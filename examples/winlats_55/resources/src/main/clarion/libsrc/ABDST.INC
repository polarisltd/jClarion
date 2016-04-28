!ABCIncludeFile(MAI)

OMIT('_EndOfInclude_',_MessageManager_)
_MessageManager_ EQUATE(1)

          INCLUDE('ABMIME.INC'),ONCE
          INCLUDE('ABWINDOW.INC'),ONCE
          INCLUDE('ABWSOCK.INC'),ONCE


RecipientQueue QUEUE,TYPE
TransportName     ASTRING ! SMTP, NNTP, FTP etc..
Address           ASTRING
Name              ASTRING
Name_Icon         SHORT
Type              ASTRING ! To, CC or BCC.
ConnectString     ASTRING
ErrorString       ASTRING
               END

RecipientControl      CLASS,TYPE,IMPLEMENTS(WindowComponent),MODULE('ABDST.CLW'),LINK('ABDST.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
ParentControl     UNSIGNED,PRIVATE
RecipientList     &RecipientQueue,PRIVATE
Init               PROCEDURE(UNSIGNED Control, *IABook AddressBook),VIRTUAL
SetFormat          PROCEDURE,VIRTUAL
                      END

IABook                INTERFACE
GetRecipients     PROCEDURE,*RecipientQueue
                      END

AddressVisual         CLASS(WindowManager),TYPE,MODULE('ABDST.CLW'),LINK('ABDST.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
INIMgr            &INIClass,PRIVATE
Resizer           &WindowResizeClass,PRIVATE
ParentRecipients  &RecipientQueue,PROTECTED
Recipients        &RecipientQueue,PROTECTED
TOList            &RecipientQueue,PROTECTED
CCList            &RecipientQueue,PROTECTED
BCCList           &RecipientQueue,PROTECTED
UpdWinMgr         &AdrVisualUpdate,PRIVATE
CurrentList       USHORT,PRIVATE
Window            &Window,PROTECTED

Ask               PROCEDURE(*RecipientQueue Recipients, *RecipientQueue SourceRecipients),BYTE,PROC
GetSourceRecipient PROCEDURE(*RecipientQueue RecipList,STRING Type),PRIVATE
Init              PROCEDURE(AdrVisualUpdate ABUpd, INIClass INIMgr, ErrorClass E)   !,EXTENDS
Init              PROCEDURE,BYTE,DERIVED,PROC
Kill              PROCEDURE,BYTE,DERIVED,PROC
PutRecipients     PROCEDURE,PROTECTED
SetAlerts         PROCEDURE,DERIVED
SetRecipientLists PROCEDURE,PRIVATE
TakeAccepted      PROCEDURE,DERIVED,BYTE,PROC
TakeFieldEvent    PROCEDURE,DERIVED,BYTE,PROC
TakeWindowEvent   PROCEDURE,DERIVED,BYTE,PROC
UpdateAddress     PROCEDURE(BYTE Request),VIRTUAL,BYTE,PROC
                      END

AdrVisualUpdate       CLASS(WindowManager),TYPE,MODULE('ABDST.CLW'),LINK('ABDST.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
RecipientList     &RecipientQueue,PRIVATE
Address           ASTRING,PRIVATE
Name              ASTRING,PRIVATE
TransportName     ASTRING,PRIVATE
TransportList     &DSTQueue,PRIVATE
ControlList       &DSTControlQueue,PRIVATE
Window            &Window,PROTECTED

AddItem            PROCEDURE(*IDST IDocumentSend, STRING TransportName)
Ask                PROCEDURE(*RecipientQueue RecipientList),BYTE,PROC
CreateDstControls  PROCEDURE,PRIVATE
Init               PROCEDURE,BYTE,DERIVED,PROC
Kill               PROCEDURE,BYTE,DERIVED,PROC
TakeAccepted       PROCEDURE,BYTE,DERIVED,PROC
TakeWindowEvent    PROCEDURE,BYTE,DERIVED,PROC
                      END

AdrMgr                CLASS,IMPLEMENTS(IABook),TYPE,MODULE('ABDST.CLW'),LINK('ABDST.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
Family            ASTRING,PRIVATE
INIMgr            &INIClass,PRIVATE
Recipients        &RecipientQueue,PRIVATE
Win               &AddressVisual,PRIVATE
ParentAdrMgr      &IABook,PRIVATE
AddRecipient      PROCEDURE(STRING Address, <STRING Name>, STRING Type, STRING TransportName, <STRING ConnectParameters>),VIRTUAL ! Transport name = 'SMTP' etc..
AddRecipients     PROCEDURE(*IABook Addresses)
FreeRecipients    PROCEDURE,VIRTUAL
GetIABook         PROCEDURE,*IABook
Init              PROCEDURE(INIClass INIMgr, STRING Family),VIRTUAL
Kill              PROCEDURE,VIRTUAL
Restore           PROCEDURE,VIRTUAL
Save              PROCEDURE,VIRTUAL
                      END

DSTControlQueue   QUEUE,TYPE
Name               ASTRING
Prompt             ASTRING
Picture            ASTRING
Value              ASTRING
                  END

IDST                  INTERFACE
SetAttachments    PROCEDURE(AttachmentQueue Attachments)
Send              PROCEDURE(MIMEDoc MD),BYTE,PROC
SetDescription    PROCEDURE(STRING Description)
GetWindowControls PROCEDURE(*DSTControlQueue ControlList)
                      END


TELNETTransport       CLASS,TYPE,MODULE('ABDST.CLW'),LINK('ABDST.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
Addresses         &IABook,PROTECTED
Attachments       &AttachmentQueue,PROTECTED
Charset           CSTRING(50)
DefaultPort       SHORT
DefaultServer     CSTRING(100)    ! Defalt SMTP Gateway to use when none is specified in ConnectString.
ErrorResponse     CSTRING(100),PROTECTED
Errors            &ErrorClass,PROTECTED
!ITransportInt     &ITransport,PROTECTED jvn
IConnectionInt    &IConnection,PROTECTED
ProtocolName      CSTRING(256),PRIVATE
Settings          &SettingsQueue,PROTECTED
StringToSend      &STRING,PROTECTED
Socket            &CProtocolSocket,PROTECTED
Timeout           USHORT(2000) ! Timeout whie waiting for a response.
WinSock           &WinSock,PROTECTED
ProtocolGen       &CProtocolGenerator,PROTECTED
Window            &Window,PROTECTED
Connect           PROCEDURE(STRING ServerName, SHORT Port=0),BYTE
GetRecipients     PROCEDURE(),*RecipientQueue,PROTECTED
GetResponse       PROCEDURE(STRING SendString, STRING ExpectedResponse, *ASTRING Response),BYTE,PROTECTED
Disconnect        PROCEDURE
Init              PROCEDURE(ErrorClass Errors),PROTECTED   !,EXTENDS
Kill              PROCEDURE,VIRTUAL
TakeResponse      PROCEDURE(*ASTRING Response),VIRTUAL ! Allow for logging etc..
RemoveIAB         PROCEDURE(),VIRTUAL
SendString        PROCEDURE(*STRING SendString),BYTE,VIRTUAL
SetIAB            PROCEDURE(*IABook Addresses),VIRTUAL
                      END

HeaderQueue      QUEUE,TYPE
Header            ASTRING
HeaderValue       ASTRING
                  END

SMTPTransport         CLASS(TELNETTransport),IMPLEMENTS(IDST),IMPLEMENTS(IMIMETarget),TYPE,MODULE('ABDST.CLW'),LINK('ABDST.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
From              CSTRING(100)
MD                &MIMEDoc,PROTECTED
Recipients        &RecipientQueue
ReplyTo           &RecipientQueue,PROTECTED ! can have multiple reply to's.
Sender            CSTRING(100)    ! Tells the SMTP gateway what the return path is (different from reply to).
SenderDomain      CSTRING(100)
Subject           CSTRING(300)
Headers           &HeaderQueue,PRIVATE

AddReplyto        PROCEDURE(STRING Address, <STRING Name>)
Connect           PROCEDURE(STRING ServerName, SHORT Port=0),BYTE
SendRecipients    PROCEDURE(STRING ServerName),BYTE,PROTECTED
SendData          PROCEDURE(STRING ServerName),BYTE,PROTECTED
SendTo            PROCEDURE(STRING ServerName),PROTECTED
SendBody          PROCEDURE,PROTECTED
SendUserHeaders   PROCEDURE,PROTECTED
SetHeader         PROCEDURE(STRING Header, STRING HeaderValue)
Disconnect        PROCEDURE
Init              PROCEDURE(IABook Addresses, ErrorClass Errors),VIRTUAL
Kill              PROCEDURE,DERIVED
                      END

NewsBodyQueue     QUEUE,TYPE
Line               ASTRING
                  END

NewsBodyQueues    QUEUE,TYPE
Id                 LONG
NBQ                &NewsBodyQueue
                  END

NNTPTransport         CLASS(TELNETTransport),IMPLEMENTS(IDST),IMPLEMENTS(IMIMETarget),TYPE,MODULE('ABDST.CLW'),LINK('ABDST.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
From              CSTRING(100)
MD                &MIMEDoc,PROTECTED
BodyQueues        &NewsBodyQueues,PROTECTED
Password          CSTRING(30)
Recipients        &RecipientQueue
Subject           CSTRING(300)
User              CSTRING(30)
Headers           &HeaderQueue,PRIVATE

Connect           PROCEDURE(STRING ServerName, STRING User, STRING Password, SHORT Port=0),BYTE
Disconnect        PROCEDURE
Init              PROCEDURE(IABook Addresses, ErrorClass Errors),VIRTUAL
Kill              PROCEDURE,DERIVED
SendBody          PROCEDURE,PROTECTED
SendRecipients    PROCEDURE(STRING ServerName),PROTECTED
SendUserHeaders   PROCEDURE,PROTECTED
SetHeader         PROCEDURE(STRING Header, STRING HeaderValue)
                      END

FTPTransport          CLASS(TELNETTransport),IMPLEMENTS(IDST),TYPE,MODULE('ABDST.CLW'),LINK('ABDST.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
WorkingDir        ASTRING
Connect            PROCEDURE(STRING ServerName, SHORT Port=0),BYTE
Init               PROCEDURE(IABook Addresses, ErrorClass Errors),VIRTUAL
Disconnect         PROCEDURE
                      END

DocumentHandler       CLASS(MIMEDoc),TYPE,MODULE('ABDST.CLW'),LINK('ABDST.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
DSTList           &DSTQueue,PRIVATE
AddDST             PROCEDURE(IDST IDST, STRING TransportName)
Init               PROCEDURE(ErrorClass ErrorHandler),DERIVED
Kill               PROCEDURE,DERIVED
Send               PROCEDURE,BYTE,VIRTUAL,PROC
                      END

MessageClass          CLASS(DocumentHandler),TYPE,MODULE('ABDST.CLW'),LINK('ABDST.CLW',_MAILinkMode_),DLL(_MAIDllMode_)
Addresses         &AdrMgr,PRIVATE
SMTP              &SMTPTransport
NNTP              &NNTPTransport
AddRecipient           PROCEDURE(STRING Address, <STRING Name>, STRING Type, STRING TransportName, <STRING ConnectParameters>),VIRTUAL ! Transport name = 'SMTP' etc..
AddReplyto             PROCEDURE(STRING Address, <STRING Name>),VIRTUAL
FreeRecipients         PROCEDURE,VIRTUAL
Init                   PROCEDURE(INIClass INIMgr, STRING Family, ErrorClass ErrorHandler),VIRTUAL
Kill                   PROCEDURE,DERIVED
SetDefaultSMTPServer   PROCEDURE(STRING Server)
SetDefaultNNTPServer   PROCEDURE(STRING Server)
SetSender              PROCEDURE(STRING Sender)
SetSenderDomain        PROCEDURE(STRING SenderDomain)
                      END

SendTo  EQUATE('To')
CC      EQUATE('CC')
BCC     EQUATE('BCC')

SMTP    EQUATE('SMTP')
NNTP    EQUATE('NNTP')
FTP     EQUATE('FTP')

   ITEMIZE(1000),PRE(FEQ)
AdrFirstControl EQUATE
AdrCancel       EQUATE(FEQ:AdrFirstControl)
AdrOk           EQUATE
AdrSourceAddresses EQUATE
AdrToList       EQUATE
AdrTo           EQUATE
AdrCCList       EQUATE
AdrCC           EQUATE
AdrBCCList      EQUATE
AdrBCC          EQUATE
AdrNew          EQUATE
AdrRemove       EQUATE
AdrProperties   EQUATE
AdrDelete       EQUATE
AdrAdrPrompt    EQUATE
AdrAddress      EQUATE
AdrNamePrompt   EQUATE
AdrName         EQUATE
AdrTypePrompt   EQUATE
AdrTransport    EQUATE
AdrLastControl  EQUATE(FEQ:AdrTransport)
   END

_EndOfInclude_
