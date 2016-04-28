!ABCIncludeFile(ABC)

OMIT('_EndOfInclude_',_ReportTargetPresent_)
_ReportTargetPresent_ EQUATE(1)

!********************************************
!TargetGenerator Class
TargetGenerator    CLASS,MODULE('ABPRTARG.CLW'),THREAD,TYPE,LINK('ABPRTARG.CLW',_ABCLinkMode_),DLL(_ABCDllMode_)
FPos                 LONG(0)
SFPos                LONG(0),PROTECTED
SAutoAdvance         BYTE(1),PROTECTED!IF true all the write operation move the SFPos pointer
Init                 PROCEDURE(<STRING TargetFileName>),VIRTUAL
SetFileName          PROCEDURE(STRING TargetFileName),VIRTUAL
GetFileName          PROCEDURE(),STRING,VIRTUAL
SetOriginalFileName  PROCEDURE(STRING TargetFileName),VIRTUAL
GetOriginalFileName  PROCEDURE(),STRING,VIRTUAL
GetOriginalFileName  PROCEDURE(SHORT pOrdinal,SHORT pTotal=0),STRING,VIRTUAL
GetPath              PROCEDURE(STRING FileName),STRING,VIRTUAL
GetExtension         PROCEDURE(STRING FileName),STRING,VIRTUAL
GetFileNameNoExt     PROCEDURE(STRING FileName),STRING,VIRTUAL
GetNameNoExt         PROCEDURE(STRING FileName),STRING,VIRTUAL
SetFileNameFromOriginal PROCEDURE(SHORT pOrdinal,SHORT pTotal=0),VIRTUAL
SetFileNameFromOriginal PROCEDURE(),VIRTUAL
OriginalTargetFileName CSTRING(144),PROTECTED
TargetFileName       CSTRING(144),PROTECTED
TargetFileHandle     LONG,PROTECTED
SourceFileName       CSTRING(144),PROTECTED
SourceFileHandle     LONG,PROTECTED
WriteStr             PROCEDURE(STRING str,BYTE pClipStr=0),BYTE,PROC
WriteByte            PROCEDURE(BYTE str),BYTE,PROC
WriteLong            PROCEDURE(LONG str),BYTE,PROC
WriteShort           PROCEDURE(SHORT str),BYTE,PROC
WriteULong           PROCEDURE(ULONG str),BYTE,PROC
WriteUShort          PROCEDURE(USHORT str),BYTE,PROC
WriteLine            PROCEDURE(STRING str,BYTE pClipStr=0),BYTE,PROC
WriteFileStream      PROCEDURE(STRING pFileName,LONG pStart=1,LONG pLen=0,BYTE pAllowedCharOnly=0),LONG,PROC !IF the file can be streamed it return the stream size
ReadULong            PROCEDURE(*ULONG pBuffer),LONG !If was successful return true
ReadLong             PROCEDURE(*LONG pBuffer),LONG !If was successful return true
ReadUShort           PROCEDURE(*USHORT pBuffer),LONG !If was successful return true
ReadShort            PROCEDURE(*SHORT pBuffer),LONG !If was successful return true
ReadByte             PROCEDURE(*BYTE pBuffer),LONG !If was successful return true
ReadStr              PROCEDURE(LONG pLength,*STRING pBuffer),LONG !If was successful return the readed bytes number
GetStr               PROCEDURE(LONG pLength),STRING
GetSourceFPos        PROCEDURE(),LONG
SetSourceFPos        PROCEDURE(LONG pFPos)
GetSourceSAutoAdvance PROCEDURE(),BYTE
SetSourceSAutoAdvance PROCEDURE(BYTE pParam)
OpenFile             PROCEDURE(BYTE pCreate=1),BYTE,PROC
CloseFile            PROCEDURE(),BYTE,PROC
OpenSourceFile       PROCEDURE(STRING SourceFileName),BYTE,PROC
CloseSourceFile      PROCEDURE(),BYTE,PROC
                  END

 _EndOfInclude_
