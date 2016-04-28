OMIT('_EndOfInclude_',_ICEventPresent_)
_ICEventPresent_ EQUATE(1)

EventInfoQueue       QUEUE,TYPE
EventNo                SIGNED
Letter                 STRING(1)
                     END

EventActionQueue     QUEUE,TYPE
EventNo                SIGNED
Action                 BYTE
                     END

JslEventsClass       CLASS,MODULE('ICEVENT.CLW'),LINK('ICEVENT',LinkBaseClasses),TYPE,DLL(BaseClassDllMode)
AddEvent               PROCEDURE(SIGNED, STRING)
Init                   PROCEDURE
Kill                   PROCEDURE
GetEventNumber         PROCEDURE(STRING Letter),SIGNED
GetEventString         PROCEDURE(EventActionQueue, BYTE),STRING

EventQ                 &EventInfoQueue,PRIVATE
                     END

_EndOfInclude_
