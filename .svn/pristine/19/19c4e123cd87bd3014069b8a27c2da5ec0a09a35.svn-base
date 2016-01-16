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
package org.jclarion.clarion.util;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.IdentityHashMap;
import java.util.Map;

import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.jdbc.AbstractJDBCSource;

/**
 * Model state of JDBC Connection. This same object is used
 * for current state and saved states
 * 
 * @author barney
 */

public class FileState 
{
    /**
     * Read mode/state of the connection
     * 
     * NONE             - no reading occurring
     * 
     * RESET            - file/key is positioned but no reading yet
     * FORWARD          - we are reading forward
     * BACK             - we are reading backwards
     * RESTORED         - we have been restored file that was previously 
     *                  - either in Forward or Back mode, but we have not 
     *                    yet fully restored iterator position 
     *                    (iterator restore is lazy)
     * 
     * USER             - user defined SQL was executed
     */
    public enum Mode { None, Reset, Forward, Back, Restored, User };
    public Mode mode;
    
    /**
     * catalog of buffer columns that have been modified
     */
    public boolean[] changed;

    /**
     * catalog of buffer columns that have been flagged as null
     */
    public boolean[] isnull;

    
    private static class ResultSetCount
    {
        int count;
    }
    
    /**
     * Current Result Set/etc
     */
    public PreparedStatement statement;
    public ResultSet         result;
    public ResultSetCount    resultSetCount;
    
    /**
     * Current scan key (if any)
     */
    public ClarionKey       scanKey;
    public ClarionObject[]  scanFields;
    public ClarionObject    quickScanBuffer;

    /**
     * Primary key and position
     */
    public ClarionKey       primaryKey;
    public ClarionObject[]  primaryKeyFields;
    
    
     /**
      * Current scan position
      */
     public SharedOutputStream position;
     
     /**
      * number of times open was called
      */
     public int openCount;
     
     /**
      * JDBCSource in use 
      */
     public AbstractJDBCSource source;

     /**
      * Ignore changes made to parameters as these are being done by
      * internal ClarionFile object
      */
     public boolean ignoreChange;

     /**
      * Run following SQL before PUT() if expression fails then
      * fail PUT(). Post PUT clear expression 
      */
     public ClarionObject[] watchBuffer;
     
     /**
      * is watch armed. If true On next read - set watch expression
      */
     public boolean watchArmed;
     
     /**
      * Open file meta data
      */
     public  String                          name;
     public  ClarionObject[]                 fields;
     public  String[]                        fieldNames;
     public  int[]                           types;
     public  boolean[]                       autoincrementing;
     public ClarionMemoryChangeListener[]    listeners;
     public StringBuilder                     select;
     
     /*=================================
      * Optimisation/performance considerations
      *=================================
      */
     
     /**
      * Limits - when scanning very large files say 10,000s of records in a browse, user
      * usually only wants to see the first 20 or so. Isntead of pulling back 10,000s of
      * records per scan across JDBC - limit number of records to pull back. If limit is 
      * exhausted, then invisibly reset the scan to get the next block of records
      */
     public int limit=0;                    // only pull back # of records at a time on a scan.
     public int currentLimit=0;             // current limit in effect on curent scan in progress
     public int readCount=0;                // # of records read so far in a limited scan
     
     public int offset=0;                   // when initiating a scan - specify given offset

     /**
      * Key binding. When using keys that are composite fields, it is very common that
      * the program wants to 'fix' the first key and only scan second key. For example
      * stock(franchise,partnum) - user may only want to look at parts in a given franchise
      * But way clarion files work is that if I say all parts from franchise 2, partnum
      * '1234' then all franchises above 2 are considered as well.
      * 
      * When binding is in effect it works similar to limits. The initial query assumes that
      * only franchise=2 is wanted. But if user executes 'next' statement beyond this
      * then it will invisibly rewrite the query to handle this.
      * 
      * This is beneficial in postgres at least because I had trouble getting postgres to 
      * optimise the following well
      * 
      * franchise>2 OR (franchise=2 and partnum>='1234')
      * 
      * Under some circumstances, instead of selecting a index scan starting at (2,'1234')
      * sometimes postgrs would do a index scan at (2,) only - and filter records prior
      * to 1234. For large data sets this can be very inefficient. But when I break it up into
      * two queries i.e.
      * a) franchise=2 and partnum>='1234'
      * b) franchise>2
      * 
      * The system optimises quite well
      */
    public boolean keyBinding;              // true allow key binding even if limit is still 0.
    public boolean isBounded;               // true if current scan is bounded.
    public boolean disableBinding;
    
    /**
     * Quick scan has a comparable in original clarion. Browse tables force reset
     * when scrolling through parts instead of continuing to read the already established
     * statement.
     * 
     * Clearly this is inefficient. Clarion worked around this with a quickscan setting.
     * What that setting does in clarion is unclear, documentation talks about 'buffering'
     * which I assume is caching etc.
     * 
     * For this implementation - quickScan merely intercepts key methods. Specifically:
     *  reset() - if resetting a scan that is already occurring in scan position matches
     *  the currently cached position - enable quickScan to continue to 'use' the existing scan
     */
    public boolean quickScan;
    public boolean quickScanResetActivated;     // if active - iterate() needs to skip and pretend it got a record
     
     public FileState()
     {
         this.mode=Mode.None;
         this.position=new SharedOutputStream();
         this.result=null;
         this.scanKey=null;
         this.scanFields=null;
         this.quickScanBuffer=null;
         this.source=null;
         this.changed=null;
         this.isnull=null;
         
         this.quickScan=false;
         this.quickScanResetActivated=false;

         this.primaryKey=null;
         this.primaryKeyFields=null;
         
         this.watchArmed=false;
         this.watchBuffer=null;
         
         this.name=null;
         this.fields=null;
         this.fieldNames=null;
         this.types=null;
         this.listeners=null;
         this.select=null;
     }

     public void closeCursor()
     {
         closeCursor(true);
     }

     public void closeCursor(boolean clearKeyAndPosition)
     {
         closeCursor(clearKeyAndPosition,true);
     }
     
     public void closeCursor(boolean clearKeyAndPosition,boolean clearMode)
     {
         if (resultSetCount!=null) {
             if (resultSetCount.count>0) {
                 resultSetCount.count--;
             }
             if (resultSetCount.count==0) {
                 resultSetCount=null;
             }
         }

         if (result != null) {
            if (resultSetCount == null) {
                try {
                    result.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            result = null;
        }

        if (statement != null) {
            if (resultSetCount == null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            statement = null;
        }

        this.resultSetCount = null;
         
         if (clearMode) this.mode=Mode.None;
         if (clearKeyAndPosition) {
             this.position.reset();
             this.scanKey=null;
             this.isBounded=false;
             if (this.primaryKeyFields!=null) {
                 for (int scan=0;scan<this.primaryKeyFields.length;scan++) {
                     this.primaryKeyFields[scan]=null;
                 }
             }
         }
         this.currentLimit=0;
         this.readCount=0;
         this.quickScanResetActivated=false;
     }

     public void free()
     {
         closeCursor();
     }
     
    public FileState save() 
    {
        FileState n = new FileState();
        
        n.mode=this.mode;
        
        if (this.result!=null && this.scanKey==null && this.mode!=Mode.Back && this.mode!=Mode.Forward) {
            n.result=this.result;
            n.statement=this.statement;
            if (resultSetCount==null) {
                resultSetCount=new ResultSetCount();
                resultSetCount.count=1;
            }
            resultSetCount.count++;
            n.resultSetCount=resultSetCount;
        }
        
        //this.buffer=new SharedOutputStream();
        //this.result=null;
        //this.statement=null;
        
        n.position=this.position.like();

        n.quickScan=this.quickScan;
        n.quickScanResetActivated=this.quickScanResetActivated;
        
        n.scanKey=this.scanKey;
        n.primaryKey=this.primaryKey;
        n.source=this.source;
        n.watchArmed=this.watchArmed;
        n.watchBuffer=this.watchBuffer;

        //n.limit=this.limit;
        //n.currentLimit=this.currentLimit;
        //n.readCount=this.readCount;

        if (this.changed!=null) {
            n.changed = new boolean[this.changed.length];
            n.isnull = new boolean[this.changed.length];
            n.fields = new ClarionObject[this.changed.length];
            if (n.watchBuffer != null) {
                n.watchBuffer = new ClarionObject[this.changed.length];
            }
            for (int scan = 0; scan < n.changed.length; scan++) {
                n.changed[scan] = this.changed[scan];
                n.isnull[scan] = this.isnull[scan];
                n.fields[scan] = this.fields[scan].genericLike();
                if (this.watchBuffer != null) {
                    n.watchBuffer[scan] = this.watchBuffer[scan].genericLike();
                }
            }
        }
        
        if (this.scanFields!=null) {
            n.scanFields=new ClarionObject[this.scanFields.length];
            for (int scan=0;scan<n.scanFields.length;scan++) {
                n.scanFields[scan]=this.scanFields[scan].genericLike();
            }
        }

        n.quickScanBuffer=this.quickScanBuffer;

        if (this.primaryKeyFields!=null) {
            n.primaryKeyFields=new ClarionObject[this.primaryKeyFields.length];
            for (int scan=0;scan<n.primaryKeyFields.length;scan++) {
                if (this.primaryKeyFields[scan]!=null) {
                    n.primaryKeyFields[scan]=this.primaryKeyFields[scan].genericLike();
                }
            }
        }
        
        n.name=this.name;
        
        n.fieldNames=this.fieldNames;
        n.types=this.types;
        n.autoincrementing=this.autoincrementing;
        
        //this.listeners=null;
        //this.select=null;

        return n;
    }

    public void saveBuffer(SharedOutputStream target) {
        for (int scan=0;scan<fields.length;scan++) {
            try {
                fields[scan].serialize(target);
            } catch (IOException e) {
            }
        }
    }

    public void restore(FileState save) 
    {
        this.mode=save.mode;
        this.result=save.result;
        this.statement=save.statement;
        this.resultSetCount=save.resultSetCount;
        this.mode=save.mode;

        if (save.scanKey!=null) {
            if (save.mode==Mode.Back) {    // do not reset iterator right away
                this.mode=Mode.Restored;
            }

            if (save.mode==Mode.Forward) {
                this.mode=Mode.Restored;
            }
        }
        
        if (this.mode==Mode.User || this.mode==Mode.Back || this.mode==Mode.Forward) {
            // check if non keyed or user mode is resumable
            if (save.result==null) {
                this.mode=Mode.None;
            }
        }

        //this.buffer=new SharedOutputStream();
        //this.result=null;
        //this.statement=null;
        
        this.position=save.position.like();

        this.quickScan=save.quickScan;
        this.quickScanResetActivated=save.quickScanResetActivated;
        
        this.scanKey=save.scanKey;
        this.primaryKey=save.primaryKey;
        this.watchArmed=save.watchArmed;

        if (save.fields!=null) {
            for (int scan=0;scan<save.fields.length;scan++) {
                fields[scan].setValue(save.fields[scan]);
                changed[scan]=save.changed[scan];
                isnull[scan]=isnull[scan];
            }
        }

        if (save.watchBuffer!=null) {
            watchBuffer=new ClarionObject[save.watchBuffer.length];
            for (int scan=0;scan<save.fields.length;scan++) {
                watchBuffer[scan]=save.watchBuffer[scan].genericLike();
            }
        }

        quickScanBuffer=save.quickScanBuffer;

        if (save.scanFields!=null) {
            if (scanFields==null) {
                scanFields=new ClarionObject[save.scanFields.length];
            }
            if (scanFields.length!=save.scanFields.length) {
                scanFields=new ClarionObject[save.scanFields.length];
            }
            for (int scan=0;scan<scanFields.length;scan++) {
                scanFields[scan]=save.scanFields[scan].genericLike();
            }
        }
        if (save.primaryKeyFields!=null) {
            if (primaryKeyFields==null) {
                primaryKeyFields=new ClarionObject[save.primaryKeyFields.length];
            }
            if (primaryKeyFields.length!=save.primaryKeyFields.length) {
                primaryKeyFields=new ClarionObject[save.primaryKeyFields.length];
            }
            for (int scan=0;scan<primaryKeyFields.length;scan++) {
                if (save.primaryKeyFields[scan]==null) {
                    primaryKeyFields[scan]=null;
                } else {
                    primaryKeyFields[scan]=save.primaryKeyFields[scan].genericLike();
                }
            }
        }

    }

    public void setLimit(int limit) {
        this.limit=limit;
    }

    public void setKeyBinding(boolean b) {
        keyBinding=true;
    }
    

    private Map<ClarionObject,Integer> fieldIndexMap;
    
    public int getFieldIndex(ClarionObject o)
    {
        if (fieldIndexMap==null) {
            fieldIndexMap=new IdentityHashMap<ClarionObject, Integer>();
            for (int scan=0;scan<fields.length;scan++) {
                fieldIndexMap.put(fields[scan],scan);
            }
        }
        return fieldIndexMap.get(o);
    }
    
    
}
