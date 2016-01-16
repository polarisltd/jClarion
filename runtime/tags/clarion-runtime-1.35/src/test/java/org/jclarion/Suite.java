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

import org.jclarion.clarion.*;
import org.jclarion.clarion.antlr.ClarionExprParserTest;
import org.jclarion.clarion.control.ListColumnTest;
import org.jclarion.clarion.jdbc.JDBCSourceTest;
import org.jclarion.clarion.print.OpenReportPreInitTest;
import org.jclarion.clarion.print.OpenReportTest;
import org.jclarion.clarion.print.PrintObjectTest;
import org.jclarion.clarion.print.ReportComponentIteratorTest;
import org.jclarion.clarion.print.TextBreakerTest;
import org.jclarion.clarion.runtime.*;
import org.jclarion.clarion.runtime.format.*;
import org.jclarion.clarion.runtime.ref.RefVariableTest;
import org.jclarion.clarion.swing.*;
import org.jclarion.clarion.util.*;
import org.jclarion.clarion.view.ClarionBufferedViewTest;
import org.jclarion.clarion.view.ClarionViewTest;

import junit.framework.Test;
import junit.framework.TestSuite;

public class Suite extends TestSuite
{
    public static Test suite() {
        TestSuite ts = new TestSuite();

        ts.addTestSuite(ClarionEventTest.class);
        
        ts.addTestSuite(RefVariableTest.class);
        
        ts.addTestSuite(org.jclarion.clarion.lang.LexStreamTest.class);
        ts.addTestSuite(org.jclarion.clarion.lang.LexerTest.class);
        
        ts.addTestSuite(ClarionStringTest.class);
        ts.addTestSuite(ClarionNumberTest.class);
        ts.addTestSuite(ClarionDecimalTest.class);
        ts.addTestSuite(ClarionBoolTest.class);
        ts.addTestSuite(ClarionRealTest.class);
        ts.addTestSuite(ClarionAnyTest.class);
        ts.addTestSuite(ClarionGroupTest.class);

        ts.addTestSuite(CDateTest.class);

        ts.addTestSuite(CMemoryTest.class);
        ts.addTestSuite(CRunTest.class);
        ts.addTestSuite(CConfigTest.class);
        
        ts.addTestSuite(FormatResolverTest.class);
        ts.addTestSuite(StringFormatTest.class);
        ts.addTestSuite(NumberFormatTest.class);
        ts.addTestSuite(DateFormatterTest.class);
        ts.addTestSuite(TimeFormatTest.class);
        ts.addTestSuite(PatternFormatTest.class);

        ts.addTestSuite(ListColumnTest.class);
        ts.addTestSuite(PropertyTest.class);

        ts.addTestSuite(SharedInputStreamTest.class);
        ts.addTestSuite(SharedOutputStreamTest.class);
        
        ts.addTestSuite(ClarionExprParserTest.class);
        ts.addTestSuite(CExpressionTest.class);
        ts.addTestSuite(CSQLExpressionTest.class);
        
        ts.addTestSuite(JDBCSourceTest.class);
        ts.addTestSuite(ClarionAsciiFileTest.class);
        ts.addTestSuite(ClarionDosFileTest.class);
        ts.addTestSuite(ClarionSQLFileTest.class);
        ts.addTestSuite(ClarionSQLFileWithLimitTest.class);
        ts.addTestSuite(ClarionSQLFileBinaryTest.class);
        ts.addTestSuite(ClarionViewTest.class);
        ts.addTestSuite(ClarionBufferedViewTest.class);

        ts.addTestSuite(EntryTest.class);
        ts.addTestSuite(TextTest.class);
        ts.addTestSuite(WindowTest.class);
        ts.addTestSuite(MenuTest.class);
        ts.addTestSuite(ClarionApplicationTest.class);
        ts.addTestSuite(ButtonTest.class);
        ts.addTestSuite(ListTest.class);
        ts.addTestSuite(PromptTest.class);
        ts.addTestSuite(StringTest.class);
        ts.addTestSuite(RadioTest.class);
        ts.addTestSuite(Radio2Test.class);
        ts.addTestSuite(CheckTest.class);
        ts.addTestSuite(SheetTest.class);
        ts.addTestSuite(WizardTest.class);
        ts.addTestSuite(PanelTest.class);
        ts.addTestSuite(LineTest.class);
        ts.addTestSuite(AcceptAllTest.class);
        ts.addTestSuite(MessageTest.class);
        ts.addTestSuite(ComboTest.class);
        ts.addTestSuite(ProgressTest.class);
        
        ts.addTestSuite(ClarionPrinterTest.class);
        ts.addTestSuite(TextBreakerTest.class);
        ts.addTestSuite(PrintObjectTest.class);
        ts.addTestSuite(ReportComponentIteratorTest.class);
        ts.addTestSuite(OpenReportTest.class);
        ts.addTestSuite(OpenReportPreInitTest.class);
        
        return ts;
    }
    
    
}
