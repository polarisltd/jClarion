  MEMBER

BaseClassDllMode     EQUATE(0)

  INCLUDE('ICCLIENT.INC')
  INCLUDE('ICWINDOW.INC')
  INCLUDE('ICSTD.EQU')
  INCLUDE('TPLEQU.CLW')

  MAP
    INCLUDE('ICSTD.INC')
    GetParentFeq(SIGNED, *WebWindowBaseClass),SIGNED
    GetWebActiveFrame,*WebFrameClass
    PictureKind(STRING),STRING
    PostAccepted(SIGNED Feq)
    SetPseudoFeqs(*SIGNED, *SIGNED)
    SetWebActiveFrame(<*WebFrameClass>)
    MODULE('')
      WebControlFactory(SIGNED Type),*WebControlClass
    END
  .


WebActiveFrame       &WebFrameClass
DummyFrame           WebFrameClass

!! Private Functions...

GetParentFeq         PROCEDURE(SIGNED Feq, *WebWindowBaseClass OwnerWindow)

ParentFeq            SIGNED,AUTO

  CODE
  ParentFeq = Feq{PROP:Parent}

  IF (ParentFeq = 0)
    CASE (Feq{PROP:Type})
    OF CREATE:MENU
    OROF CREATE:ITEM
      ParentFeq = OwnerWindow.GetMenubarFeq()
    ELSE
      IF (Feq{PROP:intoolbar})
        ParentFeq = OwnerWindow.GetToolbarFeq()
      ELSE
        ParentFeq = FEQ:ClientArea
      END
    END
  END

  RETURN ParentFeq


PictureKind        PROCEDURE(STRING Picture)

Kind            STRING(1),AUTO

  CODE
  Kind = Picture[1]

  IF (Kind = '@')
    Kind = Picture[2]
  END
  RETURN UPPER(Kind)


PostAccepted       PROCEDURE(SIGNED Feq)
  CODE
  IF (Feq{PROP:std} = STD:Close)
    POST(EVENT:CloseWindow)
  ELSE
    POST(EVENT:Accepted, Feq)
  END


!- Frame Management ----------------------------------------------------------

WebFrameClass.CopyControlsToWindow     PROCEDURE(*WebWindowClass OwnerWindow, BYTE MergeMenu, BYTE MergeTool)

  CODE


WebFrameClass.TakeEvent                PROCEDURE

  CODE
  RETURN REPLY:NONE


WebFrameClass.CopyControlToWindow      PROCEDURE(*WebWindowClass OwnerWindow, SIGNED Feq)

x                    SIGNED,AUTO
y                    SIGNED,AUTO
w                    SIGNED,AUTO
h                    SIGNED,AUTO
NewControl           &WebControlClass
Type                 SIGNED,AUTO

  CODE
  Type = SELF.FrameWindow $ Feq{PROP:Type}
!  CREATE(Feq, Type, CHOOSE(SELF.FrameWindow $ Feq{PROP:Parent}=SELF.GetToolbarFeq(), 0, SELF.FrameWindow $ Feq{PROP:parent}))
  CREATE(Feq, Type, CHOOSE(SELF.FrameWindow $ Feq{PROP:intoolbar}=1, 0, SELF.FrameWindow $ Feq{PROP:parent}))
  Feq{PROP:text} = SELF.FrameWindow $ Feq{PROP:text}
  Feq{PROP:icon} = '~' & SELF.FrameWindow $ Feq{PROP:icon}
  Feq{PROP:disable} = SELF.FrameWindow $ Feq{PROP:disable}
  Feq{PROP:hide} = SELF.FrameWindow $ Feq{PROP:hide}
  Feq{PROP:tooltip} = SELF.FrameWindow $ Feq{PROP:tooltip}
  SETTARGET(SELF.FrameWindow)
  GETPOSITION(Feq, x, y, w, h)
  SETTARGET()
  SETPOSITION(Feq, x, y, w, h)

  !Need to mark the control as belonging to the toolbar ...
  IF (SELF.FrameWindow $ Feq{PROP:intoolbar})
    NewControl &= OwnerWindow.AddControl(Feq, IC:GetControlType(Feq))
    IF (NewControl.ParentFeq = FEQ:ClientArea)
      NewControl.ParentFeq = OwnerWindow.GetToolbarFeq()
    END
  END


WebFrameClass.GetToolbarFeq      PROCEDURE
  CODE

  RETURN SELF.ToolbarFeq


WebFrameClass.GetMenubarFeq      PROCEDURE
  CODE

  RETURN SELF.MenubarFeq


!- Control List Class --------------------------------------------------------

WebControlListClass.AddControlsToLayout    PROCEDURE(*WebControlQueue Source, *LayoutHtmlClass Layout)

CurIndex             SIGNED,AUTO

  CODE
  LOOP CurIndex = 1 TO RECORDS(Source)
    GET(Source, CurIndex)
    IF (Source.ThisControl.GetVisible())
      Layout.Insert(Source.ThisControl)
    END
  END


WebControlListClass.CreateHtml PROCEDURE(*WebControlQueue Source, *HtmlClass Target, STRING style, SIGNED SnapX, SIGNED SnapY)

Layout                  LayoutHtmlClass

  CODE
  Layout.Init(style, SnapX, SnapY)
  SELF.AddControlsToLayout(Source, Layout)
  Layout.CreateHtml(Target)
  Layout.Kill


WebControlListClass.CreateHtml PROCEDURE(*WebControlQueue Source, *HtmlClass Target, STRING Style)

  CODE
  ASSERT(FALSE)


WebControlListClass.CreateHtmlExtra PROCEDURE(*WebControlQueue Source, *HtmlClass Target)

CurIndex             SIGNED,AUTO

  CODE
  LOOP CurIndex = 1 TO RECORDS(Source)
    GET(Source, CurIndex)
    IF (Source.ThisControl.GetVisible())
      Source.ThisControl.CreateHtmlExtra(Target)
    END
  END


WebControlListClass.Init            PROCEDURE
  CODE


WebControlListClass.Kill            PROCEDURE
  CODE


WebControlListClass.SetParentDefaults   PROCEDURE(*WebControlQueue Source, *WebControlClass Other, *Rect ParentPos)

CurIndex             SIGNED,AUTO

  CODE
  LOOP CurIndex = 1 TO RECORDS(Source)
    GET(Source, CurIndex)
    Source.ThisControl.SetParentDefaults(Other, ParentPos)
  END


!- Window Base Class ---------------------------------------------------------

!! This is an abstract interface - so there is no need to define the methods !!


!- Control Base Class---------------------------------------------------------

WebControlClass.CreateParams          PROCEDURE(*HtmlClass Target)
  CODE
  RETURN


WebControlClass.GetAppletType         PROCEDURE
  CODE
  RETURN '' ! If this is returned then it should not be a Object that uses java.


WebControlClass.GetPosition       PROCEDURE(*SIGNED x, *SIGNED y, *SIGNED width, *SIGNED height)

  CODE
  GETPOSITION(SELF.Feq, x, y, width, height)


WebControlClass.SetQueue     PROCEDURE(*QUEUE Source)
  CODE



WebControlClass.SetChildDefaults  PROCEDURE

  CODE

WebControlClass.DoSetChildDefaults  PROCEDURE

Children             WebControlQueue
MyRect               GROUP(Rect)
                     .

  CODE
  SELF.GetPosition(MyRect.x, MyRect.y, MyRect.width, MyRect.height)
  SELF.OwnerWindow.GetChildren(Children, SELF.ParentFeq)
  SELF.OwnerWindow.SetParentDefaults(Children, SELF, MyRect)


WebControlClass.SetParentDefaults   PROCEDURE(*WebControlClass Other, *Rect ParentPos)

MyRect               LIKE(Rect)

  CODE
  IF (Other.ParentFeq = SELF.ParentFeq) AND (Other.Feq <> SELF.Feq)
    GetPosition(SELF.Feq, MyRect.x, MyRect.y, MyRect.width, MyRect.height)
    IF (MyRect.x >= ParentPos.x) AND |
       (MyRect.y >= ParentPos.y) AND |
       (MyRect.x + MyRect.width < ParentPos.x + ParentPos.width) AND |
       (MyRect.y + MyRect.height < ParentPos.y + ParentPos.height)
      SELF.ParentFeq = Other.Feq
    END
  END


WebControlClass.CreateJslData   PROCEDURE(*JslManagerClass Target)

  CODE


WebControlClass.BeforeResetControl PROCEDURE
  CODE


WebControlClass.GetLevel           PROCEDURE

Level           SIGNED(0)
Feq             SIGNED,AUTO

  CODE
  Feq = SELF.Feq
  LOOP WHILE(Feq <> 0)
    Level += 1
    Feq = Feq{PROP:parent}
  END
  RETURN Level


WebControlClass.Init               PROCEDURE(SIGNED Feq, *WebWindowBaseClass OwnerWindow)

  CODE
  ASSERT(NOT OwnerWindow &= NULL)
  SELF.Container &= NULL
  SELF.Feq = Feq
  SELF.ParentFeq = GetParentFeq(Feq, OwnerWindow)
  SELF.RealParentFeq = SELF.ParentFeq
  SELF.LastUseValue = ''
  SELF.ActionOnAccept = Update:OnBrowser
  SELF.OwnerWindow &= OwnerWindow
  SELF.DisabledAction = OwnerWindow.DisabledAction


WebControlClass.Kill               PROCEDURE
  CODE


WebControlClass.GetAlignText       PROCEDURE
  CODE
  IF (SELF.Feq{PROP:left})
    RETURN 'LEFT'
  ELSIF (SELF.Feq{PROP:right})
    RETURN 'RIGHT'
  ELSIF (SELF.Feq{PROP:center})
    RETURN 'CENTER'
  END
  RETURN ''


WebControlClass.GetCellAttributes        PROCEDURE(*HtmlClass Target)

CurFont         HtmlFontClass

  CODE
  IF (SELF.OwnerWindow.Server.Client.Browser.SupportsStyleSheets)
    GETFONT(SELF.Feq, CurFont.Face, CurFont.Size, CurFont.Color, CurFont.Style)
    IF (Target.GetFontChanged(CurFont))
      RETURN Target.GetFontStyle(CurFont)
    END
  END
  RETURN ''


WebControlClass.GetTableAttributes        PROCEDURE

  CODE
  IF (SELF.OwnerWindow.FormatBorderWidth)
    RETURN ' BORDER=' & SELF.OwnerWindow.FormatBorderWidth
  END
  RETURN ''


WebControlClass.CreateCellContents PROCEDURE(*HtmlClass Target)

  CODE


WebControlClass.CreateHtml PROCEDURE(*HtmlClass Target)

  CODE
  SELF.CreateCellHeader(Target)
  SELF.CreateCellContents(Target)
  SELF.CreateCellFooter(Target)


WebControlClass.CreateHtmlExtra PROCEDURE(*HtmlClass Target)

  CODE


WebControlClass.CreateCellHeader PROCEDURE(*HtmlClass Target)

  CODE
  SELF.PushFont(Target)
  Target.WriteControlHeader


WebControlClass.CreateCellFooter PROCEDURE(*HtmlClass Target)

  CODE
  Target.WriteControlFooter
  SELF.PopFont(Target)


WebControlClass.CreateColorParameters     PROCEDURE(*HtmlClass Target, BYTE AutoSpotLink)
BackColor            LONG,AUTO
  CODE
  SELF.CreateForeColorParameter(Target)
  BackColor = SELF.GetBackgroundColor()
  IF (BackColor <> COLOR:None)
    Target.WriteAppletParameter('BackColor', IC:RGB(BackColor))
  END
  IF (AutoSpotLink)
  END


WebControlClass.CreateForeColorParameter  PROCEDURE(*HtmlClass Target)
CurFont         HtmlFontClass
ForeColor            LONG,AUTO
  CODE
  SELF.GetFont(CurFont)
  ForeColor = CurFont.Color

! If it's a child applet the forecolor of the container applet will be default
! not BLACK..
  IF (((NOT (SELF.Container &= NULL)) OR (ForeColor <> 0)) AND (ForeColor <> COLOR:None))
    Target.WriteAppletParameter('ForeColor', IC:RGB(ForeColor))
  END


WebControlClass.GetBackgroundColor      PROCEDURE(LONG DefaultColor)
BackColor            LONG
  CODE
  BackColor = SELF.Feq{PROP:background}
  IF (BackColor <> COLOR:None)
    RETURN BackColor
  END
  RETURN SELF.GetParentBackgroundColor(DefaultColor)


WebControlClass.GetParentBackgroundColor      PROCEDURE(LONG DefaultColor)
ParentControlGroup   GROUP(WebControlRefGroup).
  CODE
  SELF.OwnerWindow.GetControl(SELF.RealParentFeq, ParentControlGroup)
  IF (NOT ParentControlGroup.Control &= NULL)
    RETURN ParentControlGroup.Control.GetBackgroundColor(DefaultColor)
  END
  RETURN SELF.OwnerWindow.GetBackgroundColor(DefaultColor)


WebControlClass.GetCanDisable      PROCEDURE
  CODE
  RETURN FALSE


WebControlClass.GetIsChild      PROCEDURE(SIGNED ParentFeq, SIGNED Type=0)

  CODE
  IF (SELF.ParentFeq = ParentFeq)
    IF (Type = 0) OR (Type = SELF.Feq{PROP:type})
      IF SELF.GetVisible()
        RETURN SELF.Feq
      END
    END
  END
  RETURN 0


WebControlClass.GetChoiceChanged   PROCEDURE
  CODE
  IF (SELF.LastChoice = CHOICE(SELF.Feq))
    RETURN FALSE
  END
  RETURN TRUE


WebControlClass.GetFont           PROCEDURE(*HtmlFontClass CurFont)
  CODE
  GETFONT(SELF.Feq, CurFont.Face, CurFont.Size, CurFont.Color, CurFont.Style)


WebControlClass.GetEventAction     PROCEDURE(SIGNED EventNo)

  CODE
  IF (EventNo = EVENT:Accepted)
    RETURN SELF.ActionOnAccept
  END
  RETURN Update:OnBrowser


WebControlClass.GetHasHotkey       PROCEDURE
  CODE
  RETURN FALSE


WebControlClass.GetNameAttribute      PROCEDURE(*HtmlClass Target)

  CODE
  RETURN ' NAME="X' & IC:Feq2Id(SELF.Feq) & '"'


WebControlClass.GetText             PROCEDURE

  CODE
  IF (SELF.GetHasHotkey())
    RETURN IC:StripHotkey(CLIP(SELF.Feq{PROP:ScreenText}))
  END
  RETURN CLIP(SELF.Feq{PROP:ScreenText})


WebControlClass.GetQuotedText       PROCEDURE
  CODE
  RETURN IC:QuoteText(SELF.GetText(), IC:RESET:Text)


WebControlClass.GetUseChanged      PROCEDURE
  CODE
  IF (SELF.LastUseValue = CONTENTS(SELF.Feq))
    RETURN FALSE
  END
  RETURN TRUE


WebControlClass.GetVisible            PROCEDURE

  CODE
  IF (SELF.DisabledAction = DISABLE:Hide) OR |
     ((SELF.DisabledAction = DISABLE:OptHide) AND NOT SELF.GetCanDisable())
    IF NOT SELF.Feq{PROP:enabled}
      RETURN FALSE
    END
  END
  RETURN SELF.Feq{PROP:visible}


WebControlClass.PushFont           PROCEDURE(*HtmlClass Target)
CurFont         HtmlFontClass
  CODE
  SELF.GetFont(CurFont)
  Target.PushFont(CurFont, SELF.Feq)


WebControlClass.PopFont            PROCEDURE(*HtmlClass Target)
  CODE
  Target.PopFont(SELF.Feq)


WebControlClass.RefreshDisabled    PROCEDURE(*JslManagerClass Target, SIGNED IsEnabled, *BYTE WasEnabled)
  CODE
  IF (IsEnabled <> WasEnabled)
    IF (IsEnabled)
      Target.SetAttribute(Jsl:Enable)
    ELSE
      Target.SetAttribute(Jsl:Disable)
    END
    WasEnabled = IsEnabled
  END


WebControlClass.ResetControl       PROCEDURE(*SubmitItemClass Source)

  CODE
  IF (SELF.Feq{PROP:std} = STD:Close)
    POST(EVENT:CloseWindow)
  ELSE
    POST(Source.Event, SELF.Feq)
  END


WebControlClass.ResetFromQueue     PROCEDURE(BYTE How, LONG offset=0, LONG number=1)
  CODE


WebControlClass.SetAutoSpotLink        PROCEDURE(BYTE OnOff)
  CODE


WebControlClass.SetBorderWidth     PROCEDURE(SIGNED Width)
  CODE


WebControlClass.SetDescription     PROCEDURE(STRING NewText)
  CODE


WebControlClass.SetBreakable       PROCEDURE(BYTE CanBreak)
  CODE


WebControlClass.SetEventAction     PROCEDURE(SIGNED EventNo, BYTE Action)

  CODE
  IF (EventNo = EVENT:Accepted)
    SELF.ActionOnAccept = Action
  END



WebControlClass.UpdateCopyChoice   PROCEDURE
  CODE
  SELF.LastChoice = CHOICE(SELF.Feq)


WebControlClass.UpdateCopyUse      PROCEDURE
  CODE
  SELF.LastUseValue = CONTENTS(SELF.Feq)



WebNullControlClass.CreateHtml       PROCEDURE(*HtmlClass Target)

  CODE


WebNullControlClass.CreateJslData   PROCEDURE(*JslManagerClass Target)

  CODE


WebNullControlClass.GetCellAttributes        PROCEDURE(*HtmlClass Target)

  CODE
  RETURN ''


WebNullControlClass.GetAppletType         PROCEDURE
  CODE

  IF SELF.OwnerWindow.AllowJava
    RETURN 'NullApplet' ! Don't want to prevent java control grouping
  ELSE
    RETURN ''
  END


WebNullControlClass.GetIsChild      PROCEDURE(SIGNED ParentFeq, SIGNED Type=0)

  CODE
  RETURN 0


WebNullControlClass.GetVisible    PROCEDURE

  CODE
  RETURN FALSE



!!!!!!!!!!!!!!!!!!!!! WebWindowClass !!!!!!!!!!!!!!!!!!!!!

WebWindowClass.AddControl  PROCEDURE(*WebControlClass NewControl)

  CODE
  ASSERT(~NewControl &= NULL)
  SELF.Controls.Feq = NewControl.Feq
  SELF.Controls.ThisControl &= NewControl

  ADD(SELF.Controls, +SELF.Controls.Feq)


WebWindowClass.AddControl  PROCEDURE(SIGNED Feq, *WebControlClass NewControl)

  CODE
  ASSERT(~NewControl &= NULL)
  NewControl.Init(Feq, SELF)
  SELF.AddControl(NewControl)


WebWindowClass.AddControl  PROCEDURE(SIGNED Feq, SIGNED Type)

NewControl           &WebControlClass

  CODE

  IF (Type = 0)
    Type = IC:GetControlType(Feq)
  END
  IF (NOT SELF.GetControl(Feq))
    NewControl &= WebControlFactory(Type)

    IF (NOT NewControl &= NULL)
      SELF.AddControl(Feq, NewControl)
    END
    RETURN NewControl
  END
  RETURN SELF.Controls.ThisControl


WebWindowClass.AddControlsToLayout     PROCEDURE(*LayoutHtmlClass Layout, SIGNED ParentFeq)

Children             WebControlQueue

  CODE
  SELF.GetChildren(Children, ParentFeq)
  SELF.AddControlsToLayout(Children, Layout)


WebWindowClass.BodyHeader      PROCEDURE(*HtmlClass Target)
  CODE


WebWindowClass.BodyFooter      PROCEDURE(*HtmlClass Target)
  CODE


WebWindowClass.CreateChildHtml PROCEDURE(*HtmlClass Target, SIGNED ParentFeq, STRING Style)

Controls                WebControlQueue

  CODE
  SELF.GetChildren(Controls, ParentFeq)
  SELF.CreateHtml(Controls, Target, Style, SELF.SnapX, SELF.SnapY)


WebWindowClass.CreateHtmlPage        PROCEDURE(*HtmlClass Target, STRING HtmlFilename)
  CODE

  Target.CreateOpen(HtmlFilename, SELF.HtmlOption, SELF.Server.JavaLibraryPath, SELF.Server.Client)
  SELF.CreatePageHeader(Target)
  SELF.CreateChildHtml(Target, 0, SELF.GetTableAttributes())
  SELF.CreatePageFooter(Target)
  Target.Close

  SELF.SentHtml = TRUE


WebWindowClass.CreatePageFooter  PROCEDURE(*HtmlClass Target)

  CODE

  IF SELF.AllowJava
    Target.WriteSubmitApplet(SELF.TimerDelay*1000, SELF.TimerAction)
  END
  Target.WriteFormFooter
  IF SELF.AllowJava
    Target.WriteJavaScript
  END
  SELF.BodyFooter(Target)
  IF (SELF.IsCentered)
     Target.Writeln('<</CENTER>')
  END
  Target.Writeln('<</BODY>')

  Target.Writeln('<</HTML>')


WebWindowClass.CreatePageHeader  PROCEDURE(*HtmlClass Target)

  CODE
  Target.Writeln('<<HTML>')
  Target.WriteFrameCheckScript()
  IF (SELF.Server.Client.Browser.SupportsStyleSheets)
    Target.Writeln('<<SCRIPT>')
    Target.Writeln('  document.writeln(''<<STYLE>'');')
    Target.Writeln('  document.writeln(''A {{color: '' + document.linkColor + ''}'')')
    Target.Writeln('  document.writeln(''<</STYLE>'');')
    Target.Writeln('<</SCRIPT>')
  END
  IF (SELF.TimerAction = Update:Refresh)
    Target.WriteRefreshTimer(SELF.TimerDelay)
  END
  Target.Writeln('<<HEAD>')
  Target.Write('<<TITLE>')
  SELF.TitleContents(Target)
  Target.Writeln('<</TITLE>')
  !#EMBED (%InHTMLheader, 'Internet, Inside <<HEAD> section')
  Target.Writeln('<</HEAD>')

  Target.Write('<<BODY')
  IF (SELF.PageBackground = COLOR:None)
    Target.Write(' BGCOLOR="' & IC:ColorText(COLOR:Silver) & '"')
  ELSE
    Target.Write(' BGCOLOR="' & IC:ColorText(SELF.PageBackground) & '"') 
  END
  IF (SELF.PageImage)
    Target.Write(' BACKGROUND="' & SELF.Files.GetAlias(SELF.PageImage) & '"')
  END
  IF (SELF.AllowJava)
    Target.Write(' onLoad="setuptimer()" onUnload="killtimer()"')
  END
  Target.Writeln('>')
  IF (SELF.IsCentered)
     Target.Writeln('<<CENTER>')
  END
  Target.WriteFormHeader()
  Target.Writeln('<<INPUT TYPE=HIDDEN NAME="X9998" VALUE="">')  ! Java to JavaScript
  Target.Writeln('<<INPUT TYPE=HIDDEN NAME="X9997" VALUE="">')  ! JavaScript to Java control data (for NS 3.0x)
  Target.Writeln('<<INPUT TYPE=HIDDEN NAME="X9996" VALUE="">')  ! NoDefault
  Target.Writeln('<<INPUT TYPE=HIDDEN NAME="X9995" VALUE="">')  ! JavaScript to Java (for NS 3.0x) stores current frame name
  SELF.BodyHeader(Target)


WebWindowClass.CreateUnauthorizedPage   PROCEDURE(*HtmlClass Target, STRING HtmlFilename)
  CODE
  IC:OpenSkeleton('~ICUNAUTH.HTM', SELF.Files.GetProgramRef())
  IC:WritePatched(HtmlFilename)


WebWindowClass.CreateDummyHtmlPage        PROCEDURE(*HtmlClass Target, STRING HtmlFilename)
  CODE
  Target.CreateOpen(HtmlFilename, SELF.HtmlOption, SELF.Server.JavaLibraryPath, SELF.Server.Client)
  Target.Writeln('<<HTML>')
  Target.Writeln('<</HTML>')
  Target.Close


WebWindowClass.GetButtonInClientArea    PROCEDURE

Index                   SIGNED,AUTO
CurFeq                  SIGNED,AUTO

  CODE
  LOOP Index = 1 TO RECORDS(SELF.Controls)
    GET(SELF.Controls, Index)
    CurFeq = SELF.Controls.Feq;
    IF (CurFeq{PROP:type} = CREATE:button)
      IF (SELF.Controls.ThisControl.ParentFeq <> SELF.GetToolbarFeq()) AND (CurFeq{PROP:visible})
        RETURN CurFeq
      END
    END
  END
  RETURN 0


WebWindowClass.GetShowMenubar           PROCEDURE

Controls                WebControlQueue

  CODE

  RETURN CHOOSE(SELF.GetFirstChild(SELF.GetMenubarFeq())<>0, TRUE, FALSE)


WebWindowClass.GetShowToolbar           PROCEDURE
  CODE
  RETURN CHOOSE(SELF.GetFirstChild(SELF.GetToolbarFeq())<>0, TRUE, FALSE)


WebWindowClass.SetChildDefaults   PROCEDURE

Index                   SIGNED,AUTO

  CODE
  LOOP Index = 1 TO RECORDS(SELF.Controls)
    GET(SELF.Controls, Index)
    SELF.Controls.ThisControl.SetChildDefaults
  END


WebWindowClass.SetSplash            PROCEDURE(SIGNED TimerDelay)
  CODE
  SELF.TimerDelay = TimerDelay
  SELF.TimerAction = Update:Refresh
  SELF.IsSplash = TRUE


WebWindowClass.SetTimer            PROCEDURE(SIGNED TimerDelay, SIGNED TimerAction)
  CODE
  SELF.TimerDelay = TimerDelay
  SELF.TimerAction = TimerAction


WebWindowClass.Init        PROCEDURE(*WebServerClass Server, *HtmlClass HtmlTarget, <STRING AuthorizeArea>)

  CODE
  SELF.Server &= Server
  SELF.HtmlTarget &= HtmlTarget
  SELF.Controls &= NEW WebControlQueue
  SELF.Files &= Server.Files
  SELF.WebActiveFrame &= GetWebActiveFrame()

  SELF.AllowJava = TRUE
  SELF.Authorize = FALSE
  SELF.AuthorizeArea = AuthorizeArea
  SELF.AuthorizeFailed = FALSE
  SELF.Background = COLOR:None
  SELF.BackImage = ''
  SELF.BorderWidth = 2
  SELF.CloseImage = 'exit.ico'
  SELF.CreateCaption = TRUE
  SELF.CreateClose = CLOSE:Always
  SELF.CreateToolbar = TRUE
  SELF.DisabledAction = DISABLE:Hide
  SELF.FormatBorderWidth = 0
  SELF.GroupBorderWidth = 2
  SELF.MenubarType = PROP:none
  SELF.OptionBorderWidth = 2
  SELF.PageBackground = COLOR:None
  SELF.PageImage = ''
  SELF.SheetBorderWidth = 2
  SELF.TimerDelay = 0
  SELF.TimerAction = 0
  SELF.IsSecure = FALSE
  SELF.IsCentered = TRUE
  SELF.SetFormatOptions(2, 2, 6, 13)

  SELF.Server.SetSendWholePage(TRUE)

  SetPseudoFeqs(SELF.ToolbarFeq, SELF.MenubarFeq)



WebWindowClass.SetPassword PROCEDURE(<STRING Password>, BYTE CaseSensitive)
  CODE
  SELF.Authorize = TRUE
  SELF.Password = Password
  SELF.PasswordCaseSensitive = CaseSensitive


WebWindowClass.Kill                PROCEDURE

Index           SIGNED,AUTO

  CODE
  IF (~SELF.Controls &= NULL)
    LOOP Index = 1 TO RECORDS(SELF.Controls)
      GET(SELF.Controls, Index)
      ASSERT(~SELF.Controls.ThisControl &= NULL)
      SELF.Controls.ThisControl.Kill
      IF (SELF.Controls.ThisControl.IsDynamic)
        DISPOSE(SELF.Controls.ThisControl)
      END
    END
    DISPOSE(SELF.Controls)
  END
  IF (NOT SELF.Server &= NULL) AND (NOT SELF.AuthorizeFailed)
    SELF.Server.SetSendWholePage(TRUE)
  END


WebWindowClass.CreateJslData    PROCEDURE(*JslManagerClass Target)

Index                   SIGNED,AUTO

  CODE
  LOOP Index = 1 TO RECORDS(SELF.Controls)
    GET(SELF.Controls, Index)
    IF (SELF.Controls.ThisControl.GetVisible())
      SELF.Controls.ThisControl.CreateJslData(Target)
    END
  END


WebWindowClass.GetBackgroundImage      PROCEDURE
  CODE

  RETURN SELF.BackImage


WebWindowClass.GetPageImage      PROCEDURE
  CODE

  RETURN SELF.PageImage


WebWindowClass.GetBackgroundColor      PROCEDURE(LONG DefaultColor)
Color                LONG,AUTO
  CODE
  IF (SELF.Background <> COLOR:None)
    RETURN SELF.Background
  END
  Color = SELF.PageBackground
  IF (Color = COLOR:None)
    Color = DefaultColor
  END
  IF (Color = COLOR:None)
    RETURN COLOR:Silver        ! standard default color
  ELSE
    RETURN Color
  END


WebWindowClass.GetControl          PROCEDURE(SIGNED Feq)

  CODE
  SELF.Controls.Feq = Feq
  GET(SELF.Controls, +SELF.Controls.Feq)
  IF (NOT ERRORCODE())
    RETURN TRUE
  END
  RETURN FALSE


WebWindowClass.GetControl          PROCEDURE(SIGNED Feq, *WebControlRefGroup Result)
  CODE
  Result.Control &= SELF.GetControlInfo(Feq)


WebWindowClass.GetControlInfo      PROCEDURE(SIGNED Feq)

NIL                  &WebControlClass

  CODE
  SELF.Controls.Feq = Feq
  GET(SELF.Controls, +SELF.Controls.Feq)
  IF (ERRORCODE())
    RETURN NIL
  END
  RETURN SELF.Controls.ThisControl


WebWindowClass.GetFirstChild       PROCEDURE(SIGNED ParentFeq, SIGNED Type=0)

Index           SIGNED,AUTO
FirstChild      SIGNED(0)

  CODE
  LOOP Index = 1 TO RECORDS(SELF.Controls)
    GET(SELF.Controls, Index)
    FirstChild = SELF.Controls.ThisControl.GetIsChild(ParentFeq, Type)
    IF (FirstChild)
      BREAK
    END
  END
  RETURN FirstChild


WebWindowClass.GetChildren    PROCEDURE(*WebControlQueue Target, SIGNED ParentFeq, SIGNED Type=0)

Index           SIGNED,AUTO
ThisType        SIGNED,AUTO

  CODE
  LOOP Index = 1 TO RECORDS(SELF.Controls)
    GET(SELF.Controls, Index)
    IF (SELF.Controls.ThisControl.ParentFeq = ParentFeq)
      ! If Type<0 it means all but x, if Type>0 the list is restricted to x
      IF (Type <> 0)
        ThisType =  SELF.Controls.Feq{PROP:type}
        IF (Type < 0)
          IF (ThisType = -Type)
            CYCLE
          END
        ELSE
          IF (ThisType <> Type)
            CYCLE
          END
        END
      END
      Target :=: SELF.Controls
      ADD(Target, +Target.Feq)
    END
  END


WebWindowClass.GetCreateClose      PROCEDURE
  CODE
  CASE SELF.CreateClose
  OF CLOSE:Never
    RETURN FALSE
  OF CLOSE:IfSystem
    RETURN 0{PROP:System}
  OF CLOSE:SystemNoButton
    IF 0{PROP:System} AND NOT SELF.GetButtonInClientArea()
      RETURN TRUE
    END
    RETURN FALSE
  OF CLOSE:Always
    RETURN TRUE
  END


WebWindowClass.GetHelpHandler      PROCEDURE
  CODE
  RETURN ' onClick="' & IC:QuoteJsl('ShowHelp(''' & SELF.GetHelpReference() & ''',''' & SELF.HelpStyle & ''')') & '"'


WebWindowClass.GetHelpReference    PROCEDURE
HelpId               CSTRING(255)
Last                 STRING(1)
  CODE
  IF (SELF.HelpEnabled)
    HelpId = IC:GetAlphaNumeric(0{PROP:hlp})
    IF (HelpId)
      IF (SELF.HelpRelative)
        RETURN SELF.HelpDocument & '#' & HelpId
      ELSE
        Last = SUB(SELF.HelpDocument, -1, 1)
        IF (Last <> '\') AND (Last <> '/')
          RETURN SELF.HelpDocument & '/' & HelpId & '.htm'
        ELSE
          RETURN SELF.HelpDocument & HelpId & '.htm'
        END
      END
    END
  END
  RETURN ''


WebWindowClass.GetHelpTarget       PROCEDURE
  CODE
  RETURN ' HREF="' & SELF.GetHelpReference() & '"'


WebWindowClass.GetTableAttributes     PROCEDURE
Style                CSTRING(255)
Border               SIGNED,AUTO
  CODE
  Border = SELF.BorderWidth
  IF (Border = 0)
    Border = SELF.FormatBorderWidth
  END
  IF (Border)
    Style = Style & ' BORDER=' & Border
  END
  IF (SELF.Background <> COLOR:None)
    Style = Style & ' BGCOLOR="' & IC:ColorText(SELF.Background) & '"'
  END
  IF (SELF.BackImage)
    Style = Style & ' BACKGROUND="' & SELF.Files.GetAlias(SELF.BackImage) & '"'
  END
  RETURN Style


WebWindowClass.GetTargetSecurity   PROCEDURE
  CODE
  IF (SELF.IsSecure) THEN RETURN Secure:Full.
  RETURN Secure:None

WebWindowClass.GetToolbarMode     PROCEDURE
  CODE
  RETURN BrowseMode

WebWindowClass.SetBackground       PROCEDURE(LONG Background, <STRING BackImage>)
  CODE
  SELF.Background = Background
  SELF.BackImage = BackImage


WebWindowClass.SetCentered         PROCEDURE(BYTE IsCentered)
  CODE
  SELF.IsCentered = IsCentered


WebWindowClass.SetHelpDocument     PROCEDURE(STRING Filename, STRING Style)
  CODE
  SELF.HelpEnabled = TRUE
  SELF.HelpRelative = TRUE
  SELF.HelpDocument = Filename
  SELF.HelpStyle = Style

WebWindowClass.SetHelpURL          PROCEDURE(STRING URL, STRING Style)
  CODE
  SELF.HelpEnabled = TRUE
  SELF.HelpRelative = FALSE
  SELF.HelpDocument = URL
  SELF.HelpStyle = Style


WebWindowClass.SetPageBackground   PROCEDURE(LONG Background, <STRING BackImage>)
  CODE
  SELF.PageBackground = Background
  SELF.PageImage = BackImage


WebWindowClass.SetFormatOptions    PROCEDURE(SIGNED dx, SIGNED dy, SIGNED d2x, SIGNED d2y)
  CODE
  SELF.SnapX = dx
  SELF.SnapY = dy
  SELF.HtmlOption.ScaleX = d2x / 4
  SELF.HtmlOption.ScaleY = d2y / 8


WebWindowClass.SuppressControl       PROCEDURE(SIGNED Feq)

NewControl           &WebControlClass

  CODE
  IF (NOT SELF.GetControl(Feq))
    NewControl &= NEW WebNullControlClass
    SELF.AddControl(Feq, NewControl)
  END


WebWindowClass.ResetFromControls   PROCEDURE

CurFeq          SIGNED,AUTO
Type            SIGNED,AUTO
Index           SIGNED,AUTO

  CODE

  CurFeq = 0{PROP:nextfield}
  LOOP WHILE (CurFeq)
    IF (CurFeq)
      Type = IC:GetControlType(CurFeq)
      SELF.AddControl(CurFeq, Type)
    END
    CurFeq = 0{PROP:nextfield, CurFeq}
  END

  CurFeq = 04000H
  LOOP WHILE (CurFeq{PROP:type})
    SELF.AddControl(CurFeq, IC:GetControlType(CurFeq))
    CurFeq += 1
  END

  IF (SELF.CreateCaption)
    SELF.AddControl(FEQ:Caption, CREATE:Caption)
  END

  IF (SELF.CreateToolbar)
    SELF.AddControl(SELF.GetToolbarFeq(), CREATE:Toolbar)
  END

  IF (SELF.MenubarType <> PROP:none)
    SELF.AddControl(SELF.GetMenubarFeq(), CREATE:Menubar)
  END

  SELF.AddControl(FEQ:ClientArea, CREATE:ClientArea)

  IF (SELF.GetCreateClose())
    SELF.AddControl(FEQ:Close, CREATE:Close)
  END
  SELF.SetChildDefaults

  LOOP Index = 1 TO RECORDS(SELF.Controls)
    GET(SELF.Controls, Index)
  END

WebWindowClass.TakeEvent           PROCEDURE

  CODE

  IF (SELF.Server.Active)
    CASE SELF.Server.TakeEvent()
    OF NET:Request
      SELF.TakeRequest
    OF NET:Terminate
      RETURN 1
    END
    CASE (EVENT())
    OF EVENT:NewPage
      IF (SELF.Server.GetReadyForPage())
        SELF.TakeCreatePage
      END
    OF EVENT:OpenWindow
      SELF.ResetFromControls
    END
    SELF.WebActiveFrame.TakeEvent
    IF (SELF.Server.GetReadyForPage())
      POST(EVENT:NewPage)
    END
  END
  RETURN 0


WebWindowClass.TakeCreatePage      PROCEDURE

Client               &WebClientManagerClass
Filename             CSTRING(FILE:MaxFilePath),AUTO

  CODE
  Client &= SELF.Server.Client

  SELF.Files.SelectTarget(SELF.GetTargetSecurity())
  IF (SELF.Server.GetSendWholePage() OR NOT SELF.SentHtml)
    IF (SELF.Authorize AND NOT SELF.GetAuthorized()) ! page/data is protected ..
      Filename = SELF.Files.GetFilename(Content:UnAuthorized)
      SELF.CreateUnauthorizedPage(SELF.HtmlTarget, Filename)
      Client.TakeUnauthorized(Filename, SELF.GetTargetSecurity())
      SELF.AuthorizeFailed = TRUE
      Post(EVENT:CloseWindow)
    ELSE
      Filename = SELF.Files.GetFilename(Content:Html)
      IF (SELF.Server.GetRequestedWholePage())
        Client.NextHtmlPage
        SELF.CreateHtmlPage(SELF.HtmlTarget, Filename)
      ELSE
        Filename = SELF.Files.GetPublicDirectory() & 'dummy.htm'
        SELF.CreateDummyHtmlPage(SELF.HtmlTarget, Filename)
      END
      Client.TakeHtmlPage(Filename, SELF.GetTargetSecurity(), FALSE)
    END
  ELSE
    Client.Jsl.OpenChannel(SELF.GetTargetSecurity(), SELF.Files)
    SELF.CreateJslData(Client.Jsl)
    Client.Jsl.CloseChannel
  END
  SELF.Server.TakePageSent()


! TakeRequest processes the submit string suplied by the browser, and
! resets the windows controls from it.
! It is complicated because pressing return causes the page to be submitted,
! without an entry for a button in the submit string.  When this occurs the
! base class calculates which is the default button, and fakes a button press.
! However, if the option on an entry is to submit the data, then the default
! button should not be pressed.  This is indicated by setting the field X9996 to 1

WebWindowClass.TakeRequest         PROCEDURE

NextSubmit      &SubmitItemClass
Curfeq          SIGNED,AUTO
Index           SIGNED,AUTO
FEQ:NODEFAULT   SIGNED,AUTO
  CODE

  SELF.DefaultButtonNeeded = SELF.Server.GetRequestedWholePage()
  SELF.DefaultButton = 0
  FEQ:NODEFAULT = IC:Id2Feq(9996)

  IF (SELF.Server.GetRequestedWholePage())
    ! Unset check boxes not sent in submit string - so need to pre-clear
    LOOP Index = 1 TO RECORDS(SELF.Controls)
      GET(SELF.Controls, Index)
      SELF.Controls.ThisControl.BeforeResetControl()
    END
  END
  LOOP
    NextSubmit &= SELF.Server.SetNextAction()
    IF (NextSubmit &= NULL)
      BREAK
    END
    CurFeq = NextSubmit.Feq
    CASE (CurFeq)
    OF FEQ:UNKNOWN
       SELF.TakeUnknownSubmit(NextSubmit.Name, NextSubmit.NewValue)
    OF FEQ:NODEFAULT
      IF (NextSubmit.NewValue = 1)
        SELF.DefaultButtonNeeded = FALSE
      END
    ELSE
      IF (SELF.GetControl(CurFeq))
        IF (NextSubmit.Event)
          IF (NOT CurFeq{PROP:disable}) AND (NOT CurFeq{PROP:readonly})
            SELF.Controls.ThisControl.ResetControl(NextSubmit)
          END
        END
      END
    END
  END
  IF (SELF.DefaultButtonNeeded AND SELF.DefaultButton)
    PostAccepted(SELF.DefaultButton)
  END

WebWindowClass.TakeUnknownSubmit  PROCEDURE(STRING ControlName, STRING ControlValue)
  CODE

WebWindowClass.TitleContents      PROCEDURE(*HtmlClass Target)
  CODE
  Target.Write(IC:QuoteText(0{PROP:text}, IC:RESET:Text))


WebWindowClass.GetAuthorized      PROCEDURE
Password            STRING(255)
UserName            STRING(255)
  CODE
  SELF.Server.Broker.GetAuthorizedInfo(SELF.AuthorizeArea, UserName, Password)
  RETURN SELF.ValidatePassword(UserName, Password)


WebWindowClass.ValidatePassword   PROCEDURE(STRING UserName, STRING Password)
  CODE
  IF (NOT SELF.PasswordCaseSensitive)
    Password = UPPER(Password)
    SELF.Password = UPPER(SELF.Password)
  END

  IF (Password = SELF.Password)
    RETURN TRUE
  END
  RETURN FALSE


WebWindowClass.GetWebActiveFrame  PROCEDURE
  CODE

  RETURN SELF.WebActiveFrame


WebWindowClass.GetToolbarFeq      PROCEDURE
  CODE

  RETURN SELF.ToolbarFeq


WebWindowClass.GetMenubarFeq      PROCEDURE
  CODE

  RETURN SELF.MenubarFeq


GetWebActiveFrame                  PROCEDURE

Result                &WebFrameClass
  CODE
  Result &= WebActiveFrame
  IF (WebActiveFrame &= NULL)
    Result &= DummyFrame
  END
  RETURN Result


SetPseudoFeqs                      PROCEDURE(*SIGNED ToolbarFeq, *SIGNED MenubarFeq)
CurFeq          SIGNED,AUTO
Type            SIGNED,AUTO

  CODE

  ToolbarFeq = FEQ:Toolbar ! needed if toolbar has no feq as in CW20
  MenubarFeq = FEQ:Menubar ! needed if toolbar has no feq as in CW20

  CurFeq = 0{PROP:nextfield}
  LOOP WHILE (CurFeq)
    IF (CurFeq)
      Type = IC:GetControlType(CurFeq)
      CASE (Type)
      OF CREATE:TOOLBAR
        ToolbarFeq = CurFeq
      OF CREATE:Menubar
        MenubarFeq = CurFeq
      END
    END
    CurFeq = 0{PROP:nextfield, CurFeq}
  END


SetWebActiveFrame                  PROCEDURE(<*WebFrameClass NewFrame>)
  CODE
  IF (NewFrame &= NULL)
    WebActiveFrame &= DummyFrame
  ELSE
    WebActiveFrame &= NewFrame
    SetPseudoFeqs(WebActiveFrame.ToolbarFeq, WebActiveFrame.MenubarFeq)
  END

