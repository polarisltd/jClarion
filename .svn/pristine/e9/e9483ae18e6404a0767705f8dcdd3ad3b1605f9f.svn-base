package org.jclarion.clarion.appgen.template;

import java.io.IOException;


public abstract class TemplateItem 
{
	private boolean consume;
	private int line;
	private String file;

	public void consume(TemplateParser parser,TemplateItem parent) throws IOException
	{
		consume=true;
		if (parent!=null) {
			execute(parser,parent);
		}
	}
	
	public abstract String getItemType();
	
	public boolean isConsumed()
	{
		return consume;
	}

	public void noteTemplateSource(TemplateReader reader)
	{
		this.line=reader.getLine();
		this.file=reader.getFile();
	}
	
	public String getSrcRef()
	{
		return line+"@"+file;
	}
	
	public String getSrcFile()
	{
		return file;
	}

	public int getSrcLine()
	{
		return line;
	}
	
	protected void execute(TemplateParser parser,TemplateItem parent) throws IOException
	{
		parser.getReader().error("Do not know how to run "+this.getItemType()+" to "+parent.getItemType());
	}
}
