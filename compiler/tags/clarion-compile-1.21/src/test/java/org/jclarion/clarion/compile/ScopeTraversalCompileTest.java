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
package org.jclarion.clarion.compile;

import org.jclarion.clarion.ClarionObject;


/**
 *  Test variable scope handoff across various scope boundaries: e.g.
 *  procedure scope to target definition scope etc
 * @author barney
 *
 */
public class ScopeTraversalCompileTest extends CompileTestHelper
{

    public void testProcedureScopeToReport()
    {
        compile(
                "    program\n",
                
                "PAPER:A4                  EQUATE(9)       ! A4 210 x 297 mm\n",
                "CHARSET:ANSI            EQUATE (  0)\n",
                "FONT:bold               EQUATE (700)\n",
                "COLOR:black             EQUATE (0000000H)\n",
                
                "    map\n",
                "runreport procedure\n",
                "    .\n",
                "     code\n",
                "runreport procedure\n",
                
                "fromDate             DATE\n",
                "toDate               DATE\n",
                "nextentry            LONG\n",
                "part                 STRING(20)\n",
                "\n",
                "\n",
                "PartList             QUEUE,PRE(PL)\n",
                "refcode              BYTE,          name('refcode')\n",
                "suppcode             STRING(10),    name('suppcode')\n",
                "typecode             STRING(10),    name('typecode')\n",
                "partnum              STRING(20),    name('partnum')\n",
                "format               STRING(20)\n",
                "desc                 STRING(30)\n",
                "sqty                 SHORT,         name('sqty')\n",
                "rqty                 SHORT\n",
                "sunitcost            DECIMAL(9,2)\n",
                "scost                DECIMAL(9,2)\n",
                "ssold                DECIMAL(9,2),  name('sold')\n",
                "sdiscount            DECIMAL(9,2)\n",
                "sprofit              DECIMAL(9,2),  name('profit')\n",
                "carried              STRING(1),     name('carried')\n",
                "dqty                 SHORT,         name('dqty')\n",
                "\n",
                "dunitcost            DECIMAL(9,2)\n",
                "\n",
                "!dcost                DECIMAL(9,2)\n",
                "!dsold                DECIMAL(9,2)\n",
                "!dprofit              DECIMAL(9,2)\n",
                "\n",
                "!tprofit              DECIMAL(9,2),  name('tprofit')\n",
                "!tsold                DECIMAL(9,2),  name('tsold')\n",
                "\n",
                "                     END\n",
                "\n",
                "Tally                QUEUE(PartList),PRE(TL)\n",
                "                     END\n",
                "\n",
                "\n",
                "GrandTotal          QUEUE(PartList),PRE(GT)\n",
                "                    END\n",
                "   \n",
                "profitPer            DECIMAL(7,2)\n",
                "dordper              DECIMAL(7,2)\n",
                "discountPer          DECIMAL(7,2)\n",
                "fromfile             STRING(1)\n",
                "\n",
                "\n",
                "lastGroupStr         pstring(60)\n",
                "thisGroupStr         pstring(60)\n",
                "sortStr              pstring(80)\n",
                "\n",
                "tempQty             long\n",
                "tempRQty            long\n",
                "tempDQty            long\n",
                "\n",
                "rFranch              string(35),dim(3)\n",
                "\n",
                "loop1                LONG\n",
                "loop2                long\n",
                "\n",
                "Report REPORT('C8 Sales/Profit Report'),AT(1000,1250,9688,6000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',10,,), |\n",
                "         LANDSCAPE,THOUS\n",
                "       HEADER,AT(1000,500,9688,750)\n",
                "         STRING('Qty'),AT(5292,531),USE(?String6:12),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('Ord Qty'),AT(4010,531),USE(?String6:3),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('Discount'),AT(7469,531),USE(?String6:15),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('Sales/Profit Report from'),AT(0,0),USE(?String1),TRN\n",
                "         STRING(@d6.),AT(1500,10),USE(fromDate),TRN\n",
                "         STRING('to'),AT(2229,10),USE(?String3),TRN\n",
                "         STRING(@d6.),AT(2427,10),USE(toDate),TRN\n",
                "         STRING('Grouping'),AT(42,365),USE(?String5),TRN,FONT(,8,,FONT:bold,CHARSET:ANSI)\n",
                "         LINE,AT(5531,531,0,177),USE(?Line2:2),COLOR(COLOR:Black)\n",
                "         STRING('Ord %'),AT(4635,531),USE(?String48),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('Part Num'),AT(271,531),USE(?String6),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('Description'),AT(1552,531),USE(?String6:2),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "         LINE,AT(7458,698,0,-177),USE(?Line4:2),COLOR(COLOR:Black)\n",
                "         LINE,AT(1500,510,0,177),USE(?Line2:4),COLOR(COLOR:Black)\n",
                "         LINE,AT(3406,698,0,-177),USE(?Line4:3),COLOR(COLOR:Black)\n",
                "         STRING('Qty'),AT(3667,531),USE(?String6:6),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('Prof %'),AT(9063,531,344,156),USE(?String6:8),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('Refund'),AT(5094,406),USE(?String6:5),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('Daily '),AT(4135,385),USE(?String6:4),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('Daily '),AT(4688,406),USE(?String6:11),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('* None Carried'),AT(8354,31),USE(?String6:16),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('Profit'),AT(8552,531),USE(?String6:7),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('Sold'),AT(6802,531),USE(?String6:9),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('Cost'),AT(6042,531),USE(?String6:10),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "       END\n",
                "Part   DETAIL,AT(,,,146)                !STRING(@s30),AT(1552,-10),USE(String19,,?String19:2),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-13.2),AT(6354,-21,740,188),USE(pl:ssold,,?pl:ssold:2),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-13.2),AT(8135,-21,740,188),USE(pl:sprofit,,?pl:sprofit:2),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-7.2),AT(4479,-21,479,188),USE(dordper),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@n6),AT(4000,-21,333,188),USE(pl:dqty),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-7.2),AT(8969,-21,469,188),USE(profitper),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@s1),AT(4354,-21),USE(pl:carried),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-13.2),AT(7198,-21,740,188),USE(pl:sdiscount,,?pl:sdiscount:2),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@s20),AT(271,-21),USE(pl:format),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@s30),AT(1552,-21,1802,188),USE(pl:desc),TRN,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@n6),AT(3448,-21,396,188),USE(pl:sqty,,?pl:sqty:2),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-13.2),AT(5573,-10,740,188),USE(pl:scost,,?pl:scost:2),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@n6),AT(5083,-21,396,188),USE(pl:rqty),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "       END\n",
                "\n",
                "FranchHead DETAIL,AT(,,,188)\n",
                "         STRING(@s30),AT(42,31,1938,188),USE(rfranch[1]),TRN,FONT(,8,,FONT:bold,CHARSET:ANSI)\n",
                "         STRING(@s30),AT(3865,31,1938,188),USE(rfranch[3]),TRN,FONT(,8,,FONT:bold,CHARSET:ANSI)\n",
                "         STRING(@s30),AT(1958,31,1938,188),USE(rfranch[2]),TRN,FONT(,8,,FONT:bold,CHARSET:ANSI)\n",
                "         LINE,AT(31,10,9604,0),USE(?Line7:3),COLOR(COLOR:Black)\n",
                "       END\n",
                "FranchFoot DETAIL,AT(,10,,188)\n",
                "         STRING(@n7),AT(5021,21,,188),USE(tl:rqty),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('Totals:'),AT(2875,21),USE(?String45:2),TRN,FONT(,8,,FONT:bold,CHARSET:ANSI)\n",
                "         LINE,AT(3396,21,6240,0),USE(?Line7),COLOR(COLOR:Black)\n",
                "         STRING(@n7),AT(3385,21,,188),USE(tl:sqty),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-13.2),AT(5573,21,740,188),USE(tl:scost),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-13.2),AT(6354,21,740,188),USE(tl:ssold),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-13.2),AT(7198,21,740,188),USE(tl:sdiscount),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-13.2),AT(8135,21,740,188),USE(tl:sprofit),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@n7),AT(3875,21,,188),USE(tl:dqty),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-7.2),AT(8969,21,469,188),USE(profitper,,?profitper:2),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-7.2),AT(4479,21,479,188),USE(dordper,,?dordper:2),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "       END\n",
                "GrandTotal DETAIL,AT(,,,240)\n",
                "         STRING(@n7),AT(5021,21,,188),USE(gt:rqty),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING('GRAND TOTAL:'),AT(2427,21),USE(?String45:3),TRN,FONT(,8,,FONT:bold,CHARSET:ANSI)\n",
                "         LINE,AT(3396,21,6240,0),USE(?Line7:2),COLOR(COLOR:Black)\n",
                "         STRING(@n7),AT(3385,21,,188),USE(gt:sqty),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-13.2),AT(5573,21,740,188),USE(gt:scost),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-13.2),AT(6354,21,740,188),USE(gt:ssold),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-13.2),AT(7198,21,740,188),USE(gt:sdiscount),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-13.2),AT(8135,21,740,188),USE(gt:sprofit),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@n7),AT(3875,21,,188),USE(gt:dqty),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-7.2),AT(8969,21,469,188),USE(profitper,,?profitper:3),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "         STRING(@N-7.2),AT(4479,21,479,188),USE(dordper,,?dordper:3),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
                "       END\n",
                "     END\n",
                "\n",
                "\n",
                "   code\n",
                "");
    }
    
    public void testClassScopeToProcedureScope()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "    map\n",
                "testproc procedure(long,long),long\n",
                "   .\n",
                "   code\n",
                "   result=testproc(command(1),command(2))\n",
                "testproc procedure(p1,p2)\n",
                "somefield long\n",
                "testclass class\n",
                "myMethod procedure(long),long\n",
                ".\n",
                "   code\n",
                "   somefield=p1\n",
                "   return testclass.mymethod(p2)+4\n",
                "testclass.mymethod procedure(aVal)\n",
                "test long(2)\n",
                "   code\n",
                "   return test+aVal+someField*2\n",
        "");
        
        ClarionObject co = getMainVariable(cl,"result");
        assertEquals(0,co.intValue());

        runClarionProgram(cl,"2","3");
        assertEquals(13,co.intValue());

        runClarionProgram(cl,"5","3");
        assertEquals(19,co.intValue());
    }
    
    public void testClassScopeToProcedureScopeDisordered()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "    map\n",
                "testproc procedure(long,long),long\n",
                "   .\n",
                "   code\n",
                "   result=testproc(command(1),command(2))\n",
                "testproc procedure(p1,p2)\n",
                "i1 long\n",
                "testclass class\n",
                "myMethod procedure(long),long\n",
                ".\n",
                "i3 long\n",
                "somefield long\n",
                "i2 long\n",
                "   code\n",
                "   somefield=p1\n",
                "   return testclass.mymethod(p2)+4\n",
                "testclass.mymethod procedure(aVal)\n",
                "test long(2)\n",
                "   code\n",
                "   return test+aVal+someField*2\n",
        "");
        
        ClarionObject co = getMainVariable(cl,"result");
        assertEquals(0,co.intValue());

        runClarionProgram(cl,"2","3");
        assertEquals(13,co.intValue());

        runClarionProgram(cl,"5","3");
        assertEquals(19,co.intValue());
        
        
    }

    
    public void testRoutineClassScopeToProcedureScopeDisordered()
    {
        ClassLoader cl = compile(
                "    program\n",
                "result long\n",
                "    map\n",
                "testproc procedure(long,long),long\n",
                "   .\n",
                "   code\n",
                "   result=testproc(command(1),command(2))\n",
                "testproc procedure(p1,p2)\n",
                "i1 long\n",
                "testclass class\n",
                "myMethod procedure(long),long\n",
                "myField  long(7)\n",
                ".\n",
                "i3 long\n",
                "somefield long\n",
                "i2 long\n",
                "   code\n",
                "   somefield=p1\n",
                "   return testclass.mymethod(p2)+4\n",
                "testclass.mymethod procedure(aVal)\n",
                "test long(2)\n",
                "   code\n",
                "   do myroutine\n",
                "myroutine routine\n",
                "   return test+aVal+someField*2+SELF.myField\n",
        "");
        
        ClarionObject co = getMainVariable(cl,"result");
        assertEquals(0,co.intValue());

        runClarionProgram(cl,"2","3");
        assertEquals(20,co.intValue());

        runClarionProgram(cl,"5","3");
        assertEquals(26,co.intValue());
     
    }
    
}
