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
    
    private WeakReference<ClarionMemoryModel> left;
    private WeakReference<ClarionMemoryModel> right;
    
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
        
        this.left=new WeakReference<ClarionMemoryModel>(left);
        this.right=new WeakReference<ClarionMemoryModel>(right);
        
        left.addChangeListener(this,false);
        right.addChangeListener(this,false);
    }

    @Override
    public void objectChanged(ClarionMemoryModel model) {

        if (left==null || right==null) return;
        
        if (propagatingChanges) return;
        
        ClarionMemoryModel left;
        ClarionMemoryModel right;
        left=this.left.get();
        right=this.right.get();
        
        if (left==null || right==null) {
            // we are unglued. Remove listeners on any object still strongly referenced
            destroy();
            return;
        }

        ClarionMemoryModel src=null;
        ClarionMemoryModel dst=null;
        
        // work out propagation direction
        
        if (model==left) {
            src=left;
            dst=right;
        }
        if (model==right) {
            src=right;
            dst=left;
        }
        
        if (src==null) {
            throw new RuntimeException("OverGlue observer triggered but source of event is not known to us!");
        }
        
        try {
            propagatingChanges=true;
         
            if (sos==null) {
                // first time round
                sos=new SharedOutputStream();
                if (CMemory.size(dst)>CMemory.size(src)) {
                    // if dst size is bigger than source than
                    // fully serialize dst first so that we have
                    // a 'shared' image big enough to accomodate them
                    // both
                    dst.serialize(sos);
                    sos.reset();
                }
            }
            
            sos.reset();
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
        if (this.left!=null) {
            ClarionMemoryModel left=this.left.get();
            if (left!=null) left.removeChangeListener(this);
        }

        if (this.right!=null) {
            ClarionMemoryModel right=this.right.get();
            if (right!=null) right.removeChangeListener(this);
        }
    }
}
