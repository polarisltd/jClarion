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

import junit.framework.TestCase;

public class TimeFormatTest extends TestCase
{
    public void testMachineDeformat()
    {
        testDeformat("@t1","12",12,0,0);
        testDeformat("@t1","5",5,0,0);
        testDeformat("@t1","530",5,30,0);
        testDeformat("@t1","53010",5,30,10);
        testDeformat("@t1","7",7,0,0);
        testDeformat("@t1i","30",30,0,0);
        testDeformat("@t1","1200",12,0,0);
        testDeformat("@t1","120000",12,0,0);
        testDeformat("@t1","120102",12,1,2);

        testDeformat("@t1","125916",12,59,16);

        testDeformat("@t1","235916",23,59,16);

        testDeformat("@t1","005916",0,59,16);

        testDeformat("@t1","095916",9,59,16);

        testDeformat("@t1","095916PM",21,59,16);
    }

    public void testSimpleDeformat()
    {
        testDeformat("@t1","12",12,0,0);
        testDeformat("@t1",":12",0,12,0);
        testDeformat("@t1","0:12",0,12,0);
        testDeformat("@t1",":2",0,2,0);
        testDeformat("@t1",":20",0,20,0);
        
    	
        testDeformat("@t1","12:00",12,0,0);
        testDeformat("@t1","12:00:00",12,0,0);
        testDeformat("@t1","12:01:02",12,1,2);

        testDeformat("@t1","12-59-16",12,59,16);

        testDeformat("@t1","23 59 16",23,59,16);

        testDeformat("@t1","00,59,16",0,59,16);

        testDeformat("@t1","12,59,16AM",0,59,16);

        testDeformat("@t1","12,59,16PM",12,59,16);

        testDeformat("@t1","1,59,16PM",13,59,16);

        testDeformat("@t1","01,59,16PM",13,59,16);
    }

    public void testBlankDeformat()
    {
        TimeFormat tf = new TimeFormat("@T1");
        assertEquals("",tf.deformat(""));
    }

    public void testBlankFormat()
    {
        TimeFormat tf = new TimeFormat("@T1");
        assertEquals(" : ",tf.format(""));
        assertEquals(" : ",tf.format("0"));
        assertEquals("0:00",tf.format("1"));
        
        assertEquals("<#:##",tf.getPictureRepresentation());

        tf = new TimeFormat("@T1b");
        assertEquals("",tf.format(""));
        assertEquals("",tf.format("0"));
        assertEquals("0:00",tf.format("1"));

        assertEquals("<#:##",tf.getPictureRepresentation());
    }
    
    public void testSimpleFormat()
    {
        testFormat("@t1","0:00","<#:##",0,0,0);
        testFormat("@T1-","0-00","<#-##",0,0,0);
        testFormat("@T01-","00-00","##-##",0,0,0);
        testFormat("@T01-","00-06","##-##",0,6,5);
        testFormat("@T01-","00-06","##-##",0,6,59);
        testFormat("@T01-","09-06","##-##",9,6,59);
        testFormat("@T01-","17-06","##-##",17,6,59);
        testFormat("@T01-","30-06","##-##",30,6,59);

        testFormat("@T02-","1706","####",17,6,59);

        testFormat("@T03.","05.06PM","##.##XM",17,6,59);
        testFormat("@T3.","5.06PM","<#.##XM",17,6,59);
        testFormat("@T03.","09.06AM","##.##XM",9,6,59);
        testFormat("@T03.","09.06AM","##.##XM",9,6,59);
        testFormat("@T3.","12.06AM","<#.##XM",0,6,59);
        testFormat("@T3.","12.06PM","<#.##XM",12,6,59);
        testFormat("@t03.","12.06AM","##.##XM",0,6,59);
        testFormat("@t03.","12.06PM","##.##XM",12,6,59);

        testFormat("@T04.","17.06.59","##.##.##",17,6,59);
        testFormat("@T4.","7.06.59","<#.##.##",7,6,59);
        testFormat("@T04.","07.06.59","##.##.##",7,6,59);

        testFormat("@T05.","170659","######",17,6,59);
        testFormat("@T5.","70659","<#####",7,6,59);
        testFormat("@T05'","070659","######",7,6,59);

        testFormat("@T06.","05.06.59PM","##.##.##XM",17,6,59);
        testFormat("@T6.","5.06.59PM","<#.##.##XM",17,6,59);
        testFormat("@T6.","7.06.59AM","<#.##.##XM",7,6,59);
        testFormat("@T06.","07.06.59AM","##.##.##XM",7,6,59);
    }
    
    public void testFormat(String picture,String value,String rep,int h,int m,int s)
    {
        TimeFormat tf = new TimeFormat(picture);
        assertEquals(value,tf.format(""+simpleDate(h,m,s)));
        assertEquals(rep,tf.getPictureRepresentation());
    }

    public void testDeformat(String picture,String value,int h,int m,int s)
    {
        TimeFormat tf = new TimeFormat(picture);
        assertEquals(""+simpleDate(h,m,s),tf.deformat(value));
    }
    
    public int simpleDate(int h,int m,int s)
    {
        return h*360000+m*6000+s*100+1;
    }
}
