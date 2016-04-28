2016-02-11 generating code from winlats.app and .dct

           i. winlats026.clw is not compiling due to INCLUDE('REGSTR.REG'), commented out!
              change is in procedure gl_cont
           ii. after this change it goes up to linking but hangs on ga1.lib

--------------------------- error description
CAUSE: did not support ARRAYS in as formal procedure definitions

winlats.clw
===========
     MODULE('winla234.clw')
       GETBIL_FIFO(BYTE,*DECIMAL,*DECIMAL,*DECIMAL[]),BYTE      <-----
       IZZFILTbilform 
       SPZ_Invoice
     END
         
WINLA234.clw
============
GETBIL_FIFO          FUNCTION (OPC,BILVERT,DAUDZUMS,ATLIKUMS_N) ! Declare Procedure
....
CLEAR(ATLIKUMS_N)
........
ATLIKUMS_N[FIFO:NOL_NR]+=FIFO:DAUDZUMS


         
         
           
->   rbrack:]
     rparam:)
     param:,
     label:BYTE
     nl:

     ws:       
     label:IZZFILTbilform
     ws: 
     nl:

     ws:       
     label:SPZ_Invoice
     nl:

     ws:     
     label:END
     nl:

==========
org.jclarion.clarion.lang.ClarionCompileError: Expected ')' near line:745 (winlats.clw)








---------------------------------------------------------------------------------------------------------------------------------------------
CAUSE: didnt support RECLAIM. NAME must be revisited to avoid backslashes.

ERROR:Expected EOL near line:1580 (winlats.clw)
DEBUG:Expected EOL near line:1580 (winlats.clw) WS:true
==========
->   param:,
     label:RECLAIM
     param:,
     label:NAME
     lparam:(
     string:"\\winlats\\bin\\kludas"
     rparam:)
     param:,
     label:PRE
     lparam:(
     label:KLU
==========
org.jclarion.clarion.lang.ClarionCompileError: Expected EOL near line:1580 (winlats.clw)


KLUDAS                  FILE,DRIVER('TOPSPEED'),RECLAIM,NAME('\winlats\bin\kludas'),PRE(KLU),CREATE,BINDABLE,THREAD


---------------------------------------------------------------------------------------------------------------------------------------------
CAUSE: Didnt support OEM

DEBUG:Expected EOL near line:1633 (winlats.clw) WS:true
==========
->   param:,
     label:OEM
     param:,
     label:NAME
     lparam:(
     label:ASCIIFILENAME
     rparam:)
     param:,
     label:PRE
     lparam:(
     label:OUT
==========
org.jclarion.clarion.lang.ClarionCompileError: Expected EOL near line:1633 (winlats.clw)


----------------------------------------------------------------------------------------------------------------------
ENCRYPT is not supported!

DEBUG:Expected EOL near line:2046 (winlats.clw) WS:true
==========
->   param:,
     label:ENCRYPT
     param:,
     label:NAME
     lparam:(
     string:"PAROLES"
     rparam:)
     param:,
     label:PRE
     lparam:(
     label:SEC
==========
org.jclarion.clarion.lang.ClarionCompileError: Expected EOL near line:2046 (winlats.clw)




--------------------------------------------------------------------------------------------------
Expection EOF near line.
Commenting out following code helps.
!  SystemParametersInfo( 38, 0, lCurrentFDSetting, 0 )
!  IF lCurrentFDSetting = 1
!    SystemParametersInfo( 37, 0, lAdjFDSetting, 3 )
!  END
  Main
!IF lCurrentFDSetting = 1
!  SystemParametersInfo( 37, 1, lAdjFDSetting, 3 )
!END

-------------------------------------------------------------------------------------------------------
CAUSE: DID NOT SUPPORT LIKE AND DIM at same time! 

Replacing like with specific type gives compiled result
! BRW1::Sort2:KeyDistribution LIKE(NOD:U_NR),DIM(100)
BRW1::Sort2:KeyDistribution STRING(2),DIM(100)




BRW1::Sort2:KeyDistribution LIKE(NOD:U_NR),DIM(100)

RROR:Unhandled type:dim near line:434 (winla001.clw)
DEBUG:Unhandled type:dim near line:434 (winla001.clw) WS:true
==========
   * label:BRW1::Sort2:KeyDistribution
     ws: 
     label:LIKE
     lparam:(
     label:NOD:U_NR
     rparam:)
     param:,
     label:DIM
     lparam:(
     integer:100
     rparam:)
->   nl:

     label:BRW1::Sort2:LowValue
     ws: 
     label:LIKE
     lparam:(
     label:NOD:U_NR
     rparam:)
     ws:               
     comment:! Queue position of scroll thumb
     nl:

     label:BRW1::Sort2:HighValue
     ws: 
     label:LIKE
     lparam:(
==========
org.jclarion.clarion.lang.ClarionCompileError: Unhandled type:dim near line:434 (winla001.clw)


org.jclarion.clarion.lang.ClarionCompileError: Unhandled type:dim near line:434 (winla001.clw)
	at org.jclarion.clarion.lang.Lexer.error(Lexer.java:218)
	at org.jclarion.clarion.compile.grammar.FailFastErrorCollator.error(FailFastErrorCollator.java:13)
	at org.jclarion.clarion.compile.grammar.AbstractParser.error(AbstractParser.java:113)
	at org.jclarion.clarion.compile.grammar.VariableParser.dataDefinition(VariableParser.java:295)
	at org.jclarion.clarion.compile.grammar.VariableParser.getVariable(VariableParser.java:574)
	at org.jclarion.clarion.compile.grammar.Parser.procedureImplementation(Parser.java:392)
	at org.jclarion.clarion.compile.grammar.Parser.compileModuleFile(Parser.java:231)
	at org.jclarion.clarion.compile.grammar.Parser.compileModules(Parser.java:276)
	at org.jclarion.clarion.compile.grammar.Parser.compileProgram(Parser.java:185)
	at org.jclarion.clarion.compile.ClarionCompiler.compile(ClarionCompiler.java:198)
	at org.jclarion.clarion.compile.ClarionCompiler.main(ClarionCompiler.java:280)
org.jclarion.clarion.lang.ClarionCompileError: org.jclarion.clarion.lang.ClarionCompileError: Unhandled type:dim near line:434 (winla001.clw)
	at org.jclarion.clarion.compile.grammar.Parser.compileModuleFile(Parser.java:243)
	at org.jclarion.clarion.compile.grammar.Parser.compileModules(Parser.java:276)
	at org.jclarion.clarion.compile.grammar.Parser.compileProgram(Parser.java:185)
	at org.jclarion.clarion.compile.ClarionCompiler.compile(ClarionCompiler.java:198)
	at org.jclarion.clarion.compile.ClarionCompiler.main(ClarionCompiler.java:280)
Caused by: org.jclarion.clarion.lang.ClarionCompileError: Unhandled type:dim near line:434 (winla001.clw)
	at org.jclarion.clarion.lang.Lexer.error(Lexer.java:218)
	at org.jclarion.clarion.compile.grammar.FailFastErrorCollator.error(FailFastErrorCollator.java:13)
	at org.jclarion.clarion.compile.grammar.AbstractParser.error(AbstractParser.java:113)
	at org.jclarion.clarion.compile.grammar.VariableParser.dataDefinition(VariableParser.java:295)
	at org.jclarion.clarion.compile.grammar.VariableParser.getVariable(VariableParser.java:574)
	at org.jclarion.clarion.compile.grammar.Parser.procedureImplementation(Parser.java:392)
	at org.jclarion.clarion.compile.grammar.Parser.compileModuleFile(Parser.java:231)
	... 4 more
Exception in thread "main" org.jclarion.clarion.lang.ClarionCompileError: org.jclarion.clarion.lang.ClarionCompileError: org.jclarion.clarion.lang.ClarionCompileError: Unhandled type:dim near line:434 (winla001.clw)
	at org.jclarion.clarion.compile.grammar.Parser.compileProgram(Parser.java:196)
	at org.jclarion.clarion.compile.ClarionCompiler.compile(ClarionCompiler.java:198)
	at org.jclarion.clarion.compile.ClarionCompiler.main(ClarionCompiler.java:280)
Caused by: org.jclarion.clarion.lang.ClarionCompileError: org.jclarion.clarion.lang.ClarionCompileError: Unhandled type:dim near line:434 (winla001.clw)
	at org.jclarion.clarion.compile.grammar.Parser.compileModuleFile(Parser.java:243)
	at org.jclarion.clarion.compile.grammar.Parser.compileModules(Parser.java:276)
	at org.jclarion.clarion.compile.grammar.Parser.compileProgram(Parser.java:185)
	... 2 more
Caused by: org.jclarion.clarion.lang.ClarionCompileError: Unhandled type:dim near line:434 (winla001.clw)
	at org.jclarion.clarion.lang.Lexer.error(Lexer.java:218)
	at org.jclarion.clarion.compile.grammar.FailFastErrorCollator.error(FailFastErrorCollator.java:13)
	at org.jclarion.clarion.compile.grammar.AbstractParser.error(AbstractParser.java:113)
	at org.jclarion.clarion.compile.grammar.VariableParser.dataDefinition(VariableParser.java:295)
	at org.jclarion.clarion.compile.grammar.VariableParser.getVariable(VariableParser.java:574)
	at org.jclarion.clarion.compile.grammar.Parser.procedureImplementation(Parser.java:392)
	at org.jclarion.clarion.compile.grammar.Parser.compileModuleFile(Parser.java:231)
	... 4 more

-----------------------------------------------------------------------------------------------------------
  ! ITEM('&4-FTP:WinLats lejupl�de no www.assako.lv'),USE(?1Seanss4FTP),HIDE ! didn't like identifiers starting with number
  ITEM('&4-FTP:WinLats lejupl�de no www.assako.lv'),USE(?1Seanss4FTP)


-----------------------------------------------------------------------------------------------------------
CAUSE: LAST not supported
   MENU('&Z-Izzi�as no failiem'),USE(?FailiIzzinasnofailiem2),LAST


ERROR:Expected EOL near line:1694 (winla001.clw)
DEBUG:Expected EOL near line:1694 (winla001.clw) WS:true
==========
->   param:,
     label:LAST
     nl:

     ws:                             
     label:ITEM
     lparam:(
     string:"&1-Partneru saraksts"
     rparam:)
     param:,
     label:USE
     lparam:(
     use:?
==========
org.jclarion.clarion.lang.ClarionCompileError: Expected EOL near line:1694 (winla001.clw)
----------------------------------------------------------------------------------------------------------------
CAUSE: Such expressions are provided AppFrame{PROP:TEXT}?

  IF GNET
    AppFrame{PROP:TEXT}='WinLats '&DB_GADS&'.g. Global Net Client.NET Nr:'&clip(gnet)&' Taka: '&CLIP(LONGpath())&'  '&CLIENT
  ELSE
    IF BAND(REG_BASE_ACC,00000010b) ! Bud�ets
      AppFrame{PROP:TEXT}='WinLats Bud�ets v3.02 '&DB_GADS&'.'&FING&' Local Net Client  Taka: '&CLIP(LONGpath())&'  '&CLIENT
    ELSE
      AppFrame{PROP:TEXT}='WinLats v3.02 '&DB_GADS&'.'&FING&' Local Net Client  Taka: '&CLIP(LONGpath())&'  '&CLIENT
    .
  .
--------------------------------------------------------------------------------------------------------------------------
                  CLOSE(OUTFILEANSI)
 !                 RUN('c:\windows\system32\ftp.exe -s:TEMP.TXT www.assako.lv',1) !GAID�T COMPLETE
                  IF RUNCODE()
 !                    STOP('c:\windows\system32\ftp.exe '&ERROR())
                     BREAK
                  ELSE
                     FILENAME1=LONGPATH()
                     FILENAME1=FILENAME1[1:3]&'WINLATS\BIN'
 !                    COPY('WINLATS.ARJ',CLIP(FILENAME1)&'\WINLATS.ARJ')   !NO TEKO�� UZ \BIN
                     IF ERROR()
 !                       STOP('COPY '&CLIP(LONGPATH())&'\WINLATS.ARJ uz '&FILENAME1&'\WINLATS.ARJ '&ERROR())
                        BREAK
                     .
                  .
----------------------------------------------------------------------------------------------------------------------------
















Following classes deal with "dim"
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/scope/Scope.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/grammar/StatementParser.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/grammar/ExprParser.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/grammar/VariableParser.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/javaimport/DefaultJavaImporter.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/javaimport/MethodImport.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/javaimport/JavaImporter.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/javaimport/FieldImport.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/var/ReferenceVariable.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/var/ClassedVariable.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/var/Variable.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/var/SimpleVariable.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/expr/ExprType.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/expr/SystemExprType.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/expr/DanglingExprType.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/expr/ClassedExprType.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/expr/FilledExprType.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/expr/DumbExprType.java
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/expr/RawExprType.java

This is LIKE() variable
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/var/LikeVariable.java
Something about array 
/home/robertsp/java/clarion2java/jclarion.netbeans.sf2/compiler/trunk/src/main/java/org/jclarion/clarion/compile/expr/ArrayExpr.java
           