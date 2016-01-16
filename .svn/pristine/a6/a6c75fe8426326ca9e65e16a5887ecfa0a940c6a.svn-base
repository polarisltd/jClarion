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

import java.util.Calendar;

import org.jclarion.clarion.runtime.CDate;

import junit.framework.TestCase;

public class DateFormatterTest extends TestCase {

    
    public void testSimpleVariousFormats()
    {
        DateFormat df = new DateFormat("@d6.");
        assertEquals("<#.<#.####",df.getPictureRepresentation());
        
        assertEquals(""+CDate.date(11,12,2007),df.deformat("12 nov 2007"));

        assertEquals(""+CDate.date(11,12,2007),df.deformat("12 n 2007"));

        assertEquals(""+CDate.date(CDate.month(CDate.today()),12,CDate.year(CDate.today())),df.deformat("12"));
        assertEquals(""+CDate.date(CDate.month(CDate.today()),9,CDate.year(CDate.today())),df.deformat("9"));
        assertEquals(""+CDate.date(4,12,CDate.year(CDate.today())),df.deformat("12.4"));
        assertEquals(""+CDate.date(3,9,CDate.year(CDate.today())),df.deformat("9.3"));

        assertEquals(""+CDate.date(11,12,2007),df.deformat("12 NOVemBer 2007"));
        assertEquals(""+CDate.date(11,12,2007),df.deformat("12 NOVemBer, 2007"));
        assertEquals(""+CDate.date(11,12,2007),df.deformat("12 -NOVemBer, 2007"));
        assertEquals(""+CDate.date(11,12,2007),df.deformat("12 .-NOVemBer, 2007"));
        assertEquals(""+CDate.date(11,12,2007),df.deformat("12 .-NOVemBer,// 2007"));
        assertEquals(""+CDate.date(11,12,2007),df.deformat("12 11 2007"));

        assertEquals(""+CDate.date(1,1,1970),df.deformat("1 1 1970"));
        
        assertEquals(""+CDate.date(1,1,1970),df.deformat("01 01 1970"));

        assertEquals(""+CDate.date(1,2,1970),df.deformat("02 01 1970"));

        assertEquals(""+CDate.date(2,28,2008),df.deformat("28 2 2008"));
        
    }
    
    public void testStrictNotStrict()
    {
        DateFormat df=  new DateFormat("@d6.");
        DateFormat dfl=  new DateFormat("@d6.");
        df.setStrictMode();
        assertEquals("<#.<#.####",df.getPictureRepresentation());

        assertEquals(""+CDate.date(2,29,2008),dfl.deformat("29 2 2008"));
        assertFalse(dfl.isError());
        assertEquals(""+CDate.date(2,29,2008),df.deformat("29 2 2008"));
        assertFalse(df.isError());

        assertEquals(""+CDate.date(3,1,2008),dfl.deformat("30 2 2008"));
        assertFalse(dfl.isError());
        assertEquals("##################",df.deformat("30 2 2008"));
        assertTrue(df.isError());

        assertEquals(""+CDate.date(1,1,2009),dfl.deformat("32 12 2008"));
        assertFalse(dfl.isError());
        assertEquals("##################",df.deformat("32 12 2008"));
        assertTrue(df.isError());
    }
    
    public void testDefaultIntellidate()
    {
        DateFormat df=  new DateFormat("@d6.");
        assertEquals("<#.<#.####",df.getPictureRepresentation());

        assertEquals(""+CDate.date(11,12,2007),df.deformat("12 11 07"));
        assertEquals(""+CDate.date(11,12,2008),df.deformat("12 11 08"));
        assertEquals(""+CDate.date(11,12,2009),df.deformat("12 11 09"));
        assertEquals(""+CDate.date(11,12,1999),df.deformat("12 11 99"));
                
        // get current system year
        int year = Calendar.getInstance().get(Calendar.YEAR);
        int sy=year%100;
        //int sc=year-sy;
        
        assertEquals(""+CDate.date(11,12,year),df.deformat("12 11 "+sy));
        assertEquals(""+CDate.date(11,12,year+15),df.deformat("12 11 "+((sy+15)%100)));
        assertEquals(""+CDate.date(11,12,year+19),df.deformat("12 11 "+((sy+19)%100)));
        assertEquals(""+CDate.date(11,12,year+20),df.deformat("12 11 "+((sy+20)%100)));
        assertEquals(""+CDate.date(11,12,year-79),df.deformat("12 11 "+((sy+21)%100)));
        assertEquals(""+CDate.date(11,12,year-78),df.deformat("12 11 "+((sy+22)%100)));
    }
    
    public void testCustomFutureIntellidate()
    {
        DateFormat df=  new DateFormat("@d6.>10");
        assertEquals("<#.<#.####",df.getPictureRepresentation());

        // get current system year
        int year = Calendar.getInstance().get(Calendar.YEAR);
        int sy=year%100;
        //int sc=year-sy;
        
        assertEquals(""+CDate.date(11,12,year),df.deformat("12 11 "+sy));
        assertEquals(""+CDate.date(11,12,year+8),df.deformat("12 11 "+((sy+8)%100)));
        assertEquals(""+CDate.date(11,12,year+9),df.deformat("12 11 "+((sy+9)%100)));
        assertEquals(""+CDate.date(11,12,year+10),df.deformat("12 11 "+((sy+10)%100)));
        assertEquals(""+CDate.date(11,12,year-89),df.deformat("12 11 "+((sy+11)%100)));
        assertEquals(""+CDate.date(11,12,year-88),df.deformat("12 11 "+((sy+12)%100)));
        
    }

    public void testCustomPastIntellidate()
    {
        DateFormat df=  new DateFormat("@d6.<10");
        assertEquals("<#.<#.####",df.getPictureRepresentation());

        // get current system year
        int year = Calendar.getInstance().get(Calendar.YEAR);
        int sy=year%100;
        //int sc=year-sy;
        
        assertEquals(""+CDate.date(11,12,year),df.deformat("12 11 "+sy));
        assertEquals(""+CDate.date(11,12,year-8),df.deformat("12 11 "+((sy+100-8)%100)));
        assertEquals(""+CDate.date(11,12,year-9),df.deformat("12 11 "+((sy+100-9)%100)));
        assertEquals(""+CDate.date(11,12,year-10),df.deformat("12 11 "+((sy+100-10)%100)));
        assertEquals(""+CDate.date(11,12,year+89),df.deformat("12 11 "+((sy+100-11)%100)));
        assertEquals(""+CDate.date(11,12,year+88),df.deformat("12 11 "+((sy+100-12)%100)));
        
    }

    public void testCodedMonths()
    {
        DateFormat df = new DateFormat("@d6.");
        assertEquals("<#.<#.####",df.getPictureRepresentation());
            
        assertEquals(""+CDate.date(1,12,2007),df.deformat("12 j 2007"));
        assertEquals(""+CDate.date(2,12,2007),df.deformat("12 f 2007"));
        assertEquals(""+CDate.date(3,12,2007),df.deformat("12 mar 2007"));
        assertEquals(""+CDate.date(4,12,2007),df.deformat("12 ap 2007"));
        assertEquals(""+CDate.date(5,12,2007),df.deformat("12 may 2007"));
        assertEquals(""+CDate.date(6,12,2007),df.deformat("12 jun 2007"));
        assertEquals(""+CDate.date(7,12,2007),df.deformat("12 jul 2007"));
        assertEquals(""+CDate.date(8,12,2007),df.deformat("12 au 2007"));
        assertEquals(""+CDate.date(9,12,2007),df.deformat("12 s 2007"));
        assertEquals(""+CDate.date(10,12,2007),df.deformat("12 o 2007"));
        assertEquals(""+CDate.date(11,12,2007),df.deformat("12 n 2007"));
        assertEquals(""+CDate.date(12,12,2007),df.deformat("12 d 2007"));

        assertEquals(""+CDate.date(1,12,2007),df.deformat("12 jan 2007"));
        assertEquals(""+CDate.date(2,12,2007),df.deformat("12 feb 2007"));
        assertEquals(""+CDate.date(3,12,2007),df.deformat("12 mar 2007"));
        assertEquals(""+CDate.date(4,12,2007),df.deformat("12 apr 2007"));
        assertEquals(""+CDate.date(5,12,2007),df.deformat("12 may 2007"));
        assertEquals(""+CDate.date(6,12,2007),df.deformat("12 jun 2007"));
        assertEquals(""+CDate.date(7,12,2007),df.deformat("12 jul 2007"));
        assertEquals(""+CDate.date(8,12,2007),df.deformat("12 aug 2007"));
        assertEquals(""+CDate.date(9,12,2007),df.deformat("12 sep 2007"));
        assertEquals(""+CDate.date(10,12,2007),df.deformat("12 oct 2007"));
        assertEquals(""+CDate.date(11,12,2007),df.deformat("12 nov 2007"));
        assertEquals(""+CDate.date(12,12,2007),df.deformat("12 dec 2007"));

        assertEquals(""+CDate.date(1,12,2007),df.deformat("12 january 2007"));
        assertEquals(""+CDate.date(2,12,2007),df.deformat("12 febuary 2007"));
        assertEquals(""+CDate.date(3,12,2007),df.deformat("12 march 2007"));
        assertEquals(""+CDate.date(4,12,2007),df.deformat("12 april 2007"));
        assertEquals(""+CDate.date(5,12,2007),df.deformat("12 may 2007"));
        assertEquals(""+CDate.date(6,12,2007),df.deformat("12 june 2007"));
        assertEquals(""+CDate.date(7,12,2007),df.deformat("12 july 2007"));
        assertEquals(""+CDate.date(8,12,2007),df.deformat("12 august 2007"));
        assertEquals(""+CDate.date(9,12,2007),df.deformat("12 september 2007"));
        assertEquals(""+CDate.date(10,12,2007),df.deformat("12 october 2007"));
        assertEquals(""+CDate.date(11,12,2007),df.deformat("12 november 2007"));
        assertEquals(""+CDate.date(12,12,2007),df.deformat("12 december 2007"));
        
    }

    public void testEmpty()
    {
        DateFormat df = new DateFormat("@d6.");
        assertEquals("<#.<#.####",df.getPictureRepresentation());
        assertEquals("",df.deformat(""));
        assertEquals("",df.deformat("..."));
    }

    public void testUSStyle()
    {
        DateFormat df = new DateFormat("@d2.");
        assertEquals("<#.<#.####",df.getPictureRepresentation());

        assertEquals(""+CDate.date(11,12,2007),df.deformat("11 12 2007"));

        assertEquals(""+CDate.date(11,12,2007),df.deformat("Nov 12, 2007"));

        assertEquals(""+CDate.date(11,12,2007),df.deformat("12 Nov, 2007"));
    }
    
    
    public void testMachineStyle()
    {
        DateFormat df = new DateFormat("@d6.");
        assertEquals("<#.<#.####",df.getPictureRepresentation());
        assertEquals(""+CDate.date(11,12,2007),df.deformat("12112007"));
        assertEquals(""+CDate.date(11,12,2007),df.deformat("121107"));
        assertEquals(""+CDate.date(CDate.month(CDate.today()),12,CDate.year(CDate.today())),df.deformat("12"));
        assertEquals(""+CDate.date(CDate.month(CDate.today()),9,CDate.year(CDate.today())),df.deformat("9"));
        
        df = new DateFormat("@d2.");
        assertEquals("<#.<#.####",df.getPictureRepresentation());
        assertEquals(""+CDate.date(11,12,2007),df.deformat("11122007"));
        assertEquals(""+CDate.date(11,12,2007),df.deformat("111207"));
        
        df = new DateFormat("@d13");
        assertEquals("<#/##",df.getPictureRepresentation());
        assertEquals(""+CDate.date(11,1,2007),df.deformat("112007"));
        assertEquals(""+CDate.date(11,1,2007),df.deformat("1107"));

        df = new DateFormat("@d15");
        assertEquals("##/<#",df.getPictureRepresentation());
        assertEquals(""+CDate.date(11,1,2007),df.deformat("200711"));
        assertEquals(""+CDate.date(11,1,2007),df.deformat("0711"));
    }
    
    public void testFormat()
    {
        String date = CDate.date(2,27,2009)+"";
        
        doTestFormat("2/27/09","<#/<#/##","@d1",date);
        doTestFormat("2-27-2009","<#-<#-####","@d2-",date);
        doTestFormat("Feb 27, 2009","### <#, ####","@d3-",date);
        doTestFormat("February 27, 2009","######### <#, ####","@d4-",date);
        
        doTestFormat("27 2 09","<# <# ##","@d5_",date);
        doTestFormat("27.2.2009","<#.<#.####","@d6.",date);
        doTestFormat("27.2.2009","<#.<#.####","@d6.",date);
        doTestFormat("27 Feb 09","<# ### ##","@d7-",date);
        doTestFormat("27 Feb 2009","<# ### ####","@d8-",date);
        
        doTestFormat("09 2 27","## <# <#","@d9_",date);
        doTestFormat("2009-2-27","####-<#-<#","@d10-",date);

        doTestFormat("090227","######","@d11",date);
        doTestFormat("20090227","########","@d12",date);

        doTestFormat("2/09","<#/##","@d13",date);
        doTestFormat("2/2009","<#/####","@d14",date);

        doTestFormat("09/2","##/<#","@d15",date);
        doTestFormat("2009/2","####/<#","@d16",date);
    }

    public void testBlankModes()
    {
        String date = CDate.date(2,27,2009)+"";
        doTestFormat("27.2.2009","<#.<#.####","@d6.",date);
        doTestFormat("27.2.2009","<#.<#.####","@d6.b",date);
        doTestFormat("27.2.2009","<#.<#.####","@D6.B",date);
        doTestFormat(". . .","<#.<#.####","@D6.","");
        doTestFormat(". . .","<#.<#.####","@D6.","");
        doTestFormat("","<#.<#.####","@D6.b","0");
        doTestFormat("","<#.<#.####","@D6.b","0");
        doTestFormat("##################","<#.<#.####","@D6.b","1");
        doTestFormat("##################","<#.<#.####","@D6.b","1");
    }

    public void testPadding()
    {
        doTestFormat("27.2.2009","<#.<#.####","@d6.",CDate.date(2,27,2009)+"");
        doTestFormat("27.02.2009","##.##.####","@d06.",CDate.date(2,27,2009)+"");
        doTestFormat("3.12.2009","<#.<#.####","@d6.",CDate.date(12,3,2009)+"");
        doTestFormat("03.12.2009","##.##.####","@d06.",CDate.date(12,3,2009)+"");
        doTestFormat("3.2.2009","<#.<#.####","@d6.",CDate.date(2,3,2009)+"");
        doTestFormat("03.02.2009","##.##.####","@d06.",CDate.date(2,3,2009)+"");
    }
    
    private void doTestFormat(String result,String rep,String picture,String value)
    {
        DateFormat df = new DateFormat(picture);
        assertEquals(result,df.format(value));
        assertEquals(rep,df.getPictureRepresentation());
    }

}
