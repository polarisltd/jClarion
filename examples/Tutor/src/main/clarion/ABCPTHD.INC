
!ABCIncludeFile

  OMIT('_EndOfInclude_', _CooperativeThreadingIncluded_)
_CooperativeThreadingIncluded_  EQUATE(1)

  INCLUDE('CWSYNCHC.INC'),ONCE

  MAP
  END


ThreadLocker      CLASS(Mutex),TYPE,MODULE('ABCPTHD.CLW'),LINK('ABCPTHD.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Wait                PROCEDURE                   !,EXTENDS
Release             PROCEDURE                   !,EXTENDS
                  END


CooperationClass  CLASS,TYPE,THREAD,MODULE('ABCPTHD.CLW'),LINK('ABCPTHD.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Preemptive          BYTE,PROTECTED
Locked              BYTE,PROTECTED

PreemptiveThread    PROCEDURE(BYTE newState)    !,EXTENDS
IsPreemptive        PROCEDURE,BYTE
IsLocked            PROCEDURE,BYTE
Wait                PROCEDURE                   !,EXTENDS
Release             PROCEDURE                   !,EXTENDS
                  END

  _EndOfInclude_


