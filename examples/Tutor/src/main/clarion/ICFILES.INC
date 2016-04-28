OMIT('_EndOfInclude_',_ICFilesPresent_)
_ICFilesPresent_ EQUATE(1)

                     ITEMIZE,PRE(Secure)
Default                EQUATE
None                   EQUATE
Full                   EQUATE
Last                   EQUATE(Secure:Full)
                     END

                     ITEMIZE(1),PRE(Content)
Html                   EQUATE
Jsl                    EQUATE
Unauthorized           EQUATE
Last                   EQUATE(Content:Unauthorized)
                     END

UsedFileQueue        QUEUE
Filename               CSTRING(FILE:MaxFilePath)
                     END

WebFilesClass        CLASS,MODULE('ICFILES.CLW'),LINK('ICFILES',LinkBaseClasses),TYPE,DLL(BaseClassDllMode)
FinishInit             PROCEDURE(STRING),PRIVATE
GetAlias               PROCEDURE(<STRING Filename>),STRING
GetDirectory           PROCEDURE(SIGNED Security=Secure:Default),STRING
GetFilename            PROCEDURE(SIGNED ContentType, SIGNED Security=Secure:Default),STRING
GetProgramRef          PROCEDURE(SIGNED Security=Secure:Default),STRING
GetPublicDirectory     PROCEDURE(SIGNED Security=Secure:Default),STRING
GetRelativeFilename    PROCEDURE(STRING Filename),STRING
GetSeparateSecure      PROCEDURE,BYTE
GetTempFilename        PROCEDURE(STRING Filename),STRING
GetTemporary           PROCEDURE(STRING Prefix),STRING,PRIVATE
Init                   PROCEDURE(BYTE UseLongFilenames, <STRING PublicSubDirectory>)
InitialiseRPC          PROCEDURE(*CSTRING,*CSTRING,*CSTRING,*CSTRING,*CSTRING,*CSTRING),PRIVATE,NAME('WebFiles$InitializeRPC')
Kill                   PROCEDURE
LoadImage              PROCEDURE(STRING),STRING
LoadImage              PROCEDURE(SIGNED Feq, SIGNED PropId),STRING
RemoveAll              PROCEDURE
SelectTarget           PROCEDURE(SIGNED Security)

AliasName              CSTRING(FILE:MaxFilePath),DIM(Secure:Last),PRIVATE
Basename               CSTRING(FILE:MaxFilename),DIM(Content:Last),PRIVATE
CurTargetDir           SIGNED,PRIVATE
Directory              CSTRING(FILE:MaxFilePath),DIM(Secure:Last),PRIVATE
FullProgramRef         CSTRING(FILE:MaxFilePath),DIM(Secure:Last),PRIVATE
InstanceDir            CSTRING(FILE:MaxFilePath),PRIVATE
ProgramRef             CSTRING(FILE:MaxFilePath),DIM(Secure:Last),PRIVATE
PublicSubDirectory     CSTRING(FILE:MaxFilePath),PRIVATE
ServerName             CSTRING(FILE:MaxFilePath)
TempBasename           CSTRING(FILE:MaxFilename),PRIVATE
UniqueId               ULONG,PRIVATE
                     END

_EndOfInclude_
