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
package org.jclarion.clarion.compile.javac;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.net.URI;
import java.net.URISyntaxException;

import javax.lang.model.element.Modifier;
import javax.lang.model.element.NestingKind;
import javax.tools.JavaFileObject;

import org.jclarion.clarion.util.SharedInputStream;
import org.jclarion.clarion.util.SharedOutputStream;


public class ClarionJavaFileObject implements JavaFileObject
{
    private Kind kind;
    private ClarionFileManager mgr;
    private String pkg;
    private String name;
    
    private SharedOutputStream os;
    private String content;
    private long lastModified;
    
    public ClarionJavaFileObject(ClarionFileManager mgr,Kind kind,String pkg,String name,String content)
    {
        this.kind=kind;
        this.mgr=mgr;
        this.pkg=pkg;
        this.name=name;
        this.content=content;
        if (this.content!=null) {
            lastModified=System.currentTimeMillis();
        }
    }

    public ClarionFileManager getFileManager()
    {
        return mgr;
    }
    
    public String getPackage()
    {
        return pkg;
    }
    
    @Override
    public Modifier getAccessLevel() {
        return null;
    }

    @Override
    public Kind getKind() {
        return kind;
    }

    @Override
    public NestingKind getNestingKind() {
        return null;
    }

    @Override
    public boolean isNameCompatible(String simpleName, Kind kind) {
        return true;
    }

    @Override
    public boolean delete() {
        //mgr.delete(this);
        return true;
    }

    @Override
    public CharSequence getCharContent(boolean ignoreEncodingErrors)
            throws IOException {
        if (content!=null) return content;
        if (os!=null) {
            return new String(os.toByteArray());
        }
        return "";
    }

    @Override
    public long getLastModified() {
        return lastModified;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public InputStream openInputStream() throws IOException {
        if (os!=null) return os.getInputStream();
        if (content!=null) return new SharedInputStream(content.getBytes());
        return new SharedInputStream(new byte[0]);
    }

    @Override
    public OutputStream openOutputStream() throws IOException {
        if (os==null) {
            os=new SharedOutputStream();
            lastModified=System.currentTimeMillis();
        }
        return os;
    }

    @Override
    public Reader openReader(boolean ignoreEncodingErrors) throws IOException {
        return new InputStreamReader(openInputStream());
    }

    @Override
    public Writer openWriter() throws IOException {
        return new OutputStreamWriter(openOutputStream());
    }

    @Override
    public URI toUri() {
        try {
            return new URI(name);
        } catch (URISyntaxException e) {
            return null;
        }
    }

    public String toString()
    {
        return name;
    }
    
    public SharedOutputStream getData()
    {
        return os;
    }
}
