OMIT('_EndOfInclude_',_ICLayoutPresent_)
_ICLayoutPresent_ EQUATE(1)

INCLUDE('ICHTML.INC')

HtmlItemClass        CLASS,TYPE,MODULE('ICLAYOUT.CLW'),LINK('ICLAYOUT',LinkBaseClasses),DLL(BaseClassDllMode),DLL(BaseClassDllMode)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
GetCellAttributes      PROCEDURE(*HtmlClass),STRING,VIRTUAL
GetPosition            PROCEDURE(*SIGNED x, *SIGNED y, *SIGNED w, *SIGNED h),VIRTUAL
Kill                   PROCEDURE,VIRTUAL
                     END

CellQueue            QUEUE,TYPE
Item                   &HtmlItemClass
                     END

LayoutCellClass      CLASS,TYPE,MODULE('ICLAYOUT.CLW'),DLL(BaseClassDllMode)
GetCellAttributes      PROCEDURE,STRING
Init                   PROCEDURE
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

RangeClass           CLASS,TYPE,MODULE('ICLAYOUT.CLW'),DLL(BaseClassDllMode)
AddPoint               PROCEDURE(SIGNED Offset, SIGNED extent, *BYTE IsNew, SIGNED Delta),SIGNED
Init                   PROCEDURE
Kill                   PROCEDURE

Bounds                 &RangeQueue
                     END



LayoutHtmlClass      CLASS,TYPE,MODULE('ICLAYOUT.CLW'),DLL(BaseClassDllMode)
AddCell                PROCEDURE(SIGNED), PRIVATE
AddColumn              PROCEDURE(SIGNED), PRIVATE
AddRow                 PROCEDURE(SIGNED), PRIVATE
CreateHtml             PROCEDURE(*HtmlClass)
CreateWhitespace       PROCEDURE(SIGNED Yindex),PRIVATE
Init                   PROCEDURE(STRING Style, SIGNED SnapX, SIGNED SnapY)
Insert                 PROCEDURE(*HtmlItemClass item)
Kill                   PROCEDURE
Optimize               PROCEDURE,PRIVATE
SetCell                PROCEDURE(SIGNED Xpos, SIGNED Ypos),*LayoutCellClass,PROC

SnapX                  SIGNED
SnapY                  SIGNED
ExpandWhitespace       BYTE
Rows                   &RowQueue,PRIVATE
RangeX                 &RangeClass,PRIVATE
RangeY                 &RangeClass,PRIVATE
Style                  CSTRING(100)
                     END

_EndOfInclude_
