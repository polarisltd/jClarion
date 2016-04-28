package clarion.abeip;

import clarion.Main;
import clarion.abeip.Colormap;
import clarion.abeip.Colormapgroup;
import clarion.abeip.Multiwindow;
import clarion.abeip.Txtwindow;
import clarion.abutil.Constantclass;
import clarion.equates.Constants;
import clarion.equates.Consttype;
import clarion.equates.Level;
import clarion.equates.Term;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class Abeip
{
	public static Colormapgroup colormapgroup;
	public static ClarionNumber colorqinitialized;
	public static Colormap colormap;
	public static Multiwindow multiwindow;
	public static Txtwindow txtwindow;
	public static ClarionNumber convertbase_string_number_number_vala;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		Main.__register_destruct(new Runnable() { public void run() { __static_destruct(); } });
		__static_init();
	}

	public static void __static_init() {
		colormapgroup=new Colormapgroup();
		colorqinitialized=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		colormap=new Colormap();
		multiwindow=new Multiwindow();
		txtwindow=new Txtwindow();
		convertbase_string_number_number_vala=Clarion.newNumber(0).setEncoding(ClarionNumber.LONG);
	}

	public static void __static_destruct() {
		Abeip.multiwindow.close();
		Abeip.txtwindow.close();
	}


	public static ClarionString getcolortext(ClarionNumber color)
	{
		ClarionNumber red=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber green=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber blue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (!((color.intValue() & (int)0x80000000l)!=0) && (color.compareTo(0xffffff)>0 || color.compareTo(-1)<0)) {
			color.setValue(0);
		}
		if (!Abeip.colorqinitialized.boolValue()) {
			Abeip.colorqinitialized.setValue(Constants.TRUE);
			Abeip.initializecolors();
		}
		Abeip.colormap.color.setValue(color);
		Abeip.colormap.get(Abeip.colormap.ORDER().ascend(Abeip.colormap.color));
		if (CError.errorCode()!=0) {
			red.setValue(color.intValue() & 0xff);
			green.setValue(ClarionNumber.shift(color.intValue() & 0xff00,-8));
			blue.setValue(ClarionNumber.shift(color.intValue() & 0xff0000,-16));
			return Clarion.newString(ClarionString.staticConcat("R:",red,", G:",green,", B:",blue));
		}
		else {
			return Abeip.colormap.text.like();
		}
	}
	public static ClarionNumber getcolorvalue(ClarionString str)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber base=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString basec=Clarion.newString(1);
		ClarionString c=Clarion.newString(1);
		ClarionArray<ClarionNumber> rgb=Clarion.newNumber().setEncoding(ClarionNumber.LONG).dim(3);
		ClarionNumber pos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber result=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (!Abeip.colorqinitialized.boolValue()) {
			Abeip.colorqinitialized.setValue(Constants.TRUE);
			Abeip.initializecolors();
		}
		Abeip.colormap.textkey.setValue(str.upper());
		Abeip.colormap.get(Abeip.colormap.ORDER().ascend(Abeip.colormap.textkey));
		if (!(CError.errorCode()!=0)) {
			return Abeip.colormap.color.like();
		}
		final int loop_1=str.len();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			c.setValue(str.stringAt(i).upper());
			{
				ClarionString case_1=c;
				boolean case_1_break=false;
				boolean case_1_match=false;
				case_1_match=false;
				if (case_1.equals("R")) {
					pos.setValue(1);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals("G")) {
					pos.setValue(2);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals("B")) {
					pos.setValue(3);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(",")) {
					pos.increment(1);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(":")) {
					case_1_match=true;
				}
				if (case_1_match || case_1.equals("=")) {
					case_1_match=true;
				}
				if (case_1_match || case_1.equals(" ")) {
					case_1_break=true;
				}
				if (!case_1_break) {
					if (c.isNumeric()) {
						if (pos.compareTo(1)<0 || pos.compareTo(3)>0) {
							return Clarion.newNumber(Constants.INVALID_COLOR);
						}
						rgb.get(pos.intValue()).setValue(rgb.get(pos.intValue()).multiply(10).add(c));
						if (rgb.get(pos.intValue()).compareTo(255)>0) {
							rgb.get(pos.intValue()).setValue(255);
						}
					}
					else {
						basec.setValue(str.stringAt(1,str.len()));
						{
							ClarionString case_2=basec;
							boolean case_2_break=false;
							if (case_2.equals("H")) {
								base.setValue(16);
								case_2_break=true;
							}
							if (!case_2_break && case_2.equals("O")) {
								base.setValue(8);
								case_2_break=true;
							}
							if (!case_2_break && case_2.equals("B")) {
								base.setValue(2);
								case_2_break=true;
							}
							if (!case_2_break) {
								if (!basec.isNumeric()) {
									return Clarion.newNumber(Constants.INVALID_COLOR);
								}
								base.setValue(10);
							}
						}
						if (!base.equals(10)) {
							str.setValue(str.stringAt(1,str.len()-1));
						}
						if (Abeip.convertbase(str.like(),result,base.like()).boolValue()) {
							return result.like();
						}
						else {
							return Clarion.newNumber(Constants.INVALID_COLOR);
						}
					}
				}
			}
		}
		return Clarion.newNumber(rgb.get(1).intValue() | ClarionNumber.shift(rgb.get(2).intValue(),8) | ClarionNumber.shift(rgb.get(3).intValue(),16));
	}
	public static ClarionNumber convertbase(ClarionString p0,ClarionNumber p1)
	{
		return convertbase(p0,p1,Clarion.newNumber(16));
	}
	public static ClarionNumber convertbase(ClarionString value,ClarionNumber result,ClarionNumber base)
	{
		ClarionNumber b=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString digit=Clarion.newString(1);
		ClarionNumber index=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber val=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber top=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber neg=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber l=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (!Abeip.convertbase_string_number_number_vala.boolValue()) {
			Abeip.convertbase_string_number_number_vala.setValue(Clarion.newString("A").val());
		}
		if (!CRun.inRange(base,Clarion.newNumber(1),Clarion.newNumber(36))) {
			return Clarion.newNumber(Constants.FALSE);
		}
		else if (base.compareTo(10)<0) {
			top.setValue(Clarion.newNumber(Clarion.newString("0").val()).add(base).subtract(1));
		}
		else {
			top.setValue(Abeip.convertbase_string_number_number_vala.add(base).subtract(11));
		}
		b.setValue(0);
		result.setValue(0);
		l.setValue(value.len());
		if (!l.boolValue()) {
			return Clarion.newNumber(Constants.FALSE);
		}
		if (value.stringAt(1).equals("-")) {
			neg.setValue(Constants.TRUE);
		}
		for (index.setValue(value.len());index.compareTo(1)>=0;index.increment(-1)) {
			digit.setValue(value.stringAt(index).upper());
			if (Clarion.newNumber(digit.val()).compareTo(top)>0) {
				return Clarion.newNumber(Constants.FALSE);
			}
			val.setValue(Clarion.newBool(digit.isNumeric()).equals(Constants.TRUE) ? digit : Clarion.newNumber(digit.val()).subtract(Abeip.convertbase_string_number_number_vala).add(10));
			result.increment(val.multiply(base.power(b)));
			b.increment(1);
		}
		if (neg.boolValue()) {
			result.setValue(result.negate());
		}
		return Clarion.newNumber(Constants.TRUE);
	}
	public static void initializecolors()
	{
		Constantclass cnst=new Constantclass();
		cnst.init(Clarion.newNumber(Term.ENDGROUP));
		cnst.additem(Clarion.newNumber(Consttype.LONG),Abeip.colormap.color);
		cnst.additem(Clarion.newNumber(Consttype.PSTRING),Abeip.colormap.text);
		cnst.set(Abeip.colormapgroup.getString());
		while (cnst.next().equals(Level.BENIGN)) {
			Abeip.colormap.textkey.setValue(Abeip.colormap.text.upper());
			Abeip.colormap.add(Abeip.colormap.ORDER().ascend(Abeip.colormap.color));
		}
		cnst.kill();
	}
}
