!ABCIncludeFile(ABC)

OMIT('_EndOfInclude_',_PDFClassPresente_)
_PDFClassPresente_ EQUATE(1)

INCLUDE('ABPRTARG.INC'),ONCE   ! TargetClass
INCLUDE('ABRPATMG.INC'),ONCE   ! Attr Manager
INCLUDE('ABRPTGEN.INT'),ONCE   ! IReportGenerator Interface
INCLUDE('ABERROR.INC'),ONCE

!PDF
QueueBookMark       QUEUE,TYPE
XPos                    SHORT
YPos                    SHORT
Name                    STRING(50)
ObjectNo                LONG
ParentObjectNo          LONG
Order                   LONG
First                   LONG
Last                    LONG
Count                   LONG
Dest                    LONG
Parent                  LONG
Level                   LONG
OrderByLevel            LONG
                    END
QueueImageObject    QUEUE,TYPE
ImageNo                 LONG
ObjectNo                LONG
FileName                STRING(255)
External                BYTE
Width                   LONG
Height                  LONG
ColorTableLen           SHORT! Only for GIF
ColorTableStart         SHORT! Only for GIF
StreemStart             SHORT
Bit_depth               BYTE
Color_type              BYTE
Type                    BYTE! 1-JPEG 2-GIF 3-PNG 4-BMP
                    END
QueueObjectLocation QUEUE,TYPE
ObjectNo                LONG
Position                LONG
                    END
QueuePageObject     QUEUE,TYPE
ObjectNo                LONG
Number                  LONG
                    END
QueueXObject        QUEUE,TYPE
PageNo                  LONG
XObjectNo               LONG
                    END
QueuePoint          QUEUE,TYPE
XPos                    LONG
YPos                    LONG
                    END
QueueFontsNames     QUEUE,TYPE
Name                    STRING(31)
RealName                STRING(31)
Style                   LONG
Number                  SHORT
BuiltIn                 BYTE
ObjectNo                LONG
FirstChar               BYTE
LastChar                BYTE
CharWidth               SHORT,DIM(255)
                    END
QueueHyperLinks     QUEUE,TYPE
XPos                    SHORT
YPos                    SHORT
Width                   SHORT
Height                  SHORT
Text                    STRING(500)
Dest                    STRING(5000)
Parameters              STRING(1048)! For Command type
ObjectNo                LONG
Boxed                   BYTE
BoxColor                LONG
Type                    BYTE !1-HyperLink 2-Commnad 3-Annotation 4-PageAction
                    END
PDFHLType:HyperLink     EQUATE(1)
PDFHLType:Command       EQUATE(2)
PDFHLType:Annotation    EQUATE(3)
PDFHLType:PageAction    EQUATE(4)

!For PageAction Link Type
!Dest can be:
!first
!prev
!next
!last
!back
!forward
!For command Link Type
!Dest can be:
!command space parameters
!command.com [ /C dir c:\\*.\* /s ]
!For Annotation
!Dest is the text in the Annotation

QueueContent        QUEUE,TYPE
ObjectNo                LONG
                    END
RGBColor            GROUP,TYPE
Red                     REAL
Green                   REAL
Blue                    REAL
                    END

PDFGeneratorClass    CLASS,MODULE('ABPRPDF.CLW'),TYPE,LINK('ABPRPDF.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Output               &TargetGenerator
Title                STRING(50),PROTECTED
AppName              STRING(50),PROTECTED
ProgName             STRING(50),PROTECTED
Subject              STRING(200),PROTECTED
Author               STRING(200),PROTECTED
Keywords             STRING(200),PROTECTED
PageNo               SHORT(0),PROTECTED
TotalPageNo          SHORT(0),PROTECTED
CurObj               LONG(5),PROTECTED ! object number being or last written */
LastContent          LONG(0),PROTECTED
DC                   UNSIGNED(0),PROTECTED
PageObs              &QueuePageObject,PROTECTED!Store the Page Object Number and the Resource Object than equal to the Page Object + 1
Locations            &QueueObjectLocation,PROTECTED
XObject              &QueueXObject,PROTECTED
Images               &QueueImageObject,PROTECTED
PageHyperLinks       &QueueHyperLinks,PROTECTED
Contents             &QueueContent,PROTECTED
BookMarks            &QueueBookMark,PROTECTED
PolyPoint            &QueuePoint,PROTECTED
ImageNo              LONG,PROTECTED
FontsNames           &QueueFontsNames,PROTECTED
FontsNum             SHORT,PROTECTED
FontColor            LIKE(RGBColor)
FillColor            LIKE(RGBColor)
PolygonColor         LONG,PROTECTED !Clarion Color
PolygonPenColor      LONG,PROTECTED !Clarion Color
PolygonPenWidth      LONG,PROTECTED
PolygonPenStyle      LONG,PROTECTED
PenColor             LIKE(RGBColor)
PenWidth             LONG
PenStyle             LONG
ActualFontNumber     SHORT(1),PROTECTED
PointSize            SHORT(10),PROTECTED
ObjPenColor          LONG(0),PROTECTED  !Store the object where the Pen Color was used last time
ObjPenWidth          LONG(0),PROTECTED  !Store the object where the Pen Width was used last time
ObjPenStyle          LONG(0),PROTECTED  !Store the object where the Pen Style was used last time
ObjFontNumber        LONG(0),PROTECTED
ObjFontSize          LONG(0),PROTECTED
ObjFontColor         LONG(0),PROTECTED
ObjFillColor         LONG(0),PROTECTED
ISOEnc               SHORT(0)
FontAngle            SHORT(0),PROTECTED
PageHeight           SHORT(792),PROTECTED
PageWidth            SHORT(612),PROTECTED
PageType             SHORT(PAPER:LETTER),PROTECTED
PageLandscape        BYTE(0),PROTECTED
StreamStart          LONG(0),PROTECTED
InText               BYTE(0),PROTECTED
InCliping            BYTE(0),PROTECTED
InImage              BYTE(0),PROTECTED
InPolygon            BYTE(0),PROTECTED
LastXPos             LONG(0),PROTECTED
LastYPos             LONG(0),PROTECTED
ClipXPos             LONG(0),PROTECTED
ClipYPos             LONG(0),PROTECTED
ClipWidth            LONG(0),PROTECTED
ClipHeight           LONG(0),PROTECTED
HyperLinkBoxed       BYTE(0),PROTECTED
HyperLinkBoxColor    LONG(COLOR:Red),PROTECTED
PagesAsParentBookmark BYTE
BasePageBookmarkName STRING(15)
ppScapedString       &STRING,PRIVATE
!!!!!!!!!!!!!
Init                 PROCEDURE(<STRING TargetFileName>),VIRTUAL
SetDocumentInfo      PROCEDURE(STRING pTitle,STRING pAppName,STRING pProgName,STRING pSubject,STRING pAuthor,STRING pKeywords)
SetPageLandscape     PROCEDURE()
SetPagePortrait      PROCEDURE()
SetPageSize          PROCEDURE(LONG Width,LONG Height)
SetPageSize          PROCEDURE(),PROTECTED! To use with the Paper type
SetPageType          PROCEDURE(SHORT pPageType,LONG pWidth=0,LONG pHeight=0)
SetFileName          PROCEDURE(STRING pFileName)
SetPagesAsParentBookmark PROCEDURE(BYTE pTrue)
SetBasePageBookmarkName PROCEDURE(STRING pBaseName)
SetUp                PROCEDURE(),VIRTUAL
OpenDocument         PROCEDURE()
CloseDocument        PROCEDURE()
StartPage            PROCEDURE()
EndPage              PROCEDURE()
DrawText             PROCEDURE(LONG XPos,LONG YPos,STRING pText,LONG ClipXPos=0 ,LONG ClipYPos=0,LONG ClipWidth=0 ,LONG ClipHeight=0)
DrawSetTextAngle     PROCEDURE(SHORT FontAngle)
DrawSetFontByNumber  PROCEDURE(BYTE pFontNumber),PROTECTED
DrawSetFont          PROCEDURE(STRING pFontName,BYTE pFontSize=0,BYTE pBold=0,BYTE pItalic=0)
GetFontTranslation   PROCEDURE(STRING pFontName,BYTE pBold=0,BYTE pItalic=0),STRING,PROTECTED
DrawSetFontSize      PROCEDURE(BYTE pFontSize)
DrawLine             PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height)
DrawBox              PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height,LONG Fill=-1)
CalculateCubicBezier PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height,REAL StartAngle,REAL EndAngle,*LONG X,*LONG Y,*LONG X0,*LONG Y0,*LONG X1,*LONG Y1,*LONG X2,*LONG Y2,*LONG X3,*LONG Y3),PRIVATE
DrawArc              PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height,REAL StartAngle,REAL EndAngle)
DrawPieSlice         PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height,REAL StartAngle,REAL EndAngle,LONG Fill=-1)
DrawEllipse          PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height,LONG Fill=-1)
DrawPolygon          PROCEDURE(LONG Fill=-1,LONG PenColor=0,LONG PenWidth=1,LONG PenStyle=0)
DrawPolygonCorner    PROCEDURE(LONG XPos,LONG YPos)
DrawPolygonClose     PROCEDURE()
DrawSetFontColor     PROCEDURE(LONG pClarionColor)
DrawSetPenColor      PROCEDURE(LONG pClarionColor)
DrawSetFillColor     PROCEDURE(LONG pClarionColor)
DrawSetPenStyle      PROCEDURE(LONG pClarionStyle=0)
DrawSetPenWidth      PROCEDURE(LONG pWidth)
DrawSetColor         PROCEDURE(REAL pRed,REAL pGreen,REAL pBlue,STRING pType)
DrawImage            PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height,STRING FileName)
DrawHyperLink        PROCEDURE(LONG XPos,LONG YPos,LONG Width=0,LONG Height=0,STRING HyperLink,<STRING pText>)
DrawAnnotation       PROCEDURE(LONG XPos,LONG YPos,STRING AnnotationText)
DrawCommand          PROCEDURE(LONG XPos,LONG YPos,LONG Width=0,LONG Height=0,STRING pText,STRING pCommand,STRING pParameters)
DrawPageAction       PROCEDURE(LONG XPos,LONG YPos,LONG Width=0,LONG Height=0,STRING pText,STRING pAction)
DrawRegionLink       PROCEDURE(LONG XPos,LONG YPos,LONG Width,LONG Height,BYTE pType,STRING pDest,<STRING pPar>)
DrawImageLink        PROCEDURE(LONG XPos,LONG YPos,LONG Width,LONG Height,STRING pImage,BYTE pType,STRING pDest,<STRING pPar>)
EscapeValues         PROCEDURE(STRING pValue),STRING,PRIVATE
SetHyperLinkBoxed    PROCEDURE(BYTE pValue)
SetHyperLinkBoxColor PROCEDURE(LONG pColor)
AddBookMark          PROCEDURE(LONG XPos,LONG YPos,STRING BookMarkName,<STRING BookMarkParent>)
AddBookMark          PROCEDURE(STRING BookMarkName,<STRING BookMarkParent>)
OpenText             PROCEDURE(BYTE pDoSeting=1),PROTECTED
OpenText             PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height),PROTECTED !Open text with a cliping region
CloseText            PROCEDURE(),PROTECTED
OpenImage            PROCEDURE(BYTE pDoSeting=1),PROTECTED
CloseImage           PROCEDURE(),PROTECTED
OpenContent          PROCEDURE(),PROTECTED
CloseContent         PROCEDURE(),PROTECTED
AddFonts             PROCEDURE(),PROTECTED
AddFont              PROCEDURE(SHORT pFontNumber),PROTECTED
AddFontDescriptor    PROCEDURE(SHORT pFontNumber),BYTE,PROTECTED
AddImages            PROCEDURE(),PROTECTED
AddPageHyperLinks    PROCEDURE(),PROTECTED
AddAllBookMark       PROCEDURE(),PROTECTED
GenerateRGB          PROCEDURE(LONG pClarionColor,*REAL pRed,*REAL pGreen,*REAL pBlue),PROTECTED
WriteFileLZWStream   PROCEDURE(STRING pFileName,LONG pStart=1),LONG,PROC,PROTECTED!IF the file can be streamed it return the stream size
WriteFilePNGPLTE     PROCEDURE(STRING pFileName),PROTECTED
WriteFilePNGiDat     PROCEDURE(STRING pFileName),LONG,PROTECTED
GetImageInfo         PROCEDURE(*QueueImageObject pImage),PROTECTED
GetTextWidth         PROCEDURE(STRING pText),LONG,PROTECTED
Construct            PROCEDURE()
Destruct             PROCEDURE()
               END

PDFReportGenerator    CLASS(PDFGeneratorClass),IMPLEMENTS(IReportGenerator),MODULE('ABPRPDF.CLW'),TYPE,LINK('ABPRPDF.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Attribute               &ReportAttributeManager,PROTECTED
OutputFileQueue         &OutputFileQueue,PROTECTED
CONSTRUCT               PROCEDURE()
DESTRUCT                PROCEDURE()
ProcessHiddenControlSize PROCEDURE(*PosGrp pPosition,STRING pAttribute),PROC,PRIVATE !If the control was hidden in runtime it replace the width and height with the real
ProcessHyperlink        PROCEDURE(PosGrp pPosition, STRING Text, STRING pAttribute),BYTE,PROC,PRIVATE !Return true if it was processed
ProcessBookMark         PROCEDURE(PosGrp pPosition, STRING Text, STRING pAttribute),BYTE,PROC,PRIVATE !Return true if it was processed
                      END

_EndOfInclude_
