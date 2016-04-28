    MEMBER
 INCLUDE('ABRPPSEL.INC'),ONCE
    MAP
    END
 PRAGMA ('link (EXP_PRI.ICO)')
ReportTargetSelectorClass.CONSTRUCT          PROCEDURE()
 CODE
    SELF.Horizontal =6
    SELF.Stretch    =1
    SELF.QPlugIn &= NEW(TargetReportGeneratorQueue)

ReportTargetSelectorClass.DESTRUCT           PROCEDURE()
 CODE
    FREE(SELF.QPlugIn)
    DISPOSE(SELF.QPlugIn)
    
ReportTargetSelectorClass.SetSize            PROCEDURE(BYTE pHorizontal=6,BYTE pStretch=1)
 CODE
    SELF.Stretch    = pStretch
    SELF.Horizontal = pHorizontal
    
ReportTargetSelectorClass.AddItem            PROCEDURE(IReportGenerator pPlugIn,BYTE pEnableOnPreview=1)
 CODE
    SELF.QPlugIn.ReportGenerator &= pPlugIn
    SELF.QPlugIn.EnableOnPreview  = pEnableOnPreview
    ADD(SELF.QPlugIn)
    
ReportTargetSelectorClass.Items              PROCEDURE()
 CODE
    RETURN RECORDS(SELF.QPlugIn)
    
ReportTargetSelectorClass.GetSelected        PROCEDURE()
 CODE
     IF SELF.GetPrintSelected() THEN
        ASSERT(False,'Printer was selected as the output,it is not expected to call this method: GetSelected')
        RETURN ''
     ELSE
        ASSERT(~SELF.PlugInSelected&=NULL,'PlugIn not selected method: GetSelected')
        RETURN SELF.PlugInSelected
     END

ReportTargetSelectorClass.GetPrintSelected      PROCEDURE()
 CODE
    IF SELF.WithPrinter THEN
       RETURN SELF.PrintSelected
    ELSE
       RETURN False
    END
ReportTargetSelectorClass.ASK                PROCEDURE(BYTE pWithPrinter=0,BYTE pFromPreview=0)
lButton_W         SHORT(32)
lButton_H         SHORT(36)
lLeft_Margin      SHORT(2)
lTop_Margin       SHORT(2)
lSeparation       SHORT(2)
lPlugInChoice     SHORT
lFirstFeq         SHORT
lFEQ              LONG
lIndexH           SHORT
lIndex            SHORT
lHOR              SHORT
lVER              SHORT
lHorizontal       SHORT
lPrinterFEQ       LONG
lOK               BYTE

PlugInChoiceWindow WINDOW('Select an Output'),AT(,,103,30),FONT('Arial',8,COLOR:Black,FONT:regular,CHARSET:ANSI),CENTER,IMM,SYSTEM,GRAY,DOUBLE,MASK
       OPTION,AT(0,0,16,12),USE(lPlugInChoice,,?lPlugInChoice),FONT('Arial',8,COLOR:Black,FONT:regular,CHARSET:ANSI)
       END
       BUTTON('&OK'),AT(1,14,47,14),USE(?BOk),LEFT,ICON('WAOk.ico'),DEFAULT,FONT('MS Sans Serif',8,,FONT:regular)
       BUTTON('&Cancel'),AT(55,14,47,14),USE(?BCancel),LEFT,ICON('WACancel.ico'),FONT('MS Sans Serif',8,,FONT:regular)
     END

 CODE
  SELF.WithPrinter = pWithPrinter
  IF pWithPrinter THEN
     IF RECORDS(SELF.QPlugIn)=0 THEN
        SELF.PrintSelected   = True
        RETURN True
     END
     pWithPrinter = 1
  ELSE
     IF RECORDS(SELF.QPlugIn)=1 THEN
        GET(SELF.QPlugIn,1)
        SELF.PlugInSelected &= SELF.QPlugIn.ReportGenerator
        SELF.PrintSelected   = False
        RETURN True
     END
  END
  lOK=False
  Do PrepareWindow
  OPEN(PlugInChoiceWindow)
  Do CreateControls
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
      SELECT(?BOk)
    END
    CASE FIELD()
    OF ?BOk
      CASE EVENT()
      OF EVENT:Accepted
        lOK=True
        POST(Event:CloseWindow)
      END
    OF ?BCancel
      CASE EVENT()
      OF EVENT:Accepted
        lOK=False
        POST(Event:CloseWindow)
      END
    END
  END
  IF lOK THEN
     IF NOT pWithPrinter THEN
        GET(SELF.QPlugIn,lPlugInChoice)
        SELF.PlugInSelected &= SELF.QPlugIn.ReportGenerator
        SELF.PrintSelected = False
     ELSE
        IF lPlugInChoice=1 THEN
           SELF.PrintSelected = True
        ELSE
           GET(SELF.QPlugIn,(lPlugInChoice-1))
           SELF.PlugInSelected &= SELF.QPlugIn.ReportGenerator
           SELF.PrintSelected = False
        END
     END
  END
  RETURN lOK
PrepareWindow  ROUTINE
   lButton_W = 32
   lButton_H = 36
   lHorizontal=SELF.Horizontal
   IF SELF.Stretch THEN
      IF lHorizontal>(RECORDS(SELF.QPlugIn)+pWithPrinter) THEN
         lHorizontal=RECORDS(SELF.QPlugIn)+pWithPrinter
      ELSE
         IF (RECORDS(SELF.QPlugIn)+pWithPrinter)=lHorizontal+1 THEN
            lHorizontal+=1
         END
      END
   END

   IF lHorizontal<3 THEN
      lHorizontal = 3
   END
CreateControls  ROUTINE
   lIndexH=0
   lVER=lTop_Margin
   lHOR=lLeft_Margin
   LOOP lIndex=1 TO RECORDS(SELF.QPlugIn)+pWithPrinter
        lIndexH+=1
        IF lIndexH>lHorizontal THEN
           lIndexH=1
           lHOR=lLeft_Margin
           lVER=lVER+lButton_H+lSeparation
        END

        lFEQ=CREATE( 0 , CREATE:radio,?lPlugInChoice)
        lFEQ{PROP:Value}=lIndex
        lFEQ{PROP:FLAT}=True
        IF NOT(lIndex=1 AND pWithPrinter) THEN
           GET(SELF.QPlugIn,lIndex-pWithPrinter)
           lFEQ{PROP:ICON}=SELF.QPlugIn.ReportGenerator.DisplayIcon()
           lFEQ{PROP:TEXT}=SELF.QPlugIn.ReportGenerator.DisplayName()
        ELSE
           lFEQ{PROP:Value}=1 !The printer is always the first icon
           lPrinterFEQ=lFEQ
           lFEQ{PROP:ICON}='~EXP_PRI.ICO'
           lFEQ{PROP:Text}='Print'
        END
        SETPOSITION(lFEQ,lHOR,lVER,lButton_W,lButton_H)
        UNHIDE(lFEQ)
        IF lIndex=1 THEN
           lFirstFeq    =lFEQ
        END
        lHOR=lHOR+lButton_W+lSeparation
   END
   lPlugInChoice=1
   ?lPlugInChoice{PROP:SELECTED}=1
   lHOR=(lButton_W+lSeparation)*lHorizontal + 2
   ?BCancel{PROP:Width}=lButton_W+(lSeparation/2)+(lButton_W/2)
   ?BOk{PROP:Width}=?BCancel{PROP:Width}
   lVER=lVER+2*lSeparation+?BCancel{PROP:Height}+lButton_H+lSeparation
   ?BCancel{PROP:XPos}=lHOR-?BCancel{PROP:Width}-lSeparation
   ?BOk{PROP:XPos}= ?BCancel{PROP:XPos}-lSeparation-?BOk{PROP:Width}
   ?BCancel{PROP:YPos}=lVER-lSeparation-?BCancel{PROP:Height}
   ?BOk{PROP:YPos}=?BCancel{PROP:YPos}
   PlugInChoiceWindow{PROP:AT,3}=lHOR
   PlugInChoiceWindow{PROP:AT,4}=lVER

ReportTargetSelectorClass.FillQueue               PROCEDURE(QUEUE QueueToFill,BYTE ColumnToFill=1)
lColumn ANY
lIndex  SHORT
 CODE
    FREE(QueueToFill)
    IF RECORDS(SELF.QPlugIn)
       lColumn &= WHAT(QueueToFill,ColumnToFill)
       LOOP lIndex=1 TO RECORDS(SELF.QPlugIn)
            GET(SELF.QPlugIn,lIndex)
            IF ERRORCODE() THEN BREAK.
            lColumn = SELF.QPlugIn.ReportGenerator.DisplayName()
            ADD(QueueToFill)

       END
    END
    
ReportTargetSelectorClass.GetReportGenerator      PROCEDURE(STRING GeneratorName)
lIndex  SHORT
 CODE
       IF NUMERIC(GeneratorName) THEN
          lIndex=GeneratorName
          GET(SELF.QPlugIn,lIndex)
          IF NOT ERRORCODE() THEN
             RETURN SELF.QPlugIn.ReportGenerator
          END
          ASSERT(False,'The number "'&GeneratorName&'" is not a valid Generator: GetReportGenerator')
       ELSE
          LOOP lIndex=1 TO RECORDS(SELF.QPlugIn)
               GET(SELF.QPlugIn,lIndex)
               IF ERRORCODE() THEN BREAK.
               IF UPPER(CLIP(GeneratorName))=UPPER(SELF.QPlugIn.ReportGenerator.DisplayName()) THEN
                  RETURN SELF.QPlugIn.ReportGenerator
               END
          END
          ASSERT(False,'The name "'&GeneratorName&'" is not a valid Generator Name: GetReportGenerator')
       END
       RETURN NULL

ReportTargetSelectorClass.GetReportGeneratorName  PROCEDURE(SHORT GeneratorPos)
 CODE
          GET(SELF.QPlugIn,GeneratorPos)
          IF NOT ERRORCODE() THEN
             RETURN SELF.QPlugIn.ReportGenerator.DisplayName()
          END
          ASSERT(False,'The number "'&GeneratorPos&'" is not a valid Generator: GetReportGeneratorName')
          RETURN ''
