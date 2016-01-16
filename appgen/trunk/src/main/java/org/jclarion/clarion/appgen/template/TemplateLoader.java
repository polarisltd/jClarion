package org.jclarion.clarion.appgen.template;

import java.io.IOException;

import org.jclarion.clarion.appgen.template.cmd.AtBlock;
import org.jclarion.clarion.appgen.template.cmd.CodeSection;
import org.jclarion.clarion.appgen.template.cmd.TemplateID;

public class TemplateLoader {

	public static void main(String args[]) throws IOException, InterruptedException 
	{
		loadAll();
		//loadAll();
	}
	
	public static void loadAll()  throws IOException
	{
		long start=System.currentTimeMillis();
		TemplateChain chain = new TemplateChain();
		TemplateLoader loader = new TemplateLoader(chain);		
		loader.load("/home/barney/personal/c8/java/clarion/c9/src/main/template/c55/","abchain.tpl");
		loader.load("/home/barney/personal/c8/java/clarion/c9/src/main/template/c55/","LOCUSABC.tpl");
		long end = System.currentTimeMillis();
		System.out.println("TOTAL:"+(end-start));
		
		CodeSection cs = chain.getSection("#CONTROL",new TemplateID("ABCLocus","RichEdit"));
		for (AtBlock ab :cs.getAtBlocks()) {
			System.out.println(ab);
		}
		
		//chain.debug();
	}
	
	private TemplateChain chain;
	
	public TemplateLoader(TemplateChain chain)
	{
		this.chain=chain;
	}
	
	public void load(String source,String name) throws IOException
	{
		load(new FileLoaderSource(source),name);
	}
	
	public void load(TemplateLoaderSource source,String name) throws IOException
	{
		TemplateParser tr = new TemplateParser(source);
		tr.setChain(chain);
		tr.getReader().addSource(name);
		
		try {
			while (true ) {
				TemplateItem al = tr.read();
				if (al==null) break;
				al.consume(tr,chain);
				//	System.out.println(al);
			}
		} catch (RuntimeException ex) { 
			ex.printStackTrace();
			tr.getReader().error(ex.getMessage());
		}
	}
}
