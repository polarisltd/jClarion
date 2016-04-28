
  OMIT('_EndOfInclude_',_WINSOCK_)
_WINSOCK_  EQUATE(1)

  INCLUDE('WINDOWS.INC'),ONCE

_MAX_PATH               EQUATE(260)

WM_USER                 EQUATE(0400H)

PAGE_NOACCESS           EQUATE(01h)
PAGE_READONLY           EQUATE(02h)
PAGE_READWRITE          EQUATE(04h)
PAGE_WRITECOPY          EQUATE(08h)
PAGE_EXECUTE            EQUATE(10h)
PAGE_EXECUTE_READ       EQUATE(20h)
PAGE_EXECUTE_READWRITE  EQUATE(40h)
PAGE_EXECUTE_WRITECOPY  EQUATE(80h)
PAGE_GUARD              EQUATE(100h)
PAGE_NOCACHE            EQUATE(200h)
MEM_COMMIT              EQUATE(1000h)
MEM_RESERVE             EQUATE(2000h)
MEM_DECOMMIT            EQUATE(4000h)
MEM_RELEASE             EQUATE(8000h)
MEM_FREE                EQUATE(10000h)
MEM_PRIVATE             EQUATE(20000h)
MEM_MAPPED              EQUATE(40000h)
MEM_RESET               EQUATE(80000h)
MEM_TOP_DOWN            EQUATE(100000h)
SEC_FILE                EQUATE(800000h)
SEC_IMAGE               EQUATE(1000000h)
SEC_RESERVE             EQUATE(4000000h)
SEC_COMMIT              EQUATE(8000000h)
SEC_NOCACHE             EQUATE(10000000h)

WSADESCRIPTION_LEN      EQUATE(256)
WSASYS_STATUS_LEN       EQUATE(128)

SOCKET_ERROR            EQUATE(-1)

WSAData                 GROUP,TYPE
wVersion                  SHORT
wHighVersion              SHORT
szDescription             CSTRING(WSADESCRIPTION_LEN + 1)
szSystemStatus            CSTRING(WSASYS_STATUS_LEN + 1)
iMaxSockets               UNSIGNED
iMaxUdpDg                 UNSIGNED
lpVendorInfo              LONG
                        END

SOCKET                  EQUATE(LONG)
WSAEVENT                EQUATE(HANDLE)

INVALID_SOCKET          EQUATE(-1)

SOCKET_ADDRESS          GROUP,TYPE
lpSockaddr                LONG
iSockaddrLength           SIGNED
                        END

SOCKADDR                GROUP,TYPE
sa_family                 SHORT
sa_data                   STRING(14)
                        END

in_addr                 GROUP,TYPE
s_b1                      BYTE
s_b2                      BYTE
s_b3                      BYTE
s_b4                      BYTE
S_addr                    LONG
                        END

SOCKADDR_IN             GROUP,TYPE
sin_family                SHORT
sin_port                  SHORT
sin_addr                  LIKE(in_addr)
sin_zero                  BYTE,DIM(8)
                        END

CSADDR_INFO             GROUP,TYPE
LocalAddr                 GROUP(SOCKET_ADDRESS).
RemoteAddr                GROUP(SOCKET_ADDRESS).
iSocketType               SIGNED
iProtocol                 SIGNED
                        END

PROTOCOL_INFO           GROUP,TYPE
dwServiceFlags            LONG
iAddressFamily            SIGNED
iMaxSockAddr              SIGNED
iMinSockAddr              SIGNED
iSocketType               SIGNED
iProtocol                 SIGNED
dwMessageSize             LONG
lpszProtocol              LONG
                        END

WSAPROTOCOL_LEN         EQUATE(255)
MAX_PROTOCOL_CHAIN      EQUATE(7)

BASE_PROTOCOL           EQUATE(1)
LAYERED_PROTOCOL        EQUATE(0)

WSAPROTOCOLCHAIN        GROUP,TYPE
ChainLen                  LONG                              ! the length of the chain,
                                                            ! length = 0 means layered protocol,
                                                            ! length = 1 means base protocol,
                                                            ! length > 1 means protocol chain
ChainEntries              LONG,DIM(MAX_PROTOCOL_CHAIN)      ! a list of dwCatalogEntryIds
                        END

GUID                    GROUP,TYPE
Data1                     LONG
Data2                     SHORT
Data3                     SHORT
Data4                     BYTE,DIM(8)
Data4Str                  STRING(8),OVER(Data4)
                        END

CLSID                   GROUP(GUID),TYPE.
REFCLSID                EQUATE(LONG)
REFIID                  EQUATE(LONG)

WSAPROTOCOL_INFOA       GROUP,TYPE
dwServiceFlags1           LONG
dwServiceFlags2           LONG
dwServiceFlags3           LONG
dwServiceFlags4           LONG
dwProviderFlags           LONG
ProviderId                GROUP(GUID).
dwCatalogEntryId          LONG
ProtocolChain             LIKE(WSAPROTOCOLCHAIN)
iVersion                  LONG
iAddressFamily            LONG
iMaxSockAddr              LONG
iMinSockAddr              LONG
iSocketType               LONG
iProtocol                 LONG
iProtocolMaxOffset        LONG
iNetworkByteOrder         LONG
iSecurityScheme           LONG
dwMessageSize             LONG
dwProviderReserved        LONG
szProtocol                STRING(WSAPROTOCOL_LEN + 1)
                        END

! Types

SOCK_STREAM             EQUATE(1)               ! stream socket
SOCK_DGRAM              EQUATE(2)               ! datagram socket
SOCK_RAW                EQUATE(3)               ! raw-protocol interface
SOCK_RDM                EQUATE(4)               ! reliably-delivered message
SOCK_SEQPACKET          EQUATE(5)               ! sequenced packet stream

! Protocols

IPPROTO_IP              EQUATE(0)               ! dummy for IP
IPPROTO_ICMP            EQUATE(1)               ! control message protocol
IPPROTO_IGMP            EQUATE(2)               ! internet group management protocol
IPPROTO_GGP             EQUATE(3)               ! gateway^2 (deprecated)
IPPROTO_TCP             EQUATE(6)               ! tcp
IPPROTO_PUP             EQUATE(12)              ! pup
IPPROTO_UDP             EQUATE(17)              ! user datagram protocol
IPPROTO_IDP             EQUATE(22)              ! xns idp
IPPROTO_ND              EQUATE(77)              ! UNOFFICIAL net disk proto

IPPROTO_RAW             EQUATE(255)             ! raw IP packet
IPPROTO_MAX             EQUATE(256)

! Port/socket numbers: network standard functions

IPPORT_ECHO             EQUATE(7)
IPPORT_DISCARD          EQUATE(9)
IPPORT_SYSTAT           EQUATE(11)
IPPORT_DAYTIME          EQUATE(13)
IPPORT_NETSTAT          EQUATE(15)
IPPORT_FTP              EQUATE(21)
IPPORT_TELNET           EQUATE(23)
IPPORT_SMTP             EQUATE(25)
IPPORT_TIMESERVER       EQUATE(37)
IPPORT_NAMESERVER       EQUATE(42)
IPPORT_WHOIS            EQUATE(43)
IPPORT_MTP              EQUATE(57)


! Option flags per-socket.

SO_DEBUG                EQUATE(01h)             ! turn on debugging info recording
SO_ACCEPTCONN           EQUATE(02h)             ! socket has had listen()
SO_REUSEADDR            EQUATE(04h)             ! allow local address reuse
SO_KEEPALIVE            EQUATE(08h)             ! keep connections alive
SO_DONTROUTE            EQUATE(010h)            ! just use interface addresses
SO_BROADCAST            EQUATE(020h)            ! permit sending of broadcast msgs
SO_USELOOPBACK          EQUATE(040h)            ! bypass hardware when possible
SO_LINGER               EQUATE(080h)            ! linger on close if data present
SO_OOBINLINE            EQUATE(0100h)           ! leave received OOB data in line

! Additional options.

SO_SNDBUF               EQUATE(01001h)          ! send buffer size
SO_RCVBUF               EQUATE(01002h)          ! receive buffer size
SO_SNDLOWAT             EQUATE(01003h)          ! send low-water mark
SO_RCVLOWAT             EQUATE(01004h)          ! receive low-water mark
SO_SNDTIMEO             EQUATE(01005h)          ! send timeout
SO_RCVTIMEO             EQUATE(01006h)          ! receive timeout
SO_ERROR                EQUATE(01007h)          ! get error status and clear
SO_TYPE                 EQUATE(01008h)          ! get socket type

! WinSock 2 extension -- new options

SO_GROUP_ID             EQUATE(02001h)          ! ID of a socket group
SO_GROUP_PRIORITY       EQUATE(02002h)          ! the relative priority within a group
SO_MAX_MSG_SIZE         EQUATE(02003h)          ! maximum message size

! WinSock 2 extension -- manifest constants for shutdown()

SD_RECEIVE              EQUATE(00h)
SD_SEND                 EQUATE(01h)
SD_BOTH                 EQUATE(02h)

! TCP options.

TCP_NODELAY             EQUATE(01h)

! Address families.

AF_UNSPEC               EQUATE(0)               ! unspecified

! Although  AF_UNSPEC  is  defined for backwards compatibility, using
! AF_UNSPEC for the "af" parameter when creating a socket is STRONGLY
! DISCOURAGED.    The  interpretation  of  the  "protocol"  parameter
! depends  on the actual address family chosen.  As environments grow
! to  include  more  and  more  address families that use overlapping
! protocol  values  there  is  more  and  more  chance of choosing an
! undesired address family when AF_UNSPEC is used.

AF_UNIX                 EQUATE(1)               ! local to host (pipes, portals)
AF_INET                 EQUATE(2)               ! internetwork: UDP, TCP, etc.
AF_IMPLINK              EQUATE(3)               ! arpanet imp addresses
AF_PUP                  EQUATE(4)               ! pup protocols: e.g. BSP
AF_CHAOS                EQUATE(5)               ! mit CHAOS protocols
AF_NS                   EQUATE(6)               ! XEROX NS protocols
AF_IPX                  EQUATE(AF_NS)           ! IPX protocols: IPX, SPX, etc.
AF_ISO                  EQUATE(7)               ! ISO protocols
AF_OSI                  EQUATE(AF_ISO)          ! OSI is ISO
AF_ECMA                 EQUATE(8)               ! european computer manufacturers
AF_DATAKIT              EQUATE(9)               ! datakit protocols
AF_CCITT                EQUATE(10)              ! CCITT protocols, X.25 etc
AF_SNA                  EQUATE(11)              ! IBM SNA
AF_DECnet               EQUATE(12)              ! DECnet
AF_DLI                  EQUATE(13)              ! Direct data link interface
AF_LAT                  EQUATE(14)              ! LAT
AF_HYLINK               EQUATE(15)              ! NSC Hyperchannel
AF_APPLETALK            EQUATE(16)              ! AppleTalk
AF_NETBIOS              EQUATE(17)              ! NetBios-style addresses
AF_VOICEVIEW            EQUATE(18)              ! VoiceView
AF_FIREFOX              EQUATE(19)              ! Protocols from Firefox
AF_UNKNOWN1             EQUATE(20)              ! Somebody is using this!
AF_BAN                  EQUATE(21)              ! Banyan
AF_ATM                  EQUATE(22)              ! Native ATM Services
AF_INET6                EQUATE(23)              ! Internetwork Version 6
AF_CLUSTER              EQUATE(24)              ! Microsoft Wolfpack
AF_12844                EQUATE(25)              ! IEEE 1284.4 WG AF

AF_MAX                  EQUATE(26)

! Maximum queue length specifiable by listen.

SOMAXCONN               EQUATE(5)

! Address Family/Protocol Tuples

AFPROTOCOLS             GROUP,TYPE
iAddressFamily            LONG
iProtocol                 LONG
                        END

! WinSock 2 extension -- bit values and indices for FD_XXX network events

FD_READ_BIT             EQUATE(0)
FD_READ                 EQUATE(01b)

FD_WRITE_BIT            EQUATE(1)
FD_WRITE                EQUATE(010b)

FD_OOB_BIT              EQUATE(2)
FD_OOB                  EQUATE(0100b)

FD_ACCEPT_BIT           EQUATE(3)
FD_ACCEPT               EQUATE(01000b)

FD_CONNECT_BIT          EQUATE(4)
FD_CONNECT              EQUATE(010000b)

FD_CLOSE_BIT            EQUATE(5)
FD_CLOSE                EQUATE(0100000b)

FD_QOS_BIT              EQUATE(6)
FD_QOS                  EQUATE(01000000b)

FD_GROUP_QOS_BIT        EQUATE(7)
FD_GROUP_QOS            EQUATE(010000000b)

FD_ROUTING_INTERFACE_CHANGE_BIT EQUATE(8)
FD_ROUTING_INTERFACE_CHANGE     EQUATE(0100000000b)

FD_ADDRESS_LIST_CHANGE_BIT      EQUATE(9)
FD_ADDRESS_LIST_CHANGE          EQUATE(01000000000b)

FD_MAX_EVENTS           EQUATE(10)
FD_ALL_EVENTS           EQUATE(01111111111b)

STATUS_WAIT_0           EQUATE(0h)
STATUS_USER_APC         EQUATE(0C0h)
STATUS_TIMEOUT          EQUATE(0102h)

INFINITE                EQUATE(0FFFFFFFFh)
WAIT_OBJECT_0           EQUATE(STATUS_WAIT_0)
WAIT_IO_COMPLETION      EQUATE(STATUS_USER_APC)
WAIT_TIMEOUT            EQUATE(STATUS_TIMEOUT)

WSA_WAIT_FAILED         EQUATE(-1)
WSA_WAIT_EVENT_0        EQUATE(WAIT_OBJECT_0)
WSA_WAIT_IO_COMPLETION  EQUATE(WAIT_IO_COMPLETION)
WSA_WAIT_TIMEOUT        EQUATE(WAIT_TIMEOUT)
WSA_INFINITE            EQUATE(INFINITE)


WSANETWORKEVENTS        GROUP,TYPE
lNetworkEvents            LONG
iErrorCode                SIGNED,DIM(FD_MAX_EVENTS)
                        END
SIZE_WSANETWORKEVENTS   EQUATE(SIZE(WSANETWORKEVENTS))

WSAQuerySetA            GROUP,TYPE
dwSize                    LONG
lpszServiceInstanceName   LONG
lpServiceClassId          LONG
lpVersion                 LONG
lpszComment               LONG
dwNameSpace               LONG
lpNSProviderId            LONG
lpszContext               LONG
dwNumberOfProtocols       LONG
lpafpProtocols            LONG
lpszQueryString           LONG
dwNumberOfCsAddrs         LONG
lpcsaBuffer               LONG
dwOutputFlags             LONG
lpBlob                    LONG
                        END

WSAQUERYSET             GROUP(WSAQuerySetA),TYPE.


! Resolution flags for GetAddressByName().

RES_SOFT_SEARCH         EQUATE(01h)
RES_FIND_MULTIPLE       EQUATE(02h)
RES_SERVICE             EQUATE(03h)

! All Windows Sockets error constants are biased by WSABASEERR from
! the "normal"

WSABASEERR              EQUATE(10000)

! Windows Sockets definitions of regular Microsoft C error constants

WSAEINTR                EQUATE(WSABASEERR + 4)
WSAEBADF                EQUATE(WSABASEERR + 9)
WSAEACCES               EQUATE(WSABASEERR + 13)
WSAEFAULT               EQUATE(WSABASEERR + 14)
WSAEINVAL               EQUATE(WSABASEERR + 22)
WSAEMFILE               EQUATE(WSABASEERR + 24)

! Windows Sockets definitions of regular Berkeley error constants

WSAEWOULDBLOCK          EQUATE(WSABASEERR + 35)
WSAEINPROGRESS          EQUATE(WSABASEERR + 36)
WSAEALREADY             EQUATE(WSABASEERR + 37)
WSAENOTSOCK             EQUATE(WSABASEERR + 38)
WSAEDESTADDRREQ         EQUATE(WSABASEERR + 39)
WSAEMSGSIZE             EQUATE(WSABASEERR + 40)
WSAEPROTOTYPE           EQUATE(WSABASEERR + 41)
WSAENOPROTOOPT          EQUATE(WSABASEERR + 42)
WSAEPROTONOSUPPORT      EQUATE(WSABASEERR + 43)
WSAESOCKTNOSUPPORT      EQUATE(WSABASEERR + 44)
WSAEOPNOTSUPP           EQUATE(WSABASEERR + 45)
WSAEPFNOSUPPORT         EQUATE(WSABASEERR + 46)
WSAEAFNOSUPPORT         EQUATE(WSABASEERR + 47)
WSAEADDRINUSE           EQUATE(WSABASEERR + 48)
WSAEADDRNOTAVAIL        EQUATE(WSABASEERR + 49)
WSAENETDOWN             EQUATE(WSABASEERR + 50)
WSAENETUNREACH          EQUATE(WSABASEERR + 51)
WSAENETRESET            EQUATE(WSABASEERR + 52)
WSAECONNABORTED         EQUATE(WSABASEERR + 53)
WSAECONNRESET           EQUATE(WSABASEERR + 54)
WSAENOBUFS              EQUATE(WSABASEERR + 55)
WSAEISCONN              EQUATE(WSABASEERR + 56)
WSAENOTCONN             EQUATE(WSABASEERR + 57)
WSAESHUTDOWN            EQUATE(WSABASEERR + 58)
WSAETOOMANYREFS         EQUATE(WSABASEERR + 59)
WSAETIMEDOUT            EQUATE(WSABASEERR + 60)
WSAECONNREFUSED         EQUATE(WSABASEERR + 61)
WSAELOOP                EQUATE(WSABASEERR + 62)
WSAENAMETOOLONG         EQUATE(WSABASEERR + 63)
WSAEHOSTDOWN            EQUATE(WSABASEERR + 64)
WSAEHOSTUNREACH         EQUATE(WSABASEERR + 65)
WSAENOTEMPTY            EQUATE(WSABASEERR + 66)
WSAEPROCLIM             EQUATE(WSABASEERR + 67)
WSAEUSERS               EQUATE(WSABASEERR + 68)
WSAEDQUOT               EQUATE(WSABASEERR + 69)
WSAESTALE               EQUATE(WSABASEERR + 70)
WSAEREMOTE              EQUATE(WSABASEERR + 71)

! Extended Windows Sockets error constant definitions

WSASYSNOTREADY          EQUATE(WSABASEERR + 91)
WSAVERNOTSUPPORTED      EQUATE(WSABASEERR + 92)
WSANOTINITIALISED       EQUATE(WSABASEERR + 93)
WSAEDISCON              EQUATE(WSABASEERR + 101)
WSAENOMORE              EQUATE(WSABASEERR + 102)
WSAECANCELLED           EQUATE(WSABASEERR + 103)
WSAEINVALIDPROCTABLE    EQUATE(WSABASEERR + 104)
WSAEINVALIDPROVIDER     EQUATE(WSABASEERR + 105)
WSAEPROVIDERFAILEDINIT  EQUATE(WSABASEERR + 106)
WSASYSCALLFAILURE       EQUATE(WSABASEERR + 107)
WSASERVICE_NOT_FOUND    EQUATE(WSABASEERR + 108)
WSATYPE_NOT_FOUND       EQUATE(WSABASEERR + 109)
WSA_E_NO_MORE           EQUATE(WSABASEERR + 110)
WSA_E_CANCELLED         EQUATE(WSABASEERR + 111)
WSAEREFUSED             EQUATE(WSABASEERR + 112)


! WinSock 2 extension -- new error codes

WSAEVENT                EQUATE(LONG)

WSA_IO_PENDING          EQUATE(997)
WSA_IO_INCOMPLETE       EQUATE(996)
WSA_INVALID_HANDLE      EQUATE(6)
WSA_INVALID_PARAMETER   EQUATE(87)
WSA_NOT_ENOUGH_MEMORY   EQUATE(8)
WSA_OPERATION_ABORTED   EQUATE(995)

WSA_INVALID_EVENT       EQUATE(0)
WSA_MAXIMUM_WAIT_EVENTS EQUATE(64)

! Authoritative Answer: Host not found

WSAHOST_NOT_FOUND       EQUATE(WSABASEERR + 1001)
HOST_NOT_FOUND          EQUATE(WSAHOST_NOT_FOUND)

! Non-Authoritative: Host not found, or SERVERFAIL

WSATRY_AGAIN            EQUATE(WSABASEERR + 1002)
TRY_AGAIN               EQUATE(WSATRY_AGAIN)

! Non-recoverable errors, FORMERR, REFUSED, NOTIMP

WSANO_RECOVERY          EQUATE(WSABASEERR + 1003)
NO_RECOVERY             EQUATE(WSANO_RECOVERY)

! Valid name, no data record of requested type

WSANO_DATA              EQUATE(WSABASEERR + 1004)
NO_DATA                 EQUATE(WSANO_DATA)

! no address, look for MX record

WSANO_ADDRESS           EQUATE(WSANO_DATA)
NO_ADDRESS              EQUATE(WSANO_ADDRESS)

! Define QOS related error return codes

WSA_QOS_RECEIVERS       EQUATE(WSABASEERR + 1005)
         ! at least one Reserve has arrived
WSA_QOS_SENDERS         EQUATE(WSABASEERR + 1006)
         ! at least one Path has arrived
WSA_QOS_NO_SENDERS      EQUATE(WSABASEERR + 1007)
         ! there are no senders
WSA_QOS_NO_RECEIVERS    EQUATE(WSABASEERR + 1008)
         ! there are no receivers
WSA_QOS_REQUEST_CONFIRMED EQUATE(WSABASEERR + 1009)
         ! Reserve has been confirmed
WSA_QOS_ADMISSION_FAILURE EQUATE(WSABASEERR + 1010)
         ! error due to lack of resources
WSA_QOS_POLICY_FAILURE    EQUATE(WSABASEERR + 1011)
         ! rejected for administrative reasons - bad credentials
WSA_QOS_BAD_STYLE         EQUATE(WSABASEERR + 1012)
         ! unknown or conflicting style
WSA_QOS_BAD_OBJECT        EQUATE(WSABASEERR + 1013)
         ! problem with some part of the filterspec or providerspecific
         ! buffer in general
WSA_QOS_TRAFFIC_CTRL_ERROR EQUATE(WSABASEERR + 1014)
         ! problem with some part of the flowspec
WSA_QOS_GENERIC_ERROR   EQUATE(WSABASEERR + 1015)
         ! general error

! Name Spaces

NS_DEFAULT              EQUATE(0)
NS_ALL                  EQUATE(0)

NS_SAP                  EQUATE(1)
NS_NDS                  EQUATE(2)
NS_PEER_BROWSE          EQUATE(3)

NS_TCPIP_LOCAL          EQUATE(10)
NS_TCPIP_HOSTS          EQUATE(11)
NS_DNS                  EQUATE(12)
NS_NETBT                EQUATE(13)
NS_WINS                 EQUATE(14)

NS_NBP                  EQUATE(20)

NS_MS                   EQUATE(30)
NS_STDA                 EQUATE(31)
NS_NTDS                 EQUATE(32)

NS_X500                 EQUATE(40)
NS_NIS                  EQUATE(41)

NS_VNS                  EQUATE(50)

! Name space attributes.

NSTYPE_HIERARCHICAL     EQUATE(00000001h)
NSTYPE_DYNAMIC          EQUATE(00000002h)
NSTYPE_ENUMERABLE       EQUATE(00000004h)
NSTYPE_WORKGROUP        EQUATE(00000008h)

! Service Resolution flags

LUP_DEEP                EQUATE(0001h)
LUP_CONTAINERS          EQUATE(0002h)
LUP_NOCONTAINERS        EQUATE(0004h)
LUP_NEAREST             EQUATE(0008h)
LUP_RETURN_NAME         EQUATE(0010h)
LUP_RETURN_TYPE         EQUATE(0020h)
LUP_RETURN_VERSION      EQUATE(0040h)
LUP_RETURN_COMMENT      EQUATE(0080h)
LUP_RETURN_ADDR         EQUATE(0100h)
LUP_RETURN_BLOB         EQUATE(0200h)
LUP_RETURN_ALIASES      EQUATE(0400h)
LUP_RETURN_QUERY_STRING EQUATE(0800h)
LUP_RETURN_ALL          EQUATE(0FF0h)
LUP_RES_SERVICE         EQUATE(8000h)

LUP_FLUSHCACHE          EQUATE(01000h)
LUP_FLUSHPREVIOUS       EQUATE(02000h)

! Transport attributes.

XP1_CONNECTIONLESS      EQUATE(000000001h)
XP1_GUARANTEED_DELIVERY EQUATE(000000002h)
XP1_GUARANTEED_ORDER    EQUATE(000000004h)
XP1_MESSAGE_ORIENTED    EQUATE(000000008h)
XP1_PSEUDO_STREAM       EQUATE(000000010h)
XP1_GRACEFUL_CLOSE      EQUATE(000000020h)
XP1_EXPEDITED_DATA      EQUATE(000000040h)
XP1_CONNECT_DATA        EQUATE(000000080h)
XP1_DISCONNECT_DATA     EQUATE(000000100h)
XP1_SUPPORT_BROADCAST   EQUATE(000000200h)
XP1_SUPPORT_MULTIPOINT  EQUATE(000000400h)
XP1_MULTIPOINT_CONTROL_PLANE EQUATE(000000800h)
XP1_MULTIPOINT_DATA_PLANE EQUATE(000001000h)
XP1_QOS_SUPPORTED       EQUATE(000002000h)
XP1_INTERRUPT           EQUATE(000004000h)
XP1_UNI_SEND            EQUATE(000008000h)
XP1_UNI_RECV            EQUATE(000010000h)
XP1_IFS_HANDLES         EQUATE(000020000h)
XP1_PARTIAL_MESSAGE     EQUATE(000040000h)

! HTTP Manifests

! the default major/minor HTTP version numbers

HTTP_MAJOR_VERSION      EQUATE(1)
HTTP_MINOR_VERSION      EQUATE(0)

HTTP_VERSION            ASTRING('HTTP/1.0')

! HttpQueryInfo info levels. Generally, there is one info level
! for each potential RFC822/HTTP/MIME header that an HTTP server
! may send as part of a request response.

! The HTTP_QUERY_RAW_HEADERS info level is provided for clients
! that choose to perform their own header parsing.

HTTP_QUERY_MIME_VERSION                 EQUATE(0)
HTTP_QUERY_CONTENT_TYPE                 EQUATE(1)
HTTP_QUERY_CONTENT_TRANSFER_ENCODING    EQUATE(2)
HTTP_QUERY_CONTENT_ID                   EQUATE(3)
HTTP_QUERY_CONTENT_DESCRIPTION          EQUATE(4)
HTTP_QUERY_CONTENT_LENGTH               EQUATE(5)
HTTP_QUERY_CONTENT_LANGUAGE             EQUATE(6)
HTTP_QUERY_ALLOW                        EQUATE(7)
HTTP_QUERY_PUBLIC                       EQUATE(8)
HTTP_QUERY_DATE                         EQUATE(9)
HTTP_QUERY_EXPIRES                      EQUATE(10)
HTTP_QUERY_LAST_MODIFIED                EQUATE(11)
HTTP_QUERY_MESSAGE_ID                   EQUATE(12)
HTTP_QUERY_URI                          EQUATE(13)
HTTP_QUERY_DERIVED_FROM                 EQUATE(14)
HTTP_QUERY_COST                         EQUATE(15)
HTTP_QUERY_LINK                         EQUATE(16)
HTTP_QUERY_PRAGMA                       EQUATE(17)
HTTP_QUERY_VERSION                      EQUATE(18)  ! special: part of status line
HTTP_QUERY_STATUS_CODE                  EQUATE(19)  ! special: part of status line
HTTP_QUERY_STATUS_TEXT                  EQUATE(20)  ! special: part of status line
HTTP_QUERY_RAW_HEADERS                  EQUATE(21)  ! special: all headers as ASCIIZ
HTTP_QUERY_RAW_HEADERS_CRLF             EQUATE(22)  ! special: all headers
HTTP_QUERY_CONNECTION                   EQUATE(23)
HTTP_QUERY_ACCEPT                       EQUATE(24)
HTTP_QUERY_ACCEPT_CHARSET               EQUATE(25)
HTTP_QUERY_ACCEPT_ENCODING              EQUATE(26)
HTTP_QUERY_ACCEPT_LANGUAGE              EQUATE(27)
HTTP_QUERY_AUTHORIZATION                EQUATE(28)
HTTP_QUERY_CONTENT_ENCODING             EQUATE(29)
HTTP_QUERY_FORWARDED                    EQUATE(30)
HTTP_QUERY_FROM                         EQUATE(31)
HTTP_QUERY_IF_MODIFIED_SINCE            EQUATE(32)
HTTP_QUERY_LOCATION                     EQUATE(33)
HTTP_QUERY_ORIG_URI                     EQUATE(34)
HTTP_QUERY_REFERER                      EQUATE(35)
HTTP_QUERY_RETRY_AFTER                  EQUATE(36)
HTTP_QUERY_SERVER                       EQUATE(37)
HTTP_QUERY_TITLE                        EQUATE(38)
HTTP_QUERY_USER_AGENT                   EQUATE(39)
HTTP_QUERY_WWW_AUTHENTICATE             EQUATE(40)
HTTP_QUERY_PROXY_AUTHENTICATE           EQUATE(41)
HTTP_QUERY_ACCEPT_RANGES                EQUATE(42)
HTTP_QUERY_SET_COOKIE                   EQUATE(43)
HTTP_QUERY_COOKIE                       EQUATE(44)
HTTP_QUERY_REQUEST_METHOD               EQUATE(45)  ! special: GET/POST etc.
HTTP_QUERY_REFRESH                      EQUATE(46)
HTTP_QUERY_CONTENT_DISPOSITION          EQUATE(47)

! HTTP 1.1 defined headers

HTTP_QUERY_AGE                          EQUATE(48)
HTTP_QUERY_CACHE_CONTROL                EQUATE(49)
HTTP_QUERY_CONTENT_BASE                 EQUATE(50)
HTTP_QUERY_CONTENT_LOCATION             EQUATE(51)
HTTP_QUERY_CONTENT_MD5                  EQUATE(52)
HTTP_QUERY_CONTENT_RANGE                EQUATE(53)
HTTP_QUERY_ETAG                         EQUATE(54)
HTTP_QUERY_HOST                         EQUATE(55)
HTTP_QUERY_IF_MATCH                     EQUATE(56)
HTTP_QUERY_IF_NONE_MATCH                EQUATE(57)
HTTP_QUERY_IF_RANGE                     EQUATE(58)
HTTP_QUERY_IF_UNMODIFIED_SINCE          EQUATE(59)
HTTP_QUERY_MAX_FORWARDS                 EQUATE(60)
HTTP_QUERY_PROXY_AUTHORIZATION          EQUATE(61)
HTTP_QUERY_RANGE                        EQUATE(62)
HTTP_QUERY_TRANSFER_ENCODING            EQUATE(63)
HTTP_QUERY_UPGRADE                      EQUATE(64)
HTTP_QUERY_VARY                         EQUATE(65)
HTTP_QUERY_VIA                          EQUATE(66)
HTTP_QUERY_WARNING                      EQUATE(67)

HTTP_QUERY_MAX                          EQUATE(67)

! HTTP Response Status Codes:

HTTP_STATUS_CONTINUE            EQUATE(100) ! OK to continue with request
HTTP_STATUS_SWITCH_PROTOCOLS    EQUATE(101) ! server has switched protocols in upgrade header

HTTP_STATUS_OK                  EQUATE(200) ! request completed
HTTP_STATUS_CREATED             EQUATE(201) ! object created, reason = new URI
HTTP_STATUS_ACCEPTED            EQUATE(202) ! async completion (TBS)
HTTP_STATUS_PARTIAL             EQUATE(203) ! partial completion
HTTP_STATUS_NO_CONTENT          EQUATE(204) ! no info to return
HTTP_STATUS_RESET_CONTENT       EQUATE(205) ! request completed, but clear form
HTTP_STATUS_PARTIAL_CONTENT     EQUATE(206) ! partial GET furfilled

HTTP_STATUS_AMBIGUOUS           EQUATE(300) ! server couldn't decide what to return
HTTP_STATUS_MOVED               EQUATE(301) ! object permanently moved
HTTP_STATUS_REDIRECT            EQUATE(302) ! object temporarily moved
HTTP_STATUS_REDIRECT_METHOD     EQUATE(303) ! redirection w/ new access method
HTTP_STATUS_NOT_MODIFIED        EQUATE(304) ! if-modified-since was not modified
HTTP_STATUS_USE_PROXY           EQUATE(305) ! redirection to proxy, location header specifies proxy to use
HTTP_STATUS_REDIRECT_KEEP_VERB  EQUATE(307) ! HTTP/1.1: keep same verb

HTTP_STATUS_BAD_REQUEST         EQUATE(400) ! invalid syntax
HTTP_STATUS_DENIED              EQUATE(401) ! access denied
HTTP_STATUS_PAYMENT_REQ         EQUATE(402) ! payment required
HTTP_STATUS_FORBIDDEN           EQUATE(403) ! request forbidden
HTTP_STATUS_NOT_FOUND           EQUATE(404) ! object not found
HTTP_STATUS_BAD_METHOD          EQUATE(405) ! method is not allowed
HTTP_STATUS_NONE_ACCEPTABLE     EQUATE(406) ! no response acceptable to client found
HTTP_STATUS_PROXY_AUTH_REQ      EQUATE(407) ! proxy authentication required
HTTP_STATUS_REQUEST_TIMEOUT     EQUATE(408) ! server timed out waiting for request
HTTP_STATUS_CONFLICT            EQUATE(409) ! user should resubmit with more info
HTTP_STATUS_GONE                EQUATE(410) ! the resource is no longer available
HTTP_STATUS_LENGTH_REQUIRED     EQUATE(411) ! the server refused to accept request w/o a length
HTTP_STATUS_PRECOND_FAILED      EQUATE(412) ! precondition given in request failed
HTTP_STATUS_REQUEST_TOO_LARGE   EQUATE(413) ! request entity was too large
HTTP_STATUS_URI_TOO_LONG        EQUATE(414) ! request URI too long
HTTP_STATUS_UNSUPPORTED_MEDIA   EQUATE(415) ! unsupported media type

HTTP_STATUS_SERVER_ERROR        EQUATE(500) ! internal server error
HTTP_STATUS_NOT_SUPPORTED       EQUATE(501) ! required not supported
HTTP_STATUS_BAD_GATEWAY         EQUATE(502) ! error response received from gateway
HTTP_STATUS_SERVICE_UNAVAIL     EQUATE(503) ! temporarily overloaded
HTTP_STATUS_GATEWAY_TIMEOUT     EQUATE(504) ! timed out waiting for gateway
HTTP_STATUS_VERSION_NOT_SUP     EQUATE(505) ! HTTP version not supported

HTTP_STATUS_FIRST               EQUATE(HTTP_STATUS_CONTINUE)
HTTP_STATUS_LAST                EQUATE(HTTP_STATUS_VERSION_NOT_SUP)

! WinInet Manifests

INTERNET_INVALID_PORT_NUMBER    EQUATE(0)
INTERNET_DEFAULT_FTP_PORT       EQUATE(21)
INTERNET_DEFAULT_GOPHER_PORT    EQUATE(70)
INTERNET_DEFAULT_HTTP_PORT      EQUATE(80)
INTERNET_DEFAULT_HTTPS_PORT     EQUATE(443)
INTERNET_DEFAULT_SOCKS_PORT     EQUATE(1080)

FILETIME                GROUP,TYPE
dwLowDateTime             LONG
dwHighDateTime            LONG
                        END

WIN32_FIND_DATA         GROUP,TYPE
dwFileAttributes          LONG
ftCreationTime            GROUP(FILETIME).
ftLastAccessTime          GROUP(FILETIME).
ftLastWriteTime           GROUP(FILETIME).
nFileSizeHigh             LONG
nFileSizeLow              LONG
dwReserved0               LONG
dwReserved1               LONG
cFileName                 STRING(_MAX_PATH)
cAlternateFileName        STRING(14)
                        END

! access types for InternetOpen()

INTERNET_OPEN_TYPE_PRECONFIG                    EQUATE(0)   ! use registry configuration
INTERNET_OPEN_TYPE_DIRECT                       EQUATE(1)   ! direct to net
INTERNET_OPEN_TYPE_PROXY                        EQUATE(3)   ! via named proxy
INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY  EQUATE(4)   ! prevent using java/script/INS


! Service Types for InternetConnect

INTERNET_SERVICE_URL    EQUATE(0)
INTERNET_SERVICE_FTP    EQUATE(1)
INTERNET_SERVICE_GOPHER EQUATE(2)
INTERNET_SERVICE_HTTP   EQUATE(3)

WININET_POST            ASTRING('POST')
WININET_GET             ASTRING('GET')

  MAP
    MODULE('WinApi')
GetModuleHandle     PROCEDURE(*CSTRING szModuleName),HMODULE,PASCAL,RAW,NAME('GetModuleHandleA')
PostMessage         PROCEDURE(HWND hWnd, UNSIGNED nMsg, UNSIGNED wParam, LONG lParam),BOOL,PASCAL,PROC,NAME('PostMessageA')
VirtualAlloc        PROCEDURE(LONG lpAddress, LONG dwSize, LONG flAllocationType, LONG flProtect),LONG,PASCAL
VirtualFree         PROCEDURE(LONG lpAddress, LONG dwSize, LONG dwFreeType),BOOL,PASCAL,PROC
MoveMemory          PROCEDURE(LONG DestinationPtr, LONG SourcePtr, LONG dwLength),BOOL,PROC,PASCAL,NAME('RtlMoveMemory')
FillMemory          PROCEDURE(LONG DestinationPtr, LONG dwLength, BYTE Value),PASCAL,NAME('RtlFillMemory')
ZeroMemory          PROCEDURE(LONG DestinationPtr, LONG dwLength),PASCAL,NAME('RtlZeroMemory')
IsBadReadPtr        PROCEDURE(LONG lp, LONG ucb),BOOL,PASCAL
lstrcpy             PROCEDURE(LONG DestinationPtr, LONG SourcePtr),LONG,PASCAL,RAW
lstrcat             PROCEDURE(LONG DestinationPtr, LONG SourcePtr),LONG,PASCAL,RAW
lstrcmp             PROCEDURE(LONG DestinationPtr, LONG SourcePtr),LONG,PASCAL,RAW
lstrlen             PROCEDURE(LONG SourcePtr),LONG,PASCAL,RAW
InitializeCriticalSection PROCEDURE(*CRITICAL_SECTION CriticalSection),RAW,PASCAL
EnterCriticalSection  PROCEDURE(*CRITICAL_SECTION CriticalSection),RAW,PASCAL
LeaveCriticalSection  PROCEDURE(*CRITICAL_SECTION CriticalSection),RAW,PASCAL
DeleteCriticalSection PROCEDURE(*CRITICAL_SECTION CriticalSection),RAW,PASCAL
CreateThread        PROCEDURE(<*SECURITY_ATTRIBUTES ThreadAttributes>, LONG dwStackSize, LONG lpStartAddress, LONG lpParameter, LONG dwCreationFlags, *LONG ThreadID),HANDLE,RAW,PASCAL
TerminateThread     PROCEDURE(LONG hThread, LONG dwExitCode),BOOL,PASCAL,PROC
ExitThread          PROCEDURE(LONG dwExitCode),PASCAL
WSAStartup          PROCEDURE(SHORT wVersionRequested, LONG lpWSAData),SIGNED,PASCAL
WSACleanup          PROCEDURE(),SIGNED,PASCAL
WSACreateEvent      PROCEDURE(),WSAEVENT,PASCAL,NAME('WSACreateEvent')
WSACloseEvent       PROCEDURE(WSAEVENT hEvent),BOOL,PROC,PASCAL,NAME('WSACloseEvent')
WSAEventSelect      PROCEDURE(SOCKET s, WSAEVENT hEvent, LONG NetworkEvents),SIGNED,PASCAL,NAME('WSAEventSelect')
WSAWaitForMultipleEvents  PROCEDURE(LONG cEvents, LONG lphEvents, BOOL fWaitAll, LONG dwTimeOut, BOOL fAlertable),LONG,PASCAL,NAME('WSAWaitForMultipleEvents')
WSAEnumNetworkEvents  PROCEDURE(SOCKET s, WSAEVENT hEventObject, LONG lpNetworkEvents),SIGNED,PASCAL,NAME('WSAEnumNetworkEvents')
WSAGetLastError     PROCEDURE(),SIGNED,PASCAL,NAME('WSAGetLastError')
WSAEnumProtocols    PROCEDURE(LONG lpiProtocols, LONG lpProtocolBuffer, LONG lpdwBufferLength),SIGNED,PASCAL,NAME('WSAEnumProtocolsA')
GetAddressByName    PROCEDURE(LONG dwNameSpace, LONG lpServiceType, <*CSTRING szServiceName>, LONG lpiProtocols, LONG dwResolution, LONG lplpServiceAsyncInfo, LONG lpCsAddrBuffer, LONG lpdwBufferLength, <*CSTRING szAliasBuffer>, LONG lpdwAliasBufferLength),LONG,RAW,PASCAL,NAME('GetAddressByNameA')
WSALookupServiceBegin PROCEDURE(LONG lpqsRestrictions, LONG dwControlFlags, LONG lphLookup),LONG,PASCAL,RAW,NAME('WSALookupServiceBeginA')
WSALookupServiceNext  PROCEDURE(LONG hLookup, LONG dwControlFlags, LONG lpdwBufferLength, LONG lpqsResults),LONG,PASCAL,RAW,NAME('WSALookupServiceNextA')
WSALookupServiceEnd PROCEDURE(LONG hLookup),LONG,PASCAL,PROC,NAME('WSALookupServiceEnd')
WSAGetServiceClassNameByClassId PROCEDURE(LONG lpServiceClassId, LONG lpszServiceClassName, LONG lpdwBufferLength),LONG,PASCAL,NAME('WSAGetServiceClassNameByClassIdA')
WSAHtons            PROCEDURE(SOCKET s, SHORT hostshort, *SHORT lpnetshort),SIGNED,RAW,PASCAL
CreateSocket        PROCEDURE(SIGNED af, SIGNED type, SIGNED protocol),SOCKET,PASCAL,NAME('socket')
CloseSocket         PROCEDURE(SOCKET s),SIGNED,PROC,PASCAL,NAME('closesocket')
Connect             PROCEDURE(SOCKET s, LONG lpName, SIGNED namelen),SIGNED,PASCAL,NAME('connect')
AcceptSocket        PROCEDURE(SOCKET s, LONG lpaddr = 0, SIGNED lpaddrlen = 0),SOCKET,PASCAL,NAME('accept')
SendData            PROCEDURE(SOCKET s, LONG lpstrBuffer, SIGNED dwlen, SIGNED flags),SIGNED,PASCAL,NAME('send')
ReceiveData         PROCEDURE(SOCKET s, LONG lpstrBuffer, SIGNED dwLen, SIGNED flags),SIGNED,PASCAL,NAME('recv')
WSARecv             PROCEDURE(SOCKET s, LONG lpBuffers, LONG dwBufferCount, *LONG lpNumberOfBytesRecvd, *LONG lpFlags, LONG lpOverlapped, LONG lpCompletionROUTINE),LONG,RAW,PASCAL
BindSocket          PROCEDURE(SOCKET s, LONG lpname, SIGNED namelen),SIGNED,RAW,PASCAL,NAME('bind')
Listen              PROCEDURE(SOCKET s, SIGNED backlog),SIGNED,PASCAL,NAME('listen')
GetHostName         PROCEDURE(*CSTRING szName, SIGNED NameLen),SIGNED,RAW,PASCAL,NAME('gethostname')
GetProtocolByName   PROCEDURE(*CSTRING szName),LONG,PASCAL,RAW,NAME('getprotobyname')
setsockopt          PROCEDURE(SOCKET s, SIGNED level, SIGNED optname, LONG lpszOptVal, SIGNED optlen),SIGNED,PASCAL
Shutdown            PROCEDURE(SOCKET s, LONG how),LONG,PASCAL,NAME('shutdown'),PROC
InternetOpen        PROCEDURE(*CSTRING szAgent, LONG dwAccessType, <*CSTRING szProxyName>, <*CSTRING ProxyBypass>, LONG dwFlags),LONG,RAW,PASCAL,NAME('InternetOpenA')
InternetCloseHandle PROCEDURE(LONG hINet),BOOL,PROC,PASCAL
InternetConnect     PROCEDURE(LONG hInternetSession, *CSTRING szServerName, LONG nServerPort, *CSTRING szUserName, *CSTRING szPassword, LONG dwService, LONG dwFlags, LONG dwContext),LONG,RAW,PASCAL,NAME('InternetConnectA')
InternetReadFile    PROCEDURE(LONG hInternetRequest, LONG lpBuffer, LONG dwNumberOfBytesToRead, *LONG NumberOfBytesToRead),BOOL,RAW,PASCAL,NAME('InternetReadFile')
HttpOpenRequest     PROCEDURE(LONG hInternetSession, *CSTRING szVerb, *CSTRING szObjectName, *CSTRING szVersion, *CSTRING szReferer, *CSTRING szAcceptTypes, LONG dwFlags, LONG dwContext),LONG,RAW,PASCAL,NAME('HttpOpenRequestA')
HttpSendRequest     PROCEDURE(LONG hInternetRequest, *CSTRING szHeaders, LONG dwHeadersLength, LONG lpOptional, LONG dwOptionalLength),LONG,RAW,PASCAL,NAME('HttpSendRequestA')
HttpQueryInfo       PROCEDURE(LONG hInternetRequest, LONG dwInfoLevel, LONG lpBuffer, *LONG dwBufferLength, *LONG dwIndex),LONG,RAW,PASCAL,NAME('HttpQueryInfoA')
FtpCommand          PROCEDURE(LONG hConnect, BOOL fExpectResponse, LONG dwFlags, *CSTRING szCommand, *LONG dwContext, *LONG hFtpCommand),BOOL,RAW,PASCAL,NAME('FtpCommandA')
FtpCreateDirectory  PROCEDURE(LONG hConnect, *CSTRING szDirectory),BOOL,RAW,PASCAL,NAME('FtpCreateDirectoryA')
FtpRemoveDirectory  PROCEDURE(LONG hConnect, *CSTRING szDirectory),BOOL,RAW,PASCAL,NAME('FtpRemoveDirectoryA')
FtpGetCurrentDirectory  PROCEDURE(LONG hConnect, *CSTRING szCurrentDirectory, *LONG dwCurrentDirectory),BOOL,RAW,PASCAL,NAME('FtpGetCurrentDirectoryA')
FtpSetCurrentDirectory  PROCEDURE(LONG hConnect, *CSTRING szDirectory),BOOL,RAW,PASCAL,NAME('FtpSetCurrentDirectoryA')
FtpPutFile          PROCEDURE(LONG hConnect, *CSTRING szLocalFile, *CSTRING szNewRemoteFile, LONG dwFlags, *LONG dwContext),BOOL,RAW,PASCAL,NAME('FtpPutFileA')
FtpGetFileSize      PROCEDURE(LONG hFile, *LONG dwFileSizeHigh),LONG,RAW,PASCAL,NAME('FtpGetFileSize')
FtpGetFile          PROCEDURE(LONG hConnect, *CSTRING szRemoteFile, *CSTRING szNewFile, BOOL fFailIfExists, LONG dwFlagsAndAttributes, LONG dwFlags, *LONG dwContext),BOOL,RAW,PASCAL,NAME('FtpGetFileA')
FtpOpenFile         PROCEDURE(LONG hConnect, *CSTRING szFileName, LONG dwAccess, LONG dwFlags, *LONG dwContext),LONG,RAW,PASCAL,NAME('FtpOpenFileA')
FtpRenameFile       PROCEDURE(LONG hConnect, *CSTRING szExisting, *CSTRING szNew),BOOL,RAW,PASCAL,NAME('FtpRenameFileA')
FtpDeleteFile       PROCEDURE(LONG hConnect, *CSTRING szFileName),BOOL,RAW,PASCAL,NAME('FtpDeleteFileA')
FtpFindFirstFile    PROCEDURE(LONG hConnect, *CSTRING lpszSearchFile, *WIN32_FIND_DATA lpFindFileData, LONG dwFlags, *LONG dwContext),LONG,RAW,PASCAL,NAME('FtpFindFirstFileA')
InternetFindNextFile  PROCEDURE(LONG hFind, *WIN32_FIND_DATA lpFindFileData),BOOL,RAW,PASCAL,NAME('InternetFindNextFileA')
MessageBox          PROCEDURE(LONG hwnd, LONG lpszMessage, LONG lpszTitle, LONG dwFlags),BOOL,PASCAL,NAME('MessageBoxA'),PROC
    END
  END

  _EndOfInclude_




