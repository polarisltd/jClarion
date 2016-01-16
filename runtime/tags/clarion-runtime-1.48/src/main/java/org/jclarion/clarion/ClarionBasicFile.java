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
package org.jclarion.clarion;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.file.ClarionFileFactory;
import org.jclarion.clarion.runtime.CErrorImpl;
import org.jclarion.clarion.util.SharedWriter;


public class ClarionBasicFile extends ClarionFile 
{
    private ClarionRandomAccessCharFile file;
    private SharedWriter                write_stream=new SharedWriter();

    private char    endOfRecord[]       = "\r\n".toCharArray();
    private char    fieldDelimiter[]    = new char[] { ',' };
    private boolean controlZIsEOF       = true;
    private boolean eofINQuote          = true;
    private char    quote               = '"';
    private boolean alwaysQuote         = true;
    private boolean endOfRecordInQuote  = true;

    private int     position;
    private boolean atEOF;

    @Override
    public void add() {
        
        CErrorImpl.getInstance().clearError();
        if (file==null) {
            CErrorImpl.getInstance().setError(37,"File not open");
        }
        try {
            write(file.length());
        } catch (IOException ex) {
            CErrorImpl.getInstance().setError(05,ex.getMessage());
        }
    }

    private boolean matches(char c,char in[])
    {
        for (char test : in ) {
            if (test==c) return true;
        }
        return false;
    }
    
    private void write(long pos) 
    {
        try {
            preserveRead();
            file.seek(pos);
            write_stream.reset();
            
            for (int scan=1;scan<=getVariableCount();scan++) {
                if (scan>1) {
                    write_stream.write(this.fieldDelimiter);
                }
                
                ClarionObject o = what(scan);
                boolean doQuote=false;
                String s = o.toString();
                int len=s.length();
                
                if (o instanceof ClarionString) {
                    doQuote=alwaysQuote;
                    while (len>0 && s.charAt(len-1)==' ') len--;
                    if (!doQuote) {
                        for (int s_scan=0;s_scan<len;s_scan++) {
                            char c = s.charAt(s_scan);
                            if (matches(c,endOfRecord) || matches(c,this.fieldDelimiter) || c==27 | c==this.quote) {
                                doQuote=true;
                                break;
                            }
                        }
                    }
                }
                     
                if (doQuote) write_stream.write(this.quote);
                for (int s_scan=0;s_scan<len;s_scan++) {
                    
                    //charset.encode(
                    
                    char c = s.charAt(s_scan);
                    if (!this.endOfRecordInQuote && matches(c,this.endOfRecord)) continue;
                    if (!this.eofINQuote && c==27) continue;
                    if (c==this.quote) {
                        write_stream.write(this.quote);
                    }
                     write_stream.write(c);
                }
                if (doQuote) write_stream.write(this.quote);
            }
            write_stream.write(this.endOfRecord);
            file.write(write_stream.getBuffer(),0,write_stream.getSize());
        } catch (IOException ex) {
            CErrorImpl.getInstance().setError(05,ex.getMessage());
        }

        atEOF=false;
    }

    @Override
    public boolean bof() {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void buffer(Integer pagesize, Integer behind, Integer ahead,
            Integer timeout) 
    {
    }

    @Override
    public void build() 
    {
    }

    @Override
    public void close() {
        if (file!=null) {
            try {
                file.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            file=null;
        }
    }

    @Override
    public void create() {
        String fname=getProperty(Prop.NAME).toString().trim();
        CErrorImpl.getInstance().clearError();
        if (!Boolean.TRUE.equals(ClarionFileFactory.getInstance().create(fname))) {
            CErrorImpl.getInstance().setError(5,"Could not create");
        }
    }

    @Override
    public void delete() 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    public boolean eof() 
    {
        if (file==null) return true;
        if (atEOF) return true; // Ctrl-Z end of file
        try {
            if (controlZIsEOF) {
                if (lookahead(true)==27) return true;
            }
            return readPosition()==file.length();
        } catch (IOException e) {
            return true;
        }
    }

    @Override
    public void flush() 
    {
    }

    @Override
    public void freeState(int state) 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void get(ClarionKey akey) 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void get(ClarionString pointer, Integer len) 
    {
        if (len!=null) {
            throw new RuntimeException("Not supported");
        }
        reget(pointer);
    }

    @Override
    public void get(ClarionNumber position, Integer len) {
        if (len!=null) {
            throw new RuntimeException("Not supported");
        }
        CErrorImpl.getInstance().clearError();
        get(position.intValue()-1);
    }
    
    
    @Override
    public ClarionString getNulls() 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    public int getPointer() 
    {
        return (int)(position)+1;
    }

    @Override
    public ClarionString getPosition(ClarionKey key) 
    {
        if (key!=null) {
            throw new RuntimeException("Not supported");
        }
        
        char bits[] = new char[4];
        int pointer = getPointer();
        bits[0]=(char)((pointer>>24)&0xff);
        bits[1]=(char)((pointer>>16)&0xff);
        bits[2]=(char)((pointer>>8)&0xff);
        bits[3]=(char)((pointer)&0xff);

        return new ClarionString(new String(bits));
    }

    @Override
    public int getState() 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void lock() 
    {
        throw new RuntimeException("Not supported");
    }


    private SharedWriter  read_stream=new SharedWriter();
    private int quoteMode;  // 0 = none. 1 = in quote. 2 = quote in quote
    private static final int QM_NONE=0;
    private static final int QM_QUOTE=1;
    private static final int QM_ESCAPE=2;
    
    private List<String> params=new ArrayList<String>();
    private StringBuilder read_param=new StringBuilder();
    
    private void resetStream()
    {
        read_stream.reset();
        quoteMode=0;
        params.clear();
    }
    
    private boolean appendToStream(char next_char)
    {
        if (next_char==quote) {
            if (quoteMode==QM_NONE) {
                if (read_stream.getSize()==0) {
                    quoteMode=QM_QUOTE;
                    return false;
                }
            }
            if (quoteMode==QM_QUOTE) {
                quoteMode=QM_ESCAPE;
                return false;
            }
            
            if (quoteMode==QM_ESCAPE) {
                read_stream.append(quote);
                quoteMode=QM_QUOTE;
                return false;
            }
        } else {
            if (quoteMode==QM_ESCAPE) {
                quoteMode=QM_NONE;
            }
        }
        
        read_stream.write(next_char);
        if (quoteMode==QM_QUOTE && !endOfRecordInQuote && read_stream.endsWith(endOfRecord[endOfRecord.length-1])) {
            quoteMode=QM_NONE;
        } 
        if (quoteMode==QM_QUOTE && !endOfRecordInQuote && read_stream.endsWith((char)27)) {
            quoteMode=QM_NONE;
        }

        if (quoteMode==QM_NONE) {
            if (next_char==fieldDelimiter[fieldDelimiter.length-1] && read_stream.endsWith(fieldDelimiter)) {
                read_stream.skip(-fieldDelimiter.length);
                streamToField();
                return false;
            }
            
            if (next_char==endOfRecord[endOfRecord.length-1]) {
                read_stream.shrink(endOfRecord);
                streamToField();
                return true;
            }
            
            if (next_char==27 && this.controlZIsEOF) {
                read_stream.shrink();
                if (read_stream.getSize()!=0 || !params.isEmpty()) {
                    streamToField();
                }
                atEOF=true;
                return true;
            }
        }
        
        return false;
    }

    private void streamToField() 
    {
        read_param.setLength(0);
        int len = read_stream.getSize();
        char buffer[] = read_stream.getBuffer();
        for (int scan=0;scan<len;scan++) {
            read_param.append(buffer[scan]);
        }
        params.add(read_param.toString());
        read_stream.reset();
    }

    private void copyStreamToRecord()
    {
        if (params.isEmpty()) {
            CErrorImpl.getInstance().setError(33,"File not found");
            return;
        }
        
        int fc = getVariableCount();
        for (int scan=1;scan<=fc;scan++) {
            ClarionObject o = what(scan);
            if (scan>params.size()) {
                o.clear();
            } else {
                o.setValue(params.get(scan-1));
            }
        }
    }
    
    @Override
    public void next() 
    {
        CErrorImpl.getInstance().clearError();
        if (file==null) {
            CErrorImpl.getInstance().setError(37,"File not open");
            return;
        }

        if (eof()) {
            CErrorImpl.getInstance().setError(33,"End of File");
            return;
        }
        
        resetStream();
        
        try {
            position = readPosition();
            
            while ( true ) {
                int chr = read();
                if (chr==-1) break;
                if (appendToStream((char)chr)) break;
            }

            copyStreamToRecord();
            
        } catch (IOException ex) {
            CErrorImpl.getInstance().setError(33,ex.getMessage());
            return;
        }
    }

    @Override
    public void open(int mode) 
    {
        String fname=getProperty(Prop.NAME).toString().trim();
        try {
            file=ClarionFileFactory.getInstance().getRandomAccessFile(fname).getCharFile();
            CErrorImpl.getInstance().clearError();
        } catch (IOException e) {
            CErrorImpl.getInstance().setError(2,e.getMessage());
        }
    }

    @Override
    public void previous() 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void put() 
    {
        CErrorImpl.getInstance().clearError();
        if (file==null) {
            CErrorImpl.getInstance().setError(37,"File not open");
        }
        write(position);
    }

    @Override
    public int records() 
    {
         throw new RuntimeException("Not supported");
    }

    @Override
    public void reget(ClarionKey key,ClarionString string) 
    {
        CErrorImpl.getInstance().clearError();
        if (key!=null) {
            throw new RuntimeException("Not yet implemented");
        }
        
        CErrorImpl.getInstance().clearError();
        String s = string.toString();
        
        position = 
            ((s.charAt(0)&0xff)<<24)+
            ((s.charAt(1)&0xff)<<16)+
            ((s.charAt(2)&0xff)<<8)+
            ((s.charAt(3)&0xff))-1;
     
        get(position);
    }
    
    private void get(int position)
    {
        try {
            preserveRead();
            resetStream();
            file.seek(position);
            while ( true ) {
                int val = file.read();
                if (val==-1) break;
                if (appendToStream((char)val)) break;
            }
        } catch (IOException e) {
            CErrorImpl.getInstance().setError(35,e.getMessage());
        }

        copyStreamToRecord();
    }

    @Override
    public void remove() {
        close();
        String fname=getProperty(Prop.NAME).toString().trim();
        CErrorImpl.getInstance().clearError();
        ClarionFileFactory.getInstance().delete(fname);
    }

    @Override
    public void reset(ClarionKey key,ClarionString string) 
    {
        if (key!=null) {
            throw new RuntimeException("Not supported");
        }
        String s = string.toString();
        
        set( 
            ((s.charAt(0)&0xff)<<24)+
            ((s.charAt(1)&0xff)<<16)+
            ((s.charAt(2)&0xff)<<8)+
            ((s.charAt(3)&0xff)));
    }

    @Override
    public void set(int pos) 
    {
        CErrorImpl.getInstance().clearError();
        atEOF=false;
        readLookahead=-1;
        readPosition=pos-1;
    }

    @Override
    public void restoreState(int state) 
    {
        throw new RuntimeException("Not supported");
    }

    private Pattern sendPattern;
    
    @Override
    public void send(String operator) {
        operator=operator.toLowerCase();
        if (sendPattern==null) sendPattern=Pattern.compile("^\\s*/?\\s*(alwaysquote|comma|ctrlziseof|endofrecord|endofrecordinquote|fielddelimiter|filebuffers|quickscan|quote)\\s*=\\s*(.*?)\\s*$");
        Matcher m = sendPattern.matcher(operator);
        if (!m.matches()) throw new RuntimeException("Send command unknown:"+operator);

        String key = m.group(1);
        String value = m.group(2);

        if (key.equalsIgnoreCase("alwaysquote")) {
            alwaysQuote=value.equalsIgnoreCase("on");
            return;
        }

        if (key.equalsIgnoreCase("comma")) {
            fieldDelimiter=new char[] { (char)Byte.parseByte(value) };
            return;
        }

        if (key.equalsIgnoreCase("fielddelimiter")) {
            fieldDelimiter=decodeCharArraySend(value);
            return;
        }
        
        if (key.equalsIgnoreCase("ctrlziseof")) {
            controlZIsEOF=value.equalsIgnoreCase("on");
            return;
        }

        if (key.equalsIgnoreCase("endofrecord")) {
            endOfRecord=decodeCharArraySend(value);
            return;
        }

        if (key.equalsIgnoreCase("endofrecordinquote")) {
            endOfRecordInQuote=value.equalsIgnoreCase("on");
            return;
        }

        if (key.equalsIgnoreCase("quote")) {
            quote=(char)Byte.parseByte(value);
            return;
        }
    }

    @Override
    public void set(ClarionKey key) 
    {
        if (key!=null) {
            throw new RuntimeException("Not yet implemented");
        }
        atEOF=false;
        readLookahead=-1;
        readPosition=0;
    }


    @Override
    public void setNulls(ClarionString nulls) 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    public void stream() 
    {
    }

    @Override
    public void unlock() 
    {
    }

    @Override
    public void watch() 
    {
        throw new RuntimeException("Not supported");
    }

    @Override
    protected String getDriver() {
        return "Basic";
    }

    @Override
    public void add(int size) 
    {
        throw new RuntimeException("Not supported");
    }

    private int readLookahead=-1;
    private int readPosition=-1;
    private int preLookaheadPosition=0;
    
    private void preserveRead() throws IOException
    {
        readLookahead=-1;
        if (readPosition==-1) {
            readPosition=readPosition();
        }
    }

    private int readPosition() throws IOException
    {
        if (readPosition>=0) return readPosition;
        if (readLookahead==-1) {
            return (int)file.position();
        } else {
            return preLookaheadPosition;
        }
    }
    
    private int lookahead(boolean rememberPosition) throws IOException
    {
        if (readLookahead==-1) {
            if (readPosition>=0) {
                file.seek(readPosition);
                readPosition=-1;
            }
            if (rememberPosition) {
                preLookaheadPosition=(int)file.position();
            }
            readLookahead=file.read();
        }
        return readLookahead;
    }
    
    private int read() throws IOException
    {
        int result = lookahead(false);
        readLookahead=-1;
        return result;
    }

    
}
