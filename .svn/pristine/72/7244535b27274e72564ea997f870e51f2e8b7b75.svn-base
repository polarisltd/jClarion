package org.jclarion.clarion.appgen.app;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.jclarion.clarion.appgen.embed.SimpleEmbedStore;
import org.jclarion.clarion.appgen.symbol.SymbolEntry;
import org.jclarion.clarion.appgen.symbol.SymbolScope;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.appgen.symbol.system.FileStructureSymbolScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.at.AdditionExecutionState;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.appgen.template.cmd.TemplateID;

public class Addition implements AtSource 
{
	private TemplateID 		base;
	private int 			instanceID;
	private int 			orderID;
	private boolean 		procedureProperty;
	private int 			parentID;
	private UserSymbolScope properties;
	
	private Procedure 		procedure;
	private Addition 		parent;
	private List<Addition> 	children=new ArrayList<Addition>();
	private PrimaryFile 	primary;
	
	
	public Addition()
	{
	}
	
	private Meta meta;
	@Override
	public Meta meta()
	{
		if (meta==null) meta=new Meta();
		return meta;
	}
	
	public Addition(Addition base)
	{
		this.base=base.base;
		this.instanceID=base.instanceID;
		this.orderID=base.orderID;
		this.procedureProperty=base.procedureProperty;
		this.parentID=base.parentID;
		if (base.properties!=null) {
			this.properties=new UserSymbolScope(base.properties,null,true);
		}
		this.procedure=base.procedure;
		this.parent=base.parent;
		for (Addition scan : base.children) {
			scan=new Addition(scan);
			scan.parent=this;
			this.children.add(scan);
		}
		if (base.primary!=null) {
			primary=base.primary.clone();
		}		
		meta().setObject("Original",base);
	}
	
	public Addition clone()
	{
		return new Addition(this);
	}
	
	public void addChild(Addition a) {
		a.parent=this;
		if (a.parentID==0) {
			a.parentID=instanceID;
		}
		children.add(a);
	}
	
	public void delete()
	{
		if (parent!=null) {
			parent.children.remove(this);
		}
		procedure.delete(this);
	}
	
	public void setProcedure(Procedure p)
	{
		this.procedure=p;
	}

	public TemplateID getBase() {
		return base;
	}
	
	public void setBase(String chain,String type)
	{
		base=new TemplateID(chain,type);
	}
	
	public void setBase(TemplateID id)
	{
		base=id;
	}

	public int getInstanceID() {
		return instanceID;
	}

	public int getAtSourceOrder() {
		return orderID;
	}

	public void setInstanceID(int instanceID) {
		this.instanceID = instanceID;
	}

	public void setOrderID(int orderID) {
		this.orderID=orderID;
	}

	public boolean isProcedureProperty() {
		return procedureProperty;
	}

	public void setProcedureProperty(boolean procedureProperty) {
		this.procedureProperty = procedureProperty;
	}

	public int getParentID() {
		return parentID;
	}

	public void setParentID(int parentID) {
		this.parentID = parentID;
	}

	public UserSymbolScope getProperties() {
		return properties;
	}

	public void setProperties(UserSymbolScope properties) {
		this.properties = properties;
	}

	public void setPrompts(UserSymbolScope properties) {
		this.properties = properties;
	}

	public Addition getParentAddition() {
		return parent;
	}

	public AtSource getParent() {
		if (parent!=null) {
			return parent;
		}
		return procedure;
	}

	public void setParent(Addition parent) {
		this.parent = parent;
	}

	public List<Addition> getChildren() {
		return children;
	}

	public void setChildren(List<Addition> children) {
		this.children = children;
	}

	public void getAllCalls(Set<String> collector) 
	{
		if (properties!=null) { 
			for (SymbolEntry se : properties.getAllSymbols()) {
				if (!"PROCEDURE".equals(se.getType())) continue;
				for (SymbolValue sv : se.getAllPossibleValues()) {
					collector.add(sv.getString());
				}
			}
		}
		
		for (Addition kid : children) {
			kid.getAllCalls(collector);
		}
	}

	public void setPrimaryFile(PrimaryFile f) {
		primary=f;
	}
	
	public PrimaryFile getPrimaryFile()
	{
		return primary;
	}
	
	private static int lastIIID=0;
	private int iiID= ++lastIIID;

	@Override
	public String toString() 
	{
		return "Addition [base=" + base + ", instanceID=" + instanceID+ ", iiID="+iiID+"]";
	}

	@Override
	public String getTemplateType() {
		return "#CONTROL";
	}

	@Override
	public UserSymbolScope getPrompts() 
	{
		return this.properties;
	}

	@Override
	public SimpleEmbedStore<Embed> getEmbeds() 
	{
		return procedure.getEmbeds();
	}

	@Override
	public void prepareToExecute(AdditionExecutionState state) 
	{
		//state.set("%activetemplate",base.getType()+"("+base.getChain()+")",true);
		state.set("%activetemplateinstance",String.valueOf(instanceID),true);
	}

	@Override
	public String getName() {
		return base.toString();
	}

	@Override
	public SymbolScope getSystemScope(ExecutionEnvironment environment) {
		if (primary!=null) { 
			return new FileStructureSymbolScope(primary,environment);
		}
		return getParent().getSystemScope(environment);
	}
}
