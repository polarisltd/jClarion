package org.jclarion.clarion.appgen.dict;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.appgen.loader.DefinitionLoader;
import org.jclarion.clarion.appgen.loader.DefinitionProperty;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public class TextDictLoad 
{
	private static Set<String> create(String ...items)
	{
		HashSet<String> result = new HashSet<String>();
		for (String s : items) {
			result.add(s);
		}
		return result;
	}

	private static final Set<String> FILE_EXTRACT=create("IDENT","USAGE");
	private static final Set<String> FIELD_EXTRACT=create("IDENT","PROMPT","HEADER","JUSTIFY","MESSAGE","TOOLTIP",
			"PICTURE","VALID","PASSWORD","VALUES","CASE","FREEZE","DERIVEDFROM","INITIAL","TRUEVALUE","FALSEVALUE","READONLY");
	private static final Set<String> KEY_EXTRACT=create("IDENT","AUTO");
	
	
	public static void main(String args[]) throws IOException
	{
		TextDictLoad loader = new TextDictLoad();
		long start=System.currentTimeMillis();
		Dict d = loader.load("target/app/c8odbc.dict");
		long end=System.currentTimeMillis();
		System.out.println("Load:"+(end-start));
		
		TextDictStore store = new TextDictStore();
		FileWriter fw =new FileWriter("target/app/c8odbc2.dict"); 
		store.save(d,fw);
		fw.close();			
	}

	public Dict load(String filename) throws IOException
	{
		Lexer l = new Lexer(new FileReader(filename));
		l.setJavaMode(false);
		return load(l);
	}

	public Dict load(InputStream stream) throws IOException
	{
		Lexer l = new Lexer(new InputStreamReader(stream));
		l.setJavaMode(false);
		return load(l);
	}
	
	public Dict load(Lexer src)
	{
        System.out.println("load(Lexer) ENTRY");
		Dict result = new Dict();
		while ( src.lookahead().type!=LexType.eof) {
			src.setIgnoreWhitespace(true);
			if (src.lookahead().type==LexType.nl) {
				src.next();
				continue;
			}
			if (src.lookahead().type==LexType.comment) {
				src.next();
				continue;
			}				
			if (src.lookahead(0).type==LexType.label && src.lookahead(1).type==LexType.label && src.lookahead(1).value.equalsIgnoreCase("file")) {
				loadFile(result,src);
				continue;
			}
			
			if (src.lookahead(0).type==LexType.label && src.lookahead(0).value.equalsIgnoreCase("relate")) {
				loadRelation(result,src);
				continue;
			}
			
			src.error("Unknown");
		}		
		return result;
	}

	private void loadRelation(Dict result, Lexer src) 
	{
		File from=null;
		Key fromKey=null;
		File to=null;
		Key toKey=null;
		
		src.setIgnoreWhitespace(true);
		Lex relation = src.next(); 
		if (relation.type!=LexType.label || !relation.value.equalsIgnoreCase("relate")) src.error("Expected label");
		
		
		
		Lex lex = src.next();
		if (lex.type!=LexType.label) src.error("Expected label");
		if (lex.value.indexOf(':')>-1) {
			fromKey = loadKey(result,lex.value);
			from=fromKey.getFile();
		} else {
			from = result.getFile(lex.value);
		}
		
		lex = src.next();
		if (lex.type!=LexType.comparator) src.error("Expected < or > ");
		boolean oneToMany=true;
		if (lex.value.equals("<")) {
			oneToMany=true;
		} else if (lex.value.equals(">")) {
			oneToMany=false;
		} else {
			src.error("Expected < or > ");
		}
		
		lex=src.next();
		if (lex.type!=LexType.label) src.error("Expected label");
		if (lex.value.indexOf(':')>-1) {
			toKey = loadKey(result,lex.value);
			to=toKey.getFile();
		} else {
			to = result.getFile(lex.value);
		}
		
		String delete="";
		String update="";
		
		while ( true ) {
			lex=  src.next();
			if (lex.type==LexType.comment) continue;
			if (lex.type==LexType.eof) break;
			if (lex.type==LexType.nl) break;
			
			if (lex.type==LexType.label)
			{
				String type = lex.value;
				lex = src.next();
				if (lex.type!=LexType.lparam) src.error("Expected (");
				
				lex = src.next();
				if (lex.type!=LexType.label) src.error("Expected label");
				
				String value = lex.value;
				
				lex = src.next();
				if (lex.type!=LexType.rparam) src.error("Expected (");
				
				if (type.equalsIgnoreCase("delete")) {
					delete=value;
					continue;
				}
				if (type.equalsIgnoreCase("update")) {
					update=value;
					continue;
				}
				src.error("expected delete or update");
			}
		}
		
		RelationKey fromRel =  from.addRelationKey(from,fromKey,oneToMany);
		RelationKey toRel =  to.addRelationKey(to,toKey,!oneToMany);
		fromRel.join(toRel);
		result.addRelation(fromRel);
		
		fromRel.setDeleteMode(delete);
		toRel.setDeleteMode(delete);
		fromRel.setUpdateMode(update);
		toRel.setUpdateMode(update);
		
		List<Field> fromFields=new ArrayList<Field>();
		List<Field> toFields=new ArrayList<Field>();
		
		while ( true ) {
			src.setIgnoreWhitespace(true);
			if (src.lookahead().type==LexType.eof) break;
			if (src.lookahead().type==LexType.nl) {
				src.next();
				continue;
			}
			if (src.lookahead().type==LexType.comment) {
				src.next();
				continue;
			}
			
			if (src.lookahead().type==LexType.label && src.lookahead().value.equalsIgnoreCase("end")) {
				readLine(src);
				break;
			}

			if (src.lookahead().type==LexType.dot) {
				readLine(src);
				break;
			}

			if (src.lookahead(0).type!=LexType.label) src.error("Expected Label");
			if (src.lookahead(1).type!=LexType.comparator || !src.lookahead(1).value.equals("=")) src.error("Expected =");
			if (src.lookahead(2).type!=LexType.label) src.error("Expected Label");
			
			String fieldA = src.next().value;
			src.next();
			String fieldB = src.next().value;
			
			int colon = fieldA.indexOf(':');
			if (fieldA.substring(0,colon).equalsIgnoreCase(to.getFile().getValue("pre"))) {
				String swap = fieldA;
				fieldA=fieldB;
				fieldB=swap;
			}
			
			fieldA=fieldA.substring(fieldA.indexOf(':')+1);
			fieldB=fieldB.substring(fieldA.indexOf(':')+1);
			
			fromFields.add(from.getField(fieldA));
			toFields.add(to.getField(fieldB));
		}
		
		// add joins
		
		
		addJoins(fromRel,fromFields,toFields);
		addJoins(toRel,toFields,fromFields);
	}
	
	private void addJoins(RelationKey rel, List<Field> fromFields,List<Field> toFields) 
	{
		DefinitionProperty prop = rel.getKey()==null ? null : rel.getKey().getKey().getTypeProperty(); 
		int count=prop==null ? fromFields.size() :  prop.getPropCount();
		
		for (int scan=0;scan<count;scan++) {
			Field from = fromFields.size()>scan ? fromFields.get(scan) : null;
			Field to = toFields.size()>scan ? toFields.get(scan) : null;
			if (from==null && to==null) continue;
			rel.addRelationship(from, to);
		}
	}

	private Key loadKey(Dict result, String value) 
	{
		int colon = value.indexOf(':');
		return result.getFileByPrefix(value.substring(0,colon)).getKey(value.substring(colon+1));
	}

	private void loadFile(Dict result, Lexer src) 
	{
		File f = new File();
		Definition d = DefinitionLoader.loadItem(src);
		Definition extract = extract(d,FILE_EXTRACT);
		
		if (d.getProperty("LONGDESC")!=null) {
			String desc = d.getProperty("LONGDESC").get(0).getString();
			f.setDescription(desc);			
			d=d.remove("LONGDESC");
		}
		
		f.setFile(d);
		f.addParams(extract);
		Field lastField=null;
		
		while ( true ) {
			src.setIgnoreWhitespace(true);
			if (src.lookahead().type==LexType.eof) break;
			if (src.lookahead().type==LexType.nl) {
				src.next();
				continue;
			}
			if (src.lookahead().type==LexType.comment) {
				src.next();
				continue;
			}
			
			
			
			if (src.lookahead().type==LexType.label && src.lookahead().value.equalsIgnoreCase("end")) {
				readLine(src);
				break;
			}

			if (src.lookahead().type==LexType.dot) {
				readLine(src);
				break;
			}
			
			if (src.lookahead().type==LexType.implicit && src.lookahead().value.equals("#") && src.lookahead(1).type==LexType.label) {
				src.next();
				String type = src.next().value.toUpperCase();
				d = DefinitionLoader.loadItem(src);
				if (type.equals("SCREEN")) {
					lastField.addScreenControl(d);
					continue;
				}
				if (type.equals("REPORT")) {
					lastField.addReportControl(d);
					continue;
				}
				if (type.equals("QUICK")) {
					lastField.addQuickCode(d);
					continue;
				}
				src.error("What is this?");
			}
			
			if (src.lookahead(1).value.equalsIgnoreCase("KEY")) {
				Key key = new Key();
				d = DefinitionLoader.loadItem(src);
				extract = extract(d,KEY_EXTRACT);
				key.setKey(d);
				key.addParams(extract);
				f.addKey(key);
				continue;
			}
			
			if (src.lookahead(1).value.equalsIgnoreCase("RECORD")) {
				f.setRecord(DefinitionLoader.loadItem(src));
				continue;
			}
			
			if (src.lookahead(1).type==LexType.label) {
				Field field = new Field();
				d = DefinitionLoader.loadItem(src);
				extract = extract(d,FIELD_EXTRACT);
				field.setField(d);
				field.addParams(extract);
				f.addField(field);
				lastField=field;
				continue;
			}
			
			src.error("What is this?");
		}
		result.addFile(f);
	}

	private void readLine(Lexer src) {
		while (true) {
			Lex l = src.next();
			if (l.type==LexType.nl) break;
			if (l.type==LexType.eof) break;
		}
	}
	
	

	private Definition extract(Definition d, Set<String> items) 
	{
		return d.split(items);
	}
}
