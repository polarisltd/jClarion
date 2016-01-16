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
package org.jclarion.clarion;

import java.io.IOException;

/**
 * Model a random access char file
 * 
 * Unlike random access file, methods that deal with positions, length(), seek() etc
 * will not necessarily count chars - they may be counting bytes.
 * 
 * So do not assume that calling read() will cause position to increment by 1. It
 * may increment more than this depdending on the underlying character set used 
 * 
 * @author barney
 *
 */
public abstract class ClarionRandomAccessCharFile 
{
    public abstract long length() throws IOException;

    public abstract long position() throws IOException;

    public abstract void close() throws IOException;

    public abstract void seek(long l) throws IOException;

    public abstract int read()  throws IOException;
    
    public int read(char[] get_buffer, int ofset, int len) throws IOException
    {
        if (len<=0) return 0;
        int size=0;
        while (len>0) {
            int c = read();
            if (c==-1) break;
            get_buffer[ofset++]=(char)c;
            size++;
            len--;
        }
        if (size==0) return -1;
        return size;
    }

    public abstract void write(char[] bytes, int i, int size) throws IOException;
    
    public abstract String getName();
}
