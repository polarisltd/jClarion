package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionString;

public class Month_group extends ClarionGroup
{
	public ClarionString m1=Clarion.newString("January   ");
	public ClarionString m2=Clarion.newString("February  ");
	public ClarionString m3=Clarion.newString("March     ");
	public ClarionString m4=Clarion.newString("April     ");
	public ClarionString m5=Clarion.newString("May       ");
	public ClarionString m6=Clarion.newString("June      ");
	public ClarionString m7=Clarion.newString("July      ");
	public ClarionString m8=Clarion.newString("August    ");
	public ClarionString m9=Clarion.newString("September ");
	public ClarionString m10=Clarion.newString("October   ");
	public ClarionString m11=Clarion.newString("November  ");
	public ClarionString m12=Clarion.newString("December  ");

	public Month_group()
	{
		this.addVariable("m1",this.m1);
		this.addVariable("m2",this.m2);
		this.addVariable("m3",this.m3);
		this.addVariable("m4",this.m4);
		this.addVariable("m5",this.m5);
		this.addVariable("m6",this.m6);
		this.addVariable("m7",this.m7);
		this.addVariable("m8",this.m8);
		this.addVariable("m9",this.m9);
		this.addVariable("m10",this.m10);
		this.addVariable("m11",this.m11);
		this.addVariable("m12",this.m12);
	}
}
