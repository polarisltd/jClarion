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
import java.awt.Dimension;
import java.awt.Image;
import java.util.logging.Logger;

import javax.swing.ImageIcon;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JScrollPane;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.constants.Create;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;


public class ImageControl extends AbstractControl {

    private static Logger log = Logger.getLogger(ImageControl.class.toString());
    
    public ImageControl setText(ClarionString text)
    {
        setProperty(Prop.TEXT,text);
        return this;
    }
    
    public ImageControl setHVScroll()
    {
        setProperty(Prop.HSCROLL,true);
        setProperty(Prop.VSCROLL,true);
        return this;
    }
    
    public ImageControl setCentered()
    {
        setProperty(Prop.CENTERED,true);
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

    @Override
    public int getCreateType() {
        return Create.IMAGE;
    }

    private JComponent  base;
    private JLabel      label;
    
    @Override
    public void clearMetaData() 
    {
        base=null;
        label=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        super.debugMetaData(sb);
        debugMetaData(sb,"label",label);
        debugMetaData(sb,"base",base);
    }
    
    @Override
    public void constructSwingComponent(Container parent) 
    {
        label = new JLabel();
        
        if (isProperty(Prop.HSCROLL) || isProperty(Prop.VSCROLL)) {
            JScrollPane jsp = new JScrollPane(label);
            base = jsp;
            if (isProperty(Prop.HSCROLL)) {
                jsp.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
            }
            if (isProperty(Prop.VSCROLL)) {
                jsp.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
            }
        } else {
            base=label;
        }
        
        setIcon();
        label.setOpaque(false);
        parent.add(base);
        configureFont(label);
        setPositionAndState();
        setIcon();
    }

    private void setIcon() {
        JLabel lab=label;
        if (lab!=null) {
            
            Image i=null;
            String text = getProperty(Prop.TEXT).toString();
            if (text.length()>0) {
                i  = CWin.getInstance().getImage(text,0,0);
            } else {
                ClarionObject payload = getRawProperty(Prop.IMAGEBITS);
                if (payload!=null) {
                    i = CWin.getInstance().getImageFromBinaryData(payload);
                }
            }
            if (i!=null) {
                if (isProperty(Prop.CENTERED)) {
                    // as is 
                } else {
                    Dimension d = lab.getSize();
                    if (d.width>0 && d.height>0) {
                        i =CWin.getInstance().scale(i,d.width,d.height);
                    }
                }
                lab.setIcon(new ImageIcon(i));
            } else {
                lab.setIcon(null);
            }
        }
    }

    @Override
    protected void notifyLocalChange(int indx, final ClarionObject value) {
        
        if (indx==Prop.TEXT) {
            log.fine("New image:["+value.toString()+"]");
            CWinImpl.run(new Runnable() { 
                public void run()
                {
                    setIcon();
                }
            });
            
        }
        super.notifyLocalChange(indx, value);
    }

    @Override
    public Component getComponent() {
        return base;
    }
    

    
    
}
