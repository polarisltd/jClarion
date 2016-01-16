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
import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.FontMetrics;

import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.SwingConstants;

import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Prop; 
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.SwingTask;


public class StringControl extends AbstractControl 
{

    public StringControl setPageNo()
    {
        setProperty(Prop.PAGENO,true);
        return this;
    }

    public StringControl setSum()
    {
        setProperty(Prop.SUM,true);
        return this;
    }

    public StringControl setCount()
    {
        setProperty(Prop.CNT,true);
        return this;
    }

    public StringControl setAverage()
    {
        setProperty(Prop.AVE,true);
        return this;
    }

    public StringControl setMin()
    {
        setProperty(Prop.MIN,true);
        return this;
    }

    public StringControl setMax()
    {
        setProperty(Prop.MAX,true);
        return this;
    }

    private AbstractReportControl reset; 
    private AbstractReportControl tally; 
    
    public AbstractReportControl getReset()
    {
        return reset;
    }

    public AbstractReportControl getTally()
    {
        return tally;
    }
    
    public StringControl setReset(AbstractReportControl br)
    {
        this.reset=br;
        return this;
    }

    public StringControl setTally(AbstractReportControl br)
    {
        this.tally=br;
        return this;
    }
    
    @Override
    public boolean isAcceptAllControl() {
        return false;
    }

    @Override
    public boolean validateInput() {
        return true;
    }
    
    private void resize()
    {
        JLabel _label=label;
        if (_label==null) return;
        
        Dimension s = _label.getSize();
        Dimension ps = _label.getPreferredSize();

        //if (ps.height>500) return;
        
        if (ps.width > s.width || ps.height > s.height) {
            
            if (ps.width > s.width)
                s.width = ps.width;
            if (ps.height > s.height)
                s.height = ps.height;
            _label.setSize(s);
        }
    }

    private class Refresh implements Runnable
    {
        @Override
        public void run() 
        {
            JLabel _label=label;
            if (_label==null) return;
            _label.setText(getPicture().format(
                    getUseObject().toString()).trim());
            resize();
        }
    }

    private class ChangeListener implements ClarionMemoryChangeListener
    {
        @Override
        public void objectChanged(ClarionMemoryModel model) {
            getWindowOwner().addAcceptTask(getUseID(),refresh);
        }
    }
    
    
    private JLabel              label;
    private Runnable            refresh;
    private ChangeListener      listener;
    private JComponent          base;
    
    public JLabel getLabel()
    {
        return label;
    }
    
    @Override
    public void clearMetaData() 
    {
        label=null;
        refresh=null;
        listener=null;
        base=null;
        super.clearMetaData();
    }
    
    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"label",label);
        debugMetaData(sb,"refresh",refresh);
        debugMetaData(sb,"listener",listener);
        debugMetaData(sb,"base",base);
   }
    
    
    @Override
    public void constructSwingComponent(Container parent) 
    {
        label = new JLabel();
        
        if (isProperty(Prop.CENTER))
            label.setHorizontalAlignment(SwingConstants.CENTER);
        if (isProperty(Prop.RIGHT))
            label.setHorizontalAlignment(SwingConstants.RIGHT);
        if (isProperty(Prop.DECIMAL))
            label.setHorizontalAlignment(SwingConstants.RIGHT);

        ClarionObject object = getUseObject();
        
        refresh=new SwingTask(new Refresh());
        listener=new ChangeListener(); 

        if (object == null) {
            label.setText(getProperty(Prop.TEXT).toString().trim());
        } else {
            object.addChangeListener(listener);
            label.setText(getPicture().format(getUseObject().toString()).trim());
        }

        base = label;

        Color bg = getColor(Prop.FILLCOLOR);
        if (bg != null) {
            JPanel panel = new JPanel(new BorderLayout(0, 0));
            panel.add(label, BorderLayout.CENTER);
            panel.setBackground(bg);
            panel.setOpaque(true);
            base = panel;
        }

        parent.add(base);

        configureFont(label);
        configureColor(label);
        setPositionAndState();
    }

    @Override
    public ClarionObject getAWTProperty(int index) 
    {
        if (index== Prop.SCREENTEXT) { 
            JLabel l = label;
            if (l!=null) return new ClarionString(label.getText());
        }
        return super.getAWTProperty(index);
    }
    
    @Override
    public boolean isAWTProperty(int index) {
        return super.isAWTProperty(index) || index==Prop.SCREENTEXT;
    }
    
    @Override
    protected void notifyLocalChange(final int indx,final ClarionObject value) {

        final JLabel lab = label;
        if (lab==null) {
            super.notifyLocalChange(indx, value);
            return;
        }
        
        if (indx == Prop.USE && listener!=null) {
            ClarionObject co = getUseObject();
            if (co != null) {
                co.removeChangeListener(listener);
            }
            value.addChangeListener(listener);

            super.notifyLocalChange(indx, value);
            
            CWinImpl.run(new Runnable() {
                public void run()
                {
                    lab.setText(getPicture().format(value.toString()).trim());
                    resize();
                }
            });
            
            return;
        }

        super.notifyLocalChange(indx, value);

        if (indx == Prop.TEXT && lab!=null) {
            CWinImpl.run(new Runnable() {
                public void run() {
                    if (getUseObject() == null) {
                        lab.setText(value.toString().trim());
                    } else {
                        lab.setText(getPicture().format(
                                getUseObject().toString()).trim());
                    }
                    resize();
                }
            });
        }
        
        switch (indx) {
            case Prop.WIDTH: 
            case Prop.HEIGHT: 
            case Prop.FONTNAME: 
            case Prop.FONTSIZE: 
                CWinImpl.run(new Runnable() {
                    public void run() {
                        resize();
                    }
                });
        }
    }

    
    
    @Override
    public int getCreateType() {
        return Create.STRING;
    }

    @Override
    public Component getComponent() {
        return base;
    }

    @Override
    public Dimension getPreferredSize() 
    {
        Dimension r = getComponent().getPreferredSize();
        
        if (getUseObject()!=null) {
            // try another size
            if (getPicture()!=null) {
                String rep = getPicture().getPictureRepresentation();
                FontMetrics fm = getComponent().getGraphics().getFontMetrics(getComponent().getFont());
                r.width = fm.stringWidth(rep);
            }
        }
        
        return r; 
    }

    @Override
    protected void doToggleMode(boolean value, int mode) {
        super.doToggleMode(value, mode);
        if (value==true && mode==Prop.HIDE) {
            resize();
        }
    }


    
}
