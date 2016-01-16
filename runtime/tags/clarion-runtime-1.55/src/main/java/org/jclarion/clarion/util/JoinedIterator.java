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

public class JoinedIterator<T> implements Iterator<T>
{
    private Iterator<T> bits[];
    private int pos=0;
    
    public JoinedIterator(Iterator<T>... bits)
    {
        this.bits=bits;
    }

    @Override
    public boolean hasNext() {
        while (true) {
            if (pos>=bits.length) return false;
            if (bits[pos].hasNext()) return true;
            pos++;
        }
    }

    @Override
    public T next() {
        return bits[pos].next();
    }

    @Override
    public void remove() {
        bits[pos].remove();
    }
}
