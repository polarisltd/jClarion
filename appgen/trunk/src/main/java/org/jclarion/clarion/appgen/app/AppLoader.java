package org.jclarion.clarion.appgen.app;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Stack;

import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.loader.DefinitionLoader;
import org.jclarion.clarion.appgen.loader.GenericLoader;
import org.jclarion.clarion.appgen.loader.StringScanner;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.IntSymbolValue;
import org.jclarion.clarion.appgen.symbol.LabelSymbolValue;
import org.jclarion.clarion.appgen.symbol.StringSymbolValue;
import org.jclarion.clarion.appgen.symbol.ValueType;
import org.jclarion.clarion.appgen.symbol.user.AppLoaderScope;
import org.jclarion.clarion.appgen.symbol.user.PlaceholderDependency;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.TemplateChain;
import org.jclarion.clarion.appgen.template.TemplateLoader;
import org.jclarion.clarion.appgen.template.cmd.ProcedureCmd;
import org.jclarion.clarion.appgen.template.cmd.TemplateID;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;

/**
 * Loads a TXA application file and represents it as a set of beans stemming from App object
 * 
 * @author barney
 */
public class AppLoader {
	private static int n = 0;
	public static void main(String args[]) throws IOException 
	{
		TemplateChain chain = new TemplateChain();
		TemplateLoader loader = new TemplateLoader(chain);		
		loader.load("/home/barney/personal/c8/java/clarion/c9/src/main/template/c55/","abchain.tpl");
		loader.load("/home/barney/personal/c8/java/clarion/c9/src/main/template/c55/","LOCUSABC.tpl");
		chain.finalise();
		
		String def = ((ProcedureCmd)chain.getSection("#PROCEDURE", new TemplateID("ABC","Browse"))).getDefault();
		
		AppLoader al = new AppLoader();
		al.setLoader(new StringReader("[PROCEDURE]\n"+def));
		al.loadProcedure();
		
		/*
		AppLoader al = new AppLoader();	
		long start=System.currentTimeMillis();
		App a = al.loadApplication("/home/barney/personal/c8/java/clarion/c9/src/main/clarion/main/c8.txa");
		long end=System.currentTimeMillis();
		System.out.println("Load time:"+(end-start));
		
		TextAppStore factory = new TextAppStore(chain);
		factory.serialize(a);
		*/
		
		//System.out.println(a.getProcedure("ApplyAccountQuery").get);
	}

	private GenericLoader loader;
	
	// app settings
	
	public App loadApplication(String fileName) throws IOException 
	{
		App a=loadApplication(new BufferedReader(
			new InputStreamReader(
				new FileInputStream(fileName),"windows-1257")  // %%%robertsp 1252 -> 1257(LV)
			)
		);
		System.out.println("loading app "+fileName);
		a.setFile(fileName);
		return a;
	}

	private App loadApplication(BufferedReader reader) throws IOException
	{
		this.loader=new GenericLoader(reader);
		return loadApplication();
	}
	
	public void setLoader(Reader r)
	{
		if (r instanceof BufferedReader) {
			this.loader=new GenericLoader((BufferedReader)r);
		} else {
			this.loader=new GenericLoader(new BufferedReader(r));
		}
	}

	public App loadApplication() throws IOException
	{
		if (!"[APPLICATION]".equals(next())) throw new IOException("Expected Application definition");
		App a = new App();
		while (!la().startsWith("[")) {
			List<Lex> bits = decode(next());
			if (bits.size()==2 && bits.get(0).value.equals("PROCEDURE")) {
				a.setProcedure(bits.get(1).value);
				continue;
			}
			if (bits.size()==2 && bits.get(0).value.equals("DICTIONARY")) {
				a.setDictionary(bits.get(1).value);
				continue;
			}
			if (bits.size()==2 && bits.get(0).value.equals("VERSION")) {
				a.setVersion(Integer.parseInt(bits.get(1).value));
				continue;
			}
			if (bits.size()==3 && bits.get(0).value.equals("TODO")) {
				a.setTodoType(bits.get(1).value);
				a.setTodoValue(bits.get(2).value);
				continue;
			}
			lineError("Unknown Comand:"+bits);
		}
		
		List<String> moduleNames=new ArrayList<String>();
		
		while ( la()!= null ) {
			
			if (!la().startsWith("[")) {
				lineError("Unknown entry");
			}

			if (loadCommon(a)) {
				continue;
			}
			
			if (la().equals("[PROJECT]")) {
				next();
				while (!la().startsWith("[")) {
					String n = next();
					if (n.startsWith("#compile")) {
						String file = n.split(" ")[1];
						moduleNames.add(file.substring(1,file.length()-1));
						continue;
					}
					if (n.startsWith("#")) {
						continue;
					}
					lineError("What is this?");
				}
				continue;
			}
			
			if (la().equals("[PROGRAM]")) {
				a.setProgram(loadProgram());				
				continue;
			}

			if (la().equals("[END]")) {
				next();
				break;
			}

			if (la().equals("[PERSIST]")) {
				next();
				a.setPersist(loadProperties("PERSIST"));
				continue;
			}

			lineError("So far");
		}
		
		int moduleOfs=1;
		
		if (a.getProgram()!=null && moduleNames.size()>0) {
			a.getProgram().setName(moduleNames.get(0));			
		}

		while ( la()!= null ) {			
			if (la().equals("[MODULE]")) {
				
				String moduleName=moduleNames.get(moduleOfs);
				Module m = loadModule();
				
				if (m.getName()==null) {
					m.setName(moduleName);
					moduleOfs++;
				} else {
					if (a.getModule(m.getName())==null) {
						if (!m.getName().equals(moduleName)) {
							throw new IOException("module name mismatch:"+m.getName()+" "+moduleName+" "+moduleOfs);
						}
						moduleOfs++;
					}
				}
				
				/*
				if (m.getName()!=null && a.getModule(m.getName())!=null) continue;
				moduleOfs++;
				if (m.getName()!=null && !m.getName().equals(moduleName)) {
					throw new IOException("module name mismatch:"+m.getName()+" "+moduleName+" "+moduleOfs);
				} else {
					m.setName(moduleName);
				}
				*/
				
				a.addModule(m);
				continue;
			}
			lineError("So far");
		}
		
		return a;		
	}
	
		
	public Module loadModule() throws IOException
	{
		if (!"[MODULE]".equals(next())) throw new IOException("Expected Program definition");
		Module m =new Module();
		while (!la().startsWith("[")) {
			List<Lex> bits = decode(next());
			if (bits.size()==2 && bits.get(0).value.equals("NAME")) {
				m.setName(bits.get(1).value);
				continue;
			}
			if (bits.size()==2 && bits.get(0).value.equals("INCLUDE")) {
				m.setInclude(bits.get(1).value);
				continue;
			}
			if (bits.size()==1 && bits.get(0).value.equals("NOPOPULATE")) {
				m.setPopulate(false);
				continue;
			}
			lineError("Unknown Comand:"+bits);
		}

		while (true) {
			/*
			if (la()==null) {
				break;
			}
			*/
			if (loadCommon(m)) {
				continue;
			}
			if (la().equals("[PROCEDURE]")) {				
				m.addProcedure(loadProcedure());
				continue;
			}
			/*
			if (la().equals("[MODULE]")) {
				break;
			}
			*/
			if (la().equals("[END]")) {
				next();
				return m;
			}
			lineError("TODO");			
		}
		
		//return m;
	}
	
	public Procedure loadProcedure() throws IOException
	{
		if (!"[PROCEDURE]".equals(next())) throw new IOException("Expected Procedure definition");
		Procedure p = new Procedure();
		while (!la().startsWith("[")) {
			List<Lex> bits = decode(next());
			if (bits.size()==2 && bits.get(0).value.equals("NAME")) {
				p.setName(bits.get(1).value);
				continue;
			}
			if (bits.size()==2 && bits.get(0).value.equals("PROTOTYPE") && bits.get(1).type==LexType.string) {
				p.setPrototype(bits.get(1).value);
				continue;
			}
			if (bits.size()==1 && bits.get(0).value.equals("GLOBAL")) {
				p.setGlobal(true);
				continue;
			}
			if (bits.size()==2 && bits.get(0).value.equals("CATEGORY")) {
				p.setCategory(bits.get(1).value);
				continue;
			}			
			lineError("Unknown Comand:"+bits);
		}
		
		Map<Integer,Addition> additions=new LinkedHashMap<Integer,Addition>();
		
		while (la()!=null) {
			
			if (loadCommon(p)) {
				continue;
			}
			
			if (la().equals("[PROCEDURE]")) {
				break;
			}

			if (la().equals("[MODULE]")) {
				break;
			}

			if (la().equals("[WINDOW]")) {
				next();
				p.setWindow(loadWindow());
				continue;
			}
		
			if (la().equals("[ADDITION]")) {
				for (Addition a : loadAdditions()) {
					a.setProcedure(p);
					a.setOrderID(additions.size()+1);
					additions.put(a.getInstanceID(),a);
				}
				continue;
			}

			if (la().equals("[CALLS]")) {
				next();
				while ( true ) {
					if (la()==null) break;
					if (la().startsWith("[")) break;
					p.addCall(next());
				}
				continue;
			}
			
			if (la().equals("[FILES]")) {
				loadFiles(p);
				continue;
			}

			if (la().equals("[END]")) {
				// end of module
				break;
			}
			
			lineError("Unknown");
		}
		
		for (Addition scan : additions.values()) {
			if (scan.getParentID()>0) {
				additions.get(scan.getParentID()).addChild(scan);
			}
			p.addAddition(scan);
		}
		
		return p;
	}
	
	public void loadFiles(Procedure target) throws IOException
	{
		if (!"[FILES]".equals(next())) lineError("Expected Files definition");
	
		while (true) {
			if (la()==null) return;
			
			if (la().equals("[PRIMARY]")) {
				loadPrimaryFile(target);
				continue;
			}
			
			if (la().equals("[OTHERS]")) {
				next();
				while ( true ) {
					if (la()==null) break;
					if (la().startsWith("[")) break;
					target.addOtherFile(next());
				}
				continue;
			}
			
			break;
		}
	}
	
	private void loadPrimaryFile(Procedure target) throws IOException
	{
		Map<String,File> files=new LinkedHashMap<String,File>();
		PrimaryFile f=  new PrimaryFile();
		next();
		List<Lex> bits = decode(next());
		if (bits.size()!=1 || bits.get(0).type!=LexType.label) lineError("No filename");
		f.setName(bits.get(0).value);
		files.put(f.getName().toLowerCase(),f);
		while (true) {
			if (la()==null) break;
			if (la().equals("[INSTANCE]")) {
				next();
				bits = decode(next());
				if (bits.size()!=1 || bits.get(0).type!=LexType.integer) lineError("No instance");
				f.setInstanceID(Integer.parseInt(bits.get(0).value));
				continue;
			}
			if (la().equals("[KEY]")) {
				next();
				bits = decode(next());
				if (bits.size()!=1 || bits.get(0).type!=LexType.label) lineError("No key def");
				f.setKey(bits.get(0).value);
				continue;
			}
			if (la().equals("[SECONDARY]")) {
				next();
				while (true) {
					if (la()==null) break;
					if (la().startsWith("[")) break;
					StringScanner ss = loader.scanner();

					
					if (ss.la()==null || ss.la().type!=LexType.label) lineError("Unknown Secondary File Type");
					File child = sourceFile(files,ss.next().value);
					
					if (ss.la()==null || ss.la().type!=LexType.label) lineError("Unknown Secondary File Type");
					File parent = sourceFile(files,ss.next().value);
					
					boolean inner=false;
					if (ss.la()!=null && ss.la().type==LexType.label && ss.la().value.equals("INNER")) {
						ss.next();
						inner=true;
					}

					String expression=null;
					if (ss.la()!=null && ss.la().type==LexType.label && ss.la().value.equals("CUSTOM")) {
						ss.next();
						if (ss.la()==null || ss.la().type!=LexType.lparam) lineError("Unknown Secondary File Type");
						ss.next();
						if (ss.la()==null || ss.la().type!=LexType.string) lineError("Unknown Secondary File Type");
						expression=ss.next().value;
						if (ss.la()==null || ss.la().type!=LexType.rparam) lineError("Unknown Secondary File Type");
						ss.next();
					}
					
					if (ss.la()!=null) lineError("expected EOL");
					f.add(parent.addChild(child,inner,expression));					
				}
			}
			break;
		}
		
		for (File test : files.values() ) {
			if (test==f) continue;
			if (test.getParent()==null) {
				lineError("Orphaned file:"+test.getName());
			}
		}
		
		target.setPrimaryFile(f);
	}

	private File sourceFile(Map<String, File> files, String value) 
	{
		String lookup=value.toLowerCase();
		File f=files.get(lookup);
		if (f!=null) return f;
		f = new File();
		f.setName(value);
		files.put(lookup,f);
		return f;
	}

	private Iterable<Addition> loadAdditions() throws IOException
	{
		if (!"[ADDITION]".equals(next())) lineError("Expected Addition definition");
		if (la()==null) throw new IOException("Expected Name");
		
		List<Lex> cbits = decode(next());
		if (cbits.size()!=3) lineError("Expected Name");
		if (cbits.get(0).type!=LexType.label) lineError("expected name");
		if (!cbits.get(0).value.equals("NAME")) lineError("expected name");

		List<Addition> result = new LinkedList<Addition>();
		
		while (la().equals("[INSTANCE]")) {
			next();
			Addition a = new Addition();
			a.setBase(cbits.get(1).value,cbits.get(2).value);
			
			while ( true ) {
				if (la()==null) break;
				if (la().startsWith("[")) break;
				List<Lex> bits = decode(next());
				if (bits.size()==2 && bits.get(0).type==LexType.label && bits.get(0).value.equals("INSTANCE") && bits.get(1).type==LexType.integer) {
					a.setInstanceID(Integer.parseInt(bits.get(1).value));
					continue;
				}
				if (bits.size()==2 && bits.get(0).type==LexType.label && bits.get(0).value.equals("PARENT") && bits.get(1).type==LexType.integer) {
					a.setParentID(Integer.parseInt(bits.get(1).value));
					continue;
				}
				if (bits.size()==1 && bits.get(0).type==LexType.label && bits.get(0).value.equals("PROCPROP")) {
					a.setProcedureProperty(true);
					continue;
				}				
				lineError("Uknown instance param");
			}
		
			if (la().equals("[PROMPTS]")) {
				next();
				a.setProperties(loadProperties("Addition("+a.getBase()+")"));
			}
		
			result.add(a);
		}
		return result;
	}
	
	private String loadWindow() throws IOException
	{
		StringBuilder out  = new StringBuilder();
		while ( true ) {
			String n = next();
			if (n.length()==0) break;
			out.append(n).append('\n');
		}
		return out.toString();
	}
	
	public Program loadProgram() throws IOException
	{
		if (!"[PROGRAM]".equals(next())) throw new IOException("Expected Program definition");
		Program p = new Program();
		while ( true ) {
			if (la()==null) break;
			if (!loadCommon(p)) break;
		}
		return p;
		
	}
	
	private SimpleDateFormat modified = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");

	private boolean loadCommon(Component c) throws IOException 
	{
			if (la().equals("[COMMON]")) {
				next();
				while (!la().startsWith("[")) {
					List<Lex> bits = decode(next());
					if (bits.size()==2 && bits.get(0).value.equals("FROM")) {
						c.setBase(bits.get(1).value,null);
						continue;
					}
					if (bits.size()==3 && bits.get(0).value.equals("FROM")) {
						c.setBase(bits.get(1).value,bits.get(2).value);
						continue;
					}
					if (bits.size()==2 && bits.get(0).value.equals("DESCRIPTION")) {
						c.setDescription(bits.get(1).value);
						continue;
					}
					if (bits.size()==2 && bits.get(0).value.equals("LONG")) {
						c.appendToLongDescription(bits.get(1).value);
						continue;
					}
					if (bits.size()==2 && bits.get(0).value.equals("CATEGORY")) {
						c.setCategory(bits.get(1).value);
						continue;
					}
					if (bits.size()==3 && bits.get(0).value.equals("MODIFIED")) {
						String date = bits.get(1).value+" "+bits.get(2).value;
						try {
							c.setModified(modified.parse(date));
						} catch (ParseException e) {
							lineError("Invalid Date:"+date);
						}
						continue;
					}
					lineError("Do not know how to handle this");
				}
				return true;
			}
			if (la().equals("[PROMPTS]")) {
				next();
				c.setPrompts(loadProperties(c.getType()+"("+c.getName()+")"));
				return true;
			}
			
			if (la().equals("[DATA]")) {
				loadData(c);
				return true;
			}

			if (la().equals("[EMBED]")) {
				loadEmbeds(c);
				return true;
			}
			
			return false;
	}
	
	

	private void loadEmbeds(Component c) throws IOException 
	{
		if (!"[EMBED]".equals(next())) throw new IOException("Expected embed definition");
		
		while (true) {
			
			
			if (la()==null) lineError("Unexpected EOF");
			if  (la().equals("[END]")) {
				next();
				return;
			}
			
			StringScanner ss = loader.scanner();
			if (ss.la()==null || ss.la().type!=LexType.label || !ss.la().value.equals("EMBED")) {
				return;
			}
			ss.next();
			
			if (ss.la()==null || ss.la().type!=LexType.label || !ss.la().value.startsWith("%")) ss.lexError("Expected label");
			String label = ss.next().value;
			
			if (ss.next()!=null) ss.lexError("Expected EOL");

			
			if (la().equals("[INSTANCES]")) {
				loadEmbedInstance(c,label);
			} else if (la().equals("[DEFINITION]")) {
				loadEmbedDefinition(c,label);
			} else {
				lineError("Unknown");
			}
		}
	}
	
	private void loadEmbedDefinition(Component c, String label,String... instances) throws IOException 
	{
		if (!next().equals("[DEFINITION]")) lineError("Expected Definition");
		
		StringBuilder content = new StringBuilder();

		int count=0;
		while (true) {
			if (la()==null) lineError("Unexpected EOF");
			if (!next().equals("[SOURCE]")) lineError("Expected Source");
			
			int priority=1;
			boolean indent=true;

			if (!next().equals("PROPERTY:BEGIN")) lineError("Expected property begin");
			
			while (true) {
				String n = next();	
				if (n.equals("PROPERTY:END")) break;
				List<Lex> bits= decode(n);
			
				if (bits.size()==2 && bits.get(0).type==LexType.label && bits.get(0).value.equals("PRIORITY") && bits.get(1).type==LexType.integer) {
					priority=Integer.parseInt(bits.get(1).value);
					continue;
				}
				if (bits.size()==1 && bits.get(0).type==LexType.label && bits.get(0).value.equals("LABEL")) {
					indent=false;
					continue;
				}
				lineError("Unknown Property");
			}

			content.setLength(0);
			Embed e = new Embed(priority,new EmbedKey(label,instances.clone()),count++);
			if (!indent) {
				e.setIndent(indent);
			}
			c.addEmbed(e);

			while ( true ) {				
				String line = loader.la(false);
				if (line==null) lineError("Expected END");
				if (line.equals("[SOURCE]")) {
					e.setValue(content.toString());
					break;
				}
				if (line.equals("[END]")) {
					e.setValue(content.toString());
					next();
					return;
				}
				if (line.startsWith("[")) {
					lineError("Unexpected");
				}
				content.append(next()).append('\n');
			}
		}
	}

	private void loadEmbedInstance(Component c, String label,String... instances) throws IOException 
	{
		if (!next().equals("[INSTANCES]")) lineError("Expected instances");
		
		
		String[] post = new String[instances.length+1];
		System.arraycopy(instances, 0, post, 0, instances.length);
		
		while (true) {
			if (la()==null) lineError("Unexpected EOF");
			if (la().equals("[END]")) {
				next();
				return;
			}
			
			if (la().equals("[INSTANCES]")) {
				loadEmbedInstance(c,label,post);
				continue;
			}

			if (la().equals("[DEFINITION]")) {	
				loadEmbedDefinition(c,label,post);
				continue;
			}
			
			if (la().startsWith("WHEN")) {
				StringScanner ss = loader.scanner();
				if (ss.la()==null || ss.la().type!=LexType.label || !ss.la().value.equals("WHEN")) ss.lexError("Expected label");
				ss.next();
				if (ss.la()==null || ss.la().type!=LexType.string) ss.lexError("Expected String");
				post[post.length-1]=ss.next().value;
				if (ss.next()!=null) ss.lexError("Expected EOL");
				continue;
			}
			
			lineError("Unexpected");
		}		
		
	}
	

	private void loadData(Component c) throws IOException 
	{
		if (!"[DATA]".equals(next())) throw new IOException("Expected Data definition");
		
		Stack<Field> stack = new Stack<Field>();
		Field next=null;
		Field last=null;
		int target=0;
		
		
		while (la()!=null) {
			String s = la();
			if (s.equals("[SCREENCONTROLS]")) {
				next();
				if (next==null) next=new Field();
				target=0;
				continue;
			}

			if (s.equals("[LONGDESC]")) {
				next();
				if (next==null) next=new Field();
				StringBuilder longDesc=new StringBuilder();
				while (la()!=null && la().startsWith("!")) {
					longDesc.append(next().substring(1)).append('\n');
				}
				next.setLongDescription(longDesc.toString());
				continue;
			}
			
			if (s.equals("[QUICKCODE]")) {
				next();
				if (next==null) next=new Field();
				while (la()!=null && la().startsWith("!")) {
					if (la().trim().equals("!NOPOPULATE")) {
						next();
						next.setPopulate(false);
						continue;
					}
					lineError("Do not know how to handle this");
				}				
				continue;
			}
			
			if (s.equals("[REPORTCONTROLS]")) {
				next();
				if (next==null) next=new Field();
				target=1; // report
				continue;
			}
			
			if (s.startsWith("! ")) {
				next();
				if (target==1) {
					next.addReportControl(s.substring(2).trim());
				}
				if (target==2) {
					next.addScreenControl(s.substring(2).trim());
				}				
				continue;
			}
			
			if (s.startsWith("!!> GUID")) {
				next();
				last.setGuiDefinition(DefinitionLoader.loadItem(s.substring(4)));
				continue;
			}

			if (s.startsWith("!!> IDENT")) {            // %%% IDENT() ignoring
				
				System.out.println("IGNORED TODO (1) "+"  "+s); //%%%
				last.setGuiDefinition(DefinitionLoader.loadItem(s.substring(4))); // %%% IDENT() adapt like this method
				next();                 // %%% IDENT() ignoring
				continue;				// %%% IDENT() ignoring
			}
			
			
			
			if (s.startsWith("[")) {
				return;
			}
			
			if (looksLikeALabel(s)) {
				next();
				if (next==null) next=new Field();		
				
				next.setDefinition(DefinitionLoader.loadItem(s));

				if (!stack.isEmpty()) {
					stack.peek().addField(next);
				} else {
					c.addField(next);
				}
				
				last=next;
				next=null;		
				
				String typeName=last.getDefinition().getTypeName().toUpperCase();
				if (typeName.startsWith("GROUP") || typeName.startsWith("QUEUE") || typeName.startsWith("CLASS")) {
					stack.push(last);
				}

				continue;
			}
			
			if (s.trim().equals("END")) {
				next();
				if (stack.isEmpty()) {
					lineError("Stack is empty");
				}
				last=stack.pop();
				continue;
			}
			
			lineError("TODO");	            

		}
	}
	
	private boolean looksLikeALabel(String s) {
		if (s.length()==0) return false;
		char c = s.charAt(0);
		if (c>='a' && c<='z') return true;
		if (c>='A' && c<='Z') return true;
		if (c=='_') return true;
		return false;
	}
	
	private UserSymbolScope loadProperties(String src) throws IOException
	{
		UserSymbolScope result = new UserSymbolScope(src);
		result.setParent(new AppLoaderScope());
		
		while (true ) {
			if (la()==null) return result;
			if (la().startsWith("[")) return result;
			
			StringScanner ss = loader.scanner();
			
			Lex key = ss.next();
			if (key==null || key.type!=LexType.label || !key.value.startsWith("%")) ss.lexError("Expected Label");
			
			if (ss.la()!=null && ss.la().type==LexType.label && ss.la().value.equals("DEPEND")) {
				
				Set<String> conditionNames = new HashSet<String>();
				List<SymbolEntry> conditions = new ArrayList<SymbolEntry>();
				
				while (ss.la()!=null && ss.la().type==LexType.label && ss.la().value.equals("DEPEND")) {				
					ss.next();
					Lex condition = ss.next(); 
					if (condition==null || condition.type!=LexType.label || !condition.value.startsWith("%")) ss.lexError("Expected Condition");
					SymbolEntry se =result.get(condition.value);
					if (se==null) {
						ss.lexError("Symbol not found:"+condition.value);
					}
					if (se.getDependencies().iterator().hasNext()) {
						for (SymbolEntry dep : se.getDependencies()) {
							if (!conditionNames.contains(dep.getName().toLowerCase())) {
								conditionNames.add(dep.getName().toLowerCase());
								conditions.add(dep);
							}
						}						
					}
					if (!conditionNames.contains(se.getName().toLowerCase())) {
						conditionNames.add(se.getName().toLowerCase());
						conditions.add(se);
					}
				}
				
				boolean multi=false;
				if (ss.la()!=null && ss.la().type==LexType.label && ss.la().value.equals("MULTI")) {
					ss.next();
					multi=true;
				}
				
				Lex type = ss.next();
				if (type==null || type.type!=LexType.label) ss.lexError("Expected type");
				if (ss.la()==null || ss.la().type!=LexType.label || !ss.la().value.equals("TIMES")) ss.lexError("Expected TIMES");
				ss.next();
				if (ss.la()==null || ss.la().type!=LexType.integer) ss.lexError("Expected integer");
				int count = Integer.parseInt(ss.next().value);
				
				if (ss.next()!=null) ss.lexError("Expected EOL");
			
				SymbolEntry cond[] = conditions.toArray(new SymbolEntry[conditions.size()]);
				
				SymbolEntry target=result.declare(key.value,type.value,multi ? ValueType.multi : ValueType.scalar, cond);
				popMap(target,result,cond,0,count,multi);
				
				ss = loader.scanner();
				if (ss.next()!=null) ss.lexError("Expected empty line");		
				continue;
			}
			
			ValueType vt = ValueType.scalar;
			if (ss.la()!=null && ss.la().type==LexType.label && ss.la().value.equals("MULTI")) {
				ss.next();
				vt=ValueType.multi;
			}
			if (ss.la()!=null && ss.la().type==LexType.label && ss.la().value.equals("UNIQUE")) {
				ss.next();
				vt=ValueType.unique;
			}
			
			Lex type = ss.next();
			if (type==null || type.type!=LexType.label) ss.lexError("Expected label");
			
			SymbolEntry se =result.declare(key.value,type.value,vt);
					
			popParams(ss,se,vt!=ValueType.scalar);
			
			if (ss.next()!=null) ss.lexError("Expected EOL");
			continue;
		}
	}
	
	private SymbolValue construct(Lex l)
	{
		if (l.type==LexType.integer) {
			return new IntSymbolValue(Integer.parseInt(l.value));
		}
		if (l.type==LexType.string) {
			return new StringSymbolValue(l.value);
		}
		if (l.type==LexType.label) {
			return new LabelSymbolValue(l.value);
		}
		return null;
	}
	
	
	private void popMap(SymbolEntry target,UserSymbolScope scope, SymbolEntry[] se,int ofs, int count,boolean multi)  throws IOException 
	{
		for (int scan=0;scan<count;scan++) {
			StringScanner ss = loader.scanner();
			if (ss.la()==null || ss.la().type!=LexType.label || !ss.la().value.equals("WHEN")) ss.lexError("Expected WHEN");
			ss.next();
			
			if (ss.la()==null || ss.la().type!=LexType.lparam) ss.lexError("Expected");
			ss.next();
			
			if (ss.la()==null || (ss.la().type!=LexType.string && ss.la().type!=LexType.integer)) ss.lexError("Expected");
			
			String key=ss.next().value;
			
			if (ss.la()==null || ss.la().type!=LexType.rparam) ss.lexError("Expected");
			ss.next();

			if (se[ofs].list()!=null) {
				StringSymbolValue ssv = new StringSymbolValue(key);
				if (!se[ofs].list().values().fix(ssv)) {
					if (se[ofs] instanceof PlaceholderDependency) {
						se[ofs].list().values().add(ssv);
					} else {
						throw new IllegalStateException("Disallowed");
					}
				}
			} else {
				//se[ofs].scalar().setValue(new StringSymbolValue(key));
				throw new IllegalStateException("Disallowed");
			}
			
			if (ss.la()!=null && ss.la().type==LexType.lparam) {
				popParams(ss,target,multi);
			} else if (ss.la()!=null && ss.la().type==LexType.label && ss.la().value.equals("TIMES")) {
				ss.next();
				if (ss.la()==null || ss.la().type!=LexType.integer) ss.lexError("Expected integer");
				int sub_count = Integer.parseInt(ss.next().value);
				if (sub_count>0) {
					if (ofs+1==se.length) {
						ss.lexError("At limit. ofs="+ofs+". length="+se.length);
					}
					popMap(target,scope,se,ofs+1,sub_count,multi);
				}
			} else {
				ss.lexError("Expected something");
			}

			if (ss.next()!=null) ss.lexError("Expected EOL");
		}
	}

	private void popParams(StringScanner ss, SymbolEntry target,boolean multi) throws IOException 
	{
		if (ss.la()==null || ss.la().type!=LexType.lparam) {			
			ss.lexError("Expected (");
		}
		ss.next();
		
		if (ss.la()!=null && ss.la().type==LexType.rparam) {
			ss.next();
			return;
		}
		
		while ( true ) {
			if (ss.la()==null) ss.lexError("Expected parameter");
			Lex l = ss.next();
			SymbolValue av = construct(l);
			if (av==null) {
				ss.lexError("Expected string/number");
			}
			l = ss.next();
			
			if (target.list()!=null) {
				target.list().values().add(av);
			}
			
			if (l.type==LexType.rparam) {
				if (!multi) {
					if (target.getValue()!=null) {
						ss.lexError("Duplicate "+target.getValue()+" <= "+av+" for "+target.getName()+" "+target.getStore().getDependencies());
					}
					target.scalar().setValue(av);
				}
				return;
			}
			if (l.type==LexType.param && multi) {
				continue;
			}
			ss.lexError("Unexpected");
		}
	}

	private void lineError(String error) throws IOException
	{
		loader.lineError(error);
	}
	
	private List<Lex> decode(String next) throws IOException
	{
		return loader.decode(next);
	}

	
	private String next() throws IOException
	{
		return loader.next();
	}
	
	private String la() throws IOException
	{
		return loader.la();
	}
}
