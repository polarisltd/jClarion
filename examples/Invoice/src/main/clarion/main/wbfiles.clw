  MEMBER

  INCLUDE('WBFILES.INC'),ONCE
  INCLUDE('WBSTD.EQU'),ONCE
  INCLUDE('WBSTD.INC'),ONCE

  MAP
GetPageReference  PROCEDURE(STRING Pathname),STRING
EnsureSeparated   PROCEDURE(STRING),STRING
RemoveDirectory   PROCEDURE(STRING Filename)
StripSeparator    PROCEDURE(STRING),STRING
  END

GlobalFiles             &WbFilesClass

EnsureSeparated         PROCEDURE(STRING Directory)

LastChar             STRING(1)

  CODE
  LastChar = SUB(Directory, -1, 1)
  IF Directory AND (LastChar <> '\') AND (LastChar <> '/')
    RETURN Directory & '\'
  END
  RETURN Directory


StripSeparator         PROCEDURE(STRING Directory)

LastChar             STRING(1),AUTO
Len                  SIGNED,AUTO

  CODE
  Len = LEN(Directory)
  IF (Len)
    LastChar = Directory[Len]
    IF (LastChar = '\') OR (LastChar = '/')
      RETURN SUB(Directory, 1, Len-1)
    END
  END
  RETURN Directory


GetPageReference        PROCEDURE(STRING Pathname)
Start                SIGNED,AUTO
  CODE
  IF (UPPER(SUB(Pathname, 1, 4)) = 'HTTP')
    ! string has form http..//.../....   we want everything from the third '/'
    Start = INSTRING('/', Pathname, 1, 1)
    Start = INSTRING('/', Pathname, 1, Start+2)
    IF (Start)
      RETURN IC:TranslateFilename(Pathname[Start : LEN(Pathname)])
    END
  END
  IF (SUB(Pathname, 1, 1) = '/')
    RETURN IC:TranslateFilename(Pathname)
  ELSE
    RETURN '/' & IC:TranslateFilename(Pathname)
  END


RemoveDirectory         PROCEDURE(STRING DirName)

ContentsQueue        QUEUE(FILE:Queue),PRE(XXX).
CurIndex             SIGNED,AUTO

  CODE

  DIRECTORY(ContentsQueue,DirName & '\*.*',ff_:NORMAL)
  LOOP CurIndex = 1 TO RECORDS(ContentsQueue)
    GET(ContentsQueue, CurIndex)
    IC:RemoveFile(DirName & '\' & ContentsQueue.Name)
  END
  IC:RemoveDirectory(DirName)


WbFilesClass.GetDirectory           PROCEDURE(SIGNED Security)
  CODE
  IF (Security = Secure:Default)
    Security = SELF.CurTargetDir
  END
  RETURN SELF.Directory[Security] & SELF.PublicSubDirectory & SELF.InstanceDir


WbFilesClass.GetPublicDirectory           PROCEDURE(SIGNED Security)
  CODE
  IF (Security = Secure:Default)
    Security = SELF.CurTargetDir
  END
  RETURN SELF.Directory[Security] & SELF.PublicSubDirectory


WbFilesClass.GetFilename            PROCEDURE(SIGNED ContentType, SIGNED Security)
  CODE
  RETURN SELF.GetDirectory(Security) & '\' & SELF.Basename & SELF.CurSuffix & SELF.Extension[ContentType]


WbFilesClass.GetAlias       PROCEDURE(<STRING Filename>)
CurDir               CSTRING(FILE:MaxFilename),AUTO
Security             SIGNED,AUTO
LenCurDir            SIGNED,AUTO
BaseName             CSTRING(FILE:MaxFilename),AUTO
SearchName           CSTRING(FILE:MaxFilePath),AUTO
  CODE
  IF (NOT Filename)
    RETURN ''
  END
  IF (SUB(Filename,1,1)='~')
    RETURN SELF.GetAlias(SUB(Filename, 2, -1))
  END
  LOOP Security = Secure:None TO Secure:Full
    CurDir = SELF.Directory[Security]
    LenCurDir = LEN(CurDir)
    IF (SUB(Filename,1,LenCurDir) = CurDir)
      RETURN IC:TranslateFilename(SELF.AliasName[Security] & CLIP(SUB(Filename, LenCurDir+1, FILE:MaxFilename)))
    END
  END
  BaseName = IC:GetBaseName(Filename)
  IF (SELF.PublicSubDirectory)
    SearchName = SELF.Directory[SELF.CurTargetDir] & SELF.PublicSubDirectory & BaseName
    IF (IC:GetFileExists(SearchName))
      RETURN IC:TranslateFilename(SELF.AliasName[SELF.CurTargetDir] & SELF.PublicSubDirectory & BaseName)
    END
  END
  RETURN IC:TranslateFilename(SELF.AliasName[SELF.CurTargetDir] & BaseName)


WbFilesClass.GetAliasPrefix       PROCEDURE
LenAlias                SIGNED,AUTO
CurAlias                &CSTRING,AUTO
  CODE
  CurAlias &= SELF.AliasName[SELF.CurTargetDir]
  LenAlias = LEN(CurAlias)
  ASSERT(CurAlias[LenAlias]='/')
  RETURN IC:TranslateFilename(CurAlias[1 : LenAlias-1])

WbFilesClass.GetProgramRef        PROCEDURE(SIGNED Security)
  CODE
  IF (Security = Secure:Default)
    RETURN SELF.ProgramRef[SELF.CurTargetDir]
  END
  RETURN SELF.FullProgramRef[Security]


WbFilesClass.GetRelativeFilename  PROCEDURE(STRING Filename)
CurDir               CSTRING(FILE:MaxFilename),AUTO
Security             SIGNED,AUTO
LenCurDir            SIGNED,AUTO
  CODE
  LOOP Security = Secure:None TO Secure:Full
    CurDir = SELF.Directory[Security]
    LenCurDir = LEN(CurDir)
    IF (SUB(Filename,1,LenCurDir) = CurDir)
      RETURN CLIP(SUB(Filename, LenCurDir+1, FILE:MaxFilename))
    END
  END
  RETURN Filename


WbFilesClass.GetSeparateSecure      PROCEDURE
  CODE
  IF (SELF.Directory[Secure:None] = SELF.Directory[Secure:Full])
    RETURN FALSE
  END
  RETURN TRUE


WbFilesClass.GetSuffix     PROCEDURE
  CODE
    RETURN SELF.CurSuffix


WbFilesClass.GetTempFilename        PROCEDURE(STRING Filename)
  CODE
  RETURN IC:GetPathname(Filename) & SELF.Basename & SELF.CurSuffix & '.tmp'


WbFilesClass.GetTemporary           PROCEDURE(STRING Prefix)
  CODE
  RETURN IC:GetBaseName(IC:GetTempFilename(SELF.GetDirectory(Secure:None),Prefix))


WbFilesClass.Init                   PROCEDURE(BYTE UseLongFilenames, <STRING PublicSubDirectory>)

ServerName       CSTRING(FILE:MaxFilePath)

  CODE
  ServerName = IC:GetCommandLineOption('/inet=')

  SELF.PublicSubDirectory = EnsureSeparated(PublicSubDirectory)
  SELF.CurSuffix = ''

  IF (ServerName)
    SELF.Directory[Secure:Default] = ''
    SELF.Directory[Secure:None] = EnsureSeparated(IC:GetCommandLineOption('/pdir='))
    SELF.Directory[Secure:Full] = EnsureSeparated(IC:GetCommandLineOption('/sdir='))

    SELF.AliasName[Secure:Default] = ''
    SELF.AliasName[Secure:None] = IC:TranslateFilename(IC:GetCommandLineOption('/palias='))
    SELF.AliasName[Secure:Full] = IC:TranslateFilename(IC:GetCommandLineOption('/salias='))

    SELF.FullProgramRef[Secure:None] = IC:TranslateFilename(IC:GetCommandLineOption('/inet='))
    SELF.FullProgramRef[Secure:Full] = IC:TranslateFilename(IC:GetCommandLineOption('/sinet='))
    SELF.FinishInit(ServerName)
  END

WbFilesClass.FinishInit             PROCEDURE(STRING ServerName)

BaseServerName       CSTRING(FILE:MaxFilePath)
StartIndex           SIGNED
EndIndex             SIGNED
NumDigits            SIGNED

  CODE
  SELF.ProgramRef[Secure:None] = GetPageReference(SELF.FullProgramRef[Secure:None])
  SELF.ProgramRef[Secure:Full] = GetPageReference(SELF.FullProgramRef[Secure:Full])

  IF (SELF.Directory[Secure:Full] = '')
    SELF.Directory[Secure:Full] = SELF.Directory[Secure:None]
  END
  IF (SELF.AliasName[Secure:None] = '')
    SELF.AliasName[Secure:None] = '/'
  END
  IF (SELF.AliasName[Secure:Full] = '')
    SELF.AliasName[Secure:full] = SELF.AliasName[Secure:None]
  END

  IF (ServerName)
    ! Find Components of progname.exe.sid
    BaseServerName = IC:GetBaseName(ServerName)

    StartIndex = INSTRING('.', BaseServerName, 1, 1)
    EndIndex = INSTRING('.', BaseServerName, 1, StartIndex + 1)
    NumDigits = LEN(BaseServerName) - EndIndex
    SELF.UniqueId = SUB(BaseServerName, EndIndex+1, 255)
    SELF.InstanceDir = IC:Hex(SELF.UniqueId)

    IC:CreateDirectory(SELF.Directory[Secure:None] & SELF.PublicSubDirectory)
    IC:CreateDirectory(SELF.GetDirectory(Secure:None))
    IF (SELF.GetSeparateSecure())
      IC:CreateDirectory(SELF.Directory[Secure:Full] & SELF.PublicSubDirectory)
      IC:CreateDirectory(SELF.GetDirectory(Secure:Full))
    END

    SELF.Basename = SUB(BaseServerName, 1, StartIndex-1)

    SELF.Extension[Content:Html] = '.htm'
    SELF.Extension[Content:Jsl] = '.jsl'
    SELF.Extension[Content:UnAuthorized] = '.aut'
  END

WbFilesClass.InitialiseRPC         PROCEDURE(*CSTRING inet, *CSTRING sinet, *CSTRING pdir, *CSTRING sdir, *CSTRING salias, *CSTRING palias)
  CODE
  SELF.Directory[Secure:Default] = ''
  SELF.Directory[Secure:None] = EnsureSeparated(pdir)
  SELF.Directory[Secure:Full] = EnsureSeparated(sdir)

  SELF.AliasName[Secure:Default] = ''
  SELF.AliasName[Secure:None] = IC:TranslateFilename(palias)
  SELF.AliasName[Secure:Full] = IC:TranslateFilename(salias)

  SELF.FullProgramRef[Secure:None] = IC:TranslateFilename(inet)
  SELF.FullProgramRef[Secure:Full] = IC:TranslateFilename(sinet)
  SELF.FinishInit(inet)

WbFilesClass.Kill                   PROCEDURE
  CODE


WbFilesClass.LoadImage PROCEDURE(SIGNED Feq, SIGNED PropId)

  CODE
  return SELF.LoadImage(Feq{PropId})


WbFilesClass.LoadImage PROCEDURE(STRING Filename)

  CODE

  IF (Filename AND Filename[1] = '~')
    Filename = SUB(Filename, 2, -1)
  END
  IF (Filename)
    RETURN IC:GetBasename(CLIP(Filename))
  END
  RETURN ''


WbFilesClass.RemoveAll              PROCEDURE
  CODE
  IF (SELF.UniqueId)                             ! Run from internet?
    RemoveDirectory(SELF.GetDirectory(Secure:None))
    IF (SELF.GetSeparateSecure())
      RemoveDirectory(SELF.GetDirectory(Secure:Full))
    END
  END


WbFilesClass.SelectTarget           PROCEDURE(SIGNED Security)
PathLength           EQUATE(FILE:MaxFilePath * 4)
ImagePath            CSTRING(PathLength)
  CODE
  SELF.CurTargetDir = Security

  ImagePath = SELF.Directory[Security] & SELF.PublicSubDirectory & SELF.InstanceDir & '\'
  SYSTEM{PROP:temppagepath} = ImagePath
  IF (SELF.PublicSubDirectory)
    ImagePath = ImagePath & ';' & SELF.Directory[Security] & SELF.PublicSubDirectory
  END
  ImagePath = ImagePath & ';' & SELF.Directory[Security]

  SYSTEM{PROP:tempimagepath} = ImagePath


WbFilesClass.SetSuffix    PROCEDURE(STRING suffix)
  CODE
    SELF.CurSuffix = suffix


WbFilesClass::Set     PROCEDURE(WbFilesClass Files)
  CODE
    ASSERT(GlobalFiles &= NULL)
    GlobalFiles &= Files

WbFilesClass::Get     PROCEDURE()
  CODE
    RETURN GlobalFiles

