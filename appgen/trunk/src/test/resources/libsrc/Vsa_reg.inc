
!ABCIncludeFile

OMIT('_EndOfInclude_',_vsRegistryPresent_)
_vsRegistryPresent_ EQUATE(1)

! Equates

HKEY_CLASSES_ROOT                EQUATE(080000000H)
HKEY_CURRENT_USER                EQUATE(080000001H)
HKEY_LOCAL_MACHINE               EQUATE(080000002H)
HKEY_USERS                       EQUATE(080000003H)

!DELETE                          EQUATE(00010000H)
READ_CONTROL                     EQUATE(00020000H)
!WRITE_DAC                       EQUATE(00040000H)
!WRITE_OWNER                     EQUATE(00080000H)
SYNCHRONIZE                     EQUATE(00100000H)
STANDARD_RIGHTS_REQUIRED         EQUATE(000F0000H)
STANDARD_RIGHTS_READ             EQUATE(READ_CONTROL)
STANDARD_RIGHTS_WRITE            EQUATE(READ_CONTROL)
STANDARD_RIGHTS_EXECUTE          EQUATE(READ_CONTROL)
STANDARD_RIGHTS_ALL              EQUATE(001F0000H)

KEY_QUERY_VALUE                  EQUATE(001H)
KEY_SET_VALUE                    EQUATE(002H)
KEY_CREATE_SUB_KEY               EQUATE(004H)
KEY_ENUMERATE_SUB_KEYS           EQUATE(008H)
KEY_NOTIFY                       EQUATE(010H)
KEY_CREATE_LINK                  EQUATE(020H)

REG_NONE                         EQUATE(0)
REG_SZ                           EQUATE(1)
REG_EXPAND_SZ                    EQUATE(2)
REG_BINARY                       EQUATE(3)
REG_DWORD                        EQUATE(4)
REG_DWORD_LITTLE_ENDIAN          EQUATE(4)
REG_DWORD_BIG_ENDIAN             EQUATE(5)
REG_LINK                         EQUATE(6)
REG_MULTI_SZ                     EQUATE(7)
REG_RESOURCE_LIST                EQUATE(8)

KEY_READ                         EQUATE((STANDARD_RIGHTS_READ + |
                                           KEY_QUERY_VALUE + |
                                           KEY_ENUMERATE_SUB_KEYS + |
                                           KEY_NOTIFY) - |
                                           SYNCHRONIZE)
KEY_WRITE                        EQUATE((STANDARD_RIGHTS_WRITE + |
                                           KEY_SET_VALUE +|
                                           KEY_CREATE_SUB_KEY) - |
                                           SYNCHRONIZE)
KEY_EXECUTE                      EQUATE((KEY_READ) - |
                                          SYNCHRONIZE)
KEY_ALL_ACCESS                   EQUATE((STANDARD_RIGHTS_ALL + |
                                           KEY_QUERY_VALUE + |
                                           KEY_SET_VALUE + |
                                           KEY_CREATE_SUB_KEY + |
                                           KEY_ENUMERATE_SUB_KEYS + |
                                           KEY_NOTIFY + |
                                           KEY_CREATE_LINK) - |
                                           SYNCHRONIZE)

REG_OPTION_NON_VOLATILE                    EQUATE(000H) ! Key is preserved when system is rebooted
REG_OPTION_VOLATILE                        EQUATE(001H) ! Key is not preserved when system is rebooted

ERROR_SUCCESS                              EQUATE(0)
ERROR_NO_MORE_ITEMS                        EQUATE(259)
!NULL                                      EQUATE(0)

tRegValueQ      QUEUE,TYPE
ValueName         STRING(1024)             ! ValueName
Value             STRING(1024)             ! Value
                END

vsRegistryClass               CLASS,TYPE,MODULE('VSA_REG.CLW'),LINK('VSA_REG.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
! Properties
QuietMode                       BYTE
! Error-related properties
LastOp                          STRING(255)
LastError                       STRING(255)
LastKeyName                     STRING(255)
! Other properties
Q                               &tRegValueQ

!
! Methods
Init                            PROCEDURE(LONG QuietMode=0)
Kill                            PROCEDURE

LoadQ                           PROCEDURE(LONG BaseKey,STRING KeyName)
!LoadQStr                       PROCEDURE(STRING BaseKey,STRING KeyName)
LoadQ                           PROCEDURE(tRegValueQ pQueue,LONG BaseKey,STRING KeyName)
! Standard format of parameters - HKEY, Key name, value name, value
Fetch                           PROCEDURE(LONG BaseKey,STRING KeyName,STRING ValueName),STRING
Fetch                           PROCEDURE(LONG BaseKey,STRING KeyName,STRING ValueName,STRING DefaultValue),STRING
Update                          PROCEDURE(LONG BaseKey,STRING KeyName,STRING ValueName,STRING Value)
Remove                          PROCEDURE(LONG BaseKey,STRING KeyName,STRING ValueName)
Remove                          PROCEDURE(LONG BaseKey,STRING KeyName)
!! Standard format of parameters - HKEY as a string, Key name, value name, value
!FetchStr                       PROCEDURE(STRING BaseKey,STRING KeyName,STRING ValueName),STRING
!FetchStr                       PROCEDURE(STRING BaseKey,STRING KeyName,STRING ValueName,STRING DefaultValue),STRING
!UpdateStr                      PROCEDURE(STRING BaseKey,STRING KeyName,STRING ValueName,STRING Value)
!RemoveStr                      PROCEDURE(STRING BaseKey,STRING KeyName,STRING ValueName)
!RemoveStr                      PROCEDURE(STRING BaseKey,STRING KeyName)
! GETINI/PUTINI-style format of parameters - Key name, value name, value, HKEY
GetValue                        PROCEDURE(STRING KeyName,STRING ValueName,LONG BaseKey),STRING
GetValue                        PROCEDURE(STRING KeyName,STRING ValueName,STRING DefaultValue,LONG BaseKey),STRING
PutValue                        PROCEDURE(STRING KeyName,STRING ValueName,STRING Value,LONG BaseKey)
DeleteValue                     PROCEDURE(STRING KeyName,STRING ValueName,LONG BaseKey)
DeleteValue                     PROCEDURE(STRING KeyName,LONG BaseKey)
!! GETINI/PUTINI-style format of parameters - Key name, value name, value, HKEY as a STRING
!GetStr                         PROCEDURE(STRING KeyName,STRING ValueName,STRING BaseKey),STRING
!GetStr                         PROCEDURE(STRING KeyName,STRING ValueName,STRING DefaultValue,STRING BaseKey),STRING
!PutStr                         PROCEDURE(STRING KeyName,STRING ValueName,STRING Value,STRING BaseKey)
!DeleteStr                      PROCEDURE(STRING KeyName,STRING ValueName,STRING BaseKey)
!DeleteStr                      PROCEDURE(STRING KeyName,LONG BaseKey)
!! Other
ThrowError                      PROCEDURE(STRING KeyName,STRING Op)
StringToHKEY                    PROCEDURE(STRING pText),LONG
GetRegUserName                  PROCEDURE,STRING
GetEmailRoot                    PROCEDURE,STRING
GetEmailName                    PROCEDURE,STRING
GetEmailAddress                 PROCEDURE,STRING
GetEmailReplyToAddress          PROCEDURE,STRING
GetEmailServer                  PROCEDURE,STRING
                              END

_EndOfInclude_
