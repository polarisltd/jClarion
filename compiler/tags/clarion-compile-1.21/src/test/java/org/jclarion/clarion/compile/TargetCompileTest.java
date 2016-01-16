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

import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.constants.Event;
import org.jclarion.clarion.constants.Prop;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.runtime.CWin;



public class TargetCompileTest extends CompileTestHelper {

	public void testDragDrop()
	{
        compile("  program\n",
                "mywindow window\n",
                "   string('hello'),dragid('some','kind','of','monster'),dropid('the','mighty','boosh')\n",
                ".\n",
                "  code\n",
                "");
		
	}

	public void testCompileMark()
	{
        compile("  program\n",
        		"myqueue queue\n",
        		"entry string(20)\n",
        		"mark  byte\n",
        		".\n",
                "mywindow window\n",
                "   list,grid(0),from(myqueue),mark(myqueue.mark),color(1,2)\n",
                "   combo,grid(0),from(myqueue),mark(myqueue.mark),color(,1,2)\n",
                ".\n",
                "   code\n",
                "");
	}
	
	public void testCompileVCR()
	{
        compile("  program\n",
        		"input long\n",
                "mywindow window\n",
                "	entry(@n10),use(input)\n",
                "   list,grid(0)\n",
                "   list,vcr\n",
                "   list,vcr(1)\n",
                "   list,vcr(?input)\n",
                "   combo\n",
                "   combo,vcr\n",
                "   combo,vcr(1)\n",
                "   combo,vcr(?input)\n",
                ".\n",
                "   code\n",
                "");
	}
	
	public void testCenterInReport()
	{
        compile("  program\n",
        		"mqueue queue\n",
        		"file string(100)\n",
        		".\n",
                "Report               REPORT('musician Report'),AT(250,850,8000,9650),PRE(RPT),THOUS,PREVIEW(mqueue)\n",
                "MyDetail detail,font('test'),pagebefore(-1)\n",
                "  STRING('HERE I AM J.H.'),AT(115,52,344,135),CENTER(4)\n",
                ".\n",
                ".\n",
                "   code\n",
                "");
	}
	
	public void testPageBefore()
	{
        ClassLoader cl = compile("  program\n",
        		"mqueue queue\n",
        		"file string(100)\n",
        		".\n",
                "Report               REPORT('musician Report'),AT(250,850,8000,9650),PRE(RPT),THOUS,PREVIEW(mqueue)\n",
                "MyDetail detail,pagebefore(-1)\n",
                "  STRING('HERE I AM J.H.'),AT(115,52,344,135)\n",
                ".\n",
                ".\n",
                "   code\n",
                "   open(report)\n",
                "   print(rpt:mydetail)\n",
                "   print(rpt:mydetail)\n",
                "   print(rpt:mydetail)\n",
                "   print(rpt:mydetail)\n",
                "   print(rpt:mydetail)\n",
                "   endpage(report)\n",
                "   assert(records(mqueue)=5)\n",
                "   close(report)\n",
                "");
        runClarionProgram(cl);
		
	}

	public void testPageAfter()
	{
        ClassLoader cl = compile("  program\n",
        		"mqueue queue\n",
        		"file string(100)\n",
        		".\n",
                "Report               REPORT('musician Report'),AT(250,850,8000,9650),PRE(RPT),THOUS,PREVIEW(mqueue)\n",
                "MyDetail detail,pageafter(-1)\n",
                "  STRING('HERE I AM J.H.'),AT(115,52,344,135)\n",
                ".\n",
                ".\n",
                "   code\n",
                "   open(report)\n",
                "   print(rpt:mydetail)\n",
                "   print(rpt:mydetail)\n",
                "   print(rpt:mydetail)\n",
                "   print(rpt:mydetail)\n",
                "   print(rpt:mydetail)\n",
                "   assert(records(mqueue)=5)\n",
                "   close(report)\n",
                "");
        runClarionProgram(cl);
		
	}

	public void testPageNoBeforeAfterControlTest()
	{
        ClassLoader cl = compile("  program\n",
        		"mqueue queue\n",
        		"file string(100)\n",
        		".\n",
                "Report               REPORT('musician Report'),AT(250,850,8000,9650),PRE(RPT),THOUS,PREVIEW(mqueue)\n",
                "MyDetail detail\n",
                "  STRING('HERE I AM J.H.'),AT(115,52,344,135)\n",
                ".\n",
                ".\n",
                "   code\n",
                "   open(report)\n",
                "   print(rpt:mydetail)\n",
                "   print(rpt:mydetail)\n",
                "   print(rpt:mydetail)\n",
                "   print(rpt:mydetail)\n",
                "   print(rpt:mydetail)\n",
                "   endpage(report)\n",
                "   assert(records(mqueue)=1)\n",
                "   close(report)\n",
                "");
        runClarionProgram(cl);
		
	}
	
    public void testClarion6StyleReport()
    {
        compile("  program\n",
        "Report               REPORT('musician Report'),AT(250,850,8000,9650),PRE(RPT),THOUS\n",
        "   FOOTER,AT(250,10500,8000,250),USE(?Footer)\n",
        "  STRING('Date:'),AT(115,52,344,135),USE(?ReportDatePrompt,,?ReportDatePrompt:2),TRN\n",
        ".\n",
        ".\n",
        "   code\n",
        "");
        
    }

    public void testSetWindowPosition()
    {
    	ClassLoader cl = compile(" program\n",
    	        "win window('test'),at(10,10,200,200),resize,timer(5)\n",
    	        ".\n",
    	        "   map\n",
    	        "ip procedure(window awin)\n",
    	        "   .\n",
    	        "   code\n",
    	        "   ip(win)\n",
    	        "ip procedure(window awin)\n",
    	        "c  long\n",
    	        "x long\n",
    	        "y long\n",
    	        "w long\n",
    	        "h long\n",
    	        "   code\n",
    	        "   open(awin)\n",
    	        "   accept\n",
    	        "      if event()=20bh  ! timer\n",
    	        "            setPosition(awin,c,c,300,300)\n",
    	        "            getPosition(awin,x,y,w,h)\n",
    	        "            c+=5\n",
    	        "            if c=40 then post(201h).\n ! close window\n",
    	        "      .\n",
    	        "   .\n",
    	        "   close(awin)\n",
    	     "");
        runClarionProgram(cl);
    }
    
    public void testCreateAndDestroyControls()
    {
        ClassLoader cl = compile(" program\n",
        "window window('test'),at(10,10,200,200),timer(5)\n",
        ".\n",
        "side short\n",
        "pos  short\n",
        "   code\n",
        "   open(window)\n",
        "   accept\n",
        "      if event()=20bh\n ! timer\n",
        "         ctl#=create(0,5) ! line\n",
        "         if side=0 then setposition(ctl#,0,pos,pos,100-pos).\n",
        "         if side=1 then setposition(ctl#,pos,100,100-pos,-pos).\n",
        "         if side=2 then setposition(ctl#,100,100-pos,-pos,pos-100).\n",
        "         if side=3 then setposition(ctl#,100-pos,0,pos-100,pos).\n",
        "         unhide(ctl#)\n",
        "         pos+=10\n",
        "         if pos=100\n",
        "              pos=0\n",
        "              side+=1\n",
        "              if side=4 then post(201h).\n ! close window\n",
        "         .\n",
        "         Y#=0{7d0ah,8}\n",
        "         if y# then destroy(0{7d0ah,1})\n.   ! prop:childindex\n",
        "         Y#=0{7d0ah,8}\n",
        "         assert(y#=0)\n",
        "      .\n",
        "   .\n",
        "");
        runClarionProgram(cl);
    }
    
    public void testDestroyWindowOnExit()
    {
        ClassLoader cl = compile("  program\n",
                "test &Window\n",
                "   map\n",
                "testproc procedure\n",
                "   .\n",
                "   code\n",
                "   testproc\n",
                "testproc procedure\n",
                "win window('Win'),at(10,10,50,50),mdi,timer(10)\n",
                ".\n",
                "   code\n",
                "   test&=win\n",
                "   open(win)\n",
                "   accept\n",
                "      if event()=20bh  ! timer\n",
                "         return\n",
                "      .\n",
                "   .\n",
            "");
        
        runClarionProgram(cl);
        ClarionWindow win = (ClarionWindow)getMainObject(cl,"test");
        assertNull(win.getWindow());
        
    }

    public void testWindowNotDestroyedOnEscalation()
    {
        ClassLoader cl = compile("  program\n",
                "test &Window\n",
                "   map\n",
                "testproc procedure\n",
                "   .\n",
                "   code\n",
                "   testproc\n",
                "testproc procedure\n",
                "win window('Win'),at(10,10,50,50),mdi,timer(10)\n",
                ".\n",
                "myclass class\n",
                "doit procedure\n",
                ".\n",
                "   code\n",
                "   test&=win\n",
                "   open(win)\n",
                "   accept\n",
                "      if event()=20bh  ! timer\n",
                "         myclass.doit()\n",
                "         @java-code 'CRun._assert($.getWindow()!=null);'(win)\n",
                "         do doitr\n",
                "         @java-code 'CRun._assert($.getWindow()!=null);'(win)\n",
                "         return\n",
                "      .\n",
                "   .\n",
                "doitr routine\n",
                "   k#=win{1}\n",
                "myclass.doit procedure\n",
                "   code\n",
                "   k#=win{1}\n",
            "");
        System.out.println(ClassRepository.get("Main").toJavaSource());
        
        runClarionProgram(cl);
        ClarionWindow win = (ClarionWindow)getMainObject(cl,"test");
        assertNull(win.getWindow());
        
    }
    
    public void testDestroyReportOnExit()
    {
        ClassLoader cl = compile("  program\n",
                "test &Report\n",
                "   map\n",
                "testproc procedure\n",
                "   .\n",
                "   code\n",
                "   testproc\n",
                "testproc procedure\n",
                "mypreview queue\n",
                "entry   string(64)\n",
                ".\n",
                "Report REPORT('C8 Sales/Profit Report'),AT(1000,1250,9688,6000),PRE(RPT),FONT('Arial',10,,), |\n",
                "         LANDSCAPE,THOUS,preview(mypreview)\n",
                "mydetail detail,at(,,1000,200)\n",
                ".\n",
                ".\n",
                "   code\n",
                "   test&=report\n",
                "   open(report)\n",
                "   print(rpt:mydetail)\n",
                "   print(rpt:mydetail)\n",
            "");
        
        runClarionProgram(cl);
        ClarionReport rep = (ClarionReport)getMainObject(cl,"test");
        assertNull(rep.getOpenReport());
    }
    
    public void testNotifyOneWindowToAnother()
    {
        ClassLoader cl = compile("  program\n",
                "app application('App'),at(10,10,100,100),timer(500)\n",
                ".\n",
                "win window('Win'),at(10,10,50,50),mdi\n",
                ".\n",
                "main_tid long\n",
                "win_tid long\n",
                
                "t_code long(-1)\n",
                "t_parameter long(-1)\n",
                "t_thread long(-1)\n",
                
                "   map\n",
                "winthread procedure\n",
                "   .\n",
                "   code\n",
                "   main_tid=thread()\n",
                "   open(app)\n",
                "   accept\n",
                "      if event()=203h  ! open window\n",
                "         start(winthread)\n",
                "      .\n",
                "      if event()=20bh  ! timer\n",
                "         post(201h)\n ! close window\n",
                "      .\n",
                "      if event()=20ah  ! notify\n",
                "         notification(t_code,t_thread,t_parameter)\n",
                "         post(201h)\n ! close window\n",
                "      .\n",
                "   .\n",
                "   assert(26=t_code,'t_code')\n",
                "   assert(win_tid=t_thread,'t_thread')\n",
                "   assert(2=t_parameter,'2')\n",
                "winthread procedure\n",
                "   code\n",
                "   win_tid=thread()\n",
                "   open(win)\n",
                "   accept\n",
                "      if event()=203h  ! open window\n",
                "           notify(26,main_tid,2)\n",
                "      .\n",
                "   .\n",
                "   close(win)\n",
        "");
        runClarionProgram(cl);
    }

    public void testNotifyOneWindowToAnotherA()
    {
        ClassLoader cl = compile("  program\n",
                "app application('App'),at(10,10,100,100),timer(500)\n",
                ".\n",
                "win window('Win'),at(10,10,50,50),mdi\n",
                ".\n",
                "main_tid long\n",
                "win_tid long\n",
                
                "t_code long(-1)\n",
                "t_parameter long(-1)\n",
                "t_thread long(-1)\n",
                
                "   map\n",
                "winthread procedure\n",
                "   .\n",
                "   code\n",
                "   main_tid=thread()\n",
                "   open(app)\n",
                "   accept\n",
                "      if event()=203h  ! open window\n",
                "         start(winthread)\n",
                "      .\n",
                "      if event()=20bh  ! timer\n",
                "         post(201h)\n ! close window\n",
                "      .\n",
                "      if event()=20ah  ! notify\n",
                "         notification(t_code,t_thread,t_parameter)\n",
                "         post(201h)\n ! close window\n",
                "      .\n",
                "   .\n",
                "   assert(26=t_code,'t_code')\n",
                "   assert(win_tid=t_thread,'t_thread')\n",
                "   assert(0=t_parameter,'t_parameter')\n",
                "winthread procedure\n",
                "   code\n",
                "   win_tid=thread()\n",
                "   open(win)\n",
                "   accept\n",
                "      if event()=203h  ! open window\n",
                "           notify(26,main_tid)\n",
                "      .\n",
                "   .\n",
                "   close(win)\n",
        "");
        runClarionProgram(cl);
    }

    public void testNotifySelf_A()
    {
        ClassLoader cl = compile("  program\n",
                "app application('App'),at(10,10,100,100),timer(500)\n",
                ".\n",
                "main_tid long\n",
                "t_code long(-1)\n",
                "t_parameter long(-1)\n",
                "t_thread long(-1)\n",
                
                "   code\n",
                "   main_tid=thread()\n",
                "   open(app)\n",
                "   accept\n",
                "      if event()=203h  ! open window\n",
                "           notify(26,0,2)\n",
                "      .\n",
                "      if event()=20bh  ! timer\n",
                "         post(201h)\n ! close window\n",
                "      .\n",
                "      if event()=20ah  ! notify\n",
                "         notification(t_code,t_thread,t_parameter)\n",
                "         post(201h)\n ! close window\n",
                "      .\n",
                "   .\n",
                "   assert(26=t_code,'t_code')\n",
                "   assert(main_tid=t_thread,'t_thread')\n",
                "   assert(2=t_parameter,'t_parameter')\n",
        "");
        runClarionProgram(cl);
    }
    
    public void testNotifySelf_B()
    {
        ClassLoader cl = compile("  program\n",
                "app application('App'),at(10,10,100,100),timer(500)\n",
                ".\n",
                "main_tid long\n",
                "t_code long(-1)\n",
                "t_parameter long(-1)\n",
                "t_thread long(-1)\n",
                
                "   code\n",
                "   main_tid=thread()\n",
                "   open(app)\n",
                "   accept\n",
                "      if event()=203h  ! open window\n",
                "           notify(26,,2)\n",
                "      .\n",
                "      if event()=20bh  ! timer\n",
                "         post(201h)\n ! close window\n",
                "      .\n",
                "      if event()=20ah  ! notify\n",
                "         notification(t_code,t_thread,t_parameter)\n",
                "         post(201h)\n ! close window\n",
                "      .\n",
                "   .\n",
                "   assert(26=t_code,'t_code')\n",
                "   assert(main_tid=t_thread,'t_thread')\n",
                "   assert(2=t_parameter,'t_parameter')\n",
        "");
        runClarionProgram(cl);
    }

    public void testNotifySelf_C()
    {
        ClassLoader cl = compile("  program\n",
                "app application('App'),at(10,10,100,100),timer(500)\n",
                ".\n",
                "main_tid long\n",
                "t_code long(-1)\n",
                "t_parameter long(-1)\n",
                "t_thread long(-1)\n",
                
                "   code\n",
                "   main_tid=thread()\n",
                "   open(app)\n",
                "   accept\n",
                "      if event()=203h  ! open window\n",
                "           notify(26)\n",
                "      .\n",
                "      if event()=20bh  ! timer\n",
                "         post(201h)\n ! close window\n",
                "      .\n",
                "      if event()=20ah  ! notify\n",
                "         notification(t_code,t_thread,t_parameter)\n",
                "         post(201h)\n ! close window\n",
                "      .\n",
                "   .\n",
                "   assert(26=t_code,'t_code')\n",
                "   assert(main_tid=t_thread,'t_thread')\n",
                "   assert(0=t_parameter,'t_parameter')\n",
        "");
        runClarionProgram(cl);
    }
    
    
    public void testNotifyOneWindowOnlyCareAboutCode()
    {
        ClassLoader cl = compile("  program\n",
                "app application('App'),at(10,10,100,100),timer(500)\n",
                ".\n",
                "win window('Win'),at(10,10,50,50),mdi\n",
                ".\n",
                "main_tid long\n",
                "win_tid long\n",
                
                "t_code long(-1)\n",
                
                "   map\n",
                "winthread procedure\n",
                "   .\n",
                "   code\n",
                "   main_tid=thread()\n",
                "   open(app)\n",
                "   accept\n",
                "      if event()=203h  ! open window\n",
                "         start(winthread)\n",
                "      .\n",
                "      if event()=20bh  ! timer\n",
                "         post(201h)\n ! close window\n",
                "      .\n",
                "      if event()=20ah  ! notify\n",
                "         notification(t_code)\n",
                "         post(201h)\n ! close window\n",
                "      .\n",
                "   .\n",
                "   assert(26=t_code,'t_code')\n",
                "winthread procedure\n",
                "   code\n",
                "   win_tid=thread()\n",
                "   open(win)\n",
                "   accept\n",
                "      if event()=203h  ! open window\n",
                "           notify(26,main_tid,2)\n",
                "      .\n",
                "   .\n",
                "   close(win)\n",
        "");
        runClarionProgram(cl);
    }
    
    public void testBug2988797()
    {
        compile(

                "     program\n",
                "reg:saison long\n",
                "Window    WINDOW('Message'),AT(,,117,107),FONT('MS Sans Serif',18,,1,),CENTER,SYSTEM,GRAY,MDI,MAXIMIZE,auto\n",
                "   SPIN(@N4_),AT(100,20,119,10),USE(reg:saison),SKIP,DISABLE,RIGHT(1),RANGE(2006,2100)\n",
                ".\n",
                " code\n",
         "");
    }
    
    public void testCompileToolBar()
    {
        compile(

                "     program\n",
                "Window    WINDOW('Message'),AT(,,117,107),FONT('MS Sans Serif',18,,1,),CENTER,SYSTEM,GRAY,MDI,MAXIMIZE,auto\n",
                "   TOOLBAR,AT(1,20,148,146)\n",
                "   .\n",
                ".\n",
                "    code\n"
        );
    }

    public void testCompileVariousConstructs()
    {
        compile(

        "     program\n",
        
        "acclist queue.\n",
        
        "Window    WINDOW('Message'),AT(,,117,107),FONT('MS Sans Serif',18,,1,),CENTER,SYSTEM,GRAY,MDI,MAXIMIZE,auto\n",
        "       PROGRESS,USE(?percent),AT(23,39,142,11),RANGE(0,100)\n",
        "           COMBO(@s32),AT(3,23,120,12),USE(?RTF:ListFonts),SKIP,VSCROLL,TIP('Font name'),FORMAT('32L(2)'),DROP(10)\n",
        "           SPIN(@d6.),AT(38,26,60,10),range(1,100),step(2)\n",
        "           CHECK('Stream debugging to file'),AT(226,216),VALUE('1','0')\n",
        "           PANEL,AT(0,-1,130,105),USE(?Panel1),fill(5)\n",
        "         TEXT,AT(96,58,127,34),resize,readonly,single\n",
        "       BOX,AT(1,1,281,26),USE(?Box1),COLOR(0),FILL(0ffh)\n",
        "       OPTION('Print Range'),AT(3,16,149,49),BOXED\n",
        "           RADIO('All'),AT(8,28),USE(?rPages:Radio1),VALUE('A')\n",
        "           RADIO('Pages'),AT(9,41),USE(?rPages:Radio2),VALUE('R')\n",
        "      END\n",
        "      STRING('Refund Deposit'),AT(0,1,117,10),USE(?String1),CENTER\n",
        "      ENTRY(@n$13.2),AT(37,51,60,10),UPR\n",
        "      ENTRY(@n$13.2),AT(37,51,60,10),CAP\n",
        "   SHEET,AT(1,20,148,146),USE(?Sheet1),WIZARD,NOSHEET\n",
        "    TAB('Simple'),USE(?Tab1)\n",
        "     GROUP,AT(13,24,120,15),USE(?GroupSimple:1),BOXED,BEVEL(-1)\n",
        "      BUTTON('Method 1'),AT(13,24,120,15),USE(?ButtonSimple:1),FLAT,req\n",
        "     END\n", 
        "    END\n",
        "   END\n",
        "    PROMPT('Prompt X'),AT(3,27),USE(?method:1),RIGHT\n",
        "    LIST,AT(6,31,298,91),USE(?AccList),VSCROLL,FORMAT('44L(2)|M~Code~@s10@127L(2)|M~Name~@s40@20L(2)|M~Address~@s40@'), |\n",
        "     FROM(AccList),use(acclist)\n",
        "    IMAGE('hello'),AT(5,5),USE(?Image1)\n",
        " .\n",
        " code\n",
        " box(1,1,2,3)\n",
        "");
    }
    
    public void testTypicalWindow()
    {
        ClassLoader cl = compile(

          "     program\n",
          
          "treason     string(30)\n",
          "tAmount     decimal(12,2)\n",
          "tRefund     decimal(12,2)\n",
          "tWithhold   decimal(12,2)\n",
          "tRemain     decimal(12,2)\n",
          "ok          short\n",
          
          "COLOR:Yellow            EQUATE (000FFFFH)\n",
          "COLOR:Red               EQUATE (00000FFH)\n",
          "FONT:bold               EQUATE (700)\n",
          "CHARSET:ANSI            EQUATE (  0)\n",
          "STD:CLOSE               EQUATE (15)\n",
          
          "EVENT:Timer         EQUATE (20BH)\n",
          "EVENT:CloseWindow   EQUATE (201H)\n",
          
          "Window    WINDOW('Message'),AT(,,117,107),FONT('MS Sans Serif',18,,FONT:bold,CHARSET:ANSI),CENTER,SYSTEM,GRAY,timer(10)!,MDI\n",
          "      STRING('Refund Deposit'),AT(0,1,117,10),USE(?String1),CENTER\n",
          "      STRING(@s30),AT(0,10,117,),USE(treason),CENTER,FONT(,,COLOR:Yellow,,CHARSET:ANSI),COLOR(COLOR:Red)\n",
          "      GROUP,AT(1,23,114,68),USE(?Group1),BOXED,BEVEL(1)\n",
          "      STRING('Held Deposit:'),AT(3,24),USE(?String3)\n",
          "      STRING(@n$13.2),AT(49,24),USE(tamount),LEFT\n",
          "      STRING('Refund:'),AT(3,40),USE(?String5)\n",
          "      END\n",
          "     ENTRY(@n$13.2),AT(37,39,60,10),USE(trefund)\n",
          "      STRING('Withhold:'),AT(3,52),USE(?String5:2)\n",
          "      ENTRY(@n$13.2),AT(37,51,60,10),USE(twithhold)\n",
          "      STRING('Remain:'),AT(3,64),USE(?RemainString)\n",
          "      STRING(@n$13.2),AT(37,64),USE(tRemain)\n",
          "      BUTTON('Refund All Monies'),AT(2,74,56,14),USE(?RefundAll),FONT(,16,,,CHARSET:ANSI)\n",
          "      BUTTON('Withhold all Monies'),AT(60,74,54,14),USE(?WithholdAll),FONT(,16,,,CHARSET:ANSI)\n",
          "      BUTTON('OK'),AT(43,93,35,10),USE(?OKButton),FONT(,16,,,CHARSET:ANSI)\n",
          "      BUTTON('Cancel'),AT(79,93,37,10),USE(?CancelButton),FONT(,16,,,CHARSET:ANSI),STD(std:close)\n",
          "    END\n",
          
          "    code\n",
          "    open(window)\n",
          "    case ?remainString{7c01h}\n", // prop:type
          "         of 1\n",
          "             ?remainString{7c00h}='hello'\n", //prop:text
          "    .\n",
          "    accept\n",
          "        if event()=event:timer then post(event:closewindow).\n",
          "    .\n",
          "    close(window)\n",
                
        "");
        
        runClarionProgram(cl);
    }
    
    public void testAccessUseVarsInCode()
    {
        ClassLoader cl = compile(
                
        "     program\n",
        
        "treason     string(30)\n",
        
        "EVENT:Timer         EQUATE (20BH)\n",
        "EVENT:CloseWindow   EQUATE (201H)\n",
        "EVENT:OpenWindow    EQUATE (203H)\n",
        
        "Window    WINDOW('Message'),AT(,,117,107),CENTER,SYSTEM,GRAY,timer(10)!,MDI\n",
        "      STRING('Refund Deposit'),AT(0,1,117,10),USE(?String1),CENTER\n",
        "      STRING(@s30),AT(0,10,117,),USE(treason),CENTER\n",
        "    END\n",
        
        "    code\n",
        "    treason='opening'\n",
        "    open(window)\n",
        "    accept\n",
        "        if event()=event:openwindow then disable(?treason).\n",
        "        if event()=event:timer then post(event:closewindow).\n",
        "    .\n",
        "    close(window)\n",
              
      "");
      
      runClarionProgram(cl);
    }

    public void testAccessComplexUseVarsInCode()
    {
        compile(
                
        "     program\n",
        
        "mygroup group,pre(mg)\n",
        "s1     string(30)\n",
        "s2     string(30)\n",
        ".\n",
        
        "mybits long,dim(3)\n",
        
        "Window    WINDOW('Message'),AT(,,117,107),CENTER,SYSTEM,GRAY,timer(10)!,MDI\n",
        "      STRING(@s30),AT(0,10,117,),USE(mygroup.s1),CENTER\n",
        "      STRING(@s30),AT(0,10,117,),USE(mg:s2),CENTER\n",
        "      STRING(@s30),AT(0,10,117,),USE(mybits[1]),CENTER\n",
        "    END\n",
        
        "    code\n",
        "    ?mygroup:s1{1}='hello'\n",
        "    ?mg:s2{1}='hello'\n",
        "    ?mybits_1{1}='hello'\n",
              
      "");
    }
    
    
    public void testManipulateProperties()
    {
        ClassLoader cl = compile(
                
        "     program\n",
        
        "tReason     string(30)\n",
        
        "EVENT:Timer         EQUATE (20BH)\n",
        "EVENT:CloseWindow   EQUATE (201H)\n",
        "EVENT:OpenWindow    EQUATE (203H)\n",
        
        "PROP:Text           EQUATE(7C00H)  \n",
        "PROP:At             EQUATE(7C02H) \n",
        "PROP:Disable        EQUATE(7C5FH)  \n",
        
        "Window    WINDOW('Message'),AT(,,117,107),CENTER,SYSTEM,GRAY,timer(10)!,MDI\n",
        "      STRING('Refund Deposit'),AT(0,1,117,10),USE(?String1),CENTER\n",
        "      STRING(@s30),AT(0,10,117,),USE(tReason),CENTER\n",
        "    END\n",
        
        "    code\n",
        "    treason='opening'\n",
        "    open(window)\n",
        "    window{prop:text}='Prefix:'&window{prop:text}\n",
        "    window{prop:at,1}=10\n",
        "    accept\n",
        "        if event()=event:openwindow then ?tReason{prop:disable}=1.\n",
        "        if event()=event:timer then post(event:closewindow).\n",
        "    .\n",
        "    close(window)\n",
              
      "");
      
      runClarionProgram(cl);
    }
    
    
    public void testAppFrame()
    {
        ClassLoader cl = compile(
        "    program\n",
        "STD:WindowList    EQUATE (1)\n",
        "STD:TileWindow    EQUATE (2)\n",
        "STD:CascadeWindow EQUATE (3)\n",
        "STD:ArrangeIcons  EQUATE (4)\n",
        "STD:HelpIndex     EQUATE (5)\n",
        "STD:HelpOnHelp    EQUATE (6)\n",
        "STD:HelpSearch    EQUATE (7)\n",
        "STD:Help          EQUATE (8)\n",
        "STD:Cut           EQUATE (10)\n",
        "STD:Copy          EQUATE (11)\n",
        "STD:Paste         EQUATE (12)\n",
        "STD:Clear         EQUATE (13)\n",
        "STD:Undo          EQUATE (14)\n",
        "STD:Close         EQUATE (15)\n",
        "STD:PrintSetup    EQUATE (16)\n",
        "STD:TileHorizontal EQUATE (17)\n",
        "STD:TileVertical   EQUATE (18)\n",

        "EVENT:Timer         EQUATE (20BH)\n",
        "EVENT:CloseWindow   EQUATE (201H)\n",
        "EVENT:OpenWindow    EQUATE (203H)\n",
        
        "AppFrame             APPLICATION('FRAME'),AT(,,310,213),HVSCROLL,STATUS(-1,80,120,45),SYSTEM,MAX,RESIZE,IMM,TIMER(10)\n",
        " MENUBAR\n",
        "  MENU('&File'),USE(?FileMenu)\n",
        "    ITEM,SEPARATOR\n",
        "    ITEM('E&xit'),USE(?Exit),MSG('Exit this application'),STD(STD:Close)\n",
        "  END\n",
        "  MENU('&Edit'),USE(?EditMenu)\n",
        "    ITEM('Cu&t'),USE(?Cut),MSG('Remove item to Windows Clipboard'),STD(STD:Cut)\n",
        "    ITEM('&Copy'),USE(?Copy),MSG('Copy item to Windows Clipboard'),STD(STD:Copy)\n",
        "    ITEM('&Paste'),USE(?Paste),MSG('Paste contents of Windows Clipboard'),STD(STD:Paste)\n",
        "  END\n",
        "  MENU('&Window'),MSG('Create and Arrange windows'),STD(STD:WindowList)\n",
        "    ITEM('T&ile'),USE(?Tile),MSG('Make all open windows visible'),STD(STD:TileWindow)\n",
        "    ITEM('&Cascade'),USE(?Cascade),MSG('Stack all open windows'),STD(STD:CascadeWindow)\n",
        "    ITEM('&Arrange Icons'),USE(?Arrange),MSG('Align all window icons'),STD(STD:ArrangeIcons)\n",
        "  END\n",
        "  MENU('&Help'),USE(?Help),RIGHT\n",
        "    ITEM('&About'),USE(?HelpAbout)\n",
        "    ITEM('Debug Event Log'),USE(?HelpDebugEventLog)\n",
        "  END\n",
        " END\n",
        "END\n",
        "    code\n",
        "    open(appframe)\n",
        "    accept\n",
        "        if event()=event:timer then post(event:closewindow).\n",
        "    .\n",
        "    close(appframe)\n",
        "");
        
        runClarionProgram(cl);
    }
    
    public void testReport()
    {
        ClassLoader cl = compile(
        "    program\n",
        
        "PAPER:A4                  EQUATE(9)       ! A4 210 x 297 mm\n",
        "CHARSET:ANSI            EQUATE (  0)\n",
        "FONT:bold               EQUATE (700)\n",
        "COLOR:black             EQUATE (0000000H)\n",
        
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
        
        "mypreview queue\n",
        "entry   string(64)\n",
        ".\n",
        
        "Report REPORT('C8 Sales/Profit Report'),AT(1000,1250,9688,6000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial',10,,), |\n",
        "         LANDSCAPE,THOUS,preview(mypreview)\n",
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
        "MyBreak  break(loop2)\n",
        "Part   DETAIL,AT(,,,146)                !STRING(@s30),AT(1552,-10),USE(String19,,?String19:2),TRN,FONT(,8,,,CHARSET:ANSI)\n",
        "         STRING(@N-13.2),AT(6354,-21,740,188),USE(pl:ssold,,?pl:ssold:2),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
        "         STRING(@N-13.2),AT(8135,-21,740,188),USE(pl:sprofit,,?pl:sprofit:2),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
        "         STRING(@N-7.2),AT(4479,-21,479,188),USE(dordper),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
        "         STRING(@n6),AT(4000,-21,333,188),USE(pl:dqty),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
        "         STRING(@N-7.2),AT(8969,-21,469,188),USE(profitper),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
        "         STRING(@s1),AT(4354,-21),USE(pl:carried),TRN,FONT(,8,,,CHARSET:ANSI)\n",
        "         STRING(@N-13.2),AT(7198,-21,740,188),USE(pl:sdiscount,,?pl:sdiscount:2),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI),sum,tally(mybreak),reset(mybreak)\n",
        "         STRING(@s20),AT(271,-21),USE(pl:format),TRN,FONT(,8,,,CHARSET:ANSI)\n",
        "         STRING(@s30),AT(1552,-21,1802,188),USE(pl:desc),TRN,FONT(,8,,,CHARSET:ANSI)\n",
        "          STRING(@n6),AT(3448,-21,396,188),USE(pl:sqty,,?pl:sqty:2),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
        "         STRING(@N-13.2),AT(5573,-10,740,188),USE(pl:scost,,?pl:scost:2),TRN,DECIMAL(200),FONT(,8,,,CHARSET:ANSI)\n",
        "         STRING(@n6),AT(5083,-21,396,188),USE(pl:rqty),TRN,RIGHT,FONT(,8,,,CHARSET:ANSI)\n",
        "       END\n",
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
        "   open(report)\n",
        "   print(rpt:franchhead)\n",
        "   print(rpt:part)\n",
        "   print(rpt:franchfoot)\n",
        "   print(rpt:grandtotal)\n",
        "   endpage(report)\n",
        "");
        
        runClarionProgram(cl);
        
        ClarionReport cr = (ClarionReport)getMainObject(cl,"report");
        ClarionQueue cq = (ClarionQueue)getMainObject(cl,"mypreview");
        
        assertEquals(1,cq.records());
        cq.get(1);
        
        ClarionWindow.suppressWindowSizingEvents=true;
        ClarionWindow cw = new ClarionWindow();
        cw.setText("Test");
        cw.setAt(0,0,500,300);
        ImageControl ic=new ImageControl();
        ic.setHVScroll().setAt(0,0,500,300);
        cw.add(ic);
        
        cw.open();
        ic.setProperty(Prop.TEXT,cq.what(1).toString().trim());
        
        assertTrue(cw.accept());
        assertEquals(Event.OPENWINDOW,CWin.event());
        cw.consumeAccept();

        cw.setTimer(500);
        assertTrue(cw.accept());
        assertEquals(Event.TIMER,CWin.event());
        cw.consumeAccept();
        
        cw.close();

        //cr.setProperty(org.jclarion.clarion.constants.Prop.FLUSHPREVIEW,true);
        cr.close();
        
        
    }
    
    public void testAccessUseAcrossWideScopeBoundary()
    {
        compile(
        "      program\n",
        "PROP:Text           EQUATE(7C00H)  \n",
        "PROP:Xpos           EQUATE(7C02H)  ! integer, equivalent to PROP:At[1]\n",
        
        "C8DocketLine    string(40)\n",
        "C8DocketControl string(40)\n",
        "        \n",
        "C8DocketReport REPORT,AT(0,0,,32767),PRE(C8DR),THOUS\n",
        "Line   DETAIL,USE(?C8DR:Line)\n",
        "         STRING(@s40),AT(0,0),USE(C8DocketLine)\n",
        "       END\n",
        "BlankLine DETAIL,USE(?C8DR:BlankLine)\n",
        "         STRING(' '),AT(0,0),USE(?C8DocketBlankLine)\n",
        "       END\n",
        "Control DETAIL,USE(?C8DR:Control)\n",
        "         STRING(@s40),AT(0,0),USE(C8DocketControl)\n",
        "       END\n",
        "     END\n",
        "",
        "myclass class\n",
        "mymethod procedure\n",
        "mIndent  long\n",
        ".\n",
        "    code\n",
        "    myclass.mymethod()\n",
        "myclass.mymethod procedure\n",
        "    code\n",
        "    ?C8DocketLine{prop:text}='hello'\n",
        "    ?C8DR:Line{prop:xpos}=SELF.mIndent\n",
        "");
    }
    
    public void testWindowProperty()
    {
        compile(
                "      program\n",
                "mywin window\n",
                ".\n",
                "      map\n",
                "testit procedure(short id,window win)\n",
                "     .\n",
                "   code\n",
                "   testit(10,mywin)\n",
                "testit procedure(short id,window win)\n",
                "   code\n",
                "   win$id{1}='hello'\n",
        "");
    }
    
    public void testSetPropertyIsNotMutable()
    {
        ClassLoader cl = compile(
                "      program\n",
                "mywin window\n",
                ".\n",
                "myval  long\n",
                "myat   long(7c02h)\n",
                "      code\n",
                "      open(mywin)\n",
                "      myval=1\n",
                "      create(2,5)\n",
                "      2{myat,1}=myval\n",
                "      myval=2\n",
                "      assert(2{myat,1}=1,'Test Failed:'& (2{myat,1}))\n",
                "      close(mywin)\n",
            "");
        runClarionProgram(cl);
        
    }

    public void testSetPropertyFromNull()
    {
        ClassLoader cl = compile(
                "      program\n",
                "mywin window\n",
                ".\n",
                "myval  &long\n",
                "myat   long(7c02h)\n",
                "      code\n",
                "      open(mywin)\n",
                "      create(2,5)\n",
                "      2{myat,1}=1\n",
                "      assert(2{myat,1}=1,'#1')\n",
                "      2{myat,1}=myval\n",
                "      assert(2{myat,1}=0,'#2')\n",
                "      myval&=new long\n",
                "      myval=3\n",
                "      2{myat,1}=myval\n",
                "      assert(2{myat,1}=3,'#3')\n",
                "      myval=4\n",
                "      assert(2{myat,1}=3,'#4')\n",
                "      close(mywin)\n",
            "");
        
        System.out.println(ClassRepository.get("Main").toJavaSource());
        
        runClarionProgram(cl);
        
    }
    
    public void testSetPropertyFromConstant()
    {
        ClassLoader cl = compile(
                "      program\n",
                "mywin window\n",
                ".\n",
                "myval  equate(1)\n",
                "myat   long(7c02h)\n",
                "      code\n",
                "      open(mywin)\n",
                "      create(2,5)\n",
                "      2{myat,1}=myval\n",
                "      assert(2{myat,1}=1,'Test Failed:'& (2{myat,1}))\n",
                "      close(mywin)\n",
            "");
        runClarionProgram(cl);
        
    }

    public void testSetPropertyFromUseVar()
    {
        ClassLoader cl = compile(
                "      program\n",
                "mywin window\n",
                "mystring   string('hello'),use(?mystring)\n",
                ".\n",
                "myval  equate(1)\n",
                "myat   long(7c02h)\n",
                "      code\n",
                "      open(mywin)\n",
                "      create(2,5)\n",
                "      2{myat,1}=?mystring\n",
                "      assert(2{myat,1}=1,'Test Failed:'& (2{myat,1}))\n",
                "      close(mywin)\n",
            "");
        runClarionProgram(cl);
        
    }

    public void testSetPropertyFromObject()
    {
        ClassLoader cl = compile(
                "      program\n",
                "    map\n",
                "myfunc  procedure(*?)\n",
                "    .\n",
                "mywin window\n",
                ".\n",
                "myval  long\n",
                "myat   long(7c02h)\n",
                "      code\n",
                "      open(mywin)\n",
                "      myval=1\n",
                "      create(2,5)\n",
                "      myfunc(myval)\n",
                "      myval=2\n",
                "      assert(2{myat,1}=1,'Test Failed:'& (2{myat,1}))\n",
                "      close(mywin)\n",
                "myfunc procedure(*? mv)\n",
                "     code\n",
                "     2{myat,1}=mv\n",
            "");
        runClarionProgram(cl);
        
    }

    public void testSetPropertyFromObjectNotRef()
    {
        ClassLoader cl = compile(
                "      program\n",
                "    map\n",
                "myfunc  procedure(?)\n",
                "    .\n",
                "mywin window\n",
                ".\n",
                "myval  long\n",
                "myat   long(7c02h)\n",
                "      code\n",
                "      open(mywin)\n",
                "      myval=1\n",
                "      create(2,5)\n",
                "      myfunc(myval)\n",
                "      myval=2\n",
                "      assert(2{myat,1}=1,'Test Failed:'& (2{myat,1}))\n",
                "      close(mywin)\n",
                "myfunc procedure(*? mv)\n",
                "     code\n",
                "     2{myat,1}=mv\n",
            "");
        runClarionProgram(cl);
    }

    public void testSetUsePropertyWorksAsExpected()
    {
        ClassLoader cl = compile(
                "      program\n",
                "myval1  long\n",
                "myval2  long\n",
                "Prop:use           equate(7a10h)\n",
                "prop:screentext    equate(7cbah)\n",
                "mywin window\n",
                "      string(@n10),use(myval1)\n",
                ".\n",
                "      code\n",
                "      open(mywin)\n",
                "      myval1=1\n",
                "      myval2=2\n",
                "      display\n",
                "      assert(?myval1{prop:screentext}='1','assert #1')",
                "      ?myval1{prop:use}=myval2\n",
                "      assert(?myval1{prop:screentext}=2,'assert #2')",
                "      myval1=3\n",
                "      myval2=4\n",
                "      display\n",
                "      assert(?myval1{prop:screentext}=4,'assert #3')",
                "      close(mywin)\n",
            "");
        
        System.out.println(ClassRepository.get("Main").toJavaSource());
        
        runClarionProgram(cl);
    }
    
}
