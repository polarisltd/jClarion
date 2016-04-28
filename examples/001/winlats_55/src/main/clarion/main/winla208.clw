                     MEMBER('winlats.clw')        ! This is a MEMBER module
A_PAZ_ALNOD          PROCEDURE                    ! Declare Procedure
!------------------------------------------------------------------------
RPT_GADS             DECIMAL(4)
RPT_MEN_NR           BYTE
VUT                  STRING(35)
GRAM_NR              STRING(12)
KART_NR              STRING(12)
S1                   DECIMAL(9,2)
S2                   DECIMAL(9,2)
S3                   DECIMAL(9,2)
S4                   DECIMAL(9,2)
S5                   DECIMAL(9,2)
S6                   DECIMAL(9,2)
S7                   DECIMAL(9,2)
S8                   DECIMAL(9,2)
S9                   DECIMAL(10,2)
S10                  DECIMAL(9,2)
S11                  DECIMAL(9,2)
S12                  DECIMAL(9,2)
S12P                 DECIMAL(9,2)
RINDA                STRING(40)
A_NM                 DECIMAL(10,2)
APLIEN               DECIMAL(10,2)
RPT_S_DAT            LONG
RPT_B_DAT            LONG
E_DAT                LONG
PAR_NOS_P            LIKE(PAR:NOS_P)

!------------------------------------------------------------------------
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
!-----------------------------------------------------------------------------
Process:View         VIEW(KADRI)
                       PROJECT(KAD:AMATS)
                       PROJECT(KAD:APGAD_SK)
                       PROJECT(KAD:AVANSS)
                       PROJECT(KAD:DARBA_GR)
                       PROJECT(KAD:DZIM)
                       PROJECT(KAD:D_GR_END)
                       PROJECT(KAD:ID)
                       PROJECT(KAD:INI)
                       PROJECT(KAD:INV_P)
                       PROJECT(KAD:IZGLITIBA)
                       PROJECT(KAD:KARTNR)
                       PROJECT(KAD:VID_U_NR)
                       PROJECT(KAD:DAR_LIG)
                       PROJECT(KAD:DAR_DAT)
                       PROJECT(KAD:NEDAR_LIG)
                       PROJECT(KAD:NEDAR_DAT)
                       PROJECT(KAD:PASE)
                       PROJECT(KAD:PERSKOD)
                       PROJECT(KAD:PIERADR)
                       PROJECT(KAD:PR1)
                       PROJECT(KAD:PR37)
                       PROJECT(KAD:REGNR)
                       PROJECT(KAD:REK_NR1)
                       PROJECT(KAD:NODALA)
                       PROJECT(KAD:STATUSS)
                       PROJECT(KAD:TERKOD)
                       PROJECT(KAD:TEV)
                       PROJECT(KAD:UZV)
                       PROJECT(KAD:VAR)
                     END
!------------------------------------------------------------------------
report REPORT,AT(104,198,8000,11000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(100,100,8000,104)
       END
detail DETAIL,AT(,,,10896),USE(?unnamed)
         STRING('Ministru Kabineta'),AT(6979,208),USE(?String65:2),TRN
         LINE,AT(104,104,0,313),USE(?Line2:9),COLOR(COLOR:Black)
         LINE,AT(104,104,1719,0),USE(?Line8:3),COLOR(COLOR:Black)
         LINE,AT(1823,104,0,313),USE(?Line2:10),COLOR(COLOR:Black)
         STRING('Izsniedz ien�kuma sa��m�jam un '),AT(156,104),USE(?String65:3),TRN
         STRING('1. pielikums'),AT(7240,104),USE(?String65:5),TRN
         STRING('Ien�kuma izmaksas datums'),AT(156,4323,1823,208),USE(?String13:5)
         STRING(@N2),AT(2240,4323),USE(SYS:NOKL_DC),RIGHT
         LINE,AT(104,4583,7813,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING('Bruto ie��mumi'),AT(156,4635,3542,208),USE(?String13:6),LEFT
         LINE,AT(6875,7604,0,260),USE(?Line33),COLOR(COLOR:Black)
         STRING('Neapliekamie ien�kumi'),AT(156,4844,3542,208),USE(?String13:7),LEFT
         STRING(@N_10.2),AT(7031,4635),USE(S1)
         LINE,AT(104,7240,7813,0),USE(?Line1:16),COLOR(COLOR:Black)
         STRING('Ietur�ts nodoklis'),AT(156,7031,1302,208),USE(?String71)
         STRING('12'),AT(6615,7031,260,208),USE(?String50:12),CENTER
         LINE,AT(104,7604,0,260),USE(?Line30),COLOR(COLOR:Black)
         STRING('Attaisnotie izdevumi'),AT(156,6198,1302,208),USE(?String13:8),LEFT
         STRING('valsts soci�l�s apdro�in��anas iemaksas'),AT(1510,6198,2760,208),USE(?String13:9),LEFT
         LINE,AT(104,7865,7813,0),USE(?Line1:15),COLOR(COLOR:Black)
         STRING('_____gada "____"_{20}'),AT(365,8177),USE(?String60)
         STRING(@s25),AT(5156,8385),USE(sys:paraksts1),CENTER
         STRING('_{20}'),AT(5469,8177),USE(?String62)
         STRING(@s25),AT(3490,8177),USE(sys:amats1,,?sys:amats1:2),RIGHT
         STRING('Z. V.'),AT(365,8594),USE(?String61)
         STRING('_{20}'),AT(5469,8698),USE(?String63)
         STRING(@s25),AT(3490,8698),USE(sys:amats2),RIGHT
         STRING(@s25),AT(5156,8906),USE(sys:paraksts2),CENTER
         STRING('T�lr. '),AT(4531,9271),USE(?String64)
         STRING(@s12),AT(4844,9271),USE(Sys:tel),LEFT
         STRING('(C) Assako'),AT(7469,10760,500,104),USE(?StringASSAKO),TRN,FONT(,6,,FONT:regular+FONT:italic,CHARSET:ANSI)
         STRING('09'),AT(6615,6406,260,208),USE(?String50:9),CENTER
         STRING(@N_10.2),AT(7031,6406,740,208),USE(S9,,?S9:2)
         STRING(@N_10.2),AT(7031,7031,740,208),USE(S12)
         STRING('06'),AT(6615,5729,260,208),USE(?String50:6),CENTER
         STRING(@N_10.2),AT(7031,6823,740,208),USE(S11)
         STRING('05'),AT(6615,5521,260,208),USE(?String50:5),CENTER
         STRING('Nodok�a summa, kas likum� noteiktaj� termi�� ir p�rskait�ta bud�et�'),AT(156,7656,4583,208), |
             USE(?String13:18)
         STRING(@N_10.2),AT(7031,7656),USE(S12p)
         LINE,AT(7917,7604,0,260),USE(?Line33:2),COLOR(COLOR:Black)
         STRING('08'),AT(6615,6198,260,208),USE(?String50:8),CENTER
         STRING(@N_10.2),AT(7031,5729,646,177),USE(S6)
         STRING('04'),AT(6615,5260,260,208),USE(?String50:4),CENTER
         STRING('nacion�l�s preto�an�s kust�bas dal�bniekiem'),AT(1510,5938,2969,208),USE(?String13:10), |
             LEFT
         STRING('Neapliekamais minimums'),AT(156,5052,3542,208),USE(?String13:11),LEFT
         LINE,AT(104,7604,7813,0),USE(?Line1:14),COLOR(COLOR:Black)
         LINE,AT(104,6146,7813,0),USE(?Line1:13),COLOR(COLOR:Black)
         STRING(@s40),AT(156,7344,2969,208),USE(rinda),LEFT
         STRING('07'),AT(6615,5938,260,208),USE(?String50:7),CENTER
         STRING(@N_10.2),AT(7031,5521,646,177),USE(S5)
         STRING('03'),AT(6615,5052,260,208),USE(?String50:3),CENTER
         LINE,AT(104,4583,0,2656),USE(?Line2:8),COLOR(COLOR:Black)
         STRING(@d06.),AT(3021,4063),USE(RPT_b_dat),RIGHT
         LINE,AT(1979,4010,0,521),USE(?Line2:7),COLOR(COLOR:Black)
         STRING('Ien�kuma g��anas periods'),AT(156,4063,1667,208),USE(?String13:4)
         STRING(@d06.),AT(2240,4063),USE(RPT_S_dat),LEFT
         STRING('-'),AT(2917,4063,104,208),USE(?String24),CENTER
         STRING('PAZI�OJUMS'),AT(3229,104,1406,260),USE(?String1),TRN,CENTER,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,417,1719,0),USE(?Line8:2),COLOR(COLOR:Black)
         STRING('noteikumiem Nr.166'),AT(6875,417),USE(?String65:6),TRN
         STRING('par algas nodokli'),AT(3250,313),USE(?String1:2),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('2000.gada 2.maija'),AT(6927,313),USE(?String65),TRN
         STRING('Valsts ie��mumu dienestam'),AT(156,260),USE(?String65:4),TRN
         STRING(''),AT(1094,313),USE(?String2),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,625,7813,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Valsts ie��mumu dienesta'),AT(208,677,1667,208),USE(?String4)
         STRING(@s25),AT(2083,677),USE(gl:vid_nos),LEFT
         STRING('teritori�l� iest�de'),AT(6823,677,990,208),USE(?String4:3),TRN
         LINE,AT(6719,625,0,260),USE(?Line2:11),COLOR(COLOR:Black)
         LINE,AT(104,885,7813,0),USE(?Line1:2),COLOR(COLOR:Black)
         LINE,AT(5365,885,0,260),USE(?Line2:4),COLOR(COLOR:Black)
         STRING('Taks�cijas gads'),AT(5417,938,1510,208),USE(?String4:2),CENTER
         STRING(@n04),AT(7240,938),USE(RPT_gads),FONT(,10,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5365,1146,2552,0),USE(?Line8),COLOR(COLOR:Black)
         STRING('IEN�KUMA SA��M�JS'),AT(2833,1250,2188,260),USE(?String1:3),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1510,7813,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING(@s35),AT(938,1563),USE(VUT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@p######-#####p),AT(6563,1563),USE(KAD:PERSKOD),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,1823,7813,0),USE(?Line1:4),COLOR(COLOR:Black)
         STRING(@s35),AT(938,1875,2708,208),USE(kad:pieradr),LEFT
         STRING(@n06),AT(6771,1875,521,208),USE(kad:terkod),CENTER
         LINE,AT(104,2083,7813,0),USE(?Line1:5),COLOR(COLOR:Black)
         STRING('Gr�mati�as s�rija, Nr'),AT(208,2135),USE(?String13)
         STRING(@s12),AT(1563,2135),USE(gram_nr),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Kartes s�rija, Nr'),AT(2708,2135),USE(?String13:2)
         STRING(@s12),AT(3750,2135),USE(kart_nr),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('Izsniedz�js:'),AT(260,2344,729,208),USE(?String13:20)
         STRING(@s45),AT(1563,2344,3406,208),USE(par_nos_p),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1146,3750,0,260),USE(?Line2:6),COLOR(COLOR:Black)
         LINE,AT(104,2552,7813,0),USE(?Line1:6),COLOR(COLOR:Black)
         STRING(@s45),AT(938,3021,3792,208),USE(client),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,4531,7813,0),USE(?Line1:10),COLOR(COLOR:Black)
         LINE,AT(104,4271,7813,0),USE(?Line1:9),COLOR(COLOR:Black)
         LINE,AT(104,4010,7813,0),USE(?Line1:8),COLOR(COLOR:Black)
         LINE,AT(6250,2917,0,573),USE(?Line18),COLOR(COLOR:Black)
         LINE,AT(7917,4583,0,2656),USE(?Line10:5),COLOR(COLOR:Black)
         STRING(@s13),AT(6302,3073,1615,208),USE(GL:REG_NR),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(938,3229,3802,208),USE(GL:adrese),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,2917,7813,0),USE(?Line10:4),COLOR(COLOR:Black)
         STRING('DARBA DEV�JS (IEN�KUMA IZMAKS�T�JS)'),AT(2083,2656,3750,260),USE(?String1:4),TRN,CENTER, |
             FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(104,3490,7813,0),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(104,3750,7813,0),USE(?Line1:17),COLOR(COLOR:Black)
         STRING('Ien�kuma veids'),AT(156,3802,990,208),USE(?String13:3)
         STRING('Darba alga'),AT(1615,3802),USE(?String73)
         LINE,AT(104,5469,7813,0),USE(?Line1:12),COLOR(COLOR:Black)
         STRING('Atvieglojumi par apg�d�jamiem'),AT(156,5260,3542,208),USE(?String13:12),LEFT
         STRING(@N_10.2),AT(7031,4844),USE(S2)
         STRING('01'),AT(6615,4635,260,208),USE(?String50),CENTER
         STRING('Ien�kums, no kura apr��in�ts nodoklis (1-2-3-4-(5v6v7v)-8-9-10)'),AT(156,6823,3958,208), |
             USE(?String13:16),LEFT
         STRING('11'),AT(6615,6823,260,208),USE(?String50:11),CENTER
         STRING('iemaksas priv�tajos pensiju fondos'),AT(1510,6406,2760,208),USE(?String13:17),LEFT
         STRING(@N_10.2),AT(7031,5260),USE(S4)
         STRING('10'),AT(6615,6615,260,208),USE(?String50:10),CENTER
         STRING(@N_10.2),AT(7031,6615,740,208),USE(S10,,?S10:2)
         STRING('izdevumi'),AT(1510,6615,2760,208),USE(?String13:19),LEFT
         STRING('02'),AT(6615,4844,260,208),USE(?String50:2),CENTER
         STRING('Papildu atvieglojumi'),AT(156,5521,1302,208),USE(?String13:13),LEFT
         STRING('par invalidit�ti'),AT(1510,5521,1302,208),USE(?String13:14),LEFT
         LINE,AT(6563,4583,0,2656),USE(?Line10:7),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(7031,6198,740,208),USE(S8)
         STRING('politiski repres�tai personai'),AT(1510,5729,1979,208),USE(?String13:15),LEFT
         LINE,AT(6875,4583,0,2656),USE(?Line10:6),COLOR(COLOR:Black)
         STRING(@N_10.2),AT(7031,5052),USE(S3,,?S3:2)
         LINE,AT(6250,1510,0,573),USE(?Line10:3),COLOR(COLOR:Black)
         LINE,AT(7917,1510,0,3021),USE(?Line10:2),COLOR(COLOR:Black)
         LINE,AT(104,1510,0,3021),USE(?Line10),COLOR(COLOR:Black)
         LINE,AT(6927,885,0,260),USE(?Line2:5),COLOR(COLOR:Black)
         LINE,AT(7917,625,0,521),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(1979,625,0,260),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(104,625,0,260),USE(?Line2),COLOR(COLOR:Black)
       END
     END

Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Atlikt'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO
  CODE                                            ! Begin processed code
  PUSHBIND

  RPT_GADS=YEAR(ALP:YYYYMM)
  RPT_MEN_NR=MONTH(ALP:YYYYMM)
  S_DAT=DATE(1,1,YEAR(ALP:YYYYMM))
  B_DAT=DATE(12,31,YEAR(ALP:YYYYMM))

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  IF ALGPA::USED=0
     CHECKOPEN(ALGPA,1)
  .
  ALGPA::USED+=1
  CHECKOPEN(ALGAS,1)
  CHECKOPEN(PAR_K,1)
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)

  BIND('F:NODALA',F:NODALA)
  BIND('ID',ID)
  BIND('F:IDP',F:IDP)
  BIND(KAD:RECORD)

  FilesOpened = True
  RecordsToProcess = RECORDS(KADRI)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Pazi�ojums par Algas nodokli'
  ?Progress:UserString{Prop:Text}=''
  SEND(KADRI,'QUICKSCAN=on')
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(KAD:RECORD)
      SET(KAD:INI_KEY,KAD:INI_KEY)
      Process:View{Prop:Filter} = '~(F:NODALA and ~(KAD:NODALA=F:NODALA)) AND ~(ID and ~(KAD:ID=ID))'
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
      OPEN(report)
      report{Prop:Preview} = PrintPreviewImage
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF ~F:IDP OR|                                                   !VISI
           (F:IDP='1' AND YEAR(KAD:D_GR_END)=RPT_GADS) OR|              !TIKAI ATLAISTIE �.G.
           (F:IDP='2' AND ~INRANGE(YEAR(KAD:D_GR_END),1,RPT_GADS)) OR|  !TIKAI NEATLAISTIE
           (F:IDP='3' AND YEAR(KAD:D_GR_END)=RPT_GADS AND MONTH(KAD:D_GR_END)=RPT_MEN_NR) !TIKAI ATLAISTIE �.M.
           VUT=clip(kad:var)&' '&clip(kad:uzv)
           PAR_NOS_P=getpar_k(KAD:VID_U_NR,0,2)
           IF INRANGE(KAD:DARBA_GR,S_DAT,B_DAT)
             RPT_S_DAT=KAD:DARBA_GR
           ELSE
             RPT_S_DAT=S_DAT
           .
           IF INRANGE(KAD:D_GR_END,S_DAT,B_DAT)
             RPT_B_DAT=KAD:D_GR_END
           ELSE
             RPT_B_DAT=B_DAT
           .
           S1=0
           S2=0
           S3=0
           S4=0
           S5=0
           S6=0
           S7=0
           S8=0
           S9=0
           S10=0
           S11=0
           S12=0
           S12P=0
           aplien=0
           A_NM  =0
           K#=0

           CLEAR(ALG:RECORD)
           ALG:ID=KAD:ID
           ALG:YYYYMM=DATE(MONTH(RPT_S_DAT),1,YEAR(RPT_S_DAT))
           SET(ALG:ID_DAT,ALG:ID_DAT)
           LOOP
             NEXT(ALGAS)
             IF ERROR() OR ~(ALG:ID=KAD:ID) OR ~(YEAR(ALG:YYYYMM)=RPT_GADS) THEN BREAK.
             K#+=1
             ?Progress:UserString{PROP:TEXT}=CLIP(K#)&' '&VUT
             DISPLAY(?Progress:UserString)
             S1+=ROUND(SUM(33),.01)
             S2+=ROUND(SUM(2),.01)+ROUND(SUM(53),.01)
!             S3+=ROUND(SUM(37),.01)   !IZR��IN�TS NEAPLIEKAMAIS MINIMUMS F(CAL,KADRIEM,B_LAPAS,APR ALGAS)
             S3+=CALCNEA(1,0,0)       !F(CAL,KADRIEM,B_LAPAS)
!             S4+=ROUND(SUM(38),.01)   !IZR��IN�TS ATV.PAR B�RNIEM F(CAL,KADRIEM,B_LAPAS,APR ALGAS)
             S4+=CALCNEA(2,0,0)       !F(CAL,KADRIEM,B_LAPAS)
             IF INRANGE(ALG:INV_P,1,3)
                S5+=CALCNEA(3,0,0)       !F(CAL,KADRIEM,B_LAPAS)
             ELSIF INRANGE(ALG:INV_P,4,5)
                S6+=CALCNEA(3,0,0)       !F(CAL,KADRIEM,B_LAPAS)
             .
             S7 =0   !NAC.PRET.DAL.
             S8+=ROUND(SUM(6),.01)
             S9+=ALG:PPF
             S10+=ALG:DZIVAP+ALG:IZDEV
             S12+=ROUND(SUM(22)+SUM(23)+SUM(26)+SUM(27)+SUM(42),.01) !APR��IN�TAIS NODOKLIS
!             S12+=ALG:IIN                                             !IETUR�TAIS NODOKLIS
             S12P+=ALG:IIN                                            !P�RSKAIT�TAIS NODOKLIS
             IF MONTH(ALG:YYYYMM)=12
               A_NM+=SUM(21)                !ATVA�IN�JUMI N�KAMAJOS M�NE�OS
             .
             E_DAT=DATE(MONTH(ALG:YYYYMM)+1,1,RPT_GADS)-1
           .
           IF E_DAT < RPT_B_DAT                  
              RPT_B_DAT=E_DAT
           .
           S11=S1-S2-S3-S4-S5-S6-S7-S8-S9-S10
           IF S11<0 THEN S11=0.
           CASE KAD:STATUSS
           OF '1'
           OROF '3'
             GRAM_NR=KAD:KARTNR
             KART_NR=''
           ELSE
             GRAM_NR=''
             KART_NR=KAD:KARTNR
           .
           IF A_NM
             RINDA='Atva�in�jumi n�kamaj� gad� : '&a_nm
           ELSE
             RINDA=''
           .
           a_nm=0
           IF S1
             PRINT(RPT:DETAIL)
           .
        .
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
  IF SEND(KADRI,'QUICKSCAN=off').
  IF SEND(ALGAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
     CLOSE(ProgressWindow)
     F:DBF='W'   ! .................... PAGAID�M TIKAI WMF
     IF F:DBF='W'   !WMF
        ENDPAGE(report)
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
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
    ALGPA::USED -= 1
    IF ALGPA::USED = 0 THEN CLOSE(ALGPA).
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
      StandardWarning(Warn:RecordFetchError,'KADRI')
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END

A_DNKUS              PROCEDURE                    ! Declare Procedure
NPK             LONG
DATUMS          LONG
PERSKODS        STRING(12)
VUT             STRING(22)
ZDAT            LONG
ZK              STRING(2)
E               STRING(1)

TEX:DUF         STRING(100)
XMLFILENAME     CSTRING(200),STATIC

OUTFILEXML      FILE,DRIVER('ASCII'),NAME(XMLFILENAME),PRE(XML),CREATE,BINDABLE,THREAD
Record             RECORD,PRE()
LINE                  STRING(256)
                   END
                END

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

!-----------------------------------------------------------------------------
Process:View         VIEW(KADRI)
                       PROJECT(KAD:AMATS)
                       PROJECT(KAD:APGAD_SK)
                       PROJECT(KAD:AVANSS)
                       PROJECT(KAD:DARBA_GR)
                       PROJECT(KAD:DZIM)
                       PROJECT(KAD:D_GR_END)
                       PROJECT(KAD:ID)
                       PROJECT(KAD:INI)
                       PROJECT(KAD:INV_P)
                       PROJECT(KAD:IZGLITIBA)
                       PROJECT(KAD:KARTNR)
                       PROJECT(KAD:VID_U_NR)
                       PROJECT(KAD:DAR_LIG)
                       PROJECT(KAD:DAR_DAT)
                       PROJECT(KAD:NEDAR_LIG)
                       PROJECT(KAD:NEDAR_DAT)
                       PROJECT(KAD:PASE)
                       PROJECT(KAD:PERSKOD)
                       PROJECT(KAD:PIERADR)
                       PROJECT(KAD:PR1)
                       PROJECT(KAD:PR37)
                       PROJECT(KAD:REGNR)
                       PROJECT(KAD:REK_NR1)
                       PROJECT(KAD:NODALA)
                       PROJECT(KAD:STATUSS)
                       PROJECT(KAD:TERKOD)
                       PROJECT(KAD:TEV)
                       PROJECT(KAD:UZV)
                       PROJECT(KAD:VAR)
                     END

!-----------------------------------------------------------------------------
report REPORT,AT(198,2136,8000,9000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,198,8000,1938),USE(?unnamed:3)
         STRING('1. pielikums'),AT(6458,52,,156),USE(?String1),LEFT
         STRING('Ministru kabineta'),AT(6458,208,,156),USE(?String1:2),LEFT
         LINE,AT(781,1927,6510,0),USE(?Line3:17),COLOR(COLOR:Black)
         STRING('2000. gada 14. novembra'),AT(6458,365,,156),USE(?String1:3),LEFT
         STRING('noteikumiem Nr. 397'),AT(6458,521,,156),USE(?String1:4),LEFT
         STRING('Valsts ie��mumu dienesta'),AT(781,625,1979,208),USE(?String5),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s25),AT(2813,625),USE(gl:VID_NOS),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('teritori�lajai iest�dei'),AT(4479,625,1250,208),USE(?String5:2),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(groz�jumi Nr.790 un Nr.969)'),AT(6344,677,,156),USE(?String1:6),TRN,LEFT
         STRING('Nodok�u maks�t�ja kods'),AT(781,833,1979,208),USE(?String5:3),FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(2813,833),USE(GL:REG_NR),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(2240,1042,3906,260),USE(CLIENT),CENTER,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,1302,6510,0),USE(?Line2),COLOR(COLOR:Black)
         STRING('(darba dev�ja nosaukums vai v�rds un uzv�rds)'),AT(1146,1354,5521,208),USE(?String1:5), |
             CENTER
         STRING('ZI�AS PAR DARBA ��M�JIEM'),AT(2656,1615,2656,260),USE(?String9),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('(ZDN.DUF)'),AT(5260,1625,698,208),USE(?String1:7),TRN,CENTER
       END
PAGE_HEAD DETAIL,AT(,,,396)
         LINE,AT(781,0,6510,0),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(1198,0,0,417),USE(?Line4:2),COLOR(COLOR:Black)
         LINE,AT(2552,0,0,417),USE(?Line4:3),COLOR(COLOR:Black)
         LINE,AT(4115,0,0,417),USE(?Line4:4),COLOR(COLOR:Black)
         LINE,AT(5833,0,0,417),USE(?Line4:5),COLOR(COLOR:Black)
         LINE,AT(6771,0,0,417),USE(?Line4:6),COLOR(COLOR:Black)
         LINE,AT(7292,0,0,417),USE(?Line4:7),COLOR(COLOR:Black)
         STRING('Npk'),AT(813,52,365,156),USE(?String11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Personas kods vai'),AT(1229,52,1302,156),USE(?String11:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Personas dzim�anas dati'),AT(2583,52,1510,156),USE(?String11:4),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('V�rds, uzv�rds'),AT(4146,52,1667,156),USE(?String11:6),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Datums,'),AT(5865,52,885,156),USE(?String11:7),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Zi�u'),AT(6802,52,469,156),USE(?String11:9),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('re�istr�cijas numurs'),AT(1229,208,1302,156),USE(?String11:3),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('(ja nav personas koda)'),AT(2583,208,1510,156),USE(?String11:5),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('m�nesis, gads'),AT(5865,208,885,156),USE(?String11:8),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('kods'),AT(6802,208,469,156),USE(?String11:10),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,0,0,417),USE(?Line4),COLOR(COLOR:Black)
         LINE,AT(781,365,6510,0),USE(?Line3:2),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,167)
         LINE,AT(781,-10,0,188),USE(?Line4:8),COLOR(COLOR:Black)
         STRING(@N_3),AT(885,10,,156),USE(NPK),RIGHT
         LINE,AT(1198,-10,0,188),USE(?Line4:9),COLOR(COLOR:Black)
         LINE,AT(2552,-10,0,188),USE(?Line4:10),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,188),USE(?Line4:11),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,188),USE(?Line4:12),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,188),USE(?Line4:13),COLOR(COLOR:Black)
         LINE,AT(7292,-10,0,188),USE(?Line4:14),COLOR(COLOR:Black)
         STRING(@S2),AT(6979,10,,156),USE(ZK),LEFT
         STRING(@s22),AT(4167,10,,156),USE(VUT)
         STRING(@D06.),AT(5990,10,,156),USE(ZDAT)
         STRING(@S12),AT(1396,10,,156),USE(PERSKODS)
       END
detail2 DETAIL,AT(,,,177)
         LINE,AT(781,-10,0,63),USE(?Line19:3),COLOR(COLOR:Black)
         LINE,AT(1198,-10,0,63),USE(?Line19:4),COLOR(COLOR:Black)
         LINE,AT(2552,-10,0,63),USE(?Line19:5),COLOR(COLOR:Black)
         LINE,AT(4115,-10,0,63),USE(?Line19:6),COLOR(COLOR:Black)
         LINE,AT(5833,-10,0,63),USE(?Line19:7),COLOR(COLOR:Black)
         LINE,AT(6771,-10,0,63),USE(?Line19),COLOR(COLOR:Black)
         LINE,AT(7292,-10,0,63),USE(?Line19:2),COLOR(COLOR:Black)
         LINE,AT(781,52,6510,0),USE(?Line3:3),COLOR(COLOR:Black)
       END
Zinu_kodi DETAIL,AT(,,,4448),USE(?unnamed:4)
         LINE,AT(781,52,6510,0),USE(?Line3:5),COLOR(COLOR:Black)
         STRING('Npk'),AT(833,146,365,208),USE(?String11:11),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Zi�u'),AT(1250,146,469,208),USE(?String11:12),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('At�ifr�jums'),AT(1771,146,5521,208),USE(?String11:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7292,63,0,4271),USE(?Line4:15),COLOR(COLOR:Black)
         STRING('nelaimes gad�jumiem darb� un arodslim�b�m (darba ��m�jam, kur� ir sasniedz vecum' &|
             'u, kas dod ties�bas '),AT(1771,2375,5510,156),USE(?String11:35),LEFT
         STRING('sa�emt valsts vecuma pensiju; darba ��m�jam, kuram ir pie��irta vecuma pensija a' &|
             'r atvieglotiem noteikumiem;'),AT(1771,2531,5510,156),USE(?String11:36),LEFT
         STRING(' I un II grupas inval�dam)'),AT(1771,2688,5510,156),USE(?String11:37),LEFT
         LINE,AT(781,2865,6510,0),USE(?Line3:12),COLOR(COLOR:Black)
         STRING('6.'),AT(833,2917,260,156),USE(?String11:39),RIGHT
         STRING('40'),AT(1250,2917,469,156),USE(?String11:40),CENTER
         STRING('Darba ��m�jam ir pie��irts b�rna kop�anas atva�in�jums l�dz b�rna tr�s gadu vecu' &|
             'ma sasnieg�anai'),AT(1771,2917,5510,156),USE(?String11:46),LEFT
         STRING('Darba ��m�js, kuram ir b�rns vecum� l�dz trim gadiem, nodarbin�ts nepilnu darba ' &|
             'ned��u (l�dz 20 stund�m'),AT(1771,3125,5510,156),USE(?String11:45),LEFT
         STRING('ned���, ja b�rns ir vecum� l�dz pusotram gadam, un l�dz 34 stund�m ned���, ja b�' &|
             'rns ir vecum� no pusotra '),AT(1771,3281,5510,156),USE(?String11:41),LEFT
         STRING('l�dz trim gadiem)'),AT(1771,3438,5510,156),USE(?String11:42),LEFT
         LINE,AT(781,3594,6510,0),USE(?Line3:14),COLOR(COLOR:Black)
         STRING('8.'),AT(833,3615,260,156),USE(?String11:47),RIGHT
         STRING('52'),AT(1250,3615,469,156),USE(?String11:48),CENTER
         STRING('Darba ��m�js, kuram ir b�rns vecum� l�dz trim gadiem, nodarbin�ts pilnu darba ne' &|
             'd��u (vair�k par 20 stund�m '),AT(1771,3615,5510,156),USE(?String11:49),LEFT
         STRING('ned���, ja b�rns ir vecum� l�dz pusotram gadam, un vair�k par 34 stund�m ned���,' &|
             ' ja b�rns ir vecum� no '),AT(1771,3771,5510,156),USE(?String11:50),LEFT
         STRING('pusotra l�dz trim gadiem)'),AT(1771,3927,5510,156),USE(?String11:51),LEFT
         LINE,AT(781,4115,6510,0),USE(?Line3:15),COLOR(COLOR:Black)
         STRING('9.'),AT(833,4167,260,156),USE(?String11:52),RIGHT
         STRING('60'),AT(1250,4167,469,156),USE(?String11:53),CENTER
         STRING('Darba ��m�ja v�rda, uzv�rda mai�a'),AT(1771,4167,5510,156),USE(?String11:54),LEFT
         LINE,AT(781,4323,6510,0),USE(?Line3:16),COLOR(COLOR:Black)
         LINE,AT(781,3073,6510,0),USE(?Line3:13),COLOR(COLOR:Black)
         STRING('7.'),AT(833,3125,260,156),USE(?String11:43),RIGHT
         STRING('51'),AT(1250,3125,469,156),USE(?String11:44),CENTER
         STRING('kods'),AT(1250,344,469,156),USE(?String11:13),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,521,6510,0),USE(?Line3:6),COLOR(COLOR:Black)
         STRING('1'),AT(833,563,365,156),USE(?String11:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(1250,563,469,156),USE(?String11:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(1771,563,5521,156),USE(?String11:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,729,6510,0),USE(?Line3:7),COLOR(COLOR:Black)
         STRING('1.'),AT(833,781,260,156),USE(?String11:18),RIGHT
         STRING('11'),AT(1250,781,469,156),USE(?String11:19),CENTER
         STRING('T�da darba ��m�ja statusa ieg��ana, kur� ir apdro�in�ms atbilsto�i visiem valsts' &|
             ' soci�l�s apdro�in��anas'),AT(1771,781,5417,156),USE(?String11:20),LEFT
         STRING('veidiem'),AT(1771,938,5417,156),USE(?String11:21),LEFT
         LINE,AT(781,1094,6510,0),USE(?Line3:8),COLOR(COLOR:Black)
         STRING('2.'),AT(833,1146,260,156),USE(?String11:22),RIGHT
         STRING('12'),AT(1250,1146,469,156),USE(?String11:23),CENTER
         STRING('T�da darba ��m�ja statusa ieg��ana, kur� ir pak�auts valsts pensiju apdro�in��an' &|
             'ai, maternit�tes un slim�bas'),AT(1771,1146,5469,156),USE(?String11:24),LEFT
         STRING('apdro�in��anai un soci�lajai apdro�in��anai pret nelaimes gad�jumiem darb� un ar' &|
             'odslim�b�m'),AT(1771,1302,5469,156),USE(?String11:25),LEFT
         LINE,AT(781,1458,6510,0),USE(?Line3:9),COLOR(COLOR:Black)
         STRING('3.'),AT(833,1510,260,156),USE(?String11:26),RIGHT
         STRING('20'),AT(1250,1510,469,156),USE(?String11:27),CENTER
         STRING('Darba ��m�ja statusa zaud��ana'),AT(1771,1510,5417,156),USE(?String11:28),LEFT
         LINE,AT(781,1667,6510,0),USE(?Line3:10),COLOR(COLOR:Black)
         STRING('4.'),AT(833,1698,260,156),USE(?String11:29),RIGHT
         STRING('31'),AT(1250,1698,469,156),USE(?String11:30),CENTER
         STRING('Darba ��m�ja apdro�in��anas statuss - darba ��m�js, kur� ir apdro�in�ms visiem v' &|
             'alsts soci�l�s'),AT(1771,1698,5427,156),USE(?String11:31),LEFT
         STRING('apdro�in��anas veidiem (darba ��m�jam, kur� ir zaud�jis I vai II grupas invalidi' &|
             't�ti)'),AT(1771,1854,4583,156),USE(?String11:32),LEFT
         LINE,AT(781,2031,6510,0),USE(?Line3:11),COLOR(COLOR:Black)
         STRING('5.'),AT(833,2063,260,156),USE(?String11:33),RIGHT
         STRING('32'),AT(1250,2063,469,156),USE(?String11:34),CENTER
         STRING('Darba ��m�ja apdro�in��anas statuss - darba ��m�js, kur� ir pak�auts valsts pens' &|
             'iju apdro�in��anai,'),AT(1771,2063,5510,156),USE(?String11:38),LEFT
         STRING('maternit�tes un slim�bas apdro�in��anai un soci�lajai apdro�in��anai un soci�laj' &|
             'ai apdro�in��anai pret'),AT(1771,2219,5510,156),USE(?String11:59),LEFT
         LINE,AT(1198,63,0,4271),USE(?Line4:17),COLOR(COLOR:Black)
         LINE,AT(781,52,0,4271),USE(?Line4:18),COLOR(COLOR:Black)
         LINE,AT(1719,52,0,4271),USE(?Line4:16),COLOR(COLOR:Black)
       END
Zinu_Kodi_New DETAIL,AT(,,,5490),USE(?unnamed)
         LINE,AT(781,52,6510,0),USE(?Line3:51),COLOR(COLOR:Black)
         STRING('Npk'),AT(833,104,365,156),USE(?String11:109),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Zi�u'),AT(1250,104,469,156),USE(?String11:108),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('At�ifr�jums'),AT(1771,104,5521,156),USE(?String11:55),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7292,63,0,5354),USE(?Line4:22),COLOR(COLOR:Black)
         STRING('nelaimes gad�jumiem darb� un arodslim�b�m (darba ��m�jam, kam ir pie��irta izdie' &|
             'nas pensija vai valsts'),AT(1771,3625,5510,156),USE(?String11:66),LEFT
         STRING('speci�l� pensija)'),AT(1771,3771,5510,156),USE(?String11:107),LEFT
         STRING('arodslim�b�m (darba ��m�jam, kur� ir sasniedzis vecumu, kas dod ties�bas sa�emt ' &|
             'valsts vecuma pensiju;'),AT(1771,4250,5510,156),USE(?String11:65),LEFT
         STRING('darba ��m�jam, kuram ir pie��irta vecuma pensija ar atvieglotiem noteikumiem)'),AT(1771,4396,5510,156), |
             USE(?String11:64),LEFT
         LINE,AT(781,4552,6510,0),USE(?Line3:30),COLOR(COLOR:Black)
         STRING('12.'),AT(833,4583,260,156),USE(?String11:102),RIGHT
         LINE,AT(781,3927,6510,0),USE(?Line3:21),COLOR(COLOR:Black)
         STRING('11.'),AT(833,3958,260,156),USE(?String11:98),RIGHT
         STRING('33'),AT(1250,3958,469,156),USE(?String11:99),CENTER
         STRING('Darba ��m�ja apdro�in��anas statusa mai�a - darba ��m�js, kur� ir pak�auts valst' &|
             's pensiju apdro�in��anai,'),AT(1771,3958,5510,156),USE(?String11:100),LEFT
         STRING('maternit�tes un slim�bas apdro�in��anai un soci�lajai apdro�in��anai pret nelaim' &|
             'es gad�jumiem darb� un'),AT(1771,4104,5510,156),USE(?String11:101),LEFT
         STRING('6.'),AT(833,2427,260,156),USE(?String11:87),RIGHT
         STRING('23'),AT(1250,2427,469,156),USE(?String11:88),CENTER
         STRING('Darba ��m�ja statusa zaud��ana sakar� ar darba dev�ja likvid�ciju'),AT(1771,2427,5510,156), |
             USE(?String11:89),LEFT
         LINE,AT(781,2583,6510,0),USE(?Line3:27),COLOR(COLOR:Black)
         STRING('40'),AT(1250,4583,469,156),USE(?String11:103),CENTER
         STRING('Darba ��m�jam ir pie��irts b�rna kop�anas atva�in�jums'),AT(1771,4583,5510,156),USE(?String11:63), |
             LEFT
         STRING('Darba ��m�js, kuram ir b�rns vecum� l�dz diviem gadiem, nodarbin�ts nepilnu darb' &|
             'a ned��u (l�dz 20 stund�m'),AT(1771,4771,5510,156),USE(?String11:62),LEFT
         STRING('ned���)'),AT(1771,4927,5510,156),USE(?String11:61),LEFT
         LINE,AT(781,5083,6510,0),USE(?Line3:19),COLOR(COLOR:Black)
         STRING('14.'),AT(833,5104,260,156),USE(?String11:106),RIGHT
         STRING('8.'),AT(833,2792,260,156),USE(?String11:93),RIGHT
         STRING('25'),AT(1250,2792,469,156),USE(?String11:94),CENTER
         STRING('Darba ��m�ja statusa zaud��ana citos gad�jumos'),AT(1771,2792,5510,156),USE(?String11:95), |
             LEFT
         LINE,AT(781,2969,6510,0),USE(?Line3:29),COLOR(COLOR:Black)
         STRING('52'),AT(1250,5104,469,156),USE(?String11:60),CENTER
         STRING('Darba ��m�js, kuram ir b�rns vecum� l�dz diviem gadiem, un kur� ir nodarbin�ts p' &|
             'ilnu darba ned��u (vair�k par'),AT(1771,5104,5510,156),USE(?String11:58),LEFT
         STRING('20 stund�m ned���)'),AT(1771,5250,5510,156),USE(?String11:57),LEFT
         LINE,AT(781,5417,6510,0),USE(?Line3:18),COLOR(COLOR:Black)
         STRING('9.'),AT(833,3000,260,156),USE(?String11:96),RIGHT
         LINE,AT(781,4740,6510,0),USE(?Line3:20),COLOR(COLOR:Black)
         STRING('13.'),AT(833,4771,260,156),USE(?String11:104),RIGHT
         STRING('7.'),AT(833,2604,260,156),USE(?String11:90),RIGHT
         STRING('24'),AT(1250,2604,469,156),USE(?String11:91),CENTER
         STRING('Darba ��m�ja statusa zaud��ana sakar� ar nesp�ju veikt nol�gto darbu vesel�bas s' &|
             't�vok�a d��'),AT(1771,2604,5510,156),USE(?String11:92),LEFT
         LINE,AT(781,2760,6510,0),USE(?Line3:28),COLOR(COLOR:Black)
         STRING('51'),AT(1250,4771,469,156),USE(?String11:105),CENTER
         STRING('kods'),AT(1250,260,469,156),USE(?String11:110),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,417,6510,0),USE(?Line3:31),COLOR(COLOR:Black)
         STRING('1'),AT(833,427,365,156),USE(?String11:111),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('2'),AT(1250,427,469,156),USE(?String11:816),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('3'),AT(1771,427,5521,156),USE(?String11:917),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(781,583,6510,0),USE(?Line3:32),COLOR(COLOR:Black)
         STRING('1.'),AT(833,594,260,156),USE(?String11:114),RIGHT
         STRING('11'),AT(1250,594,469,156),USE(?String11:113),CENTER
         STRING('T�da darba ��m�ja statusa ieg��ana, kur� ir apdro�in�ms atbilsto�i visiem VSA ve' &|
             'idiem'),AT(1771,594,5510,156),USE(?String11:112),LEFT
         LINE,AT(781,750,6510,0),USE(?Line783:8),COLOR(COLOR:Black)
         STRING('2.'),AT(833,760,260,156),USE(?String11:252),RIGHT
         STRING('12'),AT(1250,760,469,156),USE(?String11:283),CENTER
         STRING('T�da darba ��m�ja statusa ieg��ana, kur� ir pak�auts valsts pensiju apdro�in��an' &|
             'ai, invalidit�tes apdro�in�-'),AT(1771,760,5510,156),USE(?String11:73),LEFT
         STRING('�anai, maternit�tes un slim�bas apdro�in��anai un soci�lajai apdro�in��anai pret' &|
             ' nelaimes gad�jumiem darb�'),AT(1771,906,5510,156),USE(?String11:72),LEFT
         STRING('un arodslim�b�m (darba ��m�jam, kur� ir izdienas pensijas sa��m�js vai III grupa' &|
             's inval�ds - valsts speci�l�s'),AT(1771,1052,5510,156),USE(?String11:74),LEFT
         LINE,AT(781,1354,6510,0),USE(?Line3:24),COLOR(COLOR:Black)
         STRING('3.'),AT(833,1406,260,156),USE(?String11:75),RIGHT
         STRING('13'),AT(1250,1406,469,156),USE(?String11:76),CENTER
         STRING('T�da darba ��m�ja statusa ieg��ana, kur� ir pak�auts valsts pensiju apdro�in��an' &|
             'ai, maternit�tes un slim�bas'),AT(1771,1406,5510,156),USE(?String11:77),LEFT
         STRING('apdro�in��anai un soci�lajai apdro�in��anai pret nelaimes gad�jumiem darb� un ar' &|
             'odslim�b�m (darba ��m�jam,'),AT(1771,1563,5510,156),USE(?String11:78),LEFT
         STRING('kur� ir sasniedzis vecumu, kas dod ties�bas sa�emt valsts vecuma pensiju; darba ' &|
             '��m�jam, kuram ir pie��irta'),AT(1771,1719,5510,156),USE(?String131:78),LEFT
         STRING('vecuma pensija ar atvieglotiem noteikumiem)'),AT(1771,1875,5510,156),USE(?String11:79), |
             LEFT
         LINE,AT(781,2031,6510,0),USE(?Line3:25),COLOR(COLOR:Black)
         STRING('21'),AT(1250,2063,469,156),USE(?String11:81),CENTER
         STRING('Darba ��m�ja statusa zaud��ana, pamatojoties uz darba ��m�ja uzteikumu'),AT(1771,2063,5510,156), |
             USE(?String11:71),LEFT
         STRING('pensijas sa��m�js)'),AT(1771,1198,5510,156),USE(?String11:56),LEFT
         LINE,AT(781,2219,6510,0),USE(?Line3:23),COLOR(COLOR:Black)
         STRING('4.'),AT(833,2063,260,156),USE(?String11:80),RIGHT
         STRING('31'),AT(1250,3000,469,156),USE(?String11:84),CENTER
         STRING('Darba ��m�ja apdro�in��anas statusa mai�a - darba ��m�js, kur� ir apdro�in�ms vi' &|
             'siem valsts soci�l�s apdr-'),AT(1771,3000,5510,156),USE(?String11:70),LEFT
         STRING('o�in��anas veidiem (darba ��m�jam, kam ir p�rtraukt� izdienas pensija vai valsts' &|
             ' speci�l�s pensijas izmaksa)'),AT(1771,3156,5510,156),USE(?String11:69),LEFT
         LINE,AT(781,3313,6510,0),USE(?Line3:22),COLOR(COLOR:Black)
         STRING('10.'),AT(833,3333,260,156),USE(?String11:97),RIGHT
         STRING('5.'),AT(833,2240,260,156),USE(?String11:82),RIGHT
         STRING('22'),AT(1250,2240,469,156),USE(?String11:85),CENTER
         STRING('Darba ��m�ja statusa zaud��ana sakar� ar darba ��m�ja p�rk�pumu normat�vajos akt' &|
             'os noteiktajos gad�jumos'),AT(1771,2240,5510,156),USE(?String11:86),LEFT
         LINE,AT(781,2396,6510,0),USE(?Line3:26),COLOR(COLOR:Black)
         STRING('32'),AT(1250,3333,469,156),USE(?String11:83),CENTER
         STRING('Darba ��m�ja apdro�in��anas statusa mai�a - darba ��m�js, kur� ir pak�auts valst' &|
             's pensiju apdro�in��anai,'),AT(1771,3333,5510,156),USE(?String11:68),LEFT
         STRING('invalidit�tes apdro�in��anai, maternit�tes un slim�bas apdro�in��anai un soci�la' &|
             'jai apdro�in��anai pret'),AT(1771,3479,5510,156),USE(?String11:67),LEFT
         LINE,AT(1198,52,0,5365),USE(?Line4:20),COLOR(COLOR:Black)
         LINE,AT(781,52,0,5365),USE(?Line4:21),COLOR(COLOR:Black)
         LINE,AT(1719,52,0,5365),USE(?Line4:19),COLOR(COLOR:Black)
       END
paraksti DETAIL,AT(,,,1760),USE(?unnamed:2)
         STRING('Izpild�t�js'),AT(938,260,677,208),USE(?String23)
         STRING(@s25),AT(2271,500),USE(sys:paraksts2),LEFT
         LINE,AT(1615,469,3021,0),USE(?Line27),COLOR(COLOR:Black)
         STRING('T�lru�a numurs:'),AT(4719,260,1042,208),USE(?String23:2)
         STRING(@s8),AT(6073,260),USE(sys:tel),LEFT
         STRING(@s25),AT(2813,1094),USE(sys:paraksts1),LEFT
         STRING(@s25),AT(52,833,1875,208),USE(Sys:amats1),RIGHT
         LINE,AT(1958,1042,3021,0),USE(?Line27:2),COLOR(COLOR:Black)
         STRING(@d06.),AT(1698,1313),USE(DATUMS),LEFT
         STRING('Datums'),AT(938,1313,677,208),USE(?String23:4)
         STRING('Z.v.'),AT(938,1563,677,208),USE(?String23:5)
       END
       FOOTER,AT(198,11150,8000,52)
         LINE,AT(781,0,6510,0),USE(?Line3:4),COLOR(COLOR:Black)
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

DISKS                 CSTRING(60)
DISKETE               BYTE
MERKIS                STRING(1)
ToScreen WINDOW('XML faila sagatavo�ana'),AT(,,185,79),GRAY
       OPTION('Nor�diet, kur rakst�t'),AT(9,12,173,45),USE(merkis),BOXED
         RADIO('Priv�tais folderis'),AT(16,21),USE(?Merkis:Radio1),VALUE('1')
         RADIO('A:\'),AT(16,30),USE(?Merkis:Radio2),VALUE('2')
         RADIO('Teko�� direktorij�'),AT(16,40,161,10),USE(?Merkis:Radio3),VALUE('3')
       END
       BUTTON('&Atlikt'),AT(109,61,36,14),USE(?CancelButton:T)
       BUTTON('&OK'),AT(147,61,35,14),USE(?OkButton:T),DEFAULT
     END
  CODE                                            ! Begin processed code
  PUSHBIND

  IF F:XML
     E='E'
     DISKETE=FALSE
     disks=''
     MERKIS='1'
     OPEN(TOSCREEN)
     ?Merkis:radio1{prop:text}=USERFOLDER
     ?Merkis:radio3{prop:text}=path()
     DISPLAY
     ACCEPT
        CASE FIELD()
        OF ?OkButton:T
           CASE EVENT()
           OF EVENT:Accepted
              EXECUTE CHOICE(?MERKIS)
                 DISKS=USERFOLDER&'\'
                 BEGIN
                    DISKS=USERFOLDER&'\'
                    DISKETE=TRUE
                 .
                 DISKS=''
              .
              LocalResponse = RequestCompleted
              BREAK
           END
        OF ?CancelButton:T
           CASE EVENT()
           OF EVENT:Accepted
             LocalResponse = RequestCancelled
              DO ProcedureReturn
           .
        END
     END
     CLOSE(TOSCREEN)
     XMLFILENAME=DISKS&'ZDN.DUF'
     CHECKOPEN(OUTFILEXML,1)
     CLOSE(OUTFILEXML)
     OPEN(OUTFILEXML,18)
     IF ERROR()
        KLUDA(1,XMLFILENAME)
     ELSE
        EMPTY(OUTFILEXML)
        F:XML_OK#=TRUE
        XML:LINE='<<?xml version="1.0" encoding="windows-1257" ?>'
        ADD(OUTFILEXML)
!        XML:LINE='<<!DOCTYPE DeclarationFile SYSTEM "DUF.dtd">'
!        ADD(OUTFILEXML)
        XML:LINE='<<DeclarationFile type="zinas_par_dn">'
        ADD(OUTFILEXML)
        XML:LINE='<<Declaration>'
        ADD(OUTFILEXML)
     .
  .

  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  IF KAD_RIK::Used = 0
    CheckOpen(KAD_RIK,1)
  END
  KAD_RIK::Used += 1
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1

  BIND(KAD:RECORD)
  BIND('ID',ID)
  BIND('F:NODALA',F:NODALA)
  BIND('F:IDP',F:IDP)
  DATUMS=TODAY()

  FilesOpened = True
  RecordsToProcess = RECORDS(KADRI)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'Zi�as par DN'
  ?Progress:UserString{Prop:Text}=''
  SEND(KADRI,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      SET(KAD:INI_KEY)
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


      IF F:XML_OK#=TRUE
         XML:LINE='<<DeclarationHeader>'
         ADD(OUTFILEXML)
         IF ~GL:VID_NR THEN KLUDA(87,'J�su NMR kods').
         XML:LINE='<<Field name="nmr_kods" value="'&GL:REG_NR&'" />'
         ADD(OUTFILEXML)
         TEX:DUF=CLIENT
         DO CONVERT_TEX:DUF
         XML:LINE='<<Field name="isais_nosauk" value="'&CLIP(TEX:DUF)&'" />'
         ADD(OUTFILEXML)
         XML:LINE='<<Field name="vaditajs" value="'&CLIP(SYS:PARAKSTS1)&'" />'
         ADD(OUTFILEXML)
         IF ~SYS:PARAKSTS2 THEN KLUDA(87,'Izpild�t�js').
         XML:LINE='<<Field name="izpilditajs" value="'&CLIP(SYS:PARAKSTS2)&'" />'
         ADD(OUTFILEXML)
!         XML:LINE='<<Field name="telef" value="'&CLIP(SYS:TEL)&'" />'
!         ADD(OUTFILEXML)
!         XML:LINE='<<Field name="datums_aizp" value="'&FORMAT(TODAY(),@D06.)&'" />'
!         ADD(OUTFILEXML)
         XML:LINE='<</DeclarationHeader>'
         ADD(OUTFILEXML)
      .


      IF F:DBF = 'W'
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
        PRINT(RPT:PAGE_HEAD)
      ELSE           !WORD,EXCEL
        IF ~OPENANSI('DNKUS.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'1.pielikums'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Ministru kabineta'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'2000.g. 14.nov.'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Noteikumiem Nr 397'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Valsts ie��mumu dienesta'&CHR(9)&GL:VID_NOS&CHR(9)&'teritori�l� iest�de'
        ADD(OUTFILEANSI)
        OUTA:LINE='Nodok�u maks�t�ja kods'&CHR(9)&GL:VID_NR
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CLIENT
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='    ZI�AS PAR DARBA ��M�JIEM'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        IF F:DBF = 'E' !2 LINES
           OUTA:LINE='Npk'&CHR(9)&'Personas kods vai'&CHR(9)&'Personas dzim�anas dati'&CHR(9)&'V�rds, uzv�rds'&CHR(9)&|
           'Datums'&CHR(9)&'Zi�u'
           ADD(OUTFILEANSI)
           OUTA:LINE=CHR(9)&'re�istr�cijas numurs'&CHR(9)&'(ja nav personas koda)'&CHR(9)&CHR(9)&'m�nesis,gads'&CHR(9)&'kods'
           ADD(OUTFILEANSI)
        ELSE !WORDAM 1 RIND�
           OUTA:LINE='Npk'&CHR(9)&'Personas kods vai re�istr�cijas numurs'&CHR(9)&|
           'Personas dzim�anas dati (ja nav personas koda)'&CHR(9)&'V�rds, uzv�rds'&CHR(9)&|
           'Datums (m�nesis,gads)'&CHR(9)&'Zi�u kods'
           ADD(OUTFILEANSI)
        .
!        OUTA:LINE=''
!        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        NPK#+=1
        ?Progress:UserString{Prop:Text}=NPK#
        DISPLAY
        LOOP I#= 1 TO 2
           EXECUTE I#
              ZDAT=KAD:DARBA_GR
              ZDAT=KAD:D_GR_END
           .
           IF INRANGE(ZDAT,S_DAT,B_DAT)
             VUT = CLIP(KAD:VAR) & ' ' &CLIP(KAD:UZV)
             PERSKODS=KAD:PERSKOD
             EXECUTE I#
                ZK=KAD:Z_KODS
                ZK=KAD:Z_KODS_END
             .
             NPK+=1
             IF F:XML_OK#=TRUE
                XML:LINE='<<Row>'
                ADD(OUTFILEXML)
                XML:LINE='<<Field name="pers_kods" value="'&DEFORMAT(KAD:PERSKOD,@P######-#####P)&'" />'
                ADD(OUTFILEXML)
                XML:LINE='<<Field name="uzv_vards" value="'&CLIP(VUT)&'" />'
                ADD(OUTFILEXML)
                XML:LINE='<<Field name="datums_izm" value="'&FORMAT(ZDAT,@D06.)&'" />'
                ADD(OUTFILEXML)
                XML:LINE='<<Field name="izm_kods" value="'&ZK&'" />'
                ADD(OUTFILEXML)
                XML:LINE='<</Row>'
                ADD(OUTFILEXML)
             .
             IF F:DBF = 'W'
                PRINT(RPT:detail)
             ELSE
                OUTA:LINE=CLIP(Npk)&CHR(9)&PERSKODS&CHR(9)&CHR(9)&VUT&CHR(9)&FORMAT(ZDAT,@D06.)&CHR(9)&ZK
                ADD(OUTFILEANSI)
             END
           .
        .
        CLEAR(RIK:RECORD)
        RIK:ID = KAD:ID
        SET(RIK:DAT_KEY,RIK:DAT_KEY)
        LOOP
           NEXT(KAD_RIK)
           IF ERROR() OR ~(RIK:ID=KAD:ID) THEN BREAK.
           IF ~INSTRING(RIK:TIPS,'KAC') THEN CYCLE. ! IESP�JAM�S ZI�AS NO R�KOJUMIEM
           IF ~INRANGE(RIK:DATUMS,S_DAT,B_DAT) THEN CYCLE.
           IF ~RIK:Z_KODS THEN CYCLE.
           VUT = CLIP(KAD:VAR) & ' ' &CLIP(KAD:UZV)
           PERSKODS=KAD:PERSKOD
           ZK=RIK:Z_KODS
           ZDAT=RIK:DATUMS
           NPK+=1
           IF F:XML_OK#=TRUE
              XML:LINE='<<Row>'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="pers_kods" value="'&DEFORMAT(KAD:PERSKOD,@P######-#####P)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="uzv_vards" value="'&CLIP(VUT)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="datums_izm" value="'&FORMAT(ZDAT,@D06.)&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<<Field name="izm_kods" value="'&ZK&'" />'
              ADD(OUTFILEXML)
              XML:LINE='<</Row>'
              ADD(OUTFILEXML)
           .
           IF F:DBF = 'W'
              PRINT(RPT:detail)
           ELSE
              OUTA:LINE=CLIP(Npk)&CHR(9)&PERSKODS&CHR(9)&CHR(9)&VUT&CHR(9)&FORMAT(ZDAT,@D06.)&CHR(9)&ZK
              ADD(OUTFILEANSI)
           .
        .

!LOOP KAD_RIK
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
  IF SEND(KADRI,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    IF F:XML_OK#=TRUE
       XML:LINE='<</Declaration>'
       ADD(OUTFILEXML)
       XML:LINE='<</DeclarationFile>'
       ADD(OUTFILEXML)
       CLOSE(OUTFILEXML)
       IF DISKETE=TRUE
          FILENAME2='A:\DDZ_P.DUF'
          IF ~CopyFileA(XMLFILENAME,FILENAME2,0)
             KLUDA(3,XMLFILENAME&' uz '&FILENAME2)
          .
       .
    .
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL2)
        IF YEAR(B_DAT) < 2003
           PRINT(RPT:ZINU_KODI)
        ELSE
           PRINT(RPT:ZINU_KODI_NEW)
        .
        PRINT(RPT:PARAKSTI)
    ELSE
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Npk'&CHR(9)&'Zi�u kods'&CHR(9)&'At�ifr�jums'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='1.  '&CHR(9)&'11'&CHR(9)&'T�da darba ��m�ja statusa ieg��ana, kur� ir apdro�in�ms atbilsto�i visiem valsts soci�l�s apdro�in��anas veidiem'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='2.  '&CHR(9)&CHR(9)&'T�da darba ��m�ja ieg��ana, kur� ir pak�auts valsts pensiju apdro�in��anai, invalidit�tes apdro�in��anai,'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'maternit�tes un slim�bas apdro�in��anai un soci�lajai apdro�in��anai pret nelaimes gad�jumiem darb� un arodslim�b�m'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'(darba ��m�jam, kur� ir I vai II grupas inval�ds)'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='3.  '&CHR(9)&CHR(9)&'T�da darba ��m�ja ieg��ana, kur� ir pak�auts valsts pensiju apdro�in��anai, maternit�tes un slim�bas apdro�in��anai,'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'un soci�lajai apdro�in��anai pret nelaimes gad�jumiem darb� un arodslim�b�m'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'(darba ��m�jam, kur� ir sasniedzis vecumu, kas dod ties�bas sa�emt valsts vecuma pensiju; darba ��m�jam, kuram ir pie��irta'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'vecuma pensija ar atvieglotiem noteikumiem)'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='4.  '&CHR(9)&CHR(9)&'Darba ��m�ja statusa zaud��ana, pamatojoties uz darba ��m�ja uzteikumu'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='5.  '&CHR(9)&CHR(9)&'Darba ��m�ja statusa zaud��ana sakar� ar darba ��m�ja p�rk�pumu normat�vajos aktos noteiktajos gad�jumos'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='6.  '&CHR(9)&CHR(9)&'Darba ��m�ja statusa zaud��ana sakar� ar darba dev�ja likvid�ciju'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='7.  '&CHR(9)&CHR(9)&'Darba ��m�ja statusa zaud��ana sakar� ar nesp�ju veikt nol�gto darbu vesel�bas st�vok�a d��'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='8.  '&CHR(9)&CHR(9)&'Darba ��m�ja statusa zaud��ana citos gad�jumos'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='9.  '&CHR(9)&CHR(9)&'Darba ��m�ja apdro�in��anas statusa mai�a - darba ��m�js, kur� ir apdro�in�ms visiem valsts soci�l�s'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'apdro�in��anas veidiem (darba ��m�jam, kur� ir zaud�jis I vai II grupas invalidit�ti)'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='10. '&CHR(9)&CHR(9)&'Darba ��m�ja apdro�in��anas statusa mai�a - darba ��m�js, kur� ir pak�auts valsts pensiju apdro�in��anai,'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'invalidit�tes apdro�in��anai, maternit�tes un slim�bas apdro�in��anai un soci�lajai apdro�in��anai pret'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'nelaimes gad�jumiem darb� un arodslim�b�m (darba ��m�jam, kur� ir ieguvis I vai II grupas invalidit�ti'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='11. '&CHR(9)&CHR(9)&'Darba ��m�ja apdro�in��anas statusa mai�a - darba ��m�js, kur� ir pak�auts valsts pensiju apdro�in��anai,'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'maternit�tes un slim�bas apdro�in��anai un soci�lajai apdro�in��anai pret nelaimes gad�jumiem darb� un'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'arodslim�b�m (darba ��m�jam, kur� ir sasniedzis vecumu, kas dod ties�bas sa�emt valsts vecuma pensiju;'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'darba ��m�jam, kuram ir pie��irta vecuma pensija ar atvieglotiem noteikumiem)'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='12. '&CHR(9)&CHR(9)&'Darba ��m�jam ir pie��irts b�rna kop�anas atva�in�jums'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='13. '&CHR(9)&CHR(9)&'Darba ��m�js, kuram ir b�rns vecum� l�dz trim gadiem, nodarbin�ts nepilnu darba ned��u (l�dz 20 stund�m'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'ned���, ja b�rns ir vecum� l�dz pusotram gadam, un l�dz 34 stund�m ned���, ja b�rns ir vecum� no pusotra'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'l�dz trim gadam)'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='14. '&CHR(9)&CHR(9)&'Darba ��m�js, kuram ir b�rns vecum� l�dz trim gadiem, nodarbin�ts pilnu darba ned��u (vair�k par 20 stund�m'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'ned���, ja b�rns ir vecum� l�dz pusotram gadam, un vair�k par 34 stund�m ned���, ja b�rns ir vecum� no'
        ADD(OUTFILEANSI)
        OUTA:LINE='    '&CHR(9)&CHR(9)&'pusotra l�dz trim gadiem)'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='Izpild�t�js:'&CLIP(SYS:PARAKSTS2)&' T�lru�a numurs:'&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE='Vad�t�js:'&SYS:PARAKSTS1
        ADD(OUTFILEANSI)
        OUTA:LINE='Datums'&FORMAT(DATUMS,@D06.)
        ADD(OUTFILEANSI)
        OUTA:LINE='Z.V.'
        ADD(OUTFILEANSI)
    END
    CLOSE(ProgressWindow)
    IF F:DBF='W'
       ENDPAGE(report)
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
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
    KAD_RIK::Used -= 1
    IF KAD_RIK::Used = 0 THEN CLOSE(KAD_RIK).
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
      StandardWarning(Warn:RecordFetchError,'KADRI')
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END

!-----------------------------------------------------------------------------
CONVERT_TEX:DUF  ROUTINE
  LOOP J#= 1 TO LEN(TEX:DUF)  !CSTRING NEVAR LIKT
     IF TEX:DUF[J#]='"'
        TEX:DUF=TEX:DUF[1:J#-1]&'&quot;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='<<'
        TEX:DUF=TEX:DUF[1:J#-1]&'&lt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='>'
        TEX:DUF=TEX:DUF[1:J#-1]&'&gt;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]='&'
        TEX:DUF=TEX:DUF[1:J#-1]&'&amp;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     ELSIF TEX:DUF[J#]=''''
        TEX:DUF=TEX:DUF[1:J#-1]&'apos;'&TEX:DUF[J#+1:LEN(CLIP(TEX:DUF))]
     .
  .
A_ParskNeIIN         PROCEDURE                    ! Declare Procedure
NPK                 DECIMAL(3)
PASE                STRING(25)
PASE1               STRING(25)
ADRESE              STRING(25)
ADRESE1             STRING(25)
SUMMAIEN            DECIMAL(8,2)
IZMDAT              LONG
IENNODPROC          DECIMAL(4,1)
SUMMASAM            DECIMAL(9,2)
YYYYMM              LONG
datums              long
!-----------------------------------------------------------------------------
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
!-----------------------------------------------------------------------------
Process:View         VIEW(ALGAS)
                       PROJECT(ALG:APGAD_SK)
                       PROJECT(ALG:ID)
                       PROJECT(ALG:INI)
                       PROJECT(ALG:INV_P)
                       PROJECT(ALG:IZMAKSAT)
                       PROJECT(ALG:LBER)
                       PROJECT(ALG:LINV)
                       PROJECT(ALG:LMIA)
                       PROJECT(ALG:N_STUNDAS)
                       PROJECT(ALG:PR1)
                       PROJECT(ALG:PR37)
                       PROJECT(ALG:NODALA)
                       PROJECT(ALG:STATUSS)
                       PROJECT(ALG:YYYYMM)
                     END
!-----------------------------------------------------------------------------
report REPORT,AT(298,1720,9000,6302),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         LANDSCAPE,THOUS
       HEADER,AT(298,198,9000,1521)
         LINE,AT(156,104,1875,0),USE(?Line1),COLOR(COLOR:Black)
         STRING('Iesniedz Valsts ie��mumu dienest�'),AT(208,156,1823,208),USE(?String1),CENTER
         STRING('noteikumiem Nr. 166'),AT(7708,573,,156),USE(?String5),LEFT
         STRING('P � R S K A T S'),AT(3646,469,1719,260),USE(?String6),CENTER,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         STRING('par nerezidenta g�tajiem ien�kumiem un samaks�to iedz�vot�ju ien�kuma nodokli La' &|
             'tvijas Republik�'),AT(677,729),USE(?String7),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('DECLARATION'),AT(469,990,1563,260),USE(?String6:2),LEFT,FONT(,14,,FONT:bold,CHARSET:BALTIC)
         STRING('on income derived and income tax paid in the Republic of Latvija'),AT(469,1250,5208,260), |
             USE(?String7:2),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(156,365,1875,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('2000. gada 2. maija'),AT(7708,417,,156),USE(?String4),LEFT
         STRING('Ministru kabineta'),AT(7708,260,885,156),USE(?String3),LEFT
         STRING('3. pielikums'),AT(7708,104,,156),USE(?String2),LEFT,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2031,104,0,260),USE(?Line4),COLOR(COLOR:Black)
         LINE,AT(156,104,0,260),USE(?Line3),COLOR(COLOR:Black)
       END
detail DETAIL,AT(,,,4302)
         STRING('Rezidences'),AT(1552,3490,729,156),USE(?String13:20),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,3438,8646,0),USE(?Line6:11),COLOR(COLOR:Black)
         LINE,AT(469,3438,0,885),USE(?Line12:9),COLOR(COLOR:Black)
         STRING('Nr.'),AT(250,3490,208,156),USE(?String13:14),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('V�rds,'),AT(510,3490,990,156),USE(?String13:16),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(1510,3438,0,885),USE(?Line35),COLOR(COLOR:Black)
         STRING('Name, surname'),AT(510,3802,990,156),USE(?String13:18),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Resident'),AT(1552,3802,729,156),USE(?String13:22),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('country'),AT(1552,3958,729,156),USE(?String13:19),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('identification dokument,'),AT(2333,3958,1615,156),USE(?String13:26),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('number, date of issue'),AT(2333,4115,1615,156),USE(?String13:27),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(6188,4115,573,156),USE(val_uzsk),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(8115,4115,729,156),USE(val_uzsk,,?val_uzsk:2),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,4271,8646,0),USE(?Line6:12),COLOR(COLOR:Black)
         LINE,AT(8854,3438,0,885),USE(?Line35:9),COLOR(COLOR:Black)
         STRING('Tax paid'),AT(8115,3958,729,156),USE(?String13:50),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('nodoklis/'),AT(8115,3802,729,156),USE(?String13:49),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('s�tais'),AT(8115,3646,729,156),USE(?String13:48),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Samak-'),AT(8115,3490,729,156),USE(?String13:47),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Latvija'),AT(7135,2708,1719,208),USE(?String13:52),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(8073,3438,0,885),USE(?Line35:8),COLOR(COLOR:Black)
         STRING('(%)'),AT(7542,3958,521,156),USE(?String13:46),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Tax rate'),AT(7542,3802,521,156),USE(?String13:45),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('likme/'),AT(7542,3646,521,156),USE(?String13:44),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Nodok�a'),AT(7542,3490,521,156),USE(?String13:43),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7500,3438,0,885),USE(?Line35:7),COLOR(COLOR:Black)
         STRING('payment'),AT(6813,3958,677,156),USE(?String13:42),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Date of'),AT(6813,3802,677,156),USE(?String13:41),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('datums/'),AT(6813,3646,677,156),USE(?String13:40),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Izmaksas'),AT(6813,3490,677,156),USE(?String13:39),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('of income'),AT(6188,3958,573,156),USE(?String13:37),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6771,3438,0,885),USE(?Line35:6),COLOR(COLOR:Black)
         STRING('Amount'),AT(6188,3802,573,156),USE(?String13:36),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('summa/'),AT(6188,3646,573,156),USE(?String13:35),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ien�k.'),AT(6188,3490,573,156),USE(?String13:34),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(6146,3438,0,885),USE(?Line35:5),COLOR(COLOR:Black)
         STRING('income'),AT(5667,3958,469,156),USE(?String13:33),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Type of'),AT(5667,3802,469,156),USE(?String13:32),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('veids/'),AT(5667,3646,469,156),USE(?String13:31),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Ien�k.'),AT(5667,3490,469,156),USE(?String13:30),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5625,3438,0,885),USE(?Line35:4),COLOR(COLOR:Black)
         STRING('Adrese/Address'),AT(4000,3698,1615,156),USE(?String13:28),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('numurs, izdo�anas datums/'),AT(2333,3802,1615,156),USE(?String13:25),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(3958,3438,0,885),USE(?Line35:3),COLOR(COLOR:Black)
         STRING('apliecino�s dokuments,'),AT(2333,3646,1615,156),USE(?String13:24),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(2292,3438,0,885),USE(?Line35:2),COLOR(COLOR:Black)
         STRING('Personu'),AT(2333,3490,1615,156),USE(?String13:23),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('valsts/'),AT(1552,3646,729,156),USE(?String13:21),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('uzv�rds/'),AT(510,3646,990,156),USE(?String13:17),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('No.'),AT(250,3646,208,156),USE(?String13:15),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,3438,0,885),USE(?Line12:13),COLOR(COLOR:Black)
         LINE,AT(208,2135,8646,0),USE(?Line6:7),COLOR(COLOR:Black)
         LINE,AT(8854,625,0,729),USE(?Line12:4),COLOR(COLOR:Black)
         LINE,AT(6146,625,0,729),USE(?Line12:3),COLOR(COLOR:Black)
         LINE,AT(3438,625,0,729),USE(?Line12:2),COLOR(COLOR:Black)
         STRING('Re�istr�cijas numurs Uz��mumu re�istr�/'),AT(3469,677,2656,208),USE(?String13:2),CENTER, |
             FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Registration number'),AT(3469,885,2656,208),USE(?String13:3),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Taxpayer Re�ister Code'),AT(6177,885,2656,208),USE(?String13:5),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1094,8646,0),USE(?Line6:3),COLOR(COLOR:Black)
         STRING(@s45),AT(260,1146,3177,208),USE(CLIENT),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC),COLOR(COLOR:White)
         STRING(@s25),AT(3385,52,1927,208),USE(GL:VID_NOS),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC),COLOR(COLOR:White)
         STRING(@s11),AT(4375,1146),USE(GL:REG_NR),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s13),AT(7083,1146),USE(GL:VID_NR),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1354,8646,0),USE(?Line6:4),COLOR(COLOR:Black)
         STRING('vai / or'),AT(2552,1406,3177,208),USE(?String13:7),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('II. Nerezidentu (ien�kuma sa��m�ju) g�tie ien�kumi un samaks�tais nodoklis/'),AT(260,3021,8594,208), |
             USE(?String10:5),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC),COLOR(COLOR:White)
         STRING('Non-resident (recipient of income), income derived and income tax paid'),AT(365,3229,4323,208), |
             USE(?String10:6),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC),COLOR(COLOR:White)
         STRING('Izmaks�t�ja adrese/Address of payer'),AT(3021,2188),USE(?String10:4),CENTER,FONT(,10,,FONT:bold,CHARSET:BALTIC), |
             COLOR(COLOR:White)
         STRING(@s45),AT(625,2708,4271,208),USE(sys:adrese),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC),COLOR(COLOR:White)
         LINE,AT(208,2396,8646,0),USE(?Line6:8),COLOR(COLOR:Black)
         LINE,AT(7083,2396,0,521),USE(?Line12:11),COLOR(COLOR:Black)
         LINE,AT(8854,2396,0,521),USE(?Line12:12),COLOR(COLOR:Black)
         LINE,AT(208,2396,0,521),USE(?Line12:8),COLOR(COLOR:Black)
         LINE,AT(208,1615,8646,0),USE(?Line6:5),COLOR(COLOR:Black)
         LINE,AT(5938,1615,0,521),USE(?Line12:6),COLOR(COLOR:Black)
         LINE,AT(8854,1615,0,521),USE(?Line12:7),COLOR(COLOR:Black)
         STRING('V�rds, uzv�rds/Name, surname'),AT(708,1667,4875,208),USE(?String13:8),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Personas kods/Personal code'),AT(6063,1667,2688,208),USE(?String13:9),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,1875,8646,0),USE(?Line6:6),COLOR(COLOR:Black)
         STRING('Iela, numurs/Street, number'),AT(260,2448,2135,208),USE(?String13:10),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Pils�ta, apdz�vota vieta/City or place'),AT(2448,2448,2292,208),USE(?String13:11),CENTER, |
             FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Pasta indekss/Postal code'),AT(4792,2448,2208,208),USE(?String13:12),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Valsts/Country'),AT(7135,2448,1656,208),USE(?String13:13),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,2656,8646,0),USE(?Line6:9),COLOR(COLOR:Black)
         LINE,AT(208,2917,8646,0),USE(?Line6:10),COLOR(COLOR:Black)
         LINE,AT(208,1615,0,521),USE(?Line12:5),COLOR(COLOR:Black)
         STRING('Name of payer'),AT(240,885,3177,208),USE(?String13:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Nodok�u maks�t�ju re�istra kods/'),AT(6177,677,2656,208),USE(?String13:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,0,8646,0),USE(?Line5),COLOR(COLOR:Black)
         LINE,AT(3229,0,0,260),USE(?Line7:2),COLOR(COLOR:Black)
         LINE,AT(6823,0,0,260),USE(?Line7:4),COLOR(COLOR:Black)
         LINE,AT(8854,0,0,260),USE(?Line7:3),COLOR(COLOR:Black)
         STRING('Valsts ie��munu dienesta/State Revenue Service'),AT(240,52,2969,208),USE(?String10), |
             LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC),COLOR(COLOR:White)
         STRING('teritori�l� iest�de/local office'),AT(6875,52),USE(?String10:2),RIGHT,FONT(,10,,FONT:bold,CHARSET:BALTIC), |
             COLOR(COLOR:White)
         LINE,AT(208,260,8646,0),USE(?Line6),COLOR(COLOR:Black)
         STRING('I. Darba dev�js (ien�kuma izmaks�t�js)/Employer (Payer of income)'),AT(260,417),USE(?String10:3), |
             LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC),COLOR(COLOR:White)
         LINE,AT(208,625,8646,0),USE(?Line6:2),COLOR(COLOR:Black)
         STRING('Izmaks�t�ja nosaukums/'),AT(240,677,3177,208),USE(?String13),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(208,625,0,729),USE(?Line12),COLOR(COLOR:Black)
         LINE,AT(208,0,0,260),USE(?Line7),COLOR(COLOR:Black)
       END
detail1 DETAIL,AT(,,,313)
         LINE,AT(208,-10,0,323),USE(?Line45),COLOR(COLOR:Black)
         LINE,AT(469,-10,0,323),USE(?Line46),COLOR(COLOR:Black)
         LINE,AT(1510,-10,0,323),USE(?Line47),COLOR(COLOR:Black)
         LINE,AT(2292,-10,0,323),USE(?Line48),COLOR(COLOR:Black)
         LINE,AT(3958,-10,0,323),USE(?Line49),COLOR(COLOR:Black)
         STRING(@s25),AT(4010,10,,156),USE(ADRESE)
         LINE,AT(5625,-10,0,323),USE(?Line50),COLOR(COLOR:Black)
         LINE,AT(6146,-10,0,323),USE(?Line51),COLOR(COLOR:Black)
         STRING(@n_8.2),AT(6198,10,,156),USE(SummaIen),RIGHT
         LINE,AT(6771,-10,0,323),USE(?Line52),COLOR(COLOR:Black)
         STRING(@d6),AT(6823,10,,156),USE(IzmDat),RIGHT
         LINE,AT(7500,-10,0,323),USE(?Line53),COLOR(COLOR:Black)
         STRING(@n_4.1),AT(7604,10,,156),USE(IenNodProc),RIGHT
         LINE,AT(8073,-10,0,323),USE(?Line54),COLOR(COLOR:Black)
         STRING(@n_8.2),AT(8177,10,,156),USE(SummaSam),RIGHT
         LINE,AT(8854,-10,0,323),USE(?Line55),COLOR(COLOR:Black)
         STRING(@N3),AT(240,10,208,156),USE(NPK),RIGHT
         STRING(@s15),AT(521,10,,156),USE(kad:var)
         STRING(@s25),AT(2344,10,,156),USE(PASE)
         STRING(@s15),AT(521,156,,156),USE(kad:UZV)
         STRING(@s25),AT(2344,156,,156),USE(PASE1)
         STRING(@s25),AT(4010,156,,156),USE(adrese1)
         STRING('alga'),AT(5667,156,469,156),USE(?String13:53),CENTER
         LINE,AT(208,313,8646,0),USE(?Line56),COLOR(COLOR:Black)
         STRING('darba'),AT(5667,10,469,156),USE(?String13:29),CENTER
       END
detail3 DETAIL,AT(,,,1333)
         STRING('Official'),AT(781,885,573,156),USE(?String92:2),CENTER
         LINE,AT(2969,1250,5885,0),USE(?Line66:3),COLOR(COLOR:Black)
         STRING('seal'),AT(781,1042,573,156),USE(?String92:3),CENTER
         STRING('III. Ien�kumu izmaks�t�ja apliecin�jums/Certificate of the payer of income'),AT(260,52,8594,208), |
             USE(?String10:7),LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC),COLOR(COLOR:White)
         STRING('P�rskata parakst�t�js apliecina, ka �� pazi�ojuma I un II da�� sniegt� inform�ci' &|
             'ja ir piln�ga un pareiza.'),AT(260,260,8594,208),USE(?String10:8),LEFT,FONT(,9,,,CHARSET:BALTIC), |
             COLOR(COLOR:White)
         STRING('The undersigned declares that the particular information given in part I and II ' &|
             'of this declaration is correct.'),AT(260,469,8594,208),USE(?String10:9),LEFT,FONT(,9,,,CHARSET:ANSI), |
             COLOR(COLOR:White)
         LINE,AT(2969,729,5885,0),USE(?Line66),COLOR(COLOR:Black)
         LINE,AT(2969,990,5885,0),USE(?Line66:2),COLOR(COLOR:Black)
         LINE,AT(8854,729,0,521),USE(?Line68:2),COLOR(COLOR:Black)
         STRING('Datums/Date'),AT(7688,781,1146,208),USE(?String13:57),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Z. v.'),AT(833,729,417,156),USE(?String92),CENTER
         LINE,AT(7656,729,0,521),USE(?Line69:3),COLOR(COLOR:Black)
         LINE,AT(6250,729,0,521),USE(?Line69:2),COLOR(COLOR:Black)
         STRING('Paraksts/Signature'),AT(6281,781,1354,208),USE(?String13:56),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(4167,729,0,521),USE(?Line69),COLOR(COLOR:Black)
         LINE,AT(2969,729,0,521),USE(?Line68),COLOR(COLOR:Black)
         STRING('V�rds, uzv�rds/Name, surname'),AT(4198,781,2031,208),USE(?String13:55),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
         STRING('Amats/Position'),AT(3000,781,1146,208),USE(?String13:54),CENTER,FONT(,8,,FONT:bold,CHARSET:BALTIC)
       END
       FOOTER,AT(298,8000,9000,52)
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
  BIND('YYYYMM',YYYYMM)
  NPK = 0
  datums=today()
  IF SYS:NOKL_DC
     IZMDAT=DATE(MONTH(ALP:YYYYMM),SYS:NOKL_DC,YEAR(ALP:YYYYMM))
  .
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  FilesOpened = True
  RecordsToProcess = RECORDS(ALGAS)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0%'
  ProgressWindow{Prop:Text} = 'P�rskats par nerezidentu IIN'
  ?Progress:UserString{Prop:Text}=''
  SEND(ALGAS,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(ALG:RECORD)
      ALG:YYYYMM=ALP:YYYYMM
      YYYYMM=ALG:YYYYMM
      SET(ALG:ini_KEY,ALG:INI_KEY)
      Process:View{Prop:Filter} = 'YYYYMM=ALG:YYYYMM'
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
      OPEN(report)
      report{Prop:Preview} = PrintPreviewImage
      PRINT(RPT:DETAIL)
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        IF GETKADRI(ALG:ID,0,10)='N'  !NEREZIDENTS
          S$=SUM(33)
          T$=SUM(28)
          IF S$ AND T$
            pase=kad:pase[1:25]
            pase1=kad:pase[26:35]
            LEN#=LEN(CLIP(KAD:PASE))
            IF LEN#>25
              LOOP I#=25 TO 25-10-(35-LEN#) BY -1
                IF INSTRING(KAD:PASE[I#],' ')
                  pase=kad:pase[1:I#]
                  pase1=kad:pase[I#+1:35]
                  BREAK
                .
              .
            .
            adrese=kad:PIERadr[1:25]
            adrese1=kad:PIERadr[26:35]
            LEN#=LEN(CLIP(KAD:PIERADR))
            IF LEN#>25
              LOOP I#=25 TO 25-10-(35-LEN#) BY -1
                IF INSTRING(KAD:PIERADR[I#],' ')
                  adrese=kad:pieradr[1:I#]
                  adrese1=kad:pieradr[I#+1:35]
                  BREAK
                .
              .
            .
            NPK += 1
            SUMMAIEN = SUM(33)
            IENNODPROC= ALP:PR_PAM
            SUMMASAM = SUM(22)+SUM(26)+SUM(27)
            PRINT(RPT:DETAIL1)
          END
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
  IF SEND(ALGAS,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    PRINT(RPT:DETAIL3)
     ENDPAGE(report)
     CLOSE(ProgressWindow)
     F:DBF='W'   ! .................... PAGAID�M TIKAI WMF
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
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
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
      StandardWarning(Warn:RecordFetchError,'ALGAS')
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '%'
      DISPLAY()
    END
  END


