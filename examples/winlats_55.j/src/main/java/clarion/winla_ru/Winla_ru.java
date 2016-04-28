package clarion.winla_ru;

import clarion.Main;
import clarion.equates.Constants;
import clarion.equates.Warn;
import clarion.winla_ru.Sav;
import clarion.winla_sf.Winla_sf;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;

@SuppressWarnings("all")
public class Winla_ru
{
	public static ClarionString holdposition;
	public static Sav sav;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		__static_init();
	}

	public static void __static_init() {
		holdposition=Clarion.newString(512).setThread();
		sav=(Sav)(new Sav()).getThread();
	}


	public static ClarionNumber riupdateAlgas()
	{
		return riupdateAlgas(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAlgas(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.algas);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("ALGAS"));
			riupdateAlgas_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.algas.getPosition());
		Main.algas.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.algas.watch();
				Main.algas.reget(Winla_ru.holdposition);
				riupdateAlgas_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("ALGAS"));
				riupdateAlgas_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAlgas_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAlgas_riclosefiles()
	{
		return;
	}
	public static void risnapAlgas()
	{
	}
	public static ClarionNumber riupdateAlgpa()
	{
		return riupdateAlgpa(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAlgpa(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.algpa);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("ALGPA"));
			riupdateAlgpa_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.algpa.getPosition());
		Main.algpa.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.algpa.watch();
				Main.algpa.reget(Winla_ru.holdposition);
				riupdateAlgpa_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("ALGPA"));
				riupdateAlgpa_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAlgpa_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAlgpa_riclosefiles()
	{
		return;
	}
	public static void risnapAlgpa()
	{
	}
	public static ClarionNumber riupdateAmati()
	{
		return riupdateAmati(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAmati(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.amati);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("AMATI"));
			riupdateAmati_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.amati.getPosition());
		Main.amati.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.amati.watch();
				Main.amati.reget(Winla_ru.holdposition);
				riupdateAmati_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("AMATI"));
				riupdateAmati_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAmati_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAmati_riclosefiles()
	{
		return;
	}
	public static void risnapAmati()
	{
	}
	public static ClarionNumber riupdateArm_k()
	{
		return riupdateArm_k(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateArm_k(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.arm_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("ARM_K"));
			riupdateArm_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.arm_k.getPosition());
		Main.arm_k.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.arm_k.watch();
				Main.arm_k.reget(Winla_ru.holdposition);
				riupdateArm_k_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("ARM_K"));
				riupdateArm_k_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateArm_k_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateArm_k_riclosefiles()
	{
		return;
	}
	public static void risnapArm_k()
	{
	}
	public static ClarionNumber riupdateAtl_k()
	{
		return riupdateAtl_k(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAtl_k(ClarionNumber fromform)
	{
		if (Main.atl_sUsed.equals(0)) {
			Winla_sf.checkopen(Main.atl_s,Clarion.newNumber(1));
		}
		Main.atl_sUsed.increment(1);
		ClarionFile.logout(2,Main.atl_k,Main.atl_s);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("ATL_K"));
			riupdateAtl_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.atl_k.getPosition());
		Main.atl_k.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.atl_k.watch();
				Main.atl_k.reget(Winla_ru.holdposition);
				riupdateAtl_k_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("ATL_K"));
				riupdateAtl_k_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		if (!Winla_ru.sav.atlU_nr.equals(Main.atl_k.u_nr)) {
			if (Winla_ru.riupdateAtl_kAtl_s().boolValue()) {
				ClarionFile.rollback();
				Main.atl_s.u_nr.setValue(Main.atl_k.u_nr);
				riupdateAtl_k_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAtl_k_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAtl_k_riclosefiles()
	{
		Main.atl_sUsed.decrement(1);
		if (Main.atl_sUsed.equals(0)) {
			Main.atl_s.close();
		}
		return;
	}
	public static void risnapAtl_k()
	{
		Winla_ru.sav.atlU_nr.setValue(Main.atl_k.u_nr);
	}
	public static ClarionNumber riupdateAtl_s()
	{
		return riupdateAtl_s(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAtl_s(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.atl_s);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("ATL_S"));
			riupdateAtl_s_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.atl_s.getPosition());
		Main.atl_s.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.atl_s.watch();
				Main.atl_s.reget(Winla_ru.holdposition);
				riupdateAtl_s_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("ATL_S"));
				riupdateAtl_s_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAtl_s_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAtl_s_riclosefiles()
	{
		return;
	}
	public static void risnapAtl_s()
	{
	}
	public static ClarionNumber riupdateAuto()
	{
		return riupdateAuto(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAuto(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.auto);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("AUTO"));
			riupdateAuto_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.auto.getPosition());
		Main.auto.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.auto.watch();
				Main.auto.reget(Winla_ru.holdposition);
				riupdateAuto_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("AUTO"));
				riupdateAuto_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAuto_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAuto_riclosefiles()
	{
		return;
	}
	public static void risnapAuto()
	{
	}
	public static ClarionNumber riupdateAutoapk()
	{
		return riupdateAutoapk(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAutoapk(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.autoapk);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("AUTOAPK"));
			riupdateAutoapk_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.autoapk.getPosition());
		Main.autoapk.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.autoapk.watch();
				Main.autoapk.reget(Winla_ru.holdposition);
				riupdateAutoapk_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("AUTOAPK"));
				riupdateAutoapk_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAutoapk_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAutoapk_riclosefiles()
	{
		return;
	}
	public static void risnapAutoapk()
	{
	}
	public static ClarionNumber riupdateAutoapk1()
	{
		return riupdateAutoapk1(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAutoapk1(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.autoapk1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("AUTOAPK1"));
			riupdateAutoapk1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.autoapk1.getPosition());
		Main.autoapk1.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.autoapk1.watch();
				Main.autoapk1.reget(Winla_ru.holdposition);
				riupdateAutoapk1_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("AUTOAPK1"));
				riupdateAutoapk1_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAutoapk1_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAutoapk1_riclosefiles()
	{
		return;
	}
	public static void risnapAutoapk1()
	{
	}
	public static ClarionNumber riupdateAutodarbi()
	{
		return riupdateAutodarbi(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAutodarbi(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.autodarbi);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("AUTODARBI"));
			riupdateAutodarbi_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.autodarbi.getPosition());
		Main.autodarbi.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.autodarbi.watch();
				Main.autodarbi.reget(Winla_ru.holdposition);
				riupdateAutodarbi_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("AUTODARBI"));
				riupdateAutodarbi_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAutodarbi_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAutodarbi_riclosefiles()
	{
		return;
	}
	public static void risnapAutodarbi()
	{
	}
	public static ClarionNumber riupdateAutodarbi1()
	{
		return riupdateAutodarbi1(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAutodarbi1(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.autodarbi1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("AUTODARBI1"));
			riupdateAutodarbi1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.autodarbi1.getPosition());
		Main.autodarbi1.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.autodarbi1.watch();
				Main.autodarbi1.reget(Winla_ru.holdposition);
				riupdateAutodarbi1_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("AUTODARBI1"));
				riupdateAutodarbi1_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAutodarbi1_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAutodarbi1_riclosefiles()
	{
		return;
	}
	public static void risnapAutodarbi1()
	{
	}
	public static ClarionNumber riupdateAutokra()
	{
		return riupdateAutokra(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAutokra(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.autokra);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("AUTOKRA"));
			riupdateAutokra_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.autokra.getPosition());
		Main.autokra.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.autokra.watch();
				Main.autokra.reget(Winla_ru.holdposition);
				riupdateAutokra_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("AUTOKRA"));
				riupdateAutokra_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAutokra_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAutokra_riclosefiles()
	{
		return;
	}
	public static void risnapAutokra()
	{
	}
	public static ClarionNumber riupdateAutomarkas()
	{
		return riupdateAutomarkas(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAutomarkas(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.automarkas);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("AUTOMARKAS"));
			riupdateAutomarkas_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.automarkas.getPosition());
		Main.automarkas.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.automarkas.watch();
				Main.automarkas.reget(Winla_ru.holdposition);
				riupdateAutomarkas_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("AUTOMARKAS"));
				riupdateAutomarkas_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAutomarkas_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAutomarkas_riclosefiles()
	{
		return;
	}
	public static void risnapAutomarkas()
	{
	}
	public static ClarionNumber riupdateAutotex()
	{
		return riupdateAutotex(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAutotex(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.autotex);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("AUTOTEX"));
			riupdateAutotex_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.autotex.getPosition());
		Main.autotex.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.autotex.watch();
				Main.autotex.reget(Winla_ru.holdposition);
				riupdateAutotex_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("AUTOTEX"));
				riupdateAutotex_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAutotex_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAutotex_riclosefiles()
	{
		return;
	}
	public static void risnapAutotex()
	{
	}
	public static ClarionNumber riupdateAu_bilde()
	{
		return riupdateAu_bilde(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAu_bilde(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.au_bilde);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("AU_BILDE"));
			riupdateAu_bilde_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.au_bilde.getPosition());
		Main.au_bilde.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.au_bilde.watch();
				Main.au_bilde.reget(Winla_ru.holdposition);
				riupdateAu_bilde_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("AU_BILDE"));
				riupdateAu_bilde_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAu_bilde_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAu_bilde_riclosefiles()
	{
		return;
	}
	public static void risnapAu_bilde()
	{
	}
	public static ClarionNumber riupdateAu_tex()
	{
		return riupdateAu_tex(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateAu_tex(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.au_tex);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("AU_TEX"));
			riupdateAu_tex_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.au_tex.getPosition());
		Main.au_tex.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.au_tex.watch();
				Main.au_tex.reget(Winla_ru.holdposition);
				riupdateAu_tex_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("AU_TEX"));
				riupdateAu_tex_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateAu_tex_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateAu_tex_riclosefiles()
	{
		return;
	}
	public static void risnapAu_tex()
	{
	}
	public static ClarionNumber riupdateBankas_k()
	{
		return riupdateBankas_k(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateBankas_k(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.bankas_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("BANKAS_K"));
			riupdateBankas_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.bankas_k.getPosition());
		Main.bankas_k.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.bankas_k.watch();
				Main.bankas_k.reget(Winla_ru.holdposition);
				riupdateBankas_k_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("BANKAS_K"));
				riupdateBankas_k_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateBankas_k_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateBankas_k_riclosefiles()
	{
		return;
	}
	public static void risnapBankas_k()
	{
	}
	public static ClarionNumber riupdateB_pavad()
	{
		return riupdateB_pavad(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateB_pavad(ClarionNumber fromform)
	{
		Winla_ru.holdposition.setValue(Main.b_pavad.getPosition());
		Main.b_pavad.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.b_pavad.watch();
				Main.b_pavad.reget(Winla_ru.holdposition);
				riupdateB_pavad_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("B_PAVAD"));
				riupdateB_pavad_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		riupdateB_pavad_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateB_pavad_riclosefiles()
	{
		return;
	}
	public static void risnapB_pavad()
	{
	}
	public static ClarionNumber riupdateCal()
	{
		return riupdateCal(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateCal(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.cal);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("CAL"));
			riupdateCal_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.cal.getPosition());
		Main.cal.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.cal.watch();
				Main.cal.reget(Winla_ru.holdposition);
				riupdateCal_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("CAL"));
				riupdateCal_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateCal_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateCal_riclosefiles()
	{
		return;
	}
	public static void risnapCal()
	{
	}
	public static ClarionNumber riupdateCenuvest()
	{
		return riupdateCenuvest(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateCenuvest(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.cenuvest);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("CENUVEST"));
			riupdateCenuvest_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.cenuvest.getPosition());
		Main.cenuvest.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.cenuvest.watch();
				Main.cenuvest.reget(Winla_ru.holdposition);
				riupdateCenuvest_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("CENUVEST"));
				riupdateCenuvest_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateCenuvest_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateCenuvest_riclosefiles()
	{
		return;
	}
	public static void risnapCenuvest()
	{
	}
	public static ClarionNumber riupdateConfig()
	{
		return riupdateConfig(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateConfig(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.config);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("CONFIG"));
			riupdateConfig_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.config.getPosition());
		Main.config.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.config.watch();
				Main.config.reget(Winla_ru.holdposition);
				riupdateConfig_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("CONFIG"));
				riupdateConfig_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateConfig_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateConfig_riclosefiles()
	{
		return;
	}
	public static void risnapConfig()
	{
	}
	public static ClarionNumber riupdateCrossref()
	{
		return riupdateCrossref(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateCrossref(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.crossref);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("CROSSREF"));
			riupdateCrossref_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.crossref.getPosition());
		Main.crossref.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.crossref.watch();
				Main.crossref.reget(Winla_ru.holdposition);
				riupdateCrossref_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("CROSSREF"));
				riupdateCrossref_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateCrossref_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateCrossref_riclosefiles()
	{
		return;
	}
	public static void risnapCrossref()
	{
	}
	public static ClarionNumber riupdateDaiev()
	{
		return riupdateDaiev(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateDaiev(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.daiev);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("DAIEV"));
			riupdateDaiev_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.daiev.getPosition());
		Main.daiev.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.daiev.watch();
				Main.daiev.reget(Winla_ru.holdposition);
				riupdateDaiev_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("DAIEV"));
				riupdateDaiev_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateDaiev_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateDaiev_riclosefiles()
	{
		return;
	}
	public static void risnapDaiev()
	{
	}
	public static ClarionNumber riupdateEirokodi()
	{
		return riupdateEirokodi(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateEirokodi(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.eirokodi);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("EIROKODI"));
			riupdateEirokodi_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.eirokodi.keykods.getPosition());
		Main.eirokodi.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.eirokodi.watch();
				Main.eirokodi.reget(Winla_ru.holdposition);
				riupdateEirokodi_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("EIROKODI"));
				riupdateEirokodi_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateEirokodi_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateEirokodi_riclosefiles()
	{
		return;
	}
	public static void risnapEirokodi()
	{
	}
	public static ClarionNumber riupdateFpnolik()
	{
		return riupdateFpnolik(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateFpnolik(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.fpnolik);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("FPNOLIK"));
			riupdateFpnolik_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.fpnolik.getPosition());
		Main.fpnolik.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.fpnolik.watch();
				Main.fpnolik.reget(Winla_ru.holdposition);
				riupdateFpnolik_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("FPNOLIK"));
				riupdateFpnolik_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateFpnolik_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateFpnolik_riclosefiles()
	{
		return;
	}
	public static void risnapFpnolik()
	{
	}
	public static ClarionNumber riupdateFppavad()
	{
		return riupdateFppavad(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateFppavad(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.fppavad);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("FPPAVAD"));
			riupdateFppavad_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.fppavad.nr_key.getPosition());
		Main.fppavad.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.fppavad.watch();
				Main.fppavad.reget(Winla_ru.holdposition);
				riupdateFppavad_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("FPPAVAD"));
				riupdateFppavad_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateFppavad_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateFppavad_riclosefiles()
	{
		return;
	}
	public static void risnapFppavad()
	{
	}
	public static ClarionNumber riupdateG1()
	{
		return riupdateG1(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateG1(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.g1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("G1"));
			riupdateG1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.g1.getPosition());
		Main.g1.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.g1.watch();
				Main.g1.reget(Winla_ru.holdposition);
				riupdateG1_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("G1"));
				riupdateG1_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateG1_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateG1_riclosefiles()
	{
		return;
	}
	public static void risnapG1()
	{
	}
	public static ClarionNumber riupdateG2()
	{
		return riupdateG2(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateG2(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.g2);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("G2"));
			riupdateG2_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.g2.getPosition());
		Main.g2.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.g2.watch();
				Main.g2.reget(Winla_ru.holdposition);
				riupdateG2_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("G2"));
				riupdateG2_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateG2_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateG2_riclosefiles()
	{
		return;
	}
	public static void risnapG2()
	{
	}
	public static ClarionNumber riupdateGg()
	{
		return riupdateGg(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateGg(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.gg);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("GG"));
			riupdateGg_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.gg.getPosition());
		Main.gg.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.gg.watch();
				Main.gg.reget(Winla_ru.holdposition);
				riupdateGg_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("GG"));
				riupdateGg_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateGg_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateGg_riclosefiles()
	{
		return;
	}
	public static void risnapGg()
	{
	}
	public static ClarionNumber riupdateGgk()
	{
		return riupdateGgk(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateGgk(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.ggk);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("GGK"));
			riupdateGgk_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.ggk.getPosition());
		Main.ggk.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.ggk.watch();
				Main.ggk.reget(Winla_ru.holdposition);
				riupdateGgk_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("GGK"));
				riupdateGgk_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateGgk_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateGgk_riclosefiles()
	{
		return;
	}
	public static void risnapGgk()
	{
	}
	public static ClarionNumber riupdateGk1()
	{
		return riupdateGk1(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateGk1(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.gk1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("GK1"));
			riupdateGk1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.gk1.getPosition());
		Main.gk1.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.gk1.watch();
				Main.gk1.reget(Winla_ru.holdposition);
				riupdateGk1_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("GK1"));
				riupdateGk1_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateGk1_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateGk1_riclosefiles()
	{
		return;
	}
	public static void risnapGk1()
	{
	}
	public static ClarionNumber riupdateGk2()
	{
		return riupdateGk2(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateGk2(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.gk2);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("GK2"));
			riupdateGk2_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.gk2.getPosition());
		Main.gk2.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.gk2.watch();
				Main.gk2.reget(Winla_ru.holdposition);
				riupdateGk2_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("GK2"));
				riupdateGk2_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateGk2_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateGk2_riclosefiles()
	{
		return;
	}
	public static void risnapGk2()
	{
	}
	public static ClarionNumber riupdateGlobal()
	{
		return riupdateGlobal(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateGlobal(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.global);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("GLOBAL"));
			riupdateGlobal_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.global.getPosition());
		Main.global.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.global.watch();
				Main.global.reget(Winla_ru.holdposition);
				riupdateGlobal_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("GLOBAL"));
				riupdateGlobal_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateGlobal_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateGlobal_riclosefiles()
	{
		return;
	}
	public static void risnapGlobal()
	{
	}
	public static ClarionNumber riupdateGrafiks()
	{
		return riupdateGrafiks(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateGrafiks(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.grafiks);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("GRAFIKS"));
			riupdateGrafiks_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.grafiks.getPosition());
		Main.grafiks.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.grafiks.watch();
				Main.grafiks.reget(Winla_ru.holdposition);
				riupdateGrafiks_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("GRAFIKS"));
				riupdateGrafiks_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateGrafiks_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateGrafiks_riclosefiles()
	{
		return;
	}
	public static void risnapGrafiks()
	{
	}
	public static ClarionNumber riupdateGrupa1()
	{
		return riupdateGrupa1(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateGrupa1(ClarionNumber fromform)
	{
		if (Main.grupa2Used.equals(0)) {
			Winla_sf.checkopen(Main.grupa2,Clarion.newNumber(1));
		}
		Main.grupa2Used.increment(1);
		ClarionFile.logout(2,Main.grupa1,Main.grupa2);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("GRUPA1"));
			riupdateGrupa1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.grupa1.gr1_key.getPosition());
		Main.grupa1.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.grupa1.watch();
				Main.grupa1.reget(Winla_ru.holdposition);
				riupdateGrupa1_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("GRUPA1"));
				riupdateGrupa1_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		if (!Winla_ru.sav.gr1Grupa1.equals(Main.grupa1.grupa1)) {
			if (Winla_ru.riupdateGrupa1Grupa2().boolValue()) {
				ClarionFile.rollback();
				Main.grupa2.grupa1.setValue(Main.grupa1.grupa1);
				riupdateGrupa1_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateGrupa1_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateGrupa1_riclosefiles()
	{
		Main.grupa2Used.decrement(1);
		if (Main.grupa2Used.equals(0)) {
			Main.grupa2.close();
		}
		return;
	}
	public static void risnapGrupa1()
	{
		Winla_ru.sav.gr1Grupa1.setValue(Main.grupa1.grupa1);
	}
	public static ClarionNumber riupdateGrupa2()
	{
		return riupdateGrupa2(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateGrupa2(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.grupa2);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("GRUPA2"));
			riupdateGrupa2_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.grupa2.getPosition());
		Main.grupa2.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.grupa2.watch();
				Main.grupa2.reget(Winla_ru.holdposition);
				riupdateGrupa2_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("GRUPA2"));
				riupdateGrupa2_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateGrupa2_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateGrupa2_riclosefiles()
	{
		return;
	}
	public static void risnapGrupa2()
	{
	}
	public static ClarionNumber riupdateInvent()
	{
		return riupdateInvent(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateInvent(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.invent);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("INVENT"));
			riupdateInvent_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.invent.getPosition());
		Main.invent.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.invent.watch();
				Main.invent.reget(Winla_ru.holdposition);
				riupdateInvent_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("INVENT"));
				riupdateInvent_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateInvent_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateInvent_riclosefiles()
	{
		return;
	}
	public static void risnapInvent()
	{
	}
	public static ClarionNumber riupdateKadri()
	{
		return riupdateKadri(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateKadri(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.kadri);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("KADRI"));
			riupdateKadri_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.kadri.getPosition());
		Main.kadri.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.kadri.watch();
				Main.kadri.reget(Winla_ru.holdposition);
				riupdateKadri_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("KADRI"));
				riupdateKadri_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateKadri_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateKadri_riclosefiles()
	{
		return;
	}
	public static void risnapKadri()
	{
	}
	public static ClarionNumber riupdateKad_rik()
	{
		return riupdateKad_rik(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateKad_rik(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.kad_rik);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("KAD_RIK"));
			riupdateKad_rik_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.kad_rik.getPosition());
		Main.kad_rik.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.kad_rik.watch();
				Main.kad_rik.reget(Winla_ru.holdposition);
				riupdateKad_rik_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("KAD_RIK"));
				riupdateKad_rik_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateKad_rik_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateKad_rik_riclosefiles()
	{
		return;
	}
	public static void risnapKad_rik()
	{
	}
	public static ClarionNumber riupdateKat_k()
	{
		return riupdateKat_k(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateKat_k(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.kat_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("KAT_K"));
			riupdateKat_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.kat_k.getPosition());
		Main.kat_k.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.kat_k.watch();
				Main.kat_k.reget(Winla_ru.holdposition);
				riupdateKat_k_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("KAT_K"));
				riupdateKat_k_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateKat_k_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateKat_k_riclosefiles()
	{
		return;
	}
	public static void risnapKat_k()
	{
	}
	public static ClarionNumber riupdateKludas()
	{
		return riupdateKludas(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateKludas(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.kludas);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("KLUDAS"));
			riupdateKludas_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.kludas.getPosition());
		Main.kludas.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.kludas.watch();
				Main.kludas.reget(Winla_ru.holdposition);
				riupdateKludas_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("KLUDAS"));
				riupdateKludas_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateKludas_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateKludas_riclosefiles()
	{
		return;
	}
	public static void risnapKludas()
	{
	}
	public static ClarionNumber riupdateKoivunen()
	{
		return riupdateKoivunen(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateKoivunen(ClarionNumber fromform)
	{
		Winla_ru.holdposition.setValue(Main.koivunen.getPosition());
		Main.koivunen.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.koivunen.watch();
				Main.koivunen.reget(Winla_ru.holdposition);
				riupdateKoivunen_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("KOIVUNEN"));
				riupdateKoivunen_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		riupdateKoivunen_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateKoivunen_riclosefiles()
	{
		return;
	}
	public static void risnapKoivunen()
	{
	}
	public static ClarionNumber riupdateKomplekt()
	{
		return riupdateKomplekt(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateKomplekt(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.komplekt);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("KOMPLEKT"));
			riupdateKomplekt_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.komplekt.getPosition());
		Main.komplekt.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.komplekt.watch();
				Main.komplekt.reget(Winla_ru.holdposition);
				riupdateKomplekt_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("KOMPLEKT"));
				riupdateKomplekt_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateKomplekt_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateKomplekt_riclosefiles()
	{
		return;
	}
	public static void risnapKomplekt()
	{
	}
	public static ClarionNumber riupdateKon_k()
	{
		return riupdateKon_k(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateKon_k(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.kon_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("KON_K"));
			riupdateKon_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.kon_k.getPosition());
		Main.kon_k.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.kon_k.watch();
				Main.kon_k.reget(Winla_ru.holdposition);
				riupdateKon_k_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("KON_K"));
				riupdateKon_k_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateKon_k_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateKon_k_riclosefiles()
	{
		return;
	}
	public static void risnapKon_k()
	{
	}
	public static ClarionNumber riupdateKon_r()
	{
		return riupdateKon_r(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateKon_r(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.kon_r);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("KON_R"));
			riupdateKon_r_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.kon_r.getPosition());
		Main.kon_r.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.kon_r.watch();
				Main.kon_r.reget(Winla_ru.holdposition);
				riupdateKon_r_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("KON_R"));
				riupdateKon_r_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateKon_r_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateKon_r_riclosefiles()
	{
		return;
	}
	public static void risnapKon_r()
	{
	}
	public static ClarionNumber riupdateKursi_k()
	{
		return riupdateKursi_k(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateKursi_k(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.kursi_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("KURSI_K"));
			riupdateKursi_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.kursi_k.getPosition());
		Main.kursi_k.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.kursi_k.watch();
				Main.kursi_k.reget(Winla_ru.holdposition);
				riupdateKursi_k_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("KURSI_K"));
				riupdateKursi_k_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateKursi_k_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateKursi_k_riclosefiles()
	{
		return;
	}
	public static void risnapKursi_k()
	{
	}
	public static ClarionNumber riupdateMer_k()
	{
		return riupdateMer_k(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateMer_k(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.mer_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("MER_K"));
			riupdateMer_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.mer_k.getPosition());
		Main.mer_k.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.mer_k.watch();
				Main.mer_k.reget(Winla_ru.holdposition);
				riupdateMer_k_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("MER_K"));
				riupdateMer_k_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateMer_k_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateMer_k_riclosefiles()
	{
		return;
	}
	public static void risnapMer_k()
	{
	}
	public static ClarionNumber riupdateNodalas()
	{
		return riupdateNodalas(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateNodalas(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.nodalas);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("NODALAS"));
			riupdateNodalas_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.nodalas.getPosition());
		Main.nodalas.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.nodalas.watch();
				Main.nodalas.reget(Winla_ru.holdposition);
				riupdateNodalas_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("NODALAS"));
				riupdateNodalas_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateNodalas_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateNodalas_riclosefiles()
	{
		return;
	}
	public static void risnapNodalas()
	{
	}
	public static ClarionNumber riupdateNoli1()
	{
		return riupdateNoli1(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateNoli1(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.noli1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("NOLI1"));
			riupdateNoli1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.noli1.getPosition());
		Main.noli1.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.noli1.watch();
				Main.noli1.reget(Winla_ru.holdposition);
				riupdateNoli1_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("NOLI1"));
				riupdateNoli1_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateNoli1_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateNoli1_riclosefiles()
	{
		return;
	}
	public static void risnapNoli1()
	{
	}
	public static ClarionNumber riupdateNolik()
	{
		return riupdateNolik(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateNolik(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.nolik);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("NOLIK"));
			riupdateNolik_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.nolik.getPosition());
		Main.nolik.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.nolik.watch();
				Main.nolik.reget(Winla_ru.holdposition);
				riupdateNolik_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("NOLIK"));
				riupdateNolik_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateNolik_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateNolik_riclosefiles()
	{
		return;
	}
	public static void risnapNolik()
	{
	}
	public static ClarionNumber riupdateNolpas()
	{
		return riupdateNolpas(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateNolpas(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.nolpas);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("NOLPAS"));
			riupdateNolpas_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.nolpas.getPosition());
		Main.nolpas.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.nolpas.watch();
				Main.nolpas.reget(Winla_ru.holdposition);
				riupdateNolpas_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("NOLPAS"));
				riupdateNolpas_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateNolpas_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateNolpas_riclosefiles()
	{
		return;
	}
	public static void risnapNolpas()
	{
	}
	public static ClarionNumber riupdateNol_fifo()
	{
		return riupdateNol_fifo(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateNol_fifo(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.nol_fifo);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("NOL_FIFO"));
			riupdateNol_fifo_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.nol_fifo.getPosition());
		Main.nol_fifo.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.nol_fifo.watch();
				Main.nol_fifo.reget(Winla_ru.holdposition);
				riupdateNol_fifo_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("NOL_FIFO"));
				riupdateNol_fifo_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateNol_fifo_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateNol_fifo_riclosefiles()
	{
		return;
	}
	public static void risnapNol_fifo()
	{
	}
	public static ClarionNumber riupdateNol_kops()
	{
		return riupdateNol_kops(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateNol_kops(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.nol_kops);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("NOL_KOPS"));
			riupdateNol_kops_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.nol_kops.getPosition());
		Main.nol_kops.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.nol_kops.watch();
				Main.nol_kops.reget(Winla_ru.holdposition);
				riupdateNol_kops_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("NOL_KOPS"));
				riupdateNol_kops_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateNol_kops_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateNol_kops_riclosefiles()
	{
		return;
	}
	public static void risnapNol_kops()
	{
	}
	public static ClarionNumber riupdateNol_stat()
	{
		return riupdateNol_stat(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateNol_stat(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.nol_stat);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("NOL_STAT"));
			riupdateNol_stat_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.nol_stat.getPosition());
		Main.nol_stat.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.nol_stat.watch();
				Main.nol_stat.reget(Winla_ru.holdposition);
				riupdateNol_stat_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("NOL_STAT"));
				riupdateNol_stat_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateNol_stat_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateNol_stat_riclosefiles()
	{
		return;
	}
	public static void risnapNol_stat()
	{
	}
	public static ClarionNumber riupdateNom_a()
	{
		return riupdateNom_a(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateNom_a(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.nom_a);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("NOM_A"));
			riupdateNom_a_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.nom_a.getPosition());
		Main.nom_a.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.nom_a.watch();
				Main.nom_a.reget(Winla_ru.holdposition);
				riupdateNom_a_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("NOM_A"));
				riupdateNom_a_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateNom_a_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateNom_a_riclosefiles()
	{
		return;
	}
	public static void risnapNom_a()
	{
	}
	public static ClarionNumber riupdateNom_c()
	{
		return riupdateNom_c(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateNom_c(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.nom_c);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("NOM_C"));
			riupdateNom_c_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.nom_c.getPosition());
		Main.nom_c.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.nom_c.watch();
				Main.nom_c.reget(Winla_ru.holdposition);
				riupdateNom_c_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("NOM_C"));
				riupdateNom_c_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateNom_c_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateNom_c_riclosefiles()
	{
		return;
	}
	public static void risnapNom_c()
	{
	}
	public static ClarionNumber riupdateNom_k()
	{
		return riupdateNom_k(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateNom_k(ClarionNumber fromform)
	{
		if (Main.komplektUsed.equals(0)) {
			Winla_sf.checkopen(Main.komplekt,Clarion.newNumber(1));
		}
		Main.komplektUsed.increment(1);
		ClarionFile.logout(2,Main.nom_k,Main.komplekt);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("NOM_K"));
			riupdateNom_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.nom_k.getPosition());
		Main.nom_k.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.nom_k.watch();
				Main.nom_k.reget(Winla_ru.holdposition);
				riupdateNom_k_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("NOM_K"));
				riupdateNom_k_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		if (!Winla_ru.sav.nomNomenklat.equals(Main.nom_k.nomenklat)) {
			if (Winla_ru.riupdateNom_kKomplekt().boolValue()) {
				ClarionFile.rollback();
				Main.komplekt.nomenklat.setValue(Main.nom_k.nomenklat);
				riupdateNom_k_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateNom_k_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateNom_k_riclosefiles()
	{
		Main.komplektUsed.decrement(1);
		if (Main.komplektUsed.equals(0)) {
			Main.komplekt.close();
		}
		return;
	}
	public static void risnapNom_k()
	{
		Winla_ru.sav.nomNomenklat.setValue(Main.nom_k.nomenklat);
	}
	public static ClarionNumber riupdateNom_k1()
	{
		return riupdateNom_k1(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateNom_k1(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.nom_k1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("NOM_K1"));
			riupdateNom_k1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.nom_k1.getPosition());
		Main.nom_k1.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.nom_k1.watch();
				Main.nom_k1.reget(Winla_ru.holdposition);
				riupdateNom_k1_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("NOM_K1"));
				riupdateNom_k1_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateNom_k1_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateNom_k1_riclosefiles()
	{
		return;
	}
	public static void risnapNom_k1()
	{
	}
	public static ClarionNumber riupdateNom_n()
	{
		return riupdateNom_n(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateNom_n(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.nom_n);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("NOM_N"));
			riupdateNom_n_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.nom_n.getPosition());
		Main.nom_n.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.nom_n.watch();
				Main.nom_n.reget(Winla_ru.holdposition);
				riupdateNom_n_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("NOM_N"));
				riupdateNom_n_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateNom_n_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateNom_n_riclosefiles()
	{
		return;
	}
	public static void risnapNom_n()
	{
	}
	public static ClarionNumber riupdateNom_p()
	{
		return riupdateNom_p(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateNom_p(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.nom_p);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("NOM_P"));
			riupdateNom_p_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.nom_p.getPosition());
		Main.nom_p.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.nom_p.watch();
				Main.nom_p.reget(Winla_ru.holdposition);
				riupdateNom_p_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("NOM_P"));
				riupdateNom_p_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateNom_p_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateNom_p_riclosefiles()
	{
		return;
	}
	public static void risnapNom_p()
	{
	}
	public static ClarionNumber riupdateOutfile()
	{
		return riupdateOutfile(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateOutfile(ClarionNumber fromform)
	{
		Winla_ru.holdposition.setValue(Main.outfile.getPosition());
		Main.outfile.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.outfile.watch();
				Main.outfile.reget(Winla_ru.holdposition);
				riupdateOutfile_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("OUTFILE"));
				riupdateOutfile_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		riupdateOutfile_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateOutfile_riclosefiles()
	{
		return;
	}
	public static void risnapOutfile()
	{
	}
	public static ClarionNumber riupdateOutfileansi()
	{
		return riupdateOutfileansi(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateOutfileansi(ClarionNumber fromform)
	{
		Winla_ru.holdposition.setValue(Main.outfileansi.getPosition());
		Main.outfileansi.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.outfileansi.watch();
				Main.outfileansi.reget(Winla_ru.holdposition);
				riupdateOutfileansi_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("OUTFILEANSI"));
				riupdateOutfileansi_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		riupdateOutfileansi_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateOutfileansi_riclosefiles()
	{
		return;
	}
	public static void risnapOutfileansi()
	{
	}
	public static ClarionNumber riupdatePamam()
	{
		return riupdatePamam(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePamam(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.pamam);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAMAM"));
			riupdatePamam_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.pamam.nr_key.getPosition());
		Main.pamam.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.pamam.watch();
				Main.pamam.reget(Winla_ru.holdposition);
				riupdatePamam_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAMAM"));
				riupdatePamam_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePamam_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePamam_riclosefiles()
	{
		return;
	}
	public static void risnapPamam()
	{
	}
	public static ClarionNumber riupdatePamat()
	{
		return riupdatePamat(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePamat(ClarionNumber fromform)
	{
		if (Main.pamamUsed.equals(0)) {
			Winla_sf.checkopen(Main.pamam,Clarion.newNumber(1));
		}
		Main.pamamUsed.increment(1);
		ClarionFile.logout(2,Main.pamat,Main.pamam);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAMAT"));
			riupdatePamat_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.pamat.getPosition());
		Main.pamat.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.pamat.watch();
				Main.pamat.reget(Winla_ru.holdposition);
				riupdatePamat_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAMAT"));
				riupdatePamat_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		if (!Winla_ru.sav.pamU_nr.equals(Main.pamat.u_nr)) {
			if (Winla_ru.riupdatePamatPamam().boolValue()) {
				ClarionFile.rollback();
				Main.pamam.u_nr.setValue(Main.pamat.u_nr);
				riupdatePamat_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePamat_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePamat_riclosefiles()
	{
		Main.pamamUsed.decrement(1);
		if (Main.pamamUsed.equals(0)) {
			Main.pamam.close();
		}
		return;
	}
	public static void risnapPamat()
	{
		Winla_ru.sav.pamU_nr.setValue(Main.pamat.u_nr);
	}
	public static ClarionNumber riupdatePamkat()
	{
		return riupdatePamkat(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePamkat(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.pamkat);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAMKAT"));
			riupdatePamkat_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.pamkat.getPosition());
		Main.pamkat.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.pamkat.watch();
				Main.pamkat.reget(Winla_ru.holdposition);
				riupdatePamkat_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAMKAT"));
				riupdatePamkat_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePamkat_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePamkat_riclosefiles()
	{
		return;
	}
	public static void risnapPamkat()
	{
	}
	public static ClarionNumber riupdatePam_p()
	{
		return riupdatePam_p(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePam_p(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.pam_p);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAM_P"));
			riupdatePam_p_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.pam_p.getPosition());
		Main.pam_p.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.pam_p.watch();
				Main.pam_p.reget(Winla_ru.holdposition);
				riupdatePam_p_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAM_P"));
				riupdatePam_p_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePam_p_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePam_p_riclosefiles()
	{
		return;
	}
	public static void risnapPam_p()
	{
	}
	public static ClarionNumber riupdateParoles()
	{
		return riupdateParoles(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateParoles(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.paroles);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAROLES"));
			riupdateParoles_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.paroles.getPosition());
		Main.paroles.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.paroles.watch();
				Main.paroles.reget(Winla_ru.holdposition);
				riupdateParoles_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAROLES"));
				riupdateParoles_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateParoles_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateParoles_riclosefiles()
	{
		return;
	}
	public static void risnapParoles()
	{
	}
	public static ClarionNumber riupdatePar_a()
	{
		return riupdatePar_a(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePar_a(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.par_a);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAR_A"));
			riupdatePar_a_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.par_a.getPosition());
		Main.par_a.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.par_a.watch();
				Main.par_a.reget(Winla_ru.holdposition);
				riupdatePar_a_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAR_A"));
				riupdatePar_a_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePar_a_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePar_a_riclosefiles()
	{
		return;
	}
	public static void risnapPar_a()
	{
	}
	public static ClarionNumber riupdatePar_e()
	{
		return riupdatePar_e(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePar_e(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.par_e);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAR_E"));
			riupdatePar_e_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.par_e.getPosition());
		Main.par_e.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.par_e.watch();
				Main.par_e.reget(Winla_ru.holdposition);
				riupdatePar_e_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAR_E"));
				riupdatePar_e_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePar_e_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePar_e_riclosefiles()
	{
		return;
	}
	public static void risnapPar_e()
	{
	}
	public static ClarionNumber riupdatePar_k()
	{
		return riupdatePar_k(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePar_k(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.par_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAR_K"));
			riupdatePar_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.par_k.getPosition());
		Main.par_k.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.par_k.watch();
				Main.par_k.reget(Winla_ru.holdposition);
				riupdatePar_k_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAR_K"));
				riupdatePar_k_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePar_k_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePar_k_riclosefiles()
	{
		return;
	}
	public static void risnapPar_k()
	{
	}
	public static ClarionNumber riupdatePar_k1()
	{
		return riupdatePar_k1(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePar_k1(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.par_k1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAR_K1"));
			riupdatePar_k1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.par_k1.getPosition());
		Main.par_k1.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.par_k1.watch();
				Main.par_k1.reget(Winla_ru.holdposition);
				riupdatePar_k1_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAR_K1"));
				riupdatePar_k1_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePar_k1_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePar_k1_riclosefiles()
	{
		return;
	}
	public static void risnapPar_k1()
	{
	}
	public static ClarionNumber riupdatePar_l()
	{
		return riupdatePar_l(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePar_l(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.par_l);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAR_L"));
			riupdatePar_l_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.par_l.getPosition());
		Main.par_l.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.par_l.watch();
				Main.par_l.reget(Winla_ru.holdposition);
				riupdatePar_l_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAR_L"));
				riupdatePar_l_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePar_l_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePar_l_riclosefiles()
	{
		return;
	}
	public static void risnapPar_l()
	{
	}
	public static ClarionNumber riupdatePar_z()
	{
		return riupdatePar_z(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePar_z(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.par_z);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAR_Z"));
			riupdatePar_z_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.par_z.getPosition());
		Main.par_z.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.par_z.watch();
				Main.par_z.reget(Winla_ru.holdposition);
				riupdatePar_z_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAR_Z"));
				riupdatePar_z_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePar_z_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePar_z_riclosefiles()
	{
		return;
	}
	public static void risnapPar_z()
	{
	}
	public static ClarionNumber riupdatePava1()
	{
		return riupdatePava1(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePava1(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.pava1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAVA1"));
			riupdatePava1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.pava1.getPosition());
		Main.pava1.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.pava1.watch();
				Main.pava1.reget(Winla_ru.holdposition);
				riupdatePava1_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAVA1"));
				riupdatePava1_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePava1_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePava1_riclosefiles()
	{
		return;
	}
	public static void risnapPava1()
	{
	}
	public static ClarionNumber riupdatePavad()
	{
		return riupdatePavad(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePavad(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.pavad);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAVAD"));
			riupdatePavad_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.pavad.getPosition());
		Main.pavad.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.pavad.watch();
				Main.pavad.reget(Winla_ru.holdposition);
				riupdatePavad_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAVAD"));
				riupdatePavad_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePavad_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePavad_riclosefiles()
	{
		return;
	}
	public static void risnapPavad()
	{
	}
	public static ClarionNumber riupdatePavpas()
	{
		return riupdatePavpas(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePavpas(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.pavpas);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PAVPAS"));
			riupdatePavpas_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.pavpas.getPosition());
		Main.pavpas.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.pavpas.watch();
				Main.pavpas.reget(Winla_ru.holdposition);
				riupdatePavpas_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAVPAS"));
				riupdatePavpas_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePavpas_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePavpas_riclosefiles()
	{
		return;
	}
	public static void risnapPavpas()
	{
	}
	public static ClarionNumber riupdatePernos()
	{
		return riupdatePernos(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdatePernos(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.pernos);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PERNOS"));
			riupdatePernos_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.pernos.getPosition());
		Main.pernos.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.pernos.watch();
				Main.pernos.reget(Winla_ru.holdposition);
				riupdatePernos_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PERNOS"));
				riupdatePernos_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdatePernos_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdatePernos_riclosefiles()
	{
		return;
	}
	public static void risnapPernos()
	{
	}
	public static ClarionNumber riupdateProjekti()
	{
		return riupdateProjekti(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateProjekti(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.projekti);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PROJEKTI"));
			riupdateProjekti_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.projekti.getPosition());
		Main.projekti.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.projekti.watch();
				Main.projekti.reget(Winla_ru.holdposition);
				riupdateProjekti_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PROJEKTI"));
				riupdateProjekti_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateProjekti_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateProjekti_riclosefiles()
	{
		return;
	}
	public static void risnapProjekti()
	{
	}
	public static ClarionNumber riupdateProj_p()
	{
		return riupdateProj_p(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateProj_p(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.proj_p);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("PROJ_P"));
			riupdateProj_p_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.proj_p.getPosition());
		Main.proj_p.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.proj_p.watch();
				Main.proj_p.reget(Winla_ru.holdposition);
				riupdateProj_p_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PROJ_P"));
				riupdateProj_p_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateProj_p_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateProj_p_riclosefiles()
	{
		return;
	}
	public static void risnapProj_p()
	{
	}
	public static ClarionNumber riupdateSystem()
	{
		return riupdateSystem(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateSystem(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.system);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("SYSTEM"));
			riupdateSystem_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.system.getPosition());
		Main.system.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.system.watch();
				Main.system.reget(Winla_ru.holdposition);
				riupdateSystem_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("SYSTEM"));
				riupdateSystem_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateSystem_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateSystem_riclosefiles()
	{
		return;
	}
	public static void risnapSystem()
	{
	}
	public static ClarionNumber riupdateTeksti()
	{
		return riupdateTeksti(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateTeksti(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.teksti);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("TEKSTI"));
			riupdateTeksti_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.teksti.getPosition());
		Main.teksti.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.teksti.watch();
				Main.teksti.reget(Winla_ru.holdposition);
				riupdateTeksti_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("TEKSTI"));
				riupdateTeksti_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateTeksti_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateTeksti_riclosefiles()
	{
		return;
	}
	public static void risnapTeksti()
	{
	}
	public static ClarionNumber riupdateTeksti1()
	{
		return riupdateTeksti1(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateTeksti1(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.teksti1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("TEKSTI1"));
			riupdateTeksti1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.teksti1.getPosition());
		Main.teksti1.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.teksti1.watch();
				Main.teksti1.reget(Winla_ru.holdposition);
				riupdateTeksti1_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("TEKSTI1"));
				riupdateTeksti1_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateTeksti1_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateTeksti1_riclosefiles()
	{
		return;
	}
	public static void risnapTeksti1()
	{
	}
	public static ClarionNumber riupdateTek_k()
	{
		return riupdateTek_k(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateTek_k(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.tek_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("TEK_K"));
			riupdateTek_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.tek_k.getPosition());
		Main.tek_k.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.tek_k.watch();
				Main.tek_k.reget(Winla_ru.holdposition);
				riupdateTek_k_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("TEK_K"));
				riupdateTek_k_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateTek_k_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateTek_k_riclosefiles()
	{
		return;
	}
	public static void risnapTek_k()
	{
	}
	public static ClarionNumber riupdateTek_ser()
	{
		return riupdateTek_ser(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateTek_ser(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.tek_ser);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("TEK_SER"));
			riupdateTek_ser_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.tek_ser.getPosition());
		Main.tek_ser.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.tek_ser.watch();
				Main.tek_ser.reget(Winla_ru.holdposition);
				riupdateTek_ser_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("TEK_SER"));
				riupdateTek_ser_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateTek_ser_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateTek_ser_riclosefiles()
	{
		return;
	}
	public static void risnapTek_ser()
	{
	}
	public static ClarionNumber riupdateVal_k()
	{
		return riupdateVal_k(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateVal_k(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.val_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("VAL_K"));
			riupdateVal_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.val_k.getPosition());
		Main.val_k.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.val_k.watch();
				Main.val_k.reget(Winla_ru.holdposition);
				riupdateVal_k_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("VAL_K"));
				riupdateVal_k_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateVal_k_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateVal_k_riclosefiles()
	{
		return;
	}
	public static void risnapVal_k()
	{
	}
	public static ClarionNumber riupdateVesture()
	{
		return riupdateVesture(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateVesture(ClarionNumber fromform)
	{
		ClarionFile.logout(2,Main.vesture);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Update"),Clarion.newString("VESTURE"));
			riupdateVesture_riclosefiles();
			return Clarion.newNumber(1);
		}
		Winla_ru.holdposition.setValue(Main.vesture.getPosition());
		Main.vesture.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.vesture.watch();
				Main.vesture.reget(Winla_ru.holdposition);
				riupdateVesture_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("VESTURE"));
				riupdateVesture_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		ClarionFile.commit();
		riupdateVesture_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateVesture_riclosefiles()
	{
		return;
	}
	public static void risnapVesture()
	{
	}
	public static ClarionNumber riupdateZurfile()
	{
		return riupdateZurfile(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateZurfile(ClarionNumber fromform)
	{
		Winla_ru.holdposition.setValue(Main.zurfile.getPosition());
		Main.zurfile.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.zurfile.watch();
				Main.zurfile.reget(Winla_ru.holdposition);
				riupdateZurfile_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("ZURFILE"));
				riupdateZurfile_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		riupdateZurfile_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateZurfile_riclosefiles()
	{
		return;
	}
	public static void risnapZurfile()
	{
	}
	public static ClarionNumber riupdateZurnals()
	{
		return riupdateZurnals(Clarion.newNumber(0));
	}
	public static ClarionNumber riupdateZurnals(ClarionNumber fromform)
	{
		Winla_ru.holdposition.setValue(Main.zurnals.getPosition());
		Main.zurnals.put();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			if (Main.saveerrorcode.equals(Constants.RECORDCHANGEDERR)) {
				if (fromform.boolValue()) {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIFORMUPDATEERROR));
				}
				else {
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("Record Changed by Another Station"));
				}
				Main.zurnals.watch();
				Main.zurnals.reget(Winla_ru.holdposition);
				riupdateZurnals_riclosefiles();
				return Clarion.newNumber(2);
			}
			else {
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("ZURNALS"));
				riupdateZurnals_riclosefiles();
				return Clarion.newNumber(1);
			}
		}
		riupdateZurnals_riclosefiles();
		return Clarion.newNumber(0);
	}
	public static void riupdateZurnals_riclosefiles()
	{
		return;
	}
	public static void risnapZurnals()
	{
	}
	public static ClarionNumber riupdateAtl_kAtl_s()
	{
		Main.atl_s.clear(0);
		Main.atl_s.u_nr.setValue(Winla_ru.sav.atlU_nr);
		Main.atl_s.nomenklat.clear(-1);
		Main.atl_s.nr_key.set(Main.atl_s.nr_key);
		while (true) {
			Main.atl_s.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("ATL_S"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.atl_s.u_nr.equals(Winla_ru.sav.atlU_nr)) {
				return Clarion.newNumber(0);
			}
			Winla_ru.risnapAtl_s();
			Main.atl_s.u_nr.setValue(Main.atl_k.u_nr);
			Main.atl_s.put();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("ATL_S"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber riupdateGrupa1Grupa2()
	{
		Main.grupa2.clear(0);
		Main.grupa2.grupa1.setValue(Winla_ru.sav.gr1Grupa1);
		Main.grupa2.grupa2.clear(-1);
		Main.grupa2.gr1_key.set(Main.grupa2.gr1_key);
		while (true) {
			Main.grupa2.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("GRUPA2"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.grupa2.grupa1.equals(Winla_ru.sav.gr1Grupa1)) {
				return Clarion.newNumber(0);
			}
			Winla_ru.risnapGrupa2();
			Main.grupa2.grupa1.setValue(Main.grupa1.grupa1);
			Main.grupa2.put();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("GRUPA2"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber riupdateNom_kKomplekt()
	{
		Main.komplekt.clear(0);
		Main.komplekt.nomenklat.setValue(Winla_ru.sav.nomNomenklat);
		Main.komplekt.nom_source.clear(-1);
		Main.komplekt.nom_key.set(Main.komplekt.nom_key);
		while (true) {
			Main.komplekt.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("KOMPLEKT"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.komplekt.nomenklat.equals(Winla_ru.sav.nomNomenklat)) {
				return Clarion.newNumber(0);
			}
			Winla_ru.risnapKomplekt();
			Main.komplekt.nomenklat.setValue(Main.nom_k.nomenklat);
			Main.komplekt.put();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("KOMPLEKT"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber riupdatePamatPamam()
	{
		Main.pamam.clear(0);
		Main.pamam.u_nr.setValue(Winla_ru.sav.pamU_nr);
		Main.pamam.yyyymm.clear(-1);
		Main.pamam.nr_key.set(Main.pamam.nr_key);
		while (true) {
			Main.pamam.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("PAMAM"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.pamam.u_nr.equals(Winla_ru.sav.pamU_nr)) {
				return Clarion.newNumber(0);
			}
			Winla_ru.risnapPamam();
			Main.pamam.u_nr.setValue(Main.pamat.u_nr);
			Main.pamam.put();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIUPDATEERROR),Clarion.newString("PAMAM"));
				return Clarion.newNumber(1);
			}
		}
	}
}
