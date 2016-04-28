!Popup Manager code

  MEMBER
  map
  .

  MAP
GetUniqueName  PROCEDURE(PopupClass SELF,STRING mText),STRING,PRIVATE
RemoveAmpersand PROCEDURE(STRING ItemText),STRING
PopToolbox  PROCEDURE(STRING,STRING)
  END

  INCLUDE('ERRORS.CLW'),ONCE
  INCLUDE('ABPOPUP.INC'),ONCE
  INCLUDE('ABPOPUP.TRN'),ONCE

  ITEMIZE(0),PRE(State)
None  EQUATE
On    EQUATE
Off   EQUATE
  END

PopupItemQueue      QUEUE,TYPE
ControlID             SIGNED                          !Control to post event to, else zero
Depth                 UNSIGNED
Event                 UNSIGNED                        !event to post
MimicMode             BYTE
Disabled              BYTE
Check                 BYTE
OnToolbox             BYTE
Icon                  CSTRING(FILE:MaxFileName)
Name                  CSTRING(MaxMenuItemLen+1)
Text                  CSTRING(MaxMenuItemLen+1)       !text of menu item
                    END

PopupClass.Init PROCEDURE                       !Does not allow acces to Save and restore methods

  CODE
  SELF.PopupItems &= NEW PopupItemQueue
  SELF.ClearKeycode = 1
  SELF.MyThread = THREAD()
  SELF.LastNumberSelection=0

PopupClass.Init PROCEDURE(INIClass INIMgr)      !Allows access to Save and Restore methods

  CODE
  SELF.INIMgr &= IniMgr
  SELF.Init

PopupClass.SetTranslator PROCEDURE(TranslatorClass T)

  CODE
  SELF.Translator &= T
  ASSERT(~SELF.Translator&=NULL)


!This method adds a menu string to a menu at the position supplied.
!If Atposition parameter is 0, existing menu is cleared before adding new items
!mText can contain sub menu definitions
PopupClass.AddMenu PROCEDURE (STRING mText, BYTE AtPosition)

cDepth  UNSIGNED(1)
cItem   CSTRING(MaxMenuItemLen+1)
i       UNSIGNED,AUTO
commit  BYTE,AUTO

  CODE
  ASSERT(mText)                                         !Should not pass an empty string
  IF AtPosition
    AtPosition -= 1
    GET (SELF.PopupItems, AtPosition)
    cDepth = CHOOSE (ERRORCODE()=0, SELF.PopupItems.Depth, 1)
  ELSE
    FREE(SELF.PopupItems)
  END

  commit = FALSE

  LOOP i = 1 TO LEN(mText)
    CASE VAL (mText[i])
    OF VAL('|')
      DO AddItem
    OF VAL('{{')
      DO AddItem
      cDepth += 1
    OF VAL('}')
      DO AddItem
      cDepth -= 1
      ASSERT(cDepth>0)                                  !Bad menu string
    ELSE
      cItem  = cItem & mText[i]
      commit = TRUE
    END
  END

  IF commit
    DO AddItem                                          !End of String - commit last menu item
  END

AddItem ROUTINE
  IF cItem
    SELF.SetItem (AtPosition, cDepth, cItem, cItem)
    AtPosition += 1
    CLEAR (cItem)
  END
  commit = FALSE
  EXIT


PopupClass.Kill PROCEDURE

  CODE
  DISPOSE(SELF.PopupItems)

PopupClass.Ask PROCEDURE (SIGNED XPos, SIGNED YPos)

  CODE
  SELF.LastNumberSelection = SELF.ExecutePopup (SELF.GetMenuText(), XPos, YPos)
  IF SELF.LastNumberSelection = 0
    SELF.LastSelection = ''
    RETURN ''
  END

  SELF.LastSelection = SELF.GetName (SELF.LastNumberSelection)
  IF SELF.LastSelection AND SELF.LocateName (SELF.LastSelection)
    IF SELF.PopupItems.Event OR SELF.PopupItems.MimicMode
      IF SELF.ClearKeycode
        SETKEYCODE(0)
      END
      POST (CHOOSE(SELF.PopupItems.MimicMode = 1,EVENT:Accepted,SELF.PopupItems.Event), |
            SELF.PopupItems.ControlID, SELF.MyThread)
    END
  END
  RETURN SELF.LastSelection

PopToolbox PROCEDURE( STRING S, STRING N )
P &PopupClass,AUTO
  CODE
  P &= S+0
  P.AskToolbox(N)

PopupClass.Toolbox PROCEDURE (STRING Name)
  CODE
  SELF.InToolbox = 1
  SELF.ParentWindow &= SYSTEM{PROP:Target}
  START (PopToolbox,, ADDRESS(SELF), Name)

PopupClass.AskToolbox PROCEDURE(STRING N)
W    WINDOW,FONT('MS Sans Serif',8,,FONT:regular),CENTER,SYSTEM,TOOLBOX,TIMER(50)
     END
XP UNSIGNED
YP UNSIGNED
YD UNSIGNED(0)
C  UNSIGNED,AUTO
NV UNSIGNED
  CODE
  OPEN (W, SELF.ParentWindow)
  W{PROP:Text} = N
  SELF.ThisWindow &= W

  LOOP C = 1 TO RECORDS(SELF.PopupItems)
    GET (SELF.PopupItems, C)
    IF NOT SELF.PopupItems.OnToolbox
      CYCLE
    END
    NV += 1

    SETTARGET (SELF.ParentWindow)
    SELF.CheckMimics
    SETTARGET (W)

    CREATE (NV, CREATE:Button)
    IF SELF.PopupItems.Icon
      NV{PROP:Icon} = '~' & SELF.PopupItems.Icon
      NV{PROP:ToolTip} = RemoveAmpersand (SELF.PopupItems.Text)
    ELSE
      NV{PROP:Text} = SELF.PopupItems.Text
    END
    SETPOSITION(NV,XP,YP)
    XP += NV{PROP:Width}
    IF NV{PROP:Height} > YD
      YD = NV{PROP:Height}
    END
  END
  UNHIDE(1,NV)
  W{PROP:Width} = XP
  W{PROP:Height} = YP + YD

  ACCEPT
    IF NOT SELF.Ask()
      BREAK
    END
  END
  CLOSE (W)
  SELF.InToolbox = 0

PopupClass.ResetToolbox PROCEDURE
XP UNSIGNED
YP UNSIGNED
YD UNSIGNED(0)
C  UNSIGNED,AUTO
NV UNSIGNED
  CODE
  IF SELF.ThisWindow &= NULL THEN RETURN.

  LOOP C = 1 TO RECORDS(SELF.PopupItems)
    GET (SELF.PopupItems, C)
    IF NOT SELF.PopupItems.OnToolbox
      CYCLE 
    END
    NV += 1

    SETTARGET (SELF.ParentWindow)
    SELF.CheckMimics
    SETTARGET (SELF.ThisWindow)

    IF NOT NV{Prop:Type}
       CREATE (NV, CREATE:Button)
    END
    IF SELF.PopupItems.Icon
      NV{PROP:Icon} = '~' & SELF.PopupItems.Icon
      NV{PROP:ToolTip} = RemoveAmpersand(SELF.PopupItems.Text)
    ELSE
      NV{PROP:Text} = SELF.PopupItems.Text
    END
    NV{PROP:Disable} = CHOOSE (SELF.PopupItems.Disabled = State:On)
    SETPOSITION(NV,XP,YP)
    UNHIDE(NV)
    XP += NV{PROP:Width}
    IF NV{PROP:Height} > YD
      YD = NV{PROP:Height}
    END
  END

  NV += 1 ! Past Last valid control
  LOOP UNTIL NOT NV{PROP:Feq} ! Destroy old buttons
    DESTROY(NV)
    NV += 1
  END
  0{PROP:Width} = XP
  0{PROP:Height} = YP + YD


PopupClass.SetItemEnable PROCEDURE(STRING Name,BYTE EnableState)
  CODE
  IF SELF.LocateName(Name) AND SELF.PopupItems.Text <> '-'     !Cannot set enable state of separators
    SELF.PopupItems.Disabled = CHOOSE (EnableState = 0, State:On, State:Off)
    PUT(SELF.PopupItems)
    ASSERT(~ERRORCODE())
  END

PopupClass.SetToolbox PROCEDURE(STRING Name,BYTE Show)
  CODE
  IF SELF.LocateName(Name)
    SELF.PopupItems.OnToolbox = Show
    PUT(SELF.PopupItems)
    ASSERT(~ERRORCODE())
  END


PopupClass.DeleteItem PROCEDURE(STRING Name)
  CODE
  IF SELF.LocateName(Name)
    DELETE(SELF.PopupItems)
  END


PopupClass.SetItemCheck PROCEDURE(STRING Name,BYTE CheckState)
  CODE
  IF SELF.LocateName(Name) AND SELF.PopupItems.Text <> '-'           !Cannot set check state of seeperator items
    SELF.PopupItems.Check = CHOOSE (CheckState = 0, State:Off, State:On)
    PUT(SELF.PopupItems)
    ASSERT(~ERRORCODE())
  END


PopupClass.GetItemChecked PROCEDURE(STRING Name)
  CODE
  IF SELF.LocateName(Name)
    RETURN CHOOSE(SELF.PopupItems.Check = State:On)
  END
  RETURN False

PopupClass.GetItemEnabled PROCEDURE(STRING Name)
  CODE
  IF SELF.LocateName(Name)
    RETURN CHOOSE(SELF.PopupItems.Disabled = State:Off)
  END
  RETURN False


PopupClass.Save PROCEDURE (STRING MenuDescription)

C       UNSIGNED,AUTO
ItemStr STRING('ItemXXX')
  CODE
  IF ~SELF.INIMgr &= NULL AND RECORDS(SELF.PopupItems) AND LEN(MenuDescription)
    SELF.INIMgr.Update (MenuDescription, 'Items', RECORDS(SELF.PopupItems))
    LOOP C = 1 TO RECORDS(SELF.PopupItems)
      GET (SELF.PopupItems, C)
      ASSERT(~ERRORCODE())
      ItemStr [5 : 7] = FORMAT (C,@N03)
      SELF.INIMgr.Update (MenuDescription, ItemStr, SELF.PopupItems.Name & ',' & SELF.PopupItems.Text & ',' & SELF.PopupItems.Depth & ',' & SELF.PopupItems.ControlID & ',' & SELF.PopupItems.Event & ',' & SELF.PopupItems.MimicMode & ',' & SELF.PopupItems.Check & ',' & SELF.PopupItems.Disabled)
    END
  END


PopupClass.Restore PROCEDURE(STRING MenuDescription)

C         UNSIGNED,AUTO
ItemStr   STRING('ItemXXX')

  CODE
  IF ~SELF.INIMgr &= NULL AND MenuDescription
    FREE(SELF.PopupItems)
    LOOP C = 1 TO SELF.INIMgr.TryFetch (MenuDescription, 'Items')
      ItemStr [5 : 7] = FORMAT (C,@N03)
      SELF.PopupItems.Name      = SELF.INIMgr.FetchField(MenuDescription,ItemStr,1)
      SELF.PopupItems.Text      = SELF.INIMgr.FetchField(MenuDescription,ItemStr,2)
      SELF.PopupItems.Depth     = SELF.INIMgr.FetchField(MenuDescription,ItemStr,3)
      SELF.PopupItems.ControlID = SELF.INIMgr.FetchField(MenuDescription,ItemStr,4)
      SELF.PopupItems.Event     = SELF.INIMgr.FetchField(MenuDescription,ItemStr,5)
      SELF.PopupItems.MimicMode = SELF.INIMgr.FetchField(Menudescription,ItemStr,6)
      SELF.PopupItems.Check     = SELF.INIMgr.FetchField(Menudescription,ItemStr,7)
      SELF.PopupItems.Disabled  = SELF.INIMgr.FetchField(Menudescription,ItemStr,8)
      ADD(SELF.PopupItems)
      ASSERT(~ERRORCODE())
    END
  END


PopupClass.AddItemEvent PROCEDURE (STRING Name, UNSIGNED EventNo, SIGNED ControlID)

RVal  STRING(MaxMenuItemLen),AUTO

  CODE
  RVal = CHOOSE (SELF.LocateName(Name) = 0, SELF.AddItem(Name), Name)
  SELF.PopupItems.MimicMode = False
  SELF.PopupItems.ControlID = ControlID
  SELF.PopupItems.Event     = EventNo
  SELF.PopupItems.OnToolbox = True
  PUT(SELF.PopupItems)
  ASSERT(~ERRORCODE())
  RETURN RVal


PopupClass.GetName PROCEDURE (UNSIGNED Positional)

C           UNSIGNED,AUTO
Pd          BYTE,AUTO
PosCnt      UNSIGNED

  CODE
  IF Positional
    LOOP c = 1 TO RECORDS(SELF.PopupItems)
      GET (SELF.PopupItems, c)
      IF SELF.InToolbox
        IF NOT SELF.PopupItems.OnToolbox
          CYCLE
        END
      ELSIF SELF.PopupItems.Text = '-'
        CYCLE
      END
      
      IF c < RECORDS(SELF.PopupItems)
        Pd = SELF.PopupItems.Depth
        GET (SELF.PopupItems, c + 1)
        IF Pd < SELF.PopupItems.Depth            ! Sub-menu headers not numbered
          CYCLE
        END
        GET (SELF.PopupItems, c)
      END

      PosCnt += 1
      IF PosCnt = Positional
        RETURN SELF.PopupItems.Name
      END
    END
  END
  RETURN ''


PopupClass.GetLastSelection PROCEDURE()

  CODE
  RETURN SELF.LastSelection


PopupClass.GetMenuText PROCEDURE()

C           UNSIGNED,AUTO
MenuText    CSTRING(MaxMenuStrLen)
OldDepth    UNSIGNED(1)
NewStyle    BYTE

  CODE
  LOOP C = 1 TO RECORDS(SELF.PopupItems)
    GET (SELF.PopupItems, C)
    SELF.CheckMimics
    IF SELF.PopupItems.Icon
      NewStyle = 1
      BREAK
    END
  END

  LOOP C = 1 TO RECORDS(SELF.PopupItems)
    GET(SELF.PopupItems,C)
    IF SELF.PopupItems.Depth = OldDepth
      MenuText = MenuText & '|'
    ELSIF SELF.PopupItems.Depth > OldDepth
      MenuText = MenuText & '{{'
    ELSE
      MenuText = MenuText & '}'
    END
    OldDepth = SELF.PopupItems.Depth
    SELF.CheckMimics
    IF SELF.PopupItems.Disabled = State:On
      MenuText = MenuText & '~'
    END
    IF SELF.PopupItems.Check <> State:None
      MenuText = MenuText & CHOOSE(SELF.PopupItems.Check = State:On,'+','-')
    END
    DO ExtendedItems
    IF ~SELF.Translator &= NULL               !Check and call to translator if setup
      SELF.PopupItems.Text = SELF.Translator.TranslateString (SELF.PopupItems.Text)
    END
    MenuText = MenuText & SELF.PopupItems.Text
  END
  RETURN MenuText

ExtendedItems ROUTINE
  IF NewStyle AND SELF.PopupItems.Text <> '-'
    MenuText = MenuText & '['
    IF SELF.PopupItems.Icon
      MenuText = MenuText&PROP:Icon & '(~' & SELF.PopupItems.Icon & ')'
    END
    MenuText = MenuText & ']'
  END

PopupClass.CheckMimics PROCEDURE
  CODE
  IF SELF.PopupItems.MimicMode
    ! Fill in the blanks, note this Q record is not put.
    IF SELF.PopupItems.ControlID{PROP:Text} AND (SELF.PopupItems.Text[1]='!' OR ~SELF.PopupItems.Text)
      SELF.PopupItems.Text=SELF.PopupItems.ControlID{PROP:Text}
    END
    IF SELF.PopupItems.Text[1] = '!'
      SELF.PopupItems.Text = SELF.PopupItems.Text[2:LEN(SELF.PopupItems.Text)]
    END
    IF ~SELF.PopupItems.Disabled
      SELF.PopupItems.Disabled = CHOOSE( SELF.PopupItems.ControlID{PROP:Disable}, State:On, State:Off )
    END
    IF ~SELF.PopupItems.Icon
      SELF.PopupItems.Icon = SELF.PopupItems.ControlId{PROP:Icon}
    END
  END

PopupClass.AddItemMimic PROCEDURE (STRING Name, SIGNED ButtonID, <STRING Txt>)

RVal  STRING(MaxMenuItemLen),AUTO

  CODE
? ASSERT(INLIST(ButtonID{PROP:Type},CREATE:Button,CREATE:Item))  !Mimiced control must be a button or menu item
  RVal = SELF.AddItemEvent (Name, EVENT:Accepted, ButtonID)
  SELF.PopupItems.Text = Txt
  SELF.PopupItems.MimicMode = True
  SELF.PopupItems.OnToolbox = True
  PUT(SELF.PopupItems)
  ASSERT(~ERRORCODE())
  RETURN RVal


PopupClass.AddItem PROCEDURE (STRING MenuText)
  CODE
  RETURN SELF.AddItem(MenuText,GetUniqueName(SELF,CHOOSE(MenuText='-','Separator',MenuText)))


PopupClass.AddItem PROCEDURE (STRING MenuText, STRING ItemName)
  CODE
  RETURN SELF.AddItem(MenuText,ItemName,'',0)


PopupClass.AddItem PROCEDURE (STRING MenuText, STRING Name, STRING NameToFollow, BYTE Level)
  CODE
  RETURN SELF.SetItem(SELF.LocateName(NameToFollow),Level,Name,MenuText)


PopupClass.SetItem PROCEDURE (UNSIGNED AddAfter, UNSIGNED Level, STRING BaseName, STRING MenuText)

NewName CSTRING(MaxMenuItemLen+1),AUTO
i       UNSIGNED,AUTO
L       UNSIGNED,AUTO

  CODE
? ASSERT(~INSTRING('{{',MenuText,1,1) AND ~INSTRING('}',MenuText,1,1))  !{} characters not allowed in individual menu item names
  IF AddAfter = 0
    AddAfter = RECORDS(SELF.PopupItems)                     !default action is to append to end of menu
  END
  IF Level = 0
    GET (SELF.PopupItems, AddAfter)
    Level = CHOOSE (ERRORCODE() = 0, SELF.PopupItems.Depth, 1)
  END
  NewName = GetUniqueName (SELF, BaseName)
  CLEAR(SELF.PopupItems)
  SELF.PopupItems.Name = NewName

  L = LEN (CLIP (MenuText))
  i = 1
  IF MenuText <> '-'
    LOOP WHILE i <= L
      CASE VAL (MenuText[i])
      OF VAL('~')
        SELF.PopupItems.Disabled = State:On
      OF VAL('+')  
        SELF.PopupItems.Check = State:On
      OF VAL('-')
        SELF.PopupItems.Check = State:Off
      ELSE
        BREAK
      END
      i += 1
    END
  END
  SELF.PopupItems.Text  = CHOOSE (i > L, '', MenuText [i : L])
  SELF.PopupItems.Depth = Level
  ADD (SELF.PopupItems, AddAfter+1)
  ASSERT(~ERRORCODE())
  RETURN NewName


PopupClass.AddSubMenu PROCEDURE (STRING MenuHeading, STRING MenuText, STRING NameToFollow)
  CODE
  SELF.AddSubMenu (CLIP(MenuHeading) & '{{' & CLIP(MenuText) & '}', NameToFollow)


PopupClass.AddSubMenu PROCEDURE (STRING mText, STRING NameToFollow)
  CODE
  SELF.AddMenu(mText,SELF.LocateName(NameToFollow)+1)


PopupClass.LocateName PROCEDURE (STRING Name)
i UNSIGNED,AUTO
  CODE
  LOOP i = 1 TO RECORDS(SELF.PopupItems)
    GET(SELF.PopupItems,i)
    IF SELF.PopupItems.Name = Name
      RETURN i
    END
  END
  RETURN 0

PopupClass.GetItems PROCEDURE (BYTE pOnlyItems=0)
C           UNSIGNED,AUTO
lItems      SIGNED
OldDepth    UNSIGNED(1)
  CODE
  IF NOT pOnlyItems THEN
     RETURN RECORDS(SELF.PopupItems)
  END

  lItems = 0
  LOOP C = 1 TO RECORDS(SELF.PopupItems)
     GET (SELF.PopupItems,C)
     IF SELF.PopupItems.Text = '-' THEN
        CYCLE
     END
     IF SELF.PopupItems.Depth <= OldDepth
        lItems += 1
     END
     OldDepth = SELF.PopupItems.Depth
  END
  RETURN lItems

PopupClass.SetText PROCEDURE (STRING Name, STRING Txt)
  CODE
  IF SELF.LocateName(Name)
    SELF.PopupItems.Text = Txt
    PUT(SELF.PopupItems)
  END

PopupClass.SetIcon PROCEDURE (STRING Name, STRING Txt)
  CODE
  IF SELF.LocateName(Name)
    SELF.PopupItems.Icon = Txt
    PUT(SELF.PopupItems)
  END

  COMPILE('***',_DEBUG_)
PopupClass.ViewMenu PROCEDURE

DisplayQueue  QUEUE
Item            STRING(MaxMenuItemLen+MaxMenuItemLen+5)
Level           LONG
              END

window WINDOW('View Menu'),AT(,,251,233),FONT('MS Sans Serif',8,,FONT:regular),CENTER,SYSTEM,GRAY,DOUBLE
       LIST,AT(2,2,247,211),USE(?List1),VSCROLL,FORMAT('20L(1)T~Menu Structure~L(2)S(255)@S255@'),FROM(DisplayQueue)
       BUTTON('&Close'),AT(210,216,41,15),USE(?CloseButton),STD(STD:Close)
     END

i UNSIGNED,AUTO

  CODE
  LOOP i=1 TO RECORDS(SELF.PopupItems)
    GET(SELF.PopupItems,i)
    ASSERT(~ERRORCODE())
    DisplayQueue.Item=SELF.PopupItems.Text&' ('&SELF.PopupItems.Name&')  '&POINTER(SELF.PopupItems)
    DisplayQueue.Level=SELF.PopupItems.Depth
    ADD(DisplayQueue)
    ASSERT(~ERRORCODE())
  END
  OPEN(Window)
  ACCEPT
  END
  CLOSE(Window)
  ***

  OMIT('***',_DEBUG_)
PopupClass.ViewMenu PROCEDURE
  CODE
  ***


PopupClass.SetLevel PROCEDURE(STRING Name,BYTE Lvl)
  CODE
  IF SELF.LocateName(Name)
    SELF.PopupItems.Depth = Lvl
    PUT(SELF.PopupItems)
  END


GetUniqueName PROCEDURE (PopupClass SELF,STRING ThisItem)

C           UNSIGNED,AUTO
i           UNSIGNED,AUTO
UNameLen    UNSIGNED,AUTO
UniqueName  CSTRING(MaxMenuItemLen+1)

  CODE
  IF ThisItem = '-'
    UniqueName = 'Separator'
    UNameLen   = 9
  ELSE
    i = 0
    LOOP C = 1 TO LEN(CLIP(ThisItem))
      CASE VAL (ThisItem[C])
      OF VAL('A') TO VAL('Z')
      OROF VAL('a') TO VAL('z')
      OROF VAL('0') TO VAL('9')
      OROF VAL('_')
        i += 1
        UniqueName[i] = ThisItem[C]
      END
    END
    UniqueName[i+1] = '<0>'
    UNameLen = i
  END

  C = 0
  LOOP
    IF C > 0
      UniqueName = UniqueName [1 : UNameLen] & C
    END
    IF NOT SELF.LocateName(UniqueName)
      BREAK
    END
    C += 1
  END
  RETURN UniqueName

RemoveAmpersand PROCEDURE(STRING ItemText)
CleanText STRING(100)
S         UNSIGNED,AUTO
T         UNSIGNED,AUTO
SLen      UNSIGNED,AUTO
  CODE
  SLen = LEN(CLIP(ItemText))
  T = 1
  LOOP S = 1 TO SLen
   IF ItemText[S] = '&'
      IF S + 1 > SLen
         CYCLE
      ELSE
         IF ItemText[S+1] = '&'
            CleanText[T] = '&'
         ELSE
            CYCLE
         END
      END
   ELSE
      CleanText[T] = ItemText[S]
   END
   T += 1
  END
  RETURN CLIP(CleanText)

PopupClass.ExecutePopup PROCEDURE(STRING MenuText,UNSIGNED XPos,UNSIGNED YPos)
   CODE
   IF NOT SELF.InToolbox
     IF XPos = 0
       XPos = _nopos
     END
     IF YPos = 0
       YPos = _nopos
     END

     RETURN POPUP (MenuText, XPos, YPos)
   END

   ACCEPT
     CASE EVENT()
     OF EVENT:CloseWindow
     OROF EVENT:CloseDown
       RETURN 0
     OF EVENT:Accepted
       IF ACCEPTED()
         RETURN ACCEPTED()
       END
     OF EVENT:Timer
       SELF.ResetToolbox
     END
   END

PopupClass.GetLastNumberSelection PROCEDURE()
  CODE
  RETURN SELF.LastNumberSelection

PopupClass.DeleteMenu PROCEDURE (STRING mText)

cDepth      UNSIGNED(1)
cItem       CSTRING(MaxMenuItemLen+1)
refText     &STRING,AUTO
cDeleteSep  BYTE(0)
i           UNSIGNED,AUTO
  CODE
? ASSERT(mText)                                      !Should not pass an empty string
  refText &= mText
  IF LEN(mText) > 3 THEN
     IF mText[1:3] = '|-|' THEN
        !Remove separation
        refText &= mText [4 : (LEN(mText))]
        cDeleteSep = True
     END
  END

  LOOP i=1 TO LEN(refText)
    IF refText[i] = '{{'
      DO DeleteItem
      BREAK
    ELSE
      cItem = cItem & refText[i]
      IF i = LEN(refText)                             !End of String - commit last menu item
         DO DeleteItem
      END
    END
  END

DeleteItem ROUTINE
 DATA
ii          UNSIGNED,AUTO
StartDelete BYTE
TotalRec    UNSIGNED
 CODE
  IF cItem[1] = '<0>'
    EXIT
  END

  StartDelete = False
  LOOP ii = 1 TO RECORDS(SELF.PopupItems)
     GET(SELF.PopupItems,ii)
     IF CLIP(SELF.PopupItems.Text) = CLIP(cItem) AND NOT StartDelete THEN
        cDepth = SELF.PopupItems.Depth
        StartDelete = True
        SELF.PopupItems.Text = 'TOBEDELETED'
        SELF.PopupItems.Name = 'TOBEDELETED'
        PUT(SELF.PopupItems)
        IF cDeleteSep THEN
           cDeleteSep = False
           IF ii > 1 THEN
              GET(SELF.PopupItems,ii-1)
              IF SELF.PopupItems.Text = '-' THEN
                 SELF.PopupItems.Text = 'TOBEDELETED'
                 SELF.PopupItems.Name = 'TOBEDELETED'
                 PUT(SELF.PopupItems)
              END
           END
        END
        CYCLE
     END
     IF StartDelete THEN
        IF cDepth < SELF.PopupItems.Depth THEN
           SELF.PopupItems.Text = 'TOBEDELETED'
           SELF.PopupItems.Name = 'TOBEDELETED'
           PUT(SELF.PopupItems)
        ELSE
           BREAK
        END
     END
  END
  TotalRec = RECORDS(SELF.PopupItems)
  LOOP ii = TotalRec TO 1 BY -1
     GET(SELF.PopupItems,ii)
     IF SELF.PopupItems.Text = 'TOBEDELETED' AND SELF.PopupItems.Name = 'TOBEDELETED' THEN
        DELETE(SELF.PopupItems)
     END
  END
