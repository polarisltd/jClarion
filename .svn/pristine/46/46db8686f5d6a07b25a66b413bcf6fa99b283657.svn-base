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
package org.jclarion.clarion.runtime.format;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.StringTokenizer;

import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.SimpleStringDecoder;

/**
 * Clarion date formatting
 *  
 * @d <mode>. Mode type 1 to 18. Leading zero indicates to fill day/month with leading zero
 * separator: (default is forward slahes)
 *    . = dots
 *    ' = commas
 *    - = hypens
 *    _ = spaces 
 *    
 * >[num]  for 2 number years - use this century if year specified is 
 *         representable as less than or equal to n years into the future
 *         then use it. Same goes for '<' but in past.
 *         Intellidate default is >20
 * 
 * b - if date is invalid blank - render as empty string
 * 
 * @d1 = mm/dd/yy
 * @d2 = mm/dd/yyyy
 * @d3 = mmm dd, yyyy
 * @d4 = mmmmmmmmm dd, yyyy
 * @d5 = dd/mm/yy
 * @d6 = dd/mm/yyyy
 * @d7 = dd mmm yy
 * @d8 = dd mmm yyyy
 * @d9 = yy/mm/dd
 * @d10 = yyyy/mm/dd
 * @d11 = yymmdd
 * @d12 = yyyymmdd
 * @d13 = mm/yy
 * @d14 = mm/yyyy
 * @d15 = yy/mm
 * @d16 = yyyy/mm
 * 
 * @d17 = locale short date default
 * @d18 - locale long date default
 * 
 *  
 * @author barney
 *
 */

public class DateFormat extends Formatter 
{
    private static class Order {
        
        private static Order DMY = new Order("DMY".toCharArray());
        private static Order MDY = new Order("MDY".toCharArray());
        private static Order YMD = new Order("YMD".toCharArray());
        private static Order MY = new Order("MY".toCharArray());
        private static Order YM = new Order("YM".toCharArray());
        
        private char profile[];
        private Order(char profile[])
        {
            this.profile=profile;
        }
        
        public int getCount()
        {
            return profile.length;
        }
        
        /*
        public char getType(int offset)
        {
            return profile[offset];
        }
        */
        
        public boolean isYear(int offset)
        {
            return profile[offset]=='Y';
        }

        public boolean isMonth(int offset)
        {
            return profile[offset]=='M';
        }

        public boolean isDay(int offset)
        {
            return profile[offset]=='D';
        }
        
        public String toString() {
            return "ORDER:"+(new String(profile));
        }
    }
    
    private static class BasicFormat
    {
        private Order order;
        private String format;
        
        public BasicFormat(Order order,String format)
        {
            this.order=order;
            this.format=format;
        }
        
        public String toString()
        {
            return "BasicFormat:["+order+" format:"+format+"]";
        }
    }

    
    private static BasicFormat formats[] = {
        new BasicFormat(Order.MDY,"M*/d*/yy"),      // @d1
        new BasicFormat(Order.MDY,"M*/d*/yyyy"),    // @d2
        new BasicFormat(Order.MDY,"MMM d*, yyyy"),  // @d3
        new BasicFormat(Order.MDY,"MMMM????? d*, yyyy"), // @d4
        
        new BasicFormat(Order.DMY,"d*/M*/yy"),      // @d5
        new BasicFormat(Order.DMY,"d*/M*/yyyy"),    // @d6
        new BasicFormat(Order.DMY,"d* MMM yy"),     // @d7
        new BasicFormat(Order.DMY,"d* MMM yyyy"),   // @d8

        new BasicFormat(Order.YMD,"yy/M*/d*"),      // @d9
        new BasicFormat(Order.YMD,"yyyy/M*/d*"),    // @d10
        new BasicFormat(Order.YMD,"yyMMdd"),        // @d11
        new BasicFormat(Order.YMD,"yyyyMMdd"),      // @d12

        new BasicFormat(Order.MY,"M*/yy"),          // @d13
        new BasicFormat(Order.MY,"M*/yyyy"),        // @d14

        new BasicFormat(Order.YM,"yy/M*"),          // @d15
        new BasicFormat(Order.YM,"yyyy/M*"),        // @d16

        new BasicFormat(Order.DMY,"d*/M*/yy"),    // @d17
        new BasicFormat(Order.DMY,"d* MMM yyyy"),   // @d18
    };
    /*
         No sensible way to do these in Clarion
     
        * @d17 = locale short date default
        * @d18 - locale long date default
    */
    

    
    private String          format=null;
    private String          pattern_represention=null;
    private class JDF extends ThreadLocal<SimpleDateFormat>
    {
        protected SimpleDateFormat initialValue()
        {
            return new SimpleDateFormat(format);
        }
    }
    
    private JDF             formatter=new JDF();
    
    private Order           order=null;
    private boolean         blank=false;
    private char            sep='/';
    private int             intelliFuture=20;
    
    public DateFormat(String input)
    {
        super(input);
        SimpleStringDecoder ssd = new SimpleStringDecoder(input);
        if (!ssd.pop('@')) ssd.error("Invalid Format");
        if (!ssd.pop('d')) ssd.error("Invalid Format");
        
        boolean pad = ssd.pop('0');
        
        Integer type = ssd.popNumeric();
        if (type==null) ssd.error("Invalid format");
        int itype = type;
        if (itype<1 || itype>18) ssd.error("Invalid format");
        
        switch(ssd.peekChar(0)) {
            case '.':
                ssd.pop('.');
                sep='.';
                break;
            case '\'':
                ssd.pop('\'');
                sep=',';
                break;
            case '-':
                ssd.pop('-');
                sep='-';
                break;
            case '_':
                ssd.pop('_');
                sep=' ';
                break;
        }
    
        intelliFuture=20;
        
        if (ssd.pop('>')) {
            intelliFuture=ssd.popNumeric();
        } else if (ssd.pop('<')) {
            intelliFuture=99-ssd.popNumeric();
        }
        
        if (ssd.pop('b')) blank=true;
        
        if (!ssd.end()) ssd.error("Invalid Format");
        
        BasicFormat f = formats[itype-1];
        order=f.order;
        
        char tformat[] = new char[f.format.length()];
        int tsize=0;
        
        char pformat[] = new char[f.format.length()];
        int psize=0;
        
        for (int scan=0;scan<f.format.length();scan++) {
            char c=  f.format.charAt(scan);
            if (c=='/') c=sep;
            if (c=='?') {
                pformat[psize++]='#';
                continue;
            }
            if (c=='*') {
                if (pad) {
                    c=tformat[tsize-1];
                } else {
                    pformat[psize-1]='<';
                    pformat[psize++]='#';
                    continue;
                }
            }
            tformat[tsize++]=c;
            if ((c>='a' && c<='z') || (c>='A' && c<='Z')) {
                pformat[psize++]='#';
            } else {
                pformat[psize++]=c;
            }
        }
        format=new String(tformat,0,tsize);
        pattern_represention=new String(pformat,0,psize);

    }
    
    @Override
    public String deformat(String input) {
        
        clearError();
        
        // deformatting steps
        // break down into tokens - permitted tokens are ,- /
        // if token count == 1 then do system date checking/conversion based on type. Length of string must be either 6 or 8 chars
        // if token count == 2 only match mm/yy and yy/mm types
        // if token count == 3 then match those types
        // otherwise fail
        
        StringTokenizer tok = new StringTokenizer(input," .,-/\t");
        int count = tok.countTokens();
        if (count>4) return error();
        
        String day=null;
        String month=null;
        String year=null;

        if (count==0) return "";    // blank
        
        if (count==1) {
            while (true) {
                String field = tok.nextToken();
                boolean y4 = false;
                if (order.getCount() == 2) {
                    if (field.length() != 4 && field.length() != 6) break;
                    y4 = field.length() == 6;
                } else {
                    if (field.length() != 6 && field.length() != 8) break;
                    y4 = field.length() == 8;
                }
                int pos = 0;
                for (int scan = 0; scan < order.getCount(); scan++) {
                    if (order.isYear(scan)) {
                        if (y4) {
                            year = field.substring(pos, pos + 4);
                            pos = pos + 4;
                        } else {
                            year = field.substring(pos, pos + 2);
                            pos = pos + 2;
                        }
                    }
                    if (order.isMonth(scan)) {
                        month = field.substring(pos, pos + 2);
                        pos = pos + 2;
                    }
                    if (order.isDay(scan)) {
                        day = field.substring(pos, pos + 2);
                        pos = pos + 2;
                    }
                }
                break;
            }
            
            if (year==null && month==null && day==null) { 
                tok = new StringTokenizer(input," .,-/\t");
            }
        }
        
        if (year==null && month==null && day==null) 
        {
            if (count>order.getCount()) return error();
            for (int scan = 0; scan < count;scan++) {
                if (order.isYear(scan))  year=tok.nextToken();
                if (order.isMonth(scan)) month=tok.nextToken();
                if (order.isDay(scan))   day=tok.nextToken();
            }
        }

        Calendar c = Calendar.getInstance();
        
        int iyear=-1;
        int imonth=-1;
        int iday=-1;
        
        if (year!=null) {
            try {
                iyear = Integer.parseInt(year);
            } catch (NumberFormatException ex) {
                return error();
            }
            if (year.length()<=2) {
                // intellidate
                int thisyear = c.get(Calendar.YEAR);
                int this2dyear = thisyear%100;
                int thiscentury = thisyear-this2dyear;
                
                iyear = iyear + thiscentury;
                if (iyear<thisyear) iyear=iyear+100;
                
                if (thisyear+intelliFuture<iyear) {
                    iyear=iyear-100;
                }
            }
        } else {
            iyear = c.get(Calendar.YEAR);
        }

        // consider swapping month and day around if day clearly looks like a string
        if (day!=null) {
            char fc = day.charAt(0);
            if ((fc>='a' && fc<='z') || (fc>='A' && fc<='Z')) {
                String swap = day;
                day=month;
                month=swap;
            }
        }
        

        
        if (month!=null) {
            month=month.toLowerCase();
            if (month.startsWith("j")) imonth=1;
            if (month.startsWith("f")) imonth=2;
            if (month.startsWith("mar")) imonth=3;
            if (month.startsWith("ap")) imonth=4;
            if (month.startsWith("may")) imonth=5;
            if (month.startsWith("jun")) imonth=6;
            if (month.startsWith("jul")) imonth=7;
            if (month.startsWith("au")) imonth=8;
            if (month.startsWith("s")) imonth=9;
            if (month.startsWith("o")) imonth=10;
            if (month.startsWith("n")) imonth=11;
            if (month.startsWith("d")) imonth=12;
            
            if (imonth==-1) {
                try {
                    imonth=Integer.parseInt(month);
                } catch (NumberFormatException ex) { 
                    return error();
                }
            }
        } else {
            imonth = c.get(Calendar.MONTH)-Calendar.JANUARY+1;
        }
        
        if (day!=null) {
            try {
                iday=Integer.parseInt(day);
            } catch (NumberFormatException ex) { 
                return error();
            }
        } else {
            for (int scan=0;scan<order.getCount();scan++) {
                if (order.isDay(scan)) {
                    iday=c.get(Calendar.DAY_OF_MONTH);
                    break;
                }
            }
            if (iday==-1) iday=1;
        }

        if (iday==-1) return error();
        if (imonth==-1) return error();
        if (iyear==-1) return error();
        
        c.clear();
        c.set(iyear,imonth-1+Calendar.JANUARY,iday);
        
        if (isStrict()) {
            if (iday!=c.get(Calendar.DAY_OF_MONTH)) return error();
            if (imonth!=c.get(Calendar.MONTH)-Calendar.JANUARY+1) return error();
        }

        return String.valueOf(CDate.epochToClarionDate(c.getTimeInMillis()));
    }

    /**
     * Note that format for dates does not implicitly deformat-  because
     * of risk of confusion between machine greogian date and clarion encoded
     * date - cannot tell the two apart. This differs from numeric handling
     */
    @Override
    public String format(String input) {
        clearError();
        String s = input.trim();
        int date = 0;
        try {
            if (s.length()!=0) date = Integer.parseInt(s);
        } catch (NumberFormatException ex) { 
            return error();
        }
        
        if (date==0) {
            if (blank) {
                return "";
            } else {
                boolean size3=false;
                if (order==Order.DMY) size3=true;
                if (order==Order.MDY) size3=true;
                if (order==Order.YMD) size3=true;
                if (size3) {
                    return sep+" "+sep+" "+sep;
                } else {
                    return sep+" "+sep;
                }
            }
        }
        if (date<4) {
            return error();
        }
        
        return formatter.get().format(new Date(CDate.clarionDateToEpoch(date)));
    }

    @Override
    public int getMaxLen() {
        return 18;
    }
    
    private String error()
    {
        setError();
        return "##################";
    }

    @Override
    public String getPictureRepresentation() {
        return pattern_represention;
    }

}
