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

import java.io.IOException;
import java.io.Writer;

public class LengthMonitoringWriter extends Writer
{
    private Writer source;
    private long   length=0;
    
    public LengthMonitoringWriter(Writer source)
    {
        this.source=source;
    }

    @Override
    public Writer append(char c) throws IOException 
    {
        length++;
        return source.append(c);
    }

    @Override
    public Writer append(CharSequence csq, int start, int end)
            throws IOException {
        length+=end-start;
        return source.append(csq, start, end);
    }

    @Override
    public Writer append(CharSequence csq) throws IOException {
        length+=csq.length();
        return source.append(csq);
    }

    @Override
    public void close() throws IOException {
        source.close();
    }

    @Override
    public void flush() throws IOException {
        source.flush();
    }

    @Override
    public void write(char[] cbuf, int off, int len) throws IOException {
        length+=len;
        source.write(cbuf,off,len);
    }

    @Override
    public void write(char[] cbuf) throws IOException {
        length+=cbuf.length;
        source.write(cbuf);
    }

    @Override
    public void write(int c) throws IOException {
        length++;
        source.write(c);
    }

    @Override
    public void write(String str, int off, int len) throws IOException {
        length+=len;
        source.write(str, off, len);
    }

    @Override
    public void write(String str) throws IOException {
        length+=str.length();
        source.write(str);
    }
    
    public long getLength()
    {
        return length;
    }
}
