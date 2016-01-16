package org.jclarion.clarion.appgen.app;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jclarion.clarion.appgen.embed.Advise;
import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.appgen.loader.DefinitionLoader;
import org.jclarion.clarion.appgen.symbol.ListScanner;
import org.jclarion.clarion.appgen.symbol.ListSymbolValue;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.ValueType;
import org.jclarion.clarion.appgen.symbol.user.AppLoaderScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.TemplateChain;
import org.jclarion.clarion.appgen.template.TemplateLoader;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.appgen.template.cmd.TemplateID;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public class TextAppLoad 
{
	private static enum Cmd { UNK,EOF,NAME,BASE,CATEGORY,DESCRIPTION,DICTIONARY,LONGDESC,TODOTYPE,TODOVALUE,GLOBAL,MODULE,ORDER,
		VERSION,DECLARE,SET,FIELDS,ADD,WINDOW,EMBED,INCLUDE,PROCEDURE,PROTOTYPE,ADDITION,CALL,ID,KEY,OTHERFILES,JOIN,INNER,EXPRESSION,POPULATE,FILE };
	
	public static void main(String args[]) throws IOException {
		
		TemplateChain chain = new TemplateChain();
		TemplateLoader loader = new TemplateLoader(chain);		
		loader.load("/home/barney/personal/c8/java/clarion/c9/src/main/template/c55/","abchain.tpl");
		loader.load("/home/barney/personal/c8/java/clarion/c9/src/main/template/c55/","LOCUSABC.tpl");
		chain.finalise();
		
		TextAppLoad tal = new TextAppLoad(chain);
		App a = tal.load("target/app");

		Procedure p = a.getProcedure("BrosweWSParts");
		logButtonAction(p);
		p=new Procedure(p);
		logButtonAction(p);
	}

	private static void logButtonAction(Procedure p) {
		System.out.println("======");
		SymbolEntry control = p.getPrompts().get("%control");
		SymbolEntry ba = p.getPrompts().get("%buttonAction");
		ListScanner l = control.list().values().loop(false);
		while (l.next()) {
			System.out.println(control.getValue()+" "+ba.getValue());
		}
		System.out.println("======");
	}



	private TemplateChain chain;
	
	public TextAppLoad(TemplateChain chain)
	{
		this.chain=chain;
	}
	
	public App load(String path)
	{
		return load(new FileTextAppSource(path));
	}
	
	public App load(TextAppSource source)
	{
		setSource(source,"main.app");
		try {
			App a = new App();
			deserialize(a);
			
			setSource(source,"main.program");
			Program p = new Program();
			deserialize(p);
			a.setProgram(p);
			
			setSource(source,"main.save");
			UserSymbolScope persist = new UserSymbolScope("Persist");
			persist.setParent(new AppLoaderScope());
			while (cmd()!=Cmd.EOF) {
				deserializePrompt(persist,true);
			}
			a.setPersist(persist);
			
			for (String kid : source.getAll("module")) {
				Object o = source.get(kid);
				setSource(kid,source.open(o));
				Module m = new Module();
				m.setFilename(kid);
				m.setSource(o);
				deserialize(m);
				a.addModule(m);
			}
			a.sortModules();
			return a;
			
		} catch (Exception ex) {
			System.err.println("Line:"+line+" src:"+sourceName);
			ex.printStackTrace();
		}
		return null;
	}
	
	public void deserialize(App a)
	{
		while (cmd()!=Cmd.EOF) {
			switch(cmd()) {
				case NAME:
					a.setFile(deserializeString());
					break;
				case BASE:
					a.setBase(deserializeString(),null);
					break;
				case CATEGORY:
					a.setCategory(deserializeString());
					break;
				case DESCRIPTION:
					a.setDescription(deserializeString());
					break;
				case LONGDESC:
					a.setLongDescription(deserializeString());
					break;
				case PROCEDURE:
					a.setProcedure(deserializeString());
					break;
				case TODOTYPE:
					a.setTodoType(deserializeString());
					break;
				case TODOVALUE:
					a.setTodoValue(deserializeString());
					break;
				case VERSION:
					a.setVersion(deserializeInt());
					break;
				case DICTIONARY:
					a.setDictionary(deserializeString());
					break;
				case DECLARE:
				case SET:
					deserializePrompt(a);
					break;
				case MODULE:
					read();
					Module m = new Module();
					deserialize(m);
					a.addModule(m);
					break;
				default:
					throw new IllegalStateException("Unknown : "+ cmd());
			}			
		}
		read();		
		initPrompt(a);
	}
	
	private void deserialize(Module m) {
		while (cmd()!=Cmd.EOF) {
			switch(cmd()) {
				case NAME:
					m.setName(deserializeString());
					break;
				case BASE:
					m.setBase(deserializeTemplateID());
					break;
				case CATEGORY:
					m.setCategory(deserializeString());
					break;
				case DESCRIPTION:
					m.setDescription(deserializeString());
					break;
				case LONGDESC:
					m.setLongDescription(deserializeString());
					break;
				case INCLUDE:
					m.setInclude(deserializeString());
					break;
				case FIELDS:
					read();
					deserializeFields(m);
					break;
				case DECLARE:
				case SET:
					deserializePrompt(m);
					break;
				case EMBED:
					deserializeEmbed(m);
					break;
				case POPULATE:
					m.setPopulate(deserializeBoolean());
					break;
				case ORDER:
					m.setOrder(deserializeInt());
					break;
				case PROCEDURE: 
					read();
					Procedure p = new Procedure();
					deserialize(p);
					m.addProcedure(p);
					break;
				default:
					throw new IllegalStateException("Unknown : "+ cmd());
			}			
		}
		read();
		initPrompt(m);		
	}

	private void deserialize(Program p) 
	{
		while (cmd()!=Cmd.EOF) {
			switch(cmd()) {
				case NAME:
					p.setName(deserializeString());
					break;
				case BASE:
					p.setBase(deserializeTemplateID());
					break;
				case CATEGORY:
					p.setCategory(deserializeString());
					break;
				case DESCRIPTION:
					p.setDescription(deserializeString());
					break;
				case LONGDESC:
					p.setLongDescription(deserializeString());
					break;
				case DECLARE:
				case SET:
					deserializePrompt(p);
					break;
				case FIELDS:
					read();
					deserializeFields(p);
					break;
				case EMBED:
					deserializeEmbed(p);
					break;
				default:
					throw new IllegalStateException("Unknown : "+ cmd());
			}			
		}
		read();
		initPrompt(p);		
	}
	
	private void deserialize(Procedure p) 
	{
		int additionCount=0;
		while (cmd()!=Cmd.EOF) {
			switch(cmd()) {
				case NAME:
					p.setName(deserializeString());
					break;
				case BASE:
					p.setBase(deserializeTemplateID());
					break;
				case CATEGORY:
					p.setCategory(deserializeString());
					break;
				case DESCRIPTION:
					p.setDescription(deserializeString());
					break;
				case LONGDESC:
					p.setLongDescription(deserializeString());
					break;
				case GLOBAL:
					p.setGlobal(deserializeBoolean());
					break;					
				case PROTOTYPE:
					p.setPrototype(deserializeString());
					break;
				case WINDOW:
					read();
					p.setWindow(deserializeBlock());
					break;
				case FIELDS:
					read();
					deserializeFields(p);
					break;
				case DECLARE:
				case SET:
					deserializePrompt(p);
					break;
				case EMBED:
					deserializeEmbed(p);
					break;
				case ADDITION: 
					read();
					Addition a = new Addition();
					a.setOrderID(++additionCount);
					additionCount=deserialize(p,a,additionCount);
					p.addAddition(a);
					break;
				case CALL: {
					Lexer l = lexer();
					read();
					l.next();
					while (true) {
						p.addCall(l.next().value);
						if (l.next().type!=LexType.param) break; 
					}
					break;
				}					
				case OTHERFILES: {
					Lexer l = lexer();
					read();
					l.next();
					while (true) {
						p.addOtherFile(l.next().value);
						if (l.next().type!=LexType.param) break; 
					}
					break;
				}					
				default:
					throw new IllegalStateException("Unknown : "+ cmd());
			}			
		}
		read();
		initPrompt(p);		
	}
	
	private int deserialize(Procedure p,Addition a,int additionCount) {
		while (cmd()!=Cmd.EOF) {
			switch(cmd()) {
				case NAME:					
					break;
				case BASE:
					a.setBase(deserializeTemplateID());
					break;
				case ID:
					a.setInstanceID(deserializeInt());
					break;
				case DECLARE:
				case SET:
					deserializePrompt(a);
					break;
				case FILE: {
					read();
					PrimaryFile pf = new PrimaryFile();
					deserialize(pf);
					a.setPrimaryFile(pf);
					break;
				}
				case ADDITION: {
					read();
					Addition kid = new Addition();
					kid.setOrderID(++additionCount);
					kid.setParentID(a.getInstanceID());
					a.addChild(kid);
					additionCount=deserialize(p,kid,additionCount);
					p.addAddition(kid);
					break;
				}
				default:
					throw new IllegalStateException("Unknown : "+ cmd());
			}
		}
		read();
		initPrompt(a);		
		return additionCount;
	}

	
	private void deserialize(PrimaryFile f) 
	{
		while (cmd()!=Cmd.EOF) {
			switch(cmd()) {
				case NAME:		
					f.setName(deserializeString());
					break;
				case KEY:
					f.setKey(deserializeString());
					break;
				case JOIN:
					read();
					deserializeFileJoin(f,f);
					break;
				default:
					throw new IllegalStateException("Unknown : "+ cmd());
			}
		}
		read();
	}

	private void deserializeFileJoin(PrimaryFile f,File parent) 
	{
		String name=null;
		boolean inner=false;
		String expression=null;
		FileJoin result=null;
		while (cmd()!=Cmd.EOF) {
			switch(cmd()) {
				case NAME:		
					name=deserializeString();
					break;
				case EXPRESSION:
					expression=deserializeString();
					break;
				case INNER:					
					inner=deserializeBoolean();
					break;
				case JOIN:
					read();
					if (result==null) {
						result=parent.addChild(new File(name),inner,expression);
					}
					deserializeFileJoin(f,result.getChild());
					break;
				default:
					throw new IllegalStateException("Unknown : "+ cmd());
			}
		}
		read();
		
		if (result==null) {
			result=parent.addChild(new File(name),inner,expression);
		}
		f.add(result);
	}

	private void deserializeEmbed(Component c) 
	{
		Lexer l = lexer();
		read();
		l.next(); //EMBED
		
		l.next(); //(

		String symbol = l.next().value;
		l.next(); // ,
		int priority = Integer.parseInt(l.next().value);

		List<String> instances = new ArrayList<String>();
		
		while (l.next().type==LexType.param) {
			instances.add(l.next().value);
		}

		boolean indent=true;
		while (l.next().type==LexType.param) {
			if (l.next().value.equals("NOINDENT")) {
				indent=false;
			}
		}
		
		EmbedKey ek = new EmbedKey(symbol,instances.toArray(new String[instances.size()]));
		
		int count=0;
		Iterator<? extends Advise> scan = c.getEmbeds().get(ek,priority,priority); 
		while (scan.hasNext() ) {
			scan.next();
			count++;
		}
		
		Embed e = new Embed(priority,ek,count);
		e.setIndent(indent);
		e.setValue(deserializeBlock());
		c.addEmbed(e);

	}
	
	
	private void deserializeFields(FieldStore c) 
	{
		while (lexer()!=null && !lexer().lookahead().value.equals("}")) {			
			Field f = deserializeField();
			c.addField(f);
		}
		read();
	}
	
	public Field deserializeField() {
		
		Lexer l = lexer();
		read();
		l.setIgnoreWhitespace(false);
		while (l.lookahead().type==LexType.ws) {
			l.next();
		}
		Definition d = DefinitionLoader.loadItem(l);
		Definition g = d.extractGUI();
		Field f = new Field();
		f.setDefinition(d);
		f.setGuiDefinition(g);		
		
		boolean kids=false;
		if (l.lookahead().value.equals("{")) {
			kids=true;
			l.next();
		}

		if (l.lookahead().type==LexType.comment) {
			d.setComment(l.next().value.substring(1));
		}
		
		if (kids) {
			deserializeFields(f);
		}
		
		return f;
	}

	private String deserializeString() {
		String value = lexer().lookahead(1).value;
		read();
		return value;
	}
	
	private boolean deserializeBoolean() {
		return deserializeString().equalsIgnoreCase("true");
	}

	private int deserializeInt() {
		String value = lexer().lookahead(1).value;
		read();
		return Integer.parseInt(value);
	}

	private TemplateID deserializeTemplateID() 
	{
		Lexer l = lexer();
		l.next(); // skip label
		
		String type = l.next().value;
		String chain=null;
		if (l.lookahead().type==LexType.lparam) {
			l.next();
			chain=l.next().value;
		}
		read();
		return new TemplateID(chain,type);
	}

	private String deserializeBlock() 
	{
		StringBuilder out =new StringBuilder();
		while ( true ) {
			String read = read();
			if (read.equals("<<<END")) break;
			out.append(read).append('\n');
		}
		return out.toString();
	}

	private List<Lex> popArray(Lexer l) {
		if (l.lookahead().type!=LexType.lbrack) return null;
		l.next();
		
		
		List<Lex> r = new ArrayList<Lex>();
		boolean expectValue=false;
		
		while ( l.lookahead().type!=LexType.eof ) {
			
			Lex le = l.next();
			
			if (le.type==LexType.rbrack) {
				if (expectValue) {
					r.add(null);					
				}
				break;
			}

			if (le.type==LexType.param) {
				if (expectValue) {
					r.add(null);					
				}
				expectValue=true;
				continue;
			}
			
			r.add(le);
			expectValue=false;
		}
		return r;
	}
	
	private void initPrompt(AtSource c)
	{
		UserSymbolScope scope = c.getPrompts();
		boolean create=chain==null;
		if (scope==null) {
			if (!create) {
				scope=chain.getSection(c.getTemplateType(),c.getBase(),false).getDeclaredPrompts();
			} else {
				scope=new UserSymbolScope("Loaded");
				scope.setParent(new AppLoaderScope());
			}
			c.setPrompts(scope);
		}
	}
	
	private void deserializePrompt(AtSource c) 
	{
		initPrompt(c);
		deserializePrompt(c.getPrompts(),chain==null);
	}	
	
	public void deserializePrompt(UserSymbolScope scope,boolean allowDeclare,SymbolEntry... deps)
	{
		Lexer l =lexer();
		read();
		
		l.next();
		
		while ( true ) {
			ValueType v_type=  ValueType.scalar;
			String type="DEFAULT";
			if (l.lookahead().type==LexType.label && !l.lookahead().value.startsWith("%")) {
				type=l.next().value;
				if (type.equals("MULTI")) {
					v_type=ValueType.multi;
					type="DEFAULT";
				}
				if (type.equals("UNIQUE")) {
					v_type=ValueType.unique;
					type="DEFAULT";
				}
			}

			if (l.lookahead().type==LexType.label) {
				if (l.lookahead().value.equals("MULTI")) {
					l.next();
					v_type=ValueType.multi;
				} else if (l.lookahead().value.equals("UNIQUE")) {
					l.next();
					v_type=ValueType.unique;
				} 
			}
		
			String symbol = l.next().value;
		
			SymbolEntry se= scope.get(symbol);
			if (se==null) {
				
				if (allowDeclare) {
					se = scope.declare(symbol,type,v_type,deps);					 
				} else {
					System.out.println(symbol+" is null! for "+scope.getName());
					if (symbol.equals("%ClassItem")) {
						scope.debug();
						System.exit(0);
					}
				}
			}
		
			if (l.lookahead().value.equals("=")) {
				deserializeValue(l,se);
				return;
			} else if (l.lookahead().value.equals("{")) {
				SymbolEntry path[]=new SymbolEntry[deps.length+1];
				System.arraycopy(deps,0,path,0,deps.length);
				path[path.length-1]=se;		
				if (se==null) {
				}
				deserializePrompts(scope,allowDeclare,path);
				return;
			}
			
			if (l.lookahead().type!=LexType.param) return;
			l.next();
		}
	}

	private void deserializePrompts(UserSymbolScope scope,boolean allowDeclare, SymbolEntry[] deps) 
	{
		while (lexer()!=null && !lexer().lookahead().value.equals("}")) {			
			if (cmd()==Cmd.DECLARE) {
				deserializePrompt(scope,allowDeclare,deps);
				continue;
			}

			if (cmd()==Cmd.SET) {				
				Lexer l = lexer();
				read();
				l.next();			
				String varname=l.next().value;
				SymbolEntry se = scope.get(varname);
				
				if (l.lookahead().value.equals("=")) {
					deserializeValue(l,se);
				} else if (l.lookahead().value.equals("{")) {
					SymbolEntry path[]=new SymbolEntry[deps.length+1];
					System.arraycopy(deps,0,path,0,deps.length);
					path[path.length-1]=se;			
					deserializePrompts(scope,allowDeclare,path);					
				}
				
				continue;
			}		
			
			if (cmd()==Cmd.ADD) {
				Lexer l = lexer();
				read();
				l.next();								
				deps[deps.length-1].list().values().add(SymbolValue.construct(l));
				if (l.next().value.equals("{")) {
					deserializePrompts(scope,allowDeclare,deps);
				}
				continue;
			}
			
			throw new IllegalStateException("Unknown:"+cmd());
		}
		read();
	}

	private void deserializeValue(Lexer l,SymbolEntry se) {
		l.next();
		if (l.lookahead().type==LexType.lbrack) {
			ListSymbolValue lsv=se!=null ? se.list().values() : null;
			for (Lex o : popArray(l)) {
				if (lsv!=null) {
					lsv.add(SymbolValue.construct(o));
				}
			}
		} else {
			if (se!=null) {
				se.scalar().setValue(SymbolValue.construct(l));
			}
		}
	}


	
	private String sourceName;
	private BufferedReader source;
	private int line;

	public void setSource(TextAppSource source,String name)
	{
		try {
			setSource(name,source.open(source.get(name)));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void setSource(String string,InputStream stream) {
		if (source!=null) {
			try {
				source.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if (string!=null) {
			source=new BufferedReader(new InputStreamReader(stream));
			sourceName=string;
			line=0;
		} else {
			source=null;
		}
		read=null;
		lexer=null;
		command=null;
	}

	private String read=null;
	private Lexer  lexer=null;
	private Cmd command=null;

	public String peek()
	{
		if (read!=null) return read;
		try {
			read=source.readLine();
			lexer=null;
			command=null;
			line++;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return read;
	}
	
	public String read()
	{
		String result = peek();
		read=null;
		command=null;
		lexer=null;
		return result;
	}
	
	public Lexer lexer()
	{
		if (lexer!=null) {
			lexer.rollback();
			lexer.begin();
			return lexer;
		}
		if (peek()==null) return null;
		lexer = new Lexer(new StringReader(read));
		lexer.setJavaMode(false);
		lexer.setTemplateLexer(true);
		lexer.setIgnoreWhitespace(true);
		lexer.begin();
		return lexer;
	}
	
	public Cmd cmd()
	{
		if (command!=null) return command;
		if (lexer()==null) {
			command=Cmd.EOF;
		} else {
			if (lexer().lookahead().value.equals("}")) {
				command=Cmd.EOF;
				return command;
			}
			command = Cmd.valueOf(lexer.lookahead().value.toUpperCase());
			if (command==null) {
				command=Cmd.UNK;
			}
		}
		return command;
	}
}
