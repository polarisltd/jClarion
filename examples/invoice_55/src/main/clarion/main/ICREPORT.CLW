  MEMBER

BaseClassDllMode     EQUATE(0)
  INCLUDE('ICSTD.EQU')
  INCLUDE('ICHTML.INC')
  INCLUDE('ICLAYOUT.INC')
  INCLUDE('ICREPORT.INC')
  INCLUDE('ICWINDOW.INC')
  INCLUDE('ICREPORT.TRN')

    MAP
      INCLUDE('ICSTD.INC')
    END


Chatty EQUATE(0)
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

ReportItemClass      CLASS(HtmlItemClass),TYPE
GetPosition            PROCEDURE(*SIGNED, *SIGNED, *SIGNED, *SIGNED),VIRTUAL

X                      SIGNED
Y                      SIGNED
Width                  SIGNED
Height                 SIGNED
                     END

ReportStringClass    CLASS(ReportItemClass),TYPE
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
Init                   PROCEDURE(STRING,HtmlFontClass)
Kill                   PROCEDURE,VIRTUAL

Font                   &HtmlFontClass
Text                   ANY
                     END

ReportImageClass     CLASS(ReportItemClass),TYPE
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
Init                   PROCEDURE(STRING)

FileName               CSTRING(FILE:MaxFilePath)
                     END

ReportItemQueue      QUEUE,TYPE
CurItem                &ReportItemClass
                     END

WebPageClass         CLASS(WebControlClass),TYPE
AddControl             PROCEDURE(ReportItemClass)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
GetCellAttributes      PROCEDURE(*HtmlClass),STRING,VIRTUAL
Init                   PROCEDURE(SIGNED, WebWindowClass, QUEUE)
Kill                   PROCEDURE,VIRTUAL
Translate              PROCEDURE(string infile,string repfile,HtmlClass)

Q                      &QUEUE,PROTECTED
CurPage                SIGNED
ItemQ                  &ReportItemQueue
                     END


ReportItemClass.GetPosition PROCEDURE(*SIGNED X, *SIGNED Y, *SIGNED Width, *SIGNED Height)
  CODE
  X = SELF.X
  Y = SELF.Y
  Width = SELF.Width
  Height = SELF.Height


ReportStringClass.CreateHtml PROCEDURE(*HtmlClass H)
  CODE
  H.WriteFontHeader(SELF.Font)
  H.Writeln(SELF.Text)
  H.WriteFontFooter(SELF.Font)

ReportStringClass.Init  PROCEDURE(STRING Text,HtmlFontClass F)
  CODE
  SELF.Text = CLIP(Text)
  SELF.Font &= NEW HtmlFontClass
  SELF.Font = F

ReportStringClass.Kill PROCEDURE
  CODE
  DISPOSE(SELF.Font)
  PARENT.Kill

ReportImageClass.Init PROCEDURE(STRING S)
  CODE
  SELF.FileName = S

ReportImageClass.CreateHtml PROCEDURE(*HtmlClass H)
I USHORT,AUTO
  CODE
  H.Write('<<IMG')
  H.Write(' SRC="' & SELF.FileName &'"')
  H.Write(' WIDTH='&H.GetPixelsX(SELF.Width))
  H.Write(' HEIGHT='&H.GetPixelsY(SELF.Height))
  H.Writeln('>')

!---------------------------------------------------------------------
! Procedure to translate from a .wmf file to a .htm file
!---------------------------------------------------------------------

WebPageClass.AddControl             PROCEDURE(ReportItemClass NewItem)
  CODE
  SELF.ItemQ.CurItem &= NewItem
  ADD(SELF.ItemQ)


WebPageClass.CreateHtml             PROCEDURE(*HtmlClass Target)
wmfstring            cstring(255),auto
  CODE
  GET(SELF.Q,SELF.CurPage)
  wmfstring = CLIP(SELF.Q)
  ASSERT(INSTRING('.',wmfstring,1,1))

  SELF.Translate(wmfstring,'out.rep',Target)


WebPageClass.GetCellAttributes PROCEDURE(*HtmlClass H)
  CODE
  RETURN ' BGCOLOR=White'


WebPageClass.Init      PROCEDURE(SIGNED Feq, WebWindowClass Owner, QUEUE Q)
  CODE
  PARENT.Init(Feq, Owner)
  SELF.Q &= Q
  SELF.ItemQ &= NEW ReportItemQueue


WebPageClass.Kill      PROCEDURE
  CODE
  DISPOSE(SELF.ItemQ)


WebPageClass.Translate PROCEDURE(infilename,repfile,outstream)
IName                STRING(255),AUTO,STATIC
OName                STRING(255),AUTO,STATIC
InFile               FILE,DRIVER('DOS'),NAME(IName)
                     RECORD
Buffer                 STRING(5000)
                     ..
OutFile              FILE,DRIVER('Ascii'),NAME(OName),CREATE
                     RECORD
Buffer                 STRING(1000)
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


PixelsPerInch        USHORT(360)

FontsSeen            QUEUE
Id                     USHORT
Font                   &HtmlFontClass
                     END

Holes                QUEUE
Id                     USHORT
                     END

CurrentObject        USHORT
MaxObject            USHORT
CurPos               LONG(1)
Layout               LayoutHtmlClass
I                    USHORT,AUTO
XPos                 USHORT,AUTO
Ypos                 USHORT,AUTO
Width                USHORT,AUTO
Height               USHORT,AUTO
SavedOptions         LIKE(HtmlOptionGroup)
ScreenPixelPerInchX  EQUATE(72)
ScreenPixelPerInchY  EQUATE(72)
  CODE
  IName = infilename
  OPEN(InFile)
  ASSERT(~ERRORCODE())
  COMPILE('***',Chatty)
  OName = repfile
  CREATE(OutFile)
  ASSERT(~ERRORCODE())
  OPEN(OutFile)
  ASSERT(~ERRORCODE()) ***
  GET(InFile,1,SIZE(METAFILEHEADER))
  IF MetaFileHeader.Key = 9ac6cdd7H THEN
    DO OutMetaFileHeader
    CurPos += SIZE(METAFILEHEADER)
  END
  GET(InFile,CurPos,SIZE(METAHEADER))
  ASSERT(~ERRORCODE())
  CurPos += SIZE(MetaHeader)
  DO OutHeader

  SavedOptions :=: OutStream.Option
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
  CLOSE(OutFile)
  Layout.CreateHtml(OutStream)
  Layout.Kill

  OutStream.Option :=: SavedOptions

  LOOP I = 1 TO RECORDS(FontsSeen)
    GET(FontsSeen,I)
    DISPOSE(FontsSeen.Font)
  END

  LOOP I = 1 TO RECORDS(SELF.ItemQ)
    GET(SELF.ItemQ,I)
    SELF.ItemQ.CurItem.Kill
    DISPOSE(SELF.ItemQ.CurItem)
  END
  FREE(SELF.ItemQ)


OutMetaFileHeader ROUTINE
  PixelsPerInch = MetaFileHeader.Inch
  COMPILE('***',Chatty)
  OutFile.Buffer = 'Placeable Header : bbox('&METAFILEHEADER.Bbox:Left&','&METAFILEHEADER.Bbox:Top&','&METAFILEHEADER.Bbox:Right&','&METAFILEHEADER.Bbox:Bottom&') : Inches =' &METAFILEHEADER.Inch
  ADD(OutFile)  ***

OutHeader ROUTINE
   COMPILE('***',Chatty)
   OutFile.Buffer = 'Type         :' & METAHEADER.Type
   ADD(OutFile)
   OutFile.Buffer = 'HeaderSize   :' & METAHEADER.HeaderSize
   ADD(OutFile)
   OutFile.Buffer = 'Version      :' & METAHEADER.Version
   ADD(OutFile)
   OutFile.Buffer = 'Size         :' & METAHEADER.Size
   ADD(OutFile)
   OutFile.Buffer = 'NoObjects    :' & METAHEADER.NoObjects
   ADD(OutFile)
   OutFile.Buffer = 'MaxRecord    :' & METAHEADER.MaxRecord
   ADD(OutFile)
   OutFile.Buffer = 'NoParameters :' & METAHEADER.NoParameters
   ADD(OutFile)
   OutFile.Buffer = ''
   ADD(OutFile)  ***

OutRecord ROUTINE
  DATA
TextStart            USHORT,AUTO
TextLen              USHORT,AUTO
I                    USHORT
Via                  CSTRING(255)
Filename             CSTRING(FILE:MaxFilePath)
ViaSign              SHORT
StringClass          &ReportStringClass
ImageClass           &ReportImageClass
  CODE
  CASE MetaRecord.Funct
  COMPILE('***',Chatty)
  OF META:SETBKCOLOR
    OutFile.Buffer = 'SETBKCOLOR'
  OF META:SETBKMODE
    OutFile.Buffer = 'SETBKMODE'
  OF META:SETMAPMODE
    OutFile.Buffer = 'SETMAPMODE'
  OF META:SETROP2
    OutFile.Buffer = 'SETROP2'
  OF META:SETRELABS
    OutFile.Buffer = 'SETRELABS'
  OF META:SETPOLYFILLMODE
    OutFile.Buffer = 'SETPOLYFILLMODE'
  OF META:SETSTRETCHBLTMODE
    OutFile.Buffer = 'SETSTRETCHBLTMODE'
  OF META:SETTEXTCHAREXTRA
    OutFile.Buffer = 'SETTEXTCHAREXTRA'
  OF META:SETTEXTCOLOR
    OutFile.Buffer = 'SETTEXTCOLOR'
  OF META:SETTEXTJUSTIFICATION
    OutFile.Buffer = 'SETTEXTJUSTIFICATION'
  OF META:SETWINDOWORG
    OutFile.Buffer = 'SETWINDOWORG'
  OF META:SETWINDOWEXT
    OutFile.Buffer = 'SETWINDOWEXT'
  OF META:SETVIEWPORTORG
    OutFile.Buffer = 'SETVIEWPORTORG'
  OF META:SETVIEWPORTEXT
    OutFile.Buffer = 'SETVIEWPORTEXT'
  OF META:OFFSETWINDOWORG
    OutFile.Buffer = 'OFFSETWINDOWORG'
  OF META:SCALEWINDOWEXT
    OutFile.Buffer = 'SCALEWINDOWEXT'
  OF META:OFFSETVIEWPORTORG
    OutFile.Buffer = 'OFFSETVIEWPORTORG'
  OF META:SCALEVIEWPORTEXT
    OutFile.Buffer = 'SCALEVIEWPORTEXT'
  OF META:LINETO
    OutFile.Buffer = 'LINETO'
  OF META:MOVETO
    OutFile.Buffer = 'MOVETO'
  OF META:EXCLUDECLIPRECT
    OutFile.Buffer = 'EXCLUDECLIPRECT'
  OF META:INTERSECTCLIPRECT
    OutFile.Buffer = 'INTERSECTCLIPRECT'
  OF META:ARC
    OutFile.Buffer = 'ARC'
  OF META:ELLIPSE
    OutFile.Buffer = 'ELLIPSE'
  OF META:FLOODFILL
    OutFile.Buffer = 'FLOODFILL'
  OF META:PIE
    OutFile.Buffer = 'PIE'
  OF META:RECTANGLE
    OutFile.Buffer = 'RECTANGLE'
  OF META:ROUNDRECT
    OutFile.Buffer = 'ROUNDRECT'
  OF META:PATBLT
    OutFile.Buffer = 'PATBLT'
  OF META:SAVEDC
    OutFile.Buffer = 'SAVEDC'
  OF META:SETPIXEL
    OutFile.Buffer = 'SETPIXEL'
  OF META:OFFSETCLIPRGN
    OutFile.Buffer = 'OFFSETCLIPRGN'
  OF META:TEXTOUT
    OutFile.Buffer = 'TEXTOUT'
  OF META:BITBLT
    OutFile.Buffer = 'BITBLT'
  OF META:STRETCHBLT
    OutFile.Buffer = 'STRETCHBLT'
  OF META:POLYGON
    OutFile.Buffer = 'POLYGON'
  OF META:POLYLINE
    OutFile.Buffer = 'POLYLINE'
  OF META:RESTOREDC
    OutFile.Buffer = 'RESTOREDC'
  OF META:FILLREGION
    OutFile.Buffer = 'FILLREGION'
  OF META:FRAMEREGION
    OutFile.Buffer = 'FRAMEREGION'
  OF META:INVERTREGION
    OutFile.Buffer = 'INVERTREGION'
  OF META:PAINTREGION
    OutFile.Buffer = 'PAINTREGION'
  OF META:SELECTCLIPREGION
    OutFile.Buffer = 'SELECTCLIPREGION'
  OF META:SETTEXTALIGN
    OutFile.Buffer = 'SETTEXTALIGN'
  OF META:DRAWTEXT
    OutFile.Buffer = 'DRAWTEXT'
  OF META:CHORD
    OutFile.Buffer = 'CHORD'
  OF META:SETMAPPERFLAGS
    OutFile.Buffer = 'SETMAPPERFLAGS'
  OF META:SETDIBTODEV
    OutFile.Buffer = 'SETDIBTODEV'
  OF META:SELECTPALETTE
    OutFile.Buffer = 'SELECTPALETTE'
  OF META:REALIZEPALETTE
    OutFile.Buffer = 'REALIZEPALETTE'
  OF META:ANIMATEPALETTE
    OutFile.Buffer = 'ANIMATEPALETTE'
  OF META:SETPALENTRIES
    OutFile.Buffer = 'SETPALENTRIES'
  OF META:POLYPOLYGON
    OutFile.Buffer = 'POLYPOLYGON'
  OF META:RESIZEPALETTE
    OutFile.Buffer = 'RESIZEPALETTE'
  OF META:DIBBITBLT
    OutFile.Buffer = 'DIBBITBLT'
  OF META:DIBSTRETCHBLT
    OutFile.Buffer = 'DIBSTRETCHBLT'
  OF META:DIBCREATEPATTERNBRUSH
    DO NextObject
    OutFile.Buffer = 'DIBCREATEPATTERNBRUSH'
  OF META:STRETCHDIB
    OutFile.Buffer = 'STRETCHDIB'
  OF META:EXTFLOODFILL
    OutFile.Buffer = 'EXTFLOODFILL'
  OF META:RESETDC
    OutFile.Buffer = 'RESETDC'
  OF META:STARTDOC
    OutFile.Buffer = 'STARTDOC'
  OF META:STARTPAGE
    OutFile.Buffer = 'STARTPAGE'
  OF META:ENDPAGE
    OutFile.Buffer = 'ENDPAGE'
  OF META:ABORTDOC
    OutFile.Buffer = 'ABORTDOC'
  OF META:ENDDOC
    OutFile.Buffer = 'ENDDOC'
    ***
  OF META:ESCAPE
    IF MetaRecord.Params[3] = 1319 AND MetaRecord.Params[4] = 9 THEN
      XPos = MetaRecord.Params[6]
      YPos = MetaRecord.Params[5]
      Width = MetaRecord.Params[8]-MetaRecord.Params[6]
      Height = MetaRecord.Params[7]-MetaRecord.Params[5]
      Filename = CLIP(InFile.Buffer[7+9*2:MetaRecord.Size*2])
      Filename = SELF.OwnerWindow.Files.GetAlias(Filename)
      ImageClass &= NEW ReportImageClass
      ImageClass.Init(Filename)
      ImageClass.X = XPos
      ImageClass.Y = YPos
      ImageClass.Width = Width
      ImageClass.Height = Height
      Layout.Insert(ImageClass)
      SELF.AddControl(ImageClass)
    COMPILE('***',Chatty=1)
      OutFile.Buffer = 'IMAGE(' &XPos&','&YPos&','&Width&','&Height&')'
      ADD(OutFile)
      OutFile.Buffer = ' File =' & CLIP( InFile.Buffer[7+9*2:LEN(InFile.Buffer)] )
    ELSE
      OutFile.Buffer = 'ESCAPE('&MetaRecord.Params[1]&','&MetaRecord.Params[2]&','&MetaRecord.Params[3]&','&MetaRecord.Params[4]&')'
    ***
    END
  OF META:CREATEPALETTE
    OutFile.Buffer = 'CREATEPALETTE'
    DO NextObject
  OF META:CREATEBRUSH
    OutFile.Buffer = 'CREATEBRUSH'
    DO NextObject
  OF META:CREATEPATTERNBRUSH
    OutFile.Buffer = 'CREATEPATTERNBRUSH'
    DO NextObject
  OF META:CREATEPENINDIRECT
    OutFile.Buffer = 'CREATEPENINDIRECT'
    DO NextObject
  OF META:CREATEBRUSHINDIRECT
    OutFile.Buffer = 'CREATEBRUSHINDIRECT'
    DO NextObject
  OF META:CREATEBITMAPINDIRECT
    OutFile.Buffer = 'CREATEBITMAPINDIRECT'
    DO NextObject
  OF META:CREATEBITMAP
    OutFile.Buffer = 'CREATEBITMAP'
    DO NextObject
  OF META:CREATEREGION
    OutFile.Buffer = 'CREATEREGION'
    DO NextObject
  OF META:SELECTOBJECT
    OutFile.Buffer = 'SELECTOBJECT :' & MetaRecord.Params[1]
    FontsSeen.Id = MetaRecord.Params[1]
    GET(FontsSeen,FontsSeen.Id)
  OF META:EXTTEXTOUT
    COMPILE('***',Chatty)
    OutFile.Buffer = 'EXTTEXTOUT(x=' & MetaRecord.Params[2] & ',y=' & MetaRecord.Params[1] & ') Length:' & MetaRecord.Params[3]
    ADD(OutFile)
    ***
    TextStart = 15
    TextLen = MetaRecord.Params[3]
    IF MetaRecord.Params[4] THEN
      COMPILE('***',Chatty)
      OutFile.Buffer = '  Rectangle('&MetaRecord.Params[5]&','&MetaRecord.Params[6]&','&MetaRecord.Params[7]&','&MetaRecord.Params[8]&')'
      ADD(OutFile)
      ***
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
      OutFile.Buffer = 'Text = "' & InFile.Buffer[TextStart : TextStart + TextLen - 1] & '"'
      StringClass &= NEW ReportStringClass
      StringClass.Init(InFile.Buffer[TextStart : TextStart + TextLen - 1],FontsSeen.Font)
      StringClass.X = XPos
      StringClass.Y = YPos
      StringClass.Width = Width
      StringClass.Height = Height
      SELF.AddControl(StringClass)
      Layout.Insert(StringClass)
    ELSE
      OutFile.Buffer = ' No text available '
    END
  OF META:DELETEOBJECT
    OutFile.Buffer = 'DELETEOBJECT : '& MetaRecord.Params[1]
    Holes.Id = MetaRecord.Params[1]
    ADD(Holes,Holes.Id)
    FontsSeen.Id = MetaRecord.Params[1]
    GET(FontsSeen,FontsSeen.Id)
    IF ~ERRORCODE() THEN
      DISPOSE(FontsSeen.Font)
      DELETE(FontsSeen)
    END
  OF META:CREATEFONTINDIRECT
    OutFile.Buffer = 'CREATEFONTINDIRECT'
    DO NextObject
    ViaSign = MetaRecord.Params[1]
    CLEAR(FontsSeen)
    FontsSeen.Font &= NEW HtmlFontClass
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
  COMPILE('***')
  ADD(OutFile)
  ***

NextObject ROUTINE
  IF RECORDS(Holes) THEN
    GET(Holes,1)
    CurrentObject = Holes.Id
    DELETE(Holes)
  ELSE
    CurrentObject = MaxObject
    MaxObject += 1
  END
  OutFile.Buffer = CLIP(OutFile.Buffer) & ' Object : ' & CurrentObject


WebReportClass.Init           PROCEDURE(WebServerClass Server, HtmlClass Html, QUEUE PreviewQueue)
  CODE
  SELF.Q &= PreviewQueue
  SELF.Server &= Server
  SELF.Html &= Html

WebReportClass.SetNumPages    PROCEDURE(SIGNED NumPages)
  CODE
  SELF.NumPages = NumPages


WebReportClass.Kill           PROCEDURE
  CODE

WebReportClass.Preview        PROCEDURE

IncludeLocator       EQUATE(1)
FEQ:ButtonBase       EQUATE(6000)
WebWindow            WebWindowClass
HtmlPage             WebPageClass
CurPage              SIGNED(1)
CurPageText          CSTRING(255)
NumPages             SIGNED,AUTO

PreviewWindow        WINDOW('Print Preview'),AT(0,0,200,200),AUTO
                       GROUP,AT(0,0,180,20)
                         BUTTON,USE(?First),AT(0,0,16,14),ICON('VCRFIRST.ICO')
                         BUTTON,USE(?Previous),AT(20,0,16,14),ICON('VCRUP.ICO')
                         STRING(@s255),USE(CurPageText),AT(40,0,60,14)
                         BUTTON,USE(?Next),AT(100,0,16,14),ICON('VCRDOWN.ICO')
                         BUTTON,USE(?Last),AT(120,0,16,14),ICON('VCRLAST.ICO')
                       END
                       BUTTON,AT(190,0,16,14),USE(?Close),STD(STD:Close),ICON('exit.ico')
                       STRING(''),USE(?CurrentPage),AT(0,40,200,50)
                       GROUP,AT(0,100,180,20),USE(?ButtonGroup)
                       END
                     END

CurControl           &WebControlClass

  CODE
  NumPages = RECORDS(SELF.Q)

  OPEN(PreviewWindow)
  WebWindow.Init(SELF.Server, SELF.Html)
  WebWindow.CreateClose = CLOSE:Never
  WebWindow.CreateCaption = FALSE
  WebWindow.CreateToolbar = FALSE
  WebWindow.BorderWidth = 0

  CurControl &= WebWindow.AddControl(?First)
  CurControl.SetEventAction(EVENT:Accepted, Update:Full)
  CurControl &= WebWindow.AddControl(?Previous)
  CurControl.SetEventAction(EVENT:Accepted, Update:Full)
  CurControl &= WebWindow.AddControl(?Next)
  CurControl.SetEventAction(EVENT:Accepted, Update:Full)
  CurControl &= WebWindow.AddControl(?Last)
  CurControl.SetEventAction(EVENT:Accepted, Update:Full)
  CurControl &= WebWindow.AddControl(?Close)
  CurControl.SetEventAction(EVENT:Accepted, Update:Full)

  HtmlPage.Init(?CurrentPage, WebWindow, SELF.Q)
  WebWindow.AddControl(HtmlPage)

  DO AddPreviewButtons

  IF (NOT IncludeLocator)
    HIDE(?First, ?Last)
  END

  ACCEPT
    IF WebWindow.TakeEvent() THEN BREAK.

    CASE ACCEPTED()
    OF ?First
      CurPage = 1
    OF ?Previous
      IF (CurPage > 1)
        CurPage -= 1
      END
    OF ?Next
      IF (CurPage < NumPages)
        CurPage += 1
      END
    OF ?Last
      CurPage = NumPages
    ELSE
      IF (ACCEPTED() > FEQ:ButtonBase) AND (ACCEPTED() <= FEQ:ButtonBase + NumPages)
        CurPage = ACCEPTED() - FEQ:ButtonBase
      END
    END
    IF (HtmlPage.CurPage <> CurPage)
      HtmlPage.CurPage = CurPage
      CurPageText = 'Page ' & CurPage & '/' & NumPages
      DISPLAY(?CurPageText)
    END
  END

  CLOSE(PreviewWindow)
  HtmlPage.Kill
  WebWindow.Kill
  POST(EVENT:NewPage)                  ! Force an iteration of the accept loop


! Strategy : Add ten buttons across for as many lines as needed
AddPreviewButtons ROUTINE
  DATA
I                    USHORT,AUTO
Column               BYTE,AUTO
Row                  USHORT,AUTO
ButtonXPos           EQUATE(0)
ButtonYPos           EQUATE(100)
Feq                  SIGNED,AUTO
MaxPages             SIGNED,AUTO
  CODE

  MaxPages = NumPages
  IF (MaxPages > MaxButtons)
    MaxPages = MaxButtons
  END
  LOOP I = 1 TO MaxPages
    Feq = FEQ:ButtonBase + I
    Column = (I-1) % ButtonsPerLine
    Row = (I-1) / ButtonsPerLine

    CREATE(Feq, CREATE:Button, ?ButtonGroup)
    Feq{PROP:text} = I
    SETPOSITION(Feq, ButtonXPos + Column * ButtonWidth, ButtonYPos + Row * ButtonHeight, ButtonWidth, ButtonHeight)
    UNHIDE(Feq)
    IF (UseJavaButtons)
      CurControl &= WebWindow.AddControl(Feq, CREATE:button)
      CurControl.SetEventAction(EVENT:Accepted, Update:Full)
    END
  END

