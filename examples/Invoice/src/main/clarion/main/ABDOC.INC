
  !ABCIncludeFile(DOC)

  OMIT('_EndOfInclude_',_ABDocumentPresent_)
_ABDocumentPresent_  EQUATE(1)


  INCLUDE('ABFILE.INC'),ONCE
  INCLUDE('IDOC.INC'),ONCE
  INCLUDE('ABHTMSUP.INC'),ONCE


WrapFormatOptQueue QUEUE,TYPE
strOptionName        ASTRING
OptionValue          STRING(256)       !Optional Option value
                   END

ComponentQueue     QUEUE(),TYPE
ComponentInfo        GROUP(ComponentGroup)
                     END
                   END

DocumentFileMgr    CLASS(FileManager),TYPE,MODULE('ABDOC.CLW'),LINK('ABDOC', _DocLinkMode_),DLL(_DocDllMode_)
Init                 PROCEDURE(ErrorClass ErrorHandler)   !,EXTENDS
                   END

OpenFormatInfo     CLASS,TYPE,MODULE('ABDOC.CLW'),LINK('ABDOC', _DocLinkMode_),DLL(_DocDllMode_)
dwParentID           LONG
strFormat            ASTRING
OptFormatValue       &STRING
WrapFormats          &WrapFormatOptQueue
strData              &STRING
                   END


OpenFormatStack    CLASS(Stack),TYPE,MODULE('ABDOC.CLW'),LINK('ABDOC', _DocLinkMode_),DLL(_DocDllMode_)
OnKillElement        PROCEDURE(LONG lpObject),VIRTUAL,PROTECTED
                   END


MapAStringToAString CLASS,TYPE,MODULE('ABDOC.CLW'),LINK('ABDOC', _DocLinkMode_),DLL(_DocDllMode_)

Destruct              PROCEDURE

AddAssoc              PROCEDURE(ASTRING LeftAssoc, ASTRING RightAssoc)
GetLeftAssoc          PROCEDURE(ASTRING RightAssoc),ASTRING
GetRightAssoc         PROCEDURE(ASTRING LeftAssoc),ASTRING
Exists                PROCEDURE(ASTRING Element),BYTE

MapIndex              LONG,PROTECTED

                   END


DocumentEngine     CLASS,TYPE,MODULE('ABDOC.CLW'),LINK('ABDOC', _DocLinkMode_),DLL(_DocDllMode_)

Construct            PROCEDURE
Destruct             PROCEDURE,VIRTUAL

Init                 PROCEDURE(ErrorClass ErrorHandler, BYTE bAutoFlushOnDestruct)   !,EXTENDS
Kill                 PROCEDURE,VIRTUAL
SetFileName          PROCEDURE(STRING strFileName, BYTE bCreateFile = false),BYTE
GetFileName          PROCEDURE(*CSTRING szDocFileName),BYTE
WriteDocument        PROCEDURE(BYTE bFlush = false),VIRTUAL
IsInitialised        PROCEDURE,BYTE
IsInputSourceOpen    PROCEDURE,BYTE,VIRTUAL
GetLastID            PROCEDURE,LONG
FindLastChild        PROCEDURE(LONG dwID),LONG
PutFormat            PROCEDURE(ASTRING strFormat, LONG RelID = 0, LONG nMoveTo = 0),LONG,PROC
PutFormat            PROCEDURE(ASTRING strFormat, STRING FormatValue, LONG RelID = 0, LONG nMoveTo = 0, STRING strData),LONG,PROC
BeginFormat          PROCEDURE(ASTRING strFormat, <STRING strFormatValue>)
EndFormat            PROCEDURE(ASTRING strFormat)
PutDataSerial        PROCEDURE(*STRING strData)
PutData              PROCEDURE(STRING strData),LONG,PROC
AddData              PROCEDURE(*STRING strData, LONG dwID = 0),LONG,PROC
PutCell              PROCEDURE(LONG dwRow, LONG dwColumn, *STRING strData),LONG,PROC
GetOption            PROCEDURE(LONG dwID, ASTRING strOptionName),STRING
PutOption            PROCEDURE(ASTRING strFormat, *STRING OptionValue, LONG dwComponentID = 0),LONG,PROC
MoveComponent        PROCEDURE(LONG dwID, LONG RelID, LONG nMoveTo = 0),BYTE,PROC
GetNextFormat        PROCEDURE(LONG dwLastID),LONG
GetNextChildFormat   PROCEDURE(LONG dwParentID, LONG dwLastID),LONG
GetFormatInfo        PROCEDURE(LONG dwID, ComponentGroup ComponentInfo),BYTE
HasChildren          PROCEDURE(LONG dwID),BYTE
HasData              PROCEDURE(LONG dwID),BYTE
FlushOptions         PROCEDURE(WrapFormatOptQueue WrapFormats)
FetchData            PROCEDURE(LONG dwFilePos, LONG dwBytes, *STRING strBuffer)
WriteData            PROCEDURE(*CSTRING szDataBuffer)
WriteData            PROCEDURE(STRING strDataBuffer)
IsFileSet            PROCEDURE,BYTE
TagToID              PROCEDURE(ASTRING TagText),ASTRING,VIRTUAL
TagFromID            PROCEDURE(ASTRING TagID),ASTRING,VIRTUAL
FetchNextComponent   PROCEDURE,BYTE
FetchLastComponentRead PROCEDURE,LONG
FetchComponentType   PROCEDURE,LONG
FetchComponentValue  PROCEDURE,ASTRING
FetchComponentLabel  PROCEDURE,ASTRING

InitStructure        PROCEDURE(ASTRING strFormat, STRING FormatValue, STRING strData),PROTECTED
MoveChildren         PROCEDURE(LONG dwID),BYTE,PROTECTED
FlushComponentQueue  PROCEDURE(LONG dwParentPointer),LONG,PROC,PROTECTED
FlushBuffer          PROCEDURE,PROTECTED
GetNextID            PROCEDURE,LONG,PROTECTED
DisposeComponentQueue PROCEDURE,PROTECTED
OnDocInitFlush       PROCEDURE,VIRTUAL,PROTECTED
OnDocCompleteFlush   PROCEDURE,VIRTUAL,PROTECTED
OnStartComponentFlush PROCEDURE(ComponentGroup ComponentInfo),VIRTUAL,PROTECTED
OnEndComponentFlush  PROCEDURE(ComponentGroup ComponentInfo),VIRTUAL,PROTECTED
OnFlushOption        PROCEDURE(ASTRING strOptionName, *STRING OptionValue),VIRTUAL,PROTECTED
OnReadComponent      PROCEDURE(ComponentGroup ComponentInfo),VIRTUAL,PROTECTED
OnReadOption         PROCEDURE(LONG dwOption, *STRING OptionValue),VIRTUAL,PROTECTED

!Protected Properties

bAutoLineBreak       BYTE
TagMap               &MapAStringToAString

DocComponentsQueue   &ComponentQueue,PROTECTED
ErrorHandler         &ErrorClass,PROTECTED
FileHandler          &DocumentFileMgr,PROTECTED
IDocCreate           &IDocumentCreate,PROTECTED
OpenParentStack      &OpenFormatStack,PROTECTED

szDocFileName        CSTRING(256),PROTECTED
bAutoFlushOnDestruct BYTE,PROTECTED
bInitialised         BYTE,PROTECTED
bFlushed             BYTE,PROTECTED
bInputSourceOpen     BYTE,PROTECTED
bFileSet             BYTE,PROTECTED
InTag                BYTE,PROTECTED
dwLastID             LONG,PROTECTED
dwLastOpenFormat     LONG,PROTECTED
dwLastQueueID        LONG,PROTECTED
dwFirstChildPosition LONG,PROTECTED
dwLastChildPosition  LONG,PROTECTED

dwLastComponentRead  LONG,PROTECTED
dwLastReadType       LONG,PROTECTED
strLastReadLabel     ASTRING,PROTECTED
strLastReadValue     ASTRING,PROTECTED

                   END


DocumentClass      CLASS,TYPE,MODULE('ABDOC.CLW'),LINK('ABDOC', _DocLinkMode_),DLL(_DocDllMode_)

Construct            PROCEDURE
Destruct             PROCEDURE,VIRTUAL

Init                 PROCEDURE(ErrorClass ErrorHandler, BYTE bAutoFlushOnDestruct = false),VIRTUAL
Kill                 PROCEDURE,VIRTUAL
InitTags             PROCEDURE,VIRTUAL,PROTECTED
TagToID              PROCEDURE(ASTRING TagText),ASTRING,VIRTUAL
TagFromID            PROCEDURE(ASTRING TagID),ASTRING,VIRTUAL

DocEngine            &DocumentEngine

                   END


AsciiDocumentClass CLASS(DocumentClass),TYPE,MODULE('ABDOC.CLW'),LINK('ABDOC', _DocLinkMode_),DLL(_DocDllMode_)
                   END

  _EndOfInclude_
