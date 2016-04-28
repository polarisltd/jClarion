package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Kon_k extends ClarionSQLFile
{
	public ClarionString bkk=Clarion.newString(5);
	public ClarionString alt_bkk=Clarion.newString(6);
	public ClarionString nosaukums=Clarion.newString(95);
	public ClarionString nosaukumsa=Clarion.newString(95);
	public ClarionString val=Clarion.newString(3);
	public ClarionArray<ClarionNumber> pvnd=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(2);
	public ClarionArray<ClarionNumber> pvnk=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(2);
	public ClarionArray<ClarionNumber> pzb=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(4);
	public ClarionArray<ClarionNumber> npp2=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(4);
	public ClarionString nppf=Clarion.newString(4);
	public ClarionArray<ClarionNumber> pkip=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(3);
	public ClarionString pkif=Clarion.newString(3);
	public ClarionArray<ClarionDecimal> atlikums=Clarion.newDecimal(11,2).dim(15);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString gnet_flag=Clarion.newString(2);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey bkk_key=new ClarionKey("BKK_KEY");
	public ClarionKey gnet_key=new ClarionKey("GNET_KEY");

	public Kon_k()
	{
		setName(Clarion.newString("KON_K"));
		setPrefix("KON");
		setCreate();
		this.addVariable("BKK",this.bkk);
		this.addVariable("ALT_BKK",this.alt_bkk);
		this.addVariable("NOSAUKUMS",this.nosaukums);
		this.addVariable("NOSAUKUMSA",this.nosaukumsa);
		this.addVariable("VAL",this.val);
		this.addVariable("PVND",this.pvnd);
		this.addVariable("PVNK",this.pvnk);
		this.addVariable("PZB",this.pzb);
		this.addVariable("NPP2",this.npp2);
		this.addVariable("NPPF",this.nppf);
		this.addVariable("PKIP",this.pkip);
		this.addVariable("PKIF",this.pkif);
		this.addVariable("ATLIKUMS",this.atlikums);
		this.addVariable("BAITS",this.baits);
		this.addVariable("GNET_FLAG",this.gnet_flag);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		bkk_key.setNocase().setOptional().addAscendingField(bkk);
		this.addKey(bkk_key);
		gnet_key.setDuplicate().setNocase().setOptional().addAscendingField(gnet_flag);
		this.addKey(gnet_key);
	}
}
