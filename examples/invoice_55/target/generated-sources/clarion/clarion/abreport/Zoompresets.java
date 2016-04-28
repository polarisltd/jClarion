package clarion.abreport;

import clarion.abreport.equates.Mconstants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Zoompresets extends ClarionGroup
{
	public ClarionNumber number=Clarion.newNumber(7).setEncoding(ClarionNumber.BYTE);
	public ClarionString _anon_1=Clarion.newString("Tile pages").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_2=Clarion.newString("Zoom: Tile Pages").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_3=Clarion.newNumber(Mconstants.NOZOOM).setEncoding(ClarionNumber.SHORT);
	public ClarionString _anon_4=Clarion.newString("Page Width").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_5=Clarion.newString("Zoom: Page Width").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_6=Clarion.newNumber(Mconstants.PAGEWIDTH).setEncoding(ClarionNumber.SHORT);
	public ClarionString _anon_7=Clarion.newString("50% Zoom").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_8=Clarion.newString("Zoom: 50%").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_9=Clarion.newNumber(50).setEncoding(ClarionNumber.SHORT);
	public ClarionString _anon_10=Clarion.newString("75% Zoom").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_11=Clarion.newString("Zoom: 75%").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_12=Clarion.newNumber(75).setEncoding(ClarionNumber.SHORT);
	public ClarionString _anon_13=Clarion.newString("100% Zoom").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_14=Clarion.newString("Zoom: 100%").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_15=Clarion.newNumber(100).setEncoding(ClarionNumber.SHORT);
	public ClarionString _anon_16=Clarion.newString("200% Zoom").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_17=Clarion.newString("Zoom: 200%").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_18=Clarion.newNumber(200).setEncoding(ClarionNumber.SHORT);
	public ClarionString _anon_19=Clarion.newString("300% Zoom").setEncoding(ClarionString.PSTRING);
	public ClarionString _anon_20=Clarion.newString("Zoom: 300%").setEncoding(ClarionString.PSTRING);
	public ClarionNumber _anon_21=Clarion.newNumber(300).setEncoding(ClarionNumber.SHORT);

	public Zoompresets()
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
		this.addVariable("_anon_17",this._anon_17);
		this.addVariable("_anon_18",this._anon_18);
		this.addVariable("_anon_19",this._anon_19);
		this.addVariable("_anon_20",this._anon_20);
		this.addVariable("_anon_21",this._anon_21);
	}
}
