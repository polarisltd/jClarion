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
package org.jclarion.clarion.compile.grammar;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.lang.Lexer;

public class FileLexerSource extends LexerSource {

    private Map<String,File> files=new HashMap<String, File>();
    
    //private long start=0;
    //private long last=0;
    
    public FileLexerSource(String name)
    {
        //start=System.currentTimeMillis();
        //last=start;
        File f = new File(name);
        loadDirectory(f);
        System.out.println(files.size()+" Files loaded");
    }
    
    private void loadDirectory(File f) {
        File bits[] = f.listFiles();
        if (bits==null) return;
        
        for (int scan=0;scan<bits.length;scan++) {
            File t = bits[scan];
            if (t.getName().startsWith(".")) continue;
            if (t.isFile()) {
                String name = cleanName(t.getName());
                if (files.containsKey(name)) throw new IllegalStateException("Duplicated File Name! "+t+" "+files.get(name));
                files.put(name,t);
            }
            if (t.isDirectory()) {
                loadDirectory(t);
            }
        }
    }

    @Override
    public Lexer getLexer(String name) {

        /*
        long now = System.currentTimeMillis();
        long d1=now-start;
        long d2=now-last;
        last=now;
        System.out.println(d1+" ("+d2+") Loading:"+name);
         */
        
        File f=  files.get(cleanName(name));
        if (f==null) return null;
        try {
            Lexer l = new Lexer(new FileReader(f),name);
            return l;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }
}
