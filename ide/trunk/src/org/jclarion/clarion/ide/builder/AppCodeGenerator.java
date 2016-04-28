package org.jclarion.clarion.ide.builder;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.FileHandler;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

//import org.apache.log4j.Logger;

import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IFolder;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IResource;
import org.eclipse.core.resources.IResourceDelta;
import org.eclipse.core.resources.IncrementalProjectBuilder;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;
//import org.eclipse.core.runtime.Plugin;
import org.jclarion.clarion.appgen.app.Module;
import org.jclarion.clarion.appgen.template.ExecutionEnvironment;
import org.jclarion.clarion.ide.model.AppProject;

import jclarion.Activator;


public class AppCodeGenerator extends IncrementalProjectBuilder
{
	private static final Logger LOGGER = Logger.getLogger(AppCodeGenerator.class.getName());	
//	@Inject Logger logger; 

	@Override
	protected IProject[] build(int kind, Map<String, String> args,IProgressMonitor monitor) throws CoreException 
	{
		Activator.getDefault().logWarning("AppCodeGenerator.build() ENTRY");
		System.out.println("AppCodeGenerator.build() ENTRY >> system.out.println");
		LOGGER.finest("AppCodeGenerator.build() ENTRY >> logger");
		IResource ir = getProject().findMember("clarion/main"); // this is location of clarion sources right under project dir.
        System.out.println("locating clarion/main");
		// this build() will generate/incremental clarion source from template
		// appgen.template.ExecutionEnvironment
		if (!ir.exists()) return null;
		if (!(ir instanceof IFolder)) {
			return null;
		}
		System.out.println("clarion/main located: "+ir.getName());
		AppProject o = AppProject.get(getProject());
		if (o.getApp()==null) return null;
		
		IFolder base = (IFolder)ir;
		System.out.println("clarion/main folder: "+base.getName());
	    
		boolean any=false;
		for (IResource r : base.members()) {
			if (r instanceof IFile) {
				any=true;
				break;
			}
		}
		if (!any) {
			System.out.println("No generated source. Requesting full build");
			kind=IncrementalProjectBuilder.FULL_BUILD;
		}
		
		
		
		if (kind==IncrementalProjectBuilder.FULL_BUILD || kind==IncrementalProjectBuilder.CLEAN_BUILD) {
			System.out.println("Running full build");
			ExecutionEnvironment ee = o.newEnvironment();
			ee.setGeneratorProgress(new EclipseGeneratorProgress(monitor));
			ee.setFileSystem(new AppGenFileSystem(base));
			ee.setGenerationEnabled(true);
			ee.setConditionalGenerate(false);
			ee.generate();
		} else {			
			System.out.println("Running incremental build");
			ExecutionEnvironment ee = o.getEnvironment(true);
			ee.setFileSystem(new AppGenFileSystem(base));
			ee.setGenerationEnabled(true);
			ee.setConditionalGenerate(true);
			ee.setGeneratorProgress(new EclipseGeneratorProgress(monitor));
			
			Map<String,Module> regen = new HashMap<String,Module>();
			for (Module m : o.getApp().getModules()) {
				if (m.getSource()==null) continue;
				IFile f = (IFile)m.getSource();
				regen.put(f.getFullPath().toString(), m);
			}
			processDelta(ee,regen,getDelta(getProject()),monitor);

			o.recycleEnvironment(ee);
		}
		
		return null;
	}
	
	

	@Override
	protected void clean(IProgressMonitor monitor) throws CoreException {
		/*
		IResource ir = getProject().findMember("clarion/main");
		if (!ir.exists()) return;
		if (!(ir instanceof IFolder)) {
			return;
		}
		
		IFolder base = (IFolder)ir;
		for (IResource r: base.members()) {
			if (r instanceof IFile) {
				r.delete(true, monitor);
			}
		}
		*/
	}



	private void processDelta(ExecutionEnvironment ee,Map<String, Module> regen, IResourceDelta delta,IProgressMonitor monitor) {
		Activator.getDefault().logWarning("processDelta");
		if (delta==null) return;	
		if (delta.getResource().getFullPath()!=null) {
			Module m = regen.remove(delta.getResource().getFullPath().toString());
			if (m!=null) {
				if (monitor!=null) {
					monitor.subTask("Generating "+m.getName());
				}
				ee.generate(m);
			}
		}
		for (IResourceDelta scan : delta.getAffectedChildren()) {
			processDelta(ee,regen,scan,monitor);
		}
	}
	

//////////////////////

//////////////////////	
	
	

}
