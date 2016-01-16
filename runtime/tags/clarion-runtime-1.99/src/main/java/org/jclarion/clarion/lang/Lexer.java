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
package org.jclarion.clarion.lang;

import java.io.Reader;

import java.util.Stack;


public class Lexer 
{
    private static final boolean DEBUG=false;
    
    private AbstractLexStream     reader;
    private Stack<String>         markers;
    private String                cmarker;
    private boolean       ignoreWhitespace;
    
    private Lex[]         buffer;
    private int           bufferPos=0;
    private int           bufferSize=0;

    private static class Savepoint
    {
        public int                  position;
        public StackTraceElement    trace[];
        
        public Savepoint(int position)
        {
            this.position=position;
            if (DEBUG) {
                trace=Thread.currentThread().getStackTrace();
            }
        }
        
        public String toString()
        {
            StringBuilder sb = new StringBuilder();
            sb.append("SP:").append(position).append("\n=============\n");
            if (trace!=null) {
                sb.append(trace.toString()).append('\n');
            }
            return sb.toString();
        }
    }
    
    private Stack<Savepoint> savepoints = new Stack<Savepoint>();

    private boolean javaMode=true;
    
    public Lexer(Reader reader,String name) 
    {
        this.reader=new LexStream(reader);
        this.reader.setName(name);
        buffer=new Lex[1];
    }

    public Lexer(Reader reader) 
    {
        this(reader,"Unknown");
    }
    
    public AbstractLexStream getStream()
    {
        return reader;
    }
    
    public void setStream(AbstractLexStream stream)
    {
        this.reader=stream;
    }
    
    public void setJavaMode(boolean mode)
    {
        javaMode=mode;
    }
    
    public int begin()
    {
        packBuffer();        
        savepoints.add(new Savepoint(bufferPos));
        return bufferPos;
    }
    
    public void commit()
    {
        savepoints.pop();
        packBuffer();        
    }

    public void commit(int pos)
    {
        Savepoint p = savepoints.pop();
        if (pos!=p.position) throw new IllegalStateException("Position mismatch on commit:"+p); 
        packBuffer();        
    }
    
    public Lex[] capture(int pos)
    {
        Lex[] l = new Lex[this.bufferPos-pos];
        System.arraycopy(buffer,pos,l,0,l.length);
        return l;
    }

    public void rollback()
    {
        Savepoint p = savepoints.pop();
        bufferPos=p.position;
        packBuffer();        
    }
    
    public void rollback(int pos)
    {
        Savepoint p = savepoints.pop();
        if (pos!=p.position) throw new IllegalStateException("Position mismatch on commit:"+p);
        bufferPos=p.position;
        packBuffer();        
    }
    
    public boolean eof()
    {
        if (bufferPos!=bufferSize) return false;
        return reader.eof();
    }
    
    public void testEmpty()
    {
        if (!eof()) error("Not empty");
    }
    
    public void skipUntilMarker(String skip)
    {
        while ( true ) {
            if (reader.eof()) break;
            if (reader.readString(skip,true)) break;
            reader.skip(1);
        }
    }
    
    public void setIgnoreWhitespace(boolean ignore)
    {
        ignoreWhitespace=ignore;
    }
    
    public boolean isIgnoreWhitespace()
    {
        return ignoreWhitespace;
    }
            
    
    public void addIncludeMarker(String marker)
    {
        if (cmarker!=null) {
            if (markers==null) markers=new Stack<String>();
            markers.add(cmarker);
        }
        cmarker=marker;
    }
    
    public Lex next()
    {
        return _next(true,0);
    }
    
    public Lex lookahead()
    {
        return _next(false,0);
    }
    
    public Lex lookahead(int offset)
    {
        return _next(false,offset);
    }

    
    public void error(String msg)
    {
        msg=msg+" near line:"+reader.getLineCount()+" ("+reader.getName()+")";
        
        System.err.println("ERROR:"+msg);
        debug(msg);
        throw new ClarionCompileError(msg);
    }

    public void error(String msg,Throwable t)
    {
        msg=msg+" near line:"+reader.getLineCount()+" ("+reader.getName()+")";
        System.err.println("ERROR:"+msg);
        debug(msg);
        throw new ClarionCompileError(msg,t);
    }
    
    public void debug(String msg)
    {
        System.err.println("DEBUG:"+msg+" WS:"+ignoreWhitespace);
        System.err.println("==========");
        lookahead(10);
        
        for (int scan=0;scan<bufferSize;scan++) {
            System.err.print( scan == bufferPos ? "-> " : "   ");
            boolean match=false;
            for (Savepoint test : savepoints) {
                if (test.position==scan) match=true;
            }
            System.err.print( match ? "* " : "  ");
            System.err.println(buffer[scan].toString());
        }
        System.err.println("==========");
    }
    
    /**
     * Get next Lex token from stream/buffer taking following into consideration
     *  - pay attention to setIgnoreWhitespace() setting
     * @return
     */
    Lex _next(boolean consume,int offset)
    {
        int tpos=0;
        while ( true ) {
            if (tpos+bufferPos==bufferSize) {
                incBuffer();
                Lex l = _next();
                if (l.type==LexType.eof) {
                    if (consume) {
                        bufferPos+=tpos;
                        tpos=0;
                        packBuffer();
                    }
                    return l;
                }
                buffer[bufferSize++]=l;
            }
            
            Lex l = buffer[tpos+bufferPos];
            tpos++;
            if (ignoreWhitespace && l.type==LexType.ws) continue;

            if (offset>0) {
                offset--;
                continue;
            }
            
            if (consume) {
                bufferPos+=tpos;
                tpos=0;
                packBuffer();
            }
            return l;
        }
    }
    
    /**
     * Read next raw Lex Token off underlying stream 
     * 
     * @return
     */
    Lex _next() {
        
        if (reader.eof()) return new Lex(LexType.eof,"");
        
        while (cmarker!=null) {
            if (!reader.readString(cmarker,true)) break;
            cmarker=null;
            if (markers!=null) {
                cmarker=markers.pop();
                if (markers.empty()) markers=null;
            }
        }

        if (reader.eof()) return new Lex(LexType.eof,"");
        
        char c = reader.peek(0);
        
        if ((c>='a' && c<='z') || (c>='A' && c<='Z') || (c=='_')) {
            reader.read();
            // label
            while ( true ) {
                c=reader.peek(0);
                while ( true ) {
                    if (c>='a' && c<='z') break;
                    if (c>='A' && c<='Z') break;
                    if (c>='0' && c<='9') break;
                    if (c=='_') break;
                    if (c==':') break;
                    return new Lex(LexType.label,reader.getToken());
                }
                reader.read();
            }
        }
        
        if (c==' ' || c=='\t' || c=='|') {
            while ( true ) {
                if (c==' ' || c=='\t') {
                    reader.read();
                    c=reader.peek(0);
                    continue;
                }
                if (c=='|') {
                    while ( true ) {
                        if (reader.eof()) break;
                        if (reader.read()=='\n') break;
                    }
                    c=reader.peek(0);
                    continue;
                }
                break;
            }
            return new Lex(LexType.ws,reader.getToken());
        }
        
        if (c=='\r' && reader.peek(1)=='\n') {
            // newline
            reader.read();
            reader.read();
            return new Lex(LexType.nl,reader.getToken());
        }

        if (c==':' && reader.peek(1)=='=' && reader.peek(2)==':') {
            // newline
            reader.read();
            reader.read();
            reader.read();
            return new Lex(LexType.assign,reader.getToken());
        }
        
        
        if (c>='0' && c<='9') {

            reader.read();
            
            // integer or decimal

            boolean decimal=false;
            
            while ( true ) {
                c=reader.peek(0);
                if (c>='0' && c<='9') {
                    reader.read();
                    continue;
                }
                if (c>='a' && c<='f') {
                    reader.read();
                    continue;
                }
                if (c>='A' && c<='F') {
                    reader.read();
                    continue;
                }
                
                if (c=='.') {
                    char c2=reader.peek(1);
                    if (c2>='0' && c2<='9') {
                        decimal=true;
                        reader.read();
                        continue;
                    }
                }
                
                if (c=='h' || c=='H' || c=='o' || c=='O') {
                    reader.read();
                }

                break;
            }
            return new Lex(decimal?LexType.decimal:LexType.integer,
                    Constant.number(reader.getToken()));
        }
        
        switch(c) {
            case '\n': {
                // newline
                reader.read();
                return new Lex(LexType.nl,reader.getToken());
            }
            case '\'': {
                // string
                reader.skip(1);
                while ( true ) {
                    if (reader.eof()) break;
                    if (reader.peek(0)=='\r' && reader.peek(1)=='\n') {
                        break;
                    }
                    if (reader.peek(0)=='\n') {
                        break;
                    }
                    
                    if (reader.peek(0)=='\'') {
                        if (reader.peek(1)!='\'') {
                            reader.skip(1);
                            break;
                        }
                        reader.read();
                    }
                    reader.read();
                }
                return new Lex(LexType.string,Constant.string(reader.getToken(),javaMode));
            }
            
            case '!': {
                //comment
                reader.read();
                while ( true ) {
                    if (reader.eof()) break;
                    
                    if (reader.peek(0)=='\r' && reader.peek(1)=='\n') break;
                    if (reader.peek(0)=='\n') break;
                    
                    reader.read();
                }
                return new Lex(LexType.comment,reader.getToken());
            }
            
            case '.': {
                // decimal
                reader.read();
                while ( true ) {
                    if (reader.eof()) break;
                    c=reader.peek(0);
                    if (c<'0' || c>'9') break;
                    reader.read();
                }
                String token = reader.getToken();
                if (token.length()==1) {
                    return new Lex(LexType.dot,token);
                } else {
                    return new Lex(LexType.decimal,Constant.number(token));
                }
            }
            
            case '(': 
                reader.read();
                return new Lex(LexType.lparam,reader.getToken());
            case ')': 
                reader.read();
                return new Lex(LexType.rparam,reader.getToken());
            case '[': 
                reader.read();
                return new Lex(LexType.lbrack,reader.getToken());
            case ']': 
                reader.read();
                return new Lex(LexType.rbrack,reader.getToken());
            case '{': 
                reader.read();
                return new Lex(LexType.lcurl,reader.getToken());
            case '}': 
                reader.read();
                return new Lex(LexType.rcurl,reader.getToken());
            case '"': 
            case '#': 
            case '$': 
                reader.read();
                return new Lex(LexType.implicit,reader.getToken());
                
            case '<':
                reader.read();
                c=peekSkipWS(reader);
                switch(c) {
                    case '>':
                    case '=':
                    	readSkipWS(reader,"<");
                }
                return new Lex(LexType.comparator,reader.getToken());

            case '>':
                reader.read();
                c=peekSkipWS(reader);
                switch(c) {
                    case '=':
                        readSkipWS(reader,">");
                }
                return new Lex(LexType.comparator,reader.getToken());

            case '~':
                reader.read();
                c=peekSkipWS(reader);
                switch(c) {
                    case '=':
                    case '<':
                    case '>':
                    	readSkipWS(reader,"~");
                }
                return new Lex(LexType.comparator,reader.getToken());

            case '=':
                reader.read();
                c=peekSkipWS(reader);
                switch(c) {
                    case '>':
                    case '<':
                    	readSkipWS(reader,"=");
                }
                return new Lex(LexType.comparator,reader.getToken());

            case '&':
                reader.read();
                if (peekSkipWS(reader)=='=') {
                    readSkipWS(reader,"&");
                    return new Lex(LexType.comparator,reader.getToken());
                }
                return new Lex(LexType.reference,reader.getToken());

            case '+':
            case '-':
            case '^':
            case '*':
            case '/':
            case '%':
                char t = reader.read();
                if (peekSkipWS(reader)=='=') {
                    readSkipWS(reader,String.valueOf(t));
                    return new Lex(LexType.assign,reader.getToken());
                }
                return new Lex(LexType.operator,reader.getToken());

            case ',':
                reader.read();
                return new Lex(LexType.param,reader.getToken());

            case ';':
                reader.read();
                return new Lex(LexType.semicolon,reader.getToken());

            case ':':
                reader.read();
                return new Lex(LexType.colon,reader.getToken());

            case '?':
                reader.read();
                return new Lex(LexType.use,reader.getToken());

            case '@':
                // picture
                reader.read();
                
                // java extension
                if (reader.readString("java",true)) {
                    reader.appendToToken("java");
                    while ( true ) {
                        c=reader.peek(0);
                        if (c==' ' || c=='\t' || c=='\r' || c=='\n') break;
                        reader.read();
                    }
                    
                    return new Lex(LexType.java,reader.getToken());
                }
                    
                    
                c = reader.read();
                
                if (c=='n' || c=='N') {
                    if (reader.readAny("$~")=='~') {
                        reader.readUntil('~');
                    }
                    
                    reader.readAny("-+");
                    reader.readAny("0*_");
                    reader.readAny("_.-");
                    reader.readNumber();
                    if (reader.readAny("_-")==0) {
                        if (reader.peek(0)=='.' && (reader.peek(1)<'0' || reader.peek(1)>'9')) {
                            reader.read();
                        }
                    }
                    if (reader.readAny(".'`v")!=0) {
                        reader.readNumber();
                    }
                    reader.readAny("-+");

                    if (reader.readAny("$~")=='~') {
                        reader.readUntil('~');
                    }
                    reader.readAny("bB");
                }
                if (c=='s' || c=='S') {
                    reader.readNumber();
                }
                if (c=='K' || c=='k') {
                    reader.readUntil(c);
                    reader.readAny("bB");
                }
                if (c=='P' || c=='p') {
                    reader.readUntil(c);
                    reader.readAny("bB");
                }
                if (c=='d' || c=='D') {
                    reader.readNumber();
                    reader.readAny(".'=_-");
                    if (reader.readAny("<>")!=0) {
                        reader.readNumber();
                    }
                    reader.readAny("bB");
                }
                if (c=='t' || c=='T') {
                    reader.readNumber();
                    reader.readAny(".'=_-");
                    reader.readAny("bB");
                }
                
                return new Lex(LexType.picture,reader.getToken());
        }

        reader.read();
        return new Lex(LexType.other,reader.getToken());
    }

    
    private char peekSkipWS(AbstractLexStream reader) 
    {
    	int scan=0;
    	while (true) {
    		char c = reader.peek(scan);
    		if (c==' ' || c=='\t') {
    			scan++;
    		} else {
    			return c;
    		}
    	}
	}

    private void readSkipWS(AbstractLexStream reader,String suffix) 
    {
    	boolean reset=false;
    	while (true) {
			if (reset) reader.setToken(suffix);
    		char c = reader.read();
    		if (c==' ' || c=='\t') {
    			reset=true;
    			continue;
    		} else {
    			break;
    		}
    	}
	}

	private void incBuffer()
    {
        if (bufferSize+1<=buffer.length) return;
        
        if (savepoints.isEmpty() && bufferPos>0) {
            // resize buffer based on shifting buffer Pos
            
            int shift = bufferPos;
            
            if (bufferSize>bufferPos) {
                System.arraycopy(buffer,shift,buffer,0,bufferSize-bufferPos);
            }
            bufferPos-=shift;
            bufferSize-=shift;
            
            return;
        }
        
        int nsize=buffer.length;
        while (nsize<bufferSize+1) nsize=nsize<<1; // double buffer size
        Lex newBuffer[] = new Lex[nsize];
        System.arraycopy(buffer,0,newBuffer,0,bufferSize);
        buffer=newBuffer;
    }
    
    private void packBuffer()
    {
        if (bufferPos==bufferSize && savepoints.isEmpty()) {
            bufferPos=0;
            bufferSize=0;
        }
    }

    public int getBeginCount() {
        return savepoints.size();
    }
}
