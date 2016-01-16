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

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;

import org.jclarion.clarion.ClarionRandomAccessFile;

public class ClarionRandomAccessFileSystemFile extends ClarionRandomAccessFile 
{
    private RandomAccessFile file;
    private File filename;
    
    public ClarionRandomAccessFileSystemFile(File file) throws FileNotFoundException 
    {
        if (!file.exists()) throw new FileNotFoundException(file.toString());
        this.file=new RandomAccessFile(file,file.canWrite() ? "rw" : "r");
        filename=file;
    }

    @Override
    public void close() throws IOException {
        file.close();
    }

    @Override
    public String getName() {
        return filename.getPath();
    }

    @Override
    public long length() throws IOException {
        return file.length();
    }

    @Override
    public int read(byte[] getBuffer, int i, int read) throws IOException {
        return file.read(getBuffer,i,read);
    }

    @Override
    public void seek(long l) throws IOException {
        file.seek(l);
    }

    @Override
    public void write(byte[] bytes, int i, int size) throws IOException {
        file.write(bytes,i,size);
    }

    @Override
    public long position() throws IOException {
        return file.getFilePointer();
    }
}
