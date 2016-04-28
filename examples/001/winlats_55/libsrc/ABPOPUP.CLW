!Popup Manager code

  MEMBER
  map
  .

  MAP
GetUniqueName  PROCEDURE(PopupClass SELF,STRING mText),STRING,PRIVATE
RemoveAmpersand PROCEDURE(STRING ItemText),STRING
PopToolbox  PROCEDURE(STRING,STRING)
  END

  INCLUDE('EQUATES.CLW'),ONCE
  INCLUDE('ERRORS.CLW'),ONCE
  INCLUDE('ABPOPUP.INC'),ONCE
  INCLUDE('ABPOPUP.TRN'),ONCE

  ITEMIZE(0),PRE(State)
None  EQUATE
On    EQUATE
Off   EQUATE
  END

PopupItemQueue      QUEUE,TYPE
ControlID             SHORT                           !Control to post event to, else zero
Depth                 USHORT
Event                 USHORT                          !event to post
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
  SELF.PopupItems&=NEW PopupItemQueue
  SELF.ClearKeycode = 1
  SELF.MyThread = THREAD()

PopupClass.Init PROCEDURE(INIClass INIMgr)      !Allows access to Save and Restore methods

  CODE
  SELF.INIMgr&=IniMgr
  SELF.Init

PopupClass.SetTranslator PROCEDURE(TranslatorClass T)

  CODE
  SELF.Translator&=T
  ASSERT(~SELF.Translator&=NULL)


!This method adds a menu string to a menu at the position supplied.
!If Atposition parameter is 0, existing menu is cleared before adding new items
!mText can contain sub menu definitions
PopupClass.AddMenu PROCEDURE(STRING mText,BYTE AtPosition)

cDepth  USHORT(1)
cItem   CSTRING(MaxMenuItemLen+1)
i       USHORT,AUTO

  CODE
  ASSERT(mText)                                         !Should not pass an empty string
  IF AtPosition
    AtPosition -= 1
    GET(SELF.PopupItems,AtPosition)
    cDepth=CHOOSE(ERRORCODE()=0,SELF.PopupItems.Depth,1)
  ELSE
    FREE(SELF.PopupItems)
  END
  LOOP i=1 TO LEN(mText)
    CASE mText[i]
    OF '|'
      DO AddItem
    OF '{{'
      DO AddItem
      cDepth+=1
    OF '}'
      DO AddItem
      cDepth-=1
      ASSERT(cDepth>0)                                  !Bad menu string
    ELSE
      cItem=cItem&mText[i]
      IF i=LEN(mText) THEN DO AddItem.                  !End of String - commit last menu item
    END
  END

AddItem ROUTINE
  IF cItem
    SELF.SetItem(AtPosition,cDepth,cItem,cItem)
    AtPosition+=1
    CLEAR(cItem)
  END


PopupClass.Kill PROCEDURE

  CODE
  DISPOSE(SELF.PopupItems)

PopupClass.Ask PROCEDURE(SIGNED XPos=0,SIGNED YPos=0)

  CODE
  SELF.LastSelection = SELF.GetName(SELF.ExecutePopup(SELF.GetMenuText(),XPos,YPos))
  IF SELF.LastSelection AND SELF.LocateName(SELF.LastSelection)
    IF SELF.PopupItems.Event OR SELF.PopupItems.MimicMode
      IF SELF.ClearKeycode THEN SETKEYCODE(0).
      POST(CHOOSE(SELF.PopupItems.MimicMode=1,EVENT:Accepted,SELF.PopupItems.Event),SELF.PopupItems.ControlID,SELF.MyThread)
    END
  END
  RETURN SELF.LastSelection

PopToolbox PROCEDURE( STRING S, STRING N )
P &PopupClass
  CODE
  P &= S+0
  P.AskToolbox(N)

PopupClass.Toolbox PROCEDURE(STRING Name)
  CODE
    SELF.InToolbox = 1
    SELF.ParentWindow &= SYSTEM{PROP:Target}
    START(PopToolbox,,ADDRESS(SELF),Name)

PopupClass.AskToolbox PROCEDURE(STRING N)
W    WINDOW,FONT('MS Sans Serif',8,,FONT:regular),CENTER,SYSTEM,TOOLBOX,TIMER(50)
     END
XP UNSIGNED
YP UNSIGNED
YD UNSIGNED(0)
C  UNSIGNED,AUTO
NV UNSIGNED
  CODE
  OPEN(W,SELF.ParentWindow)
  W{PROP:Text} = N
  SELF.ThisWindow &= W
  LOOP C=1 TO RECORDS(SELF.PopupItems)
    GET(SELF.PopupItems,C)
    IF ~SELF.PopupItems.OnToolbox THEN CYCLE .
    NV += 1
    SETTARGET(SELF.ParentWindow)
    SELF.CheckMimics
    SETTARGET(W)
    CREATE(NV,CREATE:Button)
    IF SELF.PopupItems.Icon
      NV{PROP:Icon} = '~'&SELF.PopupItems.Icon
      NV{PROP:ToolTip} = SELF.PopupItems.Text
    ELSE
      NV{PROP:Text} = SELF.PopupItems.Text
    END
    SETPOSITION(NV,XP,YP)
    XP += NV{PROP:Width}
    IF NV{PROP:Height}>YD THEN YD = NV{PROP:Height}.
  END
  UNHIDE(1,NV)
  W{PROP:Width} = XP
  W{PROP:Height} = YP + YD
  LOOP WHILE SELF.Ask() .

PopupClass.ResetToolbox PROCEDURE
XP UNSIGNED
YP UNSIGNED
YD UNSIGNED(0)
C  UNSIGNED,AUTO
NV UNSIGNED
  CODE
  IF SELF.ThisWindow &= NULL THEN RETURN.

  LOOP C=1 TO RECORDS(SELF.PopupItems)
    GET(SELF.PopupItems,C)
    IF ~SELF.PopupItems.OnToolbox THEN CYCLE .
    NV += 1
    SETTARGET(SELF.ParentWindow)
    SELF.CheckMimics
    SETTARGET(SELF.ThisWindow)
    IF NOT NV{Prop:Type}
       CREATE(NV,CREATE:Button)
    END
    IF SELF.PopupItems.Icon
      NV{PROP:Icon} = '~'&SELF.PopupItems.Icon
      NV{PROP:ToolTip} = RemoveAmpersand(SELF.PopupItems.Text)
    ELSE
      NV{PROP:Text} = SELF.PopupItems.Text
    END
    NV{PROP:Disable} = CHOOSE(SELF.PopupItems.Disabled=State:On)
    SETPOSITION(NV,XP,YP)
    UNHIDE(NV)
    XP += NV{PROP:Width}
    IF NV{PROP:Height}>YD THEN YD = NV{PROP:Height}.
  END
  NV+= 1 ! Past Last valid control
  LOOP Until NOT NV{Prop:Feq} ! Destroy old buttons
    DESTROY(NV)
    NV+= 1
  END
  0{PROP:Width} = XP
  0{PROP:Height} = YP + YD


PopupClass.SetItemEnable PROCEDURE(STRING Name,BYTE EnableState)
  CODE
  IF SELF.LocateName(Name) AND SELF.PopupItems.Text NOT='-'     !Cannot set enable state of separators
    SELF.PopupItems.Disabled = CHOOSE(EnableState=0,State:On,State:Off)
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
  IF SELF.LocateName(Name) AND SELF.PopupItems.Text NOT='-'           !Cannot set check state of seeperator items
    SELF.PopupItems.Check = CHOOSE(CheckState=0,State:Off,State:On)
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


PopupClass.Save PROCEDURE(STRING MenuDescription)

C       USHORT,AUTO
ItemStr STRING('ItemXXX')
  CODE
  IF ~SELF.INIMgr&=NULL AND RECORDS(SELF.PopupItems) AND LEN(MenuDescription)
    SELF.INIMgr.Update(MenuDescription,'Items',RECORDS(SELF.PopupItems))
    LOOP C=1 TO RECORDS(SELF.PopupItems)
      GET(SELF.PopupItems,C)
      ASSERT(~ERRORCODE())
      ItemStr=ItemStr[1:4]&FORMAT(C,@N03)
      SELF.INIMgr.Update(MenuDescription,ItemStr,SELF.PopupItems.Name&','&SELF.PopupItems.Text&','&SELF.PopupItems.Depth&','&SELF.PopupItems.ControlID&','&SELF.PopupItems.Event&','&SELF.PopupItems.MimicMode&','&SELF.PopupItems.Check&','&SELF.PopupItems.Disabled)
    END
  END


PopupClass.Restore PROCEDURE(STRING MenuDescription)

C         USHORT,AUTO
ItemStr   STRING('ItemXXX')

  CODE
  IF ~SELF.INIMgr&=NULL AND MenuDescription
    FREE(SELF.PopupItems)
    LOOP C=1 TO SELF.INIMgr.TryFetch(MenuDescription,'Items')
      ItemStr=ItemStr[1:4]&FORMAT(C,@N03)
      SELF.PopupItems.Name=SELF.INIMgr.FetchField(MenuDescription,ItemStr,1)
      SELF.PopupItems.Text=SELF.INIMgr.FetchField(MenuDescription,ItemStr,2)
      SELF.PopupItems.Depth=SELF.INIMgr.FetchField(MenuDescription,ItemStr,3)
      SELF.PopupItems.ControlID=SELF.INIMgr.FetchField(MenuDescription,ItemStr,4)
      SELF.PopupItems.Event=SELF.INIMgr.FetchField(MenuDescription,ItemStr,5)
      SELF.PopupItems.MimicMode=SELF.INIMgr.FetchField(Menudescription,ItemStr,6)
      SELF.PopupItems.Check=SELF.INIMgr.FetchField(Menudescription,ItemStr,7)
      SELF.PopupItems.Disabled=SELF.INIMgr.FetchField(Menudescription,ItemStr,8)
      ADD(SELF.PopupItems)
      ASSERT(~ERRORCODE())
    END
  END


PopupClass.AddItemEvent PROCEDURE(STRING Name,USHORT EventNo,SHORT ControlID)

RVal  STRING(MaxMenuItemLen),AUTO

  CODE
  RVal=CHOOSE(SELF.LocateName(Name)=0,SELF.AddItem(Name),Name)
  SELF.PopupItems.MimicMode=False
  SELF.PopupItems.ControlID=ControlID
  SELF.PopupItems.Event=EventNo
  SELF.PopupItems.OnToolbox=True
  PUT(SELF.PopupItems)
  ASSERT(~ERRORCODE())
  RETURN RVal


PopupClass.GetName PROCEDURE(USHORT Positional)

RVal        CSTRING(MaxMenuItemLen)
C           USHORT,AUTO
Pd          BYTE,AUTO
PosCnt      USHORT

  CODE
  IF Positional
    LOOP c=1 TO RECORDS(SELF.PopupItems)
      GET(SELF.PopupItems,c)
      IF ~SELF.PopupItems.Text='-'
        IF c<RECORDS(SELF.PopupItems)
          GET(SELF.PopupItems,c+1)
          Pd = SELF.PopupItems.Depth
          GET(SELF.PopupItems,c)
          IF Pd > SELF.PopupItems.Depth THEN CYCLE . ! Sub-menu headers not numbered
        END
        PosCnt+=1
        IF PosCnt=Positional
          RVal=SELF.PopupItems.Name
          BREAK
        END
      END
    END
  END
  RETURN RVal


PopupClass.GetLastSelection PROCEDURE()

  CODE
  RETURN SELF.LastSelection


PopupClass.GetMenuText PROCEDURE()

C           UNSIGNED,AUTO
MenuText    CSTRING(MaxMenuStrLen)
OldDepth    USHORT(1)
NewStyle    BYTE

  CODE
  LOOP C=1 TO RECORDS(SELF.PopupItems)
    GET(SELF.PopupItems,C)
    SELF.CheckMimics
    IF SELF.PopupItems.Icon
      NewStyle = 1
      BREAK
    END
  END
  LOOP C=1 TO RECORDS(SELF.PopupItems)
    GET(SELF.PopupItems,C)
    IF SELF.PopupItems.Depth=OldDepth
      MenuText=MenuText&'|'
    ELSIF SELF.PopupItems.Depth>OldDepth
      MenuText=MenuText&'{{'
    ELSE
      MenuText=MenuText&'}'
    END
    OldDepth=SELF.PopupItems.Depth
    SELF.CheckMimics
    IF SELF.PopupItems.Disabled = State:On
      MenuText = MenuText & '~'
    END
    IF SELF.PopupItems.Check <> State:None
      MenuText = MenuText & CHOOSE(SELF.PopupItems.Check = State:On,'+','-')
    END
    DO ExtendedItems
    IF ~SELF.Translator&=NULL               !Check and call to translator if setup
      SELF.PopupItems.Text=SELF.Translator.TranslateString(SELF.PopupItems.Text)
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

PopupClass.AddItemMimic PROCEDURE(STRING Name,SHORT ButtonID,<STRING Txt>)

RVal  STRING(MaxMenuItemLen),AUTO

  CODE
? ASSERT(INLIST(ButtonID{PROP:Type},CREATE:Button,CREATE:Item))  !Mimiced control must be a button or menu item
  RVal=SELF.AddItemEvent(Name,EVENT:Accepted,ButtonID)
  SELF.PopupItems.Text=Txt
  SELF.PopupItems.MimicMode=True
  SELF.PopupItems.OnToolbox=True
  PUT(SELF.PopupItems)
  ASSERT(~ERRORCODE())
  RETURN RVal


PopupClass.AddItem PROCEDURE(STRING MenuText)

  CODE
  RETURN SELF.AddItem(MenuText,GetUniqueName(SELF,CHOOSE(MenuText='-','Separator',MenuText)))


PopupClass.AddItem PROCEDURE(STRING MenuText,STRING ItemName)

  CODE
  RETURN SELF.AddItem(MenuText,ItemName,'',0)


PopupClass.AddItem PROCEDURE(STRING MenuText,STRING Name,STRING NameToFollow,BYTE Level)

  CODE
  RETURN SELF.SetItem(SELF.LocateName(NameToFollow),Level,Name,MenuText)


PopupClass.SetItem PROCEDURE(USHORT AddAfter,USHORT Level,STRING BaseName,STRING MenuText)

NewName CSTRING(MaxMenuItemLen+1),AUTO

  CODE
? ASSERT(~INSTRING('{{',MenuText,1,1) AND ~INSTRING('}',MenuText,1,1))  !{} characters not allowed in individual menu item names
  IF AddAfter=0 THEN AddAfter=RECORDS(SELF.PopupItems).                     !default action is to append to end of menu
  IF Level=0
    GET(SELF.PopupItems,AddAfter)
    Level=CHOOSE(ERRORCODE()=0,SELF.PopupItems.Depth,1)
  END
  NewName=GetUniqueName(SELF,BaseName)
  CLEAR(SELF.PopupItems)
  SELF.PopupItems.Name = NewName
  IF MenuText <> '-'
    LOOP
      EXECUTE(INSTRING(MenuText[1],'~+-'))
        SELF.PopupItems.Disabled = State:On
        SELF.PopupItems.Check = State:On
        SELF.PopupItems.Check = State:Off
      ELSE
        BREAK
      END
      MenuText = MenuText[2 : LEN(MenuText)]
    END
  END
  SELF.PopupItems.Text=MenuText
  SELF.PopupItems.Depth=Level
  ADD(SELF.PopupItems,AddAfter+1)
  ASSERT(~ERRORCODE())
  RETURN NewName


PopupClass.AddSubMenu PROCEDURE(STRING MenuHeading,STRING MenuText,STRING NameToFollow)

  CODE
  SELF.AddSubMenu(CLIP(MenuHeading)&'{{'&CLIP(MenuText)&'}',NameToFollow)


PopupClass.AddSubMenu PROCEDURE(STRING mText,STRING NameToFollow)

  CODE
  SELF.AddMenu(mText,SELF.LocateName(NameToFollow)+1)


PopupClass.LocateName PROCEDURE(STRING Name)
i USHORT,AUTO
  CODE
  LOOP i = 1 TO RECORDS(SELF.PopupItems)
    GET(SELF.PopupItems,i)
    IF SELF.PopupItems.Name = Name THEN RETURN i.
  END
  RETURN 0

PopupClass.GetItems PROCEDURE

  CODE
  RETURN RECORDS(SELF.PopupItems)


PopupClass.SetText PROCEDURE(STRING Name,STRING Txt)

  CODE
  IF SELF.LocateName(Name)
    SELF.PopupItems.Text = Txt
    PUT(SELF.PopupItems)
  END

PopupClass.SetIcon PROCEDURE(STRING Name,STRING Txt)

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

i USHORT,AUTO

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
    SELF.PopupItems.Depth=Lvl
    PUT(SELF.PopupItems)
  END


GetUniqueName PROCEDURE(PopupClass SELF,STRING ThisItem)

C           USHORT,AUTO
UNameLen    USHORT,AUTO
UniqueName  CSTRING(MaxMenuItemLen+1)

   CODE
   IF ThisItem='-'
     UniqueName='Separator'
   ELSE
     LOOP C=1 TO LEN(CLIP(ThisItem))
       CASE ThisItem[C]
       OF 'A' TO 'Z'
       OROF 'a' TO 'z'
       OROF '0' TO '9'
       OROF '_'
         UniqueName=UniqueName&ThisItem[C]
       END
     END
   END
   UNameLen=LEN(UniqueName)
   C=0
   LOOP
     IF C>0 THEN UniqueName=UniqueName[1:UNameLen]&C.
     IF ~SELF.LocateName(UniqueName) THEN BREAK.
     C+=1
   END
   RETURN UniqueName

RemoveAmpersand PROCEDURE(STRING ItemText)
CleanText STRING(100)
S         USHORT,AUTO
T         USHORT,AUTO
SLen      USHORT,AUTO
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
   IF SELF.InToolbox
     ACCEPT
       IF ACCEPTED() THEN RETURN ACCEPTED().
       IF EVENT() = EVENT:Timer
         SELF.ResetToolbox
       END
     END
     SELF.InToolbox = 0
     RETURN 0
   ELSE
    IF XPos AND YPos
      RETURN POPUP(MenuText,XPos,YPos)
    ELSIF XPos
      RETURN POPUP(MenuText,XPos)
    ELSIF YPos
      RETURN POPUP(MenuText,,YPos)
    ELSE
      RETURN POPUP(MenuText)
    END
  END


