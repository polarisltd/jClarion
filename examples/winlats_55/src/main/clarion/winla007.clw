                     MEMBER('winlats.clw')        ! This is a MEMBER module
Parmani PROCEDURE


LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
soundfile    CSTRING(80)
window               WINDOW,AT(,,204,94),FONT('MS Sans Serif',8,,FONT:regular),CENTER,GRAY,NOFRAME
                       PANEL,AT(0,0,204,95),BEVEL(6)
                       PANEL,AT(7,6,191,83),BEVEL(-2,1)
                       STRING('Izstrâdâtâjs: Informâcijas servisa firma "ASSAKO"'),AT(13,12,182,10),USE(?String2),CENTER
                       STRING('Kokneses pr. 25, Rîga, LV-1014, 67518058,29234246'),AT(13,22,182,10),USE(?String2:2),CENTER
                       IMAGE('TOPSPEED.WMF'),AT(15,61,178,26),USE(?Image1)
                       PANEL,AT(17,33,177,12),BEVEL(-1,1,09H)
                       STRING(@s1),AT(9,8),USE(F:CEN),FONT(,,COLOR:Gray,,CHARSET:ANSI)
                       STRING('Platforma: Clarion for Windows 5 Licence 366787-SSJ'),AT(13,48,182,10),USE(?String1),CENTER
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
       SoundFile='\WINLATS\BIN\Jungle Open.wav'
       sndPlaySoundA(SoundFile,1)
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  ACCEPT
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF MouseLeft
      OROF MouseLeft2
      OROF MouseRight
        POST(Event:CloseWindow)
      END
    OF EVENT:OpenWindow
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?String2)
    OF EVENT:GainFocus
      ForceRefresh = True
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      ELSE
        DO RefreshWindow
      END
    OF Event:Rejected
      BEEP
      DISPLAY(?)
      SELECT(?)
    ELSE
      IF EVENT() = Event:Timer
        POST(Event:CloseWindow)
      END
      IF EVENT() = Event:AlertKey
        CASE KEYCODE()
        OF MouseLeft
        OROF MouseLeft2
        OROF MouseRight
          POST(Event:CloseWindow)
        END
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
  FilesOpened = True
  OPEN(window)
  WindowOpened=True
  INIRestoreWindow('Parmani','winlats.INI')
  TARGET{Prop:Timer} = 500
  TARGET{Prop:Alrt,255} = MouseLeft
  TARGET{Prop:Alrt,254} = MouseLeft2
  TARGET{Prop:Alrt,253} = MouseRight
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
  END
  IF WindowOpened
    INISaveWindow('Parmani','winlats.INI')
    CLOSE(window)
  END
   F:CEN=''
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
  IF window{Prop:AcceptAll} THEN EXIT.
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
kalkis               PROCEDURE                    ! Declare Procedure
Number     string(@s16)         !!!Needs to be a string for proper '0' display
Operand    REAL                 !The first operand for +,-,*,/,^ operations
Memory     REAL                 !The value contained in memory
Operation  REAL                 !The field number of the operation key
NewNumber  BYTE                 !True following = or %
Decimal    BYTE                 !True after pressing decimal point key
Digit      BYTE                 !Numeric digit represented by number key
DecimalFlg BYTE                 !!!decimal flag
Calculator WINDOW('Kalkulâtors'),AT(,,116,192),FONT('Arial',8,,),CENTER,ICON('G_CALC.ICO'),SYSTEM,GRAY, |
         DOUBLE,AUTO
       BUTTON('&0'),AT(67,125,16,14),FONT('Arial',8,,),KEY(KeyPad0),USE(?Zero)
       BUTTON('&1'),AT(31,109,16,14),FONT('Arial',8,,),KEY(KeyPad1),USE(?One)
       BUTTON('&2'),AT(49,109,16,14),FONT('Arial',8,,),KEY(KeyPad2),USE(?Two)
       BUTTON('&3'),AT(67,109,16,14),FONT('Arial',8,,),KEY(KeyPad3),USE(?Three)
       BUTTON('&4'),AT(31,93,16,14),FONT('Arial',8,,),KEY(KeyPad4),USE(?Four)
       BUTTON('&5'),AT(49,93,16,14),FONT('Arial',8,,),KEY(KeyPad5),USE(?Five)
       BUTTON('&6'),AT(67,93,16,14),FONT('Arial',8,,),KEY(KeyPad6),USE(?Six)
       BUTTON('&7'),AT(31,77,16,14),FONT('Arial',8,,),KEY(KeyPad7),USE(?Seven)
       BUTTON('&8'),AT(49,77,16,14),FONT('Arial',8,,),KEY(KeyPad8),USE(?Eight)
       BUTTON('&9'),AT(67,77,16,14),FONT('Arial',8,,),KEY(KeyPad9),USE(?Nine)
       BUTTON('.'),AT(49,125,16,14),FONT('Arial',8,,),KEY(DecimalKey),USE(?Decimal)
       BUTTON('CE'),AT(9,125,16,14),FONT('Arial',8,,),TIP('Clear'),USE(?Clear)
       BUTTON('p'),AT(49,56,16,14),FONT('Symbol',10,,),TIP('Pi'),USE(?Pi)
       BUTTON('+/-'),AT(31,125,16,14),FONT('Arial',8,,),TIP('Change Sign'),USE(?Sign)
       BUTTON(' x<178>'),AT(67,41,16,14),FONT('Arial',8,,),TIP('Value Squared'),USE(?Square)
       BUTTON('Ö'),AT(67,56,16,14),FONT('Symbol',8,,),TIP('Square Root'),USE(?Root)
       BUTTON('1/x'),AT(13,56,16,14),FONT('Arial',8,,),TIP('Reciprocal'),USE(?Reciprical)
       BUTTON('10X'),AT(31,56,16,14),FONT('Arial',8,,),TIP('Multiply by 10'),USE(?TenTimes)
       BUTTON('%'),AT(90,41,18,16),FONT('Arial',8,,),TIP('Percent'),USE(?Percent)
       BUTTON(' lg'),AT(31,41,16,14),FONT('Arial',8,,),TIP('Base 10 Logarithm'),USE(?Log)
       BUTTON(' ln'),AT(13,41,16,14),FONT('Arial',8,,),TIP('Natural Logarithm'),USE(?Ln)
       BUTTON('MR'),AT(9,77,16,14),FONT('Arial',8,,),TIP('Recall Memory'),USE(?Recall)
       BUTTON('M'),AT(9,93,16,14),FONT('Arial',8,,),TIP('Store in Memory'),USE(?Store)
       BUTTON(' M+'),AT(9,109,16,14),FONT('Arial',8,,),TIP('Add to Memory'),USE(?Accumulate)
       BUTTON('+'),AT(90,116,18,46),FONT('Arial',8,,),TIP('Add'),KEY(PlusKey),USE(?Add)
       BUTTON('-'),AT(90,97,18,16),FONT('Arial',8,,),TIP('Subtract'),KEY(MinusKey),USE(?Subtract)
       BUTTON('x'),AT(90,78,18,16),FONT('Arial',8,,),TIP('Multiply'),KEY(AstKey),USE(?Multiply)
       BUTTON('/'),AT(90,60,18,16),FONT(,8,,),TIP('Divide'),KEY(SlashKey),USE(?Divide)
       BUTTON(' exp'),AT(49,41,16,14),FONT('Arial',8,,),TIP('Exponent'),USE(?Power)
       BUTTON('='),AT(10,143,77,19),FONT('Arial',8,,),KEY(EnterKey),USE(?Equal)
       BUTTON,AT(37,169,71,20),TIP('Exit'),KEY(AltF4),USE(?Exit),ICON('EXITS.ICO')
       BUTTON,AT(11,169,22,20),TIP('Copy to Clipboard'),KEY(AltC),USE(?COPY),ICON(ICON:Copy)
       BOX,AT(5,35,107,130),USE(?Box1),ROUND,COLOR(0FFFFH),FILL(0808080H)
       PANEL,AT(28,74,58,67),USE(?Panel1),FILL(0FFFFFFH),BEVEL(1,-1)
       STRING('Atmiòâ:'),AT(4,22,30,10),LEFT
       STRING(@S20),AT(34,22,79,10),FONT(,8,,),USE(Memory),LEFT
       ENTRY(@s20),AT(6,4,104,15),FONT('Arial',11,,FONT:bold),USE(Number),RIGHT(1),INS
     END

  CODE                                            ! Begin processed code
  OPEN(Calculator)                        !Open the calculator window
  NewNumber = True                        !Start with a new number
  Decimal = False                         !No decimal point has been entered
  Operation = ?Equal                      !No outstanding operation
  DecimalFlg = TRUE                       !!!Set flag
  ACCEPT                                  !Enable windows and wait for an event
    DISPLAY
    IF ACCEPTED()                         ! user has caused accepted event
      CASE ACCEPTED()                     ! Jump to the accepted field
      OF ?EXIT                            !!!Exit Button
        BREAK                             !!!
      OF ?COPY                            !!!Copy to clipboard
        NewNumber = False                 !!!
        SETCLIPBOARD(NUMBER)              !!!
      OF ?Recall                          ! For the Recall Memory key 
        Number = Memory                   !  Set number to memory
        cycle
      OF ?Zero TO ?Nine                   ! For a numeric key
        Digit = ACCEPTED() - ?Zero        !  The digit is the field number
         IF NewNumber                     !  For the first digit
          Number = Digit                  !   Set the number to the digit
          NewNumber = False               !   Turn NewNumber flag off
          Decimal = False                 !   Turn decimal point flag off
         ELSE                             !   For any other digit
          IF Decimal                      !    For a fractional digit
          IF DecimalFlg                      !!!
             Number=clip(number) &'.'& Digit !!!
             DecimalFlg = false              !!!
          ELSE                               !!!
            Number=clip(number) & digit      !!!
          END                                !!!
          ELSE                            !    For an integer digit
             DecimalFlg = true
             number=clip(number)& digit
          END                             !   End the IF
        END                               !   End the IF
        CYCLE                             !   Continue number entry
      OF ?Decimal                         ! For the decimal point key
        Decimal = True                    !  Turn decimal point flag on
        DecimalFlg=TRUE                   !!!Reset Flag
        IF NEWNUMBER = TRUE               !!!No need to press 0
           NUMBER = '0'                   !!!if new number
           NEWNUMBER = FALSE              !!!Reset Flag
        END                               !!!
        CYCLE                             !  Continue number entry
      OF ?Pi                              ! For the Pi key
        Number = 3.141592654              !  Set number to Pi
        NewNumber = TRUE                  !  Start new number
        CYCLE                             !  Continue
      OF ?Clear                           ! For the ClearEntry/Clear key
        IF NewNumber THEN                 !  completed number entry
          Operation = ?Equal              !   so Clear current calculation
        END                               !  End IF
        Number = 0                        !  Clear number
        NewNumber = 0                     !  Start new number
      END                                 ! End CASE
      IF Operation <> ?Equal              ! Complete outstanding operations
        IF ACCEPTED() = ?Percent          ! For the percent key
          Number = Number * Operand / 100 ! Calculate % value
          IF  (Operation <> ?Add ) |      ! Check not adding
          AND (Operation <> ?Subtract ) | !  or subtractiong percentage
          AND (Operation <> ?Multiply)  | !!! Added Multiply and Divide
          AND (Operation <> ?Divide)      !!! To the percentage
            Operation = ?Equal            !   Finished operation
          END                             !  End IF
        END                               ! End IF
        CASE Operation                    !  Jump to saved operation key
        OF ?Add                           ! For Add key
          Number += Operand               !   Add number to operand
        OF ?Subtract                      !  For Subtract key
          Number = Operand - Number       !   Subtract number from operand
        OF ?Multiply                      !  For Multiply key
          Number *= Operand               !   Multiply operand by number
        OF ?Divide                        !  For Divide key
          IF Number <> 0 THEN             !  Check for divide by zero
            Number = Operand / Number     !   Divide operand by number
          END                             !  End IF
        OF ?Power                         !  For Raise to a Power key
          Number = Operand ^ Number       !   Raise operand to number power
        END                               !  End CASE
        Operation = ?Equal                !  Operation done
      END                                 ! End IF
      CASE ACCEPTED()                     ! Jump to the accepted field
      OF ?Sign                            ! For the Change Sign key
        Number *= -1                      !  Multiply by -1
      OF ?Square                          ! For the Square key
        Number *= Number                  !  Multilpy by itself
      OF ?Root                            ! For the Square Root key
        Number = SQRT(Number)             !  Find the square root
      OF ?TenTimes                        ! For the 10X key
        Number *= 10                      !  Multiply by 10
      OF ?Reciprical                      ! For the Reciprical key
        IF Number <> 0 THEN               ! Check for divide by zero
          Number = 1/Number               !  Find the reciprical
        END                               ! End IF
      OF ?Log                             ! For the logarithm key
        Number = LOG10(Number)            !  Find the base 10 logarithm
      OF ?Ln                              ! For the natural logarithm key
        Number = LOGE(Number)             !  Find the natural logarithm
      OF ?Store                           ! For the Store memory key
        Memory = Number                   !  Set memory to number
      OF ?Accumulate                      ! For the Add to Memory key
        Memory += Number                  !  Add number to memory
      OF ?Add TO ?Power                   ! For two operand operation keys
        Operation = ACCEPTED()            !  Save the operator
        Operand = Number                  !  Save the first operand
      END                                 ! End CASE
      SELECT(?Zero)                       ! Set focus to the Zero key
      NewNumber = TRUE                    ! ready for next number
      DecimalFlg = TRUE                   !!!Reset flag
    END                                   !End CASE
  END                                     !End ACCEPT
  CLOSE(Calculator)                      !Close the calculator window
UpdateParoles PROCEDURE


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
Update::Reloop  BYTE
Update::Error   BYTE
History::SEC:Record LIKE(SEC:Record),STATIC
SAV::SEC:Record      LIKE(SEC:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:SEC:U_NR     LIKE(SEC:U_NR)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the PAROLES File'),AT(,,250,298),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('Upateparoles'),SYSTEM,GRAY,RESIZE
                       SHEET,AT(4,4,241,274),USE(?CurrentTab)
                         TAB('Lietotâju pieejas lîmeòa kontrole '),USE(?Tab:1)
                           BUTTON('Atvçrt U-NR -->'),AT(9,18,56,14),USE(?AUNR)
                           ENTRY(@n_6),AT(69,19,31,11),USE(SEC:U_NR),DISABLE,FONT(,,,FONT:bold),REQ,OVR,UPR
                           PROMPT('&Slçptâ daïa'),AT(8,33,54,10),USE(?SEC:SECURE:Prompt)
                           ENTRY(@s8),AT(69,32,58,11),USE(SEC:SECURE),FONT(,,,FONT:bold),REQ,OVR,UPR
                           PROMPT('&Publiskâ daïa'),AT(8,46,58,10),USE(?SEC:PUBLISH:Prompt)
                           ENTRY(@s8),AT(69,45,58,11),USE(SEC:PUBLISH),FONT(,,,FONT:bold),REQ,OVR,UPR
                           PROMPT('&Vârds Uzvârds:'),AT(9,59,57,10),USE(?SEC:VUT:Prompt)
                           ENTRY(@s25),AT(69,58,108,11),USE(SEC:VUT)
                           PROMPT('Amats:'),AT(9,72),USE(?SEC:AMATS:Prompt)
                           ENTRY(@s25),AT(69,70,108,11),USE(SEC:AMATS)
                           BUTTON('Pieeja Failiem'),AT(9,83,98,14),USE(?files)
                           STRING(@s8),AT(109,85,69,10),USE(SEC:FILES_ACC),LEFT(1)
                           BUTTON('Pieeja Bâzei DB:1-15'),AT(9,99,98,14),USE(?base)
                           STRING(@s20),AT(109,100,103,10),USE(SEC:BASE_ACC),LEFT(1)
                           BUTTON('Pieeja Noliktavai DB:16-40'),AT(9,114,98,14),USE(?nolik)
                           STRING(@s25),AT(109,116,130,10),USE(SEC:NOL_ACC),LEFT(1)
                           BUTTON('Pieeja Fiskâlai Dr DB:41-65'),AT(9,130,98,14),USE(?FP)
                           STRING(@s25),AT(109,130,129,10),USE(SEC:FP_ACC),LEFT(1)
                           BUTTON('Pieeja Algai DB:66-80'),AT(9,145,98,14),USE(?alga)
                           STRING(@s20),AT(109,146,105,10),USE(SEC:ALGA_ACC),LEFT(1)
                           BUTTON('Pieeja P/L DB:81-95'),AT(9,161,98,14),USE(?pam)
                           STRING(@s20),AT(109,162,104,10),USE(SEC:PAM_ACC),LEFT(1)
                           BUTTON('Pieeja Laika-u DB:96-120'),AT(9,177,98,14),USE(?LM)
                           STRING(@s25),AT(110,179,129,10),USE(SEC:LM_ACC),LEFT(1)
                           PROMPT('Starta DB (1-95) :'),AT(12,201),USE(?START:Prompt)
                           ENTRY(@n2),AT(72,200,22,11),USE(SEC:START_NR)
                           BUTTON('Supervizora pieeja'),AT(119,198),USE(?SuperACC)
                           IMAGE('CHECK3.ICO'),AT(201,194),USE(?ImageSuper),HIDE
                           BUTTON('Aizliegt datu apmaiòu un importa interfeisu '),AT(40,218),USE(?AizliegtDatuApmainu)
                           IMAGE('CANCEL4.ICO'),AT(201,234),USE(?ImageA_self),HIDE
                           BUTTON('Aizliegt  selftestu'),AT(94,238,98,14),USE(?AizliegtSelftestu)
                           BUTTON('Aizliegt pieeju neapstiprinâtiem rakstiem'),AT(39,257,153,14),USE(?AizliegtNEAP)
                           IMAGE('CANCEL4.ICO'),AT(201,254),USE(?ImageA_Neap),HIDE
                           IMAGE('CANCEL4.ICO'),AT(201,214),USE(?ImageA_DAII),HIDE
                         END
                       END
                       STRING(@s8),AT(8,284),USE(SEC:ACC_KODS),FONT(,,COLOR:Gray,)
                       BUTTON('&OK'),AT(151,282,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(199,282,45,14),USE(?Cancel)
                       STRING(@D06.),AT(45,284),USE(SEC:ACC_DATUMS),FONT(,,COLOR:Gray,)
                     END
access      string(1)
SEC_PUBLISH LIKE(SEC:PUBLISH)

screen:files WINDOW('Pieeja failiem'),AT(,,283,145),GRAY
       OPTION('&Sistçmas kopçjie faili :'),AT(12,14,123,117),USE(?option1),BOXED
         RADIO('Partneri, atzîmes,'),AT(18,26),USE(?Option1:Radio1)
         RADIO('Kontu plâns'),AT(18,43,51,10),USE(?Option1:Radio2)
         RADIO('Bankas'),AT(18,53,37,10),USE(?option1:Radio3)
         RADIO('Valûtas, valûtu kursi'),AT(18,62,82,10),USE(?option1:Radio4)
         RADIO('Nomenklatûras, grupas,'),AT(18,71,87,10),USE(?option1:Radio5)
         RADIO('Kadri'),AT(18,99,29,10),USE(?option1:Radio6)
         RADIO('Auto'),AT(18,109,29,10),USE(?option1:Radio7)
       END
       OPTION('&Pieejas lîmenis :'),AT(138,17,135,63),USE(access),BOXED
         RADIO('0-Pilna pieeja'),AT(145,29),USE(?access:Radio1),VALUE('0')
         RADIO('1-Aizliegts dzçst'),AT(145,38),USE(?access:Radio2),VALUE('1')
         RADIO('2-Aizliegts dzçst un mainît'),AT(145,47),USE(?access:Radio3),VALUE('2')
         RADIO('3-Aizliegts dzçst,mainît un ievadît'),AT(145,56),USE(?access:Radio4),VALUE('3')
         RADIO('N-Nav pieejas'),AT(145,65),USE(?access:Radio5),VALUE('N')
       END
       STRING('projekti, atlaides,adreses'),AT(25,35),USE(?String9)
       STRING('apakðgrupas, mçrvienîbas,'),AT(25,80),USE(?String7)
       STRING(@s1),AT(120,33,11,10),USE(sec:files_acc[1]),CENTER
       STRING(@s1),AT(120,43,11,10),USE(sec:files_acc[2]),CENTER
       STRING(@s1),AT(120,53,11,10),USE(sec:files_acc[3]),CENTER
       STRING(@s1),AT(120,62,11,10),USE(sec:files_acc[4]),CENTER
       STRING(@s1),AT(120,89,11,10),USE(sec:files_acc[5]),CENTER
       STRING(@s1),AT(120,99,11,10),USE(sec:files_acc[6]),CENTER
       STRING(@s1),AT(120,109,11,10),USE(sec:files_acc[7]),CENTER
       BUTTON('&Aizliegts mainît Par Grupas un Karti'),AT(139,81,122,15),USE(?grupasaizl)
       IMAGE('CANCEL4.ICO'),AT(263,81,16,15),USE(?Imagegrupas),HIDE
       BUTTON('&Aizliegts mainît Par Atzîmi un Kred.L'),AT(140,97,122,15),USE(?atzimeaizl)
       IMAGE('CANCEL4.ICO'),AT(263,97,16,15),USE(?Imageatzime),HIDE
       STRING('tekstu plâns, cenu vçsture'),AT(25,89),USE(?String8)
       BUTTON('&OK'),AT(240,124,35,15),USE(?OkFiles),DEFAULT
     END
screen:base WINDOW('Pieeja Bâzei'),AT(,,265,176),GRAY
       OPTION('Base'),AT(10,14,88,152),USE(?option11),BOXED
         RADIO('Base 01'),AT(19,26,39,10),USE(?Option11:Radio1)
         RADIO('Base 02'),AT(19,35,39,10),USE(?Option11:Radio2)
         RADIO('Base 03'),AT(19,44,39,10),USE(?option11:Radio3)
         RADIO('Base 04'),AT(19,54,39,10),USE(?option11:Radio4)
         RADIO('Base 05'),AT(19,63,39,10),USE(?option11:Radio5)
         RADIO('Base 06'),AT(19,72,39,10),USE(?option11:Radio6)
         RADIO('Base 07'),AT(19,81,39,10),USE(?option11:Radio7)
         RADIO('Base 08'),AT(19,90,39,10),USE(?option11:Radio8)
         RADIO('Base 09'),AT(19,100,39,10),USE(?option11:Radio9)
         RADIO('Base 10'),AT(19,109,39,10),USE(?option11:Radio10)
         RADIO('Base 11'),AT(19,118,39,10),USE(?option11:Radio11)
         RADIO('Base 12'),AT(19,127,39,10),USE(?option11:Radio12)
         RADIO('Base 13'),AT(19,136,39,10),USE(?option11:Radio13)
         RADIO('Base 14'),AT(19,145,39,10),USE(?option11:Radio14)
         RADIO('Base 15'),AT(19,154,39,10),USE(?option11:Radio15)
       END
       OPTION('Pieejas lîmenis :'),AT(121,17,135,63),USE(access,,?access11),BOXED
         RADIO('0-Pilna pieeja'),AT(128,29),USE(?access11:Radio1),VALUE('0')
         RADIO('1-Aizliegts dzçst'),AT(128,38),USE(?access11:Radio2),VALUE('1')
         RADIO('2-Aizliegts dzçst un mainît'),AT(128,47),USE(?access11:Radio3),VALUE('2')
         RADIO('3-Aizliegts dzçst,mainît un ievadît'),AT(128,56),USE(?access11:Radio4),VALUE('3')
         RADIO('N-Nav pieejas'),AT(128,65),USE(?access11:Radio5),VALUE('N')
       END
       STRING(@s1),AT(82,26),USE(sec:base_acc[1]),CENTER
       STRING(@s1),AT(82,35),USE(sec:base_acc[2]),CENTER
       STRING(@s1),AT(82,44),USE(sec:base_acc[3]),CENTER
       STRING(@s1),AT(82,54),USE(sec:base_acc[4]),CENTER
       STRING(@s1),AT(82,63),USE(sec:base_acc[5]),CENTER
       STRING(@s1),AT(82,72),USE(sec:base_acc[6]),CENTER
       STRING(@s1),AT(82,81),USE(sec:base_acc[7]),CENTER
       STRING(@s1),AT(82,90),USE(sec:base_acc[8]),CENTER
       STRING(@s1),AT(82,100,11,10),USE(sec:base_acc[9]),CENTER
       STRING(@s1),AT(82,109,11,10),USE(sec:base_acc[10]),CENTER
       STRING(@s1),AT(82,118,11,10),USE(sec:base_acc[11]),CENTER
       STRING(@s1),AT(82,127,11,10),USE(sec:base_acc[12]),CENTER
       STRING(@s1),AT(82,136,11,10),USE(sec:base_acc[13]),CENTER
       STRING(@s1),AT(82,145,11,10),USE(sec:base_acc[14]),CENTER
       STRING(@s1),AT(82,154,11,10),USE(sec:base_acc[15]),CENTER
       BUTTON('OK'),AT(195,149,35,14),USE(?OkBase),DEFAULT
     END
screen:nolik WINDOW('Pieeja Noliktavai'),AT(,,386,230),GRAY
       OPTION('Noliktava'),AT(6,7,153,152),USE(?option21),BOXED
         RADIO('Noliktava 01'),AT(15,19,54,10),USE(?Option21:Radio1)
         RADIO('Noliktava 02'),AT(15,28,49,10),USE(?Option21:Radio2)
         RADIO('Noliktava 03'),AT(15,37,49,10),USE(?option21:Radio3)
         RADIO('Noliktava 04'),AT(15,47,50,10),USE(?option21:Radio4)
         RADIO('Noliktava 05'),AT(15,56,52,10),USE(?option21:Radio5)
         RADIO('Noliktava 06'),AT(15,65,51,10),USE(?option21:Radio6)
         RADIO('Noliktava 07'),AT(15,74,52,10),USE(?option21:Radio7)
         RADIO('Noliktava 08'),AT(15,83,52,10),USE(?option21:Radio8)
         RADIO('Noliktava 09'),AT(15,93,52,10),USE(?option21:Radio9)
         RADIO('Noliktava 10'),AT(15,102,54,10),USE(?option21:Radio10)
         RADIO('Noliktava 11'),AT(15,111,49,10),USE(?option21:Radio11)
         RADIO('Noliktava 12'),AT(15,120,50,10),USE(?option21:Radio12)
         RADIO('Noliktava 13'),AT(15,129,51,10),USE(?option21:Radio13)
         RADIO('Noliktava 14'),AT(15,138,52,10),USE(?option21:Radio14)
         RADIO('Noliktava 15'),AT(15,147,52,10),USE(?option21:Radio15)
         RADIO('Noliktava 16'),AT(85,19),USE(?option21:Radio16)
         RADIO('Noliktava 17'),AT(85,28),USE(?option21:Radio17)
         RADIO('Noliktava 18'),AT(85,37),USE(?option21:Radio18)
         RADIO('Noliktava 19'),AT(85,47),USE(?option21:Radio19)
         RADIO('Noliktava 20'),AT(85,56),USE(?option21:Radio20)
         RADIO('Noliktava 21'),AT(85,65),USE(?option21:Radio21)
         RADIO('Noliktava 22'),AT(85,74),USE(?option21:Radio22)
         RADIO('Noliktava 23'),AT(85,83),USE(?option21:Radio23)
         RADIO('Noliktava 24'),AT(85,93),USE(?option21:Radio24)
         RADIO('Noliktava 25'),AT(85,102),USE(?option21:Radio25)
       END
       OPTION('Pieejas lîmenis :'),AT(163,7,135,61),USE(access,,?access21),BOXED
         RADIO('0-Pilna pieeja'),AT(170,19),USE(?access21:Radio1),VALUE('0')
         RADIO('1-Aizliegts dzçst'),AT(170,28),USE(?access21:Radio2),VALUE('1')
         RADIO('2-Aizliegts dzçst un mainît'),AT(170,37),USE(?access21:Radio3),VALUE('2')
         RADIO('3-Aizliegts dzçst,mainît un ievadît'),AT(170,46),USE(?access21:Radio4),VALUE('3')
         RADIO('N-Nav pieejas'),AT(170,55),USE(?access21:Radio6),VALUE('N')
       END
       STRING(@s1),AT(70,19,11,10),USE(sec:nol_acc[1]),CENTER
       STRING(@s1),AT(70,28,11,10),USE(sec:nol_acc[2]),CENTER
       STRING(@s1),AT(70,37,11,10),USE(sec:nol_acc[3]),CENTER
       STRING(@s1),AT(70,47,11,10),USE(sec:nol_acc[4]),CENTER
       STRING(@s1),AT(70,56,11,10),USE(sec:nol_acc[5]),CENTER
       STRING(@s1),AT(70,65,11,10),USE(sec:nol_acc[6]),CENTER
       STRING(@s1),AT(70,74,11,10),USE(sec:nol_acc[7]),CENTER
       STRING(@s1),AT(70,83,11,10),USE(sec:nol_acc[8]),CENTER
       STRING(@s1),AT(70,93,11,10),USE(sec:nol_acc[9]),CENTER
       STRING(@s1),AT(70,102,11,10),USE(sec:nol_acc[10]),CENTER
       STRING(@s1),AT(70,111,11,10),USE(sec:nol_acc[11]),CENTER
       STRING(@s1),AT(70,120,11,10),USE(sec:nol_acc[12]),CENTER
       STRING(@s1),AT(70,129,11,10),USE(sec:nol_acc[13]),CENTER
       STRING(@s1),AT(70,138,11,10),USE(sec:nol_acc[14]),CENTER
       STRING(@s1),AT(70,147,11,10),USE(sec:nol_acc[15]),CENTER
       STRING(@s1),AT(143,19,11,10),USE(sec:nol_acc[16]),CENTER
       STRING(@s1),AT(143,28,11,10),USE(sec:nol_acc[17]),CENTER
       STRING(@s1),AT(143,37,11,10),USE(sec:nol_acc[18]),CENTER
       STRING(@s1),AT(143,47,11,10),USE(sec:nol_acc[19]),CENTER
       STRING(@s1),AT(143,56,11,10),USE(sec:nol_acc[20]),CENTER
       STRING(@s1),AT(143,65,11,10),USE(sec:nol_acc[21]),CENTER
       STRING(@s1),AT(143,74,11,10),USE(sec:nol_acc[22]),CENTER
       STRING(@s1),AT(143,83,11,10),USE(sec:nol_acc[23]),CENTER
       STRING(@s1),AT(143,93,11,10),USE(sec:nol_acc[24]),CENTER
       STRING(@s1),AT(143,102,11,10),USE(sec:nol_acc[25]),CENTER
       BUTTON('Aizliegt apskatît D P/Z un jebkuru pieeju iepirkuma cenâm'),AT(163,71,197,13),USE(?BNOL1)
       IMAGE('CANCEL4.ICO'),AT(363,71,14,14),USE(?ImageNOL1),HIDE
       BUTTON('Aizliegt pieeju statistikai'),AT(163,85,197,13),USE(?BNOL2)
       IMAGE('CANCEL4.ICO'),AT(363,84,14,14),USE(?ImageNOL2),HIDE
       BUTTON('Aizliegt pieeju kopsavilkumiem'),AT(163,99,197,13),USE(?BNOL3)
       IMAGE('CANCEL4.ICO'),AT(363,98,14,14),USE(?ImageNOL3),HIDE
       BUTTON('Aizliegt apvienot un sadalît gabalos P/Z'),AT(163,113,197,13),USE(?BNOL4)
       IMAGE('CANCEL4.ICO'),AT(363,112,14,14),USE(?ImageNOL4),HIDE
       BUTTON('Aizliegt pieeju pasûtîjumiem'),AT(163,127,197,13),USE(?BNOL5)
       IMAGE('CANCEL4.ICO'),AT(363,126,14,14),USE(?ImageNOL5),HIDE
       BUTTON('Aizliegts atvçrt/slçgt P/Z (S)'),AT(163,141,197,13),USE(?BNOL6)
       IMAGE('CANCEL4.ICO'),AT(363,140,14,14),USE(?ImageNOL6),HIDE
       BUTTON('&OK'),AT(348,214,35,14),USE(?OkNolik),DEFAULT
       IMAGE('CANCEL4.ICO'),AT(363,154,14,14),USE(?ImageNOLserviss),HIDE
       BUTTON('Aizliegt pieeju Atlaidei, Summai un Tekoðai cenai (arî FP)'),AT(163,169,197,13),USE(?BNOLatlaide)
       IMAGE('CANCEL4.ICO'),AT(363,168,14,14),USE(?ImageNOLatlaide),HIDE
       BUTTON('Aizliegt pârdot, ja veidojas negatîvi atlikumi (arî FP)'),AT(163,183,197,13),USE(?NOTMINUSI)
       IMAGE('CANCEL4.ICO'),AT(363,182,14,14),USE(?ImageNOTMINUSI),HIDE
       BUTTON('Aizliegt pârdot zem minimâlâs realizâcijas cenas (arî FP)'),AT(163,197,197,13),USE(?NOTMINRC)
       IMAGE('CANCEL4.ICO'),AT(363,196,14,14),USE(?ImageNOTMINRC),HIDE
       BUTTON('Aizliegt pieeju Servisam'),AT(163,155,197,13),USE(?BNOLserviss)
     END
screen:fp WINDOW('Pieeja Fiskâlai Drukai'),AT(,,340,176),GRAY
       OPTION('Fiskâla Druka'),AT(10,14,177,152),USE(?option51),BOXED
         RADIO('FP 01'),AT(19,26,54,10),USE(?Option51:Radio1)
         RADIO('FP 02'),AT(19,35,49,10),USE(?Option51:Radio2)
         RADIO('FP 03'),AT(19,44,49,10),USE(?option51:Radio3)
         RADIO('FP 04'),AT(19,54,50,10),USE(?option51:Radio4)
         RADIO('FP 05'),AT(19,63,52,10),USE(?option51:Radio5)
         RADIO('FP 06'),AT(19,72,51,10),USE(?option51:Radio6)
         RADIO('FP 07'),AT(19,81,52,10),USE(?option51:Radio7)
         RADIO('FP 08'),AT(19,90,52,10),USE(?option51:Radio8)
         RADIO('FP 09'),AT(19,100,52,10),USE(?option51:Radio9)
         RADIO('FP 10'),AT(19,109,54,10),USE(?option51:Radio10)
         RADIO('FP 11'),AT(19,118,49,10),USE(?option51:Radio11)
         RADIO('FP 12'),AT(19,127,50,10),USE(?option51:Radio12)
         RADIO('FP 13'),AT(19,136,51,10),USE(?option51:Radio13)
         RADIO('FP 14'),AT(19,145,52,10),USE(?option51:Radio14)
         RADIO('FP 15'),AT(19,154,52,10),USE(?option51:Radio15)
         RADIO('FP 16'),AT(105,26),USE(?option51:Radio16)
         RADIO('FP 17'),AT(105,35),USE(?option51:Radio17)
         RADIO('FP 18'),AT(105,44),USE(?option51:Radio18)
         RADIO('FP 19'),AT(105,54),USE(?option51:Radio19)
         RADIO('FP 20'),AT(105,63),USE(?option51:Radio20)
         RADIO('FP 21'),AT(105,72),USE(?option51:Radio21)
         RADIO('FP 22'),AT(105,81),USE(?option51:Radio22)
         RADIO('FP 23'),AT(105,90),USE(?option51:Radio23)
         RADIO('FP 24'),AT(105,100),USE(?option51:Radio24)
         RADIO('FP 25'),AT(105,109),USE(?option51:Radio25)
       END
       OPTION('Pieejas lîmenis :'),AT(193,17,135,65),USE(access,,?access51),BOXED
         RADIO('0-Pilna pieeja'),AT(200,29),USE(?access51:Radio1),VALUE('0')
         RADIO('1-Aizliegts dzçst'),AT(200,38),USE(?access51:Radio2),VALUE('1')
         RADIO('2-Aizliegts dzçst un mainît'),AT(200,47),USE(?access51:Radio3),VALUE('2')
         RADIO('3-Aizliegts dzçst,mainît un ievadît'),AT(200,56),USE(?access51:Radio4),VALUE('3')
         RADIO('N-Nav pieejas'),AT(200,66),USE(?access51:Radio6),VALUE('N')
       END
       STRING(@s1),AT(79,26,11,10),USE(sec:FP_acc[1]),CENTER
       STRING(@s1),AT(79,35,11,10),USE(sec:FP_acc[2]),CENTER
       STRING(@s1),AT(79,44,11,10),USE(sec:FP_acc[3]),CENTER
       STRING(@s1),AT(79,54,11,10),USE(sec:FP_acc[4]),CENTER
       STRING(@s1),AT(79,63,11,10),USE(sec:FP_acc[5]),CENTER
       STRING(@s1),AT(79,72,11,10),USE(sec:FP_acc[6]),CENTER
       STRING(@s1),AT(79,81,11,10),USE(sec:FP_acc[7]),CENTER
       STRING(@s1),AT(79,90,11,10),USE(sec:FP_acc[8]),CENTER
       STRING(@s1),AT(79,100,11,10),USE(sec:FP_acc[9]),CENTER
       STRING(@s1),AT(79,109,11,10),USE(sec:FP_acc[10]),CENTER
       STRING(@s1),AT(79,118,11,10),USE(sec:FP_acc[11]),CENTER
       STRING(@s1),AT(79,127,11,10),USE(sec:FP_acc[12]),CENTER
       STRING(@s1),AT(79,136,11,10),USE(sec:FP_acc[13]),CENTER
       STRING(@s1),AT(79,145,11,10),USE(sec:FP_acc[14]),CENTER
       STRING(@s1),AT(79,154,11,10),USE(sec:FP_acc[15]),CENTER
       STRING(@s1),AT(159,26,11,10),USE(sec:FP_acc[16]),CENTER
       STRING(@s1),AT(159,35,11,10),USE(sec:FP_acc[17]),CENTER
       STRING(@s1),AT(159,44,11,10),USE(sec:FP_acc[18]),CENTER
       STRING(@s1),AT(159,54,11,10),USE(sec:FP_acc[19]),CENTER
       STRING(@s1),AT(159,63,11,10),USE(sec:FP_acc[20]),CENTER
       STRING(@s1),AT(159,72,11,10),USE(sec:FP_acc[21]),CENTER
       STRING(@s1),AT(159,81,11,10),USE(sec:FP_acc[22]),CENTER
       STRING(@s1),AT(159,90,11,10),USE(sec:FP_acc[23]),CENTER
       STRING(@s1),AT(159,100,11,10),USE(sec:FP_acc[24]),CENTER
       STRING(@s1),AT(159,109,11,10),USE(sec:FP_acc[25]),CENTER
       BUTTON('OK'),AT(284,150,35,14),USE(?OkFP),DEFAULT
     END
screen:alga WINDOW('Pieeja Algai'),AT(,,265,176),GRAY
       OPTION('Alga'),AT(10,14,88,152),USE(?option31),BOXED
         RADIO('Alga 01 '),AT(19,26,39,10),USE(?Option31:Radio1)
         RADIO('Alga 02'),AT(19,35,39,10),USE(?Option31:Radio2)
         RADIO('Alga 03'),AT(19,44,39,10),USE(?option31:Radio3)
         RADIO('Alga 04'),AT(19,54,39,10),USE(?option31:Radio4)
         RADIO('Alga 05'),AT(19,63,39,10),USE(?option31:Radio5)
         RADIO('Alga 06'),AT(19,72,39,10),USE(?option31:Radio6)
         RADIO('Alga 07'),AT(19,81,39,10),USE(?option31:Radio7)
         RADIO('Alga 08'),AT(19,90,39,10),USE(?option31:Radio8)
         RADIO('Alga 09'),AT(19,100,39,10),USE(?option31:Radio9)
         RADIO('Alga 10'),AT(19,109,39,10),USE(?option31:Radio10)
         RADIO('Alga 11'),AT(19,118,39,10),USE(?option31:Radio11)
         RADIO('Alga 12'),AT(19,127,39,10),USE(?option31:Radio12)
         RADIO('Alga 13'),AT(19,136,39,10),USE(?option31:Radio13)
         RADIO('Alga 14'),AT(19,145,39,10),USE(?option31:Radio14)
         RADIO('Alga 15'),AT(19,154,39,10),USE(?option31:Radio15)
       END
       OPTION('Pieejas lîmenis :'),AT(121,17,135,63),USE(access,,?access31),BOXED
         RADIO('0-Pilna pieeja'),AT(128,29),USE(?access31:Radio1),VALUE('0')
         RADIO('1-Aizliegts dzçst'),AT(128,38),USE(?access31:Radio2),VALUE('1')
         RADIO('2-Aizliegts dzçst un mainît'),AT(128,47),USE(?access31:Radio3),VALUE('2')
         RADIO('3-Aizliegts dzçst,mainît un ievadît'),AT(128,56),USE(?access31:Radio4),VALUE('3')
         RADIO('N-Nav pieejas'),AT(128,65),USE(?access31:Radio5),VALUE('N')
       END
       STRING(@s1),AT(82,26),USE(sec:Alga_acc[1]),CENTER
       STRING(@s1),AT(82,35),USE(sec:Alga_acc[2]),CENTER
       STRING(@s1),AT(82,44),USE(sec:Alga_acc[3]),CENTER
       STRING(@s1),AT(82,54),USE(sec:Alga_acc[4]),CENTER
       STRING(@s1),AT(82,63),USE(sec:Alga_acc[5]),CENTER
       STRING(@s1),AT(82,72),USE(sec:Alga_acc[6]),CENTER
       STRING(@s1),AT(82,81),USE(sec:Alga_acc[7]),CENTER
       STRING(@s1),AT(82,90),USE(sec:Alga_acc[8]),CENTER
       STRING(@s1),AT(82,100,11,10),USE(sec:Alga_acc[9]),CENTER
       STRING(@s1),AT(82,109,11,10),USE(sec:Alga_acc[10]),CENTER
       STRING(@s1),AT(82,118,11,10),USE(sec:Alga_acc[11]),CENTER
       STRING(@s1),AT(82,127,11,10),USE(sec:Alga_acc[12]),CENTER
       STRING(@s1),AT(82,136,11,10),USE(sec:Alga_acc[13]),CENTER
       STRING(@s1),AT(82,145,11,10),USE(sec:Alga_acc[14]),CENTER
       STRING(@s1),AT(82,154,11,10),USE(sec:Alga_acc[15]),CENTER
       BUTTON('OK'),AT(195,149,35,14),USE(?OkAlga),DEFAULT
     END
screen:pam WINDOW('Pieeja Pamatlîdzekïiem'),AT(,,265,176),GRAY
       OPTION('Pamatlîdzekïi'),AT(10,14,88,152),USE(?option41),BOXED
         RADIO('Pam 01 '),AT(19,26,39,10),USE(?Option41:Radio1)
         RADIO('Pam 02'),AT(19,35,39,10),USE(?Option41:Radio2)
         RADIO('Pam 03'),AT(19,44,39,10),USE(?option41:Radio3)
         RADIO('Pam 04'),AT(19,54,39,10),USE(?option41:Radio4)
         RADIO('Pam 05'),AT(19,63,39,10),USE(?option41:Radio5)
         RADIO('Pam 06'),AT(19,72,39,10),USE(?option41:Radio6)
         RADIO('Pam 07'),AT(19,81,39,10),USE(?option41:Radio7)
         RADIO('Pam 08'),AT(19,90,39,10),USE(?option41:Radio8)
         RADIO('Pam 09'),AT(19,100,39,10),USE(?option41:Radio9)
         RADIO('Pam 10'),AT(19,109,39,10),USE(?option41:Radio10)
         RADIO('Pam 11'),AT(19,118,39,10),USE(?option41:Radio11)
         RADIO('Pam 12'),AT(19,127,39,10),USE(?option41:Radio12)
         RADIO('Pam 13'),AT(19,136,39,10),USE(?option41:Radio13)
         RADIO('Pam 14'),AT(19,145,39,10),USE(?option41:Radio14)
         RADIO('Pam 15'),AT(19,154,39,10),USE(?option41:Radio15)
       END
       OPTION('Pieejas lîmenis :'),AT(121,17,135,63),USE(access,,?access41),BOXED
         RADIO('0-Pilna pieeja'),AT(128,29),USE(?access41:Radio1),VALUE('0')
         RADIO('1-Aizliegts dzçst'),AT(128,38),USE(?access41:Radio2),VALUE('1')
         RADIO('2-Aizliegts dzçst un mainît'),AT(128,47),USE(?access41:Radio3),VALUE('2')
         RADIO('3-Aizliegts dzçst,mainît un ievadît'),AT(128,56),USE(?access41:Radio4),VALUE('3')
         RADIO('N-Nav pieejas'),AT(128,65),USE(?access41:Radio5),VALUE('N')
       END
       STRING(@s1),AT(82,26),USE(sec:Pam_acc[1]),CENTER
       STRING(@s1),AT(82,35),USE(sec:Pam_acc[2]),CENTER
       STRING(@s1),AT(82,44),USE(sec:Pam_acc[3]),CENTER
       STRING(@s1),AT(82,54),USE(sec:Pam_acc[4]),CENTER
       STRING(@s1),AT(82,63),USE(sec:Pam_acc[5]),CENTER
       STRING(@s1),AT(82,72),USE(sec:Pam_acc[6]),CENTER
       STRING(@s1),AT(82,81),USE(sec:Pam_acc[7]),CENTER
       STRING(@s1),AT(82,90),USE(sec:Pam_acc[8]),CENTER
       STRING(@s1),AT(82,100,11,10),USE(sec:Pam_acc[9]),CENTER
       STRING(@s1),AT(82,109,11,10),USE(sec:Pam_acc[10]),CENTER
       STRING(@s1),AT(82,118,11,10),USE(sec:Pam_acc[11]),CENTER
       STRING(@s1),AT(82,127,11,10),USE(sec:Pam_acc[12]),CENTER
       STRING(@s1),AT(82,136,11,10),USE(sec:Pam_acc[13]),CENTER
       STRING(@s1),AT(82,145,11,10),USE(sec:Pam_acc[14]),CENTER
       STRING(@s1),AT(82,154,11,10),USE(sec:Pam_acc[15]),CENTER
       BUTTON('OK'),AT(195,149,35,14),USE(?OkPam),DEFAULT
     END

screen:LM WINDOW('Pieeja Laika uzskaites sistçmai'),AT(,,340,176),GRAY
       OPTION('Laika uzskaites vietas'),AT(10,14,177,152),USE(?option61),BOXED
         RADIO('LM 01'),AT(19,26,54,10),USE(?Option61:Radio1)
         RADIO('LM 02'),AT(19,35,49,10),USE(?Option61:Radio2)
         RADIO('LM 03'),AT(19,44,49,10),USE(?option61:Radio3)
         RADIO('LM 04'),AT(19,54,50,10),USE(?option61:Radio4)
         RADIO('LM 05'),AT(19,63,52,10),USE(?option61:Radio5)
         RADIO('LM 06'),AT(19,72,61,10),USE(?option61:Radio6)
         RADIO('LM 07'),AT(19,81,52,10),USE(?option61:Radio7)
         RADIO('LM 08'),AT(19,90,52,10),USE(?option61:Radio8)
         RADIO('LM 09'),AT(19,100,52,10),USE(?option61:Radio9)
         RADIO('LM 10'),AT(19,109,54,10),USE(?option61:Radio10)
         RADIO('LM 11'),AT(19,118,49,10),USE(?option61:Radio11)
         RADIO('LM 12'),AT(19,127,50,10),USE(?option61:Radio12)
         RADIO('LM 13'),AT(19,136,51,10),USE(?option61:Radio13)
         RADIO('LM 14'),AT(19,145,52,10),USE(?option61:Radio14)
         RADIO('LM 15'),AT(19,154,52,10),USE(?option61:Radio15)
         RADIO('LM 16'),AT(105,26),USE(?option61:Radio16)
         RADIO('LM 17'),AT(105,35),USE(?option61:Radio17)
         RADIO('LM 18'),AT(105,44),USE(?option61:Radio18)
         RADIO('LM 19'),AT(105,54),USE(?option61:Radio19)
         RADIO('LM 20'),AT(105,63),USE(?option61:Radio20)
         RADIO('LM 21'),AT(105,72),USE(?option61:Radio21)
         RADIO('LM 22'),AT(105,81),USE(?option61:Radio22)
         RADIO('LM 23'),AT(105,90),USE(?option61:Radio23)
         RADIO('LM 24'),AT(105,100),USE(?option61:Radio24)
         RADIO('LM 25'),AT(105,109),USE(?option61:Radio25)
       END
       OPTION('Pieejas lîmenis :'),AT(193,17,135,65),USE(access,,?access61),BOXED
         RADIO('0-Pilna pieeja'),AT(200,29),USE(?access61:Radio1),VALUE('0')
         RADIO('1-Aizliegts dzçst'),AT(200,38),USE(?access61:Radio2),VALUE('1')
         RADIO('2-Aizliegts dzçst un mainît'),AT(200,47),USE(?access61:Radio3),VALUE('2')
         RADIO('3-Aizliegts dzçst,mainît un ievadît'),AT(200,56),USE(?access61:Radio4),VALUE('3')
         RADIO('N-Nav pieejas'),AT(200,66),USE(?access61:Radio6),VALUE('N')
       END
       STRING(@s1),AT(79,26,11,10),USE(sec:LM_acc[1]),CENTER
       STRING(@s1),AT(79,35,11,10),USE(sec:LM_acc[2]),CENTER
       STRING(@s1),AT(79,44,11,10),USE(sec:LM_acc[3]),CENTER
       STRING(@s1),AT(79,54,11,10),USE(sec:LM_acc[4]),CENTER
       STRING(@s1),AT(79,63,11,10),USE(sec:LM_acc[5]),CENTER
       STRING(@s1),AT(79,72,11,10),USE(sec:LM_acc[6]),CENTER
       STRING(@s1),AT(79,81,11,10),USE(sec:LM_acc[7]),CENTER
       STRING(@s1),AT(79,90,11,10),USE(sec:LM_acc[8]),CENTER
       STRING(@s1),AT(79,100,11,10),USE(sec:LM_acc[9]),CENTER
       STRING(@s1),AT(79,109,11,10),USE(sec:LM_acc[10]),CENTER
       STRING(@s1),AT(79,118,11,10),USE(sec:LM_acc[11]),CENTER
       STRING(@s1),AT(79,127,11,10),USE(sec:LM_acc[12]),CENTER
       STRING(@s1),AT(79,136,11,10),USE(sec:LM_acc[13]),CENTER
       STRING(@s1),AT(79,145,11,10),USE(sec:LM_acc[14]),CENTER
       STRING(@s1),AT(79,154,11,10),USE(sec:LM_acc[15]),CENTER
       STRING(@s1),AT(159,26,11,10),USE(sec:LM_acc[16]),CENTER
       STRING(@s1),AT(159,35,11,10),USE(sec:LM_acc[17]),CENTER
       STRING(@s1),AT(159,44,11,10),USE(sec:LM_acc[18]),CENTER
       STRING(@s1),AT(159,54,11,10),USE(sec:LM_acc[19]),CENTER
       STRING(@s1),AT(159,63,11,10),USE(sec:LM_acc[20]),CENTER
       STRING(@s1),AT(159,72,11,10),USE(sec:LM_acc[21]),CENTER
       STRING(@s1),AT(159,81,11,10),USE(sec:LM_acc[22]),CENTER
       STRING(@s1),AT(159,90,11,10),USE(sec:LM_acc[23]),CENTER
       STRING(@s1),AT(159,100,11,10),USE(sec:LM_acc[24]),CENTER
       STRING(@s1),AT(159,109,11,10),USE(sec:LM_acc[25]),CENTER
       BUTTON('OK'),AT(284,150,35,14),USE(?OkLM),DEFAULT
     END
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
  IF SEC:SUPER_ACC='1'
     UNHIDE(?IMAGESUPER)
  .
  IF SEC:SPEC_ACC[1]='1'  !DATU APMAIÒA UN IMP_INT
     UNHIDE(?ImageA_DAII)
  .
  IF SEC:SPEC_ACC[8]='1'  !SELFTESTS
     UNHIDE(?IMAGEA_SELF)
  .
  IF SEC:SPEC_ACC[9]='1'  !NEAPST RAKSTI
     UNHIDE(?IMAGEA_NEAP)
  .
  IF  ~SEC:LM_ACC         !12.10.2008.
     SEC:LM_ACC='N{25}'
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
      !IF COPYREQUEST
      !   SELECT(?SEC:SECURE)
      !.
      DO FORM::AssignButtons
      IF NOT WindowInitialized
        DO InitializeWindow
        WindowInitialized = True
      END
      SELECT(?AUNR)
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
        History::SEC:Record = SEC:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(PAROLES)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(SEC:SECURE_KEY)
              IF StandardWarning(Warn:DuplicateKey,'SEC:SECURE_KEY')
                SELECT(?AUNR)
                VCRRequest = VCRNone
                CYCLE
              END
            END
            IF DUPLICATE(SEC:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'SEC:NR_KEY')
                SELECT(?AUNR)
                VCRRequest = VCRNone
                CYCLE
              END
            END
            IF DUPLICATE(SEC:PUB_KEY)
              IF StandardWarning(Warn:DuplicateKey,'SEC:PUB_KEY')
                SELECT(?AUNR)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?AUNR)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::SEC:Record <> SEC:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:PAROLES(1)
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
              SELECT(?AUNR)
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
          END
        DO RefreshWindow
      OF EVENT:TabChanging
        DO RefreshWindow
      OF EVENT:Selected
        DO RefreshWindow
      END
    OF ?AUNR
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
          ENABLE(?SEC:U_NR)
          SELECT(?SEC:U_NR)
      END
    OF ?SEC:PUBLISH
      CASE EVENT()
      OF EVENT:Accepted
        SEC_PUBLISH=''
        LOOP I#=1 TO 8
           IF ~INSTRING(SEC:PUBLISH[I#],' <>?[]:|*',1)
              SEC_PUBLISH=CLIP(SEC_PUBLISH)&SEC:PUBLISH[I#]
           .
        .
        SEC:PUBLISH=UPPER(INIGEN(SEC_PUBLISH,8,1))
        DISPLAY
      END
    OF ?files
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        open(screen:files)
        IF SEC:SPEC_ACC[7]='1'
           UNHIDE(?IMAGEGRUPAS)
        ELSE
           HIDE(?IMAGEGRUPAS)
        .
        IF SEC:SPEC_ACC[13]='1'
           UNHIDE(?IMAGEATZIME)
        ELSE
           HIDE(?IMAGEATZIME)
        .
        select(?option1,1)
        access=SEC:FILES_ACC[1]
        display
        accept
          case field()
          of ?option1
             CASE EVENT()
             OF EVENT:Accepted
                access=SEC:FILES_ACC[CHOICE(?option1)]
                DISPLAY
             .
          of ?access
             IF CHOICE(?option1)
                SEC:FILES_ACC[CHOICE(?option1)]=ACCESS
                DISPLAY
             .
          of ?okFiles
             break
          OF ?grupasaizl
             CASE EVENT()
             OF EVENT:Accepted
                IF SEC:SPEC_ACC[7]='1'
                   SEC:SPEC_ACC[7]=''
                   HIDE(?IMAGEgrupas)
                ELSE
                   SEC:SPEC_ACC[7]='1'
                   UNHIDE(?IMAGEGRUPAS)
                .
                DISPLAY
             .
          OF ?ATZIMEaizl
             CASE EVENT()
             OF EVENT:Accepted
                IF SEC:SPEC_ACC[13]='1'
                   SEC:SPEC_ACC[13]=''
                   HIDE(?IMAGEATZIME)
                ELSE
                   SEC:SPEC_ACC[13]='1'
                   UNHIDE(?IMAGEATZIME)
                .
                DISPLAY
             .
          .
        .
        close(screen:files)
      END
    OF ?base
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        open(screen:base)
        LOOP I#=1 TO 15
          IF I# > BASE_SK
             DISABLE(I#+1)
          .
        .
        IF BASE_SK=0 THEN DISABLE(?ACCESS11).
        select(?option11,1)
        access=SEC:BASE_ACC[1]
        display
        accept
          case field()
          of ?option11
             CASE EVENT()
             OF EVENT:Accepted
                access=SEC:base_ACC[CHOICE(?option11)]
                DISPLAY
             .
          of ?access11
             IF CHOICE(?option11)
                SEC:BASE_ACC[CHOICE(?option11)]=ACCESS
                DISPLAY
             .
          of ?okbase
             CASE EVENT()
             OF EVENT:Accepted
                break
             .
          .
        .
        close(screen:base)
      END
    OF ?nolik
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        open(screen:nolik)
        IF SEC:SPEC_ACC[2]='1'
           UNHIDE(?IMAGENOL1)
        ELSE
           HIDE(?IMAGENOL1)
        .
        IF SEC:SPEC_ACC[3]='1'
           UNHIDE(?IMAGENOL2)
        ELSE
           HIDE(?IMAGENOL2)
        .
        IF SEC:SPEC_ACC[4]='1'
           UNHIDE(?IMAGENOL3)
        ELSE
           HIDE(?IMAGENOL3)
        .
        IF SEC:SPEC_ACC[5]='1'
           UNHIDE(?IMAGENOL4)
        ELSE
           HIDE(?IMAGENOL4)
        .
        IF SEC:SPEC_ACC[6]='1' !PASÛTÎJUMI
           UNHIDE(?IMAGENOL5)
        ELSIF SEC:SPEC_ACC[6]='2'
           UNHIDE(?IMAGENOL5)
           ?BNOL5{PROP:TEXT}='Ierobeþota pieeja pasûtîjumiem'
        ELSE
           HIDE(?IMAGENOL5)
        .
        IF SEC:SPEC_ACC[10]='1'
           UNHIDE(?IMAGENOL6)
        ELSE
           HIDE(?IMAGENOL6)
        .
        IF SEC:SPEC_ACC[11]='1'
           UNHIDE(?IMAGENOLSERVISS)
        ELSIF SEC:SPEC_ACC[11]='2'
           UNHIDE(?IMAGENOLSERVISS)
           ?BNOLserviss{PROP:TEXT}='Aizliegt pieeju meistariem un darbiem'
        ELSIF SEC:SPEC_ACC[11]='3'
           UNHIDE(?IMAGENOLSERVISS)
           ?BNOLserviss{PROP:TEXT}='Aizliegt pieeju meistaru atskaitçm'
        ELSE
           HIDE(?IMAGENOLSERVISS)
        .
        IF SEC:SPEC_ACC[12]='1'
           UNHIDE(?IMAGENOLATLAIDE)
        ELSE
           HIDE(?IMAGENOLATLAIDE)
        .
        IF SEC:SPEC_ACC[14]='1'   !~MINUSATLIKUMI
           UNHIDE(?IMAGENOTMINUSI)
        ELSE
           HIDE(?IMAGENOTMINUSI)
        .
        IF SEC:SPEC_ACC[15]='1'   !~NOTMINRC
           UNHIDE(?IMAGENOTMINRC)
        ELSE
           HIDE(?IMAGENOTMINRC)
        .
        
        LOOP I#=1 TO 25
          IF I# > NOL_SK
             DISABLE(I#+1)
          .
        .
        IF NOL_SK=0 THEN DISABLE(?ACCESS21).
        select(?option21,1)
        access=SEC:NOL_ACC[1]
        display
        accept
          case field()
          of ?option21
             CASE EVENT()
             OF EVENT:Accepted
                access=SEC:NOL_ACC[CHOICE(?option21)]
                DISPLAY
             .
          of ?access21
             IF CHOICE(?option21)
                SEC:NOL_ACC[CHOICE(?option21)]=ACCESS
                DISPLAY
             .
          of ?okNOLIK
             CASE EVENT()
             OF EVENT:Accepted
                break
             .
          OF ?BNOL1
             CASE EVENT()
             OF EVENT:Accepted
                IF SEC:SPEC_ACC[2]='1'
                   SEC:SPEC_ACC[2]=''
                   HIDE(?IMAGENOL1)
                ELSE
                   SEC:SPEC_ACC[2]='1'
                   UNHIDE(?IMAGENOL1)
                .
                DISPLAY
             .
          OF ?BNOL2
             CASE EVENT()
             OF EVENT:Accepted
                IF SEC:SPEC_ACC[3]='1'
                   SEC:SPEC_ACC[3]=''
                   HIDE(?IMAGENOL2)
                ELSE
                   SEC:SPEC_ACC[3]='1'
                   UNHIDE(?IMAGENOL2)
                .
                DISPLAY
             .
          OF ?BNOL3
             CASE EVENT()
             OF EVENT:Accepted
                IF SEC:SPEC_ACC[4]='1'
                   SEC:SPEC_ACC[4]=''
                   HIDE(?IMAGENOL3)
                ELSE
                   SEC:SPEC_ACC[4]='1'
                   UNHIDE(?IMAGENOL3)
                .
                DISPLAY
             .
          OF ?BNOL4
             CASE EVENT()
             OF EVENT:Accepted
                IF SEC:SPEC_ACC[5]='1'
                   SEC:SPEC_ACC[5]=''
                   HIDE(?IMAGENOL4)
                ELSE
                   SEC:SPEC_ACC[5]='1'
                   UNHIDE(?IMAGENOL4)
                .
                DISPLAY
             .
          OF ?BNOL5      !PIEEJA PASÛTÎJUMIEM
             CASE EVENT()
             OF EVENT:Accepted
                IF SEC:SPEC_ACC[6]='1'
                   SEC:SPEC_ACC[6]='2'
                   UNHIDE(?IMAGENOL5)
                   ?BNOL5{PROP:TEXT}='Ierobeþota pieeja pasûtîjumiem'
                ELSIF SEC:SPEC_ACC[6]='2'
                   SEC:SPEC_ACC[6]=''
                   HIDE(?IMAGENOL5)
                   ?BNOL5{PROP:TEXT}='Aizliegt pieeju pasûtîjumiem'
                ELSE
                   SEC:SPEC_ACC[6]='1'
                   UNHIDE(?IMAGENOL5)
                   ?BNOL5{PROP:TEXT}='Aizliegt pieeju pasûtîjumiem'
                .
                DISPLAY
             .
          OF ?BNOL6
             CASE EVENT()
             OF EVENT:Accepted
                IF SEC:SPEC_ACC[10]='1'
                   SEC:SPEC_ACC[10]=''
                   HIDE(?IMAGENOL6)
                ELSE
                   SEC:SPEC_ACC[10]='1'
                   UNHIDE(?IMAGENOL6)
                .
                DISPLAY
             .
          OF ?BNOLSERVISS
             CASE EVENT()
             OF EVENT:Accepted
                IF SEC:SPEC_ACC[11]='1'
                   SEC:SPEC_ACC[11]='2'
                   ?BNOLserviss{PROP:TEXT}='Aizliegt pieeju meistariem un darbiem'
                ELSIF SEC:SPEC_ACC[11]='2'
                   SEC:SPEC_ACC[11]='3'
                   ?BNOLserviss{PROP:TEXT}='Aizliegt pieeju meistaru atskaitçm'
                ELSIF SEC:SPEC_ACC[11]='3'
                   SEC:SPEC_ACC[11]=''
                   ?BNOLserviss{PROP:TEXT}='Aizliegt pieeju Servisam'
                   HIDE(?IMAGENOLSERVISS)
                ELSE
                   SEC:SPEC_ACC[11]='1'
                   ?BNOLserviss{PROP:TEXT}='Aizliegt pieeju Servisam'
                   UNHIDE(?IMAGENOLSERVISS)
                .
                DISPLAY
             .
          OF ?BNOLATLAIDE
             CASE EVENT()
             OF EVENT:Accepted
                IF SEC:SPEC_ACC[12]='1'
                   SEC:SPEC_ACC[12]=''
                   HIDE(?IMAGENOLATLAIDE)
                ELSE
                   SEC:SPEC_ACC[12]='1'
                   UNHIDE(?IMAGENOLATLAIDE)
                .
                DISPLAY
             .
           OF ?NOTMINUSI
             CASE EVENT()
             OF EVENT:Accepted
                IF SEC:SPEC_ACC[14]='1'
                   SEC:SPEC_ACC[14]=''
                   HIDE(?IMAGENOTMINUSI)
                ELSE
                   SEC:SPEC_ACC[14]='1'
                   UNHIDE(?IMAGENOTMINUSI)
                .
                DISPLAY
             .
           OF ?NOTMINRC
             CASE EVENT()
             OF EVENT:Accepted
                IF SEC:SPEC_ACC[15]='1'
                   SEC:SPEC_ACC[15]=''
                   HIDE(?IMAGENOTMINRC)
                ELSE
                   SEC:SPEC_ACC[15]='1'
                   UNHIDE(?IMAGENOTMINRC)
                .
                DISPLAY
             .
          .
        .
        close(screen:NOLIK)
        
      END
    OF ?FP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        open(screen:FP)
        LOOP I#=1 TO 25
          IF I# > FP_SK
             DISABLE(I#+1)
          .
        .
        IF FP_SK=0 THEN DISABLE(?ACCESS51).
        select(?option51,1)
        access=SEC:FP_ACC[1]
        display
        accept
          case field()
          of ?option51
             CASE EVENT()
             OF EVENT:Accepted
                access=SEC:FP_ACC[CHOICE(?option51)]
                DISPLAY
             .
          of ?access51
             IF CHOICE(?option51)
                SEC:FP_ACC[CHOICE(?option51)]=ACCESS
                DISPLAY
             .
          of ?okFP
             CASE EVENT()
             OF EVENT:Accepted
                break
             .
          .
        .
        close(screen:FP)
      END
    OF ?alga
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        open(screen:ALGA)
        LOOP I#=1 TO 15
          IF I# > ALGU_SK
             DISABLE(I#+1)
          .
        .
        IF ALGU_SK=0 THEN DISABLE(?ACCESS31).
        select(?option31,1)
        access=SEC:ALGA_ACC[1]
        display
        accept
          case field()
          of ?option31
             CASE EVENT()
             OF EVENT:Accepted
                access=SEC:ALGA_ACC[CHOICE(?option31)]
                DISPLAY
             .
          of ?access31
             IF CHOICE(?option31)
                SEC:ALGA_ACC[CHOICE(?option31)]=ACCESS
                DISPLAY
             .
          of ?okALGA
             CASE EVENT()
             OF EVENT:Accepted
                break
             .
          .
        .
        close(screen:ALGA)
      END
    OF ?pam
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        open(screen:PAM)
        LOOP I#=1 TO 15
          IF I# > PAM_SK
             DISABLE(I#+1)
          .
        .
        IF PAM_SK=0 THEN DISABLE(?ACCESS41).
        select(?option41,1)
        access=SEC:PAM_ACC[1]
        display
        accept
          case field()
          of ?option41
             CASE EVENT()
             OF EVENT:Accepted
                access=SEC:PAM_ACC[CHOICE(?option41)]
                DISPLAY
             .
          of ?access41
             IF CHOICE(?option41)
                SEC:PAM_ACC[CHOICE(?option41)]=ACCESS
                DISPLAY
             .
          of ?okPAM
             CASE EVENT()
             OF EVENT:Accepted
                break
             .
          .
        .
        close(screen:PAM)
      END
    OF ?LM
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        open(screen:LM)
        LOOP I#=1 TO 25
          IF I# > LM_SK
             DISABLE(I#+1)
          .
        .
        IF LM_SK=0 THEN DISABLE(?ACCESS61).
        select(?option61,1)
        access=SEC:LM_ACC[1]
        display
        accept
          case field()
          of ?option61
             CASE EVENT()
             OF EVENT:Accepted
                access=SEC:LM_ACC[CHOICE(?option61)]
                DISPLAY
             .
          of ?access61
             IF CHOICE(?option61)
                SEC:LM_ACC[CHOICE(?option61)]=ACCESS
                DISPLAY
             .
          of ?okLM
             CASE EVENT()
             OF EVENT:Accepted
                break
             .
          .
        .
        close(screen:LM)
      END
    OF ?SEC:START_NR
      CASE EVENT()
      OF EVENT:Accepted
        IF NOT INRANGE(SEC:START_NR,0,120)
          IF StandardWarning(Warn:OutOfRange,'SEC:START_NR','0 and 120')
            SELECT(?SEC:START_NR)
            QuickWindow{Prop:AcceptAll} = False
            CYCLE
          END
        END
      END
    OF ?SuperACC
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF SEC:SUPER_ACC='1'
           SEC:SUPER_ACC=''
           HIDE(?IMAGESUPER)
        ELSE
           SEC:SUPER_ACC='1'
           UNHIDE(?IMAGESUPER)
        .
        DISPLAY
      END
    OF ?AizliegtDatuApmainu
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF SEC:SPEC_ACC[1]='1'
           SEC:SPEC_ACC[1]=''
           HIDE(?ImageA_DAII)
        ELSE
           SEC:SPEC_ACC[1]='1'
           UNHIDE(?ImageA_DAII)
        .
        DISPLAY
      END
    OF ?AizliegtSelftestu
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF SEC:SPEC_ACC[8]='1'
           SEC:SPEC_ACC[8]=''
           HIDE(?ImageA_Self)
        ELSE
           SEC:SPEC_ACC[8]='1'
           UNHIDE(?IMAGEA_SELF)
        .
        DISPLAY
      END
    OF ?AizliegtNEAP
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF SEC:SPEC_ACC[9]='1'
           SEC:SPEC_ACC[9]=''
           HIDE(?ImageA_NEAP)
        ELSE
           SEC:SPEC_ACC[9]='1'
           UNHIDE(?IMAGEA_NEAP)
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
        SEC:ACC_KODS=ACC_kods
        SEC:ACC_DATUMS=today()
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
  IF PAROLES::Used = 0
    CheckOpen(PAROLES,1)
  END
  PAROLES::Used += 1
  BIND(SEC:RECORD)
  FilesOpened = True
  RISnap:PAROLES
  SAV::SEC:Record = SEC:Record
  IF LocalRequest = InsertRecord
    LocalResponse = RequestCompleted
    DO PrimeFields
    IF LocalResponse = RequestCancelled
      DO ProcedureReturn
    END
    LocalResponse = RequestCancelled
     IF ~COPYREQUEST
       SEC:FILES_ACC='N{8}'
       SEC:BASE_ACC='N{15}'
       SEC:ALGA_ACC='N{15}'
       SEC:PAM_ACC='N{15}'
       SEC:NOL_ACC='N{25}'
       SEC:FP_ACC='N{25}'
       SEC:LM_ACC='N{25}'
     .
  END
  IF LocalRequest = DeleteRecord
    IF StandardWarning(Warn:StandardDelete) = Button:OK
      LOOP
        LocalResponse = RequestCancelled
        SETCURSOR(Cursor:Wait)
        IF RIDelete:PAROLES()
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
  INIRestoreWindow('UpdateParoles','winlats.INI')
  WinResize.Resize
  ?SEC:U_NR{PROP:Alrt,255} = 734
  ?SEC:SECURE{PROP:Alrt,255} = 734
  ?SEC:PUBLISH{PROP:Alrt,255} = 734
  ?SEC:VUT{PROP:Alrt,255} = 734
  ?SEC:AMATS{PROP:Alrt,255} = 734
  ?SEC:FILES_ACC{PROP:Alrt,255} = 734
  ?SEC:BASE_ACC{PROP:Alrt,255} = 734
  ?SEC:NOL_ACC{PROP:Alrt,255} = 734
  ?SEC:FP_ACC{PROP:Alrt,255} = 734
  ?SEC:ALGA_ACC{PROP:Alrt,255} = 734
  ?SEC:PAM_ACC{PROP:Alrt,255} = 734
  ?SEC:LM_ACC{PROP:Alrt,255} = 734
  ?SEC:START_NR{PROP:Alrt,255} = 734
  ?SEC:ACC_KODS{PROP:Alrt,255} = 734
  ?SEC:ACC_DATUMS{PROP:Alrt,255} = 734
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
    PAROLES::Used -= 1
    IF PAROLES::Used = 0 THEN CLOSE(PAROLES).
  END
  IF WindowOpened
    INISaveWindow('UpdateParoles','winlats.INI')
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
    OF ?SEC:U_NR
      SEC:U_NR = History::SEC:Record.U_NR
    OF ?SEC:SECURE
      SEC:SECURE = History::SEC:Record.SECURE
    OF ?SEC:PUBLISH
      SEC:PUBLISH = History::SEC:Record.PUBLISH
    OF ?SEC:VUT
      SEC:VUT = History::SEC:Record.VUT
    OF ?SEC:AMATS
      SEC:AMATS = History::SEC:Record.AMATS
    OF ?SEC:FILES_ACC
      SEC:FILES_ACC = History::SEC:Record.FILES_ACC
    OF ?SEC:BASE_ACC
      SEC:BASE_ACC = History::SEC:Record.BASE_ACC
    OF ?SEC:NOL_ACC
      SEC:NOL_ACC = History::SEC:Record.NOL_ACC
    OF ?SEC:FP_ACC
      SEC:FP_ACC = History::SEC:Record.FP_ACC
    OF ?SEC:ALGA_ACC
      SEC:ALGA_ACC = History::SEC:Record.ALGA_ACC
    OF ?SEC:PAM_ACC
      SEC:PAM_ACC = History::SEC:Record.PAM_ACC
    OF ?SEC:LM_ACC
      SEC:LM_ACC = History::SEC:Record.LM_ACC
    OF ?SEC:START_NR
      SEC:START_NR = History::SEC:Record.START_NR
    OF ?SEC:ACC_KODS
      SEC:ACC_KODS = History::SEC:Record.ACC_KODS
    OF ?SEC:ACC_DATUMS
      SEC:ACC_DATUMS = History::SEC:Record.ACC_DATUMS
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
  SEC:Record = SAV::SEC:Record
  SAV::SEC:Record = SEC:Record
  Auto::Attempts = 0
  LOOP
    SET(SEC:NR_KEY)
    PREVIOUS(PAROLES)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAROLES')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE()
      Auto::Save:SEC:U_NR = 1
    ELSE
      Auto::Save:SEC:U_NR = SEC:U_NR + 1
    END
    SEC:Record = SAV::SEC:Record
    SEC:U_NR = Auto::Save:SEC:U_NR
    SAV::SEC:Record = SEC:Record
    ADD(PAROLES)
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
        DELETE(PAROLES)
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

