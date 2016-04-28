                     MEMBER('winlats.clw')        ! This is a MEMBER module
GetNodalas           FUNCTION (NODALA,OPC)        ! Declare Procedure
  CODE                                            ! Begin processed code
!
!   POZICIONÇ NODAÏAS UN ATGRIEÞ NOSAUKUMU
!

 IF NODALA
    IF NODALAS::USED=0
       CHECKOPEN(NODALAS,1)
    .
    NODALAS::USED+=1
    CLEAR(NOD:RECORD)
    NOD:U_NR=NODALA
    GET(NODALAS,NOD:NR_KEY)
    IF ERROR()
       RETURN('')
    .
    NODALAS::USED-=1
    IF NODALAS::USED=0
       CLOSE(NODALAS)
    .
 ELSE
    RETURN('')
 .
 EXECUTE OPC
   RETURN(NOD:NOS_P)
   RETURN(NOD:KODS)
 .
B_NodKops            PROCEDURE                    ! Declare Procedure
RejectRecord         LONG
LocalRequest         LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
NGGK                STRING(1)
NOSAUKUMS           STRING(30)
DEB                 DECIMAL(14,2)
KRE                 DECIMAL(14,2)
ATL                 DECIMAL(15,2)
DEBk                DECIMAL(14,2)
KREk                DECIMAL(14,2)
ATLk                DECIMAL(15,2)
LAI                 LONG
DAT                 LONG

N_TABLE             QUEUE,PRE(N)
DEB                     DECIMAL(14,2)
KRE                     DECIMAL(14,2)
NOS                     STRING(2)
                    END

CG                  STRING(10)
LINEH               STRING(190)
VIRSRAKSTS          STRING(80)

!-----------------------------------------------------------------------------
Process:View         VIEW(GGK)
                       PROJECT(GGK:BAITS)
                       PROJECT(GGK:BKK)
                       PROJECT(GGK:DATUMS)
                       PROJECT(GGK:D_K)
                       PROJECT(GGK:KK)
                       PROJECT(GGK:PAR_NR)
                       PROJECT(GGK:PVN_PROC)
                       PROJECT(GGK:PVN_TIPS)
                       PROJECT(GGK:REFERENCE)
                       PROJECT(GGK:RS)
                       PROJECT(GGK:SUMMA)
                       PROJECT(GGK:SUMMAV)
                       PROJECT(GGK:U_NR)
                       PROJECT(GGK:VAL)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(104,1469,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(104,198,8000,1271),USE(?unnamed)
         STRING(@s45),AT(1688,104,4583,260),USE(CLIENT),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(635,448,6667,260),USE(VIRSRAKSTS),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(6729,813,729,156),PAGENO,USE(?PAGECOUNT),RIGHT
         LINE,AT(729,990,6719,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Nr'),AT(781,1042,313,208),USE(?String12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izmaksas'),AT(5208,1042,1094,208),USE(?String12:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Rezultâts'),AT(6354,1042,1094,208),USE(?String69),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7448,990,0,313),USE(?Line2:14),COLOR(COLOR:Black)
         LINE,AT(729,1250,6719,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Ieòçmumi'),AT(4063,1042,1094,208),USE(?String12:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nodaïas nosaukums'),AT(1146,1042,2865,208),USE(?String12:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1094,990,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(4010,990,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(5156,990,0,313),USE(?Line2:8),COLOR(COLOR:Black)
         LINE,AT(6302,990,0,313),USE(?Line2:10),COLOR(COLOR:Black)
         LINE,AT(729,990,0,313),USE(?Line2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,177)
         STRING(@S30),AT(1198,10,1979,156),USE(NOSAUKUMS),LEFT
         LINE,AT(5156,-10,0,198),USE(?Line2:5),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(5260,10,885,156),USE(N:KRE),RIGHT
         LINE,AT(4010,-10,0,198),USE(?Line2:4),COLOR(COLOR:Black)
         STRING(@N-_14.2B),AT(4115,10,885,156),USE(N:DEB),RIGHT
         LINE,AT(6302,-10,0,198),USE(?Line2:9),COLOR(COLOR:Black)
         STRING(@N-_15.2B),AT(6406,10,938,156),USE(ATL),RIGHT
         LINE,AT(7448,-10,0,198),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(1094,-10,0,198),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@s2),AT(781,10,313,156),USE(N:NOS),CENTER
         LINE,AT(729,-10,0,198),USE(?Line2:3),COLOR(COLOR:Black)
       END
RPT_FOOT1 DETAIL,AT(,-10,,604)
         LINE,AT(729,260,6719,0),USE(?Line651:4),COLOR(COLOR:Black)
         STRING('Sastâdîja :'),AT(990,365,573,208),USE(?String61),LEFT
         STRING(@S8),AT(1563,365,625,208),USE(ACC_kods),LEFT
         STRING(@d6),AT(6281,302,625,208),USE(dat),LEFT
         STRING(@t4),AT(6958,302,521,208),USE(lai),LEFT
         LINE,AT(5156,0,0,260),USE(?Line51),COLOR(COLOR:Black)
         LINE,AT(729,52,6719,0),USE(?Line651:34),COLOR(COLOR:Black)
         STRING('Kopâ:'),AT(885,104,521,156),USE(?String21),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@N-_14.2B),AT(4115,104,885,156),USE(DEBk),RIGHT
         STRING(@N-_14.2B),AT(5260,104,885,156),USE(KREk),RIGHT
         STRING(@N-_15.2B),AT(6406,104,938,156),USE(ATLk),RIGHT
         LINE,AT(7448,0,0,260),USE(?Line23:2),COLOR(COLOR:Black)
         LINE,AT(6302,0,0,260),USE(?Line23),COLOR(COLOR:Black)
         LINE,AT(4010,0,0,260),USE(?Line22),COLOR(COLOR:Black)
         LINE,AT(1094,0,0,63),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(729,0,0,260),USE(?Line845),COLOR(COLOR:Black)
       END
       FOOTER,AT(104,11000,8000,52)
         LINE,AT(729,0,6719,0),USE(?Line1:3),COLOR(COLOR:Black)
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND

  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CG',CG)
  BIND('CYCLEGGK',CYCLEGGK)

  DAT = TODAY()
  LAI = CLOCK()
  VIRSRAKSTS='6,7,81600,82600,81900,82900 kontu projektu kopsavilkums '&FORMAT(S_DAT,@D06.)&'-'&FORMAT(B_DAT,@D06.)

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Nodaïu kopsavilkums'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      GGK:BKK[1] = '6'
      CG = 'K11'
      SET(GGK:BKK_DAT,GGK:BKK_DAT)
      Process:View{Prop:Filter} = '~CYCLEGGK(CG)'
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      END
      OPEN(Process:View)
      IF ERRORCODE()
        StandardWarning(Warn:ViewOpenError)
      END
      LOOP
        DO GetNextRecord
        DO ValidateRecord
        CASE RecordStatus
          OF Record:Ok
            BREAK
          OF Record:OutOfRange
            LocalResponse = RequestCancelled
            BREAK
        END
      END
      IF LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
        CYCLE
      END
      IF F:DBF='W'
          OPEN(report)
          report{Prop:Preview} = PrintPreviewImage
      ELSE
          IF ~OPENANSI('NODKOPS.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE=CLIENT
          ADD(OUTFILEANSI)
          OUTA:LINE='Ieòçmumu/Izmaksu nodaïu kopsavilkums'
          ADD(OUTFILEANSI)
          OUTA:LINE=format(S_DAT,@d06.)&' - '&format(B_DAT,@d06.)
          ADD(OUTFILEANSI)
          OUTA:LINE='NR'&CHR(9)&'Nodaïas nosaukums'&CHR(9)&'Ieòçmumi'&CHR(9)&'Izmaksas'&CHR(9)&'Rezultâts'
          ADD(OUTFILEANSI)
      end
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        np#+=1
        ?Progress:UserString{Prop:Text}=NP#
        DISPLAY(?Progress:UserString)
        IF GGK:NODALA AND INRANGE(GGK:DATUMS,S_DAT,B_DAT)
!            STOP('DATE '&FORMAT(GGK:DATUMS,@D6))
!            STOP('NODALA '&GGK:NODALA)
!            STOP('KONTS '&GGK:BKK)
            GET(N_TABLE,0)
            N:NOS=GGK:NODALA
            GET(N_TABLE,N:NOS)
            IF ERROR()
                N:NOS= GGK:NODALA
                IF INSTRING(GGK:BKK[1],'6') OR INSTRING(GGK:BKK[1:3],'816')  OR INSTRING(GGK:BKK[1:3],'819')
                    N:DEB = GGK:SUMMA
                ELSIF INSTRING(GGK:BKK[1],'7') OR INSTRING(GGK:BKK[1:3],'826')  OR INSTRING(GGK:BKK[1:3],'829')
                    N:DEB = 0
                    N:KRE = GGK:SUMMA
                END
                ADD(N_TABLE)
                SORT(N_TABLE,N:NOS)
            ELSE
                IF INSTRING(GGK:BKK[1],'6') OR INSTRING(GGK:BKK[1:3],'816')  OR INSTRING(GGK:BKK[1:3],'819')
                    N:DEB += GGK:SUMMA
                ELSIF INSTRING(GGK:BKK[1],'7') OR INSTRING(GGK:BKK[1:3],'826')  OR INSTRING(GGK:BKK[1:3],'829')
                    N:KRE += GGK:SUMMA
                END
                PUT(N_TABLE)
            END
!            STOP('DEB '&N:DEB)
!            STOP('KRE '&N:KRE)
        END
        LOOP
          DO GetNextRecord
          DO ValidateRecord
          CASE RecordStatus
            OF Record:OutOfRange
              LocalResponse = RequestCancelled
              BREAK
            OF Record:OK
              BREAK
          END
        END
        IF LocalResponse = RequestCancelled
          LocalResponse = RequestCompleted
          BREAK
        END
        LocalResponse = RequestCancelled
      END
      IF LocalResponse = RequestCompleted
        CLOSE(ProgressWindow)
        BREAK
      END
    END
    CASE FIELD()
    OF ?Progress:Cancel
      CASE Event()
      OF Event:Accepted
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    END
  END
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    LOOP N#=1 TO RECORDS(N_TABLE)
      GET(N_TABLE,N#)
      NOSAUKUMS = GETNODALAS(N:NOS,1)
      ATL = N:DEB - N:KRE
      ATLk += ATL
      DEBk += N:DEB
      KREk += N:KRE
      IF F:DBF='W'
        PRINT(RPT:DETAIL)
      ELSE
          OUTA:LINE=N:NOS&CHR(9)&NosaukumS&CHR(9)&LEFT(FORMAT(N:DEB,@N-_14.2))&CHR(9)&LEFT(FORMAT(N:KRE,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATL,@N-_15.2))
          ADD(OUTFILEANSI)
      END
    END
    ATLk = DEBk - KREk
    IF F:DBF='W'
        PRINT(RPT:RPT_FOOT1)
    ELSE
        OUTA:LINE='KOPÂ:'&CHR(9)&CHR(9)&LEFT(FORMAT(DEBk,@N-_14.2))&CHR(9)&LEFT(FORMAT(KREk,@N-_14.2))&CHR(9)&LEFT(FORMAT(ATLk,@N-_15.2))
        ADD(OUTFILEANSI)
    END
    ENDPAGE(report)
    CLOSE(ProgressWindow)
    IF F:DBF='W'
        RP
        IF Globalresponse = RequestCompleted
           loop J#=1 to PR:SKAITS
              report{Prop:FlushPreview} = True
              IF ~(J#=PR:SKAITS)
                 loop I#= 1 to RECORDS(PrintPreviewQueue1)
                    GET(PrintPreviewQueue1,I#)
                    PrintPreviewImage=PrintPreviewImage1
                    add(PrintPreviewQueue)
                 .
              .
           .
        END
    ELSE
        ANSIJOB
    .
  .
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE           !RTF,EXCEL
     CLOSE(OUTFILEANSI)
     ANSIFILENAME=''
  .
  DO ProcedureReturn
!-----------------------------------------------------------------------------------------------------------------------------------------
ProcedureReturn  ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
!|
!| Next, GlobalResponse is assigned a value to signal the calling procedure
!| what happened in this procedure.
!|
!| Next, we replace the BINDings that were in place when the procedure initialized
!| (and saved with PUSHBIND) using POPBIND.
!|
!| Finally, we return to the calling procedure.
!|
  IF FilesOpened
    GGK::Used -= 1
    IF GGK::Used = 0 THEN CLOSE(GGK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!-----------------------------------------------------------------------------
ValidateRecord       ROUTINE
!|
!| This routine is used to provide for complex record filtering and range limiting. This
!| routine is only generated if you've included your own code in the EMBED points provided in
!| this routine.
!|
  RecordStatus = Record:OutOfRange
  IF LocalResponse = RequestCancelled THEN EXIT.
  RecordStatus = Record:OK
  EXIT
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR ~INSTRING(GGK:BKK[1],'67')
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'GGK')
    END
    LocalResponse = RequestCancelled
    EXIT
  ELSE
    LocalResponse = RequestCompleted
  END
  RecordsProcessed += 1
  RecordsThisCycle += 1
  IF PercentProgress < 100
    PercentProgress = (RecordsProcessed / RecordsToProcess)*100
    IF PercentProgress > 100
      PercentProgress = 100
    END
    IF PercentProgress <> Progress:Thermometer THEN
      Progress:Thermometer = PercentProgress
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% analizçti'
      DISPLAY()
    END
  END
GetNom_Valoda        FUNCTION (NOMEN,RET)         ! Declare Procedure

  CODE                                            ! Begin processed code
!
! RET 2-ANGLISKI
!     3-KRIEVISKI
!     4-IR ATRASTS NOM_C RAKSTS
!

 IF ~INRANGE(RET,1,4)
     STOP('NOM_C:PIEPRASÎTS ATGRIEZT RET='&RET)
     RETURN('')
 .
 IF NOM_C::USED=0
    CHECKOPEN(NOM_C,1)
 .
 NOM_C::USED+=1
 IF NOMEN
    CLEAR(NOC:RECORD)
    NOC:NOMENKLAT=NOMEN
    GET(NOM_C,NOC:NOM_KEY)
    IF ERROR()
        RET=1
    .
 ELSE
    RET=1
 .
 NOM_C::USED-=1
 IF NOM_C::USED=0
    CLOSE(NOM_C)
 .
 EXECUTE(RET)
    RETURN('')
    RETURN(NOC:NOSAUKUMS_A)
    RETURN(NOC:NOSAUKUMS_C)
    RETURN(TRUE)             !IR ATRASTA
 .
