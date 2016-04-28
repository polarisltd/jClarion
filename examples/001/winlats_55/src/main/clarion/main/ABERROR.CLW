  MEMBER

  INCLUDE('ABERROR.INC'),ONCE
  INCLUDE('ABERROR.TRN'),ONCE
  INCLUDE('ABWINDOW.INC'),ONCE

  MAP
Replace       PROCEDURE(STRING,STRING,*CSTRING),PRIVATE
SetId         PROCEDURE(ErrorClass,USHORT Id,UNSIGNED StartPos),BYTE,PRIVATE
    MODULE('Core')
      DESTROY(FILE,UNSIGNED=0),NAME('Cla$FILE_DESTROY')
    END
  END


PNQ         QUEUE,TYPE
Thread        LONG
Name          ASTRING
            END


Window WINDOW('Error'),AT(,,320,96),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI),CENTER,GRAY,RESIZE
       IMAGE,AT(2,4,26,28),USE(?Image, ImageFeq)
       LIST,AT(32,4,286,71),USE(?List, ListFeq),VSCROLL,FORMAT('217L(2)|M~Message~S(255)@s255@42L(2)|M~Category~L(1)@s255@')
       BUTTON('Button 1'),AT(4,80,36,14),USE(?Button1,BaseButtonFeq + 7),HIDE
       BUTTON('Button 2'),AT(44,80,36,14),USE(?Button2,BaseButtonFeq + 6),HIDE
       BUTTON('Button 3'),AT(84,80,36,14),USE(?Button3,BaseButtonFeq + 5),HIDE
       BUTTON('Button 4'),AT(124,80,36,14),USE(?Button4,BaseButtonFeq + 4),HIDE
       BUTTON('Button 5'),AT(164,80,36,14),USE(?Button5,BaseButtonFeq + 3),HIDE
       BUTTON('Button 6'),AT(204,80,36,14),USE(?Button6,BaseButtonFeq + 2),HIDE
       BUTTON('Button 7'),AT(244,80,36,14),USE(?Button7,BaseButtonFeq + 1),HIDE
       BUTTON('Button 8'),AT(284,80,36,14),USE(?Button8,BaseButtonFeq),HIDE
     END


StdErrorFile  FILE,DRIVER('ASCII'),CREATE,NAME('ABCError.Log')
                RECORD
Txt               STRING(1024)
                END
              END


ErrorClass.SetId PROCEDURE(USHORT Id,UNSIGNED StartPos)
I UNSIGNED,AUTO
   CODE
?   ASSERT(~(Self.Errors &= NULL),'ErrorClass not correctly initialized')
    LOOP I = StartPos TO 1 BY -1
      GET(SELF.Errors,I)
      IF Self.Errors.Id = Id
        RETURN Level:Benign
      END
    END
    RETURN Level:Notify

! This routines finds the first occurrence of Id in the queue starting
! from the end of the list. It is -not- a sorted list to allow multiple
! entries with a clear definition of which overrides the other.
ErrorClass.SetId PROCEDURE(USHORT Id)
  CODE
    ASSERT(~SELF.SetId(ID,RECORDS(Self.Errors)),'Identifier not found.')

! This function is to Do 'innocent' errors such as end of file
! By default it does nothing, you may wish to insert tracing in here for
! debug purposes
ErrorClass.TakeBenign PROCEDURE
  CODE
    RETURN Level:Benign

! This procedure takes a group of type ErrorBlock and translates the
! group into entries in the Errors queue.
ErrorClass.AddErrors PROCEDURE(ErrorBlock ErrsIn)
Follow USHORT(3)
Slen   BYTE,AUTO
Errs   &STRING
  CODE
    Errs &= ErrsIn
?   ASSERT(NOT SELF.Errors &= NULL,'ErrorClass incorrectly initialized.')
    LOOP ErrsIn.Number TIMES
      SELF.Errors.Id = VAL(Errs[Follow])+256 * VAL(Errs[Follow+1])      ! Id is a little-endian binary 16 bit word
      Follow += 2
      SELF.Errors.Fatality = VAL(Errs[Follow])
      Follow += 1
      Slen = VAL(Errs[Follow])
      Follow += 1
      SELF.Errors.Title &= Errs[Follow :Follow+Slen-1]
      Follow += Slen
      Slen = VAL(Errs[Follow])
      Follow += 1
      SELF.Errors.Message &= Errs[Follow :Follow+Slen-1]
      Follow += Slen
      SELF.Errors.Category = ''
      ADD(SELF.Errors)
?     ASSERT(~ERRORCODE(),'Unable to add new error message to queue.')
    END

! This is for errors which the program is not expected to Do.
! The default action is to issue a message and HALT
! You may, if you wish, return from this function but it is up to you
! to make sure this 'fatal' condition has been rendered benign
ErrorClass.TakeFatal PROCEDURE
   CODE
     SELF.Msg(SELF.SubsString() & '  Press OK to end this application', |
             SELF.Errors.Title,ICON:Exclamation,Button:OK,BUTTON:OK,0)
     HALT(0,SELF.Errors.Title)
     RETURN Level:Fatal

ErrorClass.TakeNotify   PROCEDURE
   CODE
     SELF.Msg(SELF.SubsString(),SELF.Errors.Title,ICON:Exclamation,|
       Button:OK,BUTTON:OK,0)

! This is purely here to enable people to add their own fatality levels
! By default an unknown fatality is a program error
ErrorClass.TakeOther PROCEDURE
  CODE
    RETURN SELF.TakeProgram()

! This is for errors which really suggest a mal-functioning program
! The default action is simply to make the error fatal
ErrorClass.TakeProgram   PROCEDURE
  CODE
    RETURN SELF.TakeFatal()

! This is really to allow the user to confirm an action
! The simple case is just a yes or no with a yes default
ErrorClass.TakeUser PROCEDURE
  CODE
    IF SELF.Msg(SELF.SubsString(),SELF.Errors.Title,ICON:Question, |
       Button:Yes+Button:No,BUTTON:Yes,0) = Button:Yes
      RETURN Level:Benign
    ELSE
      RETURN Level:Cancel
    END


ErrorClass.Init PROCEDURE

  CODE
    SELF.StdErrorLog &= NEW StandardErrorLogClass
    SELF.SetCategory( ,'ABC')
    SELF.HistoryThreshold = 0                         !Switch off error history for backwards compatibility
    SELF.HistoryViewLevel = Level:Fatal
    SELF.HistoryResetOnView = False
    SELF.Init(SELF.StdErrorLog.ErrorLogInterface)


ErrorClass.Init PROCEDURE(ErrorLogInterface ErrLog)

  CODE
    SELF.ErrorLog &= ErrLog
    SELF.Errors &= NEW ErrorEntry
    SELF.AddErrors(DefaultErrors)
    SELF.ProcNames &= NEW PNQ
    IF SELF.History&=NULL THEN SELF.History &= NEW ErrorHistoryList .


ErrorClass.Kill PROCEDURE
  CODE
    DISPOSE(SELF.Errors)
    DISPOSE(SELF.History)
    DISPOSE(SELF.ProcNames)
    DISPOSE(SELF.StdErrorLog)


! For people that want to use the ErrorClass as a simple way
! of putting messages on the screen
ErrorClass.Message PROCEDURE(SHORT Id,LONG Buttons,LONG Default)
  CODE

    IF SELF.Silent THEN RETURN Default .

    SELF.SetId(Id)
    RETURN SELF.MessageBox(, SELF.SubsString(),SELF.Errors.Title,ICON:Question,|
      Buttons,Default,0)


ErrorClass.GetProcedureName PROCEDURE
  CODE
? ASSERT(~SELF.ProcNames &= NULL,'ErrorClass incorrectly initialized.')
  IF ~RECORDS(SELF.ProcNames) THEN RETURN ''.
  GET(SELF.ProcNames,RECORDS(SELF.ProcNames))
  LOOP WHILE SELF.ProcNames.Thread <> THREAD()
    IF ERRORCODE() THEN RETURN '' .
    GET(SELF.Procnames,POINTER(SELF.ProcNames)-1)
  END
  RETURN SELF.ProcNames.Name

ErrorClass.SetProcedureName PROCEDURE(<STRING S>)
  CODE
  IF OMITTED(2)
    IF SELF.GetProcedureName()
      DELETE(SELF.ProcNames)
    END
  ELSE
    SELF.ProcNames.Name = CLIP(S)
    SELF.Procnames.Thread = THREAD()
    ADD(SELF.ProcNames)
  END

ErrorClass.SetErrors PROCEDURE
  CODE
    SELF.SaveErrorCode = ERRORCODE()
    SELF.SaveError = CLIP(ERROR())
    SELF.SaveFileErrorCode = CLIP(FILEERRORCODE())
    SELF.SaveFileError = CLIP(FILEERROR())

ErrorClass.SetField PROCEDURE(STRING Name)
  CODE
    SELF.FieldName = CLIP(Name)

ErrorClass.SetFile PROCEDURE(STRING Name)
  CODE
    SELF.FileName = CLIP(Name)

ErrorClass.SetFatality PROCEDURE(SHORT Id,BYTE level)
  CODE
    SELF.SetId(Id)
    SELF.Errors.Fatality = level
    PUT(Self.Errors)
?   ASSERT(~ERRORCODE(),'Unable to change fatality level.')

! The function takes a description string and substitutes in for these
! %File          -> FileName
! %Error         -> ERROR() string
! %ErrorCode     -> ERRORCODE()
! %FileError     -> FILEERROR()
! %FileErrorCode -> FILEERRORCODE()
! %Message       -> User define message
! %Field         -> Fieldname
! %ErrorText     -> %FileError(%FileErrorCode)
! %Previous      -> Whatever the previous incarnation of this error said
! %Procedure     -> Current procedure name
! %Category      -> The category of the error
ErrorClass.SubsString PROCEDURE
BuildString CSTRING(2000)
ErrorPos USHORT,AUTO
  CODE
    BuildString = SELF.Errors.Message
    Replace('%File',SELF.FileName,BuildString)
    Replace('%ErrorCode',SELF.SaveErrorCode,BuildString)
    IF SELF.SaveErrorCode = 90
      Replace('%ErrorText',Self.SaveFileError&' ('&Self.SaveFileErrorCode&')',BuildString)
    ELSE
      Replace('%ErrorText',Self.SaveError&' ('&Self.SaveErrorCode&')',BuildString)
    END
    Replace('%Error',SELF.SaveError,BuildString)
    Replace('%FileErrorCode',SELF.SaveFileErrorCode,BuildString)
    Replace('%FileError',SELF.SaveFileError,BuildString)
    Replace('%Message',SELF.MessageText,BuildString)
    Replace('%Field',SELF.FieldName,BuildString)
    Replace('%Procedure',SELF.GetProcedureName(),BuildString)
    Replace('%Category', SELF.Errors.Category, BuildString)
    IF INSTRING('%Previous',BuildString,1,1)
      ErrorPos = POINTER(SELF.Errors)
      IF SELF.SetId(SELF.Errors.Id,ErrorPos-1)
        Replace('%Previous','',BuildString)
      ELSE
        Replace('%Previous',SELF.Errors.Message,BuildString)
      END
      GET(SELF.Errors,ErrorPos)
    END
    RETURN BuildString

! The main 'accept error' function. Saves the error state, locates the
! error number and then calls the relevant TakeError function
! The ELSE clause allows 'template' defined errors.
ErrorClass.Throw  PROCEDURE(SHORT Id)
  CODE
    SELF.SetErrors
    RETURN SELF.TakeError(Id)

ErrorClass.TakeError PROCEDURE(SHORT Id)
  CODE
    SELF.SetId(Id)
    CASE SELF.Errors.Fatality
    OF Level:Benign
      RETURN SELF.TakeBenign()
    OF Level:User
    OROF Level:Cancel
      RETURN SELF.TakeUser()
    OF Level:Program
      RETURN SELF.TakeProgram()
    OF Level:Fatal
      RETURN SELF.TakeFatal()
    OF Level:Notify
      SELF.TakeNotify()
      RETURN Level:Notify
    ELSE
      RETURN SELF.TakeOther()
    END

ErrorClass.ThrowFile PROCEDURE(SHORT Id,STRING File)
  CODE
    SELF.SetFile(File)
    RETURN SELF.Throw(Id)

ErrorClass.ThrowMessage PROCEDURE(SHORT Id,STRING Message)
  CODE
    SELF.MessageText = Message
    RETURN SELF.Throw(Id)

ErrorClass.RemoveErrors PROCEDURE(ErrorBlock ErrsIn)

Errs  &STRING
P     USHORT(3)
L     USHORT,AUTO

  CODE
  Errs &= ErrsIn
  LOOP ErrsIn.Number TIMES
    L=VAL(Errs[P])+256 * VAL(Errs[P+1])
    P+=3
    P+=VAL(Errs[P])+1
    P+=VAL(Errs[P])+1
    SELF.SetId(L)
    DELETE(SELF.Errors)
?   ASSERT(~ERRORCODE(),'Unable to delete error id :'&L)
  END


ErrorClass.Msg PROCEDURE(STRING Txt, <STRING Caption>, <STRING Icon>, LONG Buttons, LONG DefaultButton, LONG Style)

RVal  LONG,AUTO

  CODE
  RVal = DefaultButton
  IF SELF.LogErrors
?   ASSERT(~SELF.ErrorLog &= NULL, 'Attempt to LogErrors with ErrorLogInterface NULL!')
    ASSERT(SELF.ErrorLog.Open() = Level:Benign, 'Unable to Open error log; ' & ERROR())          ! Do not make this conditionally compile in debug
    ASSERT(SELF.ErrorLog.Take(FORMAT(TODAY(), @D17) & '@' & FORMAT(CLOCK(), @T8) & ' --> ' & Txt) = Level:Benign, 'Unable to update error log; ' & ERROR())     ! ditto
    ASSERT(SELF.ErrorLog.Close() = Level:Benign, 'Unable to close error log; ' & ERROR())        ! ditto
  END
  IF SELF.HistoryThreshold
    IF SELF.HistoryThreshold > 0
      LOOP WHILE RECORDS(SELF.History) >= SELF.HistoryThreshold
        GET(SELF.History, 1)                  ! Delete 'scrolled' items from 'top' of list
?       ASSERT(~ERRORCODE())
        DELETE(SELF.History)
?       ASSERT(~ERRORCODE())
      END
    END
    SELF.History.Txt = Txt
    SELF.History.Id = SELF.Errors.Id
    SELF.History.Category = SELF.GetCategory(SELF.Errors.Id)
    SELF.AddHistory
  END
  IF ~SELF.Silent
    IF SELF.HistoryThreshold
      IF SELF.Errors.Fatality = SELF.HistoryViewLevel
        RVal = SELF.HistoryMsg(Caption, Icon, Buttons, DefaultButton)
        IF SELF.HistoryResetOnView
          SELF.ResetHistory
        END
      END
    ELSE
      RVal = SELF.MessageBox(SELF.Errors.Fatality, Txt, Caption, Icon, Buttons, DefaultButton, Style)
    END
  END
  RETURN RVal


ErrorClass.AddHistory PROCEDURE
  CODE

  ADD(SELF.History)                       ! Add new item to end of list
? ASSERT(~ERRORCODE())


ErrorClass.MessageBox PROCEDURE(BYTE Level, STRING Txt, <STRING Caption>, <STRING Icon>, LONG Buttons, LONG DefaultButton, LONG Style)
  CODE

  RETURN MESSAGE(Txt, Caption, Icon, Buttons, DefaultButton, Style)


ErrorClass.ResetHistory PROCEDURE

  CODE
  FREE(SELF.History)


ErrorClass.ViewHistory PROCEDURE

  CODE
                                   
  SELF.HistoryMsg('Errors History', 0, BUTTON:OK + BUTTON:HELP, BUTTON:OK)


ErrorClass.SetCategory PROCEDURE(SHORT Id, ASTRING Category)

  CODE
  IF Id = -1
    SELF.DefaultCategory = Category
  ELSE
    SELF.SetId(Id)
    SELF.Errors.Category = Category
    PUT(SELF.Errors)
?   ASSERT(~ERRORCODE())
  END


ErrorClass.GetCategory PROCEDURE(SHORT Id)

RVal  ASTRING,AUTO

  CODE
  IF Id = -1
    RVal = SELF.DefaultCategory
  ELSE
    RVal = CHOOSE(SELF.SetId(Id, RECORDS(SELF.Errors)) = Level:Benign AND SELF.Errors.Category <> '', SELF.Errors.Category, SELF.DefaultCategory)
  END
  RETURN RVal


ErrorClass.HistoryMsg PROCEDURE(STRING Caption, LONG Icon, LONG Buttons, LONG DefaultButton)
MsgBox MsgBoxClass
Hist   HistHandlerClass
  CODE

  MsgBox.Init(Window, SELF, Caption, Icon, Buttons, DefaultButton)
  Hist.Init(Window, SELF, SELF.History)
  MsgBox.HistoryHandler &= Hist.WindowComponent
  MsgBox.Run
  RETURN MsgBox.MsgRVal


MsgBoxClass.Init PROCEDURE(WINDOW Win, ErrorClass Err, <STRING Caption>, LONG Icon, LONG Buttons, LONG DefaultButton, LONG Style)
  CODE

  SELF.Win &= Win
  SELF.Err &= Err
  SELF.Caption &= NEW STRING(LEN(Caption))
  SELF.Caption = Caption
  SELF.Icon = Icon
  SELF.ButtonTypes = Buttons
  SELF.MsgRVal = DefaultButton
  SELF.Style = Style


MsgBoxClass.Init PROCEDURE

RVal  BYTE,AUTO
i     LONG,AUTO
Feq   UNSIGNED,AUTO

  CODE
  RVal = PARENT.Init()
  IF RVal = Level:Benign
    IF ~(SELF.HistoryHandler &= NULL)
      SELF.AddItem(SELF.HistoryHandler)
    END

    OPEN(SELF.Win)
    SELF.Opened = True
    IF SELF.Caption
      SELF.Win{PROP:Text} = SELF.Caption
    END
    SELF.MsgButtons = 0
    LOOP i = 7 TO 0 BY -1
      IF BAND(SELF.ButtonTypes, 2 ^ i)
        SELF.MsgButtons += 1
        SELF.MsgButtonID[SELF.MsgButtons] = 2 ^ i
        Feq=BaseButtonFeq + SELF.MsgButtons - 1
        Feq{PROP:Text} = CHOOSE(i + 1, 'O&k', '&Yes', '&No', '&Abort', '&Retry', '&Ignore', '&Cancel', '&Help')
        IF SELF.MsgRVal = 2 ^ i
          Feq{PROP:Default} = True
          SELECT(Feq)
        END
        UNHIDE(Feq)
      END
    END
    SELF.SetupAdditionalFeqs
  END
  RETURN RVal


MsgBoxClass.Kill PROCEDURE

RVal  BYTE,AUTO

  CODE
  RVal = PARENT.Kill()
  IF RVal = Level:Benign
    DISPOSE(SELF.Caption)

    CLOSE(SELF.Win)
    SELF.Opened = False
  END
  RETURN RVal


MsgBoxClass.FetchFeq PROCEDURE(BYTE Btn)
i LONG,AUTO
  CODE

  LOOP i = 1 TO SELF.MsgButtons
    IF SELF.MsgButtonID[i] = Btn
      RETURN BaseButtonFeq + i - 1
    END
  END
  RETURN 0


MsgBoxClass.FetchStdButton PROCEDURE(SHORT Feq)
i LONG,AUTO
  CODE

  LOOP i = BaseButtonFeq TO BaseButtonFeq + SELF.MsgButtons - 1
    IF Feq = i
      RETURN SELF.MsgButtonID[i - BaseButtonFeq + 1]
    END
  END
  RETURN 0


MsgBoxClass.TakeAccepted PROCEDURE

RVal  BYTE,AUTO
i     LONG,AUTO

  CODE
  RVal = PARENT.TakeAccepted()
  IF RVal = Level:Benign

    i = SELF.FetchStdButton(ACCEPTED())
    IF i
      SELF.MsgRVal = i
      RETURN Level:Fatal
    END
  END

  RETURN RVal


MsgBoxClass.SetupAdditionalFeqs PROCEDURE
  CODE

  IF SELF.Icon = 0
     ImageFeq{PROP:Text} = ICON:Exclamation
  ELSE
     ImageFeq{PROP:Text} = SELF.Icon
  END
!  ImageFeq{PROP:Text} = CHOOSE(SELF.Icon=0, ICON:Exclamation, SELF.Icon) this doesn't work?



HistHandlerClass.Init PROCEDURE(WINDOW Win, ErrorClass Err, ErrorHistoryList History)
  CODE

  SELF.Win &= Win
  SELF.Err &= Err
  SELF.History &= History


HistHandlerClass.TakeEvent PROCEDURE
  CODE

  CASE EVENT()
  OF EVENT:OpenWindow
    ListFeq{PROP:Selected} = RECORDS(SELF.History)

    LOOP I#=1 TO 100 ! How else can I generically count columns? 100=high #
      IF SELF.Win $ ListFeq{PROPLIST:Width, I#}=''
        BREAK
      END
    END
    ASSERT(I#<>100)
    SELF.LBColumns=I#
    SELF.Win $ ListFeq{PROP:VLBVal} = ADDRESS(SELF)
    SELF.Win $ ListFeq{PROP:VLBProc} = ADDRESS(SELF._VLBProc)
  END
  RETURN Level:Benign


HistHandlerClass._VLBProc PROCEDURE(LONG RowNum, SHORT ColNum)
  CODE

  RETURN SELF.VLBProc(RowNum, ColNum)


HistHandlerClass.VLBProc PROCEDURE(LONG RowNum, SHORT ColNum)
  CODE

  CASE RowNum
  OF -1                                                     ! How many rows
    RETURN RECORDS(SELF.History)
  OF -2                                                     ! How many cols
    RETURN SELF.LBColumns
  OF -3
    RETURN True
  ELSE
    GET(SELF.History, RowNum)
?   ASSERT(~ERRORCODE())
    CASE ColNum
    OF 1
      RETURN SELF.History.Txt
    OF 2
      RETURN SELF.History.Category
    END
  END
  RETURN ''


HistHandlerClass.WindowComponent.Kill PROCEDURE
  CODE


HistHandlerClass.WindowComponent.Reset PROCEDURE(BYTE Force)
  CODE


HistHandlerClass.WindowComponent.ResetRequired PROCEDURE
  CODE
  
  RETURN False


HistHandlerClass.WindowComponent.SetAlerts PROCEDURE
  CODE


HistHandlerClass.WindowComponent.TakeEvent PROCEDURE
  CODE

  RETURN SELF.TakeEvent()


HistHandlerClass.WindowComponent.Update PROCEDURE
  CODE


HistHandlerClass.WindowComponent.UpdateWindow PROCEDURE
  CODE

  DISPLAY(ListFeq)


! The routine replaces instances of 'find' with 'replace' in 'into'
Replace       PROCEDURE(string find,string replace,*cstring into)
Locate LONG,AUTO
  CODE
    LOOP
      Locate = INSTRING(UPPER(find),UPPER(into),1,1)
      IF ~Locate THEN RETURN .
      into = SUB(into,1,Locate-1) & replace & SUB(into,Locate+LEN(find),LEN(into))
    END


StandardErrorLogClass.Construct PROCEDURE

  CODE
  SELF.Usage = 0


StandardErrorLogClass.Destruct PROCEDURE

  CODE
  SELF.Close(True)


StandardErrorLogClass.Open PROCEDURE(BYTE Force)

  CODE
  IF ~SELF.Usage OR Force                       !Allows nested 'opens' should the need arise
    IF ~EXISTS(NAME(StdErrorFile))
      CREATE(StdErrorFile)
      IF ERRORCODE() THEN RETURN Level:Notify.
    END
    OPEN(StdErrorFile, 42h)                     !Read/write deny none
    IF ERRORCODE() THEN RETURN Level:Notify.
  END
  SELF.Usage += 1
  RETURN Level:Benign


StandardErrorLogClass.Close PROCEDURE(BYTE Force)

  CODE
  IF SELF.Usage = 1 OR Force
    DESTROY(StdErrorFile)
    IF ERRORCODE() THEN RETURN Level:Notify.
    SELF.Usage = 1
  END
  SELF.Usage -= 1
  RETURN Level:Benign


StandardErrorLogClass.ErrorLogInterface.Open PROCEDURE(BYTE Force)

  CODE
  RETURN SELF.Open(Force)


StandardErrorLogClass.ErrorLogInterface.Close PROCEDURE(BYTE Force)

  CODE
  RETURN SELF.Close(Force)


StandardErrorLogClass.ErrorLogInterface.Take PROCEDURE(STRING Txt)

  CODE
  IF SELF.Usage
    StdErrorFile.Txt = Txt
    ADD(StdErrorFile)
    RETURN CHOOSE(ERRORCODE() = 0, Level:Benign, Level:Notify)
  END
  RETURN Level:Notify

