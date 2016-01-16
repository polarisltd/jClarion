package org.jclarion.clarion.lang;

import java.util.regex.Pattern;

public class StringEncoding 
{
    private String in;
    int     scan=0;
    private StringBuilder out;
    private int mark;
    private int outMark;
    
    public StringEncoding(String in)
    {
        out=new StringBuilder(in.length());
        this.in=in;
    }
    
    public char read()
    {
        return in.charAt(scan++);
    }
    
    public int pos()
    {
        return scan;
    }

    public void pos(int pos)
    {
        scan=pos;
    }
    
    public int remaining()
    {
        return in.length()-scan;
    }
    
    public int len()
    {
        return in.length();
    }
    
    public boolean matches(Pattern p,int ofs)
    {
        return p.matcher(in).find(scan+ofs);
    }
    
    public char peek(int offset)
    {
        return in.charAt(scan+offset);
    }

    public char charAt(int offset)
    {
        return in.charAt(offset);
    }
    
    public void append(char c)
    {
        out.append(c);
    }

    public void append(String s)
    {
        out.append(s);
    }
    
    public StringBuilder getBuilder()
    {
        return out;
    }
    
    public String toString()
    {
        return in;
    }

    public void mark()
    {
        mark=scan;
        outMark=out.length();
    }

    public void reset()
    {
        scan=mark;
    }
    
    public String getMark()
    {
        return out.substring(outMark);
    }
}
