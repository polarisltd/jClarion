package org.jclarion.clarion.ide.dialog;

import org.eclipse.jface.dialogs.Dialog;
import org.eclipse.jface.dialogs.IDialogConstants;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.graphics.Font;
import org.eclipse.swt.graphics.FontData;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Table;
import org.eclipse.swt.widgets.TableColumn;
import org.eclipse.swt.widgets.TableItem;
import org.eclipse.ui.PlatformUI;
import org.jclarion.clarion.appgen.app.PrimaryFile;
import org.jclarion.clarion.appgen.dict.Dict;
import org.jclarion.clarion.appgen.dict.Key;

public class EditPrimaryFileDialog extends Dialog {

	
	private PrimaryFile key;
	private Dict dict;
	private String keySel;	

	public EditPrimaryFileDialog()
	{
		this(PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell());
	}
	
	/**
	 * Create the dialog.
	 * @param parentShell
	 * @wbp.parser.constructor
	 */	
	public EditPrimaryFileDialog(Shell parentShell) 
	{
		super(parentShell);
	}
	
	public void setInfo(PrimaryFile key,Dict dict)
	{
		this.key=key;
		this.dict=dict;
		this.keySel=key.getKey();
	}

	/**
	 * Create contents of the dialog.
	 * @param parent
	 */
	@Override
	protected Control createDialogArea(Composite parent) {
		getShell().setText("Add/Edit Primary File");
		Composite container = (Composite) super.createDialogArea(parent);	
		container.setLayout(new GridLayout(1,false));
		Table t = new Table(container,SWT.SINGLE| SWT.BORDER | SWT.FULL_SELECTION);
		t.setLayoutData(new GridData(GridData.FILL,GridData.FILL,true,true));
		t.setHeaderVisible(true);
		t.setLinesVisible (true);
		TableColumn c;
		c=new TableColumn(t, SWT.NONE);
		c.setText("Key");
		c=new TableColumn(t, SWT.NONE);
		c.setWidth(133);
		c.setText("Fields");
		
		
		
		TableItem ti = new TableItem(t,0);
		ti.setText("No Key");
		FontData fontData = ti.getFont().getFontData()[0];
		Font font = new Font(parent.getDisplay(), new FontData(fontData.getName(), fontData.getHeight(), SWT.ITALIC));
		ti.setFont(font);	

		if (key.getKey()==null || key.getKey().equals("")) {
			t.setSelection(0);
		}
		
		String keyname = key.getKey();
		keyname=keyname==null ? "" : keyname;
		keyname=keyname.substring(keyname.indexOf(':')+1);
		
		int maxpos=0;
		
		for (Key k : dict.getFile(key.getName()).getKeys()) {
			TableItem key = new TableItem(t,SWT.NONE);
			int pos=0;
			key.setText(0,k.getKey().getName());
			for (int scan=0;scan<k.getKey().getTypeProperty().getPropCount();scan++) {
				String s = k.getKey().getTypeProperty().getProp(scan).value;
				String lead="";
				if (s.startsWith("-")) {
					lead="-";
				}
				key.setText(++pos,lead+s.substring(s.indexOf(':')+1));
				
				if (pos>maxpos) {
					maxpos=pos;
					c=new TableColumn(t, SWT.NONE);
					c.setWidth(133);
					c.setText("");					
				}
			}
			
			if (keyname.equalsIgnoreCase(k.getKey().getName())) {
				t.setSelection(t.getItemCount()-1);
			}
		}
		
		for (int i=0; i<t.getColumnCount(); i++) {
			t.getColumn (i).pack ();
		}	
		
		t.addSelectionListener(new SelectionListener() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				Table t = (Table)e.widget;
				if (t.getSelectionIndex()==0) {
					keySel="";
				} else if (t.getSelectionIndex()>0) {
					keySel=dict.getFile(key.getName()).getFile().getValue("PRE")+":"+t.getSelection()[0].getText(0);
				}
			}

			@Override
			public void widgetDefaultSelected(SelectionEvent e) {
			}
		});
		
		return container;
	}

	
	
	@Override
	protected void okPressed() {
		this.key.setKey(keySel);
		super.okPressed();
	}

	/**
	 * Create contents of the button bar.
	 * @param parent
	 */
	@Override
	protected void createButtonsForButtonBar(Composite parent) {
		createButton(parent, IDialogConstants.OK_ID, IDialogConstants.OK_LABEL,true);
		createButton(parent, IDialogConstants.CANCEL_ID,IDialogConstants.CANCEL_LABEL, false);
	}

	/**
	 * Return the initial size of the dialog.
	 */
	@Override
	protected Point getInitialSize() {
		return new Point(450, 300);
	}

}
