HKEY_CLASSES_ROOT           EQUATE(80000000h)
HKEY_CURRENT_USER           EQUATE(80000001h)
HKEY_LOCAL_MACHINE          EQUATE(80000002h)
HKEY_USERS                  EQUATE(80000003h)
HKEY_PERFORMANCE_DATA       EQUATE(80000004h)
HKEY_CURRENT_CONFIG         EQUATE(80000005h)
HKEY_DYN_DATA               EQUATE(80000006h)

REG_NONE                     EQUATE( 0 )   !!// No value type
REG_SZ                       EQUATE( 1 )   !!// Unicode nul terminated string
REG_EXPAND_SZ                EQUATE( 2 )   !!// Unicode nul terminated string
                                           !!// (with environment variable references)
REG_BINARY                   EQUATE( 3 )   !!// Free form binary
REG_DWORD                    EQUATE( 4 )   !!// 32-bit number
REG_DWORD_LITTLE_ENDIAN      EQUATE( 4 )   !!// 32-bit number (same as REG_DWORD)
REG_DWORD_BIG_ENDIAN         EQUATE( 5 )   !!// 32-bit number
REG_LINK                     EQUATE( 6 )   !!// Symbolic Link (unicode)
REG_MULTI_SZ                 EQUATE( 7 )   !!// Multiple Unicode strings
REG_RESOURCE_LIST            EQUATE( 8 )   !!// Resource list in the resource map
REG_FULL_RESOURCE_DESCRIPTOR EQUATE( 9 )   !!// Resource list in the hardware description
REG_RESOURCE_REQUIREMENTS_LIST EQUATE( 10 )


FILE_DATE_LAST_WRITE        EQUATE(0)
FILE_DATE_CREATED           EQUATE(1)
FILE_DATE_LAST_ACCESS       EQUATE(2)
