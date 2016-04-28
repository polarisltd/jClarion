package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Paroles extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString secure=Clarion.newString(8);
	public ClarionString publish=Clarion.newString(8);
	public ClarionString super_acc=Clarion.newString(1);
	public ClarionString files_acc=Clarion.newString(8);
	public ClarionString spec_acc=Clarion.newString(30);
	public ClarionNumber start_nr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString base_acc=Clarion.newString(15);
	public ClarionString nol_acc=Clarion.newString(25);
	public ClarionString fp_acc=Clarion.newString(25);
	public ClarionString alga_acc=Clarion.newString(15);
	public ClarionString pam_acc=Clarion.newString(15);
	public ClarionString lm_acc=Clarion.newString(25);
	public ClarionNumber dup_acc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString vut=Clarion.newString(25);
	public ClarionString amats=Clarion.newString(25);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey secure_key=new ClarionKey("SECURE_KEY");
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey pub_key=new ClarionKey("PUB_KEY");

	public Paroles()
	{
		setSource(Clarion.newString("MARIS"));
		setName(Clarion.newString("PAROLES"));
		setPrefix("SEC");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("SECURE",this.secure);
		this.addVariable("PUBLISH",this.publish);
		this.addVariable("SUPER_ACC",this.super_acc);
		this.addVariable("FILES_ACC",this.files_acc);
		this.addVariable("SPEC_ACC",this.spec_acc);
		this.addVariable("START_NR",this.start_nr);
		this.addVariable("BASE_ACC",this.base_acc);
		this.addVariable("NOL_ACC",this.nol_acc);
		this.addVariable("FP_ACC",this.fp_acc);
		this.addVariable("ALGA_ACC",this.alga_acc);
		this.addVariable("PAM_ACC",this.pam_acc);
		this.addVariable("LM_ACC",this.lm_acc);
		this.addVariable("DUP_ACC",this.dup_acc);
		this.addVariable("VUT",this.vut);
		this.addVariable("AMATS",this.amats);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		secure_key.setNocase().setOptional().addAscendingField(secure);
		this.addKey(secure_key);
		nr_key.setNocase().setOptional().addAscendingField(u_nr);
		this.addKey(nr_key);
		pub_key.setNocase().setOptional().addAscendingField(publish);
		this.addKey(pub_key);
	}
}
