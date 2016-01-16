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

import java.util.Iterator;

public abstract class FilteredIterator<T> implements Iterator<T> 
{
    private T val;
    private Iterator<? extends T> scan;
    
    public FilteredIterator(Iterator<? extends T> scan)
    {
        this.scan=scan;
    }
    
    public abstract boolean filter(T value);    

    @Override
    public final boolean hasNext() {
        
        while (val==null) {
            if (!scan.hasNext()) return false;
            T test = scan.next();
            if (!filter(test)) val=test;
        }
        return true;
    }

    @Override
    public T next() {
        if (!hasNext()) throw new IllegalStateException("Iterator exhausted");
        T result = val;
        val=null;
        return result;
    }

    @Override
    public void remove() {
        throw new IllegalStateException("Not Supported");
    }
}
