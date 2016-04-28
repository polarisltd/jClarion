OMIT('_EndOfInclude_',_ICWindowPresent_)
_ICWindowPresent_ EQUATE(1)

INCLUDE('ICHTML.INC')
INCLUDE('ICLAYOUT.INC')
INCLUDE('ICEVENT.INC')
INCLUDE('ICCLIENT.INC')
INCLUDE('ICSERVER.INC')

                     ITEMIZE(32700),PRE(FEQ)
PSEUDO_START           EQUATE
Caption                EQUATE
Menubar                EQUATE
Toolbar                EQUATE
ClientArea             EQUATE
Close                  EQUATE
UNKNOWN                EQUATE
PSEUDO_END             EQUATE
                     END

                     ITEMIZE(0),PRE(CLOSE)
Never                  EQUATE
IfSystem               EQUATE
SystemNoButton         EQUATE
Always                 EQUATE
                     END

PROP:none            EQUATE(0)

                     ITEMIZE,PRE(DISABLE)
Hide                   EQUATE
OptHide                EQUATE
Show                   EQUATE
                     END

!- Helper Types -------------------------------------------------------------

Rect                 GROUP,TYPE
x                      SIGNED
y                      SIGNED
width                  SIGNED
height                 SIGNED
                     END

!- Frame management ---------------------------------------------------------

CREATEBUTTON:Disable EQUATE(1)
CREATEBUTTON:Hide    EQUATE(2)

REPLY:NONE           EQUATE(0)
REPLY:CYCLE          EQUATE(1)
REPLY:BREAK          EQUATE(2)

Global:AnonBase      EQUATE(-5000)

WebFrameClass        CLASS,TYPE,MODULE('ICWINDOW.CLW'),LINK('ICWINDOW',LinkBaseClasses),DLL(BaseClassDllMode)
CopyControlsToWindow   PROCEDURE(*WebWindowClass, BYTE MergeMenu, BYTE MergeTool),VIRTUAL
CopyControlToWindow    PROCEDURE(*WebWindowClass, SIGNED feq),PROTECTED
GetMenubarFeq          PROCEDURE,SIGNED
GetToolbarFeq          PROCEDURE,SIGNED
TakeEvent              PROCEDURE,SIGNED,VIRTUAL,PROC

FrameWindow            &WINDOW
MenubarFeq             SIGNED
ToolbarFeq             SIGNED
                     END


!- Control -----------------------------------------------------------------

! This is the base class that all window controls are derived from.

WebControlClass      CLASS(HtmlItemClass),TYPE,MODULE('ICWINDOW.CLW'),DLL(BaseClassDllMode)
BeforeResetControl     PROCEDURE,VIRTUAL
CreateColorParameters  PROCEDURE(*HtmlClass Target, BYTE AutoSpotLink=FALSE),PROTECTED
CreateForeColorParameter PROCEDURE(*HtmlClass Target),PROTECTED
CreateHtmlExtra        PROCEDURE(*HtmlClass),VIRTUAL
CreateCellContents     PROCEDURE(*HtmlClass),VIRTUAL,PROTECTED
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
CreateCellHeader       PROCEDURE(*HtmlClass Target),PROTECTED
CreateCellFooter       PROCEDURE(*HtmlClass Target),PROTECTED
CreateJslData          PROCEDURE(*JslManagerClass),VIRTUAL
CreateParams           PROCEDURE(*HtmlClass Target),VIRTUAL
DoSetChildDefaults     PROCEDURE,PROTECTED
GetAlignText           PROCEDURE,STRING
GetAppletType          PROCEDURE,STRING,VIRTUAL
GetBackgroundColor     PROCEDURE(LONG=COLOR:None),LONG,VIRTUAL
GetCanDisable          PROCEDURE,BYTE,VIRTUAL
GetCellAttributes      PROCEDURE(*HtmlClass),STRING,VIRTUAL
GetChoiceChanged       PROCEDURE,BYTE
GetIsChild             PROCEDURE(SIGNED Feq, SIGNED Type=0),SIGNED,VIRTUAL
GetEventAction         PROCEDURE(SIGNED EventNo),SIGNED,VIRTUAL
GetFont                PROCEDURE(*HtmlFontClass CurFont)
GetHasHotkey           PROCEDURE,BYTE,VIRTUAL
GetLevel               PROCEDURE,SIGNED
GetNameAttribute       PROCEDURE(*HtmlClass Target),STRING
GetParentBackgroundColor PROCEDURE(LONG Color=COLOR:None),LONG,VIRTUAL
GetPosition            PROCEDURE(*SIGNED,*SIGNED,*SIGNED,*SIGNED),VIRTUAL
GetQuotedText          PROCEDURE,STRING
GetTableAttributes     PROCEDURE,STRING,VIRTUAL
GetText                PROCEDURE,STRING,VIRTUAL
GetUseChanged          PROCEDURE,BYTE
GetVisible             PROCEDURE,BYTE,VIRTUAL
Init                   PROCEDURE(SIGNED, *WebWindowBaseClass),VIRTUAL
Kill                   PROCEDURE,VIRTUAL
PopFont                PROCEDURE(*HtmlClass Target),VIRTUAL
PushFont               PROCEDURE(*HtmlClass Target),VIRTUAL
RefreshDisabled        PROCEDURE(*JslManagerClass Target, SIGNED IsEnabled, *BYTE WasEnabled)
ResetFromQueue         PROCEDURE(BYTE How, LONG offset=0, LONG number=1),VIRTUAL
ResetControl           PROCEDURE(*SubmitItemClass), VIRTUAL
SetAutoSpotLink        PROCEDURE(BYTE),VIRTUAL
SetBorderWidth         PROCEDURE(SIGNED),VIRTUAL
SetBreakable           PROCEDURE(BYTE),VIRTUAL
SetChildDefaults       PROCEDURE,VIRTUAL
SetDescription         PROCEDURE(STRING),VIRTUAL
SetEventAction         PROCEDURE(SIGNED EventNo, BYTE Action),VIRTUAL
SetParentDefaults      PROCEDURE(*WebControlClass other, *Rect ParentPos),VIRTUAL
SetQueue               PROCEDURE(*QUEUE Source),VIRTUAL
UpdateCopyUse          PROCEDURE,PROTECTED
UpdateCopyChoice       PROCEDURE,PROTECTED

ActionOnAccept         BYTE
Container              &WebControlClass
DisabledAction         BYTE
Feq                    SIGNED
IsDynamic              BYTE
LastChoice             SIGNED,PRIVATE
LastUseValue           ANY,PRIVATE
OwnerWindow            &WebWindowBaseClass
ParentFeq              SIGNED
RealParentFeq          SIGNED,PROTECTED
                     END


WebNullControlClass  CLASS(WebControlClass),TYPE,MODULE('ICWINDOW.CLW'),DLL(BaseClassDllMode)
CreateHtml             PROCEDURE(*HtmlClass),VIRTUAL
CreateJslData          PROCEDURE(*JslManagerClass),VIRTUAL
GetCellAttributes      PROCEDURE(*HtmlClass),STRING,VIRTUAL
GetAppletType          PROCEDURE,STRING,VIRTUAL
GetIsChild             PROCEDURE(SIGNED ParentFeq, SIGNED Type=0),SIGNED,VIRTUAL
GetVisible             PROCEDURE,BYTE,VIRTUAL
                     END


WebControlRefGroup   GROUP,TYPE
Control                &WebControlClass
                     END


!- Main Window --------------------------------------------------------------

WebControlListClass  CLASS,TYPE,MODULE('ICWINDOW.CLW'),DLL(BaseClassDllMode)
AddControlsToLayout    PROCEDURE(*WebControlQueue Source, *LayoutHtmlClass Layout),VIRTUAL
CreateHtmlExtra        PROCEDURE(*WebControlQueue Source, *HtmlClass),VIRTUAL
CreateHtml             PROCEDURE(*WebControlQueue Source, *HtmlClass, STRING, SIGNED, SIGNED)
CreateHtml             PROCEDURE(*WebControlQueue Source, *HtmlClass, STRING),VIRTUAL
Init                   PROCEDURE,VIRTUAL
Kill                   PROCEDURE,VIRTUAL
SetParentDefaults      PROCEDURE(*WebControlQueue Source, *WebControlClass Other, *Rect ParentPos)
                     END

! This is an abstract base class so the controls can have a reference to it.

WebWindowBaseClass   CLASS(WebControlListClass),TYPE,MODULE('ABSTRACT'),DLL(BaseClassDllMode)
CreateChildHtml        PROCEDURE(*HtmlClass, SIGNED, STRING),VIRTUAL
GetBackgroundColor     PROCEDURE(LONG Color=COLOR:None),LONG,VIRTUAL
GetBackgroundImage     PROCEDURE,STRING,VIRTUAL
GetControl             PROCEDURE(SIGNED Feq),BYTE,VIRTUAL
GetControl             PROCEDURE(SIGNED Feq, *WebControlRefGroup),VIRTUAL
GetCreateClose         PROCEDURE,BYTE,VIRTUAL
GetFirstChild          PROCEDURE(SIGNED Feq, SIGNED Type=0),SIGNED,VIRTUAL
GetChildren            PROCEDURE(*WebControlQueue, SIGNED Feq, SIGNED Type=0),VIRTUAL
GetHelpHandler         PROCEDURE,STRING,VIRTUAL
GetHelpReference       PROCEDURE,STRING,VIRTUAL
GetHelpTarget          PROCEDURE,STRING,VIRTUAL
GetMenubarFeq          PROCEDURE,SIGNED,VIRTUAL
GetPageImage           PROCEDURE,STRING,VIRTUAL
GetToolbarFeq          PROCEDURE,SIGNED,VIRTUAL
GetShowMenubar         PROCEDURE,BYTE,VIRTUAL
GetShowToolbar         PROCEDURE,BYTE,VIRTUAL
GetToolbarMode         PROCEDURE,SIGNED,VIRTUAL
GetWebActiveFrame      PROCEDURE,*WebFrameClass,VIRTUAL

AllowJava              BYTE
Background             LONG(COLOR:None)
BackImage              ANY
BorderWidth            BYTE
CloseImage             STRING(FILE:MaxFileName)
CreateCaption          BYTE
CreateClose            BYTE
CreateToolbar          BYTE
DefaultButton          SIGNED
DefaultButtonNeeded    BYTE
SnapX                  SIGNED
SnapY                  SIGNED
DisabledAction         BYTE
Files                  &WebFilesClass
FormatBorderWidth      BYTE
GroupBorderWidth       BYTE
HelpDocument           ANY
HelpEnabled            BYTE
HelpRelative           BYTE
HelpStyle              ANY
HtmlOption             LIKE(HtmlOptionGroup)
IsSplash               BYTE
MenubarFeq             SIGNED
MenubarType            SIGNED
OptionBorderWidth      BYTE
PageBackground         LONG
PageImage              ANY
Server                 &WebServerClass
SheetBorderWidth       BYTE
TimerAction            BYTE,PROTECTED
TimerDelay             SIGNED,PROTECTED
ToolbarFeq             SIGNED
                     END


!! The real implementation of a window...

WebControlQueue      QUEUE,TYPE
Feq                    SIGNED
ThisControl            &WebControlClass
                     END


WebWindowClass       CLASS(WebWindowBaseClass),TYPE,MODULE('ICWINDOW.CLW'),DLL(BaseClassDllMode)
AddControl             PROCEDURE(*WebControlClass NewItem)
AddControl             PROCEDURE(SIGNED, *WebControlClass NewItem)
AddControl             PROCEDURE(SIGNED, SIGNED=0),*WebControlClass,VIRTUAL,PROC
AddControlsToLayout    PROCEDURE(*LayoutHtmlClass Layout, SIGNED ParentFeq),VIRTUAL
BodyFooter             PROCEDURE(*HtmlClass),VIRTUAL
BodyHeader             PROCEDURE(*HtmlClass),VIRTUAL
CreateChildHtml        PROCEDURE(*HtmlClass, SIGNED, STRING),VIRTUAL
CreateDummyHtmlPage    PROCEDURE(*HtmlClass Target, STRING HtmlFilename)
CreateHtmlPage         PROCEDURE(*HtmlClass, STRING),VIRTUAL
CreateJslData          PROCEDURE(*JslManagerClass)
CreatePageFooter       PROCEDURE(*HtmlClass Target)
CreatePageHeader       PROCEDURE(*HtmlClass Target)
CreateUnauthorizedPage PROCEDURE(*HtmlClass Target, STRING HtmlFilename),VIRTUAL
GetAuthorized          PROCEDURE,BYTE
GetBackgroundColor     PROCEDURE(LONG Color=COLOR:None),LONG,VIRTUAL
GetBackgroundImage     PROCEDURE,STRING,VIRTUAL
GetButtonInClientArea  PROCEDURE,SIGNED
GetFirstChild          PROCEDURE(SIGNED ParentFeq, SIGNED Type=0),SIGNED,VIRTUAL
GetChildren            PROCEDURE(*WebControlQueue Target, SIGNED ParentFeq, SIGNED Type=0),VIRTUAL
GetControl             PROCEDURE(SIGNED Feq),BYTE,VIRTUAL
GetControl             PROCEDURE(SIGNED Feq, *WebControlRefGroup),VIRTUAL
GetControlInfo         PROCEDURE(SIGNED Feq),*WebControlClass,VIRTUAL
GetCreateClose         PROCEDURE,BYTE,VIRTUAL
GetHelpHandler         PROCEDURE,STRING,VIRTUAL
GetHelpReference       PROCEDURE,STRING,VIRTUAL
GetHelpTarget          PROCEDURE,STRING,VIRTUAL
GetMenubarFeq          PROCEDURE,SIGNED,VIRTUAL
GetPageImage           PROCEDURE,STRING,VIRTUAL
GetShowMenubar         PROCEDURE,BYTE,VIRTUAL
GetShowToolbar         PROCEDURE,BYTE,VIRTUAL
GetTableAttributes     PROCEDURE,STRING,VIRTUAL
GetTargetSecurity      PROCEDURE,SIGNED
GetToolbarFeq          PROCEDURE,SIGNED,VIRTUAL
GetToolbarMode         PROCEDURE,SIGNED,VIRTUAL
GetWebActiveFrame      PROCEDURE,*WebFrameClass,VIRTUAL
Init                   PROCEDURE(*WebServerClass, *HtmlClass, <STRING>)
Kill                   PROCEDURE,VIRTUAL
SuppressControl        PROCEDURE(SIGNED Feq)
ResetFromControls      PROCEDURE
SetBackground          PROCEDURE(LONG=COLOR:None, <STRING>)
SetCentered            PROCEDURE(BYTE center=TRUE)
SetChildDefaults       PROCEDURE
SetFormatOptions       PROCEDURE(SIGNED dx, SIGNED dy, SIGNED d2x, SIGNED d2y)
SetHelpDocument        PROCEDURE(STRING Filename, STRING Style)
SetHelpURL             PROCEDURE(STRING URL, STRING Style)
SetPageBackground      PROCEDURE(LONG=COLOR:None, <STRING>)
SetPassword            PROCEDURE(<STRING Password>, BYTE CaseSensitive=FALSE)
SetSplash              PROCEDURE(SIGNED TimerDelay)
SetTimer               PROCEDURE(SIGNED TimerDelay, SIGNED TimerUpdate)
TakeCreatePage         PROCEDURE,VIRTUAL
TakeEvent              PROCEDURE,BYTE,PROC,VIRTUAL
TakeRequest            PROCEDURE,VIRTUAL
TakeUnknownSubmit      PROCEDURE(STRING Name, STRING NewValue),VIRTUAL
TitleContents          PROCEDURE(*HtmlClass),VIRTUAL
ValidatePassword       PROCEDURE(STRING UserName, STRING Password),BYTE,VIRTUAL

PasswordCaseSensitive  BYTE,PRIVATE
Password               CSTRING(30),PRIVATE
Authorize              BYTE
AuthorizeArea          ANY
AuthorizeFailed        BYTE,PRIVATE
Controls               &WebControlQueue,PRIVATE
HtmlTarget             &HtmlClass
IsCentered             BYTE
IsSecure               BYTE
SentHtml               BYTE
WebActiveFrame         &WebFrameClass,PRIVATE
                     END

_EndOfInclude_
