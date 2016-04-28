!ABCIncludeFile
  OMIT('__EndOfInclude__',__CWCYNCHC_INC)

__CWSYNCHC_INC  EQUATE(1)

                  INCLUDE('CWSYNCH.INT'),ONCE

CriticalProcedure CLASS,MODULE('CWSYNCHC.CLW'),LINK('CWSYNCHC.CLW',_ABCLinkMode_),DLL(_ABCDllMode_),TYPE
Sync                &ISyncObject,PRIVATE

Construct           PROCEDURE()
Destruct            PROCEDURE()
Init                PROCEDURE(*ISyncObject O)
Kill                PROCEDURE()
                  END

CriticalSection CLASS,MODULE('CWSYNCHC.CLW'),LINK('CWSYNCHC.CLW',_ABCLinkMode_),DLL(_ABCDllMode_),TYPE
CS                  &ICriticalSection,PRIVATE

Construct           PROCEDURE()
Destruct            PROCEDURE()
Wait                PROCEDURE()
Release             PROCEDURE()
GetIFace            PROCEDURE(),*ISyncObject
                  END

Mutex         CLASS,MODULE('CWSYNCHC.CLW'),LINK('CWSYNCHC.CLW',_ABCLinkMode_),DLL(_ABCDllMode_),TYPE
M                   &IMutex,PRIVATE

Construct           PROCEDURE()
Destruct            PROCEDURE()
Wait                PROCEDURE()
TryWait             PROCEDURE(LONG milliseconds),SIGNED,PROC
Release             PROCEDURE()
Release             PROCEDURE(SIGNED Count)
HandleOf            PROCEDURE(),UNSIGNED
GetIFace            PROCEDURE(),*ISyncObject
                    END

Semaphore     CLASS,MODULE('CWSYNCHC.CLW'),LINK('CWSYNCHC.CLW',_ABCLinkMode_),DLL(_ABCDllMode_),TYPE
S                   &ISemaphore,PRIVATE

Construct           PROCEDURE()
Destruct            PROCEDURE()
Wait                PROCEDURE()
TryWait             PROCEDURE(LONG milliseconds),SIGNED,PROC
Release             PROCEDURE()
Release             PROCEDURE(SIGNED Count)
HandleOf            PROCEDURE(),UNSIGNED
GetIFace            PROCEDURE(),*ISyncObject
                    END

! __EndOfInclude__
