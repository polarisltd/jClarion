                     MEMBER('winlats.clw')        ! This is a MEMBER module
UpdatePar_A PROCEDURE


CurrentTab           STRING(80)
IsKlientsAddress     DECIMAL(1)
Seller               DECIMAL(1)
Payer                DECIMAL(1)
Buyer                DECIMAL(1)
IsKlientEDI          STRING(1)
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
History::ADR:Record LIKE(ADR:Record),STATIC
SAV::ADR:Record      LIKE(ADR:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:ADR:PAR_NR   LIKE(ADR:PAR_NR)
Auto::Save:ADR:ADR_NR   LIKE(ADR:ADR_NR)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the ADR_K File'),AT(,,265,194),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateADR_K'),SYSTEM,GRAY,RESIZE
                       SHEET,AT(4,6,258,170),USE(?CurrentTab)
                         TAB('Cita adrese '),USE(?Tab:1)
                           STRING(@n_9),AT(10,22),USE(ADR:PAR_NR)
                           STRING(@n3),AT(50,22),USE(ADR:ADR_NR)
                           ENTRY(@s60),AT(10,33,244,10),USE(ADR:ADRESE)
                           OPTION('Klients EDI (EDISOFT/TELEMA)'),AT(54,44,122,20),USE(IsKlientEDI),BOXED
                             RADIO('ne'),AT(66,53,45,9),USE(?IsKlientEDI:Radio1),VALUE('0')
                             RADIO('ja'),AT(116,53,43,9),USE(?IsKlientEDI:Radio2),VALUE('1')
                           END
                           OPTION('&Tips'),AT(11,68,234,20),USE(ADR:TIPS)
                             RADIO('File�les adrese'),AT(18,74,62,10),USE(?ADR:TIPS:Radio1),VALUE('F')
                             RADIO('Pasta adrese'),AT(81,74),USE(?ADR:TIPS:Radio2),VALUE('P')
                             RADIO('Veikala adrese'),AT(141,74,62,10),USE(?ADR:TIPS:Radio3),VALUE('V')
                             RADIO('Arh�vs'),AT(205,74,62,10),USE(?ADR:TIPS:Radio4),VALUE('A')
                           END
                           CHECK('Maks�t�js'),AT(18,99,100,12),USE(Payer),VALUE('1','0')
                           CHECK('Pirc�js'),AT(18,111,100,12),USE(Buyer),VALUE('1','0')
                           CHECK('Pieg�d�t�js'),AT(18,88,100,12),USE(Seller),VALUE('1','0')
                           OPTION,AT(10,65,234,20),USE(IsKlientsAddress)
                             RADIO('Klienta adrese'),AT(18,72,95,10),USE(?IsKlientsAddress:Radio1),VALUE('1')
                             RADIO('Pieg�des adrese'),AT(119,72),USE(?IsKlientsAddress:Radio2),VALUE('0')
                           END
                           PROMPT('Grupa:'),AT(11,125),USE(?ADR:GRUPA:Prompt)
                           ENTRY(@s6),AT(68,125,33,10),USE(ADR:GRUPA)
                           PROMPT('Kontaktpersona:'),AT(11,137),USE(?ADR:KONTAKTS:Prompt)
                           ENTRY(@s25),AT(68,137,109,10),USE(ADR:KONTAKTS)
                           PROMPT('Tele&fons:'),AT(11,149),USE(?ADR:TELEFAX:Prompt)
                           ENTRY(@s25),AT(68,149,108,10),USE(ADR:TELEFAX)
                           PROMPT('&Darba laiks:'),AT(11,162,46,9),USE(?ADR:DARBALAIKS:Prompt)
                           ENTRY(@s25),AT(68,161,108,10),USE(ADR:DARBALAIKS)
                         END
                       END
                       BUTTON('&OK'),AT(167,179,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(216,178,45,14),USE(?Cancel)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF ~ADR:TIPS
     ADR:TIPS='F'
  .
    if INSTRING(ADR:TIPS,'FPVA') OR ~ADR:TIPS
        IsKlientEDI = 0
    else
        IsKlientEdi = 1
        if INSTRING(ADR:TIPS,'8')  !piegades adrese
            IsKlientsAddress = 0
        else
            IsKlientsAddress = 1
            if ADR:TIPS = 1
                Seller = 1
                Payer = 1
                Buyer = 1
            elsif ADR:TIPS = 2
                Seller = 1
                Payer = 1
                Buyer = 0
            elsif ADR:TIPS = 3
                Seller = 0
                Payer = 1
                Buyer = 1
            elsif ADR:TIPS = 4
                Seller = 1
                Buyer = 1
                Payer = 0
            elsif ADR:TIPS = 5
                Seller = 1
                Payer = 0
                Buyer = 0
            elsif ADR:TIPS = 6
                Payer = 1
                Seller = 0
                Buyer = 0
            elsif ADR:TIPS = 7
                Buyer = 1
                Seller = 0
                Payer = 0
  
            end
        end
    end
  
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks main�ts'
  OF DeleteRecord
  END
  QuickWindow{Prop:Text} = ActionMessage
  ENABLE(TBarBrwHistory)
    if IsKlientEDI = 0
       HIDE(?IsKlientsAddress:Radio1)
       HIDE(?IsKlientsAddress:Radio2)
       UNHIDE(?ADR:TIPS:Radio1)
       UNHIDE(?ADR:TIPS:Radio2)
       UNHIDE(?ADR:TIPS:Radio3)
       UNHIDE(?ADR:TIPS:Radio4)
    else
       UNHIDE(?IsKlientsAddress:Radio1)
       UNHIDE(?IsKlientsAddress:Radio2)
       HIDE(?ADR:TIPS:Radio1)
       HIDE(?ADR:TIPS:Radio2)
       HIDE(?ADR:TIPS:Radio3)
       HIDE(?ADR:TIPS:Radio4)
    end
    if IsKlientsAddress = 1
       UNHIDE(?Buyer)
       UNHIDE(?Seller)
       UNHIDE(?Payer)
    else
       HIDE(?Buyer)
       HIDE(?Seller)
       HIDE(?Payer)
    end
  
  ACCEPT
!    stop('tip '&ADR:TIPS)
!    if IsKlientEDI = 1 AND IsKlientsAddress = 0
!       ADR:TIPS = 8
!    elsif IsKlientEDI = 1 AND IsKlientsAddress = 1
!       if Seller = 1 AND Payer = 1 AND Buyer = 1
!          ADR:TIPS = 1
!       elsif Seller = 1 AND Payer = 1
!          ADR:TIPS = 2
!       elsif Payer = 1 AND Buyer = 1
!          ADR:TIPS = 3
!       elsif Seller = 1 AND Buyer = 1
!          ADR:TIPS = 4
!       elsif Seller = 1
!          ADR:TIPS = 5
!       elsif Payer = 1
!          ADR:TIPS = 6
!       elsif Buyer = 1
!          ADR:TIPS = 7
!!   else
!!          ADR:TIPS='F'
!!          IsKlientEDI = 0
!!          stop('else')
!       end
!    elsif IsKlientEDI = 1
!       stop('IsKlientEDI = 1')
!       if INSTRING(ADR:TIPS,'FPVA')
!          IsKlientsAddress = 0
!          ADR:TIPS = 8
!       end
!    elsif IsKlientEDI = 0
!       stop('IsKlientEDI = 0')
!       if INSTRING(ADR:TIPS,'12345678')
!          ADR:TIPS='F'
!          IsKlientsAddress = 0
!       end
!    end
    IF IsKlientEDI = 1
       ?ADR:DARBALAIKS:Prompt{PROP:TEXT}='ILN/GLN:'
    ELSE                                 
       ?ADR:DARBALAIKS:Prompt{PROP:TEXT}='Darba laiks:'
    .
!    if IsKlientEDI = 0
!!       IsKlientsAddress = 0
!!       ADR:TIPS = 'F'
!       HIDE(?IsKlientsAddress:Radio1)
!       HIDE(?IsKlientsAddress:Radio2)
!       UNHIDE(?ADR:TIPS:Radio1)
!       UNHIDE(?ADR:TIPS:Radio2)
!       UNHIDE(?ADR:TIPS:Radio3)
!       UNHIDE(?ADR:TIPS:Radio4)
!    else
!!       IsKlientsAddress = 0
!!       ADR:TIPS = '8'
!       UNHIDE(?IsKlientsAddress:Radio1)
!       UNHIDE(?IsKlientsAddress:Radio2)
!       HIDE(?ADR:TIPS:Radio1)
!       HIDE(?ADR:TIPS:Radio2)
!       HIDE(?ADR:TIPS:Radio3)
!       HIDE(?ADR:TIPS:Radio4)
!    end
!    
!    if IsKlientsAddress = 1
!       UNHIDE(?Buyer)
!       UNHIDE(?Seller)
!       UNHIDE(?Payer)
!    else
!       HIDE(?Buyer)
!       HIDE(?Seller)
!       HIDE(?Payer)
!    end
!
!    IF ~ADR:TIPS
!       ADR:TIPS='F'
!       IsKlientEDI = 0
!       IsKlientsAddress = 0
!    .
!
!    
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
      SELECT(?ADR:PAR_NR)
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
        History::ADR:Record = ADR:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(PAR_A)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(ADR:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'ADR:NR_KEY')
                SELECT(?ADR:PAR_NR)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?ADR:PAR_NR)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::ADR:Record <> ADR:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:PAR_A(1)
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
              SELECT(?ADR:PAR_NR)
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
    OF ?IsKlientEDI
      CASE EVENT()
      OF EVENT:Accepted
    if IsKlientEDI = 1 AND IsKlientsAddress = 0
       ADR:TIPS = 8
    elsif IsKlientEDI = 1 AND IsKlientsAddress = 1
       if Seller = 1 AND Payer = 1 AND Buyer = 1
          ADR:TIPS = 1
       elsif Seller = 1 AND Payer = 1
          ADR:TIPS = 2
       elsif Payer = 1 AND Buyer = 1
          ADR:TIPS = 3
       elsif Seller = 1 AND Buyer = 1
          ADR:TIPS = 4
       elsif Seller = 1
          ADR:TIPS = 5
       elsif Payer = 1
          ADR:TIPS = 6
       elsif Buyer = 1
          ADR:TIPS = 7
!   else
!          ADR:TIPS='F'
!          IsKlientEDI = 0
!          stop('else')
       end
    elsif IsKlientEDI = 1
       if INSTRING(ADR:TIPS,'FPVA')
          IsKlientsAddress = 0
          ADR:TIPS = 8
       end
    elsif IsKlientEDI = 0
       if INSTRING(ADR:TIPS,'12345678')
          ADR:TIPS='F'
          IsKlientsAddress = 0
       end
    end
    DISPLAY
    IF IsKlientEDI = 1
       ?ADR:DARBALAIKS:Prompt{PROP:TEXT}='ILN:'
    ELSE                                 
       ?ADR:DARBALAIKS:Prompt{PROP:TEXT}='Darba laiks:'
    .
    if IsKlientEDI = 0
!       IsKlientsAddress = 0
!       ADR:TIPS = 'F'
       HIDE(?IsKlientsAddress:Radio1)
       HIDE(?IsKlientsAddress:Radio2)
       UNHIDE(?ADR:TIPS:Radio1)
       UNHIDE(?ADR:TIPS:Radio2)
       UNHIDE(?ADR:TIPS:Radio3)
       UNHIDE(?ADR:TIPS:Radio4)
    else
!       IsKlientsAddress = 0
!       ADR:TIPS = '8'
       UNHIDE(?IsKlientsAddress:Radio1)
       UNHIDE(?IsKlientsAddress:Radio2)
       HIDE(?ADR:TIPS:Radio1)
       HIDE(?ADR:TIPS:Radio2)
       HIDE(?ADR:TIPS:Radio3)
       HIDE(?ADR:TIPS:Radio4)
    end
    
    if IsKlientsAddress = 1
       UNHIDE(?Buyer)
       UNHIDE(?Seller)
       UNHIDE(?Payer)
    else
       HIDE(?Buyer)
       HIDE(?Seller)
       HIDE(?Payer)
    end

!    IF ~ADR:TIPS
!       ADR:TIPS='F'
!       IsKlientEDI = 0
!       IsKlientsAddress = 0
!    .

      END
    OF ?IsKlientEDI:Radio1
      CASE EVENT()
      OF EVENT:Accepted
         
      END
    OF ?IsKlientEDI:Radio2
      
      CASE EVENT()
      END
    OF ?Payer
      CASE EVENT()
      OF EVENT:Accepted
    if IsKlientEDI = 1 AND IsKlientsAddress = 0
       ADR:TIPS = 8
    elsif IsKlientEDI = 1 AND IsKlientsAddress = 1
       if Seller = 1 AND Payer = 1 AND Buyer = 1
          ADR:TIPS = 1
       elsif Seller = 1 AND Payer = 1
          ADR:TIPS = 2
       elsif Payer = 1 AND Buyer = 1
          ADR:TIPS = 3
       elsif Seller = 1 AND Buyer = 1
          ADR:TIPS = 4
       elsif Seller = 1
          ADR:TIPS = 5
       elsif Payer = 1
          ADR:TIPS = 6
       elsif Buyer = 1
          ADR:TIPS = 7
!   else
!          ADR:TIPS='F'
!          IsKlientEDI = 0
!          stop('else')
       end
    elsif IsKlientEDI = 1
       if INSTRING(ADR:TIPS,'FPVA')
          IsKlientsAddress = 0
          ADR:TIPS = 8
       end
    elsif IsKlientEDI = 0
       if INSTRING(ADR:TIPS,'12345678')
          ADR:TIPS='F'
          IsKlientsAddress = 0
       end
    end
    DISPLAY
    IF IsKlientEDI = 1
       ?ADR:DARBALAIKS:Prompt{PROP:TEXT}='ILN:'
    ELSE                                 
       ?ADR:DARBALAIKS:Prompt{PROP:TEXT}='Darba laiks:'
    .
    if IsKlientEDI = 0
!       IsKlientsAddress = 0
!       ADR:TIPS = 'F'
       HIDE(?IsKlientsAddress:Radio1)
       HIDE(?IsKlientsAddress:Radio2)
       UNHIDE(?ADR:TIPS:Radio1)
       UNHIDE(?ADR:TIPS:Radio2)
       UNHIDE(?ADR:TIPS:Radio3)
       UNHIDE(?ADR:TIPS:Radio4)
    else
!       IsKlientsAddress = 0
!       ADR:TIPS = '8'
       UNHIDE(?IsKlientsAddress:Radio1)
       UNHIDE(?IsKlientsAddress:Radio2)
       HIDE(?ADR:TIPS:Radio1)
       HIDE(?ADR:TIPS:Radio2)
       HIDE(?ADR:TIPS:Radio3)
       HIDE(?ADR:TIPS:Radio4)
    end
    
    if IsKlientsAddress = 1
       UNHIDE(?Buyer)
       UNHIDE(?Seller)
       UNHIDE(?Payer)
    else
       HIDE(?Buyer)
       HIDE(?Seller)
       HIDE(?Payer)
    end

!    IF ~ADR:TIPS
!       ADR:TIPS='F'
!       IsKlientEDI = 0
!       IsKlientsAddress = 0
!    .

      END
    OF ?Buyer
      CASE EVENT()
      OF EVENT:Accepted
    if IsKlientEDI = 1 AND IsKlientsAddress = 0
       ADR:TIPS = 8
    elsif IsKlientEDI = 1 AND IsKlientsAddress = 1
       if Seller = 1 AND Payer = 1 AND Buyer = 1
          ADR:TIPS = 1
       elsif Seller = 1 AND Payer = 1
          ADR:TIPS = 2
       elsif Payer = 1 AND Buyer = 1
          ADR:TIPS = 3
       elsif Seller = 1 AND Buyer = 1
          ADR:TIPS = 4
       elsif Seller = 1
          ADR:TIPS = 5
       elsif Payer = 1
          ADR:TIPS = 6
       elsif Buyer = 1
          ADR:TIPS = 7
!   else
!          ADR:TIPS='F'
!          IsKlientEDI = 0
!          stop('else')
       end
    elsif IsKlientEDI = 1
       if INSTRING(ADR:TIPS,'FPVA')
          IsKlientsAddress = 0
          ADR:TIPS = 8
       end
    elsif IsKlientEDI = 0
       if INSTRING(ADR:TIPS,'12345678')
          ADR:TIPS='F'
          IsKlientsAddress = 0
       end
    end
    DISPLAY
    IF IsKlientEDI = 1
       ?ADR:DARBALAIKS:Prompt{PROP:TEXT}='ILN:'
    ELSE                                 
       ?ADR:DARBALAIKS:Prompt{PROP:TEXT}='Darba laiks:'
    .
    if IsKlientEDI = 0
!       IsKlientsAddress = 0
!       ADR:TIPS = 'F'
       HIDE(?IsKlientsAddress:Radio1)
       HIDE(?IsKlientsAddress:Radio2)
       UNHIDE(?ADR:TIPS:Radio1)
       UNHIDE(?ADR:TIPS:Radio2)
       UNHIDE(?ADR:TIPS:Radio3)
       UNHIDE(?ADR:TIPS:Radio4)
    else
!       IsKlientsAddress = 0
!       ADR:TIPS = '8'
       UNHIDE(?IsKlientsAddress:Radio1)
       UNHIDE(?IsKlientsAddress:Radio2)
       HIDE(?ADR:TIPS:Radio1)
       HIDE(?ADR:TIPS:Radio2)
       HIDE(?ADR:TIPS:Radio3)
       HIDE(?ADR:TIPS:Radio4)
    end
    
    if IsKlientsAddress = 1
       UNHIDE(?Buyer)
       UNHIDE(?Seller)
       UNHIDE(?Payer)
    else
       HIDE(?Buyer)
       HIDE(?Seller)
       HIDE(?Payer)
    end

!    IF ~ADR:TIPS
!       ADR:TIPS='F'
!       IsKlientEDI = 0
!       IsKlientsAddress = 0
!    .

      END
    OF ?Seller
      CASE EVENT()
      OF EVENT:Accepted
    if IsKlientEDI = 1 AND IsKlientsAddress = 0
       ADR:TIPS = 8
    elsif IsKlientEDI = 1 AND IsKlientsAddress = 1
       if Seller = 1 AND Payer = 1 AND Buyer = 1
          ADR:TIPS = 1
       elsif Seller = 1 AND Payer = 1
          ADR:TIPS = 2
       elsif Payer = 1 AND Buyer = 1
          ADR:TIPS = 3
       elsif Seller = 1 AND Buyer = 1
          ADR:TIPS = 4
       elsif Seller = 1
          ADR:TIPS = 5
       elsif Payer = 1
          ADR:TIPS = 6
       elsif Buyer = 1
          ADR:TIPS = 7
!   else
!          ADR:TIPS='F'
!          IsKlientEDI = 0
!          stop('else')
       end
    elsif IsKlientEDI = 1
       if INSTRING(ADR:TIPS,'FPVA')
          IsKlientsAddress = 0
          ADR:TIPS = 8
       end
    elsif IsKlientEDI = 0
       if INSTRING(ADR:TIPS,'12345678')
          ADR:TIPS='F'
          IsKlientsAddress = 0
       end
    end
    DISPLAY
    IF IsKlientEDI = 1
       ?ADR:DARBALAIKS:Prompt{PROP:TEXT}='ILN:'
    ELSE                                 
       ?ADR:DARBALAIKS:Prompt{PROP:TEXT}='Darba laiks:'
    .
    if IsKlientEDI = 0
!       IsKlientsAddress = 0
!       ADR:TIPS = 'F'
       HIDE(?IsKlientsAddress:Radio1)
       HIDE(?IsKlientsAddress:Radio2)
       UNHIDE(?ADR:TIPS:Radio1)
       UNHIDE(?ADR:TIPS:Radio2)
       UNHIDE(?ADR:TIPS:Radio3)
       UNHIDE(?ADR:TIPS:Radio4)
    else
!       IsKlientsAddress = 0
!       ADR:TIPS = '8'
       UNHIDE(?IsKlientsAddress:Radio1)
       UNHIDE(?IsKlientsAddress:Radio2)
       HIDE(?ADR:TIPS:Radio1)
       HIDE(?ADR:TIPS:Radio2)
       HIDE(?ADR:TIPS:Radio3)
       HIDE(?ADR:TIPS:Radio4)
    end
    
    if IsKlientsAddress = 1
       UNHIDE(?Buyer)
       UNHIDE(?Seller)
       UNHIDE(?Payer)
    else
       HIDE(?Buyer)
       HIDE(?Seller)
       HIDE(?Payer)
    end

!    IF ~ADR:TIPS
!       ADR:TIPS='F'
!       IsKlientEDI = 0
!       IsKlientsAddress = 0
!    .

      END
    OF ?IsKlientsAddress
      CASE EVENT()
      OF EVENT:Accepted
    if IsKlientEDI = 1 AND IsKlientsAddress = 0
       ADR:TIPS = 8
    elsif IsKlientEDI = 1 AND IsKlientsAddress = 1
       if Seller = 1 AND Payer = 1 AND Buyer = 1
          ADR:TIPS = 1
       elsif Seller = 1 AND Payer = 1
          ADR:TIPS = 2
       elsif Payer = 1 AND Buyer = 1
          ADR:TIPS = 3
       elsif Seller = 1 AND Buyer = 1
          ADR:TIPS = 4
       elsif Seller = 1
          ADR:TIPS = 5
       elsif Payer = 1
          ADR:TIPS = 6
       elsif Buyer = 1
          ADR:TIPS = 7
!   else
!          ADR:TIPS='F'
!          IsKlientEDI = 0
!          stop('else')
       end
    elsif IsKlientEDI = 1
       if INSTRING(ADR:TIPS,'FPVA')
          IsKlientsAddress = 0
          ADR:TIPS = 8
       end
    elsif IsKlientEDI = 0
       if INSTRING(ADR:TIPS,'12345678')
          ADR:TIPS='F'
          IsKlientsAddress = 0
       end
    end
    DISPLAY
    IF IsKlientEDI = 1
       ?ADR:DARBALAIKS:Prompt{PROP:TEXT}='ILN:'
    ELSE                                 
       ?ADR:DARBALAIKS:Prompt{PROP:TEXT}='Darba laiks:'
    .
    if IsKlientEDI = 0
!       IsKlientsAddress = 0
!       ADR:TIPS = 'F'
       HIDE(?IsKlientsAddress:Radio1)
       HIDE(?IsKlientsAddress:Radio2)
       UNHIDE(?ADR:TIPS:Radio1)
       UNHIDE(?ADR:TIPS:Radio2)
       UNHIDE(?ADR:TIPS:Radio3)
       UNHIDE(?ADR:TIPS:Radio4)
    else
!       IsKlientsAddress = 0
!       ADR:TIPS = '8'
       UNHIDE(?IsKlientsAddress:Radio1)
       UNHIDE(?IsKlientsAddress:Radio2)
       HIDE(?ADR:TIPS:Radio1)
       HIDE(?ADR:TIPS:Radio2)
       HIDE(?ADR:TIPS:Radio3)
       HIDE(?ADR:TIPS:Radio4)
    end
    
    if IsKlientsAddress = 1
       UNHIDE(?Buyer)
       UNHIDE(?Seller)
       UNHIDE(?Payer)
    else
       HIDE(?Buyer)
       HIDE(?Seller)
       HIDE(?Payer)
    end

!    IF ~ADR:TIPS
!       ADR:TIPS='F'
!       IsKlientEDI = 0
!       IsKlientsAddress = 0
!    .

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
  IF PAR_A::Used = 0
    CheckOpen(PAR_A,1)
  END
  PAR_A::Used += 1
  BIND(ADR:RECORD)
  FilesOpened = True
  RISnap:PAR_A
  SAV::ADR:Record = ADR:Record
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
        IF RIDelete:PAR_A()
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
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('UpdatePar_A','winlats.INI')
  WinResize.Resize
  ?ADR:PAR_NR{PROP:Alrt,255} = 734
  ?ADR:ADR_NR{PROP:Alrt,255} = 734
  ?ADR:ADRESE{PROP:Alrt,255} = 734
  ?ADR:TIPS{PROP:Alrt,255} = 734
  ?ADR:GRUPA{PROP:Alrt,255} = 734
  ?ADR:KONTAKTS{PROP:Alrt,255} = 734
  ?ADR:TELEFAX{PROP:Alrt,255} = 734
  ?ADR:DARBALAIKS{PROP:Alrt,255} = 734
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
    PAR_A::Used -= 1
    IF PAR_A::Used = 0 THEN CLOSE(PAR_A).
  END
  IF WindowOpened
    INISaveWindow('UpdatePar_A','winlats.INI')
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
    OF ?ADR:PAR_NR
      ADR:PAR_NR = History::ADR:Record.PAR_NR
    OF ?ADR:ADR_NR
      ADR:ADR_NR = History::ADR:Record.ADR_NR
    OF ?ADR:ADRESE
      ADR:ADRESE = History::ADR:Record.ADRESE
    OF ?ADR:TIPS
      ADR:TIPS = History::ADR:Record.TIPS
    OF ?ADR:GRUPA
      ADR:GRUPA = History::ADR:Record.GRUPA
    OF ?ADR:KONTAKTS
      ADR:KONTAKTS = History::ADR:Record.KONTAKTS
    OF ?ADR:TELEFAX
      ADR:TELEFAX = History::ADR:Record.TELEFAX
    OF ?ADR:DARBALAIKS
      ADR:DARBALAIKS = History::ADR:Record.DARBALAIKS
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
  ADR:Record = SAV::ADR:Record
  SAV::ADR:Record = ADR:Record
  Auto::Attempts = 0
  LOOP
    Auto::Save:ADR:PAR_NR = ADR:PAR_NR
    CLEAR(ADR:ADR_NR,1)
    SET(ADR:NR_KEY,ADR:NR_KEY)
    PREVIOUS(PAR_A)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAR_A')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE() |
    OR Auto::Save:ADR:PAR_NR <> ADR:PAR_NR
      Auto::Save:ADR:ADR_NR = 1
    ELSE
      Auto::Save:ADR:ADR_NR = ADR:ADR_NR + 1
    END
    ADR:Record = SAV::ADR:Record
    ADR:ADR_NR = Auto::Save:ADR:ADR_NR
    SAV::ADR:Record = ADR:Record
    ADD(PAR_A)
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
        DELETE(PAR_A)
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

BrowsePAR_A PROCEDURE


CurrentTab           STRING(80)
LocalRequest         LONG
OriginalRequest      LONG
LocalResponse        LONG
FilesOpened          LONG
WindowOpened         LONG
WindowInitialized    LONG
ForceRefresh         LONG
RecordFiltered       LONG

BRW1::View:Browse    VIEW(PAR_A)
                       PROJECT(ADR:TIPS)
                       PROJECT(ADR:ADRESE)
                       PROJECT(ADR:PAR_NR)
                       PROJECT(ADR:ADR_NR)
                     END

Queue:Browse:1       QUEUE,PRE()                  ! Browsing Queue
BRW1::ADR:TIPS         LIKE(ADR:TIPS)             ! Queue Display field
BRW1::ADR:ADRESE       LIKE(ADR:ADRESE)           ! Queue Display field
BRW1::ADR:PAR_NR       LIKE(ADR:PAR_NR)           ! Queue Display field
BRW1::ADR:ADR_NR       LIKE(ADR:ADR_NR)           ! Queue Display field
BRW1::Mark             BYTE                       ! Queue POSITION information
BRW1::Position         STRING(512)                ! Queue POSITION information
                     END                          ! END (Browsing Queue)
BRW1::CurrentScroll  BYTE                         ! Queue position of scroll thumb
BRW1::ScrollRecordCount LONG                      ! Queue position of scroll thumb
BRW1::SkipFirst      BYTE                         ! Skip first retrieved record in page fill
BRW1::Sort1:Reset:PAR:U_NR LIKE(PAR:U_NR)
BRW1::Sort2:KeyDistribution LIKE(ADR:ADR_NR),DIM(100)
BRW1::Sort2:LowValue LIKE(ADR:ADR_NR)             ! Queue position of scroll thumb
BRW1::Sort2:HighValue LIKE(ADR:ADR_NR)            ! Queue position of scroll thumb
BRW1::Sort2:Reset:PAR:U_NR LIKE(PAR:U_NR)
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
QuickWindow          WINDOW('Browse the ADR_K File'),AT(,,250,193),FONT('MS Sans Serif',9,,FONT:bold),CENTER,IMM,HLP('BrowseADR_K'),SYSTEM,GRAY,RESIZE
                       STRING('Juridisk� adrese :'),AT(33,1),USE(?String2)
                       LIST,AT(8,25,233,124),USE(?Browse:1),IMM,VSCROLL,MSG('Browsing Records'),FORMAT('19C(2)|M~Tips~C(0)@s1@80L(2)|M~Adrese~@s60@'),FROM(Queue:Browse:1)
                       BUTTON('Iz&v�l�ties citu  '),AT(52,174,124,14),USE(?Select:2),FONT(,,COLOR:Navy,,CHARSET:ANSI),DEFAULT
                       BUTTON('&Ievad�t'),AT(85,153,45,14),USE(?Insert:3)
                       BUTTON('&Main�t'),AT(134,153,45,14),USE(?Change:3),DEFAULT
                       BUTTON('&Dz�st'),AT(183,153,45,14),USE(?Delete:3)
                       BUTTON('Visa&s'),AT(4,174,46,14),USE(?visas),HIDE,DEFAULT
                       SHEET,AT(4,9,241,162),USE(?CurrentTab)
                         TAB('Citas'),USE(?Tab:2)
                         END
                         TAB('ar� Arh�vs'),USE(?Tab:3)
                         END
                       END
                       STRING(@s60),AT(68,10,172,10),USE(PAR:ADRESE)
                       BUTTON('&Beigt'),AT(178,174,68,14),USE(?Close)
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
  IF LOCALREQUEST=SELECTRECORD
     IF INRANGE(JOB_NR,1,15)                 !BASE
        ?Change:3{PROP:DEFAULT}=''
        ?Select:2{PROP:DEFAULT}='1'
        ?Select:2{PROP:TEXT}='Iz&v�l�ties citu k� pasta ardesi'
        ?close{prop:TEXT}='&Atst�t juridisko'
     ELSIF INRANGE(JOB_NR,16,40)             !NOL
        ?Change:3{PROP:DEFAULT}=''
        ?Select:2{PROP:DEFAULT}='1'
        ?Select:2{PROP:TEXT}='Iz&v�l�ties citu k� izkrau�anas vietu'
        ?close{prop:TEXT}='&Atst�t juridisko'
        IF ADR_NR=999999999
           UNHIDE(?VISAS)
        .
     .
  .
  ACCEPT
    CASE EVENT()
    OF EVENT:CloseDown
      WinResize.Destroy
    OF EVENT:OpenWindow
      QuickWindow{PROP:TEXT}=PAR:NOS_P
      DO BRW1::AssignButtons
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
        DO SelectDispatch
      END
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
    OF ?Select:2
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCompleted
        POST(Event:CloseWindow)
        ADR_NR=ADR:ADR_NR
      END
    OF ?Insert:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonInsert
      END
    OF ?Change:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonChange
      END
    OF ?Delete:3
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        DO BRW1::ButtonDelete
      END
    OF ?visas
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        ADR_NR=999999999
        LOCALRESPONSE=REQUESTCOMPLETED
        BREAK
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
    OF ?Close
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        LocalResponse = RequestCancelled
        POST(Event:CloseWindow)
        ADR_NR=0
      END
    END
  END
  DO ProcedureReturn
!---------------------------------------------------------------------------
PrepareProcedure ROUTINE
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
  FilesOpened = True
  OPEN(QuickWindow)
  WindowOpened=True
  QuickWindow{PROP:MinWidth}=QuickWindow{PROP:Width}
  QuickWindow{PROP:MinHeight}=QuickWindow{PROP:Height}
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('BrowsePAR_A','winlats.INI')
  WinResize.Resize
  BRW1::AddQueue = True
  BRW1::RecordCount = 0
  IF LocalRequest <> SelectRecord
    ?Select:2{Prop:Hide} = True
    DISABLE(?Select:2)
  ELSE
  END
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,252} = MouseLeft2
  ?Browse:1{Prop:Alrt,255} = InsertKey
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
    PAR_A::Used -= 1
    IF PAR_A::Used = 0 THEN CLOSE(PAR_A).
    PAR_K::Used -= 1
    IF PAR_K::Used = 0 THEN CLOSE(PAR_K).
  END
  IF WindowOpened
    INISaveWindow('BrowsePAR_A','winlats.INI')
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

SelectDispatch ROUTINE
  IF ACCEPTED()=TBarBrwSelect THEN         !trap remote browse select control calls
    POST(EVENT:ACCEPTED,BrowseButtons.SelectButton)
  END

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
  IF CHOICE(?CURRENTTAB)=2
    BRW1::SortOrder = 1
  ELSE
    BRW1::SortOrder = 2
  END
  IF BRW1::SortOrder = BRW1::LastSortOrder
    CASE BRW1::SortOrder
    OF 1
      IF BRW1::Sort1:Reset:PAR:U_NR <> PAR:U_NR
        BRW1::Changed = True
      END
    OF 2
      IF BRW1::Sort2:Reset:PAR:U_NR <> PAR:U_NR
        BRW1::Changed = True
      END
    END
  ELSE
  END
  IF BRW1::SortOrder <> BRW1::LastSortOrder OR BRW1::Changed OR ForceRefresh
    CASE BRW1::SortOrder
    OF 1
      BRW1::Sort1:Reset:PAR:U_NR = PAR:U_NR
    OF 2
      BRW1::Sort2:Reset:PAR:U_NR = PAR:U_NR
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
      StandardWarning(Warn:RecordFetchError,'PAR_A')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:HighValue = ADR:ADR_NR
  END
  DO BRW1::Reset
  NEXT(BRW1::View:Browse)
  IF ERRORCODE()
    IF ERRORCODE() = BadRecErr
      DO BRW1::RestoreResetValues
    ELSE
      StandardWarning(Warn:RecordFetchError,'PAR_A')
      POST(Event:CloseWindow)
    END
    EXIT
  END
  CASE BRW1::SortOrder
  OF 2
    BRW1::Sort2:LowValue = ADR:ADR_NR
    SetupRealStops(BRW1::Sort2:LowValue,BRW1::Sort2:HighValue)
    LOOP BRW1::ScrollRecordCount = 1 TO 100
      BRW1::Sort2:KeyDistribution[BRW1::ScrollRecordCount] = NextRealStop()
    END
  END
!----------------------------------------------------------------------
BRW1::FillBuffer ROUTINE
!|
!| This routine fills the record buffer from the BrowseBox queue. This gives the appearance
!| that the record is "fresh" from the disk, without the disk access required.
!|
  ADR:TIPS = BRW1::ADR:TIPS
  ADR:ADRESE = BRW1::ADR:ADRESE
  ADR:PAR_NR = BRW1::ADR:PAR_NR
  ADR:ADR_NR = BRW1::ADR:ADR_NR
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
  BRW1::ADR:TIPS = ADR:TIPS
  BRW1::ADR:ADRESE = ADR:ADRESE
  BRW1::ADR:PAR_NR = ADR:PAR_NR
  BRW1::ADR:ADR_NR = ADR:ADR_NR
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
      IF LocalRequest = SelectRecord
        BRW1::PopupText = 'Iz&v�l�ties citu  '
      ELSE
        BRW1::PopupText = '~Iz&v�l�ties citu  '
      END
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievad�t|&Main�t|&Dz�st|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievad�t|&Main�t|&Dz�st'
      END
    ELSE
      BRW1::PopupText = '~Iz&v�l�ties citu  '
      IF BRW1::PopupText
        BRW1::PopupText = '&Ievad�t|~&Main�t|~&Dz�st|-|' & BRW1::PopupText
      ELSE
        BRW1::PopupText = '&Ievad�t|~&Main�t|~&Dz�st'
      END
    END
    EXECUTE(POPUP(BRW1::PopupText))
      POST(Event:Accepted,?Insert:3)
      POST(Event:Accepted,?Change:3)
      POST(Event:Accepted,?Delete:3)
      POST(Event:Accepted,?Select:2)
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
      OF 2
        LOOP BRW1::CurrentScroll = 1 TO 100
          IF BRW1::Sort2:KeyDistribution[BRW1::CurrentScroll] => ADR:ADR_NR
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
  OF 1
    BRW1::CurrentScroll = 50                      ! Move Thumb to center
    IF BRW1::RecordCount = ?Browse:1{Prop:Items}
      IF BRW1::ItemsToFill
        IF BRW1::CurrentEvent = Event:ScrollUp
          BRW1::CurrentScroll = 0
        ELSE
          BRW1::CurrentScroll = 100
        END
      END
    ELSE
      BRW1::CurrentScroll = 0
    END
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
      IF LocalRequest = SelectRecord
        POST(Event:Accepted,?Select:2)
        EXIT
      END
      POST(Event:Accepted,?Change:3)
      DO BRW1::FillBuffer
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
    OF DeleteKey
      POST(Event:Accepted,?Delete:3)
    OF CtrlEnter
      POST(Event:Accepted,?Change:3)
    ELSE                                          ! ELSE (What keycode was hit)
      CASE BRW1::SortOrder
      OF 1
        IF CHR(KEYCHAR())
          IF UPPER(SUB(ADR:ADR_NR,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(ADR:ADR_NR,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            ADR:ADR_NR = CHR(KEYCHAR())
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      OF 2
        IF CHR(KEYCHAR())
          IF UPPER(SUB(ADR:ADR_NR,1,1)) = UPPER(CHR(KEYCHAR()))
            BRW1::CurrentEvent = EVENT:ScrollDown
            DO BRW1::ScrollOne
            GET(Queue:Browse:1,BRW1::CurrentChoice)
            DO BRW1::FillBuffer
          END
          IF UPPER(SUB(ADR:ADR_NR,1,1)) = UPPER(CHR(KEYCHAR()))
            ?Browse:1{Prop:SelStart} = BRW1::CurrentChoice
          ELSE
            ADR:ADR_NR = CHR(KEYCHAR())
            BRW1::LocateMode = LocateOnValue
            DO BRW1::LocateRecord
          END
        END
      END
    END                                           ! END (What keycode was hit)
  ELSE
    CASE KEYCODE()                                ! What keycode was hit
    OF InsertKey
      POST(Event:Accepted,?Insert:3)
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
    OF 2
      ADR:ADR_NR = BRW1::Sort2:KeyDistribution[?Browse:1{Prop:VScrollPos}]
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
        StandardWarning(Warn:RecordFetchError,'PAR_A')
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
      BRW1::HighlightedPosition = POSITION(ADR:NR_KEY)
      RESET(ADR:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      ADR:PAR_NR = PAR:U_NR
      SET(ADR:NR_KEY,ADR:NR_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'ADR:PAR_NR = PAR:U_NR'
  OF 2
    IF BRW1::LocateMode = LocateOnEdit
      BRW1::HighlightedPosition = POSITION(ADR:NR_KEY)
      RESET(ADR:NR_KEY,BRW1::HighlightedPosition)
    ELSE
      ADR:PAR_NR = PAR:U_NR
      SET(ADR:NR_KEY,ADR:NR_KEY)
    END
    BRW1::View:Browse{Prop:Filter} = |
    'ADR:PAR_NR = PAR:U_NR AND (~(ADR:TIPS=''A''))'
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
    ?Change:3{Prop:Disable} = 0
    ?Delete:3{Prop:Disable} = 0
  ELSE
    CLEAR(ADR:Record)
    BRW1::CurrentChoice = 0
    ?Change:3{Prop:Disable} = 1
    ?Delete:3{Prop:Disable} = 1
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
    ADR:PAR_NR = PAR:U_NR
    SET(ADR:NR_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'ADR:PAR_NR = PAR:U_NR'
  OF 2
    ADR:PAR_NR = PAR:U_NR
    SET(ADR:NR_KEY)
    BRW1::View:Browse{Prop:Filter} = |
    'ADR:PAR_NR = PAR:U_NR AND (~(ADR:TIPS=''A''))'
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
    PAR:U_NR = BRW1::Sort1:Reset:PAR:U_NR
  OF 2
    PAR:U_NR = BRW1::Sort2:Reset:PAR:U_NR
  END
BRW1::AssignButtons ROUTINE
  CLEAR(BrowseButtons)
  BrowseButtons.ListBox=?Browse:1
  BrowseButtons.SelectButton=?Select:2
  BrowseButtons.InsertButton=?Insert:3
  BrowseButtons.ChangeButton=?Change:3
  BrowseButtons.DeleteButton=?Delete:3
  DO DisplayBrowseToolbar
!--------------------------------------------------------------------------
DisplayBrowseToolbar      ROUTINE
  ENABLE(TBarBrwBottom,TBarBrwLocate)
    IF BrowseButtons.SelectButton THEN
      TBarBrwSelect{PROP:DISABLE}=BrowseButtons.SelectButton{PROP:DISABLE}
    END
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
BRW1::ButtonInsert ROUTINE
!|
!| This routine calls the BrowseBox's update procedure (as specified in the
!| BrowseUpdateButtons control template) to insert a new record.
!|
!| First, the primary file's record  buffer is cleared, as well as any memos
!| or BLOBs. Next, any range-limit values are restored so that the inserted
!| record defaults to being added to the current display set.
!|
!| Next, LocalRequest is set to InsertRecord, and the BRW1::CallRecord routine
!| is called. This routine performs the actual call to the update procedure.
!|
!| If the insert is successful (GlobalRequest = RequestCompleted) then the newly added
!| record is displayed in the BrowseBox, at the top of the listbox.
!|
!| If the insert is not successful, the current page of the browse is refreshed.
!|
!| Finally, The BrowseBox is re-initialized, resetting scroll bars and totals.
!|
  GET(PAR_A,0)
  CLEAR(ADR:Record,0)
  CASE BRW1::SortOrder
  OF 1
    ADR:PAR_NR = BRW1::Sort1:Reset:PAR:U_NR
  OF 2
    ADR:PAR_NR = BRW1::Sort2:Reset:PAR:U_NR
  END
  LocalRequest = InsertRecord
  DO BRW1::CallUpdate
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
!| (UpdatePar_A) is called.
!|
!| Upon return from the update, the routine BRW1::Reset is called to reset the VIEW
!| and reopen it.
!|
  EXECUTE CHECKACCESS(LOCALREQUEST,ATLAUTS[2])
     EXIT
     LOCALREQUEST=0
     LOCALREQUEST=LOCALREQUEST
  .
  CLOSE(BRW1::View:Browse)
  LOOP
    GlobalRequest = LocalRequest
    VCRRequest = VCRNone
    UpdatePar_A
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
        GET(PAR_A,0)
        CLEAR(ADR:Record,0)
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


UpdatePAR_E PROCEDURE


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
EMA_EMAIL            STRING(35)
Update::Reloop  BYTE
Update::Error   BYTE
History::EMA:Record LIKE(EMA:Record),STATIC
SAV::EMA:Record      LIKE(EMA:Record)
Auto::Attempts       LONG,AUTO
Auto::Save:EMA:PAR_NR   LIKE(EMA:PAR_NR)
Auto::Save:EMA:EMA_NR   LIKE(EMA:EMA_NR)
ToolBarMode     UNSIGNED,AUTO
WindowXPos      SIGNED,AUTO,STATIC
WindowYPos      SIGNED,AUTO,STATIC
WindowPosInit   BOOL(False),STATIC
WinResize            WindowResizeType
QuickWindow          WINDOW('Update the PAR_E File'),AT(,,270,141),FONT('MS Sans Serif',9,,FONT:bold),IMM,HLP('UpdateADR_K'),SYSTEM,GRAY,RESIZE
                       SHEET,AT(4,6,258,110),USE(?CurrentTab)
                         TAB('Cits e-pasts'),USE(?Tab:1)
                           STRING(@n3),AT(220,27),USE(EMA:EMA_NR)
                           PROMPT('&e-pasts:'),AT(33,51),USE(?EMA:EMAILS:Prompt)
                           ENTRY(@s35),AT(89,49,139,10),USE(EMA_EMAIL),LEFT
                           PROMPT('&Piez�mes:'),AT(33,64),USE(?EMA:AMATS:Prompt)
                           ENTRY(@s20),AT(89,62,89,10),USE(EMA:AMATS)
                           PROMPT('&Kontaktpersona:'),AT(33,77),USE(?EMA:KONTAKTS:Prompt)
                           ENTRY(@s20),AT(89,75,90,10),USE(EMA:KONTAKTS)
                         END
                       END
                       BUTTON('&OK'),AT(167,119,45,14),USE(?OK),DEFAULT
                       BUTTON('&Atlikt'),AT(216,119,45,14),USE(?Cancel)
                     END
  CODE
  PUSHBIND
  LocalRequest = GlobalRequest
  OriginalRequest = GlobalRequest
  LocalResponse = RequestCancelled
  ForceRefresh = False
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  IF ~ADR:TIPS
     ADR:TIPS='F'
  .
  IF KEYCODE() = MouseRight
    SETKEYCODE(0)
  END
  DO PrepareProcedure
  EMA_EMAIL=CLIP(EMA:EMAIL)&EMA:KONTAKTS[21:25]
  CASE LocalRequest
  OF InsertRecord
    ActionMessage = 'Ieraksts tiks pievienots'
  OF ChangeRecord
    ActionMessage = 'Ieraksts tiks main�ts'
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
      SELECT(?EMA:EMA_NR)
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
        History::EMA:Record = EMA:Record
        CASE LocalRequest
        OF InsertRecord
          PUT(PAR_E)
          CASE ERRORCODE()
          OF NoError
            LocalResponse = RequestCompleted
            POST(Event:CloseWindow)
          OF DupKeyErr
            IF DUPLICATE(EMA:NR_KEY)
              IF StandardWarning(Warn:DuplicateKey,'EMA:NR_KEY')
                SELECT(?EMA:EMA_NR)
                VCRRequest = VCRNone
                CYCLE
              END
            END
          ELSE
            IF StandardWarning(Warn:InsertError)
              SELECT(?EMA:EMA_NR)
              VCRRequest = VCRNone
              CYCLE
            END
          END
        OF ChangeRecord
          LOOP
            LocalResponse = RequestCancelled
            SETCURSOR(Cursor:Wait)
            RecordChanged=false
            IF SAV::EMA:Record <> EMA:Record
              RecordChanged = True
            END
            IF RecordChanged THEN
              Update::Error = RIUpdate:PAR_E(1)
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
              SELECT(?EMA:EMA_NR)
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
    OF ?OK
      CASE EVENT()
      OF EVENT:Accepted
        DO SyncWindow
        IF OriginalRequest = ChangeRecord OR OriginalRequest = InsertRecord
          SELECT()
        ELSE
          POST(EVENT:Completed)
        END
        EMA:EMAIL=EMA_EMAIL[1:30]
        EMA:KONTAKTS[21:25]=EMA_EMAIL[31:35]
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
  IF PAR_E::Used = 0
    CheckOpen(PAR_E,1)
  END
  PAR_E::Used += 1
  BIND(EMA:RECORD)
  FilesOpened = True
  RISnap:PAR_E
  SAV::EMA:Record = EMA:Record
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
        IF RIDelete:PAR_E()
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
  WinResize.Initialize(AppStrat:Spread)
  INIRestoreWindow('UpdatePAR_E','winlats.INI')
  WinResize.Resize
  ?EMA:EMA_NR{PROP:Alrt,255} = 734
  ?EMA_EMAIL{PROP:Alrt,255} = 734
  ?EMA:AMATS{PROP:Alrt,255} = 734
  ?EMA:KONTAKTS{PROP:Alrt,255} = 734
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
    PAR_E::Used -= 1
    IF PAR_E::Used = 0 THEN CLOSE(PAR_E).
  END
  IF WindowOpened
    INISaveWindow('UpdatePAR_E','winlats.INI')
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
    OF ?EMA:EMA_NR
      EMA:EMA_NR = History::EMA:Record.EMA_NR
    OF ?EMA_EMAIL
      EMA_EMAIL = History::EMA:Record.EMAIL
    OF ?EMA:AMATS
      EMA:AMATS = History::EMA:Record.AMATS
    OF ?EMA:KONTAKTS
      EMA:KONTAKTS = History::EMA:Record.KONTAKTS
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
  EMA:Record = SAV::EMA:Record
  SAV::EMA:Record = EMA:Record
  Auto::Attempts = 0
  LOOP
    Auto::Save:EMA:PAR_NR = EMA:PAR_NR
    CLEAR(EMA:EMA_NR,1)
    SET(EMA:NR_KEY,EMA:NR_KEY)
    PREVIOUS(PAR_E)
    IF ERRORCODE() AND ERRORCODE() <> BadRecErr
      StandardWarning(Warn:RecordFetchError,'PAR_E')
      POST(Event:CloseWindow)
      EXIT
    END
    IF ERRORCODE() |
    OR Auto::Save:EMA:PAR_NR <> EMA:PAR_NR
      Auto::Save:EMA:EMA_NR = 1
    ELSE
      Auto::Save:EMA:EMA_NR = EMA:EMA_NR + 1
    END
    EMA:Record = SAV::EMA:Record
    EMA:EMA_NR = Auto::Save:EMA:EMA_NR
    SAV::EMA:Record = EMA:Record
    ADD(PAR_E)
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
        DELETE(PAR_E)
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

