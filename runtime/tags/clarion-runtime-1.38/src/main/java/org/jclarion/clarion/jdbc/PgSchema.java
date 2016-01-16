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
package org.jclarion.clarion.jdbc;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PgSchema 
{
    private static PgSchema sInstance;
    
    public static PgSchema get()
    {
        if (sInstance==null) {
            sInstance=new PgSchema();
            sInstance.load();
        }
        return sInstance;
    }
    
    private List<String> schema=new ArrayList<String>();

    public PgSchema()
    {
        schema=new ArrayList<String>();
    }

    public PgSchema(List<String> schema)
    {
        this.schema=schema;
    }
    
    public PgSchema[] split(String regex)
    {
        Pattern p = Pattern.compile(regex);
        PgSchema[] split = new PgSchema[2];

        int midpoint=0;
        while (midpoint<schema.size()) {
            Matcher m = p.matcher(getTask(midpoint));
            if (m.find()) break;
            midpoint++;
        }

        split[0]=new PgSchema(schema.subList(0,midpoint));
        split[1]=new PgSchema(schema.subList(midpoint,schema.size()));
        
        return split;
    }
    
    public void load()
    {
        ClassLoader cl = getClass().getClassLoader();
        InputStream is = cl.getResourceAsStream("resources/schema.sql");
        if (is==null) return;
        try {
            load(is);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public void load(InputStream is) throws IOException
    {
        InputStreamReader isr = new InputStreamReader(is);
        BufferedReader br = new BufferedReader(isr);
        
        StringBuilder result=new StringBuilder();

        result.setLength(0);
        
        while ( true ) {
            
            String next = br.readLine();
            
            if (next==null) {
                if (result.length()>0) {
                    schema.add(result.toString());
                }
                break;
            }
            
            if (next.startsWith("SET client_encoding")) continue;
                
            if (next.length()==0) continue;
            if (next.charAt(0)=='-') {
                if (result.length()>0) {
                    schema.add(result.toString());
                }
                result.setLength(0);
                continue;
            }
            
            if (result.length()>0) result.append('\n');
            result.append(next);
        }
    }
 
    public int getCount()
    {
        return schema.size();
    }
    
    public String getTask(int ofs)
    {
        return schema.get(ofs);
    }
    
    public List<String> getTasks()
    {
        return schema;
    }

    public Set<String> getTables()
    {
        HashSet<String> set=new HashSet<String>();
        Pattern p = Pattern.compile("^create table (\\S+)");
        for (String line : schema ) {
            line=line.toLowerCase();
            Matcher m = p.matcher(line);
            if (m.find()) {
                set.add(m.group(1));
            }
        }
        return set;
    }

    public Set<String> getColumns(String name)
    {
        HashSet<String> set=new HashSet<String>();
        Pattern p = Pattern.compile("^create table "+(name.toLowerCase())+" ");
        Pattern f = Pattern.compile("^\\s+(\\S+)\\s(\\S+)");
        
        
        for (String line : schema ) {
            line=line.toLowerCase();
            
            Matcher m = p.matcher(line);
            if (m.find()) {
                
                StringTokenizer lines = new StringTokenizer(line,"\n");
                while (lines.hasMoreTokens()) {
                    m = f.matcher(lines.nextToken());
                    if (m.find()) {
                        String col = m.group(1);
                        col=col.replaceAll("\"","");
                        set.add(col);
                    }
                }
            }
        }
        return set;
    }
    
    public void write(Writer w) throws IOException
    {
        for (String line : schema ) {
            w.write("--\n");
            w.write(line);
            w.write("\n");
        }
    }
}
