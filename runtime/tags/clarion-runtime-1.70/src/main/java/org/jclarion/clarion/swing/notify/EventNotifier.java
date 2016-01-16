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
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.StringTokenizer;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.border.LineBorder;

import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.ClarionDesktopPane;
import org.jclarion.clarion.swing.gui.AbstractWidget;
import org.jclarion.clarion.swing.gui.GUIModel;
import org.jclarion.clarion.swing.gui.RemoteTypes;
public class EventNotifier extends AbstractWidget implements ActionListener
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
            this.id=0;
        }
        
        private String  message;
        private Color   forground;
        private Color   background;
        private int     wait;
        private boolean keep;
        private int		id;
    }
    
    private LinkedList<Event> events = new LinkedList<Event>();
    private Map<Integer,Event> eventsByID = new HashMap<Integer,Event>();
    private JPanel 		component;
    private JComponent 	textBlock;
    private boolean 	shutdown;
    private Timer		timer;
    
    private EventNotifier()
    {
        CRun.addShutdownHook(new Runnable() {
            @Override
            public void run() {
                shutdown();
            } } );
        
        CWinImpl.run(this,INIT);
    }

    private void init()
    {
        component=new JPanel();
        component.putClientProperty("shadow","1");
        component.setSize(0,0);
        component.setLocation(0,0);
        component.setLayout(new BorderLayout(5,5));
        component.setBorder(new LineBorder(Color.black,2));

        JButton button = new JButton();
        button.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) 
            {
            	next.keep=false;
            	sequence=-20;
            	if (timer!=null) {
            		timer.setInitialDelay(1);
            		timer.restart();
            	}
            } } );
        button.setText("close");
        button.setFont(new Font("Serif",0,8));
        JComponent head = new JPanel(new BorderLayout());
        head.setBorder(new EmptyBorder(2,50,2,5));
        head.setBackground(null);
        JLabel title = new JLabel();
        title.setBorder(new EmptyBorder(2,15,2,15));
        title.setText("Notification");
        title.setFont(new Font("Serif",0,8));
        title.setHorizontalAlignment(SwingConstants.CENTER);
        head.add(button,BorderLayout.EAST);
        component.add(head,BorderLayout.NORTH);
        
        
        textBlock=javax.swing.Box.createVerticalBox();
        textBlock.setBorder(new EmptyBorder(10,10,10,10));
        component.add(textBlock,BorderLayout.CENTER);
        //initThread();
    }

    private void initThread()
    {
    	if (component.getParent()==null) {
    		ClarionApplication app = CWin.getInstance().getGuiApp();
    		if (app!=null) {
    			((ClarionDesktopPane)app.getDesktopPane()).add(component,new Integer(1000));
    		} else { 
    			return;
    		}
    	}
    	if (timer==null) {
    		synchronized(events) {
    			if (shutdown || events.isEmpty()) return;
   				if (timer==null) {
   					timer=new Timer(1,this);
   					timer.setRepeats(false);
   					timer.start();
   				}
    		}
    	}
    }
    
    public Component getComponent()
    {
        return component;
    }

    public void cancel(NotifyStatus status)
    {
    	CWinImpl.run(this,REMOVE,status.getID());    	
    	synchronized(this.status) {
    		this.status.remove(status.getID());
    	}
    }
    
    public boolean query(NotifyStatus status)
    {
    	synchronized(this.status) {
    		return this.status.containsKey(status.getID());
    	}
    }

    private Map<Integer,NotifyStatus> status=new HashMap<Integer,NotifyStatus>();
    private int _lastEventID=0;    
    
    public NotifyStatus message(String message,Color foreground,Color background,int wait,boolean keep) 
    {
    	NotifyStatus ns;
    	synchronized(status) {
    		ns = new NotifyStatus(++_lastEventID);
    		status.put(ns.getID(),ns);
    	}
    	CWinImpl.run(this,POST,ns.getID(),message,foreground,background,wait,keep);
    	return ns;
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
    
    private Event next=null;
    private int sequence=0;

	@Override
	public void actionPerformed(ActionEvent e) {
		
		while(true) {
			if (next==null) {
				synchronized(events) {
					if (shutdown || events.isEmpty()) {
						if (timer!=null) {
							timer.stop();
							timer=null;
						}
						return;
					}
					next=events.removeFirst();
					if (next.id==0) continue;
					sequence=0;
				}

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
			}

			if (sequence>=0 && sequence<20) {
				sequence++;
				setPosition(sequence*5);
				timer.setInitialDelay(10);
				timer.restart();
				return;
			}
			
			if (sequence>=20) {
				timer.setInitialDelay(next.wait);
				timer.restart();
				sequence=-20;
				return;
			}
        
			sequence++;
            setPosition(sequence*-5);
            if (sequence<0) {
            	timer.setInitialDelay(10);
				timer.restart();
            	return;
            }
            
            component.setVisible(false);
            if (next.keep) {
                synchronized(events) {
                    events.add(next);
                }            	
            } else {
                GUIModel.getServer().send(this,SERVER_NOTIFY,next.id);
                synchronized(events) {
                    eventsByID.remove(next.id);
                    next.id=0;
                }            	            	
            }
           	next=null;
            continue;
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
            events.clear();
            eventsByID.clear();
            if (timer!=null) {
            	timer.stop();
            	timer=null;
            }
        }
        instance=null;
    }

    private static final int INIT=1;
    private static final int POST=2;
    private static final int REMOVE=3;
    private static final int QUERY=4;
    private static final int SERVER_NOTIFY=5;
    
	@Override
	public Object command(int command, Object... params) {
		switch(command) {
			case SERVER_NOTIFY: {
				synchronized(status) {
					status.remove((Integer)params[0]);
				}
				return null;
			}
			case INIT:
				init();
				return null;
			case POST: {
	            Event e = new Event((String)params[1],(Color)params[2],(Color)params[3],(Integer)params[4],(Boolean)params[5]);
	            e.id=(Integer)params[0];
	            synchronized(events) {
	                events.add(e);
	                eventsByID.put(e.id,e);
	            }
	            initThread();
				return e.id;
			}
			case QUERY: {
				int id = (Integer)params[0];
	            synchronized(events) {
	            	return eventsByID.containsKey(id);
	            }
			}
			case REMOVE: {
				int id = (Integer)params[0];
	            synchronized(events) {
	            	Event e = eventsByID.get(id);
	            	if (e!=null) {
	            		e.id=0;
	            		e.keep=false;
	            		if (e==next) {
	            			sequence=-20;
	            			timer.setInitialDelay(1);
	            			timer.restart();
	            		}
	            	}
	            }
	            return null;
			}
		}
		return null;
	}

	@Override
	public int getWidgetType() {
		return RemoteTypes.NOTIFIER;
	}

            
}
