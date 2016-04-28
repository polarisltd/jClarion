! Process server header module

!ABCIncludeFile

  OMIT('_EndOfInclude_',_WindowsPresent_)
_WindowsPresent_   EQUATE(1)

  ITEMIZE,PRE(Delete)
None EQUATE
Warn EQUATE
Form EQUATE
Auto EQUATE
  END

  ITEMIZE,PRE(Insert)
None   EQUATE
Caller EQUATE
Batch  EQUATE
Query  EQUATE
  END

  ITEMIZE,PRE(Cancel)
Cancel  EQUATE(0)
Save    EQUATE(1)
Query   EQUATE(2)   ! Bitwise-OR ed
  END

ProcessorQueue QUEUE,TYPE
P &RecordProcessor
  END

RecordProcessor INTERFACE
TakeRecord          PROCEDURE,BYTE,VIRTUAL,PROC
TakeClose           PROCEDURE,BYTE,PROC,VIRTUAL
  END

WindowComponent INTERFACE
Kill         PROCEDURE
Reset        PROCEDURE(BYTE Force)
ResetRequired PROCEDURE,BYTE      ! 1 if reset of window required
SetAlerts    PROCEDURE
TakeEvent    PROCEDURE,BYTE
Update       PROCEDURE            ! Everything but the window!
UpdateWindow PROCEDURE
  END

WindowManager CLASS,TYPE,MODULE('ABWINDOW.CLW'),LINK('ABWINDOW.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
AutoRefresh    BYTE
AutoToolbar    BYTE
Buttons        &ButtonList,PRIVATE
CL             &ComponentList,PRIVATE
CancelAction   BYTE
ChangeAction   BYTE
Dead           BYTE,PROTECTED
DeleteAction   BYTE
Errors         &ErrorClass
Files          &FileList,PRIVATE
FilesOpened    BYTE,PROTECTED
FirstField     SIGNED
ForcedReset    BYTE
History        &HistoryList,PRIVATE
HistoryKey     SIGNED
Inited         BYTE,PRIVATE
InsertAction   BYTE
LastInsertedPosition STRING(1024),PRIVATE
OkControl      SIGNED
Opened         BYTE
OriginalRequest BYTE
Primary        &RelationManager
Request        BYTE
ResetOnGainFocus  BYTE
Resize         &WindowResizeClass
Response       BYTE
Saved          USHORT,PROTECTED
Toolbar        &ToolbarClass,PRIVATE
Translator     &TranslatorClass,PROTECTED
VCRRequest     &LONG                       ! Public so 'children' can get at value
AddHistoryField PROCEDURE(SIGNED Control,SIGNED FieldNumber)
AddHistoryFile PROCEDURE(*GROUP RecBuf,*GROUP HistBuf)
AddItem        PROCEDURE(BrowseClass BC)
AddItem        PROCEDURE(SIGNED Control,BYTE Action)  ! Perform 'action' when 'control' accepted
AddItem        PROCEDURE(ToolbarClass TC)
AddItem        PROCEDURE(ToolbarUpdateClass TF)
AddItem        PROCEDURE(TranslatorClass Translator)
AddItem        PROCEDURE(WindowComponent WC)
AddItem        PROCEDURE(WindowResizeClass RC)
AddUpdateFile  PROCEDURE(FileManager FM)
Ask            PROCEDURE,VIRTUAL
RemoveItem     PROCEDURE(WindowComponent WC)
Init           PROCEDURE,BYTE,VIRTUAL,PROC
Kill           PROCEDURE,PROC,BYTE,VIRTUAL    ! Level:Notify means dead already
Open           PROCEDURE,VIRTUAL
PostCompleted  PROCEDURE
PrimeFields    PROCEDURE,PROC,VIRTUAL
PrimeUpdate    PROCEDURE,PROC,BYTE,VIRTUAL
Reset          PROCEDURE(BYTE Force=0),VIRTUAL
ResetBuffers   PROCEDURE(BYTE Force=0),PRIVATE
RestoreField   PROCEDURE(SIGNED Control),VIRTUAL
Run            PROCEDURE,BYTE,VIRTUAL,PROC
Run            PROCEDURE(USHORT Number,BYTE Request),BYTE,VIRTUAL,PROC
SaveHistory    PROCEDURE,PROTECTED
SetAlerts      PROCEDURE,VIRTUAL
SetResponse    PROCEDURE(BYTE Response),VIRTUAL
TakeAccepted   PROCEDURE,VIRTUAL,BYTE,PROC
TakeCompleted  PROCEDURE,BYTE,PROC,VIRTUAL
TakeCloseEvent PROCEDURE,BYTE,PROC,VIRTUAL
TakeEvent      PROCEDURE,VIRTUAL,BYTE,PROC
TakeFieldEvent PROCEDURE,VIRTUAL,BYTE,PROC
TakeNewSelection PROCEDURE,VIRTUAL,BYTE,PROC
TakeRejected   PROCEDURE,VIRTUAL,BYTE,PROC
TakeSelected   PROCEDURE,VIRTUAL,BYTE,PROC
TakeWindowEvent  PROCEDURE,VIRTUAL,BYTE,PROC
Update         PROCEDURE,VIRTUAL
  END

ImageManager CLASS,IMPLEMENTS(RecordProcessor),TYPE,MODULE('ABWINDOW.CLW'),DLL(_ABCDllMode_)
Control SIGNED,PRIVATE
Fld     ANY,PRIVATE
Blb     &BLOB
AddItem PROCEDURE(SIGNED Control, *? Field)
AddItem PROCEDURE(SIGNED Control, BLOB Field)
  END

  INCLUDE('ABRESIZE.INC'),ONCE
  INCLUDE('ABBROWSE.INC'),ONCE
  INCLUDE('ABTOOLBA.INC'),ONCE

  _EndOfInclude_
