  MEMBER

BaseClassDllMode     EQUATE(0)

  INCLUDE('ICSTD.EQU')
  INCLUDE('ICEVENT.INC')

  MAP
  .


JslEventsClass.AddEvent               PROCEDURE(SIGNED EventNo, STRING Letter)

  CODE
  SELF.EventQ.EventNo = EventNo
  SELF.EventQ.Letter = Letter
  ADD(SELF.EventQ, +SELF.EventQ.Letter)


JslEventsClass.Init                   PROCEDURE

  CODE
  SELF.EventQ &= NEW EventInfoQueue
  SELF.AddEvent(EVENT:ScrollBottom, 'B')
  SELF.AddEvent(EVENT:PageDown, 'C')
  SELF.AddEvent(EVENT:ScrollDown, 'D')
  SELF.AddEvent(EVENT:Expanding, 'E')
  SELF.AddEvent(EVENT:Initialize, 'I')
  SELF.AddEvent(EVENT:AlertKey, 'K')
  SELF.AddEvent(EVENT:Locate, 'L')
  SELF.AddEvent(EVENT:Contracting, 'O')
  SELF.AddEvent(EVENT:ScrollDrag, 'M')
  SELF.AddEvent(EVENT:NewSelection, 'N')
  SELF.AddEvent(EVENT:PageUp, 'R')
  SELF.AddEvent(EVENT:ScrollTop, 'T')
  SELF.AddEvent(EVENT:ScrollUp, 'U')
  SELF.AddEvent(EVENT:Accepted, 'X')
  SELF.AddEvent(EVENT:Expanded, 'Y')
  SELF.AddEvent(EVENT:Contracted, 'Z')


JslEventsClass.Kill                   PROCEDURE
  CODE
  DISPOSE(SELF.EventQ)


JslEventsClass.GetEventString         PROCEDURE(EventActionQueue ActionQ, BYTE DefaultAction)

Result          CSTRING(200)
Index           SIGNED
Action          SIGNED

  CODE
  Result = ''
  LOOP Index = 1 TO RECORDS(SELF.EventQ)
    GET(SELF.EventQ, Index)
    Action = DefaultAction
    ActionQ.EventNo = SELF.EventQ.EventNo
    GET(ActionQ, +ActionQ.EventNo)           ! ActionQ is sorted by event
    IF (~ERRORCODE())
      Action = ActionQ.Action
    END
    IF (Result)
      Result = Result & '|'
    END
    Result = Result & SELF.EventQ.Letter & Action
  END
  RETURN Result


JslEventsClass.GetEventNumber        PROCEDURE(STRING Letter)

  CODE
  SELF.EventQ.Letter = Letter
  GET(SELF.EventQ, +SELF.EventQ.Letter)
  IF (ERRORCODE())
    RETURN EVENT:Accepted
  END
  RETURN SELF.EventQ.EventNo
