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

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.constants.Button;
import org.jclarion.clarion.constants.Constants;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Icon;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.constants.Propstyle;
import org.jclarion.clarion.constants.Std;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.CheckControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.ProgressControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.runtime.CWin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.*;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

public class PgRestore 
{
    public static Logger log = Logger.getLogger(PgRestore.class.getName());
    
    
    private ClarionNumber allTables =new ClarionNumber(1);
    private boolean       schema;
    private ClarionString file      =new ClarionString();
    private TableList     tables    =new TableList();
    private Connection    connection;
    
    private static class TableList extends ClarionQueue
    {
        public ClarionString name = Clarion.newString(20).setEncoding(ClarionString.PSTRING);
        public ClarionNumber mark = new ClarionNumber();
        
        public TableList()
        {
            addVariable("name",name);
            addVariable("mark",mark);
        }
    }
    
    public PgRestore(Connection c,boolean schema) throws SQLException
    {
        connection=c;
        this.schema=schema;
        connection.setAutoCommit(true);
    }

    public void setFileName(String name)
    {
        log.info("PgRestore filename: "+name);
    	file.setValue(name);
    }

    public String getDetails(String input)
    {
        try {
            Statement s = connection.createStatement();
            try {
                ResultSet rs = s.executeQuery(input);
                try {
                    if (rs.next()) {
                        return rs.getString(1);
                    }
                } finally {
                    rs.close();
                }
            } finally {
                s.close();
            }
        } catch (SQLException ex) { 
            ex.printStackTrace();
        }
        return null;
    }
    
    public boolean dialog()
    {
        String text="*** WARNING ***\n\n"+
        "Restoring a system is very dangerous. You may accidently overwrite\n"+
        "and lose ALL of your live data. It is highly recommended that you\n"+
        "contact Support before continuing\n\n";
        
        if (!schema) {
            int scan=1;
            boolean any=false;
            while ( true ) {
                String r = PgProperties.get().getProperty("restore."+scan);
                if (r==null) break;
                r=getDetails(r);
                if (r!=null) {
                    any=true;
                    text+=r+"\n";
                }
                scan++;
            }
            if (any) text+="\n";
        }
        
        text+="Continue?";
        
        
        if (CWin.message(
                Clarion.newString(text),
                Clarion.newString("Restore System"),
                Icon.EXCLAMATION,
                Button.YES+Button.NO,Button.NO)!=Button.YES)
        {
            return false;
        }
        
        ClarionWindow win = new ClarionWindow();
        win.setText("Restore System");
        win.setAt(0,0,200,110);
        win.setCenter();
        
        CheckControl cc;

        EntryControl sc = new EntryControl();
        sc.setAt(1,1,160,null);
        sc.setText("@s100");
        sc.use(file);
        sc.setReadOnly();
        sc.setSkip();
        win.add(sc);
        
        ButtonControl bc = new ButtonControl();
        bc.setAt(160,1,40,15);
        bc.setText("&Select");
        win.add(bc);
        
        cc = new CheckControl();
        cc.setText("Restore All Data");
        cc.setValue("1","0");
        cc.use(allTables);
        cc.setAt(5,25,null,null);
        win.add(cc);
        int _allTables=cc.getUseID();

        ListControl lc = new ListControl();
        lc.setAt(98,22,100,80);
        lc.setFrom(tables);
        lc.setFormat("60L(3)~Table~YM|");
        lc.setHVScroll();
        lc.setProperty(Prop.HIDE,allTables.boolValue());
        lc.setProperty(Propstyle.BACKSELECTED,1,0xe0e0e0);
        lc.setProperty(Propstyle.TEXTSELECTED,1,0x000000);
        lc.setProperty(Propstyle.BACKCOLOR,2,0xff0000);
        lc.setProperty(Propstyle.FONTCOLOR,2,0xffffff);
        lc.setAlrt(Constants.MOUSELEFT);
        
        ButtonControl ok = new ButtonControl();
        ok.setDefault();
        ok.setAt(0,70,55,15);
        ok.setText("Restore DB");
        ok.setProperty(Prop.DISABLE,true); 
        win.add(ok);
        ButtonControl cancel = new ButtonControl();
        cancel.setAt(55,70,45,15);
        cancel.setText("&Cancel");
        cancel.setStandard(Std.CLOSE);
        win.add(cancel);
        
        boolean result=false;
        
        
        win.add(lc);
        
        win.open();
        bc.post(Event.ACCEPTED);
        while(win.accept()) {

            if (CWin.accepted()==ok.getUseID()) {
                win.post(Event.CLOSEWINDOW);
                result=true;
            }
            
            if (CWin.accepted()==bc.getUseID()) {
                CWin.fileDialog("Select Restore File",file, "Zip Files|*.zip",0+2);

                try {
                    ZipFile zip = new ZipFile(file.toString());

                    Enumeration<? extends ZipEntry> en = zip.entries();
                    tables.free();
                    while (en.hasMoreElements()) {
                        ZipEntry ze = en.nextElement();
                        String name = ze.getName();
                        if (name.startsWith("50-")) {
                            int end = name.indexOf('.');
                            tables.clear();
                            tables.name.setValue(name.substring(3,end));
                            tables.mark.setValue(1);
                            tables.add(tables.ORDER().ascend(tables.name));
                        }
                    }
                    ok.setProperty(Prop.DISABLE,false);
                    zip.close();
                } catch (IOException ex) {
                   ok.setProperty(Prop.DISABLE,true); 
                }
                
            }
            
            if (CWin.accepted()==_allTables) {
                lc.setProperty(Prop.HIDE,allTables.boolValue());
            }
            
            if (CWin.event()==Event.ALERTKEY && CWin.keyCode()==Constants.MOUSELEFT) {
                tables.get(CWin.choice(lc.getUseID()));
                tables.mark.setValue(tables.mark.intValue()==1?2:1);
                tables.put();
            }
            
            if (CWin.accepted()==lc.getUseID())
            {
            }
            
            win.consumeAccept();
        }
        win.close();
        return result;
    }


    public void restore()
    {
        ZipFile zip;
        Map<String,ZipEntry> entries=new HashMap<String, ZipEntry>();

        PgSchema start=null;
        PgSchema end=null;
        int taskCount=0;
        
        try {
            zip = new ZipFile(file.toString());
            Enumeration<? extends ZipEntry> en = zip.entries();
            while (en.hasMoreElements()) {
                ZipEntry ze = en.nextElement();
                entries.put(ze.getName().toLowerCase(),ze);
            }
            
            if (schema) {
                ZipEntry e;
                e = entries.get("10-schema.sql");
                if (e!=null) {
                    start=new PgSchema();
                    start.load(zip.getInputStream(e));
                    taskCount+=start.getCount();
                }
                e = entries.get("90-schema.sql");
                if (e!=null) {
                    end=new PgSchema();
                    end.load(zip.getInputStream(e));
                    taskCount+=end.getCount();
                }
            }
            
        } catch (IOException e1) {
            CWin.message(
                    Clarion.newString("Could not open "+file),
                    Clarion.newString("Restore"),
                    Icon.HAND);
            return;
        }

        if (allTables.boolValue()) {
            taskCount+=tables.records();
        } else {
           for (int scan=1;scan<=tables.records();scan++) {
               tables.get(scan);
               if (tables.mark.intValue()==2) taskCount++;
           }
        }
        
        ClarionWindow win = new ClarionWindow();
        win.setText("Restoring Database");
        win.setAt(0,0,200,40);
        win.setCenter();
        
        ClarionNumber progress=new ClarionNumber();
        ProgressControl pc = new ProgressControl();
        pc.setRange(0,taskCount);
        pc.use(progress);
        pc.setAt(5,2,190,20);
        win.add(pc);
        
        ClarionString rowCount=new ClarionString();
        StringControl status= new StringControl();
        status.setText("@s30").setAt(5,25,null,null).use(rowCount);
        win.add(status);

        win.open();
        
        win.accept();
        win.consumeAccept();

        
        try {
            connection.setAutoCommit(false);
        
            if (start != null) {
                rowCount.setValue("Creating Schema");
                CWin.display();
                if (eatEvents(win)) return;

                for (int scan = 0; scan < start.getCount(); scan++) {

                    progress.increment(1);
                    CWin.display();
                    if (eatEvents(win)) return;

                    Savepoint sp = connection.setSavepoint();
                    try {
                        Statement s = connection.createStatement();
                        try {
                            s.execute(start.getTask(scan));
                        } finally {
                            s.close();
                        }
                        connection.releaseSavepoint(sp);
                    } catch (SQLException ex) {
                        connection.rollback(sp);
                        log.warning(ex.getMessage());
                    }
                }
            }

            for (int scan = 1; scan <= tables.records(); scan++) {
                tables.get(scan);
                if (!allTables.boolValue() && tables.mark.intValue() != 2)
                    continue;

                progress.increment(1);
                rowCount.setValue("Restoring:" + tables.name);
                CWin.display();
                if (eatEvents(win)) return;

                ZipEntry ze = entries.get("50-" + tables.name + ".sql");
                if (ze == null)
                    throw new IOException("Entry not found:" + tables.name);

                BufferedReader isr = new BufferedReader(new InputStreamReader(
                        zip.getInputStream(ze)));
                while (true) {
                    String next = isr.readLine();
                    if (next == null)
                        break;
                    Statement s = connection.createStatement();
                    try {
                        s.execute(next);
                    } finally {
                        s.close();
                    }
                }
                isr.close();
            }

            if (end != null) {
                rowCount.setValue("Creating Indexes & Constraints");
                CWin.display();
                if (eatEvents(win)) return;

                for (int scan = 0; scan < end.getCount(); scan++) {

                    progress.increment(1);
                    CWin.display();
                    if (eatEvents(win)) return;

                    Savepoint sp = connection.setSavepoint();
                    try {
                        Statement s = connection.createStatement();
                        try {
                            s.execute(end.getTask(scan));
                        } finally {
                            s.close();
                        }
                        connection.releaseSavepoint(sp);
                    } catch (SQLException ex) {
                        connection.rollback(sp);
                        log.warning(ex.getMessage());
                    }
                }
            }
            
            connection.commit();

        } catch (SQLException ex) {
            log.warning(ex.getMessage());
            CWin.message(
                    Clarion.newString("DB Error\n"+ex.getMessage()),
                    Clarion.newString("Restore"),
                    Icon.HAND);
        } catch (IOException ex) {
            log.warning(ex.getMessage());
            CWin.message(
                    Clarion.newString("IO Error\n"+ex.getMessage()),
                    Clarion.newString("Restore"),
                    Icon.HAND);
        } finally {
            
            try {
                connection.rollback();
            } catch (SQLException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            
            try {
                zip.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        
        win.close();
        
        notifySuccess();
        return;
    }

    
    private boolean eatEvents(ClarionWindow win) 
    {
        win.setTimer(-1);
        while (win.accept()) {
            if (CWin.event()==Event.TIMER) {
                win.setTimer(0);
                return false;
            }
            win.consumeAccept();
        }
        win.close();
        CWin.message(
               Clarion.newString("Restore cancelled"),
               Clarion.newString("Restore Database"),
                Icon.EXCLAMATION);
        return true;
    }
    
    public void notifySuccess()
    {
        CWin.message(
                Clarion.newString("Restore Completed\n"),
                Clarion.newString("Restore Database - Success"),
                Icon.SAVE);
    }
}
