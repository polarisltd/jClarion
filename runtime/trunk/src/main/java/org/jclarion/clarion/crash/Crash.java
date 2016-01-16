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
package org.jclarion.clarion.crash;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Container;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Map.Entry;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.SwingConstants;
import javax.swing.border.EmptyBorder;

import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;


public class Crash implements Runnable 
{
    public static void main(String args[]) {
        try {
            throw new RuntimeException("Hello");
        } catch (Throwable t) {
            getInstance().log(t);
        }
        getInstance().crash();
    }
    
    private static Crash        instance;
    
    public static Crash getInstance()
    {
        if (instance==null) {
            synchronized(Crash.class) {
                if (instance==null) {
                    instance=new Crash();
                }
            }
        }
        return instance;
    }
    
    private StringBuilder log;
    private CrashStream  stream;
    private List<CrashContributor> contributors=new ArrayList<CrashContributor>();
    private Properties      crashResources;
    
    public Crash()
    {
        InputStream is = getClass().getClassLoader().getResourceAsStream("resources/crash.properties");
        crashResources=new Properties();
        if (is!=null) {
            try {
                crashResources.load(is);
            } catch (IOException ex) { }
            try {
                is.close();
            } catch (IOException ex) { }
        }
        
        log=new StringBuilder();
        CharArrayWriter caw = new CharArrayWriter();
        try {
            System.getProperties().store(caw,"Crash Log");
        } catch (IOException e) {
            e.printStackTrace();
        }
        log.append(caw.toString());
        log.append("\n==============\n");
        
        CRun.addShutdownHook(new Runnable() { 
            public void run()
            {
                instance=null;
            }
        } );
    }
    
    public void registerContributor(CrashContributor contributor)
    {
        synchronized(contributors) {
            contributors.add(contributor);
        }
    }
    
    public void setCrashStream(CrashStream stream)
    {
        this.stream=stream;
    }
    
    public void crashDetailed()
    {
        log(CWin.getInstance().getDebugMetaData());
        crash();
    }
    
    public void log(String entry)
    {
        synchronized(log) {
            log.append(entry).append('\n');
        }
    }

    public void log(int b) {
        synchronized(log) {
            log.append((char)b);
        }
    }

    public void log(byte b[],int ofs,int len) {
        synchronized(log) {
            for (int scan=0;scan<len;scan++) {
                log.append((char)b[ofs+scan]);
            }
        }
    }
    
    public void log(Throwable t)
    {
        synchronized(log) {
            log.append(t.toString()).append('\n');
            for (StackTraceElement e : t.getStackTrace()) {
                log.append("  ").append(e.toString()).append("\n");
            }
        }
    }

    private JLabel          labelb;
    private Thread          upload;

    public String getResourceString(String key,String def)
    {
        String result = crashResources.getProperty(key);
        if (result==null) result=def;
        return result;
    }
    
    public void crash()
    {
        synchronized(this) {
            if (upload!=null) return;
            upload = new Thread(this,"Crash Upload");
        }
        
        logAllThreads();
        
        synchronized(contributors) {
            for (CrashContributor contributor : contributors ) {
                try {
                    contributor.contribute(log);
                } catch (Throwable t ) { 
                    log.append(t.getMessage());
                } 
            }
        }
        
        
        if (stream!=null) {
            stream.dump();
        }

        StringSelection ss = new StringSelection(log.toString());
        Toolkit.getDefaultToolkit().getSystemClipboard().setContents(ss,ss);
        
        JFrame frame = new JFrame();
        final JDialog dialog = new JDialog(frame,true);
        dialog.setDefaultCloseOperation(JDialog.DO_NOTHING_ON_CLOSE);
        dialog.addWindowListener(new WindowListener() {
            @Override
            public void windowActivated(WindowEvent e) {
            }

            @Override
            public void windowClosed(WindowEvent e) {
            }

            @Override
            public void windowClosing(WindowEvent e) {
                if (!upload.isAlive()) dialog.dispose(); 
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
            } } );
        dialog.setTitle("System error");
        
        Container pane = dialog.getContentPane();
        pane.setLayout(new BorderLayout());
        
        JLabel labela = new JLabel("Unexpected System Error Occurred");
        labela.setHorizontalAlignment(SwingConstants.CENTER);
        labela.setBorder(new EmptyBorder(10,10,10,10));
        labela.setFont(new Font("Dialog",Font.BOLD,16));
        
        labelb = new JLabel(getResourceString("label.uploading","A report of this crash is being uploaded for analysis"));
        
        JPanel top=new JPanel(new GridLayout(2,1));
        top.add(labela);
        top.add(labelb);
        
        pane.add(top,BorderLayout.NORTH);
        
        JTextArea area = new JTextArea();
        area.setEditable(false);
        area.setText(log.toString());
        JScrollPane jsp = new JScrollPane(area);
        pane.add(jsp,BorderLayout.CENTER);
        
        JPanel panel = new JPanel();
        pane.add(panel,BorderLayout.SOUTH);
        JButton exit = new JButton("Exit");
        exit.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (!upload.isAlive()) dialog.dispose(); 
            } } );
        panel.add(exit);

        Rectangle r = dialog.getGraphicsConfiguration().getBounds();
        
        dialog.setSize(r.width/2,r.height/2);
        dialog.setLocation(r.width/4,r.height/4);
        
        upload.start();
        
        dialog.setVisible(true);
        System.exit(0);
    }

    @Override
    public void run() 
    {
        try {
            
            String target = getResourceString("upload.url","");
            
            URL u = new URL(target);
            URLConnection uc = u.openConnection();
            uc.setDoOutput(true);
            uc.getOutputStream().write(log.toString().getBytes());
            uc.getOutputStream().flush();
            InputStream is = uc.getInputStream();
            while (is.read()>=0) {
            }
            is.close();
            labelb.setText(getResourceString("label.uploaded","A report of this crash has been uploaded for analysis"));
        } catch (IOException e) {
            labelb.setText(getResourceString("label.uploaded","A report of this crash could not be uploaded. Please contact your software vendor with below details."));
            labelb.setForeground(Color.red);
            e.printStackTrace();
        }
    }

    public void logAllThreads() {
        for (Entry<Thread, StackTraceElement[]> e : Thread.getAllStackTraces().entrySet() ) {
            log(e.getKey().toString());
            for (StackTraceElement line : e.getValue()) {
                log(" "+line.toString());
            }
        }
    }

    public void threadCrash() {
        Thread t = new Thread("crash") {
            public void run()
            {
                crash();
            }
        };
        t.start();
    }

}
