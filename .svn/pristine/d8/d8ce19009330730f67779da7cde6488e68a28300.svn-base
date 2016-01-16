package org.jclarion.clarion.appgen.app;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolScope;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.system.FileStructureSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.at.AdditionExecutionState;
import org.jclarion.clarion.appgen.template.at.AtSource;

public class Procedure extends Component
{

	private String name;
	private String window;
	
	private List<Addition> rootAdditions=new ArrayList<Addition>();
	private Map<Integer,Addition> additions=new LinkedHashMap<Integer,Addition>();
	private List<String> calls=new ArrayList<String>();
	private String prototype;
	private PrimaryFile 		primary;
	private List<String> 	other=new ArrayList<String>();
	private boolean global;
	private Module parent;
	private Map<Integer,PrimaryFile> tempPrimaryFile = new HashMap<Integer,PrimaryFile>();
	
	public Procedure()
	{
	}
	
	public Procedure(Procedure base)
	{
		super(base);
		this.name=base.name;
		this.window=base.window;
		for (Addition scan : base.rootAdditions) {
			scan=new Addition(scan);
			rootAdditions.add(scan);
			cloneFixAdditions(scan);
		}
		calls.addAll(base.calls);
		this.prototype=base.prototype;
		if (base.primary!=null) {
			this.primary=new PrimaryFile(base.primary);
		}
		this.other.addAll(base.other);
		this.global=base.global;
		this.parent=base.parent;
		meta().setObject("Original",base);
	}
	
	private void cloneFixAdditions(Addition scan) {
		scan.setProcedure(this);
		additions.put(scan.getInstanceID(),scan);
		for (Addition kid : scan.getChildren()) {
			cloneFixAdditions(kid);
		}
	}

	public void setParent(Module parent)
	{
		this.parent=parent;
	}
	
	public Procedure clone()
	{
		return new Procedure(this);
	}
	
	
	public void addAddition(Addition scan) 
	{
		if (scan.getParentID()==0) {
			rootAdditions.add(scan);
		}
		additions.put(scan.getInstanceID(),scan);
		PrimaryFile f = tempPrimaryFile.remove(scan.getInstanceID()) ;
		if (f!=null) {
			scan.setPrimaryFile(f);
		}
		scan.setProcedure(this);
	}

	public void delete(Addition addition) {
		additions.remove(addition.getInstanceID());
		rootAdditions.remove(addition);
	}	
	
	public int getMaxInstanceID()
	{
		int max=0;
		for (int i : additions.keySet()) {
			if (i>max) max=i;
		}
		return max;
	}
	
	public Addition getAddition(int instance)
	{
		return additions.get(instance);
	}
	
	public void addCall(String call) 
	{
		calls.add(call);
	}
	
	public void replaceCalls(Collection<String> calls) {
		this.calls.clear();
		this.calls.addAll(calls);
	}

	public void setPrimaryFile(PrimaryFile f) {
		if (f.getInstanceID()==0) {
			primary=f;
		} else {
			Addition a = additions.get(f.getInstanceID());
			if (a==null) {
				tempPrimaryFile.put(f.getInstanceID(),f);
			} else {
				a.setPrimaryFile(f);
			}
		}
	}

	public void addOtherFile(String f) {
		other.add(f);
	}
	
	public PrimaryFile getPrimaryFile() {
		return primary;
	}

	public Collection<String> getOtherFiles() {
		return other;
	}
	
	public String getName() {
		return name;
	}
	
	private String oldName;

	public void setName(String name) {
		if (this.name!=null && !this.name.equals(name)) {
			// handle name change
			if (this.parent!=null) {
				parent.alertProcedureNameChange(this.name,name);
				if (this.parent.getParent()!=null) {
					parent.getParent().alertProcedureNameChange(this.name,name);
				}
			}
			oldName=this.name;
		}
		this.name = name;
	}
	
	public String getOldName(boolean clear)
	{
		String result=oldName;
		if (clear) {
			oldName=null;
		}
		return result;
	}
	

	public String getWindow() {
		return window;
	}

	public void setWindow(String window) {
		this.window = window;
	}

	public String getPrototype() {
		return prototype;
	}
	
	public String getReturnType()
	{
		if (prototype==null) return "";
		int len=prototype.length();
		if (len==0) return "";
		while (len>0) {
			char c = prototype.charAt(len-1);
			if (c==',') break;
			if (c>='a' && c<='z') {
				len--;
				continue;
			}
			if (c>='A' && c<='Z') {
				len--;
				continue;
			}
			if (c=='_' || c=='*' || c=='&' || c==':') {
				len--;
				continue;				
			}
			if (c>='0' && c<='9') {
				len--;
				continue;
			}
			return "";
		}
		return prototype.substring(len);
	}

	public void setPrototype(String prototype) {
		this.prototype = prototype;
	}

	public boolean isGlobal() {
		return global;
	}

	public void setGlobal(boolean global) {
		this.global = global;
	}
	
	public Collection<String> getCalls()
	{
		return calls;
	}
	
	public Collection<String> getAllCalls()
	{
		Set<String> calls = new LinkedHashSet<String>();
		calls.addAll(this.calls);
		
		for (SymbolEntry se : getPrompts().getAllSymbols()) {
			if (!"PROCEDURE".equals(se.getType())) continue;
			for (SymbolValue sv : se.getAllPossibleValues()) {
				calls.add(sv.getString());
			}
		}
		
		for (Addition a : additions.values()) {
			a.getAllCalls(calls);
		}
		
		return calls;
	}

	public Iterable<Addition> getAllAdditions() {
		return additions.values();
	}

	public Iterable<Addition> getAdditions() {
		return rootAdditions;
	}
	
	@Override
	public String getType() {
		return "Proc";
	}

	@Override
	public String getTemplateType() {
		return "#PROCEDURE";
	}

	@Override
	public Collection<? extends AtSource> getChildren() 
	{
		return rootAdditions;
	}

	@Override
	public void prepareToExecute(AdditionExecutionState state) 
	{
		state.set("%procedure",getName(),false);
	}

	@Override
	public AtSource getParent() {
		return parent;
	}


	@Override
	public SymbolScope getSystemScope(ExecutionEnvironment env) {
		return new FileStructureSymbolScope(primary,env);
	}

	
}
