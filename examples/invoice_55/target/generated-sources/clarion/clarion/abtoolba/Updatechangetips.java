package clarion.abtoolba;

import clarion.equates.Toolbar;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Updatechangetips extends ClarionGroup
{
	public ClarionNumber _anon_1=Clarion.newNumber(7).setEncoding(ClarionNumber.BYTE);
	public ClarionNumber _anon_2=Clarion.newNumber(Toolbar.BOTTOM).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_3=Clarion.newString("Save changes and go to last record").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_4=Clarion.newNumber(Toolbar.TOP).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_5=Clarion.newString("Save changes and go to first record").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_6=Clarion.newNumber(Toolbar.PAGEDOWN).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_7=Clarion.newString("Save changes and page down to record").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_8=Clarion.newNumber(Toolbar.PAGEUP).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_9=Clarion.newString("Save changes and page up to record").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_10=Clarion.newNumber(Toolbar.DOWN).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_11=Clarion.newString("Save changes and go to next record").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_12=Clarion.newNumber(Toolbar.UP).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_13=Clarion.newString("Save changes and go to previous record").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_14=Clarion.newNumber(Toolbar.INSERT).setEncoding(ClarionNumber.USHORT);
	public ClarionString _anon_15=Clarion.newString("Save this record and add a new one").setEncoding(ClarionString.PSTRING);

	public Updatechangetips()
	{
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
	}
}
