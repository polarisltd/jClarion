  MEMBER

  INCLUDE('WBSTD.EQU'),ONCE
  INCLUDE('ABTOOLBA.INC'),ONCE
  INCLUDE('WBSTD.INC'),ONCE


FEQBASE                 EQUATE(30000)
TOOLBAR:MIN             EQUATE(Toolbar:First)
TOOLBAR:MAX             EQUATE(Toolbar:Last)

IC:GetControlType       PROCEDURE (SIGNED Feq)

Type                 SIGNED

  CODE
  Type = Feq{PROP:type}
  IF (Type = CREATE:List) AND (Feq{PROP:drop})
    Type = CREATE:DropList
  ELSIF (Type = CREATE:Button)
    IF (Feq >= TOOLBAR:MIN) AND (Feq <= TOOLBAR:MAX)
      Type = CREATE:ToolButton
    ELSIF (NOT Feq{PROP:icon})
      Type = CREATE:TextButton
    END
  END
  RETURN Type


IC:Id2Feq               PROCEDURE(UNSIGNED Id)
  CODE
  RETURN BAND(Id, PAGEBASE-1) - FEQBASE


IC:Feq2Id               PROCEDURE(SIGNED Feq, SIGNED PageNumber)
  CODE
  RETURN (Feq + FEQBASE) + (PageNumber * PAGEBASE)


