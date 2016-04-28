package clarion;

import clarion.Filemanager;
import clarion.Main;
import clarion.equates.Level;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CRun;

public class HideAccessDetail extends Filemanager
{
	public HideAccessDetail()
	{
	}

	public void init()
	{
		this.init(Main.detail,Main.globalErrors);
		this.fileNameValue.setValue("Detail");
		this.buffer=Main.detail;
		this.lockRecover.setValue(10);
		this.addKey(Main.detail.keyDetails,Clarion.newString("DTL:KeyDetails"),Clarion.newNumber(3));
		Main.accessDetail.set(this);
	}
	public void kill()
	{
		super.kill();
		Main.accessDetail.set(null);
	}
	public ClarionNumber validateFieldServer(ClarionNumber id,ClarionNumber handleErrors)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber saveProducts4=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		returnValue.setValue(super.validateFieldServer(id.like(),handleErrors.like()));
		{
			ClarionNumber case_1=id;
			boolean case_1_break=false;
			if (case_1.equals(3)) {
				Main.globalErrors.setField(Clarion.newString("Line number"));
				if (!CRun.inRange(Main.detail.lineNumber,Clarion.newNumber(1),Clarion.newDecimal("99999.99"))) {
					returnValue.setValue(Level.NOTIFY);
				}
				if (!returnValue.equals(Level.BENIGN)) {
					if (handleErrors.boolValue()) {
						returnValue.setValue(Main.globalErrors.throwMessage(Clarion.newNumber(Msg.FIELDOUTOFRANGE),Clarion.newString("1 .. 99999.99")));
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(4)) {
				Main.globalErrors.setField(Clarion.newString("Product Identification Number"));
				saveProducts4.setValue(Main.accessProducts.get().saveFile());
				Main.products.productNumber.setValue(Main.detail.productNumber);
				returnValue.setValue(Main.accessProducts.get().tryFetch(Main.products.keyProductNumber));
				if (!returnValue.equals(Level.BENIGN)) {
					if (handleErrors.boolValue()) {
						returnValue.setValue(Main.globalErrors.throwMessage(Clarion.newNumber(Msg.FIELDNOTINFILE),Clarion.newString("Products")));
					}
				}
				Main.accessProducts.get().restoreFile(saveProducts4);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(5)) {
				Main.globalErrors.setField(Clarion.newString("Quantity of product ordered"));
				if (!CRun.inRange(Main.detail.quantityOrdered,Clarion.newNumber(1),Clarion.newNumber(99999))) {
					returnValue.setValue(Level.NOTIFY);
				}
				if (!returnValue.equals(Level.BENIGN)) {
					if (handleErrors.boolValue()) {
						returnValue.setValue(Main.globalErrors.throwMessage(Clarion.newNumber(Msg.FIELDOUTOFRANGE),Clarion.newString("1 .. 99999")));
					}
				}
				case_1_break=true;
			}
		}
		return returnValue.like();
	}
}
