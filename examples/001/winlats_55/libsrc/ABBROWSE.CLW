! Server routines for browse windows
  MEMBER
  MAP
  .
  INCLUDE('Errors.clw'),ONCE
  INCLUDE('Keycodes.clw'),ONCE
  INCLUDE('ABBROWSE.trn'),ONCE
  INCLUDE('ABQUERY.INC'),ONCE
  INCLUDE('ABEIP.inc'),ONCE
  INCLUDE('ABBROWSE.inc'),ONCE

MouseRightIndex EQUATE(249)

Scroll:Alpha     STRING('  AFANATB BFBNBTC CFCNCT'|
                       &'D DFDNDTE EFENETF FFFNFT'|
                       &'G GFGNGTH HFHNHTI IFINIT'|
                       &'J JFJNJTK KFKNKTL LFLNLT'|
                       &'M MFMNMTN NFNNNTO OFONOT'|
                       &'P PFPNPTQ QNR RFRNRTS SF'|
                       &'SNSTT TFTNTTU UFUNUTV VF'|
                       &'VNVTW WFWNWTX XFXNXTY YF'|
                       &'YNYTZ ZN')

Scroll:Name      STRING('   ALBAMEARNBAKBATBENBIABOBBRA'|
                       &'BROBUACACCARCENCHRCOECONCORCRU'|
                       &'DASDELDIADONDURELDEVEFELFISFLO'|
                       &'FREFUTGARGIBGOLGOSGREGUTHAMHEM'|
                       &'HOBHOTINGJASJONKAGKEAKIRKORKYO'|
                       &'LATLEOLIGLOUMACMAQMARMAUMCKMER'|
                       &'MILMONMORNATNOLOKEPAGPAUPETPIN'|
                       &'PORPULRAUREYROBROSRUBSALSCASCH'|
                       &'SCRSHASIGSKISNASOUSTESTISUNTAY'|
                       &'TIRTUCVANWACWASWEIWIEWIMWOLYOR')

OverrideCharacters   STRING('`!"£$%%^&*()''-=_+][#;~@:/.,?\| ')

StepClass.Init PROCEDURE(BYTE Controls)
  CODE
    SELF.Controls = Controls

StepClass.Kill PROCEDURE
  CODE

StepClass.GetPercentile PROCEDURE(? Value)
  CODE
    RETURN 50

StepClass.GetValue PROCEDURE(BYTE Percentile)
  CODE
    RETURN ''

StepClass.SetLimit PROCEDURE(? L,? H)
  CODE

StepClass.SetLimitNeeded PROCEDURE
  CODE
    RETURN 1

StepLongClass.GetPercentile PROCEDURE(? Value)
R BYTE,AUTO
  CODE ! Allows out of range values
    IF SELF.Low = SELF.High
      RETURN 50
    END
    R = (Value - SELF.Low) * (100 / (SELF.High - SELF.Low))
    IF BAND(SELF.Controls,ScrollSort:Descending)
      R = 100 - R
    END
    RETURN CHOOSE(R = 0,1,R)

StepLongClass.GetValue PROCEDURE(BYTE P)
  CODE
    IF BAND(SELF.Controls,ScrollSort:Descending)
      P = 100 - P
    END
    RETURN SELF.Low + (SELF.High - SELF.Low) * (P / 100)

StepLongClass.SetLimit PROCEDURE(? low,? high)
  CODE
    IF BAND(SELF.Controls,ScrollSort:Descending)
      SELF.Low = High
      SELF.High = Low
    ELSE
      SELF.Low = Low
      SELF.High = High
    END

StepRealClass.GetPercentile PROCEDURE(? Value)
R BYTE,AUTO
  CODE  ! Allows out of range values
    IF SELF.Low = SELF.High
      RETURN 50
    END
    R = ((Value - SELF.Low) * 100) / (SELF.High - SELF.Low)
    IF BAND(SELF.Controls,ScrollSort:Descending)
      R = 100 - R
    END
    RETURN CHOOSE(R = 0,1,R)

StepRealClass.GetValue PROCEDURE(BYTE P)
  CODE
    IF BAND(SELF.Controls,ScrollSort:Descending)
      P = 100 - P
    END
    RETURN SELF.Low + (SELF.High - SELF.Low) * P / 100

StepRealClass.SetLimit PROCEDURE(? low,? high)
  CODE
    IF BAND(SELF.Controls,ScrollSort:Descending)
      SELF.Low = High
      SELF.High = Low
    ELSE
      SELF.Low = Low
      SELF.High = High
    END

StepCustomClass.AddItem PROCEDURE(STRING s)
  CODE
    ASSERT(~(SELF.Entries &= NULL))
    SELF.Entries.Item &= NEW CSTRING(LEN(s)+1)
    SELF.Entries.Item = s
    ADD(SELF.Entries)

StepStringClass.Init PROCEDURE (BYTE Controls, BYTE Mode)
ValidChars  STRING(255),AUTO
Chars       UNSIGNED,AUTO
I           UNSIGNED,AUTO
  CODE
    SELF.LookupMode = Mode
    PARENT.Init(Controls)
    CASE Mode
    OF ScrollBy:Name
      SELF.Ref &= Scroll:Name
      SELF.TestLen = 3
    OF ScrollBy:Alpha
      SELF.Ref &= Scroll:Alpha
      SELF.TestLen = 2
    OF ScrollBy:Runtime
      SELF.Ref &= NEW STRING(400)
      SELF.TestLen = 4
      Chars = 0

      LOOP I = 1 TO 255   ! Compute string of valid sort characters
        IF BAND(Controls,ScrollSort:AllowAlt) AND INSTRING(CHR(I),OverrideCharacters) OR |
           BAND(Controls,ScrollSort:AllowNumeric) AND CHR(I) >= '0' AND CHR(I) <= '9' OR |
           BAND(Controls,ScrollSort:AllowAlpha) AND ISALPHA(CHR(I)) AND |
               (BAND(Controls,ScrollSort:CaseSensitive) OR ISUPPER(CHR(I)))
          Chars += 1
          ValidChars [Chars] = CHR (I)
        END
      END
      SELF.SortChars &= NEW CSTRING (Chars + 1)
      SELF.SortChars  = ValidChars [1 : Chars]
    END


StepCustomClass.Init PROCEDURE(BYTE Controls)
  CODE
    PARENT.Init(Controls)
    SELF.Entries &= NEW CStringList

StepStringClass.Kill PROCEDURE
  CODE
    IF SELF.LookupMode = ScrollBy:RunTime
      DISPOSE(SELF.Ref)
    END
    DISPOSE(SELF.SortChars)

StepCustomClass.Kill PROCEDURE
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.Entries)
      GET(SELF.Entries,I)
      DISPOSE(SELF.Entries.Item)
    END
    DISPOSE(SELF.Entries)

StepStringClass.Unhash PROCEDURE(LONG l)
RetVal STRING(4),AUTO
I BYTE,AUTO
Base USHORT,AUTO
  CODE
    Base = LEN(SELF.SortChars)
    ASSERT(Base)
    LOOP I = 4 TO 1 BY -1
      RetVal[I] = SELF.SortChars[L%Base + 1]
      L /= Base
    END
    RETURN RetVal

StepStringClass.SetLimit PROCEDURE(? l,? h)
MinLen UNSIGNED,AUTO
Common UNSIGNED,AUTO
LowValue  STRING(4),AUTO
HighValue STRING(4),AUTO
I      UNSIGNED,AUTO
Delta  LONG,AUTO
LowVal LONG,AUTO
Low CSTRING(80)
High CSTRING(80)
  CODE
    Low = CLIP(l)
    High = CLIP(h)
    IF LEN(High) < LEN(Low)
      MinLen = LEN(High)
    ELSE
      MinLen = LEN(Low)
    END
    LOOP Common = 1 TO MinLen     ! Find the common length of the limits
    UNTIL Low[Common] <> High[Common]
    SELF.Root = CHOOSE(Common > 1,Low[ 1 : Common - 1 ],'') ! Common is first non-common character
    LowValue = Low[ Common : LEN(Low) ]
    LOOP I = 2 + LEN(Low) - Common TO 4
      LowValue[I] = SELF.SortChars[1]    ! 'Clear(,-1)'
    END
    HighValue = High[ Common : LEN(High) ]
    LOOP I = 2 + LEN(High) - Common TO 4
      HighValue[I] = SELF.SortChars[LEN(SELF.SortChars)] ! 'Clear(,1)'
    END
    LowVal = SELF.Hash(LowValue)
    Delta = (SELF.Hash(HighValue) - LowVal) / 100
    IF BAND(SELF.Controls,ScrollSort:Descending)
      LOOP I = 99 TO 0 BY -1
        SELF.Ref[1+I*4 : 4+I*4] = SELF.Unhash(LowVal)
        LowVal += Delta
      END
    ELSE
      LOOP I = 0 TO 99
        SELF.Ref[1+I*4 : 4+I*4] = SELF.Unhash(LowVal)
        LowVal += Delta
      END
    END

StepStringClass.SetLimitNeeded PROCEDURE
  CODE
    RETURN CHOOSE(SELF.LookupMode = ScrollBy:RunTime)

StepStringClass.GetPercentile PROCEDURE(? Value)
I BYTE,AUTO
Match CSTRING(80)
  CODE
    IF LEN(SELF.Root)
?     ASSERT(SELF.Root = SUB(Value,1,LEN(SELF.Root)))
      Match = SUB(Value,LEN(SELF.Root)+1,SELF.TestLen+1)
    ELSE
      Match = Value
    END
    IF ~BAND(SELF.Controls,ScrollSort:CaseSensitive)
      Match = UPPER(Match)
    END
    LOOP I = 0 TO 99
      IF SELF.Ref[I*SELF.TestLen+1:(I+1)*SELF.TestLen]>Match
        BREAK
      END
    END
    IF BAND(SELF.Controls,ScrollSort:Descending)
      I = 100 - I
    END
    RETURN CHOOSE(I = 0,1,I)

StepCustomClass.GetPercentile PROCEDURE(? Value)
I UNSIGNED,AUTO
  CODE
    LOOP I = 1 TO RECORDS(SELF.Entries)
      GET(SELF.Entries,I)
      IF BAND(SELF.Controls,ScrollSort:CaseSensitive)
        IF SELF.Entries.Item<Value
          BREAK
        END
      ELSE
        IF SELF.Entries.Item<UPPER(Value)
          BREAK
        END
      END
    END
    I = ((I-1)*100) / RECORDS(SELF.Entries)
    IF BAND(SELF.Controls,ScrollSort:Descending)
      I = 100 - I
    END
    RETURN CHOOSE(I = 0,1,I)

StepStringClass.GetValue PROCEDURE(BYTE P)
  CODE
    IF BAND(SELF.Controls,ScrollSort:Descending)
      P = 100 - P
    END
    IF P = 0
      P = 1
    END
    RETURN SELF.Root & SELF.Ref[(P-1)*SELF.TestLen+1 : P*SELF.TestLen ]

StepCustomClass.GetValue PROCEDURE(BYTE P)
  CODE
    IF BAND(SELF.Controls,ScrollSort:Descending)
      P = 100 - P
    END
    GET(SELF.Entries,P * RECORDS(SELF.Entries) / 100)
    ASSERT(~ERRORCODE())
    RETURN SELF.Entries.Item

StepStringClass.Hash PROCEDURE(STRING Value)
Base USHORT,AUTO
Result LONG(0)
I BYTE,AUTO
Digit BYTE,AUTO
  CODE
    Base = LEN(SELF.SortChars)
    IF ~BAND(SELF.Controls,ScrollSort:CaseSensitive)
      Value = UPPER(Value)
    END
    LOOP I = 1 TO 4
      Digit = INSTRING(Value[I],SELF.SortChars)
      IF Digit THEN Digit -= 1 .
      Result = Result * Base + Digit
    END
    RETURN Result

StandardBehavior.Init PROCEDURE(QUEUE Q, *STRING Pos, SIGNED LC)
  CODE
  SELF.Q &= Q
  SELF.S &= Pos
  SELF.LC = LC

StandardBehavior.IListControl.Choice PROCEDURE
  CODE
  RETURN CHOICE(SELF.Lc)

StandardBehavior.IListControl.SetChoice PROCEDURE(SIGNED NC)
  CODE
  SELF.LC{PROP:SelStart} = NC

StandardBehavior.IListControl.GetControl PROCEDURE
  CODE
  RETURN SELF.Lc

StandardBehavior.IListControl.SetControl PROCEDURE(SIGNED NC)
  CODE
  SELF.Lc = NC

StandardBehavior.IListControl.GetItems PROCEDURE
  CODE
  RETURN SELF.Lc{PROP:Items}

StandardBehavior.IListControl.GetVisible PROCEDURE
  CODE
  RETURN SELF.Lc{PROP:Visible}

StandardBehavior.BrowseQueue.Records PROCEDURE

  CODE
  RETURN RECORDS(SELF.Q)

StandardBehavior.BrowseQueue.Insert PROCEDURE

  CODE
  ADD(SELF.Q)

StandardBehavior.BrowseQueue.Insert PROCEDURE(UNSIGNED RowNum)

  CODE
  ADD(SELF.Q, RowNum)

StandardBehavior.BrowseQueue.Fetch PROCEDURE(UNSIGNED RowNum)

  CODE
  GET(SELF.Q, RowNum)

StandardBehavior.BrowseQueue.Update PROCEDURE

  CODE
  PUT(SELF.Q)

StandardBehavior.BrowseQueue.Delete PROCEDURE

  CODE
  DELETE(SELF.Q)

StandardBehavior.BrowseQueue.Free PROCEDURE

  CODE
  FREE(SELF.Q)

StandardBehavior.BrowseQueue.Who PROCEDURE(UNSIGNED ColNum)

  CODE
  RETURN WHO(SELF.Q, ColNum)

StandardBehavior.BrowseQueue.GetViewPosition PROCEDURE

  CODE
  RETURN SELF.S

StandardBehavior.BrowseQueue.SetViewPosition PROCEDURE(STRING S)

  CODE
  SELF.S = S

BrowseClass.AddEditControl PROCEDURE(<EditClass EC>,UNSIGNED Id,BYTE Free)
  CODE
    SELF.CheckEIP
    SELF.EIP.AddControl(EC,Id,Free)

BrowseClass.AddField PROCEDURE(*? FromFile,*? FromQueue)
  CODE
    SELF.Fields.AddPair(FromFile,FromQueue)

BrowseClass.AddField PROCEDURE(*string FromFile,*string FromQueue)
  CODE
    SELF.Fields.AddPair(FromFile,FromQueue)

BrowseClass.AddField PROCEDURE(*long FromFile,*long FromQueue)
  CODE
    SELF.Fields.AddPair(FromFile,FromQueue)

BrowseClass.AddItem PROCEDURE( RecordProcessor RP )
  CODE
  ASSERT(~SELF.Processors &= NULL,'Object not initialized')
  SELF.Processors.P &= RP
  ADD(SELF.Processors)

BrowseClass.AddResetField PROCEDURE(*? Left)
  CODE
    ASSERT(~(SELF.Sort.Resets &= NULL))
    SELF.Sort.Resets.AddItem(Left)

BrowseClass.AddResetField PROCEDURE(*string Left)
  CODE
    ASSERT(~(SELF.Sort.Resets &= NULL))
    SELF.Sort.Resets.AddItem(Left)

BrowseClass.AddLocator PROCEDURE(LocatorClass L)
  CODE
    SELF.Sort.Locator &= L
    PUT(SELF.Sort)

BrowseClass.AddSortOrder PROCEDURE(<StepClass Th>,<Key K>)
SNum BYTE,AUTO
  CODE
    CLEAR(SELF.Sort)
    SNum = PARENT.AddSortOrder(K)
    SELF.Sort.Thumb &= Th
    SELF.Sort.Resets &= NEW FieldPairsClass
    SELF.Sort.Resets.Init
    PUT(SELF.Sort)
    ASSERT(~ERRORCODE())
    RETURN SNum

BrowseClass.AddToolbarTarget PROCEDURE(ToolbarClass T)
  CODE
    SELF.Toolbar &= T
    SELF.ToolbarItem &= NEW ToolbarListboxClass
    SELF.ToolbarItem.Browse &= SELF
    T.AddTarget(SELF.ToolbarItem,SELF.ILC.GetControl())
    SELF.UpdateToolbarButtons

BrowseClass.ApplyRange PROCEDURE
RVal BYTE
LI   SIGNED,AUTO
  CODE
    LI = SELF.ILC.GetItems()
    IF SELF.LastItems <> LI  AND  LI >= 0
      IF SELF.FileLoaded
        CLEAR(SELF.LastItems,1)
      ELSE
        SELF.LastItems = LI
        RVal = 1
      END
    END
    IF RVal OR PARENT.ApplyRange() OR ~SELF.Sort.Resets.Equal()
      SELF.LoadPending = 1
      RVal = 1
    END
    RETURN RVal

BrowseClass.Ask PROCEDURE(BYTE Req)
Response BYTE
  CODE
  LOOP
    SELF.Window.VCRRequest = VCR:None
    IF KEYCODE() = MouseRightUp
      SETKEYCODE(0)
    END
    IF SELF.AskProcedure
      IF Req=InsertRecord THEN
        IF SELF.PrimeRecord()
          RETURN RequestCancelled
        END
      END
      Response = SELF.Window.Run(SELF.AskProcedure,Req)
      SELF.ResetFromAsk(Req,Response)
    ELSE
      Response = SELF.AskRecord(Req)
    END
  UNTIL SELF.Window.VCRRequest = VCR:None
  RETURN Response

BrowseClass.AskRecord PROCEDURE(BYTE Req)
  CODE
  SELF.CheckEIP
  RETURN SELF.EIP.Run(Req)

BrowseClass.CheckEIP PROCEDURE
  CODE
  IF SELF.EIP &= NULL
    SELF.EIP &= NEW BrowseEIPManager
    SELF.FreeEIP = 1
  END
  SELF.EIP.Arrow &= SELF.ArrowAction
  SELF.EIP.BC &= SELF
  SELF.EIP.Enter &= SELF.EnterAction
  SELF.EIP.Eq &= SELF.EditList   ! Certain amount of 'interface swapping' so that EIP manager can mascarade under 'old' browse EIP interface
  SELF.EIP.Errors &= SELF.Window.Errors
  SELF.EIP.Fields &= SELF.Fields
  SELF.EIP.FocusLoss &= SELF.FocusLossAction
  SELF.EIP.ListControl = SELF.ILC.GetControl()
  SELF.EIP.Tab &= SELF.TabAction
  SELF.EIP.VCRRequest &= SELF.Window.VCRRequest


BrowseClass.Fetch PROCEDURE(BYTE Direction)
SkipFirst BYTE(0)
  CODE
  IF SELF.QuickScan AND SELF.ItemsToFill > 1
    SELF.Primary.SetQuickScan(1)
  END
  IF SELF.ListQueue.RECORDS()
    SELF.ListQueue.Fetch(CHOOSE(Direction = FillForward,SELF.ListQueue.Records(),1))
    RESET(SELF.View,SELF.ListQueue.GetViewPosition())
    SkipFirst = 1
  END
  LOOP WHILE SELF.ItemsToFill
    CASE CHOOSE(Direction = FillForward,SELF.Next(),SELF.Previous())
    OF Level:Notify
      BREAK
    OF Level:Fatal
      RETURN
    END
    IF SkipFirst
      SkipFirst = FALSE
      IF POSITION(SELF.View)= SELF.ListQueue.GetViewPosition()
        CYCLE
      END
    END
    IF SELF.ListQueue.Records() = SELF.LastItems
      SELF.ListQueue.Fetch(CHOOSE(Direction = FillForward,1,SELF.ListQueue.Records()))
      SELF.ListQueue.Delete()
    END
    SELF.SetQueueRecord
    IF Direction = FillForward
      SELF.ListQueue.Insert()
    ELSE
      SELF.ListQueue.Insert(1)
    END
    SELF.ItemsToFill -= 1
  END
  IF SELF.QuickScan
    SELF.Primary.SetQuickScan(0)
  END

BrowseClass.ResetFieldS PROCEDURE
  CODE
    SELF.Fields.Kill
    SELF.Fields.Init

BrowseClass.Init  PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager F,WindowManager WM)

  CODE
  SELF.Behavior &= NEW StandardBehavior
  SELF.Behavior.Init(Q,Posit,ListBox)
  SELF.Init(SELF.Behavior.IListControl, V, SELF.Behavior.BrowseQueue, F, WM)

BrowseClass.Init  PROCEDURE(IListControl LI,VIEW V,BrowseQueue LQ,RelationManager F,WindowManager WM)
  CODE
    SELF.PrevChoice = 0
    SELF.Window &= WM
    SELF.ListQueue &= LQ
    SELF.ILC &= LI
    SELF.Sort &= NEW BrowseSortOrder
    SELF.Fields &= NEW FieldPairsClass
    SELF.Fields.Init
    SELF.Processors &= NEW ProcessorQueue
    SELF.Popup &= NEW PopupClass
    SELF.EditList &= NEW BrowseEditQueue
    SELF.RetainRow = 1
    ASSERT(~SELF.Popup&=NULL)
    SELF.Popup.Init
    PARENT.Init(V,F,SELF.Sort)
    SELF.Window.AddItem(SELF)
    IF SELF.Selecting
      SELF.Primary.Me.UseFile(UseType:Returns)
      SELF.Buffer = SELF.Primary.Me.SaveBuffer()
    END


BrowseClass.Kill PROCEDURE
I UNSIGNED,AUTO
  CODE
    IF ~(SELF.Sort &= NULL)
      LOOP I = 1 TO RECORDS(SELF.Sort)
        GET(SELF.Sort,I)
        IF ~(SELF.Sort.Thumb &= NULL)
          SELF.Sort.Thumb.Kill
        END
        SELF.Sort.Resets.Kill
        DISPOSE(SELF.Sort.Resets)
      END
    END
    SELF.Window.RemoveItem(SELF.WindowComponent)
    PARENT.Kill
    DISPOSE(SELF.Sort)
    IF ~SELF.Fields &= NULL
      SELF.Fields.Kill
      DISPOSE(SELF.Fields)
    END
    IF ~SELF.Popup &= NULL
      SELF.Popup.Kill
      DISPOSE(SELF.Popup)
    END
    DISPOSE(SELF.ToolbarItem)
    IF ~SELF.Query &= NULL
      SELF.Query.Kill
    END
    IF SELF.FreeEIP
      DISPOSE(SELF.EIP)
      SELF.FreeEIP = 0
    END
    IF ~SELF.EditList &= NULL
      LOOP I = 1 TO RECORDS(SELF.EditList)
        GET(SELF.EditList,I)
        IF SELF.EditList.FreeUp
          DISPOSE(SELF.EditList.Control)
        END
      END
      DISPOSE(SELF.EditList)
    END
    IF ~SELF.Behavior&= NULL
      self.ListQueue &= NULL
      SELF.ILC &= NULL
      DISPOSE(SELF.Behavior)
    END
    LOOP I = 1 TO RECORDS(SELF.Processors)
      GET(SELF.Processors,I)
      SELF.Processors.P.TakeClose()
    END
    DISPOSE(SELF.Processors)

BrowseClass.Next PROCEDURE
Res BYTE,AUTO
  CODE
    Res = PARENT.Next()
    CASE Res
    OF Level:Notify
      SELF.UpdateResets
    OF Level:Fatal
      POST(EVENT:CloseWindow)
    END
    RETURN Res

BrowseClass.NotifyUpdateError PROCEDURE
  CODE
  SELF.Primary.Me.Throw(Msg:AbortReading)
  RETURN TRUE

BrowseClass.PostNewSelection PROCEDURE
  CODE
  IF  SELF.PrevChoice <> 0  OR  SELF.CurrentChoice <> 0  OR  KEYCODE() = MouseRightUp
    SELF.PrevChoice = SELF.CurrentChoice
    SELF.ILC.SetChoice(SELF.CurrentChoice)
    POST(Event:NewSelection,SELF.ILC.GetControl())
  END

BrowseClass.Previous  PROCEDURE
Res BYTE,AUTO
  CODE
    Res = PARENT.Previous()
    CASE Res
    OF Level:Notify
      SELF.UpdateResets
    OF Level:Fatal
      POST(EVENT:CloseWindow)
    END
    RETURN Res

BrowseClass.Records PROCEDURE
RVal BYTE,AUTO
  CODE
    RVal = CHOOSE(SELF.ListQueue.Records())
    IF ~SELF.Sort.Locator &= NULL
      SELF.Sort.Locator.SetEnabled(RVal)
    END
    IF ~RVal
      SELF.CurrentChoice = 0
    END
    RETURN SELF.ListQueue.Records()

BrowseClass.ResetFromAsk PROCEDURE(*BYTE Request,*BYTE Response)
  CODE
  IF Response = RequestCompleted
    FLUSH(SELF.View)
    IF Request = DeleteRecord
      SELF.ListQueue.Delete()
      SELF.ResetQueue(Reset:Queue)
    ELSE
      SELF.ResetFromFile
    END
  ELSE
    SELF.ResetQueue(Reset:Queue)
  END
  IF SELF.Window.VCRRequest = VCR:Insert OR SELF.Window.VCRRequest = VCR:Forward AND Request = InsertRecord
    Request = InsertRecord
    GET(SELF.Primary.Me.File,0)
    CLEAR(SELF.Primary.Me.File)
  ELSE
    SELF.TakeVCRScroll(SELF.Window.VCRRequest)
  END
  IF SELF.Window.VCRRequest = VCR:None
    SELF.ResetFromView
    SELF.UpdateWindow
    SELF.PostNewSelection
    SELECT(SELF.ILC.GetControl())
  END


BrowseClass.ResetFromBuffer PROCEDURE
  CODE
    IF SELF.Sort.MainKey &= NULL
      SELF.Reset(1)
    ELSE
      SELF.Reset(SELF.Primary.Me.GetComponents(SELF.Sort.MainKey))
    END
    SELF.ResetQueue(Reset:Done)
    SELF.UpdateWindow

BrowseClass.ResetFromFile PROCEDURE
  CODE
    RESET(SELF.View,SELF.Primary.Me.File)
    ASSERT(~ERRORCODE())
    SELF.ResetQueue(Reset:Done)

BrowseClass.ResetFromView PROCEDURE
  CODE
    SETCURSOR(CURSOR:Wait)
    SELF.ResetThumbLimits
    SETCURSOR

! Strategy :
! Fill forward from starting position.
! The 'highlight' is either
!    a) The current choice (Reset:Queue)
!    b) The First record read forwards (Reset:Done)
!    c) The first record read backwards (when Reset:Done is beyond EOF)
! If ResetDone and RetainingRow it is -probably- better not to fill the whole page.
! Find where highlighted record is in current set and add records (first to beginning, then end) to fill page
! As this can possible result in too many records, start deleting, trying to move CurrentChoice to correct position
! Noteworthy tweaks :-
!   If loading from start of record set there is no point going backwards
!   If FromQueue then load from -first- element not -required- one (you will probably get lucky and find required where you want it)
!   If EOF hit on read forward then no point attempting to read forward again
BrowseClass.ResetQueue PROCEDURE(BYTE RefreshMode)
HighlightRequired UNSIGNED
TopMargin         LONG
HighlightedPosition      STRING(1024)
FromTop           BYTE
EofHit            BYTE,AUTO
  CODE
  IF ~SELF.ActiveInvisible AND ~SELF.ILC.GetVisible()
    SELF.LoadPending = 1
    RETURN
  END
  SELF.Loaded = 1
  SELF.LoadPending = 0
  SETCURSOR(Cursor:Wait)
  IF ~SELF.CurrentChoice THEN SELF.CurrentChoice = 1.
  IF RefreshMode = Reset:Done
    IF SELF.RetainRow
      TopMargin = SELF.CurrentChoice - 1
    END
  ELSE
    IF SELF.ListQueue.Records()
      SELF.ListQueue.Fetch(SELF.CurrentChoice)
      IF ERRORCODE()
        SELF.ListQueue.Fetch(SELF.ListQueue.Records())
      END
      HighlightedPosition = SELF.ListQueue.GetViewPosition()
      SELF.ListQueue.Fetch(1)
      RESET(SELF.View,SELF.ListQueue.GetViewPosition())
    ELSE
      FromTop = 1
      SELF.Reset
    END
  END
  IF SELF.RetainRow
    HighlightRequired = SELF.CurrentChoice
  END
  SELF.ListQueue.Free()
  SELF.ItemsToFill = SELF.LastItems-TopMargin
  SELF.Fetch(FillForward)
  EofHit = CHOOSE(SELF.ItemsToFill)
  IF ~HighlightedPosition AND SELF.ListQueue.Records()
    SELF.ListQueue.Fetch(1)
    HighLightedPosition = SELF.ListQueue.GetViewPosition()
  END
  DO ResetCurrentChoice
  IF ~SELF.ListQueue.Records()  ! Probably a locate beyond EOF
    SELF.Reset
  END
  SELF.ItemsToFill = CHOOSE(SELF.AllowUnfilled=0,SELF.LastItems - SELF.ListQueue.Records(),0)
  IF ~FromTop AND ( SELF.ItemsToFill OR TopMargin > 0 )
    SELF.ItemsToFill = CHOOSE(SELF.ItemsToFill > TopMargin,SELF.ItemsToFill,TopMargin)
    SELF.Fetch(FillBackward)
    IF ~HighlightedPosition AND SELF.ListQueue.Records()
      SELF.ListQueue.Fetch(SELF.ListQueue.Records())
      HighLightedPosition = SELF.ListQueue.GetViewPosition()
    END
    DO ResetCurrentChoice
  END
  IF SELF.RetainRow AND (TopMargin < 0 OR SELF.ListQueue.Records() < SELF.LastItems AND ~EofHit)
    SELF.ItemsToFill = CHOOSE(-TopMargin > SELF.LastItems-SELF.ListQueue.Records(),-TopMargin,SELF.LastItems-SELF.ListQueue.Records())
    SELF.Fetch(FillForward)
    DO ResetCurrentChoice
  END
  LOOP WHILE SELF.ListQueue.Records() > SELF.LastItems ! May have happened if over-read to get row correct
    IF TopMargin < 0
      SELF.ListQueue.Fetch(1)
      SELF.ListQueue.Delete()
      TopMargin += 1
      SELF.CurrentChoice -= 1
    ELSE
      SELF.ListQueue.Fetch(SELF.ListQueue.Records())
      SELF.ListQueue.Delete()
    END
  END
  IF ~SELF.CurrentChoice
    SELF.CurrentChoice = 1
  END
  IF SELF.Records()
    SELF.UpdateBuffer
  ELSE
    CLEAR(SELF.Primary.Me.File)
  END
  SETCURSOR()

ResetCurrentChoice ROUTINE
  IF HighlightedPosition
    LOOP SELF.CurrentChoice = 1 TO SELF.ListQueue.Records()
      SELF.ListQueue.Fetch(SELF.CurrentChoice)
    UNTIL SELF.ListQueue.GetViewPosition() = HighLightedPosition
    IF SELF.CurrentChoice > SELF.ListQueue.Records()
      SELF.CurrentChoice = 0
    END
  ELSE
    SELF.CurrentChoice = 1
  END
  IF SELF.RetainRow
    TopMargin = HighlightRequired-SELF.CurrentChoice
  END

BrowseClass.ResetResets PROCEDURE
  CODE
    SELF.Sort.Resets.AssignLeftToRight

BrowseClass.ResetSort PROCEDURE(BYTE Force)
  CODE
    RETURN SELF.SetSort(POINTER(SELF.Sort),Force)

! Thumb limits are set using the extrema of the underlying view
BrowseClass.ResetThumbLimits PROCEDURE
HighValue ANY
  CODE
  IF SELF.Sort.Thumb &= NULL OR ~SELF.Sort.Thumb.SetLimitNeeded() OR ~SELF.AllowUnfilled AND SELF.ILC.GetItems() > SELF.ListQueue.Records()
    RETURN
  END
  SELF.Reset
  IF SELF.Previous()
    RETURN
  END
  HighValue = SELF.Sort.FreeElement
  SELF.Reset
  IF SELF.Next()
    RETURN
  END
  SELF.Sort.Thumb.SetLimit(SELF.Sort.FreeElement,HighValue)

BrowseClass.ScrollOne PROCEDURE(SIGNED Ev)
  CODE
  SELF.CurrentEvent = Ev
  IF Ev = Event:ScrollUp AND SELF.CurrentChoice > 1
    SELF.CurrentChoice -= 1
  ELSIF Ev = Event:ScrollDown AND SELF.CurrentChoice < SELF.ListQueue.Records()
    SELF.CurrentChoice += 1
  ELSIF ~SELF.FileLoaded
    SELF.ItemsToFill = 1
    SELF.Fetch(CHOOSE(Ev = EVENT:ScrollUp,1,2))
  END

BrowseClass.ScrollPage PROCEDURE(SIGNED Ev)
LI SIGNED,AUTO
  CODE
  SELF.CurrentEvent = Ev
  Li = SELF.ILC.GetItems()
  IF ~SELF.FileLoaded
    SELF.ItemsToFill = LI
    SELF.Fetch(CHOOSE(Ev = EVENT:PageUp,1,2))                           ! Fill with next read(s)
    LI = SELF.ItemsToFill
  END
  IF Ev = Event:PageUp
    SELF.CurrentChoice -= LI
    IF SELF.CurrentChoice < 1
      SELF.CurrentChoice = 1
    END
  ELSE
    SELF.CurrentChoice += LI
    IF SELF.CurrentChoice > SELF.ListQueue.Records()
      SELF.CurrentChoice = SELF.ListQueue.Records()
    END
  END

BrowseClass.ScrollEnd PROCEDURE(SIGNED Ev)
  CODE
  SELF.CurrentEvent = Ev
  IF ~SELF.FileLoaded
    SELF.ListQueue.Free()
    SELF.Reset
    SELF.ItemsToFill = SELF.ILC.GetItems()
    SELF.Fetch(CHOOSE(Ev = Event:ScrollTop,FillForward,FillBackward))                           ! Fill with next read(s)
  END
  SELF.CurrentChoice = CHOOSE(Ev = Event:ScrollTop,1,SELF.ListQueue.Records())

BrowseClass.SetAlerts PROCEDURE
I BYTE,AUTO
  CODE
    SELF.ILC.GetControl(){Prop:Alrt,MouseLeft2Index} = MouseLeft2
    SELF.ILC.GetControl(){Prop:Alrt,MouseRightIndex} = MouseRightUp
    SELF.HasThumb = CHOOSE(SELF.ILC.GetControl(){PROP:VScroll})
    SELF.ILC.GetControl(){PROP:VScroll} = 0 ! Not really the right place for this but we want to avoid the peek-a-boo scrollbar
    LOOP I = 1 TO RECORDS(SELF.Sort)
      GET(SELF.Sort,I)
      IF ~ (SELF.Sort.Locator &= NULL)
        SELF.Sort.Locator.SetAlerts(SELF.ILC.GetControl())
      END
    END
    IF SELF.InsertControl
      SELF.ILC.GetControl(){Prop:Alrt,255} = InsertKey
      SELF.Popup.AddItemMimic(DefaultInsertName,SELF.InsertControl,'!'&DefaultInsertName)
    END
    IF SELF.ChangeControl
      SELF.ILC.GetControl(){Prop:Alrt,253} = CtrlEnter
      SELF.Popup.AddItemMimic(DefaultChangeName,SELF.ChangeControl,'!'&DefaultChangeName)
    END
    IF SELF.DeleteControl
      SELF.ILC.GetControl(){Prop:Alrt,254} = DeleteKey
      SELF.Popup.AddItemMimic(DefaultDeleteName,SELF.DeleteControl,'!'&DefaultDeleteName)
    END
    IF SELF.ViewControl
      SELF.ILC.GetControl(){PROP:Alrt,255} = ShiftEnter
      SELF.Popup.AddItemMimic(DefaultViewName, SELF.ViewControl, '!' & DefaultViewName)
    END
    IF SELF.PrintControl
      SELF.Popup.AddItemMimic(DefaultPrintName,SELF.PrintControl,'!'&DefaultPrintName)
    END
    IF SELF.QueryControl
      IF SELF.Query.QkSupport AND ~(SELF.Popup &= NULL)
       SELF.Query.SetQuickPopup(SELF.Popup,SELF.QueryControl)
      END
      IF SELF.Popup.GetItems() !.
         SELF.Popup.AddItem('-','Separator2',SELF.Popup.GetItems(),1)
      END
      SELF.Popup.AddItemMimic(DefaultQueryName,SELF.QueryControl,'!'&DefaultQueryName)
    END
    IF SELF.SelectControl AND SELF.Selecting
      SELF.Popup.AddItemMimic(DefaultSelectName,SELF.SelectControl,'!'&DefaultSelectName)
    END
    IF SELF.ToolControl
      SELF.Popup.AddItem('-')
      SELF.Popup.SetToolbox(SELF.Popup.AddItemMimic(DefaultToolName,SELF.ToolControl,'!'&DefaultToolName),0)
    END

BrowseClass.SetQueueRecord PROCEDURE
  CODE
    SELF.Fields.AssignLeftToRight
    SELF.ListQueue.SetViewPosition(POSITION(SELF.View))

BrowseClass.InitSort PROCEDURE(BYTE B)
RVal BYTE(0)
  CODE
    IF SELF.SetSort(B)
      IF ~SELF.Sort.Locator &= NULL
        SELF.Sort.Locator.Set
      END
      Rval = 1
    END
    RETURN RVal

BrowseClass.SetSort PROCEDURE(BYTE B,BYTE Force)
RVal BYTE(0)
  CODE
    RVal = SELF.InitSort(B)
    IF SELF.ApplyRange() OR Rval OR Force OR ~SELF.Loaded OR SELF.LoadPending
      SELF.ResetResets
      SELF.ApplyOrder
      SELF.ApplyFilter
      IF (SELF.Selecting OR SELF.StartAtCurrent) AND ~SELF.Loaded
        SELF.Reset(SELF.GetFreeElementPosition())
        SELF.ResetQueue(Reset:Done)
      ELSIF SELF.ListQueue.Records()
        RESET(SELF.View,SELF.ListQueue.GetViewPosition())
        SELF.ResetQueue(Reset:Done)
      ELSE
        SELF.ResetQueue(Reset:Queue)
      END
      IF ~SELF.LoadPending
        SELF.PostNewSelection
        SELF.ResetFromView
        Rval = 1
      END
    END
    SELF.UpdateBuffer
    RETURN Rval

BrowseClass.TakeAcceptedLocator PROCEDURE
  CODE
    IF ~SELF.Sort.Locator &= NULL AND ACCEPTED() = SELF.Sort.Locator.Control
      IF SELF.Sort.Locator.TakeAccepted()
        SELF.Reset(SELF.GetFreeElementPosition())
        SELECT(SELF.ILC.GetControl())
        SELF.ResetQueue(Reset:Done)
        SELF.Sort.Locator.Reset
        SELF.UpdateWindow
        SELF.PostNewSelection
      END
    END

BrowseClass.TakeEvent PROCEDURE
VSP BYTE,AUTO
  CODE
    CASE FIELD()
    OF 0
      SELF.CurrentChoice = SELF.ILC.Choice()

    OF SELF.ILC.GetControl()
      CASE EVENT()
      OF EVENT:ScrollUp
      OROF EVENT:ScrollDown
      OROF EVENT:PageUp
      OROF EVENT:PageDown
      OROF EVENT:ScrollTop
      OROF EVENT:ScrollBottom
        SELF.TakeScroll
      OF EVENT:ScrollDrag
        VSP = SELF.ILC.GetControl(){PROP:VScrollPos}
        IF VSP <= 1
          POST(Event:ScrollTop,SELF.ILC.GetControl())
        ELSIF VSP = 100
          POST(Event:ScrollBottom,SELF.ILC.GetControl())
        ELSE
          IF ~(SELF.Sort.FreeElement &= NULL) AND ~(SELF.Sort.Thumb &= NULL)
            SELF.Sort.FreeElement = SELF.Sort.Thumb.GetValue(VSP)
            SELF.ResetFromBuffer
          ELSIF SELF.FileLoaded
            SELF.CurrentChoice = VSP / 100 * SELF.ListQueue.Records()
            SELF.TakeChoiceChanged
          ELSIF VSP < 50
            POST(Event:PageUp,SELF.ILC.GetControl())
          ELSIF VSP > 50
            POST(Event:PageDown,SELF.ILC.GetControl())
          END
        END
      OF EVENT:AlertKey
        SELF.TakeKey
      OF EVENT:NewSelection
        SELF.TakeNewSelection
      OF EVENT:Locate
        SELF.TakeLocate
      END
    END
    IF SELF.QueryControl AND FIELD() = SELF.QueryControl
       IF EVENT() = EVENT:NewSelection
          ASSERT(~SELF.Query&=NULL)
          IF self.query.Take(SELF.Popup) THEN
             SELF.TakeLocate()
          END
       END
    END

    SELF.NeedRefresh = FALSE

    CASE ACCEPTED()
    OF 0
    OF SELF.DeleteControl
      SELF.Window.Update()
      IF  NOT SELF.NeedRefresh
        SELF.Ask(DeleteRecord)
      END
    OF SELF.ChangeControl
      SELF.Window.Update()
      IF  NOT SELF.NeedRefresh
        SELF.Ask(ChangeRecord)
      END
    OF SELF.InsertControl
      SELF.Window.Update()
      IF  NOT SELF.NeedRefresh
        SELF.Ask(InsertRecord)
      END
  OF SELF.ViewControl
      SELF.Window.Update
      IF  NOT SELF.NeedRefresh
        SELF.Ask(ViewRecord)
      END
    OF SELF.SelectControl
      SELF.Window.Response = RequestCompleted
      POST(EVENT:CloseWindow)
    OF SELF.PrintControl
      SELF.UpdateViewRecord
      IF  NOT SELF.NeedRefresh
        SELF.Window.Run(SELF.PrintProcedure,ProcessRecord)
        SELF.UpdateBuffer   ! Print procedure probably corrupts hot-fields
      END
    OF SELF.QueryControl
      CLEAR(SELF.Query.QkCurrentQuery) ! Set Query for non-QuickQBE Mode.
      SELF.TakeLocate
    OF SELF.ToolControl
      SELF.Popup.Toolbox('Browse Actions')
    ELSE
      SELF.TakeAcceptedLocator
    END
    IF  SELF.NeedRefresh
      SELF.ResetQueue (Reset:Done)
      SELF.NeedRefresh = FALSE
    ELSIF EVENT() = EVENT:CloseWindow AND SELF.Selecting
      IF SELF.Window.Response = RequestCompleted
        SELF.Primary.Me.RestoreBuffer(SELF.Buffer,0)
        IF SELF.SelectWholeRecord
          SELF.UpdateViewRecord
        ELSE
          SELF.UpdateBuffer
        END
      ELSE
        SELF.Primary.Me.RestoreBuffer(SELF.Buffer)
      END
    END

BrowseClass.TakeLocate PROCEDURE
CurSort USHORT,AUTO
I USHORT,AUTO
  CODE
    IF ~SELF.Query&=NULL
       IF SELF.Query.Ask()
          DO SS ! Set Sort.
       END
       IF SELF.Query.QkSupport AND ~(SELF.Popup &= NULL)
          SELF.Query.SetQuickPopup(SELF.Popup,SELF.QueryControl) ! Remap Right-click popup.
       END
    END

SS ROUTINE
  IF SELF.QueryShared
     CurSort = POINTER(SELF.Sort)
     LOOP I = 1 TO RECORDS(SELF.Sort)
        PARENT.SetSort(I)
        DO SF
     END
     PARENT.SetSort(CurSort)
  ELSE
     DO SF
  END
  SELF.ResetSort(1)

SF ROUTINE
  SELF.SetFilter(SELF.Query.GetFilter(),'9 - QBE')
  IF SELF.QueryResult
    SELF.QueryResult{PROP:Text} = SELF.Query.GetFilter()
  END

BrowseClass.TakeKey PROCEDURE
  CODE
  IF KEYCODE() = MouseRightUp
    IF SELF.ILC.GetControl(){PROPLIST:mousedownrow}>0
      SELF.CurrentChoice = SELF.ILC.GetControl(){PROPLIST:mousedownrow}
    END
    SELF.PostNewSelection
  ELSE
    IF SELF.ListQueue.Records()
      CASE KEYCODE()
      OF InsertKey
        DO CheckInsert
      OF DeleteKey
        IF SELF.DeleteControl
          POST(EVENT:Accepted,SELF.DeleteControl)
          DO HandledOut
        END
      OF CtrlEnter
        DO CheckChange
      OF ShiftEnter
        DO CheckView
      OF MouseLeft2
        IF SELF.Selecting
          IF SELF.SelectControl
            POST(EVENT:Accepted,SELF.SelectControl)
            DO HandledOut
          END
        ELSE
          DO CheckChange
        END
      ELSE
        DO CheckLocator
      END
    ELSE
      DO CheckLocator
      DO CheckInsert
    END
  END
  RETURN 0

CheckLocator ROUTINE
  IF ~(SELF.Sort.Locator &= NULL)
    IF SELF.Sort.Locator.TakeKey()
      SELF.Reset(SELF.GetFreeElementPosition())
      SELF.ResetQueue(Reset:Done)
      DO HandledOut
    ELSE
      IF SELF.ListQueue.Records()
        DO HandledOut
      END
    END
  END

HandledOut ROUTINE
  SELF.UpdateWindow
  SELF.PostNewSelection
  RETURN 1

CheckInsert ROUTINE
  IF SELF.InsertControl AND KEYCODE() = InsertKey
    POST(EVENT:Accepted,SELF.InsertControl)
    DO HandledOut
  END

CheckChange ROUTINE
  IF SELF.ChangeControl
    POST(EVENT:Accepted,SELF.ChangeControl)
    SELF.UpdateBuffer
    DO HandledOut
  END

CheckView ROUTINE
  IF SELF.ViewControl
    POST(EVENT:Accepted, SELF.ViewControl)
    SELF.UpdateBuffer
    DO HandledOut
  END

BrowseClass.TakeNewSelection PROCEDURE
  CODE
  IF SELF.ListQueue.Records()
    SELF.CurrentChoice = SELF.ILC.Choice()
    SELF.LastChoice = SELF.CurrentChoice
  END
  SELF.UpdateBuffer
  IF KEYCODE() = MouseRightUp
    SELF.Popup.Ask()
  ELSE
    SELF.Window.Reset
  END

BrowseClass.TakeScroll PROCEDURE(SIGNED E)
  CODE
  IF ~E
    E = EVENT()
  END
  IF SELF.ListQueue.Records()
    CASE E
    OF Event:ScrollUp OROF Event:ScrollDown
      SELF.ScrollOne(E)
    OF Event:PageUp OROF Event:PageDown
      SELF.ScrollPage(E)
    OF Event:ScrollTop OROF Event:ScrollBottom
      SELF.ScrollEnd(E)
    END
    SELF.TakeChoiceChanged
  END

BrowseClass.TakeChoiceChanged PROCEDURE
  CODE
    IF ~SELF.Sort.Locator &= NULL
      SELF.Sort.Locator.Set
    END
    SELF.PostNewSelection
    IF SELF.Sort.Thumb &= NULL
      SELF.UpdateThumbFixed
    END
    SELF.UpdateBuffer

BrowseClass.TakeVCRScroll PROCEDURE(SIGNED Vcr)
  CODE
    CASE Vcr
    OF VCR:Forward
      SELF.TakeScroll(Event:ScrollDown)
    OF VCR:Backward
      SELF.TakeScroll(Event:ScrollUp)
    OF VCR:PageForward
      SELF.TakeScroll(Event:PageDown)
    OF VCR:PageBackward
      SELF.TakeScroll(Event:PageUp)
    OF VCR:First
      SELF.TakeScroll(Event:ScrollTop)
    OF VCR:Last
      SELF.TakeScroll(Event:ScrollBottom)
    ELSE
      RETURN
    END
    SELF.Window.Reset
    SELF.Window.Update

BrowseClass.UpdateBuffer PROCEDURE
  CODE
    IF SELF.ListQueue.Records()
      SELF.ListQueue.Fetch(SELF.CurrentChoice)
      SELF.Fields.AssignRightToLeft
    ELSE
      SELF.Fields.ClearLeft
    END

BrowseClass.UpdateQuery PROCEDURE(QueryClass QC, BYTE Caseless)
I USHORT(1)
FN CSTRING(100)
  CODE
  ASSERT(SELF.Query &= NULL)
  SELF.Query &= QC
  LOOP WHILE SELF.ILC.GetControl(){PROPLIST:Exists,I}
    FN = SELF.ListQueue.Who(SELF.ILC.GetControl(){PROPLIST:FieldNo,I})
    IF CaseLess
       FN = 'UPPER(' & FN & ')'
    END
    IF FN
      QC.AddItem(FN,SELF.ILC.GetControl(){PROPLIST:header,I},SELF.ILC.GetControl(){PROPLIST:picture,I})
    END
    I += 1
  END

BrowseClass.UpdateResets PROCEDURE
  CODE
    SELF.Sort.Resets.AssignRightToLeft

BrowseClass.UpdateThumbFixed PROCEDURE
Pos BYTE(50)
  CODE
  IF SELF.FileLoaded
    Pos = SELF.CurrentChoice/SELF.ListQueue.Records()*100
  ELSE
    IF SELF.ItemsToFill
      CASE SELF.CurrentEvent
      OF Event:ScrollDown
      OROF Event:PageDown
      OROF Event:ScrollBottom
        IF SELF.CurrentChoice = SELF.ListQueue.Records()
          Pos = 100
        END
      ELSE
        IF SELF.CurrentChoice = 1
          Pos = 0
        END
      END
    END
  END
  SELF.ILC.GetControl(){PROP:VScrollPos} = Pos

!|
!| This routine is used to retrieve the VIEW record that corresponds to a
!| chosen listbox record.
!|
BrowseClass.UpdateViewRecord    PROCEDURE
  CODE
    IF SELF.ListQueue.Records()
      SELF.CurrentChoice = SELF.ILC.Choice()
      SELF.ListQueue.Fetch(SELF.CurrentChoice)
      WATCH(SELF.View)
      REGET(SELF.View,SELF.ListQueue.GetViewPosition())
      IF  ERRORCODE()
        SELF.NeedRefresh = SELF.NotifyUpdateError()
      END
    END

BrowseClass.UpdateWindow PROCEDURE
  CODE
    IF ~(SELF.Sort.Locator &= NULL)
      SELF.Sort.Locator.UpdateWindow
    END
    IF SELF.Records()
      IF SELF.ChangeControl
        ENABLE(SELF.ChangeControl)
      END
      IF SELF.DeleteControl
        ENABLE(SELF.DeleteControl)
      END
      IF SELF.PrintControl
        ENABLE(SELF.PrintControl)
      END
    ELSE
      IF SELF.ChangeControl
        DISABLE(SELF.ChangeControl)
      END
      IF SELF.DeleteControl
        DISABLE(SELF.DeleteControl)
      END
      IF SELF.PrintControl
        DISABLE(SELF.PrintControl)
      END
    END
    IF SELF.SelectControl
      IF SELF.Selecting
        IF SELF.RECORDS() AND SELF.Window.Request = SelectRecord
          ENABLE(SELF.SelectControl)
          SELF.SelectControl{PROP:Default} = 1
        ELSE
          DISABLE(SELF.SelectControl)
        END
      ELSIF SELF.HideSelect
        DISABLE(SELF.SelectControl)   ! For the benefit of the toolbar
        HIDE(SELF.SelectControl)
      END
    END
    SELF.UpdateThumb
    IF ~SELF.Toolbar &= NULL
      SELF.Toolbar.DisplayButtons
    END
    DISPLAY(SELF.ILC.GetControl())
    SELF.ILC.SetChoice(SELF.CurrentChoice)

BrowseClass.UpdateThumb PROCEDURE
  CODE
  IF SELF.HasThumb AND ( SELF.ListQueue.Records() >= SELF.ILC.GetItems() OR SELF.AllowUnfilled )
    SELF.ILC.GetControl(){Prop:VScroll} = True
    IF SELF.Sort.Thumb &= NULL OR SELF.Sort.FreeElement &= NULL
      SELF.UpdateThumbFixed
    ELSIF SELF.Loaded AND ~SELF.LoadPending
      SELF.UpdateBuffer
      SELF.ILC.GetControl(){PROP:VScrollPos} = SELF.Sort.Thumb.GetPercentile(SELF.Sort.FreeElement)
    END
  ELSE
    SELF.ILC.GetControl(){Prop:VScroll} = False
  END

BrowseClass.UpdateToolbarButtons PROCEDURE
  CODE
    IF SELF.InsertControl
      SELF.ToolbarItem.InsertButton = SELF.InsertControl
    END
    IF SELF.DeleteControl
      SELF.ToolbarItem.DeleteButton = SELF.DeleteControl
    END
    IF SELF.ChangeControl
      SELF.ToolbarItem.ChangeButton = SELF.ChangeControl
    END
    IF SELF.SelectControl
      SELF.ToolbarItem.SelectButton = SELF.SelectControl
    END
    IF SELF.QueryControl
      SELF.ToolbarItem.LocateButton = SELF.QueryControl
    END
    SELF.Toolbar.SetTarget(SELF.ILC.GetControl())

BrowseClass.WindowComponent.Kill         PROCEDURE
  CODE
  SELF.Kill

BrowseClass.WindowComponent.TakeEvent    PROCEDURE
  CODE
  SELF.TakeEvent
  RETURN Level:Benign

BrowseClass.WindowComponent.SetAlerts    PROCEDURE
  CODE
  SELF.SetAlerts

BrowseClass.WindowComponent.Reset        PROCEDURE(BYTE Force)
  CODE
  SELF.ResetSort(Force)

BrowseClass.WindowComponent.ResetRequired PROCEDURE
  CODE
  RETURN SELF.ApplyRange()

BrowseClass.WindowComponent.Update       PROCEDURE
  CODE
  SELF.UpdateViewRecord

BrowseClass.WindowComponent.UpdateWindow PROCEDURE
  CODE
  SELF.UpdateWindow

! Locator classes
LocatorClass.Init PROCEDURE(SIGNED Control,*? Free,BYTE NoCase,<BrowseClass VM>)
  CODE
    SELF.FreeElement &= Free
    SELF.Control = Control
    SELF.NoCase = NoCase
    SELF.ViewManager &= VM

LocatorClass.Destruct PROCEDURE
  CODE
    SELF.FreeElement &= NULL

LocatorClass.Reset PROCEDURE
  CODE

LocatorClass.SetAlerts PROCEDURE(SIGNED S)
  CODE

LocatorClass.SetEnabled PROCEDURE(BYTE E)
  CODE
    IF SELF.Control
      SELF.Control{PROP:Disable} = CHOOSE(E=0)
    END

LocatorClass.TakeAccepted PROCEDURE
  CODE
    RETURN 0

LocatorClass.TakeKey PROCEDURE
  CODE
    RETURN 0

LocatorClass.Set PROCEDURE
  CODE
    SELF.FreeElement = ''

LocatorClass.GetShadow PROCEDURE
  CODE
  RETURN ''

LocatorClass.SetShadow PROCEDURE(STRING S)
  CODE

LocatorClass.UpdateWindow PROCEDURE
  CODE
    SELF.Set ! Locators typically 'one-shot' so updateing the screen nullifies them

StepLocatorClass.Set PROCEDURE
  CODE

StepLocatorClass.TakeKey PROCEDURE
Key BYTE,AUTO
Handled BYTE(0)
  CODE
    Key = KEYCHAR()
    IF Key
      IF RECORDS(SELF.ViewManager.ListQueue)
        Handled = 1
        SELF.ViewManager.ScrollOne(EVENT:ScrollDown)
        SELF.ViewManager.UpdateBuffer
      END
      IF SELF.NoCase AND UPPER(SUB(SELF.FreeElement,1,1)) <> UPPER(CHR(Key)) OR |
         ~SELF.NoCase AND SUB(SELF.FreeElement,1,1) <> CHR(Key)
        SELF.FreeElement = CHR(Key)
        Handled = 1
      END
    END
    RETURN Handled

EntryLocatorClass.TakeAccepted PROCEDURE
  CODE
    UPDATE(SELF.Control)
    SELF.FreeElement = SELF.Shadow
    IF SELF.FreeElement
      RETURN 1
    ELSE
      RETURN 0
    END

EntryLocatorClass.GetShadow PROCEDURE
  CODE
  RETURN SELF.Shadow

EntryLocatorClass.SetShadow PROCEDURE(STRING S)
  CODE
  SELF.Shadow = S

EntryLocatorClass.TakeKey PROCEDURE
  CODE
    IF KEYCHAR() <> 0 AND SELF.Control{PROP:Enabled}
      SELECT(SELF.Control)
      FORWARDKEY(SELF.Control)
    END
    RETURN 0

EntryLocatorClass.Init PROCEDURE(SIGNED Control,*? Free,BYTE NoCase,<BrowseClass VM>)
  CODE
    PARENT.Init(Control,Free,NoCase,VM)
    Control{PROP:Use} = SELF.Shadow

EntryLocatorClass.Update PROCEDURE
  CODE
    SELF.FreeElement = CHOOSE(SELF.NoCase,UPPER(SELF.Shadow),SELF.Shadow)
    SELF.UpdateWindow

EntryLocatorClass.Set PROCEDURE
  CODE
    CLEAR(SELF.Shadow)
    SELF.Control{PROP:Use} = SELF.Shadow
    PARENT.Set
    SELF.Update

EntryLocatorClass.UpdateWindow PROCEDURE
  CODE
    DISPLAY(SELF.Control)

IncrementalLocatorClass.SetAlerts PROCEDURE(SIGNED S)
  CODE
    S{PROP:Alrt,250} = BSKey
    S{PROP:Alrt,251} = SpaceKey

IncrementalLocatorClass.TakeKey PROCEDURE
Key BYTE,AUTO
  CODE
    Key = KEYCHAR()
    IF KEYCODE() = BSKey
      IF LEN(SELF.Shadow)
        SELF.Shadow = SELF.Shadow[1:LEN(SELF.Shadow) - 1]
      END
      SELF.Update
      RETURN 1
    ELSIF KEYCODE() = SpaceKey OR Key
      SELF.Shadow = SELF.Shadow & CHOOSE(KEYCODE()=SpaceKey,' ',CHR(Key))
      SELF.Update
      RETURN 1
    END
    RETURN 0

FilterLocatorClass.Reset PROCEDURE
  CODE

FilterLocatorClass.UpdateWindow PROCEDURE
FN CSTRING(100),AUTO
SN CSTRING(100),AUTO
  CODE
    ASSERT(~SELF.ViewManager &= NULL)
    FN = SELF.ViewManager.GetFreeElementName()
    SN = CHOOSE(INSTRING('UPPER(',FN,1,1) = 0,SELF.Shadow,UPPER(SELF.Shadow))
    IF SELF.FloatRight
      SELF.ViewManager.SetFilter(CHOOSE(SN='','','INSTRING('''&SN&''','&FN&',1,1) <<> 0'),'3 Locator')
    ELSE
      SELF.ViewManager.SetFilter('SUB('&FN&',1,'&LEN(SELF.Shadow)&') = '''& SN & '''','3 Locator')
    END
    SELF.ViewManager.ApplyFilter()
    SELF.FreeElement = SELF.Shadow
    DISPLAY(SELF.Control)

FilterLocatorClass.TakeAccepted PROCEDURE
  CODE
    UPDATE(SELF.Control)
    SELF.Shadow = CLIP(CONTENTS(SELF.Control))
    IF SELF.FreeElement
      SELF.UpdateWindow
      RETURN 1
    ELSE
      RETURN 0
    END

BrowseEIPManager.Init PROCEDURE
RetVal BYTE(RequestCancelled)
AtEnd  BYTE,AUTO
  CODE
  SELF.BC.CurrentChoice = CHOICE(SELF.ListControl)
  CASE SELF.Req
  OF InsertRecord
    IF SELF.BC.ListQueue.Records()
      IF SELF.Insert = EIPAction:Append
        SELF.BC.ScrollEnd(Event:ScrollBottom)
      END
      IF SELF.BC.PrimeRecord()
        RETURN Level:Fatal
      END
      SELF.BC.Primary.Save()
      AtEnd = CHOOSE(SELF.BC.CurrentChoice = SELF.BC.ListQueue.Records())
      SELF.BC.CurrentChoice = CHOOSE(SELF.Insert=EIPAction:Before, SELF.BC.CurrentChoice,SELF.BC.CurrentChoice+1)
      IF SELF.BC.ListQueue.Records() >= SELF.BC.LastItems
        IF AtEnd
          SELF.BC.ListQueue.Fetch(1)
          SELF.BC.CurrentChoice -= 1
        ELSE
          SELF.BC.ListQueue.Fetch(SELF.BC.ListQueue.Records())
        END
        SELF.BC.ListQueue.Delete()
      END
    ELSE
      IF SELF.BC.PrimeRecord()
        RETURN Level:Fatal
      END
      SELF.BC.Primary.Save()
      SELF.BC.CurrentChoice = 1
    END
    SELF.BC.SetQueueRecord
    SELF.BC.ListQueue.Insert(SELF.BC.CurrentChoice)
    ASSERT(~ERRORCODE())
    DISPLAY(SELF.ListControl)
    SELECT(SELF.ListControl,SELF.BC.CurrentChoice)
    SELF.Column = 1
  OF DeleteRecord
    RetVal = CHOOSE(SELF.BC.Primary.Delete() = Level:Benign,RequestCompleted,RequestCancelled)
    SELF.Response = RetVal
    RETURN Level:Fatal
  OF ChangeRecord
    SELF.BC.SetQueueRecord()    ! Buffers are 'fresh' make sure queue record is too
    SELF.BC.ListQueue.Update()
    SELF.BC.Primary.Save()
    IF KEYCODE() = MouseLeft2
      SELF.Column = SELF.ListControl{PROPLIST:MouseUpField}
    END
  ELSE
    ASSERT(0)
  END
  SELF.BC.ListQueue.Fetch(SELF.BC.CurrentChoice)
  SELF.ListControl{PROP:Alrt,MouseLeft2Index} = 0 ! Prevent alert short-stopping double click
  RETURN PARENT.Init()

BrowseEIPManager.Kill PROCEDURE
  CODE
  SELF.BC.ResetFromAsk(SELF.Req,SELF.Response)
  RETURN PARENT.Kill()

BrowseEIPManager.TakeNewSelection PROCEDURE
  CODE
  IF FIELD() = SELF.ListControl
    IF CHOICE(SELF.ListControl) = SELF.BC.CurrentChoice
      RETURN PARENT.TakeNewSelection()
    ELSE                                  ! Focus change to different record
      SELF.TakeFocusLoss
      IF SELF.Again
        SELECT(SELF.ListControl,SELF.BC.CurrentChoice)
        RETURN Level:Benign
      ELSE
        SELF.BC.CurrentChoice = CHOICE(SELF.ListControl)
        SELF.Response = RequestCancelled           ! Avoid cursor following 'new' record
        RETURN Level:Fatal
      END
    END
  END

BrowseEIPManager.TakeCompleted PROCEDURE(BYTE Force)
SaveAns UNSIGNED,AUTO
Id      USHORT,AUTO
  CODE
  SELF.Again = 0
  SELF.ClearColumn
  SaveAns = CHOOSE(Force = 0,Button:Yes,Force)
  IF SELF.Fields.Equal()
    SaveAns = Button:No
  ELSE
    IF ~Force
      SaveAns = SELF.Errors.Message(Msg:SaveRecord,Button:Yes+Button:No+Button:Cancel,Button:Yes)
    END
  END
  Force = 0
  SELF.Response = RequestCancelled
  CASE SaveAns
  OF Button:Cancel
    SELF.Again = 1
  OF Button:No
    IF SELF.Req = InsertRecord
      SELF.BC.ListQueue.Delete()
      IF SELF.BC.CurrentChoice AND SELF.Insert <> EIPAction:Before
        SELF.BC.CurrentChoice -= 1
      END
      SELF.BC.Primary.Me.CancelAutoInc()
    END
  OF Button:Yes
    Id = SELF.BC.Primary.Me.SaveBuffer()
    SELF.BC.UpdateBuffer
    IF CHOOSE(SELF.Req = InsertRecord,SELF.BC.Primary.Me.Insert(),SELF.BC.Primary.Update()) <> Level:Benign
      SELF.Again = 1
    ELSE
      SELF.Response = RequestCompleted
    END
    SELF.BC.Primary.Me.RestoreBuffer(Id,SELF.Again)
    FLUSH(SELF.BC.View)
  END
  PARENT.TakeCompleted(Force)

BrowseEIPManager.ClearColumn PROCEDURE
  CODE
  IF SELF.LastColumn
    UPDATE
    SELF.BC.ListQueue.Update()
    ASSERT(~ERRORCODE())
  END
  PARENT.ClearColumn
