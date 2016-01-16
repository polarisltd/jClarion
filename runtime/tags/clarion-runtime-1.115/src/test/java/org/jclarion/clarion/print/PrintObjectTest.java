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
package org.jclarion.clarion.print;

import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;

import javax.swing.ImageIcon;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.border.LineBorder;

import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.control.ImageControl;

import junit.framework.TestCase;

public class PrintObjectTest extends TestCase {

    public void testElements() throws InterruptedException
    {
        BufferedImage bi = new BufferedImage(320,320,BufferedImage.TYPE_4BYTE_ABGR);
        
        PrintObject po = new PrintObject();
        po.setAt(20,20,300,300);
        
        Font f = new Font("Serif",Font.BOLD,14);
        
        po.drawText(null,"","Hello World",0,0,0,0,Text.Justify.LEFT,0,Color.black,f,true);
        po.drawBox(null,5,20,200,40,3,Color.black,Color.white,false);
        po.drawLine(null,5,50,150,50,1,Color.black);
        po.drawLine(null,5,55,150,55,4,Color.black);
        
        po.drawText(null,"","$123.55",5,60,150,60,Text.Justify.DECIMAL,18,Color.black,f,false);
        po.drawText(null,"","$14,123.19",5,80,150,80,Text.Justify.DECIMAL,18,Color.black,f,false);
        
        po.drawBox(null,5,100,200,120,1,Color.black,Color.green,true);

        po.drawText(null,"","* * * CENTER * * *",0,120,300,120,Text.Justify.CENTER,0,Color.black,f,true);
        po.drawText(null,"","RIGHT",0,140,300,140,Text.Justify.RIGHT,0,Color.black,f,true);

        ImageControl ic = new ImageControl();
        ic.setText(Icon.ASTERISK);
        po.drawImage(ic,20,60,40,80);
        
        Graphics2D g2 = (Graphics2D)bi.getGraphics();
        AWTPrintContext g2d = new AWTPrintContext(g2);

        Page p = new Page(new OpenReport(null));
        p.setScale(1f,1f);
        
        po.getSize(p,g2d);
        po.paint(p,g2d);
        
        final JDialog jd = new JDialog();
        jd.setModal(true);
        jd.setSize(400,400);
        JLabel jl = new JLabel(new ImageIcon(bi));
        jl.setBorder(new LineBorder(Color.blue,2));
        jd.getContentPane().add(jl);
        jd.getContentPane().setLayout(new FlowLayout());
        
        Thread t = new Thread() { 
            public void run() {
                jd.setVisible(true);
            }
        };
        t.start();
        Thread.sleep(3000);
        jd.dispose();
        t.join();
        
    }
    
}
