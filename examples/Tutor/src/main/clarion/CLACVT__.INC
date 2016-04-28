  OMIT ('_EndOfInclude_', _CLACVT_)

_CLACVT_             EQUATE(1)

! =============================================================================

                     ITEMIZE,PRE(STATE)
Init                   EQUATE
NextTask               EQUATE
Continue               EQUATE
NoIdle                 EQUATE
Completed              EQUATE
                     END

! =============================================================================

TASK:Initiate        EQUATE(00000001h)
TASK:Backup          EQUATE(00000002h)
TASK:CreateDest      EQUATE(00000004h)
TASK:OpenDest        EQUATE(00000008h)
TASK:OpenSrc         EQUATE(00000010h)
TASK:AlterDest       EQUATE(00000020h)
TASK:UpdateDest      EQUATE(00000040h)
TASK:CloseSrc        EQUATE(00000080h)
TASK:DropSrc         EQUATE(00000100h)
TASK:DropKeys        EQUATE(00000200h)
TASK:BuildKeys       EQUATE(00000400h)
TASK:CloseDest       EQUATE(00000800h)
TASK:Replace         EQUATE(00001000h)
TASK:Rename          EQUATE(00002000h)
TASK:Drop            EQUATE(00004000h)
TASK:Rollback        EQUATE(80000000h)

TASK:DefaultSimple   EQUATE(TASK:Initiate + TASK:Backup  + TASK:CreateDest + |
                            TASK:OpenDest + TASK:OpenSrc + TASK:UpdateDest + |
                            TASK:CloseSrc + TASK:CloseDest)
TASK:DefaultISAM     EQUATE(TASK:DefaultSimple + TASK:BuildKeys)
!DAW!TASK:DefaultSQL    EQUATE(TASK:Initiate  + TASK:Backup    + TASK:OpenDest + |
!DAW!                          TASK:AlterDest + TASK:BuildKeys + TASK:CloseDest)
TASK:DefaultSQL      EQUATE(TASK:Initiate  + TASK:OpenDest + |
                            TASK:OpenSrc  + TASK:UpdateDest + TASK:CloseSrc + |
                            TASK:BuildKeys + TASK:CloseDest)

 ! =============================================================================

                     ITEMIZE(0),PRE(RC)
Ok                     EQUATE
Filtered               EQUATE
OutOfRange             EQUATE
EOF                    EQUATE
Error                  EQUATE
                     END

! =============================================================================

RCCODE               EQUATE(SIGNED)

BaseTable            CLASS,TYPE,MODULE('CLACVT__.CLW'),LINK('CLACVT__')
File                   &FILE
Key                    &KEY
Record                 &GROUP
Driver                 &CvtDriver,PROTECTED
Label                  &CSTRING
FileName               &CSTRING
Owner                  &CSTRING

WasRead                LONG(0)
Opened                 BYTE(FALSE),PROTECTED

Init                   PROCEDURE (),       VIRTUAL
Open                   PROCEDURE (),RCCODE,VIRTUAL
Close                  PROCEDURE (),       VIRTUAL
Drop                   PROCEDURE (),       VIRTUAL
Backup                 PROCEDURE (),RCCODE,VIRTUAL

AskName                PROCEDURE (BOOL _MustExist, <STRING Label>),BYTE,PROC,VIRTUAL,PROTECTED

Inform                 PROCEDURE (STRING _Msg)
ErrorMessage           PROCEDURE (STRING _Msg)
Subst                  PROCEDURE (STRING),STRING,PROTECTED

GetTmpName             PROCEDURE (),STRING,VIRTUAL
                     END

! =============================================================================

SrcTable             CLASS(BaseTable),TYPE,MODULE('CLACVT__.CLW'),LINK('CLACVT__')
Streamed               BYTE(FALSE),PROTECTED
FileSize               LONG(0)

Init                   PROCEDURE (),       VIRTUAL
Open                   PROCEDURE (),RCCODE,VIRTUAL
Close                  PROCEDURE (),       VIRTUAL
SetOrder               PROCEDURE (),RCCODE,VIRTUAL
Read                   PROCEDURE (),RCCODE,VIRTUAL
SpeedUpOn              PROCEDURE (),       VIRTUAL
SpeedUpOff             PROCEDURE (),       VIRTUAL

Filter                 PROCEDURE (),BYTE,VIRTUAL
Percent                PROCEDURE (),BYTE
                     END

! =============================================================================

DestTable            CLASS(BaseTable),TYPE,MODULE('CLACVT__.CLW'),LINK('CLACVT__')
TargetName             &CSTRING
InTransaction          BYTE(FALSE),PROTECTED

Init                   PROCEDURE (),                    VIRTUAL
CreateTable            PROCEDURE (),RCCODE,             VIRTUAL
Write                  PROCEDURE (),RCCODE,             VIRTUAL
StartTransaction       PROCEDURE (),RCCODE,             VIRTUAL
StopTransaction        PROCEDURE (BYTE _Success = TRUE),VIRTUAL
Replace                PROCEDURE (),RCCODE,             VIRTUAL
Rename                 PROCEDURE (),RCCODE,             VIRTUAL
Backup                 PROCEDURE (),RCCODE,             VIRTUAL

DropKeys               PROCEDURE (),RCCODE,             VIRTUAL
BuildKeys              PROCEDURE (),RCCODE,             VIRTUAL
                     END

! =============================================================================

Convert             CLASS,TYPE,MODULE('CLACVT__.CLW'),LINK('CLACVT__')
Src                    &SrcTable
Dest                   &DestTable
Label                  &CSTRING
RecordsPerQuant        UNSIGNED(100)
State                  BYTE(STATE:Init)
Task                   LONG
CurrentTask            LONG(TASK:Initiate)

FieldsMap              &STRING,PROTECTED

Construct              PROCEDURE ()

Make                   PROCEDURE ()
Init                   PROCEDURE (),       VIRTUAL,PROTECTED
Link                   PROCEDURE (),       VIRTUAL

AlterTable             PROCEDURE (),RCCODE,VIRTUAL,PROTECTED
UpdateTable            PROCEDURE (),RCCODE,VIRTUAL,PROTECTED
Backup                 PROCEDURE (),RCCODE,VIRTUAL,PROTECTED
Rollback               PROCEDURE (),       VIRTUAL,PROTECTED

OpenSrc                PROCEDURE (),RCCODE,        PRIVATE
CloseSrc               PROCEDURE (),               PRIVATE
DropSrc                PROCEDURE (),               PRIVATE
ReadSrc                PROCEDURE (),RCCODE,        PRIVATE

Drop                   PROCEDURE (),       VIRTUAL,PROTECTED
CheckNames             PROCEDURE (),BOOL,  VIRTUAL,PROTECTED

Assign                 PROCEDURE (),       VIRTUAL,PROTECTED
AssignMapped           PROCEDURE (),               PROTECTED

Display                PROCEDURE (LONG _Value = -1),VIRTUAL,PROTECTED
                     END

! =============================================================================

CvtDriver            CLASS,TYPE,MODULE('CLACVTDRV.CLW'),LINK('CLACVTDRV')

AskName                PROCEDURE (BaseTable T, BYTE Flags, *CSTRING Title),BYTE,PROC,VIRTUAL

CreateTable            PROCEDURE (BaseTable T),RCCODE,VIRTUAL
Read                   PROCEDURE (BaseTable T),RCCODE,VIRTUAL
Write                  PROCEDURE (BaseTable T),RCCODE,VIRTUAL
SetOrder               PROCEDURE (BaseTable T),RCCODE,VIRTUAL
Backup                 PROCEDURE (BaseTable T),RCCODE,VIRTUAL

BuildKeys              PROCEDURE (BaseTable T),RCCODE,VIRTUAL
DropKeys               PROCEDURE (BaseTable T),RCCODE,VIRTUAL
BuildKey               PROCEDURE (KEY K),RCCODE,VIRTUAL
DropKey                PROCEDURE (KEY K),RCCODE,VIRTUAL

SpeedUpOn              PROCEDURE (BaseTable T),RCCODE,VIRTUAL
SpeedUpOff             PROCEDURE (BaseTable T),       VIRTUAL
StartTransaction       PROCEDURE (BaseTable T),RCCODE,VIRTUAL
StopTransaction        PROCEDURE (BOOL _Success = TRUE),VIRTUAL

FileSize               PROCEDURE (BaseTable T, *LONG Res),RCCODE,VIRTUAL

Register               PROCEDURE (*CSTRING DrvName),PROTECTED
                     END

! =============================================================================

! _EndOfInclude_

