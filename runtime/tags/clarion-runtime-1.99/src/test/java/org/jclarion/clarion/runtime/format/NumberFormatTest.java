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

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;

import junit.framework.TestCase;

public class NumberFormatTest extends TestCase {

    public void testOverlappingPos()
    {
        NumberFormat nf = new NumberFormat("@n$-11.2");
        assertEquals("0",nf.deformat("-"));
        assertEquals("0",nf.deformat("+"));
        
    }
    
    public void testNegDecimal()
    {
        NumberFormat nf = new NumberFormat("@n$-11.2");
        nf.setStrictMode();
        assertEquals("    $-67.20",nf.format("-67.2"));
        assertEquals("-67.2",nf.deformat("-67.2"));
        assertEquals("    $-67.20",nf.format("-67.200000000000"));
    }
    
    public void testDecimalPostCalcFormat()
    {
        ClarionDecimal invtotal = new ClarionDecimal(7,2);
        ClarionDecimal gst = new ClarionDecimal(5,2);
        
        invtotal.setValue("172.65");
        gst.setValue("10.00");
        assertEquals("      $15.70",invtotal.subtract(invtotal.multiply(100).divide(Clarion.newNumber(100).add(gst))).getString().format("@n$12.2").toString());
    }
    
    public void testSimpleNumber()
    {
        NumberFormat nf = new NumberFormat("@n7");

        assertEquals("<<<,<<#",nf.getPictureRepresentation());
        
        assertEquals("1000",nf.deformat("01000"));
        
        assertEquals("1000",nf.deformat("1000"));
        assertEquals("1000",nf.deformat("1000.00"));
        assertEquals("1000",nf.deformat("1000"));
        assertEquals("1000",nf.deformat("   1,000   "));
        assertEquals("-1000",nf.deformat("   (1,000)   "));
        assertEquals("-1000",nf.deformat("   -1,000   "));
        assertEquals("-1000",nf.deformat("   -1000  "));
        assertEquals("-1000",nf.deformat("   -1,000-   "));
        assertEquals("0",nf.deformat(""));
        assertEquals("#######",nf.deformat("1000.23"));
        
        assertEquals("  1,000",nf.format("  1,000  "));
        assertEquals("  1,000",nf.format("  1000  "));
        assertEquals("  1,000",nf.format("  -1000  "));
        assertEquals(" 12,345",nf.format("  (12345)  "));
        assertEquals("123,456",nf.format("  (123456)  "));

        assertEquals("  1,000",nf.format("  1000.00  "));
    }
    
    public void testNumberWithNullableGroup()
    {
        NumberFormat nf = new NumberFormat("@n8");
        assertEquals("<<<<,<<#",nf.getPictureRepresentation());
        
        assertEquals(" 123,456",nf.format("  (123456)  "));
        assertEquals("7123,456",nf.format("  (7123456)  "));
        assertEquals("7123,456",nf.format("  (007123456)  "));
        assertEquals("########",nf.format("  (71234560)  "));
    }

    public void testEuroFormatsFromSourceForgeComment4867236()
    {
        NumberFormat nf = new NumberFormat("@n-10`2");

    	// message(deformat('1.234,56',@n-10`2)) returns correctly 1234.56 
        assertEquals("1234.56",nf.deformat("1.234,56"));
        
        
    	// message(deformat(deformat('1.234,56',@n-10`2),@n-10`2)) returns INCORRECTLY 123456
        assertEquals("123456",nf.deformat("1234.56"));
        
    	//Follows what i have found in clarion test app: 
    	//message(':' & deformat('1.234,56',@n-10`2) & ':') returns :12345.:
        assertEquals("1234.56",nf.deformat("1.234,56"));
        
    	// Adding one leading space: 
    	// message(':' & deformat(' 1.234,56',@n-10`2) & ':') returns :1234.6:
        assertEquals("1234.56",nf.deformat(" 1.234,56"));

    	// Adding one more leading space: 
    	//message(':' & deformat(' 1.234,56',@n-10`2) & ':') returns :01234.56: 
        assertEquals("1234.56",nf.deformat("  1.234,56"));
        assertEquals("123456",nf.deformat("01234.56"));
        
    	//So now it is debatable if the other cases are bugs or not because clarion does: 
    	//message(':' & format('1234.56',@n-10`2) & ':') returns : 1.234,56: 
    	//message(':' & format('-1234.56',@n-10`2) & ':') returns : -1.234,56:
        assertEquals("  1.234,56",nf.format("1234.56"));
        assertEquals(" -1.234,56",nf.format("-1234.56"));
    		
        
    	 
    	//If instead i use pictures for LONG things are better:
        nf = new NumberFormat("@n-10");
        
    	//message(':' & format(123456,@n-10) & ':') returns : 123,456:
        assertEquals("   123,456",nf.format("123456"));        
        
    	//message(':' & deformat('123456',@n-10) & ':') returns :123456: 
        assertEquals("123456",nf.deformat("123456"));
        
    	//message(':' & deformat(' 123456',@n-10) & ':') returns :123456: 
        assertEquals("123456",nf.deformat(" 123456"));
        
    	//message(':' & deformat(' 123,456',@n-10) & ':') returns :123456: 
        assertEquals("123456",nf.deformat(" 123,456"));
    }
    
    public void testNumberWithOneBiggerThanNullableGroup()
    {
        NumberFormat nf = new NumberFormat("@n9");
        assertEquals("<,<<<,<<#",nf.getPictureRepresentation());
        
        assertEquals("  123,456",nf.format("  (123456)  "));
        assertEquals("7,123,456",nf.format("  (7123456)  "));
        assertEquals("7,123,456",nf.format("  (07123456)  "));
        assertFalse(nf.isError());
        assertEquals("#########",nf.format("  (57123456)  "));
        assertTrue(nf.isError());
    }

    public void testSimpleDecimal()
    {
        NumberFormat nf = new NumberFormat("@n9.2");
        assertEquals("<<,<<#.##",nf.getPictureRepresentation());
        
        assertEquals("-123.456",nf.deformat("   -1,2,3.456   "));
        assertEquals("0",nf.deformat(""));
        assertEquals("0",nf.deformat("0"));
        assertEquals("0",nf.deformat("0.0"));
        assertEquals("0",nf.deformat("0."));
        assertEquals("0",nf.deformat(".0"));

        assertEquals("   123.46",nf.format("   -1,2,3.456   "));
        assertEquals("   123.45",nf.format("   -1,2,3.45   "));
        assertEquals("13,456.45",nf.format("   (13456.45)"));

        assertEquals("     0.00",nf.format("0.0"));
        assertEquals("     0.00",nf.format(".0"));
    }

    public void testLeadingMinus()
    {
        NumberFormat nf = new NumberFormat("@n-9.2");
        assertEquals("-<,<<#.##",nf.getPictureRepresentation());
        
        assertEquals("-123.456",nf.deformat("   -1,2,3.456   "));

        assertEquals("  -123.46",nf.format("   -1,2,3.456   "));
        assertEquals("  -123.46",nf.format("   -1,2,3.456   "));
        assertEquals("  -123.45",nf.format("   -1,2,3.45   "));
        assertEquals("   123.45",nf.format("    1,2,3.45   "));
        assertEquals("#########",nf.format("   (13456.45)"));
        assertEquals("13,456.45",nf.format("   13456.45 "));
        assertEquals("-3,456.45",nf.format("   (03456.45)"));
    }

    public void testLeadingMinusStrict()
    {
        NumberFormat nf = new NumberFormat("@n-9.2");
        nf.setStrictMode();
        assertEquals("#########",nf.format("   -1,2,3.456   "));
        assertEquals("#########",nf.format("   -1,2,3.456   "));
    }

    public void testLeadingPlus()
    {
        NumberFormat nf = new NumberFormat("@n+9.2");
        assertEquals("-<,<<#.##",nf.getPictureRepresentation());
        
        assertEquals("-123.456",nf.deformat("   -1,2,3.456   "));
        assertEquals("123.456",nf.deformat("   +1,2,3.456   "));

        assertEquals("  -123.46",nf.format("   -1,2,3.456   "));
        assertEquals("  +123.46",nf.format("   1,2,3.456   "));
        assertEquals("  -123.45",nf.format("   -1,2,3.45   "));
        assertEquals("  +123.45",nf.format("   1,2,3.45   "));
        assertEquals("#########",nf.format("   (13456.45)"));
        assertEquals("#########",nf.format("   13456.45"));
        assertEquals("-3,456.45",nf.format("   (03456.45)"));
        assertEquals("+3,456.45",nf.format("   03456.45"));
    }
    
    
    public void testTrailingMinus()
    {
        NumberFormat nf = new NumberFormat("@n9.2-");
        assertEquals("<,<<#.##-",nf.getPictureRepresentation());
        
        assertEquals("-123.456",nf.deformat("   -1,2,3.456   "));

        assertEquals("  123.46-",nf.format("   -1,2,3.456   "));
        assertEquals("  123.45-",nf.format("   -1,2,3.45   "));
        assertEquals("#########",nf.format("   (13456.45)"));
        assertEquals("3,456.45-",nf.format("   (03456.45)"));
    }

    public void testTrailingPlus()
    {
        NumberFormat nf = new NumberFormat("@n9.2+");
        assertEquals("<,<<#.##-",nf.getPictureRepresentation());
        
        assertEquals("-123.456",nf.deformat("   -1,2,3.456   "));
        assertEquals("123.456",nf.deformat("   +1,2,3.456   "));

        assertEquals("  123.46-",nf.format("   -1,2,3.456   "));
        assertEquals("  123.46+",nf.format("   1,2,3.456   "));
        assertEquals("  123.45-",nf.format("   -1,2,3.45   "));
        assertEquals("  123.45+",nf.format("   1,2,3.45   "));
        assertEquals("#########",nf.format("   (13456.45)"));
        assertEquals("#########",nf.format("   13456.45"));
        assertEquals("3,456.45-",nf.format("   (03456.45)"));
        assertEquals("3,456.45+",nf.format("   03456.45"));
    }

    public void testSpacePadding()
    {
        NumberFormat nf = new NumberFormat("@n-_10.2");
        assertEquals("-<<<<<#.##",nf.getPictureRepresentation());
        
        assertEquals("    123.45",nf.format("   123.45   "));
        assertEquals("-   123.45",nf.format("   -123.45   "));
        assertEquals("-123765.45",nf.format("   -123765.45   "));
        assertEquals("9123765.45",nf.format("   9123765.45   "));
        assertEquals("##########",nf.format("   -9123765.45   "));
    }
    
    public void testZeroPadding()
    {
        NumberFormat nf = new NumberFormat("@n-010.2");
        assertEquals("-<<<<<#.##",nf.getPictureRepresentation());
        
        assertEquals("0000123.45",nf.format("   123.45   "));
        assertEquals("-000123.45",nf.format("   -123.45   "));
        assertEquals("-123765.45",nf.format("   -123765.45   "));
        assertEquals("9123765.45",nf.format("   9123765.45   "));
        assertEquals("##########",nf.format("   -9123765.45   "));
    }

    public void testAstPadding()
    {
        NumberFormat nf = new NumberFormat("@n-*10.2");
        assertEquals("-<<<<<#.##",nf.getPictureRepresentation());
        
        assertEquals("****123.45",nf.format("   123.45   "));
        assertEquals("-***123.45",nf.format("   -123.45   "));
        assertEquals("-123765.45",nf.format("   -123765.45   "));
        assertEquals("9123765.45",nf.format("   9123765.45   "));
        assertEquals("##########",nf.format("   -9123765.45   "));
    }

    public void testPaddingAndGroup()
    {
        NumberFormat nf = new NumberFormat("@n-*10..2");
        assertEquals("-<<.<<#.##",nf.getPictureRepresentation());
        
        assertEquals("***.123.45",nf.format("   123.45   "));
        assertEquals("-**.123.45",nf.format("   -123.45   "));
        assertEquals("##########",nf.format("   -123765.45   "));
        assertEquals("##########",nf.format("   9123765.45   "));
        assertEquals("##########",nf.format("   -9123765.45   "));
    }

    public void testPaddingAndGroupSpecialLength()
    {
        NumberFormat nf = new NumberFormat("@n-*11..2");
        assertEquals("-<<<.<<#.##",nf.getPictureRepresentation());
        
        assertEquals("****.123.45",nf.format("   123.45   "));
        assertEquals("-***.123.45",nf.format("   -123.45   "));

        assertEquals("*555.123.45",nf.format("   555123.45   "));
        assertEquals("-555.123.45",nf.format("   -555123.45   "));

        assertEquals("2555.123.45",nf.format("   2555123.45   "));
        assertEquals("###########",nf.format("   -2555123.45   "));

        assertEquals("2555.123.45",nf.format("   2.55.51.23.45   "));
        assertEquals("###########",nf.format("   -2.555.12.3.45   "));
    }

    public void testPaddingAndGroupSpecialLengthP1()
    {
        NumberFormat nf = new NumberFormat("@n-*12..2");
        assertEquals("-<<<<.<<#.##",nf.getPictureRepresentation());
        
        assertEquals("*.***.123.45",nf.format("   123.45   "));
        assertEquals("-****.123.45",nf.format("   -123.45   "));

        assertEquals("*.555.123.45",nf.format("   555123.45   "));
        assertEquals("-*555.123.45",nf.format("   -555123.45   "));

        assertEquals("2.555.123.45",nf.format("   2555123.45   "));
        assertEquals("-2555.123.45",nf.format("   -2555123.45   "));

        assertEquals("2.555.123.45",nf.format("   2.55.51.23.45   "));
        assertEquals("-2555.123.45",nf.format("   -2.555.12.3.45   "));
    }

    public void testGroup()
    {
        NumberFormat nf = new NumberFormat("@n-12..2");
        assertEquals("-<<<<.<<#.##",nf.getPictureRepresentation());
        assertEquals("      123.45",nf.format("   123.45   "));
        assertEquals("     -123.45",nf.format("   -123.45   "));
        assertEquals("    9.123.45",nf.format("   9123.45   "));
        assertEquals("   -9.123.45",nf.format("   -9123.45   "));
        assertEquals("5.679.123.45",nf.format("   5.6..79.123.45   "));
        assertEquals("-5679.123.45",nf.format("   -5.6..79.123.45   "));
    }
    
    public void testGroupHythen()
    {
        NumberFormat nf = new NumberFormat("@n-12-.2");
        assertEquals("-<<<<-<<#.##",nf.getPictureRepresentation());
        assertEquals("      123.45",nf.format("   123.45   "));
        assertEquals("     -123.45",nf.format("   -123.45   "));
        assertEquals("    9-123.45",nf.format("   9123.45   "));
        assertEquals("   -9-123.45",nf.format("   -9123.45   "));
        assertEquals("5-679-123.45",nf.format("   5-6--79-123.45   "));
        assertEquals("-5679-123.45",nf.format(" -5-6--79-123.45   "));
    }

    public void testGroupSpace()
    {
        NumberFormat nf = new NumberFormat("@n-12_.2");
        assertEquals("-<<<< <<#.##",nf.getPictureRepresentation());
        assertEquals("      123.45",nf.format("   123.45   "));
        assertEquals("     -123.45",nf.format("   -123.45   "));
        assertEquals("    9 123.45",nf.format("   9123.45   "));
        assertEquals("   -9 123.45",nf.format("   -9123.45   "));
        assertEquals("5 679 123.45",nf.format("   5 6  79 123.45   "));
        assertEquals("-5679 123.45",nf.format(" -5 6  79 123.45   "));
    }
    
    public void testDecimalSeparatorComma()
    {
        NumberFormat nf = new NumberFormat("@n-12'2");
        assertEquals("-<<<<.<<#,##",nf.getPictureRepresentation());
        assertEquals("123.45",nf.deformat("123,45"));
        assertEquals("123.45",nf.deformat("1.23,45"));
        assertEquals("123",nf.deformat("123"));
        assertEquals("12345",nf.deformat("123.45"));
        
        assertEquals("      123,45",nf.format("   123.45   "));
        assertEquals("      123,45",nf.format("   123,45   "));
        assertEquals("     -123,45",nf.format("   -123,45   "));
        assertEquals("    9.123,45",nf.format("   9123,45   "));
        assertEquals("   -9.123,45",nf.format("   -9123,45   "));
        assertEquals("5.679.123,45",nf.format("   5.6..79.123,45   "));
        assertEquals("-5679.123,45",nf.format(" -5.6..79.123,45   "));
    }

    public void testDecimalSeparatorGraveAccent()
    {
        NumberFormat nf = new NumberFormat("@n-12`2");
        assertEquals("-<<<<.<<#,##",nf.getPictureRepresentation());
        assertEquals("123.45",nf.deformat("123,45"));
        assertEquals("############",nf.deformat("1,23,45"));
        assertEquals("123.45",nf.deformat("1.23,45"));
        assertEquals("123",nf.deformat("123"));
        assertEquals("12345",nf.deformat("123.45"));
        
        assertEquals("      123,45",nf.format("   123.45   "));
        assertEquals("      123,45",nf.format("   123,45   "));
        assertEquals("     -123,45",nf.format("   -123,45   "));
        assertEquals("    9.123,45",nf.format("   9123,45   "));
        assertEquals("   -9.123,45",nf.format("   -9123,45   "));
        assertEquals("5.679.123,45",nf.format("   5.6..79.123,45   "));
        assertEquals("-5679.123,45",nf.format(" -5.6..79.123,45   "));
    }

    public void testDecimalSeparatorGraveAccentExplicitGroup()
    {
        NumberFormat nf = new NumberFormat("@n-12-`2");
        assertEquals("-<<<<-<<#,##",nf.getPictureRepresentation());
        assertEquals("123.45",nf.deformat("123,45"));
        assertEquals("123.45",nf.deformat("1-23,45"));
        assertEquals("123",nf.deformat("123"));
        assertEquals("############",nf.deformat("123.45"));
        
        assertEquals("      123,45",nf.format("   123.45   "));
        assertEquals("      123,45",nf.format("   123,45   "));
        assertEquals("     -123,45",nf.format("   -123,45   "));
        assertEquals("    9-123,45",nf.format("   9123,45   "));
        assertEquals("   -9-123,45",nf.format("   -9123,45   "));
        assertEquals("5-679-123,45",nf.format("   5-6--79-123,45   "));
        assertEquals("-5679-123,45",nf.format(" -5-6--79-123,45   "));
    }
    
    public void testDecimalSeparatorNone()
    {
        NumberFormat nf = new NumberFormat("@n-12v2");
        assertEquals("-<,<<<,<<###",nf.getPictureRepresentation());
        assertEquals("123.45",nf.deformat("123,45"));
        assertEquals("123.45",nf.deformat("1,23,45"));
        assertEquals("1.23",nf.deformat("123"));
        assertEquals("0.12",nf.deformat("12"));
        assertEquals("0.01",nf.deformat("1"));
        assertEquals("0.00",nf.deformat("0"));
        assertEquals("0.00",nf.deformat(""));
        assertEquals("12.3",nf.deformat("12.3"));

        assertEquals("       12345",nf.format("   123,45   "));
        assertEquals("      -12345",nf.format("   -123,45   "));
        assertEquals("     9,12345",nf.format("   9123,45   "));
        assertEquals("    -9,12345",nf.format("   -9123,45   "));
        assertEquals(" 5,679,12345",nf.format("   5,6,,79,123,45   "));
        assertEquals("-5,679,12345",nf.format(" -5,6,,79,123,45   "));
    }

    public void testLeadingCurrency()
    {
        NumberFormat nf = new NumberFormat("@n$-12.2");
        assertEquals("$-<<<,<<#.##",nf.getPictureRepresentation());
        assertEquals("12345.6",nf.deformat("  123,45.6"));
        assertEquals("12345.7",nf.deformat("  $123,45.7"));

        assertEquals(" $123,456.12",nf.format("   $1234,56.12   "));
        assertEquals("$6123,456.12",nf.format("   $061234,56.12   "));
        assertEquals("$-123,456.12",nf.format("   $(1234,56.12)   "));
        assertEquals("############",nf.format("   $(61234,56.12)   "));
    }
    
    public void testLeadingCurrencyOther()
    {
        NumberFormat nf = new NumberFormat("@n~K ~-13.2");
        assertEquals("K -<<<,<<#.##",nf.getPictureRepresentation());
        assertEquals("12345.6",nf.deformat("  123,45.6"));
        assertEquals("12345.7",nf.deformat("  K 123,45.7"));

        assertEquals(" K 123,456.12",nf.format("   K 1234,56.12   "));
        assertEquals("K 6123,456.12",nf.format("   K 061234,56.12   "));
        assertEquals("K -123,456.12",nf.format("   K (1234,56.12)   "));
        assertEquals("#############",nf.format("   K (61234,56.12)   "));
    }    

    public void testTrailingCurrency()
    {
        NumberFormat nf = new NumberFormat("@n-12.2$");
        assertEquals("-<<<,<<#.##$",nf.getPictureRepresentation());
        assertEquals("12345.6",nf.deformat("  123,45.6   "));
        assertEquals("12345.7",nf.deformat("  123,45.7$  "));
        assertEquals("12345.6",nf.deformat("123,45.6"));
        assertEquals("12345.7",nf.deformat("123,45.7$"));

        assertEquals(" 123,456.12$",nf.format("   1234,56.12$   "));
        assertEquals("6123,456.12$",nf.format("   061234,56.12$   "));
        assertEquals("-123,456.12$",nf.format("   (1234,56.12)   "));
        assertEquals("############",nf.format("   (61234,56.12)$   "));
    }

    public void testTrailingCurrencyCustom()
    {
        NumberFormat nf = new NumberFormat("@n-14.2~PHP~");
        assertEquals("-<<<,<<#.##PHP",nf.getPictureRepresentation());
        assertEquals("12345.6",nf.deformat("  123,45.6   "));
        assertEquals("12345.7",nf.deformat("  123,45.7PHP  "));
        assertEquals("12345.6",nf.deformat("123,45.6"));
        assertEquals("12345.7",nf.deformat("123,45.7PHP"));

        assertEquals(" 123,456.12PHP",nf.format("   1234,56.12PHP   "));
        assertEquals("6123,456.12PHP",nf.format("   061234,56.12PHP   "));
        assertEquals("-123,456.12PHP",nf.format("   (1234,56.12)   "));
        assertEquals("##############",nf.format("   (61234,56.12)PHP   "));
    }

    public void testBlank()
    {
        NumberFormat nf = new NumberFormat("@N$-10.2b");
        assertEquals("$-<,<<#.##",nf.getPictureRepresentation());

        assertEquals("0",nf.deformat("0.00"));
        assertEquals("0",nf.deformat("-0.00"));
        assertEquals("-0.01",nf.deformat("-0.01"));
        
        assertEquals("          ",nf.format("0"));
        assertEquals("          ",nf.format("0.00"));
        assertEquals("          ",nf.format("-0.00"));
        assertEquals("["+nf.format("-0.01")+"]","    $-0.01",nf.format("-0.01"));
    }
    
    public void testStrictNegative()
    {
        NumberFormat nf = new NumberFormat("@N$10.2");
        assertEquals("$<<,<<#.##",nf.getPictureRepresentation());

        assertEquals("    $12.30",nf.format("-12.3"));
        assertEquals("    $12.30",nf.format("12.3"));
        nf.setStrictMode();
        assertEquals("##########",nf.format("-12.3"));
        assertEquals("    $12.30",nf.format("12.3"));
    }
    
}
