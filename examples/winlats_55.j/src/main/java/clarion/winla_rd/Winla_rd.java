package clarion.winla_rd;

import clarion.Main;
import clarion.equates.Constants;
import clarion.equates.Warn;
import clarion.winla_sf.Winla_sf;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;

@SuppressWarnings("all")
public class Winla_rd
{

	public static ClarionNumber rideleteAlgas()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.algas.id_key.getPosition());
		ClarionFile.logout(2,Main.algas);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("ALGAS"));
			rideleteAlgas_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.algas.id_key.reget(currentPosition);
		Main.algas.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("ALGAS"));
			rideleteAlgas_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAlgas_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAlgas_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteAlgpa()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.algpa.yyyymm_key.getPosition());
		if (Main.algasUsed.equals(0)) {
			Winla_sf.checkopen(Main.algas,Clarion.newNumber(1));
		}
		Main.algasUsed.increment(1);
		ClarionFile.logout(2,Main.algpa,Main.algas);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("ALGPA"));
			rideleteAlgpa_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.algpa.yyyymm_key.reget(currentPosition);
		if (Winla_rd.rideleteAlgpaAlgas().boolValue()) {
			ClarionFile.rollback();
			rideleteAlgpa_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.algpa.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("ALGPA"));
			rideleteAlgpa_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAlgpa_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAlgpa_riclosefiles()
	{
		Main.algasUsed.decrement(1);
		if (Main.algasUsed.equals(0)) {
			Main.algas.close();
		}
		return;
	}
	public static ClarionNumber rideleteAmati()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.amati.ams_key.getPosition());
		ClarionFile.logout(2,Main.amati);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("AMATI"));
			rideleteAmati_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.amati.ams_key.reget(currentPosition);
		Main.amati.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AMATI"));
			rideleteAmati_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAmati_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAmati_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteArm_k()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.arm_k.kods_key.getPosition());
		ClarionFile.logout(2,Main.arm_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("ARM_K"));
			rideleteArm_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.arm_k.kods_key.reget(currentPosition);
		Main.arm_k.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("ARM_K"));
			rideleteArm_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteArm_k_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteArm_k_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteAtl_k()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.atl_k.nr_key.getPosition());
		if (Main.atl_sUsed.equals(0)) {
			Winla_sf.checkopen(Main.atl_s,Clarion.newNumber(1));
		}
		Main.atl_sUsed.increment(1);
		ClarionFile.logout(2,Main.atl_k,Main.atl_s);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("ATL_K"));
			rideleteAtl_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.atl_k.nr_key.reget(currentPosition);
		if (Winla_rd.rideleteAtl_kAtl_s().boolValue()) {
			ClarionFile.rollback();
			rideleteAtl_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.atl_k.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("ATL_K"));
			rideleteAtl_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAtl_k_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAtl_k_riclosefiles()
	{
		Main.atl_sUsed.decrement(1);
		if (Main.atl_sUsed.equals(0)) {
			Main.atl_s.close();
		}
		return;
	}
	public static ClarionNumber rideleteAtl_s()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.atl_s.nr_key.getPosition());
		ClarionFile.logout(2,Main.atl_s);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("ATL_S"));
			rideleteAtl_s_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.atl_s.nr_key.reget(currentPosition);
		Main.atl_s.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("ATL_S"));
			rideleteAtl_s_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAtl_s_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAtl_s_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteAuto()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.auto.nr_key.getPosition());
		ClarionFile.logout(2,Main.auto);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("AUTO"));
			rideleteAuto_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.auto.nr_key.reget(currentPosition);
		Main.auto.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AUTO"));
			rideleteAuto_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAuto_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAuto_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteAutoapk()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.autoapk.pav_key.getPosition());
		if (Main.autodarbiUsed.equals(0)) {
			Winla_sf.checkopen(Main.autodarbi,Clarion.newNumber(1));
		}
		Main.autodarbiUsed.increment(1);
		if (Main.autotexUsed.equals(0)) {
			Winla_sf.checkopen(Main.autotex,Clarion.newNumber(1));
		}
		Main.autotexUsed.increment(1);
		ClarionFile.logout(2,Main.autoapk,Main.autodarbi,Main.autotex);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("AUTOAPK"));
			rideleteAutoapk_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.autoapk.pav_key.reget(currentPosition);
		if (Winla_rd.rideleteAutoapkAutodarbi().boolValue()) {
			ClarionFile.rollback();
			rideleteAutoapk_riclosefiles();
			return Clarion.newNumber(1);
		}
		if (Winla_rd.rideleteAutoapkAutotex().boolValue()) {
			ClarionFile.rollback();
			rideleteAutoapk_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.autoapk.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AUTOAPK"));
			rideleteAutoapk_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAutoapk_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAutoapk_riclosefiles()
	{
		Main.autodarbiUsed.decrement(1);
		if (Main.autodarbiUsed.equals(0)) {
			Main.autodarbi.close();
		}
		Main.autotexUsed.decrement(1);
		if (Main.autotexUsed.equals(0)) {
			Main.autotex.close();
		}
		return;
	}
	public static ClarionNumber rideleteAutoapk1()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.autoapk1.pav_key.getPosition());
		ClarionFile.logout(2,Main.autoapk1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("AUTOAPK1"));
			rideleteAutoapk1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.autoapk1.pav_key.reget(currentPosition);
		Main.autoapk1.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AUTOAPK1"));
			rideleteAutoapk1_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAutoapk1_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAutoapk1_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteAutodarbi()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.autodarbi.nr_key.getPosition());
		ClarionFile.logout(2,Main.autodarbi);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("AUTODARBI"));
			rideleteAutodarbi_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.autodarbi.nr_key.reget(currentPosition);
		Main.autodarbi.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AUTODARBI"));
			rideleteAutodarbi_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAutodarbi_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAutodarbi_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteAutodarbi1()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.autodarbi1.nr_key.getPosition());
		ClarionFile.logout(2,Main.autodarbi1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("AUTODARBI1"));
			rideleteAutodarbi1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.autodarbi1.nr_key.reget(currentPosition);
		Main.autodarbi1.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AUTODARBI1"));
			rideleteAutodarbi1_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAutodarbi1_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAutodarbi1_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteAutokra()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.autokra.kra_key.getPosition());
		ClarionFile.logout(2,Main.autokra);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("AUTOKRA"));
			rideleteAutokra_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.autokra.kra_key.reget(currentPosition);
		Main.autokra.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AUTOKRA"));
			rideleteAutokra_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAutokra_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAutokra_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteAutomarkas()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.automarkas.nr_key.getPosition());
		ClarionFile.logout(2,Main.automarkas);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("AUTOMARKAS"));
			rideleteAutomarkas_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.automarkas.nr_key.reget(currentPosition);
		Main.automarkas.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AUTOMARKAS"));
			rideleteAutomarkas_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAutomarkas_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAutomarkas_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteAutotex()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.autotex.nr_key.getPosition());
		ClarionFile.logout(2,Main.autotex);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("AUTOTEX"));
			rideleteAutotex_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.autotex.nr_key.reget(currentPosition);
		Main.autotex.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AUTOTEX"));
			rideleteAutotex_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAutotex_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAutotex_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteAu_bilde()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.au_bilde.dat_key.getPosition());
		ClarionFile.logout(2,Main.au_bilde);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("AU_BILDE"));
			rideleteAu_bilde_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.au_bilde.dat_key.reget(currentPosition);
		Main.au_bilde.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AU_BILDE"));
			rideleteAu_bilde_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAu_bilde_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAu_bilde_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteAu_tex()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.au_tex.aut_key.getPosition());
		ClarionFile.logout(2,Main.au_tex);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("AU_TEX"));
			rideleteAu_tex_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.au_tex.aut_key.reget(currentPosition);
		Main.au_tex.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AU_TEX"));
			rideleteAu_tex_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteAu_tex_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteAu_tex_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteBankas_k()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.bankas_k.kod_key.getPosition());
		ClarionFile.logout(2,Main.bankas_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("BANKAS_K"));
			rideleteBankas_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.bankas_k.kod_key.reget(currentPosition);
		Main.bankas_k.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("BANKAS_K"));
			rideleteBankas_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteBankas_k_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteBankas_k_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteB_pavad()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.b_pavad.getPosition());
		Main.b_pavad.reget(currentPosition);
		Main.b_pavad.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("B_PAVAD"));
			rideleteB_pavad_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			rideleteB_pavad_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteB_pavad_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteCal()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.cal.dat_key.getPosition());
		ClarionFile.logout(2,Main.cal);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("CAL"));
			rideleteCal_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.cal.dat_key.reget(currentPosition);
		Main.cal.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("CAL"));
			rideleteCal_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteCal_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteCal_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteCenuvest()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.cenuvest.kat_key.getPosition());
		ClarionFile.logout(2,Main.cenuvest);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("CENUVEST"));
			rideleteCenuvest_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.cenuvest.kat_key.reget(currentPosition);
		Main.cenuvest.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("CENUVEST"));
			rideleteCenuvest_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteCenuvest_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteCenuvest_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteConfig()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.config.nr_key.getPosition());
		ClarionFile.logout(2,Main.config);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("CONFIG"));
			rideleteConfig_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.config.nr_key.reget(currentPosition);
		Main.config.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("CONFIG"));
			rideleteConfig_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteConfig_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteConfig_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteCrossref()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.crossref.kat_key.getPosition());
		ClarionFile.logout(2,Main.crossref);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("CROSSREF"));
			rideleteCrossref_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.crossref.kat_key.reget(currentPosition);
		Main.crossref.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("CROSSREF"));
			rideleteCrossref_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteCrossref_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteCrossref_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteDaiev()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.daiev.kod_key.getPosition());
		ClarionFile.logout(2,Main.daiev);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("DAIEV"));
			rideleteDaiev_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.daiev.kod_key.reget(currentPosition);
		Main.daiev.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("DAIEV"));
			rideleteDaiev_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteDaiev_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteDaiev_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteEirokodi()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.eirokodi.keykods.getPosition());
		ClarionFile.logout(2,Main.eirokodi);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("EIROKODI"));
			rideleteEirokodi_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.eirokodi.keykods.reget(currentPosition);
		Main.eirokodi.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("EIROKODI"));
			rideleteEirokodi_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteEirokodi_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteEirokodi_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteFpnolik()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.fpnolik.nr_key.getPosition());
		ClarionFile.logout(2,Main.fpnolik);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("FPNOLIK"));
			rideleteFpnolik_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.fpnolik.nr_key.reget(currentPosition);
		Main.fpnolik.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("FPNOLIK"));
			rideleteFpnolik_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteFpnolik_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteFpnolik_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteFppavad()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.fppavad.nr_key.getPosition());
		if (Main.fpnolikUsed.equals(0)) {
			Winla_sf.checkopen(Main.fpnolik,Clarion.newNumber(1));
		}
		Main.fpnolikUsed.increment(1);
		ClarionFile.logout(2,Main.fppavad,Main.fpnolik);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("FPPAVAD"));
			rideleteFppavad_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.fppavad.nr_key.reget(currentPosition);
		if (Winla_rd.rideleteFppavadFpnolik().boolValue()) {
			ClarionFile.rollback();
			rideleteFppavad_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.fppavad.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("FPPAVAD"));
			rideleteFppavad_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteFppavad_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteFppavad_riclosefiles()
	{
		Main.fpnolikUsed.decrement(1);
		if (Main.fpnolikUsed.equals(0)) {
			Main.fpnolik.close();
		}
		return;
	}
	public static ClarionNumber rideleteG1()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.g1.nr_key.getPosition());
		ClarionFile.logout(2,Main.g1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("G1"));
			rideleteG1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.g1.nr_key.reget(currentPosition);
		Main.g1.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("G1"));
			rideleteG1_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteG1_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteG1_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteG2()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.g2.nr_key.getPosition());
		ClarionFile.logout(2,Main.g2);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("G2"));
			rideleteG2_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.g2.nr_key.reget(currentPosition);
		Main.g2.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("G2"));
			rideleteG2_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteG2_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteG2_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteGg()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.gg.nr_key.getPosition());
		if (Main.ggkUsed.equals(0)) {
			Winla_sf.checkopen(Main.ggk,Clarion.newNumber(1));
		}
		Main.ggkUsed.increment(1);
		ClarionFile.logout(2,Main.gg,Main.ggk);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("GG"));
			rideleteGg_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.gg.nr_key.reget(currentPosition);
		if (Winla_rd.rideleteGgGgk().boolValue()) {
			ClarionFile.rollback();
			rideleteGg_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.gg.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("GG"));
			rideleteGg_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteGg_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteGg_riclosefiles()
	{
		Main.ggkUsed.decrement(1);
		if (Main.ggkUsed.equals(0)) {
			Main.ggk.close();
		}
		return;
	}
	public static ClarionNumber rideleteGgk()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.ggk.nr_key.getPosition());
		ClarionFile.logout(2,Main.ggk);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("GGK"));
			rideleteGgk_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.ggk.nr_key.reget(currentPosition);
		Main.ggk.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("GGK"));
			rideleteGgk_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteGgk_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteGgk_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteGk1()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.gk1.nr_key.getPosition());
		ClarionFile.logout(2,Main.gk1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("GK1"));
			rideleteGk1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.gk1.nr_key.reget(currentPosition);
		Main.gk1.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("GK1"));
			rideleteGk1_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteGk1_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteGk1_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteGk2()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.gk2.nr_key.getPosition());
		ClarionFile.logout(2,Main.gk2);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("GK2"));
			rideleteGk2_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.gk2.nr_key.reget(currentPosition);
		Main.gk2.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("GK2"));
			rideleteGk2_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteGk2_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteGk2_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteGlobal()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.global.getPosition());
		ClarionFile.logout(2,Main.global);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("GLOBAL"));
			rideleteGlobal_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.global.reget(currentPosition);
		Main.global.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("GLOBAL"));
			rideleteGlobal_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteGlobal_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteGlobal_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteGrafiks()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.grafiks.ini_key.getPosition());
		ClarionFile.logout(2,Main.grafiks);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("GRAFIKS"));
			rideleteGrafiks_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.grafiks.ini_key.reget(currentPosition);
		Main.grafiks.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("GRAFIKS"));
			rideleteGrafiks_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteGrafiks_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteGrafiks_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteGrupa1()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.grupa1.gr1_key.getPosition());
		if (Main.grupa2Used.equals(0)) {
			Winla_sf.checkopen(Main.grupa2,Clarion.newNumber(1));
		}
		Main.grupa2Used.increment(1);
		ClarionFile.logout(2,Main.grupa1,Main.grupa2);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("GRUPA1"));
			rideleteGrupa1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.grupa1.gr1_key.reget(currentPosition);
		if (Winla_rd.rideleteGrupa1Grupa2().boolValue()) {
			ClarionFile.rollback();
			rideleteGrupa1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.grupa1.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("GRUPA1"));
			rideleteGrupa1_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteGrupa1_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteGrupa1_riclosefiles()
	{
		Main.grupa2Used.decrement(1);
		if (Main.grupa2Used.equals(0)) {
			Main.grupa2.close();
		}
		return;
	}
	public static ClarionNumber rideleteGrupa2()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.grupa2.gr1_key.getPosition());
		ClarionFile.logout(2,Main.grupa2);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("GRUPA2"));
			rideleteGrupa2_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.grupa2.gr1_key.reget(currentPosition);
		Main.grupa2.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("GRUPA2"));
			rideleteGrupa2_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteGrupa2_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteGrupa2_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteInvent()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.invent.nom_key.getPosition());
		ClarionFile.logout(2,Main.invent);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("INVENT"));
			rideleteInvent_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.invent.nom_key.reget(currentPosition);
		Main.invent.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("INVENT"));
			rideleteInvent_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteInvent_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteInvent_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteKadri()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.kadri.ini_key.getPosition());
		ClarionFile.logout(2,Main.kadri);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("KADRI"));
			rideleteKadri_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.kadri.ini_key.reget(currentPosition);
		Main.kadri.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("KADRI"));
			rideleteKadri_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteKadri_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteKadri_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteKad_rik()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.kad_rik.nr_key.getPosition());
		ClarionFile.logout(2,Main.kad_rik);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("KAD_RIK"));
			rideleteKad_rik_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.kad_rik.nr_key.reget(currentPosition);
		Main.kad_rik.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("KAD_RIK"));
			rideleteKad_rik_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteKad_rik_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteKad_rik_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteKat_k()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.kat_k.nr_key.getPosition());
		ClarionFile.logout(2,Main.kat_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("KAT_K"));
			rideleteKat_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.kat_k.nr_key.reget(currentPosition);
		Main.kat_k.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("KAT_K"));
			rideleteKat_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteKat_k_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteKat_k_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteKludas()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.kludas.nr_key.getPosition());
		ClarionFile.logout(2,Main.kludas);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("KLUDAS"));
			rideleteKludas_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.kludas.nr_key.reget(currentPosition);
		Main.kludas.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("KLUDAS"));
			rideleteKludas_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteKludas_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteKludas_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteKoivunen()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.koivunen.getPosition());
		Main.koivunen.reget(currentPosition);
		Main.koivunen.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("KOIVUNEN"));
			rideleteKoivunen_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			rideleteKoivunen_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteKoivunen_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteKomplekt()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.komplekt.nom_key.getPosition());
		ClarionFile.logout(2,Main.komplekt);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("KOMPLEKT"));
			rideleteKomplekt_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.komplekt.nom_key.reget(currentPosition);
		Main.komplekt.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("KOMPLEKT"));
			rideleteKomplekt_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteKomplekt_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteKomplekt_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteKon_k()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.kon_k.bkk_key.getPosition());
		ClarionFile.logout(2,Main.kon_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("KON_K"));
			rideleteKon_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.kon_k.bkk_key.reget(currentPosition);
		Main.kon_k.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("KON_K"));
			rideleteKon_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteKon_k_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteKon_k_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteKon_r()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.kon_r.ugp_key.getPosition());
		ClarionFile.logout(2,Main.kon_r);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("KON_R"));
			rideleteKon_r_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.kon_r.ugp_key.reget(currentPosition);
		Main.kon_r.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("KON_R"));
			rideleteKon_r_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteKon_r_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteKon_r_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteKursi_k()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.kursi_k.nos_key.getPosition());
		ClarionFile.logout(2,Main.kursi_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("KURSI_K"));
			rideleteKursi_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.kursi_k.nos_key.reget(currentPosition);
		Main.kursi_k.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("KURSI_K"));
			rideleteKursi_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteKursi_k_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteKursi_k_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteMer_k()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.mer_k.mer_key.getPosition());
		ClarionFile.logout(2,Main.mer_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("MER_K"));
			rideleteMer_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.mer_k.mer_key.reget(currentPosition);
		Main.mer_k.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("MER_K"));
			rideleteMer_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteMer_k_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteMer_k_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteNodalas()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.nodalas.nr_key.getPosition());
		ClarionFile.logout(2,Main.nodalas);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("NODALAS"));
			rideleteNodalas_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nodalas.nr_key.reget(currentPosition);
		Main.nodalas.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NODALAS"));
			rideleteNodalas_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteNodalas_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteNodalas_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteNoli1()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.noli1.nr_key.getPosition());
		ClarionFile.logout(2,Main.noli1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("NOLI1"));
			rideleteNoli1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.noli1.nr_key.reget(currentPosition);
		Main.noli1.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOLI1"));
			rideleteNoli1_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteNoli1_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteNoli1_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteNolik()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.nolik.nr_key.getPosition());
		ClarionFile.logout(2,Main.nolik);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("NOLIK"));
			rideleteNolik_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nolik.nr_key.reget(currentPosition);
		Main.nolik.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOLIK"));
			rideleteNolik_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteNolik_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteNolik_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteNolpas()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.nolpas.nr_key.getPosition());
		ClarionFile.logout(2,Main.nolpas);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("NOLPAS"));
			rideleteNolpas_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nolpas.nr_key.reget(currentPosition);
		Main.nolpas.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOLPAS"));
			rideleteNolpas_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteNolpas_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteNolpas_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteNol_fifo()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.nol_fifo.nr_key.getPosition());
		ClarionFile.logout(2,Main.nol_fifo);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("NOL_FIFO"));
			rideleteNol_fifo_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nol_fifo.nr_key.reget(currentPosition);
		Main.nol_fifo.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOL_FIFO"));
			rideleteNol_fifo_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteNol_fifo_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteNol_fifo_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteNol_kops()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.nol_kops.nr_key.getPosition());
		if (Main.nol_fifoUsed.equals(0)) {
			Winla_sf.checkopen(Main.nol_fifo,Clarion.newNumber(1));
		}
		Main.nol_fifoUsed.increment(1);
		ClarionFile.logout(2,Main.nol_kops,Main.nol_fifo);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("NOL_KOPS"));
			rideleteNol_kops_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nol_kops.nr_key.reget(currentPosition);
		if (Winla_rd.rideleteNol_kopsNol_fifo().boolValue()) {
			ClarionFile.rollback();
			rideleteNol_kops_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nol_kops.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOL_KOPS"));
			rideleteNol_kops_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteNol_kops_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteNol_kops_riclosefiles()
	{
		Main.nol_fifoUsed.decrement(1);
		if (Main.nol_fifoUsed.equals(0)) {
			Main.nol_fifo.close();
		}
		return;
	}
	public static ClarionNumber rideleteNol_stat()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.nol_stat.nom_key.getPosition());
		ClarionFile.logout(2,Main.nol_stat);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("NOL_STAT"));
			rideleteNol_stat_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nol_stat.nom_key.reget(currentPosition);
		Main.nol_stat.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOL_STAT"));
			rideleteNol_stat_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteNol_stat_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteNol_stat_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteNom_a()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.nom_a.nom_key.getPosition());
		ClarionFile.logout(2,Main.nom_a);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("NOM_A"));
			rideleteNom_a_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nom_a.nom_key.reget(currentPosition);
		Main.nom_a.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOM_A"));
			rideleteNom_a_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteNom_a_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteNom_a_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteNom_c()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.nom_c.nom_key.getPosition());
		ClarionFile.logout(2,Main.nom_c);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("NOM_C"));
			rideleteNom_c_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nom_c.nom_key.reget(currentPosition);
		Main.nom_c.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOM_C"));
			rideleteNom_c_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteNom_c_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteNom_c_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteNom_k()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.nom_k.nom_key.getPosition());
		if (Main.komplektUsed.equals(0)) {
			Winla_sf.checkopen(Main.komplekt,Clarion.newNumber(1));
		}
		Main.komplektUsed.increment(1);
		ClarionFile.logout(2,Main.nom_k,Main.komplekt);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("NOM_K"));
			rideleteNom_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nom_k.nom_key.reget(currentPosition);
		if (Winla_rd.rideleteNom_kKomplekt().boolValue()) {
			ClarionFile.rollback();
			rideleteNom_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nom_k.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOM_K"));
			rideleteNom_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteNom_k_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteNom_k_riclosefiles()
	{
		Main.komplektUsed.decrement(1);
		if (Main.komplektUsed.equals(0)) {
			Main.komplekt.close();
		}
		return;
	}
	public static ClarionNumber rideleteNom_k1()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.nom_k1.nom_key.getPosition());
		ClarionFile.logout(2,Main.nom_k1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("NOM_K1"));
			rideleteNom_k1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nom_k1.nom_key.reget(currentPosition);
		Main.nom_k1.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOM_K1"));
			rideleteNom_k1_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteNom_k1_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteNom_k1_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteNom_n()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.nom_n.kat_key.getPosition());
		ClarionFile.logout(2,Main.nom_n);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("NOM_N"));
			rideleteNom_n_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nom_n.kat_key.reget(currentPosition);
		Main.nom_n.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOM_N"));
			rideleteNom_n_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteNom_n_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteNom_n_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteNom_p()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.nom_p.nom_key.getPosition());
		ClarionFile.logout(2,Main.nom_p);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("NOM_P"));
			rideleteNom_p_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.nom_p.nom_key.reget(currentPosition);
		Main.nom_p.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOM_P"));
			rideleteNom_p_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteNom_p_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteNom_p_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteOutfile()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.outfile.getPosition());
		Main.outfile.reget(currentPosition);
		Main.outfile.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("OUTFILE"));
			rideleteOutfile_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			rideleteOutfile_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteOutfile_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteOutfileansi()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.outfileansi.getPosition());
		Main.outfileansi.reget(currentPosition);
		Main.outfileansi.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("OUTFILEANSI"));
			rideleteOutfileansi_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			rideleteOutfileansi_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteOutfileansi_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideletePamam()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.pamam.nr_key.getPosition());
		ClarionFile.logout(2,Main.pamam);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAMAM"));
			rideletePamam_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.pamam.nr_key.reget(currentPosition);
		Main.pamam.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAMAM"));
			rideletePamam_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePamam_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePamam_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideletePamat()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.pamat.dat_key.getPosition());
		if (Main.pamamUsed.equals(0)) {
			Winla_sf.checkopen(Main.pamam,Clarion.newNumber(1));
		}
		Main.pamamUsed.increment(1);
		ClarionFile.logout(2,Main.pamat,Main.pamam);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAMAT"));
			rideletePamat_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.pamat.dat_key.reget(currentPosition);
		if (Winla_rd.rideletePamatPamam().boolValue()) {
			ClarionFile.rollback();
			rideletePamat_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.pamat.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAMAT"));
			rideletePamat_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePamat_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePamat_riclosefiles()
	{
		Main.pamamUsed.decrement(1);
		if (Main.pamamUsed.equals(0)) {
			Main.pamam.close();
		}
		return;
	}
	public static ClarionNumber rideletePamkat()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.pamkat.getPosition());
		ClarionFile.logout(2,Main.pamkat);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAMKAT"));
			rideletePamkat_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.pamkat.reget(currentPosition);
		Main.pamkat.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAMKAT"));
			rideletePamkat_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePamkat_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePamkat_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideletePam_p()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.pam_p.nr_key.getPosition());
		ClarionFile.logout(2,Main.pam_p);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAM_P"));
			rideletePam_p_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.pam_p.nr_key.reget(currentPosition);
		Main.pam_p.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAM_P"));
			rideletePam_p_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePam_p_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePam_p_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteParoles()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.paroles.secure_key.getPosition());
		ClarionFile.logout(2,Main.paroles);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAROLES"));
			rideleteParoles_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.paroles.secure_key.reget(currentPosition);
		Main.paroles.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAROLES"));
			rideleteParoles_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteParoles_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteParoles_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideletePar_a()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.par_a.nr_key.getPosition());
		ClarionFile.logout(2,Main.par_a);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAR_A"));
			rideletePar_a_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.par_a.nr_key.reget(currentPosition);
		Main.par_a.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAR_A"));
			rideletePar_a_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePar_a_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePar_a_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideletePar_e()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.par_e.nr_key.getPosition());
		ClarionFile.logout(2,Main.par_e);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAR_E"));
			rideletePar_e_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.par_e.nr_key.reget(currentPosition);
		Main.par_e.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAR_E"));
			rideletePar_e_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePar_e_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePar_e_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideletePar_k()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.par_k.nr_key.getPosition());
		ClarionFile.logout(2,Main.par_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAR_K"));
			rideletePar_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.par_k.nr_key.reget(currentPosition);
		Main.par_k.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAR_K"));
			rideletePar_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePar_k_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePar_k_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideletePar_k1()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.par_k1.nr_key.getPosition());
		ClarionFile.logout(2,Main.par_k1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAR_K1"));
			rideletePar_k1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.par_k1.nr_key.reget(currentPosition);
		Main.par_k1.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAR_K1"));
			rideletePar_k1_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePar_k1_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePar_k1_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideletePar_l()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.par_l.nr_key.getPosition());
		ClarionFile.logout(2,Main.par_l);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAR_L"));
			rideletePar_l_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.par_l.nr_key.reget(currentPosition);
		Main.par_l.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAR_L"));
			rideletePar_l_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePar_l_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePar_l_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideletePar_z()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.par_z.nr_key.getPosition());
		ClarionFile.logout(2,Main.par_z);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAR_Z"));
			rideletePar_z_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.par_z.nr_key.reget(currentPosition);
		Main.par_z.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAR_Z"));
			rideletePar_z_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePar_z_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePar_z_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideletePava1()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.pava1.nr_key.getPosition());
		ClarionFile.logout(2,Main.pava1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAVA1"));
			rideletePava1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.pava1.nr_key.reget(currentPosition);
		Main.pava1.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAVA1"));
			rideletePava1_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePava1_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePava1_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideletePavad()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.pavad.nr_key.getPosition());
		if (Main.autoapkUsed.equals(0)) {
			Winla_sf.checkopen(Main.autoapk,Clarion.newNumber(1));
		}
		Main.autoapkUsed.increment(1);
		if (Main.autodarbiUsed.equals(0)) {
			Winla_sf.checkopen(Main.autodarbi,Clarion.newNumber(1));
		}
		Main.autodarbiUsed.increment(1);
		if (Main.autotexUsed.equals(0)) {
			Winla_sf.checkopen(Main.autotex,Clarion.newNumber(1));
		}
		Main.autotexUsed.increment(1);
		if (Main.nolikUsed.equals(0)) {
			Winla_sf.checkopen(Main.nolik,Clarion.newNumber(1));
		}
		Main.nolikUsed.increment(1);
		ClarionFile.logout(2,Main.pavad,Main.autoapk,Main.autodarbi,Main.autotex,Main.nolik);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAVAD"));
			rideletePavad_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.pavad.nr_key.reget(currentPosition);
		if (Winla_rd.rideletePavadAutoapk().boolValue()) {
			ClarionFile.rollback();
			rideletePavad_riclosefiles();
			return Clarion.newNumber(1);
		}
		if (Winla_rd.rideletePavadAutotex().boolValue()) {
			ClarionFile.rollback();
			rideletePavad_riclosefiles();
			return Clarion.newNumber(1);
		}
		if (Winla_rd.rideletePavadNolik().boolValue()) {
			ClarionFile.rollback();
			rideletePavad_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.pavad.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAVAD"));
			rideletePavad_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePavad_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePavad_riclosefiles()
	{
		Main.autoapkUsed.decrement(1);
		if (Main.autoapkUsed.equals(0)) {
			Main.autoapk.close();
		}
		Main.autodarbiUsed.decrement(1);
		if (Main.autodarbiUsed.equals(0)) {
			Main.autodarbi.close();
		}
		Main.autotexUsed.decrement(1);
		if (Main.autotexUsed.equals(0)) {
			Main.autotex.close();
		}
		Main.nolikUsed.decrement(1);
		if (Main.nolikUsed.equals(0)) {
			Main.nolik.close();
		}
		return;
	}
	public static ClarionNumber rideletePavpas()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.pavpas.nr_key.getPosition());
		if (Main.nolpasUsed.equals(0)) {
			Winla_sf.checkopen(Main.nolpas,Clarion.newNumber(1));
		}
		Main.nolpasUsed.increment(1);
		ClarionFile.logout(2,Main.pavpas,Main.nolpas);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PAVPAS"));
			rideletePavpas_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.pavpas.nr_key.reget(currentPosition);
		if (Winla_rd.rideletePavpasNolpas().boolValue()) {
			ClarionFile.rollback();
			rideletePavpas_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.pavpas.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAVPAS"));
			rideletePavpas_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePavpas_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePavpas_riclosefiles()
	{
		Main.nolpasUsed.decrement(1);
		if (Main.nolpasUsed.equals(0)) {
			Main.nolpas.close();
		}
		return;
	}
	public static ClarionNumber rideletePernos()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.pernos.id_key.getPosition());
		ClarionFile.logout(2,Main.pernos);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PERNOS"));
			rideletePernos_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.pernos.id_key.reget(currentPosition);
		Main.pernos.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PERNOS"));
			rideletePernos_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideletePernos_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideletePernos_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteProjekti()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.projekti.nr_key.getPosition());
		ClarionFile.logout(2,Main.projekti);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PROJEKTI"));
			rideleteProjekti_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.projekti.nr_key.reget(currentPosition);
		Main.projekti.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PROJEKTI"));
			rideleteProjekti_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteProjekti_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteProjekti_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteProj_p()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.proj_p.nr_key.getPosition());
		ClarionFile.logout(2,Main.proj_p);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("PROJ_P"));
			rideleteProj_p_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.proj_p.nr_key.reget(currentPosition);
		Main.proj_p.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PROJ_P"));
			rideleteProj_p_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteProj_p_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteProj_p_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteSystem()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.system.nr_key.getPosition());
		ClarionFile.logout(2,Main.system);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("SYSTEM"));
			rideleteSystem_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.system.nr_key.reget(currentPosition);
		Main.system.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("SYSTEM"));
			rideleteSystem_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteSystem_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteSystem_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteTeksti()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.teksti.nr_key.getPosition());
		ClarionFile.logout(2,Main.teksti);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("TEKSTI"));
			rideleteTeksti_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.teksti.nr_key.reget(currentPosition);
		Main.teksti.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("TEKSTI"));
			rideleteTeksti_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteTeksti_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteTeksti_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteTeksti1()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.teksti1.nr_key.getPosition());
		ClarionFile.logout(2,Main.teksti1);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("TEKSTI1"));
			rideleteTeksti1_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.teksti1.nr_key.reget(currentPosition);
		Main.teksti1.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("TEKSTI1"));
			rideleteTeksti1_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteTeksti1_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteTeksti1_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteTek_k()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.tek_k.nr_key.getPosition());
		ClarionFile.logout(2,Main.tek_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("TEK_K"));
			rideleteTek_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.tek_k.nr_key.reget(currentPosition);
		Main.tek_k.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("TEK_K"));
			rideleteTek_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteTek_k_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteTek_k_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteTek_ser()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.tek_ser.nos_key.getPosition());
		ClarionFile.logout(2,Main.tek_ser);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("TEK_SER"));
			rideleteTek_ser_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.tek_ser.nos_key.reget(currentPosition);
		Main.tek_ser.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("TEK_SER"));
			rideleteTek_ser_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteTek_ser_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteTek_ser_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteVal_k()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.val_k.nos_key.getPosition());
		ClarionFile.logout(2,Main.val_k);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("VAL_K"));
			rideleteVal_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.val_k.nos_key.reget(currentPosition);
		Main.val_k.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("VAL_K"));
			rideleteVal_k_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteVal_k_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteVal_k_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteVesture()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.vesture.crm_key.getPosition());
		ClarionFile.logout(2,Main.vesture);
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.LOGOUTERROR),Clarion.newString("Delete"),Clarion.newString("VESTURE"));
			rideleteVesture_riclosefiles();
			return Clarion.newNumber(1);
		}
		Main.vesture.crm_key.reget(currentPosition);
		Main.vesture.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("VESTURE"));
			rideleteVesture_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			ClarionFile.commit();
			rideleteVesture_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteVesture_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteZurfile()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.zurfile.getPosition());
		Main.zurfile.reget(currentPosition);
		Main.zurfile.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("ZURFILE"));
			rideleteZurfile_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			rideleteZurfile_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteZurfile_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteZurnals()
	{
		ClarionString currentPosition=Clarion.newString(512);
		currentPosition.setValue(Main.zurnals.getPosition());
		Main.zurnals.reget(currentPosition);
		Main.zurnals.delete();
		if (CError.errorCode()!=0) {
			Winla_sf.risaveerror();
			Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("ZURNALS"));
			rideleteZurnals_riclosefiles();
			return Clarion.newNumber(1);
		}
		else {
			rideleteZurnals_riclosefiles();
			return Clarion.newNumber(0);
		}
	}
	public static void rideleteZurnals_riclosefiles()
	{
		return;
	}
	public static ClarionNumber rideleteAlgpaAlgas()
	{
		Main.algas.clear(0);
		Main.algas.yyyymm.setValue(Main.algpa.yyyymm);
		Main.algas.id.clear(-1);
		Main.algas.id_key.set(Main.algas.id_key);
		while (true) {
			Main.algas.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("ALGAS"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.algpa.yyyymm.equals(Main.algas.yyyymm)) {
				return Clarion.newNumber(0);
			}
			Main.algas.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("ALGAS"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber rideleteAtl_kAtl_s()
	{
		Main.atl_s.clear(0);
		Main.atl_s.u_nr.setValue(Main.atl_k.u_nr);
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
			if (!Main.atl_k.u_nr.equals(Main.atl_s.u_nr)) {
				return Clarion.newNumber(0);
			}
			Main.atl_s.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("ATL_S"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber rideleteAutoapkAutodarbi()
	{
		Main.autodarbi.clear(0);
		Main.autodarbi.pav_nr.setValue(Main.autoapk.pav_nr);
		Main.autodarbi.nr_key.set(Main.autodarbi.nr_key);
		while (true) {
			Main.autodarbi.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("AUTODARBI"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.autoapk.pav_nr.equals(Main.autodarbi.pav_nr)) {
				return Clarion.newNumber(0);
			}
			Main.autodarbi.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AUTODARBI"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber rideleteAutoapkAutotex()
	{
		Main.autotex.clear(0);
		Main.autotex.pav_nr.setValue(Main.autoapk.pav_nr);
		Main.autotex.nr_key.set(Main.autotex.nr_key);
		while (true) {
			Main.autotex.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("AUTOTEX"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.autoapk.pav_nr.equals(Main.autotex.pav_nr)) {
				return Clarion.newNumber(0);
			}
			Main.autotex.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AUTOTEX"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber rideleteFppavadFpnolik()
	{
		Main.fpnolik.clear(0);
		Main.fpnolik.u_nr.setValue(Main.fppavad.u_nr);
		Main.fpnolik.seciba.clear(1);
		Main.fpnolik.nr_key.set(Main.fpnolik.nr_key);
		while (true) {
			Main.fpnolik.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("FPNOLIK"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.fppavad.u_nr.equals(Main.fpnolik.u_nr)) {
				return Clarion.newNumber(0);
			}
			Main.fpnolik.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("FPNOLIK"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber rideleteGgGgk()
	{
		Main.ggk.clear(0);
		Main.ggk.u_nr.setValue(Main.gg.u_nr);
		Main.ggk.bkk.clear(-1);
		Main.ggk.nr_key.set(Main.ggk.nr_key);
		while (true) {
			Main.ggk.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("GGK"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.gg.u_nr.equals(Main.ggk.u_nr)) {
				return Clarion.newNumber(0);
			}
			Main.ggk.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("GGK"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber rideleteGrupa1Grupa2()
	{
		Main.grupa2.clear(0);
		Main.grupa2.grupa1.setValue(Main.grupa1.grupa1);
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
			if (!Main.grupa1.grupa1.equals(Main.grupa2.grupa1)) {
				return Clarion.newNumber(0);
			}
			Main.grupa2.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("GRUPA2"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber rideleteNol_kopsNol_fifo()
	{
		Main.nol_fifo.clear(0);
		Main.nol_fifo.u_nr.setValue(Main.nol_kops.u_nr);
		Main.nol_fifo.datums.clear(-1);
		Main.nol_fifo.d_k.clear(-1);
		Main.nol_fifo.nr_key.set(Main.nol_fifo.nr_key);
		while (true) {
			Main.nol_fifo.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("NOL_FIFO"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.nol_kops.u_nr.equals(Main.nol_fifo.u_nr)) {
				return Clarion.newNumber(0);
			}
			Main.nol_fifo.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOL_FIFO"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber rideleteNom_kKomplekt()
	{
		Main.komplekt.clear(0);
		Main.komplekt.nomenklat.setValue(Main.nom_k.nomenklat);
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
			if (!Main.nom_k.nomenklat.equals(Main.komplekt.nomenklat)) {
				return Clarion.newNumber(0);
			}
			Main.komplekt.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("KOMPLEKT"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber rideletePamatPamam()
	{
		Main.pamam.clear(0);
		Main.pamam.u_nr.setValue(Main.pamat.u_nr);
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
			if (!Main.pamat.u_nr.equals(Main.pamam.u_nr)) {
				return Clarion.newNumber(0);
			}
			Main.pamam.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("PAMAM"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber rideletePavadAutoapk()
	{
		Main.autoapk.clear(0);
		Main.autoapk.pav_nr.setValue(Main.pavad.u_nr);
		Main.autoapk.pav_key.set(Main.autoapk.pav_key);
		while (true) {
			Main.autoapk.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("AUTOAPK"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.pavad.u_nr.equals(Main.autoapk.pav_nr)) {
				return Clarion.newNumber(0);
			}
			if (Winla_rd.rideleteAutoapkAutodarbi().boolValue()) {
				return Clarion.newNumber(1);
			}
			if (Winla_rd.rideleteAutoapkAutotex().boolValue()) {
				return Clarion.newNumber(1);
			}
			Main.autoapk.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AUTOAPK"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber rideletePavadAutotex()
	{
		Main.autotex.clear(0);
		Main.autotex.pav_nr.setValue(Main.pavad.u_nr);
		Main.autotex.nr_key.set(Main.autotex.nr_key);
		while (true) {
			Main.autotex.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("AUTOTEX"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.pavad.u_nr.equals(Main.autotex.pav_nr)) {
				return Clarion.newNumber(0);
			}
			Main.autotex.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("AUTOTEX"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber rideletePavadNolik()
	{
		Main.nolik.clear(0);
		Main.nolik.u_nr.setValue(Main.pavad.u_nr);
		Main.nolik.nomenklat.clear(-1);
		Main.nolik.nr_key.set(Main.nolik.nr_key);
		while (true) {
			Main.nolik.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("NOLIK"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.pavad.u_nr.equals(Main.nolik.u_nr)) {
				return Clarion.newNumber(0);
			}
			Main.nolik.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOLIK"));
				return Clarion.newNumber(1);
			}
		}
	}
	public static ClarionNumber rideletePavpasNolpas()
	{
		Main.nolpas.clear(0);
		Main.nolpas.u_nr.setValue(Main.pavpas.u_nr);
		Main.nolpas.nomenklat.clear(-1);
		Main.nolpas.nr_key.set(Main.nolpas.nr_key);
		while (true) {
			Main.nolpas.next();
			if (CError.errorCode()!=0) {
				if (CError.errorCode()==Constants.BADRECERR) {
					return Clarion.newNumber(0);
				}
				else {
					Winla_sf.risaveerror();
					Winla_sf.standardwarning(Clarion.newNumber(Warn.RECORDFETCHERROR),Clarion.newString("NOLPAS"));
					return Clarion.newNumber(1);
				}
			}
			if (!Main.pavpas.u_nr.equals(Main.nolpas.u_nr)) {
				return Clarion.newNumber(0);
			}
			Main.nolpas.delete();
			if (CError.errorCode()!=0) {
				Winla_sf.risaveerror();
				Winla_sf.standardwarning(Clarion.newNumber(Warn.RIDELETEERROR),Clarion.newString("NOLPAS"));
				return Clarion.newNumber(1);
			}
		}
	}
}
