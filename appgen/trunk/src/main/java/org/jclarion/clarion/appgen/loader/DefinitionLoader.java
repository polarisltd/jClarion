package org.jclarion.clarion.appgen.loader;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.appgen.symbol.DefinitionObject;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public class DefinitionLoader {

	private static Set<String> nestedTypes=new HashSet<String>();
	static {
		nestedTypes.add("application");
		nestedTypes.add("window");
		nestedTypes.add("sheet");
		nestedTypes.add("tab");
		nestedTypes.add("group");
		nestedTypes.add("option");
		nestedTypes.add("group");
		nestedTypes.add("toolbar");
		nestedTypes.add("menubar");
		nestedTypes.add("menu");
		nestedTypes.add("detail");
		nestedTypes.add("header");
		nestedTypes.add("footer");
		nestedTypes.add("break");
	};

	public static Definition construct(ClarionObject co)
	{
		if (co instanceof DefinitionObject) {
			return ((DefinitionObject)co).getDefinition();
		}
		return loadItem(co.toString());
	}
	
	public static Definition loadItem(String content)
	{
		Lexer lexer = new Lexer(new StringReader(content));
		lexer.setJavaMode(false);
		lexer.setDecodeInteger(false);
		return loadItem(lexer);
	}
	
	public static Definition loadStructure(String content)
	{
		Lexer lexer = new Lexer(new StringReader(content));
		lexer.setJavaMode(false);
		lexer.setDecodeInteger(false);
				
		Definition result=null;
		Definition parent=null;
		
		int indent=0;
		
		while ( true ) {
			lexer.setIgnoreWhitespace(true);
			if (lexer.lookahead().type==LexType.eof) {
				break;
			}
			boolean end=false;
			if (lexer.lookahead().type==LexType.dot) {
				end=true;
			} else
			if (lexer.lookahead().type==LexType.label && lexer.lookahead().value.equalsIgnoreCase("end")) {
				end=true;
			}
			if (end) {
				while (true) {
					Lex l = lexer.next();
					if (l.type==LexType.nl) break;
					if (l.type==LexType.eof) break;
				}
				parent=parent.getParent();
				indent--;
				if (parent==null) break;
				continue;
			}

			Definition ci = loadItem(lexer);
			
			if (parent==null) {
				parent=ci;
				result=ci;
			} else {
				parent.addItem(ci);
			}
			ci.setIndent(indent);
			if (nestedTypes.contains(ci.getTypeProperty().getName().toLowerCase())) {
				parent=ci;
				indent++;
			}
		}
		
		//debug(result,0);
		
		return result;
	}
	
	
	/*
	private static void debug(Definition result,int depth) 
	{
		for (int scan=0;scan<depth;scan++) {
			System.out.print("  ");
		}
		System.out.println(result);
		if (result.getChildren()!=null) {
			for (Definition d : result.getChildren()) {
				debug(d,depth+1);
			}
		}
	}
	*/

	public static Definition loadItem(Lexer l)
	{
		String label = null;
		l.setIgnoreWhitespace(false);				
		if (l.lookahead().type==LexType.label && l.lookahead(1).type==LexType.ws && (
				l.lookahead(2).type==LexType.label || l.lookahead(2).type==LexType.reference) 
		) {
			label=l.next().value;
		}
		
		String whitespace="";
		if (l.lookahead().type==LexType.ws) {
			whitespace=l.next().value;
		}
		
		Definition ci = new Definition(label,whitespace);
		
		boolean expectComma=false;
		while ( true ) {			
			l.setIgnoreWhitespace(false);		
			if (l.lookahead().value.equals("{")) {
				break;
			}
			if (l.lookahead().type==LexType.nl) {
				l.next();
				break;
			}
			if (l.lookahead().type==LexType.comment) {
				ci.setComment(l.next().value.substring(1));
				break;
			}
			if (l.lookahead().type==LexType.eof) break;
			if (expectComma) {
				if (l.lookahead().type==LexType.ws) {
					l.next();
					continue;
				}
				if (l.lookahead().type!=LexType.param && l.lookahead().type!=LexType.reference) {
					error(l,"Expected comma or end of line");
				}
				expectComma=false;
				l.next();
				continue;
			}

			l.setIgnoreWhitespace(true);		
			
			String type;
			if (l.lookahead().type==LexType.label) {
				type=l.next().value;
			} else 
			if (l.lookahead().type==LexType.implicit && l.lookahead().value.equals("#") && l.lookahead(1).type==LexType.label) {
				type=l.next().value+l.next().value;
			} else 
			if (l.lookahead().type==LexType.reference && l.lookahead(1).type==LexType.label) {
					type=l.next().value+l.next().value;
			} else {
				error(l,"Expected label. Got "+l.lookahead());
				break;
			}

			List<Lex> params=popParams(type,l);
			
			DefinitionProperty prop = new DefinitionProperty(type,params);
			
			ci.add(prop);
			
			expectComma=true;
		}
		
		return ci;
	}

	private static List<Lex> popParams(String type,Lexer l) {
		List<Lex> params=new ArrayList<Lex>();

		if (l.lookahead().type==LexType.lparam) {
			
			l.next();

			Lex add=null;
			boolean any=false;
			while (true ) {
				Lex next = l.next();
				
				if (next.type==LexType.param) {
					params.add(add);
					any=true;
					add=null;
					continue;
				} else 		
				if (next.type==LexType.rparam) {
					if (any) {
						params.add(add);
					}							
					break;
				} else
				if (add!=null) {
					error(l,"Expected , or ) in ");							
				} else
				if (next.type==LexType.label && l.lookahead().type==LexType.lparam && type.equalsIgnoreCase("valid")) {					
					List<Lex> sub=popParams(type,l);
					params.add(next);
					params.addAll(sub);
					add=params.remove(params.size()-1);					
				} else
				if ((next.type==LexType.label && (type.equalsIgnoreCase("use") || type.equalsIgnoreCase("#orig"))) || next.type==LexType.use) {
					// anything goes
					while (true) {
						Lex la = l.lookahead();
						if (la.type==LexType.lbrack || la.type==LexType.rbrack || la.type==LexType.integer || la.type==LexType.label || la.type==LexType.dot) {
							next=new Lex(LexType.use,next.value+l.next().value);
						} else {
							break;
						}
					}
					add=next;
				} else
				if (next.type==LexType.label || next.type==LexType.picture || next.type==LexType.integer || next.type==LexType.decimal) {
					while (true) {
						Lex la = l.lookahead();
						if (la.type==LexType.operator || la.type==LexType.label || la.type==LexType.dot) {
							next=new Lex(LexType.label,next.value+l.next().value);
						} else {
							break;
						}
					}
					add=next;
				} else 					
				if (next.type==LexType.string) {
					while (l.lookahead().type==LexType.reference && l.lookahead(1).type==LexType.string) {
						l.next();
						next=new Lex(LexType.string,next.value+l.next().value);
					}
					add=next;
				} else
				if (next.type==LexType.operator && next.value.equals("-") && l.lookahead().type==LexType.integer) {
					add=new Lex(LexType.integer,next.value+l.next().value);
				} else 
				if (next.type==LexType.operator && next.value.equals("-") && l.lookahead().type==LexType.label && type.equalsIgnoreCase("KEY")) {
					add=new Lex(LexType.label,next.value+l.next().value);
				} else {
					error(l,"Expected string/label/number/picture. Got : "+next);
				}
				any=true;
			}
		}
		return params;
	}

	private static void error(Lexer l, String string) {
		l.debug(string);
		System.exit(0);
	}
}

