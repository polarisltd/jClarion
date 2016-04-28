! Event numbers

! Field-specific events (FIELD() returns field number)

EVENT:Accepted      EQUATE (01H)
EVENT:NewSelection  EQUATE (02H)
EVENT:ScrollUp      EQUATE (03H)
EVENT:ScrollDown    EQUATE (04H)
EVENT:PageUp        EQUATE (05H)
EVENT:PageDown      EQUATE (06H)
EVENT:ScrollTop     EQUATE (07H)
EVENT:ScrollBottom  EQUATE (08H)
EVENT:Locate        EQUATE (09H)

EVENT:MouseDown     EQUATE (01H)
EVENT:MouseUp       EQUATE (0aH)
EVENT:MouseIn       EQUATE (0bH)
EVENT:MouseOut      EQUATE (0cH)
EVENT:MouseMove     EQUATE (0dH)
EVENT:VBXevent      EQUATE (0eH)
EVENT:AlertKey      EQUATE (0fH)
EVENT:PreAlertKey   EQUATE (10H)
EVENT:Dragging      EQUATE (11H)
EVENT:Drag          EQUATE (12H)
EVENT:Drop          EQUATE (13H)
EVENT:ScrollDrag    EQUATE (14H)
EVENT:TabChanging   EQUATE (15H)
EVENT:Expanding     EQUATE (16H)
EVENT:Contracting   EQUATE (17H)
EVENT:Expanded      EQUATE (18H)
EVENT:Contracted    EQUATE (19H)
EVENT:Rejected      EQUATE (1AH)
EVENT:DroppingDown  EQUATE (1BH)
EVENT:DroppedDown   EQUATE (1CH)
EVENT:ScrollTrack   EQUATE (1DH)
EVENT:ColumnResize  EQUATE (1EH)
EVENT:Selecting     EQUATE (1FH)

EVENT:Selected      EQUATE (101H)

! Field-independent events (FIELD() returns 0)

EVENT:CloseWindow   EQUATE (201H)
EVENT:CloseDown     EQUATE (202H)
EVENT:OpenWindow    EQUATE (203H)
EVENT:OpenFailed    EQUATE (204H)
EVENT:LoseFocus     EQUATE (205H)
EVENT:GainFocus     EQUATE (206H)

EVENT:Suspend       EQUATE (208H)
EVENT:Resume        EQUATE (209H)
EVENT:Notify        EQUATE (20AH)

EVENT:Timer         EQUATE (20BH)
EVENT:DDErequest    EQUATE (20CH)
EVENT:DDEadvise     EQUATE (20DH)
EVENT:DDEdata       EQUATE (20EH)
EVENT:DDEcommand    EQUATE (20FH)    ! same as DDEexecute
EVENT:DDEexecute    EQUATE (20FH)
EVENT:DDEpoke       EQUATE (210H)
EVENT:DDEclosed     EQUATE (211H)

EVENT:Move          EQUATE (220H)
EVENT:Size          EQUATE (221H)
EVENT:Restore       EQUATE (222H)
EVENT:Maximize      EQUATE (223H)
EVENT:Iconize       EQUATE (224H)
EVENT:Completed     EQUATE (225H)
EVENT:Moved         EQUATE (230H)
EVENT:Sized         EQUATE (231H)
EVENT:Restored      EQUATE (232H)
EVENT:Maximized     EQUATE (233H)
EVENT:Iconized      EQUATE (234H)
EVENT:Docked        EQUATE (235H)
EVENT:Undocked      EQUATE (236H)

EVENT:BuildFile     EQUATE (240H)
EVENT:BuildKey      EQUATE (241H)
EVENT:BuildDone     EQUATE (242H)

! User-definable events

EVENT:User          EQUATE (400H)
EVENT:Last          EQUATE (0FFFH)

STD:WindowList    EQUATE (1)
STD:TileWindow    EQUATE (2)
STD:CascadeWindow EQUATE (3)
STD:ArrangeIcons  EQUATE (4)
STD:HelpIndex     EQUATE (5)
STD:HelpOnHelp    EQUATE (6)
STD:HelpSearch    EQUATE (7)
STD:Help          EQUATE (8)
STD:Cut           EQUATE (10)
STD:Copy          EQUATE (11)
STD:Paste         EQUATE (12)
STD:Clear         EQUATE (13)
STD:Undo          EQUATE (14)
STD:Close         EQUATE (15)
STD:PrintSetup    EQUATE (16)
STD:TileHorizontal EQUATE (17)
STD:TileVertical   EQUATE (18)

CURSOR:None       EQUATE ('<0FFH,01H,00H,00H>')
CURSOR:Arrow      EQUATE ('<0FFH,01H,01H,7FH>')
CURSOR:IBeam      EQUATE ('<0FFH,01H,02H,7FH>')
CURSOR:Wait       EQUATE ('<0FFH,01H,03H,7FH>')
CURSOR:Cross      EQUATE ('<0FFH,01H,04H,7FH>')
CURSOR:UpArrow    EQUATE ('<0FFH,01H,05H,7FH>')
CURSOR:Size       EQUATE ('<0FFH,01H,81H,7FH>')
CURSOR:Icon       EQUATE ('<0FFH,01H,82H,7FH>')
CURSOR:SizeNWSE   EQUATE ('<0FFH,01H,83H,7FH>')
CURSOR:SizeNESW   EQUATE ('<0FFH,01H,84H,7FH>')
CURSOR:SizeWE     EQUATE ('<0FFH,01H,85H,7FH>')
CURSOR:SizeNS     EQUATE ('<0FFH,01H,86H,7FH>')
CURSOR:DragWE     EQUATE ('<0FFH,02H,01H,7FH>')
CURSOR:Drop       EQUATE ('<0FFH,02H,02H,7FH>')
CURSOR:NoDrop     EQUATE ('<0FFH,02H,03H,7FH>')
CURSOR:Zoom       EQUATE ('<0FFH,02H,04H,7FH>')

ICON:None         EQUATE ('<0FFH,01H,00H,00H>')
ICON:Application  EQUATE ('<0FFH,01H,01H,7FH>')
ICON:Hand         EQUATE ('<0FFH,01H,02H,7FH>')
ICON:Question     EQUATE ('<0FFH,01H,03H,7FH>')
ICON:Exclamation  EQUATE ('<0FFH,01H,04H,7FH>')
ICON:Asterisk     EQUATE ('<0FFH,01H,05H,7FH>')
ICON:Pick         EQUATE ('<0FFH,02H,01H,7FH>')
ICON:Save         EQUATE ('<0FFH,02H,02H,7FH>')
ICON:Print        EQUATE ('<0FFH,02H,03H,7FH>')
ICON:Paste        EQUATE ('<0FFH,02H,04H,7FH>')
ICON:Open         EQUATE ('<0FFH,02H,05H,7FH>')
ICON:New          EQUATE ('<0FFH,02H,06H,7FH>')
ICON:Help         EQUATE ('<0FFH,02H,07H,7FH>')
ICON:Cut          EQUATE ('<0FFH,02H,08H,7FH>')
ICON:Copy         EQUATE ('<0FFH,02H,09H,7FH>')
ICON:Child        EQUATE ('<0FFH,02H,0AH,7FH>')
ICON:Frame        EQUATE ('<0FFH,02H,0BH,7FH>')
ICON:Clarion      EQUATE ('<0FFH,02H,0CH,7FH>')
ICON:NoPrint      EQUATE ('<0FFH,02H,0DH,7FH>')
ICON:Zoom         EQUATE ('<0FFH,02H,0EH,7FH>')
ICON:NextPage     EQUATE ('<0FFH,02H,0FH,7FH>')
ICON:PrevPage     EQUATE ('<0FFH,02H,10H,7FH>')
ICON:JumpPage     EQUATE ('<0FFH,02H,11H,7FH>')
ICON:Thumbnail    EQUATE ('<0FFH,02H,12H,7FH>')
ICON:Tick         EQUATE ('<0FFH,02H,13H,7FH>')
ICON:Cross        EQUATE ('<0FFH,02H,14H,7FH>')
ICON:Connect      EQUATE ('<0FFH,02H,15H,7FH>')
ICON:Print1       EQUATE ('<0FFH,02H,16H,7FH>')
ICON:Ellipsis     EQUATE ('<0FFH,02H,17H,7FH>')

ICON:VCRtop         EQUATE ('<0FFH,02H,81H,7FH>')
ICON:VCRrewind      EQUATE ('<0FFH,02H,82H,7FH>')
ICON:VCRback        EQUATE ('<0FFH,02H,83H,7FH>')
ICON:VCRplay        EQUATE ('<0FFH,02H,84H,7FH>')
ICON:VCRfastforward EQUATE ('<0FFH,02H,85H,7FH>')
ICON:VCRbottom      EQUATE ('<0FFH,02H,86H,7FH>')
ICON:VCRlocate      EQUATE ('<0FFH,02H,87H,7FH>')


BEEP:SystemDefault      EQUATE (0000H)
BEEP:SystemHand         EQUATE (0010H)
BEEP:SystemQuestion     EQUATE (0020H)
BEEP:SystemExclamation  EQUATE (0030H)
BEEP:SystemAsterisk     EQUATE (0040H)

REJECT:RangeHigh        EQUATE(1)  ! Above top range on SPIN
REJECT:RangeLow         EQUATE(2)  ! below bottom range ditto
REJECT:Range            EQUATE(3)  ! Other range error
REJECT:Invalid          EQUATE(4)  ! Invalid input

INCLUDE 'property.clw'

COLOR:NONE              EQUATE (-1)
COLOR:SCROLLBAR         EQUATE (80000000H)
COLOR:BACKGROUND        EQUATE (80000001H)
COLOR:ACTIVECAPTION     EQUATE (80000002H)
COLOR:INACTIVECAPTION   EQUATE (80000003H)
COLOR:MENU              EQUATE (80000004H)
COLOR:WINDOW            EQUATE (80000005H)
COLOR:WINDOWFRAME       EQUATE (80000006H)
COLOR:MENUTEXT          EQUATE (80000007H)
COLOR:WINDOWTEXT        EQUATE (80000008H)
COLOR:CAPTIONTEXT       EQUATE (80000009H)
COLOR:ACTIVEBORDER      EQUATE (8000000AH)
COLOR:INACTIVEBORDER    EQUATE (8000000BH)
COLOR:APPWORKSPACE      EQUATE (8000000CH)
COLOR:HIGHLIGHT         EQUATE (8000000DH)
COLOR:HIGHLIGHTTEXT     EQUATE (8000000EH)
COLOR:BTNFACE           EQUATE (8000000FH)
COLOR:BTNSHADOW         EQUATE (80000010H)
COLOR:GRAYTEXT          EQUATE (80000011H)
COLOR:BTNTEXT           EQUATE (80000012H)
COLOR:INACTIVECAPTIONTEXT EQUATE (80000013H)
COLOR:BTNHIGHLIGHT        EQUATE (80000014H)

COLOR:Black             EQUATE (0000000H)
COLOR:Maroon            EQUATE (0000080H)
COLOR:Green             EQUATE (0008000H)
COLOR:Olive             EQUATE (0008080H)
COLOR:Orange            EQUATE (00080FFH)
COLOR:Navy              EQUATE (0800000H)
COLOR:Purple            EQUATE (0800080H)
COLOR:Teal              EQUATE (0808000H)
COLOR:Gray              EQUATE (0808080H)
COLOR:Silver            EQUATE (0C0C0C0H)
COLOR:Red               EQUATE (00000FFH)
COLOR:Lime              EQUATE (000FF00H)
COLOR:Yellow            EQUATE (000FFFFH)
COLOR:Blue              EQUATE (0FF0000H)
COLOR:Fuschia           EQUATE (0FF00FFH)
COLOR:Aqua              EQUATE (0FFFF00H)
COLOR:White             EQUATE (0FFFFFFH)

! Parameter to CREATE / Return value from PROP:type

CREATE:sstring          EQUATE (1)
CREATE:string           EQUATE (2)
CREATE:image            EQUATE (3)
CREATE:region           EQUATE (4)
CREATE:line             EQUATE (5)
CREATE:box              EQUATE (6)
CREATE:ellipse          EQUATE (7)
CREATE:entry            EQUATE (8)
CREATE:button           EQUATE (9)
CREATE:prompt           EQUATE (10)
CREATE:option           EQUATE (11)
CREATE:check            EQUATE (12)
CREATE:group            EQUATE (13)
CREATE:list             EQUATE (14)
CREATE:combo            EQUATE (15)
CREATE:spin             EQUATE (16)
CREATE:text             EQUATE (17)
CREATE:custom           EQUATE (18)
CREATE:menu             EQUATE (19)
CREATE:item             EQUATE (20)
CREATE:radio            EQUATE (21)
CREATE:menubar          EQUATE (22)    ! return value only
CREATE:application      EQUATE (24)    ! return value only
CREATE:window           EQUATE (25)    ! return value only
CREATE:report           EQUATE (26)    ! return value only
CREATE:header           EQUATE (27)
CREATE:footer           EQUATE (28)
CREATE:break            EQUATE (29)
CREATE:form             EQUATE (30)
CREATE:detail           EQUATE (31)
CREATE:ole              EQUATE (32)
CREATE:droplist         EQUATE (33)
CREATE:dropcombo        EQUATE (34)
CREATE:progress         EQUATE (35)

CREATE:sheet            EQUATE (37)
CREATE:tab              EQUATE (38)
CREATE:panel            EQUATE (39)
CREATE:rtf              EQUATE (40)

CREATE:sublist          EQUATE (CREATE:list + 0100H)  ! list part of a DROP or COMBO

CREATE:toolbar          EQUATE (128)

FONT:thin               EQUATE (100)
FONT:regular            EQUATE (400)
FONT:bold               EQUATE (700)
FONT:weight             EQUATE (07FFH)
FONT:fixed              EQUATE (0800H)
FONT:italic             EQUATE (01000H)
FONT:underline          EQUATE (02000H)
FONT:strikeout          EQUATE (04000H)

FONT:Screen             EQUATE(0)
FONT:Printer            EQUATE(1)
FONT:Both               EQUATE(2)
FONT:TrueTypeOnly       EQUATE(4)
FONT:FixedPitchOnly     EQUATE(8)

CHARSET:ANSI            EQUATE (  0)
CHARSET:DEFAULT         EQUATE (  1)
CHARSET:SYMBOL          EQUATE (  2)
CHARSET:MAC             EQUATE ( 77)
CHARSET:SHIFTJIS        EQUATE (128)
CHARSET:HANGEUL         EQUATE (129)
CHARSET:JOHAB           EQUATE (130)
CHARSET:GB2312          EQUATE (134)
CHARSET:CHINESEBIG5     EQUATE (136)
CHARSET:GREEK           EQUATE (161)
CHARSET:TURKISH         EQUATE (162)
CHARSET:HEBREW          EQUATE (177)
CHARSET:ARABIC          EQUATE (178)
CHARSET:BALTIC          EQUATE (186)
CHARSET:CYRILLIC        EQUATE (204)
CHARSET:THAI            EQUATE (222)
CHARSET:EASTEUROPE      EQUATE (238)
CHARSET:OEM             EQUATE (255)

PEN:solid               EQUATE (0)
PEN:dash                EQUATE (1)
PEN:dot                 EQUATE (2)
PEN:dashdot             EQUATE (3)
PEN:dashdotdot          EQUATE (4)
PEN:null                EQUATE (5)
PEN:insideframe         EQUATE (6)

BRUSH:SOLID             EQUATE (0)
BRUSH:NULL              EQUATE (1)
BRUSH:HOLLOW            EQUATE (BRUSH:NULL)
BRUSH:HATCHED           EQUATE (2)
BRUSH:PATTERN           EQUATE (3)
BRUSH:INDEXED           EQUATE (4)
BRUSH:DIBPATTERN        EQUATE (5)

FALSE                   EQUATE (0)
TRUE                    EQUATE (1)

LISTZONE:field          EQUATE(0)
LISTZONE:right          EQUATE(1)
LISTZONE:header         EQUATE(2)
LISTZONE:expandbox      EQUATE(3)
LISTZONE:tree           EQUATE(4)
LISTZONE:icon           EQUATE(5)
LISTZONE:nowhere        EQUATE(6)

VBXEVENT:Click          EQUATE (0)
VBXEVENT:DblClick       EQUATE (1)
VBXEVENT:GotFocus       EQUATE (4)
VBXEVENT:KeyDown        EQUATE (5)
VBXEVENT:KeyPress       EQUATE (6)
VBXEVENT:KeyUp          EQUATE (7)
VBXEVENT:LostFocus      EQUATE (8)
VBXEVENT:MouseDown      EQUATE (9)
VBXEVENT:MouseMove      EQUATE (10)
VBXEVENT:MouseUp        EQUATE (11)

BUTTON:OK               EQUATE (01H)
BUTTON:YES              EQUATE (02H)
BUTTON:NO               EQUATE (04H)
BUTTON:ABORT            EQUATE (08H)
BUTTON:RETRY            EQUATE (10H)
BUTTON:IGNORE           EQUATE (20H)
BUTTON:CANCEL           EQUATE (40H)
BUTTON:HELP             EQUATE (80H)

MSGMODE:SYSMODAL        EQUATE (01H)
MSGMODE:CANCOPY         EQUATE (02H)

WINDOW:OK               EQUATE (0)
WINDOW:NotOpened        EQUATE (1)
WINDOW:BadWindow        EQUATE (2)
WINDOW:ClosePending     EQUATE (3)
WINDOW:InDestroy        EQUATE (4)

TEXT:Field              EQUATE (0)
TEXT:File               EQUATE (1)

!DDE link types

DDE:auto                EQUATE (0)
DDE:manual              EQUATE (-1)
DDE:remove              EQUATE (-2)

! Types
  OMIT('***',_WIDTH32_)
SIGNED                  EQUATE(SHORT)
UNSIGNED                EQUATE(USHORT)
_nopos                  EQUATE(08000H)
  ***
  COMPILE('***',_WIDTH32_)
SIGNED                  EQUATE(LONG)
UNSIGNED                EQUATE(LONG)
_nopos                  EQUATE(080000000H)
  ***
BOOL                    EQUATE(SIGNED)

!DIRECTORY equates & TYPEs

!Old 8.3 filename support

ff_:NORMAL              EQUATE(0)
ff_:READONLY            EQUATE(1)
ff_:HIDDEN              EQUATE(2)
ff_:SYSTEM              EQUATE(4)
ff_:DIRECTORY           EQUATE(10H)
ff_:ARCHIVE             EQUATE(20H)
ff_:LFN                 EQUATE(80H)


ff_:queue    QUEUE,PRE(ff_),TYPE
name           string(13)
date           long
time           long
size           long
attrib         byte
             END

!full filename support

FILE:MaxFileName EQUATE(256)
FILE:MaxFilePath EQUATE(260)

FILE:Queue   QUEUE,PRE(FILE),TYPE
Name           STRING(FILE:MaxFileName)
ShortName      STRING(13)
Date           LONG
Time           LONG
Size           LONG
Attrib         BYTE
             END

PrintPreviewFileQueue   QUEUE,TYPE
Filename                   STRING(FILE:MaxFileName)
PrintPreviewImage          STRING(FILE:MaxFileName),OVER(Filename)
                        END
                  
oleQ         QUEUE,TYPE
name           CSTRING(64)
clsid          CSTRING(64)
progid         CSTRING(64)
             END

!FileDialog equates

FILE:Save      EQUATE(1)
FILE:KeepDir   EQUATE(2)
FILE:NoError   EQUATE(4)
FILE:Multi     EQUATE(8)
FILE:LongName  EQUATE(10H)
FILE:Directory EQUATE(20H)

OCX:default    EQUATE(0)
OCX:16bit      EQUATE(1)
OCX:32bit      EQUATE(2)
OCX:1632bit    EQUATE(3)

DOCK:Left      EQUATE(1)
DOCK:Top       EQUATE(2)
DOCK:Right     EQUATE(4)
DOCK:Bottom    EQUATE(8)
DOCK:Float     EQUATE(16)

DOCK:All       EQUATE(31)

!TopSpeed File Flags

TPSREADONLY    EQUATE(1)

!Match Flag Values
Match:Simple       EQUATE(0)
Match:Wild         EQUATE(1)
Match:Regular      EQUATE(2)
Match:Soundex      EQUATE(3)
Match:NoCase       EQUATE(10H)   ! May be added to Simple,Wild and Regular


PAPER:LETTER              EQUATE(1)       ! Letter 8 1/2 x 11 in
PAPER:LETTERSMALL         EQUATE(2)       ! Letter Small 8 1/2 x 11 in
PAPER:TABLOID             EQUATE(3)       ! Tabloid 11 x 17 in
PAPER:LEDGER              EQUATE(4)       ! Ledger 17 x 11 in
PAPER:LEGAL               EQUATE(5)       ! Legal 8 1/2 x 14 in
PAPER:STATEMENT           EQUATE(6)       ! Statement 5 1/2 x 8 1/2 in
PAPER:EXECUTIVE           EQUATE(7)       ! Executive 7 1/4 x 10 1/2 in
PAPER:A3                  EQUATE(8)       ! A3 297 x 420 mm
PAPER:A4                  EQUATE(9)       ! A4 210 x 297 mm
PAPER:A4SMALL             EQUATE(10)      ! A4 Small 210 x 297 mm
PAPER:A5                  EQUATE(11)      ! A5 148 x 210 mm
PAPER:B4                  EQUATE(12)      ! B4 250 x 354
PAPER:B5                  EQUATE(13)      ! B5 182 x 257 mm
PAPER:FOLIO               EQUATE(14)      ! Folio 8 1/2 x 13 in
PAPER:QUARTO              EQUATE(15)      ! Quarto 215 x 275 mm
PAPER:10X14               EQUATE(16)      ! 10x14 in
PAPER:11X17               EQUATE(17)      ! 11x17 in
PAPER:NOTE                EQUATE(18)      ! Note 8 1/2 x 11 in
PAPER:ENV_9               EQUATE(19)      ! Envelope #9 3 7/8 x 8 7/8
PAPER:ENV_10              EQUATE(20)      ! Envelope #10 4 1/8 x 9 1/2
PAPER:ENV_11              EQUATE(21)      ! Envelope #11 4 1/2 x 10 3/8
PAPER:ENV_12              EQUATE(22)      ! Envelope #12 4 \276 x 11
PAPER:ENV_14              EQUATE(23)      ! Envelope #14 5 x 11 1/2
PAPER:CSHEET              EQUATE(24)      ! C size sheet
PAPER:DSHEET              EQUATE(25)      ! D size sheet
PAPER:ESHEET              EQUATE(26)      ! E size sheet
PAPER:ENV_DL              EQUATE(27)      ! Envelope DL 110 x 220mm
PAPER:ENV_C5              EQUATE(28)      ! Envelope C5 162 x 229 mm
PAPER:ENV_C3              EQUATE(29)      ! Envelope C3  324 x 458 mm
PAPER:ENV_C4              EQUATE(30)      ! Envelope C4  229 x 324 mm
PAPER:ENV_C6              EQUATE(31)      ! Envelope C6  114 x 162 mm
PAPER:ENV_C65             EQUATE(32)      ! Envelope C65 114 x 229 mm
PAPER:ENV_B4              EQUATE(33)      ! Envelope B4  250 x 353 mm
PAPER:ENV_B5              EQUATE(34)      ! Envelope B5  176 x 250 mm
PAPER:ENV_B6              EQUATE(35)      ! Envelope B6  176 x 125 mm
PAPER:ENV_ITALY           EQUATE(36)      ! Envelope 110 x 230 mm
PAPER:ENV_MONARCH         EQUATE(37)      ! Envelope Monarch 3.875 x 7.5 in
PAPER:ENV_PERSONAL        EQUATE(38)      ! 6 3/4 Envelope 3 5/8 x 6 1/2 in
PAPER:FANFOLD_US          EQUATE(39)      ! US Std Fanfold 14 7/8 x 11 in
PAPER:FANFOLD_STD_GERMAN  EQUATE(40)      ! German Std Fanfold 8 1/2 x 12 in
PAPER:FANFOLD_LGL_GERMAN  EQUATE(41)      ! German Legal Fanfold 8 1/2 x 13 in
PAPER:LAST                EQUATE(41)
PAPER:USER                EQUATE(256)

! File Driver Function equates for use with file{PROP:SupportsOp,DriverOp:n}

  ITEMIZE(1),PRE(DriverOp)
ADD               EQUATE
BOF               EQUATE
BUILDfile         EQUATE
APPEND            EQUATE
BUILDdyn          EQUATE
BUILDkey          EQUATE
CLOSE             EQUATE
COMMIT            EQUATE
COPY              EQUATE
CREATE            EQUATE
DELETE            EQUATE
DUPLICATE         EQUATE
EMPTY             EQUATE
EOF               EQUATE
GETfilekey        EQUATE
GETfileptr        EQUATE
GETkeyptr         EQUATE
HOLD              EQUATE
LOCK              EQUATE(20)
LOGOUT            EQUATE(22)
NAME              EQUATE
NEXT              EQUATE
OPEN              EQUATE
PACK              EQUATE
POINTERfile       EQUATE
POINTERkey        EQUATE
FLUSH             EQUATE
PUT               EQUATE
PREVIOUS          EQUATE
RECORDSfile       EQUATE
RECORDSkey        EQUATE
BUILDdynfilter    EQUATE
STARTTRAN         EQUATE
RELEASE           EQUATE
REMOVE            EQUATE
RENAME            EQUATE
ENDTRAN           EQUATE
ROLLBACK          EQUATE
SETfile           EQUATE
SETfilekey        EQUATE
SETfileptr        EQUATE
SETkey            EQUATE
SETkeykey         EQUATE
SETkeyptr         EQUATE
SETkeykeyptr      EQUATE
SHARE             EQUATE
SKIP              EQUATE
UNLOCK            EQUATE
ADDlen            EQUATE
BYTES             EQUATE
GETfileptrlen     EQUATE
PUTfileptr        EQUATE
PUTfileptrlen     EQUATE
STREAM            EQUATE
DUPLICATEkey      EQUATE
WATCH             EQUATE
APPENDlen         EQUATE
SEND              EQUATE
POSITIONfile      EQUATE
POSITIONkey       EQUATE
RESETfile         EQUATE
RESETkey          EQUATE
NOMEMO            EQUATE
REGETfile         EQUATE
REGETkey          EQUATE
NULL              EQUATE
SETNULL           EQUATE
SETNONNULL        EQUATE
SETproperty       EQUATE
GETproperty       EQUATE
GETblobdata       EQUATE(75)
PUTblobdata       EQUATE
BLOBSIZE          EQUATE
SETblobproperty   EQUATE
GETblobproperty   EQUATE
BUFFER            EQUATE
SETviewfields     EQUATE
CLEARfile         EQUATE
RESETviewfile     EQUATE
BUILDevent        EQUATE
SETkeyproperty    EQUATE
GETkeyproperty    EQUATE
DOproperty        EQUATE(88)
DOkeyproperty     EQUATE
DOblobproperty    EQUATE
VIEWSTART         EQUATE(92)
VIEWSTOP          EQUATE
GETNULLS          EQUATE(96)
SETNULLS          EQUATE
GETSTATE          EQUATE
RESTORESTATE      EQUATE
CALLBACK          EQUATE
FREESTATE         EQUATE(102)
DESTROY           EQUATE(104)
  END

! Data Type Equates for use with file{PROP:SupportsType, DataType:n}

  ITEMIZE(1),PRE(DataType)
BYTE              EQUATE
SHORT             EQUATE
USHORT            EQUATE
DATE              EQUATE
TIME              EQUATE
LONG              EQUATE
ULONG             EQUATE
SREAL             EQUATE
REAL              EQUATE
DECIMAL           EQUATE
PDECIMAL          EQUATE
BFLOAT4           EQUATE(13)
BFLOAT8           EQUATE
STRING            EQUATE(18)
CSTRING           EQUATE
PSTRING           EQUATE
MEMO              EQUATE
BLOB              EQUATE(27)
  END

! These equates are to be used as the first parameter to the DELETEREG,
! GETREG and PUTREG statements

REG_CLASSES_ROOT      EQUATE(80000000h)
REG_CURRENT_USER      EQUATE(80000001h)
REG_LOCAL_MACHINE     EQUATE(80000002h)
REG_USERS             EQUATE(80000003h)
REG_PERFORMANCE_DATA  EQUATE(80000004h)
REG_CURRENT_CONFIG    EQUATE(80000005h)
REG_DYN_DATA          EQUATE(80000006h)

REG_NONE                 EQUATE(0)     ! No value type
REG_SZ                   EQUATE(1)     ! Unicode nul terminated string
REG_EXPAND_SZ            EQUATE(2)     ! Unicode nul terminated string
                                       ! (with environment variable references)
REG_BINARY               EQUATE(3)     ! Free form binary
REG_DWORD                EQUATE(4)     ! 32-bit number
REG_DWORD_LITTLE_ENDIAN  EQUATE(4)     ! 32-bit number (same as REG_DWORD)
REG_DWORD_BIG_ENDIAN     EQUATE(5)     ! 32-bit number
REG_LINK                 EQUATE(6)     ! Symbolic Link (unicode)
REG_MULTI_SZ             EQUATE(7)     ! Multiple Unicode strings
REG_RESOURCE_LIST        EQUATE(8)     ! Resource list in the resource map
REG_FULL_RESOURCE_DESCRIPTOR EQUATE(9) ! Resource list in the hardware description
REG_RESOURCE_REQUIREMENTS_LIST EQUATE(10)
REG_QWORD                EQUATE(11)    ! 64-bit number
REG_QWORD_LITTLE_ENDIAN  EQUATE(11)    ! 64-bit number (same as REG_QWORD)
