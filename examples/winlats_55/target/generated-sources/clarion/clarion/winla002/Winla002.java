package clarion.winla002;

import clarion.Bankas_k;
import clarion.Main;
import clarion.Par_k;
import clarion.equates.Appstrat;
import clarion.equates.Button;
import clarion.equates.Color;
import clarion.equates.Constants;
import clarion.equates.Cursor;
import clarion.equates.Event;
import clarion.equates.Prop;
import clarion.equates.Record;
import clarion.equates.Scrollsort;
import clarion.equates.Warn;
import clarion.rescode.Windowresizetype;
import clarion.winla002.Browsebuttons;
import clarion.winla002.Brw1ViewBrowse;
import clarion.winla002.ProcessView;
import clarion.winla002.Progresswindow;
import clarion.winla002.Progresswindow_1;
import clarion.winla002.QueueBrowse_1;
import clarion.winla002.Quickwindow;
import clarion.winla002.Quickwindow_1;
import clarion.winla002.Report;
import clarion.winla043.Winla043;
import clarion.winla_rd.Winla_rd;
import clarion.winla_ru.Winla_ru;
import clarion.winla_sf.Winla_sf;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionRoutineResult;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CConfig;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Winla002
{
	public static Bankas_k updatebankas_k_historyBanRecord;
	public static ClarionNumber updatebankas_k_windowxpos;
	public static ClarionNumber updatebankas_k_windowypos;
	public static ClarionBool updatebankas_k_windowposinit;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		__static_init();
	}

	public static void __static_init() {
		updatebankas_k_historyBanRecord=new Bankas_k();
		updatebankas_k_windowxpos=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		updatebankas_k_windowypos=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		updatebankas_k_windowposinit=Clarion.newBool(Constants.FALSE);
	}


	public static void f_bankasreport()
	{
		ClarionNumber rejectrecord=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber localresponse=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber windowopened=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber recordstoprocess=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber recordsprocessed=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber recordspercycle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber recordsthiscycle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber percentprogress=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber recordstatus=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber dat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lai=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString pdfout=Clarion.newString(100);
		ClarionView processView=new ProcessView();
		Report report=new Report(dat,lai);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Progresswindow progresswindow=new Progresswindow(progressThermometer);
		ClarionBool printskipdetails=Clarion.newBool();
		ClarionNumber _j_number=Clarion.newNumber();
		ClarionNumber _i_number=Clarion.newNumber();
		try {
			CExpression.pushBind();
			Main.opcija.setValue("0");
			if (Main.globalresponse.equals(Constants.REQUESTCANCELLED)) {
				System.out.println("F_BankasReport RequestCancelled");
				try {
					f_bankasreport_procedurereturn(filesopened,localresponse);
				} catch (ClarionRoutineResult _crr) {
					return;
				}
			}
			dat.setValue(CDate.today());
			lai.setValue(CDate.clock());
			localrequest.setValue(Main.globalrequest);
			localresponse.setValue(Constants.REQUESTCANCELLED);
			Main.globalrequest.clear();
			Main.globalresponse.clear();
			if (Main.bankas_kUsed.equals(0)) {
				Winla_sf.checkopen(Main.bankas_k,Clarion.newNumber(1));
			}
			Main.bankas_kUsed.increment(1);
			CExpression.bind(Main.bankas_k);
			filesopened.setValue(Constants.TRUE);
			recordstoprocess.setValue(Main.bankas_k.records());
			recordspercycle.setValue(25);
			recordsprocessed.setValue(0);
			percentprogress.setValue(0);
			progresswindow.open();
			progressThermometer.setValue(0);
			Clarion.getControl(progresswindow._progressPcttext).setProperty(Prop.TEXT,"0%");
			progresswindow.setProperty(Prop.TEXT,"Bankas");
			Clarion.getControl(progresswindow._progressUserstring).setProperty(Prop.TEXT,"");
			Main.bankas_k.send("QUICKSCAN=on");
			System.out.println("F_BankasReport Accept");
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_1=CWin.event();
					boolean case_1_break=false;
					if (case_1==Event.OPENWINDOW) {
						Main.bankas_k.nos_key.setStart();
						processView.setProperty(Prop.FILTER,"");
						if (CError.errorCode()!=0) {
							Winla_sf.standardwarning(Clarion.newNumber(Warn.VIEWOPENERROR));
						}
						processView.open();
						if (CError.errorCode()!=0) {
							Winla_sf.standardwarning(Clarion.newNumber(Warn.VIEWOPENERROR));
						}
						while (true) {
							f_bankasreport_getnextrecord(processView,localresponse,recordsprocessed,recordsthiscycle,percentprogress,recordstoprocess,progressThermometer,progresswindow);
							f_bankasreport_validaterecord(recordstatus,localresponse);
							{
								ClarionNumber case_2=recordstatus;
								boolean case_2_break=false;
								if (case_2.equals(Record.OK)) {
									break;
									// UNREACHABLE! :case_2_break=true;
								}
								if (!case_2_break && case_2.equals(Record.OUTOFRANGE)) {
									localresponse.setValue(Constants.REQUESTCANCELLED);
									break;
									// UNREACHABLE! :case_2_break=true;
								}
							}
						}
						if (localresponse.equals(Constants.REQUESTCANCELLED)) {
							CWin.post(Event.CLOSEWINDOW);
							continue;
						}
						Main.printpreviewqueue.printpreviewimage.setValue("report001.wmf");
						System.out.println("F_BankasReport opening report "+Main.printpreviewqueue.printpreviewimage.toString());
						report.open();
						report.setClonedProperty(Prop.PREVIEW,Main.printpreviewqueue.printpreviewimage);
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.TIMER) {
						for (int loop_1=recordspercycle.intValue();loop_1>0;loop_1--) {
							printskipdetails.setValue(Constants.FALSE);
							if (!printskipdetails.boolValue()) {
								System.out.println("F_BankasReport print detail");
								report.detail.print();
							}
							while (true) {
								f_bankasreport_getnextrecord(processView,localresponse,recordsprocessed,recordsthiscycle,percentprogress,recordstoprocess,progressThermometer,progresswindow);
								f_bankasreport_validaterecord(recordstatus,localresponse);
								{
									ClarionNumber case_3=recordstatus;
									boolean case_3_break=false;
									if (case_3.equals(Record.OUTOFRANGE)) {
										localresponse.setValue(Constants.REQUESTCANCELLED);
										break;
										// UNREACHABLE! :case_3_break=true;
									}
									if (!case_3_break && case_3.equals(Record.OK)) {
										break;
										// UNREACHABLE! :case_3_break=true;
									}
								}
							}
							if (localresponse.equals(Constants.REQUESTCANCELLED)) {
								localresponse.setValue(Constants.REQUESTCOMPLETED);
								break;
							}
							localresponse.setValue(Constants.REQUESTCANCELLED);
						}
						if (localresponse.equals(Constants.REQUESTCOMPLETED)) {
							progresswindow.close();
							break;
						}
						case_1_break=true;
					}
				}
				{
					int case_4=CWin.field();
					if (case_4==progresswindow._progressCancel) {
						{
							int case_5=CWin.event();
							if (case_5==Event.ACCEPTED) {
								localresponse.setValue(Constants.REQUESTCANCELLED);
								CWin.post(Event.CLOSEWINDOW);
							}
						}
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			System.out.println("F_BankasReport out of screen loop");
			if (localresponse.equals(Constants.REQUESTCOMPLETED)) {
				report.detail1.print();
				report.endPage();
				progresswindow.close();
				System.out.println("F_BankasReport progresswindow closed");
				if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
					final ClarionNumber loop_3=Main.prSkaits.like();for (_j_number.setValue(1);_j_number.compareTo(loop_3)<=0;_j_number.increment(1)) {
						report.setProperty(Prop.FLUSHPREVIEW,Constants.TRUE);
						if (!_j_number.equals(Main.prSkaits)) {
							final int loop_2=Main.printpreviewqueue1.records();for (_i_number.setValue(1);_i_number.compareTo(loop_2)<=0;_i_number.increment(1)) {
								Main.printpreviewqueue1.get(_i_number);
								Main.printpreviewqueue.printpreviewimage.setValue(Main.printpreviewqueue1.printpreviewimage1);
								Main.printpreviewqueue.add();
							}
						}
					}
				}
			}
			pdfout.setValue(report.getPDF());
			System.out.println(pdfout.toString());
			report.writePDF();
			report.previewPDF();
			System.out.println("F_BankasReport closing report");
			report.close();
			Main.printpreviewqueue.free();
			Main.printpreviewqueue1.free();
			System.out.println("F_BankasReport report closed, Do procedureReturn");
			try {
				f_bankasreport_procedurereturn(filesopened,localresponse);
			} catch (ClarionRoutineResult _crr) {
				return;
			}
		} finally {
			report.close();
			progresswindow.close();
		}
	}
	public static void f_bankasreport_procedurereturn(ClarionNumber filesopened,ClarionNumber localresponse) throws ClarionRoutineResult
	{
		if (filesopened.boolValue()) {
			Main.bankas_kUsed.decrement(1);
			if (Main.bankas_kUsed.equals(0)) {
				Main.bankas_k.close();
			}
		}
		if (localresponse.boolValue()) {
			Main.globalresponse.setValue(localresponse);
		}
		else {
			Main.globalresponse.setValue(Constants.REQUESTCANCELLED);
		}
		CExpression.popBind();
		throw new ClarionRoutineResult();
	}
	public static void f_bankasreport_validaterecord(ClarionNumber recordstatus,ClarionNumber localresponse)
	{
		recordstatus.setValue(Record.OUTOFRANGE);
		if (localresponse.equals(Constants.REQUESTCANCELLED)) {
			return;
		}
		recordstatus.setValue(Record.OK);
		return;
	}
	public static void f_bankasreport_getnextrecord(ClarionView processView,ClarionNumber localresponse,ClarionNumber recordsprocessed,ClarionNumber recordsthiscycle,ClarionNumber percentprogress,ClarionNumber recordstoprocess,ClarionNumber progressThermometer,Progresswindow progresswindow)
	{
		processView.next();
		if (CError.errorCode()!=0) {
			if (CError.errorCode()!=Constants.BADRECERR) {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("BANKAS_K"));
			}
			localresponse.setValue(Constants.REQUESTCANCELLED);
			return;
		}
		else {
			localresponse.setValue(Constants.REQUESTCOMPLETED);
		}
		recordsprocessed.increment(1);
		recordsthiscycle.increment(1);
		if (percentprogress.compareTo(100)<0) {
			percentprogress.setValue(recordsprocessed.divide(recordstoprocess).multiply(100));
			if (percentprogress.compareTo(100)>0) {
				percentprogress.setValue(100);
			}
			if (!percentprogress.equals(progressThermometer)) {
				progressThermometer.setValue(percentprogress);
				Clarion.getControl(progresswindow._progressPcttext).setProperty(Prop.TEXT,percentprogress.getString().format("@N3").concat("%"));
				CWin.display();
			}
		}
	}
	public static void updatebankas_k()
	{
		ClarionString currenttab=Clarion.newString(80);
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber originalrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber localresponse=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber windowopened=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber windowinitialized=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber forcerefresh=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString actionmessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionNumber recordchanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Par_k par_record=new Par_k();
		ClarionString par_position=Clarion.newString(260);
		ClarionString old_kods=Clarion.newString(15);
		ClarionNumber recordstoprocess=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber recordsprocessed=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber recordspercycle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber recordsthiscycle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber percentprogress=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Progresswindow_1 progresswindow=new Progresswindow_1(progressThermometer);
		ClarionNumber updateReloop=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber updateError=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Bankas_k savBanRecord=new Bankas_k();
		ClarionNumber toolbarmode=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		Windowresizetype winresize=new Windowresizetype();
		Quickwindow quickwindow=new Quickwindow();
		try {
			CExpression.pushBind();
			localrequest.setValue(Main.globalrequest);
			originalrequest.setValue(Main.globalrequest);
			localresponse.setValue(Constants.REQUESTCANCELLED);
			forcerefresh.setValue(Constants.FALSE);
			Main.globalrequest.clear();
			Main.globalresponse.clear();
			old_kods.setValue(Main.bankas_k.kods);
			if (CWin.keyCode()==Constants.MOUSERIGHT) {
				CWin.setKeyCode(0);
			}
			try {
				updatebankas_k_prepareprocedure(filesopened,savBanRecord,localrequest,localresponse,quickwindow,windowopened,winresize,old_kods,par_record,par_position,recordstoprocess,recordspercycle,recordsprocessed,percentprogress,progresswindow,progressThermometer,recordsthiscycle);
			} catch (ClarionRoutineResult _crr) {
				return;
			}
			actionmessage.setValue("Aplūkošanas režīms");
			{
				ClarionNumber case_1=localrequest;
				boolean case_1_break=false;
				if (case_1.equals(Constants.INSERTRECORD)) {
					actionmessage.setValue("Ieraksts tiks pievienots");
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
					actionmessage.setValue("Ieraksts tiks mainīts");
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
					case_1_break=true;
				}
			}
			quickwindow.setClonedProperty(Prop.TEXT,actionmessage);
			CWin.enable(Constants.TBARBRWHISTORY);
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_2=CWin.event();
					boolean case_2_break=false;
					if (case_2==Event.ALERTKEY) {
						if (CWin.keyCode()==734) {
							updatebankas_k_historyfield(quickwindow);
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==Event.CLOSEWINDOW) {
						updatebankas_k_closingwindow(updateReloop,localresponse);
						if (updateReloop.boolValue()) {
							continue;
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==Event.CLOSEDOWN) {
						updatebankas_k_closingwindow(updateReloop,localresponse);
						if (updateReloop.boolValue()) {
							continue;
						}
						winresize.destroy();
						case_2_break=true;
					}
					if (!case_2_break && case_2==Event.OPENWINDOW) {
						updatebankas_k_formAssignbuttons(toolbarmode,originalrequest);
						if (!windowinitialized.boolValue()) {
							updatebankas_k_initializewindow(quickwindow,forcerefresh);
							windowinitialized.setValue(Constants.TRUE);
						}
						CWin.select(quickwindow._banNos_pPrompt);
						if (localrequest.equals(3)) {
							quickwindow.setProperty(Prop.COLOR,Color.ACTIVEBORDER);
							CWin.disable(1,quickwindow._cancel-2);
							CWin.enable(quickwindow._tab_1);
							CWin.select(quickwindow._cancel);
						}
						else if (localrequest.equals(0)) {
							quickwindow.setProperty(Prop.COLOR,Color.ACTIVEBORDER);
							CWin.disable(1,quickwindow._cancel-1);
							CWin.enable(quickwindow._tab_1);
							CWin.select(quickwindow._cancel);
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==Event.GAINFOCUS) {
						forcerefresh.setValue(Constants.TRUE);
						if (!windowinitialized.boolValue()) {
							updatebankas_k_initializewindow(quickwindow,forcerefresh);
							windowinitialized.setValue(Constants.TRUE);
						}
						else {
							updatebankas_k_refreshwindow(quickwindow,forcerefresh);
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==Event.SIZED) {
						winresize.resize();
						forcerefresh.setValue(Constants.TRUE);
						updatebankas_k_refreshwindow(quickwindow,forcerefresh);
						case_2_break=true;
					}
					if (!case_2_break && case_2==Event.REJECTED) {
						CWin.beep();
						CWin.display(CWin.field());
						CWin.select(CWin.field());
						case_2_break=true;
					}
					if (!case_2_break) {
						if (CWin.accepted()==Constants.TBARBRWHISTORY) {
							updatebankas_k_historyfield(quickwindow);
						}
						if (CWin.event()==Event.COMPLETED) {
							Winla002.updatebankas_k_historyBanRecord.setValue(Main.bankas_k.getString());
							{
								ClarionNumber case_3=localrequest;
								boolean case_3_break=false;
								if (case_3.equals(Constants.INSERTRECORD)) {
									Main.bankas_k.add();
									{
										int case_4=CError.errorCode();
										boolean case_4_break=false;
										if (case_4==Constants.NOERROR) {
											localresponse.setValue(Constants.REQUESTCOMPLETED);
											CWin.post(Event.CLOSEWINDOW);
											case_4_break=true;
										}
										if (!case_4_break && case_4==Constants.DUPKEYERR) {
											if (Main.bankas_k.kod_key.duplicateCheck()) {
												if (Winla_sf.standardwarning(Clarion.newNumber(Warn.DUPLICATEKEY),Clarion.newString("BAN:KOD_KEY")).boolValue()) {
													CWin.select(quickwindow._banNos_pPrompt);
													Main.vcrrequest.setValue(Constants.VCRNONE);
													continue;
												}
											}
											case_4_break=true;
										}
										if (!case_4_break) {
											if (Winla_sf.standardwarning(Clarion.newNumber(Warn.INSERTERROR)).boolValue()) {
												CWin.select(quickwindow._banNos_pPrompt);
												Main.vcrrequest.setValue(Constants.VCRNONE);
												continue;
											}
										}
									}
									case_3_break=true;
								}
								if (!case_3_break && case_3.equals(Constants.CHANGERECORD)) {
									while (true) {
										localresponse.setValue(Constants.REQUESTCANCELLED);
										CWin.setCursor(Cursor.WAIT);
										recordchanged.setValue(Constants.FALSE);
										if (!savBanRecord.getString().equals(Main.bankas_k.getString())) {
											recordchanged.setValue(Constants.TRUE);
										}
										if (recordchanged.boolValue()) {
											updateError.setValue(Winla_ru.riupdateBankas_k(Clarion.newNumber(1)));
										}
										else {
											updateError.setValue(0);
										}
										CWin.setCursor(null);
										if (updateError.boolValue()) {
											if (updateError.equals(1)) {
												{
													ClarionNumber case_5=Winla_sf.standardwarning(Clarion.newNumber(Warn.UPDATEERROR));
													boolean case_5_break=false;
													if (case_5.equals(Button.YES)) {
														continue;
														// UNREACHABLE! :case_5_break=true;
													}
													if (!case_5_break && case_5.equals(Button.NO)) {
														CWin.post(Event.CLOSEWINDOW);
														break;
														// UNREACHABLE! :case_5_break=true;
													}
												}
											}
											CWin.display();
											CWin.select(quickwindow._banNos_pPrompt);
											Main.vcrrequest.setValue(Constants.VCRNONE);
										}
										else {
											if (recordchanged.boolValue() || Main.vcrrequest.equals(Constants.VCRNONE)) {
												localresponse.setValue(Constants.REQUESTCOMPLETED);
											}
											CWin.post(Event.CLOSEWINDOW);
										}
										break;
									}
									case_3_break=true;
								}
							}
						}
						if (toolbarmode.equals(Constants.FORMMODE)) {
							{
								int case_6=CWin.accepted();
								boolean case_6_break=false;
								boolean case_6_match=false;
								case_6_match=false;
								if (case_6>=Constants.TBARBRWBOTTOM && case_6<=Constants.TBARBRWUP) {
									case_6_match=true;
								}
								if (case_6_match || case_6==Constants.TBARBRWINSERT) {
									Main.vcrrequest.setValue(CWin.accepted());
									CWin.post(Event.COMPLETED);
									case_6_break=true;
								}
								case_6_match=false;
								if (!case_6_break && case_6==Constants.TBARBRWHELP) {
									CWin.pressKey(Constants.F1KEY);
									case_6_break=true;
								}
							}
						}
					}
				}
				{
					int case_7=CWin.field();
					boolean case_7_break=false;
					if (case_7==quickwindow._currenttab) {
						{
							int case_8=CWin.event();
							boolean case_8_break=false;
							if (case_8==Event.ACCEPTED) {
								updatebankas_k_refreshwindow(quickwindow,forcerefresh);
								case_8_break=true;
							}
							if (!case_8_break && case_8==Event.NEWSELECTION) {
								{
									int case_9=CWin.choice(quickwindow._currenttab);
									if (case_9==1) {
										updatebankas_k_formAssignbuttons(toolbarmode,originalrequest);
									}
								}
								updatebankas_k_refreshwindow(quickwindow,forcerefresh);
								case_8_break=true;
							}
							if (!case_8_break && case_8==Event.TABCHANGING) {
								updatebankas_k_refreshwindow(quickwindow,forcerefresh);
								case_8_break=true;
							}
							if (!case_8_break && case_8==Event.SELECTED) {
								updatebankas_k_refreshwindow(quickwindow,forcerefresh);
								case_8_break=true;
							}
						}
						case_7_break=true;
					}
					if (!case_7_break && case_7==quickwindow._banNos_s) {
						{
							int case_10=CWin.event();
							if (case_10==Event.ACCEPTED) {
								Main.bankas_k.nos_a.setValue(Winla043.inigen(Main.bankas_k.nos_s.like(),Clarion.newNumber(4),Clarion.newNumber(1)));
								CWin.display(quickwindow._banNos_a);
							}
						}
						case_7_break=true;
					}
					if (!case_7_break && case_7==quickwindow._ok) {
						{
							int case_11=CWin.event();
							if (case_11==Event.ACCEPTED) {
								updatebankas_k_syncwindow();
								if (originalrequest.equals(Constants.CHANGERECORD) || originalrequest.equals(Constants.INSERTRECORD)) {
									CWin.select();
								}
								else {
									CWin.post(Event.COMPLETED);
								}
							}
						}
						case_7_break=true;
					}
					if (!case_7_break && case_7==quickwindow._cancel) {
						{
							int case_12=CWin.event();
							if (case_12==Event.ACCEPTED) {
								updatebankas_k_syncwindow();
								localresponse.setValue(Constants.REQUESTCANCELLED);
								Main.vcrrequest.setValue(Constants.VCRNONE);
								CWin.post(Event.CLOSEWINDOW);
							}
						}
						case_7_break=true;
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			try {
				updatebankas_k_procedurereturn(filesopened,old_kods,localrequest,par_record,par_position,recordstoprocess,recordspercycle,recordsprocessed,percentprogress,progresswindow,progressThermometer,recordsthiscycle,windowopened,quickwindow,localresponse);
			} catch (ClarionRoutineResult _crr) {
				return;
			}
		} finally {
			progresswindow.close();
			quickwindow.close();
		}
	}
	public static void updatebankas_k_closingwindow(ClarionNumber updateReloop,ClarionNumber localresponse)
	{
		updateReloop.setValue(0);
		if (!localresponse.equals(Constants.REQUESTCOMPLETED)) {
			updatebankas_k_cancelautoincrement(localresponse);
		}
	}
	public static void updatebankas_k_procedurereturn(ClarionNumber filesopened,ClarionString old_kods,ClarionNumber localrequest,Par_k par_record,ClarionString par_position,ClarionNumber recordstoprocess,ClarionNumber recordspercycle,ClarionNumber recordsprocessed,ClarionNumber percentprogress,Progresswindow_1 progresswindow,ClarionNumber progressThermometer,ClarionNumber recordsthiscycle,ClarionNumber windowopened,Quickwindow quickwindow,ClarionNumber localresponse) throws ClarionRoutineResult
	{
		if (filesopened.boolValue()) {
			if (!Main.bankas_k.kods.equals(old_kods) && !old_kods.equals("") && localrequest.equals(2)) {
				Winla043.kluda(Clarion.newNumber(109),Clarion.newString(""));
				if (Main.klu_darbiba.boolValue()) {
					par_record.setValue(Main.par_k.getString());
					par_position.setValue(Main.par_k.getPosition());
					Winla_sf.checkopen(Main.par_k);
					Main.par_k.set();
					recordstoprocess.setValue(Main.par_k.records());
					recordspercycle.setValue(25);
					recordsprocessed.setValue(0);
					percentprogress.setValue(0);
					progresswindow.open();
					progressThermometer.setValue(0);
					Clarion.getControl(progresswindow._progressPcttext).setProperty(Prop.TEXT,"0% Izpild�ti");
					progresswindow.setProperty(Prop.TEXT,"Mainam bankas kodu partneriem");
					Clarion.getControl(progresswindow._progressUserstring).setProperty(Prop.TEXT,"");
					while (true) {
						Main.par_k.next();
						if (CError.error().length()!=0) {
							break;
						}
						recordsprocessed.increment(1);
						recordsthiscycle.increment(1);
						if (percentprogress.compareTo(100)<0) {
							percentprogress.setValue(recordsprocessed.divide(recordstoprocess).multiply(100));
							if (percentprogress.compareTo(100)>0) {
								percentprogress.setValue(100);
							}
							if (!percentprogress.equals(progressThermometer)) {
								progressThermometer.setValue(percentprogress);
								Clarion.getControl(progresswindow._progressPcttext).setProperty(Prop.TEXT,percentprogress.getString().format("@N3").concat("% Izpild�ti"));
								CWin.display();
							}
						}
						if (Main.par_k.ban_kods.equals(old_kods)) {
							Main.par_k.ban_kods.setValue(Main.bankas_k.kods);
							Main.par_k.put();
							if (CError.error().length()!=0) {
								CRun.stop(CError.error());
							}
						}
						if (Main.par_k.ban_kods2.equals(old_kods)) {
							Main.par_k.ban_kods2.setValue(Main.bankas_k.kods);
							Main.par_k.put();
							if (CError.error().length()!=0) {
								CRun.stop(CError.error());
							}
						}
					}
					Main.par_k.reget(par_position);
					Main.par_k.next();
					Main.par_k.setValue(par_record.getString());
				}
			}
			Main.bankas_kUsed.decrement(1);
			if (Main.bankas_kUsed.equals(0)) {
				Main.bankas_k.close();
			}
		}
		if (windowopened.boolValue()) {
			Winla_sf.inisavewindow(Clarion.newString("UpdateBANKAS_K"),Clarion.newString("winlats.INI"));
			quickwindow.close();
		}
		if (localresponse.boolValue()) {
			Main.globalresponse.setValue(localresponse);
		}
		else {
			Main.globalresponse.setValue(Constants.REQUESTCANCELLED);
		}
		CExpression.popBind();
		throw new ClarionRoutineResult();
	}
	public static void updatebankas_k_initializewindow(Quickwindow quickwindow,ClarionNumber forcerefresh)
	{
		updatebankas_k_refreshwindow(quickwindow,forcerefresh);
	}
	public static void updatebankas_k_refreshwindow(Quickwindow quickwindow,ClarionNumber forcerefresh)
	{
		if (quickwindow.getProperty(Prop.ACCEPTALL).boolValue()) {
			return;
		}
		CWin.display();
		forcerefresh.setValue(Constants.FALSE);
	}
	public static void updatebankas_k_syncwindow()
	{
	}
	public static void updatebankas_k_primefields(Bankas_k savBanRecord)
	{
		Main.bankas_k.setValue(savBanRecord.getString());
		savBanRecord.setValue(Main.bankas_k.getString());
	}
	public static void updatebankas_k_formAssignbuttons(ClarionNumber toolbarmode,ClarionNumber originalrequest)
	{
		toolbarmode.setValue(Constants.FORMMODE);
		CWin.disable(Constants.TBARBRWFIRST,Constants.TBARBRWLAST);
		CWin.enable(Constants.TBARBRWHISTORY);
		{
			ClarionNumber case_1=originalrequest;
			boolean case_1_break=false;
			if (case_1.equals(Constants.INSERTRECORD)) {
				CWin.enable(Constants.TBARBRWDOWN);
				CWin.enable(Constants.TBARBRWINSERT);
				Clarion.getControl(Constants.TBARBRWDOWN).setProperty(Prop.TOOLTIP,"Save record and add another");
				Clarion.getControl(Constants.TBARBRWINSERT).setProperty(Prop.TOOLTIP,Clarion.getControl(Constants.TBARBRWDOWN).getProperty(Prop.TOOLTIP));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				CWin.enable(Constants.TBARBRWBOTTOM,Constants.TBARBRWUP);
				CWin.enable(Constants.TBARBRWINSERT);
				Clarion.getControl(Constants.TBARBRWBOTTOM).setProperty(Prop.TOOLTIP,"Save changes and go to last record");
				Clarion.getControl(Constants.TBARBRWTOP).setProperty(Prop.TOOLTIP,"Save changes and go to first record");
				Clarion.getControl(Constants.TBARBRWPAGEDOWN).setProperty(Prop.TOOLTIP,"Save changes and page down to record");
				Clarion.getControl(Constants.TBARBRWPAGEUP).setProperty(Prop.TOOLTIP,"Save changes and page up to record");
				Clarion.getControl(Constants.TBARBRWDOWN).setProperty(Prop.TOOLTIP,"Save changes and go to next record");
				Clarion.getControl(Constants.TBARBRWUP).setProperty(Prop.TOOLTIP,"Save changes and go to previous record");
				Clarion.getControl(Constants.TBARBRWINSERT).setProperty(Prop.TOOLTIP,"Save this record and add a new one");
				case_1_break=true;
			}
		}
		CWin.display(Constants.TBARBRWFIRST,Constants.TBARBRWLAST);
	}
	public static void updatebankas_k_historyfield(Quickwindow quickwindow)
	{
		{
			int case_1=CWin.focus();
			boolean case_1_break=false;
			if (case_1==quickwindow._banNos_p) {
				Main.bankas_k.nos_p.setValue(Winla002.updatebankas_k_historyBanRecord.nos_p);
				case_1_break=true;
			}
			if (!case_1_break && case_1==quickwindow._banNos_s) {
				Main.bankas_k.nos_s.setValue(Winla002.updatebankas_k_historyBanRecord.nos_s);
				case_1_break=true;
			}
			if (!case_1_break && case_1==quickwindow._banNos_a) {
				Main.bankas_k.nos_a.setValue(Winla002.updatebankas_k_historyBanRecord.nos_a);
				case_1_break=true;
			}
			if (!case_1_break && case_1==quickwindow._banKods) {
				Main.bankas_k.kods.setValue(Winla002.updatebankas_k_historyBanRecord.kods);
				case_1_break=true;
			}
			if (!case_1_break && case_1==quickwindow._banKor_k) {
				Main.bankas_k.kor_k.setValue(Winla002.updatebankas_k_historyBanRecord.kor_k);
				case_1_break=true;
			}
			if (!case_1_break && case_1==quickwindow._banAdrese1) {
				Main.bankas_k.adrese1.setValue(Winla002.updatebankas_k_historyBanRecord.adrese1);
				case_1_break=true;
			}
			if (!case_1_break && case_1==quickwindow._banAdrese2) {
				Main.bankas_k.adrese2.setValue(Winla002.updatebankas_k_historyBanRecord.adrese2);
				case_1_break=true;
			}
			if (!case_1_break && case_1==quickwindow._banSpec) {
				Main.bankas_k.spec.setValue(Winla002.updatebankas_k_historyBanRecord.spec);
				case_1_break=true;
			}
			if (!case_1_break && case_1==quickwindow._banMaksajuma_taka) {
				Main.bankas_k.maksajuma_taka.setValue(Winla002.updatebankas_k_historyBanRecord.maksajuma_taka);
				case_1_break=true;
			}
		}
		CWin.display();
	}
	public static void updatebankas_k_cancelautoincrement(ClarionNumber localresponse)
	{
		if (!localresponse.equals(Constants.REQUESTCOMPLETED)) {
		}
	}
	public static void updatebankas_k_prepareprocedure(ClarionNumber filesopened,Bankas_k savBanRecord,ClarionNumber localrequest,ClarionNumber localresponse,Quickwindow quickwindow,ClarionNumber windowopened,Windowresizetype winresize,ClarionString old_kods,Par_k par_record,ClarionString par_position,ClarionNumber recordstoprocess,ClarionNumber recordspercycle,ClarionNumber recordsprocessed,ClarionNumber percentprogress,Progresswindow_1 progresswindow,ClarionNumber progressThermometer,ClarionNumber recordsthiscycle) throws ClarionRoutineResult
	{
		if (Main.bankas_kUsed.equals(0)) {
			Winla_sf.checkopen(Main.bankas_k,Clarion.newNumber(1));
		}
		Main.bankas_kUsed.increment(1);
		CExpression.bind(Main.bankas_k);
		filesopened.setValue(Constants.TRUE);
		Winla_ru.risnapBankas_k();
		savBanRecord.setValue(Main.bankas_k.getString());
		if (localrequest.equals(Constants.INSERTRECORD)) {
			localresponse.setValue(Constants.REQUESTCOMPLETED);
			updatebankas_k_primefields(savBanRecord);
			if (localresponse.equals(Constants.REQUESTCANCELLED)) {
				updatebankas_k_procedurereturn(filesopened,old_kods,localrequest,par_record,par_position,recordstoprocess,recordspercycle,recordsprocessed,percentprogress,progresswindow,progressThermometer,recordsthiscycle,windowopened,quickwindow,localresponse);
			}
			localresponse.setValue(Constants.REQUESTCANCELLED);
		}
		if (Main.gnet.boolValue()) {
			{
				ClarionNumber case_1=localrequest;
				boolean case_1_break=false;
				if (case_1.equals(1)) {
					Main.bankas_k.gnet_flag.setStringAt(1,1);
					Main.bankas_k.gnet_flag.setStringAt(2,"");
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(2)) {
					if (Main.bankas_k.gnet_flag.stringAt(1).equals(1)) {
					}
					else if (Main.bankas_k.gnet_flag.stringAt(1).equals(4)) {
						Winla043.kluda(Clarion.newNumber(121),Clarion.newString("I/O, kam�r nav pabeigta t�klu sinhroniz�cija"));
						localrequest.setValue(0);
					}
					else if (Main.bankas_k.gnet_flag.stringAt(1).equals(2)) {
					}
					else if (Main.bankas_k.gnet_flag.stringAt(1).equals(5)) {
						Main.bankas_k.gnet_flag.setStringAt(1,2);
						Main.bankas_k.gnet_flag.setStringAt(2,"");
					}
					else if (Main.bankas_k.gnet_flag.stringAt(1).equals(3) || Main.bankas_k.gnet_flag.stringAt(1).equals(6)) {
						Winla043.kluda(Clarion.newNumber(121),Clarion.newString("I/O, kam�r nav pabeigta t�klu sinhroniz�cija"));
						localrequest.setValue(0);
					}
					else {
						Main.bankas_k.gnet_flag.setStringAt(1,2);
						Main.bankas_k.gnet_flag.setStringAt(2,"");
					}
					savBanRecord.setValue(Main.bankas_k.getString());
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(3)) {
					if (Main.bankas_k.gnet_flag.stringAt(1).equals(1)) {
						Main.bankas_k.gnet_flag.setValue("");
					}
					else if (Main.bankas_k.gnet_flag.stringAt(1).equals(4)) {
						Winla043.kluda(Clarion.newNumber(121),Clarion.newString("dz�st, kam�r nav pabeigta t�klu sinhroniz�cija"));
						localrequest.setValue(0);
					}
					else if (Main.bankas_k.gnet_flag.stringAt(1).equals(2)) {
						Main.bankas_k.gnet_flag.setStringAt(1,3);
						localrequest.setValue(4);
					}
					else if (Main.bankas_k.gnet_flag.stringAt(1).equals(5)) {
						Main.bankas_k.gnet_flag.setStringAt(1,3);
						Main.bankas_k.gnet_flag.setStringAt(2,"");
						localrequest.setValue(4);
					}
					else if (Main.bankas_k.gnet_flag.stringAt(1).equals(3) || Main.bankas_k.gnet_flag.stringAt(1).equals(6)) {
						Winla043.kluda(Clarion.newNumber(121),Clarion.newString("I/O, kam�r nav pabeigta t�klu sinhroniz�cija"));
						localrequest.setValue(0);
					}
					else {
						Main.bankas_k.gnet_flag.setStringAt(1,3);
						Main.bankas_k.gnet_flag.setStringAt(2,"");
						localrequest.setValue(4);
					}
					case_1_break=true;
				}
			}
		}
		if (localrequest.equals(4)) {
			if (Winla_sf.standardwarning(Clarion.newNumber(Warn.STANDARDDELETE)).equals(Button.OK)) {
				while (true) {
					localresponse.setValue(Constants.REQUESTCANCELLED);
					CWin.setCursor(Cursor.WAIT);
					Main.bankas_k.nos_s.setValue("WAIT FOR DEL");
					Main.bankas_k.nos_a.setValue("WFD.");
					if (Winla_ru.riupdateBankas_k().boolValue()) {
						CWin.setCursor(null);
						{
							ClarionNumber case_2=Winla_sf.standardwarning(Clarion.newNumber(Warn.DELETEERROR));
							boolean case_2_break=false;
							boolean case_2_match=false;
							case_2_match=false;
							if (case_2.equals(Button.YES)) {
								continue;
								// UNREACHABLE! :case_2_break=true;
							}
							case_2_match=false;
							if (!case_2_break && case_2.equals(Button.NO)) {
								case_2_match=true;
							}
							if (case_2_match || case_2.equals(Button.CANCEL)) {
								break;
								// UNREACHABLE! :case_2_break=true;
							}
						}
					}
					else {
						CWin.setCursor(null);
						localresponse.setValue(Constants.REQUESTCOMPLETED);
					}
					break;
				}
			}
			updatebankas_k_procedurereturn(filesopened,old_kods,localrequest,par_record,par_position,recordstoprocess,recordspercycle,recordsprocessed,percentprogress,progresswindow,progressThermometer,recordsthiscycle,windowopened,quickwindow,localresponse);
		}
		if (localrequest.equals(Constants.DELETERECORD)) {
			if (Winla_sf.standardwarning(Clarion.newNumber(Warn.STANDARDDELETE)).equals(Button.OK)) {
				while (true) {
					localresponse.setValue(Constants.REQUESTCANCELLED);
					CWin.setCursor(Cursor.WAIT);
					if (Winla_rd.rideleteBankas_k().boolValue()) {
						CWin.setCursor(null);
						{
							ClarionNumber case_3=Winla_sf.standardwarning(Clarion.newNumber(Warn.DELETEERROR));
							boolean case_3_break=false;
							boolean case_3_match=false;
							case_3_match=false;
							if (case_3.equals(Button.YES)) {
								continue;
								// UNREACHABLE! :case_3_break=true;
							}
							case_3_match=false;
							if (!case_3_break && case_3.equals(Button.NO)) {
								case_3_match=true;
							}
							if (case_3_match || case_3.equals(Button.CANCEL)) {
								break;
								// UNREACHABLE! :case_3_break=true;
							}
						}
					}
					else {
						CWin.setCursor(null);
						localresponse.setValue(Constants.REQUESTCOMPLETED);
					}
					break;
				}
			}
			updatebankas_k_procedurereturn(filesopened,old_kods,localrequest,par_record,par_position,recordstoprocess,recordspercycle,recordsprocessed,percentprogress,progresswindow,progressThermometer,recordsthiscycle,windowopened,quickwindow,localresponse);
		}
		quickwindow.open();
		windowopened.setValue(Constants.TRUE);
		quickwindow.setProperty(Prop.MINWIDTH,quickwindow.getProperty(Prop.WIDTH));
		quickwindow.setProperty(Prop.MINHEIGHT,quickwindow.getProperty(Prop.HEIGHT));
		winresize.initialize(Clarion.newNumber(Appstrat.RESIZE));
		Winla_sf.inirestorewindow(Clarion.newString("UpdateBANKAS_K"),Clarion.newString("winlats.INI"));
		winresize.resize();
		Clarion.getControl(quickwindow._banNos_p).setProperty(Prop.ALRT,255,734);
		Clarion.getControl(quickwindow._banNos_s).setProperty(Prop.ALRT,255,734);
		Clarion.getControl(quickwindow._banNos_a).setProperty(Prop.ALRT,255,734);
		Clarion.getControl(quickwindow._banKods).setProperty(Prop.ALRT,255,734);
		Clarion.getControl(quickwindow._banKor_k).setProperty(Prop.ALRT,255,734);
		Clarion.getControl(quickwindow._banAdrese1).setProperty(Prop.ALRT,255,734);
		Clarion.getControl(quickwindow._banAdrese2).setProperty(Prop.ALRT,255,734);
		Clarion.getControl(quickwindow._banSpec).setProperty(Prop.ALRT,255,734);
		Clarion.getControl(quickwindow._banMaksajuma_taka).setProperty(Prop.ALRT,255,734);
	}
	public static void browsebankas_k()
	{
		ClarionString currenttab=Clarion.newString(80);
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber originalrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber localresponse=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber windowopened=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber windowinitialized=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber forcerefresh=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber recordfiltered=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionView brw1ViewBrowse=new Brw1ViewBrowse();
		QueueBrowse_1 queueBrowse_1=new QueueBrowse_1();
		ClarionNumber brw1Currentscroll=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber brw1Scrollrecordcount=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber brw1Skipfirst=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString brw1Sort1Locatorvalue=Clarion.newString(30);
		ClarionNumber brw1Sort1Locatorlength=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionArray<ClarionString> brw1Sort1Keydistribution=Clarion.newString(4).dim(100);
		ClarionString brw1Sort1Lowvalue=Clarion.newString(4);
		ClarionString brw1Sort1Highvalue=Clarion.newString(4);
		ClarionString brw1Sort2Locatorvalue=Clarion.newString(30);
		ClarionNumber brw1Sort2Locatorlength=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionArray<ClarionString> brw1Sort2Keydistribution=Clarion.newString(15).dim(100);
		ClarionString brw1Sort2Lowvalue=Clarion.newString(15);
		ClarionString brw1Sort2Highvalue=Clarion.newString(15);
		ClarionNumber brw1Currentevent=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber brw1Currentchoice=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber brw1Recordcount=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber brw1Sortorder=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber brw1Locatemode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber brw1Refreshmode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber brw1Lastsortorder=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber brw1Filldirection=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber brw1Addqueue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber brw1Changed=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber brw1Recordstatus=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber brw1Itemstofill=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber brw1Maxitemsinlist=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString brw1Highlightedposition=Clarion.newString(512);
		ClarionNumber brw1Newselectposted=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString brw1Popuptext=Clarion.newString(128);
		ClarionNumber toolbarmode=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		Browsebuttons browsebuttons=new Browsebuttons();
		Windowresizetype winresize=new Windowresizetype();
		Quickwindow_1 quickwindow=new Quickwindow_1(queueBrowse_1);
		try {
			CExpression.pushBind();
			localrequest.setValue(Main.globalrequest);
			originalrequest.setValue(Main.globalrequest);
			localresponse.setValue(Constants.REQUESTCANCELLED);
			forcerefresh.setValue(Constants.FALSE);
			Main.globalrequest.clear();
			Main.globalresponse.clear();
			if (CWin.keyCode()==Constants.MOUSERIGHT) {
				CWin.setKeyCode(0);
			}
			browsebankas_k_prepareprocedure(queueBrowse_1,filesopened,quickwindow,windowopened,winresize,brw1Addqueue,brw1Recordcount,localrequest);
			if (localrequest.equals(Constants.SELECTRECORD)) {
				Clarion.getControl(quickwindow._change).setProperty(Prop.DEFAULT,"");
				Clarion.getControl(quickwindow._select).setProperty(Prop.DEFAULT,"1");
			}
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_1=CWin.event();
					boolean case_1_break=false;
					if (case_1==Event.CLOSEDOWN) {
						winresize.destroy();
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.OPENWINDOW) {
						browsebankas_k_brw1Assignbuttons(browsebuttons,quickwindow,queueBrowse_1,toolbarmode);
						if (!windowinitialized.boolValue()) {
							browsebankas_k_initializewindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
							windowinitialized.setValue(Constants.TRUE);
						}
						CWin.select(quickwindow._browse_1);
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.GAINFOCUS) {
						forcerefresh.setValue(Constants.TRUE);
						if (!windowinitialized.boolValue()) {
							browsebankas_k_initializewindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
							windowinitialized.setValue(Constants.TRUE);
						}
						else {
							browsebankas_k_refreshwindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.SIZED) {
						winresize.resize();
						forcerefresh.setValue(Constants.TRUE);
						browsebankas_k_refreshwindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.REJECTED) {
						CWin.beep();
						CWin.display(CWin.field());
						CWin.select(CWin.field());
						case_1_break=true;
					}
					if (!case_1_break) {
						if (toolbarmode.equals(Constants.BROWSEMODE)) {
							browsebankas_k_selectdispatch(browsebuttons,queueBrowse_1);
						}
						if (toolbarmode.equals(Constants.BROWSEMODE)) {
							browsebankas_k_listboxdispatch(browsebuttons,queueBrowse_1,toolbarmode);
						}
						if (toolbarmode.equals(Constants.BROWSEMODE)) {
							browsebankas_k_updatedispatch(browsebuttons,queueBrowse_1);
						}
					}
				}
				{
					int case_2=CWin.field();
					boolean case_2_break=false;
					if (case_2==quickwindow._browse_1) {
						{
							int case_3=CWin.event();
							boolean case_3_break=false;
							if (case_3==Event.NEWSELECTION) {
								browsebankas_k_brw1Newselection(brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Sortorder,brw1Currentscroll,brw1Sort1Keydistribution,brw1Sort2Keydistribution,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort2Lowvalue,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.SCROLLUP) {
								browsebankas_k_brw1Processscroll(brw1Recordcount,brw1Currentevent,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Sortorder,brw1Sort1Locatorvalue,brw1Sort1Locatorlength,brw1Sort2Locatorvalue,brw1Sort2Locatorlength,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.SCROLLDOWN) {
								browsebankas_k_brw1Processscroll(brw1Recordcount,brw1Currentevent,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Sortorder,brw1Sort1Locatorvalue,brw1Sort1Locatorlength,brw1Sort2Locatorvalue,brw1Sort2Locatorlength,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.PAGEUP) {
								browsebankas_k_brw1Processscroll(brw1Recordcount,brw1Currentevent,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Sortorder,brw1Sort1Locatorvalue,brw1Sort1Locatorlength,brw1Sort2Locatorvalue,brw1Sort2Locatorlength,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.PAGEDOWN) {
								browsebankas_k_brw1Processscroll(brw1Recordcount,brw1Currentevent,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Sortorder,brw1Sort1Locatorvalue,brw1Sort1Locatorlength,brw1Sort2Locatorvalue,brw1Sort2Locatorlength,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.SCROLLTOP) {
								browsebankas_k_brw1Processscroll(brw1Recordcount,brw1Currentevent,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Sortorder,brw1Sort1Locatorvalue,brw1Sort1Locatorlength,brw1Sort2Locatorvalue,brw1Sort2Locatorlength,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.SCROLLBOTTOM) {
								browsebankas_k_brw1Processscroll(brw1Recordcount,brw1Currentevent,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Sortorder,brw1Sort1Locatorvalue,brw1Sort1Locatorlength,brw1Sort2Locatorvalue,brw1Sort2Locatorlength,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.ALERTKEY) {
								browsebankas_k_brw1Alertkey(brw1Recordcount,localrequest,quickwindow,queueBrowse_1,brw1Sortorder,brw1Sort1Locatorlength,brw1Sort1Locatorvalue,brw1Locatemode,brw1Sort2Locatorlength,brw1Sort2Locatorvalue,brw1Newselectposted,brw1ViewBrowse,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,brw1Refreshmode,brw1Currentchoice);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.SCROLLDRAG) {
								browsebankas_k_brw1Scrolldrag(quickwindow,queueBrowse_1,brw1Sortorder,brw1Sort1Keydistribution,brw1Locatemode,brw1Sort2Keydistribution,brw1ViewBrowse,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
								case_3_break=true;
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._insert_2) {
						{
							int case_4=CWin.event();
							if (case_4==Event.ACCEPTED) {
								browsebankas_k_syncwindow(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
								browsebankas_k_brw1Buttoninsert(localrequest,brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse,brw1Locatemode,brw1Sortorder,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,brw1Refreshmode,brw1Newselectposted,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,originalrequest,localresponse,brw1Currentscroll,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Currentevent,brw1Popuptext);
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._change) {
						{
							int case_5=CWin.event();
							if (case_5==Event.ACCEPTED) {
								browsebankas_k_syncwindow(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
								browsebankas_k_brw1Buttonchange(localrequest,brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,originalrequest,localresponse,brw1Currentscroll,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Currentevent,brw1Popuptext);
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._delete_2) {
						{
							int case_6=CWin.event();
							if (case_6==Event.ACCEPTED) {
								browsebankas_k_syncwindow(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
								browsebankas_k_brw1Buttondelete(localrequest,queueBrowse_1,brw1Recordcount,brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,brw1Currentchoice,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,brw1Sortorder,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,originalrequest,localresponse,brw1Currentscroll,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Locatemode,brw1Currentevent,brw1Popuptext);
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._kopet) {
						{
							int case_7=CWin.event();
							if (case_7==Event.ACCEPTED) {
								Main.copyrequest.setValue(1);
								browsebankas_k_brw1Buttoninsert(localrequest,brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse,brw1Locatemode,brw1Sortorder,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,brw1Refreshmode,brw1Newselectposted,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,originalrequest,localresponse,brw1Currentscroll,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Currentevent,brw1Popuptext);
								browsebankas_k_syncwindow(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._currenttab) {
						{
							int case_8=CWin.event();
							boolean case_8_break=false;
							if (case_8==Event.ACCEPTED) {
								browsebankas_k_refreshwindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
								case_8_break=true;
							}
							if (!case_8_break && case_8==Event.NEWSELECTION) {
								browsebankas_k_refreshwindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
								case_8_break=true;
							}
							if (!case_8_break && case_8==Event.TABCHANGING) {
								browsebankas_k_refreshwindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
								case_8_break=true;
							}
							if (!case_8_break && case_8==Event.SELECTED) {
								browsebankas_k_refreshwindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
								case_8_break=true;
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._banKods) {
						{
							int case_9=CWin.event();
							if (case_9==Event.ACCEPTED) {
								CWin.update(quickwindow._banKods);
								if (Main.bankas_k.kods.boolValue()) {
									brw1Locatemode.setValue(Constants.LOCATEONVALUE);
									browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
									brw1Sort2Locatorvalue.setValue(Main.bankas_k.kods);
									brw1Sort2Locatorlength.setValue(Main.bankas_k.kods.clip().len());
									CWin.select(quickwindow._browse_1);
									browsebankas_k_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
								}
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._banNos_a) {
						{
							int case_10=CWin.event();
							if (case_10==Event.ACCEPTED) {
								CWin.update(quickwindow._banNos_a);
								if (Main.bankas_k.nos_a.boolValue()) {
									brw1Locatemode.setValue(Constants.LOCATEONVALUE);
									browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
									brw1Sort1Locatorvalue.setValue(Main.bankas_k.nos_a);
									brw1Sort1Locatorlength.setValue(Main.bankas_k.nos_a.clip().len());
									CWin.select(quickwindow._browse_1);
									browsebankas_k_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
								}
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._select) {
						{
							int case_11=CWin.event();
							if (case_11==Event.ACCEPTED) {
								browsebankas_k_syncwindow(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
								localresponse.setValue(Constants.REQUESTCOMPLETED);
								CWin.post(Event.CLOSEWINDOW);
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._close) {
						{
							int case_12=CWin.event();
							if (case_12==Event.ACCEPTED) {
								browsebankas_k_syncwindow(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
								localresponse.setValue(Constants.REQUESTCANCELLED);
								CWin.post(Event.CLOSEWINDOW);
							}
						}
						case_2_break=true;
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			try {
				browsebankas_k_procedurereturn(filesopened,queueBrowse_1,quickwindow,windowopened,localresponse);
			} catch (ClarionRoutineResult _crr) {
				return;
			}
		} finally {
			quickwindow.close();
		}
	}
	public static void browsebankas_k_brw1Scrollend(QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,Quickwindow_1 quickwindow,ClarionNumber brw1Currentevent,ClarionNumber brw1Filldirection,ClarionNumber brw1Currentchoice,ClarionView brw1ViewBrowse,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue,ClarionNumber brw1Sortorder)
	{
		System.out.println("BRW1::ScrollEnd ======== ");
		queueBrowse_1.free();
		brw1Recordcount.setValue(0);
		browsebankas_k_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
		brw1Itemstofill.setValue(Clarion.getControl(quickwindow._browse_1).getProperty(Prop.ITEMS));
		if (brw1Currentevent.equals(Event.SCROLLTOP)) {
			brw1Filldirection.setValue(Constants.FILLFORWARD);
		}
		else {
			brw1Filldirection.setValue(Constants.FILLBACKWARD);
		}
		browsebankas_k_brw1Fillrecord(brw1Recordcount,brw1Filldirection,queueBrowse_1,brw1ViewBrowse,brw1Skipfirst,brw1Itemstofill,brw1Addqueue,quickwindow);
		if (brw1Currentevent.equals(Event.SCROLLTOP)) {
			brw1Currentchoice.setValue(1);
		}
		else {
			brw1Currentchoice.setValue(brw1Recordcount);
		}
	}
	public static void browsebankas_k_brw1Locaterecord(ClarionNumber brw1Locatemode,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse,ClarionNumber brw1Sortorder,ClarionString brw1Highlightedposition,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst,Quickwindow_1 quickwindow,ClarionNumber brw1Refreshmode,ClarionNumber brw1Newselectposted,ClarionNumber brw1Currentchoice)
	{
		System.out.println("BRW1::LocateRecord ======== ");
		if (brw1Locatemode.equals(Constants.LOCATEONPOSITION)) {
			brw1Locatemode.setValue(Constants.LOCATEONEDIT);
		}
		brw1ViewBrowse.close();
		{
			ClarionNumber case_1=brw1Sortorder;
			boolean case_1_break=false;
			if (case_1.equals(1)) {
				if (brw1Locatemode.equals(Constants.LOCATEONEDIT)) {
					brw1Highlightedposition.setValue(Main.bankas_k.nos_key.getPosition());
					Main.bankas_k.nos_key.reget(brw1Highlightedposition);
				}
				else {
					Main.bankas_k.nos_key.set(Main.bankas_k.nos_key);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(2)) {
				if (brw1Locatemode.equals(Constants.LOCATEONEDIT)) {
					brw1Highlightedposition.setValue(Main.bankas_k.kod_key.getPosition());
					Main.bankas_k.kod_key.reget(brw1Highlightedposition);
				}
				else {
					Main.bankas_k.kod_key.set(Main.bankas_k.kod_key);
				}
				case_1_break=true;
			}
		}
		if (CError.errorCode()!=0) {
			Winla_sf.standardwarning(Clarion.newNumber(Warn.VIEWOPENERROR));
		}
		brw1ViewBrowse.open();
		if (CError.errorCode()!=0) {
			Winla_sf.standardwarning(Clarion.newNumber(Warn.VIEWOPENERROR));
		}
		queueBrowse_1.free();
		brw1Recordcount.setValue(0);
		brw1Itemstofill.setValue(1);
		brw1Filldirection.setValue(Constants.FILLFORWARD);
		brw1Addqueue.setValue(Constants.FALSE);
		browsebankas_k_brw1Fillrecord(brw1Recordcount,brw1Filldirection,queueBrowse_1,brw1ViewBrowse,brw1Skipfirst,brw1Itemstofill,brw1Addqueue,quickwindow);
		brw1Addqueue.setValue(Constants.TRUE);
		if (brw1Itemstofill.boolValue()) {
			brw1Refreshmode.setValue(Constants.REFRESHONBOTTOM);
			browsebankas_k_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,brw1Sortorder);
		}
		else {
			brw1Refreshmode.setValue(Constants.REFRESHONPOSITION);
			browsebankas_k_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,brw1Sortorder);
		}
		browsebankas_k_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
		brw1Locatemode.setValue(0);
		return;
	}
	public static void browsebankas_k_brw1Buttondelete(ClarionNumber localrequest,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Recordcount,ClarionNumber brw1Refreshmode,ClarionString brw1Highlightedposition,ClarionView brw1ViewBrowse,ClarionNumber brw1Currentchoice,ClarionNumber brw1Itemstofill,Quickwindow_1 quickwindow,ClarionNumber brw1Filldirection,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue,ClarionNumber brw1Sortorder,ClarionString brw1Sort1Highvalue,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort1Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort1Keydistribution,ClarionString brw1Sort2Lowvalue,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionNumber brw1Newselectposted,ClarionNumber originalrequest,ClarionNumber localresponse,ClarionNumber brw1Currentscroll,ClarionString brw1Sort1Locatorvalue,ClarionString brw1Sort2Locatorvalue,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Sort1Locatorlength,ClarionNumber brw1Sort2Locatorlength,ClarionNumber brw1Locatemode,ClarionNumber brw1Currentevent,ClarionString brw1Popuptext)
	{
		localrequest.setValue(Constants.DELETERECORD);
		browsebankas_k_brw1Callupdate(brw1ViewBrowse,localrequest,localresponse,queueBrowse_1,brw1Currentevent,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Skipfirst,brw1Addqueue,quickwindow,brw1Sortorder,brw1Locatemode,brw1Highlightedposition,brw1Refreshmode,brw1Newselectposted,brw1Currentscroll,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Popuptext);
		if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
			queueBrowse_1.delete();
			brw1Recordcount.decrement(1);
		}
		brw1Refreshmode.setValue(Constants.REFRESHONQUEUE);
		browsebankas_k_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,brw1Sortorder);
		browsebankas_k_brw1Initializebrowse(brw1ViewBrowse,queueBrowse_1,brw1Sortorder,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution);
		browsebankas_k_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
		CWin.select(quickwindow._browse_1);
		localrequest.setValue(originalrequest);
		localresponse.setValue(Constants.REQUESTCANCELLED);
		browsebankas_k_refreshwindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
	}
	public static void browsebankas_k_brw1Restoreresetvalues()
	{
	}
	public static void browsebankas_k_brw1Scrollone(ClarionNumber brw1Currentevent,ClarionNumber brw1Currentchoice,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionView brw1ViewBrowse,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue,Quickwindow_1 quickwindow)
	{
		System.out.println("BRW1::ScrollOne ======== ");
		if (brw1Currentevent.equals(Event.SCROLLUP) && brw1Currentchoice.compareTo(1)>0) {
			brw1Currentchoice.decrement(1);
			return;
		}
		else if (brw1Currentevent.equals(Event.SCROLLDOWN) && brw1Currentchoice.compareTo(brw1Recordcount)<0) {
			brw1Currentchoice.increment(1);
			return;
		}
		brw1Itemstofill.setValue(1);
		brw1Filldirection.setValue(brw1Currentevent.subtract(2));
		browsebankas_k_brw1Fillrecord(brw1Recordcount,brw1Filldirection,queueBrowse_1,brw1ViewBrowse,brw1Skipfirst,brw1Itemstofill,brw1Addqueue,quickwindow);
	}
	public static void browsebankas_k_displaybrowsetoolbar(Browsebuttons browsebuttons,QueueBrowse_1 queueBrowse_1,ClarionNumber toolbarmode)
	{
		CWin.enable(Constants.TBARBRWBOTTOM,Constants.TBARBRWLOCATE);
		if (browsebuttons.selectbutton.boolValue()) {
			Clarion.getControl(Constants.TBARBRWSELECT).setProperty(Prop.DISABLE,Clarion.getControl(browsebuttons.selectbutton).getProperty(Prop.DISABLE));
		}
		if (browsebuttons.insertbutton.boolValue()) {
			Clarion.getControl(Constants.TBARBRWINSERT).setProperty(Prop.DISABLE,Clarion.getControl(browsebuttons.insertbutton).getProperty(Prop.DISABLE));
		}
		if (browsebuttons.changebutton.boolValue()) {
			Clarion.getControl(Constants.TBARBRWCHANGE).setProperty(Prop.DISABLE,Clarion.getControl(browsebuttons.changebutton).getProperty(Prop.DISABLE));
		}
		if (browsebuttons.deletebutton.boolValue()) {
			Clarion.getControl(Constants.TBARBRWDELETE).setProperty(Prop.DISABLE,Clarion.getControl(browsebuttons.deletebutton).getProperty(Prop.DISABLE));
		}
		CWin.disable(Constants.TBARBRWHISTORY);
		toolbarmode.setValue(Constants.BROWSEMODE);
		Clarion.getControl(Constants.TBARBRWDOWN).setProperty(Prop.TOOLTIP,"Go to the Next Record");
		Clarion.getControl(Constants.TBARBRWBOTTOM).setProperty(Prop.TOOLTIP,"Go to the Last Page");
		Clarion.getControl(Constants.TBARBRWTOP).setProperty(Prop.TOOLTIP,"Go to the First Page");
		Clarion.getControl(Constants.TBARBRWPAGEDOWN).setProperty(Prop.TOOLTIP,"Go to the Next Page");
		Clarion.getControl(Constants.TBARBRWPAGEUP).setProperty(Prop.TOOLTIP,"Go to the Prior Page");
		Clarion.getControl(Constants.TBARBRWDOWN).setProperty(Prop.TOOLTIP,"Go to the Next Record");
		Clarion.getControl(Constants.TBARBRWUP).setProperty(Prop.TOOLTIP,"Go to the Prior Record");
		Clarion.getControl(Constants.TBARBRWINSERT).setProperty(Prop.TOOLTIP,"Insert a new Record");
		CWin.display(Constants.TBARBRWFIRST,Constants.TBARBRWLAST);
	}
	public static void browsebankas_k_brw1Assignbuttons(Browsebuttons browsebuttons,Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1,ClarionNumber toolbarmode)
	{
		browsebuttons.clear();
		browsebuttons.listbox.setValue(quickwindow._browse_1);
		browsebuttons.selectbutton.setValue(quickwindow._select);
		browsebuttons.insertbutton.setValue(quickwindow._insert_2);
		browsebuttons.changebutton.setValue(quickwindow._change);
		browsebuttons.deletebutton.setValue(quickwindow._delete_2);
		browsebankas_k_displaybrowsetoolbar(browsebuttons,queueBrowse_1,toolbarmode);
	}
	public static void browsebankas_k_brw1Initializebrowse(ClarionView brw1ViewBrowse,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Sortorder,ClarionString brw1Sort1Highvalue,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort1Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort1Keydistribution,ClarionString brw1Sort2Lowvalue,ClarionArray<ClarionString> brw1Sort2Keydistribution)
	{
		browsebankas_k_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
		brw1ViewBrowse.previous();
		if (CError.errorCode()!=0) {
			if (CError.errorCode()==Constants.BADRECERR) {
				browsebankas_k_brw1Restoreresetvalues();
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("BANKAS_K"));
				CWin.post(Event.CLOSEWINDOW);
			}
			return;
		}
		{
			ClarionNumber case_1=brw1Sortorder;
			boolean case_1_break=false;
			if (case_1.equals(1)) {
				brw1Sort1Highvalue.setValue(Main.bankas_k.nos_a);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(2)) {
				brw1Sort2Highvalue.setValue(Main.bankas_k.kods);
				case_1_break=true;
			}
		}
		browsebankas_k_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
		brw1ViewBrowse.next();
		if (CError.errorCode()!=0) {
			if (CError.errorCode()==Constants.BADRECERR) {
				browsebankas_k_brw1Restoreresetvalues();
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("BANKAS_K"));
				CWin.post(Event.CLOSEWINDOW);
			}
			return;
		}
		{
			ClarionNumber case_2=brw1Sortorder;
			boolean case_2_break=false;
			if (case_2.equals(1)) {
				brw1Sort1Lowvalue.setValue(Main.bankas_k.nos_a);
				Winla_sf.setupstringstops(brw1Sort1Lowvalue.like(),brw1Sort1Highvalue.like(),Clarion.newNumber(CMemory.size(brw1Sort1Lowvalue)),Clarion.newNumber(Scrollsort.ALLOWALPHA));
				for (brw1Scrollrecordcount.setValue(1);brw1Scrollrecordcount.compareTo(100)<=0;brw1Scrollrecordcount.increment(1)) {
					brw1Sort1Keydistribution.get(brw1Scrollrecordcount.intValue()).setValue(Winla_sf.nextstringstop());
				}
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(2)) {
				brw1Sort2Lowvalue.setValue(Main.bankas_k.kods);
				Winla_sf.setupstringstops(brw1Sort2Lowvalue.like(),brw1Sort2Highvalue.like(),Clarion.newNumber(CMemory.size(brw1Sort2Lowvalue)),Clarion.newNumber(Scrollsort.ALLOWALPHA));
				for (brw1Scrollrecordcount.setValue(1);brw1Scrollrecordcount.compareTo(100)<=0;brw1Scrollrecordcount.increment(1)) {
					brw1Sort2Keydistribution.get(brw1Scrollrecordcount.intValue()).setValue(Winla_sf.nextstringstop());
				}
				case_2_break=true;
			}
		}
	}
	public static void browsebankas_k_brw1Scrollpage(ClarionNumber brw1Itemstofill,Quickwindow_1 quickwindow,ClarionNumber brw1Filldirection,ClarionNumber brw1Currentevent,ClarionNumber brw1Currentchoice,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Recordcount,ClarionView brw1ViewBrowse,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue)
	{
		System.out.println("BRW1::ScrollPage ======== ");
		brw1Itemstofill.setValue(Clarion.getControl(quickwindow._browse_1).getProperty(Prop.ITEMS));
		brw1Filldirection.setValue(brw1Currentevent.subtract(4));
		browsebankas_k_brw1Fillrecord(brw1Recordcount,brw1Filldirection,queueBrowse_1,brw1ViewBrowse,brw1Skipfirst,brw1Itemstofill,brw1Addqueue,quickwindow);
		if (brw1Itemstofill.boolValue()) {
			if (brw1Currentevent.equals(Event.PAGEUP)) {
				brw1Currentchoice.decrement(brw1Itemstofill);
				if (brw1Currentchoice.compareTo(1)<0) {
					brw1Currentchoice.setValue(1);
				}
			}
			else {
				brw1Currentchoice.increment(brw1Itemstofill);
				if (brw1Currentchoice.compareTo(brw1Recordcount)>0) {
					brw1Currentchoice.setValue(brw1Recordcount);
				}
			}
		}
	}
	public static void browsebankas_k_selectdispatch(Browsebuttons browsebuttons,QueueBrowse_1 queueBrowse_1)
	{
		if (CWin.accepted()==Constants.TBARBRWSELECT) {
			CWin.post(Event.ACCEPTED,browsebuttons.selectbutton.intValue());
		}
	}
	public static void browsebankas_k_brw1Postvcredit1(ClarionView brw1ViewBrowse,ClarionNumber brw1Sortorder,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Locatemode,ClarionString brw1Highlightedposition,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst,Quickwindow_1 quickwindow,ClarionNumber brw1Refreshmode,ClarionNumber brw1Newselectposted,ClarionNumber brw1Currentchoice,ClarionNumber brw1Currentscroll,ClarionString brw1Sort1Locatorvalue,ClarionString brw1Sort2Locatorvalue,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Sort1Locatorlength,ClarionNumber brw1Sort2Locatorlength,ClarionNumber localrequest,ClarionString brw1Sort1Highvalue,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort1Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort1Keydistribution,ClarionString brw1Sort2Lowvalue,ClarionArray<ClarionString> brw1Sort2Keydistribution)
	{
		browsebankas_k_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
		brw1Locatemode.setValue(Constants.LOCATEONEDIT);
		browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
		browsebankas_k_refreshwindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
	}
	public static void browsebankas_k_brw1Postvcredit2(Quickwindow_1 quickwindow,ClarionNumber brw1Currentchoice,ClarionNumber brw1Newselectposted,ClarionString brw1Popuptext,ClarionNumber brw1Recordcount,ClarionNumber localrequest,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Sortorder,ClarionNumber brw1Currentscroll,ClarionArray<ClarionString> brw1Sort1Keydistribution,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionString brw1Sort1Locatorvalue,ClarionString brw1Sort2Locatorvalue,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Sort1Locatorlength,ClarionNumber brw1Sort2Locatorlength,ClarionNumber brw1Locatemode,ClarionNumber brw1Refreshmode,ClarionView brw1ViewBrowse,ClarionString brw1Sort1Highvalue,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort1Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionString brw1Sort2Lowvalue,ClarionString brw1Highlightedposition,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst)
	{
		Clarion.getControl(quickwindow._browse_1).setClonedProperty(Prop.SELSTART,brw1Currentchoice);
		browsebankas_k_brw1Newselection(brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Sortorder,brw1Currentscroll,brw1Sort1Keydistribution,brw1Sort2Keydistribution,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort2Lowvalue,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
		brw1ViewBrowse.reget(queueBrowse_1.brw1Position);
		brw1ViewBrowse.close();
	}
	public static void browsebankas_k_brw1Buttoninsert(ClarionNumber localrequest,ClarionNumber brw1Recordcount,ClarionNumber brw1Currentchoice,Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse,ClarionNumber brw1Locatemode,ClarionNumber brw1Sortorder,ClarionString brw1Highlightedposition,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst,ClarionNumber brw1Refreshmode,ClarionNumber brw1Newselectposted,ClarionString brw1Sort1Highvalue,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort1Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort1Keydistribution,ClarionString brw1Sort2Lowvalue,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionNumber originalrequest,ClarionNumber localresponse,ClarionNumber brw1Currentscroll,ClarionString brw1Sort1Locatorvalue,ClarionString brw1Sort2Locatorvalue,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Sort1Locatorlength,ClarionNumber brw1Sort2Locatorlength,ClarionNumber brw1Currentevent,ClarionString brw1Popuptext)
	{
		Main.bankas_k.get(Clarion.newString(String.valueOf(0)),null);
		Main.bankas_k.clear(0);
		localrequest.setValue(Constants.INSERTRECORD);
		if (Main.copyrequest.equals(1)) {
			browsebankas_k_syncwindow(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
			Main.bankas_k.kods.setStringAt(10,ClarionString.chr(Main.bankas_k.kods.val()+1));
		}
		browsebankas_k_brw1Callupdate(brw1ViewBrowse,localrequest,localresponse,queueBrowse_1,brw1Currentevent,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Skipfirst,brw1Addqueue,quickwindow,brw1Sortorder,brw1Locatemode,brw1Highlightedposition,brw1Refreshmode,brw1Newselectposted,brw1Currentscroll,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Popuptext);
		if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
			brw1Locatemode.setValue(Constants.LOCATEONEDIT);
			browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
		}
		else {
			brw1Refreshmode.setValue(Constants.REFRESHONQUEUE);
			browsebankas_k_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,brw1Sortorder);
		}
		browsebankas_k_brw1Initializebrowse(brw1ViewBrowse,queueBrowse_1,brw1Sortorder,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution);
		browsebankas_k_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
		CWin.select(quickwindow._browse_1);
		localrequest.setValue(originalrequest);
		localresponse.setValue(Constants.REQUESTCANCELLED);
		browsebankas_k_refreshwindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
	}
	public static void browsebankas_k_brw1Fillqueue(QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse)
	{
		queueBrowse_1.brw1BanKods.setValue(Main.bankas_k.kods);
		queueBrowse_1.brw1BanNos_s.setValue(Main.bankas_k.nos_s);
		queueBrowse_1.brw1BanNos_p.setValue(Main.bankas_k.nos_p);
		queueBrowse_1.brw1BanNos_a.setValue(Main.bankas_k.nos_a);
		queueBrowse_1.brw1Position.setValue(brw1ViewBrowse.getPosition());
	}
	public static void browsebankas_k_prepareprocedure(QueueBrowse_1 queueBrowse_1,ClarionNumber filesopened,Quickwindow_1 quickwindow,ClarionNumber windowopened,Windowresizetype winresize,ClarionNumber brw1Addqueue,ClarionNumber brw1Recordcount,ClarionNumber localrequest)
	{
		if (Main.bankas_kUsed.equals(0)) {
			Winla_sf.checkopen(Main.bankas_k,Clarion.newNumber(1));
		}
		Main.bankas_kUsed.increment(1);
		CExpression.bind(Main.bankas_k);
		filesopened.setValue(Constants.TRUE);
		quickwindow.open();
		windowopened.setValue(Constants.TRUE);
		quickwindow.setProperty(Prop.MINWIDTH,quickwindow.getProperty(Prop.WIDTH));
		quickwindow.setProperty(Prop.MINHEIGHT,quickwindow.getProperty(Prop.HEIGHT));
		winresize.initialize(Clarion.newNumber(Appstrat.RESIZE));
		Winla_sf.inirestorewindow(Clarion.newString("BrowseBANKAS_K"),Clarion.newString("winlats.INI"));
		winresize.resize();
		brw1Addqueue.setValue(Constants.TRUE);
		brw1Recordcount.setValue(0);
		if (!localrequest.equals(Constants.SELECTRECORD)) {
			CWin.disable(quickwindow._select);
		}
		else {
		}
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,252,Constants.MOUSELEFT2);
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,252,Constants.MOUSELEFT2);
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,250,Constants.BSKEY);
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,250,Constants.SPACEKEY);
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,255,Constants.INSERTKEY);
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,254,Constants.DELETEKEY);
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,253,Constants.CTRLENTER);
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,252,Constants.MOUSELEFT2);
	}
	public static void browsebankas_k_procedurereturn(ClarionNumber filesopened,QueueBrowse_1 queueBrowse_1,Quickwindow_1 quickwindow,ClarionNumber windowopened,ClarionNumber localresponse) throws ClarionRoutineResult
	{
		if (filesopened.boolValue()) {
			Main.bankas_kUsed.decrement(1);
			if (Main.bankas_kUsed.equals(0)) {
				Main.bankas_k.close();
			}
		}
		if (!Clarion.getControl(quickwindow._browse_1).getProperty(Prop.FORMAT).equals("")) {
			CConfig.setProperty("BrowseBANKAS_K","?BROWSE:1 Format",Clarion.getControl(quickwindow._browse_1).getProperty(Prop.FORMAT).toString(),"WinLats.ini");
		}
		if (windowopened.boolValue()) {
			Winla_sf.inisavewindow(Clarion.newString("BrowseBANKAS_K"),Clarion.newString("winlats.INI"));
			quickwindow.close();
		}
		if (localresponse.boolValue()) {
			Main.globalresponse.setValue(localresponse);
		}
		else {
			Main.globalresponse.setValue(Constants.REQUESTCANCELLED);
		}
		CExpression.popBind();
		throw new ClarionRoutineResult();
	}
	public static void browsebankas_k_brw1Alertkey(ClarionNumber brw1Recordcount,ClarionNumber localrequest,Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Sortorder,ClarionNumber brw1Sort1Locatorlength,ClarionString brw1Sort1Locatorvalue,ClarionNumber brw1Locatemode,ClarionNumber brw1Sort2Locatorlength,ClarionString brw1Sort2Locatorvalue,ClarionNumber brw1Newselectposted,ClarionView brw1ViewBrowse,ClarionString brw1Highlightedposition,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst,ClarionNumber brw1Refreshmode,ClarionNumber brw1Currentchoice)
	{
		if (brw1Recordcount.boolValue()) {
			{
				int case_1=CWin.keyCode();
				boolean case_1_break=false;
				if (case_1==Constants.MOUSELEFT2) {
					if (localrequest.equals(Constants.SELECTRECORD)) {
						CWin.post(Event.ACCEPTED,quickwindow._select);
						return;
					}
					CWin.post(Event.ACCEPTED,quickwindow._change);
					browsebankas_k_brw1Fillbuffer(queueBrowse_1);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Constants.INSERTKEY) {
					CWin.post(Event.ACCEPTED,quickwindow._insert_2);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Constants.DELETEKEY) {
					CWin.post(Event.ACCEPTED,quickwindow._delete_2);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Constants.CTRLENTER) {
					CWin.post(Event.ACCEPTED,quickwindow._change);
					case_1_break=true;
				}
				if (!case_1_break) {
					{
						ClarionNumber case_2=brw1Sortorder;
						boolean case_2_break=false;
						if (case_2.equals(1)) {
							if (CWin.keyCode()==Constants.BSKEY) {
								if (brw1Sort1Locatorlength.boolValue()) {
									brw1Sort1Locatorlength.decrement(1);
									brw1Sort1Locatorvalue.setValue(brw1Sort1Locatorvalue.sub(1,brw1Sort1Locatorlength.intValue()));
									Main.bankas_k.nos_a.setValue(brw1Sort1Locatorvalue);
									brw1Locatemode.setValue(Constants.LOCATEONVALUE);
									browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
								}
							}
							else if (CWin.keyCode()==Constants.SPACEKEY) {
								brw1Sort1Locatorvalue.setValue(brw1Sort1Locatorvalue.sub(1,brw1Sort1Locatorlength.intValue()).concat(" "));
								brw1Sort1Locatorlength.increment(1);
								Main.bankas_k.nos_a.setValue(brw1Sort1Locatorvalue);
								brw1Locatemode.setValue(Constants.LOCATEONVALUE);
								browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
							}
							else if (ClarionString.chr(CWin.keyChar()).boolValue()) {
								brw1Sort1Locatorvalue.setValue(brw1Sort1Locatorvalue.sub(1,brw1Sort1Locatorlength.intValue()).concat(ClarionString.chr(CWin.keyChar())));
								brw1Sort1Locatorlength.increment(1);
								Main.bankas_k.nos_a.setValue(brw1Sort1Locatorvalue);
								brw1Locatemode.setValue(Constants.LOCATEONVALUE);
								browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
							}
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals(2)) {
							if (CWin.keyCode()==Constants.BSKEY) {
								if (brw1Sort2Locatorlength.boolValue()) {
									brw1Sort2Locatorlength.decrement(1);
									brw1Sort2Locatorvalue.setValue(brw1Sort2Locatorvalue.sub(1,brw1Sort2Locatorlength.intValue()));
									Main.bankas_k.kods.setValue(brw1Sort2Locatorvalue);
									brw1Locatemode.setValue(Constants.LOCATEONVALUE);
									browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
								}
							}
							else if (CWin.keyCode()==Constants.SPACEKEY) {
								brw1Sort2Locatorvalue.setValue(brw1Sort2Locatorvalue.sub(1,brw1Sort2Locatorlength.intValue()).concat(" "));
								brw1Sort2Locatorlength.increment(1);
								Main.bankas_k.kods.setValue(brw1Sort2Locatorvalue);
								brw1Locatemode.setValue(Constants.LOCATEONVALUE);
								browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
							}
							else if (ClarionString.chr(CWin.keyChar()).boolValue()) {
								brw1Sort2Locatorvalue.setValue(brw1Sort2Locatorvalue.sub(1,brw1Sort2Locatorlength.intValue()).concat(ClarionString.chr(CWin.keyChar())));
								brw1Sort2Locatorlength.increment(1);
								Main.bankas_k.kods.setValue(brw1Sort2Locatorvalue);
								brw1Locatemode.setValue(Constants.LOCATEONVALUE);
								browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
							}
							case_2_break=true;
						}
					}
				}
			}
		}
		else {
			{
				int case_3=CWin.keyCode();
				if (case_3==Constants.INSERTKEY) {
					CWin.post(Event.ACCEPTED,quickwindow._insert_2);
				}
			}
		}
		browsebankas_k_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
	}
	public static void browsebankas_k_syncwindow(ClarionNumber brw1Recordcount,ClarionNumber brw1Currentchoice,Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse)
	{
		browsebankas_k_brw1Getrecord(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
	}
	public static void browsebankas_k_brw1Selectsort(ClarionNumber brw1Lastsortorder,ClarionNumber brw1Sortorder,ClarionNumber brw1Changed,Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1,ClarionString brw1Sort1Locatorvalue,ClarionNumber brw1Sort1Locatorlength,ClarionString brw1Sort2Locatorvalue,ClarionNumber brw1Sort2Locatorlength,ClarionNumber forcerefresh,ClarionNumber localrequest,ClarionNumber brw1Locatemode,ClarionNumber brw1Refreshmode,ClarionNumber brw1Recordcount,ClarionNumber brw1Currentchoice,ClarionView brw1ViewBrowse,ClarionString brw1Sort1Highvalue,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort1Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort1Keydistribution,ClarionString brw1Sort2Lowvalue,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionNumber brw1Newselectposted,ClarionString brw1Highlightedposition,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst)
	{
		brw1Lastsortorder.setValue(brw1Sortorder);
		brw1Changed.setValue(Constants.FALSE);
		if (CWin.choice(quickwindow._currenttab)==2) {
			brw1Sortorder.setValue(1);
		}
		else {
			brw1Sortorder.setValue(2);
		}
		if (brw1Sortorder.equals(brw1Lastsortorder)) {
			{
				ClarionNumber case_1=brw1Sortorder;
			}
		}
		else {
			{
				ClarionNumber case_2=brw1Sortorder;
				boolean case_2_break=false;
				if (case_2.equals(1)) {
					brw1Sort1Locatorvalue.setValue("");
					brw1Sort1Locatorlength.setValue(0);
					Main.bankas_k.nos_a.setValue(brw1Sort1Locatorvalue);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(2)) {
					brw1Sort2Locatorvalue.setValue("");
					brw1Sort2Locatorlength.setValue(0);
					Main.bankas_k.kods.setValue(brw1Sort2Locatorvalue);
					case_2_break=true;
				}
			}
		}
		if (!brw1Sortorder.equals(brw1Lastsortorder) || brw1Changed.boolValue() || forcerefresh.boolValue()) {
			browsebankas_k_brw1Getrecord(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
			browsebankas_k_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
			if (brw1Lastsortorder.equals(0)) {
				if (localrequest.equals(Constants.SELECTRECORD)) {
					brw1Locatemode.setValue(Constants.LOCATEONVALUE);
					browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
				}
				else {
					queueBrowse_1.free();
					brw1Refreshmode.setValue(Constants.REFRESHONTOP);
					browsebankas_k_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,brw1Sortorder);
					browsebankas_k_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
				}
			}
			else {
				if (brw1Changed.boolValue()) {
					queueBrowse_1.free();
					brw1Refreshmode.setValue(Constants.REFRESHONTOP);
					browsebankas_k_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,brw1Sortorder);
					browsebankas_k_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
				}
				else {
					brw1Locatemode.setValue(Constants.LOCATEONVALUE);
					browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
				}
			}
			if (brw1Recordcount.boolValue()) {
				queueBrowse_1.get(brw1Currentchoice);
				browsebankas_k_brw1Fillbuffer(queueBrowse_1);
			}
			browsebankas_k_brw1Initializebrowse(brw1ViewBrowse,queueBrowse_1,brw1Sortorder,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution);
		}
		else {
			if (brw1Recordcount.boolValue()) {
				queueBrowse_1.get(brw1Currentchoice);
				browsebankas_k_brw1Fillbuffer(queueBrowse_1);
			}
		}
	}
	public static void browsebankas_k_brw1Reset(ClarionView brw1ViewBrowse,ClarionNumber brw1Sortorder,QueueBrowse_1 queueBrowse_1)
	{
		brw1ViewBrowse.close();
		{
			ClarionNumber case_1=brw1Sortorder;
			boolean case_1_break=false;
			if (case_1.equals(1)) {
				Main.bankas_k.nos_key.setStart();
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(2)) {
				Main.bankas_k.kod_key.setStart();
				case_1_break=true;
			}
		}
		if (CError.errorCode()!=0) {
			Winla_sf.standardwarning(Clarion.newNumber(Warn.VIEWOPENERROR));
		}
		brw1ViewBrowse.open();
		if (CError.errorCode()!=0) {
			Winla_sf.standardwarning(Clarion.newNumber(Warn.VIEWOPENERROR));
		}
	}
	public static void browsebankas_k_brw1Getrecord(ClarionNumber brw1Recordcount,ClarionNumber brw1Currentchoice,Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse)
	{
		if (brw1Recordcount.boolValue()) {
			brw1Currentchoice.setValue(CWin.choice(quickwindow._browse_1));
			queueBrowse_1.get(brw1Currentchoice);
			brw1ViewBrowse.watch();
			brw1ViewBrowse.reget(queueBrowse_1.brw1Position);
		}
	}
	public static void browsebankas_k_brw1Processscroll(ClarionNumber brw1Recordcount,ClarionNumber brw1Currentevent,QueueBrowse_1 queueBrowse_1,Quickwindow_1 quickwindow,ClarionNumber brw1Currentchoice,ClarionNumber brw1Newselectposted,ClarionNumber brw1Sortorder,ClarionString brw1Sort1Locatorvalue,ClarionNumber brw1Sort1Locatorlength,ClarionString brw1Sort2Locatorvalue,ClarionNumber brw1Sort2Locatorlength,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionView brw1ViewBrowse,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue)
	{
		if (brw1Recordcount.boolValue()) {
			brw1Currentevent.setValue(CWin.event());
			{
				ClarionNumber case_1=brw1Currentevent;
				boolean case_1_break=false;
				boolean case_1_match=false;
				case_1_match=false;
				if (case_1.equals(Event.SCROLLUP)) {
					case_1_match=true;
				}
				if (case_1_match || case_1.equals(Event.SCROLLDOWN)) {
					browsebankas_k_brw1Scrollone(brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,quickwindow);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Event.PAGEUP)) {
					case_1_match=true;
				}
				if (case_1_match || case_1.equals(Event.PAGEDOWN)) {
					browsebankas_k_brw1Scrollpage(brw1Itemstofill,quickwindow,brw1Filldirection,brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Event.SCROLLTOP)) {
					case_1_match=true;
				}
				if (case_1_match || case_1.equals(Event.SCROLLBOTTOM)) {
					browsebankas_k_brw1Scrollend(queueBrowse_1,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Currentevent,brw1Filldirection,brw1Currentchoice,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,brw1Sortorder);
					case_1_break=true;
				}
			}
			Clarion.getControl(quickwindow._browse_1).setClonedProperty(Prop.SELSTART,brw1Currentchoice);
			browsebankas_k_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
			{
				ClarionNumber case_2=brw1Sortorder;
				boolean case_2_break=false;
				if (case_2.equals(1)) {
					brw1Sort1Locatorvalue.setValue("");
					brw1Sort1Locatorlength.setValue(0);
					Main.bankas_k.nos_a.setValue(brw1Sort1Locatorvalue);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(2)) {
					brw1Sort2Locatorvalue.setValue("");
					brw1Sort2Locatorlength.setValue(0);
					Main.bankas_k.kods.setValue(brw1Sort2Locatorvalue);
					case_2_break=true;
				}
			}
		}
	}
	public static void browsebankas_k_brw1Scrolldrag(Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Sortorder,ClarionArray<ClarionString> brw1Sort1Keydistribution,ClarionNumber brw1Locatemode,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionView brw1ViewBrowse,ClarionString brw1Highlightedposition,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst,ClarionNumber brw1Refreshmode,ClarionNumber brw1Newselectposted,ClarionNumber brw1Currentchoice)
	{
		if (Clarion.getControl(quickwindow._browse_1).getProperty(Prop.VSCROLLPOS).compareTo(1)<=0) {
			CWin.post(Event.SCROLLTOP,quickwindow._browse_1);
		}
		else if (Clarion.getControl(quickwindow._browse_1).getProperty(Prop.VSCROLLPOS).equals(100)) {
			CWin.post(Event.SCROLLBOTTOM,quickwindow._browse_1);
		}
		else {
			{
				ClarionNumber case_1=brw1Sortorder;
				boolean case_1_break=false;
				if (case_1.equals(1)) {
					Main.bankas_k.nos_a.setValue(brw1Sort1Keydistribution.get(Clarion.getControl(quickwindow._browse_1).getProperty(Prop.VSCROLLPOS).intValue()));
					brw1Locatemode.setValue(Constants.LOCATEONVALUE);
					browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(2)) {
					Main.bankas_k.kods.setValue(brw1Sort2Keydistribution.get(Clarion.getControl(quickwindow._browse_1).getProperty(Prop.VSCROLLPOS).intValue()));
					brw1Locatemode.setValue(Constants.LOCATEONVALUE);
					browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
					case_1_break=true;
				}
			}
		}
	}
	public static void browsebankas_k_brw1Callupdate(ClarionView brw1ViewBrowse,ClarionNumber localrequest,ClarionNumber localresponse,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Currentevent,ClarionNumber brw1Currentchoice,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue,Quickwindow_1 quickwindow,ClarionNumber brw1Sortorder,ClarionNumber brw1Locatemode,ClarionString brw1Highlightedposition,ClarionNumber brw1Refreshmode,ClarionNumber brw1Newselectposted,ClarionNumber brw1Currentscroll,ClarionString brw1Sort1Locatorvalue,ClarionString brw1Sort2Locatorvalue,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Sort1Locatorlength,ClarionNumber brw1Sort2Locatorlength,ClarionString brw1Sort1Highvalue,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort1Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort1Keydistribution,ClarionString brw1Sort2Lowvalue,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionString brw1Popuptext)
	{
		brw1ViewBrowse.close();
		while (true) {
			Main.globalrequest.setValue(localrequest);
			Main.vcrrequest.setValue(Constants.VCRNONE);
			Winla002.updatebankas_k();
			localresponse.setValue(Main.globalresponse);
			{
				ClarionNumber case_1=Main.vcrrequest;
				boolean case_1_break=false;
				boolean case_1_match=false;
				case_1_match=false;
				if (case_1.equals(Constants.VCRNONE)) {
					break;
					// UNREACHABLE! :case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Constants.VCRINSERT)) {
					if (localrequest.equals(Constants.CHANGERECORD)) {
						localrequest.setValue(Constants.INSERTRECORD);
					}
					case_1_match=true;
				}
				if (case_1_match || case_1.equals(Constants.VCRFORWARD)) {
					if (localrequest.equals(Constants.INSERTRECORD)) {
						Main.bankas_k.get(Clarion.newString(String.valueOf(0)),null);
						Main.bankas_k.clear(0);
					}
					else {
						browsebankas_k_brw1Postvcredit1(brw1ViewBrowse,brw1Sortorder,queueBrowse_1,brw1Locatemode,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Currentscroll,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution);
						brw1Currentevent.setValue(Event.SCROLLDOWN);
						browsebankas_k_brw1Scrollone(brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,quickwindow);
						browsebankas_k_brw1Postvcredit2(quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,brw1Sortorder,brw1Currentscroll,brw1Sort1Keydistribution,brw1Sort2Keydistribution,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort2Lowvalue,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Constants.VCRBACKWARD)) {
					browsebankas_k_brw1Postvcredit1(brw1ViewBrowse,brw1Sortorder,queueBrowse_1,brw1Locatemode,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Currentscroll,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution);
					brw1Currentevent.setValue(Event.SCROLLUP);
					browsebankas_k_brw1Scrollone(brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,quickwindow);
					browsebankas_k_brw1Postvcredit2(quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,brw1Sortorder,brw1Currentscroll,brw1Sort1Keydistribution,brw1Sort2Keydistribution,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort2Lowvalue,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Constants.VCRPAGEFORWARD)) {
					browsebankas_k_brw1Postvcredit1(brw1ViewBrowse,brw1Sortorder,queueBrowse_1,brw1Locatemode,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Currentscroll,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution);
					brw1Currentevent.setValue(Event.PAGEDOWN);
					browsebankas_k_brw1Scrollpage(brw1Itemstofill,quickwindow,brw1Filldirection,brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue);
					browsebankas_k_brw1Postvcredit2(quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,brw1Sortorder,brw1Currentscroll,brw1Sort1Keydistribution,brw1Sort2Keydistribution,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort2Lowvalue,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Constants.VCRPAGEBACKWARD)) {
					browsebankas_k_brw1Postvcredit1(brw1ViewBrowse,brw1Sortorder,queueBrowse_1,brw1Locatemode,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Currentscroll,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution);
					brw1Currentevent.setValue(Event.PAGEUP);
					browsebankas_k_brw1Scrollpage(brw1Itemstofill,quickwindow,brw1Filldirection,brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue);
					browsebankas_k_brw1Postvcredit2(quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,brw1Sortorder,brw1Currentscroll,brw1Sort1Keydistribution,brw1Sort2Keydistribution,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort2Lowvalue,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Constants.VCRFIRST)) {
					browsebankas_k_brw1Postvcredit1(brw1ViewBrowse,brw1Sortorder,queueBrowse_1,brw1Locatemode,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Currentscroll,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution);
					brw1Currentevent.setValue(Event.SCROLLTOP);
					browsebankas_k_brw1Scrollend(queueBrowse_1,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Currentevent,brw1Filldirection,brw1Currentchoice,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,brw1Sortorder);
					browsebankas_k_brw1Postvcredit2(quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,brw1Sortorder,brw1Currentscroll,brw1Sort1Keydistribution,brw1Sort2Keydistribution,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort2Lowvalue,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Constants.VCRLAST)) {
					browsebankas_k_brw1Postvcredit1(brw1ViewBrowse,brw1Sortorder,queueBrowse_1,brw1Locatemode,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Currentscroll,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution);
					brw1Currentevent.setValue(Event.SCROLLBOTTOM);
					browsebankas_k_brw1Scrollend(queueBrowse_1,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Currentevent,brw1Filldirection,brw1Currentchoice,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,brw1Sortorder);
					browsebankas_k_brw1Postvcredit2(quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,brw1Sortorder,brw1Currentscroll,brw1Sort1Keydistribution,brw1Sort2Keydistribution,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort2Lowvalue,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
					case_1_break=true;
				}
			}
		}
		browsebankas_k_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
		Main.copyrequest.setValue(0);
	}
	public static void browsebankas_k_listboxdispatch(Browsebuttons browsebuttons,QueueBrowse_1 queueBrowse_1,ClarionNumber toolbarmode)
	{
		browsebankas_k_displaybrowsetoolbar(browsebuttons,queueBrowse_1,toolbarmode);
		if (CWin.accepted()!=0) {
			{
				int execute_1=CWin.accepted()-Constants.TBARBRWBOTTOM+1;
				if (execute_1==1) {
					CWin.post(Event.SCROLLBOTTOM,browsebuttons.listbox.intValue());
				}
				if (execute_1==2) {
					CWin.post(Event.SCROLLTOP,browsebuttons.listbox.intValue());
				}
				if (execute_1==3) {
					CWin.post(Event.PAGEDOWN,browsebuttons.listbox.intValue());
				}
				if (execute_1==4) {
					CWin.post(Event.PAGEUP,browsebuttons.listbox.intValue());
				}
				if (execute_1==5) {
					CWin.post(Event.SCROLLDOWN,browsebuttons.listbox.intValue());
				}
				if (execute_1==6) {
					CWin.post(Event.SCROLLUP,browsebuttons.listbox.intValue());
				}
				if (execute_1==7) {
					CWin.post(Event.LOCATE,browsebuttons.listbox.intValue());
				}
				if (execute_1==8) {
				}
				if (execute_1==9) {
					CWin.pressKey(Constants.F1KEY);
				}
			}
		}
	}
	public static void browsebankas_k_brw1Newselection(ClarionNumber brw1Newselectposted,ClarionString brw1Popuptext,ClarionNumber brw1Recordcount,ClarionNumber localrequest,QueueBrowse_1 queueBrowse_1,Quickwindow_1 quickwindow,ClarionNumber brw1Currentchoice,ClarionNumber brw1Sortorder,ClarionNumber brw1Currentscroll,ClarionArray<ClarionString> brw1Sort1Keydistribution,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionString brw1Sort1Locatorvalue,ClarionString brw1Sort2Locatorvalue,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Sort1Locatorlength,ClarionNumber brw1Sort2Locatorlength,ClarionNumber brw1Locatemode,ClarionNumber brw1Refreshmode,ClarionView brw1ViewBrowse,ClarionString brw1Sort1Highvalue,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort1Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionString brw1Sort2Lowvalue,ClarionString brw1Highlightedposition,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst)
	{
		brw1Newselectposted.setValue(Constants.FALSE);
		if (CWin.keyCode()==Constants.MOUSERIGHT) {
			brw1Popuptext.setValue("");
			if (brw1Recordcount.boolValue()) {
				if (localrequest.equals(Constants.SELECTRECORD)) {
					brw1Popuptext.setValue("Iz&v�l�ties");
				}
				else {
					brw1Popuptext.setValue("~Iz&v�l�ties");
				}
				if (brw1Popuptext.boolValue()) {
					brw1Popuptext.setValue(ClarionString.staticConcat("&Ievad�t|&Main�t|&Dz�st|-|",brw1Popuptext));
				}
				else {
					brw1Popuptext.setValue("&Ievad�t|&Main�t|&Dz�st");
				}
			}
			else {
				brw1Popuptext.setValue("~Iz&v�l�ties");
				if (brw1Popuptext.boolValue()) {
					brw1Popuptext.setValue(ClarionString.staticConcat("&Ievad�t|~&Main�t|~&Dz�st|-|",brw1Popuptext));
				}
				else {
					brw1Popuptext.setValue("&Ievad�t|~&Main�t|~&Dz�st");
				}
			}
			{
				int execute_1=CWin.popup(brw1Popuptext.toString());
				if (execute_1==1) {
					CWin.post(Event.ACCEPTED,quickwindow._insert_2);
				}
				if (execute_1==2) {
					CWin.post(Event.ACCEPTED,quickwindow._change);
				}
				if (execute_1==3) {
					CWin.post(Event.ACCEPTED,quickwindow._delete_2);
				}
				if (execute_1==4) {
					CWin.post(Event.ACCEPTED,quickwindow._select);
				}
			}
		}
		else if (brw1Recordcount.boolValue()) {
			brw1Currentchoice.setValue(CWin.choice(quickwindow._browse_1));
			queueBrowse_1.get(brw1Currentchoice);
			browsebankas_k_brw1Fillbuffer(queueBrowse_1);
			if (brw1Recordcount.equals(Clarion.getControl(quickwindow._browse_1).getProperty(Prop.ITEMS))) {
				if (Clarion.getControl(quickwindow._browse_1).getProperty(Prop.VSCROLL).equals(Constants.FALSE)) {
					Clarion.getControl(quickwindow._browse_1).setProperty(Prop.VSCROLL,Constants.TRUE);
				}
				{
					ClarionNumber case_1=brw1Sortorder;
					boolean case_1_break=false;
					if (case_1.equals(1)) {
						for (brw1Currentscroll.setValue(1);brw1Currentscroll.compareTo(100)<=0;brw1Currentscroll.increment(1)) {
							if (brw1Sort1Keydistribution.get(brw1Currentscroll.intValue()).compareTo(Main.bankas_k.nos_a.upper())>=0) {
								if (brw1Currentscroll.compareTo(1)<=0) {
									brw1Currentscroll.setValue(0);
								}
								else if (brw1Currentscroll.equals(100)) {
									brw1Currentscroll.setValue(100);
								}
								else {
								}
								break;
							}
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1.equals(2)) {
						for (brw1Currentscroll.setValue(1);brw1Currentscroll.compareTo(100)<=0;brw1Currentscroll.increment(1)) {
							if (brw1Sort2Keydistribution.get(brw1Currentscroll.intValue()).compareTo(Main.bankas_k.kods.upper())>=0) {
								if (brw1Currentscroll.compareTo(1)<=0) {
									brw1Currentscroll.setValue(0);
								}
								else if (brw1Currentscroll.equals(100)) {
									brw1Currentscroll.setValue(100);
								}
								else {
								}
								break;
							}
						}
						case_1_break=true;
					}
				}
			}
			else {
				if (Clarion.getControl(quickwindow._browse_1).getProperty(Prop.VSCROLL).equals(Constants.TRUE)) {
					Clarion.getControl(quickwindow._browse_1).setProperty(Prop.VSCROLL,Constants.FALSE);
				}
			}
			browsebankas_k_refreshwindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
		}
	}
	public static void browsebankas_k_initializewindow(Quickwindow_1 quickwindow,ClarionNumber brw1Currentscroll,ClarionNumber brw1Sortorder,ClarionString brw1Sort1Locatorvalue,QueueBrowse_1 queueBrowse_1,ClarionString brw1Sort2Locatorvalue,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Sort1Locatorlength,ClarionNumber brw1Sort2Locatorlength,ClarionNumber localrequest,ClarionNumber brw1Locatemode,ClarionNumber brw1Refreshmode,ClarionNumber brw1Recordcount,ClarionNumber brw1Currentchoice,ClarionView brw1ViewBrowse,ClarionString brw1Sort1Highvalue,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort1Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort1Keydistribution,ClarionString brw1Sort2Lowvalue,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionNumber brw1Newselectposted,ClarionString brw1Highlightedposition,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst)
	{
		browsebankas_k_refreshwindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
	}
	public static void browsebankas_k_brw1Fillbuffer(QueueBrowse_1 queueBrowse_1)
	{
		Main.bankas_k.kods.setValue(queueBrowse_1.brw1BanKods);
		Main.bankas_k.nos_s.setValue(queueBrowse_1.brw1BanNos_s);
		Main.bankas_k.nos_p.setValue(queueBrowse_1.brw1BanNos_p);
		Main.bankas_k.nos_a.setValue(queueBrowse_1.brw1BanNos_a);
	}
	public static void browsebankas_k_refreshwindow(Quickwindow_1 quickwindow,ClarionNumber brw1Currentscroll,ClarionNumber brw1Sortorder,ClarionString brw1Sort1Locatorvalue,QueueBrowse_1 queueBrowse_1,ClarionString brw1Sort2Locatorvalue,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Sort1Locatorlength,ClarionNumber brw1Sort2Locatorlength,ClarionNumber localrequest,ClarionNumber brw1Locatemode,ClarionNumber brw1Refreshmode,ClarionNumber brw1Recordcount,ClarionNumber brw1Currentchoice,ClarionView brw1ViewBrowse,ClarionString brw1Sort1Highvalue,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort1Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort1Keydistribution,ClarionString brw1Sort2Lowvalue,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionNumber brw1Newselectposted,ClarionString brw1Highlightedposition,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst)
	{
		if (quickwindow.getProperty(Prop.ACCEPTALL).boolValue()) {
			return;
		}
		browsebankas_k_brw1Selectsort(brw1Lastsortorder,brw1Sortorder,brw1Changed,quickwindow,queueBrowse_1,brw1Sort1Locatorvalue,brw1Sort1Locatorlength,brw1Sort2Locatorvalue,brw1Sort2Locatorlength,forcerefresh,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
		Clarion.getControl(quickwindow._browse_1).setClonedProperty(Prop.VSCROLLPOS,brw1Currentscroll);
		{
			ClarionNumber case_1=brw1Sortorder;
			boolean case_1_break=false;
			if (case_1.equals(1)) {
				Main.bankas_k.nos_a.setValue(brw1Sort1Locatorvalue);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(2)) {
				Main.bankas_k.kods.setValue(brw1Sort2Locatorvalue);
				case_1_break=true;
			}
		}
		CWin.display();
		forcerefresh.setValue(Constants.FALSE);
	}
	public static void browsebankas_k_brw1Refreshpage(ClarionNumber brw1Refreshmode,ClarionString brw1Highlightedposition,ClarionView brw1ViewBrowse,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Currentchoice,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,Quickwindow_1 quickwindow,ClarionNumber brw1Filldirection,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue,ClarionNumber brw1Sortorder)
	{
		System.out.println("BRW1::RefreshPage ======== ");
		CWin.setCursor(Cursor.WAIT);
		if (brw1Refreshmode.equals(Constants.REFRESHONPOSITION)) {
			brw1Highlightedposition.setValue(brw1ViewBrowse.getPosition());
			brw1ViewBrowse.reset(brw1Highlightedposition);
			brw1Refreshmode.setValue(Constants.REFRESHONTOP);
		}
		else if (queueBrowse_1.records()!=0) {
			queueBrowse_1.get(brw1Currentchoice);
			if (CError.errorCode()!=0) {
				queueBrowse_1.get(queueBrowse_1.records());
			}
			brw1Highlightedposition.setValue(queueBrowse_1.brw1Position);
			queueBrowse_1.get(1);
			brw1ViewBrowse.reset(queueBrowse_1.brw1Position);
			brw1Refreshmode.setValue(Constants.REFRESHONCURRENT);
		}
		else {
			brw1Highlightedposition.setValue("");
			browsebankas_k_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
		}
		queueBrowse_1.free();
		brw1Recordcount.setValue(0);
		brw1Itemstofill.setValue(Clarion.getControl(quickwindow._browse_1).getProperty(Prop.ITEMS));
		if (brw1Refreshmode.equals(Constants.REFRESHONBOTTOM)) {
			brw1Filldirection.setValue(Constants.FILLBACKWARD);
		}
		else {
			brw1Filldirection.setValue(Constants.FILLFORWARD);
		}
		browsebankas_k_brw1Fillrecord(brw1Recordcount,brw1Filldirection,queueBrowse_1,brw1ViewBrowse,brw1Skipfirst,brw1Itemstofill,brw1Addqueue,quickwindow);
		CWin.setCursor(null);
		return;
		// UNREACHABLE! :if (brw1Highlightedposition.boolValue()) {
			// UNREACHABLE! :if (brw1Itemstofill.boolValue()) {
				// UNREACHABLE! :if (!brw1Recordcount.boolValue()) {
					// UNREACHABLE! :browsebankas_k_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
				// UNREACHABLE! :}
				// UNREACHABLE! :if (brw1Refreshmode.equals(Constants.REFRESHONBOTTOM)) {
					// UNREACHABLE! :brw1Filldirection.setValue(Constants.FILLFORWARD);
				// UNREACHABLE! :}
				// UNREACHABLE! :else {
					// UNREACHABLE! :brw1Filldirection.setValue(Constants.FILLBACKWARD);
				// UNREACHABLE! :}
				// UNREACHABLE! :browsebankas_k_brw1Fillrecord(brw1Recordcount,brw1Filldirection,queueBrowse_1,brw1ViewBrowse,brw1Skipfirst,brw1Itemstofill,brw1Addqueue,quickwindow);
			// UNREACHABLE! :}
		// UNREACHABLE! :}
		// UNREACHABLE! :if (brw1Recordcount.boolValue()) {
			// UNREACHABLE! :{
				// UNREACHABLE! :ClarionNumber case_1=brw1Sortorder;
				// UNREACHABLE! :boolean case_1_break=false;
				// UNREACHABLE! :if (case_1.equals(1)) {
					// UNREACHABLE! :Clarion.getControl(quickwindow._banNos_a).setProperty(Prop.DISABLE,0);
					// UNREACHABLE! :case_1_break=true;
				// UNREACHABLE! :}
				// UNREACHABLE! :if (!case_1_break && case_1.equals(2)) {
					// UNREACHABLE! :Clarion.getControl(quickwindow._banKods).setProperty(Prop.DISABLE,0);
					// UNREACHABLE! :case_1_break=true;
				// UNREACHABLE! :}
			// UNREACHABLE! :}
			// UNREACHABLE! :if (brw1Highlightedposition.boolValue()) {
				// UNREACHABLE! :final ClarionNumber loop_1=brw1Recordcount.like();for (brw1Currentchoice.setValue(1);brw1Currentchoice.compareTo(loop_1)<=0;brw1Currentchoice.increment(1)) {
					// UNREACHABLE! :queueBrowse_1.get(brw1Currentchoice);
					// UNREACHABLE! :if (queueBrowse_1.brw1Position.equals(brw1Highlightedposition)) {
						// UNREACHABLE! :break;
					// UNREACHABLE! :}
				// UNREACHABLE! :}
				// UNREACHABLE! :if (brw1Currentchoice.compareTo(brw1Recordcount)>0) {
					// UNREACHABLE! :brw1Currentchoice.setValue(brw1Recordcount);
				// UNREACHABLE! :}
			// UNREACHABLE! :}
			// UNREACHABLE! :else {
				// UNREACHABLE! :if (brw1Refreshmode.equals(Constants.REFRESHONBOTTOM)) {
					// UNREACHABLE! :brw1Currentchoice.setValue(queueBrowse_1.records());
				// UNREACHABLE! :}
				// UNREACHABLE! :else {
					// UNREACHABLE! :brw1Currentchoice.setValue(1);
				// UNREACHABLE! :}
			// UNREACHABLE! :}
			// UNREACHABLE! :Clarion.getControl(quickwindow._browse_1).setClonedProperty(Prop.SELECTED,brw1Currentchoice);
			// UNREACHABLE! :browsebankas_k_brw1Fillbuffer(queueBrowse_1);
			// UNREACHABLE! :Clarion.getControl(quickwindow._change).setProperty(Prop.DISABLE,0);
			// UNREACHABLE! :Clarion.getControl(quickwindow._delete_2).setProperty(Prop.DISABLE,0);
		// UNREACHABLE! :}
		// UNREACHABLE! :else {
			// UNREACHABLE! :Main.bankas_k.clear();
			// UNREACHABLE! :{
				// UNREACHABLE! :ClarionNumber case_2=brw1Sortorder;
				// UNREACHABLE! :boolean case_2_break=false;
				// UNREACHABLE! :if (case_2.equals(1)) {
					// UNREACHABLE! :Clarion.getControl(quickwindow._banNos_a).setProperty(Prop.DISABLE,1);
					// UNREACHABLE! :case_2_break=true;
				// UNREACHABLE! :}
				// UNREACHABLE! :if (!case_2_break && case_2.equals(2)) {
					// UNREACHABLE! :Clarion.getControl(quickwindow._banKods).setProperty(Prop.DISABLE,1);
					// UNREACHABLE! :case_2_break=true;
				// UNREACHABLE! :}
			// UNREACHABLE! :}
			// UNREACHABLE! :brw1Currentchoice.setValue(0);
			// UNREACHABLE! :Clarion.getControl(quickwindow._change).setProperty(Prop.DISABLE,1);
			// UNREACHABLE! :Clarion.getControl(quickwindow._delete_2).setProperty(Prop.DISABLE,1);
		// UNREACHABLE! :}
		// UNREACHABLE! :CWin.setCursor(null);
		// UNREACHABLE! :brw1Refreshmode.setValue(0);
		// UNREACHABLE! :return;
	}
	public static void browsebankas_k_brw1Postnewselection(ClarionNumber brw1Newselectposted,Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1)
	{
		if (!brw1Newselectposted.boolValue()) {
			brw1Newselectposted.setValue(Constants.TRUE);
			CWin.post(Event.NEWSELECTION,quickwindow._browse_1);
		}
	}
	public static void browsebankas_k_brw1Fillrecord(ClarionNumber brw1Recordcount,ClarionNumber brw1Filldirection,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse,ClarionNumber brw1Skipfirst,ClarionNumber brw1Itemstofill,ClarionNumber brw1Addqueue,Quickwindow_1 quickwindow)
	{
		System.out.println("BRW1::FillRecord ======== ");
		if (brw1Recordcount.boolValue()) {
			if (brw1Filldirection.equals(Constants.FILLFORWARD)) {
				queueBrowse_1.get(brw1Recordcount);
			}
			else {
				queueBrowse_1.get(1);
			}
			System.out.println("BRW1::FillRecord RESET "+queueBrowse_1.brw1Position.toString());
			brw1ViewBrowse.reset(queueBrowse_1.brw1Position);
			brw1Skipfirst.setValue(Constants.TRUE);
		}
		else {
			brw1Skipfirst.setValue(Constants.FALSE);
		}
		while (brw1Itemstofill.boolValue()) {
			if (brw1Filldirection.equals(Constants.FILLFORWARD)) {
				System.out.println("BRW1::FillRecord NEXT ");
				brw1ViewBrowse.next();
			}
			else {
				System.out.println("BRW1::FillRecord PREVIOUS ");
				brw1ViewBrowse.previous();
			}
			if (CError.errorCode()!=0) {
				System.out.println("BRW1::FillRecord Errorcode "+CError.errorCode());
				if (CError.errorCode()==Constants.BADRECERR) {
					browsebankas_k_brw1Restoreresetvalues();
					break;
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("BANKAS_K"));
					CWin.post(Event.CLOSEWINDOW);
					return;
				}
			}
			if (brw1Skipfirst.boolValue()) {
				brw1Skipfirst.setValue(Constants.FALSE);
				if (brw1ViewBrowse.getPosition().equals(queueBrowse_1.brw1Position)) {
					continue;
				}
			}
			if (brw1Addqueue.boolValue()) {
				if (brw1Recordcount.equals(Clarion.getControl(quickwindow._browse_1).getProperty(Prop.ITEMS))) {
					if (brw1Filldirection.equals(Constants.FILLFORWARD)) {
						queueBrowse_1.get(1);
					}
					else {
						queueBrowse_1.get(brw1Recordcount);
					}
					System.out.println("BRW1::FillRecord DELETE Queue:Browse ");
					queueBrowse_1.delete();
					brw1Recordcount.decrement(1);
				}
				browsebankas_k_brw1Fillqueue(queueBrowse_1,brw1ViewBrowse);
				System.out.println("BRW1::FillRecord ADD Queue:Browse ");
				if (brw1Filldirection.equals(Constants.FILLFORWARD)) {
					queueBrowse_1.add();
				}
				else {
					queueBrowse_1.add(1);
				}
				brw1Recordcount.increment(1);
			}
			brw1Itemstofill.decrement(1);
		}
		brw1Addqueue.setValue(Constants.TRUE);
		return;
	}
	public static void browsebankas_k_brw1Buttonchange(ClarionNumber localrequest,ClarionNumber brw1Locatemode,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse,ClarionNumber brw1Sortorder,ClarionString brw1Highlightedposition,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst,Quickwindow_1 quickwindow,ClarionNumber brw1Refreshmode,ClarionNumber brw1Newselectposted,ClarionNumber brw1Currentchoice,ClarionString brw1Sort1Highvalue,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort1Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort1Keydistribution,ClarionString brw1Sort2Lowvalue,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionNumber originalrequest,ClarionNumber localresponse,ClarionNumber brw1Currentscroll,ClarionString brw1Sort1Locatorvalue,ClarionString brw1Sort2Locatorvalue,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Sort1Locatorlength,ClarionNumber brw1Sort2Locatorlength,ClarionNumber brw1Currentevent,ClarionString brw1Popuptext)
	{
		localrequest.setValue(Constants.CHANGERECORD);
		browsebankas_k_brw1Callupdate(brw1ViewBrowse,localrequest,localresponse,queueBrowse_1,brw1Currentevent,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Skipfirst,brw1Addqueue,quickwindow,brw1Sortorder,brw1Locatemode,brw1Highlightedposition,brw1Refreshmode,brw1Newselectposted,brw1Currentscroll,brw1Sort1Locatorvalue,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Popuptext);
		if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
			brw1Locatemode.setValue(Constants.LOCATEONEDIT);
			browsebankas_k_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
		}
		else {
			brw1Refreshmode.setValue(Constants.REFRESHONQUEUE);
			browsebankas_k_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,brw1Sortorder);
		}
		browsebankas_k_brw1Initializebrowse(brw1ViewBrowse,queueBrowse_1,brw1Sortorder,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution);
		browsebankas_k_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
		CWin.select(quickwindow._browse_1);
		localrequest.setValue(originalrequest);
		localresponse.setValue(Constants.REQUESTCANCELLED);
		browsebankas_k_refreshwindow(quickwindow,brw1Currentscroll,brw1Sortorder,brw1Sort1Locatorvalue,queueBrowse_1,brw1Sort2Locatorvalue,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort1Locatorlength,brw1Sort2Locatorlength,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort1Highvalue,brw1Sort2Highvalue,brw1Sort1Lowvalue,brw1Scrollrecordcount,brw1Sort1Keydistribution,brw1Sort2Lowvalue,brw1Sort2Keydistribution,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
	}
	public static void browsebankas_k_updatedispatch(Browsebuttons browsebuttons,QueueBrowse_1 queueBrowse_1)
	{
		CWin.disable(Constants.TBARBRWDELETE);
		CWin.disable(Constants.TBARBRWCHANGE);
		if (browsebuttons.deletebutton.boolValue() && Clarion.getControl(browsebuttons.deletebutton).getProperty(Prop.DISABLE).equals(0)) {
			CWin.enable(Constants.TBARBRWDELETE);
		}
		if (browsebuttons.changebutton.boolValue() && Clarion.getControl(browsebuttons.changebutton).getProperty(Prop.DISABLE).equals(0)) {
			CWin.enable(Constants.TBARBRWCHANGE);
		}
		if (CRun.inRange(Clarion.newNumber(CWin.accepted()),Clarion.newNumber(Constants.TBARBRWINSERT),Clarion.newNumber(Constants.TBARBRWDELETE))) {
			{
				int execute_1=CWin.accepted()-Constants.TBARBRWINSERT+1;
				if (execute_1==1) {
					CWin.post(Event.ACCEPTED,browsebuttons.insertbutton.intValue());
				}
				if (execute_1==2) {
					CWin.post(Event.ACCEPTED,browsebuttons.changebutton.intValue());
				}
				if (execute_1==3) {
					CWin.post(Event.ACCEPTED,browsebuttons.deletebutton.intValue());
				}
			}
		}
	}
}
