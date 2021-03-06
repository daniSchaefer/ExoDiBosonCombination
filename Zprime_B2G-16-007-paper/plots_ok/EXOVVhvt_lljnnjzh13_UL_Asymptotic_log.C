{
//=========Macro generated from canvas: c_lim_Asymptotic/c_lim_Asymptotic
//=========  (Fri Oct 14 10:16:07 2016) by ROOT version5.34/18
   TCanvas *c_lim_Asymptotic = new TCanvas("c_lim_Asymptotic", "c_lim_Asymptotic",0,0,600,630);
   gStyle->SetOptFit(1);
   gStyle->SetOptStat(0);
   gStyle->SetOptTitle(0);
   c_lim_Asymptotic->SetHighLightColor(2);
   c_lim_Asymptotic->Range(0.21375,-3.740741,4.33875,2.432099);
   c_lim_Asymptotic->SetFillColor(0);
   c_lim_Asymptotic->SetBorderMode(0);
   c_lim_Asymptotic->SetBorderSize(2);
   c_lim_Asymptotic->SetLogy();
   c_lim_Asymptotic->SetTickx(1);
   c_lim_Asymptotic->SetTicky(1);
   c_lim_Asymptotic->SetLeftMargin(0.13);
   c_lim_Asymptotic->SetRightMargin(0.07);
   c_lim_Asymptotic->SetTopMargin(0.07);
   c_lim_Asymptotic->SetBottomMargin(0.12);
   c_lim_Asymptotic->SetFrameFillStyle(0);
   c_lim_Asymptotic->SetFrameBorderMode(0);
   c_lim_Asymptotic->SetFrameFillStyle(0);
   c_lim_Asymptotic->SetFrameBorderMode(0);
   
   TH1F *hframe__7 = new TH1F("hframe__7","",1000,0.75,4.05);
   hframe__7->SetMinimum(0.001);
   hframe__7->SetMaximum(100);
   hframe__7->SetDirectory(0);
   hframe__7->SetStats(0);
   hframe__7->SetLineStyle(0);
   hframe__7->SetMarkerStyle(20);
   hframe__7->GetXaxis()->SetTitle("M_{Z'} (TeV)");
   hframe__7->GetXaxis()->SetLabelFont(42);
   hframe__7->GetXaxis()->SetLabelOffset(0.007);
   hframe__7->GetXaxis()->SetLabelSize(0.035);
   hframe__7->GetXaxis()->SetTitleSize(0.045);
   hframe__7->GetXaxis()->SetTitleOffset(1.1);
   hframe__7->GetXaxis()->SetTitleFont(42);
   hframe__7->GetYaxis()->SetTitle("#sigma_{95%} #times BR_{Z' #rightarrow WW/ZH} (pb)");
   hframe__7->GetYaxis()->SetLabelFont(42);
   hframe__7->GetYaxis()->SetLabelOffset(0.007);
   hframe__7->GetYaxis()->SetLabelSize(0.035);
   hframe__7->GetYaxis()->SetTitleSize(0.045);
   hframe__7->GetYaxis()->SetTitleOffset(1.1);
   hframe__7->GetYaxis()->SetTitleFont(42);
   hframe__7->GetZaxis()->SetLabelFont(42);
   hframe__7->GetZaxis()->SetLabelOffset(0.007);
   hframe__7->GetZaxis()->SetLabelSize(0.05);
   hframe__7->GetZaxis()->SetTitleSize(0.06);
   hframe__7->GetZaxis()->SetTitleFont(42);
   hframe__7->Draw(" ");
   
   TGraphAsymmErrors *grae = new TGraphAsymmErrors(66);
   grae->SetName("Limit95CLs");
   grae->SetTitle("Graph");
   grae->SetFillColor(5);
   grae->SetLineStyle(2);
   grae->SetLineWidth(3);
   grae->SetMarkerStyle(20);
   grae->SetPoint(0,0.8,0.09332774);
   grae->SetPointError(0,0,0,0,0);
   grae->SetPoint(1,0.9,0.09890983);
   grae->SetPointError(1,0,0,0,0);
   grae->SetPoint(2,1,0.07650125);
   grae->SetPointError(2,0,0,0,0);
   grae->SetPoint(3,1.1,0.06400925);
   grae->SetPointError(3,0,0,0,0);
   grae->SetPoint(4,1.2,0.05564345);
   grae->SetPointError(4,0,0,0,0);
   grae->SetPoint(5,1.3,0.04481966);
   grae->SetPointError(5,0,0,0,0);
   grae->SetPoint(6,1.4,0.0376452);
   grae->SetPointError(6,0,0,0,0);
   grae->SetPoint(7,1.5,0.03268813);
   grae->SetPointError(7,0,0,0,0);
   grae->SetPoint(8,1.6,0.03106283);
   grae->SetPointError(8,0,0,0,0);
   grae->SetPoint(9,1.7,0.02792294);
   grae->SetPointError(9,0,0,0,0);
   grae->SetPoint(10,1.8,0.0253655);
   grae->SetPointError(10,0,0,0,0);
   grae->SetPoint(11,1.9,0.02260107);
   grae->SetPointError(11,0,0,0,0);
   grae->SetPoint(12,2,0.02048594);
   grae->SetPointError(12,0,0,0,0);
   grae->SetPoint(13,2.1,0.02177641);
   grae->SetPointError(13,0,0,0,0);
   grae->SetPoint(14,2.2,0.01987998);
   grae->SetPointError(14,0,0,0,0);
   grae->SetPoint(15,2.3,0.0181738);
   grae->SetPointError(15,0,0,0,0);
   grae->SetPoint(16,2.4,0.01676452);
   grae->SetPointError(16,0,0,0,0);
   grae->SetPoint(17,2.5,0.01559654);
   grae->SetPointError(17,0,0,0,0);
   grae->SetPoint(18,2.6,0.01458885);
   grae->SetPointError(18,0,0,0,0);
   grae->SetPoint(19,2.7,0.01379855);
   grae->SetPointError(19,0,0,0,0);
   grae->SetPoint(20,2.8,0.01309534);
   grae->SetPointError(20,0,0,0,0);
   grae->SetPoint(21,2.9,0.01253883);
   grae->SetPointError(21,0,0,0,0);
   grae->SetPoint(22,3,0.0120653);
   grae->SetPointError(22,0,0,0,0);
   grae->SetPoint(23,3.1,0.01173437);
   grae->SetPointError(23,0,0,0,0);
   grae->SetPoint(24,3.2,0.01147106);
   grae->SetPointError(24,0,0,0,0);
   grae->SetPoint(25,3.3,0.01134129);
   grae->SetPointError(25,0,0,0,0);
   grae->SetPoint(26,3.4,0.01125369);
   grae->SetPointError(26,0,0,0,0);
   grae->SetPoint(27,3.5,0.01126862);
   grae->SetPointError(27,0,0,0,0);
   grae->SetPoint(28,3.6,0.01136283);
   grae->SetPointError(28,0,0,0,0);
   grae->SetPoint(29,3.7,0.01156203);
   grae->SetPointError(29,0,0,0,0);
   grae->SetPoint(30,3.8,0.01184947);
   grae->SetPointError(30,0,0,0,0);
   grae->SetPoint(31,3.9,0.01222891);
   grae->SetPointError(31,0,0,0,0);
   grae->SetPoint(32,4,0.01251985);
   grae->SetPointError(32,0,0,0,0);
   grae->SetPoint(33,4,0.1283173);
   grae->SetPointError(33,0,0,0,0);
   grae->SetPoint(34,3.9,0.1245085);
   grae->SetPointError(34,0,0,0,0);
   grae->SetPoint(35,3.8,0.1198592);
   grae->SetPointError(35,0,0,0,0);
   grae->SetPoint(36,3.7,0.11619);
   grae->SetPointError(36,0,0,0,0);
   grae->SetPoint(37,3.6,0.1127289);
   grae->SetPointError(37,0,0,0,0);
   grae->SetPoint(38,3.5,0.1103836);
   grae->SetPointError(38,0,0,0,0);
   grae->SetPoint(39,3.4,0.1088592);
   grae->SetPointError(39,0,0,0,0);
   grae->SetPoint(40,3.3,0.1086863);
   grae->SetPointError(40,0,0,0,0);
   grae->SetPoint(41,3.2,0.1082592);
   grae->SetPointError(41,0,0,0,0);
   grae->SetPoint(42,3.1,0.109405);
   grae->SetPointError(42,0,0,0,0);
   grae->SetPoint(43,3,0.1104994);
   grae->SetPointError(43,0,0,0,0);
   grae->SetPoint(44,2.9,0.1128344);
   grae->SetPointError(44,0,0,0,0);
   grae->SetPoint(45,2.8,0.115167);
   grae->SetPointError(45,0,0,0,0);
   grae->SetPoint(46,2.7,0.1186621);
   grae->SetPointError(46,0,0,0,0);
   grae->SetPoint(47,2.6,0.1233972);
   grae->SetPointError(47,0,0,0,0);
   grae->SetPoint(48,2.5,0.1287576);
   grae->SetPointError(48,0,0,0,0);
   grae->SetPoint(49,2.4,0.1344605);
   grae->SetPointError(49,0,0,0,0);
   grae->SetPoint(50,2.3,0.1420863);
   grae->SetPointError(50,0,0,0,0);
   grae->SetPoint(51,2.2,0.1504912);
   grae->SetPointError(51,0,0,0,0);
   grae->SetPoint(52,2.1,0.1584294);
   grae->SetPointError(52,0,0,0,0);
   grae->SetPoint(53,2,0.1601564);
   grae->SetPointError(53,0,0,0,0);
   grae->SetPoint(54,1.9,0.1710898);
   grae->SetPointError(54,0,0,0,0);
   grae->SetPoint(55,1.8,0.1858027);
   grae->SetPointError(55,0,0,0,0);
   grae->SetPoint(56,1.7,0.197894);
   grae->SetPointError(56,0,0,0,0);
   grae->SetPoint(57,1.6,0.2129575);
   grae->SetPointError(57,0,0,0,0);
   grae->SetPoint(58,1.5,0.2344499);
   grae->SetPointError(58,0,0,0,0);
   grae->SetPoint(59,1.4,0.2606303);
   grae->SetPointError(59,0,0,0,0);
   grae->SetPoint(60,1.3,0.2995488);
   grae->SetPointError(60,0,0,0,0);
   grae->SetPoint(61,1.2,0.3478324);
   grae->SetPointError(61,0,0,0,0);
   grae->SetPoint(62,1.1,0.3837095);
   grae->SetPointError(62,0,0,0,0);
   grae->SetPoint(63,1,0.4470566);
   grae->SetPointError(63,0,0,0,0);
   grae->SetPoint(64,0.9,0.5236919);
   grae->SetPointError(64,0,0,0,0);
   grae->SetPoint(65,0.8,0.5232254);
   grae->SetPointError(65,0,0,0,0);
   
   TH1F *Graph_Limit95CLs9 = new TH1F("Graph_Limit95CLs9","Graph",100,0.48,4.32);
   Graph_Limit95CLs9->SetMinimum(0.01012832);
   Graph_Limit95CLs9->SetMaximum(0.5749357);
   Graph_Limit95CLs9->SetDirectory(0);
   Graph_Limit95CLs9->SetStats(0);
   Graph_Limit95CLs9->SetLineStyle(0);
   Graph_Limit95CLs9->SetMarkerStyle(20);
   Graph_Limit95CLs9->GetXaxis()->SetLabelFont(42);
   Graph_Limit95CLs9->GetXaxis()->SetLabelOffset(0.007);
   Graph_Limit95CLs9->GetXaxis()->SetLabelSize(0.05);
   Graph_Limit95CLs9->GetXaxis()->SetTitleSize(0.06);
   Graph_Limit95CLs9->GetXaxis()->SetTitleOffset(0.9);
   Graph_Limit95CLs9->GetXaxis()->SetTitleFont(42);
   Graph_Limit95CLs9->GetYaxis()->SetLabelFont(42);
   Graph_Limit95CLs9->GetYaxis()->SetLabelOffset(0.007);
   Graph_Limit95CLs9->GetYaxis()->SetLabelSize(0.05);
   Graph_Limit95CLs9->GetYaxis()->SetTitleSize(0.06);
   Graph_Limit95CLs9->GetYaxis()->SetTitleOffset(1.25);
   Graph_Limit95CLs9->GetYaxis()->SetTitleFont(42);
   Graph_Limit95CLs9->GetZaxis()->SetLabelFont(42);
   Graph_Limit95CLs9->GetZaxis()->SetLabelOffset(0.007);
   Graph_Limit95CLs9->GetZaxis()->SetLabelSize(0.05);
   Graph_Limit95CLs9->GetZaxis()->SetTitleSize(0.06);
   Graph_Limit95CLs9->GetZaxis()->SetTitleFont(42);
   grae->SetHistogram(Graph_Limit95CLs9);
   
   grae->Draw("f");
   
   grae = new TGraphAsymmErrors(66);
   grae->SetName("Limit68CLs");
   grae->SetTitle("Graph");
   grae->SetFillColor(3);
   grae->SetLineStyle(2);
   grae->SetLineWidth(3);
   grae->SetMarkerStyle(20);
   grae->SetPoint(0,0.8,0.1306815);
   grae->SetPointError(0,0,0,0,0);
   grae->SetPoint(1,0.9,0.1372263);
   grae->SetPointError(1,0,0,0,0);
   grae->SetPoint(2,1,0.1069168);
   grae->SetPointError(2,0,0,0,0);
   grae->SetPoint(3,1.1,0.09150995);
   grae->SetPointError(3,0,0,0,0);
   grae->SetPoint(4,1.2,0.07901267);
   grae->SetPointError(4,0,0,0,0);
   grae->SetPoint(5,1.3,0.06533691);
   grae->SetPointError(5,0,0,0,0);
   grae->SetPoint(6,1.4,0.05531807);
   grae->SetPointError(6,0,0,0,0);
   grae->SetPoint(7,1.5,0.04840821);
   grae->SetPointError(7,0,0,0,0);
   grae->SetPoint(8,1.6,0.04541385);
   grae->SetPointError(8,0,0,0,0);
   grae->SetPoint(9,1.7,0.04124378);
   grae->SetPointError(9,0,0,0,0);
   grae->SetPoint(10,1.8,0.03786289);
   grae->SetPointError(10,0,0,0,0);
   grae->SetPoint(11,1.9,0.03410359);
   grae->SetPointError(11,0,0,0,0);
   grae->SetPoint(12,2,0.0312286);
   grae->SetPointError(12,0,0,0,0);
   grae->SetPoint(13,2.1,0.03225883);
   grae->SetPointError(13,0,0,0,0);
   grae->SetPoint(14,2.2,0.02976505);
   grae->SetPointError(14,0,0,0,0);
   grae->SetPoint(15,2.3,0.027704);
   grae->SetPointError(15,0,0,0,0);
   grae->SetPoint(16,2.4,0.0259267);
   grae->SetPointError(16,0,0,0,0);
   grae->SetPoint(17,2.5,0.02441626);
   grae->SetPointError(17,0,0,0,0);
   grae->SetPoint(18,2.6,0.02315843);
   grae->SetPointError(18,0,0,0,0);
   grae->SetPoint(19,2.7,0.02201487);
   grae->SetPointError(19,0,0,0,0);
   grae->SetPoint(20,2.8,0.02116588);
   grae->SetPointError(20,0,0,0,0);
   grae->SetPoint(21,2.9,0.02053986);
   grae->SetPointError(21,0,0,0,0);
   grae->SetPoint(22,3,0.01996966);
   grae->SetPointError(22,0,0,0,0);
   grae->SetPoint(23,3.1,0.019629);
   grae->SetPointError(23,0,0,0,0);
   grae->SetPoint(24,3.2,0.01932759);
   grae->SetPointError(24,0,0,0,0);
   grae->SetPoint(25,3.3,0.01914198);
   grae->SetPointError(25,0,0,0,0);
   grae->SetPoint(26,3.4,0.01919622);
   grae->SetPointError(26,0,0,0,0);
   grae->SetPoint(27,3.5,0.01931878);
   grae->SetPointError(27,0,0,0,0);
   grae->SetPoint(28,3.6,0.01958014);
   grae->SetPointError(28,0,0,0,0);
   grae->SetPoint(29,3.7,0.02002703);
   grae->SetPointError(29,0,0,0,0);
   grae->SetPoint(30,3.8,0.02060585);
   grae->SetPointError(30,0,0,0,0);
   grae->SetPoint(31,3.9,0.02135032);
   grae->SetPointError(31,0,0,0,0);
   grae->SetPoint(32,4,0.02188787);
   grae->SetPointError(32,0,0,0,0);
   grae->SetPoint(33,4,0.084475);
   grae->SetPointError(33,0,0,0,0);
   grae->SetPoint(34,3.9,0.08131626);
   grae->SetPointError(34,0,0,0,0);
   grae->SetPoint(35,3.8,0.07827985);
   grae->SetPointError(35,0,0,0,0);
   grae->SetPoint(36,3.7,0.0752757);
   grae->SetPointError(36,0,0,0,0);
   grae->SetPoint(37,3.6,0.07303335);
   grae->SetPointError(37,0,0,0,0);
   grae->SetPoint(38,3.5,0.07151391);
   grae->SetPointError(38,0,0,0,0);
   grae->SetPoint(39,3.4,0.0699568);
   grae->SetPointError(39,0,0,0,0);
   grae->SetPoint(40,3.3,0.06927705);
   grae->SetPointError(40,0,0,0,0);
   grae->SetPoint(41,3.2,0.06900486);
   grae->SetPointError(41,0,0,0,0);
   grae->SetPoint(42,3.1,0.06859026);
   grae->SetPointError(42,0,0,0,0);
   grae->SetPoint(43,3,0.06927637);
   grae->SetPointError(43,0,0,0,0);
   grae->SetPoint(44,2.9,0.0701498);
   grae->SetPointError(44,0,0,0,0);
   grae->SetPoint(45,2.8,0.07099722);
   grae->SetPointError(45,0,0,0,0);
   grae->SetPoint(46,2.7,0.07315188);
   grae->SetPointError(46,0,0,0,0);
   grae->SetPoint(47,2.6,0.07477912);
   grae->SetPointError(47,0,0,0,0);
   grae->SetPoint(48,2.5,0.07735353);
   grae->SetPointError(48,0,0,0,0);
   grae->SetPoint(49,2.4,0.08007572);
   grae->SetPointError(49,0,0,0,0);
   grae->SetPoint(50,2.3,0.08387317);
   grae->SetPointError(50,0,0,0,0);
   grae->SetPoint(51,2.2,0.08804657);
   grae->SetPointError(51,0,0,0,0);
   grae->SetPoint(52,2.1,0.09289866);
   grae->SetPointError(52,0,0,0,0);
   grae->SetPoint(53,2,0.0937013);
   grae->SetPointError(53,0,0,0,0);
   grae->SetPoint(54,1.9,0.100098);
   grae->SetPointError(54,0,0,0,0);
   grae->SetPoint(55,1.8,0.1082098);
   grae->SetPointError(55,0,0,0,0);
   grae->SetPoint(56,1.7,0.1158127);
   grae->SetPointError(56,0,0,0,0);
   grae->SetPoint(57,1.6,0.1252923);
   grae->SetPointError(57,0,0,0,0);
   grae->SetPoint(58,1.5,0.137475);
   grae->SetPointError(58,0,0,0,0);
   grae->SetPoint(59,1.4,0.1546842);
   grae->SetPointError(59,0,0,0,0);
   grae->SetPoint(60,1.3,0.1775085);
   grae->SetPointError(60,0,0,0,0);
   grae->SetPoint(61,1.2,0.2087104);
   grae->SetPointError(61,0,0,0,0);
   grae->SetPoint(62,1.1,0.2355256);
   grae->SetPointError(62,0,0,0,0);
   grae->SetPoint(63,1,0.2766582);
   grae->SetPointError(63,0,0,0,0);
   grae->SetPoint(64,0.9,0.3302894);
   grae->SetPointError(64,0,0,0,0);
   grae->SetPoint(65,0.8,0.3240165);
   grae->SetPointError(65,0,0,0,0);
   
   TH1F *Graph_Limit68CLs10 = new TH1F("Graph_Limit68CLs10","Graph",100,0.48,4.32);
   Graph_Limit68CLs10->SetMinimum(0.01722778);
   Graph_Limit68CLs10->SetMaximum(0.3614042);
   Graph_Limit68CLs10->SetDirectory(0);
   Graph_Limit68CLs10->SetStats(0);
   Graph_Limit68CLs10->SetLineStyle(0);
   Graph_Limit68CLs10->SetMarkerStyle(20);
   Graph_Limit68CLs10->GetXaxis()->SetLabelFont(42);
   Graph_Limit68CLs10->GetXaxis()->SetLabelOffset(0.007);
   Graph_Limit68CLs10->GetXaxis()->SetLabelSize(0.05);
   Graph_Limit68CLs10->GetXaxis()->SetTitleSize(0.06);
   Graph_Limit68CLs10->GetXaxis()->SetTitleOffset(0.9);
   Graph_Limit68CLs10->GetXaxis()->SetTitleFont(42);
   Graph_Limit68CLs10->GetYaxis()->SetLabelFont(42);
   Graph_Limit68CLs10->GetYaxis()->SetLabelOffset(0.007);
   Graph_Limit68CLs10->GetYaxis()->SetLabelSize(0.05);
   Graph_Limit68CLs10->GetYaxis()->SetTitleSize(0.06);
   Graph_Limit68CLs10->GetYaxis()->SetTitleOffset(1.25);
   Graph_Limit68CLs10->GetYaxis()->SetTitleFont(42);
   Graph_Limit68CLs10->GetZaxis()->SetLabelFont(42);
   Graph_Limit68CLs10->GetZaxis()->SetLabelOffset(0.007);
   Graph_Limit68CLs10->GetZaxis()->SetLabelSize(0.05);
   Graph_Limit68CLs10->GetZaxis()->SetTitleSize(0.06);
   Graph_Limit68CLs10->GetZaxis()->SetTitleFont(42);
   grae->SetHistogram(Graph_Limit68CLs10);
   
   grae->Draw("f");
   
   grae = new TGraphAsymmErrors(33);
   grae->SetName("LimitExpectedCLs");
   grae->SetTitle("Graph");
   grae->SetFillColor(1);
   grae->SetLineStyle(2);
   grae->SetLineWidth(3);
   grae->SetMarkerStyle(24);
   grae->SetMarkerSize(2);
   grae->SetPoint(0,0.8,0.2007723);
   grae->SetPointError(0,0,0,0,0);
   grae->SetPoint(1,0.9,0.2067014);
   grae->SetPointError(1,0,0,0,0);
   grae->SetPoint(2,1,0.1681058);
   grae->SetPointError(2,0,0,0,0);
   grae->SetPoint(3,1.1,0.1431124);
   grae->SetPointError(3,0,0,0,0);
   grae->SetPoint(4,1.2,0.1244081);
   grae->SetPointError(4,0,0,0,0);
   grae->SetPoint(5,1.3,0.1038356);
   grae->SetPointError(5,0,0,0,0);
   grae->SetPoint(6,1.4,0.08964811);
   grae->SetPointError(6,0,0,0,0);
   grae->SetPoint(7,1.5,0.07894492);
   grae->SetPointError(7,0,0,0,0);
   grae->SetPoint(8,1.6,0.0732911);
   grae->SetPointError(8,0,0,0,0);
   grae->SetPoint(9,1.7,0.06711992);
   grae->SetPointError(9,0,0,0,0);
   grae->SetPoint(10,1.8,0.06213942);
   grae->SetPointError(10,0,0,0,0);
   grae->SetPoint(11,1.9,0.05644756);
   grae->SetPointError(11,0,0,0,0);
   grae->SetPoint(12,2,0.0528403);
   grae->SetPointError(12,0,0,0,0);
   grae->SetPoint(13,2.1,0.05334699);
   grae->SetPointError(13,0,0,0,0);
   grae->SetPoint(14,2.2,0.04965147);
   grae->SetPointError(14,0,0,0,0);
   grae->SetPoint(15,2.3,0.04687651);
   grae->SetPointError(15,0,0,0,0);
   grae->SetPoint(16,2.4,0.04435884);
   grae->SetPointError(16,0,0,0,0);
   grae->SetPoint(17,2.5,0.04247569);
   grae->SetPointError(17,0,0,0,0);
   grae->SetPoint(18,2.6,0.04070567);
   grae->SetPointError(18,0,0,0,0);
   grae->SetPoint(19,2.7,0.03914048);
   grae->SetPointError(19,0,0,0,0);
   grae->SetPoint(20,2.8,0.03798761);
   grae->SetPointError(20,0,0,0,0);
   grae->SetPoint(21,2.9,0.0372167);
   grae->SetPointError(21,0,0,0,0);
   grae->SetPoint(22,3,0.03644502);
   grae->SetPointError(22,0,0,0,0);
   grae->SetPoint(23,3.1,0.03608408);
   grae->SetPointError(23,0,0,0,0);
   grae->SetPoint(24,3.2,0.03570324);
   grae->SetPointError(24,0,0,0,0);
   grae->SetPoint(25,3.3,0.03584407);
   grae->SetPointError(25,0,0,0,0);
   grae->SetPoint(26,3.4,0.03589962);
   grae->SetPointError(26,0,0,0,0);
   grae->SetPoint(27,3.5,0.03640084);
   grae->SetPointError(27,0,0,0,0);
   grae->SetPoint(28,3.6,0.03717424);
   grae->SetPointError(28,0,0,0,0);
   grae->SetPoint(29,3.7,0.0383156);
   grae->SetPointError(29,0,0,0,0);
   grae->SetPoint(30,3.8,0.03952397);
   grae->SetPointError(30,0,0,0,0);
   grae->SetPoint(31,3.9,0.04105707);
   grae->SetPointError(31,0,0,0,0);
   grae->SetPoint(32,4,0.04231132);
   grae->SetPointError(32,0,0,0,0);
   
   TH1F *Graph_LimitExpectedCLs11 = new TH1F("Graph_LimitExpectedCLs11","Graph",100,0.48,4.32);
   Graph_LimitExpectedCLs11->SetMinimum(0.01860342);
   Graph_LimitExpectedCLs11->SetMaximum(0.2238012);
   Graph_LimitExpectedCLs11->SetDirectory(0);
   Graph_LimitExpectedCLs11->SetStats(0);
   Graph_LimitExpectedCLs11->SetLineStyle(0);
   Graph_LimitExpectedCLs11->SetMarkerStyle(20);
   Graph_LimitExpectedCLs11->GetXaxis()->SetLabelFont(42);
   Graph_LimitExpectedCLs11->GetXaxis()->SetLabelOffset(0.007);
   Graph_LimitExpectedCLs11->GetXaxis()->SetLabelSize(0.05);
   Graph_LimitExpectedCLs11->GetXaxis()->SetTitleSize(0.06);
   Graph_LimitExpectedCLs11->GetXaxis()->SetTitleOffset(0.9);
   Graph_LimitExpectedCLs11->GetXaxis()->SetTitleFont(42);
   Graph_LimitExpectedCLs11->GetYaxis()->SetLabelFont(42);
   Graph_LimitExpectedCLs11->GetYaxis()->SetLabelOffset(0.007);
   Graph_LimitExpectedCLs11->GetYaxis()->SetLabelSize(0.05);
   Graph_LimitExpectedCLs11->GetYaxis()->SetTitleSize(0.06);
   Graph_LimitExpectedCLs11->GetYaxis()->SetTitleOffset(1.25);
   Graph_LimitExpectedCLs11->GetYaxis()->SetTitleFont(42);
   Graph_LimitExpectedCLs11->GetZaxis()->SetLabelFont(42);
   Graph_LimitExpectedCLs11->GetZaxis()->SetLabelOffset(0.007);
   Graph_LimitExpectedCLs11->GetZaxis()->SetLabelSize(0.05);
   Graph_LimitExpectedCLs11->GetZaxis()->SetTitleSize(0.06);
   Graph_LimitExpectedCLs11->GetZaxis()->SetTitleFont(42);
   grae->SetHistogram(Graph_LimitExpectedCLs11);
   
   grae->Draw("l");
   
   grae = new TGraphAsymmErrors(33);
   grae->SetName("LimitObservedCLs");
   grae->SetTitle("Graph");
   grae->SetFillColor(1);
   grae->SetLineWidth(3);
   grae->SetMarkerStyle(20);
   grae->SetPoint(0,0.8,0.1461216);
   grae->SetPointError(0,0,0,0,0);
   grae->SetPoint(1,0.9,0.2116131);
   grae->SetPointError(1,0,0,0,0);
   grae->SetPoint(2,1,0.211322);
   grae->SetPointError(2,0,0,0,0);
   grae->SetPoint(3,1.1,0.1875527);
   grae->SetPointError(3,0,0,0,0);
   grae->SetPoint(4,1.2,0.1717165);
   grae->SetPointError(4,0,0,0,0);
   grae->SetPoint(5,1.3,0.157716);
   grae->SetPointError(5,0,0,0,0);
   grae->SetPoint(6,1.4,0.1461708);
   grae->SetPointError(6,0,0,0,0);
   grae->SetPoint(7,1.5,0.07651092);
   grae->SetPointError(7,0,0,0,0);
   grae->SetPoint(8,1.6,0.05378435);
   grae->SetPointError(8,0,0,0,0);
   grae->SetPoint(9,1.7,0.05465732);
   grae->SetPointError(9,0,0,0,0);
   grae->SetPoint(10,1.8,0.05057092);
   grae->SetPointError(10,0,0,0,0);
   grae->SetPoint(11,1.9,0.04666594);
   grae->SetPointError(11,0,0,0,0);
   grae->SetPoint(12,2,0.04007694);
   grae->SetPointError(12,0,0,0,0);
   grae->SetPoint(13,2.1,0.03380741);
   grae->SetPointError(13,0,0,0,0);
   grae->SetPoint(14,2.2,0.03390443);
   grae->SetPointError(14,0,0,0,0);
   grae->SetPoint(15,2.3,0.03341679);
   grae->SetPointError(15,0,0,0,0);
   grae->SetPoint(16,2.4,0.03294042);
   grae->SetPointError(16,0,0,0,0);
   grae->SetPoint(17,2.5,0.03263914);
   grae->SetPointError(17,0,0,0,0);
   grae->SetPoint(18,2.6,0.03235971);
   grae->SetPointError(18,0,0,0,0);
   grae->SetPoint(19,2.7,0.03206126);
   grae->SetPointError(19,0,0,0,0);
   grae->SetPoint(20,2.8,0.03194283);
   grae->SetPointError(20,0,0,0,0);
   grae->SetPoint(21,2.9,0.03190459);
   grae->SetPointError(21,0,0,0,0);
   grae->SetPoint(22,3,0.03185823);
   grae->SetPointError(22,0,0,0,0);
   grae->SetPoint(23,3.1,0.03196071);
   grae->SetPointError(23,0,0,0,0);
   grae->SetPoint(24,3.2,0.03221225);
   grae->SetPointError(24,0,0,0,0);
   grae->SetPoint(25,3.3,0.032662);
   grae->SetPointError(25,0,0,0,0);
   grae->SetPoint(26,3.4,0.0332531);
   grae->SetPointError(26,0,0,0,0);
   grae->SetPoint(27,3.5,0.03400285);
   grae->SetPointError(27,0,0,0,0);
   grae->SetPoint(28,3.6,0.03487839);
   grae->SetPointError(28,0,0,0,0);
   grae->SetPoint(29,3.7,0.03613639);
   grae->SetPointError(29,0,0,0,0);
   grae->SetPoint(30,3.8,0.03754754);
   grae->SetPointError(30,0,0,0,0);
   grae->SetPoint(31,3.9,0.03925912);
   grae->SetPointError(31,0,0,0,0);
   grae->SetPoint(32,4,0.04064941);
   grae->SetPointError(32,0,0,0,0);
   
   TH1F *Graph_LimitObservedCLs12 = new TH1F("Graph_LimitObservedCLs12","Graph",100,0.48,4.32);
   Graph_LimitObservedCLs12->SetMinimum(0.01388275);
   Graph_LimitObservedCLs12->SetMaximum(0.2295886);
   Graph_LimitObservedCLs12->SetDirectory(0);
   Graph_LimitObservedCLs12->SetStats(0);
   Graph_LimitObservedCLs12->SetLineStyle(0);
   Graph_LimitObservedCLs12->SetMarkerStyle(20);
   Graph_LimitObservedCLs12->GetXaxis()->SetLabelFont(42);
   Graph_LimitObservedCLs12->GetXaxis()->SetLabelOffset(0.007);
   Graph_LimitObservedCLs12->GetXaxis()->SetLabelSize(0.05);
   Graph_LimitObservedCLs12->GetXaxis()->SetTitleSize(0.06);
   Graph_LimitObservedCLs12->GetXaxis()->SetTitleOffset(0.9);
   Graph_LimitObservedCLs12->GetXaxis()->SetTitleFont(42);
   Graph_LimitObservedCLs12->GetYaxis()->SetLabelFont(42);
   Graph_LimitObservedCLs12->GetYaxis()->SetLabelOffset(0.007);
   Graph_LimitObservedCLs12->GetYaxis()->SetLabelSize(0.05);
   Graph_LimitObservedCLs12->GetYaxis()->SetTitleSize(0.06);
   Graph_LimitObservedCLs12->GetYaxis()->SetTitleOffset(1.25);
   Graph_LimitObservedCLs12->GetYaxis()->SetTitleFont(42);
   Graph_LimitObservedCLs12->GetZaxis()->SetLabelFont(42);
   Graph_LimitObservedCLs12->GetZaxis()->SetLabelOffset(0.007);
   Graph_LimitObservedCLs12->GetZaxis()->SetLabelSize(0.05);
   Graph_LimitObservedCLs12->GetZaxis()->SetTitleSize(0.06);
   Graph_LimitObservedCLs12->GetZaxis()->SetTitleFont(42);
   grae->SetHistogram(Graph_LimitObservedCLs12);
   
   grae->Draw("lp");
   
   TGraph *graph = new TGraph(33);
   graph->SetName("CrossSectionTheo");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);
   graph->SetFillStyle(3344);

   Int_t ci;   // for color index setting
   ci = TColor::GetColor("#ff0000");
   graph->SetLineColor(ci);
   graph->SetLineWidth(2);
   graph->SetMarkerStyle(20);
   graph->SetMarkerSize(2);
   graph->SetPoint(0,0.8,0.8391462258);
   graph->SetPoint(1,0.9,0.6692875677);
   graph->SetPoint(2,1,0.4935922328);
   graph->SetPoint(3,1.1,0.3585249502);
   graph->SetPoint(4,1.2,0.2606523986);
   graph->SetPoint(5,1.3,0.1907222168);
   graph->SetPoint(6,1.4,0.1406891454);
   graph->SetPoint(7,1.5,0.1046467275);
   graph->SetPoint(8,1.6,0.0784837517);
   graph->SetPoint(9,1.7,0.05931460398);
   graph->SetPoint(10,1.8,0.04512820036);
   graph->SetPoint(11,1.9,0.0345604197);
   graph->SetPoint(12,2,0.02662163268);
   graph->SetPoint(13,2.1,0.02061408112);
   graph->SetPoint(14,2.2,0.01603883492);
   graph->SetPoint(15,2.3,0.0125330413);
   graph->SetPoint(16,2.4,0.009831916711);
   graph->SetPoint(17,2.5,0.007739342808);
   graph->SetPoint(18,2.6,0.006111818598);
   graph->SetPoint(19,2.7,0.004840561252);
   graph->SetPoint(20,2.8,0.003843805559);
   graph->SetPoint(21,2.9,0.003063496489);
   graph->SetPoint(22,3,0.002439196354);
   graph->SetPoint(23,3.1,0.001948844607);
   graph->SetPoint(24,3.2,0.001559731801);
   graph->SetPoint(25,3.3,0.001250147311);
   graph->SetPoint(26,3.4,0.001003308023);
   graph->SetPoint(27,3.5,0.0008061085955);
   graph->SetPoint(28,3.6,0.0006482701807);
   graph->SetPoint(29,3.7,0.0005217443947);
   graph->SetPoint(30,3.8,0.0004201883622);
   graph->SetPoint(31,3.9,0.0003386150119);
   graph->SetPoint(32,4,0.0002729762487);
   
   TH1F *Graph_CrossSectionTheo5 = new TH1F("Graph_CrossSectionTheo5","Graph",100,0.48,4.32);
   Graph_CrossSectionTheo5->SetMinimum(0.0002456786);
   Graph_CrossSectionTheo5->SetMaximum(0.9230336);
   Graph_CrossSectionTheo5->SetDirectory(0);
   Graph_CrossSectionTheo5->SetStats(0);
   Graph_CrossSectionTheo5->SetLineStyle(0);
   Graph_CrossSectionTheo5->SetMarkerStyle(20);
   Graph_CrossSectionTheo5->GetXaxis()->SetLabelFont(42);
   Graph_CrossSectionTheo5->GetXaxis()->SetLabelOffset(0.007);
   Graph_CrossSectionTheo5->GetXaxis()->SetLabelSize(0.05);
   Graph_CrossSectionTheo5->GetXaxis()->SetTitleSize(0.06);
   Graph_CrossSectionTheo5->GetXaxis()->SetTitleOffset(0.9);
   Graph_CrossSectionTheo5->GetXaxis()->SetTitleFont(42);
   Graph_CrossSectionTheo5->GetYaxis()->SetLabelFont(42);
   Graph_CrossSectionTheo5->GetYaxis()->SetLabelOffset(0.007);
   Graph_CrossSectionTheo5->GetYaxis()->SetLabelSize(0.05);
   Graph_CrossSectionTheo5->GetYaxis()->SetTitleSize(0.06);
   Graph_CrossSectionTheo5->GetYaxis()->SetTitleOffset(1.25);
   Graph_CrossSectionTheo5->GetYaxis()->SetTitleFont(42);
   Graph_CrossSectionTheo5->GetZaxis()->SetLabelFont(42);
   Graph_CrossSectionTheo5->GetZaxis()->SetLabelOffset(0.007);
   Graph_CrossSectionTheo5->GetZaxis()->SetLabelSize(0.05);
   Graph_CrossSectionTheo5->GetZaxis()->SetTitleSize(0.06);
   Graph_CrossSectionTheo5->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_CrossSectionTheo5);
   
   graph->Draw("c");
   
   graph = new TGraph(33);
   graph->SetName("CrossSectionTheoA");
   graph->SetTitle("Graph");
   graph->SetFillColor(1);
   graph->SetFillStyle(3344);

   ci = TColor::GetColor("#0000ff");
   graph->SetLineColor(ci);
   graph->SetLineWidth(2);
   graph->SetMarkerStyle(20);
   graph->SetMarkerSize(2);
   graph->SetPoint(0,0.8,1.210370653);
   graph->SetPoint(1,0.9,0.7439371843);
   graph->SetPoint(2,1,0.477853862);
   graph->SetPoint(3,1.1,0.3176991013);
   graph->SetPoint(4,1.2,0.2171533002);
   graph->SetPoint(5,1.3,0.1518582504);
   graph->SetPoint(6,1.4,0.1082250923);
   graph->SetPoint(7,1.5,0.07835871118);
   graph->SetPoint(8,1.6,0.05751605956);
   graph->SetPoint(9,1.7,0.0427130877);
   graph->SetPoint(10,1.8,0.03203083395);
   graph->SetPoint(11,1.9,0.02423542874);
   graph->SetPoint(12,2,0.01847867238);
   graph->SetPoint(13,2.1,0.01418458516);
   graph->SetPoint(14,2.2,0.01095391934);
   graph->SetPoint(15,2.3,0.008504091342);
   graph->SetPoint(16,2.4,0.00663349814);
   graph->SetPoint(17,2.5,0.005195696584);
   graph->SetPoint(18,2.6,0.004085063741);
   graph->SetPoint(19,2.7,0.003222757614);
   graph->SetPoint(20,2.8,0.002550224854);
   graph->SetPoint(21,2.9,0.002026171204);
   graph->SetPoint(22,3,0.001608744163);
   graph->SetPoint(23,3.1,0.00128207924);
   graph->SetPoint(24,3.2,0.001023739692);
   graph->SetPoint(25,3.3,0.0008188355974);
   graph->SetPoint(26,3.4,0.0006559035189);
   graph->SetPoint(27,3.5,0.0005260696099);
   graph->SetPoint(28,3.6,0.0004223902137);
   graph->SetPoint(29,3.7,0.0003394526026);
   graph->SetPoint(30,3.8,0.0002730104881);
   graph->SetPoint(31,3.9,0.0002197360055);
   graph->SetPoint(32,4,0.0001769368029);
   
   TH1F *Graph_CrossSectionTheoA6 = new TH1F("Graph_CrossSectionTheoA6","Graph",100,0.48,4.32);
   Graph_CrossSectionTheoA6->SetMinimum(0.0001592431);
   Graph_CrossSectionTheoA6->SetMaximum(1.33139);
   Graph_CrossSectionTheoA6->SetDirectory(0);
   Graph_CrossSectionTheoA6->SetStats(0);
   Graph_CrossSectionTheoA6->SetLineStyle(0);
   Graph_CrossSectionTheoA6->SetMarkerStyle(20);
   Graph_CrossSectionTheoA6->GetXaxis()->SetLabelFont(42);
   Graph_CrossSectionTheoA6->GetXaxis()->SetLabelOffset(0.007);
   Graph_CrossSectionTheoA6->GetXaxis()->SetLabelSize(0.05);
   Graph_CrossSectionTheoA6->GetXaxis()->SetTitleSize(0.06);
   Graph_CrossSectionTheoA6->GetXaxis()->SetTitleOffset(0.9);
   Graph_CrossSectionTheoA6->GetXaxis()->SetTitleFont(42);
   Graph_CrossSectionTheoA6->GetYaxis()->SetLabelFont(42);
   Graph_CrossSectionTheoA6->GetYaxis()->SetLabelOffset(0.007);
   Graph_CrossSectionTheoA6->GetYaxis()->SetLabelSize(0.05);
   Graph_CrossSectionTheoA6->GetYaxis()->SetTitleSize(0.06);
   Graph_CrossSectionTheoA6->GetYaxis()->SetTitleOffset(1.25);
   Graph_CrossSectionTheoA6->GetYaxis()->SetTitleFont(42);
   Graph_CrossSectionTheoA6->GetZaxis()->SetLabelFont(42);
   Graph_CrossSectionTheoA6->GetZaxis()->SetLabelOffset(0.007);
   Graph_CrossSectionTheoA6->GetZaxis()->SetLabelSize(0.05);
   Graph_CrossSectionTheoA6->GetZaxis()->SetTitleSize(0.06);
   Graph_CrossSectionTheoA6->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_CrossSectionTheoA6);
   
   graph->Draw("c");
   
   TLegend *leg = new TLegend(0.3724832,0.5963455,0.8875839,0.7973422,NULL,"brNDC");
   leg->SetBorderSize(0);
   leg->SetTextSize(0.031);
   leg->SetLineColor(1);
   leg->SetLineStyle(1);
   leg->SetLineWidth(1);
   leg->SetFillColor(0);
   leg->SetFillStyle(1001);
   TLegendEntry *entry=leg->AddEntry("LimitObservedCLs","Asympt. CL_{S} Observed","LP");
   entry->SetLineColor(1);
   entry->SetLineStyle(1);
   entry->SetLineWidth(3);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(20);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("Limit68CLs","Asympt. CL_{S} Expected #pm 1#sigma","LF");
   entry->SetFillColor(3);
   entry->SetFillStyle(1001);
   entry->SetLineColor(1);
   entry->SetLineStyle(2);
   entry->SetLineWidth(3);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(21);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("Limit95CLs","Asympt. CL_{S} Expected #pm 2#sigma","LF");
   entry->SetFillColor(5);
   entry->SetFillStyle(1001);
   entry->SetLineColor(1);
   entry->SetLineStyle(2);
   entry->SetLineWidth(3);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(21);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("CrossSectionTheo","HVT_{B} (g_{V}=3)","L");

   ci = TColor::GetColor("#ff0000");
   entry->SetLineColor(ci);
   entry->SetLineStyle(1);
   entry->SetLineWidth(2);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(21);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("CrossSectionTheoA","HVT_{A} (g_{V}=1)","L");

   ci = TColor::GetColor("#0000ff");
   entry->SetLineColor(ci);
   entry->SetLineStyle(1);
   entry->SetLineWidth(2);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(21);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   leg->Draw();
   TLatex *   tex = new TLatex(0.93,0.944,"2.3 fb^{-1} (13 TeV)");
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
      tex = new TLatex(0.234,0.944,"Preliminary");
tex->SetNDC();
   tex->SetTextFont(52);
   tex->SetTextSize(0.02548);
   tex->SetLineWidth(2);
   tex->Draw();
   
   TH1F *hframe__8 = new TH1F("hframe__8","",1000,0.75,4.05);
   hframe__8->SetMinimum(0.001);
   hframe__8->SetMaximum(100);
   hframe__8->SetDirectory(0);
   hframe__8->SetStats(0);
   hframe__8->SetLineStyle(0);
   hframe__8->SetMarkerStyle(20);
   hframe__8->GetXaxis()->SetTitle("M_{Z'} (TeV)");
   hframe__8->GetXaxis()->SetLabelFont(42);
   hframe__8->GetXaxis()->SetLabelOffset(0.007);
   hframe__8->GetXaxis()->SetLabelSize(0.035);
   hframe__8->GetXaxis()->SetTitleSize(0.045);
   hframe__8->GetXaxis()->SetTitleOffset(1.1);
   hframe__8->GetXaxis()->SetTitleFont(42);
   hframe__8->GetYaxis()->SetTitle("#sigma_{95%} #times BR_{Z' #rightarrow WW/ZH} (pb)");
   hframe__8->GetYaxis()->SetLabelFont(42);
   hframe__8->GetYaxis()->SetLabelOffset(0.007);
   hframe__8->GetYaxis()->SetLabelSize(0.035);
   hframe__8->GetYaxis()->SetTitleSize(0.045);
   hframe__8->GetYaxis()->SetTitleOffset(1.1);
   hframe__8->GetYaxis()->SetTitleFont(42);
   hframe__8->GetZaxis()->SetLabelFont(42);
   hframe__8->GetZaxis()->SetLabelOffset(0.007);
   hframe__8->GetZaxis()->SetLabelSize(0.05);
   hframe__8->GetZaxis()->SetTitleSize(0.06);
   hframe__8->GetZaxis()->SetTitleFont(42);
   hframe__8->Draw("sameaxis");
   
   TH1F *hframe__9 = new TH1F("hframe__9","",1000,0.75,4.05);
   hframe__9->SetMinimum(0.001);
   hframe__9->SetMaximum(100);
   hframe__9->SetDirectory(0);
   hframe__9->SetStats(0);
   hframe__9->SetLineStyle(0);
   hframe__9->SetMarkerStyle(20);
   hframe__9->GetXaxis()->SetTitle("M_{Z'} (TeV)");
   hframe__9->GetXaxis()->SetLabelFont(42);
   hframe__9->GetXaxis()->SetLabelOffset(0.007);
   hframe__9->GetXaxis()->SetLabelSize(0.035);
   hframe__9->GetXaxis()->SetTitleSize(0.045);
   hframe__9->GetXaxis()->SetTitleOffset(1.1);
   hframe__9->GetXaxis()->SetTitleFont(42);
   hframe__9->GetYaxis()->SetTitle("#sigma_{95%} #times BR_{Z' #rightarrow WW/ZH} (pb)");
   hframe__9->GetYaxis()->SetLabelFont(42);
   hframe__9->GetYaxis()->SetLabelOffset(0.007);
   hframe__9->GetYaxis()->SetLabelSize(0.035);
   hframe__9->GetYaxis()->SetTitleSize(0.045);
   hframe__9->GetYaxis()->SetTitleOffset(1.1);
   hframe__9->GetYaxis()->SetTitleFont(42);
   hframe__9->GetZaxis()->SetLabelFont(42);
   hframe__9->GetZaxis()->SetLabelOffset(0.007);
   hframe__9->GetZaxis()->SetLabelSize(0.05);
   hframe__9->GetZaxis()->SetTitleSize(0.06);
   hframe__9->GetZaxis()->SetTitleFont(42);
   hframe__9->Draw("sameaxig");
   
   leg = new TLegend(0.3724832,0.5963455,0.8875839,0.7973422,NULL,"brNDC");
   leg->SetBorderSize(0);
   leg->SetTextSize(0.031);
   leg->SetLineColor(1);
   leg->SetLineStyle(1);
   leg->SetLineWidth(1);
   leg->SetFillColor(0);
   leg->SetFillStyle(1001);
   entry=leg->AddEntry("LimitObservedCLs","Asympt. CL_{S} Observed","LP");
   entry->SetLineColor(1);
   entry->SetLineStyle(1);
   entry->SetLineWidth(3);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(20);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("Limit68CLs","Asympt. CL_{S} Expected #pm 1#sigma","LF");
   entry->SetFillColor(3);
   entry->SetFillStyle(1001);
   entry->SetLineColor(1);
   entry->SetLineStyle(2);
   entry->SetLineWidth(3);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(21);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("Limit95CLs","Asympt. CL_{S} Expected #pm 2#sigma","LF");
   entry->SetFillColor(5);
   entry->SetFillStyle(1001);
   entry->SetLineColor(1);
   entry->SetLineStyle(2);
   entry->SetLineWidth(3);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(21);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("CrossSectionTheo","HVT_{B} (g_{V}=3)","L");

   ci = TColor::GetColor("#ff0000");
   entry->SetLineColor(ci);
   entry->SetLineStyle(1);
   entry->SetLineWidth(2);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(21);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("CrossSectionTheoA","HVT_{A} (g_{V}=1)","L");

   ci = TColor::GetColor("#0000ff");
   entry->SetLineColor(ci);
   entry->SetLineStyle(1);
   entry->SetLineWidth(2);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(21);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   leg->Draw();
   
   TPaveText *pt = new TPaveText(0.5486577,0.8355482,0.8993289,0.8920266,"brNDC");
   pt->SetBorderSize(0);
   pt->SetFillColor(0);
   pt->SetFillStyle(0);
   pt->SetTextAlign(32);
   pt->SetTextFont(42);
   pt->SetTextSize(0.031);
   text = pt->AddText("llbb/vvbb (13 TeV)");
   text->SetTextFont(62);
   pt->Draw();
   c_lim_Asymptotic->Modified();
   c_lim_Asymptotic->cd();
   c_lim_Asymptotic->SetSelected(c_lim_Asymptotic);
}
