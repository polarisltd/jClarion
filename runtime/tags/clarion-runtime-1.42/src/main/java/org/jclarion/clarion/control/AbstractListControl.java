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

import java.awt.Container;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.util.HashMap;
import java.util.Map;

import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.text.JTextComponent;

import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.constants.Propstyle;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.ClarionCellRenderer;
import org.jclarion.clarion.swing.QueueComboModel;
import org.jclarion.clarion.swing.SimpleComboQueue;

public abstract class AbstractListControl extends AbstractControl
{
    protected ClarionQueue from;
    
    public final ClarionQueue getFrom()
    {
        if (from==null) from=new SimpleComboQueue();
        return from;
    }

    
    private Map<Integer,ListStyleProperty> listStyleProperties;
    private Map<Integer,String>            icons;
    
    
    public ListStyleProperty getListStyle(int index)
    {
        if (listStyleProperties==null) {
            listStyleProperties=new HashMap<Integer, ListStyleProperty>();
        }
        
        ListStyleProperty result = listStyleProperties.get(index);
        if (result==null) {
            result=new ListStyleProperty(this);
            listStyleProperties.put(index,result);
        }
        return result;
    }
    
    public String getIcon(int indx)
    {
        if (icons==null) return null;
        return icons.get(indx);
    }
    
    private int convListStylePropertyCodeToPropertyCode(int code)
    {
        switch(code) {
            case Propstyle.FONTNAME:
                return Prop.FONTNAME;
            case Propstyle.FONTSIZE:
                return Prop.FONTSIZE;
            case Propstyle.FONTCOLOR:
                return Prop.FONTCOLOR;
            case Propstyle.FONTSTYLE:
                return Prop.FONTSTYLE;
            case Propstyle.TEXTCOLOR:
                return Prop.FONTCOLOR;
            case Propstyle.BACKCOLOR:
                return Prop.BACKGROUND;
            case Propstyle.TEXTSELECTED:
                return Prop.SELECTEDCOLOR;
            case Propstyle.BACKSELECTED:
                return Prop.SELECTEDFILLCOLOR;
            case Propstyle.PICTURE:
                return Prop.TEXT;
            case Propstyle.CHARSET:
                return Prop.CHARSET;
            default:
                throw new RuntimeException("Not Supported:"+code);
        }
    }

    private class ComboModel implements ClarionMemoryChangeListener
    {
        @Override
        public void objectChanged(final ClarionMemoryModel model) {
            
            CWinImpl.run(new Runnable() {
                public void run()
                {
                    JComboBox c = combo;
                    if (c!=null) {
                        String s = ClarionString.rtrim(model.toString());
                        int indx = qcm.getIndex(s);
                        if (indx>0) {
                            if (c.getSelectedIndex()!=indx-1) {
                                c.setSelectedIndex(indx-1);
                            }
                            field.setText(s);
                        } else {
                            field.setText(s);
                        }
                    }
                }
            });
            
        }
    }
    
    private QueueComboModel qcm;
    private JComboBox       combo;
    private ComboModel      model;
    private JTextComponent  field;
    private boolean         forcedUpdate;
    
    @Override
    public void clearMetaData() 
    {
        this.qcm=null;
        this.combo=null;
        this.model=null;
        this.field=null;
        this.forcedUpdate=false;
        super.clearMetaData();
    }
    
    protected void debugBaseMetaData(StringBuilder sb) 
    {
        debugMetaData(sb,"qcm",qcm);
        debugMetaData(sb,"combo",combo);
        debugMetaData(sb,"model",model);
        debugMetaData(sb,"field",field);
        debugMetaData(sb,"forcedUpdate",forcedUpdate);
    }
    
    
    
    @Override
    public ClarionObject getAWTProperty(int index) 
    {
        
        
        if (index==Prop.SELSTART) {
            JComboBox c = combo;
            if (c!=null) {
                return new ClarionNumber(combo.getSelectedIndex() + 1);
            }
        }
        if (index==Prop.SCREENTEXT) {
            JTextComponent f = field;
            if (f!=null) {
                return new ClarionString(f.getText());
            }
        }
        return super.getAWTProperty(index);
    }
    
    @Override
    public boolean isAWTProperty(int index) {
        switch(index) {
            case Prop.SELSTART:
            case Prop.SCREENTEXT:
                return true;
            default:
                return super.isAWTProperty(index);
        }
    }
    
    
    @Override
    protected void notifyLocalChange(int indx,final ClarionObject value) 
    {
        if (combo!=null && indx==Prop.SELSTART) {
            CWinImpl.runNow(new Runnable() {
                public void run()
                {
                    JComboBox c = combo;
                    if (c!=null) {
                        combo.setSelectedIndex(value.intValue() - 1);
                        combo.repaint();
                    }
                }
            });
        }
        
        super.notifyLocalChange(indx,value);
    }
    
    
    
    @Override
    public void setProperty(ClarionObject key, ClarionObject index,
            ClarionObject value) {

        int ikey = key.intValue();

        if (ikey>=Propstyle.FIRST && ikey<=Propstyle.LAST) {
            ListStyleProperty po = getListStyle(index.intValue());  
            po.setProperty(
                    convListStylePropertyCodeToPropertyCode(ikey),value);
            return;
        }
        
        switch(ikey) {
            case Prop.ICONLIST: {
                if (icons==null) icons=new HashMap<Integer, String>();
                icons.put(index.intValue(),value.toString());
                return;
            }
        }
        
        // TODO Auto-generated method stub
        super.setProperty(key, index, value);
    }
    
    public void createComboControl(Container parent,boolean edit) 
    {
        qcm = new QueueComboModel(this);
        combo = new JComboBox(qcm);
        combo.setEditable(edit);
        ClarionCellRenderer ccr = new ClarionCellRenderer(this);
        combo.setRenderer(ccr);
        qcm.init(combo);
        field=(JTextComponent)combo.getEditor().getEditorComponent();
        
        if (getUseObject()==null) {
            use(new ClarionString());
        }
        field.setText(ClarionString.rtrim(getUseObject().toString()));
        model=new ComboModel();
        getUseObject().addChangeListener(model);

        int indx = 0;
        ClarionObject co = getLocalProperty(Prop.SELSTART);
        if (co != null) indx = co.intValue();
        indx--;

        combo.addItemListener(new ItemListener() {

            @Override
            public void itemStateChanged(ItemEvent e) {

                if (e.getStateChange()==ItemEvent.DESELECTED) return;
                
                if (forcedUpdate) return;
                
                int i = combo.getSelectedIndex();
                if (i >= 0) {
                    ClarionObject o = getUseObject();
                    if (o != null) {
                        o.setValue(qcm.getValue(i));
                    }
                }
                
                post(Event.NEWSELECTION);
                post(Event.ACCEPTED);
                
            } } );

        combo.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) 
            {
                JTextComponent _field=field;
                if (_field==null) return;

                if (e.getActionCommand().equals("comboBoxChanged")) return;

                String text = _field.getText().trim();
                if (getUseObject().toString().trim().equals(text)) {
                    return;
                }
                getUseObject().setValue(text);
                post(Event.NEWSELECTION);
                post(Event.ACCEPTED);
            }
        });
        
        if (indx>-1) {
            if (combo.getModel().getSize()>indx) {
                combo.setSelectedIndex(indx);
            }
        }

        configureFont(combo);
        configureColor(combo);
        setPositionAndState();
        setFocus(combo);
        setKey(combo);
        setKey((JComponent)combo.getEditor().getEditorComponent());
        parent.add(combo);
        
        field.addFocusListener(new FocusListener() {

            @Override
            public void focusGained(FocusEvent e) {
                JTextComponent jc = field;
                if (jc!=null) {
                    jc.selectAll();
                }
            }

            @Override
            public void focusLost(FocusEvent e) {
            } } );
    }

    public JComboBox getCombo()
    {
        return combo;
    }
    
    public abstract boolean isTableFocus();

    public void contentsChanged() 
    {
        if (model!=null) {
            model.objectChanged(getUseObject());
        }
        
    }
}
