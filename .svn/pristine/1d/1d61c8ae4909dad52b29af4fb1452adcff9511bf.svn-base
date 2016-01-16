package org.jclarion.clarion.appgen.template.prompt;

import java.io.PrintStream;

import org.jclarion.clarion.appgen.app.Embed;
import org.jclarion.clarion.appgen.embed.EmbedKey;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.util.SharedWriter;

public class EmbeditorBlock {
	
	private EmbeditorBlock 	previous;
	private EmbeditorBlock 	next;	
	private EmbedKey 		key;
	private Embed    		embed;
	private SharedWriter 	writer=new SharedWriter();
	private int 			priority;
	private String			indent;
	private AtSource 		origin;
	
	
	
	public EmbeditorBlock()
	{
	}
	
	public EmbeditorBlock(AtSource origin,EmbedKey key,int priority,String indent)
	{
		if (origin==null) throw new IllegalStateException("Origin is null");
		this.key=key;
		this.indent=indent;
		this.priority=priority;
		this.origin=origin;
	}

	public EmbeditorBlock(AtSource origin,Embed embed,String indent)
	{
		if (origin==null) throw new IllegalStateException("Origin is null");
		this.embed=embed;
		this.key=this.embed.getKey();
		this.priority=this.embed.getPriority();
		this.indent=indent;
		this.origin=origin;
	}
	
	public AtSource getOrigin()
	{
		return origin;
	}
	
	public EmbeditorBlock add(EmbeditorBlock next)
	{
		this.next=next;
		next.previous=this;
		return next;
	}

	public int getPriority()
	{
		return priority;
	}
	
	public EmbeditorBlock getPrevious() {
		return previous;
	}

	public EmbeditorBlock getNext() {
		return next;
	}

	public EmbedKey getKey() {
		return key;
	}

	public String getIndent()
	{
		return indent;
	}
	
	public Embed getEmbed() {
		return embed;
	}
	
	public SharedWriter getWriter()
	{
		return writer;
	}

	public void log(PrintStream printStream) 
	{
		if (indent!=null) {
			//printStream.append(writer.toString();
			printStream.print(" * ");
			printStream.print(this.writer.toString().replace("\n", "\n * "));
			printStream.println(indent);
		} else {
			printStream.append(writer);			
		}
		if (next!=null) {
			next.log(printStream);
		}
	}
	
	
}
