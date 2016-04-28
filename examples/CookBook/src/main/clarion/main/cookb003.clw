

   MEMBER('cookbook.clw')                             ! This is a MEMBER module


   INCLUDE('abbrowse.inc'),ONCE
   INCLUDE('abreport.inc'),ONCE

                     MAP
                       INCLUDE('COOKB003.INC'),ONCE        !Local module procedure declarations
                     END


PrintING:Keyid PROCEDURE                              !Generated from procedure template - Report

Progress:Thermometer BYTE
Process:View         VIEW(ingredients)
                       PROJECT(ING:cost)
                       PROJECT(ING:id)
                       PROJECT(ING:name)
                       PROJECT(ING:shelflife)
                     END
ProgressWindow       WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

report               REPORT,AT(1000,1540,6000,7460),PRE(RPT),FONT('Arial',10,,),THOUS
                       HEADER,AT(1000,1000,6000,540)
                         STRING('Print the ingredients File by ING:Keyid'),AT(0,20,6000,220),CENTER,FONT(,,,FONT:bold)
                         BOX,AT(0,260,6000,280),COLOR(COLOR:Black),FILL(COLOR:Silver)
                         LINE,AT(1500,260,0,280),COLOR(COLOR:Black)
                         LINE,AT(3000,260,0,280),COLOR(COLOR:Black)
                         LINE,AT(4500,260,0,280),COLOR(COLOR:Black)
                         STRING('id'),AT(50,310,1400,170),TRN
                         STRING('name'),AT(1550,310,1400,170),TRN
                         STRING('shelflife'),AT(3050,310,1400,170),TRN
                         STRING('cost'),AT(4550,310,1400,170),TRN
                       END
detail                 DETAIL,AT(,,6000,280),USE(?detail)
                         LINE,AT(1500,0,0,280),COLOR(COLOR:Black)
                         LINE,AT(3000,0,0,280),COLOR(COLOR:Black)
                         LINE,AT(4500,0,0,280),COLOR(COLOR:Black)
                         STRING(@n11),AT(50,50,1400,170),USE(ING:id),RIGHT(1)
                         STRING(@s50),AT(1550,50,1400,170),USE(ING:name)
                         STRING(@n6),AT(3050,50,1400,170),USE(ING:shelflife),RIGHT(1)
                         STRING(@n10.2),AT(4550,50,1400,170),USE(ING:cost),DECIMAL(12)
                         LINE,AT(50,280,5900,0),COLOR(COLOR:Black)
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

ProgressMgr          StepLongClass                    !Progress Manager
Previewer            PrintPreviewClass                !Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PrintING:Keyid')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  Relate:ingredients.Open
  SELF.FilesOpened = True
  OPEN(ProgressWindow)
!  SELF.setICON()
  SELF.Opened=True
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:ingredients, ?Progress:PctText, Progress:Thermometer, ProgressMgr, ING:id)
  ThisReport.AddSortOrder(ING:Keyid)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:ingredients.SetQuickScan(1,Propagate:OneMany)
  Previewer.AllowUserZoom=True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ingredients.Close
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

