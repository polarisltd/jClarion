                     MEMBER ('CONVERT.CLW')

                     INCLUDE('C5CVT___.INC'),ONCE
                     INCLUDE('ERRORS.CLW'),ONCE

                     MAP
                       FindDriver (FILE F),*CvtDriver
                     END

DrvList              QUEUE
DrvName                CSTRING(33)
DrvRef                 &CvtDriver
                     END

! =============================================================================

CvtDriver:Simple     CLASS(CvtDriver)

Read                   PROCEDURE (BaseTable T),RCCODE,DERIVED

SpeedUpOn              PROCEDURE (BaseTable T),RCCODE,DERIVED
SpeedUpOff             PROCEDURE (BaseTable T),       DERIVED
StartTransaction       PROCEDURE (BaseTable T),RCCODE,DERIVED
StopTransaction        PROCEDURE (BOOL _Success = TRUE),DERIVED

FileSize               PROCEDURE (BaseTable T, *LONG Res),RCCODE,DERIVED
                     END

! -----------------------------------------------------------------------------

CvtDriver:ISAM       CLASS(CvtDriver)

Write                  PROCEDURE (BaseTable T),RCCODE,DERIVED
BuildKeys              PROCEDURE (BaseTable T),RCCODE,DERIVED
BuildKey               PROCEDURE (KEY K),RCCODE,DERIVED
                     END

! -----------------------------------------------------------------------------

CvtDriver:DBF        CLASS(CvtDriver:ISAM)

AskName                PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title),BYTE,PROC,DERIVED
DropKeys               PROCEDURE (BaseTable T),RCCODE,DERIVED
DropKey                PROCEDURE (KEY K),RCCODE,DERIVED
StartTransaction       PROCEDURE (BaseTable T),RCCODE,DERIVED
StopTransaction        PROCEDURE (BOOL _Success = TRUE),DERIVED
                     END

! -----------------------------------------------------------------------------

CvtDriver:SQL        CLASS(CvtDriver)

AskName                PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title),BYTE,PROC,DERIVED
CreateTable            PROCEDURE (BaseTable T),RCCODE,DERIVED
SetOrder               PROCEDURE (BaseTable T),RCCODE,DERIVED
Backup                 PROCEDURE (BaseTable T),RCCODE,DERIVED
BuildKeys              PROCEDURE (BaseTable T),RCCODE,DERIVED
!DropKeys              PROCEDURE (Table T),RCCODE,DERIVED
StartTransaction       PROCEDURE (BaseTable T),RCCODE,DERIVED
SpeedUpOn              PROCEDURE (BaseTable T),RCCODE,DERIVED
                     END

! =============================================================================

CvtDriver:AS400      CLASS(CvtDriver:SQL)

Construct              PROCEDURE ()

StartTransaction       PROCEDURE (BaseTable T),RCCODE,DERIVED
                     END
! -----------------------------------------------------------------------------

CvtDriver:ASCII      CLASS(CvtDriver:Simple)

Construct              PROCEDURE ()

AskName                PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title),BYTE,PROC,DERIVED
                     END

! -----------------------------------------------------------------------------

CvtDriver:BASIC      CLASS(CvtDriver:Simple)

Construct              PROCEDURE ()

AskName                PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title),BYTE,PROC,DERIVED
                     END

! -----------------------------------------------------------------------------

CvtDriver:Btrieve    CLASS(CvtDriver:ISAM)

Construct              PROCEDURE ()

AskName                PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title),BYTE,PROC,DERIVED
SetOrder               PROCEDURE (BaseTable T),RCCODE,DERIVED
StartTransaction       PROCEDURE (BaseTable T),RCCODE,DERIVED
                     END

! -----------------------------------------------------------------------------

CvtDriver:Clarion    CLASS(CvtDriver:ISAM)

Construct              PROCEDURE ()

AskName                PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title),BYTE,PROC,DERIVED
                     END

! -----------------------------------------------------------------------------

CvtDriver:Clipper    CLASS(CvtDriver:DBF)

Construct              PROCEDURE ()
                     END

! -----------------------------------------------------------------------------

CvtDriver:DBase3     CLASS(CvtDriver:DBF)

Construct              PROCEDURE ()
                     END

! -----------------------------------------------------------------------------

CvtDriver:DBase4     CLASS(CvtDriver:DBF)

Construct              PROCEDURE ()
                     END

! -----------------------------------------------------------------------------

CvtDriver:DOS        CLASS(CvtDriver:Simple)

Construct              PROCEDURE ()
                     END

! -----------------------------------------------------------------------------

CvtDriver:FoxPro     CLASS(CvtDriver:DBF)

Construct              PROCEDURE ()
                     END

! -----------------------------------------------------------------------------

CvtDriver:Informix   CLASS(CvtDriver:SQL)

Construct              PROCEDURE ()
                     END

! -----------------------------------------------------------------------------

CvtDriver:MSSQL      CLASS(CvtDriver:SQL)

Construct              PROCEDURE ()
                     END

! -----------------------------------------------------------------------------

CvtDriver:ODBC       CLASS(CvtDriver:SQL)

Construct              PROCEDURE ()
                     END

! -----------------------------------------------------------------------------

CvtDriver:Oracle     CLASS(CvtDriver:SQL)

Construct              PROCEDURE ()
                     END

! -----------------------------------------------------------------------------

CvtDriver:Scalable   CLASS(CvtDriver:SQL)

Construct              PROCEDURE ()
                     END

! -----------------------------------------------------------------------------

CvtDriver:SQLAnywhere CLASS(CvtDriver:SQL)

Construct              PROCEDURE ()
                     END

! -----------------------------------------------------------------------------

CvtDriver:TopSpeed   CLASS(CvtDriver:ISAM)

Construct              PROCEDURE ()

AskName                PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title),BYTE,PROC,DERIVED
                     END

! =============================================================================

FindDriver  PROCEDURE (FILE F)

Ref            &CvtDriver,AUTO

  CODE
  Ref &= NULL

  IF  NOT F &= NULL
    DrvList.DrvName = UPPER (F {PROP:Driver})
    GET (DrvList, DrvList.DrvName)

    IF  ERRORCODE() = 0
      Ref &= DrvList.DrvRef
    END
  END

  RETURN Ref

! =============================================================================
! CvtDriver - general driver interface for conversion purposes
! =============================================================================

CvtDriver.Register  PROCEDURE (*CSTRING DrvName)
  CODE
  IF  ADDRESS (DrvName) <> 0
    DrvList.DrvName = DrvName
    DrvList.DrvRef &= SELF

    ADD (DrvList, +DrvList.DrvName)
  END

  RETURN

! -----------------------------------------------------------------------------

CvtDriver.AskName  PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title)
  CODE
  RETURN FILEDIALOG (Title, T.FileName, 'All Files|*.*', Flags)

! -----------------------------------------------------------------------------

CvtDriver.CreateTable  PROCEDURE (BaseTable T)
  CODE
  CREATE (T.File)

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! Possible extensions/changes in derived classes:
! - performing CREATE TABLE for SQL
! - CREATEing additional tables, say, temporary ones.

! -----------------------------------------------------------------------------

CvtDriver.Read  PROCEDURE (BaseTable T)
  CODE
  NEXT (T.File)

  CASE ERRORCODE()
  OF 0
    T.WasRead += 1
    RETURN RC:Ok
  OF BadRecErr
    RETURN RC:EOF
  ELSE
    RETURN RC:Error
  END

! Possible extensions/changes in derived classes:
! - reading related tables
! - performing SELECT statement for SQL
! - other value for read count increment

! -----------------------------------------------------------------------------

CvtDriver.Write  PROCEDURE (BaseTable T)
  CODE
  ADD (T.File)

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! Possible extensions/changes in derived classes:
! - APPEND (File)
! - INSERT for SQL

! -----------------------------------------------------------------------------

CvtDriver.SetOrder  PROCEDURE (BaseTable T)
  CODE
  SET (T.File)

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! Possible extensions/changes in derived classes:
! - SET in key order
! - CRETATEing of cursor for SQL

! -----------------------------------------------------------------------------

CvtDriver.Backup  PROCEDURE (BaseTable T)

TmpName      CSTRING (FILE:MaxFileName+1),AUTO

  CODE
  TmpName = T.GetTmpName()

  COPY (T.File, TmpName)

  IF  ERRORCODE() = 0
    T.FileName = TmpName

    RETURN RC:Ok
  ELSE
    T.ErrorMessage ('Unable to backup %f to ' & TmpName)

    RETURN RC:Error
  END

! Possible extensions/changes in derived classes:
! - moving/renaming the table
! - processing of related tables

! -----------------------------------------------------------------------------

CvtDriver.BuildKeys  PROCEDURE (BaseTable T)
  CODE
  T.Inform ('No keys to BUILD')

  RETURN RC:Ok

! Possible extensions/changes in derived classes:
! - actual BUILDing of keys
! - CREATE INDEX for SQL

! -----------------------------------------------------------------------------

CvtDriver.BuildKey  PROCEDURE (KEY K)
  CODE
  RETURN RC:Ok

! Possible extensions/changes in derived classes:
! - actual BUILDing of key
! - CREATE INDEX for SQL

! -----------------------------------------------------------------------------

CvtDriver.DropKeys  PROCEDURE (BaseTable T)
  CODE
  T.Inform ('No keys to DROP')

  RETURN RC:Ok

! Possible extensions/changes in derived classes:
! - REMOVE key files as ordinal files
! - DROP INDEX for SQL

! -----------------------------------------------------------------------------

CvtDriver.DropKey  PROCEDURE (KEY K)
  CODE
  RETURN RC:Ok

! Possible extensions/changes in derived classes:
! - REMOVE key file as ordinal file
! - DROP INDEX for SQL

! -----------------------------------------------------------------------------

CvtDriver.SpeedUpOn  PROCEDURE (BaseTable T)
  CODE
  STREAM (T.File)

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! Possible extensions/changes in derived classes:
! - BUFFER (File,...)
! - sending driver specific Driver Strings

! -----------------------------------------------------------------------------

CvtDriver.SpeedUpOff  PROCEDURE (BaseTable T)
  CODE
  FLUSH (T.File)
  RETURN

! Possible extensions/changes in derived classes:
! - BUFFER (File,...)
! - sending driver specific Driver Strings

! -----------------------------------------------------------------------------

CvtDriver.StartTransaction  PROCEDURE (BaseTable T)
  CODE
  LOGOUT (1, T.File)

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! Possible extensions/changes in derived classes:
! - LOCK (File)
! - sending driver specific Driver Strings
! - do nothing

! -----------------------------------------------------------------------------

CvtDriver.StopTransaction  PROCEDURE (BOOL _Success)
  CODE
  IF  _Success
    COMMIT
  ELSE
    ROLLBACK
  END

!? ASSERT (ERRORCODE() = 0, '<13,10>Unable to stop transaction: ' & ERROR())

  RETURN

! Possible extensions/changes in derived classes:
! - COMMIT/ROLLBACK
! - do nothing

! -----------------------------------------------------------------------------

CvtDriver.FileSize PROCEDURE (BaseTable T, *LONG Res)
  CODE
  Res = RECORDS (T.File)

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! Possible extensions/changes in derived classes:
! - RECORDS (Key)
! - BYTES (File) for drivers with BYTE-based pointers
! - SELECT COUNT(*) for SQL

! =============================================================================
! CvtDriver:Simple - ASCII, BASIC and DOS drivers interface for conversion purposes
! =============================================================================

CvtDriver:Simple.Read  PROCEDURE (BaseTable T)
  CODE
  NEXT (T.File)

  CASE ERRORCODE()
  OF 0
    T.WasRead += BYTES (T.File)
    RETURN RC:Ok
  OF BadRecErr
    RETURN RC:EOF
  ELSE
    RETURN RC:Error
  END

! -----------------------------------------------------------------------------

CvtDriver:Simple.SpeedUpOn  PROCEDURE (BaseTable T)
  CODE
  SEND (T.File, 'QUICKSCAN=ON')

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! -----------------------------------------------------------------------------

CvtDriver:Simple.SpeedUpOff  PROCEDURE (BaseTable T)
  CODE
  SEND (T.File, 'QUICKSCAN=OFF')
  RETURN

! -----------------------------------------------------------------------------

CvtDriver:Simple.StartTransaction  PROCEDURE (BaseTable T)
  CODE
  RETURN RC:Ok

! -----------------------------------------------------------------------------

CvtDriver:Simple.StopTransaction  PROCEDURE (BOOL _Success)
  CODE
  RETURN

! -----------------------------------------------------------------------------

CvtDriver:Simple.FileSize  PROCEDURE (BaseTable T, *LONG Res)
  CODE
  Res = T.File {PROP:FileSize}

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! =============================================================================
! CvtDriver:ISAM - ISAM driver interface for conversion purposes
! =============================================================================

CvtDriver:ISAM.Write  PROCEDURE (BaseTable T)
  CODE
  APPEND (T.File)

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! -----------------------------------------------------------------------------

CvtDriver:ISAM.BuildKeys  PROCEDURE (BaseTable T)

RC        RCCODE,AUTO
_i        UNSIGNED,AUTO
_N        UNSIGNED,AUTO
_Key      &KEY

  CODE
  RC = RC:Ok
  _N = T.File {PROP:Keys}

  LOOP _i = 1 TO _N
    _Key &= T.File {PROP:Key, _i}

    IF  _Key {PROP:Type} = 'KEY'
      T.Inform ('BUILDing of ' & _Key {PROP:Label})

      RC = SELF.BuildKey (_Key)

      IF  RC <> RC:Ok
        T.ErrorMessage ('Unsuccessful BUILD for ' & _Key {PROP:Label})
      END
    END
  WHILE RC = RC:Ok

  RETURN RC

! Possible extensions/changes in derived classes:
! - calls of BuildKey method for required keys only

! -----------------------------------------------------------------------------

CvtDriver:ISAM.BuildKey  PROCEDURE (KEY K)

  CODE
  BUILD (K)

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! =============================================================================
! CvtDriver:DBF - DBF driver interface for conversion purposes
! =============================================================================

CvtDriver:DBF.AskName  PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title)
  CODE
  RETURN FILEDIALOG (Title, T.FileName, 'xBase Files|*.dbf|All|*.*', Flags)

! -----------------------------------------------------------------------------

CvtDriver:DBF.DropKeys  PROCEDURE (BaseTable T)

RC        RCCODE,AUTO
_i        UNSIGNED,AUTO
_N        UNSIGNED,AUTO
_Key      &KEY

  CODE
  RC = RC:Ok
  _N = T.File {PROP:Keys}

  LOOP _i = 1 TO _N
    _Key &= T.File {PROP:Key, _i}

    T.Inform ('DROPping of ' & _Key {PROP:Label})

    RC = SELF.DropKey (_Key)

    IF  RC <> RC:Ok
      T.ErrorMessage ('Unsuccessful DROP for ' & _Key {PROP:Label})
    END
  WHILE RC = RC:Ok

  RETURN RC

! -----------------------------------------------------------------------------

CvtDriver:DBF.DropKey  PROCEDURE (KEY K)

KeyName   CSTRING(FILE:MaxFileName + 1),AUTO
L         UNSIGNED,AUTO

  CODE
  KeyName = K {PROP:Name}

  L = INSTRING ('=', KeyName, 1, 1)

  IF  L = 0
    L = LEN (KeyName)
  END

  IF  L = 0
    RETURN RC:Error
  END

  REMOVE (KeyName [1 : L])

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! -----------------------------------------------------------------------------

CvtDriver:DBF.StartTransaction  PROCEDURE (BaseTable T)
  CODE
  RETURN RC:Ok

! -----------------------------------------------------------------------------

CvtDriver:DBF.StopTransaction  PROCEDURE (BOOL _Success)
  CODE
  RETURN

! =============================================================================
! CvtDriver:SQL - SQL driver interface for conversion purposes
! =============================================================================

CvtDriver:SQL.AskName  PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title)

TableName        CSTRING(FILE:MaxFileName+1),AUTO
Res              BYTE,AUTO

EscKey           EQUATE(27)

GetFileWindow WINDOW('Caption'),AT(,,296,98),FONT('MS Sans Serif',8,,FONT:regular), |
         IMM,SYSTEM,GRAY,AUTO
       PROMPT('&Database Name:'),AT(27,32)
       ENTRY(@s255),AT(93,31,177,10),USE(TableName)
       BUTTON('&Accept'),AT(172,64,45,14),USE(?Ok),DEFAULT
       BUTTON('Cancel'),AT(226,64,45,14),USE(?Cancel),KEY(EscKey)
     END

  CODE
  TableName = T.FileName

  OPEN (GetFileWindow)

  GetFileWindow {PROP:Text} = Title

  ACCEPT
    CASE ACCEPTED()
    OF   ?Ok
      Res = TRUE
      BREAK

    OF   ?Cancel
      Res = FALSE
      BREAK
    END
  END

  CLOSE (GetFileWindow)

  IF  NOT Res  OR  TableName[1] = '<0>'
    RETURN FALSE
  END

  T.FileName = TableName

  RETURN TRUE

! Possible extensions/changes in derived classes:
! - obtaining a list of available tables from the server

! -----------------------------------------------------------------------------

CvtDriver:SQL.CreateTable  PROCEDURE (BaseTable T)
  CODE
  RETURN RC:Ok

! -----------------------------------------------------------------------------

CvtDriver:SQL.SetOrder  PROCEDURE (BaseTable T)
  CODE
  SET (T.Key)

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! -----------------------------------------------------------------------------

CvtDriver:SQL.Backup  PROCEDURE (BaseTable T)
  CODE
  RETURN RC:Ok

! -----------------------------------------------------------------------------

CvtDriver:SQL.BuildKeys  PROCEDURE (BaseTable T)
  CODE
  RETURN RC:Ok

! -----------------------------------------------------------------------------

!CvtDriver:SQL.DropKeys  PROCEDURE (Table T)
!  CODE

! -----------------------------------------------------------------------------

CvtDriver:SQL.StartTransaction  PROCEDURE (BaseTable T)

RC        RCCODE,AUTO

  CODE
  RC = PARENT.StartTransaction (T)

  IF  RC = RC:Ok
    T.File {PROP:AppendBuffer} = 16

    RC = CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)
  END

  RETURN RC

! -----------------------------------------------------------------------------

CvtDriver:SQL.SpeedUpOn  PROCEDURE (BaseTable T)
  CODE
  BUFFER (T.File, 16,, 2)

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! =============================================================================
! CvtDriver:AS400 - AS/400 driver interface for conversion purposes
! =============================================================================

CvtDriver:AS400.Construct  PROCEDURE ()

AS400      CSTRING('AS400'),STATIC

  CODE
  SELF.Register (AS400)

  RETURN

! -----------------------------------------------------------------------------

CvtDriver:AS400.StartTransaction  PROCEDURE (BaseTable T)
  CODE
  SEND (T.File, 'USETRANSACTIONS=ON')

  RETURN PARENT.StartTransaction (T)

! =============================================================================
! CvtDriver:ASCII - ASCII driver interface for conversion purposes
! =============================================================================

CvtDriver:ASCII.Construct  PROCEDURE ()

ASCII      CSTRING('ASCII'),STATIC

  CODE
  SELF.Register (ASCII)

  RETURN

! -----------------------------------------------------------------------------

CvtDriver:ASCII.AskName  PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title)
  CODE
  RETURN FILEDIALOG (Title, T.FileName, 'Text Files|*.txt|All|*.*', Flags)

! =============================================================================
! CvtDriver:BASIC - BASIC driver interface for conversion purposes
! =============================================================================

CvtDriver:BASIC.Construct  PROCEDURE ()

BASIC      CSTRING('BASIC'),STATIC

  CODE
  SELF.Register (BASIC)

  RETURN

! -----------------------------------------------------------------------------

CvtDriver:BASIC.AskName  PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title)
  CODE
  RETURN FILEDIALOG (Title, T.FileName, 'CSV Files|*.csv|All|*.*', Flags)

! =============================================================================
! CvtDriver:Btrieve - Btrieve driver interface for conversion purposes
! =============================================================================

CvtDriver:Btrieve.Construct  PROCEDURE ()

Btrieve    CSTRING('BTRIEVE'),STATIC

  CODE
  SELF.Register (Btrieve)

  RETURN

! -----------------------------------------------------------------------------

CvtDriver:Btrieve.AskName  PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title)
  CODE
  RETURN FILEDIALOG (Title, T.FileName, 'Btrieve Files|*.dat|All|*.*', Flags)

! -----------------------------------------------------------------------------

CvtDriver:Btrieve.SetOrder  PROCEDURE (BaseTable T)
  CODE
  SET (T.Key)

  RETURN CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)

! -----------------------------------------------------------------------------

CvtDriver:Btrieve.StartTransaction  PROCEDURE (BaseTable T)

RC        RCCODE,AUTO

  CODE
  RC = PARENT.StartTransaction (T)

  IF  RC = RC:Ok
    T.File {PROP:AppendBuffer} = 16

    RC = CHOOSE (ERRORCODE() = 0, RC:Ok, RC:Error)
  END

  RETURN RC

! =============================================================================
! CvtDriver:Clarion - Clarion driver interface for conversion purposes
! =============================================================================

CvtDriver:Clarion.Construct  PROCEDURE ()

Clarion    CSTRING('CLARION'),STATIC

  CODE
  SELF.Register (Clarion)

  RETURN

! -----------------------------------------------------------------------------

CvtDriver:Clarion.AskName  PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title)
  CODE
  RETURN FILEDIALOG (Title, T.FileName, 'Clarion Files|*.dat|All|*.*', Flags)

! =============================================================================
! CvtDriver:Clipper - Clipper driver interface for conversion purposes
! =============================================================================

CvtDriver:Clipper.Construct  PROCEDURE ()

Clipper    CSTRING('CLIPPER'),STATIC

  CODE
  SELF.Register (Clipper)

  RETURN

! =============================================================================
! CvtDriver:DBase3 - DBase3 driver interface for conversion purposes
! =============================================================================

CvtDriver:DBase3.Construct  PROCEDURE ()

DBase3     CSTRING('DBASE3'),STATIC

  CODE
  SELF.Register (DBase3)

  RETURN

! =============================================================================
! CvtDriver:DBase4 - DBase4 driver interface for conversion purposes
! =============================================================================

CvtDriver:DBase4.Construct  PROCEDURE ()

DBase4     CSTRING('DBASE4'),STATIC

  CODE
  SELF.Register (DBase4)

  RETURN

! =============================================================================
! CvtDriver:DOS - DOS driver interface for conversion purposes
! =============================================================================

CvtDriver:DOS.Construct  PROCEDURE ()

DOS        CSTRING('DOS'),STATIC

  CODE
  SELF.Register (DOS)

  RETURN

! =============================================================================
! CvtDriver:FoxPro - FoxPro driver interface for conversion purposes
! =============================================================================

CvtDriver:FoxPro.Construct  PROCEDURE ()

FoxPro     CSTRING('FOXPRO'),STATIC

  CODE
  SELF.Register (FoxPro)

  RETURN

! =============================================================================
! CvtDriver:Informix - Informix driver interface for conversion purposes
! =============================================================================

CvtDriver:Informix.Construct  PROCEDURE ()

Informix   CSTRING('INFORMIX'),STATIC

  CODE
  SELF.Register (Informix)

  RETURN

! =============================================================================
! CvtDriver:MSSQL - MSSQL driver interface for conversion purposes
! =============================================================================

CvtDriver:MSSQL.Construct  PROCEDURE ()

MSSQL      CSTRING('MSSQL'),STATIC

  CODE
  SELF.Register (MSSQL)

  RETURN

! =============================================================================
! CvtDriver:ODBC - ODBC driver interface for conversion purposes
! =============================================================================

CvtDriver:ODBC.Construct  PROCEDURE ()

ODBC       CSTRING('ODBC'),STATIC

  CODE
  SELF.Register (ODBC)

  RETURN

! =============================================================================
! CvtDriver:Oracle - Oracle driver interface for conversion purposes
! =============================================================================

CvtDriver:Oracle.Construct  PROCEDURE ()

Oracle     CSTRING('ORACLE'),STATIC

  CODE
  SELF.Register (Oracle)

  RETURN

! =============================================================================
! CvtDriver:Scalable - Scalable driver interface for conversion purposes
! =============================================================================

CvtDriver:Scalable.Construct  PROCEDURE ()

Scalable   CSTRING('SCALABLE'),STATIC

  CODE
  SELF.Register (Scalable)

  RETURN

! =============================================================================
! CvtDriver:SQLAnywhere - SQLAnywhere driver interface for conversion purposes
! =============================================================================

CvtDriver:SQLAnywhere.Construct  PROCEDURE ()

SQLAnywhere CSTRING('SQLANYWHERE'),STATIC

  CODE
  SELF.Register (SQLAnywhere)

  RETURN

! =============================================================================
! CvtDriver:TopSpeed - TopSpeed driver interface for conversion purposes
! =============================================================================

CvtDriver:TopSpeed.Construct  PROCEDURE ()

TopSpeed   CSTRING('TOPSPEED'),STATIC

  CODE
  SELF.Register (TopSpeed)

  RETURN

! -----------------------------------------------------------------------------

CvtDriver:TopSpeed.AskName  PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title)

TNQ        QUEUE
TName        CSTRING(FILE:MaxFileName+1)
           END

FileName   CSTRING(FILE:MaxFileName+1),AUTO
TableName  CSTRING(FILE:MaxFileName+1),AUTO

_          GROUP
Q            &TNQ
           END
A          LONG,OVER(_)

Res        BYTE,AUTO
L          UNSIGNED,AUTO
R          UNSIGNED,AUTO
Ptr        LONG,AUTO

Window WINDOW('Caption'),AT(,,160,230),FONT('MS Sans Serif',8,,FONT:regular),|
         SYSTEM,GRAY,MODAL,AUTO
       LIST,AT(12,14,136,148),USE(TNQ.TName,,?TNQ),VSCROLL,FORMAT('20L(1)~Tables names~@S255@'),FROM(TNQ)
       PROMPT('Table &Name:'),AT(11,170)
       ENTRY(@s255),AT(12,186,136,10),USE(TNQ.TName,,?TName),IMM,UPR
       BUTTON('&Select'),AT(50,206,45,14),USE(?Select),DEFAULT
       BUTTON('&Cancel'),AT(103,206,45,14),USE(?Cancel)
     END

  CODE
  !!! Extracting of the table name if it's present

  FileName     = T.FileName
  TableName[1] = '<0>'

  R = LEN (T.FileName)
  L = R

  LOOP WHILE L > 2
    CASE VAL (T.FileName [L])
    OF   VAL ('.')
    OROF VAL ('\')
    OROF VAL (':')
      BREAK

    OF   VAL ('!')
      IF  T.FileName [L - 1] = '\'
        IF  L <> R
          TableName = UPPER (T.FileName [L + 1 : R])
        END

        T.FileName [L - 1] = '<0>'
        BREAK
      END
    END

    L -= 1
  END

  !!! Getting a file name with FILEDIALOG

  Res = FILEDIALOG (Title, T.FileName, 'TopSpeed Files|*.tps|All|*.*', Flags)

  IF  Res
    T.FileName = LONGPATH (T.FileName)

    R = LEN (T.FileName)
    L = R

    LOOP WHILE L >= 2
      CASE VAL (T.FileName [L])
      OF   VAL ('\')
        T.FileName = T.FileName & '.TPS'
        R += 4

      OROF VAL ('.')
        BREAK
      END

      L -= 1
    END

    !!! Getting a list of tables

    _.Q &= TNQ

    SEND (T.File, 'PNMQ=' & A)

    IF  ERRORCODE() = 0
      LOOP UNTIL L = 0  OR  T.FileName [L] = '\'
        L -= 1
      END

      OPEN (Window)

      Window {PROP:Text} = T.FileName [L + 1 : R]

      IF  RECORDS (TNQ) = 0
        DISABLE (?TNQ)
        SELECT (?TName)
      ELSE
        IF  BAND (Flags, FILE:NoError) = 0
          DISABLE (?TName)
        END

        Ptr = 1

        IF  TableName
          TNQ.TName = TableName
          GET (TNQ, TNQ.TName)

          IF  ERRORCODE() = 0
            Ptr = POINTER (TNQ)
          END
        END

        SELECT (?TNQ, Ptr)

        ?TNQ {PROP:LineHeight} = ?TNQ {PROP:FontSize} + 2
      END

      IF  ?TNQ {PROP:Selected} = 0
        DISABLE (?Select)
      END

      ACCEPT
        CASE EVENT()
        OF   EVENT:Selected
          CASE  SELECTED()
          OF ?TNQ
            ?Select {PROP:Text} = '&Select'

            GET (TNQ, Ptr)
            SELECT (?TNQ, Ptr)

          OF ?TName
            ?Select {PROP:Text} = '&Accept'
          END

        OF EVENT:NewSelection
          CASE  FIELD()
          OF ?TNQ
            Ptr = CHOICE (?TNQ)
            GET (TNQ, Ptr)

          OF ?TName
            UPDATE (?TName)
            ?Select {PROP:Disable} = CHOOSE (TNQ.TName[1] = '<0>')
          END

        OF EVENT:Accepted
          CASE  ACCEPTED()
          OF   ?Cancel
            Res = FALSE
          OROF ?Select
            POST (EVENT:CloseWindow)
          END
        END
      END

      CLOSE (Window)
    ELSE
      Res = FALSE
    END
  END

  IF  Res
    IF  TNQ.TName <> 'UNNAMED'
      T.FileName = T.FileName & '\!' & TNQ.TName
    END
  ELSE
    T.FileName = FileName
  END

  RETURN Res


