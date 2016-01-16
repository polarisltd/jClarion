package org.jclarion.clarion.appgen.template.cmd;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.jclarion.clarion.appgen.symbol.ListScanner;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.user.AppLoaderScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.CommandItem;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.TemplateChain;
import org.jclarion.clarion.appgen.template.TemplateItem;
import org.jclarion.clarion.appgen.template.TemplateParser;

public abstract class CodeSection extends CommandItem  implements WidgetContainer, StatementBlock, InsertAwareParent
{
	@SuppressWarnings("unchecked")
	private List<AtBlock> atBlocks[]=new List[3];
	private Map<String,AtBlock>   atTypes=new HashMap<String,AtBlock>();
	
	private SheetCmd sheet;

	private List<Statement> block=new ArrayList<Statement>();

	private List<Statement> localData;
	
	private List<ClassCmd> classes=new ArrayList<ClassCmd>();

	private List<RestrictCmd> restrictions=new ArrayList<RestrictCmd>();

	private PrepareCmd prepare;

	private AtStartCmd atStart;

	private List<Statement> globalData;
	
	public abstract String getCodeID();
	
	public abstract String getDescription();
	
	protected void execute(TemplateParser parser,TemplateItem parent) throws IOException
	{
		parser.setCodeSection(this);
		while (true ) {
			TemplateItem child = parser.read();
			if (child==null) return;
			if (child instanceof TemplateCmd) return; // multiple template sets
			if (child instanceof CodeSection) return; // a sibling
			child.consume(parser, this);
		}
	}

	private ConcreteWidgetContainer container;
	
	public CodeSection()
	{
		container=new ConcreteWidgetContainer( );		
	}
	
	
	@Override
	public void addWidget(Widget w) {
		container.addWidget(w);
	}

	@Override
	public List<? extends Widget> getWidgets() {
		return container.getWidgets();
	}
	
	

	@Override
	public void addInsert(TemplateChain chain, InsertCmd insertCmd) 
	{
		container.addInsert(chain,insertCmd);
		addStatement(insertCmd);
	}

	@Override
	public void addStatement(Statement stmt) {
		block.add(stmt);		
	}
	
	public void addAtBlock(AtBlock block) {
		if (atBlocks[block.getPosition()]==null) {
			atBlocks[block.getPosition()]=new ArrayList<AtBlock>();
		}
		atBlocks[block.getPosition()].add(block);
		atTypes.put(block.getCmd().getLocation().toLowerCase(),block);
	}

	public AtBlock getLastAtBlock(String type) {
		return atTypes.get(type.toLowerCase());
	}
	
	public boolean containsAt(String reference)
	{
		return atTypes.containsKey(reference.toLowerCase());
	}
	
	public void fillAtCache(Set<String> cache)
	{
		cache.addAll(atTypes.keySet());
	}

	public void setLocalData(List<Statement> statements) 
	{
		this.localData=statements;
	}
	
	public List<Statement> getLocalData()
	{
		return localData;
	}

	public void setGlobalData(List<Statement> statements) {
		this.globalData=statements;
	}
	
	public List<Statement> getGlobalData()
	{
		return globalData;
	}
	
	public void addClass(ClassCmd cmd)
	{
		classes.add(cmd);
	}

	public void addRestriction(RestrictCmd restrictCmd) 
	{
		restrictions.add(restrictCmd);
	}
	
	public Collection<RestrictCmd> getRestrictions()
	{
		return restrictions;
	}

	public void addPrepare(PrepareCmd prepare) 
	{
		if (this.prepare!=null) {
			throw new IllegalStateException("Prepare Statement already defined");
		}
		this.prepare=prepare;
	}

	public void setAtStart(AtStartCmd atStartCmd) 
	{
		if (this.atStart!=null) {
			throw new IllegalStateException("AtStart already defined");			
		}
		this.atStart=atStartCmd;
	}
	
	public AtStartCmd getAtStart()
	{
		return atStart;
	}

	@Override
	public CodeResult run(ExecutionEnvironment scope) {
		return scope.runBlock(this.block);
	}
	
	public Iterable<AtBlock> getAtBlocks()
	{
		List<AtBlock> result =null;
		boolean cloned=false;
		for (List<AtBlock> at : atBlocks) {
			if (at==null) continue;
			if (result==null) {
				result=at;
				continue;
			}
			if (!cloned) {
				result=new ArrayList<AtBlock>(result);
				cloned=true;
			}
			result.addAll(at);
		}
		if (result==null) {
			atBlocks[1]=new ArrayList<AtBlock>();
			return atBlocks[1];
		}
		return result;
	}

	public void addParent(CodeSection parent)
	{
		block.addAll(parent.block);
		for (int scan=0;scan<3;scan++) {
			if (atBlocks[scan]==null) {
				atBlocks[scan]=parent.atBlocks[scan];
			} else if (parent.atBlocks[scan]!=null) {
				atBlocks[scan].addAll(parent.atBlocks[scan]);
			}
		}
		atTypes.putAll(parent.atTypes);
		container.addAll(parent.container);
		sheet=parent.sheet;
		if (parent.localData!=null) {
			if (localData==null) {
				localData=parent.localData;
			} else {
				localData.addAll(parent.localData);
			}
		}
		classes.addAll(parent.classes);
		restrictions.addAll(parent.restrictions);
		if (prepare==null) {
			prepare=parent.prepare;
		}
		if (atStart==null) {
			atStart=parent.atStart;
		}

		if (parent.globalData!=null) {
			if (globalData==null) {
				globalData=parent.globalData;
			} else {
				globalData.addAll(parent.globalData);
			}
		}
	}

	@Override
	public String getLabel(ExecutionEnvironment environment) {
		return getItemType();
	}

	private UserSymbolScope declaredPrompts;
		
	public UserSymbolScope getDeclaredPrompts() 
	{
		if (declaredPrompts==null) {
			declaredPrompts=new UserSymbolScope("DeclaredPrompts for "+getItemType()+" "+getCodeID());
			declaredPrompts.setParent(new AppLoaderScope());
			SymbolList sl = new SymbolList();
			for (Widget w : getWidgets()) {
				w.declare(declaredPrompts,sl);
			}
		}
		return new UserSymbolScope(declaredPrompts,null);
	}
	
	public void declare(UserSymbolScope scope)
	{
		for (SymbolEntry se : getDeclaredPrompts().getAllSymbols()) {
			declare(scope,se,null);
		}
	}
	
	public void prime(ExecutionEnvironment env)
	{
		Set<SymbolEntry> addedSymbols = new HashSet<SymbolEntry>();
		for (SymbolEntry se : getDeclaredPrompts().getAllSymbols()) {
			declare(env.getCurrentSource().getScope(),se,addedSymbols);
		}
		
		Set<SymbolEntry> symbolsToPrime = new HashSet<SymbolEntry>(addedSymbols);
		
		while (!symbolsToPrime.isEmpty()) {
			Iterator<SymbolEntry> scan = symbolsToPrime.iterator();
			SymbolEntry fix = null;
			List<SymbolEntry> deps = new ArrayList<SymbolEntry>();
			while (scan.hasNext()) {
				SymbolEntry test = scan.next();
				boolean ok =true;
				deps.clear();
				scan.remove();
				for (SymbolEntry dep : test.getDependencies()) {
					if (addedSymbols.contains(dep)) {
						ok=false;
						break;
					}
					deps.add(dep);
				}
				if (ok) {
					fix=test;
					break;
				}
			}
			if (fix==null) break;
			if (fix.getWidget()==null) continue;
			
			if (deps.isEmpty()) {
				fix.getWidget().prime(env);
			} else {
				ListScanner[] scanner = new ListScanner[deps.size()];
				int depth=0;
				while ( true ) {
					if (depth<scanner.length) {
						scanner[depth]=deps.get(depth).list().values().loop(false);
						depth++;
					}
					if (!scanner[depth-1].next()) {
						scanner[depth-1].dispose();
						scanner[depth-1]=null;
						depth--;
						if (depth==-1) break;
						continue;
					}
					if (depth==scanner.length) {
						fix.getWidget().prime(env);
					}
				}
			}
		}
	}

	private SymbolEntry declare(UserSymbolScope scope, SymbolEntry se,Set<SymbolEntry> addedSymbols) 
	{
		SymbolEntry result = scope.get(se.getName());
		if (result!=null) return result;		
		List<SymbolEntry> deps = new ArrayList<SymbolEntry>();
		for (SymbolEntry scan : se.getDependencies()) {
			deps.add(declare(scope,scan,addedSymbols));
		}
		result = scope.declare(se.getName(),se.getType(),se.getValueType(),deps.toArray(new SymbolEntry[deps.size()]));		
		if (addedSymbols!=null) {
			addedSymbols.add(result);
			result.setWidget(se.getWidget());
		}
		return result;
	}

}
