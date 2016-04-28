                     MEMBER('winlats.clw')        ! This is a MEMBER module
AtlikumiN            PROCEDURE (d_k_NEW,nomenklat_NEW,D_NEW,d_k_old,nomenklat_old,D_OLD,LocNr) ! Declare Procedure
NOL_DAUDZUMS       LIKE(NOL:DAUDZUMS)
DAUDZUMS_OLD       LIKE(NOL:DAUDZUMS)
DAUDZUMS_NEW       LIKE(NOL:DAUDZUMS)
NOL_D_K            STRING(1)
SAV_NOA_RECORD     LIKE(NOA:RECORD)
  CODE                                            ! Begin processed code
!
! saraksta A-failâ 1-D-K-P, ignorç R neatkarîgi no RS
!

 DAUDZUMS_OLD = D_OLD  !REÂÏUS NEDRÎKST SALÎDZINÂT !!!
 DAUDZUMS_NEW = D_NEW

 IF NOM_A::USED=0
    CHECKOPEN(NOM_A,1)
 .
 NOM_A::USED+=1
 IF ~LocNr THEN LocNr=LOC_NR.
 IF ~DAUDZUMS_OLD AND DAUDZUMS_NEW      !IEVADÎÐANA
    IF GETNOM_A(NOMENKLAT_NEW,9,1)      !CHECK FOR EXIST
       NOL_DAUDZUMS=DAUDZUMS_NEW
       NOL_D_K=D_K_NEW
       DO PLUSATLIKUMI
       PUTNOM_A#=TRUE
    .
 ELSIF DAUDZUMS_OLD AND DAUDZUMS_NEW    !MAINÎÐANA
    IF NOMENKLAT_OLD=NOMENKLAT_NEW      !NOMENKLATÛRA NAV MAINÎTA
       IF ~(DAUDZUMS_OLD=DAUDZUMS_NEW AND D_K_OLD=D_K_NEW)
          IF GETNOM_A(NOMENKLAT_NEW,9,1)
             NOL_DAUDZUMS=-DAUDZUMS_OLD
             NOL_D_K=D_K_OLD
             DO PLUSATLIKUMI
             NOL_DAUDZUMS=DAUDZUMS_NEW
             NOL_D_K=D_K_NEW
             DO PLUSATLIKUMI
             PUTNOM_A#=TRUE
          .
       .
    ELSE
       IF GETNOM_A(NOMENKLAT_NEW,9,1)
          NOL_DAUDZUMS=DAUDZUMS_NEW
          NOL_D_K=D_K_NEW
          DO PLUSATLIKUMI
          IF GNET
             DO BREMZE
          .
          IF RIUPDATE:NOM_A()
             KLUDA(24,'NOM_A:ATLIKUMI')
          ELSE
             ERROR#=W_INET(1,NOA:NOMENKLAT)  !0-OK
          .
          PUTNOM_A#=FALSE
          IF GETNOM_A(NOMENKLAT_OLD,9,1) !IZSAUCAM TO, KAS BIJA SÂKUMÂ
             NOL_DAUDZUMS=-DAUDZUMS_OLD
             NOL_D_K=D_K_OLD
             DO PLUSATLIKUMI
             PUTNOM_A#=TRUE
          .
       .
    .
 ELSIF DAUDZUMS_OLD AND ~DAUDZUMS_NEW    !DZÇÐANA
    IF GETNOM_A(NOMENKLAT_OLD,9,1)
       NOL_DAUDZUMS=-DAUDZUMS_OLD
       NOL_D_K=D_K_OLD
       DO PLUSATLIKUMI
       PUTNOM_A#=TRUE
    .
 .
 IF PUTNOM_A#=TRUE
    IF GNET
       DO BREMZE
    .
    IF RIUPDATE:NOM_A()
       KLUDA(24,'NOM_A:ATLIKUMI')
    ELSE
       ERROR#=W_INET(1,NOA:NOMENKLAT) !0-OK
    .
 .
 NOM_A::USED-=1
 IF NOM_A::USED=0
    CLOSE(NOM_A)
 .

!-------------------------------------------------
PLUSATLIKUMI  ROUTINE
   CASE NOL_D_K
   OF '1'
      NOA:D_PROJEKTS[LocNr]+=NOL_DAUDZUMS
   OF 'D'
      NOA:ATLIKUMS[LocNr]+=NOL_DAUDZUMS
   OF 'K'
      NOA:ATLIKUMS[LocNr]-=NOL_DAUDZUMS
   OF 'P'
      NOA:K_PROJEKTS[LocNr]+=NOL_DAUDZUMS
   .

!-------------------------------------------------
BREMZE  ROUTINE
   IF NOA:GNET_FLAG[3] AND ~(NOA:GNET_FLAG[3]=CHR(LocNr)) !CITÂ LOKÂLÂ TÎKLA NOLIKTAVÂ JAU MAINÎTS
      SAV_NOA_RECORD=NOA:RECORD
      CLOCK#=CLOCK()
      LOOP
         I# = GETNOM_A(NOA:NOMENKLAT,9,1)                 !PÂRLASAM FAILU
          IF CLOCK() > CLOCK#+1000  OR ~NOA:GNET_FLAG[3]  !10 SEKUNDES  VAI SERVERIS NOMETIS KAROGU
            NOA:RECORD=SAV_NOA_RECORD
            BREAK
         .
      .
   .
   IF ~(NOA:GNET_FLAG[1]=1) !SITUÂCIJA, KAD IEVADÎTA JAUNA NOMENKLATÛRA,MAINÎTS ATLIKUMS UN SERVERIS NOSPRÂDZIS
      NOA:GNET_FLAG[1]=2
   .
   NOA:GNET_FLAG[2]=''
   NOA:GNET_FLAG[3]=CHR(LocNr) !ATCERAMIES,KURÂ NOLIKTAVÂ MAINÎTS

SPZ_PackLists1       PROCEDURE                    ! Declare Procedure
RejectRecord        LONG
LocalRequest        LONG
LocalResponse       LONG
FilesOpened         LONG
WindowOpened        LONG
RecordsToProcess    LONG,AUTO
RecordsProcessed    LONG,AUTO
RecordsPerCycle     LONG,AUTO
RecordsThisCycle    LONG,AUTO
PercentProgress     BYTE
RecordStatus        BYTE,AUTO

NR                  DECIMAL(3)
NOM_SER             STRING(21)
VIRSRAKSTS          STRING(80)
PAR_NOS_P           LIKE(PAR:NOS_P)
PAR_IZ_V            STRING(60)
DAT                 LONG
LAI                 LONG
sumk_bn             REAL
RET                 BYTE

P_TABLE             QUEUE,PRE(P)
NOSAUK              STRING(10)
NOSAUKUMS           STRING(50)
NOMENKLAT           STRING(21)
NOM_SER             STRING(21)
PLAUKTS             STRING(60)
EANCODE             DECIMAL(13)
DAUDZUMS            DECIMAL(12,3)
                .
DAUDZUMS_S          STRING(15)
VARDS               STRING(30)

!-----------------------------------------------------------------------------
Process:View         VIEW(NOLIK)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:DATUMS)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:IEPAK_D)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:VAL)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:SUMMA)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:U_NR)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(198,1708,8000,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,198,8000,1510),USE(?unnamed)
         STRING('PACKING LIST'),AT(3281,104),USE(?String1),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s80),AT(260,365,6875,208),USE(VIRSRAKSTS),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(1844,625,3906,208),USE(PAR_NOS_P),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s60),AT(1198,885,5208,260),USE(PAR_IZ_V),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@P<<<#. lapaP),AT(7167,990),PAGENO,USE(?PageCount),RIGHT
         LINE,AT(156,1198,0,313),USE(?Line2),COLOR(COLOR:Black)
         STRING('Nr'),AT(208,1250,313,208),USE(?String9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nosaukums'),AT(573,1250,1927,208),USE(?String10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Plaukts'),AT(6406,1250,1094,208),USE(?SYS:NOKL_TE),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Daudzums'),AT(5365,1250,885,208),USE(?String14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7552,1198,0,313),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(6302,1198,0,313),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(156,1458,7396,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('EAN-code'),AT(4323,1250,938,208),USE(?String12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5260,1198,0,313),USE(?Line2:7),COLOR(COLOR:Black)
         STRING(@s21),AT(2552,1250,1719,208),USE(NOM_SER),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4271,1198,0,313),USE(?Line2:4),COLOR(COLOR:Black)
         LINE,AT(521,1198,0,313),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(2500,1198,0,313),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(156,1198,7396,0),USE(?Line1),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,156)
         LINE,AT(156,-10,0,176),USE(?Line9),COLOR(COLOR:Black)
         STRING(@N3),AT(208,0,,156),USE(NR),RIGHT
         LINE,AT(521,-10,0,176),USE(?Line9:1),COLOR(COLOR:Black)
         LINE,AT(2500,-10,0,176),USE(?Line9:3),COLOR(COLOR:Black)
         STRING(@s21),AT(2604,0,,156),USE(P:NOM_SER),LEFT,FONT('Courier New',9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4271,-10,0,176),USE(?Line9:4),COLOR(COLOR:Black)
         STRING(@n_13),AT(4323,0,833,156),USE(P:EANCODE),RIGHT
         LINE,AT(5260,-10,0,176),USE(?Line9:6),COLOR(COLOR:Black)
         STRING(@s30),AT(563,0,1927,156),USE(P:NOSAUKUMS),LEFT
         LINE,AT(6302,-10,0,176),USE(?Line9:5),COLOR(COLOR:Black)
         STRING(@s20),AT(6344,0,1198,156),USE(P:PLAUKTS),LEFT
         STRING(@s15),AT(5313,0,938,156),USE(DAUDZUMS_S),RIGHT
         LINE,AT(7552,-10,0,176),USE(?Line9:2),COLOR(COLOR:Black)
       END
Page_foot DETAIL,AT(,,,313),USE(?unnamed:2)
         LINE,AT(156,52,7396,0),USE(?Line1:3),COLOR(COLOR:Black)
         LINE,AT(521,-10,0,63),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(2500,-10,0,63),USE(?Line18),COLOR(COLOR:Black)
         STRING(@D06.),AT(6521,104),USE(DAT),RIGHT,FONT(,7,,,CHARSET:ANSI)
         STRING(@T4),AT(7115,104),USE(LAI),RIGHT,FONT(,7,,,CHARSET:ANSI)
         LINE,AT(6302,-10,0,63),USE(?Line20),COLOR(COLOR:Black)
         LINE,AT(7552,-10,0,63),USE(?Line21),COLOR(COLOR:Black)
         LINE,AT(4271,-10,0,63),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(5260,-10,0,63),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(156,-10,0,63),USE(?Line16),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,11150,8000,52)
         LINE,AT(156,0,7396,0),USE(?Line1:4),COLOR(COLOR:Black)
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

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(NOLIK,1)
  CHECKOPEN(PAVAD,1)
  IF ~GETPAVADZ(PAV::U_NR)  !STARTS IZSAUKUMÂ KAUT KÂ NOJAUC
     STOP('ATVEROT PAVAD'&ERROR())
  .

  DAT =  TODAY()
  LAI =  CLOCK()
  VIRSRAKSTS='pavadzîme Nr '&CLIP(PAV:DOK_SENR)&' no '&FORMAT(PAV:DATUMS,@D06.)&' '&CLIP(PAV:PAMAT)
  PAR_NOS_P=GETPAR_K(PAV:PAR_NR,2,3)
  par_iz_v=GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
  CASE sys:nom_cit
  OF 'A'
    nom_ser='Kataloga Nr'
    RET=5  !return from GETNOM_K
!  OF 'K'   --ATSEVIÐÍA KOLONNA
!    nom_ser='Kods'
!    RET=4
  OF 'C'
    nom_ser=SYS:NOKL_TE
    RET=19
  ELSE
    nom_ser='Nomenklatûra'
    RET =1
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1

  BIND(NOL:RECORD)
  BIND('PAV:U_NR',PAV:U_NR)

  FilesOpened = True
  RecordsToProcess = RECORDS(NOLIK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Packing List'
  ?Progress:UserString{Prop:Text}=''
  SEND(NOLIK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(nol:RECORD)
      NOL:U_NR=PAV:U_NR
      SET(nol:NR_KEY,NOL:NR_KEY)
      Process:View{Prop:Filter} = 'NOL:U_NR=PAV:U_NR'
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
          VARDS=CLIP(INIGEN(PAV:NOKA,15,1))&' PL:'&CLIP(PAV:DOK_SENR)
          Report{Prop:Text} = CLIP(VARDS)&'XXXX'
      ELSE
          IF ~OPENANSI('PACKLIST1.TXT')
            POST(Event:CloseWindow)
            CYCLE
          .
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='PACKING LIST'
          ADD(OUTFILEANSI)
          OUTA:LINE=VIRSRAKSTS
          ADD(OUTFILEANSI)
          OUTA:LINE=PAR:NOS_P
          ADD(OUTFILEANSI)
          OUTA:LINE=PAR_IZ_V
          ADD(OUTFILEANSI)
          OUTA:LINE=''
          ADD(OUTFILEANSI)
          OUTA:LINE='Nr'&CHR(9)&'Nosaukums'&CHR(9)&NOM_SER&CHR(9)&'EAN-code'&CHR(9)&'Daudzums'&CHR(9)&'Plaukts'
          ADD(OUTFILEANSI)
!          OUTA:LINE=''
!          ADD(OUTFILEANSI)
      END
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        npk#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY(?Progress:UserString)
        P:NOMENKLAT=NOL:NOMENKLAT
        P:NOM_SER  =GETNOM_K(NOL:NOMENKLAT,0,RET)
        P:NOSAUK   =INIGEN(NOM:NOS_P,10,1)
        P:NOSAUKUMS=NOM:NOS_P
        P:PLAUKTS  =GETNOM_ADRESE(NOL:NOMENKLAT,1)
        P:DAUDZUMS =NOL:DAUDZUMS
        P:EANCODE  =GETNOM_K(NOL:NOMENKLAT,0,4)   ! OR 8?
        ADD(P_TABLE)
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
        POST(Event:CloseWindow)
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
  IF SEND(NOLIK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:SECIBA='N'
       SORT(P_TABLE,P:NOMENKLAT)
    ELSE
       SORT(P_TABLE,P:NOSAUK)
    .
    loop i# = 1 to records(p_table)
       get(p_table,i#)
       NR+=1
       P:DAUDZUMS = ROUND(P:DAUDZUMS,.001)
       DAUDZUMS_S=CUT0(P:DAUDZUMS,3,0)
       IF F:DBF='W'
            PRINT(RPT:Detail)
       ELSE
            OUTA:LINE=FORMAT(NR,@N3)&CHR(9)&P:Nosaukums&CHR(9)&P:NOMENKLAT&CHR(9)&P:EANcode&CHR(9)&|
            LEFT(FORMAT(P:Daudzums,@N-_10.2))&CHR(9)&P:Plaukts&CHR(9)&P:NOM_SER
            ADD(OUTFILEANSI)
       END
    .
    IF F:DBF='W'
        PRINT(RPT:page_foot)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
    END
    ENDPAGE(report)
    CLOSE(ProgressWindow)
    IF F:DBF='W'   !WMF
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
      .
    ELSE
        ANSIJOB
    .
  .
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE           !WORD,EXCEL
     CLOSE(OUTFILEANSI)
     ANSIFILENAME=''
  .
  DO ProcedureReturn

!-----------------------------------------------------------------------------
ProcedureReturn ROUTINE
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
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  if f:dbf<>'w' then f:dbf='w'.
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

!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE()
    IF ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'NOLIK')
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
      DISPLAY()
    END
  END
ConvertDBF           PROCEDURE (namedbf)          ! Declare Procedure
namefile         string(60),static
KAFILE           FILE,DRIVER('DOS'),NAME(NameFILE),PRE(KA)
RECORD              RECORD
G                     BYTE
                 . .
  CODE                                            ! Begin processed code
  namefile=namedbf
  OPEN(KAFILE)
  SET(KAFILE)
  if ~error()
     GET(KAFILE,2,1)
!        STOP(KA:G)
     IF INRANGE(KA:G,0,19)
        KA:G=YEAR(TODAY())-1900   !2009=6D=109
!        STOP(KA:G)
        PUT(KAFILE,2,1)
     .
     CLOSE(KAFILE)
  ELSE
!     STOP('CONVERTDBF:'&ERROR())
  .
