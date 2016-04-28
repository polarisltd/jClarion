!ABCIncludeFile(WEB)

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

UsedFileQueue        QUEUE,TYPE
Filename               CSTRING(FILE:MaxFilePath)
                     END

WbFilesClass        CLASS,MODULE('WBFILES.CLW'),LINK('WBFILES', _WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
FinishInit             PROCEDURE(STRING ServerName),PRIVATE
GetAlias               PROCEDURE(<STRING Filename>),STRING
GetAliasPrefix         PROCEDURE,STRING
GetDirectory           PROCEDURE(SIGNED Security=Secure:Default),STRING
GetFilename            PROCEDURE(SIGNED ContentType, SIGNED Security=Secure:Default),STRING
GetProgramRef          PROCEDURE(SIGNED Security=Secure:Default),STRING
GetPublicDirectory     PROCEDURE(SIGNED Security=Secure:Default),STRING
GetRelativeFilename    PROCEDURE(STRING Filename),STRING
GetSeparateSecure      PROCEDURE,BYTE
GetSuffix              PROCEDURE,STRING
GetTempFilename        PROCEDURE(STRING Filename),STRING
GetTemporary           PROCEDURE(STRING Prefix),STRING,PRIVATE
Init                   PROCEDURE(BYTE UseLongFilenames, <STRING PublicSubDirectory>)   !,EXTENDS
InitialiseRPC          PROCEDURE(*CSTRING inet,*CSTRING sinet,*CSTRING pdir,*CSTRING sdir,*CSTRING salias,*CSTRING palias),PRIVATE,NAME('WebFiles$InitializeRPC')
Kill                   PROCEDURE
LoadImage              PROCEDURE(STRING Filename),STRING
LoadImage              PROCEDURE(SIGNED Feq, SIGNED PropId),STRING
RemoveAll              PROCEDURE,VIRTUAL
SelectTarget           PROCEDURE(SIGNED Security)
SetSuffix              PROCEDURE(STRING suffix)

AliasName              CSTRING(FILE:MaxFilePath),DIM(Secure:Last),PRIVATE
Basename               CSTRING(FILE:MaxFilename),PRIVATE
CurSuffix              CSTRING(255),PRIVATE
CurTargetDir           SIGNED,PRIVATE
Directory              CSTRING(FILE:MaxFilePath),DIM(Secure:Last),PRIVATE
Extension              CSTRING(FILE:MaxFilename),DIM(Content:Last),PRIVATE
FullProgramRef         CSTRING(FILE:MaxFilePath),DIM(Secure:Last),PRIVATE
InstanceDir            CSTRING(FILE:MaxFilePath),PRIVATE
ProgramRef             CSTRING(FILE:MaxFilePath),DIM(Secure:Last),PRIVATE
PublicSubDirectory     CSTRING(FILE:MaxFilePath),PRIVATE
ServerName             CSTRING(FILE:MaxFilePath)
UniqueId               ULONG,PRIVATE
                     END

  MAP
    MODULE('WBFILES')
WbFilesClass::Set     PROCEDURE(WbFilesClass Files),NAME('_13WbFilesClass__Set@FR13WbFilesClass')
WbFilesClass::Get     PROCEDURE(),*WbFilesClass,NAME('_13WbFilesClass__Get@F')
    END
  END

  _EndOfInclude_
