package jclarion;


import java.io.FileOutputStream;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.FileHandler;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

import org.eclipse.core.runtime.Status;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.jface.text.rules.IPartitionTokenScanner;
import org.eclipse.jface.text.rules.ITokenScanner;
import org.eclipse.jface.text.rules.Token;
import org.eclipse.swt.widgets.Display;
import org.eclipse.ui.plugin.AbstractUIPlugin;
import org.osgi.framework.BundleContext;
import org.jclarion.clarion.ide.builder.AppCodeGenerator;
import org.jclarion.clarion.ide.editor.ClarionColorCoder;
import org.jclarion.clarion.ide.editor.ClarionIncPartitionScanner;
import org.jclarion.clarion.ide.editor.rule.ClarionWindowRule;
import org.jclarion.clarion.runtime.CWin;

/**
 * The activator class controls the plug-in life cycle
 */
public class Activator extends AbstractUIPlugin {

	private static final Logger LOGGER = Logger.getLogger(Activator.class.getName());	
	public static final String PLUGIN_ID = "clarion2java";

	/** The partitioning for Clarion *.inc source files */
	public static final String CLARION_INC_DOCUMENT_PARTITIONING = "__clarion_inc_partitioning";

	// Shared instance
	private static Activator plugin;

	public Activator() {
		super();
	}

	public static Activator getDefault() {
		return plugin;
	}

	public static ImageDescriptor getImageDescriptor(String path) {
		return imageDescriptorFromPlugin(PLUGIN_ID, path);
	}

	public void runOnUiThread(Runnable runnable) {
		Display.getDefault().asyncExec(runnable);
	}

	/**
	 * Returns the singleton partition scanner instance for Clarion *.inc files
	 */
	public IPartitionTokenScanner getClarionIncPartitionScanner() {
		return new ClarionWindowRule(new Token(ClarionIncPartitionScanner.CLARION_INC_WINDOW_CONTENT_TYPE));
	}

	/**
	 * Returns the singleton Clarion *.inc syntax colorer
	 */
	public ITokenScanner getClarionIncCodeScanner() {
		return new ClarionColorCoder();
	}

	public void start(BundleContext context) throws Exception {
		super.start(context);
		plugin = this;
		CWin.getInstance().setEditorMode();
		setupSystemOut(); // getting system.out.println in file
		setupLogger();

	}

	public void stop(BundleContext context) throws Exception {
		plugin = null;
		super.stop(context);
	}

	/**
	 * TODO: Add tag to identify caller
	 */
	public void logInfo(String message) {
		log(Status.INFO, message);
	}

	/**
	 * TODO: Add tag to identify caller
	 */
	public void logWarning(String message) {
		log(Status.WARNING, message);
	}

	/**
	 * TODO: Add tag to identify caller
	 */
	public void logError(String message, Exception e) {
		getLog().log(new Status(Status.ERROR, PLUGIN_ID, Status.OK, message, e));
	}

	private void log(int severity, String message) {
		getLog().log(new Status(severity, PLUGIN_ID, message));
	}

	void setupSystemOut(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
		String now = sdf.format(new Date());
		try{
		PrintStream fileStreamOut = new PrintStream(new FileOutputStream("system.out."+now,true));
		System.setOut(fileStreamOut);
		
		PrintStream fileStreamErr = new PrintStream(new FileOutputStream("system.err."+now,true));
		System.setErr(fileStreamErr);

		System.out.println("Redirecting system.out to file in Activator");
		}catch(Exception e){
			
		}
	}
	
	void setupLogger(){
		try{
		Handler files = new FileHandler("jclarion%g.log", 1024, 3, true);
	      // Use text formatter instead of default XML formatter
	      // Default level is ALL, no Filter.
	      files.setFormatter(new SimpleFormatter());
	      // Add the FileHander to the root logger.
	      Logger.getLogger("").addHandler(files);
	      Logger.getLogger("").setLevel(Level.ALL);
	      LOGGER.finest("logger setup - finest");
		  LOGGER.finer("logger setup - finer");
	      LOGGER.fine("logger setup - fine");
		  LOGGER.config("logger setup - config");
		  LOGGER.info("logger setup - info");
		  LOGGER.warning("logger setup - warning");
		  LOGGER.severe("logger setup - severe");

		}catch(Exception e){
			
		}
	}

	
	
	
}
