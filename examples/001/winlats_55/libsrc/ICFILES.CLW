  MEMBER()

BaseClassDllMode     EQUATE(0)

  INCLUDE('ICFILES.INC')
  INCLUDE('ICSTD.EQU')

  MAP
    INCLUDE('IcStd.inc')
    GetPageReference(STRING Pathname),STRING
    EnsureSeparated(STRING),STRING
    RemoveDirectory(STRING Filename)
    StripSeparator(STRING),STRING
  END

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


WebFilesClass.GetDirectory           PROCEDURE(SIGNED Security)
  CODE
  IF (Security = Secure:Default)
    Security = SELF.CurTargetDir
  END
  RETURN SELF.Directory[Security] & SELF.PublicSubDirectory & SELF.InstanceDir


WebFilesClass.GetPublicDirectory           PROCEDURE(SIGNED Security)
  CODE
  IF (Security = Secure:Default)
    Security = SELF.CurTargetDir
  END
  RETURN SELF.Directory[Security] & SELF.PublicSubDirectory
WebFilesClass.GetFilename            PROCEDURE(SIGNED ContentType, SIGNED Security)
  CODE
  RETURN SELF.GetDirectory(Security) & '\' & SELF.Basename[ContentType]


WebFilesClass.GetAlias       PROCEDURE(<STRING Filename>)
CurDir               CSTRING(FILE:MaxFilename),AUTO
Security             SIGNED,AUTO
LenCurDir            SIGNED,AUTO
BaseName             CSTRING(FILE:MaxFilename),AUTO
SearchName           CSTRING(FILE:MaxFilePath),AUTO
  CODE
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


WebFilesClass.GetProgramRef        PROCEDURE(SIGNED Security)
  CODE
  IF (Security = Secure:Default)
    RETURN SELF.ProgramRef[SELF.CurTargetDir]
  END
  RETURN SELF.FullProgramRef[Security]


WebFilesClass.GetRelativeFilename  PROCEDURE(STRING Filename)
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


WebFilesClass.GetSeparateSecure      PROCEDURE
  CODE
  IF (SELF.Directory[Secure:None] = SELF.Directory[Secure:Full])
    RETURN FALSE
  END
  RETURN TRUE


WebFilesClass.GetTempFilename        PROCEDURE(STRING Filename)
  CODE
  RETURN IC:GetPathname(Filename) & SELF.TempBasename


WebFilesClass.GetTemporary           PROCEDURE(STRING Prefix)
  CODE
  RETURN IC:GetBaseName(IC:GetTempFilename(SELF.GetDirectory(Secure:None),Prefix))


WebFilesClass.Init                   PROCEDURE(BYTE UseLongFilenames, <STRING PublicSubDirectory>)

ServerName       CSTRING(FILE:MaxFilePath)

  CODE
  ServerName = IC:GetCommandLineOption('/inet=')

  SELF.PublicSubDirectory = EnsureSeparated(PublicSubDirectory)

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

WebFilesClass.FinishInit             PROCEDURE(STRING ServerName)

BaseServerName       CSTRING(FILE:MaxFilePath)
Basename             CSTRING(FILE:MaxFilePath)
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
    ASSERT(IC:CreateDirectory(SELF.GetDirectory(Secure:None)))
    IF (SELF.GetSeparateSecure())
      IC:CreateDirectory(SELF.Directory[Secure:Full] & SELF.PublicSubDirectory)
      IC:CreateDirectory(SELF.GetDirectory(Secure:Full))
    END

    Basename = SUB(BaseServerName, 1, StartIndex-1)

    SELF.Basename[Content:Html] = Basename & '.htm'
    SELF.Basename[Content:Jsl] = Basename & '.jsl'
    SELF.Basename[Content:UnAuthorized] = Basename & '.aut'
    SELF.TempBasename = Basename & '.tmp'
  END

WebFilesClass.InitialiseRPC         PROCEDURE(inet, sinet, pdir, sdir, salias, palias)
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

WebFilesClass.Kill                   PROCEDURE
  CODE


WebFilesClass.LoadImage PROCEDURE(SIGNED Feq, SIGNED PropId)

  CODE
  return SELF.LoadImage(Feq{PropId})


WebFilesClass.LoadImage PROCEDURE(STRING Filename)

ExtPos          SIGNED,AUTO
  CODE

  IF (Filename AND Filename[1] = '~')
    Filename = SUB(Filename, 2, -1)
  END
  IF (Filename)
    RETURN IC:GetBasename(CLIP(Filename))
  END
  RETURN ''


WebFilesClass.RemoveAll              PROCEDURE
CurIndex             SIGNED,AUTO
  CODE
  IF (SELF.UniqueId)                             ! Run from internet?
    RemoveDirectory(SELF.GetDirectory(Secure:None))
    IF (SELF.GetSeparateSecure())
      RemoveDirectory(SELF.GetDirectory(Secure:Full))
    END
  END


WebFilesClass.SelectTarget           PROCEDURE(SIGNED Security)
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


