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
import java.io.OutputStream;

import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.Threaded;

public class CMemory {
    
    public static Object castTo(ClarionMemoryModel mode,Class<? extends ClarionMemoryModel> clazz)
    {
        if (mode==null) return mode;
        return mode.castTo(clazz);
    }
    
    /**
     *  Generic empty object
     *  
     * @param o
     */
    public static void clear(Object o)
    {
        throw new RuntimeException("Not yet implemented");
    }
    
    
    private static class SizedOutputStream extends OutputStream
    {
        int size=0;
        
        @Override
        public void write(int b) throws IOException {
            size++;
        }

        @Override
        public void write(byte[] b, int off, int len) throws IOException {
            size+=len;
        }

        @Override
        public void write(byte[] b) throws IOException {
            size+=b.length;
        }
    }
    
    /**
     *  Return memory footprint size of supplied object
     *   
     * @param o
     * @return
     */
    public static int size(ClarionMemoryModel o) 
    {
        SizedOutputStream sos = new SizedOutputStream();
        try {
            o.serialize(sos);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sos.size;
    }
    
    public static int instance(Object o,Integer thread)
    {
        if (o==null) return 0;
        
        if (o instanceof Threaded && ((Threaded)o).isThreaded()) {
            Thread t = thread==null || thread==0 ? Thread.currentThread() : CRun.getThread(thread);
            return CMemoryImpl.getInstance().address(o,t);
        } else {
            return address(o);
        }
    }

    /**
     *  Return address reference for specified object
     * @param o
     * @return
     */
    
    public static int address(Object o)
    {
        return CMemoryImpl.getInstance().address(o);
    }

    /**
     *  Return address reference for specified array object
     * @param o
     * @return
     */
    public static int address(Object o[])
    {
        throw new RuntimeException("Not yet implemented");
    }
    
    
    /**
     *  Return address reference for specified protoype
     *  
     *  No way this could ever work. Lets see if any code
     *  ever tries to call it and see what we can do from there
     *  
     * @param o
     * @return
     */
    
    public static int getAddressPrototype(String prototype)
    {
        throw new RuntimeException("Not yet implemented");
    }
    
    
    /**
     *  Return object representing prototype for class
     *  
     * @param clazz
     * @param method
     * @return
     */
    public static Object getPrototype(Object clazz,String method)
    {
        throw new RuntimeException("Not yet implemented");
    }

    /**
     *  Convert address id into an object
     *  
     * @param o
     * @return
     */
    public static Object resolveAddress(int o)
    {
        return CMemoryImpl.getInstance().resolveAddress(o);
    }


    /**
     * return integer tied to key+index pair
     * 
     * @param key
     * @param index
     * @return
     */
    public static int tied(String key,int index)
    {
        return CMemoryImpl.getInstance().tied(key,index);
    }

    /**
     * Tie integer to index/key pair
     *  
     * @param key
     * @param index
     * @param value
     */
    public static int tie(String key,int index,int value)
    {
        return CMemoryImpl.getInstance().tie(key,index,value);
    }

    /**
     * untie key+index pair
     * 
     * @param key
     * @param index
     */
    public static void untie(String key,int index)
    {
        CMemoryImpl.getInstance().untie(key,index);
    }

    /**
     * Direct memory access
     * 
     * @param o
     * @param offset
     * @return
     */
    public static int peek(ClarionObject o,int offset)
    {
        throw new RuntimeException("Not yet implemented");
    }

    /**
     * Direct memory access
     * 
     * @param o
     * @param offset
     * @return
     */
    public static void poke(ClarionObject o,ClarionObject val)
    {
        throw new RuntimeException("Not yet implemented");
    }
    
}
