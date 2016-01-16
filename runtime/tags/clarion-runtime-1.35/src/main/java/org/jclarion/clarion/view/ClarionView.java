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
package org.jclarion.clarion.view;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.IdentityHashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.jclarion.clarion.BindProcedure;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.PropertyObject;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CErrorImpl;
import org.jclarion.clarion.runtime.CExprImpl;
import org.jclarion.clarion.runtime.ObjectBindProcedure;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.CExprError;
import org.jclarion.clarion.runtime.expr.LabelExpr;
import org.jclarion.clarion.util.FileState;
import org.jclarion.clarion.util.SharedOutputStream;
import org.jclarion.clarion.util.FileState.Mode;
import org.jclarion.clarion.constants.*;

/**
 * Model a clarion view
 * 
 * Some observations from experiments with views in clarion 5.5 and 
 * resulting SQL sent to postgres:
 * 
 *   When no order is indicated - select is not sorted
 *   Use of positioning etc has not effect reset will reset from top
 *   
 *   Ordering is critical for positioning etc. Clarion assumes that
 *   order defines a unique position. We will too
 * 
 *   changes to prop:order take effect on next set()
 *   
 *   Calling reset(view,file) will trigger reset based on position 
 *   inferred in file buffers taking changes to prop:order etc into 
 *   consideration. Clarion also forces a read on the table(s) in question
 *   ( their primary keys?)
 *   
 *   Calling reset(view,int) does *not* do what clarion documentation implies
 *   and what I originally coded this object to do. Calling reset is very similar
 *   to calling reset(view,file) except <n> trailing fields in key are zeroed out 
 * 
 *   calling getposition(), change prop:order call reset(view,string)
 *   works same as above. Clarion must be encoding more than just ordering
 *   data. From help files - clarion says it encodes data relating to 
 *   primary key fields. So position for views encodes PK data only.
 *   Presumably - this is all view needs - pk data. Everything else can
 *   be derived from there.
 * 
 *   All fields in a table that are keyed are implicitly included as 
 *   part of the project list
 *   
 *   reget must call get on every underlying file
 *   
 *   
 * 
 * Implementation of this is to just create a dynamic ClarionSQLFile
 * object with an overloaded open() method where we synthesize the 
 * FileState object to represent a more sophisticated table structure
 * and then methods like next() etc here become simple wrappers for the
 * underlying dynamically create file
 * 
 * Items:
 * 
 *  Limitiations:
 *  * Will not handle having tables appear more than once in structre
 *    Clarion system did not handle this well either - i.e. no way
 *    to differentiate tables thus selected.  
 *  
 *  * no intention of implementing mutators like put() etc just yet.
 *    to do this: 1) save changed params. Call reget() on primary file
 *    Restroe changed params. put()
 * 
 *  * outer joins and positions will not work due to absence of facility
 *    to record position of nullable parameters in ClarionSQLFile right now.
 *    Is doable - but tricky because of fact that comparators in ANSI SQL
 *    do not play nice with nullable columns 
 *    
 *  * will only work for all File types are SQL
 *  
 *  * will only work if all file types share same source
 *  
 *  TODO - implement view solution that can cross non SQL implementations
 *  and different sources. 
 * 
 * @author barney
 *
 */
public class ClarionView extends PropertyObject
{
    private static Logger log = Logger.getLogger(ClarionView.class.getName());
    
    private List<ViewJoin>      joins=new ArrayList<ViewJoin>();
    private List<ViewProject>   fields=new ArrayList<ViewProject>();
    private ClarionFile         table;

    private List<ClarionFile>                           allFiles;
    private Map<ClarionObject,FieldEntry>               allFields;
    private StringBuilder                                tablename;
    private ClarionSQLFile                              file;
    private ClarionKey                                  order;
    private String                                      filter;
    private CExpr                                       clientFilter;
    private boolean                                     useClientFilter=false;
    private boolean                                     changed=true;
    private int limit;
    
    private ClarionObject[]                             primaryKeyPosition;
   
    private boolean open;
    
    private static class FieldEntry
    {
        public  ClarionObject    field;
        public  int              type;
        //public  int              filePosition;
        
        public  int              viewPosition;
        public  String           viewName;
        //public  String           fileName;
    }
    
    
    public void add(ViewJoin aTable)
    {
        joins.add(aTable);
    }
    
    public void add(ViewProject aProject)
    {
        fields.add(aProject);
    }
    
    public void setTable(ClarionFile aFile) 
    {
        this.table=aFile;
    }
    
    
    public void setOrder(String order)
    {
        setProperty(Prop.ORDER,order);
    }
    
    public void setFilter(String filter)
    {
        setProperty(Prop.FILTER,filter);
    }
    
    
    private void figureFiles(ViewJoin vj)
    {
        allFiles.add(vj.table);
        for ( ViewJoin sub_vj : vj.joins ) {
            figureFiles(sub_vj);
        }
    }
    
    private void figureFiles()
    {
        allFiles=new ArrayList<ClarionFile>();
        allFiles.add(table);
        for ( ViewJoin vj : joins ) {
            figureFiles(vj);
        }
    }
    
    public void open()
    {
        CErrorImpl.getInstance().clearError();
        if (open==true) {
            CErrorImpl.getInstance().setError(52,"View already open");
            return;
        }
        
        // first step of opening a view is to coalesce all tables
        // and fields involved
        
        allFiles=new ArrayList<ClarionFile>();
        allFields=new IdentityHashMap<ClarionObject, FieldEntry>();
        
        if (!include(table,fields)) return;
        tablename = new StringBuilder();
        tablename.append(table.getFileState().name);
        tablename.append(" A");
        
        for (ViewJoin vj : joins ) {
            if (!include(1,vj)) return;
        }

        // build local clarion table
        
        file=new ClarionSQLFile() {

            @Override
            public int where(Object o)
            {
                ClarionObject co =(ClarionObject)o;

                FieldEntry fe = allFields.get(co);
                if (fe==null) return 0;
                return fe.viewPosition+1;
            }
            
            public void open()
            {
                FileState fs = getFileState();
                fs.openCount++;
                fs.changed=new boolean[allFields.size()];
                fs.isnull=new boolean[allFields.size()];
                fs.source=table.getFileState().source;
                fs.name=tablename.toString();
                
                fs.changed=new boolean[allFields.size()];
                fs.listeners=new ClarionMemoryChangeListener[allFields.size()];
                fs.fields=new ClarionObject[allFields.size()];
                fs.types=new int[allFields.size()];
                fs.autoincrementing=new boolean[allFields.size()];
                fs.fieldNames=new String[allFields.size()];

                for ( final FieldEntry e : allFields.values() ) {
                    fs.fields[e.viewPosition]=e.field;
                    fs.types[e.viewPosition]=e.type;
                    fs.fieldNames[e.viewPosition]=e.viewName;
                }
            }

            @Override
            protected boolean initWhere(StringBuilder sb) {
                if (filter==null) return false;
                sb.append(filter);
                return true;
            }
        };
        
        file.open();
        open=true;
    }

    public void close()
    {
        if (!open) return;
        file.close();
        open=false;
    }

    public void delete()
    {
        table.setPrimaryKeyPosition(primaryKeyPosition);
        table.delete();
    }

    public void put()
    {
        CErrorImpl.getInstance().clearError();
        if (!file.testWatch()) return;
        table.setPrimaryKeyPosition(primaryKeyPosition);
        table.put();
    }
    
    public void set()
    {
        //log.entering("CV","set");
        
        set(0);
    }

    public void flush()
    {
    }

    /**
     * Not really clear when is a good time to call records
     * 
     * Should we regenerate filters as part of record get
     * or assume this has already happened? 
     * 
     * Will err on side of no regeneration.
     * 
     * Another problem - what about client side filters?
     * They will not be taken into consideration. Will consider
     * this one to be ok - if anyone wants an accurate count of 
     * actual records - they need to iterate over them
     * 
     * @return
     */
    public int records()
    {
        //log.entering("CV","record");
        if (!testOpen());
        return file.records();
    }
    
    public void set(int sortOffset)
    {
        //log.entering("CV","set",sortOffset);
        if (!testOpen()) return;
        if (!regenOrderAndFilter()) return;
        
        if (sortOffset==0) {
            file.set(order);
        } else {
            
            try {
                SharedOutputStream sos = new SharedOutputStream();
                sos.write(1); // inclusive
                sos.write(sortOffset); // # of fields
            
                ClarionKey.Order[] bits = order.getOrder();
            
                for (int scan=0;scan<sortOffset;scan++) {
                    bits[scan].object.serialize(sos);
                }

                ClarionString cs = new ClarionString(sos.getSize());
                cs.deserialize(sos.getInputStream());

                file.reset(order,cs);

            } catch (IOException ex){ }
        }
    }

    public void next()
    {
        //log.entering("CV","next");
        iterate(1);
    }
    
    protected void iterate(int dir) 
    {
        if (!testOpen());
        
        if (file.getFileState().mode==Mode.Reset && changed) {
            regenOrderAndFilter();
        }
        
        while (true ) {
            
            this.table.getFileState().ignoreChange=true;
            
            try {
                if (dir>0) {
                    file.next();
                } else {
                    file.previous();
                }
            } finally {
                this.table.getFileState().ignoreChange=false;
            }
            
            if (CError.errorCode()!=0) break;
            if (useClientFilter && clientFilter!=null) {
                try {
                    ClarionObject o = clientFilter.eval();
                    if (o!=null && o.boolValue()) {
                        primaryKeyPosition=this.table.getPrimaryKeyPosition();
                        break;
                    }
                } catch (CExprError ex) {
                    CErrorImpl.getInstance().setError(801,"Client Filter failed. Probably missing binding");
                    return;
                }
            } else {
                primaryKeyPosition=this.table.getPrimaryKeyPosition();
                break;
            }
        }
    }
    
    public void watch()
    {
        file.watch();
    }
    
    public ClarionString getPosition()
    {
        //log.entering("CV","getPosition");
        SharedOutputStream sos = new SharedOutputStream();
        for (ClarionFile file : allFiles) {
            ClarionKey ck = file.getPrimaryKey();
            if (ck==null) continue;
            for (ClarionKey.Order o : ck.getFields()) {
                try {
                    o.object.serialize(sos);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        
        // also write additional order field data onto object
        // so that we can reliably check for changes in quick scan mode.
        // quick scan mode option only
        if (order!=null) {
            ClarionKey.Order o[] = order.getOrder();
            for (int scan=0;scan<o.length;scan++) {
                try {
                    o[scan].object.serialize(sos);
                } catch (IOException e) {
                }
            }
        }
        
        // write an extraneous 'ff' onto the string so that 
        // resultant object cannot possibly evaluate to '0' when bool()
        // test is performed on it. Consider view object where primary
        // key is a single number and its value is 32 (' ')
        sos.write(0xff);  
     
        ClarionString cs = new ClarionString(sos.getSize());
        try {
            cs.deserialize(sos.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return cs;
    }

    /**
     * Reset based on indicated position
     * Essentially - reget() following by a reset(file)
     * 
     * @param position
     */
    public void reset(ClarionString position)
    {
        //log.entering("CV","reset ClarionString");
        
        if (!testOpen()) return;
        
        if (limit>0) {
            //quick scan optimisation
            ClarionString cs = getPosition();
            
            String cs_string=cs.toString();
            String position_string = position.toString();
            if (!position_string.startsWith(cs_string)) {
                if (log.isLoggable(Level.FINE)) {
                    log.fine("Calling Reget: ["+ClarionString.rtrim(position_string)+"] != ["+cs_string+"]");
                }
                reget(position);
            } else {
                if (log.isLoggable(Level.FINE)) {
                    log.fine("Skipping Reget:"+ClarionString.rtrim(position_string));
                }
            }
        } else {
            reget(position);
        }
        
        reset(table);
    }

    public void reget(ClarionString position)
    {
        //log.entering("CV","reget",position);
        
        SharedOutputStream sos = new SharedOutputStream();
        try {
            position.serialize(sos);
        } catch (IOException e1) {
            e1.printStackTrace();
        }
        InputStream sis = sos.getInputStream();
        
        for (ClarionFile file : allFiles) {
            ClarionKey ck = file.getPrimaryKey();
            if (ck==null) {
                log.warning("File lacks a primary key:"+file);
                continue;
            }
            for (ClarionKey.Order o : ck.getFields()) {
                try {
                    o.object.deserialize(sis);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            file.get(ck);
        }
    }

    /**
     * Reset based on current order parameter's directly from 
     * ClarionFile buffers
     * 
     * @param position
     */
    public void reset(ClarionFile position)
    {
        //log.entering("CV","reset ClarionFile",position);
        
        if (!testOpen()) return;
        if (!regenOrderAndFilter()) return;
        
        if (order!=null) {
            order.set();
        } else {
            file.set();
        }
    }

    public void previous()
    {
        //log.entering("CV","previous");
        iterate(-1);
    }
    
    
    public void buffer(Integer pagesize,Integer behind,Integer ahead,Integer timeout) {
        if (pagesize!=null) {
            limit=pagesize.intValue()*5;
        } else {
            limit=0;
        }
        changed=true;
    }

    public ClarionFile getFile(int indx)
    {
        if (allFiles==null) figureFiles();
        if (indx<1) return null;
        if (indx>allFiles.size()) return null;
        return allFiles.get(indx-1);
    }

    @Override
    public PropertyObject getParentPropertyObject() {
        return null;
    }

    @Override
    public ClarionObject getLocalProperty(int index) {
        if (index==Prop.FILES) {
            if (allFiles==null) figureFiles();
            return new ClarionNumber(this.allFiles.size());
        }
        if (index==Prop.SQL) return file.getProperty(Prop.SQL);
        return super.getLocalProperty(index);
    }

    @Override
    protected void notifyLocalChange(int indx, ClarionObject value) {
        
        switch(indx) {
            case Prop.SQLFILTER:
            case Prop.FILTER:
            case Prop.ORDER:
                changed=true;
                CErrorImpl.getInstance().clearError();
                break;
                
        }
        super.notifyLocalChange(indx, value);
    }
    
    private boolean regenOrderAndFilter() {
        if (!changed) return true;
        //log.entering("CV","regenOrderAndFilter");
        
        StringBuilder newFilter=new StringBuilder();

        String os = getProperty(Prop.ORDER).toString();
        
        ClarionKey old_order=null;
        old_order=order;
        
        order=null;

        file.setLimit(limit);
        if (limit>0) file.setQuickScan();

        
        os.replaceAll(" ",""); // get rid of whitespace
        
        StringTokenizer tok=new StringTokenizer(os,",");
        while (tok.hasMoreTokens()) {
            String s = tok.nextToken();

            boolean ascend=true;
            if (s.startsWith("+")) {
                s=s.substring(1);
            } else if (s.startsWith("-")) {
                s=s.substring(1);
                ascend=false;
           }
            
           String function=null;
           
           if (s.endsWith(")")) {
               int start = s.indexOf('(');
               if (start>0) {
                   function=s.substring(0,start).toLowerCase();
                   s=s.substring(start+1,s.length()-1);
               }
           }
           
           // fast option - check bindings
           ClarionObject obj = null;
           FieldEntry fe = null;
           try {
               BindProcedure bp = CExprImpl.getInstance().resolveBind(s,false);
               if (bp instanceof ObjectBindProcedure) {
                   obj = bp.execute(null);
                   fe=allFields.get(obj);
               }
           } catch (CExprError ex) { 
               // do nothing - silently fall through to plan B
           }
           
           if (obj==null || fe==null) {
               CErrorImpl.getInstance().setError(801,"Could not resolve field in order:"+s);
               return false;
           }

           if (order==null) order=new ClarionKey("viewkey");
           order.addField(obj,!ascend,function);
        }

        if (order!=null) {
            file.addKey(order);
        }
        
        if (newFilter.length()>0) {
            newFilter.append(")");
        }

        String f=getProperty(Prop.FILTER).toString();
        String sqlf=getProperty(Prop.SQLFILTER).toString();
        f=f.trim();
        sqlf=sqlf.trim();
        if (sqlf.length()>0) {
            if (sqlf.startsWith("+")) {
                sqlf=sqlf.substring(1);
            } else {
                f="";
            }
        }
        
        
        clientFilter=null;
        useClientFilter=false;
        if (f.length()>0) {
            StringBuilder sf=new StringBuilder();
            clientFilter = CExprImpl.getInstance().compile(f);
            if (clientFilter==null) return false;
            substituteBindings(clientFilter);
            clientFilter.generateString(sf,true);

            StringBuilder lf  = new StringBuilder();
            clientFilter.generateString(lf,false);
            
            if (!lf.toString().equals(sf.toString())) {
                useClientFilter=true;
            }
            
            if (sf.length()>0) {
                if (newFilter.length()>0) {
                    newFilter.append(" AND (");
                } else {
                    newFilter.append(" WHERE (");
                }
                newFilter.append(sf);
                newFilter.append(')');
            }
        }
        if (sqlf.length()>0) {
            if (newFilter.length()>0) {
                newFilter.append(" AND (");
            } else {
                newFilter.append(" WHERE (");
            }
            newFilter.append(sqlf);
            newFilter.append(')');
        }
        
        String oldFilter=filter;
        
        if (newFilter.length()>0) {
            filter=newFilter.toString();
        } else {
           filter=null;
        }
        changed=false;

        FileState fs = file.getFileState();
        if (fs.scanKey!=null) {
            if (fs.scanKey.equals(order)) {
                
                boolean changedFilter=false;
                if (oldFilter==null ^ filter==null) {
                    changedFilter=true;
                } else {
                    if (oldFilter!=null && !oldFilter.equals(newFilter)) {
                        changedFilter=true;
                    }
                }
                
                if (!changedFilter) fs.scanKey=order;
            }
        }

        if (old_order!=null) {
            file.removeKey(old_order); 
        }
        
        
        return true;
    }

    /**
    private boolean regenFilter() {
        return true;
    }
    */

    
    private void substituteBindings(CExpr expr)
    {
        Iterator<CExpr> scan = expr.iterator();
        while (scan.hasNext()) {
            CExpr e = scan.next();
            if (e instanceof LabelExpr) {
                String name = ((LabelExpr)e).getName();
                ClarionObject o = e.eval();
                FieldEntry fe = allFields.get(o);
                if (fe!=null) {
                    CExprImpl.getInstance().bind(name,o,fe.viewName,fe.type);
                } else {
                    if (o.getOwner() instanceof ClarionFile) {
                        if (allFiles.contains(o.getOwner())) {
                            ClarionFile file = (ClarionFile)o.getOwner();
                            int indx = allFiles.indexOf(file);
                            char c = (char)('A'+indx);
                            CExprImpl.getInstance().bind(name,o,c+"."+o.getName(),file.getSQLType(o));
                        }
                    }
                }
            }
        }
    }
    
    private boolean include(ClarionFile table,FileState fs,ClarionObject obj)
    {
        if (allFields.containsKey(obj)) return true;
        
        int pos = table.flatWhere(obj)-1;
        if (pos==-1) {
            CErrorImpl.getInstance().setError(36,"Field not located");
            return false;
        }
        
        FieldEntry fe = new FieldEntry();
        fe.field=obj;
        fe.type=fs.types[pos];
        //fe.filePosition=pos;
        fe.viewPosition=allFields.size();
        //fe.fileName=fs.fieldNames[pos];
        fe.viewName=(char)('A'-1+allFiles.size())+"."+fs.fieldNames[pos];

        allFields.put(obj,fe);
        return true;
    }

    private boolean include(int pindx,ViewJoin join)
    {
        if (join.table==null && join.joinKey!=null) {
            join.table=join.joinKey.getFile();
        }
        
        if (!include(join.table,join.fields)) return false;

        int pos = allFiles.size();
        
        StringBuilder joinClause=new StringBuilder();
        
        // work out join
        if (join.joinKey!=null) {
            
            Iterator<ClarionKey.Order> cscan = join.joinKey.getFields().iterator();
            int pscan=0;
            
            // joining from key to parameters - as long as there are params
            while (pscan<join.joinKeyFields.length && cscan.hasNext()) {
                FieldEntry child = allFields.get(cscan.next().object);
                FieldEntry parent = allFields.get(join.joinKeyFields[pscan]);
                
                if (child==null) {
                    CErrorImpl.getInstance().setError(36,"Child Join Clause is busted at Pos:"+pscan);
                    return false;
                }
                if (parent==null) {
                    CErrorImpl.getInstance().setError(36,"Parent Join Clause is busted at Pos:"+pscan);
                    return false;
                }
                
                if (joinClause.length()>0) joinClause.append(" AND ");
                joinClause.append(child.viewName);
                joinClause.append('=');
                joinClause.append(parent.viewName);
                
                pscan++;
            }
        } else {
            try {
                CExpr ex = CExprImpl.getInstance().compile(join.joinExpression);
                if (ex==null) return false;
                
                substituteBindings(ex);
                
                StringBuilder loose=new StringBuilder();
                
                ex.generateString(joinClause,true);
                ex.generateString(loose,true);
                
                if (!joinClause.toString().equals(loose.toString())) {
                    CErrorImpl.getInstance().setError(801,"Join Clause appears to contain expression elements which cannot be converted into SQL");
                    log.warning("Strict and Loose differ");
                    log.warning("Strict:"+joinClause.toString());
                    log.warning("Loose:"+loose.toString());
                    return false;
                }
                
            } catch (CExprError ex) {
                CErrorImpl.getInstance().setError(801,"Join Clause did not evaluate - missing binds");
                return false;
            }
        }
        
        if ( join.inner ) {
            tablename.append(" INNER JOIN ");
        } else {
            tablename.append(" LEFT OUTER JOIN ");
        }
        
        tablename.append(join.table.getFileState().name);
        tablename.append(' ');
        tablename.append((char)('A'-1+allFiles.size()));
        
        tablename.append(" ON (");
        tablename.append(joinClause);
        tablename.append(')');
        
        for (ViewJoin child : join.joins ) {
            if (!include(pos,child)) return false;
        }
        
        return true;
    }
            
    private boolean include(ClarionFile table,List<ViewProject> fields)
    {
        if (!(table instanceof ClarionSQLFile)) {
            CErrorImpl.getInstance().setError(36,"Only SQL files allowed in a view");
            return false;
        }
        
        FileState fs = table.getFileState();
        
        if (fs.openCount==0) {
            CErrorImpl.getInstance().setError(36,"Supporting tables must already be open");
            return false;
        }

        allFiles.add(table);
        
        if (fields.size()==0) {
            // add all
            for (int scan=1;scan<=table.getVariableCount();scan++) {
                if (!include(table,fs,table.what(scan))) return false;
            }
        } else {
            for ( ViewProject vp : fields ) {
                for ( ClarionObject co : vp.fields ) {
                    if (!include(table,fs,co)) return false;
                }
            }
        }
        
        for (ClarionKey key : table.getKeys()) {
            for ( ClarionKey.Order o : key.getFields()) {
                if (!include(table,fs,o.object)) return false;
            }
        }
        
        return true;
    }
    
    private boolean testOpen()
    {
        CErrorImpl.getInstance().clearError();
        if (!open) {
            CErrorImpl.getInstance().setError(37,"View not open");
            return false;
        }
        return true;
    }

    @Override
    protected void debugMetaData(StringBuilder sb) {
        // TODO Auto-generated method stub
        
    }

}
