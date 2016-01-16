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
package org.jclarion.clarion.swing.notify;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Insets;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.LinkedList;
import java.util.StringTokenizer;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.border.LineBorder;

import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.swing.ClarionDesktopPane;
public class EventNotifier implements Runnable
{
    private static EventNotifier instance;
    
    public static EventNotifier getInstance()
    {
        if (instance==null) {
            synchronized(EventNotifier.class) {
                if (instance==null) {
                    instance=new EventNotifier();
                }
            }
        }
        return instance;
    }

    private static class Event
    {
        public Event(String message,Color forground,Color background,int wait,boolean keep)
        {
            this.message=message;
            this.forground=forground;
            this.background=background;
            this.wait=wait;
            this.keep=keep;
            status=new NotifyStatus();
        }
        
        private String  message;
        private Color   forground;
        private Color   background;
        private int     wait;
        private boolean keep;
        private NotifyStatus status;
    }
    
    private LinkedList<Event> events = new LinkedList<Event>();
    private JPanel component;
    private JComponent textBlock;
    private Thread notifyThread;
    private boolean shutdown;
    private boolean close=false;
    private Object closeMonitor=new Object();
    
    private EventNotifier()
    {
        CRun.addShutdownHook(new Runnable() {
            @Override
            public void run() {
                shutdown();
                instance=null;
            } } );
        
        component=new JPanel();
        component.putClientProperty("shadow","1");
        component.setSize(0,0);
        component.setLocation(0,0);
        component.setLayout(new BorderLayout(5,5));
        component.setBorder(new LineBorder(Color.black,2));

        JButton button = new JButton();
        button.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                notifyClose();
            } } );
        button.setText("close");
        button.setFont(new Font("Serif",0,8));
        //UIDefaults nimbus=new UIDefaults();;
        //nimbus.put("Button.contentMargins",new Insets(3,6,3,6));        
        //button.putClientProperty("Nimbus.Overrides",nimbus);
        JComponent head = new JPanel(new BorderLayout());
        head.setBorder(new EmptyBorder(2,50,2,5));
        head.setBackground(null);
        JLabel title = new JLabel();
        title.setBorder(new EmptyBorder(2,15,2,15));
        title.setText("Notification");
        title.setFont(new Font("Serif",0,8));
        title.setHorizontalAlignment(SwingConstants.CENTER);
        //head.add(title,BorderLayout.CENTER);
        head.add(button,BorderLayout.EAST);
        component.add(head,BorderLayout.NORTH);
        
        
        textBlock=javax.swing.Box.createVerticalBox();
        textBlock.setBorder(new EmptyBorder(10,10,10,10));
        //textBlock.set)
        //textBlock.setLayout(new BoxLayout(textBlock,BoxLayout.Y_AXIS));
        component.add(textBlock,BorderLayout.CENTER);
        
        ClarionApplication app = CWin.getInstance().getApp();
        if (app!=null) {
            ((ClarionDesktopPane)app.getDesktopPane()).add(component,new Integer(1000));
            notifyThread = new Thread(this,"clarion notify");
            notifyThread.setDaemon(true);
            notifyThread.start();
        } else {
            instance=null;
        }
    }
    
    public Component getComponent()
    {
        return component;
    }

    public NotifyStatus message(String message,Color foreground,Color background,int wait,boolean keep) 
    {
        Event e = new Event(message,foreground,background,wait,keep);
        synchronized(events) {
            events.add(e);
            events.notifyAll();
        }
        return e.status;
    }
    
    private int lineCount(String in)
    {
        StringTokenizer tok = new StringTokenizer(in,"\n");
        return tok.countTokens();
    }
    
    public NotifyStatus info(String message)
    {
        return message(message,Color.BLACK,Color.GREEN,1000,false);
    }
    
    public NotifyStatus warning(String message)
    {
        return message(message,Color.BLACK,Color.ORANGE,5000*lineCount(message),false);
    }

    public NotifyStatus notify(String message)
    {
        return message(message,Color.BLACK,new Color(180,180,255),5000*lineCount(message),false);
    }
    
    public NotifyStatus error(String message)
    {
        return message(message,Color.BLACK,Color.RED,5000*lineCount(message),true);
    }

    
    @Override
    public void run() {
        
        while ( true ) {
            Event next=null;
            synchronized(events) {
                if (shutdown) return;
                if (!events.isEmpty()) {
                    next=events.removeFirst();
                } else {
                    try {
                        events.wait();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    continue;
                }
            }
            
            if (next==null) continue;
            if (next.status.isProcessed()) continue;
            
            textBlock.removeAll();
            component.setBackground(next.background);
            
            int msgscan=0;
            while (msgscan<next.message.length()) {
                int end = next.message.indexOf('\n',msgscan);
                if (end<0) end=next.message.length();
                String msg = next.message.substring(msgscan,end);
                if (msg.length()==0) msg=" ";
                JLabel label = new JLabel(msg);
                label.setForeground(next.forground);                
                textBlock.add(label);
                msgscan=end+1;
            }
            
            component.setVisible(false);
            component.setSize(component.getPreferredSize());
            
            for (int scan=1;scan<=20;scan++) {
                setPosition(scan*5);
                sleep(10,false);
            }

            sleep(next.wait,true);

            for (int scan=19;scan>=0;scan--) {
                setPosition(scan*5);
                sleep(10,false);
            }
            component.setVisible(false);
            
            if (next.keep && !isClosed()) {
                synchronized(events) {
                    events.add(next);
                }
            } else {
                next.status.setProcessed();
            }
            resetClose();
        }
    }

    private boolean isClosed() {
        synchronized(closeMonitor) {
            return close;
        }
    }

    private void resetClose() {
        synchronized(closeMonitor) {
            close=false;
        }
    }

    private void sleep(int wait,boolean useClose)
    {
        if (!useClose) {
            try {
                Thread.sleep(wait);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            return;
        }
        
        long until = System.currentTimeMillis()+wait;

        synchronized(closeMonitor) {
            if (close) return;
            long waitUntil = until-System.currentTimeMillis();
            if (waitUntil<=0) return;
            try {
                closeMonitor.wait(waitUntil);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    
    private void notifyClose()
    {
        synchronized(closeMonitor) {
            close=true;
            closeMonitor.notifyAll();
        }
    }
    
    private void setPosition(int ratio)
    {
        Dimension preferredSize = component.getPreferredSize();
        JDesktopPane pane = (JDesktopPane)component.getParent();
        JScrollPane  scroll = (JScrollPane)pane.getParent().getParent();
        JViewport port = scroll.getViewport();
        Rectangle bounds = port.getViewRect();

        component.setLocation(
                bounds.x+bounds.width-preferredSize.width,
                bounds.y+bounds.height-preferredSize.height*ratio/100);
        if (!component.isVisible()) {
            component.setVisible(true);
            pane.moveToFront(component);
        }
        component.repaint();
    }

    public void shutdown() {
        
        synchronized(events) {
            shutdown=true;
            events.notifyAll();
        }
        
        try {
            notifyThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
            
}
