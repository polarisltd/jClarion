   MEMBER                                 ! This is a MEMBER module


   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABLPROPR.INC'),ONCE
   INCLUDE('ABLWINR.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ablwman.inc'),ONCE
   INCLUDE('abwindow.inc'),ONCE
   INCLUDE('wbframe.inc'),once
   include('wbserver.inc'),once
   include('wbstd.equ'),once
   include('layhtml.int'),once


NavOff          EQUATE(70)
TA_LEFT         EQUATE(0)
TA_RIGHT        EQUATE(2)
TA_CENTER       EQUATE(6)
TA_TOP          EQUATE(0)
TA_BOTTOM       EQUATE(8)
LOGPIXELSX      EQUATE(88)  ! Logical pixelsinch in X
LOGPIXELSY      EQUATE(90)  ! Logical pixelsinch in Y

                    MAP
                      MODULE('WBPreview.CLW')
WebPreview              PROCEDURE(WbServerClass WebServer,PreviewQueue qReportPages,STRING sWindowTitle,BYTE bShowPageNo,BYTE bShowTotalPages)
CvtGetItem              PROCEDURE(*CvtLayoutCellClass, SIGNED),*CvtItemClass
CvtMapFontSize          PROCEDURE(SIGNED PointSize),SIGNED
CvtColorHex             PROCEDURE(ULONG),STRING
CvtColorText            PROCEDURE(ULONG),STRING
CvtRGB                  PROCEDURE(LONG),LONG
CvtHex                  PROCEDURE(ULONG),STRING
                      END
                      MODULE('Windows')
                        GetSysColor(SIGNED),LONG,PASCAL,NAME('GetSysColor')
                        GetDC (UNSIGNED hWnd),UNSIGNED,RAW,PASCAL,DLL(TRUE)
                        GetDeviceCaps(UNSIGNED, SIGNED), SIGNED, PASCAL
                      END
                    END

CvtFontClass        CLASS,TYPE
Color                  LONG
Face                   STRING(50)               ! Not CSTRING to compare is ok
Size                   SIGNED
Style                  SIGNED
                     END

CvtOptionGroup      GROUP,TYPE
ScaleX                 REAL
ScaleY                 REAL
                     END

CvtHtmlClass         CLASS,TYPE
GetPixelsX             PROCEDURE(SIGNED),SIGNED
GetPixelsY             PROCEDURE(SIGNED),SIGNED
WriteFontFooter        PROCEDURE(*CvtFontClass CurFont)
WriteFontHeader        PROCEDURE(*CvtFontClass CurFont)
Option                 LIKE(CvtOptionGroup)
OutPut                 &IHtmlWriter
                     END

ColumnQueue          QUEUE,TYPE
Cell                   &CvtLayoutCellClass
                     END

RowQueue             QUEUE,TYPE
Columns                &ColumnQueue
                     END

RangeQueue           QUEUE,TYPE
MaxExtent              SIGNED
Maximum                SIGNED
Minimum                SIGNED
                     END

CellQueue            QUEUE,TYPE
Item                   &CvtItemClass
                     END

CvtLayoutCellClass      CLASS,TYPE
GetCellAttributes      PROCEDURE,STRING
Init                   PROCEDURE
Kill                   PROCEDURE

dx                     SIGNED(0)
dy                     SIGNED(0)
SpanX                  SIGNED(1)
SpanY                  SIGNED(1)
Skip                   BYTE(FALSE)
Contents               &CellQueue
                     END

RangeClass           CLASS,TYPE
AddPoint               PROCEDURE(SIGNED Offset, SIGNED extent, *BYTE IsNew, SIGNED Delta),SIGNED
Init                   PROCEDURE
Kill                   PROCEDURE

Bounds                 &RangeQueue
                     END


LayoutCvtHtmlClass   CLASS,TYPE
AddCell                PROCEDURE(SIGNED), PRIVATE
AddColumn              PROCEDURE(SIGNED), PRIVATE
AddRow                 PROCEDURE(SIGNED), PRIVATE
CreateHtml             PROCEDURE(*CvtHtmlClass)
Init                   PROCEDURE(STRING Style, SIGNED SnapX, SIGNED SnapY)
Insert                 PROCEDURE(*CvtItemClass item)
Kill                   PROCEDURE
Optimize               PROCEDURE,PRIVATE
SetCell                PROCEDURE(SIGNED Xpos, SIGNED Ypos),*CvtLayoutCellClass,PROC

SnapX                  SIGNED
SnapY                  SIGNED
ExpandWhitespace       BYTE
Rows                   &RowQueue,PRIVATE
RangeX                 &RangeClass,PRIVATE
RangeY                 &RangeClass,PRIVATE
Style                  CSTRING(100)
                     END

CvtItemClass        CLASS,TYPE
CreateHtml             PROCEDURE(*CvtHtmlClass),VIRTUAL
GetCellAttributes      PROCEDURE(*CvtHtmlClass),STRING,VIRTUAL
GetPosition            PROCEDURE(*SIGNED x, *SIGNED y, *SIGNED w, *SIGNED h),VIRTUAL

FileName               CSTRING(FILE:MaxFilePath)
Bottom                 BYTE(0)
Top                    BYTE(0)
Center                 BYTE(0)
Left                   BYTE(0)
Right                  BYTE(0)
                     END

CvtReportItemClass   CLASS(CvtItemClass),TYPE
GetPosition            PROCEDURE(*SIGNED, *SIGNED, *SIGNED, *SIGNED),VIRTUAL

X                      SIGNED
Y                      SIGNED
Width                  SIGNED
Height                 SIGNED
                     END

CvtReportStringClass    CLASS(CvtReportItemClass),TYPE
CreateHtml             PROCEDURE(*CvtHtmlClass),VIRTUAL
Init                   PROCEDURE(STRING,CvtFontClass)
Kill                   PROCEDURE,VIRTUAL

Font                   &CvtFontClass
Text                   ANY
                     END

TxtAlign             GROUP,PRE(TxtAlign)
Bottom                 BYTE(0)
Top                    BYTE(0)
Center                 BYTE(0)
Left                   BYTE(0)
Right                  BYTE(0)
                     END

CvtReportImageClass     CLASS(CvtReportItemClass),TYPE
CreateHtml             PROCEDURE(*CvtHtmlClass),VIRTUAL
Init                   PROCEDURE(STRING)

                     END

CvtReportItemQueue      QUEUE,TYPE
CurItem                &CvtReportItemClass
                     END
  ITEMIZE,PRE(META)
ABORTDOC            EQUATE(0052H)
ANIMATEPALETTE      EQUATE(0436H)
ARC                 EQUATE(0817H)
BITBLT              EQUATE(0922H)
CHORD               EQUATE(0830H)
CREATEBITMAP        EQUATE(06FEH)
CREATEBITMAPINDIRECT EQUATE(02FDH)
CREATEBRUSH         EQUATE(00F8H)
CREATEBRUSHINDIRECT EQUATE(02FCH)
CREATEFONTINDIRECT  EQUATE(02FBH)
CREATEPALETTE       EQUATE(00f7H)
CREATEPATTERNBRUSH  EQUATE(01F9H)
CREATEPENINDIRECT   EQUATE(02FAH)
CREATEREGION        EQUATE(06FFH)
DELETEOBJECT        EQUATE(01f0H)
DIBBITBLT           EQUATE(0940H)
DIBCREATEPATTERNBRUSH EQUATE(0142H)
DIBSTRETCHBLT       EQUATE(0b41H)
DRAWTEXT            EQUATE(062FH)
ELLIPSE             EQUATE(0418H)
ENDDOC              EQUATE(005EH)
ENDPAGE             EQUATE(0050H)
ESCAPE              EQUATE(0626H)
EXCLUDECLIPRECT     EQUATE(0415H)
EXTFLOODFILL        EQUATE(0548H)
EXTTEXTOUT          EQUATE(0a32H)
FILLREGION          EQUATE(0228H)
FLOODFILL           EQUATE(0419H)
FRAMEREGION         EQUATE(0429H)
INTERSECTCLIPRECT   EQUATE(0416H)
INVERTREGION        EQUATE(012AH)
LINETO              EQUATE(0213H)
MOVETO              EQUATE(0214H)
OFFSETCLIPRGN       EQUATE(0220H)
OFFSETVIEWPORTORG   EQUATE(0211H)
OFFSETWINDOWORG     EQUATE(020FH)
PAINTREGION         EQUATE(012BH)
PATBLT              EQUATE(061DH)
PIE                 EQUATE(081AH)
POLYGON             EQUATE(0324H)
POLYLINE            EQUATE(0325H)
POLYPOLYGON         EQUATE(0538H)
REALIZEPALETTE      EQUATE(0035H)
RECTANGLE           EQUATE(041BH)
RESETDC             EQUATE(014CH)
RESIZEPALETTE       EQUATE(0139H)
RESTOREDC           EQUATE(0127H)
ROUNDRECT           EQUATE(061CH)
SAVEDC              EQUATE(001EH)
SCALEVIEWPORTEXT    EQUATE(0412H)
SCALEWINDOWEXT      EQUATE(0410H)
SELECTCLIPREGION    EQUATE(012CH)
SELECTOBJECT        EQUATE(012DH)
SELECTPALETTE       EQUATE(0234H)
SETBKCOLOR          EQUATE(0201H)
SETBKMODE           EQUATE(0102H)
SETDIBTODEV         EQUATE(0d33H)
SETMAPMODE          EQUATE(0103H)
SETMAPPERFLAGS      EQUATE(0231H)
SETPALENTRIES       EQUATE(0037H)
SETPIXEL            EQUATE(041FH)
SETPOLYFILLMODE     EQUATE(0106H)
SETRELABS           EQUATE(0105H)
SETROP2             EQUATE(0104H)
SETSTRETCHBLTMODE   EQUATE(0107H)
SETTEXTALIGN        EQUATE(012EH)
SETTEXTCHAREXTRA    EQUATE(0108H)
SETTEXTCOLOR        EQUATE(0209H)
SETTEXTJUSTIFICATION EQUATE(020AH)
SETVIEWPORTEXT      EQUATE(020EH)
SETVIEWPORTORG      EQUATE(020DH)
SETWINDOWEXT        EQUATE(020CH)
SETWINDOWORG        EQUATE(020BH)
STARTDOC            EQUATE(014DH)
STARTPAGE           EQUATE(004FH)
STRETCHBLT          EQUATE(0B23H)
STRETCHDIB          EQUATE(0f43H)
TEXTOUT             EQUATE(0521H)
                  END

CvtWebPageClass      CLASS,TYPE
AddControl             PROCEDURE(CvtReportItemClass)
CreateHtml             PROCEDURE(*CvtHtmlClass),VIRTUAL
GetCellAttributes      PROCEDURE(*CvtHtmlClass),STRING,VIRTUAL
Init                   PROCEDURE()
Kill                   PROCEDURE,VIRTUAL
!Translate             PROCEDURE(string infile,CvtHtmlClass outstream) !,string repfile,CvtHtmlClass)
Translate                  PROCEDURE(string infilename,CvtHtmlClass outstream)

Q                      &QUEUE,PROTECTED
CurPage                SIGNED
ItemQ                  &CvtReportItemQueue
                     END


WebPreview PROCEDURE (WbServerClass WebServer,PreviewQueue qReportPages,STRING sReportTitle,BYTE bShowPageNo,BYTE bShowTotalPages) !Generated from procedure template - Window

Loc:Zoom             SHORT
Window WINDOW('Report Preview'),AT(,,394,283),FONT('MS Sans Serif',8,,FONT:regular),SYSTEM,GRAY,RESIZE, |
         MDI
       PANEL,AT(2,1,390,21),USE(?Panel1),BEVEL(-1)
       BUTTON,AT(5,4,23,14),USE(?First),FLAT,MSG('First Page'),TIP('First Page'),ICON('VCRFIRST.GIF')
       BUTTON,AT(34,4,29,14),USE(?Previous),FLAT,MSG('Previous Page'),TIP('Previous Page'),ICON('VCRUP.GIF')
       BUTTON,AT(69,4,29,14),USE(?Next),FLAT,MSG('Next Page'),TIP('Next Page'),ICON('VCRDOWN.GIF')
       BUTTON,AT(104,4,29,14),USE(?Last),FLAT,MSG('Last Page'),TIP('Last Page'),ICON('VCRLAST.GIF')
       BUTTON,AT(358,4,29,14),USE(?Close),FLAT,ICON('EXITS.GIF')
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
                     
WebWindowProperty    CLASS(WbWindowHtmlProperties)
qPages                 &PreviewQueue
GetEmbedText           PROCEDURE(ASTRING embed),STRING,DERIVED
                     END

DummyLong           LONG

  CODE
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
  IF RECORDS( qReportPages ) = 0
    RETURN Level:Fatal
  END
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= DummyLong
  SELF.Errors &= NEW ErrorClass !GlobalErrors
  SELF.AddItem(Toolbar)
  SELF.AddItem(?Close,RequestCancelled)
  OPEN(Window)
  SELF.Opened=True
  WebWindowProperty.qPages &= qReportPages
  GET(qReportPages,1)
  DO SetWindowTitle
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
      DO SetWindowTitle
    OF ?Previous
      ThisWindow.Update
      IF POINTER(qReportPages) > 1
        GET(qReportPages,POINTER(qReportPages)-1)
        DO SetWindowTitle
      END
    OF ?Next
      ThisWindow.Update
      IF POINTER(qReportPages) < RECORDS(qReportPages)
        GET(qReportPages,POINTER(qReportPages)+1)
        DO SetWindowTitle
      END
    OF ?Last
      ThisWindow.Update
      GET(qReportPages,RECORDS(qReportPages))
      DO SetWindowTitle
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

WebWindow.Init PROCEDURE

  CODE
  PARENT.Init
  SELF.SetFormatOptions(2, 2, 6, 13)
  WebWindowProperty.Init()
  SELF.AddControl(WebWindowProperty.IControlToHtml)
  IF (WebServer.IsEnabled())
    Web:CurFrame &= GetWebActiveFrame()
    Web:CurFrame.CopyControlsToWindow(TRUE, TRUE)
  END

WebWindowProperty.GetEmbedText PROCEDURE(ASTRING embed)

ReturnValue          ANY
Target                  &IHtmlWriter,AUTO
Cvt                     &CvtWebPageClass
HtmlClass               &CvtHtmlClass

  CODE
  Target &= IHtmlWriter:Create()
  CASE embed
  OF A:EmbedBeforeHeadClose
    Target.Writeln('<<!-- Javascript Print Report function -->')
    Target.Writeln('<<script language="JavaScript">')
    Target.Writeln('<<!--')
    Target.Writeln('function window.onbeforeprint() {{')
    Target.Writeln('  NavControls.style.display=''none'';')
    Target.WriteLn('  for (c = 0; c << ReportPage.children.length; c++) {{')
    Target.WriteLn('    var cnode = ReportPage.children.item( c );')
    Target.WriteLn('    cnode.style.pixelTop = cnode.style.pixelTop - ' & NavOff * 1.5 & ';')
    Target.WriteLn('    cnode.style.pixelLeft = cnode.style.pixelLeft - 40;')
    Target.WriteLn('  }')
    Target.WriteLn('}')

    Target.Writeln('function window.onafterprint() {{')
    Target.Writeln('  NavControls.style.display=''none'';')
    Target.WriteLn('  for (c = 0; c << ReportPage.children.length; c++) {{')
    Target.WriteLn('    var cnode = ReportPage.children.item( c );')
    Target.WriteLn('    cnode.style.pixelTop = cnode.style.pixelTop + ' & NavOff * 1.5 & ';')
    Target.WriteLn('    cnode.style.pixelLeft = cnode.style.pixelLeft + 40;')
    Target.WriteLn('  }')
    Target.Writeln('  NavControls.style.display="";')
    Target.WriteLn('}')

    Target.Writeln('//-->')
    Target.Writeln('<</SCRIPT>')
  OF A:EmbedBeforeWindow
    Target.WriteLn('<<SPAN id="NavControls">')
  OF A:EmbedAfterWindow
    Target.WriteLn('<</SPAN>')
    IF RECORDS( WebWindowProperty.qPages) <> 0
      Cvt &= NEW CvtWebPageClass
      Cvt.Init()
      HtmlClass &= NEW CvtHtmlClass
      HtmlClass.OutPut &= Target
      Target.WriteLn('<<DIV ID="ReportPage" style="position:absolute, top:0; left:0">')
      Cvt.Translate( SELF.qPages.Filename, HtmlClass )
      Target.WriteLn('<</DIV>')
      HtmlClass.OutPut &= NULL
      DISPOSE( HtmlClass )
      Cvt.Kill()
      DISPOSE( Cvt )
    END
  END
  ReturnValue = PARENT.GetEmbedText(embed)
  ReturnValue = Target.GetText()
  Target.Release()
  RETURN ReturnValue

!---------------------------------------------------------------------
! Procedure to translate from a .wmf file to a .htm file
!---------------------------------------------------------------------

CvtWebPageClass.AddControl             PROCEDURE(CvtReportItemClass NewItem)
  CODE
  SELF.ItemQ.CurItem &= NewItem
  ADD(SELF.ItemQ)


CvtWebPageClass.CreateHtml             PROCEDURE(*CvtHtmlClass Target)
wmfstring            cstring(255),auto
  CODE
  GET(SELF.Q,SELF.CurPage)
  wmfstring = CLIP(SELF.Q)
  ASSERT(INSTRING('.',wmfstring,1,1))

CvtWebPageClass.GetCellAttributes PROCEDURE(*CvtHtmlClass H)
  CODE
  RETURN ' BGCOLOR=White'


CvtWebPageClass.Init      PROCEDURE() !SIGNED Feq,  QUEUE Q) !WebWindowClass Owner,
  CODE
  SELF.ItemQ &= NEW CvtReportItemQueue

CvtWebPageClass.Kill      PROCEDURE
  CODE
  DISPOSE(SELF.ItemQ)


!CvtWebPageClass.Translate PROCEDURE(infilename,outstream) !,repfile,outstream)
CvtWebPageClass.Translate PROCEDURE(string infilename,CvtHtmlClass outstream)

IName                STRING(255),AUTO,STATIC
InFile               FILE,DRIVER('DOS'),NAME(IName)
                     RECORD
Buffer                 STRING(5000)
                     ..

METAFILEHEADER       GROUP,OVER(InFile.Buffer)
key                    LONG
hmf                    USHORT
bbox:left              SHORT
bbox:top               SHORT
bbox:right             SHORT
bbox:bottom            SHORT
inch                   USHORT
reserved               LONG
checksum               USHORT
                     END

METAHEADER           GROUP,OVER(InFile.Buffer)
Type                   USHORT
HeaderSize             USHORT
Version                USHORT
Size                   LONG
NoObjects              USHORT
MaxRecord              LONG
NoParameters           USHORT
                     END

METARECORD           GROUP,OVER(InFile.Buffer)
Size                   LONG
Funct                  USHORT
Params                 USHORT,DIM(1000)
                     END

TxtPos              BYTE,DIM(10),OVER(MetaRecord.Params)

PixelsPerInch        USHORT(360)

FontsSeen            QUEUE
Id                     USHORT
Font                   &CvtFontClass
                     END

Holes                QUEUE
Id                     USHORT
                     END

CurrentObject        USHORT
MaxObject            USHORT
CurPos               LONG(1)
Layout               LayoutCvtHtmlClass
I                    USHORT,AUTO
XPos                 USHORT,AUTO
Ypos                 USHORT,AUTO
Width                USHORT,AUTO
Height               USHORT,AUTO
SavedOptions         LIKE(CvtOptionGroup)
ScreenPixelPerInchX  SIGNED(72)
ScreenPixelPerInchY  SIGNED(72)
gLineStart           GROUP
x                      LONG
y                      LONG
                     END
ControlDC            UNSIGNED

  CODE
  IName = infilename
  OPEN(InFile)
  ASSERT(~ERRORCODE())
  GET(InFile,1,SIZE(METAFILEHEADER))
  IF MetaFileHeader.Key = 9ac6cdd7H THEN
    DO OutMetaFileHeader
    CurPos += SIZE(METAFILEHEADER)
  END
  GET(InFile,CurPos,SIZE(METAHEADER))
  ASSERT(~ERRORCODE())
  CurPos += SIZE(MetaHeader)

  ControlDC = GetDC(0)
  ScreenPixelPerInchX = GetDeviceCaps(ControlDC, LOGPIXELSX)
  ScreenPixelPerInchY = GetDeviceCaps(ControlDC, LOGPIXELSY)

  OutStream.Option.ScaleX = ScreenPixelPerInchX / PixelsPerInch
  OutStream.Option.ScaleY = ScreenPixelPerInchY / PixelsPerInch

  Layout.Init('',10,10)
  LOOP
    GET(InFile,CurPos,6)
    IF ERRORCODE() OR ~MetaRecord.Size THEN
      BREAK
    END
    GET(InFile,CurPos,MetaRecord.Size*2)
    CurPos += MetaRecord.Size*2
    DO OutRecord
  END
  CLOSE(InFile)
  Layout.CreateHtml(OutStream)
  Layout.Kill

  LOOP I = 1 TO RECORDS(FontsSeen)
    GET(FontsSeen,I)
    DISPOSE(FontsSeen.Font)
  END

  LOOP I = 1 TO RECORDS(SELF.ItemQ)
    GET(SELF.ItemQ,I)
    DISPOSE(SELF.ItemQ.CurItem)
  END
  FREE(SELF.ItemQ)


OutMetaFileHeader ROUTINE
  PixelsPerInch = MetaFileHeader.Inch

OutRecord ROUTINE
  DATA
TextStart            USHORT,AUTO
TextLen              USHORT,AUTO
I                    USHORT
Via                  CSTRING(255)
Filename             CSTRING(FILE:MaxFilePath)
ViaSign              SHORT
StringClass          &CvtReportStringClass
ImageClass           &CvtReportImageClass
GlobalFiles          &WbFilesClass,AUTO
  CODE
  CASE MetaRecord.Funct
  OMIT('!-RecordTypesNotHandled-!')
  OF META:SETBKCOLOR
  OF META:SETBKMODE
  OF META:SETMAPMODE
  OF META:SETROP2
  OF META:SETRELABS
  OF META:SETPOLYFILLMODE
  OF META:SETSTRETCHBLTMODE
  OF META:SETTEXTCHAREXTRA
  OF META:SETTEXTCOLOR
  OF META:SETTEXTJUSTIFICATION
  OF META:SETWINDOWORG
  OF META:SETWINDOWEXT
  OF META:SETVIEWPORTORG
  OF META:SETVIEWPORTEXT
  OF META:OFFSETWINDOWORG
  OF META:SCALEWINDOWEXT
  OF META:OFFSETVIEWPORTORG
  OF META:SCALEVIEWPORTEXT
  OF META:EXCLUDECLIPRECT
  OF META:INTERSECTCLIPRECT
  OF META:ARC
  OF META:ELLIPSE
  OF META:FLOODFILL
  OF META:PIE
  OF META:RECTANGLE
  OF META:ROUNDRECT
  OF META:PATBLT
  OF META:SAVEDC
  OF META:SETPIXEL
  OF META:OFFSETCLIPRGN
  OF META:TEXTOUT
  OF META:BITBLT
  OF META:STRETCHBLT
  OF META:POLYGON
  OF META:POLYLINE
  OF META:RESTOREDC
  OF META:FILLREGION
  OF META:FRAMEREGION
  OF META:INVERTREGION
  OF META:PAINTREGION
  OF META:SELECTCLIPREGION
  OF META:DRAWTEXT
  OF META:CHORD
  OF META:SETMAPPERFLAGS
  OF META:SETDIBTODEV
  OF META:SELECTPALETTE
  OF META:REALIZEPALETTE
  OF META:ANIMATEPALETTE
  OF META:SETPALENTRIES
  OF META:POLYPOLYGON
  OF META:RESIZEPALETTE
  OF META:DIBBITBLT
  OF META:DIBSTRETCHBLT
  OF META:DIBCREATEPATTERNBRUSH
    DO NextObject
  OF META:STRETCHDIB
  OF META:EXTFLOODFILL
  OF META:RESETDC
  OF META:STARTDOC
  OF META:STARTPAGE
  OF META:ENDPAGE
  OF META:ABORTDOC
  OF META:ENDDOC
  !-RecordTypesNotHandled-!
  OF META:LINETO
    IF gLineStart.x <> 0 AND gLineStart.y <> 0
      GlobalFiles &= WbFilesClass::Get()
      XPos = gLineStart.x
      YPos = gLineStart.y
      IF MetaRecord.Params[2] > gLineStart.x
        Width = MetaRecord.Params[2] - gLineStart.x
      ELSE
        Width = gLineStart.x - MetaRecord.Params[2]
      END
      IF MetaRecord.Params[1] > gLineStart.y
        Height = MetaRecord.Params[1] - gLineStart.y
      ELSE
        Height = gLineStart.y - MetaRecord.Params[1]
      END
      IF MetaRecord.Params[2] < XPos
        XPos = MetaRecord.Params[2]
      END
      IF MetaRecord.Params[1] < YPos
        YPos = MetaRecord.Params[1]
      END
      Filename = GlobalFiles.GetAlias('DOT.GIF')
      ImageClass &= NEW CvtReportImageClass
      ImageClass.Init(Filename)
      ImageClass.X = XPos
      ImageClass.Y = YPos
      ImageClass.Width = Width
      ImageClass.Height = Height
      Layout.Insert(ImageClass)
      SELF.AddControl(ImageClass)
      GlobalFiles &= NULL
      gLineStart.x = MetaRecord.Params[2]
      gLineStart.y = MetaRecord.Params[1]
    END
  OF META:MOVETO
    CLEAR( gLineStart )
    gLineStart.x = MetaRecord.Params[2]
    gLineStart.y = MetaRecord.Params[1]
  OF META:ESCAPE
    IF MetaRecord.Params[3] = 1319 AND MetaRecord.Params[4] = 9 THEN
      GlobalFiles &= WbFilesClass::Get()
      XPos = MetaRecord.Params[6]
      YPos = MetaRecord.Params[5]
      Width = MetaRecord.Params[8]-MetaRecord.Params[6]
      Height = MetaRecord.Params[7]-MetaRecord.Params[5]
      Filename = CLIP(InFile.Buffer[7+9*2:MetaRecord.Size*2])
      Filename = GlobalFiles.GetAlias(Filename)
      ImageClass &= NEW CvtReportImageClass
      ImageClass.Init(Filename)
      ImageClass.X = XPos
      ImageClass.Y = YPos
      ImageClass.Width = Width
      ImageClass.Height = Height
      Layout.Insert(ImageClass)
      SELF.AddControl(ImageClass)
      GlobalFiles &= NULL
    END
  OF META:CREATEPALETTE
    DO NextObject
  OF META:CREATEBRUSH
    DO NextObject
  OF META:CREATEPATTERNBRUSH
    DO NextObject
  OF META:CREATEPENINDIRECT
    DO NextObject
  OF META:CREATEBRUSHINDIRECT
    DO NextObject
  OF META:CREATEBITMAPINDIRECT
    DO NextObject
  OF META:CREATEBITMAP
    DO NextObject
  OF META:CREATEREGION
    DO NextObject
  OF META:SELECTOBJECT
    FontsSeen.Id = MetaRecord.Params[1]
    GET(FontsSeen,FontsSeen.Id)
  OF META:SETTEXTALIGN
  OF META:EXTTEXTOUT
    TextStart = 15
    TextLen = MetaRecord.Params[3]
    IF MetaRecord.Params[4] THEN
      TextStart += 8
      XPos = MetaRecord.Params[5]
      YPos = MetaRecord.Params[6]
      Width = MetaRecord.Params[7]-MetaRecord.Params[5]
      Height = MetaRecord.Params[8]-MetaRecord.Params[6]
    ELSE
      XPos = MetaRecord.Params[2]
      YPos = MetaRecord.Params[1]
      Width = (MetaRecord.Size*2-TextStart) * 12
      Height = 25
    END
    IF TextLen > 0 AND MetaRecord.Size * 2 >= TextStart
      StringClass &= NEW CvtReportStringClass
      IF LEN( CLIP(LEFT( InFile.Buffer[TextStart : TextStart + TextLen - 1] )) ) < LEN( CLIP( InFile.Buffer[TextStart : TextStart + TextLen - 1] ) )
        StringClass.Right = TRUE
      ELSE
        IF XPos < MetaRecord.Params[2]
          XPos = MetaRecord.Params[2]
        END
!        YPos = MetaRecord.Params[1]
      END
      StringClass.Init(InFile.Buffer[TextStart : TextStart + TextLen - 1],FontsSeen.Font)
      StringClass.X = XPos
      StringClass.Y = YPos
      StringClass.Width = Width
      StringClass.Height = Height
      SELF.AddControl(StringClass)
      Layout.Insert(StringClass)
    ELSE
    END
  OF META:DELETEOBJECT
    Holes.Id = MetaRecord.Params[1]
    ADD(Holes,Holes.Id)
    FontsSeen.Id = MetaRecord.Params[1]
    GET(FontsSeen,FontsSeen.Id)
    IF ~ERRORCODE() THEN
      DISPOSE(FontsSeen.Font)
      DELETE(FontsSeen)
    END
  OF META:CREATEFONTINDIRECT
    DO NextObject
    ViaSign = MetaRecord.Params[1]
    CLEAR(FontsSeen)
    FontsSeen.Font &= NEW CvtFontClass
    FontsSeen.Font.Size = INT(ABS(ViaSign) * 72 / PixelsPerInch)
    FontsSeen.Font.Style = BAND(MetaRecord.Params[5],FONT:Weight)
    FontsSeen.Id = CurrentObject
    IF BAND( MetaRecord.Params[6], 255 ) THEN
      FontsSeen.Font.Style += FONT:Italic
    END
    IF BSHIFT( MetaRecord.Params[6], -8 ) THEN
      FontsSeen.Font.Style += FONT:Underline
    END
    IF BAND( MetaRecord.Params[7], 255 ) THEN
      FontsSeen.Font.Style += FONT:StrikeOut
    END
    TextStart = 6 + 9 * 2 + 1
    ASSERT( MetaRecord.Size * 2 > TextStart )
    Via = Infile.Buffer[TextStart : MetaRecord.Size * 2]
    FontsSeen.Font.Face = Via
    ADD(FontsSeen,FontsSeen.Id)
  END

NextObject ROUTINE
  IF RECORDS(Holes) THEN
    GET(Holes,1)
    CurrentObject = Holes.Id
    DELETE(Holes)
  ELSE
    CurrentObject = MaxObject
    MaxObject += 1
  END


LayoutCvtHtmlClass.AddCell        PROCEDURE(SIGNED Before)

NewCell         &CvtLayoutCellClass,AUTO

  CODE
  NewCell &= NEW CvtLayoutCellClass
  Self.Rows.Columns.Cell &= NewCell
  NewCell.Init
  ADD(Self.Rows.Columns, Before)

LayoutCvtHtmlClass.AddRow         PROCEDURE(SIGNED Before)

Xpos            SIGNED,AUTO

  CODE
  Self.Rows.Columns &= NEW ColumnQueue
  ADD(Self.Rows, Before)

  ! Initialise the columns in this row...
  LOOP Xpos = 1 TO RECORDS(SELF.RangeX.Bounds)
    SELF.AddCell(Xpos)
  END

LayoutCvtHtmlClass.AddColumn      PROCEDURE(SIGNED Before)

Ypos            SIGNED,AUTO

  CODE
  ! Add a cell to each row to create the new column
  LOOP Ypos = 1 TO RECORDS(SELF.RangeY.Bounds)
    GET(Self.Rows, YPos)
    SELF.AddCell(Before)
  END

LayoutCvtHtmlClass.CreateHtml      PROCEDURE(*CvtHtmlClass Target)

CurCell         &CvtLayoutCellClass,AUTO
CurItem         &CvtItemClass,AUTO
Index           SIGNED,AUTO
NumItems        SIGNED,AUTO
NumRows         SIGNED,AUTO
Style           ANY
Xindex          SIGNED,AUTO
Yindex          SIGNED,AUTO
xpos            SIGNED,AUTO
ypos            SIGNED,AUTO
width           SIGNED,AUTO
height          SIGNED,AUTO
OutString       STRING(2048)


  CODE

  SELF.Optimize
  NumRows = RECORDS(SELF.Rows);
  IF (NumRows > 0)
    LOOP Yindex = 1 TO NumRows
      GET(SELF.Rows, Yindex)
      LOOP Xindex = 1 TO RECORDS(SELF.Rows.Columns)
        GET(SELF.Rows.Columns, Xindex)
        CurCell &= SELF.Rows.Columns.Cell
        IF (NOT CurCell.Skip)
          NumItems = RECORDS(CurCell.Contents)
          IF (NumItems = 1)
            CurItem &= CurCell.CvtGetItem(1)
            CurItem.GetPosition( xpos, ypos, width, height )
            IF INSTRING('DOT.GIF',CurItem.FileName,1,1) > 0
              IF width = 0
                width = 4
                !xpos -= 2
              END
              IF height = 0
                height = 4
                ypos -= 15/Target.Option.ScaleY
              END
            END
            OutString = '<<SPAN STYLE="position:absolute; top:' & clip( Target.GetPixelsX(ypos)+NavOff ) & 'px; left:' & clip( Target.GetPixelsY(xpos) ) & |
                           'px' 
            IF CurItem.Right
              OutString = CLIP( OutString ) & '; width:' & clip( Target.GetPixelsX(width) ) & 'px; height:' & clip( Target.GetPixelsY(height) ) & 'px; text-align: right'
            END
            OutString = CLIP( OutString ) & '">'
            Target.Output.Writeln(OutString)
            CurItem.CreateHtml(Target)
            Target.Output.WriteLn('<</SPAN>')
          ELSE
            LOOP Index = 1 TO NumItems
              CurItem &= CurCell.CvtGetItem(Index)
              CurItem.GetPosition( xpos, ypos, width, height )
              IF INSTRING('DOT.GIF',CurItem.FileName,1,1) > 0
                IF width = 0
                  width = 4
                END
                IF height = 0
                  height = 4
                  ypos -= 15/Target.Option.ScaleY
                END
              END
              OutString = '<<SPAN STYLE="position:absolute; top:' & clip( Target.GetPixelsX(ypos)+NavOff ) & 'px; left:' & clip( Target.GetPixelsY(xpos) ) & |
                           'px'
              IF CurItem.Right
                OutString = CLIP( OutString ) & '; width:' & clip( Target.GetPixelsX(width) ) & 'px; height:' & clip( Target.GetPixelsY(height) ) & 'px; text-align: right'
              END
              OutString = CLIP( OutString ) & '">'
              Target.Output.Writeln(OutString)

              Style = CurItem.GetCellAttributes(Target)
              IF (Style)
                Target.OutPut.Write('<<P ' & Style & '>')
              END
              CurItem.CreateHtml(Target)
              IF (Style)
                Target.OutPut.Write('<</P>')
              END
              Target.Output.WriteLn('<</SPAN>')
            END
          END
        END
      END
    END
  END


LayoutCvtHtmlClass.Init              PROCEDURE(STRING Style, SIGNED SnapX, SIGNED SnapY)

  CODE
  IF (Style)
     SELF.Style = ' ' & Style
  ELSE
     SELF.Style = ''
  END

  SELF.Rows &= NEW RowQueue
  SELF.RangeX &= NEW RangeClass
  SELF.RangeX.Bounds &= NEW RangeQueue
  SELF.RangeY &= NEW RangeClass
  SELF.RangeY.Bounds &= NEW RangeQueue

  SELF.SnapX = SnapX
  SELF.SnapY = SnapY
  SELF.ExpandWhitespace = FALSE


LayoutCvtHtmlClass.Insert            PROCEDURE(*CvtItemClass NewItem)

CurCell         &CvtLayoutCellClass,AUTO
dx              SIGNED,AUTO
dy              SIGNED,AUTO
x               SIGNED,AUTO
y               SIGNED,AUTO
Xpos            SIGNED,AUTO
Ypos            SIGNED,AUTO
IsNew           BYTE,AUTO

  CODE

  NewItem.GetPosition(x, y, dx, dy)
  Ypos = SELF.RangeY.AddPoint(y, dy, IsNew, SELF.SnapY)
  IF (IsNew)
    SELF.AddRow(Ypos)
  END

  Xpos = SELF.RangeX.AddPoint(x, dx, IsNew, SELF.SnapX)
  IF (IsNew)
    SELF.AddColumn(Xpos)
  END

  CurCell &= SELF.SetCell(Xpos, Ypos)
  CurCell.Contents.Item &= NewItem
  ADD(CurCell.Contents)

  IF (dx > CurCell.dx)
     CurCell.dx = dx;
  END
  IF (dy > CurCell.dy)
     CurCell.dy = dy;
  END


LayoutCvtHtmlClass.Kill              PROCEDURE

CurCell         &CvtLayoutCellClass,AUTO
CurItem         SIGNED,AUTO
Xpos            SIGNED,AUTO
Ypos            SIGNED,AUTO

  CODE

  IF (~SELF.Rows &= NULL)
    ASSERT(~SELF.RangeX.Bounds &= NULL)
    ASSERT(~SELF.RangeY.Bounds &= NULL)
    LOOP Ypos = 1 TO RECORDS(SELF.RangeY.Bounds)
      LOOP Xpos = 1 TO RECORDS(SELF.RangeX.Bounds)
        CurCell &= SELF.SetCell(Xpos, Ypos)
        CurCell.Kill
        DISPOSE(CurCell)
      END
      DISPOSE(Self.Rows.Columns)
    END
    DISPOSE(SELF.Rows)
    SELF.RangeX.Kill
    DISPOSE(SELF.RangeX)
    SELF.RangeY.Kill
    DISPOSE(SELF.RangeY)
  END


LayoutCvtHtmlClass.SetCell          PROCEDURE(SIGNED Xpos, SIGNED Ypos)

  CODE
  GET(SELF.Rows, Ypos)
  GET(SELF.Rows.Columns, Xpos)
  RETURN SELF.Rows.Columns.Cell


LayoutCvtHtmlClass.Optimize          PROCEDURE

CurCell         &CvtLayoutCellClass,AUTO
NextCell        &CvtLayoutCellClass,AUTO
LastCell        &CvtLayoutCellClass,AUTO

Xpos            SIGNED,AUTO
Ypos            SIGNED,AUTO
NextCol         SIGNED,AUTO
NextRow         SIGNED,AUTO
MaxX            SIGNED,AUTO
MaxY            SIGNED,AUTO
Span            SIGNED,AUTO
NumRangeX       SIGNED,AUTO
NumRangeY       SIGNED,AUTO

  CODE

  NumRangeX = RECORDS(SELF.RangeX.Bounds)
  NumRangeY = RECORDS(SELF.RangeY.Bounds)

  ! First expand cells horizontally, so that items fill multiple cell entries
  ! until we reach a control that overlaps us, or the column represents a
  ! position beyond the right hand of the control.
  LOOP Ypos = 1 TO NumRangeY
    Xpos = 1
    LOOP WHILE (Xpos < NumRangeX)
      CurCell &= SELF.SetCell(Xpos, Ypos)
      IF (RECORDS(CurCell.Contents) > 0)
        NextCol = Xpos + 1
        GET(SELF.RangeX.Bounds, Xpos)
        MaxX = SELF.RangeX.Bounds.Minimum + CurCell.dx
        LOOP WHILE (NextCol <= NumRangeX)
          GET(SELF.RangeX.Bounds, NextCol)
          IF (MaxX <= SELF.RangeX.Bounds.Minimum)
            BREAK
          END
          NextCell &= SELF.SetCell(NextCol, Ypos)
          IF (RECORDS(NextCell.Contents) <> 0)
            BREAK
          END
          NextCell.Skip = TRUE
          CurCell.SpanX += 1
          NextCol += 1
        END
        Xpos = NextCol
      ELSE
        Xpos += 1
      END
    END
  END

  ! Now expand the cells vertically.  Same as above, except the cells can
  ! take up more than one column.
  LOOP Xpos = 1 TO NumRangeX
    LOOP Ypos = 1 TO NumRangeY - 1
      CurCell &= SELF.SetCell(Xpos, Ypos)
      IF (RECORDS(CurCell.Contents) > 0)
        NextRow = Ypos + 1
        GET(SELF.RangeY.Bounds, Ypos)
        MaxY = SELF.RangeY.Bounds.Minimum + CurCell.dy
        LOOP WHILE (NextRow <= NumRangeY)
          GET(SELF.RangeY.Bounds, NextRow)
          IF (MaxY <= SELF.RangeY.Bounds.Minimum)
            BREAK
          END
          LOOP NextCol = Xpos TO Xpos + CurCell.SpanX - 1
            NextCell &= SELF.SetCell(NextCol, NextRow)
            IF (NextCell.Skip OR (RECORDS(NextCell.Contents) <> 0))
              GOTO Done
            END
          END
          LOOP NextCol = Xpos TO Xpos + CurCell.SpanX - 1
            NextCell &= SELF.SetCell(NextCol, NextRow)
            NextCell.Skip = TRUE
          END
          CurCell.SpanY += 1
          NextRow += 1
        END
      END
Done
    END
  END


  ! Optimize spaces within the grid.
  LOOP Ypos = 1 TO NumRangeY
    Xpos = 1
    LOOP WHILE Xpos < NumRangeX
      CurCell &= SELF.SetCell(Xpos, Ypos)
      Xpos += 1
      IF (NOT CurCell.Skip AND RECORDS(CurCell.Contents) = 0)
        LOOP WHILE Xpos <= NumRangeX
          NextCell &= SELF.SetCell(Xpos, Ypos)
          IF (NextCell.Skip OR RECORDS(NextCell.Contents) <> 0)
            BREAK
          END
          NextCell.Skip = TRUE
          CurCell.SpanX += 1
          Xpos += 1
        END
      END
    END
  END

CvtReportImageClass.Init PROCEDURE(STRING S)
  CODE
  SELF.FileName = S

CvtReportImageClass.CreateHtml PROCEDURE(*CvtHtmlClass H)
lw  LONG
lh  LONG
  CODE
  IF INSTRING('DOT.GIF',SELF.FileName,1,1) > 0
    lw = H.GetPixelsX( SELF.Width )
    lh = H.GetPixelsY( SELF.Height )
    IF lw < 1
      lw = 1
    END
    IF lh < 1
      lh = 1
    END
    H.Output.Write('<<IMG')
    H.Output.Write(' SRC="' & SELF.FileName &'"')
    H.Output.Write(' WIDTH=' & lw)
    H.Output.Write(' HEIGHT=' & lh)
    H.Output.Writeln('>')
  ELSE
    H.Output.Write('<<IMG')
    H.Output.Write(' SRC="' & SELF.FileName &'"')
    H.Output.Write(' WIDTH=' & H.GetPixelsX(SELF.Width))
    H.Output.Write(' HEIGHT=' & H.GetPixelsY(SELF.Height))
    H.Output.Writeln('>')
  END

CvtReportItemClass.GetPosition PROCEDURE(*SIGNED X, *SIGNED Y, *SIGNED Width, *SIGNED Height)
  CODE
  X = SELF.X
  Y = SELF.Y
  Width = SELF.Width
  Height = SELF.Height


CvtReportStringClass.CreateHtml PROCEDURE(*CvtHtmlClass H)
  CODE
  H.WriteFontHeader(SELF.Font)
  H.Output.Writeln(SELF.Text)
  H.WriteFontFooter(SELF.Font)

CvtReportStringClass.Init  PROCEDURE(STRING Text,CvtFontClass F)
  CODE
  SELF.Text = CLIP(Text)
  SELF.Font &= NEW CvtFontClass
  SELF.Font = F

CvtReportStringClass.Kill PROCEDURE
  CODE
  DISPOSE(SELF.Font)

CvtItemClass.CreateHtml      PROCEDURE(*CvtHtmlClass Target)

  CODE


CvtItemClass.GetCellAttributes       PROCEDURE(*CvtHtmlClass Target)

  CODE
  RETURN ''


CvtItemClass.GetPosition       PROCEDURE(*SIGNED x, *SIGNED y, *SIGNED w, *SIGNED h)

  CODE
  ASSERT(FALSE)

RangeClass.AddPoint  PROCEDURE(SIGNED Offset, SIGNED extent, *BYTE IsNew, SIGNED Delta)

AddIndex             SIGNED,AUTO
MaxBound             SIGNED,AUTO

  CODE
  MaxBound = RECORDS(SELF.Bounds)
  AddIndex = 1
  LOOP WHILE (AddIndex <= MaxBound)
    GET(SELF.Bounds, AddIndex)
    IF (Offset < SELF.Bounds.Maximum-2*Delta)
      BREAK
    END
    IF (Offset <= SELF.Bounds.Minimum+2*Delta)
      IF (Offset < SELF.Bounds.Minimum)
        SELF.Bounds.Minimum = Offset
      END
      IF (Offset > SELF.Bounds.Maximum)
        SELF.Bounds.Maximum = Offset
      END
      IF (Offset + extent > SELF.Bounds.MaxExtent)
        SELF.Bounds.MaxExtent = Offset + extent
      END
      PUT(SELF.Bounds)
      IsNew = FALSE
      RETURN AddIndex
    END
    AddIndex += 1
  END
  IsNew = TRUE
  SELF.Bounds.Minimum = Offset
  SELF.Bounds.Maximum = Offset
  SELF.Bounds.MaxExtent = Offset + extent
  ADD(SELF.Bounds, AddIndex)
  RETURN AddIndex


RangeClass.Init   PROCEDURE
  CODE
  SELF.Bounds &= NEW RangeQueue


RangeClass.Kill   PROCEDURE
  CODE
  DISPOSE (SELF.Bounds)

CvtLayoutCellClass.GetCellAttributes PROCEDURE

Style           PSTRING(100)

  CODE
  IF (SELF.SpanX > 1)
    Style = Style & ' COLSPAN=' & SELF.SpanX
  END
  IF (SELF.SpanY > 1)
    Style = Style & ' ROWSPAN=' & SELF.SpanY
  END
  RETURN Style


CvtLayoutCellClass.Init          PROCEDURE
  CODE
  SELF.SpanX = 1
  SELF.SpanY = 1
  SELF.Contents &= NEW CellQueue


CvtLayoutCellClass.Kill          PROCEDURE
  CODE
  DISPOSE (SELF.Contents)

CvtHtmlClass.WriteFontHeader PROCEDURE(*CvtFontClass CurFont)

  CODE
  SELF.Output.Write('<<FONT')
  IF (CurFont.Face)
    SELF.Output.Write(' FACE="' & CLIP(CurFont.Face) & '"')
  END
  IF (CurFont.Size)
    SELF.Output.Write(' SIZE=' & CvtMapFontSize(CurFont.Size))
  END
  IF (CurFont.Color <> COLOR:None) AND (CurFont.Color <> COLOR:Black)
    SELF.Output.Write(' COLOR="' & CvtColorText(CurFont.Color) & '"')
  END
  SELF.Output.Write('>')
  IF (BAND(CurFont.Style, FONT:Weight) >= FONT:bold)
    SELF.Output.Write('<<B>')
  END
  IF (BAND(CurFont.Style, FONT:Italic))
    SELF.Output.Write('<<I>')
  END


CvtHtmlClass.WriteFontFooter PROCEDURE(*CvtFontClass CurFont)

  CODE
  IF (BAND(CurFont.Style, FONT:Italic))
    SELF.Output.Write('<</I>')
  END
  IF (BAND(CurFont.Style, FONT:Weight) >= FONT:bold)
    SELF.Output.Write('<</B>')
  END
  SELF.Output.Write('<</FONT>')

CvtHtmlClass.GetPixelsX             PROCEDURE(SIGNED dlg)

  CODE
  RETURN INT(dlg * SELF.Option.ScaleX + SELF.Option.ScaleX/2)

CvtHtmlClass.GetPixelsY             PROCEDURE(SIGNED dlg)

  CODE
  RETURN INT(dlg * SELF.Option.ScaleY + SELF.Option.ScaleY/2)

CvtGetItem         PROCEDURE(*CvtLayoutCellClass CurCell, SIGNED Index)
  CODE
  GET(CurCell.Contents, Index)
  RETURN CurCell.Contents.Item

CvtMapFontSize     PROCEDURE(SIGNED PointSize)

MAX_SIZE                EQUATE(7)
SizeGroup               GROUP
Size1                     SIGNED(8)
Size2                     SIGNED(10)
Size3                     SIGNED(12)
Size4                     SIGNED(14)
Size5                     SIGNED(18)
Size6                     SIGNED(24)
Size7                     SIGNED(36)
                        END
Sizes                   SIGNED,DIM(MAX_SIZE),OVER(SizeGroup)
Size                    SIGNED

  CODE

  LOOP Size = 1 TO MAX_SIZE-1
    IF (PointSize < (Sizes[Size] + Sizes[Size+1])/2)
      RETURN Size
    END
  END
  RETURN MAX_SIZE

CvtColorHex             PROCEDURE(ULONG color)

  CODE
  color = CvtRGB(color)
  color = BAND(color, 0FFH) * 010000H + BAND(color, 0FF00H) + BAND(color, 0FF0000H) / 010000H
  RETURN CvtHex(color)


CvtColorText            PROCEDURE(ULONG color)

HexLen          SIGNED,AUTO
HexText         PSTRING(10),AUTO

  CODE
  color = CvtRGB(color)
  CASE color
  OF 0
    RETURN 'Black'
  OF 0FFFFFFH
    RETURN 'White'
  END
  HexText = CvtColorHex(color)
  HexLen = LEN(HexText)

  RETURN '#' & SUB('00000' & HexText, HexLen, 6)

CvtRGB                  PROCEDURE(LONG color)

SystemMask              EQUATE(080000000H)
SysColorMask            EQUATE(00000FFFFH)

  CODE
  IF (BAND(color, SystemMask))
    RETURN GetSysColor(BAND(color, SysColorMask))
  END
  RETURN color

CvtHex                  PROCEDURE(ULONG value)

MaxLength       EQUATE(20)
Digit           BYTE
Text            STRING(MaxLength)
Index           SIGNED(MaxLength)

  CODE
  IF (value = 0)
    RETURN '0'
  END
  LOOP WHILE (value)
    Digit = Value % 16
    Value = Value / 16
    IF (Digit < 10)
      Digit = VAL('0') + Digit
    ELSE
      Digit = VAL('A') + (Digit - 10)
    END
    Text[Index] = CHR(digit)
    Index -= 1
  END
  RETURN Text[Index+1 : MaxLength]
