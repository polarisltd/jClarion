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

public class JoinedIterable<T extends Object> implements Iterable<T> 
{
    private Iterable<? extends T> bits[];
    
    public JoinedIterable(Iterable<? extends T>... bits)
    {
        this.bits=bits;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public Iterator<T> iterator() {
        
        Iterator[] its=new Iterator[bits.length];
        for (int scan=0;scan<its.length;scan++) {
            its[scan]=bits[scan].iterator();
        }
        return new JoinedIterator<T>(its);
    }
}
