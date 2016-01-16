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
package org.jclarion.clarion.runtime.ref;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.jclarion.clarion.ClarionMemoryModel;
import org.jclarion.clarion.runtime.CMemory;

public class RefVariable<T> extends ClarionMemoryModel 
{
    private T variable;

    public RefVariable()
    {
    }

    public RefVariable(T variable)
    {
        this.variable=variable;
    }
    
    public final T get()
    {
        return variable;
    }
    
    public final void set(T variable)
    {
        if (variable!=this.variable) {
            this.variable=variable;
            notifyChange();
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public void deserialize(InputStream is) throws IOException 
    {
        int m=0;
        for (int scan=0;scan<4;scan++) {
            int r = is.read();
            if (r==-1) throw new IOException("Unexpected EOF");
            m=m+((r&0xff)<<(scan*8));
        }
        
        T new_variable = (T)CMemory.resolveAddress(m);
        if (new_variable!=variable) {
            variable=new_variable;
            notifyChange();
        }
    }

    @Override
    public void serialize(OutputStream os) throws IOException 
    {
        int m = CMemory.address(variable);
        os.write(m);
        os.write(m>>8);
        os.write(m>>16);
        os.write(m>>24);
    }

}
