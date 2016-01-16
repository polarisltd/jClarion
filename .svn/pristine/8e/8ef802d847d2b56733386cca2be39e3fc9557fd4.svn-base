!ABCIncludeFile

  OMIT('_EndOfInclude_',_vsFileRepairPresent_)
_vsFileRepairPresent_ EQUATE(1)

!
! Build a queue of files and their file managers.
! Add the name of the file to the queue
! Perform a build, pack, release, on fix on any file.
!
!

  INCLUDE('KEYCODES.CLW'),ONCE
  INCLUDE('ABFILE.INC'),ONCE

tFileQ        QUEUE,TYPE
F                &FILE               ! File
FD               STRING(255)         ! File description
              END

FileRepairClass CLASS,MODULE('VSA_FRBP.CLW'),TYPE,LINK('VSA_FRBP.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
Q                     &tFileQ,PRIVATE
ProgressFEQ           LONG
ProgressHigh          LONG
ProgressNow           LONG

Init                  PROCEDURE(LONG ProgressFEQ=0)
AddFile               PROCEDURE(FILE F,STRING FD)
Pack                  PROCEDURE(STRING FD),LONG,PROC
Build                 PROCEDURE(STRING FD),LONG,PROC
Repair                PROCEDURE(STRING FD),LONG,PROC
Release               PROCEDURE(STRING FD),LONG,PROC
FindFile              PROCEDURE(STRING FD),LONG,PRIVATE
Exec                  PROCEDURE(STRING OpType,STRING FD),LONG,PRIVATE
Kill                  PROCEDURE()
                    END

  _EndOfInclude_
