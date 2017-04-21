{
//=========Macro generated from canvas: c_Significance/c_Significance
//=========  (Fri Oct 21 12:45:56 2016) by ROOT version5.34/18
   TCanvas *c_Significance = new TCanvas("c_Significance", "c_Significance",0,0,600,630);
   gStyle->SetOptFit(1);
   gStyle->SetOptStat(0);
   gStyle->SetOptTitle(0);
   c_Significance->SetHighLightColor(2);
   c_Significance->Range(0.21375,-2.089384,4.33875,2.631491);
   c_Significance->SetFillColor(0);
   c_Significance->SetBorderMode(0);
   c_Significance->SetBorderSize(2);
   c_Significance->SetLogy();
   c_Significance->SetTickx(1);
   c_Significance->SetTicky(1);
   c_Significance->SetLeftMargin(0.13);
   c_Significance->SetRightMargin(0.07);
   c_Significance->SetTopMargin(0.07);
   c_Significance->SetBottomMargin(0.12);
   c_Significance->SetFrameFillStyle(0);
   c_Significance->SetFrameBorderMode(0);
   c_Significance->SetFrameFillStyle(0);
   c_Significance->SetFrameBorderMode(0);
   
   /*TCanvas *c_Significance = new TCanvas("c_Significance", "c_Significance",0,0,600,630);
   gStyle->SetOptFit(1);
   gStyle->SetOptStat(0);
   gStyle->SetOptTitle(0);
   c_Significance->SetHighLightColor(2);
   c_Significance->Range(-0.01874997,-5.888889,4.35625,1.518519);
   c_Significance->SetFillColor(0);
   c_Significance->SetBorderMode(0);
   c_Significance->SetBorderSize(2);
   c_Significance->SetLogy();
   c_Significance->SetTickx(1);
   c_Significance->SetTicky(1);
   c_Significance->SetLeftMargin(0.13);
   c_Significance->SetRightMargin(0.07);
   c_Significance->SetTopMargin(0.07);
   c_Significance->SetBottomMargin(0.12);
   c_Significance->SetFrameFillStyle(0);
   c_Significance->SetFrameBorderMode(0);
   c_Significance->SetFrameFillStyle(0);
   c_Significance->SetFrameBorderMode(0);*/

   TH1F *hframe__1 = new TH1F("hframe__1","",1000,1.75,2.05);
   hframe__1->SetMinimum(1e-05);
   hframe__1->SetMaximum(1);
   hframe__1->SetDirectory(0);
   hframe__1->SetStats(0);
   hframe__1->SetLineStyle(0);
   hframe__1->SetMarkerStyle(20);
   hframe__1->GetXaxis()->SetTitle("M_{W'} (TeV)");
   hframe__1->GetXaxis()->SetNdivisions(505);
   hframe__1->GetXaxis()->SetLabelFont(42);
   hframe__1->GetXaxis()->SetLabelOffset(0.007);
   hframe__1->GetXaxis()->SetTitleSize(0.05);
   hframe__1->GetXaxis()->SetTitleFont(42);
   hframe__1->GetYaxis()->SetTitle("p-value");
   hframe__1->GetYaxis()->SetLabelFont(42);
   hframe__1->GetYaxis()->SetLabelOffset(0.007);
   hframe__1->GetYaxis()->SetTitleSize(0.05);
   hframe__1->GetYaxis()->SetTitleOffset(1.2);
   hframe__1->GetYaxis()->SetTitleFont(42);
   hframe__1->GetZaxis()->SetLabelFont(42);
   hframe__1->GetZaxis()->SetLabelOffset(0.007);
   hframe__1->GetZaxis()->SetLabelSize(0.05);
   hframe__1->GetZaxis()->SetTitleSize(0.06);
   hframe__1->GetZaxis()->SetTitleFont(42);
   hframe__1->Draw(" ");
      
   /*TH1F *hframe__1 = new TH1F("hframe__1","",1000,1.75,2.05);
   hframe__1->SetMinimum(1e-05);
   hframe__1->SetMaximum(1);
   hframe__1->SetDirectory(0);
   hframe__1->SetStats(0);
   hframe__1->SetLineStyle(0);
   hframe__1->SetMarkerStyle(20);
   hframe__1->GetXaxis()->SetTitle("M_{W'} (TeV)");
   hframe__1->GetXaxis()->SetLabelFont(42);
   hframe__1->GetXaxis()->SetLabelOffset(0.007);
   hframe__1->GetXaxis()->SetLabelSize(0.035);
   hframe__1->GetXaxis()->SetTitleSize(0.005);
   hframe__1->GetXaxis()->SetTitleOffset(1.1);
   hframe__1->GetXaxis()->SetTitleFont(42);
   hframe__1->GetYaxis()->SetTitle("p-value");
   hframe__1->GetYaxis()->SetLabelFont(42);
   hframe__1->GetYaxis()->SetLabelOffset(0.007);
   hframe__1->GetYaxis()->SetLabelSize(0.035);
   hframe__1->GetYaxis()->SetTitleSize(0.045);
   hframe__1->GetYaxis()->SetTitleOffset(1.1);
   hframe__1->GetYaxis()->SetTitleFont(42);
   hframe__1->GetZaxis()->SetLabelFont(42);
   hframe__1->GetZaxis()->SetLabelOffset(0.007);
   hframe__1->GetZaxis()->SetLabelSize(0.05);
   hframe__1->GetZaxis()->SetTitleSize(0.06);
   hframe__1->GetZaxis()->SetTitleFont(42);
   hframe__1->Draw(" ");*/

   TLegend *leg = new TLegend(0.2248322,0.2109635,0.8171141,0.3704319,NULL,"brNDC");
   leg->SetBorderSize(0);
   leg->SetTextSize(0.031);
   leg->SetLineColor(1);
   leg->SetLineStyle(1);
   leg->SetLineWidth(1);
   leg->SetFillColor(0);
   leg->SetFillStyle(1001);
   leg->SetNColumns(2);
      
   /**********************************************************************************/   

   //ALLWVWPRIME8 (VV 8TeV)
   TGraph *graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);
   graph->SetLineWidth(2);
   graph->SetLineColor(kPink-1);//kRed+1//
   graph->SetMarkerColor(kPink-1);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.1119674537);
   graph->SetPoint(1,1.9,0.1297435624);
   graph->SetPoint(2,2,0.2388120608);
   
   TH1F *Graph_Observed1 = new TH1F("Graph_Observed1","Graph",100,0.37,3.13);
   Graph_Observed1->SetMinimum(0.03681925);
   Graph_Observed1->SetMaximum(0.545909);
   Graph_Observed1->SetDirectory(0);
   Graph_Observed1->SetStats(0);
   Graph_Observed1->SetLineStyle(0);
   Graph_Observed1->SetMarkerStyle(20);
   Graph_Observed1->GetXaxis()->SetLabelFont(42);
   Graph_Observed1->GetXaxis()->SetLabelOffset(0.007);
   Graph_Observed1->GetXaxis()->SetLabelSize(0.05);
   Graph_Observed1->GetXaxis()->SetTitleSize(0.06);
   Graph_Observed1->GetXaxis()->SetTitleOffset(0.9);
   Graph_Observed1->GetXaxis()->SetTitleFont(42);
   Graph_Observed1->GetYaxis()->SetLabelFont(42);
   Graph_Observed1->GetYaxis()->SetLabelOffset(0.007);
   Graph_Observed1->GetYaxis()->SetLabelSize(0.05);
   Graph_Observed1->GetYaxis()->SetTitleSize(0.06);
   Graph_Observed1->GetYaxis()->SetTitleOffset(1.25);
   Graph_Observed1->GetYaxis()->SetTitleFont(42);
   Graph_Observed1->GetZaxis()->SetLabelFont(42);
   Graph_Observed1->GetZaxis()->SetLabelOffset(0.007);
   Graph_Observed1->GetZaxis()->SetLabelSize(0.05);
   Graph_Observed1->GetZaxis()->SetTitleSize(0.06);
   Graph_Observed1->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Observed1);
   
   graph->Draw("lp");
   leg->AddEntry(graph,"VV 8 TeV","LP");

   //ALLHVWPRIME8 (VH 8TeV)
   graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);
   graph->SetLineWidth(2);
   graph->SetMarkerColor(210);
   graph->SetLineColor(210);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.0201061237);
   graph->SetPoint(1,1.9,0.01508285517);
   graph->SetPoint(2,2,0.5);
   
   TH1F *Graph_Observed2 = new TH1F("Graph_Observed2","Graph",100,0.62,2.78);
   Graph_Observed2->SetMinimum(0.01357457);
   Graph_Observed2->SetMaximum(0.5484917);
   Graph_Observed2->SetDirectory(0);
   Graph_Observed2->SetStats(0);
   Graph_Observed2->SetLineStyle(0);
   Graph_Observed2->SetMarkerStyle(20);
   Graph_Observed2->GetXaxis()->SetLabelFont(42);
   Graph_Observed2->GetXaxis()->SetLabelOffset(0.007);
   Graph_Observed2->GetXaxis()->SetLabelSize(0.05);
   Graph_Observed2->GetXaxis()->SetTitleSize(0.06);
   Graph_Observed2->GetXaxis()->SetTitleOffset(0.9);
   Graph_Observed2->GetXaxis()->SetTitleFont(42);
   Graph_Observed2->GetYaxis()->SetLabelFont(42);
   Graph_Observed2->GetYaxis()->SetLabelOffset(0.007);
   Graph_Observed2->GetYaxis()->SetLabelSize(0.05);
   Graph_Observed2->GetYaxis()->SetTitleSize(0.06);
   Graph_Observed2->GetYaxis()->SetTitleOffset(1.25);
   Graph_Observed2->GetYaxis()->SetTitleFont(42);
   Graph_Observed2->GetZaxis()->SetLabelFont(42);
   Graph_Observed2->GetZaxis()->SetLabelOffset(0.007);
   Graph_Observed2->GetZaxis()->SetLabelSize(0.05);
   Graph_Observed2->GetZaxis()->SetTitleSize(0.06);
   Graph_Observed2->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Observed2);
   
   graph->Draw("lp");   
   leg->AddEntry(graph,"VH 8 TeV","LP");
 
   //ALLWPRIME8 (VV+VH 8TeV)
   graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);
   graph->SetLineWidth(2);
   graph->SetMarkerColor(kPink+2);
   graph->SetLineColor(kPink+2);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.01379839392);
   graph->SetPoint(1,1.9,0.01191891314);
   graph->SetPoint(2,2,0.2986039328);
   
   TH1F *Graph_Observed3 = new TH1F("Graph_Observed3","Graph",100,0.37,3.13);
   Graph_Observed3->SetMinimum(0.01072702);
   Graph_Observed3->SetMaximum(0.5488081);
   Graph_Observed3->SetDirectory(0);
   Graph_Observed3->SetStats(0);
   Graph_Observed3->SetLineStyle(0);
   Graph_Observed3->SetMarkerStyle(20);
   Graph_Observed3->GetXaxis()->SetLabelFont(42);
   Graph_Observed3->GetXaxis()->SetLabelOffset(0.007);
   Graph_Observed3->GetXaxis()->SetLabelSize(0.05);
   Graph_Observed3->GetXaxis()->SetTitleSize(0.06);
   Graph_Observed3->GetXaxis()->SetTitleOffset(0.9);
   Graph_Observed3->GetXaxis()->SetTitleFont(42);
   Graph_Observed3->GetYaxis()->SetLabelFont(42);
   Graph_Observed3->GetYaxis()->SetLabelOffset(0.007);
   Graph_Observed3->GetYaxis()->SetLabelSize(0.05);
   Graph_Observed3->GetYaxis()->SetTitleSize(0.06);
   Graph_Observed3->GetYaxis()->SetTitleOffset(1.25);
   Graph_Observed3->GetYaxis()->SetTitleFont(42);
   Graph_Observed3->GetZaxis()->SetLabelFont(42);
   Graph_Observed3->GetZaxis()->SetLabelOffset(0.007);
   Graph_Observed3->GetZaxis()->SetLabelSize(0.05);
   Graph_Observed3->GetZaxis()->SetTitleSize(0.06);
   Graph_Observed3->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Observed3);
   
   graph->Draw("lp");   
   leg->AddEntry(graph,"VV+VH 8 TeV","LP");
     
   //JJLVJWPRIME13 (VV 13TeV)
   graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);
   graph->SetLineWidth(2);
   graph->SetLineColor(kOrange+2);
   graph->SetMarkerColor(kOrange+2);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.5);
   graph->SetPoint(1,1.9,0.5);
   graph->SetPoint(2,2,0.5);
   
   TH1F *Graph_Observed4 = new TH1F("Graph_Observed4","Graph",100,0.26,4.34);
   Graph_Observed4->SetMinimum(0.002869778);
   Graph_Observed4->SetMaximum(0.5496811);
   Graph_Observed4->SetDirectory(0);
   Graph_Observed4->SetStats(0);
   Graph_Observed4->SetLineStyle(0);
   Graph_Observed4->SetMarkerStyle(20);
   Graph_Observed4->GetXaxis()->SetLabelFont(42);
   Graph_Observed4->GetXaxis()->SetLabelOffset(0.007);
   Graph_Observed4->GetXaxis()->SetLabelSize(0.05);
   Graph_Observed4->GetXaxis()->SetTitleSize(0.06);
   Graph_Observed4->GetXaxis()->SetTitleOffset(0.9);
   Graph_Observed4->GetXaxis()->SetTitleFont(42);
   Graph_Observed4->GetYaxis()->SetLabelFont(42);
   Graph_Observed4->GetYaxis()->SetLabelOffset(0.007);
   Graph_Observed4->GetYaxis()->SetLabelSize(0.05);
   Graph_Observed4->GetYaxis()->SetTitleSize(0.06);
   Graph_Observed4->GetYaxis()->SetTitleOffset(1.25);
   Graph_Observed4->GetYaxis()->SetTitleFont(42);
   Graph_Observed4->GetZaxis()->SetLabelFont(42);
   Graph_Observed4->GetZaxis()->SetLabelOffset(0.007);
   Graph_Observed4->GetZaxis()->SetLabelSize(0.05);
   Graph_Observed4->GetZaxis()->SetTitleSize(0.06);
   Graph_Observed4->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Observed4);
   
   graph->Draw("lp");
   leg->AddEntry(graph,"VV 13 TeV","LP");

   //ALLWPRIME13 (VV+VH 13TeV)
   graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);
   graph->SetLineWidth(2);
   graph->SetLineColor(kBlue-4);
   graph->SetMarkerColor(kBlue-4);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.5);
   graph->SetPoint(1,1.9,0.5);
   graph->SetPoint(2,2,0.5);
   
   TH1F *Graph_Observed5 = new TH1F("Graph_Observed5","Graph",100,0.26,4.34);
   Graph_Observed5->SetMinimum(0.002869778);
   Graph_Observed5->SetMaximum(0.5496811);
   Graph_Observed5->SetDirectory(0);
   Graph_Observed5->SetStats(0);
   Graph_Observed5->SetLineStyle(0);
   Graph_Observed5->SetMarkerStyle(20);
   Graph_Observed5->GetXaxis()->SetLabelFont(42);
   Graph_Observed5->GetXaxis()->SetLabelOffset(0.007);
   Graph_Observed5->GetXaxis()->SetLabelSize(0.05);
   Graph_Observed5->GetXaxis()->SetTitleSize(0.06);
   Graph_Observed5->GetXaxis()->SetTitleOffset(0.9);
   Graph_Observed5->GetXaxis()->SetTitleFont(42);
   Graph_Observed5->GetYaxis()->SetLabelFont(42);
   Graph_Observed5->GetYaxis()->SetLabelOffset(0.007);
   Graph_Observed5->GetYaxis()->SetLabelSize(0.05);
   Graph_Observed5->GetYaxis()->SetTitleSize(0.06);
   Graph_Observed5->GetYaxis()->SetTitleOffset(1.25);
   Graph_Observed5->GetYaxis()->SetTitleFont(42);
   Graph_Observed5->GetZaxis()->SetLabelFont(42);
   Graph_Observed5->GetZaxis()->SetLabelOffset(0.007);
   Graph_Observed5->GetZaxis()->SetLabelSize(0.05);
   Graph_Observed5->GetZaxis()->SetTitleSize(0.06);
   Graph_Observed5->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Observed5);
   
   graph->Draw("lp");
   leg->AddEntry(graph,"VV+VH 13 TeV","LP");
      
   //ALLWVWPRIME138 (VV 8+13TeV)   
   graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);
   graph->SetLineWidth(2);
   graph->SetMarkerColor(kCyan-3);
   graph->SetLineColor(kCyan-3);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.3591660307);
   graph->SetPoint(1,1.9,0.5);
   graph->SetPoint(2,2,0.4345144436);
   
   TH1F *Graph_Observed6 = new TH1F("Graph_Observed6","Graph",100,0.26,4.34);
   Graph_Observed6->SetMinimum(0.005184239);
   Graph_Observed6->SetMaximum(0.549424);
   Graph_Observed6->SetDirectory(0);
   Graph_Observed6->SetStats(0);
   Graph_Observed6->SetLineStyle(0);
   Graph_Observed6->SetMarkerStyle(20);
   Graph_Observed6->GetXaxis()->SetLabelFont(42);
   Graph_Observed6->GetXaxis()->SetLabelOffset(0.007);
   Graph_Observed6->GetXaxis()->SetLabelSize(0.05);
   Graph_Observed6->GetXaxis()->SetTitleSize(0.06);
   Graph_Observed6->GetXaxis()->SetTitleOffset(0.9);
   Graph_Observed6->GetXaxis()->SetTitleFont(42);
   Graph_Observed6->GetYaxis()->SetLabelFont(42);
   Graph_Observed6->GetYaxis()->SetLabelOffset(0.007);
   Graph_Observed6->GetYaxis()->SetLabelSize(0.05);
   Graph_Observed6->GetYaxis()->SetTitleSize(0.06);
   Graph_Observed6->GetYaxis()->SetTitleOffset(1.25);
   Graph_Observed6->GetYaxis()->SetTitleFont(42);
   Graph_Observed6->GetZaxis()->SetLabelFont(42);
   Graph_Observed6->GetZaxis()->SetLabelOffset(0.007);
   Graph_Observed6->GetZaxis()->SetLabelSize(0.05);
   Graph_Observed6->GetZaxis()->SetTitleSize(0.06);
   Graph_Observed6->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Observed6);
   
   graph->Draw("lp");
   leg->AddEntry(graph,"VV 8+13 TeV","LP");
      
   //ALLWPRIME138 (VV+VH 8+13TeV)
   graph = new TGraph(3);
   graph->SetName("Observed");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);
   graph->SetLineWidth(2);
   graph->SetMarkerStyle(20);
   graph->SetPoint(0,1.8,0.2013182205);
   graph->SetPoint(1,1.9,0.466097453);
   graph->SetPoint(2,2,0.5);
   
   TH1F *Graph_Observed7 = new TH1F("Graph_Observed7","Graph",100,0.26,4.34);
   Graph_Observed7->SetMinimum(0.003477671);
   Graph_Observed7->SetMaximum(0.5496136);
   Graph_Observed7->SetDirectory(0);
   Graph_Observed7->SetStats(0);
   Graph_Observed7->SetLineStyle(0);
   Graph_Observed7->SetMarkerStyle(20);
   Graph_Observed7->GetXaxis()->SetLabelFont(42);
   Graph_Observed7->GetXaxis()->SetLabelOffset(0.007);
   Graph_Observed7->GetXaxis()->SetLabelSize(0.05);
   Graph_Observed7->GetXaxis()->SetTitleSize(0.06);
   Graph_Observed7->GetXaxis()->SetTitleOffset(0.9);
   Graph_Observed7->GetXaxis()->SetTitleFont(42);
   Graph_Observed7->GetYaxis()->SetLabelFont(42);
   Graph_Observed7->GetYaxis()->SetLabelOffset(0.007);
   Graph_Observed7->GetYaxis()->SetLabelSize(0.05);
   Graph_Observed7->GetYaxis()->SetTitleSize(0.06);
   Graph_Observed7->GetYaxis()->SetTitleOffset(1.25);
   Graph_Observed7->GetYaxis()->SetTitleFont(42);
   Graph_Observed7->GetZaxis()->SetLabelFont(42);
   Graph_Observed7->GetZaxis()->SetLabelOffset(0.007);
   Graph_Observed7->GetZaxis()->SetLabelSize(0.05);
   Graph_Observed7->GetZaxis()->SetTitleSize(0.06);
   Graph_Observed7->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Observed7);
   
   graph->Draw("lp");
   leg->AddEntry(graph,"VV+VH 8+13 TeV","LP");
         
   /**********************************************************************************/   
   TF1 *oneSLine = new TF1("oneSLine","1.58655253931457074e-01",0.75,2.05);
   oneSLine->SetFillColor(19);
   oneSLine->SetFillStyle(0);
   oneSLine->SetMarkerStyle(20);

   Int_t ci;   // for color index setting
   ci = TColor::GetColor("#ff0000");
   oneSLine->SetLineColor(ci);
   oneSLine->SetLineWidth(2);
   oneSLine->SetLineStyle(3);
   oneSLine->GetXaxis()->SetLabelFont(42);
   oneSLine->GetXaxis()->SetLabelOffset(0.007);
   oneSLine->GetXaxis()->SetLabelSize(0.05);
   oneSLine->GetXaxis()->SetTitleSize(0.06);
   oneSLine->GetXaxis()->SetTitleOffset(0.9);
   oneSLine->GetXaxis()->SetTitleFont(42);
   oneSLine->GetYaxis()->SetLabelFont(42);
   oneSLine->GetYaxis()->SetLabelOffset(0.007);
   oneSLine->GetYaxis()->SetLabelSize(0.05);
   oneSLine->GetYaxis()->SetTitleSize(0.06);
   oneSLine->GetYaxis()->SetTitleOffset(1.25);
   oneSLine->GetYaxis()->SetTitleFont(42);
   oneSLine->Draw("same");
   
   TF1 *twoSLine = new TF1("twoSLine","2.27501319481792155e-02",0.75,2.05);
   twoSLine->SetFillColor(19);
   twoSLine->SetFillStyle(0);
   twoSLine->SetMarkerStyle(20);

   ci = TColor::GetColor("#ff0000");
   twoSLine->SetLineColor(ci);
   twoSLine->SetLineWidth(2);
   twoSLine->SetLineStyle(3);
   twoSLine->GetXaxis()->SetLabelFont(42);
   twoSLine->GetXaxis()->SetLabelOffset(0.007);
   twoSLine->GetXaxis()->SetLabelSize(0.05);
   twoSLine->GetXaxis()->SetTitleSize(0.06);
   twoSLine->GetXaxis()->SetTitleOffset(0.9);
   twoSLine->GetXaxis()->SetTitleFont(42);
   twoSLine->GetYaxis()->SetLabelFont(42);
   twoSLine->GetYaxis()->SetLabelOffset(0.007);
   twoSLine->GetYaxis()->SetLabelSize(0.05);
   twoSLine->GetYaxis()->SetTitleSize(0.06);
   twoSLine->GetYaxis()->SetTitleOffset(1.25);
   twoSLine->GetYaxis()->SetTitleFont(42);
   twoSLine->Draw("same");
   
   TF1 *threeSLine = new TF1("threeSLine","1.34989803163009588e-03",0.75,2.05);
   threeSLine->SetFillColor(19);
   threeSLine->SetFillStyle(0);
   threeSLine->SetMarkerStyle(20);

   ci = TColor::GetColor("#ff0000");
   threeSLine->SetLineColor(ci);
   threeSLine->SetLineWidth(2);
   threeSLine->SetLineStyle(3);
   threeSLine->GetXaxis()->SetLabelFont(42);
   threeSLine->GetXaxis()->SetLabelOffset(0.007);
   threeSLine->GetXaxis()->SetLabelSize(0.05);
   threeSLine->GetXaxis()->SetTitleSize(0.06);
   threeSLine->GetXaxis()->SetTitleOffset(0.9);
   threeSLine->GetXaxis()->SetTitleFont(42);
   threeSLine->GetYaxis()->SetLabelFont(42);
   threeSLine->GetYaxis()->SetLabelOffset(0.007);
   threeSLine->GetYaxis()->SetLabelSize(0.05);
   threeSLine->GetYaxis()->SetTitleSize(0.06);
   threeSLine->GetYaxis()->SetTitleOffset(1.25);
   threeSLine->GetYaxis()->SetTitleFont(42);
   threeSLine->Draw("same");
   
   TF1 *fourSLine = new TF1("fourSLine","3.16712418331199785e-05",0.75,2.05);
   fourSLine->SetFillColor(19);
   fourSLine->SetFillStyle(0);
   fourSLine->SetMarkerStyle(20);

   ci = TColor::GetColor("#ff0000");
   fourSLine->SetLineColor(ci);
   fourSLine->SetLineWidth(2);
   fourSLine->SetLineStyle(3);
   fourSLine->GetXaxis()->SetLabelFont(42);
   fourSLine->GetXaxis()->SetLabelOffset(0.007);
   fourSLine->GetXaxis()->SetLabelSize(0.05);
   fourSLine->GetXaxis()->SetTitleSize(0.06);
   fourSLine->GetXaxis()->SetTitleOffset(0.9);
   fourSLine->GetXaxis()->SetTitleFont(42);
   fourSLine->GetYaxis()->SetLabelFont(42);
   fourSLine->GetYaxis()->SetLabelOffset(0.007);
   fourSLine->GetYaxis()->SetLabelSize(0.05);
   fourSLine->GetYaxis()->SetTitleSize(0.06);
   fourSLine->GetYaxis()->SetTitleOffset(1.25);
   fourSLine->GetYaxis()->SetTitleFont(42);
   fourSLine->Draw("same");
   
   TLatex *   tex = new TLatex(2.02,0.1586553,"1 #sigma");
   tex->SetTextColor(2);
   tex->SetTextSize(0.028);
   tex->SetLineWidth(2);
   tex->Draw();
      tex = new TLatex(2.02,0.02275013,"2 #sigma");
   tex->SetTextColor(2);
   tex->SetTextSize(0.028);
   tex->SetLineWidth(2);
   tex->Draw();
      tex = new TLatex(2.02,0.001349898,"3 #sigma");
   tex->SetTextColor(2);
   tex->SetTextSize(0.028);
   tex->SetLineWidth(2);
   tex->Draw();
      tex = new TLatex(2.02,3.167124e-05,"4 #sigma");
   tex->SetTextColor(2);
   tex->SetTextSize(0.028);
   tex->SetLineWidth(2);
   tex->Draw();

   /**********************************************************************************/      
   /*TLegend *leg = new TLegend(0.4966443,0.2325581,0.8926174,0.3239203,NULL,"brNDC");
   leg->SetBorderSize(0);
   leg->SetTextSize(0.031);
   leg->SetLineColor(1);
   leg->SetLineStyle(1);
   leg->SetLineWidth(1);
   leg->SetFillColor(0);
   leg->SetFillStyle(1001);
   TLegendEntry *entry=leg->AddEntry("Observed","Observed significance","pl");
   entry->SetLineColor(1);
   entry->SetLineStyle(1);
   entry->SetLineWidth(2);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(20);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("Expected","Expected significance","l");
   entry->SetLineColor(1);
   entry->SetLineStyle(2);
   entry->SetLineWidth(2);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(21);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);*/
   leg->Draw();

   /**********************************************************************************/   
      /*tex = new TLatex(0.93,0.944,"2.3-2.7 fb^{-1} (13 TeV)");
tex->SetNDC();
   tex->SetTextAlign(31);
   tex->SetTextFont(42);
   tex->SetTextSize(0.0371);
   tex->SetLineWidth(2);
   tex->Draw();
      tex = new TLatex(0.234,0.90165,"CMS");
tex->SetNDC();
   tex->SetTextAlign(13);
   tex->SetTextFont(61);
   tex->SetTextSize(0.0455);
   tex->SetLineWidth(2);
   tex->Draw();
      tex = new TLatex(0.234,0.84705,"Preliminary");
tex->SetNDC();
   tex->SetTextAlign(13);
   tex->SetTextFont(52);
   tex->SetTextSize(0.02548);
   tex->SetLineWidth(2);*/
   //tex->Draw();
   TLatex *   tex = new TLatex(0.93,0.944,"#scale[0.85]{2.3-2.7 fb^{-1} (13 TeV) + 19.7 fb^{-1} (8 TeV)}");
tex->SetNDC();
   tex->SetTextAlign(31);
   tex->SetTextFont(42);
   tex->SetTextSize(0.0371);
   tex->SetLineWidth(2);
   tex->Draw();
      tex = new TLatex(0.13,0.944,"CMS");
tex->SetNDC();
   tex->SetTextFont(61);
   tex->SetTextSize(0.0455);
   tex->SetLineWidth(2);
   tex->Draw();

   /**********************************************************************************/      
   /*TH1F *hframe__2 = new TH1F("hframe__2","",1000,1.75,2.05);
   hframe__2->SetMinimum(1e-05);
   hframe__2->SetMaximum(10);
   hframe__2->SetDirectory(0);
   hframe__2->SetStats(0);
   hframe__2->SetLineStyle(0);
   hframe__2->SetMarkerStyle(20);
   hframe__2->GetXaxis()->SetTitle("M_{W'} (TeV)");
   hframe__2->GetXaxis()->SetLabelFont(42);
   hframe__2->GetXaxis()->SetLabelOffset(0.007);
   hframe__2->GetXaxis()->SetLabelSize(0.035);
   hframe__2->GetXaxis()->SetTitleSize(0.045);
   hframe__2->GetXaxis()->SetTitleOffset(1.1);
   hframe__2->GetXaxis()->SetTitleFont(42);
   hframe__2->GetYaxis()->SetTitle("p-value");
   hframe__2->GetYaxis()->SetLabelFont(42);
   hframe__2->GetYaxis()->SetLabelOffset(0.007);
   hframe__2->GetYaxis()->SetLabelSize(0.035);
   hframe__2->GetYaxis()->SetTitleSize(0.045);
   hframe__2->GetYaxis()->SetTitleOffset(1.1);
   hframe__2->GetYaxis()->SetTitleFont(42);
   hframe__2->GetZaxis()->SetLabelFont(42);
   hframe__2->GetZaxis()->SetLabelOffset(0.007);
   hframe__2->GetZaxis()->SetLabelSize(0.05);
   hframe__2->GetZaxis()->SetTitleSize(0.06);
   hframe__2->GetZaxis()->SetTitleFont(42);
   hframe__2->Draw("sameaxis");
   
   TH1F *hframe__3 = new TH1F("hframe__3","",1000,1.75,2.05);
   hframe__3->SetMinimum(1e-05);
   hframe__3->SetMaximum(1);
   hframe__3->SetDirectory(0);
   hframe__3->SetStats(0);
   hframe__3->SetLineStyle(0);
   hframe__3->SetMarkerStyle(20);
   hframe__3->GetXaxis()->SetTitle("M_{W'} (TeV)");
   hframe__3->GetXaxis()->SetLabelFont(42);
   hframe__3->GetXaxis()->SetLabelOffset(0.007);
   hframe__3->GetXaxis()->SetLabelSize(0.035);
   hframe__3->GetXaxis()->SetTitleSize(0.045);
   hframe__3->GetXaxis()->SetTitleOffset(1.1);
   hframe__3->GetXaxis()->SetTitleFont(42);
   hframe__3->GetYaxis()->SetTitle("p-value");
   hframe__3->GetYaxis()->SetLabelFont(42);
   hframe__3->GetYaxis()->SetLabelOffset(0.007);
   hframe__3->GetYaxis()->SetLabelSize(0.035);
   hframe__3->GetYaxis()->SetTitleSize(0.045);
   hframe__3->GetYaxis()->SetTitleOffset(1.1);
   hframe__3->GetYaxis()->SetTitleFont(42);
   hframe__3->GetZaxis()->SetLabelFont(42);
   hframe__3->GetZaxis()->SetLabelOffset(0.007);
   hframe__3->GetZaxis()->SetLabelSize(0.05);
   hframe__3->GetZaxis()->SetTitleSize(0.06);
   hframe__3->GetZaxis()->SetTitleFont(42);
   hframe__3->Draw("sameaxig");*/
   
   c_Significance->Modified();
   c_Significance->cd();
   c_Significance->SetSelected(c_Significance);
}

