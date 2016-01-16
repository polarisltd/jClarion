package jclarion;


import org.eclipse.core.runtime.Status;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.jface.text.rules.IPartitionTokenScanner;
import org.eclipse.jface.text.rules.ITokenScanner;
import org.eclipse.jface.text.rules.Token;
import org.eclipse.swt.widgets.Display;
import org.eclipse.ui.plugin.AbstractUIPlugin;
import org.osgi.framework.BundleContext;

import org.jclarion.clarion.ide.editor.ClarionColorCoder;
import org.jclarion.clarion.ide.editor.ClarionIncPartitionScanner;
import org.jclarion.clarion.ide.editor.rule.ClarionWindowRule;
import org.jclarion.clarion.runtime.CWin;

/**
 * The activator class controls the plug-in life cycle
 */
public class Activator extends AbstractUIPlugin {

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

}
