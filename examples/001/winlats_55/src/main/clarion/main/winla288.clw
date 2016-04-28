                     MEMBER('winlats.clw')        ! This is a MEMBER module
Gita_Rikojumi        PROCEDURE                    ! Declare Procedure
KAD_RI1                 FILE,DRIVER('TOPSPEED'),PRE(RI1),CREATE,BINDABLE,THREAD
NR_KEY                   KEY(RI1:U_NR),NOCASE,OPT
ID_KEY                   KEY(RI1:ID,-RI1:DATUMS),DUP,NOCASE
DAT_KEY                  KEY(RI1:DATUMS,RI1:DOK_NR),DUP,NOCASE,OPT
DAT_DKEY                 KEY(-RI1:DATUMS,-RI1:DOK_NR),DUP,NOCASE,OPT
Record                   RECORD,PRE()
U_NR                        ULONG
ID                          USHORT
TIPS                        STRING(1)
Z_KODS                      BYTE
DATUMS                      LONG
DOK_NR                      STRING(10)
DATUMS1                     LONG
DATUMS2                     LONG
SATURS                      STRING(60)
SATURS1                     STRING(60)
R_FAILS                     STRING(12)
BAITS                       BYTE
ACC_KODS                    STRING(8)
ACC_DATUMS                  LONG
                         END
                       END

  CODE                                            ! Begin processed code
          TTAKA"=LONGPATH()
          stop(TTAKA")
          SETPATH(TTAKA")
          CHECKOPEN(KAD_RIK,1)
          FILENAME1 = 'C:\CurWork\Gita\BERNI'
!           COPY(KAD_RIK,FILENAME1)
           TTAKA"=LONGPATH()
           SETPATH(FILENAME1)
!           close(KAD_RIK)
           CHECKOPEN(KAD_RI1,1)
               CLEAR(RIK:Record,0)
               SET(KAD_RIK)
               ! kopiruen KAD_RIK iz tekuschego kataloga LONGPATH() v  KAD_RI1 iz papki Berni
               LOOP
                  NEXT(KAD_RIK)
                  IF ERROR() THEN BREAK.
                  CLEAR(RI1:Record,0)
                  RI1:record = RIK:record
                  STOP (RI1:TIPS &' '&RI1:SATURS)
                  ADD(KAD_RI1)
               .
               close(KAD_RIK)
               SETPATH(FILENAME1)
               CHECKOPEN(KAD_RIK,1)
               CLEAR(RIK:Record,0)
               SET(KAD_RIK)
                ! kopiruen KAD_RIK iz papki Berni v  KAD_RI1 iz papki Berni
              LOOP
                  NEXT(KAD_RIK)
                  IF ERROR() THEN BREAK.
                  CLEAR(RI1:Record,0)
                  RI1:record = RIK:record
                  STOP (RI1:TIPS &' '&RI1:SATURS)
                  ADD(KAD_RI1)
               .
               close(KAD_RIK)
               close(KAD_RI1)
               SETPATH(TTAKA")


