package org.jclarion.clarion.ide.nature;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import org.eclipse.core.resources.ICommand;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IProjectDescription;
import org.eclipse.core.resources.IProjectNature;
import org.eclipse.core.runtime.CoreException;

public class ClarionNature implements IProjectNature
{
	public ClarionNature()
	{
	}
	
	private IProject project;

	@Override
	public void configure() throws CoreException {
		IProjectDescription description = project.getDescription();
		List<ICommand> builds = new ArrayList<ICommand>(Arrays.asList(description.getBuildSpec()));
		Iterator<ICommand> scan = builds.iterator();
		while (scan.hasNext()) {
			if (scan.next().getBuilderName().equals("org.jclarion.clarion.ide.builder.AppCodeGenerator")) {
				return;
			}
		}
		ICommand cmd = description.newCommand();
		cmd.setBuilderName("org.jclarion.clarion.ide.builder.AppCodeGenerator");
		builds.add(0,cmd);
		cmd = description.newCommand();
		cmd.setBuilderName("org.jclarion.clarion.ide.builder.ClarionToJavaBuilder");
		builds.add(1,cmd);
		description.setBuildSpec(builds.toArray(new ICommand[builds.size()]));
		project.setDescription(description, null);

		/*
		new Job("Configure Clarion Project") {
			@Override
			protected IStatus run(IProgressMonitor monitor) {
				try {
					System.out.println("ERE!!!");
					project.build(IncrementalProjectBuilder.FULL_BUILD,"org.jclarion.clarion.ide.builder.AppCodeGenerator",null,monitor);
				} catch (CoreException e) {
					e.printStackTrace();
				}
				return Status.OK_STATUS;
			}
		
		}.schedule();
		*/
	}

	@Override
	public void deconfigure() throws CoreException {
		IProjectDescription description = project.getDescription();
		List<ICommand> builds = new ArrayList<ICommand>(Arrays.asList(description.getBuildSpec()));
		Iterator<ICommand> scan = builds.iterator();
		boolean altered=false;
		while (scan.hasNext()) {
			String name = scan.next().getBuilderName();
			if (name.equals("org.jclarion.clarion.ide.builder.AppCodeGenerator") || name.equals("org.jclarion.clarion.ide.builder.Clarion2JavaBuilder")) {
				scan.remove();
				altered=true;
			}
		}
		if (altered) {
			description.setBuildSpec(builds.toArray(new ICommand[builds.size()]));
			project.setDescription(description, null);
		}
	}

	@Override
	public IProject getProject() {
		return project;
	}

	@Override
	public void setProject(IProject project) {
		this.project=project;
	}

}
