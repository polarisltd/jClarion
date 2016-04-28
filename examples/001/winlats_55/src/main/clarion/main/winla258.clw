                     MEMBER('winlats.clw')        ! This is a MEMBER module
PerformShortcutIesk  PROCEDURE                    ! Declare Procedure
I_D_K                STRING(1)
SAV_PAR_NR    ULONG
GGK_SUMMAV    DECIMAL(12,2)
SVARS         SREAL
TEKSTS1       LIKE(TEKSTS)
DK_KKKS       STRING(12)
DK_KKK        STRING(3),DIM(4),OVER(DK_KKKS)

A_NODALA      LIKE(A:NODALA)
A_OBJ_NR      LIKE(A:OBJ_NR)

B_TABLE  QUEUE,PRE(B)
KEY        STRING(8)
NODALA     LIKE(GGK:NODALA)
OBJ_NR     LIKE(GGK:OBJ_NR)
PROPORCIJA LIKE(GGK:SUMMAV)
         .
B_SUMMAV       LIKE(GGK:SUMMAV)
SAV_GGK_RECORD LIKE(GGK:RECORD)

  CODE                                            ! Begin processed code
!***************** BÛS VIÒU IESKAITS APMAKSA *****************
   CHECKOPEN(GLOBAL,1)
   IF GG:PAR_NR=0
      KLUDA(87,'Partneris sastâdâmajâ dokumentâ')
      DO PROCEDURERETURN
   .
   PAR_NR=GG:PAR_NR
!  KKK=*31
   ReferFixGGIESK         !REFERENCES UZ PREÈU(PAKALPOJUMU) DOKUMENTIEM
   IF GLOBALRESPONSE=REQUESTCOMPLETED
      TEKSTS='Ieskaits'
      TEKSTS1=TEKSTS
      SUMMA=0
      RAKSTI#=0
      LOOP I#= 1 TO RECORDS(A_TABLE)
         GET(A_TABLE,I#)
         IF A:SUMMAV_T
            SUMMA+=A:SUMMAV_T
            VAL_NOS=A:VAL_T
            RAKSTI#+=1
            TEKSTS =CLIP(TEKSTS)&' '&A:REFERENCE
            TEKSTS1=CLIP(TEKSTS1)&' '&A:REFERENCE
         .
      .
      IF SUMMA
         IF RAKSTI# > 5  !CITÂDI NELIEN IEKÐÂ
            TEKSTS=TEKSTS1
         .
         FORMAT_TEKSTS(45,'WINDOW',0,'',)
         gg:saturs =F_TEKSTS[1]
         gg:saturs2=F_TEKSTS[2]
         gg:saturs3=F_TEKSTS[3]
         GG:ATT_DOK='8' !AKTS-jâdomâ ieskaits
      ELSE
         KLUDA(0,'NULLES SUMMA ...')
         DO PROCEDURERETURN
      .
      CHECKOPEN(GGK,1)
      CLEAR(GGK:RECORD)
      CHECKOPEN(KON_K,1)
      IF ~val_nos THEN VAL_NOS='Ls'.
      GGK:val=val_nos
      GG:val=val_nos
      GGK:U_NR=GG:U_NR
      ggk:rs=gg:rs
      GGK:DATUMS=GG:DATUMS
      GGK:REFERENCE=0
      GGK:PAR_NR=GG:PAR_NR
      GGK:SUMMAV= Summa
      IF ~PVN_PROC THEN PVN_PROC=SYS:NOKL_PVN.
      GGK:PVN_PROC=PVN_PROC
      LOOP J#= 1 TO RECORDS(A_TABLE)
         GET(A_TABLE,J#)
         IF A:SUMMAV_T                   !FIX SAM.TAGAD
            GGK:BKK=A:BKK
            IF GGK:BKK[1:3]='231'
               GGK:D_K='K'
            ELSE
               GGK:D_K='D'
            .
            GGK:SUMMAV=A:SUMMAV_T
            ggk:REFERENCE=A:REFERENCE
            GGK:NODALA=A:NODALA
            GGK:OBJ_NR=A:OBJ_NR
            DO ADDGGK
         .
      .
   .
   DO PROCEDURERETURN

ADDGGK    ROUTINE
        GGK:SUMMA=GGK:SUMMAV*BANKURS(GGK:VAL,GGK:DATUMS)
!        STOP(GGK:U_NR&' '&GGK:BKK&' '&GGK:SUMMA)
        ADD(GGK)
        IF ~ERROR()
           CASE GGK:D_K
           OF 'D'
              CONTROL$+=GGK:SUMMA
           OF 'K'
              CONTROL$-=GGK:SUMMA
           .
           ATLIKUMIB(GGK:D_K,GGK:BKK,GGK:SUMMA,GGK:D_K,GGK:BKK,0)
        ELSE
           STOP('Rakstot ggk:'&ERROR())
        .

PROCEDURERETURN    ROUTINE
       FREE(A_TABLE)
       FREE(B_TABLE)
       RETURN
ANSIJOB              PROCEDURE                    ! Declare Procedure
  CODE                                            ! Begin processed code
 IF ~F:DBF  !NO REPORTIEM NÂK .TXT AR F:DBF
    IF INSTRING('.DOC',UPPER(ANSIFILENAME),1)
       F:DBF='A'
    ELSIF INSTRING('.XLS',UPPER(ANSIFILENAME),1)
       F:DBF='E'
    ELSIF INSTRING('.PDF',UPPER(ANSIFILENAME),1)
       F:DBF='P'
    ELSIF INSTRING('.JPG',UPPER(ANSIFILENAME),1)
       F:DBF='J'
    ELSE
       KLUDA(0,'Neatbalstîts faila formâts '&ANSIFILENAME[LEN(ANSIFILENAME)-2:LEN(ANSIFILENAME)])
       F:DBF=''
    .
 .
 CLOSE(OUTFILEANSI)
 IF F:DBF='A'
   IF WORD
      RUN(WORD&' '&ANSIFILENAME)
      IF RUNCODE()=-4
         KLUDA(88,'prog-a '&WORD)
      .
   ELSE
      RUN('WORDPAD '&ANSIFILENAME)
      IF RUNCODE()=-4
         KLUDA(88,'prog-a WordPad.exe')
      .
   .
 ELSIF F:DBF='E'
   IF EXCEL
      RUN(EXCEL&' '&ANSIFILENAME)
      IF RUNCODE()=-4
         KLUDA(88,'prog-a '&EXCEL)
      .
   ELSE
      KLUDA(0,'Nav definçta prog-a Excel.exe failâ C:\WinLats\WinLatsC.INI')
   .
 ELSIF F:DBF='P'
   IF PDF
      RUN(PDF&' '&ANSIFILENAME)
      IF RUNCODE()=-4
         KLUDA(88,'prog-a '&PDF)
      .
   ELSE
      KLUDA(0,'Nav definçta prog-a AcroRd32.exe failâ C:\WinLats\WinLatsC.INI')
   .
 ELSIF F:DBF='J'
   IF JPG
      RUN(JPG&' '&ANSIFILENAME)
      IF RUNCODE()=-4
         KLUDA(88,'prog-a '&JPG)
      .
   ELSE
      KLUDA(0,'Nav definçts jpg failu skatîtâjs failâ C:\WinLats\WinLatsC.INI')
   .
 ELSE
    KLUDA(0,'nepareizs izsaukums: '&F:DBF)
 .
 F:DBF=''
 ! ANSIFILENAME='' VAR VÇL NODERÇT
GetFiltrs_Text       FUNCTION (FILTRS)            ! Declare Procedure
FILTRS_TEXT    STRING(120)
STRINGS        STRING(21)
  CODE                                            ! Begin processed code
!FILTRS:OBJ,NOD,PART,PARG,NOM,NOMT,DN,PARÂDS
 LOOP I#=1 TO LEN(CLIP(FILTRS))      !MAX=8 31.07.07.
   IF INSTRING(FILTRS[I#],'12')      !PAGAIDÂM TIKAI 0,1
      EXECUTE I#
        IF F:OBJ_NR THEN FILTRS_TEXT='Objekts:'&F:OBJ_NR&' '&GetPROJEKTI(F:OBJ_NR,1).
        IF F:NODALA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' F pçc Nodaïas: '&F:NODALA&' '&GetNodalas(F:nodala,1).
        IF ~(PAR_TIPS='EFCNIR') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' ParTips:'&PAR_TIPS.
        BEGIN                                                                                  !4
           IF PAR_GRUPA
              STRINGS=PAR_GRUPA
              LOOP J#=1 TO LEN(CLIP(STRINGS))
                  IF STRINGS[J#]='' THEN STRINGS[J#]='.'.
              .
              FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Grupa:'&STRINGS
           .
        .
        IF NOMENKLAT THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Nomenklatûra:'&NOMENKLAT.            !5
        IF ~(NOM_TIPS7='PTAKRIV') THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' NomTips:'&NOM_TIPS7.    !6
        IF F:DIENA THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' Diena/nakts=:'&F:DIENA.                !7
        IF F:ATL[2]='1' THEN FILTRS_TEXT=CLIP(FILTRS_TEXT)&' arî, ja nav parâds'.              !8
      .
   .
 .
 FILTRS_TEXT=LEFT(FILTRS_TEXT)
 RETURN(FILTRS_TEXT)
