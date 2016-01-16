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
package org.jclarion.clarion.crash;

import java.io.*;

public class CrashStream extends OutputStream
{
    private static int MAX = 256*1024;
    private static int MIN = 128*1024;
    
    private OutputStream out;
    private StringBuilder buffer;
    
    public CrashStream(OutputStream out)
    {
        this.out=out;
        buffer=new StringBuilder();
        Crash.getInstance().setCrashStream(this);
    }
    
    @Override
    public void write(int b) throws IOException 
    {
        buffer.append((char)b);
        prune();
        out.write(b);
    }

    private void prune() {
        if (buffer.length()>MAX) {
            buffer.delete(0,MIN);
        }
    }

    @Override
    public void close() throws IOException {
        out.close();
    }

    @Override
    public void flush() throws IOException {
        out.flush();
    }

    @Override
    public void write(byte[] b, int off, int len) throws IOException {
        for (int scan=0;scan<len;scan++) {
            buffer.append((char)b[off+scan]);
        }
        prune();
        out.write(b, off, len);
    }

    @Override
    public void write(byte[] b) throws IOException {
        for (int scan=0;scan<b.length;scan++) {
            buffer.append((char)b[scan]);
        }
        prune();
        out.write(b);
    }

    public void dump() {
        Crash.getInstance().log("Crash Stream");
        Crash.getInstance().log("===================");
        Crash.getInstance().log(buffer.toString());
        buffer.setLength(0);
    }
}
