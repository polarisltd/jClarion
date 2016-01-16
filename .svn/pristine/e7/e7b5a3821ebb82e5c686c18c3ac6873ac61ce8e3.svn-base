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

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

//import org.jclarion.Params;
import org.jclarion.clarion.primative.AbstractStateFactory;
import org.jclarion.clarion.primative.AbstractStateGetter;
import org.jclarion.clarion.primative.GlobalStateGetter;
import org.jclarion.clarion.primative.ThreadStateGetter;
import org.jclarion.clarion.runtime.CErrorImpl;
import org.jclarion.clarion.util.FileState;
import org.jclarion.clarion.util.SharedInputStream;
import org.jclarion.clarion.util.SharedOutputStream;
import org.jclarion.clarion.constants.*;
import org.jclarion.clarion.hooks.FilecallbackParams;
import org.jclarion.clarion.hooks.Filecallbackinterface;

/**
 *  Provide abstract model of a File entity in clarion.
 *  
 * @author barney
 *
 */
public abstract class ClarionFile extends ClarionGroup
{
    private List<ClarionKey> keys=new ArrayList<ClarionKey>();

    public int getSQLType(ClarionObject o)
    {
        FileState fs=  getFileState();
        int indx = fs.getFieldIndex(o);
        return fs.global.types[indx];
    }

    private static class StateFactory extends AbstractStateFactory<FileState>
    {
        @Override
        public FileState cloneState(FileState base) {
            return new FileState(base);
        }

        @Override
        public FileState createState() {
            return new FileState();
        }
    }
    private static StateFactory factory=new StateFactory();
    
    private AbstractStateGetter<FileState> state=new GlobalStateGetter<FileState>(factory);

    @Override
    protected void initThread()
    {
        if (!state.isThreaded()) state=new ThreadStateGetter<FileState>(factory,state);
        super.initThread();
    }
    
    public void setCreate()
    {
        setProperty(Prop.CREATE,true);
    }
    
    /**
     * Add sort key
     * 
     * @param key
     */
    public void addKey(ClarionKey key) 
    {
        keys.add(key);
        key.setFile(this);
    }

    /**
     * Remove a sort key. Used by views
     * 
     * @param key
     */
    public void removeKey(ClarionKey key) 
    {
        keys.remove(key);
        key.setFile(null);
    }
    
    public void setNoMemo()
    {
    }
    
    public int getBytes()
    {
        return 0;
    }

    public void removeKeys() 
    {
        keys.clear();
    }
    
    
    /**
     * Specify owner of the file. For SQL drivers it indicates where 
     * want to connect to 
     * 
     * @param source also known as owner
     * @return
     */
    public ClarionFile setSource(ClarionString source)
    {
        setProperty(Prop.OWNER,source);
        return this;
    }

    /**
     * Set name of file to read. i.e. file name for filesystem access
     * and table name ofr SQL access
     *  
     * @param name
     * @return
     */
    public ClarionFile setName(String name)
    {
        setProperty(Prop.NAME,name);
        return this;
    }

    public ClarionFile setName(ClarionString name)
    {
        setProperty(Prop.NAME,name);
        return this;
    }


    /**
     * Open the file in read/write local but deny write others mode
     */
    public void open()
    {
        open(0x22);
    }

    /**
     * Set output write caching on a file. By default it is disabled. Only
     * applies for filesystem type files.
     */
    public abstract void stream();

    /**
     *  Delete a file.
     */
    public abstract void remove();

    /**
     *  Flush file buffers. Only applies for filesystem type files.
     */
    public abstract void flush();

    /**
     *  Open file in particular mode. Supported modes are:
     *  
     *  User access:
     *      x00 = read only
     *      x01 = write only
     *      x02 = read/write
     *      
     *  Remote access:
     *      x00 = any
     *      x10 = deny all    
     *      x20 = deny write    
     *      x30 = deny read    
     *      x40 = deny nothing    
     *      
     * Open default is x22 = Read/Write user but deny write remote.     
     *      
     * @param mode
     */
    public abstract void open(int mode);

    /**
     *  Close a file
     */
    public abstract void close();

    /**
     *  Rebuild key files
     */
    public abstract void build();

    /**
     *  Get next record in current sequence
     */
    public abstract void next();
    
    /**
     *  Get prior record in current sequence
     */
    public abstract void previous();

    /**
     * Rewrite current record
     */
    public abstract void put();

    /**
     *  Delete current record
     *  
     */
    public abstract void delete();

    /**
     *  Create new file. If file already exists it will be overwritten. 
     *  this call open after.
     */
    public abstract void create();

    /**
     *  Lock file
     */
    public abstract void lock();
    
    /**
     * Enable optimistic locking. 
     * 
     * On next get,next,previous or reget. make a note of contents of record.
     * 
     * On subsequent put, fail operation if the record has changed in anyway
     * error code for failure is 89.
     * 
     * A second get,next,previous or reget will cancel the watch.
     */
    public abstract void watch();
    
    /**
     * Set record paging. We will never bother with this one but will make
     * it abstract anyway.
     * 
     * @param pagesize
     * @param behind
     * @param ahead
     * @param timeout
     */
    public abstract void buffer(Integer pagesize,Integer behind,Integer ahead,Integer timeout);

    /**
     * Unlock previously locked file
     */
    public abstract void unlock();

    /**
     * Get record based on particular key
     * @param akey
     */
    public abstract void get(ClarionKey akey);
    
    /**
     * insert new record based on contents of record buffer
     */
    public abstract void add();

    /**
     * insert new record writing only fixed # of bytes. Mainly for ascii
     * and binary file drivers
     */
    public abstract void add(int size);

    /**
     * Return number of records in file
     * @return
     */
    public abstract int records();
    
    /**
     * retrieve record based on specified pointer position - previously
     * returned by pointer command.
     * 
     * @param pointer - the position to get
     * @param len - the number of bytes to read, for dos drivers etc
     * 
     * @return
     */
    public abstract void get(ClarionString pointer,Integer len);

    public abstract void get(ClarionNumber position, Integer len);
    
    
    /**
     *  Return true if at end of file
     * @return
     */
    public abstract boolean eof();

    /**
     *  Retrun true if at beginning of file
     * @return
     */
    public abstract boolean bof();

    /**
     *  Set sequentual record processing
     */
    public final void set()
    {
        set(null);
    }

    /**
     *  Set key based record processing
     */
    public abstract void set(ClarionKey key);
    
    
    /**
     * Set sequentual record processing starting at position
     *  
     * @param position position - as returned by position method
     */
    public abstract void set(int position);

    /**
     *  Send special command to the file driver 
     * @param operator
     */
    public abstract void send(String operator);
    
    protected byte[] decodeByteArraySend(String value)
    {
        StringTokenizer tok = new StringTokenizer(value," ,");
        byte result[]=new byte[Integer.parseInt(tok.nextToken())];
        for (int scan=0;scan<result.length;scan++) {
            result[scan]=Byte.parseByte(tok.nextToken());
        }
        return result;
    }

    protected char[] decodeCharArraySend(String value)
    {
        StringTokenizer tok = new StringTokenizer(value," ,");
        char result[]=new char[Integer.parseInt(tok.nextToken())];
        for (int scan=0;scan<result.length;scan++) {
            result[scan]=(char)Byte.parseByte(tok.nextToken());
        }
        return result;
    }
    
    private PropertyObject prop=new PropertyObject() {
        public PropertyObject getParentPropertyObject() {
            return null;
        }

        @Override
        public ClarionObject getLocalProperty(int index) {
            return getFileProperty(index);
        }

        @Override
        protected void notifyLocalChange(int indx, ClarionObject value) {
            // TODO Auto-generated method stub
            setFileProperty(indx,value);
        }

        @Override
        protected void debugMetaData(StringBuilder sb) {
        }
    };
    
    protected abstract String getDriver();
    
    protected ClarionObject getFileProperty(int index)
    {
        switch(index) { 
            case Prop.FIELDS:
                return Clarion.newNumber(getVariableCount());
            case Prop.KEYS:
                return Clarion.newNumber(keys.size());
            case Prop.DRIVER:
                return Clarion.newString(getDriver());
        }
        return null;
    }
    
    protected void setFileProperty(int index,ClarionObject value)
    {
    }

    public final void setClonedProperty(Object index, Object value) {
        prop.setClonedProperty(index,value);
    }
    
    public final void setProperty(Object index, Object value) {
        prop.setProperty(index,value);
    }

    /**
     * Set file property. i.e. prop:owner, etc
     * @param index
     * @param value
     */
    public void setProperty(ClarionObject index, ClarionObject value) {
        prop.setProperty(index,value);
    }

    public final void setClonedProperty(Object key, Object index, Object value) {
        prop.setClonedProperty(key,index,value);
    }
    
    public final void setProperty(Object key,Object index, Object value) {
        prop.setProperty(key,index,value);
    }
    
    /**
     * Set file property.
     * @param key
     * @param index
     * @param value
     */
    public void setProperty(ClarionObject key,ClarionObject index, ClarionString value) {
        prop.setProperty(key,index,value);
    }

    public final ClarionObject getProperty(Object index) {
        return prop.getProperty(index);
    }
    
    /**
     * get file property.
     * @param key
     * @param index
     * @param value
     */
    public ClarionObject getProperty(ClarionObject index) {
        return prop.getProperty(index);
    }

    public final ClarionObject getProperty(Object key,Object index) {
        
        int okey = Clarion.getClarionObject(key).intValue();
        ClarionObject oindex = Clarion.getClarionObject(index);
        
        if (okey==Prop.LABEL) {
            return new ClarionString(flatWho(oindex.intValue()));
        }
        if (okey==Prop.NAME) {
            return new ClarionString(flatWhat(oindex.intValue()).getName());
        }
        if (okey==Prop.KEYS) {
            return new ClarionNumber(keys.size());
        }
        
        
        return prop.getProperty(key,index);
    }

    /**
     * Get file property
     * @param key
     * @param index
     * @return
     */
    public ClarionObject getProperty(ClarionObject key,ClarionObject index) {
        return prop.getProperty(key,index);
    }

    /**
     *  Get file position
     *  
     * @return
     */
    public final ClarionString getPosition()
    {
        return getPosition(null);
    }

    public abstract  ClarionString getPosition(ClarionKey key);

    /**
     *  Get file pointer
     *  
     * @return
     */
    public abstract int getPointer();

    /**
     * Reget a record based on result of position method
     * @param string
     */
    public final void reget(ClarionString string) {
        reget(null,string);
    }
    
    public abstract void reget(ClarionKey key,ClarionString string);

    /**
     *  Reset sequental processing based on specified position
     *  
     * @param string
     */
    public final void reset(ClarionString string)
    {
        reset(null,string);
    }
    
    public abstract void reset(ClarionKey key,ClarionString string);
    
    /**
     * Get a particular key based on index
     *  
     * @param index
     * @return
     */
    public final ClarionKey getKey(ClarionObject indx)
    {
        return getKey(indx.intValue());
    }
    
    public ClarionKey getKey(int indx)
    {
        if (indx<1) return null;
        if (indx>keys.size()) return null;
        return keys.get(indx-1);
    }

    public List<ClarionKey> getKeys()
    {
        return keys;
    }
    
    public ClarionKey getPrimaryKey()
    {
        for (ClarionKey key : keys ) {
            if (key.isProperty(Prop.PRIMARY)) return key;
        }
        return null;
    }
    
    /** 
     * Save state of file to be restored later. Saving
     *  Current file state, open etc
     *  Contents of record buffer
     *  Watch status
     *  Variable change status
     *  Null variable states
     *  Sequentual processing position
     */
    public abstract int getState();
    
    /**
     *  Free memory held by stored state but do not restore state
     * @param state
     */
    public abstract void freeState(int state);

    /**
     * Restore state. Memory is not freed
     * @param state
     */
    public abstract void restoreState(int state);

    /**
     * Get encoding of status of nulls used by SQL files
     * @return
     */
    public abstract ClarionString getNulls();

    /**
     *  Restore encoding of status of nulls used by SQL files
     * @param nulls
     */
    public abstract void setNulls(ClarionString nulls);

    /**
     * return file name
     * 
     * @return
     */
    public String getName()
    {
        throw new RuntimeException("Not yet implemented");
    }
    

    /** 
     * initialise transaction processing
     * 
     * @param timeout
     */
    public static void logout(int timeout)
    {
        //throw new RuntimeException("Not yet implemented");
    }

    /**
     * rollback transaction changes
     */
    public static void rollback()
    {
        //throw new RuntimeException("Not yet implemented");
    }

    /**
     * Commit transaction changes
     */
    public static void commit()
    {
        //throw new RuntimeException("Not yet implemented");
    }
    
    public FileState getFileState()
    {
        FileState fs = state.get();
        if (fs.fields==null) {
            initFileState(fs);
        }
        return fs;
    }
    
    private void initFileState(final FileState fs)
    {
        fs.changed=new boolean[getVariableCount()];
        fs.isnull=new boolean[getVariableCount()];
        fs.fields=new ClarionObject[getVariableCount()];
        fs.listeners=new ClarionMemoryChangeListener[getVariableCount()];
        for (int scan=0;scan<getVariableCount();scan++) {
            final int pos = scan;
            final ClarionObject obj = what(pos+1);
            fs.fields[scan]=obj;
            fs.listeners[scan]=new ClarionMemoryChangeListener() 
            {
                public void objectChanged(ClarionMemoryModel model) {
                    //FileState fs = getFileState();
                    if (fs.ignoreChange) return;
                    fs.changed[pos]=true;
                    fs.isnull[pos]=false;
                } 
            };
            obj.addChangeListener(fs.listeners[scan]);
        }
        fs.primaryKey=getPrimaryKey();
        fs.primaryKeyFields=null;
    }
    
    protected void disposeFileState()
    {
        state.get().closeCursor();
        state.reset();
    }
    
    private List<Filecallbackinterface> fileCallbacks=new ArrayList<Filecallbackinterface>();

    public void registerCallback(Filecallbackinterface inf,boolean junk)
    {
        fileCallbacks.add(inf);
    }
    
    public void deregisterCallback(Filecallbackinterface inf)
    {
        fileCallbacks.remove(inf);
    }
    
    public void functionCalled(int code,FilecallbackParams params,String ecode,String emsg)
    {
        for (Filecallbackinterface cb : fileCallbacks ) {
            cb.functionCalled(
                    Clarion.newNumber(code),
                    params,
                    Clarion.newString(ecode),
                    Clarion.newString(emsg));
        }
    }
    
    public void functionDone(int code,FilecallbackParams params,String ecode,String emsg)
    {
        for (Filecallbackinterface cb : fileCallbacks ) {
            cb.functionDone(
                    Clarion.newNumber(code),
                    params,
                    Clarion.newString(ecode),
                    Clarion.newString(emsg));
        }
    }

    public boolean testOpen()
    {
        CErrorImpl.getInstance().clearError();
        if (getFileState().global.openCount==0) {
            CErrorImpl.getInstance().setError(37,"File Not Open");
            return false;
        }
        return true;
    }

    public boolean duplicateCheck(ClarionKey clarionKey) {
        throw new RuntimeException("Not yet implemented");
    }

    public static boolean isPositionMatches(ClarionString string,ClarionObject[] scanFields) 
    {
        if (scanFields==null) return false;
        for (int scan=0;scan<scanFields.length;scan++) {
            if (scanFields[scan]==null) return false;
        }
        
        SharedOutputStream sos = new SharedOutputStream();
        try {
            string.serialize(sos);
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        SharedInputStream sis = sos.getInputStream();
        
        sis.read(); // inclusive
        int count = sis.read();
        if (count==-1) return false;
        if (count!=scanFields.length) return false;
        
        for (int scan=0;scan<count;scan++) {
            
            ClarionObject test = scanFields[scan].genericLike();
            try {
                test.deserialize(sis);
            } catch (IOException e) {
                return false;
            }
            if (!test.equals(scanFields[scan])) return false;
        }
        return true;
    }

    public ClarionObject[] getPrimaryKeyPosition()
    {
        return null;
    }
    
    public void setPrimaryKeyPosition(ClarionObject[] position)
    {
    }

    @Override
    public void clearNull(ClarionObject clarionObject) {
        alterNull(clarionObject,false);
    }

    @Override
    public void setNull(ClarionObject clarionObject) {
        alterNull(clarionObject,true);
    }   

    private void alterNull(ClarionObject clarionObject, boolean nullValue) {
        FileState fs = getFileState();
        if (fs.isnull==null) return;
        int scan = where(clarionObject)-1;
        fs.isnull[where(clarionObject)-1]=nullValue;
        fs.changed[scan]=true;
    }

}
