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

import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Reader;
import java.io.Writer;
import java.net.URI;

import javax.lang.model.element.Modifier;
import javax.lang.model.element.NestingKind;
import javax.tools.JavaFileObject;

public class MavenHackFileJava implements JavaFileObject,MavenHack
{
    private String name;
    private File file;

    public MavenHackFileJava(File f,String name) {
        file=f;
        this.name=name;
    }

    @Override
    public Modifier getAccessLevel() {
        return null;
    }

    @Override
    public Kind getKind() {
        return Kind.CLASS;
    }

    @Override
    public NestingKind getNestingKind() {
        return null;
    }

    @Override
    public boolean isNameCompatible(String simpleName, Kind kind) 
    {
        simpleName=simpleName.replaceAll(".class$","");
        return getName().equals(name);
    }

    @Override
    public boolean delete() {
        return false;
    }

    @Override
    public CharSequence getCharContent(boolean ignoreEncodingErrors)
            throws IOException {
        throw new IllegalStateException("Dunno");
    }

    @Override
    public long getLastModified() {
        return file.lastModified();
    }

    @Override
    public String getName() {
        return file.getName();
    }

    @Override
    public InputStream openInputStream() throws IOException {
        return new FileInputStream(file); 
    }

    @Override
    public OutputStream openOutputStream() throws IOException {
        throw new IllegalStateException("Dunno");
    }

    @Override
    public Reader openReader(boolean ignoreEncodingErrors) throws IOException {
        return new FileReader(file);
    }

    @Override
    public Writer openWriter() throws IOException {
        throw new IllegalStateException("Dunno");
    }

    @Override
    public URI toUri() {
        return file.toURI();
    }
    
}
