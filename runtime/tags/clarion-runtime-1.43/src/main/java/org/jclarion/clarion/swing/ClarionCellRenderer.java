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
package org.jclarion.clarion.swing;

import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Rectangle;

import javax.swing.JComponent;
import javax.swing.JList;
import javax.swing.JTable;
import javax.swing.ListCellRenderer;
import javax.swing.table.TableCellRenderer;


import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractListControl;
import org.jclarion.clarion.control.ListColumn;
import org.jclarion.clarion.control.ListStyleProperty;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;


public class ClarionCellRenderer extends JComponent implements TableCellRenderer, ListCellRenderer 
{
    /**
     * 
     */
    private static final long serialVersionUID = 5098670870412564644L;
    private CWinImpl impl;
    private boolean nobar;
    private AbstractListControl control;
    
    private String text;
    private ListColumn listColumn;
    
    private int         treeDepth;
    private int         treeDepthPos;
    private String      icon;
    
    private AbstractWindowTarget target;

    public ClarionCellRenderer(AbstractListControl control)
    {
        impl=CWin.getInstance();
        this.control=control;
        this.nobar=control.isProperty(Prop.NOBAR);
        target=control.getWindowOwner();
        setBorder(null);
    }

    private ClarionQueueTableCell cell;
    private JComponent table;

    @Override
    public Component getListCellRendererComponent(JList list, Object value,
            int index, boolean isSelected, boolean cellHasFocus) 
    {
        return getCellRenderer(list,value,isSelected,cellHasFocus,index,0,
                list.getSelectionForeground(),
                list.getSelectionBackground());
    }
    
    @Override
    public Component getTableCellRendererComponent(JTable table, Object value,
            boolean isSelected, boolean hasFocus, int row, int column) 
    {
        return getCellRenderer(table,value,isSelected,hasFocus,row,column,
                table.getSelectionForeground(),
                table.getSelectionBackground());
    }
    
    public Component getCellRenderer(JComponent table, Object value,
            boolean isSelected, boolean hasFocus, int row, int column,
            Color selectedFG,Color selectedBG)
    {
        this.table=table;
        
        if (nobar && isSelected) {
            if (!control.isTableFocus()) isSelected=false;
        }
        
        Color fg = isSelected ? selectedFG : table.getForeground(); 
        Color bg = isSelected ? selectedBG : table.getBackground();
        Font f = table.getFont();
        
        cell = (ClarionQueueTableCell)value;
        String r_value="";
        treeDepth=0;
        icon=null;
        
        if (cell!=null) {
            r_value = cell.toString();
        
            int offset=0;

            if (cell.getColumn().isColor()) {
                Color tfg= impl.getColor(cell.getValue(offset+(isSelected? 3 : 1)));
                if (tfg!=null) fg=tfg;
                Color tbg= impl.getColor(cell.getValue(offset+(isSelected? 4 : 2)));
                if (tbg!=null) bg=tbg;
                offset+=4;
            }
            
            if (cell.getColumn().isIcon() || cell.getColumn().isTransparantIcon()) 
            {
                icon=control.getIcon(cell.getValue(++offset).intValue());
            }

            if (cell.getColumn().isTree()) {
                treeDepth = cell.getValue(++offset).intValue();
                treeDepthPos=offset;
            }
            
            int styleid=cell.getColumn().getDefaultStyle();

            if (cell.getColumn().isStyle()) {
                styleid = cell.getValue(++offset).intValue();
            }
            
            if (styleid>0) {
                ListStyleProperty lsp = control.getListStyle(styleid);
                
                f = impl.getFontOnly(table,lsp);
                
                Color s_fg = impl.getColor(lsp,isSelected ? Prop.SELECTEDCOLOR : Prop.FONTCOLOR);
                if (s_fg!=null) fg=s_fg;
                
                Color s_bg = impl.getColor(lsp,isSelected ? Prop.SELECTEDFILLCOLOR : Prop.BACKGROUND );
                if (s_bg!=null) bg=s_bg;
                
            }
            
            listColumn=cell.getColumn();
        }

        
        setForeground(fg);
        setBackground(bg);
        setFont(f);
        this.text=r_value;
                
        return this;
    }
    
    public void firePropertyChange(String propertyName, boolean oldValue, boolean newValue) { }

    public void repaint() { }
    
    public void repaint(Rectangle r) { }
    
    public void repaint(long tm, int x, int y, int width, int height) {}

    public void revalidate() {}

    public void validate() {}

    public void invalidate() {}

    public boolean isOpaque() {
        return true;
    }

    @Override
    protected void paintComponent(Graphics g) 
    {
        //((Graphics2D)g).setRenderingHint(RenderingHints.KEY_ANTIALIASING,RenderingHints.VALUE_ANTIALIAS_ON);
        //((Graphics2D)g).setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
        
        int w = getWidth();
        int h = getHeight();
        
        g.setColor(getBackground());
        g.fillRect(0,0,w,h);

        int textIndent=0;

        if (treeDepth!=0) {
            
            boolean[] bits = cell.getSiblingTree(treeDepthPos);
            
            int aTreeDepth=Math.abs(treeDepth);
            g.setColor(getForeground());
            for (int scan=0;scan<aTreeDepth;scan++) {
                if (bits[scan]) {
                    g.drawLine(scan*10+5,0,scan*10+5,h);
                }
            }
            
            if (!bits[aTreeDepth-1]) {
                g.drawLine(aTreeDepth*10-5,0,aTreeDepth*10-5,h/2);
            }
            
            if (cell.hasChildren(treeDepthPos)) {
                g.drawRect(aTreeDepth*10+2,h/2-4,8,8);
                g.drawLine(aTreeDepth*10+4,h/2,aTreeDepth*10+4+4,h/2);
                if (treeDepth<0) {
                    int xp=aTreeDepth*10+2+4;
                    g.drawLine(xp,h/2-2,xp,h/2+2);
                }
                
                if (treeDepth>0) {
                    g.drawLine(aTreeDepth*10+5,h/2+4,aTreeDepth*10+5,h);
                }
            }

            g.drawLine(aTreeDepth*10-5,h/2,aTreeDepth*10+2,h/2);
            
            textIndent=Math.abs(treeDepth)*10+10;
        }

        if (icon!=null) {
            
            java.awt.Image img = impl.getImage(icon,16,16);
            
            int width = img.getHeight(table);
            int height = img.getWidth(table);
            
            if (width!=-1 && height!=-1) {
                if (textIndent>0) textIndent+=4;
                g.drawImage(img,textIndent,(h-height)/2,getBackground(),table);
                textIndent+=4+width;
            } else {
                textIndent+=20;
            }
        }
        
        if (text!=null) {
            g.setColor(getForeground());
            g.setFont(getFont());
            FontMetrics fm = g.getFontMetrics();
            
            int xpos=0;
            
            w-=textIndent;
            
            if (listColumn!=null) {
            
                if (listColumn.isLeft()) {
                    xpos=target.widthDialogToPixels(listColumn.getIndent());
                }

                if (listColumn.isCenter()) {
                    xpos = (w-fm.stringWidth(text))/2+target.widthDialogToPixels(listColumn.getIndent());
                }

                if (listColumn.isRight()) {
                    xpos = w-fm.stringWidth(text)-target.widthDialogToPixels(listColumn.getIndent());
                }

                if (listColumn.isDecimal()) {
                    int lpos = text.lastIndexOf('.');
                    if (lpos==-1) {
                        xpos = w-fm.stringWidth(text)-target.widthDialogToPixels(listColumn.getIndent());
                    } else {
                        xpos = w-fm.stringWidth(text.substring(0,lpos+1))-target.widthDialogToPixels(listColumn.getIndent());
                    }
                }
            }
            
            sun.swing.SwingUtilities2.drawString(table,g,text,xpos+textIndent,(h-fm.getHeight())/2+fm.getAscent());
        }
    }

    @Override
    public Dimension getPreferredSize() {
        return new Dimension(100,16);
    }

}
