package org.jclarion.clarion.ide;

import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.AbstractTarget;
import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Font;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.constants.Std;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.AbstractReportControl;
import org.jclarion.clarion.control.BoxControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.LineControl;
import org.jclarion.clarion.control.OptionControl;
import org.jclarion.clarion.control.RadioControl;
import org.jclarion.clarion.control.ReportBreak;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.control.ReportFooter;
import org.jclarion.clarion.control.ReportForm;
import org.jclarion.clarion.control.ReportHeader;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;
import org.jclarion.clarion.control.TextControl;
import org.jclarion.clarion.ide.model.JavaSwingProvider;
import org.jclarion.clarion.ide.model.manager.ColorHelper;
import org.jclarion.clarion.ide.windowdesigner.ControlType;
import org.jclarion.clarion.ide.windowdesigner.ExtendProperties;
import org.jclarion.clarion.ide.windowdesigner.PropSerializer;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.format.Formatter;
import org.jclarion.clarion.util.SharedWriter;

public class Compiler {

	@SuppressWarnings("serial")
	private static Map<String, Object> EQUATES = new HashMap<String, Object>() {
		{
			put("font:regular".toLowerCase(), Font.REGULAR);
			put("font:bold".toLowerCase(), Font.BOLD);
			put("font:italic".toLowerCase(), Font.ITALIC);
			put("std:close".toLowerCase(), Std.CLOSE);
			put("charset:ansi".toLowerCase(), "");
		}
	};
	private String value;

	/**
	 * Creates a new compiler instance that will update the supplied
	 * {@link JavaSwingProvider} with the output of compiling Clarion to Java
	 */
	public Compiler() 
	{
	}

	/**
	 * Compiles the {@link Lexer} and updates the configured
	 * {@link JavaSwingProvider} with the resulting {@link AbstractWindowTarget}
	 * TODO: populate compilation exception line and column
	 */
	public AbstractTarget compile(String value) {
		this.value=value;
		Lexer lexer = new Lexer(new StringReader(value));
		lexer.setJavaMode(false);
		return (AbstractTarget) popControl(lexer);
	}

	public AbstractTarget compile(Reader reader) {
		
		SharedWriter sw = new SharedWriter();
		char buff[] = new char[8192];
		while ( true ) {
			int len;
			try {
				len = reader.read(buff);
				if (len<=0) break;
				sw.write(buff,0,len);
			} catch (IOException e) {
				e.printStackTrace();
				break;
			}
		}
		this.value=sw.toString();
		sw.close();
		Lexer lexer = new Lexer(new StringReader(value));
		lexer.setJavaMode(false);
		return (AbstractTarget) popControl(lexer);
	}
	
	public PropertyObject popControl(String value) {
		this.value=value;
		Lexer lexer = new Lexer(new StringReader(value));
		lexer.setJavaMode(false);
		return popControl(lexer);		
	}

	public List<PropertyObject> popControls(String value) {
		this.value=value;
		Lexer lexer = new Lexer(new StringReader(value));
		lexer.setJavaMode(false);
		List<PropertyObject> l = new ArrayList<PropertyObject>();
		while ( true ) {
			PropertyObject po = popControl(lexer);
			if (po==null) break;
			l.add(po);
		}		
		return l; 		
	}
	
	private int   charStart=-1;
	private String items=null;
	
	private void snapshot(Lexer lexer)
	{
		int pos=0;
		if (lexer.isIgnoreWhitespace()) {
			lexer.setIgnoreWhitespace(false);
			pos = lexer.lookahead().charStart;
			lexer.setIgnoreWhitespace(true);
		} else {
			pos = lexer.lookahead().charStart;	
		}		
		if (charStart>=0 && charStart<=pos) {
			items=value.substring(charStart,pos);
		} else {
			items=null;
		}
		charStart=pos;
	}
	
	private void clear(Lexer lexer)
	{
		items=null;
		charStart=-1;
	}
	
	private boolean isEnd(Lex lex) {
		if (lex.type == LexType.dot) return true;
		if (lex.type == LexType.label && lex.value.equalsIgnoreCase("end")) return true;
		return false;
	}
	
	private PropertyObject popControl(Lexer lexer) {
		String lastLabel = null;
		PropertyObject control = null;
		
		snapshot(lexer);
		
		while (true) {
			Lex lex = lexer.next();
			if (lex.type == LexType.eof) {
				clear(lexer);
				return null;
			}
			
			if (isEnd(lex)) {
				while(true) {
					lex = lexer.lookahead();
					if (lex.type==LexType.ws || lex.type==LexType.comment) {
						lexer.next();
						continue;
					}
					if (lex.type==LexType.nl){
						lexer.next();
						lexer.setIgnoreWhitespace(false);
					}
					break;
				}
				snapshot(lexer);
				return null;
			}
			
			if (lex.type == LexType.comment) {
				continue;
			}

			if (lex.type == LexType.nl) {
				lexer.setIgnoreWhitespace(false);
				continue;
			}

			if (!lexer.isIgnoreWhitespace()) {
				lexer.setIgnoreWhitespace(true);
				if (lex.type == LexType.label) {
					lastLabel = lex.value;
					continue;
				}
				if (lex.type == LexType.ws) {
					continue;
				}
			}

			if (lex.type != LexType.label) {
				System.out.println("!!! Warning !!! Expected Label Got:" + lex);
				skipToNL(lexer);
				continue;
			}
			String type = lex.value.toLowerCase();
			
			if (type.equals("controls")) {
				// special case when dragging in controls from a template 
				skipToNL(lexer);
				continue;				
			}
			
			ControlType ct = ControlType.get(type);
			if (ct == null) {
				System.out.println("!!! Warning !!! Unknown ControlType:" + type);
				skipToNL(lexer);
				continue;
			}

			try {
				control = ct.clazz.newInstance();
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
			if (control == null) {
				skipToNL(lexer);
				continue;
			}

			ExtendProperties ep = new ExtendProperties(control);
			control.setExtend(ep);
			ep.setLabel(lastLabel);
			
			if (control instanceof SheetControl) {
				((SheetControl) control).use(new ClarionNumber());
			}

			if (lexer.lookahead().type == LexType.lparam) {
				lexer.next();
				Lex param = lexer.next();
				
				while (lexer.lookahead().type==LexType.reference && lexer.lookahead(1).type==LexType.string) {
					lexer.next();
					param.value=param.value+lexer.next().value;
				}

				if (lexer.lookahead().type==LexType.rparam) {
					lexer.next();
				}
				
				if (param.type==LexType.label && ct.isSerializeSpecial()) {
					control.setProperty(Prop.TEXT, "!"+param.value);
				} else {
					control.setProperty(Prop.TEXT, param.value);
				}
				
				if (param.type == LexType.picture) {
					ClarionObject co = null;
					if (control instanceof StringControl) {
						Formatter f = Formatter.construct(param.value);
						co = new ClarionString(f.getPictureRepresentation());
					}
					if (co == null) {
						co = new ClarionString();
					}
					((AbstractControl) control).use(co);
				}
			}

			while (true) {
				if (lexer.lookahead().type != LexType.param) {
					if (lexer.lookahead().type == LexType.eof || lexer.lookahead().type == LexType.nl) {
						break;
					}
					System.out.println("!!! Warning !!! Expected NewLine. Got :" + lexer.lookahead());
					break;
				}
				lexer.next();

				boolean pragma = false;
				if (lexer.lookahead().type == LexType.implicit
						&& lexer.lookahead().value.equals("#")) {
					pragma = true;
					lexer.next();
				}

				if (lexer.lookahead().type != LexType.label) {
					if (lexer.lookahead().type != LexType.nl) {
						System.out.println("!!! Warning !!! Expected Label. Got :" + lexer.lookahead());
					}
					break;
				}
				String prop = lexer.next().value;
				List<Lex> params = new ArrayList<Lex>();
				Lex param=null;
				//StringBuilder param = new StringBuilder();

				boolean anyParam = false;

				if (lexer.lookahead().type == LexType.lparam) {
					lexer.next();
					Lex last = null;
					while (true) {
						lex = lexer.next();
						if (lex.type == LexType.nl || lex.type == LexType.eof) {
							System.out.println("!!! Warning !!! Expected rparam");
							lexer.setIgnoreWhitespace(true);
							break;
						}
						if (lex.type == LexType.rparam) {
							break;
						}
						if (lex.type == LexType.param) {
							params.add(param != null ? param : new Lex(LexType.ws,""));
							param=null;
							anyParam = true;
							last = null;
							continue;
						}
						anyParam = true;
						if (lex.type == LexType.label
								&& !prop.equalsIgnoreCase("use")) {
							Object equate = EQUATES.get(lex.value.toLowerCase());
							if (equate != null) {
								lex.value = equate.toString();
							} else {
								Integer val = ColorHelper.getInstance().getValue(lex.value);
								if (val!=null) {
									lex.value=val.toString();
								}
							}
						}

						if (last != null && last.type == LexType.string
								&& lex.type == LexType.reference) {
						} else {
							if (param==null) {
								param=new Lex(lex.type, lex.value);
							} else {
								param.value=param.value+lex.value;
							}
						}
						last = lex;
					}
				}

				if (anyParam) {
					params.add(param != null ? param : new Lex(LexType.ws,""));
				}

				if (pragma) {
					String s[]=new String[params.size()];
					int scan=0;
					for (Lex l : params) {
						s[scan++]=l.value;
					}
					ep.addPragma(prop,s);
				} else {
					PropSerializer p = PropSerializer.get(prop);
					if (p == null) {
						System.out.println("  " + prop + " : " + params);
					} else {
						p.deserialize(control, prop, params.toArray(new Lex[params.size()]));
					}
				}
			}

			skipToNL(lexer);
			snapshot(lexer);
			ep.controlLex = this.items;
			control.addListener(ep);			

			if (ct.hasKids) {
				while (true) {
					PropertyObject po = popControl(lexer);
					if (po == null) {
						ep.endLex = this.items;
						break;
					}
					if (control instanceof AbstractControl) {
						((AbstractControl) control).addChild((AbstractControl) po);
					}
					if (control instanceof AbstractTarget) {
						((AbstractTarget) control).add((AbstractControl) po);
					}
				}
			}

			return control;

		}
	}

	private void skipToNL(Lexer lexer) {
		if (!lexer.isIgnoreWhitespace())
			return;
		while (true) {
			Lex lex = lexer.next();
			if (lex.type == LexType.eof)
				break;
			if (lex.type == LexType.nl)
				break;
		}
		lexer.setIgnoreWhitespace(false);
	}

	public static boolean dragKids(PropertyObject parent)
	{
		if (parent instanceof ClarionReport) {
			return false;
		}

		if (parent instanceof AbstractReportControl) {
			return false;
		}
		
		return true;
	}
	
	public static boolean isValidParent(PropertyObject child, PropertyObject parent) {
		if (child instanceof RadioControl) {
			if (parent instanceof OptionControl) {
				return true;
			}
			return false;		
		}

		if (child instanceof TabControl) {
			if (parent instanceof SheetControl) {
				return true;
			}
			return false;
		}
	
		if (parent instanceof GroupControl) {
			return true;
		}
	
	
		if (parent instanceof TabControl) {
			return true;
		}
		
		if (parent instanceof AbstractWindowTarget) {
			return true;
		}

		if (child instanceof ReportHeader) {
			if (parent instanceof ReportBreak || parent instanceof ClarionReport) {
				ReportHeader exists = getExistingChild(parent,ReportHeader.class);
				return exists==null || exists==child;
			}
			return false;
		}

		if (child instanceof ReportFooter) {
			if (parent instanceof ReportBreak || parent instanceof ClarionReport) {
				ReportFooter exists = getExistingChild(parent,ReportFooter.class);
				return exists==null || exists==child;
			}
			return false;
		}			
		
		if (parent instanceof ClarionReport) {
			if (child instanceof ReportForm) {
				ReportForm exists = getExistingChild(parent,ReportForm.class);
				return exists==null || exists==child;
			}			
			
			if (child instanceof ReportDetail) {
				return true;
			}
			if (child instanceof ReportBreak) {
				return true;
			}
			return false;
		}
		
		
		if (parent instanceof ReportBreak) {
			if (child instanceof ReportDetail) {
				return true;
			}
			if (child instanceof ReportBreak) {
				return true;
			}
			return false;
		}			
		
		if (parent instanceof AbstractReportControl)
		{
			if (child instanceof StringControl) {
				return true;
			}
			if (child instanceof ImageControl) {
				return true;
			}
			if (child instanceof LineControl) {
				return true;
			}
			if (child instanceof BoxControl) {
				return true;
			}
			if (child instanceof TextControl) {
				return true;
			}
			if (child instanceof GroupControl) {
				return true;
			}
		}
		
		return false;
	}
	
	@SuppressWarnings("unchecked")
	private static <X> X getExistingChild(PropertyObject parent,Class<X> clazz) {
		
		for (PropertyObject ac : parent.getChildren()) {
			if (ac.getClass()==clazz) {
				return (X)ac;
			}
		}
		return null;
	}

	public static PropertyObject getUse(PropertyObject scan,String use)
	{
		if (scan.getExtend()==null) {
			return null;
		}
		String usevar=((ExtendProperties)scan.getExtend()).getUsevar();
		if ( use.equals(usevar)) {
			return scan;
		}
		
		for (PropertyObject child : scan.getChildren()) {
			PropertyObject test = getUse(child,use);
			if (test!=null) return test;
		}
		return null;
	}
	
	public static String getUniqueUse(AbstractTarget source,AbstractControl target,String requestedUse)
	{
		UseVarHelper helper = new UseVarHelper();
		helper.use(source, target,true);
		return helper.getUniqueUse(target, requestedUse);
	}

}