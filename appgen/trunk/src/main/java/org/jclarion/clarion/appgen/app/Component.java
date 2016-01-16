package org.jclarion.clarion.appgen.app;

import java.util.Date;
import java.util.Iterator;

import org.jclarion.clarion.appgen.embed.Advise;
import org.jclarion.clarion.appgen.embed.AdviseStore;
import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.embed.SimpleEmbedStore;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.appgen.template.cmd.TemplateID;

public abstract class Component implements AdviseStore, AtSource, FieldStore
{
	private TemplateID base;
	private Date modified;
	private UserSymbolScope prompts;
	private AbstractFieldStore fields = new AbstractFieldStore();
	
	private SimpleEmbedStore<Embed> embeds = new SimpleEmbedStore<Embed>();
	private String description;
	private String category;
	private String longDescription;
	
	public Component()
	{
	}
	
	private Meta meta;
	@Override
	public Meta meta()
	{
		if (meta==null) meta=new Meta();
		return meta;
	}	
	
	public Component(Component base)
	{
		this.base=base.base;
		this.modified=base.modified;
		if (base.prompts!=null) {
			this.prompts=new UserSymbolScope(base.prompts,null,true);
		}
		fields = new AbstractFieldStore(base.fields);
		for (Embed e : base.embeds) {
			embeds.add(e);
		}
		this.description=base.description;
		this.category=base.category;
		this.longDescription=base.longDescription;
	}
	
	public void addEmbed(Embed e) {
		embeds.add(e);
	}

	public TemplateID getBase() {
		return base;
	}


	public void setBase(String system,String type) {
		base=new TemplateID(system,type);
	}

	public void setBase(TemplateID id) {
		base=id;
	}


	public Date getModified() {
		return modified;
	}


	public void setModified(Date modified) {
		this.modified = modified;
	}


	public UserSymbolScope getPrompts() {
		return prompts;
	}


	public void setPrompts(UserSymbolScope prompts) {
		this.prompts = prompts;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public String getLongDescription() {
		return longDescription;
	}


	public void setLongDescription(String longDescription) {
		this.longDescription = longDescription;
	}

	public void appendToLongDescription(String longDescription) {
		if (this.longDescription==null) {
			this.longDescription = longDescription;
		} else {
			this.longDescription = this.longDescription+longDescription;
		}
	}

	@Override
	public Iterator<? extends Advise> get(EmbedKey key,int minPriority,int maxPriority) {
		return embeds.get(key, minPriority, maxPriority);
	}

	public abstract String getType();
	public abstract String getName();
	
	public void debugEmbeds()
	{
		embeds.debug();
	}

	public void debug(EmbedKey key)
	{
		embeds.debug(key);
	}

	@Override
	public SimpleEmbedStore<Embed> getEmbeds() {
		return embeds;
	}
	
	@Override
	public int getAtSourceOrder()
	{
		return 0;
	}

	public Field getParentField()
	{
		return null;
	}

	@Override
	public void addField(Field f) {
		fields.addField(f);
	}

	@Override
	public void replaceField(String oldName, Field newField) {
		fields.replaceField(oldName,newField);
	}

	@Override
	public void addField(Field f, int position) {
		fields.addField(f,position);
	}

	@Override
	public Field getField(String name) {
		return fields.getField(name);
	}

	@Override
	public Iterable<Field> getFields() {
		return fields.getFields();
	}

	@Override
	public void deleteField(String name) {
		fields.deleteField(name);
	}

	@Override
	public int getOffset(Field f) {
		return fields.getOffset(f);
	}

	@Override
	public Field getPrevious(Field f) {
		return fields.getPrevious(f);
	}

	@Override
	public Field getNext(Field f) {
		return fields.getNext(f);
	}

	@Override
	public Field getField(int ofs) {
		return fields.getField(ofs);
	}

	@Override
	public int getFieldCount() {
		return fields.getFieldCount();
	}

	@Override
	public Field getFirstField() {
		return getFirstField();
	}

	@Override
	public Field getLastField() {
		return getLastField();
	}

	@Override
	public FieldStore getParentStore() {
		return null;
	}
}

