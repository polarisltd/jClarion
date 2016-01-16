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

import java.io.IOException;
import java.lang.ref.WeakReference;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.jclarion.clarion.ClarionMemoryChangeListener;
import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.util.SharedOutputStream;

/**
 * This class allows an object to call setOver() another object. Changes
 * in one object are propagated to other via their memory models as expressed
 * via ClarionMemoryModel interface
 * 
 * Objects are weakly linked. Once one of the objects becomes unreferencable
 * the Glue dissolves.
 * 
 * @author barney
 *
 */
public class OverGlue implements ClarionMemoryChangeListener
{
    private static Logger log = Logger.getLogger(OverGlue.class.getName());
    
    private ClarionMemoryModel left;
    private WeakReference<ClarionMemoryModel> right;
   
    private int leftSize;
    private int rightSize;
    
    private SharedOutputStream sos;
    
    /** 
     * when set we are already propagating changes. Required to protected against
     * backflow which will again forward flow and create an infinite loop
     */
    private boolean propagatingChanges=false;
    
    public OverGlue(ClarionMemoryModel left,ClarionMemoryModel right) {
        
        if (left==null || right==null) {
            // soft in the head clarion code in BufferedPairsClass does this
            return;
        }

        leftSize=CMemory.size(left);
        rightSize=CMemory.size(right);
        
        this.left=left;
        this.right=new WeakReference<ClarionMemoryModel>(right);
        
        left.addChangeListener(this,true);
        right.addChangeListener(this,false);
    }

    @Override
    public void objectChanged(ClarionMemoryModel model) {

        if (left==null || right==null) return;
        
        if (propagatingChanges) return;
        
        ClarionMemoryModel left;
        ClarionMemoryModel right;
        left=this.left;
        right=this.right.get();
        
        if (left==null || right==null) {
            // we are unglued. Remove listeners on any object still strongly referenced
            destroy();
            return;
        }

        ClarionMemoryModel src=null;
        ClarionMemoryModel dst=null;
        
        int srcSize=0;
        int destSize=0;
        
        // work out propagation direction
        
        if (model==left) {
            src=left;
            dst=right;
            srcSize=leftSize;
            destSize=rightSize;
        }
        if (model==right) {
            src=right;
            dst=left;
            srcSize=rightSize;
            destSize=leftSize;
        }
        
        if (src==null) {
            throw new RuntimeException("OverGlue observer triggered but source of event is not known to us!");
        }
        
        try {
            propagatingChanges=true;
         
            if (sos==null) {
                sos=new SharedOutputStream();
            }
            
            sos.reset();

            if (destSize>srcSize) {
                dst.serialize(sos);
                sos.reset();
            }
            
            src.serialize(sos);
            dst.deserialize(sos.getFullInputStream());
            
        } catch (IOException e) {
            // eat exception and keep on trucking. But log it
            log.log(Level.SEVERE,"IOException while synchronizing overlapping objects",e);
        } finally {
            propagatingChanges=false;
        }
    }

    @Override
    public void finalize()
    {
        destroy();
    }
    
    public void destroy()
    {
        if (this.right!=null) {
            ClarionMemoryModel right=this.right.get();
            if (right!=null) right.removeChangeListener(this);
        }
    }
}
