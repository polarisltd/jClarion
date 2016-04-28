! Implementation module for process server
  MEMBER

  MAP
Idx2Percentile  PROCEDURE(PrintPreviewClass SELF,BYTE Index),SHORT
Percentile2Idx  PROCEDURE(PrintPreviewClass SELF,SHORT Percentile),BYTE
  END

  INCLUDE('KEYCODES.CLW'),ONCE
  INCLUDE('ERRORS.CLW'),ONCE
  INCLUDE('ABREPORT.INC'),ONCE
  INCLUDE('ABREPORT.TRN'),ONCE
  INCLUDE('ABQUERY.INC'),ONCE

ChildList  QUEUE,TYPE
VM  &ViewManager
  END

ZoomItemQueue     QUEUE,TYPE
Percentile          SHORT                             !Zoom percentile or special zoom value
MenuText            CSTRING(64)
StatusText          CSTRING(64)
                  END

!PageManagerClass objects are entirely encapsulated within the PrintPreviewClass object's DISPLAY method.

PageManagerClass  CLASS,TYPE
PP                  &PrintPreviewClass,PRIVATE
AspectRatio         DECIMAL(8,4),PRIVATE
ImageFeq            USHORT,PRIVATE                          !Feq of ImageField
BorderFeq           USHORT,PRIVATE                          !Feq of BorderField
ImageWidth          USHORT,PRIVATE                          !Extent of image
ImageHeight         USHORT,PRIVATE
XPos                SHORT,PRIVATE                           !Thumbnail Pos and size
YPos                SHORT,PRIVATE
Width               SHORT,PRIVATE
Height              SHORT,PRIVATE
FileName            &STRING,PRIVATE                         !wmf file
CentreOnX           BYTE,PRIVATE                            !Attempts to centre Zoomed image on these approximate Coords (Range 0-100)
CentreOnY           BYTE,PRIVATE                            !Reset to (0,0) at next redraw
Neighbour           &PageManagerClass,PRIVATE               !Pointer to previous Object in linked list
PageNo              LONG,PRIVATE
ZoomState           SHORT,PRIVATE

CoordContained      PROCEDURE(SHORT X,SHORT Y),LONG          !Returns page containing the mouse coords x,y
Delete              PROCEDURE
Delete              PROCEDURE(LONG PageNo)
Draw                PROCEDURE(LONG PageNo,SHORT ZoomFactor=NoZoom)
Exists              PROCEDURE(LONG PageNo),BYTE
GetProp             PROCEDURE(LONG PageNo,USHORT Property),STRING
HighLight           PROCEDURE(LONG PageNo)
Init                PROCEDURE(PrintPreviewClass P, LONG PageNo,USHORT BaseFeq,*STRING FileName)
Init                PROCEDURE(PrintPreviewClass P, LONG PageNo,USHORT BaseFeq,*STRING FileName,SHORT XPos,SHORT YPos,USHORT Width,USHORT Height)
Kill                PROCEDURE
SetCentre           PROCEDURE(LONG PageNo,BYTE X,BYTE Y)
SetPosition         PROCEDURE(LONG PageNo,SHORT XPos,SHORT YPos,USHORT Width,USHORT Height)
                  END

ProcessClass.AddItem PROCEDURE(ViewManager VM)
  CODE
  IF SELF.Children &= NULL
    SELF.Children &= NEW ChildList
  END
  SELF.Children.VM &= VM
  ADD(SELF.Children)
  RETURN RECORDS(SELF.Children)

ProcessClass.Init PROCEDURE(VIEW V,RelationManager R,SIGNED ProgressText,<*BYTE PercentProgress>,LONG GuessRecords)
  CODE
  SELF.Percentile &= PercentProgress
  IF ~SELF.Percentile &= NULL
    SELF.Percentile = 0
  END
  SELF.RecordsToProcess = GuessRecords
  SELF.PText = ProgressText
  PARENT.Init(V,R)

ProcessClass.Init PROCEDURE(VIEW V,RelationManager R,SIGNED ProgressText,<*BYTE PercentProgress>,StepClass StepManager,*? ValueField)
  CODE
  SELF.Percentile&=PercentProgress
  IF ~SELF.Percentile &= NULL
    SELF.Percentile = 0
  END
  SELF.PText=ProgressText
  SELF.StepMgr&=StepManager
  SELF.ValueField&=ValueField
  SELF.CaseSensitiveValue = TRUE       ! For backward compatibility
  PARENT.Init(V,R)

ProcessClass.Kill PROCEDURE
  CODE
    SELF.Percentile &= NULL
    SELF.ValueField &= NULL
    SELF.Primary.SetQuickScan(0,Propagate:OneMany)
    DISPOSE(SELF.Children)
    IF ~SELF.StepMgr &= NULL
      SELF.StepMgr.Kill
    END
    PARENT.Kill

ProcessClass.TakeRecord PROCEDURE
  CODE
    RETURN Level:Benign

ProcessClass.Reset  PROCEDURE
  CODE
  SELF.RecordsProcessed = 0
  IF ~SELF.StepMgr &= NULL
    SELF.SetProgressLimits
  ELSIF ~SELF.RecordsToProcess
    SELF.Primary.Me.UseFile
    SELF.RecordsToProcess = RECORDS(SELF.Primary.Me.File)
    IF ~SELF.RecordsToProcess   ! Records not supported
      SELF.FileSize = SELF.Primary.Me.File{PROP:FileSize}
    END
  END
  SELF.ChildRead = 0
  PARENT.Reset

ProcessClass.Next   PROCEDURE(BYTE ProcessRecords)
RetVal BYTE,AUTO
Progress BYTE,AUTO
  CODE
  IF SELF.RecordsProcessed AND ~SELF.Children &= NULL AND SELF.ChildRead < RECORDS(SELF.Children)
    SELF.ChildRead += 1
    GET(SELF.Children,SELF.ChildRead)
    SELF.Children.VM.ApplyRange
    SELF.Children.VM.Reset
  END
  LOOP
    RetVal = CHOOSE(~SELF.ChildRead,PARENT.Next(),SELF.Children.VM.Next())
    IF ~RetVal OR ~SELF.ChildRead THEN BREAK .
    SELF.ChildRead -= 1
    GET(SELF.Children,SELF.ChildRead)
  END
  IF ~RetVal AND ProcessRecords
    IF SELF.FileSize
      SELF.BytesRead += BYTES(SELF.Primary.Me.File)
    END
    SELF.RecordsProcessed += 1
    IF ~SELF.Percentile &= NULL AND ~SELF.ChildRead
      IF SELF.StepMgr &= NULL
        IF SELF.FileSize THEN
          Progress = 100 * SELF.BytesRead / SELF.FileSize
        ELSE
          Progress = SELF.RecordsProcessed / SELF.RecordsToProcess*100
        END
      ELSIF SELF.CaseSensitiveValue
        Progress = SELF.StepMgr.GetPercentile(SELF.ValueField)
      ELSE
        Progress = SELF.StepMgr.GetPercentile(UPPER(SELF.ValueField))
      END
      IF Progress > 100 THEN Progress = 100.
      IF Progress <> SELF.Percentile
        SELF.Percentile = Progress
        SELF.UpdateDisplay
      END
    END
  END
  RETURN RetVal


ProcessClass.UpdateDisplay PROCEDURE
  CODE
  SELF.PText{PROP:Text}=CHOOSE(SELF.Percentile &= NULL,'',SELF.Percentile)&CompletedText
  DISPLAY


ProcessClass.SetProgressLimits PROCEDURE

Lo  STRING(64),AUTO                             !64 characters should be enough to identify limits
Hi  STRING(64),AUTO

  CODE
  ASSERT(~SELF.ValueField&=NULL)
  PARENT.Reset
  IF SELF.Previous() THEN CLEAR(SELF.ValueField,1).
  Hi=SELF.ValueField
  PARENT.Reset
  IF SELF.Next(False) THEN CLEAR(SELF.ValueField,-1).
  Lo=SELF.ValueField
  SELF.SetProgressLimits(Lo,Hi)

ProcessClass.SetProgressLimits PROCEDURE(STRING Lo,STRING Hi)
  CODE
  ASSERT(~SELF.StepMgr&=NULL)
  IF SELF.CaseSensitiveValue
    SELF.StepMgr.SetLimit (Lo,Hi)
  ELSE
    SELF.StepMgr.SetLimit (UPPER(Lo), UPPER(Hi))
  END

ProcessClass.TakeAccepted PROCEDURE
  CODE

ProcessClass.TakeLocate PROCEDURE
  CODE
    IF ~SELF.Query&=NULL AND SELF.Query.Ask()
      SELF.SetFilter(SELF.Query.GetFilter())
    END

!
!
!------ Print Previewer Implementation Follows -------------------------------------------------------
!
!


PrintPreviewClass.Init PROCEDURE(PreviewQueue ImageQueue)

Cnst       ConstantClass

   CODE
   PARENT.Init
   SELF.ImageQueue&=ImageQueue                        !assign the image queue
   ASSERT(~SELF.ImageQueue&=NULL)
   SELF.ZoomQueue&=NEW ZoomItemQueue
   SELF.Popup&=NEW PopupClass
   SELF.Popup.Init
   Cnst.Init(Term:Byte)
   Cnst.AddItem(ConstType:PString,SELF.ZoomQueue.MenuText)
   Cnst.AddItem(ConstType:PString,SELF.ZoomQueue.StatusText)
   Cnst.AddItem(ConstType:Short,SELF.ZoomQueue.Percentile)
   Cnst.Set(ZoomPresets)
   LOOP WHILE Cnst.Next()=Level:Benign
     ADD(SELF.ZoomQueue)
     ASSERT(~ERRORCODE())
     SELF.Popup.AddItem('-'&SELF.ZoomQueue.MenuText,'ZoomItem'&RECORDS(SELF.ZoomQueue))
   END
   Cnst.Kill


PrintPreviewClass.SetINIManager PROCEDURE(INIClass INI)

  CODE
  ASSERT(~INI&=NULL)
  SELF.INIMgr&=INI


PrintPreviewClass.Kill PROCEDURE

   CODE
   IF ~SELF.Popup &= NULL
    SELF.Popup.Kill
    DISPOSE(SELF.Popup)
   END
   DISPOSE(SELF.ZoomQueue)
   RETURN PARENT.Kill()


PrintPreviewClass.SetPosition PROCEDURE(<SHORT X>,<SHORT Y>,<SHORT Wid>,<SHORT Hgt>)

   CODE
   IF ~OMITTED(2) AND ~OMITTED(3)
     SELF.WindowPosSet=True
     SELF.WinXPos=X
     SELF.WinYPos=Y
   END
   IF ~OMITTED(4) AND ~OMITTED(5)
     SELF.WindowSizeSet=true
     SELF.WinWidth=Wid
     SELF.WinHeight=Hgt
   END


!Return false from these functions to signal Supress Printing, True to signal printing OK


PrintPreviewClass.Display PROCEDURE(SHORT InitZoom,LONG InitCurrentPage,USHORT InitPagesAcross,USHORT InitPagesDown)

PreviewWindow WINDOW('Report Preview'),AT(,,291,120),FONT('MS Sans Serif',10,,),COLOR(COLOR:Gray),CENTER, |
         IMM,ICON(Icon:Print),ALRT(MouseRightUp),ALRT(PgUpKey),ALRT(PgDnKey),STATUS(-1,90,70),GRAY,MAX, |
         RESIZE
       MENUBAR
         MENU('&File'),USE(?FileMenu)
           ITEM('Pa&ges to Print...'),USE(?PagesToPrint),MSG('Select which pages to print')
           ITEM,SEPARATOR
           ITEM('&Print'),USE(?Print),MSG('Print the report')
           ITEM,SEPARATOR
           ITEM('E&xit'),USE(?Exit),MSG('Exit without printing the report')
         END
         MENU('&View'),USE(?ViewMenu),DISABLE
           ITEM('&Next Page(s)'),USE(?Next),MSG('View the next page or pages of the report')
           ITEM('&Previous Page(s)'),USE(?Previous),DISABLE,MSG('View the next page or pages of the report')
           ITEM,SEPARATOR
           ITEM('&Jump to a page'),USE(?Jump),MSG('Jump to a specific page of the report')
           ITEM,SEPARATOR
           ITEM('&Change Display'),USE(?ChangeDisplay),MSG('Change the number of pages displayed')
         END
         MENU('&Zoom'),USE(?ZoomMenu)
         END
       END
       TOOLBAR,AT(0,0,291,21)
         BUTTON,AT(4,4,14,14),USE(?TBarPrint),TIP('Print this report'),ICON(ICON:Print)
         BUTTON,AT(20,4,14,14),USE(?TBarExit),TIP('Exit without printing the report'),ICON(ICON:NoPrint)
         BUTTON,AT(36,4,14,14),USE(?TBarZoom),TIP('Zoom in on a page of the report'),ICON(ICON:Zoom)
         PROMPT('&Page:'),AT(52,8,20,9),USE(?PagePrompt),RIGHT
         SPIN(@n4),AT(76,8,28,9),USE(SELF.CurrentPage,,?CurrentPage),RANGE(1,10),STEP(1)
         PROMPT('&Across:'),AT(108,8,24,9),USE(?AcrossPrompt),RIGHT
         SPIN(@N2),AT(136,8,24,9),USE(SELF.PagesAcross,,?PagesAcross),VSCROLL,MSG('Select the number of thumbnails in a row'), |
             RANGE(1,10),STEP(1)
         PROMPT('&Down:'),AT(164,8,20,9),USE(?DownPrompt),RIGHT
         SPIN(@n2),AT(188,8,24,9),USE(SELF.PagesDown,,?PagesDown),MSG('Select the number of thumbnails in a column'), |
             RANGE(1,10),STEP(1)
         PROMPT('Z&oom:'),AT(216,8,20,9),USE(?ZoomPrompt),HIDE,RIGHT
         COMBO(@S16),AT(240,8,48,9),USE(SELF.ZoomList,,?ZoomList),HIDE,MSG('Set zoom to standard or user defined value'), |
             DROP(10),FROM('')
       END
     END

  CODE
  SELF.PrintOK=False
  IF RECORDS(SELF.ImageQueue)
    SELF.InitZoom=CHOOSE(InitZoom = 0, DefaultZoom, InitZoom)           !Uses zoom from AbReport.Trn if no passed
    SELF.FirstPage=InitCurrentPage
    SELF.CurrentPage=InitCurrentPage
    SELF.PagesAcross=InitPagesAcross
    SELF.PagesDown=InitPagesDown
    SELF.SetDefaultPages
    OPEN(PreviewWindow)
    IF SELF.Maximize THEN PreviewWindow{PROP:Maximize}=True.             !Window requested opened maximized
    SETCURSOR(CURSOR:Wait)
    IF ~SELF.Translator&=NULL THEN SELF.Translator.TranslateWindow(PreviewWindow).
    SELF.PreviewWindow &= PreviewWindow
    SELF.PrtPrev:TBarZoom=?TBarZoom
    SELF.PrtPrev:TBarPrint=?TBarPrint
    SELF.PrtPrev:TBarExit=?TBarExit
    SELF.PrtPrev:MenuPages=?PagesToPrint
    SELF.PrtPrev:MenuPrint=?Print
    SELF.PrtPrev:MenuExit=?Exit
    SELF.PrtPrev:ZoomList=?ZoomList
    SELF.PrtPrev:ZoomPrompt=?ZoomPrompt
    SELF.PrtPrev:PagePrompt=?PagePrompt
    SELF.PrtPrev:CurrentPage=?CurrentPage
    SELF.PrtPrev:PagesAcross=?PagesAcross
    SELF.PrtPrev:PagesDown=?PagesDown
    SELF.PrtPrev:Next=?Next
    SELF.PrtPrev:Previous=?Previous
    SELF.PrtPrev:Jump=?Jump
    SELF.PrtPrev:ChangeDisplay=?ChangeDisplay
    SELF.PrtPrev:ViewMenu=?ViewMenu
    SELF.PrtPrev:ZoomMenu=?ZoomMenu
    SELF.Ask
    CLOSE(PreviewWindow)
  END
  IF SELF.PrintOk
    SELF.SyncImageQueue
  END
  RETURN SELF.PrintOK


!This method synconizes the image queue with the contents of PageToPrint, ensuring that only the selected pages
!are sent to the printer

PrintPreviewClass.SyncImageQueue PROCEDURE

i LONG,AUTO

  CODE
  LOOP i = RECORDS(SELF.ImageQueue) TO 1 BY -1
    IF ~SELF.InPageList(i)
      SELF.DeleteImageQueue(i)
    END
  END


!This method removes an image from the image queue and also, remove ths associated image meta file

PrintPreviewClass.DeleteImageQueue PROCEDURE(LONG i)

  CODE
  IF POINTER(SELF.ImageQueue) <> i
    GET(SELF.ImageQueue, i)
    IF ERRORCODE() THEN RETURN False.
  END
  REMOVE(SELF.ImageQueue.Filename)
? ASSERT(~ERRORCODE())
  DELETE(SELF.ImageQueue)
? ASSERT(~ERRORCODE())
  RETURN True


PrintPreviewClass.SetDefaultPages PROCEDURE

  CODE
  SELF.PagesToPrint = '1-' & RECORDS(SELF.ImageQueue)


PrintPreviewClass.Open PROCEDURE

i USHORT,AUTO

  CODE
  IF ~(SELF.WindowPosSet AND SELF.WindowSizeSet)
    IF SELF.SaveSize.Set
      SETPOSITION(0,SELF.SaveSize.XPos,SELF.SaveSize.YPos,SELF.SaveSize.Width,SELF.SaveSize.Height)
    ELSIF ~SELF.INIMgr&=NULL
      SELF.INIMgr.Fetch('_PreviewWindow_',SELF.PreviewWindow)
    END
  ELSIF SELF.WindowPosSet AND SELF.WindowSizeSet
    SETPOSITION(0,SELF.WinXPos,SELF.WinYPos,SELF.WinWidth,SELF.WinHeight)
  ELSIF SELF.WindowPosSet
    SETPOSITION(0,SELF.WinXPos,SELF.WinYPos)
  ELSIF SELF.WindowSizeSet
    SETPOSITION(0,,,SELF.WinWidth,SELF.WinHeight)
  END
  GET(SELF.ImageQueue,1)
  ASSERT(~ERRORCODE())
  SELF.PageManager &= NEW PageManagerClass                            !Root PageManager
  SELF.PageManager.Init(SELF, 1,BaseFeq,SELF.ImageQueue.Filename)
  IF RECORDS(SELF.ImageQueue)>1
    ENABLE(SELF.PrtPrev:ViewMenu)
    SELF.PrtPrev:CurrentPage{PROP:RangeHigh}=RECORDS(SELF.ImageQueue)
    SELF.PrtPrev:CurrentPage{PROP:Msg}=EnterStr&' '&RECORDS(SELF.ImageQueue)
  ELSE
    DISABLE(SELF.PrtPrev:CurrentPage,SELF.PrtPrev:PagesDown)
  END
  LOOP i=1 TO RECORDS(SELF.ZoomQueue)
    GET(SELF.ZoomQueue,i)
    ASSERT(~ERRORCODE())
    CREATE(ZoomItem+i,CREATE:Item,SELF.PrtPrev:ZoomMenu,i)
    (ZoomItem+i){PROP:Use}=SELF.mUse[i]
    (ZoomItem+i){PROP:Text}=SUB(SELF.ZoomQueue.MenuText,1,LEN(SELF.ZoomQueue.MenuText))     !ROYMORE - Assignment fix required
    (ZoomItem+i){PROP:Check}=True
    SELF.mUse[i]=CHOOSE(i=DefaultZoom)
    SELF.Popup.AddItemEvent('ZoomItem'&i,EVENT:Accepted,ZoomItem+i)
    SELF.PrtPrev:ZoomList{PROP:From}=CLIP(SELF.PrtPrev:ZoomList{PROP:From})&CLIP(SELF.ZoomQueue.MenuText)&CHOOSE(i<RECORDS(SELF.ZoomQueue),'|','')
  END
  IF SELF.AllowUserZoom
    SELF.ResetUserZoom
    UNHIDE(SELF.PrtPrev:ZoomList)
    UNHIDE(SELF.PrtPrev:ZoomPrompt)
  END
  SELF.ZoomIndex=Percentile2Idx(SELF,SELF.InitZoom)
  IF SELF.ZoomIndex>RECORDS(SELF.ZoomQueue)
    ASSERT(SELF.AllowUserZoom)
    SELF.ZoomIndex=0
    SELF.UserPercentile=SELF.InitZoom
  END
  IF ~SELF.Translator&=NULL
    SELF.Popup.SetTranslator(SELF.Translator)
  END
  SELF.NewZoom
  SETCURSOR


PrintPreviewClass.TakeAccepted PROCEDURE

c USHORT,AUTO
i USHORT,AUTO

  CODE
  IF PARENT.TakeAccepted() THEN RETURN Level:Notify.
  CASE FIELD()
  OF ZoomItem+1 TO ZoomItem+RECORDS(SELF.ZoomQueue)
    i=SELF.ZoomIndex
    SELF.ZoomIndex=ACCEPTED()-(ZoomItem+1)+1
    IF SELF.ZoomIndex NOT=i THEN SELF.NewZoom.
  OF SELF.PrtPrev:TBarZoom
    SELF.ConfigMenuChecks
    SELF.Popup.Ask()
  OF SELF.PrtPrev:MenuPages
    SELF.AskPrintPages
    SELF.DrawPage
  OF SELF.PrtPrev:MenuPrint
  OROF SELF.PrtPrev:TBarPrint
    SELF.PrintOk = CHOOSE(SELF.ConfirmPages = True, SELF.AskPrintPages(), True)
    POST(EVENT:CloseWindow)
  OF SELF.PrtPrev:MenuExit
  OROF SELF.PrtPrev:TBarExit
    POST(EVENT:CloseWindow)
  OF SELF.PrtPrev:ZoomList
    i=False
    LOOP c=1 TO RECORDS(SELF.ZoomQueue)
      GET(SELF.ZoomQueue,c)
      ASSERT(~ERRORCODE())
      IF SELF.ZoomQueue.MenuText=SELF.ZoomList THEN i=True.
    WHILE ~i
    IF i
      POST(EVENT:Accepted,ZoomItem+CHOICE(SELF.PrtPrev:ZoomList))
      RETURN Level:Notify
    ELSE
      SELF.ZoomList=ABS(SELF.ZoomList)
      SELF.ZoomIndex=0
      SELF.UserPercentile=SELF.ZoomList
      SELF.NewZoom
    END
  OF SELF.PrtPrev:CurrentPage
    IF ~INRANGE(SELF.CurrentPage-SELF.FirstPage+1,1,SELF.PagesAcross*SELF.PagesDown)
      SELF.FirstPage=SELF.CurrentPage
      LOOP WHILE SELF.FirstPage+(SELF.PagesAcross*SELF.PagesDown)-1>RECORDS(SELF.ImageQueue)
         SELF.FirstPage-=1
      WHILE SELF.FirstPage>1
      SELF.DrawPage
    ELSE
      IF ~SELF.PageManager.Exists(SELF.CurrentPage)
        SELF.DrawPage
      ELSE
        SELF.PageManager.HighLight(SELF.CurrentPage)
      END
    END
  OF SELF.PrtPrev:PagesAcross
  OROF SELF.PrtPrev:PagesDown
    i=True
    LOOP WHILE SELF.FirstPage+(SELF.PagesAcross*SELF.PagesDown)-1>RECORDS(SELF.ImageQueue)
      SELF.PagesAcross-=CHOOSE(ACCEPTED()=SELF.PrtPrev:PagesAcross)
      SELF.PagesDown-=CHOOSE(ACCEPTED()=SELF.PrtPrev:PagesDown)
      i=False
    WHILE SELF.PagesAcross>1 AND SELF.PagesDown>1
    IF i THEN SELF.DrawPage.
  OF SELF.PrtPrev:Next
  OROF SELF.PrtPrev:Previous
    SELF.CurrentPage+=CHOOSE(ACCEPTED()=SELF.PrtPrev:Next,1,-1)
    POST(EVENT:Accepted,SELF.PrtPrev:CurrentPage)
    RETURN Level:Notify
  OF SELF.PrtPrev:Jump
    IF SELF.AskPage() THEN POST(EVENT:Accepted,SELF.PrtPrev:CurrentPage).
  OF SELF.PrtPrev:ChangeDisplay
    SELF.AskThumbnails
    SELF.CurrentPage=1
    SELF.DrawPage
  END
  RETURN Level:Benign


PrintPreviewClass.TakeWindowEvent PROCEDURE
  CODE
  RETURN CHOOSE(EVENT()=EVENT:GainFocus,Level:Benign,PARENT.TakeWindowEvent())

PrintPreviewClass.TakeEvent PROCEDURE
C   USHORT,AUTO
Cx  USHORT,AUTO
Cy  USHORT,AUTO
i   USHORT,AUTO
Mx  USHORT,AUTO
My  USHORT,AUTO
  CODE
  IF PARENT.TakeEvent() THEN RETURN Level:Notify.
  CASE EVENT()
  OF EVENT:CloseWindow
    IF ~SELF.INIMgr&=NULL
      SELF.INIMgr.Update('_PreviewWindow_',SELF.PreviewWindow)
    END
    SELF.PageManager.Kill
    DISPOSE(SELF.PageManager)
  OF EVENT:Sized
    SELF.SaveSize.Set=True
    GETPOSITION(0,SELF.SaveSize.XPos,SELF.SaveSize.YPos,SELF.SaveSize.Width,SELF.SaveSize.Height)
    SELF.DrawPage
  OF EVENT:AlertKey
    CASE KEYCODE()
    OF PgUpKey
      IF SELF.CurrentPage>1 AND ~SELF.PrtPrev:Previous{PROP:Disable} THEN POST(EVENT:Accepted,SELF.PrtPrev:Previous).
    OF PgDnKey
      IF SELF.CurrentPage<RECORDS(SELF.ImageQueue) AND ~SELF.PrtPrev:Next{PROP:Disable} THEN POST(EVENT:Accepted,SELF.PrtPrev:Next).
    OF MouseLeft
      DO GetCoord
      IF C
        SELF.CurrentPage=C
        IF Idx2Percentile(SELF,SELF.ZoomIndex)=NoZoom
          IF Percentile2Idx(SELF,PageWidth)<=RECORDS(SELF.ZoomQueue)
            SELF.ZoomIndex=Percentile2Idx(SELF,PageWidth)
            SELF.PageManager.SetCentre(C,0,((My-SELF.PageManager.GetProp(C,PROP:YPos))/SELF.PageManager.GetProp(C,PROP:Height))*100)
            SELF.NewZoom
          END
        ELSE
          IF Percentile2Idx(SELF,NoZoom)<=RECORDS(SELF.ZoomQueue)
            SELF.ZoomIndex=Percentile2Idx(SELF,NoZoom)
            SELF.NewZoom
          END
        END
      END
    OF MouseRightUp
      DO GetCoord
      IF C
        IF Idx2Percentile(SELF,SELF.ZoomIndex)=NoZoom
          Cx=((Mx-SELF.PageManager.GetProp(C,PROP:XPos))/SELF.PageManager.GetProp(C,PROP:Width))*100
          Cy=((My-SELF.PageManager.GetProp(C,PROP:YPos))/SELF.PageManager.GetProp(C,PROP:Height))*100
        ELSE
          IF SELF.PageManager.GetProp(C,PROP:VScroll)
            i=SELF.PageManager.GetProp(C,PROP:VScrollPos)*((SELF.PageManager.GetProp(C,PROP:MaxHeight)-SELF.PageManager.GetProp(C,PROP:Height))/255)
            Cy=100*((i+My)/SELF.PageManager.GetProp(C,PROP:MaxHeight))
          ELSE
            Cy=(My/SELF.PageManager.GetProp(C,PROP:Height))*100
          END
          IF SELF.PageManager.GetProp(C,PROP:HScroll)
            i=SELF.PageManager.GetProp(C,PROP:HScrollPos)*((SELF.PageManager.GetProp(C,PROP:MaxWidth)-SELF.PageManager.GetProp(C,PROP:Width))/255)
            Cx=100*((i+Mx)/SELF.PageManager.GetProp(C,PROP:MaxWidth))
          ELSE
            Cx=(Mx/SELF.PageManager.GetProp(C,PROP:Width))*100
          END
        END
        SELF.PageManager.SetCentre(C,Cx,Cy)
        IF SELF.Popup.Ask()
          SELF.CurrentPage=C
        ELSE
          SELF.PageManager.SetCentre(C,0,0)
        END
      END
    END
  END
  DO DisplayWindow
  RETURN Level:Benign

GetCoord ROUTINE
  Mx=MOUSEX()
  My=MOUSEY()
  C=SELF.PageManager.CoordContained(Mx,My)

DisplayWindow ROUTINE
  SELF.ConfigMenuChecks
  SELF.PrtPrev:Previous{PROP:Disable}=CHOOSE(SELF.CurrentPage=1)
  SELF.PrtPrev:Next{PROP:Disable}=CHOOSE(SELF.CurrentPage=RECORDS(SELF.ImageQueue))
  SELF.PrtPrev:Jump{PROP:Disable}=CHOOSE(RECORDS(SELF.ImageQueue)=1)
  SELF.PrtPrev:ChangeDisplay{PROP:Disable}=SELF.PrtPrev:Jump{PROP:Disable}
  IF RECORDS(SELF.ImageQueue)=1
    DISABLE(SELF.PrtPrev:PagePrompt,SELF.PrtPrev:PagesDown)
  ELSE
    IF Idx2Percentile(SELF,SELF.ZoomIndex)=NoZoom
      ENABLE(SELF.PrtPrev:PagesAcross,SELF.PrtPrev:PagesDown)
    ELSE
      DISABLE(SELF.PrtPrev:PagesAcross,SELF.PrtPrev:PagesDown)
    END
  END
  DISPLAY(SELF.PrtPrev:CurrentPage,SELF.PrtPrev:PagesDown)
  IF Idx2Percentile(SELF,SELF.ZoomIndex)=NoZoom
    SELF.PrtPrev:ChangeDisplay{PROP:Disable}=CHOOSE(RECORDS(SELF.ImageQueue)<=1)
  ELSE
    DISABLE(SELF.PrtPrev:ChangeDisplay)
  END
  SELF.PreviewWindow{PROP:StatusText,3}=CHOOSE(SELF.ZoomIndex=0,SBZoom&' '&SELF.UserPercentile&'%',SELF.ZoomQueue.StatusText)
  IF Idx2Percentile(SELF,SELF.ZoomIndex)=NoZoom
    SELF.PreviewWindow{PROP:StatusText,2}=PageStr&' '&CHOOSE(SELF.ThumbnailsPresent>1,SELF.FirstPage&'-'&SELF.FirstPage+SELF.ThumbnailsPresent-1&' '&OfStr,SELF.CurrentPage&' '&OfStr)&' '&RECORDS(SELF.ImageQueue)
  ELSE
    SELF.PreviewWindow{PROP:StatusText,2}=PageStr&' '&SELF.CurrentPage&' '&OfStr&' '&RECORDS(SELF.ImageQueue)
  END
  DISPLAY(SELF.PrtPrev:Next,SELF.PrtPrev:ChangeDisplay)


PrintPreviewClass.TakeFieldEvent PROCEDURE
  CODE
  CASE EVENT()
  OF EVENT:NewSelection
    IF INLIST(FIELD(),SELF.PrtPrev:CurrentPage,SELF.PrtPrev:PagesAcross,SELF.PrtPrev:PagesDown)
      POST(EVENT:Accepted,FIELD())
      RETURN Level:Notify
    END
  END
  RETURN Level:Benign


PrintPreviewClass.NewZoom PROCEDURE
  CODE
  SELF.ResetUserZoom
  SELF.DrawPage
  SELF.ConfigMenuChecks

PrintPreviewclass.ConfigMenuChecks PROCEDURE
c  BYTE,AUTO
   CODE
   LOOP c=1 TO RECORDS(SELF.ZoomQueue)
     SELF.Popup.SetItemCheck('ZoomItem'&c,CHOOSE(c=SELF.ZoomIndex))
     SELF.mUse[c]=CHOOSE(c=SELF.ZoomIndex)
   END
   DISPLAY(ZoomItem+1,ZoomItem+RECORDS(SELF.ZoomQueue))

PrintPreviewClass.ResetUserZoom PROCEDURE
  CODE
  IF SELF.AllowUserZoom
    IF SELF.ZoomIndex
      GET(SELF.ZoomQueue,SELF.ZoomIndex)
      ASSERT(~ERRORCODE())
      SELF.ZoomList=SELF.ZoomQueue.MenuText
    ELSE
      SELF.ZoomList=CLIP(SELF.ZoomList)&PCZoom
    END
    DISPLAY(SELF.PrtPrev:ZoomList)
  END


PrintPreviewClass.DrawPage PROCEDURE

  CODE
  IF Idx2Percentile(SELF,SELF.ZoomIndex)=NoZoom
    DO DrawThumbnails
  ELSE
    IF EVENT() NOT=EVENT:Sized
      SELF.PageManager.Delete
      IF ~SELF.PageManager.Exists(SELF.CurrentPage) THEN DO AddNewPageManager.
    END
    SELF.PageManager.Draw(SELF.CurrentPage,Idx2Percentile(SELF,SELF.ZoomIndex))
  END
  IF EVENT() NOT=EVENT:Sized THEN SELF.PageManager.HighLight(SELF.CurrentPage).

DrawThumbnails ROUTINE
  DATA
TXPos       SHORT,AUTO
TYPos       SHORT,AUTO
TWidth      USHORT,AUTO
THeight     USHORT,AUTO
TRow        USHORT,AUTO
TCol        USHORT,AUTO
SavePage    LONG,AUTO
  CODE
  IF EVENT() NOT=EVENT:Sized
    LOOP SavePage=1 TO RECORDS(SELF.ImageQueue)
      IF ~INRANGE(SavePage,SELF.FirstPage,SELF.FirstPage+(SELF.PagesAcross*SELF.PagesDown)-1) AND SELF.PageManager.Exists(SavePage) THEN SELF.PageManager.Delete(SavePage).
    END
  END
  SavePage=SELF.CurrentPage
  SELF.CurrentPage=SELF.FirstPage
  TWidth=(SELF.PreviewWindow{PROP:ClientWidth}-((SELF.PagesAcross+1)*MinXSeperation))/SELF.PagesAcross
  THeight=(SELF.PreviewWindow{PROP:ClientHeight}-((SELF.PagesDown+1)*MinYSeperation))/SELF.PagesDown
  TYPos=MinYSeperation
  SELF.ThumbnailsPresent=0
  LOOP TRow=1 TO SELF.PagesDown
    TXPos=MinXSeperation
    LOOP TCol=1 To SELF.PagesAcross
      IF SELF.CurrentPage<=RECORDS(SELF.ImageQueue)
        IF ~SELF.PageManager.Exists(SELF.CurrentPage) THEN DO AddNewPageManager.
        SELF.PageManager.SetPosition(SELF.CurrentPage,TXPos,TYPos,TWidth,THeight)
        SELF.PageManager.Draw(SELF.CurrentPage,NoZoom)
        SELF.ThumbnailsPresent+=1
      END
      TXPos+=MinXSeperation+SELF.PageManager.GetProp(SELF.CurrentPage,PROP:Width)
      THeight=SELF.PageManager.GetProp(SELF.CurrentPage,PROP:Height)
      SELF.CurrentPage+=1
    END
    TYPos+=MinYSeperation+THeight
  END
  SELF.CurrentPage=SavePage
  SELF.PageManager.HighLight(SELF.CurrentPage)

AddNewPageManager ROUTINE
  DATA
OldRoot &PageManagerClass
  CODE
  GET(SELF.ImageQueue,SELF.CurrentPage)
  ASSERT(~ERRORCODE())
  OldRoot &= SELF.PageManager
  SELF.PageManager &= New PageManagerClass
  SELF.PageManager.Init(SELF, SELF.CurrentPage,BaseFeq+((SELF.CurrentPage*2)-2),SELF.ImageQueue.Filename)
  SELF.PageManager.Neighbour &= OldRoot


PrintPreviewClass.SetZoomPercentile PROCEDURE(SHORT Percentile)

C USHORT,AUTO

  CODE
  SELF.ZoomIndex=0
  LOOP C=1 TO RECORDS(SELF.ZoomQueue)
    GET(SELF.ZoomQueue,C)
    ASSERT(~ERRORCODE())
    IF SELF.ZoomQueue.Percentile=Percentile
      SELF.ZoomIndex=C
      SELF.UserPercentile=0
    END
  WHILE ~SELF.ZoomIndex
  IF ~SELF.ZoomIndex
    ASSERT(SELF.AllowUserZoom)
    SELF.UserPercentile=Percentile
  END


PrintPreviewClass.AskPage PROCEDURE

JumpPage LONG,AUTO
RVal     BYTE(False)

JumpWindow WINDOW('Jump to a Report Page'),AT(,,181,26),FONT('MS Sans Serif',10,,),CENTER,STATUS,GRAY, |
         DOUBLE
       PROMPT('&Page:'),AT(5,8),USE(?JumpPrompt)
       SPIN(@n5),AT(30,7,50,12),MSG('Select a page of the report'),USE(JumpPage),RANGE(1,10),STEP(1)
       BUTTON('OK'),AT(89,7,40,12),MSG('Jump to the selected page'),USE(?OKButton),DEFAULT
       BUTTON('Cancel'),AT(134,7,40,12),MSG('Cancel this selection'),USE(?CancelButton)
     END

   CODE
   JumpPage=SELF.CurrentPage
   OPEN(JumpWindow)
   IF ~SELF.Translator&=NULL THEN SELF.Translator.TranslateWindow(JumpWindow).
   ACCEPT
     CASE EVENT()
     OF EVENT:OpenWindow
       ?JumpPage{PROP:RangeHigh}=RECORDS(SELF.ImageQueue)
     OF EVENT:Accepted
       CASE ACCEPTED()
       OF ?OKButton
         IF JumpPage NOT=SELF.CurrentPage
           RVal=True                                     !RVal=true if SELF.CurrentPage has changed
           SELF.CurrentPage=JumpPage
         END
         POST(EVENT:CloseWindow)
       OF ?CancelButton
         POST(EVENT:CloseWindow)
       END
     END
   END
   CLOSE(JumpWindow)
   RETURN RVal


PrintPreviewClass.AskThumbnails PROCEDURE

SelectWindow WINDOW('Change the Report Display'),AT(,,141,64),FONT('MS Sans Serif',10,,),GRAY,DOUBLE
       GROUP('Pages Displayed'),AT(3,2,135,43),USE(?Group1),BOXED
         GROUP('Across'),AT(7,10,62,32),BOXED
           SPIN(@N2),AT(13,22,50,12),USE(SELF.PagesAcross,,?PagesAcross),HSCROLL,RANGE(1,10),STEP(1)
         END
         GROUP('Down'),AT(72,10,62,32),BOXED
           SPIN(@N2),AT(79,22,50,12),USE(SELF.PagesDown,,?PagesDown),HVSCROLL,RANGE(1,10),STEP(1)
         END
       END
       BUTTON('OK'),AT(98,47,40,14),KEY(EnterKey),USE(?OK)
     END

   CODE
   OPEN(SelectWindow)
   IF ~SELF.Translator&=NULL THEN SELF.Translator.TranslateWindow(SelectWindow).
   ACCEPT
     CASE EVENT()
     OF EVENT:Accepted
       CASE FIELD()
       OF ?OK
         IF SELF.PagesAcross*SELF.PagesDown>RECORDS(SELF.ImageQueue)
           SELECT(?PagesAcross)
         ELSE
           POST(EVENT:CloseWindow)
         END
       END
     END
   END
   CLOSE(SelectWindow)


PrintPreviewClass.AskPrintPages PROCEDURE

Preserve  LIKE(PrintPreviewClass.PagesToPrint),AUTO

Window WINDOW('Pages to Print'),AT(,,260,37),FONT('MS Sans Serif',8,,FONT:regular),CENTER,SYSTEM,GRAY, |
         RESIZE
       PROMPT('&Pages to Print:'),AT(4,8),USE(?Prompt)
       ENTRY(@s255),AT(56,4,200,11),USE(SELF.PagesToPrint, , ?PagesToPrint)
       BUTTON('&Reset'),AT(116,20,45,14),USE(?Reset)
       BUTTON('&Ok'),AT(164,20,45,14),USE(?Ok),DEFAULT
       BUTTON('&Cancel'),AT(212,20,45,14),USE(?Cancel),STD(STD:Close)
     END

RVal  BYTE(False)

  CODE
  Preserve = SELF.PagesToPrint
  OPEN(Window)
  ACCEPT
    CASE EVENT()
    OF EVENT:Accepted
      CASE ACCEPTED()
      OF ?Cancel
        SELF.PagesToPrint = Preserve
        POST(EVENT:CloseWindow)
      OF ?Ok
        RVal = True
        POST(EVENT:CloseWindow)
      OF ?Reset
        SELF.SetDefaultPages
        SELECT(?PagesToPrint)
      END
    OF EVENT:OpenWindow
      IF ~SELF.INIMgr &= NULL
        SELF.INIMgr.Fetch('_PreviewAskPagesWindow_', Window)
      END
    OF EVENT:CloseWindow
      IF ~SELF.INIMgr &= NULL
        SELF.INIMgr.Update('_PreviewAskPagesWindow_', Window)
      END
    END
  END
  CLOSE(Window)
  RETURN RVal


PrintPreviewClass.InPageList PROCEDURE(LONG PageN)

i     LONG(1)
j     LONG(0)
Itm   CSTRING(256),AUTO
Lo    LONG,AUTO
Hi    LONG,AUTO
s     USHORT,AUTO

  CODE
  IF SELF.PagesToPrint
    LOOP
      IF i = LEN(SELF.PagesToPrint)
        Itm = SELF.PagesToPrint[j + 1 : i]
      ELSIF SELF.PagesToPrint[i] = ','
        Itm = SELF.PagesToprint[j + 1 : i - 1]
        j = i
      END
      s = INSTRING('-', Itm, 1, 1)
      IF s
        Lo = SUB(Itm, 1, s - 1)
        Hi = SUB(Itm, s + 1, LEN(Itm) - s)
        IF Lo > 0 AND Hi > 0 AND Lo <= Hi AND INRANGE(PageN, Lo, Hi)
          RETURN True
        END
      ELSIF NUMERIC(Itm) AND PageN = Itm
        RETURN True
      END
      i += 1
    WHILE i <= LEN(SELF.PagesToPrint)
  END
  RETURN False







!-------------------------------------------------------------

PageManagerClass.Init PROCEDURE(PrintPreviewClass P, LONG PageNo,USHORT pBaseFeq,*STRING FName)

TempImage     EQUATE(498)
  CODE
  SELF.PP &= P
  SELF.Filename &= NEW STRING(LEN(CLIP(FName)))
  SELF.Filename=FName
  SELF.BorderFeq=pBaseFeq
  SELF.ImageFeq=pBaseFeq+1
  SELF.PageNo=PageNo
  CREATE(TempImage,CREATE:Image)
  TempImage{PROP:Text}=SELF.Filename
  SELF.ImageWidth=TempImage{PROP:MaxWidth}
  SELF.ImageHeight=TempImage{PROP:MaxHeight}
  DESTROY(TempImage)
  SELF.AspectRatio=SELF.ImageHeight/SELF.ImageWidth


PageManagerClass.Init PROCEDURE(PrintPreviewClass P, LONG PageNo,USHORT pBaseFeq,*STRING FName,SHORT X,SHORT Y,USHORT Wid,USHORT Hgt)

  CODE
  SELF.Init(P, PageNo,pBaseFeq,FName)
  SELF.SetPosition(SELF.PageNo,X,Y,Wid,Hgt)


PageManagerClass.SetPosition PROCEDURE(LONG PageNo,SHORT X,SHORT Y,USHORT W,USHORT H)

  CODE
  IF SELF.PageNo=PageNo
    SELF.XPos=X
    SELF.YPos=Y
    IF H/W<SELF.AspectRatio
      W=H/SELF.AspectRatio
    ELSE
      H=W*SELF.Aspectratio
    END
    SELF.Width=W
    SELF.Height=H
    IF SELF.BorderFeq{PROP:Type}=CREATE:Box THEN SETPOSITION(SELF.BorderFeq,X,Y,W,H).
    IF SELF.ImageFeq{PROP:Type}=CREATE:Image THEN SETPOSITION(SELF.ImageFeq,X,Y,W,H).
  ELSIF ~SELF.Neighbour&=NULL
    SELF.Neighbour.SetPosition(PageNo,X,Y,W,H)
  END


PageManagerClass.Draw PROCEDURE(LONG PageNo,SHORT ZoomFactor)

ZoomModifier  DECIMAL(8,4),AUTO
TWidth        USHORT,AUTO
THeight       USHORT,AUTO
WinWidth      LIKE(TWidth),AUTO
WinHeight     LIKE(THeight),AUTO

  CODE
  IF SELF.PageNo=PageNo
    IF SELF.Borderfeq{PROP:Type} NOT=CREATE:Box
      CREATE(SELF.BorderFeq,CREATE:Box)
      CREATE(SELF.ImageFeq,CREATE:Image)
      SELF.BorderFeq{PROP:Color}=COLOR:Black
      SELF.BorderFeq{PROP:Fill}=COLOR:White
      SELF.ImageFeq{PROP:Cursor}=CURSOR:Zoom
      SELF.ImageFeq{PROP:Color}=COLOR:White
      SELF.ImageFeq{PROP:Alrt,250}=MouseLeft
      SELF.ImageFeq{PROP:Text}=SELF.Filename
    END
    IF ZoomFactor=NoZoom
      SELF.ImageFeq{PROP:MaxWidth}=SELF.Width
      SELF.ImageFeq{PROP:MaxHeight}=SELF.Height
      SELF.ImageFeq{PROP:VScroll}=False
      SELF.ImageFeq{PROP:HScroll}=False

      IF ~SELF.PP.InPageList(SELF.PageNo)
        SELF.BorderFeq{PROP:Fill} = COLOR:Gray
        SELF.ImageFeq{PROP:Text} = ''
      ELSE
        SELF.BorderFeq{PROP:Fill} = COLOR:White
        SELF.ImageFeq{PROP:Text} = SELF.Filename
      END

      SETPOSITION(SELF.BorderFeq,SELF.XPos,SELF.YPos,SELF.Width,SELF.Height)
      SETPOSITION(SELF.ImageFeq,SELF.XPos,SELF.YPos,SELF.Width,SELF.Height)
      UNHIDE(SELF.BorderFeq)
      UNHIDE(SELF.ImageFeq)
    ELSE
      WinWidth=0{PROP:ClientWidth}
      WinHeight=0{PROP:ClientHeight}
      ZoomModifier=CHOOSE(ZoomFactor=PageWidth,WinWidth/SELF.ImageWidth,ZoomFactor/100)
      TWidth=SELF.ImageWidth*ZoomModifier
      THeight=SELF.ImageHeight*ZoomModifier
      UNHIDE(SELF.ImageFeq)
      SELF.ImageFeq{PROP:MaxWidth}=TWidth
      SELF.ImageFeq{PROP:MaxHeight}=THeight
      SETPOSITION(SELF.ImageFeq,0,0,CHOOSE(TWidth<=WinWidth,TWidth,WinWidth),CHOOSE(THeight<=WinHeight,THeight,WinHeight))
      SETPOSITION(SELF.BorderFeq,0,0,CHOOSE(TWidth<=WinWidth,TWidth,WinWidth),CHOOSE(THeight<=WinHeight,THeight,WinHeight))
      SELF.ImageFeq{PROP:HScroll}=CHOOSE(TWidth>WinWidth)
      SELF.ImageFeq{PROP:VScroll}=CHOOSE(THeight>WinHeight)
      SELF.BorderFeq{PROP:Hide}=CHOOSE(THeight>WinHeight AND TWidth>WinWidth)
      IF EVENT() NOT=EVENT:Sized
        IF SELF.ImageFeq{PROP:VScroll} THEN SELF.ImageFeq{PROP:VScrollPos}=255*(SELF.CentreOnY/100).
        IF SELF.ImageFeq{PROP:HScroll} THEN SELF.ImageFeq{PROP:HScrollPos}=255*(SELF.CentreOnX/100).
      END
    END
    SELF.CentreOnX=0
    SELF.CentreOnY=0
    SELF.ZoomState=ZoomFactor
  ELSIF ~SELF.Neighbour&=NULL
    SELF.Neighbour.Draw(PageNo,ZoomFactor)
  END


PageManagerClass.CoordContained PROCEDURE(SHORT X,SHORT Y)

  CODE
  IF SELF.ZoomState=NoZoom
    IF INRANGE(X-SELF.ImageFeq{PROP:XPos},0,SELF.ImageFeq{PROP:Width}) AND INRANGE(Y-SELF.ImageFeq{PROP:YPos},0,SELF.ImageFeq{PROP:Height}) THEN RETURN SELF.PageNo.
  ELSE
    IF INRANGE(X,0,SELF.ImageFeq{PROP:Width}) AND INRANGE(Y,0,SELF.ImageFeq{PROP:Height}) THEN RETURN SELF.PageNo.
  END
  IF ~SELF.Neighbour&=NULL THEN RETURN SELF.Neighbour.CoordContained(X,Y).
  RETURN 0


PageManagerClass.Delete PROCEDURE(LONG PageNo)
  CODE
  IF SELF.PageNo=PageNo
    DESTROY(SELF.ImageFeq)
    DESTROY(SELF.BorderFeq)
    SELF.ZoomState=NoZoom
  ELSIF ~SELF.Neighbour&=NULL
    SELF.Neighbour.Delete(PageNo)
  END


PageManagerClass.Delete PROCEDURE
  CODE
  IF ~SELF.Neighbour&=NULL THEN SELF.Neighbour.Delete.
  SELF.Delete(SELF.PageNo)


PageManagerClass.Kill PROCEDURE
  CODE
  IF ~SELF.Neighbour&=NULL
    SELF.Neighbour.Kill
    DISPOSE(SELF.Neighbour)
  END
  DESTROY(SELF.ImageFeq)
  DESTROY(SELF.BorderFeq)
  DISPOSE(SELF.Filename)


PageManagerClass.Exists PROCEDURE(LONG PageNo)
  CODE
  IF SELF.PageNo=PageNo
    RETURN True
  ELSIF ~SELF.Neighbour &=NULL
    RETURN SELF.Neighbour.Exists(PageNo)
  END
  RETURN False


PageManagerClass.HighLight PROCEDURE(LONG PageNo)
  CODE
  IF SELF.BorderFeq{PROP:Type}=CREATE:Box
    SELF.BorderFeq{PROP:Color}=CHOOSE(SELF.PageNo=PageNo,COLOR:Red,COLOR:Black)
  END
  IF ~SELF.Neighbour&=NULL THEN SELF.Neighbour.HighLight(PageNo).


PageManagerClass.SetCentre PROCEDURE(LONG PageNo,BYTE X,Byte Y)
  CODE
  SELF.CentreOnX=CHOOSE(SELF.PageNo=PageNo,X,0)
  SELF.CentreOnY=CHOOSE(SELF.PageNo=PageNo,Y,0)
  IF ~SELF.Neighbour&=NULL THEN SELF.Neighbour.SetCentre(PageNo,X,Y).


PageManagerClass.GetProp PROCEDURE(LONG PageNo,USHORT Prop)
  CODE
  IF SELF.PageNo=PageNo
    RETURN SELF.ImageFeq{Prop}
  ELSIF ~SELF.Neighbour&=NULL
    RETURN SELF.Neighbour.GetProp(PageNo,Prop)
  END
  RETURN 0


!---------------------------------------------------------


Idx2Percentile  PROCEDURE(PrintPreviewClass SELF,BYTE Index)
   CODE
?  ASSERT(INRANGE(Index,0,RECORDS(SELF.ZoomQueue)))
   IF Index
     GET(SELF.ZoomQueue,Index)
     ASSERT(~ERRORCODE())
     RETURN SELF.ZoomQueue.Percentile
   ELSE
     RETURN SELF.UserPercentile
   END


Percentile2Idx  PROCEDURE(PrintPreviewClass SELF,SHORT Percentile)
c  BYTE
   CODE
   LOOP c=1 TO RECORDS(SELF.ZoomQueue)
     GET(SELF.ZoomQueue,c)
     ASSERT(~ERRORCODE())
     IF SELF.ZoomQueue.Percentile=Percentile THEN RETURN c.
   END
   RETURN RECORDS(SELF.ZoomQueue)+1       !error condition

ReportManager.Init PROCEDURE(ProcessClass PC,<REPORT R>,<PrintPreviewClass PV>)
  CODE
    SELF.Process &= PC
    SELF.Report &= R
    SELF.Preview &= PV
    IF ~SELF.Preview &= NULL
      SELF.PreviewQueue &= NEW PreviewQueue
      PV.Init(SELF.PreviewQueue)
    END
    SELF.RecordsPerCycle = 1
    SELF.TimeSlice = 100
    SELF.Processors &= NEW ProcessorQueue

ReportManager.Kill PROCEDURE
  CODE
    IF SELF.Dead OR SELF.Process &= NULL THEN RETURN Level:Notify.
    DISPOSE(SELF.PreviewQueue)
    IF ~SELF.Preview &= NULL
      SELF.Preview.Kill
    END
    SELF.Process.Kill
    DISPOSE(SELF.Processors)
    RETURN PARENT.Kill()

ReportManager.AddItem PROCEDURE( RecordProcessor RP )
  CODE
  ASSERT(~SELF.Processors &= NULL,'Object not initialized')
  SELF.Processors.P &= RP
  ADD(SELF.Processors)

ReportManager.Next PROCEDURE
  CODE
    CASE SELF.Process.Next()
    OF Level:Notify
      IF SELF.Process.RecordsProcessed
        SELF.Response = RequestCompleted
        POST(Event:CloseWindow)
        RETURN Level:Notify
      END
    OROF Level:Fatal
      SELF.Response = RequestCancelled
      POST(Event:CloseWindow)
      RETURN Level:Fatal
    END
    RETURN Level:Benign

ReportManager.Open  PROCEDURE
  CODE
    PARENT.Open
    IF ~SELF.DeferOpenReport
      SELF.OpenReport
    END

ReportManager.Ask PROCEDURE
  CODE
    IF SELF.DeferWindow
      IF SELF.WaitCursor
        SETCURSOR(CURSOR:Wait)
      END
      SELF.StartTime = CLOCK()
      HIDE(0)
    END
    PARENT.Ask

ReportManager.OpenReport  PROCEDURE
RVal BYTE,AUTO
  CODE
    SELF.Process.Reset() ! Needed for 're-read' case
    RVal = SELF.Next()
    SELF.DeferOpenReport = 0
    IF RVal
      SELF.TakeNoRecords
    ELSE
      SELF.OpenFailed = 0
      IF ~SELF.Report&=NULL
        OPEN(SELF.Report)
        IF ~SELF.Preview &= NULL
          SELF.Report{PROP:Preview} = SELF.PreviewQueue.Filename
        END
      END
    END
    RETURN RVal


ReportManager.TakeNoRecords PROCEDURE
  CODE
    SELF.Errors.Throw(Msg:NoRecords)
    SELF.OpenFailed = 1

ReportManager.TakeCloseEvent PROCEDURE
I LONG,AUTO
RVal BYTE(Level:Benign)
  CODE
    IF EVENT() = EVENT:CloseWindow
      IF SELF.WaitCursor
        SETCURSOR()
      END
      IF ~SELF.KeepVisible
        TARGET{PROP:Hide} = 1
      END
      LOOP I = 1 TO RECORDS(SELF.Processors)
        GET(SELF.Processors,I)
        RVal = SELF.Processors.P.TakeClose()
      END
      IF ~RVal
        SELF.AskPreview()
      END
      IF ~SELF.Report&=NULL
        CLOSE(SELF.Report)
      END
    END
    RETURN RVal

ReportManager.TakeAccepted PROCEDURE
  CODE
    CASE Accepted()
    OF SELF.QueryControl
       SELF.Process.TakeLocate()
    END
    RETURN PARENT.TakeAccepted()

ReportManager.TakeRecord PROCEDURE
I            LONG,AUTO
RVal         BYTE(Level:Benign)
  CODE
    RVal = SELF.Process.TakeRecord()
    DO CheckState
    LOOP I = 1 TO RECORDS(SELF.Processors)
      GET(SELF.Processors,I)
      RVal = SELF.Processors.P.TakeRecord()
      DO CheckState
    END
    IF SELF.Next() THEN
      TARGET{PROP:Timer} = 0
      RETURN Level:Notify
    .
    RETURN RVal

CheckState ROUTINE
    CASE RVal
    OF Level:Fatal
      TARGET{PROP:Timer} = 0
      POST(EVENT:CloseWindow)
    OROF Level:Notify
      RETURN Level:Notify
    END



ReportManager.TakeWindowEvent PROCEDURE
StartOfCycle LONG,AUTO
StartTime    LONG,AUTO
TimeTaken    LONG,AUTO
RVal         BYTE(Level:Benign)
  CODE
    IF EVENT() = EVENT:Timer
      IF SELF.DeferOpenReport
        SELF.OpenReport()
      END
      IF SELF.OpenFailed THEN RETURN Level:Fatal.
! Take a timer event. Adjust RecordsPerCycle to get a granularity of around SELF.TimeSlice
      StartOfCycle = SELF.Process.RecordsProcessed
      StartTime = CLOCK()
      IF SELF.DeferWindow AND StartTime-SELF.StartTime > SELF.DeferWindow * 100
        TARGET{PROP:Hide} = 0
        SELF.DeferWindow = 0
      END
      LOOP
        LOOP WHILE SELF.Process.RecordsProcessed - StartOfCycle < SELF.RecordsPerCycle
          RVal = SELF.TakeRecord()
          IF RVal THEN RETURN RVal .
        END
        TimeTaken = CLOCK()-StartTime
        IF 5 * TimeTaken < SELF.TimeSlice * 4       ! Use integer arithmetic for speed
          SELF.RecordsPerCycle += SELF.RecordsPerCycle
        END
      WHILE 2 * TimeTaken < SELF.TimeSlice
      IF 2 * TimeTaken > SELF.TimeSlice * 3 AND SELF.RecordsPerCycle > 1
        SELF.RecordsPerCycle = SELF.RecordsPerCycle * 0.5
      END
    END
    RETURN PARENT.TakeWindowEvent()


ReportManager.AskPreview PROCEDURE

DoFlush     UNSIGNED,AUTO

  CODE
  IF NOT SELF.Report &= NULL
    IF NOT SELF.Preview &= NULL AND SELF.Response = RequestCompleted
      ENDPAGE(SELF.Report)
      DoFlush = CHOOSE (NOT SELF.SkipPreview, SELF.Preview.Display(SELF.Zoom), TRUE)
      SELF.Report {PROP:FlushPreview} = DoFlush
      FREE(SELF.Preview.ImageQueue)
    END
  END
