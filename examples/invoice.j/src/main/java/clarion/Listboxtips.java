package clarion;

import clarion.equates.Toolbar;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Listboxtips extends ClarionGroup
{
	public ClarionNumber number=Clarion.newNumber(8).setEncoding(ClarionNumber.BYTE);
	public ClarionNumber _anon_1=Clarion.newNumber(Toolbar.DOWN).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_2=Clarion.newString("Go to the Next Record").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_3=Clarion.newNumber(Toolbar.BOTTOM).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_4=Clarion.newString("Go to the Last Page").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_5=Clarion.newNumber(Toolbar.TOP).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_6=Clarion.newString("Go to the First Page").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_7=Clarion.newNumber(Toolbar.PAGEDOWN).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_8=Clarion.newString("Go to the Next Page").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_9=Clarion.newNumber(Toolbar.PAGEUP).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_10=Clarion.newString("Go to the Prior Page").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_11=Clarion.newNumber(Toolbar.DOWN).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_12=Clarion.newString("Go to the Next Record").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_13=Clarion.newNumber(Toolbar.UP).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_14=Clarion.newString("Go to the Prior Record").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_15=Clarion.newNumber(Toolbar.INSERT).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_16=Clarion.newString("Insert a new Record").setEncoding(ClarionString.PSTRING);

	public Listboxtips()
	{
		this.addVariable("Number",this.number);
		this.addVariable("_anon_1",this._anon_1);
		this.addVariable("_anon_2",this._anon_2);
		this.addVariable("_anon_3",this._anon_3);
		this.addVariable("_anon_4",this._anon_4);
		this.addVariable("_anon_5",this._anon_5);
		this.addVariable("_anon_6",this._anon_6);
		this.addVariable("_anon_7",this._anon_7);
		this.addVariable("_anon_8",this._anon_8);
		this.addVariable("_anon_9",this._anon_9);
		this.addVariable("_anon_10",this._anon_10);
		this.addVariable("_anon_11",this._anon_11);
		this.addVariable("_anon_12",this._anon_12);
		this.addVariable("_anon_13",this._anon_13);
		this.addVariable("_anon_14",this._anon_14);
		this.addVariable("_anon_15",this._anon_15);
		this.addVariable("_anon_16",this._anon_16);
	}
}
