  MEMBER
  MAP
          RTFFindDlg  (STRING, STRING),PRIVATE
          RTFFindAndRelaceDlg  (STRING, STRING),PRIVATE
          MODULE('')
            MulDiv (LONG,LONG,LONG),LONG,PASCAL
          END
  END
  INCLUDE('RTFCTL.INC'),ONCE
  INCLUDE('KEYCODES.CLW'),ONCE
  INCLUDE('PRNPROP.CLW'),ONCE

  PRAGMA ('link (BMPFONT.ICO)')
  PRAGMA ('link (PRNFONT.ICO)')
  PRAGMA ('link (TTFFONT.ICO)')
  PRAGMA ('link (OPENFONT.ICO)')
  PRAGMA ('link (SBULLETS.ICO)')
  PRAGMA ('link (COLOR.ICO)')
  PRAGMA ('link (BCOLOR.ICO)')

  PRAGMA ('link (BLACK.BMP)')
  PRAGMA ('link (MAROON.BMP)')
  PRAGMA ('link (GREEN.BMP)')
  PRAGMA ('link (OLIVE.BMP)')
  PRAGMA ('link (NAVY.BMP)')
  PRAGMA ('link (PURPLE.BMP)')
  PRAGMA ('link (TEAL.BMP)')
  PRAGMA ('link (GRAY.BMP)')
  PRAGMA ('link (SILVER.BMP)')
  PRAGMA ('link (RED.BMP)')
  PRAGMA ('link (LIME.BMP)')
  PRAGMA ('link (YELLOW.BMP)')
  PRAGMA ('link (BLUE.BMP)')
  PRAGMA ('link (FUSCHIA.BMP)')
  PRAGMA ('link (AQUA.BMP)')
  PRAGMA ('link (WHITE.BMP)')


EVENT:FindCancel   EQUATE(3000h)
EVENT:FindOK       EQUATE(3001h)

RTFControlClass.Construct               PROCEDURE
  CODE
  SELF.RTF        &= NULL
  SELF.Props      &= NULL
  SELF.Fonts      &= NEW(FontList)
  SELF.Scripts    &= NEW(FontScriptList)
  SELF.UndoAction = -1
  SELF.DocumentTitle = 'CW RFT Document'
  RETURN

! =============================================================================

RTFControlClass.Destruct                PROCEDURE
  CODE
  DISPOSE(SELF.Fonts)
  DISPOSE(SELF.Scripts)
  RETURN

! =============================================================================

RTFControlClass.BindControls            PROCEDURE
  CODE
  IF SELF.CtlAlignment THEN
     SELF.CtlAlignment{PROP:USE} = SELF.Alignment
  END
  IF SELF.CtlBullets THEN
     SELF.CtlBullets{PROP:USE} = SELF.Bullets
  END
  IF SELF.CtlBulletStyle THEN
     SELF.CtlBulletStyle{PROP:USE} = SELF.BulletStyle
  END
  IF SELF.CtlFontName THEN
     SELF.CtlFontName{PROP:USE}  = SELF.FontName
     SELF.CtlFontName{PROP:FROM} = SELF.Fonts
  END
  IF SELF.CtlFontSize THEN
     SELF.CtlFontSize{PROP:USE} = SELF.FontSize
  END
  IF SELF.CtlFontScript THEN
     SELF.CtlFontScript{PROP:USE}  = SELF.FontScript
     SELF.CtlFontScript{PROP:FROM} = SELF.Scripts.Script
  END
  IF SELF.CtlBold THEN
     SELF.CtlBold{PROP:USE} = SELF.Bold
  END
  IF SELF.CtlItalic THEN
     SELF.CtlItalic{PROP:USE} = SELF.Italic
  END
  IF SELF.CtlUnderline THEN
     SELF.CtlUnderline{PROP:USE} = SELF.Underline
  END
  RETURN

! =============================================================================

RTFControlClass.UpdateControls          PROCEDURE(BYTE pRTFControlEquate,STRING pValue)
FontBitmap     LONG,AUTO
TextColor      LONG,AUTO
FIndex         LONG,AUTO
BulletsStyle   BYTE,AUTO
Ctl            SIGNED,AUTO
TFValue        BYTE,AUTO
  CODE
  TFValue = CHOOSE(pValue='' or pValue='0' OR UPPER(CLIP(pValue))='FALSE',False,True)
  CASE pRTFControlEquate
  OF RTFToolbar:CtlAlignment
    IF SELF.CtlAlignment THEN
       IF SELF.CtlAlignment{PROP:Visible} <> TRUE THEN RETURN.
       CHANGE (SELF.CtlAlignment, pValue+0)
    END
  OF RTFToolbar:CtlBullets
    IF SELF.CtlBullets THEN
       IF SELF.CtlBullets{PROP:Visible} <> TRUE THEN RETURN.
       BulletsStyle = pValue
       SELF.Bullets = CHOOSE (BulletsStyle <> PARA:Nothing)
       CHANGE (SELF.CtlBullets, SELF.Bullets)
    END
  OF RTFToolbar:CtlBulletStyle
    IF SELF.CtlBulletStyle THEN
      IF SELF.CtlBulletStyle{PROP:Visible} <> TRUE THEN RETURN.
      BulletsStyle = pValue
      IF BulletsStyle = PARA:Nothing
        IF SELF.CtlBulletStyle{PROP:SELECTED} = 0
          SELF.BulletStyle = PARA:Bullets
          SELF.CtlBulletStyle{PROP:SELECTED} = PARA:Bullets
        END
      ELSE
        SELF.BulletStyle = BulletsStyle
        SELF.CtlBulletStyle{PROP:SELECTED} = BulletsStyle
      END
    END
  OF RTFToolbar:CtlFontName
    IF SELF.CtlFontName THEN
      IF SELF.CtlFontName{PROP:Visible} <> TRUE THEN RETURN.
      CHANGE (SELF.CtlFontName, pValue)
      SELF.ReloadScripts()
      SELF.Fonts.TypeFace = pValue
      GET (SELF.Fonts, SELF.Fonts.TypeFace)
      IF ERRORCODE() = 0 THEN
        SELF.CtlFontName{PROP:SELECTED} = POINTER(SELF.Fonts)
      END
    END
  OF RTFToolbar:CtlFontSize
    IF SELF.CtlFontSize THEN
      IF SELF.CtlFontSize{PROP:Visible} <> TRUE THEN RETURN.
      SELF.FontSize = pValue
      CHANGE (SELF.CtlFontSize, SELF.FontSize)
      CASE SELF.FontSize
      OF 8 ; FIndex = 1
      OF 9 ; FIndex = 2
      OF 10; FIndex = 3
      OF 11; FIndex = 4
      OF 12; FIndex = 5
      OF 14; FIndex = 6
      OF 16; FIndex = 7
      OF 18; FIndex = 8
      OF 20; FIndex = 9
      OF 22; FIndex = 10
      OF 24; FIndex = 11
      OF 26; FIndex = 12
      OF 28; FIndex = 13
      OF 36; FIndex = 14
      OF 48; FIndex = 15
      OF 72; FIndex = 16
      ELSE
         FIndex = 1
      END
      SELF.CtlFontSize{PROP:SELECTED} = FIndex
    END
  OF RTFToolbar:CtlFontScript
    IF SELF.CtlFontScript THEN
       IF SELF.CtlFontScript{PROP:Visible} <> TRUE THEN RETURN.
       IF NUMERIC(pValue)
          SELF.Scripts.Charset = pValue
          GET (SELF.Scripts, SELF.Scripts.Charset)
       ELSE
          SELF.Scripts.Script = pValue
          GET (SELF.Scripts, SELF.Scripts.Script)
       END
       IF ERRORCODE() = 0 THEN
          SELF.CtlFontScript{PROP:SELECTED} = POINTER(SELF.Scripts)
       END
    END
  OF RTFToolbar:CtlBold
    IF SELF.CtlBold THEN
       IF SELF.CtlBold{PROP:Visible} <> TRUE THEN RETURN.
       CHANGE (SELF.CtlBold, TFValue)
    END
  OF RTFToolbar:CtlItalic
    IF SELF.CtlItalic THEN
       IF SELF.CtlItalic{PROP:Visible} <> TRUE THEN RETURN.
       CHANGE (SELF.CtlItalic, TFValue)
    END
  OF RTFToolbar:CtlUnderline
    IF SELF.CtlUnderline THEN
       IF SELF.CtlUnderline{PROP:Visible} <> TRUE THEN RETURN.
       CHANGE (SELF.CtlUnderline, TFValue)
    END
  OF RTFToolbar:CtlFontColor
  OROF RTFToolbar:CtlFontBkColor
    IF (pRTFControlEquate = RTFToolbar:CtlFontColor)
      Ctl = SELF.CtlFontColor
    ELSE
      Ctl = SELF.CtlFontBkColor
    END
    IF Ctl THEN
      IF Ctl{PROP:Visible} <> TRUE THEN RETURN.
      CASE pValue+0
      OF COLOR:Maroon
        TextColor = 2
      OF COLOR:Green
        TextColor = 3
      OF COLOR:Olive
        TextColor = 4
      OF COLOR:Navy
        TextColor = 5
      OF COLOR:Purple
        TextColor = 6
      OF COLOR:Teal
        TextColor = 7
      OF COLOR:Gray
        TextColor = 8
      OF COLOR:Silver
        TextColor = 9
      OF COLOR:Red
        TextColor = 10
      OF COLOR:Lime
        TextColor = 11
      OF COLOR:Yellow
        TextColor = 12
      OF COLOR:Blue
        TextColor = 13
      OF COLOR:Fuschia
        TextColor = 14
      OF COLOR:Aqua
        TextColor = 15
      OF COLOR:White
        TextColor = 16
      OF COLOR:NONE
        TextColor = 17
      ELSE
        TextColor = 1
      END
      Ctl{PROP:Selected} = TextColor
    END
  END
  RETURN

! =============================================================================

RTFControlClass.AddItem                 PROCEDURE(BYTE pRTFControlEquate,SIGNED pRTFToolbarControl)
  CODE
  CASE pRTFControlEquate
  OF RTFToolbar:CtlShowFileName ;SELF.CtlShowFileName = pRTFToolbarControl
  OF RTFToolbar:CtlShowLineNo   ;SELF.CtlShowLineNo   = pRTFToolbarControl
  OF RTFToolbar:CtlShowPosInLine;SELF.CtlShowPosInLine= pRTFToolbarControl
  OF RTFToolbar:CtlShowDirty    ;SELF.CtlShowDirty    = pRTFToolbarControl

  OF RTFToolbar:CtlButtonNew    ;SELF.CtlButtonNew    = pRTFToolbarControl
  OF RTFToolbar:CtlButtonOpen   ;SELF.CtlButtonOpen   = pRTFToolbarControl
  OF RTFToolbar:CtlButtonSave   ;SELF.CtlButtonSave   = pRTFToolbarControl
  OF RTFToolbar:CtlButtonPrint  ;SELF.CtlButtonPrint  = pRTFToolbarControl
  OF RTFToolbar:CtlButtonFind   ;SELF.CtlButtonFind   = pRTFToolbarControl
  OF RTFToolbar:CtlButtonFindAndReplace   ;SELF.CtlButtonFindAndReplace   = pRTFToolbarControl
  OF RTFToolbar:CtlButtonCut    ;SELF.CtlButtonCut    = pRTFToolbarControl
  OF RTFToolbar:CtlButtonCopy   ;SELF.CtlButtonCopy   = pRTFToolbarControl
  OF RTFToolbar:CtlButtonPaste  ;SELF.CtlButtonPaste  = pRTFToolbarControl
  OF RTFToolbar:CtlButtonUndo   ;SELF.CtlButtonUndo   = pRTFToolbarControl
  OF RTFToolbar:CtlButtonRedo   ;SELF.CtlButtonRedo   = pRTFToolbarControl
  OF RTFToolbar:CtlButtonTabs   ;SELF.CtlButtonTabs   = pRTFToolbarControl
  OF RTFToolbar:CtlButtonPara   ;SELF.CtlButtonPara   = pRTFToolbarControl

  OF RTFToolbar:CtlAlignment    ;SELF.CtlAlignment    = pRTFToolbarControl
  OF RTFToolbar:CtlAlignmentJust;SELF.CtlAlignmentJust= pRTFToolbarControl
  OF RTFToolbar:CtlBullets      ;SELF.CtlBullets      = pRTFToolbarControl
  OF RTFToolbar:CtlBulletStyle  ;SELF.CtlBulletStyle  = pRTFToolbarControl
  OF RTFToolbar:CtlFontName     ;SELF.CtlFontName     = pRTFToolbarControl
  OF RTFToolbar:CtlFontSize     ;SELF.CtlFontSize     = pRTFToolbarControl
  OF RTFToolbar:CtlFontScript   ;SELF.CtlFontScript   = pRTFToolbarControl
  OF RTFToolbar:CtlBold         ;SELF.CtlBold         = pRTFToolbarControl
  OF RTFToolbar:CtlItalic       ;SELF.CtlItalic       = pRTFToolbarControl
  OF RTFToolbar:CtlUnderline    ;SELF.CtlUnderline    = pRTFToolbarControl
  OF RTFToolbar:CtlFontColor    ;SELF.CtlFontColor    = pRTFToolbarControl
  OF RTFToolbar:CtlFontBkColor  ;SELF.CtlFontBkColor  = pRTFToolbarControl
  END
  RETURN

! =============================================================================

RTFControlClass.CheckUndoRedo           PROCEDURE()
  CODE
  IF SELF.Props.CanUndo() <> SELF.UndoEnabled
    IF SELF.UndoEnabled
      IF SELF.CtlButtonUndo
        DISABLE (SELF.CtlButtonUndo)
      END
    ELSE
      IF SELF.CtlButtonUndo
        ENABLE (SELF.CtlButtonUndo)
      END
    END
    SELF.UndoEnabled = BXOR (SELF.UndoEnabled, 1)
  END

  IF SELF.Props.CanRedo() <> SELF.RedoEnabled
    IF SELF.RedoEnabled
      IF SELF.CtlButtonRedo
        DISABLE (SELF.CtlButtonRedo)
      END
    ELSE
      IF SELF.CtlButtonRedo
        ENABLE (SELF.CtlButtonRedo)
      END
    END
    SELF.RedoEnabled = BXOR (SELF.RedoEnabled, 1)
  END
  RETURN

! =============================================================================

RTFControlClass.CheckPasteButton        PROCEDURE()
  CODE
  IF SELF.Props.CanPaste() <> SELF.PasteEnabled
    IF SELF.PasteEnabled
      IF SELF.CtlButtonPaste
        DISABLE (SELF.CtlButtonPaste)
      END
    ELSE
      IF SELF.CtlButtonPaste
        ENABLE (SELF.CtlButtonPaste)
      END
    END
    SELF.PasteEnabled = BXOR (SELF.PasteEnabled, 1)
  END
  RETURN

! =============================================================================

RTFControlClass.Resize                  PROCEDURE()
X              SIGNED,AUTO
Y              SIGNED,AUTO
W              SIGNED,AUTO
H              SIGNED,AUTO
  CODE
  IF SELF.CtlRTF THEN
    GETPOSITION (SELF.CtlRTF, X, Y, W, H)
    SELF.Props.SetPosition (X, Y, W, H)
  END
  RETURN

! =============================================================================

RTFControlClass.LoadFonts               PROCEDURE()
i    UNSIGNED,AUTO
  CODE
  IF NOT SELF.RTF &= NULL
    FREE(SELF.Fonts)
    SELF.RTF.LoadFonts (SELF.Fonts)
    LOOP i = 1 TO RECORDS (SELF.Fonts)
      GET (SELF.Fonts, i)

      IF BAND (SELF.Fonts.Technology, FONT:DEVICE)
        SELF.Fonts.Icon = 1
      ELSIF BAND (SELF.Fonts.Technology, FONT:BITMAP)
        SELF.Fonts.Icon = 2
      ELSIF BAND (SELF.Fonts.Technology, FONT:TRUETYPE)
        IF BAND (SELF.Fonts.Technology, FONT:OPENTRUETYPE)
          SELF.Fonts.Icon = 4
        ELSE
          SELF.Fonts.Icon = 3
        END
      END

      PUT (SELF.Fonts)
    END
    IF SELF.CtlFontName THEN
      SELF.CtlFontName{PROP:Lineheight}  = 10
      SELF.CtlFontName{PROP:IconList, 1} = '~PRNFONT.ICO'
      SELF.CtlFontName{PROP:IconList, 2} = '~BMPFONT.ICO'
      SELF.CtlFontName{PROP:IconList, 3} = '~TTFFONT.ICO'
      SELF.CtlFontName{PROP:IconList, 4} = '~OPENFONT.ICO'
    END
  END
  RETURN

! =============================================================================

RTFControlClass.RefreshFileName            PROCEDURE()
L         UNSIGNED,AUTO
i         UNSIGNED,AUTO
  CODE
  SELF.Props.FileName (SELF.FileName)
  IF SELF.CtlShowFileName
     IF SELF.FileName[1] = '<0>'
        SELF.CtlShowFileName{PROP:Text} = '<<<<<< UNKNOWN >>>'
     ELSE
        L = LEN (SELf.FileName)
        i = L

        LOOP
           IF SELF.FileName[i] = '\' OR SELF.FileName[i] = ':'
              i += 1
              BREAK
           END
              i -= 1
        UNTIL i = 0
        SELF.CtlShowFileName{PROP:Text} = SELF.FileName [i : L]
     END
  END

  SELF.RefreshLinePos()
  RETURN

! =============================================================================

RTFControlClass.RefreshLinePos            PROCEDURE()
  CODE
  IF SELF.CtlShowLineNo
     SELF.CtlShowLineNo{PROP:Text} = 'Line: ' & SELF.Props.CaretY() & ' of ' & SELF.Props.LineCount()
  END
  IF SELF.CtlShowPosInLine
     SELF.CtlShowPosInLine{PROP:Text} = 'Col: ' & SELF.Props.CaretX()
  END
  RETURN

! =============================================================================

RTFControlClass.Init                    PROCEDURE(SIGNED pRTFControl,<STRING pDefaultFileName>)
  CODE
  IF pRTFControl THEN
    IF NOT OMITTED(3)
       SELf.FileName = pDefaultFileName
    END
    SELF.CtlRTF = pRTFControl

    SELF.ShowInfoGroup(True)
    SELF.ShowCtlGroup(True)

    SELF.RTF   &= SELF.CtlRTF{PROP:Interface} + 0
    SELF.Props &= SELF.RTF.Properties()
    SELF.RTFFromFile = SELF.RTF.UseMode()
    IF NOT SELF.RTFFromFile THEN
       IF SELF.CtlShowFileName THEN
          SELF.CtlShowFileName{PROP:HIDE}=True
       END
    ELSE
       SELF.RTF.SetUse(SELF.FileNAme)
    END
    
    IF SELF.CtlShowDirty
       SELF.CtlShowDirty {PROP:Text} = ''
    END

    SELF.DefaultFont &= SELF.Props.Font (TRUE)
    SELF.CurrentFont &= SELF.Props.Font (FALSE)

    SELF.BindControls()

  ! === Setting default values

    SELF.Alignment   = 0
    SELF.Bold        = FALSE
    SELF.Italic      = FALSE
    SELF.Underline   = FALSE
    SELF.Bullets     = FALSE

  ! === Set initial font information

    SELF.DefaultFont.GetFont (SELF.FontName)
    SELF.FontSize    = SELF.DefaultFont.FontSize()
    SELF.FontScript  = SELF.DefaultFont.FontScript()
    SELF.FontColor   = SELF.DefaultFont.FontColor()
    SELF.FontStyle   = SELF.DefaultFont.FontStyle()
    SELF.FontWeight  = SELF.DefaultFont.FontWeight()
    SELF.FontBkColor = SELF.DefaultFont.FontBackColor()

    SELF.LoadFonts

    SELF.RTF.LoadScripts (SELF.Scripts, SELF.FontName)

    IF BAND (SELF.FontStyle, FONT:Italic)
       SELF.Italic = TRUE
    END

    IF BAND (SELF.FontStyle, FONT:Underline)
       SELF.Underline = TRUE
    END

    SELF.FontWeight = BAND (SELF.FontStyle, FONT:Weight)

    IF SELF.FontWeight = FONT:Bold
       SELF.Bold = TRUE
    END

  ! === Set RTF control position

    SELF.Resize()

  ! === Initialize other data

    SELF.RTF.Notify (SELF.RTFNotify)

    IF SELF.RTF.Version() < 0300h
       IF SELF.CtlAlignmentJust
          DISABLE (SELF.CtlAlignmentJust)           ! Not supported in RichEdit 2.0
       END
       IF SELF.CtlBulletStyle
          HIDE (SELF.CtlBulletStyle)                ! Not supported in RichEdit 2.0
       END
    ELSE
       IF SELF.CtlBulletStyle
          CHANGE (SELF.CtlBulletStyle, PARA:Bullets)
       END
    END

    IF SELF.CtlBulletStyle
       SELF.CtlBulletStyle{PROP:Icon}        = '~SBULLETS.ICO'
    END
    IF SELF.CtlFontColor
       SELF.CtlFontColor{PROP:Icon}        = '~color.ico'
       SELF.CtlFontColor{PROP:Lineheight}  = 10
       SELF.CtlFontColor{PROP:IconList,  1} = '~BLACK.BMP'
       SELF.CtlFontColor{PROP:IconList,  2} = '~MAROON.BMP'
       SELF.CtlFontColor{PROP:IconList,  3} = '~GREEN.BMP'
       SELF.CtlFontColor{PROP:IconList,  4} = '~OLIVE.BMP'
       SELF.CtlFontColor{PROP:IconList,  5} = '~NAVY.BMP'
       SELF.CtlFontColor{PROP:IconList,  6} = '~PURPLE.BMP'
       SELF.CtlFontColor{PROP:IconList,  7} = '~TEAL.BMP'
       SELF.CtlFontColor{PROP:IconList,  8} = '~GRAY.BMP'
       SELF.CtlFontColor{PROP:IconList,  9} = '~SILVER.BMP'
       SELF.CtlFontColor{PROP:IconList, 10} = '~RED.BMP'
       SELF.CtlFontColor{PROP:IconList, 11} = '~LIME.BMP'
       SELF.CtlFontColor{PROP:IconList, 12} = '~YELLOW.BMP'
       SELF.CtlFontColor{PROP:IconList, 13} = '~BLUE.BMP'
       SELF.CtlFontColor{PROP:IconList, 14} = '~FUSCHIA.BMP'
       SELF.CtlFontColor{PROP:IconList, 15} = '~AQUA.BMP'
       SELF.CtlFontColor{PROP:IconList, 16} = '~WHITE.BMP'
    END
    IF SELF.CtlFontBkColor
       SELF.CtlFontBkColor{PROP:Icon}        = '~BColor.ico'
       SELF.CtlFontBkColor{PROP:Lineheight}  = 10
       SELF.CtlFontBkColor{PROP:IconList,  1} = '~BLACK.BMP'
       SELF.CtlFontBkColor{PROP:IconList,  2} = '~MAROON.BMP'
       SELF.CtlFontBkColor{PROP:IconList,  3} = '~GREEN.BMP'
       SELF.CtlFontBkColor{PROP:IconList,  4} = '~OLIVE.BMP'
       SELF.CtlFontBkColor{PROP:IconList,  5} = '~NAVY.BMP'
       SELF.CtlFontBkColor{PROP:IconList,  6} = '~PURPLE.BMP'
       SELF.CtlFontBkColor{PROP:IconList,  7} = '~TEAL.BMP'
       SELF.CtlFontBkColor{PROP:IconList,  8} = '~GRAY.BMP'
       SELF.CtlFontBkColor{PROP:IconList,  9} = '~SILVER.BMP'
       SELF.CtlFontBkColor{PROP:IconList, 10} = '~RED.BMP'
       SELF.CtlFontBkColor{PROP:IconList, 11} = '~LIME.BMP'
       SELF.CtlFontBkColor{PROP:IconList, 12} = '~YELLOW.BMP'
       SELF.CtlFontBkColor{PROP:IconList, 13} = '~BLUE.BMP'
       SELF.CtlFontBkColor{PROP:IconList, 14} = '~FUSCHIA.BMP'
       SELF.CtlFontBkColor{PROP:IconList, 15} = '~AQUA.BMP'
       SELF.CtlFontBkColor{PROP:IconList, 16} = '~WHITE.BMP'
    END

    SELF.CutCopyEnabled = FALSE
    SELF.PasteEnabled   = FALSE
    SELF.UndoEnabled    = FALSE
    SELF.RedoEnabled    = FALSE

    SELF.VScroller &= SELF.Props.ScrollBar (SCROLLBAR:Vertical)
    SELF.HScroller &= SELF.Props.ScrollBar (SCROLLBAR:Horizontal)

    SELF.Props.WrapMode (WRAP:ToWindow)

    SELF.Props.Boxed (TRUE)                   ! Draw border around the control
    SELF.Props.Flat (TRUE)                    ! Make border not-3D

    IF SELF.RTFFromFile THEN
       SELF.RefreshFileName()
    END

    SELF.Props.Touch (FALSE)

    SELF.UpdateControls(RTFToolbar:CtlBullets,False)
    SELF.UpdateControls(RTFToolbar:CtlBulletStyle,0)
    SELF.UpdateControls(RTFToolbar:CtlAlignment,SELF.Props.Alignment())
    SELF.UpdateControls(RTFToolbar:CtlFontName,SELF.FontName)
    SELF.UpdateControls(RTFToolbar:CtlFontSize,SELF.FontSize)
    SELF.UpdateControls(RTFToolbar:CtlFontScript,SELF.FontScript)
    SELF.UpdateControls(RTFToolbar:CtlBold,CHOOSE (SELF.FontWeight >= FONT:Bold))
    SELF.UpdateControls(RTFToolbar:CtlItalic,SELF.Italic)
    SELF.UpdateControls(RTFToolbar:CtlUnderline,SELF.Underline)
    SELF.UpdateControls(RTFToolbar:CtlFontColor,SELF.FontColor)
    SELF.UpdateControls(RTFToolbar:CtlFontBkColor,NotAColor)
  END
  RETURN

! =============================================================================

RTFControlClass.Load                    PROCEDURE (<CONST *CSTRING filename>)
  CODE
  IF NOT SELF.RTF &= NULL
     IF NOT OMITTED(2)
        IF SELF.RTFFromFile
           SELF.FileName=''
           SELF.CtlRTF{PROP:Use}=''
        END
        SELF.RTF.Load(filename)
     ELSE
        SELF.RTF.Load()
     END
     SELF.RefreshFileName()
     SELF.RTF.SetFocus()
  END
  RETURN

! =============================================================================

RTFControlClass.Save                    PROCEDURE (<CONST *CSTRING filename>, UNSIGNED mode = TEXT:Default)
lFileName   CSTRING(256)
  CODE
  IF NOT SELF.RTF &= NULL
     IF SELF.GetRTFFromFile()
        SELF.RTF.Save(filename,mode)
     ELSE
        lFileName=''
        SELF.RTF.Save(lFileName,mode)
     END
     SELF.RefreshFileName()
     SELF.RTF.SetFocus()
  END
  RETURN

! =============================================================================

RTFControlClass.SaveAs                  PROCEDURE (UNSIGNED mode = TEXT:Default)
lFileName   CSTRING(256)
  CODE
  IF NOT SELF.RTF &= NULL
     lFileName=''
     SELF.RTF.Save(lFileName,mode)
     SELF.RefreshFileName()
     SELF.RTF.SetFocus()
  END
  RETURN

! =============================================================================

RTFControlClass.Kill                    PROCEDURE()
  CODE
  FREE (SELF.Fonts)
  FREE (SELF.Scripts)

  IF NOT SELF.RTF &= NULL
    SELF.RTF.Notify()

    SELF.RTF   &= NULL
    SELF.Props &= NULL
  END

  SELF.ShowInfoGroup(FALSE)
  SELF.ShowCtlGroup(FALSE)
  RETURN

! =============================================================================

RTFControlClass.TakeEvent               PROCEDURE()
  CODE
  IF SELF.CtlRTF{PROP:Visible}
     IF NOT SELF.RTF &= NULL
        SELF.CheckPasteButton()
        SELF.CheckUndoRedo()
        CASE EVENT()
        OF EVENT:Accepted
           RETURN SELF.TakeAccepted()
        END
     END
  END

  RETURN Level:Benign

! =============================================================================
  
RTFControlClass.TakeAccepted            PROCEDURE()
RetVal         BYTE,AUTO
  CODE
  RetVal = Level:Benign
  IF SELF.CtlRTF{PROP:Visible}
     IF NOT SELF.RTF &= NULL
        RetVal = Level:Notify
        CASE ACCEPTED()
        OF 0
        OF SELF.CtlButtonNew
          SELF.RTF.Reset()
          SELF.FileName = ''
          SELF.RefreshFileName
          SELF.RTF.SetFocus()
        OF SELF.CtlButtonOpen
          SELF.Load()
        OF SELF.CtlButtonSave
          SELF.Save()
        OF SELF.CtlButtonFind
          SELF.FindDlg()
          SELF.RTF.SetFocus()
        OF SELF.CtlButtonFindAndReplace
          SELF.FindAndReplaceDlg()
          SELF.RTF.SetFocus()
        OF SELF.CtlButtonPrint
           SELF.PrintDocument(SELF.DocumentTitle)
        OF SELF.CtlButtonCut
          SELF.Props.Cut()
        OF SELF.CtlButtonCopy
          SELF.Props.Copy()
        OF SELF.CtlButtonPaste
          SELF.Props.Paste()
        OF SELF.CtlButtonUndo
          SELF.Props.Undo()
        OF SELF.CtlButtonRedo
          SELF.Props.Redo()
        OF SELF.CtlButtonTabs
          SELF.TabDlg (SELF.Props.Unit())
          SELF.RTF.SetFocus()
        OF SELF.CtlButtonPara
          SELF.IndentDlg()
          SELF.RTF.SetFocus()
        OF SELF.CtlAlignment
          SELF.Props.Alignment (SELF.Alignment)
        OF SELF.CtlBullets
          SELF.Props.BulletStyle (CHOOSE (NOT SELF.Bullets, PARA:Nothing, SELF.BulletStyle))
        OF SELF.CtlBulletStyle
          IF SELF.Bullets
             SELF.Props.BulletStyle (SELF.BulletStyle)
          END
        OF SELF.CtlFontName
          SELF.CurrentFont.SetFont (SELF.FontName)
          SELF.ReloadScripts
        OF SELF.CtlFontSize
          SELF.CurrentFont.FontSize (SELF.FontSize)
        OF SELF.CtlFontScript
          SELF.CurrentFont.FontScript (SELF.FontScript)
        OF SELF.CtlBold
          IF SELF.Bold
            SELF.CurrentFont.FontWeight (FONT:Bold)
          ELSE
            SELF.CurrentFont.FontWeight (FONT:Regular)
          END
        OF SELF.CtlItalic
          SELF.CurrentFont.FontItalic (SELF.Italic)
        OF SELF.CtlUnderline
          SELF.CurrentFont.FontUnderline (SELF.Underline)
        OF SELF.CtlFontColor
          SELF.CurrentFont.FontColor (CHOOSE (CHOICE (SELF.CtlFontColor), COLOR:Black,    |
                                                              COLOR:Maroon,   |
                                                              COLOR:Green,    |
                                                              COLOR:Olive,    |
                                                              COLOR:Navy,     |
                                                              COLOR:Purple,   |
                                                              COLOR:Teal,     |
                                                              COLOR:Gray,     |
                                                              COLOR:Silver,   |
                                                              COLOR:Red,      |
                                                              COLOR:Lime,     |
                                                              COLOR:Yellow,   |
                                                              COLOR:Blue,     |
                                                              COLOR:Fuschia,  |
                                                              COLOR:Aqua,     |
                                                              COLOR:White,    |
                                                              COLOR:NONE))
          SELF.RTF.SetFocus()
        OF SELF.CtlFontBkColor
          SELF.CurrentFont.FontBackColor (CHOOSE (CHOICE (SELF.CtlFontBkColor), COLOR:Black,    |
                                                              COLOR:Maroon,   |
                                                              COLOR:Green,    |
                                                              COLOR:Olive,    |
                                                              COLOR:Navy,     |
                                                              COLOR:Purple,   |
                                                              COLOR:Teal,     |
                                                              COLOR:Gray,     |
                                                              COLOR:Silver,   |
                                                              COLOR:Red,      |
                                                              COLOR:Lime,     |
                                                              COLOR:Yellow,   |
                                                              COLOR:Blue,     |
                                                              COLOR:Fuschia,  |
                                                              COLOR:Aqua,     |
                                                              COLOR:White,     |
                                                              COLOR:NONE))

          SELF.RTF.SetFocus()
        ELSE
          RetVal = Level:Benign
        END
     END
  END
  RETURN RetVal

! =============================================================================

RTFControlClass.GetRTFFromFile          PROCEDURE()
  CODE
     RETURN SELF.RTFFromFile

! =============================================================================

RTFControlClass.TakeAction              PROCEDURE(BYTE pRTFControlEquate,<STRING pRTFControlValue>)
RetVal         BYTE,AUTO
CurrentPrinter CSTRING(251),AUTO
  CODE
  RetVal = Level:Benign
  IF SELF.CtlRTF{PROP:Visible}
     IF NOT SELF.RTF &= NULL
        RetVal = Level:Notify
        CASE pRTFControlEquate
        OF RTFToolbar:CtlButtonNew    
           SELF.RTF.Reset()
           SELF.RefreshFileName
           SELF.RTF.SetFocus()
        OF RTFToolbar:CtlButtonOpen
           SELF.Load()
        OF RTFToolbar:CtlButtonSave
           SELF.Save()
        OF RTFToolbar:CtlButtonPrint
           CurrentPrinter = PRINTER{PROPPRINT:Device}
           IF PRINTERDIALOG('Choose Printer')
              SELF.PrintDocument(SELF.DocumentTitle)
              PRINTER{PROPPRINT:Device} = CurrentPrinter
           END
        OF RTFToolbar:CtlButtonFind
           SELF.FindDlg()
           SELF.RTF.SetFocus()
        OF RTFToolbar:CtlButtonFindAndReplace
           SELF.FindAndReplaceDlg()
           SELF.RTF.SetFocus()
        OF RTFToolbar:CtlButtonCut
           SELF.Props.Cut()
        OF RTFToolbar:CtlButtonCopy
           SELF.Props.Copy()
        OF RTFToolbar:CtlButtonPaste
           SELF.Props.Paste()
        OF RTFToolbar:CtlButtonUndo
           SELF.Props.Undo()
        OF RTFToolbar:CtlButtonRedo
           SELF.Props.Redo()
        OF RTFToolbar:CtlButtonTabs
           SELF.TabDlg (SELF.Props.Unit())
           SELF.RTF.SetFocus()
        OF RTFToolbar:CtlButtonPara
           SELF.IndentDlg()
           SELF.RTF.SetFocus()

        OF RTFToolbar:CtlAlignment    
        OF RTFToolbar:CtlAlignmentJust
        OF RTFToolbar:CtlBullets      
        OF RTFToolbar:CtlBulletStyle  
        OF RTFToolbar:CtlFontName     
        OF RTFToolbar:CtlFontSize     
        OF RTFToolbar:CtlFontScript   
        OF RTFToolbar:CtlBold         
        OF RTFToolbar:CtlItalic       
        OF RTFToolbar:CtlUnderline    
        OF RTFToolbar:CtlFontColor    
        OF RTFToolbar:CtlFontBkColor  
        END
     END
  END
  RETURN RetVal

! =============================================================================

RTFControlClass.IndentDlg               PROCEDURE()
Left       LONG,AUTO
Right      LONG,AUTO
First      LONG,AUTO
Unit       BYTE,AUTO
Unit1      BYTE,AUTO

W    WINDOW('Paragraph Indents'),AT(,,156,121),FONT('Tahoma',8,,FONT:regular,CHARSET:ANSI),SYSTEM,GRAY, |
         AUTO
       PROMPT('&Units:'),AT(10,12),USE(?Propmpt:Units),TRN
       LIST,AT(57,10,85,12),USE(Unit),LEFT(2),TIP('Units'),DROP(10),FROM('1/100 of millimeter|#1|1/1000 of inch|#2|twips (1/1440 of inch)|#3')
       PROMPT('&First:'),AT(10,34),USE(?Prompt:First),TRN
       SPIN(@N-_6),AT(57,32,84,12),USE(First),RIGHT(2),TIP('First line indent'),RANGE(-99999,99999),STEP(1)
       PROMPT('&Left:'),AT(10,56),USE(?Prompt:Left),TRN
       SPIN(@N-_6),AT(57,54,84,12),USE(Left),RIGHT(2),TIP('Left indent relative first line'),RANGE(-99999,99999),STEP(1)
       PROMPT('&Right:'),AT(11,78),USE(?Prompt:Right),TRN
       SPIN(@N-_6),AT(57,76,84,12),USE(Right),RIGHT(2),TIP('Right indent'),RANGE(-99999,99999),STEP(1)
       BUTTON('OK'),AT(46,97,45,14),USE(?OK),TIP('Save changes'),DEFAULT
       BUTTON('Cancel'),AT(96,97,45,14),USE(?Cancel),TIP('Discard changes'),KEY(EscKey)
     END


  CODE
  Unit  = SELF.Props.Unit()
  Unit1 = Unit
  SELF.Props.GetIndent (Left, Right, First)
  Left += First

  OPEN (W)

  ACCEPT
    CASE EVENT()
    OF EVENT:Accepted
      CASE ACCEPTED()
      OF ?OK
        Left -= First
        SELF.Props.Unit (Unit)
        SELF.Props.SetIndent (Left, Right, First)
      OROF ?Cancel
        POST (EVENT:CloseWindow)
      END
    OF EVENT:NewSelection
      IF FIELD() = ?Unit
        Left  = SELF.FromTwips (SELF.ToTwips (Left,  Unit1), Unit)
        Right = SELF.FromTwips (SELF.ToTwips (Right, Unit1), Unit)
        First = SELF.FromTwips (SELF.ToTwips (First, Unit1), Unit)
        Unit1 = Unit
      END
    END
  END

  CLOSE (W)
  RETURN

! =============================================================================

RTFControlClass.TabDlg                  PROCEDURE(BYTE Unit)
TabQ       QUEUE,AUTO
pos          LONG
           END
Unit1      BYTE,AUTO
EIP        BYTE,AUTO
Dirty      BOOLEAN,AUTO
NTabs      UNSIGNED,AUTO
i          UNSIGNED,AUTO
Tabs       &RTFTabs,AUTO

W    WINDOW('Tabs'),AT(,,232,185),FONT('Tahoma',8,,),IMM,ALRT(EscKey),SYSTEM,GRAY,AUTO
       PROMPT('&Units:'),AT(10,12),USE(?Propmpt:Units),TRN
       LIST,AT(57,10,85,12),USE(Unit),SKIP,LEFT(2),TIP('Units'),DROP(10),FROM('1/100 of millimeter|#1|1/1000 of inch|#2|twips (1/1440 of inch)|#3')
       GROUP('&Tabs'),AT(12,30,132,145),USE(?Group:Tabs),BOXED,TRN
       END
         LIST,AT(25,47,106,116),USE(?TabList),FLAT,VSCROLL,RIGHT(2),TIP('List of tab stops'),COLUMN, |
             FORMAT('20R(2)_@N-_6@'),FROM(TabQ)
       BUTTON('OK'),AT(163,10,45,14),USE(?OK),SKIP,TIP('Save changes'),DEFAULT
       BUTTON('Cancel'),AT(164,30,45,14),USE(?Cancel),SKIP,TIP('Discard changes')
       BUTTON('&Insert'),AT(164,66,45,14),USE(?Insert),SKIP,TIP('Add new tab stop'),KEY(InsertKey)
       BUTTON('&Change'),AT(164,87,45,14),USE(?Change),SKIP,TIP('Change tab stop'),KEY(CtrlEnter)
       BUTTON('&Delete'),AT(164,107,45,14),USE(?Delete),SKIP,TIP('Delete tab stop'),KEY(DeleteKey)
       BUTTON('Clear &All'),AT(164,128,45,14),USE(?DoAll),SKIP,TIP('Clear all tab stops'),KEY(CtrlDelete)
       ENTRY(@N-_6),AT(153,162,60,10),USE(TabQ.Pos,,?Edit),HIDE
     END

  CODE
  Dirty = FALSE
  EIP   = 0
  Unit1 = Unit
  Tabs &= SELF.Props.Tabs()
  NTabs = Tabs.Count()

  LOOP WHILE NTabs <> 0
    TabQ.pos = Tabs.Tab (NTabs)
    ADD (TabQ)
    NTabs -= 1
  END

  SORT (TabQ, TabQ.pos)

  OPEN (W)

  ?TabList {PROP:LineHeight} = 10

  DO TabDlgCheckButtons
  SELECT (?TabList)

  ACCEPT
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF MouseLeft2
        POST (EVENT:Accepted, ?Change)
      OF EscKey
        IF EIP <> 0
          IF EIP = 1
            DELETE (TabQ)
          END
          DO StopEIP
        ELSE
          POST (EVENT:Accepted, ?Cancel)
        END
      OF EnterKey
        IF EIP <> 0
          POST (EVENT:Accepted, ?Edit)
        ELSE
          POST (EVENT:Accepted, ?OK)
        END
      END
    OF EVENT:Accepted
      CASE ACCEPTED()
      OF ?OK
        IF Dirty
          Tabs.RemoveAll()
          LOOP i = 1 TO RECORDS (TabQ)
            GET (TabQ, i)
            Tabs.Insert (TabQ.pos, Unit)
          END
          Tabs.Update()
        END
      OROF ?Cancel
        POST (EVENT:CloseWindow)
      OF ?Unit
        DO TabDlgChangeUnit
        DISPLAY (?TabList)
      OF ?Delete
        IF CHOICE(?TabList) <> 0
          GET (TabQ, CHOICE(?TabList))
          DELETE (TabQ)
          Dirty = TRUE
        END
        DO TabDlgCheckButtons
      OF ?DoAll
        FREE (TabQ)
        Dirty = TRUE
        DO TabDlgCheckButtons
      OF ?Insert
        TabQ.pos = 0
        ADD (TabQ)
        GET (TabQ, RECORDS (TabQ))
        SELECT (?TabList, RECORDS (TabQ))

        DO StartEIP
        EIP = 1
      OF ?Change
        IF CHOICE(?TabList) <> 0
          GET (TabQ, CHOICE (?TabList))

          DO StartEIP
          EIP = 2
        END
      OF ?Edit
        PUT (TabQ)
        SORT (TabQ, TabQ.pos)
        DO StopEIP

        Dirty = TRUE
        SELECT (?TabList, POSITION (TabQ))
      END
    END
  END

  CLOSE (W)
  RETURN

TabDlgChangeUnit  ROUTINE
  IF Unit <> Unit1
    LOOP i = 1 TO RECORDS (TabQ)
      GET (TabQ, i)
      TabQ.pos = SELF.FromTwips (SELF.ToTwips (TabQ.pos, Unit1), Unit)
      PUT (TabQ)
    END

    Unit1 = Unit
  END

StartEIP  ROUTINE
  ?TabList {PROP:Edit, 1} = ?Edit
  SELECT (?Edit)
  DISABLE (?OK, ?DoAll)
  EXIT

StopEIP  ROUTINE
  EIP = 0
  ?TabList {PROP:Edit, 1} = 0
  HIDE (?Edit)
  ENABLE (?OK, ?Insert)
  DO TabDlgCheckButtons
  EXIT

TabDlgCheckButtons  ROUTINE
  IF RECORDS (TabQ) = 0
    DISABLE (?Change, ?DoAll)
  ELSE
    ENABLE (?Change, ?DoAll)
  END

! =============================================================================

RTFControlClass.FindDlg                 PROCEDURE(<STRING Text>)
ExitEvent  UNSIGNED,AUTO
  CODE
  START (RTFFindDlg,, ADDRESS (SELF.RTF), Text)

  ACCEPT
    CASE EVENT()
    OF EVENT:FindOK
    OROF EVENT:FindCancel
      ExitEvent = EVENT()
      BREAK
    END
  END

  RETURN CHOOSE (ExitEvent = EVENT:FindOK)

! =============================================================================

RTFControlClass.FindAndReplaceDlg       PROCEDURE(<STRING Text>)
ExitEvent  UNSIGNED,AUTO
  CODE
  START (RTFFindAndRelaceDlg,, ADDRESS (SELF.RTF), Text)

  ACCEPT
    CASE EVENT()
    OF EVENT:FindOK
    OROF EVENT:FindCancel
      ExitEvent = EVENT()
      BREAK
    END
  END

  RETURN CHOOSE (ExitEvent = EVENT:FindOK)

! =============================================================================

RTFControlClass.PrintDocument             PROCEDURE(<STRING Text>,BYTE Silent=0)
RetValue    BYTE,AUTO
  CODE
  RetValue = 0
  IF SELF.Props.Length()>0
     RetValue = SELF.RTF.PrintRTF (Text)
     IF NOT Silent THEN
       IF RetValue <> 0
         BEEP (BEEP:SystemExclamation)
         MESSAGE ('Printing error ' & RetValue, 'Error', ICON:Hand)
       END
     END
  END
  RETURN RetValue

! =============================================================================

RTFControlClass.RTFNotify.EventCallback PROCEDURE (LONG event)
  CODE
  CASE event
  OF NOTIFY:Dirty
    IF SELF.GetRTFFromFile()
       IF MESSAGE ('Text is changed. Do you want to save it?', 'Text is changed', |
                   ICON:Exclamation, BUTTON:Yes + BUTTON:No, BUTTON:Yes) = BUTTON:No
         RETURN 0
       END
    END
  OF NOTIFY:Undo
    SELF.UndoAction = SELF.Props.WhatUndo()
  OF NOTIFY:TextMode
    RETURN 0
  END

  RETURN 1

! =============================================================================

RTFControlClass.ShowInfoGroup   PROCEDURE(BYTE pShowIt)
  CODE
  IF SELF.CtlShowFileName THEN 
    SELF.CtlShowFileName{PROP:HIDE} = CHOOSE (NOT pShowIt)
  END
  IF SELF.CtlShowLineNo THEN 
    SELF.CtlShowLineNo{PROP:HIDE} = CHOOSE (NOT pShowIt)
  END
  IF SELF.CtlShowPosInLine THEN 
    SELF.CtlShowPosInLine{PROP:HIDE} = CHOOSE (NOT pShowIt)
  END
  IF SELF.CtlShowDirty THEN 
    SELF.CtlShowDirty{PROP:HIDE} = CHOOSE (NOT pShowIt)
  END
  RETURN

! =============================================================================

RTFControlClass.ShowCtlGroup    PROCEDURE(BYTE pShowIt)
  CODE
  IF SELF.CtlButtonNew    THEN SELF.CtlButtonNew{PROP:HIDE}   = CHOOSE (NOT pShowIt).
  IF SELF.CtlButtonOpen   THEN SELF.CtlButtonOpen{PROP:HIDE}  = CHOOSE (NOT pShowIt).
  IF SELF.CtlButtonSave   THEN SELF.CtlButtonSave{PROP:HIDE}  = CHOOSE (NOT pShowIt).
  IF SELF.CtlButtonPrint  THEN SELF.CtlButtonPrint{PROP:HIDE} = CHOOSE (NOT pShowIt).
  IF SELF.CtlButtonFind   THEN SELF.CtlButtonFind{PROP:HIDE}  = CHOOSE (NOT pShowIt).
  IF SELF.CtlButtonFindAndReplace   THEN SELF.CtlButtonFindAndReplace{PROP:HIDE} = CHOOSE (NOT pShowIt).
  IF SELF.CtlButtonCut    THEN SELF.CtlButtonCut{PROP:HIDE}   = CHOOSE (NOT pShowIt).
  IF SELF.CtlButtonCopy   THEN SELF.CtlButtonCopy{PROP:HIDE}  = CHOOSE (NOT pShowIt).
  IF SELF.CtlButtonPaste  THEN SELF.CtlButtonPaste{PROP:HIDE} = CHOOSE (NOT pShowIt).
  IF SELF.CtlButtonUndo   THEN SELF.CtlButtonUndo{PROP:HIDE}  = CHOOSE (NOT pShowIt).
  IF SELF.CtlButtonRedo   THEN SELF.CtlButtonRedo{PROP:HIDE}  = CHOOSE (NOT pShowIt).
  IF SELF.CtlButtonTabs   THEN SELF.CtlButtonTabs{PROP:HIDE}  = CHOOSE (NOT pShowIt).
  IF SELF.CtlButtonPara   THEN SELF.CtlButtonPara{PROP:HIDE}  = CHOOSE (NOT pShowIt).
  IF SELF.CtlAlignment    THEN SELF.CtlAlignment{PROP:HIDE}   = CHOOSE (NOT pShowIt).
  IF SELF.CtlBullets      THEN SELF.CtlBullets{PROP:HIDE}     = CHOOSE (NOT pShowIt).
  IF SELF.CtlBulletStyle  THEN SELF.CtlBulletStyle{PROP:HIDE} = CHOOSE (NOT pShowIt).
  IF SELF.CtlFontName     THEN SELF.CtlFontName{PROP:HIDE}    = CHOOSE (NOT pShowIt).
  IF SELF.CtlFontSize     THEN SELF.CtlFontSize{PROP:HIDE}    = CHOOSE (NOT pShowIt).
  IF SELF.CtlFontScript   THEN SELF.CtlFontScript{PROP:HIDE}  = CHOOSE (NOT pShowIt).
  IF SELF.CtlBold         THEN SELF.CtlBold{PROP:HIDE}        = CHOOSE (NOT pShowIt).
  IF SELF.CtlItalic       THEN SELF.CtlItalic{PROP:HIDE}      = CHOOSE (NOT pShowIt).
  IF SELF.CtlUnderline    THEN SELF.CtlUnderline{PROP:HIDE}   = CHOOSE (NOT pShowIt).
  IF SELF.CtlFontColor    THEN SELF.CtlFontColor{PROP:HIDE}   = CHOOSE (NOT pShowIt).
  IF SELF.CtlFontBkColor  THEN SELF.CtlFontBkColor{PROP:HIDE} = CHOOSE (NOT pShowIt).
  RETURN

! =============================================================================

RTFControlClass.ToTwips  PROCEDURE (LONG V, BYTE Unit)
  CODE
  IF Unit = UNIT:MM100
    V = MulDiv (V, 144, 254)
  ELSIF Unit = UNIT:Inch1000
    V = MulDiv (V, 144, 100)
  END

  RETURN V

! =============================================================================

RTFControlClass.FromTwips  PROCEDURE (LONG V, BYTE Unit)
  CODE
  IF Unit = UNIT:MM100
    V = MulDiv (V, 254, 144)
  ELSIF Unit = UNIT:Inch1000
    V = MulDiv (V, 100, 144)
  END

  RETURN V

! =============================================================================

RTFControlClass.ReloadScripts  PROCEDURE
N    UNSIGNED,AUTO
  CODE
  FREE (SELF.Scripts)
  SELF.RTF.LoadScripts (SELF.Scripts, SELF.FontName)

  SELF.Scripts.Charset = SELF.FontScript
  N = POSITION (SELF.Scripts)

  IF ERRORCODE()
    SELF.FontScript = SELF.CurrentFont.FontScript()
    SELF.Scripts.Charset = SELF.FontScript
    N = POSITION (SELF.Scripts)
  END
  IF SELF.CtlFontScript
     SELF.CtlFontScript {PROP:Selected} = N
  END
  RETURN

! =============================================================================

RTFControlClass.SelectedText            PROCEDURE(*CSTRING pText)
lSelection &RTFSelection
  CODE
     IF NOT SELF.RTF &= NULL
        lSelection &= SELF.Props.Selection()
        IF lSelection.SelectionType()=SELECT:Text OR lSelection.SelectionType()=SELECT:MultiChar
           lSelection.SelectedText(pText)
        END
     END
  RETURN

! =============================================================================

RTFControlClass.SetFocus                PROCEDURE ()
  CODE
     IF NOT SELF.RTF &= NULL
        SELF.RTF.SetFocus()
     END
  RETURN

! =============================================================================

RTFControlClass.PrintRTF                PROCEDURE (<STRING jobname>, BYTE device = TARGET:Printer)
  CODE
     IF NOT SELF.RTF &= NULL
        RETURN SELF.RTF.PrintRTF(jobname, device)
     END
  RETURN False

! =============================================================================

RTFControlClass.Changed                 PROCEDURE ()
  CODE
     IF NOT SELF.RTF &= NULL
        RETURN SELF.Props.Changed()
     END
  RETURN False

! =============================================================================

RTFControlClass.Touch                   PROCEDURE (BYTE onoff)
  CODE
     IF NOT SELF.RTF &= NULL
        SELF.Props.Touch(onoff)
     END
  RETURN

! =============================================================================

RTFControlClass.FindAndReplace          PROCEDURE(STRING SearchText,STRING ReplaceText,ULONG pFlags)
Flags      DWORD,AUTO
SText      CSTRING(256),AUTO
RText      CSTRING(256),AUTO
  CODE
  Flags = 0
  SText = SearchText
  RText = ReplaceText
  Flags = FIND:ReplaceAll
  IF BAND (pFlags, FIND:MatchCase)
    Flags += FIND:MatchCase
  END
  IF BAND (pFlags, FIND:WholeWord)
    Flags += FIND:WholeWord
  END
  IF SearchText
    SELF.RTF.FindAndReplace (SText, RText, Flags, 0)
  END
  RETURN

! =============================================================================

RTFFindDlg  PROCEDURE (STRING ARTF, STRING Text)

RTF        &RTFHandler,AUTO
Props      &RTFProperty,AUTO
Selection  &RTFSelection,AUTO
OwnerW     &WINDOW,AUTO

SText      CSTRING(256),AUTO
Down       BOOLEAN(TRUE)
WholeWord  BOOLEAN(FALSE)
MatchCase  BOOLEAN(FALSE)
Found      BOOLEAN(FALSE)
Flags      DWORD,AUTO

W    WINDOW('Find'),AT(,,236,62),FONT('Tahoma',8,,),IMM,GRAY,DOUBLE
       PROMPT('Fi&nd what:'),AT(5,7),RIGHT
       ENTRY(@s255),AT(41,7,137,10),USE(SText),LEFT(2)
       CHECK(' &Whole words only'),AT(3,35),USE(WholeWord)
       OPTION('Direction'),AT(107,35,71,23),USE(Down),BOXED
         RADIO('&Up'),AT(111,45),USE(?ToTop),VALUE('0')
         RADIO('&Down'),AT(138,45),USE(?ToEnd),VALUE('1')
       END
       CHECK(' &Case sensitive search'),AT(3,48),USE(MatchCase)
       BUTTON('&Find Next'),AT(184,5,48,14),USE(?Find),DEFAULT
       BUTTON('Cancel'),AT(184,24,48,14),USE(?Cancel)
     END

  CODE
  RTF &= ARTF + 0
  IF RTF &= NULL
    Props     &= NULL
    Selection &= NULL
    OwnerW    &= NULL
  ELSE
    Props     &= RTF.Properties()
    Selection &= Props.Selection()
    OwnerW    &= RTF.OwnerWindow()
  END

  IF  LEN (CLIP (Text)) <> 0
    SText = Text
  ELSIF NOT Selection &= NULL
    Selection.SelectedText (SText)
    
    IF SText[1] ='<0>'
      RTF.FindHistory (SText)
    END
  END

  OPEN (W, OwnerW)
  ACCEPT
    IF EVENT() = EVENT:ACCEPTED
      CASE ACCEPTED()
      OF ?Cancel
        POST (EVENT:CloseWindow)
      OF ?Find
        Flags = 0
        IF NOT Down
          Flags += FIND:Back
        END
        IF MatchCase
          Flags += FIND:MatchCase
        END
        IF WholeWord
          Flags += FIND:WholeWord
        END

        IF RTF.Find (SText, Flags) = -1
          BEEP (BEEP:SystemExclamation)
          MESSAGE ('"' & SText & '" not found.', 'Search', ICON:Question, BUTTON:OK)
        ELSE
          Found = TRUE
          DISPLAY
        END
      END
    END
  END
  POST (CHOOSE (NOT Found, EVENT:FindCancel, EVENT:FindOK),, OwnerW {PROP:Thread})
  RETURN

! =============================================================================

RTFFindAndRelaceDlg  PROCEDURE (STRING ARTF, STRING Text)

RTF        &RTFHandler,AUTO
Props      &RTFProperty,AUTO
Selection  &RTFSelection,AUTO
OwnerW     &WINDOW,AUTO

SText      CSTRING(256),AUTO
RText      CSTRING(256),AUTO
Down       BOOLEAN(TRUE)
WholeWord  BOOLEAN(FALSE)
MatchCase  BOOLEAN(FALSE)
Found      BOOLEAN(FALSE)
Flags      DWORD,AUTO
lPos       LONG,AUTO
lLoop      BYTE,AUTO

W    WINDOW('Find and Replace'),AT(,,236,70),FONT('Tahoma',8,,),IMM,GRAY,DOUBLE
       PROMPT('Fi&nd what:'),AT(2,7),RIGHT
       ENTRY(@s255),AT(47,7,131,10),USE(SText),LEFT(2)
       PROMPT('Replace with:'),AT(2,23),USE(?Prompt2),RIGHT
       ENTRY(@s255),AT(47,23,131,10),USE(RText),LEFT(2)
       CHECK(' &Whole words only'),AT(3,39),USE(WholeWord)
       OPTION('Direction'),AT(107,39,71,23),USE(Down),BOXED
         RADIO('&Up'),AT(111,49),USE(?ToTop),VALUE('0')
         RADIO('&Down'),AT(138,49),USE(?ToEnd),VALUE('1')
       END
       CHECK(' &Case sensitive search'),AT(3,52),USE(MatchCase)
       BUTTON('&Find Next'),AT(184,5,48,14),USE(?Find),DEFAULT
       BUTTON('&Replace'),AT(184,21,48,14),USE(?Replace)
       BUTTON('Replace &All'),AT(184,37,48,14),USE(?ReplaceAll)
       BUTTON('Cancel'),AT(184,52,48,14),USE(?Cancel)
     END

  CODE
  RTF &= ARTF + 0
  IF RTF &= NULL
    Props     &= NULL
    Selection &= NULL
    OwnerW    &= NULL
  ELSE
    Props     &= RTF.Properties()
    Selection &= Props.Selection()
    OwnerW    &= RTF.OwnerWindow()
  END

  IF  LEN (CLIP (Text)) <> 0
    SText = Text
  ELSIF NOT Selection &= NULL
    Selection.SelectedText (SText)
    
    IF SText[1] ='<0>'
      RTF.FindHistory (SText)
    END
  END
  IF NOT RTF.ReplaceHistory(RText) THEN
     RText = ''
  END
  OPEN (W, OwnerW)
  ACCEPT
    IF EVENT() = EVENT:ACCEPTED
      CASE ACCEPTED()
      OF ?Cancel
        POST (CHOOSE (NOT Found, EVENT:FindCancel, EVENT:FindOK),, OwnerW {PROP:Thread})
        POST (EVENT:CloseWindow)
      OF ?Replace
        IF NOT Found
           Flags = 0
           IF NOT Down
             Flags += FIND:Back
           END
           IF MatchCase
             Flags += FIND:MatchCase
           END
           IF WholeWord
             Flags += FIND:WholeWord
           END
           lPos = RTF.Find (SText, Flags)
           IF lPos = -1
             BEEP (BEEP:SystemExclamation)
             MESSAGE ('"' & SText & '" not found.', 'Search', ICON:Question, BUTTON:OK)
           ELSE
             Found = TRUE
           END
        END
        IF Found AND lPos > -1
           RTF.FindAndReplace (SText, RText, Flags+FIND:Again,lPos)
           DISPLAY
        END
        Found = False
      OF ?ReplaceAll
        Flags = FIND:ReplaceAll
        IF NOT Down
          Flags += FIND:Back
        END
        IF MatchCase
          Flags += FIND:MatchCase
        END
        IF WholeWord
          Flags += FIND:WholeWord
        END

        IF RTF.FindAndReplace (SText, RText, Flags) = -1
          BEEP (BEEP:SystemExclamation)
          MESSAGE ('"' & SText & '" not found.', 'Search', ICON:Question, BUTTON:OK)
        ELSE
          Found = TRUE
          DISPLAY
        END
      OF ?Find
        Flags = 0
        IF NOT Down
          Flags += FIND:Back
        END
        IF MatchCase
          Flags += FIND:MatchCase
        END
        IF WholeWord
          Flags += FIND:WholeWord
        END
        lPos = RTF.Find (SText, Flags)
        IF lPos=-1
          BEEP (BEEP:SystemExclamation)
          MESSAGE ('"' & SText & '" not found.', 'Search', ICON:Question, BUTTON:OK)
        ELSE
          Found = TRUE
          DISPLAY
        END
      END
    END
  END
  POST (EVENT:FindOK,, OwnerW {PROP:Thread})
  RETURN

! =============================================================================

RTFControlClass.RTFNotify.ChangeCallback PROCEDURE (LONG bitmap)
FontBitmap     LONG,AUTO
TextColor      LONG,AUTO
FIndex         LONG,AUTO
Bullets        BYTE,AUTO
  CODE

  SELF.CheckPasteButton()
  SELF.CheckUndoRedo()

  SELF.UpdateControls (RTFToolbar:CtlBullets, SELF.Props.BulletStyle())
  SELF.UpdateControls (RTFToolbar:CtlBulletStyle, SELF.Props.BulletStyle())
  SELF.UpdateControls (RTFToolbar:CtlAlignment, SELF.Props.Alignment())

  ! === Check changes in selection and caret position

  IF BAND (bitmap, CHANGE:Selection)
    SELF.Selection &= SELF.Props.Selection()

    IF CHOOSE (SELF.Selection.SelectionType() <> SELECT:Empty) <> SELF.CutCopyEnabled
      IF SELF.CutCopyEnabled
        IF SELF.CtlButtonCut
          DISABLE (SELF.CtlButtonCut)
        END
        IF SELF.CtlButtonCopy
          DISABLE (SELF.CtlButtonCopy)
        END
      ELSE
        IF SELF.CtlButtonCut
          ENABLE (SELF.CtlButtonCut)
        END
        IF SELF.CtlButtonCopy
          ENABLE (SELF.CtlButtonCopy)
        END
      END
      SELF.CutCopyEnabled = BXOR (SELF.CutCopyEnabled, 1)
    END

    SELF.RefreshLinePos()

    SELF.Selection.Snap()
  END

  ! === Check changes in the current font

  IF BAND (bitmap, CHANGE:Font)
     FontBitmap = SELF.CurrentFont.Changes()

     IF BAND (FontBitmap, CHANGEFONT:Name)
        SELF.CurrentFont.GetFont (SELF.FontName)
        SELF.UpdateControls(RTFToolbar:CtlFontName,SELF.FontName)
     END

    IF BAND (FontBitmap, CHANGEFONT:Size)
       SELF.UpdateControls(RTFToolbar:CtlFontSize,SELF.CurrentFont.FontSize())
    END

    IF BAND (FontBitmap, CHANGEFONT:Charset)
       SELF.UpdateControls(RTFToolbar:CtlFontScript,SELF.CurrentFont.FontScript())
    END

    IF BAND (FontBitmap, CHANGEFONT:Weight)
       SELF.UpdateControls(RTFToolbar:CtlBold,CHOOSE (SELF.CurrentFont.FontWeight() >= FONT:Bold))
    END

    IF BAND (FontBitmap, CHANGEFONT:Italic)
       SELF.UpdateControls(RTFToolbar:CtlItalic,SELF.CurrentFont.FontItalic())
    END

    IF BAND (FontBitmap, CHANGEFONT:Underline)
       SELF.UpdateControls(RTFToolbar:CtlUnderline,SELF.CurrentFont.FontUnderline())
    END

    IF BAND (FontBitmap, CHANGEFONT:Color)
       SELF.UpdateControls(RTFToolbar:CtlFontColor,SELF.CurrentFont.FontColor())
    END
    IF BAND (FontBitmap, CHANGEFONT:BackColor)
       SELF.UpdateControls(RTFToolbar:CtlFontBkColor,SELF.CurrentFont.FontBackColor())
    END
    
    SELF.CurrentFont.Snap()
  END

  ! === Update "modified" flag

  IF SELF.CtlShowDirty
     IF SELF.Props.Changed()
        SELF.CtlShowDirty {PROP:Text} = '*'
     ELSE
        SELF.CtlShowDirty {PROP:Text} = ''
     END
  END
  RETURN

RTFControlClass.GetText          PROCEDURE (*STRING textbuf, LONG min = 0, LONG max = -1)
  CODE
? ASSERT(NOT(SELF.RTF &= NULL),'The RTF control was not initialized')
  IF NOT SELF.RTF &= NULL
    RETURN SELF.RTF.GetText(textbuf, min, max)
  ELSE
    RETURN 0
  END

RTFControlClass.GetText          PROCEDURE (*CSTRING textbuf, LONG min = 0, LONG max = -1)
  CODE
? ASSERT(NOT(SELF.RTF &= NULL),'The RTF control was not initialized')
  IF NOT SELF.RTF &= NULL
    RETURN SELF.RTF.GetText(textbuf, min,max)
  ELSE
    RETURN 0
  END

RTFControlClass.SetText          PROCEDURE (STRING newtext)
  CODE
? ASSERT(NOT(SELF.RTF &= NULL),'The RTF control was not initialized')
  IF NOT SELF.RTF &= NULL
    SELF.RTF.SetText(newtext)
  END

RTFControlClass.SetText          PROCEDURE (CONST *CSTRING newtext)
  CODE
? ASSERT(NOT(SELF.RTF &= NULL),'The RTF control was not initialized')
  IF NOT SELF.RTF &= NULL
    SELF.RTF.SetText(newtext)
  END

RTFControlClass.SelectText       PROCEDURE (LONG min = 0, LONG max = -1)
  CODE
? ASSERT(NOT(SELF.RTF &= NULL),'The RTF control was not initialized')
  IF NOT SELF.RTF &= NULL
    SELF.RTF.SelectText(min,max)
  END

RTFControlClass.SetCaret         PROCEDURE (LONG pos)
  CODE
? ASSERT(NOT(SELF.RTF &= NULL),'The RTF control was not initialized')
  IF NOT SELF.RTF &= NULL
    SELF.RTF.SetCaret(pos)
  END
