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

import java.awt.AWTEvent;
import java.awt.EventQueue;
import java.awt.event.KeyEvent;
import java.util.LinkedList;

import javax.swing.SwingUtilities;


//import org.jclarion.clarion.runtime.CWinImpl;

public class ClarionEventQueue extends EventQueue 
{
    private static ClarionEventQueue instance=new ClarionEventQueue();
    
    public static ClarionEventQueue getInstance()
    {
        return instance;
    }
    
    private LinkedList<AWTEvent> queue=new LinkedList<AWTEvent>();
    private boolean record;
    private long    recordSession;
    private long    dispatchPlaybackSession;
    private boolean init;
    
    private static class Playback extends AWTEvent
    {
        private static final long serialVersionUID = 6315226337196031226L;
        private long playbackSession=0;
        private String reason;
        
        public Playback(long playbackSession,String reason) 
        {
            super(instance,0);
            this.playbackSession=playbackSession;
            this.reason=reason;
        }
        
        public long getPlaybackSession()
        {
            return playbackSession;
        }
        
        @SuppressWarnings("unused")
        public String getReason()
        {
            return reason;
        }
    }
    
    public void init()
    {
        if (init) return;
        init=true;
        java.awt.Toolkit.getDefaultToolkit().getSystemEventQueue().push(this);
    }
    
    @Override 
    public AWTEvent getNextEvent() throws InterruptedException
    {
        while ( true ) {
            AWTEvent event = null;

            //if (super.peekEvent()==null) {
                synchronized(queue) {
                    if (record==true && dispatchPlaybackSession==recordSession) {
                        if (queue.isEmpty()) {
                            record=false;
                        } else {
                            event=queue.removeFirst();
                            //System.out.println("PLAYBACK:"+event);
                        }
                    }
                }
                if (event!=null) return event;
            //}
            
            event = super.getNextEvent();
            if (event instanceof Playback) {
                long newDispatchPlaybackSession=((Playback)event).getPlaybackSession();
                synchronized(this) {
                    if (newDispatchPlaybackSession>dispatchPlaybackSession) {
                        dispatchPlaybackSession=newDispatchPlaybackSession;
                    }
                }
                //System.out.println("Playing back:"+dispatchPlaybackSession+" "+((Playback)event).getReason());
                continue;
            }

            if (event.getID() == KeyEvent.KEY_TYPED
                    ||  event.getID() == KeyEvent.KEY_PRESSED
                    ||  event.getID() == KeyEvent.KEY_RELEASED)
            {
                synchronized(queue) {
                    if (record) {
                        queue.add(event);
                        //System.out.println("RECORD:"+event);
                        continue;
                    }
                }
            }
            
            return event;
        }
        
    }
    
    public void setRecordState(boolean record,final String reason)
    {
        if (!init) return;
        if (record==true) {
            synchronized(queue) {
                this.record=true;
                this.recordSession++;
                //System.out.println("Recording:"+recordSession+":"+reason);
            }
        } else {
            final long tplaybackSession;
            synchronized(queue) {
                if (!this.record) return;
                tplaybackSession=recordSession;
            }
            SwingUtilities.invokeLater(new Runnable() {
                public void run() {
                    postEvent(new Playback(tplaybackSession,reason));
                }
            });
        }
    }
}
