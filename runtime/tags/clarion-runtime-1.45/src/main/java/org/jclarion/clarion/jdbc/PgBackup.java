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
import org.jclarion.clarion.util.LengthMonitoringWriter;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class PgBackup 
{
    private ClarionNumber allTables =new ClarionNumber(1);
    private ClarionNumber schema    =new ClarionNumber(1);
    private ClarionNumber jarFiles  =new ClarionNumber(1);
    private ClarionString file      =new ClarionString();
    private TableList     tables    =new TableList();
    private Connection    connection;
    
    private static class TableList extends ClarionQueue
    {
        public ClarionString name = Clarion.newString(30).setEncoding(ClarionString.PSTRING);
        public ClarionNumber mark = new ClarionNumber();
        
        public TableList()
        {
            addVariable("name",name);
            addVariable("mark",mark);
        }
    }
    
    public PgBackup(Connection c) throws SQLException
    {
        connection=c;
        connection.setAutoCommit(false);
        connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
        Statement s = c.createStatement();
        
        Set<String> sch_tables = PgSchema.get().getTables();
        
        StringBuilder extra = new StringBuilder();
        
        Set<String> tableIgnore = getIgnoreSetting("tables");

        try {
            ResultSet rs = s.executeQuery(
            "select c.relname from pg_class c " +
            "join pg_roles r on (r.oid=c.relowner) " +
            "WHERE r.rolname=current_user and c.relkind='r' " +
            "ORDER BY c.relname");
            while (rs.next()) {
                
                String name = rs.getString(1);
       
                if (tableIgnore.contains(name.toLowerCase())) continue;

                if (!sch_tables.contains(name.toLowerCase())) {
                    if (extra.length()>0) extra.append(", ");
                    extra.append(name);
                    continue;
                }
                
                tables.name.setValue(name);
                tables.mark.setValue(1);
                tables.add();
            }
        } finally {
            s.close();
        }
        
        if (extra.length()>0) {
            CWin.message(
                    Clarion.newString("Warning the following extraneous database tables will not be backed up.\n"+extra.toString()),
                    Clarion.newString("Create Backup File"),
                    Icon.ASTERISK);
        }
    }

    public void setFileName(String name)
    {
        file.setValue(name);
    }
    
    public String getFileName()
    {
        return file.toString().trim();
    }
    
    public boolean dialog()
    {
        ClarionWindow win = new ClarionWindow();
        win.setText("Create Backup File");
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
        cc.setText("Backup All data");
        cc.setValue("1","0");
        cc.use(allTables);
        cc.setAt(5,25,null,null);
        win.add(cc);
        int _allTables=cc.getUseID();

        cc = new CheckControl();
        cc.setText("Backup Schema");
        cc.setValue("1","0");
        cc.use(schema);
        cc.setAt(5,40,null,null);
        win.add(cc);

        cc = new CheckControl();
        cc.setText("Backup Program");
        cc.setValue("1","0");
        cc.use(jarFiles);
        cc.setAt(5,55,null,null);
        win.add(cc);
        
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
        ok.setAt(0,70,45,15);
        ok.setText("Backup");
        win.add(ok);
        ButtonControl cancel = new ButtonControl();
        cancel.setAt(45,70,45,15);
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
                CWin.fileDialog("Save Backup File",file, "Zip Files|*.zip",1+2);
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

    public Set<String> getIgnoreSetting(String type)
    {
        HashSet<String> result = new HashSet<String>();
        
        String values = PgProperties.get().getProperty(type+".ignore");
        if (values!=null) {
            StringTokenizer tok = new StringTokenizer(values,", \t");
            while (tok.hasMoreTokens()) {
                result.add(tok.nextToken().toLowerCase());
            }
        }
        return result;
    }
    
    public void backup()
    {
        Set<String> seqIgnore = getIgnoreSetting("seqs");
        
        ZipOutputStream zos;
        LengthMonitoringWriter osw;
        try {
            zos = new ZipOutputStream(new FileOutputStream(file.toString()));
            osw=new LengthMonitoringWriter(new OutputStreamWriter(zos,"US-ASCII"));
        } catch (FileNotFoundException e1) {
            CWin.message(
                    Clarion.newString("Could not write to "+file),
                    Clarion.newString("Create Backup File"),
                    Icon.HAND);
            return;
        } catch (UnsupportedEncodingException e) {
            CWin.message(
                    Clarion.newString("Encoding Error"),
                    Clarion.newString("Create Backup File"),
                    Icon.HAND);
            return;
        }
        
        try {

        int taskCount=0;
        if (schema.boolValue()) taskCount+=2;
        if (jarFiles.boolValue()) taskCount+=1;
        if (allTables.boolValue()) {
            taskCount+=tables.records();
        } else {
            for (int scan=1;scan<=tables.records();scan++) {
                tables.get(scan);
                if (tables.mark.intValue()==2) {
                    taskCount++;
                }
            }
        }
        
        ClarionWindow win = new ClarionWindow();
        win.setText("Creating Backup File");
        win.setAt(0,0,200,60);
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

        ButtonControl cancel = new ButtonControl();
        cancel.setText("Cancel");
        cancel.setStandard(Std.CLOSE);
        cancel.setAt(70,40,60,15);
        win.add(cancel);
        

        win.open();
        
        win.accept();
        win.consumeAccept();

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");

        Set<String> unbackedSeq=new HashSet<String>();

        PgSchema ps = PgSchema.get();
        
        PgSchema split[] = ps.split("^(?s:ALTER TABLE|CREATE INDEX|CREATE UNIQUE INDEX)");

        if (schema.boolValue()) {
            
            progress.increment(1);
            rowCount.setValue("Schema Part A");
            if (eatEvents(win)) return;
            CWin.display();
            
            try {
                zos.putNextEntry(new ZipEntry("10-schema.sql"));
                split[0].write(osw);
                osw.flush();
            } catch (IOException e1) {
                CWin.message(
                        Clarion.newString("Could not write to 10-schema.sql"),
                        Clarion.newString("Create Backup File"),
                        Icon.HAND);
            }
        }
        
        try {
            Statement st = connection.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
            try {
                ResultSet rs = st.executeQuery(
                "select c.relname from pg_class c " +
                "join pg_roles r on (r.oid=c.relowner) " +
                "WHERE r.rolname=current_user and c.relkind='S'");
                try {
                    while (rs.next()) {
                        unbackedSeq.add(rs.getString(1));
                    }
                } finally {
                    rs.close();
                }
            } finally {
                st.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            CWin.message(
                Clarion.newString("Database Error:"+e.getMessage()),
                Clarion.newString("Create Backup File"),
                Icon.HAND);
        }
        unbackedSeq.removeAll(seqIgnore);
        
        // do databases first
        for (int scan=1;scan<=tables.records();scan++) {
            tables.get(scan);
            if (tables.mark.intValue()==2 || allTables.boolValue()) 
            {
                progress.increment(1);
                rowCount.setValue("Table: "+tables.name);
                if (eatEvents(win)) return;
                CWin.display();

                try {
                    zos.putNextEntry(new ZipEntry("50-"+tables.name.toString().trim()+".sql"));
                } catch (IOException e1) {
                    CWin.message(
                            Clarion.newString("Could not write to "+file),
                            Clarion.newString("Create Backup File"),
                            Icon.HAND);
                }
                
                Set<String> seqs = new HashSet<String>();
                Pattern p = Pattern.compile("^nextval\\('([^']+)'");
                
                try {
                    Statement st = connection.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
                    try {
                        st.setFetchDirection(ResultSet.FETCH_FORWARD);
                        
                        st.setFetchDirection(ResultSet.FETCH_FORWARD);

                        ResultSet rs = st.executeQuery(
                        "select a.attname,d.adsrc from pg_attribute a " +
                        "join pg_class p on (p.oid=a.attrelid and p.relname='"+tables.name.toString()+"') " +
                        "join pg_roles r on (r.oid=p.relowner and r.rolname=current_user) " +
                        "left outer join pg_attrdef d ON (d.adrelid=p.oid AND d.adnum=a.attnum) "+
                        "where a.attnum>0 and not a.attisdropped " +
                        "order by attnum");

                        seqs.clear();
    
                        
                        Set<String> sch_columns = PgSchema.get().getColumns(tables.name.toString());
                        StringBuilder columns=new StringBuilder();
                        StringBuilder extra=new StringBuilder();
                        int colCount=0;
                        try {
                            while (rs.next()) {

                                if (!sch_columns.contains(rs.getString(1).toLowerCase())) {
                                    if (extra.length()>0) {
                                        extra.append(", ");
                                    }
                                    extra.append(rs.getString(1));
                                    continue;
                                }
                                
                                String def = rs.getString(2);
                                if (def!=null) {
                                    Matcher m = p.matcher(def);
                                    if (m.find()) {
                                        seqs.add(m.group(1));
                                    }
                                }
                                
                                if (columns.length()>0) { 
                                    columns.append(",");
                                }
                                columns.append(rs.getString(1));
                                colCount++;
                            } 
                        } finally {
                            rs.close();
                        }
                        
                        if (extra.length()>0) {
                            CWin.message(
                                    Clarion.newString("Warning the following extraneous columns in the database table "+tables.name.toString()+" will not be backed up.\n"+extra.toString()),
                                    Clarion.newString("Create Backup File"),
                                    Icon.ASTERISK);
                        }
                        
                        String cfg_seq = PgProperties.get().getProperty("seq."+tables.name.toString());
                        if (cfg_seq!=null) {
                            StringTokenizer tok = new StringTokenizer(cfg_seq,",");
                            while (tok.hasMoreTokens()) {
                                seqs.add(tok.nextToken());
                            }
                        }

                        for (String seq : seqs ) {
                            unbackedSeq.remove(seq);
                            rs=st.executeQuery("SELECT last_value FROM "+seq);
                            try {
                                if (!rs.next()) throw new SQLException("No next");
                                osw.append("SELECT setval('"+seq+"',"+rs.getLong(1)+",true);\n");
                            } finally {
                                rs.close();
                            }
                        }

                        osw.write("TRUNCATE ");
                        osw.write(tables.name.toString());
                        osw.append(";\n");
                        
                        
                        st.setFetchDirection(ResultSet.FETCH_FORWARD);
                        st.setFetchSize(500);
                        rs = st.executeQuery("SELECT "+columns.toString()+" FROM "+tables.name.toString());
                        boolean first=true;
                        
                        int count=0;
                        int sub_count=0;
                        int renew_count=0;
                        long init_length=osw.getLength();
                        
                        long next = System.currentTimeMillis()+3000;
                        
                        try {
                            while (rs.next()) {
                        
                                renew_count++;
                                if (renew_count==10000 || osw.getLength()-init_length>1000000) {
                                    osw.write(";\n");
                                    first=true;
                                    renew_count=0;
                                    init_length=osw.getLength();
                                }
                                
                                sub_count++;
                                if (sub_count==1379) {
                                    count+=1379;
                                    sub_count=0;
                                    if (System.currentTimeMillis()>next) {
                                        next = System.currentTimeMillis()+1000;
                                        rowCount.setValue("Table: "+tables.name+"... "+count);
                                        if (eatEvents(win)) return;
                                        CWin.display();
                                    }
                                }
                                
                                if (first) {
                                    first=false;
                                    osw.write("INSERT INTO ");
                                    osw.write(tables.name.toString());
                                    osw.write(" (");
                                    osw.write(columns.toString());
                                    osw.write(") VALUES ");
                                } else {
                                    osw.write(",");
                                }
                                osw.write("(");
                                
                                for (int cscan=0;cscan<colCount;cscan++) {
                                    Object o = rs.getObject(cscan+1);
                                    if (cscan>0) {
                                        osw.write(",");
                                    }
                                    if (o==null) {
                                        osw.write("NULL");
                                        continue;
                                    }
                                    
                                    if (o instanceof Number) {
                                        osw.write(o.toString());
                                        continue;
                                    }
                                    
                                    if (o instanceof String) {
                                        
                                        String s = o.toString();
                                        boolean escaped=false;
                                        
                                        if (s.length()<100) {
                                            
                                            for (int ss=0;ss<s.length();ss++) {
                                                char c=s.charAt(ss);
                                                if (c=='\\' || c=='\'' || c<32 || c>127) {
                                                    escaped=true;
                                                    break;
                                                }
                                            }
                                        } else {
                                            escaped=true;
                                        }
                                        
                                        if (escaped) {
                                            osw.write("E'");
                                        } else {
                                            osw.write("'");
                                        }
                                        
                                        for (int ss=0;ss<s.length();ss++) {
                                            char c=s.charAt(ss);
                                            
                                            if (c=='\\' || c=='\'') {
                                                osw.write('\\');
                                                osw.write(c);
                                                continue;
                                            }
                                            
                                            if (c>=32 && c<128) {
                                                osw.write(c);
                                                continue;
                                            }
                                            if (c>127 || c<0) c=128;
                                            osw.write('\\');
                                            osw.write((char)('0'+((c>>6)&7)));
                                            osw.write((char)('0'+((c>>3)&7)));
                                            osw.write((char)('0'+((c)&7)));
                                        }
                                        osw.write('\'');
                                        continue;
                                    }

                                    if (o instanceof byte[]) {
                                        byte[] bo=(byte[])o;
                                        
                                        boolean escaped=false;
                                        if (bo.length<100) {
                                            for (int ss=0;ss<bo.length;ss++) {
                                                int c=bo[ss]&0xff;
                                                if (c=='\\' || c=='\'' || c<32 || c>127) {
                                                    escaped=true;
                                                    break;
                                                }
                                            }
                                        } else {
                                            escaped=true;
                                        }

                                        if (escaped) {
                                            osw.write("E'");
                                        } else {
                                            osw.write("'");
                                        }

                                        for (int ss=0;ss<bo.length;ss++) {
                                            char c=(char)(bo[ss]&0xff);
                                            
                                            if (c=='\'') {
                                                osw.write('\\');
                                                osw.write(c);
                                                continue;
                                            }

                                            if (c=='\\') {
                                                osw.write('\\');
                                                osw.write('\\');
                                                osw.write('\\');
                                                osw.write('\\');
                                                continue;
                                            }
                                            
                                            if (c>=32 && c<128) {
                                                osw.write(c);
                                                continue;
                                            }
                                            osw.write('\\');
                                            osw.write('\\');
                                            osw.write((char)('0'+((c>>6)&7)));
                                            osw.write((char)('0'+((c>>3)&7)));
                                            osw.write((char)('0'+((c)&7)));
                                            escaped=true;
                                        }
                                        osw.write('\'');
                                        continue;
                                    }
                                    
                                    if (o instanceof java.sql.Date) {
                                        osw.write('\'');
                                        osw.write(dateFormat.format(((java.sql.Date)o)));
                                        osw.write('\'');
                                        continue;
                                    }
                                    
                                    if (o instanceof java.sql.Time) {
                                        osw.write('\'');
                                        osw.write(timeFormat.format(((java.sql.Time)o)));
                                        osw.write('\'');
                                        continue;
                                    }
                                    if (o instanceof java.sql.Timestamp) {
                                        osw.write('\'');
                                        osw.write(o.toString());
                                        osw.write('\'');
                                        continue;
                                    }

                                    if (o instanceof java.lang.Boolean) {
                                        osw.write(((Boolean)o).booleanValue()?"'1'":"'0'");
                                        continue;
                                    }

                                    throw new SQLException("Not supported:"+o.getClass());
                                }
                             
                                
                                osw.write(")");
                            }
                        } finally {
                            rs.close();
                        }
                        
                        if (!first) {
                            osw.write(";\n");
                        }
                        
                    } finally {
                        st.close();
                    }
                    osw.flush();
                } catch (SQLException e) {
                    e.printStackTrace();
                    CWin.message(
                        Clarion.newString("Database Error:"+e.getMessage()),
                        Clarion.newString("Create Backup File"),
                        Icon.HAND);
                } catch (IOException e) {
                    e.printStackTrace();
                    CWin.message(
                        Clarion.newString("ZIP File Error:"+e.getMessage()),
                        Clarion.newString("Create Backup File"),
                        Icon.HAND);
                }
            }
        }

        if (schema.boolValue()) {
            
            progress.increment(1);
            rowCount.setValue("Schema Part B");
            if (eatEvents(win)) return;
            CWin.display();
            
            try {
                zos.putNextEntry(new ZipEntry("90-schema.sql"));
                split[1].write(osw);
                osw.flush();
            } catch (IOException e1) {
                CWin.message(
                        Clarion.newString("Could not write to 10-schema.sql"),
                        Clarion.newString("Create Backup File"),
                        Icon.HAND);
            }
        }

        if (jarFiles.boolValue()) {

            progress.increment(1);
            rowCount.setValue("Client Files");
            if (eatEvents(win)) return;
            CWin.display();
            
            File base = new File(".");
            
            File[] sf = base.listFiles();
            if (sf!=null) {
                
                byte b_buffer[]=new byte[1024];
                
                for (File f : sf ) {
                    if (!f.getName().endsWith(".jar") && !f.getName().endsWith(".properties")) {
                        continue;
                    }
                    rowCount.setValue("Client Files:"+f.getName());
                    if (eatEvents(win)) return;
                    CWin.display();
                    
                    try {
                        zos.putNextEntry(new ZipEntry(f.getName()));
                        InputStream is = new FileInputStream(f);
                        while ( true ) {
                            int len = is.read(b_buffer);
                            if (len<0) break;
                            zos.write(b_buffer,0,len);
                        }
                        zos.flush();
                    } catch (IOException e) {
                        e.printStackTrace();
                        CWin.message(
                                Clarion.newString("IO Error writing to "+f+"\n"+e.getMessage()),
                                Clarion.newString("Create Backup File"),
                                Icon.HAND);
                    }
                }
            }
        }
        
        
        win.close();

        if (!unbackedSeq.isEmpty() && allTables.boolValue()) {
            PgSourceFinder.log.warning("Unbacked Seqs:"+unbackedSeq);
            CWin.message(
                Clarion.newString("Warning - following sequences were NOT backed up. Contact support."+unbackedSeq),
                Clarion.newString("Create Backup File"),
                Icon.EXCLAMATION);
        }

        
        } finally {
            try {
                zos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
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
               Clarion.newString("Create Backup File cancelled"),
               Clarion.newString("Create Backup File"),
                Icon.EXCLAMATION);
        return true;
    }

    public void notifySuccess()
    {
        CWin.message(
                Clarion.newString(
                        "Creation of the backup file was successful.\n\n"+ 
                		"You MUST now copy this file onto a proper backup media\n" +
                		"like a Optical drive (preferred option) or USB stick\n" +
                		"in order to securely protect your backup. Use separate\n" +
                		"devices for different days of the week. And a separate\n"+
                		" one for the end of month\n\n"+
                		"File:"+file),
                Clarion.newString("Create Backup File - Success"),
                Icon.SAVE);
    }
}
