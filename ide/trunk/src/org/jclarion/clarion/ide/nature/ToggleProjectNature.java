package org.jclarion.clarion.ide.nature;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.IProjectDescription;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.jface.action.ContributionItem;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.MenuAdapter;
import org.eclipse.swt.events.MenuEvent;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.widgets.Menu;
import org.eclipse.swt.widgets.MenuItem;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.PlatformUI;

public class ToggleProjectNature extends ContributionItem
{

	public ToggleProjectNature() {
		super();
	}

	public ToggleProjectNature(String id) {
		super(id);
	}

	@Override
	public void fill(Menu menu, int index) {
		final MenuItem menuItem = new MenuItem(menu,SWT.CHECK,index);
		menuItem.setText("Add/Remove Clarion Support");
		menuItem.addSelectionListener(new SelectionAdapter()
		{
			@Override
			public void widgetSelected(SelectionEvent e) {
				run();
			}
			
		});
		menu.addMenuListener(new MenuAdapter() {
			@Override
			public void menuShown(MenuEvent e) {
				updateState(menuItem);
			}
			
		});
		super.fill(menu, index);
	}
	
	private void updateState(MenuItem item)
	{
		IProject project = getProject();
		item.setEnabled(project!=null);
		try {
			item.setSelection(project!=null && project.hasNature("jclarion.Clarion"));
		} catch (CoreException e) {
			item.setSelection(false);
			e.printStackTrace();
		}
	}
	
	private IProject getProject()
	{
		IWorkbenchWindow window = PlatformUI.getWorkbench().getActiveWorkbenchWindow();
		ISelection s = window.getActivePage().getSelection();
		if (s instanceof IStructuredSelection) {
			IStructuredSelection iss = (IStructuredSelection)s;
			if (!iss.isEmpty()) {
				if (iss.getFirstElement() instanceof IProject) {
					return (IProject)iss.getFirstElement();
				}
			}
		}
		return null;
	}

	private void run()
	{
		IProject proj = getProject();
		if (proj!=null) {
			try {
				IProjectDescription pd = proj.getDescription();
				List<String> natures = new ArrayList<String>(Arrays.asList(pd.getNatureIds()));
				boolean added=false;
				if (!natures.remove("jclarion.Clarion")) {
					added=true;
					natures.add("jclarion.Clarion");
				}
				pd.setNatureIds(natures.toArray(new String[natures.size()]));
				proj.setDescription(pd, null);
				if (added) {
					// TODO : register builders
				}
			} catch (CoreException e) {
				e.printStackTrace();
			}
		}
	}
	
}
