package clarion;

import clarion.Filemanager;
import clarion.Main;
import clarion.equates.Level;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CDate;

public class HideAccessInvhist extends Filemanager
{
	public HideAccessInvhist()
	{
	}

	public void init()
	{
		this.init(Main.invHist,Main.globalErrors);
		this.fileNameValue.setValue("InvHist");
		this.buffer=Main.invHist;
		this.lockRecover.setValue(10);
		this.addKey(Main.invHist.keyProductNumberDate,Clarion.newString("INV:KeyProductNumberDate"),Clarion.newNumber(0));
		this.addKey(Main.invHist.keyProdNumberDate,Clarion.newString("INV:KeyProdNumberDate"),Clarion.newNumber(0));
		this.addKey(Main.invHist.keyVendorNumberDate,Clarion.newString("INV:KeyVendorNumberDate"),Clarion.newNumber(0));
		Main.accessInvHist.set(this);
	}
	public void kill()
	{
		super.kill();
		Main.accessInvHist.set(null);
	}
	public void primeFields()
	{
		Main.invHist.date.setValue(CDate.today());
		super.primeFields();
	}
	public ClarionNumber validateFieldServer(ClarionNumber id,ClarionNumber handleErrors)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber saveProducts3=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		returnValue.setValue(super.validateFieldServer(id.like(),handleErrors.like()));
		{
			ClarionNumber case_1=id;
			if (case_1.equals(3)) {
				Main.globalErrors.setField(Clarion.newString("Product Identification Number"));
				saveProducts3.setValue(Main.accessProducts.get().saveFile());
				Main.products.productNumber.setValue(Main.invHist.productNumber);
				returnValue.setValue(Main.accessProducts.get().tryFetch(Main.products.keyProductNumber));
				if (!returnValue.equals(Level.BENIGN)) {
					if (handleErrors.boolValue()) {
						returnValue.setValue(Main.globalErrors.throwMessage(Clarion.newNumber(Msg.FIELDNOTINFILE),Clarion.newString("Products")));
					}
				}
				Main.accessProducts.get().restoreFile(saveProducts3);
			}
		}
		return returnValue.like();
	}
}
