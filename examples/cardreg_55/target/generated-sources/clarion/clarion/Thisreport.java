package clarion;

import clarion.Main;
import clarion.Processclass;
import clarion.Report;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Thisreport extends Processclass
{
	ClarionString lOCCardType;
	ClarionString lOCOrdinalExtension;
	ClarionString lOCCityStateZip;
	ClarionDecimal lOCAvailableFunds;
	Report report;
	public Thisreport(ClarionString lOCCardType,ClarionString lOCOrdinalExtension,ClarionString lOCCityStateZip,ClarionDecimal lOCAvailableFunds,Report report)
	{
		this.lOCCardType=lOCCardType;
		this.lOCOrdinalExtension=lOCOrdinalExtension;
		this.lOCCityStateZip=lOCCityStateZip;
		this.lOCAvailableFunds=lOCAvailableFunds;
		this.report=report;
	}

	public ClarionNumber takeRecord()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipDetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		{
			ClarionString case_1=Main.accounts.cardType;
			boolean case_1_break=false;
			if (case_1.equals("V")) {
				lOCCardType.setValue("Visa Account");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("M")) {
				lOCCardType.setValue("Master Card Account");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("D")) {
				lOCCardType.setValue("Discover Card Account");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("A")) {
				lOCCardType.setValue("American Express Account");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("S")) {
				lOCCardType.setValue("Store Account");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("G")) {
				lOCCardType.setValue("Gasoline Account");
				case_1_break=true;
			}
			if (!case_1_break) {
				lOCCardType.setValue("Other Account");
			}
		}
		{
			ClarionNumber case_2=Main.accounts.billingDay;
			boolean case_2_break=false;
			if (case_2.equals("1")) {
				lOCOrdinalExtension.setValue("st");
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals("2")) {
				lOCOrdinalExtension.setValue("nd");
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals("3")) {
				lOCOrdinalExtension.setValue("rd");
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals("21")) {
				lOCOrdinalExtension.setValue("st");
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals("22")) {
				lOCOrdinalExtension.setValue("nd");
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals("23")) {
				lOCOrdinalExtension.setValue("rd");
				case_2_break=true;
			}
			if (!case_2_break) {
				lOCOrdinalExtension.setValue("th");
			}
		}
		lOCCityStateZip.setValue(Main.accounts.vendorCity.clip().concat(", ",Main.accounts.vendorState,"   ",Main.accounts.vendorZip));
		lOCAvailableFunds.setValue(Main.accounts.creditLimit.subtract(Main.accounts.accountBalance));
		returnValue.setValue(super.takeRecord());
		report.detail.print();
		return returnValue.like();
	}
}
