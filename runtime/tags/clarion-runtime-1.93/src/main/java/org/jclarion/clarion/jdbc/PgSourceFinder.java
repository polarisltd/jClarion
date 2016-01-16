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
package org.jclarion.clarion.jdbc;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Properties;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.TreeSet;
import java.util.logging.Logger;

import javax.swing.filechooser.FileSystemView;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionEvent;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Button;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Font;
import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.constants.Propstyle;
import org.jclarion.clarion.constants.Std;
import org.jclarion.clarion.control.AbstractControl;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.CheckControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.runtime.CConfig;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;

/**
 * Locate postgres data source based on configuration etc
 * 
 * @author barney
 */

public class PgSourceFinder 
{
    public static Logger log = Logger.getLogger(PgSourceFinder.class.getName());
    
    
    public static void main(String args[])
    {
        (new PgSourceFinder("clarion")).run();
    }
    
    private static final int MODE_HOST_OK=0;
    private static final int MODE_DB_OK=1;
    private static final int MODE_HOST_SCANNING=2;
    
    private static final int MODE_HOST_NOT_OK=10;
    private static final int MODE_DB_EMPTY=11;
    private static final int MODE_DB_NOT_OK=12;
    
    private static class HostFinder extends ClarionQueue
    {
        public ClarionNumber index=Clarion.newNumber();
        public ClarionString service=Clarion.newString(30).setEncoding(ClarionString.PSTRING);
        public ClarionNumber style1=Clarion.newNumber();
        public ClarionNumber depth=Clarion.newNumber();
        public ClarionString status=Clarion.newString(60).setEncoding(ClarionString.PSTRING);
        public ClarionNumber style2=Clarion.newNumber();
        public ClarionNumber mode=Clarion.newNumber();

        public ClarionString host=Clarion.newString(30).setEncoding(ClarionString.PSTRING);
        public ClarionString user=Clarion.newString(30).setEncoding(ClarionString.PSTRING);
        public ClarionString pass=Clarion.newString(30).setEncoding(ClarionString.PSTRING);
        public ClarionNumber port=Clarion.newNumber();
        
        public HostFinder()
        {
            addVariable("service",service);
            addVariable("depth",depth);
            addVariable("style1",style1);
            addVariable("status",status);
            addVariable("style2",style2);
            addVariable("mode",mode);

            addVariable("host",host);
            addVariable("user",user);
            addVariable("pass",pass);
            addVariable("port",port);
            addVariable("index",index);
        }
    }

    private abstract class Task
    {
        private String name;
        
        public Task(String name)
        {
            this.name=name;
        }
        
        public String toString()
        {
            return name;
        }
        
        public abstract void run();
    }
    
    private class FinderThread extends Thread
    {
        private boolean done;
        private LinkedList<Task> tasks;
        
        public FinderThread()
        {
            super("PG Finder");
            this.setDaemon(true);
            tasks=new LinkedList<Task>();
        }
        
        public void deployNextTask(Task r)
        {
            synchronized(this) {
                tasks.add(r);
                notifyAll();
            }
        }
        
        public void shutdown()
        {
            synchronized(this) {
                done=true;
                notifyAll();
            }
        }
        
        public void run()
        {
            while ( true ) {
                Task nextTask=null;
            
                synchronized(this) {
                    if (done) break;
                    if (tasks.isEmpty()) {
                        try {
                            wait();
                            continue;
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    } else {
                        nextTask=tasks.removeFirst();
                    }
                }
     
                currentTask.setValue(nextTask.toString());
                window.post(ClarionEvent.test(Event.USER,1,false));

                try {
                    nextTask.run();
                } catch (Throwable t) {
                    t.printStackTrace();
                }

                boolean empty=false;
                synchronized(this) {
                    empty=tasks.isEmpty();
                }

                if (empty) {
                    currentTask.setValue("Done");
                }
                
                window.post(ClarionEvent.test(Event.USER,2,false));

            }
        }
    }
    
    private ClarionWindow   window;

    private int             hostid=1;
    private HostFinder      hosts;
    private HostFinder      view_hosts;
    private FinderThread    thread;
    private ClarionString   currentTask;
    private ClarionNumber   expert;

    private int             _expert; 
    private int             _list;
    private int             _expert_buttons;
    
    private int             _find;
    private int             _scan;
    private int             _backup;
    private int             _create;
    private int             _delete;
    private int             _restore;
    private int             _select;
    
    private String          select;
    private String          highlight;
    private String          selection;

    private String          dbTest;

    public PgSourceFinder(String select)
    {
        this(select,select);
    }
    
    public PgSourceFinder(String select,String highlight)
    {
        this.highlight=highlight;
        dbTest=PgProperties.get().getProperty("dbtest");
        if (dbTest==null) dbTest="SELECT 'Default Database Test'";
        
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
        }
        
        this.select=select;
        window=new ClarionWindow();
        if (select!=null) {
            window.setText("Database Manager : select "+select);
        } else {
            window.setText("Database Manager");
        }
        window.setSystem();
        window.setAt(null,null,320,200);
        window.setCenter();
        //window.setFont("Serif",12,0,0,null);

        hosts=new HostFinder();
        view_hosts=new HostFinder();
        
        ListControl list = new ListControl();
        list.setAt(2,2,316,160);
        list.setFrom(view_hosts);
        list.setFormat(
                "100L(5)YT~Host / Server~|M"+
                "80L(5)Y~Status~|M"
                );
        list.setHVScroll();
        window.add(list);
        _list=list.getUseID();
        
        list.setProperty(Propstyle.FONTSTYLE,MODE_DB_OK,Font.BOLD);
        list.setProperty(Propstyle.FONTCOLOR,MODE_DB_EMPTY,0xc0c0c0);
        list.setProperty(Propstyle.FONTCOLOR,MODE_HOST_NOT_OK,0x8080ff);
        list.setProperty(Propstyle.FONTCOLOR,MODE_DB_NOT_OK,0x8080ff);
        list.setProperty(Propstyle.FONTCOLOR,MODE_HOST_SCANNING,0xffc0c0);
        
        
        currentTask=Clarion.newString().setEncoding(ClarionString.PSTRING);
        GroupControl gc = new GroupControl();
        gc.setAt(62,185,263,17);
        gc.setBoxed();
        window.add(gc);
        StringControl sc = new StringControl();
        sc.setText("@s40");
        sc.setRight(0);
        sc.setAt(2,185,316,17);
        sc.use(currentTask);
        gc.add(sc);
        
        expert=new ClarionNumber();
        CheckControl cc = new CheckControl();
        cc.setAt(1,189,55,11);
        cc.setText("Expert Mode");
        cc.setFlat();
        cc.setValue("1","0");
        cc.use(expert);
        window.add(cc);
        _expert=cc.getUseID();
        
        
        ButtonControl bc;
        bc = new ButtonControl();
        bc.setAt(1,160,60, 12);
        bc.setText("Find Server");
        window.add(bc);
        _find=bc.getUseID();

        bc = new ButtonControl();
        bc.setAt(65,160,80, 12);
        bc.setText("Scan for servers");
        window.add(bc);
        _scan=bc.getUseID();
        
        
        bc = new ButtonControl();
        bc.setAt(1,173,80, 12);
        bc.setText("Create Backup File");
        bc.setDisabled();
        window.add(bc);
        _backup=bc.getUseID();
        
        GroupControl expert_buttons = new GroupControl();
        window.add(expert_buttons);
        expert_buttons.setHidden();
        _expert_buttons=expert_buttons.getUseID();
        
        bc = new ButtonControl();
        bc.setAt(95,173,65, 12);
        bc.setText("Create New DB");
        bc.setDisabled();
        expert_buttons.add(bc);
        _create=bc.getUseID();

        bc = new ButtonControl();
        bc.setAt(165,173,55, 12);
        bc.setText("Delete DB");
        bc.setDisabled();
        expert_buttons.add(bc);
        _delete=bc.getUseID();

        bc = new ButtonControl();
        bc.setAt(220,173,55, 12);
        bc.setText("Restore DB");
        bc.setDisabled();
        expert_buttons.add(bc);
        _restore=bc.getUseID();

        bc = new ButtonControl();
        bc.setAt(275,173,40, 12);
        bc.setText("Select");
        bc.setDefault();
        bc.setDisabled();
        if (select==null) bc.setHidden();
        window.add(bc);
        _select=bc.getUseID();
    }

    public static String[] getHostData(String in)
    {
        if (in==null) return null;
        int count=1;
        int scan=0;
        while (scan<in.length()) {
            int next = in.indexOf(':',scan);
            if (next==-1) break;
            count++;
            scan=next+1;
        }
        
        String result[]=new String[count];
        count=0;
        scan=0;
        while (scan<in.length()) {
            int next = in.indexOf(':',scan);
            if (next<0) break;
            result[count++]=in.substring(scan,next);
            scan=next+1;
        }
        result[count++]=in.substring(scan);
        return result;
    }

    public String getSelection()
    {
        return selection;
    }
    
    
    public void run()
    {
        window.open();
        
        thread=new FinderThread();
        thread.start();

        while (window.accept()) {
            
            if (CWin.event()==Event.OPENWINDOW) {
                
                String good_hosts = CConfig.getProperty("db","good","X","db.properties");
                if (good_hosts.equals("X")) {
                    addHost("localhost","postgres","postgres",5432,false);
                    scanForServers();
                } else {
                    StringTokenizer tok = new StringTokenizer(good_hosts.toString(),",");
                    while (tok.hasMoreTokens()) {
                        String t=tok.nextToken();
                        String hd[] = getHostData(t);
                        if (hd.length==4) {
                            addHost(hd[0],hd[1],hd[2],Integer.parseInt(hd[3]),false);
                        }
                    }
                }
            }

            if (CWin.event()==Event.NEWSELECTION) {
                view_hosts.get(CWin.choice(_list));
                
                int mode =  view_hosts.mode.intValue();
                
                CWin.getControl(_create).setProperty(Prop.DISABLE,mode!=MODE_HOST_OK);
                CWin.getControl(_backup).setProperty(Prop.DISABLE,mode!=MODE_DB_OK);
                CWin.getControl(_delete).setProperty(Prop.DISABLE,mode!=MODE_DB_OK && mode!=MODE_DB_EMPTY);
                CWin.getControl(_restore).setProperty(Prop.DISABLE,mode!=MODE_DB_EMPTY && mode!=MODE_DB_OK);
                CWin.getControl(_select).setProperty(Prop.DISABLE,mode!=MODE_DB_OK);
                
            }
            
            if (CWin.accepted()==_expert) {

                if (expert.boolValue()) {
                    CWin.unhide(_expert_buttons);
                } else {
                    CWin.hide(_expert_buttons);
                }
                
                refresh();
            }

            if (CWin.accepted()==_scan)
            {
                scanForServers();
            }

            if (CWin.accepted()==_select) 
            {
                view_hosts.get(CWin.choice(_list));
                if (CError.errorCode()==0 && view_hosts.mode.intValue()==MODE_DB_OK) {
                    selection=view_hosts.host.toString()+":"+view_hosts.user.toString()+":"+view_hosts.pass.toString()+":"+view_hosts.port.intValue();
                    window.post(Event.CLOSEWINDOW);
                }
            }

            if (CWin.accepted()==_restore) 
            {
                view_hosts.get(CWin.choice(_list));
                if (CError.errorCode()==0 && (view_hosts.mode.intValue()==MODE_DB_OK || view_hosts.mode.intValue()==MODE_DB_EMPTY)) {
                    Connection c = tryConnection(
                            view_hosts.host.toString(),
                            view_hosts.user.toString(),
                            view_hosts.user.toString(),
                            view_hosts.pass.toString(),
                            view_hosts.port.intValue());
                    
                    if (c!=null) {
                        try {
                            PgRestore rs = new PgRestore(c,view_hosts.mode.intValue()==MODE_DB_EMPTY);
                            rs.setFileName(".."+File.separator+view_hosts.service.toString().trim()+"backup"+File.separator);
                            if (rs.dialog()) {
                                rs.restore();
                            }
                        } catch (SQLException e) {
                            CWin.message(
                            Clarion.newString("Database Error:\n"+e.getMessage()),
                            Clarion.newString("Restore Database"),
                            Icon.HAND);
                        } finally {
                            try {
                                c.close();
                            } catch (SQLException ex) { } 
                        }
                    }
                    refreshGoodHosts();
                }
            }
            
            if (CWin.accepted()==_backup) 
            {
                view_hosts.get(CWin.choice(_list));
                if (CError.errorCode()==0 && view_hosts.mode.intValue()==MODE_DB_OK) {
                    
                    Connection c = tryConnection(
                            view_hosts.host.toString(),
                            view_hosts.user.toString(),
                            view_hosts.user.toString(),
                            view_hosts.pass.toString(),
                            view_hosts.port.intValue());
                    
                    if (c!=null) {
                        try {
                            PgBackup bk = new PgBackup(c);
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
                            bk.setFileName(".."+File.separator+view_hosts.service.toString().trim()+"backup"+File.separator+sdf.format(new Date(System.currentTimeMillis()))+".zip");
                            if (bk.dialog()) {
                                bk.backup();
                            }
                        } catch (SQLException e) {
                            CWin.message(
                            Clarion.newString("Database Error:\n"+e.getMessage()),
                            Clarion.newString("Install Database"),
                            Icon.HAND);
                        } finally {
                            try {
                                c.close();
                            } catch (SQLException ex) { } 
                        }
                    }
                }
            }
            
            
            if (CWin.accepted()==_delete) 
            {
                view_hosts.get(CWin.choice(_list));
                if (CError.errorCode()==0)
                {
                    view_hosts.get(CWin.choice(_list));
                    
                    String user = view_hosts.user.toString();
                    
                    int scan = CWin.choice(_list)-1;
                    while (scan>0) {
                        view_hosts.get(scan);
                        if (view_hosts.depth.intValue()==1) break;
                        scan--;
                    }
                    
                    boolean cancel=false;
                    
                    for (int cscan=1;cscan<=5;cscan++) {
                        
                        String message = 
                            "Delete "+user.trim()+" on "+view_hosts.host.toString().trim()+"\n\n"+
                            "Deleting a database will result in IRREVERSABLE data loss!\n"+
                            "in Are You absolutely sure you want to do this?\n";
                        
                        if (cscan<5) {
                            message+="(I am going to ask you "+(5-cscan)+" more time"+(cscan<4?"s":"")+" just to be sure)";
                        } else {
                            message+="(Last Chance to Abort!)";
                        }
                        
                        if (CWin.message(
                            Clarion.newString(message),
                            Clarion.newString("Delete Database"),
                            Icon.ASTERISK,
                            Button.YES+Button.NO,
                            Button.NO)==Button.NO) 
                        {
                            cancel=true;
                            break;
                        }
                    }
                    if (!cancel) {

                        String error=null;
                        Connection c = tryConnection(
                                view_hosts.host.toString(),
                                view_hosts.user.toString(),
                                view_hosts.user.toString(),
                                view_hosts.pass.toString(),
                                view_hosts.port.intValue());
                        
                        if (c==null) {
                            error="Could not connect to PostgreSQL Server";
                        } else {
                            try {
                                Statement s = c.createStatement();
                                s.execute("DROP DATABASE "+user);
                                s.execute("DROP ROLE "+user);
                            } catch (SQLException ex) { 
                                error="Database Error\n"+ex.getMessage();
                            } finally {
                                try {
                                    c.close();
                                } catch (SQLException ex){  }
                            }
                        }

                        if (error!=null) {
                            CWin.message(
                                    Clarion.newString(error),
                                    Clarion.newString("Delete Database"),
                                    Icon.HAND);
                        }
                        
                    }
                    refreshGoodHosts();
                }
            }
            
            if (CWin.accepted()==_create) {
                
                view_hosts.get(CWin.choice(_list));
                if (CError.errorCode()==0 && view_hosts.mode.intValue()==MODE_HOST_OK) {
                    ClarionWindow w = new ClarionWindow();
                    w.setAt(0, 0, 200, 40);
                    w.setCenter();
                    w.setText("Create New Database");

                    ClarionString host = new ClarionString(30);
                    if (select!=null) host.setValue(select);

                    w.add((new StringControl()).setText("Database Name:")
                            .setAt(2, 5, null, null));
                    w.add((new EntryControl()).setText("@s30").setAt(90, 2,
                            105, 15).use(host));

                    ButtonControl ok = new ButtonControl();
                    ok.setDefault().setText("OK").setAt(45, 20, 50, 15);
                    w.add(ok);
                    w.add((new ButtonControl()).setStandard(Std.CLOSE).setText(
                            "Cancel").setAt(110, 20, 50, 15));

                    w.open();
                    while (w.accept()) {
                        if (CWin.accepted() == ok.getUseID()) {
                            
                            String db = host.toString().trim();
                            
                            Connection c = tryConnection(
                                view_hosts.host.toString().trim(),
                                "",
                                view_hosts.user.toString().trim(), 
                                view_hosts.pass.toString().trim(),
                                view_hosts.port.intValue()
                            );
                            
                            String error=null;
                            
                            if (c==null) {
                                error="Could not connect to PostgreSQL Server";
                            } else {
                                try {
                                    Statement s = c.createStatement();
                                    s.execute("CREATE USER "+db+" NOCREATEDB NOCREATEUSER UNENCRYPTED PASSWORD '"+db+"'");
                                    String encoding = PgProperties.get().getProperty("encoding."+db);
                                    if (encoding==null) encoding = PgProperties.get().getProperty("encoding");
                                    System.out.println("ERE:"+encoding);
                                    if (encoding==null) {
                                    	s.execute("CREATE DATABASE "+db+" WITH OWNER="+db);
                                    } else {
                                    	s.execute("CREATE DATABASE "+db+" WITH OWNER="+db+" ENCODING '"+encoding+"' TEMPLATE template0");
                                    }
                                } catch (SQLException ex) {
                                    error="Database Error\n"+ex.getMessage();
                                } finally {
                                    if (c!=null) {
                                        try {
                                            c.close();
                                        } catch (SQLException ex) { }
                                    }
                                }
                            }

                            if (error!=null) {
                                CWin.message(
                                        Clarion.newString(error),
                                        Clarion.newString("Create New Database"),
                                        Icon.HAND);
                            }
                            refreshGoodHosts();
                            w.post(Event.CLOSEWINDOW);
                        }
                        w.consumeAccept();
                    }
                    w.close();
                }
            }

            if (CWin.accepted()==_find) {
                
                ClarionWindow w = new ClarionWindow();
                w.setAt(0,0,200,100);
                w.setCenter();
                w.setText("Find PostgreSQL Server");
                ClarionString host=  new ClarionString(30);
                ClarionString user=  new ClarionString(30);
                ClarionString pass=  new ClarionString(30);
                ClarionNumber port=  new ClarionNumber();
                user.setValue("postgres");
                pass.setValue("postgres");
                port.setValue(5432);
            
                w.add((new StringControl()).setText("Server:").setAt(2,5,null,null));
                w.add((new StringControl()).setText("PostgreSQL User:").setAt(2,25,null,null));
                w.add((new StringControl()).setText("PostgreSQL Password:").setAt(2,45,null,null));
                w.add((new StringControl()).setText("PostgreSQL Port:").setAt(2,65,null,null));
                
                w.add((new EntryControl()).setText("@s30").setAt(90,2,105,15).use(host));
                w.add((new EntryControl()).setText("@s30").setAt(90,22,105,15).use(user));
                w.add((new EntryControl()).setText("@s30").setAt(90,42,105,15).use(pass));
                w.add((new EntryControl()).setText("@n_5").setAt(90,62,105,15).use(port));
                
                ButtonControl ok = new ButtonControl();
                ok.setDefault().setText("OK").setAt(45,80,50,15);
                w.add(ok);
                w.add((new ButtonControl()).setStandard(Std.CLOSE).setText("Cancel").setAt(110,80,50,15));
                
                w.open();
                while (w.accept()) {
                    if (CWin.accepted()==ok.getUseID()) {
                        addHost(host.toString().trim(),user.toString().trim(),pass.toString().trim(),port.intValue(),true);
                        CWin.post(Event.CLOSEWINDOW);
                    }
                    w.consumeAccept();
                }
                w.close();
            }
            
            if (CWin.event()==Event.USER) {
                refresh();
            }
            
            window.consumeAccept();
        }

        thread.shutdown();
        window.close();

        StringBuilder good_hosts=new StringBuilder();
        
        synchronized(hosts) {
            for (int scan=1;scan<=hosts.records();scan++) {
                hosts.get(scan);
                if (hosts.mode.intValue()==MODE_HOST_OK) {
                    if (good_hosts.length()>0) good_hosts.append(",");
                    good_hosts.append(hosts.host.toString());
                    good_hosts.append(":");
                    good_hosts.append(hosts.user.toString());
                    good_hosts.append(":");
                    good_hosts.append(hosts.pass.toString());
                    good_hosts.append(":");
                    good_hosts.append(hosts.port.intValue());
                }
            }
        }

        CConfig.setProperty("db","good",good_hosts.toString(),"db.properties");
        
    }
    
    private Thread scanner;

    private void scanForServers() {

        if (scanner!=null) {
            if (scanner.isAlive()) return;
        }
        
        CWin.disable(_scan);
        
        scanner=new Thread() {
            public void run()
            {
            	Set<File> computers = new HashSet<File>();
            	Set<File> scanned = new HashSet<File>();
            	FileSystemView fsv = FileSystemView.getFileSystemView();
            	findComputer(scanned,computers,fsv,fsv.getHomeDirectory(),0);
            	for (File f : fsv.getRoots() ) {
            		findComputer(scanned,computers,fsv,f,0);
            	}
            	for (File f : computers ) {
            		System.out.println("Computer:"+f.getName());
                    addHost(f.getName(),"postgres","postgres",5432,false);
            	}
            	if (computers.isEmpty()) {
            		scanForServersOld();
            	}
            	AbstractControl ac = window.getControl(_scan);
            	if (ac!=null) ac.setProperty(Prop.DISABLE,0);
            }
        };
        scanner.start();
    }

    private void findComputer(Set<File> scanned,Set<File> computers, FileSystemView fsv,File base,int depth) 
    {
    	if (scanned.contains(base)) return;
    	scanned.add(base);
    	System.out.println("Scanning:"+base.getName()+" : "+fsv.getSystemDisplayName(base));
    	
    	File kids[] = fsv.getFiles(base,true);
    	for (File kid : kids ) {
    		if (!fsv.isTraversable(kid)) continue;
    		String name = kid.getName().toLowerCase().replaceAll("[^a-z]","");

        	if (kid.getName().startsWith("::")) {
    			findComputer(scanned,computers,fsv,kid,0);
        	}
        	
    		if (name.contains("entirenetwork")) {
    			findComputer(scanned,computers,fsv,kid,1);
    		}
    		if (name.contains("microsoftwindowsnetwork")) {
    			findComputer(scanned,computers,fsv,kid,1);
    		}
    	}

    	for (File kid : kids ) {
    		if (fsv.isComputerNode(kid)) {
    			computers.add(kid);
    		}
    		if (!fsv.isTraversable(kid)) continue;
    		if (depth>0) {
    			findComputer(scanned,computers,fsv,kid,depth-1);
    		}
    	}
	}
    
    private void scanForServersOld() {
                ProcessBuilder builder = new ProcessBuilder();
                builder.command("net","view");
                builder.redirectErrorStream(true);
                try {
                    Process p = builder.start();
                    BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
                    while ( true ) {
                        String line = r.readLine();
                        if (line==null) break;
                        if (line.startsWith("\\")) {
                            StringTokenizer tok = new StringTokenizer(line.substring(2));
                            if (tok.hasMoreTokens()) {
                                addHost(tok.nextToken(),"postgres","postgres",5432,false);
                            }
                        }
                    }
                    p.waitFor();
                } catch (IOException e) {
                    e.printStackTrace();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
    }

    private void refresh()
    {
        int ns=0;
        
        view_hosts.free();
        synchronized(hosts) {
            for (int scan=1;scan<=hosts.records();scan++) {
                hosts.get(scan);
                if (expert.boolValue() || hosts.mode.intValue()<10) {
                    view_hosts.merge(hosts);
                    view_hosts.add();
                    if (highlight!=null && view_hosts.depth.intValue()==2 && view_hosts.service.equals(highlight)) {
                        ns=view_hosts.records();
                    }
                }
            }
        }
        if (ns>0) CWin.select(_list,ns);
    }

    public void refreshGoodHosts()
    {
        Set<String> good_hosts=new HashSet<String>();
        
        synchronized(hosts) {
            for (int scan=1;scan<=hosts.records();scan++) {
                hosts.get(scan);
                if (hosts.mode.intValue()==MODE_HOST_OK) {
                    good_hosts.add(
                            hosts.host+":"+hosts.user+":"+hosts.pass+":"+hosts.port
                    );
                }
            }
            hosts.free();
        }
        
        for (String good : good_hosts) {
            String hd[] = getHostData(good);
            if (hd.length==4) {
                addHost(hd[0],hd[1],hd[2],Integer.parseInt(hd[3]),false);
            }
        }

        window.post(Event.USER);
    }
    
    public void addHost(final String host,final String user,final String pass,final int port,final boolean keep)
    {
        thread.deployNextTask(new Task("Adding Host:"+host+"....") { 

            public void run()
            {
                int hpos;
                
                synchronized(hosts) {
                    hosts.index.setValue(++hostid);
                    hosts.service.setValue(host);
                    hosts.depth.setValue(1);
                    hosts.status.setValue("Searching...");
                    hosts.mode.setValue(MODE_HOST_SCANNING);
                    hosts.style1.setValue(MODE_HOST_SCANNING);
                    hosts.style2.setValue(MODE_HOST_SCANNING);
                    hosts.host.setValue(host);
                    hosts.user.setValue(user);
                    hosts.pass.setValue(pass);
                    hosts.port.setValue(port);
                    hosts.add();
                    hpos=hostid;
                }
                window.post(Event.USER);
                
                InetAddress ia=null;
                
                try {
                    ia = InetAddress.getByName(host);
                } catch (UnknownHostException e) {
                    synchronized(hosts) {

                        hosts.index.setValue(hpos);
                        hosts.get(hosts.ORDER().ascend(hosts.index));

                        if (keep) {
                            hosts.status.setValue("Server Not Found");
                            hosts.mode.setValue(MODE_HOST_NOT_OK);
                            hosts.style1.setValue(MODE_HOST_NOT_OK);
                            hosts.style2.setValue(MODE_HOST_NOT_OK);
                            hosts.put();
                        } else {
                            hosts.delete();
                        }
                    }
                    return;
                }

                Socket s = new Socket();
                try {
                    s.connect(new InetSocketAddress(ia,port),2000);
                    s.close();
                } catch (IOException e) {
                    synchronized(hosts) {
                        hosts.index.setValue(hpos);
                        hosts.get(hosts.ORDER().ascend(hosts.index));

                        if (keep) {
                            hosts.status.setValue("PostgreSQL Server Not Found");
                            hosts.mode.setValue(MODE_HOST_NOT_OK);
                            hosts.style1.setValue(MODE_HOST_NOT_OK);
                            hosts.style2.setValue(MODE_HOST_NOT_OK);
                            hosts.put();
                        } else {
                            hosts.delete();
                        }
                    }
                    return;
                }
                
                Connection c = null;
                c = tryConnection(host,"",user,pass,port);

                if (c==null) {
                    synchronized(hosts) {
                        hosts.index.setValue(hpos);
                        hosts.get(hosts.ORDER().ascend(hosts.index));

                        if (keep) {
                            hosts.status.setValue("Cannot Login to PostgreSQL. Check users and HBA");
                            hosts.mode.setValue(MODE_HOST_NOT_OK);
                            hosts.style1.setValue(MODE_HOST_NOT_OK);
                            hosts.style2.setValue(MODE_HOST_NOT_OK);
                            hosts.put();
                        } else {
                            hosts.delete();
                        }
                    }
                    return;
                }
                synchronized(hosts) {
                    hosts.index.setValue(hpos);
                    hosts.get(hosts.ORDER().ascend(hosts.index));
                    hosts.status.setValue("PostgreSQL Available");
                    hosts.mode.setValue(MODE_HOST_OK);
                    hosts.style1.setValue(MODE_HOST_OK);
                    hosts.style2.setValue(MODE_HOST_OK);
                    hosts.put();
                }

                Set<String> names = new TreeSet<String>();
                
                try {
                    Statement st = c.createStatement();
                    ResultSet rs = st.executeQuery("SELECT usename FROM pg_user");
                    while (rs.next()) {
                        names.add(rs.getString(1));
                    }
                    rs.close();
                    st.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                try {
                    c.close();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }

                
                
                for (String name : names ) {
                    
                    if (name.equals("postgres")) continue;
                    
                    String description = null;

                    boolean hostOk=false;
                    
                    try {
                        c=tryConnection(host,name,name,name,port);
                        if (c!=null) {
                            hostOk=true;
                            try {
                                
                                Statement st = c.createStatement();
                                try {
                                    ResultSet rs = st.executeQuery(dbTest);
                                    if (rs.next()) {
                                        description=rs.getString(1);
                                    }
                                    rs.close();
                                } finally {
                                    st.close();
                                }
                            } finally {
                                c.close();
                            }
                        }
                    } catch (SQLException ex) { }

                    synchronized(hosts) {
                        
                        hosts.index.setValue(hpos);
                        hosts.get(hosts.ORDER().ascend(hosts.index));
                        
                        hosts.index.setValue(++hostid);
                        hosts.service.setValue(name);
                        hosts.depth.setValue(2);
                        hosts.host.setValue(host);
                        hosts.user.setValue(name);
                        hosts.pass.setValue(name);
                        hosts.port.setValue(port);
                    
                        if (description!=null) {
                            hosts.status.setValue(description);
                            hosts.mode.setValue(MODE_DB_OK);
                            hosts.style1.setValue(MODE_DB_OK);
                            hosts.style2.setValue(MODE_DB_OK);
                            hosts.add(hosts.getPointer()+1);
                        } else {
                            if (hostOk) {
                                hosts.status.setValue("*** EMPTY ***");
                                hosts.mode.setValue(MODE_DB_EMPTY);
                                hosts.style1.setValue(MODE_DB_EMPTY);
                                hosts.style2.setValue(MODE_DB_EMPTY);
                                hosts.add(hosts.getPointer()+1);
                            } else {
                                hosts.status.setValue("Cannot Login to PostgreSQL. Check users and HBA");
                                hosts.mode.setValue(MODE_DB_NOT_OK);
                                hosts.style1.setValue(MODE_DB_NOT_OK);
                                hosts.style2.setValue(MODE_DB_NOT_OK);
                                hosts.add(hosts.getPointer()+1);
                            }
                        }
                    }
                }
            }
        });
    }
    
    private Connection tryConnection(String host, String db,String user,String pass,int port) 
    {
        Properties p = new Properties();
        p.setProperty("user",user);
        p.setProperty("password",pass);
        try {
            return DriverManager.getConnection("jdbc:postgresql://"+host+":"+port+"/"+db,p);
        } catch (SQLException e) {
        }
        return null;
    }
    
    
}
