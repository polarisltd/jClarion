package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Vesture extends ClarionSQLFile
{
	public ClarionNumber crm=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber kam=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString rs=Clarion.newString(1);
	public ClarionNumber process=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString dok_senr=Clarion.newString(14);
	public ClarionNumber apmdat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber dokdat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber seciba=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString saturs=Clarion.newString(47);
	public ClarionString saturs2=Clarion.newString(47);
	public ClarionString saturs3=Clarion.newString(47);
	public ClarionDecimal summa=Clarion.newDecimal(11,2);
	public ClarionDecimal atlaide=Clarion.newDecimal(3,1);
	public ClarionString val=Clarion.newString(3);
	public ClarionString d_k_konts=Clarion.newString(5);
	public ClarionDecimal samaksats=Clarion.newDecimal(11,2);
	public ClarionString sam_val=Clarion.newString(3);
	public ClarionNumber sam_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey crm_key=new ClarionKey("CRM_KEY");
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");
	public ClarionKey par_key=new ClarionKey("PAR_KEY");
	public ClarionKey ref_key=new ClarionKey("REF_KEY");

	public Vesture()
	{
		setName(Clarion.newString("VESTURE"));
		setPrefix("VES");
		setCreate();
		this.addVariable("CRM",this.crm);
		this.addVariable("KAM",this.kam);
		this.addVariable("RS",this.rs);
		this.addVariable("PROCESS",this.process);
		this.addVariable("DOK_SENR",this.dok_senr);
		this.addVariable("APMDAT",this.apmdat);
		this.addVariable("DOKDAT",this.dokdat);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("SECIBA",this.seciba);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("SATURS",this.saturs);
		this.addVariable("SATURS2",this.saturs2);
		this.addVariable("SATURS3",this.saturs3);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("Atlaide",this.atlaide);
		this.addVariable("VAL",this.val);
		this.addVariable("D_K_KONTS",this.d_k_konts);
		this.addVariable("Samaksats",this.samaksats);
		this.addVariable("SAM_VAL",this.sam_val);
		this.addVariable("Sam_datums",this.sam_datums);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		crm_key.setDuplicate().setNocase().addAscendingField(crm).addDescendingField(datums).addDescendingField(seciba);
		this.addKey(crm_key);
		dat_key.setDuplicate().setNocase().addAscendingField(par_nr).addDescendingField(datums).addDescendingField(seciba);
		this.addKey(dat_key);
		par_key.setDuplicate().setNocase().setOptional().addAscendingField(par_nr).addAscendingField(datums);
		this.addKey(par_key);
		ref_key.setDuplicate().setNocase().setOptional().addAscendingField(par_nr).addAscendingField(dok_senr);
		this.addKey(ref_key);
	}
}
