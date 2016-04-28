
!ABCIncludeFile(API)


  OMIT('EndOfInclude',_ABAPI_)
_ABAPI_  EQUATE(1)


  INCLUDE('ITRANS.INT'),ONCE
  INCLUDE('WINSOCK.INC'),ONCE
  INCLUDE('ABERROR.INC'),ONCE
  INCLUDE('CWSYNCHM.INC'),ONCE


  MAP
    MODULE('ABAPI.CLW')
      EventThread(LONG lpParameter),LONG,PASCAL
      AssignAddr(LONG dwVal),LONG
      SVCID_HOSTNAME(),STRING
      SVCID_TCP_RR(LONG _Port, SHORT _RR),STRING
      SVCID_TCP(LONG _Port),STRING
      IS_SVCID_TCP(GUID _g),BYTE
      PORT_FROM_SVCID_TCP(GUID _g),SHORT
      MakeWord(BYTE LowByte, BYTE HighByte),SHORT
      MakeLong(BYTE LowWord, BYTE HighWord),LONG
      LoWord(LONG),SHORT
      HiWord(LONG),SHORT
      LoByte(SHORT),BYTE
      HiByte(SHORT),BYTE
    END
  END

HardSocketCloseCodes    ITEMIZE
SCL:NotSpecified          EQUATE
SCL:CleanExit             EQUATE
SCL:NetDown               EQUATE
SCL:ConnReset             EQUATE
SCL:ConnAborted           EQUATE
SCL:Last                  EQUATE
SCL:BadPtrs               EQUATE
                        END

EventProcessCodes       ITEMIZE
Evt:CloseDown             EQUATE
Evt:Last                  EQUATE
                        END

MsgEventCodes           ITEMIZE(WM_USER + 1001)
Msg:Connected             EQUATE
Msg:ErrorConnecting       EQUATE
Msg:LastWriteCompleted    EQUATE
Msg:SocketClosed          EQUATE
Msg:ConnectionLost        EQUATE
Msg:Last                  EQUATE
                        END

LEN_PROTOCOL_NAME       EQUATE(128)

ProtocolInfoQueue       QUEUE(),TYPE
                          GROUP(WSAPROTOCOL_INFOA).
szProtocolName            CSTRING(LEN_PROTOCOL_NAME + 1)
                        END

AfProtocolQueue         QUEUE(),TYPE
                          GROUP(AFPROTOCOLS).
                        END

ProtocolListQueue       QUEUE(),TYPE
ProtocolName              CSTRING(LEN_PROTOCOL_NAME + 1)
                        END

ConnectionQueue         QUEUE(),TYPE
Connection                &CSocketConnection
IConnectionAddress        LONG
                        END

HttpConnectionQueue     QUEUE(),TYPE
Connection                &CHttpConnection
IConnectionAddress        LONG
                        END

EvtThreadParams         GROUP(),TYPE
hEvent                    WSAEVENT
Socket                    SOCKET
lpConnection              LONG
lpWinSockMgr              LONG
                        END


NO_ERROR                EQUATE(0)
ERR_NO_PROTOCOLS        EQUATE(-10)
ERR_NO_GOOD_PROTOCOLS   EQUATE(-11)
ERR_MEM_ALLOC_FAILED    EQUATE(-12)


SearchCriteria          CLASS,TYPE,MODULE('ABAPI.CLW'),LINK('ABAPI.CLW', _APILinkMode_),DLL(_APIDllMode_)
bReliable                 BOOL,PROTECTED
bMsgOriented              BOOL,PROTECTED
bStreamOriented           BOOL,PROTECTED
bConnectionless           BOOL,PROTECTED
                        END


CProtocolSocket         CLASS,TYPE,MODULE('ABAPI.CLW'),LINK('ABAPI.CLW', _APILinkMode_),DLL(_APIDllMode_)
Construct                 PROCEDURE
Destruct                  PROCEDURE
Init                      PROCEDURE(SOCKET Sock, LONG lpqsResults, LONG QSResultsBuffSize),SIGNED
kill                      PROCEDURE
GetSocket                 PROCEDURE,SOCKET
GetLocalAddr              PROCEDURE,LONG
GetLocalAddrLen           PROCEDURE,LONG
GetRemoteAddr             PROCEDURE,LONG
GetRemoteAddrLen          PROCEDURE,LONG
GetSocketType             PROCEDURE,LONG
GetProtocol               PROCEDURE,LONG

AssignBuffers             PROCEDURE,BOOL,PROTECTED

bInitialised              BOOL,PRIVATE
SockAddr                  GROUP(SOCKADDR),PRIVATE.
QSResults                 GROUP(WSAQUERYSET),PROTECTED.
ICSAddr_Info              GROUP(CSADDR_INFO),PROTECTED.
LocalSockAddr             GROUP(SOCKADDR),PROTECTED.
RemoteSockAddr            GROUP(SOCKADDR),PROTECTED.
Sock                      SOCKET,PRIVATE
lpqsResults               LONG,PRIVATE
QSResultsBuffSize         LONG,PRIVATE
lpCSAddrInfos             LONG,PRIVATE
CSAddrBuffSize            LONG,PRIVATE
                        END


CProtocolGenerator      CLASS,TYPE,MODULE('ABAPI.CLW'),LINK('ABAPI.CLW', _APILinkMode_),DLL(_APIDllMode_)
Construct                 PROCEDURE
Destruct                  PROCEDURE,VIRTUAL
Init                      PROCEDURE(<ErrorClass ErrHdlr>)
IsInitialised             PROCEDURE,BOOL
Kill                      PROCEDURE,VIRTUAL
CreateProtocol            PROCEDURE(SearchCriteria SearchInfo, *CSTRING szServiceName, LONG lpServiceType, LONG dwPort, *LONG nErr, LONG dwNameSpace = NS_ALL),*CProtocolSocket
CreateProtocol            PROCEDURE(LONG AddressFamily = AF_INET, LONG Protocol = IPPROTO_TCP, LONG SocketType = SOCK_STREAM, *CSTRING szServiceName, LONG Port, *LONG nErr, LONG dwNameSpace = NS_ALL),*CProtocolSocket
EnumProtocols             PROCEDURE(*LONG lpProtocolBuffer, *LONG dwProtBufSize),SIGNED
BuildAfProtocolsList      PROCEDURE
GetAFProtocolsAddr        PROCEDURE,SIGNED
GetProtocolCount          PROCEDURE,LONG
LookupServiceAddresses    PROCEDURE(*CSTRING szServiceName, LONG lpServiceType, *LONG lpCSAddrInfos, *LONG CSAddrBuffSize, *LONG dwNumCsAddrInfos, *LONG lpqsResults, *LONG qsResultsBuffSize, LONG dwNameSpace = NS_ALL),SIGNED
CrackSockAddr             PROCEDURE(LONG dwPort, *SOCKADDR _LocalSockAddr, *SOCKADDR _RemoteSockAddr, LONG iSocketType, LONG iProtocol, *SOCKET sock),SIGNED
ThrowError                PROCEDURE(*CSTRING szErrMsg)

IsGoodProtocol            PROCEDURE(LONG dwServiceFlags),BOOL,PROTECTED
IsReliable                PROCEDURE(LONG dwServiceFlags),BOOL,PROTECTED
IsConnectionless          PROCEDURE(LONG dwServiceFlags),BOOL,PROTECTED
OnEnumProtocol            PROCEDURE(WSAPROTOCOL_INFOA ProtocolInfo, *CSTRING ProtocolName),VIRTUAL,PROTECTED

ProtocolInfoQueue         &ProtocolInfoQueue,PROTECTED
SearchInfo                &SearchCriteria,PROTECTED
ErrHdlr                   &ErrorClass,PROTECTED
lpAfProtocols             LONG,PROTECTED
AfProtocolsSize           LONG,PROTECTED
dwNumAfProtocols          LONG,PROTECTED
lpProtocolBuffer          LONG,PROTECTED
dwProtInfoStructs         LONG,PROTECTED
dwProtBufSize             LONG,PROTECTED
bUseProtocolIndependence  BOOL,PROTECTED
bInitialised              BOOL,PROTECTED
AddressFamily             LONG,PROTECTED
Protocol                  LONG,PROTECTED
bProtsEnumerated          BOOL,PROTECTED
                        END


CSocketConnection       CLASS,TYPE,MODULE('ABAPI.CLW'),LINK('ABAPI.CLW', _APILinkMode_),DLL(_APIDllMode_),IMPLEMENTS(IConnection)
Construct                 PROCEDURE
Destruct                  PROCEDURE,VIRTUAL
Init                      PROCEDURE(LONG dwThreadID, CWinSock20 WinSockMgr, CProtocolSocket Protocol, BYTE bServerSocket = false),BOOL,PROC
Kill                      PROCEDURE,VIRTUAL
IsInitialised             PROCEDURE,BOOL
IsConnected               PROCEDURE,BOOL
IsServerSocket            PROCEDURE,BOOL
Connect                   PROCEDURE,SIGNED
SetThreadProc             PROCEDURE(LONG lpThreadProc)
GetSocket                 PROCEDURE,SOCKET
CloseSocket               PROCEDURE
SafeClose                 PROCEDURE
Shutdown                  PROCEDURE,LONG
SetSendTimeout            PROCEDURE(LONG dwTimeout),LONG
SetRecvTimeout            PROCEDURE(LONG dwTimeout),LONG
SendData                  PROCEDURE(*STRING strSendBuffer, *LONG BytesSent),LONG
ReceiveData               PROCEDURE(LONG lpReceiveBuffer, LONG dwSize, *LONG BytesReceived),LONG

OnCloseSocket             PROCEDURE(LONG dwReason, *CProtocolSocket Socket),VIRTUAL,PROTECTED

StartSocketThread         PROCEDURE(*LONG TID)

CloseCritSection          &ICriticalSection
ThreadParams              LIKE(EvtThreadParams),PROTECTED
WinSockMgr                &CWinSock20,PROTECTED
Socket                    &CProtocolSocket,PROTECTED
hEvent                    WSAEVENT,PROTECTED
Sock                      SOCKET,PROTECTED
hThread                   HANDLE,PROTECTED
bInitialised              BOOL,PROTECTED
bConnected                BOOL,PROTECTED
bServerSocket             BOOL,PROTECTED
dwThreadID                LONG,PROTECTED
bUserThreadProc           LONG,PROTECTED
lpThreadProc              LONG,PROTECTED
bShutdown                 LONG,PROTECTED
                        END


CWinSock20              CLASS,TYPE,MODULE('ABAPI.CLW'),LINK('ABAPI.CLW', _APILinkMode_),DLL(_APIDllMode_)
Construct                 PROCEDURE
Destruct                  PROCEDURE,VIRTUAL
Init                      PROCEDURE(<ErrorClass ErrHdlr>),SIGNED
InitServer                PROCEDURE(LONG dwServerPort = 0, LONG dwServerThreadID = 0),SIGNED
Kill                      PROCEDURE,VIRTUAL
KillServer                PROCEDURE,VIRTUAL
IsInitialised             PROCEDURE,BOOL
IsServerInitialised       PROCEDURE,BOOL
SetSendTimeout            PROCEDURE(*IConnection Connection, LONG dwTimeout),LONG
SetRecvTimeout            PROCEDURE(*IConnection Connection, LONG dwTimeout),LONG
ServerConnect             PROCEDURE(LONG dwThreadID),LONG,PROTECTED
SocketConnect             PROCEDURE(LONG dwThreadID, LONG dwPort, *CSTRING szServiceName, CProtocolSocket Socket, *LONG nErr, <*CSocketConnection Connection>),*CSocketConnection
Disconnect                PROCEDURE(*IConnection Connection),LONG,PROC
CleanupConnection         PROCEDURE(*IConnection Connection)
Listen                    PROCEDURE
SendData                  PROCEDURE(*IConnection Connection, *STRING strSendBuffer, *LONG BytesSent),LONG
ReceiveData               PROCEDURE(*IConnection Connection, *STRING strReceiveBuffer, *LONG BytesReceived),LONG
ReceiveServerData         PROCEDURE(*STRING strReceiveBuffer),LONG
ProcessEvent              PROCEDURE(*CSocketConnection Connection, LONG nErr, LONG hEvent),LONG
ThrowError                PROCEDURE(*CSTRING szErrMsg)

CleanupConnectionQueue    PROCEDURE(ConnectionQueue Connections),PROTECTED
OnReadEventTS             PROCEDURE(LONG dwThreadID, SOCKET Sock, *STRING strReceiveBuffer, LONG dwBytes, BYTE bServerSocket = false),LONG,VIRTUAL,PROTECTED
OnWriteEventTS            PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode = 0),LONG,VIRTUAL,PROTECTED
OnAcceptEventTS           PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode = 0, SOCKET InboundSock = INVALID_SOCKET),LONG,VIRTUAL,PROTECTED
OnOOBEventTS              PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode = 0),LONG,VIRTUAL,PROTECTED
OnConnectEventTS          PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode = 0),LONG,VIRTUAL,PROTECTED
OnCloseEventTS            PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode = 0),LONG,VIRTUAL,PROTECTED
OnWaitFailedTS            PROCEDURE(*CSocketConnection Connection),LONG,VIRTUAL,PROTECTED
OnReadEventPostTS         PROCEDURE(SOCKET Sock, *IConnection Connection),LONG,VIRTUAL,PROTECTED
OnWriteEventPostTS        PROCEDURE(SOCKET Sock, *IConnection Connection),LONG,VIRTUAL,PROTECTED
OnAcceptEventPostTS       PROCEDURE(SOCKET Sock, *IConnection Connection),LONG,VIRTUAL,PROTECTED
OnOOBEventPostTS          PROCEDURE(SOCKET Sock, *IConnection Connection),LONG,VIRTUAL,PROTECTED
OnConnectEventPostTS      PROCEDURE(SOCKET Sock, *IConnection Connection),LONG,VIRTUAL,PROTECTED
OnCloseEventPostTS        PROCEDURE(SOCKET Sock, *IConnection Connection),LONG,VIRTUAL,PROTECTED
OnWaitFailedPostTS        PROCEDURE(*CSocketConnection Connection),LONG,VIRTUAL,PROTECTED
OnEnumNetEventError       PROCEDURE(LONG WSAError, *IConnection Connection),LONG,VIRTUAL,PROTECTED
OnSocketClosed            PROCEDURE(SOCKET Sock, *IConnection IConnection),VIRTUAL

ProcessReadEvent          PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode),LONG,PROTECTED
ProcessWriteEvent         PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode),LONG,PROTECTED
ProcessAcceptEvent        PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode),LONG,PROTECTED
ProcessOOBEvent           PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode),LONG,PROTECTED
ProcessConnectEvent       PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode),LONG,PROTECTED
ProcessCloseEvent         PROCEDURE(SOCKET Sock, *IConnection Connection, LONG iErrorCode),LONG,PROTECTED

ProcessWaitError          PROCEDURE(*CSocketConnection Connection),LONG,PRIVATE
ProcessNetworkEvent       PROCEDURE(*CSocketConnection Connection, LONG hEvent),LONG,PRIVATE

ClientConnectionQueue     &ConnectionQueue,PROTECTED
ServerConnectionQueue     &ConnectionQueue,PROTECTED
ErrHdlr                   &ErrorClass,PROTECTED
WSADataGrp                GROUP(WSAData),PROTECTED.
ServiceType               GROUP(GUID),PROTECTED.
bInitialised              BOOL,PROTECTED
bServerInitialised        BOOL,PROTECTED
dwServerPort              LONG,PROTECTED
nLastError                LONG,PROTECTED
                        END


CHttpConnection         CLASS,TYPE,MODULE('ABAPI.CLW'),LINK('ABAPI.CLW', _APILinkMode_),DLL(_APIDllMode_),IMPLEMENTS(IINetConnectionHttp)
Construct                 PROCEDURE
Destruct                  PROCEDURE,VIRTUAL
Init                      PROCEDURE(CWinINet WinINetMgr, LONG hInternetSession, LONG hInternetConnect, ASTRING ASVerb, *CSTRING szServerName),BYTE,PROC
Kill                      PROCEDURE
SetOptions                PROCEDURE(*CSTRING szReferer, *CSTRING szAcceptTypes, LONG dwFlags, LONG dwContext)
OpenRequest               PROCEDURE(ASTRING szVerb, *CSTRING szObjectName, *CSTRING szVersion, *CSTRING szReferer, *CSTRING szAcceptTypes, LONG dwFlags, LONG dwContext),BYTE
SendRequest               PROCEDURE(*CSTRING szHeaders, LONG dwHeadersLength, LONG lpOptional, LONG dwOptionalLength),BYTE,PROC
QueryInfo                 PROCEDURE(LONG dwInfoLevel, LONG lpBuffer, LONG dwBufferLength, LONG dwIndex),LONG,PROC
ReceiveData               PROCEDURE(LONG lpReceiveBuffer, LONG dwSize),LONG

ConnectionMgr             &CWinINet,PROTECTED
szServerName              &CSTRING,PROTECTED
szReferer                 &CSTRING,PROTECTED
szAcceptTypes             &CSTRING,PROTECTED
ASVerb                    ASTRING,PROTECTED
hInternetSession          LONG,PROTECTED
hInternetConnect          LONG,PROTECTED
hInternetOpenRequest      LONG,PROTECTED
dwFlags                   LONG,PROTECTED
dwContext                 LONG,PROTECTED
dwStatus                  LONG,PROTECTED
dwThreadID                LONG
                        END


CFtpConnection          CLASS(CHttpConnection),TYPE,MODULE('ABAPI.CLW'),LINK('ABAPI.CLW', _APILinkMode_),DLL(_APIDllMode_)
SendCommand               PROCEDURE(BYTE fExpectResponse, LONG dwFlags, *CSTRING szCommand, *LONG lpdwContext, *LONG lphFtpCommand),LONG
FindFirstFile             PROCEDURE(*CSTRING szSearchFile, WIN32_FIND_DATA lpFindFileData, LONG dwFlags, LONG dwContext = 0),LONG
FindNextFile              PROCEDURE(WIN32_FIND_DATA lpFindFileData),LONG
GetFileSize               PROCEDURE(*CSTRING szFileName, LONG dwAccess, LONG dwFlags, *LONG dwContext, *LONG dwFileSizeHigh),LONG
GetFile                   PROCEDURE(*CSTRING szRemoteFile, *CSTRING szNewFile, BYTE bFailIfExists, LONG dwLocalFlagsAndAttributes, LONG dwInternetFlags, LONG dwContext = 0),LONG
PutFile                   PROCEDURE(*CSTRING szLocalFile, *CSTRING szNewRemoteFile, LONG dwFlags, LONG dwContext = 0),LONG
GetCurrentDirectory       PROCEDURE(*CSTRING szCurrentDirectory, *LONG dwCurrentDirectory),LONG
SetCurrentDirectory       PROCEDURE(*CSTRING szDirectory),LONG
CreateDirectory           PROCEDURE(*CSTRING szDirectory),LONG
RemoveDirectory           PROCEDURE(*CSTRING szDirectory),LONG
RenameFile                PROCEDURE(*CSTRING szExisting, *CSTRING szNew),LONG
DeleteFile                PROCEDURE(*CSTRING szFileName),LONG

hFind                     LONG,PROTECTED
                        END


CWinINet                CLASS,TYPE,MODULE('ABAPI.CLW'),LINK('ABAPI.CLW', _APILinkMode_),DLL(_APIDllMode_)
Construct                 PROCEDURE
Destruct                  PROCEDURE,VIRTUAL
Init                      PROCEDURE(*CSTRING szAgent, LONG dwAccessType, LONG dwFlags = 0, <ErrorClass ErrHdlr>),BYTE,PROC
InitProxy                 PROCEDURE(*CSTRING szAgent, LONG dwAccessType, *CSTRING szProxyName, *CSTRING szProxyBypass, LONG dwFlags = 0, <ErrorClass ErrHdlr>),BYTE
Kill                      PROCEDURE
SetUser                   PROCEDURE(*CSTRING szUserName, *CSTRING szPassword)
Connect                   PROCEDURE(*CSTRING szServerName, LONG nServerPort = INTERNET_DEFAULT_HTTP_PORT, *CSTRING szUserName, *CSTRING szPassword, LONG dwService = INTERNET_SERVICE_HTTP, LONG dwFlags = 0, LONG dwContext = 0, ASTRING ASVerb),*CHttpConnection
Disconnect                PROCEDURE(*IINetConnection Connection)
OnReadEvent               PROCEDURE(IINetConnection Connection,*STRING strReceiveBuffer,LONG dwBytes),PROTECTED,VIRTUAL

HttpConnectionQueue       &HttpConnectionQueue,PROTECTED
szAgent                   &CSTRING,PROTECTED
hInternetSession          LONG,PROTECTED
dwFlags                   LONG,PROTECTED
szUserName                &CSTRING
szPassword                &CSTRING
                        END


  EndOfInclude

