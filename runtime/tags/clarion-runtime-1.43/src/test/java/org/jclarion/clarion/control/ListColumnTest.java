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
package org.jclarion.clarion.control;

import org.jclarion.clarion.control.ListColumn.Justify;

import junit.framework.TestCase;



public class ListColumnTest extends TestCase {

    public void testStyledOffset()
    {
        ListColumn[] r = ListColumn.construct("20LY@s10@Z(1)30LY@s20@");
        assertEquals(2,r.length);
        assertEquals(1,r[0].getFieldNumber());
        assertEquals(3,r[1].getFieldNumber());
    }
    
    public void testStyledOffset2()
    {
        ListColumn[] r = ListColumn.construct("20L@s10@Z(1)30LY@s20@");
        assertEquals(2,r.length);
        assertEquals(1,r[0].getFieldNumber());
        assertEquals(2,r[1].getFieldNumber());
    }

    public void testStyledOffset3()
    {
        ListColumn[] r = ListColumn.construct("20LJ@s10@Z(1)30LY@s20@");
        assertEquals(2,r.length);
        assertEquals(1,r[0].getFieldNumber());
        assertEquals(3,r[1].getFieldNumber());
    }
    
    public void testBrokenPattern()
    {
        ListColumn[] r = ListColumn.construct(
                "0|M~Code~@25L(2)|M~Name~L(2)@s5@20L(2)|M~~L(2)@s1@#41#");
        assertEquals(3,r.length);
        
        assertNull(r[0].getPicture());
        assertEquals(0,r[0].getWidth());
        assertEquals("Code",r[0].getHeader());
        
        assertNotNull(r[1].getPicture());
        assertEquals(25,r[1].getWidth());
        assertEquals("Name",r[1].getHeader());

        assertNotNull(r[2].getPicture());
    }
    
    public void testDecimal()
    {
        ListColumn[] r = ListColumn.construct(
                "51D(14)|M*~Total~L(2)@n$10.2@");
        assertEquals(1,r.length);

        assertNull(r[0].getChildren());
        assertEquals(0,r[0].getColumnScroll());
        assertEquals(0,r[0].getDefaultStyle());
        assertEquals(1,r[0].getFieldNumber());
        assertEquals("Total",r[0].getHeader());
        assertEquals(2,r[0].getHeaderIndent());
        assertEquals(Justify.LEFT,r[0].getHeaderJustification());
        assertEquals(14,r[0].getIndent());
        assertEquals(Justify.DECIMAL,r[0].getJustification());
        assertEquals(" $1,234.56",r[0].getPicture().format("1234.56"));
        assertEquals(0,r[0].getTreeRootOffset());
        assertEquals(51,r[0].getWidth());
        assertTrue(r[0].isColor());
        assertFalse(r[0].isColumnFixed());
        assertFalse(r[0].isIcon());
        assertFalse(r[0].isLastOnLine());
        assertFalse(r[0].isLocator());
        assertTrue(r[0].isResizable());
        assertFalse(r[0].isStyle());
        assertFalse(r[0].isTransparantIcon());
        assertFalse(r[0].isTree());
        assertFalse(r[0].isTreeBoxes());
        assertFalse(r[0].isTreeIndent());
        assertFalse(r[0].isTreeLines());
        assertFalse(r[0].isTreeRootLines());
        assertFalse(r[0].isUnderline());
        assertTrue(r[0].isVerticalLine());
    }
    
    public void testComplex()
    {
        ListColumn[] r = ListColumn.construct(
                "13L(2)J@s1@Z(1)14L(2)J@s1@Z(1)78L|Y~Part Number~@s20@107L(2)|Y~Description~@s35@"+
                "Z(1)27L(2)|Y~Loc~@s6@Z(1)24R(2)|Y~Stk~@P<<<<<<<<#P@Z(1)24R(2)|Y~Ord~@s5@Z(1)24R(2)|Y"+
                "~Req~@P<<<<<<<<#P@Z(1)24R(2)|Y~Sup~@P<<<<<<<<#P@Z(1)20R(2)|Y~Price~@n$10.2@Z(1)");        

        assertEquals(10,r.length);
        
        assertEquals(13,r[0].getWidth());
        assertTrue(r[0].isLeft());
        assertEquals(2,r[0].getIndent());
        assertTrue(r[0].isTransparantIcon());
        assertEquals(" ",r[0].getPicture().format(""));
        assertEquals(1,r[0].getDefaultStyle());
    }
    
    public void testSimple()
    {
        ListColumn[] r = ListColumn.construct("20L(2)|M~F1~@s20@20L(2)|M~F2~@s20@20L(2)|M~F3~@n9@20L(2)|M~F4~@n$12.2@");
        
        assertEquals(4,r.length);
        
        assertEquals(20,r[0].getWidth());
        assertTrue(r[0].isLeft());
        assertFalse(r[0].isRight());
        assertFalse(r[0].isCenter());
        assertFalse(r[0].isDecimal());
        assertFalse(r[0].isDecimal());
        assertEquals(2,r[0].getIndent());
        assertTrue(r[0].isVerticalLine());
        assertTrue(r[0].isResizable());
        assertEquals("F1",r[0].getHeader());
        assertTrue(r[0].isHeaderLeft());
        assertEquals(0,r[0].getHeaderIndent());
        assertEquals("12345               ",r[0].getPicture().format("12345"));

        assertEquals("12345               ",r[1].getPicture().format("12345"));

        assertEquals("   12,345",r[2].getPicture().format("12345"));

        assertEquals("  $12,345.00",r[3].getPicture().format("12345"));
    }

    public void testComplex2()
    {
        ListColumn[] r = ListColumn.construct(
        "86L(2)|M*~Part Number~@s20@" +
        "127L(2)|M*~Description~@s30@" +
        "28R(2)|M*~QoH~L@s7@");
        
        assertEquals(3,r.length);
        
        assertNull(r[0].getChildren());
        assertEquals(0,r[0].getColumnScroll());
        assertEquals(0,r[0].getDefaultStyle());
        assertEquals(1,r[0].getFieldNumber());
        assertEquals("Part Number",r[0].getHeader());
        assertEquals(0,r[0].getHeaderIndent());
        assertEquals(Justify.LEFT,r[0].getHeaderJustification());
        assertEquals(2,r[0].getIndent());
        assertEquals(Justify.LEFT,r[0].getJustification());
        assertEquals("Crap                ",r[0].getPicture().format("Crap"));
        assertEquals(0,r[0].getTreeRootOffset());
        assertEquals(86,r[0].getWidth());
        assertTrue(r[0].isColor());
        assertFalse(r[0].isColumnFixed());
        assertFalse(r[0].isIcon());
        assertFalse(r[0].isLastOnLine());
        assertFalse(r[0].isLocator());
        assertTrue(r[0].isResizable());
        assertFalse(r[0].isStyle());
        assertFalse(r[0].isTransparantIcon());
        assertFalse(r[0].isTree());
        assertFalse(r[0].isTreeBoxes());
        assertFalse(r[0].isTreeIndent());
        assertFalse(r[0].isTreeLines());
        assertFalse(r[0].isTreeRootLines());
        assertFalse(r[0].isUnderline());
        assertTrue(r[0].isVerticalLine());

        assertNull(r[1].getChildren());
        assertEquals(0,r[1].getColumnScroll());
        assertEquals(0,r[1].getDefaultStyle());
        assertEquals(6,r[1].getFieldNumber());
        assertEquals("Description",r[1].getHeader());
        assertEquals(0,r[1].getHeaderIndent());
        assertEquals(Justify.LEFT,r[1].getHeaderJustification());
        assertEquals(2,r[1].getIndent());
        assertEquals(Justify.LEFT,r[1].getJustification());
        assertEquals("Crap                          ",r[1].getPicture().format("Crap"));
        assertEquals(0,r[1].getTreeRootOffset());
        assertEquals(127,r[1].getWidth());
        assertTrue(r[1].isColor());
        assertFalse(r[1].isColumnFixed());
        assertFalse(r[1].isIcon());
        assertFalse(r[1].isLastOnLine());
        assertFalse(r[1].isLocator());
        assertTrue(r[1].isResizable());
        assertFalse(r[1].isStyle());
        assertFalse(r[1].isTransparantIcon());
        assertFalse(r[1].isTree());
        assertFalse(r[1].isTreeBoxes());
        assertFalse(r[1].isTreeIndent());
        assertFalse(r[1].isTreeLines());
        assertFalse(r[1].isTreeRootLines());
        assertFalse(r[1].isUnderline());
        assertTrue(r[1].isVerticalLine());

        assertNull(r[2].getChildren());
        assertEquals(0,r[2].getColumnScroll());
        assertEquals(0,r[2].getDefaultStyle());
        assertEquals(11,r[2].getFieldNumber());
        assertEquals("QoH",r[2].getHeader());
        assertEquals(0,r[2].getHeaderIndent());
        assertEquals(Justify.LEFT,r[2].getHeaderJustification());
        assertEquals(2,r[2].getIndent());
        assertEquals(Justify.RIGHT,r[2].getJustification());
        assertEquals("Crap   ",r[2].getPicture().format("Crap"));
        assertEquals(0,r[2].getTreeRootOffset());
        assertEquals(28,r[2].getWidth());
        assertTrue(r[2].isColor());
        assertFalse(r[2].isColumnFixed());
        assertFalse(r[2].isIcon());
        assertFalse(r[2].isLastOnLine());
        assertFalse(r[2].isLocator());
        assertTrue(r[2].isResizable());
        assertFalse(r[2].isStyle());
        assertFalse(r[2].isTransparantIcon());
        assertFalse(r[2].isTree());
        assertFalse(r[2].isTreeBoxes());
        assertFalse(r[2].isTreeIndent());
        assertFalse(r[2].isTreeLines());
        assertFalse(r[2].isTreeRootLines());
        assertFalse(r[2].isUnderline());
        assertTrue(r[2].isVerticalLine());
        
    }
        
}
