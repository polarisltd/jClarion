! Data Send Transports and document handling.
  MEMBER

WORD       EQUATE(USHORT)
DWORD      EQUATE(LONG)

SYSTEMTIME   GROUP,TYPE
wYear          WORD
wMonth         WORD
wDayOfWeek     WORD
wDay           WORD
wHour          WORD
wMinute        WORD
wSecond        WORD
wMilliSecond   WORD
             END

TimeZoneInfo GROUP,TYPE
Bias           LONG
StandardName   USHORT,DIM(32)
StandardDate   LIKE(SYSTEMTIME)
StandardBias   LONG
DayLightName   USHORT,DIM(32)
DayLightDate   LIKE(SYSTEMTIME)
DayLightBias   LONG
             END


  MAP
    SortByParameter(*RecipientQueue Recipients, STRING Parametername)
    MoveParameterToFront(STRING ConnectString, STRING Parametername),STRING
    GetParameter(STRING ParamString, STRING ParamName, BYTE CaseLess=0),STRING
    MakeDateHeader(),STRING
    MODULE('CLA')
     BString2String(LONG, LONG, BOOL),NAME('Cla$BString2String')
    END
    MODULE('kernel32')
     GetTimeZoneInformation(*TimeZoneInfo),LONG,PROC,RAW,PASCAL,NAME('GetTimeZoneInformation')
    END
  END

  INCLUDE('ERRORS.CLW'),ONCE
  INCLUDE('KEYCODES.CLW'),ONCE
  INCLUDE('ABWINDOW.INC'),ONCE
  INCLUDE('ABMIME.INC'),ONCE
  INCLUDE('ABDST.INC'),ONCE
  INCLUDE('ABDST.TRN'),ONCE
  INCLUDE('ABERROR.INC'),ONCE

  COMPILE ('=== DO LINK', _MAILinkMode_)
    PRAGMA ('link (adr1.ico)')
! === DO LINK

TELNETWinsock  CLASS(Winsock)
               END

DSTQueue QUEUE,TYPE
DST               &IDST
Name              CSTRING(20)
                  END

SettingsQueue QUEUE,TYPE
ID                SIGNED
Addresses         &IABook
              END

Window      WINDOW('Winsock Window'),AT(,,260,34),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI), |
             GRAY,DOUBLE
            END

DocumentHandler.AddDST           PROCEDURE(IDST IDSTransport, STRING TransportName)
 CODE
 SELF.DSTList.DST &= IDSTransport
 SELF.DSTList.Name = TransportName
 ADD(SELF.DSTList,SELF.DSTList.Name)

DocumentHandler.Init             PROCEDURE(ErrorClass ErrorHandler)
 CODE
 SELF.DSTList   &= NEW(DSTQueue)
 PARENT.Init(ErrorHandler)

DocumentHandler.Kill             PROCEDURE
 CODE
 FREE(SELF.DSTList)
 DISPOSE(SELF.DSTList)
 PARENT.Kill()

DocumentHandler.Send             PROCEDURE
T    USHORT,AUTO
RVAL BYTE
 CODE
 ASSERT(RECORDS(SELF.DSTList),'No Registered Data Send Transports?')
 ! Pass Attachments
 LOOP T = 1 TO RECORDS(SELF.DSTList)
  GET(SELF.DSTList,T)
  SELF.DSTList.DST.SetAttachments(SELF.Attachments) ! Could possibly do this once elsewhere.
 END
 ! Trigger Transports to send
 LOOP T = 1 TO RECORDS(SELF.DSTList)
  GET(SELF.DSTList,T)
  SELF.DSTList.DST.SetDescription(SELF.Description)
  IF SELF.DSTList.DST.Send(SELF) = Level:Notify
     RVAL = Level:Notify
  END
 END
 RETURN RVAL


AdrMgr.AddRecipient               PROCEDURE(STRING Address, <STRING Name>, STRING Type, STRING TransportName, <STRING ConnectParameters>) ! Transport name = 'SMTP' etc..
 CODE
 ASSERT(~SELF.Recipients &= NULL,'Init the Address Manager First before AddRecipient.')
 CLEAR(SELF.Recipients)
 SELF.Recipients.Address = Address
 IF ~OMITTED(3)
    SELF.Recipients.Name = Name
 END
 SELF.Recipients.Name_Icon = 1
 SELF.Recipients.Type = Type
 SELF.Recipients.TransportName = TransportName
 SELF.Recipients.ConnectString = ConnectParameters
 GET(SELF.Recipients,+SELF.Recipients.TransportName,+SELF.Recipients.Address,+SELF.Recipients.Name)
 IF ERRORCODE()
    ADD(SELF.Recipients)
 END

AdrMgr.AddRecipients               PROCEDURE(*IABook Addresses)
Recipients &RecipientQueue
I USHORT,AUTO
 CODE
 Recipients &= Addresses.GetRecipients()
 LOOP I = 1 TO RECORDS(Recipients)
  GET(Recipients,I)
  SELF.Recipients = Recipients
  GET(SELF.Recipients,+SELF.Recipients.TransportName,+SELF.Recipients.Address,+SELF.Recipients.Name)
  IF ERRORCODE()
     SELF.Recipients = Recipients
     ADD(SELF.Recipients)
  END
 END

AdrMgr.FreeRecipients             PROCEDURE
 CODE
 FREE(SELF.Recipients)

AdrMgr.GetIABook                  PROCEDURE
 CODE
 RETURN SELF.IABook

AdrMgr.Init                       PROCEDURE(INIClass INIMgr, STRING Family)
 CODE
 SELF.Recipients &= NEW(RecipientQueue)
 SELF.INIMgr &= INIMgr
 SELF.Family = Family

AdrMgr.Kill                       PROCEDURE
 CODE
 FREE(SELF.Recipients)
 DISPOSE(SELF.Recipients)

AdrMgr.Restore                    PROCEDURE
SQ QUEUE
Address           ASTRING
Name              ASTRING
SaveString        ASTRING
   END
I  USHORT,AUTO
S  USHORT,AUTO
 CODE
 SELF.INIMgr.FetchQueue('Addresses',SELF.Family,SQ, SQ.Address, SQ.Name, SQ.SaveString)
 LOOP I = 1 TO RECORDS(SQ)
  GET(SQ,I)
  CLEAR(SELF.Recipients)
  SELF.Recipients.Name = SQ.Name
  SELF.Recipients.Name_Icon = 1
  S = INSTRING('$',SQ.Address,1,1)
  SELF.Recipients.Type = CHOOSE(S=0,SendTo,SUB(SQ.Address,1,S-1))
  SELF.Recipients.Address = CHOOSE(S=0,SQ.Address,SUB(SQ.Address,S+1,S+1-LEN(SQ.Address)))
  S = INSTRING('$',SQ.SaveString,1,1)
  SELF.Recipients.TransportName = CHOOSE(S=0,SMTP,SUB(SQ.SaveString,1,S-1))
  SELF.Recipients.ConnectString = CHOOSE(S=0,SQ.Savestring,SUB(SQ.SaveString,S+1,S+1-LEN(SQ.SaveString)))
  GET(SELF.Recipients,+SELF.Recipients.TransportName,+SELF.Recipients.Address,+SELF.Recipients.Name)
  IF ERRORCODE()
     ADD(SELF.Recipients)
  END
 END

AdrMgr.Save                       PROCEDURE
SQ QUEUE
Address           ASTRING
Name              ASTRING
SaveString        ASTRING
   END
I  USHORT,AUTO
 CODE
 LOOP I = 1 TO RECORDS(SELF.Recipients)
  GET(SELF.Recipients,I)
  SQ.Address = SELF.Recipients.Type & '$' & SELF.Recipients.Address
  SQ.Name    = SELF.Recipients.Name
  SQ.SaveString = CLIP(SELF.Recipients.TransportName) & '$' & SELF.Recipients.ConnectString
  ADD(SQ)
 END
 SELF.INIMgr.UpdateQueue('Addresses',SELF.Family,SQ, SQ.Address, SQ.Name, SQ.SaveString)
 FREE(SQ)

AdrMgr.IABook.GetRecipients       PROCEDURE
 CODE
 RETURN SELF.Recipients


TELNETTransport.Connect           PROCEDURE(STRING ServerName, SHORT Port=0)
NewServer &CSTRING
NewPort   SHORT,AUTO
nErr      SIGNED
rVal     BYTE

WaitWindow WINDOW('WaitWindow'),AT(,,260,100),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI),GRAY
       STRING('Waiting for Winsock Response...'),AT(14,6),USE(?String1)
     END

 CODE
 SELF.Winsock &= NEW(Winsock)
 ASSERT(~SELF.Winsock.InitWinsock(),'Winsock failed to init.')

 rVal = Level:Benign
 NewPort = CHOOSE(Port>0,Port,SELF.DefaultPort)
 IF UPPER(ServerName) = 'DEFAULT'
    NewServer &= NEW (CSTRING(LEN(SELF.DefaultServer)+1))
    NewServer = SELF.DefaultServer
 ELSE
    NewServer &= NEW (CSTRING(LEN(ServerName)+1))
    NewServer = ServerName
 END
 SELF.Socket &= SELF.ProtocolGen.CreateProtocol(,,, NewServer, NewPort, nErr)
 IF SELF.Socket &= NULL
    SELF.Errors.ThrowMessage(Msg:WinsockError, 'Error Creating Protocol ' & NewServer & ' Socket: ' & NewPort & ' nErr: ' & nErr)
    RVal = Level:Notify
 ELSE
    IF nErr AND nErr <> 1 AND nErr <> WSAEWOULDBLOCK AND RVal <> Level:Notify
       SELF.Errors.ThrowMessage(Msg:WinsockError, 'Error Creating Socket ' & SELF.DefaultServer & ' Socket: ' & NewPort & ' Error: ' & nErr)
       rVal = Level:Notify
    ELSE
       IF nErr = WSAEWOULDBLOCK
          OPEN(WaitWindow)
          WaitWindow{Prop:Text} = 'Waiting for connect...'
          SELF.Window{Prop:Hide} = True
          ACCEPT
           CASE EVENT()
           OF Msg:Connected
              POST(EVENT:CloseWindow)
           OF Msg:ErrorConnecting
              SELF.Errors.ThrowMessage(Msg:WinsockError, 'Error Connecting ' & SELF.DefaultServer & ' Socket: ' & NewPort & ' Error: ' & nErr)
              RVal = Level:Notify
              POST(EVENT:CloseWindow)
           OF Msg:DataReady
              POST(EVENT:CloseWindow)
           OF Msg:LastWriteCompleted
              POST(EVENT:CloseWindow)
           END
          END
          CLOSE(WaitWindow)
       END
       SELF.IConnectionInt &= SELF.WinSock.Connect(THREAD(), NewPort, NewServer, SELF.Socket, nErr)
       IF SELF.IConnectionInt &= NULL
        SELF.Errors.ThrowMessage(Msg:WinsockError, 'Error Connecting to ' & ServerName)
        rVal = Level:Notify
       END
       IF nErr AND nErr <> 1 AND nErr <> WSAEWOULDBLOCK
        SELF.Errors.ThrowMessage(Msg:WinsockError, 'Connecting to ' & ServerName & ' ' & nErr)
        rVal = Level:Notify
       END
    END
 END
 DISPOSE(NewServer)
 RETURN rVal

TELNETTransport.GetRecipients     PROCEDURE
 CODE
 SELF.Settings.ID = THREAD()
 GET(SELF.Settings,SELF.Settings.ID)
 IF ERRORCODE()
    RETURN SELF.Addresses.GetRecipients()
 ELSE
    RETURN SELF.Settings.Addresses.GetRecipients()
 END

TELNETTransport.GetResponse       PROCEDURE(STRING SendString, STRING ExpectedResponse, *ASTRING Response)
r    &STRING
rval BYTE
 CODE
 IF ~SELF.Winsock.IsDataReady()
  OPEN(SELF.Window)
  SELF.Window{Prop:Text} = 'Waiting for response: ' & SELF.StringToSend
  SELF.Window{Prop:Hide} = True
  ACCEPT
   CASE EVENT()
   OF EVENT:OpenWindow
      IF SendString
         SELF.StringToSend &= SendString
         IF SELF.SendString(SELF.StringToSend).
      ELSE
         SELF.StringToSend &= NULL
      END
   OF EVENT:Timer
      IF 0{Prop:Timer} <> SELF.Timeout
         0{Prop:Timer} = SELF.Timeout
      ELSE
         POST(Event:CloseWindow)
      END
   OF Msg:DataReady
      POST(EVENT:CloseWindow)
   END
  END
  CLOSE(SELF.Window)
 END
 CLEAR(SELF.ErrorResponse)
 IF SELF.Winsock.IsDataReady()
   R &= NEW(STRING(SELF.Winsock.GetNextResponseSize(SELF.IConnectionInt)))
   SELF.Winsock.GetNextResponse(SELF.IConnectionInt, R)
   Response = R
   DISPOSE(R)
   IF LEN(Response) > LEN(ExpectedResponse)
      IF Response[1:Len(ExpectedResponse)] <> ExpectedResponse
         SELF.TakeResponse(Response)
         SELF.ErrorResponse = Response
         rval = Level:Notify
      ELSE
         SELF.TakeResponse(Response)
      END
   ELSE
      SELF.TakeResponse(Response)
      SELF.ErrorResponse = Response
      rval = Level:Notify
   END
 ELSE
   SELF.TakeResponse(Response)
   SELF.ErrorResponse = Response
   SELF.Errors.ThrowMessage(Msg:WinsockError, 'Incorrect response, expected: ' & ExpectedResponse & ' -> Response:' & Response)
   rval = Level:Notify
 END
!! TC 10/9/03 - Certain Mail Servers are "duplicating" the response to EHLO
 IF SELF.Winsock.IsDataReady()
   R &= NEW(STRING(SELF.Winsock.GetNextResponseSize(SELF.IConnectionInt)))
   SELF.Winsock.GetNextResponse(SELF.IConnectionInt, R)
   DISPOSE( r )
 END
!! TC 10/9/03 - Certain Mail Servers are "duplicating" the response to EHLO
 RETURN rval

TELNETTransport.TakeResponse      PROCEDURE(*ASTRING Response)
 CODE
 COMPILE('***',DEBUG=1)
 IF SELF.ErrorResponse
    Message('Incorrect Response: ' & Response,'Winsock Reply')
 ELSE
    IF NOT Response
       Message('Timeout waiting for reply: ' & Response,'Winsock Reply')
    ELSE
       Message('Reply: ' & Response,'Winsock Reply')
    END
 END
 !***
 RETURN

TELNETTransport.SendString        PROCEDURE(*STRING SendString)
nErr        SIGNED
BytesSent   LONG
TotalBytesSent LONG
BytesToSend &STRING
rVal        BYTE

WaitWindow WINDOW('WaitWindow'),AT(,,260,100),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI),GRAY
       STRING('Waiting for Winsock Response...'),AT(14,6),USE(?String1)
     END

 CODE
 rVal = Level:Benign
 COMPILE('***',DEBUG=1)
 Message('Sending:' & SendString,'TELNET Send')
 !***
 BytesToSend &= NEW(STRING(LEN(CLIP(SendString))))

 BytesToSend = SendString
 LOOP
  nErr = SELF.Winsock.SendData(SELF.IConnectionInt, BytesToSend, BytesSent) ! Error
  DISPOSE(BytesToSend)
  IF nErr AND nErr <> 1
     IF nErr = WSAEWOULDBLOCK

        OPEN(WaitWindow)
        WaitWindow{Prop:Text} = 'Data Send, waiting for block to clear.'
        WaitWindow{Prop:Hide} = True
        WaitWindow{Prop:Timer} = SELF.Timeout
        ACCEPT
         CASE EVENT()
         OF EVENT:Timer
            POST(EVENT:CloseWindow)
         OF Msg:LastWriteCompleted
            POST(EVENT:CloseWindow)
         END
        END
        CLOSE(WaitWindow)

        IF BytesSent < LEN(SendString)-TotalBytesSent+1
           TotalBytesSent += BytesSent ! must be after the condition.
           BytesToSend &= NEW(STRING(LEN(SendString)-TotalBytesSent+1))
           BytesToSend =  SendString[TotalBytesSent+1 : LEN(SendString)]
           CYCLE
        END
     ELSE
        rVal = Level:Notify
        SELF.Errors.ThrowMessage(Msg:WinsockError, 'Error Sending Data: ' & nErr)
     END
  END
  BREAK
 END
 RETURN rVal

TELNETTransport.SetIAB              PROCEDURE(*IABook Addresses)
 CODE
 SELF.Settings.ID = THREAD()
 GET(SELF.Settings,SELF.Settings.ID)
 IF NOT ERRORCODE()
    DELETE(SELF.Settings)
 END
 SELF.Settings.ID = THREAD()
 SELF.Settings.Addresses &= Addresses
 ADD(SELF.Settings,SELF.Settings.ID)

TELNETTransport.RemoveIAB              PROCEDURE()
 CODE
 SELF.Settings.ID = THREAD()
 GET(SELF.Settings,SELF.Settings.ID)
 IF NOT ERRORCODE()
    DELETE(SELF.Settings)
 END

TELNETTransport.Disconnect        PROCEDURE
nErr        SIGNED
CloseWindow WINDOW('Close Socket Window'),AT(,,260,100),GRAY
     END

 CODE
 IF ~SELF.Winsock &= NULL
    OPEN(CloseWindow)
    CloseWindow{Prop:Text} = 'Socket Close'
    CloseWindow{Prop:Hide} = True
    ACCEPT
     CASE EVENT()
     OF EVENT:OpenWindow
      nErr = SELF.Winsock.Disconnect(SELF.IConnectionInt)
      IF nErr = NO_ERROR
         POST(EVENT:CloseWindow)
      END
     OF   Msg:ConnectionLost
     OROF Msg:SocketClosed
      POST(Event:CloseWindow)
     END
    END
    CLOSE(CloseWindow)
    DISPOSE(SELF.Winsock)
    SELF.Winsock &= NULL
 END

TELNETTransport.Init              PROCEDURE(ErrorClass Errors)

 CODE
 SELF.Errors &= Errors

 SELF.ProtocolGen &= NEW(CProtocolGenerator)
 SELF.ProtocolGen.Init()

 SELF.Settings &= NEW(SettingsQueue)
 SELF.Window &= Window

TELNETTransport.Kill              PROCEDURE
 CODE
 DISPOSE(SELF.ProtocolGen)
 FREE(SELF.Settings)
 DISPOSE(SELF.Settings)
 SELF.Window &= NULL

SMTPTransport.Init                PROCEDURE(IABook Addresses, ErrorClass Errors)
 CODE
 SELF.Headers &= NEW(HeaderQueue)
 SELF.Addresses &= Addresses
 SELF.ReplyTo &= NEW(RecipientQueue)
 SELF.DefaultPort = 25 ! Default SMTP Port.
 SELF.Sender = 'Default' ! Need to specify a valid sender (or not, for a spammer).
 PARENT.Init(Errors)

SMTPTransport.Kill                PROCEDURE
 CODE
 FREE(SELF.Headers)
 DISPOSE(SELF.Headers)
 FREE(SELF.ReplyTo)
 DISPOSE(SELF.ReplyTo)
 PARENT.Kill()

SMTPTransport.AddReplyTo          PROCEDURE(STRING Address, <STRING Name>)
 CODE
 ASSERT(~SELF.ReplyTo&=NULL,'No ReplyTo Queue in SMTP Transport. Init Transport first?')
 CLEAR(SELF.ReplyTo)
 SELF.ReplyTo.Address = Address
 IF ~OMITTED(3)
    SELF.ReplyTo.Name = Name
 END
 ADD(SELF.ReplyTo)

SMTPTransport.Connect             PROCEDURE(STRING ServerName, SHORT Port=0)
RVAL       BYTE
Response   ASTRING
SendString ASTRING
textEncode  &Base64FileMgr
sOut      &STRING
ret       BYTE
 CODE
 IF PARENT.Connect(ServerName, Port)
    RETURN Level:Notify
 END
 IF SELF.GetResponse('','220',Response)
    SELF.Errors.ThrowMessage(Msg:SMTPError, 'Connect Error ' & CHOOSE(UPPER(ServerName)='DEFAULT',SELF.DefaultServer,ServerName) & '-> Response:' & Response)
    SELF.Disconnect() ! Close the socket etc...
    RETURN Level:Notify
 END

 IF INSTRING('ESMTP',UPPER(Response),1,1)
   SendString = 'EHLO ' & SELF.SenderDomain & CRLF
 ELSE
   SendString = 'HELO ' & SELF.SenderDomain & CRLF
 END
 IF SELF.GetResponse(SendString,'250',Response)
   SELF.Errors.ThrowMessage(Msg:SMTPError, 'HELO Error -> Response:' & Response)
   SELF.Disconnect() ! Close the socket etc...
   RETURN Level:Notify
 END

 IF INSTRING('AUTH ', UPPER( Response ), 1, 1 ) AND SELF.AuthUser <> ''
   textEnCode &= NEW Base64FileMgr

   SendString = 'AUTH LOGIN' & CRLF
   IF SELF.GetResponse(SendString,'334',Response)
      SELF.Errors.ThrowMessage(MSG:SMTPError, 'AUTH LOGIN Error -> Response:' & Response)
      SELF.Disconnect()
      RETURN Level:Notify
   END
   sOut &= NEW( STRING( 1024 ) )
   ret = textEncode.ToBase64( SELF.AuthUser, sOut)
   SendString = CLIP( sOut )  & CRLF
   IF SELF.GetResponse(SendString,'334',Response)
      SELF.Errors.ThrowMessage(MSG:SMTPError, 'Login User Name Error -> Response:' & Response)
      SELF.Disconnect()
      DISPOSE( sOut )
      RETURN Level:Notify
   END

   CLEAR( sOut )
   ret = textEncode.ToBase64( SELF.AuthPass, sOut )
   SendString = CLIP( sOut )  & CRLF
   IF SELF.GetResponse(SendString,'235',Response)
      SELF.Errors.ThrowMessage(MSG:SMTPError, 'Login Password Error -> Response:' & Response)
      SELF.Disconnect()
      DISPOSE( sOut )
      RETURN Level:Notify
   END
   DISPOSE( sOut )
   DISPOSE( textEnCode )
 END
!here
 CLEAR( Response )
 SendString = 'MAIL FROM: <' & CLIP(SELF.Sender) & '>' & CRLF
 IF SELF.GetResponse(SendString, '250', Response)
    SELF.Errors.ThrowMessage(Msg:SMTPError, 'MAIL FROM -> Response:' & Response)
    SELF.Disconnect() ! Close the socket etc...
    RETURN Level:Notify
 END
 RETURN RVAL

SMTPTransport.SendRecipients      PROCEDURE(STRING ServerName)
R USHORT,AUTO
S USHORT,AUTO
RVAL BYTE
Response   ASTRING
SendString STRING(100)
 CODE
 S = POINTER(SELF.Recipients)
 LOOP R = S TO RECORDS(SELF.Recipients)
  GET(SELF.Recipients,R)
  IF SELF.Recipients.TransportName <> SMTP THEN BREAK.
  IF GetParameter(SELF.Recipients.ConnectString, 'SERVER') <> UPPER(ServerName) THEN BREAK.
  SendString = 'RCPT TO: <<' & CLIP(SELF.Recipients.Address) & '>' & CRLF
  IF SELF.GetResponse(SendString, '250',Response)
     SELF.Errors.ThrowMessage(Msg:SMTPError, 'RCPT TO: -> Response:' & Response)
     SELF.Recipients.ErrorString = SELF.ErrorResponse
     PUT(SELF.Recipients)
  END
 END
 GET(SELF.Recipients,S)
 RETURN RVAL

SMTPTransport.SendBody            PROCEDURE
 CODE
 ASSERT(~(SELF.MD &= NULL),'No MIME Document to output.')
 SELF.MD.PutData(SELF.IMIMETarget)

SMTPTransport.SendTo              PROCEDURE(STRING ServerName)
R USHORT,AUTO
S USHORT,AUTO
SendString STRING(100)
Type       STRING(50)
 CODE
 CLEAR(SendString)
 S = POINTER(SELF.Recipients)
 LOOP R = S TO RECORDS(SELF.Recipients)
  GET(SELF.Recipients,R)
  IF SELF.Recipients.TransportName <> SMTP THEN BREAK.
  IF GetParameter(SELF.Recipients.ConnectString, 'SERVER') <> UPPER(ServerName) THEN BREAK.
  IF UPPER(CLIP(SELF.Recipients.Type)) <> UPPER(Type)
     IF Type
        SendString = CRLF
     END
     Type = SELF.Recipients.Type
     CASE Type
     OF CC
        SendString = CLIP(SendString) & 'CC: '
     OF BCC
        SendString = CLIP(SendString) & 'BCC: '
        IF SELF.SendString(SendString).
        CYCLE ! only do once.
     ELSE
        SendString = CLIP(SendString) & 'To: '
     END
  ELSE
     IF SELF.Recipients.Type <> BCC
        SendString = CHOOSE(R>S,',','')
     END
  END
  IF SELF.Recipients.Type <> BCC
   IF SELF.Recipients.Name
      SendString = CLIP(SendString) & ' "' & CLIP(SELF.Recipients.Name) & '" <<' & CLIP(SELF.Recipients.Address) & '>'
   ELSE
      SendString = CLIP(SendString) & ' <<' & CLIP(SELF.Recipients.Address) & '>'
   END
   IF SELF.SendString(SendString).
  END
 END
 IF SendString ! IF it's clear then only BCCs exist.
    SendString = CRLF
 END
 IF SendString
    IF SELF.SendString(SendString).
 END
 GET(SELF.Recipients,S)

SMTPTransport.SendData            PROCEDURE(STRING ServerName)
RVAL BYTE
Response   ASTRING
SendString &STRING
R          USHORT

 CODE
  SendString &= NEW(STRING(6))
  SendString = 'DATA' & CRLF
  IF SELF.GetResponse(SendString, '354', Response)
     SELF.Errors.ThrowMessage(Msg:SMTPError, 'DATA command -> Response:' & Response)
     DISPOSE(SendString)
     RETURN Level:Notify
  END
  DISPOSE(SendString)
  SELF.SendTo(ServerName)

  SendString &= NEW(STRING(LEN(CLIP(SELF.From)) + 8))
  SendString = 'From: ' & CLIP(SELF.From) & CRLF
  IF SELF.SendString(SendString).
  DISPOSE(SendString)

  IF RECORDS(SELF.ReplyTo)
   SendString &= NEW(STRING(300))
   SendString = 'Reply-to: '
   IF SELF.SendString(SendString).
   LOOP R = 1 TO RECORDS(SELF.ReplyTo)
    GET(SELF.ReplyTo,R)
    SendString = CHOOSE(R>1,',','')
    IF SELF.ReplyTo.Name
       SendString = CLIP(SendString) & '"' & SELF.ReplyTo.Name & '"' & '<<' & SELF.ReplyTo.Address & '>'
    ELSE
       SendString = CLIP(SendString) & '<' & SELF.ReplyTo.Address & '>'
    END
    IF SELF.SendString(SendString).
   END
   SendString = CRLF
   IF SELF.SendString(SendString).
   DISPOSE(SendString)
  END

  SendString &= NEW(STRING(LEN(CLIP(SELF.Subject))+11))
  SendString = 'Subject: ' & CLIP(SELF.Subject) & CRLF
  IF SELF.SendString(SendString).
  DISPOSE(SendString)

  SendString &= NEW STRING (64)
  SendString  = MakeDateHeader()
  IF SELF.SendString (SendString).
  DISPOSE (SendString)

  SELF.SendUserHeaders()

  SELF.SendBody()

  SendString &= NEW(STRING(5))
  SendString = CRLF & '.' & CRLF ! End Message Data Double CRLF in case the previous Send omits to put one in.
  IF SELF.GetResponse(SendString, '250', Response)
     SELF.Errors.ThrowMessage(Msg:SMTPError, 'Save message -> Response:' & Response)
     RVal = Level:Notify
  END
  DISPOSE(SendString)
  RETURN RVAL

SMTPTransport.SendUserHeaders   PROCEDURE()
SendString STRING(100)
I          USHORT,AUTO
  CODE
  ASSERT(~SELF.Headers&=NULL,'No Header Queue. No Init?')
  LOOP I=1 TO RECORDS(SELF.Headers)
   GET(SELF.Headers,I)
   SendString = CLIP(SELF.Headers.Header) & ': ' & CLIP(SELF.Headers.HeaderValue) & CRLF
   IF SELF.SendString(SendString).
  END

SMTPTransport.SetHeader         PROCEDURE(STRING Header, STRING HeaderValue)

  CODE
  ASSERT(~SELF.Headers&=NULL,'No HeaderQueue has been created, No init?')
  SELF.Headers.Header = Header
  GET(SELF.Headers,+SELF.Headers.Header)
  SELF.Headers.Header = Header
  SELF.Headers.HeaderValue = HeaderValue
  IF ERRORCODE()
     ADD(SELF.Headers)
  ELSE
     PUT(SELF.Headers)
  END

SMTPTransport.Disconnect          PROCEDURE
SendString STRING(6)
Response   ASTRING
 CODE
 SendString = 'QUIT' & CRLF
 IF SELF.GetResponse(SendString, '221',Response)
    SELF.Errors.ThrowMessage(Msg:SMTPError, 'QUIT -> Response:' & Response)
 END
 PARENT.Disconnect()
 RETURN

SMTPTransport.IDST.SetAttachments PROCEDURE(AttachmentQueue Attachments)
 CODE
 SELF.Attachments &= Attachments
 RETURN

SMTPTransport.IDST.SetDescription PROCEDURE(STRING Description)
 CODE
 SELF.Subject = Description
 RETURN

SMTPTransport.IDST.Send           PROCEDURE(MIMEDoc MD)
R    USHORT,AUTO
CurrentServer CSTRING(100)
CurrentPort   SHORT,AUTO
RVAL  BYTE
SRVAL BYTE

 CODE
 SELF.MD &= MD ! initialise MIME Document for SMTP.
 ! Parse Recipients and group by STMP Gateway, some might simply use the default gateway.
 SELF.Recipients &= SELF.GetRecipients()
 IF NOT RECORDS(SELF.Recipients) THEN RETURN Level:Benign.

 SortByParameter(SELF.Recipients,'SERVER')
 ! Per Recipient Per Server
 LOOP R = 1 TO RECORDS(SELF.Recipients)
  GET(SELF.Recipients,R)
  IF UPPER(SELF.Recipients.TransportName) < SMTP THEN CYCLE.
  IF UPPER(SELF.Recipients.TransportName) > SMTP THEN BREAK.

  IF UPPER(CurrentServer) <> GetParameter(SELF.Recipients.ConnectString, 'SERVER')
     CurrentServer = GetParameter(SELF.Recipients.ConnectString, 'SERVER',1)
     CurrentPort = GetParameter(SELF.Recipients.ConnectString, 'PORT',1)
     ! Send message to all recipients using the Current Server, increment R.
     IF SELF.Connect(CurrentServer, CurrentPort) = Level:Notify
        SRVAL = Level:Notify
        CYCLE
     END
     RVal = SELF.SendRecipients(CurrentServer)
     IF RVal = Level:Benign
        RVal = SELF.SendData(CurrentServer)
        IF RVal = Level:Notify
           SRVAL = Level:Notify
        END
     ELSE
        SRVAL = Level:Notify
     END
     SELF.Disconnect()
  END
 END
 SELF.Recipients &= NULL
 RETURN SRVAL

SMTPTransport.IDST.GetWindowControls PROCEDURE(*DSTControlQueue ControlList)
 CODE
 ControlList.Name = 'SERVER'
 ControlList.Prompt = '&Server:'
 ControlList.Picture = '@s80'
 ADD(ControlList)
 ControlList.Name = 'PORT'
 ControlList.Prompt = '&Port:'
 ControlList.Picture = '@s10'
 ADD(ControlList)

SMTPTransport.IMIMETarget.PutText PROCEDURE(STRING Text)
 CODE
 COMPILE('***',DEBUG=1)
 Message(Text,'SMTP Data Output') 
 !***

 IF SELF.SendString(Text).

NNTPTransport.Init                PROCEDURE(IABook Addresses, ErrorClass Errors)
 CODE
 SELF.Headers &= NEW(HeaderQueue)
 SELF.Addresses &= Addresses
 SELF.DefaultServer = '127.0.0.1'
 SELF.DefaultPort = 119 ! Default NNTP Port.
 SELF.BodyQueues &= NEW(NewsBodyQueues)
 PARENT.Init(Errors)

NNTPTransport.Kill                PROCEDURE
I LONG,AUTO
 CODE
 FREE(SELF.Headers)
 DISPOSE(SELF.Headers)
 I = 1
 IF ~(SELF.BodyQueues &= NULL)
  LOOP UNTIL I > RECORDS(SELF.BodyQueues)
   GET(SELF.BodyQueues,I)
   IF ~(SELF.BodyQueues.NBQ &= NULL)
      FREE(SELF.BodyQueues.NBQ)
      DISPOSE(SELF.BodyQueues.NBQ)
      SELF.BodyQueues.NBQ &= NULL
   END
   DELETE(SELF.BodyQueues)
  END
  DISPOSE(SELF.BodyQueues)
 END
 PARENT.Kill()


NNTPTransport.IDST.SetAttachments PROCEDURE(AttachmentQueue Attachments)
 CODE
 SELF.Attachments &= Attachments
 RETURN

NNTPTransport.IDST.SetDescription PROCEDURE(STRING Description)
 CODE
 SELF.Subject = Description
 RETURN

NNTPTransport.Connect           PROCEDURE(STRING ServerName, STRING User, STRING Password, SHORT Port=0)
RVAL       BYTE
Response   ASTRING
SendString ASTRING
Usr        CSTRING(30)
Pswd       CSTRING(30)

 CODE
 IF PARENT.Connect(ServerName, Port)
    RETURN Level:Notify
 END
 IF SELF.GetResponse('','2',Response)
    SELF.Errors.ThrowMessage(Msg:NNTPError, 'Connect Error ' & CHOOSE(UPPER(ServerName)='DEFAULT',SELF.DefaultServer,ServerName) & '-> Response:' & Response)
    SELF.Disconnect() ! Close the successful socket connect.
    RETURN Level:Notify
 END
 IF User
    Usr = User
    Pswd = Password
 ELSIF SELF.User AND (SELF.DefaultServer = ServerName OR ServerName = 'DEFAULT')
    Usr = SELF.User
    Pswd = SELF.Password
 END
 IF Usr
    SendString = 'authinfo USER ' & Usr & CRLF
    IF SELF.GetResponse(SendString,'3',Response)
       SELF.Errors.ThrowMessage(Msg:NNTPError, CHOOSE(UPPER(ServerName)='DEFAULT',SELF.DefaultServer,ServerName) & ' UserName Error (' & Usr &') -> Response:' & Response)
       SELF.Disconnect() ! Close the successful socket connect.
       RETURN Level:Notify
    END
    SendString = 'authinfo PASS ' & Pswd & CRLF
    IF SELF.GetResponse(SendString,'2',Response)
       SELF.Errors.ThrowMessage(Msg:NNTPError, CHOOSE(UPPER(ServerName)='DEFAULT',SELF.DefaultServer,ServerName) & ' Password Error (' & Usr &') -> Response:' & Response)
       SELF.Disconnect() ! Close the successful socket connect.
       RETURN Level:Notify
    END
 END
 RETURN RVAL

NNTPTransport.Disconnect        PROCEDURE
SendString STRING(100)
Response   ASTRING

 CODE
 SendString = 'QUIT' & CRLF
 IF SELF.GetResponse(SendString, '2',Response)
    SELF.Errors.ThrowMessage(Msg:NNTPError, 'QUIT Error -> Response:' & Response)
 END
 PARENT.Disconnect()
 RETURN

NNTPTransport.SendBody          PROCEDURE
SendString &STRING
Response   ASTRING
I SHORT,AUTO
 CODE
 ASSERT(~(SELF.MD &= NULL),'No MIME Document to output.')
 ASSERT(~SELF.BodyQueues &= NULL,'No Body Thread Queue')
 SELF.BodyQueues.Id = THREAD()
 GET(SELF.BodyQueues,+SELF.BodyQueues.Id)
 IF ERRORCODE()
    SELF.BodyQueues.Id = THREAD()
    SELF.BodyQueues.NBQ &= NEW(NewsBodyQueue)
    ADD(SELF.BodyQueues)
 END
 SELF.MD.PutData(SELF.IMIMETarget)

 SendString &= NEW(STRING(LEN(RECORDS(SELF.BodyQueues.NBQ)) + 7))
 SendString = 'Lines: ' & RECORDS(SELF.BodyQueues.NBQ)
 IF SELF.SendString(SendString).
 DISPOSE(SendString)

 SendString &= NEW(STRING(2))
 SendString = CRLF ! Send Blank Line before Body
 IF SELF.SendString(SendString).
 DISPOSE(SendString)

 SELF.BodyQueues.Id = THREAD()
 GET(SELF.BodyQueues,+SELF.BodyQueues.Id)
 LOOP I = 1 TO RECORDS(SELF.BodyQueues.NBQ)
  GET(SELF.BodyQueues.NBQ,I)
  SendString &= NEW(STRING(LEN(SELF.BodyQueues.NBQ.Line)))
  SendString = SELF.BodyQueues.NBQ.Line
  IF SELF.SendString(SendString).
  DISPOSE(SendString)
 END
 FREE(SELF.BodyQueues.NBQ)
 SELF.BodyQueues.NBQ &= NULL
 DELETE(SELF.BodyQueues)
 SendString &= NEW(STRING(5))
 SendString = CRLF & '.' & CRLF ! End Message Data Double CRLF in case the previous Send omits to put one in.
 IF SELF.GetResponse(SendString,'2',Response)
    SELF.Errors.ThrowMessage(Msg:NNTPError, 'Error saving posting -> Response:' & Response) ! for cross posting errors etc..
 END
 DISPOSE(SendString)


NNTPTransport.SendUserHeaders   PROCEDURE()
SendString STRING(100)
I          USHORT,AUTO
  CODE
  ASSERT(~SELF.Headers&=NULL,'No Header Queue. No Init?')
  LOOP I=1 TO RECORDS(SELF.Headers)
   GET(SELF.Headers,I)
   SendString = CLIP(SELF.Headers.Header) & ': ' & CLIP(SELF.Headers.HeaderValue) & CRLF
   IF SELF.SendString(SendString).
  END


NNTPTransport.SetHeader         PROCEDURE(STRING Header, STRING HeaderValue)

  CODE
  ASSERT(~SELF.Headers&=NULL,'No HeaderQueue has been created, No init?')
  SELF.Headers.Header = Header
  GET(SELF.Headers,+SELF.Headers.Header)
  SELF.Headers.Header = Header
  SELF.Headers.HeaderValue = HeaderValue
  IF ERRORCODE()
     ADD(SELF.Headers)
  ELSE
     PUT(SELF.Headers)
  END

NNTPTransport.IDST.Send           PROCEDURE(MIMEDoc MD)
R             USHORT,AUTO
CurrentServer CSTRING(100)
CurrentPort   SHORT,AUTO
RVAL          BYTE
SRVAL         BYTE
SendString    STRING(100)
Response      ASTRING
User          STRING(30)
Password      STRING(30)

 CODE
 SELF.MD &= MD ! initialise MIME Document for SMTP.
 ! Parse Recipients and group by STMP Gateway, some might simply use the default gateway.
 SELF.Recipients &= SELF.GetRecipients()
 IF NOT RECORDS(SELF.Recipients) THEN RETURN Level:Benign.

 SortByParameter(SELF.Recipients,'SERVER')
 ! Per Recipient Per Server
 LOOP R = 1 TO RECORDS(SELF.Recipients)
  GET(SELF.Recipients,R)
  IF UPPER(SELF.Recipients.TransportName) < NNTP THEN CYCLE.
  IF UPPER(SELF.Recipients.TransportName) > NNTP THEN BREAK.
  IF UPPER(CurrentServer) <> GetParameter(SELF.Recipients.ConnectString, 'SERVER')
     CurrentServer = GetParameter(SELF.Recipients.ConnectString, 'SERVER',1)
     CurrentPort = GetParameter(SELF.Recipients.ConnectString, 'PORT',1)
     ! Send message to all recipients using the Current Server, increment R.
     IF GetParameter(SELF.Recipients.ConnectString, 'USER',1)
        User = GetParameter(SELF.Recipients.ConnectString, 'USER',1)
        Password = GetParameter(SELF.Recipients.ConnectString, 'PASSWORD',1)
     ELSE
        User = ''
        Password = ''
     END
     IF SELF.Connect(CurrentServer, User, Password, CurrentPort)
        SRVAL = Level:Notify
        CYCLE
     END
     SendString = 'POST' & CRLF
     IF SELF.GetResponse(SendString,'3',Response)
        SRVAL = Level:Notify
        CYCLE
     END
     SendString = 'From: ' & SELF.From & CRLF
     RVal = SELF.SendString(SendString)
     !Date
     SendString = MakeDateHeader()
     IF SELF.SendString (SendString).

     SELF.SendRecipients(CurrentServer)

     SendString = 'Subject: ' & SELF.Subject & CRLF
     IF SELF.SendString(SendString).

     SELF.SendUserHeaders()

     ! MessageID
     SELF.SendBody()
     SELF.Disconnect()
  END
 END

 RETURN SRVAL

NNTPTransport.SendRecipients      PROCEDURE(STRING ServerName)
R USHORT,AUTO
S USHORT,AUTO
SendString STRING(100)

 CODE
 SendString = 'Newsgroups:'
 S = POINTER(SELF.Recipients)
 LOOP R = S TO RECORDS(SELF.Recipients)
  GET(SELF.Recipients,R)
  IF SELF.Recipients.TransportName <> NNTP THEN BREAK.
  IF GetParameter(SELF.Recipients.ConnectString, 'SERVER') <> UPPER(ServerName) THEN BREAK.
  SendString = CLIP(SendString) & ' ' & CLIP(SELF.Recipients.Address)
 END
 SendString = CLIP(SendString) & CRLF
 IF SELF.SendString(SendString).
 GET(SELF.Recipients,S)
 RETURN

NNTPTransport.IDST.GetWindowControls PROCEDURE(*DSTControlQueue ControlList)
 CODE
 ControlList.Name = 'SERVER'
 ControlList.Prompt = '&Server:'
 ControlList.Picture = '@s80'
 ADD(ControlList)
 ControlList.Name = 'PORT'
 ControlList.Prompt = '&Port:'
 ControlList.Picture = '@s10'
 ADD(ControlList)
 ControlList.Name = 'USER'
 ControlList.Prompt = '&User:'
 ControlList.Picture = '@s80'
 ADD(ControlList)
 ControlList.Name = 'PASSWORD'
 ControlList.Prompt = '&Password:'
 ControlList.Picture = '@s80'
 ADD(ControlList)

NNTPTransport.IMIMETarget.PutText PROCEDURE(STRING Text)
 CODE
 ! This needs to add the body to a queue so the lines can be set later.
 ASSERT(~SELF.BodyQueues &= NULL,'No Body Thread Queue')
 SELF.BodyQueues.Id = THREAD()
 GET(SELF.BodyQueues,+SELF.BodyQueues.Id)
 SELF.BodyQueues.NBQ.Line = Text
 ADD(SELF.BodyQueues.NBQ)

FTPTransport.Init                PROCEDURE(IABook Addresses, ErrorClass Errors)
 CODE
 SELF.Addresses &= Addresses
 SELF.DefaultPort = 21 ! Default FTP Port.
 PARENT.Init(Errors)

FTPTransport.Connect             PROCEDURE(STRING ServerName, SHORT Port=0)
RVAL       BYTE
Response   ASTRING
SendString ASTRING
Username   ASTRING
Password   ASTRING
 CODE
 IF PARENT.Connect(ServerName, Port)
    RETURN Level:Notify
 END
 IF SELF.GetResponse('','220',Response)
    RETURN Level:Notify
 END

 SendString = 'USER ' & UserName & CRLF
 IF SELF.GetResponse(SendString,'2',Response)
    RETURN Level:Notify
 END
 SendString = 'PASS ' & Password & CRLF
 IF SELF.GetResponse(SendString, '2', Response)
    RETURN Level:Notify
 END
 RETURN RVAL

FTPTransport.Disconnect          PROCEDURE
SendString STRING(100)
Response   ASTRING
 CODE
 SendString = 'QUIT' & CRLF
 IF SELF.GetResponse(SendString, '2',Response)
 END
 PARENT.Disconnect()
 RETURN

FTPTransport.IDST.SetAttachments  PROCEDURE(AttachmentQueue Attachments)
 CODE
 RETURN

FTPTransport.IDST.SetDescription  PROCEDURE(STRING Description)
 CODE
 RETURN

FTPTransport.IDST.Send            PROCEDURE(MIMEDoc MD)
RVAL BYTE
 CODE
 IF SELF.Connect(SELF.DefaultServer, SELF.DefaultPort)
    SELF.Disconnect()
 END
 RETURN RVAL

FTPTransport.IDST.GetWindowControls PROCEDURE(*DSTControlQueue ControlList)
 CODE
 ControlList.Name = 'USERNAME'
 ControlList.Prompt = '&User:'
 ControlList.Picture = '@s80'
 ADD(ControlList)
 ControlList.Name = 'PASSWORD'
 ControlList.Prompt = '&Password:'
 ControlList.Picture = '@s80'
 ADD(ControlList)
 ControlList.Name = 'DIRECTORY'
 ControlList.Prompt = '&Directory:'
 ControlList.Picture = '@s80'
 ADD(ControlList)

SortByParameter                   PROCEDURE(*RecipientQueue Recipients, STRING Parametername)
R USHORT,AUTO
 CODE
 LOOP R = 1 TO RECORDS(Recipients)
  GET(Recipients,R)
  Recipients.ConnectString = MoveParameterToFront(Recipients.ConnectString, Parametername)
  PUT(Recipients)
 END
 SORT(Recipients,+Recipients.TransportName,-Recipients.Type,+Recipients.ConnectString)


MoveParameterToFront              PROCEDURE(STRING ConnectString, STRING Parametername)
S USHORT,AUTO
E USHORT,AUTO
NewConnectString CSTRING(1000)
 CODE
 ! IF Parameter not found make parameter 'Default'
 NewConnectString = ConnectString
 S = INSTRING(UPPER(Parametername),UPPER(NewConnectString),1,1)
 IF NOT S
    NewConnectString = CHOOSE(NewConnectString='','SERVER=DEFAULT','SERVER=DEFAULT,' & NewConnectString)
 ELSE
    IF S > 1
       E = INSTRING('$',NewConnectString,1,S)
       NewConnectString = CHOOSE(NOT E OR E = LEN(NewConnectString), |
                            NewConnectString[S : Len(NewConnectString)] & '$' & NewConnectString[1:S-1], |
                            NewConnectString[S : E] & '$' & NewConnectString[1:S-1] & NewConnectString[E+1:LEN(CLIP(ConnectString))])
    END
 END
 RETURN NewConnectString


GetParameter                      PROCEDURE(STRING ParamString, STRING ParamName, BYTE CaseLess=0)
S USHORT,AUTO
E USHORT,AUTO
L USHORT,AUTO
PN             CSTRING(100)
ParameterValue CSTRING(100)
CS             CSTRING(1000)
 CODE
 CLEAR(ParameterValue)
 PN = UPPER(ParamName)
 CS = UPPER(CLIP(ParamString))
 L = LEN(CS)
 LOOP S = 1 TO L
  IF CS[S : S+LEN(PN)-1] = PN
     E = INSTRING('$',CS,1,S)
     IF CaseLess
        ParameterValue = CHOOSE(E>0,ParamString[S+LEN(PN)+1: E-1],ParamString[S+LEN(PN)+1:LEN(ParamString)])
     ELSE
        ParameterValue = CHOOSE(E>0,CS[S+LEN(PN)+1: E-1],CS[S+LEN(PN)+1:LEN(CS)])
     END
     BREAK
  END
 END
 RETURN ParameterValue

AddressVisual.Ask               PROCEDURE(*RecipientQueue Recipients, *RecipientQueue SourceRecipients)
W    WINDOW('Select Recipients'),AT(,,321,206),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI),SYSTEM, |
         GRAY,RESIZE
       LIST,AT(5,6,135,156),USE(?AddressList,FEQ:AdrSourceAddresses),HVSCROLL,FORMAT('85LMI~Name~L(2)80L|M~Address~L(2)20L|M~Transport~L(2)')
       LIST,AT(181,6,135,48),USE(?ToList,FEQ:AdrToList),NOBAR,HVSCROLL,FORMAT('20L(2)I#3#')
       BUTTON('&To: ->'),AT(146,6,31,14),USE(?To,FEQ:AdrTo)
       LIST,AT(181,61,135,48),USE(?CCList,FEQ:AdrCCList),NOBAR,HVSCROLL,FORMAT('20L(2)I#3#')
       BUTTON('&CC: ->'),AT(146,61,31,14),USE(?CC,FEQ:AdrCC)
       LIST,AT(181,115,135,48),USE(?BCCList,FEQ:AdrBCCList),NOBAR,HVSCROLL,FORMAT('20L(2)I#3#')
       BUTTON('&New Contact'),AT(5,165,52,14),USE(?NewContact,FEQ:AdrNew)
       BUTTON('&Properties'),AT(97,165,43,14),USE(?Properties,FEQ:AdrProperties)
       BUTTON('&Delete'),AT(273,165,43,14),USE(?Delete:2,FEQ:AdrDelete),DISABLE
       PANEL,AT(4,182,313,2),USE(?Panel1),BEVEL(-1,1,01E8H)
       BUTTON('&BCC: ->'),AT(146,115,31,14),USE(?BCC,FEQ:AdrBCC)
       BUTTON('&Ok'),AT(224,186,45,14),USE(?Ok,FEQ:AdrOk)
       BUTTON('&Cancel'),AT(272,186,45,14),USE(?Cancel,FEQ:AdrCancel)
       BUTTON('&Remove'),AT(58,165,39,14),USE(?Delete,FEQ:AdrRemove)
     END       
WMDI WINDOW('Select Recipients'),AT(,,321,206),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI),SYSTEM, |
         GRAY,RESIZE,MDI
       LIST,AT(5,6,135,156),USE(?AddressList1,FEQ:AdrSourceAddresses),HVSCROLL,FORMAT('85LMI~Name~L(2)80L|M~Address~L(2)20L|M~Transport~L(2)')
       LIST,AT(181,6,135,48),USE(?ToList1,FEQ:AdrToList),NOBAR,HVSCROLL,FORMAT('20L(2)I#3#')
       BUTTON('&To: ->'),AT(146,6,31,14),USE(?To1,FEQ:AdrTo)
       LIST,AT(181,61,135,48),USE(?CCList1,FEQ:AdrCCList),NOBAR,HVSCROLL,FORMAT('20L(2)I#3#')
       BUTTON('&CC: ->'),AT(146,61,31,14),USE(?CC1,FEQ:AdrCC)
       LIST,AT(181,115,135,48),USE(?BCCList1,FEQ:AdrBCCList),NOBAR,HVSCROLL,FORMAT('20L(2)I#3#')
       BUTTON('&New Contact'),AT(5,165,52,14),USE(?NewContact1,FEQ:AdrNew)
       BUTTON('&Properties'),AT(97,165,43,14),USE(?Properties1,FEQ:AdrProperties)
       BUTTON('&Delete'),AT(273,165,43,14),USE(?Delete:21,FEQ:AdrDelete),DISABLE
       PANEL,AT(4,182,313,2),USE(?Panel11),BEVEL(-1,1,01E8H)
       BUTTON('&BCC: ->'),AT(146,115,31,14),USE(?BCC1,FEQ:AdrBCC)
       BUTTON('&Ok'),AT(224,186,45,14),USE(?Ok1,FEQ:AdrOk)
       BUTTON('&Cancel'),AT(272,186,45,14),USE(?Cancel1,FEQ:AdrCancel)
       BUTTON('&Remove'),AT(58,165,39,14),USE(?Delete1,FEQ:AdrRemove)
     END

 CODE
 SELF.ParentRecipients &= SourceRecipients
 SELF.Recipients &= Recipients
 IF 0{Prop:MDI}
    OPEN(WMDI)
    SELF.Window &= WMDI
 ELSE
    OPEN(W)
    SELF.Window &= W
 END
 SELF.Window{Prop:Hide} = True
 SELF.Window{Prop:Text} = AdrWindowText
 RETURN CHOOSE(SELF.Run()=RequestCancelled,Level:Benign,Level:Notify)

AddressVisual.Init              PROCEDURE(AdrVisualUpdate ABUpd, INIClass INIMgr, ErrorClass E)
 CODE
 SELF.INIMgr &= INIMgr
 SELF.Errors &= E
 SELF.UpdWinMgr &= ABUpd
 RETURN

AddressVisual.Init              PROCEDURE
RVal BYTE
 CODE
 SELF.ToList &= NEW(RecipientQueue)
 SELF.CCList &= NEW(RecipientQueue)
 SELF.BCCList &= NEW(RecipientQueue)
 SELF.Resizer &= NEW WindowResizeClass
 SELF.Dead = False
 RVal = PARENT.Init()
 IF RVal THEN RETURN RVal.
 SELF.AddItem(Feq:AdrCancel,RequestCancelled)
 SELF.OkControl = Feq:AdrOk
 FEQ:AdrTo{Prop:Text} = AdrTo
 FEQ:AdrCC{Prop:Text} = AdrCC
 FEQ:AdrBCC{Prop:Text} = AdrBCC
 FEQ:AdrNew{Prop:Text} = AdrNew
 FEQ:AdrRemove{Prop:Text} = AdrRemove
 FEQ:AdrDelete{Prop:Text} = AdrDelete
 FEQ:AdrProperties{Prop:Text} = AdrProperties
 FEQ:AdrOk{Prop:Text} = AdrOk
 FEQ:AdrCancel{Prop:Text} = AdrCancel
 FEQ:AdrSourceAddresses{Prop:Format} = '85LMI~' & AdrSrcName & '~L(2)#3#80L|M~' & AdrSrcAddress & '~L(2)#2#20L|M~' & AdrSrcTransport & '~L(2)#1#'
 FEQ:AdrSourceAddresses{Prop:From} = SELF.ParentRecipients
 FEQ:AdrSourceAddresses{Prop:IconList,1} = '~Adr1.ico'
 FEQ:AdrToList{Prop:From} = SELF.ToList
 FEQ:AdrToList{Prop:IconList,1} = '~Adr1.ico'
 FEQ:AdrCCList{Prop:From} = SELF.CCList
 FEQ:AdrCCList{Prop:IconList,1} = '~Adr1.ico'
 FEQ:AdrBCCList{Prop:From} = SELF.BCCList
 FEQ:AdrBCCList{Prop:IconList,1} = '~Adr1.ico'
 SELF.SetRecipientLists()
 SELF.SetAlerts
 RETURN RVal

AddressVisual.Kill              PROCEDURE
RVal BYTE,AUTO
 CODE
 RVal = Level:Benign
 FREE(SELF.ToList)
 DISPOSE(SELF.ToList)
 FREE(SELF.CCList)
 DISPOSE(SELF.CCList)
 FREE(SELF.BCCList)
 DISPOSE(SELF.BCCList)
 RVal = PARENT.Kill() ! This will also kill the resizer so the DISPOSE is after this...
 DISPOSE(SELF.Resizer)
 Return RVal

AddressVisual.PutRecipients     PROCEDURE
I USHORT,AUTO
 CODE
 FREE(SELF.Recipients)
 LOOP I = 1 TO RECORDS(SELF.ToList)
  GET(SELF.ToList,I)
  SELF.GetSourceRecipient(SELF.ToList,SendTo)
  ADD(SELF.Recipients)
 END
 LOOP I = 1 TO RECORDS(SELF.CCList)
  GET(SELF.CCList,I)
  SELF.GetSourceRecipient(SELF.CCList,CC)
  ADD(SELF.Recipients)
 END
 LOOP I = 1 TO RECORDS(SELF.BCCList)
  GET(SELF.BCCList,I)
  SELF.GetSourceRecipient(SELF.BCCList,BCC)
  ADD(SELF.Recipients)
 END

AddressVisual.GetSourceRecipient PROCEDURE(*RecipientQueue RecipList,STRING Type)
 CODE
 SELF.ParentRecipients = RecipList
 GET(SELF.ParentRecipients,+SELF.ParentRecipients.Address,+SELF.ParentRecipients.Name)
 IF ERRORCODE()
    SELF.Recipients = RecipList
 ELSE
    SELF.Recipients = SELF.ParentRecipients
    SELF.Recipients.Type = Type
 END

AddressVisual.SetAlerts         PROCEDURE
 CODE
 FEQ:AdrSourceAddresses{Prop:Alrt,1} = DeleteKey
 FEQ:AdrSourceAddresses{Prop:Alrt,2} = MouseRight
 FEQ:AdrSourceAddresses{Prop:Alrt,3} = MouseLeft2
 FEQ:AdrSourceAddresses{Prop:Alrt,4} = EnterKey
 FEQ:AdrSourceAddresses{Prop:Alrt,5} = InsertKey

 FEQ:AdrToList{Prop:Alrt,1} = DeleteKey
 FEQ:AdrToList{Prop:Alrt,2} = MouseRight
 FEQ:AdrCCList{Prop:Alrt,1} = DeleteKey
 FEQ:AdrCCList{Prop:Alrt,2} = MouseRight
 FEQ:AdrBCCList{Prop:Alrt,1} = DeleteKey
 FEQ:AdrBCCList{Prop:Alrt,2} = MouseRight
 PARENT.SetAlerts()

AddressVisual.SetRecipientLists PROCEDURE
I USHORT,AUTO
 CODE
 FREE(SELF.ToList)
 FREE(SELF.CCList)
 FREE(SELF.BCCList)
 LOOP I = 1 TO RECORDS(SELF.Recipients)
  GET(SELF.Recipients,I)
  CASE SELF.Recipients.Type
  OF CC
     SELF.CCList = SELF.Recipients
     ADD(SELF.CCList)
  OF BCC
     SELF.BCCList = SELF.Recipients
     ADD(SELF.BCCList)
  ELSE
     SELF.ToList = SELF.Recipients
     ADD(SELF.ToList)
  END
 END

 RETURN

AddressVisual.TakeAccepted      PROCEDURE
 CODE
 CASE FIELD()
 OF FEQ:AdrProperties
    SELF.UpdateAddress(ChangeRecord)
 OF FEQ:AdrSourceAddresses
 OF FEQ:AdrToList
 OF FEQ:AdrTo
    SELF.ToList = SELF.ParentRecipients
    SELF.ToList.Type = SendTo
    GET(SELF.ToList,+SELF.ToList.Address)
    IF ERRORCODE()
       ADD(SELF.ToList)
       DISPLAY(FEQ:AdrToList)
    END
 OF FEQ:AdrCC
    SELF.CCList = SELF.ParentRecipients
    SELF.CCList.Type = CC
    GET(SELF.CCList,+SELF.CCList.Address)
    IF ERRORCODE()
       ADD(SELF.CCList)
       DISPLAY(FEQ:AdrCCList)
    END
 OF FEQ:AdrBCC
    SELF.BCCList = SELF.ParentRecipients
    SELF.BCCList.Type = BCC
    GET(SELF.BCCList,+SELF.BCCList.Address)
    IF ERRORCODE()
       ADD(SELF.BCCList)
       DISPLAY(FEQ:AdrBCCList)
    END
 OF FEQ:AdrNew
    SELF.UpdateAddress(InsertRecord)
 OF FEQ:AdrDelete
    CASE SELF.CurrentList
    OF FEQ:AdrToList
       DELETE(SELF.ToList)
       DISPLAY(FEQ:AdrToList)
    OF FEQ:AdrCCList
       DELETE(SELF.CCList)
       DISPLAY(FEQ:AdrCCList)
    OF FEQ:AdrBCCList
       DELETE(SELF.BCCList)
       DISPLAY(FEQ:AdrBCCList)
    END
 OF FEQ:AdrRemove
    IF SELF.Errors.Throw(Msg:ConfirmDelete) = Level:Benign
       DELETE(SELF.ParentRecipients)
       DISPLAY(FEQ:AdrSourceAddresses)
    END
 END
 RETURN PARENT.TakeAccepted()

AddressVisual.TakeFieldEvent    PROCEDURE
 CODE
 CASE FIELD()
 OF FEQ:AdrSourceAddresses
    CASE EVENT()
    OF EVENT:NewSelection
       GET(SELF.ParentRecipients,CHOICE(FEQ:AdrSourceAddresses))
       DISABLE(FEQ:AdrDelete)
    OF EVENT:AlertKey
       GET(SELF.ParentRecipients,CHOICE(FEQ:AdrSourceAddresses))
       CASE KEYCODE()
       OF   MouseLeft2
       OROF EnterKey
          POST(EVENT:Accepted,FEQ:AdrProperties)
       OF   DeleteKey
          POST(EVENT:Accepted,FEQ:AdrRemove)
       OF   InsertKey
          POST(EVENT:Accepted,FEQ:AdrNew)
       END
    END
 OF FEQ:AdrToList
    CASE EVENT()
    OF EVENT:NewSelection
       GET(SELF.ToList,CHOICE(FEQ:AdrToList))
       SELF.CurrentList = FEQ:AdrToList
       ENABLE(FEQ:AdrDelete)
    OF EVENT:AlertKey
       IF KEYCODE() = DeleteKey
          DELETE(SELF.ToList)
          DISPLAY(FEQ:AdrToList)
       END
    END
 OF FEQ:AdrCCList
    CASE EVENT()
    OF EVENT:NewSelection
       GET(SELF.CCList,CHOICE(FEQ:AdrCCList))
       SELF.CurrentList = FEQ:AdrCCList
       ENABLE(FEQ:AdrDelete)
    OF EVENT:AlertKey
       IF KEYCODE() = DeleteKey
          DELETE(SELF.CCList)
          DISPLAY(FEQ:AdrCCList)
       END
    END
 OF FEQ:AdrBCCList
    CASE EVENT()
    OF EVENT:NewSelection
       GET(SELF.BCCList,CHOICE(FEQ:AdrBCCList))
       SELF.CurrentList = FEQ:AdrBCCList
       ENABLE(FEQ:AdrDelete)
    OF EVENT:AlertKey
       IF KEYCODE() = DeleteKey
          DELETE(SELF.BCCList)
          DISPLAY(FEQ:AdrBCCList)
       END
    END
 END
 RETURN PARENT.TakeFieldEvent()

AddressVisual.TakeWindowEvent    PROCEDURE
 CODE
 CASE EVENT()
 OF EVENT:OpenWindow
    SELF.Resizer.Init(AppStrategy:Resize,Resize:SetMinSize)
    SELF.AddItem(SELF.Resizer)
    SELF.Resizer.SetParentDefaults
    SELF.INIMgr.Fetch('Clarion-AddressBook',SELF.Window) ! Restore saved size.
    SELF.Resizer.Resize
    SELF.Resizer.Reset
    0{Prop:Hide} = False
    0{Prop:Active} = True
 OF EVENT:CloseWindow
    SELF.INIMgr.Update('Clarion-AddressBook',SELF.Window) ! Save Window Size.
 OF EVENT:Completed
    SELF.PutRecipients()
    POST(EVENT:CloseWindow)
 END
 RETURN PARENT.TakeWindowEvent()

AddressVisual.UpdateAddress     PROCEDURE(BYTE Request)
RVal        BYTE
 CODE
 IF Request = InsertRecord
    CLEAR(SELF.ParentRecipients)
 END
 RVal = SELF.UpdWinMgr.Ask(SELF.ParentRecipients)
 IF RVal
    IF Request = InsertRecord
       SELF.ParentRecipients.Name_Icon = 1
       ADD(SELF.ParentRecipients)
    ELSE
       PUT(SELF.ParentRecipients)
    END
 ELSE
    GET(SELF.ParentRecipients,POINTER(SELF.ParentRecipients))
 END
 RETURN RVal

AdrVisualUpdate.AddItem           PROCEDURE(*IDST IDocumentSend, STRING TransportName)
 CODE
? ASSERT(~SELF.TransportList &= NULL, 'No Transport List.')
 SELF.TransportList.DST  &= IDocumentSend
 SELF.TransportList.Name = TransportName
 ADD(SELF.TransportList)

AdrVisualUpdate.Ask               PROCEDURE(*RecipientQueue RecipientList)
W    WINDOW('Update Recipient Details'),AT(,,181,75),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI), |
         SYSTEM,GRAY,RESIZE
       PROMPT('&Address:'),AT(5,9),USE(?Address:Prompt,FEQ:AdrAdrPrompt)
       ENTRY(@s80),AT(39,9,,10),USE(?Address,FEQ:AdrAddress)
       PROMPT('&Name:'),AT(6,23),USE(?Name:Prompt,FEQ:AdrNamePrompt)
       ENTRY(@s80),AT(39,23,,10),USE(?Name,FEQ:AdrName)
       PROMPT('&Type:'),AT(6,36),USE(?Type:Prompt,FEQ:AdrTypePrompt)
       LIST,AT(39,36,60,10),USE(?TransportList,FEQ:AdrTransport),IMM,DROP(10)
       PANEL,AT(1,49,180,1),USE(?Panel),BEVEL(0,0,01B9H)
       BUTTON('Ok'),AT(85,57,45,14),USE(?Ok,FEQ:AdrOk),DEFAULT
       BUTTON('&Cancel'),AT(135,57,45,14),USE(?Cancel,FEQ:AdrCancel)
     END

WMDI WINDOW('Update Recipient Details'),AT(,,181,75),FONT('MS Sans Serif',8,,FONT:regular,CHARSET:ANSI), |
         SYSTEM,GRAY,RESIZE,MDI
       PROMPT('&Address:'),AT(5,9),USE(?Address:Prompt1,FEQ:AdrAdrPrompt)
       ENTRY(@s80),AT(39,9,,10),USE(?Address1,FEQ:AdrAddress)
       PROMPT('&Name:'),AT(6,23),USE(?Name:Prompt1,FEQ:AdrNamePrompt)
       ENTRY(@s80),AT(39,23,,10),USE(?Name1,FEQ:AdrName)
       PROMPT('&Type:'),AT(6,36),USE(?Type:Prompt1,FEQ:AdrTypePrompt)
       LIST,AT(39,36,60,10),USE(?TransportList1,FEQ:AdrTransport),IMM,DROP(10)
       PANEL,AT(1,49,180,1),USE(?Panel1),BEVEL(0,0,01B9H)
       BUTTON('Ok'),AT(85,57,45,14),USE(?Ok1,FEQ:AdrOk),DEFAULT
       BUTTON('&Cancel'),AT(135,57,45,14),USE(?Cancel1,FEQ:AdrCancel)
     END

 CODE
 SELF.RecipientList &= RecipientList
 SELF.Name = RecipientList.Name
 SELF.Address = RecipientList.Address
 IF 0{Prop:MDI}
    OPEN(WMDI)
    SELF.Window &= WMDI
 ELSE
    OPEN(W)
    SELF.Window &= W
 END
 SELF.Window{Prop:Text} = AdrUpdWinText
 RETURN CHOOSE(SELF.Run()=RequestCancelled,Level:Benign,Level:Notify)

AdrVisualUpdate.Init              PROCEDURE
RVal BYTE
 CODE
 SELF.TransportList &= NEW(DSTQueue)
 SELF.ControlList   &= NEW(DSTControlQueue)
 SELF.Dead = False

 SELF.Window{Prop:Text} = AdrUpdWinText
 FEQ:AdrAdrPrompt{Prop:Text} = AdrAdrPrompt
 FEQ:AdrNamePrompt{Prop:Text} = AdrNamePrompt
 FEQ:AdrTypePrompt{Prop:Text} = AdrTypePrompt
 FEQ:AdrAddress{Prop:ScreenText} = SELF.Address
 FEQ:AdrName{Prop:ScreenText} = SELF.Name
 UPDATE()

 RVal = PARENT.Init()
 IF RVal THEN RETURN Level:Benign.
 SELF.TransportList.Name = CLIP(SELF.RecipientList.TransportName)
 GET(SELF.TransportList, SELF.TransportList.Name)
 SELF.AddItem(Feq:AdrCancel,RequestCancelled)
 SELF.AddItem(Feq:AdrOk,RequestCompleted)
 SELF.OkControl = Feq:AdrOk
 RETURN RVal

AdrVisualUpdate.CreateDstControls PROCEDURE
I USHORT,AUTO
C USHORT,AUTO
 CODE
? ASSERT(~SELF.TransportList.DST &= NULL,'Transport IDST not available?')
 DESTROY(FEQ:AdrLastControl+2,FEQ:AdrLastControl+2+(RECORDS(SELF.ControlList)*2))
 FREE(SELF.ControlList)
 SELF.TransportList.DST.GetWindowControls(SELF.ControlList)
 LOOP I = 1 TO RECORDS(SELF.ControlList)
  GET(SELF.ControlList,I)
  C = ((I * 2)-1)+FEQ:AdrLastControl+2
  CREATE(C,CREATE:Prompt)
  C{Prop:Text} = SELF.ControlList.Prompt
  SETPOSITION(C,FEQ:AdrTypePrompt{Prop:XPos},FEQ:AdrLastControl{Prop:YPos} + (I*13) + 5,,10)
  C+=1
  CREATE(C,CREATE:Entry)
  C{Prop:Text} = SELF.ControlList.Picture
  SETPOSITION(C, FEQ:AdrTransport{Prop:XPos}, (C-1){Prop:YPos},,10)
  C{Prop:ScreenText} = GetParameter(SELF.RecipientList.ConnectString, SELF.ControlList.Name, True)
  UPDATE(C)
 END
 SETPOSITION(FEQ:AdrOk,,C{Prop:YPos}+C{Prop:Height}+5)
 SETPOSITION(FEQ:AdrCancel,,C{Prop:YPos}+C{Prop:Height}+5)
 SETPOSITION(0,,,,FEQ:AdrCancel{Prop:YPos}+FEQ:AdrCancel{Prop:Height}+3)
 UNHIDE(FEQ:AdrLastControl+2,FEQ:AdrLastControl+2+(RECORDS(SELF.ControlList)*2))

AdrVisualUpdate.TakeWindowEvent                PROCEDURE
 CODE
 CASE EVENT()
 OF EVENT:OpenWindow
    FEQ:AdrTransport{Prop:From} = SELF.TransportList.Name
    FEQ:AdrTransport{Prop:Use} = SELF.RecipientList.TransportName

    IF NOT SELF.RecipientList.TransportName
       FEQ:AdrTransport{Prop:Selected} = 1
       GET(SELF.TransportList,1)
    ELSE
       SELF.TransportList.Name = SELF.RecipientList.TransportName
       GET(SELF.TransportList,SELF.TransportList.Name)
       IF ERRORCODE()
          FEQ:AdrTransport{Prop:Selected} = 1
          GET(SELF.TransportList,1)
       END
    END
    SELF.CreateDSTControls
    SELF.Window{Prop:Hide} = False
 END
 RETURN PARENT.TakeWindowEvent()

AdrVisualUpdate.Kill            PROCEDURE
 CODE
 DISPOSE(SELF.TransportList)
 DISPOSE(SELF.ControlList)
 RETURN PARENT.Kill()

AdrVisualUpdate.TakeAccepted    PROCEDURE
I USHORT,AUTO
C USHORT,AUTO
 CODE
 CASE FIELD()
 OF FEQ:AdrName
    SELF.RecipientList.Name = FEQ:AdrName{Prop:ScreenText}
    IF NOT SELF.RecipientList.Name
       SELF.RecipientList.Name = SELF.RecipientList.Address
    END
    FEQ:AdrName{Prop:ScreenText} = SELF.RecipientList.Name
 OF FEQ:AdrAddress
    SELF.RecipientList.Address = FEQ:AdrAddress{Prop:ScreenText}
 OF FEQ:AdrOk
    IF NOT SELF.RecipientList.Address
       BEEP(BEEP:SystemExclamation)
       SELECT(FEQ:AdrAddress)
       RETURN Level:Notify
    END
    IF NOT SELF.RecipientList.Name
       SELF.RecipientList.Name = SELF.RecipientList.Address
       FEQ:AdrName{Prop:ScreenText} = SELF.RecipientList.Name
       UPDATE(FEQ:AdrName)
       BEEP(BEEP:SystemExclamation)
       SELECT(FEQ:AdrName)
       RETURN Level:Notify
    END
    CLEAR(SELF.RecipientList.ConnectString)
    LOOP I = 1 TO RECORDS(SELF.ControlList)
     GET(SELF.ControlList,I)
     C = (I * 2)+FEQ:AdrLastControl+2
     IF C{Prop:ScreenText}
      SELF.RecipientList.ConnectString = CHOOSE(SELF.RecipientList.ConnectString='',SELF.ControlList.Name & '=' & C{Prop:ScreenText},|
                                         CLIP(SELF.RecipientList.ConnectString) & '$' & SELF.ControlList.Name & '=' & C{Prop:ScreenText})
     END
    END
 OF FEQ:AdrTransport
    GET(SELF.TransportList,CHOICE(FEQ:AdrTransport))
    IF SELF.TransportList.Name <> SELF.TransportName
       SELF.CreateDstControls()
       SELF.TransportName = SELF.TransportList.Name
    END
 END
 RETURN PARENT.TakeAccepted()

RecipientControl.Init             PROCEDURE(UNSIGNED Control, *IABook AddressBook)
 CODE
 SELF.ParentControl = Control
 SELF.RecipientList &= AddressBook.GetRecipients()

RecipientControl.SetFormat        PROCEDURE
 CODE
 SELF.ParentControl{Prop:IconList,1} = '~Adr1.ico'
 SELF.ParentControl{Prop:Format} =  '85L(2)MI~' & AdrSrcName & '~L(2)#3#'
 SELF.ParentControl{Prop:From} = SELF.RecipientList

RecipientControl.WindowComponent.Kill         PROCEDURE
 CODE

RecipientControl.WindowComponent.Reset        PROCEDURE(BYTE Force)
 CODE

RecipientControl.WindowComponent.ResetRequired PROCEDURE
RVAL BYTE
 CODE
 RETURN RVAL

RecipientControl.WindowComponent.SetAlerts    PROCEDURE
 CODE

RecipientControl.WindowComponent.TakeEvent    PROCEDURE
RVal BYTE
 CODE
 CASE EVENT()
 OF EVENT:OpenWindow
    SELF.SetFormat()
 END
 RETURN RVal

RecipientControl.WindowComponent.Update       PROCEDURE
 CODE

RecipientControl.WindowComponent.UpdateWindow PROCEDURE
 CODE




MessageClass.Init              PROCEDURE(INIClass INIMgr, STRING Family, ErrorClass ErrorHandler)
 CODE
 PARENT.Init(ErrorHandler)
 SELF.Addresses &= NEW(AdrMgr)
 SELF.Addresses.Init(INIMgr, Family)
 SELF.SMTP &= NEW(SMTPTransport)
 SELF.NNTP &= NEW(NNTPTransport)
 SELF.SMTP.Init(SELF.Addresses.IABook, ErrorHandler)
 SELF.NNTP.Init(SELF.Addresses.IABook, ErrorHandler)
 SELF.AddDST(SELF.SMTP.IDST, 'SMTP')
 SELF.AddDST(SELF.NNTP.IDST, 'NNTP')

MessageClass.Kill               PROCEDURE

 CODE
 SELF.Addresses.Kill()
 DISPOSE(SELF.Addresses)
 SELF.SMTP.Kill()
 DISPOSE(SELF.SMTP)
 SELF.NNTP.Kill()
 DISPOSE(SELF.NNTP)
 PARENT.Kill()

MessageClass.AddRecipient      PROCEDURE(STRING Address, <STRING Name>, STRING Type, STRING TransportName, <STRING ConnectParameters>)

 CODE
 SELF.Addresses.AddRecipient(Address, Name, Type, TransportName, ConnectParameters)

MessageClass.AddReplyto        PROCEDURE(STRING Address, <STRING Name>)

 CODE
 SELF.SMTP.AddReplyTo(Address, Name)

MessageClass.FreeRecipients    PROCEDURE

 CODE
 SELF.Addresses.FreeRecipients()

MessageClass.SetDefaultSMTPServer   PROCEDURE(STRING Server)

 CODE
 SELF.SMTP.DefaultServer = Server

MessageClass.SetDefaultNNTPServer   PROCEDURE(STRING Server)

 CODE
 SELF.NNTP.DefaultServer = Server

MessageClass.SetSender          PROCEDURE(STRING Sender)

 CODE
 SELF.SMTP.Sender = Sender

MessageClass.SetSenderDomain    PROCEDURE(STRING SenderDomain)

 CODE
 SELF.SMTP.SenderDomain = SenderDomain


MakeDateHeader  PROCEDURE()

Days       STRING('SunMonTueWedThuFriSat'),STATIC
Mons       STRING('JanFebMarAprMayJunJulAugSepOctNovDec'),STATIC
DSub       UNSIGNED,AUTO
MSub       UNSIGNED,AUTO
TZ         LIKE(TimeZoneInfo),AUTO
Bias       LONG,AUTO
BiasSign   BYTE,AUTO
Now        LONG,AUTO

  CODE
  CASE GetTimeZoneInformation (TZ)
  OF 0                              ! TIME_ZONE_ID_UNKNOWN
    Bias = 0
  OF 1                              ! TIME_ZONE_ID_STANDARD
    Bias = TZ.StandardBias
  OF 2                              ! TIME_ZONE_ID_DAYLIGHT
    Bias = CHOOSE (TZ.DayLightDate.wMonth <> 0, TZ.DayLightBias, 0)
  END
  Bias += TZ.Bias

  IF Bias <= 0
    BiasSign = VAL ('+')
    Bias = -Bias
  ELSE
    BiasSign = VAL('-')
  END

  Now   = TODAY()
  DSub  = (((Now % 7) + 1) * 3) - 2
  MSub  = MONTH (Now) * 3 - 2

  RETURN 'Date: ' & Days [DSub : DSub+2] & ', ' & |
         DAY (Now) & ' ' & Mons [MSub : MSub+2] & ' ' & YEAR (Now) & ' ' &|
         FORMAT(Clock(), @T04) & ' ' & |
         CHR(BiasSign) & FORMAT (INT(Bias/60),@N02) & FORMAT (Bias % 60, @N02) & |
         CRLF

