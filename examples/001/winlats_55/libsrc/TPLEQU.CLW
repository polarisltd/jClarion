! Template Equates

! Template Defined Action Values

InsertRecord            EQUATE (1)             !  Add a record to table
ChangeRecord            EQUATE (2)             !  Change the current record
DeleteRecord            EQUATE (3)             !  Delete the current record
SelectRecord            EQUATE (4)             !  Select the current record
RequestCompleted        EQUATE (1)             !  Update Completed
RequestCancelled        EQUATE (2)             !  Update Aborted

! Template Defined Record Status Flags

Record:OK               EQUATE(0)              !  Record passes range and filter
Record:OutOfRange       EQUATE(1)              !  Record fails range test
Record:Filtered         EQUATE(2)              !  Record fails filter tests

! File Access Modes

ReadOnly                EQUATE (0H)
WriteOnly               EQUATE (1H)
ReadWrite               EQUATE (2H)

AnyAccess               EQUATE (0H)
DenyAll                 EQUATE (10H)
DenyWrite               EQUATE (20H)
DenyRead                EQUATE (30H)
DenyNone                EQUATE (40H)

!Constant field equate values for Toolbar browse control

TBarBrwFirst            EQUATE(2000)
TBarBrwInsert           EQUATE(TBarBrwFirst)
TBarBrwChange           EQUATE(TBarBrwFirst+1)
TBarBrwDelete           EQUATE(TBarBrwFirst+2)
TBarBrwSelect           EQUATE(TBarBrwFirst+3)
TBarBrwBottom           EQUATE(TBarBrwFirst+4)
TBarBrwTop              EQUATE(TBarBrwFirst+5)
TBarBrwPageDown         EQUATE(TBarBrwFirst+6)
TBarBrwPageUp           EQUATE(TBarBrwFirst+7)
TBarBrwDown             EQUATE(TBarBrwFirst+8)
TBarBrwUp               EQUATE(TBarBrwFirst+9)
TBarBrwLocate           EQUATE(TBarBrwFirst+10)
TBarBrwHistory          EQUATE(TBarBrwFirst+11)
TBarBrwHelp             EQUATE(TBarBrwFirst+12)
TBarBrwLast             EQUATE(TBarBrwHelp)

!Form VCR Request Codes

VCRForward              EQUATE(TBarBrwDown)
VCRBackward             EQUATE(TBarBrwUp)
VCRPageForward          EQUATE(TBarBrwPageDown)
VCRPageBackward         EQUATE(TBarBrwPageUp)
VCRFirst                EQUATE(TBarBrwTop)
VCRLast                 EQUATE(TBarBrwBottom)
VCRInsert               EQUATE(TBarBrwInsert)
VCRNone                 EQUATE(0)

!Tool bar navigation modes

FormMode                EQUATE(1)
BrowseMode              EQUATE(2)
TreeMode                EQUATE(3)

!Resize strategies

Resize:LockWidth        EQUATE(01b)           !locks width of control
Resize:LockHeight       EQUATE(10b)           !locks height of control

!Positional Strategies
!Horizontal
Resize:LockXPos         EQUATE(0000000000000001b)           !locks XPos of control
Resize:FixRight         EQUATE(0000000000000010b)           !fixes XPos offset of control to right of window
Resize:FixLeft          EQUATE(0000000000000100b)           !fixes XPos offset of control to left of window
Resize:FixXCentre       EQUATE(0000000000001000b)           !fixes XPos offset of control relative to centre
Resize:FixNearestX      EQUATE(0000000000010000b)           !fixes to nearest window side - derived strategy
!Vertical
Resize:LockYPos         EQUATE(0000000100000000b)           !locks YPos of control
Resize:FixBottom        EQUATE(0000001000000000b)           !fixes YPos offset of control to bottom of window
Resize:FixTop           EQUATE(0000010000000000b)           !fixes YPos offset of control to top of window
Resize:FixYCentre       EQUATE(0000100000000000b)           !fixes YPos offset of control relative to centre
Resize:FixNearestY      EQUATE(0001000000000000b)           !fixes to nearest, window top of bottom = derived strategy

!Application Resize Strategies

AppStrat:Resize         EQUATE(1)           !Resizes & moves all controls
AppStrat:Spread         EQUATE(2)           !Resizes 'surface' controls moves others using Resize:FixNearestX+Resize:FixNearestY

! Template Warnings

Warn:InvalidFile         EQUATE (1)
Warn:InvalidKey          EQUATE (2)
Warn:RebuildError        EQUATE (3)
Warn:CreateError         EQUATE (4)
Warn:CreateOpenError     EQUATE (5)
Warn:ProcedureToDo       EQUATE (6)
Warn:BadKeyedRec         EQUATE (7)
Warn:OutOfRangeHigh      EQUATE (8)
Warn:OutOfRangeLow       EQUATE (9)
Warn:OutOfRange          EQUATE (10)
Warn:NotInFile           EQUATE (11)
Warn:RestrictUpdate      EQUATE (12)
Warn:RestrictDelete      EQUATE (13)
Warn:InsertError         EQUATE (14)
Warn:RIUpdateError       EQUATE (15)
Warn:UpdateError         EQUATE (16)
Warn:RIDeleteError       EQUATE (17)
Warn:DeleteError         EQUATE (18)
Warn:InsertDisabled      EQUATE (19)
Warn:UpdateDisabled      EQUATE (20)
Warn:DeleteDisabled      EQUATE (21)
Warn:NoCreate            EQUATE (22)
Warn:ConfirmCancel       EQUATE (23)
Warn:DuplicateKey        EQUATE (24)
Warn:AutoIncError        EQUATE (25)
Warn:FileLoadError       EQUATE (26)
Warn:ConfirmCancelLoad   EQUATE (27)
Warn:FileZeroLength      EQUATE (28)
Warn:EndOfAsciiQueue     EQUATE (29)
Warn:DiskError           EQUATE (30)
Warn:ProcessActionError  EQUATE (31)
Warn:StandardDelete      EQUATE (32)
Warn:SaveOnCancel        EQUATE (33)
Warn:LogoutError         EQUATE (34)
Warn:RecordFetchError    EQUATE (35)
Warn:ViewOpenError       EQUATE (36)
Warn:NewRecordAdded      EQUATE (37)
Warn:RIFormUpdateError   EQUATE (38)

ScrollSort:Alpha         EQUATE('  AFANATB BFBNBTC CFCNCT'|
                               &'D DFDNDTE EFENETF FFFNFT'|
                               &'G GFGNGTH HFHNHTI IFINIT'|
                               &'J JFJNJTK KFKNKTL LFLNLT'|
                               &'M MFMNMTN NFNNNTO OFONOT'|
                               &'P PFPNPTQ QNR RFRNRTS SF'|
                               &'SNSTT TFTNTTU UFUNUTV VF'|
                               &'VNVTW WFWNWTX XFXNXTY YF'|
                               &'YNYTZ ZN')

ScrollSort:Name          EQUATE('   ALBAMEARNBAKBATBENBIABOBBRA'|
                               &'BROBUACACCARCENCHRCOECONCORCRU'|
                               &'DASDELDIADONDURELDEVEFELFISFLO'|
                               &'FREFUTGARGIBGOLGOSGREGUTHAMHEM'|
                               &'HOBHOTINGJASJONKAGKEAKIRKORKYO'|
                               &'LATLEOLIGLOUMACMAQMARMAUMCKMER'|
                               &'MILMONMORNATNOLOKEPAGPAUPETPIN'|
                               &'PORPULRAUREYROBROSRUBSALSCASCH'|
                               &'SCRSHASIGSKISNASOUSTESTISUNTAY'|
                               &'TIRTUCVANWACWASWEIWIEWIMWOLYOR')

ScrollSort:AllowAlpha    EQUATE(1)
ScrollSort:AllowAlt      EQUATE(2)
ScrollSort:AllowNumeric  EQUATE(4)
ScrollSort:CaseSensitive EQUATE(8)

SortRequest:SelectSort   EQUATE(1)
SortRequest:Reset        EQUATE(2)
SortRequest:LocateRecord EQUATE(3)

SortResult:Changed       EQUATE(1)
SortResult:OK            EQUATE(2)
LocateOnPosition         EQUATE(1)
LocateOnValue            EQUATE(2)
LocateOnEdit             EQUATE(3)
FillBackward             EQUATE(1)
FillForward              EQUATE(2)
RefreshOnPosition        EQUATE(1)
RefreshOnQueue           EQUATE(2)
RefreshOnTop             EQUATE(3)
RefreshOnBottom          EQUATE(4)
RefreshOnCurrent         EQUATE(5)
EVENT:Preview:Print          EQUATE (401H)
EVENT:Preview:Cancel         EQUATE (402H)
EVENT:Preview:Zoom           EQUATE (403H)
EVENT:Preview:NextPage       EQUATE (404H)
EVENT:Preview:PrevPage       EQUATE (405H)
EVENT:Preview:Jump           EQUATE (406h)
EVENT:Preview:ChangeDisplay  EQUATE (407H)
EVENT:Preview:DisableNext    EQUATE (450h)
EVENT:Preview:EnableNext     EQUATE (451h)
EVENT:Preview:DisablePrev    EQUATE (452h)
EVENT:Preview:EnablePrev     EQUATE (453h)
EVENT:Preview:DirectZoom     EQUATE (454h)
EVENT:Preview:DirectUnzoom   EQUATE (455h)

Preview:OutOfPagesText       EQUATE ('There are no more pages to display')
Preview:OutOfPagesHead       EQUATE ('End of Report')

Preview:DisplayText          EQUATE (1)
Preview:DisplayIcons         EQUATE (2)
Preview:DisplayAll           EQUATE (3)

