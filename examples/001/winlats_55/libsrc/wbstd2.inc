! Contains declarions that should not be exported

  OMIT('_EndOfInclude_',_WbStd2Present_)
_WbStd2Present_ EQUATE(1)

            MAP
              MODULE('WBSTD2')
IC:Feq2Id                   PROCEDURE(SIGNED Feq,SIGNED PageNo=0),UNSIGNED
IC:GetControlType           PROCEDURE(SIGNED Feq),SIGNED
IC:Id2Feq                   PROCEDURE(UNSIGNED id),SIGNED
              END
              MODULE('WBEXT')
IC:CopyFile                 PROCEDURE(*CSTRING Source, *CSTRING Target),SIGNED,RAW,PROC,NAME('CopyFile')
IC:DoRemoveFile             PROCEDURE(*CSTRING filename),SIGNED,RAW,PROC,NAME('_remove')
IC:RenameFile               PROCEDURE(*CSTRING Source, *CSTRING Target),SIGNED,RAW,PROC,NAME('_rename')
              END
            END

_EndOfInclude_
