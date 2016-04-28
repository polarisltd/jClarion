!Popup Manager definitions

!ABCIncludeFile

OMIT('_EndOfInclude_',_POPUPPRESENT_)
_PopupPresent_      EQUATE(1)

  INCLUDE('ABUTIL.INC'),ONCE

MaxMenuStrLen       EQUATE(10000)                       !Maximum allowed length of menu string
MaxMenuItemLen      EQUATE(1024)                        !Maximum allowed length of any single menu item

PopupClass          CLASS,MODULE('ABPOPUP.CLW'),TYPE,LINK('ABPOPUP.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
ClearKeycode          BYTE
LastSelection         CSTRING(MaxMenuItemLen),PRIVATE
PopupItems            &PopupItemQueue,PRIVATE
Translator            &TranslatorClass,PRIVATE
INIMgr                &INIClass,PRIVATE
InToolbox             BYTE,PRIVATE
MyThread              UNSIGNED,PRIVATE
ParentWindow          &Window,PRIVATE
ThisWindow            &Window,PRIVATE
AddItem               PROCEDURE(STRING Text),STRING,PROC                                                  !Adds a single menu item at end of menu
AddItem               PROCEDURE(STRING Text,STRING ItemName),STRING,PROC                                  !Adds a single menu item at end of menu with the name specified
AddItem               PROCEDURE(STRING Text,STRING ItemName,STRING NameToFollow,BYTE Level),STRING,PROC   !Adds a single menu item following NameToFollow
AddItemEvent          PROCEDURE(STRING Name,USHORT EventNo,SHORT ControlID=0),STRING,PROC     !Returns the label of the item
AddItemMimic          PROCEDURE(STRING Name,SHORT ButtonID,<STRING Text>),STRING,PROC         !Mimics a button, returns the label of the item
AddMenu               PROCEDURE(STRING Text,BYTE AtPosition=0)                                !Adds an entire menu
AddSubMenu            PROCEDURE(STRING Text,STRING NameToFollow)
AddSubMenu            PROCEDURE(STRING Heading,STRING Text,STRING NameToFollow)
Ask                   PROCEDURE(SIGNED XPos=0,SIGNED YPos=0),STRING,PROC
AskToolbox            PROCEDURE(STRING N),PRIVATE
CheckMimics           PROCEDURE,PRIVATE
DeleteItem            PROCEDURE(STRING Name)
ExecutePopup          PROCEDURE(STRING MenuText,UNSIGNED XPos,UNSIGNED YPos),UNSIGNED,PRIVATE
GetItemChecked        PROCEDURE(STRING Name),BYTE
GetItemEnabled        PROCEDURE(STRING Name),BYTE
GetItems              PROCEDURE(),USHORT                                                      !Returns number of menu items
GetLastSelection      PROCEDURE(),STRING                                                      !Returns lase selected item from last Ask() or ''
GetMenuText           PROCEDURE(),STRING,PRIVATE
GetName               PROCEDURE(USHORT Position),STRING,PRIVATE
Init                  PROCEDURE   !,EXTENDS
Init                  PROCEDURE(INIClass IC)   !,EXTENDS
Kill                  PROCEDURE
LocateName            PROCEDURE(STRING NameToFind),BYTE,PRIVATE
Restore               PROCEDURE(STRING Description)
ResetToolbox          PROCEDURE,PRIVATE !
Save                  PROCEDURE(STRING Description)
SetItem               PROCEDURE(USHORT AddAfter,USHORT Level,STRING BaseName,STRING MenuText),STRING,PROC,PRIVATE
SetItemCheck          PROCEDURE(STRING Name,BYTE CheckState)
SetItemEnable         PROCEDURE(STRING Name,BYTE EnableState)
SetLevel              PROCEDURE(STRING Name,BYTE Level)
SetIcon               PROCEDURE(STRING Name,STRING IconName)
SetText               PROCEDURE(STRING Name,STRING Text)
SetToolbox            PROCEDURE(STRING Name,BYTE Show)
SetTranslator         PROCEDURE(TranslatorClass T)
Toolbox               PROCEDURE(STRING Name)
ViewMenu              PROCEDURE                                                     !Debug only
                    END

_EndOfInclude_



