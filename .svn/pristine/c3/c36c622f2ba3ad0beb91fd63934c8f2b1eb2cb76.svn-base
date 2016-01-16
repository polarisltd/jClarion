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
package org.jclarion.clarion.compile.java;

import junit.framework.TestCase;

public class LabellerTest extends TestCase {

    public void testTyping()
    {
        assertEquals("v1",Labeller.get("v1",false));
        assertEquals("V1",Labeller.get("v1",true));
    }

    public void testUpperCase()
    {
        assertEquals("var2",Labeller.get("var2",false));
        assertEquals("var3",Labeller.get("VAR3",false));

        assertEquals("Var2",Labeller.get("var2",true));
        assertEquals("Var3",Labeller.get("VAR3",true));
    }
    
    public void testMixedCase()
    {
        assertEquals("adjnoun",Labeller.get("adjNoun",false));
        assertEquals("adjnoun",Labeller.get("adjnoun",false));
        assertEquals("adjnoun",Labeller.get("ADJNOUN",false));

        assertEquals("Adjnoun",Labeller.get("adjNoun",true));
        assertEquals("Adjnoun",Labeller.get("adjnoun",true));
        assertEquals("Adjnoun",Labeller.get("ADJNOUN",true));
    }
    
    public void testColonModifier()
    {
        assertEquals("accessStock",Labeller.get("access:stock",false));
        assertEquals("accessFranch",Labeller.get("access::franch",false));
        assertEquals("brw1_0",Labeller.get("brw1:0",false));
        assertEquals("brw1_",Labeller.get("brw1:",false));
    }

    public void testFirstAlpha()
    {
        assertEquals("alpha1",Labeller.get("Alpha1",false));
        assertEquals("alpha2",Labeller.get("alpha2",false));

        assertEquals("Alpha3",Labeller.get("alpha3",true));
        assertEquals("Alpha4",Labeller.get("Alpha4",true));

        assertEquals("_alpha1",Labeller.get("_Alpha1",false));
        assertEquals("_alpha2",Labeller.get("_alpha2",false));

        assertEquals("_Alpha3",Labeller.get("_alpha3",true));
        assertEquals("_Alpha4",Labeller.get("_Alpha4",true));
    }
    
    public void testNoAlpha()
    {
        assertEquals("a_1",Labeller.get("_1",false));
        assertEquals("A_1",Labeller.get("_1",true));
    }
}
