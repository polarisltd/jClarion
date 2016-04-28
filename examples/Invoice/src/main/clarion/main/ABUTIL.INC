!ABCIncludeFile

 OMIT('_EndOfInclude_',_UtilitiesPresent_)

_UtilitiesPresent_ EQUATE(1)

  INCLUDE('ABERROR.INC'),ONCE
  INCLUDE('ABFILE.EQU'),ONCE

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
FieldValue    EQUATE            !Stops when a specified value is found in a nominated field
  END


ConstantClass   CLASS,TYPE,MODULE('ABUTIL.CLW'),LINK('ABUTIL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
CharPnt           LONG,PRIVATE
Items             USHORT,PRIVATE
RecordPnt         USHORT,PRIVATE
SourceSize        LONG,PRIVATE
Str               &STRING,PRIVATE
Termination       BYTE,PRIVATE
TerminatorValue   ANY                           ! the value used to terminate when terminating on a field value
TerminatorField   USHORT                        ! the field number containing the termination value when terminating on a field value, defaults to 1
TerminatorInclude BOOL                          ! set true to include the record containing the termination value, defaults to false
Descriptor        &ConstDescriptorList,PRIVATE
complete          BOOL,PRIVATE

ConstantClass     PROCEDURE

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



!----------------------------------------------------------------------------------------
! The INI class used to act as an interface solely to an INI file. Now, it can act as an
! interface to an INI file, the system registry or a table.
!
! For backward compatibility, the default action is to use an INI file, however, the 3
! parameter version of Init() can be used to direct to a different non-volatile data
! store. Pass one of the NV constants defined below.
!----------------------------------------------------------------------------------------

  ITEMIZE(0)
NVD_INI           EQUATE
NVD_Registry      EQUATE
NVD_Table         EQUATE           ! ** not yet supported
  END


SectorQueue       QUEUE,TYPE
Family              CSTRING(100)    !*** Eventually we'll want ASTRINGs
Item                CSTRING(100)
Type                CSTRING(100)
                  END

WindowInfo        GROUP,TYPE
X                   SIGNED
Y                   SIGNED
W                   SIGNED
H                   SIGNED
Maximized           BYTE
Minimized           BYTE
Got                 BYTE
                  END

INIClass          CLASS,TYPE,MODULE('ABUTIL.CLW'),LINK('ABUTIL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
FileName            CSTRING(File:MaxFilePath)
Sectors             &SectorQueue,PRIVATE
nvType              UNSIGNED,PROTECTED
extraData           LONG,PRIVATE
critSect            &ICriticalSection,PRIVATE

Construct           PROCEDURE
Destruct            PROCEDURE,VIRTUAL

Fetch               PROCEDURE(STRING Sector, STRING Name, STRING Default, STRING Filename),STRING,VIRTUAL,PROTECTED
Update              PROCEDURE(STRING Sector, STRING Name, STRING Value, STRING Filename),VIRTUAL,PROTECTED
FetchWindowInfo     PROCEDURE(STRING ProcName,*WindowInfo Info),PROTECTED
UpdateWindowInfo    PROCEDURE(STRING ProcName,*WindowInfo Info),PROTECTED

AddSector           PROCEDURE(STRING Sector)
DeleteSector        PROCEDURE(STRING Sector)
Fetch               PROCEDURE,VIRTUAL
Fetch               PROCEDURE(STRING Sector,STRING Name),STRING
Fetch               PROCEDURE(STRING ProcName,WINDOW W)
Fetch               PROCEDURE(STRING Sector,STRING Name,*? Value)
FetchField          PROCEDURE(STRING Sector,STRING Name,BYTE FieldNo),STRING
FetchQueue          PROCEDURE(STRING Sector,STRING Name,QUEUE Q,*? F1,<*? F2>,<*? F3>,<*? F4>)
FetchQ              PROCEDURE(STRING pSection, *QUEUE pQ)
GetFamily           PROCEDURE(STRING Sector,*CSTRING Family,*CSTRING Item,*CSTRING Type)
GetSector           PROCEDURE(STRING Family, STRING Item, STRING Type),STRING
GetSectors          PROCEDURE(<STRING Family>, <STRING Item>, <STRING Type>, SectorQueue SQ)
Init                PROCEDURE(STRING FileName)                  !,EXTENDS
Init                PROCEDURE(STRING FileName, UNSIGNED nvType, LONG extraData = 0) !,EXTENDS
ParseStr            PROCEDURE(STRING pValue, *QUEUE pQ, LONG pFldNbr)
Kill                PROCEDURE
Remove              PROCEDURE(STRING Sector,STRING Name)
TryFetch            PROCEDURE(STRING Sector,STRING Name),STRING
TryFetchField       PROCEDURE(STRING Sector,STRING Name,BYTE FieldNo),STRING
Update              PROCEDURE,VIRTUAL
Update              PROCEDURE(STRING ProcName,WINDOW W)
Update              PROCEDURE(STRING Sector,STRING Name,STRING Value)
UpdateQueue         PROCEDURE(STRING Sector,STRING Name,QUEUE Q,*? F1,<*? F2>,<*? F3>,<*? F4>)
UpdateQ             PROCEDURE(STRING pSection, *QUEUE pQ)
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
Translate             PROCEDURE(*STRING Str, *STRING RVal, UNSIGNED Level),UNSIGNED,PRIVATE
TranslateControl      PROCEDURE(SHORT ControlID,<WINDOW Win>),VIRTUAL                           !Translates a given control
TranslateControls     PROCEDURE(SHORT FirstControlID,SHORT LastControlID,<WINDOW Win>),VIRTUAL  !Translates a range of controls
TranslateProperty     PROCEDURE(USHORT Property,SHORT CtrlID,<WINDOW Win>),VIRTUAL              !Translates a given property of a control
TranslateString       PROCEDURE(STRING TextProp),STRING,VIRTUAL                                 !Looks up the TextProp & returns replacement
TranslateWindow       PROCEDURE(<WINDOW Win>),VIRTUAL                                           !Translates a whole window
                    END

CalendarBaseClass   CLASS,TYPE,MODULE('ABUTIL.CLW'),LINK('ABUTIL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
CtrlExit              SHORT,PROTECTED
CtrlToday             SHORT,PROTECTED
CtrlDay1              SHORT,PROTECTED
CtrlDay42             SHORT,PROTECTED
CtrlPrevMonth         SHORT,PROTECTED
CtrlNextMonth         SHORT,PROTECTED
CtrlPrevYear          SHORT,PROTECTED
CtrlNextYear          SHORT,PROTECTED
CtrlMore7             SHORT,PROTECTED
CtrlLess7             SHORT,PROTECTED
CtrlMore15            SHORT,PROTECTED
CtrlLess15            SHORT,PROTECTED
CtrlCurrTime          SHORT,PROTECTED
CtrlMonthYear         SHORT,PROTECTED
CtrlTheDate           SHORT,PROTECTED
CtrlCurrTime          LONG,PROTECTED
CtrlMonthYear         STRING(15),PROTECTED
CtrlTheDate           LONG,PROTECTED
CtrlTitleBG           SHORT,PROTECTED
CtrlBodyBG            SHORT,PROTECTED
CtrlSun               SHORT,PROTECTED
XPos                  LONG,PROTECTED
YPos                  LONG,PROTECTED
Response              BYTE
FirstWeekDay          BYTE(7) ! must be from 1 to 7 1-Mon and 7-Sun
SelectedDate          LONG
ColorSunday           LONG(00000FFH)
ColorSaturday         LONG(00000FFH)
ColorOther            LONG(0)
ColorHoliday          LONG(0008000H)
SelectOnClose         BYTE(0)
RightAlignment        BYTE(0)
Ask                   PROCEDURE(LONG pDate=0),LONG,PROC
Ask                   PROCEDURE(STRING pTitle,LONG pDate=0),LONG,PROC,VIRTUAL
SetUp                 PROCEDURE(),VIRTUAL
SetPosition           PROCEDURE(LONG pXPos,LONG pYPos)
IsHoliday             PROCEDURE(BYTE pDay,BYTE pMonth,SHORT pYear,BYTE pWeekDay),BYTE,VIRTUAL
SetColor              PROCEDURE(LONG pColorSaturday,LONG pColorSunday,LONG pColorOther,LONG pColorHoliday)
                    END

CalendarClass       CLASS(CalendarBaseClass),TYPE,MODULE('ABUTIL.CLW'),LINK('ABUTIL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Ask                   PROCEDURE(STRING pTitle,LONG pDate=0),LONG,PROC,VIRTUAL
SetUp                 PROCEDURE(),VIRTUAL
                    END
CalendarSmallClass  CLASS(CalendarBaseClass),TYPE,MODULE('ABUTIL.CLW'),LINK('ABUTIL.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Ask                   PROCEDURE(STRING pTitle,LONG pDate=0),LONG,PROC,VIRTUAL
SetUp                 PROCEDURE(),VIRTUAL
                    END

  _EndOfInclude_
