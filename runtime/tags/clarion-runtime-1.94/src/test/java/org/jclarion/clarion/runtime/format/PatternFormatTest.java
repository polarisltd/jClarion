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

public class PatternFormatTest extends TestCase {

    public void testUsingLongString()
    {
        PatternFormat pf = new PatternFormat("@P##P");
        assertEquals("00",pf.format("          "));
        assertEquals("00",pf.format("0         "));
        assertEquals("01",pf.format("1         "));
        assertEquals("04",pf.format("4         "));
        assertEquals("16",pf.format("16        "));
        assertEquals("16",pf.format(" 16       "));
        assertEquals("16",pf.format("016       "));
        assertEquals("##",pf.format("100       "));
    }

    public void testAdvanced()
    {
        PatternFormat pf = new PatternFormat("@P##-##PB");
        assertEquals("43",pf.deformat("43"));
        assertEquals("00-43",pf.format("43"));
        assertEquals("43",pf.deformat("-43"));
        assertEquals("103",pf.deformat("1-3"));

        assertEquals("400",pf.deformat("400"));
        assertFalse(pf.isError());
        
        assertEquals("5000",pf.deformat("5000"));
        assertFalse(pf.isError());
        
        assertEquals("",pf.deformat("50000"));
        assertTrue(pf.isError());
        
        assertEquals("4300",pf.deformat("43-0"));
        assertEquals("4300",pf.deformat("43-"));
        assertEquals("43-00",pf.format("4300"));
        assertEquals("04-30",pf.format("430"));
    }
    
    public void testWithB()
    {
        PatternFormat pf = new PatternFormat("@P##PB");
        assertEquals("",pf.format("          "));
        assertEquals("",pf.format("0         "));
        assertEquals("01",pf.format("1         "));
        assertEquals("04",pf.format("4         "));
        assertEquals("16",pf.format("16        "));
        assertEquals("16",pf.format(" 16       "));
        assertEquals("16",pf.format("016       "));
        assertEquals("##",pf.format("100       "));
        
        assertEquals(2,pf.getMaxLen());
    }
    
    public void testDeformatSimple()
    {
        PatternFormat pf = new PatternFormat("@P<<<<<#P");
        assertEquals("123456",pf.deformat("123456"));
        assertEquals("12345",pf.deformat("12345"));
        assertEquals("12",pf.deformat("12"));
        assertFalse(pf.isError());
        assertEquals("",pf.deformat("1234567"));
        assertTrue(pf.isError());
    }

    public void testDeformatComplex()
    {
        assertDeformat("0","@P<<<<<<<<#P","0");
        assertDeformat("10","@P<<<<<<<<#P","0010");
        assertDeformat("123456","@P<<<<<#P","123456");
        assertDeformat("123456","@P<<<-<<#P","123-456");
        assertDeformat("123456","@P<<<-<<#P","123456");
        assertDeformat("123456","@P<<<-<<#P","123-456");
        assertDeformat("1006","@P<<<-<<#P","1-6");
        assertDeformat("1006","@P<<<-<<#P","1- 6");
        assertDeformat("1006","@P<<<-<<#P","   1- 6");
        assertDeformat("1006","@P<<<-<<#P","   1-  6");
        assertDeformat("1016","@P<<<-<<#P","   1- 16");
        assertDeformat("16","@P<<<-<<#P","16");
        assertDeformat("16","@P<<<-<<#P","-16");
        assertDeformat("1234","@P<<<-<<#P","1-234");
        assertDeformat(null,"@P<<<-<<#P","1x234");
        assertDeformat("506","@P<#' <#\"P","5' 06\"");
        assertDeformat("506","@P<#' <#\"P","5' 6\"");
        assertDeformat("504","@P<#lb. <#oz.P","5lb. 4oz.");
        assertDeformat("504","@P<#lb. <#oz.P","504");
    }

    public void testDeformatVeryComplex()
    {
        assertDeformat("23456","@P<<<5<#P","23456");
        assertDeformat("23466","@P<<<5<#P","23466");
    }

    public void testFormat()
    {
        assertFormat("        0","@P<<<<<<<<#P","0");
        assertFormat("       00","@P<<<<<<<##P","0");
        assertFormat("       00","@P<<<<<<<##P","00");
        assertFormat("       03","@P<<<<<<<##P","3");
        assertFormat("       10","@P<<<<<<<<#P","10");
        assertFormat(" 5lb.  4oz.","@P<#lb. <#oz.P","504");
        assertFormat(" 5lb. 34oz.","@P<#lb. <#oz.P","534");
        assertFormat("      10023","@p<<<<<<<<<<#p","10023");
    }
    
    private void assertDeformat(String result, String pattern, String input) {
        PatternFormat pf = new PatternFormat(pattern);
        String r =pf.deformat(input);
        if (result==null) {
            assertEquals("",r);
            assertTrue(pf.isError());
        } else {
            assertEquals(r,result,r);
            assertFalse(pf.isError());
        }
        
    }
    
    private void assertFormat(String result, String pattern, String input) {
        PatternFormat pf = new PatternFormat(pattern);
        String r =pf.format(input);
        assertEquals(r,result,r);
        assertEquals(pattern.substring(2,pattern.length()-1),pf.getPictureRepresentation());
    }    
}
