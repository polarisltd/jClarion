  MEMBER
  MAP
    MakeOperator(String opers,string lead_opers),string
    MakeOperator(String opers,string lead_opers,*CSTRING Opers,*CSTRING Stripped)
  .
  INCLUDE('aberror.inc'),ONCE
  INCLUDE('abutil.inc'),ONCE
  INCLUDE('abquery.inc'),ONCE
  INCLUDE('abeip.inc'),ONCE
  INCLUDE('abpopup.inc'),ONCE
  INCLUDE('abquery.trn'),ONCE
  INCLUDE('KEYCODES.CLW'),ONCE

FieldQueue QUEUE,TYPE
Name             CSTRING(100)
Title            CSTRING(100)
Picture          CSTRING(40)
QueryString      CSTRING(1500)
Low              &CSTRING
Middle           &CSTRING
High             &CSTRING
ForceEditPicture BYTE
  END

PopupQueue QUEUE,TYPE
QueryName        CSTRING(100)
PopupID          CSTRING(100)
  END

ValueList QUEUE,TYPE
Field CSTRING(100)
Ops   CSTRING(10)
Value CSTRING(100)
  END

StringList QUEUE,TYPE
Value CSTRING(100)
  END


QEIPManager CLASS(EIPManager),TYPE
Q                    &ValueList
Visual               &QueryListVisual
ClearColumn          PROCEDURE,DERIVED
Init                 PROCEDURE,BYTE,DERIVED,PROC
TakeCompleted        PROCEDURE(BYTE Force),DERIVED
TakeNewSelection     PROCEDURE,DERIVED,BYTE,PROC
TakeEvent            PROCEDURE,DERIVED,BYTE,PROC
           END

QueryClass.AddItem   PROCEDURE(STRING FieldName, STRING Title, <STRING Picture>,BYTE ForceEditPicture=1)
  CODE
    ASSERT(~SELF.Fields &= NULL)
    CLEAR(SELF.Fields)
    SELF.Fields.Title = Title
    SELF.Fields.Name = UPPER(FieldName)
    SELF.Fields.Picture = CLIP(Picture)
    IF SELF.Fields.Picture[1] = '@' THEN SELF.Fields.Picture = SELF.Fields.Picture[2:LEN(SELF.Fields.Picture)].
    IF SELF.Fields.Picture[1] = 's' THEN SELF.Fields.Picture[1] = 'S'.
    IF ~SELF.Fields.Picture THEN SELF.Fields.Picture = 'S255'.
    SELF.Fields.ForceEditPicture = ForceEditPicture
    ADD(SELF.Fields)

QueryClass.Quote PROCEDURE(STRING Value)
RV CSTRING(1000),AUTO
I UNSIGNED,AUTO
RVP UNSIGNED,AUTO
  CODE
    RV[1] = ''''
    RVP = 2
    LOOP I = 1 TO LEN(Value)
      LOOP 1 + CHOOSE(Value[I] = '''') TIMES
        RV[RVP] = Value[I]
        RVP += 1
      END
    END
    RV[RVP :RVP+1] = '''<0>'
    RETURN Rv


! Default tries to match 'record buffers'
QueryClass.Ask       PROCEDURE(BYTE UseLast=1)
I USHORT,AUTO
EV CSTRING(1000),AUTO

W    WINDOW(DefaultWindowText),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI),CENTER,TILED,SYSTEM, |
         GRAY,RESIZE
       SHEET,AT(5,4,301,206),USE(?Sheet1,Feq:SheetControl)
         TAB(DefaultSaveTabName),USE(?Tab1,Feq:SaveRestoreTab)
         END
         TAB(DefaultSettingsName),USE(?Tab2,Feq:ControlTab)
         END
       END
       BUTTON(DefaultOkName),AT(,,50,14),USE(?Ok,Feq:OK),DEFAULT
       BUTTON(DefaultCancelName),AT(,,50,14),USE(?Cancel,Feq:Cancel)
       BUTTON(DefaultClearName),AT(0,15,50,14),USE(?Clear,Feq:Clear)
     END

  CODE
    IF SELF.Win &= NULL
     SELF.Reset
     LOOP I = 1 TO RECORDS(SELF.Fields)
       GET(SELF.Fields,I)
       EV = CLIP(EVALUATE(SELF.Fields.Name))
       IF EV
          SELF.SetLimit(SELF.Fields.Name,,,EV)
       END
     END
     RETURN Level:Notify
    ELSE
     IF SELF.QkCurrentQuery
        RETURN 1
     ELSE
        SELF.ParentWindow &= SYSTEM{Prop:Target}
        OPEN(W)
        SELF.Window &= W

        W{Prop:WallPaper} = '~'  & SELF.ParentWindow{Prop:Wallpaper}
        W{Prop:Tiled} = SELF.ParentWindow{Prop:Tiled}

        W{Prop:Font} = SELF.ParentWindow{Prop:Font}
        LOOP I = Feq:FirstControl To Feq:LastControl
         I{Prop:FontName} = SELF.ParentWindow{Prop:FontName}
        END

        IF ~UseLast THEN SELF.Reset().
        RETURN CHOOSE(SELF.Win.Run()=RequestCancelled,Level:Benign,Level:Notify)
     END
    END

QueryClass.Reset PROCEDURE(<STRING FieldName>)
I USHORT,AUTO
  CODE
    IF OMITTED(2)
      LOOP I = 1 TO RECORDS(SELF.Fields)
        GET(SELF.Fields,I)
        SELF.Reset(SELF.Fields.Name)
      END
    ELSE
      SELF.SetLimit(FieldName,'','','')
    END


QueryClass.GetFilter PROCEDURE
! No picture indicates that the Value is in raw form.
! A Non string picture indicates that the source data field needs to be formatted for instring or Sub
! A String picture indicates that the data needs to be quoted where non-string data is not.
I USHORT,AUTO
Filter  CSTRING(5000)
Sy      CSTRING(20),AUTO
Value   CSTRING(1000)
Picture CSTRING(20),AUTO
CaseLess BYTE,AUTO
High     BYTE
  CODE
    LOOP I = 1 TO RECORDS(SELF.Fields)
      GET(SELF.Fields,I)
      LOOP
        Picture = SELF.Fields.Picture ! If the value is deformatted the picture will be cleared, for a query with a Low and High value the second value still needs the picture for deformatting.
        High = SELF.GetLimit(Value,Sy,CaseLess,High,Picture)  ! Value is 'raw'
        IF Value OR Sy
          DO PictureAndCase
          DO CaseLess
          CASE Sy
          OF Query:Contains  ! Must have 'formatted' data
            Filter = Filter & 'INSTRING(' & SELF.Quote(Value) & ',' & CLIP(SELF.Fields.Name) & ',1,1) <> 0'
          OF Query:Begins
            Filter = Filter & 'SUB(' & CLIP(SELF.Fields.Name) & ',1,' & LEN(Value) & ') = ' & SELF.Quote(Value)
          ELSE
            Filter = Filter & '(' & CLIP(SELF.Fields.Name) & ' ' & MakeOperator(Sy,'') & ' ' & CHOOSE(Picture = '' OR Picture[1]<>'S',Value,SELF.Quote(Value)) & ')'
          END
        END
      WHILE High
    END
    RETURN Filter

PictureAndCase ROUTINE
      IF (Sy = Query:Contains OR Sy = Query:Begins) AND (Picture AND Picture[1] <> 'S') ! Value is in formatted form, if non-String then Field is Formatted.
         SELF.Fields.Name = 'FORMAT(' & SELF.Fields.Name & ',@' & Picture & ')'
         CaseLess = True         ! Force caseless for non-String Begins and Contains.
      END
      IF (Sy = '<<>' AND NOT Value AND Picture[1] <> 'S')
         Value = 0
      END

Caseless ROUTINE
    IF CaseLess
      Value = UPPER(Value)
      IF Value[1] = '^' ! Remove magic carat from value for filter.
         Value = Value[2:Len(Value)]
      END
      IF ~INSTRING('UPPER(',SELF.Fields.Name,1,1)
        SELF.Fields.Name = 'UPPER('&SELF.Fields.Name&')'
      END
    END
    IF Filter THEN Filter = Filter & ' AND ' .

! Convention :
!   High & Low fields combine with middle if same exists
!   Any 'equivalence' symbol at the start of a value is 'or'd into the symbol to come
!   A * at the end of the middle value means 'starts with'
!   A * at the begining of the middle value means 'ends with'

QueryClass.GetLimit PROCEDURE(STRING FieldName,*CSTRING Value,*CSTRING Operator,*BYTE CaseLess)
  CODE
    SELF.FindName(FieldName)
    SELF.Fields.ForceEditPicture = False   ! *** User does not accept formatting
    PUT(SELF.Fields)
    SELF.GetLimit(Value,Operator,CaseLess)

QueryClass.GetLimit PROCEDURE(STRING FieldName,*CSTRING Value,*CSTRING Operator,*BYTE CaseLess,*CSTRING Picture)
  CODE
    SELF.FindName(FieldName)
    SELF.GetLimit(Value,Operator,CaseLess,Picture)

QueryClass.GetLimit PROCEDURE(*CSTRING Value,*CSTRING Operator,*BYTE CaseLess,BYTE High)
Dummy CSTRING(100)
RVal  BYTE
  CODE
    SELF.Fields.ForceEditPicture = False   ! *** User does not accept formatting
    PUT(SELF.Fields)
    RVal = SELF.GetLimit(Value,Operator,CaseLess,High,Dummy)
    RETURN RVal


QueryClass.GetLimit PROCEDURE(*CSTRING Value,*CSTRING Operator,*BYTE CaseLess,BYTE High,*CSTRING Picture)
Rval    BYTE
IsS     BYTE,AUTO
  CODE
    CaseLess = 0
    Operator = ''
    IsS = CHOOSE(SELF.Fields.Picture[1] = 'S',1,0)
    IF NOT SELF.Fields.Low &= NULL AND ~High
      IF NOT SELF.Fields.High &= NULL
        RVal = Level:Notify
      END
      Operator = '>'
      Value = SELF.Fields.Low
      DO ParseBound
      DO MakeUnformatted
      RETURN RVal
    END
    IF NOT SELF.Fields.High &= NULL
      ASSERT(High OR SELF.Fields.Low &= NULL)
      Operator = '<<'
      Value = SELF.Fields.High
      DO ParseBound
      DO MakeUnformatted
      RETURN RVal
    END
    Value = CHOOSE (SELF.Fields.Middle &= NULL, '', SELF.Fields.Middle)
    DO ParseBound
    IF Value[1] = '*'
      Operator = Query:Contains
      Value = Value[2:LEN(Value)]
    ELSIF Value[LEN(Value)]='*'
      Operator = Query:Begins
      Value = Value[1:LEN(Value)-1]
    END
    IF Value[1] = '^'  ! When the carat is the second character i.e. *^
       CaseLess = 1
       Value = UPPER(Value[2:LEN(Value)])
    END
    IF Picture
       IF ~SELF.Fields.ForceEditPicture AND ~(Operator = Query:Contains OR Operator = Query:Begins)  !         *** Data is in formatted state.
          DO MakeUnformatted
       END
    END
    RETURN RVal

ParseBound ROUTINE
  IF NOT SELF.Fields.Middle &= NULL
?    ASSERT(SELF.Fields.Middle = Value)
    Operator = Operator & '='
  END
  MakeOperator(Operator,Value,Operator,Value)
  IF Value[1] = '^'
     CaseLess = 1
     Value = UPPER(Value[2:LEN(Value)])
  END
  IF INSTRING('UPPER(',SELF.Fields.Name,1,1)
    CaseLess = 1
    Value = UPPER(Value)
  END
  IF SELF.Fields.ForceEditPicture AND ~IsS ! nocase for unformatted non-string data.
     CaseLess = False
  END
  IF SELF.Fields.ForceEditPicture AND ~IsS  !         *** Data is in unformatted state.
    Clear(Picture)
  END

MakeUnformatted ROUTINE
  IF NOT Picture THEN EXIT.
  IF Picture[1] = 'S' THEN EXIT.
  Value = CHOOSE(Value='','',DEFORMAT(Value,Picture)) ! Don't deformat '' cause it will return 0
  CaseLess = False
  Clear(Picture) ! *** Data is in now in unformatted form.


QueryClass.SetQuickPopup PROCEDURE(PopupClass Popup, USHORT QueryControl)
QQ      &SectorQueue
sm      USHORT
pID STRING(100)
sbMenu  BYTE
 CODE
 QQ &= NEW SectorQueue
 IF Records(SELF.PopupList) ! A Submenu exists
    sm = 1
    LOOP Until NOT Records(SELF.PopupList)
     GET(SELF.PopupList,sm)
     Popup.DeleteItem(SELF.PopupList.PopupID)
     DELETE(SELF.PopupList)
    END
    sbMenu = True
 ELSE
    sbMenu = False ! Need to create a SubMenu
 END
 FREE(SELF.PopupList) !
 SELF.GetQueries( QQ )
 SORT(QQ,QQ.Item)  ! Sort alphabetically
 IF Records(QQ)
    pID = DefaultQkQueryName ! remove with the line above once RH has put a return value in for AddSubMenu
    IF NOT sbMenu
       IF Popup.GetItems() ! Only if there are previous items.
          Popup.AddItem('-','Separator1',Popup.GetItems(),1)
       END
       Popup.AddSubMenu(DefaultQkQueryName,'','')
       pID = DefaultQkQueryName ! remove with the line above once RH has put a return value in for AddSubMenu
       !pID = Popup.AddSubMenu(DefaultQkQueryName,'','')
       Popup.SetIcon(pID,SELF.QkMenuIcon) ! IF RH can add returning the name this will prevent a possible bug if the DefaultQkQueryName has a & in it.
       sbMenu = True
    END
 ELSE
    IF sbMenu ! Save Query List is now empty, add an empty submenu and disable it. Need RH to add a return value for AddSubMenu so we can do the Delete.
       pID = Popup.AddItem('Empty       ','tsQBEEmpty',DefaultQkQueryName,2)
       Popup.SetItemEnable(pID,False) ! Disable the Empty item
       SELF.PopupList.PopupID = pID
       SELF.PopupList.QueryName = pID
       ADD(SELF.PopupList)
    END
 END
 LOOP sm = 1 to RECORDS(QQ)
  GET(QQ,sm)
  pID = Popup.AddItem(CLIP(QQ.Item) & '  ',Clip(QQ.Item),pID,2)
  Popup.SetIcon(pID,SELF.QkIcon)
  Popup.AddItemEvent(pID,EVENT:NewSelection,QueryControl)
  SELF.PopupList.PopupID = pID
  SELF.PopupList.QueryName = QQ:Item
  ADD(SELF.PopupList)
 END
 IF sbMenu ! Add a Clear Menu Option
    pID = Popup.AddItem('-','ClearSeparator  ',pID,2)
    SELF.PopupList.PopupID = pID
    SELF.PopupList.QueryName = pID
    ADD(SELF.PopupList)
    pID = Popup.AddItem(DefaultClearName,'tsQBEClear',pID,2)
    Popup.SetIcon(pID,SELF.QkIcon)
    Popup.AddItemEvent(pID,EVENT:NewSelection,QueryControl)
    SELF.PopupList.PopupID = pID
    SELF.PopupList.QueryName = 'tsQBEClear'
    ADD(SELF.PopupList)
 END
 DISPOSE(QQ)
 RETURN

QueryClass.Take PROCEDURE(PopupClass P)
 CODE
 ASSERT(~P &= NULL)
 IF SELF.QkSupport
    SELF.QkCurrentQuery = P.GetLastSelection()
    SELF.PopupList.PopupID = SELF.QkCurrentQuery
    GET(SELF.PopupList,SELF.PopupList.PopupID)
    IF Errorcode()
       SELF.ClearQuery()
    ELSE
       SELF.Restore(SELF.PopupList.QueryName)
    END
    SELF.Save('tsMRU') ! Save Most recently used for Browse\Report query sharing.
    RETURN 1
 END
 RETURN 0

QueryClass.FindName PROCEDURE(STRING FieldName)
  CODE
  SELF.Fields.Name = FieldName
  GET(SELF.Fields,SELF.Fields.Name)
  ASSERT(~ERRORCODE())

QueryClass.GetName PROCEDURE(STRING Title)
  CODE
  SELF.Fields.Title = Title
  GET(SELF.Fields,SELF.Fields.Title)
  ASSERT(~ERRORCODE())
  RETURN SELF.Fields.Name

QueryClass.GetLimit  PROCEDURE(STRING FieldName,*CSTRING Low,*CSTRING High,*CSTRING Eq)
  CODE
    SELF.FindName(FieldName)
    Low  = CHOOSE (SELF.Fields.Low &= NULL, '', SELF.Fields.Low)
    High = CHOOSE (SELF.Fields.High &= NULL, '', SELF.Fields.High)
    Eq   = CHOOSE (SELF.Fields.Middle &= NULL, '', SELF.Fields.Middle)


QueryClass.Init      PROCEDURE(<QueryVisual Q>)
  CODE
  SELF.Fields &= NEW FieldQueue
  IF NOT OMITTED(2)
     SELF.Win &= Q
  END

QueryClass.Init      PROCEDURE(QueryVisual Q, INIClass INIMgr, STRING Family, ErrorClass E)
  CODE
    SELF.Win &= Q
    SELF.Fields &= NEW FieldQueue
    SELF.INIMgr &= INIMgr
    SELF.Win.Errors &= E
    SELF.Errors &= E
    SELF.Family &= NEW STRING(Len(Clip(Family)))
    SELF.Family = Family
    SELF.PopupList &= NEW PopupQueue

QueryClass.Kill      PROCEDURE
  CODE
    DISPOSE(SELF.Fields)
    DISPOSE(SELF.Family)
    DISPOSE(SELF.PopupList)

QueryClass.SetLimit  PROCEDURE(STRING FieldName,<STRING Low>,<STRING High>,<STRING Eq>)
IsValue    BYTE,AUTO
  CODE
    IsValue = 3
    SELF.FindName(FieldName)
    IF OMITTED(3) OR Low = ''
      SELF.Fields.Low &= NULL
      IsValue -= 1
    ELSE
      SELF.Fields.QueryString = Low
      SELF.Fields.Low &= SELF.Fields.QueryString  ! Data always in Q in raw form
    END
    IF OMITTED(4) OR High = ''
      SELF.Fields.High &= NULL
      IsValue -= 1
    ELSE
      SELF.Fields.QueryString = High
      SELF.Fields.High &= SELF.Fields.QueryString
    END
    IF OMITTED(5) OR Eq = ''
      SELF.Fields.Middle &= NULL
      IsValue -= 1
    ELSE
      SELF.Fields.QueryString = Eq
      SELF.Fields.Middle &= SELF.Fields.QueryString
    END
    IF  NOT IsValue
      CLEAR (SELF.Fields.QueryString)
    END
    PUT(SELF.Fields)

QueryClass.Save PROCEDURE(STRING QueryName)
  CODE
  SELF.INIMgr.AddSector(SELF.INIMgr.GetSector(SELF.Family,QueryName,'Query'))
  SELF.INIMgr.Update('Query',SELF.INIMgr.GetSector(SELF.Family,QueryName,'Query'),SELF.Fields,SELF.Fields.Name,SELF.Fields.QueryString)
  !*** would be nice to have an INI method to save the sectors at this point jvn?

QueryClass.Delete PROCEDURE(STRING QueryName)
  CODE
  SELF.INIMgr.DeleteSector(SELF.INIMgr.GetSector(SELF.Family,QueryName,'Query'))
  !*** would be nice to have an INI method to save the sectors at this point jvn?

QueryClass.ClearQuery   PROCEDURE
J    USHORT
  CODE
  LOOP J=1 TO RECORDS(SELF.Fields) ! Clear current Query.
   GET(SELF.Fields,J)
   CLEAR (SELF.Fields.QueryString)
   SELF.Fields.Low &= NULL
   SELF.Fields.Middle &= NULL
   SELF.Fields.High &= NULL
   PUT(Self.Fields)
  END

QueryClass.Restore PROCEDURE(STRING QueryName)
RestoreFields   &FieldQueue
I    USHORT
  CODE
  RestoreFields &= NEW FieldQueue
  SELF.ClearQuery()

  FREE(RestoreFields)
  SELF.INIMgr.FetchQueue('Query',SELF.INIMgr.GetSector(SELF.Family,QueryName,'Query'),RestoreFields,RestoreFields.Name, RestoreFields.QueryString)
  IF NOT Records(RestoreFields) ! Query not valid.
     SELF.ClearQuery()
  ELSE
     LOOP I=1 TO RECORDS(RestoreFields)
      GET(RestoreFields,I)
      SELF.Fields.Name = UPPER(RestoreFields.Name)
      GET(SELF.Fields,SELF.Fields.Name)
      IF Errorcode() AND RestoreFields.Name[1:6] <> 'UPPER(' ! to accomodate where interface has been changed to caseless and the fn now contains UPPER(FN)
         SELF.Fields.Name = 'UPPER(' & SELF.Fields.Name & ')'
         GET(SELF.Fields,SELF.Fields.Name)
      END
      IF Errorcode() AND RestoreFields.Name[1:6] = 'UPPER(' ! to accomodate where the interface has changed to case sensitive but the query is saved as caseless.
         SELF.Fields.Name = SELF.Fields.Name[7:Len(SELF.Fields.Name)-1] ! Remove 'UPPER(' and closing )
         GET(SELF.Fields,SELF.Fields.Name)
         IF NOT Errorcode() ! QBE has changed from caseless to case sensitive.
            IF RestoreFields.QueryString AND |
               (UPPER(SELF.Fields.Picture[1]) = 'S' OR NOT SELF.Fields.Picture) AND |
               (RestoreFields.QueryString[1] <> '^' AND RestoreFields.QueryString[2] <> '^')! Is string
              RestoreFields.QueryString = '^' & RestoreFields.QueryString
            END
         END
      END
      IF Errorcode()
         SELF.Errors.SetField(RestoreFields.Name)
         SELF.Errors.Throw(Msg:QBEColumnNotSupported)
      ELSE
         SELF.Fields.QueryString = RestoreFields.QueryString
         SELF.Fields.Middle &= SELF.Fields.QueryString
         PUT(Self.Fields)
      END
     END
     FREE(RestoreFields)
  END
  DISPOSE(RestoreFields)

QueryClass.GetQueries  PROCEDURE(SectorQueue QQ)
  CODE
  IF SELF.INIMgr &= NULL
     RETURN
  END
  FREE(QQ)
  SELF.INIMgr.GetSectors (SELF.Family,, 'Query', QQ)
  SORT(QQ,QQ.Item)  ! Sort alphabetically
  QQ.Item = 'tsMRU'
  GET(QQ,QQ.Item)
  IF NOT Error()
     DELETE(QQ) ! Remove the MRU entry for Browse\Report query Sharing.
  END

! FormQueryClass - A simple 'form' for the user to do QBE by
QueryFormVisual.GetButtonFeq PROCEDURE(SIGNED index)
  CODE
  IF index <> 0 AND index <= RECORDS(SELF.QFC.Fields)
    RETURN FEQ:StartControl + index * 3
  END
  RETURN 0


QueryFormVisual.Init           PROCEDURE
RVal   BYTE,AUTO
I      USHORT,AUTO
MaxW   USHORT
MaxPW  USHORT
QFC    &QueryFormClass,AUTO
Control   USHORT
  CODE
  QFC &= SELF.QFC
  CLEAR(SELF)
  SELF.QFC &= QFC
  SELF.QC &= QFC
  RVal = PARENT.Init()
  IF RVal THEN RETURN RVal.
  LOOP I = 1 TO RECORDS(SELF.QFC.Fields)
    GET(SELF.QFC.Fields,I)
    Control = Feq:StartControl+(I*3-2)
    CREATE(Control,CREATE:Prompt,Feq:ControlTab)
    Control{PROP:Text} = SELF.QFC.Fields.Title & ':'
    IF Control{PROP:Width} > MaxPW THEN MaxPW = Control{PROP:Width} .
    Control = Feq:StartControl+(I*3-1)
    CREATE(Control,CREATE:Entry,Feq:ControlTab)
    Control{PROP:Text} = CHOOSE(SELF.QFC.Fields.ForceEditPicture,SELF.QFC.Fields.Picture,'@s30')
    Control{Prop:Alrt,1} = F7Key
    Control{Prop:Alrt,1} = MouseRight
    IF Control{PROP:Width} > MaxW THEN MaxW = Control{PROP:Width} .
    Control = Feq:StartControl + (I*3)
    CREATE(Control,CREATE:Button,Feq:ControlTab)
    Control{PROP:Skip} = 1
    SELF.SetText((Feq:StartControl+(I*3-1)),SELF.QFC.Fields.QueryString)
  END
  DO Positions
  IF ~Records(SELF.Queries) ! Override First control if there are no saved queries.
     SELF.FirstField = FEQ:StartControl+1
  END
  SELF.AddItem(FEQ:Cancel,RequestCancelled)
  SELF.OkControl = FEQ:OK
  RETURN RVal

Positions ROUTINE
  DATA
LMargin      USHORT,AUTO
TMargin      USHORT,AUTO
Margin      EQUATE(10)
VSpacing    EQUATE(4)
HSpacing    EQUATE(4)
CHeight     EQUATE(10)
FullWidth   USHORT,AUTO
FullHeight  USHORT,AUTO
I           USHORT,AUTO
MinWidth    USHORT,AUTO
  CODE
  LMargin = FEQ:SheetControl{Prop:XPos} + 5
  TMargin = FEQ:SheetControl{Prop:YPos} + 16
  FullWidth = 3 * LMargin + MaxPW + MaxW + HSpacing + 20
  MinWidth = 2.7 * FEQ:Cancel{PROP:Width}
  IF FullWidth < MinWidth THEN FullWidth = MinWidth.
  LOOP I = 1 TO RECORDS(SELF.QFC.Fields)
    SETPOSITION(Feq:StartControl+(I * 3 - 2), LMargin, TMargin + (I - 1) * (CHeight + VSpacing), MaxPW, CHeight)
    SETPOSITION(Feq:StartControl+(I * 3 - 1), 2 * LMargin + MaxPW, TMargin + (I - 1) * (CHeight + VSpacing), MaxW, CHeight)
    SETPOSITION(Feq:StartControl+(I * 3), 2 * LMargin + HSpacing + MaxPW + MaxW, TMargin + (I - 1) * (CHeight + VSpacing), 10, 10)
  END
  UNHIDE(Feq:StartControl+1,Feq:StartControl+RECORDS(SELF.QFC.Fields)*3)
  I = RECORDS(SELF.QFC.Fields)
  FullHeight = Margin * 2 + I * CHeight + (I - 1) * VSpacing + 5
  IF FullHeight < 140
     FullHeight = 140
  END
  SETPOSITION(FEQ:OK, FullWidth - FEQ:Ok{PROP:Width} - HSpacing - FEQ:Cancel{PROP:Width} - Margin, FullHeight)
  SETPOSITION(FEQ:Cancel, FullWidth - FEQ:Cancel{PROP:Width} - Margin, FEQ:Ok{PROP:YPos})
  SETPOSITION(FEQ:SheetControl, FEQ:SheetControl{Prop:XPos}, FEQ:SheetControl{Prop:YPos},FullWidth-10,FEQ:Ok{PROP:YPos}-6) ! Sheet control
  FullHeight = FEQ:OK{PROP:YPos} + FEQ:OK{PROP:Height} + VSpacing !for the sheet control    !GJS - I Used VSpacing and not margin on purpose.
  SETPOSITION(0,,,FullWidth,FullHeight)

QueryFormVisual.SetText PROCEDURE(USHORT Control, STRING EntryText)
PFT CSTRING(5)
  CODE
  IF LEN(EntryText)
    LOOP WHILE INSTRING(EntryText[1],'<<>~=')
      PFT = PFT & EntryText[1]
      EntryText = SUB(EntryText,2,LEN(EntryText)-1)
    END
  END
  (Control){PROP:ScreenText} = CHOOSE(EntryText='','',FORMAT(EntryText,CHOOSE(SELF.QFC.Fields.ForceEditPicture,SELF.QFC.Fields.Picture,'@s30')))
  UPDATE(Control)
  (Control+1){PROP:Text} = CHOOSE(PFT='',CHOOSE(EntryText='',' ','='),PFT)


QueryFormVisual.TakeCompleted   PROCEDURE
  CODE
  SELF.SetResponse(RequestCompleted)
  SELF.UpdateFields
  RETURN Level:Benign

QueryFormVisual.UpdateFields PROCEDURE
I USHORT,AUTO
Control USHORT
  CODE
  LOOP I = 1 TO RECORDS(SELF.QFC.Fields)
    GET(SELF.QFC.Fields,I)
    Control = Feq:StartControl + ((I*3))
    IF Control{PROP:ScreenText}
      SELF.QFC.Fields.QueryString = MakeOperator(Control{PROP:ScreenText},CLIP((Control-1){PROP:Value}))
    ELSE
      CLEAR(SELF.QFC.Fields.QueryString)
    END
    PUT(SELF.QFC.Fields)
  END

QueryFormVisual.TakeAccepted   PROCEDURE
A USHORT,AUTO
  CODE
  CASE ACCEPTED()
  OF Feq:StartControl+1 TO Feq:StartControl+(RECORDS(SELF.QFC.Fields)*3)
    A = ACCEPTED()
    IF (A - Feq:StartControl) % 3 = 0 THEN
      CASE A{PROP:Text}
      OF ' '
        A{PROP:Text} = '='
      OF '='
        A{PROP:Text} = '>='
      OF '>='
        A{PROP:Text} = '<<='
      OF '<<='
        A{PROP:Text} = '<<>'
      OF '<<>'
        A{PROP:Text} = ' '
      END
    ELSIF (A-Feq:StartControl) % 3 = 2
      IF A{PROP:Text}
        IF ~(A+1){PROP:Text}
          (A+1){PROP:Text} = '='
        END
      ELSE
        (A+1){PROP:Text} = ' '
      END
    END
  END

  RETURN PARENT.TakeAccepted()

QueryFormVisual.TakeFieldEvent PROCEDURE
RVal          BYTE,AUTO
  CODE
  RVal = PARENT.TakeFieldEvent()
  IF FIELD() < FEQ:StartControl Then RETURN RVal.
  CASE (FIELD()-Feq:StartControl)%3
  OF 2
     IF EVENT() = EVENT:AlertKey
        GET(SELF.QFC.Fields,((FIELD()-Feq:StartControl)+1)/3)
        SELF.SetText(FIELD(),CHOOSE(SELF.QFC.Fields.ForceEditPicture,        |  !*** DAB is this ok?
        FORMAT(CLIP(EVALUATE(SELF.QFC.Fields.Name)),FIELD(){Prop:Text}),     |
        FORMAT(CLIP(EVALUATE(SELF.QFC.Fields.Name)),SELF.QFC.Fields.Picture)))
        Update(FIELD())
        POST(EVENT:Accepted,FIELD())
     END
  END
  RETURN RVal

QueryFormVisual.ResetFromQuery PROCEDURE
I USHORT
 CODE
 LOOP I = 1 TO RECORDS(SELF.QFC.Fields)
  GET(SELF.QFC.Fields,I)
  SELF.SetText((Feq:StartControl+(I*3-1)),SELF.QFC.Fields.QueryString)
 END
 Update()
 RETURN

QueryFormClass.Init      PROCEDURE(QueryFormVisual Q)
  CODE
    SELF.Win &= Q
    Q.QFC &= SELF
    PARENT.Init( Q )

QueryFormClass.Init      PROCEDURE(QueryFormVisual Q, INIClass INIMgr, STRING Family, ErrorClass E)
  CODE
    SELF.Win &= Q
    Q.QFC &= SELF
    PARENT.Init(SELF.Win, INIMgr, Family, E)

QueryFormClass.Kill PROCEDURE
  CODE
    IF  NOT SELF.Win &= NULL
      SELF.Win.Kill
    END
    PARENT.Kill

MakeOperator PROCEDURE(String Opers, String LeadOpers)
Res CSTRING(1000)
Op  CSTRING(40)
  CODE
  MakeOperator(Opers,LeadOpers,Op,Res)
  RETURN Op & Res

MakeOperator PROCEDURE(String Opers, String LeadOpers,*CSTRING Sym,*CSTRING Left)
Symb CSTRING(20)
J USHORT,AUTO
I USHORT,AUTO
  CODE
    Sym = ''
    LOOP I = 1 TO LEN(LeadOpers)
      IF INSTRING(LeadOpers[I],'=<<>~',1,1)
        Symb = Symb & LeadOpers[I]
      ELSE
        BREAK
      END
    END
    Left = SUB(LeadOpers,I,LEN(LeadOpers)-I+1)
    CASE Opers
    OF Query:Contains
      Left = '*' & Left
    OF Query:Begins
      Left = Left & '*'
    OF Query:NotEquals
      Symb = Symb & '<<>'
    ELSE
      Symb = Symb & Opers
    END
    LOOP J = 1 TO LEN(Symb)
      IF INSTRING(Symb[J],'<<>~') AND ~INSTRING(Symb[J],Sym)
        Sym = Sym & Symb[J]
      END
    END
    IF INSTRING('=',Symb) AND (~INSTRING('<<',Symb) OR ~INSTRING('>',Symb)) THEN Sym = Sym & '=' .

QueryListClass.Init      PROCEDURE(QueryListVisual Q)
  CODE
    SELF.Win &= Q
    Q.QFC &= SELF
    PARENT.Init ( Q )

QueryListClass.Init      PROCEDURE(QueryListVisual Q, INIClass INIMgr, STRING Family, ErrorClass E)
  CODE
    SELF.Win &= Q
    Q.QFC &= SELF
    PARENT.Init( SELF.Win, INIMgr, Family, E)

QueryListClass.Kill PROCEDURE
  CODE
    IF ~(SELF.Win &= NULL)
       SELF.Win.Kill
    END
    PARENT.Kill

! FormListClass - A list box of fields and conditions
QueryListVisual.Init           PROCEDURE
QFC    &QueryListClass,AUTO
RVal   BYTE,AUTO
I  USHORT,AUTO
CaseLess BYTE,AUTO
High     BYTE
  CODE
  QFC &= SELF.QFC
  CLEAR(SELF)
  SELF.QFC &= QFC
  SELF.QC  &= QFC
  RVal = PARENT.Init()
  IF RVal THEN RETURN RVal.
  ! Creat ListVisual specific controls.
  CREATE(FEQ:Listbox,CREATE:List,FEQ:ControlTab)
  Feq:ListBox{Prop:Format} = '91L|M~' & DefaultQBEFieldHdr & '~@s20@44C|M~' & DefaultQBEOpsHdr & '~L@s10@120C|M~' & DefaultQBEValueHdr & '~L@s30@'
  SELF.Vals &= NEW ValueList
  FEQ:ListBox{PROP:From} = SELF.Vals
  SELF.Flds &= NEW StringList
  LOOP I = 1 TO RECORDS(SELF.QFC.Fields)
    GET(SELF.QFC.Fields,I)
    SELF.Flds.Value = SELF.QFC.Fields.Title
    ADD(SELF.Flds,SELF.Flds.Value)
    LOOP
      High = SELF.QFC.GetLimit(SELF.Vals.Value,SELF.Vals.Ops,CaseLess,High)
      IF SELF.Vals.Value OR SELF.Vals.Ops
        IF CaseLess AND SELF.Vals.Value[1] ~= '^'
           SELF.Vals.Value = '^' & SELF.Vals.Value
        END
        SELF.Vals.Field = SELF.QFC.Fields.Title
        ADD(SELF.Vals)
      END
    WHILE High
  END
  SETPOSITION(FEQ:Listbox,11,20,290,168)
  Unhide(FEQ:Listbox)
  CREATE(FEQ:Insert,CREATE:Button,Feq:ControlTab)
  FEQ:Insert{Prop:Text} = '&Insert'
  SETPOSITION(FEQ:Insert,162,192,45,14)
  CREATE(FEQ:Change,CREATE:Button,Feq:ControlTab)
  FEQ:Change{Prop:Text} = '&Change'
  SETPOSITION(FEQ:Change,209,192,45,14)
  CREATE(FEQ:Delete,CREATE:Button,Feq:ControlTab)
  FEQ:Delete{Prop:Text} = '&Delete'
  SETPOSITION(FEQ:Delete,256,192,45,14)
  Unhide(FEQ:Insert,FEQ:Delete)

  SETPOSITION(Feq:SheetControl,5,4,301,206)
  SETPOSITION(0,,,310,232)

  SELF.Ops &= NEW StringList ! Operators for EIP
  SELF.Ops.Value = Query:Contains
  ADD(SELF.Ops)
  SELF.Ops.Value = Query:Begins
  ADD(SELF.Ops)
  SELF.Ops.Value = Query:NotEquals
  ADD(SELF.Ops)
  SELF.Ops.Value = '='
  ADD(SELF.Ops)
  SELF.Ops.Value = '<<='
  ADD(SELF.Ops)
  SELF.Ops.Value = '>='
  ADD(SELF.Ops)
  SELF.OpsEIP &= NEW EditDropListClass
  SELF.FldsEIP &= NEW EditDropListClass
  SELF.ValueEIP &= NEW QEditEntryClass
  IF ~Records(SELF.Queries) ! Override First control if there are no saved queries.
     SELF.FirstField = FEQ:ListBox
  END
  SELF.AddItem(FEQ:Cancel,RequestCancelled)
  SELF.OkControl = FEQ:OK
  SELF.SetAlerts
  RETURN RVal

QueryListVisual.Kill           PROCEDURE
  CODE
  DISPOSE(SELF.Vals)
  DISPOSE(SELF.Flds)
  DISPOSE(SELF.Ops)
  IF  NOT SELF.OpsEIP &= NULL
    SELF.OpsEIP.Kill()
    DISPOSE(SELF.OpsEIP)
  END
  IF  NOT SELF.FldsEIP &= NULL
    SELF.FldsEIP.Kill()
    DISPOSE(SELF.FldsEIP)
  END
  IF  NOT SELF.ValueEIP &= NULL
    SELF.ValueEIP.Kill()
    DISPOSE(SELF.ValueEIP)
  END
  RETURN PARENT.Kill()

QueryListVisual.SetAlerts PROCEDURE
  CODE
  FEQ:ListBox{Prop:Alrt,MouseLeft2Index} = MouseLeft2
  FEQ:ListBox{Prop:Alrt,255} = InsertKey
  FEQ:ListBox{Prop:Alrt,253} = CtrlEnter
  FEQ:ListBox{Prop:Alrt,254} = DeleteKey

QueryListVisual.TakeFieldEvent PROCEDURE
  CODE
  CASE FIELD()
  OF FEQ:ListBox
     IF EVENT() = EVENT:AlertKey
        CASE KEYCODE()
        OF MouseLeft2
           POST(EVENT:Accepted,CHOOSE(RECORDS(SELF.Vals)=0,FEQ:Insert,FEQ:Change))
        OF CtrlEnter
           POST(EVENT:Accepted,FEQ:Change)
        OF InsertKey
           POST(EVENT:Accepted,FEQ:Insert)
        OF DeleteKey
           IF RECORDS(SELF.Vals)
              POST(EVENT:Accepted,FEQ:Delete)
           END
        END
     END
     FEQ:Delete{PROP:Disable} = CHOOSE(CHOICE(FEQ:Listbox)=0) ! List contains entries
     FEQ:Change{PROP:Disable} = CHOOSE(CHOICE(FEQ:Listbox)=0) ! List contains entries
  END
  RETURN PARENT.TakeFieldEvent()

QueryListVisual.TakeAccepted   PROCEDURE
EIP QEIPManager
E   EditQueue
F   FieldPairsClass
Rv  BYTE,AUTO
Fld CSTRING(100)
Op  CSTRING(20)
Vl  CSTRING(100)
  CODE
  CASE ACCEPTED()
  OF FEQ:Insert OROF FEQ:Delete OROF FEQ:Change
    EIP.Q &= SELF.Vals                  ! I wonder if it is worth making this 'once per form' ?
    EIP.Visual &= SELF
    EIP.EQ &= E
    F.Init
    EIP.Fields &= F
    F.AddPair(SELF.Vals.Field,Fld)
    F.AddPair(SELF.Vals.Ops,Op)
    F.AddPair(SELF.Vals.Value,Vl)
    EIP.ListControl = FEQ:ListBox
    EIP.AddControl(SELF.FldsEIP,1)
    EIP.AddControl(SELF.OpsEIP,2)
    EIP.AddControl(SELF.ValueEIP,3)
    Rv = EIP.Run(CHOOSE(ACCEPTED()=FEQ:Insert,InsertRecord,CHOOSE(ACCEPTED()=FEQ:Change,ChangeRecord,DeleteRecord)))
    F.Kill
    RETURN Rv
  ELSE
    RETURN PARENT.TakeAccepted()
  END

QueryListVisual.TakeCompleted   PROCEDURE
  CODE
  SELF.SetResponse(RequestCompleted)
  SELF.UpdateFields()
  RETURN Level:Benign

QueryListVisual.UpdateFields PROCEDURE
I USHORT,AUTO
  CODE
  SELF.QFC.Reset
  LOOP I = 1 TO RECORDS(SELF.Vals)
    GET(SELF.Vals,I)
    CASE SELF.Vals.Ops
    OF '>='
      SELF.QFC.SetLimit(SELF.QFC.GetName(SELF.Vals.Field),'>='&SELF.Vals.Value)
    OF '<='
      SELF.QFC.SetLimit(SELF.QFC.GetName(SELF.Vals.Field),,'<='&SELF.Vals.Value)
    ELSE
      SELF.QFC.SetLimit(SELF.QFC.GetName(SELF.Vals.Field),,,MakeOperator(SELF.Vals.Ops,SELF.Vals.Value))
    END
  END

QueryListVisual.UpdateControl PROCEDURE(STRING FieldName)
  CODE
  SELF.ValueEIP.Feq{PROP:ScreenText} = EVALUATE(SELF.QFC.GetName(FieldName))


QueryListVisual.ResetFromQuery PROCEDURE
I USHORT
CaseLess BYTE,AUTO
High     BYTE
  CODE
  FREE(SELF.Vals)
  LOOP I = 1 TO RECORDS(SELF.QFC.Fields)
    GET(SELF.QFC.Fields,I)
    LOOP
      High = SELF.QFC.GetLimit(SELF.Vals.Value,SELF.Vals.Ops,CaseLess,High)
      IF SELF.Vals.Value
        IF CaseLess AND SELF.Vals.Value[1] ~= '^'
           SELF.Vals.Value = '^' & SELF.Vals.Value
        END
        SELF.Vals.Field = SELF.QFC.Fields.Title
        ADD(SELF.Vals)
      END
    WHILE High
  END
  RETURN

QEIPManager.Init PROCEDURE
Rv BYTE,AUTO
  CODE
  GET(SELF.Q,CHOICE(SELF.ListControl))
  CASE SELF.Req
  OF InsertRecord
    CLEAR(SELF.Q)
    ADD(SELF.Q,POINTER(SELF.Q)+1)
  OF DeleteRecord
    DELETE(SELF.Q)
    ASSERT(~ERRORCODE())
    SELF.Response = RequestCompleted
    RETURN Level:Fatal
  OF ChangeRecord
    IF KEYCODE() = MouseLeft2
      SELF.Column = SELF.ListControl{PROPLIST:MouseUpField}
    END
  ELSE
    ASSERT(0)
  END
  Rv = PARENT.Init()
  SELF.Visual.FldsEIP.Feq{PROP:From} = SELF.Visual.Flds
  SELF.Visual.OpsEIP.Feq{PROP:From} = SELF.Visual.Ops
  SELF.Visual.FldsEIP.Feq{PROP:VScroll} = 1
  SELF.Visual.OpsEIP.Feq{PROP:VScroll} = 1
  CASE SELF.Req
  OF InsertRecord
    DISPLAY(SELF.ListControl)
    SELECT(SELF.ListControl,POINTER(SELF.Q))
    SELF.Column = 1
  OF DeleteRecord
  OF ChangeRecord
    SELF.Fields.AssignLeftToRight()
    SELF.Visual.Flds.Value = SELF.Visual.FldsEIP.Feq{PROP:Value}
    GET(SELF.Visual.Flds,SELF.Visual.Flds.Value)
    SELF.Visual.FldsEIP.Feq{PROP:SelStart} = POINTER(SELF.Visual.Flds)
    SELF.Visual.Ops.Value = SELF.Visual.OpsEIP.Feq{PROP:Value}
    GET(SELF.Visual.Ops,SELF.Visual.Ops.Value)
    SELF.Visual.OpsEIP.Feq{PROP:SelStart} = POINTER(SELF.Visual.Ops)
    IF KEYCODE() = MouseLeft2
      SELF.Column = SELF.ListControl{PROPLIST:MouseUpField}
    END
  ELSE
    ASSERT(0)
  END
  RETURN Rv

QEIPManager.TakeCompleted PROCEDURE(BYTE Force)
  CODE
  SELF.Again = 0
  SELF.ClearColumn
  IF ~SELF.Q.Field OR ~SELF.Q.Ops
    Force = Button:No
  END
  CASE Force
  OF Button:Cancel
    SELF.Again = 1
  OF Button:No
    IF SELF.Req = InsertRecord
      DELETE(SELF.Q)
    END
  OF Button:Yes
    PUT(SELF.Q)
    SELF.Response = RequestCompleted
  END
  PARENT.TakeCompleted(Force)

QEIPManager.ClearColumn PROCEDURE
  CODE
  IF SELF.LastColumn
    UPDATE
    SELF.Fields.AssignRightToLeft()
    PUT(SELF.Q)
    ASSERT(~ERRORCODE())
  END
  PARENT.ClearColumn

QEIPManager.TakeNewSelection PROCEDURE
  CODE
  SELF.ClearColumn
  RETURN CHOOSE(POINTER(SELF.Q) <> CHOICE(SELF.ListControl),Level:Fatal,PARENT.TakeNewSelection())

QEIPManager.TakeEvent PROCEDURE
  CODE
  IF EVENT() = EVENT:AlertKey
     IF Keycode() = MouseRight
        SELF.Visual.UpdateControl(SELF.Q.Field)
     END
  END
  RETURN PARENT.TakeEvent()

QueryVisual.Init           PROCEDURE
  CODE
  SELF.Resizer &= NEW WindowResizeClass
  IF ~SELF.QC.INIMgr &= NULL
   0{Prop:Hide} = True
   SELF.Queries &= NEW SectorQueue
   SELF.QC.GetQueries(SELF.Queries)

   ! Create Controls (jvn needs to be replaced by const class later).
   CREATE(Feq:SaveListbox,CREATE:List,Feq:SaveRestoreTab)
   Feq:SaveListbox{Prop:Format} = '20L(1)~' & DefaultQueryListText & '~#2#'
   Feq:SaveListbox{Prop:From} = SELF.Queries
   Feq:SaveListbox{Prop:VScroll} = True
   Feq:SaveListbox{Prop:HScroll} = True
   Feq:SaveListbox{Prop:Alrt,1} = MouseLeft2

   CREATE(Feq:SaveQueryButton,CREATE:Button,Feq:SaveRestoreTab)
   Feq:SaveQueryButton{Prop:Text} = DefaultSaveText
   Feq:SaveQueryButton{Prop:Height} = 14

   CREATE(Feq:DeleteQueryButton,CREATE:Button,Feq:SaveRestoreTab)
   Feq:DeleteQueryButton{Prop:Text} = DefaultDeleteText
   Feq:DeleteQueryButton{Prop:Height} = 14

   CREATE(Feq:RestoreQueryButton,CREATE:Button,Feq:SaveRestoreTab)
   Feq:RestoreQueryButton{Prop:Text} = DeleteRestoreText
   Feq:RestoreQueryButton{Prop:Disable} = True
   Feq:RestoreQueryButton{Prop:Height} = 14

   CREATE(Feq:QueryNamePrompt,CREATE:Prompt,Feq:SaveRestoreTab)
   Feq:QueryNamePrompt{Prop:Text} = DefaultNamePrompt
   Feq:QueryNamePrompt{Prop:Height} = 10
   Feq:QueryNamePrompt{Prop:Trn} = True
   CREATE(Feq:QueryNameField,CREATE:Entry,Feq:SaveRestoreTab)
   Feq:QueryNameField{Prop:Text} = '@s50'
   Feq:QueryNameField{Prop:Height} = 10
   Feq:QueryNameField{Prop:Imm} = True

   SELF.FirstField = FEQ:SaveListBox ! derived class can override this.

  END
  RETURN PARENT.Init()

QueryVisual.TakeAccepted   PROCEDURE
  CODE
  CASE FIELD()
  OF FEQ:QueryNameField
     SELF.Reset
  OF FEQ:SaveQueryButton
     SELF.UpdateFields
     SELF.QC.Save(Feq:QueryNameField{Prop:ScreenText})
     SELF.QC.GetQueries(SELF.Queries)
     SELF.Reset
  OF FEQ:RestoreQueryButton
     SELF.QC.Restore(Feq:QueryNameField{Prop:ScreenText})
     SELF.ResetFromQuery()
     SELECT(FEQ:ControlTab)
  OF FEQ:DeleteQueryButton
     SELF.QC.Delete(Feq:QueryNameField{Prop:ScreenText})
     SELF.QC.GetQueries(SELF.Queries)
     SELECT(FEQ:SaveListbox)
     Feq:QueryNameField{Prop:ScreenText} = ''
     UPDATE(Feq:QueryNameField)
     SELF.Reset
  OF FEQ:Clear
     SELF.QC.ClearQuery()
     SELF.ResetFromQuery()
     POST(EVENT:Accepted,Feq:OK)
  END
  RETURN Parent.TakeAccepted()

QueryVisual.TakeFieldEvent PROCEDURE
  CODE
  CASE FIELD()
  OF FEQ:QueryNameField
     CASE EVENT()
     OF EVENT:NewSelection
        SELF.Reset
     END
  OF FEQ:SaveListBox
     CASE Event()
     OF EVENT:AlertKey
        IF Keycode() = MouseLeft2
           GET(SELF.Queries,CHOICE(FEQ:SaveListBox))
           SELF.QC.Restore(SELF.Queries.Item)
           SELF.ResetFromQuery
           POST(EVENT:Accepted,FEQ:Ok)
        END
     OF EVENT:NewSelection
        GET(SELF.Queries,CHOICE(FEQ:SaveListBox))
        FEQ:QueryNameField{Prop:ScreenText} = SELF.Queries.Item
        Update(FEQ:QueryNameField)
        SELF.Reset
     END
  END
  RETURN PARENT.TakeFieldEvent()

QueryVisual.Kill      PROCEDURE
RVal BYTE,AUTO
  CODE
  RVal = Parent.Kill()
  DISPOSE(SELF.Queries)

  IF  NOT SELF.Resizer &= NULL
    SELF.Resizer.Kill()
    DISPOSE(SELF.Resizer)
  END
  RETURN RVal

QueryVisual.Reset           PROCEDURE(BYTE Force=0)
  CODE
  IF ~SELF.QC.INIMgr &= NULL
   IF ~FEQ:QueryNameField{Prop:ScreenText}
      Disable(FEQ:DeleteQueryButton)
      Disable(FEQ:RestoreQueryButton)
      Disable(FEQ:SaveQueryButton)
   ELSE
      SELF.Queries.Item = FEQ:QueryNameField{Prop:ScreenText}
      GET(SELF.Queries,+SELF.Queries.Item)
      IF ERRORCODE()
         Disable(FEQ:DeleteQueryButton)
      ELSE
         Enable(FEQ:DeleteQueryButton)
      END
      Enable(FEQ:RestoreQueryButton)
      Enable(FEQ:SaveQueryButton)
   END
  END
  PARENT.Reset


QueryVisual.TakeWindowEvent  PROCEDURE
  CODE
  CASE Event()
  OF EVENT:OpenWindow
     IF ~SELF.QC.INIMgr &= NULL
      SETPOSITION(Feq:SaveListbox, Feq:SheetControl{Prop:XPos}+4, Feq:SheetControl{Prop:YPos} + 16,Feq:SheetControl{Prop:Width}-10,Feq:SheetControl{Prop:Height}-48)
      UNHIDE(Feq:SaveListbox)
      SETPOSITION(Feq:SaveQueryButton,Feq:SaveListbox{Prop:XPos} + Feq:SaveListbox{Prop:Width} - 45,Feq:SaveListbox{Prop:YPos} + Feq:SaveListbox{Prop:Height} + 16,45)
      UNHIDE(Feq:SaveQueryButton)
      SETPOSITION(Feq:DeleteQueryButton,Feq:SaveQueryButton{Prop:XPos} - 47,Feq:SaveQueryButton{Prop:YPos},45)
      UNHIDE(Feq:DeleteQueryButton)
      SETPOSITION(Feq:RestoreQueryButton,Feq:DeleteQueryButton{Prop:XPos} - 47,Feq:SaveQueryButton{Prop:YPos},45)
      UNHIDE(Feq:RestoreQueryButton)
      SETPOSITION(Feq:QueryNamePrompt,Feq:SaveListbox{Prop:XPos},Feq:SaveListbox{Prop:YPos} + Feq:SaveListbox{Prop:Height}+3)
      UNHIDE(Feq:QueryNamePrompt)
      SETPOSITION(Feq:QueryNameField,Feq:QueryNamePrompt{Prop:XPos}+Feq:QueryNamePrompt{Prop:Width} + 3,Feq:QueryNamePrompt{Prop:YPos},Feq:DeleteQueryButton{Prop:XPos}-(Feq:QueryNamePrompt{Prop:XPos}+Feq:QueryNamePrompt{Prop:Width} + 8))
      UNHIDE(Feq:QueryNameField)
     ELSE
      HIDE(Feq:SaveRestoreTab)
     END
     SETPOSITION(Feq:Clear,Feq:SheetControl{Prop:XPos}+Feq:SheetControl{Prop:Width}-Feq:Clear{Prop:Width},Feq:SheetControl{Prop:YPos}+Feq:SheetControl{Prop:Height}+3,50,14)
     SETPOSITION(Feq:Cancel,Feq:Clear{Prop:XPos}-52,Feq:Clear{Prop:YPos},50,14)
     SETPOSITION(Feq:Ok,Feq:Cancel{Prop:XPos}-52,Feq:Cancel{Prop:YPos},50,14)

     SELF.Resizer.Init(AppStrategy:Resize,Resize:SetMinSize)
     SELF.AddItem(SELF.Resizer)
     SELF.Resizer.SetParentDefaults
     IF ~SELF.QC.INIMgr &= NULL
      SELF.QC.INIMgr.Fetch('QBE-' & SELF.QC.Family,SELF.QC.Window) ! Restore saved size.
     END
     SELF.Resizer.Resize
     SELF.Resizer.Reset
     0{Prop:Hide} = False ! Show Window after all the positioning has been done
  OF EVENT:CloseWindow
     IF ~SELF.QC.INIMgr &= NULL
      SELF.QC.INIMgr.Update('QBE-' & SELF.QC.Family,SELF.QC.Window) ! Save Window Size.
     END
     SELF.QC.Save('tsMRU') ! Save as Most Recently used.
  END
  RETURN PARENT.TakeWindowEvent()

QueryVisual.ResetFromQuery PROCEDURE
  CODE

QueryVisual.UpdateFields PROCEDURE
  CODE

QEditEntryClass.SetAlerts PROCEDURE
  CODE
  PARENT.SetAlerts
  SELF.Feq{PROP:Alrt,7} = MouseRight
