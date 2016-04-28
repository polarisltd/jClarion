
   MEMBER                                 ! This is a MEMBER module


   INCLUDE('ABLPROPR.INC'),ONCE
   INCLUDE('ABLWINR.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ablwman.inc'),ONCE
   INCLUDE('abwindow.inc'),ONCE
   INCLUDE('wbframe.inc'),once
   include('wbserver.inc'),once
   include('wbstd.equ'),once

                     MAP
                       MODULE('WBPreview.CLW')
WebPreview             PROCEDURE(WbServerClass WebServer,QUEUE qReportPages,STRING sWindowTitle,BYTE bShowPageNo,BYTE bShowTotalPages)
                       END
                     END


WebPreview PROCEDURE (WbServerClass WebServer,QUEUE qReportPages,STRING sReportTitle,BYTE bShowPageNo,BYTE bShowTotalPages) !Generated from procedure template - Window

Loc:Zoom             SHORT
Window               WINDOW('Report Preview'),AT(,,394,283),FONT('MS Sans Serif',8,,FONT:regular),SYSTEM,GRAY,RESIZE,MDI
                       PANEL,AT(2,1,390,21),USE(?Panel1),BEVEL(-1)
                       BUTTON,AT(5,4,23,14),USE(?First),FLAT,MSG('First Page'),TIP('First Page'),ICON('VCRFIRST.GIF')
                       BUTTON,AT(34,4,29,14),USE(?Previous),FLAT,MSG('Previous Page'),TIP('Previous Page'),ICON('VCRUP.GIF')
                       BUTTON,AT(69,4,29,14),USE(?Next),FLAT,MSG('Next Page'),TIP('Next Page'),ICON('VCRDOWN.GIF')
                       BUTTON,AT(104,4,29,14),USE(?Last),FLAT,MSG('Last Page'),TIP('Last Page'),ICON('VCRLAST.GIF')
                       BUTTON,AT(139,4,29,14),USE(?ZoomIn),FLAT,MSG('Zoom In'),TIP('Zoom In'),ICON('ZoomIn.gif')
                       BUTTON,AT(174,4,29,14),USE(?ZoomOut),FLAT,MSG('Zoom Out'),TIP('Zoom Out'),ICON('zoomout.gif')
                       BUTTON,AT(209,4,29,14),USE(?SinglePage),FLAT,MSG('One Page'),TIP('One Page'),ICON('1page.gif')
                       BUTTON,AT(244,4,29,14),USE(?TwoPage),FLAT,MSG('Two Pages'),TIP('Two Pages'),ICON('2pages.gif')
                       BUTTON,AT(358,4,29,14),USE(?Close),FLAT,ICON('EXITS.GIF')
                       IMAGE,AT(2,23),USE(?Image1),CENTERED
                       IMAGE('blank.gif'),AT(194,23),USE(?Image3),TILED
                       IMAGE,AT(200,23),USE(?Image2),HIDE,CENTERED
                     END
Web:CurFrame         &WbFrameClass

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
WebWindowManager     WbWindowManagerClass
WebWindow            CLASS(WbWindowClass)
Init                   PROCEDURE()
                     END

Web:Image1           CLASS(WbControlHtmlProperties)   !Web Control Manager for ?Image1
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Image3           CLASS(WbControlHtmlProperties)   !Web Control Manager for ?Image3
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Image2           CLASS(WbControlHtmlProperties)   !Web Control Manager for ?Image2
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

DummyLong           LONG

  CODE
!  GlobalResponse = ThisWindow.Run()
  ThisWindow.Run()

SetWindowTitle  ROUTINE
  ThisWindow{PROP:Text} = CLIP(sReportTitle)
  IF bShowPageNo
    ThisWindow{PROP:Text} = CLIP(ThisWindow{PROP:Text}) & ' - Page ' & POINTER(qReportPages)
  END
  IF bShowTotalPages
    ThisWindow{PROP:Text} = CLIP(ThisWindow{PROP:Text}) & ' of ' & RECORDS(qReportPages)
  END
  EXIT

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
!  GlobalErrors.SetProcedureName('WebPreview')
!  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= DummyLong
  SELF.Errors &= NEW ErrorClass !GlobalErrors
  SELF.AddItem(Toolbar)
!  CLEAR(GlobalRequest)
!  CLEAR(GlobalResponse)
  SELF.AddItem(?Close,RequestCancelled)
  OPEN(Window)
  SELF.Opened=True
  GET(qReportPages,1)
  DO SetWindowTitle
  ?Image1{Prop:Text} = WHAT(qReportPages,1)
  Loc:Zoom = 100
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (WebPreview)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF (WebServer.IsEnabled())
    POST(EVENT:NewPage)
  END
!  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?First
      ThisWindow.Update
      GET(qReportPages,1)
      ?Image1{Prop:Text} = WHAT(qReportPages,1)
      DO SetWindowTitle
      IF ~?Image2{PROP:Hide}
        IF POINTER(qReportPages) < RECORDS(qReportPages)
          GET(qReportPages,POINTER(qReportPages)+1)
          ?Image2{PROP:Text} = WHAT(qReportPages,1)
          GET(qReportPages,POINTER(qReportPages)-1)
        ELSE
          ?Image2{PROP:Text} = 'blank.gif'
        END
      END
    OF ?Previous
      ThisWindow.Update
      IF POINTER(qReportPages) > 1
        GET(qReportPages,POINTER(qReportPages)-1)
        ?Image1{Prop:Text} = WHAT(qReportPages,1)
        IF ~?Image2{PROP:Hide}
          IF POINTER(qReportPages) < RECORDS(qReportPages)
            GET(qReportPages,POINTER(qReportPages)+1)
            ?Image2{PROP:Text} = WHAT(qReportPages,1)
            GET(qReportPages,POINTER(qReportPages)-1)
          ELSE
            ?Image2{PROP:Text} = 'blank.gif'
          END
        END
        DO SetWindowTitle
      END
    OF ?Next
      ThisWindow.Update
      IF POINTER(qReportPages) < RECORDS(qReportPages)
        GET(qReportPages,POINTER(qReportPages)+1)
        ?Image1{Prop:Text} = WHAT(qReportPages,1)
        IF ~?Image2{PROP:Hide}
          IF POINTER(qReportPages) < RECORDS(qReportPages)
            GET(qReportPages,POINTER(qReportPages)+1)
            ?Image2{PROP:Text} = WHAT(qReportPages,1)
            GET(qReportPages,POINTER(qReportPages)-1)
          ELSE
            ?Image2{PROP:Text} = 'blank.gif'
          END
        END
        DO SetWindowTitle
      END
    OF ?Last
      ThisWindow.Update
      GET(qReportPages,RECORDS(qReportPages))
      ?Image1{Prop:Text} = WHAT(qReportPages,1)
      DO SetWindowTitle
      IF ~?Image2{PROP:Hide}
        IF POINTER(qReportPages) < RECORDS(qReportPages)
          GET(qReportPages,POINTER(qReportPages)+1)
          ?Image2{PROP:Text} = WHAT(qReportPages,1)
          GET(qReportPages,POINTER(qReportPages)-1)
        ELSE
          ?Image2{PROP:Text} = 'blank.gif'
        END
      END
    OF ?ZoomIn
      ThisWindow.Update
      IF Loc:Zoom < 500
        Loc:Zoom += 25
      END
    OF ?ZoomOut
      ThisWindow.Update
      IF Loc:Zoom > 25
        Loc:Zoom -= 25
      END
    OF ?SinglePage
      ThisWindow.Update
      ?Image2{PROP:Hide} = TRUE
      Loc:Zoom = 100
      ?Image3{PROP:Text} = 'blank.gif'
    OF ?TwoPage
      ThisWindow.Update
      ?Image2{PROP:Hide} = FALSE
      Loc:Zoom = 50
      IF POINTER(qReportPages) < RECORDS(qReportPages)
        GET(qReportPages,POINTER(qReportPages)+1)
        ?Image2{PROP:Text} = WHAT(qReportPages,1)
        GET(qReportPages,POINTER(qReportPages)-1)
      ELSE
        ?Image2{PROP:Text} = 'blank.gif'
      END
      ?Image3{PROP:Text} = 'linea.gif'
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Web:Image1.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'PixelHeight')
    RETURN CreateIntegerValue(1062 * Loc:Zoom / 100)
  ELSIF (name = 'PixelWidth')
    RETURN CreateIntegerValue(816 * Loc:Zoom / 100)
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Image1.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SubmitOnChange = TRUE


Web:Image3.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'PixelHeight')
    RETURN CreateIntegerValue(1062 * Loc:Zoom / 100)
  ELSIF (name = 'PixelWidth')
    RETURN CreateIntegerValue(1)
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Image2.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'PixelHeight')
    RETURN CreateIntegerValue(1062 * Loc:Zoom / 100)
  ELSIF (name = 'PixelWidth')
    RETURN CreateIntegerValue(816 * Loc:Zoom / 100)
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Image2.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SubmitOnChange = TRUE


WebWindow.Init PROCEDURE

  CODE
  PARENT.Init
  SELF.SetFormatOptions(2, 2, 6, 13)
  Web:Image1.Init(?Image1, FEQ:Unknown)
  SELF.AddControl(Web:Image1.IControlToHtml)
  Web:Image3.Init(?Image3, FEQ:Unknown)
  SELF.AddControl(Web:Image3.IControlToHtml)
  Web:Image2.Init(?Image2, FEQ:Unknown)
  SELF.AddControl(Web:Image2.IControlToHtml)
  IF (WebServer.IsEnabled())
    Web:CurFrame &= GetWebActiveFrame()
    Web:CurFrame.CopyControlsToWindow(TRUE, TRUE)
  END

