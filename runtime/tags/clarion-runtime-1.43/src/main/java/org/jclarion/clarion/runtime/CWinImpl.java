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
package org.jclarion.clarion.runtime;

import java.awt.AWTException;
import java.awt.AWTKeyStroke;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Cursor;
import java.awt.Dialog;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Frame;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.GraphicsEnvironment;
import java.awt.Image;
import java.awt.Insets;
import java.awt.KeyboardFocusManager;
import java.awt.MouseInfo;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.RenderingHints;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.Window;
import java.awt.Dialog.ModalExclusionType;
import java.awt.Dialog.ModalityType;
import java.awt.event.ActionEvent;
import java.awt.event.ComponentEvent;
import java.awt.event.ComponentListener;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.awt.image.BufferedImage;
import java.awt.image.ImageObserver;
import java.beans.PropertyVetoException;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.logging.Logger;

import javax.swing.AbstractAction;
import javax.swing.Action;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JDesktopPane;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRootPane;
import javax.swing.JScrollPane;
import javax.swing.JWindow;
import javax.swing.LayoutFocusTraversalPolicy;
import javax.swing.ScrollPaneConstants;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;
import javax.swing.WindowConstants;
import javax.swing.UIManager.LookAndFeelInfo;
import javax.swing.border.EmptyBorder;
import javax.swing.event.InternalFrameEvent;
import javax.swing.event.InternalFrameListener;


import org.jclarion.clarion.AbstractWindowTarget;
import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.KeyedClarionEvent;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.PropertyObjectListener;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ControlIterator;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.print.AWTPrintContext;
import org.jclarion.clarion.print.Page;
import org.jclarion.clarion.swing.ClarionContentPane;
import org.jclarion.clarion.swing.ClarionDesktopPane;
import org.jclarion.clarion.swing.ClarionEventQueue;
import org.jclarion.clarion.swing.ClarionFocusTraversalPolicy;
import org.jclarion.clarion.swing.ClarionLayoutManager;
import org.jclarion.clarion.swing.ClarionLookAndFeel;
import org.jclarion.clarion.swing.ClarionStatusPane;
import org.jclarion.clarion.swing.FramePropertyListener;
import org.jclarion.clarion.swing.MnemonicConfig;
import org.jclarion.clarion.swing.OpenMonitor;
import org.jclarion.clarion.swing.ShadowCanvas;
import org.jclarion.clarion.swing.ShadowGlass;
import org.jclarion.clarion.swing.SwingAccept;
import org.jclarion.clarion.swing.SwingKeyCodes;
import org.jclarion.clarion.swing.MnemonicConfig.Mode;

public class CWinImpl {
    
    public static Logger log = Logger.getLogger(CWinImpl.class.getName());
    
    private static class WindowStack
    {
        private List<AbstractWindowTarget> windows = new ArrayList<AbstractWindowTarget>(); 
        private AbstractWindowTarget target;
        private Thread               thread;
        
        public String toString()
        {
            return "WS:["+target+" :: "+windows+"]";
        }
    }

    private ClarionApplication app;

    private static class Stack
    {
        private Map<Long,WindowStack> threads =new HashMap<Long, WindowStack>();
        
        public synchronized WindowStack get(Thread t)
        {
            WindowStack ws = threads.get(t.getId());
            if (ws==null) {
                ws=new WindowStack();
                ws.thread=t;
                threads.put(t.getId(),ws);
            }
            return ws;
        }
        
        public WindowStack get()
        {
            return get(Thread.currentThread());
        }
        
        public String toString()
        {
            return threads.toString();
        }
    }
    private Stack stack=new Stack();

    public CWinImpl()
    {
        ClarionEventQueue.getInstance().init();
        ClarionLookAndFeel.init(System.getProperty("laf"));
    }
    
    private long lastLog=0;
    
    public void log(String entry)
    {
        if (lastLog+5000<System.currentTimeMillis()) {
            log.info(entry);
        } else {
            System.out.println(entry);
        }
        lastLog=System.currentTimeMillis();
    }
    
    public void getLookAndFeels(ClarionQueue queue)
    {
        for (LookAndFeelInfo info : UIManager.getInstalledLookAndFeels()) {
            queue.what(1).setValue(info.getName());
            queue.add();
        }
    }

    public String getDebugMetaData()
    {
        StringBuilder data = new StringBuilder();
        
        for (WindowStack entry : stack.threads.values()) {
            data.append("THREAD:").append(entry.thread).append('\n');
            AbstractWindowTarget t =entry.target;
            if (t!=null) {
                t.getDebugMetaData(data);
                data.append('\n');
                ControlIterator ci = new ControlIterator(t);
                ci.setLoop(false);
                ci.setScanDisabled(true);
                ci.setScanHidden(true);
                ci.setScanSheets(true);
                while (ci.hasNext()) {
                    ci.next().getDebugMetaData(data);
                    data.append('\n');
                }
            }  
        }
        return data.toString();
    }
    
    public boolean isNimbus()
    {
        return UIManager.getLookAndFeel().getName().contains("Nimbus");
    }
    
    public void setTarget(AbstractWindowTarget awt)
    {
        stack.get().target=awt;
    }
    
    public AbstractWindowTarget getTarget()
    {
        AbstractWindowTarget result=stack.get().target;
        if (result==null) {
            log.fine("Target is null on thread:"+Thread.currentThread());
        } else {
            restoreWindow(result);
        }
        return result;
    }

    public int getTargetDepth()
    {
        return stack.get().windows.size();
    }
    
    public AbstractWindowTarget getTarget(int ofs)
    {
        synchronized(stack) {
            WindowStack ws = stack.get();
            if (ws.windows.size()<=ofs) return null;
            return ws.windows.get(ws.windows.size()-1-ofs);
        }
    }
    
    
    public AbstractWindowTarget getTarget(Thread t)
    {
        synchronized(stack) {
            WindowStack ws = stack.get(t);
            return ws.target;
        }
    }
    
    public ClarionApplication getApp()
    {
        return app;
    }

    public void open(final AbstractWindowTarget target)
    {
        WindowStack ws = stack.get();

        target.setClarionThread(Thread.currentThread());
        
        synchronized(stack) {
            if (ws.target!=null) {
                ws.target.setActiveState(false);
            }
            ws.windows.add(target);
            ws.target=target;
        }
        
        open();

        if (target instanceof ClarionApplication) {
            if (app!=null) {
                throw new RuntimeException("Application already open");
            }
            app=(ClarionApplication)target;
        }

        target.clearAllEvents();
        target.post(Event.OPENWINDOW);
    }

    private void closeApp()
    {
        AbstractWindowTarget awt; 
        while ( true ) {
            
            awt=null;
            Thread t = null;
            WindowStack ws=null;
            synchronized(stack) {
                
                for (WindowStack stacks : stack.threads.values() ) {
                    if (!stacks.windows.isEmpty()) {
                        awt=stacks.target;
                        if (!awt.isProperty(Prop.MDI)) {
                            awt=null;
                        } else {
                            ws=stacks;
                            if (stacks.windows.size()<=1) {
                                t=stacks.thread;
                            }
                            break;
                        }
                    }
                }
            }
         
            if (awt==null) break;
            ClarionEvent ce = new ClarionEvent(Event.CLOSEDOWN,null,false);
            awt.post(ce);
            ce.getConsumeResult();
            awt.waitForActiveState(false,5000);
            
            long until = System.currentTimeMillis()+5000;
            synchronized(stack) {
                while ( ws.target==awt ) {
                    long wu = until-System.currentTimeMillis();
                    if (wu<=0) break;
                    try {
                        stack.wait(wu);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
            
            if (t!=null) {
                try {
                    t.join(5000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public void programmaticClose(AbstractWindowTarget target)
    {
        close(target);
        closeAcceptLoop(target);
    }
    
    public void closeAcceptLoop(AbstractWindowTarget target) 
    {
        WindowStack ws=stack.get();

        synchronized(stack) {
            if (ws.target!=target) return;
            ws.windows.remove(target);
            if (ws.windows.isEmpty()) {
                ws.target=null;
            } else {
                ws.target=ws.windows.get(ws.windows.size()-1);
            }
            stack.notifyAll();
        }
        
        target.setActiveState(false);
        
        if (target==app) {
            app=null;
        }
    }
    
    public void close(AbstractWindowTarget target)
    {
        WindowStack ws=stack.get();

        synchronized(stack) {
            if (ws.windows.size()==0) return;
            AbstractWindowTarget awt = ws.windows.get(ws.windows.size()-1);
            if (awt!=target) return;
            ws.target=target;
        }

        if (target==app) {
            target.setActiveState(false);
            closeApp();
        }

        close();
    }
    
    public final boolean accept()
    {
        return accept((AbstractWindowTarget)getTarget());
    }
    
    public final void consumeAccept()
    {
        consumeAccept((AbstractWindowTarget)getTarget());
    }
    
    public void lazyOpen(final AbstractWindowTarget target) 
    {
        OpenMonitor monitor = target.getOpenMonitor();
        if (monitor == null) return;

        Runnable r = new Runnable() {
            @Override
            public void run() {
                final Container c = (Container) target.getWindow();
     
                c.addComponentListener(new ComponentListener() {

                    private Point last_known_location = c.getLocation();

                    @Override
                    public void componentHidden(ComponentEvent e) {
                    }

                    @Override
                    public void componentMoved(ComponentEvent e) {
                        Point np = e.getComponent().getLocation();
                        if (np.x == last_known_location.x
                                && np.y == last_known_location.y)
                            return;
                        last_known_location = np;
                        target.post(Event.MOVED);
                    }

                    @Override
                    public void componentResized(ComponentEvent e) {
                        target.post(Event.SIZED);
                    }

                    @Override
                    public void componentShown(ComponentEvent e) {
                    }
                });

                boolean max =false;
                ClarionObject maximize = target.getRawProperty(Prop.MAXIMIZE,false);
                if (maximize!=null && maximize.boolValue()) max=true;

                if ((c instanceof Frame) && max) {
                    ((Frame) c).setExtendedState(Frame.MAXIMIZED_BOTH);
                }
                
                if ((c instanceof JInternalFrame) && max) {
                    try {
                        ((JInternalFrame) c).setMaximum(true);
                    } catch (PropertyVetoException e) {
                    }
                }

                c.setVisible(true);
            }
        };

        run(r);
           
        monitor.waitForOpen();
        target.setOpenMonitor(null);
    }

    //@Override
    public boolean accept(AbstractWindowTarget target) {
        if (target == null)
            return false;

        lazyOpen(target);
        restoreWindow(target);
        target.runAcceptTasks();

        ClarionObject timer = target.getRawProperty(Prop.TIMER);

        while (true) {
            Component s = (Component) target.getWindow();
            if (s == null) {
                break;
            }
            if (!s.isDisplayable()) {
                break;
            }

            ClarionEvent cycled = target.consumePendingEvent();
            if (cycled != null) {
                cycled.consume(false);

                if (cycled.getEvent() == Event.CLOSEDOWN) {
                    close(target);
                    continue;
                    // not allowed to cycle a close down event
                }

                if (cycled.getEvent() == Event.OPENWINDOW) {
                    close(target);
                    continue;
                }
            }

            ClarionEvent next = target.getNextEvent(timer == null ? 0 : timer
                    .intValue());

            if (next != null) {
                if (next.getEvent() == 0) {
                    target.consumePendingEvent();
                    continue;
                }
                return true;
            } else {
                target.post(Event.TIMER);
            }
        }

        programmaticClose(target);
        return false;
    }
    
    public void setDefaultButton(final AbstractWindowTarget parent)
    {
        if (parent==null) return;
        
        Runnable r = new Runnable() {
            public void run() {
                JButton def=null;
                JRootPane pane = parent.getRootPane();
                if (pane==null) return; 

                ControlIterator ci = new ControlIterator(parent);
                while (ci.hasNext()) {
                    AbstractControl act = ci.next();
                    if (act instanceof ButtonControl) {
                        ButtonControl bc = (ButtonControl)act;
                        if (bc.isProperty(Prop.DEFAULT)) {
                            def=(JButton)bc.getButton();
                            if (def!=null) {
                                break;
                            }
                        }
                    }
                }

                pane.setDefaultButton(def);
            }
        };
        run(r);
    }
    
    private void restoreWindow(final AbstractWindowTarget parent)
    {
        if (parent == null) return;
        if (parent.getShadow()==null) return;
        
        Runnable r = new Runnable() {
          
            public void run() 
            {
                if (parent.getShadow()==null) return;
                final JDesktopPane desktopPane = getApp().getDesktopPane();

                Component shadow = parent.getShadow();
                JInternalFrame window = (JInternalFrame) parent.getWindow();

                window.putClientProperty("shadow",null);
                window.removeVetoableChangeListener(FramePropertyListener.getInstance());
                window.getGlassPane().setVisible(false);
                desktopPane.remove(shadow);

                try {
                    window.setSelected(true);
                } catch (PropertyVetoException e) {
                }

                parent.setShadow(null);
                AbstractControl ac=parent.getCurrentFocus();
                
                setDefaultButton(parent);
         
                if (ac!=null) {
                    Component t = ac.getComponent();
                    ClarionFocusTraversalPolicy ftp = (ClarionFocusTraversalPolicy)window.getFocusTraversalPolicy();
                    if (!ftp.accept(t,null)) {
                        t=ftp.getComponentAfter(window,t);
                    }

                    if (t!=null) {
                        if (!t.hasFocus()) {
                            t.requestFocusInWindow();
                        }
                    }
                }
            }
        };

        run(r);
    }

    protected void close() {

        final AbstractWindowTarget target = getTarget();
        final AbstractWindowTarget parent = getTarget(1);

        target.setActiveState(false);
        
        Runnable r = new Runnable() {
            public void run()
            {
                int x = target.getProperty(Prop.XPOS).intValue();
                int y = target.getProperty(Prop.YPOS).intValue();
                int wi = target.getProperty(Prop.WIDTH).intValue();
                int he = target.getProperty(Prop.HEIGHT).intValue();
                int max = target.getProperty(Prop.MAXIMIZE).intValue();

                Component w = (Component) target.getWindow();
                if (w != null) {
                    if (w instanceof Window) {
                        ((Window) w).dispose();
                    } else {
                        ((JInternalFrame) w).dispose();
                    }
                }

                if (target.getHoldingFrame()!=null) {
                    target.getHoldingFrame().dispose();
                }

                if (AbstractWindowTarget.suppressWindowSizingEvents && w!=null && (!(w instanceof JInternalFrame)) ) {
                    try {
                        Thread.sleep(250);
                    } catch (InterruptedException e1) {
                        e1.printStackTrace();
                    }
                }
                
                target.clearMetaData();
                target.removeAllListeners();

                for (AbstractControl c : target.getControls()) {
                    clean(c);
                }

                target.setProperty(Prop.XPOS,x);
                target.setProperty(Prop.YPOS,y);
                target.setProperty(Prop.WIDTH,wi);
                target.setProperty(Prop.HEIGHT,he);
                target.setProperty(Prop.MAXIMIZE,max);
            }
        };
        
        runNow(r);

        if (parent!=null) {
            parent.purgeEvents();
        } else {
            ClarionEventQueue.getInstance().setRecordState(false,"Thread finished");
        }
        
        target.setClarionThread(null);
    }

    private void clean(AbstractControl c) {

        c.clearMetaData();
        c.removeAllListeners();
        for (AbstractControl child : c.getChildren()) {
            clean(child);
        }
    }

    //@Override
    public void consumeAccept(AbstractWindowTarget target) {
        ClarionEvent ev = target.consumePendingEvent();
        if (ev == null)
            return;

        ev.consume(true);

        if (ev.getEvent() == Event.OPENWINDOW) {
        }

        if (ev.getEvent() == Event.CLOSEDOWN) {
            close(target);
        }

        if (ev.getEvent() == Event.ACCEPTED) {
            AbstractControl ctl = target.getControl(ev.getField());
            if (ctl != null) {
                ClarionObject std = ctl.getRawProperty(Prop.STD, false);
                if (std != null) {
                    int istd = std.intValue();
                    if (istd == Std.CLOSE) {
                        target.post(Event.CLOSEWINDOW);
                    }
                    if (istd == Std.PRINTSETUP) {
                        CWin.printerDialog(new ClarionString("Printer Setup"),null);
                    }
                }
            }
        }

        if (!ev.isWindowEvent()) {
            if (ev.getEvent() == Event.CLOSEWINDOW) {
                close(target);
            }
        }
    }

    //@Override
    public int focus() {
        AbstractControl ac = getTarget().getCurrentFocus();
        if (ac == null) return 0;
        return ac.getUseID();
    }

    private static class MessageKeyListener implements KeyListener {
        private Map<Integer, JButton> buttons = new HashMap<Integer, JButton>();

        public void addButton(JButton button, String text) {
            int c = text.charAt(0);
            if (c >= 'a' && c <= 'z')
                c = c - 'a' + 'A';
            buttons.put(c, button);
            buttons.put(c + 0x400, button);
            button.addKeyListener(this);
        }

        @Override
        public void keyPressed(KeyEvent e) {
        }

        @Override
        public void keyReleased(KeyEvent e) {
        }

        @Override
        public void keyTyped(KeyEvent e) {
            int key = SwingKeyCodes.getInstance().toClarionCode(e);
            JButton button = buttons.get(key);
            if (button != null) {
                button.doClick();
            }
        }
    }

    private class MessageFocusTraversalPolicy extends
            LayoutFocusTraversalPolicy {
        private static final long serialVersionUID = 8392703113661202447L;
        
        private Component def;

        public void setDefaultComponent(Component def) {
            this.def = def;
        }

        @Override
        public Component getDefaultComponent(Container container) {
            if (def != null)
                return def;
            return super.getDefaultComponent(container);
        }
    }

    private void addButton(JRootPane pane, JPanel panel, int button, int def,
            int code, String name, Action a, MessageKeyListener listener) {
        if ((button & code) != code)
            return;
        final JButton b;
        b=new JButton(a);
        b.setText(name);
        b.setDisplayedMnemonicIndex(0);
        listener.addButton(b, name);
        
        
        panel.add(b);
        b.setActionCommand(String.valueOf(code));
        if (def == code) {
            ((MessageFocusTraversalPolicy) pane.getFocusCycleRootAncestor()
                    .getFocusTraversalPolicy()).setDefaultComponent(b);
        }

        b.addKeyListener(new KeyListener() {

            @Override
            public void keyPressed(KeyEvent e) {
                if (e.getKeyCode()=='\n' && e.getModifiersEx()==0) {
                    b.doClick();
                }
            }

            @Override
            public void keyReleased(KeyEvent e) {
            }

            @Override
            public void keyTyped(KeyEvent e) {
            }
        });

        Set<AWTKeyStroke> forward = new HashSet<AWTKeyStroke>();
        forward.add(AWTKeyStroke.getAWTKeyStroke(KeyEvent.VK_RIGHT, 0));
        forward.add(AWTKeyStroke.getAWTKeyStroke(KeyEvent.VK_DOWN, 0));
        forward.add(AWTKeyStroke.getAWTKeyStroke(KeyEvent.VK_TAB, 0));
        b.setFocusTraversalKeys(KeyboardFocusManager.FORWARD_TRAVERSAL_KEYS,
                forward);

        Set<AWTKeyStroke> backward = new HashSet<AWTKeyStroke>();
        backward.add(AWTKeyStroke.getAWTKeyStroke(KeyEvent.VK_LEFT, 0));
        backward.add(AWTKeyStroke.getAWTKeyStroke(KeyEvent.VK_UP, 0));
        backward.add(AWTKeyStroke.getAWTKeyStroke(KeyEvent.VK_TAB,
                KeyEvent.SHIFT_DOWN_MASK));
        b.setFocusTraversalKeys(KeyboardFocusManager.BACKWARD_TRAVERSAL_KEYS,
                backward);
    }

    private static class MessageAction extends AbstractAction {
        private static final long serialVersionUID = -7756388166603189307L;
        private JDialog dialog;
        private MessageOutcome outcome;

        public MessageAction(JDialog dialog,MessageOutcome outcome) {
            this.dialog = dialog;
            this.outcome=outcome;
        }

        @Override
        public void actionPerformed(ActionEvent e) {
            final int result = Integer.parseInt(e.getActionCommand());
            dialog.dispose();
            SwingUtilities.invokeLater(new Runnable()
            {  
                public void run() { 
                    outcome.setOutcome(result);
                }
            });
        }
    }

    private int getSize(Component c)
    {
        if (c==null) return 0;
        return c.getY()+c.getHeight();
    }

    private static class MessageOutcome
    {
        private boolean finish=false;
        private int outcome=0;
        
        public void setOutcome(int outcome)
        {
            synchronized(this) {
                finish=true;
                this.outcome=outcome;
                this.notifyAll();
            }
        }
        
        public int getOutcome()
        {
            synchronized(this) {
                while (!finish) {
                    try {
                        this.wait();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
                return outcome;
            }
        }
    }
    
    //@Override
    public int message(final ClarionString message,final ClarionString header,
            final String icon,final int button,final int defButton,final int style) {
        
        AbstractWindowTarget target = CWin.getWindowTarget();
        if (target!=null) {
            target.setActiveState(false);
        }
        
        final MessageOutcome outcome = new MessageOutcome();
        
        Runnable msgbox = new Runnable() 
        {
            public void run()
            {
                Root r = getRoot();
                
                final JDialog dialog;
                List<java.awt.Image> icons=null;
                if (r.dialog!=null) {
                    dialog=new JDialog(r.dialog);
                    icons=r.dialog.getIconImages();
                } else {
                    dialog=new JDialog(r.frame);
                    icons=r.frame.getIconImages();
                }
                //dialog.setResizable(true);
                if (icons!=null && !icons.isEmpty()) {
                    dialog.setIconImage(icons.get(0));
                }
                dialog.setFocusTraversalPolicy(new MessageFocusTraversalPolicy());
                
                
                if (header!=null) {
                    dialog.setTitle(header.toString());
                }
                dialog.setModalityType(ModalityType.APPLICATION_MODAL);
                
                Container c = dialog.getContentPane();
                c.setLayout(new BorderLayout(15,15));

                JPanel panel = new JPanel(new ResizingBoxLayout());
                Component last = null;
                        
                String msg = message.toString().trim();
                
                int len=0;
                
                while (len<msg.length()) {
                    
                    int end_n = msg.indexOf('\n',len);
                    int end_r = msg.indexOf('\r',len);
                    if (end_n==-1) end_n=msg.length();
                    if (end_r==-1) end_r=msg.length();
                    
                    String line;

                    if (end_r+1==end_n) {
                        line = msg.substring(len,end_r);
                        len=end_n+1;
                    } else {
                        if (end_r<end_n) end_n=end_r;
                        line = msg.substring(len,end_n);
                        len=end_n+1;
                    }

                    boolean first=true;
                    
                    StringTokenizer words = new StringTokenizer(line," \t");
                    
                    if (!words.hasMoreTokens()) {
                        JLabel label = new JLabel(" ");
                        label.putClientProperty("newline",Boolean.TRUE);
                        panel.add(label);
                    }
                    
                    while (words.hasMoreTokens()) {
                        JLabel label = new JLabel(words.nextToken());
                        if (first) {
                            label.putClientProperty("newline",Boolean.TRUE);
                            first=false;
                        }
                        panel.add(label);
                        last=label;
                    }

                }
                        
                //c.add(new JLabel(message.toString(),JLabel.CENTER),BorderLayout.CENTER);
                c.add(panel,BorderLayout.CENTER);
                
                JPanel buttons = new JPanel(new FlowLayout(FlowLayout.CENTER,10,5));
                c.add(buttons,BorderLayout.SOUTH);
                
                MessageAction a=new MessageAction(dialog,outcome);
                MessageKeyListener mkl=new MessageKeyListener();
                
                JRootPane root = dialog.getRootPane();
                root.setBorder(new EmptyBorder(10,10,10,10));
                addButton(root,buttons,button,defButton,Button.OK,"OK",a,mkl);
                addButton(root,buttons,button,defButton,Button.YES,"Yes",a,mkl);
                addButton(root,buttons,button,defButton,Button.NO,"No",a,mkl);
                addButton(root,buttons,button,defButton,Button.ABORT,"Abort",a,mkl);
                addButton(root,buttons,button,defButton,Button.RETRY,"Retry",a,mkl);
                addButton(root,buttons,button,defButton,Button.CANCEL,"Cancel",a,mkl);
                addButton(root,buttons,button,defButton,Button.IGNORE,"Ignore",a,mkl);
                addButton(root,buttons,button,defButton,Button.HELP,"Help",a,mkl);

                if (icon!=null) {
                    ImageIcon ii = getIcon(icon,0,0);
                    if (ii!=null) {
                        JLabel img = new JLabel(ii);
                        c.add(img,BorderLayout.WEST);
                    }
                }

                dialog.validate();
                dialog.pack();
                dialog.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
                dialog.validate();

                Dimension size = dialog.getSize();

                int ils=getSize(last);
                int offset = size.height-ils;

                if (size.width>size.height*3) {

                    int resize = size.width/2;
                    
                    while (resize>0) {
                        
                        int diff = size.width-size.height*3;

                        if (diff<10 && diff>-10) break;
                        
                        if (diff>0) {
                            size.width-=resize;
                        } else {
                            size.width+=resize;
                        }

                        dialog.setSize(size);
                        dialog.validate();

                        resize=(resize-1)/2;
                        
                        int ls = getSize(last);
                        
                        size.height=ls+offset;

                        dialog.setSize(size);
                        dialog.validate();
                        size=dialog.getSize();
                    }
                    
                }
                
                Rectangle screen= dialog.getGraphicsConfiguration().getBounds();
                            
                dialog.setLocation(
                                    (screen.width-size.width)/2,
                                    (screen.height-size.height)/2);

                ClarionEventQueue.getInstance().setRecordState(false,"enter message");

                dialog.setVisible(true);

                if (r.holdingFrame!=null) r.holdingFrame.dispose();

                ClarionEventQueue.getInstance().setRecordState(true,"exit message");
            }

        };
        run(msgbox);
        
        int r = outcome.getOutcome(); 

        if (target!=null) {
            target.setActiveState(true);
        }
        
        return r; 
    }

    private class Root {
        private Frame frame;
        private Dialog dialog;
        private Frame holdingFrame;
    }
    
    private Root getRoot() {
        return getRoot(getTarget(1));
    }

    private Root getRoot(AbstractWindowTarget parent) {
        Root r = new Root();

        if (parent != null) {
            Component c = (Component) parent.getWindow();
            if (c instanceof Dialog) {
                r.dialog = (Dialog) c;
            }
            if (c instanceof Frame) {
                r.frame = (Frame) c;
            }
        }
        if (r.frame == null && r.dialog == null) {
            ClarionApplication base = getApp();
            if (base != null) {
                r.frame = (Frame) base.getWindow();
            }
            if (r.frame == null) {
                r.frame = new JFrame();
                r.holdingFrame=r.frame;
            }
        }

        return r;
    }

    public static void run(Runnable r) {
        if (SwingUtilities.isEventDispatchThread()) {
            r.run();
        } else {
            SwingUtilities.invokeLater(r);
        }
    }

    public static void runNow(Runnable r) {
        if (SwingUtilities.isEventDispatchThread()) {
            r.run();
        } else {
            try {
                SwingUtilities.invokeAndWait(r);
            } catch (InterruptedException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }
    }
    
    private Color desktopColor= new Color(0xc0c0c0);
    
    private Map<Font,Dimension> fontStats = new HashMap<Font, Dimension>(); 
    
    //@Override
    protected void open() {
        
        final AbstractWindowTarget target = getTarget();
        final AbstractWindowTarget parent = getTarget(1);

        final OpenMonitor monitor = new OpenMonitor();
        target.setOpenMonitor(monitor);        

        if (target.isProperty(Prop.MDI) && getApp()==null) {
            target.setProperty(Prop.MDI,0);
        }

        runNow(new Runnable() {
            public void run() {

                final Container win;
                final Container content;
                final JRootPane root;
                
        boolean desktop = false;
        
        if (target instanceof ClarionApplication) {
            final JFrame frame = new JFrame();
            frame.setTitle(target.getProperty(Prop.TEXT).toString());

            if (target.isProperty(Prop.ICON)) {
                frame.setIconImage(getImage(target.getProperty(Prop.ICON)
                        .toString(), -1, -1));
            }

            JDesktopPane dt = new ClarionDesktopPane();
            dt.setBackground(desktopColor);

            JScrollPane jsp = new JScrollPane(dt);
            jsp.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_AS_NEEDED);
            jsp.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);

            ClarionStatusPane csp = new ClarionStatusPane(target,jsp);
            target.setStatusPane(csp);
            frame.getContentPane().add(csp);
            
            frame.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);

            if (target.isProperty(Prop.MAXIMIZE)) {
                frame.setExtendedState(JFrame.MAXIMIZED_BOTH);
            }
            
            
            root = frame.getRootPane();
            content = frame.getContentPane();
            win = frame;
            ((ClarionApplication) target).setDesktopPane(dt);
            desktop = true;
        } else if (target.isProperty(Prop.MDI)) {

            final JDesktopPane desktopPane = getApp().getDesktopPane();

            if (parent != null && parent.getShadow()==null) {
                final JInternalFrame c = (JInternalFrame) parent.getWindow();

                JComponent canvas = new ShadowCanvas(); 
                canvas.putClientProperty("shadow", true);
                canvas.setSize(c.getSize());
                canvas.setLocation(c.getLocation());

                //desktopPane.add(canvas);
                //desktopPane.moveToFront(canvas);
                parent.setShadow(canvas);

                c.addVetoableChangeListener(FramePropertyListener.getInstance());
                ShadowGlass glass = new ShadowGlass();
                c.setGlassPane(glass);
                c.putClientProperty("shadow",Boolean.TRUE);
                glass.setVisible(true);
            }

            final JInternalFrame jif = new JInternalFrame();
            jif.setClosable(target.isProperty(Prop.SYSTEM));
            jif.setMaximizable(target.isProperty(Prop.MAX));
            jif.setResizable(target.isProperty(Prop.RESIZE));
            //jif.setIconifiable(target.isProperty(Prop.ICON));

            if (target.isProperty(Prop.ICON)) {
                String icon = target.getProperty(Prop.ICON).toString();
                jif.setFrameIcon(scale(getIcon(icon,16,16),icon,16,16));
            }

            String title = target.getProperty(Prop.TEXT).toString();
            if (title.length() > 0) {
                jif.setTitle(title);
            } else {
                jif.setTitle(null);
            }
            jif.setVisible(false);
            jif.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
            root = jif.getRootPane();

            content = new ClarionContentPane();
            jif.setContentPane(content);
            
            Color bg = getColor(target, Prop.BACKGROUND);
            if (bg != null) {
                content.setBackground(bg);
            }

            win = jif;
            desktopPane.add(jif);

            jif.addInternalFrameListener(new InternalFrameListener() {

                @Override
                public void internalFrameActivated(InternalFrameEvent e) {
                    getApp().getStatusPane().setChild(target);
                }

                @Override
                public void internalFrameClosed(InternalFrameEvent e) {
                    post(target, 0, null);
                    getApp().getStatusPane().setChild(parent);
                }

                @Override
                public void internalFrameClosing(InternalFrameEvent e) {
                    if (jif.getClientProperty("shadow")==null) {
                        postAsUser(target, Event.CLOSEWINDOW,null);
                    }
                }

                @Override
                public void internalFrameDeactivated(InternalFrameEvent e) {
                    getApp().getStatusPane().clearChild(target);
                }

                @Override
                public void internalFrameDeiconified(InternalFrameEvent e) {
                }

                @Override
                public void internalFrameIconified(InternalFrameEvent e) {
                }

                @Override
                public void internalFrameOpened(InternalFrameEvent e) {
                    monitor.setOpened();
                    getApp().getStatusPane().setChild(target);
                }
            });

        } else {
            String text = target.getProperty(Prop.TEXT).toString();

            Root r = getRoot(parent);
            target.setHoldingFrame(r.holdingFrame);

            content = new ClarionContentPane();
            Container con;
            if (text.length() == 0) {
                JWindow jw;
                if (r.dialog != null) {
                    jw = new JWindow(r.dialog);
                } else {
                    jw = new JWindow(r.frame);
                }
                win = jw;
                configureColor(jw, target);
                con=jw.getContentPane();
                root = jw.getRootPane();
            } else {
                JDialog jd;
                if (r.dialog != null) {
                    jd = new JDialog(r.dialog, text);
                    jd.setModalityType(ModalityType.APPLICATION_MODAL);
                } else {
                    jd = new JDialog(r.frame, text);
                }
                win = jd;
                jd.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
                jd.setResizable(target.isProperty(Prop.RESIZE));
                con=jd.getContentPane();
                configureColor(jd, target);
                root = jd.getRootPane();
            }
            
            //con.setLayout(new BorderLayout(0,0));
            ClarionStatusPane csp = new ClarionStatusPane(target,content);
            target.setStatusPane(csp);
            con.add(csp);
        }

        if (win instanceof Window) {

            
            ((Window) win).addWindowListener(new WindowListener() {

                boolean first=true;
                
                @Override
                public void windowActivated(WindowEvent e) {
                    if (!first) return;
                    first=false;
                    Window w=  e.getWindow();
                    if (w instanceof Frame) {
                        Frame f = (Frame)w;  
                        f.setAlwaysOnTop(true);
                        f.toFront();
                        w.setAlwaysOnTop(false);

                        if (!AbstractWindowTarget.suppressWindowSizingEvents) {                        
                            try {
                                Robot r = new Robot();
                                Point location = MouseInfo.getPointerInfo().getLocation();
                                Point locationOnScreen = w.getLocationOnScreen();
                                r.mouseMove(locationOnScreen.x + 100, locationOnScreen.y + 10);
                                r.mousePress(InputEvent.BUTTON1_MASK);
                                r.mouseRelease(InputEvent.BUTTON1_MASK);
                                r.mouseMove(location.x, location.y);
                            } catch (AWTException e1) {
                                e1.printStackTrace();
                            }
                        }
                    }
                }

                @Override
                public void windowClosed(WindowEvent e) {
                    post(target, 0,null);
                }

                @Override
                public void windowClosing(WindowEvent e) {
                    postAsUser(target, Event.CLOSEWINDOW,null);
                }

                @Override
                public void windowDeactivated(WindowEvent e) {
                }

                @Override
                public void windowDeiconified(WindowEvent e) {
                }

                @Override
                public void windowIconified(WindowEvent e) {
                }

                @Override
                public void windowOpened(WindowEvent e) {
                    e.getWindow().toFront();
                    monitor.setOpened();
                }
            });
        }

        if (target.isProperty(Prop.MODAL)) {
            if (win instanceof Window) {
                ((Window) win)
                        .setModalExclusionType(ModalExclusionType.APPLICATION_EXCLUDE);
            }
        }

        if (target.getRawProperty(Prop.FONTSTYLE,false)==null) {
            target.setProperty(Prop.FONTSTYLE,Font.PLAIN);
        }
        
        configureFont(content, target);
        Font f = content.getFont();

        Dimension fs;
        
        synchronized(fontStats) {
            fs = fontStats.get(f);
        }
        
        if (fs==null) {
            FontMetrics fm = win.getFontMetrics(f);
            int fw[] = fm.getWidths();
            int wsum = 0;
            int wcount = 0;
            int width = 0; 
            for (int scan = 0; scan < fw.length; scan++) {
                if (fw[scan] <= 1)
                    continue;
                wsum += fw[scan];
                wcount++;
            }
            width=(wsum+wcount-1)/wcount;
            
            fs = new Dimension(width,fm.getAscent()+fm.getDescent());
            
            synchronized(fontStats) {
                fontStats.put(f,fs);
            }
        }

        target.setFontDimensions(fs.width, fs.height);

        Insets ins;
        if (win instanceof Window) {
            ((Window)win).pack();
            ins = win.getInsets();
        } else {
            Component s = content;
            int left=0,right=0,top=0,bottom=0;
            while (true ) {
                left+=s.getX();
                top+=s.getY();
                ins=((Container)s).getInsets();
                left+=ins.left;
                right+=ins.right;
                top+=ins.top;
                bottom+=ins.bottom;
                if (s==win) break;
                s=s.getParent();
            }
            ins = new Insets(top,left,bottom,right);
        }

        target.setInsets(ins);

        {
            ClarionObject x = target.getRawProperty(Prop.XPOS);
            ClarionObject y = target.getRawProperty(Prop.YPOS);

            if (x==null && parent!=null) x=parent.getProperty(Prop.XPOS).add(10);
            if (y==null && parent!=null) y=parent.getProperty(Prop.YPOS).add(10);
            
            if (x != null && y != null) {
                win.setLocation(toPixels(target, x.intValue(), y.intValue()));
            }

            ClarionObject w = target.getRawProperty(Prop.WIDTH);
            ClarionObject h = target.getRawProperty(Prop.HEIGHT);

            if (w == null || h == null) {
                
                int maxX=0;
                int maxY=0;
                
                ControlIterator ci = new ControlIterator(target);
                ci.setScanDisabled(true);
                ci.setScanHidden(true);
                ci.setScanSheets(true);
                
                while (ci.hasNext()) {
                    AbstractControl ac = ci.next();
                    
                    
                    int sum;
                    ClarionObject inc;

                    sum=0;
                    inc=ac.getRawProperty(Prop.XPOS,false);
                    if (inc!=null) sum+=inc.intValue();
                    inc=ac.getRawProperty(Prop.WIDTH,false);
                    if (inc!=null) sum+=inc.intValue();
                    if (sum>maxX) maxX=sum;

                    sum=0;
                    inc=ac.getRawProperty(Prop.YPOS,false);
                    if (inc!=null) sum+=inc.intValue();
                    inc=ac.getRawProperty(Prop.HEIGHT,false);
                    if (inc!=null) sum+=inc.intValue();
                    if (sum>maxY) maxY=sum;
                }
                
                if (w==null) w=new ClarionNumber(maxX);
                if (h==null) h=new ClarionNumber(maxY);
            }

            if (w != null && h != null) {

                Point p = toPixels(target, w.intValue(), h.intValue());
                p.x += ins.left+ins.right;
                p.y += ins.top+ins.bottom;

                win.setSize(p.x, p.y);

                if (target.isProperty(Prop.CENTER)) {
                    if (target.isProperty(Prop.MDI)) {
                        Dimension r= getApp().getDesktopPane().getSize();
                        win.setLocation((r.width - p.x) / 2, (r.height - p.y) / 2-10);
                    } else {
                        Rectangle r = win.getGraphicsConfiguration().getBounds();
                        win.setLocation((r.width - p.x) / 2, (r.height - p.y) / 2);
                    }
                }
            }
        }


        target.setWindow(win);
        target.setRootPane(root);
        target.setContentPane(content);

        if (!desktop) setupContainer(content);
        win.setFocusTraversalPolicy(new ClarionFocusTraversalPolicy(target));

        setKey(target, win, true, false, null);
        setKey(target, root, true, false, null);

        for (AbstractControl ac : target.getControls()) {
            createControl(ac,content);
        }
        
        setDefaultButton(target);
        
        } });

    }

    private void setupContainer(Container win) {
        win.setLayout(new ClarionLayoutManager());
    }

    public void createControl(AbstractControl ac, Container parent) 
    {
        ac.constructSwingComponent(parent);
    }
    
    private boolean isActionKey(KeyEvent e)
    {
        if ((e.getModifiersEx() & KeyEvent.CTRL_DOWN_MASK)!=0) return true;
        
        if (e.getKeyChar()!=KeyEvent.CHAR_UNDEFINED) {
            if (e.getKeyChar()=='\n') return true;
            return false;
        } else {
            if (e.getKeyCode()=='\n' && e.getModifiersEx()==0) return true;
            return e.isActionKey();
        }
    }
    
    public void setKey(final AbstractWindowTarget ctl, final Component comp,
            final boolean allowSimple, final boolean postAlways,
            final AbstractControl start) 
    {
        comp.addKeyListener(new KeyListener() {

            public void handleEvent(KeyEvent e) {

                
                SwingKeyCodes skc = SwingKeyCodes.getInstance();
                int key = skc.toClarionCode(e);
                int keyChar = skc.toClarionChar(e);
                int state = skc.toClarionState(e);

                // AbstractWindowTarget ctl = ac.getWindowOwner();
                ctl.setKeyCode(key);
                ctl.setKeyState(state);
                ctl.setKeyChar(keyChar);

                if (e.isConsumed()) return;

                if (e.getKeyCode()==KeyEvent.VK_F2 && (e.getModifiersEx() & KeyEvent.CTRL_DOWN_MASK)!=0) {
                    new org.jclarion.clarion.swing.winedit.EditTool(ctl); 
                    e.consume();
                    return;
                }

                if (e.getKeyCode()==KeyEvent.VK_F3 && (e.getModifiersEx() & KeyEvent.CTRL_DOWN_MASK)!=0) {
                    org.jclarion.clarion.crash.Crash.getInstance().crashDetailed(); 
                    e.consume();
                    return;
                }
                

                boolean alert = false;
                AbstractControl atarget = null;
                if (start != null && start.isAlertKey(key)) {
                    alert = true;
                    atarget = start;
                }
                if (!alert) {
                    if (ctl.isAlertKey(key)) {
                        alert = true;
                    }
                }

                if (alert) {

                    KeyedClarionEvent kce; 
                    kce = new KeyedClarionEvent(
                            Event.PREALERTKEY,atarget,true,key,keyChar,state);
                    ctl.post(kce);
                    if (!kce.getConsumeResult()) {
                    } else {
                        e.consume();
                    }
                    
                    kce = new KeyedClarionEvent(
                            Event.ALERTKEY,atarget,true,key,keyChar,state);
                    ctl.post(kce);
                    return;
                }

                // check for hot keys
                if (handleMnemonic(e)) return;

                // check for other specials
                if (e.getKeyChar() == 27) {
                    e.consume();
                    ctl.post(Event.CLOSEWINDOW);
                    return;
                }

                if (postAlways) {
                    
                    if (isActionKey(e)) return;

                    /*
                    // TODO - maybe action keys only
                    switch (e.getKeyCode()) {
                        case KeyEvent.VK_LEFT: 
                        case KeyEvent.VK_RIGHT:
                        case KeyEvent.VK_ENTER:
                            return;
                    }
                    
                    if (e.getKeyChar()==KeyEvent.VK_ENTER) {
                        return;
                    }
                    */
                    
                    e.consume();
                    // clarion doco says it is NEWSELECTION, but
                    // test 5.5 code actually generates alert key events
                    post(ctl, Event.ALERTKEY, start);
                }
            }

            private boolean handleMnemonic(KeyEvent e) {
                MnemonicConfig md = getMnemonic(ctl, false);
                if (md == null)
                    return false;
                int mkey = SwingKeyCodes.getInstance().toClarionCode(e);

                if (mkey >= 'A' && mkey <= 'Z') {
                    // only interesting if we are in any of the following
                    // controls: Button, Option, Check

                    // if (!(ac instanceof SimpleMnemonicAllowed)) return;
                    if (!allowSimple)
                        return false;
                }

                if (!md.isKeyOfInterest(mkey)) {
                    return false;
                }

                ControlIterator ci = null;

                if (start != null) {
                    ci = new ControlIterator(start, false);
                } else {
                    ci = new ControlIterator(ctl);
                }

                while (ci.hasNext()) {
                    AbstractControl candidate = ci.next();
                    MnemonicConfig.Entry entry = md.match(candidate, mkey);
                    if (entry != null) {

                        if (entry.offset > 0) {
                            ControlIterator si = new ControlIterator(candidate,
                                    false);
                            si.setScanSheets(true);
                            for (int scan = 0; scan < entry.offset; scan++) {
                                candidate = si.next();
                            }
                        }
                        if (candidate != null) {
                            if (entry.mode == Mode.SELECTONLY) {
                                select(candidate);
                            } else {
                                selectAndAccept(candidate);
                            }
                            e.consume();
                            return true;
                        }
                    }
                }
                return false;
            }

            public void keyPressed(KeyEvent e) 
            {
                if (isActionKey(e)) {
                    handleEvent(e);
                }
            }

            public void keyReleased(KeyEvent e) {
            }

            public void keyTyped(KeyEvent e) {
                if (!isActionKey(e)) {
                    handleEvent(e);
                }
            }

        });

        setMouseAlerts(start, comp);
    }

    private void setMouseAlerts(final AbstractControl control, final Component c) {
        if (control == null)
            return;
        registerMouseAlerts(control, c);
        control.addListener(new PropertyObjectListener() {
            @Override
            public Object getProperty(PropertyObject owner, int property) {
                return null;
            }

            @Override
            public void propertyChanged(PropertyObject owner, int property,
                    ClarionObject value) {
                if (property == Prop.ALRT) {
                    registerMouseAlerts(control, c);
                }
            }
        });
    }

    private void registerMouseAlerts(final AbstractControl control,
            final Component c) 
    {
        if (!control.isMouseAlert()) return;
        if (control.isMouseAlertsEnabled()) return;
        control.setMouseAlertsEnabled(true);

        MouseListener ml = new MouseListener() {

            @Override
            public void mouseClicked(MouseEvent e) {

                int code = 0;

                switch (e.getClickCount()) {
                case 1:
                    switch (e.getButton()) {
                    case MouseEvent.BUTTON1:
                        code = Constants.MOUSELEFT;
                        break;
                    case MouseEvent.BUTTON2:
                        code = Constants.MOUSECENTER;
                        break;
                    case MouseEvent.BUTTON3:
                        code = Constants.MOUSERIGHT;
                        break;
                    }
                    break;
                case 2:
                    switch (e.getButton()) {
                    case MouseEvent.BUTTON1:
                        code = Constants.MOUSELEFT2;
                        break;
                    case MouseEvent.BUTTON2:
                        code = Constants.MOUSECENTER2;
                        break;
                    case MouseEvent.BUTTON3:
                        code = Constants.MOUSERIGHT2;
                        break;
                    }
                    break;
                }

                if (code == 0)
                    return;

                if (control.isAlertKey(code)) {

                    control.getWindowOwner().setKeyCode(code);

                    if (!control.postAndWait(Event.PREALERTKEY)) {
                            
                    } else {
                        e.consume();
                    }
                    
                    // generate post irrespective of whether or not 
                    // pre-alert was eaten
                    post(control.getWindowOwner(), Event.ALERTKEY, control);
                }
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
        };

        c.addMouseListener(ml);
    }



    public void select(int control) {
        select(getTarget().getControl(control));
    }
    
    private static class SelectProcess implements Runnable
    {
        private AbstractControl control;
        private Component       c;
        private AbstractControl last;
        private AbstractControl scan;
        private int             pos;
        private Container       win;
        
        public SelectProcess(AbstractControl control)
        {
            this.control=control;
        }
        
        public void run()
        {
            c = control.getComponent();
            if (c == null) {
                c = (Component) control.getParent().getComponent();
            }
            
            win = (Container) control.getWindowOwner().getWindow();
            if (win == null) return;
            
            last = null;
            scan = control;
            
            doScanLoop();
        }
        
        public void doScanLoop()
        {
            while (scan != null) {
                if (scan instanceof SheetControl) {
                    if (last != null) {
                        pos = scan.getChildIndex(last) + 1;
                        int cpos = scan.getProperty(Prop.SELSTART).intValue();
                        if (cpos != pos) {
                            
                            SheetControl sc = (SheetControl)scan;
                            
                            sc.forceUpdate();
                            sc.changeValue(pos,new Runnable() {
                                @Override
                                public void run() {
                                    if (scan.getProperty(Prop.SELSTART).intValue() != pos) return;
                                    last = scan;
                                    scan = scan.getParent();
                                    doScanLoop();
                                } });
                            return;
                        }
                    }
                }
                last = scan;
                scan = scan.getParent();
            }
            
            Runnable r = new Runnable() {
                public void run()
                {
                    ClarionFocusTraversalPolicy cftp = (ClarionFocusTraversalPolicy) win.getFocusTraversalPolicy();
                    if (!cftp.accept(c, null)) {
                        Container base = c.getFocusCycleRootAncestor();
                        c = base.getFocusTraversalPolicy().getComponentAfter(base,c);
                    }

                    if (c != null) {
                        c.requestFocusInWindow();
                    }
                }
            };
            CWinImpl.run(r);
        }
    }

    public void select(final AbstractControl control)
    {
        AbstractWindowTarget awt = control.getWindowOwner();
        if (awt.getOpenMonitor()!=null) {
            awt.setInitialSelectControl(control);
            run(new SelectProcess(control));
        } else {
            (new SelectProcess(control)).run();
        }
    }


    //@Override
    public void selectAndAccept(AbstractControl control) {

        final AbstractControl prior = control.getWindowOwner().getCurrentFocus();
        if (prior != null) {
            SwingAccept a = prior.getAccept();
            if (a != null) {
                if (!a.accept(false)) return;
            }
        }

        control.accept();
    }

    public void configureColor(JWindow jw, PropertyObject target) {
        Color c;
        c = getColor(target, Prop.FONTCOLOR);
        if (c != null)
            jw.setForeground(c);
        c = getColor(target, Prop.BACKGROUND);
        if (c != null)
            jw.setBackground(c);
    }

    public void configureColor(JDialog jw, PropertyObject target) {
        Color c;
        c = getColor(target, Prop.FONTCOLOR);
        if (c != null)
            jw.setForeground(c);
        c = getColor(target, Prop.BACKGROUND);
        if (c != null)
            jw.setBackground(c);
    }

    public void configureColor(JComponent jw, PropertyObject target) {
        Color c;
        c = getColor(target, Prop.FONTCOLOR);
        if (c != null)
            jw.setForeground(c);
        c = getColor(target, Prop.BACKGROUND);
        if (c != null)
            jw.setBackground(c);
    }

    public Color getColor(PropertyObject object, int property) {
        return getColor(object.getRawProperty(property));
    }

    public Color getNestedColor(PropertyObject object, int property) {
        
        while ( object!=null ) {
            Color c = getColor(object,property);
            if (c!=null) return c;
            object=object.getParentPropertyObject();
        }
        return null;
    }

    public Color getColor(ClarionObject color) {
        if (color == null)
            return null;

        int val = color.intValue();
        return getColor(val);
    }
    
    public Color getUIColor(String... colors)
    {
        for (int scan=0;scan<colors.length;scan++) {
            Color c = UIManager.getColor(colors[scan]);
            if (c!=null) return c;
        }
        return null;
    }

    public Color getColor(int val) {
        switch (val) {
        case org.jclarion.clarion.constants.Color.ACTIVEBORDER:
            return getUIColor("activeCaptionBorder");
        case org.jclarion.clarion.constants.Color.ACTIVECAPTION:
            return getUIColor("activeCaption","nimbusBase");
        case org.jclarion.clarion.constants.Color.APPWORKSPACE:
            return getUIColor("Desktop.background","desktop");
        case org.jclarion.clarion.constants.Color.BACKGROUND:
            return getUIColor("Label.background","background");
        case org.jclarion.clarion.constants.Color.BTNFACE:
            return getUIColor("Button.background");
        case org.jclarion.clarion.constants.Color.BTNHIGHLIGHT:
            return getUIColor("Button.highlight","controlHighlight");
        case org.jclarion.clarion.constants.Color.BTNSHADOW:
            return getUIColor("Button.shadow","controlShadow");
        case org.jclarion.clarion.constants.Color.BTNTEXT:
            return getUIColor("Button.foreground","Button.textForeground");
        case org.jclarion.clarion.constants.Color.CAPTIONTEXT:
            return getUIColor("activeCaptionText","InternalFrame.foreground");
        case org.jclarion.clarion.constants.Color.GRAYTEXT:
            return getUIColor("textInactiveText","textInactiveText");
        case org.jclarion.clarion.constants.Color.HIGHLIGHT:
            return getUIColor("textHighlight");
        case org.jclarion.clarion.constants.Color.HIGHLIGHTTEXT:
            return getUIColor("textHighlightText");
        case org.jclarion.clarion.constants.Color.INACTIVEBORDER:
            return getUIColor("inactiveCaptionBorder");
        case org.jclarion.clarion.constants.Color.INACTIVECAPTION:
            return getUIColor("inactiveCaption","InternalFrame.disabled");
        case org.jclarion.clarion.constants.Color.INACTIVECAPTIONTEXT:
            return getUIColor("inactiveCaptionText","InternalFrame.disabledText");
        case org.jclarion.clarion.constants.Color.MENU:
            return getUIColor("Menu.background");
        case org.jclarion.clarion.constants.Color.MENUTEXT:
            return getUIColor("Menu.foreground");
        case org.jclarion.clarion.constants.Color.NONE:
            return null;
        case org.jclarion.clarion.constants.Color.SCROLLBAR:
            return getUIColor("ScrollBar.background");
        case org.jclarion.clarion.constants.Color.WINDOW:
            return getUIColor("window","InternalFrame.background");
        case org.jclarion.clarion.constants.Color.WINDOWFRAME:
            return getUIColor("windowBorder","nimbusDisabledText");
        case org.jclarion.clarion.constants.Color.WINDOWTEXT:
            return getUIColor("windowText","InternalFrame.foreground");
        }

        int rval = (((val >> 0) & 0xff) << 16) + (((val >> 8) & 0xff) << 8)
                + (((val >> 16) & 0xff) << 0);

        return new Color(rval);
    }

    public void configureFont(final Component component, final PropertyObject o) {
        o.addListener(new PropertyObjectListener() {

            @Override
            public Object getProperty(PropertyObject owner, int property) {
                return null;
            }

            @Override
            public void propertyChanged(PropertyObject owner, int property,
                    ClarionObject value) {
                switch (property) {
                case Prop.FONTNAME:
                case Prop.FONTSIZE:
                case Prop.FONTSTYLE:
                    changeFont(component, o);
                }
            }
        });

        changeFont(component, o);
    }

    public void changeFont(final Component component, final PropertyObject o) {
        Font f=  getFontOnly(component,o);
        if (f!=null) {
            component.setFont(f);
        }
    }

    private static double fontResize;
    
    static {
        //fontResize="gnome".equals(System.getProperty("sun.desktop"))?1.5:1.0;
        fontResize=1.4;
        
        String fr = System.getProperty("clarion.fontsize");
        if (fr!=null) {
            fontResize=Double.valueOf(fr);
        }
    };
    
    public Font getFontOnly(final Component component, final PropertyObject o) {
        return getFontOnly(component,o,fontResize);
    }

    public Font getFontOnly(final Component component, final PropertyObject o,double scale) {
        Font f = null;
        if (component!=null) f = component.getFont();

        ClarionObject p_face = o.getInheritedProperty(Prop.FONTNAME);
        ClarionObject p_size = o.getInheritedProperty(Prop.FONTSIZE);
        ClarionObject p_style = o.getInheritedProperty(Prop.FONTSTYLE);

        if (p_face == null && p_size == null && p_style == null)
            return null;

        String face = null;
        int size = 0;
        int style = 0;

        if (p_face != null) {
            face = p_face.toString();
        } else if (f!=null) {
            face = f.getFontName();
        } else {
            face="Monospaced";
        }

        if (p_size != null) {
            size = (int) (p_size.intValue() * scale );
        } else if (f!=null)  {
            size = f.getSize();
        } else {
            size=(int)(10*scale);
        }

        if (p_style != null) {
            int cl_style = p_style.intValue();
            style = 0;
            if ((cl_style & org.jclarion.clarion.constants.Font.BOLD) == org.jclarion.clarion.constants.Font.BOLD)
                style |= Font.BOLD;
            if ((cl_style & org.jclarion.clarion.constants.Font.ITALIC) == org.jclarion.clarion.constants.Font.ITALIC)
                style |= Font.ITALIC;
        } else if (f!=null)  {
            style = f.getStyle();
        } else {
            style = Font.PLAIN;
        }

        face = convertFace(face);

        Font nf = new Font(face, style, size);
        return nf;
    }

    boolean logged = false;

    private Map<String,String> fontFaces;
    
    public String convertFace(String face) {
        
        if (fontFaces==null) {
            fontFaces=new HashMap<String,String>();
            Font fonts[] = GraphicsEnvironment.getLocalGraphicsEnvironment().getAllFonts();
            for (Font font : fonts ) {
                fontFaces.put(font.getFontName().toLowerCase().trim(),font.getFontName());
            }
        }
        
        String oface=face;
        face = face.toLowerCase();
        if (face.equals("ms sans serif")) face="microsoft sans serif";
        
        String result = fontFaces.get(face.trim().toLowerCase());
        if (result!=null) return result;

        while ( true ) {
            
            
            if (face.indexOf("sans") > -1 && face.indexOf("serif") > -1) {
                result="SansSerif";
                break;
            }

            if (face.indexOf("sans") > -1) {
                result="Sans";
                break;
            }
            if (face.indexOf("serif") > -1) {
                result="Serif";
                break;
            }

            if (face.indexOf("courier") > -1) {
                result="Monospaced";
                break;
            }
            
            result=oface;
            
            break;
        }
        
        log.warning("Font Unknown :"+oface+" using: "+result);
        fontFaces.put(face,result);
        return result;
    }

    public static Point toPixels(AbstractWindowTarget win, int x, int y) {
        Point p = new Point(x, y);
        return toPixels(win, p);
    }

    public static Point toPixels(AbstractWindowTarget win, Point p) {
        p.x = win.widthDialogToPixels(p.x);
        p.y = win.heightDialogToPixels(p.y);
        return p;
    }

    public static Point toPixels(AbstractControl c, Point p) {
        return toPixels(c.getWindowOwner(), p);
    }

    public void post(AbstractWindowTarget awt, int event,AbstractControl field) {
        awt.post(new ClarionEvent(event, field, true));
    }

    public void postAsUser(AbstractWindowTarget awt, int event,AbstractControl field) {
        awt.post(new ClarionEvent(event, field, false));
    }

    public boolean postAndWait(AbstractWindowTarget awt, int event,AbstractControl field) {
        ClarionEvent ce = new ClarionEvent(event, field, true);
        awt.post(ce);
        return ce.getConsumeResult();
    }

    public MnemonicConfig getMnemonic(AbstractWindowTarget po, boolean create) 
    {
        return po.getMnemonic(create);
    }

    private Map<String, Integer> cursorMap;

    //@Override
    public void setCursor(String cursor) {

        if (cursorMap == null) {
            cursorMap = new HashMap<String, Integer>();
            cursorMap.put("\u00ff\u0001\u0001\u007f", Cursor.DEFAULT_CURSOR);
            cursorMap.put("\u00ff\u0001\u0002\u007f", Cursor.TEXT_CURSOR);
            cursorMap.put("\u00ff\u0001\u0003\u007f", Cursor.WAIT_CURSOR);
            cursorMap.put("\u00ff\u0001\u0004\u007f", Cursor.CROSSHAIR_CURSOR);
            // cursorMap.put("\u00ff\u0001\u0005\u007f",Cursor.???); // up arrow
            cursorMap.put("\u00ff\u0001\u0081\u007f", Cursor.MOVE_CURSOR);

            // cursorMap.put("\u00ff\u0001\u0082\u007f",Cursor.CUSTOM_CURSOR);
            // // icon

            cursorMap.put("\u00ff\u0001\u0083\u007f", Cursor.NW_RESIZE_CURSOR); // SIZE
            // NW
            // +
            // SE
            cursorMap.put("\u00ff\u0001\u0084\u007f", Cursor.NE_RESIZE_CURSOR); // SIZE
            // NE
            // +
            // SW
            cursorMap.put("\u00ff\u0001\u0085\u007f", Cursor.E_RESIZE_CURSOR); // SIZE
            // W
            // +
            // E
            cursorMap.put("\u00ff\u0001\u0086\u007f", Cursor.N_RESIZE_CURSOR); // SIZE
            // N
            // +
            // S

            cursorMap.put("\u00ff\u0002\u0001\u007f", Cursor.MOVE_CURSOR); // drag
            // cursorMap.put("\u00ff\u0002\u0002\u007f",Cursor.???); // drop
            cursorMap.put("\u00ff\u0002\u0003\u007f", Cursor.HAND_CURSOR); // no
            // drop
            // cursorMap.put("\u00ff\u0002\u0004\u007f",Cursor.???); // zoom
        }

        Cursor c = null;

        if (cursor != null) {
            Integer id = cursorMap.get(cursor);
            if (id != null) {
                c = Cursor.getPredefinedCursor(id.intValue());
            }
        }
        
        AbstractWindowTarget target = getTarget();
        if (target!=null) {
            Container con = (Container)target.getWindow();
            if (con!=null) con.setCursor(c);
        }
    }

    public java.awt.Image getImage(String name, int prefx, int prefy) 
    {
        if (name.startsWith("print:/")) {

            name=name.trim();
            
            int scalePos = name.indexOf("#");
            int scale=100;
            if (scalePos>-1) {
                scale=Integer.parseInt(name.trim().substring(scalePos+1));
                name=name.substring(0,scalePos);
            }
            
            int page = Integer.parseInt(name.substring(7));
            Page p = (Page)CMemory.resolveAddress(page);
            
            Dimension d = p.getGraphicsSize();
            
            while ( true ) {
                try {
                    BufferedImage bi = new BufferedImage(d.width*scale/100,d.height*scale/100,BufferedImage.TYPE_BYTE_GRAY); //TYPE_INT_ARGB);
                    Graphics2D g2d = (Graphics2D)bi.getGraphics(); 
                    g2d.setColor(Color.white);
                    g2d.fillRect(0,0,d.width*scale/100,d.height*scale/100);
                    g2d.scale(scale/100f,scale/100f);
                    g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING,RenderingHints.VALUE_ANTIALIAS_ON);
                    g2d.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
                    p.print(new AWTPrintContext(g2d));
                    return bi;
                } catch (OutOfMemoryError ex ) {
                    scale=scale/2;
                }
            }
        }
        
        String cache = getImageURL(name)+"_p"+prefx+"_p"+prefy;
        Image i=getImageFromCache(cache);
        if (i!=null) return i;
        
        if (name.equals(Icon.NONE)) return null;
        
        i = getMicrosoftIcon(name, prefx, prefy);
        if (i != null) {
            addImagetoCache(cache,i);
            return i;
        }

        //ClassLoader cl = Thread.currentThread().getContextClassLoader();
        ClassLoader cl = getClass().getClassLoader();
        InputStream is = cl.getResourceAsStream(getImageURL(name));
        
        /*
        if (is==null) {
            is = cl.getResourceAsStream("resources/"+getImageURL(name));
        }
        */
        
        if (is == null) {
            log.warning("Icon Not Found!:"+name+" ("+getImageURL(name)+")");
            return null;
        }

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte buffer[] = new byte[512];
        while (true) {
            try {
                int count = is.read(buffer);
                if (count == -1)
                    break;
                baos.write(buffer, 0, count);
            } catch (IOException e) {
                e.printStackTrace();
                break;
            }
        }

        i=Toolkit.getDefaultToolkit().createImage(baos.toByteArray());
        addImagetoCache(cache,i);
        return i;
    }
    
    private Map<String,Image> imageCache=new HashMap<String, Image>();

    private void addImagetoCache(String cache, Image i) {
        imageCache.put(cache,i);
    }

    private Image getImageFromCache(String cache) {
        return imageCache.get(cache);
    }

    public javax.swing.ImageIcon getIcon(String name, int prefx, int prefy) 
    {
        if (name.equals(Icon.NONE)) return null;
        return new ImageIcon(getImage(name,prefx,prefy));
    }

    public javax.swing.ImageIcon scale(javax.swing.ImageIcon icon,String name,int sx,
            int sy) 
    {
        return new ImageIcon(scale(icon.getImage(),name,sx,sy));
    }

    private static class WaitingImageObserver implements ImageObserver
    {
        private boolean done;

        @Override
        public boolean imageUpdate(Image img, int infoflags, int x, int y,
                int width, int height) 
        {
            if ((infoflags & (ImageObserver.ALLBITS|ImageObserver.FRAMEBITS|ImageObserver.ERROR))!=0) {
                synchronized(this) {
                    done=true;
                    notifyAll();
                }
                return false;
            }
            return true;
        }
        
        public boolean waitTillDone()
        {
            long limit=System.currentTimeMillis()+5000;
            
            synchronized(this) {
                while (!done) {
                    try {
                        long until = limit-System.currentTimeMillis();
                        if (until<=0) return false;
                        wait(until);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
            return true;
        }
    }
    
    public BufferedImage scale(java.awt.Image bi, String name,int sx, int sy) {
        if (bi == null) return null;
        name=getImageURL(name)+"_sx"+sx+"_sy"+sy;
        BufferedImage cache = (BufferedImage)getImageFromCache(name);
        if (cache!=null) return cache;
        
        Image i = bi.getScaledInstance(sx, sy, Image.SCALE_AREA_AVERAGING);

        BufferedImage scale = new BufferedImage(16, 16,
                BufferedImage.TYPE_4BYTE_ABGR);
        
        Graphics g = scale.createGraphics();
        WaitingImageObserver wio=new WaitingImageObserver();
        if (!g.drawImage(i, 0, 0, wio)) {
            if (!wio.waitTillDone()) {
                log.warning("Problem scaling:"+name);
            }
            g.drawImage(i, 0, 0,null);
        }

        addImagetoCache(name,scale);
        return scale;
    }

    private java.awt.Image getMicrosoftIcon(String name, int prefx, int prefy) {

        name=name.toLowerCase();
        
        if (name.endsWith(".bmp")) {
            name = getImageURL(name);

            ClassLoader cl = getClass().getClassLoader();
            try {
                InputStream is = cl.getResourceAsStream(name);
                if (is == null) return null;
                return net.sf.image4j.codec.bmp.BMPDecoder.read(is);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        if (name.endsWith(".ico")) {
            name = getImageURL(name);

            ClassLoader cl = getClass().getClassLoader();
            java.util.List<BufferedImage> bits;
            try {
                InputStream is = cl.getResourceAsStream(name);
                if (is == null) return null;
                bits = net.sf.image4j.codec.ico.ICODecoder.read(is);

                int sel = 0;
                int best = Integer.MAX_VALUE;

                if (prefx > 0 && prefy > 0) {
                    for (int scan = 0; scan < bits.size(); scan++) {
                        BufferedImage bi = bits.get(scan);
                        int matchx = bi.getWidth() - prefx;
                        int matchy = bi.getHeight() - prefy;
                        int match = matchx * matchx + matchy * matchy;
                        if (match < best) {
                            sel = scan;
                            best = match;
                        }
                    }
                }

                BufferedImage bi = bits.get(sel);
                return bi;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    private static Map<String, String> clarionIcons;
    static {
        clarionIcons = new HashMap<String, String>();
        clarionIcons.put(Icon.APPLICATION, "resources/images/clarion/application.png");
        clarionIcons.put(Icon.HAND, "resources/images/clarion/hand.png");
        clarionIcons.put(Icon.QUESTION, "resources/images/clarion/question.png");
        clarionIcons.put(Icon.EXCLAMATION, "resources/images/clarion/exclamation.png");
        clarionIcons.put(Icon.ASTERISK, "resources/images/clarion/asterisk.png");
        clarionIcons.put(Icon.PICK, "resources/images/clarion/pick.png");
        clarionIcons.put(Icon.SAVE, "resources/images/clarion/save.png");
        clarionIcons.put(Icon.PRINT, "resources/images/clarion/print.png");
        clarionIcons.put(Icon.PASTE, "resources/images/clarion/paste.png");
        clarionIcons.put(Icon.OPEN, "resources/images/clarion/open.png");
        clarionIcons.put(Icon.NEW, "resources/images/clarion/new.png");
        clarionIcons.put(Icon.HELP, "resources/images/clarion/help.png");
        clarionIcons.put(Icon.CUT, "resources/images/clarion/cut.png");
        clarionIcons.put(Icon.COPY, "resources/images/clarion/copy.png");
        clarionIcons.put(Icon.ZOOM, "resources/images/clarion/zoom.png");
        clarionIcons.put(Icon.NEXTPAGE, "resources/images/clarion/nextpage.png");
        clarionIcons.put(Icon.PREVPAGE, "resources/images/clarion/prevpage.png");
        clarionIcons.put(Icon.JUMPPAGE, "resources/images/clarion/jumppage.png");
        clarionIcons.put(Icon.TICK, "resources/images/clarion/tick.png");
        clarionIcons.put(Icon.CROSS, "resources/images/clarion/cross.png");
        clarionIcons.put(Icon.CONNECT, "resources/images/clarion/connect.png");
        clarionIcons.put(Icon.PRINT1, "resources/images/clarion/print1.png");
        clarionIcons.put(Icon.ELLIPSIS, "resources/images/clarion/ellipsis.png");
        clarionIcons.put(Icon.VCRTOP, "resources/images/clarion/vcrtop.png");
        clarionIcons.put(Icon.VCRREWIND, "resources/images/clarion/vcrrewind.png");
        clarionIcons.put(Icon.VCRPLAY, "resources/images/clarion/vcrplay.png");
        clarionIcons.put(Icon.VCRBACK, "resources/images/clarion/vcrback.png");
        clarionIcons.put(Icon.VCRFASTFORWARD,
                "resources/images/clarion/vcrfastforward.png");
        clarionIcons.put(Icon.VCRBOTTOM, "resources/images/clarion/vcrbottom.png");
    }

    public String getImageURL(String name) {

        String result = clarionIcons.get(name);
        if (result != null) {
            return result;
        }

        name = name.toLowerCase();
        name=name.trim();
        int pos = name.lastIndexOf('/') + 1;
        int pos2 = name.lastIndexOf('\\') + 1;
        if (pos2 > pos)
            pos = pos2;
        return "resources/images/" + name.substring(pos);
    }

    public void debugStack() {
        log.info(stack.toString());
    }
    
}
