     MEMBER
INCLUDE('ABPRPDF.INC'),ONCE
    PRAGMA('link(C%V%LZWS.LIB)')
    PRAGMA('link(C%V%DOS%X%%L%.LIB)')
    PRAGMA('link(EXP_PDF.ICO)')

FDFlag:FixedPitch       EQUATE(0000000000000000001b)
FDFlag:Serif            EQUATE(0000000000000000010b)
FDFlag:Symbolic         EQUATE(0000000000000000100b)
FDFlag:Script           EQUATE(0000000000000001000b)
FDFlag:Nonsymbolic      EQUATE(0000000000000100000b)
FDFlag:Italic           EQUATE(0000000000001000000b)

FDFlag:AllCap           EQUATE(0010000000000000000b)
FDFlag:SmallCap         EQUATE(0100000000000000000b)
FDFlag:ForceBold        EQUATE(1000000000000000000b)


PitchAndFamily:FIXED_PITCH EQUATE(0001b)
PitchAndFamily:VECTOR      EQUATE(0010b)
PitchAndFamily:TRUETYPE    EQUATE(0100b)
PitchAndFamily:DEVICE      EQUATE(1000b)

PitchAndFamily:FF_DONTCARE      EQUATE(0)
PitchAndFamily:FF_ROMAN         EQUATE(16)
PitchAndFamily:FF_SWISS         EQUATE(32)
PitchAndFamily:FF_MODERN        EQUATE(48)
PitchAndFamily:FF_SCRIPT        EQUATE(64)
PitchAndFamily:FF_DECORATIVE    EQUATE(80)

RECT                 GROUP,TYPE
left                    SIGNED
top                     SIGNED
right                   SIGNED
bottom                  SIGNED
                     END

winSizeType          GROUP,TYPE
eW                      SIGNED
eH                      SIGNED
                     END

TEXTMETRIC           GROUP,TYPE
tmHeight                LONG
tmAscent                LONG
tmDescent               LONG
tmInternalLeading       LONG
tmExternalLeading       LONG
tmAveCharWidth          LONG
tmMaxCharWidth          LONG
tmWeight                LONG
tmOverhang              LONG
tmDigitizedAspectX      LONG
tmDigitizedAspectY      LONG
tmFirstChar             BYTE
tmLastChar              BYTE
tmDefaultChar           BYTE
tmBreakChar             BYTE
tmItalic                BYTE
tmUnderlined            BYTE
tmStruckOut             BYTE
tmPitchAndFamily        BYTE
tmCharSet               BYTE
                     END

PANOSE               GROUP,TYPE
bFamilyType             BYTE
bSerifStyle             BYTE
bWeight                 BYTE
bProportion             BYTE
bContrast               BYTE
bStrokeVariation        BYTE
bArmStyle               BYTE
bLetterform             BYTE
bMidline                BYTE
bXHeight                BYTE
                     END

POINT                GROUP,TYPE
X                       SIGNED
Y                       SIGNED
                     END


OUTLINETEXTMETRIC    GROUP,TYPE
otmSize                 UNSIGNED
otmTextMetrics          LIKE(TEXTMETRIC)
otmFiller               BYTE
otmPanoseNumber         LIKE(PANOSE)
otmfsSelection          UNSIGNED
otmfsType               UNSIGNED
otmsCharSlopeRise       SIGNED
otmsCharSlopeRun        SIGNED
otmItalicAngle          SIGNED
otmEMSquare             UNSIGNED
otmAscent               SIGNED
otmDescent              SIGNED
otmLineGap              UNSIGNED
otmsCapEmHeight         UNSIGNED
otmsXHeight             UNSIGNED
otmrcFontBox            LIKE(RECT)
otmMacAscent            SIGNED
otmMacDescent           SIGNED
otmMacLineGap           UNSIGNED
otmusMinimumPPEM        UNSIGNED
otmptSubscriptSize      LIKE(POINT)
otmptSubscriptOffset    LIKE(POINT)
otmptSuperscriptSize    LIKE(POINT)
otmptSuperscriptOffset  LIKE(POINT)
otmsStrikeoutSize       UNSIGNED
otmsStrikeoutPosition   SIGNED
otmsUnderscoreSize      SIGNED
otmsUnderscorePosition  SIGNED
otmpUNKW                LONG
otmpFamilyName          LONG        !*PSTR
otmpFaceName            LONG        !*PSTR
otmpStyleName           LONG        !*PSTR
otmpFullName            LONG        !*PSTR
                     END

    MAP
     MODULE('Windows API')
       GetDC(UNSIGNED),UNSIGNED,PASCAL
       CreateCompatibleDC(UNSIGNED),UNSIGNED,PASCAL
       ReleaseDC(UNSIGNED, UNSIGNED),SIGNED,PASCAL
       DeleteDC(UNSIGNED),BOOL,PROC,PASCAL
       SelectObject(UNSIGNED, UNSIGNED),UNSIGNED,PASCAL
       DeleteObject(UNSIGNED),UNSIGNED,PROC,PASCAL
       CreateFont(SIGNED, SIGNED, SIGNED, SIGNED, SIGNED, ULONG, ULONG, ULONG, ULONG, ULONG, ULONG,ULONG, ULONG,*CSTRING),UNSIGNED,PASCAL,RAW,NAME('CreateFontA')
       GetOutlineTextMetrics(ULONG, ULONG, <*CSTRING>),ULONG,PASCAL,RAW,NAME('GetOutlineTextMetricsA')
       GetTextExtentPoint32(UNSIGNED,*STRING, SIGNED, *winSizeType),BOOL,PASCAL,RAW,NAME('GetTextExtentPoint32A')
       GetDeviceCaps(UNSIGNED, SIGNED),SIGNED,PASCAL
       SetMapMode(ULONG hdc, ULONG nMapMode ),ULONG,PASCAL,RAW
     END
     MODULE('C60LZWS.LIB')
       Insert_LZWStream(*CSTRING pdfName,*CSTRING gifName,SIGNED pStreemStart),LONG,RAW,NAME('_insert_lzwstream')
     END
    END
!********************************************
PDFGeneratorClass.Init        PROCEDURE(<STRING TargetFileName>)
 CODE
   FREE(SELF.PageObs)
   FREE(SELF.Locations)
   FREE(SELF.XObject)
   FREE(SELF.Images)
   FREE(SELF.PageHyperLinks)
   FREE(SELF.Contents)
   FREE(SELF.BookMarks)
   FREE(SELF.FontsNames)
   SELF.InText  = False
   SELF.InImage = False

   SELF.FontColor.Red   =0
   SELF.FontColor.Green =0
   SELF.FontColor.Blue  =0

   SELF.FillColor.Red   =0
   SELF.FillColor.Green =0
   SELF.FillColor.Blue  =0

   SELF.PenColor.Red   =0
   SELF.PenColor.Green =0
   SELF.PenColor.Blue  =0

   SELF.ObjPenColor    =0
   SELF.ObjPenWidth    =0
   SELF.ObjPenStyle    =0
   SELF.ObjFontNumber  =0
   SELF.ObjFontColor   =0
   SELF.ObjFontSize    =0
   SELF.ObjFillColor   =0

   SELF.PenWidth = 1
   SELF.PenStyle = PEN:solid

   SELF.FontsNum = 0
   SELF.ImageNo  = 0
   IF NOT OMITTED(2) THEN
      SELF.Output.Init(TargetFileName)
   END
   IF NOT SELF.Title THEN
      SELF.Title = 'PDF Document'
   END
   IF NOT SELF.AppName THEN
      SELF.AppName = 'Clarion PDF'
   END
   IF NOT SELF.ProgName THEN
      SELF.ProgName = 'Clarion PDF'
   END
   SELF.SetPagesAsParentBookmark(False)
   SELF.SetBasePageBookmarkName('Page_')
   SELF.ISOEnc = TRUE
   SELF.SetUp()

PDFGeneratorClass.SetPagesAsParentBookmark PROCEDURE(BYTE pTrue)
 CODE
    SELF.PagesAsParentBookmark = pTrue

PDFGeneratorClass.SetBasePageBookmarkName PROCEDURE(STRING pBaseName)
 CODE
    SELF.BasePageBookmarkName = pBaseName

PDFGeneratorClass.SetDocumentInfo      PROCEDURE(STRING pTitle,STRING pAppName,STRING pProgName,STRING pSubject,STRING pAuthor,STRING pKeywords)
 CODE
    SELF.Title    = pTitle
    SELF.AppName  = pAppName
    SELF.ProgName = pProgName
    SELF.Subject  = pSubject
    SELF.Author   = pAuthor
    SELF.Keywords = pKeywords

PDFGeneratorClass.SetUp    PROCEDURE()
 CODE

PDFGeneratorClass.Construct   PROCEDURE()
 CODE
   SELF.PageObs   &= NEW(QueuePageObject)
   SELF.Locations &= NEW(QueueObjectLocation)
   SELF.XObject   &= NEW(QueueXObject)
   SELF.Images    &= NEW(QueueImageObject)
   SELF.PageHyperLinks &= NEW(QueueHyperLinks)
   SELF.Contents  &= NEW(QueueContent)
   SELF.BookMarks &= NEW(QueueBookMark)
   SELF.Output &= NEW(TargetGenerator)
   SELF.PolyPoint &= NEW(QueuePoint)
   SELF.FontsNames&=NEW(QueueFontsNames)
   SELF.DC = 0

PDFGeneratorClass.Destruct    PROCEDURE()
lIndex  LONG
 CODE

   IF SELF.DC
      DeleteDC(SELF.DC)
   END

   FREE(SELF.PageObs)
   FREE(SELF.Locations)
   FREE(SELF.XObject)
   FREE(SELF.Images)
   FREE(SELF.PageHyperLinks)
   FREE(SELF.Contents)
   FREE(SELF.BookMarks)
   FREE(SELF.PolyPoint)
   FREE(SELF.FontsNames)

   DISPOSE(SELF.PolyPoint)
   DISPOSE(SELF.PageObs)
   DISPOSE(SELF.Locations)
   DISPOSE(SELF.XObject)
   DISPOSE(SELF.Images)
   DISPOSE(SELF.PageHyperLinks)
   DISPOSE(SELF.Contents)
   DISPOSE(SELF.BookMarks)
   DISPOSE(SELF.Output)
   DISPOSE(SELF.FontsNames)

PDFGeneratorClass.SetFileName              PROCEDURE(STRING pFileName)
 CODE
    SELF.Output.SetOriginalFileName(pFileName)

PDFGeneratorClass.SetPageLandscape PROCEDURE()
 CODE
    SELF.PageLandscape = True

PDFGeneratorClass.SetPagePortrait  PROCEDURE()
 CODE
    SELF.PageLandscape = False

PDFGeneratorClass.SetPageSize PROCEDURE(LONG Width ,LONG Height)
 CODE
   SELF.PageWidth  = Width
   SELF.PageHeight = Height

PDFGeneratorClass.SetPageSize PROCEDURE() ! use with the Paper type
LOC:Width  LONG
LOC:Height LONG
 CODE
   CASE SELF.PageType
   OF PAPER:LETTER
      LOC:Width  = 8500
      LOC:Height = 11000
   OF PAPER:LETTERSMALL
      LOC:Width  = 8500
      LOC:Height = 11000
   OF PAPER:TABLOID
      LOC:Width  = 11000
      LOC:Height = 17000
   OF PAPER:LEDGER
      LOC:Width  = 17000
      LOC:Height = 11000
   OF PAPER:LEGAL
      LOC:Width  = 8500
      LOC:Height = 14000
   OF PAPER:STATEMENT
      LOC:Width  = 5500
      LOC:Height = 8500
   OF PAPER:EXECUTIVE
      LOC:Width  = 7250
      LOC:Height = 10500
   OF PAPER:A3
      LOC:Width  = 11688
      LOC:Height = 16500
   OF PAPER:A4
      LOC:Width  = 8250
      LOC:Height = 11688
   OF PAPER:A4SMALL
      LOC:Width  = 8250
      LOC:Height = 11688
   OF PAPER:A5
      LOC:Width  = 5844
      LOC:Height = 8250
   OF PAPER:B4
      LOC:Width  = 9842
      LOC:Height = 13937
   OF PAPER:B5
      LOC:Width  = 7165
      LOC:Height = 10118
   OF PAPER:FOLIO
      LOC:Width  = 8500
      LOC:Height = 13000
   OF PAPER:QUARTO
      LOC:Width  = 8464
      LOC:Height = 10826
   OF PAPER:10X14
      LOC:Width  = 10000
      LOC:Height = 14000
   OF PAPER:11X17
      LOC:Width  = 11000
      LOC:Height = 17000
   OF PAPER:NOTE
      LOC:Width  = 8500
      LOC:Height = 11000
   OF PAPER:ENV_9
      LOC:Width  = 3875
      LOC:Height = 8875
   OF PAPER:ENV_10
      LOC:Width  = 4125
      LOC:Height = 9500
   OF PAPER:ENV_11
      LOC:Width  = 4500
      LOC:Height = 10375
   OF PAPER:ENV_12
      LOC:Width  = 4500
      LOC:Height = 11000
   OF PAPER:ENV_14
      LOC:Width  = 5000
      LOC:Height = 11500
   OF PAPER:CSHEET
      LOC:Width  = 10000
      LOC:Height = 10000
   OF PAPER:DSHEET
      LOC:Width  = 10000
      LOC:Height = 10000
   OF PAPER:ESHEET
      LOC:Width  = 10000
      LOC:Height = 10000
   OF PAPER:ENV_DL
      LOC:Width  = 4330
      LOC:Height = 8660
   OF PAPER:ENV_C5
      LOC:Width  = 6377
      LOC:Height = 9015
   OF PAPER:ENV_C3
      LOC:Width  = 12755
      LOC:Height = 18031
   OF PAPER:ENV_C4
      LOC:Width  = 9015
      LOC:Height = 12755
   OF PAPER:ENV_C6
      LOC:Width  = 4488
      LOC:Height = 6377
   OF PAPER:ENV_C65
      LOC:Width  = 4488
      LOC:Height = 9015
   OF PAPER:ENV_B4
      LOC:Width  = 9842
      LOC:Height = 13897
   OF PAPER:ENV_B5
      LOC:Width  = 6929
      LOC:Height = 9842
   OF PAPER:ENV_B6
      LOC:Width  = 6929
      LOC:Height = 4921
   OF PAPER:ENV_ITALY
      LOC:Width  = 4330
      LOC:Height = 9055
   OF PAPER:ENV_MONARCH
      LOC:Width  = 3875
      LOC:Height = 7500
   OF PAPER:ENV_PERSONAL
      LOC:Width  = 3625
      LOC:Height = 6500
   OF PAPER:FANFOLD_US
      LOC:Width  = 14875
      LOC:Height = 11000
   OF PAPER:FANFOLD_STD_GERMAN
      LOC:Width  = 8500
      LOC:Height = 12000
   OF PAPER:FANFOLD_LGL_GERMAN
      LOC:Width  = 8500
      LOC:Height = 13000
   ELSE
   END
   IF SELF.PageType<>PAPER:USER THEN
      SELF.SetPageSize(LOC:Width/(8500/612),LOC:Height/(8500/612))
   END

PDFGeneratorClass.SetPageType PROCEDURE(SHORT pPageType,LONG pWidth=0,LONG pHeight=0) ! The size is in 1/1000 inch
 CODE
   SELF.PageType = pPageType
   IF pPageType=PAPER:USER THEN
      SELF.SetPageSize(pWidth/(8500/612),pHeight/(8500/612))
   ELSE
      SELF.SetPageSize()
   END

PDFGeneratorClass.SetHyperLinkBoxed     PROCEDURE(BYTE pValue)
 CODE
   SELF.HyperLinkBoxed = pValue

PDFGeneratorClass.SetHyperLinkBoxColor     PROCEDURE(LONG pColor)
 CODE
   SELF.HyperLinkBoxColor = pColor

PDFGeneratorClass.OpenDocument PROCEDURE()
  CODE
     SELF.Output.Init()
     SELF.Output.OpenFile()

     SELF.Output.WriteStr('%PDF-1.3'&CHR(13)&CHR(37)&CHR(226)&CHR(227)&CHR(207)&CHR(211)&CHR(13)&CHR(10))

     SELF.Locations.ObjectNo = 1
     SELF.Locations.Position = SELF.Output.FPos
     ADD(SELF.Locations)
     SELF.Output.WriteLine('1 0 obj')
     SELF.Output.WriteLine(CHR(60)&CHR(60)&' ')
     SELF.Output.WriteLine('/CreationDate (D:'&FORMAT(TODAY(),'@D012')&FORMAT(CLOCK(),'@T05')&')')
     IF NOT (SELF.Title) THEN
        SELF.Title='PDF-CW-Job'
     END
     SELF.Output.WriteLine('/Title ('&CLIP(SELF.Title)&')')
     SELF.Output.WriteLine('/Creator ('&CLIP(SELF.AppName)&')')
     SELF.Output.WriteLine('/Producer ('&CLIP(SELF.ProgName)&')')
     SELF.Output.WriteLine('/ModDate (D:'&FORMAT(TODAY(),'@D012')&FORMAT(CLOCK(),'@T05')&')')
     SELF.Output.WriteLine('/Subject ('&CLIP(SELF.Subject)&')')
     SELF.Output.WriteLine('/Author ('&CLIP(SELF.Author)&')')
     SELF.Output.WriteLine('/Keywords ('&CLIP(SELF.Keywords)&')')
     SELF.Output.WriteLine('>> ')
     SELF.Output.WriteLine('endobj')
     SELF.Locations.ObjectNo = 2
     SELF.Locations.Position = SELF.Output.FPos
     ADD(SELF.Locations)

     SELF.Output.WriteLine('2 0 obj')
     SELF.Output.WriteLine(CHR(60)&CHR(60)&' ')
     SELF.Output.WriteLine('/Type /Catalog')
     SELF.Output.WriteLine('/Outlines 5 0 R')
     SELF.Output.WriteLine('/Pages 3 0 R')
     SELF.Output.WriteLine('>> ')
     SELF.Output.WriteLine('endobj')
     SELF.CurObj=5

PDFGeneratorClass.CloseDocument PROCEDURE()
LOC:XRef LONG
LOC:I    LONG
LOC:P    LONG
LOC:INDEX LONG
LOC:XOExist BYTE
 CODE

    !!!!!!!!!!!!!!!!!!!!!!!
    ! Write Obj: XX
    ! All Bookmarks Obj
    !!!!!!!!!!!!!!!!!!!!!!!
    SELF.AddAllBookMark()

    !!!!!!!!!!!!!!!!!!!!!!!
    ! Write Obj: XX
    ! All Fonts Obj
    !!!!!!!!!!!!!!!!!!!!!!!
    Self.AddFonts()

    !!!!!!!!!!!!!!!!!!!!!!!
    ! Write Obj: XX
    ! All Images Obj
    !!!!!!!!!!!!!!!!!!!!!!!
    SELF.AddImages()
    !!!!!!!!!!!!!!!!!!!!!!!
    ! Write Obj:3
    ! Pages
    !!!!!!!!!!!!!!!!!!!!!!!
    SELF.Locations.ObjectNo = 3
    SELF.Locations.Position = SELF.Output.FPos
    ADD(SELF.Locations)
    SELF.Output.WriteLine('3 0 obj')
    SELF.Output.WriteLine(CHR(60)&CHR(60)&' ')
    SELF.Output.WriteLine('/Type /Pages')
    SELF.Output.WriteLine('/Count '&SELF.PageNo)
    IF SELF.PageLandscape = False THEN
       SELF.Output.WriteLine('/MediaBox [ 0 0 '&SELF.PageWidth&' '&SELF.PageHeight&' ]')
    ELSE
       SELF.Output.WriteLine('/MediaBox [ 0 0 '&SELF.PageHeight&' '&SELF.PageWidth&' ]')
    END
    SELF.Output.WriteStr('/Kids [')
    LOOP LOC:I = 1 TO  SELF.PageNo
         SELF.PageObs.Number = LOC:I
         GET(SELF.PageObs,SELF.PageObs.Number)
         IF NOT ERRORCODE() THEN
            SELF.Output.WriteStr(' '&(SELF.PageObs.ObjectNo)&' 0 R')
         END
    END
    SELF.Output.WriteLine(' ]')
    SELF.Output.WriteLine('>>')
    SELF.Output.WriteLine('endobj')

    !!!!!!!!!!!!!!!!!!!!!!!
    ! Write Resource , All page use the same resource
    ! Fonts Resources,XObject Resources
    !!!!!!!!!!!!!!!!!!!!!!!
    SELF.Locations.ObjectNo = 4
    SELF.Locations.Position = SELF.Output.FPos
    ADD(SELF.Locations)
    SELF.Output.WriteLine('4 0 obj')
    SELF.Output.WriteLine(CHR(60)&CHR(60)&' ')
    IF RECORDS(SELF.FontsNames)>0 THEN
       SELF.Output.WriteStr('/Font '&CHR(60)&CHR(60))
       LOOP LOC:I=1 TO RECORDS(SELF.FontsNames)
            GET(SELF.FontsNames,LOC:I)
            IF NOT ERRORCODE()
               SELF.Output.WriteStr(' /F'&SELF.FontsNames.Number)
               SELF.Output.WriteStr(' '&SELF.FontsNames.ObjectNo)
               SELF.Output.WriteStr(' 0 R')
            END
       END
       SELF.Output.WriteStr(' >>'&CHR(13))
    END
    IF SELF.ImageNo>0 THEN
       SELF.Output.WriteStr('/XObject '&CHR(60)&CHR(60))
       LOOP LOC:I=1 TO RECORDS(SELF.Images)
           GET(SELF.Images,LOC:I)
           IF NOT ERRORCODE() THEN
              SELF.Output.WriteStr(' /Im'&SELF.Images.ImageNo&' '&SELF.Images.ObjectNo&' 0 R')
           END
       END
       SELF.Output.WriteLine(' >>')
    END
    SELF.Output.WriteLine('/ProcSet [ /PDF /Text /ImageC ]')
    SELF.Output.WriteLine('>>')
    SELF.Output.WriteLine('endobj')

    LOC:XRef = SELF.Output.FPos
    SELF.CurObj+=1
    SELF.Output.WriteLine('xref')
    SELF.Output.WriteLine('0 '&SELF.CurObj&' ')
    ! note that '&CHR(10)&' is translated by SELF.Output.WriteLine */
    SELF.Output.WriteLine('0000000000 65535 f')

    LOOP LOC:I = 1 TO SELF.CurObj
        SELF.Locations.ObjectNo = LOC:I
        GET(SELF.Locations,SELF.Locations.ObjectNo)
        IF NOT ERRORCODE() THEN
           SELF.Output.WriteLine(FORMAT(SELF.Locations.Position,'@n010')&' 00000 n')
        END
    END
    SELF.Output.WriteLine('trailer')
    SELF.Output.WriteLine(CHR(60)&CHR(60)&' ')
    SELF.Output.WriteLine('/Size '&(SELF.CurObj))
    SELF.Output.WriteLine('/Info 1 0 R')
    SELF.Output.WriteLine('/Root 2 0 R')
    SELF.Output.WriteLine('/ID[<b94f171e8c6ad92a8dc45b559e759d39><b94f171e8c6ad92a8dc45b559e759d39>]')
    SELF.Output.WriteLine('>>')
    SELF.Output.WriteLine('startxref')
    SELF.Output.WriteLine(LOC:XRef)
    SELF.Output.WriteLine('%%EOF')

    SELF.Output.CloseFile()

PDFGeneratorClass.WriteFileLZWStream   PROCEDURE(STRING pFileName,LONG pStart=1)
LOC:pFileName       CSTRING(255)
LOC:TargetFileName  CSTRING(255)
ReturnValue         LONG
 CODE
   IF NOT CLIP(pFileName) THEN RETURN 0.
   ReturnValue = 0
   LOC:pFileName = CLIP(pFileName)
   SELF.Output.CloseFile()
   LOC:TargetFileName = SELF.Output.GetFileName()
   ReturnValue = Insert_LZWStream(LOC:TargetFileName,LOC:pFileName,pStart)
   SELF.Output.OpenFile(0)
   RETURN ReturnValue

PDFGeneratorClass.WriteFilePNGPLTE       PROCEDURE(STRING pFileName)
LOC:Buffer     STRING(768),NAME('|BINARY')                                   
LOC:ChunkName  STRING(4)
LOC:ChunkSize  ULONG
 CODE
    LOC:ChunkName=''
    IF SELF.Output.OpenSourceFile(pFileName) THEN
       SELF.Output.SetSourceSAutoAdvance(True)
       SELF.Output.SetSourceFPos(33) !Omit the firm and IHDR chunk
       IF SELF.Output.ReadULong(LOC:ChunkSize) THEN
          LOC:ChunkName=SELF.Output.GetStr(4)
          LOOP
             IF LOC:ChunkName='PLTE' OR LOC:ChunkName='IEND' OR LOC:ChunkName='IDAT' THEN BREAK.
             SELF.Output.SetSourceFPos(SELF.Output.GetSourceFPos()+LOC:ChunkSize+8)
             IF SELF.Output.ReadULong(LOC:ChunkSize) THEN
                LOC:ChunkName=SELF.Output.GetStr(4)
             ELSE
                LOC:ChunkName=''
                BREAK
             END
          END
       END
       IF LOC:ChunkName='PLTE' THEN
          SELF.Output.WriteStr(((LOC:ChunkSize/3)-1)&' [/Indexed /DeviceRGB (')
          SELF.Output.WriteStr(SELF.Output.GetStr(LOC:ChunkSize))
          SELF.Output.WriteLine(')]')
       ELSE
          SELF.Output.WriteLine(LOC:ChunkSize&' /DeviceRGB')
       END
    END
    SELF.Output.CloseSourceFile()

PDFGeneratorClass.WriteFilePNGiDat       PROCEDURE(STRING pFileName)
LOC:Buffer     STRING(2000),NAME('|BINARY')                                  
LOC:BytesToRead LONG
LOC:BytesRest   LONG
LOC:ChunkName  STRING(4)
LOC:ChunkSize  ULONG
G GROUP,OVER(LOC:ChunkSize)
A              BYTE
B              BYTE
C              BYTE
D              BYTE
               END
LOC:TotalBytes  LONG
LOC:AuxFPos     LONG
 CODE
    !4BYTE_LEN-NAME-CHUNK_DATA-4BYTE_CRC
    LOC:TotalBytes=0
    LOC:ChunkName=''
    IF SELF.Output.OpenSourceFile(pFileName) THEN
       SELF.Output.SetSourceSAutoAdvance(True)
       SELF.Output.SetSourceFPos(34) !Omit the firm and IHDR chunk
       IF SELF.Output.ReadULong(LOC:ChunkSize) THEN
          LOC:ChunkName=SELF.Output.GetStr(4)
          LOOP
             IF LOC:ChunkName='IDAT' OR LOC:ChunkName='IEND' THEN BREAK.
             SELF.Output.SetSourceFPos(SELF.Output.GetSourceFPos()+LOC:ChunkSize+4)
             IF SELF.Output.ReadULong(LOC:ChunkSize) THEN
                LOC:ChunkName=SELF.Output.GetStr(4)
             ELSE
                LOC:ChunkName=''
                BREAK
             END
          END
       END
       LOOP
          IF LOC:ChunkName<>'IDAT' THEN BREAK.
          SELF.Output.WriteFileStream(pFileName,SELF.Output.GetSourceFPos(),LOC:ChunkSize)
          LOC:TotalBytes+=LOC:ChunkSize
          SELF.Output.SetSourceFPos(SELF.Output.GetSourceFPos()+4)

          IF SELF.Output.ReadULong(LOC:ChunkSize) THEN
             LOC:ChunkName=SELF.Output.GetStr(4)
          ELSE
             BREAK
          END
       END
    END
    SELF.Output.CloseSourceFile()
    RETURN LOC:TotalBytes

PDFGeneratorClass.GetImageInfo PROCEDURE(*QueueImageObject pImage)
LOC:ImageInfo           FILE,DRIVER('DOS'),PRE(IMIF)
                          RECORD
Buffer                     STRING(1849),NAME('|BINARY')
                          END
                        END
LOC:FileHandle  LONG
JPGRecord     GROUP,OVER(IMIF:Buffer)
JPGLength         STRING(6)
JPGIdentifier     STRING(4) !74,70,73,70,0 = 'JFIF'
JPGNull           BYTE
JPGNull2          STRING(152)
JPGHeight         USHORT
JPGGHeight        GROUP,OVER(JPGHeight)
JPGHeight1           BYTE   !To Change higher and lower bytes
JPGHeight2           BYTE   !To Change higher and lower bytes
                  END
JPGWidth          USHORT
JPGGWidth         GROUP,OVER(JPGWidth)
JPGWidth1            BYTE   !To Change higher and lower bytes
JPGWidth2            BYTE   !To Change higher and lower bytes
                  END
              END
GIFRecord     GROUP,OVER(IMIF:Buffer)
GIFIdentifier      STRING(3) !'GIF'
GIFVersion         STRING(3) !'87'
GIFWidth           USHORT
GIFHeight          USHORT
GIFColorTableLen   BYTE
GIFBackgroundColor BYTE
GIFPixelRatio      BYTE
GIFColorTableStreem STRING(1790),NAME('|BINARY')                             
                END
PNGRecord     GROUP,OVER(IMIF:Buffer)
PNGIdentifier         BYTE,DIM(8) !137 80 78 71 13 10 26 10
PNGChunkLen           ULONG ! First chunk is the header and is 13 byte long
PNGHeader             STRING(4)
PNGWidth              ULONG
PNGHeight             ULONG
PNGBit_depth          BYTE
PNGColor_type         BYTE
PNGCompression_method BYTE
PNGFilter_method      BYTE
PNGInterlace_method   BYTE
              END
LOC:BYTEAUX     BYTE
LOC:PNGChunkLen1 ULONG
LOC:PNGChunkLen2 ULONG
LOC:PNGChunkLen3 ULONG
LOC:PNGChunkLen4 ULONG
LOC:USHORTAUX    USHORT
LOC:I SHORT
LOC:II SHORT
LOC:FlipUlong  ULONG
LOC:GFlipUlong         GROUP,OVER(LOC:FlipUlong)
LOC:GFlipUlong1            BYTE
LOC:GFlipUlong2            BYTE
LOC:GFlipUlong3            BYTE
LOC:GFlipUlong4            BYTE
                  END
LOC:FlipUlongAux  BYTE
LOC:ColorTableLenByte   BYTE
LOC:ColorTableLen   SHORT
LOC:ColorTableStart SHORT
LOC:GIFBlockSizePos  SHORT
LOC:GIFHasExtension  SHORT(0)
LOC:GIFExtensionSubBlockLenS STRING(1)
LOC:GIFExtensionSubBlockLen BYTE,OVER(LOC:GIFExtensionSubBlockLenS)
 CODE


   pImage.Width   =0
   pImage.Height  =0
   pImage.Type    =0
   pImage.ColorTableLen =0
   LOC:ImageInfo{PROP:NAME}=CLIP(pImage.FileName)
   OPEN(LOC:ImageInfo,0+32) !Read Only - Deny Write
   IF ERRORCODE() THEN
      MESSAGE('ERROR ('&ERRORCODE()&')'&ERROR()&' FILE:'&LOC:ImageInfo{PROP:NAME},'GetImageInfo')
      RETURN
   END

   SET(LOC:ImageInfo)
   pImage.Type = 0
   GET(LOC:ImageInfo,1)
   IF ERRORCODE() THEN
      MESSAGE('ERROR ('&ERRORCODE()&')'&ERROR()&' FILE:'&LOC:ImageInfo{PROP:NAME},'GetImageInfo')
      RETURN
   END

   IF LEN(CLIP(LOC:ImageInfo.Buffer))>0 THEN
      IF JPGRecord.JPGIdentifier = 'JFIF' AND JPGRecord.JPGNull=0 THEN
         pImage.Type    = 1        !-JPEG

         LOC:BYTEAUX=JPGRecord.JPGGWidth.JPGWidth1
         JPGRecord.JPGGWidth.JPGWidth1=JPGRecord.JPGGWidth.JPGWidth2
         JPGRecord.JPGGWidth.JPGWidth2=LOC:BYTEAUX
         LOC:BYTEAUX=JPGRecord.JPGGHeight.JPGHeight1
         JPGRecord.JPGGHeight.JPGHeight1=JPGRecord.JPGGHeight.JPGHeight2
         JPGRecord.JPGGHeight.JPGHeight2=LOC:BYTEAUX

         pImage.Width   = JPGRecord.JPGWidth
         pImage.Height  = JPGRecord.JPGHeight

      ELSE
         IF GIFRecord.GIFIdentifier = 'GIF' THEN
            !global color table
            IF BAND(10000000b,GIFRecord.GIFColorTableLen) THEN
               LOC:ColorTableLenByte =  BSHIFT(GIFRecord.GIFColorTableLen,5)
               LOC:ColorTableLenByte =  BSHIFT(LOC:ColorTableLenByte,-5)
               pImage.ColorTableLen = LOC:ColorTableLenByte
               LOC:ColorTableLen =  3 * (2^(LOC:ColorTableLenByte+1))
            ELSE
!               'NOT GLOBAL'
            END
               !Need a valid global color table

                !Others Blocks
                LOC:GIFHasExtension=0
                LOOP
                   IF GIFRecord.GIFColorTableStreem[(LOC:ColorTableLen+1+LOC:GIFHasExtension)]=CHR(33) THEN
                      CASE GIFRecord.GIFColorTableStreem[(LOC:ColorTableLen+2+LOC:GIFHasExtension)]
                      OF CHR(249)        !Graphic
                         LOC:GIFHasExtension+=8
                      OF CHR(254)        !Comment
                         LOC:GIFHasExtension+=2
                         LOC:GIFExtensionSubBlockLen=1
                         LOOP
                             IF LOC:GIFExtensionSubBlockLen=0 THEN BREAK.
                             LOC:GIFExtensionSubBlockLenS=GIFRecord.GIFColorTableStreem[(LOC:ColorTableLen+LOC:GIFHasExtension+1)]
                             LOC:GIFHasExtension=LOC:GIFHasExtension+(1+LOC:GIFExtensionSubBlockLen)
                         END
                      OF CHR(1)          !Plain Text
                         LOC:GIFHasExtension+=15
                         LOC:GIFExtensionSubBlockLen=1
                         LOOP
                             IF LOC:GIFExtensionSubBlockLen=0 THEN BREAK.
                             LOC:GIFExtensionSubBlockLenS=GIFRecord.GIFColorTableStreem[(LOC:ColorTableLen+LOC:GIFHasExtension+1)]
                             LOC:GIFHasExtension=LOC:GIFHasExtension+(1+LOC:GIFExtensionSubBlockLen)
                         END
                      OF CHR(255)         !Application
                         LOC:GIFHasExtension+=14
                         LOC:GIFExtensionSubBlockLen=1
                         LOOP
                             IF LOC:GIFExtensionSubBlockLen=0 THEN BREAK.
                             LOC:GIFExtensionSubBlockLenS=GIFRecord.GIFColorTableStreem[(LOC:ColorTableLen+LOC:GIFHasExtension+1)]
                             LOC:GIFHasExtension=LOC:GIFHasExtension+(1+LOC:GIFExtensionSubBlockLen)
                         END
                      END
                   ELSE
                      BREAK
                   END
                END

               !Start Image Data Block
               IF GIFRecord.GIFColorTableStreem[(LOC:GIFHasExtension+LOC:ColorTableLen+1)]=CHR(44)
                  LOC:ColorTableLenByte =  GIFRecord.GIFColorTableStreem[(LOC:GIFHasExtension+LOC:ColorTableLen+10)]
                  IF BAND(10000000b,LOC:ColorTableLenByte) THEN
                     LOC:ColorTableLenByte =  BSHIFT(GIFRecord.GIFColorTableStreem[(LOC:GIFHasExtension+LOC:ColorTableLen+10)],5)
                     LOC:ColorTableLenByte =  BSHIFT(LOC:ColorTableLenByte,-5)
                     pImage.ColorTableLen = LOC:ColorTableLenByte
                     LOC:GIFBlockSizePos=LOC:GIFHasExtension+LOC:ColorTableLen+11+(3 * (2^(LOC:ColorTableLenByte+1)))
                     pImage.ColorTableStart = 14+LOC:ColorTableLen+LOC:GIFHasExtension+11
                  ELSE
                     LOC:GIFBlockSizePos=LOC:ColorTableLen+11+LOC:GIFHasExtension
                     pImage.ColorTableStart = 14
                  END
                     !ONLY GIF THAT START ENCODING WITH CODE BLOCK=8 are suported by PDF
                     IF GIFRecord.GIFColorTableStreem[(LOC:GIFBlockSizePos)]=CHR(8)
                     !LZW inital code size must be 9
                        pImage.Type = 2          !-GIF
                        pImage.Width   = GIFRecord.GIFWidth
                        pImage.Height  = GIFRecord.GIFHeight
                        pImage.StreemStart = LOC:GIFBlockSizePos+1+12
                     END
               END
         ELSE
            IF PNGRecord.PNGIdentifier[1]=137 AND |
               PNGRecord.PNGIdentifier[2]=80  AND |
               PNGRecord.PNGIdentifier[3]=78  AND |
               PNGRecord.PNGIdentifier[4]=71  AND |
               PNGRecord.PNGIdentifier[5]=13  AND |
               PNGRecord.PNGIdentifier[6]=10  AND |
               PNGRecord.PNGIdentifier[7]=26  AND |
               PNGRecord.PNGIdentifier[8]=10  THEN

               LOC:FlipUlong=PNGRecord.PNGChunkLen
               Do FlipUlong
               PNGRecord.PNGChunkLen=LOC:FlipUlong

               LOC:FlipUlong=PNGRecord.PNGHeight
               Do FlipUlong
               PNGRecord.PNGHeight=LOC:FlipUlong

               LOC:FlipUlong=PNGRecord.PNGWidth
               Do FlipUlong
               PNGRecord.PNGWidth=LOC:FlipUlong

               IF PNGRecord.PNGInterlace_method=0 THEN
               !Only non interlace PNG are suported
                  IF BAND(PNGRecord.PNGColor_type,4)<>4 THEN
                        !valid only if it's notinterlaced, is not 16 bit
                        !per colour component and the fourth colour is not the alpha channel
                        IF PNGRecord.PNGInterlace_method=0 AND PNGRecord.PNGColor_type<=3 AND PNGRecord.PNGBit_depth<16 THEN
                           pImage.Type = 3      !-PNG
                           pImage.Bit_depth  = PNGRecord.PNGBit_depth
                           pImage.Color_type = PNGRecord.PNGColor_type
                           pImage.Width      = PNGRecord.PNGWidth
                           pImage.Height     = PNGRecord.PNGHeight
                        END
                  END
               END
            END
         END
         !3-PNG 4-BMP
      END
   END

   CLOSE(LOC:ImageInfo)

FlipUlong   ROUTINE
   LOC:FlipUlongAux = LOC:GFlipUlong.LOC:GFlipUlong1
   LOC:GFlipUlong.LOC:GFlipUlong1=LOC:GFlipUlong.LOC:GFlipUlong4
   LOC:GFlipUlong.LOC:GFlipUlong4=LOC:FlipUlongAux
   LOC:FlipUlongAux = LOC:GFlipUlong.LOC:GFlipUlong2
   LOC:GFlipUlong.LOC:GFlipUlong2=LOC:GFlipUlong.LOC:GFlipUlong3
   LOC:GFlipUlong.LOC:GFlipUlong3=LOC:FlipUlongAux

PDFGeneratorClass.DrawImage   PROCEDURE(LONG XPos,LONG YPos,LONG pWidth ,LONG pHeight,STRING pFileName)
LOC:I       LONG
LOC:FoundImage BYTE
LOC:W       LONG
LOC:H       LONG
 CODE
     IF NOT CLIP(pFileName) THEN RETURN.
     !Store the image into the queue
     !later in the close document method all the image will be written together
     !Only one copy for each image is stored
     LOC:FoundImage = False
     LOOP LOC:I=1 TO RECORDS(SELF.Images)
          GET(SELF.Images,LOC:I)
          IF NOT ERRORCODE() THEN
             IF CLIP(UPPER(pFileName))=CLIP(UPPER(SELF.Images.FileName)) THEN
                LOC:FoundImage = True
                BREAK
             END
          END
     END
     IF LOC:FoundImage = False THEN
        SELF.ImageNo+=1
        SELF.Images.ImageNo  = SELF.ImageNo
        SELF.Images.ObjectNo = 0
        SELF.Images.FileName = pFileName
        
        SELF.GetImageInfo(SELF.Images)
        
        IF SELF.Images.Type=0 THEN
           RETURN
        END
        ADD(SELF.Images)
     END
     !Write the reference into the stream

     IF pWidth THEN
        LOC:W = SELF.Images.Width  * ((pWidth/(8500/612))/SELF.Images.Width)
     ELSE
        LOC:W = SELF.Images.Width
     END
     IF pHeight THEN
        LOC:H = SELF.Images.Height * ((pHeight/(8500/612))/SELF.Images.Height)
     ELSE
        LOC:H = SELF.Images.Height
     END
     SELF.OpenImage()

     SELF.Output.WriteStr('q')
     SELF.Output.WriteStr(' '&LOC:W&' 0 0 '&LOC:H&' '&(XPos/(8500/612))&' '&((SELF.PageHeight-YPos/(8500/612))-LOC:H)&' cm')
     SELF.Output.WriteStr(' /Im'&SELF.Images.ImageNo&' Do')
     SELF.Output.WriteLine(' Q')

PDFGeneratorClass.GetTextWidth  PROCEDURE(STRING pText)
LOC:I                           SHORT
LOC:DC                          UNSIGNED, AUTO
LOC:HFont                       UNSIGNED, AUTO
LOC:CharSize                    LIKE(winSizeType)
LOC:CharToTest                  STRING(1)
LOC:OLDMAPMODE                  ULONG
LOC:FontName                    CSTRING(65)
  CODE
     GET(SELF.FontsNames,SELF.ActualFontNumber)
     IF NOT ERRORCODE()
        LOC:FontName = CLIP(SELF.FontsNames.RealName)
        IF NOT SELF.FontsNames.BuiltIn THEN
           IF NOT SELF.DC
              SELF.DC = CreateCompatibleDC(0)
           END
           LOC:DC = SELF.DC
           IF LOC:DC THEN
              LOC:OLDMAPMODE=SetMapMode(LOC:DC,1)
                LOC:HFont = CreateFont(-((SELF.PointSize*10 *GetDeviceCaps(LOC:DC, 90))/72), |
                 0, 0, 0,|
                 0, |
                                      choose(band(SELF.FontsNames.Style, FONT:italic)),|
                                      choose(band(SELF.FontsNames.Style, FONT:underline)),|
                                      choose(band(SELF.FontsNames.Style, FONT:strikeout)),|
                 1,|
                 0,|
                 0,|
                 2, 0,LOC:FontName)
              LOC:OLDMAPMODE=SetMapMode(LOC:DC,LOC:OLDMAPMODE)
              IF LOC:HFont THEN
                 IF SelectObject(LOC:DC, LOC:HFont) THEN
                    IF GetTextExtentPoint32(LOC:DC,pText, LEN(pText),LOC:CharSize)<>0 THEN
                       RETURN LOC:CharSize.eW
                    END
                 END
                 DeleteObject(LOC:HFont)
              END
           END
        END
     END
     RETURN 0

PDFGeneratorClass.DrawText    PROCEDURE(LONG XPos,LONG YPos,STRING pText,LONG ClipXPos=0 ,LONG ClipYPos=0,LONG ClipWidth=0 ,LONG ClipHeight=0)
LOC:SEN  REAL
LOC:COS  REAL                    
X        REAL,AUTO
Y        REAL,AUTO
XP       REAL,AUTO
YP       REAL,AUTO
A        REAL,AUTO
W        REAL
H        REAL
 CODE
     IF SELF.FontAngle
        W = SELF.GetTextWidth(pText)
        A = CHOOSE(INRANGE(SELF.FontAngle,180,360),(SELF.FontAngle-180),(SELF.FontAngle+180))*0.0174532925199
        X = COS(A)*(W/2)
        Y = SIN(A)*(W/2)
        XP = SIN(A)*(SELF.PointSize)
        YP = COS(A)*(SELF.PointSize)
     ELSE
        X = 0
        Y = 0
        XP = 0
        YP = -SELF.PointSize
     END
     IF ClipWidth OR ClipHeight THEN
        SELF.OpenText(ClipXPos,ClipYPos,ClipWidth ,ClipHeight)
     ELSE
        SELF.OpenText()
     END

     SELF.Output.WriteLine('/F'&SELF.ActualFontNumber&' '&SELF.PointSize&' Tf')

     SELF.DrawSetColor(SELF.FontColor.Red,SELF.FontColor.Green,SELF.FontColor.Blue,'rg')

     !The angle is stored in degrees and need to be converted in radians to be used in the COS&SIN functions
     SELF.Output.WriteLine(ROUND(COS(SELF.FontAngle*(0.0174532925199)),0.001)&' '&|
                           ROUND(SIN(SELF.FontAngle*(0.0174532925199)),0.001)&' '&|
                           ROUND(SIN(-(SELF.FontAngle*(0.0174532925199))),0.001)&' '&|
                           ROUND(COS(-(SELF.FontAngle*(0.0174532925199))),0.001)&' '&|
                           ABS(((XPos+X)/(8500/612))-XP)&' '&(SELF.PageHeight-ABS(((YPos-Y)/(8500/612))-YP))&' Tm ('&SELF.EscapeValues(pText)&') Tj')
     SELF.DrawSetTextAngle(0)

PDFGeneratorClass.EscapeValues            PROCEDURE(STRING pValue)
CharToReplace   STRING(1)
ReplacedBy      STRING(10)
LenReplacedBy   SHORT
lIndex          SHORT
lLastIndex      SHORT

lSLen           SHORT
lOriginalSLen   SHORT
lReplaced       BYTE
SAux1           &STRING
SAux2           &STRING

 CODE

    SAux1 &= SELF.ppScapedString

    IF NOT SAux1 &= NULL
       DISPOSE(SAux1)
    END

    lSLen = LEN(pValue)
    lOriginalSLen = lSLen
    SAux1 &= NEW(STRING(lSLen+20))
    SAux1 = pValue

    CharToReplace= '\'
    ReplacedBy   = '\\'
    LenReplacedBy= 2
    Do ReplaceOneChar

    CharToReplace= '('
    ReplacedBy   = '\('
    LenReplacedBy= 2
    Do ReplaceOneChar

    CharToReplace= ')'
    ReplacedBy   = '\)'
    LenReplacedBy= 2
    Do ReplaceOneChar

    SELF.ppScapedString &= SAux1
    RETURN SAux1[1:lSLen]

ReplaceOneChar   ROUTINE
    lLastIndex = 1
    LOOP
       lIndex = INSTRING(CharToReplace,SAux1,1,lLastIndex)
       IF lIndex THEN
          lReplaced = True
          IF CharToReplace='\'
             IF lSLen-lIndex>=2
                IF SAux1[(lIndex):(lIndex+1)]='\)' OR SAux1[(lIndex):(lIndex+3)]='\(' OR SAux1[(lIndex):(lIndex+3)]='\\'
                   lReplaced = False
                   lLastIndex=lIndex+3
                END
             END
          END
          IF lReplaced
             IF (lSLen+LenReplacedBy)>(lOriginalSLen+20) THEN
                SAux2 &= NEW(STRING(lSLen+500))
                SAux2 = ''
                SAux2 = SAux1[1:lSLen]
                DISPOSE(SAux1)
                SAux1 = SAux2[1:lSLen]
                DISPOSE(SAux2)
             END
             SAux1 = SAux1[1:(lIndex-1)] & ReplacedBy[1:LenReplacedBy] & SAux1[(lIndex+1):(lSLen)]
             lSLen += LenReplacedBy
             lLastIndex=lIndex+LenReplacedBy
          END
       ELSE
          BREAK
       END
    END

PDFGeneratorClass.CalculateCubicBezier PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height,REAL alpha,REAL beta,*LONG X,*LONG Y,*LONG X0,*LONG Y0,*LONG X1,*LONG Y1,*LONG X2,*LONG Y2,*LONG X3,*LONG Y3)
lAlpha   REAL !START ANGLE 1
lBeta    REAL !START ANGLE 2
A        LONG !Radius V
B        LONG !Radius H
BCP      REAL
SIN_LALPHA   REAL
COS_LALPHA   REAL
SIN_LBETA    REAL
COS_LBETA    REAL
 CODE
    X = (XPos+Width/2)/(8500/612)
    Y = SELF.PageHeight-(YPos+Height/2)/(8500/612)
    a = Width/(8500/612) /2
    b = Height/(8500/612)/2
    lAlpha = alpha * 3.1415926535898 / 180
    lBeta  = beta * 3.1415926535898 / 180
    bcp = (4.0/3 * (1-COS((lbeta-lalpha)/2)) / SIN((lbeta - lalpha)/2))
    SIN_LALPHA = SIN(lalpha)
    COS_LALPHA = COS(lalpha)
    SIN_LBETA  = SIN(lbeta)
    COS_LBETA  = COS(lbeta)
    X0 = X + A * COS_lAlpha
    Y0 = Y + B * SIN_lAlpha
    X1 = X + A * (COS_lAlpha - BCP * SIN_lAlpha)
    Y1 = Y + B * (SIN_lAlpha + BCP * COS_lAlpha)
    X2 = X + A * (COS_lBeta + BCP * SIN_lBeta)
    Y2 = Y + B * (SIN_lBeta - BCP * COS_lBeta)
    X3 = X + A * COS_lBeta
    Y3 = Y + B * SIN_lBeta

PDFGeneratorClass.DrawPieSlice         PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height,REAL alpha,REAL beta,LONG Fill=-1)
X   LONG !Center of the ellipse
Y   LONG !Center of the ellipse
X0      LONG
Y0      LONG
X1      LONG
Y1      LONG
X2      LONG
Y2      LONG
X3      LONG
Y3      LONG
 CODE
    SELF.OpenImage()
    IF Fill>-1 THEN
       SELF.DrawSetFillColor(Fill)
    END
    SELF.CalculateCubicBezier(XPos,YPos,Width ,Height,alpha,beta,X,Y,X0,Y0,X1,Y1,X2,Y2,X3,Y3)

    SELF.Output.WriteLine(X&' '&Y&' m')
    SELF.Output.WriteLine(X0&' '&Y0&' l')
    SELF.Output.WriteLine(X1&' '&Y1&' '&X2&' '&Y2&' '&X3&' '&Y3&' c')
    SELF.Output.WriteLine(X&' '&Y&' l')
    IF Fill=-1 THEN
       SELF.Output.WriteLine('s')
    ELSE
       SELF.Output.WriteLine('B')
    END

PDFGeneratorClass.DrawArc PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height,REAL alpha,REAL beta)
X   LONG !Center of the ellipse
Y   LONG !Center of the ellipse
X0      LONG
Y0      LONG
X1      LONG
Y1      LONG
X2      LONG
Y2      LONG
X3      LONG
Y3      LONG

 CODE
    SELF.OpenImage()
    SELF.CalculateCubicBezier(XPos,YPos,Width ,Height,alpha,beta,X,Y,X0,Y0,X1,Y1,X2,Y2,X3,Y3)

    SELF.Output.WriteLine(X0&' '&Y0&' m')
    SELF.Output.WriteLine(X1&' '&Y1&' '&X2&' '&Y2&' '&X3&' '&Y3&' c')
    SELF.Output.WriteLine('s')


PDFGeneratorClass.DrawEllipse PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height,LONG Fill=0)
X   LONG !Center of the ellipse
Y   LONG !Center of the ellipse
X0      LONG
Y0      LONG
X1      LONG
Y1      LONG
X2      LONG
Y2      LONG
X3      LONG
Y3      LONG

 CODE
    SELF.OpenImage()
    IF Fill>-1 THEN
       SELF.DrawSetFillColor(Fill)
    END
    SELF.CalculateCubicBezier(XPos,YPos,Width ,Height,0,90,X,Y,X0,Y0,X1,Y1,X2,Y2,X3,Y3)
    SELF.Output.WriteLine(X0&' '&Y0&' m')
    SELF.Output.WriteLine(X1&' '&Y1&' '&X2&' '&Y2&' '&X3&' '&Y3&' c')
    SELF.CalculateCubicBezier(XPos,YPos,Width ,Height,90,180,X,Y,X0,Y0,X1,Y1,X2,Y2,X3,Y3)
    SELF.Output.WriteLine(X1&' '&Y1&' '&X2&' '&Y2&' '&X3&' '&Y3&' c')
    SELF.CalculateCubicBezier(XPos,YPos,Width ,Height,180,270,X,Y,X0,Y0,X1,Y1,X2,Y2,X3,Y3)
    SELF.Output.WriteLine(X1&' '&Y1&' '&X2&' '&Y2&' '&X3&' '&Y3&' c')
    SELF.CalculateCubicBezier(XPos,YPos,Width ,Height,270,360,X,Y,X0,Y0,X1,Y1,X2,Y2,X3,Y3)
    SELF.Output.WriteLine(X1&' '&Y1&' '&X2&' '&Y2&' '&X3&' '&Y3&' c')
    IF Fill=-1 THEN
       SELF.Output.WriteLine('s')
    ELSE
       SELF.Output.WriteLine('B')
    END

PDFGeneratorClass.DrawLine    PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height)
 CODE
   SELF.OpenImage()
   SELF.LastXPos=(XPos/(8500/612))
   SELF.LastYPos=(SELF.PageHeight-(YPos/(8500/612)))
   SELF.Output.WriteLine((XPos/(8500/612))&' '&(SELF.PageHeight-(YPos/(8500/612)))&' m')
   SELF.Output.WriteLine((XPos/(8500/612))+(Width/(8500/612))&' '&(SELF.PageHeight-(YPos/(8500/612)))-(Height/(8500/612))&' l')
   SELF.Output.WriteLine('s')

PDFGeneratorClass.DrawBox     PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height,LONG Fill=-1)
 CODE
   SELF.OpenImage()
   SELF.LastXPos=(XPos/(8500/612))
   SELF.LastYPos=(SELF.PageHeight-(YPos/(8500/612)))
   IF Fill>-1 THEN
      SELF.DrawSetFillColor(Fill)
   END
   SELF.Output.WriteLine((XPos/(8500/612))&' '&(SELF.PageHeight-(YPos/(8500/612)))&' '&(Width/(8500/612))&' '&-(Height/(8500/612))&' re')
   IF Fill=-1 THEN
      SELF.Output.WriteLine('s')
   ELSE
      SELF.Output.WriteLine('B')
   END

PDFGeneratorClass.DrawPolygon          PROCEDURE(LONG Fill=-1,LONG PenColor=0,LONG PenWidth=1,LONG PenStyle=0)
 CODE
   FREE(SELF.PolyPoint)
   SELF.PolygonColor   = Fill
   SELF.PolygonPenColor= PenColor
   SELF.PolygonPenWidth= PenWidth
   SELF.PolygonPenStyle= PenStyle
   SELF.InPolygon = True

PDFGeneratorClass.DrawPolygonCorner    PROCEDURE(LONG XPos,LONG YPos)
 CODE
    IF SELF.InPolygon = True THEN
       SELF.PolyPoint.XPos = XPos
       SELF.PolyPoint.YPos = YPos
       ADD(SELF.PolyPoint)
    END

PDFGeneratorClass.DrawPolygonClose     PROCEDURE()
lIndex  SHORT
 CODE
    IF SELF.InPolygon = True THEN
       SELF.InPolygon = False
       SELF.OpenImage()
       GET(SELF.PolyPoint,1)
       IF NOT ERRORCODE() THEN
          IF SELF.PolygonColor<>-1 THEN
             SELF.DrawSetPenStyle(SELF.PolygonPenStyle)
             SELF.DrawSetPenWidth(SELF.PolygonPenWidth)
             SELF.DrawSetPenColor(SELF.PolygonPenColor)
             SELF.DrawSetFillColor(SELF.PolygonColor)
          END
          SELF.Output.WriteLine((SELF.PolyPoint.XPos/(8500/612))&' '&(SELF.PageHeight-(SELF.PolyPoint.YPos/(8500/612)))&' m')
          SELF.LastXPos=(SELF.PolyPoint.XPos/(8500/612))
          SELF.LastYPos=(SELF.PageHeight-(SELF.PolyPoint.YPos/(8500/612)))
          LOOP lIndex=2 TO RECORDS(SELF.PolyPoint)
               GET(SELF.PolyPoint,lIndex)
               IF ERRORCODE() THEN BREAK.
               SELF.LastXPos=(SELF.PolyPoint.XPos/(8500/612))
               SELF.LastYPos=(SELF.PageHeight-(SELF.PolyPoint.YPos/(8500/612)))
               SELF.Output.WriteLine((SELF.PolyPoint.XPos/(8500/612))&' '&(SELF.PageHeight-(SELF.PolyPoint.YPos/(8500/612)))&' l')
          END
          SELF.Output.WriteLine('h')
          IF SELF.PolygonColor<>-1 THEN
             SELF.Output.WriteLine('B')
          END
       END
       FREE(SELF.PolyPoint)
    END

PDFGeneratorClass.DrawSetPenStyle PROCEDURE(LONG pClarionStyle=0)
 CODE
   IF SELF.ObjPenStyle=SELF.CurObj AND SELF.PenStyle = pClarionStyle
      RETURN
   END
   SELF.OpenImage(False)
   SELF.PenStyle = pClarionStyle
   SELF.ObjPenStyle=SELF.CurObj

   CASE pClarionStyle
   OF PEN:dashdot       !Mixed dashes and dots
      SELF.Output.WriteLine('[3 2 1 2] 0 d')
   OF PEN:solid
   OROF 0        !Solid line
      SELF.Output.WriteLine('[] 0 d')
   OF PEN:dash          !Dashed line
      SELF.Output.WriteLine('[3] 3 d')
   OF PEN:dot           !Dotted line
      SELF.Output.WriteLine('[1] 1 d')
   ELSE
      SELF.Output.WriteLine('[] 0 d')
   END


PDFGeneratorClass.DrawSetPenColor PROCEDURE(LONG pClarionColor)
LOC:Blue              REAL
LOC:Green             REAL
LOC:Red               REAL
 CODE
   SELF.GenerateRGB(pClarionColor,LOC:Red,LOC:Green,LOC:Blue)

   IF SELF.ObjPenColor=SELF.CurObj AND (SELF.PenColor.Red = LOC:Red AND SELF.PenColor.Green = LOC:Green AND SELF.PenColor.Blue = LOC:Blue)
      RETURN
   END

   SELF.OpenImage(False)
   SELF.ObjPenColor=SELF.CurObj

   SELF.PenColor.Red   =LOC:Red
   SELF.PenColor.Green =LOC:Green
   SELF.PenColor.Blue  =LOC:Blue
   SELF.DrawSetColor(LOC:Red,LOC:Green,LOC:Blue,'RG')

PDFGeneratorClass.DrawSetFillColor PROCEDURE(LONG pClarionColor)
LOC:Blue              REAL
LOC:Green             REAL
LOC:Red               REAL
 CODE
   SELF.GenerateRGB(pClarionColor,LOC:Red,LOC:Green,LOC:Blue)

   IF SELF.ObjFillColor=SELF.CurObj AND (SELF.FillColor.Red = LOC:Red AND SELF.FillColor.Green = LOC:Green AND SELF.FillColor.Blue = LOC:Blue)
      RETURN
   END

   SELF.OpenImage(False)
   SELF.ObjFillColor=SELF.CurObj

   SELF.FillColor.Red   =LOC:Red
   SELF.FillColor.Green =LOC:Green
   SELF.FillColor.Blue  =LOC:Blue

   SELF.DrawSetColor(LOC:Red,LOC:Green,LOC:Blue,'rg')

PDFGeneratorClass.DrawSetColor PROCEDURE(REAL pRed,REAL pGreen,REAL pBlue,STRING pType)
 CODE
   SELF.Output.WriteLine(pRed&' '&pGreen&' '&pBlue&' '&CLIP(pType))

PDFGeneratorClass.DrawSetFontColor PROCEDURE(LONG pClarionColor)
LOC:Blue              REAL
LOC:Green             REAL
LOC:Red               REAL
 CODE
   SELF.GenerateRGB(pClarionColor,LOC:Red,LOC:Green,LOC:Blue)
   IF SELF.ObjFontColor=SELF.CurObj AND (SELF.FontColor.Red = LOC:Red AND SELF.FontColor.Green = LOC:Green AND SELF.FontColor.Blue = LOC:Blue)
      RETURN
   END
   SELF.ObjFontColor=SELF.CurObj

   SELF.FontColor.Red   =LOC:Red
   SELF.FontColor.Green =LOC:Green
   SELF.FontColor.Blue  =LOC:Blue

PDFGeneratorClass.DrawSetPenWidth PROCEDURE(LONG pWidth)
 CODE
   IF SELF.ObjPenWidth=SELF.CurObj AND SELF.PenWidth = pWidth
      RETURN
   END
   SELF.OpenImage(False)
   SELF.PenWidth = pWidth
   SELF.ObjPenWidth=SELF.CurObj
                                 
   SELF.Output.WriteLine(ROUND(pWidth/8.3774250440917107583774250440917,0.001)&' w')

PDFGeneratorClass.DrawSetTextAngle PROCEDURE(SHORT FontAngle)
 CODE
    SELF.FontAngle = FontAngle

PDFGeneratorClass.DrawSetFontSize PROCEDURE(BYTE pFontSize)
 CODE
    SELF.PointSize = pFontSize
    SELF.ObjFontSize=SELF.CurObj

PDFGeneratorClass.DrawSetFont PROCEDURE(STRING pFontName,BYTE pFontSize=0,BYTE pBold=0,BYTE pItalic=0)
LOC:I       BYTE
LOC:F       BYTE
LOC:Font    STRING(32)
LOC:OrinalFont STRING(32)
LOC:Internal BYTE
 CODE
    LOC:F = False

    LOC:Font=SELF.GetFontTranslation(CLIP(pFontName),pBold,pItalic)
    IF CLIP(LOC:Font)
        LOC:Internal = True
        LOC:OrinalFont = LOC:Font
    ELSE
        LOC:Internal = False
        LOC:OrinalFont = CLIP(pFontName)
        IF pItalic AND pBold
           LOC:Font = CLIP(pFontName)&',BoldItalic'
        ELSE
           IF pItalic
              LOC:Font = CLIP(pFontName)&',Italic'
           ELSE
              IF pBold
                 LOC:Font = CLIP(pFontName)&',Bold'
              ELSE
                 LOC:Font = CLIP(pFontName)
              END
           END
        END
    END
    LOOP LOC:I=1 TO RECORDS(SELF.FontsNames)
         GET(SELF.FontsNames,LOC:I)
         IF NOT ERRORCODE()
            IF CLIP(UPPER(SELF.FontsNames.Name))=CLIP(UPPER(LOC:Font))
               LOC:F = True
               BREAK
            END
         END
    END
    IF LOC:F= False THEN
       SELF.FontsNames.Name    =LOC:Font
       SELF.FontsNames.RealName=LOC:OrinalFont
       SELF.FontsNames.Number  =RECORDS(SELF.FontsNames)+1
       SELF.FontsNames.Style   =CHOOSE(pBold,FONT:Bold,0)+CHOOSE(pItalic,FONT:italic,0)
       SELF.FontsNames.BuiltIn =LOC:Internal
       SELF.FontsNames.ObjectNo=0
       SELF.FontsNames.FirstChar=0
       SELF.FontsNames.LastChar =0
       LOOP LOC:I=1 to 255
            SELF.FontsNames.CharWidth[LOC:I] =0
       END

       ADD(SELF.FontsNames)
    END
    IF SELF.ObjFontNumber=SELF.CurObj AND SELF.ObjFontNumber=SELF.CurObj AND pFontSize=SELF.PointSize AND SELF.ActualFontNumber = SELF.FontsNames.Number
       RETURN
    END

    IF pFontSize<>0 THEN
      SELF.DrawSetFontSize(pFontSize)
    END

    SELF.ObjFontNumber=SELF.CurObj
    
    SELF.ActualFontNumber = SELF.FontsNames.Number

PDFGeneratorClass.DrawSetFontByNumber PROCEDURE(BYTE pFontNumber)
 CODE
    IF pFontNumber>0 AND pFontNumber<=RECORDS(SELF.FontsNames) THEN
       IF SELF.ObjFontNumber=SELF.CurObj AND SELF.ActualFontNumber = SELF.FontsNames.Number
          RETURN
       END
       SELF.ActualFontNumber = pFontNumber
       SELF.ObjFontNumber    = SELF.CurObj
       SELF.Output.WriteLine('/F'&pFontNumber&' '&SELF.PointSize&' Tf')
    ELSE
       SELF.DrawSetFont('Helvetica')
    END

!********************************************
PDFGeneratorClass.GenerateRGB PROCEDURE(LONG pClarionColor,*REAL pRed,*REAL pGreen,*REAL pBlue)
LOC:ClarionColor  LONG
LOC:GClarionColor GROUP,OVER(LOC:ClarionColor)
Red               BYTE
Green             BYTE
Blue              BYTE
NotUsed           BYTE
                  END
RBlue             REAL
RGreen            REAL
RRed              REAL
   CODE
       LOC:ClarionColor = pClarionColor
       pRed=LOC:GClarionColor.Red
       pGreen=LOC:GClarionColor.Green
       pBlue=LOC:GClarionColor.Blue
       pRed=pRed/255
       pGreen=pGreen/255
       pBlue=pBlue/255
       pRed=ROUND(pRed,0.001)
       pGreen=ROUND(pGreen,0.001)
       pBlue=ROUND(pBlue,0.001)

PDFGeneratorClass.AddAllBookMark          PROCEDURE()
LOC:I       LONG
LOC:X       LONG
LOC:First   LONG
LOC:Last    LONG
LOC:FirstBookMarkObj LONG
LOC:Level   LONG
LOC:ParentOrder LONG
LOC:OrderByLevel LONG
  CODE
     LOC:Last = 0
     LOC:First = 0
     LOC:FirstBookMarkObj = SELF.CurObj
     LOC:Level = 1
     LOC:OrderByLevel=0
     SORT(SELF.BookMarks,SELF.BookMarks.Level,SELF.BookMarks.Order)
     LOOP LOC:I=1 TO RECORDS(SELF.BookMarks)
          GET(SELF.BookMarks,LOC:I)
          IF NOT ERRORCODE() THEN
             LOC:OrderByLevel+=1
             SELF.BookMarks.OrderByLevel=LOC:OrderByLevel
             LOC:Level = SELF.BookMarks.Level
             SELF.Locations.ObjectNo = SELF.BookMarks.Order+LOC:FirstBookMarkObj
             SELF.Locations.Position = SELF.Output.FPos
             ADD(SELF.Locations)
             SELF.BookMarks.ObjectNo = SELF.Locations.ObjectNo
             IF LOC:First = 0 THEN
                LOC:First = SELF.BookMarks.ObjectNo
             END
             SELF.Output.WriteLine(SELF.BookMarks.ObjectNo&' 0 obj '&CHR(60)&CHR(60))
             IF SELF.BookMarks.Parent THEN
                LOC:ParentOrder = SELF.BookMarks.Parent
                SELF.BookMarks.Parent = SELF.BookMarks.Parent+LOC:FirstBookMarkObj
             ELSE
                SELF.BookMarks.Parent = 5
             END
             SELF.Output.WriteLine('/Parent '&SELF.BookMarks.Parent&' 0 R')
             IF SELF.BookMarks.First THEN
                SELF.BookMarks.First = SELF.BookMarks.First + LOC:FirstBookMarkObj
                SELF.Output.WriteLine('/First '&SELF.BookMarks.First&' 0 R')
             END
             IF SELF.BookMarks.Last THEN
                SELF.BookMarks.Last = SELF.BookMarks.Last + LOC:FirstBookMarkObj
                SELF.Output.WriteLine('/Last '&SELF.BookMarks.Last&' 0 R')
             END
             PUT(SELF.BookMarks)
             SELF.PageObs.Number = SELF.BookMarks.Dest
             GET(SELF.PageObs,SELF.PageObs.Number)
             SELF.Output.WriteStr('/Dest ['&SELF.PageObs.ObjectNo&' 0 R /XYZ')
             IF SELF.BookMarks.XPos THEN
                SELF.Output.WriteStr(' '&SELF.BookMarks.XPos)
             ELSE
                SELF.Output.WriteStr(' null')
             END
             IF SELF.BookMarks.YPos THEN
                SELF.Output.WriteStr(' '&SELF.PageHeight-ABS(SELF.BookMarks.YPos))
             ELSE
                SELF.Output.WriteStr(' null')
             END
             SELF.Output.WriteLine(' null]')
             SELF.Output.WriteLine('/Title ('&CLIP(SELF.BookMarks.Name)&')')
             GET(SELF.BookMarks,LOC:I+1)
             IF NOT ERRORCODE() THEN
                IF SELF.BookMarks.Level = LOC:Level AND LOC:ParentOrder = SELF.BookMarks.Parent THEN
                   SELF.Output.WriteLine('/Next '&SELF.BookMarks.Order+LOC:FirstBookMarkObj&' 0 R')
                END
             END
             SELF.Output.WriteLine('>>')
             SELF.Output.WriteLine('endobj')
             SELF.CurObj += 1
        END
     END
     SELF.Locations.ObjectNo = 5
     SELF.Locations.Position = SELF.Output.FPos
     ADD(SELF.Locations)
     SELF.Output.WriteLine('5 0 obj')
     SELF.Output.WriteLine(CHR(60)&CHR(60)&' ')
     SELF.Output.WriteLine('/Type /Outlines')
     SELF.Output.WriteLine('/Count '&RECORDS(SELF.BookMarks))
     IF LOC:First THEN
        LOC:Last = SELF.BookMarks.ObjectNo
     SELF.Output.WriteLine('/First '&LOC:First&' 0 R')
     SELF.Output.WriteLine('/Last '&LOC:Last&' 0 R')
     END
     SELF.Output.WriteLine('>> ')
     SELF.Output.WriteLine('endobj')

PDFGeneratorClass.AddBookMark          PROCEDURE(LONG XPos,LONG YPos,STRING BookMarkName,<STRING BookMarkParent>)
LOC:I       LONG
LOC:Parent  LONG
LOC:ParentLevel LONG
lBookMarkParentName  STRING(50)
  CODE
    LOC:Parent = 0
    LOC:ParentLevel = 0
    IF OMITTED(5) THEN
       IF SELF.PagesAsParentBookmark THEN
          lBookMarkParentName = CLIP(SELF.BasePageBookmarkName)&SELF.PageNo
       ELSE
          lBookMarkParentName = ''
       END
    ELSE
       IF lBookMarkParentName = '' THEN
          IF SELF.PagesAsParentBookmark THEN
             lBookMarkParentName = CLIP(SELF.BasePageBookmarkName)&SELF.PageNo
          END
       END
    END
    IF CLIP(lBookMarkParentName) THEN
       LOOP LOC:I=1 TO RECORDS(SELF.BookMarks)
            GET(SELF.BookMarks,LOC:I)
            IF NOT ERRORCODE() THEN
               IF UPPER(CLIP(lBookMarkParentName))=UPPER(CLIP(SELF.BookMarks.Name)) THEN
                  LOC:Parent = LOC:I
                  SELF.BookMarks.Last  = RECORDS(SELF.BookMarks)+1
                  IF SELF.BookMarks.First = 0 THEN
                     SELF.BookMarks.First = SELF.BookMarks.Last
                  END
                  SELF.BookMarks.Count -=1
                  LOC:ParentLevel = SELF.BookMarks.Level
                  PUT(SELF.BookMarks)
               END
            END
       END
    END
    IF XPos=0 THEN XPos=1.
    IF YPos=0 THEN YPos=1.
    SELF.BookMarks.Count          = 0
    SELF.BookMarks.Dest           = SELF.PageNo
    SELF.BookMarks.XPos           = (XPos/(8500/612))
    SELF.BookMarks.YPos           = (YPos/(8500/612))
    SELF.BookMarks.Name           = CLIP(BookMarkName)
    SELF.BookMarks.Order          = RECORDS(SELF.BookMarks)+1
    SELF.BookMarks.First          = 0
    SELF.BookMarks.Last           = 0
    SELF.BookMarks.Parent         = LOC:Parent
    SELF.BookMarks.Level          = LOC:ParentLevel+1
    SELF.BookMarks.ObjectNo       = 0
    ADD(SELF.BookMarks)

PDFGeneratorClass.AddBookMark          PROCEDURE(STRING BookMarkName,<STRING BookMarkParent>)
  CODE
    IF OMITTED(3) THEN
       SELF.AddBookMark( 0, 0, BookMarkName)
    ELSE
       SELF.AddBookMark( 0, 0, BookMarkName,BookMarkParent)
    END

PDFGeneratorClass.DrawImageLink       PROCEDURE(LONG XPos,LONG YPos,LONG Width,LONG Height,STRING pImage,BYTE pType,STRING pDest,<STRING pPar>)
 CODE
    SELF.PageHyperLinks.Text = ''
    IF OMITTED(9) THEN
       SELF.DrawRegionLink(XPos,YPos,Width,Height,pType,pDest)
    ELSE
       SELF.DrawRegionLink(XPos,YPos,Width,Height,pType,pDest,pPar)
    END
    SELF.DrawImage(XPos,YPos,Width,Height,pImage)

PDFGeneratorClass.DrawRegionLink       PROCEDURE(LONG XPos,LONG YPos,LONG Width,LONG Height,BYTE pType,STRING pDest,<STRING pPar>)
LOC:Index   LONG
LOC:Index2  LONG
 CODE

    SELF.PageHyperLinks.Boxed    = SELF.HyperLinkBoxed
    SELF.PageHyperLinks.BoxColor = SELF.HyperLinkBoxColor

    SELF.PageHyperLinks.XPos = (XPos/(8500/612))
    SELF.PageHyperLinks.YPos = (YPos/(8500/612))
    SELF.PageHyperLinks.Width = (Width/(8500/612))
    SELF.PageHyperLinks.Height = (Height/(8500/612))

    SELF.PageHyperLinks.Dest = pDest
    SELF.PageHyperLinks.Type = pType

    IF OMITTED(8) THEN
       SELF.PageHyperLinks.Parameters = ''
    ELSE
       IF pType=PDFHLType:Command THEN
          pPar=CLIP(LEFT(pPar))
          LOC:Index2=1
          SELF.PageHyperLinks.Parameters=''
          LOOP LOC:Index=1 TO LEN(CLIP(LEFT(pPar)))
               IF pPar[LOC:Index]='\' THEN
                  SELF.PageHyperLinks.Parameters[(LOC:Index2)] = '\'
                  LOC:Index2+=1
               END
               SELF.PageHyperLinks.Parameters[(LOC:Index2)] = pPar[LOC:Index]
               LOC:Index2+=1
          END
       ELSE
          SELF.PageHyperLinks.Parameters = CLIP(LEFT(pPar))
       END
    END

    IF pType=PDFHLType:Command THEN
       pDest=CLIP(LEFT(pDest))
       LOC:Index2=1
       LOOP LOC:Index=1 TO LEN(CLIP(LEFT(pDest)))
            IF pDest[LOC:Index]='\' THEN
               SELF.PageHyperLinks.Dest[(LOC:Index2)] = '\'
               LOC:Index2+=1
            END
            SELF.PageHyperLinks.Dest[(LOC:Index2)] = pDest[LOC:Index]
            LOC:Index2+=1
       END
    END
    SELF.PageHyperLinks.ObjectNo = 0 
    ADD(SELF.PageHyperLinks)
PDFGeneratorClass.DrawHyperLink      PROCEDURE(LONG XPos,LONG YPos,LONG Width=0,LONG Height=0,STRING HyperLink,<STRING pText>)
 CODE

    IF NOT OMITTED(5) THEN
       SELF.PageHyperLinks.Text = pText
    ELSE
       SELF.PageHyperLinks.Text = HyperLink
    END
    SELF.DrawRegionLink(XPos,YPos,Width,Height,1,HyperLink,'')
    SELF.DrawText(XPos,YPos,CLIP(SELF.PageHyperLinks.Text),XPos,YPos,Width,Height)

PDFGeneratorClass.DrawAnnotation       PROCEDURE(LONG XPos,LONG YPos,STRING AnnotationText)
 CODE
    SELF.PageHyperLinks.XPos = (XPos/(8500/612))
    SELF.PageHyperLinks.YPos = (YPos/(8500/612))
    SELF.PageHyperLinks.Type = PDFHLType:Annotation
    SELF.PageHyperLinks.ObjectNo = 0
    SELF.PageHyperLinks.Boxed    = SELF.HyperLinkBoxed
    SELF.PageHyperLinks.BoxColor = SELF.HyperLinkBoxColor
    SELF.PageHyperLinks.Text = 'ANNOTATION'
    SELF.PageHyperLinks.Dest = CLIP(LEFT(AnnotationText))
    ADD(SELF.PageHyperLinks)

PDFGeneratorClass.DrawCommand          PROCEDURE(LONG XPos,LONG YPos,LONG Width=0,LONG Height=0,STRING pText,STRING pCommand,STRING pParameters)
 CODE
    SELF.PageHyperLinks.Text = CLIP(LEFT(pText))
    SELF.DrawRegionLink(XPos,YPos,Width,Height,PDFHLType:Command,CLIP(LEFT(pCommand)),CLIP(LEFT(pParameters)))
    SELF.DrawText(XPos,YPos,CLIP(SELF.PageHyperLinks.Text),XPos,YPos,Width,Height)

PDFGeneratorClass.DrawPageAction       PROCEDURE(LONG XPos,LONG YPos,LONG Width=0,LONG Height=0,STRING pText,STRING pAction)
 CODE
    SELF.PageHyperLinks.Text = pText
    CASE CLIP(LEFT(UPPER(pAction)))
    OF 'FIRST'
    OROF 'PREV'
    OROF 'NEXT'
    OROF 'LAST'
    OROF 'BACK'
    OROF 'FORWARD'
      SELF.DrawRegionLink(XPos,YPos,Width,Height,PDFHLType:PageAction,UPPER(pAction),'')
    ELSE
      RETURN
    END
    SELF.DrawText(XPos,YPos,CLIP(SELF.PageHyperLinks.Text),XPos,YPos,Width,Height)

PDFGeneratorClass.AddPageHyperLinks      PROCEDURE()
LOC:I       LONG
LOC:Blue    REAL
LOC:Green   REAL
LOC:Red     REAL
LOC:Index   LONG
 CODE
    LOOP LOC:I=1 TO RECORDS(SELF.PageHyperLinks)
         GET(SELF.PageHyperLinks,LOC:I)
         IF NOT ERRORCODE() THEN
             IF SELF.PageHyperLinks.Type>PDFHLType:PageAction THEN CYCLE.
             SELF.CurObj+=1
             SELF.Locations.ObjectNo = SELF.CurObj
             SELF.Locations.Position = SELF.Output.FPos
             ADD(SELF.Locations)
             SELF.PageHyperLinks.ObjectNo=SELF.CurObj
             PUT(SELF.PageHyperLinks)
             SELF.Output.WriteLine((SELF.CurObj)&' 0 obj '&CHR(60)&CHR(60))
             SELF.Output.WriteLine('/Type /Annot ')
             CASE SELF.PageHyperLinks.Type
             OF PDFHLType:HyperLink       !-HyperLink
             OROF PDFHLType:PageAction    !-PageAction
             OROF PDFHLType:Command       !-Commnad
                 SELF.Output.WriteLine('/Subtype /Link')
                 IF SELF.PageHyperLinks.Width AND SELF.PageHyperLinks.Height THEN
                       SELF.Output.WriteLine('/Rect [ '&|
                       SELF.PageHyperLinks.XPos&' '&|
                       (SELF.PageHeight-SELF.PageHyperLinks.Height-SELF.PageHyperLinks.YPos)&' '&|
                       (SELF.PageHyperLinks.XPos+SELF.PageHyperLinks.Width)&' '&|
                       (SELF.PageHeight-SELF.PageHyperLinks.YPos)&' ]')
                 ELSE
                    IF SELF.PageHyperLinks.Text THEN
                       SELF.Output.WriteLine('/Rect [ '&|
                       SELF.PageHyperLinks.XPos&' '&|
                       (SELF.PageHeight-SELF.PointSize-SELF.PageHyperLinks.YPos-INT((SELF.PointSize/3)))&' '&|
                       SELF.PageHyperLinks.XPos+INT(LEN(CLIP(SELF.PageHyperLinks.Text))*(SELF.PointSize/2))&' '&|
                       (SELF.PageHeight-SELF.PageHyperLinks.YPos)&' ]')
                    ELSE
                       SELF.Output.WriteLine('/Rect [ '&|
                       SELF.PageHyperLinks.XPos&' '&|
                       0&' '&|
                       0&' '&|
                       (SELF.PageHeight-SELF.PageHyperLinks.YPos)&' ]')
                    END
                 END
                 IF SELF.PageHyperLinks.Boxed THEN
                    SELF.Output.WriteLine('/Border [ 0 0 1 ]')
                 ELSE
                    SELF.Output.WriteLine('/Border [ 0 0 0 ]')
                 END
                 SELF.GenerateRGB(SELF.PageHyperLinks.BoxColor,LOC:Red,LOC:Green,LOC:Blue)
                 SELF.Output.WriteLine('/C [ '&LOC:Red&' '&LOC:Green&' '&LOC:Blue&' ]')
                 SELF.Output.WriteLine('/A '&SELF.CurObj+1&' 0 R')
             OF PDFHLType:Annotation         !-Annotation
                 SELF.Output.WriteLine('/Subtype /Text')
                 SELF.Output.WriteLine('/Rect [ '&|
                 SELF.PageHyperLinks.XPos&' '&|
                 (SELF.PageHeight-SELF.PointSize-SELF.PageHyperLinks.YPos-INT((SELF.PointSize/3)))&' '&|
                 SELF.PageHyperLinks.XPos+INT(LEN(CLIP(SELF.PageHyperLinks.Text))*(SELF.PointSize/2))&' '&|
                 (SELF.PageHeight-SELF.PageHyperLinks.YPos)&' ]')
                 SELF.Output.WriteLine('/Contents ('&CLIP(SELF.PageHyperLinks.Dest)&')')
             END
             SELF.Output.WriteLine('>> ')
             SELF.Output.WriteLine('endobj')
             SELF.CurObj+=1
             SELF.Locations.ObjectNo = SELF.CurObj
             SELF.Locations.Position = SELF.Output.FPos
             ADD(SELF.Locations)
             IF SELF.PageHyperLinks.Type<>PDFHLType:Annotation THEN         !-Annotation
                SELF.Output.WriteLine((SELF.CurObj)&' 0 obj')
                SELF.Output.WriteLine(CHR(60)&CHR(60)&' ')
                CASE SELF.PageHyperLinks.Type
                OF PDFHLType:HyperLink                                      !-HyperLink
                    SELF.Output.WriteLine('/Type /Action /S /URI')
                    SELF.Output.WriteLine('/URI ('&CLIP(SELF.PageHyperLinks.Dest)&')')
                OF PDFHLType:Command                                        !-Commnad
                    SELF.Output.WriteLine('/Type /Action /S /Launch')
                    IF CLIP(SELF.PageHyperLinks.Parameters) THEN
                       SELF.Output.WriteLine('/Win '&CHR(60)&CHR(60)&'/F ('&CLIP(SELF.PageHyperLinks.Dest)&') /P ( '&CLIP(SELF.PageHyperLinks.Parameters)&' )>>')
                    ELSE
                       SELF.Output.WriteLine('/Win '&CHR(60)&CHR(60)&'/F ('&CLIP(SELF.PageHyperLinks.Dest)&')>>')
                    END
                OF PDFHLType:PageAction                                      !-PageAction
                   SELF.Output.WriteStr('/Type /Action /S /Named')
                   CASE CLIP(LEFT(UPPER(SELF.PageHyperLinks.Dest)))
                   OF 'FIRST'
                    SELF.Output.WriteLine(' /N /FirstPage')
                   OF 'PREV'
                    SELF.Output.WriteLine(' /N /PrevPage')
                   OF 'NEXT'
                    SELF.Output.WriteLine(' /N /NextPage')
                   OF 'LAST'
                    SELF.Output.WriteLine(' /N /LastPage')
                   OF 'BACK'
                    SELF.Output.WriteLine(' /N /GoBack')
                   OF 'FORWARD'
                    SELF.Output.WriteLine(' /N /GoForward')
                   END
                END
                SELF.Output.WriteLine('>> ')
                SELF.Output.WriteLine('endobj')
             END
         END
    END

PDFGeneratorClass.AddFonts    PROCEDURE()
LOC:I SHORT
  CODE
      LOOP LOC:I=1 TO RECORDS(SELF.FontsNames)
           SELF.AddFont(LOC:I)
      END

PDFGeneratorClass.AddFont     PROCEDURE(SHORT pFontNumber)
LOC:I   SHORT
LOC:X   BYTE
  CODE
     GET(SELF.FontsNames,pFontNumber)
     IF NOT ERRORCODE()
         !VALIDATE IF THE FONT ALREADY EXISTS
         IF SELF.FontsNames.BuiltIn THEN
            SELF.CurObj+=1
            SELF.FontsNames.ObjectNo = SELF.CurObj
            PUT(SELF.FontsNames)
            SELF.Locations.ObjectNo  = SELF.CurObj
            SELF.Locations.Position  = SELF.Output.FPos
            ADD(SELF.Locations)

            SELF.Output.WriteLine(SELF.CurObj&' 0 obj')
            SELF.Output.WriteLine(CHR(60)&CHR(60)&' ')
            SELF.Output.WriteLine('/Type /Font')
            SELF.Output.WriteLine('/Subtype /Type1')
            SELF.Output.WriteLine('/Name /F'&SELF.FontsNames.Number)
            SELF.Output.WriteLine('/BaseFont /'&SELF.FontsNames.Name)
            SELF.Output.WriteLine('/Encoding /WinAnsiEncoding')
         ELSE
            IF NOT SELF.AddFontDescriptor(pFontNumber)
               SELF.Output.WriteLine('% FontDescriptor missing')
            END
            SELF.CurObj+=1
            SELF.FontsNames.ObjectNo = SELF.CurObj
            PUT(SELF.FontsNames)
            SELF.Locations.ObjectNo  = SELF.CurObj
            SELF.Locations.Position  = SELF.Output.FPos
            ADD(SELF.Locations)

            SELF.Output.WriteLine(SELF.CurObj&' 0 obj')
            SELF.Output.WriteLine(CHR(60)&CHR(60)&' ')
            SELF.Output.WriteLine('/Type /Font')
            SELF.Output.WriteLine('/Subtype /TrueType')
            SELF.Output.WriteLine('/Name /F'&SELF.FontsNames.Number)
            SELF.Output.WriteLine('/BaseFont /'&CLIP(SELF.FontsNames.Name))
            SELF.Output.WriteLine('/FirstChar '&SELF.FontsNames.FirstChar)
            SELF.Output.WriteLine('/LastChar '&SELF.FontsNames.LastChar)
            SELF.Output.WriteLine('/Encoding /WinAnsiEncoding')
            SELF.Output.WriteLine('/FontDescriptor '&SELF.CurObj-1&' 0 R')
            SELF.Output.WriteStr('/Widths [')
            LOC:X = 0
            LOOP LOC:I=SELF.FontsNames.FirstChar TO SELF.FontsNames.LastChar
                 LOC:X += 1
                 IF LOC:X = 10 AND (LOC:I <> SELF.FontsNames.LastChar)
                    LOC:X = 0
                    SELF.Output.WriteLine(' '&SELF.FontsNames.CharWidth[LOC:I])
                 ELSE
                    SELF.Output.WriteStr(' '&SELF.FontsNames.CharWidth[LOC:I])
                 END
                 
            END
            SELF.Output.WriteLine(']')
         END
         SELF.Output.WriteLine('>> ')
         SELF.Output.WriteLine('endobj')
     END

PDFGeneratorClass.AddFontDescriptor    PROCEDURE(SHORT pFontNumber)
LOC:I                           SHORT
LOC:CSOUTLINETEXTMETRIC_SIZE    LONG
LOC:CSOUTLINETEXTMETRIC         &CSTRING
LOC:SOUTLINETEXTMETRIC          STRING(SIZE(OUTLINETEXTMETRIC))
LOC:OUTLINETEXTMETRIC           LIKE(OUTLINETEXTMETRIC),OVER(LOC:SOUTLINETEXTMETRIC)
LOC:DC                          UNSIGNED, AUTO
LOC:HFont                       UNSIGNED, AUTO
LOC:CharSize                    LIKE(winSizeType)
LOC:CharToTest                  STRING(1)
LOC:OLDMAPMODE                  ULONG
LOC:FontName                    CSTRING(65)
LOC:Flags                       LONG
LOC:Subclasing                  BYTE
ReturnValue                     BYTE
  CODE
     ReturnValue = False
     GET(SELF.FontsNames,pFontNumber)
     IF NOT ERRORCODE()
        LOC:FontName = CLIP(SELF.FontsNames.RealName)
        IF NOT SELF.FontsNames.BuiltIn THEN
           IF NOT SELF.DC
              SELF.DC = CreateCompatibleDC(0)
           END
           LOC:DC = SELF.DC
           IF LOC:DC THEN
              LOC:OLDMAPMODE=SetMapMode(LOC:DC,1)
              LOC:HFont = CreateFont(-((750 *GetDeviceCaps(LOC:DC, 90))/72), |
                 0, 0, 0,|
                 0, |
                                      choose(band(SELF.FontsNames.Style, FONT:italic)),|
                                      choose(band(SELF.FontsNames.Style, FONT:underline)),|
                                      choose(band(SELF.FontsNames.Style, FONT:strikeout)),|
                 1,|
                 0,|
                 0,|
                 2, 0,LOC:FontName)
              LOC:OLDMAPMODE=SetMapMode(LOC:DC,LOC:OLDMAPMODE)
              IF LOC:HFont THEN
                 IF SelectObject(LOC:DC, LOC:HFont) THEN
                    LOC:CSOUTLINETEXTMETRIC_SIZE = GetOutlineTextMetrics(LOC:DC, 0)
                    IF LOC:CSOUTLINETEXTMETRIC_SIZE AND LOC:CSOUTLINETEXTMETRIC_SIZE>=SIZE(OUTLINETEXTMETRIC) THEN
                       LOC:CSOUTLINETEXTMETRIC &= NEW(CSTRING(LOC:CSOUTLINETEXTMETRIC_SIZE+1))
                       IF GetOutlineTextMetrics(LOC:DC, LOC:CSOUTLINETEXTMETRIC_SIZE, LOC:CSOUTLINETEXTMETRIC)
                          LOC:SOUTLINETEXTMETRIC = LOC:CSOUTLINETEXTMETRIC[1:SIZE(OUTLINETEXTMETRIC)]

                          SELF.CurObj+=1
                          SELF.Locations.ObjectNo  = SELF.CurObj
                          SELF.Locations.Position  = SELF.Output.FPos
                          ADD(SELF.Locations)
                          SELF.Output.WriteLine(SELF.CurObj&' 0 obj')
                          SELF.Output.WriteLine(CHR(60)&CHR(60)&' ')
                          SELF.Output.WriteLine('/Type /FontDescriptor')

                          !Saving the real font name
                                                 !FamilyName
                          SELF.FontsNames.Name = LOC:CSOUTLINETEXTMETRIC[(LOC:OUTLINETEXTMETRIC.otmpFamilyName+1):(LOC:OUTLINETEXTMETRIC.otmpFaceName-1)]

                          IF CHOOSE(BAND(SELF.FontsNames.Style, FONT:italic)) AND CHOOSE(BAND(SELF.FontsNames.Style, FONT:Bold))
                             SELF.FontsNames.Name=CLIP(SELF.FontsNames.Name)&',BoldItalic'
                          ELSE
                             IF CHOOSE(BAND(SELF.FontsNames.Style, FONT:italic))
                                SELF.FontsNames.Name=CLIP(SELF.FontsNames.Name)&',Italic'
                             ELSE
                                IF CHOOSE(BAND(SELF.FontsNames.Style, FONT:Bold))
                                   SELF.FontsNames.Name=CLIP(SELF.FontsNames.Name)&',Bold'
                                END
                             END
                          END
                          Do RemoveNameSpaces
                          SELF.Output.WriteLine('/FontName /'&SELF.FontsNames.Name)

                          !SET the flags
                          LOC:Flags         =0
                          IF LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmCharSet=0
                             LOC:Flags         +=FDFlag:Nonsymbolic
                          ELSE
                             IF LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmCharSet=2
                                LOC:Flags         +=FDFlag:Symbolic
                             END
                          END
                          IF BAND(LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmPitchAndFamily,PitchAndFamily:FIXED_PITCH)<>PitchAndFamily:FIXED_PITCH
                             LOC:Flags         +=FDFlag:FixedPitch
                          END
                          IF LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmItalic
                             LOC:Flags         +=FDFlag:Italic
                          END
                          IF BAND(LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmPitchAndFamily, 0Fh)=PitchAndFamily:FF_ROMAN
                             LOC:Flags         +=FDFlag:Serif
                          END
                          IF BAND(LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmPitchAndFamily, 0Fh)=PitchAndFamily:FF_SCRIPT
                             LOC:Flags         +=FDFlag:Script
                          END
                          IF LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmWeight>700 THEN
                             LOC:Flags         +=FDFlag:ForceBold
                          END

                          SELF.Output.WriteLine('/Flags '&LOC:Flags)
                          SELF.Output.WriteStr('/FontBBox [')
                          SELF.Output.WriteStr(LOC:OUTLINETEXTMETRIC.otmrcFontBox.top)
                          SELF.Output.WriteStr(' '&LOC:OUTLINETEXTMETRIC.otmMacAscent)
                          SELF.Output.WriteStr(' '&LOC:OUTLINETEXTMETRIC.otmrcFontBox.bottom)
                          SELF.Output.WriteLine(' '&LOC:OUTLINETEXTMETRIC.otmrcFontBox.right&']')

                          IF LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmWeight=0
                             SELF.Output.WriteLine('/StemV '&80)
                             SELF.Output.WriteLine('/StemH '&80)
                          ELSE
                             SELF.Output.WriteLine('/StemV '&ROUND((LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmWeight/5.7),1))
                             SELF.Output.WriteLine('/StemH '&ROUND((LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmWeight/5.7),1))
                          END

                          SELF.Output.WriteLine('/ItalicAngle '&LOC:OUTLINETEXTMETRIC.otmItalicAngle)
                          SELF.Output.WriteLine('/Ascent '&LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmAscent)
                          SELF.Output.WriteLine('/Descent '&-LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmDescent)
                          SELF.Output.WriteLine('/Leading '&LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmInternalLeading + LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmExternalLeading)
                          SELF.Output.WriteLine('/MaxWidth '&LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmMaxCharWidth)
                          SELF.Output.WriteLine('/AvgWidth '&LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmAveCharWidth)

                          SELF.Output.WriteLine('>> ')
                          SELF.Output.WriteLine('endobj')

                          IF SELF.FontsNames.FirstChar = 0
                             SELF.FontsNames.FirstChar     = LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmFirstChar
                             SELF.FontsNames.LastChar      = LOC:OUTLINETEXTMETRIC.otmTextMetrics.tmLastChar
                             LOC:Subclasing = False
                          ELSE
                             LOC:Subclasing = True
                          END


                          !SET the fonts Width
                          LOOP LOC:I=SELF.FontsNames.FirstChar TO SELF.FontsNames.LastChar
                               LOC:CharToTest=CHR(LOC:I)
                               IF GetTextExtentPoint32(LOC:DC,LOC:CharToTest, 1,LOC:CharSize)<>0 THEN
                                  IF LOC:Subclasing THEN
                                     IF SELF.FontsNames.CharWidth[LOC:I] THEN
                                        SELF.FontsNames.CharWidth[LOC:I]=LOC:CharSize.eW
                                     END
                                  ELSE
                                     SELF.FontsNames.CharWidth[LOC:I]=LOC:CharSize.eW
                                  END
                               END
                          END
                          PUT(SELF.FontsNames)
                          ReturnValue = True
                       END
                       DISPOSE(LOC:CSOUTLINETEXTMETRIC)
                    ELSE
                       MESSAGE('NOT LOC:CSOUTLINETEXTMETRIC_SIZE:'&LOC:CSOUTLINETEXTMETRIC_SIZE)
                    END
                 ELSE
                    MESSAGE('NOT SelectObject')
                 END
                 DeleteObject(LOC:HFont)
              ELSE
                 MESSAGE('NOT LOC:HFont')
              END
           ELSE
              MESSAGE('NOT LOC:DC')
           END
        END
     END
     RETURN ReturnValue
RemoveNameSpaces    ROUTINE
 DATA
lI      SHORT
lX      SHORT
lLastI  SHORT
 CODE
    lLastI = LEN(CLIP(SELF.FontsNames.Name))
    LOOP lI=1 TO lLastI
         IF SELF.FontsNames.Name[lI]=' '

            LOOP lX=lI+1 TO lLastI
                 SELF.FontsNames.Name[lX-1]=SELF.FontsNames.Name[lX]
            END
            SELF.FontsNames.Name[lLastI]=' '
            lLastI = lLastI-1
         END
    END
    SELF.FontsNames.Name = CLIP(SELF.FontsNames.Name)

PDFGeneratorClass.GetFontTranslation PROCEDURE(STRING pFontName,BYTE pBold=0,BYTE pItalic=0)
ReturnValue STRING(30)
 CODE
   CASE UPPER(pFontName)
   OF 'COURIER';              ReturnValue = 'Courier'
   OF 'HELVETICA';            ReturnValue = 'Helvetica'
   OF 'TIMES-ROMAN'
   OROF  'TIMES'
   OROF  'ROMAN'
                              ReturnValue = 'Times-Roman'
   OF 'SYMBOL';               RETURN 'Symbol'
   OF 'ZAPFDINGBATS';         RETURN 'ZapfDingbats'
   OF 'COURIER-BOLD';         RETURN 'Courier-Bold'
   OF 'COURIER-BOLDOBLIQUE';  RETURN 'Courier-BoldOblique'
   OF 'COURIER-OBLIQUE';      RETURN 'Courier-Oblique'
   OF 'HELVETICA-BOLD';       RETURN 'Helvetica-Bold'
   OF 'HELVETICA-BOLDOBLIQUE';RETURN 'Helvetica-BoldOblique'
   OF 'HELVETICA-OBLIQUE';    RETURN 'Helvetica-Oblique'
   OF 'TIMES-BOLD';           RETURN 'Times-Bold'
   OF 'TIMES-ITALIC';         RETURN 'Times-Italic'
   OF 'TIMES-BOLDITALIC';     RETURN 'Times-BoldItalic'
   ELSE
      ReturnValue = ''
   END
   IF ReturnValue
      IF pBold OR pItalic THEN
         IF UPPER(CLIP(ReturnValue))='TIMES-ROMAN' THEN ReturnValue='Times'.
         ReturnValue = CLIP(ReturnValue)&'-'
      END
      IF pBold THEN
         ReturnValue = CLIP(ReturnValue)&'Bold'
      END
      IF pItalic THEN
         IF LEFT(UPPER(CLIP(ReturnValue)),6)='TIMES-' THEN
            ReturnValue = CLIP(ReturnValue)&'Italic'
         ELSE
            ReturnValue = CLIP(ReturnValue)&'Oblique'
         END
      END
   END
   RETURN CLIP(ReturnValue)

!Courier
!Courier-Bold
!Courier-BoldOblique
!Courier-Oblique
!Helvetica
!Helvetica-Bold
!Helvetica-BoldOblique
!Helvetica-Oblique
!Times-Roman
!Times-Bold
!Times-Italic
!Times-BoldItalic
!Symbol
!ZapfDingbats
PDFGeneratorClass.AddImages      PROCEDURE()
LOC:I       LONG
LOC:Length  LONG
 CODE
     LOOP LOC:I=1 TO RECORDS(SELF.Images)
          GET(SELF.Images,LOC:I)
          IF NOT ERRORCODE() THEN
             SELF.CurObj+=1
             SELF.Locations.ObjectNo = SELF.CurObj
             SELF.Locations.Position = SELF.Output.FPos
             ADD(SELF.Locations)
             SELF.Images.ObjectNo = SELF.CurObj
             PUT(SELF.Images)
             SELF.Output.WriteLine(SELF.CurObj&' 0 obj '&CHR(60)&CHR(60))
             SELF.Output.WriteLine('/Type /XObject')
             SELF.Output.WriteLine('/Subtype /Image')
             SELF.Output.WriteLine('/Name /Im'&SELF.Images.ImageNo)
             SELF.Output.WriteLine('/Width '&SELF.Images.Width)
             SELF.Output.WriteLine('/Height '&SELF.Images.Height)
             SELF.Output.WriteLine('/Length '&(SELF.CurObj+1)&' 0 R')
             CASE SELF.Images.Type
             OF 1                  !JPEG
             SELF.Output.WriteLine('/BitsPerComponent 8')
             SELF.Output.WriteLine('/ColorSpace /DeviceRGB')
             SELF.Output.WriteLine('/Filter /DCTDecode')
             OF 2                  !GIF
             SELF.Output.WriteLine('/BitsPerComponent 8')
             SELF.Output.WriteLine('/Filter /LZWDecode')
             SELF.Output.WriteLine('/DecodeParms '&CHR(60)&CHR(60)&'/EarlyChange 0>>')
             SELF.Output.WriteStr('/ColorSpace [/Indexed /DeviceRGB '&(2^(SELF.Images.ColorTableLen+1))-1&' (')
             LOC:Length=SELF.Output.WriteFileStream(SELF.Images.FileName,SELF.Images.ColorTableStart,(3 * (2^(SELF.Images.ColorTableLen+1))),true)
             SELF.Output.WriteStr(')]')
             OF 3                  !PNG
                SELF.Output.WriteLine('/Filter /FlateDecode')
                IF SELF.Images.Color_type=2 THEN
                SELF.Output.WriteLine('/DecodeParms '&CHR(60)&CHR(60)&'/Predictor 15 /Columns '&SELF.Images.Width&' /Colors 3 /BitsPerComponent '&SELF.Images.Bit_depth&'>>')
                ELSE
                SELF.Output.WriteLine('/DecodeParms '&CHR(60)&CHR(60)&'/Predictor 15 /Columns '&SELF.Images.Width&' /Colors 1 /BitsPerComponent'&SELF.Images.Bit_depth&'>>')
                END
                CASE SELF.Images.Color_type
                OF 0
                SELF.Output.WriteLine('/BitsPerComponent '&SELF.Images.Bit_depth)
                SELF.Output.WriteLine('/ColorSpace /DeviceGray')
                OF 2
                SELF.Output.WriteLine('/BitsPerComponent '&SELF.Images.Bit_depth)
                SELF.Output.WriteLine('/ColorSpace /DeviceRGB')
                OF 3
                SELF.Output.WriteLine('/BitsPerComponent 8')
                SELF.Output.WriteStr('/ColorSpace ')
                SELF.WriteFilePNGPLTE(SELF.Images.FileName)
                END
             END
             SELF.Output.WriteLine('>>')
             SELF.Output.WriteLine('stream')
             CASE SELF.Images.Type
             OF 1                  !JPEG
                LOC:Length=SELF.Output.WriteFileStream(SELF.Images.FileName)
             OF 2                  !GIF
                LOC:Length=SELF.WriteFileLZWStream(SELF.Images.FileName,SELF.Images.StreemStart)
             OF 3                  !PNG
                LOC:Length=SELF.WriteFilePNGiDat(SELF.Images.FileName)
             END
             SELF.Output.WriteLine('')
             SELF.Output.WriteLine('endstream')
             SELF.Output.WriteLine('endobj')
             !Write the image length
             IF LOC:Length THEN
                SELF.CurObj+=1
                SELF.Locations.ObjectNo = SELF.CurObj
                SELF.Locations.Position = SELF.Output.FPos
                ADD(SELF.Locations)

                SELF.Output.WriteLine(SELF.CurObj&' 0 obj')
                SELF.Output.WriteLine(LOC:Length)
                SELF.Output.WriteLine('endobj')
             END
          END
     END


!ASCIIHexDecode none Decodes binary data in an ASCII hexadecimal representation.
!ASCII85Decode none Decodes binary data in an ASCII base-85 representation.
!LZWDecode dictionary (Parameters optional) Decompresses text or binary data using LZW adaptive
!compression method.
!RunLengthDecode
!none Decompresses binary data using a byte-oriented run-length decoding algorithm.
!CCITTFaxDecode
!dictionary (Parameters optional) Decompresses binary data using a bit-oriented decoding
!algorithm, the CCITT facsimile standard.
!DCTDecode dictionary (Parameters optional) Decompresses sampled image data using a discrete cosine
!transform technique based on the JPEG standard.
!FlateDecode dictionary (Parameters optional) Decompresses text or binary data using the Flate
!decompression PDF 1.2
PDFGeneratorClass.StartPage   PROCEDURE()
  CODE
     SELF.PageNo+=1
     FREE(SELF.PageHyperLinks)
     FREE(SELF.Contents)
     IF SELF.PagesAsParentBookmark THEN
        SELF.AddBookMark(CLIP(SELF.BasePageBookmarkName)&SELF.PageNo)
     END

PDFGeneratorClass.EndPage  PROCEDURE()
LOC:StreamEnd  LONG
LOC:I          LONG
LOC:HylObj     LONG
   CODE
     IF SELF.InText THEN SELF.CloseText().
     IF SELF.InImage THEN SELF.CloseImage().

     !Write the page
     SELF.CurObj+=1
     SELF.Locations.ObjectNo = SELF.CurObj
     SELF.Locations.Position = SELF.Output.FPos
     ADD(SELF.Locations)

     SELF.PageObs.ObjectNo = SELF.CurObj
     SELF.PageObs.Number   = SELF.PageNo
     ADD(SELF.PageObs)

     SELF.Output.WriteLine(SELF.CurObj&' 0 obj '&CHR(60)&CHR(60))
     SELF.Output.WriteLine('/Type /Page')
     SELF.Output.WriteLine('/Parent 3 0 R')
     SELF.Output.WriteLine('/Resources 4 0 R')!All the pages use the same resources
     IF SELF.PageLandscape = False THEN
        SELF.Output.WriteLine('/MediaBox [ 0 0 '&SELF.PageWidth&' '&SELF.PageHeight&' ]')
     ELSE
        SELF.Output.WriteLine('/MediaBox [ 0 0 '&SELF.PageHeight&' '&SELF.PageWidth&' ]')
     END
     IF RECORDS(SELF.Contents) THEN
        SELF.Output.WriteStr('/Contents [')
     END
     LOOP LOC:I=1 TO RECORDS(SELF.Contents)
          GET(SELF.Contents,LOC:I)
          IF NOT ERRORCODE() THEN
             SELF.Output.WriteStr(' '&SELF.Contents.ObjectNo&' 0 R')
          END
     END
     IF RECORDS(SELF.Contents) THEN
        SELF.Output.WriteLine(']')
     END
     IF RECORDS(SELF.PageHyperLinks) THEN
        LOC:HylObj=SELF.CurObj+1
        SELF.Output.WriteStr('/Annots [')
        LOOP LOC:I=1 TO RECORDS(SELF.PageHyperLinks)
             GET(SELF.PageHyperLinks,LOC:I)
             IF NOT ERRORCODE() THEN
                 SELF.PageHyperLinks.ObjectNo=LOC:HylObj
                 PUT(SELF.PageHyperLinks)
             END
             SELF.Output.WriteStr(' '&LOC:HylObj&' 0 R')
             LOC:HylObj+=2
        END
        SELF.Output.WriteLine(' ]')
     END
     SELF.Output.WriteLine('>> ')
     SELF.Output.WriteLine('endobj')
     !!!!!!!!!!!!!!!!!!!!!!!
     ! Write Obj: XX
     ! All Page HyperLink Obj
     !!!!!!!!!!!!!!!!!!!!!!!
     SELF.AddPageHyperLinks()

PDFGeneratorClass.OpenContent PROCEDURE()
 CODE
    SELF.LastContent = SELF.CurObj
    SELF.CurObj+=1
    SELF.Contents.ObjectNo=SELF.CurObj
    ADD(SELF.Contents)

    SELF.Locations.ObjectNo = SELF.CurObj
    SELF.Locations.Position = SELF.Output.FPos
    ADD(SELF.Locations)
    SELF.Output.WriteLine(SELF.CurObj&' 0 obj')
    SELF.Output.WriteLine(CHR(60)&CHR(60)&' /Length '&SELF.CurObj+1&' 0 R >> ')
    SELF.Output.WriteLine('stream')
    SELF.StreamStart = SELF.Output.FPos

PDFGeneratorClass.CloseContent PROCEDURE()
LOC:StreamEnd  LONG
 CODE
        !End stream and close the object
        LOC:StreamEnd = SELF.Output.FPos
        SELF.Output.WriteLine('endstream')
        SELF.Output.WriteLine('endobj')
        SELF.CurObj+=1
        SELF.Locations.ObjectNo = SELF.CurObj
        SELF.Locations.Position = SELF.Output.FPos
        ADD(SELF.Locations)
        SELF.Output.WriteLine(SELF.CurObj&' 0 obj')
        SELF.Output.WriteLine((LOC:StreamEnd - SELF.StreamStart))
        SELF.Output.WriteLine('endobj')

PDFGeneratorClass.OpenText    PROCEDURE(LONG XPos,LONG YPos,LONG Width ,LONG Height)
 CODE
    IF SELF.InText THEN
       SELF.CloseText()
    END
    SELF.InCliping  = True
    SELF.ClipXPos   = XPos
    SELF.ClipYPos   = YPos
    SELF.ClipWidth  = Width
    SELF.ClipHeight = Height
    SELF.OpenText(True)

PDFGeneratorClass.OpenText    PROCEDURE(BYTE pDoSeting=1)
 CODE
    IF SELF.InText THEN
       IF SELF.InCliping = True THEN
          SELF.CloseText()
       ELSE
          RETURN
       END
    END
    IF SELF.InImage THEN
       SELF.CloseImage()
    END
    ! Open It
    SELF.InText = True
    SELF.OpenContent()
    !START CLIPPING
    IF SELF.InCliping = True THEN
       SELF.Output.WriteLine('q')
       SELF.Output.WriteLine((SELF.ClipXPos/(8500/612))&' '&(SELF.PageHeight-(SELF.ClipYPos/(8500/612)))&' '&(SELF.ClipWidth/(8500/612))&' '&-(SELF.ClipHeight/(8500/612))&' re')
       SELF.Output.WriteLine('W n')
    END
    !START TEXT
    SELF.Output.WriteLine('BT')

PDFGeneratorClass.CloseText   PROCEDURE()
 CODE
     !Close Text
     IF SELF.InText = True THEN
        SELF.InText = False
        SELF.Output.WriteLine('ET')
        IF SELF.InCliping THEN
           SELF.InCliping  = False
           SELF.ClipXPos   = 0
           SELF.ClipYPos   = 0
           SELF.ClipWidth  = 0
           SELF.ClipHeight = 0
           SELF.Output.WriteLine('Q')
        END
        SELF.CloseContent()
     END

PDFGeneratorClass.OpenImage   PROCEDURE(BYTE pDoSeting=1)
 CODE
    IF SELF.InImage THEN RETURN.
    IF SELF.InText THEN
       SELF.CloseText()
    END
    !Open It
    SELF.InImage = True
    SELF.OpenContent()
    IF pDoSeting THEN
       SELF.DrawSetColor(SELF.PenColor.Red,SELF.PenColor.Green,SELF.PenColor.Blue,'RG')
       SELF.DrawSetColor(SELF.FillColor.Red,SELF.FillColor.Green,SELF.FillColor.Blue,'rg')
       SELF.DrawSetPenWidth(SELF.PenWidth)
       SELF.DrawSetPenStyle(SELF.PenStyle)
    END

PDFGeneratorClass.CloseImage  PROCEDURE()
 CODE
    IF SELF.InImage = True THEN
       SELF.InImage = False
       SELF.CloseContent()
    END
!****************************************************************************************
PDFReportGenerator.CONSTRUCT            PROCEDURE()
 CODE
    SELF.Attribute  &=NEW ReportAttributeManager
PDFReportGenerator.DESTRUCT                             PROCEDURE()
 CODE
    DISPOSE(SELF.Attribute)

PDFReportGenerator.IReportGenerator.Init                PROCEDURE(<ErrorClass EC>)
  CODE
PDFReportGenerator.IReportGenerator.ProcessBand         PROCEDURE(STRING type, BYTE start)
  CODE

PDFReportGenerator.IReportGenerator.OpenDocument        PROCEDURE(UNSIGNED TotalPages)
 CODE
     SELF.TotalPageNo=TotalPages
     SELF.OpenDocument()
     RETURN Level:Benign
PDFReportGenerator.IReportGenerator.CloseDocument       PROCEDURE()
 CODE
     SELF.CloseDocument()
     IF NOT SELF.OutputFileQueue &= NULL THEN
        SELF.OutputFileQueue.FileName = SELF.Output.GetFileName()
        ADD(SELF.OutputFileQueue)
     END
     SELF.Output.SetFileName('')
     RETURN Level:Benign

PDFReportGenerator.IReportGenerator.OpenPage            PROCEDURE(SHORT pBoxLeft,SHORT pBoxTop,SHORT pBoxRight,SHORT pBoxBottom)
 CODE
     SELF.SetPageType(PAPER:USER,pBoxRight-pBoxLeft,pBoxBottom-pBoxTop)
     SELF.StartPage()
     RETURN Level:Benign

PDFReportGenerator.IReportGenerator.ClosePage           PROCEDURE()
 CODE
     SELF.EndPage()
     RETURN Level:Benign

PDFReportGenerator.IReportGenerator.AskProperties       PROCEDURE(BYTE Force)
ReturnValue BYTE
LOC:FileName    STRING(143)
 CODE
     ReturnValue = Level:Benign
     SELF.Init()
     IF NOT CLIP(SELF.Output.GetFileName()) THEN
        LOC:FileName = ''
        IF NOT FILEDIALOG('Save PDF File',LOC:FileName,'PDF|*.PDF|All|*.*',FILE:LongName+FILE:Save+FILE:KeepDir) THEN
           ReturnValue = Level:Notify
        ELSE
           IF NOT INSTRING('.',LOC:FileName) THEN
              LOC:FileName=CLIP(LOC:FileName)&'.PDF'
           END
           SELF.Output.SetFileName(LOC:FileName)
        END
     END
     RETURN ReturnValue

PDFReportGenerator.IReportGenerator.WhoAmI              PROCEDURE()
 CODE
     RETURN RepGen:PDF

PDFReportGenerator.IReportGenerator.DisplayIcon         PROCEDURE()
 CODE
     RETURN '~EXP_PDF.ICO'

PDFReportGenerator.IReportGenerator.DisplayName         PROCEDURE()
 CODE
     RETURN 'PDF'

PDFReportGenerator.IReportGenerator.ProcessString         PROCEDURE(*StringFormatGrp pFormatGrp, STRING Text, STRING pExtendControlAttr)
RetVal  BYTE
lFont   STRING(12)
 CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:PDF,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    SELF.ProcessHiddenControlSize(pFormatGrp.Pos,pExtendControlAttr)
    RetVal=SELF.ProcessHyperlink(pFormatGrp.Pos, Text, pExtendControlAttr)
    RetVal=SELF.ProcessBookMark(pFormatGrp.Pos, Text, pExtendControlAttr)

    IF NOT SELF.Attribute.Extract(RepGen:PDF,TargetAttr:HIDE,pExtendControlAttr) AND Text THEN
       ! if diferent than white it needs to create a box with this color and border 0
       IF pFormatGrp.BackgroundColor<>COLOR:NONE THEN
          IF (pFormatGrp.Pos.Right-pFormatGrp.Pos.Left)>0 AND (pFormatGrp.Pos.Bottom-pFormatGrp.Pos.Top)>0
             SELF.DrawSetPenStyle(PEN:solid)
             SELF.DrawSetPenColor(pFormatGrp.BackgroundColor)
             SELF.DrawSetPenWidth(0)
             SELF.DrawBox(pFormatGrp.Pos.Left,pFormatGrp.Pos.Top,pFormatGrp.Pos.Right-pFormatGrp.Pos.Left,pFormatGrp.Pos.Bottom-pFormatGrp.Pos.Top,pFormatGrp.BackgroundColor)
          END
       END
       IF BAND(pFormatGrp.Style,FONT:underline)=FONT:underline THEN
          SELF.DrawSetPenStyle(PEN:solid)
          SELF.DrawSetPenColor(pFormatGrp.Color)
          SELF.DrawSetPenWidth(1)
          SELF.DrawLine(pFormatGrp.Pos.Left,pFormatGrp.Pos.Top+(pFormatGrp.Size * 15),pFormatGrp.Pos.Right-pFormatGrp.Pos.Left,0)
       END
       SELF.DrawSetFontColor(pFormatGrp.Color)

       lFont=SELF.Attribute.Extract(RepGen:PDF,TargetAttr:FontName,pExtendControlAttr)
       IF lFont THEN
          pFormatGrp.Face = lFont
       END
       SELF.DrawSetTextAngle(pFormatGrp.Angle)
       SELF.DrawSetFont(pFormatGrp.Face,pFormatGrp.Size,CHOOSE(BAND(pFormatGrp.Style,FONT:bold)=FONT:bold,TRue,False),CHOOSE(BAND(pFormatGrp.Style,FONT:italic)=FONT:italic,TRue,False))
       SELF.DrawText(pFormatGrp.LeftText,pFormatGrp.TopText,Text,pFormatGrp.Pos.Left,pFormatGrp.Pos.Top,pFormatGrp.Pos.Right-pFormatGrp.Pos.Left,pFormatGrp.Pos.Bottom-pFormatGrp.Pos.Top)
       IF BAND(pFormatGrp.Style,FONT:strikeout)=FONT:strikeout THEN
          SELF.DrawSetPenStyle(PEN:solid)
          SELF.DrawSetPenColor(pFormatGrp.Color)
          SELF.DrawSetPenWidth(1)
          SELF.DrawLine(pFormatGrp.Pos.Left,pFormatGrp.Pos.Top+(pFormatGrp.Size * 9),pFormatGrp.Pos.Right-pFormatGrp.Pos.Left,0)
       END
    END

PDFReportGenerator.IReportGenerator.ProcessLine         PROCEDURE(*LineFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:PDF,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END

    SELF.ProcessHiddenControlSize(pFormatGrp.Pos,pExtendControlAttr)
    SELF.ProcessHyperlink(pFormatGrp.Pos, '', pExtendControlAttr)
    SELF.ProcessBookMark(pFormatGrp.Pos, '', pExtendControlAttr)

    IF NOT SELF.Attribute.Extract(RepGen:PDF,TargetAttr:HIDE,pExtendControlAttr) THEN
       SELF.DrawSetPenStyle(pFormatGrp.Style)
    ! Need to be added to the LineFormatGrp
       SELF.DrawSetPenColor(pFormatGrp.Color)
       SELF.DrawSetPenWidth(pFormatGrp.Width)
       SELF.DrawLine(pFormatGrp.Pos.Left,pFormatGrp.Pos.Top,pFormatGrp.Pos.Right-pFormatGrp.Pos.Left,pFormatGrp.Pos.Bottom-pFormatGrp.Pos.Top)
    END

PDFReportGenerator.IReportGenerator.ProcessEllipse      PROCEDURE(*EllipseFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:PDF,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END

    SELF.ProcessHiddenControlSize(pFormatGrp.Pos,pExtendControlAttr)
    SELF.ProcessHyperlink(pFormatGrp.Pos, '', pExtendControlAttr)
    SELF.ProcessBookMark(pFormatGrp.Pos, '', pExtendControlAttr)

    IF NOT SELF.Attribute.Extract(RepGen:PDF,TargetAttr:HIDE,pExtendControlAttr) THEN
       SELF.DrawSetPenStyle(pFormatGrp.Style.BorderStyle)
    ! Need to be added to the StyleGrp
       SELF.DrawSetPenColor(pFormatGrp.Style.BorderColor)
       SELF.DrawSetPenWidth(pFormatGrp.Style.BorderWidth)
       SELF.DrawEllipse(pFormatGrp.Pos.Left,pFormatGrp.Pos.Top,|
       pFormatGrp.Pos.Right-pFormatGrp.Pos.Left,|
       pFormatGrp.Pos.Bottom-pFormatGrp.Pos.Top,pFormatGrp.Style.BackgroundColor)
    END

PDFReportGenerator.IReportGenerator.ProcessRectangle    PROCEDURE(*RectFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:PDF,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    SELF.ProcessHiddenControlSize(pFormatGrp.Pos,pExtendControlAttr)
    SELF.ProcessHyperlink(pFormatGrp.Pos, '', pExtendControlAttr)
    SELF.ProcessBookMark(pFormatGrp.Pos, '', pExtendControlAttr)

    IF NOT SELF.Attribute.Extract(RepGen:PDF,TargetAttr:HIDE,pExtendControlAttr) THEN
       SELF.DrawSetPenStyle(pFormatGrp.Style.BorderStyle)
   ! Need to be added to the StyleGrp
       SELF.DrawSetPenColor(pFormatGrp.Style.BorderColor)
       SELF.DrawSetPenWidth(pFormatGrp.Style.BorderWidth)
       SELF.DrawBox(pFormatGrp.Pos.Left,pFormatGrp.Pos.Top,pFormatGrp.Pos.Right-pFormatGrp.Pos.Left,pFormatGrp.Pos.Bottom-pFormatGrp.Pos.Top,pFormatGrp.Style.BackgroundColor)
    END

PDFReportGenerator.IReportGenerator.ProcessImage        PROCEDURE(*ImageFormatGrp pFormatGrp, STRING iName, STRING pExtendControlAttr)
 CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:PDF,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
        
   !pFormatGrp.StretchMode ????
    IF NOT SELF.Attribute.Extract(RepGen:PDF,TargetAttr:HIDE,pExtendControlAttr) THEN
       SELF.ProcessHiddenControlSize(pFormatGrp.Pos,pExtendControlAttr)
       SELF.ProcessHyperlink(pFormatGrp.Pos, '', pExtendControlAttr)
       SELF.ProcessBookMark(pFormatGrp.Pos, '', pExtendControlAttr)
       SELF.DrawImage(pFormatGrp.Pos.Left,pFormatGrp.Pos.Top,pFormatGrp.Pos.Right-pFormatGrp.Pos.Left,pFormatGrp.Pos.Bottom-pFormatGrp.Pos.Top,iName)
    END

PDFReportGenerator.IReportGenerator.ProcessCheck        PROCEDURE(*CheckFormatGrp pFormatGrp, STRING Text, STRING pExtendControlAttr)
lPos    GROUP(PosGrp).
lFont       STRING(12)
 CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:PDF,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END

    lPos.Top         =pFormatGrp.Pos.Top
    lPos.Left        =pFormatGrp.Pos.Left
    lPos.Bottom      =pFormatGrp.Pos.Bottom
    lPos.Right       =pFormatGrp.Prompt.Pos.Right
    SELF.ProcessHiddenControlSize(lPos,pExtendControlAttr)
    SELF.ProcessHyperlink(lPos, Text, pExtendControlAttr)
    SELF.ProcessBookMark(lPos, Text, pExtendControlAttr)

    IF NOT SELF.Attribute.Extract(RepGen:PDF,TargetAttr:HIDE,pExtendControlAttr) THEN
       SELF.DrawSetPenStyle(PEN:solid)
       SELF.DrawSetPenColor(pFormatGrp.Style.BorderColor)
       SELF.DrawSetPenWidth(pFormatGrp.Style.BorderWidth)
       SELF.DrawBox(pFormatGrp.Pos.Left,pFormatGrp.Pos.Top,pFormatGrp.Pos.Right-pFormatGrp.Pos.Left,pFormatGrp.Pos.Bottom-pFormatGrp.Pos.Top,COLOR:NONE)
       IF pFormatGrp.Checked THEN
          SELF.DrawLine(pFormatGrp.Pos.Left,pFormatGrp.Pos.Top,pFormatGrp.Pos.Right-pFormatGrp.Pos.Left,pFormatGrp.Pos.Bottom-pFormatGrp.Pos.Top)
          SELF.DrawLine(pFormatGrp.Pos.Left,pFormatGrp.Pos.Bottom,pFormatGrp.Pos.Right-pFormatGrp.Pos.Left,pFormatGrp.Pos.Top-pFormatGrp.Pos.Bottom)
       END
       lFont=SELF.Attribute.Extract(RepGen:PDF,TargetAttr:FontName,pExtendControlAttr)
       IF lFont THEN
          pFormatGrp.Prompt.Face = lFont
       END
       pFormatGrp.Prompt.Angle= 0
       SELF.IReportGenerator.ProcessString(pFormatGrp.Prompt, Text,pExtendControlAttr)
    END

PDFReportGenerator.IReportGenerator.ProcessRadio        PROCEDURE(*RadioFormatGrp pFormatGrp, STRING Text, STRING pExtendControlAttr)
lPos    GROUP(PosGrp).
lFont       STRING(12)
 CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:PDF,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END

    lPos.Top         =pFormatGrp.Outer.Pos.Top
    lPos.Left        =pFormatGrp.Outer.Pos.Left
    lPos.Bottom      =pFormatGrp.Prompt.Pos.Bottom
    lPos.Right       =pFormatGrp.Prompt.Pos.Right

    SELF.ProcessHyperlink(lPos, Text, pExtendControlAttr)
    SELF.ProcessBookMark(lPos, Text, pExtendControlAttr)

    IF NOT SELF.Attribute.Extract(RepGen:PDF,TargetAttr:HIDE,pExtendControlAttr) THEN
       pFormatGrp.Outer.Style.BackgroundColor=COLOR:NONE
       SELF.IReportGenerator.ProcessEllipse(pFormatGrp.Outer, '')
       IF pFormatGrp.Checked THEN
          SELF.IReportGenerator.ProcessEllipse(pFormatGrp.Inner, '')
       END
       lFont=SELF.Attribute.Extract(RepGen:PDF,TargetAttr:FontName,pExtendControlAttr)
       IF lFont THEN
          pFormatGrp.Prompt.Face = lFont
       END
       pFormatGrp.Prompt.Angle = 0
       SELF.IReportGenerator.ProcessString(pFormatGrp.Prompt, Text,'')
    END

PDFReportGenerator.IReportGenerator.ProcessArc      PROCEDURE(*ArcFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
 !NOT SUPPORTED

PDFReportGenerator.IReportGenerator.ProcessChord      PROCEDURE(*ChordFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
 !NOT SUPPORTED

PDFReportGenerator.IReportGenerator.ProcessPie          PROCEDURE(SliceFormatQueue pSliceFormatQueue, *PosGrp pPosGroup, STRING pExtendControlAttr)
lIndex      USHORT
 CODE
 !NOT SUPPORTED

PDFReportGenerator.IReportGenerator.ProcessPolygon  PROCEDURE(PointQueue pPointQueue, *StyleGrp pStyleGrp, STRING pExtendControlAttr)
lIndex      USHORT
lPExist     BYTE
  CODE
    lPExist=False
    LOOP lIndex=1 to RECORDS(pPointQueue)
         GET(pPointQueue,lIndex)
         IF ERRORCODE() THEN BREAK.
         IF lIndex=1 THEN
            lPExist=True
            SELF.DrawPolygon(pStyleGrp.BackgroundColor,pStyleGrp.BorderColor,pStyleGrp.BorderWidth,pStyleGrp.BorderStyle)
         END
         SELF.DrawPolygonCorner(pPointQueue.XPos,pPointQueue.YPos)
    END
    IF lPExist=True THEN
       SELF.DrawPolygonClose()
    END

PDFReportGenerator.IReportGenerator.ProcessGroup        PROCEDURE(*GroupFormatGrp pFormatGrp, STRING Text, STRING pExtendControlAttr)
lRect GROUP(RectFormatGrp).
lLine GROUP(LineFormatGrp).
lFont       STRING(12)
 CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:PDF,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    SELF.ProcessHiddenControlSize(pFormatGrp.Pos,pExtendControlAttr)
    lRect.Pos = pFormatGrp.Pos
    lRect.Ell_width =0
    lRect.Ell_height=0
    lRect.Style.BackgroundColor=COLOR:NONE
    lRect.Style.BorderColor    =pFormatGrp.LineColor
    lRect.Style.BorderWidth    =pFormatGrp.LineWidth
    lRect.Style.BorderStyle    =PEN:solid

    lLine.Pos.Top    = lRect.Pos.Top
    lLine.Pos.Left   = pFormatGrp.X1
    lLine.Pos.Bottom = lRect.Pos.Top
    lLine.Pos.Right  = pFormatGrp.X2
    lLine.Color      = COLOR:WHITE
    lLine.Width      = pFormatGrp.LineWidth
    lLine.Style      = PEN:solid

    SELF.ProcessHyperlink(pFormatGrp.Pos, Text, pExtendControlAttr)
    SELF.ProcessBookMark(pFormatGrp.Pos, Text, pExtendControlAttr)

    IF NOT SELF.Attribute.Extract(RepGen:PDF,TargetAttr:HIDE,pExtendControlAttr) THEN
       SELF.IReportGenerator.ProcessRectangle(lRect, '')
       SELF.IReportGenerator.ProcessLine(lLine, '')
       lFont=SELF.Attribute.Extract(RepGen:PDF,TargetAttr:FontName,pExtendControlAttr)
       IF lFont THEN
          pFormatGrp.header.Face = lFont
       END
       pFormatGrp.header.Angle = 0
       SELF.IReportGenerator.ProcessString(pFormatGrp.header, Text,'')
    END

PDFReportGenerator.IReportGenerator.ProcessText     PROCEDURE(TextFormatQueue TextFormatQ, STRING pExtendControlAttr)
lActionType BYTE
lIndex      USHORT
lValue      STRING(MAXAttributeSize)
lFont       STRING(12)
  CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:PDF,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    lActionType = SELF.Attribute.Extract(RepGen:PDF,TargetAttr:PDFActionType,pExtendControlAttr)
    GET(TextFormatQ, 1)
    IF ERRORCODE() THEN
       RETURN
    END
    IF lActionType=PDFHLType:Annotation THEN
       lValue = SELF.Attribute.Extract(RepGen:PDF,TargetAttr:Annotation,pExtendControlAttr)
       IF CLIP(lValue)=TargetAttr:Annotation THEN
          lValue = ''
          LOOP lIndex = 1 TO RECORDS(TextFormatQ)
            GET(TextFormatQ, lIndex)
            lValue = CLIP(lValue)&CLIP(TextFormatQ.Text)
          END
          IF CLIP(lValue) THEN
             SELF.DrawAnnotation(TextFormatQ.Format.Pos.Left,TextFormatQ.Format.Pos.Top,CLIP(lValue))
          END
       ELSE
          SELF.DrawAnnotation(TextFormatQ.Format.Pos.Left,TextFormatQ.Format.Pos.Top,CLIP(lValue))
       END
    ELSE
       SELF.ProcessHyperlink(TextFormatQ.Format.Pos, '', pExtendControlAttr)
    END

    SELF.ProcessBookMark(TextFormatQ.Format.Pos, '', pExtendControlAttr)

    IF TextFormatQ.Format.BackgroundColor<>COLOR:NONE THEN
       IF (TextFormatQ.Format.Pos.Right-TextFormatQ.Format.Pos.Left)>0 AND (TextFormatQ.Format.Pos.Bottom-TextFormatQ.Format.Pos.Top)>0
           SELF.DrawSetPenStyle(PEN:solid)
           SELF.DrawSetPenColor(TextFormatQ.Format.BackgroundColor)
           SELF.DrawSetPenWidth(0)
           SELF.DrawBox(TextFormatQ.Format.Pos.Left,TextFormatQ.Format.Pos.Top,TextFormatQ.Format.Pos.Right-TextFormatQ.Format.Pos.Left,TextFormatQ.Format.Pos.Bottom-TextFormatQ.Format.Pos.Top,TextFormatQ.Format.BackgroundColor)
       END
    END

    IF NOT SELF.Attribute.Extract(RepGen:PDF,TargetAttr:HIDE,pExtendControlAttr) THEN
       lFont=SELF.Attribute.Extract(RepGen:PDF,TargetAttr:FontName,pExtendControlAttr)
       IF lFont THEN
          TextFormatQ.Format.Face = lFont
          TextFormatQ.Format.Angle= 0
       END
       LOOP lIndex = 1 TO RECORDS(TextFormatQ)
         GET(TextFormatQ, lIndex)
         IF TextFormatQ.Text THEN
            TextFormatQ.Format.Pos.Right   =0
            TextFormatQ.Format.Pos.Left    =0
            TextFormatQ.Format.Pos.Bottom  =0
            TextFormatQ.Format.Pos.Top     =0
            SELF.IReportGenerator.ProcessString(TextFormatQ.Format, TextFormatQ.Text,'')
         END
       END
    END

PDFReportGenerator.ProcessHyperlink        PROCEDURE(PosGrp pPos, STRING Text, STRING pExtendControlAttr)
lActionType BYTE
lValue      STRING(MAXAttributeSize)
lValue2     STRING(MAXAttributeSize)
lValue0     CSTRING(MAXAttributeSize+1)
 CODE
    IF NOT CLIP(pExtendControlAttr) THEN
       RETURN False
    END
    lActionType = SELF.Attribute.Extract(RepGen:PDF,TargetAttr:PDFActionType,pExtendControlAttr)
    IF lActionType=PDFHLType:HyperLink OR lActionType=PDFHLType:Command OR lActionType=PDFHLType:PageAction THEN
       IF SELF.Attribute.IsValid(RepGen:PDF,TargetAttr:HyperBoxColor,pExtendControlAttr) THEN
          SELF.SetHyperLinkBoxed(True)
          SELF.SetHyperLinkBoxColor(SELF.Attribute.Extract(RepGen:PDF,TargetAttr:HyperBoxColor,pExtendControlAttr))
       ELSE
          SELF.SetHyperLinkBoxed(False)
       END
    END
    CASE lActionType
    OF PDFHLType:HyperLink
       lValue0 = SELF.Attribute.Extract(RepGen:PDF,TargetAttr:HyperlinkType,pExtendControlAttr)
       lValue  = SELF.Attribute.Extract(RepGen:PDF,TargetAttr:Hyperlink,pExtendControlAttr)
       IF lValue = TargetAttr:Hyperlink THEN
          lValue = Text
       END
       IF CLIP(lValue) THEN
          SELF.DrawRegionLink(pPos.Left,pPos.Top,pPos.Right-pPos.Left,pPos.Bottom-pPos.Top,PDFHLType:HyperLink,lValue0&CLIP(lValue))
          RETURN True
       END
    OF PDFHLType:Command
       lValue = SELF.Attribute.Extract(RepGen:PDF,TargetAttr:CommandLine,pExtendControlAttr)
       IF CLIP(lValue) THEN
          lValue2 = SELF.Attribute.Extract(RepGen:PDF,TargetAttr:CommandLineParam,pExtendControlAttr)
          SELF.DrawRegionLink(pPos.Left,pPos.Top,pPos.Right-pPos.Left,pPos.Bottom-pPos.Top,PDFHLType:Command,CLIP(lValue),CLIP(lValue2))
          RETURN True
       END
    OF PDFHLType:Annotation
       lValue = SELF.Attribute.Extract(RepGen:PDF,TargetAttr:Annotation,pExtendControlAttr)
       IF lValue = TargetAttr:Annotation THEN
          lValue = Text
       END
       IF CLIP(lValue) THEN
          SELF.DrawAnnotation(pPos.Left,pPos.Top,CLIP(lValue))
          RETURN True
       END
    OF PDFHLType:PageAction
       lValue = SELF.Attribute.Extract(RepGen:PDF,TargetAttr:PageAction,pExtendControlAttr)
       IF CLIP(lValue) THEN
          SELF.DrawRegionLink(pPos.Left,pPos.Top,pPos.Right-pPos.Left,pPos.Bottom-pPos.Top,PDFHLType:PageAction,CLIP(lValue))
          RETURN True
       END
    END
    RETURN False

PDFReportGenerator.ProcessBookMark         PROCEDURE(PosGrp pPos, STRING Text, STRING pExtendControlAttr)
lValue      STRING(MAXAttributeSize)
lValue2     STRING(MAXAttributeSize)
 CODE
    IF NOT CLIP(pExtendControlAttr) THEN
       RETURN False
    END
    lValue = SELF.Attribute.Extract(RepGen:PDF,TargetAttr:Bookmark,pExtendControlAttr)
    IF CLIP(lValue) = TargetAttr:Bookmark THEN
       lValue = Text
    END
    IF CLIP(lValue) THEN
       lValue2 = SELF.Attribute.Extract(RepGen:PDF,TargetAttr:BookmarkParent,pExtendControlAttr)
       SELF.AddBookMark(pPos.Left,pPos.Top,CLIP(lValue),CLIP(lValue2))
       RETURN True
    END
    RETURN False

PDFReportGenerator.ProcessHiddenControlSize PROCEDURE(*PosGrp pPos,STRING pExtendControlAttr)
lWidth   LONG,AUTO
lHeight  LONG,AUTO
 CODE
       lWidth  = 0
       lHeight = 0
       lWidth  = SELF.Attribute.Extract(RepGen:ALL,TargetAttr:HideWidth,pExtendControlAttr)
       lHeight = SELF.Attribute.Extract(RepGen:ALL,TargetAttr:HideHeight,pExtendControlAttr)
       IF lWidth OR lHeight THEN
           pPos.Right = pPos.Left + lWidth
           pPos.Bottom= pPos.Top  + lHeight
       END

PDFReportGenerator.IReportGenerator.SetResultQueue      PROCEDURE(OutputFileQueue pOutputFile)
 CODE
    SELF.OutputFileQueue &= pOutputFile
    FREE(SELF.OutputFileQueue)

PDFReportGenerator.IReportGenerator.SupportResultQueue  PROCEDURE()
 CODE
 RETURN True
