package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Pamam extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber yyyymm=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal lin_g_pr=Clarion.newDecimal(5,3);
	public ClarionString nodala=Clarion.newString(2);
	public ClarionDecimal sak_v_li=Clarion.newDecimal(11,2);
	public ClarionDecimal nol_g_li=Clarion.newDecimal(11,3);
	public ClarionDecimal nol_u_li=Clarion.newDecimal(11,3);
	public ClarionDecimal nol_lin=Clarion.newDecimal(11,3);
	public ClarionNumber lock_lin=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal kaprem=Clarion.newDecimal(11,2);
	public ClarionDecimal parcen=Clarion.newDecimal(11,2);
	public ClarionDecimal parcenli=Clarion.newDecimal(11,2);
	public ClarionDecimal izslegts=Clarion.newDecimal(11,2);
	public ClarionDecimal skaits=Clarion.newDecimal(3,0);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey yyyymm_key=new ClarionKey("YYYYMM_KEY");

	public Pamam()
	{
		setName(Main.pamamname);
		setPrefix("AMO");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("YYYYMM",this.yyyymm);
		this.addVariable("LIN_G_PR",this.lin_g_pr);
		this.addVariable("NODALA",this.nodala);
		this.addVariable("SAK_V_LI",this.sak_v_li);
		this.addVariable("NOL_G_LI",this.nol_g_li);
		this.addVariable("NOL_U_LI",this.nol_u_li);
		this.addVariable("NOL_LIN",this.nol_lin);
		this.addVariable("LOCK_LIN",this.lock_lin);
		this.addVariable("KAPREM",this.kaprem);
		this.addVariable("PARCEN",this.parcen);
		this.addVariable("PARCENLI",this.parcenli);
		this.addVariable("IZSLEGTS",this.izslegts);
		this.addVariable("SKAITS",this.skaits);
		nr_key.setNocase().setPrimary().addAscendingField(u_nr).addAscendingField(yyyymm);
		this.addKey(nr_key);
		yyyymm_key.setNocase().setOptional().addAscendingField(yyyymm).addAscendingField(u_nr);
		this.addKey(yyyymm_key);
	}
}
