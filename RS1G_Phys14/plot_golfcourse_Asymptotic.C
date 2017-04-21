#include <Riostream.h>
#include <string>
#include <vector>
#include <math.h>
#include <algorithm>
//#include <cstdlib>
#include "TTree.h"
#include "TH1D.h"
#include "TFile.h"
#include "TROOT.h"
#include "TGraphAsymmErrors.h"
#include "TCanvas.h"
#include "TLine.h"
#include "TLatex.h"
#include "TLegend.h"
#include "TStyle.h"
#include "TPaveText.h"
//void getSigmaBands(string fileName);

const bool isZZChannel = false;
const bool isFullCombination = true;
const float intLumi = 19.7;
const float BRZZ2l2q = isZZChannel ? 0.0941 : 0.2882464;
const string dirXSect = "./";

void plot_golfcourse_Asymptotic(bool unblind = false, char* width = 0, char* scenario = "ALL813");
void setFPStyle();
void scaleGraph(TGraphAsymmErrors* g, double factor)
{
  int npoints = g->GetN();
  for(int i=0; i!=npoints; ++i) {
    double x = g->GetX()[i];
    double y = g->GetY()[i];
    double eyh = g->GetEYhigh()[i];
    double eyl = g->GetEYlow()[i];
    y = (y*factor);
    eyh = (eyh*factor);
    eyl = (eyl*factor);
    g->SetPoint(i,x,y);
    g->SetPointEYhigh(i, eyh);
    g->SetPointEYlow(i, eyl);
  }

}

double expo_interp(double s2, double s1,  double newM, double m2, double m1)
{
  if (m1 > m2) {
    double tmps = s1;
    double tmpm = m1;
    s1 = s2;
    m1 = m2;
    s2 = tmps;
    m2 = tmpm;
  }
  double deltaM = m2 - m1;
  double alpha = (log(s2) - log(s1)) / deltaM;
  double newS = s1 * pow(exp(newM - m1), alpha);
  return newS;
}



double linear_interp(double s2, double s1, double mass, double m2, double m1)
{
  if (m1 > m2) {
    double tmps = s1;
    double tmpm = m1;
    s1 = s2;
    m1 = m2;
    s2 = tmps;
    m2 = tmpm;
  }
  return (s1 + (s2 - s1) * (mass - m1) / (m2 - m1));
}



void plot_golfcourse_Asymptotic(bool unblind, char* width, char* scenario)
{

  bool useNewStyle = true;
  if (useNewStyle)  setFPStyle();

  TFile *fFREQ = 0;
  if (width == 0)
  {
    char fnam[50];
    sprintf(fnam, "higgsCombine%s.Asymptotic.TOTAL.root", scenario);
    fFREQ = new TFile(fnam, "READ");
  } else {
    char fnam[50];
    sprintf(fnam, "higgsCombine%s.Asymptotic.%s.TOTAL.root", scenario, width);
    fFREQ = new TFile(fnam, "READ");
  }

  TTree *t = (TTree*)fFREQ->Get("limit");

  double mh, limit;
  float quant;
  t->SetBranchAddress("mh", &mh);
  t->SetBranchAddress("limit", &limit);
  t->SetBranchAddress("quantileExpected", &quant);

  /// 1st loop on tree for preparing mH ordered list
  vector<double> v_mhTMP;
  for (int i = 0; i < t->GetEntries(); i++) {
    t->GetEntry(i);
    double innerMH = mh;
    if (quant > 0.49 && quant < 0.51) {
      v_mhTMP.push_back(mh);
    }
  }
  cout << "Vector of mh filled." << v_mhTMP.size() << endl;
  std::sort(v_mhTMP.begin(), v_mhTMP.end());

  /// 2nd loop on tree to fill vectors with limits and error bands
  int nMH = v_mhTMP.size();
  int iMH = 0;
  vector<double> v_mh, v_median, v_68l, v_68h, v_95l, v_95h, v_obs;
  while (iMH < nMH) {
    double mhTMP = v_mhTMP.at(iMH);
    for (int i = 0; i < t->GetEntries(); i++) {

      t->GetEntry(i);

      if (mh != mhTMP)continue; //follow exactly the order of v_mhTMP

      /// Map: mh --> observed, 95low, 68low, expected, 68hi, 95hi, xsec
      if (quant > -1.01 && quant < -0.99) {
        v_obs.push_back(limit);
      } 
      else if (quant > 0.02 && quant < 0.03) {
	v_95l.push_back(limit);
      }
      else if (quant > 0.15 && quant < 0.17) {
	v_68l.push_back(limit);
      }
      else if (quant > 0.49 && quant < 0.51) {
	v_median.push_back(limit);
        v_mh.push_back(mh);
      }
      else if (quant > 0.83 && quant < 0.85) {
	v_68h.push_back(limit);
      }
      else if (quant > 0.965 && quant < 0.98) {
	v_95h.push_back(limit);
      }
      else {
        cout << "Error! Quantile =  " << quant << endl;
      }
    }
    iMH++;
  }//end while loop

  cout << "Vectors of limits and error bands filled." << endl;

  ///////////////////////////
  //   THEORY INPUT PART   //
  ///////////////////////////

  // The limits are given in terms of a signal strength, which is the
  // theoretical cross-section - remain from the Higgs analysis.
  // Here we read in theoretical values from text files.
  // Notice that the values to plot the RED lines in the plot
  // are directly input in this macro (see below).

  string xsect_file_th = dirXSect + "theory_RS1_WW_8TeV.txt";
  if (!isZZChannel)xsect_file_th = dirXSect + "theory_RS1_ZZ_8TeV.txt";
  if (isFullCombination)xsect_file_th = dirXSect + "theory_RS1_signal_strength.txt";
  // make_interpolated_xsect(xsect_file_th, xsect_file_interpol);
  // string xsect_file_interpol="./RSGravXSectTimesBRToZZ_AgasheHapola_c10_EXPOINTERP.txt";

  ifstream xsect_file(xsect_file_th.c_str(), ios::in);
  if (! xsect_file.is_open()) {
    cout << "Failed to open file with xsections: " << xsect_file_th << endl;
  }

  float mH, CS;
  vector<float> v_mhxs, v_xs,  v_brzz2l2q, v_toterrh, v_toterrl;
  while (xsect_file.good()) {
    xsect_file >> mH >> CS;
    if (mH < 600.0)continue;
    v_mhxs.push_back(mH);
    v_xs.push_back(CS);//*BRZZ2l2q (multyply by BRZZ2l2q only if exp rates in cards are for process X->ZZ->2l2q !)

    //unavailable theory errors for graviton

    float tot_err_p = 0.0;
    float tot_err_m = 0.0;

    v_toterrh.push_back(1.0 + (tot_err_p));
    v_toterrl.push_back(1.0 - (tot_err_m));
  }
  cout << "Size of theory xsects vector" << v_mhxs.size() << endl;
  xsect_file.close();
  /*
  string xsect_file_interpol2 = dirXSect + "xsect_BulkG_ZZ_c0p2_xsect_in_pb.txt";
  if (!isZZChannel)xsect_file_interpol2 = dirXSect + "xsect_BulkG_WW_c0p2_xsect_in_pb.txt";
  if (isFullCombination)xsect_file_interpol2 = dirXSect + "xsect_BulkGProduction_c0p5_correct.txt";
  ifstream xsect_file2(xsect_file_interpol2.c_str(), ios::in);
  if (! xsect_file2.is_open()) {
    cout << "Failed to open file with xsections: " << xsect_file_interpol2 << endl;
  }

  float mH2, CS10;
  vector<float>  v_xs10;
  while (xsect_file2.good()) {
    xsect_file2 >> mH2 >> CS10;
    if (mH2 < 600.0)continue;
    v_xs10.push_back(CS10);//*BRZZ2l2q

    //unavailable theor errors for graviton
    float tot_err_p = 0.0;
    float tot_err_m = 0.0;

    //  v_toterrh.push_back(1.0+(tot_err_p));
    //  v_toterrl.push_back(1.0-(tot_err_m));
  }
  cout << "Size of theory xsects vector" << v_xs10.size() << endl;
  xsect_file2.close();
  */
  ///////////////////////////
  // END THEORY INPUT PART //
  ///////////////////////////

  if(!unblind)
    v_obs=v_median;

  /// Here we multiply the limits in terms of signal strength by the cross-section.
  /// There are also some hooks to exclude sick mass points.
  const int nMass = v_mh.size();
  double mass[nMass], mass1[nMass], obs_lim_cls[nMass];
  double medianD[nMass];
  double up68err[nMass], down68err[nMass], up95err[nMass], down95err[nMass];
  double xs[nMass], xs_uperr[nMass], xs_downerr[nMass];
  double xs10[nMass], xs10_uperr[nMass], xs10_downerr[nMass];
  int nMassEff = 0, nMassEff1 = 0;
  int nM95 = 0;
  double mass95[nMass], median95[nMass];
  int nexcluded = 0;
  bool excl;
  for (int im = 0; im < nMass; im++) {
    // maybe we want to print the higher mass limits?
    //if (mass[nMassEff - 1] > 1600.) cout << "Array " << im << flush << "  m = " << v_mh.at(im) << endl;;

    // some protection against messed up jobs

    if (im>=v_median.size() || im>=v_68h.size() || im>=v_95h.size() || im>=v_68l.size() || im>=v_95l.size()) {
      cout << "Point " << im << " at M = " << v_mh.at(im) << " excluded: " << v_median.size() << endl;
      nexcluded++;
      continue;
    }

    excl = false;
    if (v_68h.at(im) >= v_95h.at(im) || v_68l.at(im) <= v_95l.at(im)) {
      // sick limits where the 68% band is out of the 95% band.
      cout << "Point at M = " << v_mh.at(im) << " excluded: " << v_95l.at(im) << "  " << v_68l.at(im) << "  " << v_median.at(im) << "  " << v_68h.at(im) << "  " << v_95h.at(im) << endl;
      nexcluded++;
      // continue;
      excl = true;
    }

    //if(im%2==1)excl=true; //sample only one half of the points

    // search for right index in theory vectors
    bool found = false;
    int indtmp = 0, ind = -1, swapind = -1;
    while (!found) {
      if (v_mhxs.at(indtmp) == v_mh.at(im)) {
        found = true;
        ind = indtmp;
      }
      if (swapind == -1 && v_mh.at(im) < v_mhxs.at(indtmp)) {
        swapind = indtmp;
      }
      indtmp++;
      if (indtmp == v_mhxs.size()) {
        cout << "!!! m=" << flush << v_mh.at(im) << " NOT found in theory matrix." << endl;
        break;
      }
    }//end while

    if (!found && swapind != -1) {
      ind = swapind;
    }

    double fl_xs = double(v_xs.at(ind)); //*1000.0
    double fl_xs10 = 0;//double(v_xs10.at(ind)); //*1000.0
    fl_xs = (fl_xs);
    fl_xs10 = (fl_xs10);

    if (!found) {
      cout << "(2) m=" << v_mh.at(im) << " NOT found in theory matrix." << endl;
      fl_xs  = expo_interp(v_xs.at(ind), v_xs.at(ind - 1), v_mh.at(im), v_mhxs.at(ind), v_mhxs.at(ind - 1));
      fl_xs10  = expo_interp(v_xs10.at(ind), v_xs10.at(ind - 1), v_mh.at(im), v_mhxs.at(ind), v_mhxs.at(ind - 1));
      //continue;
    }

    if (fl_xs < fl_xs10)cout << "WARNING ABOUT XSECT! XS=" << fl_xs << "  XS10=" << fl_xs10 << endl;

    mass[nMassEff] = v_mh.at(im);

    /// This is the part where we multiply the limits in terms of signal strength
    /// by the cross-section, in order to have limits in picobarns.
    //std::cerr << mass[nMassEff] << ":" << v_obs.at(im) << std::endl;
    obs_lim_cls[nMassEff] = v_obs.at(im) * fl_xs;
    nMassEff++;
    if (!excl) {
      mass1[nMassEff1] = v_mh.at(im);
      medianD[nMassEff1] = v_median.at(im) * fl_xs;
      up68err[nMassEff1] = (v_68h.at(im) - v_median.at(im)) * fl_xs;
      down68err[nMassEff1] = (v_median.at(im) - v_68l.at(im)) * fl_xs;
      cout << "M=" << mass1[nMassEff1] << "  Median=" << medianD[nMassEff1] << endl;

      //scale factor 100 for making the xsect visible
      xs[nMassEff1] = fl_xs; //*100.0;
      xs_uperr[nMassEff1] = double(v_toterrh.at(ind)) * xs[nMassEff1] - xs[nMassEff1];
      xs_downerr[nMassEff1] =  xs[nMassEff1] - double(v_toterrl.at(ind)) * xs[nMassEff1];

      xs10[nMassEff1] = fl_xs10; //*100.0;
      xs10_uperr[nMassEff1] = double(v_toterrh.at(ind)) * xs10[nMassEff1] - xs10[nMassEff1];
      xs10_downerr[nMassEff1] =  xs10[nMassEff1] - double(v_toterrl.at(ind)) * xs10[nMassEff1];

      nMassEff1++;


      bool skip95 = false; //
      if (skip95)continue;
      mass95[nM95] = v_mh.at(im);
      median95[nM95] = v_median.at(im) * fl_xs;
      up95err[nM95] = (v_95h.at(im) - v_median.at(im)) * fl_xs;
      down95err[nM95] = (v_median.at(im) - v_95l.at(im)) * fl_xs;

      //  cout<<"M95: "<< mass95[nM95]<<" "<<median95[nM95]<<" +"<<up95err[nM95]<<"   -"<< down95err[nM95]<<
      // " ("<<v_95h.at(im) <<" - "<<v_median.at(im) <<")"<<endl;
      nM95++;
    }//end if not excluded mass point
  }//end loop over im (mass points)
  cout << "Excluded " << nexcluded << " sick mass points." << endl;


  /// The TGraphs themselves.

  //cout<<"Working on TGraph"<<endl;
  TGraphAsymmErrors *grobslim_cls = new TGraphAsymmErrors(nMassEff, mass, obs_lim_cls);
  grobslim_cls->SetName("LimitObservedCLs");
  TGraphAsymmErrors *grmedian_cls = new TGraphAsymmErrors(nMassEff1, mass1, medianD);
  grmedian_cls->SetName("LimitExpectedCLs");
  TGraphAsymmErrors *gr68_cls = new TGraphAsymmErrors(nMassEff1, mass1, medianD, 0, 0, down68err, up68err);
  gr68_cls->SetName("Limit68CLs");
  TGraphAsymmErrors *gr95_cls = new TGraphAsymmErrors(nM95, mass95, median95, 0, 0, down95err, up95err);
  gr95_cls->SetName("Limit95CLs");

  // TGraphAsymmErrors *grthSM=new TGraphAsymmErrors(nMassEff1,mass1,xs,0,0,0,0);//xs_downerr,xs_uperr);
  TGraph *grthSM=new TGraph(nMassEff1,mass1,xs);//xs_downerr,xs_uperr);

  /// For the time being we have to do it like this, given that
  /// the cards and the limits were made with the old, wrong xsects.
  // TGraph *grthSM10 = new TGraph(35);
//   grthSM10->SetPoint(0, 600, 7.1185E-03);
//   grthSM10->SetPoint(1, 650, 4.1893E-03);
//   grthSM10->SetPoint(2, 700, 2.5592E-03);
//   grthSM10->SetPoint(3, 750, 1.6182E-03);
//   grthSM10->SetPoint(4, 800, 1.0564E-03);
//   grthSM10->SetPoint(5, 850, 7.0295E-04);
//   grthSM10->SetPoint(6, 900, 4.7877E-04);
//   grthSM10->SetPoint(7, 950, 3.3017E-04);
//   grthSM10->SetPoint(8, 1000, 2.3212E-04);
//   grthSM10->SetPoint(9, 1050, 1.6574E-04);
//   grthSM10->SetPoint(10, 1100, 1.1917E-04);
//   grthSM10->SetPoint(11, 1150, 8.6629E-05);
//   grthSM10->SetPoint(12, 1200, 6.3987E-05);
//   grthSM10->SetPoint(13, 1250, 4.7353E-05);
//   grthSM10->SetPoint(14, 1300, 3.5511E-05);
//   grthSM10->SetPoint(15, 1350, 2.6631E-05);
//   grthSM10->SetPoint(16, 1400, 2.0199E-05);
//   grthSM10->SetPoint(17, 1450, 1.5333E-05);
//   grthSM10->SetPoint(18, 1500, 1.1758E-05);
//   grthSM10->SetPoint(19, 1550, 9.0363E-06);
//   grthSM10->SetPoint(20, 1600, 6.9870E-06);
//   grthSM10->SetPoint(21, 1650, 5.4316E-06);
//   grthSM10->SetPoint(22, 1700, 4.2252E-06);
//   grthSM10->SetPoint(23, 1750, 3.3172E-06);
//   grthSM10->SetPoint(24, 1800, 2.6083E-06);
//   grthSM10->SetPoint(25, 1850, 2.0499E-06);
//   grthSM10->SetPoint(26, 1900, 1.6186E-06);
//   grthSM10->SetPoint(27, 1950, 1.2799E-06);
//   grthSM10->SetPoint(28, 2000, 1.0205E-06);
//   grthSM10->SetPoint(29, 2050, 8.0867E-07);
//   grthSM10->SetPoint(30, 2100, 6.4555E-07);
//   grthSM10->SetPoint(31, 2150, 5.1755E-07);
//   grthSM10->SetPoint(32, 2200, 4.1408E-07);
//   grthSM10->SetPoint(33, 2250, 3.3170E-07);
//   grthSM10->SetPoint(34, 2300, 2.6637E-07);
//   grthSM10->SetPoint(35, 2350, 2.1366E-07);
//   grthSM10->SetPoint(36, 2400, 1.7285E-07);
//   grthSM10->SetPoint(37, 2450, 1.3896E-07);
//   grthSM10->SetPoint(38, 2500, 1.1238E-07);

//   if (!isZZChannel) {
//     grthSM10->SetPoint(0, 800, 2.0523E-03);
//     grthSM10->SetPoint(1, 850, 1.3726E-03);
//     grthSM10->SetPoint(2, 900, 9.3786E-04);
//     grthSM10->SetPoint(3, 950, 6.4928E-04);
//     grthSM10->SetPoint(4, 1000, 4.5618E-04);
//     grthSM10->SetPoint(5, 1050, 3.2571E-04);
//     grthSM10->SetPoint(6, 1100, 2.3543E-04);
//     grthSM10->SetPoint(7, 1150, 1.7157E-04);
//     grthSM10->SetPoint(8, 1200, 1.2611E-04);
//     grthSM10->SetPoint(9, 1250, 9.3461E-05);
//     grthSM10->SetPoint(10, 1300, 6.9899E-05);
//     grthSM10->SetPoint(11, 1350, 5.2749E-05);
//     grthSM10->SetPoint(12, 1400, 4.0048E-05);
//     grthSM10->SetPoint(13, 1450, 3.0363E-05);
//     grthSM10->SetPoint(14, 1500, 2.3324E-05);
//     grthSM10->SetPoint(15, 1550, 1.8008E-05);
//     grthSM10->SetPoint(16, 1600, 1.3876E-05);
//     grthSM10->SetPoint(17, 1650, 1.0812E-05);
//     grthSM10->SetPoint(18, 1700, 8.4385E-06);
//     grthSM10->SetPoint(19, 1750, 6.5972E-06);
//     grthSM10->SetPoint(20, 1800, 5.1608E-06);
//     grthSM10->SetPoint(21, 1850, 4.0824E-06);
//     grthSM10->SetPoint(22, 1900, 3.2292E-06);
//     grthSM10->SetPoint(23, 1950, 2.5502E-06);
//     grthSM10->SetPoint(24, 2000, 2.0281E-06);
//     grthSM10->SetPoint(25, 2050, 1.6179E-06);
//     grthSM10->SetPoint(26, 2100, 1.2893E-06);
//     grthSM10->SetPoint(27, 2150, 1.0313E-06);
//     grthSM10->SetPoint(28, 2200, 8.2293E-07);
//     grthSM10->SetPoint(29, 2250, 6.6187E-07);
//     grthSM10->SetPoint(30, 2300, 5.3108E-07);
//     grthSM10->SetPoint(31, 2350, 4.2755E-07);
//     grthSM10->SetPoint(32, 2400, 3.4315E-07);
//     grthSM10->SetPoint(33, 2450, 2.7803E-07);
//     grthSM10->SetPoint(34, 2500, 2.2432E-07);
//   }
  grthSM->SetName("SMXSection");


  // TGraphAsymmErrors *grthSM10=new TGraphAsymmErrors(nMassEff1,mass1,xs10,0,0,0,0);
  TGraph *grthSM10=new TGraph(nMassEff1,mass1,xs10);
  // TGraph *grthSM = new TGraph(35);
//   grthSM->SetPoint(0, 600, 4.4387E-02);
//   grthSM->SetPoint(1, 650, 2.6088E-02);
//   grthSM->SetPoint(2, 700, 1.5907E-02);
//   grthSM->SetPoint(3, 750, 1.0045E-02);
//   grthSM->SetPoint(4, 800, 6.5582E-03);
//   grthSM->SetPoint(5, 850, 4.3560E-03);
//   grthSM->SetPoint(6, 900, 2.9701E-03);
//   grthSM->SetPoint(7, 950, 2.0553E-03);
//   grthSM->SetPoint(8, 1000, 1.4410E-03);
//   grthSM->SetPoint(9, 1050, 1.0283E-03);
//   grthSM->SetPoint(10, 1100, 7.3979E-04);
//   grthSM->SetPoint(11, 1150, 5.4086E-04);
//   grthSM->SetPoint(12, 1200, 3.9717E-04);
//   grthSM->SetPoint(13, 1250, 2.9347E-04);
//   grthSM->SetPoint(14, 1300, 2.1957E-04);
//   grthSM->SetPoint(15, 1350, 1.6507E-04);
//   grthSM->SetPoint(16, 1400, 1.2514E-04);
//   grthSM->SetPoint(17, 1450, 9.5937E-05);
//   grthSM->SetPoint(18, 1500, 7.3300E-05);
//   grthSM->SetPoint(19, 1550, 5.6376E-05);
//   grthSM->SetPoint(20, 1600, 4.3715E-05);
//   grthSM->SetPoint(21, 1650, 3.3834E-05);
//   grthSM->SetPoint(22, 1700, 2.6389E-05);
//   grthSM->SetPoint(23, 1750, 2.0691E-05);
//   grthSM->SetPoint(24, 1800, 1.6259E-05);
//   grthSM->SetPoint(25, 1850, 1.2809E-05);
//   grthSM->SetPoint(26, 1900, 1.0131E-05);
//   grthSM->SetPoint(27, 1950, 8.0235E-06);
//   grthSM->SetPoint(28, 2000, 6.3711E-06);
//   grthSM->SetPoint(29, 2050, 5.0725E-06);
//   grthSM->SetPoint(30, 2100, 4.0513E-06);
//   grthSM->SetPoint(31, 2150, 3.2469E-06);
//   grthSM->SetPoint(32, 2200, 2.6006E-06);
//   grthSM->SetPoint(33, 2250, 2.0899E-06);
//   grthSM->SetPoint(34, 2300, 1.6810E-06);
//   grthSM->SetPoint(35, 2350, 1.3586E-06);
//   grthSM->SetPoint(36, 2400, 1.0964E-06);
//   grthSM->SetPoint(37, 2450, 8.8416E-07);
//   grthSM->SetPoint(38, 2500, 7.1662E-07);
//   if (!isZZChannel) {
//     grthSM->SetPoint(0, 800, 1.2713E-02);
//     grthSM->SetPoint(1, 850, 8.5015E-03);
//     grthSM->SetPoint(2, 900, 5.8030E-03);
//     grthSM->SetPoint(3, 950, 4.0261E-03);
//     grthSM->SetPoint(4, 1000, 2.8289E-03);
//     grthSM->SetPoint(5, 1050, 2.0214E-03);
//     grthSM->SetPoint(6, 1100, 1.4580E-03);
//     grthSM->SetPoint(7, 1150, 1.0625E-03);
//     grthSM->SetPoint(8, 1200, 7.8079E-04);
//     grthSM->SetPoint(9, 1250, 5.7987E-04);
//     grthSM->SetPoint(10, 1300, 4.3448E-04);
//     grthSM->SetPoint(11, 1350, 3.2719E-04);
//     grthSM->SetPoint(12, 1400, 2.4778E-04);
//     grthSM->SetPoint(13, 1450, 1.8896E-04);
//     grthSM->SetPoint(14, 1500, 1.4543E-04);
//     grthSM->SetPoint(15, 1550, 1.1200E-04);
//     grthSM->SetPoint(16, 1600, 8.6492E-05);
//     grthSM->SetPoint(17, 1650, 6.7405E-05);
//     grthSM->SetPoint(18, 1700, 5.2283E-05);
//     grthSM->SetPoint(19, 1750, 4.1121E-05);
//     grthSM->SetPoint(20, 1800, 3.2378E-05);
//     grthSM->SetPoint(21, 1850, 2.5507E-05);
//     grthSM->SetPoint(22, 1900, 2.0215E-05);
//     grthSM->SetPoint(23, 1950, 1.6020E-05);
//     grthSM->SetPoint(24, 2000, 1.2714E-05);
//     grthSM->SetPoint(25, 2050, 1.0133E-05);
//     grthSM->SetPoint(26, 2100, 8.0785E-06);
//     grthSM->SetPoint(27, 2150, 6.4583E-06);
//     grthSM->SetPoint(28, 2200, 5.1774E-06);
//     grthSM->SetPoint(29, 2250, 4.1620E-06);
//     grthSM->SetPoint(30, 2300, 3.3440E-06);
//     grthSM->SetPoint(31, 2350, 2.7018E-06);
//     grthSM->SetPoint(32, 2400, 2.1753E-06);
//     grthSM->SetPoint(33, 2450, 1.7626E-06);
//     grthSM->SetPoint(34, 2500, 1.4225E-06);
//   }
  grthSM10->SetName("SMXSection_2nd");

  // cout<<"Plotting"<<endl;
  double fr_left = 590.0, fr_down = 5E-4, fr_right = 2520.0, fr_up = 0.5;
  if (!isZZChannel) {
    fr_left = 750.0, fr_down = 5E-4, fr_right = 3950.0, fr_up = 1.0;
  }
  if (isFullCombination) {
    fr_left = 550.0, fr_down = 1e-2, fr_right = 4050.0, fr_up = 1e3;
  }

  TCanvas *cMCMC = new TCanvas("c_lim_Asymptotic", "canvas with limits for Asymptotic CLs", 630, 600);
  cMCMC->cd();
  cMCMC->SetGridx(1);
  cMCMC->SetGridy(1);
  // draw a frame to define the range

  TH1F *hr = cMCMC->DrawFrame(fr_left, fr_down, fr_right, fr_up, "");
  TString VV = "ZZ";
  if (!isZZChannel)VV = "WW";
  hr->SetXTitle("M_{G*} [GeV]");
  hr->SetYTitle("#sigma_{95%} #times BR(G* #rightarrow " + VV + ") [pb]"); // #rightarrow 2l2q
  if(isFullCombination)
    hr->SetYTitle("#sigma_{95%} / #sigma_{theory}"); // #rightarrow 2l2q
  

  gr95_cls->SetFillColor(kYellow);
  gr95_cls->SetFillStyle(1001);//solid
  gr95_cls->SetLineStyle(kDashed);
  gr95_cls->SetLineWidth(3);
  gr95_cls->GetXaxis()->SetTitle("M_{G*} [GeV]");
  gr95_cls->GetYaxis()->SetTitle("#sigma_{95%} #times BR(G* #rightarrow " + VV + ") [pb]"); // #rightarrow 2l2q
  gr95_cls->GetXaxis()->SetRangeUser(fr_left, fr_right);

  gr95_cls->Draw("3");

  gr68_cls->SetFillColor(kGreen);
  gr68_cls->SetFillStyle(1001);//solid
  gr68_cls->SetLineStyle(kDashed);
  gr68_cls->SetLineWidth(3);
  gr68_cls->Draw("3same");
  grmedian_cls->GetXaxis()->SetTitle("M_{G*} [GeV]");
  grmedian_cls->GetYaxis()->SetTitle("#sigma_{95%} #times BR(G* #rightarrow " + VV + ") [pb]"); // #rightarrow 2l2q
  grmedian_cls->SetMarkerStyle(24);//25=hollow squre
  grmedian_cls->SetMarkerColor(kBlack);
  grmedian_cls->SetLineStyle(2);
  grmedian_cls->SetLineWidth(3);
  grmedian_cls->SetMinimum(0.0);
  grmedian_cls->SetMaximum(8.0);

  grobslim_cls->SetMarkerColor(kBlack);
  grobslim_cls->SetMarkerStyle(21);//24=hollow circle
  grobslim_cls->SetMarkerSize(1.0);
  grobslim_cls->SetLineStyle(1);
  grobslim_cls->SetLineWidth(3);

  grthSM->SetLineColor(kRed);
  grthSM->SetLineWidth(2);
  grthSM->SetLineStyle(kSolid);
  grthSM->SetFillColor(kRed);
  grthSM->SetFillStyle(3344);

  grthSM10->SetLineColor(kRed);
  grthSM10->SetLineWidth(2);
  grthSM10->SetLineStyle(1);
  grthSM10->SetLineStyle(kDashed);
  grthSM10->SetFillColor(kRed);
  grthSM10->SetFillStyle(3344);

  TLine *l1 = new TLine();
  l1->SetLineStyle(1);
  l1->SetLineWidth(2.0);
  l1->SetLineColor(kBlue);
  l1->SetLineStyle(7);
  l1->DrawLine(990.0,fr_down,990.0,fr_up);
  //cMCMC->RedrawAxis("");
  //gPad->RedrawAxis("");
  cMCMC->Update();

  TLine *l1b = new TLine();
  l1b->SetLineStyle(1);
  l1b->SetLineWidth(2.0);
  l1b->SetLineColor(kBlue);
  l1b->SetLineStyle(7);
  l1b->DrawLine(790.0,fr_down,790.0,fr_up);
  cMCMC->Update();

  TLine *l1c = new TLine();
  l1c->SetLineStyle(1);
  l1c->SetLineWidth(2.0);
  l1c->SetLineColor(kBlue);
  l1c->SetLineStyle(7);
  l1c->DrawLine(2490.0,fr_down,2490.0,fr_up);
  cMCMC->Update();

  TLine *l1d = new TLine();
  l1d->SetLineStyle(1);
  l1d->SetLineWidth(2.0);
  l1d->SetLineColor(kBlue);
  l1d->SetLineStyle(7);
  l1d->DrawLine(1190.0,fr_down,1190.0,fr_up);
  cMCMC->Update();

  TLine *l1e = new TLine();
  l1e->SetLineStyle(1);
  l1e->SetLineWidth(2.0);
  l1e->SetLineColor(kBlue);
  l1e->SetLineStyle(7);
  l1e->DrawLine(2890.0,fr_down,2890.0,fr_up);
  cMCMC->Update();

  grthSM->Draw("L3");
  if(!isFullCombination) {
    grthSM10->Draw("L3");
  }
  grmedian_cls->Draw("L");
  if (unblind)grobslim_cls->Draw("LP");

  /*
  TFile *fUnMPlus=new TFile("AsymptoticCLs_UnmatchedPlus_TGraph.root","READ");
  TGraph *grobs_ump=(TGraph*)fUnMPlus->Get("LimitObservedCLs");
  TGraph *grmedian_ump=(TGraph*)fUnMPlus->Get("LimitExpectedCLs");
  grobs_ump->SetName("LimitObs_UnmatchedPlus");
  grmedian_ump->SetName("LimitExp_UnmatchedPlus");
  grobs_ump->SetMarkerColor(kBlue);
  grobs_ump->SetLineColor(kBlue);
  grobs_ump->SetMarkerStyle(25);
  grmedian_ump->SetMarkerColor(kBlue);
  grmedian_ump->SetLineColor(kBlue);
  grmedian_ump->SetMarkerStyle(25);
  grobs_ump->Draw("P");
  grmedian_ump->Draw("L");
  */

  //draw grid on top of limits
  gStyle->SetOptStat(0);
  TH1D* postGrid = new TH1D("postGrid", "", 1, fr_left, fr_right);
  postGrid->GetYaxis()->SetRangeUser(fr_down, fr_up);
  postGrid->Draw("AXIGSAME");

  //more graphics

  TLegend *leg = new TLegend(.18, .65, .60, .90);
  //   TLegend *leg = new TLegend(.35,.71,.90,.90);
  leg->SetFillColor(0);
  leg->SetShadowColor(0);
  leg->SetTextFont(42);
  leg->SetTextSize(0.025);
  //   leg->SetBorderMode(0);
  if (unblind)leg->AddEntry(grobslim_cls, "Frequentist CL_{S} Observed", "LP");
  leg->AddEntry(gr68_cls, "Frequentist CL_{S}  Expected #pm 1#sigma", "LF");
  leg->AddEntry(gr95_cls, "Frequentist CL_{S}  Expected #pm 2#sigma", "LF");
  if(!isFullCombination) {
    leg->AddEntry(grthSM, "#sigma_{TH} x BR(G* #rightarrow " + VV + "), #tilde{k}=0.50", "L"); // #rightarrow 2l2q
    leg->AddEntry(grthSM10, "#sigma_{TH} x BR(G* #rightarrow " + VV + "), #tilde{k}=0.20", "L"); // #rightarrow 2l2q
  }
  if(isFullCombination) {
    leg->AddEntry(grthSM, "#sigma_{TH} (pp #rightarrow G*), #tilde{k}=0.10", "L");
  }
  leg->Draw();

  if (useNewStyle) {
    if(isFullCombination || isZZChannel) {
      TPaveText* pave1 = new TPaveText(0.17, 0.18, 0.17, 0.22, "brNDC");
      pave1->SetFillColor(kWhite);
      pave1->SetTextSize(0.0375);
      pave1->SetTextAlign(11);
      pave1->SetTextFont(22);
      pave1->SetTextColor(kBlue);
      pave1->SetBorderSize(0);
      pave1->AddText("I");
      pave1->Draw();
      
      TPaveText* pave2 = new TPaveText(0.20, 0.18, 0.20, 0.22, "brNDC");
      pave2->SetFillColor(kWhite);
      pave2->SetTextSize(0.0375);
      pave2->SetTextAlign(11);
      pave2->SetTextFont(22);
      pave2->SetTextColor(kBlue);
      pave2->SetBorderSize(0);
      pave2->AddText("II");
      pave2->Draw();
      
      TPaveText* pave3 = new TPaveText(0.245, 0.18, 0.245, 0.22, "brNDC");
      pave3->SetFillColor(kWhite);
      pave3->SetTextSize(0.0375);
      pave3->SetTextAlign(11);
      pave3->SetTextFont(22);
      pave3->SetTextColor(kBlue);
      pave3->SetBorderSize(0);
      pave3->AddText("III");
      pave3->Draw();
      
      TPaveText* pave4 = new TPaveText(0.375, 0.18, 0.425, 0.22, "brNDC");
      pave4->SetFillColor(kWhite);
      pave4->SetTextSize(0.0375);
      pave4->SetTextAlign(11);
      pave4->SetTextFont(22);
      pave4->SetTextColor(kBlue);
      pave4->SetBorderSize(0);
      pave4->AddText("IV");
      pave4->Draw();
      
      TPaveText* pave5 = new TPaveText(0.65, 0.18, 0.65, 0.22, "brNDC");
      pave5->SetFillColor(kWhite);
      pave5->SetTextSize(0.0375);
      pave5->SetTextAlign(11);
      pave5->SetTextFont(22);
      pave5->SetTextColor(kBlue);
      pave5->SetBorderSize(0);
      pave5->AddText("V");
      pave5->Draw();

      TPaveText* pave6 = new TPaveText(0.80, 0.18, 0.80, 0.22, "brNDC");
      pave6->SetFillColor(kWhite);
      pave6->SetTextSize(0.0375);
      pave6->SetTextAlign(11);
      pave6->SetTextFont(22);
      pave6->SetTextColor(kBlue);
      pave6->SetBorderSize(0);
      pave6->AddText("VI");
      pave6->Draw();
    } 
    
    TPaveText* cmslabel = new TPaveText(0.145, 0.953, 0.6, 0.975, "brNDC");
    cmslabel->SetFillColor(kWhite);
    cmslabel->SetTextSize(0.038);
    cmslabel->SetTextAlign(11);
    cmslabel->SetTextFont(62);
    cmslabel->SetBorderSize(0);
    std::string leftText = "CMS";
    std::string units = "fb ^{-1}";
    char lumiText[300];
    sprintf(lumiText, "%.1f %s", intLumi, units.c_str());
    cmslabel->AddText(Form("%s", leftText.c_str(), lumiText));
    cmslabel->Draw();

    TPaveText* label_sqrt = new TPaveText(0.5, 0.953, 0.96, 0.975, "brNDC");
    label_sqrt->SetFillColor(kWhite);
    label_sqrt->SetBorderSize(0);
    label_sqrt->SetTextSize(0.038);
    label_sqrt->SetTextFont(62);
    label_sqrt->SetTextAlign(31); // align right
    label_sqrt->AddText(Form("L = %s at  #sqrt{s} = 8 TeV", lumiText));
    //label_sqrt->Draw();

    TPaveText* aNum = new TPaveText(0.13, 0.08, 0.203, 0.135, "brNDC");
    aNum->SetFillColor(kWhite);
    aNum->SetTextSize(0.045);
    aNum->SetTextAlign(11);
    aNum->SetTextFont(42);
    aNum->SetBorderSize(0);
    if(isFullCombination || isZZChannel)
      aNum->AddText("600");
    if(!isFullCombination && !isZZChannel)
      aNum->AddText("800");
    aNum->Draw();
  }  
  else {
    TLatex * latex = new TLatex();
    latex->SetNDC();
    latex->SetTextSize(0.04);
    latex->SetTextAlign(31);
    latex->SetTextAlign(11); // align left
    latex->DrawLatex(0.18, 0.96, "CMS preliminary 2012");
    latex->DrawLatex(0.60, 0.96, Form("%.1f fb^{-1} at #sqrt{s} = 8 TeV", intLumi));
  }

  // cMCMC->RedrawAxis("");
  gPad->RedrawAxis("");
  // hr->GetYaxis()->DrawClone();
  cMCMC->Update();
  char fnam[50];
  if (width != 0) {
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic_%s.root", scenario, width);
    cMCMC->SaveAs(fnam);
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic_%s.eps", scenario, width);
    cMCMC->SaveAs(fnam);
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic_%s.png", scenario, width);
    cMCMC->SaveAs(fnam);
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic_%s.pdf", scenario, width);
    cMCMC->SaveAs(fnam);
    gPad->SetLogy();
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic_%s_log.eps", scenario, width);
    cMCMC->SaveAs(fnam);
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic_%s_log.png", scenario, width);
    cMCMC->SaveAs(fnam);
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic_%s_log.pdf", scenario, width);
    cMCMC->SaveAs(fnam);
  } else {
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic.root", scenario);
    cMCMC->SaveAs(fnam);
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic.eps", scenario);
    cMCMC->SaveAs(fnam);
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic.png", scenario);
    cMCMC->SaveAs(fnam);
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic.pdf", scenario);
    cMCMC->SaveAs(fnam);
    gPad->SetLogy();
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic_log.eps", scenario);
    cMCMC->SaveAs(fnam);
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic_log.png", scenario);
    cMCMC->SaveAs(fnam);
    sprintf(fnam, "EXOVV_%s_UL_Asymptotic_log.pdf", scenario);
    cMCMC->SaveAs(fnam);
  }

  cMCMC->Draw();

  if (width == 0)
    sprintf(fnam, "AsymptoticCLs_TGraph.root");
  else
    sprintf(fnam, "AsymptoticCLs_TGraph_%s.root", width);

  TFile *outfile = new TFile(fnam, "RECREATE");
  outfile->cd();
  if (unblind)grobslim_cls->Write();
  grmedian_cls->Write();
  outfile->Close();


}//end main

void setFPStyle()
{
  gStyle->SetPadBorderMode(0);
  gStyle->SetFrameBorderMode(0);
  gStyle->SetPadBottomMargin(0.12);
  gStyle->SetPadLeftMargin(0.12);
  gStyle->SetCanvasColor(kWhite);
  gStyle->SetCanvasDefH(600); //Height of canvas
  gStyle->SetCanvasDefW(600); //Width of canvas
  gStyle->SetCanvasDefX(0);   //Position on screen
  gStyle->SetCanvasDefY(0);

  gStyle->SetPadTopMargin(0.05);
  gStyle->SetPadBottomMargin(0.15);//0.13);
  gStyle->SetPadLeftMargin(0.15);//0.16);
  gStyle->SetPadRightMargin(0.05);//0.02);

  // For the Pad:
  gStyle->SetPadBorderMode(0);
  // gStyle->SetPadBorderSize(Width_t size = 1);
  gStyle->SetPadColor(kWhite);
  gStyle->SetPadGridX(false);
  gStyle->SetPadGridY(false);
  gStyle->SetGridColor(0);
  gStyle->SetGridStyle(3);
  gStyle->SetGridWidth(1);

  // For the Frame:
  gStyle->SetFrameBorderMode(0);
  gStyle->SetFrameBorderSize(1);
  gStyle->SetFrameFillColor(0);
  gStyle->SetFrameFillStyle(0);
  gStyle->SetFrameLineColor(1);
  gStyle->SetFrameLineStyle(1);
  gStyle->SetFrameLineWidth(1);

  gStyle->SetAxisColor(1, "XYZ");
  gStyle->SetStripDecimals(kTRUE);
  gStyle->SetTickLength(0.03, "XYZ");
  gStyle->SetNdivisions(605, "XYZ");
  gStyle->SetPadTickX(1);  // To get tick marks on the opposite side of the frame
  gStyle->SetPadTickY(1);
  gStyle->SetGridColor(0);
  gStyle->SetGridStyle(3);
  gStyle->SetGridWidth(1);


  gStyle->SetTitleColor(1, "XYZ");
  gStyle->SetTitleFont(42, "XYZ");
  gStyle->SetTitleSize(0.05, "XYZ");
  // gStyle->SetTitleXSize(Float_t size = 0.02); // Another way to set the size?
  // gStyle->SetTitleYSize(Float_t size = 0.02);
  gStyle->SetTitleXOffset(1.15);//0.9);
  gStyle->SetTitleYOffset(1.3); // => 1.15 if exponents
  gStyle->SetLabelColor(1, "XYZ");
  gStyle->SetLabelFont(42, "XYZ");
  gStyle->SetLabelOffset(0.007, "XYZ");
  gStyle->SetLabelSize(0.045, "XYZ");

  gStyle->SetPadBorderMode(0);
  gStyle->SetFrameBorderMode(0);
  gStyle->SetTitleTextColor(1);
  gStyle->SetTitleFillColor(10);
  gStyle->SetTitleFontSize(0.05);
}


