package org.jclarion.clarion.appgen.app;

import java.util.ArrayList;
import java.util.List;

import org.jclarion.clarion.appgen.loader.Definition;
import org.jclarion.clarion.appgen.loader.DefinitionProperty;
import org.jclarion.clarion.appgen.symbol.SymbolValue;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;

public class Field extends AbstractFieldStore
{
	private Definition 			definition;
	private FieldStore 			parent;
	private List<String> 		screenControls=new ArrayList<String>();
	private List<String> 		reportControls=new ArrayList<String>();
	private Definition 			guiDefinition;
	private String 				longDescription;
	private boolean 			populate=true;
	
	public Field()
	{
	}
	
	public void setStore(FieldStore store)
	{
		this.parent=store;
	}
	
	@Override
	public FieldStore getParentStore()
	{
		return parent;
	}	
	
	public Field(Field base)
	{
		super(base);
		if (base.definition!=null) {
			this.definition=new Definition(base.definition);
		}
		this.screenControls.addAll(base.screenControls);
		this.reportControls.addAll(base.reportControls);
		if (base.guiDefinition!=null) {
			this.guiDefinition=new Definition(base.guiDefinition);
		}
		this.longDescription=base.longDescription;
		this.populate=base.populate;
	}
	
	public String getLabel() {
		return definition.getName();
	}
	
	public Definition getDefinition() {
		return definition;
	}
	
	public void setDefinition(Definition definition) {
		this.definition = definition;
	}
	
	public Definition getGuiDefinition() {
		return guiDefinition;
	}
	
	public void setGuiDefinition(Definition guiDefinition) {
		this.guiDefinition = guiDefinition;
	}
	
	public String getLongDescription() {
		return longDescription;
	}
	
	public void setLongDescription(String longDescription) {
		this.longDescription = longDescription;
	}
	
	public boolean isPopulate() {
		return populate;
	}
	
	public void setPopulate(boolean populate) {
		this.populate = populate;
	}
	
	public FieldStore getParent()
	{
		return parent;
	}
	
	
	public void addScreenControl(String def)
	{
		screenControls.add(def);
	}

	public void addReportControl(String def)
	{
		reportControls.add(def);
	}

	public SymbolValue getStatement() 
	{
		DefinitionProperty init = guiDefinition!=null ? guiDefinition.getProperty("INITIAL") : null;
		if (init!=null) {
			Definition d = new Definition(null,"");
			
			List<Lex> param = new ArrayList<Lex>();
			
			String type = definition.getTypeName();
			Lex val = init.getProp(0);
			
			if (type.toLowerCase().contains("string")) {
				param.add(val);
			}
			else if (type.toLowerCase().contains("decimal")) {
				for (Lex l : definition.getTypeProperty().getParams()) {
					param.add(l);
				}
				param.add(new Lex(LexType.integer,val.value));
			} else {
				param.add(new Lex(LexType.integer,val.value));
			}
			
			DefinitionProperty n = new DefinitionProperty(type,param);
			d.add(n);
			
			for (DefinitionProperty scan : definition.getProperties()) {
				d.add(scan);
			}
		
			return d.asSymbolValue();
		}
		return definition.getStatement().asSymbolValue();
	}

	@Override
	public Field getParentField()
	{
		if (parent instanceof Field) {
			return (Field)parent;
		}
		return null;
	}
}
