package clarion.winla043;

import clarion.Main;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Prop;
import clarion.equates.Record;
import clarion.equates.Warn;
import clarion.winla043.K_table;
import clarion.winla043.ProcessView;
import clarion.winla043.Progresswindow;
import clarion.winla043.Report;
import clarion.winla043.Window;
import clarion.winla_sf.Winla_sf;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionRoutineResult;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Winla043
{

	public static void b_dekr()
	{
		ClarionString cg=Clarion.newString(10);
		ClarionString cycleggk=Clarion.newString(10);
		ClarionDecimal p2190=Clarion.newDecimal(13,2);
		ClarionDecimal p2310=Clarion.newDecimal(13,2);
		ClarionDecimal p5210=Clarion.newDecimal(13,2);
		ClarionDecimal p5310=Clarion.newDecimal(13,2);
		ClarionDecimal k2190=Clarion.newDecimal(13,2);
		ClarionDecimal k2310=Clarion.newDecimal(13,2);
		ClarionDecimal k5210=Clarion.newDecimal(13,2);
		ClarionDecimal k5310=Clarion.newDecimal(13,2);
		ClarionDecimal v2190=Clarion.newDecimal(13,2);
		ClarionDecimal v2310=Clarion.newDecimal(13,2);
		ClarionDecimal v5210=Clarion.newDecimal(13,2);
		ClarionDecimal v5310=Clarion.newDecimal(13,2);
		ClarionDecimal r2190=Clarion.newDecimal(13,2);
		ClarionDecimal r2310=Clarion.newDecimal(13,2);
		ClarionDecimal r5210=Clarion.newDecimal(13,2);
		ClarionDecimal r5310=Clarion.newDecimal(13,2);
		ClarionDecimal l2190=Clarion.newDecimal(13,2);
		ClarionDecimal l2310=Clarion.newDecimal(13,2);
		ClarionDecimal l5210=Clarion.newDecimal(13,2);
		ClarionDecimal l5310=Clarion.newDecimal(13,2);
		ClarionDecimal kv2190=Clarion.newDecimal(13,2);
		ClarionDecimal kv2310=Clarion.newDecimal(13,2);
		ClarionDecimal kv5210=Clarion.newDecimal(13,2);
		ClarionDecimal kv5310=Clarion.newDecimal(13,2);
		ClarionDecimal pv2190=Clarion.newDecimal(13,2);
		ClarionDecimal pv2310=Clarion.newDecimal(13,2);
		ClarionDecimal pv5210=Clarion.newDecimal(13,2);
		ClarionDecimal pv5310=Clarion.newDecimal(13,2);
		ClarionNumber dat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lai=Clarion.newNumber().setEncoding(ClarionNumber.TIME);
		ClarionDecimal ggnr=Clarion.newDecimal(5,0);
		ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString dok_nr=Clarion.newString(14);
		ClarionString koment=Clarion.newString(70);
		ClarionString nos_p=Clarion.newString(35);
		ClarionString saturs=Clarion.newString(60);
		ClarionString satursv=Clarion.newString(60);
		ClarionString saturs2=Clarion.newString(60);
		ClarionString saturs3=Clarion.newString(60);
		ClarionString kvnos=Clarion.newString(3);
		ClarionString vnos=Clarion.newString(3);
		ClarionString pvnos=Clarion.newString(3);
		ClarionString ts=Clarion.newString(12);
		ClarionString tsp=Clarion.newString(12);
		ClarionString filtrs=Clarion.newString(15);
		K_table k_table=new K_table();
		ClarionString bkk=Clarion.newString(3);
		ClarionNumber valuta=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber valutap=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
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
		ClarionView processView=new ProcessView();
		Report report=new Report(koment,datums,saturs,ggnr,dok_nr,r2190,r2310,r5210,r5310,v2310,v5210,v5310,vnos,v2190,satursv,saturs2,saturs3,p2190,p5310,p5210,p2310,k2190,k2310,k5210,k5310,ts,kv2190,kv2310,kv5210,kv5310,kvnos,tsp,pv2190,pv2310,pv5210,pv5310,pvnos,dat,lai,l2190,l2310,l5210,l5310);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Progresswindow progresswindow=new Progresswindow(progressThermometer);
		ClarionBool printskipdetails=Clarion.newBool();
		ClarionNumber _v_number=Clarion.newNumber();
		ClarionNumber _nk_number=Clarion.newNumber();
		ClarionNumber _j_number=Clarion.newNumber();
		ClarionNumber _i_number=Clarion.newNumber();
		try {
			CExpression.pushBind();
			Winla_sf.checkopen(Main.global,Clarion.newNumber(1));
			Winla_sf.checkopen(Main.system,Clarion.newNumber(1));
			Winla_sf.checkopen(Main.ggk,Clarion.newNumber(1));
			Winla_sf.checkopen(Main.gg,Clarion.newNumber(1));
			Winla_sf.checkopen(Main.par_k,Clarion.newNumber(1));
			Winla_sf.checkopen(Main.kon_k,Clarion.newNumber(1));
			Winla_sf.checkopen(Main.val_k,Clarion.newNumber(1));
			CExpression.bind("CG",cg);
			CExpression.bind("CYCLEGGK",cycleggk);
			valuta.setValue(0);
			valutap.setValue(0);
			_v_number.setValue(0);
			koment.setValue(ClarionString.staticConcat("Nor��ini ar : ",nos_p.clip()," ",Main.s_dat.getString().format("@D06."),"-",Main.b_dat.getString().format("@D06.")));
			Winla_sf.checkopen(Main.val_k);
			Main.val_k.clear();
			Main.val_k.nos_key.setStart();
			b_dekr_nextval(_v_number);
			while (!_v_number.boolValue()) {
				k_table.nos.setValue(Main.val_k.val);
				k_table.k2190.setValue(0);
				k_table.k2310.setValue(0);
				k_table.k5210.setValue(0);
				k_table.k5310.setValue(0);
				k_table.p2190.setValue(0);
				k_table.p2310.setValue(0);
				k_table.p5210.setValue(0);
				k_table.p5310.setValue(0);
				k_table.get(0);
				k_table.add(k_table.ORDER().ascend(k_table.nos));
				b_dekr_nextval(_v_number);
			}
			k_table.sort(k_table.ORDER().ascend(k_table.nos));
			k2190.setValue(0);
			k2310.setValue(0);
			k5210.setValue(0);
			k5310.setValue(0);
			p2190.setValue(0);
			p2310.setValue(0);
			p5210.setValue(0);
			p5310.setValue(0);
			localrequest.setValue(Main.globalrequest);
			localresponse.setValue(Constants.REQUESTCANCELLED);
			Main.globalrequest.clear();
			Main.globalresponse.clear();
			if (Main.ggkUsed.equals(0)) {
				Winla_sf.checkopen(Main.ggk,Clarion.newNumber(1));
			}
			Main.ggkUsed.increment(1);
			CExpression.bind(Main.ggk);
			filesopened.setValue(Constants.TRUE);
			recordstoprocess.setValue(Main.ggk.records());
			recordspercycle.setValue(25);
			recordsprocessed.setValue(0);
			percentprogress.setValue(0);
			progresswindow.open();
			progressThermometer.setValue(0);
			Clarion.getControl(progresswindow._progressPcttext).setProperty(Prop.TEXT,"0%");
			progresswindow.setProperty(Prop.TEXT,"B�v�jam izzi�u");
			Clarion.getControl(progresswindow._progressUserstring).setProperty(Prop.TEXT,"");
			Main.ggk.send("QUICKSCAN=on");
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_1=CWin.event();
					boolean case_1_break=false;
					if (case_1==Event.OPENWINDOW) {
						Main.ggk.clear();
						Main.ggk.par_nr.setValue(Main.par_nr);
						Main.ggk.datums.setValue(CDate.date(1,1,CDate.year(Main.s_dat.intValue())));
						cg.setValue("K1100");
						Main.ggk.par_key.set(Main.ggk.par_key);
						processView.setProperty(Prop.FILTER,"INSTRING(GGK:BKK[1:3],'219231521531',3,1) AND ~CYCLEGGK(CG)");
						if (CError.errorCode()!=0) {
							Winla_sf.standardwarning(Clarion.newNumber(Warn.VIEWOPENERROR));
						}
						processView.open();
						if (CError.errorCode()!=0) {
							Winla_sf.standardwarning(Clarion.newNumber(Warn.VIEWOPENERROR));
						}
						while (true) {
							b_dekr_getnextrecord(processView,localresponse,recordsprocessed,recordsthiscycle,percentprogress,recordstoprocess,progressThermometer,progresswindow);
							b_dekr_validaterecord(recordstatus,localresponse);
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
						if (Main.fDbf.equals("W")) {
							report.open();
							report.setClonedProperty(Prop.PREVIEW,Main.printpreviewqueue.printpreviewimage);
						}
						else {
							Main.outfileansi.line.setValue("");
							Main.outfileansi.add();
							Main.outfileansi.line.setValue(Main.client);
							Main.outfileansi.add();
							Main.outfileansi.line.setValue(koment);
							Main.outfileansi.add();
							Main.outfileansi.line.setValue(Main.s_dat.getString().format("@d06.").concat(" - ",Main.b_dat.getString().format("@d06.")));
							Main.outfileansi.add();
							Main.outfileansi.line.setValue("");
							Main.outfileansi.add();
							Main.outfileansi.line.setValue("");
							Main.outfileansi.add();
							if (Main.fDbf.equals("E")) {
								Main.outfileansi.line.setValue(ClarionString.staticConcat("NR GG",ClarionString.chr(9),"Dokumenta",ClarionString.chr(9),"Datums",ClarionString.chr(9),"Ieraksta saturs",ClarionString.chr(9),"219** (+)-mums",ClarionString.chr(9),"231** (+)-mums",ClarionString.chr(9),"521** (-)-m�s esam",ClarionString.chr(9),"531** (-)-m�s esam"));
								Main.outfileansi.add();
								Main.outfileansi.line.setValue(ClarionString.chr(9).concat("numurs",ClarionString.chr(9),ClarionString.chr(9),ClarionString.chr(9),"par�d� preci",ClarionString.chr(9),"par�d� naudu",ClarionString.chr(9),"par�d� preci",ClarionString.chr(9),"par�d� naudu"));
								Main.outfileansi.add();
							}
							else {
								Main.outfileansi.line.setValue(ClarionString.staticConcat("NR GG",ClarionString.chr(9),"Dokumenta numurs",ClarionString.chr(9),"Datums",ClarionString.chr(9),"Ieraksta saturs",ClarionString.chr(9),"219** (+)-mums par�d� preci",ClarionString.chr(9),"231** (+)-mums par�d� naudu",ClarionString.chr(9),"521** (-)-m�s esam par�d� preci",ClarionString.chr(9),"531** (-)-m�s esam par�d� naudu"));
								Main.outfileansi.add();
							}
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.TIMER) {
						for (int loop_1=recordspercycle.intValue();loop_1>0;loop_1--) {
							_nk_number.increment(1);
							Clarion.getControl(progresswindow._progressUserstring).setClonedProperty(Prop.TEXT,_nk_number);
							CWin.display(progresswindow._progressUserstring);
							if (Main.ggk.d_k.equals("K")) {
								Main.ggk.summa.setValue(Main.ggk.summa.negate());
								Main.ggk.summav.setValue(Main.ggk.summav.negate());
							}
							bkk.setValue(Main.ggk.bkk.stringAt(1,3));
							{
								ClarionString case_3=bkk;
								boolean case_3_break=false;
								if (case_3.equals("219")) {
									k2190.increment(Main.ggk.summa);
									case_3_break=true;
								}
								if (!case_3_break && case_3.equals("231")) {
									k2310.increment(Main.ggk.summa);
									case_3_break=true;
								}
								if (!case_3_break && case_3.equals("521")) {
									k5210.increment(Main.ggk.summa);
									case_3_break=true;
								}
								if (!case_3_break && case_3.equals("531")) {
									k5310.increment(Main.ggk.summa);
									case_3_break=true;
								}
								if (!case_3_break) {
									CRun.stop(bkk.toString());
								}
							}
							if (!Main.ggk.val.equals(Main.val_uzsk)) {
								valuta.setValue(Constants.TRUE);
							}
							if (!((Main.ggk.baits.intValue() & 0x1)!=0)) {
								k_table.get(0);
								k_table.nos.setValue(Main.ggk.val);
								k_table.get(k_table.ORDER().ascend(k_table.nos));
								if (CError.error().length()!=0) {
									Winla043.kluda(Clarion.newNumber("16"),Main.ggk.u_nr.getString());
									k_table.free();
									report.close();
									try {
										b_dekr_procedurereturn(filesopened,localresponse,k_table);
									} catch (ClarionRoutineResult _crr) {
										return;
									}
								}
								bkk.setValue(Main.ggk.bkk.sub(1,3));
								{
									ClarionString case_4=bkk;
									boolean case_4_break=false;
									if (case_4.equals("219")) {
										k_table.k2190.increment(Main.ggk.summav);
										case_4_break=true;
									}
									if (!case_4_break && case_4.equals("231")) {
										k_table.k2310.increment(Main.ggk.summav);
										case_4_break=true;
									}
									if (!case_4_break && case_4.equals("521")) {
										k_table.k5210.increment(Main.ggk.summav);
										case_4_break=true;
									}
									if (!case_4_break && case_4.equals("531")) {
										k_table.k5310.increment(Main.ggk.summav);
										case_4_break=true;
									}
								}
								k_table.put();
							}
							if (Main.ggk.datums.compareTo(Main.s_dat)>=0) {
								r2190.setValue(0);
								r2310.setValue(0);
								r5210.setValue(0);
								r5310.setValue(0);
								v2190.setValue(0);
								v2310.setValue(0);
								v5210.setValue(0);
								v5310.setValue(0);
								bkk.setValue(Main.ggk.bkk.sub(1,3));
								{
									ClarionString case_5=bkk;
									boolean case_5_break=false;
									if (case_5.equals("219")) {
										p2190.increment(Main.ggk.summa);
										l2190.increment(Main.ggk.summa);
										r2190.setValue(Main.ggk.summa);
										case_5_break=true;
									}
									if (!case_5_break && case_5.equals("231")) {
										p2310.increment(Main.ggk.summa);
										l2310.increment(Main.ggk.summa);
										r2310.setValue(Main.ggk.summa);
										case_5_break=true;
									}
									if (!case_5_break && case_5.equals("521")) {
										p5210.increment(Main.ggk.summa);
										l5210.increment(Main.ggk.summa);
										r5210.setValue(Main.ggk.summa);
										case_5_break=true;
									}
									if (!case_5_break && case_5.equals("531")) {
										p5310.increment(Main.ggk.summa);
										l5310.increment(Main.ggk.summa);
										r5310.setValue(Main.ggk.summa);
										case_5_break=true;
									}
								}
								if (!Main.ggk.val.equals(Main.val_uzsk)) {
									valutap.setValue(Constants.TRUE);
								}
								if (!((Main.ggk.baits.intValue() & 0x1)!=0)) {
									k_table.get(0);
									k_table.nos.setValue(Main.ggk.val);
									k_table.get(k_table.ORDER().ascend(k_table.nos));
									if (CError.error().length()!=0) {
										Winla043.kluda(Clarion.newNumber("16"),Main.ggk.u_nr.getString());
										k_table.free();
										report.close();
										try {
											b_dekr_procedurereturn(filesopened,localresponse,k_table);
										} catch (ClarionRoutineResult _crr) {
											return;
										}
									}
									bkk.setValue(Main.ggk.bkk.sub(1,3));
									{
										ClarionString case_6=bkk;
										boolean case_6_break=false;
										if (case_6.equals("219")) {
											k_table.p2190.increment(Main.ggk.summav);
											v2190.setValue(Main.ggk.summav);
											case_6_break=true;
										}
										if (!case_6_break && case_6.equals("231")) {
											k_table.p2310.increment(Main.ggk.summav);
											v2310.setValue(Main.ggk.summav);
											case_6_break=true;
										}
										if (!case_6_break && case_6.equals("521")) {
											k_table.p5210.increment(Main.ggk.summav);
											v5210.setValue(Main.ggk.summav);
											case_6_break=true;
										}
										if (!case_6_break && case_6.equals("531")) {
											k_table.p5310.increment(Main.ggk.summav);
											v5310.setValue(Main.ggk.summav);
											case_6_break=true;
										}
									}
									vnos.setValue(Main.ggk.val);
									k_table.put();
								}
								Main.gg.u_nr.setValue(Main.ggk.u_nr);
								Main.gg.get(Main.gg.nr_key);
								if (CError.error().length()!=0) {
									Main.gg.clear();
								}
								ggnr.setValue(Main.gg.u_nr);
								datums.setValue(Main.gg.datums);
								Main.teksts.setValue(Main.gg.saturs.clip().concat(" ",Main.gg.saturs2.clip()," ",Main.gg.saturs3.clip()));
								saturs.setValue(Main.f_teksts.get(1));
								satursv.setValue(Main.f_teksts.get(2));
								saturs2.setValue(Main.f_teksts.get(2));
								saturs3.setValue(Main.f_teksts.get(3));
								dok_nr.setValue(Main.gg.dok_senr);
								if (!Main.fDtk.boolValue()) {
									if (Main.fDbf.equals("W")) {
										report.detail.print();
									}
									else {
										Main.outfileansi.line.setValue(ggnr.getString().clip().concat(ClarionString.chr(9),dok_nr,ClarionString.chr(9),datums.getString().format("@D06."),ClarionString.chr(9),saturs,ClarionString.chr(9),r2190.getString().format("@N-_13.2B").left(),ClarionString.chr(9),r2310.getString().format("@N-_13.2B").left(),ClarionString.chr(9),r5210.getString().format("@N-_13.2B").left(),ClarionString.chr(9),r5310.getString().format("@N-_13.2B").left()));
										Main.outfileansi.add();
									}
								}
								if (!Main.ggk.val.equals(Main.val_uzsk)) {
									if (!Main.fDtk.boolValue()) {
										if (Main.fDbf.equals("W")) {
											report.detailv.print();
										}
										else {
											Main.outfileansi.line.setValue(ClarionString.staticConcat("T.S.",ClarionString.chr(9),ClarionString.chr(9),ClarionString.chr(9),satursv,ClarionString.chr(9),v2190.getString().format("@N-_13.2").left(),ClarionString.chr(9),v2310.getString().format("@N-_13.2").left(),ClarionString.chr(9),v5210.getString().format("@N-_13.2").left(),ClarionString.chr(9),v5310.getString().format("@N-_13.2").left(),ClarionString.chr(9),vnos));
											Main.outfileansi.add();
										}
									}
								}
								else if (saturs2.boolValue()) {
									if (!Main.fDtk.boolValue()) {
										if (Main.fDbf.equals("W")) {
											report.detail2.print();
										}
										else {
											Main.outfileansi.line.setValue(ClarionString.chr(9).concat(ClarionString.chr(9),ClarionString.chr(9),saturs2));
											Main.outfileansi.add();
										}
									}
								}
								if (saturs3.boolValue()) {
									if (!Main.fDtk.boolValue()) {
										if (Main.fDbf.equals("W")) {
											report.detail3.print();
										}
										else {
											Main.outfileansi.line.setValue(ClarionString.chr(9).concat(ClarionString.chr(9),ClarionString.chr(9),saturs3));
											Main.outfileansi.add();
										}
									}
								}
							}
							while (true) {
								b_dekr_getnextrecord(processView,localresponse,recordsprocessed,recordsthiscycle,percentprogress,recordstoprocess,progressThermometer,progresswindow);
								b_dekr_validaterecord(recordstatus,localresponse);
								{
									ClarionNumber case_7=recordstatus;
									boolean case_7_break=false;
									if (case_7.equals(Record.OUTOFRANGE)) {
										localresponse.setValue(Constants.REQUESTCANCELLED);
										break;
										// UNREACHABLE! :case_7_break=true;
									}
									if (!case_7_break && case_7.equals(Record.OK)) {
										break;
										// UNREACHABLE! :case_7_break=true;
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
					int case_8=CWin.field();
					if (case_8==progresswindow._progressCancel) {
						{
							int case_9=CWin.event();
							if (case_9==Event.ACCEPTED) {
								localresponse.setValue(Constants.REQUESTCANCELLED);
								CWin.post(Event.CLOSEWINDOW);
							}
						}
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			if (localresponse.equals(Constants.REQUESTCOMPLETED)) {
				dat.setValue(CDate.today());
				lai.setValue(CDate.clock());
				if (Main.fDbf.equals("W")) {
					report.per_foot.print();
				}
				else {
					Main.outfileansi.line.setValue(ClarionString.staticConcat("Kop� pa periodu:",ClarionString.chr(9),ClarionString.chr(9),ClarionString.chr(9),ClarionString.chr(9),p2190.getString().format("@N-_13.2B").left(),ClarionString.chr(9),p2310.getString().format("@N-_13.2B").left(),ClarionString.chr(9),p5210.getString().format("@N-_13.2B").left(),ClarionString.chr(9),p5310.getString().format("@N-_13.2B").left(),ClarionString.chr(9),Main.val_uzsk));
					Main.outfileansi.add();
				}
				if (valutap.boolValue()) {
					tsp.setValue("Tai skait� :");
					final int loop_2=k_table.records();for (_j_number.setValue(1);_j_number.compareTo(loop_2)<=0;_j_number.increment(1)) {
						k_table.get(_j_number);
						if (!k_table.p2190.add(k_table.p2310).add(k_table.p5210).add(k_table.p5310).equals(0)) {
							pv2190.setValue(k_table.p2190);
							pv2310.setValue(k_table.p2310);
							pv5210.setValue(k_table.p5210);
							pv5310.setValue(k_table.p5310);
							pvnos.setValue(k_table.nos);
							if (Main.fDbf.equals("W")) {
								report.per_footv.print();
							}
							else {
								Main.outfileansi.line.setValue(tsp.concat(ClarionString.chr(9),ClarionString.chr(9),ClarionString.chr(9),ClarionString.chr(9),pv2190.getString().format("@N-_13.2B").left(),ClarionString.chr(9),pv2310.getString().format("@N-_13.2B").left(),ClarionString.chr(9),pv5210.getString().format("@N-_13.2B").left(),ClarionString.chr(9),pv5310.getString().format("@N-_13.2B").left(),ClarionString.chr(9),pvnos));
								Main.outfileansi.add();
							}
							tsp.setValue("");
						}
					}
				}
				report.per_foot1.print();
				if (Main.fDbf.equals("W")) {
					report.rpt_foot.print();
				}
				else {
					Main.outfileansi.line.setValue(ClarionString.staticConcat("Kop� no gada s�kuma:",ClarionString.chr(9),ClarionString.chr(9),ClarionString.chr(9),ClarionString.chr(9),k2190.getString().format("@N-_13.2B").left(),ClarionString.chr(9),k2310.getString().format("@N-_13.2B").left(),ClarionString.chr(9),k5210.getString().format("@N-_13.2B").left(),ClarionString.chr(9),k5310.getString().format("@N-_13.2B").left(),ClarionString.chr(9),Main.val_uzsk));
					Main.outfileansi.add();
				}
				if (valuta.boolValue()) {
					ts.setValue("Tai skait� :");
					final int loop_3=k_table.records();for (_j_number.setValue(1);_j_number.compareTo(loop_3)<=0;_j_number.increment(1)) {
						k_table.get(_j_number);
						if (!k_table.k2190.add(k_table.k2310).add(k_table.k5210).add(k_table.k5310).equals(0)) {
							kv2190.setValue(k_table.k2190);
							kv2310.setValue(k_table.k2310);
							kv5210.setValue(k_table.k5210);
							kv5310.setValue(k_table.k5310);
							kvnos.setValue(k_table.nos);
							if (Main.fDbf.equals("W")) {
								report.rpt_footv.print();
							}
							else {
								Main.outfileansi.line.setValue(ts.concat(ClarionString.chr(9),ClarionString.chr(9),ClarionString.chr(9),ClarionString.chr(9),kv2190.getString().format("@N-_13.2B").left(),ClarionString.chr(9),kv2310.getString().format("@N-_13.2B").left(),ClarionString.chr(9),kv5210.getString().format("@N-_13.2B").left(),ClarionString.chr(9),kv5310.getString().format("@N-_13.2B").left(),ClarionString.chr(9),kvnos));
								Main.outfileansi.add();
							}
							ts.setValue("");
						}
					}
				}
				report.rpt_foot1.print();
				report.endPage();
				progresswindow.close();
				if (Main.fDbf.equals("W")) {
					if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
						final ClarionNumber loop_5=Main.prSkaits.like();for (_j_number.setValue(1);_j_number.compareTo(loop_5)<=0;_j_number.increment(1)) {
							report.setProperty(Prop.FLUSHPREVIEW,Constants.TRUE);
							if (!_j_number.equals(Main.prSkaits)) {
								final int loop_4=Main.printpreviewqueue1.records();for (_i_number.setValue(1);_i_number.compareTo(loop_4)<=0;_i_number.increment(1)) {
									Main.printpreviewqueue1.get(_i_number);
									Main.printpreviewqueue.printpreviewimage.setValue(Main.printpreviewqueue1.printpreviewimage1);
									Main.printpreviewqueue.add();
								}
							}
						}
					}
				}
				else {
				}
			}
			if (Main.fDbf.equals("W")) {
				report.close();
				Main.printpreviewqueue.free();
				Main.printpreviewqueue1.free();
			}
			else {
				Main.outfileansi.close();
				Main.ansifilename.setValue("");
			}
			try {
				b_dekr_procedurereturn(filesopened,localresponse,k_table);
			} catch (ClarionRoutineResult _crr) {
				return;
			}
		} finally {
			report.close();
			progresswindow.close();
		}
	}
	public static void b_dekr_procedurereturn(ClarionNumber filesopened,ClarionNumber localresponse,K_table k_table) throws ClarionRoutineResult
	{
		if (filesopened.boolValue()) {
			Main.ggkUsed.decrement(1);
			if (Main.ggkUsed.equals(0)) {
				Main.ggk.close();
			}
		}
		if (localresponse.boolValue()) {
			Main.globalresponse.setValue(localresponse);
		}
		else {
			Main.globalresponse.setValue(Constants.REQUESTCANCELLED);
		}
		k_table.free();
		CExpression.popBind();
		throw new ClarionRoutineResult();
	}
	public static void b_dekr_nextval(ClarionNumber _v_number)
	{
		while (!Main.val_k.eof()) {
			Main.val_k.next();
			return;
		}
		_v_number.setValue(1);
	}
	public static void b_dekr_validaterecord(ClarionNumber recordstatus,ClarionNumber localresponse)
	{
		recordstatus.setValue(Record.OUTOFRANGE);
		if (localresponse.equals(Constants.REQUESTCANCELLED)) {
			return;
		}
		recordstatus.setValue(Record.OK);
		return;
	}
	public static void b_dekr_getnextrecord(ClarionView processView,ClarionNumber localresponse,ClarionNumber recordsprocessed,ClarionNumber recordsthiscycle,ClarionNumber percentprogress,ClarionNumber recordstoprocess,ClarionNumber progressThermometer,Progresswindow progresswindow)
	{
		processView.next();
		if (CError.errorCode()!=0 || !Main.ggk.par_nr.equals(Main.par_nr)) {
			if (CError.errorCode()!=0 && CError.errorCode()!=Constants.BADRECERR) {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("GGK"));
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
	public static void kluda(ClarionNumber p0,ClarionString p1,ClarionNumber p2)
	{
		kluda(p0,p1,p2,(ClarionNumber)null);
	}
	public static void kluda(ClarionNumber p0,ClarionString p1)
	{
		kluda(p0,p1,(ClarionNumber)null);
	}
	public static void kluda(ClarionNumber opc,ClarionString norade,ClarionNumber da,ClarionNumber krasa)
	{
		ClarionString clakluda=Clarion.newString(80);
		ClarionString zina=Clarion.newString(90);
		ClarionString zina1=Clarion.newString(90);
		ClarionDecimal clanr=Clarion.newDecimal(2,0);
		ClarionString soundfile=Clarion.newString(80).setEncoding(ClarionString.CSTRING);
		Window window=new Window(zina1,zina,clakluda);
		try {
			soundfile.setValue("\\WINLATS\\BIN\\KLUDA.wav");
			clakluda.setValue(CError.error());
			clanr.setValue(CError.errorCode());
			window.open();
			if (opc.boolValue()) {
				Winla_sf.checkopen(Main.kludas,Clarion.newNumber(1));
				Main.kludas.clear();
				Main.kludas.nr.setValue(opc);
				Main.kludas.get(Main.kludas.nr_key);
				if (CError.error().length()!=0) {
					zina.setValue(ClarionString.staticConcat("K��das KODS= ",opc.getString().clip()," pa�emiet KLUDAS.TPS no www.assako.lv <BIN>"));
				}
				else {
					{
						ClarionDecimal case_1=Main.kludas.kartiba;
						boolean case_1_break=false;
						if (case_1.equals(1)) {
							zina.setValue(norade.clip().concat(" ",Main.kludas.koment.clip()));
							case_1_break=true;
						}
						if (!case_1_break) {
							zina.setValue(Main.kludas.koment.clip().concat(" ",norade.clip()));
						}
					}
					if (!da.boolValue()) {
						da.setValue(Main.kludas.darbiba);
					}
				}
			}
			else {
				Main.kludas.clear();
				zina.setValue(norade.clip());
			}
			{
				ClarionNumber case_2=da;
				boolean case_2_break=false;
				boolean case_2_match=false;
				case_2_match=false;
				if (case_2.equals(0)) {
					case_2_match=true;
				}
				if (case_2_match || case_2.equals(1)) {
					Clarion.getControl(window._darit).setProperty(Prop.TEXT,"   &OK  ");
					CWin.hide(window._nedarit);
					case_2_break=true;
				}
				case_2_match=false;
				if (!case_2_break && case_2.equals(2)) {
					Clarion.getControl(window._darit).setProperty(Prop.TEXT,"   &OK  ");
					Clarion.getControl(window._nedarit).setProperty(Prop.TEXT," &Atlikt  ");
					case_2_break=true;
				}
				case_2_match=false;
				if (!case_2_break && case_2.equals(3)) {
					Clarion.getControl(window._darit).setProperty(Prop.TEXT," Aiz&vietot  ");
					Clarion.getControl(window._nedarit).setProperty(Prop.TEXT," &Atlikt  ");
					case_2_break=true;
				}
				case_2_match=false;
				if (!case_2_break && case_2.equals(4)) {
					Clarion.getControl(window._darit).setProperty(Prop.TEXT," &P�rr��in�t  ");
					Clarion.getControl(window._nedarit).setProperty(Prop.TEXT," &Atlikt  ");
					case_2_break=true;
				}
				case_2_match=false;
				if (!case_2_break && case_2.equals(5)) {
					Clarion.getControl(window._darit).setProperty(Prop.TEXT," Aiz&vietot  ");
					Clarion.getControl(window._nedarit).setProperty(Prop.TEXT,"&Atst�t k� ir");
					case_2_break=true;
				}
				case_2_match=false;
				if (!case_2_break && case_2.equals(6)) {
					Clarion.getControl(window._darit).setProperty(Prop.TEXT," At&jaunot ");
					Clarion.getControl(window._nedarit).setProperty(Prop.TEXT," &Atlikt  ");
					case_2_break=true;
				}
				case_2_match=false;
				if (!case_2_break && case_2.equals(7)) {
					Clarion.getControl(window._darit).setProperty(Prop.TEXT," &OK ");
					Clarion.getControl(window._nedarit).setProperty(Prop.TEXT," &Nevajag  ");
					case_2_break=true;
				}
				case_2_match=false;
				if (!case_2_break && case_2.equals(8)) {
					Clarion.getControl(window._darit).setProperty(Prop.TEXT," Iz&veidot  ");
					Clarion.getControl(window._nedarit).setProperty(Prop.TEXT," &Atlikt  ");
					case_2_break=true;
				}
				case_2_match=false;
				if (!case_2_break && case_2.equals(9)) {
					Clarion.getControl(window._darit).setProperty(Prop.TEXT," &Atlikt  ");
					Clarion.getControl(window._nedarit).setProperty(Prop.TEXT,"   &OK  ");
					case_2_break=true;
				}
				case_2_match=false;
				if (!case_2_break && case_2.equals(10)) {
					Clarion.getControl(window._darit).setProperty(Prop.TEXT," &Atlikt  ");
					Clarion.getControl(window._nedarit).setProperty(Prop.TEXT,"Aiz&vietot");
					case_2_break=true;
				}
				case_2_match=false;
				if (!case_2_break && case_2.equals(11)) {
					Clarion.getControl(window._darit).setProperty(Prop.TEXT," &Nevajag");
					Clarion.getControl(window._nedarit).setProperty(Prop.TEXT," &Main�t");
					case_2_break=true;
				}
				case_2_match=false;
				if (!case_2_break && case_2.equals(12)) {
					Clarion.getControl(window._darit).setProperty(Prop.TEXT," &Apskat�t");
					Clarion.getControl(window._nedarit).setProperty(Prop.TEXT," &P�rb�v�t");
					case_2_break=true;
				}
			}
			if (krasa.equals(1)) {
				zina1.setValue(zina);
				zina.setValue("");
				window.setProperty(Prop.TEXT,"Zi�a");
			}
			clakluda.setValue(ClarionString.staticConcat("WinLats: ",opc.getString().clip()," Clarion5: ",clanr.getString().clip()," ",clakluda));
			CWin.display();
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_3=CWin.field();
					boolean case_3_break=false;
					if (case_3==window._darit) {
						if (CWin.event()==Event.ACCEPTED) {
							Main.klu_darbiba.setValue(1);
							Main.globalresponse.setValue(Constants.REQUESTCOMPLETED);
							break;
						}
						case_3_break=true;
					}
					if (!case_3_break && case_3==window._nedarit) {
						if (CWin.event()==Event.ACCEPTED) {
							Main.klu_darbiba.setValue(0);
							Main.globalresponse.setValue(Constants.REQUESTCOMPLETED);
							break;
						}
						case_3_break=true;
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			window.close();
		} finally {
			window.close();
		}
	}
	public static ClarionString inigen(ClarionString p0,ClarionNumber p2)
	{
		return inigen(p0,(ClarionNumber)null,p2);
	}
	public static ClarionString inigen(ClarionString lauks,ClarionNumber gar,ClarionNumber opc)
	{
		ClarionString burti=Clarion.newString(25);
		ClarionString burtim=Clarion.newString(22);
		ClarionArray<ClarionString> subst=Clarion.newString(6).dim(4);
		ClarionNumber _i_number=Clarion.newNumber();
		ClarionNumber _j_number=Clarion.newNumber();
		ClarionNumber _k_number=Clarion.newNumber();
		ClarionNumber _garumzime196_number=Clarion.newNumber();
		ClarionNumber _garumzime197_number=Clarion.newNumber();
		ClarionNumber _tukss_number=Clarion.newNumber();
		if (!CRun.inRange(opc,Clarion.newNumber(1),Clarion.newNumber(10))) {
			CRun.stop(ClarionString.staticConcat("INIGEN: PIEPRAS�TS ATGRIEZT:",opc));
			return Clarion.newString("");
		}
		if (!gar.boolValue() || gar.compareTo(lauks.clip().len())>0) {
			gar.setValue(lauks.clip().len());
		}
		if (!gar.boolValue()) {
			return Clarion.newString("");
		}
		{
			ClarionNumber case_1=opc;
			boolean case_1_break=false;
			if (case_1.equals(1)) {
				burti.setValue("AaCcEeGgIiKkLlNnSsUuZz");
				final ClarionNumber loop_1=gar.like();for (_i_number.setValue(1);_i_number.compareTo(loop_1)<=0;_i_number.increment(1)) {
					_j_number.setValue(Clarion.newString("����������������������").inString(lauks.stringAt(_i_number).toString()));
					if (_j_number.boolValue()) {
						lauks.setStringAt(_i_number,burti.stringAt(_j_number));
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(2)) {
				burti.setValue("�����������");
				final ClarionNumber loop_2=gar.like();for (_i_number.setValue(1);_i_number.compareTo(loop_2)<=0;_i_number.increment(1)) {
					_j_number.setValue(Clarion.newString("�����������").inString(lauks.stringAt(_i_number).toString()));
					if (_j_number.boolValue()) {
						lauks.setStringAt(_i_number,burti.stringAt(_j_number));
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(3)) {
				Winla043.kluda(Clarion.newNumber(0),Clarion.newString("Tiks main�ti Lielie/mazie burti(CASE) teko�ajam laukam"),Clarion.newNumber(5),Clarion.newNumber(1));
				if (Main.klu_darbiba.boolValue()) {
					burti.setValue("�����������");
					burtim.setValue("�����������");
					final ClarionNumber loop_3=gar.like();for (_i_number.setValue(1);_i_number.compareTo(loop_3)<=0;_i_number.increment(1)) {
						_j_number.setValue(Clarion.newString("�����������").inString(lauks.stringAt(_i_number).toString()));
						_k_number.setValue(Clarion.newString("�����������").inString(lauks.stringAt(_i_number).toString()));
						if (_j_number.boolValue()) {
							lauks.setStringAt(_i_number,burti.stringAt(_j_number));
						}
						else if (_k_number.boolValue()) {
							lauks.setStringAt(_i_number,burtim.stringAt(_k_number));
						}
						else {
						}
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(4)) {
				burti.setValue("AACCEEGGIIKKLLNNSSUUZZ");
				final ClarionNumber loop_4=gar.like();for (_i_number.setValue(1);_i_number.compareTo(loop_4)<=0;_i_number.increment(1)) {
					_j_number.setValue(Clarion.newString("����������������������").inString(lauks.stringAt(_i_number).toString()));
					if (_j_number.boolValue()) {
						lauks.setStringAt(_i_number,burti.stringAt(_j_number));
					}
				}
				lauks.setValue(lauks.upper());
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(5)) {
				burti.setValue("AaCcEeGgIiKkLlNnSsUuZz Oo");
				final ClarionNumber loop_5=gar.like();for (_i_number.setValue(1);_i_number.compareTo(loop_5)<=0;_i_number.increment(1)) {
					_j_number.setValue(Clarion.newString("����������������������&��").inString(lauks.stringAt(_i_number).toString()));
					if (_j_number.boolValue()) {
						lauks.setStringAt(_i_number,burti.stringAt(_j_number));
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(6)) {
				burti.setValue(" #           ");
				final ClarionNumber loop_6=gar.like();for (_i_number.setValue(1);_i_number.compareTo(loop_6)<=0;_i_number.increment(1)) {
					_j_number.setValue(Clarion.newString("@#$%^&*?~;\"=\\").inString(lauks.stringAt(_i_number).toString()));
					if (_j_number.boolValue()) {
						lauks.setStringAt(_i_number,burti.stringAt(_j_number));
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(7)) {
				burti.setValue("AaCcEeGgIiKkLlNnSsUuZzu_");
				final ClarionNumber loop_7=gar.like();for (_i_number.setValue(1);_i_number.compareTo(loop_7)<=0;_i_number.increment(1)) {
					_j_number.setValue(Clarion.newString("����������������������& ").inString(lauks.stringAt(_i_number).toString()));
					if (_j_number.boolValue()) {
						lauks.setStringAt(_i_number,burti.stringAt(_j_number));
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(8)) {
				burti.setValue(" ");
				final ClarionNumber loop_8=gar.like();for (_i_number.setValue(1);_i_number.compareTo(loop_8)<=0;_i_number.increment(1)) {
					_j_number.setValue(Clarion.newString("&").inString(lauks.stringAt(_i_number).toString()));
					if (_j_number.boolValue()) {
						lauks.setStringAt(_i_number,burti.stringAt(_j_number));
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(9)) {
				burti.setValue(".");
				_garumzime196_number.setValue(Constants.FALSE);
				_garumzime197_number.setValue(Constants.FALSE);
				_tukss_number.setValue(0);
				_k_number.increment(1);
				final ClarionNumber loop_9=gar.like();for (_i_number.setValue(1);_i_number.compareTo(loop_9)<=0;_i_number.increment(1)) {
					_j_number.setValue(lauks.stringAt(_i_number).val());
					if (_garumzime196_number.equals(Constants.TRUE)) {
						if (_j_number.equals(128)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(146)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(170)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(162)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(182)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(187)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(140)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(129)) {
							lauks.setStringAt(_k_number,"a");
						}
						else if (_j_number.equals(147)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(171)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(163)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(183)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(188)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(141)) {
							lauks.setStringAt(_k_number,"�");
						}
						else {
							lauks.setStringAt(_k_number," ");
						}
						_garumzime196_number.setValue(Constants.FALSE);
					}
					else if (_garumzime197_number.equals(Constants.TRUE)) {
						if (_j_number.equals(170)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(160)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(189)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(133)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(171)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(161)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(190)) {
							lauks.setStringAt(_k_number,"�");
						}
						else if (_j_number.equals(134)) {
							lauks.setStringAt(_k_number,"�");
						}
						else {
							lauks.setStringAt(_k_number," ");
						}
						_garumzime197_number.setValue(Constants.FALSE);
					}
					else {
						if (_j_number.equals(196)) {
							_garumzime196_number.setValue(Constants.TRUE);
							_tukss_number.increment(1);
							continue;
						}
						else if (_j_number.equals(197)) {
							_garumzime197_number.setValue(Constants.TRUE);
							_tukss_number.increment(1);
							continue;
						}
						lauks.setStringAt(_k_number,lauks.stringAt(_i_number));
					}
					_k_number.increment(1);
				}
				if (_tukss_number.compareTo(0)>0) {
					final ClarionObject loop_10=_tukss_number.subtract(1);for (_i_number.setValue(0);_i_number.compareTo(loop_10)<=0;_i_number.increment(1)) {
						lauks.setStringAt(_k_number.add(_i_number),"");
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(10)) {
				burti.setValue("\"\"<>");
				subst.get(1).setValue("&quot;");
				subst.get(2).setValue("&apos;");
				subst.get(3).setValue("&lt;");
				subst.get(4).setValue("&gt;");
				for (int loop_12=2;loop_12>0;loop_12--) {
					for (_i_number.setValue(1);_i_number.compareTo(4)<=0;_i_number.increment(1)) {
						_j_number.setValue(lauks.inString(subst.get(_i_number.intValue()).clip().toString(),1,1));
						if (_j_number.boolValue()) {
							lauks.setStringAt(_j_number,burti.stringAt(_i_number));
							lauks.setValue(lauks.stringAt(1,_j_number).concat(lauks.stringAt(_j_number.add(subst.get(_i_number.intValue()).clip().len()),lauks.clip().len())));
						}
					}
				}
				case_1_break=true;
			}
		}
		return lauks.sub(1,gar.intValue());
	}
}
