!ABCIncludeFile(HITS)

  OMIT('_EndOfInclude_', _HitsPresent_)
_HitsPresent_ EQUATE(1)

  INCLUDE('ABWINDOW.INC'),ONCE
  INCLUDE('ABUTIL.INC'),ONCE
  INCLUDE('EQUATES.CLW'),ONCE


HitFile         INTERFACE
Close             PROCEDURE
GetCount          PROCEDURE(ASTRING Tag),LONG
Open              PROCEDURE(ASTRING Filename)
TakeTag           PROCEDURE(ASTRING Tag, LONG Count)
                END


WbHitFileINIClass CLASS(INIClass),IMPLEMENTS(HitFile),TYPE,MODULE('WBHITS.CLW'),LINK('WBHITS',_HitsLinkMode_),DLL(_HitsDllMode_)
lLock             PROCEDURE(ASTRING Itm),BYTE,PRIVATE
lUnlock           PROCEDURE(ASTRING Itm),PRIVATE

Lock              PROCEDURE,BYTE,PROC,PROTECTED
Unlock            PROCEDURE,BYTE,PROC,PROTECTED
                END


WbHitManagerClass CLASS,TYPE,MODULE('WBHITS.CLW'),LINK('WBHITS',_HitsLinkMode_),DLL(_HitsDllMode_)
Cache             &HitCache,PRIVATE
HF                &HitFile,PRIVATE
Threshold         LONG,PRIVATE

GetTag            PROCEDURE(ASTRING Tag),BYTE,PROC,PRIVATE

Construct         PROCEDURE
Destruct          PROCEDURE,VIRTUAL

GetCount          PROCEDURE(ASTRING Tag),LONG
Init              PROCEDURE(HitFile HF, LONG UpdateThreshold = 10, <ASTRING Filename>)   !,EXTENDS
Kill              PROCEDURE
Take              PROCEDURE(ASTRING Tag)
WriteCache        PROCEDURE(ASTRING Tag, BYTE Force = False)
WriteHits         PROCEDURE(<ASTRING Tag>)
                END


WbHitCounterClass CLASS,IMPLEMENTS(WindowComponent),TYPE,MODULE('WBHITS.CLW'),LINK('WBHITS',_HitsLinkMode_),DLL(_HitsDllMode_)
Links             &LinksList,PRIVATE
HitManager        &WbHitManagerClass,PROTECTED
Filename          ASTRING,PRIVATE
MyName            ASTRING,PRIVATE

Construct         PROCEDURE
Destruct          PROCEDURE,VIRTUAL

AddLink           PROCEDURE(ASTRING LinkTag, LONG EventID = 0, LONG ControlID = 0)
GetCount          PROCEDURE(ASTRING LinkTag),LONG
GetFullTagName    PROCEDURE(ASTRING LinkTag),ASTRING
GetTag            PROCEDURE(LONG EventID = EVENT:OpenWindow, LONG ControlID = 0),ASTRING
Init              PROCEDURE(WbHitManagerClass HitManager, <ASTRING InstanceName>)   !,EXTENDS
Take              PROCEDURE(ASTRING Tag)
TryAddLink        PROCEDURE(ASTRING LinkTag, LONG EventID = 0, LONG ControlID = 0),BYTE,PROC
                END


  _EndOfInclude_
