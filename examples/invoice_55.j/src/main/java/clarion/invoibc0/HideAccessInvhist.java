package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Filemanager;
import clarion.equates.Level;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CDate;

@SuppressWarnings("all")
public class HideAccessInvhist extends Filemanager
{
	public HideAccessInvhist()
	{
	}

	public void init()
	{
		this.init(Main.invhist,Main.globalerrors);
		this.filenamevalue.setValue("InvHist");
		this.buffer=Main.invhist;
		this.lockrecover.setValue(10);
		this.addkey(Main.invhist.keyproductnumberdate,Clarion.newString("INV:KeyProductNumberDate"),Clarion.newNumber(0));
		this.addkey(Main.invhist.keyprodnumberdate,Clarion.newString("INV:KeyProdNumberDate"),Clarion.newNumber(0));
		this.addkey(Main.invhist.keyvendornumberdate,Clarion.newString("INV:KeyVendorNumberDate"),Clarion.newNumber(0));
		Main.accessInvhist=this;
	}
	public void kill()
	{
		super.kill();
		Main.accessInvhist=null;
	}
	public void primefields()
	{
		Main.invhist.date.setValue(CDate.today());
		super.primefields();
	}
	public ClarionNumber validatefieldserver(ClarionNumber id,ClarionNumber handleerrors)
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber saveProducts3=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		returnvalue.setValue(super.validatefieldserver(id.like(),handleerrors.like()));
		{
			ClarionNumber case_1=id;
			if (case_1.equals(3)) {
				Main.globalerrors.setfield(Clarion.newString("Product Identification Number"));
				saveProducts3.setValue(Main.accessProducts.savefile());
				Main.products.productnumber.setValue(Main.invhist.productnumber);
				returnvalue.setValue(Main.accessProducts.tryfetch(Main.products.keyproductnumber));
				if (!returnvalue.equals(Level.BENIGN)) {
					if (handleerrors.boolValue()) {
						returnvalue.setValue(Main.globalerrors.throwmessage(Clarion.newNumber(Msg.FIELDNOTINFILE),Clarion.newString("Products")));
					}
				}
				Main.accessProducts.restorefile(saveProducts3);
			}
		}
		return returnvalue.like();
	}
}
