package clarion.winla048;

import clarion.Main;
import clarion.equates.Constants;
import clarion.equates.Ff_;
import clarion.winla043.Winla043;
import clarion.winla048.Dosfiles;
import clarion.winla_sf.Winla_sf;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CFile;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class Winla048
{

	public static ClarionString getval_k(ClarionString valval,ClarionNumber req)
	{
		if (valval.equals("") && !req.boolValue()) {
			System.out.println("GETVAL_K empty args_1");
			return Clarion.newString("");
		}
		else if (valval.boolValue() || req.boolValue()) {
			if (Main.val_kUsed.equals(0)) {
				Winla_sf.checkopen(Main.val_k,Clarion.newNumber(1));
			}
			Main.val_kUsed.increment(1);
			Main.val_k.clear();
			Main.val_k.val.setValue(valval);
			Main.val_k.get(Main.val_k.nos_key);
			if (CError.errorCode()!=0) {
				System.out.println("GETVAL_K error_1 "+CError.errorCode()+CError.error().toString());
				if (req.equals(2)) {
					Winla043.kluda(Clarion.newNumber(14),valval.like());
					Main.val_k.clear();
				}
				else if (req.equals(1)) {
					Main.globalrequest.setValue(Constants.SELECTRECORD);
					if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
					}
					else {
						Main.val_k.clear();
					}
				}
				else {
					Main.val_k.clear();
				}
			}
			Main.val_kUsed.decrement(1);
			if (Main.val_kUsed.equals(0)) {
				Main.val_k.close();
			}
		}
		else {
			System.out.println("GETVAL_K empty args_2");
			return Clarion.newString("");
		}
		System.out.println("GETVAL_K normal return "+Main.val_k.val.toString());
		return Main.val_k.val.like();
	}
	public static ClarionNumber dos_cont(ClarionString p0,ClarionNumber p1)
	{
		return dos_cont(p0,p1,(ClarionNumber)null);
	}
	public static ClarionNumber dos_cont(ClarionString dos_name,ClarionNumber ret,ClarionNumber new_nr)
	{
		Dosfiles dosfiles=new Dosfiles();
		ClarionNumber _r_number=Clarion.newNumber();
		ClarionNumber _i_number=Clarion.newNumber();
		CFile.getDirectoryListing(dosfiles,dos_name.toString(),Ff_.NORMAL);
		if (CError.error().length()!=0) {
			return Clarion.newNumber(0);
		}
		{
			int execute_1=ret.intValue();
			if (execute_1==1) {
				if (dosfiles.records()==0) {
					dosfiles.date.setValue(0);
					Main.a_time.setValue(0);
				}
				else {
					dosfiles.sort(dosfiles.ORDER().descend(dosfiles.date));
					dosfiles.get(1);
					Main.a_time.setValue(dosfiles.time);
				}
				dosfiles.free();
				return dosfiles.date.like();
			}
			if (execute_1==2) {
				_r_number.setValue(dosfiles.records());
				dosfiles.free();
				return _r_number.like();
			}
			if (execute_1==3) {
				if (dosfiles.records()!=0) {
					final int loop_1=dosfiles.records();for (_i_number.setValue(1);_i_number.compareTo(loop_1)<=0;_i_number.increment(1)) {
						dosfiles.get(_i_number);
						Main.filename1.setValue(Main.docfolderk.concat("\\",dosfiles.name));
						Main.filename2.setValue(Main.docfolderk.concat("\\",new_nr.getString().format("@N04"),dosfiles.name.stringAt(5,dosfiles.name.clip().len())));
						if (CError.error().length()!=0) {
							return Clarion.newNumber(1);
						}
					}
				}
				dosfiles.free();
				return Clarion.newNumber(0);
			}
		}
		return Clarion.newNumber();
	}
	public static ClarionString getbankas_k(ClarionString ban_kods,ClarionNumber req,ClarionNumber ret)
	{
		if (!CRun.inRange(ret,Clarion.newNumber(1),Clarion.newNumber(2))) {
			return Clarion.newString("");
		}
		if (ban_kods.boolValue() || req.boolValue()) {
			if (Main.bankas_kUsed.equals(0)) {
				Winla_sf.checkopen(Main.bankas_k,Clarion.newNumber(1));
			}
			Main.bankas_kUsed.increment(1);
			Main.bankas_k.clear();
			Main.bankas_k.kods.setValue(ban_kods);
			Main.bankas_k.get(Main.bankas_k.kod_key);
			if (CError.error().length()!=0) {
				if (req.equals(2)) {
					Winla043.kluda(Clarion.newNumber(17),Clarion.newString(ClarionString.staticConcat("Bankas kods:",ban_kods)));
				}
				else if (req.equals(1)) {
					Main.globalrequest.setValue(Constants.SELECTRECORD);
					if (!Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
						Main.bankas_k.clear();
					}
				}
				else {
					Main.bankas_k.clear();
				}
			}
			Main.bankas_kUsed.decrement(1);
			if (Main.bankas_kUsed.equals(0)) {
				Main.bankas_k.close();
			}
		}
		else {
			return Clarion.newString("");
		}
		{
			int execute_1=ret.intValue();
			if (execute_1==1) {
				return Main.bankas_k.nos_p.like();
			}
			if (execute_1==2) {
				return Main.bankas_k.maksajuma_taka.like();
			}
		}
		return Clarion.newString();
	}
}
