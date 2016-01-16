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
package org.jclarion.clarion.file;

import java.io.IOException;
import java.io.InputStream;

import org.jclarion.clarion.ClarionRandomAccessFile;

public class InputStreamWrapper extends InputStream 
{
    private ClarionRandomAccessFile file;
    private long markPos;
    private long pos;
    
    public InputStreamWrapper(ClarionRandomAccessFile file)
    {
        this.file=file;
    }

    private byte[] byteBuffer = new byte[1];

    @Override
    public int read() throws IOException 
    {
        if (file.read(byteBuffer, 0, 1) <= 0) return -1;
        pos+=1;
        return byteBuffer[0] & 0xff;
    }

    @Override
    public int read(byte[] b, int off, int len) throws IOException 
    {
        if (len==0) return 0;
        int result=file.read(b, off, len);
        if (result>0) {
            pos+=result;
            return result;
        }
        return -1;
    }

    @Override
    public int read(byte[] b) throws IOException {
        if (b.length==0) return 0;
        int result=file.read(b, 0, b.length);
        if (result>0) {
            pos+=result;
            return result;
        }
        return -1;
    }

    @Override
    public synchronized void mark(int readlimit) 
    {
        this.markPos=this.pos;
    }

    @Override
    public boolean markSupported() 
    {
        return true;
    }

    @Override
    public synchronized void reset() throws IOException 
    {
        file.seek(markPos);
    }
}
