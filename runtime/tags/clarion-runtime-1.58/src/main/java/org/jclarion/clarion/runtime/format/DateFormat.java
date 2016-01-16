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

//import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
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
    private static class ProfileMetaData
    {
        private String longMonths[];
        private String shortMonths[];
        private int    longMaxLen;
        private int    shortMaxLen;
        private Map<String,Integer> lookupMonths;
        private Locale locale;
     
        private static ProfileMetaData instance;
        
        public static ProfileMetaData getInstance()
        {
            synchronized(ProfileMetaData.class) {
                if (instance!=null && instance.locale!=Locale.getDefault()) {
                    instance=null;
                }
                if (instance==null) {
                    instance=new ProfileMetaData();
                }
            }
            return instance;
        }
        
        public ProfileMetaData()
        {
            locale=Locale.getDefault();
            java.text.DateFormatSymbols sym = java.text.DateFormatSymbols.getInstance(locale); 
            longMonths=sym.getMonths();
            shortMonths=sym.getShortMonths();
            longMaxLen=0;
            for (String month : longMonths) {
                if (month.length()>longMaxLen) longMaxLen=month.length();
            }
            shortMaxLen=0;
            for (String month : shortMonths) {
                if (month.length()>shortMaxLen) shortMaxLen=month.length();
            }
            
            lookupMonths=new HashMap<String,Integer>();
            boolean allocated[]=new boolean[longMonths.length];
            int unallocated=allocated.length;
            while (unallocated>0) {
                for (int scan=0;scan<allocated.length;scan++) {
                    if (allocated[scan]) continue;
                    
                    int len=0;
                    String test = longMonths[scan].toLowerCase();
                    while ( true ) {
                        len++;
                        if (len>test.length()) {
                            allocated[scan]=true;
                            unallocated--;
                            break; // do not index this one : it is not unique!
                        }
                        String key = test.substring(0,len);
                        Integer value = lookupMonths.get(key);
                        if (value==null) {
                            allocated[scan]=true;
                            unallocated--;
                            lookupMonths.put(key,scan);
                            break;
                        }
                        if (value>=0) {
                            // conflict - deallocate lookup and flag conflict
                            allocated[value]=false;
                            unallocated++;
                            lookupMonths.put(key,-1);
                        } // else value<0 : conflict already detected
                    }
                }
            }
        }
        
        public int lookupMonth(String month)
        {
            month=month.toLowerCase();
            int len=0;
            while ( true ) {
                len++;
                if (len>month.length()) return -1;
                String key = month.substring(0,len);
                Integer value = lookupMonths.get(key);
                if (value!=null && value>=0) return value;
            }
        }
    }
    
    
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

    private static abstract class FormatComponent
    {
        public abstract void format(DateFormat format,StringBuilder target,Calendar value);
        public abstract void picture(DateFormat format,StringBuilder target);
    }

    private static class SeperatorField extends FormatComponent
    {
        @Override
        public void format(DateFormat format, StringBuilder target,
                Calendar value) {
            target.append(format.sep);
        }

        @Override
        public void picture(DateFormat format, StringBuilder target) {
            target.append(format.sep);
        }
    }

    private static class ConstField extends FormatComponent
    {
        private String value;
        
        public ConstField(String value)
        {
            this.value=value;
        }
        
        @Override
        public void format(DateFormat format, StringBuilder target,Calendar value) {
            target.append(this.value);
        }

        @Override
        public void picture(DateFormat format, StringBuilder target) {
            target.append(this.value);
        }
    }
    
    private static class NumericField extends FormatComponent
    {
        private int type;
        private int minlen;
        private int maxlen;
        private int offset;

        public NumericField(int type,int minlen,int maxlen)
        {
            this(type,minlen,maxlen,0);
        }

        public NumericField(int type,int minlen,int maxlen,int offset)
        {
            this.type=type;
            this.minlen=minlen;
            this.maxlen=maxlen;
            this.offset=offset;
        }
        
        @Override
        public void format(DateFormat format, StringBuilder target,Calendar value) {
            int val = value.get(type)+offset;

            int len=1;
            if (val>=1000) {
                len=4;
            } else if (val>=100) {
                len=3;
            } else if (val>=10) {
                len=2;
            }
            
            if (format.pad) {
                for (int scan=0;scan<maxlen;scan++) {
                    target.append("0");
                }
            } else {
                if (minlen>len) {
                    for (int scan=0;scan<minlen;scan++) {
                        target.append("0");
                    }
                } else {
                    for (int scan=0;scan<len && scan<maxlen;scan++) {
                        target.append("0");
                    }
                }
            }
            
            for (int scan=0;scan<len && scan<maxlen;scan++) {
                target.setCharAt(target.length()-1-scan,(char)('0'+val%10));
                val=val/10;
            }
        }

        @Override
        public void picture(DateFormat format, StringBuilder target) 
        {
            for (int scan=0;scan<maxlen-minlen;scan++) {
                target.append(format.pad?'#':'<');
            }
            for (int scan=0;scan<minlen;scan++) {
                target.append('#');
            }
        }
    }

    private static class LongMonthField extends FormatComponent
    {
        @Override
        public void format(DateFormat format, StringBuilder target,Calendar value) {
            int val = value.get(Calendar.MONTH)-Calendar.JANUARY;
            target.append(ProfileMetaData.getInstance().longMonths[val]);
        }

        @Override
        public void picture(DateFormat format, StringBuilder target) 
        {
            int len = ProfileMetaData.getInstance().longMaxLen;
            for (int scan=0;scan<len;scan++) {
                target.append('#');
            }
        }
    }

    private static class ShortMonthField extends FormatComponent
    {
        @Override
        public void format(DateFormat format, StringBuilder target,Calendar value) {
            int val = value.get(Calendar.MONTH)-Calendar.JANUARY;
            target.append(ProfileMetaData.getInstance().shortMonths[val]);
        }

        @Override
        public void picture(DateFormat format, StringBuilder target) 
        {
            int len = ProfileMetaData.getInstance().shortMaxLen;
            for (int scan=0;scan<len;scan++) {
                target.append('#');
            }
        }
    }
    
    private static class BasicFormat
    {
        private Order order;
        private FormatComponent[] format;
        
        public BasicFormat(Order order,FormatComponent ...format)
        {
            this.order=order;
            this.format=format;
        }
        
        public String toString()
        {
            return "BasicFormat:["+order+" format:"+format+"]";
        }
    }

    private static FormatComponent M2 = new NumericField(Calendar.MONTH,1,2,1-Calendar.JANUARY);
    private static FormatComponent D2 = new NumericField(Calendar.DAY_OF_MONTH,1,2);
    private static FormatComponent M2X = new NumericField(Calendar.MONTH,2,2,1-Calendar.JANUARY);
    private static FormatComponent D2X = new NumericField(Calendar.DAY_OF_MONTH,2,2);
    private static FormatComponent Y2 = new NumericField(Calendar.YEAR,2,2);
    private static FormatComponent Y4 = new NumericField(Calendar.YEAR,4,4);
    private static FormatComponent ML = new LongMonthField();
    private static FormatComponent MS = new ShortMonthField();
    private static FormatComponent S = new SeperatorField();
    private static FormatComponent SP = new ConstField(" ");
    private static FormatComponent CO = new ConstField(", ");
    
    private static BasicFormat formats[] = {
        new BasicFormat(Order.MDY,M2,S,D2,S,Y2),    // @d1
        new BasicFormat(Order.MDY,M2,S,D2,S,Y4),    // @d2
        new BasicFormat(Order.MDY,MS,SP,D2,CO,Y4),   // @d3
        new BasicFormat(Order.MDY,ML,SP,D2,CO,Y4),   // @d4
        
        new BasicFormat(Order.DMY,D2,S,M2,S,Y2),    // @d5
        new BasicFormat(Order.DMY,D2,S,M2,S,Y4),    // @d6
        new BasicFormat(Order.DMY,D2,SP,MS,SP,Y2),  // @d7
        new BasicFormat(Order.DMY,D2,SP,MS,SP,Y4),  // @d8

        new BasicFormat(Order.YMD,Y2,S,M2,S,D2),    // @d9
        new BasicFormat(Order.YMD,Y4,S,M2,S,D2),    // @d10
        new BasicFormat(Order.YMD,Y2,M2X,D2X),      // @d11
        new BasicFormat(Order.YMD,Y4,M2X,D2X),      // @d12

        new BasicFormat(Order.MY,M2,S,Y2),          // @d13
        new BasicFormat(Order.MY,M2,S,Y4),          // @d14

        new BasicFormat(Order.YM,Y2,S,M2),          // @d15
        new BasicFormat(Order.YM,Y4,S,M2),          // @d16

        new BasicFormat(Order.DMY,D2,S,M2,Y2),      // @d17
        new BasicFormat(Order.DMY,D2,SP,MS,SP,Y4),  // @d18
    };
    /*
         No sensible way to do these in Clarion
     
        * @d17 = locale short date default
        * @d18 - locale long date default
    */

    private BasicFormat     format;
    private String          pattern_represention=null;
    private boolean         blank=false;
    private char            sep='/';
    private int             intelliFuture=20;
    private boolean         pad;
    
    public DateFormat(String input)
    {
        super(input);
        SimpleStringDecoder ssd = new SimpleStringDecoder(input);
        if (!ssd.pop('@')) ssd.error("Invalid Format");
        if (!ssd.pop('d')) ssd.error("Invalid Format");
        
        pad = ssd.pop('0');
        
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
        
        format = formats[itype-1];
 
        StringBuilder pattern = new StringBuilder();
        for (FormatComponent fc : format.format ) {
            fc.picture(this,pattern);
        }
        pattern_represention=pattern.toString();
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
                if (format.order.getCount() == 2) {
                    if (field.length() != 4 && field.length() != 6) break;
                    y4 = field.length() == 6;
                } else {
                    if (field.length() != 6 && field.length() != 8) break;
                    y4 = field.length() == 8;
                }
                int pos = 0;
                for (int scan = 0; scan < format.order.getCount(); scan++) {
                    if (format.order.isYear(scan)) {
                        if (y4) {
                            year = field.substring(pos, pos + 4);
                            pos = pos + 4;
                        } else {
                            year = field.substring(pos, pos + 2);
                            pos = pos + 2;
                        }
                    }
                    if (format.order.isMonth(scan)) {
                        month = field.substring(pos, pos + 2);
                        pos = pos + 2;
                    }
                    if (format.order.isDay(scan)) {
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
            if (count>format.order.getCount()) return error();
            for (int scan = 0; scan < count;scan++) {
                if (format.order.isYear(scan))  year=tok.nextToken();
                if (format.order.isMonth(scan)) month=tok.nextToken();
                if (format.order.isDay(scan))   day=tok.nextToken();
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
            imonth=ProfileMetaData.getInstance().lookupMonth(month);
            if (imonth>=0) imonth++;
            
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
            for (int scan=0;scan<format.order.getCount();scan++) {
                if (format.order.isDay(scan)) {
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
                if (format.order==Order.DMY) size3=true;
                if (format.order==Order.MDY) size3=true;
                if (format.order==Order.YMD) size3=true;
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
        
        StringBuilder output=new StringBuilder();
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(CDate.clarionDateToEpoch(date));

        for (FormatComponent fc : format.format ) {
            fc.format(this,output,c);
        }
        return output.toString();
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
