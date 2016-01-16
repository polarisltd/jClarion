

   MEMBER('musicdb6.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('MUSIC007.INC'),ONCE        !Local module procedure declarations
                     END


musicianReport PROCEDURE                                   ! Generated from procedure template - Report

Progress:Thermometer BYTE                                  !
Process:View         VIEW(musician)
                       PROJECT(MUS:name)
                     END
ProgressWindow       WINDOW('Report musician'),AT(,,142,59),FONT('MS Sans Serif',8,,FONT:regular),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(46,42,49,15),USE(?Progress:Cancel),FLAT,LEFT,MSG('Cancel Report'),TIP('Cancel Report'),ICON('WACANCEL.ICO')
                     END

Report               REPORT('musician Report'),AT(250,850,8000,9646),PAPER(PAPER:LETTER),PRE(RPT),FONT('MS Sans Serif',8,,FONT:regular),THOUS
                       HEADER,AT(250,250,8000,604),USE(?Header),FONT('MS Sans Serif',8,,FONT:regular)
                         STRING('Report musician file'),AT(0,20,8000,220),USE(?ReportTitle),CENTER,FONT('MS Sans Serif',8,,FONT:regular)
                         BOX,AT(0,350,8000,250),USE(?HeaderBox),COLOR(COLOR:Black)
                         STRING('name'),AT(50,390,7900,170),USE(?HeaderTitle:1),TRN
                       END
Detail                 DETAIL,AT(,,8000,250),USE(?Detail)
                         LINE,AT(0,0,0,250),USE(?DetailLine:0),COLOR(COLOR:Black)
                         LINE,AT(8000,0,0,250),USE(?DetailLine:1),COLOR(COLOR:Black)
                         STRING(@s40),AT(50,50,7900,170),USE(MUS:name),LEFT
                         LINE,AT(0,250,8000,0),USE(?DetailEndLine),COLOR(COLOR:Black)
                       END
                       FOOTER,AT(250,10500,8000,250),USE(?Footer)
                         STRING('Date:'),AT(115,52,344,135),USE(?ReportDatePrompt,,?ReportDatePrompt:2),TRN,FONT('Arial',8,,FONT:regular)
                         STRING('<<-- Date Stamp -->'),AT(490,52,927,135),USE(?ReportDateStamp,,?ReportDateStamp:2),TRN,FONT('Arial',8,,FONT:regular)
                         STRING('Time:'),AT(1625,52,271,135),USE(?ReportTimePrompt,,?ReportTimePrompt:2),TRN,FONT('Arial',8,,FONT:regular)
                         STRING('<<-- Time Stamp -->'),AT(1927,52,927,135),USE(?ReportTimeStamp,,?ReportTimeStamp:2),TRN,FONT('Arial',8,,FONT:regular)
                         STRING(@pPage <<#p),AT(6950,52,700,135),PAGENO,USE(?PageCount,,?PageCount:2),FONT('Arial',8,,FONT:regular)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

ProgressMgr          StepStringClass                       ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It's called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('musicianReport')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:musician.Open                                     ! File musician used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  OPEN(ProgressWindow)                                     ! Open window
  SELF.Opened=True
  Do DefineListboxStyle
  INIMgr.Fetch('musicianReport',ProgressWindow)            ! Restore window settings from non-volatile store
  ProgressMgr.Init(ScrollSort:AllowAlpha+ScrollSort:AllowNumeric,ScrollBy:RunTime)
  ThisReport.Init(Process:View, Relate:musician, ?Progress:PctText, Progress:Thermometer, ProgressMgr, MUS:name)
  ThisReport.CaseSensitiveValue = FALSE
  ThisReport.AddSortOrder(MUS:namekey)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:musician.SetQuickScan(1,Propagate:OneMany)
  ProgressWindow{Prop:Timer} = 10                          ! Assign timer interval
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom=True
  Previewer.Maximize=True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:musician.Close
  END
  IF SELF.Opened
    INIMgr.Update('musicianReport',ProgressWindow)         ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ~ReturnValue
    SELF.Report $ ?ReportDateStamp:2{PROP:Text}=FORMAT(TODAY(),@D17)
  END
  IF ~ReturnValue
    SELF.Report $ ?ReportTimeStamp:2{PROP:Text}=FORMAT(CLOCK(),@T7)
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

