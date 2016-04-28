

   MEMBER('cookbook.clw')                             ! This is a MEMBER module


   INCLUDE('abbrowse.inc'),ONCE
   INCLUDE('abreport.inc'),ONCE

                     MAP
                       INCLUDE('COOKB012.INC'),ONCE        !Local module procedure declarations
                     END


PrintRIM:ingrediantkey PROCEDURE                      !Generated from procedure template - Report

Progress:Thermometer BYTE
Process:View         VIEW(rimap)
                       PROJECT(RIM:id)
                       PROJECT(RIM:ingrediant_id)
                       PROJECT(RIM:recipe_id)
                     END
ProgressWindow       WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

report               REPORT,AT(1000,1540,6000,7460),PRE(RPT),FONT('Arial',10,,),THOUS
                       HEADER,AT(1000,1000,6000,540)
                         STRING('Print the rimap File by RIM:ingrediantkey'),AT(0,20,6000,220),CENTER,FONT(,,,FONT:bold)
                         BOX,AT(0,260,6000,280),COLOR(COLOR:Black),FILL(COLOR:Silver)
                         LINE,AT(2000,260,0,280),COLOR(COLOR:Black)
                         LINE,AT(4000,260,0,280),COLOR(COLOR:Black)
                         STRING('id'),AT(50,310,1900,170),TRN
                         STRING('recipe id'),AT(2050,310,1900,170),TRN
                         STRING('ingrediant id'),AT(4050,310,1900,170),TRN
                       END
detail                 DETAIL,AT(,,6000,280),USE(?detail)
                         LINE,AT(2000,0,0,280),COLOR(COLOR:Black)
                         LINE,AT(4000,0,0,280),COLOR(COLOR:Black)
                         STRING(@n-14),AT(50,50,1900,170),USE(RIM:id),RIGHT(1)
                         STRING(@n-14),AT(2050,50,1900,170),USE(RIM:recipe_id),RIGHT(1)
                         STRING(@n-14),AT(4050,50,1900,170),USE(RIM:ingrediant_id),RIGHT(1)
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
  GlobalErrors.SetProcedureName('PrintRIM:ingrediantkey')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  Relate:rimap.Open
  SELF.FilesOpened = True
  OPEN(ProgressWindow)
!  SELF.setICON()
  SELF.Opened=True
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:rimap, ?Progress:PctText, Progress:Thermometer, ProgressMgr, RIM:ingrediant_id)
  ThisReport.AddSortOrder(RIM:ingrediantkey)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:rimap.SetQuickScan(1,Propagate:OneMany)
  Previewer.AllowUserZoom=True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:rimap.Close
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

