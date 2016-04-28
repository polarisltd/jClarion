  MEMBER

BaseClassDllMode     EQUATE(0)

  INCLUDE('ICCLIENT.INC')
  INCLUDE('ICWINDOW.INC')
  INCLUDE('ICCNTRLS.INC')
  INCLUDE('ICSTD.EQU')
  INCLUDE('TPLEQU.CLW')
  INCLUDE('ICWINDOW.TRN')

  MAP
    INCLUDE('ICSTD.INC')
    INCLUDE('ICWINDOW.INC')
  .


Layout:Col1          EQUATE(0)
Layout:Col2          EQUATE(100)
Layout:Col3          EQUATE(200)

Layout:Row1          EQUATE(0)
Layout:Row2          EQUATE(100)
Layout:Row3          EQUATE(200)
Layout:Row4          EQUATE(300)
Layout:Row5          EQUATE(400)

JavaEvents           JslEventsClass,EXTERNAL

RIGHTALIGN           EQUATE(9999)

!! Classes that implement the areas of the window (e.g. toolbar, menu)

WebAreaClass.GetCellAttributes           PROCEDURE(*HtmlClass Target)

Result          CSTRING(255)

  CODE

  Result = Result & ' BGCOLOR="' & IC:ColorText(SELF.GetBackgroundColor()) & '"'
  IF (SELF.BackImage)
    Result = Result & ' BACKGROUND="' & SELF.OwnerWindow.Files.GetAlias(SELF.BackImage) & '"'
  END

  IF (NOT (SELF.OwnerWindow.Server.Client.Browser.SupportsStyleSheets))
    RETURN Result
  END
  RETURN Result & Target.GetFontStyle(SELF.LocalFont)


WebAreaClass.GetBackgroundColor      PROCEDURE(LONG DefaultColor)
  CODE
  IF (SELF.Background <> COLOR:None)
    RETURN SELF.Background
  END
  RETURN SELF.OwnerWindow.GetBackgroundColor(DefaultColor)


WebAreaClass.GetFont           PROCEDURE(*HtmlFontClass CurFont)
  CODE

  CurFont.Face = SELF.LocalFont.Face
  CurFont.Size = SELF.LocalFont.Size
  CurFont.Color = SELF.LocalFont.Color
  CurFont.Style = SELF.LocalFont.Style


WebAreaClass.GetVisible         PROCEDURE
  CODE
  RETURN TRUE


WebAreaClass.Init               PROCEDURE(SIGNED Feq, *WebWindowBaseClass OwnerWindow)
  CODE
  PARENT.Init(Feq, OwnerWindow)

  SELF.ParentFeq = 0
  SELF.RealParentFeq = 0
  SELF.BackImage = ''
  SELF.Background = COLOR:None

  SELF.LocalFont &= NEW HtmlFontClass
  GETFONT(0, SELF.LocalFont.Face, SELF.LocalFont.Size, SELF.LocalFont.Color, SELF.LocalFont.Style)


WebAreaClass.Kill               PROCEDURE
  CODE
  DISPOSE (SELF.LocalFont)


WebAreaClass.PushFont           PROCEDURE(*HtmlClass Target)
CurFont         HtmlFontClass
  CODE
  Target.PushFont(SELF.LocalFont, SELF.Feq)


WebAreaClass.SetBackground      PROCEDURE(LONG Background, <STRING BackImage>)
  CODE
  SELF.Background = Background
  SELF.BackImage = BackImage


WebAreaClass.SetFont            PROCEDURE(<STRING Face>, SIGNED Size, LONG Color, SIGNED Style)
  CODE
  SELF.LocalFont.Face = Face
  SELF.LocalFont.Size = Size
  SELF.LocalFont.Color = Color
  SELF.LocalFont.Style = Style


WebAreaClass.SetParentDefaults   PROCEDURE(*WebControlClass Other, *Rect ParentPos)
  CODE


!--- Caption ---

WebCaptionClass.Init               PROCEDURE(SIGNED Feq, *WebWindowBaseClass OwnerWindow)

  CODE
  PARENT.Init(Feq, OwnerWindow)
  SELF.Background = COLOR:Navy
  SELF.SetFont(,,COLOR:White)


WebCaptionClass.CreateHtml       PROCEDURE(*HtmlClass Target)

  CODE
  SELF.PushFont(Target)
  Target.WriteControlHeader
  Target.Write(SELF.GetQuotedText())
  Target.WriteControlFooter
  SELF.PopFont(Target)


WebCaptionClass.GetCellAttributes        PROCEDURE(*HtmlClass Target)

Result          CSTRING(40)

  CODE

  CASE SELF.Alignment
  OF PROP:right
    Result = ' ALIGN=RIGHT'
  OF PROP:center
  OF PROP:none
    Result = ' ALIGN=CENTER'
  ELSE
    Result = ' ALIGN=LEFT'
  END

  RETURN PARENT.GetCellAttributes(Target) & Result


WebCaptionClass.GetPosition       PROCEDURE(*SIGNED x, *SIGNED y, *SIGNED width, *SIGNED height)

  CODE
  IF (SELF.OwnerWindow.MenubarType <> PROP:left) OR (NOT SELF.OwnerWindow.GetShowMenubar())
    x = Layout:Col2
  ELSE
    x = Layout:Col1
  END
  y = Layout:Row1
  width = Layout:Col3-x
  height = Layout:Row2-Layout:Row1


WebCaptionClass.GetText            PROCEDURE
  CODE
  RETURN 0{PROP:text}


WebCaptionClass.GetVisible         PROCEDURE
  CODE
  IF 0{PROP:text}
    RETURN TRUE
  END
  RETURN FALSE


!--- Menubar ---

WebMenubarClass.Init               PROCEDURE(SIGNED Feq, *WebWindowBaseClass OwnerWindow)

  CODE
  PARENT.Init(Feq, OwnerWindow)
  SELF.Background = 099CCCCH


WebMenubarClass.CreateHtml       PROCEDURE(*HtmlClass Target)

  CODE
  SELF.PushFont(Target)
  SELF.OwnerWindow.CreateChildHtml(Target, SELF.FEQ, '')
  SELF.PopFont(Target)


WebMenubarClass.GetPosition       PROCEDURE(*SIGNED x, *SIGNED y, *SIGNED width, *SIGNED height)

  CODE
  IF (SELF.OwnerWindow.MenubarType = PROP:left)
    x = Layout:Col1
    y = Layout:Row3
    width = Layout:Col2-Layout:Col1
    height = Layout:Row5-Layout:Row3
  ELSIF (SELF.OwnerWindow.MenubarType = PROP:below)
    x = Layout:Col2
    y = Layout:Row3
    width = Layout:Col3-Layout:Col2
    height = Layout:Row4-Layout:Row3
  ELSE
    x = Layout:Col2
    y = Layout:Row2
    width = Layout:Col3-Layout:Col2
    height = Layout:Row3-Layout:Row2
  END


WebMenubarClass.GetVisible         PROCEDURE
  CODE
  RETURN SELF.OwnerWindow.GetShowMenubar()


!--- Toolbar ---

WebToolbarClass.GetAppletType   PROCEDURE

  CODE
  RETURN 'ClarionContainer'


WebToolbarClass.CreateHtml       PROCEDURE(*HtmlClass Target)

ActiveFrame     &WebFrameClass
AppletType      CSTRING(100)
BackColor       LONG,AUTO
ControlNum      SIGNED,AUTO
Controls        WebControlQueue
CurFont         HtmlFontClass
CurIndex        SIGNED,AUTO
width           SIGNED,AUTO
height          SIGNED,AUTO
HtmlCntrls      BYTE(FALSE)
MaxX            SIGNED,AUTO
MaxY            SIGNED,AUTO
PrevAppletType  CSTRING(100)
RightWidth      SIGNED(0)
RightXPos       SIGNED,AUTO
SameAppletType  BYTE(TRUE)
ThisControl     &WebControlClass
x               SIGNED,AUTO
y               SIGNED,AUTO

  CODE
  SELF.PushFont(Target)
  SELF.OwnerWindow.GetChildren(Controls, SELF.OwnerWindow.GetToolbarFeq())

  IF (SELF.OwnerWindow.AllowJava) THEN
    MaxX = 0
    MaxY = 0
    LOOP CurIndex = 1 TO RECORDS(Controls)
      GET(Controls, CurIndex)
      ThisControl &= Controls.ThisControl
      IF (ThisControl.GetVisible())
        IF (ThisControl.GetAppletType() = '')
          HtmlCntrls = TRUE
          BREAK
        END
        IF (SameAppletType)
          IF (AppletType = '')
            AppletType = ThisControl.GetAppletType()
          ELSE
            IF (AppletType <> ThisControl.GetAppletType())
              SameAppletType = FALSE
            END
          END
        END
        ThisControl.GetPosition(x, y, width, height)

        IF (RIGHTALIGN = x)
          RightWidth = width
        ELSE
          IF (x+width > MaxX)
            MaxX = (x + width)
          END
        END

        IF (y+height > MaxY)
          MaxY = (y + height)
        END
      END
    END
  END

  ! Cannot combine controls if there are html controls here.
  IF (HtmlCntrls OR NOT SELF.OwnerWindow.AllowJava)
    SELF.OwnerWindow.CreateChildHtml(Target, SELF.OwnerWindow.GetToolbarFeq(), SELF.GetTableAttributes())
  ELSE
    RightXPos = MaxX
    MaxX += RightWidth
    MaxY += 2

    Target.WriteContainerAppletHeader(SELF.Feq, SELF.GetAppletType(), MaxX, MaxY)
    IF (SameAppletType)
      Target.WriteAppletParameter('className', AppletType)
    END
    SELF.CreateColorParameters(Target)

    BackColor = SELF.GetBackgroundColor()
    IF (BackColor <> COLOR:None)
      Target.WriteAppletParameter('ContainerBgColor',IC:RGB(BackColor))
    END

    SELF.GetFont(CurFont)
    Target.WriteAppletFontParameter(CurFont)

    ControlNum = 1
    LOOP CurIndex = 1 TO RECORDS(Controls)
      GET(Controls, CurIndex)
      ThisControl &= Controls.ThisControl
      ThisControl.Container &= SELF
      IF (ThisControl.GetVisible())
        ThisControl.GetPosition(x, y, width, height)
        IF (x = RIGHTALIGN)
          x = RightXPos
        END

        Target.WriteChildAppletHeader('control' & ControlNum, ThisControl.Feq)

        Target.WriteAppletDimParameter(x, y, width, height)
        IF (NOT SameAppletType)
          Target.WriteAppletParameter('className', ThisControl.GetAppletType())
        END
        ThisControl.CreateParams(Target)

        Target.WriteChildAppletFooter

        ControlNum += 1
      END
    END

    Target.WriteAppletFooter
  END

  SELF.PopFont(Target)


WebToolbarClass.GetPosition       PROCEDURE(*SIGNED x, *SIGNED y, *SIGNED width, *SIGNED height)

  CODE
  IF (SELF.OwnerWindow.MenubarType = PROP:below)
    x = Layout:Col2
    y = Layout:Row2
    width = Layout:Col3-Layout:Col2
    height = Layout:Row3-Layout:Row2
  ELSE
    x = Layout:Col2
    y = Layout:Row3
    width = Layout:Col3-Layout:Col2
    height = Layout:Row4-Layout:Row3
  END


WebToolbarClass.GetVisible         PROCEDURE
  CODE
  RETURN SELF.OwnerWindow.GetShowToolbar()


!--- ClientArea ---

WebClientAreaClass.CreateHtml       PROCEDURE(*HtmlClass Target)

CurFont         HtmlFontClass

  CODE
  SELF.PushFont(Target)
  SELF.OwnerWindow.CreateChildHtml(Target, FEQ:ClientArea, SELF.GetTableAttributes())
  SELF.PopFont(Target)
  IF (SELF.OwnerWindow.IsSplash)
    Target.Write('<<CENTER>')
    Target.Write('<<A HREF="' & SELF.OwnerWindow.Files.GetProgramRef() & '">' & SplashContinueText & '<</A>')
    Target.Writeln('<</CENTER>')
    POST(EVENT:CloseWindow)
  END


WebClientAreaClass.GetBackgroundColor      PROCEDURE(LONG DefaultColor)
Color                LONG,AUTO
  CODE
  IF (SELF.Background <> COLOR:None)
    RETURN SELF.Background
  ELSE
    Color = 0{PROP:background}
  END
  IF (Color = COLOR:None)
    RETURN PARENT.GetBackgroundColor(DefaultColor)
  ELSE
    RETURN Color
  END


WebClientAreaClass.GetPosition       PROCEDURE(*SIGNED x, *SIGNED y, *SIGNED width, *SIGNED height)

  CODE
  x = Layout:Col2
  y = Layout:Row4
  width = Layout:Col3-Layout:Col2
  height = Layout:Row5-Layout:Row4


!- Internet wrappers for the different kinds of controls ---------------------

WebHtmlPromptClass.CreateCellContents  PROCEDURE(*HtmlClass Target)

  CODE
  Target.WriteText(SELF.GetText())


WebHtmlPromptClass.GetHasHotkey       PROCEDURE
  CODE
  RETURN TRUE


WebStringClass.SetBreakable       PROCEDURE(BYTE CanBreak)
  CODE
  SELF.CanBreak = CanBreak


WebHtmlStringClass.CreateCellContents  PROCEDURE(*HtmlClass Target)

  CODE
  IF (SELF.CanBreak)
    Target.WriteText(SELF.GetText())
  ELSE
    Target.Write('<<NOBR>')
    Target.Write(SELF.GetQuotedText())
    Target.Writeln('<</NOBR>')
  END


WebHtmlStringClass.GetCellAttributes   PROCEDURE(*HtmlClass Target)

Result          CSTRING(40)

  CODE

  IF (SELF.Feq{PROP:center})
    Result = ' ALIGN=CENTER'
  END
  RETURN PARENT.GetCellAttributes(Target) & Result


WebJavaStringClass.Init                PROCEDURE(SIGNED Feq, *WebWindowBaseClass OwnerWindow)
  CODE
  PARENT.Init(Feq, OwnerWindow)
  SELF.LastText = 'MagicValue<12>'     ! To not match anything!

WebJavaStringClass.CreateParams        PROCEDURE(*HtmlClass Target)

CurFont              HtmlFontClass
  CODE

  SELF.GetFont(CurFont)
  SELF.LastText = SELF.GetText()

  SELF.CreateColorParameters(Target, SELF.AutoSpotLink)
  Target.WriteAppletOptParameter('Text', SELF.LastText)
  Target.WriteAppletOptParameter('Align', SELF.GetAlignText())
  IF ((SELF.Container &= NULL) OR (Target.GetFontChanged(CurFont)))
    Target.WriteAppletFontParameter(CurFont)
  END
  IF (SELF.CanBreak)
    Target.WriteAppletParameter('Wrap', '1')
  END
  IF (SELF.AutoSpotLink)
    Target.WriteAppletOptParameter('AutoSpotLink', SELF.AutoSpotLink)
  END


WebJavaStringClass.GetAppletType         PROCEDURE
  CODE
  RETURN 'ClarionStringControl'


WebJavaStringClass.CreateHtml         PROCEDURE(*HtmlClass Target)

Height               SIGNED,AUTO
Width                SIGNED,AUTO
  CODE

  IF (NOT SELF.OwnerWindow.AllowJava) THEN RETURN.

  GetPosition(SELF.Feq,,,Width,Height)

  Target.WriteAppletHeader(SELF.Feq, SELF.GetAppletType(), Width, Height)

  SELF.CreateParams(Target)

  Target.WriteAppletFooter


WebJavaStringClass.CreateJslData     PROCEDURE(*JslManagerClass Target)
CurText              ANY
  CODE
  CurText = SELF.GetText()
  IF (CurText <> SELF.LastText)
    Target.SelectControl(SELF.Feq)
    Target.SetAttribute(Jsl:StringText, CurText)
    SELF.LastText = CurText
  END


WebJavaStringClass.SetAutoSpotLink        PROCEDURE(BYTE OnOff)
  CODE
  SELF.AutoSpotLink = OnOff

!- Entry Control -------------------------------------------------------------

WebHtmlEntryClass.CreateCellContents   PROCEDURE(*HtmlClass Target)

  CODE

  Target.TakeNewControl(SELF.Feq, TRUE)
  IF (SELF.Feq{PROP:password})
    Target.Write('<<INPUT TYPE=PASSWORD')
  ELSE
    Target.Write('<<INPUT TYPE=TEXT')
  END

  Target.Write(' VALUE="')
  Target.Write(IC:QuoteText(SELF.GetText(), IC:RESET:Value))
  Target.Write('"')

  Target.Write(SELF.GetNameAttribute(Target))
  Target.Write(' SIZE="' & INT((SELF.Feq{PROP:width} + 2)/4) & '"')
  IF (SELF.OwnerWindow.AllowJava)
    Target.WriteEventHandler(SELF.GetEventAction(EVENT:Accepted), HTML:TextChanged, HTML:TextValue)
  END
  Target.WriteOnFocusHandler
  Target.Writeln('>')

  SELF.UpdateCopyUse


WebHtmlEntryClass.CreateJslData     PROCEDURE(*JslManagerClass Target)

  CODE
  IF (SELF.GetUseChanged())
    Target.SetValue(SELF.Feq, CONTENTS(SELF.Feq))
    SELF.UpdateCopyUse
  END


WebHtmlEntryClass.ResetControl         PROCEDURE(*SubmitItemClass Source)

EnteredText     ANY

  CODE
  EnteredText = IC:Html2Clarion(Source.NewValue)

  IF (SELF.Feq{PROP:screentext} <> EnteredText)
    SELF.Feq{PROP:screentext} = EnteredText
    UPDATE(SELF.Feq)
    IF (SELF.Feq{PROP:rejectcode}<>0)
      POST(EVENT:Rejected, SELF.Feq)
    ELSE
      POST(EVENT:Accepted, SELF.Feq)
    END
    SELF.UpdateCopyUse
  END


!- Text Control -------------------------------------------------------------

WebHtmlTextClass.CreateCellContents   PROCEDURE(*HtmlClass Target)

  CODE

  Target.TakeNewControl(SELF.Feq, FALSE)
  Target.Write('<<TEXTAREA WRAP=VIRTUAL')
  Target.Write(SELF.GetNameAttribute(Target))
  Target.Write(' COLS="' & INT((SELF.Feq{PROP:width} + 2)/4) & '"')
  Target.Write(' ROWS="' & INT((SELF.Feq{PROP:height} + 4)/8) & '"')
  IF (SELF.OwnerWindow.AllowJava)
    Target.WriteEventHandler(SELF.GetEventAction(EVENT:Accepted), HTML:TextAreaChanged, HTML:TextAreaValue)
  END
  Target.Write('>')
  Target.Write(IC:QuoteText(CLIP(CONTENTS(SELF.Feq)), IC:RESET:Text))
  Target.Writeln('<</TEXTAREA>')

  SELF.UpdateCopyUse


WebHtmlTextClass.CreateJslData     PROCEDURE(*JslManagerClass Target)

  CODE
  IF (SELF.GetUseChanged())
    Target.SetValue(SELF.Feq, CONTENTS(SELF.Feq))
    SELF.UpdateCopyUse
  END


WebHtmlTextClass.ResetControl         PROCEDURE(*SubmitItemClass Source)

  CODE
  CHANGE(SELF.Feq, IC:Html2Clarion(Source.NewValue))
  SELF.UpdateCopyUse


!- Check Control -------------------------------------------------------------

WebHtmlCheckClass.BeforeResetControl PROCEDURE
  CODE
  IF (SELF.GetVisible())
    CHANGE(SELF.Feq, '')
    SELF.UpdateCopyUse
    POST(EVENT:Accepted, SELF.Feq)
  END


WebHtmlCheckClass.CreateCellContents PROCEDURE(*HtmlClass Target)

  CODE

  Target.Write('<<INPUT TYPE=CHECKBOX VALUE="1"')
  IF (SELF.Feq{PROP:checked})
    Target.Write(' CHECKED')
  END
  Target.Write(SELF.GetNameAttribute(Target))
  IF (SELF.OwnerWindow.AllowJava)
    Target.WriteEventHandler(SELF.GetEventAction(EVENT:Accepted), HTML:CheckChanged, HTML:CheckValue)
  END
  Target.Write('>')
  Target.Write(SELF.GetQuotedText())

  SELF.UpdateCopyUse


WebHtmlCheckClass.CreateJslData     PROCEDURE(*JslManagerClass Target)

  CODE
  IF (SELF.GetUseChanged())
    Target.SetChecked(SELF.Feq, SELF.Feq{PROP:checked})
    SELF.UpdateCopyUse
  END


WebHtmlCheckClass.GetHasHotkey       PROCEDURE
  CODE
  RETURN TRUE


WebHtmlCheckClass.ResetControl         PROCEDURE(*SubmitItemClass Source)
NewValue             CSTRING(255)
  CODE
  NewValue = UPPER(IC:Html2Clarion(Source.NewValue))
  IF (NewValue = '0') OR (NewValue = 'OFF') OR (NewValue = 'FALSE')
    CHANGE(SELF.Feq, '')
  ELSE
    CHANGE(SELF.Feq, 1)
  END
  SELF.UpdateCopyUse
  POST(EVENT:Accepted, SELF.Feq)


!- Option and Radio Controls --------------------------------------------------

WebHtmlOptionClass.CreateHtml PROCEDURE(*HtmlClass Target)

  CODE
  SELF.OwnerWindow.CreateChildHtml(Target, SELF.Feq, SELF.GetTableAttributes())
  SELF.UpdateCopyChoice


WebHtmlOptionClass.CreateJslData     PROCEDURE(*JslManagerClass Target)

  CODE
  IF (SELF.GetChoiceChanged())
    Target.SetValue(SELF.Feq, CHOICE(SELF.Feq))
    SELF.UpdateCopyChoice
  END


WebHtmlOptionClass.GetTableAttributes     PROCEDURE
  CODE
  IF (SELF.Feq{PROP:boxed}<>0)
    IF (SELF.BorderWidth)
       RETURN ' BORDER=' & SELF.BorderWidth
    END
  END
  RETURN ''


WebHtmlOptionClass.Init         PROCEDURE(SIGNED Feq, *WebWindowBaseClass OwnerWindow)
  CODE
  PARENT.Init(Feq, OwnerWindow)
  SELF.BorderWidth = SELF.OwnerWindow.OptionBorderWidth


WebHtmlOptionClass.ResetControl         PROCEDURE(*SubmitItemClass Source)

  CODE
  SELF.Feq{PROP:selstart} = Source.NewValue
  POST(EVENT:Accepted, SELF.Feq)
  SELF.UpdateCopyChoice


WebHtmlOptionClass.SetBorderWidth     PROCEDURE(SIGNED BorderWidth)
  CODE
  SELF.BorderWidth = BorderWidth


WebHtmlRadioClass.CreateCellContents          PROCEDURE(*HtmlClass Target)

RadioIndex           SIGNED,AUTO
ParentControl        GROUP(WebControlRefGroup).

  CODE

  SELF.OwnerWindow.GetControl(SELF.ParentFeq, ParentControl)
  RadioIndex = SELF.feq{PROP:childindex}

  Target.Write('<<INPUT TYPE=RADIO VALUE="' & RadioIndex & '"')
  IF (SELF.ParentFeq{PROP:choicefeq} = SELF.Feq)
    Target.Write(' CHECKED')
  END
  Target.Write(' NAME="X' & IC:Feq2Id(SELF.ParentFeq) & '"')
  IF (SELF.OwnerWindow.AllowJava)
    Target.WriteEventHandler(ParentControl.Control.GetEventAction(EVENT:Accepted), HTML:RadioChanged, RadioIndex)
  END
  Target.Write('>')
  Target.Write(SELF.GetQuotedText())


WebHtmlRadioClass.GetHasHotkey       PROCEDURE
  CODE
  RETURN TRUE


WebListClass.GetBackgroundColor      PROCEDURE(LONG DefaultColor)
  CODE

  RETURN PARENT.GetBackgroundColor(COLOR:White)


!- Html List boxes -----------------------------------------------------------

WebHtmlListClass.CreateCellContents        PROCEDURE(*HtmlClass Target)

Depth           SIGNED(1)

  CODE

  IF (SELF.Feq{PROP:drop} = 0)
    Depth = (SELF.Feq{PROP:height} + 4)/8
  END
  Target.Write('<<SELECT' & SELF.GetNameAttribute(Target) & ' SIZE=' & Depth)
  IF (SELF.OwnerWindow.AllowJava)
    Target.WriteEventHandler(SELF.GetEventAction(EVENT:Accepted), HTML:SelectChanged, HTML:SelectValue)
  END
  Target.Writeln('>')
  Target.Write(IC:GetListboxHtml(SELF.Feq))
  Target.Writeln('<</SELECT>')

  SELF.UpdateCopyChoice


WebHtmlListClass.CreateJslData     PROCEDURE(*JslManagerClass Target)

  CODE
  IF (SELF.GetChoiceChanged())
    Target.SetListChoice(SELF.Feq, CHOICE(SELF.Feq))
    SELF.UpdateCopyChoice
  END


WebHtmlListClass.ResetControl       PROCEDURE(*SubmitItemClass Source)

  CODE
  IF CHOICE(SELF.Feq) <> Source.NewValue
    SELF.Feq{PROP:selstart} = Source.NewValue
    SELF.UpdateCopyChoice
    POST(Event:NewSelection, SELF.Feq)
    POST(Event:Accepted, SELF.Feq)
  END


!- Java List boxes -----------------------------------------------------------

WebJavaListClass.SetQueue      PROCEDURE(*QUEUE Source)
  CODE

  SELF.FromQ &= Source
  SELF.SetDirty


WebJavaListClass.CreateParams       PROCEDURE(*HtmlClass Target)

Properties              ANY
CurFont                 HtmlFontClass
Feq                     SIGNED,AUTO
SelectedFgColor         LONG,AUTO
SelectedBkColor         LONG,AUTO

  CODE

  Feq = SELF.Feq
  IF (Feq{PROP:left})
    Properties = ',LEFT'
  ELSIF (Feq{PROP:right})
    Properties = ',RIGHT'
  ELSIF (Feq{PROP:decimal})
    Properties = ',DECIMAL'
  ELSIF (Feq{PROP:center})
    Properties = ',CENTER'
  ELSE
    Properties = ''
  END

  IF (Feq{PROPLIST:grid}) THEN  Properties = Properties & ',GRID(' & IC:Hex(Feq{PROPLIST:grid}) & 'H)'.
  IF (Feq{PROP:column}<>0) THEN Properties = Properties & ',COLUMN'.
  IF (Feq{PROP:imm}) THEN       Properties = Properties & ',IMM'.
  IF (Feq{PROP:vcr}) THEN       Properties = Properties & ',VCR'.

  IF (Feq{PROP:hscroll})
    IF (Feq{PROP:vscroll})
      Properties = Properties & ',HVSCROLL'
    ELSE
      Properties = Properties & ',HSCROLL'
    END
  ELSE
    IF (Feq{PROP:vscroll})
      Properties = Properties & ',VSCROLL'
    END
  END

  SelectedFgColor = Feq{PROP:selectedcolor}
  SelectedBkColor = Feq{PROP:selectedfillcolor}

  SELF.GetFont(CurFont)

  SELF.CreateColorParameters(Target, SELF.AutoSpotLink)
  Target.WriteAppletParameter('formatString', SELF.Feq{PROP:format})
  Target.WriteAppletParameter('Events', JavaEvents.GetEventString(SELF.EventActionQ, Update:OnBrowser))
  Target.WriteAppletParameter('Properties', SUB(Properties, 2, -1))
  IF ((SELF.Container &= NULL) OR (Target.GetFontChanged(CurFont)))
    Target.WriteAppletFontParameter(CurFont)
  END
  IF (SelectedFgColor <> COLOR:none)
    Target.WriteAppletParameter('SelectFgColor', IC:RGB(SelectedFgColor))
  END
  IF (SelectedBkColor <> COLOR:none)
    Target.WriteAppletParameter('SelectBkColor', IC:RGB(SelectedBkColor))
  END
  IF (SELF.AutoSpotLink)
    Target.WriteAppletOptParameter('AutoSpotLink', SELF.AutoSpotLink)
  END


WebJavaListClass.GetAppletType     PROCEDURE
  CODE

  RETURN 'ClarionListBox'


WebJavaListClass.CreateHtml        PROCEDURE(*HtmlClass Target)

  CODE

  IF (NOT SELF.OwnerWindow.AllowJava) THEN RETURN.

  IF (SELF.width = 0)
    ! Need to only get the width/height once, otherwise setting PROP:items
    ! can cause a list box to shrink ad-infinitum.
    GETPOSITION(SELF.Feq,,, SELF.width, SELF.height)
  END

  Target.WriteAppletHeader(SELF.Feq, SELF.GetAppletType(), SELF.width, SELF.height)

  SELF.CreateParams(Target)

  Target.WriteAppletFooter

  ! Reinitialise the variables to reflect a new applet being created
  SELF.Started = FALSE

  SELF.UpdateState


WebJavaListClass.CreateJslData     PROCEDURE(*JslManagerClass Target)

Changes         LONG(0)
CurAction       SIGNED,AUTO
CurColumn       SIGNED,AUTO
CurFeq          SIGNED,AUTO
CurIndex        SIGNED,AUTO
CurRecord       LONG,AUTO
DataChanged     SIGNED(FALSE)
Format          ANY
NextIconName    STRING(FILE:MaxFilePath)
NumActions      SIGNED,AUTO
NumActionItems  SIGNED,AUTO
NumRecords      LONG,AUTO
Skipped         SIGNED,AUTO

  CODE

  IF (NOT SELF.FromQ &= NULL)
    Changes = CHANGES(SELF.FromQ)
  END
  IF (SELF.Changes <> Changes)
    DataChanged = TRUE
  END

  IF (SELF.Started)
    CurFeq = SELF.Feq
    Target.SelectControl(CurFeq)

    Format = CurFeq{PROP:format}
    IF (SELF.LastFormat <> Format)
      Target.SetAttribute(JSL:ListFormat, Format)
      DataChanged = TRUE
      FREE(SELF.QueueActionQ)                   ! Update whole queue

      IC:FreeListboxFormat(SELF.Format)
      SELF.Format = IC:CreateListboxFormat(SELF.Feq)
    END

    CurColumn = CurFeq{PROP:column}
    IF (CurColumn)
      Target.SetAttribute(JSL:ListSelection, CHOICE(CurFeq)-1 & ' ' & CurColumn-1)
    ELSE
      Target.SetAttribute(JSL:ListSelection, CHOICE(CurFeq)-1)
    END

    IF (CurFeq{PROP:imm})
      Target.SetAttributeLong(JSL:ListThumb, CurFeq{PROP:vscrollpos})
    END

    IF (SELF.LastHscroll <> CurFeq{PROP:hscroll})
      Target.SetAttributeLong(JSL:ListHScroll, CurFeq{PROP:hscroll})
    END

    IF (SELF.LastVscroll <> CurFeq{PROP:vscroll})
      Target.SetAttributeLong(JSL:ListVScroll, CurFeq{PROP:hscroll})
    END

    IF (SELF.SendIcons)
      ! Allow a gap of up to 1 icon in the list
      CurIndex = 0
      Skipped = 0
      LOOP WHILE (Skipped < 2)
        NextIconName = SELF.OwnerWindow.Files.LoadImage(CurFeq{PROP:iconlist, CurIndex})
        IF (NextIconName)
          Target.SetIconAttribute(CurIndex, NextIconName)
          Skipped = 0
        ELSE
          Skipped += 1
        END
        CurIndex += 1
      END
      SELF.SendIcons = FALSE
    END

    IF (DataChanged)
      NumRecords = IC:GetNumRecords(CurFeq)
      Target.SetAttributeLong(JSL:ListRecords, NumRecords)
      Target.SetAttributeLong(JSL:ListFields, IC:GetNumColumns(CurFeq))

      NumActions = RECORDS(SELF.QueueActionQ)
      IF (NumActions = 0) OR (SELF.FirstPage)
        !Things have changed, but no indication why => send the whole page
        LOOP CurRecord = 1 TO NumRecords
          Target.SetQueueEntry(CurFeq, CurRecord, SELF.Format)
        END
      ELSE
        LOOP CurAction = 1 TO NumActions
          GET(SELF.QueueActionQ, CurAction)
          NumActionItems = SELF.QueueActionQ.NumItems
          CASE (SELF.QueueActionQ.Action)
          OF ACTION:Insert
            LOOP CurRecord = 1 TO NumActionItems
              Target.AddQueueEntry(CurFeq, SELF.QueueActionQ.Offset + (CurRecord - 1), SELF.Format)
            END
          OF ACTION:Replace
            LOOP CurRecord = 1 TO NumActionItems
              Target.SetQueueEntry(CurFeq, SELF.QueueActionQ.Offset + (CurRecord - 1), SELF.Format)
            END
          OF ACTION:ScrollUp
            LOOP CurRecord = 1 TO NumActionItems
              Target.ScrollQueueUp(CurFeq, NumRecords - NumActionItems + CurRecord, SELF.Format)
            END
          OF ACTION:ScrollDown
            LOOP CurRecord = 1 TO NumActionItems
              Target.ScrollQueueDown(CurFeq, NumActionItems - (CurRecord - 1), SELF.Format)
            END
          OF ACTION:Delete
            Target.RemoveQueueEntries(SELF.QueueActionQ.Offset, NumActionItems)
          OF ACTION:DeleteAll
            Target.RemoveAllQueueEntries
          END
        END
      END
    END

    SELF.UpdateCopyChoice
    SELF.UpdateState
    SELF.Changes = Changes
    SELF.FirstPage = FALSE
  END

  FREE(SELF.QueueActionQ)


WebJavaListClass.GetEventAction         PROCEDURE(SIGNED EventNo)
  CODE
  SELF.EventActionQ.EventNo = EventNo
  GET(SELF.EventActionQ, +SELF.EventActionQ.EventNo)
  IF (~ERRORCODE())
    RETURN SELF.EventActionQ.Action
  END
  RETURN Update:OnBrowser


WebJavaListClass.Init            PROCEDURE(SIGNED Feq, *WebWindowBaseClass OwnerWindow)

  CODE
  PARENT.Init(Feq, OwnerWindow)
  SELF.EventActionQ &= NEW EventActionQueue
  SELF.QueueActionQ &= NEW QueueActionQueue
  SELF.SendIcons = TRUE

  IF (SELF.feq{PROP:imm})
    SELF.SetEventAction(EVENT:ScrollDown,    Update:Partial)
    SELF.SetEventAction(EVENT:ScrollUp,      Update:Partial)
    SELF.SetEventAction(EVENT:ScrollTop,     Update:Partial)
    SELF.SetEventAction(EVENT:ScrollBottom,  Update:Partial)
    SELF.SetEventAction(EVENT:ScrollDrag,    Update:Partial)
    SELF.SetEventAction(EVENT:PageUp,        Update:Partial)
    SELF.SetEventAction(EVENT:PageDown,      Update:Partial)
    SELF.SetEventAction(EVENT:Locate,        Update:Partial)
  END

  SELF.SetEventAction(EVENT:NewSelection,  Update:Partial)
  SELF.SetEventAction(EVENT:Initialize,    Update:Partial)
  SELF.SetEventAction(EVENT:AlertKey,      Update:Partial)

  SELF.Format = IC:CreateListboxFormat(SELF.Feq)


WebJavaListClass.Kill            PROCEDURE

  CODE
  DISPOSE (SELF.EventActionQ)
  DISPOSE (SELF.QueueActionQ)
  IC:FreeListboxFormat(SELF.Format)


WebJavaListClass.ResetFromQueue     PROCEDURE(BYTE How, LONG Offset=0, LONG Number=1)
  CODE
  IF (How = ACTION:Scroll)
    IF (offset < 0)
      How = ACTION:ScrollUp
      Number = -offset
    ELSE
      How = ACTION:ScrollDown
      Number = offset
    END
  END

  IF (How = ACTION:DeleteAll)
    FREE (SELF.QueueActionQ)
  END
  SELF.QueueActionQ.Action = How
  SELF.QueueActionQ.NumItems = Number
  SELF.QueueActionQ.Offset = Offset
  ADD (SELF.QueueActionQ)


WebJavaListClass.ResetControl       PROCEDURE(*SubmitItemClass Source)

CommaPos        SIGNED,AUTO
Column          SIGNED(0)
KeyCode         SIGNED,AUTO
Event           SIGNED,AUTO

  CODE

  !The action queue may contain items when called from VCR style form
  FREE(SELF.QueueActionQ)               !
  CommaPos = INSTRING(',', Source.NewValue)
  IF (CommaPos)
    Column = SUB(Source.NewValue, CommaPos+1, 255)
  END

  Event = Source.Event
  CASE (Event)
  OF EVENT:ScrollDrag
     SELF.Feq{PROP:vscrollpos} = Source.Extra
  OF EVENT:AlertKey
     KeyCode = Source.Extra
     SETKEYCODE(KeyCode)
     SETKEYCHAR(KeyCode)
  OF Event:Expanding
  OROF Event:Contracting
  OROF Event:Expanded
  OROF Event:Contracted
    IF (Source.Extra)
      SELF.Feq{PropList:MouseDownRow} = Source.Extra+1
    END
  OF EVENT:Initialize
    SELF.Feq{PROP:items} = Source.Extra
    SELF.Changes = -1
    SELF.SendIcons = TRUE
    SELF.Started = TRUE
    SELF.FirstPage = TRUE
    FREE(SELF.QueueActionQ)
    POST(EVENT:RefreshPage, SELF.Feq)           ! Template forces refresh page
    Event = EVENT:NewSelection
  ELSE
    IF (Source.NewValue)
      SELF.Feq{PROP:selstart} = Source.NewValue+1
      IF (CommaPos AND (SELF.Feq{PROP:column}<>0))
        SELF.Feq{PROP:column} = Column+1
      END
    END
  END
  POST(Event, SELF.Feq)


WebJavaListClass.SetAutoSpotLink        PROCEDURE(BYTE OnOff)
  CODE
  SELF.AutoSpotLink = OnOff


WebJavaListClass.SetEventAction    PROCEDURE(SIGNED EventNo, BYTE Action)

  CODE
  SELF.EventActionQ.EventNo = EventNo
  GET(SELF.EventActionQ, +SELF.EventActionQ.EventNo)
  SELF.EventActionQ.Action = Action

  ! Can call this function multiple times to change the effect of an event.
  IF (NOT ERRORCODE())
    PUT(SELF.EventActionQ)
  ELSE
    SELF.EventActionQ.EventNo = EventNo
    ADD(SELF.EventActionQ, +SELF.EventActionQ.EventNo)
  END


WebJavaListClass.SetDirty PROCEDURE

  CODE
  SELF.Changes = -1

WebJavaListClass.UpdateState PROCEDURE

  CODE
  SELF.LastHscroll = SELF.Feq{PROP:hscroll}
  SELF.LastVscroll = SELF.Feq{PROP:vscroll}
  SELF.LastFormat = SELF.Feq{PROP:format}


!- Sheet and Tab Controls ----------------------------------------------------

WebHtmlSheetClass.CreateHtml         PROCEDURE(*HtmlClass Target)

Alignment            SIGNED(PROP:above)
BackColor            SIGNED,AUTO
Children             WebControlQueue
CurTabFeq            SIGNED,AUTO
TabControls          WebControlQueue
Layout               LayoutHtmlClass

  CODE

  IF SELF.GetVisible()

    SELF.OwnerWindow.GetChildren(TabControls, SELF.Feq, CREATE:Tab)

    IF (SELF.Feq{PROP:wizard})
      Alignment = 0
    ELSIF (SELF.Feq{PROP:left})
      Alignment = PROP:left
    ELSIF (SELF.Feq{PROP:right})
      Alignment = PROP:right
    ELSIF (SELF.Feq{PROP:above})
      Alignment = PROP:above
    ELSIF (SELF.Feq{PROP:below})
      Alignment = PROP:below
    END

    CurTabFeq = SELF.Feq{PROP:choicefeq}

    Target.Writeln('<<TABLE' & SELF.GetTableAttributes() & '><<TR>')
    IF (Alignment = PROP:left)
      Target.Writeln('<<TD VALIGN=TOP>')
      SELF.CreateTabControl(TabControls, Target, Alignment, CurTabFeq)
      Target.Writeln('<</TD>')
    ELSIF (Alignment = PROP:above)
      Target.Writeln('<<TD>')
      SELF.CreateTabControl(TabControls, Target, Alignment, CurTabFeq)
      Target.Writeln('<</TD><</TR><<TR>')
    END

    BackColor = CurTabFeq{PROP:background}
    IF (BackColor = COLOR:None)
      BackColor = SELF.GetBackgroundColor()
    END
    Target.Writeln('<<TD BGCOLOR="' & IC:ColorText(BackColor) & '">')
    Layout.Init(' BORDER=' & SELF.OwnerWindow.FormatBorderWidth, SELF.OwnerWindow.SnapX, SELF.OwnerWindow.SnapY)
    SELF.OwnerWindow.GetChildren(Children, SELF.Feq, -CREATE:Tab)
    IF (CurTabFeq)
      SELF.OwnerWindow.GetChildren(Children, CurTabFeq)
    END
    SELF.OwnerWindow.AddControlsToLayout(Children, Layout)
    Layout.CreateHtml(Target)
    Layout.Kill
    Target.Writeln('<</TD>')

    IF (Alignment = PROP:right)
      Target.Writeln('<<TD VALIGN=TOP>')
      SELF.CreateTabControl(TabControls, Target, Alignment, CurTabFeq)
      Target.Writeln('<</TD>')
    ELSIF (Alignment = PROP:below)
      Target.Writeln('<</TR><<TR><<TD>')
      SELF.CreateTabControl(TabControls, Target, Alignment, CurTabFeq)
      Target.Writeln('<</TD>')
    END

    Target.Writeln('<</TR><</TABLE>')
  ELSE
    ! Add 'hoisted' children - that may still be visible..
    SELF.OwnerWindow.CreateChildHtml(Target, SELF.Feq, '')
  END


WebHtmlSheetClass.CreateTabControl PROCEDURE(*WebControlQueue TabControls, *HtmlClass Target, SIGNED Alignment, SIGNED SelectedTabFeq)
CharToDlgX      EQUATE(4)
ControlNum      SIGNED,AUTO
CurFont         HtmlFontClass
CurIndex        SIGNED,AUTO
Height          SIGNED,AUTO
MaxX            SIGNED,AUTO
MaxY            SIGNED,AUTO
NumRecords      SIGNED,AUTO
SelectedTab     SIGNED,AUTO
SpacingX        EQUATE(4)
SpacingY        EQUATE(2)
TabExtraWidth   EQUATE(16)
TabNum          SIGNED,AUTO
ThisControl     &WebControlClass
Width           SIGNED,AUTO
x               SIGNED,AUTO
y               SIGNED,AUTO

  CODE

  IF (NOT SELF.OwnerWindow.AllowJava) THEN RETURN.

  NumRecords = RECORDS(TabControls)

  IF (NumRecords > 0)
    SELF.GetFont(CurFont)
    SELF.PushFont(Target)

    Height = 14

    MaxX = 0
    MaxY = 0

    SelectedTab = 0

    TabNum = 1
    LOOP CurIndex = 1 TO NumRecords
      GET(TabControls, CurIndex)
      ThisControl &= TabControls.ThisControl
      IF (ThisControl.GetVisible())
        Width = LEN(ThisControl.GetText()) * CharToDlgX + TabExtraWidth
  
        IF ((Alignment = PROP:left) OR (Alignment = PROP:right))
          IF ((Width+SpacingX) > MaxX) THEN MaxX = (Width+SpacingX).
          MaxY = MaxY + (Height + SpacingY)
        ELSE
          MaxX = MaxX + (Width + SpacingX)
          IF ((Height+SpacingY) > MaxY) THEN MaxY = (Height+SpacingY).
        END
  
        IF (ThisControl.Feq = SelectedTabFeq) THEN SelectedTab = (TabNum-1).

        TabNum += 1
      END
    END

    Target.WriteContainerAppletHeader(SELF.Feq, 'ClarionTabControl', MaxX, MaxY)
    SELF.CreateColorParameters(Target)
    Target.WriteAppletParameter('ContainerBgColor', IC:RGB(SELF.GetParentBackgroundColor()))
    IF ((SELF.Container &= NULL) OR (Target.GetFontChanged(CurFont)))
      Target.WriteAppletFontParameter(CurFont)
    END

    Target.WriteAppletParameter('className', 'ClarionTabButton')
    IF (SelectedTab)
      Target.WriteAppletParameter('FirstTab', SelectedTab)
    END

    CASE Alignment
    OF PROP:left
      Target.WriteAppletParameter('Location', 'LEFT')
    OF PROP:right
      Target.WriteAppletParameter('Location', 'RIGHT')
    OF PROP:above
      Target.WriteAppletParameter('Location', 'ABOVE')
    OF PROP:below
      Target.WriteAppletParameter('Location', 'BELOW')
    END

    TabNum = 1
    LOOP CurIndex = 1 TO NumRecords
      GET(TabControls, CurIndex)
      ThisControl &= TabControls.ThisControl
      ThisControl.Container &= SELF
      IF (ThisControl.GetVisible())
        Target.WriteChildAppletHeader('tab' & TabNum, ThisControl.Feq)
        ThisControl.CreateParams(Target)
        Target.WriteChildAppletFooter
  
        TabNum = TabNum + 1
      END
    END

    Target.WriteAppletFooter

    SELF.PopFont(Target)
  END


WebHtmlSheetClass.GetIsChild      PROCEDURE(SIGNED ParentFeq, SIGNED Type=0)

  CODE
  IF (PARENT.GetIsChild(ParentFeq, Type))
    RETURN SELF.Feq
  END
  IF (ParentFeq = SELF.ParentFeq)
    RETURN SELF.OwnerWindow.GetFirstChild(SELF.Feq, Type)
  END
  RETURN 0


WebHtmlSheetClass.GetTableAttributes    PROCEDURE
  CODE
  RETURN ' BORDER=' & SELF.BorderWidth


WebHtmlSheetClass.Init         PROCEDURE(SIGNED Feq, *WebWindowBaseClass OwnerWindow)
  CODE
  PARENT.Init(Feq, OwnerWindow)
  SELF.BorderWidth = OwnerWindow.SheetBorderWidth
  SELF.ActionOnAccept = Update:Full


WebHtmlSheetClass.ResetControl         PROCEDURE(*SubmitItemClass Source)

  CODE
  SELF.Feq{PROP:selstart} = Source.NewValue
  SELF.OwnerWindow.DefaultButtonNeeded = FALSE


WebHtmlSheetClass.SetBorderWidth     PROCEDURE(SIGNED BorderWidth)
  CODE
  SELF.BorderWidth = BorderWidth


WebHtmlSheetClass.SetChildDefaults  PROCEDURE

  CODE
  PARENT.DoSetChildDefaults


WebHtmlTabClass.SetParentDefaults  PROCEDURE(*WebControlClass Other, *Rect ParentPos)
  CODE


WebHtmlTabClass.CreateParams         PROCEDURE(*HtmlClass Target)
CurFont              HtmlFontClass
ParentControl        GROUP(WebControlRefGroup).

  CODE

  SELF.IsEnabled = 1 - SELF.Feq{PROP:disable}

  Target.WriteAppletOptParameter('Label', SELF.GetText())
  Target.WriteAppletOptParameter('Hint', SELF.Feq{PROP:tooltip})

  SELF.GetFont(CurFont)
  IF ((SELF.Container &= NULL) OR (Target.GetFontChanged(CurFont)))
    Target.WriteAppletFontParameter(CurFont)
  END

  SELF.CreateColorParameters(Target)
  IF (NOT SELF.IsEnabled)
    Target.WriteAppletOptParameter('Disabled', '1')
  END
  SELF.OwnerWindow.GetControl(SELF.ParentFeq, ParentControl)
  IF (ParentControl.Control.GetEventAction(EVENT:Accepted)= Update:Full)
    Target.WriteAppletParameter('Submit', 1)
  END


WebHtmlTabClass.GetAppletType       PROCEDURE
  CODE
  RETURN 'ClarionImageButton'


WebHtmlTabClass.CreateHtml         PROCEDURE(*HtmlClass Target)
CharToDlgX           EQUATE(4)
TabExtraWidth        EQUATE(8)
CurText              ANY
Filename             ANY
Height               SIGNED,AUTO
Width                SIGNED,AUTO

  CODE

  IF (NOT SELF.OwnerWindow.AllowJava) THEN RETURN.

  CurText = SELF.GetText()
  Width = LEN(CurText) * CharToDlgX + TabExtraWidth
  Height = 14

  Target.WriteAppletHeader(SELF.Feq, SELF.GetAppletType(), Width, Height)

  SELF.CreateParams(Target)

  Target.WriteAppletFooter


WebHtmlTabClass.CreateJslData     PROCEDURE(*JslManagerClass Target)

  CODE
  Target.SelectControl(SELF.Feq)
  SELF.RefreshDisabled(Target, 1 - SELF.Feq{PROP:disable}, SELF.IsEnabled)


WebHtmlTabClass.GetIsChild      PROCEDURE(SIGNED ParentFeq, SIGNED Type=0)

  CODE
  RETURN 0


WebHtmlTabClass.GetHasHotkey       PROCEDURE
  CODE
  RETURN TRUE


WebHtmlTabClass.GetPosition   PROCEDURE(*SIGNED x, *SIGNED y, *SIGNED width, *SIGNED height)

  CODE
  IF (SELF.ParentFeq{PROP:left} OR SELF.ParentFeq{PROP:right})
    x = 0
    y = SELF.Feq{PROP:childindex} * 100
  ELSE
    x = SELF.Feq{PROP:childindex} * 100
    y = 0
  END

  width = 10
  height = 10


WebHtmlTabClass.GetVisible              PROCEDURE

  CODE
  IF (NOT SELF.Feq{PROP:disable} AND NOT SELF.Feq{PROP:hide})
    RETURN TRUE
  END
  RETURN FALSE


WebHtmlTabClass.ResetControl         PROCEDURE(*SubmitItemClass Source)

  CODE
  !MORE: ModalEvent - SELECT Changing
  SELF.ParentFeq{PROP:choicefeq} = SELF.Feq
  POST(EVENT:NewSelection, SELF.ParentFeq)
  SELF.OwnerWindow.DefaultButtonNeeded = FALSE


!- Button classes (Java and Html) ---------------------------------------------

WebButtonClass.Init        PROCEDURE(SIGNED Feq, *WebWindowBaseClass OwnerWindow)

  CODE
  PARENT.Init(Feq, OwnerWindow)
  IF (SELF.FEQ = TBarBrwHelp)
    SELF.Feq{PROP:std} = STD:Help
  END


WebButtonClass.GetVisible    PROCEDURE
  CODE
  CASE SELF.Feq{PROP:std}
  OF STD:Close
  OROF 0
    RETURN PARENT.GetVisible()
  OF STD:Help
    IF (SELF.OwnerWindow.HelpEnabled)
      RETURN PARENT.GetVisible()
    END
  END
  RETURN FALSE


WebButtonClass.BeforeResetControl PROCEDURE
  CODE
  IF (SELF.Feq{PROP:default})
    SELF.OwnerWindow.DefaultButton = SELF.Feq
  END


WebButtonClass.GetHasHotkey       PROCEDURE
  CODE
  RETURN TRUE


WebButtonClass.ResetControl         PROCEDURE(*SubmitItemClass Source)

  CODE
  IF (Source.NewValue)
    SELF.OwnerWindow.DefaultButtonNeeded = FALSE
  END


WebHtmlButtonClass.CreateCellContents PROCEDURE(*HtmlClass Target)

  CODE
  Target.Write('<<INPUT TYPE=SUBMIT VALUE="')
  IF (SELF.FEQ{PROP:default})
    Target.Write(DefaultBtnLeftText & IC:QuoteText(SELF.GetText(), IC:RESET:HotValue) & DefaultBtnRightText & '"')
  ELSE
    Target.Write(IC:QuoteText(CHOOSE(SELF.GetText()='',' ',SELF.GetText()), IC:RESET:HotValue) & '"')
  END
  Target.Write(SELF.GetNameAttribute(Target))
  IF SELF.Feq{PROP:std} = STD:Help
    Target.Write(SELF.OwnerWindow.GetHelpHandler())
  END
  Target.Writeln('>')


WebHtmlButtonClass.ResetControl         PROCEDURE(*SubmitItemClass Source)

  CODE
  PARENT.ResetControl(Source)
  IF (Source.NewValue)
    IF (SELF.Feq{PROP:std} = STD:Close)
      POST(EVENT:CloseWindow)
    ELSE
      POST(Source.Event, SELF.Feq)
    END
  END


WebJavaButtonClass.Init        PROCEDURE(SIGNED Feq, *WebWindowBaseClass OwnerWindow)

  CODE
  PARENT.Init(Feq, OwnerWindow)
  SELF.ActionOnAccept = Update:Full


WebJavaButtonClass.CreateHtml         PROCEDURE(*HtmlClass Target)

Height          SIGNED,AUTO
Width           SIGNED,AUTO

  CODE

  GetPosition(SELF.Feq,,,Width,Height)

  SELF.CreateHtml(Target, Width, Height)


WebJavaButtonClass.CreateParams       PROCEDURE(*HtmlClass Target)

CurFont         HtmlFontClass
Filename        CSTRING(FILE:MaxFileName)

  CODE

  SELF.IsEnabled = SELF.Feq{PROP:enabled}

  Filename = SELF.GetFilename()

  Target.WriteAppletFilenameParameter('Picture', Filename)
  Target.WriteAppletOptParameter('Label', SELF.GetText())

  SELF.GetFont(CurFont)
  IF ((SELF.Container &= NULL) OR (Target.GetFontChanged(CurFont)))
    Target.WriteAppletFontParameter(CurFont)
  END
  Target.WriteAppletOptParameter('Hint', SELF.Feq{PROP:tooltip})
  Target.WriteAppletOptParameter('Align', SELF.GetAlignText())
  IF (SELF.FEQ{PROP:default})
    Target.WriteAppletParameter('Default', '')
  END

  SELF.CreateColorParameters(Target)
  IF SELF.Feq{PROP:std} = STD:Help
    Target.WriteAppletParameter('Help', SELF.OwnerWindow.GetHelpReference() & ' ' & SELF.OwnerWindow.HelpStyle)
  ELSE
    IF (SELF.GetEventAction(EVENT:Accepted) = Update:Full)
      Target.WriteAppletParameter('Submit', 1)
    END
  END
  IF (NOT SELF.IsEnabled)
    Target.WriteAppletOptParameter('Disabled', '1')
  END


WebJavaButtonClass.GetAppletType         PROCEDURE
  CODE
  RETURN 'ClarionImageButton'


WebJavaButtonClass.CreateHtml         PROCEDURE(*HtmlClass Target, SIGNED Width, SIGNED Height)

  CODE

  IF (NOT SELF.OwnerWindow.AllowJava) THEN RETURN.

  Target.WriteAppletHeader(SELF.Feq, SELF.GetAppletType(), Width, Height)

  SELF.CreateParams(Target)

  Target.WriteAppletFooter


WebJavaButtonClass.CreateJslData     PROCEDURE(*JslManagerClass Target)

  CODE
  Target.SelectControl(SELF.Feq)
  SELF.RefreshDisabled(Target, SELF.Feq{PROP:enabled}, SELF.IsEnabled)
  !MORE: Update Icon, Text etc....


WebJavaButtonClass.GetCanDisable      PROCEDURE
  CODE
  RETURN TRUE


WebJavaButtonClass.GetFilename        PROCEDURE
  CODE
  RETURN SELF.OwnerWindow.Files.LoadImage(SELF.Feq, PROP:icon)


WebJavaButtonClass.ResetControl         PROCEDURE(*SubmitItemClass Source)

  CODE
  PARENT.ResetControl(Source)
  IF (Source.NewValue)
    IF (SELF.Feq{PROP:std} = STD:Close)
      POST(EVENT:CloseWindow)
    ELSE
      POST(Source.Event, SELF.Feq)
    END
  END


WebJavaToolButtonClass.GetEventAction     PROCEDURE(SIGNED EventNo)

  CODE
  IF (EventNo = EVENT:Accepted)
    IF (SELF.Ownerwindow.GetToolbarMode() = FormMode)
      RETURN Update:Full
    ELSE
      RETURN Update:Partial
    END
  END
  RETURN Update:OnBrowser


!- Menu and Menu-Item Controls ------------------------------------------------

WebMenuBaseClass.SetParentDefaults  PROCEDURE(*WebControlClass Other, *Rect ParentPos)
  CODE


WebMenuBaseClass.GetHasHotkey       PROCEDURE
  CODE
  RETURN TRUE


WebMenuBaseClass.GetPosition   PROCEDURE(*SIGNED x, *SIGNED y, *SIGNED width, *SIGNED height)

ActiveFrame     &WebFrameClass
Level           SIGNED,AUTO

  CODE
  Level = SELF.GetLevel()
  ActiveFrame &= SELF.OwnerWindow.GetWebActiveFrame()
  IF (SELF.ParentFeq = ActiveFrame.GetMenubarFeq()) AND (SELF.OwnerWindow.MenubarType <> PROP:left)
    x = SELF.Feq{PROP:childindex} * 40
    y = 0
  ELSE
    x = 0
    y = SELF.Feq{PROP:childindex} * 40
  END
  width = 10
  height = 10


WebMenuBaseClass.GetText       PROCEDURE
ItemText             ANY
TabPos               SIGNED,AUTO
  CODE
  ItemText = IC:StripHotkey(SELF.Feq{PROP:Text})
  TabPos = INSTRING('<9>', ItemText)
  IF (TabPos)
    RETURN SUB(ItemText, 1, TabPos-1)
  END
  RETURN ItemText


WebHtmlItemClass.CreateCellContents PROCEDURE(*HtmlClass Target)

  CODE
  Target.Writeln('<<NOBR>')
  Target.WriteSpace((SELF.GetLevel()-1)*2)
  Target.Write('<<A')
  IF SELF.Feq{PROP:std} = STD:Help
    Target.Write(' TARGET="_HELP"' & SELF.OwnerWindow.GetHelpTarget())
  ELSE
    Target.Write(' HREF="' & Target.GetControlReference(SELF.Feq) & '"')
  END
  Target.Write('>')
  Target.Writeln(SELF.GetQuotedText() & '<</A>')
  Target.Writeln('<</NOBR><<BR>')


WebHtmlItemClass.GetVisible    PROCEDURE

  CODE
  IF (SELF.Feq{PROP:Text})
    CASE SELF.Feq{PROP:std}
    OF STD:Close
    OROF 0
      RETURN PARENT.GetVisible()
    OF STD:Help
      IF (SELF.OwnerWindow.HelpEnabled)
        RETURN PARENT.GetVisible()
      END
    END
  END
  RETURN FALSE


WebHtmlItemClass.ResetControl         PROCEDURE(*SubmitItemClass Source)

  CODE
  PARENT.ResetControl(Source)
  SELF.OwnerWindow.DefaultButtonNeeded = FALSE


WebHtmlMenuClass.CreateCellContents PROCEDURE(*HtmlClass Target)

  CODE
  Target.Writeln('<<NOBR>')
  Target.WriteSpace((SELF.GetLevel()-1)*2)
  Target.Writeln(SELF.GetQuotedText())
  Target.Writeln('<</NOBR><<BR>')


WebHtmlMenuClass.CreateHtml         PROCEDURE(*HtmlClass Target)

  CODE
  PARENT.CreateHtml(Target)           ! Derived from Item
  SELF.OwnerWindow.CreateChildHtml(Target, SELF.Feq, '')


WebHtmlMenuClass.GetCellAttributes        PROCEDURE(*HtmlClass Target)

  CODE

  RETURN PARENT.GetCellAttributes(Target) & ' NOWRAP VALIGN=TOP'


WebHtmlMenuClass.GetVisible    PROCEDURE

  CODE
  IF (PARENT.GetVisible() AND SELF.OwnerWindow.GetFirstChild(SELF.Feq))
    RETURN TRUE
  END
  RETURN FALSE


!- Image Controls ------------------------------------------------------------

WebHtmlImageClass.CreateCellContents         PROCEDURE(*HtmlClass Target)

Children        WebControlQueue
Filename        CSTRING(FILE:MaxFileName)
Id              UNSIGNED,AUTO
ImagePos        LIKE(Rect)

  CODE

  Filename = SELF.OwnerWindow.Files.GetAlias(SELF.Feq{PROP:tempimage})
  Id = IC:Feq2Id(SELF.Feq)

  IF (Filename)
    SELF.OwnerWindow.GetChildren(Children, SELF.Feq)
    IF RECORDS(Children)
      Target.Writeln('<<MAP NAME="MAP' & Id & '">')
      SELF.OwnerWindow.CreateHtmlExtra(Children, Target)
      Target.Writeln('<</MAP>')
    END
    Target.Write('<<IMG SRC="' & Filename & '"')
    IF (RECORDS(Children))
      Target.Write(' USEMAP="#MAP' & Id & '"')
    END
    IF (SELF.AltText)
      Target.Write(' ALT="' & SELF.AltText & '"')
    END
    GetPosition(SELF.Feq,,,ImagePos.width,ImagePos.height)
    Target.Write(' WIDTH=' & Target.GetPixelsX(ImagePos.width))
    Target.Write(' HEIGHT=' & Target.GetPixelsY(ImagePos.height))
    Target.Writeln('>')
  END


WebHtmlImageClass.SetDescription        PROCEDURE(STRING AltText)
  CODE
  SELF.AltText = CLIP(AltText)


WebHtmlImageClass.SetChildDefaults  PROCEDURE

Children             WebControlQueue
MyRect               GROUP(Rect)
                     .

  CODE
  SELF.GetPosition(MyRect.x, MyRect.y, MyRect.width, MyRect.height)
  SELF.OwnerWindow.GetChildren(Children, SELF.ParentFeq, CREATE:Region)
  SELF.OwnerWindow.SetParentDefaults(Children, SELF, MyRect)


WebJavaImageClass.CreateParams         PROCEDURE(*HtmlClass Target)
  CODE

  Target.WriteAppletParameter('Picture', SELF.Filename)


WebJavaImageClass.GetAppletType         PROCEDURE
  CODE
  RETURN 'ClarionImageControl'


WebJavaImageClass.CreateHtml         PROCEDURE(*HtmlClass Target)

X               SIGNED,AUTO
Y               SIGNED,AUTO
Width           SIGNED,AUTO
Height          SIGNED,AUTO

  CODE

  IF (NOT SELF.OwnerWindow.AllowJava) THEN RETURN.

  SELF.Filename = SELF.OwnerWindow.Files.GetAlias(SELF.Feq{PROP:tempimage})

  IC:GetPositionPixels(SELF.Feq, X,Y,Width,Height)
  Target.WriteAppletHeaderPixel(SELF.Feq, SELF.GetAppletType(), Width, Height)

  SELF.CreateParams(Target)

  Target.WriteAppletFooter


WebJavaImageClass.CreateJslData     PROCEDURE(*JslManagerClass Target)

Filename        CSTRING(FILE:MaxFileName),AUTO

  CODE

  Filename = SELF.Feq{PROP:tempimage}

  Target.SelectControl(SELF.Feq)
  IF (SELF.Filename <> Filename)
    Target.SetAttributeFilename(JSL:Picture, Filename)
    SELF.Filename = Filename
  END



!- Group Controls ------------------------------------------------------------

WebHtmlGroupClass.CreateHtml         PROCEDURE(*HtmlClass Target)

  CODE
  SELF.OwnerWindow.CreateChildHtml(Target, SELF.Feq, SELF.GetTableAttributes())


WebHtmlGroupClass.GetHasHotkey       PROCEDURE
  CODE
  RETURN TRUE


WebHtmlGroupClass.GetTableAttributes     PROCEDURE
  CODE
  IF (SELF.Feq{PROP:boxed}<>0)
    IF (SELF.BorderWidth)
       RETURN ' BORDER=' & SELF.BorderWidth
    END
  END
  RETURN ''


WebHtmlGroupClass.Init         PROCEDURE(SIGNED Feq, *WebWindowBaseClass OwnerWindow)
  CODE
  PARENT.Init(Feq, OwnerWindow)
  SELF.BorderWidth = OwnerWindow.GroupBorderWidth


WebHtmlGroupClass.SetBorderWidth     PROCEDURE(SIGNED BorderWidth)
  CODE
  SELF.BorderWidth = BorderWidth


WebHtmlRegionClass.CreateHtmlExtra  PROCEDURE(*HtmlClass Target)

ImagePos        GROUP(Rect)
                END
RegionPos       GROUP(Rect)
                END
MapLeft         SIGNED,AUTO
MapTop          SIGNED,AUTO
MapRight        SIGNED,AUTO
MapBottom       SIGNED,AUTO
  CODE

  GetPosition(SELF.ParentFeq, ImagePos.x, ImagePos.y, ImagePos.width, ImagePos.height)
  GetPosition(SELF.Feq, RegionPos.x, RegionPos.y, RegionPos.width, RegionPos.height)

  MapLeft = RegionPos.x - ImagePos.x
  IF (MapLeft < 0)
    MapLeft = 0
  END
  MapTop = RegionPos.y - ImagePos.y
  IF (MapTop < 0)
    MapTop = 0
  END
  MapRight = RegionPos.x + RegionPos.width - ImagePos.x
  IF (MapRight > ImagePos.width)
    MapRight = ImagePos.width
  END
  MapBottom = RegionPos.y + RegionPos.height - ImagePos.y
  IF (MapBottom > ImagePos.height)
    MapBottom = ImagePos.height
  END

  Target.Write('<<AREA SHAPE=RECT ')
  Target.Write('COORDS="')
  Target.Write(Target.GetPixelsX(MapLeft) & ',')
  Target.Write(Target.GetPixelsY(MapTop) & ',')
  Target.Write(Target.GetPixelsX(MapRight) & ',')
  Target.Write(Target.GetPixelsY(MapBottom))
  Target.Write('" HREF="' & Target.GetControlReference(SELF.Feq))
  Target.Writeln('">')


WebHtmlRegionClass.SetParentDefaults   PROCEDURE(*WebControlClass Other, *Rect ParentPos)

MyRect               LIKE(Rect)

  CODE
  IF (Other.ParentFeq = SELF.ParentFeq) AND (Other.Feq <> SELF.Feq)
    GetPosition(SELF.Feq, MyRect.x, MyRect.y, MyRect.width, MyRect.height)
    IF (MyRect.x < ParentPos.x + ParentPos.width) AND |
       (MyRect.y < ParentPos.y + ParentPos.height) AND |
       (MyRect.x + MyRect.width > ParentPos.x) AND |
       (MyRect.y + MyRect.height > ParentPos.y)
      SELF.ParentFeq = Other.Feq
    END
  END


!- Special 'pseudo' wrappers -------------------------------------------------

WebCloseButtonClass.CreateParams         PROCEDURE(*HtmlClass Target)
Filename        CSTRING(FILE:MaxFileName)

  CODE

  IF (NOT SELF.OwnerWindow.AllowJava) THEN RETURN.

  Filename = SELF.OwnerWindow.Files.LoadImage(SELF.OwnerWindow.CloseImage)

  Target.WriteAppletFilenameParameter('Picture', Filename)
  Target.WriteAppletOptParameter('Hint', CloseButtonText)
  Target.WriteAppletParameter('Submit', 1)


WebCloseButtonClass.GetAppletType         PROCEDURE
  CODE

  IF SELF.OwnerWindow.AllowJava
    RETURN 'ClarionImageButton'
  ELSE
    RETURN ''
  END


WebCloseButtonClass.CreateHtml         PROCEDURE(*HtmlClass Target)

  CODE

  IF SELF.OwnerWindow.AllowJava
    Target.WriteAppletHeader(SELF.Feq, SELF.GetAppletType(), SELF.width, SELF.height)
    SELF.CreateParams(Target)
    Target.WriteAppletFooter
  ELSE
    Target.Write('<<INPUT TYPE=SUBMIT VALUE="Close"')
    Target.Write(SELF.GetNameAttribute(Target))
    Target.Writeln('>')
  END


WebCloseButtonClass.CreateJslData     PROCEDURE(*JslManagerClass Target)
  CODE


WebCloseButtonClass.GetCloneFeq          PROCEDURE
  CODE
  RETURN TBarBrwChange                 ! Match change button if exists


WebCloseButtonClass.GetPosition   PROCEDURE(*SIGNED x, *SIGNED y, *SIGNED width, *SIGNED height)

  CODE
  x = SELF.x
  y = SELF.y
  width = SELF.width
  height = SELF.height


WebCloseButtonClass.GetVisible            PROCEDURE
  CODE
  RETURN TRUE


WebCloseButtonClass.Init               PROCEDURE(SIGNED Feq, *WebWindowBaseClass OwnerWindow)

CloneFeq             SIGNED
  CODE

  SELF.Feq = Feq
  SELF.RealParentFeq = SELF.ParentFeq
  SELF.x = RIGHTALIGN
  SELF.y = 2
  SELF.width = 16
  SELF.height = 14
  SELF.OwnerWindow &= OwnerWindow
  SELF.ParentFeq = SELF.OwnerWindow.GetToolbarFeq()

  ! Resize the close button to match the control returned from this function
  CloneFeq = SELF.GetCloneFeq()
  IF (CloneFeq{PROP:type} <> 0)
    GetPosition(CloneFeq,,SELF.y,SELF.width,SELF.height)
  END


WebCloseButtonClass.ResetControl         PROCEDURE(*SubmitItemClass Source)

  CODE
  SELF.OwnerWindow.DefaultButtonNeeded = FALSE
  POST(EVENT:CloseWindow)


WebHotlinkClass.CreateCellContents PROCEDURE(*HtmlClass Target)

  CODE
  Target.Writeln('<<NOBR>')
  Target.Write('<<A HREF="' & Target.GetControlReference(SELF.Feq) & '">')
  Target.Writeln(SELF.GetQuotedText() & '<</A>')
  Target.Writeln('<</NOBR><<BR>')


!- WebLiteralClass ----------------------------------------------------

WebLiteralClass.GetCellAttributes        PROCEDURE(*HtmlClass Target)

  CODE
  RETURN ''


WebLiteralClass.CreateHtml       PROCEDURE(*HtmlClass Target)

  CODE
  Target.Write(SELF.Text)


