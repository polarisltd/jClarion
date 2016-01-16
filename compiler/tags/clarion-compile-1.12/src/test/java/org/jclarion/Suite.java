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
package org.jclarion;

import org.jclarion.clarion.compile.*;
import org.jclarion.clarion.compile.expr.ExprCasterTest;
import org.jclarion.clarion.compile.grammar.*;
import org.jclarion.clarion.compile.hook.HookEntryTest;
import org.jclarion.clarion.compile.java.JavaClassTest;
import org.jclarion.clarion.compile.java.JavaCodeTest;
import org.jclarion.clarion.compile.java.LabellerTest;
import org.jclarion.clarion.compile.rewrite.PatternRewriterTest;
import org.jclarion.clarion.compile.setting.SettingParserTest;

import junit.framework.Test;
import junit.framework.TestSuite;

public class Suite extends TestSuite
{
    public static Test suite() {
        TestSuite ts = new TestSuite();

        ts.addTestSuite(LabellerTest.class);
        ts.addTestSuite(ExprCasterTest.class);
        ts.addTestSuite(ExprParserTest.class);
        ts.addTestSuite(SettingParserTest.class);
        ts.addTestSuite(VariableParserTest.class);
        ts.addTestSuite(PrototypeParserTest.class);
        ts.addTestSuite(JavaClassTest.class);
        ts.addTestSuite(JavaCodeTest.class);
        ts.addTestSuite(CompileTest.class);
        ts.addTestSuite(StatementParserTest.class);
        ts.addTestSuite(GroupCompileTest.class);
        ts.addTestSuite(QueueCompileTest.class);
        ts.addTestSuite(FileCompileTest.class);
        ts.addTestSuite(CompileRealFileTest.class);
        ts.addTestSuite(CompileDosFileTest.class);
        ts.addTestSuite(ClarionClassCompileTest.class);
        ts.addTestSuite(InterfaceCompileTest.class);
        ts.addTestSuite(PatternRewriterTest.class);
        ts.addTestSuite(SysCallTest.class);
        ts.addTestSuite(TargetCompileTest.class);
        ts.addTestSuite(RoutineCompileTest.class);
        ts.addTestSuite(ScopeTraversalCompileTest.class);
        ts.addTestSuite(CompileOmitTest.class);
        ts.addTestSuite(IncludeCompileTest.class);
        ts.addTestSuite(CompileModuleTest.class);
        ts.addTestSuite(EquateTest.class);
        ts.addTestSuite(HookEntryTest.class);
        ts.addTestSuite(JavaExtensionsTest.class);
        
        return ts;
    }
    
    
}
