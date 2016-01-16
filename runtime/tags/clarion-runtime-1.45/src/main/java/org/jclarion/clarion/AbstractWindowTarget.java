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
package org.jclarion.clarion;

import java.awt.Component;
import java.awt.Container;
import java.awt.Frame;
import java.awt.Insets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;

import javax.swing.JRootPane;
import javax.swing.SwingUtilities;

import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.ControlIterator;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.runtime.CWinImpl;
import org.jclarion.clarion.swing.ClarionEventQueue;
import org.jclarion.clarion.swing.ClarionStatusPane;
import org.jclarion.clarion.swing.MnemonicConfig;
import org.jclarion.clarion.swing.OpenMonitor;

/**
 * Window type target. i.e. application or window
 * 
 * @author barney
 *
 */
public abstract class AbstractWindowTarget extends AbstractTarget {

    public static boolean suppressWindowSizingEvents=false;
    
    private LinkedList<ClarionEvent>    events;
    private ClarionEvent                acceptedEvent;
    private List<StatusBar>             status;
    private ClarionStatusPane           statusPane;
    
    //private Map<Integer,AbstractControl> hotKeyedControls;
    
    public AbstractWindowTarget() {
        super();
        events=new LinkedList<ClarionEvent>();
    }
    
    public AbstractControl add(AbstractControl child) {
        super.add(child);
        return child;
    }
    
    public static class StatusBar
    {
        private ClarionObject value;
        private int width;

        public StatusBar()
        {
            value=new ClarionString();
            width=0;
        }

        public String getValue() {
            return value.toString();
        }
        
        public int getWidth()
        {
            return width;
        }
    }

    public synchronized List<StatusBar> getStatus()
    {
        return status;
    }
    
    public synchronized StatusBar getStatus(int offset)
    {
        if (status==null) {
            status=new ArrayList<StatusBar>();
        }
        while (status.size()<offset) {
            status.add(new StatusBar());
        }
        return status.get(offset-1);
    }

    public void doSetStatus(int... bars)
    {
        if (bars.length==0) {
            bars=new int[] { -1 };
        }
        
        for (int scan=1;scan<=bars.length;scan++) {
            getStatus(scan).width=bars[scan-1];
        }
    }
    
    
    /**
     * Accept loop trigger. checks if current window event loop is still active
     * and waits/primes next event to be dealt with
     * 
     * @return true if accept loop is still alive
     */
    public boolean accept() {
        return CWin.getInstance().accept(this);
    }

    /**
     *  Consume next event. i.e. accept loop reached end of its loop. If user
     *  calls continue during accept loop then means that non consume handling 
     *  of event is to be performed. i.e. if continue is called during CloseWindow
     *  event then close window is aborted. but if consumeAccept is called in that
     *  time, means that close window is to proceed. 
     */
    public void consumeAccept() {
        CWin.getInstance().consumeAccept(this);
    }
    
    public void clearAllEvents()
    {
        events.clear();
        acceptedEvent=null;
    }
    
    public boolean isPurgable(ClarionEvent e)
    {
        if (e.getEvent()==Event.ACCEPTED) return true;
        if (e.getEvent()==Event.PREALERTKEY) return true;
        if (e.getEvent()==Event.ALERTKEY) return true;
        return false;
    }

    public void purgeEvents()
    {
        ArrayList<ClarionEvent>  cloneEvents=null;
        
        synchronized(events) {
            Iterator<ClarionEvent> ce = events.iterator();
            while (ce.hasNext()) {
                ClarionEvent e = ce.next();
                if (isPurgable(e)) {
                    if (cloneEvents==null) {
                        debugEvents();
                        cloneEvents=new ArrayList<ClarionEvent>();
                    }
                    ce.remove();
                    cloneEvents.add(e);
                }
            }
            
            events.notifyAll();
        }
        
        if (cloneEvents!=null) {
            for (ClarionEvent e : cloneEvents) {
                e.consume(true);
            }
        }
    }
    
    @Deprecated
    public void post(int event,int field) 
    {
        if (field==0) {
            post(event);
        } else {
            post(ClarionEvent.test(event,field,false));
        }
    } 

    public void post(int event) 
    {
        post(new ClarionEvent(event,null,false));
    } 

    public void post(ClarionEvent e) 
    {
        if (suppressWindowSizingEvents) {
            switch (e.getEvent()) {
                case Event.SIZED:
                case Event.MOVED:
                    return;
            }
        }
        
        boolean active;
        
        e.setClarionThread(getClarionThread());

        boolean record=false;
        
        if (SwingUtilities.isEventDispatchThread()) {
            //switch(e.getEvent()) {
                //case Event.PREALERTKEY:
                //case Event.ALERTKEY:
                //case Event.ACCEPTED:
                //case Event.SELECTED:
                //case Event.NEWSELECTION:
                    record=true;
            //}
        }
       
        synchronized(events) {
            events.add(e);
            events.notifyAll();
            active=this.active;
            if (record) {
                if (active) {
                    ClarionEventQueue.getInstance().setRecordState(true,"posting event to clarion thread");
                    //ClarionEventQueue.getInstance().setRecordState(true,CWin.eventString(e.getEvent()));
                } else {
                    //ClarionEventQueue.getInstance().setRecordState(true,CWin.eventString(e.getEvent()));
                    // assume that we are already recording
                    // it should be safe to call record again - but doesn't work
                    // well with things like message().  
                }
            }
        }
        
        
        if (!active) {
            e.consume(true);
        }
        
        if (CWinImpl.log.isLoggable(Level.FINE)) CWinImpl.log.fine(e.toString()); 
        
    }

    private boolean active;
    
    private void debugEvents()
    {
        if (!CWinImpl.log.isLoggable(Level.FINE)) return;
        if (events.isEmpty()) return;
        for (ClarionEvent ce : events ) {
            CWinImpl.log.fine(ce.toString(true));
        }
    }
    
    public void setActiveState(boolean active)
    {
        ArrayList<ClarionEvent>  cloneEvents=null;
        
        synchronized(events) {
            if (active==this.active) return;
            
            this.active=active;
            if (!active) {
                for (ClarionEvent ce : events ) {
                    if (ce.getConsumeResultNoWait()==null) {
                        if (cloneEvents==null) {
                            debugEvents();
                            cloneEvents=new ArrayList<ClarionEvent>();
                        }
                        cloneEvents.add(ce);
                    }
                }
            }
            events.notifyAll();
        }
        
        if (cloneEvents!=null) {
            for (ClarionEvent ce : cloneEvents ) {
                ce.consume(true);
            }
        }
    }

    private List<Runnable> anonymousTasks=new ArrayList<Runnable>();
    
    public void addAcceptTask(Runnable r)
    {
        synchronized(events) {
            anonymousTasks.add(r);
            events.notifyAll();
        }
    }
    
    private Map<Object,Runnable> keyedTasks=new HashMap<Object, Runnable>();

    public void addAcceptTask(Object o,Runnable r)
    {
        if (r==null) return;
        synchronized(events) {
            keyedTasks.put(o,r);
            events.notifyAll();
        }
    }

    public boolean hasTasksPending()
    {
        synchronized(events) {
            return (!anonymousTasks.isEmpty()) ||  (!keyedTasks.isEmpty());
        }
    }
    
    public void runAcceptTasks()
    {
        List<Runnable> run;
        
        synchronized(events) {
            int size = anonymousTasks.size()+keyedTasks.size();
            if (size==0) return;
            run=new ArrayList<Runnable>(size);
            run.addAll(anonymousTasks);
            run.addAll(keyedTasks.values());
            anonymousTasks.clear();
            keyedTasks.clear();
        }
        
        for ( Runnable r : run ) {
            r.run();
        }
    }
    
    public boolean getActiveState()
    {
        synchronized(events) {
            return active;
        }
    }
    
    public void waitForActiveState(boolean state,int milliseconds)
    {
        long until = System.currentTimeMillis()+milliseconds;

        while ( true ) {
            synchronized(events) {
                if (active==state) return;
                
                long waitUntil = until-System.currentTimeMillis();
                if (waitUntil<=0) return;
                try {
                    events.wait(waitUntil);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    
    private Set<Integer> alerts;
    
    public void addAlert(int keyCode)
    {
        if (alerts==null) {
            alerts=new HashSet<Integer>();
        }
        alerts.add(keyCode);
    }
    
    public void clearAlerts()
    {
        alerts=null;
    }
    
    public boolean isAlertKey(int keyCode)
    {
        if (alerts==null) return false;
        return alerts.contains(keyCode);
    }
    
    private int keyCode;
    private int keyState;
    private int keyChar;
    
    public void setKeyCode(int keyCode)
    {
        this.keyCode=keyCode;
    }
    
    public int getKeyCode()
    {
        if (acceptedEvent!=null && acceptedEvent instanceof KeyedClarionEvent)
        {
            return ((KeyedClarionEvent)acceptedEvent).getKeyCode();
        }
        return keyCode;
    }
    
    public void setKeyChar(int keyCode)
    {
        this.keyChar=keyCode;
    }

    public int getKeyChar() 
    {
        if (acceptedEvent!=null && acceptedEvent instanceof KeyedClarionEvent)
        {
            return ((KeyedClarionEvent)acceptedEvent).getKeyChar();
        }
        return keyChar;
    }
    
    public void setKeyState(int keyState)
    {
        this.keyState=keyState;
    }
    
    public int getKeyState()
    {
        if (acceptedEvent!=null && acceptedEvent instanceof KeyedClarionEvent)
        {
            return ((KeyedClarionEvent)acceptedEvent).getKeyState();
        }
        return keyState;
    }
 
    
    public void waitForEvent(int wait)
    {
        synchronized(events) {
            long waitUntil=0;
            if (wait>0) waitUntil=System.currentTimeMillis()+wait*10;

            try {
                while (events.isEmpty()) {
                    if (wait<=0) {
                        events.wait();
                    } else {
                        long until = waitUntil-System.currentTimeMillis();
                        if (until<=0) break;
                        events.wait(until);
                    }
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public void waitForSpecificEvent(int type,int wait)
    {
        synchronized(events) {
            long waitUntil=0;
            if (wait>0) waitUntil=System.currentTimeMillis()+wait*10;

            try {
                while ( true ) {
                    for (ClarionEvent ce : events) {
                        if (ce.getEvent()==type) return;
                    }
                    
                    if (wait <= 0) {
                        events.wait();
                    } else {
                        long until = waitUntil - System.currentTimeMillis();
                        if (until <= 0)
                            break;
                        events.wait(until);
                    }
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    
    private Map<Integer,Map<Integer,Runnable>> registeredEvents;
    
    public ClarionEvent getNextEvent(int wait) 
    {
        setActiveState(true);
        
        if (acceptedEvent==null) {
            
            synchronized(events) {
                
                while (events.isEmpty() && acceptAllIterator!=null) {
                    if (acceptAllIterator.hasNext()) {
                        AbstractControl ac = acceptAllIterator.next();
                        if (ac.isAcceptAllControl()) {
                            
                            if (ac.isProperty(Prop.REQ) && ac.getUseObject()!=null && (ac.getUseObject().boolValue()==false)) {
                                CWin.getInstance().select(ac);
                                acceptAllIterator=null;
                                acceptAll=false;
                            } else {
                                events.add(new ClarionEvent(Event.ACCEPTED,ac,true));
                            }
                        }
                    } else {
                        events.add(new ClarionEvent(Event.COMPLETED,null,true));
                        acceptAllIterator=null;
                        acceptAll=false;
                    }
                }
            }

            long waitUntil=0;
            if (wait>0) waitUntil=System.currentTimeMillis()+wait*10;
            
            boolean runTasks=false;
            while ( acceptedEvent==null ) {
            
                if (runTasks) runAcceptTasks();
                
                synchronized(events) {
                    if (hasTasksPending()) {
                        runTasks=true;
                        continue;
                    } else {
                        runTasks=false;
                    }
                    
                    if (!events.isEmpty()) {
                        acceptedEvent=events.removeFirst();
                        continue;
                    }

                    ClarionEventQueue.getInstance().setRecordState(false,"accept()");
                    
                    try {
                         if (wait<0) {
                             break;
                         }
                         if (wait==0) {
                            events.wait();
                        } else {
                            long until = waitUntil-System.currentTimeMillis();
                            if (until<=0) break;
                            events.wait(until);
                        }
                    } catch (InterruptedException e) { }
                }
            }
            
            if (acceptedEvent!=null && registeredEvents!=null) {
                Map<Integer,Runnable> reg = registeredEvents.get(acceptedEvent.getEvent());
                if (reg!=null) {
                    for (Runnable r : reg.values()) {
                        r.run();
                    }
                }
            }
        }
        return acceptedEvent;
    }    

    public ClarionEvent getPendingEvent() 
    {
        return acceptedEvent;
    }    
    
    public ClarionEvent consumePendingEvent() 
    {
        ClarionEvent event = acceptedEvent;
        acceptedEvent=null;
        return event;
    }

    private int fontWidth;
    private int fontHeight;
    
    public void setFontDimensions(int averageCharWidth, int height) {
        this.fontWidth=averageCharWidth;
        this.fontHeight=height;
    }    
    
    public int getFontWidth()
    {
        return fontWidth;
    }

    public int getFontHeight()
    {
        return fontHeight;
    }
    
    public int widthPixelsToDialog(int val)
    {
        if (fontWidth==0) return val;
        return (val)*4/fontWidth;
    }

    public int widthDialogToPixels(int val)
    {
        if (fontWidth==0) return val;
        return val*fontWidth/4;
    }
    
    public int heightPixelsToDialog(int val)
    {
        if (fontHeight==0) return val;
        return (val)*8/fontHeight;
    }

    public int heightDialogToPixels(int val)
    {
        if (fontHeight==0) return val;
        return val*fontHeight/8;
    }

    public void registerEvent(int event, Runnable trigger, int key) {
        
        if (registeredEvents==null) {
            registeredEvents=new HashMap<Integer, Map<Integer, Runnable>>();
        }
        
        Map<Integer,Runnable> bits = registeredEvents.get(event);
        if (bits==null) {
            bits=new HashMap<Integer, Runnable>();
            registeredEvents.put(event,bits);
        }
        bits.put(key,trigger);
    }

    public void deregisterEvent(int event, Runnable trigger, int key) {
        
        if (registeredEvents==null) return;
        Map<Integer,Runnable> bits = registeredEvents.get(event);
        if (bits==null) return;
        bits.remove(key);
        if (bits.isEmpty()) {
            registeredEvents.remove(event);
            if (registeredEvents.isEmpty()) registeredEvents=null;
        }
        
    }

    private boolean acceptAll;
    private ControlIterator acceptAllIterator;
    
    @Override
    protected void notifyLocalChange(int indx, ClarionObject value) {
        if (indx==Prop.ACCEPTALL) {
            boolean new_accept=value.boolValue();
            if (new_accept==acceptAll) return;
            acceptAll=new_accept;
            if (acceptAll) {
                acceptAllIterator = new ControlIterator(this);
                acceptAllIterator.setScanSheets(true);
            } else {
                acceptAllIterator=null;
            }
        }
    }

    private MnemonicConfig      mnemonicConfig;
    private Component           refocus;
    private AbstractControl     currentFocus;
    private Container           contentPane;
    private Container           window;
    private JRootPane           rootPane;
    private OpenMonitor         openMonitor;
    private Component           shadow;
    private Insets              insets;
    private Frame               holdingFrame;
    private Runnable            repaint;
    private Thread              clarionThread;
    private AbstractControl     initialSelectControl;

    @Override
    public void clearMetaData() {
        mnemonicConfig=null;
        refocus=null;
        currentFocus=null;
        contentPane=null;
        statusPane=null;
        window=null;
        rootPane=null;
        openMonitor=null;
        shadow=null;
        insets=null;
        holdingFrame=null;
        repaint=null;
        clarionThread=null;
        initialSelectControl=null;
        super.clearMetaData();
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        debugMetaData(sb,"mnemonicConfig",mnemonicConfig);
        debugMetaData(sb,"refocus",refocus);
        debugMetaData(sb,"currentFocus",currentFocus);
        debugMetaData(sb,"contentPane",contentPane);
        debugMetaData(sb,"window",window);
        debugMetaData(sb,"rootPane",rootPane);
        debugMetaData(sb,"openMonitor",openMonitor);
        debugMetaData(sb,"shadow",shadow);
        debugMetaData(sb,"insets",insets);
        debugMetaData(sb,"holdingFrame",holdingFrame);
        debugMetaData(sb,"repaint",repaint);
        debugMetaData(sb,"initialSelectControl",initialSelectControl);
        debugMetaData(sb,"clarionThread",clarionThread);
        debugMetaData(sb,"status",status);
        debugMetaData(sb,"statusPane",statusPane);
    }
    
    public MnemonicConfig getMnemonic(boolean create) 
    {
        if (mnemonicConfig==null && create) {
            mnemonicConfig = new MnemonicConfig();
        }
        return mnemonicConfig;
    }

    
    public Component getRefocus()
    {
        return refocus;
    }
    
    public void setRefocus(Component refocus)
    {
        this.refocus=refocus;
    }

    public AbstractControl getCurrentFocus()
    {
        return currentFocus;
    }
 
     
    public void setCurrentFocus(AbstractControl currentFocus)
    {
        this.currentFocus=currentFocus;
    }

    public Container getContentPane()
    {
        return contentPane; 
    }
    
    public void setContentPane(Container contentPane)
    {
        this.contentPane=contentPane;
    }

    public ClarionStatusPane getStatusPane()
    {
        return statusPane; 
    }
    
    public void setStatusPane(ClarionStatusPane statusPane)
    {
        this.statusPane=statusPane;
    }
    
    public JRootPane getRootPane()
    {
        return rootPane; 
    }
    
    public void setRootPane(JRootPane rootPane)
    {
        this.rootPane=rootPane;
    }
    
    public Container getWindow()
    {
        return window; 
    }

    
    public void setWindow(Container window)
    {
        this.window=window;
    }
    
    public OpenMonitor getOpenMonitor()
    {
        return openMonitor;
    }

    public void setOpenMonitor(OpenMonitor openMonitor)
    {
        this.openMonitor=openMonitor;
    }

    public Component getShadow()
    {
        return shadow;
    }
    
    public void setShadow(Component shadow)
    {
        this.shadow=shadow;
    }
    
    public Insets getInsets()
    {
        return insets;
    }
    
    public void setInsets(Insets insets)
    {
        this.insets=insets;
    }

    public String toString()
    {
        return (getActiveState()? "(ACTIVE)" : "(INACTIVE)") +super.toString();
    }

    public static boolean isSuppressWindowSizingEvents() {
        return suppressWindowSizingEvents;
    }

    public static void setSuppressWindowSizingEvents(
            boolean suppressWindowSizingEvents) {
        AbstractWindowTarget.suppressWindowSizingEvents = suppressWindowSizingEvents;
    }

    public LinkedList<ClarionEvent> getEvents() {
        return events;
    }

    public void setEvents(LinkedList<ClarionEvent> events) {
        this.events = events;
    }

    public ClarionEvent getAcceptedEvent() {
        return acceptedEvent;
    }

    public void setAcceptedEvent(ClarionEvent acceptedEvent) {
        this.acceptedEvent = acceptedEvent;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public List<Runnable> getAnonymousTasks() {
        return anonymousTasks;
    }

    public void setAnonymousTasks(List<Runnable> anonymousTasks) {
        this.anonymousTasks = anonymousTasks;
    }

    public Map<Object, Runnable> getKeyedTasks() {
        return keyedTasks;
    }

    public void setKeyedTasks(Map<Object, Runnable> keyedTasks) {
        this.keyedTasks = keyedTasks;
    }

    public Set<Integer> getAlerts() {
        return alerts;
    }

    public void setAlerts(Set<Integer> alerts) {
        this.alerts = alerts;
    }

    public Map<Integer, Map<Integer, Runnable>> getRegisteredEvents() {
        return registeredEvents;
    }

    public void setRegisteredEvents(
            Map<Integer, Map<Integer, Runnable>> registeredEvents) {
        this.registeredEvents = registeredEvents;
    }

    public boolean isAcceptAll() {
        return acceptAll;
    }

    public void setAcceptAll(boolean acceptAll) {
        this.acceptAll = acceptAll;
    }

    public ControlIterator getAcceptAllIterator() {
        return acceptAllIterator;
    }

    public void setAcceptAllIterator(ControlIterator acceptAllIterator) {
        this.acceptAllIterator = acceptAllIterator;
    }

    public MnemonicConfig getMnemonicConfig() {
        return mnemonicConfig;
    }

    public void setMnemonicConfig(MnemonicConfig mnemonicConfig) {
        this.mnemonicConfig = mnemonicConfig;
    }

    public Frame getHoldingFrame() {
        return holdingFrame;
    }

    public void setHoldingFrame(Frame holdingFrame) {
        this.holdingFrame = holdingFrame;
    }

    public void setFontWidth(int fontWidth) {
        this.fontWidth = fontWidth;
    }

    public void setFontHeight(int fontHeight) {
        this.fontHeight = fontHeight;
    }

    public void noteFullRepaint()
    {
        if (repaint==null) {
            repaint=new Runnable() {
                @Override
                public void run() {
                    CWinImpl.run(new Runnable() {
                        public void run() {
                            Component c = getWindow();
                            if (c!=null) c.repaint();
                        }
                    });
                } 
            };
        }
        addAcceptTask(repaint); 
    }

    public void setClarionThread(Thread t)
    {
        clarionThread=t;
    }
    
    public Thread getClarionThread() {
        return clarionThread;
    }

    @Override
    public boolean isSettable(int indx, ClarionObject value) {
        switch(indx) {
            case Prop.WIDTH: 
            case Prop.HEIGHT:
                if (value.intValue()<=0) return false;
        }
        return super.isSettable(indx, value);
    }

    public AbstractControl getInitialSelectControl() {
        return initialSelectControl;
    }

    public void setInitialSelectControl(AbstractControl initialSelectControl) {
        this.initialSelectControl = initialSelectControl;
    }
    

    @Override
    public ClarionObject getProperty(ClarionObject key,ClarionObject index) {
        int test = key.intValue();
        switch(test) {
            case Prop.STATUS:
                return new ClarionNumber(getStatus(index.intValue()).width);
            case Prop.STATUSTEXT:
                return getStatus(index.intValue()).value;
            default:
                return super.getProperty(key,index);
        }
    }

    @Override
    public void setProperty(ClarionObject key, ClarionObject index,
            ClarionObject value) {
        int test = key.intValue();
        switch(test) {
            case Prop.STATUS:
                getStatus(index.intValue()).width=value.intValue();
                if (getStatusPane()!=null) {
                    getStatusPane().notifyStatusChange();
                }
                break;
            case Prop.STATUSTEXT:
                getStatus(index.intValue()).value=value;
                if (getStatusPane()!=null) {
                    getStatusPane().notifyStatusChange();
                }
                break;
            default:
                super.setProperty(key, index, value);
        }
    }
    
    
}
