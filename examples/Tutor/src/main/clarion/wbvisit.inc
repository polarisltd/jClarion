!ABCIncludeFile(SHOP)

  OMIT('_EndOfInclude_', _VisitorPresent_)
_VisitorPresent_  EQUATE(1)

   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('WBGUARD.INC'),ONCE

VisitorClass CLASS(WBGuardClass),TYPE,MODULE('WBVISIT.CLW'),LINK('WBVISIT', _GuardLinkMode_),DLL(_GuardDllMode_)
FMVIS             &FileManager,PRIVATE
VISIdxKey         &KEY
VISIdx            ANY,PRIVATE
VISCusID          ANY,PRIVATE
FMCART            &FileManager,PRIVATE
CARTKey           &Key
CARTCusID         ANY,PRIVATE
FMINV             &FileManager,PRIVATE
INVKey            &Key
INVCusID          ANY,PRIVATE
Guard             &WBGuardClass,PRIVATE
Visitor           LONG,PRIVATE

Ask               PROCEDURE,BYTE,DERIVED
InitCart          PROCEDURE(FileManager FMCART, KEY CARTKey, *? CARTCusID),BYTE
InitInvoice       PROCEDURE(FileManager FMINV, KEY INVKey, *? INVCusID),BYTE
InitVisitor       PROCEDURE(FileManager FMVIS, KEY VISIdxKey, *? VISIdx, *? VISCusID),BYTE
KillVisitor       PROCEDURE
NewVisitor        PROCEDURE(),BYTE
ReservedLogonName PROCEDURE(ASTRING Name),BYTE,DERIVED
TidyUp            PROCEDURE

  END



  _EndOfInclude_
