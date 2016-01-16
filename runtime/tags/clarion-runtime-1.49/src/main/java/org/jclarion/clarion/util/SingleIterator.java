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

public class SingleIterator<T> implements Iterator<T> 
{
    private T value;
    private boolean consumed;
    
    public SingleIterator(T value)
    {
        this.value=value;
    }
    
    @Override
    public boolean hasNext() {
        return !consumed;
    }

    @Override
    public T next() {
        if (consumed) throw new IllegalStateException("Iterator finished");
        return value;
    }

    @Override
    public void remove() {
        // TODO Auto-generated method stub
        
    }
}
