package org.jclarion.clarion.appgen.template;

import java.io.File;
import java.io.IOException;

import org.jclarion.clarion.appgen.app.App;
import org.jclarion.clarion.appgen.app.Module;
import org.jclarion.clarion.appgen.app.Procedure;
import org.jclarion.clarion.appgen.app.TextAppLoad;
import org.jclarion.clarion.appgen.dict.Dict;
import org.jclarion.clarion.appgen.dict.TextDictLoad;
import org.jclarion.clarion.appgen.template.cmd.TemplateID;
//import org.jclarion.clarion.appgen.template.prompt.EmbedEditor;
//import org.jclarion.clarion.appgen.template.prompt.MemoryFileSystem;
import org.jclarion.clarion.appgen.template.prompt.MemoryFileSystem;

public class Generator 
{
	public static void main(String args[]) throws IOException 
	{
		String from="/home/barney/personal/c8/java/clarion/c9/eclipse/";
		long start=System.currentTimeMillis();
		TemplateChain chain = new TemplateChain();
		TemplateLoader tl = new TemplateLoader(chain);
		tl.load((from+"templates/").replace('/',File.separatorChar), "abchain.tpl");
		tl.load((from+"templates/").replace('/',File.separatorChar), "LocusABC.tpl");
		chain.finalise();
		
		
		//App a = (new AppLoader()).loadApplication((from+"src/main/clarion/main/c8.txa").replace('/',File.separatorChar));
		
		
		App a = (new TextAppLoad(chain)).load(from+"/app");
		Dict d = (new TextDictLoad()).load(from+"/app/c8odbc.dict");
		long end=System.currentTimeMillis();		
		System.out.println("Load:"+(end-start));
		
		ExecutionEnvironment ee = new ExecutionEnvironment(chain,a,d);
		ee.setLibSrc((from+"libsrc").replace('/',File.separatorChar));
		ee.init();		
		ee.setTarget("target/");
		ee.setGenerationEnabled(true);
		ee.setConditionalGenerate(false);
		ee.generate(a);

		/*
		ee.open("edit.$$$",ExecutionEnvironment.CREATE);
		ee.setEditProcedure("edit.$$$","doMaxCheck",false);		
		ee.setGenerationEnabled(true);
		MemoryFileSystem mfs = new MemoryFileSystem();
		ee.setFileSystem(mfs);
		ee.generate(a.getProcedure("setup").getParent());
		System.out.println(a.getProcedure("setup").getParent().getName());
		MemoryFileSystem.log();
		BufferedWriteTarget target = mfs.get("target/c8063.clw");
		target.flushInto(new AppendableWriteTarget(System.out));
		*/
		
	}
}
