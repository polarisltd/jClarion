!Acsii Viewer Code

   MEMBER

   MAP
AddRecord      PROCEDURE(AsciiFileClass SELF)             !adds a record to the index queue
IdxExtend      PROCEDURE(AsciiFileClass SELF)             !extends the file index to eof
IdxExtend      PROCEDURE(AsciiFileClass SELF,LONG LineNo),BYTE,PROC !extends the file index to lineNo, returns true if requested line is greater than the number of lines in the file
SetSequence    PROCEDURE(AsciiFileClass SELF)             !sets up sequenctial processing of file
   END

  INCLUDE('ABASCII.INC'),ONCE
  INCLUDE('KEYCODES.CLW'),ONCE
  INCLUDE('ERRORS.CLW'),ONCE
  INCLUDE('ABFILE.INC'),ONCE
  INCLUDE('ABUTIL.INC'),ONCE
  INCLUDE('ABREPORT.INC'),ONCE

IndexQueue          QUEUE,TYPE
Offset                LONG
Length                USHORT
                    END

DisplayQueue        QUEUE,TYPE
Line                  STRING(255)
                    END


AsciiFileClass.Init PROCEDURE(FILE AsciiFile,*STRING FileLine,*STRING FName,ErrorClass ErrorHandler)

  CODE
  SELF.OpenMode=ReadOnly+DenyNone
  SELF.AsciiFile&=AsciiFile
  SELF.Line&=FileLine
  SELF.ErrorMgr&=ErrorHandler
  SELF.IndexQueue&=NEW(IndexQueue)
  IF ~SELF.Reset(FName)
    SELF.Kill
    RETURN False
  END
  RETURN True


AsciiFileClass.Reset PROCEDURE(*STRING FName)

RVal      BYTE(False)
SavePath  CSTRING(FILE:MaxFilePath+1),AUTO

  CODE
  CLOSE(SELF.AsciiFile)
  FREE(SELF.IndexQueue)
  SavePath=PATH()
  LOOP
    IF ~FName AND ~SELF.GetDOSFilename(FName) THEN BREAK.
    OPEN(SELF.AsciiFile,SELF.OpenMode)
    IF ERRORCODE()
      IF ~INLIST(SELF.ErrorMgr.Throw(Msg:FileLoadFailed),Level:Benign,Level:User) THEN BREAK.
    ELSE
      RVal=True
    END
  UNTIL RVal=True
  IF RVal
    SELF.FileSize=BYTES(SELF.AsciiFile)
    SELF.ErrorMgr.SetFile(NAME(SELF.AsciiFile))
  END
  SETPATH(SavePath)
  RETURN RVal


AsciiFileClass.Kill PROCEDURE

  CODE
  DISPOSE(SELF.IndexQueue)
  CLOSE(SELF.AsciiFile)


!This function gets a line at position LineNo from the Ascii file, extending the index queue as
!required. If the index queue already contains the requested line number then the file is read
!using the existing offset, otherwise th index is extended. If the requested LineNo does not
!exist in the file, the text line is cleared and ERRORCODE() set.
AsciiFileClass.GetLine PROCEDURE(LONG LineNo)

  CODE
  ASSERT(LineNo>0)
  IdxExtend(SELF,LineNo)
  GET(SELF.IndexQueue,LineNo)
  IF ~ERRORCODE()
    GET(SELF.AsciiFile,SELF.IndexQueue.Offset)
    ASSERT(~ERRORCODE())
    SELF.FormatLine(SELF.Line,LineNo)
  END
  RETURN SELF.Line


!This function processes the whole file until the last record is encounted, returning its line
!position, taking into account already indexed items and active filters.
AsciiFileClass.GetLastLineNo PROCEDURE()

  CODE
  IdxExtend(SELF)
  RETURN RECORDS(SELF.IndexQueue)


!This function returns the approximate percentage through the file that LineNo occurs at. Returns 0
!if LineNo=0 and 100 if LineNo>number of filtered lines in the file. Useful for calibrating vertical
!scroll bars.
AsciiFileClass.GetPercentile PROCEDURE(LONG LineNo)

  CODE
  IF LineNo>0
    IdxExtend(SELF,LineNo)
    IF LineNo<=RECORDS(SELF.IndexQueue)
      GET(SELF.IndexQueue,LineNo)
      ASSERT(~ERRORCODE())
      RETURN (SELF.IndexQueue.Offset/SELF.FileSize)*100
    ELSE
      RETURN 100
    END
  END
  RETURN 0


!This procedure synronises the 'focus record' with a given percentage through the file(usually
!the vertical thumb position). The index is extended as required and the the virtual SetLine
!procedure is called with the line number that is the required percentage of the way through the
!file.
AsciiFileClass.SetPercentile PROCEDURE(USHORT Percentage)

TargetLine     LONG(0)
TargetOffset   LONG,AUTO
LCnt           LONG(1)

  CODE
  TargetOffset=SELF.FileSize*(Percentage/100)
  IF TargetOffset>SELF.FileSize THEN TargetOffset=SELF.FileSize.
  IF TargetOffset=SELF.FileSize
    TargetLine=SELF.GetLastLineNo()
  ELSIF TargetOffset=0
    TargetLine=1
  ELSE
    LOOP
      IF LCnt<RECORDS(SELF.IndexQueue)
        GET(SELF.IndexQueue,LCnt)
        ASSERT(~ERRORCODE())
      ELSE
        IF IdxExtend(SELF,RECORDS(SELF.IndexQueue)+1) THEN BREAK.
      END
      LCnt+=1
    UNTIL INRANGE(TargetOffset,SELF.IndexQueue.Offset,SELF.IndexQueue.Offset+SELF.IndexQueue.Length-1)
    TargetLine=POINTER(SELF.IndexQueue)
  END
  SELF.SetLine(TargetLine)


AsciiFileClass.GetFilename PROCEDURE()

  CODE
  RETURN NAME(SELF.AsciiFile)


AsciiFileClass.FormatLine PROCEDURE(*STRING TextLine) !Place holder for users Virtual function

  CODE


AsciiFileClass.FormatLine PROCEDURE(*STRING TextLine,LONG LineNo) !Place holder for users Virtual function

  CODE
  SELF.FormatLine(TextLine)


AsciiFileClass.SetLine PROCEDURE(LONG LineNo) !Place holder for Virtual function

  CODE


AsciiFileClass.ValidateLine PROCEDURE(STRING LineToTest)

  CODE
  RETURN True


AsciiFileClass.GetDOSFilename PROCEDURE(*STRING DestVar)

DOSLookup   SelectFileClass

  CODE
  DOSLookup.Init
  DOSLookup.AddMask('Text files|*.Txt|All files|*.*')
  DOSLookup.WindowTitle='Select an Ascii File'
  DOSLookup.Flags=FILE:LongName
  DestVar=DOSLookup.Ask()
  RETURN CHOOSE(DestVar<>'')


IdxExtend PROCEDURE(AsciiFileClass SELF)

  CODE
  IdxExtend(SELF,0)


IdxExtend PROCEDURE(AsciiFileClass SELF,LONG LineNo)

  CODE
  IF LineNo>RECORDS(SELF.IndexQueue) OR LineNo=0
    SetSequence(SELF)
    LOOP
      IF LineNo AND RECORDS(SELF.IndexQueue)>LineNo THEN BREAK.
      NEXT(SELF.AsciiFile)
      IF ERRORCODE() THEN RETURN True.
      AddRecord(SELF)
    END
  END
  RETURN False


AddRecord PROCEDURE(AsciiFileClass SELF)

  CODE
  IF SELF.ValidateLine(SELF.Line)
    SELF.IndexQueue.Offset=POINTER(SELF.AsciiFile)
    SELF.IndexQueue.Length=BYTES(SELF.AsciiFile)
    ADD(SELF.IndexQueue)
    ASSERT(ERRORCODE()=NoError)
  END


SetSequence PROCEDURE(AsciiFileClass SELF)

  CODE
  IF RECORDS(SELF.IndexQueue)
    GET(SELF.IndexQueue,RECORDS(SELF.IndexQueue))
    ASSERT(ERRORCODE()=NoError)
    SET(SELF.AsciiFile,SELF.IndexQueue.Offset)
    NEXT(SELF.AsciiFile)
  ELSE
    SET(SELF.AsciiFile)
  END


!-Ascii Viewer Code-----------------------------------------------------------------------


AsciiViewerClass.Init PROCEDURE(FILE AsciiFile,*STRING FileLine,UNSIGNED ListBox,ErrorClass ErrHandler,BYTE Enables=0)

Filename  STRING(File:MaxFilePath),AUTO

  CODE
  FileName=NAME(AsciiFile)
  ASSERT(FileName)
  RETURN SELF.Init(AsciiFile,FileLine,Filename,ListBox,ErrHandler,Enables)


AsciiViewerClass.Init PROCEDURE(FILE AsciiFile,*STRING FileLine,*STRING Filename,UNSIGNED ListBox,ErrorClass ErrHandler,BYTE Enables=0)

c USHORT,AUTO

  CODE
  SELF.ListBox=ListBox
  SELF.ListBoxItems=SELF.ListBox{PROP:Items}
  IF ~PARENT.Init(AsciiFile,FileLine,Filename,ErrHandler) THEN RETURN False.     !FileMgr Init failed
  SELF.DisplayQueue&=NEW(DisplayQueue)
  SELF.LBPreserve.HScrollState=SELF.ListBox{PROP:HScroll}
  SELF.LBPreserve.HScrollPos=SELF.ListBox{PROP:HScrollPos}
  SELF.LBPreserve.VScrollState=SELF.ListBox{PROP:VScroll}
  SELF.LBPreserve.VScrollPos=SELF.ListBox{PROP:VScrollPos}
  SELF.LBPreserve.IMMState=SELF.ListBox{PROP:IMM}
  SELF.LBPreserve.Format=SELF.ListBox{PROP:Format}
  LOOP c=251 TO 253
    SELF.LBPreserve.Alrt[c-250]=SELF.ListBox{PROP:Alrt,c}
  END
  SELF.ListBox{PROP:From}=SELF.DisplayQueue
  SELF.ListBox{PROP:Format}=''
  SELF.ListBox{PROP:HScroll}=True
  SELF.ListBox{PROP:Alrt,251}=MouseRightUp
  SELF.ListBox{PROP:Alrt,252}=CtrlPgUp
  SELF.ListBox{PROP:Alrt,253}=CtrlPgDn
  SELF.ListBox{PROP:Imm}=True
  SELF.ListBox{PROP:VScroll}=True
  IF BAND(Enables,EnableSearch)
    SELF.SearcherSelfCreated=True
    SELF.Searcher &= NEW AsciiSearchClass
    SELF.Searcher.Init(SELF)
  END
  IF BAND(Enables,EnablePrint)
    SELF.Printer &= NEW AsciiPrintClass
    SELF.Printer.Init(SELF)
    SELF.PrinterSelfCreated=True
  END
  SELF.Popup &= NEW PopupClass
  SELF.Popup.Init
  SELF.Popup.AddMenu('~&Find|~&Print|-|&Move{{&Top|Page &Up|Page &Down|Bottom}|-|&Goto')
  SELF.Popup.SetItemEnable('Find',CHOOSE(BAND(Enables,EnableSearch)))
  SELF.Popup.SetItemEnable('Print',CHOOSE(BAND(Enables,EnablePrint)))
  SELF.Popup.AddItemEvent('Top',EVENT:ScrollTop,ListBox)
  SELF.Popup.AddItemEvent('PageUp',EVENT:PageUp,ListBox)
  SELF.Popup.AddItemEvent('PageDown',EVENT:PageDown,ListBox)
  SELF.Popup.AddItemEvent('Bottom',EVENT:ScrollBottom,ListBox)
  RETURN SELF.Reset(Filename)


AsciiViewerClass.Kill PROCEDURE

c USHORT,AUTO

  CODE
  SELF.ListBox{PROP:HScroll}=SELF.LBPreserve.HScrollState     !restore list box settings
  SELF.ListBox{PROP:HScrollPos}=SELF.LBPreserve.HScrollPos
  SELF.ListBox{PROP:VScroll}=SELF.LBPreserve.VScrollState
  SELF.ListBox{PROP:VScrollPos}=SELF.LBPreserve.VScrollPos
  SELF.ListBox{PROP:IMM}=SELF.LBPreserve.IMMState
  SELF.ListBox{PROP:Format}=SELF.LBPreserve.Format
  LOOP c=251 TO 253
    SELF.ListBox{PROP:Alrt,c}=SELF.LBPreserve.Alrt[c-250]
  END
  PARENT.Kill                                                 !kill FileMgr
  DISPOSE(SELF.DisplayQueue)
  SELF.ListBox{PROP:From}=''
  SELF.Popup.Kill
  DISPOSE(SELF.Popup)
  IF SELF.SearcherSelfCreated=True THEN
     DISPOSE(SELF.Searcher)
  END
  IF SELF.PrinterSelfCreated=True THEN
     DISPOSE(SELF.Printer)
  END



AsciiViewerClass.AddItem PROCEDURE(AsciiPrintClass Printer)

  CODE
  IF SELF.PrinterSelfCreated=True THEN
     DISPOSE(SELF.Printer)
     SELF.PrinterSelfCreated=False
  END
  SELF.Printer &= Printer
  SELF.Printer.Init(SELF)
  SELF.Popup.SetItemEnable('Print',True)


AsciiViewerClass.AddItem PROCEDURE(AsciiSearchClass Searcher)

  CODE
  IF SELF.SearcherSelfCreated=True THEN
     DISPOSE(SELF.Searcher)
     SELF.SearcherSelfCreated=False
  END
  SELF.Searcher &= Searcher
  SELF.Searcher.Init(SELF)
  SELF.Popup.SetItemEnable('Find',True)


AsciiViewerClass.SetTranslator PROCEDURE(TranslatorClass T)

  CODE
  SELF.Translator &= T
  IF ~SELF.Searcher&=NULL
    SELF.Searcher.Translator &= T
  END
  IF ~SELF.Printer&=NULL
    SELF.Printer.Translator &= T
  END
  SELF.Popup.SetTranslator(T)


AsciiViewerClass.Reset PROCEDURE(*STRING Filename)

  CODE
  FREE(SELF.DisplayQueue)
  DISPLAY(SELF.ListBox)
  IF ~PARENT.Reset(Filename) THEN RETURN False.
  SELF.TopLine=1
  SELF.SetPercentile(0)
  SELF.DisplayPage
  RETURN True


AsciiViewerClass.TakeEvent PROCEDURE(UNSIGNED EventNo)
  CODE
  IF FIELD()=0                              !Field independant event
    CASE EVENT()
    OF EVENT:Sized
      SELF.DisplayPage
    END
  ELSIF FIELD()=SELF.ListBox
    CASE EventNo
    OF EVENT:NewSelection
      SELF.SetThumb
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF CtrlPgUp
        POST(EVENT:ScrollTop,SELF.ListBox)
      OF CtrlPgDn
        POST(EVENT:ScrollBottom,SELF.ListBox)
      OF MouseRightUp
        CASE SELF.Popup.Ask()
        OF 'Find'
          SELF.Searcher.Ask(CHOOSE(CHOICE(SELF.listBox)>0,SELF.TopLine+CHOICE(SELF.ListBox)-1,1))
        OF 'Print'
          SELF.Printer.Ask
        OF 'Goto'
          SELF.AskGotoLine
        END
      END
    OF EVENT:ScrollDrag
      SETCURSOR(CURSOR:Wait)
      SELF.SetPercentile(SELF.ListBox{PROP:VScrollPos})
      SETCURSOR
    OF EVENT:Scrollup
      SELF.SetLineRelative(-1)
    OF EVENT:ScrollDown
      SELF.SetLineRelative(1)
    OF EVENT:PageUp
      SELF.PageUp
    OF EVENT:PageDown
      SELF.PageDown
    OF EVENT:ScrollTop
      SELF.DisplayPage(1)
    OF EVENT:ScrollBottom
      SETCURSOR(CURSOR:Wait)
      SELF.DisplayPage(SELF.GetLastLineNo())
      SETCURSOR
    END
    RETURN Level:Notify
  END
  RETURN Level:Benign


AsciiViewerClass.AskGotoLine PROCEDURE

LineNo  LONG,STATIC
OKGo    BYTE(False)

GotoDialog WINDOW('Goto'),AT(,,96,38),FONT('MS Sans Serif',8,,FONT:regular),GRAY,DOUBLE
       SPIN(@n_5),AT(36,4,56,13),USE(LineNo),RANGE(1,99999)
       PROMPT('&Line No:'),AT(4,9,32,10),USE(?Prompt1)
       BUTTON('&Go'),AT(8,22,40,14),TIP('Go to selected Line'),USE(?GoButton)
       BUTTON('&Cancel'),AT(52,22,40,14),TIP('Cancel GoTo operation'),USE(?CancelButton)
     END

  CODE
  OPEN(GotoDialog)
  IF ~SELF.Translator&=NULL THEN SELF.Translator.TranslateWindow.
  ACCEPT
    CASE EVENT()
    OF EVENT:Accepted
      CASE ACCEPTED()
      OF ?GoButton
        OKGo=True
      OROF ?CancelButton
        POST(EVENT:CloseWindow)
      END
    END
  END
  CLOSE(GotoDialog)
  IF OKGo THEN SELF.SetLine(LineNo).


AsciiViewerClass.DisplayPage PROCEDURE

  CODE
  SELF.DisplayPage(SELF.TopLine)


AsciiViewerClass.DisplayPage PROCEDURE(LONG LineNo)

LastPageLine  USHORT,AUTO
RecsQ         LONG,AUTO

  CODE
  SELF.ListBoxItems=SELF.ListBox{PROP:Items}
  IF LineNo>0
    LastPageLine=LineNo+SELF.ListBoxItems-1
    RecsQ=RECORDS(SELF.IndexQueue)
    SELF.GetLine(LastPageLine)
    IF RecsQ<=SELF.ListBoxItems
      SELF.DisplayPage(1,RecsQ,LineNo)
    ELSE
      IF RecsQ>=LastPageLine
        SELF.DisplayPage(LineNo,LastPageLine,1)
      ELSE
        SELF.DisplayPage(RecsQ-SELF.ListBoxItems+1,RecsQ,SELF.ListBoxItems)
      END
    END
  END


!This is a PRIVATE low-level version of DisplayPage, it assumes that StartLine and EndLine are always valid and that
!the file has alreday been indexed up to EndLine, also SelectLine must exist withinc the ListBox
AsciiViewerClass.DisplayPage PROCEDURE(LONG StartLine,LONG EndLine,USHORT SelectLine)

i LONG,AUTO

  CODE
  FREE(SELF.DisplayQueue)
  LOOP i=StartLine TO EndLine
    SELF.DisplayQueue.Line=SELF.GetLine(i)
    ADD(SELF.DisplayQueue)
    ASSERT(~ERRORCODE())
  END
  SELF.TopLine=StartLine
  SELF.SetListboxSelection(SelectLine)


AsciiViewerClass.SetLineRelative PROCEDURE(LONG LineCount)        !-Ve up, +Ve Down

CurSelect   USHORT,AUTO
SelectLine  USHORT,AUTO

  CODE
  CurSelect=SELF.ListBox{PROP:Selected}
  SelectLine=CurSelect
  LOOP ABS(LineCount) TIMES
    IF LineCount<0
      IF CurSelect>1
        SelectLine=CurSelect-1
      ELSE
        IF SELF.TopLine=1 THEN BREAK.
        SELF.TopLine-=1
        SelectLine=1
      END
    ELSE
      IF CurSelect<SELF.ListBoxItems
        IF CurSelect+1<=RECORDS(SELF.IndexQueue)
          SelectLine=CurSelect+1
        END
      ELSE
        SELF.GetLine(SELF.TopLine+SELF.ListBoxItems)
        IF RECORDS(SELF.indexQueue)<SELF.TopLine+SELF.ListBoxItems THEN BREAK.
        SELF.TopLine+=1
        SelectLine=SELF.ListBoxItems
      END
    END
  END
  SELF.DisplayPage(SELF.TopLine)
  SELF.SetListBoxSelection(SelectLine)


AsciiViewerClass.SetListboxSelection PROCEDURE(LONG SelectLine)

  CODE
  IF INRANGE(SelectLine,1,SELF.ListBoxItems)
    SELF.ListBox{PROP:Selected}=SelectLine
    SELF.SetThumb
  END


AsciiViewerClass.PageUp PROCEDURE

  CODE
  IF CHOICE(SELF.ListBox)=1
    SELF.SetLineRelative(-SELF.ListBoxItems)
  ELSE
    SELF.SetListboxSelection(1)
  END


AsciiViewerClass.PageDown PROCEDURE

  CODE
  IF CHOICE(SELF.ListBox)=SELF.ListBoxItems
    SELF.SetLineRelative(SELF.ListBoxItems)
  ELSE
    SELF.SetListboxSelection(CHOOSE(RECORDS(SELF.IndexQueue)<=SELF.ListBoxItems,RECORDS(SELF.IndexQueue),SELF.ListBoxItems))
  END


AsciiViewerClass.SetThumb PROCEDURE

  CODE
  SELF.ListBox{PROP:VScrollPos}=SELF.GetPercentile(SELF.TopLine+CHOICE(SELF.ListBox)-1)


AsciiViewerClass.SetLine PROCEDURE(LONG LineNo)         !sync list box with line no provided by external source

  CODE
  SELF.DisplayPage(LineNo)
  SELF.SetListboxSelection(CHOOSE(LineNo-SELF.TopLine+1<=RECORDS(SELF.DisplayQueue),LineNo-SELF.TopLine+1,1))


!-Ascii Searcher Code-----------------------------------------------------------------------


AsciiSearchClass.Init PROCEDURE(AsciiFileClass FileMgr)

  CODE
  SELF.FileMgr&=FileMgr
  CLEAR(SELF.Find.What)
  SELF.Find.MatchCase=False
  SELF.Find.Direction='Down'


AsciiSearchClass.Ask PROCEDURE(LONG StartLine)

OmitWindow      BYTE(False)
Quit            BYTE,AUTO
WinXPos         SIGNED,AUTO
WinYPos         SIGNED,AUTO
WinInit         BYTE(False)

FindOptions WINDOW('Find'),AT(,,239,46),FONT('MS Sans Serif',8,,FONT:regular),IMM,GRAY,DOUBLE
       PROMPT('Find What:'),AT(4,9,40,12),USE(?Prompt1)
       ENTRY(@s32),AT(48,4,144,12),USE(SELF.Find.What),IMM
       CHECK('Match &Case'),AT(4,22,92,14),USE(SELF.Find.MatchCase)
       OPTION('&Direction'),AT(100,17,92,25),USE(SELF.Find.Direction),BOXED
         RADIO('&Up'),AT(112,30),USE(?Radio1),VALUE('Up')
         RADIO('&Down'),AT(148,30),USE(?Radio2),VALUE('Down')
       END
       BUTTON('&Cancel'),AT(196,22,40,14),USE(?CancelButton)
       BUTTON('&Next'),AT(196,4,40,13),USE(?NextButton),DEFAULT
     END

  CODE
  SELF.LineCounter=StartLine
  IF ~SELF.Find.Direction THEN SELF.Find.Direction='Down'.
  LOOP
    IF ~OmitWindow
      OPEN(FindOptions)
      IF WinInit
        SETPOSITION(0,WinXPos,WinYPos)
      ELSE
        GETPOSITION(0,WinXPos,WinYPos)
        WinInit=True
      END
      IF ~SELF.Translator&=NULL THEN SELF.Translator.TranslateWindow.
      ACCEPT
        CASE EVENT()
        OF EVENT:OpenWindow
          SELECT(?SELF:Find:What)
        OF EVENT:Accepted
          CASE FIELD()
          OF ?NextButton
            Quit=False
            POST(EVENT:CloseWindow)
          OF ?CancelButton
            Quit=True
            POST(EVENT:CloseWindow)
          END
        OF EVENT:Moved
          GETPOSITION(0,WinXPos,WinYPos)
        END
        UPDATE(?SELF:Find:What)
        ?NextButton{PROP:Disable}=CHOOSE(SELF.Find.What='')
      END
      CLOSE(FindOptions)
    END
    OmitWindow=False
    IF Quit
      BREAK
    ELSE
      SELF.LineCounter=SELF.Next()
      IF SELF.LineCounter
        SELF.FileMgr.SetLine(SELF.LineCounter)
      ELSE
        CASE SELF.FileMgr.ErrorMgr.Throw(CHOOSE(SELF.Find.Direction='Down',Msg:SearchReachedEnd,Msg:SearchReachedBeginning))
        OF Level:Benign
          SELF.LineCounter=CHOOSE(SELF.Find.Direction='Down',1,SELF.FileMgr.GetLastLineNo())
          OmitWindow=True
        OF Level:Cancel
          BREAK
        ELSE
          ASSERT(False) !Unexpected return value from ErrorMgr.Throw()
        END
      END
    END
  END


AsciiSearchClass.Setup PROCEDURE(*FindGroup FindAttrib,LONG StartLine)

  CODE
  SELF.Find :=: FindAttrib
  SELF.LineCounter=StartLine


AsciiSearchClass.Next PROCEDURE()

Cnt         LONG(0)
CurrentLine CSTRING(256),AUTO

  CODE
  IF SELF.LineCounter>0 AND SELF.Find.What
    Cnt=SELF.LineCounter
    LOOP
      Cnt+=(CHOOSE(SELF.Find.Direction='Down',1,-1))
      IF Cnt>0
        CurrentLine=SELF.FileMgr.GetLine(Cnt)
        IF ERRORCODE()
          RETURN 0
        ELSIF (~SELF.Find.MatchCase AND INSTRING(UPPER(CLIP(SELF.Find.What)),UPPER(CurrentLine),1,1)) OR INSTRING(CLIP(SELF.Find.What),CurrentLine,1,1)
          BREAK
        END
      ELSE
        BREAK
      END
    END
  END
  RETURN CHOOSE(Cnt<=0,0,Cnt)



!-Ascii Printer Code------------------------------------------------------------------------


AsciiPrintClass.Init PROCEDURE(AsciiFileClass FileMgr)

  CODE
  SELF.FileMgr&=FileMgr
  SELF.PrintPreview=False


AsciiPrintClass.Ask PROCEDURE

FirstLine       LONG
LastLine        LONG
HighestLine     LONG,AUTO

PrintOptions WINDOW('Print Options: Checking File, please wait...'),AT(,,259,89),FONT('MS Sans Serif',8,,FONT:regular), |
         CENTER,GRAY,DOUBLE
       OPTION('&Range to Print'),AT(4,0,196,73),USE(?RangeOption),BOXED
         RADIO('&All'),AT(8,13,30,13),USE(?Radio1),VALUE('All')
         RADIO('&Selection'),AT(8,26,44,13),USE(?Radio2),VALUE('Selection')
       END
       GROUP('&Line Range'),AT(8,39,188,30),USE(?LineRangeGroup),DISABLE,BOXED
         SPIN(@n5),AT(32,52,64,13),USE(FirstLine),RANGE(1,99999),STEP(1)
         SPIN(@n5),AT(128,52,64,13),USE(LastLine),RANGE(1,99999),STEP(1)
         PROMPT('&Last:'),AT(108,56,20,12),USE(?Prompt2),TRN
         PROMPT('&First:'),AT(12,56,20,13),USE(?FirstLinePrompt),TRN
       END
       CHECK('Pre&view Before Printing?'),AT(8,78),USE(SELF.PrintPreview,,?PrintPreview)
       BUTTON('&Print'),AT(204,4,52,14),USE(?PrintButton),DEFAULT
       BUTTON('Print &Setup...'),AT(204,22,52,14),USE(?PrintSetupButton),STD(STD:PrintSetup)
       BUTTON('&Cancel'),AT(204,39,52,14),USE(?CancelButton)
     END

  CODE
  OPEN(PrintOptions)
  IF ~SELF.Translator&=NULL THEN SELF.Translator.TranslateWindow.
  DISABLE(?RangeOption)
  DISABLE(?LineRangeGroup)
  DISABLE(?PrintButton,?CancelButton)
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      HighestLine=SELF.FileMgr.GetLastLineNo()
      PrintOptions{PROP:Text}=SUB(PrintOptions{Prop:Text},1,LEN('Print Options'))
      FirstLine=1
      LastLine=HighestLine
      ?FirstLine{PROP:RangeHigh}=Highestline
      ?LastLine{PROP:RangeHigh}=HighestLine
      ENABLE(?RangeOption,?Radio2)
      ENABLE(?PrintButton,?CancelButton)
      SELECT(?RangeOption,1)
      DISPLAY
    OF EVENT:Accepted
      CASE ACCEPTED()
      OF ?CancelButton
        POST(EVENT:CloseWindow)
      OF ?PrintButton
        IF CHOICE(?RangeOption)=1
          FirstLine=1
          LastLine=HighestLine
        ELSE
          IF ~INRANGE(LastLine,1,HighestLine) OR ~INRANGE(FirstLine,1,LastLine) OR FirstLine>LastLine
            SELF.FileMgr.ErrorMgr.SetField('first line ')
            IF SELF.FileMgr.ErrorMgr.ThrowMessage(Msg:FieldOutofRange,'1 and '&LastLine) NOT=Level:Fatal
              SELECT(?FirstLine)
              CYCLE
            END
          END
        END
        SELF.PrintLines(FirstLine,LastLine)
        POST(EVENT:CloseWindow)
      END
    END
    ?LineRangeGroup{PROP:Disable}=CHOOSE(CHOICE(?RangeOption)<>2)
  END
  CLOSE(PrintOptions)


AsciiPrintClass.PrintLines PROCEDURE(LONG FirstLine,LONG LastLine)

YieldGrain      EQUATE(10)

CurrentLine     STRING(255),AUTO
ProgressValue   LONG
LineCount       LONG
PrevQ           PreviewQueue
Previewer       &PrintPreviewClass

window WINDOW('Printing'),AT(,,219,33),FONT('MS Sans Serif',8,,FONT:regular),CENTER,GRAY,DOUBLE
       PROGRESS,USE(ProgressValue),AT(4,17,212,14),RANGE(0,100)
       STRING('100%'),AT(200,4),USE(?String3),RIGHT
       STRING('0%'),AT(4,4),USE(?String2),LEFT
       STRING('%age Complete'),AT(85,4),USE(?String1),CENTER
     END

Report REPORT,AT(1000,42,6000,11604),PRE(RPT),FONT('Arial',10,,),THOUS
Detail DETAIL,AT(,,,177)
         STRING(@s255),AT(0,0,6042,208),USE(CurrentLine)
       END
     END

  CODE
  OPEN(Window)
  Window{PROP:Text}=Window{Prop:Text}&' line '&FirstLine&' to '&LastLine
  ?ProgressValue{PROP:RangeHigh}=LastLine-FirstLine+1
  IF ~SELF.Translator&=NULL THEN SELF.Translator.TranslateWindow.
  OPEN(Report)
  Report{PROP:Preview}=PrevQ.Filename
  IF SELF.PrintPreview
    Previewer &= NEW PrintPreviewClass
    Previewer.Init(PrevQ)
  END
  LOOP LineCount=FirstLine TO LastLine
    CurrentLine=SELF.FileMgr.GetLine(LineCount)
    PRINT(RPT:Detail)
    ProgressValue+=1
    DISPLAY(?ProgressValue)
    IF ~(ProgressValue%YieldGrain) THEN YIELD().
  END
  CLOSE(Window)
  ENDPAGE(Report)
  Report{PROP:FlushPreview}=CHOOSE(SELF.PrintPreview=False,True,Previewer.Display())
  CLOSE(Report)
  IF SELF.PrintPreview
    Previewer.Kill
    DISPOSE(Previewer)
  END

