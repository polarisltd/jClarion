! Template Equates

! Template Defined Action Values

 INCLUDE ('ABFILE.EQU'),ONCE !File Manager Equates
 INCLUDE ('ABBROWSE.EQU'),ONCE
 INCLUDE ('ABTOOLBA.EQU'),ONCE
 INCLUDE ('ABRESIZE.EQU'),ONCE

!Tool bar navigation modes

FormMode                EQUATE(1)
BrowseMode              EQUATE(2)
TreeMode                EQUATE(3)



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


SortRequest:SelectSort   EQUATE(1)
SortRequest:Reset        EQUATE(2)
SortRequest:LocateRecord EQUATE(3)

SortResult:Changed       EQUATE(1)
SortResult:OK            EQUATE(2)
LocateOnPosition         EQUATE(1)
LocateOnValue            EQUATE(2)
LocateOnEdit             EQUATE(3)

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

