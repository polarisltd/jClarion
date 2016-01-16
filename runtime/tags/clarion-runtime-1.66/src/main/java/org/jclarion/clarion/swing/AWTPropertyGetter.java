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
package org.jclarion.clarion.swing;

import javax.swing.SwingUtilities;

import org.jclarion.clarion.ClarionObject;

public class AWTPropertyGetter 
{
    private static ThreadLocal<AWTPropertyGetter> instance=new ThreadLocal<AWTPropertyGetter>() {
        @Override
        protected AWTPropertyGetter initialValue() 
        {
            return new AWTPropertyGetter();
        }
    };
    
    public static AWTPropertyGetter getInstance()
    {
        return instance.get();
    }
    
    private class BlockNotify implements Runnable
    {
        private long session;
        
        public BlockNotify(long session)
        {
            this.session=session;
        }
        
        @Override
        public void run()
        {
            getResult(session);
        }
    }
    
    private AWTBlocker blocker;

    private boolean                     resultFetched;  
    private ClarionObject               result;
    private int                         index;
    private AbstractAWTPropertyGetter   getter;
    private long                        session; 
    
    protected AWTPropertyGetter()
    {
        blocker = AWTBlocker.getInstance(Thread.currentThread());
    }
    
    
    public ClarionObject get(int index,AbstractAWTPropertyGetter getter)
    {
        if (SwingUtilities.isEventDispatchThread()) return getter.getAWTProperty(index);

        final long this_session; 
        
        synchronized(this) {
            this.getter=getter;
            this.index=index;
            resultFetched=false;
            result=null;
            session++;
            this_session=session;
        }

        BlockNotify bn = new BlockNotify(this_session);
        if (blocker.addListener(bn)) {
            bn.run();
            return result;
        }
        try {
            SwingUtilities.invokeLater(bn);
            
            synchronized(this) {
                while ( !resultFetched ) {
                    try {
                        this.wait();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
                session++;
                return result;
            }
            
        } finally {
            blocker.removeListener(bn);
        }
    }
    
    private void getResult(long inst)
    {
        AbstractAWTPropertyGetter m_g ;
        int                       m_i;
        long                      l_s;
        
        synchronized(this) {
            m_g = getter;
            m_i=index;
            l_s=session;
        }
        
        if (l_s!=inst) return; 
        if (m_g==null) return;

        ClarionObject m_r = null;
        
        try {
            m_r=m_g.getAWTProperty(m_i); 
        } finally {
            synchronized(this) {
                if (m_g==getter && l_s==session) {
                    result=m_r;
                    resultFetched=true;
                    session++;
                    notifyAll();
                }
            }
        }
    }

     
}
