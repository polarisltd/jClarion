                     MEMBER('winlats.clw')        ! This is a MEMBER module
Upali PROCEDURE
  CODE
  IF StandardWarning(Warn:ProcedureToDo,'Upali')
    SETKEYCODE(0)
    GlobalResponse = RequestCancelled
    RETURN
  END
UpdateAlgas PROCEDURE


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
DAIEV_N              STRING(35),DIM(35)
PIESK1               DECIMAL(10,2)
IETUR                DECIMAL(10,2)
MIA                  DECIMAL(7,2)
BER                  DECIMAL(7,2)
INV                  DECIMAL(7,2)
BLA                  DECIMAL(2)
UINI                 STRING(20)
LIST1:QUEUE          QUEUE,PRE()
ALG_STATUSS          STRING(20)
                     END
ZINA1                STRING(35)
ZINA2                STRING(25)
Update::Reloop  BYTE
Update::Error   BYTE
History::ALG:Record LIKE(ALG:Record),STATIC
SAV::ALG:Record      LIKE(ALG:Record)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update ALGAS'),AT(,,360,312),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateALGAS'),SYSTEM,GRAY,RESIZE,MDI
                       SHEET,AT(0,4,357,254),USE(?Sheet1)
                         TAB('Pieskaitîj&umi'),USE(?Tab1)
                           STRING('KODS'),AT(25,25),USE(?StringKODS)
                           STRING('L'),AT(49,25,11,10),USE(?String2)
                           STRING('St.'),AT(66,25),USE(?String3)
                           STRING('Dienas'),AT(82,25),USE(?String68)
                           STRING('Nosaukums'),AT(165,25),USE(?String4)
                           STRING('Arguments'),AT(261,25),USE(?String5)
                           STRING('Rezultâts'),AT(306,25),USE(?String6)
                           PROMPT('&1:'),AT(9,39,6,8),USE(?Prompt1)
                           ENTRY(@n3b),AT(25,39,,8),USE(ALG:K[1])
                           ENTRY(@n1b),AT(49,39,9,8),USE(ALG:L[1])
                           ENTRY(@n3b),AT(61,39,21,8),USE(ALG:S[1])
                           STRING(@n2b),AT(89,39),USE(ALG:D[1])
                           STRING(@s35),AT(110,39,143,8),USE(DAIEV_N[1]),LEFT
                           ENTRY(@n_9.3b),AT(258,39,36,8),USE(ALG:A[1])
                           ENTRY(@n-_11.2b),AT(301,39,42,8),USE(ALG:R[1])
                           PROMPT('&2:'),AT(9,49,6,8),USE(?Prompt1:2)
                           ENTRY(@n3b),AT(25,49,,8),USE(ALG:K[2])
                           ENTRY(@n1b),AT(49,49,9,8),USE(ALG:L[2])
                           ENTRY(@n3b),AT(61,49,21,8),USE(ALG:S[2])
                           STRING(@n2b),AT(89,49),USE(ALG:D[2])
                           STRING(@s35),AT(110,49,143,8),USE(DAIEV_N[2]),LEFT
                           ENTRY(@n_9.3b),AT(258,49,36,8),USE(ALG:A[2])
                           ENTRY(@n-_11.2b),AT(301,49,42,8),USE(ALG:R[2])
                           PROMPT('&3:'),AT(9,60,,8),USE(?Prompt1:3)
                           ENTRY(@n3b),AT(25,58,,8),USE(ALG:K[3])
                           ENTRY(@n1b),AT(49,58,9,8),USE(ALG:L[3])
                           ENTRY(@n3b),AT(61,58,21,8),USE(ALG:S[3])
                           STRING(@n2b),AT(89,58),USE(ALG:D[3])
                           STRING(@s35),AT(110,58,143,8),USE(DAIEV_N[3]),LEFT
                           ENTRY(@n_9.3b),AT(258,58,36,8),USE(ALG:A[3])
                           ENTRY(@n-_11.2b),AT(301,58,42,8),USE(ALG:R[3])
                           PROMPT('&4:'),AT(9,68,,8),USE(?Prompt1:4)
                           ENTRY(@n3b),AT(25,68,,8),USE(ALG:K[4])
                           ENTRY(@n1b),AT(49,68,9,8),USE(ALG:L[4])
                           ENTRY(@n3b),AT(61,68,21,8),USE(ALG:S[4])
                           STRING(@n2b),AT(89,68),USE(ALG:D[4])
                           STRING(@s35),AT(110,68,143,8),USE(DAIEV_N[4]),LEFT
                           ENTRY(@n_9.3b),AT(258,68,36,8),USE(ALG:A[4])
                           ENTRY(@n-_11.2b),AT(301,68,42,8),USE(ALG:R[4])
                           PROMPT('&5:'),AT(9,79,,8),USE(?Prompt1:5)
                           ENTRY(@n3b),AT(25,79,,8),USE(ALG:K[5])
                           ENTRY(@n1b),AT(49,79,9,8),USE(ALG:L[5])
                           ENTRY(@n3b),AT(61,79,21,8),USE(ALG:S[5])
                           STRING(@n2b),AT(89,79),USE(ALG:D[5])
                           STRING(@s35),AT(110,79,143,8),USE(DAIEV_N[5]),LEFT
                           ENTRY(@n_9.3b),AT(258,79,36,8),USE(ALG:A[5])
                           ENTRY(@n-_11.2b),AT(301,79,42,8),USE(ALG:R[5])
                           PROMPT('&6:'),AT(9,89,,8),USE(?Prompt1:6)
                           ENTRY(@n3b),AT(25,89,,8),USE(ALG:K[6])
                           ENTRY(@n1b),AT(49,89,9,8),USE(ALG:L[6])
                           ENTRY(@n3b),AT(61,89,21,8),USE(ALG:S[6])
                           STRING(@n2b),AT(89,89),USE(ALG:D[6])
                           STRING(@s35),AT(110,89,143,8),USE(DAIEV_N[6]),LEFT
                           ENTRY(@n_9.3b),AT(258,89,36,8),USE(ALG:A[6])
                           ENTRY(@n-_11.2b),AT(301,89,42,8),USE(ALG:R[6])
                           STRING(@n2b),AT(89,98),USE(ALG:D[7])
                           PROMPT('&7:'),AT(9,98,,8),USE(?Prompt1:7)
                           ENTRY(@n3b),AT(25,98,,8),USE(ALG:K[7])
                           ENTRY(@n1b),AT(49,98,9,8),USE(ALG:L[7])
                           ENTRY(@n3b),AT(61,98,21,8),USE(ALG:S[7])
                           STRING(@s35),AT(110,98,143,8),USE(DAIEV_N[7]),LEFT
                           ENTRY(@n_9.3b),AT(258,98,36,8),USE(ALG:A[7])
                           ENTRY(@n-_11.2b),AT(301,98,42,8),USE(ALG:R[7])
                           PROMPT('&8:'),AT(9,108,,8),USE(?Prompt1:8)
                           ENTRY(@n3B),AT(25,108,,8),USE(ALG:K[8])
                           ENTRY(@n1B),AT(49,108,9,8),USE(ALG:L[8])
                           ENTRY(@n3B),AT(61,108,21,8),USE(ALG:S[8])
                           STRING(@n2b),AT(89,108),USE(ALG:D[8])
                           STRING(@s35),AT(110,108,143,8),USE(DAIEV_N[8]),LEFT
                           ENTRY(@n_9.3b),AT(258,108,36,8),USE(ALG:A[8])
                           ENTRY(@n-_11.2b),AT(301,108,42,8),USE(ALG:R[8])
                           PROMPT('&9:'),AT(9,119,,8),USE(?Prompt1:9)
                           ENTRY(@n3B),AT(25,119,,8),USE(ALG:K[9])
                           ENTRY(@n1B),AT(49,119,9,8),USE(ALG:L[9])
                           ENTRY(@n3B),AT(61,119,21,8),USE(ALG:S[9])
                           STRING(@n2b),AT(89,119),USE(ALG:D[9])
                           STRING(@s35),AT(110,119,143,8),USE(DAIEV_N[9]),LEFT
                           ENTRY(@n_9.3b),AT(258,119,36,8),USE(ALG:A[9])
                           ENTRY(@n-_11.2b),AT(301,119,42,8),USE(ALG:R[9])
                           PROMPT('&A:'),AT(9,129,11,8),USE(?Prompt1:10)
                           ENTRY(@n3B),AT(25,129,,8),USE(ALG:K[10])
                           ENTRY(@n1B),AT(49,129,9,8),USE(ALG:L[10])
                           ENTRY(@n3B),AT(61,129,21,8),USE(ALG:S[10])
                           STRING(@n2b),AT(89,129),USE(ALG:D[10])
                           STRING(@s35),AT(110,129,143,8),USE(DAIEV_N[10]),LEFT
                           ENTRY(@n_9.3b),AT(258,129,36,8),USE(ALG:A[10])
                           ENTRY(@n-_11.2b),AT(301,129,42,8),USE(ALG:R[10])
                           PROMPT('&B:'),AT(9,140,11,8),USE(?Prompt1:11)
                           ENTRY(@n3B),AT(25,140,21,8),USE(ALG:K[11])
                           ENTRY(@n1B),AT(49,140,9,8),USE(ALG:L[11])
                           ENTRY(@n3B),AT(61,140,21,8),USE(ALG:S[11])
                           STRING(@n2b),AT(89,140,13,8),USE(ALG:D[11])
                           STRING(@s35),AT(110,140,143,8),USE(DAIEV_N[11]),LEFT
                           ENTRY(@n_9.3b),AT(258,140,36,8),USE(ALG:A[11])
                           ENTRY(@n-_11.2b),AT(301,140,42,8),USE(ALG:R[11])
                           PROMPT('&C:'),AT(9,148,11,8),USE(?Prompt1:12)
                           ENTRY(@n3B),AT(25,148,21,8),USE(ALG:K[12])
                           ENTRY(@n1B),AT(49,148,9,8),USE(ALG:L[12])
                           ENTRY(@n3B),AT(61,148,21,8),USE(ALG:S[12])
                           STRING(@n2b),AT(89,148,13,8),USE(ALG:D[12])
                           STRING(@s35),AT(110,148,143,8),USE(DAIEV_N[12]),LEFT
                           ENTRY(@n_9.3b),AT(258,148,36,8),USE(ALG:A[12])
                           ENTRY(@n-_11.2b),AT(301,148,42,8),USE(ALG:R[12])
                           STRING(@n2b),AT(89,159,13,8),USE(ALG:D[13])
                           PROMPT('&D:'),AT(9,159,11,8),USE(?Prompt1:13)
                           ENTRY(@n3B),AT(25,159,21,8),USE(ALG:K[13])
                           ENTRY(@n1B),AT(49,159,9,8),USE(ALG:L[13])
                           ENTRY(@n3B),AT(61,159,21,8),USE(ALG:S[13])
                           STRING(@s35),AT(110,159,143,8),USE(DAIEV_N[13]),LEFT
                           ENTRY(@n_9.3b),AT(258,159,36,8),USE(ALG:A[13])
                           ENTRY(@n-_11.2b),AT(301,159,42,8),USE(ALG:R[13])
                           STRING(@n2b),AT(89,169,13,8),USE(ALG:D[14])
                           PROMPT('&E:'),AT(9,169,11,8),USE(?Prompt1:14)
                           ENTRY(@n3B),AT(25,169,21,8),USE(ALG:K[14])
                           ENTRY(@n1B),AT(49,169,9,8),USE(ALG:L[14])
                           ENTRY(@n3B),AT(61,169,21,8),USE(ALG:S[14])
                           STRING(@s35),AT(110,169,143,8),USE(DAIEV_N[14]),LEFT
                           ENTRY(@n_9.3b),AT(258,169,36,8),USE(ALG:A[14])
                           ENTRY(@n-_11.2b),AT(301,169,42,8),USE(ALG:R[14])
                           STRING(@n2b),AT(89,180,13,8),USE(ALG:D[15])
                           PROMPT('&F:'),AT(9,180,11,8),USE(?Prompt1:15)
                           ENTRY(@n3B),AT(25,180,21,8),USE(ALG:K[15])
                           ENTRY(@n1B),AT(49,180,9,8),USE(ALG:L[15])
                           ENTRY(@n3B),AT(61,180,21,8),USE(ALG:S[15])
                           STRING(@s35),AT(110,180,143,8),USE(DAIEV_N[15]),LEFT
                           ENTRY(@n_9.3b),AT(258,180,36,8),USE(ALG:A[15])
                           ENTRY(@n-_11.2b),AT(301,180,42,8),USE(ALG:R[15])
                           STRING(@n2b),AT(89,188,13,8),USE(ALG:D[16])
                           PROMPT('&G:'),AT(9,188,11,8),USE(?Prompt1:16)
                           ENTRY(@n3B),AT(25,188,21,8),USE(ALG:K[16])
                           ENTRY(@n1B),AT(49,188,9,8),USE(ALG:L[16])
                           ENTRY(@n3B),AT(61,188,21,8),USE(ALG:S[16])
                           STRING(@s35),AT(110,188,143,8),USE(DAIEV_N[16]),LEFT
                           ENTRY(@n_9.3b),AT(258,188,36,8),USE(ALG:A[16])
                           ENTRY(@n-_11.2b),AT(301,188,42,8),USE(ALG:R[16])
                           PROMPT('&H:'),AT(9,199,11,8),USE(?Prompt1:17)
                           ENTRY(@n3B),AT(25,199,21,8),USE(ALG:K[17])
                           ENTRY(@n1B),AT(49,199,9,8),USE(ALG:L[17])
                           ENTRY(@n3B),AT(61,199,21,8),USE(ALG:S[17])
                           STRING(@n2b),AT(89,199,13,8),USE(ALG:D[17])
                           STRING(@s35),AT(110,199,143,8),USE(DAIEV_N[17]),LEFT
                           ENTRY(@n_9.3b),AT(258,199,36,8),USE(ALG:A[17])
                           ENTRY(@n-_11.2b),AT(301,199,42,8),USE(ALG:R[17])
                           PROMPT('&I:'),AT(9,209,11,8),USE(?Prompt1:18)
                           ENTRY(@n3B),AT(25,209,21,8),USE(ALG:K[18])
                           ENTRY(@n1B),AT(49,209,9,8),USE(ALG:L[18])
                           ENTRY(@n3B),AT(61,209,21,8),USE(ALG:S[18])
                           STRING(@n2b),AT(89,209,13,8),USE(ALG:D[18])
                           STRING(@s35),AT(110,209,143,8),USE(DAIEV_N[18]),LEFT
                           ENTRY(@n_9.3b),AT(258,209,36,8),USE(ALG:A[18])
                           ENTRY(@n-_11.2b),AT(301,209,42,8),USE(ALG:R[18])
                           PROMPT('&J:'),AT(9,220,11,8),USE(?Prompt1:19)
                           ENTRY(@n3B),AT(25,220,21,8),USE(ALG:K[19])
                           ENTRY(@n1B),AT(49,220,9,8),USE(ALG:L[19])
                           ENTRY(@n3B),AT(61,220,21,8),USE(ALG:S[19])
                           STRING(@n2b),AT(89,220,13,8),USE(ALG:D[19])
                           STRING(@s35),AT(110,218,143,8),USE(DAIEV_N[19]),LEFT
                           ENTRY(@n_9.3b),AT(258,218,36,8),USE(ALG:A[19])
                           ENTRY(@n-_11.2b),AT(301,218,42,8),USE(ALG:R[19])
                           PROMPT('&K:'),AT(9,228,11,8),USE(?Prompt1:20)
                           ENTRY(@n3b),AT(25,228,21,8),USE(ALG:K[20])
                           ENTRY(@n1b),AT(49,228,9,8),USE(ALG:L[20])
                           ENTRY(@n3b),AT(61,228,21,8),USE(ALG:S[20])
                           STRING(@n2b),AT(89,228,13,8),USE(ALG:D[20])
                           STRING(@s35),AT(110,228,143,8),USE(DAIEV_N[20]),LEFT
                           ENTRY(@n_9.3b),AT(258,228,36,8),USE(ALG:A[20])
                           ENTRY(@n-_11.2b),AT(301,228,42,8),USE(ALG:R[20],,?ALGR20)
                         END
                         TAB('Ietu&rçjumi'),USE(?Tab2)
                           STRING('KODS'),AT(33,28),USE(?StringKODSI)
                           STRING('L'),AT(58,28,7,10),USE(?String2:2)
                           STRING('Nosaukums'),AT(122,28),USE(?String773)
                           STRING('Arguments'),AT(221,28),USE(?String74)
                           STRING('Rezultâts'),AT(261,28),USE(?String75)
                           PROMPT('&1 :'),AT(18,41,,8),USE(?Prompt21)
                           ENTRY(@n3b),AT(33,41,22,8),USE(ALG:I[1])
                           ENTRY(@n1b),AT(57,41,10,8),USE(ALG:J[1])
                           STRING(@s35),AT(73,41,,8),USE(DAIEV_N[21])
                           ENTRY(@n_9.2b),AT(221,41,36,8),USE(ALG:C[1])
                           ENTRY(@n-_11.2b),AT(260,41,42,8),USE(ALG:N[1])
                           PROMPT('&2 :'),AT(18,52,,8),USE(?Prompt22)
                           ENTRY(@n3b),AT(33,52,22,8),USE(ALG:I[2])
                           ENTRY(@n1b),AT(57,52,10,8),USE(ALG:J[2])
                           STRING(@s35),AT(73,52,,8),USE(DAIEV_N[22])
                           ENTRY(@n_9.2b),AT(221,52,36,8),USE(ALG:C[2])
                           ENTRY(@n-_11.2b),AT(260,52,42,8),USE(ALG:N[2])
                           PROMPT('&3 :'),AT(18,60,,8),USE(?Prompt23)
                           ENTRY(@n3b),AT(33,60,22,8),USE(ALG:I[3])
                           ENTRY(@n1b),AT(57,60,10,8),USE(ALG:J[3])
                           STRING(@s35),AT(73,60,,8),USE(DAIEV_N[23])
                           ENTRY(@n_9.2b),AT(221,60,36,8),USE(ALG:C[3])
                           ENTRY(@n-_11.2b),AT(260,60,42,8),USE(ALG:N[3])
                           PROMPT('&4 :'),AT(18,71,,8),USE(?Prompt24)
                           ENTRY(@n3b),AT(33,71,22,8),USE(ALG:I[4])
                           ENTRY(@n1b),AT(57,71,10,8),USE(ALG:J[4])
                           STRING(@s35),AT(73,71,,8),USE(DAIEV_N[24])
                           ENTRY(@n_9.2b),AT(221,71,36,8),USE(ALG:C[4])
                           ENTRY(@n-_11.2b),AT(260,71,42,8),USE(ALG:N[4])
                           PROMPT('&5 :'),AT(18,81,,8),USE(?Prompt25)
                           ENTRY(@n3b),AT(33,81,22,8),USE(ALG:I[5])
                           ENTRY(@n1b),AT(57,81,10,8),USE(ALG:J[5])
                           STRING(@s35),AT(73,81,,8),USE(DAIEV_N[25])
                           ENTRY(@n_9.2b),AT(221,81,36,8),USE(ALG:C[5])
                           ENTRY(@n-_11.2b),AT(260,81,42,8),USE(ALG:N[5])
                           PROMPT('&6 :'),AT(18,92,,8),USE(?Prompt26)
                           ENTRY(@n3b),AT(33,92,22,8),USE(ALG:I[6])
                           ENTRY(@n1b),AT(57,92,10,8),USE(ALG:J[6])
                           STRING(@s35),AT(73,92,145,8),USE(DAIEV_N[26])
                           ENTRY(@n_9.2b),AT(221,92,36,8),USE(ALG:C[6])
                           ENTRY(@n-_11.2b),AT(260,92,42,8),USE(ALG:N[6])
                           PROMPT('&7 :'),AT(18,100,,8),USE(?Prompt27)
                           ENTRY(@n3b),AT(33,100,22,8),USE(ALG:I[7])
                           ENTRY(@n1b),AT(57,100,10,8),USE(ALG:J[7])
                           STRING(@s35),AT(73,100,,8),USE(DAIEV_N[27])
                           ENTRY(@n_9.2b),AT(221,100,36,8),USE(ALG:C[7])
                           ENTRY(@n-_11.2b),AT(260,100,42,8),USE(ALG:N[7])
                           PROMPT('&8 :'),AT(18,111,,8),USE(?Prompt28)
                           ENTRY(@n3b),AT(33,111,22,8),USE(ALG:I[8])
                           ENTRY(@n1b),AT(57,111,10,8),USE(ALG:J[8])
                           STRING(@s35),AT(73,111,,8),USE(DAIEV_N[28])
                           ENTRY(@n_9.2b),AT(221,111,36,8),USE(ALG:C[8])
                           ENTRY(@n-_11.2b),AT(260,111,42,8),USE(ALG:N[8])
                           PROMPT('&9 :'),AT(18,121,,8),USE(?Prompt29)
                           ENTRY(@n3b),AT(33,121,22,8),USE(ALG:I[9])
                           ENTRY(@n1b),AT(57,121,10,8),USE(ALG:J[9])
                           STRING(@s35),AT(73,121,,8),USE(DAIEV_N[29])
                           ENTRY(@n_9.2b),AT(221,121,36,8),USE(ALG:C[9])
                           ENTRY(@n-_11.2b),AT(260,121,42,8),USE(ALG:N[9])
                           PROMPT('&A :'),AT(18,132,,8),USE(?Prompt30)
                           ENTRY(@n3B),AT(33,132,22,8),USE(ALG:I[10])
                           ENTRY(@n1B),AT(57,132,10,8),USE(ALG:J[10])
                           STRING(@s35),AT(73,132,,8),USE(DAIEV_N[30])
                           ENTRY(@n_9.2b),AT(221,132,36,8),USE(ALG:C[10])
                           ENTRY(@n-_11.2b),AT(260,132,42,8),USE(ALG:N[10])
                           PROMPT('&B :'),AT(18,140,,8),USE(?Prompt31)
                           ENTRY(@n3B),AT(33,140,22,8),USE(ALG:I[11])
                           ENTRY(@n1B),AT(57,140,10,8),USE(ALG:J[11])
                           STRING(@s35),AT(73,140,,8),USE(DAIEV_N[31])
                           ENTRY(@n_9.2b),AT(221,140,36,8),USE(ALG:C[11])
                           ENTRY(@n-_11.2b),AT(260,140,42,8),USE(ALG:N[11])
                           PROMPT('&C :'),AT(18,151,,8),USE(?Prompt32)
                           ENTRY(@n3B),AT(33,151,22,8),USE(ALG:I[12])
                           ENTRY(@n1B),AT(57,151,10,8),USE(ALG:J[12])
                           STRING(@s35),AT(73,151,,8),USE(DAIEV_N[32])
                           ENTRY(@n_9.2b),AT(221,151,36,8),USE(ALG:C[12])
                           ENTRY(@n-_11.2b),AT(260,151,42,8),USE(ALG:N[12])
                           PROMPT('&D :'),AT(18,161,,8),USE(?Prompt33)
                           ENTRY(@n3B),AT(33,161,22,8),USE(ALG:I[13])
                           ENTRY(@n1B),AT(57,161,10,8),USE(ALG:J[13])
                           STRING(@s35),AT(73,161,,8),USE(DAIEV_N[33])
                           ENTRY(@n_9.2b),AT(221,161,36,8),USE(ALG:C[13])
                           ENTRY(@n-_11.2b),AT(260,161,42,8),USE(ALG:N[13])
                           PROMPT('&E :'),AT(18,170,,8),USE(?Prompt34)
                           ENTRY(@n3B),AT(33,170,22,8),USE(ALG:I[14])
                           ENTRY(@n1B),AT(57,170,10,8),USE(ALG:J[14])
                           STRING(@s35),AT(73,170,,8),USE(DAIEV_N[34])
                           ENTRY(@n_9.2b),AT(221,170,36,8),USE(ALG:C[14])
                           ENTRY(@n-_11.2b),AT(260,170,42,8),USE(ALG:N[14])
                           PROMPT('&F :'),AT(18,180,,8),USE(?Prompt35)
                           ENTRY(@n3B),AT(33,180,22,8),USE(ALG:I[15])
                           ENTRY(@n1B),AT(57,180,10,8),USE(ALG:J[15])
                           STRING(@s35),AT(73,180,,8),USE(DAIEV_N[35])
                           ENTRY(@n_9.2b),AT(221,180,36,8),USE(ALG:C[15])
                           ENTRY(@n-_11.2b),AT(260,180,42,8),USE(ALG:N[15])
                           PROMPT('&Ieturçts IIN:'),AT(30,212,45,10),USE(?ALG:IIN:Prompt)
                           ENTRY(@n-11.2),AT(81,212,32,13),USE(ALG:IIN),RIGHT(1)
                           ENTRY(@d06.B),AT(117,212,48,13),USE(ALG:IIN_DATUMS)
                           BUTTON('Lock IIN'),AT(168,212,45,14),USE(?ButtonLock)
                           IMAGE('CHECK2.ICO'),AT(214,207,17,19),USE(?ImageIIN),HIDE
                         END
                         TAB('Papildu&s dati'),USE(?Tab3)
                           STRING('Neapl. minimums :'),AT(14,22,60,10),USE(?StringNM)
                           STRING(@n6.2),AT(75,22,28,10),USE(ALP:MIA)
                           OPTION('Papildus at&vieglojumi'),AT(172,20,146,79),USE(ALG:INV_P),BOXED
                             RADIO('0 - nav'),AT(180,28),USE(?ALG:INV_P:Radio1),VALUE('0')
                             RADIO('1 - 1. gr. invaliditâte'),AT(180,38),USE(?ALG:INV_P:Radio2),VALUE('1')
                             RADIO('2 - 2. gr. invaliditâte'),AT(180,47),USE(?ALG:INV_P:Radio3),VALUE('2')
                             RADIO('3 - 3. gr. invaliditâte'),AT(180,58),USE(?ALG:INV_P:Radio4),VALUE('3')
                             RADIO('4 - politiski represçta persona'),AT(180,68),USE(?ALG:INV_P:Radio5),VALUE('4')
                             RADIO('5 - PRP, nesaòem pensiju'),AT(180,78),USE(?ALG:INV_P:Radio6),VALUE('5')
                             RADIO('6 - pensionârs'),AT(180,87),USE(?ALG:INV_P:Radio7),VALUE('6')
                           END
                           PROMPT('&Nodaïa :'),AT(110,25,35,10),USE(?Prompt41)
                           ENTRY(@S2),AT(149,25,19,10),USE(ALG:NODALA),CENTER,OVR
                           PROMPT('Projekts(ob&j) :'),AT(89,36,46,10),USE(?Prompt41:2)
                           ENTRY(@N_6B),AT(139,36,29,10),USE(ALG:OBJ_NR),CENTER
                           PROMPT('&Statuss :'),AT(54,52,29,10),USE(?Prompt2)
                           LIST,AT(86,52,68,12),USE(ALG_STATUSS),DROP(10),FROM(List1:Queue)
                           BUTTON('U.lîgums'),AT(14,36,38,14),USE(?ButtonUL)
                           IMAGE('CHECK2.ICO'),AT(54,33,16,17),USE(?ImageUL),HIDE
                           PROMPT('Ap&gâdâjamo skaits :'),AT(53,66,70,10),USE(?Prompt3)
                           ENTRY(@n1b),AT(133,66,19,10),USE(ALG:APGAD_SK),RIGHT
                           PROMPT('Pârrçíinâts :'),AT(30,173,42,10),USE(?Prompt5)
                           STRING('WINLATS'),AT(105,173,38,10),USE(?String4:2),CENTER,FONT(,,COLOR:Blue,FONT:bold)
                           STRING('LIETOTÂJS'),AT(162,173,41,10),USE(?String5:2),CENTER,FONT(,,COLOR:Red,FONT:bold)
                           LINE,AT(13,185,218,0),USE(?Line9),COLOR(COLOR:Black)
                           LINE,AT(231,227,0,-62),USE(?Line8),COLOR(COLOR:Black)
                           GROUP('Attaisnotie izdevumi'),AT(233,163,114,65),USE(?Group1),BOXED
                             STRING('iemaksas veic Darba òçmçjs'),AT(238,171),USE(?String96)
                             PROMPT('Pr&iv,pens.f.:'),AT(236,187),USE(?ALG:PPF:Prompt)
                             PROMPT('&Dzîv.apdr.p.:'),AT(236,200),USE(?ALG:VAP:Prompt)
                             ENTRY(@n-9.2),AT(278,198,32,12),USE(ALG:DZIVAP),RIGHT,MSG('Veselîbas apdroðinâðanas polise')
                             BUTTON('L'),AT(313,200,15,14),USE(?ButtonLockDZ_AB)
                             PROMPT('Izdevumi:'),AT(236,214),USE(?ALG:IZDEV:Prompt)
                             ENTRY(@n-10.2),AT(278,214,32,12),USE(ALG:IZDEV),DECIMAL(12),MSG('citi ATTAISNOTIE IZDEVUMI'),TIP('citi ATTAISNOTIE IZDEVUMI')
                             IMAGE('CHECK2.ICO'),AT(329,198,16,17),USE(?IMAGELOCDZ_AB),HIDE
                             ENTRY(@n-9.2),AT(278,184,32,12),USE(ALG:PPF),RIGHT,MSG('Privâtie pensiju fondi')
                             BUTTON('L'),AT(313,184,15,14),USE(?ButtonLockPPF)
                             IMAGE('CHECK2.ICO'),AT(329,179,16,17),USE(?ImageLockPPF),HIDE
                           END
                           LINE,AT(13,166,0,62),USE(?Line7),COLOR(COLOR:Black)
                           PROMPT('&Neapliekamais minimums :'),AT(17,189,85,10),USE(?Prompt6)
                           STRING(@n8.2),AT(101,189,41,10),USE(MIA),RIGHT,FONT(,,COLOR:Blue,FONT:bold)
                           STRING('(0 - atstât, kâ ir)'),AT(174,189,53,10),USE(?String16)
                           PROMPT('Atvieglojums par &bçrniem :'),AT(16,201,86,10),USE(?Prompt6:2)
                           STRING(@n8.2),AT(108,201,34,10),USE(BER),RIGHT,FONT(,,COLOR:Blue,FONT:bold)
                           STRING('(0 - atstât, kâ ir)'),AT(174,213,53,10),USE(?String16:3)
                           STRING('Alga izmaksâta:'),AT(252,229),USE(?String92)
                           STRING(@D06.B),AT(306,229),USE(ALG:IIN_DATUMS,,?ALG:IIN_DATUMS:2)
                           PROMPT('Atvieglojums INV, P&RP :'),AT(23,213,79,10),USE(?Prompt6:3)
                           STRING(@n8.2),AT(108,213,34,10),USE(INV),RIGHT,FONT(,,COLOR:Blue,FONT:bold)
                           STRING('(0 - atstât, kâ ir)'),AT(174,201,53,10),USE(?String16:2)
                           PROMPT('B - slimîbas lapa :'),AT(141,242,59,10),USE(?Prompt6:4)
                           STRING(@n-3.0),AT(201,242,15,10),USE(BLA)
                           STRING('(dienas)'),AT(217,242,26,10),USE(?String13)
                           PROMPT('&Darba devçja sociâlais nodoklis :'),AT(17,76,108,10),USE(?Prompt6:5)
                           ENTRY(@n5.2),AT(129,76,23,10),USE(ALG:PR37),RIGHT
                           STRING('%'),AT(157,87,9,10),USE(?String14:2)
                           OPTION('&Valsts sociâlâs apdroðinâðanas statuss'),AT(16,98,302,65),USE(ALG:SOC_V),BOXED
                             RADIO('1-DN, kurð apdr. atbilstoði visiem VSA veidiem'),AT(20,107),USE(?ALG:SOC_V:Radio:1),VALUE('1')
                             RADIO('2-DN, izdienas pensijas saòçmçji vai invalîdi- valsts speciâlâs pensijas saòçmçj' &|
   'i'),AT(20,116),USE(?ALG:SOC_V:Radio:2),VALUE('2')
                             RADIO('3-Valsts vecuma pensija, pieðíirta vecuma pensija ar atvieglotiem noteikumiem'),AT(20,125),USE(?ALG:SOC_V:Radio:3),VALUE('3')
                             RADIO('4-Persona, kura nav obligâti sociâli apdroðinâma'),AT(20,134),USE(?ALG:SOC_V:Radio:4),VALUE('4')
                             RADIO('5-DN, kurð tiek nodarbinâts brîvîbas atòemðanas soda izcieðanas laikâ'),AT(20,143,261,10),USE(?ALG:SOC_V:Radio:5),VALUE('5')
                             RADIO('6-DN-pensionârs, kurð tiek nodarbinâts brîvîbas atòemðanas soda izcieðanas laikâ'),AT(20,152,290,10),USE(?ALG:SOC_V:Radio6),VALUE('6')
                           END
                           LINE,AT(13,227,218,0),USE(?Line6),COLOR(COLOR:Black)
                           PROMPT('Nostrâdâtâs St&undas:'),AT(2,237,81,10),USE(?ALG:N_Stundas:Prompt),RIGHT
                           IMAGE('CHECK2.ICO'),AT(124,237,16,17),USE(?ImageLockNS),HIDE
                           ENTRY(@n3b),AT(85,239),USE(ALG:N_Stundas),RIGHT(1)
                           BUTTON('L'),AT(108,237,15,14),USE(?ButtonLockNS)
                           ENTRY(@n8.2),AT(146,213,27,10),USE(ALG:LINV),RIGHT
                           ENTRY(@n8.2),AT(146,201,27,10),USE(ALG:LBER),RIGHT
                           ENTRY(@n8.2),AT(146,189,27,10),USE(ALG:LMIA),RIGHT
                           PROMPT('Darba òçmçja so&ciâlais nodoklis :'),AT(17,87,109,10),USE(?Prompt6:6)
                           ENTRY(@n5.2),AT(129,87,23,10),USE(ALG:PR1),RIGHT
                           STRING('%'),AT(157,76,9,10),USE(?String14)
                           LINE,AT(13,166,218,0),USE(?Line2),COLOR(COLOR:Black)
                           LINE,AT(144,166,0,62),USE(?Line5),COLOR(COLOR:Black)
                           PROMPT('&Teritorijas kods:'),AT(252,242,55,10),USE(?ALG:TERKOD:Prompt)
                           ENTRY(@n06),AT(309,240),USE(ALG:TERKOD)
                           PROMPT('(VSAOIINzin,vid.alga)'),AT(2,247,81,10),USE(?ALG:N_Stundas:Prompt:2),RIGHT
                         END
                       END
                       STRING('Pieskaitîjumi kopâ :'),AT(188,260),USE(?String7:2),RIGHT
                       STRING(@n-12.2),AT(252,260),USE(PIESK1),RIGHT
                       STRING(@s35),AT(2,265),USE(ZINA1),CENTER
                       BUTTON('&OK'),AT(213,291,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(261,291,45,14),USE(?Cancel)
                       BUTTON('&Pârrçíinât'),AT(309,291,45,14),USE(?REOR)
                       STRING('Ieturçjumi kopâ :'),AT(197,270),USE(?String7),RIGHT
                       STRING(@n-12.2),AT(252,270),USE(IETUR),RIGHT
                       STRING(@s25),AT(2,274),USE(ZINA2),CENTER,FONT(,,COLOR:Red,FONT:bold,CHARSET:ANSI)
                       STRING('Izmaksai/Pârsk.uz karti :'),AT(171,280),USE(?StringIZPA),RIGHT
                       STRING(@n-12.2),AT(252,280),USE(ALG:IZMAKSAT),RIGHT
                       STRING(@n-12.2B),AT(305,280),USE(ALG:PARSKAITIT),LEFT(1)
                       STRING(@D06.),AT(43,294),USE(ALG:ACC_DATUMS),FONT(,,COLOR:Gray,)
                       STRING('/'),AT(301,280),USE(?String91)
                       STRING(@s8),AT(6,294),USE(ALG:ACC_KODS),FONT(,,COLOR:Gray,)
                     END
SAV_RECORD LIKE(ALG:RECORD),PRE(SAV)
K          LIKE(ALG:K)
L          LIKE(ALG:L)
S          LIKE(ALG:S)
A          LIKE(ALG:A)
R          LIKE(ALG:R)
I          LIKE(ALG:I)

P_table Queue,pre(P)
Kods     decimal(3) !NEDRÎKST LIKE ALG:...
L        BYTE
S        DECIMAL(3)
D        decimal(3)
A        DECIMAL(9,3)
R        DECIMAL(9,2)
        .

SAV_INV_P           DECIMAL(1)
SAV_APGAD           DECIMAL(1)
SAV_PR37            DECIMAL(3,1)
SAV_PR1             DECIMAL(3,1)
SAV_LMIA            DECIMAL(4,2)
SAV_LBER            DECIMAL(4,2)
SAV_LINV            DECIMAL(4,2)
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  UINI=GETKADRI(alg:ID,2,1)
  SAV_RECORD=ALG:RECORD
  IF BAND(ALG:IIN_LOCK,00000001b) !IIN
     UNHIDE(?IMAGEIIN)
  .
  IF BAND(ALG:IIN_LOCK,00000010b) !PPF
     UNHIDE(?IMAGELOCKPPF)
  .
  IF BAND(ALG:IIN_LOCK,00000100b) !NOSTR STUNDAS
     UNHIDE(?IMAGELOCKNS)
  .
  IF BAND(ALG:BAITS,00000001b)    !U_LÎGUMS
     UNHIDE(?IMAGEUL)
    .
  ALG_STATUSS='1-Adm.ar DA.gr.'
  ADD(LIST1:QUEUE)
  ALG_STATUSS='2-Adm.ar Nod.karti'
  ADD(LIST1:QUEUE)
  ALG_STATUSS='3-Str.ar DA.gr.'
  ADD(LIST1:QUEUE)
  ALG_STATUSS='4-Str.ar Nod.karti'
  ADD(LIST1:QUEUE)
  ALG_STATUSS='5-Valdes loceklis'
  ADD(LIST1:QUEUE)
  ALG_STATUSS='7-Arhîvs'
  ADD(LIST1:QUEUE)
  GET(LIST1:QUEUE,0)
  IF ALG:STATUSS='7'
     GET(LIST1:QUEUE,6)
  ELSE
     ST#=ALG:STATUSS
     GET(LIST1:QUEUE,ST#)
  .
  DISPLAY(?ALG_STATUSS)
  IF LOCALREQUEST=1 OR LOCALREQUEST=2
     DO SETUPSCREEN
  .
  DO TOTALS
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
    QuickWindow{PROP:TEXT}=UINI
    IF ~(SAV_RECORD=ALG:RECORD)
       LOOP I#= 1 TO 20
          IF ~(SAV:S[I#]=ALG:S[I#] AND SAV:D[I#]=ALG:D[I#] AND SAV:A[I#]=ALG:A[I#] AND SAV:R[I#]=ALG:R[I#])
             ALG:L[I#]=1
          .
          IF ~(SAV:K[I#]=ALG:K[I#])
             IF INRANGE(ALG:K[I#],840,842) OR|! LAI ATV UZREIZ NENOMAITÂ
                INRANGE(ALG:K[I#],850,851) OR|! LAI SLI UZREIZ NENOMAITÂ
                ALG:K[I#]=880                 ! LAI PIEM PAR SV.D. UZREIZ NENOMAITÂ
                ALG:L[I#]=1
             .
          .
          IF ~(SAV:K[I#]=ALG:K[I#])
             IF ALG:K[I#]
                IF ALG:K[I#]>899 THEN ALG:K[I#]=0.
                IF ~GETDAIEV(ALG:K[I#],0,1)
                   GLOBALREQUEST = SELECTRECORD
                   F:IDP='P' !RÂDÎT PIESKAITÎJUMUS
                   BROWSEDAIEV
                   F:IDP=''
                   IF GLOBALRESPONSE=REQUESTCOMPLETED
                      ALG:K[I#]=DAI:KODS
                   ELSE
                      ALG:K[I#]=0
                   .
                .
             .
          .
       .
       LOOP I#= 1 TO 15
          IF ~(SAV:I[I#]=ALG:I[I#] AND SAV:C[I#]=ALG:C[I#] AND SAV:N[I#]=ALG:N[I#])
             ALG:J[I#]=1    !LOCK
             IF ALG:I[I#]
                IF ALG:I[I#]<901 THEN ALG:I[I#]=0.
                IF ~GETDAIEV(ALG:I[I#],0,1)
                   GLOBALREQUEST = SELECTRECORD
                   F:IDP='I' !RÂDÎT IETURÇJUMUS
                   BROWSEDAIEV
                   F:IDP=''
                   IF GLOBALRESPONSE=REQUESTCOMPLETED
                      ALG:I[I#]=DAI:KODS
                   ELSE
                      ALG:I[I#]=0
                   .
                .
             .
          .
       .
       CALCALGAS
       IF LOCALREQUEST=1 OR LOCALREQUEST=2
          DO SETUPSCREEN
       .
       DO TOTALS
       SAV_RECORD=ALG:RECORD
       DISPLAY
    .
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
      SELECT(?StringKODS)
      IF ALP:STAT=3
         ?STRINGIZPA{PROP:TEXT}='                 Izmaksât :'
         HIDE(?String91) 
         HIDE(?ZINA1)
         HIDE(?ZINA2)
      .
      IF LOCALREQUEST=0 OR LOCALREQUEST=3
         quickwindow{prop:color}=color:activeborder
         DISABLE(?StringKODS,?ALGR20)
         DISABLE(?StringKODSI,?BUTTONLOCK)
         DISABLE(?StringNM,?ALG:TERKOD)
         IF LOCALREQUEST=0
            DISABLE(?OK)
         .
         DISABLE(?REOR)
         SELECT(?CANCEL)
      .
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
      IF ACCEPTED() = TbarBrwHistory
        DO HistoryField
      END
      IF EVENT() = Event:Completed
        History::ALG:Record = ALG:Record
        CASE LocalRequest
        OF InsertRecord
          ADD(ALGAS)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(ALG:ID_KEY)
              IF StandardWarning(Warn:DuplicateKey,'ALG:ID_KEY')
                SELECT(?StringKODS)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?StringKODS)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::ALG:Record <> ALG:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:ALGAS(1)
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
              SELECT(?StringKODS)
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
            IF RIDelete:ALGAS()
              SETCURSOR()
              CASE StandardWarning(Warn:DeleteError)
              OF Button:Yes
                CYCLE
              OF Button:No
                POST(Event:CloseWindow)
                BREAK
              OF Button:Cancel
                DISPLAY
                SELECT(?StringKODS)
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
      END
    END
    CASE FIELD()
    OF ?Sheet1
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
    OF ?ButtonLock
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(ALG:IIN_LOCK,00000001b)
           ALG:IIN_LOCK-=1
           HIDE(?IMAGEIIN)
        ELSE
           ALG:IIN_LOCK+=1
           UNHIDE(?IMAGEIIN)
        .
        DISPLAY
      END
    OF ?ALG_STATUSS
      CASE EVENT()
      OF EVENT:Accepted
        ALG:STATUSS=ALG_STATUSS[1]
      END
    OF ?ButtonUL
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          IF BAND(ALG:BAITS,00000001b)
             ALG:BAITS-=1
             HIDE(?IMAGEUL)
          ELSE
             ALG:BAITS+=1
             UNHIDE(?IMAGEUL)
          .
      END
    OF ?ButtonLockDZ_AB
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(ALG:IIN_LOCK,00010000b) !5-DZ_APDROÐ.
           ALG:IIN_LOCK-=16
           HIDE(?IMAGELOCDZ_AB)
        ELSE
           ALG:IIN_LOCK+=16
           UNHIDE(?IMAGELOCDZ_AB)
        .
        DISPLAY
      END
    OF ?ButtonLockPPF
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(ALG:IIN_LOCK,00000010b)
           ALG:IIN_LOCK-=2
           HIDE(?IMAGELOCKPPF)
        ELSE
           ALG:IIN_LOCK+=2
           UNHIDE(?IMAGELOCKPPF)
        .
        DISPLAY
      END
    OF ?ALG:N_Stundas
      CASE EVENT()
      OF EVENT:Accepted
        IF BAND(ALG:IIN_LOCK,00000100b) !IR LOCKOTAS STUNDAS
        ELSE
          IF ~BAND(ALG:IIN_LOCK,00000100b)  !LOKOJAM STUNAS
             ALG:IIN_LOCK+=4
             UNHIDE(?IMAGELOCKNS)
           .
        .
        DISPLAY
      END
    OF ?ButtonLockNS
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF BAND(ALG:IIN_LOCK,00000100b)  !UNLOCK STUNDAS
           ALG:IIN_LOCK-=4
           HIDE(?IMAGELOCKNS)
        ELSE
           ALG:IIN_LOCK+=4               !LOKOJAM STUNDAS
           UNHIDE(?IMAGELOCKNS)
        .
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
        OMIT('MARIS')
        OK# = 1
        IF ~(ALG:INV_P = SAV_INV_P) OR|
           ~(ALG:APGAD = SAV_APGAD) OR|
           ~(ALG:PR37 = SAV_PR37)   OR|
           ~(ALG:PR1 = SAV_PR1)     OR|
           ~(ALG:LMIA = SAV_LMIA)   OR|
           ~(ALG:LBER = SAV_LBER)   OR|
           ~(ALG:LINV = SAV_LINV)
                PIESK(0)
                PAR
                ATV
                SLI
                NOD
                IET(0,0)
                DISPLAY
        .
        MARIS
        LocalResponse = RequestCompleted
        ALG:ACC_KODS=ACC_kods
        ALG:ACC_DATUMS=today()
      END
    OF ?Cancel
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        VCRRequest = VCRNone
        POST(Event:CloseWindow)
      END
    OF ?REOR
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          calcalgas
          DO SETUPSCREEN
          DO TOTALS
          SAV_RECORD=ALG:RECORD
          DISPLAY
          SELECT(?OK)
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  IF CAL::Used = 0
    CheckOpen(CAL,1)
  END
  CAL::Used += 1
  BIND(CAL:RECORD)
  IF DAIEV::Used = 0
    CheckOpen(DAIEV,1)
  END
  DAIEV::Used += 1
  BIND(DAI:RECORD)
  FilesOpened = True
  RISnap:ALGAS
  SAV::ALG:Record = ALG:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
  END
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('UpdateAlgas','winlats.INI')
  WinResize.Resize
  ?ALG:IIN{PROP:Alrt,255} = 734
  ?ALG:IIN_DATUMS{PROP:Alrt,255} = 734
  ?ALG:INV_P{PROP:Alrt,255} = 734
  ?ALG:NODALA{PROP:Alrt,255} = 734
  ?ALG:OBJ_NR{PROP:Alrt,255} = 734
  ?ALG_STATUSS{PROP:Alrt,255} = 734
  ?ALG:APGAD_SK{PROP:Alrt,255} = 734
  ?ALG:DZIVAP{PROP:Alrt,255} = 734
  ?ALG:IZDEV{PROP:Alrt,255} = 734
  ?ALG:PPF{PROP:Alrt,255} = 734
  ?ALG:IIN_DATUMS:2{PROP:Alrt,255} = 734
  ?ALG:PR37{PROP:Alrt,255} = 734
  ?ALG:SOC_V{PROP:Alrt,255} = 734
  ?ALG:N_Stundas{PROP:Alrt,255} = 734
  ?ALG:LINV{PROP:Alrt,255} = 734
  ?ALG:LBER{PROP:Alrt,255} = 734
  ?ALG:LMIA{PROP:Alrt,255} = 734
  ?ALG:PR1{PROP:Alrt,255} = 734
  ?ALG:TERKOD{PROP:Alrt,255} = 734
  ?ALG:IZMAKSAT{PROP:Alrt,255} = 734
  ?ALG:PARSKAITIT{PROP:Alrt,255} = 734
  ?ALG:ACC_DATUMS{PROP:Alrt,255} = 734
  ?ALG:ACC_KODS{PROP:Alrt,255} = 734
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
    FREE(LIST1:QUEUE)
    
    
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
    CAL::Used -= 1
    IF CAL::Used = 0 THEN CLOSE(CAL).
    DAIEV::Used -= 1
    IF DAIEV::Used = 0 THEN CLOSE(DAIEV).
  END
  IF WindowOpened
    INISaveWindow('UpdateAlgas','winlats.INI')
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
!---------------------------------------------------------------------------------
SETUPSCREEN  ROUTINE
  LOOP I#=1 TO 20                              !LAUKI: KODS,L,STUNDAS,DIENAS,NOS,ARG,REZ
     FIELD#=11+(I#-1)*8  !LAUKS "KODS"         !            +1 +2     +3     +4  +5  +6
     IF ALG:K[I#]                              
!        DAIEV_N[I#]=GETDAIEV(ALG:K[I#],2,1)
        DAIEV_N[I#]=CLIP(GETDAIEV(ALG:K[I#],2,1))&' '&GETDAIEV(ALG:K[I#],2,8)
!        STOP(DAI:F&FIELD#)
        ENABLE(FIELD#+1,FIELD#+6)
        CASE DAI:F
        OF 'CAL'
        OROF 'NOS'
           DISABLE(FIELD#+5)
           DISABLE(FIELD#+6)
        OF 'NAV'
!           DISABLE(FIELD#+2)
           DISABLE(FIELD#+5)
        OF 'ARG'
           DISABLE(FIELD#+2)
           DISABLE(FIELD#+6)
        OF 'CIP'
        OROF 'REZ'
           DISABLE(FIELD#+2)
           DISABLE(FIELD#+5)
        ELSE
           DISABLE(FIELD#+2)
           DISABLE(FIELD#+5)
        .
     ELSE
        DAIEV_N[I#]=''
        DISABLE(FIELD#+1,FIELD#+6)
     .
  .
  LOOP I#=1 TO 15
     DAIEV_N[I#+20]=GETDAIEV(ALG:I[I#],2,1)
  END
  DISPLAY
!---------------------------------------------------------------------------------
TOTALS       ROUTINE
  PIESK1 =SUM(33)
  IETUR  =SUM(28)-SUM(56)
  ALG:PARSKAITIT= SUM(56)
  ALG:IZMAKSAT =PIESK1-IETUR-ALG:PARSKAITIT
  MIA    = CALCNEA(1,1,0)
  BER    = CALCNEA(2,1,0)
  INV    = CALCNEA(3,1,0)
!?  IF INSTRING(ALG:STATUSS,'13')               !AR D-GRÂMATIÒU
  BLA    = CALCSTUNDAS(ALG:YYYYMM,ALG:ID,0,2,7) !B-LAPA
  ZINA1  = 'Nostrâdâtâs stundas(Pap.dati) '&ALG:N_STUNDAS
  IF SUM(1)/ALG:N_STUNDAS < 0.962 AND YEAR(ALG:YYYYMM) >= 2009
     ZINA2  = 'Jâbût ne vairâk kâ '&INT(SUM(1)/0.962)
  ELSE
     ZINA2  = ''
  .
  DISPLAY
!|
!| Copies a field from save buffer to actual buffer switched on current field
!|
HistoryField  ROUTINE
  CASE FOCUS()
    OF ?ALG:IIN
      ALG:IIN = History::ALG:Record.IIN
    OF ?ALG:IIN_DATUMS
      ALG:IIN_DATUMS = History::ALG:Record.IIN_DATUMS
    OF ?ALG:INV_P
      ALG:INV_P = History::ALG:Record.INV_P
    OF ?ALG:NODALA
      ALG:NODALA = History::ALG:Record.NODALA
    OF ?ALG:OBJ_NR
      ALG:OBJ_NR = History::ALG:Record.OBJ_NR
    OF ?ALG_STATUSS
      ALG_STATUSS = History::ALG:Record.STATUSS
    OF ?ALG:APGAD_SK
      ALG:APGAD_SK = History::ALG:Record.APGAD_SK
    OF ?ALG:DZIVAP
      ALG:DZIVAP = History::ALG:Record.DZIVAP
    OF ?ALG:IZDEV
      ALG:IZDEV = History::ALG:Record.IZDEV
    OF ?ALG:PPF
      ALG:PPF = History::ALG:Record.PPF
    OF ?ALG:IIN_DATUMS:2
      ALG:IIN_DATUMS = History::ALG:Record.IIN_DATUMS
    OF ?ALG:PR37
      ALG:PR37 = History::ALG:Record.PR37
    OF ?ALG:SOC_V
      ALG:SOC_V = History::ALG:Record.SOC_V
    OF ?ALG:N_Stundas
      ALG:N_Stundas = History::ALG:Record.N_Stundas
    OF ?ALG:LINV
      ALG:LINV = History::ALG:Record.LINV
    OF ?ALG:LBER
      ALG:LBER = History::ALG:Record.LBER
    OF ?ALG:LMIA
      ALG:LMIA = History::ALG:Record.LMIA
    OF ?ALG:PR1
      ALG:PR1 = History::ALG:Record.PR1
    OF ?ALG:TERKOD
      ALG:TERKOD = History::ALG:Record.TERKOD
    OF ?ALG:IZMAKSAT
      ALG:IZMAKSAT = History::ALG:Record.IZMAKSAT
    OF ?ALG:PARSKAITIT
      ALG:PARSKAITIT = History::ALG:Record.PARSKAITIT
    OF ?ALG:ACC_DATUMS
      ALG:ACC_DATUMS = History::ALG:Record.ACC_DATUMS
    OF ?ALG:ACC_KODS
      ALG:ACC_KODS = History::ALG:Record.ACC_KODS
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
  ALG:Record = SAV::ALG:Record
  SAV::ALG:Record = ALG:Record
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

BrowseALGAS PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG
UINI                 STRING(25)
MENESISS             STRING(15)
AprIIN               DECIMAL(6,2)
IIN_DATUMS           LONG
iet_window WINDOW('Caption'),AT(,,216,62),GRAY
       STRING('Fiksçjam IIN ieturçðanu ðim sarakstam'),AT(5,21),USE(?String1)
       ENTRY(@D06.),AT(155,19,51,12),USE(iin_datums)
       BUTTON('&OK'),AT(134,43,35,14),USE(?OkButton),DEFAULT
       BUTTON('&Atlikt'),AT(171,43,36,14),USE(?CancelButton)
     END

ALP_APRIIN LIKE(ALP:APRIIN)
ALP_IETIIN LIKE(ALP:IETIIN)
ALP_IZMAKSAT LIKE(ALP:IZMAKSAT)

BRW1::View:Browse    VIEW(ALGAS)
                       PROJECT(ALG:ID)
                       PROJECT(ALG:NODALA)
                       PROJECT(ALG:OBJ_NR)
                       PROJECT(ALG:STATUSS)
                       PROJECT(ALG:INV_P)
                       PROJECT(ALG:APGAD_SK)
                       PROJECT(ALG:PR37)
                       PROJECT(ALG:PR1)
                       PROJECT(ALG:IIN)
                       PROJECT(ALG:PARSKAITIT)
                       PROJECT(ALG:IZMAKSAT)
                       PROJECT(ALG:ACC_KODS)
                       PROJECT(ALG:ACC_DATUMS)
                       PROJECT(ALG:YYYYMM)
                       PROJECT(ALG:INI)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::ALG:ID           LIKE(ALG:ID)               ! Queue Display field
BRW1::UINI             LIKE(UINI)                 ! Queue Display field
BRW1::ALG:NODALA       LIKE(ALG:NODALA)           ! Queue Display field
BRW1::ALG:OBJ_NR       LIKE(ALG:OBJ_NR)           ! Queue Display field
BRW1::ALG:STATUSS      LIKE(ALG:STATUSS)          ! Queue Display field
BRW1::ALG:INV_P        LIKE(ALG:INV_P)            ! Queue Display field
BRW1::ALG:APGAD_SK     LIKE(ALG:APGAD_SK)         ! Queue Display field
BRW1::ALG:PR37         LIKE(ALG:PR37)             ! Queue Display field
BRW1::ALG:PR1          LIKE(ALG:PR1)              ! Queue Display field
BRW1::AprIIN           LIKE(AprIIN)               ! Queue Display field
BRW1::ALG:IIN          LIKE(ALG:IIN)              ! Queue Display field
BRW1::ALG:PARSKAITIT   LIKE(ALG:PARSKAITIT)       ! Queue Display field
BRW1::ALG:IZMAKSAT     LIKE(ALG:IZMAKSAT)         ! Queue Display field
BRW1::ALG:ACC_KODS     LIKE(ALG:ACC_KODS)         ! Queue Display field
BRW1::ALG:ACC_DATUMS   LIKE(ALG:ACC_DATUMS)       ! Queue Display field
BRW1::ALG:YYYYMM       LIKE(ALG:YYYYMM)           ! Queue Display field
BRW1::ALG:INI          LIKE(ALG:INI)              ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort1:KeyDistribution LIKE(ALG:ID),DIM(100)
BRW1::Sort1:LowValue LIKE(ALG:ID)                 ! Queue position of scroll thumb
BRW1::Sort1:HighValue LIKE(ALG:ID)                ! Queue position of scroll thumb
BRW1::Sort1:Reset:ALP:YYYYMM LIKE(ALP:YYYYMM)
BRW1::Sort2:LocatorValue STRING(30)               ! Flag for Range/Filter test
BRW1::Sort2:LocatorLength BYTE                    ! Flag for Range/Filter test
BRW1::Sort2:KeyDistribution LIKE(ALG:INI),DIM(100)
BRW1::Sort2:LowValue LIKE(ALG:INI)                ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(ALG:INI)               ! Queue position of scroll thumb
BRW1::Sort2:Reset:ALP:YYYYMM LIKE(ALP:YYYYMM)
BRW1::QuickScan      BYTE                         ! Flag for Range/Filter test
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
QuickWindow          WINDOW('Algu saraksts'),AT(0,0,458,307),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('BrowseALGAS'),SYSTEM,GRAY,RESIZE,MDI
                       STRING(@s15),AT(173,4),USE(MENESISS),LEFT,FONT(,10,,FONT:bold)
                       LIST,AT(7,23,440,235),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('21R(2)|M~ID~C(0)@n4@106L(2)|M~ Vârds , Uzvârds~C(0)@s30@10C|M~N~@S2@25R|M~P~C@n_' &|
   '6b@15C|M~ST~@S1@11R(1)|M~IP~C(0)@n1@14R(1)|M~AP~C(0)@n2@23D(12)|M~DDS%~C(0)@n5.2' &|
   '@23D(12)|M~DNS%~C(0)@n5.2@34R(1)|M~Apr.IIN~C(0)@N-_8.2@36R(1)|M~Iet.IIN~C(0)@N-_' &|
   '8.2@40R(1)|M~Pârskaitîj.~C(0)@n_9.2@40R(1)|M~Izmaksât~C(0)@n-_9.2@35C|M~Laboja~@' &|
   's8@40R(1)|M~Datums~@D06.@'),FROM(Queue:Browse:1)
                       SHEET,AT(4,4,448,279),USE(?CurrentTab),FONT('MS Sans Serif',9,,FONT:bold)
                         TAB('Uzvârdu secîbâ'),USE(?Tab:1)
                           ENTRY(@s5),AT(38,266,31,12),USE(ALG:INI)
                           PROMPT('- âtrâ meklçðana pçc Uzvârda'),AT(70,267,107,10),USE(?Prompt1)
                           STRING('Aprçíinâtais IIN :'),AT(196,262),USE(?String7)
                           STRING(@n-9.2),AT(254,262),USE(ALP:APRIIN),RIGHT(1)
                           STRING('Pârskaitîjums uz karti :'),AT(296,262),USE(?StringPARSK),RIGHT
                           STRING(@n-9.2),AT(254,272),USE(ALP:IETIIN),RIGHT(1)
                           STRING('Izmaksât :'),AT(336,272),USE(?String7:4)
                           STRING(@n-10.2),AT(372,262),USE(ALP:PARSKAITIT),RIGHT(1)
                           STRING(@n-10.2),AT(372,272),USE(ALP:IZMAKSAT,,?ALP:IZMAKSAT:2),RIGHT(1)
                           STRING('Samaksâtais IIN :'),AT(195,272),USE(?String7:2)
                         END
                         TAB('ID secîbâ'),USE(?Tab:2)
                           ENTRY(@n-7.0),AT(16,267,21,10),USE(ALG:ID)
                           STRING('pçc ID'),AT(45,268),USE(?String2)
                         END
                       END
                       BUTTON('Ieturçtais(Pârskaitîtais) IIN= Aprçíinâtais IIN'),AT(42,286,154,14),USE(?ButtonIIN)
                       BUTTON('&Mainît'),AT(299,286,45,14),USE(?Change:2),DEFAULT
                       BUTTON('&Dzçst'),AT(347,286,45,14),USE(?Delete:2)
                       BUTTON('&Beigt'),AT(396,286,45,14),USE(?Close)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  MENESISS = MENVAR(ALP:YYYYMM,2,1)&' '&YEAR(ALP:YYYYMM)
  ALP_APRIIN=ALP:APRIIN
  ALP_IETIIN=ALP:IETIIN
  
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
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
      SELECT(?MENESISS)
      IF ALP:STAT=3
         ?StringPARSK{PROP:TEXT}='             Dividendes :'
      .
      IF ALP:YYYYMM < SYS:GIL_SHOW  ! SLÇGTS APGABALS
         quickwindow{prop:color}=color:activeborder
         disable(?ButtonIIN)
         disable(?Delete:2)
         HIDE(?Delete:2)
         ?Change:2{PROP:TEXT}='Apskatît'
      !   SELECT(?Change:2)
      .
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
      IF ToolBarMode=BrowseMode THEN
        DO UpdateDispatch
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
    OF ?ALG:INI
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?ALG:INI)
        IF ALG:INI
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          BRW1::Sort2:LocatorValue = ALG:INI
          BRW1::Sort2:LocatorLength = LEN(CLIP(ALG:INI))
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?ALG:ID
      CASE EVENT()
      OF EVENT:Accepted
        UPDATE(?ALG:ID)
        IF ALG:ID
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
          SELECT(?Browse:1)
          DO BRW1::PostNewSelection
        END
      END
    OF ?ButtonIIN
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          OPEN(Iet_WINDOW)
          IF ~SYS:NOKL_DC THEN SYS:NOKL_DC=1. !ALGAS IZMAKSAS DATUMS
          IIN_DATUMS=DATE(MONTH(ALP:YYYYMM)+1,SYS:NOKL_dc,YEAR(ALP:YYYYMM))
        ! STOP(SYS:NOKL_DC&' '&MONTH(ALP:YYYYMM)+1&' '&YEAR(ALP:YYYYMM)&' '&FORMAT(IIN_DATUMS,@D06.))
          display
          ACCEPT
             CASE FIELD()
             OF ?OKBUTTON
                IF EVENT()=EVENT:ACCEPTED
                   LocalResponse = RequestCompleted
                   BREAK
                .
             OF ?CANCELBUTTON
                IF EVENT()=EVENT:ACCEPTED
                   LocalResponse = RequestCancelled
                   BREAK
                .
             .
          .
          CLOSE(Iet_WINDOW)
          IF LocalResponse = RequestCompleted
             CLEAR(ALG:RECORD)
             ALG:YYYYMM=ALP:YYYYMM
             SET(ALG:ID_KEY,ALG:ID_KEY)
             LOOP
                NEXT(ALGAS)
                IF ERROR() OR ~(ALG:YYYYMM=ALP:YYYYMM) THEN BREAK.
        !        IF ~ALG:IIN_LOCK
                IF ~BAND(ALG:IIN_LOCK,00000001b) !NAV LOCK
                   ALG:IIN=SUM(5)
                   ALG:IIN_DATUMS=IIN_DATUMS
                   IF RIUPDATE:ALGAS()
                      KLUDA(24,'ALGAS')
                   .
                .
             .
             BRW1::RefreshMode = RefreshOnQueue
             DO BRW1::RefreshPage
             DO BRW1::InitializeBrowse
             DO BRW1::PostNewSelection
             SELECT(?Browse:1)
             LocalRequest = OriginalRequest
             LocalResponse = RequestCancelled
             DO RefreshWindow
          .
        
        
      END
    OF ?Change:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
      END
    OF ?Delete:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonDelete
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
  IF ALGAS::Used = 0
    CheckOpen(ALGAS,1)
  END
  ALGAS::Used += 1
  BIND(ALG:RECORD)
  IF ALGPA::Used = 0
    CheckOpen(ALGPA,1)
  END
  ALGPA::Used += 1
  BIND(ALP:RECORD)
  IF KADRI::Used = 0
    CheckOpen(KADRI,1)
  END
  KADRI::Used += 1
  BIND(KAD:RECORD)
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  WinResize.Initialize(AppStrat:Resize)
  INIRestoreWindow('BrowseALGAS','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,250} = BSKey
  ?Browse:1{Prop:Alrt,250} = SpaceKey
  ?Browse:1{Prop:Alrt,254} = DeleteKey
  ?Browse:1{Prop:Alrt,253} = CtrlEnter
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
    ALGAS::Used -= 1
    IF ALGAS::Used = 0 THEN CLOSE(ALGAS).
    ALGPA::Used -= 1
    IF ALGPA::Used = 0 THEN CLOSE(ALGPA).
    KADRI::Used -= 1
    IF KADRI::Used = 0 THEN CLOSE(KADRI).
  END
  IF WindowOpened
    INISaveWindow('BrowseALGAS','winlats.INI')
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
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LocatorValue = ALG:ID
    CLEAR(ALG:ID)
  OF 2
    ALG:INI = BRW1::Sort2:LocatorValue
  END
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
  IF CHOICE(?CurrentTab) = 2
    BRW1::SortOrder = 1
  ELSE
    BRW1::SortOrder = 2
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    OF 1
      IF BRW1::Sort1:Reset:ALP:YYYYMM <> ALP:YYYYMM
        BRW1::Changed = True
      END
    OF 2
      IF BRW1::Sort2:Reset:ALP:YYYYMM <> ALP:YYYYMM
        BRW1::Changed = True
      END
    END
  ELSE
    CASE BRW1::SortOrder
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      ALG:INI = BRW1::Sort2:LocatorValue
    END
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:ALP:YYYYMM = ALP:YYYYMM
    OF 2
      BRW1::Sort2:Reset:ALP:YYYYMM = ALP:YYYYMM
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
  IF SEND(ALGAS,'QUICKSCAN=on').
  SETCURSOR(Cursor:Wait)
  DO BRW1::Reset
  ALP:APRIIN=0
  ALP:IETIIN=0
  IF ALP:STAT<3 THEN ALP:parskaitit=0.
  ALP:Izmaksat=0
  LOOP
    NEXT(BRW1::View:Browse)
    IF ERRORCODE()
      IF ERRORCODE() = BadRecErr
        DO BRW1::RestoreResetValues
        BREAK
      ELSE
        StandardWarning(Warn:RecordFetchError,'ALGAS')
        POST(Event:CloseWindow)
        EXIT
      END
    END
    DO BRW1::FillQueue
    ALP:APRIIN+=APRIIN
    ALP:IETIIN+=ALG:IIN
    IF ALP:STAT<3 THEN ALP:parskaitit+=alg:parskaitit.
    ALP:Izmaksat+=alg:izmaksat
  END
  SETCURSOR()
  DO BRW1::Reset
  PREVIOUS(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'ALGAS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:HighValue = ALG:ID
  OF 2
    BRW1::Sort2:HighValue = ALG:INI
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'ALGAS')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 1
    BRW1::Sort1:LowValue = ALG:ID
    SetupRealStops(BRW1::Sort1:LowValue,BRW1::Sort1:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort1:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  OF 2
    BRW1::Sort2:LowValue = ALG:INI
    SetupStringStops(BRW1::Sort2:LowValue,BRW1::Sort2:HighValue,SIZE(BRW1::Sort2:LowValue),ScrollSort:AllowAlpha)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort2:KeyDistribution[BRW1::ScrollRecordCount] = NextStringStop()
    END
  END
  IF SEND(ALGAS,'QUICKSCAN=off').
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  ALG:ID = BRW1::ALG:ID
  UINI = BRW1::UINI
  ALG:NODALA = BRW1::ALG:NODALA
  ALG:OBJ_NR = BRW1::ALG:OBJ_NR
  ALG:STATUSS = BRW1::ALG:STATUSS
  ALG:INV_P = BRW1::ALG:INV_P
  ALG:APGAD_SK = BRW1::ALG:APGAD_SK
  ALG:PR37 = BRW1::ALG:PR37
  ALG:PR1 = BRW1::ALG:PR1
  AprIIN = BRW1::AprIIN
  ALG:IIN = BRW1::ALG:IIN
  ALG:PARSKAITIT = BRW1::ALG:PARSKAITIT
  ALG:IZMAKSAT = BRW1::ALG:IZMAKSAT
  ALG:ACC_KODS = BRW1::ALG:ACC_KODS
  ALG:ACC_DATUMS = BRW1::ALG:ACC_DATUMS
  ALG:YYYYMM = BRW1::ALG:YYYYMM
  ALG:INI = BRW1::ALG:INI
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
  UINI=GETKADRI(ALG:ID,0,3)
  AprIIN=SUM(5)
  BRW1::ALG:ID = ALG:ID
  BRW1::UINI = UINI
  BRW1::ALG:NODALA = ALG:NODALA
  BRW1::ALG:OBJ_NR = ALG:OBJ_NR
  BRW1::ALG:STATUSS = ALG:STATUSS
  BRW1::ALG:INV_P = ALG:INV_P
  BRW1::ALG:APGAD_SK = ALG:APGAD_SK
  BRW1::ALG:PR37 = ALG:PR37
  BRW1::ALG:PR1 = ALG:PR1
  BRW1::AprIIN = AprIIN
  BRW1::ALG:IIN = ALG:IIN
  BRW1::ALG:PARSKAITIT = ALG:PARSKAITIT
  BRW1::ALG:IZMAKSAT = ALG:IZMAKSAT
  BRW1::ALG:ACC_KODS = ALG:ACC_KODS
  BRW1::ALG:ACC_DATUMS = ALG:ACC_DATUMS
  BRW1::ALG:YYYYMM = ALG:YYYYMM
  BRW1::ALG:INI = ALG:INI
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
      IF BRW1::PopupText
        BRW1::PopupText = '&Mainît|&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Mainît|&Dzçst'
      END
    ELSE
      IF BRW1::PopupText
        BRW1::PopupText = '~&Mainît|~&Dzçst|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '~&Mainît|~&Dzçst'
      END
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Change:2)
      POST(Event:Accepted,?Delete:2)
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
          IF BRW1::Sort1:KeyDistribution[BRW1::CurrentScroll] => ALG:ID
            IF BRW1::CurrentScroll <= 1
              BRW1::CurrentScroll = 0
            ELSIF BRW1::CurrentScroll = 100
              BRW1::CurrentScroll = 100
            ELSE
            END
            BREAK
          END
        END
      OF 2
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => UPPER(ALG:INI)
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
    CASE BRW1::SortOrder
    OF 2
      BRW1::Sort2:LocatorValue = ''
      BRW1::Sort2:LocatorLength = 0
      ALG:INI = BRW1::Sort2:LocatorValue
    END
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
      POST(Event:Accepted,?Change:2)
      DO BRW1::FillBuffer
    OF DeleteKey
      POST(Event:Accepted,?Delete:2)
    OF CtrlEnter
      POST(Event:Accepted,?Change:2)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          SELECT(?ALG:ID)
          PRESS(CHR(KEYCHAR()))
        END
      OF 2
        IF KEYCODE() = BSKey
          IF BRW1::Sort2:LocatorLength
            BRW1::Sort2:LocatorLength -= 1
            BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength)
            ALG:INI = BRW1::Sort2:LocatorValue
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        ELSIF KEYCODE() = SpaceKey
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & ' '
          BRW1::Sort2:LocatorLength += 1
          ALG:INI = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        ELSIF CHR(KEYCHAR())
          BRW1::Sort2:LocatorValue = SUB(BRW1::Sort2:LocatorValue,1,BRW1::Sort2:LocatorLength) & CHR(KEYCHAR())
          BRW1::Sort2:LocatorLength += 1
          ALG:INI = BRW1::Sort2:LocatorValue
          BRW1::LocateMode = LocateOnValue
          DO BRW1::LocateRecord
        END
      END
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
      ALG:ID = BRW1::Sort1:KeyDistribution[?Browse:1{Prop:VScrollPos}]
      BRW1::LocateMode = LocateOnValue
      DO BRW1::LocateRecord
    OF 2
      ALG:INI = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
  IF BRW1::ItemsToFill > 1
    IF SEND(ALGAS,'QUICKSCAN=on').
    BRW1::QuickScan = True
  END
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
        StandardWarning(Warn:RecordFetchError,'ALGAS')
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
  IF BRW1::QuickScan
    IF SEND(ALGAS,'QUICKSCAN=off').
    BRW1::QuickScan = False
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
      BRW1::HighlightedPosition = POSITION(ALG:ID_KEY)
      RESET(ALG:ID_KEY,BRW1::HighlightedPosition)
    ELSE
      ALG:YYYYMM = ALP:YYYYMM
      SET(ALG:ID_KEY,ALG:ID_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'ALG:YYYYMM = ALP:YYYYMM'
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(ALG:INI_KEY)
      RESET(ALG:INI_KEY,BRW1::HighlightedPosition)
    ELSE
      ALG:YYYYMM = ALP:YYYYMM
      SET(ALG:INI_KEY,ALG:INI_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'ALG:YYYYMM = ALP:YYYYMM'
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
    CASE BRW1::SortOrder
    OF 1; ?ALG:ID{Prop:Disable} = 0
    OF 2; ?ALG:INI{Prop:Disable} = 0
    END
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
    ?Change:2{Prop:Disable} = 0
    ?Delete:2{Prop:Disable} = 0
  ELSE
    CLEAR(ALG:Record)
    CASE BRW1::SortOrder
    OF 1; ?ALG:ID{Prop:Disable} = 1
    OF 2; ?ALG:INI{Prop:Disable} = 1
    END
    BRW1::CurrentChoice = 0
    ?Change:2{Prop:Disable} = 1
    ?Delete:2{Prop:Disable} = 1
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
    ALG:YYYYMM = ALP:YYYYMM
    SET(ALG:ID_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'ALG:YYYYMM = ALP:YYYYMM'
  OF 2
    ALG:YYYYMM = ALP:YYYYMM
    SET(ALG:INI_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'ALG:YYYYMM = ALP:YYYYMM'
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
    ALP:YYYYMM = BRW1::Sort1:Reset:ALP:YYYYMM
  OF 2
    ALP:YYYYMM = BRW1::Sort2:Reset:ALP:YYYYMM
  END
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  BrowseButtons.InsertButton=0
  BrowseButtons.ChangeButton=?Change:2
  BrowseButtons.DeleteButton=?Delete:2
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
  IF INRANGE(ACCEPTED(),TBarBrwInsert,TBarBrwDelete) THEN         !trap remote browse update control calls
    EXECUTE(ACCEPTED()-TBarBrwInsert+1)
      POST(EVENT:ACCEPTED,BrowseButtons.InsertButton)
      POST(EVENT:ACCEPTED,BrowseButtons.ChangeButton)
      POST(EVENT:ACCEPTED,BrowseButtons.DeleteButton)
    END
  END
!----------------------------------------------------------------
BRW1::ButtonChange ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to change a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to ChangeRecord, and the BRW1::CallRecord routine
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
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    WriteZurnals(1,2,'ALGAS'&CHR(9)&CLIP(ALG:IZMAKSAT)&CHR(9)&CLIP(ALG:ID)&CHR(9)&FORMAT(ALG:YYYYMM,@D13))
  .
  IF GlobalResponse = RequestCompleted
    BRW1::LocateMode = LocateOnEdit
    DO BRW1::LocateRecord
  ELSE
    BRW1::RefreshMode = RefreshOnQueue
    DO BRW1::RefreshPage
  END
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::ButtonDelete ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to delete a selected record.
!|
!| Whenever a button is pressed, the first thing that happens is that the
!| SyncWindow routine is called. This routine insures that the BrowseBox's
!| VIEW corresponds to the highlighted record by calling the BRW1::GetRecord routine.
!|
!| First, LocalRequest is set to DeleteRecord, and the BRW1::CallRecord routine
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
  DO BRW1::CallUpdate
  IF GlobalResponse = RequestCompleted
    WriteZurnals(1,3,'ALGAS'&CHR(9)&CLIP(ALG:IZMAKSAT)&CHR(9)&CLIP(ALG:ID)&CHR(9)&FORMAT(ALG:YYYYMM,@D13))
  .
  IF GlobalResponse = RequestCompleted
    DELETE(Queue:Browse:1)
    BRW1::RecordCount -= 1
  END
  BRW1::RefreshMode = RefreshOnQueue
  DO BRW1::RefreshPage
  DO BRW1::InitializeBrowse
  DO BRW1::PostNewSelection
  SELECT(?Browse:1)
  LocalRequest = OriginalRequest
  LocalResponse = RequestCancelled
  DO RefreshWindow
!----------------------------------------------------------------
BRW1::CallUpdate ROUTINE
!|
!| This routine performs the actual call to the update procedure.
!|
!| The first thing that happens is that the VIEW is closed. This is performed just in case
!| the VIEW is still open.
!|
!| Next, GlobalRequest is set the the value of LocalRequest, and the update procedure
!| (UpdateAlgas) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  IF ALP:YYYYMM < SYS:GIL_SHOW and (LOCALREQUEST=3 OR LOCALREQUEST=2) ! SLÇGTS APGABALS
     LOCALREQUEST=0
  .
  EXECUTE CHECKACCESS(LOCALREQUEST,ATLAUTS[JOB_NR+39]) !39+65=104-SÂKAS ALGA_ACC
     BEGIN
        GlobalResponse = RequestCancelled
        EXIT
     .
     LOCALREQUEST=0
     LOCALREQUEST=LOCALREQUEST
  .
  GlobalRequest = LocalRequest
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdateAlgas
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
        GET(ALGAS,0)
        CLEAR(ALG:Record,0)
      ELSE
        DO BRW1::PostVCREdit1
        BRW1::CurrentEvent=Event:ScrollDown
        DO BRW1::ScrollOne
        DO BRW1::PostVCREdit2
      END
    OF VCRBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollUp
      DO BRW1::ScrollOne
      DO BRW1::PostVCREdit2
    OF VCRPageForward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageDown
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRPageBackward
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:PageUp
      DO BRW1::ScrollPage
      DO BRW1::PostVCREdit2
    OF VCRFirst
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollTop
      DO BRW1::ScrollEnd
      DO BRW1::PostVCREdit2
    OF VCRLast
      DO BRW1::PostVCREdit1
      BRW1::CurrentEvent=Event:ScrollBottom
      DO BRW1::ScrollEND
      DO BRW1::PostVCREdit2
    END
  END
  DO BRW1::Reset
  IF GlobalResponse = RequestCompleted
      IF LocalRequest=DeleteRecord
        DO BRW1::RefreshPage
      .
  .

BRW1::PostVCREdit1 ROUTINE
  DO BRW1::Reset
  BRW1::LocateMode=LocateOnEdit
  DO BRW1::LocateRecord
  DO RefreshWindow

BRW1::PostVCREdit2 ROUTINE
  ?Browse:1{PROP:SelStart}=BRW1::CurrentChoice
  DO BRW1::NewSelection
  REGET(BRW1::View:Browse,BRW1::Position)
  CLOSE(BRW1::View:Browse)


