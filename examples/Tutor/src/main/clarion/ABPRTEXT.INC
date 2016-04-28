!ABCIncludeFile(ABC)

OMIT('_EndOfInclude_',_TEXTReportGeneratorPresent_)
_TEXTReportGeneratorPresent_ EQUATE(1)

 INCLUDE('ABPRTARG.INC'),ONCE   ! TargetClass
 INCLUDE('ABRPATMG.INC'),ONCE   ! Attr Manager
 INCLUDE('ABRPTGEN.INT'),ONCE   ! IReportGenerator Interface
 INCLUDE('ABERROR.INC'),ONCE
MaxTextGeneratorLineLen EQUATE(500)
QueueRows   QUEUE,TYPE
Line            STRING(MaxTextGeneratorLineLen)
LineLen         SHORT
            END
TextGenerator    CLASS,MODULE('ABPRTEXT.CLW'),TYPE,LINK('ABPRTEXT.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Output                  &TargetGenerator
PageSize                BYTE
PageNo                  SHORT(0),PROTECTED
TotalPageNo             SHORT(0),PROTECTED
Rows                    &QueueRows,PROTECTED
PageOpen                BYTE,PROTECTED
PageLen                 BYTE(72)
InitialMargin           BYTE
TopMargin               BYTE
BottomMargin            BYTE
LeftMargin              BYTE
OmitRowOverflow         BYTE
CheckBoxString          STRING(3),PROTECTED
UnCheckBoxString        STRING(3),PROTECTED
RadioButtonString       STRING(3),PROTECTED
UnRadioButtonString     STRING(3),PROTECTED
LVLine                  STRING(1),PROTECTED
RVLine                  STRING(1),PROTECTED
THLine                  STRING(1),PROTECTED
BHLine                  STRING(1),PROTECTED
LTCorner                STRING(1),PROTECTED
RTCorner                STRING(1),PROTECTED
LBCorner                STRING(1),PROTECTED
RBCorner                STRING(1),PROTECTED
TextFill                STRING(1),DIM(5),PROTECTED
PagesAsDifferentFile    BYTE,PRIVATE
Init                    PROCEDURE(<STRING TargetFileName>),VIRTUAL
Setup                   PROCEDURE(),VIRTUAL
SetPageSize             PROCEDURE(SHORT pPageType,USHORT pWidth=0,USHORT pHeight=0)
SetPageLen              PROCEDURE(BYTE pPageLen)
SetMargin               PROCEDURE(BYTE pInitialMargin=0,BYTE pTopMargin=0,BYTE pBottomMargin=0,BYTE pLeftMargin=0)
SetInitialMargin        PROCEDURE(BYTE pInitialMargin)
SetTopMargin            PROCEDURE(BYTE pTopMargin)
SetBottomMargin         PROCEDURE(BYTE pBottomMargin)
SetLeftMargin           PROCEDURE(BYTE pLeftMargin)
SetFileName             PROCEDURE(STRING pFileName)
SetPagesAsDifferentFile PROCEDURE(BYTE pTrue=1)
CONSTRUCT               PROCEDURE()
DESTRUCT                PROCEDURE()
DrawText                PROCEDURE(USHORT pCol,USHORT pRow,STRING pText)
InsertText              PROCEDURE(USHORT pCol,USHORT pRow,STRING pText)
DrawLine                PROCEDURE(USHORT pCol,USHORT pRow,USHORT Width ,USHORT Height,BYTE pTopOrLeft=1)
DrawBox                 PROCEDURE(USHORT pCol,USHORT pRow,USHORT Width ,USHORT Height,<STRING Fill>)
DrawEllipse             PROCEDURE(USHORT pCol,USHORT pRow,USHORT Width ,USHORT Height,<STRING Fill>)
OpenDocument            PROCEDURE()
CloseDocument           PROCEDURE()
StartPage               PROCEDURE()
EndPage                 PROCEDURE()
FlushPages              PROCEDURE(),PROTECTED
InchToRow               PROCEDURE(USHORT pInch),USHORT
InchToCol               PROCEDURE(USHORT pInch),USHORT
ColorToTextFill         PROCEDURE(LONG pColor),BYTE
SetCheckBoxString       PROCEDURE(STRING pChecked,STRING pUnChecked)
SetRadioButtonString    PROCEDURE(STRING pSelected,STRING pUnSelected)
SetLineString           PROCEDURE(STRING pLVLine,STRING pRVLine,STRING pTHLine,STRING pBHLine,STRING pLTCorner,STRING pRTCorner,STRING pLBCorner,STRING pRBCorner)
SetTextFillString       PROCEDURE(STRING pTextFill1,STRING pTextFill2,STRING pTextFill3,STRING pTextFill4,STRING pTextFill5)
                      END

TextReportGenerator    CLASS(TextGenerator),IMPLEMENTS(IReportGenerator),MODULE('ABPRTEXT.CLW'),TYPE,LINK('ABPRTEXT.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Attribute               &ReportAttributeManager,PROTECTED
OutputFileQueue         &OutputFileQueue,PROTECTED
OmitGraph               BYTE,PRIVATE
SetOmitGraph            PROCEDURE(BYTE pValue),PROTECTED
CONSTRUCT               PROCEDURE()
DESTRUCT                PROCEDURE()
                       END

 _EndOfInclude_
