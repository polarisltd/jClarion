package org.jclarion.clarion.lang;

public abstract class AbstractLexStream {

    private StringBuilder token = new StringBuilder();
    private int lineCount = 1;
    private String name;
    
    public abstract int     getEOFPosition(int ofs);
    public abstract boolean eof(int ofs);
    public abstract char    peek(int ofs);
    protected abstract char    readChar();

    public AbstractLexStream() {
        super();
    }

    public void skip(int skip)
    {
        while (skip>0) {
            char c=  readChar();
            if (c=='\n') lineCount++;
            skip--;
        }
    }
    
    public boolean eof()
    {
        return eof(0);
    }
    
    
    public void setName(String name) {
        this.name=name;
    }

    public String getName() {
        return name;
    }

    public int getLineCount() {
        return lineCount;
    }

    public void readUntil(char c) {
        while (true ) {
            if (eof()) break;
            if (read()==c) break;
        }
    }

    public void readNumber() {
        while ( true ) {
            if (eof()) break;
            char c = peek(0);
            if (c<'0' || c>'9') break;
            read();
        }
    }

    public boolean readString(String string) {
        return readString(string,false);
    }

    public boolean readString(String string, boolean ignoreWS) {
        if (ignoreWS) string=string.toLowerCase();
        
        for (int scan=0;scan<string.length();scan++) {
            char c = peek(scan);
            if (ignoreWS && c>='A' && c<='Z') c=(char)(c-'A'+'a');
            if (c!=string.charAt(scan)) return false;
        }
        skip(string.length());
        return true;
    }

    public char readAny(String bits) {
        if (eof()) return (char)0;
        char c = peek(0);
        for (int scan=0;scan<bits.length();scan++) {
            if (bits.charAt(scan)==c) {
                return read();
            }
        }
        return (char)0;
    }

    public void appendToToken(String add) {
        token.append(add);
    }

    public String getToken() {
        String result = token.toString();
        token.setLength(0);
        return result;
    }
    
    public void setToken(String token)
    {
        this.token.setLength(0);
        this.token.append(token);
    }
    
    public final char read()
    {
        char c=  readChar();
        if (c==0) return 0;
        if (c=='\n') lineCount++;
        token.append(c);
        return c;
    }

}