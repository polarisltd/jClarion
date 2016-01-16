package org.jclarion.clarion.appgen.app;

import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.embed.SimpleEmbedStore;
import org.jclarion.clarion.appgen.lang.SourceEncoder;
import org.jclarion.clarion.appgen.symbol.ListScanner;
import org.jclarion.clarion.appgen.symbol.MultiSymbolEntry;
import org.jclarion.clarion.appgen.symbol.NullSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.ValueType;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.TemplateChain;
import org.jclarion.clarion.appgen.template.cmd.TemplateID;


public class TextAppStore 
{
	private TemplateChain chain;
	
	public TextAppStore()
	{
	}

	public TextAppStore(TemplateChain chain)
	{
		this.chain=chain;
	}
	
	public void serialize(App a)
	{
		serialize(a,"target/app/");
	}
	
	public void serialize(App a,String path)
	{
		setTarget(path+"main.app");
		serialize("Name",a.getName());
		serialize("Base",a.getBase().getChain());
		serialize("Catetory",a.getCategory());
		serialize("Description",a.getDescription());
		serialize("Dictionary",a.getDictionary());
		serialize("LongDesc",a.getLongDescription());
		serialize("Procedure",a.getProcedure());
		serialize("TodoType",a.getTodoType());
		serialize("TodoValue",a.getTodoValue());
		serialize("Version",a.getVersion());		
		
		serializeFields("global",a.getFields());		
		serializePrompts(a.getPrompts(),chain==null);
		serializeEmbeds(a.getEmbeds());
		
		int order=0;
		for (Module m : a.getModules()) {
			if (m.getBase()==null) continue;
			m.setOrder(order++);
			if (!m.getProcedures().iterator().hasNext()) {
				indentStart("module");
				serializeModule(m);
				indentEnd();				
			}
		}
				
		setTarget(path+"main.program");
		serializeProgram(a.getProgram());
		
		setTarget(path+"main.save");
		serializePrompts(a.getPersist(),true);
		
		Set<String> mnames=new HashSet<String>();

		for (Module m : a.getModules()) {
			if (!m.getProcedures().iterator().hasNext()) continue;
			
			int test=0;
			while (true) {
				String tname =m.getProcedures().iterator().next().getName()+(test==0 ? "" : "_"+test )+".module" ;
				if (test==0 && m.getFileName()!=null) {
					tname=m.getFileName();
				}
				if (mnames.contains(tname)) {
					test++;
					continue;
				}
				mnames.add(tname);
				setTarget(path+tname);
				break;
			}
			
			//indentStart("module");
			serializeModule(m);
			//indentEnd();
		}
	}
	
	public void serializeModule(Module m) {
		serialize("Name",m.getName());
		serialize("Base",m.getBase());
		serialize("Category",m.getCategory());
		serialize("Description",m.getDescription());
		serialize("Include",m.getInclude());
		serialize("Populate",m.isPopulate());
		serialize("Order",m.getOrder());
		serializeFields("fields",m.getFields());
		serializePrompts(m.getPrompts(),chain==null);
		serializeEmbeds(m.getEmbeds());
		for (Procedure p : m.getProcedures()) {
			indentStart("procedure");
			serializeProcedure(p);
			indentEnd();
		}
	}

	private void serializeProgram(Program p) 
	{
		serialize("Name",p.getName());
		serialize("Base",p.getBase());
		serialize("Category",p.getCategory());
		serialize("Description",p.getDescription());
		serialize("LongDesc",p.getLongDescription());		
		serializeFields("fields",p.getFields());
		serializePrompts(p.getPrompts(),chain==null);
		serializeEmbeds(p.getEmbeds());			
	}
	
	private void serializeProcedure(Procedure p) 
	{
		serialize("Name",p.getName());
		serialize("Base",p.getBase());
		serialize("Category",p.getCategory());
		serialize("Description",p.getDescription());
		serialize("LongDesc",p.getLongDescription());		
		serialize("Prototype",p.getPrototype());
		if (p.isGlobal()) {
			serialize("Global",p.isGlobal());
		}
		serializeBlock("Window",p.getWindow());
		serializeFields("fields",p.getFields());
		serializePrompts(p.getPrompts(),chain==null);
		serializeEmbeds(p.getEmbeds());	
		
		for (Addition a : p.getAdditions()) {
			serializeAddition(a);
		}
		
		if (!p.getCalls().isEmpty()) {
			PrintStream ser = serialize();
			ser.append("CALL ");
			boolean first=true;
			for (String s : p.getCalls()) {
				if (first) {
					first=false;
				} else {
					ser.append(",");
				}
				ser.append(s);
			}					
			ser.append("\n");
		}

		if (!p.getOtherFiles().isEmpty()) {
			PrintStream ser = serialize();
			ser.append("OtherFiles ");
			boolean first=true;
			for (String s : p.getOtherFiles()) {
				if (first) {
					first=false;
				} else {
					ser.append(",");
				}
				ser.append(s);
			}					
			ser.append("\n");
		}
		
	}

	private void serializeAddition(Addition a) {
		indentStart("addition");
		
		serialize("Base",a.getBase());
		serialize("ID",a.getInstanceID());		
		serializePrompts(a.getPrompts(),chain==null);
		serializePrimary(a.getPrimaryFile());
		
		for (Addition kid : a.getChildren()) {
			serializeAddition(kid);
		}
		
		indentEnd();
	}

	private void serializePrimary(PrimaryFile primaryFile) 
	{
		if (primaryFile==null) return;
		indentStart("file");
		serialize("Name",primaryFile.getName());
		serialize("Key",primaryFile.getKey());
		for (FileJoin join : primaryFile.getChildren()) {
			serializeFileJoin(join);
		}
		indentEnd();
	}

	private void serializeFileJoin(FileJoin file) {
		indentStart("join");
		serialize("Name",file.getChild().getName());
		if (file.getExpression()!=null) {
			serialize("Expression",file.getExpression());
		}
		if (file.isInner()) {
			serialize("Inner",file.isInner());
		}
		for (FileJoin join : file.getChild().getChildren()) {
			serializeFileJoin(join);
		}
		indentEnd();
	}
	
	/*
			PrintStream p  = serialize("");
			p.append("JOIN ");
			p.append(join.getParent().getName());
			p.append(" ");
			p.append(join.getChild().getName());
			if (join.isInner()) {
				p.append(" INNER");
			}
			if (join.getExpression()!=null) {
				p.append(SourceEncoder.encodeString(join.getExpression()));
			}
			p.append(";");
		}
		indentEnd();
	}
	*/



	private void serializeEmbeds(SimpleEmbedStore<Embed> embeds) 
	{
		for (Embed e : embeds) {
			PrintStream ps = serialize();
			EmbedKey ek = e.getKey();
			ps.append("EMBED(");
			ps.append(ek.getName());
			ps.append(",");
			ps.append(String.valueOf(e.getPriority()));
			if (ek.getInstanceCount()>0) {
				for (int scan=0;scan<ek.getInstanceCount();scan++) {
					ps.append(",");
					ps.append(SourceEncoder.encodeString(ek.getInstance(scan)));
				}
			}
			ps.append(")");
			if (!e.isIndent()) {
				ps.append(",NOINDENT");
			}
			ps.append(" ");
			ps.append("\n");
			ps.append(e.getValue());
			if (!e.getValue().endsWith("\n")) {
				ps.append("\n");
			}
			ps.append("<<<END\n");
		}
	}
	
	
	private void serializeFields(String string, Iterable<Field> fields) 
	{
		if (!fields.iterator().hasNext()) return;
		
		indentStart(string);
		serializeFields(fields);
		indentEnd();
	}

	private void serializeFields(Iterable<Field> fields) {
		for (Field f : fields) {
			serializeField(f);
		}
	}

	public void serializeField(Field f) {
		PrintStream ps = serialize();
		ps.append(f.getDefinition().renderUnsplit());
		
		String gui = f.getGuiDefinition().renderUnsplit().trim();
		if (gui.length()>0) {
			ps.append(',').append(gui);
		}
		
		if (f.getLongDescription()!=null) {
			ps.append(",LONGDESC(").append(SourceEncoder.encodeString(f.getLongDescription())).append(")");
		}
		
		if (f.getFields().iterator().hasNext()) {
			ps.append(" {");
		}
		if (f.getDefinition().getComment()!=null) {
			ps.append(" !");
			ps.append(f.getDefinition().getComment());
		}
		ps.append('\n');
		
		if (f.getFields().iterator().hasNext()) {
			indent(4);
			serializeFields(f.getFields());
			indent(-4);
			ps = serialize();
			ps.append("}\n");
		}
	}

	private void serialize(String string, int version) {
		PrintStream ps = serialize(string);
		ps.append(' ').append(String.valueOf(version)).append('\n');
	}

	private void serialize(String string, TemplateID base) 
	{
		if (base==null) return;
		PrintStream ps = serialize(string);		
		ps.append(' ').append(String.valueOf(base.getType()));
		if (base.getChain()!=null) {
			ps.append('(').append(base.getChain()).append(')');
		}
		ps.append('\n');
	}

	private void serializeBlock(String string, String name) 
	{
		if (name==null) return;
		PrintStream ps = serialize();
		ps.append(string);
		ps.append("\n");
		ps.append(name);
		if (!name.endsWith("\n")) {
			ps.append("\n");
		}
		ps.append("<<<END\n");
		
	}

	private void serialize(String string, String name) 
	{
		if (name==null) return;
		PrintStream ps = serialize(string);
		ps.append(' ').append(SourceEncoder.encodeString(name)).append('\n');
		
	}
	
	private void serialize(String string,boolean value) 
	{
		PrintStream ps = serialize(string);
		ps.append(' ').append(value ? "True" : "False").append('\n');
		
	}

	public void serializePrompts(UserSymbolScope scope,boolean saveDeclare)
	{
		if (scope==null) return;
		
		Map<Set<String>,TreeMap<String,SymbolEntry>> symbols = new HashMap<Set<String>,TreeMap<String,SymbolEntry>>();
		Set<String> allSymbols = new HashSet<String>();
		
		for (SymbolEntry se : scope.getAllSymbols()) {
			addSymbol(symbols,allSymbols,se);
		}
		
		HashSet<String> hs = new HashSet<String>();
		serializePrompts(symbols,hs,saveDeclare);
		symbols.remove(hs);
		
		for (Map.Entry<Set<String>,TreeMap<String,SymbolEntry>> scan : symbols.entrySet()) {
			serialize().append("  #ERROR "+scan.getKey()+"\n");
		}
	}
	
	
	
	private void addSymbol(Map<Set<String>, TreeMap<String, SymbolEntry>> symbols,Set<String> allSymbols, SymbolEntry se) 
	{
		String name = se.getName().toLowerCase();
		if (allSymbols.contains(name)) return;
		
		Set<String> deps = new HashSet<String>();
		for (SymbolEntry d : se.getDependencies()) {
			addSymbol(symbols,allSymbols,d);
			deps.add(d.getName().toLowerCase());
		}
		TreeMap<String,SymbolEntry> item = symbols.get(deps);
		if (item==null) {
			item=new TreeMap<String,SymbolEntry>();
			symbols.put(deps,item);
		}
		item.put(name,se);
		allSymbols.add(name);
	}
	

	private void serializePrompts(Map<Set<String>, TreeMap<String, SymbolEntry>> symbols,HashSet<String> dep,boolean saveDeclare) 
	{
		TreeMap<String,SymbolEntry> item = symbols.get(dep);
		if (item==null) return;
		
		if (dep.size()>0 && saveDeclare) {
			PrintStream s = null;
			int count=0;
			for (SymbolEntry se : item.values()) {
				String name= se.getName().toLowerCase();			
				dep.add(name);
				if (!symbols.containsKey(dep)) {
					if (s==null) {
						s = serialize();
						s.append("DECLARE ");
					} else {
						s.append(",");
					}
					serializeDeclare(s,se);
				}
				dep.remove(name);
				count++;
				if (count==6) {
					s.append("\n");
					s=null;
					count=0;
				}
			}		
			if (s!=null) {
				s.append("\n");
			}
		}
		
		for (SymbolEntry se : item.values()) {
			//if (se instanceof PlaceholderDependency) continue;
			
			String name= se.getName().toLowerCase();
			
			dep.add(name);
			if (symbols.containsKey(dep)) {
				boolean any=false;
				if (saveDeclare) {
					PrintStream s = serialize();
					s.append("DECLARE ");
					serializeDeclare(s,se);
					s.append(" {");
					s.append("\n");
					any=true;
				} else if (dep.size()==1) {
					PrintStream s = serialize();
					s.append("SET ");
					s.append(se.getName());
					s.append(" {");
					s.append("\n");
					any=true;
				}
				indent(4);
				serializePrompts(symbols,dep,saveDeclare);
				if (dep.size()==1) {
					serializePlaceholder(se,symbols,dep);
					finishSerialize(symbols,dep);
				}
				indent(-4);
				if (any) {
					PrintStream s = serialize();
					s.append("}\n");
				}
			} else if (dep.size()==1) {				
				if (saveDeclare) {
					PrintStream s = serialize();
					s.append("DECLARE ");
					serializeDeclare(s,se);
					if (dep.size()==1) {
						serializeValue(s,se);
					}
					s.append("\n");
				} else if (dep.size()==1) {
					
					boolean output=true;
					if (se.scalar()!=null && se.scalar().getValue()==null) output=false;
					if (se.scalar()!=null && se.scalar().getValue() instanceof NullSymbolValue) output=false;
					if (output) {
						PrintStream s = serialize();					
						s.append("SET ");
						s.append(se.getName());
						serializeValue(s,se);
						s.append("\n");
					}
				}
			}
			
			dep.remove(name);
		}
	}
		

	private void serializePlaceholder(SymbolEntry se,Map<Set<String>, TreeMap<String, SymbolEntry>> symbols,
			HashSet<String> dep) 
	{
		ListScanner scanner = se.list().values().loop(false);
		while (scanner.next()) {
			PrintStream s = serialize();
			s.append("ADD ");
			s.append(se.getValue().serialize());
			
			TreeMap<String,SymbolEntry> item = symbols.get(dep);
			if (item!=null) {
				s.append(" {\n");
				indent(4);
				
				for (SymbolEntry scan : item.values() ) {
					
					if (scan.scalar()!=null && scan.scalar().getValue()==null) continue;
					if (scan.scalar()!=null && scan.scalar().getValue() instanceof NullSymbolValue) continue;
					if (scan.list()!=null && scan.list().values().size()==0) continue;

					String name = scan.getName().toLowerCase();
					dep.add(name);

					s = serialize();
					s.append("SET ");
					s.append(scan.getName());
				
					if (symbols.containsKey(dep)) {
						s.append(" {\n");
						indent(4);
						serializePlaceholder(scan,symbols,dep);
						indent(-4);
						s = serialize();
						s.append("}\n");
					} else {
						serializeValue(s, scan);
						s.append("\n");
					}
					dep.remove(name);
				}
				
				indent(-4);
				s = serialize();
				s.append("}\n");				
			} else {
				s.append("\n");
			}
		}
		
		scanner.dispose();
	}


	private void finishSerialize(
			Map<Set<String>, TreeMap<String, SymbolEntry>> symbols,
			HashSet<String> dep) 
	{
		TreeMap<String, SymbolEntry> tree = symbols.get(dep);
		if (tree!=null) {
			for (String key : tree.keySet()) {
				key=key.toLowerCase();
				dep.add(key);
				finishSerialize(symbols,dep);
				dep.remove(key);
			}
		}
		
		symbols.remove(dep);
	}

	private void serializeDeclare(PrintStream s, SymbolEntry se) {
		boolean display=true;
		if (se.getType().equals("DEFAULT")) {
			display=false;
		}
		if (display) {
			s.append(se.getType());
			s.append(' ');
		}
		if (se instanceof MultiSymbolEntry) {
			MultiSymbolEntry mse = (MultiSymbolEntry)se;
			if (mse.getValueType()==ValueType.multi) {
				s.append("MULTI ");
			} else {
				s.append("UNIQUE ");
			}
		}
		s.append(se.getName());
	}


	private void serializeValue(PrintStream s, SymbolEntry se) 
	{
		if (se.scalar()!=null) {
			if (se.scalar().getValue()==null) return;
			s.append(" = ");
			s.append(se.scalar().getValue().serialize());
		}
		if (se.list()!=null) {
			s.append(" = ");
			s.append("[");
			ListScanner scanner = se.list().values().loop(false);
			boolean first=true;
			while (scanner.next()) {
				if (first ) {
					first=false;
				} else {
					s.append(',');
				}
				s.append(se.getValue().serialize());
			}
			scanner.dispose();
			s.append("]");
		}
	}


	private int indent;
	private String indentString="";
	
	public void indentStart(String name)
	{
		PrintStream ps = serialize();
		ps.append(name);
		ps.append(" {\n");
		indent(4);
	}
	
	public void indentEnd()
	{
		indent(-4);
		PrintStream ps = serialize();
		ps.append("}\n");		
	}
	
	public void indent(int change)
	{
		this.indent+=change;
		if (indentString.length()>indent) {
			indentString=indentString.substring(0,indent);
		} else {
			indentString=indentString+("                 ".substring(0,indent-indentString.length()));
		}
	}

	private PrintStream target;
	
	public void setTarget(String string) {
		if (target!=null) {
			target.close();
		}
		if (string!=null) {
			try {
				target=new PrintStream(string);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
		} else {
			target=null;
		}
	}
	
	public void setTarget(PrintStream target)
	{
		this.target=target;
	}

	
	public PrintStream serialize()
	{
		if (target==null) {
			System.out.print(indentString);
			return System.out;
		} else {
			target.print(indentString);
			return target;
		}
	}

	public PrintStream serialize(String init)
	{
		PrintStream ps = serialize();
		ps.print(init);
		ps.print("            ".substring(init.length()));
		return ps;
	}
}
