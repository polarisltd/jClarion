/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion.control;

import java.awt.Component;
import java.awt.Container;
import java.awt.KeyboardFocusManager;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JPanel;
import javax.swing.JToggleButton;

import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.ClarionBorder;
import org.jclarion.clarion.swing.TabLayout;
import org.jclarion.clarion.swing.gui.CommandList;
import org.jclarion.clarion.swing.gui.GUIModel;
import org.jclarion.clarion.swing.gui.ResponseRunnable;

public class SheetControl extends AbstractControl {
	public SheetControl setNoSheet() {
		setProperty(Prop.NOSHEET, true);
		return this;
	}
	
	public SheetControl setWizard() {
		setProperty(Prop.WIZARD, true);
		return this;
	}

	public SheetControl setSpread() {
		setProperty(Prop.SPREAD, true);
		return this;
	}

	private List<TabControl> tabs = new ArrayList<TabControl>();

	public void add(TabControl control) {
		tabs.add(control);
		control.setParent(this);
	}

	public void add(TabControl control,int offset) {
		tabs.add(offset,control);
		control.setParent(this);
	}
	
	public List<TabControl> getTabs() {
		return tabs;
	}

	@Override
	public List<TabControl> getChildren() {
		return getTabs();
	}

	@Override
	public boolean isAcceptAllControl() {
		return false;
	}

	@Override
	public boolean validateInput() {
		return true;
	}

	@Override
	public int getCreateType() {
		return Create.SHEET;
	}

	private class ChangeListener implements ClarionMemoryChangeListener {
		@Override
        public void objectChanged(ClarionMemoryModel model) {

            int val = getUseObject().intValue();
            if (val < 1 || val > getTabs().size()) return;
            if (val==selection) return;
            selection=val;
			changing = -1;
			try {
				forcedUpdate=true;
	            changeTab(val,false,null);
			} finally {
				forcedUpdate=false;				
			}
        }
	}

	private JPanel pane;
	private ChangeListener listener;
	private int selection = -1;
	private int changing = -1;
	private boolean forcedUpdate;

	@Override
	public void clearMetaData() {
		this.pane = null;
		this.listener = null;
		this.selection = -1;
		this.changing = -1;
		this.forcedUpdate = false;
		super.clearMetaData();
	}
	
	

	@Override
	public void disposeSwingComponent() {
		this.pane = null;
		this.selection = -1;
		this.changing = -1;
		this.forcedUpdate = false;
		super.clearMetaData();
	}

	@Override
	protected void debugMetaData(StringBuilder sb) {
		super.debugMetaData(sb);
		debugMetaData(sb, "pane", pane);
		debugMetaData(sb, "listener", listener);
		debugMetaData(sb, "selection", selection);
		debugMetaData(sb, "changing", changing);
		debugMetaData(sb, "forcedUpdate", forcedUpdate);
	}

    public void removeChild(AbstractControl control)
    {
    	tabs.remove(control);
    }	
	
	public void constructTab(TabControl control) {
		boolean wizard = isProperty(Prop.WIZARD);

		int count = 0;
		for (TabControl test : tabs) {
			if (!test.canConstruct())
				continue;
			count++;
			if (test == control) {
				break;
			}
		}

		if (!wizard) {
			control.initButton(pane, count);
		}

		for (AbstractControl tc : ((AbstractControl) control).getChildren()) {
			if (!tc.canConstruct())
				continue;
			tc.constructSwingComponent(getWindowOwner().getContentPane());
		}
	}

	@Override
	public void opened() {
		int init = 1;
		if (getUseObject() != null) {
			init = getUseObject().intValue();
			if (init < 1)
				init = 1;
			if (init > getTabs().size())
				init = getTabs().size();
			getUseObject().setValue(init);
			listener = new ChangeListener();
			getUseObject().addChangeListener(listener);
		}
		setProperty(Prop.SELSTART, init);
		super.opened();
	}

	@Override
	public void constructSwingComponent(Container parent) {
		if (pane!=null) return;
		pane = new JPanel();
		boolean wizard = isProperty(Prop.WIZARD);
		pane.setLayout(new TabLayout(isProperty(Prop.SPREAD)));
		// pane.setLayout(new TabLayout(true));
		addComponent(parent,pane);
		pane.setOpaque(false);
		pane.setBorder(new ClarionBorder(this, 1, 1, false) {
		    public boolean isBoxed(PropertyObject po)
		    {
		        return po.isProperty(Prop.BOXED) || !po.isProperty(Prop.WIZARD);     	
		    }			
		});

		int count = 0;
		for (final TabControl tab : getTabs()) {
			count++;
			if (!wizard) {
				tab.initButton(pane, count);
			}

			for (AbstractControl tc : ((AbstractControl) tab).getChildren()) {
				tc.constructSwingComponent(parent);
			}
		}

		int init = 1;
		if (getUseObject() != null) {
			init = getUseObject().intValue();
		}
		selection = init;

		configureFont(pane);
		configureColor(pane);
		setPositionAndState();
		toggleMode(getMode(Prop.HIDE), Prop.HIDE);
	}

	@Override
	public ClarionObject getLocalProperty(int index) {
		if (index == Prop.SELSTART) {
			if (changing > -1)
				return new ClarionNumber(changing);
			if (selection > -1)
				return new ClarionNumber(selection);
		}
		return super.getLocalProperty(index);
	}

	private SheetControl getUs() {
		return this;
	}

	private class ChangeTabTask implements Runnable {
		private ClarionEvent ev;
		private int val;
		private Runnable nextTask = null;

		public ChangeTabTask(ClarionEvent ev, int val, Runnable nextTask) {
			this.ev = ev;
			this.val = val;
			this.nextTask = nextTask;
		}

		@Override
		public void run() {
			
			if (!ev.getConsumeResult()) {
				changing = -1;
				forcedUpdate = false;
				return;
			}

			changeTab(val,true,nextTask);
		}
	}

	public static final int CHANGE_TAB = 100;
	public static final int NOTIFY_CHANGE = 101;

	public void notifyChange(int val)
	{
		GUIModel.getServer().send(this,NOTIFY_CHANGE,val);
	}

	@Override
	public CommandList getCommandList() {
    	return super.getCommandList()
    		.add("CHANGE_TAB",CHANGE_TAB)
    		.add("NOTIFY_CHANGE",NOTIFY_CHANGE)
    	;
    }
	
	@Override
	public Object command(int command, Object... params) {
		if (command == CHANGE_TAB) {
			handleChange((Integer) params[0],(Boolean)params[1],(Boolean)params[2]);
			return null;
		}
		if (command == NOTIFY_CHANGE) {
			setProperty(Prop.SELSTART,(Integer)params[0]);
			return null;
		}
		return super.command(command, params);
	}

	private void changeTab(int val,boolean post,final Runnable nextTask) {
		selection=val;
		changing=-1;
		if (getUseObject() != null) {
			getUseObject().setValue(val);
		}
		if (nextTask==null) {
			CWinImpl.run(this, null,CHANGE_TAB, val,post,forcedUpdate);
		} else {
			
			CWinImpl.run(this,new ResponseRunnable() {
				@Override
				public void run(Object result) {
					nextTask.run();
				}
			},CHANGE_TAB, val,post,forcedUpdate);
						
			//CWinImpl.run(this,CHANGE_TAB,val,post,forcedUpdate);
			//nextTask.run();
		}
		forcedUpdate = false;
	}

	private void handleChange(int val,boolean post,boolean forcedUpdate) {
		JPanel pane = getUs().pane;
		if (pane == null) return;
		
		try {
			// dodgy!
			Component c[] = pane.getComponents();
			for (int scan = 0; scan < c.length; scan++) {
				JToggleButton b = (JToggleButton) c[scan];
				if (scan == val - 1) {
					b.setSelected(true);
					// b.setContentAreaFilled(true);
					// b.setBorderPainted(false);
				} else {
					b.setSelected(false);
					// b.setContentAreaFilled(false);
					// b.setBorderPainted(true);
				}
			}

			selection = val;

			AbstractControl focus = getWindowOwner().getCurrentFocus();
			if (focus!=null) {
				boolean isDescendant=false;
				AbstractControl scan = focus;
				while (scan!=null && !isDescendant) {
					if (scan==this) {
						isDescendant=true;
					}
					scan=scan.getParent();
				}
				if (isDescendant) {
		        	KeyboardFocusManager.getCurrentKeyboardFocusManager().clearGlobalFocusOwner();
				}
			} else {
	        	KeyboardFocusManager.getCurrentKeyboardFocusManager().clearGlobalFocusOwner();
			}				
			
			toggleMode(getMode(Prop.HIDE), Prop.HIDE);
			
			if (!forcedUpdate) {
				Container base = pane.getFocusCycleRootAncestor();
				Component nc = base.getFocusTraversalPolicy().getComponentAfter(base, pane);
				if (nc != null) {
					nc.requestFocusInWindow();
				}
			}

			if (post) {
				post(Event.NEWSELECTION);
			}
			
		} finally {
		}
	}

	public void changeValue(final int val, final Runnable nextTask) {
		if (val < 1) return;
		if (val > getTabs().size()) return;
		if (val == selection) return;

		AbstractControl focus = getWindowOwner().getCurrentFocus();
		if (focus != null && focus.isAccept()) {
			CWinImpl.run(focus, new ResponseRunnable() {
				@Override
				public void run(Object result) {
					if (result == null || (Boolean) result) {
						doChangeValue(val, nextTask);
					}
				}
			}, RUN_ACCEPT);
			return;
		}
		doChangeValue(val, nextTask);
	}

	private void doChangeValue(final int val, final Runnable nextTask) {
		changing = val;
		ClarionEvent ce = post(Event.TABCHANGING);
		Runnable ctt = new ChangeTabTask(ce, val, nextTask);
		if (ce.runOnConsumedResult(ctt) != null) ctt.run();
	}

	@Override
	protected void doNotifyLocalChange(int indx, final ClarionObject value) {
		if (indx == Prop.SELSTART && isOpened()) {
			changeValue(value.intValue(), null);
		}
		super.doNotifyLocalChange(indx, value);
	}

	public void forceUpdate() {
		forcedUpdate = true;
	}

	public TabControl getSelectedTab() {
		if (selection <= 0)
			return null;
		return tabs.get(selection - 1);
	}

	@Override
	public Component getComponent() {
		return pane;
	}

	@Override
	public void addChild(AbstractControl control) {
		add((TabControl) control);
	}

	@Override
	public void addChild(AbstractControl control,int offset) {
		add((TabControl) control,offset);
	}

}
