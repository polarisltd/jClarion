!ABCIncludeFile

 OMIT('_EndOfInclude_',_UtilitiesPresent_)
_UtilitiesPresent_ EQUATE(1)

  INCLUDE('ABERROR.INC'),ONCE

  ITEMIZE(1)
RequestCompleted        EQUATE                 !  Update Completed
RequestCancelled        EQUATE                 !  Update Aborted
  END

  ITEMIZE(1),PRE(ConstType)
First         EQUATE
Cstring       EQUATE(ConstType:First)
Pstring       EQUATE
Byte          EQUATE            !1 byte unsigned integer
Short         EQUATE            !2 byte signed integer
UShort        EQUATE            !2 byte unsigned interger
Long          EQUATE            !4 byte signed integer
Last          EQUATE(ConstType:Long)
  END

  ITEMIZE(1),PRE(Term)
EndGroup      EQUATE            !Stops reading when end of group is encountered
UShort        EQUATE            !Reads number of items from an Items USHORT value at start of group
Byte          EQUATE            !Reads number of items from an Items BYTE value at start of group
FieldValue    EQUATE            !Stops when a specified value is found in field one, only first 32 chars are compared
  END


ConstantClass   CLASS,TYPE,MODULE('ABUTIL.CLW'),LINK('ABUTIL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
CharPnt           LONG,PRIVATE
Items             USHORT,PRIVATE
RecordPnt         USHORT,PRIVATE
SourceSize        LONG,PRIVATE
Str               &STRING,PRIVATE
Termination       BYTE,PRIVATE
TerminatorValue   CSTRING(33)                     !up to 32 significant characters
Descriptor        &ConstDescriptorList,PRIVATE

AddItem           PROCEDURE(BYTE ItemType,*? Dest)
GetByte           PROCEDURE(),BYTE,PRIVATE
GetShort          PROCEDURE(),SHORT,PRIVATE
GetUShort         PROCEDURE(),USHORT,PRIVATE
GetLong           PROCEDURE(),LONG,PRIVATE
GetPString        PROCEDURE(),STRING,PRIVATE
GetCString        PROCEDURE(),STRING,PRIVATE
Init              PROCEDURE(BYTE Termination=Term:UShort)   !,EXTENDS
Kill              PROCEDURE
Reset             PROCEDURE
Set               PROCEDURE(*STRING DataSource)
Next              PROCEDURE(),BYTE,PROC
Next              PROCEDURE(QUEUE Q)
Next              PROCEDURE(FILE F)
                END


FieldPairsQueue QUEUE,TYPE
Left  ANY
Right ANY
  END

FieldPairsClass CLASS,TYPE,MODULE('ABUTIL.CLW'),LINK('ABUTIL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
List              &FieldPairsQueue
AddPair           PROCEDURE(*? Left,*? Right),VIRTUAL
AddItem           PROCEDURE(*? Left) ! Added to left, copy taken on right
AssignLeftToRight PROCEDURE
AssignRightToLeft PROCEDURE
ClearLeft         PROCEDURE
ClearRight        PROCEDURE
Equal             PROCEDURE,BYTE
EqualLeftRight    PROCEDURE,BYTE
Kill              PROCEDURE
Init              PROCEDURE   !,EXTENDS
           END

BufferedPairsQueue QUEUE,TYPE
Left   ANY
Right  ANY
Buffer ANY
  END

BufferedPairsClass CLASS(FieldPairsClass),TYPE,MODULE('ABUTIL.CLW'),LINK('ABUTIL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
RealList            &BufferedPairsQueue
AddPair             PROCEDURE(*? Left,*? Right),VIRTUAL
AssignBufferToLeft  PROCEDURE
AssignBufferToRight PROCEDURE
AssignLeftToBuffer  PROCEDURE
AssignRightToBuffer PROCEDURE
EqualLeftBuffer     PROCEDURE,BYTE
EqualRightBuffer    PROCEDURE,BYTE
Init                PROCEDURE   !,EXTENDS
Kill                PROCEDURE
  END

SectorQueue QUEUE,TYPE
Family  CSTRING(100)    !*** Eventually we'll want ASTRINGs
Item    CSTRING(100)
Type    CSTRING(100)
            END

INIClass          CLASS,TYPE,MODULE('ABUTIL.CLW'),LINK('ABUTIL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
FileName            CSTRING(File:MaxFilePath)
Sectors             &SectorQueue,PRIVATE

Fetch              PROCEDURE(STRING Sector, STRING Name, STRING Default, STRING Filename),STRING,VIRTUAL,PROTECTED
Update             PROCEDURE(STRING Sector, STRING Name, STRING Value,STRING Filename),VIRTUAL,PROTECTED

AddSector           PROCEDURE(STRING Sector)
DeleteSector        PROCEDURE(STRING Sector)
Fetch               PROCEDURE,VIRTUAL
Fetch               PROCEDURE(STRING Sector,STRING Name),STRING
Fetch               PROCEDURE(STRING ProcName,WINDOW W)
Fetch               PROCEDURE(STRING Sector,STRING Name,*? Value)
FetchField          PROCEDURE(STRING Sector,STRING Name,BYTE FieldNo),STRING
FetchQueue          PROCEDURE(STRING Sector,STRING Name,QUEUE Q,*? F1,<*? F2>,<*? F3>)
GetFamily           PROCEDURE(STRING Sector,*CSTRING Family,*CSTRING Item,*CSTRING Type)
GetSector           PROCEDURE(STRING Family, STRING Item, STRING Type),STRING
GetSectors          PROCEDURE(<STRING Family>, <STRING Item>, <STRING Type>, SectorQueue SQ)
Init                PROCEDURE(STRING FileName)   !,EXTENDS
Kill                PROCEDURE
TryFetch            PROCEDURE(STRING Sector,STRING Name),STRING
TryFetchField       PROCEDURE(STRING Sector,STRING Name,BYTE FieldNo),STRING
Update              PROCEDURE,VIRTUAL
Update              PROCEDURE(STRING ProcName,WINDOW W)
Update              PROCEDURE(STRING Sector,STRING Name,STRING Value)
Update              PROCEDURE(STRING Sector,STRING Name,QUEUE Q,*? F1,<*? F2>,<*? F3>)
                  END

SelectFileQueue     QUEUE,TYPE
Name                  STRING(File:MaxFilePath)        !either
ShortName             STRING(File:MaxFilePath)        !with long filenames, this will contain the equivalent short file name
                    END

SelectFileClass  CLASS,TYPE,MODULE('ABUTIL.CLW'),LINK('ABUTIL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
DefaultDirectory      CSTRING(File:MaxFilePath)       !Default directory when file dialog is opened
DefaultFile           CSTRING(File:MaxFileName)       !Default filename (wildcards allowed) to initally appear in file name entry field
Flags                 BYTE
MaskString            CSTRING(255),PRIVATE
SavePath              CSTRING(File:MaxFilePath),PRIVATE
WindowTitle           CSTRING(80)

Init                  PROCEDURE   !,EXTENDS
AddMask               PROCEDURE(STRING FileMasks)
AddMask               PROCEDURE(STRING Description,STRING Pattern)
Ask                   PROCEDURE(BYTE KeepDir=0),STRING  !,EXTENDS
Ask                   PROCEDURE(SelectFileQueue FileQueue,BYTE KeepDir = 0)  !,EXTENDS
SetMask               PROCEDURE(STRING FileMask)
SetMask               PROCEDURE(STRING Description,STRING Pattern)
                    END

MaxRecursion        EQUATE(32)    !Maximum level of recursive calling allow during translation

TranslatorGroup     GROUP,TYPE
Number                USHORT
                    END

TranslatorClass     CLASS,TYPE,MODULE('ABUTIL.CLW'),LINK('ABUTIL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
ExtractText           CSTRING(FILE:MaxFilePath)                                                 !Set to a valid filename to extract untranslated items at run-time to given file
Queue                 &TranslatorQueue,PRIVATE
TypeMapping           &TypeMappingQueue,PRIVATE

AddTranslation        PROCEDURE(STRING Source,STRING Replacement)                               !Adds a translation item
AddTranslation        PROCEDURE(TranslatorGroup TG)                                             !Adds a GROUP of translation items
Init                  PROCEDURE   !,EXTENDS
Kill                  PROCEDURE
ResolveMacros         PROCEDURE(*CSTRING Str),PRIVATE
TranslateControl      PROCEDURE(SHORT ControlID,<WINDOW Win>),VIRTUAL                           !Translates a given control
TranslateControls     PROCEDURE(SHORT FirstControlID,SHORT LastControlID,<WINDOW Win>),VIRTUAL  !Translates a range of controls
TranslateProperty     PROCEDURE(USHORT Property,SHORT CtrlID,<WINDOW Win>),VIRTUAL              !Translates a given property of a control
TranslateString       PROCEDURE(STRING TextProp),STRING,VIRTUAL                                 !Looks up the TextProp & returns replacement
TranslateWindow       PROCEDURE(<WINDOW Win>),VIRTUAL                                           !Translates a whole window
                    END

  _EndOfInclude_

