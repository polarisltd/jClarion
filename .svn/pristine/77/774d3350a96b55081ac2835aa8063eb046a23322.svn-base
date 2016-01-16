package org.jclarion.clarion.ide;

import java.io.IOException;
import java.util.Map;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Font;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.constants.Propprint;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.CheckControl;
import org.jclarion.clarion.control.TabControl;
import org.jclarion.clarion.ide.lang.SourceEncoder;
import org.jclarion.clarion.ide.model.manager.ColorHelper;
import org.jclarion.clarion.ide.model.manager.StdHelper;
import org.jclarion.clarion.ide.windowdesigner.ControlType;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;

public class Serializer {
	
	private static String PAD="                                                                                                                               ";
	
	private String getValue(PropertyObject po,int prop)
	{
		ClarionObject co = po.getRawProperty(prop,false);
		if (co==null) return "";
		return co.toString();
	}
	
	public void serialize(PropertyObject po, Appendable out) throws IOException 
	{
		int gap=18;
		PropertyObject scan = po;
		while (scan!=null) {
			scan=scan.getParentPropertyObject();
			gap+=4;
		}
		serialize(po,out,gap);
	}
	
	private void serialize(PropertyObject po, Appendable out,int whitespaceGap) throws IOException {
		ExtendProperties ep = (ExtendProperties) po.getExtend();
		ControlType ct = ControlType.get(po.getClass());
		
		if (ep.controlLex!=null) {
			out.append(ep.controlLex);
			
			boolean anyWhitespace=false;
			whitespaceGap=0;
			
			int scan=0;
			while (scan<ep.controlLex.length()) {
				char c = ep.controlLex.charAt(scan++);
				if (c==' ') {
					anyWhitespace=true;
					whitespaceGap++;
					continue;
				}
				if (c=='\t') {
					anyWhitespace=true;
					whitespaceGap+=8;
					continue;
				}
				if (anyWhitespace) break;
				whitespaceGap++;
			}			
		} else {
			int len = 0;
			if (ep.getLabel() != null) {
				out.append(ep.getLabel());
				len = ep.getLabel().length();
			}

			if (len<whitespaceGap) {
				out.append(PAD,len,whitespaceGap);
			} else {
				out.append(' ');
			}

			out.append(ct.getName().toUpperCase());

			if (ct.isSerializeText()) {
				String text = po.getProperty(Prop.TEXT).toString();
				if (text.length() > 0) {
					out.append('(');
					if (ct.isSerializeAsPicture(po)) {
						out.append(text);
					} else if (ct.isSerializeSpecial()) {
						serializeSpecialString(out,po.getProperty(Prop.TEXT),"");
					} else {
						SourceEncoder.encodeString(text, out);
					}
					out.append(')');
				}
			}

			if (!(po instanceof TabControl)) {
				out.append(",AT(");
				out.append(getValue(po,Prop.XPOS));
				out.append(",");
				out.append(getValue(po,Prop.YPOS));
				if (po.getRawProperty(Prop.WIDTH,false) != null || po.getRawProperty(Prop.HEIGHT,false) != null) {
					out.append(",");
					out.append(getValue(po,Prop.WIDTH));
					out.append(",");
					out.append(getValue(po,Prop.HEIGHT));
				}
				out.append(")");
			}
				
				if (!po.getProperty(Prop.RATIO).toString().equals("")) {
					out.append(",RATIO(");
					SourceEncoder.encodeString(po.getProperty(Prop.RATIO).toString(), out);
					out.append(")");
				} else {
					ClarionObject ratioData[] = new ClarionObject[]{
							po.getRawProperty(Prop.RATIO_X,false),
							po.getRawProperty(Prop.RATIO_Y,false),
							po.getRawProperty(Prop.RATIO_WIDTH,false),
							po.getRawProperty(Prop.RATIO_HEIGHT,false)};
					int count = 4;
					while (count > 0 && ratioData[count - 1] == null) {
						count--;
					}
					if (count>0) {
						out.append(",RATIO(");	
						for (int scan=0;scan<count;scan++) {
							if (scan>0) out.append(',');
							out.append(getValue(po,Prop.RATIO_X+scan));
						}
						out.append(")");
					}
				}
			
			if (ep.getPre()!=null) {
				out.append(",PRE(").append(ep.getPre()).append(")");
			}

			if (ep.getUsevars() != null) {
				out.append(",USE(");
				boolean first=true;
				for (String s : ep.getUsevars()) {
					if (first) {
						first=false;
					} else {
						out.append(",");
					}
					out.append(s);
				}
				out.append(")");
			}

			// consider outputting font data
			ClarionObject fontData[] = new ClarionObject[]{
				po.getRawProperty(po.reMap(Prop.FONT, 1),false),
				po.getRawProperty(po.reMap(Prop.FONT, 2),false),
				po.getRawProperty(po.reMap(Prop.FONT, 3),false),
				po.getRawProperty(po.reMap(Prop.FONT, 4),false),
				po.getRawProperty(po.reMap(Prop.FONT, 5),false)};
			int count = 5;
			while (count > 0 && fontData[count - 1] == null) {
				count--;
			}

			if (count > 0) {
				out.append(",FONT(");
				for (int scan = 0; scan < count; scan++) {
					if (scan > 0) {
						out.append(",");
					}
					if (fontData[scan] != null) {
						switch(scan) {
							case 0: // font
								SourceEncoder.encodeString(fontData[scan].toString(), out);
								break;
							case 2 : // color
								serializeColor(out,fontData[scan]);
								break;
							case 3: // style
								int style = fontData[scan].intValue();
								boolean any=false;
								if ((style & Font.BOLD)==Font.BOLD) {
									out.append("FONT:bold");
									any=true;
								}
								if ((style & Font.ITALIC)==Font.ITALIC) {
									if (any) out.append('+');
									out.append("FONT:ITALIC");
									any=true;
								}
								if (!any) {
									out.append("FONT:REGULAR");
								}
								break;
							default:
								out.append(fontData[scan].toString());
						}
					}
				}
				out.append(")");
			}
			
			if (po.getRawProperty(Propprint.PAPER,false)!=null) {
				out.append(",PAPER(");
				out.append(po.getRawProperty(Propprint.PAPER,false).toString());
				ClarionObject width = po.getRawProperty(Propprint.PAPERWIDTH,false);
				ClarionObject height = po.getRawProperty(Propprint.PAPERHEIGHT,false);
				if (width!=null || height!=null) {
					out.append(",");
					if (width!=null) out.append(width.toString());
					out.append(",");
					if (height!=null) out.append(height.toString());
				}
				out.append(')');
			}

			serializeFlag(out, po, "double");
			serializeString(out, po, "msg", "hlp", "tip", "format");
			serializeSpecial(out,po,"icon");
			
			if (po instanceof CheckControl) {
				ClarionObject tv =po.getRawProperty(Prop.TRUEVALUE,false); 
				ClarionObject fv =po.getRawProperty(Prop.FALSEVALUE,false);
				if (tv!=null || fv!=null) {
					out.append(",VALUE(");
					serializeSpecialString(out,tv,"'1'");
					out.append(',');
					serializeSpecialString(out,fv,"'0'");
					out.append(')');
				}
			} else {
				serializeString(out,po,"value");
			}
			
			serializeColor(out, po, "color");
			serializeFlag(out, po, "gray", "mdi", "system", "imm", "boxed", "default", "trn", "skip", "disable", "hide","wizard","landscape","absolute","thous","mm","points","readonly","password","resize","req","flat","max","nosheet","nobar","centered");
			if (po.isProperty(Prop.VSCROLL) && po.isProperty(Prop.HSCROLL)) {
				out.append(",HVSCROLL");
			} else if (po.isProperty(Prop.VSCROLL)) {
				out.append(",VSCROLL");
			} else if (po.isProperty(Prop.HSCROLL)) {
				out.append(",HSCROLL");
			}
			
			serializeRaw(out, po, "bevel", "drop", "key", "from","preview","withprior","withnext","timer");
			serializeOptRaw(out, po, "center", "centeroffset",false);
			serializeOptRaw(out, po, "right", "rightoffset",false);
			serializeOptRaw(out, po, "left", "leftoffset",true);
			serializeOptRaw(out, po, "decimal", "decimaloffset",false);
			

			if (po.getRawProperty(Prop.STD,false)!=null) {
				out.append(",STD(");
				ClarionObject std=po.getRawProperty(Prop.STD,false);
				if (std.intValue()>0) {
					out.append(StdHelper.getInstance().getName(std.intValue()));
				} else {
					out.append(std.toString());
				}
				out.append(")");
			}
			
			for (Map.Entry<String, String[]> scan : ep.getPragma().entrySet()) {
				out.append(",#");
				out.append(scan.getKey());
				if (scan.getValue().length > 0) {
					boolean first = true;
					for (String o : scan.getValue()) {
						if (first) {
							out.append("(");
							first = false;
						} else {
							out.append(",");
						}
						out.append(o);
					}
					out.append(")");
				}
			}
			out.append('\n');
		}

		if (ct.hasKids) {
			if (po instanceof AbstractTarget) {
				for (AbstractControl ac : ((AbstractTarget) po).getControls()) {
					serialize(ac, out,whitespaceGap+4);
				}
			}
			if (po instanceof AbstractControl) {
				for (AbstractControl ac : ((AbstractControl) po).getChildren()) {
					serialize(ac, out,whitespaceGap+4);
				}
			}

			if (ep.endLex!=null && ep.endLex.length()>0) {
				out.append(ep.endLex);
			} else {
				out.append(PAD,0,whitespaceGap);
				out.append("END\n");
			}
		}
	}
	
	private void serializeSpecialString(Appendable out, ClarionObject tv,String def) throws IOException 
	{
		if (tv==null) {
			out.append(def);
			return;
		}
		String v = tv.toString();
		if (v.length()>0 && v.charAt(0)=='!') {
			out.append(v,1,v.length());
			return;
		}
		SourceEncoder.encodeString(v, out);
	}

	private void serializeColor(Appendable a,ClarionObject obj) throws IOException
	{
		if (obj==null) return;
		int val = obj.intValue();
		String name = ColorHelper.getInstance().getName(val);
		if (name!=null) {
			a.append(name);
			return;
		}
		
		String hex=Integer.toHexString(val);
		char f =hex.charAt(0);
		if ( (f>='a' && f<='f') || (f>='A' && f<='F')) a.append('0');
		a.append(hex);
		a.append('h');
	}

	private void serializeFlag(Appendable a, PropertyObject po, String... d) throws IOException {
		for (String sflag : d) {
			int flag = Prop.getPropID(sflag);
			if (po.isProperty(flag)) {
				a.append(',');
				a.append(sflag.toUpperCase());
			}
		}
	}
	
	private void serializeSpecial(Appendable a, PropertyObject po, String... d) throws IOException {
		for (String sflag : d) {
			int flag = Prop.getPropID(sflag);
			ClarionObject co = po.getRawProperty(flag,false);
			if (co != null && co.toString().length()>0) {
				a.append(',');
				a.append(sflag.toUpperCase());
				a.append('(');
				serializeSpecialString(a,co,"");
				a.append(')');
			}
		}
	}

	private void serializeString(Appendable a, PropertyObject po, String... d) throws IOException {
		for (String sflag : d) {
			int flag = Prop.getPropID(sflag);
			ClarionObject co = po.getRawProperty(flag,false);
			if (co != null) {
				a.append(',');
				a.append(sflag.toUpperCase());
				a.append('(');
				SourceEncoder.encodeString(co.toString(), a);
				a.append(')');
			}
		}
	}

	private void serializeColor(Appendable a, PropertyObject po, String... d) throws IOException {
		for (String sflag : d) {
			int flag = Prop.getPropID(sflag);
			ClarionObject co = po.getRawProperty(flag,false);
			if (co != null) {
				a.append(',');
				a.append(sflag.toUpperCase());
				a.append('(');
				serializeColor(a, co);
				a.append(')');
			}
		}
	}
	
	private void serializeRaw(Appendable a, PropertyObject po, String... d) throws IOException {
		for (String sflag : d) {
			int flag = Prop.getPropID(sflag);
			ClarionObject co = po.getRawProperty(flag,false);
			if (co != null) {
				a.append(',');
				a.append(sflag.toUpperCase());
				a.append('(');
				a.append(co.toString());
				a.append(')');
			}
		}
	}

	private void serializeOptRaw(Appendable a, PropertyObject po,String sflag,String sOptValue,boolean isDefault) throws IOException {
		
		int flag  = Prop.getPropID(sflag);
		int optValue  = Prop.getPropID(sOptValue);
		
		if (!po.isProperty(flag)) return;
		ClarionObject opt = po.getRawProperty(optValue,false);
		if (opt!=null && opt.intValue()==0) opt=null;
		if (isDefault && opt==null) return; 
		
		a.append(',');
		a.append(sflag.toUpperCase());
		
		
		if (opt==null) return;
		a.append("(");
		a.append(opt.toString());
		a.append(")");
	}

}

