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

import java.awt.AWTKeyStroke;
import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Container;
import java.awt.KeyboardFocusManager;
import java.awt.Rectangle;
import java.awt.event.AdjustmentEvent;
import java.awt.event.AdjustmentListener;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseWheelEvent;
import java.awt.event.MouseWheelListener;
import java.util.HashSet;
import java.util.Set;

import javax.swing.InputMap;
import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.JScrollBar;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JViewport;
import javax.swing.KeyStroke;
import javax.swing.ListSelectionModel;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.event.TableColumnModelEvent;
import javax.swing.event.TableColumnModelListener;
import javax.swing.table.TableColumn;

import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.ClarionQueueTableCell;
import org.jclarion.clarion.swing.QueueTableModel;
import org.jclarion.clarion.swing.SwingKeyCodes;

public class ListControl extends AbstractListControl {

    public ListControl setFormat(String format)
    {
        setProperty(Prop.FORMAT,format);
        return this;
    }

    public ListControl setVScroll()
    {
        setProperty(Prop.VSCROLL,true);
        return this;
    }

    public ListControl setFull()
    {
        setProperty(Prop.FULL,true);
        return this;
    }

    public ListControl setColumn()
    {
        setProperty(Prop.COLUMN,true);
        return this;
    }

    public ListControl setHVScroll()
    {
        setProperty(Prop.HSCROLL,true);
        setProperty(Prop.VSCROLL,true);
        return this;
    }

    public ListControl setDrop(int size)
    {
        setProperty(Prop.DROP,size);
        return this;
    }

    public ListControl setNoBar()
    {
        setProperty(Prop.NOBAR,true);
        return this;
    }
    
    
    public ListControl setFrom(ClarionQueue from)
    {
        this.from=from;
        return this;
    }

    public ListControl setFrom(String from)
    {
        return this;
    }
    
    
    //private ListColumn columns[];
    
    public ListColumn[] getColumns()
    {
        return qtm.getColumns();
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
        return Create.LIST;
    }

    private class CustomJTable extends JTable
    {
        private static final long serialVersionUID = -2729625020487899815L;

        public CustomJTable(QueueTableModel qtm) 
        {
            super(qtm);
        }

        
        public void doLayout() 
        {
            int scan = this.getColumnCount() - 1;

            ListColumn columns[] = getColumns();

            if (scan + 1 != columns.length) return;

            TableColumn tc = getTableHeader().getResizingColumn();

            int tcw = 0;
            for (int iscan = 0; iscan < columns.length; iscan++) {
                TableColumn test = getColumnModel().getColumn(iscan);

                if (tc == test) {
                    columns[iscan].setSwingWidth(test.getWidth());
                }

                if (columns[iscan].getSwingWidth() == 0) {
                    columns[iscan].syncSetSwingWidth(test.getWidth());
                }

                tcw += columns[iscan].getSwingWidth();
            }

            JViewport vp = (JViewport) getParent();
            int width = vp.getWidth();
            
            while (scan >= 0) {

                if (hscroll) {
                    if (tcw >= width)
                        break;
                } else {
                    if (tcw == width)
                        break;
                }

                TableColumn last = getColumnModel().getColumn(scan);
                int ow = columns[scan].getSwingWidth();
                int nw = ow + width - tcw;
                last.setWidth(nw);
                last.setPreferredWidth(nw);
                nw = last.getWidth();

                tcw += nw - ow;
                scan--;
            }

            while (scan >= 0) {
                TableColumn last = getColumnModel().getColumn(scan);
                if (last.getWidth() != columns[scan].getSwingWidth()) {
                    last.setWidth(columns[scan].getSwingWidth());
                    last.setPreferredWidth(columns[scan].getSwingWidth());
                }
                scan--;
            }

            if (getLayout() != null) {
                getLayout().layoutContainer(this);
            }
        }

        @Override
        public boolean getScrollableTracksViewportWidth() {
            if (hscroll) {
                return false;
            } else {
                return true;
            }
        }
        
    }
    
    private JComponent      base;
    private boolean         hscroll;
    private JTable          table;
    private int             columnSelect=-1;
    private JScrollBar      js;
    private int             priorValue=-1;
    private boolean         forcedUpdate;
    private JScrollPane     scroll;
    private boolean         tableFocus=false;
    private boolean         scrollDragging;
    private QueueTableModel qtm;
    
    @Override
    public void clearMetaData() 
    {
        this.base=null;
        this.hscroll=false;
        this.table=null;
        this.columnSelect=-1;
        this.js=null;
        this.priorValue=-1;
        this.forcedUpdate=false;
        this.scroll=null;
        this.tableFocus=false;
        this.scrollDragging=false;
        this.qtm=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugBaseMetaData(sb);
        debugMetaData(sb,"base",base);
        debugMetaData(sb,"hscroll",hscroll);
        debugMetaData(sb,"table",table);
        debugMetaData(sb,"columnSelect",columnSelect);
        debugMetaData(sb,"js",js);
        debugMetaData(sb,"priorValue",priorValue);
        debugMetaData(sb,"forcedUpdate",forcedUpdate);
        debugMetaData(sb,"scroll",scroll);
        debugMetaData(sb,"tableFocus",tableFocus);
        debugMetaData(sb,"scrollDragging",scrollDragging);
        debugMetaData(sb,"qtm",qtm);
    }
    
    @Override
    public void constructSwingComponent(Container parent) 
    {
        if (isProperty(Prop.DROP)) {
            createComboControl(parent,false);
            return;
        }

        base = new JPanel(new BorderLayout(0, 0));

        qtm = new QueueTableModel(this);

        hscroll = isProperty(Prop.HSCROLL);

        table = new CustomJTable(qtm);
        //table = new JTable(qtm);

        table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
        table.setCellSelectionEnabled(isProperty(Prop.COLUMN));
        table.setFillsViewportHeight(true);
        table.setRowSelectionAllowed(true);
        table.setShowHorizontalLines(false);
        table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        table.setBorder(null);

        table.addMouseListener(new MouseListener() {

            @Override
            public void mouseClicked(MouseEvent e) {

                int row = table.rowAtPoint(e.getPoint());
                int column = table.columnAtPoint(e.getPoint());
                if (row == -1 || column == -1) return;

                Rectangle cellRect = table.getCellRect(row, column, true);

                ((ClarionQueueTableCell) table.getValueAt(row, column))
                        .handleMouseEvent(e,e.getX() - cellRect.x, e.getY()
                                - cellRect.y, cellRect.width, cellRect.height);
            }

            @Override
            public void mouseEntered(MouseEvent e) {
            }

            @Override
            public void mouseExited(MouseEvent e) {
            }

            @Override
            public void mousePressed(MouseEvent e) {
            }

            @Override
            public void mouseReleased(MouseEvent e) {
            }
        });

        table.getSelectionModel().addListSelectionListener(
                new ListSelectionListener() {
                    public void valueChanged(ListSelectionEvent e) {
                        if (e.getValueIsAdjusting()) return;
                        int selection = table.getSelectedRow();
                        if (selection==-1) return;

                        int this_cs = table.getSelectedColumn();
                        if (this_cs != -1) {
                            columnSelect=this_cs;
                        } else {
                            if (columnSelect>-1) {
                                table.setColumnSelectionInterval(columnSelect,columnSelect);
                            }
                        }

                        post(Event.ACCEPTED);
                        post(Event.NEWSELECTION);

                    }
                });

        if (isProperty(Prop.COLUMN)) {
            columnSelect=0;

            table.getColumnModel().addColumnModelListener(
                    new TableColumnModelListener() {

                        @Override
                        public void columnAdded(TableColumnModelEvent e) {
                        }

                        @Override
                        public void columnMarginChanged(ChangeEvent e) {
                        }

                        @Override
                        public void columnMoved(TableColumnModelEvent e) {
                        }

                        @Override
                        public void columnRemoved(TableColumnModelEvent e) {
                        }

                        @Override
                        public void columnSelectionChanged(ListSelectionEvent e) {
                            if (e.getValueIsAdjusting())
                                return;

                            int last_cs = columnSelect;
                            int this_cs = table.getSelectedColumn();
                            if (last_cs == this_cs) return;
                            if (this_cs == -1) return;
                            post(Event.ACCEPTED);
                            post(Event.NEWSELECTION);
                            columnSelect=this_cs;
                        }
                    });
        }

        qtm.init(table);
        
        Set<AWTKeyStroke> forward = new HashSet<AWTKeyStroke>();
        forward.add(AWTKeyStroke.getAWTKeyStroke(KeyEvent.VK_TAB, 0));
        table.setFocusTraversalKeys(
                KeyboardFocusManager.FORWARD_TRAVERSAL_KEYS, forward);

        Set<AWTKeyStroke> backward = new HashSet<AWTKeyStroke>();
        backward.add(AWTKeyStroke.getAWTKeyStroke(KeyEvent.VK_TAB,
                KeyEvent.SHIFT_DOWN_MASK));
        table.setFocusTraversalKeys(
                KeyboardFocusManager.BACKWARD_TRAVERSAL_KEYS, backward);

        table.setFocusTraversalKeys(
                KeyboardFocusManager.DOWN_CYCLE_TRAVERSAL_KEYS,
                new HashSet<AWTKeyStroke>());
        table.setFocusTraversalKeys(
                KeyboardFocusManager.UP_CYCLE_TRAVERSAL_KEYS,
                new HashSet<AWTKeyStroke>());

        scroll = new JScrollPane(table);
        
        if (isProperty(Prop.IMM)) {
            scroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_NEVER);
            scroll.setHorizontalScrollBarPolicy(
                    isProperty(Prop.HSCROLL) ? JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS
                    : JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
        } else {
            scroll.setHorizontalScrollBarPolicy(
                    isProperty(Prop.HSCROLL) ? JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS
                    : JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);

            scroll.setVerticalScrollBarPolicy(
                    isProperty(Prop.VSCROLL) ? JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED
                    : JScrollPane.VERTICAL_SCROLLBAR_NEVER);
        }

        base.add(scroll, BorderLayout.CENTER);

        if (isProperty(Prop.IMM)) {
            js = new JScrollBar(JScrollBar.VERTICAL);
            js.setMinimum(0);
            js.setMaximum(10013);
            js.setBlockIncrement(10);
            js.setValue(5001);

            table.addMouseWheelListener(new MouseWheelListener() {

                @Override
                public void mouseWheelMoved(MouseWheelEvent e) {
                    if (e.getUnitsToScroll()<0) {
                        post(Event.SCROLLUP);
                    } else {
                        post(Event.SCROLLDOWN);
                    }
                } });
            
            js.addMouseListener(new MouseListener() {

                @Override
                public void mouseClicked(MouseEvent e) {
                }

                @Override
                public void mouseEntered(MouseEvent e) {
                }

                @Override
                public void mouseExited(MouseEvent e) {
                }

                @Override
                public void mousePressed(MouseEvent e) {
                }

                @Override
                public void mouseReleased(MouseEvent e) {
                    /**
                     *  This only works under GTK/Linux
                     */
                    if (e.getClickCount() == 0) {
                        post(Event.SCROLLDRAG);
                        scrollDragging=false;
                    }

                    // fallback for Windows
                    if (e.getClickCount()==1 && scrollDragging) {
                        post(Event.SCROLLDRAG);
                    }
                    scrollDragging=false;
                }
            });

            js.addAdjustmentListener(new AdjustmentListener() {

                @Override
                public void adjustmentValueChanged(AdjustmentEvent e) {
                    int value = e.getValue();

                    if (priorValue==-1) priorValue=5001;
                    if (value == priorValue) return;

                    int event = 0;

                    if (!forcedUpdate && !scrollDragging) {
                        if (value == priorValue - 1) {
                            event = Event.SCROLLUP;
                        }
                        if (value == priorValue + 1) {
                            event = Event.SCROLLDOWN;
                        }
                        if (value == priorValue - 10) {
                            event = Event.PAGEUP;
                        }
                        if (value == priorValue + 10) {
                            event = Event.PAGEDOWN;
                        }
                        
                        if (event == 0) {
                            if (value==0) {
                                event=Event.SCROLLTOP;
                            }

                            if (value==10002) {
                                event=Event.SCROLLBOTTOM;
                            }
                        }
                        
                        if (event == 0) {
                            scrollDragging=true;
                            event = Event.SCROLLTRACK;
                        }
                    }
                    priorValue=value;
                    
                    if (value==0 && !scrollDragging) {
                        boolean oForcedUpdate=forcedUpdate;
                        try {
                            forcedUpdate=true;                            
                            js.setValue(1);
                        } finally {
                            forcedUpdate=oForcedUpdate;
                        }
                    }

                    if (value>10001 && !scrollDragging) {
                        boolean oForcedUpdate=forcedUpdate;
                        try {
                            forcedUpdate=true;                            
                            js.setValue(10001);
                        } finally {
                            forcedUpdate=oForcedUpdate;
                        }
                    }

                    if (event!=0) { 
                        post(event);
                    }
                }
            });

            base.add(js, BorderLayout.EAST);

            table.addKeyListener(new KeyListener() {

                @Override
                public void keyPressed(KeyEvent e) {

                    SwingKeyCodes skc = SwingKeyCodes.getInstance();
                    int key = skc.toClarionCode(e);
                    int state = skc.toClarionState(e);

                    AbstractWindowTarget ctl = getWindowOwner();
                    ctl.setKeyCode(key);
                    ctl.setKeyState(state);

                    switch (e.getKeyCode()) {
                    case KeyEvent.VK_ENTER:
                        break;
                    case KeyEvent.VK_DOWN:
                        post(Event.SCROLLDOWN);
                        e.consume();
                        return;
                    case KeyEvent.VK_UP:
                        post(Event.SCROLLUP);
                        e.consume();
                        return;
                    case KeyEvent.VK_PAGE_UP:
                        post(Event.PAGEUP);
                        e.consume();
                        return;
                    case KeyEvent.VK_PAGE_DOWN:
                        post(Event.PAGEDOWN);
                        e.consume();
                        return;
                    case KeyEvent.VK_HOME:
                        post(Event.SCROLLTOP);
                        e.consume();
                        return;
                    case KeyEvent.VK_END:
                        post(Event.SCROLLBOTTOM);
                        e.consume();
                        return;
                    }
                }

                @Override
                public void keyReleased(KeyEvent e) {
                }

                @Override
                public void keyTyped(KeyEvent e) {
                }
            });
        } else {
            js = null;
        }


        // force base to relayout
        base.addComponentListener(new ComponentAdapter() {
            @Override
            public void componentResized(ComponentEvent e) {
                e.getComponent().validate();
            }
        });

        configureFont(table);
        configureFont(table.getTableHeader());
        table.setRowHeight(table.getFontMetrics(table.getFont()).getHeight());
        table.setRowMargin(0);
        configureColor(table);
        setPositionAndState();

        setFocus(table);

        table.addFocusListener(new FocusListener() {
            @Override
            public void focusGained(FocusEvent e) {
            	
            	JTable tab=table;
            	if (tab==null) return;
            	
                tableFocus=true;
                if (tab.getSelectedRow() == -1) {
                    tab.getSelectionModel().setSelectionInterval(0, 0);
                    if (tab.getColumnSelectionAllowed()) {
                        tab.setColumnSelectionInterval(0, 0);
                    }
                }
                if (isProperty(Prop.NOBAR)) {
                    tab.repaint();
                }
            }

            @Override
            public void focusLost(FocusEvent e) {
            	JTable tab=table;
            	if (tab==null) return;
                if (tab!=null) {
                    tableFocus=false;
                    if (isProperty(Prop.NOBAR)) tab.repaint();
                }
            }
        });

        setKey(table);

        InputMap im = table.getInputMap(JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT);
        KeyStroke ks = KeyStroke.getKeyStroke(KeyEvent.VK_ENTER, 0);
        while (im != null) {
            im.remove(ks);
            im = im.getParent();
        }

        parent.add(base);
    }

    @Override
    public boolean isAWTProperty(int index) {
        switch(index) {
            case Prop.COLUMN:
            case Prop.SELSTART:
            case Prop.ITEMS:
            case Prop.VSCROLLPOS:
                return true;
            default:
                return super.isAWTProperty(index);
        }
    }
    

    @Override
    public ClarionObject getAWTProperty(int index) 
    {
        JTable table=this.table;
        
        if (table!=null) {
            switch(index) {
                case Prop.COLUMN:
                    if (columnSelect>-1) {
                        return new ClarionNumber(table.getSelectedColumn() + 1);
                    }
                    break;
                case Prop.SELSTART:
                    
                    return new ClarionNumber(
                        qtm.getQueue().convertScreenIndexToQueueIndex(
                        table.getSelectedRow()) + 1);
                case Prop.ITEMS: {
                    base.validate();
                    int height = table.getRowHeight();
                    int size = scroll.getViewport().getExtentSize().height;
                    int items = (size + (height - 1)) / height;
                    return new ClarionNumber(items);
                }
                case Prop.VSCROLLPOS: {
                    int value = 0;
                    if (js != null) {
                        value = (js.getValue()+js.getBlockIncrement()) * 100 / js.getMaximum();
                    } else {
                        JScrollBar jsb = scroll.getVerticalScrollBar();
                        if (jsb != null) {
                            return new ClarionNumber(jsb.getValue() * 100 / jsb.getMaximum());
                        }
                    }
                    return new ClarionNumber(value);
                }
            }
        }
        return super.getAWTProperty(index);
    }
    
    @Override
    protected void notifyLocalChange(int indx,final ClarionObject value) {
        
        switch(indx) {
            case Prop.FORMAT:  
                CWinImpl.run(new Runnable() {
                    public void run() {
                        QueueTableModel q = qtm;
                        if (q!=null) {
                            q.setColumns(ListColumn.construct(value.toString()));
                            q.applyModel();
                        }
                    }
                });
                break;
            case Prop.COLUMN:  
                if (columnSelect>-1) {
                    CWinImpl.run(new Runnable() {
                       public void run()
                       {
                           JTable tbl = table;
                           if (tbl!=null) {
                               int pos = value.intValue() - 1;
                               table.setColumnSelectionInterval(pos, pos);
                           }
                       }
                    });
                }
                break;
            case Prop.SELECTED: 
                CWinImpl.run(new Runnable() {
                    public void run()
                    {
                        JTable tbl = table;
                        if (tbl==null) return;
                        int v = value.intValue() - 1;
                        v = qtm.getQueue().convertQueueIndexToScreenIndex(v);
                        //Point op = scroll.getViewport().getViewPosition();
                        Rectangle r = tbl.getCellRect(v, 0, true);
                        tbl.getSelectionModel().setSelectionInterval(v, v);
                        tbl.scrollRectToVisible(r);
                        
                        /*
                        if (!op.equals(scroll.getViewport().getViewPosition())) {
                            tbl.repaint();
                        }
                        */
                    }
                });
                break;
            case Prop.VSCROLLPOS: 
                CWinImpl.run(new Runnable() {
                    public void run()
                    {
                        JScrollBar j = js;
                        if (j==null) return;
                        int ivalue = value.intValue() * 100+1;
                        forcedUpdate=true;
                        try {
                            js.setValue(ivalue);
                        } finally {
                            forcedUpdate=false;
                        }
                    }
                });
                break;
        }

        super.notifyLocalChange(indx,value);

        switch (indx) {
            case Prop.FONTNAME:
            case Prop.FONTSIZE:
            case Prop.FONTSTYLE:
                CWinImpl.run(new Runnable() {
                    public void run() {
                        JTable t = table;
                        if (t != null) {
                            t.setRowHeight(t.getFontMetrics(t.getFont())
                                .getHeight());
                        }
                    }
                });
            break;
        }
    }
    
    public JTable getTable()
    {
        return table;
    }
    
    @Override
    public void setKey(JComponent comp) {
        CWin.getInstance().setKey(
                getWindowOwner(),comp,this instanceof SimpleMnemonicAllowed,
                isProperty(Prop.IMM),this);
    }

    @Override
    public boolean isTableFocus() {
        return tableFocus;
    }

    @Override
    public Component getComponent() 
    {
        if (base!=null) return base;
        return getCombo();
    }

    @Override
    public Component[] getToggleComponents()
    {
        return new Component[] {
                this.base, this.scroll, this.table, this.js, getCombo() 
        };
    }
    
}
