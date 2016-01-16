!File Drop Box Managers
! ***** Warning *****
! Unlike the other ABC headers files this one is -not- in its' final form
! and the interface is liable to change in future releases

!ABCIncludeFile

  OMIT('_EndOfInclude_',_FileDropBoxesPresent_)
_FileDropBoxesPresent_  EQUATE(1)

  INCLUDE('ABFILE.INC'),ONCE
  INCLUDE('ABWINDOW.INC'),ONCE


FileDropClass       CLASS(ViewManager),IMPLEMENTS(WindowComponent),MODULE('ABDROPS.CLW'),TYPE,LINK('ABDROPS.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
DisplayFields         &FieldPairsClass,PRIVATE                                              !Ref's to FieldPairsClass
UpdateFields          &FieldPairsClass,PRIVATE
Window                &WindowManager,PRIVATE
DefaultFill           BYTE
InitSyncPair          BYTE
AllowReset            BYTE
ListControl           SIGNED,PRIVATE                                                        !Feq of control
ListField             SIGNED,PRIVATE
ListQueue             &QUEUE,PRIVATE                                                        !Reference to list box queue
Loaded                BYTE,PRIVATE
ViewPosition          &STRING,PRIVATE                                                       !Reference to view

AddField              PROCEDURE(*? Source,*? Destination)                                   !Adds a display pair
AddRecord             PROCEDURE(),BYTE,VIRTUAL,PROTECTED                                    !Adds a record to ListQueue
AddUpdateField        PROCEDURE(*? Source,*? Destination)                                   !Adds an update field pair
BufferMatches         PROCEDURE,BYTE,PRIVATE,VIRTUAL
Init                  PROCEDURE(SIGNED Listbox,*STRING Position,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)  !Initializes
Kill                  PROCEDURE,VIRTUAL                                                     !Kills
ResetQueue            PROCEDURE(BYTE Force=0),LONG,PROC,VIRTUAL                                                  !Rebuilds queue from View
SetQueueRecord        PROCEDURE,VIRTUAL                                                     !Fills a queue record
TakeAccepted          PROCEDURE(),VIRTUAL
TakeEvent             PROCEDURE(),VIRTUAL                                                      !Takes event from accept loop
TakeNewSelection      PROCEDURE(),VIRTUAL
TakeNewSelection      PROCEDURE(SIGNED Field),VIRTUAL
ValidateRecord        PROCEDURE(),BYTE,VIRTUAL                                               !Tests every record for inclusion during queue building
                    END


FileDropComboClass  CLASS(FileDropClass),MODULE('ABDROPS.CLW'),TYPE,LINK('ABDROPS.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
AskProcedure          USHORT
UseField              ANY,PROTECTED                                                         !Reference to combos use variable
ButtonField           SIGNED,PRIVATE
EntryField            SIGNED,PRIVATE
EntryCompletion       BYTE
RemoveDuplicatesFlag  BYTE                                                                  !Set True to not add duplicate records
ErrMgr                &ErrorClass,PRIVATE
AutoAddFlag           BYTE,PRIVATE                                                          !Set to True to allow auto-add new records
CaseSensitiveFlag     BYTE,PRIVATE                                                          !Set True to force case sensitive comparisons
SyncronizeViewFlag    BYTE,PRIVATE                                                          !Set True to keep the file buffers syncronized with the current list box choice
PromptCaption         PSTRING(80),PRIVATE
PromptText            PSTRING(256),PRIVATE
ECOn                  BYTE,PROTECTED                                                   !Current state of entry completion, varies with keystrokes

AddRecord             PROCEDURE(),BYTE,DERIVED,PROTECTED                               !Adds a record to ListQueue
Ask                   PROCEDURE,VIRTUAL,BYTE,PROTECTED                                 !Return errorlevel = Level:Notify to prevent ResetQueue
BufferMatches         PROCEDURE,BYTE,DERIVED,PRIVATE
GetQueueMatch         PROCEDURE(STRING LookFor),LONG,PROTECTED
Init                  PROCEDURE(*? UseField,SIGNED Listbox,*STRING Pos,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM,ErrorClass EC,BYTE AutoAdd=1,BYTE AutoSync=1,BYTE Cased=0)
Kill                  PROCEDURE,DERIVED                                                     !Kills
KeyValid              PROCEDURE(),BYTE,VIRTUAL
ResetQueue            PROCEDURE(BYTE Force=0),LONG,PROC,DERIVED
ResetFromList         PROCEDURE,PROTECTED
TakeAccepted          PROCEDURE(),DERIVED
TakeNewSelection      PROCEDURE(),DERIVED
TakeNewSelection      PROCEDURE(SIGNED Field),DERIVED
TakeEvent             PROCEDURE(),DERIVED
UniquePosition        PROCEDURE(),LONG,PROTECTED
                    END

  _EndOfInclude_
