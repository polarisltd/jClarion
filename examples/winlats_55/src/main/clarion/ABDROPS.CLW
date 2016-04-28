  MEMBER

  INCLUDE('ABDROPS.INC'),ONCE
  INCLUDE('ABWINDOW.INC'),ONCE
  INCLUDE('KEYCODES.CLW'),ONCE

  MAP
    CompareFunc (*GROUP,*GROUP),SIGNED,TYPE

    CaseSensitiveCompare (*GROUP,*GROUP),SIGNED
    CaseInsensitiveCompare (*GROUP,*GROUP),SIGNED

    MODULE('')
      ADDF (QUEUE, CompareFunc),NAME('Cla$ADDqueuefkey')
    END
  END


FileDropClass.Init PROCEDURE(SIGNED FieldID,*STRING Pos,VIEW V,QUEUE Q,RelationManager RelMgr,WindowManager WM)

  CODE
  SELF.ListControl=FieldID
  SELF.ListField = SELF.ListControl
  SELF.ListControl{PROP:IMM}=False          !IMM not required for file loaded Drop Lists
  IF ~SELF.ListControl{PROP:Format} THEN SELF.ListControl{PROP:Format}=(SELF.ListControl{PROP:Width}-16)&'L@'&SELF.ListControl{PROP:Text}&'@'.
  SELF.ListQueue &= Q
  SELF.ViewPosition &= Pos
  SELF.Window &= WM
  ASSERT(~SELF.ViewPosition &= NULL)
  SELF.AllowReset = FALSE
  SELF.InitSyncPair = 1
  SELF.DefaultFill = 1
  SELF.DisplayFields &= NEW FieldPairsClass
  SELF.DisplayFields.Init
  SELF.UpdateFields &= NEW FieldPairsClass
  SELF.UpdateFields.Init
  PARENT.Init(V,RelMgr)


FileDropClass.Kill PROCEDURE

  CODE
  IF ~SELF.DisplayFields &= NULL
    SELF.DisplayFields.Kill
    DISPOSE(SELF.DisplayFields)
  END
  IF ~SELF.UpdateFields &= NULL
    SELF.UpdateFields.Kill
    DISPOSE(SELF.UpdateFields)
  END
  PARENT.Kill


FileDropClass.AddRecord  PROCEDURE()
  CODE
  ADD (SELF.ListQueue)
  ASSERT(~ERRORCODE())
  RETURN TRUE


FileDropClass.ResetQueue PROCEDURE(BYTE Force)

i   LONG,AUTO
ptr LONG,AUTO

  CODE
  IF SELF.ApplyRange() OR Force OR ~SELF.Loaded
    i = 0
    SELF.Loaded = 1
    SETCURSOR(CURSOR:Wait)
    FREE(SELF.ListQueue)
    SELF.Reset
    LOOP UNTIL SELF.Next()
      IF SELF.ValidateRecord()=Record:OK
        SELF.SetQueueRecord
        IF  SELF.AddRecord()
          ptr = POINTER (SELF.ListQueue)
  
          IF i = 0
            IF  SELF.BufferMatches()
              i = ptr
            END
          ELSIF ptr <= i
            i += 1
          END
        END
      END
    END
    SELF.Close

    IF i = 0 AND SELF.DefaultFill AND RECORDS(SELF.ListQueue) THEN i = 1 .
    IF i
      SELF.ListField{PROP:Selected}=i
      SELF.TakeNewSelection(SELF.ListField)
    END
    SELF.ListField{PROP:VScroll}=CHOOSE(RECORDS(SELF.ListQueue)>SELF:ListField{PROP:Items})
    SETCURSOR
  ELSE
    i = CHOICE(SELF.ListField)
  END
  RETURN i

FileDropClass.BufferMatches PROCEDURE
  CODE
    IF SELF.InitSyncPair
      IF SELF.InitSyncPair<=RECORDS(SELF.UpdateFields.List)
        GET(SELF.UpdateFields.List,SELF.InitSyncPair)
        ASSERT(~ERRORCODE())
        IF SELF.UpdateFields.List.Left=SELF.UpdateFields.List.Right
          RETURN True
        END
      END
    END
    RETURN False

FileDropClass.AddField PROCEDURE(*? Src,*? Dest)

  CODE
  SELF.DisplayFields.AddPair(Src,Dest)


FileDropClass.AddUpdateField PROCEDURE(*? Src,*? Dest)

  CODE
  SELF.UpdateFields.AddPair(Src,Dest)


FileDropClass.TakeEvent PROCEDURE

  CODE
  CASE EVENT()
  OF EVENT:Accepted
    SELF.TakeAccepted
  OF EVENT:NewSelection
    SELF.TakeNewSelection
  END


FileDropClass.TakeAccepted PROCEDURE

  CODE


FileDropClass.TakeNewSelection PROCEDURE

  CODE
  SELF.TakeNewSelection(FIELD())


FileDropClass.TakeNewSelection PROCEDURE(SIGNED Field)
  CODE
  IF Field = SELF.ListField
    IF CHOICE(SELF.ListField)
      GET(SELF.ListQueue,CHOICE(SELF.ListField))
      ASSERT(~ERRORCODE())
      SELF.Reset
      RESET(SELF.View,SELF.ViewPosition)
      IF ~SELF.Next()
        SELF.UpdateFields.AssignLeftToRight
      ELSE
        SELF.UpdateFields.ClearRight
      END
      SELF.Close
      SELF.AllowReset = TRUE
    ELSE
      SELF.UpdateFields.ClearRight
    END
    SELF.Window.Reset
  END

FileDropClass.SetQueueRecord PROCEDURE

  CODE
  SELF.ViewPosition=POSITION(SELF.View)
  SELF.DisplayFields.AssignLeftToRight


FileDropClass.ValidateRecord PROCEDURE
  CODE
  RETURN PARENT.ValidateRecord()


FileDropClass.WindowComponent.Kill PROCEDURE

  CODE
  SELF.Kill


FileDropClass.WindowComponent.Reset PROCEDURE(BYTE Force)

  CODE
  SELF.ResetQueue(Force)


FileDropClass.WindowComponent.ResetRequired PROCEDURE

Ret      BYTE,AUTO

  CODE
  Ret = SELF.AllowReset
  SELF.AllowReset = FALSE
  RETURN Ret


FileDropClass.WindowComponent.SetAlerts PROCEDURE

  CODE


FileDropClass.WindowComponent.TakeEvent PROCEDURE

  CODE
  SELF.TakeEvent
  IF EVENT() = EVENT:OpenWindow
    SELF.ResetQueue(True)
  END
  RETURN Level:Benign


FileDropClass.WindowComponent.Update PROCEDURE

  CODE


FileDropClass.WindowComponent.UpdateWindow PROCEDURE

  CODE



!---FileDropComboClass Methods-------------------------------------------------------------------------


FileDropComboClass.Init PROCEDURE(*? UseField,SIGNED FieldID,*STRING Pos,VIEW V,QUEUE Q,RelationManager RelMgr,WindowManager WM,ErrorClass ErrMgr,BYTE AutoAdd,BYTE AutoSync,BYTE CaseSense)

  CODE
  PARENT.Init(FieldID,POS,V,Q,RelMgr,WM)
  SELF.UseField &= UseField
  SELF.ErrMgr &= ErrMgr
  SELF.AutoAddFlag=AutoAdd
  SELF.SyncronizeViewFlag=AutoSync
  SELF.CaseSensitiveFlag=CaseSense
  SELF.EntryCompletion=True
  SELF.RemoveDuplicatesFlag = FALSE


FileDropComboClass.Kill PROCEDURE()
  CODE
  SELF.UseField &= NULL
  PARENT.Kill


FileDropComboClass.AddRecord  PROCEDURE()
  CODE
  IF  NOT SELF.RemoveDuplicatesFlag OR SELF.UniquePosition() <> 0
    IF  SELF.CaseSensitiveFlag
      ADDF (SELF.ListQueue, CaseSensitiveCompare)
    ELSE
      ADDF (SELF.ListQueue, CaseInsensitiveCompare)
    END

    ASSERT(~ERRORCODE())
    RETURN TRUE
  END
  RETURN FALSE


FileDropComboClass.TakeEvent PROCEDURE

Qm  LONG,AUTO

  CODE
  PARENT.TakeEvent
  CASE EVENT()
  OF EVENT:OpenWindow
    SELF.EntryField = SELF.ListControl
    SELF.ListField = SELF.ListControl + 1000
    SELF.ListControl{PROP:ListFeq} = SELF.ListField
    SELF.ButtonField = SELF.ListControl + 2000
    SELF.ListControl{PROP:ButtonFeq} = SELF.ButtonField
    IF SELF.EntryCompletion
      SELF.EntryField{PROP:IMM} = True
      SELF.ListControl{PROP:Auto} = False
    END
    SELF.ListField{PROP:IMM} = False                    !Must always turn off list box's IMM attribute
  OF EVENT:Selected
    IF FIELD() = SELF.ListControl
      SELF.ECOn = SELF.EntryCompletion
    END
  END


FileDropComboClass.TakeAccepted PROCEDURE

Qm  LONG,AUTO

  CODE
? ASSERT(EVENT()=EVENT:Accepted)
  !CASE FIELD()                       !debug tracing
  !OF SELF.EntryField
  !  0{PROP:Text} = 0{PROP:Text}&'Y'
  !OF SELF.ListField
  !  0{PROP:Text} = 0{PROP:Text}&'Z'
  !END
  IF FIELD()=SELF.EntryField AND ~0{PROP:AcceptAll}
    SELF.UseField = SELF.EntryField{PROP:ScreenText}
    Qm = SELF.GetQueueMatch(SELF.UseField)
    IF  Qm = 0
      IF  SELF.Ask() <> Level:Benign
        SELECT(SELF.EntryField)
        CLEAR(SELF.UseField)
        RETURN
      END
      SELF.UpdateFields.AssignLeftToRight
      SELF.ResetQueue(1)
      Qm = SELF.GetQueueMatch(SELF.UseField)
    END

    SELF.ListField{PROP:Selected} = Qm
    SELF.ResetFromList
  END


FileDropComboClass.TakeNewSelection PROCEDURE

  CODE
  SELF.TakeNewSelection(FIELD())


FileDropComboClass.TakeNewSelection PROCEDURE(SIGNED Field)

CurrentEntry  CSTRING(256),AUTO
LastEntry     LIKE(CurrentEntry),STATIC
s             LONG,AUTO

  CODE
  CASE Field
  OF SELF.EntryField
    !0{PROP:Text} = 0{PROP:Text}&'E'      !debug tracing
    IF SELF.EntryCompletion
      IF SELF.KeyValid()
        IF NOT SELF.ECOn
          IF  (SELF.EntryField {PROP:SelStart}) <> (SELF.EntryField {PROP:SelEnd}) |
              OR LEN (SELF.EntryField {PROP:ScreenText}) = 0
            SELF.ECOn = TRUE
          END
        END

        IF SELF.ECOn
          IF KEYCODE() = BSKey
            CurrentEntry = CHOOSE (LastEntry = '', '', SUB(LastEntry,1,LEN(LastEntry)-1))
          ELSE
            CurrentEntry = SUB(SELF.EntryField{PROP:ScreenText},1,SELF.EntryField{Prop:SelStart}-1)
          END
          IF CurrentEntry<>LastEntry
            IF CurrentEntry
              !0{PROP:text}=SELF.UseField&'|'&LEN(CLIP(SELF.UseField))&'|'&CurrentEntry&'|'&LEN(CurrentEntry) !debug tracing
              s = SELF.GetQueueMatch(CurrentEntry)
              IF s
                GET(SELF.DisplayFields.List,1)
                ASSERT(~ERRORCODE())
                SELF.UseField = SELF.DisplayFields.List.Right
                !0{PROP:text}='-->'&SELF.UseField&'|'&LEN(CLIP(SELF.UseField))&'|'&CurrentEntry&'|'   !debug tracing
                SELF.EntryField{PROP:ScreenText} = SELF.UseField
                SELF.EntryField{PROP:SelStart} = LEN(CurrentEntry)+1
                SELF.EntryField{PROP:SelEnd} = LEN(CLIP(SELF.UseField))
                SELF.ListField{PROP:Selected} = s
                SELF.UpdateFields.AssignLeftToRight
                IF SELF.SyncronizeViewFlag
                  SELF.ResetFromList
                END
              ELSE
                CHANGE (SELF.ListControl, SELF.EntryField {PROP:ScreenText})
                SELF.EcOn = False
              END
            END
            LastEntry = CurrentEntry
          END
        ELSE   ! ECOn = False so canit be switched back on?
          SELF.ECOn = TRUE
        END
      ELSE
        SELF.ECOn = False
      END
    END
  OF SELF.ListField
    !0{PROP:Text} = 0{PROP:Text}&'L'      !debug tracing
    SELF.ResetFromlist
  END


FileDropComboClass.ResetFromList PROCEDURE

s LONG,AUTO

  CODE
  s=CHOICE(SELF.ListControl)
  IF s
    GET(SELF.ListQueue,s)
    ASSERT(~ERRORCODE())
    SELF.Reset
    RESET(SELF.View,SELF.ViewPosition)
    IF SELF.Next()=Level:Benign
      GET(SELF.DisplayFields.List,1)
      SELF.UseField=SELF.DisplayFields.List.Left
      SELF.UpdateFields.AssignLeftToRight
      SELF.AllowReset = TRUE
    ELSE
      SELF.UpdateFields.ClearRight
    END
    SELF.Close
  ELSE
    SELF.UpdateFields.ClearRight
  END


FileDropComboClass.Ask PROCEDURE

RVal  BYTE(Level:Notify)

  CODE
  IF SELF.AskProcedure
    DO PrimeForAdd
    IF SELF.Window.Run(SELF.AskProcedure,InsertRecord)=RequestCompleted THEN RVal = Level:Benign.
  ELSIF SELF.AutoAddFlag
    IF SELF.ErrMgr.Message(Msg:AddNewRecord,BUTTON:Yes+BUTTON:No,BUTTON:Yes)=BUTTON:Yes
      DO PrimeForAdd
      RVal = SELF.Primary.Me.Insert()
    END
  END
  RETURN RVal

PrimeForAdd ROUTINE
  DATA
cValue  ANY                 !This is required as SELF.UseField is a reference, and could change during the priming process
  CODE
  cValue = SELF.UseField
  SELF.PrimeRecord
  GET(SELF.DisplayFields.List,1)
  ASSERT(~ERRORCODE())
  SELF.DisplayFields.List.Left = cValue


FileDropComboClass.ResetQueue PROCEDURE(BYTE Force)

i LONG,AUTO

  CODE
  i=PARENT.ResetQueue(Force)
  IF i
    GET(SELF.ListQueue,i)
    ASSERT(~ERRORCODE())
    GET(SELF.DisplayFields.List,1)
    ASSERT(~ERRORCODE())
    SELF.UseField = SELF.DisplayFields.List.Right
  END
  RETURN i


FileDropComboClass.GetQueueMatch PROCEDURE(STRING LookFor)

i LONG,AUTO

  CODE
  GET (SELF.DisplayFields.List,1)
  ASSERT(~ERRORCODE())

  SELF.DisplayFields.List.Right = CLIP (LookFor)
  i = POSITION (SELF.ListQueue)

  IF  ERRORCODE() = 0
    RETURN i                           ! Exact matching
  END

  IF  i > RECORDS (SELF.ListQueue)     
    RETURN 0                           ! No matching records
  END

  GET (SELF.ListQueue, i)

  IF SELF.CaseSensitiveFlag
    IF SUB(SELF.DisplayFields.List.Right,1,LEN(CLIP(Lookfor))) = LookFor THEN RETURN i.
  ELSE
    IF UPPER(SUB(SELF.DisplayFields.List.Right,1,LEN(CLIP(Lookfor)))) = UPPER(LookFor) THEN RETURN i.
  END
  RETURN 0


FileDropComboClass.UniquePosition PROCEDURE()

i LONG,AUTO

  CODE
  i = POSITION (SELF.ListQueue)

  IF  ERRORCODE() = 0
    RETURN 0                           ! Exact matching
  END

  RETURN i                             ! No matching records found


FileDropComboClass.BufferMatches PROCEDURE
  CODE
    IF SELF.InitSyncPair
      RETURN Parent.BufferMatches()
    ELSE
      GET(SELF.DisplayFields.List,1)
      RETURN CHOOSE(SELF.UseField = SELF.DisplayFields.List.Left)
    END


FileDropComboClass.KeyValid PROCEDURE

  CODE
  IF ~KEYCHAR() THEN RETURN False.
  IF BAND(KEYSTATE(),0400h+0200h) THEN RETURN False.
  IF INLIST(KEYCODE(),LeftKey,RightKey,ShiftLeft,ShiftRight) THEN RETURN False.
  RETURN True



CaseSensitiveCompare PROCEDURE (*GROUP l, *GROUP r)

A1   ANY,AUTO
A2   ANY,AUTO

  CODE
  A1 &= WHAT (l, 1)
  A2 &= WHAT (r, 1)

  IF  A1 < A2
    RETURN -1
  ELSIF  A1 > A2
    RETURN 1
  END

  RETURN 0

CaseInsensitiveCompare PROCEDURE (*GROUP l, *GROUP r)

A1   ANY,AUTO
A2   ANY,AUTO

  CODE
  A1 &= WHAT (l, 1)
  A2 &= WHAT (r, 1)

  IF  UPPER (A1) < UPPER (A2)
    RETURN -1
  ELSIF  UPPER (A1) > UPPER (A2)
    RETURN 1
  END

  RETURN 0
