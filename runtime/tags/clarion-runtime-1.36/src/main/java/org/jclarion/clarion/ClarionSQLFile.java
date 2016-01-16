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

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;

import org.jclarion.clarion.jdbc.AbstractJDBCSource;
import org.jclarion.clarion.jdbc.JDBCSource;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CErrorImpl;
import org.jclarion.clarion.util.FileState;
import org.jclarion.clarion.util.SharedInputStream;
import org.jclarion.clarion.util.SharedOutputStream;
import org.jclarion.clarion.ClarionKey.Order;
import org.jclarion.clarion.constants.*;

public class ClarionSQLFile extends ClarionFile 
{
    private static final String FORCED_AUTO_COMMIT = new String("FORCED_AUTO_COMMIT");
    private static Logger log = Logger.getLogger(ClarionSQLFile.class.getName());
    
    public void setLimit(int limit)
    {
        getFileState().setLimit(limit);
    }
    
    

    public void setKeyBinding()
    {
        getFileState().setKeyBinding(true);
    }
    
    
    @Override
    public void add() {

        if (!testOpen()) return;

        FileState fs = getFileState();
        
        StringBuilder sb = new StringBuilder();
        sb.append("INSERT INTO ");
        sb.append(fs.global.name);
        
        StringBuilder names=new StringBuilder();
        StringBuilder values=new StringBuilder();

        List<Object> params=new ArrayList<Object>();
        
        int count=0;
        for (int scan=0;scan<fs.changed.length;scan++) {
            if (fs.global.autoincrementing[scan]) {
                continue;
            }
            if (count>0) {
                names.append(',');
                values.append(',');
            }
            names.append(fs.global.fieldNames[scan]);
            encodeValue(values,fs.isnull[scan]?null:fs.fields[scan],fs.global.types[scan],params,null);
            count++;
        }

        if (count>0) {
            sb.append(" (");
            sb.append(names);
            sb.append(") VALUES (");
            sb.append(values);
            sb.append(')');
        }

        
        String sql = sb.toString();
        setInternalSQL(sql,params);

        
        try {
            if (params.isEmpty()) {
                Statement s=fs.global.source.getConnection().createStatement();
                try {
                    s.execute(sql);
                } finally {
                    s.close();
                }
            } else {
                PreparedStatement s=prepare(fs,sql,params);
                try {
                    s.execute();
                } finally {
                    s.close();
                }
            }
        } catch (SQLException e) {
            setError(fs,e);
        }

        optCommit(fs);
    }
    
    private PreparedStatement prepare(FileState fs,String sql,List<Object> params)
        throws SQLException
    {
        PreparedStatement ret =null;
        PreparedStatement p = fs.global.source.getConnection().prepareStatement(sql); 
        try {
            int count=0;
            for ( Object o : params ) {
                count++;
                if (o instanceof byte[]) {
                    p.setBytes(count,(byte[])o);
                    continue;
                }
                if (o instanceof InputStream) {
                    p.setBinaryStream(count,(InputStream)o);
                    continue;
                }
                if (o instanceof String) {
                    p.setString(count,(String)o);
                    continue;
                }
                throw new RuntimeException("Unhandled param:"+o);
            }
            ret=p;
            p=null;
        } finally {
            if (p!=null) p.close();
        }
        return ret;
    }

    @Override
    public void add(int size) {
        throw new RuntimeException("Not yet implemented");
    }

    @Override
    public boolean bof() {
        throw new RuntimeException("Not yet implemented");
    }

    @Override
    public void buffer(Integer pagesize, Integer behind, Integer ahead,
            Integer timeout) {
        throw new RuntimeException("Not yet implemented");
    }

    @Override
    public void build() {
        throw new RuntimeException("Not yet implemented");
    }

    @Override
    public void close() {
        FileState fs = getFileState();
        synchronized(fs.global) {
            if (fs.global.openCount>0) {
                fs.global.openCount--;
            }
            if (fs.global.openCount==0) disposeFileState();
        }
    }

    @Override
    public void delete() {
        if (!testOpen()) return;
        
        FileState fs = getFileState();
        
        StringBuilder upd = new StringBuilder();
        upd.append("DELETE FROM ");
        upd.append(fs.global.name);
        
        List<Object> params=new ArrayList<Object>();
        if (!appendPrimaryWhereClause(fs,upd,params)) return;
        
        String sql = upd.toString();
        setInternalSQL(sql,params);
        
        try {
            PreparedStatement s = prepare(fs,sql,params);
            try {
                int result = s.executeUpdate();
                if (result!=1) {
                    CErrorImpl.getInstance().setError(33,"Deleted "+result+" Rows!");
                } else {
                    for (int scan=0;scan<fs.fields.length;scan++) {
                        fs.changed[scan]=false;
                    }
                }
            } finally {
                s.close();
            }
            
        } catch (SQLException e) {
            setError(fs,e);
        }

        optCommit(fs);
        
    }


    @Override
    public boolean eof() {
        throw new RuntimeException("Not yet implemented");
    }

    @Override
    public void flush() {
    }

    @Override
    public void freeState(int state) {
        FileState save;
        synchronized(states) {
            save=states.remove(state);
        }
        if (save!=null) {
            save.free();
        }
    }

    @Override 
    public boolean duplicateCheck(ClarionKey key)
    {
        if (!testOpen()) return true;
        if (key.isProperty(Prop.DUP)) return false;

        FileState fs = getFileState();
        
        StringBuilder get = new StringBuilder();
        get.append("SELECT 1 FROM ");
        get.append(fs.global.name);
        List<Object> params=new ArrayList<Object>();
        genWhere(fs,get,key,null,0,false,params);
        
        String sql = get.toString();
        setInternalSQL(sql,params);

        PreparedStatement s = fs.statement;
        ResultSet rs = fs.result;
        
        try {
            fs.statement = prepare(fs,sql,params);
            try {
                fs.result = fs.statement.executeQuery();
                try {
                    return fs.result.next();
                } finally {
                    fs.result.close();
                }
            } finally {
                fs.statement.close();
            }
        } catch (SQLException ex) {
            setError(fs,ex);
            return true;
        } finally {
            fs.statement = s;
            fs.result = rs;
        }
    }
    
    @Override
    public void get(ClarionKey key) {
        if (!testOpen()) return;
        
        if (key!=null) {
            FileState fs = getFileState();
            StringBuilder get = new StringBuilder();
            genSelect(fs,get);
            
            List<Object> params=new ArrayList<Object>();
            genWhere(fs,get,key,null,0,false,params);

            String sql = get.toString();
            setInternalSQL(sql,params);
        
            PreparedStatement s = fs.statement;
            ResultSet rs = fs.result;
            
            try {
                fs.statement = prepare(fs,sql,params);
                try {
                    fs.result = fs.statement.executeQuery();
                    try {
                        if (fs.result.next()) {
                            copyResultSetToBuffer(fs);
                            fs.primaryKeyFields=saveKeyPosition(fs,fs.primaryKey,fs.primaryKeyFields);
                        } else {
                            CErrorImpl.getInstance().setError(35,"Reget Failed");
                        }
                    } finally {
                        fs.result.close();
                    }
                } finally {
                    fs.statement.close();
                }
            } catch (SQLException ex) {
                setError(fs,ex);
                return;
            } finally {
                fs.statement = s;
                fs.result = rs;
            }

            return;
        }
        throw new RuntimeException("Not yet implemented");
    }

    @Override
    public void get(ClarionString pointer, Integer len) {
        CErrorImpl.getInstance().setError(80,"Function not supported by driver");
    }

    @Override
    public ClarionString getNulls() {
        
        FileState fs=getFileState();
        if (fs.isnull==null) return new ClarionString("");
        
        char r[]=new char[fs.isnull.length];
        for (int scan=0;scan<r.length;scan++) {
            r[scan]=fs.isnull[scan]?'1':'0';
        }
        
        return new ClarionString(new String(r));
    }

    @Override
    public int getPointer() {
        throw new RuntimeException("Not yet implemented");
    }

    @Override
    public ClarionString getPosition(ClarionKey key) {
        if (key!=null) {
            SharedOutputStream sos = new SharedOutputStream();
            savePosition(getFileState(),sos,key,true);
            ClarionString cs = new ClarionString(sos.getSize());
            try {
                cs.deserialize(sos.getInputStream());
            } catch (IOException e) {
                e.printStackTrace();
            }
            return cs;
        }
        
        return new ClarionString("");
    }
    
    private Map<Integer,FileState> states=new HashMap<Integer, FileState>();
    private int lastStateID=0;

    @Override
    public int getState() {
        
        FileState fs = getFileState();
        
        FileState save = fs.save();
        
        synchronized(states) {
            int id = lastStateID++;
            states.put(id,save);
            return id;
        }
    }

    @Override
    public void lock() {
        testOpen();
    }

    @Override
    public void next() {
        iterate(1);
    }

    @Override
    public void previous() {
        iterate(-1);
    }
    
    public void iterate(int dir)
    {
        if (!testOpen()) return;
        
        FileState fs = getFileState();

        if (fs.quickScanResetActivated) {
            fs.quickScanResetActivated=false;
            return;
        }
        
        boolean resetOnKeyBound=false;
        
        while (true) {

            if (fs.mode == FileState.Mode.Restored) {
                ClarionKey ck = fs.scanKey;
                fs.closeCursor();
                fs.scanKey=ck;
                if (!savePosition(fs,fs.position,fs.scanFields,false)) return;
                fs.mode = FileState.Mode.Reset;
            }
            
            if (dir == 1 && fs.mode == FileState.Mode.Back) {
                ClarionKey ck = fs.scanKey;
                fs.closeCursor();
                fs.scanKey=ck;
                if (!savePosition(fs,fs.position,fs.scanFields,false)) return;
                fs.mode = FileState.Mode.Reset;
            }

            if (dir == -1 && fs.mode == FileState.Mode.Forward) {
                
                ClarionKey ck = fs.scanKey;
                fs.closeCursor();
                fs.scanKey=ck;
                if (!savePosition(fs,fs.position,fs.scanFields,false)) return;
                fs.mode = FileState.Mode.Reset;
            }

            if (fs.result!=null && fs.currentLimit>0 && fs.readCount==fs.currentLimit) {
                ClarionKey ck = fs.scanKey;
                fs.closeCursor();
                fs.scanKey=ck;
                if (!savePosition(fs,fs.position,fs.scanFields,false)) return;
                fs.mode = FileState.Mode.Reset;
            }
            
            if (fs.result == null) {
                // lets get a result set
                if (fs.mode != FileState.Mode.Reset) {
                    CErrorImpl.getInstance().setError(33, "Not reading data");
                    return;
                }

                StringBuilder select = new StringBuilder();
                genSelect(fs,select);
                
                boolean bound=false;
                
                if ( (fs.limit>0 || fs.keyBinding) 
                        && !fs.disableBinding 
                        && fs.scanKey!=null 
                        && fs.scanKey.getOrder()!=null 
                        && fs.scanKey.getOrder().length>1
                        && fs.scanKey.getOrder()[0].object instanceof ClarionNumber
                        && !resetOnKeyBound
                        && (fs.position==null || fs.position.getSize()>0))  
                {
                    bound=true;

                    if (fs.position!=null && fs.position.getSize()>0) {
                        int psize = fs.position.getBytes()[1];
                        if (psize<=1) bound=false;
                    }
                        
                }
               
                List<Object> params=new ArrayList<Object>();
                genWhere(fs,select,fs.scanKey,fs.position,dir,bound,params);
                genOrder(fs,select,fs.scanKey, dir);
                if (fs.limit>0 && fs.scanKey!=null) {
                    select.append(" LIMIT ");
                    select.append(fs.limit);
                    fs.currentLimit=fs.limit;
                    fs.readCount=0;
                }
                if (fs.offset>0 && fs.scanKey!=null) {
                    select.append(" OFFSET ");
                    select.append(fs.offset);
                    fs.offset=0;
                }

                String sql = select.toString();
                setInternalSQL(sql,params);

                try {
                    fs.statement = prepare(fs,sql,params);
                    if (fs.limit<=0) {
                        prepareForCursor(fs);
                        fs.statement.setFetchSize(500);
                    } else {
                        prepareForCursor(fs);
                        fs.statement.setFetchSize(fs.limit);
                    }
                    
                    fs.result = fs.statement.executeQuery();
                } catch (SQLException e) {
                    setError(fs,e);
                    return;
                }
                if (dir==1) fs.mode=FileState.Mode.Forward; 
                if (dir==-1) fs.mode=FileState.Mode.Back; 
            } else {
                try {
                    if (!fs.result.next()) {
                        
                        if (fs.isBounded) {

                            fs.closeCursor(false);
                            fs.mode = FileState.Mode.Reset;
                            
                            resetOnKeyBound=true;
                            
                            ClarionObject field;
                            
                            if (fs.scanFields==null) {
                                // nothing matched at all while bound

                                field=fs.fields[Math.abs(fs.scanKey.getOrder()[0].order)-1].genericLike();
                                
                                if (fs.position!=null) {
                                    SharedInputStream sis = fs.position.getInputStream();
                                    sis.read();
                                    sis.read();
                                    try {
                                        field.deserialize(sis);
                                    } catch (IOException e) {
                                        e.printStackTrace();
                                    }
                                }
                            } else {
                                field  = fs.scanFields[0].genericLike();
                                //fs.scanFields=null;
                            }

                            if (dir>0) {
                                field.increment(1);
                            } else {
                                field.decrement(1);
                            }

                            fs.position.reset();
                            fs.position.write(1); // inclusive
                            fs.position.write(1); // one field only
                            try {
                                field.serialize(fs.position);
                            } catch (IOException e) { }
                         
                            // try deserializing field just to make
                            // sure we have not triggered integer wraparound
                            // or anything similar
                            int value = field.intValue();
                            SharedInputStream sis=fs.position.getInputStream();
                            sis.read();
                            sis.read();
                            try {
                                field.deserialize(sis);
                            } catch (IOException e) {}
                            if (field.intValue()==value) {
                                continue;
                            }
                        }

                        CErrorImpl.getInstance().setError(33,"EOF Reached");
                        return;
                    }
                    if (fs.currentLimit>0) fs.readCount++;
                    
                    copyResultSetToBuffer(fs);
                    
                    fs.scanFields=saveKeyPosition(fs,fs.scanKey,fs.scanFields);
                    fs.primaryKeyFields=saveKeyPosition(fs,fs.primaryKey,fs.primaryKeyFields);
                    if (fs.quickScan) {
                        fs.quickScanBuffer=getFileBuffer(fs);
                    } else {
                        fs.quickScanBuffer=null;
                    }
                    
                    
                    return;
                    
                } catch (SQLException e) {
                    setError(fs,e);
                    return;
                }
            }
        }
    }

    private ClarionObject getFileBuffer(FileState fs) {
        
        try {
            ByteArrayOutputStream baos=new ByteArrayOutputStream();
            
            for (ClarionObject o : fs.fields ) {
                o.serialize(baos);
            }
            byte b[] = baos.toByteArray();
            char c[] = new char[b.length];
            for (int scan=0;scan<c.length;scan++) {
                c[scan]=(char)b[scan];
            }
            return new ClarionString(new String(c));
        } catch (IOException ex ) {
            throw new RuntimeException("Got some sort of IO exception",ex);
        }
    }

    @Override
    public ClarionObject[] getPrimaryKeyPosition()
    {
        FileState fs = getFileState();
        return saveKeyPosition(fs,fs.primaryKey,null);
    }
    
    @Override
    public void setPrimaryKeyPosition(ClarionObject[] position)
    {
        FileState fs = getFileState();
        fs.primaryKeyFields=position;
    }

    private ClarionObject[] saveKeyPosition(FileState fis, ClarionKey key,
            ClarionObject[] fields) 
    {
        
        if (key==null) return fields;
        
        ClarionKey.Order order[] = key.getOrder();
        if (fields!=null) {
            if (fields.length!=order.length) {
                fields=null;
            }
        }
            
        if (fields==null) {
            fields=new ClarionObject[order.length];
        }
        for (int scan=0;scan<order.length;scan++) {
            fields[scan]=fis.fields[Math.abs(order[scan].order)-1].genericLike();
        }

        return fields;
    }

    @Override
    public void create() 
    {
        CErrorImpl.getInstance().clearError();

        FileState fs = getFileState();
        if (fs.global.source==null) {
            fs.global.source=JDBCSource.get(getProperty(Prop.OWNER).toString());
        }
        
        try {
            optCommit(fs.global.source);
            
            Connection c = fs.global.source.getConnection();
            c.setAutoCommit(false);
            try {
                StringBuilder builder = new StringBuilder();
                builder.append("CREATE TABLE ");
                
                String name =  getProperty(Prop.NAME).toString().trim().toLowerCase();
                if (name.indexOf('.')>-1) {
                    name=name.substring(name.indexOf('.')+1);
                }
                builder.append(name);
                builder.append(" ( ");
                
                for (int scan=1;scan<=getVariableCount();scan++) {
                    if (scan>1) {
                        builder.append(",");
                    }
                    ClarionObject what = what(scan);
                    String fieldName=what.getName();
                    if (fieldName==null) fieldName=whoNoPrefix(scan).toString();
                    builder.append(fieldName.toLowerCase());
                    builder.append(" ");
                    
                    typeloop: while ( true ) {
                        if (what instanceof ClarionString) {
                            ClarionString s = what.getString();
                            if (s.allowedSize()>255 || s.allowedSize()==-1) {
                                builder.append("TEXT");
                            } else {
                                builder.append("VARCHAR(");
                                builder.append(what.getString().allowedSize());
                                builder.append(")");
                            }
                            break;
                        }

                        if (what instanceof ClarionNumber) {
                            switch (what.getNumber().getEncoding()) {
                            
                                case ClarionNumber.LONG:
                                case ClarionNumber.ULONG:
                                case ClarionNumber.UNSIGNED:
                                case ClarionNumber.SIGNED:
                                    builder.append("BIGINT");
                                    break typeloop;

                                case ClarionNumber.SHORT:
                                case ClarionNumber.USHORT:
                                    builder.append("INTEGER");
                                    break typeloop;
                            
                                case ClarionNumber.BYTE:
                                    builder.append("SMALLINT");
                                    break typeloop;
                                    
                                case ClarionNumber.DATE:
                                    builder.append("DATE");
                                    break typeloop;

                                case ClarionNumber.TIME:
                                    builder.append("TIME");
                                    break typeloop;
                            }
                        }

                        if (what instanceof ClarionDecimal) {
                            ClarionDecimal d = what.getDecimal();
                            builder.append("NUMERIC(");
                            builder.append(d.getSize());
                            builder.append(",");
                            builder.append(d.getPrecision());
                            builder.append(")");
                            break;
                        }
                        
                        throw new SQLException("Unknown type:"+what.getClass());
                    }
                }

                builder.append(" ) ");
                
                Statement s = c.createStatement();
                try {
                    s.execute(builder.toString());
                    
                    for (ClarionKey key : getKeys() ) {
                        builder.setLength(0);
                        
                        builder.append("CREATE ");
                        if (!key.isProperty(Prop.DUP)) {
                            builder.append("UNIQUE ");
                        }
                        builder.append("INDEX ");
                        builder.append(name);
                        builder.append("_");
                        builder.append(key.getProperty(Prop.LABEL).toString().trim().toLowerCase());
                        builder.append(" ON ");
                        builder.append(name);
                        builder.append(" (");
                        
                        boolean first=true;
                        for (Order o : key.getFields() ) {
                            
                            if (!first) {
                                builder.append(",");
                            } else {
                                first=false;
                            }
                            
                            boolean upper = key.isProperty(Prop.NOCASE) && (o.object instanceof ClarionString); 
                            if (upper) {
                                builder.append("UPPER(");
                            }
                            
                            String fieldName = o.object.getName();
                            if (fieldName==null) {
                                fieldName=whoNoPrefix(where(o.object)).toString();
                            }
                            
                            builder.append(fieldName.toLowerCase());
                            if (upper) {
                                builder.append(")");
                            }
                        }
                        builder.append(")");

                        s.execute(builder.toString());
                    }
                    
                    
                } finally {
                    s.close();
                }
                
                c.commit();
                c.setAutoCommit(true);
                c=null;
                
            } finally {
                if (c!=null) {
                    try {
                        c.rollback();
                    } catch (SQLException ex) { }
                    try {
                        c.setAutoCommit(true);
                    } catch (SQLException ex) { }
                }
            }
        } catch (SQLException ex) {
            setError(fs,ex);
        }
    }

    
    @Override
    public void open(int mode) {
        CErrorImpl.getInstance().clearError();
        
        FileState fs = getFileState();
        synchronized(fs.global) {

        
        if (fs.global.openCount==0) {
            
            
            fs.global.source=JDBCSource.get(getProperty(Prop.OWNER).toString());
            fs.global.name=getProperty(Prop.NAME).toString();

            Map<String,int[]> cl=new HashMap<String, int[]>();
            
            try {
                Connection c = null;
                try {
                    c = fs.global.source.getConnection();
                } catch (SQLException ex) {
                    CErrorImpl.getInstance().setError(90,ex.getMessage());
                    return;
                }
                String tname=fs.global.name;
                int indx = tname.indexOf('.');
                if (indx>=0) tname=tname.substring(indx+1);

                ResultSet rs;
                
                rs = c.getMetaData().getTables(null,null,tname,null);
                try {
                    if (!rs.next()) {
                        CErrorImpl.getInstance().setError(2,"File not found");
                        return;
                    }
                } finally {
                    rs.close();
                }
                
                rs = c.getMetaData().getColumns(null,null,tname,null);
                while (rs.next()) {
                    
                    String name = rs.getString(4).toLowerCase();
                    int type    = rs.getInt(5);
                    String ai="NO";
                    //if (rs.getMetaData().getColumnCount()>=23) {
                        ai= rs.getString(23);
                    //}
                    
                    cl.put(name,new int[] { type,"YES".equals(ai) ? 1: 0 } );
                }
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
                CErrorImpl.getInstance().setError(90,e.getMessage());
                String state = e.getSQLState();
                if (state!=null && !state.startsWith("57") && !state.startsWith("08")) { // not operator error
                    throw new RuntimeException("SQLError:"+state,e);
                }
                return;
            }
            
            fs.global.types=new int[getVariableCount()];
            fs.global.autoincrementing=new boolean[getVariableCount()];
            fs.global.fieldNames=new String[getVariableCount()];
            
            for (int scan=0;scan<getVariableCount();scan++) {
                
                final int pos = scan;
                final ClarionObject obj = what(pos+1);
                
                String name = obj.getName();
                if (name==null) name = whoNoPrefix(pos+1).toString();
                int val[] = cl.get(name.toLowerCase());
                if (val==null) { 
                    throw new RuntimeException("Field not Found:"+name);
                }
                fs.global.fieldNames[scan]=name;
                fs.global.types[scan]=val[0];
                fs.global.autoincrementing[scan]=val[1]==1;
            }
            
        }
        fs.global.openCount++;
        }
    }

    public boolean testWatch()
    {
        FileState fs = getFileState();

        if (fs.watchBuffer==null) return true;

        StringBuilder watchTest=new StringBuilder();
        genSelect(fs,watchTest);
        List<Object> params=new ArrayList<Object>();
        appendPrimaryWhereClause(fs,watchTest,params);
        String sql = watchTest.toString();
        setInternalSQL(sql,params);
        
        FileState watch = fs.save();
        watch.watchArmed=false;
        watch.watchBuffer=null;

        boolean ok = false;
        
        try {
            watch.statement = prepare(fs,sql,params);
            try {
                watch.result = watch.statement.executeQuery();
                try {
                    if (watch.result.next()) {
                        copyResultSetToBuffer(watch);
                        ok=true;
                        for (int scan=0;scan<fs.fields.length;scan++) {
                            if (!fs.watchBuffer[scan].equals(watch.fields[scan])) {
                                ok=false;
                                break;
                            }
                        }
                    }
                } finally {
                    watch.result.close();
                }
            } finally {
                watch.statement.close();
            }
        } catch (SQLException ex) { 
            setError(fs,ex);
            return false;
        } finally {
            fs.watchBuffer=null;
        }
        
        if (!ok) {
            CErrorImpl.getInstance().setError(89,"Watch failed");
            return false;
        }
        
        return true;
    }

    @Override
    public void put() {
        if (!testOpen()) return;
        
        FileState fs = getFileState();

        if (!testWatch()) return;
        
        StringBuilder upd = new StringBuilder();
        upd.append("UPDATE ");
        upd.append(fs.global.name);
        upd.append(" SET ");
        
        List<Object> params=new ArrayList<Object>();
        
        boolean first=true;
        for (int scan=0;scan<fs.fields.length;scan++) {
            if (!fs.changed[scan]) continue;
            
            if (first) {
                first=false;  
            } else {
                upd.append(',');
            }
            upd.append(fs.global.fieldNames[scan]);
            upd.append('=');
            encodeValue(upd,fs.isnull[scan]?null:fs.fields[scan],fs.global.types[scan],params,null);
        }
        
        if (first==true) {
            // nothing to update
            return;
        }
        
        if (!appendPrimaryWhereClause(fs,upd,params)) return;
        
        String sql = upd.toString();
        setInternalSQL(sql,params);
        
        try {
            
            int result=0;
            
            PreparedStatement ps = prepare(fs,sql, params);
            try {
                result = ps.executeUpdate();
            } finally {
                ps.close();
            }
                
            if (result != 1) {
                CErrorImpl.getInstance().setError(33,"Updated " + result + " Rows!");
            } else {
                for (int scan = 0; scan < fs.fields.length; scan++) {
                    fs.changed[scan] = false;
                }
            }
        } catch (SQLException e) {
            setError(fs,e);
        }

        optCommit(fs);
        
    }


    @Override
    public int records() {
        
        if (!testOpen()) return 0;
        
        
        FileState fs = getFileState();

        StringBuilder q=new StringBuilder();
        q.append("SELECT count(*) FROM ");
        q.append(fs.global.name);
        initWhere(q);
        
        try {
            Statement s = fs.global.source.getConnection().createStatement();
            try {
                ResultSet rs = s.executeQuery(q.toString());
                try {
                    rs.next();
                    return rs.getInt(1);
                } finally {
                    rs.close();
                }
            } finally {
                s.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public void reget(ClarionKey key,ClarionString string) {

        if (!testOpen()) return;
        
        if (key!=null) {
            FileState fs = getFileState();
            StringBuilder get = new StringBuilder();
            genSelect(fs,get);
            
            SharedOutputStream sos=new SharedOutputStream();
            try {
                string.serialize(sos);
            } catch (IOException e) {
                e.printStackTrace();
            }
            List<Object> params=new ArrayList<Object>(); 
            genWhere(fs,get,key,sos,0,false,params);
            
            String sql = get.toString();
            setInternalSQL(sql,params);
        
            PreparedStatement s = fs.statement;
            ResultSet rs = fs.result;
            
            try {
                fs.statement = prepare(fs,sql,params);
                try {
                    fs.result = fs.statement.executeQuery();
                    try {
                        if (fs.result.next()) {
                            copyResultSetToBuffer(fs);
                            fs.primaryKeyFields=saveKeyPosition(fs,fs.primaryKey,fs.primaryKeyFields);
                        } else {
                            CErrorImpl.getInstance().setError(35,"Reget Failed");
                        }
                    } finally {
                        fs.result.close();
                    }
                } finally {
                    fs.statement.close();
                }
            } catch (SQLException ex) {
                setError(fs,ex);
                return;
            } finally {
                fs.statement = s;
                fs.result = rs;
            }

            return;
        }
        throw new RuntimeException("Not yet implemented");
    }

    @Override
    public void remove() {
        throw new RuntimeException("Not yet implemented");
    }

    @Override
    public void reset(ClarionKey key,ClarionString string) {
        if (!testOpen()) return;

        FileState fs = getFileState();
        
        if (fs.quickScan && key==fs.scanKey && key!=null &&  
                ( fs.mode==FileState.Mode.Back || fs.mode==FileState.Mode.Forward) 
        ) {
            if (!getFileBuffer(fs).equals(fs.quickScanBuffer)) {
                if (log.isLoggable(Level.FINE)) {
                    log.fine("Not using quick scan : scan ok failed");
                }
            } else { 
                if (isPositionMatches(string, fs.scanFields)) {
                    if (log.isLoggable(Level.FINE)) {
                        log.fine("Using Quick scan:" + string);
                    }
                    fs.quickScanResetActivated = true;
                    return;
                }
            }
        }
        
        fs.closeCursor();
        
        fs.mode=FileState.Mode.Reset;
        fs.scanFields=null;
        fs.scanKey=key;
        fs.position.reset();
        try {
            string.serialize(fs.position);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void restoreState(int state) {
        
        FileState fs = getFileState();
        
        FileState save;
        synchronized(states) {
            save = states.get(state);
        }
        
        if (save!=null) {
            
            try {
                if (save.result!=null && save.result.isClosed()) {
                    save.closeCursor(false,false);
                }
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            
            if (fs.result!=save.result) {
                fs.closeCursor(false,false);           // close any new cursor
            }
            fs.restore(save);
        }
    }

    @Override
    public void send(String operator) 
    {
        log.info("Ignoring SQL Driver send instruction:"+operator);
    }

    @Override
    public void set(ClarionKey key) {
        if (!testOpen()) return;

        FileState fs = getFileState();
        fs.closeCursor();
        
        fs.mode=FileState.Mode.Reset;
        fs.scanKey=key;
        fs.scanFields=null;
    }
    

    @Override
    public void set(int position) {
        throw new RuntimeException("Not yet implemented");
    }

    @Override
    public void setNulls(ClarionString nulls) {
        
        if (nulls==null) return;
        
        FileState fs=getFileState();
        
        String s=nulls.toString();
        for (int scan=0;scan<fs.isnull.length;scan++) {
            if (scan>=s.length()) break;
            fs.isnull[scan]=s.charAt(scan)=='1';
        }
    }

    @Override
    public void stream() {
        throw new RuntimeException("Not yet implemented");
    }

    @Override
    public void unlock() {
        testOpen();
    }

    @Override
    public void watch() {
        if (!testOpen()) return;
        getFileState().watchArmed=true;
    }

    private static void encodePaddedNumber(StringBuilder target,int length,int val)
    {
        target.setLength(target.length()+length);
        int pos = target.length()-1;
        while (length>0) {
            target.setCharAt(pos, (char)('0'+(val%10)));
            pos--;
            length--;
            val=val/10;
        }
    }


    private void copyResultSetToBuffer(FileState fs) {
        try {
            fs.ignoreChange=true;
            
            for (int scan=0;scan<fs.global.fieldNames.length;scan++) {
                
                fs.changed[scan]=false;
                fs.isnull[scan]=false;
                switch (fs.global.types[scan]) {
                    case Types.DATE: 
                    case Types.TIMESTAMP: {
                        Date d = fs.result.getDate(scan+1,Calendar.getInstance());
                        if (d==null) {
                            fs.fields[scan].setValue(0);
                            fs.isnull[scan]=true;
                        } else {
                            fs.fields[scan].setValue(CDate.epochToClarionDate(d.getTime()));
                        }
                        break;
                    }
                    case Types.TIME: { 
                        Date d = fs.result.getTime(scan+1,Calendar.getInstance());
                        if (d==null) {
                            fs.fields[scan].setValue(0);
                            fs.isnull[scan]=true;
                        } else {
                            Calendar c = Calendar.getInstance();
                            c.setTime(d);
                            fs.fields[scan].setValue(
                                    c.get(Calendar.HOUR_OF_DAY)*360000+
                                    c.get(Calendar.MINUTE)*6000+
                                    c.get(Calendar.SECOND)*100+
                                    c.get(Calendar.MILLISECOND)/10+1);
                        }
                        break;
                    }
                    case Types.BIGINT:
                    case Types.INTEGER:
                    case Types.SMALLINT:
                        fs.fields[scan].setValue(fs.result.getInt(scan+1));
                        break;

                    case Types.BOOLEAN:
                    case Types.BIT:
                        fs.fields[scan].setValue(fs.result.getBoolean(scan+1));
                        break;

                    case Types.DECIMAL:
                    case Types.NUMERIC:
                        fs.fields[scan].setValue(fs.result.getBigDecimal(scan+1));
                        break;

                    case Types.VARCHAR:

                        // TODO : This code needs some work
                        // need to find a better way to deal with
                        // rogue \u0080's in the stream
                        
                        String value = fs.result.getString(scan+1);
                        
                        if (value!=null) {
                            boolean bool=false;
                            for (int s2=0;s2<value.length();s2++) {
                                char c=value.charAt(s2);
                                if (c>255) bool=true;
                            }
                            if (bool) {
                                char nc[]=value.toCharArray();
                                
                                for (int s2=0;s2<nc.length;s2++) {
                                    if (nc[s2]>255) {
                                        //if (nc[s2]==65533) {
                                            nc[s2]=128;
                                        //}
                                    }
                                    if (nc[s2]>255) {
                                        throw new RuntimeException("NC:"+((int)nc[s2]));
                                    }
                                }
                                value=new String(nc);
                            }
                            fs.fields[scan].setValue(value);
                        } else {
                            fs.fields[scan].clear();
                            fs.isnull[scan]=true;
                        }
                        
                        break;
                        
                    case Types.BINARY: {
                        byte bits[] = fs.result.getBytes(scan+1);
                        if (bits==null) {
                            bits=new byte[0];
                            fs.isnull[scan]=true;
                        }
                        char cbits[]=new char[bits.length];
                        for (int bs=0;bs<cbits.length;bs++) {
                            cbits[bs]=(char)(bits[bs]&0xff);
                        }
                        fs.fields[scan].setValue(new String(cbits));
                        break;
                    }
                    default:
                        throw new RuntimeException("Unknown SQL Type:"+fs.global.types[scan]+" : "+fs.global.fieldNames[scan]);
                }
            }
        } catch (SQLException ex) {
            setError(fs,ex);
        } finally {
            fs.ignoreChange=false;
        }

        if (fs.watchBuffer!=null) {
            // clear watch it was never used
            fs.watchBuffer=null;
        }
        
        if (fs.watchArmed) {
            fs.watchArmed=false;
            fs.watchBuffer=new ClarionObject[fs.fields.length];
            for (int scan=0;scan<fs.fields.length;scan++) {
                fs.watchBuffer[scan]=fs.fields[scan].genericLike();
            }
        }
    }

    public static void encodeValue(StringBuilder target,ClarionObject obj,int type)
    {
        encodeValue(target,obj,type,null,null);
    }

    
    
    public static void encodeFilter(StringBuilder target,String name,int op,boolean inclusive,ClarionObject obj,int type,List<Object> params,String function)
    {
        boolean potentialNull = type == Types.DATE || type == Types.TIME;
        boolean isNull=false;
        if (potentialNull) {
            if ( (obj==null) || ( (type == Types.DATE || type == Types.TIME) && obj.intValue()==0) )  {
                isNull=true;
            }
        }
        
        if (isNull && op>0 && inclusive) {
            target.append("1=1");
            return;
        }

        if (isNull && op<0 && !inclusive) {
            target.append("1=0");
            return;
        }
        
        boolean brackets = potentialNull && (!isNull) && op<0; 
        
        if (brackets) target.append("(");
        
        if (function!=null) {
            target.append(function).append('(');
        }
        target.append(name);
        
        if (function!=null) {
            target.append(')');
        }

        boolean added=false;
        
        if (op==0) {
            if (isNull) {
                target.append(" IS NULL");
                added=true;
            } else {
                target.append('=');
            }
        } else {
            
            if (potentialNull) {

                
                
                if (op>0) {
                    if (isNull) {
                        target.append(" IS NOT NULL");
                        added=true;
                    }
                } else {
                    if (isNull) {
                        target.append(" IS NULL");
                        added=true;
                    } else {
                        target.append(" IS NULL OR ");
                        if (function!=null) {
                            target.append(function).append('(');
                        }
                        target.append(name);
                        
                        if (function!=null) {
                            target.append(')');
                        }
                    }
                }
            }
            
            if (!added) {
                target.append(op>0 ? '>' : '<');
                if (inclusive) target.append('=');
            }
        }
        
        if (!added) {
            encodeValue(target,obj,type,params,function);
        }
        
        if (brackets) target.append(")");
    }
    
    
    public static void encodeValue(StringBuilder target,ClarionObject obj,int type,List<Object> params,String function)
    {
        if ("upper".equals(function)) obj=obj.getString().upper();
        
        
        if (obj==null) {
            target.append("null");
            return;
        }
        
        switch (type) {
            case Types.DATE: 
            case Types.TIMESTAMP:
            {
                int val = obj.intValue();
                if (val==0) { 
                    target.append("null");
                    return;
                };
                Calendar c = Calendar.getInstance();
                CDate.clarionDateToEpoch(val,c);
                target.append('\'');
                encodePaddedNumber(target,4,c.get(Calendar.YEAR));
                target.append('-');
                encodePaddedNumber(target,2,c.get(Calendar.MONTH)-Calendar.JANUARY+1);
                target.append('-');
                encodePaddedNumber(target,2,c.get(Calendar.DAY_OF_MONTH));
                target.append('\'');
                return;
            }
            
            case Types.TIME: 
            {
                int val = obj.intValue();
                if (val==0) { 
                    target.append("null");
                    return;
                };
                target.append('\'');
                val=val-1;
                encodePaddedNumber(target,2,val/360000);
                target.append(':');
                encodePaddedNumber(target,2,(val/6000)%60);
                target.append(':');
                encodePaddedNumber(target,2,(val/100)%60);
                target.append('\'');
                return;
            }
            
            case Types.BIGINT:
            case Types.INTEGER:
            case Types.SMALLINT:
                target.append(obj.intValue());
                return;

            case Types.BOOLEAN:
            case Types.BIT:
                target.append(obj.boolValue()?"1":"0");
                return;

            case Types.DECIMAL:
            case Types.NUMERIC:
                target.append(obj.getDecimal().toString());
                return;

            case Types.VARCHAR:
            {
                String val = obj.toString();
                
                int len=val.length();
                while (len>0 && val.charAt(len-1)==' ') len--;
                
                boolean allZeros=true;
                for (int scan=0;scan<len;scan++) {
                    char c=val.charAt(scan);
                    if (c!=0) {
                        allZeros=false;
                        break;
                    }
                }
                if (allZeros) len=0; 
                
                boolean binary=false;
                int start =target.length();
                target.append('\'');
                for (int scan=0;scan<len;scan++) {
                    char c=val.charAt(scan);
                    if (c<32 || c>127) {
                        if (params!=null) {
                            binary=true;
                            break;
                        } else {
                            continue;
                        }
                    }
                    if (c=='\\' || c=='\'') {
                        if (params!=null) {
                            binary=true;
                            break;
                        } else {
                            target.append(c);
                        }
                    }
                    target.append(c);
                }
                
                if (!binary) {
                    target.append('\'');
                } else {
                    target.setLength(start);
                    if (params!=null) {
                        params.add(val!=null && len!=val.length() ? val.substring(0,len) : val);
                    }
                    target.append('?');
                }
                return;
            }
            
            case Types.BINARY:
            {
                String content = obj.toString();
                int len = content.length();
                while (len>0) {
                    if (content.charAt(len-1)!=' ') break;
                    len--;
                }
                byte bits[]=new byte[len];
                for (int s=0;s<len;s++) {
                    bits[s]=(byte)content.charAt(s);
                }
                if (params!=null) {
                    params.add(bits);
                }
                target.append('?');
                return;
            }
            
            default:
                throw new RuntimeException("Unknown SQL Type:"+type);
        }
    }
    
    
    private void genSelect(FileState fs,StringBuilder select) {
        if (fs.select==null) {
            StringBuilder tselect=new StringBuilder();
            tselect.append("SELECT ");
            for (int scan=0;scan<fs.global.fieldNames.length;scan++) {
                if (scan>0) tselect.append(',');
                tselect.append(fs.global.fieldNames[scan]);
            }
            tselect.append(" FROM ");
            tselect.append(fs.global.name);
            fs.select=tselect;
        }
        select.append(fs.select);
    }

    private void genOrder(FileState fs,StringBuilder buff,ClarionKey scanKey,int direction) {
        if (scanKey==null) return;

        ClarionKey.Order order[] = scanKey.getOrder();
        if (order==null) return;
        if (order.length==0) return;
        
        boolean nocase = scanKey.isProperty(Prop.NOCASE);
        
        buff.append(" ORDER BY ");
        for (int scan=0;scan<order.length;scan++) {
            int dir = order[scan].order*direction;
            int pos = Math.abs(order[scan].order)-1;
        
            if (scan>0) buff.append(",");

            if ( (nocase && fs.global.types[pos]==Types.VARCHAR) || ("upper".equals(order[scan].function)) ) {
                buff.append("UPPER(");
            }
            
            buff.append(fs.global.fieldNames[pos]);
            
            if ( (nocase && fs.global.types[pos]==Types.VARCHAR) || ("upper".equals(order[scan].function)) ) {
                buff.append(")");
            }
            
            if (dir<0) {
                buff.append(" DESC");
            }
            
            if (fs.global.types[pos]==Types.DATE || fs.global.types[pos]==Types.TIME) {
                if (dir<0) {
                    buff.append(" NULLS LAST");
                } else {
                    buff.append(" NULLS FIRST");
                }
            }
        }
    }

    private boolean appendPrimaryWhereClause(FileState fs,StringBuilder upd,List<Object> params) {
        
        ClarionKey ck = fs.primaryKey;
        if (ck==null) {
            CErrorImpl.getInstance().setError(33,"No Primary Key!");
            return false;
        }
        
        SharedOutputStream sos = new SharedOutputStream();
        if (fs.primaryKeyFields==null) {
            CErrorImpl.getInstance().setError(33,"Primary Key position not established!");
            return false;
        }
        savePosition(fs,sos,fs.primaryKeyFields,true);
        genWhere(fs,upd,ck,sos,0,false,params);
        
        return true;
    }
    
    protected boolean initWhere(StringBuilder sb)
    {
        return false;
    }

    /**
     * Generate where clause from given key, position and direction 
     * 
     * @param buff      Buffer to write int
     * @param key       Key to use. If null than file sequental order
     * @param position  Position to source. if null then use buffer. if length=0 then no position
     * @param direction direction. -1 = backwards. 1 = forwards. 0 = exact match only
     * @param bound     if true then limit where clause on assumption that first component of key is only boundary we are interested in.
     *                  if it turns out not to be the case then later redefinition of query will correct for this 
     */
    private void genWhere(FileState fs,StringBuilder buff,ClarionKey key,SharedOutputStream position,int direction,boolean bound,List<Object> params) 
    {
        boolean where = initWhere(buff);
        if (position!=null) {
            if (position.getSize()==0) return;;              
        }
        
        if (key!=null) {
            ClarionKey.Order order[] = key.getOrder();
            ClarionObject bits[]=new ClarionObject[order.length];
            boolean inclusive=false;
            boolean nocase = key.isProperty(Prop.NOCASE);
            int size=0;
            
            if (position!=null) {
                SharedInputStream is = position.getInputStream();
                
                int flags= is.read();
                if (flags==1) inclusive=true;
                size = is.read();
                if (size>bits.length) size=bits.length;
                for (int scan=0;scan<size;scan++) {
                    bits[scan]=fs.fields[Math.abs(order[scan].order)-1].genericLike();
                    try {
                        bits[scan].deserialize(is);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                size=bits.length;
                for (int scan=0;scan<bits.length;scan++) {
                    bits[scan]=fs.fields[Math.abs(order[scan].order)-1];
                }
            }
            
            if (where) {
                buff.append(" AND (");
            } else {
                buff.append(" WHERE (");
            }
            if (direction==0) {
                // easy one field=<value> (AND)*
                for (int scan=0;scan<size;scan++) {
                    
                    int pos = Math.abs(order[scan].order)-1;
                    
                    if (scan>0) buff.append(" AND ");
                    
                    encodeFilter(buff,fs.global.fieldNames[pos],0,false,bits[scan],fs.global.types[pos],params,
                    order[scan].function==null && nocase && fs.global.types[pos]==Types.VARCHAR ? "upper" : order[scan].function );  
                }
                buff.append(')');
                return;
            }
            
            /*
             *  HARD one. Consider field 1, field 2
             *  field1><value> OR (field1=<value> AND ([field<n>]))
             *  
             *  If bound is set although, then need to do as follows
             *   
             */
            
            int start=0;
            if (bound) {
                start=1;
                int pos=Math.abs(order[0].order)-1;
                encodeFilter(buff,fs.global.fieldNames[pos],0,false,bits[0],fs.global.types[pos],params,
                order[0].function==null && nocase && fs.global.types[pos]==Types.VARCHAR ? "upper" : order[0].function );  
                buff.append(") AND (");
            }
            fs.isBounded=bound;

            if (start>=size) {
                throw new RuntimeException("What is going on here?");
            }
            
            for (int scan=start;scan<size;scan++) {

                if (scan>start) {
                    buff.append(" OR (");
                    int pos=Math.abs(order[scan-1].order)-1;
                    encodeFilter(buff,fs.global.fieldNames[pos],0,false,bits[scan-1],fs.global.types[pos],params,
                    order[scan-1].function==null && nocase && fs.global.types[pos]==Types.VARCHAR ? "upper" : order[scan-1].function );  
                    buff.append(" AND (");
                }

                int pos = Math.abs(order[scan].order)-1;
                int dir = order[scan].order*direction;
                
                encodeFilter(buff,fs.global.fieldNames[pos],dir,scan==size-1 && inclusive,bits[scan],fs.global.types[pos],params,
                order[scan].function==null && nocase && fs.global.types[pos]==Types.VARCHAR ? "upper" : order[scan].function );  
            }

            for (int scan=start;scan<size-1;scan++) {
                buff.append("))");
            }
                
            buff.append(")");
            
            return;
        }
        
        return;
        //throw new RuntimeException("Not yet Implemented");
    }
    

    public boolean savePosition(FileState fs,SharedOutputStream position, ClarionKey scanKey,
            boolean inclusive) {
        
        if (scanKey!=null) {
            position.write(inclusive? 1 : 0);
            ClarionKey.Order order[] = scanKey.getOrder();
            position.write(order.length);
            for (int scan = 0; scan < order.length; scan++) {
                try {
                    fs.fields[Math.abs(order[scan].order) - 1].serialize(position);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            return true;
        }
        
        throw new RuntimeException("Saving non Keyed position not supported!");
    }

    public boolean savePosition(FileState fs,SharedOutputStream position, ClarionObject obj[],
            boolean inclusive) {
        
        if (obj==null) {
            return true;
        }
        
        position.write(inclusive ? 1 : 0);
        position.write( obj.length );
        for (int scan=0;scan<obj.length;scan++) {
            try {
                obj[scan].serialize(position);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return true;
    }
    
    private boolean internalSQL;
    
    private void setInternalSQL(String sql,List<Object> params) {
        try {
            internalSQL=true;
            setProperty(Prop.SQL,sql);
        } finally {
            internalSQL=false;
        }
        log.fine(sql+" ["+params+"]");
    }

    private void setError(FileState fs,SQLException ex) {
        String state = ex.getSQLState();
        if (state==null) state="(unknown)";
        
        if (state.equals("34000")) {
            throw new RuntimeException("Cursor Error",ex);
        }
        
        if (state.startsWith("25")) {
            // transaction state type errors
            //try {
            //    fs.global.source.getConnection().rollback();
            //} catch (SQLException e) { }
        }
        
        int error=90; 
        if (state!=null && state.equals("23505")) error=40;

        
        if (error==90) {
            log.warning("SQLException : "+ex.getMessage()+" "+state);
            ex.printStackTrace();
        }
        CErrorImpl.getInstance().setError(error,ex.getMessage());
    }

    @Override
    protected String getDriver() {
        return "JDBC";
    }

    private static final Pattern selectCommand=Pattern.compile("^(?i)\\s*(select)\\s+");
    
    private static final Pattern beginCommand=Pattern.compile("^(?i)\\s*(begin|(start(\\s+)transaction))\\s*(;|$)");

    private static final Pattern commitCommand=Pattern.compile("^(?i)\\s*(commit)\\s*(;|$)");

    private static final Pattern rollbackCommand=Pattern.compile("^(?i)\\s*(rollback)\\s*(;|$)");
    
    @Override
    protected void setFileProperty(int index, ClarionObject value) {
        
        if (index==Prop.SQL) {
            if (internalSQL) return;
            
            if (!testOpen()) return;
            
            FileState fs = getFileState();
            fs.closeCursor();
            fs.mode=FileState.Mode.User;
            
            try {
                String op = value.toString().trim();

                log.fine("PROP:SQL = "+op);
                
                fs.statement=fs.global.source.getConnection().prepareStatement(op);
                
                boolean select=false;
                select = selectCommand.matcher(op).find();
                
                if (select) {
                    prepareForCursor(fs);
                    fs.statement.setFetchSize(500);
                    fs.result=fs.statement.executeQuery();
                } else {
                    
                    optCommit(fs);
                    
                    while ( true ) {
                        if (beginCommand.matcher(op).matches()) {
                            fs.global.source.getConnection().setAutoCommit(false);
                            break;
                        }

                        if (commitCommand.matcher(op).matches()) {
                            fs.global.source.getConnection().commit();
                            fs.global.source.getConnection().setAutoCommit(true);
                            break;
                        }

                        if (rollbackCommand.matcher(op).matches()) {
                            try {
                                fs.global.source.getConnection().rollback();
                            } catch (SQLException ex) { }
                            fs.global.source.getConnection().setAutoCommit(true);
                            break;
                        }
                        
                        fs.statement.execute();
                        break;
                    }
                }
            } catch (SQLException ex) {
                setError(fs,ex);
            }
            
            return;
        }
        
        super.setFileProperty(index, value);
    }

    public void setQuickScan() {
        getFileState().quickScan=true;
    }

    @Override
    public void get(ClarionNumber position, Integer len) {
        throw new RuntimeException("Not yet implemented");
    }


    public static void optCommit(FileState fs) 
    {
        optCommit(fs.global.source);
    }

    public static void optCommit(AbstractJDBCSource source) 
    {
        try {
            if (source.get(FORCED_AUTO_COMMIT)!=null) {
                source.put(FORCED_AUTO_COMMIT,null);
                Connection c= source.getConnection();
                try {
                    c.commit();
                } catch (SQLException ex) {  
                    try {
                        c.rollback();
                    } catch (SQLException rex) {  }
                }
                try {
                    c.setAutoCommit(true);
                } catch (SQLException ex){  }
            }
        } catch (SQLException ex){  }
    }
    
    private void prepareForCursor(FileState fs) throws SQLException
    {
        if (fs.global.source.getConnection().getAutoCommit()) {
            fs.global.source.getConnection().setAutoCommit(false);
            fs.global.source.put(FORCED_AUTO_COMMIT,Boolean.TRUE);
        }
    }


}
