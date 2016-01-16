

   MEMBER('cookbook.clw')                             ! This is a MEMBER module


   INCLUDE('abbrowse.inc'),ONCE
   INCLUDE('abreport.inc'),ONCE

                     MAP
                       INCLUDE('COOKB008.INC'),ONCE        !Local module procedure declarations
                     END


PrintREC:Keytype PROCEDURE                            !Generated from procedure template - Report

Progress:Thermometer BYTE
Process:View         VIEW(recipe)
                       PROJECT(REC:cooking)
                       PROJECT(REC:cooktime)
                       PROJECT(REC:id)
                       PROJECT(REC:name)
                       PROJECT(REC:preparation)
                       PROJECT(REC:preptime)
                       PROJECT(REC:type)
                     END
ProgressWindow       WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

report               REPORT,AT(1000,1720,6000,7280),PRE(RPT),FONT('Arial',10,,),THOUS
                       HEADER,AT(1000,1000,6000,720)
                         STRING('Print the recipe File by REC:Keytype'),AT(0,20,6000,220),CENTER,FONT(,,,FONT:bold)
                         BOX,AT(0,260,6000,460),COLOR(COLOR:Black),FILL(COLOR:Silver)
                         LINE,AT(1500,260,0,460),COLOR(COLOR:Black)
                         LINE,AT(3000,260,0,460),COLOR(COLOR:Black)
                         LINE,AT(4500,260,0,460),COLOR(COLOR:Black)
                         STRING('id'),AT(50,310,1400,170),TRN
                         STRING('name'),AT(1550,310,1400,170),TRN
                         STRING('type'),AT(3050,310,1400,170),TRN
                         STRING('preparation'),AT(4550,310,1400,170),TRN
                         STRING('cooking'),AT(50,490,1400,170),TRN
                         STRING('cooktime'),AT(1550,490,1400,170),TRN
                         STRING('preptime'),AT(3050,490,1400,170),TRN
                       END
detail                 DETAIL,AT(,,6000,460),USE(?detail)
                         LINE,AT(1500,0,0,460),COLOR(COLOR:Black)
                         LINE,AT(3000,0,0,460),COLOR(COLOR:Black)
                         LINE,AT(4500,0,0,460),COLOR(COLOR:Black)
                         STRING(@n11),AT(50,50,1400,170),USE(REC:id),RIGHT(1)
                         STRING(@s50),AT(1550,50,1400,170),USE(REC:name)
                         STRING(@s30),AT(3050,50,1400,170),USE(REC:type)
                         STRING(@s255),AT(4550,50,1400,170),USE(REC:preparation)
                         STRING(@s255),AT(50,230,1400,170),USE(REC:cooking)
                         STRING(@n4),AT(1550,230,1400,170),USE(REC:cooktime),RIGHT(1)
                         STRING(@n4),AT(3050,230,1400,170),USE(REC:preptime),RIGHT(1)
                         LINE,AT(50,460,5900,0),COLOR(COLOR:Black)
                       END
                       FOOTER,AT(1000,9000,6000,219)
                         STRING(@pPage <<<#p),AT(5250,30,700,135),PAGENO,USE(?PageCount),FONT('Arial',8,,FONT:regular)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)              !Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepStringClass                  !Progress Manager
Previewer            PrintPreviewClass                !Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PrintREC:Keytype')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  Relate:recipe.Open
  SELF.FilesOpened = True
  OPEN(ProgressWindow)
!  SELF.setICON()
  SELF.Opened=True
  ProgressMgr.Init(ScrollSort:AllowAlpha+ScrollSort:AllowNumeric,ScrollBy:RunTime)
  ThisReport.Init(Process:View, Relate:recipe, ?Progress:PctText, Progress:Thermometer, ProgressMgr, REC:type)
  ThisReport.CaseSensitiveValue = FALSE
  ThisReport.AddSortOrder(REC:Keytype)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:recipe.SetQuickScan(1,Propagate:OneMany)
  Previewer.AllowUserZoom=True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:recipe.Close
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail)
  RETURN ReturnValue

