    MEMBER
INCLUDE('ABPRTEXT.INC'),ONCE
INCLUDE('ABERROR.INC'),ONCE
    PRAGMA('link(EXP_TXT.ICO)')
    MAP
    END

TextGenerator.CONSTRUCT               PROCEDURE()
 CODE
    SELF.Rows &= NEW(QueueRows)
    SELF.CheckBoxString     ='[X]'
    SELF.UnCheckBoxString   ='[_]'
    SELF.RadioButtonString  ='(*)'
    SELF.UnRadioButtonString='(_)'
    SELF.LVLine             = '|'
    SELF.RVLine             = '|'
    SELF.THLine             = '-'
    SELF.BHLine             = '-'
    SELF.LTCorner           = '/'
    SELF.RTCorner           = '\'
    SELF.LBCorner           = '\'
    SELF.RBCorner           = '/'

    SELF.TextFill[1]        = ' '
    SELF.TextFill[2]        = CHR(176) !Using the TERMINAL FONT
    SELF.TextFill[3]        = CHR(177)
    SELF.TextFill[4]        = CHR(178)
    SELF.TextFill[5]        = CHR(219)

    SELF.Output &= NEW(TargetGenerator)

TextGenerator.DESTRUCT                PROCEDURE()
 CODE
    DISPOSE(SELF.Output)
    FREE(SELF.Rows)
    DISPOSE(SELF.Rows)

TextGenerator.Init                    PROCEDURE(<STRING TargetFileName>)
 CODE
    FREE(SELF.Rows)
    SELF.PageLen  = 0
    SELF.PageOpen = False
    SELF.OmitRowOverflow = False
    SELF.SetPagesAsDifferentFile(False)
    SELF.PageNo   = 0
    IF OMITTED(2) THEN
       SELF.Output.Init()
    ELSE
       SELF.Output.Init(TargetFileName)
    END
    SELF.Setup()

TextGenerator.SetUp                   PROCEDURE()
 CODE

TextGenerator.SetFileName              PROCEDURE(STRING pFileName)
 CODE
    SELF.Output.SetOriginalFileName(pFileName)

TextGenerator.SetMargin               PROCEDURE(BYTE pInitialMargin=0,BYTE pTopMargin=0,BYTE pBottomMargin=0,BYTE pLeftMargin=0)
 CODE
    SELF.SetInitialMargin(pInitialMargin)
    SELF.SetTopMargin(pTopMargin)
    SELF.SetBottomMargin(pBottomMargin)
    SELF.SetLeftMargin(pLeftMargin)
TextGenerator.SetInitialMargin        PROCEDURE(BYTE pInitialMargin)
 CODE
    SELF.InitialMargin = pInitialMargin
TextGenerator.SetTopMargin            PROCEDURE(BYTE pTopMargin)
 CODE
    SELF.TopMargin = pTopMargin
TextGenerator.SetBottomMargin         PROCEDURE(BYTE pBottomMargin)
 CODE
    SELF.BottomMargin = pBottomMargin
TextGenerator.SetLeftMargin           PROCEDURE(BYTE pLeftMargin)
 CODE
    SELF.LeftMargin = pLeftMargin
TextGenerator.SetPageLen              PROCEDURE(BYTE pPageLen)
 CODE
    SELF.PageLen = pPageLen
TextGenerator.DrawText                PROCEDURE(USHORT pCol,USHORT pRow,STRING pText)
lColEnd         USHORT
lTextLen        USHORT
 CODE
    IF SELF.PageOpen = False THEN RETURN.
    IF pRow>SELF.PageLen THEN
       IF SELF.OmitRowOverflow THEN
          RETURN
       ELSE
          pRow = SELF.PageLen
       END
    END
    IF pCol<=MaxTextGeneratorLineLen THEN
       lTextLen = LEN(pText)
       lColEnd = pCol+lTextLen-1
       IF lColEnd>MaxTextGeneratorLineLen THEN
          lColEnd  = MaxTextGeneratorLineLen
          lTextLen = MaxTextGeneratorLineLen-pCol+1
       END
       GET(SELF.Rows,pRow)
       IF NOT ERRORCODE() THEN
          SELF.Rows.Line[(pCol):(lColEnd)] = pText[1:(lTextLen)]
          IF lColEnd>SELF.Rows.LineLen THEN
             SELF.Rows.LineLen = lColEnd
          END
          PUT(SELF.Rows)
       END
    END
TextGenerator.InsertText              PROCEDURE(USHORT pCol,USHORT pRow,STRING pText)
lTextLen        USHORT
 CODE
    IF SELF.PageOpen = False THEN RETURN.
    IF pRow>SELF.PageLen THEN
       IF SELF.OmitRowOverflow THEN
          RETURN
       ELSE
          pRow = SELF.PageLen
       END
    END
    IF pCol<=MaxTextGeneratorLineLen THEN
       GET(SELF.Rows,pRow)
       IF NOT ERRORCODE() THEN
          IF pCol>SELF.Rows.LineLen THEN
             SELF.DrawText(pCol,pRow,pText)
          ELSE
             lTextLen = LEN(pText)
             SELF.Rows.Line = SELF.Rows.Line[1:(pCol-1)]&pText[1:(lTextLen)]&SELF.Rows.Line[(pCol):(SELF.Rows.LineLen)]
             SELF.Rows.LineLen +=lTextLen
             IF SELF.Rows.LineLen>MaxTextGeneratorLineLen THEN
                SELF.Rows.LineLen=MaxTextGeneratorLineLen
             END
             PUT(SELF.Rows)
          END
       END
    END
TextGenerator.OpenDocument            PROCEDURE()
 CODE
    SELF.PageNo = 0
    IF SELF.PagesAsDifferentFile = False THEN
       SELF.Output.OpenFile()
    END
TextGenerator.CloseDocument           PROCEDURE()
 CODE
    IF SELF.PagesAsDifferentFile = False THEN
       SELF.FlushPages()
       SELF.Output.CloseFile()
       SELF.Output.SetFileName('')
    END
TextGenerator.StartPage               PROCEDURE()
lIndex  SHORT
 CODE
    SELF.PageNo+=1
    FREE(SELF.Rows)
    LOOP lIndex=1 to SELF.PageLen
         SELF.Rows.Line = ALL(' ',MaxTextGeneratorLineLen)
         SELF.Rows.LineLen = 0
         ADD(SELF.Rows)
    END
    SELF.PageOpen = True
    IF SELF.PagesAsDifferentFile = True THEN
       !GENERATE FILE NAME
       SELF.Output.SetFileNameFromOriginal(SELF.PageNo,SELF.TotalPageNo)
       SELF.Output.OpenFile()
    END

TextGenerator.EndPage                 PROCEDURE()
 CODE
    SELF.FlushPages()
    IF SELF.PagesAsDifferentFile = True THEN
       SELF.Output.CloseFile()
       SELF.Output.SetFileName('')
    END
    SELF.PageOpen = False
    
TextGenerator.FlushPages              PROCEDURE()
lIndex  SHORT
 CODE
    IF NOT RECORDS(SELF.Rows) THEN
       RETURN
    END
    IF SELF.PageNo=1 THEN
       LOOP SELF.InitialMargin TIMES
            SELF.Output.WriteLine('')
       END
    END
    LOOP SELF.TopMargin TIMES
         SELF.Output.WriteLine('')
    END
    LOOP lIndex=1 to RECORDS(SELF.Rows)
         GET(SELF.Rows,lIndex)
         IF ERRORCODE() THEN BREAK.
         SELF.Output.WriteLine(ALL(' ',SELF.LeftMargin)&SELF.Rows.Line[1:(SELF.Rows.LineLen)])
    END
    LOOP SELF.BottomMargin TIMES
         SELF.Output.WriteLine('')
    END
    FREE(SELF.Rows)

TextGenerator.SetPagesAsDifferentFile  PROCEDURE(BYTE pTrue=1)
 CODE
    SELF.PagesAsDifferentFile = pTrue

TextGenerator.SetPageSize             PROCEDURE(SHORT pPageType,USHORT pWidth=0,USHORT pHeight=0)
LOC:Width  USHORT
LOC:Height USHORT
 CODE

!tabloid 93
!leter 60
!legal 77
!foil 71
!fanfold usa 60
!fanfold ger 66
!env monarch 42
!env b6 28
!env b5 54
!env b4 76
!env 9 49
!b5 56
!b4 76
!a4 64
!a3 90 

   CASE pPageType
   OF PAPER:FANFOLD_US
      LOC:Width  = 14875
      LOC:Height = 11000 !60   183.33333333333333333333333333333
   OF PAPER:FANFOLD_STD_GERMAN
      LOC:Width  = 8500
      LOC:Height = 12000 !66   181.81818181818181818181818181818
   OF PAPER:LETTER
      LOC:Width  = 8500
      LOC:Height = 11000 !60   180.32786885245901639344262295082
   OF PAPER:LETTERSMALL
      LOC:Width  = 8500
      LOC:Height = 11000
   OF PAPER:TABLOID
      LOC:Width  = 11000
      LOC:Height = 17000 !93   182.79569892473118279569892473118
   OF PAPER:LEDGER
      LOC:Width  = 17000
      LOC:Height = 11000
   OF PAPER:LEGAL
      LOC:Width  = 8500
      LOC:Height = 14000 !77   181.81818181818181818181818181818
   OF PAPER:STATEMENT
      LOC:Width  = 5500
      LOC:Height = 8500
   OF PAPER:EXECUTIVE
      LOC:Width  = 7250
      LOC:Height = 10500
   OF PAPER:FOLIO
      LOC:Width  = 8500
      LOC:Height = 13000 !71   183.09859154929577464788732394366
   OF PAPER:ENV_MONARCH
      LOC:Width  = 3875
      LOC:Height = 7500 !42    178.57142857142857142857142857143
   OF PAPER:A3
      LOC:Width  = 11688
      LOC:Height = 16500 !90   183.33333333333333333333333333333
   OF PAPER:A4
      LOC:Width  = 8250 
      LOC:Height = 11688 !64   182.625
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
   OF PAPER:ENV_PERSONAL
      LOC:Width  = 3625
      LOC:Height = 6500
   OF PAPER:FANFOLD_LGL_GERMAN
      LOC:Width  = 8500
      LOC:Height = 13000
   ELSE
      LOC:Width  = pWidth
      LOC:Height = pHeight
   END
   SELF.SetPageLen(ROUND(pHeight/167,1))
TextGenerator.InchToRow               PROCEDURE(USHORT pInch)
lRow       USHORT
 CODE
    
 RETURN ROUND(pInch/166,1)+1

TextGenerator.InchToCol               PROCEDURE(USHORT pInch)
lCol       USHORT
 CODE
    
    !Still the majic number is missing to replace 612
 RETURN ROUND(pInch/93,1)+1
TextGenerator.SetCheckBoxString       PROCEDURE(STRING pChecked,STRING pUnChecked)
 CODE
    SELF.CheckBoxString     = pChecked
    SELF.UnCheckBoxString   = pUnChecked
TextGenerator.SetRadioButtonString    PROCEDURE(STRING pSelected,STRING pUnSelected)
 CODE
    SELF.RadioButtonString  = pSelected
    SELF.UnRadioButtonString= pUnSelected
TextGenerator.SetLineString           PROCEDURE(STRING pLVLine,STRING pRVLine,STRING pTHLine,STRING pBHLine,STRING pLTCorner,STRING pRTCorner,STRING pLBCorner,STRING pRBCorner)
 CODE
    SELF.LVLine   = pLVLine
    SELF.RVLine   = pRVLine
    SELF.THLine   = pTHLine
    SELF.BHLine   = pBHLine
    SELF.LTCorner = pLTCorner
    SELF.RTCorner = pRTCorner
    SELF.LBCorner = pLBCorner
    SELF.RBCorner = pRBCorner
TextGenerator.SetTextFillString       PROCEDURE(STRING pTextFill1,STRING pTextFill2,STRING pTextFill3,STRING pTextFill4,STRING pTextFill5)
 CODE
    SELF.TextFill[1] = pTextFill1
    SELF.TextFill[2] = pTextFill2
    SELF.TextFill[3] = pTextFill3
    SELF.TextFill[4] = pTextFill4
    SELF.TextFill[5] = pTextFill5

TextGenerator.DrawLine                PROCEDURE(USHORT pCol,USHORT pRow,USHORT Width ,USHORT Height,BYTE pTopOrLeft=1)
lIndex  USHORT
lLineStroke  STRING(1)
 CODE
    !Only horizontal or vertical lines are supported
    IF NOT (Height = 0 OR Width = 0) THEN
       RETURN
    END
    IF Height = 0 THEN
       !Horizontal
       IF pTopOrLeft THEN
          lLineStroke = SELF.THLine
       ELSE
          lLineStroke = SELF.BHLine
       END
       SELF.DrawText(pCol,pRow,ALL(lLineStroke,Width))
    ELSE
       !Vertical
       IF pTopOrLeft THEN
          lLineStroke = SELF.LVLine
       ELSE
          lLineStroke = SELF.RVLine
       END
       LOOP lIndex=pRow TO Height+pRow-1
            SELF.DrawText(pCol,lIndex,lLineStroke)
       END
    END
 
TextGenerator.DrawBox                 PROCEDURE(USHORT pCol,USHORT pRow,USHORT Width ,USHORT Height,<STRING Fill>)
lIndex  USHORT
 CODE
    SELF.DrawLine(pCol,pRow,Width ,0,1) !Top
    SELF.DrawLine(pCol,pRow+Height,Width ,0,0) !Bottom
    SELF.DrawLine(pCol,pRow,0 ,Height,1) !Left
    SELF.DrawLine(pCol+Width,pRow,0 ,Height,0) !Rigth

    SELF.DrawText(pCol,pRow,SELF.LTCorner) !Top - Left
    SELF.DrawText(pCol+Width,pRow,SELF.RTCorner) !Top - Rigth
    SELF.DrawText(pCol,pRow+Height,SELF.RTCorner) !Bottom - Left
    SELF.DrawText(pCol+Width,pRow+Height,SELF.RBCorner) !Bottom - Rigth
    IF NOT OMITTED(6) THEN
       LOOP lIndex=1 TO Height-1
            SELF.DrawText(pCol+1,pRow+lIndex,ALL(Fill[1],Width-1))
       END
    END

TextGenerator.DrawEllipse             PROCEDURE(USHORT pCol,USHORT pRow,USHORT Width ,USHORT Height,<STRING Fill>)
 CODE
    !NOT SUPPORTED YET

TextGenerator.ColorToTextFill         PROCEDURE(LONG pColor)
Delta                   SHORT
Min                     SHORT
LOC:RGBTriple           LONG
RGBT                    GROUP,OVER(LOC:RGBTriple)
R                          BYTE
G                          BYTE
B                          BYTE
NotUsed                    BYTE
                        END
LOC:H                   SHORT
LOC:S                   SHORT
LOC:V                   SHORT
LOC:TextFill            BYTE
  CODE
    IF pColor= COLOR:NONE THEN
       RETURN 1
    END
    LOC:RGBTriple=pColor
 
     IF RGBT.R<RGBT.G THEN
        IF RGBT.R<RGBT.B THEN
           Min =  RGBT.R
        ELSE
           Min =  RGBT.B
        END
     ELSE
        IF RGBT.G<RGBT.B THEN
           Min =  RGBT.G
        ELSE
           Min =  RGBT.B
        END
     END

     IF RGBT.R>RGBT.G THEN
        IF RGBT.R>RGBT.B THEN
           LOC:V =  RGBT.R
        ELSE
           LOC:V =  RGBT.B
        END
     ELSE
        IF RGBT.G>RGBT.B THEN
           LOC:V =  RGBT.G
        ELSE
           LOC:V =  RGBT.B
        END
     END

    Delta = LOC:V - Min
 
    ! Calculate saturation:  saturation is 0 if r, g and b are all 0
    IF LOC:V = 0 THEN
       LOC:S = 0
    ELSE
       LOC:S = Delta * 255 / LOC:V
    END
 
    IF LOC:S = 0 THEN
       LOC:H = 0      ! Achromatic:  When s = 0, h is undefined but assigned the value 0
    ELSE          ! Chromatic
       IF RGBT.R = LOC:V THEN  ! degrees -- between yellow and magenta
          LOC:H = (RGBT.G - RGBT.B)* 60 / Delta
       ELSE
         IF RGBT.G = LOC:V THEN ! between cyan and yellow
            LOC:H = 120 + ((RGBT.B-RGBT.R)*60/ Delta)
         ELSE
           IF RGBT.B = LOC:V THEN ! between magenta and cyan
              LOC:H = 240 + ((RGBT.R-RGBT.G)* 60/ Delta)
           END
         END
       END
       IF LOC:H < 0 THEN LOC:H = LOC:H + 360.
    END
    
    CASE LOC:V
    OF 51*0 TO 51*1
       LOC:TextFill = 1
    OF 51*1+1 TO 51*2
       LOC:TextFill = 2
    OF 51*2+1 TO 51*3
       LOC:TextFill = 3
    OF 51*3+1 TO 51*4
       LOC:TextFill = 4
    OF 51*4+1 TO 51*5
       LOC:TextFill = 5
    ELSE
       LOC:TextFill = 1
    END
    RETURN LOC:TextFill

TextReportGenerator.CONSTRUCT            PROCEDURE()
 CODE
    SELF.Attribute  &=NEW ReportAttributeManager
    SELF.OmitGraph = False
TextReportGenerator.DESTRUCT                             PROCEDURE()
 CODE
    DISPOSE(SELF.Attribute)

TextReportGenerator.SetOmitGraph            PROCEDURE(BYTE pValue)
 CODE
    SELF.OmitGraph = pValue

TextReportGenerator.IReportGenerator.Init                PROCEDURE(<ErrorClass EC>)
  CODE

TextReportGenerator.IReportGenerator.ProcessBand         PROCEDURE(STRING type, BYTE start)
  CODE
 !NOT SUPPORTED

TextReportGenerator.IReportGenerator.OpenDocument        PROCEDURE(UNSIGNED TotalPages)
 CODE
     SELF.TotalPageNo = TotalPages
     SELF.OpenDocument()
     RETURN Level:Benign

TextReportGenerator.IReportGenerator.CloseDocument       PROCEDURE()
 CODE
     IF SELF.PagesAsDifferentFile = False THEN
        IF NOT SELF.OutputFileQueue &= NULL THEN
           SELF.OutputFileQueue.FileName = SELF.Output.GetFileName()
           ADD(SELF.OutputFileQueue)
        END
     END
     SELF.CloseDocument()
     SELF.SetFileName('')
     RETURN Level:Benign

TextReportGenerator.IReportGenerator.OpenPage            PROCEDURE(SHORT pBoxLeft,SHORT pBoxTop,SHORT pBoxRight,SHORT pBoxBottom)
 CODE
     IF SELF.PageLen<=0 THEN
        SELF.SetPageSize(PAPER:USER,pBoxRight-pBoxLeft,pBoxBottom-pBoxTop)
     END
     SELF.StartPage()
     RETURN Level:Benign

TextReportGenerator.IReportGenerator.ClosePage           PROCEDURE()
 CODE
     IF SELF.PagesAsDifferentFile = True THEN
        IF NOT SELF.OutputFileQueue &= NULL THEN
           SELF.OutputFileQueue.FileName = SELF.Output.GetFileName()
           ADD(SELF.OutputFileQueue)
        END
     END
     SELF.EndPage()
     RETURN Level:Benign

TextReportGenerator.IReportGenerator.AskProperties       PROCEDURE(BYTE Force=0)
ReturnValue BYTE
LOC:FileName    STRING(143)
 CODE
     ReturnValue = Level:Benign
     SELF.Init()
     IF NOT CLIP(SELF.Output.GetFileName()) OR Force THEN
        LOC:FileName = ''
        IF NOT FILEDIALOG('Save as TXT File',LOC:FileName,'Text|*.TXT|All|*.*',FILE:LongName+FILE:Save+FILE:KeepDir) THEN
           ReturnValue = Level:Notify
        ELSE
           IF NOT INSTRING('.',LOC:FileName) THEN
              LOC:FileName=CLIP(LOC:FileName)&'.TXT'
           END
           SELF.Output.SetOriginalFileName(LOC:FileName)
        END
     END
     RETURN ReturnValue
TextReportGenerator.IReportGenerator.WhoAmI              PROCEDURE()
 CODE
     RETURN RepGen:TXT

TextReportGenerator.IReportGenerator.DisplayIcon         PROCEDURE()
 CODE
     RETURN '~EXP_TXT.ICO'

TextReportGenerator.IReportGenerator.DisplayName         PROCEDURE()
 CODE
     RETURN 'TEXT'

TextReportGenerator.IReportGenerator.ProcessString         PROCEDURE(*StringFormatGrp pFormatGrp, STRING Text, STRING pExtendControlAttr)
lRow       USHORT
lCol       USHORT
 CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:TXT,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END

    lCol = SELF.InchToCol(pFormatGrp.LeftText)
    lRow = SELF.InchToRow(pFormatGrp.TopText)

    SELF.DrawText(lCol,lRow,Text)

TextReportGenerator.IReportGenerator.ProcessLine         PROCEDURE(*LineFormatGrp pFormatGrp, STRING pExtendControlAttr)
lCol     USHORT
lRow     USHORT
lWidth   USHORT
lHeight  USHORT
 CODE
    IF SELF.OmitGraph THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:TXT,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    lCol    = SELF.InchToCol(pFormatGrp.Pos.Left)
    lRow    = SELF.InchToRow(pFormatGrp.Pos.Top)
    lWidth  = SELF.InchToCol(pFormatGrp.Pos.Right-pFormatGrp.Pos.Left)
    lHeight = SELF.InchToRow(pFormatGrp.Pos.Bottom-pFormatGrp.Pos.Top)
    IF lWidth=1 THEN lWidth=0.
    IF lHeight=1 THEN lHeight=0.
    SELF.DrawLine(lCol,lRow,lWidth ,lHeight)

TextReportGenerator.IReportGenerator.ProcessArc      PROCEDURE(*ArcFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
 !NOT SUPPORTED

TextReportGenerator.IReportGenerator.ProcessChord      PROCEDURE(*ChordFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
 !NOT SUPPORTED

TextReportGenerator.IReportGenerator.ProcessEllipse      PROCEDURE(*EllipseFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
 !NOT SUPPORTED BY THE FORMAT

TextReportGenerator.IReportGenerator.ProcessRectangle    PROCEDURE(*RectFormatGrp pFormatGrp, STRING pExtendControlAttr)
 CODE
    IF SELF.OmitGraph THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:TXT,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
   IF pFormatGrp.Style.BackgroundColor>-1 THEN
      SELF.DrawBox(SELF.InchToCol(pFormatGrp.Pos.Left),SELF.InchToRow(pFormatGrp.Pos.Top),SELF.InchToCol(pFormatGrp.Pos.Right-pFormatGrp.Pos.Left),SELF.InchToRow(pFormatGrp.Pos.Bottom-pFormatGrp.Pos.Top),SELF.TextFill[SELF.ColorToTextFill(pFormatGrp.Style.BackgroundColor)])
   ELSE
      SELF.DrawBox(SELF.InchToCol(pFormatGrp.Pos.Left),SELF.InchToRow(pFormatGrp.Pos.Top),SELF.InchToCol(pFormatGrp.Pos.Right-pFormatGrp.Pos.Left),SELF.InchToRow(pFormatGrp.Pos.Bottom-pFormatGrp.Pos.Top))
   END

TextReportGenerator.IReportGenerator.ProcessImage        PROCEDURE(*ImageFormatGrp pFormatGrp, STRING iName, STRING pExtendControlAttr)
 CODE
 !NOT SUPPORTED BY THE FORMAT

TextReportGenerator.IReportGenerator.ProcessCheck        PROCEDURE(*CheckFormatGrp pFormatGrp, STRING Text, STRING pExtendControlAttr)
 CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:TXT,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END

   pFormatGrp.Prompt.LeftText=pFormatGrp.Pos.Left
   pFormatGrp.Prompt.TopText =pFormatGrp.Pos.Top
   IF pFormatGrp.Checked THEN
      SELF.IReportGenerator.ProcessString(pFormatGrp.Prompt, CLIP(SELF.CheckBoxString)&Text,pExtendControlAttr)
   ELSE
      SELF.IReportGenerator.ProcessString(pFormatGrp.Prompt, CLIP(SELF.UnCheckBoxString)&Text,pExtendControlAttr)
   END

TextReportGenerator.IReportGenerator.ProcessRadio        PROCEDURE(*RadioFormatGrp pFormatGrp, STRING Text, STRING pExtendControlAttr)
 CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:TXT,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
   pFormatGrp.Prompt.LeftText=pFormatGrp.Outer.Pos.Left
   pFormatGrp.Prompt.TopText =pFormatGrp.Outer.Pos.Top
   IF pFormatGrp.Checked THEN
      SELF.IReportGenerator.ProcessString(pFormatGrp.Prompt, CLIP(SELF.RadioButtonString)&Text,pExtendControlAttr)
   ELSE
      SELF.IReportGenerator.ProcessString(pFormatGrp.Prompt, CLIP(SELF.UnRadioButtonString)&Text,pExtendControlAttr)
   END

TextReportGenerator.IReportGenerator.ProcessPie          PROCEDURE(SliceFormatQueue pSliceFormatQueue, *PosGrp pPosGroup, STRING pExtendControlAttr)
 CODE
  !NOT SUPPORTED

TextReportGenerator.IReportGenerator.ProcessPolygon  PROCEDURE(PointQueue pPointQueue, *StyleGrp pStyleGrp, STRING pExtendControlAttr)
  CODE
  !NOT SUPPORTED

TextReportGenerator.IReportGenerator.ProcessGroup        PROCEDURE(*GroupFormatGrp pFormatGrp, STRING Text, STRING pExtendControlAttr)
lRect GROUP(RectFormatGrp).
lLine GROUP(LineFormatGrp).
 CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:TXT,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    lRect.Pos = pFormatGrp.Pos
    lRect.Pos.Top   =pFormatGrp.header.Pos.Top
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

    SELF.IReportGenerator.ProcessRectangle(lRect, pExtendControlAttr)

    SELF.DrawText(SELF.InchToCol(lLine.Pos.Left),SELF.InchToRow(lLine.Pos.Top),ALL(' ',SELF.InchToCol(lLine.Pos.Right-lLine.Pos.Left)))

    SELF.IReportGenerator.ProcessString(pFormatGrp.header, Text,pExtendControlAttr)

TextReportGenerator.IReportGenerator.ProcessText     PROCEDURE(TextFormatQueue TextFormatQ, STRING pExtendControlAttr)
lIndex      USHORT
  CODE
    IF SELF.Attribute.Extract(RepGen:ALL,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    IF SELF.Attribute.Extract(RepGen:TXT,TargetAttr:SKIP,pExtendControlAttr) THEN
       RETURN
    END
    LOOP lIndex = 1 TO RECORDS(TextFormatQ)
      GET(TextFormatQ, lIndex)
      SELF.IReportGenerator.ProcessString(TextFormatQ.Format, TextFormatQ.Text,pExtendControlAttr)
    END  

TextReportGenerator.IReportGenerator.SetResultQueue      PROCEDURE(OutputFileQueue pOutputFile)
 CODE
    SELF.OutputFileQueue &= pOutputFile
    FREE(SELF.OutputFileQueue)

TextReportGenerator.IReportGenerator.SupportResultQueue  PROCEDURE()
 CODE
 RETURN True
