package org.jclarion.clarion.appgen.dict;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.appgen.loader.DefinitionProperty;
import org.jclarion.clarion.appgen.loader.GenericLoader;
import org.jclarion.clarion.lang.Lex;


public class DictLoader {
	
	public static void main(String args[]) throws IOException 
	{
		DictLoader al = new DictLoader();
		long start=System.currentTimeMillis();
		al.loadDictionary("/home/barney/personal/c8/java/clarion/c9/src/main/clarion/common/c8odbc.txd");
		long end=System.currentTimeMillis();
		System.out.println("Load time:"+(end-start));

		/*
		start=System.currentTimeMillis();
		al.loadDictionary("/home/barney/personal/c8/java/clarion/c9/src/main/clarion/common/c8odbc.txd");
		end=System.currentTimeMillis();
		System.out.println("Load time:"+(end-start));
		*/

	}

	private GenericLoader l;
	
	// app settings
	
	public Dict loadDictionary(String fileName) throws IOException 
	{
		return loadDictionary(new BufferedReader(new FileReader(fileName)));
	}

	private Dict loadDictionary(BufferedReader reader) throws IOException
	{
		this.l=new GenericLoader(reader);
		return loadDictionary();
	}

	public Dict loadDictionary() throws IOException
	{
		if ("[VERSION2]".equals(l.la())) {
			l.next();
		}
		if (!"[DICTIONARY]".equals(l.next())) throw new IOException("Expected Dictionary definition");
		
		Dict d = new Dict();
		
		while (!l.la().startsWith("[")) {
			List<Lex> result = l.decode();
			if (result.size()==0) continue;
			if (result.size()==2 && result.get(0).value.equals("VERSION")) {
				d.setVersion(result.get(1).value);
				continue;
			}
			l.lineError("Unknown line");
		}
		
		d.setLongDesc(popLongDesc());
		
		if (l.la().equals("[FILES]")) {
			loadFiles(d);
		}

		if (l.la()!=null) {
			if (l.la().equals("[RELATIONS]")) {
				loadRelations(d);
			}
		}
		
		if (l.next()!=null) {
			l.lineError("Expected EOF");
		}
		
		return d;
	}
	
	public void loadFiles(Dict d) throws IOException
	{
		if (!"[FILES]".equals(l.next())) throw new IOException("Expected Dictionary definition");
		
		while (true) {
			if (l.la()==null) break;
			if (l.la().startsWith("[") && !l.la().equals("[LONGDESC]")) break;
			if (l.la().equals("")) {
				l.next();
				continue;
			}
			d.addFile(loadFile());
		}
	}

	public void loadRelations(Dict d) throws IOException
	{
		if (!"[RELATIONS]".equals(l.next())) throw new IOException("Expected Dictionary definition");
		
		
		while (true) {
			if (l.la()==null) break;
			if (l.la().trim().equals("")) {
				l.next();
				continue;
			}

			String next = l.next();			
			Definition rel = l.getDefintion(next);
			if (!rel.getTypeName().equals("RELATION")) l.lineError("Expected relation");
			if (rel.size()==0) l.lineError("relation type undefined");
			String deleteMode="";
			String updateMode="";
			boolean many=false;
			for (DefinitionProperty param : rel ) {
				if (param.getName().equals("RELATION")) {
					continue;
				}
				if (param.getName().equals("ONE:MANY")) {
					many=true;
					continue;
				}
				if (param.getName().equals("MANY:ONE")) {
					many=false;
					continue;
				}
				if (param.getName().equals("DELETE")) {
					deleteMode=rel.getProperty("DELETE").get(0).getString();
					continue;
				}			
				if (param.getName().equals("UPDATE")) {
					updateMode=rel.getProperty("UPDATE").get(0).getString();
					continue;
				}			
				l.lineError("Unknown type:"+param);				
			}
			
			RelationKey file = getRelationKey(d,"FILE",many);
			RelationKey related = getRelationKey(d,"RELATED_FILE",!many);
			
			//System.out.println(file.toString()+"  => "+related.toString()+" "+many);
			
			file.setDeleteMode(deleteMode);
			file.setUpdateMode(updateMode);
			related.setDeleteMode(deleteMode);
			related.setUpdateMode(updateMode);
			file.join(related);
			
			if (related.getKey()!=null) relateFields(file,"FILE_TO_RELATED_KEY");
			if (file.getKey()!=null) relateFields(related,"RELATED_FILE_TO_KEY");
			if (!l.next().trim().equals("END")) l.lineError("Invalid");
			
			d.addRelation(file);
			d.addRelation(related);
		}
	}
	
	private void relateFields(RelationKey file, String name) throws IOException 
	{
		if (!l.next().trim().equals(name)) l.lineError("Invalid");
		
		while ( true ) {
			if (l.la().trim().equals("END")) {
				l.next();
				return;
			}
			Definition rel = l.getDefintion();
			if (!rel.getTypeName().equals("FIELD")) l.lineError("Invalid type");
			if (rel.getTypeProperty().size()!=2) l.lineError("Invalid type");
			
			String f1 = rel.getTypeProperty().get(0).getString();
			String f2 = rel.getTypeProperty().get(1).getString();
			
			Field from=null;
			Field to=null;
			
			if (f1.equals("NOLINK")) {
				from=null; 
			} else {
				from=file.getFile().getField(f1);
				if (from==null) l.lineError("Field not found");
			}
			to = file.getOther().getFile().getField(f2);
			if (to==null) l.lineError("Field not found");
			file.addRelationship(from,to);			
		}
	}

	private RelationKey getRelationKey(Dict d,String name,boolean many) throws IOException 
	{
		Definition rel = l.getDefintion();
		if (!rel.getTypeName().equals(name)) l.lineError("Invalid type");
		
		File f = d.getFile(rel.getName());
		if (f==null) l.lineError("file not found");

		if (rel.getTypeProperty().size()==0) {
			return f.addRelationKey(f,null,many);
		}
				
		if (rel.getTypeProperty().size()!=1) l.lineError("no key");
		
		
		Key k = f.getKey(rel.getTypeProperty().get(0).getString());
		if (k==null) l.lineError("key not found");
		
		return f.addRelationKey(f,k,many);
	}

	private static Set<String> allowedFields=new HashSet<String>();
	static {
		allowedFields.add("LONG");
		allowedFields.add("STRING");
		allowedFields.add("BYTE");
		allowedFields.add("SHORT");
		allowedFields.add("DECIMAL");
		allowedFields.add("DATE");
		allowedFields.add("TIME");
		allowedFields.add("USHORT");
		allowedFields.add("PDECIMAL");
	}

	private File loadFile() throws IOException 
	{
		
		File f=null;
		int depth=0;  // 0 = keys. 1 = record. 2 = fields.
		Identity last=null;
		
		String nextDescription=null;
		List<Definition> nextScreenControls=null;
		List<Definition> nextReportControls=null;
		List<Definition> nextQuickCode=null;
		
		while ( true ) {
			if (l.la().equals("[LONGDESC]")) {
				nextDescription=popLongDesc();
				continue;
			}

			if (l.la().equals("[SCREENCONTROLS]")) {
				if (nextScreenControls!=null) l.lineError("SC already set");
				l.next();
				nextScreenControls=popControls();
				continue;
			}
			
			if (l.la().equals("[REPORTCONTROLS]")) {
				if (nextReportControls!=null) l.lineError("RC already set");
				l.next();
				nextReportControls=popControls();
				continue;
			}

			if (l.la().equals("[QUICKCODE]")) {
				if (nextQuickCode!=null) l.lineError("QC already set");				
				l.next();
				nextQuickCode=popControls();
				continue;
			}
			
			if (l.la().trim().length()==0) {
				l.next();
				continue;
			}
			if (f==null) {
				f = new File();
				Definition cd = l.getDefintion();
				f.setFile(cd);
				
				last=f;
				last.init(nextDescription,nextScreenControls,nextReportControls,nextQuickCode);
				nextDescription=null;nextScreenControls=nextReportControls=nextQuickCode=null;
				
				continue;
			}
			
			if (l.la().startsWith("!!>")) {
				String line=l.next();
				line=" "+line.substring(3);
				Definition cd = l.getDefintion(" "+line);
				last.addParams(cd);
				continue;
			}
			
			if (l.la().trim().equals("END")) {
				l.next();
				depth--;
				if (depth==0) break;
				continue;
			}
			
			Definition cd = l.getDefintion();
			if (depth==0) {
				if (cd.getTypeName().equals("RECORD")) {
					depth=2;
					f.setRecord(cd);
					continue;
				};
				if (cd.getTypeName().equals("KEY")) {
					Key k = new Key();
					k.setKey(cd);
					last=k;
					last.init(nextDescription,nextScreenControls,nextReportControls,nextQuickCode);
					nextDescription=null;nextScreenControls=nextReportControls=nextQuickCode=null;
					cd.setPadding(25);
					f.addKey(k);
					continue;
				}
			}
			
			if (depth==2) {
				if (allowedFields.contains(cd.getTypeName())) {
					Field fld= new Field();
					fld.setField(cd);
					cd.setPadding(28);
					last=fld;
					last.init(nextDescription,nextScreenControls,nextReportControls,nextQuickCode);
					nextDescription=null;nextScreenControls=nextReportControls=nextQuickCode=null;
					f.addField(fld);
					continue;
				}
			}
			
			l.lineError("Unknown");
		}
		return f;
	}

	private List<Definition> popControls() throws IOException 
	{
		List<Definition> cd = new ArrayList<Definition>();
		while ( true ) {
			if (!l.la().startsWith("!")) break;
			cd.add(l.getDefintion(" "+l.next().substring(1)));
		}
		return cd;
	}

	private String popLongDesc() throws IOException 
	{
		if (!l.la().equals("[LONGDESC]")) {
			return null;
		}
		l.next();
		StringBuilder result = new StringBuilder();
		while ( l.la().startsWith("!")) {
			result.append(l.next().substring(1)).append('\n');
		}
		return result.toString();
	}
}
