                     MEMBER('winlats.clw')        ! This is a MEMBER module
PerformShortcutForRef PROCEDURE                   ! Declare Procedure
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
REFERENCE     STRING(14)
GGK_SAVE_POSITION STRING(256)

  CODE                                            ! Begin processed code
!***************** BÛS VIÒU VAI MÛSU APMAKSA *****************
   CHECKOPEN(GLOBAL,1)
   IF GG:PAR_NR=0
      KLUDA(87,'Partneris sastâdâmajâ dokumentâ')
      DO PROCEDURERETURN
   .

   IF D_K='D'          !D_K NÂK NO IZSAUKUMA POGAS
      I_D_K='K'
   ELSE
      I_D_K='D'
   .
   PAR_NR=GG:PAR_NR
   GGK_SAVE_POSITION = POSITION(GGK)
   SAV_GGK_RECORD=GGK:RECORD
   REFERENCE=''

   ReferFixGG_noKont          !REFERENCES UZ PREÈU(PAKALPOJUMU) DOKUMENTIEM

   RESET(GGK,GGK_SAVE_POSITION)
   NEXT(GGK)
   GGK:RECORD = SAV_GGK_RECORD

   IF GLOBALRESPONSE=REQUESTCOMPLETED

       IF RECORDS(A_TABLE) = 1
          GET(A_TABLE,I#)
          REFERENCE=A:REFERENCE
       .
       ggk:REFERENCE = REFERENCE
   .
   DO PROCEDURERETURN


PROCEDURERETURN    ROUTINE
       FREE(A_TABLE)
       FREE(B_TABLE)
       RETURN
