
!ABCIncludeFile

OMIT('_EndOfInclude_',_vsBrowsePresent_)
_vsBrowsePresent_ EQUATE(1)

  INCLUDE ('ABBROWSE.INC')

vsBrowseClass CLASS(BrowseClass),TYPE,MODULE('vsBrowse.CLW'),LINK('vsBrowse.CLW'),DLL(_ABCDllMode_)

! Data
ViewControl          SIGNED
CopyControl          SIGNED

! Methods
AskCopy              PROCEDURE(),BYTE ! Response out
SetAlerts            PROCEDURE,VIRTUAL
TakeEvent            PROCEDURE,VIRTUAL
TakeKey              PROCEDURE,BYTE,PROC,VIRTUAL ! 1 If action taken
UpdateWindow         PROCEDURE,VIRTUAL    ! Sets actual value to that stored in locator
HasRecords           PROCEDURE(),LONG
  END

_EndOfInclude_



