package org.jclarion.clarion.ide.builder;
import org.eclipse.core.runtime.IProgressMonitor;
import org.jclarion.clarion.appgen.template.GeneratorProgress;

public class EclipseGeneratorProgress implements GeneratorProgress
{
	private IProgressMonitor monitor;

	public EclipseGeneratorProgress(IProgressMonitor monitor) {
		this.monitor=monitor;
	}

	@Override
	public void message(String arg0, int arg1) {
		if (monitor!=null) {
			monitor.subTask(arg0);
		}
	}

}
