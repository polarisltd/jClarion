

   MEMBER('Invoice.clw')                              ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('INVOI003.INC'),ONCE        !Local module procedure declarations
                     END


PrintSelectedCustomer PROCEDURE                       !Generated from procedure template - Report

LocalRequest         LONG
FilesOpened          BYTE
Progress:Thermometer BYTE
LOC:CSZ              STRING(45)
LOC:Address          STRING(45)
Process:View         VIEW(Customers)
                       PROJECT(CUS:Address1)
                       PROJECT(CUS:Address2)
                       PROJECT(CUS:City)
                       PROJECT(CUS:Company)
                       PROJECT(CUS:Extension)
                       PROJECT(CUS:FirstName)
                       PROJECT(CUS:LastName)
                       PROJECT(CUS:MI)
                       PROJECT(CUS:PhoneNumber)
                       PROJECT(CUS:State)
                       PROJECT(CUS:ZipCode)
                     END
ProgressWindow       WINDOW('Report Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
                       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,46,15),USE(?Progress:Cancel),FLAT,LEFT,FONT(,,COLOR:Green,FONT:bold),TIP('Cancel Printing'),ICON(ICON:NoPrint)
                     END

report               REPORT,AT(1000,1167,6500,9104),PRE(RPT),FONT('MS Serif',8,,FONT:regular),THOUS
                       HEADER,AT(1000,500,6500,760)
                         STRING('Customer Information'),AT(21,10,6448,354),USE(?String16),CENTER,FONT('MS Serif',18,,FONT:bold+FONT:underline)
                       END
detail                 DETAIL,AT(10,,6500,1500),USE(?detail)
                         STRING('Name:'),AT(1146,94,1844,167),TRN,FONT('MS Serif',10,,FONT:regular)
                         STRING(@s35),AT(3083,94,2604,167),USE(GLOT:CustName)
                         STRING('Company:'),AT(1146,354,1844,167),TRN,FONT('MS Serif',10,,FONT:regular)
                         STRING(@P<<<#PB),AT(3948,1135,333,167),USE(CUS:Extension),RIGHT
                         STRING(@s20),AT(3083,354,1719,167),USE(CUS:Company)
                         STRING('Address:'),AT(1146,615,1844,167),USE(?String12),TRN
                         STRING(@s45),AT(3083,615,2667,167),USE(LOC:Address)
                         STRING('City/State/Zip:'),AT(1146,875,1844,167),USE(?String11),TRN,FONT('MS Serif',10,,FONT:regular)
                         STRING(@s45),AT(3083,875,2552,167),USE(LOC:CSZ)
                         STRING(@P(###) ###-####PB),AT(3083,1135,865,167),USE(CUS:PhoneNumber)
                         STRING('Phone#/Extension:'),AT(1146,1135,1844,167),USE(?String13),TRN,FONT('MS Serif',10,,FONT:regular)
                       END
                       FOOTER,AT(1000,10260,6500,271)
                         STRING(@pPage <<<#p),AT(5229,31,729,188),PAGENO,USE(?PageCount),FONT('MS Serif',10,,FONT:regular)
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
  GlobalErrors.SetProcedureName('PrintSelectedCustomer')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  Relate:Customers.Open
  SELF.FilesOpened = True
  OPEN(ProgressWindow)
  SELF.Opened=True
  INIMgr.Fetch('PrintSelectedCustomer',ProgressWindow)
  ProgressMgr.Init(ScrollSort:AllowAlpha+ScrollSort:AllowNumeric,ScrollBy:RunTime)
  ThisReport.Init(Process:View, Relate:Customers, ?Progress:PctText, Progress:Thermometer, ProgressMgr, CUS:LastName)
  ThisReport.CaseSensitiveValue = FALSE
  ThisReport.AddSortOrder(CUS:KeyFullName)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,report,Previewer)
  ?Progress:UserString{Prop:Text}=''
  Relate:Customers.SetQuickScan(1,Propagate:OneMany)
  SELF.Zoom = PageWidth
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom=True
  Previewer.Maximize=True
  IF SELF.OriginalRequest = ProcessRecord
    CLEAR(SELF.DeferWindow,1)
    ThisReport.AddRange(CUS:MI)        ! Overrides any previous range
  END
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Customers.Close
  END
  IF SELF.Opened
    INIMgr.Update('PrintSelectedCustomer',ProgressWindow)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  GLOT:CustName = CLIP(CUS:FirstName) & '   ' & CLIP(CUS:LastName)
  IF (CUS:Address2 = '')
    LOC:Address = CUS:Address1
  ELSE
    LOC:Address = CLIP(CUS:Address1) & ',  ' & CUS:Address2
  END
  LOC:CSZ = CityStateZip(CUS:City,CUS:State,CUS:ZipCode)
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:detail)
  RETURN ReturnValue

CityStateZip         PROCEDURE  (LOC:City,LOC:State,LOC:Zip) ! Declare Procedure
  CODE
 !Format City, State, and Zip
  IF OMITTED(1) OR LOC:City = ''
    RETURN(LOC:State &'  '& LOC:Zip)
  ELSIF OMITTED(2) OR LOC:State = ''
    RETURN(CLIP(LOC:City) &',  '& LOC:Zip)
  ELSIF OMITTED(3) OR LOC:Zip = ''
    RETURN(CLIP(LOC:City) &',  '& LOC:State)
  ELSE
    RETURN(CLIP(LOC:City) &', '& LOC:State &'  '& LOC:Zip)
  END

