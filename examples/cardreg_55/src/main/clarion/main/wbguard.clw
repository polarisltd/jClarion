  MEMBER

  INCLUDE('WBSTD.EQU'),ONCE
  INCLUDE('WBGUARD.INC'),ONCE
  INCLUDE('WBGUARD.TRN'),ONCE
  INCLUDE('KEYCODES.CLW'),ONCE
  INCLUDE('ABLWINR.INC'),ONCE
  INCLUDE('ABLWMAN.INC'),ONCE
  MAP
  END


UserName       CSTRING(255)
UserPassword   CSTRING(255)
VerifyPassword CSTRING(255)
AskWindow WINDOW('Logon'),AT(,,160,77),FONT('MS Sans Serif',8,,FONT:regular),CENTER,GRAY,NOFRAME
       PROMPT('User &ID:'),AT(4,8),USE(?Prompt1)
       ENTRY(@s255),AT(60,4,94,12),USE(UserName),REQ,UPR
       PROMPT('&Password:'),AT(4,24),USE(?Prompt2)
       ENTRY(@s40),AT(60,20,94,12),USE(UserPassword),PASSWORD,UPR,REQ
       PROMPT('&Verify Password:'),AT(4,44),USE(?Prompt3)
       ENTRY(@s40),AT(60,40,94,12),USE(VerifyPassword),PASSWORD,UPR,REQ
       BUTTON('&New User'),AT(8,60,42,14),USE(?NewUserButton)
       BUTTON('OK'),AT(68,60,42,14),USE(?OKButton),KEY(EnterKey),DEFAULT,REQ
       BUTTON('&Cancel'),AT(112,60,42,14),USE(?CancelButton)
     END


WinMan  CLASS(WindowManager)
Guard          &WbGuardClass,PRIVATE
Errors         &ErrorClass,PRIVATE
NewName        BYTE,PRIVATE
CurName        ASTRING,PRIVATE
WebServer      &WbServerClass,PRIVATE
WebWindow      &WbWindowClass,PRIVATE
AllowNewUser   BYTE,PRIVATE
WebWindowManager &WbWindowManagerClass,PRIVATE
Init           PROCEDURE,BYTE,PROC,DERIVED
InitGuardVar   PROCEDURE(WbGuardClass Guard, ErrorClass Errors, BYTE NewName, ASTRING CurName, BYTE AllowNewUser, <WbServerClass WebServer>),PRIVATE
Kill           PROCEDURE,PROC,BYTE,DERIVED
TakeAccepted   PROCEDURE,BYTE,PROC,DERIVED
    END


WbGuardClass.Init PROCEDURE(FileManager FileMgr, KEY FileKey, *? Name, *? Pswd, *? Capability, *? Id, <*? CntFailures>, <*? Locked>, <*? LockedUntil>, <ErrorClass ErrorHandler>)
  CODE
    SELF.FM &= FileMgr
    IF NOT OMITTED(10)
      SELF.Errors &= ErrorHandler
    ELSE
      SELF.Errors &= NEW ErrorClass
      SELF.Errors.Init
      SELF.ErrorsCreated = TRUE
    END
?   ASSERT(~SELF.Errors &= NULL, 'SELF.Errors is NULL!')
    SELF.Errors.AddErrors(WBGuardErrors)
    SELF.FileKey &= FileKey
    SELF.NameField &= Name
    SELF.PswdField &= Pswd
    SELF.UserCapField &= Capability
    SELF.ID &= ID
    SELF.CapField &= SELF.DefaultCapabilities
    IF NOT OMITTED(8)
      SELF.CntFailures &= CntFailures
    END
    IF NOT OMITTED(9)
      SELF.Locked &= Locked
    END
    IF NOT OMITTED(10)
      SELF.LockedUntil &= LockedUntil
    END
    SELF.PreventLogon=FALSE
    RETURN Level:Benign


WBGuardClass.SetCookieMgr PROCEDURE(WbCookieClass CookieMgr)

  CODE
  SELF.CookieMgr &= CookieMgr


WBGuardClass.GetPriorUse PROCEDURE

RVal  BYTE(Level:Benign)

  CODE
    IF ~SELF.CookieMgr &= NULL AND ~SELF.WebServer &= NULL AND SELF.WebServer.IsEnabled() |
      AND ~SELF.ReservedLogonName(SELF.CurName)
      IF SELF.CookieMgr.TryFetchCookie('ThisUser', 'PriorLogon') = 'Yes'
        RVal = Level:Notify           !Level:Notify means prior use found
      END
    END
    RETURN RVal


WbGuardClass.ThrowError PROCEDURE(SHORT ID, <ASTRING Text>)
  CODE
    IF ~OMITTED(3)
      RETURN SELF.Errors.ThrowMessage(ID, Text)
    ELSE
      RETURN SELF.Errors.Throw(ID)
    END


WbGuardClass.ActivateGuardFile PROCEDURE
  CODE
    SELF.FM.LazyOpen=FALSE
    RETURN SELF.FM.Open()


WbGuardClass.DeactivateGuardFile PROCEDURE
  CODE
    SELF.FM.Close


WbGuardClass.SetWeb PROCEDURE(WbServerClass WebServer)
  CODE
    SELF.WebServer &= WebServer


WbGuardClass.GetCurrent PROCEDURE
  CODE
    RETURN SELF.CurID


WbGuardClass.GetCapability PROCEDURE(ASTRING Capability, BYTE HaveAll, BYTE AllowLogon)
pos1 USHORT(1)
pos2 USHORT,AUTO
ret BYTE,AUTO
  CODE
    LOOP
      pos2 = INSTRING(',',Capability,1,pos1)
      ret = SELF._ProcessCapability(CHOOSE(pos2<>'',LEFT(CLIP(SUB(Capability,pos1,pos2-pos1))),LEFT(CLIP(SUB(Capability,pos1,LEN(Capability)+1-pos1)))))
      IF HaveAll AND ret <> Level:Benign OR ~HaveAll AND ret = Level:Benign
        BREAK
      END
      IF pos2 THEN
        pos1 = pos2+1
      ELSE
        BREAK
      END
    END
    IF ret <> Level:Benign AND ~SELF.CurName AND AllowLogon AND ~SELF.PreventLogon
      ret = SELF.Ask()
      IF ret = Level:Benign
        ret = SELF.GetCapability(Capability, HaveAll, AllowLogon)
      END
    END
    RETURN ret

WbGuardClass._ProcessCapability PROCEDURE(ASTRING Capability, BYTE Remove)

fa USHORT,AUTO
fb USHORT,AUTO
fc USHORT
fd USHORT
LC USHORT,AUTO

  CODE
    IF SELF.CurName
      SELF.NameField = SELF.CurName
      IF SELF.FM.Fetch(SELF.FileKey)<>Level:Benign
        RETURN Level:Fatal
      END
    END
    LC = LEN(SELF.CapField)
    LOOP WHILE fc<LC
      DO ParseCapability
      IF ~SELF.IgnoreCase AND SUB(SELF.CapField,fa,fb+1-fa)=Capability OR |
         SELF.IgnoreCase AND UPPER(SUB(SELF.CapField,fa,fb+1-fa))=UPPER(Capability)
        IF remove
          DO RemoveCapability
        END
        RETURN LEVEL:Benign
      END
    END
    RETURN LEVEL:Notify

ParseCapability ROUTINE
  DATA
comma BYTE
  CODE
  fa = CHOOSE(fc=0,1,fc)
  fb = fc
  LOOP WHILE fc < LC
    fc += 1
    CASE SUB(SELF.CapField,fc,1)
    OF ''
      IF NOT comma
        fb = fc
      END
    OF Delimiter
      comma = TRUE
      fd = fc
    ELSE
      IF comma THEN BREAK.
      fb = fc
    END
  END

RemoveCapability ROUTINE
  IF fd = 0             !only capability
    CLEAR(SELF.CapField)
  ELSIF fd < fa         !last capabilty
    SELF.CapField = SUB(SELF.CapField,1,fd-1)
  ELSE !fd > fb
    SELF.CapField = SUB(SELF.CapField,1,fa-1)&CHOOSE(fc<LC,SUB(SELF.CapField,fc,LC-fc+1),'')
  END
  IF SELF.CurName
    SELF.FM.Update()
  END


WbGuardClass.AssertCapability PROCEDURE(ASTRING Capability, BYTE HaveAll, BYTE AllowLogon)
  CODE
    IF SELF.GetCapability(Capability, HaveAll, AllowLogon) <> LEVEL:Benign
      RETURN SELF.TakeAssertFailed(Capability)
    END
    RETURN LEVEL:Benign


WbGuardClass.TakeAssertFailed PROCEDURE(ASTRING Capability)
  CODE
    RETURN SELF.ThrowError(Msg:CapabilityNotFound,Capability)

WbGuardClass.TakeInvalidPassword  PROCEDURE(BYTE PasswordReminder)
  CODE

WbGuardClass.TakeInvalidUser PROCEDURE(*? Name, *? Password)
  CODE

WbGuardClass.AddCapability PROCEDURE(ASTRING Capability)
  CODE
    IF SELF.GetCapability(Capability) <> LEVEL:Benign
      IF SELF.CurName  ! don't add if default capabilities
        SELF.NameField = SELF.CurName
        ASSERT(SELF.FM.Fetch(SELF.FileKey)=Level:Benign)
        SELF.CapField = CHOOSE(SELF.CapField<>'',SELF.CapField & Delimiter,'') & Capability
        SELF.FM.Update()
      END
    END


WbGuardClass.RemoveCapability PROCEDURE(ASTRING Capability)
  CODE
    SELF._ProcessCapability(Capability,TRUE)


WbGuardClass._CheckAdminExists PROCEDURE
SvCapField ANY,AUTO
  CODE
    IF ~SELF.AdminLogon THEN RETURN END
    SELF.NameField=UPPER(SELF.AdminLogon)
    IF SELF.FM.TryFetch(SELF.FileKey)=Level:Benign THEN RETURN END
    SvCapField &= SELF.CapField
    SELF.CapField &= SELF.UserCapField
    SELF.FM.PrimeRecord()
    SELF.NameField=UPPER(SELF.AdminLogon)
    SELF.PswdField = UPPER(SELF.AdminPassword)
    SELF.CapField = SELF.AdminCapabilities
    ASSERT(SELF.FM.Insert()=Level:Benign)
    SELF.CapField&=SvCapField

WbGuardClass.SetName PROCEDURE(ASTRING Name, ASTRING Pswd)
  CODE
    ASSERT(~SELF.FM &= NULL)
    SELF._CheckAdminExists()
    IF SELF.ReservedLogonName(Name)
      RETURN SELF.ThrowError(Msg:InvalidLogon,Name)
    END
    SELF.FM.ClearKey(SELF.FileKey)
    SELF.NameField = UPPER(Name)
    IF SELF.FM.TryFetch(SELF.FileKey)=Level:Benign
      IF NOT SELF.Locked &= NULL AND SELF.Locked
        IF NOT SELF.LockedUntil &= NULL AND SELF.LockedUntil <= TODAY()
          SELF.Locked = FALSE
          CLEAR(SELF.LockedUntil)
          IF NOT SELF.CntFailures &= NULL
            SELF.CntFailures = 0
          END
          SELF.FM.Update()
        ELSE
          DO ResetName
          RETURN SELF.ThrowError(Msg:AccountLocked)
        END
      END
      IF UPPER(SELF.PswdField) = UPPER(Pswd)
        SELF.CurName = UPPER(Name)
        SELF.CurID = SELF.ID
        SELF.CapField &= SELF.UserCapField
        IF NOT SELF.CntFailures &= NULL AND SELF.CntFailures > 0
          SELF.CntFailures = 0
          SELF.FM.Update()
        END
        RETURN LEVEL:Benign
      ELSE
        IF NOT SELF.CntFailures &= NULL
          SELF.CntFailures += 1
          IF SELF.CntFailures = SELF.AllowedAttempts
            IF NOT SELF.Locked &= NULL
              SELF.TakeInvalidPassword(SELF.PasswordReminder) ! Invalid Password.
              SELF.Locked = CHOOSE(SELF.PasswordReminder=TRUE,2,1)
              IF SELF.DaysToLock AND NOT SELF.LockedUntil &= NULL
                SELF.LockedUntil = TODAY() + SELF.DaysToLock
              END
              SELF.FM.Update()
              DO ResetName
              RETURN SELF.ThrowError(Msg:AccountLocked)
            END
          END
          SELF.FM.Update()
        END
      END
      SELF.TakeInvalidUser(Name, Pswd) ! Unknown account.
    END
    DO ResetName
    RETURN SELF.ThrowError(Msg:LogonError)

ResetName ROUTINE
  CLEAR(SELF.CurName)
  CLEAR(SELF.CurID)
  SELF.CapField &= SELF.DefaultCapabilities


WbGuardClass.SetNewName PROCEDURE(ASTRING Name, ASTRING Pswd, BYTE Visitor)
ret BYTE,AUTO
  CODE
    ASSERT(~SELF.FM &= NULL)
    IF Name = ''
      RETURN SELF.ThrowError(Msg:NameFieldRequired)
    ELSIF ~Visitor AND SELF.ReservedLogonName(Name)
      RETURN SELF.ThrowError(Msg:InvalidLogon,Name)
    ELSE
      SELF._CheckAdminExists()
      SELF.NameField = UPPER(Name)
      IF SELF.FM.TryFetch(SELF.FileKey) <> Level:Benign
        SELF.CapField &= SELF.UserCapField
        ret = SELF.FM.PrimeRecord()
        SELF.NameField = UPPER(Name)
        SELF.PswdField = UPPER(Pswd)
        SELF.CapField = SELF.DefaultCapabilities
        ret = SELF.FM.Insert()
        SELF.CurName = CHOOSE(ret = Level:Benign,UPPER(Name),'')
        IF ~SELF.CurName
          SELF.CapField &= SELF.DefaultCapabilities
        ELSE
          SELF.CurID = SELF.ID
        END
      ELSE  !Name exists
        IF SELF.CurName
          SELF.PswdField = UPPER(Pswd)
          ret = SELF.FM.Update()
        ELSE
          ret = SELF.ThrowError(Msg:DuplicateName,Name)
        END
      END
    END
    RETURN ret


WbGuardClass.ReservedLogonName PROCEDURE(ASTRING Name)
  CODE
    RETURN Level:Benign


WbGuardClass.Ask PROCEDURE

RVal BYTE,AUTO

  CODE
    RVal = SELF._Ask()
    IF RVal = Level:Benign AND ~SELF.CookieMgr &= NULL AND ~SELF.WebServer &= NULL AND SELF.WebServer.IsEnabled() |
      AND ~SELF.ReservedLogonName(SELF.CurName)
      SELF.CookieMgr.UpdateCookie('ThisUser', 'PriorLogon', 'Yes')
    END
    RETURN RVal


WbGuardClass.AskNewName PROCEDURE()
  CODE
    RETURN SELF._Ask(TRUE)


WbGuardClass.Kill PROCEDURE
  CODE
    SELF.FM.Close
    IF SELF.ErrorsCreated
      SELF.Errors.Kill
      DISPOSE(SELF.Errors)
      SELF.ErrorsCreated = FALSE
    END


WbGuardClass._Ask PROCEDURE(BYTE NewName)
ret BYTE,AUTO
WM WinMan
  CODE
    IF NOT SELF.WebServer &= NULL
      WM.InitGuardVar(SELF, SELF.Errors, NewName, SELF.CurName, SELF.AllowNewUser, SELF.WebServer)
    ELSE
      WM.InitGuardVar(SELF, SELF.Errors, NewName, SELF.CurName, SELF.AllowNewUser)
    END
    ret = CHOOSE(WM.Run() = RequestCompleted,LEVEL:Benign,Level:Notify)
    RETURN ret

WinMan.InitGuardVar PROCEDURE(WbGuardClass Guard, ErrorClass Errors, BYTE NewName, ASTRING CurName, BYTE AllowNewUser, <WbServerClass WebServer>)
  CODE
    SELF.Guard &= Guard
    SELF.Errors &= Errors
    SELF.NewName = NewName
    IF ~SELF.Guard.ReservedLogonName(CurName)
      SELF.CurName = CurName
    END
    IF NOT OMITTED(7)
      SELF.WebServer &= WebServer
    END
    SELF.AllowNewUser = AllowNewUser

WinMan.Init PROCEDURE

RVal BYTE,AUTO

  CODE
  RVal = PARENT.Init()
  IF RVal = Level:Benign
    SELF.SetResponse(RequestCancelled)
    OPEN(AskWindow)
    SELF.Opened = True
    IF ~SELF.NewName AND ~SELF.CurName THEN HIDE(?Prompt3,?VerifyPassword).
    IF ~SELF.AllowNewUser OR SELF.NewName THEN HIDE(?NewUserButton).
    CLEAR(UserPassword)
    CLEAR(VerifyPassword)
    IF SELF.CurName
      UserName = SELF.CurName
      ?UserName{Prop:Disable} = 1
      AskWindow{Prop:Text} = 'Change Password'
      ?Prompt2{Prop:Text} = 'New Password'
      HIDE(?NewUserButton)
    END
    IF NOT SELF.WebServer &= NULL
      SELF.WebWindow &= NEW WbWindowClass
      SELF.WebWindowManager &= NEW WbWindowManagerClass
      SELF.WebWindow.Init()
      SELF.WebWindowManager.Init(SELF.WebServer, SELF.WebWindow.IPageCreator, SELF.WebWindow.IWebResponseProcessor, AskWindow{PROP:text})
      SELF.AddItem(SELF.WebWindow.WindowComponent)
      SELF.AddItem(SELF.WebWindowManager.WindowComponent)
    END
    SELF.SetAlerts
  END
  RETURN RVal


WinMan.Kill PROCEDURE

ret         BYTE,AUTO

  CODE
  ret = PARENT.Kill()
  IF ret = Level:Benign
    CLOSE(AskWindow)
    IF NOT SELF.WebServer &= NULL
      IF SELF.WebServer.IsEnabled() THEN POST(EVENT:NewPage).
      DISPOSE(SELF.WebWindow)
    END
    SELF.Opened = False
  END
  RETURN ret


WinMan.TakeAccepted PROCEDURE

ret BYTE,AUTO

  CODE
  ret = PARENT.TakeAccepted()
  IF ret = Level:Benign
    CASE ACCEPTED()
    OF ?OkButton
      IF ?VerifyPassword{PROP:Hide}=FALSE
        IF UserPassword <> VerifyPassword
          SELECT(?UserPassword)
          RETURN SELF.Guard.ThrowError(Msg:VerifyPswdFailed)
        END
      END
      IF SELF.NewName AND SELF.Guard.SetNewName(UserName,UserPassword)=Level:Benign OR |
         SELF.CurName AND SELF.Guard.SetNewName(UserName,UserPassword)=Level:Benign OR |
        ~SELF.NewName AND ~SELF.CurName AND SELF.Guard.SetName(UserName,UserPassword)=Level:Benign
        SELF.SetResponse(RequestCompleted)
      END
    OF ?CancelButton
      SELF.Guard.PreventLogon=TRUE
      SELF.SetResponse(RequestCancelled)
    OF ?NewUserButton
      SELF.NewName = TRUE
      UNHIDE(?Prompt3, ?VerifyPassword)
      HIDE(?NewUserButton)
      SELECT(?UserName)
    END
  END
  RETURN ret
