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
package org.jclarion.clarion.runtime;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.TimeZone;

import junit.framework.TestCase;

public class CDateTest extends TestCase {

    private TimeZone local;
    
    public void setUp() {
        local=TimeZone.getDefault();
        TimeZone t = TimeZone.getTimeZone("Australia/Melbourne");
        assertFalse(t.getDisplayName().equals("Greenwich Mean Time"));
        TimeZone.setDefault(t);
    }
    
    public void tearDown() {
        TimeZone.setDefault(local);
    }
    
    public void testClarionDateToEpoch() 
    {
        assertEquals(CDate.clarionDateToEpoch(61729),getDate("1969-12-31 00:00:00.000"));
        assertEquals(CDate.clarionDateToEpoch(61730),getDate("1970-01-01 00:00:00.000"));
        assertEquals(CDate.clarionDateToEpoch(61731),getDate("1970-01-02 00:00:00.000"));
        assertEquals(CDate.clarionDateToEpoch(76154),getDate("2009-06-29 00:00:00.000"));
        assertEquals(CDate.clarionDateToEpoch(76155),getDate("2009-06-30 00:00:00.000"));
        assertEquals(CDate.clarionDateToEpoch(76278),getDate("2009-10-31 00:00:00.000"));
        assertEquals(CDate.clarionDateToEpoch(76279),getDate("2009-11-01 00:00:00.000"));
        assertEquals(CDate.clarionDateToEpoch(76068),getDate("2009-04-04 00:00:00.000"));
        assertEquals(CDate.clarionDateToEpoch(76069),getDate("2009-04-05 00:00:00.000"));
        assertEquals(CDate.clarionDateToEpoch(76070),getDate("2009-04-06 00:00:00.000"));
        assertEquals(CDate.clarionDateToEpoch(76250),getDate("2009-10-03 00:00:00.000"));
        assertEquals(CDate.clarionDateToEpoch(76251),getDate("2009-10-04 00:00:00.000"));
        assertEquals(CDate.clarionDateToEpoch(76252),getDate("2009-10-05 00:00:00.000"));
        
        
    }

    public void testEpochToClarionDate() 
    {
        
        // try right on epoch
        assertEquals(61730,CDate.epochToClarionDate(getDate("1970-01-01 00:00:00.000")));

        // try a millisecond before
        assertEquals(61729,CDate.epochToClarionDate(getDate("1969-12-31 23:59:59.999")));

        // try a day before
        assertEquals(61729,CDate.epochToClarionDate(getDate("1969-12-31 00:00:00.000")));

        // try a day before
        assertEquals(61729,CDate.epochToClarionDate(getDate("1969-12-31 00:00:00.001")));

        // try a millisecond after
        assertEquals(61730,CDate.epochToClarionDate(getDate("1970-01-01 00:00:00.001")));

        // 12 hours after
        assertEquals(61730,CDate.epochToClarionDate(getDate("1970-01-01 12:00:00.000")));

        // just under 24 hours after
        assertEquals(61730,CDate.epochToClarionDate(getDate("1970-01-01 23:59:59.999")));

        // Next date
        assertEquals(61731,CDate.epochToClarionDate(getDate("1970-01-02 00:00:00.000")));

        // Next date again
        assertEquals(61731,CDate.epochToClarionDate(getDate("1970-01-02 00:00:00.001")));

        // more recent time
        assertEquals(76154,CDate.epochToClarionDate(getDate("2009-06-29 23:59:59.999")));
        assertEquals(76155,CDate.epochToClarionDate(getDate("2009-06-30 00:00:00.000")));
        assertEquals(76155,CDate.epochToClarionDate(getDate("2009-06-30 00:00:00.001")));
        
        // during planning daylight savings period 
        assertEquals(76278,CDate.epochToClarionDate(getDate("2009-10-31 23:59:59.001")));
        assertEquals(76279,CDate.epochToClarionDate(getDate("2009-11-01 00:00:00.000")));
        assertEquals(76279,CDate.epochToClarionDate(getDate("2009-11-01 00:00:00.001")));
        assertEquals(76279,CDate.epochToClarionDate(getDate("2009-11-01 23:59:59.001")));

        // on daylight savings changeover for 2009 - from and to
        // ends - Sunday 5 Apr 2009 (3 am) 
        // begins - 4 Oct 2009 (2 am)
        
        // firstly verify above
        Calendar c= Calendar.getInstance();
        c.setTimeInMillis(getDate("2009-4-5 1:59:59.999"));
        assertEquals(3600000,c.get(Calendar.DST_OFFSET));
        c.add(Calendar.MILLISECOND,1);
        assertEquals(3600000,c.get(Calendar.DST_OFFSET));
        c.add(Calendar.HOUR,1);
        assertEquals(0,c.get(Calendar.DST_OFFSET));
        
        c.setTimeInMillis(getDate("2009-10-4 1:59:59.999"));
        assertEquals(0,c.get(Calendar.DST_OFFSET));
        c.add(Calendar.MILLISECOND,1);
        assertEquals(3600000,c.get(Calendar.DST_OFFSET));
  
        // April 76069
        assertEquals(76068,CDate.epochToClarionDate(getDate("2009-04-04 00:00:00.000")));
        assertEquals(76068,CDate.epochToClarionDate(getDate("2009-04-04 23:59:59.999")));
        assertEquals(76069,CDate.epochToClarionDate(getDate("2009-04-05 00:00:00.000")));
        assertEquals(76069,CDate.epochToClarionDate(getDate("2009-04-05 00:00:00.001")));
        assertEquals(76069,CDate.epochToClarionDate(getDate("2009-04-05 01:59:59.999")));
        assertEquals(76069,CDate.epochToClarionDate(getDate("2009-04-05 01:59:59.999")+1));
        assertEquals(76069,CDate.epochToClarionDate(getDate("2009-04-05 01:59:59.999")+3600000));
        assertEquals(76069,CDate.epochToClarionDate(getDate("2009-04-05 01:59:59.999")+3600001));
        assertEquals(76069,CDate.epochToClarionDate(getDate("2009-04-05 04:00:00.000")));
        assertEquals(76069,CDate.epochToClarionDate(getDate("2009-04-05 23:59:59.999")));
        assertEquals(76070,CDate.epochToClarionDate(getDate("2009-04-06 00:00:00.000")));
        
        // October 76251
        assertEquals(76250,CDate.epochToClarionDate(getDate("2009-10-03 23:59:59.999")));
        assertEquals(76251,CDate.epochToClarionDate(getDate("2009-10-04 00:00:00.000")));
        assertEquals(76251,CDate.epochToClarionDate(getDate("2009-10-04 01:59:59.999")));
        assertEquals(76251,CDate.epochToClarionDate(getDate("2009-10-04 01:59:59.999")+1));
        assertEquals(76251,CDate.epochToClarionDate(getDate("2009-10-04 01:59:59.999")+2));
        assertEquals(76251,CDate.epochToClarionDate(getDate("2009-10-04 23:59:59.999")));
        assertEquals(76252,CDate.epochToClarionDate(getDate("2009-10-05 00:00:00.000")));
    }
    
    public void testToday() {
        int today = CDate.today();
        assertEquals(today,CDate.epochToClarionDate(System.currentTimeMillis()));
    }

    public void testClock() {
        int clock = CDate.clock();
        long epoch = System.currentTimeMillis();
        
        Calendar c=  Calendar.getInstance();
        c.setTimeInMillis(epoch);
        
        int test = 1 + c.get(Calendar.HOUR_OF_DAY)*60*60*100 +
            c.get(Calendar.MINUTE)*60*100 +
            c.get(Calendar.SECOND)*100 +
            c.get(Calendar.MILLISECOND)/10;
     
        // within 10 milliseconds
        assertTrue(  Math.abs(test-clock)<10 );
    }

    public void testMonth() {
        assertEquals(10,CDate.month(76278));
        assertEquals(11,CDate.month(76279));
    }

    public void testDay() {
        assertEquals(31,CDate.day(76278));
        assertEquals(1,CDate.day(76279));
    }

    public void testYear() {
        assertEquals(2009,CDate.year(76278));
        assertEquals(1970,CDate.year(61730));
    }

    public void testDate() {
        assertEquals(76278,CDate.date(10,31,2009));
        assertEquals(76279,CDate.date(11,01,2009));
        assertEquals(76250,CDate.date(10,03,2009));
        assertEquals(76251,CDate.date(10,04,2009));
        assertEquals(76252,CDate.date(10,05,2009));
        assertEquals(61730,CDate.date(1,1,1970));
        assertEquals(61731,CDate.date(1,2,1970));
        assertEquals(61729,CDate.date(12,31,1969));
    }
    

    private long getDate(String date) 
    {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        try {
            return sdf.parse(date).getTime();
        } catch (ParseException e) {
            fail(e.getMessage());
            return 0;
        }
    }
    
}
