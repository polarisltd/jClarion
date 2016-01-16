package org.jclarion.clarion.appgen.template.service;

import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import org.jclarion.clarion.appgen.app.TextAppSource;
import org.jclarion.clarion.appgen.lang.SourceEncoder;
import org.jclarion.clarion.appgen.symbol.ListSymbolValue;
import org.jclarion.clarion.appgen.symbol.MultiSymbolEntry;
import org.jclarion.clarion.appgen.symbol.ScalarSymbolEntry;
import org.jclarion.clarion.appgen.symbol.StringSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.cmd.CodeResult;
import org.jclarion.clarion.appgen.template.cmd.TemplateCode;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public class GenReadABCFiles implements TemplateCode
{
	private static class LoadResult
	{
		private Map<String,Clazz> classes=new HashMap<String,Clazz>();
		private Map<String,Interface> interfaces=new HashMap<String,Interface>();
		private Map<String,Procedure> procs=new HashMap<String,Procedure>();
	}

	private TextAppSource libsrc;
	
	public GenReadABCFiles(TextAppSource libsrc) {
		this.libsrc=libsrc;
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		LoadResult lr = new LoadResult();
		load(libsrc,lr);
		
		ListSymbolValue className = scope.getScope().get("%pClassName").list().values();
		SymbolEntry classCategory = scope.getScope().get("%pClassCategory");
		SymbolEntry classIncFile = scope.getScope().get("%pClassIncFile");

		MultiSymbolEntry classImplementsEntry = scope.getScope().get("%pClassImplements").list();
		
		MultiSymbolEntry classMethodEntry = scope.getScope().get("%pClassMethod").list();
		MultiSymbolEntry classMethodPrototypeEntry = scope.getScope().get("%pClassMethodPrototype").list();
		
		ScalarSymbolEntry classMethodPrivate = scope.getScope().get("%pClassMethodPrivate").scalar();
		ScalarSymbolEntry classMethodExtends = scope.getScope().get("%pClassMethodExtends").scalar();
		ScalarSymbolEntry classMethodVirtual = scope.getScope().get("%pClassMethodVirtual").scalar();
		ScalarSymbolEntry classMethodProtected = scope.getScope().get("%pClassMethodProtected").scalar();
		ScalarSymbolEntry classMethodProcAttribute = scope.getScope().get("%pClassMethodProcAttribute").scalar();
		ScalarSymbolEntry classMethodInherited = scope.getScope().get("%pClassMethodInherited").scalar();
		ScalarSymbolEntry classMethodDefined = scope.getScope().get("%pClassMethodDefined").scalar();
		ScalarSymbolEntry classMethodReturnType = scope.getScope().get("%pClassMethodReturnType").scalar();
		ScalarSymbolEntry classMethodParentCall = scope.getScope().get("%pClassMethodParentCall").scalar();

		MultiSymbolEntry classPropertyEntry  =scope.getScope().get("%pClassProperty").list();
		ScalarSymbolEntry classPropertyPrototype = scope.getScope().get("%pClassPropertyPrototype").scalar();
		ScalarSymbolEntry classPropertyPrivate = scope.getScope().get("%pClassPropertyPrivate").scalar();
		ScalarSymbolEntry classPropertyProtected = scope.getScope().get("%pClassPropertyProtected").scalar();
		ScalarSymbolEntry classPropertyInherited = scope.getScope().get("%pClassPropertyInherited").scalar();
		ScalarSymbolEntry classPropertyDefined = scope.getScope().get("%pClassPropertyDefined").scalar();

		for (Clazz z : lr.classes.values()) {
			resolve(lr,z);
		}
		
		for (Clazz z : lr.classes.values()) {
			SymbolValue tmp;
			tmp=SymbolValue.construct(z.name);
			className.add(tmp);
			
			className.fix(tmp);
			ListSymbolValue classMethod = classMethodEntry.values();
			ListSymbolValue classProperty = classPropertyEntry.values();

			classCategory.scalar().setValue(SymbolValue.construct(z.category));
			classIncFile.scalar().setValue(SymbolValue.construct(z.incfile));
			
			if (!z.iList.isEmpty()) {
				ListSymbolValue classImplements = classImplementsEntry.values();
				for (String s : z.iList) {
					classImplements.add(SymbolValue.construct(s));
				}
			}
			 
			
			
			for (Procedure p : z.procs.values()) {
				
				tmp=SymbolValue.construct(p.name);
				classMethod.add(tmp);
				classMethod.fix(tmp);
				ListSymbolValue classMethodPrototype = classMethodPrototypeEntry.list().values();
				
				tmp=SymbolValue.construct(p.prototype);
				classMethodPrototype.add(tmp);
				classMethodPrototype.fix(tmp);
				
				classMethodExtends.setValue(SymbolValue.construct(p.flagExtends ? 1 : 0));
				classMethodPrivate.setValue(SymbolValue.construct(p.flagPrivate));
				classMethodVirtual.setValue(SymbolValue.construct(p.flagVirtual ||p.flagDerived ? 1 : 0 ));
				classMethodProtected.setValue(SymbolValue.construct(p.flagProtected ? 1 : 0 ));
				classMethodProcAttribute.setValue(SymbolValue.construct(p.flagProc ? 1 : 0 ));
				classMethodInherited.setValue(SymbolValue.construct(p.clazz!=z ? 1 : 0 ));
				if (p.clazz!=z || z.flagExtended) {
					classMethodDefined.setValue(SymbolValue.construct(p.clazz.name));
				} else {
					classMethodDefined.setValue(StringSymbolValue.BLANK);
				}
				classMethodReturnType.setValue(SymbolValue.construct(p.returnType));
				if (p.flagPrivate) {
					classMethodParentCall.setValue(StringSymbolValue.BLANK);
				} else {
					if (p.prototypeCall.length()>0 || p.returnType.length()>0) {
						classMethodParentCall.setValue(SymbolValue.construct("PARENT."+p.name+"("+p.prototypeCall+")"));
					} else {
						classMethodParentCall.setValue(SymbolValue.construct("PARENT."+p.name));
					}
				}
			}
			
			for (Prop p : z.props.values()) {
				tmp=SymbolValue.construct(p.name);
				classProperty.add(tmp);
				classProperty.fix(tmp);
				
				classPropertyPrototype.setValue(SymbolValue.construct(p.prototype));
				classPropertyPrivate.setValue(SymbolValue.construct(p.flagPrivate ? 1 : 0));
				classPropertyProtected.setValue(SymbolValue.construct(p.flagProtected ? 1 : 0));
				
				Prop overloaded=null;
				if (z.parentClazz!=null) {
					overloaded = z.parentClazz.props.get(p.lcname);
					if (overloaded!=null && overloaded.flagPrivate) {
						overloaded=null;
					}
					if (overloaded!=null && !overloaded.flagProtected) {
						overloaded=null;
					}
				}
				
				classPropertyInherited.setValue(SymbolValue.construct(p.clazz!=z || overloaded!=null ? 1 : 0));
				if (p.clazz!=z || z.flagExtended) {
					classPropertyDefined.setValue(SymbolValue.construct(p.clazz.name));
				} else if (overloaded!=null) {
					classPropertyDefined.setValue(SymbolValue.construct(overloaded.clazz.name));
				} else {
					classPropertyDefined.setValue(StringSymbolValue.BLANK);
				}
			}
		}
		
		ListSymbolValue interfaceName  =scope.getScope().get("%pInterface").list().values();
		SymbolEntry interfaceCategory = scope.getScope().get("%pInterfaceCategory");
		SymbolEntry interfaceIncFile = scope.getScope().get("%pInterfaceIncFile");
		
		MultiSymbolEntry interfaceMethodEntry = scope.getScope().get("%pInterfaceMethod").list();
		MultiSymbolEntry interfaceMethodPrototypeEntry = scope.getScope().get("%pInterfaceMethodPrototype").list();
				
		ScalarSymbolEntry interfaceMethodInherited = scope.getScope().get("%pInterfaceMethodInherited").scalar();
		ScalarSymbolEntry interfaceMethodDefined = scope.getScope().get("%pInterfaceMethodDefined").scalar();
		ScalarSymbolEntry interfaceMethodReturnType = scope.getScope().get("%pInterfaceMethodReturnType").scalar();
		
		
		for (Interface z : lr.interfaces.values()) {
			SymbolValue tmp;
			tmp=SymbolValue.construct(z.name);
			interfaceName.add(tmp);
			
			interfaceName.fix(tmp);
			ListSymbolValue interfaceMethod = interfaceMethodEntry.values();

			interfaceCategory.scalar().setValue(SymbolValue.construct(z.category));
			interfaceIncFile.scalar().setValue(SymbolValue.construct(z.incfile));
			
			
			for (Procedure p : z.procs.values()) {
				
				tmp=SymbolValue.construct(p.name);
				interfaceMethod.add(tmp);
				interfaceMethod.fix(tmp);
				ListSymbolValue interfaceMethodPrototype = interfaceMethodPrototypeEntry.list().values();
				
				tmp=SymbolValue.construct(p.prototype);
				interfaceMethodPrototype.add(tmp);
				interfaceMethodPrototype.fix(tmp);
				
				interfaceMethodInherited.setValue(SymbolValue.construct(p.iface!=z ? 1 : 0 ));
				if (p.iface!=z || z.flagExtended) {
					interfaceMethodDefined.setValue(SymbolValue.construct(p.iface.name));
				} else {
					interfaceMethodDefined.setValue(StringSymbolValue.BLANK);
				}
				interfaceMethodReturnType.setValue(SymbolValue.construct(p.returnType));
			}
		}		
		
		ListSymbolValue procedureName  =scope.getScope().get("%pProcedure").list().values();
		SymbolEntry procedureCategory = scope.getScope().get("%pProcedureCategory");
		SymbolEntry procedureIncFile = scope.getScope().get("%pProcedureIncFile");
		MultiSymbolEntry procedurePrototype = scope.getScope().get("%pProcedurePrototype").list();
		
		for (Procedure p : lr.procs.values()) {
			SymbolValue tmp;
			tmp=SymbolValue.construct(p.name);
			procedureName.add(tmp);
			procedureName.fix(tmp);
			
			procedureCategory.scalar().setValue(SymbolValue.construct(p.category));
			procedureIncFile.scalar().setValue(SymbolValue.construct(p.incfile));
			
			procedurePrototype.list().values().add(SymbolValue.construct(p.prototype));
		}
		
		return CodeResult.OK;
	}
	
	private void resolve(LoadResult lr,Clazz z) {
		if (z.resolved) return;
		z.resolved=true;		
		if (z.parent==null) {
			return;
		}
		z.parentClazz=lr.classes.get(z.parent.toLowerCase());
		if (z.parentClazz==null) return;
		z.parentClazz.flagExtended=true;
		resolve(lr,z.parentClazz);
		
		for (Map.Entry<String,Procedure> p : z.parentClazz.procs.entrySet()) {
			if (p.getValue().flagPrivate) continue;
			if (z.procs.containsKey(p.getKey())) continue;
			z.procs.put(p.getKey(),p.getValue());
		}

		for (Map.Entry<String,Prop> p : z.parentClazz.props.entrySet()) {
			if (p.getValue().flagPrivate) continue;
			if (z.props.containsKey(p.getKey())) continue;
			z.props.put(p.getKey(),p.getValue());
		}
	}

	private void load(TextAppSource path,LoadResult lr) 
	{
		TreeMap<String,String> incFiles = new TreeMap<String,String>(); 
		for (String src : path.getAll(null)) {
			String end = src.toLowerCase();
			if (end.endsWith(".inc")) {
				incFiles.put(end, src);
			} 
			if (end.endsWith(".int")) {
				incFiles.put(end, src);
			} 
		}
		for (String scan : incFiles.values()) {
			try {
				Lexer lexer = new Lexer(new InputStreamReader(path.open(path.get(scan))),scan);
				lexer.setJavaMode(false);
				loadIncFile(lexer,lr);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	private void loadIncFile(Lexer lexer,LoadResult lr) 
	{
		//System.out.println("Load "+lexer.getStream().getName());
		
		String incfile=lexer.getStream().getName();
		incfile="C:\\Clarion55\\libsrc\\"+incfile.toUpperCase();
		
		String type=null;
		
		while ( true ) {
			if (lexer.lookahead().type==LexType.eof) break;
			if (type==null) {
				if (lexer.lookahead().type==LexType.label) {
					return;
				}
				lexer.setIgnoreWhitespace(true);
				if (lexer.lookahead().type==LexType.comment) {
					String comment = lexer.next().value;
					if (comment.toLowerCase().startsWith("!abcincludefile")) {
						type="ABC";
						if (comment.indexOf('(')>0) {
							type=comment.substring(comment.indexOf('(')+1,comment.indexOf(')')).toUpperCase();
						}
						
					}
					readUntilEOL(lexer);
					continue;
				}				
			}
			
			Pair p = readPair(lexer);
			if (p==null) {
				readUntilEOL(lexer);
				continue;
			}
			
			if (p.type.equals("CLASS")) {
				if (type==null) return;
				Clazz c = loadClass(p.label,lexer);
				c.category=type;
				c.incfile=incfile;
				lr.classes.put(c.name.toLowerCase(),c);
				continue;
			}

			if (p.type.equals("INTERFACE")) {
				if (type==null) return;
				Interface i = loadInterface(p.label,lexer);
				i.category=type;
				i.incfile=incfile;
				lr.interfaces.put(i.name.toLowerCase(),i);
				continue;
			}

			if (p.type.equals("PROCEDURE")) {
				if (type==null) return;
				Procedure r = loadProcedure(p.label,lexer);
				r.category=type;
				r.incfile=incfile;				
				lr.procs.put(r.name+"("+r.prototypeKey+")",r);		
				continue;
			}
			
			readUntilEOL(lexer);
		}
	}
	
	public Procedure loadProcedure(String label,Lexer lexer)
	{
		Procedure p = new Procedure();
		
		p.name=label;
		
		StringBuilder prototype = new StringBuilder();
		StringBuilder prototypeKey = new StringBuilder();
		StringBuilder prototypeCall = new StringBuilder();
		StringBuilder retValue = new StringBuilder();
		
		if (lexer.lookahead().type==LexType.lparam) {
			
			lexer.next();
			
			// pop prototype as is

			boolean first=true;
			while (true) {
				Lex l = lexer.lookahead();
				if (l.type==LexType.comment || l.type==LexType.nl  || l.type==LexType.eof) {
					warn(lexer);
					break;
				}
				if (l.type==LexType.rparam) {
					lexer.next();
					break;
				}
				
				/*
				 * Build prototype
				 */
				if (prototype.length()>0) {
					prototype.append(',');
				}
				int pos = lexer.begin();			
				lexer.setIgnoreWhitespace(false);
				while (lexer.lookahead().type==LexType.ws) {
					lexer.next();
				}
				while (true) {
					Lex scan = lexer.next();
					if (scan.type==LexType.comment || scan.type==LexType.nl ) {
						warn(lexer);
						break;
					}
					if (scan.type==LexType.rparam || scan.type==LexType.param) {
						break;
					}
					toString(scan,prototype);
				}
				
				lexer.setIgnoreWhitespace(true);
				lexer.rollback(pos);
				/*
				 * done
				 */
				
				Lex type = null;
				while (true ) {
					type=lexer.next();
					if (type.type==LexType.operator) continue;
					if (type.type==LexType.comparator) continue;
					if (type.type==LexType.label && type.value.equalsIgnoreCase("const")) continue;
					break;
				}
				if (type.type!=LexType.label && type.type!=LexType.use) {
					warn(lexer,"Not label:"+type);
					break;
				}
				
				Lex name = null;
				name=lexer.next();
				if (name.type!=LexType.label) {
					warn(lexer,"Not label "+name);
				}
				

				while (true ) {
					l = lexer.lookahead();
					if (l.type==LexType.comment || l.type==LexType.nl || l.type==LexType.eof) {
						warn(lexer);
						break;
					}
					if (l.type==LexType.rparam) {
						break;
					}
					if (l.type==LexType.param) {
						lexer.next();
						break;
					}
					lexer.next();
				}

				if (first) {
					first=false;
				} else {
					prototypeKey.append(',');
					prototypeCall.append(',');
				}
				prototypeKey.append(type.value.toString().toUpperCase());
				prototypeCall.append(name.value.toString());
			}
		}
		
		boolean first=true;
		while ( lexer.lookahead().type==LexType.param) {
			lexer.next();
			Lex type = lexer.next();
			
			if (type.type==LexType.label && type.value.equalsIgnoreCase("VIRTUAL")) {
				p.flagVirtual=true;
				continue;
			}
			if (type.type==LexType.label && type.value.equalsIgnoreCase("PROTECTED")) {
				p.flagProtected=true;
				continue;
			}
			if (type.type==LexType.label && type.value.equalsIgnoreCase("PRIVATE")) {
				p.flagPrivate=true;
				continue;
			}
			if (type.type==LexType.label && type.value.equalsIgnoreCase("DERIVED")) {
				p.flagDerived=true;
				continue;
			}
			if (type.type==LexType.label && type.value.equalsIgnoreCase("PASCAL")) {
				continue;
			}
			if (type.type==LexType.label && type.value.equalsIgnoreCase("PROC")) {
				p.flagProc=true;
				continue;
			}
			
			if (first) {
				first=false;
				toString(type,retValue);
				while ( true) {
					if (lexer.lookahead().type==LexType.param) break;
					if (lexer.lookahead().type==LexType.comment) break;
					if (lexer.lookahead().type==LexType.nl) break;
					if (lexer.lookahead().type==LexType.eof) break;
					type = lexer.next();
					toString(type,retValue);
				}
				continue;
			} 
			warn(lexer,"Unknown:"+type);			
		}
				
		// skip line
		while (true ) {
			Lex l = lexer.next();
			if (l.type==LexType.comment) {
				String comment = l.value.toUpperCase();
				if (comment.contains(",EXTENDS")) {
					p.flagExtends=true;
				}
			}
			if (l.type==LexType.nl) break; 
			if (l.type==LexType.eof) break; 
		}		
		
		
		p.prototype="("+prototype.toString()+")"+(retValue.length()>0 ? ","+retValue.toString() : ""); 
		p.prototypeCall=prototypeCall.toString();
		p.prototypeKey=prototypeKey.toString();
		p.returnType=retValue.toString();
		return p;
		
	}
	
	private Clazz loadClass(String label, Lexer lexer) 
	{		
		Clazz c = new Clazz();
		c.name=label;
		
		Lex[][] params = popParams(lexer);
		if (params!=null) {
			if (params.length>1) {
				warn(lexer,"Param length weird");
			}
			if (params.length>0) {
				if (params[0].length!=1) {
					warn(lexer,"Param length weird");
				} 					
				if (params[0].length>0) {
					if (params[0][0].type!=LexType.label) warn(lexer,"class unexpected");
					c.parent=params[0][0].value;
				}
			}
		}
		
		while ( true ) {
			if (lexer.lookahead().type==LexType.comment) break;
			if (lexer.lookahead().type==LexType.nl) break;
			
			if (lexer.lookahead().type!=LexType.param) {
				warn(lexer,"Unexpected "+lexer.lookahead());
				break;
			}
			
			lexer.next();
			Lex type = lexer.lookahead();
			if (type.type!=LexType.label) {
				warn(lexer);
				break;
			}
			lexer.next();
			
			params = popParams(lexer);
			if (type.value.equalsIgnoreCase("TYPE")) continue;
			if (type.value.equalsIgnoreCase("MODULE")) continue;
			if (type.value.equalsIgnoreCase("LINK")) continue;
			if (type.value.equalsIgnoreCase("THREAD")) continue;
			if (type.value.equalsIgnoreCase("EXTERNAL")) continue;
			if (type.value.equalsIgnoreCase("DLL")) continue;
			
			if (type.value.equals("IMPLEMENTS")) {
				if (params.length!=1 || params[0].length!=1) {
					warn(lexer);
				} else {
					c.iList.add(params[0][0].value);
				}
				continue;
			}
			
			warn(lexer,"unknown :"+type);
		}				
		this.readUntilEOL(lexer);
		
		int endDepth=0;
		
		while ( endDepth>=0 ) {
			if (lexer.lookahead().type==LexType.eof) {
				warn(lexer,"Unexpected EOF");
				break;
			}
			Pair p = readPair(lexer);
			if (p!=null) {

				if (p.type.equalsIgnoreCase("PROCEDURE")) {
					Procedure proc = loadProcedure(p.label, lexer);
					proc.clazz=c;
					c.addProcedure(proc);
				} else {
					boolean ignore=false;
					if (p.type.equalsIgnoreCase("GROUP")) {
						endDepth++;
						ignore=true;
					}
					if (p.type.equalsIgnoreCase("CLASS")) {
						warn(lexer,"Nested Class");
						endDepth++;
					}
					
					params=popParams(lexer); // definition
					
					Prop prop = new Prop();
					prop.clazz=c;
					prop.name=p.label;
					
					StringBuilder prototype = new StringBuilder();
					prototype.append(p.type);
					if (params!=null) {
						prototype.append('(');
						toString(params,prototype);
						prototype.append(')');
					}
					
					
					while ( true ) {
						if (lexer.lookahead().type==LexType.comment) break;
						if (lexer.lookahead().type==LexType.nl) break;
						
						if (lexer.lookahead().type==LexType.dot) {
							endDepth--;
							break;
						}
						
						if (lexer.lookahead().type!=LexType.param) {
							warn(lexer,"Unexpected "+lexer.lookahead());
							break;
						}
						
						lexer.next();
						Lex type = lexer.lookahead();
						if (type.type!=LexType.label) {
							warn(lexer);
							break;
						}
						lexer.next();
						
						params = popParams(lexer);
						if (type.value.equals("PROTECTED")) {
							prop.flagProtected=true;
							continue;
						}
						if (type.value.equals("PRIVATE")) {
							prop.flagPrivate=true;
							continue;
						}
						if (type.value.equals("DIM")) {
							prototype.append(",DIM(");
							toString(params,prototype);
							prototype.append(")");
							continue;
						}
						if (type.value.equals("STATIC")) {
							prototype.append(",STATIC");
							continue;							
						}
						if (type.value.equals("AUTO")) {
							//prototype.append(",AUTO");
							continue;							
						}
						warn(lexer,"unknown :"+type.value);
					}
					
					if (!ignore) { 
						prop.prototype=prototype.toString();
						prop.lcname=prop.name.toLowerCase();
						c.props.put(prop.lcname,prop);
					}
					
					readUntilEOL(lexer);
				}
				
			} else {
				lexer.setIgnoreWhitespace(true);
				if (lexer.lookahead().value.equals(".") || lexer.lookahead().value.equalsIgnoreCase("end")) {
					endDepth--;
				}
				readUntilEOL(lexer);
			}
		}
		
		return c;
	}

	private Interface loadInterface(String label, Lexer lexer) 
	{		
		Interface c = new Interface();
		c.name=label;
		
		Lex[][] params = popParams(lexer);
		if (params!=null) {
			if (params.length>1) {
				warn(lexer,"Param length weird");
			}
			if (params.length>0) {
				if (params[0].length!=1) {
					warn(lexer,"Param length weird");
				} 					
				if (params[0].length>0) {
					if (params[0][0].type!=LexType.label) warn(lexer,"class unexpected");
					c.parent=params[0][0].value;
					warn(lexer,"Cannot cope with this:"+c.parent);
				}
			}
		}
		
		while ( true ) {
			if (lexer.lookahead().type==LexType.comment) break;
			if (lexer.lookahead().type==LexType.nl) break;
			
			if (lexer.lookahead().type!=LexType.param) {
				warn(lexer,"Unexpected "+lexer.lookahead());
				break;
			}
			
			lexer.next();
			Lex type = lexer.lookahead();
			if (type.type!=LexType.label) {
				warn(lexer);
				break;
			}
			lexer.next();
			
			params = popParams(lexer);
			
			warn(lexer,"unknown :"+type);
		}				
		this.readUntilEOL(lexer);
		
		int endDepth=0;
		
		while ( endDepth>=0 ) {
			if (lexer.lookahead().type==LexType.eof) {
				warn(lexer,"Unexpected EOF");
				break;
			}
			Pair p = readPair(lexer);
			if (p!=null) {
				if (!p.type.equals("PROCEDURE")) {
					warn(lexer,"Do not know what this is");
				} else {
					Procedure proc = loadProcedure(p.label, lexer);
					proc.iface=c;
					c.addProcedure(proc);
				}
			} else {
				lexer.setIgnoreWhitespace(true);
				if (lexer.lookahead().value.equals(".") || lexer.lookahead().value.equalsIgnoreCase("end")) {
					endDepth--;
				}
				readUntilEOL(lexer);
			}
		}
		
		return c;
	}
	
	private void toString(Lex[] in,StringBuilder out)
	{
		for (Lex l : in) {
			toString(l,out);
		}
	}

	private void toString(Lex in,StringBuilder out)
	{
		if (in.type==LexType.string) {
			try {
				SourceEncoder.encodeString(in.value,out,true);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			out.append(in.value);
		}
	}

	private void toString(Lex[][] in,StringBuilder out)
	{
		boolean first=true;
		for (Lex l[] : in) {
			if (first) {
				first=false;
			} else {
				out.append(",");
			}
			toString(l,out);
		}
	}

	private Lex[][] popParams(Lexer lexer) {
		if (lexer.lookahead().type!=LexType.lparam) return null;
		lexer.next();
		if (lexer.lookahead().type==LexType.rparam) {
			lexer.next();
			return new Lex[0][];
		}
		List<Lex[]> result = new ArrayList<Lex[]>();
		
		List<Lex> last=new ArrayList<Lex>();
		while (true) {
			Lex l = lexer.lookahead();
			if (l.type==LexType.nl || l.type==LexType.comment) {
				warn(lexer,"Expered )");
				break;
			}
			l = lexer.next();
			if (l.type==LexType.rparam) {
				result.add(last.toArray(new Lex[last.size()]));
				last.clear();
				break;
			}
			if (l.type==LexType.param) {
				result.add(last.toArray(new Lex[last.size()]));
				last.clear();
				continue;
			}
			last.add(l);
		}
		return result.toArray(new Lex[result.size()][]);
	}

	private void warn(Lexer lexer) 
	{
		warn(lexer,"?");
	}
	
	private void warn(Lexer lexer, String string) 
	{
		try {
			throw new Throwable(string+" "+lexer.getStream().getLineCount()+" "+lexer.getStream().getName());
		} catch (Throwable t) {
			t.printStackTrace();
		}
	}

	private static class Procedure
	{
		public boolean flagExtends;
		public String incfile;
		public String category;
		public Interface iface;
		public Clazz clazz;
		public boolean flagDerived;
		public boolean flagProc;
		public boolean flagPrivate;
		private String name;
		private String prototype;
		private String prototypeKey;
		private String prototypeCall;
		private boolean flagVirtual;
		private boolean flagProtected;
		private String  returnType;
	}
	
	private static class Clazz
	{
		public Clazz parentClazz;
		public boolean resolved;
		public boolean flagExtended;
		public String incfile;
		public Set<String> iList = new TreeSet<String>();
		private String name;
		private String category;
		private String parent;
		
		public Map<String,Prop> props = new LinkedHashMap<String,Prop>();
		public Map<String,Procedure> procs = new LinkedHashMap<String,Procedure>();

		public void addProcedure(Procedure proc) {
			procs.put(proc.name+"("+proc.prototype+")",proc);
		}
	}

	private static class Interface
	{
		public boolean flagExtended;
		public String incfile;
		public String category;
		private String name;
		private String parent;
		
		public Map<String,Procedure> procs = new LinkedHashMap<String,Procedure>();

		public void addProcedure(Procedure proc) {
			procs.put(proc.name+"("+proc.prototype+")",proc);
		}
	}
	
	private static class Prop
	{
		public String lcname;
		public Clazz clazz;
		private String name;
		private String prototype;
		private boolean flagPrivate;
		private boolean flagProtected;
		
		@Override
		public String toString() {
			return "Prop [name=" + name + ", prototype=" + prototype
					+ ", flagPrivate=" + flagPrivate + ", flagProtected="
					+ flagProtected + "]";
		}
	}
	
	private static class Pair
	{
		private String label;
		private String type;
		
		public String toString()
		{
			return label+" "+type;
		}
	}
	
	private Pair readPair(Lexer lexer)
	{
		lexer.setIgnoreWhitespace(false);
		if (lexer.lookahead().type==LexType.label && lexer.lookahead(1).type==LexType.ws) {
			String label = lexer.next().value;
			lexer.setIgnoreWhitespace(true);
			if (lexer.lookahead().type==LexType.label) {
				Pair p = new Pair();
				p.label=label;
				p.type=lexer.next().value.toUpperCase();
				return p;
			} else if (lexer.lookahead().type==LexType.reference && lexer.lookahead(1).type==LexType.label) {
				Pair p = new Pair();
				p.label=label;
				p.type=lexer.next().value+(lexer.next().value.toUpperCase());
				return p;
			} else {
				warn(lexer,lexer.lookahead().toString());
			}
		}		
		return null;
	}
	
	private void readUntilEOL(Lexer lexer)
	{
		// skip line
		while (true ) {
			Lex l = lexer.next();
			if (l.type==LexType.nl) break; 
			if (l.type==LexType.eof) break; 
		}		
	}

}
