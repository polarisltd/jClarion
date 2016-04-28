!ABCIncludeFile

  OMIT('_EndOfInclude_',_RTFClassPresent_)
_RTFClassPresent_   EQUATE(1)

   INCLUDE('RTF.INT'),ONCE
   INCLUDE('ABERROR.INC'),ONCE

  ITEMIZE,PRE(RTFToolbar)
CtlShowFileName         EQUATE
CtlShowLineNo           EQUATE
CtlShowPosInLine        EQUATE
CtlShowDirty            EQUATE

CtlButtonNew            EQUATE
CtlButtonOpen           EQUATE
CtlButtonSave           EQUATE
CtlButtonPrint          EQUATE
CtlButtonFind           EQUATE
CtlButtonFindAndReplace EQUATE
CtlButtonCut            EQUATE
CtlButtonCopy           EQUATE
CtlButtonPaste          EQUATE
CtlButtonUndo           EQUATE
CtlButtonRedo           EQUATE
CtlButtonTabs           EQUATE
CtlButtonPara           EQUATE

CtlAlignment            EQUATE
CtlAlignmentJust        EQUATE
CtlBullets              EQUATE
CtlBulletStyle          EQUATE
CtlFontName             EQUATE
CtlFontSize             EQUATE
CtlFontScript           EQUATE
CtlBold                 EQUATE
CtlItalic               EQUATE
CtlUnderline            EQUATE
CtlFontColor            EQUATE
CtlFontBkColor          EQUATE
                 END
!IMPLEMENTS(WindowComponent),
RTFControlClass     CLASS,IMPLEMENTS(RTFNotify),TYPE,MODULE('RTFCTL.CLW'),LINK('RTFCTL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
UndoAction              UNDONAMEID,PROTECTED

Fonts                   &FontList,PROTECTED
Scripts                 &FontScriptList,PROTECTED
Props                   &RTFProperty
RTF                     &RTFHandler,PROTECTED
DefaultFont             &RTFFont,PROTECTED
CurrentFont             &RTFFont,PROTECTED
Selection               &RTFSelection,PROTECTED
HScroller               &RTFScrollBar,PROTECTED
VScroller               &RTFScrollBar,PROTECTED

Alignment               BYTE,PROTECTED
Bold                    BOOLEAN,PROTECTED
Italic                  BOOLEAN,PROTECTED
Underline               BOOLEAN,PROTECTED
Bullets                 BOOLEAN,PROTECTED
BulletStyle             BYTE,PROTECTED

FontName                CSTRING(32),PROTECTED
FontSize                SIGNED,PROTECTED
FontScript              BYTE,PROTECTED
FontColor               LONG,PROTECTED
FontStyle               LONG,PROTECTED
FontWeight              LONG,PROTECTED
FontBkColor             LONG,PROTECTED

CutCopyEnabled          BOOLEAN,PROTECTED
PasteEnabled            BOOLEAN,PROTECTED
UndoEnabled             BOOLEAN,PROTECTED
RedoEnabled             BOOLEAN,PROTECTED
FileName                CSTRING(FILE:MaxFileName),PROTECTED
X                       SIGNED,PROTECTED
Y                       SIGNED,PROTECTED
W                       SIGNED,PROTECTED
H                       SIGNED,PROTECTED
Err                     LONG,PROTECTED
DocumentTitle           STRING(50)
RTFFromFile             BYTE,PROTECTED

CtlRTF                  SIGNED,PROTECTED
CtlShowFileName         SIGNED,PROTECTED
CtlShowLineNo           SIGNED,PROTECTED
CtlShowPosInLine        SIGNED,PROTECTED
CtlShowDirty            SIGNED,PROTECTED

CtlButtonNew            SIGNED,PROTECTED
CtlButtonOpen           SIGNED,PROTECTED
CtlButtonSave           SIGNED,PROTECTED
CtlButtonPrint          SIGNED,PROTECTED
CtlButtonFind           SIGNED,PROTECTED
CtlButtonFindAndReplace SIGNED,PROTECTED
CtlButtonCut            SIGNED,PROTECTED
CtlButtonCopy           SIGNED,PROTECTED
CtlButtonPaste          SIGNED,PROTECTED
CtlButtonUndo           SIGNED,PROTECTED
CtlButtonRedo           SIGNED,PROTECTED
CtlButtonTabs           SIGNED,PROTECTED
CtlButtonPara           SIGNED,PROTECTED

CtlAlignment            SIGNED,PROTECTED
CtlAlignmentJust        SIGNED,PROTECTED
CtlBullets              SIGNED,PROTECTED
CtlBulletStyle          SIGNED,PROTECTED
CtlFontName             SIGNED,PROTECTED
CtlFontSize             SIGNED,PROTECTED
CtlFontScript           SIGNED,PROTECTED
CtlBold                 SIGNED,PROTECTED
CtlItalic               SIGNED,PROTECTED
CtlUnderline            SIGNED,PROTECTED
CtlFontColor            SIGNED,PROTECTED
CtlFontBkColor          SIGNED,PROTECTED

Construct               PROCEDURE
Destruct                PROCEDURE
Init                    PROCEDURE(SIGNED pRTFControl,<STRING pDefaultFileName>),VIRTUAL
Kill                    PROCEDURE(),VIRTUAL
AddItem                 PROCEDURE(BYTE pRTFControlEquate,SIGNED pRTFToolbarControl)
TakeAccepted            PROCEDURE,VIRTUAL,BYTE,PROC
TakeAction              PROCEDURE(BYTE pRTFControlEquate,<STRING pRTFControlValue>),VIRTUAL,BYTE,PROC
TakeEvent               PROCEDURE,VIRTUAL,BYTE,PROC
CheckUndoRedo           PROCEDURE,VIRTUAL
CheckPasteButton        PROCEDURE,VIRTUAL
GetRTFFromFile          PROCEDURE(),BYTE
Load                    PROCEDURE (<CONST *CSTRING filename>)
Save                    PROCEDURE (<CONST *CSTRING filename>, UNSIGNED mode = TEXT:Default)
SaveAs                  PROCEDURE (UNSIGNED mode = TEXT:Default)
IndentDlg               PROCEDURE(),VIRTUAL
TabDlg                  PROCEDURE(BYTE Unit),VIRTUAL
FindDlg                 PROCEDURE(<STRING Text>),BOOLEAN,PROC,VIRTUAL
FindAndReplaceDlg       PROCEDURE(<STRING Text>),BOOLEAN,PROC,VIRTUAL
FindAndReplace          PROCEDURE(STRING SearchText,STRING ReplaceText,ULONG flags=FIND:WholeWord) !flags=FIND:MatchCase FIND:WholeWord
Printdocument           PROCEDURE(<STRING Text>,BYTE Silent=0),BYTE,PROC,VIRTUAL
Resize                  PROCEDURE(),VIRTUAL
LoadFonts               PROCEDURE(),VIRTUAL
RefreshFileName         PROCEDURE(),VIRTUAL
RefreshLinePos          PROCEDURE(),VIRTUAL
ShowCtlGroup            PROCEDURE(BYTE pShowIt=1),VIRTUAL
ShowInfoGroup           PROCEDURE(BYTE pShowIt=1),VIRTUAL
ToTwips                 PROCEDURE(LONG V, BYTE Unit),LONG,PRIVATE
FromTwips               PROCEDURE(LONG V, BYTE Unit),LONG,PRIVATE
ReloadScripts           PROCEDURE(),PRIVATE
BindControls            PROCEDURE(),VIRTUAL
UpdateControls          PROCEDURE(BYTE pRTFControlEquate,STRING pValue),VIRTUAL
SelectedText            PROCEDURE(*CSTRING pText),VIRTUAL
SetFocus                PROCEDURE (),VIRTUAL
PrintRTF                PROCEDURE (<STRING jobname>, BYTE device = TARGET:Printer),LONG,PROC,VIRTUAL
Changed                 PROCEDURE (),BYTE,VIRTUAL
Touch                   PROCEDURE (BYTE onoff),VIRTUAL
GetText                 PROCEDURE (*STRING textbuf, LONG min = 0, LONG max = -1),LONG,PROC
GetText                 PROCEDURE (*CSTRING textbuf, LONG min = 0, LONG max = -1),LONG,PROC
SetText                 PROCEDURE (STRING newtext)
SetText                 PROCEDURE (CONST *CSTRING newtext)
SelectText              PROCEDURE (LONG min = 0, LONG max = -1)
SetCaret                PROCEDURE (LONG pos)
                    END
  _EndOfInclude_

