!ABCIncludeFile

  OMIT('_EndOfInclude_',_WMFParser_)
_WMFParser_   EQUATE(1)

  INCLUDE('ABREPORT.INC'),ONCE
  INCLUDE('ABERROR.INC'),ONCE
  INCLUDE('ABRPTGEN.INT'),ONCE
  
WMFParser CLASS,TYPE,MODULE('ABWMFPAR.CLW'),LINK('ABWMFPAR.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Errors              &ErrorClass,PROTECTED
ReportGenerator     &IReportGenerator,PROTECTED
FileName            CSTRING(256),PROTECTED
FileOpen            BYTE,PRIVATE
CurrentObject       USHORT,PRIVATE
FirstSlice          BYTE,PRIVATE

InsideArc           BYTE,PRIVATE
InsideBox           BYTE,PRIVATE
InsideCheck         BYTE,PRIVATE
InsideChord         BYTE,PRIVATE
InsideEllipse       BYTE,PRIVATE
InsideImage         BYTE,PRIVATE
InsideLine          BYTE,PRIVATE
InsideGroup         BYTE,PRIVATE
InsidePie           BYTE,PRIVATE
InsidePolygon       BYTE,PRIVATE
InsideRadio         BYTE,PRIVATE
InsideString        BYTE,PRIVATE
InsideText          BYTE,PRIVATE

Pos                 LIKE(PosGrp),PRIVATE
Style               LIKE(StyleGrp),PRIVATE
ArcFormat           LIKE(ArcFormatGrp),PRIVATE
CheckFormat         LIKE(CheckFormatGrp),PRIVATE
EllipseFormat       LIKE(EllipseFormatGrp),PRIVATE
ImageFormat         LIKE(ImageFormatGrp),PRIVATE
LineFormat          LIKE(LineFormatGrp),PRIVATE
GroupFormat         LIKE(GroupFormatGrp),PRIVATE
RadioFormat         LIKE(RadioFormatGrp),PRIVATE
RectFormat          LIKE(RectFormatGrp),PRIVATE
StringFormat        LIKE(StringFormatGrp),PRIVATE

PointQ              &PointQueue,PRIVATE
SliceFormatQ        &SliceFormatQueue,PRIVATE
TextFormatQ         &TextFormatQueue,PRIVATE

DC                  &QueueDC,PRIVATE
Brush               &QueueBrush,PRIVATE
Fonts               &QueueFonts,PRIVATE
Pens                &QueuePens,PRIVATE
Objects             &QueueObjects,PRIVATE
Holes               &QueueHoles,PRIVATE

LineStartXPos       USHORT
LineStartYPos       USHORT

TempText            STRING(256)
TempTextLen         USHORT
Comment             STRING(MaxAttributeSize)
PreserveComment     STRING(MaxAttributeSize)

BoxLeft             SHORT
BoxTop              SHORT
BoxRight            SHORT
BoxBottom           SHORT
PixelsPerInch       USHORT(360)
ToInch              REAL
WMFFPos             LONG
WindowOriginX       SHORT
WindowOriginY       SHORT

CONSTRUCT           PROCEDURE()
DESTRUCT            PROCEDURE()

GetBoxLeft          PROCEDURE(),SHORT
GetBoxTop           PROCEDURE(),SHORT
GetBoxRight         PROCEDURE(),SHORT
GetBoxBottom        PROCEDURE(),SHORT

Init                PROCEDURE(STRING fname, IReportGenerator rptgen, ErrorClass EC)
Kill                PROCEDURE()
OpenFile            PROCEDURE(),BYTE
Run                 PROCEDURE(),BYTE
CloseFile           PROCEDURE(),BYTE,PROC

AddObject           PROCEDURE(BYTE),BYTE,PRIVATE
ProcessHeader       PROCEDURE(),BYTE,PROTECTED
ProcessFile         PROCEDURE(),BYTE,PROTECTED
TakeRecord          PROCEDURE(),BYTE,PROTECTED
  END
  
WMFDocumentParser CLASS,TYPE,MODULE('ABWMFPAR.CLW'),LINK('ABWMFPAR.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Errors              &ErrorClass,PROTECTED
ErrorsCreated       BYTE,PROTECTED
WMFQueue            &PreviewQueue,PROTECTED
Parser              &WMFParser,PROTECTED
ReportGenerator     &IReportGenerator,PROTECTED

GenerateReport      PROCEDURE(BYTE ShowProgress=TRUE),BYTE
Init                PROCEDURE(PreviewQueue WMFQueue, IReportGenerator rptgen, <ErrorClass EC>)

CloseDocument       PROCEDURE(),BYTE,PROTECTED
OpenDocument        PROCEDURE(),BYTE,PROTECTED
ProcessDocument     PROCEDURE(),BYTE,PROTECTED
Destructor          PROCEDURE
  END

 _EndOfInclude_


