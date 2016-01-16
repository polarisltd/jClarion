package org.jclarion.clarion.appgen.app;

import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;

import org.jclarion.clarion.appgen.dict.Dict;
import org.jclarion.clarion.appgen.dict.DictLoader;
import org.jclarion.clarion.appgen.dict.TextDictLoad;
import org.jclarion.clarion.appgen.dict.TextDictStore;
import org.jclarion.clarion.appgen.symbol.user.AppLoaderScope;
import org.jclarion.clarion.appgen.symbol.user.UserSymbolScope;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.appgen.template.TemplateChain;
import org.jclarion.clarion.appgen.template.TemplateLoader;
import org.jclarion.clarion.appgen.template.at.AdditionExecutionState;
import org.jclarion.clarion.appgen.template.at.AtSource;
import org.jclarion.clarion.appgen.template.at.AtSourceSession;
import org.jclarion.clarion.appgen.template.cmd.CodeSection;

/**
 * Convert Barney's SoftVelocity .app and .dct into Clarion2Java application format.  
 * 
 * This class also de-crufts and purges unused/blank symbols creating tighter application source. 
 * 
 * @author barney
 */
public class Convert {
	public static void main(String args[]) throws IOException
	{
		// load Template Chain. Needed for decrufting
		
		TemplateChain chain = new TemplateChain();
		TemplateLoader loader = new TemplateLoader(chain);		
		loader.load("/home/barney/personal/c8/java/clarion/c9/src/main/template/c55/","abchain.tpl");
		loader.load("/home/barney/personal/c8/java/clarion/c9/src/main/template/c55/","LOCUSABC.tpl");
		chain.finalise();

		DictLoader dl = new DictLoader();
		Dict d = dl.loadDictionary("/home/barney/personal/c8/java/clarion/c9/src/main/clarion/common/c8odbc.txd");

		AppLoader al = new AppLoader();	
		App a = al.loadApplication("/home/barney/personal/c8/java/clarion/c9/src/main/clarion/main/c8.txa");
		
		TextAppStore tas; 
		tas = new TextAppStore(chain);
		tas.serialize(a, "target/app/");
		
		TextAppLoad tal;
		tal = new TextAppLoad(chain);
		a = tal.load("target/app/");
		
		ExecutionEnvironment decruft = new ExecutionEnvironment(chain,a,d);
		decruft.setLibSrc("resources/src/main/clarion/libsrc");
		decruft.init();
		decruft.setGenerationEnabled(false);
		decruft.generate(a,true);		
		purgeCruft(decruft,a);
		
		tas = new TextAppStore(chain);
		tas.serialize(a, "target/app/");
		
		
		
		TextDictStore store = new TextDictStore();
		FileWriter fw =new FileWriter("target/app/c8odbc.dict"); 
		store.save(d,fw);
		fw.close();		
		
		tal = new TextAppLoad(chain);
		a = tal.load("target/app");
		
		TextDictLoad tdl = new TextDictLoad();
		d=tdl.load(new FileInputStream("target/app/c8odbc.dict"));
		
		// generate for good measure
		ExecutionEnvironment ee = new ExecutionEnvironment(chain,a,d);
		ee.setLibSrc("resources/src/main/clarion/libsrc");
		
		
		ee.setTarget("target/");
		ee.setConditionalGenerate(false);
		ee.generate();
	}

	private static void purgeCruft(ExecutionEnvironment decruft, AtSource src) 
	{
		System.out.println("Decrufting : "+ src.getName());
		decruft.recycle();
		AtSourceSession session = decruft.getSession(src);		
		CodeSection cs = session.getCodeSection();		
		AdditionExecutionState state = session. prepareToExecute();
		session.prepare();
		UserSymbolScope ns=new UserSymbolScope(session.getScope(),new AppLoaderScope(),false);
		ns.constrainFields(cs.getDeclaredPrompts());
		src.setPrompts(ns);
		state.finish();
		
		for (AtSource kid : src.getChildren()) {
			purgeCruft(decruft,kid);
		}
	}
}
