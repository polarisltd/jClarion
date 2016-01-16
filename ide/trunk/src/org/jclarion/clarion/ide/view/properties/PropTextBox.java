package org.jclarion.clarion.ide.view.properties;


import org.eclipse.swt.SWT;
import org.eclipse.swt.events.FocusEvent;
import org.eclipse.swt.events.FocusListener;
import org.eclipse.swt.events.KeyEvent;
import org.eclipse.swt.events.KeyListener;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.widgets.Text;

public abstract class PropTextBox implements ModifyListener,FocusListener, KeyListener
{
	private Text text;
	private boolean modified=false;
	private Object priorValue;
	
	public abstract void setValueAsString(Object priorValue,String value,boolean commit);
	public abstract Object getValue();
	
	public PropTextBox(Text text) {
		this.text=text;
		text.addModifyListener(this);
        text.addFocusListener(this);
        text.addKeyListener(this);
	}
	
	public int getProperty()
	{
		return 0;
	}

	public void refresh() {

		String currentValue = text.getText();
		Object newValue = getValue();
		String s_newValue = newValue==null ? "" : newValue.toString(); 
		if (currentValue.equals(s_newValue)) return;
        text.removeModifyListener(this);
        modified=false;
        priorValue=newValue;
        text.setText(s_newValue);
        text.addModifyListener(this);
	}

	
		@Override
		public void modifyText(ModifyEvent e) {
			if (modified==false) {
				modified=true;
			}
			setValueAsString(priorValue,text.getText(),false);
		}

		@Override
		public void focusGained(FocusEvent e) 
		{
		}

		@Override
		public void focusLost(FocusEvent e) 
		{
			if (modified) {
				commit();
			}
		}

		public void commit() {
			modified=false;
			setValueAsString(priorValue,text.getText(),true);
			refresh();
		}
		
		@Override
		public void keyPressed(KeyEvent e) {
			if (modified && e.keyCode==SWT.CR) {
				commit();
			}
		}
		@Override
		public void keyReleased(KeyEvent e) {
		}
}
