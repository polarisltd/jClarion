                     MEMBER('winlats.clw')        ! This is a MEMBER module
B_PVN_DEK01          PROCEDURE                    ! Declare Procedure
RejectRecord         LONG
EOF                  BYTE
CG           STRING(10)
SAK_MEN      STRING(2)
BEI_MEN      STRING(2)
BEI_DAT      STRING(2)
K31          REAL
K33          REAL
K34          REAL
K54          REAL
K56          REAL
R1           DECIMAL(12,2)
R2           DECIMAL(12,2)
R3           DECIMAL(12,2)
R4           DECIMAL(12,2)
R5           DECIMAL(12,2)
R6           DECIMAL(12,2)
R7           DECIMAL(12,2)
R8           DECIMAL(12,2)
R9           DECIMAL(12,2)
R10          DECIMAL(12,2)
R14          DECIMAL(12,2)
R15          DECIMAL(12,2)
R21          DECIMAL(12,2)
R22          DECIMAL(12,2)
R23          DECIMAL(12,2)
R24          DECIMAL(12,2)
R25          DECIMAL(12,2)
R26          DECIMAL(12,2)
R27          DECIMAL(12,2)
SS           DECIMAL(12,2)
PP           DECIMAL(12,2)
RSG          DECIMAL(12,2)
DATUMS       DATE
G            STRING(4)
rmenesiem    string(8)
SUM1         STRING(11)
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
PrintSkipDetails     BOOL,AUTO
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
report REPORT,AT(300,396,8000,11604),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
detail DETAIL,AT(-10,10,8000,7500)
         STRING('3. pielikums'),AT(6302,52,573,156),USE(?String92) 
         STRING('Ministru kabineta'),AT(6302,208,885,156),USE(?String92:2) 
         STRING('2001. gada 30. janvâra'),AT(6302,365,1250,156),USE(?String92:3) 
         STRING('Valsts ieòçmumu dienests'),AT(2656,781),USE(?String1),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('noteikumiem Nr. 46'),AT(6302,521,1042,156),USE(?String92:4) 
         STRING('PIEVIENOTÂS VÇRTÎBAS NODOKÏA DEKLARÂCIJA'),AT(1823,1094),USE(?String2),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('Taksâcijas'),AT(6615,1458),USE(?String3),CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING('Gads'),AT(6760,1979,365,208),USE(?String6),CENTER,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(208,1406,0,1302),USE(?Line3),COLOR(COLOR:Black)
         STRING(@S1),AT(6458,2240,188,208),USE(G[1]),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(6719,2240,188,208),USE(G[2]),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(6979,2240,188,208),USE(G[3]),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING(@S1),AT(7240,2240,188,208),USE(G[4]),CENTER(1),FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('Maksâtâja'),AT(313,1458),USE(?String8),LEFT,FONT(,10,,FONT:regular)
         LINE,AT(6302,1406,0,1302),USE(?Line44:3),COLOR(COLOR:Black)
         LINE,AT(1875,1406,0,1302),USE(?Line44),COLOR(COLOR:Black)
         STRING('Adrese'),AT(313,2083),USE(?String10),LEFT,FONT(,,,FONT:regular)
         STRING(@s50),AT(2031,2083,4219,260),USE(GL:ADRESE),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         STRING('periods'),AT(6719,1667),USE(?String3:2),CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING('saîsinâtais nosaukums'),AT(313,1667),USE(?String8:2),LEFT,FONT(,10,,FONT:regular)
         LINE,AT(208,1927,6094,0),USE(?Line1:53),COLOR(COLOR:Black)
         LINE,AT(208,1406,6094,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('PVN reìistrâcijas Nr. LV'),AT(313,2500),USE(?String12),LEFT,FONT(,,,FONT:regular)
         STRING(@s13),AT(2031,2500,1146,208),USE(GL:REG_NR),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5104,2969,0,469),USE(?Line3:2),COLOR(COLOR:Black)
         STRING(@s45),AT(2031,1563,3854,208),USE(CLIENT),LEFT,FONT(,11,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7448,3438,0,-469),USE(?Line3:3),COLOR(COLOR:Black)
         STRING('Samaksâtais'),AT(521,3958,833,208),USE(?String14),LEFT
         STRING(@N_4),AT(1354,3958),USE(GADS),RIGHT(1)
         STRING('. gadâ'),AT(1771,3958),USE(?String42)
         STRING(@N-_10),AT(5781,3938),USE(RSG),RIGHT
         STRING('Aprçíinâtais'),AT(521,3594),USE(?String16),LEFT
         STRING(@N-_10),AT(5781,3594),USE(R15),RIGHT
         STRING('Budþetâ maksâjamais vai no budþeta atmaksâjamais'),AT(521,4323),USE(?String15),LEFT
         LINE,AT(6406,2188,1042,0),USE(?Line1:5),COLOR(COLOR:Black)
         LINE,AT(6406,1406,1042,0),USE(?Line63),COLOR(COLOR:Black)
         LINE,AT(7188,2188,0,260),USE(?Line1:8),COLOR(COLOR:Black)
         LINE,AT(6406,1927,1042,0),USE(?Line1:55),COLOR(COLOR:Black)
         LINE,AT(208,2708,6094,0),USE(?Line1:6),COLOR(COLOR:Black)
         LINE,AT(5104,2969,2344,0),USE(?Line1:7),COLOR(COLOR:Black)
         LINE,AT(6927,2188,0,260),USE(?Line1:58),COLOR(COLOR:Black)
         STRING('Pievienotâs vçrtîbas'),AT(5156,3021,2292,208),USE(?String31),CENTER
         LINE,AT(6406,2448,1042,0),USE(?Line1:10),COLOR(COLOR:Black)
         LINE,AT(5104,3438,2344,0),USE(?Line1:12),COLOR(COLOR:Black)
         LINE,AT(5104,3542,2344,0),USE(?Line1:13),COLOR(COLOR:Black)
         LINE,AT(5104,4271,0,260),USE(?Line1:15),COLOR(COLOR:Black)
         LINE,AT(5104,3906,2344,0),USE(?Line1:26),COLOR(COLOR:Black)
         LINE,AT(5104,4167,2344,0),USE(?Line1:14),COLOR(COLOR:Black)
         LINE,AT(5104,4531,2344,0),USE(?Line1:16),COLOR(COLOR:Black)
         LINE,AT(208,4688,7240,0),USE(?Line66),COLOR(COLOR:Black)
         STRING('Apstiprinu, ka pievienotâs vçrtîbas nodokïa deklarâcijâ sniegtâ informâcija ir p' &|
             'ilnîga un patiesa '),AT(521,4792),USE(?String39)
         LINE,AT(5104,4271,2344,0),USE(?Line1:17),COLOR(COLOR:Black)
         LINE,AT(7448,4271,0,260),USE(?Line3:11),COLOR(COLOR:Black)
         LINE,AT(1615,5365,0,260),USE(?Line3:12),COLOR(COLOR:Black)
         STRING('Atbildîgâ persona :'),AT(521,5104),USE(?String64),LEFT
         LINE,AT(1771,6927,3542,0),USE(?Line1:19),COLOR(COLOR:Black)
         STRING(@S1),AT(990,7240),USE(RS) 
         LINE,AT(1615,5729,1719,0),USE(?Line1:24),COLOR(COLOR:Black)
         LINE,AT(5313,5729,1719,0),USE(?Line1:25),COLOR(COLOR:Black)
         LINE,AT(7031,5729,0,260),USE(?Line70:2),COLOR(COLOR:Black)
         LINE,AT(1615,5729,0,260),USE(?Line3:14),COLOR(COLOR:Black)
         LINE,AT(5313,5365,1719,0),USE(?Line1:23),COLOR(COLOR:Black)
         LINE,AT(1615,5625,1719,0),USE(?Line1:21),COLOR(COLOR:Black)
         LINE,AT(5313,5625,1719,0),USE(?Line1:523),COLOR(COLOR:Black)
         LINE,AT(208,4688,0,1458),USE(?Line1:18),COLOR(COLOR:Black)
         LINE,AT(208,6146,7240,0),USE(?Line35),COLOR(COLOR:Black)
         LINE,AT(7031,5365,0,260),USE(?Line3:16),COLOR(COLOR:Black)
         STRING('R : '),AT(729,7240),USE(?String99) 
         LINE,AT(7448,4688,0,1458),USE(?Line1:22),COLOR(COLOR:Black)
         STRING('Saòemðanas datums'),AT(469,6719),USE(?String73),LEFT
         LINE,AT(5313,5365,0,260),USE(?Line3:15),COLOR(COLOR:Black)
         LINE,AT(3333,5365,0,260),USE(?Line3:13),COLOR(COLOR:Black)
         LINE,AT(1771,6458,5677,0),USE(?Line36),COLOR(COLOR:Black)
         LINE,AT(1771,6667,5677,0),USE(?Line73),COLOR(COLOR:Black)
         STRING(@s5),AT(260,7240),USE(KKK) 
         STRING('Uzvârds'),AT(938,5417),USE(?String65),LEFT
         STRING(@s20),AT(1719,5417),USE(SYS:PARAKSTS1),LEFT
         STRING('Datums :'),AT(4635,5417),USE(?String68),LEFT
         STRING(@d6),AT(5885,5417),USE(datums)
         LINE,AT(1615,5365,1719,0),USE(?Line1:20),COLOR(COLOR:Black)
         STRING(@s15),AT(5573,5781),USE(SYS:TEL)
         LINE,AT(1615,5990,1719,0),USE(?Line67),COLOR(COLOR:Black)
         LINE,AT(5313,5990,1719,0),USE(?Line1:525),COLOR(COLOR:Black)
         LINE,AT(5313,5729,0,260),USE(?Line70),COLOR(COLOR:Black)
         STRING('Inspektora piezîmes'),AT(521,6250),USE(?String72)
         STRING('Paraksts'),AT(938,5781),USE(?String67),LEFT
         LINE,AT(3333,5729,0,260),USE(?Line3:17),COLOR(COLOR:Black)
         STRING('Tâlrunis :'),AT(4635,5781),USE(?String70),LEFT
         LINE,AT(7448,3906,0,260),USE(?Line3:10),COLOR(COLOR:Black)
         LINE,AT(7448,3542,0,260),USE(?Line3:9),COLOR(COLOR:Black)
         LINE,AT(5104,3802,2344,0),USE(?Line1:11),COLOR(COLOR:Black)
         STRING('nodoklis (latos)'),AT(5156,3229,2292,208),USE(?String34),CENTER,FONT(,9,,)
         LINE,AT(6667,2188,0,260),USE(?Line3:7),COLOR(COLOR:Black)
         LINE,AT(5104,3542,0,260),USE(?Line3:8),COLOR(COLOR:Black)
         LINE,AT(208,2448,6094,0),USE(?Line1:9),COLOR(COLOR:Black)
         LINE,AT(6406,1406,0,1042),USE(?Line3:6),COLOR(COLOR:Black)
         LINE,AT(7448,1406,0,1042),USE(?Line3:5),COLOR(COLOR:Black)
         LINE,AT(5104,3906,0,260),USE(?Line3:4),COLOR(COLOR:Black)
       END
     END
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
  CODE                                            ! Begin processed code
  PUSHBIND
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  CHECKOPEN(GGK,1)
  CHECKOPEN(GG,1)
  CHECKOPEN(PAR_K,1)
  BIND('MEN_NR',MEN_NR)
  BIND('kkk',kkk)
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF GGK::Used = 0
    CHECKOPEN(GGK,1)
  end
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)
  FilesOpened = True
  RecordsToProcess = RECORDS(GGK)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% Izpildîti'
  ProgressWindow{Prop:Text} = 'PVN gada atskaite'
  ?Progress:UserString{Prop:Text}='Uzgaidiet ...'
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      G=FORMAT(GADS,@N4)
      CG = 'K1000'
      SET(GGK:DAT_key,GGK:DAT_KEY)
      Process:View{Prop:Filter} = '~(GGK:U_NR=1) AND ~CYCLEGGK(CG)'
      IF ErrorCode()
        StandardWarning(Warn:ViewOpenError)
      END
      OPEN(Process:View)
      IF ErrorCode()
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
      IF F:DBF='W'   !WMF
        OPEN(report)
        report{Prop:Preview} = PrintPreviewImage
      ELSE           !RTF
        IF ~OPENANSI('PVNDKLRG.TXT')
           POST(Event:CloseWindow)
           CYCLE
        .
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'VALSTS IEÒÇMUMU DIENESTS'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&CHR(9)&CHR(9)&CHR(9)&'PIEVIENOTÂS VÇRTÎBAS DEKLARÂCIJA'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='-{106}'
        ADD(OUTFILEANSI)
        OUTA:LINE='Maksâtâja saîsinâtais nosaukums'&CHR(9)&CLIENT&CHR(9)&CHR(9)&CHR(9)&'Taksâcijas periods'
        ADD(OUTFILEANSI)
        OUTA:LINE='Adrese'&CHR(9)&GL:ADRESE&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'GADS'
        ADD(OUTFILEANSI)
        OUTA:LINE='PVN reìistrâcijas Nr. LV'&CHR(9)&GL:REG_NR&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&G[1]&CHR(9)&G[2]&CHR(9)&G[3]&CHR(9)&G[4]
        ADD(OUTFILEANSI)
        OUTA:LINE='-{106}'
        ADD(OUTFILEANSI)
      .
    OF Event:Timer
      LOOP RecordsPerCycle TIMES
        PrintSkipDetails = FALSE
        IF ~CYCLEBKK(GGK:BKK,KKK)    !IR PVN KONTS
           nk#+=1
           ?Progress:UserString{Prop:Text}=NK#
           DISPLAY(?Progress:UserString)
           CASE GGK:D_K
       !************************ SAMAKSÂTS PVN ********
           OF 'D'                                     ! SAMAKSÂTS PVN
             CASE GGK:PVN_TIPS
             OF '1'                                   ! PVN_TIPS=1 budþetam
               RSG+=GGK:SUMMA
             OF '2'                                   ! PVN_TIPS=2 IMPORTS
               R22+=GGK:SUMMA                     !
             OF '0'                                   ! SAMAKSÂTS,IEGÂDÂJOTIES
             OROF ''
               IF GGK:PVN_PROC=12                           ! PIEÐÛTS 12% ZEMNIEKIEM
                  R25+=GGK:SUMMA                  !
               ELSE
                  R23+=GGK:SUMMA                  !
               .
             .
       !************************ SAÒEMTS PVN ********
           OF 'K'                                     ! SAÒEMTS PVN
             CASE GGK:PVN_TIPS
             OF '1'                                   ! PVN_TIPS=1 budþetam
       !       RPT:ANKOP-=GGK:SUMMA                     ! AN NO FIN NOD.
             OF '2'                                   ! PVN_TIPS=2 IMPORTS
               KLUDA(20,GGK:U_NR&' '&FORMAT(GGK:DATUMS,@D6))
             OF '0'                                   ! SAÒEMTS,REALIZÇJOT
             OROF ''
               R8+=GGK:SUMMA
       !       IF GGK:P2=0
       !          RPT:R2+=(GGK:SUMMA*100)/sys:NOKL_AN   ! LIETOTÂJA KÏÛDA
       !       else
       !          RPT:R2+=(GGK:SUMMA*100)/GGK:P2
       !       .
             .
           .
        ELSIF INSTRING(GGK:BKK[1],'568') AND GGK:D_K='K' ! ÐEIT VAR BÛT NEAPLIEKAMIE DARÎJUMI
           C#=GETKON_K(GGK:BKK,2,1)
           LOOP R#=1 TO 2
              CASE KON:PVND[R#]        ! Neapliekamie darîjumi
              OF 3
                 R3 += GGK:SUMMA
              OF 4
                 R4 += GGK:SUMMA
              OF 5
                 R5 += GGK:SUMMA
     !        ELSE
     !           RPT:R2 += GGK:SUMMA   ! Apliekamie ar ?%
              .
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
  IF TODAY() > B_DAT+15
     DATUMS=B_DAT+15
  ELSE
     DATUMS=TODAY()
  .
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    R2=(R8*100)/sys:NOKL_PVN               ! ANALÎTISKI
  ! RPT:R1=RPT:R2+RPT:R3+RPT:R4+RPT:R5
    R1=R2+R3+R4          ! 19/06/98
    R7=ROUND((R2+R3)/R1*100,.01)
    R21=R22+R23+R24+R25
    R27=ROUND(R21*(100-R7)/100,.01)
    PP=R21-R26-R27
    SS=R8
    R15=SS-PP
    RSG=ROUND(RSG,.01)
    IF F:DBF = 'W'
        PRINT(RPT:DETAIL)                              !  PRINT DETAIL LINES
    ELSE
        SUM1 = R15
        OUTA:LINE=' {82}-{24}'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {82}| Pievienotâs vçrtîbas |'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {82}|   nodoklis (latos)   |'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {82}-{24}'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {10}Aprçíinâtais {60}|      '&SUM1&' {5}|'
        ADD(OUTFILEANSI)
        SUM1 = RSG
        OUTA:LINE=' {10}Samaksâtais '&GADS&'. gadâ {50}|      '&SUM1&' {5}|'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {10}Budþetâ maksâjamais vai no budþeta atmaksâjamais {24}| {22}|'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {82}-{24}'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='-{106}'
        ADD(OUTFILEANSI)
        OUTA:LINE=' {6}Apstirpinu, ka pievienotâs vçrtîbas nodokïa deklarâcijâ sniegta informâcija ir pilnîga un patiesa'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Atbildîgâ persona:'
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Uzvârds:'&CHR(9)&CHR(9)&SYS:PARAKSTS1&CHR(9)&CHR(9)&CHR(9)&'Datums: '&format(DATUMS,@D6)
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Paraksts:'&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&CHR(9)&'Tâlrunis: '&SYS:TEL
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE='-{106}'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Inspektora piezîmes'
        ADD(OUTFILEANSI)
        OUTA:LINE=''
        ADD(OUTFILEANSI)
        OUTA:LINE=CHR(9)&'Saòemðanas datums'
        ADD(OUTFILEANSI)
    END
    IF ~INRANGE(R8/R2*100-18,-3,3)
       KLUDA(85,R8/R2*100&' %')
    .
    endpage(Report)
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
      END
    ELSE
      CLOSE(OUTFILEANSI)
      RUN('WORDPAD '&ANSIFILENAME)
      IF RUNCODE()=-4
         KLUDA(88,'prog-a WordPad.exe')
      .
    .
  END
  IF F:DBF='W'   !WMF
     CLOSE(report)
     FREE(PrintPreviewQueue)
     FREE(PrintPreviewQueue1)
  ELSE           !RTF
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
!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR GGK:DATUMS>B_DAT
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
      DISPLAY()
    END
  END
B_SALAKTS            PROCEDURE                    ! Declare Procedure
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

D_SUMMA              DECIMAL(12,2)
K_SUMMA              DECIMAL(12,2)

CLIENT1              STRING(40)
CLIENT01             STRING(40)
CLIENT02             STRING(40)
CLIENT11             STRING(40)
CLIENT12             STRING(40)
DATUMS               LONG
SAV_PAR_NR           ULONG
CG                   STRING(10)
GOV_REG              STRING(40)
GOV_REG0             STRING(40)
Padrese1             string(50)
Padrese2             string(50)
Jadrese1             string(50)
Jadrese2             string(50)
SYS_adrese1          string(45)
SYS_adrese2          string(45)
GL_adrese1           string(45)
GL_adrese2           string(45)
FAXmail              STRING(40)
PAR_FAXmail          STRING(40)
MENESIS              STRING(10)
D_sum                STRING(20)
K_sum                STRING(20)
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

report REPORT,AT(198,1313,8000,9000),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC), |
         THOUS
       HEADER,AT(198,1000,8000,313)
       END
detail DETAIL,PAGEAFTER(-1),AT(,,,7854),USE(?unnamed)
         STRING(@s40),AT(229,104,3719,219),USE(CLIENT11),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(4010,104,3573,208),USE(CLIENT01),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(240,313,3719,260),USE(CLIENT12),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(4010,313,3573,260),USE(CLIENT02),TRN,CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s40),AT(552,1021,3115,208),USE(gov_reg),CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s50),AT(3979,1510,3802,208),USE(FAXmail),TRN,CENTER,FONT(,10,,,CHARSET:ANSI)
         STRING(@s40),AT(4531,1031,2656,198),USE(GOV_REG0),FONT(,10,,,CHARSET:BALTIC)
         STRING(@s50),AT(198,1188,3792,208),USE(JADRESE1),TRN,CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(4167,1188,3438,208),USE(GL_ADRESE1),TRN,CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s50),AT(198,1354,3792,208),USE(JADRESE2),TRN,CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(4167,1354,3438,208),USE(GL_ADRESE2),TRN,CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s50),AT(219,1510,3750,208),USE(PAR_FAXmail),TRN,CENTER,FONT(,10,,,CHARSET:ANSI)
         STRING(@s50),AT(198,573,3792,208),USE(PADRESE1),CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(4094,573,3438,208),USE(sys_ADRESE1,,?sys_ADRESE1:2),CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s3),AT(5927,3177,1635,208),USE(val_uzsk,,?val_uzsk:2),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s3),AT(2354,3177,1635,208),USE(val_uzsk),TRN,LEFT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@S20),AT(2385,3938,,156),USE(K_sum),TRN,CENTER,FONT(,9,,)
         STRING(@S20),AT(625,3938,,156),USE(D_sum),TRN,CENTER,FONT(,9,,)
         STRING(@s50),AT(198,750,3792,208),USE(PADRESE2),TRN,CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(4094,750,3438,208),USE(sys_ADRESE2),TRN,CENTER,FONT(,10,,,CHARSET:BALTIC)
         STRING('Akts par savstarpçjo norçíinu salîdzinâðanu'),AT(2188,2083),USE(?String5:2),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('uz'),AT(2865,2344),USE(?String5:3),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@n4),AT(3073,2344,458,240),USE(GADS),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('.g.'),AT(3542,2344,188,240),USE(?String5:4),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@n2),AT(3750,2344,271,240),USE(datums),RIGHT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING('.'),AT(4063,2344,104,240),USE(?String5:5),FONT(,12,,FONT:bold,CHARSET:BALTIC)
         STRING(@s10),AT(4167,2344,1021,240),USE(menesis),LEFT,FONT(,12,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,2708,0,1198),USE(?Line2:3),COLOR(COLOR:Black)
         LINE,AT(4010,2708,0,1198),USE(?Line2),COLOR(COLOR:Black)
         LINE,AT(7552,2708,0,1198),USE(?Line2:2),COLOR(COLOR:Black)
         LINE,AT(469,2708,7083,0),USE(?Line1),COLOR(COLOR:Black)
         STRING(@N_12.2B),AT(2604,3698,,156),USE(K_SUMMA),RIGHT,FONT(,9,,)
         LINE,AT(469,3906,7083,0),USE(?Line1:3),COLOR(COLOR:Black)
         STRING('Lûdzam jûs salîdzinât un apstiprinât ðo datu pareizîbu un vienu eksemplâru atsût' &|
             'ît atpakaï nedçïas laikâ no'),AT(563,4365,7031,208),USE(?String22)
         STRING('saòemðanas brîþa. Pretçjâ gadîjumâ uzskatîsim, ka piekrîtat mûsu uzrâdîtajam atl' &|
             'ikumam.'),AT(573,4583,7031,208),USE(?String22:2)
         STRING('Nesaskaòas gadîjumâ lûdzam norâdît pamatojumu - dokumenta numuru un datumu.'),AT(573,4948,7031,208), |
             USE(?String22:6)
         STRING('Ar cieòu'),AT(573,5625),USE(?String22:3)
         STRING(@s45),AT(573,5833,3333,208),USE(CLIENT,,?CLIENT:3),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING(@s45),AT(4583,5833,3333,208),USE(CLIENT1,,?CLIENT1:2),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('grâmatvedis /-e/'),AT(573,6042),USE(?String22:4)
         STRING(@s25),AT(573,6250,1979,208),USE(sys:paraksts2),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('vârds, uzvârds'),AT(5208,6510,781,156),USE(?String22:7)
         STRING('grâmatvedis /-e/'),AT(4583,6042),USE(?String22:8)
         STRING('tâlr.'),AT(573,6771),USE(?String22:5)
         STRING(@s16),AT(833,6771,1250,208),USE(sys:tel),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('tâlr.'),AT(4583,6771),USE(?String22:9)
         LINE,AT(4844,6927,1510,0),USE(?Line17:4),COLOR(COLOR:Black)
         LINE,AT(4583,6458,2396,0),USE(?Line17:3),COLOR(COLOR:Black)
         STRING('V.z.'),AT(781,7604),USE(?String38)
         STRING('V.z.'),AT(4792,7604),USE(?String38:2)
         LINE,AT(4583,7552,2552,0),USE(?Line17:2),COLOR(COLOR:Black)
         LINE,AT(573,7552,2552,0),USE(?Line17),COLOR(COLOR:Black)
         STRING('Saskaòâ ar'),AT(521,2760,3438,208),USE(?String14:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Saskaòâ ar'),AT(4115,2760,3385,208),USE(?String14:4),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(521,2969,3438,208),USE(CLIENT,,?CLIENT:2),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING(@s45),AT(4104,2969,3385,208),USE(CLIENT1),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('datiem'),AT(521,3177,1781,208),USE(?String14),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('datiem'),AT(4115,3177,1781,208),USE(?String14:3),RIGHT,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,3385,7083,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING(@N_12.2B),AT(677,3698,,156),USE(D_SUMMA),RIGHT,FONT(,9,,)
         LINE,AT(2240,3385,0,521),USE(?Line9),COLOR(COLOR:Black)
         LINE,AT(5729,3385,0,521),USE(?Line9:2),COLOR(COLOR:Black)
         STRING('Debets'),AT(521,3438,1667,156),USE(?String14:5),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kredîts'),AT(2344,3438,1615,156),USE(?String14:6),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Debets'),AT(4115,3438,1563,156),USE(?String14:7),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         STRING('Kredîts'),AT(5833,3438,1667,156),USE(?String14:8),CENTER,FONT(,9,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(469,3594,7083,0),USE(?Line1:4),COLOR(COLOR:Black)
       END
       FOOTER,AT(198,9500,8000,500)
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
  LocalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)

  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(SYSTEM,1)
  IF GGK::Used = 0
    CheckOpen(GGK,1)
  END
  GGK::Used += 1
  BIND(GGK:RECORD)
  BIND('par_nr',par_nr)
  BIND('kkk',kkk)
  BIND('kkk1',kkk1)
  BIND('cyclebkk',cyclebkk)
  BIND('CYCLEGGK',CYCLEGGK)
  BIND('CG',CG)

  MENESIS = MENVAR(B_DAT,2,3)
  DATUMS = DAY(B_DAT)
  TEKSTS=CLIENT
  FORMAT_TEKSTS(77,'ARIAL',12,'B')
  IF F_TEKSTS[2]
     CLIENT01 = F_TEKSTS[1]
     CLIENT02 = F_TEKSTS[2]
  ELSE
     CLIENT01 = ''
     CLIENT02 = F_TEKSTS[1]
  .
  GOV_REG0='NMR: '&gl:reg_nr
  IF gl:VID_NR THEN GOV_REG0=CLIP(GOV_REG0)&' PVN: '&gl:VID_NR.
  IF SYS:ADRESE
     TEKSTS=SYS:ADRESE
  ELSE
     TEKSTS=GL:ADRESE
  .
  FORMAT_TEKSTS(70,'ARIAL',10,' ')
  SYS_ADRESE1 = F_TEKSTS[1]
  SYS_ADRESE2 = F_TEKSTS[2]
  IF ~(SYS:ADRESE=GL:ADRESE) AND SYS:ADRESE
     TEKSTS='Jur.adrese: '&GL:ADRESE
     FORMAT_TEKSTS(70,'ARIAL',10,' ')
     GL_ADRESE1 = F_TEKSTS[1]
     GL_ADRESE2 = F_TEKSTS[2]
  .
  IF SYS:FAX THEN FAXMAIL='fakss: '&CLIP(SYS:FAX).
  IF SYS:E_MAIL THEN FAXMAIL=CLIP(FAXMAIL)&' e-pasts: '&SYS:E_MAIL.

  FilesOpened = True
  RecordsToProcess = records(ggk)
  RecordsPerCycle = 25
  RecordsProcessed = 0
  PercentProgress = 0
  OPEN(ProgressWindow)
  Progress:Thermometer = 0
  ?Progress:PctText{Prop:Text} = '0% izpildîti'
  ProgressWindow{Prop:Text} = 'Bûvçjam izziòu'
  ?Progress:UserString{Prop:Text}=''
  SEND(GGK,'QUICKSCAN=on')
  ACCEPT
    CASE EVENT()
    OF Event:OpenWindow
      CLEAR(GGK:RECORD)
      IF ~(PAR_NR=999999999) !NAV VISI
         GGK:PAR_NR=PAR_NR
      ELSE
         GGK:PAR_NR=51       !IZLAIÞAM TOS, KAM NEVAR BÛT
      .
      SET(GGK:PAR_KEY,GGK:PAR_KEY)
      CG='K110000'
      IF KKK AND KKK1
         Process:View{Prop:Filter} = '~(CYCLEBKK(GGK:BKK,KKK) AND CYCLEBKK(GGK:BKK,KKK1)) AND ~CYCLEGGK(CG)'
      ELSIF KKK
         Process:View{Prop:Filter} = '~CYCLEBKK(GGK:BKK,KKK) AND ~CYCLEGGK(CG)'
      ELSIF KKK1
         Process:View{Prop:Filter} = '~CYCLEBKK(GGK:BKK,KKK1) AND ~CYCLEGGK(CG)'
      .
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
            SAV_PAR_NR=GGK:PAR_NR
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
!        STOP(GGK:BKK&' '&GGK:SUMMA)
        LOOP
          IF ~(SAV_PAR_NR=GGK:PAR_NR)
             IF D_SUMMA OR K_SUMMA OR F:DTK !VAI DRUKÂT ARÎ TUKÐUS
                IF D_SUMMA<0
                   K_SUMMA+=ABS(D_SUMMA)
                   D_SUMMA=0
                   If ~val_uzsk='EUR'
                       D_SUM = ''
                       K_SUM = ''&Format(K_SUMMA/0.702804,@N_12.2B)&' '&'EUR'
                   Else
                       D_sum = ''
                       K_sum = ''
                   .
                .
                IF K_SUMMA<0
                   D_SUMMA+=ABS(K_SUMMA)
                   K_SUMMA=0
                   If ~val_uzsk='EUR'
                       K_SUM = ''
                       D_SUM = ''&Format(D_SUMMA/0.702804,@N_12.2B)&' '&'EUR'
                   Else
                       D_sum = ''
                       K_sum = ''
                   .
                 .
                TEKSTS = GETPAR_K(SAV_PAR_NR,2,2)
                FORMAT_TEKSTS(77,'ARIAL',12,'B')
                IF F_TEKSTS[2]
                   CLIENT11 = F_TEKSTS[1]
                   CLIENT12 = F_TEKSTS[2]
                ELSE
                   CLIENT11 = ''
                   CLIENT12 = F_TEKSTS[1]
                .
                GOV_REG=GETPAR_K(SAV_PAR_NR,0,9)
                IF getpar_k(SAV_PAR_NR,2,1)
                   TEKSTS=GETPAR_ADRESE(PAR:U_NR,0,1,0) !Ja nav citu,atgrieþ par:adrese,JA IR IZSAUC BROWSI
                   FORMAT_TEKSTS(80,'ARIAL',10,' ')
                   PADRESE1 = F_TEKSTS[1]
                   PADRESE2 = F_TEKSTS[2]
                   IF ~(TEKSTS=par:adrese)
                      TEKSTS='Jur.adrese: '&PAR:ADRESE
                      FORMAT_TEKSTS(80,'ARIAL',10,' ')
                      JADRESE1 = F_TEKSTS[1]
                      JADRESE2 = F_TEKSTS[2]
                    ELSE
                      JADRESE1=''
                      JADRESE2=''
                   .
                   PAR_FAXMAIL=''
                   IF PAR:FAX THEN PAR_FAXMAIL='fakss: '&CLIP(PAR:FAX).
                   IF PAR:EMAIL THEN PAR_FAXMAIL=CLIP(PAR_FAXMAIL)&' e-pasts: '&PAR:EMAIL.
                .
                PRINT(RPT:DETAIL)
             .
             D_SUMMA=0
             K_SUMMA=0
             SAV_PAR_NR=GGK:PAR_NR
          .
          IF GGK:BKK[1]='2'
             CASE GGK:D_K
             OF 'D'
                D_SUMMA+=GGK:SUMMA
             ELSE
                D_SUMMA-=GGK:SUMMA
             .
          ELSIF GGK:BKK[1]='5'
             CASE GGK:D_K
             OF 'D'
                K_SUMMA-=GGK:SUMMA
             ELSE
                K_SUMMA+=GGK:SUMMA
             .
          .
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
  IF D_SUMMA OR K_SUMMA OR F:DTK !VAI DRUKÂT ARÎ TUKÐUS
     IF D_SUMMA<0
        K_SUMMA+=ABS(D_SUMMA)
        D_SUMMA=0
        If ~val_uzsk='EUR'
            D_SUM = ''
            K_SUM = ''&Format(K_SUMMA/0.702804,@N_12.2B)&' '&'EUR'
        Else
            D_sum = ''
            K_sum = ''
        .
     .
     IF K_SUMMA<0
        D_SUMMA+=ABS(K_SUMMA)
        K_SUMMA=0
        If ~val_uzsk='EUR'
            K_SUM = ''
            D_SUM = ''&Format(D_SUMMA/0.702804,@N_12.2B)&' '&'EUR'
        Else
            D_sum = ''
            K_sum = ''
        .
     .
     CLIENT1= GETPAR_K(SAV_PAR_NR,2,2)
     TEKSTS = CLIENT1
     FORMAT_TEKSTS(80,'ARIAL',12,'B')
     IF F_TEKSTS[2]
        CLIENT11 = F_TEKSTS[1]
        CLIENT12 = F_TEKSTS[2]
     ELSE
        CLIENT11 = ''
        CLIENT12 = F_TEKSTS[1]
     .
     GOV_REG=GETPAR_K(SAV_PAR_NR,0,9)
     IF getpar_k(SAV_PAR_NR,2,1)
        TEKSTS=GETPAR_ADRESE(PAR:U_NR,0,1,0) !Ja nav citu,atgrieþ par:adrese,JA IR IZSAUC BROWSI
        FORMAT_TEKSTS(80,'ARIAL',10,' ')
        PADRESE1 = F_TEKSTS[1]
        PADRESE2 = F_TEKSTS[2]
        IF ~(TEKSTS=par:adrese)
           TEKSTS='Jur.adrese: '&PAR:ADRESE
           FORMAT_TEKSTS(80,'ARIAL',10,' ')
           IF F_TEKSTS[2]
              JADRESE1 = F_TEKSTS[1]
              JADRESE2 = F_TEKSTS[2]
           ELSE
              JADRESE1 = ''
              JADRESE2 = F_TEKSTS[1]
           .
        ELSE
           JADRESE1=''
           JADRESE2=''
        .
     .
     PRINT(RPT:DETAIL)
  .
  IF SEND(GGK,'QUICKSCAN=off').
  IF LocalResponse = RequestCompleted
    ENDPAGE(report)
    CLOSE(ProgressWindow)
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
  END
  CLOSE(report)
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
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

!-----------------------------------------------------------------------------
GetNextRecord ROUTINE
!|
!| This routine is used to retrieve the next record from the VIEW.
!|
!| After the record has been retrieved, the PROGRESS control on the
!| Progress window is updated.
!|
  NEXT(Process:View)
  IF ERRORCODE() OR (GGK:PAR_NR>PAR_NR AND ~(PAR_NR=999999999))
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
      ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% izpildîti'
      DISPLAY()
    END
  END
BrowsePavadApv PROCEDURE(OPC)


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
BINDOPCIJA           BYTE
ES             DECIMAL(1)
Process        STRING(35)
JAAEXP         BYTE
DELTA          DECIMAL(11,2)

nr_table queue,pre(n)
nr       ulong
         .

NOL_NR        BYTE(1)
SAV_JOB_NR    BYTE
LAST_NR       ULONG
PAV_SUMMA     DECIMAL(12,2)
PAV_SUMMA_A   DECIMAL(12,2)
PAV_SUMMA_B   DECIMAL(12,2)
PAV_C_SUMMA   DECIMAL(12,2)
SAV_VAL       STRING(3)

RecordsToProcess     LONG,AUTO
RecordsProcessed     LONG,AUTO
RecordsPerCycle      LONG,AUTO
RecordsThisCycle     LONG,AUTO
PercentProgress      BYTE
RecordStatus         BYTE,AUTO
Progress:Thermometer BYTE
ProgressWindow WINDOW('Progress...'),AT(,,142,59),CENTER,TIMER(1),GRAY,DOUBLE
       PROGRESS,USE(Progress:Thermometer),AT(15,15,111,12),RANGE(0,100)
       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
     END
PrintSkipDetails BOOL,AUTO


NOLNRSCREEN WINDOW(' '),AT(,,122,52),CENTER,GRAY
       STRING('Noliktavas Nr:'),AT(13,10),USE(?String1)
       ENTRY(@N2),AT(68,7),USE(NOL_NR),REQ
       BUTTON('&OK'),AT(39,32,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(79,32,36,14),USE(?CancelButton)
     END

BRW1::View:Browse    VIEW(PAVAD)
                       PROJECT(PAV:KEKSIS)
                       PROJECT(PAV:RS)
                       PROJECT(PAV:DATUMS)
                       PROJECT(PAV:D_K)
                       PROJECT(PAV:DOK_SENR)
                       PROJECT(PAV:NOKA)
                       PROJECT(PAV:SUMMA)
                       PROJECT(PAV:val)
                       PROJECT(PAV:PAR_NR)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::PAV:KEKSIS       LIKE(PAV:KEKSIS)           ! Queue Display field
BRW1::PAV:RS           LIKE(PAV:RS)               ! Queue Display field
BRW1::PAV:DATUMS       LIKE(PAV:DATUMS)           ! Queue Display field
BRW1::PAV:D_K          LIKE(PAV:D_K)              ! Queue Display field
BRW1::PAV:DOK_SENR     LIKE(PAV:DOK_SENR)         ! Queue Display field
BRW1::PAV:NOKA         LIKE(PAV:NOKA)             ! Queue Display field
BRW1::PAV:SUMMA        LIKE(PAV:SUMMA)            ! Queue Display field
BRW1::PAV:val          LIKE(PAV:val)              ! Queue Display field
BRW1::PAR_NR           LIKE(PAR_NR)               ! Queue Display field
BRW1::S_DAT            LIKE(S_DAT)                ! Queue Display field
BRW1::B_DAT            LIKE(B_DAT)                ! Queue Display field
BRW1::d_k              LIKE(d_k)                  ! Queue Display field
BRW1::BINDOPCIJA       LIKE(BINDOPCIJA)           ! Queue Display field
BRW1::PAV:PAR_NR       LIKE(PAV:PAR_NR)           ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:KeyDistribution LIKE(PAV:DATUMS),DIM(100)
BRW1::Sort1:LowValue LIKE(PAV:DATUMS)             ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(PAV:DATUMS)            ! Queue position of scroll thumb
BRW1::Sort1:Reset:PAR_NR LIKE(PAR_NR)
BRW1::CurrentEvent   LONG                         !
BRW1::CurrentChoice  LONG                         !
BRW1::RecordCount    LONG                         !
BRW1::SortOrder      BYTE                         !
BRW1::LocateMode     BYTE                         !
BRW1::RefreshMode    BYTE                         !
BRW1::LastSortOrder  BYTE                         !
BRW1::FillDirection  BYTE                         !
BRW1::AddQueue       BYTE                         !
BRW1::Changed        BYTE                         !
BRW1::RecordStatus   BYTE                         ! Flag for Range/Filter test
BRW1::ItemsToFill    LONG                         ! Controls records retrieved
BRW1::MaxItemsInList LONG                         ! Retrieved after window opened
BRW1::HighlightedPosition STRING(512)             ! POSITION of located record
BRW1::NewSelectPosted BYTE                        ! Queue position of located record
BRW1::PopupText      STRING(128)                  !
ToolBarMode          UNSIGNED,AUTO
BrowseButtons        GROUP                      !info for current browse with focus
ListBox                SIGNED                   !Browse list control
InsertButton           SIGNED                   !Browse insert button
ChangeButton           SIGNED                   !Browse change button
DeleteButton           SIGNED                   !Browse delete button
SelectButton           SIGNED                   !Browse select button
                     END
WinResize            WindowResizeType
QuickWindow          WINDOW('Browse the PAVAD File'),AT(,,336,211),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP('BrowsePavad1'),SYSTEM,GRAY,RESIZE,MODAL
                       LIST,AT(8,20,319,167),USE(?Browse:1),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('12C|M~X~@n1B@15C|M~Y~@N1B@46R(2)|M~Dok.dat.~C(0)@D6@16C|M~D/K~@s1@59R|M~Sçrija-N' &|
   'r~C@s14@63R(2)|M~Partneris~C(0)@s15@60D(12)|M~Summa~C(0)@n-15.2@12D(12)|M~Val~C(' &|
   '0)@s3@'),FROM(Queue:Browse:1)
                       SHEET,AT(3,5,329,203),USE(?CurrentTab)
                         TAB('Atrastas sekojoðas P/Z'),USE(?Tab:2)
                           BUTTON('&Apvienot atzîmçtâs (X=7) P/Z'),AT(65,191,111,14),USE(?Apvienot)
                           BUTTON('&X-Atzîmçt'),AT(9,191,45,14),USE(?Atzimet),HIDE
                         END
                       END
                       BUTTON('&Beigt'),AT(277,190,45,14),USE(?Close)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  CASE OPC
  OF 1
     OPCIJA='01212000000000000000'
  !          12345678901234567890
     IZZFILTN
  OF 2
     IF PAR_NR=0
        KLUDA(87,'Partneris sastâdâmajâ dokumentâ')
        LOCALRESPONSE=REQUESTCANCELLED
        DO ProcedureReturn
     .
     BINDOPCIJA=OPC
     OPEN(NOLNRSCREEN)
     DISPLAY
     ACCEPT
        CASE FIELD()
        OF ?OKBUTTON
          CASE EVENT()
          OF EVENT:Accepted
             CLOSE(PAVAD)
             CLOSE(NOLIK)
             PAVADNAME='PAVAD'&FORMAT(NOL_NR,@N02)
             NOLIKNAME='NOLIK'&FORMAT(NOL_NR,@N02)
             LOCALRESPONSE=REQUESTCOMPLETED
             BREAK
          .
        OF ?CANCELBUTTON
          CASE EVENT()
          OF EVENT:Accepted
             LOCALRESPONSE=REQUESTCANCELLED
             BREAK
          .
        .
     .
     CLOSE(NOLNRSCREEN)
     GLOBALRESPONSE=LOCALRESPONSE
  .
  IF GLOBALRESPONSE=REQUESTCANCELLED
     DO ProcedureReturn
  .
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  CASE OPC
  OF 1
     UNHIDE(?Atzimet)
  OF 2
     ?Apvienot{PROP:TEXT}='&Importçt'
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO BRW1::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Browse:1)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Sized
      WinResize.Resize
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF ToolBarMode=BrowseMode THEN
        DO ListBoxDispatch
      END
    END
    CASE FIELD()
    OF ?Browse:1
      CASE EVENT()
      OF EVENT:NewSelection
        DO BRW1::NewSelection
      OF EVENT:ScrollUp
        DO BRW1::ProcessScroll
      OF EVENT:ScrollDown
        DO BRW1::ProcessScroll
      OF EVENT:PageUp
        DO BRW1::ProcessScroll
      OF EVENT:PageDown
        DO BRW1::ProcessScroll
      OF EVENT:ScrollTop
        DO BRW1::ProcessScroll
      OF EVENT:ScrollBottom
        DO BRW1::ProcessScroll
      OF EVENT:AlertKey
        DO BRW1::AlertKey
      OF EVENT:ScrollDrag
        DO BRW1::ScrollDrag
      END
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?Apvienot
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        CASE OPC
        OF 1   !P/Z APVIENOÐANA
          CLEAR(pav:RECORD)
          pav:DATUMS=S_DAT
          pav:par_nr=par_nr
          PAV:D_K=D_K
          SET(PAV:PAR_KEY,PAV:PAR_KEY)
          LOOP
             NEXT(PAVAD)
             IF ERROR() OR ~(PAV:PAR_NR=PAR_NR) THEN BREAK.
             IF PAV:DATUMS>B_DAT THEN CYCLE .
             IF ~(PAV:D_K=D_K) THEN CYCLE.
             IF ~(PAV:keksis=7) THEN CYCLE.
             IF ~SAV_VAL THEN SAV_VAL=PAV:VAL.
             IF ~(SAV_VAL=PAV:VAL)
                KLUDA(97,' APVIENOT P/Z ...')
                FREE(NR_TABLE)
                RETURN
             .
             N:NR=PAV:U_NR
             LAST_NR=N:NR
             ADD(NR_TABLE)
             SORT(NR_TABLE,N:NR)
             PAV_SUMMA   += PAV:SUMMA
             PAV_SUMMA_A += PAV:SUMMA_A
             PAV_SUMMA_B += PAV:SUMMA_B
             PAV_C_SUMMA += PAV:C_SUMMA
             RecordsToProcess +=1
          .
          IF records(nr_table)<2
             kluda(100,'')
             FREE(NR_TABLE)
             RETURN
          ELSE
             kluda(99,' '&records(nr_table)&' P/Z, ko apvienot')
             IF KLU_DARBIBA =0
                FREE(NR_TABLE)
                RETURN
             .
          .
          OPEN(ProgressWindow)
          Progress:Thermometer = 0
          ?Progress:PctText{Prop:Text} = '0% Izpildîti'
          ProgressWindow{Prop:Text} = 'Apvienojam P/Z'
          ?Progress:UserString{Prop:Text}=''
          CLEAR(NOL:RECORD)
          NOL:par_nr=par_nr
          NOL:DATUMS=S_DAT
          NOL:D_K=D_K
          SET(NOL:PAR_KEY,NOL:PAR_KEY)
          LOOP
             NEXT(NOLIK)
             IF ERROR() OR ~(NOL:PAR_NR=PAR_NR) OR ~INRANGE(NOL:DATUMS,S_DAT,B_DAT) THEN BREAK.
             IF ~(NOL:D_K=D_K) THEN CYCLE.
             GET(NR_TABLE,0)
             N:NR=NOL:U_NR
             GET(NR_TABLE,N:NR)
             IF ERROR()
                CYCLE
             ELSE
                IF N:NR=LAST_NR
                   CYCLE
                ELSE
                   NOL:U_NR=LAST_NR
                   IF RIUPDATE:NOLIK()
                      KLUDA(24,'NOLIK')
                   .
                   I# += 1
                   ?Progress:UserString{Prop:Text}='Pârvietotas '&clip(I#)&' nomenklatûras'
                   DISPLAY
                .
             .
          .
          IF I#=0
             kluda(88,' neviena nomenklatûra, ko apvienot')
             FREE(NR_TABLE)
             CLOSE(ProgressWindow)
             RETURN
          .
          CLEAR(PAV:RECORD)
          LOOP I#=1 TO RECORDS(NR_TABLE)
             GET(NR_TABLE,I#)
             PAV:U_NR=N:NR
             GET(PAVAD,PAV:nr_key)
             IF ERROR()
                STOP('Nevar atrast P/Z UNR='&n:nr)
             ELSE
                IF N:NR=LAST_NR
                   PAV:SUMMA  = PAV_SUMMA
                   PAV:SUMMA_A= PAV_SUMMA_A
                   PAV:SUMMA_B= PAV_SUMMA_B
                   PAV:C_SUMMA= PAV_C_SUMMA
                   PAV:KEKSIS=0
                   IF RIUPDATE:PAVAD()
                      KLUDA(24,'PAVAD')
                   .
                ELSE
                   DELETE(PAVAD)  !NEDRÎKST RIDELETE
                   IF ERROR()
                      KLUDA(26,'PAVAD')
                   .
                .
             .
             RecordsProcessed += 1
             IF PercentProgress < 100
                PercentProgress = (RecordsProcessed / RecordsToProcess)*100
                IF PercentProgress > 100
                   PercentProgress = 100
                END
                IF PercentProgress <> Progress:Thermometer THEN
                   Progress:Thermometer = PercentProgress
                   ?Progress:PctText{Prop:Text} = FORMAT(PercentProgress,@N3) & '% Izpildîti'
                   DISPLAY()
                END
             END
          .
          CLOSE(ProgressWindow)
          FREE(NR_TABLE)
          DO BRW1::InitializeBrowse
          DO BRW1::RefreshPage
          DISPLAY
          LOCALRESPONSE=REQUESTCOMPLETED
        OF 2         !TIEÐAIS IMPORTS NO NOLIKTAVAS
          DO BUILDGG
          DO PROCEDURERETURN
        .
                        
      END
    OF ?Atzimet
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF PAV:KEKSIS
           PAV:KEKSIS=0
        ELSE
           PAV:KEKSIS=7
        .
        IF RIUPDATE:PAVAD()
           KLUDA(24,'PAVAD')
        .
        BRW1::LocateMode = LocateOnEdit
        DO BRW1::LocateRecord
        SELECT(?Browse:1)
      END
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  BIND(PAV:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowsePavadApv','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  BIND('S_DAT',S_DAT)
  BIND('B_DAT',B_DAT)
  BIND('d_k',d_k)
  BIND('BINDOPCIJA',BINDOPCIJA)
  BIND('PAR_NR',PAR_NR)
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
!---------------------------------------------------------------------------
ProcedureReturn ROUTINE
!|
!| This routine provides a common procedure exit point for all template
!| generated procedures.
!|
!| First, all of the files opened by this procedure are closed.
!|
!| Next, if it was opened by this procedure, the window is closed.
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
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
  END
  IF WindowOpened
    INISaveWindow('BrowsePavadApv','winlats.INI')
    CLOSE(QuickWindow)
  END
  IF LocalResponse
    GlobalResponse = LocalResponse
  ELSE
    GlobalResponse = RequestCancelled
  END
  POPBIND
  RETURN
!---------------------------------------------------------------------------
InitializeWindow ROUTINE
!|
!| This routine is used to prepare any control templates for use. It should be called once
!| per procedure.
!|
  DO RefreshWindow
!---------------------------------------------------------------------------
RefreshWindow ROUTINE
!|
!| This routine is used to keep all displays and control templates current.
!|
  IF QuickWindow{Prop:AcceptAll} THEN EXIT.
  DO BRW1::SelectSort
  ?Browse:1{Prop:VScrollPos} = BRW1::CurrentScroll
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
  DO BRW1::GetRecord
!---------------------------------------------------------------------------
BUILDGG ROUTINE   ! BÛVÇJAM GG UN GGK NO P/Z

    JAAEXP=TRUE          ! BÛVÇT
    DELTA=0
    IF PAV:EXP=1         ! RAKSTS JAU IR EXPORTÇTS
       KLUDA(118,FORMAT(PAV:DATUMS,@D6)&' Nr='&CLIP(PAV:DOK_SENR)&' S='&PAV:SUMMA&' '&PAV:VAL)
       IF ~KLU_DARBIBA
          JAAEXP=FALSE   ! IZLAIST ÐO
       .
    .
    IF JAAEXP
       IF PAV:EXP=0
          PAV:EXP=1
          IF RIUPDATE:PAVAD()
             KLUDA(24,'PAVAD')
          .
       .

       CLOSE(SYSTEM)
       SAV_JOB_NR=JOB_NR
       JOB_NR=NOL_NR+15
       CHECKOPEN(SYSTEM,1)   !LAI DABÛTU AUTOKONTÇJUMU ALGORITMUS
       BuildGGKTable(1)
       CLOSE(SYSTEM)
       JOB_NR=SAV_JOB_NR
       CHECKOPEN(SYSTEM,1)   !NOLIEKAM, KUR PAÒÇMÂM

!*********************************************************************************
!**********************  RAKSTAM GG&GGK  *****************************************
!*********************************************************************************

       GG:imp_nr=NOL_NR+15
       GG:RS=PAV:RS
       GG:DOK_SENR=PAV:DOK_SENR
       GG:ATT_DOK='2'
       GG:DATUMS=PAV:DATUMS
       GG:DOKDAT=PAV:DATUMS
       IF PAV:C_DATUMS            !16/11/99
          GG:APMDAT=PAV:C_DATUMS  !10/05/99
       ELSE
          GG:APMDAT=PAV:DATUMS
       .
!       GG:NOKA=PAV:NOKA
!       GG:PAR_NR=PAV:PAR_NR
       CASE PAV:D_K
       OF 'D'
          GG:SATURS='Saòemts - Nol'&CLIP(NOL_NR) &': '& PAV:PAMAT
       OF 'K'
          IF PAV:D_K='R'
             GG:SATURS='Norakstîts-Nol'&CLIP(nol_nr) &': '& PAV:PAMAT
          ELSE
             IF PAV:SUMMA >= 0
                GG:SATURS='Realizçts-Nol'&CLIP(NOL_NR) &': '& PAV:PAMAT
             ELSE
                GG:SATURS='Atgriezts-Nol'&CLIP(NOL_NR) &': '& PAV:PAMAT
             .
          .
       OF 'I'
          GG:SATURS='Inventar.-Nol'&CLIP(NOL_NR) &': '& PAV:PAMAT
       .
       GG:summa =PAV:summa
       GG:VAL   =PAV:VAL
       LOOP J#=1 TO RECORDS(GGK_TABLE)
          GET(GGK_TABLE,J#)
          CLEAR(GGK:RECORD)
          GGK:SUMMA=ROUND(GGT:SUMMA,.01)
          GGK:SUMMAV=ROUND(GGT:SUMMAV,.01)
          GgK:U_NR     = GG:U_NR
          GgK:RS       = GG:RS
          GgK:DATUMS   = GG:DATUMS
          GGK:NODALA   = PAV:NODALA
          GGK:OBJ_NR   = PAV:OBJ_NR
          GgK:PAR_NR   = GG:PAR_NR
          GgK:BKK      = GGT:BKK
          GgK:D_K      = GGT:D_K
          GGK:VAL      = GGT:VAL
          GgK:PVN_PROC = GGT:PVN_PROC
          GgK:PVN_TIPS = GGT:PVN_TIPS  !PVN TIPS
          ADD(GGK)
          IF ERROR() THEN STOP(ERROR()).
          CASE GGK:D_K
          OF 'D'
             DELTA+=GGK:SUMMA
          ELSE
             DELTA-=GGK:SUMMA
          .
       .
       IF DELTA
          CLEAR(GGK:RECORD)
          Ggk:U_NR   = GG:U_NR
          Ggk:RS     = GG:RS
          Ggk:DATUMS = GG:DATUMS
          Ggk:PAR_NR = 0
          Ggk:SUMMA  = ABS(DELTA)
          Ggk:SUMMAV = ABS(DELTA)
          Ggk:BKK    = 'DELTA'
          IF DELTA>0
             Ggk:D_K = 'K'
          ELSE
             GGk:D_K = 'D'
          .
          GGK:VAL    = 'Ls'
          ADD(GgK)
          IF ERROR() THEN STOP(ERROR()).
       .
       FREE(GGK_TABLE)
       LOCALRESPONSE=REQUESTCOMPLETED
    .

!----------------------------------------------------------------------
BRW1::SelectSort ROUTINE
!|
!| This routine is called during the RefreshWindow ROUTINE present in every window procedure.
!| The purpose of this routine is to make certain that the BrowseBox is always current with your
!| user's selections. This routine...
!|
!| 1. Checks to see if any of your specified sort-order conditions are met, and if so, changes the sort order.
!| 2. If no sort order change is necessary, this routine checks to see if any of your Reset Fields has changed.
!| 3. If the sort order has changed, or if a reset field has changed, or if the ForceRefresh flag is set...
!|    a. The current record is retrieved from the disk.
!|    b. If the BrowseBox is accessed for the first time, and the Browse has been called to select a record,
!|       the page containing the current record is loaded.
!|    c. If the BrowseBox is accessed for the first time, and the Browse has not been called to select a
!|       record, the first page of information is loaded.
!|    d. If the BrowseBox is not being accessed for the first time, and the Browse sort order has changed, the
!|       new "first" page of information is loaded.
!|    e. If the BrowseBox is not being accessed for the first time, and the Browse sort order hasn't changes,
!|       the page containing the current record is reloaded.
!|    f. The record buffer is refilled from the currently highlighted BrowseBox item.
!|    f. The BrowseBox is reinitialized (BRW1::InitializeBrowse ROUTINE).
!| 4. If step 3 is not necessary, the record buffer is refilled from the currently highlighted BrowseBox item.
!|
  BRW1::LastSortOrder = BRW1::SortOrder
  BRW1::Changed = False
  IF BRW1::SortOrder = 0
    BRW1::SortOrder = 1
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    OF 1
      IF BRW1::Sort1:Reset:PAR_NR <> PAR_NR
        BRW1::Changed = True
      END
    END
  ELSE
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:PAR_NR = PAR_NR
    END
    DO BRW1::GetRecord
    DO BRW1::Reset
    IF BRW1::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      ELSE
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      END
    ELSE
      IF BRW1::Changed
        FREE(Queue:Browse:1)
        BRW1::RefreshMode = RefreshOnTop
        DO BRW1::RefreshPage
        DO BRW1::PostNewSelection
      ELSE
        BRW1::LocateMode = LocateOnValue
        DO BRW1::LocateRecord
      END
    END
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
    DO BRW1::InitializeBrowse
  ELSE
    IF BRW1::RecordCount
      GET(Queue:Browse:1,BRW1::CurrentChoice)
      DO BRW1::FillBuffer
    END
  END
!----------------------------------------------------------------------
BRW1::InitializeBrowse ROUTINE
!|
!| This routine initializes the BrowseBox control template. This routine is called when...
!|
!| The BrowseBox sort order has changed. This includes the first time the BrowseBox is accessed.
!| The BrowseBox returns from a record update.
!|
!| This routine performs two main functions.
!|   1. Computes all BrowseBox totals. All records that satisfy the current selection criteria
!|      are read, and totals computed. If no totals are present, this section is not generated,
!|      and may not be present in the code below.
!|   2. Calculates any runtime scrollbar positions. Again, if runtime scrollbars are not used,
!|      the code for runtime scrollbar computation will not be present.
!|
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = PAV:DATUMS
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = PAV:DATUMS
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  PAV:KEKSIS = BRW1::PAV:KEKSIS
  PAV:RS = BRW1::PAV:RS
  PAV:DATUMS = BRW1::PAV:DATUMS
  PAV:D_K = BRW1::PAV:D_K
  PAV:DOK_SENR = BRW1::PAV:DOK_SENR
  PAV:NOKA = BRW1::PAV:NOKA
  PAV:SUMMA = BRW1::PAV:SUMMA
  PAV:val = BRW1::PAV:val
  PAR_NR = BRW1::PAR_NR
  S_DAT = BRW1::S_DAT
  B_DAT = BRW1::B_DAT
  d_k = BRW1::d_k
  BINDOPCIJA = BRW1::BINDOPCIJA
  PAV:PAR_NR = BRW1::PAV:PAR_NR
!----------------------------------------------------------------------
BRW1::FillQueue ROUTINE
!|
!| This routine is used to fill the BrowseBox QUEUE from several sources.
!|
!| First, all Format Browse formulae are processed.
!|
!| Next, each field of the BrowseBox is processed. For each field...
!|
!|    The value of the field is placed in the BrowseBox queue.
!|
!| Finally, the POSITION of the current VIEW record is added to the QUEUE
!|
  BRW1::PAV:KEKSIS = PAV:KEKSIS
  BRW1::PAV:RS = PAV:RS
  BRW1::PAV:DATUMS = PAV:DATUMS
  BRW1::PAV:D_K = PAV:D_K
  BRW1::PAV:DOK_SENR = PAV:DOK_SENR
  BRW1::PAV:NOKA = PAV:NOKA
  BRW1::PAV:SUMMA = PAV:SUMMA
  BRW1::PAV:val = PAV:val
  BRW1::PAR_NR = PAR_NR
  BRW1::S_DAT = S_DAT
  BRW1::B_DAT = B_DAT
  BRW1::d_k = d_k
  BRW1::BINDOPCIJA = BINDOPCIJA
  BRW1::PAV:PAR_NR = PAV:PAR_NR
  BRW1::Position = POSITION(BRW1::View:Browse)
!----------------------------------------------------------------------
BRW1::PostNewSelection ROUTINE
!|
!| This routine is used to post the NewSelection EVENT to the window. Because we only want this
!| EVENT processed once, and becuase there are several routines that need to initiate a NewSelection
!| EVENT, we keep a flag that tells us if the EVENT is already waiting to be processed. The EVENT is
!| only POSTed if this flag is false.
!|
  IF NOT BRW1::NewSelectPosted
    BRW1::NewSelectPosted = True
    POST(Event:NewSelection,?Browse:1)
  END
!----------------------------------------------------------------------
BRW1::NewSelection ROUTINE
!|
!| This routine performs any window bookkeeping necessary when a new record is selected in the
!| BrowseBox.
!| 1. If the new selection is made with the right mouse button, the popup menu (if applicable) is
!|    processed.
!| 2. The current record is retrieved into the buffer using the BRW1::FillBuffer ROUTINE.
!|    After this, the current vertical scrollbar position is computed, and the scrollbar positioned.
!|
  BRW1::NewSelectPosted = False
  IF KEYCODE() = MouseRight
    BRW1::PopupText = ''
    IF BRW1::RecordCount
    ELSE
    END
    EXECUTE(POPUP(BRW1::PopupText))
    END
  ELSIF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    DO BRW1::FillBuffer
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF ?Browse:1{Prop:VScroll} = False
        ?Browse:1{Prop:VScroll} = True
      END
      CASE BRW1::SortOrder
      OF 1
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => PAV:DATUMS
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      END
    ELSE
      IF ?Browse:1{Prop:VScroll} = True
        ?Browse:1{Prop:VScroll} = False
      END
    END
    DO RefreshWindow
  END
!---------------------------------------------------------------------
BRW1::ProcessScroll ROUTINE
!|
!| This routine processes any of the six scrolling EVENTs handled by the BrowseBox.
!| If one record is to be scrolled, the ROUTINE BRW1::ScrollOne is called.
!| If a page of records is to be scrolled, the ROUTINE BRW1::ScrollPage is called.
!| If the first or last page is to be displayed, the ROUTINE BRW1::ScrollEnd is called.
!|
!| If an incremental locator is in use, the value of that locator is cleared.
!| Finally, if a Fixed Thumb vertical scroll bar is used, the thumb is positioned.
!|
  IF BRW1::RecordCount
    BRW1::CurrentEvent = EVENT()
    CASE BRW1::CurrentEvent
    OF Event:ScrollUp OROF Event:ScrollDown
      DO BRW1::ScrollOne
    OF Event:PageUp OROF Event:PageDown
      DO BRW1::ScrollPage
    OF Event:ScrollTop OROF Event:ScrollBottom
      DO BRW1::ScrollEnd
    END
    ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
    DO BRW1::PostNewSelection
  END
!----------------------------------------------------------------------
BRW1::ScrollOne ROUTINE
!|
!| This routine is used to scroll a single record on the BrowseBox. Since the BrowseBox is an IMM
!| listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Sees if scrolling in the intended direction will cause the listbox display to shift. If not,
!|    the routine moves the list box cursor and exits.
!| 2. Calls BRW1::FillRecord to retrieve one record in the direction required.
!|
  IF BRW1::CurrentEvent = Event:ScrollUp AND BRW1::CurrentChoice > 1
    BRW1::CurrentChoice -= 1
    EXIT
  ELSIF BRW1::CurrentEvent = Event:ScrollDown AND BRW1::CurrentChoice < BRW1::RecordCount
    BRW1::CurrentChoice += 1
    EXIT
  END
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = BRW1::CurrentEvent - 2
  DO BRW1::FillRecord
!----------------------------------------------------------------------
BRW1::ScrollPage ROUTINE
!|
!| This routine is used to scroll a single page of records on the BrowseBox. Since the BrowseBox is
!| an IMM listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Calls BRW1::FillRecord to retrieve one page of records in the direction required.
!| 2. If BRW1::FillRecord doesn't fill a page (BRW1::ItemsToFill > 0), then
!|    the list-box cursor ia shifted.
!|
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  BRW1::FillDirection = BRW1::CurrentEvent - 4
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::ItemsToFill
    IF BRW1::CurrentEvent = Event:PageUp
      BRW1::CurrentChoice -= BRW1::ItemsToFill
      IF BRW1::CurrentChoice < 1
        BRW1::CurrentChoice = 1
      END
    ELSE
      BRW1::CurrentChoice += BRW1::ItemsToFill
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    END
  END
!----------------------------------------------------------------------
BRW1::ScrollEnd ROUTINE
!|
!| This routine is used to load the first or last page of the displayable set of records.
!| Since the BrowseBox is an IMM listbox, all scrolling must be handled in code. When called,
!| this routine...
!|
!| 1. Resets the BrowseBox VIEW to insure that it reads from the end of the current sort order.
!| 2. Calls BRW1::FillRecord to retrieve one page of records.
!| 3. Selects the record that represents the end of the view. That is, if the first page was loaded,
!|    the first record is highlighted. If the last was loaded, the last record is highlighted.
!|
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  DO BRW1::Reset
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::FillDirection = FillForward
  ELSE
    BRW1::FillDirection = FillBackward
  END
  DO BRW1::FillRecord                           ! Fill with next read(s)
  IF BRW1::CurrentEvent = Event:ScrollTop
    BRW1::CurrentChoice = 1
  ELSE
    BRW1::CurrentChoice = BRW1::RecordCount
  END
!----------------------------------------------------------------------
BRW1::AlertKey ROUTINE
!|
!| This routine processes any KEYCODEs experienced by the BrowseBox.
!| NOTE: The cursor movement keys are not processed as KEYCODEs. They are processed as the
!|       appropriate BrowseBox scrolling and selection EVENTs.
!| This routine includes handling for double-click. Actually, this handling is in the form of
!| EMBEDs, which are filled by child-control templates.
!| This routine also includes the BrowseBox's locator handling.
!| After a value is entered for locating, this routine sets BRW1::LocateMode to a value
!| of 2 -- EQUATEd to LocateOnValue -- and calls the routine BRW1::LocateRecord.
!|
  IF BRW1::RecordCount
    CASE KEYCODE()                                ! What keycode was hit
    OF MouseLeft2
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    END
  END
  DO BRW1::PostNewSelection
!----------------------------------------------------------------------
BRW1::ScrollDrag ROUTINE
!|
!| This routine processes the Vertical Scroll Bar arrays to find the free key field value
!| that corresponds to the current scroll bar position.
!|
!| After the scroll position is computed, and the scroll value found, this routine sets
!| BRW1::LocateMode to that scroll value of 2 -- EQUATEd to LocateOnValue --
!| and calls the routine BRW1::LocateRecord.
!|
  IF ?Browse:1{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?Browse:1)
  ELSIF ?Browse:1{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?Browse:1)
  ELSE
    CASE BRW1::SortOrder
    OF 1
      PAV:DATUMS = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    END
  END
!----------------------------------------------------------------------
BRW1::FillRecord ROUTINE
!|
!| This routine is used to retrieve a number of records from the VIEW. The number of records
!| retrieved is held in the variable BRW1::ItemsToFill. If more than one record is
!| to be retrieved, QuickScan is used to minimize reads from the disk.
!|
!| If records exist in the queue (in other words, if the browse has been used before), the record
!| at the appropriate end of the list box is retrieved, and the VIEW is reset to read starting
!| at that record.
!|
!| Next, the VIEW is accessed to retrieve BRW1::ItemsToFill records. Normally, this will
!| result in BRW1::ItemsToFill records being read from the VIEW, but if custom filtering
!| or range limiting is used (via the BRW1::ValidateRecord routine) then any number of records
!| might be read.
!|
!| For each good record, if BRW1::AddQueue is true, the queue is filled using the BRW1::FillQueue
!| routine. The record is then added to the queue. If adding this record causes the BrowseBox queue
!| to contain more records than can be displayed, the record at the opposite end of the queue is
!| deleted.
!|
!| The only time BRW1::AddQueue is false is when the BRW1::LocateRecord routine needs to
!| get the closest record to its record to be located. At this time, the record doesn't need to be
!| added to the queue, so it isn't.
!|
  IF BRW1::RecordCount
    IF BRW1::FillDirection = FillForward
      GET(Queue:Browse:1,BRW1::RecordCount)       ! Get the first queue item
    ELSE
      GET(Queue:Browse:1,1)                       ! Get the first queue item
    END
    RESET(BRW1::View:Browse,BRW1::Position)       ! Reset for sequential processing
    BRW1::SkipFirst = TRUE
  ELSE
    BRW1::SkipFirst = FALSE
  END
  LOOP WHILE BRW1::ItemsToFill
    IF BRW1::FillDirection = FillForward
      NEXT(BRW1::View:Browse)
    ELSE
      PREVIOUS(BRW1::View:Browse)
    END
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'PAVAD')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    IF BRW1::SkipFirst
       BRW1::SkipFirst = FALSE
       IF POSITION(BRW1::View:Browse)=BRW1::Position
          CYCLE
       END
    END
    IF BRW1::AddQueue
      IF BRW1::RecordCount = ?Browse:1{Prop:Items}
        IF BRW1::FillDirection = FillForward
          GET(Queue:Browse:1,1)                   ! Get the first queue item
        ELSE
          GET(Queue:Browse:1,BRW1::RecordCount)   ! Get the first queue item
        END
        DELETE(Queue:Browse:1)
        BRW1::RecordCount -= 1
      END
      DO BRW1::FillQueue
      IF BRW1::FillDirection = FillForward
        ADD(Queue:Browse:1)
      ELSE
        ADD(Queue:Browse:1,1)
      END
      BRW1::RecordCount += 1
    END
    BRW1::ItemsToFill -= 1
  END
  BRW1::AddQueue = True
  EXIT
!----------------------------------------------------------------------
BRW1::LocateRecord ROUTINE
!|
!| This routine is used to find a record in the VIEW, and to display that record
!| in the BrowseBox.
!|
!| This routine has three different modes of operation, which are invoked based on
!| the setting of BRW1::LocateMode. These modes are...
!|
!|   LocateOnPosition (1) - This mode is still supported for 1.5 compatability. This mode
!|                          is the same as LocateOnEdit.
!|   LocateOnValue    (2) - The values of the current sort order key are used. This mode
!|                          used for Locators and when the BrowseBox is called to select
!|                          a record.
!|   LocateOnEdit     (3) - The current record of the VIEW is used. This mode assumes
!|                          that there is an active VIEW record. This mode is used when
!|                          the sort order of the BrowseBox has changed
!|
!| If an appropriate record has been located, the BRW1::RefreshPage routine is
!| called to load the page containing the located record.
!|
!| If an appropriate record is not locate, the last page of the BrowseBox is loaded.
!|
  IF BRW1::LocateMode = LocateOnPosition
    BRW1::LocateMode = LocateOnEdit
  END
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(PAV:PAR_KEY)
      RESET(PAV:PAR_KEY,BRW1::HighlightedPosition)
    ELSE
      PAV:PAR_NR = PAR_NR
      SET(PAV:PAR_KEY,PAV:PAR_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'PAV:PAR_NR = PAR_NR AND ((INRANGE(PAV:DATUMS,S_DAT,B_DAT) AND PAV:D_K=' & |
    'D_K) or BINDOPCIJA=2)'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = 1
  BRW1::FillDirection = FillForward               ! Fill with next read(s)
  BRW1::AddQueue = False
  DO BRW1::FillRecord                             ! Fill with next read(s)
  BRW1::AddQueue = True
  IF BRW1::ItemsToFill
    BRW1::RefreshMode = RefreshOnBottom
    DO BRW1::RefreshPage
  ELSE
    BRW1::RefreshMode = RefreshOnPosition
    DO BRW1::RefreshPage
  END
  DO BRW1::PostNewSelection
  BRW1::LocateMode = 0
  EXIT
!----------------------------------------------------------------------
BRW1::RefreshPage ROUTINE
!|
!| This routine is used to load a single page of the BrowseBox.
!|
!| If this routine is called with a BRW1::RefreshMode of RefreshOnPosition,
!| the active VIEW record is loaded at the top of the page. Otherwise, if there are
!| records in the browse queue (Queue:Browse:1), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW1::RefreshMode = RefreshOnPosition
    BRW1::HighlightedPosition = POSITION(BRW1::View:Browse)
    RESET(BRW1::View:Browse,BRW1::HighlightedPosition)
    BRW1::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse:1,RECORDS(Queue:Browse:1))
    END
    BRW1::HighlightedPosition = BRW1::Position
    GET(Queue:Browse:1,1)
    RESET(BRW1::View:Browse,BRW1::Position)
    BRW1::RefreshMode = RefreshOnCurrent
  ELSE
    BRW1::HighlightedPosition = ''
    DO BRW1::Reset
  END
  FREE(Queue:Browse:1)
  BRW1::RecordCount = 0
  BRW1::ItemsToFill = ?Browse:1{Prop:Items}
  IF BRW1::RefreshMode = RefreshOnBottom
    BRW1::FillDirection = FillBackward
  ELSE
    BRW1::FillDirection = FillForward
  END
  DO BRW1::FillRecord                             ! Fill with next read(s)
  IF BRW1::HighlightedPosition
    IF BRW1::ItemsToFill
      IF NOT BRW1::RecordCount
        DO BRW1::Reset
      END
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::FillDirection = FillForward
      ELSE
        BRW1::FillDirection = FillBackward
      END
      DO BRW1::FillRecord
    END
  END
  IF BRW1::RecordCount
    IF BRW1::HighlightedPosition
      LOOP BRW1::CurrentChoice = 1 TO BRW1::RecordCount
        GET(Queue:Browse:1,BRW1::CurrentChoice)
        IF BRW1::Position = BRW1::HighlightedPosition THEN BREAK.
      END
      IF BRW1::CurrentChoice > BRW1::RecordCount
        BRW1::CurrentChoice = BRW1::RecordCount
      END
    ELSE
      IF BRW1::RefreshMode = RefreshOnBottom
        BRW1::CurrentChoice = RECORDS(Queue:Browse:1)
      ELSE
        BRW1::CurrentChoice = 1
      END
    END
    ?Browse:1{Prop:Selected} = BRW1::CurrentChoice
    DO BRW1::FillBuffer
  ELSE
    CLEAR(PAV:Record)
    BRW1::CurrentChoice = 0
  END
  SETCURSOR()
  BRW1::RefreshMode = 0
  EXIT
BRW1::Reset ROUTINE
!|
!| This routine is used to reset the VIEW used by the BrowseBox.
!|
  CLOSE(BRW1::View:Browse)
  CASE BRW1::SortOrder
  OF 1
    PAV:PAR_NR = PAR_NR
    SET(PAV:PAR_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'PAV:PAR_NR = PAR_NR AND ((INRANGE(PAV:DATUMS,S_DAT,B_DAT) AND PAV:D_K=' & |
    'D_K) or BINDOPCIJA=2)'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW1::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW1::GetRecord ROUTINE
!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
  IF BRW1::RecordCount
    BRW1::CurrentChoice = CHOICE(?Browse:1)
    GET(Queue:Browse:1,BRW1::CurrentChoice)
    WATCH(BRW1::View:Browse)
    REGET(BRW1::View:Browse,BRW1::Position)
  END
!----------------------------------------------------------------------
BRW1::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
  CASE BRW1::SortOrder
  OF 1
    PAR_NR = BRW1::Sort1:Reset:PAR_NR
  END
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
  DISABLE(TBarBrwHistory)
  ToolBarMode=BrowseMode
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwBottom{PROP:ToolTip}='Go to the Last Page'
  TBarBrwTop{PROP:ToolTip}='Go to the First Page'
  TBarBrwPageDown{PROP:ToolTip}='Go to the Next Page'
  TBarBrwPageUp{PROP:ToolTip}='Go to the Prior Page'
  TBarBrwDown{PROP:ToolTip}='Go to the Next Record'
  TBarBrwUP{PROP:ToolTip}='Go to the Prior Record'
  TBarBrwInsert{PROP:ToolTip}='Insert a new Record'
  DISPLAY(TBarBrwFirst,TBarBrwLast)
!--------------------------------------------------------------------------
ListBoxDispatch ROUTINE
  DO DisplayBrowseToolbar
  IF ACCEPTED() THEN            !trap remote browse box control calls
    EXECUTE(ACCEPTED()-TBarBrwBottom+1)
      POST(EVENT:ScrollBottom,BrowseButtons.ListBox)
      POST(EVENT:ScrollTop,BrowseButtons.ListBox)
      POST(EVENT:PageDown,BrowseButtons.ListBox)
      POST(EVENT:PageUp,BrowseButtons.ListBox)
      POST(EVENT:ScrollDown,BrowseButtons.ListBox)
      POST(EVENT:ScrollUp,BrowseButtons.ListBox)
      POST(EVENT:Locate,BrowseButtons.ListBox)
      BEGIN                     !EXECUTE Place Holder - Ditto has no effect on a browse
      END
      PRESSKEY(F1Key)
    END
  END

