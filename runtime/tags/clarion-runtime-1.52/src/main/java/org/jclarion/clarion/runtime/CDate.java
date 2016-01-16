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

import java.util.Calendar;

/**
 *  Clarion date format is number of days since Dec 28 1800. 
 * ---------------
 *  
 *  Valid values start from 4 , Jan 1 1801.
 *  
 *  Epoch (1.1.1970) = 61730
 *  
 *  Assumption is that clarion stored date is localtime based on current
 *  timezone location - so epoch conversion will take this into consideration
 *  
 *  i.e. 1.1.1970 clarion date for me equals 1.1.1970 Midnight Melbourne/Victoria
 *  But for someone running software in different TZ, the epoch result will differ
 * 
 * Clarion time format
 * ---------------
 *  Value = 100ths of seconds since midnight + 1.
 *  
 *  i.e. midnight = 1
 *  
 *  the 100th of a second before midnight = 8640000
 *  
 *  Assumption is that clarion time values are wall time only and do
 *  not take daylight savings variations into consideration 
 * 
 * @author barney
 *
 */
public class CDate {

    public static int epochToClarionDate(long epoch)
    {
        Calendar c=  Calendar.getInstance();
        c.setTimeInMillis(epoch);
        c.set(Calendar.ZONE_OFFSET,0); // zero out local timezone effects
        c.set(Calendar.DST_OFFSET,0);  // zero out local daylight savings effects

        long v = c.getTimeInMillis();
        
        if (v>0) {
            return (int)(v/86400000)+61730;
        } else {
            return (int)((v-86399999)/86400000)+61730;
        }
    }

    private static Long localizedEpoch;

    public static long clarionDateToEpoch(int date)
    {
        Calendar c=  Calendar.getInstance();
        clarionDateToEpoch(date,c);
        return c.getTimeInMillis();
    }
    
    public static String age(int c_birthdate,int c_basedate)
    {
        int difference = c_basedate-c_birthdate;
        
        if (difference<61) {
            return difference+" DAYS";
        }

        Calendar birthdate_cal = Calendar.getInstance();
        clarionDateToEpoch(c_birthdate,birthdate_cal);
        
        Calendar basedate_cal = Calendar.getInstance();
        clarionDateToEpoch(c_basedate,basedate_cal);
        
        long year_diff=basedate_cal.get(Calendar.YEAR)-birthdate_cal.get(Calendar.YEAR);
        
        long month_diff=year_diff*12 + basedate_cal.get(Calendar.MONTH)-birthdate_cal.get(Calendar.MONTH);
        
        if (month_diff<=24) return month_diff+" MOS";
        
        // reduce year by one based on calendar year (assuming implementation is birthdate type)
        birthdate_cal.set(Calendar.YEAR,basedate_cal.get(Calendar.YEAR));
        if (birthdate_cal.compareTo(basedate_cal)>0) {
            year_diff--;
        }
        
        return year_diff+" YRS";
    }
    
    public static void clarionDateToEpoch(int date,Calendar c)
    {
        if (localizedEpoch==null) {
            Calendar le=  Calendar.getInstance();
            le.setTimeInMillis(0);
            le.set(Calendar.ZONE_OFFSET,0); // zero out local timezone effects
            le.set(Calendar.DST_OFFSET,0);  // zero out local daylight savings effects
            localizedEpoch = -le.getTimeInMillis();
        }
        
        c.setTimeInMillis(localizedEpoch);
        c.add(Calendar.DAY_OF_YEAR,date-61730);
    }
    
    
    /**
     *  Get date in clarion format
     * 
     *  
     * @return
     */
    public static int today()
    {
        return epochToClarionDate(System.currentTimeMillis());
    }

    /**
     *  Get time of day in clarion format
     *  
     *  Value = 10ths of seconds since midnight + 1.
     *  
     *  i.e. midnight = 1
     *  
     *  the 10th of a second before midnight = 8640000
     *  
     *  0 = invalid/null
     *  
     * @return
     */
    public static int clock()
    {
        Calendar c = Calendar.getInstance();
        
        return 1+
            c.get(Calendar.HOUR_OF_DAY)*360000+
            c.get(Calendar.MINUTE)*6000+
            c.get(Calendar.SECOND)*100+
            c.get(Calendar.MILLISECOND)/10;
    }

    /**
     *  Get month (1-12) based on provided date
     *  
     * @param date
     * @return
     */
    public static int month(int date)
    {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(clarionDateToEpoch(date));
        return c.get(Calendar.MONTH)-Calendar.JANUARY+1;
    }

    /**
     *  Get day (1-31) based on provided date
     *  
     * @param date
     * @return
     */
    public static int day(int date)
    {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(clarionDateToEpoch(date));
        return c.get(Calendar.DAY_OF_MONTH);
    }

    /**
     *  Get year in yyyy format based on provided date
     *  
     * @param date
     * @return
     */
    public static int year(int date)
    {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(clarionDateToEpoch(date));
        return c.get(Calendar.YEAR);
    }

    /**
     * Calculate date from supplied gregorian date semantics
     * 
     * @param month
     * @param day
     * @param year
     * @return
     */
    public static int date(int month,int day,int year)
    {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.HOUR_OF_DAY,0);
        c.set(Calendar.MINUTE,0);
        c.set(Calendar.SECOND,0);
        c.set(Calendar.MILLISECOND,0);
        c.set(Calendar.YEAR,year);
        c.set(Calendar.MONTH,month-1+Calendar.JANUARY);
        c.set(Calendar.DAY_OF_MONTH,day);
        return epochToClarionDate(c.getTimeInMillis());
    }

}
