EVENT:RTFReady      EQUATE( EVENT:User + 503 )

Bullets             ITEMIZE,PRE(Bullets)
On                    EQUATE(1)
Arabic                EQUATE
LowerLetters          EQUATE
UpperLetters          EQUATE
LowerRoman            EQUATE
UpperRoman            EQUATE
                    END

cwRTF               CLASS,TYPE,MODULE('cwRTF'),DLL(TRUE),THREAD
ErrorCode             LONG
Error                 STRING(128)
rWindow               &WINDOW
rContainer            &WINDOW

iTxtBox               SIGNED
hRTFLib               LONG
hRTFWindow            LONG
lPrevWndProc          LONG
lRTFWndProc           LONG
lTxtWndProc           LONG
ctrlGroup             SIGNED
ctrlRegion            SIGNED
ToolBox               SIGNED
FormatBox             SIGNED
ctrlTabsStart         SIGNED
bShowTabs             BYTE
sBuffer               STRING(4096)
rField                &STRING
sFileName             STRING(FILE:MaxFilePath+FILE:MaxFileName)
iTabSheet             SIGNED
bButtonState          BYTE
TBDockPos             BYTE
TBActive              BYTE
TBOffSet              SIGNED
TBThread              SIGNED
TBYPos                SIGNED
TBXPos                SIGNED
FBDockPos             BYTE
FBActive              BYTE
FBOffSet              SIGNED
FBThread              SIGNED
FBYPos                SIGNED
FBXPos                SIGNED
RTFXOffset            SIGNED
RTFYOffset            SIGNED
lRTFThread            LONG
bShowOnStart          BYTE
bCursorActive         BYTE
bShiftDown            BYTE
bCtrlDown             BYTE
Opened                BYTE
szFont                CSTRING(32)
lFontSize             LONG
lFontColor            ULONG
lFontBold             LONG
lFontItalic           LONG
lFontUnderline        LONG
lFontStrike           LONG
lParaFormat           LONG
bBullets              BYTE( FALSE )

Resize                PROCEDURE(),BYTE,PRIVATE
ChangeTabstop         PROCEDURE(),BYTE,PRIVATE
TabChange             PROCEDURE(),BYTE
RTFSelected           PROCEDURE(),BYTE,PRIVATE

Init                  PROCEDURE( Window hostWin, LONG TextBox, BYTE bRulerOn=TRUE, BYTE bToolBarOn=TRUE, BYTE bFormatBarOn=TRUE  )
Kill                  PROCEDURE( BYTE IsDirty=TRUE ), BOOL, PROC
ShowControl           PROCEDURE( BYTE ShowState )
LimitTextSize         PROCEDURE( LONG MaxTextSize )
ResizeControls        PROCEDURE()
NewFile               PROCEDURE()
LoadFile              PROCEDURE( STRING FileName )
LoadField             PROCEDURE( *STRING FieldName )
SaveFile              PROCEDURE( STRING FileName )
SaveField             PROCEDURE( *STRING FieldName )
_Print                PROCEDURE( BYTE ShowSetup=TRUE, <STRING sJobTitle> ),BYTE,PROC
PageSetup             PROCEDURE()
Font                  PROCEDURE(<STRING FontName>, <LONG FontSize>, <LONG FontColor>, <LONG FontStyle>)
Color                 PROCEDURE()
Copy                  PROCEDURE()
Cut                   PROCEDURE()
Paste                 PROCEDURE()
ChangeFontStyle       PROCEDURE( LONG FontStyle )
AlignParaLeft         PROCEDURE()
AlignParaRight        PROCEDURE()
AlignParaCenter       PROCEDURE()
ParaBulletsOn         PROCEDURE( BYTE bBulletStyle=1 )
ParaBulletsOff        PROCEDURE( )
LeftIndent            PROCEDURE( REAL Indent )
RightIndent           PROCEDURE( REAL Indent )
Offset                PROCEDURE( REAL Indent )
Undo                  PROCEDURE()
Redo                  PROCEDURE()
Find                  PROCEDURE( <STRING FindText> ),LONG, PROC
Replace               PROCEDURE( <STRING FindText>, <STRING ReplaceText> ), LONG, PROC
SetFocus              PROCEDURE()
CanUndo               PROCEDURE(),BYTE
CanRedo               PROCEDURE(),BYTE
IsDirty               PROCEDURE( BYTE bPromptSave=TRUE ), BYTE
SelectText            PROCEDURE( LONG lStartPos, LONG lEndPos )
GetText               PROCEDURE( *STRING sTxtBuffer, <LONG lStartPos>, <LONG lEndPos> ),LONG, PROC
SetText               PROCEDURE( STRING sTxtBuffer, BYTE bAllowUndo=FALSE, <LONG lStartPos>, <LONG lEndPos> )
FlatButtons           PROCEDURE( BYTE bButtonStatus )
SetDirtyFlag          PROCEDURE( BYTE bStatus )
                    END

