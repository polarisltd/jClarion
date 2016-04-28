OMIT('_EndOfInclude_',_AbDocLayoutPresent_)
_AbDocLayoutPresent_ EQUATE(1)

  INCLUDE('IDOC.INC'),ONCE
  INCLUDE('ABDOCLAY.INC'),ONCE

CellQueue            QUEUE,TYPE
Item                   IDocIdType
                     END


LayoutCellClass      CLASS,TYPE,MODULE('ABDOCLAY.CLW'),LINK('ABDOCLAY', _ABCLinkMode_),DLL(_ABCDllMode_)
ApplyCellAttributes    PROCEDURE(IDocumentCreate ICreate, IDocIdType Id)
GetItem                PROCEDURE(SIGNED Index),IDocIdType
Init                   PROCEDURE   !,EXTENDS
Kill                   PROCEDURE

dx                     SIGNED(0)
dy                     SIGNED(0)
SpanX                  SIGNED(1)
SpanY                  SIGNED(1)
Skip                   BYTE(FALSE)
Contents               &CellQueue
                     END


ColumnQueue          QUEUE,TYPE
Cell                   &LayoutCellClass
                     END

RowQueue             QUEUE,TYPE
Columns                &ColumnQueue
                     END

RangeQueue           QUEUE,TYPE
MaxExtent              SIGNED
Maximum                SIGNED
Minimum                SIGNED
                     END

RangeClass           CLASS,TYPE,MODULE('ABDOCLAY.CLW'),LINK('ABDOCLAY', _ABCLinkMode_),DLL(_ABCDllMode_)
AddPoint               PROCEDURE(SIGNED Offset, SIGNED extent, *BYTE IsNew, SIGNED Delta),SIGNED
Init                   PROCEDURE   !,EXTENDS
Kill                   PROCEDURE

Bounds                 &RangeQueue
                     END



LayoutClass      CLASS,TYPE,MODULE('ABDOCLAY.CLW'),LINK('ABDOCLAY', _ABCLinkMode_),DLL(_ABCDllMode_)
ICreate                &IDocumentCreate,PRIVATE

AddCell                PROCEDURE(SIGNED), PRIVATE
AddColumn              PROCEDURE(SIGNED), PRIVATE
AddRow                 PROCEDURE(SIGNED), PRIVATE
CreateWhitespace       PROCEDURE(SIGNED Yindex),PRIVATE
Init                   PROCEDURE(IDocumentCreate ICreate)   !,EXTENDS
Insert                 PROCEDURE(IDocIdType Id, LONG x, LONG y, LONG dx, LONG dy)
Kill                   PROCEDURE
Layout                 PROCEDURE(IDocIdType Id)
Optimize               PROCEDURE,PRIVATE
SetCell                PROCEDURE(SIGNED Xpos, SIGNED Ypos),*LayoutCellClass,PROC
SetSnap                PROCEDURE(SIGNED SnapX, SIGNED SnapY)

SnapX                  SIGNED
SnapY                  SIGNED
ExpandWhitespace       BYTE
Rows                   &RowQueue,PRIVATE
RangeX                 &RangeClass,PRIVATE
RangeY                 &RangeClass,PRIVATE
                     END

_EndOfInclude_
