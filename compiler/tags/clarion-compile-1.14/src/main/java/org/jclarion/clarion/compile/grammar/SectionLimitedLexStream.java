package org.jclarion.clarion.compile.grammar;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jclarion.clarion.lang.AbstractLexStream;

public class SectionLimitedLexStream extends AbstractLexStream
{
    private AbstractLexStream base; 
    private char ringBuffer[];
    private int  head;
    private int  tail;
    private boolean testSection=false;
    
    private class RingBufferSequence implements CharSequence 
    {
        private int  head;
        private int  tail;

        public RingBufferSequence(int head,int tail)
        {
            if (head>=ringBuffer.length) head-=ringBuffer.length;
            if (tail>=ringBuffer.length) tail-=ringBuffer.length;
            this.head=head;
            this.tail=tail;
        }
        
        @Override
        public char charAt(int index) {
            int pos = tail+index;
            if (pos>=ringBuffer.length) pos=pos-ringBuffer.length;
            return ringBuffer[pos];
        }

        @Override
        public int length() {
            if (tail<=head) {
                return head-tail;
            }
            return head-tail+ringBuffer.length;
        }

        @Override
        public CharSequence subSequence(int start, int end) 
        {
            return new RingBufferSequence(tail+end,tail+start);
        }
        
        public String toString()
        {
            if (head>=tail) {
                return new String(ringBuffer,tail,head-tail);
            }
            return (new StringBuilder(this)).toString();
        }
    }

    
    public SectionLimitedLexStream(AbstractLexStream base,String section)
    {
        this.base=base;
        ringBuffer=new char[512];
        head=0;
        tail=0;
        head=1;
        ringBuffer[0]='\n'; //fake insert leading \n

        while ( true ) {
            fillBuffer();
            if (head==tail) break;
            if (section.equalsIgnoreCase(matchSection())) {
                break;
            }
            read();
        }
        testSection=true;
    }
    
    @Override
    public boolean eof(int ofs) {
        fillBuffer();
        int diff = head-tail;
        if (diff<0) diff+=ringBuffer.length;
        
        if (testSection) {
            int section_end = getSectionDistance();
            if (section_end>=0 && section_end<diff) diff=section_end;
        }
        if (diff<=ofs) return true;
        return false;
    }

    @Override
    public int getEOFPosition(int ofs) {
        fillBuffer();
        int diff = head-tail;
        if (diff<0) diff+=ringBuffer.length;
        
        if (testSection) {
            int section_end = getSectionDistance();
            if (section_end>=0 && section_end<diff) diff=section_end;
        }
        if (diff>ofs) return -1;
        return diff;
    }

    @Override
    public char peek(int ofs) {
        int eof = getEOFPosition(ofs); 
        if (eof>0) return 0;
        
        int pos = tail+ofs;
        if (pos>=ringBuffer.length) pos-=ringBuffer.length;
        return ringBuffer[pos];
    }

    @Override
    protected char readChar() {
        fillBuffer();
        if (testSection) {
            if (matchSection()!=null) return 0;
        }
        
        if (head==tail) return 0;
        char result = ringBuffer[tail];
        tail++;
        if (tail==ringBuffer.length) tail=0;
        return result;
    }
    
    private void fillBuffer()
    {
        while (true) {
            if (head+1==tail) break;
            if (head==ringBuffer.length-1 && tail==0) break;
            char c = base.read();
            if (c==0) break;
            ringBuffer[head]=c;
            head++;
            if (head==ringBuffer.length) head=0;
        }
    }
    
    private static Pattern section=Pattern.compile("(?i)^\\n(?:[ \t]*)section(?:[ \t]*)\\((?:[ \t]*)'([^']+)'(?:[ \t]*)\\)");
    
    private String matchSection() 
    {
        RingBufferSequence rbs = new RingBufferSequence(head,tail);
        Matcher m = section.matcher(rbs);
        if (m.find()) {
            String result = m.group(1);
            boolean oldTest=testSection;
            testSection=false;
            skip(m.end());
            testSection=oldTest;
            return result;
        }
        return null;
    }

    private static Pattern sectionDistance=Pattern.compile("(?i)\\n(?:[ \t]*)section(?:[ \t]*)\\((?:[ \t]*)'([^']+)'(?:[ \t]*)\\)");
    
    private int getSectionDistance() 
    {
        RingBufferSequence rbs = new RingBufferSequence(head,tail);
        Matcher m = sectionDistance.matcher(rbs);
        if (m.find()) {
            return m.start();
        }
        return -1;
    }

    @Override
    public int getLineCount() {
        // return less one because of the fake '\n' we insert into the stream at the top
        // for pattern matching purposes
        return super.getLineCount()-1;
    }

    @Override
    public String getName() {
        return base.getName();
    }
    

    
}
