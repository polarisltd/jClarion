package clarion.winla001;

import clarion.Main;
import clarion.Nodalas;
import clarion.equates.Appstrat;
import clarion.equates.Button;
import clarion.equates.Constants;
import clarion.equates.Cursor;
import clarion.equates.Event;
import clarion.equates.Prop;
import clarion.equates.Scrollsort;
import clarion.equates.Warn;
import clarion.rescode.Windowresizetype;
import clarion.winla001.Appframe;
import clarion.winla001.Browsebuttons;
import clarion.winla001.Brw1ViewBrowse;
import clarion.winla001.Ftp_window;
import clarion.winla001.QueueBrowse_1;
import clarion.winla001.Quickwindow;
import clarion.winla001.Quickwindow_1;
import clarion.winla001.Tfile_b;
import clarion.winla043.Winla043;
import clarion.winla048.Winla048;
import clarion.winla_rd.Winla_rd;
import clarion.winla_ru.Winla_ru;
import clarion.winla_sf.Winla_sf;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionRoutineResult;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Winla001
{
	public static Nodalas updatenodalas_historyNodRecord;
	public static ClarionNumber updatenodalas_windowxpos;
	public static ClarionNumber updatenodalas_windowypos;
	public static ClarionBool updatenodalas_windowposinit;
	public static ClarionString main_tname_b;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		__static_init();
	}

	public static void __static_init() {
		updatenodalas_historyNodRecord=new Nodalas();
		updatenodalas_windowxpos=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		updatenodalas_windowypos=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		updatenodalas_windowposinit=Clarion.newBool(Constants.FALSE);
		main_tname_b=Clarion.newString(70);
	}


	public static void updatenodalas()
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
		ClarionNumber updateReloop=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber updateError=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Nodalas savNodRecord=new Nodalas();
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
			if (CWin.keyCode()==Constants.MOUSERIGHT) {
				CWin.setKeyCode(0);
			}
			System.out.println("update nodalas");
			try {
				updatenodalas_prepareprocedure(filesopened,savNodRecord,localrequest,localresponse,quickwindow,windowopened,winresize);
			} catch (ClarionRoutineResult _crr) {
				return;
			}
			{
				ClarionNumber case_1=localrequest;
				boolean case_1_break=false;
				if (case_1.equals(Constants.INSERTRECORD)) {
					actionmessage.setValue("Ieraksts tiks pievienots");
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
					actionmessage.setValue("Ieraksts tiks main�ts");
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
							updatenodalas_historyfield(quickwindow);
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==Event.CLOSEWINDOW) {
						updatenodalas_closingwindow(updateReloop,localresponse);
						if (updateReloop.boolValue()) {
							continue;
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==Event.CLOSEDOWN) {
						updatenodalas_closingwindow(updateReloop,localresponse);
						if (updateReloop.boolValue()) {
							continue;
						}
						winresize.destroy();
						case_2_break=true;
					}
					if (!case_2_break && case_2==Event.OPENWINDOW) {
						updatenodalas_formAssignbuttons(toolbarmode,originalrequest);
						if (!windowinitialized.boolValue()) {
							updatenodalas_initializewindow(quickwindow,forcerefresh);
							windowinitialized.setValue(Constants.TRUE);
						}
						CWin.select(quickwindow._nodU_nrPrompt);
						case_2_break=true;
					}
					if (!case_2_break && case_2==Event.GAINFOCUS) {
						forcerefresh.setValue(Constants.TRUE);
						if (!windowinitialized.boolValue()) {
							updatenodalas_initializewindow(quickwindow,forcerefresh);
							windowinitialized.setValue(Constants.TRUE);
						}
						else {
							updatenodalas_refreshwindow(quickwindow,forcerefresh);
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==Event.SIZED) {
						winresize.resize();
						forcerefresh.setValue(Constants.TRUE);
						updatenodalas_refreshwindow(quickwindow,forcerefresh);
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
							updatenodalas_historyfield(quickwindow);
						}
						if (CWin.event()==Event.COMPLETED) {
							Winla001.updatenodalas_historyNodRecord.setValue(Main.nodalas.getString());
							{
								ClarionNumber case_3=localrequest;
								boolean case_3_break=false;
								if (case_3.equals(Constants.INSERTRECORD)) {
									Main.nodalas.add();
									{
										int case_4=CError.errorCode();
										boolean case_4_break=false;
										if (case_4==Constants.NOERROR) {
											localresponse.setValue(Constants.REQUESTCOMPLETED);
											CWin.post(Event.CLOSEWINDOW);
											case_4_break=true;
										}
										if (!case_4_break && case_4==Constants.DUPKEYERR) {
											if (Main.nodalas.nr_key.duplicateCheck()) {
												if (Winla_sf.standardwarning(Clarion.newNumber(Warn.DUPLICATEKEY),Clarion.newString("NOD:Nr_Key")).boolValue()) {
													CWin.select(quickwindow._nodU_nrPrompt);
													Main.vcrrequest.setValue(Constants.VCRNONE);
													continue;
												}
											}
											case_4_break=true;
										}
										if (!case_4_break) {
											if (Winla_sf.standardwarning(Clarion.newNumber(Warn.INSERTERROR)).boolValue()) {
												CWin.select(quickwindow._nodU_nrPrompt);
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
										if (!savNodRecord.getString().equals(Main.nodalas.getString())) {
											recordchanged.setValue(Constants.TRUE);
										}
										if (recordchanged.boolValue()) {
											updateError.setValue(Winla_ru.riupdateNodalas(Clarion.newNumber(1)));
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
											CWin.select(quickwindow._nodU_nrPrompt);
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
								updatenodalas_refreshwindow(quickwindow,forcerefresh);
								case_8_break=true;
							}
							if (!case_8_break && case_8==Event.NEWSELECTION) {
								{
									int case_9=CWin.choice(quickwindow._currenttab);
									if (case_9==1) {
										updatenodalas_formAssignbuttons(toolbarmode,originalrequest);
									}
								}
								updatenodalas_refreshwindow(quickwindow,forcerefresh);
								case_8_break=true;
							}
							if (!case_8_break && case_8==Event.TABCHANGING) {
								updatenodalas_refreshwindow(quickwindow,forcerefresh);
								case_8_break=true;
							}
							if (!case_8_break && case_8==Event.SELECTED) {
								updatenodalas_refreshwindow(quickwindow,forcerefresh);
								case_8_break=true;
							}
						}
						case_7_break=true;
					}
					if (!case_7_break && case_7==quickwindow._nodSvars) {
						{
							int case_10=CWin.event();
							if (case_10==Event.ACCEPTED) {
								if (Main.nodalas.svars.compareTo(100)>0) {
									if (Winla_sf.standardwarning(Clarion.newNumber(Warn.OUTOFRANGEHIGH),Clarion.newString("NOD:SVARS"),Clarion.newString("100")).boolValue()) {
										CWin.select(quickwindow._nodSvars);
										quickwindow.setProperty(Prop.ACCEPTALL,Constants.FALSE);
										continue;
									}
								}
							}
						}
						case_7_break=true;
					}
					if (!case_7_break && case_7==quickwindow._ok) {
						{
							int case_11=CWin.event();
							if (case_11==Event.ACCEPTED) {
								updatenodalas_syncwindow();
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
								updatenodalas_syncwindow();
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
				updatenodalas_procedurereturn(filesopened,windowopened,quickwindow,localresponse);
			} catch (ClarionRoutineResult _crr) {
				return;
			}
		} finally {
			quickwindow.close();
		}
	}
	public static void updatenodalas_closingwindow(ClarionNumber updateReloop,ClarionNumber localresponse)
	{
		updateReloop.setValue(0);
		if (!localresponse.equals(Constants.REQUESTCOMPLETED)) {
			updatenodalas_cancelautoincrement(localresponse);
		}
	}
	public static void updatenodalas_procedurereturn(ClarionNumber filesopened,ClarionNumber windowopened,Quickwindow quickwindow,ClarionNumber localresponse) throws ClarionRoutineResult
	{
		if (filesopened.boolValue()) {
			Main.nodalasUsed.decrement(1);
			if (Main.nodalasUsed.equals(0)) {
				Main.nodalas.close();
			}
		}
		if (windowopened.boolValue()) {
			Winla_sf.inisavewindow(Clarion.newString("UpdateNodalas"),Clarion.newString("winlats.INI"));
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
	public static void updatenodalas_initializewindow(Quickwindow quickwindow,ClarionNumber forcerefresh)
	{
		updatenodalas_refreshwindow(quickwindow,forcerefresh);
	}
	public static void updatenodalas_refreshwindow(Quickwindow quickwindow,ClarionNumber forcerefresh)
	{
		if (quickwindow.getProperty(Prop.ACCEPTALL).boolValue()) {
			return;
		}
		CWin.display();
		forcerefresh.setValue(Constants.FALSE);
	}
	public static void updatenodalas_syncwindow()
	{
	}
	public static void updatenodalas_primefields(Nodalas savNodRecord)
	{
		Main.nodalas.setValue(savNodRecord.getString());
		savNodRecord.setValue(Main.nodalas.getString());
	}
	public static void updatenodalas_formAssignbuttons(ClarionNumber toolbarmode,ClarionNumber originalrequest)
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
	public static void updatenodalas_historyfield(Quickwindow quickwindow)
	{
		{
			int case_1=CWin.focus();
			boolean case_1_break=false;
			if (case_1==quickwindow._nodU_nr) {
				Main.nodalas.u_nr.setValue(Winla001.updatenodalas_historyNodRecord.u_nr);
				case_1_break=true;
			}
			if (!case_1_break && case_1==quickwindow._nodKods) {
				Main.nodalas.kods.setValue(Winla001.updatenodalas_historyNodRecord.kods);
				case_1_break=true;
			}
			if (!case_1_break && case_1==quickwindow._nodNos_p) {
				Main.nodalas.nos_p.setValue(Winla001.updatenodalas_historyNodRecord.nos_p);
				case_1_break=true;
			}
			if (!case_1_break && case_1==quickwindow._nodSvars) {
				Main.nodalas.svars.setValue(Winla001.updatenodalas_historyNodRecord.svars);
				case_1_break=true;
			}
		}
		CWin.display();
	}
	public static void updatenodalas_cancelautoincrement(ClarionNumber localresponse)
	{
		if (!localresponse.equals(Constants.REQUESTCOMPLETED)) {
		}
	}
	public static void updatenodalas_prepareprocedure(ClarionNumber filesopened,Nodalas savNodRecord,ClarionNumber localrequest,ClarionNumber localresponse,Quickwindow quickwindow,ClarionNumber windowopened,Windowresizetype winresize) throws ClarionRoutineResult
	{
		if (Main.nodalasUsed.equals(0)) {
			Winla_sf.checkopen(Main.nodalas,Clarion.newNumber(1));
		}
		Main.nodalasUsed.increment(1);
		CExpression.bind(Main.nodalas);
		filesopened.setValue(Constants.TRUE);
		Winla_ru.risnapNodalas();
		savNodRecord.setValue(Main.nodalas.getString());
		if (localrequest.equals(Constants.INSERTRECORD)) {
			localresponse.setValue(Constants.REQUESTCOMPLETED);
			updatenodalas_primefields(savNodRecord);
			if (localresponse.equals(Constants.REQUESTCANCELLED)) {
				updatenodalas_procedurereturn(filesopened,windowopened,quickwindow,localresponse);
			}
			localresponse.setValue(Constants.REQUESTCANCELLED);
		}
		if (localrequest.equals(Constants.DELETERECORD)) {
			if (Winla_sf.standardwarning(Clarion.newNumber(Warn.STANDARDDELETE)).equals(Button.OK)) {
				while (true) {
					localresponse.setValue(Constants.REQUESTCANCELLED);
					CWin.setCursor(Cursor.WAIT);
					if (Winla_rd.rideleteNodalas().boolValue()) {
						CWin.setCursor(null);
						{
							ClarionNumber case_1=Winla_sf.standardwarning(Clarion.newNumber(Warn.DELETEERROR));
							boolean case_1_break=false;
							boolean case_1_match=false;
							case_1_match=false;
							if (case_1.equals(Button.YES)) {
								continue;
								// UNREACHABLE! :case_1_break=true;
							}
							case_1_match=false;
							if (!case_1_break && case_1.equals(Button.NO)) {
								case_1_match=true;
							}
							if (case_1_match || case_1.equals(Button.CANCEL)) {
								break;
								// UNREACHABLE! :case_1_break=true;
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
			updatenodalas_procedurereturn(filesopened,windowopened,quickwindow,localresponse);
		}
		quickwindow.open();
		windowopened.setValue(Constants.TRUE);
		quickwindow.setProperty(Prop.MINWIDTH,quickwindow.getProperty(Prop.WIDTH));
		quickwindow.setProperty(Prop.MINHEIGHT,quickwindow.getProperty(Prop.HEIGHT));
		winresize.initialize(Clarion.newNumber(Appstrat.RESIZE));
		Winla_sf.inirestorewindow(Clarion.newString("UpdateNodalas"),Clarion.newString("winlats.INI"));
		winresize.resize();
		Clarion.getControl(quickwindow._nodU_nr).setProperty(Prop.ALRT,255,734);
		Clarion.getControl(quickwindow._nodKods).setProperty(Prop.ALRT,255,734);
		Clarion.getControl(quickwindow._nodNos_p).setProperty(Prop.ALRT,255,734);
		Clarion.getControl(quickwindow._nodSvars).setProperty(Prop.ALRT,255,734);
	}
	public static void browsenodalas()
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
		ClarionString nos_p=Clarion.newString(97);
		ClarionView brw1ViewBrowse=new Brw1ViewBrowse();
		QueueBrowse_1 queueBrowse_1=new QueueBrowse_1(nos_p);
		ClarionNumber brw1Currentscroll=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber brw1Scrollrecordcount=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber brw1Skipfirst=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionArray<ClarionString> brw1Sort2Keydistribution=Clarion.newString(2).dim(100);
		ClarionString brw1Sort2Lowvalue=Clarion.newString(2);
		ClarionString brw1Sort2Highvalue=Clarion.newString(2);
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
			System.out.println("browse nodalas");
			browsenodalas_prepareprocedure(queueBrowse_1,filesopened,quickwindow,windowopened,winresize,brw1Addqueue,brw1Recordcount,localrequest);
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_1=CWin.event();
					boolean case_1_break=false;
					if (case_1==Event.CLOSEDOWN) {
						winresize.destroy();
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.OPENWINDOW) {
						browsenodalas_brw1Assignbuttons(browsebuttons,quickwindow,queueBrowse_1,toolbarmode);
						if (!windowinitialized.boolValue()) {
							browsenodalas_initializewindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
							windowinitialized.setValue(Constants.TRUE);
						}
						CWin.select(quickwindow._browse_1);
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.GAINFOCUS) {
						forcerefresh.setValue(Constants.TRUE);
						if (!windowinitialized.boolValue()) {
							browsenodalas_initializewindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
							windowinitialized.setValue(Constants.TRUE);
						}
						else {
							browsenodalas_refreshwindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.SIZED) {
						winresize.resize();
						forcerefresh.setValue(Constants.TRUE);
						browsenodalas_refreshwindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
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
							browsenodalas_selectdispatch(browsebuttons,queueBrowse_1);
						}
						if (toolbarmode.equals(Constants.BROWSEMODE)) {
							browsenodalas_listboxdispatch(browsebuttons,queueBrowse_1,toolbarmode);
						}
						if (toolbarmode.equals(Constants.BROWSEMODE)) {
							browsenodalas_updatedispatch(browsebuttons,queueBrowse_1);
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
								browsenodalas_brw1Newselection(brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,quickwindow,brw1Currentchoice,nos_p,brw1Sortorder,brw1Currentscroll,brw1Sort2Keydistribution,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.SCROLLUP) {
								browsenodalas_brw1Processscroll(brw1Recordcount,brw1Currentevent,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Sortorder,brw1Currentscroll,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,nos_p);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.SCROLLDOWN) {
								browsenodalas_brw1Processscroll(brw1Recordcount,brw1Currentevent,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Sortorder,brw1Currentscroll,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,nos_p);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.PAGEUP) {
								browsenodalas_brw1Processscroll(brw1Recordcount,brw1Currentevent,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Sortorder,brw1Currentscroll,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,nos_p);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.PAGEDOWN) {
								browsenodalas_brw1Processscroll(brw1Recordcount,brw1Currentevent,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Sortorder,brw1Currentscroll,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,nos_p);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.SCROLLTOP) {
								browsenodalas_brw1Processscroll(brw1Recordcount,brw1Currentevent,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Sortorder,brw1Currentscroll,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,nos_p);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.SCROLLBOTTOM) {
								browsenodalas_brw1Processscroll(brw1Recordcount,brw1Currentevent,queueBrowse_1,quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Sortorder,brw1Currentscroll,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,nos_p);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.ALERTKEY) {
								browsenodalas_brw1Alertkey(brw1Recordcount,localrequest,quickwindow,queueBrowse_1,nos_p,brw1Sortorder,brw1Currentevent,brw1Currentchoice,brw1Itemstofill,brw1Filldirection,brw1Locatemode,brw1Newselectposted,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,brw1Highlightedposition,brw1Refreshmode);
								case_3_break=true;
							}
							if (!case_3_break && case_3==Event.SCROLLDRAG) {
								browsenodalas_brw1Scrolldrag(quickwindow,queueBrowse_1,brw1Sortorder,brw1Sort2Keydistribution,brw1Locatemode,brw1ViewBrowse,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
								case_3_break=true;
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._select_2) {
						{
							int case_4=CWin.event();
							if (case_4==Event.ACCEPTED) {
								browsenodalas_syncwindow(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
								localresponse.setValue(Constants.REQUESTCOMPLETED);
								CWin.post(Event.CLOSEWINDOW);
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._currenttab) {
						{
							int case_5=CWin.event();
							boolean case_5_break=false;
							if (case_5==Event.ACCEPTED) {
								browsenodalas_refreshwindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
								case_5_break=true;
							}
							if (!case_5_break && case_5==Event.NEWSELECTION) {
								browsenodalas_refreshwindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
								case_5_break=true;
							}
							if (!case_5_break && case_5==Event.TABCHANGING) {
								browsenodalas_refreshwindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
								case_5_break=true;
							}
							if (!case_5_break && case_5==Event.SELECTED) {
								browsenodalas_refreshwindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
								case_5_break=true;
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._insert_3) {
						{
							int case_6=CWin.event();
							if (case_6==Event.ACCEPTED) {
								browsenodalas_syncwindow(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
								browsenodalas_brw1Buttoninsert(localrequest,brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,originalrequest,localresponse,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Currentevent,brw1Popuptext);
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._change_3) {
						{
							int case_7=CWin.event();
							if (case_7==Event.ACCEPTED) {
								browsenodalas_syncwindow(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
								browsenodalas_brw1Buttonchange(localrequest,brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,originalrequest,localresponse,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Currentevent,brw1Popuptext);
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._delete_3) {
						{
							int case_8=CWin.event();
							if (case_8==Event.ACCEPTED) {
								browsenodalas_syncwindow(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
								browsenodalas_brw1Buttondelete(localrequest,queueBrowse_1,brw1Recordcount,brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,brw1Currentchoice,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,nos_p,brw1Sortorder,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,brw1Newselectposted,originalrequest,localresponse,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Locatemode,brw1Currentevent,brw1Popuptext);
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==quickwindow._close) {
						{
							int case_9=CWin.event();
							if (case_9==Event.ACCEPTED) {
								browsenodalas_syncwindow(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
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
				browsenodalas_procedurereturn(filesopened,queueBrowse_1,windowopened,quickwindow,localresponse);
			} catch (ClarionRoutineResult _crr) {
				return;
			}
		} finally {
			quickwindow.close();
		}
	}
	public static void browsenodalas_brw1Scrollend(QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,Quickwindow_1 quickwindow,ClarionNumber brw1Currentevent,ClarionNumber brw1Filldirection,ClarionNumber brw1Currentchoice,ClarionView brw1ViewBrowse,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue,ClarionString nos_p,ClarionNumber brw1Sortorder)
	{
		queueBrowse_1.free();
		brw1Recordcount.setValue(0);
		browsenodalas_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
		brw1Itemstofill.setValue(Clarion.getControl(quickwindow._browse_1).getProperty(Prop.ITEMS));
		if (brw1Currentevent.equals(Event.SCROLLTOP)) {
			brw1Filldirection.setValue(Constants.FILLFORWARD);
		}
		else {
			brw1Filldirection.setValue(Constants.FILLBACKWARD);
		}
		browsenodalas_brw1Fillrecord(brw1Recordcount,brw1Filldirection,queueBrowse_1,brw1ViewBrowse,brw1Skipfirst,brw1Itemstofill,brw1Addqueue,quickwindow,nos_p);
		if (brw1Currentevent.equals(Event.SCROLLTOP)) {
			brw1Currentchoice.setValue(1);
		}
		else {
			brw1Currentchoice.setValue(brw1Recordcount);
		}
	}
	public static void browsenodalas_brw1Locaterecord(ClarionNumber brw1Locatemode,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse,ClarionNumber brw1Sortorder,ClarionString brw1Highlightedposition,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst,Quickwindow_1 quickwindow,ClarionString nos_p,ClarionNumber brw1Refreshmode,ClarionNumber brw1Newselectposted,ClarionNumber brw1Currentchoice)
	{
		if (brw1Locatemode.equals(Constants.LOCATEONPOSITION)) {
			brw1Locatemode.setValue(Constants.LOCATEONEDIT);
		}
		brw1ViewBrowse.close();
		{
			ClarionNumber case_1=brw1Sortorder;
			boolean case_1_break=false;
			if (case_1.equals(1)) {
				if (brw1Locatemode.equals(Constants.LOCATEONEDIT)) {
					brw1Highlightedposition.setValue(Main.nodalas.kods_key.getPosition());
					Main.nodalas.kods_key.reget(brw1Highlightedposition);
				}
				else {
					Main.nodalas.kods_key.set(Main.nodalas.kods_key);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(2)) {
				if (brw1Locatemode.equals(Constants.LOCATEONEDIT)) {
					brw1Highlightedposition.setValue(Main.nodalas.nr_key.getPosition());
					Main.nodalas.nr_key.reget(brw1Highlightedposition);
				}
				else {
					Main.nodalas.nr_key.set(Main.nodalas.nr_key);
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
		browsenodalas_brw1Fillrecord(brw1Recordcount,brw1Filldirection,queueBrowse_1,brw1ViewBrowse,brw1Skipfirst,brw1Itemstofill,brw1Addqueue,quickwindow,nos_p);
		brw1Addqueue.setValue(Constants.TRUE);
		if (brw1Itemstofill.boolValue()) {
			brw1Refreshmode.setValue(Constants.REFRESHONBOTTOM);
			browsenodalas_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,nos_p,brw1Sortorder);
		}
		else {
			brw1Refreshmode.setValue(Constants.REFRESHONPOSITION);
			browsenodalas_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,nos_p,brw1Sortorder);
		}
		browsenodalas_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
		brw1Locatemode.setValue(0);
		return;
	}
	public static void browsenodalas_brw1Buttondelete(ClarionNumber localrequest,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Recordcount,ClarionNumber brw1Refreshmode,ClarionString brw1Highlightedposition,ClarionView brw1ViewBrowse,ClarionNumber brw1Currentchoice,ClarionNumber brw1Itemstofill,Quickwindow_1 quickwindow,ClarionNumber brw1Filldirection,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue,ClarionString nos_p,ClarionNumber brw1Sortorder,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort2Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionNumber brw1Newselectposted,ClarionNumber originalrequest,ClarionNumber localresponse,ClarionNumber brw1Currentscroll,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Locatemode,ClarionNumber brw1Currentevent,ClarionString brw1Popuptext)
	{
		localrequest.setValue(Constants.DELETERECORD);
		browsenodalas_brw1Callupdate(brw1ViewBrowse,localrequest,localresponse,queueBrowse_1,brw1Currentevent,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Skipfirst,brw1Addqueue,quickwindow,nos_p,brw1Sortorder,brw1Locatemode,brw1Highlightedposition,brw1Refreshmode,brw1Newselectposted,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,brw1Popuptext);
		if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
			queueBrowse_1.delete();
			brw1Recordcount.decrement(1);
		}
		brw1Refreshmode.setValue(Constants.REFRESHONQUEUE);
		browsenodalas_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,nos_p,brw1Sortorder);
		browsenodalas_brw1Initializebrowse(brw1ViewBrowse,queueBrowse_1,brw1Sortorder,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution);
		browsenodalas_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
		CWin.select(quickwindow._browse_1);
		localrequest.setValue(originalrequest);
		localresponse.setValue(Constants.REQUESTCANCELLED);
		browsenodalas_refreshwindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
	}
	public static void browsenodalas_brw1Restoreresetvalues()
	{
	}
	public static void browsenodalas_brw1Scrollone(ClarionNumber brw1Currentevent,ClarionNumber brw1Currentchoice,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionView brw1ViewBrowse,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue,Quickwindow_1 quickwindow,ClarionString nos_p)
	{
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
		browsenodalas_brw1Fillrecord(brw1Recordcount,brw1Filldirection,queueBrowse_1,brw1ViewBrowse,brw1Skipfirst,brw1Itemstofill,brw1Addqueue,quickwindow,nos_p);
	}
	public static void browsenodalas_displaybrowsetoolbar(Browsebuttons browsebuttons,QueueBrowse_1 queueBrowse_1,ClarionNumber toolbarmode)
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
	public static void browsenodalas_brw1Assignbuttons(Browsebuttons browsebuttons,Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1,ClarionNumber toolbarmode)
	{
		browsebuttons.clear();
		browsebuttons.listbox.setValue(quickwindow._browse_1);
		browsebuttons.selectbutton.setValue(quickwindow._select_2);
		browsebuttons.insertbutton.setValue(quickwindow._insert_3);
		browsebuttons.changebutton.setValue(quickwindow._change_3);
		browsebuttons.deletebutton.setValue(quickwindow._delete_3);
		browsenodalas_displaybrowsetoolbar(browsebuttons,queueBrowse_1,toolbarmode);
	}
	public static void browsenodalas_brw1Initializebrowse(ClarionView brw1ViewBrowse,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Sortorder,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort2Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort2Keydistribution)
	{
		browsenodalas_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
		brw1ViewBrowse.previous();
		if (CError.errorCode()!=0) {
			if (CError.errorCode()==Constants.BADRECERR) {
				browsenodalas_brw1Restoreresetvalues();
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("NODALAS"));
				CWin.post(Event.CLOSEWINDOW);
			}
			return;
		}
		{
			ClarionNumber case_1=brw1Sortorder;
			if (case_1.equals(2)) {
				brw1Sort2Highvalue.setValue(Main.nodalas.u_nr);
			}
		}
		browsenodalas_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
		brw1ViewBrowse.next();
		if (CError.errorCode()!=0) {
			if (CError.errorCode()==Constants.BADRECERR) {
				browsenodalas_brw1Restoreresetvalues();
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("NODALAS"));
				CWin.post(Event.CLOSEWINDOW);
			}
			return;
		}
		{
			ClarionNumber case_2=brw1Sortorder;
			if (case_2.equals(2)) {
				brw1Sort2Lowvalue.setValue(Main.nodalas.u_nr);
				Winla_sf.setupstringstops(brw1Sort2Lowvalue.like(),brw1Sort2Highvalue.like(),Clarion.newNumber(CMemory.size(brw1Sort2Lowvalue)),Clarion.newNumber(Scrollsort.ALLOWALPHA));
				for (brw1Scrollrecordcount.setValue(1);brw1Scrollrecordcount.compareTo(100)<=0;brw1Scrollrecordcount.increment(1)) {
					brw1Sort2Keydistribution.get(brw1Scrollrecordcount.intValue()).setValue(Winla_sf.nextstringstop());
				}
			}
		}
	}
	public static void browsenodalas_brw1Scrollpage(ClarionNumber brw1Itemstofill,Quickwindow_1 quickwindow,ClarionNumber brw1Filldirection,ClarionNumber brw1Currentevent,ClarionNumber brw1Currentchoice,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Recordcount,ClarionView brw1ViewBrowse,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue,ClarionString nos_p)
	{
		brw1Itemstofill.setValue(Clarion.getControl(quickwindow._browse_1).getProperty(Prop.ITEMS));
		brw1Filldirection.setValue(brw1Currentevent.subtract(4));
		browsenodalas_brw1Fillrecord(brw1Recordcount,brw1Filldirection,queueBrowse_1,brw1ViewBrowse,brw1Skipfirst,brw1Itemstofill,brw1Addqueue,quickwindow,nos_p);
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
	public static void browsenodalas_selectdispatch(Browsebuttons browsebuttons,QueueBrowse_1 queueBrowse_1)
	{
		if (CWin.accepted()==Constants.TBARBRWSELECT) {
			CWin.post(Event.ACCEPTED,browsebuttons.selectbutton.intValue());
		}
	}
	public static void browsenodalas_brw1Postvcredit1(ClarionView brw1ViewBrowse,ClarionNumber brw1Sortorder,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Locatemode,ClarionString brw1Highlightedposition,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst,Quickwindow_1 quickwindow,ClarionString nos_p,ClarionNumber brw1Refreshmode,ClarionNumber brw1Newselectposted,ClarionNumber brw1Currentchoice,ClarionNumber brw1Currentscroll,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber localrequest,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort2Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort2Keydistribution)
	{
		browsenodalas_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
		brw1Locatemode.setValue(Constants.LOCATEONEDIT);
		browsenodalas_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
		browsenodalas_refreshwindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
	}
	public static void browsenodalas_brw1Postvcredit2(Quickwindow_1 quickwindow,ClarionNumber brw1Currentchoice,ClarionNumber brw1Newselectposted,ClarionString brw1Popuptext,ClarionNumber brw1Recordcount,ClarionNumber localrequest,QueueBrowse_1 queueBrowse_1,ClarionString nos_p,ClarionNumber brw1Sortorder,ClarionNumber brw1Currentscroll,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Locatemode,ClarionNumber brw1Refreshmode,ClarionView brw1ViewBrowse,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort2Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionString brw1Highlightedposition,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst)
	{
		Clarion.getControl(quickwindow._browse_1).setClonedProperty(Prop.SELSTART,brw1Currentchoice);
		browsenodalas_brw1Newselection(brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,quickwindow,brw1Currentchoice,nos_p,brw1Sortorder,brw1Currentscroll,brw1Sort2Keydistribution,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
		brw1ViewBrowse.reget(queueBrowse_1.brw1Position);
		brw1ViewBrowse.close();
	}
	public static void browsenodalas_brw1Buttoninsert(ClarionNumber localrequest,ClarionNumber brw1Locatemode,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse,ClarionNumber brw1Sortorder,ClarionString brw1Highlightedposition,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst,Quickwindow_1 quickwindow,ClarionString nos_p,ClarionNumber brw1Refreshmode,ClarionNumber brw1Newselectposted,ClarionNumber brw1Currentchoice,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort2Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionNumber originalrequest,ClarionNumber localresponse,ClarionNumber brw1Currentscroll,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Currentevent,ClarionString brw1Popuptext)
	{
		Main.nodalas.get(Clarion.newString(String.valueOf(0)),null);
		Main.nodalas.clear(0);
		localrequest.setValue(Constants.INSERTRECORD);
		browsenodalas_brw1Callupdate(brw1ViewBrowse,localrequest,localresponse,queueBrowse_1,brw1Currentevent,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Skipfirst,brw1Addqueue,quickwindow,nos_p,brw1Sortorder,brw1Locatemode,brw1Highlightedposition,brw1Refreshmode,brw1Newselectposted,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,brw1Popuptext);
		if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
			brw1Locatemode.setValue(Constants.LOCATEONEDIT);
			browsenodalas_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
		}
		else {
			brw1Refreshmode.setValue(Constants.REFRESHONQUEUE);
			browsenodalas_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,nos_p,brw1Sortorder);
		}
		browsenodalas_brw1Initializebrowse(brw1ViewBrowse,queueBrowse_1,brw1Sortorder,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution);
		browsenodalas_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
		CWin.select(quickwindow._browse_1);
		localrequest.setValue(originalrequest);
		localresponse.setValue(Constants.REQUESTCANCELLED);
		browsenodalas_refreshwindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
	}
	public static void browsenodalas_brw1Fillqueue(ClarionString nos_p,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse)
	{
		nos_p.setValue(Main.nodalas.kods.clip().concat(" ",Main.nodalas.nos_p));
		queueBrowse_1.brw1NodU_nr.setValue(Main.nodalas.u_nr);
		if (!Main.nodalas.u_nr.stringAt(2).boolValue()) {
			queueBrowse_1.brw1NodU_nrNormalfg.setValue(255);
			queueBrowse_1.brw1NodU_nrNormalbg.setValue(-1);
			queueBrowse_1.brw1NodU_nrSelectedfg.setValue(255);
			queueBrowse_1.brw1NodU_nrSelectedbg.setValue(-1);
		}
		else {
			queueBrowse_1.brw1NodU_nrNormalfg.setValue(-1);
			queueBrowse_1.brw1NodU_nrNormalbg.setValue(-1);
			queueBrowse_1.brw1NodU_nrSelectedfg.setValue(-1);
			queueBrowse_1.brw1NodU_nrSelectedbg.setValue(-1);
		}
		queueBrowse_1.brw1Nos_p.setValue(nos_p);
		if (!Main.nodalas.u_nr.stringAt(2).boolValue()) {
			queueBrowse_1.brw1Nos_pNormalfg.setValue(255);
			queueBrowse_1.brw1Nos_pNormalbg.setValue(-1);
			queueBrowse_1.brw1Nos_pSelectedfg.setValue(255);
			queueBrowse_1.brw1Nos_pSelectedbg.setValue(-1);
		}
		else {
			queueBrowse_1.brw1Nos_pNormalfg.setValue(-1);
			queueBrowse_1.brw1Nos_pNormalbg.setValue(-1);
			queueBrowse_1.brw1Nos_pSelectedfg.setValue(-1);
			queueBrowse_1.brw1Nos_pSelectedbg.setValue(-1);
		}
		queueBrowse_1.brw1NodSvars.setValue(Main.nodalas.svars);
		queueBrowse_1.brw1NodKods.setValue(Main.nodalas.kods);
		queueBrowse_1.brw1Position.setValue(brw1ViewBrowse.getPosition());
	}
	public static void browsenodalas_prepareprocedure(QueueBrowse_1 queueBrowse_1,ClarionNumber filesopened,Quickwindow_1 quickwindow,ClarionNumber windowopened,Windowresizetype winresize,ClarionNumber brw1Addqueue,ClarionNumber brw1Recordcount,ClarionNumber localrequest)
	{
		if (Main.nodalasUsed.equals(0)) {
			Winla_sf.checkopen(Main.nodalas,Clarion.newNumber(1));
		}
		Main.nodalasUsed.increment(1);
		CExpression.bind(Main.nodalas);
		filesopened.setValue(Constants.TRUE);
		quickwindow.open();
		windowopened.setValue(Constants.TRUE);
		quickwindow.setProperty(Prop.MINWIDTH,quickwindow.getProperty(Prop.WIDTH));
		quickwindow.setProperty(Prop.MINHEIGHT,quickwindow.getProperty(Prop.HEIGHT));
		winresize.initialize(Clarion.newNumber(Appstrat.SPREAD));
		Winla_sf.inirestorewindow(Clarion.newString("BrowseNodalas"),Clarion.newString("winlats.INI"));
		winresize.resize();
		brw1Addqueue.setValue(Constants.TRUE);
		brw1Recordcount.setValue(0);
		if (!localrequest.equals(Constants.SELECTRECORD)) {
			Clarion.getControl(quickwindow._select_2).setProperty(Prop.HIDE,Constants.TRUE);
			CWin.disable(quickwindow._select_2);
		}
		else {
		}
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,252,Constants.MOUSELEFT2);
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,252,Constants.MOUSELEFT2);
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,255,Constants.INSERTKEY);
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,254,Constants.DELETEKEY);
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,253,Constants.CTRLENTER);
		Clarion.getControl(quickwindow._browse_1).setProperty(Prop.ALRT,252,Constants.MOUSELEFT2);
	}
	public static void browsenodalas_procedurereturn(ClarionNumber filesopened,QueueBrowse_1 queueBrowse_1,ClarionNumber windowopened,Quickwindow_1 quickwindow,ClarionNumber localresponse) throws ClarionRoutineResult
	{
		if (filesopened.boolValue()) {
			Main.nodalasUsed.decrement(1);
			if (Main.nodalasUsed.equals(0)) {
				Main.nodalas.close();
			}
		}
		if (windowopened.boolValue()) {
			Winla_sf.inisavewindow(Clarion.newString("BrowseNodalas"),Clarion.newString("winlats.INI"));
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
	public static void browsenodalas_brw1Alertkey(ClarionNumber brw1Recordcount,ClarionNumber localrequest,Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1,ClarionString nos_p,ClarionNumber brw1Sortorder,ClarionNumber brw1Currentevent,ClarionNumber brw1Currentchoice,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Locatemode,ClarionNumber brw1Newselectposted,ClarionView brw1ViewBrowse,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue,ClarionString brw1Highlightedposition,ClarionNumber brw1Refreshmode)
	{
		if (brw1Recordcount.boolValue()) {
			{
				int case_1=CWin.keyCode();
				boolean case_1_break=false;
				if (case_1==Constants.MOUSELEFT2) {
					if (localrequest.equals(Constants.SELECTRECORD)) {
						CWin.post(Event.ACCEPTED,quickwindow._select_2);
						return;
					}
					CWin.post(Event.ACCEPTED,quickwindow._change_3);
					browsenodalas_brw1Fillbuffer(queueBrowse_1,nos_p);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Constants.INSERTKEY) {
					CWin.post(Event.ACCEPTED,quickwindow._insert_3);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Constants.DELETEKEY) {
					CWin.post(Event.ACCEPTED,quickwindow._delete_3);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Constants.CTRLENTER) {
					CWin.post(Event.ACCEPTED,quickwindow._change_3);
					case_1_break=true;
				}
				if (!case_1_break) {
					{
						ClarionNumber case_2=brw1Sortorder;
						boolean case_2_break=false;
						if (case_2.equals(1)) {
							if (ClarionString.chr(CWin.keyChar()).boolValue()) {
								if (Main.nodalas.kods.sub(1,1).upper().equals(ClarionString.chr(CWin.keyChar()).upper())) {
									brw1Currentevent.setValue(Event.SCROLLDOWN);
									browsenodalas_brw1Scrollone(brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,quickwindow,nos_p);
									queueBrowse_1.get(brw1Currentchoice);
									browsenodalas_brw1Fillbuffer(queueBrowse_1,nos_p);
								}
								if (Main.nodalas.kods.sub(1,1).upper().equals(ClarionString.chr(CWin.keyChar()).upper())) {
									Clarion.getControl(quickwindow._browse_1).setClonedProperty(Prop.SELSTART,brw1Currentchoice);
								}
								else {
									Main.nodalas.kods.setValue(ClarionString.chr(CWin.keyChar()));
									brw1Locatemode.setValue(Constants.LOCATEONVALUE);
									browsenodalas_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
								}
							}
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals(2)) {
							if (ClarionString.chr(CWin.keyChar()).boolValue()) {
								if (Main.nodalas.u_nr.sub(1,1).upper().equals(ClarionString.chr(CWin.keyChar()).upper())) {
									brw1Currentevent.setValue(Event.SCROLLDOWN);
									browsenodalas_brw1Scrollone(brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,quickwindow,nos_p);
									queueBrowse_1.get(brw1Currentchoice);
									browsenodalas_brw1Fillbuffer(queueBrowse_1,nos_p);
								}
								if (Main.nodalas.u_nr.sub(1,1).upper().equals(ClarionString.chr(CWin.keyChar()).upper())) {
									Clarion.getControl(quickwindow._browse_1).setClonedProperty(Prop.SELSTART,brw1Currentchoice);
								}
								else {
									Main.nodalas.u_nr.setValue(ClarionString.chr(CWin.keyChar()));
									brw1Locatemode.setValue(Constants.LOCATEONVALUE);
									browsenodalas_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
								}
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
					CWin.post(Event.ACCEPTED,quickwindow._insert_3);
				}
			}
		}
		browsenodalas_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
	}
	public static void browsenodalas_syncwindow(ClarionNumber brw1Recordcount,ClarionNumber brw1Currentchoice,Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse)
	{
		browsenodalas_brw1Getrecord(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
	}
	public static void browsenodalas_brw1Selectsort(ClarionNumber brw1Lastsortorder,ClarionNumber brw1Sortorder,ClarionNumber brw1Changed,Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1,ClarionNumber forcerefresh,ClarionNumber localrequest,ClarionNumber brw1Locatemode,ClarionNumber brw1Refreshmode,ClarionNumber brw1Recordcount,ClarionNumber brw1Currentchoice,ClarionView brw1ViewBrowse,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort2Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionString nos_p,ClarionNumber brw1Newselectposted,ClarionString brw1Highlightedposition,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst)
	{
		brw1Lastsortorder.setValue(brw1Sortorder);
		brw1Changed.setValue(Constants.FALSE);
		if (CWin.choice(quickwindow._currenttab)==2) {
			brw1Sortorder.setValue(1);
		}
		else {
			brw1Sortorder.setValue(2);
		}
		if (!brw1Sortorder.equals(brw1Lastsortorder) || brw1Changed.boolValue() || forcerefresh.boolValue()) {
			browsenodalas_brw1Getrecord(brw1Recordcount,brw1Currentchoice,quickwindow,queueBrowse_1,brw1ViewBrowse);
			browsenodalas_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
			if (brw1Lastsortorder.equals(0)) {
				if (localrequest.equals(Constants.SELECTRECORD)) {
					brw1Locatemode.setValue(Constants.LOCATEONVALUE);
					browsenodalas_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
				}
				else {
					queueBrowse_1.free();
					brw1Refreshmode.setValue(Constants.REFRESHONTOP);
					browsenodalas_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,nos_p,brw1Sortorder);
					browsenodalas_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
				}
			}
			else {
				if (brw1Changed.boolValue()) {
					queueBrowse_1.free();
					brw1Refreshmode.setValue(Constants.REFRESHONTOP);
					browsenodalas_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,nos_p,brw1Sortorder);
					browsenodalas_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
				}
				else {
					brw1Locatemode.setValue(Constants.LOCATEONVALUE);
					browsenodalas_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
				}
			}
			if (brw1Recordcount.boolValue()) {
				queueBrowse_1.get(brw1Currentchoice);
				browsenodalas_brw1Fillbuffer(queueBrowse_1,nos_p);
			}
			browsenodalas_brw1Initializebrowse(brw1ViewBrowse,queueBrowse_1,brw1Sortorder,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution);
		}
		else {
			if (brw1Recordcount.boolValue()) {
				queueBrowse_1.get(brw1Currentchoice);
				browsenodalas_brw1Fillbuffer(queueBrowse_1,nos_p);
			}
		}
	}
	public static void browsenodalas_brw1Reset(ClarionView brw1ViewBrowse,ClarionNumber brw1Sortorder,QueueBrowse_1 queueBrowse_1)
	{
		brw1ViewBrowse.close();
		{
			ClarionNumber case_1=brw1Sortorder;
			boolean case_1_break=false;
			if (case_1.equals(1)) {
				Main.nodalas.kods_key.setStart();
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(2)) {
				Main.nodalas.nr_key.setStart();
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
	public static void browsenodalas_brw1Getrecord(ClarionNumber brw1Recordcount,ClarionNumber brw1Currentchoice,Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse)
	{
		if (brw1Recordcount.boolValue()) {
			brw1Currentchoice.setValue(CWin.choice(quickwindow._browse_1));
			queueBrowse_1.get(brw1Currentchoice);
			brw1ViewBrowse.watch();
			brw1ViewBrowse.reget(queueBrowse_1.brw1Position);
		}
	}
	public static void browsenodalas_brw1Processscroll(ClarionNumber brw1Recordcount,ClarionNumber brw1Currentevent,QueueBrowse_1 queueBrowse_1,Quickwindow_1 quickwindow,ClarionNumber brw1Currentchoice,ClarionNumber brw1Newselectposted,ClarionNumber brw1Sortorder,ClarionNumber brw1Currentscroll,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionView brw1ViewBrowse,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue,ClarionString nos_p)
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
					browsenodalas_brw1Scrollone(brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,quickwindow,nos_p);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Event.PAGEUP)) {
					case_1_match=true;
				}
				if (case_1_match || case_1.equals(Event.PAGEDOWN)) {
					browsenodalas_brw1Scrollpage(brw1Itemstofill,quickwindow,brw1Filldirection,brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,nos_p);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Event.SCROLLTOP)) {
					case_1_match=true;
				}
				if (case_1_match || case_1.equals(Event.SCROLLBOTTOM)) {
					browsenodalas_brw1Scrollend(queueBrowse_1,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Currentevent,brw1Filldirection,brw1Currentchoice,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,nos_p,brw1Sortorder);
					case_1_break=true;
				}
			}
			Clarion.getControl(quickwindow._browse_1).setClonedProperty(Prop.SELSTART,brw1Currentchoice);
			browsenodalas_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
			{
				ClarionNumber case_2=brw1Sortorder;
				if (case_2.equals(1)) {
					brw1Currentscroll.setValue(50);
					if (brw1Recordcount.equals(Clarion.getControl(quickwindow._browse_1).getProperty(Prop.ITEMS))) {
						if (brw1Itemstofill.boolValue()) {
							if (brw1Currentevent.equals(Event.SCROLLUP)) {
								brw1Currentscroll.setValue(0);
							}
							else {
								brw1Currentscroll.setValue(100);
							}
						}
					}
					else {
						brw1Currentscroll.setValue(0);
					}
				}
			}
		}
	}
	public static void browsenodalas_brw1Scrolldrag(Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Sortorder,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionNumber brw1Locatemode,ClarionView brw1ViewBrowse,ClarionString brw1Highlightedposition,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst,ClarionString nos_p,ClarionNumber brw1Refreshmode,ClarionNumber brw1Newselectposted,ClarionNumber brw1Currentchoice)
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
				if (case_1.equals(2)) {
					Main.nodalas.u_nr.setValue(brw1Sort2Keydistribution.get(Clarion.getControl(quickwindow._browse_1).getProperty(Prop.VSCROLLPOS).intValue()));
					brw1Locatemode.setValue(Constants.LOCATEONVALUE);
					browsenodalas_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
				}
			}
		}
	}
	public static void browsenodalas_brw1Callupdate(ClarionView brw1ViewBrowse,ClarionNumber localrequest,ClarionNumber localresponse,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Currentevent,ClarionNumber brw1Currentchoice,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue,Quickwindow_1 quickwindow,ClarionString nos_p,ClarionNumber brw1Sortorder,ClarionNumber brw1Locatemode,ClarionString brw1Highlightedposition,ClarionNumber brw1Refreshmode,ClarionNumber brw1Newselectposted,ClarionNumber brw1Currentscroll,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort2Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionString brw1Popuptext)
	{
		brw1ViewBrowse.close();
		while (true) {
			Main.globalrequest.setValue(localrequest);
			Main.vcrrequest.setValue(Constants.VCRNONE);
			Winla001.updatenodalas();
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
						Main.nodalas.get(Clarion.newString(String.valueOf(0)),null);
						Main.nodalas.clear(0);
					}
					else {
						browsenodalas_brw1Postvcredit1(brw1ViewBrowse,brw1Sortorder,queueBrowse_1,brw1Locatemode,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Changed,localrequest,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution);
						brw1Currentevent.setValue(Event.SCROLLDOWN);
						browsenodalas_brw1Scrollone(brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,quickwindow,nos_p);
						browsenodalas_brw1Postvcredit2(quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,nos_p,brw1Sortorder,brw1Currentscroll,brw1Sort2Keydistribution,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Constants.VCRBACKWARD)) {
					browsenodalas_brw1Postvcredit1(brw1ViewBrowse,brw1Sortorder,queueBrowse_1,brw1Locatemode,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Changed,localrequest,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution);
					brw1Currentevent.setValue(Event.SCROLLUP);
					browsenodalas_brw1Scrollone(brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,quickwindow,nos_p);
					browsenodalas_brw1Postvcredit2(quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,nos_p,brw1Sortorder,brw1Currentscroll,brw1Sort2Keydistribution,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Constants.VCRPAGEFORWARD)) {
					browsenodalas_brw1Postvcredit1(brw1ViewBrowse,brw1Sortorder,queueBrowse_1,brw1Locatemode,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Changed,localrequest,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution);
					brw1Currentevent.setValue(Event.PAGEDOWN);
					browsenodalas_brw1Scrollpage(brw1Itemstofill,quickwindow,brw1Filldirection,brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,nos_p);
					browsenodalas_brw1Postvcredit2(quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,nos_p,brw1Sortorder,brw1Currentscroll,brw1Sort2Keydistribution,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Constants.VCRPAGEBACKWARD)) {
					browsenodalas_brw1Postvcredit1(brw1ViewBrowse,brw1Sortorder,queueBrowse_1,brw1Locatemode,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Changed,localrequest,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution);
					brw1Currentevent.setValue(Event.PAGEUP);
					browsenodalas_brw1Scrollpage(brw1Itemstofill,quickwindow,brw1Filldirection,brw1Currentevent,brw1Currentchoice,queueBrowse_1,brw1Recordcount,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,nos_p);
					browsenodalas_brw1Postvcredit2(quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,nos_p,brw1Sortorder,brw1Currentscroll,brw1Sort2Keydistribution,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Constants.VCRFIRST)) {
					browsenodalas_brw1Postvcredit1(brw1ViewBrowse,brw1Sortorder,queueBrowse_1,brw1Locatemode,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Changed,localrequest,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution);
					brw1Currentevent.setValue(Event.SCROLLTOP);
					browsenodalas_brw1Scrollend(queueBrowse_1,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Currentevent,brw1Filldirection,brw1Currentchoice,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,nos_p,brw1Sortorder);
					browsenodalas_brw1Postvcredit2(quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,nos_p,brw1Sortorder,brw1Currentscroll,brw1Sort2Keydistribution,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Constants.VCRLAST)) {
					browsenodalas_brw1Postvcredit1(brw1ViewBrowse,brw1Sortorder,queueBrowse_1,brw1Locatemode,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Changed,localrequest,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution);
					brw1Currentevent.setValue(Event.SCROLLBOTTOM);
					browsenodalas_brw1Scrollend(queueBrowse_1,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Currentevent,brw1Filldirection,brw1Currentchoice,brw1ViewBrowse,brw1Skipfirst,brw1Addqueue,nos_p,brw1Sortorder);
					browsenodalas_brw1Postvcredit2(quickwindow,brw1Currentchoice,brw1Newselectposted,brw1Popuptext,brw1Recordcount,localrequest,queueBrowse_1,nos_p,brw1Sortorder,brw1Currentscroll,brw1Sort2Keydistribution,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Locatemode,brw1Refreshmode,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
					case_1_break=true;
				}
			}
		}
		browsenodalas_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
	}
	public static void browsenodalas_listboxdispatch(Browsebuttons browsebuttons,QueueBrowse_1 queueBrowse_1,ClarionNumber toolbarmode)
	{
		browsenodalas_displaybrowsetoolbar(browsebuttons,queueBrowse_1,toolbarmode);
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
	public static void browsenodalas_brw1Newselection(ClarionNumber brw1Newselectposted,ClarionString brw1Popuptext,ClarionNumber brw1Recordcount,ClarionNumber localrequest,QueueBrowse_1 queueBrowse_1,Quickwindow_1 quickwindow,ClarionNumber brw1Currentchoice,ClarionString nos_p,ClarionNumber brw1Sortorder,ClarionNumber brw1Currentscroll,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Locatemode,ClarionNumber brw1Refreshmode,ClarionView brw1ViewBrowse,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort2Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionString brw1Highlightedposition,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst)
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
					CWin.post(Event.ACCEPTED,quickwindow._insert_3);
				}
				if (execute_1==2) {
					CWin.post(Event.ACCEPTED,quickwindow._change_3);
				}
				if (execute_1==3) {
					CWin.post(Event.ACCEPTED,quickwindow._delete_3);
				}
				if (execute_1==4) {
					CWin.post(Event.ACCEPTED,quickwindow._select_2);
				}
			}
		}
		else if (brw1Recordcount.boolValue()) {
			brw1Currentchoice.setValue(CWin.choice(quickwindow._browse_1));
			queueBrowse_1.get(brw1Currentchoice);
			browsenodalas_brw1Fillbuffer(queueBrowse_1,nos_p);
			if (brw1Recordcount.equals(Clarion.getControl(quickwindow._browse_1).getProperty(Prop.ITEMS))) {
				if (Clarion.getControl(quickwindow._browse_1).getProperty(Prop.VSCROLL).equals(Constants.FALSE)) {
					Clarion.getControl(quickwindow._browse_1).setProperty(Prop.VSCROLL,Constants.TRUE);
				}
				{
					ClarionNumber case_1=brw1Sortorder;
					boolean case_1_break=false;
					if (case_1.equals(1)) {
						case_1_break=true;
					}
					if (!case_1_break && case_1.equals(2)) {
						for (brw1Currentscroll.setValue(1);brw1Currentscroll.compareTo(100)<=0;brw1Currentscroll.increment(1)) {
							if (brw1Sort2Keydistribution.get(brw1Currentscroll.intValue()).compareTo(Main.nodalas.u_nr.upper())>=0) {
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
			browsenodalas_refreshwindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
		}
	}
	public static void browsenodalas_initializewindow(Quickwindow_1 quickwindow,ClarionNumber brw1Currentscroll,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Sortorder,ClarionNumber brw1Changed,QueueBrowse_1 queueBrowse_1,ClarionNumber localrequest,ClarionNumber brw1Locatemode,ClarionNumber brw1Refreshmode,ClarionNumber brw1Recordcount,ClarionNumber brw1Currentchoice,ClarionView brw1ViewBrowse,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort2Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionString nos_p,ClarionNumber brw1Newselectposted,ClarionString brw1Highlightedposition,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst)
	{
		browsenodalas_refreshwindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
	}
	public static void browsenodalas_brw1Fillbuffer(QueueBrowse_1 queueBrowse_1,ClarionString nos_p)
	{
		Main.nodalas.u_nr.setValue(queueBrowse_1.brw1NodU_nr);
		nos_p.setValue(queueBrowse_1.brw1Nos_p);
		Main.nodalas.svars.setValue(queueBrowse_1.brw1NodSvars);
		Main.nodalas.kods.setValue(queueBrowse_1.brw1NodKods);
	}
	public static void browsenodalas_refreshwindow(Quickwindow_1 quickwindow,ClarionNumber brw1Currentscroll,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Sortorder,ClarionNumber brw1Changed,QueueBrowse_1 queueBrowse_1,ClarionNumber localrequest,ClarionNumber brw1Locatemode,ClarionNumber brw1Refreshmode,ClarionNumber brw1Recordcount,ClarionNumber brw1Currentchoice,ClarionView brw1ViewBrowse,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort2Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionString nos_p,ClarionNumber brw1Newselectposted,ClarionString brw1Highlightedposition,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst)
	{
		if (quickwindow.getProperty(Prop.ACCEPTALL).boolValue()) {
			return;
		}
		browsenodalas_brw1Selectsort(brw1Lastsortorder,brw1Sortorder,brw1Changed,quickwindow,queueBrowse_1,forcerefresh,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
		Clarion.getControl(quickwindow._browse_1).setClonedProperty(Prop.VSCROLLPOS,brw1Currentscroll);
		CWin.display();
		forcerefresh.setValue(Constants.FALSE);
	}
	public static void browsenodalas_brw1Refreshpage(ClarionNumber brw1Refreshmode,ClarionString brw1Highlightedposition,ClarionView brw1ViewBrowse,QueueBrowse_1 queueBrowse_1,ClarionNumber brw1Currentchoice,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,Quickwindow_1 quickwindow,ClarionNumber brw1Filldirection,ClarionNumber brw1Skipfirst,ClarionNumber brw1Addqueue,ClarionString nos_p,ClarionNumber brw1Sortorder)
	{
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
			browsenodalas_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
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
		browsenodalas_brw1Fillrecord(brw1Recordcount,brw1Filldirection,queueBrowse_1,brw1ViewBrowse,brw1Skipfirst,brw1Itemstofill,brw1Addqueue,quickwindow,nos_p);
		if (brw1Highlightedposition.boolValue()) {
			if (brw1Itemstofill.boolValue()) {
				if (!brw1Recordcount.boolValue()) {
					browsenodalas_brw1Reset(brw1ViewBrowse,brw1Sortorder,queueBrowse_1);
				}
				if (brw1Refreshmode.equals(Constants.REFRESHONBOTTOM)) {
					brw1Filldirection.setValue(Constants.FILLFORWARD);
				}
				else {
					brw1Filldirection.setValue(Constants.FILLBACKWARD);
				}
				browsenodalas_brw1Fillrecord(brw1Recordcount,brw1Filldirection,queueBrowse_1,brw1ViewBrowse,brw1Skipfirst,brw1Itemstofill,brw1Addqueue,quickwindow,nos_p);
			}
		}
		if (brw1Recordcount.boolValue()) {
			if (brw1Highlightedposition.boolValue()) {
				final ClarionNumber loop_1=brw1Recordcount.like();for (brw1Currentchoice.setValue(1);brw1Currentchoice.compareTo(loop_1)<=0;brw1Currentchoice.increment(1)) {
					queueBrowse_1.get(brw1Currentchoice);
					if (queueBrowse_1.brw1Position.equals(brw1Highlightedposition)) {
						break;
					}
				}
				if (brw1Currentchoice.compareTo(brw1Recordcount)>0) {
					brw1Currentchoice.setValue(brw1Recordcount);
				}
			}
			else {
				if (brw1Refreshmode.equals(Constants.REFRESHONBOTTOM)) {
					brw1Currentchoice.setValue(queueBrowse_1.records());
				}
				else {
					brw1Currentchoice.setValue(1);
				}
			}
			Clarion.getControl(quickwindow._browse_1).setClonedProperty(Prop.SELECTED,brw1Currentchoice);
			browsenodalas_brw1Fillbuffer(queueBrowse_1,nos_p);
			Clarion.getControl(quickwindow._change_3).setProperty(Prop.DISABLE,0);
			Clarion.getControl(quickwindow._delete_3).setProperty(Prop.DISABLE,0);
		}
		else {
			Main.nodalas.clear();
			brw1Currentchoice.setValue(0);
			Clarion.getControl(quickwindow._change_3).setProperty(Prop.DISABLE,1);
			Clarion.getControl(quickwindow._delete_3).setProperty(Prop.DISABLE,1);
		}
		CWin.setCursor(null);
		brw1Refreshmode.setValue(0);
		return;
	}
	public static void browsenodalas_brw1Postnewselection(ClarionNumber brw1Newselectposted,Quickwindow_1 quickwindow,QueueBrowse_1 queueBrowse_1)
	{
		if (!brw1Newselectposted.boolValue()) {
			brw1Newselectposted.setValue(Constants.TRUE);
			CWin.post(Event.NEWSELECTION,quickwindow._browse_1);
		}
	}
	public static void browsenodalas_brw1Fillrecord(ClarionNumber brw1Recordcount,ClarionNumber brw1Filldirection,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse,ClarionNumber brw1Skipfirst,ClarionNumber brw1Itemstofill,ClarionNumber brw1Addqueue,Quickwindow_1 quickwindow,ClarionString nos_p)
	{
		if (brw1Recordcount.boolValue()) {
			if (brw1Filldirection.equals(Constants.FILLFORWARD)) {
				queueBrowse_1.get(brw1Recordcount);
			}
			else {
				queueBrowse_1.get(1);
			}
			brw1ViewBrowse.reset(queueBrowse_1.brw1Position);
			brw1Skipfirst.setValue(Constants.TRUE);
		}
		else {
			brw1Skipfirst.setValue(Constants.FALSE);
		}
		while (brw1Itemstofill.boolValue()) {
			if (brw1Filldirection.equals(Constants.FILLFORWARD)) {
				brw1ViewBrowse.next();
			}
			else {
				brw1ViewBrowse.previous();
			}
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					browsenodalas_brw1Restoreresetvalues();
					break;
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("NODALAS"));
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
					queueBrowse_1.delete();
					brw1Recordcount.decrement(1);
				}
				browsenodalas_brw1Fillqueue(nos_p,queueBrowse_1,brw1ViewBrowse);
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
	public static void browsenodalas_brw1Buttonchange(ClarionNumber localrequest,ClarionNumber brw1Locatemode,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse,ClarionNumber brw1Sortorder,ClarionString brw1Highlightedposition,ClarionNumber brw1Recordcount,ClarionNumber brw1Itemstofill,ClarionNumber brw1Filldirection,ClarionNumber brw1Addqueue,ClarionNumber brw1Skipfirst,Quickwindow_1 quickwindow,ClarionString nos_p,ClarionNumber brw1Refreshmode,ClarionNumber brw1Newselectposted,ClarionNumber brw1Currentchoice,ClarionString brw1Sort2Highvalue,ClarionString brw1Sort2Lowvalue,ClarionNumber brw1Scrollrecordcount,ClarionArray<ClarionString> brw1Sort2Keydistribution,ClarionNumber originalrequest,ClarionNumber localresponse,ClarionNumber brw1Currentscroll,ClarionNumber forcerefresh,ClarionNumber brw1Lastsortorder,ClarionNumber brw1Changed,ClarionNumber brw1Currentevent,ClarionString brw1Popuptext)
	{
		localrequest.setValue(Constants.CHANGERECORD);
		browsenodalas_brw1Callupdate(brw1ViewBrowse,localrequest,localresponse,queueBrowse_1,brw1Currentevent,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Skipfirst,brw1Addqueue,quickwindow,nos_p,brw1Sortorder,brw1Locatemode,brw1Highlightedposition,brw1Refreshmode,brw1Newselectposted,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Changed,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,brw1Popuptext);
		if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
			brw1Locatemode.setValue(Constants.LOCATEONEDIT);
			browsenodalas_brw1Locaterecord(brw1Locatemode,queueBrowse_1,brw1ViewBrowse,brw1Sortorder,brw1Highlightedposition,brw1Recordcount,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst,quickwindow,nos_p,brw1Refreshmode,brw1Newselectposted,brw1Currentchoice);
		}
		else {
			brw1Refreshmode.setValue(Constants.REFRESHONQUEUE);
			browsenodalas_brw1Refreshpage(brw1Refreshmode,brw1Highlightedposition,brw1ViewBrowse,queueBrowse_1,brw1Currentchoice,brw1Recordcount,brw1Itemstofill,quickwindow,brw1Filldirection,brw1Skipfirst,brw1Addqueue,nos_p,brw1Sortorder);
		}
		browsenodalas_brw1Initializebrowse(brw1ViewBrowse,queueBrowse_1,brw1Sortorder,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution);
		browsenodalas_brw1Postnewselection(brw1Newselectposted,quickwindow,queueBrowse_1);
		CWin.select(quickwindow._browse_1);
		localrequest.setValue(originalrequest);
		localresponse.setValue(Constants.REQUESTCANCELLED);
		browsenodalas_refreshwindow(quickwindow,brw1Currentscroll,forcerefresh,brw1Lastsortorder,brw1Sortorder,brw1Changed,queueBrowse_1,localrequest,brw1Locatemode,brw1Refreshmode,brw1Recordcount,brw1Currentchoice,brw1ViewBrowse,brw1Sort2Highvalue,brw1Sort2Lowvalue,brw1Scrollrecordcount,brw1Sort2Keydistribution,nos_p,brw1Newselectposted,brw1Highlightedposition,brw1Itemstofill,brw1Filldirection,brw1Addqueue,brw1Skipfirst);
	}
	public static void browsenodalas_updatedispatch(Browsebuttons browsebuttons,QueueBrowse_1 queueBrowse_1)
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
	public static void main()
	{
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber originalrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber localresponse=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber windowopened=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber windowinitialized=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber forcerefresh=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString currenttab=Clarion.newString(80);
		ClarionString fing=Clarion.newString(35);
		Windowresizetype winresize=new Windowresizetype();
		Appframe appframe=new Appframe();
		ClarionNumber autoAttempts=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionDecimal summakopa=Clarion.newDecimal(12,2);
		ClarionString rekinanr_s=Clarion.newString(11);
		ClarionString soundfile=Clarion.newString(80).setEncoding(ClarionString.CSTRING);
		ClarionNumber wldatums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber ftpdatums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString exename=Clarion.newString(30);
		Ftp_window ftp_window=new Ftp_window(ftpdatums,wldatums);
		Tfile_b tfile_b=new Tfile_b();
		try {
			CExpression.pushBind();
			localrequest.setValue(Main.globalrequest);
			originalrequest.setValue(Main.globalrequest);
			localresponse.setValue(Constants.REQUESTCANCELLED);
			forcerefresh.setValue(Constants.FALSE);
			Main.globalrequest.clear();
			Main.globalresponse.clear();
			Main.opcija_nr.setValue(1);
			Main.opcija_nr.setValue(0);
			if (CWin.keyCode()==Constants.MOUSERIGHT) {
				CWin.setKeyCode(0);
			}
			System.out.println("winl001.main() before prepare");
			main_prepareprocedure(filesopened,appframe,windowopened);
			System.out.println("winl001.main() before checkopen");
			Winla_sf.checkopen(Main.global,Clarion.newNumber(1));
			if (!Main.global.db_gads.boolValue()) {
				Main.global.db_gads.setValue(CDate.year(CDate.today()));
				Main.global.db_s_dat.setValue(CDate.date(1,1,Main.global.db_gads.intValue()));
				Main.global.db_b_dat.setValue(CDate.date(12,31,Main.global.db_gads.intValue()));
				if (Winla_ru.riupdateGlobal().boolValue()) {
					Winla043.kluda(Clarion.newNumber(24),Clarion.newString("GLOBAL"));
				}
			}
			Main.gads.setValue(Main.global.db_gads);
			Main.db_gads.setValue(Main.global.db_gads);
			Main.db_s_dat.setValue(Main.global.db_s_dat);
			Main.db_b_dat.setValue(Main.global.db_b_dat);
			if (!(CDate.year(Main.db_s_dat.intValue())==CDate.year(Main.db_b_dat.intValue()))) {
				Main.db_fgk.setValue(12-CDate.month(Main.db_s_dat.intValue())+1);
			}
			Main.global.close();
			System.out.println("winl001.main() 001");
			Main.dzfname.setValue("DZFILES");
			Main.ggname.setValue("GG01");
			Main.ggkname.setValue("GGK01");
			Main.parname.setValue("PAR_K");
			Main.nomname.setValue("NOM_K");
			Main.val_uzsk.setValue("");
			if (Main.global.db_gads.compareTo(2013)>0) {
				Main.val_uzsk.setValue(Winla048.getval_k(Clarion.newString("EUR"),Clarion.newNumber(0)));
				if (!Main.val_uzsk.boolValue()) {
					CRun.stop("Failâ Valûtas nav atrodams EUR...");
					Main.val_uzsk.setValue("EUR");
				}
			}
			Main.val_lv.setValue(Winla048.getval_k(Clarion.newString("Ls"),Clarion.newNumber(0)));
			if (!Main.val_lv.boolValue()) {
				Main.val_lv.setValue(Winla048.getval_k(Clarion.newString("LVL"),Clarion.newNumber(0)));
				if (!Main.val_lv.boolValue()) {
					Main.val_lv.setValue("Ls");
				}
			}
			Main.val_nos.setValue(Main.val_lv);
			Winla_sf.checkopen(Main.bankas_k,Clarion.newNumber(1));
			Main.bankas_k.close();
			if (Main.val_uzsk.equals("")) {
				Main.val_uzsk.setValue("Ls");
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
						if (!windowinitialized.boolValue()) {
							main_initializewindow(appframe,forcerefresh);
							windowinitialized.setValue(Constants.TRUE);
						}
						CWin.select(1);
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.GAINFOCUS) {
						forcerefresh.setValue(Constants.TRUE);
						if (!windowinitialized.boolValue()) {
							main_initializewindow(appframe,forcerefresh);
							windowinitialized.setValue(Constants.TRUE);
						}
						else {
							main_refreshwindow(appframe,forcerefresh);
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.REJECTED) {
						CWin.beep();
						CWin.display(CWin.field());
						CWin.select(CWin.field());
						case_1_break=true;
					}
					if (!case_1_break) {
						if (CRun.inRange(Clarion.newNumber(CWin.accepted()),Clarion.newNumber(Constants.TBARBRWFIRST),Clarion.newNumber(Constants.TBARBRWLAST))) {
							CWin.post(Event.ACCEPTED,CWin.accepted(),Main.system.getProperty(Prop.ACTIVE).intValue());
							continue;
						}
					}
				}
				{
					int case_2=CWin.accepted();
					boolean case_2_break=false;
					if (case_2==appframe._exit) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._seanssparmani) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._servisskalkulators) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._systemglob) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._systemparoles) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._browsekon_k) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._browsebankas_k) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._browseval_k) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._browsekursi_k) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._fourfaili6nodalas) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._failiprojekti) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._failiatzimespartneriem) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._fourfaili9izzinasnofailiem1partnerusaraksts) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._izzinasnofailiemkontuplans) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._fourfaili9izzinasnofailiem2bankusarakstsplans) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._failiizzinasnofailiematlaizulapas) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._failiizzinasnofailiempieskirtasatlaides) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._fourfaili9izzinasnofailiem6atlaidesklientiem) {
						case_2_break=true;
					}
					if (!case_2_break && case_2==appframe._fourfailizizz7atzpartneriem) {
						case_2_break=true;
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			try {
				main_procedurereturn(filesopened,windowopened,appframe,localresponse);
			} catch (ClarionRoutineResult _crr) {
				return;
			}
		} finally {
			appframe.close();
			ftp_window.close();
		}
	}
	public static void main_procedurereturn(ClarionNumber filesopened,ClarionNumber windowopened,Appframe appframe,ClarionNumber localresponse) throws ClarionRoutineResult
	{
		if (filesopened.boolValue()) {
		}
		if (windowopened.boolValue()) {
			appframe.close();
		}
		if (Main.acc_kods_n.boolValue()) {
			Winla_sf.checkopen(Main.paroles,Clarion.newNumber(1));
			Main.paroles.u_nr.setValue(Main.acc_kods_n);
			Main.paroles.get(Main.paroles.nr_key);
			if (!(CError.error().length()!=0)) {
				Main.paroles.dup_acc.setValue(0);
				Main.paroles.put();
			}
			else {
				CRun.stop(ClarionString.staticConcat("NEVAR ATRAST SEC:U_NR=",Main.acc_kods_n));
			}
			Main.paroles.close();
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
	public static void main_initializewindow(Appframe appframe,ClarionNumber forcerefresh)
	{
		main_refreshwindow(appframe,forcerefresh);
	}
	public static void main_refreshwindow(Appframe appframe,ClarionNumber forcerefresh)
	{
		if (appframe.getProperty(Prop.ACCEPTALL).boolValue()) {
			return;
		}
		CWin.display();
		forcerefresh.setValue(Constants.FALSE);
	}
	public static void main_syncwindow()
	{
	}
	public static void main_prepareprocedure(ClarionNumber filesopened,Appframe appframe,ClarionNumber windowopened)
	{
		System.out.println("Hello PrepareProcedure");
		filesopened.setValue(Constants.TRUE);
		appframe.open();
		windowopened.setValue(Constants.TRUE);
	}
}
