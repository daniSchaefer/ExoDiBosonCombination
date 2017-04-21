#include <Riostream.h>
#include <string>
#include <vector>
#include <math.h>
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
#include "TMath.h"
#include "TPaveText.h"

void plot_Significance(bool unblind=true, char* scenario = "WZH");
const float intLumi=19.7;


void plot_Significance(bool unblind, char* scenario){


  gROOT->ProcessLine(".x tdrstyle.cc");
  gStyle->SetPadLeftMargin(0.16);
  gStyle->SetPadTopMargin(0.05);
 
  gStyle->SetNdivisions(605, "XYZ");
  gROOT->LoadMacro("CMS_lumi.C");


  //take tree with exp significance for all masses
  char fnam[50];
  sprintf(fnam, "higgsCombine%sExpSignif.ProfileLikelihood.TOTAL.root", scenario);
  TFile *fexp=new TFile(fnam,"READ");
  TTree *texp=(TTree*)fexp->Get("limit");

  //take tree with obs significance for all masses
  char fnam[50];
  sprintf(fnam, "higgsCombine%sObsSignif.ProfileLikelihood.TOTAL.root", scenario);
  TFile *fobs=new TFile(fnam,"READ");
  TTree *tobs=(TTree*)fobs->Get("limit");

  double expS,expM;
  texp->SetBranchAddress("limit",&expS);
  texp->SetBranchAddress("mh",&expM);

  double obsS,obsM;
  tobs->SetBranchAddress("limit",&obsS);
  tobs->SetBranchAddress("mh",&obsM);

  const int N=texp->GetEntries();
  if(N!=tobs->GetEntries()){
    cout<<"ERROR from plot_Significance !!! Mismatch in number of masses present in exp and obs significance trees. ExpTree: "<<N<<" entries, ObsTree: "<<tobs->GetEntries()<<" entries"<<endl;
    return;
  }

  double arrM[100],arrExp[100],arrObs[100];


  //1st loop on tree for preparing mH ordered list
  vector<double> v_mhTMP;
  for(int i=0;i<texp->GetEntries();i++){
    texp->GetEntry(i);
    v_mhTMP.push_back(expM);   
  }
  std::sort(v_mhTMP.begin(),v_mhTMP.end());
 
  int nMH=v_mhTMP.size();
  int iMH=0;

  // while(iMH<nMH){
  // cout<<"Check order: "<<iMH<<" -> "<<v_mhTMP.at(iMH)<<endl;
  //iMH++;
  // }
 iMH=0;
  while(iMH<nMH){
    double mhTMP=v_mhTMP.at(iMH);
    cout<<"Check "<<mhTMP<<endl;
    for(int i=0;i<N;i++){
      texp->GetEntry(i);
      if(expM!=mhTMP)continue;//follow exactly the order of v_mhTMP
      if(expS<1e-06)expS=1e-06;
      arrM[iMH]=expM;
      arrExp[iMH]=expS;
      //  cout<<"M="<<expM<<"   ExpSig="<<expS<<endl;
    }
    iMH++;
  }

  iMH=0;
  while(iMH<nMH){
    double mhTMP=v_mhTMP.at(iMH);
   
    for(int i=0;i<N;i++){
      tobs->GetEntry(i);
      if(obsM!=mhTMP)continue;//follow exactly the order of v_mhTMP
      arrObs[iMH]=obsS;
    }
    iMH++;
  }

  for(int i=0;i<N;i++){
    cout<<"M="<<arrM[i]<<"   ExpSig="<<arrExp[i]<<flush;
    if(unblind)cout<<"   ObsSig="<<arrObs[i] <<endl;
    else cout<<endl;
  }

  arrM[N]=arrM[N-1];
  arrExp[N]=arrExp[N-1];
  arrObs[N]=arrObs[N-1];

  TGraph *grExp=new TGraph(N+1,arrM,arrExp);
  TGraph *grObs=new TGraph(N+1,arrM,arrObs);
  grExp->SetMarkerStyle(7);
  grObs->SetMarkerStyle(20);
  grExp->SetLineStyle(kDashed);
  grObs->SetLineStyle(kSolid);
  grExp->SetTitle("");

  TLegend *l=new TLegend(0.2,0.15,0.75,0.40);
  l->SetTextSize(0.03);
  l->AddEntry(grExp,"Expected Significance","L");
  if(unblind)l->AddEntry(grObs,"Observed Significance","LP");
  l->SetFillColor(kWhite);

  TCanvas *cS=new TCanvas("canSig","Significance EXO-VH",800,800);
  cS->cd();

  double fr_left=750.0, fr_down=1e-06,fr_right=2650.0,fr_up=0.6;
  grExp->GetXaxis()->SetTitle("M_{V'} [GeV]");
  grExp->GetYaxis()->SetTitle("p-value");// #rightarrow 2l2q
  grExp->GetYaxis()->SetTitleOffset(1.6);

  grExp->Draw("AL");
  if(unblind)  grObs->Draw("LP");
  grExp->GetXaxis()->SetRangeUser(fr_left,fr_right);
  grExp->GetYaxis()->SetRangeUser(fr_down,fr_up);
  cS->SetGrid();
  gPad->SetLogy();
  l->Draw();
  // gPad->RedrawAxis("");
  const double quant1sigma=1.58655253931457074e-01;
  const double quant2sigma=2.27501319481792155e-02;
  const double quant3sigma=1.34989803163009588e-03;
  const double quant4sigma=3.16712418331199785e-05;

   TLine *l1=new TLine();
  l1->SetLineStyle(2);
  l1->SetLineWidth(3.0);
  l1->SetLineColor(kRed);
  l1->DrawLine(800.0,quant1sigma,2600.0,quant1sigma);
  TLine *l2=new TLine();
  l2->SetLineStyle(2);
  l2->SetLineWidth(3.0);
  l2->SetLineColor(kRed);
  l2->DrawLine(800.0,quant2sigma,2600.0,quant2sigma);
  TLine *l3=new TLine();
  l3->SetLineStyle(2);
  l3->SetLineWidth(3.0);
  l3->SetLineColor(kRed);
  l3->DrawLine(800.0,quant3sigma,2600.0,quant3sigma);
  TLine *l4=new TLine();
  l4->SetLineStyle(2);
  l4->SetLineWidth(3.0);
  l4->SetLineColor(kRed);
  l4->DrawLine(800.0,quant4sigma,2600.0,quant4sigma);


  TPaveText* cmslabel = new TPaveText( 0.145, 0.953, 0.6, 0.975, "brNDC");
   cmslabel->SetFillColor(kWhite);
   cmslabel->SetTextSize(0.038);
   cmslabel->SetTextAlign(11);
   cmslabel->SetTextFont(62);
   cmslabel->SetBorderSize(0);
   //   std::string leftText = "CMS Preliminary 2011";
   std::string leftText = "CMS";
   std::string units = "fb ^{-1}";
   char lumiText[300];
   sprintf( lumiText, "%.1f %s", intLumi, units.c_str());
   cmslabel->AddText(Form("%s,  #sqrt{s} = 8 TeV, %s", leftText.c_str(), lumiText));
   //cmslabel->Draw();

   TPaveText* label_sqrt = new TPaveText(0.4,0.953,0.96,0.975, "brNDC");
   label_sqrt->SetFillColor(kWhite);
   label_sqrt->SetBorderSize(0);
   label_sqrt->SetTextSize(0.038);
   label_sqrt->SetTextFont(62);   
   label_sqrt->SetTextAlign(31); // align right
   // label_sqrt->AddText("#sqrt{s} = 7 TeV");
   label_sqrt->AddText(Form("%s, L = %s at  #sqrt{s} = 8 TeV", leftText.c_str(), lumiText));
   //label_sqrt->Draw();

   CMS_lumi( cS, 2, 0 );

   char fnam[50];
   sprintf(fnam, "EXOVH_%s_Significance.root", scenario);
   cS->SaveAs(fnam);
   sprintf(fnam, "EXOVH_%s_Significance.eps", scenario);
   cS->SaveAs(fnam);
   sprintf(fnam, "EXOVH_%s_Significance.png", scenario);
   cS->SaveAs(fnam);
   sprintf(fnam, "EXOVH_%s_Significance.pdf", scenario);
   cS->SaveAs(fnam);
}
