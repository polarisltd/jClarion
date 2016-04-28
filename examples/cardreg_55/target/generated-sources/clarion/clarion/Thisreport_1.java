package clarion;

import clarion.Main;
import clarion.Processclass;
import clarion.Report_1;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Thisreport_1 extends Processclass
{
	Report_1 report;
	public Thisreport_1(Report_1 report)
	{
		this.report=report;
	}

	public ClarionNumber takeRecord()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipDetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		{
			ClarionString case_1=Main.transactions.transactionType;
			boolean case_1_break=false;
			if (case_1.equals("P")) {
				Main.gLOTransactionTypeDescription.setValue("Pmt/Credit");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("C")) {
				Main.gLOTransactionTypeDescription.setValue("Charge");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("F")) {
				Main.gLOTransactionTypeDescription.setValue("Fee");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("I")) {
				Main.gLOTransactionTypeDescription.setValue("Interest");
				case_1_break=true;
			}
			if (!case_1_break) {
				Main.gLOTransactionTypeDescription.setValue("Cash Adv");
			}
		}
		returnValue.setValue(super.takeRecord());
		report.detail.print();
		return returnValue.like();
	}
}
