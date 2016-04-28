!ABCIncludeFile(GUARD)

  OMIT('_EndOfInclude_', _GuardPresent_)
_GuardPresent_  EQUATE(1)

  INCLUDE('ABERROR.INC'),ONCE
  INCLUDE('ABFILE.INC'),ONCE
  INCLUDE('ABWINDOW.INC'),ONCE
  INCLUDE('WBUTIL.INC'),ONCE

Delimiter STRING(',')

  ITEMIZE(100),PRE(Msg)
VerifyPswdFailed     EQUATE
CapabilityNotFound   EQUATE
DuplicateName        EQUATE
LogonError           EQUATE
NameFieldRequired    EQUATE
AccountLocked        EQUATE
InvalidLogon         EQUATE
  END

WbGuardClass         CLASS,TYPE,MODULE('WBGUARD.CLW'),LINK('WBGUARD', _GuardLinkMode_),DLL(_GuardDllMode_)
CookieMgr            &WbCookieClass,PRIVATE
Errors               &ErrorClass,PRIVATE
FM                   &FileManager,PRIVATE
FileKey              &KEY
NameField            ANY,PRIVATE
PswdField            ANY,PRIVATE
Id                   ANY,PRIVATE
CapField             ANY,PRIVATE
CntFailures          ANY,PRIVATE
Locked               ANY,PRIVATE
LockedUntil          ANY,PRIVATE
UserCapField         ANY,PRIVATE
CurName              ASTRING,PRIVATE
CurID                ASTRING,PRIVATE
DefaultCapabilities  ASTRING
AdminLogon           ASTRING
AdminPassword        ASTRING
AdminCapabilities    ASTRING
DaysToLock           LONG
AllowedAttempts      LONG  !0 means unlimited
PasswordReminder     BYTE
ErrorsCreated        BYTE,PRIVATE
HtmlManager          &WbHtmlClass,PRIVATE
WebServer            &WbServerClass,PRIVATE
IgnoreCase           BYTE
AllowNewUser         BYTE
PositionFile         BYTE
PreventLogon         BYTE

_Ask                 PROCEDURE(BYTE NewName=FALSE),BYTE,PRIVATE
_CheckAdminExists    PROCEDURE,PRIVATE
_ProcessCapability   PROCEDURE(ASTRING Capability, BYTE Remove=0),BYTE,PROC,PRIVATE

ActivateGuardFile    PROCEDURE(),BYTE  !necessary because of THREAD attribute
AddCapability        PROCEDURE(ASTRING Capability)
Ask                  PROCEDURE,BYTE,VIRTUAL
AskNewName           PROCEDURE,BYTE,VIRTUAL
AssertCapability     PROCEDURE(ASTRING Capability, BYTE HaveAll=TRUE, BYTE AllowLogon=TRUE),BYTE,VIRTUAL
DeactivateGuardFile  PROCEDURE
GetCapability        PROCEDURE(ASTRING Capability, BYTE HaveAll=TRUE, BYTE AllowLogon=TRUE),BYTE
GetCurrent           PROCEDURE,ASTRING
GetPriorUse          PROCEDURE,BYTE                               !Returns Level:Benign if application used by this client before
Init                 PROCEDURE(FileManager FileMgr, KEY FileKey, *? Name, *? Pswd, *? Capability, *? Id, <*? CntFailures>, <*? Locked>, <*? LockedUntil>, <ErrorClass ErrorHandler>),BYTE,PROC   !,EXTENDS
Kill                 PROCEDURE
RemoveCapability     PROCEDURE(ASTRING Capability)
ReservedLogonName    PROCEDURE(ASTRING Name),BYTE,VIRTUAL
SetCookieMgr         PROCEDURE(WbCookieClass CookieMgr)
SetName              PROCEDURE(ASTRING Name, ASTRING Pswd),BYTE
SetNewName           PROCEDURE(ASTRING Name, ASTRING Pswd,BYTE Visitor=FALSE),BYTE
SetWeb               PROCEDURE(WbServerClass WebServer)
TakeAssertFailed     PROCEDURE(ASTRING FailedOn),BYTE,VIRTUAL
TakeInvalidPassword  PROCEDURE(BYTE PasswordReminder),VIRTUAL
TakeInvalidUser      PROCEDURE(*? Name, *? Password),VIRTUAL
ThrowError           PROCEDURE(SHORT ID, <ASTRING Text>),BYTE,VIRTUAL
                   END

  _EndOfInclude_
