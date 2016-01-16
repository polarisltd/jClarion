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

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JDesktopPane;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JViewport;
import javax.swing.Timer;
import javax.swing.event.InternalFrameEvent;
import javax.swing.event.InternalFrameListener;

import org.jclarion.clarion.runtime.CWin;

public class SystemMonitor extends JInternalFrame 
{
    private static final long serialVersionUID = 3000475873155749764L;
    private JLabel label;
    private Timer  timer;
    
    public SystemMonitor()
    {
        setClosable(true);
        setTitle("System Monitor");
        setResizable(true);
        addMemoryMonitor();
        putClientProperty("shadow",1);

        final JDesktopPane pane = CWin.getInstance().getGuiApp().getDesktopPane();
        final JInternalFrame current = pane.getSelectedFrame();

        addInternalFrameListener(new InternalFrameListener(){

            @Override
            public void internalFrameActivated(InternalFrameEvent e) {
            }

            @Override
            public void internalFrameClosed(InternalFrameEvent e) {
            }

            @Override
            public void internalFrameClosing(InternalFrameEvent e) {
                close();
            }

            @Override
            public void internalFrameDeactivated(InternalFrameEvent e) {
            }

            @Override
            public void internalFrameDeiconified(InternalFrameEvent e) {
            }

            @Override
            public void internalFrameIconified(InternalFrameEvent e) {
            }

            @Override
            public void internalFrameOpened(InternalFrameEvent e) {
                if (current!=null) {
                    pane.setSelectedFrame(current);
                }
            } } );

        setSize(250,60);
        
        JScrollPane  scroll = (JScrollPane)pane.getParent().getParent();
        JViewport port = scroll.getViewport();
        Rectangle bounds = port.getViewRect();

        setLocation(bounds.x,bounds.y+bounds.height-60);

        pane.add(this,JDesktopPane.PALETTE_LAYER);
        setVisible(true);
        
    }
    
    private void close()
    {
        setVisible(false);
        dispose();
        if (getParent()!=null) {
            getParent().remove(this);
        }
        if (timer!=null) {
            timer.stop();
            timer=null;
        }
    }
    

    private void addMemoryMonitor()
    {
        JPanel base = new JPanel(new BorderLayout(5,5));
        setContentPane(base);
        
        JPanel textbox = new JPanel(new FlowLayout(FlowLayout.LEFT,5,5));
        base.add(textbox,BorderLayout.CENTER);
        
        JLabel mem = new JLabel();
        mem.setText("Mem:");
        mem.setFont(mem.getFont().deriveFont(Font.BOLD));
        
        textbox.add(mem);
        label=new JLabel();
        textbox.add(label);
        
        timer = new Timer(2500,new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Runtime r = Runtime.getRuntime();
                label.setText(
                        toMem(r.totalMemory() - r.freeMemory() )+" / "
                        +toMem(r.maxMemory()) ); 
            } } );
        timer.setInitialDelay(0);
        timer.start();
        
        JButton collection = new JButton("Compact");
        collection.setFont(collection.getFont().deriveFont(8.0f));
        collection.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.gc();
            } } );
        //base.add(collection,BorderLayout.EAST);
        textbox.add(collection);
    }


    private String toMem(long val)
    {
        char suffix='B';
        
        if (val>1024*1024*1024*.9) {
            val=val/1024*1024/102;
            suffix='G';
        } else if (val>1024*1024*0.9) {
            val=val/1024/102;
            suffix='M';
        } else {
            val=val/102;
            suffix='K';
        }
        
        return String.valueOf(val/10)+"."+String.valueOf(val%10)+suffix;
    }
}
