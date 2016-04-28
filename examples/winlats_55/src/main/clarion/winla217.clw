                     MEMBER('winlats.clw')        ! This is a MEMBER module
GetAuto              FUNCTION (Ved_NR,RET)        ! Declare Procedure
AUT_PERSKODS   STRING(12)
PARVADATAJS    STRING(100)
  CODE                                            ! Begin processed code
  IF ~INRANGE(RET,1,11)
     KLUDA(0,'KÏÛDA IZSAUCOT F-ju GETAUTO:'&RET)
     RETURN('')
  .
  IF VED_NR=0
     return('')
  ELSE
     IF AUTO::USED=0
        CHECKOPEN(AUTO,1)
     .
     AUTO::USED+=1
     CLEAR(AUT:RECORD)
     AUT:U_NR=VED_NR
     GET(AUTO,AUT:NR_KEY)
     IF ERROR()
        RET=0
     .
  .
  IF AUT:PERSKODS>'000000-00000'
     AUT_PERSKODS=format(AUT:PERSKODS,@P######-#####P)
  ELSE
     AUT_PERSKODS=''
  .
  AUTO::USED-=1
  IF AUTO::USED=0
     CLOSE(AUTO)
  .
  EXECUTE RET+1
     return('')
     return(AUT:Vaditajs)                                                  !1
     return(CLIP(AUT:Vaditajs)&' '&CLIP(AUT:V_NR)&' '&AUT:V_NR2)           !2
     return(CLIP(AUT:Vaditajs)&' '&AUT_PERSKODS)                           !3
     BEGIN                                                                 !4-VISS,KAS VAJADZÎGS PPR 'PARVADATAJS...'
       IF AUT:PAR_NR  !ÎPAÐNIEKS
         PARVADATAJS=CLIP(GETPAR_K(AUT:PAR_NR,0,2))&' '&CLIP(GETPAR_K(AUT:PAR_NR,0,8))
         return(CLIP(PARVADATAJS)&','&CLIP(AUT:MARKA)&' '&CLIP(AUT:V_NR)&' '&CLIP(AUT:V_NR2)&','&CLIP(AUT:Vaditajs)&' '&CLIP(AUT_PERSKODS)) !4
       ELSE
         return(CLIP(AUT:MARKA)&' '&CLIP(AUT:V_NR)&' '&CLIP(AUT:V_NR2)&','&CLIP(AUT:Vaditajs)&' '&CLIP(AUT_PERSKODS)) !4
       .
     .
     return(CLIP(AUT:V_NR)&' '&CLIP(AUT:V_NR2)&' '&AUT:MARKA)              !5
     BEGIN
        IF AUT:MMYYYY
           return(CLIP( AUT:MARKA)&','&YEAR(AUT:MMYYYY)&' g.')                     !6
        ELSE
           return(CLIP( AUT:MARKA))
        .
     .
     return(CLIP(AUT:Vaditajs)&' '&CLIP(AUT:V_NR)&' '&AUT:V_NR2&' '&AUT:Virsb_NR) !7
     return(aut:marka)                                                     !8
     return(AUT:V_NR)                                                      !9
     return(CLIP(AUT:V_NR)&' '&CLIP(AUT:MARKA)&' '&AUT:KRASA)              !10
     return(AUT:Virsb_NR)                                                  !11
  .

!     return(CLIP(AUT:Vaditajs)&' '&CLIP(AUT_PERSKODS)&' '&CLIP(AUT:V_NR)&' '&AUT:V_NR2) !4
N_MAKRIK             PROCEDURE                    ! Declare Procedure
TYPEFACE     string(20)
rpt_menesis  string(11)
RPT_GADS     decimal(4)
RPT_DATUMS   decimal(2)
rpt_REG_ADRESE string(34)
rpt_BAN_NR   string(18)
rpt_BAN_KR   string(11)
rpt_SUMVAR1  string(100)
rpt_SUMVAR2  string(100)
GG_SATURS1   string(100)
GG_SATURS2   string(100)
PVN_TEX      STRING(4)
tex          string(100)
!rpt_index   string(7)
!BIND         GROUP,OVER(BINDEX)
!BINDEX1      STRING(3)
!BINDEX2      STRING(4)
!             .
!SANBI        GROUP,OVER(BAN:INDEX)
!SANBIND1     STRING(3)
!SANBIND2     STRING(4)
!             .
report REPORT,AT(198,198,8104,9500),PAPER(PAPER:A4),PRE(RPT),FONT('Arial Baltic',8,,,CHARSET:BALTIC),THOUS
detail0 DETAIL,AT(10,,8000,302)
         STRING(@s100),AT(104,52,7344,208),USE(tex),FONT(,12,,,CHARSET:BALTIC)
       END
detail DETAIL,AT(10,10,8000,6000)
         LINE,AT(4167,104,1042,0),USE(?Line1:2),COLOR(COLOR:Black)
         STRING('Maksâjuma uzdevums Nr'),AT(1927,208,2125,240),USE(?String22),CENTER,FONT(,12,,FONT:bold,CHARSET:BALTIC+FONT:underline)
         LINE,AT(4167,104,0,417),USE(?Line3),COLOR(COLOR:Black)
         LINE,AT(5208,104,0,417),USE(?Line3:2),COLOR(COLOR:Black)
         LINE,AT(4167,521,1042,0),USE(?Line1),COLOR(COLOR:Black)
         STRING(@n4),AT(2729,615,448,208),USE(rpt_gads),CENTER,FONT(,12,,,CHARSET:BALTIC)
         STRING('. gada'),AT(3219,625,375,208),USE(?String28),LEFT
         STRING(@n2),AT(3635,615,260,208),USE(rpt_datums),FONT(,12,,,CHARSET:BALTIC)
         STRING('.'),AT(3896,615,104,208),USE(?String40),LEFT
         STRING(@s11),AT(3958,625),USE(rpt_menesis),LEFT
         STRING('Maksâtâjs'),AT(313,2031),USE(?String29),CENTER,FONT(,9,,,CHARSET:BALTIC)
         STRING('DEBETS'),AT(4844,1010),USE(?String30),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING('SUMMA'),AT(6198,1010),USE(?String31),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,1146,0,469),USE(?Line5),COLOR(COLOR:Black)
         STRING(@s45),AT(1042,1146,3333,208),USE(CLIENT),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s11),AT(1042,1354,833,208),USE(GL:REG_NR),LEFT
         STRING(@s5),AT(1885,1354),USE(pvn_tex),RIGHT(1)
         STRING(@s13),AT(2354,1354),USE(gl:vid_nr),LEFT(1)
         LINE,AT(4427,1302,2708,0),USE(?Line7),COLOR(COLOR:Black)
         LINE,AT(260,1615,4167,0),USE(?Line6),COLOR(COLOR:Black)
         STRING(@s31),AT(313,1719,2396,208),USE(BANKA),LEFT
         LINE,AT(3385,1615,0,365),USE(?Line5:3),COLOR(COLOR:Black)
         STRING(@s11),AT(3438,1719,938,208),USE(BKODS),LEFT
         LINE,AT(4427,1302,0,677),USE(?Line5:2),COLOR(COLOR:Black)
         STRING(@s12),AT(4531,1719,938,208),USE(REK),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(5917,1302,0,3177),USE(?Line5:4),COLOR(COLOR:Black)
         STRING(@N_11.2),AT(6042,1771),USE(pav:summa),FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(7135,1302,0,3177),USE(?Line5:5),COLOR(COLOR:Black)
         LINE,AT(260,1979,5677,0),USE(?Line6:2),COLOR(COLOR:Black)
         STRING('Saòçmçjs'),AT(313,938,583,198),USE(?String17),FONT(,9,,,CHARSET:BALTIC)
         STRING('KREDÎTS'),AT(4688,2083,833,208),USE(?String18),CENTER,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(938,2292,0,469),USE(?Line5:6),COLOR(COLOR:Black)
         STRING(@s35),AT(1042,2344,3010,208),USE(PAR:NOS_P),LEFT,FONT(,10,,FONT:bold,CHARSET:BALTIC)
         STRING(@s35),AT(1042,2552,2917,208),USE(RPT_REG_ADRESE),LEFT,FONT(,10,,,CHARSET:BALTIC)
         LINE,AT(4427,2500,2708,0),USE(?Line17),COLOR(COLOR:Black)
         LINE,AT(4427,2500,0,677),USE(?Line5:8),COLOR(COLOR:Black)
         STRING(@s11),AT(4531,2656,885,208),USE(RPT_BAN_KR),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,2760,4167,0),USE(?Line6:3),COLOR(COLOR:Black)
         STRING(@s31),AT(260,2865,2448,208),USE(BAN:NOS_P),LEFT
         LINE,AT(3385,2760,0,417),USE(?Line5:7),COLOR(COLOR:Black)
         STRING(@s11),AT(3438,2865,938,208),USE(BAN:KODS),LEFT
         STRING(@s18),AT(4531,2875,1375,208),USE(RPT_BAN_NR),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,3177,6875,0),USE(?Line6:4),COLOR(COLOR:Black)
         STRING(@S100),AT(260,3281,5573,208),USE(RPT_SUMVAR1),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         STRING(@s100),AT(260,3490,5573,208),USE(RPT_SUMVAR2),LEFT,FONT(,,,FONT:bold,CHARSET:BALTIC)
         LINE,AT(260,3802,5677,0),USE(?Line6:5),COLOR(COLOR:Black),LINEWIDTH(2)
         STRING('sods       d.   %'),AT(5990,3333,938,208),USE(?String23)
         STRING('summa'),AT(6000,3521),USE(?String24)
         STRING('op.veids    1'),AT(6000,3729),USE(?String25)
         STRING('mak. rinda'),AT(6000,3938),USE(?String26)
         STRING('bankas Nr'),AT(6000,4146),USE(?String27)
         STRING(@s100),AT(260,3906,5573,208),USE(pav:pamat),LEFT,FONT(,10,,FONT:regular)
         LINE,AT(5906,4479,1250,0),USE(?Line20),COLOR(COLOR:Black)
         STRING('Parbaudîts bankâ'),AT(5906,4521),USE(?String37),FONT(,10,,,CHARSET:BALTIC)
         STRING('V. z.'),AT(1042,4479),USE(?String34),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('Klienta paraksti:'),AT(1031,4740),USE(?String35),LEFT,FONT(,10,,,CHARSET:BALTIC)
         STRING('Bankas paraksti:'),AT(4167,4740),USE(?String36),RIGHT,FONT(,10,,,CHARSET:BALTIC)
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
  IF PAV:D_K='K' !AND SUB(GGK:BKK,1,3)='262'
!     IF ~GG:DOK_NR
!        GG:DOK_NR=PERFORMGL(1)   !PIEÐÍIRAM MU NR
!     .
  ELSE
     KLUDA(104,' 262.. Kredîtam')
     DO ProcedureReturn
  .
  CHECKOPEN(GLOBAL,1)
  CHECKOPEN(system,1)
  OPEN(ProgressWindow)
  open(report)
  report{Prop:Preview} = PrintPreviewImage
!
  report{Prop:FONT} = TYPEFACE
!
  rpt_menesis = MENVAR(PAV:DATUMS,2,2)
  RPT_GADS=YEAR(PAV:DATUMS)
  RPT_DATUMS=DAY(PAV:DATUMS)
  IF GL:VID_NR
     PVN_TEX='PVN:'
  ELSE
     PVN_TEX=''
  .
  GETMYBANK('26200')              ! MANA BANKA
  C#=GETPAR_K(PAV:PAR_NR,2,1)     ! POZICIONÇ PAR_K
  CASE SYS:nokl_PB
  OF 1
     BAN:KODS=PAR:BAN_KODS
     RPT_BAN_NR=PAR:BAN_NR
     RPT_BAN_KR=PAR:BAN_KR
  OF 2
     BAN:KODS=PAR:BAN_KODS2
     RPT_BAN_NR=PAR:BAN_NR2
     RPT_BAN_KR=PAR:BAN_KR2
  ELSE
     kluda(69,'')
  .
  C#=Getbankas_k(BAN:KODS,2,1)      ! SAÒÇMÇJA BANKA
  IF LEN(CLIP(PAR:ADRESE))>23
     LOOP I#=24 TO 1 BY -1
        IF PAR:ADRESE[I#]=' ' OR PAR:ADRESE[I#]=','
           IF I#>1
              IF PAR:ADRESE[I#-1]=' ' OR PAR:ADRESE[I#-1]=','
                 I#-=1
              .
           .
           BREAK
        .
     .
  ELSE
     I#=24
  .
!  RPT_REG_ADRESE=GOVREG(PAR:U_NR,1)&' '&SUB(PAR:ADRESE,1,I#-1)
  RPT_REG_ADRESE=GETPAR_K(PAV:PAR_NR,0,9)
  TEKSTS= SUMVAR(PAV:SUMMA,PAV:VAL,0)
  FORMAT_TEKSTS(75,'Arial',10,'B')
  RPT_SUMVAR1 = F_TEKSTS[1]
  RPT_SUMVAR2 = F_TEKSTS[2]
!  TEKSTS=clip(GG:SATURS)&' '&clip(GG:SATURS2)&' '&clip(GG:SATURS3)
!  FORMAT_TEKSTS(75,'Arial',10,'')
!  GG_SATURS1=F_TEKSTS[1]
!  GG_SATURS2=F_TEKSTS[2]
  print(RPT:detail)
  ENDPAGE(report)
  pr:skaits=1
  CLOSE(ProgressWindow)
  RP
  IF Globalresponse = RequestCompleted
     loop j#=1 to PR:SKAITS
        report{Prop:FlushPreview} = True
        IF ~(j#=PR:SKAITS)
           loop i#= 1 to RECORDS(PrintPreviewQueue1)
              get(PrintPreviewQueue1,i#)
              PrintPreviewImage=PrintPreviewImage1
              add(PrintPreviewQueue)
           .
        .
     .
  .
  POST(EVENT:CloseWindow)
  close(report)
  DO PROCEDURERETURN
ProcedureReturn ROUTINE
  FREE(PrintPreviewQueue)
  FREE(PrintPreviewQueue1)
  popBIND
  return
omit('maris')
  tex='A{50}'
  print(RPT:detail0)
  TEX='Â{50}'
  PRINT(RPT:DETAIL0)
  tex='B{50}'
  print(RPT:detail0)
  tex='C{50}'
  print(RPT:detail0)
  TEX='È{50}'
  PRINT(RPT:DETAIL0)
  TEX='D{50}'
  PRINT(RPT:DETAIL0)
  TEX='E{50}'
  PRINT(RPT:DETAIL0)
  TEX='Ç{50}'
  PRINT(RPT:DETAIL0)
  TEX='F{50}'
  PRINT(RPT:DETAIL0)
  TEX='G{50}'
  PRINT(RPT:DETAIL0)
  TEX='Ì{50}'
  PRINT(RPT:DETAIL0)
  TEX='H{50}'
  PRINT(RPT:DETAIL0)
  TEX='I{50}'
  PRINT(RPT:DETAIL0)
  TEX='Î{50}'
  PRINT(RPT:DETAIL0)
  TEX='J{50}'
  PRINT(RPT:DETAIL0)
  TEX='K{50}'
  PRINT(RPT:DETAIL0)
  TEX='Í{50}'
  PRINT(RPT:DETAIL0)
  TEX='L{50}'
  PRINT(RPT:DETAIL0)
  TEX='Ï{50}'
  PRINT(RPT:DETAIL0)
  TEX='M{50}'
  PRINT(RPT:DETAIL0)
  TEX='N{50}'
  PRINT(RPT:DETAIL0)
  TEX='Ò{50}'
  PRINT(RPT:DETAIL0)
  TEX='O{50}'
  PRINT(RPT:DETAIL0)
  TEX='P{50}'
  PRINT(RPT:DETAIL0)
  TEX='Q{50}'
  PRINT(RPT:DETAIL0)
  TEX='R{50}'
  PRINT(RPT:DETAIL0)
  TEX='S{50}'
  PRINT(RPT:DETAIL0)
  TEX='Ð{50}'
  PRINT(RPT:DETAIL0)
  TEX='T{50}'
  PRINT(RPT:DETAIL0)
  TEX='U{50}'
  PRINT(RPT:DETAIL0)
  TEX='Û{50}'
  PRINT(RPT:DETAIL0)
  TEX='V{50}'
  PRINT(RPT:DETAIL0)
  TEX='W{50}'
  PRINT(RPT:DETAIL0)
  TEX='X{50}'
  PRINT(RPT:DETAIL0)
  TEX='Y{50}'
  PRINT(RPT:DETAIL0)
  TEX='Z{50}'
  PRINT(RPT:DETAIL0)
  tex='a{50}'
  print(RPT:detail0)
  TEX='â{50}'
  PRINT(RPT:DETAIL0)
  tex='b{50}'
  print(RPT:detail0)
  tex='c{50}'
  print(RPT:detail0)
  TEX='è{50}'
  PRINT(RPT:DETAIL0)
  TEX='d{50}'
  PRINT(RPT:DETAIL0)
  TEX='e{50}'
  PRINT(RPT:DETAIL0)
  TEX='ç{50}'
  PRINT(RPT:DETAIL0)
  TEX='f{50}'
  PRINT(RPT:DETAIL0)
  TEX='g{50}'
  PRINT(RPT:DETAIL0)
  TEX='ì{50}'
  PRINT(RPT:DETAIL0)
  TEX='h{50}'
  PRINT(RPT:DETAIL0)
  TEX='i{50}'
  PRINT(RPT:DETAIL0)
  TEX='î{50}'
  PRINT(RPT:DETAIL0)
  TEX='j{50}'
  PRINT(RPT:DETAIL0)
  TEX='k{50}'
  PRINT(RPT:DETAIL0)
  TEX='í{50}'
  PRINT(RPT:DETAIL0)
  TEX='l{50}'
  PRINT(RPT:DETAIL0)
  TEX='ï{50}'
  PRINT(RPT:DETAIL0)
  TEX='m{50}'
  PRINT(RPT:DETAIL0)
  TEX='n{50}'
  PRINT(RPT:DETAIL0)
  TEX='ò{50}'
  PRINT(RPT:DETAIL0)
  TEX='o{50}'
  PRINT(RPT:DETAIL0)
  TEX='p{50}'
  PRINT(RPT:DETAIL0)
  TEX='q{50}'
  PRINT(RPT:DETAIL0)
  TEX='r{50}'
  PRINT(RPT:DETAIL0)
  TEX='s{50}'
  PRINT(RPT:DETAIL0)
  TEX='ð{50}'
  PRINT(RPT:DETAIL0)
  TEX='t{50}'
  PRINT(RPT:DETAIL0)
  TEX='u{50}'
  PRINT(RPT:DETAIL0)
  TEX='û{50}'
  PRINT(RPT:DETAIL0)
  TEX='v{50}'
  PRINT(RPT:DETAIL0)
  TEX='w{50}'
  PRINT(RPT:DETAIL0)
  TEX='x{50}'
  PRINT(RPT:DETAIL0)
  TEX='y{50}'
  PRINT(RPT:DETAIL0)
  TEX='z{50}'
  PRINT(RPT:DETAIL0)
  tex='1{50}'
  print(RPT:detail0)
  TEX='2{50}'
  PRINT(RPT:DETAIL0)
  tex='3{50}'
  print(RPT:detail0)
  tex='4{50}'
  print(RPT:detail0)
  TEX='5{50}'
  PRINT(RPT:DETAIL0)
  TEX='6{50}'
  PRINT(RPT:DETAIL0)
  TEX='7{50}'
  PRINT(RPT:DETAIL0)
  TEX='8{50}'
  PRINT(RPT:DETAIL0)
  TEX='9{50}'
  PRINT(RPT:DETAIL0)
  TEX='0{50}'
  PRINT(RPT:DETAIL0)
  TEX='`{50}'
  PRINT(RPT:DETAIL0)
  TEX='~{50}'
  PRINT(RPT:DETAIL0)
  TEX='!{50}'
  PRINT(RPT:DETAIL0)
  TEX='@{50}'
  PRINT(RPT:DETAIL0)
  TEX='#{50}'
  PRINT(RPT:DETAIL0)
  TEX='${50}'
  PRINT(RPT:DETAIL0)
  TEX='%{50}'
  PRINT(RPT:DETAIL0)
  TEX='^{50}'
  PRINT(RPT:DETAIL0)
  TEX='&{50}'
  PRINT(RPT:DETAIL0)
  TEX='*{50}'
  PRINT(RPT:DETAIL0)
  TEX='({50}'
  PRINT(RPT:DETAIL0)
  TEX='){50}'
  PRINT(RPT:DETAIL0)
  TEX='-{50}'
  PRINT(RPT:DETAIL0)
  TEX='_{50}'
  PRINT(RPT:DETAIL0)
  TEX='={50}'
  PRINT(RPT:DETAIL0)
  TEX='+{50}'
  PRINT(RPT:DETAIL0)
  TEX='|{50}'
  PRINT(RPT:DETAIL0)
  TEX='\{50}'
  PRINT(RPT:DETAIL0)
  TEX='[{50}'
  PRINT(RPT:DETAIL0)
  TEX=']{50}'
  PRINT(RPT:DETAIL0)
  TEX='?{50}'
  PRINT(RPT:DETAIL0)
  tex=',{50}'
  print(RPT:detail0)
  TEX='.{50}'
  PRINT(RPT:DETAIL0)
  tex='/{50}'
  print(RPT:detail0)
  tex=' {50}'&'|'
  print(RPT:detail0)
maris
ANSIUZOEM            FUNCTION (LAUKS)             ! Declare Procedure
BURTI    STRING(22)
  CODE                                            ! Begin processed code
  BURTI='µÆÓÒðñòÖ×Øôóöõü·ÐýÞÝø÷' !ASCII BURTI
  LOOP I# = 1 TO LEN(CLIP(LAUKS))
    J#=INSTRING(lauks[I#],'ÂâÈèÇçÌìÎîÍíÏïÒòÐðÛûÞþ')
    IF J#
       LAUKS[I#]=BURTI[J#]
    .
  .
  RETURN(LAUKS)
