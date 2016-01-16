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

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.KeyboardFocusManager;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.AbstractButton;
import javax.swing.BoxLayout;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSeparator;
import javax.swing.JToggleButton;
import javax.swing.SwingUtilities;

import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.constants.Prop; 
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.MnemonicConfig.Mode;
import org.jclarion.clarion.swing.MnemonicDecoder;
import org.jclarion.clarion.swing.gui.GUIModel;



public class TreeMenuControl extends AbstractControl implements SimpleMnemonicAllowed, CustomMnemonic 
{
    @Override
    public boolean isAcceptAllControl() {
        return false;
    }

    @Override
    public boolean validateInput() {
        return true;
    }
    
    private List<Button>			buttons;
    private JPanel          		component;
    private ClarionQueue			queue;
    private int focus;
    private boolean			queueChanged=true;
    
    public static final int QUEUE_CHANGED=100;
    public static final int CHANGE_DEPTH=101;
    
    public ClarionQueue getQueue()
    {
    	return queue;
    }
    
    public void setQueue(ClarionQueue queue) {
    	if (queue!=this.queue) {
    		setProperty(Prop.SELSTART,0);
    		setProperty(Prop.SELEND,0);
    	}
    	this.queue=queue;
    	queueChanged=true;
    	if (isOpened()) {
    		CWinImpl.run(this,QUEUE_CHANGED);
    	}
    }
    
    
    
    @Override
	public Object command(int command, Object... params) {
    	if (command==QUEUE_CHANGED) {
    		configureMenu();
    		return null;
    	}
    	if (command==CHANGE_DEPTH) {
    		boolean val = (Boolean)params[0];
    		int row = (Integer)params[1];
    		boolean cval = queue.getValueAt(row,1).intValue()>0;
    		if (cval!=val) {
    			queue.toggle(row, 1);
    		}
    		return null;
    	}
    	return super.command(command, params);
    }
    
    public static final int MD_QUEUE=0x2100;
    
	@Override
	public Map<Integer, Object> getChangedMetaData() {
		if (isOpened() && queueChanged && queue!=null) {
			Map<Integer, Object> result = super.getChangedMetaData();
			if (result==null) result=new HashMap<Integer,Object>();
			
			Object o[] = new Object[queue.records()*queue.getVariableCount()+1];
			int scan=0;
			o[scan++]=queue.getVariableCount();			
			for (int row=1;row<=queue.records();row++) {
				ClarionObject[] r = queue.getRecord(row);
				for (ClarionObject co : r ) {
					if (co==null) {
						o[scan++]="";
						continue;
					}
					if (co instanceof ClarionNumber) {
						o[scan++]=co.intValue();
						continue;
					}
					if (co instanceof ClarionNumber) {
						o[scan++]=co.boolValue();
						continue;
					}
					o[scan++]=co.getString().clip().toString();
				}
			}
			result.put(MD_QUEUE, o);
			queueChanged=false;
			return result;
		}
		return super.getChangedMetaData();
	}

	@Override
	protected boolean setMetaData(int index, Object value) {
		if (index==MD_QUEUE) {
			ClarionQueue q = new ClarionQueue();
			Object x[] = (Object[])value;
			int scan=0;
			int vars = (Integer)x[scan++];
			
			while (scan<x.length) {
				for (int c = 0;c<vars;c++) {
					Object o = x[scan++];
					if (c>=q.getVariableCount()) {
						ClarionObject co = null;
						while (true) {
							if (o==null || o instanceof String) {
								co=new ClarionString();
								break;
							}
							if (o instanceof Boolean) {
								co=new ClarionBool();
								break;
							}
							if (o instanceof Integer) {
								co=new ClarionNumber();
								break;
							}
							co=new ClarionString();
							break;
						}
						q.addVariable("v"+c,co);
					}
					q.flatWhat(c+1).setValue(o);
				}
				q.add();				
			}
			queue=q;
			return true;		
		}
		return super.setMetaData(index,value);
	}	
    
    
	@Override
    public void clearMetaData() 
    {
        component=null;
        buttons=null;
        super.clearMetaData();
    }
    
    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"component",component);
   }
    
    
    private void refreshAllButtons()
    {
    	if (buttons==null) return;
    	for (Button b : buttons) {
    		if (b!=null) {
    			b.refreshButton();
    		}
    	}
    }
    
    public AbstractButton getSelectedButton()
    {
    	Button b = getButton(getProperty(Prop.SELSTART).intValue());
    	if (b==null) return null;
    	return b.button;
    }
    
    private Button findVisibleButton(int ofs,int dir)
    {
    	ofs+=dir;
    	while (ofs>=1 && ofs<=buttons.size()) {
    		Button b = buttons.get(ofs-1);
        	ofs+=dir;
    		if (b!=null && b.isDisplayable() && !b.isDisabled()) return b;
    	}
    	return null;
    }
    
    private int clickOnFocus=0;
    
    private class Button
    {
    	private Button parent;
    	private int id;
    	private int     mnemonic;
    	private boolean focus=false;
    	private boolean mouseover=false;
		private JPanel expand;
		private AbstractButton button;
    	private JPanel  children;
    	private JLabel toggle;
    	private boolean isExpanded;
    	
    	public Button()
    	{
    	}
    	
    	public boolean isDisplayable() {
    		if (button==null) return false;
    		if (parent==null) return true;
    		if (!parent.isExpanded) return false;
    		return parent.isDisplayable();
		}
    	
    	public boolean isDisabled()
    	{
    		return !button.isEnabled();
    	}

		public void expand(boolean val)
    	{
    		if (children==null) return;
    		if (val==isExpanded) return;
    		isExpanded=val;
    		component.getRootPane().revalidate();
    		GUIModel.getServer().send(TreeMenuControl.this,CHANGE_DEPTH,val,id);
    		setIcon();
    	}
    	
    	private void refreshButton()
    	{
    		if (button==null) return;
    		boolean selected=id==getProperty(Prop.SELEND).intValue();
			button.setContentAreaFilled(focus || mouseover || selected);
			button.getModel().setSelected(selected);
    	}
    	
    	public void setParent(Button b)
    	{
    		parent=b;
    	}
    	
    	
    	public void create(int id,String name,boolean hasKids,boolean expanded,int depth,int fontsize,boolean disable)
    	{
    		this.id=id;
    		this.button=new JToggleButton();
    		Font f = CWin.getInstance().getFontOnly(button, TreeMenuControl.this);
    		if (fontsize==0) fontsize=f.getSize()+1-depth;
    		f=new Font(f.getName(),depth==1 && fontsize>12 ? Font.BOLD : Font.PLAIN, fontsize);
            MnemonicDecoder dec = new MnemonicDecoder(name);
            mnemonic=Character.toUpperCase(dec.getMnemonicChar());
            button.setText(dec.getString());
            button.setHorizontalAlignment(SwingUtilities.LEFT);
            button.setFont(f);
            if (disable) {
            	button.setEnabled(false);
            }
            if (dec.getMnemonicPos() >= 0) {
                button.setDisplayedMnemonicIndex(dec.getMnemonicPos());
                if (!disable) {
                	getWindowOwner().getMnemonic(true).addMnemonic(TreeMenuControl.this,dec.getMnemonicChar(), Mode.SELECTONLY,0);
                }
            }
            
            if (!disable) {
			if (!hasKids) {
				button.addActionListener(new ActionListener() {
					@Override
					public void actionPerformed(ActionEvent e) {
						Button.this.accept();
					}
				});
            } else {
				button.addActionListener(new ActionListener() {
					@Override
					public void actionPerformed(ActionEvent e) {
						Button.this.button.getModel().setSelected(Button.this.id==getProperty(Prop.SELEND).intValue());
					}
				});            	
            }
            
    		button.addMouseListener(new MouseAdapter() {
				@Override
				public void mouseExited(MouseEvent e) {
					mouseover=false;
					refreshButton();
				}
				
				@Override
				public void mouseEntered(MouseEvent e) {
					mouseover=true;
					refreshButton();
				}
				
				@Override
				public void mouseClicked(MouseEvent e) 
				{
					if (children==null) return;
					
					if (e.getClickCount()==2) {
						e.consume();
						Button.this.accept();
					}
					if (e.getClickCount()==1) {
						e.consume();
						expand(!Button.this.isExpanded);
					}					
				}
			});
    		
    		button.addFocusListener(new FocusListener() {
				
				@Override
				public void focusLost(FocusEvent e) {
					focus=false;
					TreeMenuControl.this.focus=0;
					refreshButton();
				}
				
				@Override
				public void focusGained(FocusEvent e) {
					focus=true;
					TreeMenuControl.this.focus=Button.this.id;
					refreshButton();
					setProperty(Prop.SELSTART,Button.this.id);
					if (clickOnFocus==Button.this.id) {
						button.doClick();
					}
					clickOnFocus=0;
				}
			});
    		
    		setFocus(button);
    		setKey(button);    		
    		
    		button.addKeyListener(new KeyAdapter() {
				@Override
				public void keyPressed(KeyEvent e) {
					if (e.isConsumed()) return;
					if (e.getKeyCode()==KeyEvent.VK_ENTER) {
						button.doClick();
						e.consume();
						return;
					}
					if (e.getKeyCode()==KeyEvent.VK_DOWN) {
						Button c=findVisibleButton(Button.this.id,1);
						if (c!=null) {
							c.button.requestFocus();
						}
						e.consume();
					}
					if (e.getKeyCode()==KeyEvent.VK_UP) {
						Button c=findVisibleButton(Button.this.id,-1);
						if (c!=null) {
							c.button.requestFocus();
						}
						e.consume();
					}

					if (e.getKeyCode()==KeyEvent.VK_RIGHT) {
						if (children!=null) {
							expand(true);
						}
						e.consume();
					}
					if (e.getKeyCode()==KeyEvent.VK_LEFT) {
						if (children!=null) {
							expand(false);
						}
						e.consume();
					}
				}
			});    	    	
    		
            }
    		
    		expand=new JPanel(new FlowLayout());
    		expand.setOpaque(false);
    		
    		if (hasKids) {
    			this.isExpanded=expanded && !disable;
    			children=new JPanel();
    	    	children.setOpaque(false);    			
    			children.setLayout(new BoxLayout(children,BoxLayout.Y_AXIS));
    			toggle = new JLabel();
    			setIcon();
        		toggle.addMouseListener(new MouseAdapter() {
					@Override
					public void mouseClicked(MouseEvent e) {
						button.requestFocus();
						expand(!Button.this.isExpanded);
					}
        			
        		});
    			expand.add(toggle);
    			Dimension d = toggle.getPreferredSize();
    			BufferedImage bi = new BufferedImage(10, 10, BufferedImage.TYPE_3BYTE_BGR);
    			Graphics g = bi.getGraphics();
    			FontMetrics fm = g.getFontMetrics(f);
    			d.height = d.height < fm.getHeight()+2 ? fm.getHeight()+2 : d.height;
    			toggle.setPreferredSize(d);
    		} else {
    			/*
    			JLabel lab = new JLabel(CWin.getInstance().getIcon(Icon.BULLET,0,0));
    			Dimension d = lab.getPreferredSize();
    			BufferedImage bi = new BufferedImage(10, 10, BufferedImage.TYPE_3BYTE_BGR);
    			Graphics g = bi.getGraphics();
    			FontMetrics fm = g.getFontMetrics(f);
    			d.height = d.height < fm.getHeight()+2 ? fm.getHeight()+2 : d.height;
    			lab.setPreferredSize(d);
    			expand.add(lab);
    			*/
    		}

    		
            refreshButton();
    	}
    	
    	protected void accept() {
			setProperty(Prop.SELEND,Button.this.id);
			setProperty(Prop.SELSTART,Button.this.id);
			refreshAllButtons();
			post(Event.ACCEPTED);
		}

		private boolean isAncestor(Container parent,Component child)
    	{
    		while (child!=null) {
    			if (child==parent) return true;
    			child=child.getParent();
    		}
    		return false;
    	}
    	
    	private void setIcon() {
    		if (isExpanded) {
    			toggle.setIcon(CWin.getInstance().getIcon(Icon.DOWN,0,0));
    			children.setVisible(true);    			
    		} else {
    			toggle.setIcon(CWin.getInstance().getIcon(Icon.VCRPLAY,0,0));
    			children.setVisible(false);
    			if (isAncestor(children,KeyboardFocusManager.getCurrentKeyboardFocusManager().getFocusOwner())) {
    				button.requestFocus();
    			}
    		}
    	}
    	
    	public AbstractButton getButton()
    	{
    		return button;
    	}
    	
    	public JPanel getExpand()
    	{
    		return expand;
    	}
    	
    	public JPanel getChildren()
    	{
    		return children;
    	}
    }
    
    
    
    @Override
    public void constructSwingComponent(Container parent) 
    {
    	if (component!=null) return;
    	System.out.println("Constructing menu");
    	component = new JPanel();
    	BoxLayout bl = new BoxLayout(component,BoxLayout.Y_AXIS);
    	addComponent(parent, component);
    	component.setAlignmentX(0);
    	component.setLayout(bl);
    	component.setOpaque(false);
    	
    	configureMenu();
    }
    
    private void configureMenu()
    {
    	if (component==null) return;
    	component.removeAll();
    	buttons=new ArrayList<Button>();
    	
    	if (queue==null) return;
    	
    	Button target[]= new Button[5];
    	
    	for (int scan=1;scan<=queue.records();scan++) {
    		ClarionObject co[] = queue.getRecord(scan);
    		int depth=Math.abs(co[0].intValue());

    		if (co[1].equals("===")) {
    			JSeparator js = new JSeparator();
    			component.add(js);
    			buttons.add(new Button());
    			continue;
    		}

    		boolean kids=false;
    		if (scan<queue.records()) {
    			int nd = Math.abs(queue.getValueAt(scan+1,1).intValue());
    			if (nd>depth) {
    				kids=true;
    			}
    		}
    		
    		Button opt = new Button();
    		buttons.add(opt);
    		opt.create(scan,co[1].toString(),kids,co[0].intValue()>=0,depth,co.length>=4 ? co[3].intValue() : 0,co.length>=5 ? co[4].boolValue() : false);
    		if (co.length>=3 && co[2].toString().length()>0) {
    			opt.button.setToolTipText(co[2].toString());
    		}
    		
    		
    		JPanel panel = new JPanel(new BorderLayout());
    		panel.setOpaque(false);
    		panel.add(opt.getButton(),BorderLayout.CENTER);
    		if (kids) {
    			panel.add(opt.getChildren(),BorderLayout.SOUTH);
				JPanel wrap = new JPanel(new BorderLayout());
				wrap.setOpaque(false);
				wrap.add(panel,BorderLayout.CENTER);
				panel=wrap;
				target[depth+1]=opt;
    		}
    		panel.add(opt.getExpand(),BorderLayout.WEST);
    		if (depth==1) {
    			component.add(panel); 
    		} else {
    			target[depth].getChildren().add(panel);
    		}
			opt.setParent(target[depth]);
    	}    	
    	
    	if (component.getRootPane()!=null) {
    		component.getRootPane().revalidate();
    	}
    }

    
	@Override
    public int getCreateType() {
        return Create.TREEMENU;
    }

    @Override
    public Component getComponent() {
        return component;
    }

	@Override
	protected boolean isCopy() {
		return false;
	}

	@Override
	public boolean handleMnemonic(int chr) 
	{
		int f=focus-1;
		for (int scan=0;scan<buttons.size();scan++) {
			f++;
			if (f==buttons.size()) {
				f=0;
			}
			Button b = buttons.get(f);
			if (b!=null && b.isDisplayable() && chr==b.mnemonic && !b.isDisabled()) {
				if (b.children==null) {
					clickOnFocus=b.id;
					b.getButton().requestFocus();
				} else {
					b.getButton().requestFocus();
					b.expand(true);
				}
				return true;
			}
		}
		return false;
	}
	
	
	 protected boolean isAWTChange(int indx)
	 {
		 if (indx==Prop.SELSTART || indx==Prop.SELEND) return true;
		 return super.isAWTChange(indx);
	 }
	 
	 protected void handleAWTChange(int indx, ClarionObject value) {
		 super.handleAWTChange(indx, value);
		 //if (forcedUpdate) return;
		 if (indx==Prop.SELEND) {
			 Button b = getButton(value.intValue());
			 if (b!=null) {
				 b=b.parent;
				 while (b!=null) {
					 b.expand(true);
					 b=b.parent;
				 }
			 }
			 refreshAllButtons();
		 }
		 if (indx==Prop.SELSTART) {
			 Button b = getButton(value.intValue());
			 if (b!=null) {
				 b.button.requestFocus();
				 b=b.parent;
				 while (b!=null) {
					 b.expand(true);
					 b=b.parent;
				 }
			 }
		 }
	 }
	 
	 private Button getButton(int indx)
	 {
		 if (buttons==null) return null;
		 if (indx<1 || indx>buttons.size()) return null;
		 return buttons.get(indx-1);
	 }
	 
	 
}
