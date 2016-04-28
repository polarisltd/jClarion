OMIT('_EndOfInclude_',_ICCntrlsPresent_)
_ICCntrlsPresent_ EQUATE(1)

INCLUDE('ICWINDOW.INC')
INCLUDE('ICHTML.INC')
INCLUDE('ICLAYOUT.INC')
INCLUDE('ICEVENT.INC')
INCLUDE('ICCLIENT.INC')
INCLUDE('ICSERVER.INC')

                     ITEMIZE,PRE(ACTION)
Insert                 EQUATE
Delete                 EQUATE
Replace                EQUATE
DeleteAll              EQUATE
Scroll                 EQUATE
ScrollDown             EQUATE
ScrollUp               EQUATE
                     END

!! Classes that implement the areas of the window (e.g. toolbar, menu)

WebAreaClass         CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),LINK('ICCNTRLS',LinkBaseClasses),DLL(BaseClassDllMode)
GetBackgroundColor     PROCEDURE(LONG=COLOR:None),LONG,VIRTUAL
GetCellAttributes      PROCEDURE(*HtmlClass),STRING,VIRTUAL
GetFont                PROCEDURE(*HtmlFontClass CurFont)
GetVisible             PROCEDURE,BYTE,VIRTUAL
Init                   PROCEDURE(SIGNED, *WebWindowBaseClass),VIRTUAL
Kill                   PROCEDURE,VIRTUAL
PushFont               PROCEDURE(*HtmlClass Target),VIRTUAL
SetBackground          PROCEDURE(LONG=COLOR:None, <STRING>)
SetFont                PROCEDURE(<STRING Face>, SIGNED Size=0, LONG Color=COLOR:None, SIGNED Style=0)
SetParentDefaults      PROCEDURE(*WebControlClass Other, *Rect ParentPos),VIRTUAL

Background             LONG(COLOR:None)
BackImage              ANY
LocalFont              &HtmlFontClass
                     END

WebCaptionClass      CLASS(WebAreaClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
GetCellAttributes      PROCEDURE(*HtmlClass),STRING,VIRTUAL
GetPosition            PROCEDURE(*SIGNED,*SIGNED,*SIGNED,*SIGNED),VIRTUAL
GetText                PROCEDURE,STRING,VIRTUAL
GetVisible             PROCEDURE,BYTE,VIRTUAL
Init                   PROCEDURE(SIGNED, *WebWindowBaseClass),VIRTUAL

Alignment              SIGNED
                     END

WebMenubarClass      CLASS(WebAreaClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
GetPosition            PROCEDURE(*SIGNED,*SIGNED,*SIGNED,*SIGNED),VIRTUAL
GetVisible             PROCEDURE,BYTE,VIRTUAL
Init                   PROCEDURE(SIGNED, *WebWindowBaseClass),VIRTUAL
                     END

WebToolbarClass      CLASS(WebAreaClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
GetAppletType          PROCEDURE,STRING,VIRTUAL
GetPosition            PROCEDURE(*SIGNED,*SIGNED,*SIGNED,*SIGNED),VIRTUAL
GetVisible             PROCEDURE,BYTE,VIRTUAL
                     END

WebClientAreaClass   CLASS(WebAreaClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
GetBackgroundColor     PROCEDURE(LONG=COLOR:None),LONG,VIRTUAL
GetPosition            PROCEDURE(*SIGNED,*SIGNED,*SIGNED,*SIGNED),VIRTUAL
                     END

!- Different types of controls ---------------------------------------------

WebHtmlPromptClass   CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateCellContents     PROCEDURE(*HtmlClass),VIRTUAL
GetHasHotkey           PROCEDURE,BYTE,VIRTUAL
                     END

WebStringClass       CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
SetBreakable           PROCEDURE(BYTE),VIRTUAL

CanBreak               BYTE,PRIVATE
                     END

WebHtmlStringClass   CLASS(WebStringClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateCellContents     PROCEDURE(*HtmlClass),VIRTUAL
GetCellAttributes      PROCEDURE(*HtmlClass Target),STRING,VIRTUAL
                     END

WebJavaStringClass   CLASS(WebStringClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
CreateJslData          PROCEDURE(*JslManagerClass),VIRTUAL
CreateParams           PROCEDURE(*HtmlClass Target),VIRTUAL
GetAppletType          PROCEDURE,STRING,VIRTUAL
Init                   PROCEDURE(SIGNED, *WebWindowBaseClass),VIRTUAL
SetAutoSpotLink        PROCEDURE(BYTE),VIRTUAL

AutoSpotLink           BYTE,PROTECTED
LastText               ANY,PROTECTED
                     END

WebHtmlEntryClass    CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateCellContents     PROCEDURE(*HtmlClass),VIRTUAL
CreateJslData          PROCEDURE(*JslManagerClass),VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL
                     END

WebHtmlTextClass     CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateCellContents     PROCEDURE(*HtmlClass),VIRTUAL
CreateJslData          PROCEDURE(*JslManagerClass),VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL
                     END

WebHtmlCheckClass    CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
BeforeResetControl     PROCEDURE,VIRTUAL
CreateCellContents     PROCEDURE(*HtmlClass),VIRTUAL
CreateJslData          PROCEDURE(*JslManagerClass),VIRTUAL
GetHasHotkey           PROCEDURE,BYTE,VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL
                     END

WebHtmlOptionClass   CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
CreateJslData          PROCEDURE(*JslManagerClass),VIRTUAL
GetTableAttributes     PROCEDURE,STRING,VIRTUAL
Init                   PROCEDURE(SIGNED, *WebWindowBaseClass),VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL
SetBorderWidth         PROCEDURE(SIGNED),VIRTUAL

BorderWidth            BYTE
                     END

WebHtmlRadioClass    CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateCellContents     PROCEDURE(*HtmlClass),VIRTUAL
GetHasHotkey           PROCEDURE,BYTE,VIRTUAL
                     END

WebListClass         CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
GetBackgroundColor     PROCEDURE(LONG=COLOR:None),LONG,VIRTUAL
                     END

WebHtmlListClass     CLASS(WebListClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateCellContents     PROCEDURE(*HtmlClass),VIRTUAL
CreateJslData          PROCEDURE(*JslManagerClass),VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL
                     END

QueueActionQueue     QUEUE,TYPE
Action                 BYTE
NumItems               LONG
Offset                 LONG
                     END

WebJavaListClass     CLASS(WebListClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
SetQueue               PROCEDURE(*QUEUE Source),VIRTUAL
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
CreateJslData          PROCEDURE(*JslManagerClass),VIRTUAL
CreateParams           PROCEDURE(*HtmlClass Target),VIRTUAL
GetAppletType          PROCEDURE,STRING,VIRTUAL
GetEventAction         PROCEDURE(SIGNED EventNo),SIGNED,VIRTUAL
Init                   PROCEDURE(SIGNED, *WebWindowBaseClass),VIRTUAL
Kill                   PROCEDURE,VIRTUAL
ResetFromQueue         PROCEDURE(BYTE How, LONG offset=0, LONG number=1),VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL
SetAutoSpotLink        PROCEDURE(BYTE),VIRTUAL
SetDirty               PROCEDURE
SetEventAction         PROCEDURE(SIGNED EventNo, BYTE Action),VIRTUAL
UpdateState            PROCEDURE

AutoSpotLink           BYTE,PROTECTED
Changes                LONG,PRIVATE
Width                  SIGNED,PRIVATE
Height                 SIGNED,PRIVATE
EventActionQ           &EventActionQueue
FirstPage              BYTE,PRIVATE
Format                 ULONG
FromQ                  &QUEUE
LastFormat             ANY,PRIVATE
LastHScroll            BYTE,PRIVATE
LastVScroll            BYTE,PRIVATE
QueueActionQ           &QueueActionQueue,PROTECTED
SendIcons              BYTE,PRIVATE
Started                BYTE(FALSE),PROTECTED
                     END

WebButtonClass       CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
Init                   PROCEDURE(SIGNED, *WebWindowBaseClass),VIRTUAL
BeforeResetControl     PROCEDURE,VIRTUAL
GetHasHotkey           PROCEDURE,BYTE,VIRTUAL
GetVisible             PROCEDURE,BYTE,VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL
                     END

WebJavaButtonClass   CLASS(WebButtonClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
Init                   PROCEDURE(SIGNED, *WebWindowBaseClass),VIRTUAL
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
CreateHtml             PROCEDURE(*HtmlClass,SIGNED,SIGNED),VIRTUAL
CreateJslData          PROCEDURE(*JslManagerClass),VIRTUAL
CreateParams           PROCEDURE(*HtmlClass Target),VIRTUAL
GetAppletType          PROCEDURE,STRING,VIRTUAL
GetCanDisable          PROCEDURE,BYTE,VIRTUAL
GetFilename            PROCEDURE,STRING,VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL

IsEnabled              BYTE
                     END

WebJavaToolButtonClass CLASS(WebJavaButtonClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
GetEventAction         PROCEDURE(SIGNED EventNo),SIGNED,VIRTUAL
                     END

WebHtmlButtonClass   CLASS(WebButtonClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateCellContents     PROCEDURE(*HtmlClass),VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL
                     END

WebMenuBaseClass     CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
GetHasHotkey           PROCEDURE,BYTE,VIRTUAL
GetPosition            PROCEDURE(*SIGNED,*SIGNED,*SIGNED,*SIGNED),VIRTUAL
GetText                PROCEDURE,STRING,VIRTUAL
SetParentDefaults      PROCEDURE(*WebControlClass Other, *Rect ParentPos),VIRTUAL
                     END

WebHtmlItemClass     CLASS(WebMenuBaseClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateCellContents     PROCEDURE(*HtmlClass),VIRTUAL
GetVisible             PROCEDURE,BYTE,VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL

                     END

WebHtmlMenuClass     CLASS(WebMenuBaseClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateCellContents     PROCEDURE(*HtmlClass),VIRTUAL
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
GetCellAttributes      PROCEDURE(*HtmlClass),STRING,VIRTUAL
GetVisible             PROCEDURE,BYTE,VIRTUAL
                     END

WebHtmlSheetClass    CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
CreateTabControl       PROCEDURE(*WebControlQueue TabControls, *HtmlClass Target, SIGNED Alignment, SIGNED SelectedTabFeq)
GetIsChild             PROCEDURE(SIGNED ParentFeq, SIGNED Type=0),SIGNED,VIRTUAL
GetTableAttributes     PROCEDURE,STRING,VIRTUAL
Init                   PROCEDURE(SIGNED, *WebWindowBaseClass),VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL
SetBorderWidth         PROCEDURE(SIGNED),VIRTUAL
SetChildDefaults       PROCEDURE, VIRTUAL

BorderWidth            BYTE
                     END

WebHtmlTabClass      CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
CreateJslData          PROCEDURE(*JslManagerClass),VIRTUAL
CreateParams           PROCEDURE(*HtmlClass Target),VIRTUAL
GetAppletType          PROCEDURE,STRING,VIRTUAL
GetIsChild             PROCEDURE(SIGNED ParentFeq, SIGNED Type=0),SIGNED,VIRTUAL
GetHasHotkey           PROCEDURE,BYTE,VIRTUAL
GetPosition            PROCEDURE(*SIGNED,*SIGNED,*SIGNED,*SIGNED),VIRTUAL
GetVisible             PROCEDURE,BYTE,VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL
SetParentDefaults      PROCEDURE(*WebControlClass Other, *Rect ParentPos),VIRTUAL

IsEnabled              BYTE
                     END

WebImageClass        CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
                     END

WebHtmlImageClass    CLASS(WebImageClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateCellContents     PROCEDURE(*HtmlClass),VIRTUAL
SetChildDefaults       PROCEDURE,VIRTUAL
SetDescription         PROCEDURE(STRING),VIRTUAL

AltText                CSTRING(255)
                     END

WebJavaImageClass    CLASS(WebImageClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
CreateJslData          PROCEDURE(*JslManagerClass),VIRTUAL
CreateParams           PROCEDURE(*HtmlClass Target),VIRTUAL
GetAppletType          PROCEDURE,STRING,VIRTUAL

Filename               CSTRING(FILE:MaxFileName)
                     END

WebHtmlGroupClass    CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
GetHasHotkey           PROCEDURE,BYTE,VIRTUAL
GetTableAttributes     PROCEDURE,STRING,VIRTUAL
Init                   PROCEDURE(SIGNED, *WebWindowBaseClass),VIRTUAL
SetBorderWidth         PROCEDURE(SIGNED),VIRTUAL

BorderWidth            BYTE
                     END

WebHtmlRegionClass   CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateHtmlExtra        PROCEDURE(*HtmlClass),VIRTUAL
SetParentDefaults      PROCEDURE(*WebControlClass other, *Rect ParentPos),VIRTUAL
                     END


!- Some special (pseudo) controls -------------------------------------------

WebCloseButtonClass  CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
Init                   PROCEDURE(SIGNED, *WebWindowBaseClass),VIRTUAL
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
CreateJslData          PROCEDURE(*JslManagerClass),VIRTUAL
CreateParams           PROCEDURE(*HtmlClass Target),VIRTUAL
GetAppletType          PROCEDURE,STRING,VIRTUAL
GetCloneFeq            PROCEDURE,SIGNED,VIRTUAL
GetPosition            PROCEDURE(*SIGNED,*SIGNED,*SIGNED,*SIGNED),VIRTUAL
GetVisible             PROCEDURE,BYTE,VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL

Width                  SIGNED
Height                 SIGNED
x                      SIGNED
y                      SIGNED
                     END

WebHotlinkClass      CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateCellContents     PROCEDURE(*HtmlClass),VIRTUAL
                     END


WebLiteralClass      CLASS(WebControlClass),TYPE,MODULE('ICCNTRLS.CLW'),DLL(BaseClassDllMode)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
GetCellAttributes      PROCEDURE(*HtmlClass),STRING,VIRTUAL
Text                   CSTRING(1000)
                     END

_EndOfInclude_
