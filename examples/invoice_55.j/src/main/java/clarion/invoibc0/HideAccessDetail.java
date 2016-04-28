package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Filemanager;
import clarion.equates.Level;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class HideAccessDetail extends Filemanager
{
	public HideAccessDetail()
	{
	}

	public void init()
	{
		this.init(Main.detail,Main.globalerrors);
		this.filenamevalue.setValue("Detail");
		this.buffer=Main.detail;
		this.lockrecover.setValue(10);
		this.addkey(Main.detail.keydetails,Clarion.newString("DTL:KeyDetails"),Clarion.newNumber(3));
		Main.accessDetail=this;
	}
	public void kill()
	{
		super.kill();
		Main.accessDetail=null;
	}
	public ClarionNumber validatefieldserver(ClarionNumber id,ClarionNumber handleerrors)
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber saveProducts4=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		returnvalue.setValue(super.validatefieldserver(id.like(),handleerrors.like()));
		{
			ClarionNumber case_1=id;
			boolean case_1_break=false;
			if (case_1.equals(3)) {
				Main.globalerrors.setfield(Clarion.newString("Line number"));
				if (!CRun.inRange(Main.detail.linenumber,Clarion.newNumber(1),Clarion.newDecimal("99999.99"))) {
					returnvalue.setValue(Level.NOTIFY);
				}
				if (!returnvalue.equals(Level.BENIGN)) {
					if (handleerrors.boolValue()) {
						returnvalue.setValue(Main.globalerrors.throwmessage(Clarion.newNumber(Msg.FIELDOUTOFRANGE),Clarion.newString("1 .. 99999.99")));
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(4)) {
				Main.globalerrors.setfield(Clarion.newString("Product Identification Number"));
				saveProducts4.setValue(Main.accessProducts.savefile());
				Main.products.productnumber.setValue(Main.detail.productnumber);
				returnvalue.setValue(Main.accessProducts.tryfetch(Main.products.keyproductnumber));
				if (!returnvalue.equals(Level.BENIGN)) {
					if (handleerrors.boolValue()) {
						returnvalue.setValue(Main.globalerrors.throwmessage(Clarion.newNumber(Msg.FIELDNOTINFILE),Clarion.newString("Products")));
					}
				}
				Main.accessProducts.restorefile(saveProducts4);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(5)) {
				Main.globalerrors.setfield(Clarion.newString("Quantity of product ordered"));
				if (!CRun.inRange(Main.detail.quantityordered,Clarion.newNumber(1),Clarion.newNumber(99999))) {
					returnvalue.setValue(Level.NOTIFY);
				}
				if (!returnvalue.equals(Level.BENIGN)) {
					if (handleerrors.boolValue()) {
						returnvalue.setValue(Main.globalerrors.throwmessage(Clarion.newNumber(Msg.FIELDOUTOFRANGE),Clarion.newString("1 .. 99999")));
					}
				}
				case_1_break=true;
			}
		}
		return returnvalue.like();
	}
}
