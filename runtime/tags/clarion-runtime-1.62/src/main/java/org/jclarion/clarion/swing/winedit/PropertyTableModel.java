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
package org.jclarion.clarion.swing.winedit;

import java.awt.Color;
import java.awt.Component;
import java.util.List;

import javax.swing.JComponent;
import javax.swing.border.Border;
import javax.swing.border.CompoundBorder;
import javax.swing.border.LineBorder;
import javax.swing.table.AbstractTableModel;

import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.setting.DefaultSetting;

public class PropertyTableModel extends AbstractTableModel
{
    private static final long serialVersionUID = 7410864630660757345L;

    private PropertyObject  object;
    private List<Integer>   values;

    @Override
    public int getColumnCount() {
        return 2;
    }

    @Override
    public int getRowCount() {
        if (object==null) return 0;
        return values.size();
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) 
    {
        int val = values.get(rowIndex);
        
        if (columnIndex==0) {
            return Prop.getPropString(val);
        } else {
            return object.getProperty(val).toString();
        }
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        return columnIndex==1;
    }
    
    private JComponent component;
    private Border     oborder;
    
    public void set(PropertyObject po)
    {
        if (component!=null) {
            component.setBorder(oborder);
            component=null;
        }
        
        object=po;
        if (object!=null) {
            values=po.getSetProperties();
            
            if ((po instanceof AbstractControl)) {
                Component c = ((AbstractControl)po).getComponent();
                if (c instanceof JComponent) {
                   component = (JComponent)c;
                   oborder=component.getBorder();
                   component.setBorder(new CompoundBorder(
                           new LineBorder(Color.GREEN,3)
                           ,oborder
                           ));
                }
            }
            
        } else {
            values=null;
        }
        fireTableDataChanged();
    }

    @Override
    public String getColumnName(int column) {
        if (column==0) return "Property";
        return "Value";
    }

    @Override
    public void setValueAt(Object value, int rowIndex, int columnIndex) 
    {
        int val = values.get(rowIndex);
        object.setProperty(val,value);
        WinSetting.getInstance().set(object.getId(),val,value.toString());
        WinSetting.getInstance().save();
        DefaultSetting.reload(); 
    }
}
