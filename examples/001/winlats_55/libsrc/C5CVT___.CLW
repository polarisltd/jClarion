                     MEMBER ('CONVERT.CLW')

                     INCLUDE('C5CVT___.INC'),ONCE
                     INCLUDE('ERRORS.CLW'),ONCE

                     MAP
                       AskUser (),BYTE

                       MODULE('C5CVTDRV.CLW')
                         FindDriver (FILE F),*CvtDriver
                       END
                     END

! =============================================================================

CVTWindow WINDOW('Converting'),AT(,,274,67),FONT('MS Sans Serif',8,,FONT:regular), |
         IMM,TIMER(100),GRAY,MODAL
       PROGRESS,USE(?Files),AT(15,12,243,8),RANGE(0,100)
       STRING('Phase'),AT(15,30,243,8),USE(?Phase),CENTER
       PROGRESS,USE(?Progress),AT(15,45,243,8),RANGE(0,100)
     END

! =============================================================================

BackupDir    CSTRING (FILE:MaxFilePath+1)

! =============================================================================

CVTQ                 QUEUE
CVT                    &Convert
DoConvert              BYTE
                     END

! =============================================================================

AskUser  PROCEDURE ()

SpaceKey     EQUATE(20h)

AskQ                 QUEUE
Task                   LONG
DoBackup               BYTE
FileLabel              CSTRING(129)
ConvertText            STRING(3)
ConvertIcon            LONG
BackupText             STRING(3)
BackupIcon             LONG
FileSourceName         CSTRING(FILE:MaxFileName + 1)
FileTargetName         CSTRING(FILE:MaxFileName + 1)
                     END


AskWindow WINDOW('Files being converted'),AT(,,360,160),FONT('MS Sans Serif',8,,FONT:regular),SYSTEM, |
         IMM,GRAY,RESIZE
       LIST,AT(10,10,340,100),USE(?AskList),VSCROLL,ALRT(SpaceKey),COLUMN,FORMAT('56L(1)|M~File Label~S(8)#3#@S128@36L(1)|MJ~Convert~36L(1)|MJ~Backup~106L(1)|' &|
           'M~Source File Name~S(8)106L(1)|M~Target File Name~S(8)'),FROM(AskQ)
       STRING('Press the Space key to change value'),AT(0,120,,13),USE(?Msg),FULL,CENTER,FONT(,,COLOR:Black,FONT:bold),TRN
       BUTTON('Con&vert All Files'),AT(9,136,80,14),USE(?ConvertAll)
       BUTTON('&Backup All Files'),AT(96,136,80,14),USE(?BackupAll)
       BUTTON('&Proceed'),AT(184,136,80,14),USE(?Proceed),DEFAULT
       BUTTON('Cancel'),AT(271,136,80,14),USE(?Cancel)
     END


i            UNSIGNED,AUTO
Backuped     UNSIGNED,AUTO
ReturnFlag   BYTE,AUTO

WWidth       UNSIGNED,AUTO
WHeight      UNSIGNED,AUTO
OWidth       UNSIGNED,AUTO
OHeight      UNSIGNED,AUTO
WDelta       SIGNED,AUTO
HDelta       SIGNED,AUTO

  CODE
  ReturnFlag = TRUE
  Backuped   = 0

  LOOP i = 1 TO RECORDS (CVTQ)
    GET (CVTQ, i)

    CLEAR (AskQ)

    DO SetConvertOn
    DO SetBackupOn

    AskQ.Task           = CVTQ.CVT.Task
    AskQ.FileLabel      = CVTQ.CVT.Label
    AskQ.FileTargetName = CVTQ.CVT.Dest.FileName

    IF  BAND (AskQ.Task, TASK:OpenSrc) = 0  OR  CVTQ.CVT.Src &= NULL
      AskQ.FileSourceName = '<<Not available>'
      DO SetBackupOff
    ELSE
      AskQ.FileSourceName = CVTQ.CVT.Src.FileName
    END

    ADD (AskQ)
    PUT (CVTQ)
  END

  OPEN (AskWindow)

  ?AskList {PROP:IconList, 1} = ICON:Cross
  ?AskList {PROP:IconList, 2} = ICON:Tick
  ?AskList {PROP:LineHeight } = 16

  WWidth  = AskWindow {PROP:Width}
  OWidth  = WWidth
  WHeight = AskWindow {PROP:Height}
  OHeight = WHeight

  AskWindow {PROP:MinWidth}  = WWidth
  AskWindow {PROP:MinHeight} = WHeight

  SELECT (?AskList, 1)

  ACCEPT
    CASE EVENT()
    OF  EVENT:Sized
      SYSTEM {PROP:DeferMove} = ?Cancel - ?AskList

      WWidth  = AskWindow {PROP:Width}
      WHeight = AskWindow {PROP:Height}

      WDelta = WWidth  - OWidth
      HDelta = WHeight - OHeight

      IF  WDelta <> 0
        ?Proceed {PROP:XPos} = ?Proceed {PROP:XPos} + WDelta
        ?Cancel  {PROP:XPos} = ?Cancel  {PROP:XPos} + WDelta

        ?AskList {PROP:Width}  = ?AskList {PROP:Width}  + WDelta

        WDelta = BSHIFT (WDelta, -1)

        ?AskList {PROPLIST:Width, 4} = ?AskList {PROPLIST:Width, 4} + WDelta
        ?AskList {PROPLIST:Width, 5} = ?AskList {PROPLIST:Width, 5} + WDelta
      END

      IF  HDelta <> 0
        LOOP i = ?Msg TO ?Cancel
          i {PROP:YPos} = i {PROP:YPos} + HDelta
        END

        ?Asklist {PROP:Height} = ?AskList {PROP:Height} + HDelta
      END

      OWidth  = WWidth
      OHeight = WHeight

    OF  EVENT:Accepted
      CASE ACCEPTED()
      OF   ?ConvertAll
        LOOP i = 1 TO RECORDS (AskQ)
          GET (AskQ, i)
          GET (CVTQ, i)

          DO SetConvertOn

          PUT (AskQ)
          PUT (CVTQ)
        END

      OF   ?BackupAll
        LOOP i = 1 TO RECORDS (AskQ)
          GET (AskQ, i)

          DO SetBackupOn

          PUT (AskQ)
        END

      OF   ?Cancel
        ReturnFlag = FALSE

      OROF ?Proceed
        POST (EVENT:CloseWindow)
      END

    OF  EVENT:AlertKey
      IF  FIELD() = ?AskList  AND  KEYCODE() = SpaceKey
        GET (AskQ, CHOICE (?AskList))
        GET (CVTQ, POINTER (AskQ))

        CASE ?AskList {PROP:Column}
        OF   1
        OROF 2
          IF  CVTQ.DoConvert
            DO SetConvertOff
          ELSE
            DO SetConvertOn
          END

          PUT (CVTQ)

        OF   3
          IF  BAND (AskQ.Task, TASK:OpenSrc) = 0
            CYCLE
          END

          IF  AskQ.DoBackup
            IF  NOT CVTQ.CVT.CheckNames ()
              DO SetBackupOff
            END
          ELSE
            DO SetBackupOn
          END

        OF   4
          IF  BAND (AskQ.Task, TASK:OpenSrc) = 0
            CYCLE
          END

          IF  NOT CVTQ.CVT.Src &= NULL
            IF  CVTQ.CVT.Src.AskName (TRUE, AskQ.FileLabel)
              AskQ.FileSourceName = CVTQ.CVT.Src.FileName

              IF  NOT AskQ.FileTargetName
                AskQ.FileTargetName    = AskQ.FileSourceName
                CVTQ.CVT.Dest.FileName = AskQ.FileSourceName
                DO SetBackupOn
              END

              PUT (CVTQ)
            END
          END

        OF   5
          IF  CVTQ.CVT.Dest.AskName (FALSE, AskQ.FileLabel)
            AskQ.FileTargetName = CVTQ.CVT.Dest.FileName

            IF  NOT AskQ.FileSourceName  AND  NOT CVTQ.CVT.Src &= NULL
              AskQ.FileSourceName   = AskQ.FileTargetName
              CVTQ.CVT.Src.FileName = AskQ.FileTargetName
              DO SetBackupOn
            END

            PUT (CVTQ)
          END
        END

        PUT (AskQ)
      END
    END
  END

  CLOSE (AskWindow)

  IF  NOT ReturnFlag
    FREE (AskQ)
    RETURN FALSE
  END

  IF Backuped <> 0
    BackupDir = CLIP (LONGPATH())

    IF  BackupDir [LEN (BackupDir)] <> '\'
      BackupDir = BackupDir & '\'
    END

    BackupDir = BackupDir & 'BACKUP'

    IF  FILEDIALOG ('Choose the Backup directory',                   |
                    BackupDir,                                       |
                    'All directories|*.*',                           |
                    FILE:KeepDir + FILE:NoError + FILE:LongName + FILE:Directory)
      IF  BackupDir [LEN (BackupDir)] <> '\'
        BackupDir = BackupDir & '\'
      END
    END
  END

  LOOP i = 1  TO  RECORDS (AskQ)
    GET (AskQ, i)
    GET (CVTQ, i)

    IF  AskQ.DoBackup  OR  CVTQ.CVT.CheckNames()
      CVTQ.CVT.Task = BOR (CVTQ.CVT.Task, TASK:Backup)
    ELSE
      CVTQ.CVT.Task = BAND (CVTQ.CVT.Task, 0FFFFFFFFh - TASK:Backup)
    END

    PUT (CVTQ)
  END

  FREE (AskQ)
  RETURN TRUE


SetConvertOn  ROUTINE
  CVTQ.DoConvert   = TRUE
  AskQ.ConvertText = 'Yes'
  AskQ.ConvertIcon = 2
  EXIT

SetConvertOff  ROUTINE
  CVTQ.DoConvert   = FALSE
  AskQ.ConvertText = 'No'
  AskQ.ConvertIcon = 1
  EXIT

SetBackupOn  ROUTINE
  AskQ.DoBackup   = TRUE
  AskQ.backupText = 'Yes'
  AskQ.BackupIcon = 2
  Backuped       += 1
  EXIT

SetBackupOff  ROUTINE
  AskQ.DoBackup   = FALSE
  AskQ.backupText = 'No'
  AskQ.BackupIcon = 1
  Backuped       -= 1
  EXIT

! =============================================================================

DoCVT  PROCEDURE ()

IdxFile              UNSIGNED,AUTO
NextFile             BOOL,AUTO
TimerValue           LONG,AUTO

  CODE
  IF  NOT AskUser()
    RETURN
  END

  OPEN (CVTWindow)

  ACCEPT
    CASE EVENT()
    OF   EVENT:OpenWindow
      IdxFile   = 0
      NextFile  = TRUE

      ?Files {PROP:RangeLow}  = 0
      ?Files {PROP:RangeHigh} = RECORDS (CVTQ)
      ?Files {PROP:Progress}  = 0

    OF   EVENT:BuildKey
      ?Progress {PROP:Progress} = CVTQ.CVT.Dest.File {PROP:Completed}

    OF   EVENT:Timer
      TimerValue = CVTWindow {PROP:Timer}
      CVTWindow {PROP:Timer} = 0

      IF  NextFile
        NextFile = FALSE

        LOOP
          IdxFile += 1

          IF  IdxFile > RECORDS (CVTQ)
            BREAK
          END

          GET (CVTQ, IdxFile)
        UNTIL CVTQ.DoConvert

        IF  IdxFile > RECORDS (CVTQ)
          POST (EVENT:CloseWindow)
          CYCLE
        END

        CVTQ.CVT.State       = STATE:Init
        CVTQ.CVT.CurrentTask = TASK:Initiate
      END

      CVTQ.CVT.Make()

      IF  CVTQ.CVT.State = STATE:Completed
        ?Files {PROP:Progress} = IdxFile
        NextFile = TRUE
      END

      CVTWindow {PROP:Timer} = TimerValue
    END
  END

  FREE (CVTQ)

  CLOSE (CVTWindow)
  RETURN

! =============================================================================
! Table class - Common properties of tables
! =============================================================================

BaseTable.Init  PROCEDURE ()                     ! VIRTUAL
  CODE
  RETURN

! Possible extension in derived classes:
! - initializing information about related tables

! -----------------------------------------------------------------------------

BaseTable.Open  PROCEDURE ()                     ! VIRTUAL
  CODE
  OPEN (SELF.File, 12h)

  IF  ERRORCODE() <> 0
    SELF.ErrorMessage ('Unable to open %n')
    RETURN RC:Error
  END

  SELF.Opened = TRUE
  RETURN RC:Ok

! Possible extensions in derived classes:
! - opening related tables
! - setting filters

! -----------------------------------------------------------------------------

BaseTable.Close  PROCEDURE ()                    ! VIRTUAL
  CODE
  IF  SELF.Opened
    CLOSE (SELF.File)
    SELF.Opened = FALSE
  END
  RETURN

! Possible extension in derived classes:
! - closing related tables

! -----------------------------------------------------------------------------

BaseTable.Drop  PROCEDURE ()                     ! VIRTUAL
  CODE
  SELF.Close()
  REMOVE (SELF.FileName)
  RETURN

! -----------------------------------------------------------------------------

BaseTable.GetTmpName  PROCEDURE ()

TmpName      CSTRING (FILE:MaxFileName+1),AUTO
idx          UNSIGNED,AUTO

  CODE
  TmpName = CLIP (LONGPATH (SELF.FileName))

  idx = LEN (TmpName)

  LOOP WHILE TmpName [idx] <> '\'
    idx -= 1
  UNTIL idx = 0

  RETURN BackupDir & TmpName [idx + 1 : LEN (TmpName)]

! -----------------------------------------------------------------------------

BaseTable.Backup  PROCEDURE ()                   ! VIRTUAL
  CODE
  RETURN SELF.Driver.Backup (SELF)

! -----------------------------------------------------------------------------

BaseTable.Inform  PROCEDURE (STRING _Msg)
  CODE
  ?Phase {PROP:Text} = CLIP (_Msg)
  DISPLAY (?Phase)

  RETURN

! -----------------------------------------------------------------------------

BaseTable.ErrorMessage  PROCEDURE (STRING _Msg)
  CODE
  MESSAGE (SELF.Subst (_Msg) & '<13,10>Error: ' &                      |
           CHOOSE (ERRORCODE() = FileSystemErr, FILEERROR(), ERROR()), |
           'Error', ICON:Hand)
  RETURN

! -----------------------------------------------------------------------------

BaseTable.AskName  PROCEDURE (BOOL _MustExist, <STRING FileLabel>) ! VIRTUAL

Flags      BYTE,AUTO
Title      CSTRING(129),AUTO

  CODE
  Flags = FILE:KeepDir + FILE:LongName

  IF  NOT _MustExist
    Flags += FILE:NoError
  END

  Title = 'Choose a table '                             & |
          CHOOSE (OMITTED (3), SELF.Label, FileLabel)   & |
          CHOOSE (_MustExist, ' (Source)', ' (Target)')

  RETURN SELF.Driver.AskName (SELF, Flags, Title)

! -----------------------------------------------------------------------------

BaseTable.Subst  PROCEDURE (STRING _msg)

Res      CSTRING(1024),AUTO
S        &STRING,AUTO
idx      UNSIGNED,AUTO

  CODE
  CLEAR (Res)

  S  &= _msg
  idx = 1

  LOOP WHILE idx < SIZE (S)
    S  &= S [idx : SIZE (S)]
    idx = INSTRING ('%', S, 1, 1)

    CASE idx
    OF   0
    OROF SIZE (S)
      Res = Res & CLIP (S)
      BREAK
    OF   1
    ELSE
      Res = Res & S [1 : idx - 1]
    END

    CASE VAL (S [idx + 1])
    OF  VAL ('%')
      Res = Res & '%'
    OF  VAL ('f')
      Res = Res & SELF.Label
    OF  VAL ('n')
      Res = Res & SELF.FileName
    ELSE
      Res  = Res & '%'
      idx -= 1
    END

    idx += 2
  END

  RETURN Res

! =============================================================================
! SrcTable class - Source table properties
! =============================================================================

SrcTable.Init  PROCEDURE ()                      ! VIRTUAL
  CODE
  PARENT.Init()

  IF  NOT SELF.FileName
    SELF.AskName (TRUE)
  END
  RETURN

! -----------------------------------------------------------------------------

SrcTable.Open  PROCEDURE ()                      ! VIRTUAL

RC         RCCODE,AUTO

  CODE
  IF  PARENT.Open() = RC:Error
    RETURN RC:Error
  END

  RC = SELF.Driver.FileSize (SELF, SELF.FileSize)! VIRTUAL call

  IF  RC = RC:Ok
    SELF.SpeedUpOn ()                            ! VIRTUAL call
    RC = SELF.SetOrder ()                        ! VIRTUAL call
  END

  RETURN RC

! -----------------------------------------------------------------------------

SrcTable.Close  PROCEDURE ()                     ! VIRTUAL
  CODE
  SELF.SpeedUpOff ()                             ! VIRTUAL call
  PARENT.Close ()

  RETURN

! -----------------------------------------------------------------------------

SrcTable.SetOrder  PROCEDURE ()                  ! VIRTUAL

RC         RCCODE,AUTO

  CODE
  RC = SELF.Driver.SetOrder (SELF)               ! VIRTUAL call

  IF  RC <> RC:Ok
    SELF.ErrorMessage ('Unable set access order for %n')
  END

  RETURN RC

! -----------------------------------------------------------------------------

SrcTable.Read  PROCEDURE ()                      ! VIRTUAL

RC         RCCODE,AUTO

  CODE
  RC = SELF.Driver.Read (SELF)                   ! VIRTUAL call

  IF  RC = RC:Error
    SELF.ErrorMessage ('Error reading %n')
  END

  RETURN RC

! -----------------------------------------------------------------------------

SrcTable.SpeedUpOn  PROCEDURE ()                 ! VIRTUAL

RC         RCCODE,AUTO

  CODE
  RC = SELF.Driver.SpeedUpOn (SELF)              ! VIRTUAL call

  IF  RC = RC:Ok
    SELF.Streamed = TRUE
  END

  RETURN

! -----------------------------------------------------------------------------

SrcTable.SpeedUpOff  PROCEDURE ()                ! VIRTUAL
  CODE
  IF  SELF.Streamed
    SELF.Driver.SpeedUpOff (SELF)                ! VIRTUAL call

    SELF.Streamed = FALSE
  END

  RETURN

! -----------------------------------------------------------------------------

SrcTable.Filter  PROCEDURE ()                    ! VIRTUAL
  CODE
  RETURN RC:Ok

! Possible extensions/changes in derived classes:
! - obvious

! -----------------------------------------------------------------------------

SrcTable.Percent  PROCEDURE ()
  CODE
  RETURN INT (100 * SELF.WasRead / SELF.FileSize)

! =============================================================================
! DestTable class - Destination tables properties
! =============================================================================

DestTable.Init  PROCEDURE ()                     ! VIRTUAL
  CODE
  PARENT.Init()

  IF  NOT SELF.FileName
    SELF.AskName (FALSE)
  END
  RETURN

! -----------------------------------------------------------------------------

DestTable.CreateTable  PROCEDURE ()              ! VIRTUAL

RC         RCCODE,AUTO

  CODE
  RC = SELF.Driver.CreateTable (SELF)

  IF  RC <> RC:Ok
    SELF.ErrorMessage ('Unable to create %n')
  END

  RETURN RC

! Possible extensions/changes in derived classes:
! - writing information to the LOG file

! -----------------------------------------------------------------------------

DestTable.Write  PROCEDURE ()                    ! VIRTUAL

RC         RCCODE,AUTO

  CODE
  RC = SELF.Driver.Write (SELF)

  IF  RC <> RC:Ok
    SELF.ErrorMessage ('Unable to write to %n')
  END

  RETURN RC

! Possible extensions/changes in derived classes:
! - writing information to the LOG file

! -----------------------------------------------------------------------------

DestTable.StartTransaction  PROCEDURE ()         ! VIRTUAL

RC         RCCODE,AUTO

  CODE
  RC = SELF.Driver.StartTransaction (SELF)

  IF  RC = RC:Ok
    SELF.InTransaction = TRUE
  ELSE
    SELF.ErrorMessage ('Unable to initiate transaction for %n')
  END

  RETURN RC

! Possible extensions/changes in derived classes:
! - logging additional tables
! - making copy of destination table

! -----------------------------------------------------------------------------

DestTable.StopTransaction  PROCEDURE (BYTE _Success) ! VIRTUAL
  CODE
  IF  SELF.InTransaction
    SELF.Driver.StopTransaction (_Success)

    SELF.InTransaction = FALSE
  END
  RETURN

! Possible extensions/changes in derived classes:
! - restoring table from the copy

! -----------------------------------------------------------------------------

DestTable.Replace  PROCEDURE ()                  ! VIRTUAL
  CODE
  RETURN SELF.Rename ()                          ! VIRTUAL call

! -----------------------------------------------------------------------------

DestTable.Rename  PROCEDURE ()                   ! VIRTUAL
  CODE
  SELF.Close ()                                  ! VIRTUAL call

  IF  NOT SELF.TargetName &= NULL
    RENAME (SELF.File, SELF.TargetName)

    IF  ERRORCODE()
      SELF.ErrorMessage ('Unable to RENAME %f to ' & CLIP (SELF.TargetName))
      RETURN RC:Error
    END
  END

  RETURN RC:Ok

! -----------------------------------------------------------------------------

DestTable.Backup  PROCEDURE ()
  CODE
  RETURN RC:Ok

! -----------------------------------------------------------------------------

DestTable.DropKeys  PROCEDURE ()                 ! VIRTUAL
  CODE
  RETURN SELF.Driver.DropKeys (SELF)

! -----------------------------------------------------------------------------

DestTable.BuildKeys  PROCEDURE ()                ! VIRTUAL
  CODE
  RETURN SELF.Driver.BuildKeys (SELF)

! =============================================================================
! Convert class - conversion job executor
! =============================================================================

Convert.Construct  PROCEDURE ()
  CODE
  CVTQ.CVT &= SELF
  ADD (CVTQ)
  RETURN

! -----------------------------------------------------------------------------

Convert.Make  PROCEDURE ()

RC      RCCODE,AUTO

  CODE
  LOOP
    CASE SELF.State
    OF   STATE:Init
      SELF.State = STATE:NextTask
      SELF.Init()
                                                 ! VIRTUAL call
    OF   STATE:NextTask
      LOOP
        SELF.CurrentTask *= 2
      UNTIL BAND (SELF.Task, SELF.CurrentTask)

    OROF STATE:Continue
      SELF.State = STATE:NextTask

      RC = RC:Ok

      CASE SELF.CurrentTask
      OF   TASK:Backup                           ! BACKUP  Original State
        RC = SELF.Backup()

      OF   TASK:CreateDest                       ! CREATE  Destination Table
        RC = SELF.Dest.CreateTable ()

      OF   TASK:OpenDest                         ! OPEN    Destination Table
        RC = SELF.Dest.Open()

      OF   TASK:OpenSrc                          ! OPEN    Source Table
        RC = SELF.OpenSrc()

      OF   TASK:AlterDest                        ! ALTER   Destination Table
        RC = SELF.AlterTable()

      OF   TASK:UpdateDest                       ! UPDATE  Destination Table
        RC = SELF.UpdateTable()

      OF   TASK:CloseSrc                         ! CLOSE   Source Table
        SELF.CloseSrc ()

      OF   TASK:DropSrc                          ! DROP    Source Table
        SELF.DropSrc ()

      OF   TASK:DropKeys                         ! DROP    Keys/Indexes
        RC = SELF.Dest.DropKeys()

      OF   TASK:BuildKeys                        ! BUILD   Keys
        RC = SELF.Dest.BuildKeys()

      OF   TASK:CloseDest                        ! CLOSE   Destination Table
        SELF.Dest.Close ()

      OF   TASK:Replace                          ! REPLACE Src Table with Destination one
        RC = SELF.Dest.Replace ()

      OF   TASK:Rename                           ! RENAME  Destination Table
        RC = SELF.Dest.Rename ()

      OF   TASK:Drop                             ! DROP    (Destination) Table
        SELF.Drop()

      OF   TASK:Rollback                         ! RESTORE Original State
        SELF.Rollback()
      END

      IF  RC = RC:Error
        IF  SELF.CurrentTask <> TASK:Rollback
          SELF.Task        = TASK:Rollback
          SELF.CurrentTask = TASK:Rollback
          SELF.State       = STATE:Continue
          CYCLE
        END
      END
    END

    CASE SELF.State
    OF   STATE:NextTask
    OROF STATE:NoIdle
      SELF.Task -= SELF.CurrentTask
    END

    IF  SELF.Task = 0
      SELF.State = STATE:Completed
    END

    IF  SELF.State <> STATE:NoIdle
      BREAK
    END

    SELF.State = STATE:NextTask
  END

  RETURN

! -----------------------------------------------------------------------------

Convert.Init  PROCEDURE ()                       ! VIRTUAL

TheSameName  BYTE,AUTO

  CODE
  IF  NOT SELF.Src &= NULL
    SELF.Src.Label &= SELF.Label
    SELF.Src.Init()                              ! VIRTUAL call

    TheSameName = CHOOSE (BAND (SELF.Task, TASK:UpdateDest), TRUE, FALSE)
  ELSE
    IF  BAND (SELF.Task, TASK:Replace)
      SELF.Task -= TASK:Replace
    END

    TheSameName = FALSE
  END

  SELF.Dest.Label &= SELF.Label
  SELF.Dest.Init()                               ! VIRTUAL call

  IF  TheSameName  AND  SELF.CheckNames ()
    SELF.Task = BOR (SELF.Task, TASK:Backup)
  END

  IF  SELF.RecordsPerQuant = 0
    SELF.RecordsPerQuant = 100
  END

  SELF.Display ()                                ! VIRTUAL call
  RETURN

! Possible extensions/changes in derived classes:
! - changing LOCALE settings
! - additional initialization code

! -----------------------------------------------------------------------------

Convert.Link  PROCEDURE ()                       ! VIRTUAL
  CODE
  IF  NOT SELF.Src &= NULL
    SELF.Src.Driver &= FindDriver (SELF.Src.File)
  END

  SELF.Dest.Driver &= FindDriver (SELF.Dest.File)
  RETURN

! Possible extensions/changes in derived classes:
! - any desirable pre-Init actions

! -----------------------------------------------------------------------------

Convert.AlterTable  PROCEDURE ()                 ! VIRTUAL
  CODE
  RETURN RC:Ok

! Possible extensions/changes in derived classes:
! - SQL statements for altering table layout

! -----------------------------------------------------------------------------

Convert.UpdateTable  PROCEDURE ()                ! VIRTUAL

RC      RCCODE,AUTO

  CODE
  IF  SELF.Dest.StartTransaction() = RC:Error    ! VIRTUAL call
    RETURN RC:Error
  END

  LOOP SELF.RecordsPerQuant TIMES
    RC = SELF.ReadSrc()

    CASE RC
    OF   RC:Filtered
      CYCLE
    OF   RC:OutOfRange
    OROF RC:EOF
      SELF.State = STATE:NextTask
      BREAK
    OF   RC:Error
      SELF.Dest.StopTransaction (FALSE)          ! VIRTUAL call
      RETURN RC:Error
    END

    SELF.Assign ()                               ! VIRTUAL call

    IF  SELF.Dest.Write() = RC:Error             ! VIRTUAL call
      SELF.Dest.StopTransaction (FALSE)          ! VIRTUAL call
      RETURN RC:Error
    END

    SELF.State = STATE:Continue
  END

  SELF.Dest.StopTransaction (TRUE)               ! VIRTUAL call
  RETURN RC

! -----------------------------------------------------------------------------

Convert.Backup  PROCEDURE ()                     ! VIRTUAL
  CODE
  IF  NOT SELF.Src &= NULL
    IF  SELF.Src.Backup() = RC:Error
      RETURN RC:Error
    END
  END

  RETURN SELF.Dest.Backup()

! -----------------------------------------------------------------------------

Convert.Rollback  PROCEDURE ()                   ! VIRTUAL
  CODE
  IF  NOT SELF.Src &= NULL
    SELF.CloseSrc ()
  END

  SELF.Dest.Close()
  RETURN

! Possible extensions/changes in derived classes:
! - restoring the previously saved state of data

! -----------------------------------------------------------------------------

Convert.OpenSrc  PROCEDURE ()

RC         RCCODE,AUTO

  CODE
  ASSERT (NOT SELF.Src &= NULL)

  RC = SELF.Src.Open()                           ! VIRTUAL call

  IF  RC = RC:Ok
    SELF.Display()
  END

  RETURN RC

! -----------------------------------------------------------------------------

Convert.CloseSrc  PROCEDURE ()
  CODE
  ASSERT (NOT SELF.Src &= NULL)

  SELF.Src.Close()                               ! VIRTUAL call

  RETURN

! -----------------------------------------------------------------------------

Convert.DropSrc  PROCEDURE ()
  CODE
  ASSERT (NOT SELF.Src &= NULL)

  SELF.Src.Drop()                                ! VIRTUAL call

  RETURN

! -----------------------------------------------------------------------------

Convert.ReadSrc  PROCEDURE ()
  CODE
  ASSERT (NOT SELF.Src &= NULL)

  CASE SELF.Src.Read()                           ! VIRTUAL call
  OF RC:Ok
    SELF.Display (SELF.Src.Percent())            ! VIRTUAL call
    RETURN SELF.Src.Filter ()                    ! VIRTUAL call
  OF RC:EOF
    SELF.Display (100)                           ! VIRTUAL call
    RETURN RC:EOF
  ELSE
    RETURN RC:Error
  END

! -----------------------------------------------------------------------------

Convert.Drop  PROCEDURE ()
  CODE
  SELF.Dest.Drop()                               ! VIRTUAL call
  RETURN

! -----------------------------------------------------------------------------

Convert.Assign  PROCEDURE ()                     ! VIRTUAL
  CODE
  ASSERT(0)
  RETURN

! Possible extensions/changes in derived classes:
! - Real assignments of fields including possible formulae
! - Copying of MEMOs and BLOBs

! -----------------------------------------------------------------------------

Convert.AssignMapped  PROCEDURE ()

SCtlS    &STRING,AUTO
DCtlS    &STRING,AUTO
SCtl     &LONG,AUTO                    ! Rerefence to current item in SCtlS
DCtl     &LONG,AUTO                    ! Reference to current item in DCtls
Idx      &LONG,AUTO                    ! Mapped index
i        UNSIGNED,AUTO
NS       UNSIGNED,AUTO
ND       UNSIGNED,AUTO
A        ANY,AUTO
V        LONG,AUTO

  CODE
  IF  SELF.FieldsMap &= NULL
?   ASSERT (0)
    RETURN
  END

  NS = SELF.Src.File {PROP:Fields}

  SCtlS &= NEW STRING (NS * SIZE (V))
  SCtl  &= ADDRESS (SCtlS)

  IF  SCtl &= NULL
?   ASSERT (0)
    RETURN
  END

  ND = SELF.Dest.File {PROP:Fields}

  DCtlS &= NEW STRING (ND * SIZE (V))
  DCtl  &= ADDRESS (DCtlS)

  IF  DCtl &= NULL
    DISPOSE (SCtlS)
?   ASSERT (0)
    RETURN
  END

  CLEAR (DCtlS, -1)

  ! --- Copy NULL values

  SCtlS = GetNULLs (SELF.Src.File)

  IF  SCtlS = ''
    CLEAR (SCtlS, -1)
  ELSE
    LOOP i = 1 TO NS
      IF  SCtl <> 0
        Idx &= ADDRESS (SELF.FieldsMap) + (i - 1) * SIZE (V)

        IF  Idx > 0
          DCtl &= ADDRESS (DCtlS) + (Idx - 1) * SIZE (V)
          DCtl  = SCtl
        END
      END

      SCtl &= ADDRESS (SCtl) + SIZE (V)
    END

    SetNULLs (SELF.Dest.File, DCtlS)
  END

  ! --- Copy regular fields

  SCtl &= ADDRESS (SCtlS)

  LOOP i = 1 TO NS
    IF  SCtl = 0
      Idx &= ADDRESS (SELF.FieldsMap) + (i - 1) * SIZE (V)

      IF  Idx > 0
        DCtl &= ADDRESS (DCtlS) + (Idx - 1) * SIZE (V)

        IF  DCtl = 0
          A &= WHAT (SELF.Dest.Record, Idx)
          A  = WHAT (SELF.Src.Record, i)

          DCtl = 1
        END
      END
    END

    SCtl &= ADDRESS (SCtl) + SIZE (V)
  END

  ! --- Exit

  A &= NULL

  DISPOSE (DCtlS)
  DISPOSE (SCtlS)

  RETURN

! -----------------------------------------------------------------------------

Convert.CheckNames  PROCEDURE ()                 ! VIRTUAL
  CODE
  IF  SELF.Src &= NULL
    RETURN FALSE
  END

  IF  LEN (SELF.Src.FileName) = 0  AND  LEN (SELF.Dest.FileName) = 0
    RETURN TRUE
  END

  IF  LONGPATH (SELF.Src.FileName) = LONGPATH (SELF.Dest.FileName)
    RETURN TRUE
  END

  RETURN FALSE

! Possible extensions/changes in derived classes:
! - Explicit return of required flag

! -----------------------------------------------------------------------------

Convert.Display  PROCEDURE (LONG _Value)         ! VIRTUAL
  CODE
  CASE SELF.CurrentTask
  OF   TASK:Initiate
    CVTWindow {PROP:Text} = 'Converting ' & SELF.Label
  OF   TASK:UpdateDest
    ?Phase {PROP:Text} = 'Converting records'

    IF  _Value <> -1
      ?Progress {PROP:Progress} = _Value
    END
  OF   TASK:OpenSrc
    ?Progress {PROP:RangeLow}  = 0
    ?Progress {PROP:RangeHigh} = 100
    ?Progress {PROP:Progress}  = 0
  END

  RETURN

! =============================================================================
