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

public class EmptyIterable<T> implements Iterable<T>
{
    private Iterator<T> cache;
    
    @Override
    public Iterator<T> iterator() {
        if (cache==null) cache=new EmptyIterator<T>();
        return cache;
    }
}
