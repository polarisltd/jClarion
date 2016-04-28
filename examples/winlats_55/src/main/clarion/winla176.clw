                     MEMBER('winlats.clw')        ! This is a MEMBER module
AI_KA_WRITE          PROCEDURE                    ! Declare Procedure
!************** KONFIG FAILS CHD3010T,4010T,5010,TEC,3510T,5510T *********************************************
KONFIG              FILE,PRE(KFG),DRIVER('DBASE3'),CREATE
RECORD                 RECORD
COM                      STRING(@N_1)
BAUD                     STRING(@N_6)
BASEADDR                 STRING(4)
IRQ                      STRING(@N_2)
PHONENUM                 STRING(42)
NOCOMTIME                STRING(@N_2)
DEBUG                    STRING(@N_1)
EANSET                   STRING(@N_1)
ECRADDR                  STRING(@N_2)
                    .  .
!************** KONFIG FAILS OMRON3420 *********************************************
KOMANDA           FILE,PRE(KMD),DRIVER('dBase3'),CREATE
RECORD              RECORD
KOMANDA               STRING(@N2)
FAILS                 STRING(12)
KLUDA                 STRING(@N2)
PARAM                 STRING(25)
SK1                   STRING(@N_12)
SK2                   STRING(@N_12)
SK3                   STRING(@N_12)
                  . .
!!************** KONFIG FAILS OMRON3420 *********************************************
!KOMANDAN          FILE,PRE(KMN),DRIVER('dBase3'),CREATE,NAME('KOMANDA.DBF')
!RECORD              RECORD
!KOMANDA               STRING(@N2)
!FAILS                 STRING(12)
!KLUDA                 STRING(@N2)
!PARAM                 STRING(25)
!SK1                   STRING(@N_12)
!SK2                   STRING(@N_12)
!SK3                   STRING(@N_12)
!SK4                   STRING(@N_12)
!                  . .
!************** DATU FAILS TEC,OMRON2810,3410,3420,3510 *******************************
DATI              FILE,PRE(DAT),DRIVER('dBase3'),CREATE,OEM
RECORD              RECORD
KODS                  STRING(@N_13)
NOSAUK                STRING(20)
ACM                   STRING(@N2)
PVN                   STRING(@N1)
LIMENIS               STRING(@N1)
ATLAIDE               STRING(@N1)
SVARS                 STRING(@N1)
TARA                  STRING(@N3)
NODALA                STRING(@N2)
CENA                  STRING(@N_9.2)
ID                    STRING(@N1)
SKAITS                STRING(@N_9.3)
SUMMA                 STRING(@N_11.2)
DATUMS                STRING(@D5)
LAIKS                 STRING(@T4)
KASEID                STRING(3)
REZIMS                STRING(1)
TIKLADR               STRING(@N2)
REZULT                STRING(@N1)
KLUDA                 STRING(@N1)
                  . .
!************** DATU FAILS CHD3010T,4010T,5010T,3510T,5510T ***********************
!Acm               FILE,PRE(ACM),DRIVER('dBase3'),CREATE,OEM  IESPÇJAMS,KA 4010 VAJAG OEM !!!
Acm               FILE,PRE(ACM),DRIVER('dBase3'),CREATE
RECORD              RECORD
KODS                  STRING(@N_13)
NOSAUK                STRING(20)
PVN                   STRING(@N_1)
TARA                  STRING(@N_3)
NODALA                STRING(@N_2)
CENA                  STRING(@N_9.2)
SKAITS                STRING(@N_9.3)
SUMMA                 STRING(@N_11.2)
DATUMS                STRING(@D12)
LAIKS                 STRING(8)
REZIMS                STRING(1)
TIKLADR               STRING(@N_2)
                  . .
!************** DATU FAILI BLUEBRIDGE *******************************
PLUNAME               STRING(30),STATIC
PROTNAME              STRING(30),STATIC
LOCKNAME              STRING(30)
LOCKOKNAME            STRING(30)
BLUESOURCE            BYTE

PlU               FILE,PRE(PLU),DRIVER('dBase3'),NAME(PLUNAME),CREATE,OEM
RECORD              RECORD
CODE                  STRING(14)
ART                   STRING(6)
DESCR                 STRING(35)
PRICE                 STRING(15)
PRICE1                STRING(15)
UNIT                  STRING(2)
DEC                   STRING(1)
TAX                   STRING(1)
TBLOCK                STRING(2)
DISC                  STRING(2)
DISC_A                STRING(2)
DEPT                  STRING(2)
QTY                   STRING(15)
AMT                   STRING(15)
STATUS                STRING(1)
STATUS1               STRING(1)
STATUS2               STRING(1)
BOTTLE                STRING(8)
ACTIVE                STRING(1)
DEL                   STRING(1)
LOAD                  STRING(1)
CRC                   STRING(8)
RC                    STRING(1)
                  . .
PROT              FILE,PRE(PRR),DRIVER('dBase3'),NAME(PROTNAME),CREATE
RECORD              RECORD
ISSUED                STRING(12)
CMD                   STRING(3)
P1                    STRING(14)
P2                    STRING(14)
P3                    STRING(14)
LVL                   STRING(1)
DONE_DATE             STRING(8)
DONE_TIME             STRING(5)
DEL                   STRING(1)
                  . .

!************** DATU FAILS CASIO FE300 *******************************

ASCIINAME    STRING(40),STATIC
ASCIIFILE      FILE,NAME(ASCIINAME),PRE(A),DRIVER('ASCII'),CREATE
RECORD          RECORD
KODS             STRING(13)              !PLU
KOMATS1          STRING(1)               !KOMATS
CENA             STRING(8)               !CENA (RIGHT), PÇDÇJIE 2 BAITI IR SANTÎMI
KOMATS2          STRING(1)               !KOMATS
NOSAUK           STRING(16)              !NOSAUKUMAM JÂBÛT "....."
KOMATS3          STRING(1)               !KOMATS
D1               STRING(4)               !
KOMATS4          STRING(1)               !KOMATS
D2               STRING(2)               !
KOMATS5          STRING(1)               !KOMATS
PVN              STRING(4)               !PVN JÂBÛT ".." 01-18% 02-9% 03-0%
KOMATS6          STRING(1)               !KOMATS
SKAITS           STRING(@N_8.3)          !SKAITS
             . .
!************** INI FAILS CHD 3320/5620 Elya *******************************
ININAME    STRING(40),STATIC
INIFILE      FILE,NAME(ININAME),PRE(I),DRIVER('ASCII'),CREATE
RECORD          RECORD
STR             STRING(40)
             . .
!************** DATU FAILS CHD 3320/5620 Elya *******************************

TNAME    STRING(40),STATIC
TFILE      FILE,NAME(TNAME),PRE(T),DRIVER('ASCII'),CREATE
RECORD          RECORD
KODS             STRING(@N_13)           !PLU
KOMATS1          STRING(1)               !KOMATS
NOSAUK           STRING(22)              !NOSAUKUMAM JÂBÛT "....."  20 + " + "
KOMATS2          STRING(1)               !KOMATS
CENA             STRING(@N_10.2)         !CENA (RIGHT), PÇDÇJIE 2 BAITI IR SANTÎMI
KOMATS3          STRING(1)               !KOMATS
CENA1            STRING(@N_10.2)         !CENA (RIGHT), PÇDÇJIE 2 BAITI IR SANTÎMI
KOMATS4          STRING(1)               !KOMATS
CENA2            STRING(@N_10.2)         !CENA (RIGHT), PÇDÇJIE 2 BAITI IR SANTÎMI
KOMATS5          STRING(1)               !KOMATS
PVN              STRING(2)               !PVN 1 … PVN sekcijas numurs, 0 - neapliekam.
KOMATS6          STRING(1)               !KOMATS
NODALA           STRING(2)               !0 … 99
KOMATS7          STRING(1)               !KOMATS
D1               STRING(2)               !=00 … 77 Digit 1 - number of high price limit digits, 0 - no limit
                                          !Digit 2 - number of low price limit digits, 0 - no limit
KOMATS8          STRING(1)               !KOMATS
NegItem          STRING(1)               !0 - disabled, 1 - enabled
KOMATS9          STRING(1)               !KOMATS
NulCena          STRING(1)               !0 - disabled, 1 - enabled
KOMATS10         STRING(1)               !KOMATS
!Optional fields
PrecGr           STRING(4)               !1 … Preces grupa, 0 - nav grupas (pec noklusejuma)
KOMATS11         STRING(1)               !KOMATS
LielakCena       STRING(1)               !0 - disabled, 1 - enabled
KOMATS12         STRING(1)               !KOMATS
DaudzOblig       STRING(1)               !0 - disabled, 1 - enabled
             . .

!************** DATU FAILS OPTIMA CR500 *******************************

OPTIMA    FILE,PRE(OPT),DRIVER('dBase3'),CREATE,NAME(FILENAME1),OEM
RECORD      RECORD
F1           STRING(@N_5)
F2           STRING(@N_13)
F3           STRING(12)
F4           STRING(@N_3)
F5           STRING(@N_8)
F6           STRING(@N_10)
F7           STRING(@N_10)
          . .

!************** DATU FAILS UNIWELL *******************************

UNIWELL   FILE,NAME(FILENAME1),PRE(UNI),DRIVER('ASCII'),CREATE
            RECORD,PRE(UNI)
DRAZA              STRING(5)
KODS_ACM           STRING(13)
TAB1               STRING(1)
NOSAUK             STRING(16)
TAB2               STRING(1)
NUL1               STRING(1)
TAB3               STRING(1)
NUL2               STRING(1)
TAB4               STRING(1)
PVN                STRING(1)
TAB5               STRING(1)
VIE1               STRING(1)
TAB6               STRING(1)
VIE2               STRING(1)
TAB7               STRING(1)
NUL3               STRING(1)
TAB8               STRING(1)
VIE3               STRING(1)
TAB9               STRING(1)
NUL4               STRING(1)
TAB10              STRING(1)
VIE4               STRING(1) !1-ATÏAUTA 0-ES CENA
TAB11              STRING(1)
NUL5               STRING(1)
TAB12              STRING(1)
C98                STRING(2)
TAB13              STRING(1)
AP                 STRING(2)
TAB14              STRING(1)
NUL6               STRING(2)
TAB15              STRING(1)
NUL7               STRING(2)
TAB16              STRING(1)
NUL8               STRING(3)
TAB17              STRING(1)
CENA               STRING(8)
TAB18              STRING(1)
CENA2              STRING(8)
TAB19              STRING(1)
ATLIK              STRING(9) !99999.999
          . .

!******************************************************************

soundfile             CSTRING(80)
KODS                  DECIMAL(13)
NOSAUK                STRING(20)
PVN                   DECIMAL(1)
CENA                  DECIMAL(9,2)
IDE                   STRING(1)
RAKSTI                USHORT
DN                    STRING(1)
NODALA                DECIMAL(2)
STATUSS1              STRING(60)
LOCALRESPONSE         LONG
IzlaistNulles         STRING(1)
vers                  byte,dim(4)
version               long,over(vers)
WINDOWSVERS           string(20)
PAROLE                string(10)
IPAdrese              string(20)
COM_                  DECIMAL(2)
TCPPorts              DECIMAL(4)
ChangeINI             DECIMAL(1) !Elya 1 - vajag manit INI, 2 - jauns INI


Konfig_screen WINDOW('CHD3010,4010,5010,TEC MA-1650,CHD3510,5510 Konfigurâcija '),AT(,,230,210),CENTER, |
         GRAY
       PROMPT('&COM'),AT(27,10),USE(?Prompt:KFG:COM)
       ENTRY(@n1),AT(67,8),USE(KFG:COM)
       STRING(@s20),AT(131,3,89,10),USE(windowsvers),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
       PROMPT('&Baud'),AT(27,24),USE(?Prompt:Kfg:baud)
       ENTRY(@N_6),AT(67,22),USE(KFG:BAUD)
       PROMPT('BaseA&DDR'),AT(27,38),USE(?Prompt:Kfg:BASEADDR)
       ENTRY(@s4),AT(67,36),USE(Kfg:BASEADDR)
       ENTRY(@n_2),AT(67,50),USE(KFG:IRQ)
       PROMPT('IR&Q'),AT(27,53),USE(?Prompt:KFG:IRQ)
       ENTRY(@S42),AT(67,64),USE(KFG:PhoneNum)
       PROMPT('&PhoneNum'),AT(27,67),USE(?Prompt:KFG:PhoneNum)
       ENTRY(@n2),AT(67,78),USE(KFG:NocomTime)
       PROMPT('Nocom&Time'),AT(27,81),USE(?Prompt:KFG:NocomTime)
       ENTRY(@n1),AT(67,92),USE(Kfg:Debug)
       PROMPT('Debu&g'),AT(27,95),USE(?Prompt:Kfg:Debug)
       ENTRY(@n1),AT(67,106),USE(Kfg:EanSet)
       PROMPT('&KA Nr'),AT(27,109),USE(?Prompt:Kfg:EanSet)
       PROMPT('&EcrAddr'),AT(27,122),USE(?Prompt:Kfg:EcrAddr)
       ENTRY(@n_2),AT(67,120),USE(Kfg:EcrAddr)
       ENTRY(@s1),AT(67,135),USE(DN)
       STRING('D-vispirms nodzçst PLU kases aparâtâ'),AT(89,137),USE(?String1)
       PROMPT('&Cena'),AT(27,152),USE(?Prompt:cena)
       ENTRY(@N1),AT(67,150,16,12),USE(NOKL_CP)
       BUTTON('Rakstît tikai tos, kam ir atlikums'),AT(28,166,119,14),USE(?ButtonIzlNul)
       IMAGE('CHECK3.ICO'),AT(151,164,16,16),USE(?ImageIzlNul),HIDE
       PROMPT('&Nodaïa'),AT(29,186),USE(?Prompt:nodala)
       ENTRY(@n2),AT(67,185),USE(nodala)
       BUTTON('&OK'),AT(144,185,35,14),USE(?OkButton),DEFAULT
       BUTTON('Atlikt'),AT(181,185,36,14),USE(?CancelButton)
     END
Kon_screen WINDOW('CHD 3320/5620 Konfigurâcija '),AT(,,230,108),CENTER,GRAY
       PROMPT('&COM'),AT(27,26),USE(?Prompt:COM)
       ENTRY(@n2),AT(67,24,16,12),USE(COM_)
       STRING(@s20),AT(131,3,89,10),USE(windowsvers),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
       ENTRY(@s1),AT(67,56,16,12),USE(DN)
       STRING('D-vispirms nodzçst PLU kases aparâtâ'),AT(89,58),USE(?String1)
       PROMPT('&Cena'),AT(27,42),USE(?Prompt:cena)
       ENTRY(@N1),AT(67,40,16,12),USE(NOKL_CP)
       BUTTON('Rakstît tikai tos, kam ir atlikums'),AT(28,70,119,14),USE(?ButtonIzlNul_0)
       IMAGE('CHECK3.ICO'),AT(151,68,16,16),USE(?ImageIzlNul_0),HIDE
       PROMPT('&Nodaïa'),AT(27,10),USE(?Prompt:nodala)
       ENTRY(@n2),AT(67,9),USE(nodala)
       BUTTON('&OK'),AT(144,89,35,14),USE(?OkButton_0),DEFAULT
       BUTTON('Atlikt'),AT(181,89,36,14),USE(?CancelButton_0)
     END
Kon1_screen WINDOW('CHD 3320/5620 Konfigurâcija '),AT(,,230,138),CENTER,GRAY
       STRING(@s20),AT(131,3,89,10),USE(windowsvers),CENTER,FONT(,,COLOR:Gray,,CHARSET:ANSI)
       ENTRY(@s1),AT(67,86),USE(DN)
       ENTRY(@s10),AT(67,57,60,10),USE(Parole),LEFT
       PROMPT('&Parole'),AT(29,57,36,10),USE(?Prompt:Parole)
       STRING('D-vispirms nodzçst PLU kases aparâtâ'),AT(89,88),USE(?String1)
       PROMPT('&Cena'),AT(29,72),USE(?Prompt:cena)
       PROMPT('&IP Adrese'),AT(29,29,36,10),USE(?Prompt:IPAdrese)
       ENTRY(@N1),AT(67,70,16,12),USE(NOKL_CP)
       ENTRY(@n4),AT(67,43,46,10),USE(TCPPorts)
       PROMPT('&TCP ports'),AT(29,43,36,10),USE(?Prompt:TCPports)
       ENTRY(@s20),AT(67,29,60,10),USE(IPAdrese),LEFT
       BUTTON('Rakstît tikai tos, kam ir atlikums'),AT(28,101,119,14),USE(?ButtonIzlNul_1)
       IMAGE('CHECK3.ICO'),AT(151,99,16,16),USE(?ImageIzlNul_1),HIDE
       PROMPT('&Nodaïa'),AT(29,13),USE(?Prompt:nodala)
       ENTRY(@n2),AT(67,12),USE(nodala)
       BUTTON('&OK'),AT(144,120,35,14),USE(?OkButton_1),DEFAULT
       BUTTON('Atlikt'),AT(181,120,36,14),USE(?CancelButton_1)
     END

Komanda_Screen WINDOW('OMRON komandu fails'),AT(,,236,181),CENTER,GRAY
       STRING('Komanda'),AT(28,18),USE(?String2)
       STRING(@s2),AT(65,18),USE(KMD:KOMANDA)
       STRING('Fails'),AT(28,28),USE(?String4)
       STRING(@s20),AT(66,28),USE(kmd:fails),LEFT
       PROMPT('&Nodaïa'),AT(28,39),USE(?Prompt:kmd:param)
       ENTRY(@n2),AT(66,37),USE(nodala,,?nodala:1)
       PROMPT('&Parametri'),AT(28,52),USE(?Prompt:kmd:param:1)
       ENTRY(@s25),AT(66,51),USE(kmd:param)
       STRING('C1 Pârraide cuur COM1 portu'),AT(35,65),USE(?String5)
       STRING('C2 Pârraide cuur COM2 portu'),AT(35,76),USE(?String6)
       STRING('B1200(B2400,B9600) Datu pârraides âtrums'),AT(35,87),USE(?String7)
       STRING('D(S) Izvadît (Neizvadît) komunikâciju paziòojumus uz ekrâna '),AT(35,98),USE(?String8)
       PROMPT('&Cena'),AT(74,115),USE(?Prompt:cena:2)
       ENTRY(@N1),AT(97,114,18,12),USE(NOKL_CP,,?NOKL_CP:1)
       BUTTON('Rakstît tikas tos, kam ir atlikums'),AT(50,133,108,14),USE(?ButtonIzlNul1)
       IMAGE('CHECK3.ICO'),AT(162,132,15,15),USE(?ImageIzlNul1),HIDE
       BUTTON('&OK'),AT(146,158,35,14),USE(?OkButton1),DEFAULT
       BUTTON('Atlikt'),AT(185,158,36,14),USE(?CancelButton1)
     END

!KomandaN_Screen WINDOW('OMRON3420 komandu fails'),AT(,,236,181),CENTER,GRAY
!       STRING('Komanda'),AT(28,18),USE(?String2N)
!       STRING(@s2),AT(65,18),USE(KMN:KOMANDA)
!       STRING('Fails'),AT(28,28),USE(?String4N)
!       STRING(@s20),AT(66,28),USE(kmN:fails),LEFT
!       PROMPT('&Nodaïa'),AT(28,39),USE(?Prompt:kmN:param)
!       ENTRY(@n2),AT(66,37),USE(nodala,,NODALA1)
!       PROMPT('&Parametri'),AT(28,52),USE(?Prompt:kmN:param:1)
!       ENTRY(@s25),AT(66,51),USE(kmN:param)
!       STRING('C1 Pârraide cuur COM1 portu'),AT(35,65),USE(?String5N)
!       STRING('C2 Pârraide cuur COM2 portu'),AT(35,76),USE(?String6N)
!       STRING('B1200(B2400,B9600) Datu pârraides âtrums'),AT(35,87),USE(?String7N)
!       STRING('D(S) Izvadît (Neizvadît) komunikâciju paziòojumus uz ekrâna '),AT(35,98),USE(?String8N)
!       PROMPT('&Cena'),AT(74,115),USE(?Prompt:cena:2N)
!       ENTRY(@N1),AT(97,114,18,12),USE(NOKL_CP,,?NOKL_CP:1N)
!       BUTTON('Rakstît tikas tos, kam ir atlikums'),AT(50,133,108,14),USE(?ButtonIzlNul1N)
!       IMAGE('CHECK3.ICO'),AT(162,132,15,15),USE(?ImageIzlNul1N),HIDE
!       BUTTON('&OK'),AT(146,158,35,14),USE(?OkButton1N),DEFAULT
!       BUTTON('Atlikt'),AT(185,158,36,14),USE(?CancelButton1N)
!     END

PLU_Screen WINDOW('BLUEBRIDGE'),AT(,,230,117),CENTER,GRAY
       OPTION('Fails, kur rakstît :'),AT(47,11,133,45),USE(BLUESOURCE),BOXED
         RADIO('\\KASE1\MBOX\PLU.DBF'),AT(55,21),USE(?BLUESOURCE:Radio1),VALUE('1')
         RADIO('\\KASE2\MBOX\PLU.DBF'),AT(55,30),USE(?BLUESOURCE:Radio2),VALUE('2')
         RADIO('\\KASE3\MBOX\PLU.DBF'),AT(55,39),USE(?BLUESOURCE:Radio3),VALUE('3')
       END
       IMAGE('CHECK3.ICO'),AT(164,77,15,15),USE(?ImageIzlNul2),HIDE
       PROMPT('&Cena'),AT(49,64),USE(?Prompt:cena:5)
       ENTRY(@N1),AT(72,63,18,12),USE(NOKL_CP,,?NOKL_CP:2)
       BUTTON('Rakstît tikas tos, kam ir atlikums'),AT(49,78,112,14),USE(?ButtonIzlNul2)
       BUTTON('&OK'),AT(148,97,35,14),USE(?OkButton2),DEFAULT
       BUTTON('Atlikt'),AT(187,97,36,14),USE(?CancelButton2)
     END

LoadScreen WINDOW('Kases aparâta rakstîðana'),AT(,,353,80),GRAY
       STRING(@N6B),AT(312,6),USE(RAKSTI)
       STRING(@s80),AT(9,17,337,10),USE(ZUR:record),CENTER
       STRING(@S60),AT(50,29,252,10),USE(STATUSS1),CENTER
       BUTTON('Pârtraukt'),AT(248,51,92,14),USE(?Cancel),HIDE
       BUTTON('Turpinât'),AT(150,51,95,14),USE(?ok),HIDE
     END



  CODE                                            ! Begin processed code
  DZNAME='DZKA'&FORMAT(JOB_NR,@N02)
  CLOSE(ZURNALS)
  CHECKOPEN(ZURNALS,1)
  checkopen(NOLIK,1)
  NOLIK::USED+=1
  checkopen(NOM_K,1)
  NOM_K::USED+=1

  ! 1-OMRON-3410'       X
  ! 2-OMRON-3420'       X
  ! 3-OMRON-3510'       X
  ! 4-OMRON-3510TDL'
  ! 5-VDM261'
  ! 6-KONIC-SR2000'
  ! 7-CHD-4010'         X
  ! 8-KONIC-SR2200'
  ! 9-FP-600            X
  !10-TEC-MA-1650'      X
  !11-CHD-2010'
  !12-OMRON-2810'       X
  !13-BLUEBRIDGE'       X
  !14-UNIWELL UX43'     X
  !15-OPTIMA CR500'     X
  !16-POSMAN'           x
  !17-CHD-5010'
  !18-CASIO FE300       X
  !19-FP-600PLUS        N
  !20-CHD-3010T FISCAL  N
  !21-CHD-5010T FISCAL  N
  !22-EPOS-3L FISCAL    N
  !23-CHD-3010T         X
  !24-OMRON-2810 FISCAL N
  !25-UNIWELL NX5400'   X
  !26-NEW VISION FISCAL
  !27-DATECS
  !28-CHD-3510T FISCAL
  !29-CHD-5510T FISCAL
  !30-CHD-3510T
  !31-CHD-5510T
  !32-CHD-3320/5620 !Elya

  version=GetVersion()
!  stop(vers[1]&' '&vers[2]&' '&vers[3]&' '&vers[4])
  EXECUTE vers[1]
     WINDOWSVERS='WINDOWS v '&vers[1]&'.'&vers[2]
     WINDOWSVERS='WINDOWS v '&vers[1]&'.'&vers[2]
     WINDOWSVERS='WINDOWS v '&vers[1]&'.'&vers[2]
     WINDOWSVERS='WINDOWS ( '&vers[1]&'.'&vers[2]
     WINDOWSVERS='WINDOWS XP'
     WINDOWSVERS='WINDOWS VISTA'
     WINDOWSVERS='WINDOWS 7'
  .

  CASE SYS:KASES_AP
  OF '32'        ! CHD-3320/5620
     TNAME = 'plu.txt'

     NODALA=20
     ChangeINI = 0
     ININAME = 'SDRV.ini'
     OPEN(INIFILE)
     ERR# = ERRORCODE()
     IF ERR# AND ~ERR# = 2
       kluda(1,'INIFILE')
       DO ProcedureReturn
     ELSIF ERR# = 2  !nav faila
        CREATE(INIFILE)
        CLOSE(INIFILE)
        ChangeINI = 2
     ELSE ! INI fails ir atverts
        SET(INIFILE)
        LOOP UNTIL EOF (INIFILE)
           NEXT (INIFILE)
           IF ERRORCODE() THEN
              kluda(1,'INIFILE')
              CLOSE(INIFILE)
              DO ProcedureReturn
           .
           PosEq# = INSTRING('=', I:STR)
           L# = LEN(I:STR)
           IF INSTRING('ComNumber', I:STR)
             COM_ = CLIP(SUB(I:STR, PosEq#+1, L#-PosEq#+1))
             IF SYS:COM_NR = 2 THEN
                ChangeINI = 1
             .
           ELSIF INSTRING('IpAddress', I:STR)
             IPAdrese = CLIP(SUB(I:STR, PosEq#+1, L#-PosEq#+1))
             IF SYS:COM_NR = 1 THEN
                ChangeINI = 1
             .
           ELSIF INSTRING('TcpPort', I:STR)
             TCPPorts = CLIP(SUB(I:STR, PosEq#+1, L#-PosEq#+1))
             IF SYS:COM_NR = 1 THEN
                ChangeINI = 1
             .
           ELSIF INSTRING('Password', I:STR)
             Parole = CLIP(SUB(I:STR, PosEq#+1, L#-PosEq#+1))
             IF SYS:COM_NR = 1 THEN
                ChangeINI = 1
             .
           .
        .
        CLOSE(INIFILE)
     .
     IF SYS:COM_NR = 1 THEN
        OPEN(Kon_screen)
        DISPLAY
        ACCEPT
           CASE FIELD()
           OF COM_
              IF ~ChangeINI = 2 THEN ChangeINI = 1.
           OF ?ButtonIzlNul_0
             IF EVENT()=EVENT:ACCEPTED
                IF IZLAISTNULLES
                   IZLAISTNULLES=''
                   HIDE(?IMAGEIZLNUL_0)
                ELSE
                   IZLAISTNULLES='1'
                   UNHIDE(?IMAGEIZLNUL_0)
                .
                DISPLAY
             .
           OF ?OkButton_0
             IF EVENT()=EVENT:ACCEPTED
                IF ~INRANGE(NOKL_CP,1,5)   !cenu tips
                   BEEP
                   SELECT(?NOKL_CP)
                   CYCLE
                .
                IF ChangeINI = 1 !vajag mainit
                   REMOVE(INIFILE)
                   IF ERRORCODE() THEN
                      kluda(1,'INIFILE')
                      CLOSE(INIFILE)
                      DO ProcedureReturn
                   .
                   CREATE(INIFILE)
                   CLOSE(INIFILE)
                .
                IF ChangeINI = 2 OR ChangeINI = 1 !jauns vai mainisanai
                   OPEN(INIFILE)
                   CLEAR(I:RECORD)
                   I:STR = '[ECR_1]'
                   ADD(INIFILE)
                   I:STR = 'ComNumber = '&COM_
                   ADD(INIFILE)
                .
                CLOSE(INIFILE)

                LOCALRESPONSE=REQUESTCOMPLETED
                BREAK
             .
           OF ?CANCELBUTTON_0
             IF EVENT()=EVENT:ACCEPTED
                LOCALRESPONSE=REQUESTCANCELLED
                BREAK
             .
           .
        .
        CLOSE(Kon_screen)
        IF LOCALRESPONSE=REQUESTCANCELLED
           DO PROCEDURERETURN
        .
     ELSE
        OPEN(Kon1_screen)
        DISPLAY
        ACCEPT
           CASE FIELD()
           OF Parole
              IF ~ChangeINI = 2 THEN ChangeINI = 1. !ja nejauns
           OF IPAdrese
              IF ~ChangeINI = 2 THEN ChangeINI = 1.
           OF TCPPorts
              IF ~ChangeINI = 2 THEN ChangeINI = 1.
           OF ?ButtonIzlNul_1
             IF EVENT()=EVENT:ACCEPTED
                IF IZLAISTNULLES
                   IZLAISTNULLES=''
                   HIDE(?IMAGEIZLNUL_1)
                ELSE
                   IZLAISTNULLES='1'
                   UNHIDE(?IMAGEIZLNUL_1)
                .
                DISPLAY
             .
           OF ?OkButton_1
             IF EVENT()=EVENT:ACCEPTED
                IF ~INRANGE(NOKL_CP,1,5)   !cenu tips
                   BEEP
                   SELECT(?NOKL_CP)
                   CYCLE
                .
                IF ChangeINI = 1 !vajag mainit
                   REMOVE(INIFILE)
                   IF ERRORCODE() THEN
                      kluda(1,'INIFILE')
                      CLOSE(INIFILE)
                      DO ProcedureReturn
                   .
                   CREATE(INIFILE)
                   CLOSE(INIFILE)
                .
                IF ChangeINI = 2 OR ChangeINI = 1 !jauns vai mainisanai
                   OPEN(INIFILE)
                   CLEAR(I:RECORD)
                   I:STR = '[ECR_1]'
                   ADD(INIFILE)
                   I:STR = 'IpAddress = '&CLIP(IPAdrese)
                   ADD(INIFILE)
                   I:STR = 'TcpPort = '&TcpPorts
                   ADD(INIFILE)
                   I:STR = 'Password = '&CLIP(Parole)
                   ADD(INIFILE)
                .
                CLOSE(INIFILE)

                LOCALRESPONSE=REQUESTCOMPLETED
                BREAK
             .
           OF ?CANCELBUTTON_1
             IF EVENT()=EVENT:ACCEPTED
                LOCALRESPONSE=REQUESTCANCELLED
                BREAK
             .
           .
        .
        CLOSE(Kon1_screen)
        IF LOCALRESPONSE=REQUESTCANCELLED
           DO PROCEDURERETURN
        .
     .

  OF '10'          ! TEC
  OROF '7'         ! CHD-4010
  OROF '17'        ! CHD-5010
  OROF '23'        ! CHD-3010T
  OROF '30'        ! CHD-3510T
  OROF '31'        ! CHD-5510T

     IF SYS:KASES_AP='17' OR SYS:KASES_AP='23' OR SYS:KASES_AP='30' OR SYS:KASES_AP='31'
        NODALA=50
     ELSE
        NODALA=20
     .
     CHECKOPEN(KONFIG,1)
     IF RECORDS(KONFIG)=0
        CLEAR(KFG:RECORD)
        KFG:COM=SYS:COM_NR
        KFG:BAUD=9600
        ADD(KONFIG)
     .
     SET(KONFIG)
     NEXT(KONFIG)
     OPEN(KONFIG_SCREEN)
     DISPLAY
     SELECT(?KFG:ECRADDR)
     ACCEPT
        CASE FIELD()
        OF ?ButtonIzlNul
           IF EVENT()=EVENT:ACCEPTED
              IF IZLAISTNULLES
                 IZLAISTNULLES=''
                 HIDE(?IMAGEIZLNUL)
              ELSE
                 IZLAISTNULLES='1'
                 UNHIDE(?IMAGEIZLNUL)
              .
              DISPLAY
           .
        OF ?OkButton
           IF EVENT()=EVENT:ACCEPTED
              IF ~INRANGE(NOKL_CP,1,5)
                 BEEP
                 SELECT(?NOKL_CP)
                 CYCLE
              .
              LOCALRESPONSE=REQUESTCOMPLETED
              BREAK
           .
        OF ?CANCELBUTTON
           IF EVENT()=EVENT:ACCEPTED
              LOCALRESPONSE=REQUESTCANCELLED
              BREAK
           .
        .
     .
     CLOSE(KONFIG_SCREEN)
     IF LOCALRESPONSE=REQUESTCANCELLED
        close(KONFIG)
        DO PROCEDURERETURN
     .
     PUT(KONFIG)
     close(KONFIG)
  OF   '1'         ! OMRON-3410'
!  OROF '2'         ! OMRON-3420'  Savâdâks komandu fails ?
  OROF '2'         ! OMRON-3420'
  OROF '3'         ! OMRON-3510'
  OROF '12'        ! OMRON-2810'
     CHECKOPEN(KOMANDA,1)
     IF RECORDS(KOMANDA)=0
        CLEAR(KMD:RECORD)
        ADD(KOMANDA)
     .
     SET(KOMANDA)
     NEXT(KOMANDA)
     KMD:KOMANDA=21
     KMD:FAILS  ='DATI.DBF'
     KMD:KLUDA  =0
     KMD:SK2    =1
     NODALA     =1
     OPEN(KOMANDA_SCREEN)
  !   SELECT(?KFG:ECRADDR)
     DISPLAY
     ACCEPT
        CASE FIELD()
        OF ?ButtonIzlNul1
           IF EVENT()=EVENT:ACCEPTED
              IF IZLAISTNULLES
                 IZLAISTNULLES=''
                 HIDE(?IMAGEIZLNUL1)
              ELSE
                 IZLAISTNULLES='1'
                 UNHIDE(?IMAGEIZLNUL1)
              .
              DISPLAY
           .
        OF ?OkButton1
           IF EVENT()=EVENT:ACCEPTED
              IF ~INRANGE(NOKL_CP,1,5)
                 BEEP
                 SELECT(?NOKL_CP)
                 CYCLE
              .
              LOCALRESPONSE=REQUESTCOMPLETED
              BREAK
           .
        OF ?CANCELBUTTON1
           IF EVENT()=EVENT:ACCEPTED
              LOCALRESPONSE=REQUESTCANCELLED
              BREAK
           .
        .
     .
     CLOSE(KOMANDA_SCREEN)
     IF LOCALRESPONSE=REQUESTCANCELLED
        close(KOMANDA)
        DO PROCEDURERETURN
     .
     PUT(KOMANDA)
     close(KOMANDA)
!   OF '2'         ! OMRON-3420'
!     CHECKOPEN(KOMANDAN,1)
!     IF RECORDS(KOMANDAN)=0
!        CLEAR(KMN:RECORD)
!        ADD(KOMANDAN)
!     .
!     SET(KOMANDAN)
!     NEXT(KOMANDAN)
!     KMN:KOMANDA=21
!     KMN:FAILS  ='DATI.DBF'
!     KMN:KLUDA  =0
!     KMN:SK2    =1
!     NODALA     =1
!     OPEN(KOMANDAN_SCREEN)
!!   SELECT(?KFG:ECRADDR)
!     DISPLAY
!     ACCEPT
!        CASE FIELD()
!        OF ?ButtonIzlNul1N
!           IF EVENT()=EVENT:ACCEPTED
!              IF IZLAISTNULLES
!                 IZLAISTNULLES=''
!                 HIDE(?IMAGEIZLNUL1)
!              ELSE
!                 IZLAISTNULLES='1'
!                 UNHIDE(?IMAGEIZLNUL1)
!              .
!              DISPLAY
!           .
!        OF ?OkButton1N
!           IF EVENT()=EVENT:ACCEPTED
!              IF ~INRANGE(NOKL_CP,1,5)
!                 BEEP
!                 SELECT(?NOKL_CP)
!                 CYCLE
!              .
!              LOCALRESPONSE=REQUESTCOMPLETED
!              BREAK
!           .
!        OF ?CANCELBUTTON1N
!           IF EVENT()=EVENT:ACCEPTED
!              LOCALRESPONSE=REQUESTCANCELLED
!              BREAK
!           .
!        .
!     .
!     CLOSE(KOMANDAN_SCREEN)
!     IF LOCALRESPONSE=REQUESTCANCELLED
!        close(KOMANDAN)
!        DO PROCEDURERETURN
!     .
!     PUT(KOMANDAN)
!     close(KOMANDAN)
  OF  '13'         ! BLUEBRIDGE
  OROF '14'        ! UNIWELL UX43
  OROF '15'        ! OPTIMA CR500
  OROF '18'        ! CASIO FE300
  OROF '25'        ! UNIWELL NX5400
     OPEN(PLU_SCREEN)
     IF SYS:KASES_AP='14' OR SYS:KASES_AP='25' THEN PLU_SCREEN{PROP:TEXT}='UNIWELL'.
     IF SYS:KASES_AP='15' THEN PLU_SCREEN{PROP:TEXT}='OPTIMA CR500'.
     IF SYS:KASES_AP='18' THEN PLU_SCREEN{PROP:TEXT}='CASIO FE300'.
     IF INSTRING(SYS:KASES_AP,'14151825',1,2) THEN HIDE(?BLUESOURCE).
     BLUESOURCE=1
     DISPLAY
     ACCEPT
        CASE FIELD()
        OF ?ButtonIzlNul2
           IF EVENT()=EVENT:ACCEPTED
              IF IZLAISTNULLES
                 IZLAISTNULLES=''
                 HIDE(?IMAGEIZLNUL2)
              ELSE
                 IZLAISTNULLES='1'
                 UNHIDE(?IMAGEIZLNUL2)
              .
              DISPLAY
           .
        OF ?OkButton2
           IF EVENT()=EVENT:ACCEPTED
              IF ~INRANGE(NOKL_CP,1,5)
                 BEEP
                 SELECT(?NOKL_CP)
                 CYCLE
              .
              LOCALRESPONSE=REQUESTCOMPLETED
              BREAK
           .
        OF ?CANCELBUTTON2
           IF EVENT()=EVENT:ACCEPTED
              LOCALRESPONSE=REQUESTCANCELLED
              BREAK
           .
        .
     .
     CLOSE(PLU_SCREEN)
     IF LOCALRESPONSE=REQUESTCANCELLED
        DO PROCEDURERETURN
     .
     PLUNAME ='\\KASE'&BLUESOURCE&'\MBOX\PLU.DBF'
     PROTNAME='\\KASE'&BLUESOURCE&'\MBOX\PROT.DBF'
     LOCKNAME='\\KASE'&BLUESOURCE&'\MBOX\LOCK.ECR'
     LOCKOKNAME='\\KASE'&BLUESOURCE&'\MBOX\LOCK.OK'
     ASCIINAME='\FE300P\PRO\PLU.TXTF'
     TNAME = '\plu.txt'
     IF SYS:KASES_AP='14' OR SYS:KASES_AP='25' ! UNIWELL
        FILENAME1= 'UZKASI.TXT'
     ELSE
        FILENAME1='PLU.DBF'
     .
  ELSE
     KLUDA(0,'KOMUNIKÂCIJA NAV IZSTRÂDÂTA')
     DO PROCEDURERETURN
  .

  OPEN(LoadSCREEN)
  ZUR:RECORD='--------------SEANSS : '& format(TODAY(),@d5) &' '& format(CLOCK(),@t1) &' ----------------'
  ADD(ZURNALS)
  DISPLAY

  CASE SYS:KASES_AP
  OF '10'          ! TEC
  OROF '1'         ! OMRON-3410
  OROF '2'         ! OMRON-3420
  OROF '3'         ! OMRON-3510
  OROF '12'        ! OMRON-2810
     CHECKOPEN(DATI,1)
     close(DATI)
     OPEN(DATI,18)
     IF ERROR()
       kluda(1,'DATI')
       DO ProcedureReturn
     .
     EMPTY(DATI)
  OF '7'           ! CHD-4010
  OROF '17'        ! CHD-5010
  OROF '23'        ! CHD-3010T
  OROF '30'        ! CHD-3510T
  OROF '31'        ! CHD-5510T
     CHECKOPEN(ACM,1)
     close(ACM)
     OPEN(ACM,18)
     IF ERROR()
       kluda(1,'ACM')
       DO ProcedureReturn
     .
     EMPTY(ACM)
  OF  '13'         ! BLUEBRIDGE
     IF DOS_CONT(LOCKNAME,2)
        KLUDA(0,'Kase aizòemta: atrasts fails '&lockname)
        DO ProcedureReturn
     ELSE
        CONVERTDBF(PLUNAME)
        CHECKOPEN(PLU,1)
        close(PLU)
        OPEN(PLU,18)
        IF ERROR()
           kluda(1,'PLU')
           DO ProcedureReturn
        .
        EMPTY(PLU)
!        RENAMEFILE(LOCKNAME,PCUSEDNAME)
        CONVERTDBF(PROTNAME)
        CHECKOPEN(PROT,1)
     .
  OF  '14'         ! UNIWELL
  OROF  '25'       ! UNIWELL 5400
     CHECKOPEN(UNIWELL,1)
     close(UNIWELL)
     OPEN(UNIWELL,18)
     IF ERROR()
       kluda(1,'UZKASI.TXT')
       DO PROCEDUREreturn
     .
     EMPTY(UNIWELL)
  OF  '15'         ! OPTIMA
     CHECKOPEN(OPTIMA,1)
     close(OPTIMA)
     OPEN(OPTIMA,18)
     IF ERROR()
       kluda(1,'PLU.DBF')
       DO PROCEDUREreturn
     .
     EMPTY(OPTIMA)
  OF '18'          ! CASIO FE300
     CHECKOPEN(ASCIIFILE,1)
     close(ASCIIFILE)
     OPEN(ASCIIFILE,18)
     IF ERROR()
       kluda(1,ASCIINAME)
       DO ProcedureReturn
     .
     EMPTY(ASCIIFILE)
  OF '32'          ! CHD 3320/5620
     CHECKOPEN(TFILE,1)
     close(TFILE)
     OPEN(TFILE,18)
     IF ERROR()
       kluda(1,TNAME)
       DO ProcedureReturn
     .
     EMPTY(TFILE)
  .

!----------------LASAM NOM_K-----------------
  clear(nom:record)
  SET(NOM:KOD_KEY,NOM:KOD_KEY)  ! TÂ DOMA IR TÂDA, KA DAUDZAS NOMENKLATÛRAS NEMAZ NAV JÂSÛTA UZ KA
  LOOP
     NEXT(NOM_K)
     IF ERROR() THEN BREAK.
     CASE NOM:STATUSS[LOC_NR]   ! DATU PÂRRAIDES VEIDS
     OF '3'                     ! NEKAS NAV JÂDARA
        CYCLE
     ELSE
        ID=NOM:STATUSS[LOC_NR]
     .
     IF IZLAISTNULLES AND GETNOM_A(NOM:NOMENKLAT,1,0,LOC_NR)<=0  THEN CYCLE. !NERAKSTÎT, JA NAV ATLIKUMA
     KODS = NOM:KODS
     IF NOM:KODS=0             ! ÐITAIS NEVAR NOSRTÂDÂT
        KLUDA(30,NOM:NOMENKLAT&' sk.Þurnâlu')
        ZUR:RECORD='KÏÛDA: ACM=0 '&NOM:NOMENKLAT
        ADD(ZURNALS)
        DISPLAY
        CYCLE
     .
     IF ~NOM:NOS_S
        NOSAUK = NOM:NOS_P !PA KREISI IZLÎDZINÂTS
     ELSE
        NOSAUK = NOM:NOS_S !PA KREISI IZLÎDZINÂTS
     .
     IF ~NOSAUK
        KLUDA(87,' Preces nosaukums '&NOM:NOMENKLAT&' sk.Þurnâlu')
        ZUR:RECORD='KÏÛDA: Nav norâdîts preces nosaukums '&NOM:NOMENKLAT
        ADD(ZURNALS)
        DISPLAY
        CYCLE
     .
!     IF NOM:PVN_PROC=21
!     IF NOM:PVN_PROC=22
     IF (NOM:PVN_PROC>17) AND (NOM:PVN_PROC<23)
        PVN =1               !22% KURÐ NO KASÇ IEVADÎTAJIEM PVN TIKS IZMANTOTS APRÇÍINÂ
     ELSIF NOM:PVN_PROC=9
        PVN =2               !9% KURÐ NO KASÇ IEVADÎTAJIEM PVN TIKS IZMANTOTS APRÇÍINÂ
!     ELSIF NOM:PVN_PROC=10
     ELSIF NOM:PVN_PROC=12
        PVN =3               !12% KURÐ NO KASÇ IEVADÎTAJIEM PVN TIKS IZMANTOTS APRÇÍINÂ
     ELSIF NOM:PVN_PROC=18
        PVN =4               !18% CIGARETÇM
     ELSE
        PVN =0               !0% KURÐ NO KASÇ IEVADÎTAJIEM PVN TIKS IZMANTOTS APRÇÍINÂ
     .
  !       DAT:SVARS                   !   NORÂDE UZ SVARA UZSKAITES VEIDU
  !       TARA                        !   PRECES TARAS VIENÎBU SKAITS
  !  stop(PVN)
     CENA = GETNOM_K(NOM:NOMENKLAT,0,7)*BANKURS(NOM:VAL[NOKL_CP],TODAY())
     IF CENA=0
        KLUDA(31,NOM:NOMENKLAT&' sk.Þurnâlu')
        ZUR:RECORD='KÏÛDA: CENA=0 '&NOM:NOMENKLAT&' '&NOM:KODS
        ADD(ZURNALS)
        CYCLE
     .
     ZUR:RECORD='R: KODS= '&KODS &' '&NOSAUK &' Ls '&CENA
     ADD(ZURNALS)
     DISPLAY
     CASE syS:KASES_AP
     OF '10'          ! TEK
     OROF '1'         ! OMRON-3410'
     OROF '2'         ! OMRON-3420'
     OROF '3'         ! OMRON-3510'
     OROF '12'        ! OMRON-2810'
        DO LOADDATI
     OF '7'           ! CHD-4010
     OROF '17'        ! CHD-5010
     OROF '23'        ! CHD-3010T
     OROF '3O'        ! CHD-3510T
     OROF '31'        ! CHD-5510T
        DO LOADACM
     OF '13'          ! BLUEBRIDGE
        DO LOADPLU
     OF '14'          ! OUNIWELL UX43
     OROF '25'        ! OUNIWELL NX5400
        DO LOADUNI
     OF '15'          ! OPTIMA CR500
        DO LOADOPT
     OF '18'          ! CASIO FE300
        DO LOADASCII
     OF '32'
        IF NOM:PVN_PROC=21
           PVN =1               !22% KURÐ NO KASÇ IEVADÎTAJIEM PVN TIKS IZMANTOTS APRÇÍINÂ
        ELSIF NOM:PVN_PROC=12
           PVN =2               !9% KURÐ NO KASÇ IEVADÎTAJIEM PVN TIKS IZMANTOTS APRÇÍINÂ
        ELSIF NOM:PVN_PROC=22
           PVN =3               !12% KURÐ NO KASÇ IEVADÎTAJIEM PVN TIKS IZMANTOTS APRÇÍINÂ
!        ELSIF NOM:PVN_PROC=18
!           PVN =4               !18% CIGARETÇM
        ELSE
           PVN =0               !0% KURÐ NO KASÇ IEVADÎTAJIEM PVN TIKS IZMANTOTS APRÇÍINÂ
        .
        DO LOADTFILE  ! CHD 3320/5620
     .
  .
  close(ACM)
  close(DATI)
  close(PLU)
  close(ASCIIFILE)
  close(TFILE)
  close(UNIWELL)
  close(OPTIMA)
  IF RAKSTI
     STATUSS1='Atrastas '&clip(RAKSTI)&' nomenklatûras, ko sûtît uz kases aparâtu'
     UNHIDE(?ok)
  ELSE
     STATUSS1='Nav atrasta neviena nosûtâma nomenklatûra'
  .
  UNHIDE(?CANCEL)
  DISPLAY
  soundfile='\WINLATS\BIN\Jungle Question.wav'
  sndPlaySoundA(soundfile,1)
  ACCEPT
     CASE FIELD()
     OF ?Ok
        IF EVENT()=EVENT:ACCEPTED
           LOCALRESPONSE=REQUESTCOMPLETED
           BREAK
        .
     OF ?CANCEL
        IF EVENT()=EVENT:ACCEPTED
           LOCALRESPONSE=REQUESTCANCELLED
           BREAK
        .
     .
  .
  IF SYS:KASES_AP='13' !BLUEBRIDGE
     ZUR:RECORD='Rakstu Þurnâlu '
     DISPLAY
     CLEAR(PRR:RECORD)
     PRR:ISSUED=CLIP(FORMAT(TODAY(),@D12))&FORMAT(CLOCK(),@T2)
     PRR:CMD='1'
     PRR:P2='plu.dbf'
     ADD(PROT)
     CLOSE(PROT)
!     RENAMEFILE(PCUSEDNAME,LOCKNAME)
     REMOVEFILE(LOCKOKNAME)
     LOCALRESPONSE=REQUESTCANCELLED
  .
  IF LOCALRESPONSE=REQUESTCANCELLED
     DO PROCEDURERETURN
  .
  HIDE(?ok)
  HIDE(?CANCEL)
  CASE SYS:KASES_AP
  OF '1'         ! OMRON-3410'
     run('\WINLATS\BIN\AI3410.exe KOMANDA.DBF')
  OF '2'         ! OMRON-3420'
!     run('\WINLATS\BIN\AI3420.exe KOMANDA.DBF')
     run('AI3420.BAT')
  OF '3'         ! OMRON-3510'
     run('\WINLATS\BIN\AI35.exe KOMANDA.DBF')
  OF '12'        ! OMRON-2810'
     run('\WINLATS\BIN\AI2810.exe KOMANDA.DBF')
  OF '10'          ! TEC
     CASE DN
     OF 'D'
        run('\WINLATS\BIN\TEC1650.exe 21 DATI.DBF')
     ELSE
        run('\WINLATS\BIN\TEC1650.exe 41 DATI.DBF')
     .
  OF '7'          ! CHD-4010
     CASE DN
     OF 'D'
        run('\WINLATS\BIN\4010COMM.exe 21 ACM.DBF')
     ELSE
        run('\WINLATS\BIN\4010COMM.exe 41 ACM.DBF')
     .
  OF '14'         ! UNIWELL UX43
!     run('\WINLATS\BIN\uniwell.exe /wPLU uzkasi.txt')
     run('PLU43.BAT '&CLIP(LOC_NR))
  OF '15'         ! OPTIMA CR500
!     run(COMMAND('COMSPEC',0) & ' /C ' & '\WINLATS\BIN\SEND.BAT')
     run('\WINLATS\BIN\SEND.BAT')
  OF '17'         ! CHD-5010
  OROF '23'       ! CHD-3010T
  OROF '30'       ! CHD-3510T
  OROF '31'       ! CHD-5510T
     CASE DN
     OF 'D'
        IF vers[1]<7
           run('\WINLATS\BIN\CHD_DRV.exe 21 ACM.DBF')
        ELSE
           run('CHD_DRV.exe 21 ACM.DBF')
        .
     ELSE
        IF vers[1]<7
           run('\WINLATS\BIN\CHD_DRV.exe 41 ACM.DBF')
        ELSE
           run('CHD_DRV.exe 41 ACM.DBF')
        .
     .
  OF '32'       ! CHD 3320/5620 Elya
     CASE DN
     OF 'D'
        !run('\WINLATS\BIN\SDRV.exe ClearAndSend 3 PLU.TXT')
        run('chd5620c.bat')
     ELSE
        !run('\WINLATS\BIN\SDRV.exe Send 3 PLU.TXT')
        run('chd5620.bat')
     .
  OF '18'        ! CASIO FE300
     run('\FE300P\PRO\FE300.EXE')
  OF '25'        ! UNIWELL NX5400
     run('PLU.BAT '&CLIP(LOC_NR))
  .
  IF RUNCODE()
     IF RUNCODE()=-4
        IF SYS:KASES_AP='15'
           KLUDA(120,'\WINLATS\BIN\SEND.BAT')
        ELSIF SYS:KASES_AP='18'
           KLUDA(120,'\FE300P\PRO\FE300.EXE')
        ELSIF SYS:KASES_AP='32'  !Elya
           KLUDA(120,'\WINLATS\BIN\SDRV.exe')
        ELSE
           IF vers[1]<7
              KLUDA(120,'\WINLATS\BIN\CHD_DRV.exe')
           ELSE
              KLUDA(120,CLIP(LONGPATH())&'\CHD_DRV.exe')
           .
        .
     .
     ZUR:RECORD='KÏÛDA IZSAUCOT APMAIÒAS PROGRAMMU: RC='&CLIP(RUNCODE())&' '&ERROR()
     ADD(ZURNALS)
     STATUSS1='Apmaiòas programmas kïûda ...'
  ELSE
     CLEAR(ZUR:RECORD)
     CONVERTDBF('KOMANDA.DBF')
     CONVERTDBF('KONFIG.DBF')
     CONVERTDBF('DATI.DBF')
     CONVERTDBF('PLU.DBF')
     STATUSS1='Apmaiòas programma darbu beigusi ...'
     UNHIDE(?ok)
     ?OK{PROP:TEXT}='Sûtîjums veiksmîgs'
  .
  UNHIDE(?CANCEL)
  ?CANCEL{PROP:TEXT}='Sûtîjums nav veiksmîgs'
  DISPLAY
  soundfile='\WINLATS\BIN\Jungle Question.wav'
  sndPlaySoundA(soundfile,1)
  ACCEPT
     CASE FIELD()
     OF ?Ok
        IF EVENT()=EVENT:ACCEPTED
           LOCALRESPONSE=REQUESTCOMPLETED
           BREAK
        .
     OF ?CANCEL
        IF EVENT()=EVENT:ACCEPTED
           LOCALRESPONSE=REQUESTCANCELLED
           BREAK
        .
     .
  .
  IF LOCALRESPONSE=REQUESTCANCELLED
     CLOSE(LoadSCREEN)
     DO PROCEDURERETURN
  .
  ZUR:RECORD='Mainu KA statusu NOM_K ...'
  HIDE(?ok)
  HIDE(?CANCEL)
  DISPLAY

  CLEAR(NOM:RECORD)
  SET(NOM:KOD_KEY,NOM:KOD_KEY)
  LOOP
     NEXT(NOM_K)
     IF ERROR() THEN BREAK.
     IF IZLAISTNULLES AND GETNOM_A(NOM:NOMENKLAT,1,0,LOC_NR)<=0  THEN CYCLE. !NEAPSTRÂDÂJAM 0-ES, JA BIJA JÂIZLAIÞ
     IF NOM:STATUSS[LOC_NR]<'3'
        NOM:STATUSS[LOC_NR]='3'
        IF RIUPDATE:NOM_K()
           KLUDA(26,'NOM_K')
        ELSE
           I#+=1
           STATUSS1=I#
           DISPLAY
        .
     .
  .
  CLOSE(LoadSCREEN)
  DO PROCEDURERETURN

!---------------------------------------------------------------------------------------------
LOADDATI      ROUTINE
   CLEAR(DAT:RECORD)
   DAT:KODS  =KODS
   DAT:NOSAUK=NOSAUK
   DAT:PVN   =PVN
   DAT:NODALA=NODALA          !   NODAÏA ZEM KURAS TIKS PÂRDOTA PRECE
   DAT:CENA  =CENA
   CASE syS:KASES_AP
   OF '1'           ! OMRON-3410'
   OROF '2'         ! OMRON-3420'
   OROF '3'         ! OMRON-3510'
   OROF '12'        ! OMRON-2810'
      DAT:ID=ID
   .
   ADD(DATI)
   IF ERROR()
      KLUDA(24,'DATI')
      IF ~KLU_DARBIBA
         DO PROCEDURERETURN
      .
   ELSE
      RAKSTI+=1
   .
!---------------------------------------------------------------------------------------------
LOADACM      ROUTINE
   CLEAR(ACM:RECORD)
   ACM:KODS  =KODS
   ACM:NOSAUK=NOSAUK
   ACM:PVN   =PVN
   ACM:NODALA=NODALA          !   NODAÏA ZEM KURAS TIKS PÂRDOTA PRECE
   ACM:CENA  =CENA
   ADD(ACM)
   IF ERROR()
      KLUDA(24,'ACM')
      IF ~KLU_DARBIBA
         DO PROCEDURERETURN
      .
   ELSE
      RAKSTI+=1
   .
!---------------------------------------------------------------------------------------------
LOADPLU      ROUTINE
   CLEAR(PLU:RECORD)
!!   PLU:Code      = FORMAT(KODS,@N_13)
   PLU:Code      = LEFT(KODS)
!!   PLU:Code[13]  = ' '
   PLU:Descr     = NOSAUK
   PLU:Price     = FORMAT(CENA,@N_10.3)
   CASE NOM:MERVIEN
   OF 'm.'
      PLU:Unit   = '1'
   OF 'KOMPL.'
      PLU:Unit   = '2'
   OF 'iepak.'
      PLU:Unit   = '3'
   OF 'kg.'
      PLU:Unit   = '4'
   OF 'stundas'
      PLU:Unit   = '5'
   OF 'litri'
      PLU:Unit   = '6'
   OF 'pac.'
      PLU:Unit   = '7'
   OF 'kub.m.'
      PLU:Unit   = '8'
   OF 'kv.m.'
      PLU:Unit   = '9'
   OF 'tek.m.'
      PLU:Unit   = '10'
   OF 't.'
      PLU:Unit   = '11'
   OF 'loksne'
      PLU:Unit   = '12'
   OF 'gab.'
      PLU:Unit   = '13'
   OF 'rullis'
      PLU:Unit   = '14'
   OF 'M'
      PLU:Unit   = '15'
   ELSE
      PLU:Unit   = '16'
   .
!   PVN =1               !21%
!   PVN =2               !9%
!   PVN =3               !10%
!   PVN =0               !0%
!   PVN =4               !18%
   PLU:Tax      = PVN
   PLU:Active              = '1'
   PLU:Load                = '1'
   ADD(PLU)
   IF ERROR()
      KLUDA(24,'PLU')
      IF ~KLU_DARBIBA
         DO PROCEDURERETURN
      .
   ELSE
      RAKSTI+=1
   .

!---------------------------------------------------------------------------------------------
LOADASCII      ROUTINE
   CLEAR(A:RECORD)
   A:KODS   =FORMAT(KODS,@N013)
   A:KOMATS1=','
   A:CENA   = FORMAT(CENA*100,@N08)
   A:KOMATS2=','
   A:NOSAUK ='"'&NOSAUK[1:14]&'"'
   A:KOMATS3=','
   A:D1     ='"01"'
   A:KOMATS4=','
   A:D2     ='00'
   A:KOMATS5=','
   EXECUTE PVN+1
      A:PVN ='"03"'              ! 0%PVN
      A:PVN ='"01"'              ! 22/21%PVN
      A:PVN ='"02"'              ! 9%PVN
      A:PVN ='"04"'              ! 12/10%PVN
      A:PVN ='"05"'              ! 18%PVN CIGARETÇM ??
   .
   A:KOMATS6=','
   A:SKAITS =0
   ADD(ASCIIFILE)
   IF ERROR()
      KLUDA(24,'PLU.TXT')
      IF ~KLU_DARBIBA
         DO PROCEDURERETURN
      .
   ELSE
      RAKSTI+=1
   .
!---------------------------------------------------------------------------------------------
! Elya CHD 3320/5620
LOADTFILE      ROUTINE
   CLEAR(T:RECORD)
   T:KODS   =FORMAT(KODS,@N013)
   T:KOMATS1=','
   T:NOSAUK ='"'&NOSAUK[1:20]&'"'
   T:KOMATS2=','
   T:CENA   = FORMAT(CENA,@N10.2)
   T:KOMATS3=','
   T:CENA1   = FORMAT(0,@N10.2)
   T:KOMATS4=','
   T:CENA2   = FORMAT(0,@N10.2)
   T:KOMATS5=','
   T:PVN     = PVN
   T:KOMATS6=','
   T:NODALA  = NODALA
   T:KOMATS7=','
   T:D1      = 0
   T:KOMATS8=','
   T:NegItem = 0
   T:KOMATS9=','
   T:NulCena = 0
!   T:KOMATS10=','
!Optional fields
!PrecGr           STRING(4)               !1 … Preces grupa, 0 - nav grupas (pec noklusejuma)
!KOMATS11         STRING(1)               !KOMATS
!LielakCena       STRING(1)               !0 - disabled, 1 - enabled
!KOMATS12         STRING(1)               !KOMATS
!DaudzOblig       STRING(1)               !0 - disabled, 1 - enabled
   ADD(TFILE)
   IF ERROR()
      KLUDA(24,'PLU.TXT')
      IF ~KLU_DARBIBA
         DO PROCEDURERETURN
      .
   ELSE
      RAKSTI+=1
   .

!---------------------------------------------------------------------------------------------
LOADUNI      ROUTINE
!   CLEAR(UNI:RECORD)
   UNI:DRAZA='00000'
   UNI:NUL1 = '0'
   UNI:NUL2 = '0'
   UNI:NUL3 = '0'
   UNI:NUL4 = '0'
   UNI:NUL5 = '0'
   UNI:NUL6 = '00'
   UNI:NUL7 = '00'
   UNI:NUL8 = '000'
   UNI:VIE1 = '1'
   UNI:VIE2 = '1'
   UNI:VIE3 = '1'
   UNI:VIE4 = '1'
   UNI:C98  = '98'
   UNI:AP   = '01'
   UNI:TAB1 = CHR(9)
   UNI:TAB2 = CHR(9)
   UNI:TAB3 = CHR(9)
   UNI:TAB4 = CHR(9)
   UNI:TAB5 = CHR(9)
   UNI:TAB6 = CHR(9)
   UNI:TAB7 = CHR(9)
   UNI:TAB8 = CHR(9)
   UNI:TAB9 = CHR(9)
   UNI:TAB10= CHR(9)
   UNI:TAB11= CHR(9)
   UNI:TAB12= CHR(9)
   UNI:TAB13= CHR(9)
   UNI:TAB14= CHR(9)
   UNI:TAB15= CHR(9)
   UNI:TAB16= CHR(9)
   UNI:TAB17= CHR(9)
   UNI:TAB18= CHR(9)
   UNI:TAB19= CHR(9)
   UNI:KODS_ACM = FORMAT(NOM:KODS,@N013)
   UNI:NOSAUK = NOSAUK
   CASE NOM:PVN_PROC
!   of 18
!   of 21
   of 22
      UNI:PVN ='0'               ! 22/21% KURÐ NO KASð IEVADÎTAJIEM PVN TIKS IZMANTOTS APRÇÍINÂ
   else
      UNI:PVN ='4'               ! 0% KURÐ NO KASð IEVADÎTAJIEM PVN TIKS IZMANTOTS APRÇÍINÂ
   .
   UNI:CENA=FORMAT(CENA*100,@N08)    ! PÂRDODAMÂS PRECES CENA
   UNI:CENA2=UNI:CENA            ! PÂRDODAMÂS PRECES 2.CENA
   UNI:ATLIK='00000.000'
   ADD(UNIWELL)
   IF ERROR()
      KLUDA(24,'UZKASI.TXT')
      DO PROCEDURERETURN
   ELSE
      RAKSTI+=1
   .

!---------------------------------------------------------------------------------------------
LOADOPT      ROUTINE
   CLEAR(OPT:RECORD)
   OPT:F1 = 0
   OPT:F2 = NOM:KODS
   OPT:F3 = NOSAUK
   OPT:F4 = PVN
   OPT:F5 = CENA*100
   OPT:F6 = 0
   OPT:F7 = 0
   ADD(OPTIMA)
   IF ERROR()
      KLUDA(24,'PLU.DBF')
      DO PROCEDURERETURN
   ELSE
      RAKSTI+=1
   .

!---------------------------------------------------------------------------------------------
PROCEDURERETURN    ROUTINE
  CLOSE(LoadSCREEN)
  CASE SYS:KASES_AP
  OF '10'          ! TEC
     CLOSE(DATI)
  OF '7'           ! CHD-4010
  OROF '17'        ! CHD-5010
  OROF '23'        ! CHD-3010T
     CLOSE(ACM)
  .
  CLOSE(ZURNALS)
  DZNAME='DZ'&FORMAT(JOB_NR,@N02)
  CHECKOPEN(ZURNALS,1)
  NOLIK::USED-=1
  IF NOLIK::USED=0
     CLOSE(NOLIK)
  .
  NOM_K::USED-=1
  IF NOM_K::USED=0
     CLOSE(NOM_K)
  .
  RETURN




OMIT('MARIS')


MARIS

UpdateSystem_AutoKont PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
BKK_AP               STRING(5)
BKK_AP1              STRING(5)
BKK_AP2              STRING(5)
BKK_AP3              STRING(5)
BKK_AP4              STRING(5)
OKK_PR               STRING(5)
OKK_PR1              STRING(5)
OKK_PR2              STRING(5)
OKK_PR3              STRING(5)
OKK_TA               STRING(5)
OKK_TA1              STRING(5)
OKK_TA2              STRING(5)
OKK_TA3              STRING(5)
BKK_PR               STRING(5)
BKK_PR1              STRING(5)
BKK_TA               STRING(5)
BKK_TA1              STRING(5)
BKK_KA               STRING(5)
OKK_KTR              STRING(5)
OKK_KTR1             STRING(5)
OKK_KTR2             STRING(5)
OKK_KTR3             STRING(5)
nol_tips             STRING(30)
Update::Reloop  BYTE
Update::Error   BYTE
History::SYS:Record LIKE(SYS:Record),STATIC
SAV::SYS:Record      LIKE(SYS:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Autokontçjuma  algoritmi'),AT(,,393,233),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP(' '),CURSOR(CURSOR:None),GRAY,RESIZE
                       SHEET,AT(5,12,383,178),USE(?CurrentTab)
                         TAB('Realizâcija'),USE(?Tab:3)
                           LINE,AT(207,181,0,-143),USE(?Line9),COLOR(COLOR:Black)
                           STRING('Debitori/Kreditori'),AT(127,43),USE(?String19),FONT(,9,,FONT:bold)
                           STRING('PVN'),AT(226,40),USE(?String19:2),FONT(,9,,FONT:bold)
                           STRING('Ieòçmumi'),AT(302,40),USE(?String19:3),FONT(,9,,FONT:bold)
                           STRING('Priekðapmaksa'),AT(19,61,77,10),USE(?String1:3),LEFT,FONT(,9,,FONT:bold)
                           STRING('D521* vai D231*'),AT(107,61,58,10),USE(?String4),LEFT
                           ENTRY(@s5),AT(166,61,36,10),USE(SYS:K_DK_PRI),FONT(,,,FONT:bold)
                           PROMPT('Prece K611*'),AT(277,61,49,10),USE(?SYS:BKK_PR:Prompt),LEFT
                           ENTRY(@s5),AT(351,61,26,10),USE(SYS:K_PR),FONT(,,,FONT:bold)
                           STRING('(Summa bez PVN)'),AT(143,73),USE(?StringSbezPVN)
                           BUTTON('Saòemot naudu'),AT(209,59,56,14),USE(?ButtonPVN_KP)
                           PROMPT('Tara K611*'),AT(277,72,44,10),USE(?SYS:BKK_TA:Prompt),LEFT
                           ENTRY(@s5),AT(351,73,26,10),USE(SYS:K_TA),FONT(,,,FONT:bold)
                           LINE,AT(15,90,252,0),USE(?Line6),COLOR(COLOR:Black)
                           LINE,AT(15,53,363,0),USE(?Line5),COLOR(COLOR:Black)
                           PROMPT('Transports K611*'),AT(277,108,62,10),USE(?SYS:OKK_DTR:Prompt),LEFT
                           ENTRY(@s5),AT(351,107,26,10),USE(SYS:K_TR),FONT(,,,FONT:bold)
                           STRING('Konsignâcija/Pçcapmaksa'),AT(19,104,91,10),USE(?String1:4),LEFT,FONT(,8,,FONT:bold)
                           STRING('D231*'),AT(139,104,25,10),USE(?String4:2),LEFT
                           ENTRY(@s5),AT(166,104,36,10),USE(SYS:K_DK_PEC),FONT(,,,FONT:bold)
                           ENTRY(@s5),AT(218,104,36,10),USE(SYS:K_PVN)
                           STRING('Pakalpojumi'),AT(277,96),USE(?String24)
                           ENTRY(@s5),AT(351,96,26,10),USE(SYS:K_PA)
                           STRING('Kokmateriâli'),AT(277,85),USE(?String25)
                           ENTRY(@s5),AT(351,85,26,10),USE(SYS:K_KO)
                           LINE,AT(15,125,252,0),USE(?Line7),COLOR(COLOR:Black)
                           STRING('Subkonts (5.cip./burts) ES :'),AT(270,121),USE(?String31),FONT(,,COLOR:Red,,CHARSET:ANSI)
                           ENTRY(@s1),AT(365,121,12,10),USE(SYS:SUB_ES),CENTER,MSG('SUBKONTS ES')
                           STRING('Apmaksa uzreiz'),AT(19,144,54,10),USE(?String1:5),LEFT,FONT(,8,,FONT:bold)
                           PROMPT('Kase D261* vai D231*'),AT(85,144,80,10),USE(?SYS:BKK_DU:Prompt)
                           ENTRY(@s5),AT(166,144,36,10),USE(SYS:K_DK_UKA),FONT(,,,FONT:bold)
                           STRING(@s5),AT(223,144,24,10),USE(SYS:K_PVN,,?SYS:K_PVN:2)
                           LINE,AT(267,37,0,142),USE(?Line8),COLOR(COLOR:Black)
                           STRING(@s5),AT(223,157,24,10),USE(SYS:K_PVN,,?SYS:K_PVN:3)
                         END
                         TAB('Saòemta prece'),USE(?Tab:4)
                           LINE,AT(211,182,0,-142),USE(?Line10),COLOR(COLOR:Black)
                           STRING('Debitori/Kreditori'),AT(127,43),USE(?String19:4),FONT(,9,,FONT:bold)
                           STRING('PVN'),AT(226,40),USE(?String19:5),FONT(,9,,FONT:bold)
                           STRING('Summa bez PVN'),AT(302,40),USE(?String19:6),FONT(,9,,FONT:bold)
                           LINE,AT(15,53,363,0),USE(?Line2),COLOR(COLOR:Black)
                           STRING('Priekðapmaksa'),AT(19,61,77,10),USE(?String1:31),LEFT,FONT(,8,,FONT:bold)
                           STRING('K219* vai K531*'),AT(107,61,58,10),USE(?String41),LEFT
                           ENTRY(@s5),AT(166,61,36,10),USE(SYS:D_DK_PRI)
                           ENTRY(@s5),AT(343,61,36,10),USE(SYS:D_PR)
                           BUTTON('ES:nekontçt'),AT(214,72,50,14),USE(?ButtonES2PVN)
                           ENTRY(@s5),AT(343,72,36,10),USE(SYS:D_TA)
                           LINE,AT(267,90,-252,0),USE(?Line3),COLOR(COLOR:Black)
                           ENTRY(@s5),AT(221,60,36,10),USE(SYS:D_PVN_PRI)
                           ENTRY(@s5),AT(343,108,36,10),USE(SYS:D_TR)
                           STRING('K5721.'),AT(235,123),USE(?String26:2)
                           STRING('Konsignâcija/Pçcapmaksa'),AT(19,99,91,10),USE(?String1:41),LEFT,FONT(,8,,FONT:bold)
                           PROMPT('Tara D213**'),AT(277,72,47,10),USE(?SYS:BKK_TA:Prompt1)
                           ENTRY(@s5),AT(221,99,36,10),USE(SYS:D_PVN_PEC)
                           STRING('Kokmateriâli'),AT(277,84),USE(?String29)
                           ENTRY(@s5),AT(342,84,36,10),USE(SYS:D_KO)
                           LINE,AT(267,139,-251,0),USE(?Line4),COLOR(COLOR:Black)
                           STRING('Pakalpojumi'),AT(277,96),USE(?String28)
                           ENTRY(@s5),AT(342,96,36,10),USE(SYS:D_PA)
                           STRING('ES: D5721.'),AT(221,113),USE(?String26)
                           STRING('K531*'),AT(139,99,25,10),USE(?String4:21),LEFT
                           ENTRY(@s5),AT(166,99,36,10),USE(SYS:D_DK_PEC)
                           PROMPT('Transports D762**'),AT(277,108,65,10),USE(?SYS:OKK_DTR:Prompt1)
                           STRING('Apmaksa uzreiz'),AT(19,151,54,10),USE(?String1:51),LEFT,FONT(,8,,FONT:bold)
                           PROMPT('KASE K261* vai K531*'),AT(85,151,80,10),USE(?SYS:BKK_DU:Prompt1)
                           ENTRY(@s5),AT(166,151,36,10),USE(SYS:D_DK_UKA)
                           PROMPT('Prece D213**'),AT(277,61,49,10),USE(?SYS:BKK_PR:Prompt1)
                           STRING(@s5),AT(226,151),USE(SYS:D_PVN_PRI,,?SYS:BKK_AP:2),LEFT
                           STRING(@s5),AT(226,163),USE(SYS:D_PVN_PRI,,?SYS:BKK_AP:3),LEFT
                           LINE,AT(267,37,0,142),USE(?Line1),COLOR(COLOR:Black)
                         END
                       END
                       STRING(@s30),AT(171,12),USE(nol_tips)
                       OPTION('Atgrieztu preci (- zîme) kontçt'),AT(5,193,117,33),USE(SYS:CONTROL_BYTE),BOXED
                         RADIO(' ar + zîmi, mainot D un K'),AT(9,204),USE(?Option1:Radio1),VALUE('0')
                         RADIO(' ar - zîmi'),AT(9,212),USE(?Option1:Radio2),DISABLE,VALUE('1')
                       END
                       BUTTON('&OK'),AT(285,211,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(338,211,45,14),USE(?Cancel)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
    LocalRequest = CHANGERECORD
    OriginalRequest = CHANGERECORD
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  IF BAND(SYS:BAITS1,00000100B) !Vairumtirdzniecîba
     NOL_TIPS='Vairumtirdzniecîbas noliktava'
  ELSE
     NOL_TIPS='Mazumtirdzniecîbas noliktava'
  .
  IF BAND(SYS:BAITS1,00000001B)
     ?BUTTONPVN_KP{PROP:TEXT}='K23990'
     ?StringSbezPVN{PROP:TEXT}='(Summa ar PVN)'
  .
  IF BAND(SYS:BAITS1,00000010B)
     ?BUTTONES2PVN{PROP:TEXT}='ES:DK5721.'
  .
  
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
  END
  QuickWindow{Prop:Text} = ActionMessage
  ENABLE(TBarBrwHistory)
  ACCEPT
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE() = 734 THEN
        DO HistoryField
      END
    OF EVENT:CloseWindow
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
    OF EVENT:CloseDown
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?Line9)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF EVENT:Moved
      GETPOSITION(0,WindowXPos,WindowYPos)
    OF EVENT:Sized
      WinResize.Resize
      ForceRefresh = True
      DO RefreshWindow
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF ACCEPTED() = TbarBrwHistory
        DO HistoryField
      END
      IF EVENT() = Event:Completed
        History::SYS:Record = SYS:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(SYSTEM)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(SYS:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'SYS:NR_KEY')
                SELECT(?Line9)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?Line9)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::SYS:Record <> SYS:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:SYSTEM(1)
            ELSE
              Update::Error = 0
            END
            SETCURSOR()
            IF Update::Error THEN
              IF Update::Error = 1 THEN
                CASE StandardWarning(Warn:UpdateError)
                OF Button:Yes
                  CYCLE
                OF Button:No
                  POST(Event:CloseWindow)
                  BREAK
                END
              END
              DISPLAY
              SELECT(?Line9)
              VCRRequest = VCRNone
            ELSE
              IF RecordChanged OR VCRRequest = VCRNone THEN
                LocalResponse = RequestCompleted
              END
              POST(Event:CloseWindow)
            END
            BREAK
          END
        END
      END
      IF ToolbarMode = FormMode THEN
        CASE ACCEPTED()
        OF TBarBrwBottom TO TBarBrwUp
        OROF TBarBrwInsert
          VCRRequest=ACCEPTED()
          POST(EVENT:Completed)
        OF TBarBrwHelp
          PRESSKEY(F1Key)
        END
      END
    END
    CASE FIELD()
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
          !Code to assign button control based upon current tab selection
          CASE CHOICE(?CurrentTab)
          OF 1
            DO FORM::AssignButtons
          OF 2
          OF 3
          OF 4
          OF 5
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?SYS:K_DK_PRI
      CASE EVENT()
      OF EVENT:Accepted
        SYS:K_DK_PRI = GETKON_K(SYS:K_DK_PRI,1,1)
        DISPLAY
      END
    OF ?SYS:K_PR
      CASE EVENT()
      OF EVENT:Accepted
        SYS:K_PR = GETKON_K(SYS:K_PR,1,1) !LAI ÐITAS STRÂDÂTU, JÂBÛT MDI LOGAM...
        DISPLAY
      END
    OF ?ButtonPVN_KP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(SYS:BAITS1,00000001B)
           SYS:BAITS1-=1
           ?BUTTONPVN_KP{PROP:TEXT}='Saòemot naudu'
           ?StringSbezPVN{PROP:TEXT}='(Summa bez PVN)'
        ELSE
           SYS:BAITS1+=1
           ?BUTTONPVN_KP{PROP:TEXT}='K23990'
           ?StringSbezPVN{PROP:TEXT}='(Summa ar PVN)'
        .
        DISPLAY
      END
    OF ?SYS:K_TA
      CASE EVENT()
      OF EVENT:Accepted
        SYS:K_TA = GETKON_K(SYS:K_TA,1,1)
        DISPLAY
      END
    OF ?SYS:K_TR
      CASE EVENT()
      OF EVENT:Accepted
        SYS:K_TR = GETKON_K(SYS:K_TR,1,1)
        DISPLAY
      END
    OF ?SYS:K_DK_PEC
      CASE EVENT()
      OF EVENT:Accepted
        SYS:K_DK_PEC = GETKON_K(SYS:K_DK_PEC,1,1)
        DISPLAY
      END
    OF ?SYS:K_PVN
      CASE EVENT()
      OF EVENT:Accepted
        SYS:K_PVN = GETKON_K(SYS:K_PVN,1,1)
        DISPLAY
      END
    OF ?SYS:K_PA
      CASE EVENT()
      OF EVENT:Accepted
        SYS:K_PA = GETKON_K(SYS:K_PA,1,1)
        DISPLAY
      END
    OF ?SYS:K_KO
      CASE EVENT()
      OF EVENT:Accepted
        SYS:K_KO = GETKON_K(SYS:K_KO,1,1)
        DISPLAY
      END
    OF ?SYS:K_DK_UKA
      CASE EVENT()
      OF EVENT:Accepted
        SYS:K_DK_UKA = GETKON_K(SYS:K_DK_UKA,1,1)
        DISPLAY
      END
    OF ?SYS:D_DK_PRI
      CASE EVENT()
      OF EVENT:Accepted
        SYS:D_DK_PRI = GETKON_K(SYS:D_DK_PRI,1,1)
        DISPLAY
      END
    OF ?SYS:D_PR
      CASE EVENT()
      OF EVENT:Accepted
        SYS:D_PR = GETKON_K(SYS:D_PR,1,1)
        DISPLAY
      END
    OF ?ButtonES2PVN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(SYS:BAITS1,00000010B)
           SYS:BAITS1-=2
           ?BUTTONES2PVN{PROP:TEXT}='ES:nekontçt'
        ELSE
           SYS:BAITS1+=2
           ?BUTTONES2PVN{PROP:TEXT}='ES:DK5721.'
        .
        DISPLAY                                               
      END
    OF ?SYS:D_TA
      CASE EVENT()
      OF EVENT:Accepted
        SYS:D_TA = GETKON_K(SYS:D_TA,1,1)
        DISPLAY
      END
    OF ?SYS:D_PVN_PRI
      CASE EVENT()
      OF EVENT:Accepted
        SYS:D_PVN_PRI = GETKON_K(SYS:D_PVN_PRI,1,1)
        DISPLAY
      END
    OF ?SYS:D_TR
      CASE EVENT()
      OF EVENT:Accepted
        SYS:D_TR = GETKON_K(SYS:D_TR,1,1)
        DISPLAY
      END
    OF ?SYS:D_PVN_PEC
      CASE EVENT()
      OF EVENT:Accepted
        SYS:D_PVN_PEC = GETKON_K(SYS:D_PVN_PEC,1,1)
        DISPLAY
      END
    OF ?SYS:D_KO
      CASE EVENT()
      OF EVENT:Accepted
        SYS:D_KO = GETKON_K(SYS:D_KO,1,1) !LAI ÐITAS STRÂDÂTU, JÂBÛT MDI LOGAM...
        DISPLAY
      END
    OF ?SYS:D_PA
      CASE EVENT()
      OF EVENT:Accepted
        SYS:D_PA = GETKON_K(SYS:D_PA,1,1)
        DISPLAY
      END
    OF ?SYS:D_DK_PEC
      CASE EVENT()
      OF EVENT:Accepted
        SYS:D_DK_PEC = GETKON_K(SYS:D_DK_PEC,1,1)
        DISPLAY
      END
    OF ?SYS:D_DK_UKA
      CASE EVENT()
      OF EVENT:Accepted
        SYS:D_DK_UKA = GETKON_K(SYS:D_DK_UKA,1,1)
        DISPLAY
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        VCRRequest = VCRNone
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF SYSTEM::Used = 0
    CheckOpen(SYSTEM,1)
  END
  SYSTEM::Used += 1
  BIND(SYS:RECORD)
  FilesOpened = True
  RISnap:SYSTEM
  SAV::SYS:Record = SYS:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:SYSTEM()
          SETCURSOR()
          CASE StandardWarning(Warn:DeleteError)
          OF Button:Yes
            CYCLE
          OF Button:No OROF Button:Cancel
            BREAK
          END
        ELSE
          SETCURSOR()
          LocalResponse = RequestCompleted
        END
        BREAK
      END
    END
    DO ProcedureReturn
  END
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  IF WindowPosInit THEN
    SETPOSITION(0,WindowXPos,WindowYPos)
  ELSE
    GETPOSITION(0,WindowXPos,WindowYPos)
    WindowPosInit=True
  END
  ?SYS:K_DK_PRI{PROP:Alrt,255} = 734
  ?SYS:K_PR{PROP:Alrt,255} = 734
  ?SYS:K_TA{PROP:Alrt,255} = 734
  ?SYS:K_TR{PROP:Alrt,255} = 734
  ?SYS:K_DK_PEC{PROP:Alrt,255} = 734
  ?SYS:K_PVN{PROP:Alrt,255} = 734
  ?SYS:K_PA{PROP:Alrt,255} = 734
  ?SYS:K_KO{PROP:Alrt,255} = 734
  ?SYS:SUB_ES{PROP:Alrt,255} = 734
  ?SYS:K_DK_UKA{PROP:Alrt,255} = 734
  ?SYS:K_PVN:2{PROP:Alrt,255} = 734
  ?SYS:K_PVN:3{PROP:Alrt,255} = 734
  ?SYS:D_DK_PRI{PROP:Alrt,255} = 734
  ?SYS:D_PR{PROP:Alrt,255} = 734
  ?SYS:D_TA{PROP:Alrt,255} = 734
  ?SYS:D_PVN_PRI{PROP:Alrt,255} = 734
  ?SYS:D_TR{PROP:Alrt,255} = 734
  ?SYS:D_PVN_PEC{PROP:Alrt,255} = 734
  ?SYS:D_KO{PROP:Alrt,255} = 734
  ?SYS:D_PA{PROP:Alrt,255} = 734
  ?SYS:D_DK_PEC{PROP:Alrt,255} = 734
  ?SYS:D_DK_UKA{PROP:Alrt,255} = 734
  ?SYS:BKK_AP:2{PROP:Alrt,255} = 734
  ?SYS:BKK_AP:3{PROP:Alrt,255} = 734
  ?SYS:CONTROL_BYTE{PROP:Alrt,255} = 734
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
    SYSTEM::Used -= 1
    IF SYSTEM::Used = 0 THEN CLOSE(SYSTEM).
  END
  IF WindowOpened
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
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
!---------------------------------------------------------------------------
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?SYS:K_DK_PRI
      SYS:K_DK_PRI = History::SYS:Record.K_DK_PRI
    OF ?SYS:K_PR
      SYS:K_PR = History::SYS:Record.K_PR
    OF ?SYS:K_TA
      SYS:K_TA = History::SYS:Record.K_TA
    OF ?SYS:K_TR
      SYS:K_TR = History::SYS:Record.K_TR
    OF ?SYS:K_DK_PEC
      SYS:K_DK_PEC = History::SYS:Record.K_DK_PEC
    OF ?SYS:K_PVN
      SYS:K_PVN = History::SYS:Record.K_PVN
    OF ?SYS:K_PA
      SYS:K_PA = History::SYS:Record.K_PA
    OF ?SYS:K_KO
      SYS:K_KO = History::SYS:Record.K_KO
    OF ?SYS:SUB_ES
      SYS:SUB_ES = History::SYS:Record.SUB_ES
    OF ?SYS:K_DK_UKA
      SYS:K_DK_UKA = History::SYS:Record.K_DK_UKA
    OF ?SYS:K_PVN:2
      SYS:K_PVN = History::SYS:Record.K_PVN
    OF ?SYS:K_PVN:3
      SYS:K_PVN = History::SYS:Record.K_PVN
    OF ?SYS:D_DK_PRI
      SYS:D_DK_PRI = History::SYS:Record.D_DK_PRI
    OF ?SYS:D_PR
      SYS:D_PR = History::SYS:Record.D_PR
    OF ?SYS:D_TA
      SYS:D_TA = History::SYS:Record.D_TA
    OF ?SYS:D_PVN_PRI
      SYS:D_PVN_PRI = History::SYS:Record.D_PVN_PRI
    OF ?SYS:D_TR
      SYS:D_TR = History::SYS:Record.D_TR
    OF ?SYS:D_PVN_PEC
      SYS:D_PVN_PEC = History::SYS:Record.D_PVN_PEC
    OF ?SYS:D_KO
      SYS:D_KO = History::SYS:Record.D_KO
    OF ?SYS:D_PA
      SYS:D_PA = History::SYS:Record.D_PA
    OF ?SYS:D_DK_PEC
      SYS:D_DK_PEC = History::SYS:Record.D_DK_PEC
    OF ?SYS:D_DK_UKA
      SYS:D_DK_UKA = History::SYS:Record.D_DK_UKA
    OF ?SYS:BKK_AP:2
      SYS:D_PVN_PRI = History::SYS:Record.D_PVN_PRI
    OF ?SYS:BKK_AP:3
      SYS:D_PVN_PRI = History::SYS:Record.D_PVN_PRI
    OF ?SYS:CONTROL_BYTE
      SYS:CONTROL_BYTE = History::SYS:Record.CONTROL_BYTE
  END
  DISPLAY()
!---------------------------------------------------------------
PrimeFields ROUTINE
!|
!| This routine is called whenever the procedure is called to insert a record.
!|
!| This procedure performs three functions. These functions are..
!|
!|   1. Prime the new record with initial values specified in the dictionary
!|      and under the Field priming on Insert button.
!|   2. Generates any Auto-Increment values needed.
!|   3. Saves a copy of the new record, as primed, for use in batch-adds.
!|
!| If an auto-increment value is generated, this routine will add the new record
!| at this point, keeping its place in the file.
!|
  SYS:Record = SAV::SYS:Record
  SAV::SYS:Record = SYS:Record
ClosingWindow ROUTINE
  Update::Reloop = 0
  IF LocalResponse <> RequestCompleted
    DO CancelAutoIncrement
  END

CancelAutoIncrement ROUTINE
  IF LocalResponse <> RequestCompleted
  END
FORM::AssignButtons ROUTINE
  ToolBarMode=FormMode
  DISABLE(TBarBrwFirst,TBarBrwLast)
  ENABLE(TBarBrwHistory)
  CASE OriginalRequest
  OF InsertRecord
    ENABLE(TBarBrwDown)
    ENABLE(TBarBrwInsert)
    TBarBrwDown{PROP:ToolTip}='Save record and add another'
    TBarBrwInsert{PROP:ToolTip}=TBarBrwDown{PROP:ToolTip}
  OF ChangeRecord
    ENABLE(TBarBrwBottom,TBarBrwUp)
    ENABLE(TBarBrwInsert)
    TBarBrwBottom{PROP:ToolTip}='Save changes and go to last record'
    TBarBrwTop{PROP:ToolTip}='Save changes and go to first record'
    TBarBrwPageDown{PROP:ToolTip}='Save changes and page down to record'
    TBarBrwPageUp{PROP:ToolTip}='Save changes and page up to record'
    TBarBrwDown{PROP:ToolTip}='Save changes and go to next record'
    TBarBrwUP{PROP:ToolTip}='Save changes and go to previous record'
    TBarBrwInsert{PROP:ToolTip}='Save this record and add a new one'
  END
  DISPLAY(TBarBrwFirst,TBarBrwLast)

UpdatePAVAD PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
ActionMessage        CSTRING(40)
RecordChanged        BYTE,AUTO
FORCEDPARCHANGE      BYTE
Forcedatlchange      BYTE
ADRESEF              STRING(60)
akmuci               DECIMAL(7,2)
NOL_ARBYTE           STRING(1)
NPK                  USHORT
DKSTRING             STRING(30)
TEKSTS1              STRING(60)
TEKSTS2              STRING(60)
TEKSTS3              STRING(60)
VEDEJS               STRING(35)
VED_AUTO             STRING(60)
NOM_NOSAUKUMS        STRING(50)
forcedparadschange   BYTE
atlaide_pr           DECIMAL(3,1)
PAV_SUMMA_A          REAL
PAV_C_SUMMA          REAL
SummaArPVN           DECIMAL(11,2)
DIENA_V              STRING(11)
protext              STRING(25)
NODTEXT              STRING(25)
MAKSTEXT             STRING(20)
FORMATNPK            BYTE
A_DAUDZUMS           DECIMAL(9,2)
LIST1:QUEUE          QUEUE,PRE()
TR_V_KODS            STRING(36)
                     END
LIST2:QUEUE          QUEUE,PRE()
PIEG_N_KODS          STRING(35)
                     END
UPTEXT               STRING(30)
PICSUMMA             DECIMAL(10,3)
REASUMMA             DECIMAL(10,3)
LIDZ                 STRING(4)
ZIME                 DECIMAL(1)
SUP_A4_NR  BYTE
NOKL_CENA  BYTE
NEW_PAV    BYTE

D_KSCREEN WINDOW('Norâdiet dokumenta Tipu:'),AT(,,137,139),FONT('MS Sans Serif',10,,FONT:bold),CENTER, |
         IMM,HLP('UpdatePAVAD'),SYSTEM,GRAY,RESIZE,MDI
       OPTION(' '),AT(2,0,128,96),USE(PAV:D_K),BOXED,FONT(,10,,FONT:bold)
         RADIO('&D-Ienâkoðâ P/Z'),AT(14,7),USE(?PAV:PAZIME:Radio1),VALUE('D')
         RADIO('&K-Izejoðâ P/Z'),AT(14,18,73,10),USE(?PAV:PAZIME:Radio2),VALUE('K')
         RADIO('&1-Debeta projekts'),AT(14,54,80,10),USE(?PAV:PAZIME:Radio3),VALUE('1')
         RADIO('&P-Kredîta projekts'),AT(14,64,64,10),USE(?PAV:PAZIME:Radio4),VALUE('P')
         RADIO('&R-Kredîta pre-projekts'),AT(14,74,80,10),USE(?PAV:PAZIME:Radio6:2),VALUE('R')
         RADIO('&X-Mainît zîmi'),AT(14,84,80,10),USE(?PAV:PAZIME:Radio6),FONT(,,COLOR:Red,,CHARSET:BALTIC), |
             VALUE('X')
       END
       OPTION('Pieðíirt SUP/A4 dokumenta Nr'),AT(15,29,107,22),USE(SUP_A4_NR),BOXED
         RADIO('Jâ'),AT(21,38,21,10),USE(?SUP_A4_NR:Radio1),VALUE('1')
         RADIO('Nç'),AT(43,38,20,10),USE(?SUP_A4_NR:Radio2),VALUE('0')
         RADIO('Garantijas Nr'),AT(66,38,52,10),USE(?SUP_A4_NR:Radio3),VALUE('2')
       END
       CHECK('Atgriezta prece'),AT(15,98,60,16),USE(ZIME,,?ZIME),HIDE,VALUE('-1','1')
       BUTTON('&OK'),AT(98,118),USE(?OK1),DEFAULT
       STRING('Pârrçíinât pçc cenas (1-6):'),AT(1,118),USE(?nokl_cena:text),HIDE,FONT(,,COLOR:Red,,CHARSET:BALTIC)
       ENTRY(@n1),AT(85,118,10,10),USE(nokl_cena),HIDE,CENTER
     END

N_TABLE      QUEUE,PRE(N)
D_K             STRING(1)
NOMENKLAT       STRING(21)
DAUDZUMS        DECIMAL(11,3)
             .
R_TABLE      QUEUE,PRE(R)
RECORD          LIKE(NOL:RECORD)
             .

SAV_D_K      STRING(1)
CANCEL_OFF   LONG
PAV_MUITA    LIKE(PAV:MUITA)
SVMUI        REAL
EXPL_MUITA   LIKE(PAV:MUITA)
LOCK_MUITA   LIKE(PAV:MUITA)
PAV_AKCIZE   LIKE(PAV:AKCIZE)
SVAKC        REAL
EXPL_AKCIZE  LIKE(PAV:AKCIZE)
LOCK_AKCIZE  LIKE(PAV:AKCIZE)
PAV_CITAS    LIKE(PAV:CITAS)
SVARS        REAL
EXPL_SUMMA   LIKE(PAV:CITAS)
LOCK_SUMMA   LIKE(PAV:CITAS)
CHECKSUM     LIKE(PAV:SUMMA)
CHANGEPK     BYTE
PAR_KRED_LIM LIKE(PAR:KRED_LIM)
D_K_CHANGEERROR BYTE
SERVISS      BYTE
OLD_DATUMS   LIKE(PAV:DATUMS)
PAV_C_DATUMS LIKE(PAV:C_DATUMS)
PAV_DATUMS   LIKE(PAV:DATUMS)

SAV_RECORD   LIKE(PAV:RECORD),PRE(SAV)
SAV_POSITION STRING(260)
SAV_OBJ_NR   LIKE(PAV:OBJ_NR)
SAV_U_NR     LIKE(PAV:U_NR)
PAV_DOK_SENR LIKE(PAV:DOK_SENR)
PAV_PIELIK   LIKE(PAV:PIELIK)

PAV_DOK_SE   STRING(7)
PAV_DOK_NR   ULONG
NOM_MINRC    LIKE(NOM:MINRC)
NOM_PIC      LIKE(NOM:PIC)

BRW2::View:Browse    VIEW(NOLIK)
                       PROJECT(NOL:NOMENKLAT)
                       PROJECT(NOL:DAUDZUMS)
                       PROJECT(NOL:SUMMAV)
                       PROJECT(NOL:ARBYTE)
                       PROJECT(NOL:PVN_PROC)
                       PROJECT(NOL:ATLAIDE_PR)
                       PROJECT(NOL:PAR_NR)
                       PROJECT(NOL:OBJ_NR)
                       PROJECT(NOL:D_K)
                       PROJECT(NOL:BAITS)
                       PROJECT(NOL:U_NR)
                     END

Queue:Browse:2       QUEUE,PRE()                  ! Browsing Queue
BRW2::NOL:NOMENKLAT    LIKE(NOL:NOMENKLAT)        ! Queue Display field
BRW2::NOM_NOSAUKUMS    LIKE(NOM_NOSAUKUMS)        ! Queue Display field
BRW2::NOL:DAUDZUMS     LIKE(NOL:DAUDZUMS)         ! Queue Display field
BRW2::NOL:SUMMAV       LIKE(NOL:SUMMAV)           ! Queue Display field
BRW2::NOL_ARBYTE       LIKE(NOL_ARBYTE)           ! Queue Display field
BRW2::NOL:PVN_PROC     LIKE(NOL:PVN_PROC)         ! Queue Display field
BRW2::NOL:ATLAIDE_PR   LIKE(NOL:ATLAIDE_PR)       ! Queue Display field
BRW2::akmuci           LIKE(akmuci)               ! Queue Display field
BRW2::SummaArPVN       LIKE(SummaArPVN)           ! Queue Display field
BRW2::NOL:PAR_NR       LIKE(NOL:PAR_NR)           ! Queue Display field
BRW2::NOL:OBJ_NR       LIKE(NOL:OBJ_NR)           ! Queue Display field
BRW2::NOL:D_K          LIKE(NOL:D_K)              ! Queue Display field
BRW2::NOL:BAITS        LIKE(NOL:BAITS)            ! Queue Display field
BRW2::NOL:U_NR         LIKE(NOL:U_NR)             ! Queue Display field
BRW2::Mark             BYTE                       ! Queue POSITION information
BRW2::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW2::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW2::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW2::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW2::Sort1:KeyDistribution LIKE(NOL:NOMENKLAT),DIM(100)
BRW2::Sort1:LowValue LIKE(NOL:NOMENKLAT)          ! Queue position of scroll thumb
BRW2::Sort1:HighValue LIKE(NOL:NOMENKLAT)         ! Queue position of scroll thumb
BRW2::Sort1:Reset:PAV:U_NR LIKE(PAV:U_NR)
BRW2::QuickScan      BYTE                         ! Flag for Range/Filter test
BRW2::CurrentEvent   LONG                         !
BRW2::CurrentChoice  LONG                         !
BRW2::RecordCount    LONG                         !
BRW2::SortOrder      BYTE                         !
BRW2::LocateMode     BYTE                         !
BRW2::RefreshMode    BYTE                         !
BRW2::LastSortOrder  BYTE                         !
BRW2::FillDirection  BYTE                         !
BRW2::AddQueue       BYTE                         !
BRW2::Changed        BYTE                         !
BRW2::RecordStatus   BYTE                         ! Flag for Range/Filter test
BRW2::ItemsToFill    LONG                         ! Controls records retrieved
BRW2::MaxItemsInList LONG                         ! Retrieved after window opened
BRW2::HighlightedPosition STRING(512)             ! POSITION of located record
BRW2::NewSelectPosted BYTE                        ! Queue position of located record
BRW2::PopupText      STRING(128)                  !
ToolBarMode          UNSIGNED,AUTO
BrowseButtons        GROUP                      !info for current browse with focus
ListBox                SIGNED                   !Browse list control
InsertButton           SIGNED                   !Browse insert button
ChangeButton           SIGNED                   !Browse change button
DeleteButton           SIGNED                   !Browse delete button
SelectButton           SIGNED                   !Browse select button
                     END
Update::Reloop  BYTE
Update::Error   BYTE
History::PAV:Record LIKE(PAV:Record),STATIC
SAV::PAV:Record      LIKE(PAV:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:PAV:U_NR     LIKE(PAV:U_NR)
Auto::Save:PAV:DOK_SENR LIKE(PAV:DOK_SENR)
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
FLD7::View           VIEW(VAL_K)
                       PROJECT(VAL:VAL)
                     END
Queue:FileDrop       QUEUE,PRE
FLD7::VAL:VAL          LIKE(VAL:VAL)
                     END
FLD7::LoopIndex      LONG,AUTO
QuickWindow          WINDOW('Update the PAVAD File'),AT(,,457,325),FONT('MS Sans Serif',8,,FONT:bold,CHARSET:BALTIC),IMM,HLP('UpdatePAVAD'),GRAY,RESIZE,MDI
                       STRING(@n_8.0),AT(4,2,37,9),USE(PAV:U_NR),FONT(,9,COLOR:Gray,FONT:bold)
                       BUTTON('&Y-Raksta statuss'),AT(81,54,60,14),USE(?Rakstastatuss),FONT(,8,,FONT:bold)
                       IMAGE('CANCEL4.ICO'),AT(142,51,18,21),USE(?ImageRS),HIDE
                       STRING(@s30),AT(15,11),USE(DKSTRING),CENTER,FONT(,10,,FONT:bold)
                       BUTTON('Nodaïa'),AT(5,23,45,14),USE(?Nodala)
                       ENTRY(@s2),AT(52,26,13,10),USE(PAV:NODALA),LEFT(1)
                       STRING(@s25),AT(67,26,93,10),USE(NODTEXT),LEFT(1)
                       BUTTON('Proj. (Obj.)'),AT(5,39,45,14),USE(?BUTTON:Projekts)
                       ENTRY(@n_6B),AT(52,41,29,10),USE(PAV:OBJ_NR),LEFT
                       STRING(@s25),AT(82,41,78,10),USE(protext,,?protext:2)
                       BUTTON('Mainît &-1-D-K-P-R-zîmi'),AT(5,54,75,14),USE(?MAINIT1DKP)
                       PROMPT('Dokumenta Sç&rija-Nr'),AT(6,74,69,10),USE(?PAV:DOK_SE:Prompt)
                       ENTRY(@s14),AT(77,73,83,12),USE(PAV:DOK_SENR),TIP('K,P,R tâs 000-es obligâti jâatstâj, lai nenojûk autonumerâcija')
                       PROMPT('Do&kum. datums'),AT(7,90,50,10),USE(?PAV:dokdat:Prompt)
                       SPIN(@D06.B),AT(58,88,51,12),USE(PAV:DOKDAT),REQ
                       PROMPT('Grâm. dat.'),AT(7,103,36,10),USE(?PAV:datums:Prompt)
                       BUTTON('&='),AT(44,100,13,14),USE(?ButtonLIDZINAS)
                       SPIN(@D06.B),AT(58,102,51,12),USE(PAV:DATUMS),REQ
                       BUTTON('&Partneris'),AT(6,115,42,14),USE(?Partneris),FONT(,9,,FONT:bold)
                       ENTRY(@s15),AT(51,117,71,10),USE(PAV:NOKA)
                       STRING(@n_8),AT(124,118,38,10),USE(PAV:PAR_NR),LEFT,FONT(,9,,FONT:bold)
                       STRING(@s11),AT(111,103),USE(DIENA_V)
                       STRING(@s60),AT(6,130,154,10),USE(ADRESEF),LEFT(1)
                       PROMPT('&Valûta'),AT(7,142),USE(?PAV:val:Prompt)
                       LIST,AT(39,140,37,12),USE(PAV:val),FORMAT('12L~VAL~@s3@'),DROP(10),FROM(Queue:FileDrop)
                       OPTION('Apmak&sas kârtîba'),AT(3,155,84,55),USE(PAV:apm_v),BOXED
                         RADIO('1-Priekðapmaksa'),AT(6,163,66,10),USE(?PAV:apm_v:Radio1)
                         RADIO('2-Pçcapmaksa'),AT(6,172,59,10),USE(?PAV:apm_v:Radio2)
                         RADIO('3-Realizâcijai'),AT(6,181,58,10),USE(?PAV:apm_v:Radio3)
                         RADIO('4-Apmaksa uzreiz'),AT(6,190,68,10),USE(?PAV:apm_v:Radio4)
                         RADIO('5-Apm.nav paredzçta'),AT(6,199,78,10),USE(?PAV:apm_v:Radio4:2)
                       END
                       OPTION('Ap&maksas veids:'),AT(88,151,73,59),USE(PAV:apm_k),BOXED
                         RADIO('1-Pârskaitîjums'),AT(90,162),USE(?PAV:apm_k:Radio1)
                         RADIO('2-Skaidrâ naudâ'),AT(90,171,66,10),USE(?PAV:apm_k:Radio2)
                         RADIO('3-Barters'),AT(90,180,40,10),USE(?PAV:apm_k:Radio3)
                         RADIO('4-Garantija'),AT(90,189,49,10),USE(?PAV:apm_k:Radio3:2)
                         RADIO('5-Rûpn.Garantija'),AT(90,198,68,10),USE(?PAV:apm_k:Radio3:3)
                       END
                       PROMPT('Pamato&jums'),AT(6,212,41,10),USE(?PAV:PAMAT:Prompt)
                       ENTRY(@s28),AT(54,212,103,10),USE(PAV:PAMAT),TIP('-D sintakse=PZ::[atgr. PZ SE-NR]')
                       PROMPT('Pie&likumâ'),AT(6,225,35,10),USE(?PAV:PIELIK:Prompt)
                       ENTRY(@s21),AT(54,225,103,10),USE(PAV:PIELIK)
                       PROMPT('&Transports (ar PVN)'),AT(6,237,66,10),USE(?PAV:T_SUMMA:Prompt)
                       ENTRY(@n-15.2),AT(73,237,41,10),USE(PAV:T_SUMMA),DECIMAL(12)
                       PROMPT(' PVN%'),AT(115,237),USE(?PAV:T_SUMMA:Prompt:2)
                       ENTRY(@n2B),AT(139,237,15,10),USE(PAV:T_PVN),CENTER,OVR
                       PROMPT('Apmaksât lîdz ...'),AT(6,251,94,10),USE(?PAV:C_DATUMS:prompt)
                       ENTRY(@D06.B),AT(105,253,43,10),USE(PAV:C_DATUMS)
                       PROMPT('Maksâjuma summa:'),AT(6,263,95,10),USE(?PAV:C_SUMMA:Prompt)
                       ENTRY(@n-15.2B),AT(105,264,43,10),USE(PAV:C_SUMMA),DECIMAL(12)
                       BUTTON('Maksâtâjs'),AT(7,276,45,14),USE(?ButtonMaksatajs)
                       STRING(@n_6b),AT(53,278),USE(PAV:MAK_NR)
                       STRING(@s20),AT(80,278,81,10),USE(MAKSTEXT),LEFT(1)
                       BUTTON('&9-Pârrçíinât parâdu pçc P/Z satura'),AT(2,296,119,14),USE(?ButtonParrekinat),HIDE
                       BUTTON('&6-Uzlikt parâdu'),AT(124,296,55,14),USE(?ButtonUzliktP),HIDE
                       BUTTON('&7-Noòemt parâdu'),AT(181,296,62,14),USE(?ButtonNonemtP),HIDE
                       SHEET,AT(162,5,290,289),USE(?CurrentTab)
                         TAB('Dokum&enta saturs'),USE(?Tab:1)
                           STRING(@s30),AT(341,7),USE(UPTEXT),CENTER
                           LIST,AT(166,24,282,237),USE(?Browse:2),IMM,HVSCROLL,MSG('Browsing Records'),FORMAT('86L(2)|M~Nomenklatûra~C(0)@s21@66L(1)|M~Nosaukums~C(0)@s16@37R(1)|M~Daudzums~C(0' &|
   ')@n-_13.3@40R(1)|M~Summa~C(0)@n-_12.2@7L@s1@10R(1)|M~%~@n2@21R(1)|M~Atl.%~C(0)@n' &|
   '-5.1@40R(1)|M~Pap. izm.~C(0)@n-_10.2@43L(1)|M~Sum ar PVN~L(0)@n-_12.2@26L(1)|M~P' &|
   'ar_Nr~C(0)@n_6@28L(1)|M~Projekts~C(0)@n_6@10C|M@s1@7L|M~B~@n1b@/'),FROM(Queue:Browse:2)
                           STRING('Summa kopâ:'),AT(290,265),USE(?String5),FONT(,9,,FONT:bold)
                           STRING(@n-_12.2),AT(333,265),USE(PAV:SUMMA),RIGHT(1),FONT(,9,,FONT:bold)
                           STRING(@n-_9.2B),AT(393,265),USE(PAV:SUMMA_A),RIGHT(1)
                           STRING('Summa bez PVN:'),AT(165,274,58,10),USE(?String13:2)
                           STRING(@n-_11.2),AT(222,274),USE(PAV:SUMMA_B),RIGHT(1),FONT(,9,,FONT:bold)
                           STRING('Ierakstu skaits:'),AT(166,265,53,10),USE(?String13)
                           STRING(@n_5),AT(218,265,28,10),USE(NPK),CENTER
                           BUTTON('&Ievadît'),AT(302,277,45,14),USE(?Insert:3),FONT(,9,,FONT:bold)
                           BUTTON('&Mainît'),AT(350,277,45,14),USE(?Change:3),FONT(,9,,FONT:bold),DEFAULT
                           BUTTON('&Dzçst'),AT(398,277,45,14),USE(?Delete:3),FONT(,9,,FONT:bold)
                         END
                         TAB('&5-Papildus dati '),USE(?Tab:2)
                           PROMPT('Deklarâcijas Nr :'),AT(213,51,62,10),USE(?PAV:DEK_NR:Prompt)
                           ENTRY(@s12),AT(277,50,41,10),USE(PAV:DEK_NR)
                           PROMPT('Kases izdevumu ordera Nr :'),AT(179,65,97,10),USE(?Prompt16)
                           ENTRY(@n_7),AT(277,64,45,10),USE(PAV:KIE_NR,,?PAV:KIE_NR:2)
                           PROMPT('Darîjuma veida kods:'),AT(190,107,73,10),USE(?PAV:DAR_V_KODS:Prompt)
                           ENTRY(@n2),AT(266,105),USE(PAV:DAR_V_KODS)
                           PROMPT('Transporta veida kods:'),AT(183,123,79,10),USE(?PAV:TR_V_KODS:Prompt)
                           LIST,AT(266,120,122,14),USE(TR_V_KODS),FORMAT('4L@s37@'),DROP(9),FROM(List1:Queue)
                           PROMPT('Piegâdes nosacîjuma kods:'),AT(171,137,91,10),USE(?PAV:PIEG_N_KODS:Prompt)
                           LIST,AT(266,135,128,14),USE(PIEG_N_KODS,,?PIEG_N_KODS:2),FORMAT('80L@s35@'),DROP(14),FROM(List2:Queue)
                           GROUP('Ârpuspavadzîmes i&zmaksas (Ls), rçíina virsû preces bilances vçrtîbai'),AT(183,175,263,110),USE(?Group1),BOXED
                             STRING('(importa interfeisâ neparâdâs, òem vçrâ, rçíinot paðizmaksu u.c. BIL.vçrt)'),AT(187,185),USE(?String33)
                             STRING(''),AT(191,203),USE(?String8)
                             PROMPT('Muita:'),AT(191,207),USE(?PAV:MUITA:Prompt)
                             ENTRY(@n_8.2),AT(257,207,45,10),USE(PAV:MUITA),RIGHT(1),MSG('citas izmaksas Ls')
                             BUTTON('proporcionâli muitai nomenklatûrâs'),AT(309,207,126,14),USE(?ButtonMUITA)
                             PROMPT('Akcîzes nodoklis:'),AT(191,220,58,10),USE(?PAV:AKCIZE:Prompt)
                             ENTRY(@n_8.2),AT(257,221,45,10),USE(PAV:AKCIZE),RIGHT
                             STRING('akcîzes nod. nomenklatûrâs'),AT(306,222),USE(?String9:2)
                             PROMPT('Transports lîdz LR:'),AT(191,234,65,10),USE(?PAV:CITAS:Prompt)
                             ENTRY(@n_8.2),AT(257,234,45,10),USE(PAV:CITAS),RIGHT(1)
                             STRING('proporcionâli cenai'),AT(306,234),USE(?String11)
                             BUTTON('Sadalît visai P/Z (izòemot LOCKED rakstus):'),AT(191,252,202,14),USE(?ButtonSadalitProporc)
                           END
                         END
                         TAB('&5-Papildus dati '),USE(?Tab:3)
                           PROMPT('Kases iençmuma ordera Nr:'),AT(198,58,90,10),USE(?PAV:KIE_NR:Prompt)
                           ENTRY(@n_5),AT(291,58,33,10),USE(PAV:KIE_NR),RIGHT(1)
                           PROMPT('Rçíina (Invoice) Nr:'),AT(198,69,87,10),USE(?PAV:REK_NR:Prompt)
                           ENTRY(@S10),AT(291,69,59,10),USE(PAV:REK_NR),LEFT(1)
                           BUTTON('a/m &vadîtâjs'),AT(186,101,59,14),USE(?soferis)
                           STRING(@s45),AT(250,100,190,10),USE(VEDEJS),LEFT(1)
                           STRING(@s40),AT(250,109,167,10),USE(VED_AUTO),LEFT(1)
                           BUTTON('&Servisa lapa'),AT(186,119,59,14),USE(?ButtonAUTAPK),HIDE
                           IMAGE('CHECK3.ICO'),AT(251,118,18,21),USE(?ImageSERVISS),HIDE
                           IMAGE('CANCEL4.ICO'),AT(270,118,18,21),USE(?ImageNEDARBI),HIDE
                           STRING(@n_9.2),AT(314,125),USE(A_DAUDZUMS),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           STRING(@n_9.2),AT(355,125),USE(MINMAXSUMMA),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           BUTTON('Plâ&notâjs'),AT(187,137,58,14),USE(?ButtonBilde),DISABLE
                           PROMPT('Darîjuma veida kods:'),AT(186,158,73,10),USE(?PAV:DAR_V_KODS:Prompt:2)
                           ENTRY(@n2),AT(265,156,21,14),USE(PAV:DAR_V_KODS,,?PAV:DAR_V_KODS:2)
                           PROMPT('Transporta veida kods:'),AT(182,174,79,10),USE(?PAV:TR_V_KODS:Prompt:2)
                           LIST,AT(265,172,128,14),USE(TR_V_KODS,,?TR_V_KODS:2),FORMAT('144L@S36@'),DROP(9),FROM(List1:Queue)
                           PROMPT('Piegâdes nosacîjumu kods:'),AT(166,188,93,10),USE(?PAV:PIEG_N_KODS:Prompt:2)
                           LIST,AT(265,188,135,14),USE(PIEG_N_KODS),FORMAT('80L@S35@'),DROP(14),FROM(List2:Queue)
                           BUTTON('Speciâlas a&Tzîmes (08+.rinda P/Z)'),AT(186,213,121,14),USE(?Teksts)
                           STRING(@n_7),AT(310,215),USE(PAV:TEKSTS_NR),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                           STRING(@s60),AT(190,229,247,9),USE(TEKSTS1)
                           STRING(@s60),AT(190,239,247,9),USE(TEKSTS2)
                           STRING(@s60),AT(190,251,247,9),USE(TEKSTS3)
                           BUTTON('Pârrçíinât visu P/Z pçc 6.cenas'),AT(186,266,119,14),USE(?ButtonFIFO),HIDE
                         END
                       END
                       BUTTON('&8-Mainît atlaidi'),AT(249,296,59,14),USE(?ButtonAtlaide)
                       STRING(@s8),AT(3,312,41,10),USE(PAV:ACC_KODS),CENTER,FONT(,9,COLOR:Gray,FONT:bold)
                       STRING(@D06.B),AT(45,312),USE(PAV:ACC_DATUMS),FONT(,9,COLOR:Gray,FONT:bold)
                       BUTTON('&OK'),AT(357,305,45,14),USE(?OK),FONT(,9,,FONT:bold)
                       BUTTON('&Atlikt'),AT(410,305,45,14),USE(?Cancel),FONT(,9,,FONT:bold)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  CHECKOPEN(SYSTEM,1)
  SUP_A4_NR=SYS:SUP_A4_NR
  SIGN#=1

  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  CASE PAV:D_K
  OF 'D'
    DKSTRING='D-Ienâkoðâ P/Z'
    HIDE(?TAB:3)
    HIDE(?ButtonFIFO)
  OF '1'
    DKSTRING='1-Debeta projekts'
    HIDE(?TAB:3)
    HIDE(?ButtonFIFO)
  OF 'K'
    DKSTRING='K-Izejoðâ P/Z'
    TEKSTS1=GetTEX(PAV:TEKSTS_NR,1)
    TEKSTS2=GetTEX(PAV:TEKSTS_NR,2)
    TEKSTS3=GetTEX(PAV:TEKSTS_NR,3)
  !  IF PAV:VED_NR
  !     APK:PAV_NR=PAV:U_NR
  !     GET(AUTOAPK,APK:PAV_KEY)
  !     IF ~ERROR()
  !        UNHIDE(?BUTTONAUTAPK)
  !     .
  !     vedejs=Getauto(pav:ved_nr,4)
  !     ved_auto=Getauto(pav:ved_nr,5)
  !  .
    HIDE(?TAB:2)
    ALERT(F7KEY)
  !  IF INRANGE(PAV:PAR_NR,26,50) THEN UNHIDE(?BUTTONFIFO).
  OF 'P'
    DKSTRING='P-Kredîta projekts'
    TEKSTS1=GetTEX(PAV:TEKSTS_NR,1)
    TEKSTS2=GetTEX(PAV:TEKSTS_NR,2)
    TEKSTS3=GetTEX(PAV:TEKSTS_NR,3)
    HIDE(?TAB:2)
  OF 'R'
    DKSTRING='R-Kredîta Pre-projekts'
    TEKSTS1=GetTEX(PAV:TEKSTS_NR,1)
    TEKSTS2=GetTEX(PAV:TEKSTS_NR,2)
    TEKSTS3=GetTEX(PAV:TEKSTS_NR,3)
    HIDE(?TAB:2)
  !  IF INRANGE(PAV:PAR_NR,26,50) THEN UNHIDE(?BUTTONFIFO).
  .
  IF PAV:U_NR=1 THEN DKSTRING='SALDO'.
  IF PAV:SUMMA<0  OR ZIME<0
     DKSTRING=CLIP(DKSTRING)&' Atgriezta'
  .

  EXECUTE PAV:DATUMS%7+1  !PAV:DATUMS TIEK PIEÐÍIRTS AUTONUMBERÂ VAI AU_BILDÇ
     DIENA_V='Svçtdiena'
     DIENA_V='Pirmdiena'
     DIENA_V='Otrdiena'
     DIENA_V='Treðdiena'
     DIENA_V='Ceturtdiena'
     DIENA_V='Piektdiena'
     DIENA_V='Sestdiena'
  .
  
  TR_V_KODS='0'
  ADD(LIST1:QUEUE)
  TR_V_KODS='1-Jûras transports'
  ADD(LIST1:QUEUE)
  TR_V_KODS='2-Dzelzceïa transpotrs'
  ADD(LIST1:QUEUE)
  TR_V_KODS='3-Autotransports'
  ADD(LIST1:QUEUE)
  TR_V_KODS='4-Gaisa transports'
  ADD(LIST1:QUEUE)
  TR_V_KODS='5-Pasta sûtîjumi'
  ADD(LIST1:QUEUE)
  TR_V_KODS='7-Stacionârâs transportiekârtas'
  ADD(LIST1:QUEUE)
  TR_V_KODS='8-Iekðzemes ûdens transports'
  ADD(LIST1:QUEUE)
  TR_V_KODS='9-Pârvietoðana bez transportlîdzekïa'
  ADD(LIST1:QUEUE)
  IF PAV:TR_V_KODS < 6
     GET(LIST1:QUEUE,PAV:TR_V_KODS+1)
  ELSE
     GET(LIST1:QUEUE,PAV:TR_V_KODS)
  .
  
  PIEG_N_KODS='   '
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='EXW-No rûpnîcas'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='FCA-Franko pârvadâtâjs'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='FAS-Franko gar kuìa bortu'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='FOB-Franko uz kuìa klâja'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='CFR-Cena un frakts'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='CIF-Cena,apdroðinâðana un frakts'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='CPT-Transportçðana samaksâta lîdz..'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='CIP-Transp.un apdroð.samaksâta lîdz..'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='DAF-Piegâdâts lîdz robeþai'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='DES-Piegâdâts no kuìa'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='DEQ-Piegâdâts no piestâtnes'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='DDU-Piegâdâts bez muitas samaksas'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='DDP-Piegâdâts ar muitas samaksu'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='DAT-Piegâdâts lîdz terminâlam'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='DAP-Piegâdâts lîdz vietai'
  ADD(LIST2:QUEUE)
  PIEG_N_KODS='XXX-Citi piegâdes nosacîjumi'
  ADD(LIST2:QUEUE)
  GET(LIST2:QUEUE,INSTRING(PAV:PIEG_N_KODS,'   EXWFCAFASFOBCFRCIFCPTCIPDAFDESDEQDDUDDPDATDAPXXX',3))
  
  ActionMessage='Aplûkoðanas reþîms'   !ja ir localrequest, sistçma pati pârrakstîs pâri
  NODtext = GETNODALAS(PAV:NODALA,1)   !PAV:NODALA tiek pieðíirta no LOKÂLIEM
  PAV_DATUMS=PAV:DATUMS
  IF ~(PAV:U_NR=1) AND (LOCALREQUEST=2 OR LOCALREQUEST=0)
     protext = GETPROJEKTI(PAV:OBJ_NR,1)
     MAKSTEXT= GETPAR_K(PAV:MAK_NR,0,1)
     IF GETPAR_K(PAV:PAR_NR,2,1) !PIE REIZES POZICIONÇJAM PAR_K
        PAR_KRED_LIM=PAR:KRED_LIM
        IF PAV:PAR_NR     !NAV CITI
           PAV:NOKA=PAR:NOS_S
           ADRESEF = GETPAR_ADRESE(PAV:PAR_NR,PAV:PAR_ADR_NR,0,0)
!           IF ~INRANGE(PAR:U_NR,0,50) AND ~(PAR:TIPS='C') AND ~(PAV:DOK_NR>999999) AND INSTRING(PAV:D_K,'DK')
!              ?PAV:DOK_NR{PROP:TEXT}='@N06'
!           .
           IF INSTRING(PAV:D_K,'KP') AND CL_NR=1304 !EZERKAULIÒI - ÐITO DRÎZ VARÇS VÂKT PROM 02.10.2007.
              IF PAR:GRUPA[1:2]='VP'
                 IF INRANGE(PAR:GRUPA[3],1,5)
                    NOKL_CP=PAR:GRUPA[3]
                 ELSE
                    KLUDA(0,'Nav definçta cenu grupa '&CLIP(PAR:NOS_S))
                 .
              ELSIF PAR:GRUPA[1:4]='MEGO'
                 NOKL_CP=4
              .
           .
        .
     .
  .
  DISPLAY
  DO MODIFYSCREEN
  DO MODIFYAUTO
  MINMAXSUMMA=0
  F:DTK=''
  
  !*******USER LEVEL ACCESS CONTROL********
  IF ~BAND(REG_NOL_ACC,00000100b) ! AUTOSERVISS
     HIDE(?ButtonAUTAPK)
  ELSIF SERVISS=TRUE
     CLEAR(APD:RECORD)
     APD:PAV_NR=PAV:U_NR
     SET(APD:NR_KEY,APD:NR_KEY)
     LOOP
        NEXT(AUTODARBI)
        IF ERROR() OR ~(APD:PAV_NR=PAV:U_NR) THEN BREAK.
        MINMAXSUMMA+=APD:LAIKS !LAI NOÈEKOTU VAI IR FIKSÇTS MEISTARU DARBALAIKS
    .
  .
  IF ATLAUTS[21]='1' AND PAV:D_K='K' !AIZLIEGTS MAINÎT SUMMU,ATLAIDI,NOKL_CENU
     DISABLE(?BUTTONATLAIDE)
  .
!  QuickWindow{PROP:FONT,5}='CHARSET:BALTIC' tip_s neiet arî ðitâ
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks mainîts'
  OF DeleteRecord
    ActionMessage = 'Ieraksts tiks dzçsts'
  END
  QuickWindow{Prop:Text} = ActionMessage
  ENABLE(TBarBrwHistory)
  ACCEPT
    DO MODIFYSCREEN
    IF SERVISS=TRUE
       IF ~(MINMAXSUMMA=A_DAUDZUMS)
         UNHIDE(?IMAGENEDARBI)
       ELSE
         HIDE(?IMAGENEDARBI)
       .
    .
    IF PAV:SUMMA<0
         ?PAV:PIELIK:Prompt{PROP:TEXT}='Reference'
         DISPLAY
    .
    
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE()=F7KEY
         forcedparadschange=2  !Noòemt visiem
         DO BRW2::InitializeBrowse
         DO BRW2::RefreshPage
         forcedparadschange=0
         PAV:C_SUMMA=0
         I#=RIUPDATE:PAVAD()
         DISPLAY
      .
      IF KEYCODE() = 734 THEN
        DO HistoryField
      END
    OF EVENT:CloseWindow
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
    OF EVENT:CloseDown
        DO ClosingWindow
        IF Update::Reloop THEN CYCLE.
      WinResize.Destroy
    OF EVENT:OpenWindow
      DO BRW2::AssignButtons
      DO FORM::AssignButtons
      DO FLD7::FillList
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?PAV:U_NR)
      IF LOCALREQUEST=2
         SELECT(?Browse:2)
      ELSIF LOCALREQUEST=1
         IF INSTRING(PAV:D_K,'1D')
            SELECT(?PAV:DOK_SENR)
         ELSE
            SELECT(?PAV:DOKDAT)
         .
      ELSIF LOCALREQUEST=3
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-2)
         enable(?Tab:1)  !ATVÇRT CURRENTTAB NEDRÎKST
         SELECT(?cancel)
      ELSE
         quickwindow{prop:color}=color:activeborder
         disable(1,?cancel-1)
         enable(?CurrentTab)
         enable(?Tab:1)
         enable(?Tab:2)
         enable(?tab:3)
         hide(?Change:3)
         hide(?Delete:3)
         SELECT(?cancel)
         DO MODIFYAUTO
      .
    OF EVENT:GainFocus
      OMIT('ForceRefresh = True')
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
      IF ToolBarMode=BrowseMode THEN
        DO UpdateDispatch
      END
      IF ACCEPTED() = TbarBrwHistory
        DO HistoryField
      END
      IF EVENT() = Event:Completed
        History::PAV:Record = PAV:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(PAVAD)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(PAV:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'PAV:NR_KEY')
                SELECT(?PAV:U_NR)
                VCRRequest = VCRNone
                CYCLE
              END
            END
            IF DUPLICATE(PAV:SENR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'PAV:SENR_KEY')
                SELECT(?PAV:U_NR)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?PAV:U_NR)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::PAV:Record <> PAV:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:PAVAD(1)
            ELSE
              Update::Error = 0
            END
            SETCURSOR()
            IF Update::Error THEN
              IF Update::Error = 1 THEN
                CASE StandardWarning(Warn:UpdateError)
                OF Button:Yes
                  CYCLE
                OF Button:No
                  POST(Event:CloseWindow)
                  BREAK
                END
              END
              DISPLAY
              SELECT(?PAV:U_NR)
              VCRRequest = VCRNone
            ELSE
              IF RecordChanged OR VCRRequest = VCRNone THEN
                LocalResponse = RequestCompleted
              END
              POST(Event:CloseWindow)
            END
            BREAK
          END
        OF DeleteRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            IF RIDelete:PAVAD()
              SETCURSOR()
              CASE StandardWarning(Warn:DeleteError)
              OF Button:Yes
                CYCLE
              OF Button:No
                POST(Event:CloseWindow)
                BREAK
              OF Button:Cancel
                DISPLAY
                SELECT(?PAV:U_NR)
                VCRRequest = VCRNone
                BREAK
              END
            ELSE
              SETCURSOR()
              LocalResponse = RequestCompleted
              POST(Event:CloseWindow)
            END
            BREAK
          END
        END
      END
      IF ToolbarMode = FormMode THEN
        CASE ACCEPTED()
        OF TBarBrwBottom TO TBarBrwUp
        OROF TBarBrwInsert
          VCRRequest=ACCEPTED()
          POST(EVENT:Completed)
        OF TBarBrwHelp
          PRESSKEY(F1Key)
        END
                VCRRequest = VCRNone
      END
    END
    CASE FIELD()
    OF ?Rakstastatuss
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF pav:rs
           pav:rs=''
           HIDE(?IMAGERS)
        ELSE
           pav:rs='1'
           UNHIDE(?IMAGERS)
        .
        DO BRW2::InitializeBrowse
        DO BRW2::RefreshPage
        display
      END
    OF ?Nodala
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseNodalas 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           PAV:nodala=NOD:U_NR
           NODTEXT=NOD:NOS_P
           DISPLAY
        .
      END
    OF ?PAV:NODALA
      CASE EVENT()
      OF EVENT:Accepted
        NODtext = GETNODALAS(PAV:NODALA,1)
        DISPLAY
      END
    OF ?BUTTON:Projekts
      CASE EVENT()
      OF EVENT:Accepted
        SAV_OBJ_NR=PAV:OBJ_NR
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseProjekti 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           PAV:OBJ_NR=PRO:U_NR
           PROTEXT=PRO:NOS_P
           DISPLAY
           DO BRW2::InitializeBrowse  !Lai nomaina NOLIK, ja mainîts PROJEKTS
           DO BRW2::RefreshPage
        .
      END
    OF ?PAV:OBJ_NR
      CASE EVENT()
      OF EVENT:Accepted
        protext = GETPROJEKTI(PAV:OBJ_NR,1)
        DO BRW2::InitializeBrowse  !Lai nomaina NOLIK, ja mainîts PROJEKTS
        DO BRW2::RefreshPage
        DISPLAY
        
        
      OF EVENT:Selected
        SAV_OBJ_NR=PAV:OBJ_NR
      END
    OF ?MAINIT1DKP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        SAV_D_K=PAV:D_K
        OPEN(D_KSCREEN)
        IF PAV:D_K='K'
           ENABLE(?SUP_A4_NR)
        ELSIF PAV:D_K='P'
           ENABLE(?SUP_A4_NR)
           DISABLE(?SUP_A4_NR:Radio1) !NOÒEMAM JÂ
           SUP_A4_NR=0 !NÇ
        ELSE
           DISABLE(?SUP_A4_NR)
        .
        DISPLAY
        accept
           case field()
           of ?PAV:D_K
              if event()=EVENT:Accepted
                 IF PAV:D_K='K'
                    ENABLE(?SUP_A4_NR)
                    ENABLE(?SUP_A4_NR:Radio1)
                 ELSIF PAV:D_K='P'
                    IF SUP_A4_NR=1 THEN SUP_A4_NR=0.
                    ENABLE(?SUP_A4_NR)
                    DISABLE(?SUP_A4_NR:Radio1) !NOÒEMAM JÂ
                 ELSE
                    DISABLE(?SUP_A4_NR)
                 .
                 DISPLAY
              .
           of ?OK1
              if event()=EVENT:Accepted
                 IF ~INSTRING(PAV:D_K,'KP') THEN SUP_A4_NR=0.
                 BREAK
              .
           .
        .
        close(D_KSCREEN)
        IF (GETPAR_ATZIME(PAR:ATZIME1,2) ='2' AND PAV:D_K='K') OR|
           (GETPAR_ATZIME(PAR:ATZIME2,2) ='2' AND PAV:D_K='K')
           KLUDA(68,'LEVEL=2 '&ATZ:TEKSTS)
           PAV:D_K=SAV_D_K
        ELSE
           IF PAV:D_K='X'
             PAV:D_K=SAV_D_K
             SIGN#=-1
             PAV:C_SUMMA=-PAV:C_SUMMA
           ELSE
             SIGN#=1
           .
           CASE PAV:D_K
           OF 'D'
             DKSTRING='D-Ienâkoðâ P/Z'
             HIDE(?TAB:3)
             UNHIDE(?TAB:2)
           OF '1'
             DKSTRING='1-Debeta projekts'
             HIDE(?TAB:3)
             UNHIDE(?TAB:2)
           OF 'K'
             DKSTRING='K-Izejoðâ P/Z'
             PAV_DOK_NR = GETDOK_SENR(2,PAV:DOK_SENR,,'2')
             IF SUP_A4_NR=1       !JÂBÛVÇ SUP/A4 Nr
                PAV_DOK_SE=SYS:PZ_SERIJA
                PAV_DOK_NR=0
             ELSIF SUP_A4_NR=2    !JÂBÛVÇ GARANTIJAS Nr
                PAV_DOK_SE='G'
                PAV_DOK_NR=0
             ELSIF ~PAV:DOK_SENR  !NAV JAU BIJIS KAUT KÂDS NUMURS&SÇRIJA
                PAV_DOK_SE='K'
                PAV_DOK_NR=0
             .
             IF ~PAV_DOK_NR
                SAV_POSITION=POSITION(PAVAD)
                SAV::PAV:Record = PAV:Record !ÐITO VAJAG ASSIGN_DOK_NR_am
                DO ASSIGN_DOK_NR  !MAINA DOKSE_NR iekð PAV:Record un SAV::PAV:Record
                IF PAV_DOK_SE=SYS:PZ_SERIJA AND PAV_DOK_NR>SYS:PZ_NR_END
                   KLUDA(0,'beidzies PPR numerâcijas apgabals Lokâlajos datos...')
                   PAV:DOK_SENR=''
!                ELSIF PAV:DOK_SE=SYS:PZ_SERIJA AND INRANGE(SYS:PZ_NR_END-PAV:DOK_NR,0,5)
!                   KLUDA(0,'PPR numerâcijas apgabalâ vçl atlikuðas '&CLIP(SYS:PZ_NR_END-PAV:DOK_NR)&' pavadzîmes')
!                   !JA USERIS TAGAD ILGI BAKSTÎSIES UN BRÎNÎSIES, ÐITO NUMURU VAR PAGRÂBT ARÎ KÂDS CITS)
                .
                RESET(PAVAD,SAV_POSITION)
                NEXT(PAVAD)
                PAV:Record=SAV::PAV:Record !ar jauno DOK_SENR
             .
             SAV::PAV:Record='' !LAI NOSTRÂDÂTU RECORDCHANGED
             HIDE(?TAB:2)
             UNHIDE(?TAB:3)
             IF SAV_D_K='P'
                CHANGEPK=TRUE ! VAJAG kredîtlimita analîzei
             .
           OF 'P'
             DKSTRING='P-Kredîta projekts'
             SAV_POSITION=POSITION(PAVAD)
             IF SUP_A4_NR=2    !JÂBÛVÇ GARANTIJAS Nr
                PAV_DOK_SE='G'
             ELSE
                PAV_DOK_SE='P'
             .
!             STOP(PAV_DOK_SE)
             SAV::PAV:Record = PAV:Record !ÐITO VAJAG ASSIGN_DOK_NR_am
             DO ASSIGN_DOK_NR
             RESET(PAVAD,SAV_POSITION)
             NEXT(PAVAD)
             PAV:Record=SAV::PAV:Record
             SAV::PAV:Record='' !LAI NOSTRÂDÂTU RECORDCHANGED
             HIDE(?TAB:2)
             UNHIDE(?TAB:3)
           OF 'R'
             DKSTRING='R-Kredîta pre-projekts'
             SAV_POSITION=POSITION(PAVAD)
             PAV_DOK_SE='R'
             SAV::PAV:Record = PAV:Record !ÐITO VAJAG ASSIGN_DOK_NR_am
             DO ASSIGN_DOK_NR
             RESET(PAVAD,SAV_POSITION)
             NEXT(PAVAD)
             PAV:Record=SAV::PAV:Record
             SAV::PAV:Record='' !LAI NOSTRÂDÂTU RECORDCHANGED
             HIDE(?TAB:2)
             UNHIDE(?TAB:3)
           ELSE
             STOP('? '&PAV:D_K)
           .
           IF DUPLICATE(PAV:SENR_KEY)
              KLUDA(0,'Atkârtojas dokumenta SE-Nr : '&CLIP(PAV:DOK_SENR)&' ,atceïam autonumerâciju....')
              PAV:DOK_SENR=''
           .
           DO BRW2::InitializeBrowse
           DO BRW2::RefreshPage
           IF D_K_CHANGEERROR=TRUE !VEIDOJÂS AIZLIEGTI NEGATÎVI ATLIKUMI, ATGRIEÞAM D_K KÂ BIJA
              DO BRW2::InitializeBrowse
              DO BRW2::RefreshPage
              DKSTRING='P-Kredîta projekts'
              D_K_CHANGEERROR=FALSE
           .
           IF PAV:SUMMA < 0
              DKSTRING=CLIP(DKSTRING)&' Atgriezta'
           .
           SIGN#=1
           display
        .
      END
    OF ?PAV:DOK_SENR
      CASE EVENT()
      OF EVENT:Accepted
        PAV:DOK_SENR=LEFT(INIGEN(PAV:DOK_SENR,14,1))
        DISPLAY
      END
    OF ?ButtonLIDZINAS
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        PAV:datums=PAV:dokdat
        IF PAV:DATUMS < SYS:GIL_SHOW  ! SLÇGTS APGABALS
            KLUDA(27,'DATUMS, Datu bloks ir slçgts...mainu datumu')
            PAV:DATUMS = SYS:GIL_SHOW+1
            PAV:DOKDAT = PAV:DATUMS
            DISPLAY
            SELECT(?PAV:DATUMS)
        ELSE
!           SAV_datums=PAV:datums
           EXECUTE PAV:DATUMS%7+1
              DIENA_V='Svçtdiena'
              DIENA_V='Pirmdiena'
              DIENA_V='Otrdiena'
              DIENA_V='Treðdiena'
              DIENA_V='Ceturtdiena'
              DIENA_V='Piektdiena'
              DIENA_V='Sestdiena'
           .
           display(?diena_v)
           DO BRW2::InitializeBrowse   ! Lai nomaina GGK, ja mainâs datums
           DO BRW2::RefreshPage
           display(?PAV:datums)
           select(?partneris)
        .
      END
    OF ?PAV:DATUMS
      CASE EVENT()
      OF EVENT:Accepted
        IF PAV:DATUMS < SYS:GIL_SHOW  ! SLÇGTS APGABALS
            KLUDA(27,'DATUMS, Datu bloks ir slçgts...mainu datumu')
            PAV:DATUMS = SYS:GIL_SHOW+1
            PAV:DOKDAT = PAV:DATUMS
            SELECT(?PAV:DATUMS)
        ELSE
           EXECUTE PAV:DATUMS%7+1
              DIENA_V='Svçtdiena'
              DIENA_V='Pirmdiena'
              DIENA_V='Otrdiena'
              DIENA_V='Treðdiena'
              DIENA_V='Ceturtdiena'
              DIENA_V='Piektdiena'
              DIENA_V='Sestdiena'
           .
!           SAV_datums=PAV:datums  !ÐÍIET, NÂKOÐIEM DOKUMENTIEM --- NEZVAI 10.03.08
           DO BRW2::InitializeBrowse   ! Lai nomaina NOLIK,AUTOAPK,AUTODARBI, ja mainâs datums
           DO BRW2::RefreshPage
           !IF INSTRING(PAV:D_K,'KP') AND (PAR:NOKL_DC OR SYS:NOKL_DC)
           IF INSTRING(PAV:APM_V,'12') AND PAV:C_DATUMS AND ~(PAV_DATUMS=PAV:DATUMS) !PÇCAPMAKSA PAV:APM_V '3'-REALIZÂCIJAI
              DO C_DATUMS
              IF ~(PAV:C_DATUMS=PAV_C_DATUMS)
                 KLUDA(0,'Jâmaina atliktâ maksâjuma datums uz '&FORMAT(PAV_C_DATUMS,@D06.),5,1)
                 IF KLU_DARBIBA
                    PAV:C_DATUMS=PAV_C_DATUMS
                 .
              .
           .
           PAV_DATUMS=PAV:DATUMS
        .
        DISPLAY
        PAV:DATUMS=GETFING(3,PAV:DATUMS) !3-AR FING KONTROLI
!        IF ~(YEAR(PAV:DATUMS)=DB_GADS)
!           KLUDA(23,DB_GADS&'. gadu')
!        .
      END
    OF ?Partneris
      CASE EVENT()
      OF EVENT:Accepted
        IF PAV:PAR_NR
           PAR_NR=PAV:PAR_NR
        .
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         IF GlobalResponse=RequestCompleted
            IF ~(PAV:D_K='K' AND (GETPAR_ATZIME(PAR:ATZIME1,2)='2' OR GETPAR_ATZIME(PAR:ATZIME2,2)='2')) !~AIZLIEGTS PARTNERIS
!               IF INSTRING(PAR:TIPS,'CN') AND ~(PAV:VAL=VAL_LV)
               IF INSTRING(PAR:TIPS,'CN')
                  CLEAR(VAL:RECORD)
                  VAL:V_KODS=PAR:V_KODS
                  GET(VAL_K,VAL:KODS_KEY)
                  IF ~ERROR()
                     IF ~VAL:VAL !EIROZONA
                        PAV:VAL='EUR'
                     ELSE
                        PAV:VAL=VAL:VAL
                     .
                  ELSE
                     !PAV:VAL=VAL_LV
                     PAV:VAL=val_uzsk !15/12/2013
                  .
               ELSE
                  !PAV:VAL=VAL_LV
                  PAV:VAL=val_uzsk !15/12/2013
               .

               IF INRANGE(PAR:U_NR,26,50) AND INSTRING(PAV:D_K,'1D')   !D UZMANÎGI AR RAÞOÐANU
                  KLUDA(0,'Partneris ir Raþoðana U_NR: '&par:U_NR&' ,jâievada iepirkuma cenâs',,1)
               .
               pav:par_nr=par:U_nr
               par_nr=par:U_nr
               pav:noka=PAR:NOS_S
               ForcedParChange=1
               DO BRW2::InitializeBrowse  !Lai nomaina NOLIK, ja mainîts partneris
               DO BRW2::RefreshPage
               ForcedParChange=0
               ADRESEF=GETPAR_ADRESE(PAR:U_NR,0,1,0) !Ja nav citu,atgrieþ par:adrese,JA IR IZSAUC BROWSI
               PAV:PAR_ADR_NR=ADR:ADR_NR
               IF INRANGE(PAV:PAR_NR,1,50)
                  PAV:APM_V='5'  !APMAKSA NAV PAREDZÇTA
                  PAV:C_DATUMS=0
!               ELSIF INSTRING(PAV:D_K,'KP') AND (PAR:NOKL_DC OR SYS:NOKL_DC)
               ELSIF PAR:NOKL_DC OR SYS:NOKL_DC
                  PAV:APM_V='2' !PÇCAPMAKSA
                  DO C_DATUMS
                  PAV:C_DATUMS=PAV_C_DATUMS
               ELSE
                  PAV:APM_V='1'  !PRIEKÐAPMAKSA
!                  PAV:C_DATUMS=0
                  PAV:C_DATUMS=PAV_C_DATUMS
               .
               IF ~PAV:PAMAT
                  PAV:PAMAT=PAR:LIGUMS
               .
!               IF ~INRANGE(PAR:U_NR,1,50) AND ~(PAR:TIPS='C') AND ~(PAV:DOK_NR>999999)
!                  ?PAV:DOK_NR{PROP:TEXT}='@N06'
!               .
               IF INRANGE(PAV:PAR_NR,26,50) THEN UNHIDE(?BUTTONFIFO).
               IF INSTRING(PAV:D_K,'KP') AND CL_NR=1304 !EZERKAULIÒI
                  IF PAR:GRUPA[1:2]='VP'
                     IF INRANGE(PAR:GRUPA[3],1,5)
                        NOKL_CP=PAR:GRUPA[3]
        !                stop(nokl_cp)
                     ELSE
                        KLUDA(0,'Nav definçta cenu grupa '&CLIP(PAR:NOS_S))
                     .
                     PAV:MAK_NR=253
                  ELSIF PAR:GRUPA[1:4]='MEGO'
                     NOKL_CP=4
                     PAV:MAK_NR=523
                  .
                  MAKSTEXT= GETPAR_K(PAV:MAK_NR,0,1)
               .
               PAR_KRED_LIM=GETPAR_K(PAV:PAR_NR,0,22) !POZICIONÇJAM PAR_K ANYWAY
               DISPLAY
            .
         .
      END
    OF ?PAV:NOKA
      CASE EVENT()
      OF EVENT:Accepted
        ! ÐITO VAJAG !!!  22.10.2008
        !   DO BRW2::InitializeBrowse  !Lai nomaina NOLIK, ja mainîts PARTNERIS
        !   DO BRW2::RefreshPage
      END
    OF ?PAV:val
      CASE EVENT()
      OF EVENT:Accepted
        GET(Queue:FileDrop,CHOICE())
        PAV:val = FLD7::VAL:VAL
        DO BRW2::InitializeBrowse  !Lai nomaina NOLIK, ja mainîta valûta
        DO BRW2::RefreshPage
      END
    OF ?PAV:apm_v
      CASE EVENT()
      OF EVENT:Accepted
        !IF INSTRING(PAV:D_K,'KP') AND (PAR:NOKL_DC OR SYS:NOKL_DC)
        IF INSTRING(PAV:APM_V,'23') AND ~PAV:C_DATUMS  !PÇCAPMAKSA  PAV:APM_V '3'-realizâcijai
           DO C_DATUMS
           PAV:C_DATUMS=PAV_C_DATUMS
        .
        DISPLAY
      END
    OF ?PAV:apm_k:Radio1
      CASE EVENT()
      OF EVENT:Accepted
        select(?Browse:2)
      END
    OF ?PAV:apm_k:Radio2
      CASE EVENT()
      OF EVENT:Accepted
        select(?Browse:2)
      END
    OF ?PAV:apm_k:Radio3
      CASE EVENT()
      OF EVENT:Accepted
        select(?Browse:2)
      END
    OF ?PAV:T_PVN
      CASE EVENT()
      OF EVENT:Accepted
        IF PAV:T_PVN > 22
          IF StandardWarning(Warn:OutOfRangeHigh,'PAV:T_PVN','22')
            SELECT(?PAV:T_PVN)
            QuickWindow{Prop:AcceptAll} = False
            CYCLE
          END
        END
      END
    OF ?ButtonMaksatajs
      CASE EVENT()
      OF EVENT:Accepted
        IF PAV:MAK_NR
           PAR_NR=PAV:MAK_NR
        .
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowsePAR_K 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         IF GlobalResponse=RequestCompleted
            PAV:MAK_NR=PAR:U_NR
            MAKSTEXT=PAR:NOS_S
            DISPLAY
         .
      END
    OF ?ButtonParrekinat
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        CASE PAV:D_K
        OF 'K'
           clear(nol:record)
           pav_c_summa=0
           nol:u_nr=pav:u_nr
           set(nol:nr_key,nol:nr_key)
           loop
              next(nolik)
              if error() or ~(nol:u_nr=pav:u_nr) then break.
              if BAND(NOL:BAITS,00000001b) ! nav maksâts
                 pav_c_summa+=calcsum(4,1)
              .
           .
           pav:c_summa=ROUND(pav_c_summa,.01)
           IF INRANGE(PAV:SUMMA-PAV:C_SUMMA,-0.02,0.02)
              PAV:C_SUMMA=PAV:SUMMA
           .
           display
        .
      END
    OF ?ButtonUzliktP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        forcedparadschange=1  !Uzlikt visiem
        DO BRW2::InitializeBrowse
        DO BRW2::RefreshPage
        forcedparadschange=0
        PAV:C_SUMMA=PAV:SUMMA
        DISPLAY
      END
    OF ?ButtonNonemtP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        forcedparadschange=2  !Noòemt visiem
        DO BRW2::InitializeBrowse
        DO BRW2::RefreshPage
        forcedparadschange=0
        PAV:C_SUMMA=0
        DISPLAY
      END
    OF ?CurrentTab
      CASE EVENT()
      OF EVENT:Accepted
        DO RefreshWindow
      OF EVENT:NewSelection
          !Code to assign button control based upon current tab selection
          CASE CHOICE(?CurrentTab)
          OF 1
            DO FORM::AssignButtons
          OF 2
          OF 3
          OF 4
          OF 5
          OF 6
          OF 7
            DO BRW2::AssignButtons
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?Browse:2
      CASE EVENT()
      OF EVENT:NewSelection
        DO BRW2::NewSelection
      OF EVENT:ScrollUp
        DO BRW2::ProcessScroll
      OF EVENT:ScrollDown
        DO BRW2::ProcessScroll
      OF EVENT:PageUp
        DO BRW2::ProcessScroll
      OF EVENT:PageDown
        DO BRW2::ProcessScroll
      OF EVENT:ScrollTop
        DO BRW2::ProcessScroll
      OF EVENT:ScrollBottom
        DO BRW2::ProcessScroll
      OF EVENT:AlertKey
        DO BRW2::AlertKey
      OF EVENT:ScrollDrag
        DO BRW2::ScrollDrag
      END
    OF ?Insert:3
      CASE EVENT()
      OF EVENT:Accepted
        !IF ~PAV:VAL THEN PAV:VAL=VAL_LV.
        IF ~PAV:VAL THEN PAV:VAL=val_uzsk. !15/12/2013
        IF INSTRING(PAV:D_K,'KPR') AND SYS:Tuksni AND SYS:Tuksni=NPK  !bûs jâdrukâ no abâm pusçm
           KLUDA(47,'',,1)
        .
        DO SyncWindow
        DO BRW2::ButtonInsert
      END
    OF ?Change:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW2::ButtonChange
      END
    OF ?Delete:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW2::ButtonDelete
      END
    OF ?TR_V_KODS
      CASE EVENT()
      OF EVENT:Accepted
        PAV:TR_V_KODS=TR_V_KODS[1]
      END
    OF ?PIEG_N_KODS:2
      CASE EVENT()
      OF EVENT:Accepted
        PAV:PIEG_N_KODS=PIEG_N_KODS[1:3]
      END
    OF ?ButtonMUITA
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF F:DTK
           F:DTK=''
           ?BUTTONMUITA{PROP:TEXT}='proporcionâli muitai nomenklatûrâs'
        ELSE
           F:DTK='1'
           ?BUTTONMUITA{PROP:TEXT}='proporcionâli cenai'
        .
      END
    OF ?ButtonSadalitProporc
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF NOLIK::USED=0
           CHECKOPEN(NOLIK,1)
        .
        NOLIK::USED+=1
        
        LOCK_MUITA=0    !SUMMA, KAS NOLOKOTA UN NAV DALÂMA
        EXPL_MUITA=0    !SUMMA, KAS SADALÂMA STARP PÂRÇJÂM
        LOCK_AKCIZE=0   !SUMMA, KAS NOLOKOTA UN NAV DALÂMA
        EXPL_AKCIZE=0   !SUMMA, KAS SADALÂMA STARP PÂRÇJÂM
        LOCK_SUMMA=0    !SUMMA, KAS NOLOKOTA UN NAV DALÂMA
        EXPL_SUMMA=0    !SUMMA, KAS SADALÂMA STARP PÂRÇJÂM
        CHECKSUM=0
        
        CLEAR(NOL:RECORD)
        NOL:U_NR=PAV:U_NR
        SET(NOL:NR_KEY,NOL:NR_KEY)
        LOOP
           NEXT(NOLIK)
           IF ERROR() OR ~(PAV:U_NR=NOL:U_NR) THEN BREAK.
           IF NOL:LOCK         !RAKSTS IR SLÇGTS
              LOCK_MUITA+=NOL:MUITA
              LOCK_AKCIZE+=NOL:AKCIZE
              LOCK_SUMMA+=NOL:CITAS
           ELSE
              EXPL_MUITA+=GETNOM_K(NOL:NOMENKLAT,0,17)
              EXPL_AKCIZE+=GETNOM_K(NOL:NOMENKLAT,0,18)
              EXPL_SUMMA+=CALCSUM(3,4)
           .
        .
        
        IF LOCK_MUITA > PAV:MUITA
           KLUDA(0,'Slçgtâs muitas summas ðajâ P/Z > nekâ sadalâmâ summa...')
        ELSIF LOCK_AKCIZE > PAV:AKCIZE
           KLUDA(0,'Slçgtâs akcîzes summas ðajâ P/Z > nekâ sadalâmâ summa...')
        ELSIF LOCK_SUMMA > PAV:CITAS
           KLUDA(0,'Slçgtâs citu izmaksu summas ðajâ P/Z > nekâ sadalâmâ summa...')
        ELSE
           PAV_MUITA=PAV:MUITA-LOCK_MUITA
           PAV_AKCIZE=PAV:AKCIZE-LOCK_AKCIZE
           PAV_CITAS=PAV:CITAS-LOCK_SUMMA
           CLEAR(NOL:RECORD)
           NOL:U_NR=PAV:U_NR
           SET(NOL:NR_KEY,NOL:NR_KEY)
           LOOP
              NEXT(NOLIK)
              IF ERROR() OR ~(PAV:U_NR=NOL:U_NR) THEN BREAK.
              IF ~NOL:LOCK
                 SVMUI=GETNOM_K(NOL:NOMENKLAT,0,17)/EXPL_MUITA
                 SVAKC=GETNOM_K(NOL:NOMENKLAT,0,18)/EXPL_AKCIZE
                 SVARS=CALCSUM(3,4)/EXPL_SUMMA
                 IF F:DTK !DALÎT PROPORCIONÂLI SUMMAI
                    NOL:MUITA=PAV_MUITA*SVARS
                 ELSE
                    NOL:MUITA=PAV_MUITA*SVMUI
                 .
                 NOL:AKCIZE=PAV_AKCIZE*SVAKC
                 NOL:CITAS=PAV_CITAS*SVARS
                 CHECKSUM+=NOL:CITAS+NOL:MUITA+NOL:AKCIZE
                 IF RIUPDATE:NOLIK()
                    KLUDA(24,'NOLIK')
                 .
              .
           .
           IF ~(PAV_CITAS+PAV_MUITA+PAV_AKCIZE=CHECKSUM)
              KLUDA(0,'Noapaïojot radâs starpîba par Ls '&CHECKSUM-(PAV_CITAS+PAV_MUITA+PAV_AKCIZE),,1)
           .
           DO BRW2::RefreshPage
        .
        NOLIK::USED-=1
        IF NOLIK::USED=0 THEN CLOSE(NOLIK).
        SELECT(?Tab:1)
      END
    OF ?PAV:REK_NR
      CASE EVENT()
      OF EVENT:Accepted
        PAV:REK_NR=LEFT(INIGEN(PAV:REK_NR,10,1))
        DISPLAY
      END
    OF ?soferis
      CASE EVENT()
      OF EVENT:Accepted
        PAV::U_NR=PAV:U_NR
        AUT_NR=PAV:VED_NR
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseAuto 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        if globalresponse=requestcompleted
           PAV:VED_NR=AUT:U_NR
           DO MODIFYAUTO
           DISPLAY
        elsIF globalresponse=7 !NOÒEMT
           vedejs=''
           ved_auto=''
           PAV:VED_NR=0
           DISPLAY
        .
        AUT_NR=0
        PAV::U_NR=0
        
      END
    OF ?ButtonAUTAPK
      CASE EVENT()
      OF EVENT:Accepted
        PAV::U_NR=PAV:U_NR
        DO SyncWindow
        IF PAV:BAITS1=1 !SLÇGTS RAKSTS
           globalrequest=0
        ELSE
           IF CHECKSERVISS(PAV:U_NR)
              GLOBALREQUEST=changerecord
           ELSE
              GLOBALREQUEST=INSERTRECORD
           .
        .
        UPDATEAUTOAPK
        if globalresponse=requestcompleted
           PAV:VED_NR=APK:AUT_NR
           DO MODIFYAUTO
        .
        PAV::U_NR=0
        SELECT(?OK)
        DISPLAY
        
      END
    OF ?ButtonBilde
      CASE EVENT()
      OF EVENT:Accepted
         PAV::U_NR=PAV:U_NR
         IF RIUPDATE:PAVAD() !PLÂNOTÂJS IZKUSTINA
            KLUDA(24,PAVADNAME)
         .
        DO SyncWindow
        BrowseAU_BILDE 
        LocalRequest = OriginalRequest
        DO RefreshWindow
         PAV::U_NR=0
      END
    OF ?TR_V_KODS:2
      CASE EVENT()
      OF EVENT:Accepted
        PAV:TR_V_KODS=TR_V_KODS[1]
      END
    OF ?PIEG_N_KODS
      CASE EVENT()
      OF EVENT:Accepted
        PAV:PIEG_N_KODS=PIEG_N_KODS[1:3]
      END
    OF ?Teksts
      CASE EVENT()
      OF EVENT:Accepted
         IF DOS_CONT('TEX_NOL*.tps',2) > 1
            TTAKA"=PATH()
            IF ~FILEDIALOG('...TIKAI TEX_NOL*.tps FAILI !!!',TEXNAME,'TPS|TEX_NOL*.TPS',0)
               TEXNAME='TEX_NOL.TPS'
            .
            SETPATH(TTAKA")
         .
        DO SyncWindow
        GlobalRequest = SelectRecord
        BrowseTex 
        LocalRequest = OriginalRequest
        DO RefreshWindow
        IF GLOBALRESPONSE=REQUESTCOMPLETED
           TEKSTS1=TEX:TEKSTS1
           TEKSTS2=TEX:TEKSTS2
           TEKSTS3=TEX:TEKSTS3
           PAV:TEKSTS_NR=TEX:NR
        ELSE
           TEKSTS1=''
           TEKSTS2=''
           TEKSTS3=''
           PAV:TEKSTS_NR=0
        .
        DISPLAY
      END
    OF ?ButtonFIFO
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        CLEAR(NOL:RECORD)
        NOL:U_NR=PAV:U_NR
        SET(NOL:NR_KEY,NOL:NR_KEY)
        LOOP
           NEXT(NOLIK)
           IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
!           NOL:SUMMA=GETBIL_FIFO(NOL:NOMENKLAT,NOL:DATUMS,NOL:DAUDZUMS)
           NOL:SUMMAV=GETNOM_K(NOL:NOMENKLAT,0,7,6)
           NOL:SUMMA=NOL:SUMMAV
           NOL:VAL=VAL_LV
           IF RIUPDATE:NOLIK()
              KLUDA(24,'NOLIK')
           .
        .
        DO BRW2::RefreshPage
      END
    OF ?ButtonAtlaide
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
         SUMMA_W(3)
         IF GlobalResponse=RequestCompleted
           ATLAIDE_PR=SUMMA
           forcedatlchange=true
           DO BRW2::InitializeBrowse  !Lai nomaina NOLIK UN PIC NOM_K
           DO BRW2::RefreshPage
           forcedatlchange=false
           atlaide_pr=0
           SUMMA=0
           F:IDP=''
         .
      END
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
!         STOP(CHANGEPK&'  '&PAR_KRED_LIM)
         IF (LOCALREQUEST=1 OR LOCALREQUEST=2 OR CHANGEPK=TRUE) AND PAV:D_K='K' AND PAV:APM_V='2' AND PAR_KRED_LIM
            IF PAV:SUMMA > PAR_KRED_LIM
               KLUDA(0,'P/Z summa '&CLIP(PAV:SUMMA)&' lielâka par kredîtlimitu: '&CLIP(PAR_KRED_LIM))
               IF CL_NR=1033 OR CL_NR=1738  !ÍIPSALA, BAU UN SERVISS
                  SELECT(?Browse:2)
                  CYCLE
               .
            ELSE                    !tiek skaitîta BASE
               IF GGK::USED=0
                  CHECKOPEN(GGK,1)
               .
               GGK::USED+=1
               CHECKOPEN(GGK,1)
               CLEAR(ggk:record)
               CURR_KRED# = 0
               GGK:PAR_NR=PAV:PAR_NR
               SET(GGK:PAR_KEY,GGK:PAR_KEY)
               LOOP
                  NEXT(GGK)
                  IF ERROR() OR ~(GGK:PAR_NR=PAV:PAR_NR) THEN BREAK.
                  IF GGK:BKK[1:3]='231'
                     CASE GGK:D_K
                     OF 'D'
                        CURR_KRED# += GGK:SUMMA
                     OF 'K'
                        CURR_KRED# -= GGK:SUMMA
                     .
                  .
               .
               GGK::USED-=1
               IF GGK::USED=0 THEN CLOSE(GGK).
               CURR_KRED#+=PAV:SUMMA  !PIESKAITAM TEKOÐO

               IF ~(CURR_KRED# > PAR_KRED_LIM) !VÇL NOLIKTAVA:VARBÛT, KA ÐODIEN JAU KAUT KO IR PIRCIS
                  SAV_RECORD=PAV:RECORD
                  SAV_U_NR=PAV:U_NR
                  SAV_POSITION=POSITION(PAV:DAT_KEY)
                  CLEAR(PAV:RECORD)
                  PAV:DATUMS=TODAY()
                  PAV:PAR_NR=PAR:U_NR
                  PAV:D_K='K'
                  SET(PAV:PAR_KEY,PAV:PAR_KEY)
                  LOOP
                     NEXT(PAVAD)
                     IF ERROR() OR ~(PAV:PAR_NR=PAR:U_NR) OR ~(PAV:DATUMS=TODAY()) OR ~(PAV:D_K='K')
                        BREAK
                     .
                     IF PAV:APM_V='2' AND ~(SAV_U_NR=PAV:U_NR) !PÇCAPMAKSA UN BEZ TEKOÐÂ RAKSTA
                        CURR_KRED#+=PAV:SUMMA
                     .
                  .
                  RESET(PAV:DAT_KEY,SAV_POSITION)
                  NEXT(PAVAD)
                  PAV:RECORD=SAV_RECORD
               .
               IF CURR_KRED# > PAR_KRED_LIM
                  KLUDA(0,'Tiek pârsniegts kredîtlimits: Ls'&CLIP(PAR_KRED_LIM)&' Parâda un P/Z summa: Ls'&CURR_KRED#,9)
                  IF KLU_DARBIBA !ATLIKT(ÐITAM OTRÂDI)
                     SELECT(?Browse:2)
                     CYCLE
                  ELSE
                     IF (CL_NR=1033 OR CL_NR=1738) AND ~(PAR:ATZIME1=12) !ÍIPSALA, BAU
                        PAR:ATZIME1=12
                        I#=RIUPDATE:PAR_K()
                     .
                  .
               .
            .
         .
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
         IF ~(LOCALREQUEST=3)
            PAV:ACC_KODS=ACC_kods
            PAV:ACC_DATUMS=today()
!            IF INSTRING(PAV:APM_V,'1345')
            IF INSTRING(PAV:APM_V,'345')
               PAV:C_DATUMS=0
               PAV:C_SUMMA=0
            .
         .
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        VCRRequest = VCRNone
        POST(Event:CloseWindow)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF AUTO::Used = 0
    CheckOpen(AUTO,1)
  END
  AUTO::Used += 1
  BIND(AUT:RECORD)
  IF AUTOAPK::Used = 0
    CheckOpen(AUTOAPK,1)
  END
  AUTOAPK::Used += 1
  BIND(APK:RECORD)
  IF AUTODARBI::Used = 0
    CheckOpen(AUTODARBI,1)
  END
  AUTODARBI::Used += 1
  BIND(APD:RECORD)
  IF NOLIK::Used = 0
    CheckOpen(NOLIK,1)
  END
  NOLIK::Used += 1
  BIND(NOL:RECORD)
  IF PAR_A::Used = 0
    CheckOpen(PAR_A,1)
  END
  PAR_A::Used += 1
  BIND(ADR:RECORD)
  IF PAR_K::Used = 0
    CheckOpen(PAR_K,1)
  END
  PAR_K::Used += 1
  BIND(PAR:RECORD)
  IF PAVAD::Used = 0
    CheckOpen(PAVAD,1)
  END
  PAVAD::Used += 1
  BIND(PAV:RECORD)
  IF PROJEKTI::Used = 0
    CheckOpen(PROJEKTI,1)
  END
  PROJEKTI::Used += 1
  BIND(PRO:RECORD)
  IF TEKSTI::Used = 0
    CheckOpen(TEKSTI,1)
  END
  TEKSTI::Used += 1
  BIND(TEX:RECORD)
  IF VAL_K::Used = 0
    CheckOpen(VAL_K,1)
  END
  VAL_K::Used += 1
  BIND(VAL:RECORD)
  FilesOpened = True
  IF LOCALREQUEST=DELETERECORD
     CLEAR(NOL:RECORD)
     NOL:U_NR=PAV:U_NR
     SET(NOL:NR_KEY,NOL:NR_KEY)
     LOOP
        NEXT(NOLIK)
        IF ERROR() OR ~(NOL:U_NR=PAV:U_NR) THEN BREAK.
        N:D_K=NOL:D_K
        N:NOMENKLAT=NOL:NOMENKLAT
        N:DAUDZUMS=NOL:DAUDZUMS
        ADD(N_TABLE)
        IF ERROR() THEN STOP('RAKSTOT N_TABLE:'&ERROR()).
     .
  .
  RISnap:PAVAD
  SAV::PAV:Record = PAV:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
!    IF ~PAV:DokDAT THEN PAV:DokDAT=TODAY().
!    IF ~PAV:DATUMS THEN PAV:DATUMS=TODAY().
    PAV:DokDAT=TODAY()
    PAV:DATUMS=TODAY()
    SAV_DATUMS=TODAY() ! TAS SAV_D PARÂDÂS CORÇ
    PAV:T_PVN=SYS:NOKL_PVN !12.12.08
    PAV:C_DATUMS=0
    PAV:ACC_KODS=ACC_kods
    PAV:ACC_DATUMS=today()
    PAV:DATUMS=GETFING(3,PAV:DATUMS) !3-AR FING KONTROLI
!    IF ~(YEAR(PAV:DATUMS)=DB_GADS)
!       KLUDA(23,DB_GADS&'. gadu')
!    .
    NEW_PAV = 1   !Elya kopejam summu uz paradu tikai jaunam pavadzimem
    IF COPYREQUEST=1
       CLEAR(NOL:RECORD)
       NOL:U_NR=PAV::U_NR
       SET(NOL:NR_KEY,NOL:NR_KEY)
       LOOP
          NEXT(NOLIK)
          IF ERROR() OR ~(NOL:U_NR=PAV::U_NR) THEN BREAK.
          R:RECORD=NOL:RECORD
          ADD(R_TABLE)
       .
       LOOP I#=1 TO RECORDS(R_TABLE)
          GET(R_TABLE,I#)
          NOL:RECORD  =R:RECORD
          NOL:U_NR    =PAV:U_NR
          NOL:DATUMS  =PAV:DATUMS
          NOL:DAUDZUMS=NOL:DAUDZUMS*ZIME
          IF INRANGE(NOKL_CENA,1,6)
             NOL:SUMMAV = GETNOM_K(NOL:NOMENKLAT,2,7,NOKL_CENA)*NOL:DAUDZUMS
             NOL:ARBYTE = 0             !bez pvn
             IF GETNOM_K('POZICIONÇTS',0,10) THEN NOL:ARBYTE=1.
          .
          NOL:SUMMA=NOL:SUMMA*ZIME
          NOL:SUMMAV=NOL:SUMMAV*ZIME
          ADD(NOLIK)
          AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,'','',0)  !02.04.08.
          KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
       .
       FREE(R_TABLE)
    ELSE
       PAV:NODALA=SYS:NODALA
       IF SUP_A4_NR=2   !GARANTIJAS Nr
          PAV:apm_v='5' !NAV PAREDZÇTA
          PAV:apm_k='5' !RÛPNÎCAS GARANTIJA
       ELSE
          PAV:apm_v='2'
          PAV:apm_k='1'
       .
       !PAV:VAL=VAL_LV
       PAV:VAL=val_uzsk !15/12/2013
    .
    IF PAV_DOK_SE=SYS:PZ_SERIJA AND INRANGE(SYS:PZ_NR_END-PAV_DOK_NR,0,5)! TÎKLÂ ÐITAIS PÂRTRAUKUMS PIRMS ADD
                                                                           ! VAR IEDOT==DUS SE_NRUS
       KLUDA(0,'PPR numerâcijas apgabalâ vçl atlikuðas '&CLIP(SYS:PZ_NR_END-PAV_DOK_NR)&' pavadzîmes',,1)
    .

  END
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('UpdatePAVAD','winlats.INI')
  WinResize.Resize
  BRW2::AddQueue = True
  BRW2::RecordCount = 0
  BIND('BRW2::Sort1:Reset:PAV:U_NR',BRW2::Sort1:Reset:PAV:U_NR)
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?Browse:2{Prop:Alrt,255} = InsertKey
  ?Browse:2{Prop:Alrt,254} = DeleteKey
  ?Browse:2{Prop:Alrt,253} = CtrlEnter
  ?Browse:2{Prop:Alrt,252} = MouseLeft2
  ?PAV:U_NR{PROP:Alrt,255} = 734
  ?PAV:NODALA{PROP:Alrt,255} = 734
  ?PAV:OBJ_NR{PROP:Alrt,255} = 734
  ?PAV:DOK_SENR{PROP:Alrt,255} = 734
  ?PAV:DOKDAT{PROP:Alrt,255} = 734
  ?PAV:DATUMS{PROP:Alrt,255} = 734
  ?PAV:NOKA{PROP:Alrt,255} = 734
  ?PAV:PAR_NR{PROP:Alrt,255} = 734
  ?PAV:val{PROP:Alrt,255} = 734
  ?PAV:apm_v{PROP:Alrt,255} = 734
  ?PAV:apm_k{PROP:Alrt,255} = 734
  ?PAV:PAMAT{PROP:Alrt,255} = 734
  ?PAV:PIELIK{PROP:Alrt,255} = 734
  ?PAV:T_SUMMA{PROP:Alrt,255} = 734
  ?PAV:T_PVN{PROP:Alrt,255} = 734
  ?PAV:C_DATUMS{PROP:Alrt,255} = 734
  ?PAV:C_SUMMA{PROP:Alrt,255} = 734
  ?PAV:MAK_NR{PROP:Alrt,255} = 734
  ?PAV:SUMMA{PROP:Alrt,255} = 734
  ?PAV:SUMMA_A{PROP:Alrt,255} = 734
  ?PAV:SUMMA_B{PROP:Alrt,255} = 734
  ?PAV:DEK_NR{PROP:Alrt,255} = 734
  ?PAV:KIE_NR:2{PROP:Alrt,255} = 734
  ?PAV:DAR_V_KODS{PROP:Alrt,255} = 734
  ?PAV:MUITA{PROP:Alrt,255} = 734
  ?PAV:AKCIZE{PROP:Alrt,255} = 734
  ?PAV:CITAS{PROP:Alrt,255} = 734
  ?PAV:KIE_NR{PROP:Alrt,255} = 734
  ?PAV:REK_NR{PROP:Alrt,255} = 734
  ?PAV:DAR_V_KODS:2{PROP:Alrt,255} = 734
  ?PAV:TEKSTS_NR{PROP:Alrt,255} = 734
  ?PAV:ACC_KODS{PROP:Alrt,255} = 734
  ?PAV:ACC_DATUMS{PROP:Alrt,255} = 734
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
    IF LOCALREQUEST=DELETERECORD AND LOCALRESPONSE=REQUESTCOMPLETED
       LOOP I#= 1 TO RECORDS(N_TABLE)
          GET(N_TABLE,I#)
          ATLIKUMIN('','',0,N:D_K,N:NOMENKLAT,N:DAUDZUMS)
          KopsN(N:NOMENKLAT,PAV:DATUMS,N:D_K)
       .
    ELSIF LOCALREQUEST=CHANGERECORD AND LOCALRESPONSE=REQUESTCOMPLETED AND GETDOK_SENR(1,PAV:DOK_SENR,,'2')=SYS:PZ_SERIJA|
       AND SYS:PZ_NR_END AND INRANGE(SYS:PZ_NR_END-GETDOK_SENR(2,PAV:DOK_SENR,,'2'),0,5) AND PAV:D_K='K'
       KLUDA(0,'PPR numerâcijas apgabalâ vçl atlikuðas '&CLIP(SYS:PZ_NR_END-GETDOK_SENR(2,PAV:DOK_SENR,,'2'))&' pavadzîmes',,1)
    .
    !STOP(GETDOK_SENR(1,PAV:DOK_SENR,,'2')&'='&SYS:PZ_SERIJA&'-'&SYS:PZ_NR_END&'='&GETDOK_SENR(2,PAV:DOK_SENR,,'2'))
    FREE(N_TABLE)
    AUTO::Used -= 1
    IF AUTO::Used = 0 THEN CLOSE(AUTO).
    AUTOAPK::Used -= 1
    IF AUTOAPK::Used = 0 THEN CLOSE(AUTOAPK).
    AUTODARBI::Used -= 1
    IF AUTODARBI::Used = 0 THEN CLOSE(AUTODARBI).
    NOLIK::Used -= 1
    IF NOLIK::Used = 0 THEN CLOSE(NOLIK).
    PAR_A::Used -= 1
    IF PAR_A::Used = 0 THEN CLOSE(PAR_A).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
    PAVAD::Used -= 1
    IF PAVAD::Used = 0 THEN CLOSE(PAVAD).
    PROJEKTI::Used -= 1
    IF PROJEKTI::Used = 0 THEN CLOSE(PROJEKTI).
    TEKSTI::Used -= 1
    IF TEKSTI::Used = 0 THEN CLOSE(TEKSTI).
    VAL_K::Used -= 1
    IF VAL_K::Used = 0 THEN CLOSE(VAL_K).
  END
  IF WindowOpened
    INISaveWindow('UpdatePAVAD','winlats.INI')
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
  DO BRW2::SelectSort
  ?Browse:2{Prop:VScrollPos} = BRW2::CurrentScroll
  DISPLAY()
  ForceRefresh = False
!---------------------------------------------------------------------------
SyncWindow ROUTINE
!|
!| This routine is used to insure that any records pointed to in control
!| templates are fetched before any procedures are called via buttons or menu
!| options.
!|
  DO BRW2::GetRecord
!---------------------------------------------------------------------------
MODIFYAUTO    ROUTINE
    vedejs=Getauto(pav:ved_nr,3)
    ved_auto=Getauto(pav:ved_nr,5)
    IF ~(ATLAUTS[20]='1')  !~AIZLIEGTS SERVISS
       UNHIDE(?BUTTONAUTAPK)
       ENABLE(?BUTTONAUTAPK)                             !JA RAKSTS SLÇGTS, ATVERAM POGU
       IF PAV:VED_NR
          IF CHECKSERVISS(PAV:U_NR,PAV:VED_NR)
             IF ~PAV:REK_NR THEN PAV:REK_NR=PERFORMGL(5). !PIEÐÍIRAM RÇÍINA NR
             IF ~PAV:PAMAT THEN PAV:PAMAT='N '&CLIP(PAV:REK_NR)&' '&Getauto(pav:ved_nr,9).
             SERVISS=TRUE
             UNHIDE(?ImageSERVISS)
          .
       .
       IF ~AU_BILDE::USED         !NETIEK SAUKTS NO FAILIEM
          IF CL_NR=1102 OR|       !ADREM
             CL_NR=1464 OR|       !AUTO ÎLE
             CL_NR=1454 OR|       !SD AUTOCENTRS
             ACC_KODS_N=0
             ENABLE(?ButtonBilde) !SERVISA PLÂNOTÂJS
          .
       .
    .
    DISPLAY

MODIFYSCREEN  ROUTINE
 IF INRANGE(LOCALREQUEST,1,2)
    IF ATLAUTS[18]='1'  !AIZLIEGTI NEAPSTIPRINÂTIE
       HIDE(?Rakstastatuss)
       DISABLE(?Rakstastatuss)
    ELSE
       IF PAV:RS
          UNHIDE(?IMAGERS)
       ELSE
          HIDE(?IMAGERS)
       .
    .
    IF INSTRING(PAV:D_K,'DK')
!       IF INSTRING(PAV:apm_v,'145')
       IF INSTRING(PAV:apm_v,'45')
          DISABLE(?PAV:C_DATUMS)
          DISABLE(?PAV:C_SUMMA)
          HIDE(?BUTTONPARREKINAT)
          HIDE(?BUTTONUZLIKTP)
          HIDE(?BUTTONNONEMTP)
       ELSE
          ENABLE(?PAV:C_DATUMS)
          ENABLE(?PAV:C_SUMMA)
          UNHIDE(?BUTTONPARREKINAT)
          UNHIDE(?BUTTONUZLIKTP)
          UNHIDE(?BUTTONNONEMTP)
       .
    .
    CASE LOCALREQUEST
    OF 1
       IF RECORDS(Queue:Browse:2) OR CHECKSERVISS(PAV:U_NR)
          DISABLE(?CANCEL)
          ALIAS(EscKey,0) ! Novâcam EscKey
       ELSE
          ENABLE(?CANCEL)
          ALIAS
       .
    OF 2
       IF CANCEL_OFF
          DISABLE(?CANCEL)
          ALIAS(EscKey,0) ! Novâcam EscKey
       ELSE
          ENABLE(?CANCEL)
          ALIAS
       .
    .
 .
 IF PAV:U_NR=1      !SALDO
    HIDE(?ButtonAtlaide)
 .
 DISPLAY

C_DATUMS  ROUTINE
 IF PAR:NOKL_DC_TIPS='1' !Bankas dienas
    SKAITITAJS#=0  !CIK BANKAS DIENÂM JÂSANÂK
    PAV_C_DATUMS=PAV:DATUMS
    LOOP
       IF SKAITITAJS#=PAR:NOKL_DC THEN BREAK.
       PAV_C_DATUMS+=1
       IF ~(PAV_C_DATUMS%7=0 OR PAV_C_DATUMS%7=6)
          SKAITITAJS#+=1
       .
    .
 ELSIF PAR:NOKL_DC_TIPS='2' !Nenorâdît apmaksas termiòu
    PAV_C_DATUMS=0
 ELSIF PAR:NOKL_DC
    PAV_C_DATUMS=PAV:DATUMS+PAR:NOKL_DC
 ELSE
    PAV_C_DATUMS=PAV:DATUMS+SYS:NOKL_DC
 .

!----------------------------------------------------------------------
ASSIGN_U_NR  ROUTINE
    SET(PAV:NR_KEY)
    PREVIOUS(PAVAD)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
     POST(Event:CloseWindow)
     EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAV:U_NR = 1
    ELSE
     Auto::Save:PAV:U_NR = PAV:U_NR + 1
    END
    PAV:Record = SAV::PAV:Record
    PAV:U_NR = Auto::Save:PAV:U_NR
    SAV::PAV:Record = PAV:Record

!----------------------------------------------------------------------
ASSIGN_DOK_NR  ROUTINE    !ÐITO JOKU IZPILDAM TIKAI K-P-R
!    Auto::Save:PAV_DOK_SE = PAV_DOK_SE
    !Stop('PAV:D_K '&PAV:D_K)
    D_K" = PAV:D_K
    CLEAR(PAV:DOK_SENR,1)
    PAV:DOK_SENR = CLIP(PAV_DOK_SE)&CHR(33) !'!'
    SET(PAV:SENR_KEY,PAV:SENR_KEY)    !SÂKAM AR PIEPRASÎTÂS SÇRIJAS LIELÂKO Nr PIRMS USERA SABAKSTÎTÂM BLÇÒÂM
    LOOP
       PREVIOUS(PAVAD)
       !Stop('PAV_DOK_SE '&PAV_DOK_SE)
       !Stop('PAV:D_K '&PAV:D_K)
       IF ERRORCODE() AND ERRORCODE() <> BadRecErr
         StandardWarning(Warn:RecordFetchError,'PAVAD')
         POST(Event:CloseWindow)
         EXIT
       .
        IF ERRORCODE() OR ~(GETDOK_SENR(1,PAV:DOK_SENR,,'2')=PAV_DOK_SE) !Nav atradis tâdu sçriju....
         IF SUP_A4_NR=1 !Vajag SUP/A4 Nr - VAR BÛT TIKAI KREDÎTS
            PAV_DOK_NR = SYS:PZ_NR  !Nr_no
         ELSE
            PAV_DOK_NR = 1
         .
       ELSIF (D_K" = 'P') AND ~(PAV:D_K='P')  !31/05/2015
         CYCLE                                                      !31/05/2015
       ELSIF (D_K" = 'K') AND ~(PAV:D_K='K')  !31/05/2015
         CYCLE                                                      !31/05/2015
       ELSIF INSTRING(PAV:D_K,'1D') !IGNORÇJAM VISUS 1-D AR TÂDU PAÐU SÇRIJU un lielâku Nr....
         CYCLE
       ELSE
         PAV_DOK_NR = GETDOK_SENR(2,PAV:DOK_SENR,,'2') + 1
       .
       PAV:Record = SAV::PAV:Record
       PAV:DOK_SENR = GETDOK_SENR(3,PAV_DOK_SE,PAV_DOK_NR)  
       SAV::PAV:Record = PAV:Record
       BREAK
    .
!----------------------------------------------------------------------
BRW2::SelectSort ROUTINE
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
!|    f. The BrowseBox is reinitialized (BRW2::InitializeBrowse ROUTINE).
!| 4. If step 3 is not necessary, the record buffer is refilled from the currently highlighted BrowseBox item.
!|
  BRW2::LastSortOrder = BRW2::SortOrder
  BRW2::Changed = False
  IF BRW2::SortOrder = 0
    BRW2::SortOrder = 1
  END
  IF BRW2::SortOrder = BRW2::LastSortOrder
    CASE BRW2::SortOrder
    OF 1
      IF BRW2::Sort1:Reset:PAV:U_NR <> PAV:U_NR
        BRW2::Changed = True
      END
    END
  ELSE
  END
  IF BRW2::SortOrder <> BRW2::LastSortOrder OR BRW2::Changed OR ForceRefresh
    CASE BRW2::SortOrder
    OF 1
      BRW2::Sort1:Reset:PAV:U_NR = PAV:U_NR
    END
    DO BRW2::GetRecord
    DO BRW2::Reset
    IF BRW2::LastSortOrder = 0
      IF LocalRequest = SelectRecord
        BRW2::LocateMode = LocateOnValue
        DO BRW2::LocateRecord
      ELSE
        FREE(Queue:Browse:2)
        BRW2::RefreshMode = RefreshOnTop
        DO BRW2::RefreshPage
        DO BRW2::PostNewSelection
      END
    ELSE
      IF BRW2::Changed
        FREE(Queue:Browse:2)
        BRW2::RefreshMode = RefreshOnTop
        DO BRW2::RefreshPage
        DO BRW2::PostNewSelection
      ELSE
        BRW2::LocateMode = LocateOnValue
        DO BRW2::LocateRecord
      END
    END
    IF BRW2::RecordCount
      GET(Queue:Browse:2,BRW2::CurrentChoice)
      DO BRW2::FillBuffer
    END
    DO BRW2::InitializeBrowse
  ELSE
    IF BRW2::RecordCount
      GET(Queue:Browse:2,BRW2::CurrentChoice)
      DO BRW2::FillBuffer
    END
  END
!----------------------------------------------------------------------
BRW2::InitializeBrowse ROUTINE
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
  IF SEND(NOLIK,'QUICKSCAN=on').
  SETCURSOR(Cursor:Wait)
  DO BRW2::Reset
     pav:summa=0
     PAV_SUMMA_A=0
     NPK=0
     A_DAUDZUMS=0
     PICSUMMA=0
     REASUMMA=0
     PVNMASMODE=0 !0=18% 1=21% 3=22%
  
     FILLPVN(0)
  !***********PAV:MUITA,AKCIZE,CITAS**********
     PAV:MUITA=0
     PAV:AKCIZE=0
     PAV:CITAS=0
  LOOP
    NEXT(BRW2::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW2::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'NOLIK')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW2::FillQueue
    IF PAV:U_NR=NOL:U_NR !SUPERKONTROLE GADÎJUMAM, JA NOBRUCIS BROWSIS
       !*********** DK **********
       IF ~(NOL:D_K=PAV:D_K) OR SIGN#=-1 !MAINÎTS D_K VAI ZÎME
          SAV_D_K=NOL:D_K
          NOL:D_K=PAV:D_K
!          STOP(SIGN#)   TÂ ARÎ BIJA 0-LLÇÐANAS VAINA
          NOL:DAUDZUMS=NOL:DAUDZUMS*SIGN#
          NOL:SUMMA   =NOL:SUMMA*SIGN#
          NOL:SUMMAV  =NOL:SUMMAV*SIGN#
          IF RIUPDATE:NOLIK()
            KLUDA(24,'NOLIK')
          ELSE
            AtlikumiN(NOL:D_K,NOL:NOMENKLAT,NOL:DAUDZUMS,SAV_D_K,NOL:NOMENKLAT,NOL:DAUDZUMS)
            KopsN(NOL:NOMENKLAT,NOL:DATUMS,SAV_D_K)
            KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
            IF SAV_D_K='P' AND NOL:D_K='K'
               IF ~INSTRING(GETNOM_K(NOL:NOMENKLAT,0,16),'TRAV',1) AND GETNOM_A(NOL:NOMENKLAT,1,0)<0
                  KLUDA(77,CLIP(NOL:NOMENKLAT)&'...pierakstiet un atlabojiet')
                  IF NOL:DAUDZUMS AND ATLAUTS[23]='1' !AIZLIEGTS TIRGOT AR MÎNUSATLIKUMIEM
                     PAV:D_K=SAV_D_K
                     D_K_CHANGEERROR=TRUE
                  .
               .
               NOM_PIC=GETNOM_K(NOL:NOMENKLAT,0,7,6)
               IF  ~INRANGE(NOL:PAR_NR,1,50) AND ~(NOL:NOMENKLAT[1:4]='IEP*') AND |
               NOM_PIC > round(CALCSUM(15,3)/NOL:DAUDZUMS,.001) ! Ls bez PVN -A
                  KLUDA(0,'Realizâcijas cena mazâka par pçdçjo iepirkuma cenu...'&NOL:NOMENKLAT)
               .
               NOM_MINRC=GETNOM_K(NOL:NOMENKLAT,0,27)
               IF ~INRANGE(NOL:PAR_NR,1,50) AND NOM_MINRC AND NOM_MINRC > round(CALCSUM(15,3)/NOL:DAUDZUMS,.001) !Ls bez PVN -A
                  KLUDA(0,'Realizâcijas cena mazâka par MIN realizâcijas cenu...'&NOL:NOMENKLAT)
                  IF ATLAUTS[24]='1' !AIZLIEGTS TIRGOT ZEM MIN RC
                     PAV:D_K=SAV_D_K
                     D_K_CHANGEERROR=TRUE
                  .
               .
            .
          .
          CANCEL_OFF=TRUE
       .
       !***********valûtas un valûtas pârrçíinu kontrole**********
       IF ~(NOL:VAL=PAV:VAL)
          IF ~PAV:VAL
             !PAV:VAL=VAL_LV
             PAV:VAL=val_uzsk !15/12/2013
          .
          NOL:VAL=PAV:VAL
          NOL:SUMMA=NOL:SUMMAV*BANKURS(NOL:VAL,NOL:DATUMS)
          IF RIUPDATE:NOLIK()
            KLUDA(24,'NOLIK')
          ELSE
            KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
          .
          CANCEL_OFF=TRUE
       .
       !***********datumu (un valûtas pârrçíinu) kontrole**********
       IF ~(NOL:DATUMS=PAV:DATUMS)
          SAV_DATUMS=NOL:DATUMS
          NOL:DATUMS=PAV:DATUMS
          NOL:SUMMA=NOL:SUMMAV*BANKURS(NOL:VAL,NOL:DATUMS)
          IF RIUPDATE:NOLIK()
            KLUDA(24,'NOLIK')
          ELSE
            IF NOL:D_K='D' OR ~(MONTH(SAV_DATUMS)=MONTH(NOL:DATUMS))
               KopsN(NOL:NOMENKLAT,SAV_DATUMS,NOL:D_K)
               KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
            .
          .
          IF SERVISS=TRUE
             CLEAR(APK:RECORD)
             APK:PAV_NR=PAV:U_NR
             SET(APK:PAV_KEY,APK:PAV_KEY)
             LOOP
                NEXT(AUTOAPK)
                IF ERROR() OR ~(APK:PAV_NR=PAV:U_NR) THEN BREAK.
                IF ~(APK:DATUMS=PAV:DATUMS)
                    APK:DATUMS=PAV:DATUMS
                    IF RIUPDATE:AUTOAPK()
                       KLUDA(24,'AUTOAPK')
                    .
                .
             .
             CLEAR(APD:RECORD)
             APD:PAV_NR=PAV:U_NR
             SET(APD:NR_KEY,APD:NR_KEY)
             LOOP
                NEXT(AUTODARBI)
                IF ERROR() OR ~(APD:PAV_NR=PAV:U_NR) THEN BREAK.
                IF ~(APD:DATUMS=PAV:DATUMS)
                    APD:DATUMS=PAV:DATUMS
                    IF RIUPDATE:AUTODARBI()
                       KLUDA(24,'AUTODARBI')
                    .
                .
             .
          .
          CANCEL_OFF=TRUE
       .
       !***********raksta statusa kontrole**********
       IF ~(NOL:rs=PAV:rs)
          NOL:rs=PAV:rs
          IF RIUPDATE:NOLIK()
            KLUDA(24,'NOLIK')
          ELSE
            KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
          .
          CANCEL_OFF=TRUE
       .
       !***********partneru kontrole**********
       IF ForcedParChange=1  !Lai saglabâtu Partnerus no pos-a
          NOL:par_nr=PAV:par_nr
          IF RIUPDATE:NOLIK()
            KLUDA(24,'NOLIK')
          .
          CANCEL_OFF=TRUE
       .
       !***********PROJEKTU kontrole**********
       IF ~NOL:OBJ_NR OR NOL:OBJ_NR=SAV_OBJ_NR  !Lai saglabâtu CITUS PROJEKTUS
          IF ~(NOL:OBJ_NR=PAV:OBJ_nr)
             NOL:OBJ_NR=PAV:OBJ_nr
             IF RIUPDATE:NOLIK()
                KLUDA(24,'NOLIK')
             .
             CANCEL_OFF=TRUE
          .
       .
       !***********parâdu uzlikðana/noòemðana**********
       IF ForcedParadsChange=1
          IF ~BAND(NOL:BAITS,00000001b) !PARÂDA NAV
             NOL:BAITS+=1
             IF RIUPDATE:NOLIK()
               KLUDA(24,'NOLIK')
             .
          .
       ELSIF ForcedParadsChange=2
          IF BAND(NOL:BAITS,00000001b) !PARÂDS IR
             NOL:BAITS-=1
             IF RIUPDATE:NOLIK()
               KLUDA(24,'NOLIK')
             .
          .
       .
       !***********atlaides maiòa**********
       IF ForcedAtlChange=true
          SKIP#=FALSE
          IF GETNOM_K(NOL:NOMENKLAT,0,1)
             IF NOL:D_K='D'
                NOL:atlaide_pr=atlaide_pr
                IF ~INRANGE(NOL:PAR_NR,1,25) AND NOM:PIC_DATUMS<=NOL:DATUMS
                   NOM:PIC=round(CALCSUM(15,3)/NOL:DAUDZUMS,.001) ! Ls bez PVN -A
                   NOM:PIC_DATUMS=NOL:DATUMS
                   IF RIUPDATE:NOM_K()
                      KLUDA(24,'NOM_K')
                   .
                .
             ELSIF (INSTRING(NOL:D_K,'KP') AND ~BAND(NOM:NEATL,00000001b)) OR NOL:D_K='1' !NAV AIZLIEGTS DOT ATLAIDI KP VAI D-PROJEKTS
                EXECUTE F:IDP
                   NOL:atlaide_pr=atlaide_pr
                   NOL:atlaide_pr+=atlaide_pr
                   NOL:ATLAIDE_PR=GETPAR_ATLAIDE(PAR:Atlaide,NOL:NOMENKLAT)
                .
                IF nol:d_k='K' AND ~INRANGE(NOL:PAR_NR,1,50) AND NOM:MINRC AND NOM:MINRC > round(CALCSUM(15,3)/NOL:DAUDZUMS,.001) ! Ls bez PVN -A
                   KLUDA(0,'Realizâcijas cena mazâka par MIN real.cenu...'&NOM:NOS_P)
                   IF ATLAUTS[24]='1' !AIZLIEGTS TIRGOT ZEM MIN RC
                      SKIP#=TRUE
                   .
                .
             ELSE
                SKIP#=TRUE
             .
             IF ~SKIP#
                IF RIUPDATE:NOLIK()
                  KLUDA(24,'NOLIK')
                ELSE
                  KopsN(NOL:NOMENKLAT,NOL:DATUMS,NOL:D_K)
                .
                CANCEL_OFF=TRUE
             .
          .
       .
       !***********PAV:ATLAIDE**********
       PAV_SUMMA_A+=CALCSUM(8,1)
       !***********PAV:SUMMA**********
       FILLPVN(1)
       !***********PAV:MUITA,AKCIZE,CITAS**********
       PAV:MUITA+=NOL:MUITA
       PAV:AKCIZE+=NOL:AKCIZE
       PAV:CITAS+=NOL:CITAS
       !***********SKAITAM DARBUS**********
       IF SERVISS=TRUE
          IF GETNOM_K(NOL:NOMENKLAT,0,16)='A'
             A_DAUDZUMS+=NOL:DAUDZUMS
          .
       .
       !***********SKAITAM PIC**********
       IF ~(ATLAUTS[11]='1') !AIZLIEGTS APSKATÎT D P/Z UN JEBKURU PIEEJU IEP CENÂM
          IF INSTRING(GETNOM_K(NOL:NOMENKLAT,0,16),'PRK') AND| !TIKAI PRECEI&RAÞOJUMAM&KOKIEM
          GETNOM_K(NOL:NOMENKLAT,0,7,6) > 0                   !JA PIC>0
             PICSUMMA+=GETNOM_K(NOL:NOMENKLAT,0,7,6)*NOL:DAUDZUMS
             REASUMMA+=CALCSUM(15,3)  !BEZ PVN Ls-A
          .
       .
       !***********Ierakstu skaits**********
       npk+=1
    .
    
    ! STOP('BrTotLoop')
  END
  !  PAV:SUMMA=ROUND(GETPVN(3),.01)+ROUND(getpvn(1)+pav:t_summa*(1-1/(1+PAV:T_PVN/100)),.01)
    PAV:SUMMA=ROUND(GETPVN(3),.01)+ROUND(getpvn(1),.01)+|
              PAV:T_Summa                          !P/Z SUMMA BEZ PVN+PVN+TRANSPORTS AR PVN 10/03/03
    PAV:SUMMA_B=ROUND(GETPVN(3),.01)               !P/Z SUMMA BEZ PVN,(BEZ TRANSPORTA?)
    PAV:SUMMA_A=ROUND(PAV_SUMMA_A,.01)
    IF INRANGE(LOCALREQUEST,1,2) AND INSTRING(PAV:APM_V,'23') !PÇCAPMAKSA/REALIZÂCIJAI
       !PAV:C_SUMMA=PAV:SUMMA  !Elya
       IF NEW_PAV = 1   !Elya
          PAV:C_SUMMA=PAV:SUMMA
       .
    .
    IF ~(ATLAUTS[11]='1') !AIZLIEGTS APSKATÎT D P/Z UN JEBKURU PIEEJU IEP CENÂM
       IF REASUMMA AND PICSUMMA AND INSTRING(PAV:D_K,'KP')
          UPTEXT='Uzc.= '&CLIP(ROUND((REASUMMA/PICSUMMA-1)*100,.1))&'% NP= '&val_uzsk&' '&REASUMMA-PICSUMMA
       ELSE
          UPTEXT=''
       .
    .
  SETCURSOR()
  DO BRW2::Reset
  PREVIOUS(BRW2::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW2::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'NOLIK')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW2::SortOrder
  OF 1
    BRW2::Sort1:HighValue = NOL:NOMENKLAT
  END
  DO BRW2::Reset
  NEXT(BRW2::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW2::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'NOLIK')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW2::SortOrder
  OF 1
    BRW2::Sort1:LowValue = NOL:NOMENKLAT
    SetupStringStops(BRW2::Sort1:LowValue,BRW2::Sort1:HighValue,SIZE(BRW2::Sort1:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW2::ScrollRecordCount = 1 TO 100
      BRW2::Sort1:KeyDistribution[BRW2::ScrollRecordCount] = NextStringStop()
    END
  END
  IF SEND(NOLIK,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW2::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  NOL:NOMENKLAT = BRW2::NOL:NOMENKLAT
  NOM_NOSAUKUMS = BRW2::NOM_NOSAUKUMS
  NOL:DAUDZUMS = BRW2::NOL:DAUDZUMS
  NOL:SUMMAV = BRW2::NOL:SUMMAV
  NOL_ARBYTE = BRW2::NOL_ARBYTE
  NOL:PVN_PROC = BRW2::NOL:PVN_PROC
  NOL:ATLAIDE_PR = BRW2::NOL:ATLAIDE_PR
  akmuci = BRW2::akmuci
  SummaArPVN = BRW2::SummaArPVN
  NOL:PAR_NR = BRW2::NOL:PAR_NR
  NOL:OBJ_NR = BRW2::NOL:OBJ_NR
  NOL:D_K = BRW2::NOL:D_K
  NOL:BAITS = BRW2::NOL:BAITS
  NOL:U_NR = BRW2::NOL:U_NR
!----------------------------------------------------------------------
BRW2::FillQueue ROUTINE
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
   IF CL_NR=1407 !SALIMPEX RÎGA
      nom_nosaukums=getnom_k(nol:nomenklat,0,2) !PILNAIS NOSAUKUMS
   ELSE
      nom_nosaukums=getnom_k(nol:nomenklat,0,3)
   .
   SummaArPVN=calcsum(4,2)
   IF NOL:ARBYTE
      NOL_ARBYTE='a'
   ELSE
      NOL_ARBYTE=''
   .
  akmuci = NOL:MUITA + NOL:AKCIZE + NOL:CITAS
  BRW2::NOL:NOMENKLAT = NOL:NOMENKLAT
  BRW2::NOM_NOSAUKUMS = NOM_NOSAUKUMS
  BRW2::NOL:DAUDZUMS = NOL:DAUDZUMS
  BRW2::NOL:SUMMAV = NOL:SUMMAV
  BRW2::NOL_ARBYTE = NOL_ARBYTE
  BRW2::NOL:PVN_PROC = NOL:PVN_PROC
  BRW2::NOL:ATLAIDE_PR = NOL:ATLAIDE_PR
  BRW2::akmuci = akmuci
  BRW2::SummaArPVN = SummaArPVN
  BRW2::NOL:PAR_NR = NOL:PAR_NR
  BRW2::NOL:OBJ_NR = NOL:OBJ_NR
  BRW2::NOL:D_K = NOL:D_K
  BRW2::NOL:BAITS = NOL:BAITS
  BRW2::NOL:U_NR = NOL:U_NR
  BRW2::Position = POSITION(BRW2::View:Browse)
!----------------------------------------------------------------------
BRW2::PostNewSelection ROUTINE
!|
!| This routine is used to post the NewSelection EVENT to the window. Because we only want this
!| EVENT processed once, and becuase there are several routines that need to initiate a NewSelection
!| EVENT, we keep a flag that tells us if the EVENT is already waiting to be processed. The EVENT is
!| only POSTed if this flag is false.
!|
  IF NOT BRW2::NewSelectPosted
    BRW2::NewSelectPosted = True
    POST(Event:NewSelection,?Browse:2)
  END
!----------------------------------------------------------------------
BRW2::NewSelection ROUTINE
!|
!| This routine performs any window bookkeeping necessary when a new record is selected in the
!| BrowseBox.
!| 1. If the new selection is made with the right mouse button, the popup menu (if applicable) is
!|    processed.
!| 2. The current record is retrieved into the buffer using the BRW2::FillBuffer ROUTINE.
!|    After this, the current vertical scrollbar position is computed, and the scrollbar positioned.
!|
  BRW2::NewSelectPosted = False
  IF KEYCODE() = MouseRight
    BRW2::PopupText = ''
    IF BRW2::RecordCount
      IF BRW2::PopupText
        BRW2::PopupText = '&Ievadît|&Mainît|&Dzçst|-|' & BRW2::PopupText
      ELSE
        BRW2::PopupText = '&Ievadît|&Mainît|&Dzçst'
      END
    ELSE
      IF BRW2::PopupText
        BRW2::PopupText = '&Ievadît|~&Mainît|~&Dzçst|-|' & BRW2::PopupText
      ELSE
        BRW2::PopupText = '&Ievadît|~&Mainît|~&Dzçst'
      END
    END
    EXECUTE(POPUP(BRW2::PopupText))
      POST(Event:Accepted,?Insert:3)
      POST(Event:Accepted,?Change:3)
      POST(Event:Accepted,?Delete:3)
    END
  ELSIF BRW2::RecordCount
    BRW2::CurrentChoice = CHOICE(?Browse:2)
    GET(Queue:Browse:2,BRW2::CurrentChoice)
    DO BRW2::FillBuffer
    IF BRW2::RecordCount = ?Browse:2{Prop:Items}
      IF ?Browse:2{Prop:VScroll} = False
        ?Browse:2{Prop:VScroll} = True
      END
      CASE BRW2::SortOrder
      OF 1
        LOOP BRW2::CurrentScroll = 1 TO 100
          IF BRW2::Sort1:KeyDistribution[BRW2::CurrentScroll] => UPPER(NOL:NOMENKLAT)
            IF BRW2::CurrentScroll <= 1
              BRW2::CurrentScroll = 0
            ELSIF BRW2::CurrentScroll = 100
              BRW2::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      END
    ELSE
      IF ?Browse:2{Prop:VScroll} = True
        ?Browse:2{Prop:VScroll} = False
      END
    END
    DO RefreshWindow
  END
!---------------------------------------------------------------------
BRW2::ProcessScroll ROUTINE
!|
!| This routine processes any of the six scrolling EVENTs handled by the BrowseBox.
!| If one record is to be scrolled, the ROUTINE BRW2::ScrollOne is called.
!| If a page of records is to be scrolled, the ROUTINE BRW2::ScrollPage is called.
!| If the first or last page is to be displayed, the ROUTINE BRW2::ScrollEnd is called.
!|
!| If an incremental locator is in use, the value of that locator is cleared.
!| Finally, if a Fixed Thumb vertical scroll bar is used, the thumb is positioned.
!|
  IF BRW2::RecordCount
    BRW2::CurrentEvent = EVENT()
    CASE BRW2::CurrentEvent
    OF Event:ScrollUp OROF Event:ScrollDown
      DO BRW2::ScrollOne
    OF Event:PageUp OROF Event:PageDown
      DO BRW2::ScrollPage
    OF Event:ScrollTop OROF Event:ScrollBottom
      DO BRW2::ScrollEnd
    END
    ?Browse:2{Prop:SelStart} = BRW2::CurrentChoice
    DO BRW2::PostNewSelection
  END
!----------------------------------------------------------------------
BRW2::ScrollOne ROUTINE
!|
!| This routine is used to scroll a single record on the BrowseBox. Since the BrowseBox is an IMM
!| listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Sees if scrolling in the intended direction will cause the listbox display to shift. If not,
!|    the routine moves the list box cursor and exits.
!| 2. Calls BRW2::FillRecord to retrieve one record in the direction required.
!|
  IF BRW2::CurrentEvent = Event:ScrollUp AND BRW2::CurrentChoice > 1
    BRW2::CurrentChoice -= 1
    EXIT
  ELSIF BRW2::CurrentEvent = Event:ScrollDown AND BRW2::CurrentChoice < BRW2::RecordCount
    BRW2::CurrentChoice += 1
    EXIT
  END
  BRW2::ItemsToFill = 1
  BRW2::FillDirection = BRW2::CurrentEvent - 2
  DO BRW2::FillRecord
!----------------------------------------------------------------------
BRW2::ScrollPage ROUTINE
!|
!| This routine is used to scroll a single page of records on the BrowseBox. Since the BrowseBox is
!| an IMM listbox, all scrolling must be handled in code. When called, this routine...
!|
!| 1. Calls BRW2::FillRecord to retrieve one page of records in the direction required.
!| 2. If BRW2::FillRecord doesn't fill a page (BRW2::ItemsToFill > 0), then
!|    the list-box cursor ia shifted.
!|
  BRW2::ItemsToFill = ?Browse:2{Prop:Items}
  BRW2::FillDirection = BRW2::CurrentEvent - 4
  DO BRW2::FillRecord                           ! Fill with next read(s)
  IF BRW2::ItemsToFill
    IF BRW2::CurrentEvent = Event:PageUp
      BRW2::CurrentChoice -= BRW2::ItemsToFill
      IF BRW2::CurrentChoice < 1
        BRW2::CurrentChoice = 1
      END
    ELSE
      BRW2::CurrentChoice += BRW2::ItemsToFill
      IF BRW2::CurrentChoice > BRW2::RecordCount
        BRW2::CurrentChoice = BRW2::RecordCount
      END
    END
  END
!----------------------------------------------------------------------
BRW2::ScrollEnd ROUTINE
!|
!| This routine is used to load the first or last page of the displayable set of records.
!| Since the BrowseBox is an IMM listbox, all scrolling must be handled in code. When called,
!| this routine...
!|
!| 1. Resets the BrowseBox VIEW to insure that it reads from the end of the current sort order.
!| 2. Calls BRW2::FillRecord to retrieve one page of records.
!| 3. Selects the record that represents the end of the view. That is, if the first page was loaded,
!|    the first record is highlighted. If the last was loaded, the last record is highlighted.
!|
  FREE(Queue:Browse:2)
  BRW2::RecordCount = 0
  DO BRW2::Reset
  BRW2::ItemsToFill = ?Browse:2{Prop:Items}
  IF BRW2::CurrentEvent = Event:ScrollTop
    BRW2::FillDirection = FillForward
  ELSE
    BRW2::FillDirection = FillBackward
  END
  DO BRW2::FillRecord                           ! Fill with next read(s)
  IF BRW2::CurrentEvent = Event:ScrollTop
    BRW2::CurrentChoice = 1
  ELSE
    BRW2::CurrentChoice = BRW2::RecordCount
  END
!----------------------------------------------------------------------
BRW2::AlertKey ROUTINE
!|
!| This routine processes any KEYCODEs experienced by the BrowseBox.
!| NOTE: The cursor movement keys are not processed as KEYCODEs. They are processed as the
!|       appropriate BrowseBox scrolling and selection EVENTs.
!| This routine includes handling for double-click. Actually, this handling is in the form of
!| EMBEDs, which are filled by child-control templates.
!| This routine also includes the BrowseBox's locator handling.
!| After a value is entered for locating, this routine sets BRW2::LocateMode to a value
!| of 2 -- EQUATEd to LocateOnValue -- and calls the routine BRW2::LocateRecord.
!|
  IF BRW2::RecordCount
    CASE KEYCODE()                                ! What keycode was hit
    OF MouseLeft2
      POST(Event:Accepted,?Change:3)
      DO BRW2::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
    OF DeleteKey
      POST(Event:Accepted,?Delete:3)
    OF CtrlEnter
      POST(Event:Accepted,?Change:3)
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
    END
  END
  DO BRW2::PostNewSelection
!----------------------------------------------------------------------
BRW2::ScrollDrag ROUTINE
!|
!| This routine processes the Vertical Scroll Bar arrays to find the free key field value
!| that corresponds to the current scroll bar position.
!|
!| After the scroll position is computed, and the scroll value found, this routine sets
!| BRW2::LocateMode to that scroll value of 2 -- EQUATEd to LocateOnValue --
!| and calls the routine BRW2::LocateRecord.
!|
  IF ?Browse:2{Prop:VScrollPos} <= 1
    POST(Event:ScrollTop,?Browse:2)
  ELSIF ?Browse:2{Prop:VScrollPos} = 100
    POST(Event:ScrollBottom,?Browse:2)
  ELSE
    CASE BRW2::SortOrder
    OF 1
      NOL:NOMENKLAT = BRW2::Sort1:KeyDistribution[?Browse:2{Prop:VScrollPos}]
      BRW2::LocateMode = LocateOnValue
      DO BRW2::LocateRecord
    END
  END
!----------------------------------------------------------------------
BRW2::FillRecord ROUTINE
!|
!| This routine is used to retrieve a number of records from the VIEW. The number of records
!| retrieved is held in the variable BRW2::ItemsToFill. If more than one record is
!| to be retrieved, QuickScan is used to minimize reads from the disk.
!|
!| If records exist in the queue (in other words, if the browse has been used before), the record
!| at the appropriate end of the list box is retrieved, and the VIEW is reset to read starting
!| at that record.
!|
!| Next, the VIEW is accessed to retrieve BRW2::ItemsToFill records. Normally, this will
!| result in BRW2::ItemsToFill records being read from the VIEW, but if custom filtering
!| or range limiting is used (via the BRW2::ValidateRecord routine) then any number of records
!| might be read.
!|
!| For each good record, if BRW2::AddQueue is true, the queue is filled using the BRW2::FillQueue
!| routine. The record is then added to the queue. If adding this record causes the BrowseBox queue
!| to contain more records than can be displayed, the record at the opposite end of the queue is
!| deleted.
!|
!| The only time BRW2::AddQueue is false is when the BRW2::LocateRecord routine needs to
!| get the closest record to its record to be located. At this time, the record doesn't need to be
!| added to the queue, so it isn't.
!|
  IF BRW2::ItemsToFill > 1
    IF SEND(NOLIK,'QUICKSCAN=on').
    BRW2::QuickScan = True
  END
  IF BRW2::RecordCount
    IF BRW2::FillDirection = FillForward
      GET(Queue:Browse:2,BRW2::RecordCount)       ! Get the first queue item
    ELSE
      GET(Queue:Browse:2,1)                       ! Get the first queue item
    END
    RESET(BRW2::View:Browse,BRW2::Position)       ! Reset for sequential processing
    BRW2::SkipFirst = TRUE
  ELSE
    BRW2::SkipFirst = FALSE
  END
  LOOP WHILE BRW2::ItemsToFill
    IF BRW2::FillDirection = FillForward
      NEXT(BRW2::View:Browse)
    ELSE
      PREVIOUS(BRW2::View:Browse)
    END
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW2::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'NOLIK')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    IF BRW2::SkipFirst
       BRW2::SkipFirst = FALSE
       IF POSITION(BRW2::View:Browse)=BRW2::Position
          CYCLE
       END
    END
    IF BRW2::AddQueue
      IF BRW2::RecordCount = ?Browse:2{Prop:Items}
        IF BRW2::FillDirection = FillForward
          GET(Queue:Browse:2,1)                   ! Get the first queue item
        ELSE
          GET(Queue:Browse:2,BRW2::RecordCount)   ! Get the first queue item
        END
        DELETE(Queue:Browse:2)
        BRW2::RecordCount -= 1
      END
      DO BRW2::FillQueue
      IF BRW2::FillDirection = FillForward
        ADD(Queue:Browse:2)
      ELSE
        ADD(Queue:Browse:2,1)
      END
      BRW2::RecordCount += 1
    END
    BRW2::ItemsToFill -= 1
  END
  IF BRW2::QuickScan
    IF SEND(NOLIK,'QUICKSCAN=off').
    BRW2::QuickScan = False
  END
  BRW2::AddQueue = True
  EXIT
!----------------------------------------------------------------------
BRW2::LocateRecord ROUTINE
!|
!| This routine is used to find a record in the VIEW, and to display that record
!| in the BrowseBox.
!|
!| This routine has three different modes of operation, which are invoked based on
!| the setting of BRW2::LocateMode. These modes are...
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
!| If an appropriate record has been located, the BRW2::RefreshPage routine is
!| called to load the page containing the located record.
!|
!| If an appropriate record is not locate, the last page of the BrowseBox is loaded.
!|
  IF BRW2::LocateMode = LocateOnPosition
    BRW2::LocateMode = LocateOnEdit
  END
  CLOSE(BRW2::View:Browse)
  CASE BRW2::SortOrder
  OF 1
    IF BRW2::LocateMode = LocateOnEdit
      BRW2::HighlightedPosition = POSITION(NOL:NR_KEY)
      RESET(NOL:NR_KEY,BRW2::HighlightedPosition)
    ELSE
      NOL:U_NR = PAV:U_NR
      SET(NOL:NR_KEY,NOL:NR_KEY)
    END
    BRW2::View:Browse{Prop:Filter} = |
    'NOL:U_NR = BRW2::Sort1:Reset:PAV:U_NR'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW2::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  FREE(Queue:Browse:2)
  BRW2::RecordCount = 0
  BRW2::ItemsToFill = 1
  BRW2::FillDirection = FillForward               ! Fill with next read(s)
  BRW2::AddQueue = False
  DO BRW2::FillRecord                             ! Fill with next read(s)
  BRW2::AddQueue = True
  IF BRW2::ItemsToFill
    BRW2::RefreshMode = RefreshOnBottom
    DO BRW2::RefreshPage
  ELSE
    BRW2::RefreshMode = RefreshOnPosition
    DO BRW2::RefreshPage
  END
  DO BRW2::PostNewSelection
  BRW2::LocateMode = 0
  EXIT
!----------------------------------------------------------------------
BRW2::RefreshPage ROUTINE
!|
!| This routine is used to load a single page of the BrowseBox.
!|
!| If this routine is called with a BRW2::RefreshMode of RefreshOnPosition,
!| the active VIEW record is loaded at the top of the page. Otherwise, if there are
!| records in the browse queue (Queue:Browse:2), then the current page is reloaded, and the
!| currently selected item remains selected.
!|
  SETCURSOR(Cursor:Wait)
  IF BRW2::RefreshMode = RefreshOnPosition
    BRW2::HighlightedPosition = POSITION(BRW2::View:Browse)
    RESET(BRW2::View:Browse,BRW2::HighlightedPosition)
    BRW2::RefreshMode = RefreshOnTop
  ELSIF RECORDS(Queue:Browse:2)
    GET(Queue:Browse:2,BRW2::CurrentChoice)
    IF ERRORCODE()
      GET(Queue:Browse:2,RECORDS(Queue:Browse:2))
    END
    BRW2::HighlightedPosition = BRW2::Position
    GET(Queue:Browse:2,1)
    RESET(BRW2::View:Browse,BRW2::Position)
    BRW2::RefreshMode = RefreshOnCurrent
  ELSE
    BRW2::HighlightedPosition = ''
    DO BRW2::Reset
  END
  FREE(Queue:Browse:2)
  BRW2::RecordCount = 0
  BRW2::ItemsToFill = ?Browse:2{Prop:Items}
  IF BRW2::RefreshMode = RefreshOnBottom
    BRW2::FillDirection = FillBackward
  ELSE
    BRW2::FillDirection = FillForward
  END
  DO BRW2::FillRecord                             ! Fill with next read(s)
  IF BRW2::HighlightedPosition
    IF BRW2::ItemsToFill
      IF NOT BRW2::RecordCount
        DO BRW2::Reset
      END
      IF BRW2::RefreshMode = RefreshOnBottom
        BRW2::FillDirection = FillForward
      ELSE
        BRW2::FillDirection = FillBackward
      END
      DO BRW2::FillRecord
    END
  END
  IF BRW2::RecordCount
    IF BRW2::HighlightedPosition
      LOOP BRW2::CurrentChoice = 1 TO BRW2::RecordCount
        GET(Queue:Browse:2,BRW2::CurrentChoice)
        IF BRW2::Position = BRW2::HighlightedPosition THEN BREAK.
      END
      IF BRW2::CurrentChoice > BRW2::RecordCount
        BRW2::CurrentChoice = BRW2::RecordCount
      END
    ELSE
      IF BRW2::RefreshMode = RefreshOnBottom
        BRW2::CurrentChoice = RECORDS(Queue:Browse:2)
      ELSE
        BRW2::CurrentChoice = 1
      END
    END
    ?Browse:2{Prop:Selected} = BRW2::CurrentChoice
    DO BRW2::FillBuffer
    ?Change:3{Prop:Disable} = 0
    ?Delete:3{Prop:Disable} = 0
  ELSE
    CLEAR(NOL:Record)
    BRW2::CurrentChoice = 0
    ?Change:3{Prop:Disable} = 1
    ?Delete:3{Prop:Disable} = 1
  END
  SETCURSOR()
  BRW2::RefreshMode = 0
  EXIT
BRW2::Reset ROUTINE
!|
!| This routine is used to reset the VIEW used by the BrowseBox.
!|
  CLOSE(BRW2::View:Browse)
  CASE BRW2::SortOrder
  OF 1
    NOL:U_NR = PAV:U_NR
    SET(NOL:NR_KEY)
    BRW2::View:Browse{Prop:Filter} = |
    'NOL:U_NR = BRW2::Sort1:Reset:PAV:U_NR'
  END
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(BRW2::View:Browse)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
!----------------------------------------------------------------------
!----------------------------------------------------------------------
BRW2::GetRecord ROUTINE
!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
  IF BRW2::RecordCount
    BRW2::CurrentChoice = CHOICE(?Browse:2)
    GET(Queue:Browse:2,BRW2::CurrentChoice)
    WATCH(BRW2::View:Browse)
    REGET(BRW2::View:Browse,BRW2::Position)
  END
!----------------------------------------------------------------------
BRW2::RestoreResetValues ROUTINE
!|
!| This routine is used to restore reset values to their saved value
!| after a bad record access from the VIEW.
!|
  CASE BRW2::SortOrder
  OF 1
    PAV:U_NR = BRW2::Sort1:Reset:PAV:U_NR
  END
BRW2::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:2
  BrowseButtons.InsertButton=?Insert:3
  BrowseButtons.ChangeButton=?Change:3
  BrowseButtons.DeleteButton=?Delete:3
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
  IF BrowseButtons.InsertButton THEN
    TBarBrwInsert{PROP:DISABLE}=BrowseButtons.InsertButton{PROP:DISABLE}
  END
  IF BrowseButtons.ChangeButton THEN
    TBarBrwChange{PROP:DISABLE}=BrowseButtons.ChangeButton{PROP:DISABLE}
  END
  IF BrowseButtons.DeleteButton THEN
    TBarBrwDelete{PROP:DISABLE}=BrowseButtons.DeleteButton{PROP:DISABLE}
  END
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
  IF FOCUS() <> BrowseButtons.ListBox THEN  ! List box must have focus when on update form
    EXIT
  END
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

UpdateDispatch ROUTINE
  DISABLE(TBarBrwDelete)
  DISABLE(TBarBrwChange)
  IF BrowseButtons.DeleteButton AND BrowseButtons.DeleteButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwDelete)
  END
  IF BrowseButtons.ChangeButton AND BrowseButtons.ChangeButton{PROP:DISABLE} = 0 THEN
    ENABLE(TBarBrwChange)
  END
  IF FOCUS() <> BrowseButtons.ListBox THEN  ! List box must have focus when on update form
    EXIT
  END
  IF INRANGE(ACCEPTED(),TBarBrwInsert,TBarBrwDelete) THEN         !trap remote browse update control calls
    EXECUTE(ACCEPTED()-TBarBrwInsert+1)
      POST(EVENT:ACCEPTED,BrowseButtons.InsertButton)
      POST(EVENT:ACCEPTED,BrowseButtons.ChangeButton)
      POST(EVENT:ACCEPTED,BrowseButtons.DeleteButton)
    END
  END
!----------------------------------------------------------------
BRW2::ButtonInsert ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to insert a new record.
!|
!| First, the primary file's record  buffer is cleared, as well as any memos
!| or BLOBs. Next, any range-limit values are restored so that the inserted
!| record defaults to being added to the current display set.
!|
!| Next, LocalRequest is set to InsertRecord, and the BRW2::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the insert is successful (GlobalRequest = RequestCompleted) then the newly added
!| record is displayed in the BrowseBox, at the top of the listbox.
!|
!| If the insert is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  GET(NOLIK,0)
  CLEAR(NOL:Record,0)
  CASE BRW2::SortOrder
  OF 1
    NOL:U_NR = BRW2::Sort1:Reset:PAV:U_NR
  END
  LocalRequest = InsertRecord
  DO BRW2::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW2::LocateMode = LocateOnEdit
    DO BRW2::LocateRecord
  ELSE
    BRW2::RefreshMode = RefreshOnQueue
    DO BRW2::RefreshPage
  END
  DO BRW2::InitializeBrowse
  DO BRW2::PostNewSelection
  SELECT(?Browse:2)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW2::ButtonChange ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to change a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW2::GetRecord routine.
!|
!| First, LocalRequest is set to ChangeRecord, and the BRW2::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the change is successful (GlobalRequest = RequestCompleted) then the newly changed
!| record is displayed in the BrowseBox.
!|
!| If the change is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = ChangeRecord
  DO BRW2::CallUpdate
  IF GlobalResponse = RequestCompleted
    BRW2::LocateMode = LocateOnEdit
    DO BRW2::LocateRecord
  ELSE
    BRW2::RefreshMode = RefreshOnQueue
    DO BRW2::RefreshPage
  END
  DO BRW2::InitializeBrowse
  DO BRW2::PostNewSelection
  SELECT(?Browse:2)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW2::ButtonDelete ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to delete a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW2::GetRecord routine.
!|
!| First, LocalRequest is set to DeleteRecord, and the BRW2::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the delete is successful (GlobalRequest = RequestCompleted) then the deleted record is
!| removed from the queue.
!|
!| Next, the BrowseBox is refreshed, redisplaying the current page.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  LocalRequest = DeleteRecord
  DO BRW2::CallUpdate
  IF GlobalResponse = RequestCompleted
    DELETE(Queue:Browse:2)
    BRW2::RecordCount -= 1
  END
  BRW2::RefreshMode = RefreshOnQueue
  DO BRW2::RefreshPage
  DO BRW2::InitializeBrowse
  DO BRW2::PostNewSelection
  SELECT(?Browse:2)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW2::CallUpdate ROUTINE
!|
!| This routine performs the actual call to the update procedure.
!|
!| The first thing that happens is that the VIEW is closed. This is performed just in case
!| the VIEW is still open.
!|
!| Next, GlobalRequest is set the the value of LocalRequest, and the update procedure
!| (UpdateNOLIK) is called.
!|
!| Upon return from the update, the routine BRW2::Reset is called to reset the VIEW
!| and reopen it.
!|
  CLOSE(BRW2::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateNOLIK
    LocalResponse = GlobalResponse
    CASE VCRRequest
    OF VCRNone
      BREAK
    OF VCRInsert
      IF LocalRequest=ChangeRecord THEN
        LocalRequest=InsertRecord
      END
    OROF VCRForward
      IF LocalRequest=InsertRecord THEN
        GET(NOLIK,0)
        CLEAR(NOL:Record,0)
      ELSE
        DO BRW2::PostVCREdit1
        BRW2::CurrentEvent=Event:ScrollDown
        DO BRW2::ScrollOne
        DO BRW2::PostVCREdit2
      END
    OF VCRBackward
      DO BRW2::PostVCREdit1
      BRW2::CurrentEvent=Event:ScrollUp
      DO BRW2::ScrollOne
      DO BRW2::PostVCREdit2
    OF VCRPageForward
      DO BRW2::PostVCREdit1
      BRW2::CurrentEvent=Event:PageDown
      DO BRW2::ScrollPage
      DO BRW2::PostVCREdit2
    OF VCRPageBackward
      DO BRW2::PostVCREdit1
      BRW2::CurrentEvent=Event:PageUp
      DO BRW2::ScrollPage
      DO BRW2::PostVCREdit2
    OF VCRFirst
      DO BRW2::PostVCREdit1
      BRW2::CurrentEvent=Event:ScrollTop
      DO BRW2::ScrollEnd
      DO BRW2::PostVCREdit2
    OF VCRLast
      DO BRW2::PostVCREdit1
      BRW2::CurrentEvent=Event:ScrollBottom
      DO BRW2::ScrollEND
      DO BRW2::PostVCREdit2
    END
  END
  DO BRW2::Reset

BRW2::PostVCREdit1 ROUTINE
  DO BRW2::Reset
  BRW2::LocateMode=LocateOnEdit
  DO BRW2::LocateRecord
  DO RefreshWindow

BRW2::PostVCREdit2 ROUTINE
  ?Browse:2{PROP:SelStart}=BRW2::CurrentChoice
  DO BRW2::NewSelection
  REGET(BRW2::View:Browse,BRW2::Position)
  CLOSE(BRW2::View:Browse)

!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?PAV:U_NR
      PAV:U_NR = History::PAV:Record.U_NR
    OF ?PAV:NODALA
      PAV:NODALA = History::PAV:Record.NODALA
    OF ?PAV:OBJ_NR
      PAV:OBJ_NR = History::PAV:Record.OBJ_NR
    OF ?PAV:DOK_SENR
      PAV:DOK_SENR = History::PAV:Record.DOK_SENR
    OF ?PAV:DOKDAT
      PAV:DOKDAT = History::PAV:Record.DOKDAT
    OF ?PAV:DATUMS
      PAV:DATUMS = History::PAV:Record.DATUMS
    OF ?PAV:NOKA
      PAV:NOKA = History::PAV:Record.NOKA
    OF ?PAV:PAR_NR
      PAV:PAR_NR = History::PAV:Record.PAR_NR
    OF ?PAV:val
      PAV:val = History::PAV:Record.val
    OF ?PAV:apm_v
      PAV:apm_v = History::PAV:Record.apm_v
    OF ?PAV:apm_k
      PAV:apm_k = History::PAV:Record.apm_k
    OF ?PAV:PAMAT
      PAV:PAMAT = History::PAV:Record.PAMAT
    OF ?PAV:PIELIK
      PAV:PIELIK = History::PAV:Record.PIELIK
    OF ?PAV:T_SUMMA
      PAV:T_SUMMA = History::PAV:Record.T_SUMMA
    OF ?PAV:T_PVN
      PAV:T_PVN = History::PAV:Record.T_PVN
    OF ?PAV:C_DATUMS
      PAV:C_DATUMS = History::PAV:Record.C_DATUMS
    OF ?PAV:C_SUMMA
      PAV:C_SUMMA = History::PAV:Record.C_SUMMA
    OF ?PAV:MAK_NR
      PAV:MAK_NR = History::PAV:Record.MAK_NR
    OF ?PAV:SUMMA
      PAV:SUMMA = History::PAV:Record.SUMMA
    OF ?PAV:SUMMA_A
      PAV:SUMMA_A = History::PAV:Record.SUMMA_A
    OF ?PAV:SUMMA_B
      PAV:SUMMA_B = History::PAV:Record.SUMMA_B
    OF ?PAV:DEK_NR
      PAV:DEK_NR = History::PAV:Record.DEK_NR
    OF ?PAV:KIE_NR:2
      PAV:KIE_NR = History::PAV:Record.KIE_NR
    OF ?PAV:DAR_V_KODS
      PAV:DAR_V_KODS = History::PAV:Record.DAR_V_KODS
    OF ?PAV:MUITA
      PAV:MUITA = History::PAV:Record.MUITA
    OF ?PAV:AKCIZE
      PAV:AKCIZE = History::PAV:Record.AKCIZE
    OF ?PAV:CITAS
      PAV:CITAS = History::PAV:Record.CITAS
    OF ?PAV:KIE_NR
      PAV:KIE_NR = History::PAV:Record.KIE_NR
    OF ?PAV:REK_NR
      PAV:REK_NR = History::PAV:Record.REK_NR
    OF ?PAV:DAR_V_KODS:2
      PAV:DAR_V_KODS = History::PAV:Record.DAR_V_KODS
    OF ?PAV:TEKSTS_NR
      PAV:TEKSTS_NR = History::PAV:Record.TEKSTS_NR
    OF ?PAV:ACC_KODS
      PAV:ACC_KODS = History::PAV:Record.ACC_KODS
    OF ?PAV:ACC_DATUMS
      PAV:ACC_DATUMS = History::PAV:Record.ACC_DATUMS
  END
  DISPLAY()
!---------------------------------------------------------------
PrimeFields ROUTINE
!|
!| This routine is called whenever the procedure is called to insert a record.
!|
!| This procedure performs three functions. These functions are..
!|
!|   1. Prime the new record with initial values specified in the dictionary
!|      and under the Field priming on Insert button.
!|   2. Generates any Auto-Increment values needed.
!|   3. Saves a copy of the new record, as primed, for use in batch-adds.
!|
!| If an auto-increment value is generated, this routine will add the new record
!| at this point, keeping its place in the file.
!|
  PAV:Record = SAV::PAV:Record
  PAV:DATUMS = SAV_DATUMS
  !ÐITAIS IR TAS PATS, KAS PRIME RECORD FIELDS ON INSERT....
  IF ~PAV:D_K THEN PAV:D_K='K'.
!  IF ~SUP_A4_NR THEN SUP_A4_NR=1. !NUMURÇT ..ðitais tiek pieðíirts no SYS...
  IF PAV:D_K='P' THEN SUP_A4_NR=0. !NENUMURÇT
  OPEN(D_KSCREEN)
  IF COPYREQUEST
     UNHIDE(?NOKL_CENA)
     UNHIDE(?nokl_cena:text)
     UNHIDE(?ZIME)
     ZIME=1
  .
  DISPLAY
  accept
     case field()
     of ?PAV:D_K
        if event()=EVENT:Accepted
           IF PAV:D_K='K'
              ENABLE(?SUP_A4_NR)
              ENABLE(?SUP_A4_NR:Radio1)
           ELSIF PAV:D_K='P'
              IF SUP_A4_NR=1 THEN SUP_A4_NR=0.
              ENABLE(?SUP_A4_NR)
              DISABLE(?SUP_A4_NR:Radio1) !NOÒEMAM JÂ
           ELSE
              DISABLE(?SUP_A4_NR)
           .
           DISPLAY
        .
     of (?OK1)
        if event()=EVENT:Accepted
           IF ~INSTRING(PAV:D_K,'KP') THEN SUP_A4_NR=0.
           BREAK
        .
     .
  .
  close(D_KSCREEN)
  SAV::PAV:Record = PAV:Record
  IF COPYREQUEST AND ZIME<0   !ATGRIEZTA
     PAV_DOK_SENR=CLIP(PAV:DOK_SENR)&'-AT'
     PAV_PIELIK=PAV:DOK_SENR
  .
  Auto::Attempts = 0
  LOOP
     DO ASSIGN_U_NR
     IF ~PAV_DOK_SENR
        IF PAV:D_K='K'
           IF SUP_A4_NR=1
              PAV_DOK_SE=SYS:PZ_SERIJA
           ELSIF SUP_A4_NR=2 !AUTO GARANTIJA
              PAV_DOK_SE='G'
           ELSE
              PAV_DOK_SE='K'
           .
           SAV::PAV:Record = PAV:Record
           DO ASSIGN_DOK_NR
           IF PAV_DOK_SE=SYS:PZ_SERIJA AND GETDOK_SENR(2,PAV:DOK_SENR,,'2')>SYS:PZ_NR_END
              KLUDA(0,'beidzies PPR numerâcijas apgabals Lokâlajos datos...')
              PAV:DOK_SENR=''
           .
        ELSIF PAV:D_K='P'
           IF SUP_A4_NR=2 !AUTO GARANTIJA
              PAV_DOK_SE='G'
           ELSE
              PAV_DOK_SE='P'
           .
           SAV::PAV:Record = PAV:Record
           DO ASSIGN_DOK_NR
        ELSIF PAV:D_K='R'
           PAV_DOK_SE='R'
           SAV::PAV:Record = PAV:Record
           DO ASSIGN_DOK_NR
        ELSE
           PAV:DOK_SENR=''
        .
     ELSE
        PAV:DOK_SENR=PAV_DOK_SENR
        PAV:PAMAT='Atgriezta prece'
        PAV:PIELIK=PAV_PIELIK
        PAV:C_DATUMS=0
        PAV:C_SUMMA=0
     .
     IF DUPLICATE(PAV:SENR_KEY)
        KLUDA(0,'Atkârtojas dokumenta SE-Nr : '&CLIP(PAV:DOK_SENR)&' ,atceïam autonumerâciju....')
        PAV:DOK_SENR=''
     .
!     .
!PAV:Record = SAV::PAV:Record un ADD TIKS DOTS VÇLÂK
!   STOP(PAV:DOK_SENR&'SUA4:'&SUP_A4_NR)
  OMIT('AUTONUMBER')  !ES PATS VAIRS NESAPROTU, KÂ TAS BIJA DOMÂTS, IZSKATÂS, KA ES IZLAÎÞU LÎDZ NÂKOÐAJAM OMITAM
  SAV::PAV:Record = PAV:Record
  Auto::Attempts = 0
  LOOP
    SET(PAV:NR_KEY)
    PREVIOUS(PAVAD)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAV:U_NR = 1
    ELSE
      Auto::Save:PAV:U_NR = PAV:U_NR + 1
    END
    PAV:Record = SAV::PAV:Record
    PAV:U_NR = Auto::Save:PAV:U_NR
    SAV::PAV:Record = PAV:Record
    SET(PAV:SENR_KEY)
    PREVIOUS(PAVAD)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAVAD')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:PAV:DOK_SENR = 1
    ELSE
      Auto::Save:PAV:DOK_SENR = PAV:DOK_SENR + 1
    END
    PAV:Record = SAV::PAV:Record
    PAV:DOK_SENR = Auto::Save:PAV:DOK_SENR
    SAV::PAV:Record = PAV:Record
  !ÐITAIS IR TAS PATS, KAS PRIME RECORD FIELDS ON INSERT....
  IF ~PAV:D_K THEN PAV:D_K='K'.
!  IF ~SUP_A4_NR THEN SUP_A4_NR=1. !NUMURÇT ..ðitais tiek pieðíirts no SYS...
  IF PAV:D_K='P' THEN SUP_A4_NR=0. !NENUMURÇT
  OPEN(D_KSCREEN)
  IF COPYREQUEST
     UNHIDE(?NOKL_CENA)
     UNHIDE(?nokl_cena:text)
     UNHIDE(?ZIME)
     ZIME=1
  .
  DISPLAY
  accept
     case field()
     of ?PAV:D_K
        if event()=EVENT:Accepted
           IF PAV:D_K='K'
              ENABLE(?SUP_A4_NR)
              ENABLE(?SUP_A4_NR:Radio1)
           ELSIF PAV:D_K='P'
              IF SUP_A4_NR=1 THEN SUP_A4_NR=0.
              ENABLE(?SUP_A4_NR)
              DISABLE(?SUP_A4_NR:Radio1) !NOÒEMAM JÂ
           ELSE
              DISABLE(?SUP_A4_NR)
           .
           DISPLAY
        .
     of (?OK1)
        if event()=EVENT:Accepted
           IF ~INSTRING(PAV:D_K,'KP') THEN SUP_A4_NR=0.
           BREAK
        .
     .
  .
  close(D_KSCREEN)
  SAV::PAV:Record = PAV:Record
  IF COPYREQUEST AND ZIME<0   !ATGRIEZTA
     PAV_DOK_SENR=CLIP(PAV:DOK_SENR)&'-AT'
     PAV_PIELIK=PAV:DOK_SENR
  .
  Auto::Attempts = 0
  LOOP
     DO ASSIGN_U_NR
     IF ~PAV_DOK_SENR
        IF PAV:D_K='K'
           IF SUP_A4_NR=1
              PAV_DOK_SE=SYS:PZ_SERIJA
           ELSIF SUP_A4_NR=2 !AUTO GARANTIJA
              PAV_DOK_SE='G'
           ELSE
              PAV_DOK_SE='K'
           .
           SAV::PAV:Record = PAV:Record
           DO ASSIGN_DOK_NR
           IF PAV_DOK_SE=SYS:PZ_SERIJA AND GETDOK_SENR(2,PAV:DOK_SENR,,'2')>SYS:PZ_NR_END
              KLUDA(0,'beidzies PPR numerâcijas apgabals Lokâlajos datos...')
              PAV:DOK_SENR=''
           .
        ELSIF PAV:D_K='P'
           IF SUP_A4_NR=2 !AUTO GARANTIJA
              PAV_DOK_SE='G'
           ELSE
              PAV_DOK_SE='P'
           .
           SAV::PAV:Record = PAV:Record
           DO ASSIGN_DOK_NR
        ELSIF PAV:D_K='R'
           PAV_DOK_SE='R'
           SAV::PAV:Record = PAV:Record
           DO ASSIGN_DOK_NR
        ELSE
           PAV:DOK_SENR=''
        .
     ELSE
        PAV:DOK_SENR=PAV_DOK_SENR
        PAV:PAMAT='Atgriezta prece'
        PAV:PIELIK=PAV_PIELIK
        PAV:C_DATUMS=0
        PAV:C_SUMMA=0
     .
     IF DUPLICATE(PAV:SENR_KEY)
        KLUDA(0,'Atkârtojas dokumenta SE-Nr : '&CLIP(PAV:DOK_SENR)&' ,atceïam autonumerâciju....')
        PAV:DOK_SENR=''
     .
!     .
!PAV:Record = SAV::PAV:Record un ADD TIKS DOTS VÇLÂK
!   STOP(PAV:DOK_SENR&'SUA4:'&SUP_A4_NR)
  OMIT('AUTONUMBER')  !ES PATS VAIRS NESAPROTU, KÂ TAS BIJA DOMÂTS, IZSKATÂS, KA ES IZLAÎÞU LÎDZ NÂKOÐAJAM OMITAM
    ADD(PAVAD)
    IF ERRORCODE()
      Auto::Attempts += 1
      IF Auto::Attempts = 3
        IF StandardWarning(Warn:AutoIncError) = Button:Retry
          Auto::Attempts = 0
        ELSE
          LocalResponse = RequestCancelled
          EXIT
        END
      END
      CYCLE
    END
    BREAK
  END
ClosingWindow ROUTINE
  Update::Reloop = 0
  IF LocalResponse <> RequestCompleted
    DO CancelAutoIncrement
  END

CancelAutoIncrement ROUTINE
  IF LocalResponse <> RequestCompleted
    IF OriginalRequest = InsertRecord
      IF LocalResponse = RequestCancelled
        DELETE(PAVAD)
      END
    END
  END
FORM::AssignButtons ROUTINE
  ToolBarMode=FormMode
  DISABLE(TBarBrwFirst,TBarBrwLast)
  ENABLE(TBarBrwHistory)
  CASE OriginalRequest
  OF InsertRecord
    ENABLE(TBarBrwDown)
    ENABLE(TBarBrwInsert)
    TBarBrwDown{PROP:ToolTip}='Save record and add another'
    TBarBrwInsert{PROP:ToolTip}=TBarBrwDown{PROP:ToolTip}
  OF ChangeRecord
    ENABLE(TBarBrwBottom,TBarBrwUp)
    ENABLE(TBarBrwInsert)
    TBarBrwBottom{PROP:ToolTip}='Save changes and go to last record'
    TBarBrwTop{PROP:ToolTip}='Save changes and go to first record'
    TBarBrwPageDown{PROP:ToolTip}='Save changes and page down to record'
    TBarBrwPageUp{PROP:ToolTip}='Save changes and page up to record'
    TBarBrwDown{PROP:ToolTip}='Save changes and go to next record'
    TBarBrwUP{PROP:ToolTip}='Save changes and go to previous record'
    TBarBrwInsert{PROP:ToolTip}='Save this record and add a new one'
  END
  DISPLAY(TBarBrwFirst,TBarBrwLast)


!----------------------------------------------------
FLD7::FillList ROUTINE
!|
!| This routine is used to fill the queue that is used by the FileDrop (FD)
!| control template.
!|
!| First, the queue used by the FD (Queue:FileDrop) is FREEd, in case this routine is
!| called by EMBED code and when the window gains focus.
!|
!| Next, the VIEW used by the FD is setup and opened. In a loop, each record of the
!| view is retrieved and, if applicable, added to the FD queue. The view is then closed.
!|
!| Finally, the queue is sorted, and the necessary record retrieved.
!|
  FREE(Queue:FileDrop)
  SET(VAL:NOS_KEY)
  FLD7::View{Prop:Filter} = ''
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  OPEN(FLD7::View)
  IF ERRORCODE()
    StandardWarning(Warn:ViewOpenError)
  END
  LOOP
    NEXT(FLD7::View)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'VAL_K')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    FLD7::VAL:VAL = VAL:VAL
    ADD(Queue:FileDrop)
  END
  CLOSE(FLD7::View)
  IF RECORDS(Queue:FileDrop)
    IF PAV:val
      LOOP FLD7::LoopIndex = 1 TO RECORDS(Queue:FileDrop)
        GET(Queue:FileDrop,FLD7::LoopIndex)
        IF PAV:val = FLD7::VAL:VAL THEN BREAK.
      END
      ?PAV:val{Prop:Selected} = FLD7::LoopIndex
    END
  ELSE
    CLEAR(PAV:val)
  END
