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

import org.jclarion.clarion.file.CharClarionFile;

public abstract class ClarionRandomAccessFile 
{
    public abstract long length() throws IOException;
    
    public abstract long position() throws IOException;

    public abstract void close() throws IOException;

    public abstract void seek(long l) throws IOException;

    public abstract int read(byte[] get_buffer, int i, int read) throws IOException;

    public abstract void write(byte[] bytes, int i, int size) throws IOException;
    
    public abstract String getName();

    public ClarionRandomAccessCharFile getCharFile()
    {
        return new CharClarionFile(this);
    }
}
