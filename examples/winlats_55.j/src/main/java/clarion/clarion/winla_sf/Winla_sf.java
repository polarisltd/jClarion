package clarion.winla_sf;

import clarion.Main;
import clarion.equates.Button;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Cursor;
import clarion.equates.Event;
import clarion.equates.Icon;
import clarion.equates.Prop;
import clarion.equates.Reject;
import clarion.equates.Warn;
import clarion.winla043.Winla043;
import clarion.winla_sf.Jumpwindow;
import clarion.winla_sf.PreviewWindow;
import clarion.winla_sf.Selectwindow;
import clarion.winla_sf.equates.Mconstants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionReal;
import org.jclarion.clarion.ClarionRoutineResult;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CConfig;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Winla_sf
{

	public static void checkopen(ClarionFile p0,ClarionNumber p1)
	{
		checkopen(p0,p1,(ClarionNumber)null);
	}
	public static void checkopen(ClarionFile p0)
	{
		checkopen(p0,(ClarionNumber)null);
	}
	public static void checkopen(ClarionFile file,ClarionNumber overridecreate,ClarionNumber overrideopenmode)
	{
		ClarionNumber openmode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber _i_number=Clarion.newNumber();
		ClarionNumber _n_number=Clarion.newNumber();
		if (overrideopenmode==null) {
			openmode.setValue(0x42);
		}
		else {
			openmode.setValue(overrideopenmode);
		}
		file.open(openmode.intValue());
		if (CError.errorCode()==Constants.ISLOCKEDERR) {
			file.send("Recover=10");
			file.open(openmode.intValue());
		}
		{
			int case_1=CError.errorCode();
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1==Constants.NOERROR) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Constants.ISOPENERR) {
				try {
					checkopen_procedurereturn(file,_i_number,_n_number);
				} catch (ClarionRoutineResult _crr) {
					return;
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1==Constants.NOFILEERR) {
				if (overridecreate==null) {
				}
				else if (overridecreate.equals(Constants.TRUE)) {
					try {
						checkopen_createfile(file,overrideopenmode,_i_number,_n_number);
					} catch (ClarionRoutineResult _crr) {
						return;
					}
				}
				else {
					if (Winla_sf.standardwarning(Clarion.newNumber(Warn.CREATEERROR),Clarion.newString(file.getName())).boolValue()) {
					}
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1==Constants.INVALIDFILEERR) {
				Winla043.kluda(Clarion.newNumber(0),Clarion.newString(ClarionString.staticConcat("Main�ta strukt�ra failam : ",file.getName())));
				if (Winla_sf.standardwarning(Clarion.newNumber(Warn.INVALIDFILE),Clarion.newString(file.getName())).boolValue()) {
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1==Constants.BADKEYERR) {
				if (Winla_sf.standardwarning(Clarion.newNumber(Warn.INVALIDKEY),Clarion.newString(file.getName())).boolValue()) {
					file.build();
				}
				if (CError.errorCode()!=0) {
					if (Winla_sf.standardwarning(Clarion.newNumber(Warn.REBUILDERROR),Clarion.newString(file.getName())).boolValue()) {
					}
				}
				else {
					if (overrideopenmode==null) {
						file.open(0x42);
					}
					else {
						file.open(overrideopenmode.intValue());
					}
				}
				case_1_break=true;
			}
		}
		if (CError.errorCode()!=0) {
			if (Winla_sf.standardwarning(Clarion.newNumber(Warn.DISKERROR),Clarion.newString(file.getName())).boolValue()) {
				CRun.halt(0,"Disk Error");
			}
		}
		try {
			checkopen_procedurereturn(file,_i_number,_n_number);
		} catch (ClarionRoutineResult _crr) {
			return;
		}
	}
	public static void checkopen_procedurereturn(ClarionFile file,ClarionNumber _i_number,ClarionNumber _n_number) throws ClarionRoutineResult
	{
		if (Clarion.newString(file.getName()).inString("SYSTEM",1,1)!=0) {
			Main.system.clear();
			Main.system.avota_nr.setValue(Main.job_nr);
			Main.system.get(Main.system.nr_key);
			if (CError.error().length()!=0) {
				if (CRun.inRange(Main.job_nr,Clarion.newNumber(1),Clarion.newNumber(15))) {
					Main.system.avots.setValue(ClarionString.staticConcat("BASE ",Main.loc_nr));
				}
				else if (CRun.inRange(Main.job_nr,Clarion.newNumber(16),Clarion.newNumber(40))) {
					Main.system.avots.setValue(ClarionString.staticConcat("Noliktava ",Main.loc_nr));
				}
				else if (CRun.inRange(Main.job_nr,Clarion.newNumber(41),Clarion.newNumber(65))) {
					Main.system.avots.setValue(ClarionString.staticConcat("FP ",Main.loc_nr));
					Main.system.paraksts_nr.setValue(1);
					Main.system.baits1.setValue(128+64);
				}
				else if (CRun.inRange(Main.job_nr,Clarion.newNumber(66),Clarion.newNumber(80))) {
					Main.system.avots.setValue(ClarionString.staticConcat("Alga ",Main.loc_nr));
				}
				else if (CRun.inRange(Main.job_nr,Clarion.newNumber(81),Clarion.newNumber(95))) {
					Main.system.avots.setValue(ClarionString.staticConcat("Pamatl�dzek�i ",Main.loc_nr));
				}
				else if (CRun.inRange(Main.job_nr,Clarion.newNumber(96),Clarion.newNumber(120))) {
					Main.system.avots.setValue(ClarionString.staticConcat("Laika masina",Main.loc_nr));
				}
				Main.system.avota_nr.setValue(Main.job_nr);
				Main.system.gil_show.setValue(CDate.date(1,1,Main.gads.intValue())-1);
				Main.system.nokl_pvn.setValue(21);
				Main.system.nokl_b.setValue(1);
				Main.system.nokl_cp.setValue(1);
				Main.system.nokl_ca.setValue(1);
				Main.system.nokl_pb.setValue(1);
				Main.system.k_pvn.setValue("57210");
				file.add();
			}
		}
		if (Clarion.newString(file.getName()).inString("GLOBAL",1,1)!=0) {
			if (file.records()==0) {
				Main.global.clear();
				Main.global.db_gads.setValue(CDate.year(CDate.today()));
				Main.global.db_s_dat.setValue(CDate.date(1,1,CDate.year(CDate.today())));
				Main.global.db_b_dat.setValue(CDate.date(12,31,CDate.year(CDate.today())));
				file.add();
			}
			file.set();
			file.next();
		}
		if (Clarion.newString(file.getName()).inString("VAL_K",1,1)!=0) {
			if (file.records()==0) {
				Main.val_k.clear();
				Main.val_k.val.setValue("EUR");
				Main.val_k.rubli.setValue("Euro");
				Main.val_k.kapiki.setValue("centi");
				Main.val_k.v_kods.setValue("LV");
				Main.val_k.valsts.setValue("Latvija");
				file.add();
				Main.val_k.clear();
				Main.val_k.val.setValue("Ls");
				Main.val_k.rubli.setValue("Lati");
				Main.val_k.kapiki.setValue("sant�mi");
				Main.val_k.v_kods.setValue("");
				Main.val_k.valsts.setValue("L�dz2014Latvija");
				file.add();
			}
		}
		if (Clarion.newString(file.getName()).inString("BANKAS_K",1,1)!=0) {
			if (file.records()==0) {
				Main.bankas_k.clear();
				Main.bankas_k.kods.setValue("HABALV22");
				Main.bankas_k.nos_a.setValue("Swed");
				Main.bankas_k.nos_p.setValue("\"Swedbank\" AS");
				Main.bankas_k.nos_s.setValue("\"Swedbank\" AS");
				file.add();
			}
		}
		if (Clarion.newString(file.getName()).inString("MER_K",1,1)!=0) {
			if (file.records()==0) {
				Main.mer_k.clear();
				Main.mer_k.mervien.setValue("gab.");
				file.add();
			}
		}
		if (Clarion.newString(file.getName()).inString("TEK_K",1,1)!=0) {
			if (file.records()==0) {
				Main.tek_k.clear();
				Main.tek_k.ini.setValue("Pelna un p");
				Main.tek_k.teksts.setValue("Pe��a un pe��as nodoklis");
				Main.tek_k.tips.setValue("A");
				Main.tek_k.att_dok.setValue("");
				Main.tek_k.d_k1.setValue("K");
				Main.tek_k.d_k2.setValue("K");
				Main.tek_k.d_k3.setValue("D");
				Main.tek_k.d_k4.setValue("D");
				Main.tek_k.bkk_1.setValue("34100");
				Main.tek_k.bkk_2.setValue("57100");
				Main.tek_k.bkk_3.setValue("86100");
				Main.tek_k.bkk_4.setValue("88100");
				Main.tek_k.k_1.setValue(85);
				Main.tek_k.k_2.setValue(15);
				Main.tek_k.k_3.setValue(85);
				Main.tek_k.k_4.setValue(15);
				file.add();
				Main.tek_k.clear();
				Main.tek_k.ini.setValue("RV:Program");
				Main.tek_k.teksts.setValue("RV:Programmat�ra WinLats");
				Main.tek_k.tips.setValue("A");
				Main.tek_k.att_dok.setValue("6");
				Main.tek_k.d_k1.setValue("K");
				Main.tek_k.d_k2.setValue("D");
				Main.tek_k.d_k3.setValue("D");
				Main.tek_k.bkk_1.setValue("53100");
				Main.tek_k.bkk_2.setValue("57210");
				Main.tek_k.bkk_3.setValue("11200");
				Main.tek_k.k_1.setValue(118);
				Main.tek_k.k_2.setValue(18);
				Main.tek_k.k_3.setValue(100);
				file.add();
			}
		}
		if (Clarion.newString(file.getName()).inString("ATL_K",1,1)!=0) {
			if (file.records()==0) {
				Main.atl_k.clear();
				Main.atl_k.u_nr.setValue(101);
				Main.atl_k.hidden.setValue(0);
				Main.atl_k.komentars.setValue("Atlai�u diena(atlaides visiem)");
				file.add();
			}
		}
		if (Clarion.newString(file.getName()).inString("PAROLES",1,1)!=0) {
			if (file.records()==0) {
				Main.paroles.u_nr.setValue(1);
				Main.paroles.secure.setValue("XXXXXXXX");
				Main.paroles.publish.setValue("SUPERACC");
				Main.paroles.super_acc.setValue("1");
				Main.paroles.start_nr.setValue(1);
				Main.paroles.files_acc.setValue("00000000");
				for (_i_number.setValue(1);_i_number.compareTo(25)<=0;_i_number.increment(1)) {
					if (_i_number.compareTo(15)<=0) {
						if (_i_number.compareTo(Main.base_sk)>0) {
							Main.paroles.base_acc.setStringAt(_i_number,"N");
						}
						else {
							Main.paroles.base_acc.setStringAt(_i_number,"0");
						}
						if (_i_number.compareTo(Main.algu_sk)>0) {
							Main.paroles.alga_acc.setStringAt(_i_number,"N");
						}
						else {
							Main.paroles.alga_acc.setStringAt(_i_number,"0");
						}
						if (_i_number.compareTo(Main.pam_sk)>0) {
							Main.paroles.pam_acc.setStringAt(_i_number,"N");
						}
						else {
							Main.paroles.pam_acc.setStringAt(_i_number,"0");
						}
					}
					if (_i_number.compareTo(Main.nol_sk)>0) {
						Main.paroles.nol_acc.setStringAt(_i_number,"N");
					}
					else {
						Main.paroles.nol_acc.setStringAt(_i_number,"0");
					}
					if (_i_number.compareTo(Main.fp_sk)>0) {
						Main.paroles.fp_acc.setStringAt(_i_number,"N");
					}
					else {
						Main.paroles.fp_acc.setStringAt(_i_number,"0");
					}
				}
				file.add();
			}
		}
		if (Clarion.newString(file.getName()).inString("GG",1,1)!=0 && !(Clarion.newString(file.getName()).inString("GGK",1,1)!=0)) {
			if (file.records()==0) {
				Main.gg.clear();
				Main.gg.u_nr.setValue(1);
				Main.gg.dokdat.setValue(Main.db_s_dat);
				Main.gg.datums.setValue(Main.db_s_dat);
				Main.gg.saturs.setValue(ClarionString.staticConcat("SALDO uz ",Main.gg.datums.getString().format("@d06.")));
				file.add();
			}
		}
		if (Clarion.newString(file.getName()).inString("DAIEV",1,1)!=0) {
			if (file.records()==0) {
				Main.daiev.f.setValue("SYS");
				Main.daiev.t.setValue("7");
				Main.daiev.socyn.setValue("Y");
				Main.daiev.ienyn.setValue("Y");
				Main.daiev.sliyn.setValue("Y");
				Main.daiev.atvyn.setValue("Y");
				Main.daiev.vidyn.setValue("Y");
				Main.daiev.kods.setValue(840);
				Main.daiev.nosaukums.setValue("Atva�in�jums teko�aj� m�nes�");
				file.add();
				Main.daiev.kods.setValue(841);
				Main.daiev.nosaukums.setValue("Atva�in�jums n�ko�aj� m�nes�");
				file.add();
				Main.daiev.kods.setValue(842);
				Main.daiev.nosaukums.setValue("Atva�in�jums aizn�ko�aj� m�nes�");
				file.add();
				Main.daiev.kods.setValue(850);
				Main.daiev.nosaukums.setValue("Slim�bas lapa �aj� m�nes�");
				Main.daiev.t.setValue("8");
				file.add();
				Main.daiev.kods.setValue(851);
				Main.daiev.nosaukums.setValue("Slim�bas lapa pag�ju�aj� m�nes�");
				file.add();
				Main.daiev.kods.setValue(852);
				Main.daiev.nosaukums.setValue("Slim�bas lapa n�ko�aj� m�nes�");
				file.add();
				Main.daiev.kods.setValue(901);
				Main.daiev.nosaukums.setValue("Ien�kuma nodok�a pamatlikme");
				Main.daiev.t.setValue("4");
				file.add();
				Main.daiev.kods.setValue(902);
				Main.daiev.nosaukums.setValue("Ien�kuma nodok�a papildlikme");
				file.add();
				Main.daiev.kods.setValue(903);
				Main.daiev.nosaukums.setValue("Darba ��m�ja soci�lais nodoklis");
				Main.daiev.t.setValue("5");
				file.add();
				Main.daiev.kods.setValue(904);
				Main.daiev.nosaukums.setValue("Avanss");
				Main.daiev.f.setValue("NAV");
				Main.daiev.t.setValue("1");
				file.add();
				Main.daiev.kods.setValue(905);
				Main.daiev.nosaukums.setValue("P�rmaksa/par�ds");
				Main.daiev.f.setValue("SYS");
				Main.daiev.t.setValue("1");
				file.add();
				Main.daiev.kods.setValue(906);
				Main.daiev.nosaukums.setValue("Ien�kuma nod. par pag�ju�o m�nesi");
				Main.daiev.t.setValue("4");
				file.add();
				Main.daiev.kods.setValue(907);
				Main.daiev.nosaukums.setValue("Ien�kuma nod. par aizpag�ju�o m�nesi");
				file.add();
				Main.daiev.kods.setValue(908);
				Main.daiev.nosaukums.setValue("Ien�kuma nod. par n�ko�o m�nesi");
				file.add();
				Main.daiev.kods.setValue(909);
				Main.daiev.nosaukums.setValue("Ien�kuma nod. par aizn�ko�o m�nesi");
				file.add();
				Main.daiev.kods.setValue(910);
				Main.daiev.nosaukums.setValue("Darba ��m�ja soc. n. par n�ko�o m�nesi");
				Main.daiev.t.setValue("5");
				file.add();
				Main.daiev.kods.setValue(911);
				Main.daiev.nosaukums.setValue("Darba ��m. soc. n. par aizn�ko�o m�n.");
				file.add();
			}
		}
		if (Clarion.newString(file.getName()).inString("PAR_K",1,1)!=0) {
			if (file.records()==0) {
				Main.par_k.clear();
				Main.par_k.u_nr.setValue(0);
				Main.par_k.tips.setValue("E");
				Main.par_k.nos_s.setValue("Citi");
				Main.par_k.nos_p.setValue("Citi Partneri");
				Main.par_k.nos_a.setValue("Citi");
				Main.par_k.nmr_kods.setValue(0);
				file.add();
				for (_n_number.setValue(1);_n_number.compareTo(28)<=0;_n_number.increment(1)) {
					Main.par_k.clear();
					Main.par_k.u_nr.setValue(_n_number);
					if (CRun.inRange(_n_number,Clarion.newNumber(1),Clarion.newNumber(5))) {
						Main.par_k.tips.setValue("I");
						Main.par_k.nos_s.setValue(ClarionString.staticConcat("Noliktava N ",_n_number.getString().format("@N2")));
						Main.par_k.nos_p.setValue(ClarionString.staticConcat("Noliktava N ",_n_number.getString().format("@N2")));
						Main.par_k.nos_a.setValue("NOLIK");
						file.add();
					}
					else if (CRun.inRange(_n_number,Clarion.newNumber(26),Clarion.newNumber(28))) {
						Main.par_k.tips.setValue("R");
						Main.par_k.nos_s.setValue(ClarionString.staticConcat("Ra�o�ana ",_n_number.getString().format("@N2")));
						Main.par_k.nos_p.setValue(ClarionString.staticConcat("Ra�o�ana ",_n_number.getString().format("@N2")));
						Main.par_k.nos_a.setValue("RAZOS");
						file.add();
					}
				}
				Main.par_k.clear();
				Main.par_k.u_nr.setValue(51);
				Main.par_k.tips.setValue("E");
				Main.par_k.nos_s.setValue("ASSAKO SMART");
				Main.par_k.nos_p.setValue("SIA \"ASSAKO SMART\"");
				Main.par_k.nos_a.setValue("ASSAKO SMART");
				Main.par_k.nmr_kods.setValue("40103555548");
				Main.par_k.pvn.setValue("");
				Main.par_k.ban_nr.setValue("LV32HABA0551033651166");
				Main.par_k.ban_kods.setValue("HABALV22");
				Main.par_k.adrese.setValue("Vaidavas 3a - 17, R�ga, LV-1084");
				Main.par_k.kontakts.setValue("Vita Viese");
				Main.par_k.tel.setValue("26546445,29258808");
				Main.par_k.email.setValue("info@assakosmart.lv");
				file.add();
			}
		}
		if (Clarion.newString(file.getName()).inString("ADR_K",1,1)!=0) {
			if (file.records()==0) {
				Main.par_a.clear();
				Main.par_a.par_nr.setValue(51);
				Main.par_a.adr_nr.setValue(1);
				Main.par_a.tips.setValue("P");
				Main.par_a.adrese.setValue("Vaidavas 3a - 17, R�ga, LV-1084");
				file.add();
			}
		}
		throw new ClarionRoutineResult();
	}
	public static void checkopen_createfile(ClarionFile file,ClarionNumber overrideopenmode,ClarionNumber _i_number,ClarionNumber _n_number) throws ClarionRoutineResult
	{
		file.create();
		if (CError.errorCode()!=0) {
			if (CError.errorCode()==90) {
				if (Winla_sf.standardwarning(Clarion.newNumber(Warn.CREATEERROR),Clarion.newString(file.getName())).boolValue()) {
				}
			}
			else {
				if (Winla_sf.standardwarning(Clarion.newNumber(Warn.CREATEERROR),Clarion.newString(file.getName())).boolValue()) {
				}
			}
		}
		if (overrideopenmode==null) {
			file.open(0x42);
		}
		else {
			file.open(overrideopenmode.intValue());
		}
		if (!(CError.errorCode()!=0)) {
			checkopen_procedurereturn(file,_i_number,_n_number);
		}
		else {
			if (Winla_sf.standardwarning(Clarion.newNumber(Warn.CREATEOPENERROR),Clarion.newString(file.getName())).boolValue()) {
			}
		}
	}
	public static void reportpreview(ClarionQueue printpreviewqueue)
	{
		ClarionNumber currentpage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber pagesacross=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber pagesdown=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber displayedpagesacross=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber displayedpagesdown=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber zoomnozoom=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber zoompagewidth=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber zoom50=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber zoom75=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber zoom100=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber zoom200=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber zoom300=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionReal zoommodifier=Clarion.newReal();
		ClarionNumber popupselection=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString popuptext=Clarion.newString(50);
		ClarionNumber thumbnailspresent=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber zoompresent=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber imagecount=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber imagewidth=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber imageheight=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionReal imageaspectratio=Clarion.newReal();
		ClarionNumber thumbnailsrequired=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber currentthumbnail=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber thumbnailxposition=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber thumbnailyposition=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber thumbnailheight=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber thumbnailwidth=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionReal thumbnailaspectratio=Clarion.newReal();
		ClarionNumber thumbnailrow=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber thumbnailcolumn=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber processedpage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionReal pagezoom=Clarion.newReal();
		ClarionNumber currentimagebox=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber currentborderbox=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber totalxseparation=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber totalyseparation=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString previewwindowx=Clarion.newString(20);
		ClarionString previewwindowy=Clarion.newString(20);
		ClarionString previewwindowwidth=Clarion.newString(20);
		ClarionString previewwindowheight=Clarion.newString(20);
		ClarionNumber zoomed=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString zoomratio=Clarion.newString(20);
		ClarionNumber clickedcontrol=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		PreviewWindow previewWindow=new PreviewWindow(zoomnozoom,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300,currentpage,pagesacross,pagesdown);
		try {
			returnvalue.setValue(Constants.FALSE);
			previewWindow.open();
			CWin.getTarget().setProperty(Prop.MINWIDTH,315);
			printpreviewqueue.get(1);
			CWin.createControl(Mconstants.TEMPORARYIMAGE,Create.IMAGE,null,null);
			Clarion.getControl(Mconstants.TEMPORARYIMAGE).setProperty(Prop.TEXT,printpreviewqueue.getString());
			imagewidth.setValue(Clarion.getControl(Mconstants.TEMPORARYIMAGE).getProperty(Prop.MAXWIDTH));
			imageheight.setValue(Clarion.getControl(Mconstants.TEMPORARYIMAGE).getProperty(Prop.MAXHEIGHT));
			imageaspectratio.setValue(imageheight.divide(imagewidth));
			CWin.removeControl(Mconstants.TEMPORARYIMAGE);
			imagecount.setValue(printpreviewqueue.records());
			currentpage.setValue(1);
			pagesacross.setValue(1);
			pagesdown.setValue(1);
			pagesdown.setValue(1);
			displayedpagesacross.setValue(0);
			displayedpagesdown.setValue(0);
			thumbnailspresent.setValue(0);
			zoompresent.setValue(Constants.FALSE);
			if (imagecount.equals(1)) {
				CWin.disable(previewWindow._currentpage,previewWindow._pagesdown);
				CWin.disable(previewWindow._viewmenu);
			}
			else {
				Clarion.getControl(previewWindow._currentpage).setClonedProperty(Prop.RANGEHIGH,imagecount);
				Clarion.getControl(previewWindow._currentpage).setProperty(Prop.MSG,ClarionString.staticConcat("Enter a page number from 1 to ",imagecount));
			}
			zoomnozoom.setValue(Constants.TRUE);
			reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_1=CWin.event();
					boolean case_1_break=false;
					if (case_1==Event.SIZED) {
						reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.NEWSELECTION) {
						{
							int case_2=CWin.field();
							boolean case_2_break=false;
							boolean case_2_match=false;
							case_2_match=false;
							if (case_2==previewWindow._pagesacross) {
								case_2_match=true;
							}
							if (case_2_match || case_2==previewWindow._pagesdown) {
								reportpreview_clearzoomvalues(zoomnozoom,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
								zoomnozoom.setValue(Constants.TRUE);
								reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
								case_2_break=true;
							}
							case_2_match=false;
							if (!case_2_break && case_2==previewWindow._currentpage) {
								reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
								case_2_break=true;
							}
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.REJECTED) {
						{
							int case_3=1;
							boolean case_3_break=false;
							if (case_3==Reject.RANGEHIGH) {
								CWin.change(CWin.field(),Clarion.getControl(CWin.field()).getProperty(Prop.RANGEHIGH));
								case_3_break=true;
							}
							if (!case_3_break && case_3==Reject.RANGELOW) {
								CWin.change(CWin.field(),Clarion.getControl(CWin.field()).getProperty(Prop.RANGELOW));
								case_3_break=true;
							}
						}
						reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.ALERTKEY) {
						{
							int case_4=CWin.keyCode();
							boolean case_4_break=false;
							if (case_4==Constants.PGUPKEY) {
								CWin.post(Event.ACCEPTED,previewWindow._previous);
								case_4_break=true;
							}
							if (!case_4_break && case_4==Constants.PGDNKEY) {
								CWin.post(Event.ACCEPTED,previewWindow._next);
								case_4_break=true;
							}
							if (!case_4_break) {
								{
									int case_5=CWin.field();
									boolean case_5_break=false;
									if (case_5==Mconstants.ZOOMIMAGE) {
										reportpreview_clearzoomvalues(zoomnozoom,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
										zoomnozoom.setValue(Constants.TRUE);
										reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
										case_5_break=true;
									}
									if (!case_5_break) {
										currentpage.setValue(Clarion.newNumber(CWin.field()-Mconstants.LOWESTIMAGEEQUATE).add(currentpage));
										zoomnozoom.setValue(Constants.FALSE);
										zoompagewidth.setValue(Constants.TRUE);
										reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
									}
								}
							}
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.ACCEPTED) {
						{
							int case_6=CWin.field();
							boolean case_6_break=false;
							boolean case_6_match=false;
							case_6_match=false;
							if (case_6==previewWindow._print) {
								case_6_match=true;
							}
							if (case_6_match || case_6==previewWindow._printbutton) {
								CWin.post(Event.CLOSEWINDOW);
								returnvalue.setValue(Constants.TRUE);
								case_6_break=true;
							}
							case_6_match=false;
							if (!case_6_break && case_6==previewWindow._exit) {
								case_6_match=true;
							}
							if (case_6_match || case_6==previewWindow._exitbutton) {
								CWin.post(Event.CLOSEWINDOW);
								case_6_break=true;
							}
							case_6_match=false;
							if (!case_6_break && case_6==previewWindow._zoombutton) {
								popuptext.setValue("-No Zoom|-|-Page Width|-50%|-75%|-100%|-200%|-300%");
								if (zoomnozoom.boolValue()) {
									popuptext.setStringAt(1,"+");
								}
								else if (zoompagewidth.boolValue()) {
									popuptext.setStringAt(12,"+");
								}
								else if (zoom50.boolValue()) {
									popuptext.setStringAt(24,"+");
								}
								else if (zoom75.boolValue()) {
									popuptext.setStringAt(29,"+");
								}
								else if (zoom100.boolValue()) {
									popuptext.setStringAt(34,"+");
								}
								else if (zoom200.boolValue()) {
									popuptext.setStringAt(40,"+");
								}
								else if (zoom300.boolValue()) {
									popuptext.setStringAt(46,"+");
								}
								popupselection.setValue(CWin.popup(popuptext.toString()));
								if (popupselection.boolValue()) {
									reportpreview_clearzoomvalues(zoomnozoom,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
									{
										int execute_1=popupselection.intValue();
										if (execute_1==1) {
											zoomnozoom.setValue(Constants.TRUE);
										}
										if (execute_1==2) {
											zoompagewidth.setValue(Constants.TRUE);
										}
										if (execute_1==3) {
											zoom50.setValue(Constants.TRUE);
										}
										if (execute_1==4) {
											zoom75.setValue(Constants.TRUE);
										}
										if (execute_1==5) {
											zoom100.setValue(Constants.TRUE);
										}
										if (execute_1==6) {
											zoom200.setValue(Constants.TRUE);
										}
										if (execute_1==7) {
											zoom300.setValue(Constants.TRUE);
										}
									}
									reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
								}
								case_6_break=true;
							}
							case_6_match=false;
							if (!case_6_break && case_6==previewWindow._currentpage) {
								reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
								case_6_break=true;
							}
							case_6_match=false;
							if (!case_6_break && case_6==previewWindow._next) {
								reportpreview_getnextpage(zoomnozoom,currentpage,thumbnailspresent,imagecount);
								reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
								case_6_break=true;
							}
							case_6_match=false;
							if (!case_6_break && case_6==previewWindow._previous) {
								reportpreview_getprevpage(zoomnozoom,currentpage,thumbnailspresent);
								reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
								case_6_break=true;
							}
							case_6_match=false;
							if (!case_6_break && case_6==previewWindow._jump) {
								currentpage.setValue(Winla_sf.previewJumptopage(currentpage.like(),imagecount.like()));
								reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
								case_6_break=true;
							}
							case_6_match=false;
							if (!case_6_break && case_6==previewWindow._changedisplay) {
								Winla_sf.previewSelectdisplay(pagesacross,pagesdown);
								reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
								case_6_break=true;
							}
							case_6_match=false;
							if (!case_6_break && case_6>=previewWindow._zoomnozoom && case_6<=previewWindow._zoom300) {
								reportpreview_clearzoomvalues(zoomnozoom,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
								{
									int execute_2=(CWin.field()-previewWindow._zoomnozoom)+1;
									if (execute_2==1) {
										zoomnozoom.setValue(Constants.TRUE);
									}
									if (execute_2==2) {
										zoompagewidth.setValue(Constants.TRUE);
									}
									if (execute_2==3) {
										zoom50.setValue(Constants.TRUE);
									}
									if (execute_2==4) {
										zoom75.setValue(Constants.TRUE);
									}
									if (execute_2==5) {
										zoom100.setValue(Constants.TRUE);
									}
									if (execute_2==6) {
										zoom200.setValue(Constants.TRUE);
									}
									if (execute_2==7) {
										zoom300.setValue(Constants.TRUE);
									}
								}
								reportpreview_changedisplay(zoomnozoom,zoompresent,pagesdown,displayedpagesdown,pagesacross,displayedpagesacross,thumbnailspresent,previewWindow,printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,currentthumbnail,totalxseparation,totalyseparation,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn,processedpage,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
								case_6_break=true;
							}
						}
						case_1_break=true;
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			if (returnvalue.boolValue()) {
				Main.globalresponse.setValue(Constants.REQUESTCOMPLETED);
			}
			else {
				Main.globalresponse.setValue(Constants.REQUESTCANCELLED);
			}
			return;
		} finally {
			previewWindow.close();
		}
	}
	public static void reportpreview_createzoomcontrol(ClarionNumber zoompresent)
	{
		CWin.createControl(Mconstants.ZOOMIMAGE,Create.IMAGE,null,null);
		CWin.setPosition(Mconstants.ZOOMIMAGE,0,0,null,null);
		Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.VSCROLL,Constants.TRUE);
		Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.HSCROLL,Constants.TRUE);
		Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.FULL,Constants.TRUE);
		Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.FILLCOLOR,0xffffff);
		Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.ALRT,Constants.MOUSELEFT);
		Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.CURSOR,Cursor.ZOOM);
		CWin.unhide(Mconstants.ZOOMIMAGE);
		zoompresent.setValue(Constants.TRUE);
	}
	public static void reportpreview_fillzoomcontrol(ClarionQueue printpreviewqueue,ClarionNumber currentpage,ClarionNumber imagecount,ClarionNumber imagewidth,ClarionReal zoommodifier,ClarionNumber imageheight,ClarionNumber zoompagewidth,ClarionNumber zoom50,ClarionNumber zoom75,ClarionNumber zoom100,ClarionNumber zoom200,ClarionNumber zoom300)
	{
		reportpreview_configurezoomratio(zoompagewidth,zoommodifier,imagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
		printpreviewqueue.get(currentpage);
		Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.TEXT,printpreviewqueue.getString());
		CWin.getTarget().setProperty(Prop.STATUSTEXT,2,ClarionString.staticConcat("Page ",currentpage," of ",imagecount));
		Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.MAXWIDTH,imagewidth.multiply(zoommodifier));
		Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.MAXHEIGHT,imageheight.multiply(zoommodifier));
	}
	public static void reportpreview_changedisplay(ClarionNumber zoomnozoom,ClarionNumber zoompresent,ClarionNumber pagesdown,ClarionNumber displayedpagesdown,ClarionNumber pagesacross,ClarionNumber displayedpagesacross,ClarionNumber thumbnailspresent,PreviewWindow previewWindow,ClarionQueue printpreviewqueue,ClarionNumber currentpage,ClarionNumber imagecount,ClarionNumber imagewidth,ClarionReal zoommodifier,ClarionNumber imageheight,ClarionString zoomratio,ClarionNumber currentborderbox,ClarionNumber currentimagebox,ClarionNumber thumbnailsrequired,ClarionNumber currentthumbnail,ClarionNumber totalxseparation,ClarionNumber totalyseparation,ClarionNumber thumbnailwidth,ClarionNumber thumbnailheight,ClarionReal thumbnailaspectratio,ClarionReal imageaspectratio,ClarionNumber thumbnailyposition,ClarionNumber thumbnailrow,ClarionNumber thumbnailxposition,ClarionNumber thumbnailcolumn,ClarionNumber processedpage,ClarionNumber zoompagewidth,ClarionNumber zoom50,ClarionNumber zoom75,ClarionNumber zoom100,ClarionNumber zoom200,ClarionNumber zoom300)
	{
		if (zoomnozoom.boolValue()) {
			if (zoompresent.boolValue()) {
				reportpreview_destroyzoomcontrol(zoompresent);
			}
			if (!pagesdown.equals(displayedpagesdown) || !pagesacross.equals(displayedpagesacross)) {
				if (thumbnailspresent.boolValue()) {
					reportpreview_destroythumbnails(thumbnailspresent);
				}
				reportpreview_createthumbnails(zoomratio,currentborderbox,currentimagebox,thumbnailsrequired,pagesacross,pagesdown,currentthumbnail,thumbnailspresent);
				displayedpagesdown.setValue(pagesdown);
				displayedpagesacross.setValue(pagesacross);
			}
			reportpreview_positionthumbnails(totalxseparation,pagesacross,totalyseparation,pagesdown,thumbnailwidth,thumbnailheight,thumbnailaspectratio,imageaspectratio,currentborderbox,currentimagebox,thumbnailyposition,thumbnailrow,thumbnailxposition,thumbnailcolumn);
			reportpreview_fillthumbnails(currentborderbox,currentimagebox,currentthumbnail,thumbnailspresent,processedpage,currentpage,imagecount,printpreviewqueue,previewWindow);
			CWin.getTarget().setProperty(Prop.STATUSTEXT,3,"No Zoom");
		}
		else {
			if (thumbnailspresent.boolValue()) {
				reportpreview_destroythumbnails(thumbnailspresent);
			}
			if (!zoompresent.boolValue()) {
				reportpreview_createzoomcontrol(zoompresent);
			}
			reportpreview_fillzoomcontrol(printpreviewqueue,currentpage,imagecount,imagewidth,zoommodifier,imageheight,zoompagewidth,zoom50,zoom75,zoom100,zoom200,zoom300);
			displayedpagesacross.setValue(0);
			displayedpagesdown.setValue(0);
		}
		CWin.display(previewWindow._zoomnozoom,previewWindow._zoom300);
		CWin.display(previewWindow._currentpage,previewWindow._pagesdown);
	}
	public static void reportpreview_positionthumbnails(ClarionNumber totalxseparation,ClarionNumber pagesacross,ClarionNumber totalyseparation,ClarionNumber pagesdown,ClarionNumber thumbnailwidth,ClarionNumber thumbnailheight,ClarionReal thumbnailaspectratio,ClarionReal imageaspectratio,ClarionNumber currentborderbox,ClarionNumber currentimagebox,ClarionNumber thumbnailyposition,ClarionNumber thumbnailrow,ClarionNumber thumbnailxposition,ClarionNumber thumbnailcolumn)
	{
		totalxseparation.setValue(Clarion.newNumber(2).add(pagesacross.subtract(1).multiply(Mconstants.MINIMUMXSEPARATION)));
		totalyseparation.setValue(Clarion.newNumber(2).add(pagesdown.subtract(1).multiply(Mconstants.MINIMUMYSEPARATION)));
		thumbnailwidth.setValue(CWin.getTarget().getProperty(Prop.WIDTH).subtract(totalxseparation).divide(pagesacross));
		thumbnailheight.setValue(CWin.getTarget().getProperty(Prop.HEIGHT).subtract(18).subtract(totalyseparation).divide(pagesdown));
		thumbnailaspectratio.setValue(thumbnailheight.divide(thumbnailwidth));
		if (thumbnailaspectratio.compareTo(imageaspectratio)<0) {
			thumbnailwidth.setValue(thumbnailheight.divide(imageaspectratio));
		}
		else {
			thumbnailheight.setValue(thumbnailwidth.multiply(imageaspectratio));
		}
		currentborderbox.setValue(Mconstants.LOWESTBORDEREQUATE);
		currentimagebox.setValue(Mconstants.LOWESTIMAGEEQUATE);
		thumbnailyposition.setValue(1);
		final ClarionNumber loop_2=pagesdown.like();for (thumbnailrow.setValue(1);thumbnailrow.compareTo(loop_2)<=0;thumbnailrow.increment(1)) {
			thumbnailxposition.setValue(1);
			final ClarionNumber loop_1=pagesacross.like();for (thumbnailcolumn.setValue(1);thumbnailcolumn.compareTo(loop_1)<=0;thumbnailcolumn.increment(1)) {
				CWin.setPosition(currentborderbox.intValue(),thumbnailxposition.intValue(),thumbnailyposition.intValue(),thumbnailwidth.intValue(),thumbnailheight.intValue());
				CWin.setPosition(currentimagebox.intValue(),thumbnailxposition.intValue(),thumbnailyposition.intValue(),thumbnailwidth.intValue(),thumbnailheight.intValue());
				Clarion.getControl(currentborderbox).setProperty(Prop.COLOR,0);
				Clarion.getControl(currentborderbox).setProperty(Prop.FILL,0xffffff);
				Clarion.getControl(currentimagebox).setProperty(Prop.CURSOR,Cursor.ZOOM);
				Clarion.getControl(currentimagebox).setProperty(Prop.ALRT,Constants.MOUSELEFT);
				thumbnailxposition.increment(Clarion.newNumber(Mconstants.MINIMUMXSEPARATION).add(thumbnailwidth));
				currentborderbox.increment(1);
				currentimagebox.increment(1);
			}
			thumbnailyposition.increment(Clarion.newNumber(Mconstants.MINIMUMYSEPARATION).add(thumbnailheight));
		}
	}
	public static void reportpreview_configurezoomratio(ClarionNumber zoompagewidth,ClarionReal zoommodifier,ClarionNumber imagewidth,ClarionNumber zoom50,ClarionNumber zoom75,ClarionNumber zoom100,ClarionNumber zoom200,ClarionNumber zoom300)
	{
		if (zoompagewidth.boolValue()) {
			zoommodifier.setValue(CWin.getTarget().getProperty(Prop.WIDTH).divide(imagewidth));
			Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.HSCROLL,Constants.FALSE);
			CWin.getTarget().setProperty(Prop.STATUSTEXT,3,"Zoom (Page Width)");
		}
		else if (zoom50.boolValue()) {
			zoommodifier.setValue("0.5");
			Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.HSCROLL,Constants.TRUE);
			CWin.getTarget().setProperty(Prop.STATUSTEXT,3,"Zoom (50%)");
		}
		else if (zoom75.boolValue()) {
			zoommodifier.setValue("0.75");
			Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.HSCROLL,Constants.TRUE);
			CWin.getTarget().setProperty(Prop.STATUSTEXT,3,"Zoom (75%)");
		}
		else if (zoom100.boolValue()) {
			zoommodifier.setValue(1);
			Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.HSCROLL,Constants.TRUE);
			CWin.getTarget().setProperty(Prop.STATUSTEXT,3,"Zoom (100%)");
		}
		else if (zoom200.boolValue()) {
			zoommodifier.setValue(2);
			Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.HSCROLL,Constants.TRUE);
			CWin.getTarget().setProperty(Prop.STATUSTEXT,3,"Zoom (200%)");
		}
		else if (zoom300.boolValue()) {
			zoommodifier.setValue(3);
			Clarion.getControl(Mconstants.ZOOMIMAGE).setProperty(Prop.HSCROLL,Constants.TRUE);
			CWin.getTarget().setProperty(Prop.STATUSTEXT,3,"Zoom (300%)");
		}
	}
	public static void reportpreview_destroyzoomcontrol(ClarionNumber zoompresent)
	{
		CWin.hide(Mconstants.ZOOMIMAGE);
		CWin.removeControl(Mconstants.ZOOMIMAGE);
		zoompresent.setValue(Constants.FALSE);
	}
	public static void reportpreview_destroythumbnails(ClarionNumber thumbnailspresent)
	{
		CWin.removeControl(Mconstants.LOWESTBORDEREQUATE,Mconstants.HIGHESTCONTROLEQUATE);
		thumbnailspresent.setValue(0);
	}
	public static void reportpreview_createthumbnails(ClarionString zoomratio,ClarionNumber currentborderbox,ClarionNumber currentimagebox,ClarionNumber thumbnailsrequired,ClarionNumber pagesacross,ClarionNumber pagesdown,ClarionNumber currentthumbnail,ClarionNumber thumbnailspresent)
	{
		zoomratio.setValue("No Zoom");
		currentborderbox.setValue(Mconstants.LOWESTBORDEREQUATE);
		currentimagebox.setValue(Mconstants.LOWESTIMAGEEQUATE);
		thumbnailsrequired.setValue(pagesacross.multiply(pagesdown));
		final ClarionNumber loop_1=thumbnailsrequired.like();for (currentthumbnail.setValue(1);currentthumbnail.compareTo(loop_1)<=0;currentthumbnail.increment(1)) {
			CWin.createControl(currentborderbox.intValue(),Create.BOX,null,null);
			CWin.createControl(currentimagebox.intValue(),Create.IMAGE,null,null);
			currentborderbox.increment(1);
			currentimagebox.increment(1);
		}
		thumbnailspresent.setValue(thumbnailsrequired);
	}
	public static void reportpreview_getnextpage(ClarionNumber zoomnozoom,ClarionNumber currentpage,ClarionNumber thumbnailspresent,ClarionNumber imagecount)
	{
		if (zoomnozoom.boolValue()) {
			if (currentpage.add(thumbnailspresent).compareTo(imagecount)<=0) {
				currentpage.increment(thumbnailspresent);
			}
		}
		else {
			if (!currentpage.equals(imagecount)) {
				currentpage.increment(1);
			}
		}
	}
	public static void reportpreview_clearzoomvalues(ClarionNumber zoomnozoom,ClarionNumber zoompagewidth,ClarionNumber zoom50,ClarionNumber zoom75,ClarionNumber zoom100,ClarionNumber zoom200,ClarionNumber zoom300)
	{
		zoomnozoom.setValue(Constants.FALSE);
		zoompagewidth.setValue(Constants.FALSE);
		zoom50.setValue(Constants.FALSE);
		zoom75.setValue(Constants.FALSE);
		zoom100.setValue(Constants.FALSE);
		zoom200.setValue(Constants.FALSE);
		zoom300.setValue(Constants.FALSE);
	}
	public static void reportpreview_getprevpage(ClarionNumber zoomnozoom,ClarionNumber currentpage,ClarionNumber thumbnailspresent)
	{
		if (zoomnozoom.boolValue()) {
			currentpage.decrement(thumbnailspresent);
			if (currentpage.compareTo(1)<0) {
				currentpage.setValue(1);
			}
		}
		else {
			if (!currentpage.equals(1)) {
				currentpage.decrement(1);
			}
		}
	}
	public static void reportpreview_fillthumbnails(ClarionNumber currentborderbox,ClarionNumber currentimagebox,ClarionNumber currentthumbnail,ClarionNumber thumbnailspresent,ClarionNumber processedpage,ClarionNumber currentpage,ClarionNumber imagecount,ClarionQueue printpreviewqueue,PreviewWindow previewWindow)
	{
		currentborderbox.setValue(Mconstants.LOWESTBORDEREQUATE);
		currentimagebox.setValue(Mconstants.LOWESTIMAGEEQUATE);
		final ClarionNumber loop_1=thumbnailspresent.like();for (currentthumbnail.setValue(1);currentthumbnail.compareTo(loop_1)<=0;currentthumbnail.increment(1)) {
			processedpage.setValue(currentpage.add(currentthumbnail).subtract(1));
			if (processedpage.compareTo(imagecount)>0) {
				if (Clarion.getControl(currentimagebox).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
					CWin.hide(currentborderbox.intValue());
					CWin.hide(currentimagebox.intValue());
				}
			}
			else {
				printpreviewqueue.get(processedpage);
				Clarion.getControl(currentimagebox).setProperty(Prop.TEXT,printpreviewqueue.getString());
				if (Clarion.getControl(currentimagebox).getProperty(Prop.HIDE).equals(Constants.TRUE)) {
					CWin.unhide(currentborderbox.intValue());
					CWin.unhide(currentimagebox.intValue());
				}
			}
			currentborderbox.increment(1);
			currentimagebox.increment(1);
		}
		if (imagecount.compareTo(1)>0) {
			if (currentpage.equals(1)) {
				CWin.disable(previewWindow._previous);
			}
			else {
				CWin.enable(previewWindow._previous);
			}
			if (currentpage.add(thumbnailspresent).compareTo(imagecount)>0) {
				CWin.disable(previewWindow._next);
			}
			else {
				CWin.enable(previewWindow._next);
			}
		}
		if (thumbnailspresent.compareTo(1)>0) {
			processedpage.setValue(currentpage.add(thumbnailspresent).subtract(1));
			if (processedpage.compareTo(imagecount)>0) {
				processedpage.setValue(imagecount);
			}
			if (currentpage.equals(imagecount)) {
				CWin.getTarget().setProperty(Prop.STATUSTEXT,2,ClarionString.staticConcat("Page ",currentpage," of ",imagecount));
			}
			else {
				CWin.getTarget().setProperty(Prop.STATUSTEXT,2,ClarionString.staticConcat("Pages ",currentpage,"-",processedpage," of ",imagecount));
			}
		}
		else {
			CWin.getTarget().setProperty(Prop.STATUSTEXT,2,ClarionString.staticConcat("Page ",currentpage," of ",imagecount));
		}
	}
	public static ClarionNumber previewJumptopage(ClarionNumber inputCurrentpage,ClarionNumber inputTotalpages)
	{
		ClarionNumber jumppage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber returnpage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Jumpwindow jumpwindow=new Jumpwindow(jumppage);
		try {
			jumppage.setValue(inputCurrentpage);
			returnpage.setValue(inputCurrentpage);
			jumpwindow.open();
			Clarion.getControl(jumpwindow._jumppage).setProperty(Prop.RANGELOW,1);
			Clarion.getControl(jumpwindow._jumppage).setClonedProperty(Prop.RANGEHIGH,inputTotalpages);
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_1=CWin.accepted();
					boolean case_1_break=false;
					if (case_1==jumpwindow._okbutton) {
						returnpage.setValue(jumppage);
						break;
						// UNREACHABLE! :case_1_break=true;
					}
					if (!case_1_break && case_1==jumpwindow._cancelbutton) {
						break;
						// UNREACHABLE! :case_1_break=true;
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			jumpwindow.close();
			return returnpage.like();
		} finally {
			jumpwindow.close();
		}
	}
	public static void previewSelectdisplay(ClarionNumber inputPagesacross,ClarionNumber inputPagesdown)
	{
		Selectwindow selectwindow=new Selectwindow(inputPagesacross,inputPagesdown);
		try {
			selectwindow.open();
			while (Clarion.getWindowTarget().accept()) {
				Clarion.getWindowTarget().consumeAccept();
			}
			return;
		} finally {
			selectwindow.close();
		}
	}
	public static ClarionNumber standardwarning(ClarionNumber warningid)
	{
		return Winla_sf.standardwarning(warningid.like(),Clarion.newString(""),Clarion.newString(""));
	}
	public static ClarionNumber standardwarning(ClarionNumber warningid,ClarionString warningtext1)
	{
		return Winla_sf.standardwarning(warningid.like(),warningtext1.like(),Clarion.newString(""));
	}
	public static ClarionNumber standardwarning(ClarionNumber warningid,ClarionString warningtext1,ClarionString warningtext2)
	{
		ClarionString errortext=Clarion.newString(150);
		ClarionNumber currenterrorcode=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (Main.saveerrorcode.boolValue()) {
			currenterrorcode.setValue(Main.saveerrorcode);
			if (!Main.saveerrorcode.equals(90)) {
				errortext.setValue(Main.saveerror.clip().concat(" (",Main.saveerrorcode,")"));
			}
			else {
				errortext.setValue(Main.savefileerror.clip().concat(" (",Main.savefileerrorcode,")"));
			}
		}
		else {
			currenterrorcode.setValue(CError.errorCode());
			if (CError.errorCode()!=90) {
				errortext.setValue(Clarion.newString(CError.error()).clip().concat(" (",CError.errorCode(),")"));
			}
			else {
				errortext.setValue(Clarion.newString(CError.fileError()).clip().concat(" (",Clarion.newString(CError.fileErrorCode()).clip(),")"));
			}
		}
		Main.saveerrorcode.setValue(0);
		Main.saveerror.setValue("");
		Main.savefileerrorcode.setValue(0);
		Main.savefileerror.setValue("");
		{
			ClarionNumber case_1=warningid;
			boolean case_1_break=false;
			if (case_1.equals(Warn.INVALIDFILE)) {
				CWin.message(Clarion.newString(ClarionString.staticConcat("Error: (",errortext.clip(),") accessing ",warningtext1.clip(),".  Press OK to end this application.")),Clarion.newString("Invalid File"),Icon.EXCLAMATION,Button.OK,Button.OK,0);
				CRun.halt(0,"Invalid File!");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.INVALIDKEY)) {
				if (CWin.message(Clarion.newString(warningtext1.clip().concat(" key file is invalid.  Do you ","want to rebuild the key?")),Clarion.newString("Invalid Key"),Icon.QUESTION,Button.YES+Button.NO,Button.YES,0)==Button.NO) {
					CRun.halt(0,"Invalid Key!");
				}
				else {
					return Clarion.newNumber(Button.YES);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.REBUILDERROR)) {
				CWin.message(Clarion.newString(ClarionString.staticConcat("Error: (",errortext.clip(),") repairing key for ",warningtext1.clip(),".  Press OK to end this application.")),Clarion.newString("Key Rebuild Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0);
				CRun.halt(0,"Error Rebuilding Key!");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.CREATEERROR)) {
				CWin.message(Clarion.newString(ClarionString.staticConcat("Error: (",errortext.clip(),") creating ",warningtext1.clip(),".  Press OK to end this application.")),Clarion.newString("File Creation Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0);
				CRun.halt(0,"File Creation Error!");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.CREATEOPENERROR)) {
				CWin.message(Clarion.newString(ClarionString.staticConcat("Error: (",errortext.clip(),") opening created ","file:",warningtext1.clip(),".  Press OK to end this application.")),Clarion.newString("File Creation Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0);
				CRun.halt(0,"File Creation Error!");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.PROCEDURETODO)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("The Procedure ",warningtext1.clip()," has not ","been defined.")),Clarion.newString("Procedure not defined"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.BADKEYEDREC)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("Unable to read keyed record.  Error: ",errortext.clip(),".  Insert Aborted")),Clarion.newString(Icon.EXCLAMATION),String.valueOf(Button.OK),Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.OUTOFRANGEHIGH)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("The value of ",warningtext1.clip()," must"," be lower than ",warningtext2.clip(),".")),Clarion.newString("Range Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.OUTOFRANGELOW)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("The value of ",warningtext1.clip()," must be"," higher than ",warningtext2.clip(),".")),Clarion.newString("Range Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.OUTOFRANGE)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("The value of ",warningtext1.clip()," must be ","between ",warningtext2.clip(),".")),Clarion.newString("Range Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.NOTINFILE)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("The value for ",warningtext1.clip()," must be ","found in the ",warningtext2.clip()," file.")),Clarion.newString(ClarionString.staticConcat("Field Contents ","Error")),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.RESTRICTUPDATE)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("This record is referenced from the file ",warningtext1.clip(),".  Linking field(s) have been restricted"," from change and have been reset to original values.")),Clarion.newString("Referential Integrity Update Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.RESTRICTDELETE)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("This record is referenced from the file ",warningtext1.clip(),".  This record cannot be deleted while"," these references exist.")),Clarion.newString("Referential Integrity Delete Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.INSERTERROR)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("An error was experienced during the update of"," record.  Error: ",errortext.clip(),".")),Clarion.newString("Record Insert Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.RIUPDATEERROR)) {
				if (currenterrorcode.boolValue() && !currenterrorcode.equals(Constants.RECORDCHANGEDERR)) {
					return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("An error (",errortext.clip(),") was experienced"," when attempting to update a record from the file.  Probable Cause: ",warningtext1.clip(),".")),Clarion.newString("Update Operation Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				}
				else {
					return Clarion.newNumber(CWin.message(Clarion.newString("This record was changed by another station."),Clarion.newString("Update Operation Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				}
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.RIFORMUPDATEERROR)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("This record was changed by another station. ","Those changes will now be displayed. Use the Ditto Button or Ctrl+'"," to recall your changes.")),Clarion.newString("Record Was Not Updated"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.UPDATEERROR)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("An error was experienced changing this record.  ","Do you want to try to save again?")),Clarion.newString("Record Update Error"),Icon.EXCLAMATION,Button.YES+Button.NO+Button.CANCEL,Button.CANCEL,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.RIDELETEERROR)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("An error (",errortext.clip(),") was experienced"," when attempting to delete a record from the file ",warningtext1.clip(),".")),Clarion.newString("Delete Operation Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.DELETEERROR)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("An error was experienced deleting this record.  ","Do you want to try to save again?")),Clarion.newString("Record Update Error"),Icon.EXCLAMATION,Button.YES+Button.NO+Button.CANCEL,Button.CANCEL,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.INSERTDISABLED)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("This procedure was called to insert a record, ","however inserts are not allowed for this procedure.  Press OK ","to return to the calling procedure")),Clarion.newString("Invalid Request"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.UPDATEDISABLED)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("This procedure was called to change a record, ","however changes are not allowed for this procedure.  Press OK ","to return to the calling procedure")),Clarion.newString("Invalid Request"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.DELETEDISABLED)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("This procedure was called to delete a record, ","however deletions are not allowed for this procedure.  Press OK ","to return to the calling procedure")),Clarion.newString("Invalid Request"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.NOCREATE)) {
				CWin.message(Clarion.newString(ClarionString.staticConcat("The File ",warningtext1.clip(),"was not found, ","and creation of the file is not allowed.  Press OK to end ","this application.")),Clarion.newString("File Creation Not Allowed"),Icon.EXCLAMATION,Button.OK,Button.OK,0);
				CRun.halt(0,"File Creation Error!");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.CONFIRMCANCEL)) {
				return Clarion.newNumber(CWin.message(Clarion.newString("Are you sure you want to cancel?"),Clarion.newString("Update Cancelled"),Icon.QUESTION,Button.YES+Button.NO,Button.NO,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.DUPLICATEKEY)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("Adding this record creates a duplicate entry ","for the key:",warningtext1.clip())),Clarion.newString("Duplicate Key Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.AUTOINCERROR)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("Attempts to automatically number this record have ","failed.  Error: ",errortext.clip(),".")),Clarion.newString("Auto Increment Error"),Icon.EXCLAMATION,Button.CANCEL+Button.RETRY,Button.CANCEL,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.FILELOADERROR)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(warningtext1.clip().concat(" File Load Error.  ","Error: ",errortext.clip(),".")),Clarion.newString("File Load Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.CONFIRMCANCELLOAD)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("Are you certain you want to stop loading ",warningtext1.clip(),"?")),Clarion.newString("Cancel Request"),Icon.QUESTION,Button.OK+Button.CANCEL,Button.CANCEL,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.FILEZEROLENGTH)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(warningtext1.clip().concat(" File Load Error.  ","The file you've requested contains no text.")),Clarion.newString("File Load Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.ENDOFASCIIQUEUE)) {
				if (warningtext1.equals("Down")) {
					return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("The end of the viewed file was encountered.  ","Do you want to start again from the beginning?")),Clarion.newString("End of File Error"),Icon.QUESTION,Button.YES+Button.NO,Button.YES,0));
				}
				else {
					return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("The beginning of the viewed file was encountered.  ","Do you want to start again from the end of the file?")),Clarion.newString("Beginning of File Error"),Icon.QUESTION,Button.YES+Button.NO,Button.YES,0));
				}
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.DISKERROR)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("File (",warningtext1.clip(),") could not be ","opened.  Error: ",errortext.clip(),".")),Clarion.newString("File Access Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.PROCESSACTIONERROR)) {
				if (warningtext1.equals("Put")) {
					return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("An error was experienced when making changes"," to the ",warningtext2.clip()," file.  Error: ",errortext.clip())),Clarion.newString("Process PUT Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				}
				else {
					return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("An error was experienced when deleting a record"," from the ",warningtext2.clip()," file.  Error: ",errortext.clip())),Clarion.newString("Process DELETE Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0));
				}
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.STANDARDDELETE)) {
				return Clarion.newNumber(CWin.message(Clarion.newString(ClarionString.staticConcat("You've selected to delete the highlighted record.  ","Press OK to confirm deletion of this record.")),Clarion.newString("Confirm Delete"),Icon.QUESTION,Button.OK+Button.CANCEL,Button.CANCEL,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.SAVEONCANCEL)) {
				return Clarion.newNumber(CWin.message(Clarion.newString("Do you want to save the changes to this record?"),Clarion.newString("Update Cancelled"),Icon.QUESTION,Button.YES+Button.NO+Button.CANCEL,Button.NO,0));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.LOGOUTERROR)) {
				CWin.message(Clarion.newString(ClarionString.staticConcat("Error: (",errortext.clip(),") attempting to frame the ",warningtext1.clip().lower()," transaction on ",warningtext2.clip(),".  ",warningtext1.clip()," transaction cancelled.")),Clarion.newString("Transaction Framing Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.RECORDFETCHERROR)) {
				CWin.message(Clarion.newString(ClarionString.staticConcat("Error: (",errortext.clip(),") attempting to access a ","record from the ",warningtext1.clip()," file.  Returning to ","previous window.")),Clarion.newString("Record Retrieval Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.VIEWOPENERROR)) {
				CWin.message(Clarion.newString(ClarionString.staticConcat("Error: (",errortext.clip(),") attempting to open the ","current VIEW. Filter and Range Limits ignored.")),Clarion.newString("View Open Error"),Icon.EXCLAMATION,Button.OK,Button.OK,0);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Warn.NEWRECORDADDED)) {
				return Clarion.newNumber(CWin.message(Clarion.newString("This record has been added to the file. Do you want to add another record?"),Clarion.newString("Record Added"),Icon.QUESTION,Button.YES+Button.NO,Button.YES,0));
				// UNREACHABLE! :case_1_break=true;
			}
		}
		return Clarion.newNumber();
	}
	public static void setupstringstops(ClarionString p0,ClarionString p1,ClarionNumber p2)
	{
		setupstringstops(p0,p1,p2,(ClarionNumber)null);
	}
	public static void setupstringstops(ClarionString processlowlimit,ClarionString processhighlimit,ClarionNumber inputstringsize,ClarionNumber listtype)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public static ClarionString nextstringstop()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public static void setuprealstops(ClarionReal inputlowlimit,ClarionReal inputhighlimit)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public static ClarionReal nextrealstop()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public static void inirestorewindow(ClarionString procedurename,ClarionString inifilename)
	{
		ClarionNumber iniXposit=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber iniYposit=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber iniWidth=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber iniHeight=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString iniString=Clarion.newString(20);
		iniXposit.setValue(CConfig.getProperty(procedurename.toString(),"XPosit",null,inifilename.toString()));
		if (!iniXposit.boolValue()) {
			return;
		}
		while (true) {
			if (CWin.getTarget().getProperty(Prop.MAXIMIZE).equals(Constants.FALSE)) {
				iniXposit.setValue(CConfig.getProperty(procedurename.toString(),"XPosit",null,inifilename.toString()));
				if (!iniXposit.boolValue()) {
					break;
				}
				iniYposit.setValue(CConfig.getProperty(procedurename.toString(),"YPosit",null,inifilename.toString()));
				if (!iniYposit.boolValue()) {
					break;
				}
				if (CWin.getTarget().getProperty(Prop.RESIZE).boolValue()) {
					iniWidth.setValue(CConfig.getProperty(procedurename.toString(),"Width",null,inifilename.toString()));
					if (!iniWidth.boolValue()) {
						break;
					}
					iniHeight.setValue(CConfig.getProperty(procedurename.toString(),"Height",null,inifilename.toString()));
					if (!iniHeight.boolValue()) {
						break;
					}
				}
				else {
					iniWidth.setValue(CWin.getTarget().getProperty(Prop.WIDTH));
					iniHeight.setValue(CWin.getTarget().getProperty(Prop.HEIGHT));
				}
				CWin.setPosition(0,iniXposit.intValue(),iniYposit.intValue(),iniWidth.intValue(),iniHeight.intValue());
			}
			break;
		}
		iniString.setValue(CConfig.getProperty(procedurename.toString(),"Maximize",null,inifilename.toString()));
		if (iniString.equals("Yes")) {
			CWin.getTarget().setProperty(Prop.MAXIMIZE,1);
		}
		else {
			CWin.getTarget().setProperty(Prop.MAXIMIZE,0);
		}
		return;
	}
	public static void inisavewindow(ClarionString procedurename,ClarionString inifilename)
	{
		ClarionString iniSection=Clarion.newString(80).setEncoding(ClarionString.CSTRING);
		ClarionString iniString=Clarion.newString(20).setEncoding(ClarionString.CSTRING);
		ClarionString iniEntry=Clarion.newString(20).setEncoding(ClarionString.CSTRING);
		iniSection.setValue(procedurename);
		iniEntry.setValue("Maximize");
		if (CWin.getTarget().getProperty(Prop.MAXIMIZE).boolValue()) {
			iniString.setValue("Yes");
		}
		else {
			iniString.setValue("No");
		}
		CWin.getTarget().setProperty(Prop.MAXIMIZE,0);
		if (CWin.getTarget().getProperty(Prop.ICONIZE).boolValue()) {
			return;
		}
		CConfig.setProperty(iniSection.toString(),iniEntry.toString(),iniString.toString(),inifilename.toString());
		iniEntry.setValue("XPosit");
		iniString.setValue(CWin.getTarget().getProperty(Prop.XPOS));
		CConfig.setProperty(iniSection.toString(),iniEntry.toString(),iniString.toString(),inifilename.toString());
		iniEntry.setValue("YPosit");
		iniString.setValue(CWin.getTarget().getProperty(Prop.YPOS));
		CConfig.setProperty(iniSection.toString(),iniEntry.toString(),iniString.toString(),inifilename.toString());
		iniEntry.setValue("Width");
		iniString.setValue(CWin.getTarget().getProperty(Prop.WIDTH));
		CConfig.setProperty(iniSection.toString(),iniEntry.toString(),iniString.toString(),inifilename.toString());
		iniEntry.setValue("Height");
		iniString.setValue(CWin.getTarget().getProperty(Prop.HEIGHT));
		CConfig.setProperty(iniSection.toString(),iniEntry.toString(),iniString.toString(),inifilename.toString());
		return;
	}
	public static void risaveerror()
	{
	}
}
