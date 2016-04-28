
  MEMBER

BaseClassDllMode     EQUATE(0)

  INCLUDE('ICSTD.EQU')
  INCLUDE('ICTXTOUT.INC')

  MAP
  END

MAXTARGETLEN        EQUATE(8000)

TargetFilename      CSTRING(FILE:MaxFilepath)

TargetFile          FILE,DRIVER('DOS'),NAME(TargetFilename),PRE(TGT),THREAD,CREATE
RECORD                RECORD,PRE()
TextLine                CSTRING(MAXTARGETLEN+1)
                      END
                    END

!- The base text output class ------------------------------------------------

! Replace with direct OS calls later?

TextOutputClass.Close                  PROCEDURE
  CODE
  IF (CLIP(TGT:TextLine))
    SELF.Writeln('')
  END
  CLOSE(TargetFile)


TextOutputClass.CreateOpen             PROCEDURE(STRING Filename)
  CODE

  TargetFilename = Filename
  CREATE(TargetFile)
  ASSERT(~ERRORCODE())
  OPEN(TargetFile)
  ASSERT(~ERRORCODE())


TextOutputClass.Open             PROCEDURE(STRING Filename)
  CODE

  TargetFilename = Filename
  OPEN(TargetFile)
  ASSERT(~ERRORCODE())


TextOutputClass.GetSize            PROCEDURE(STRING Filename)
FileLen      ULONG
  CODE

  TargetFilename = Filename
  OPEN(TargetFile)
  IF (ERRORCODE())
    FileLen = 0
  ELSE
    FileLen = BYTES(TargetFile)
    ASSERT(~ERRORCODE())
    CLOSE(TargetFile)
    ASSERT(~ERRORCODE())
  END
  RETURN FileLen


TextOutputClass.Write                  PROCEDURE(STRING Text)
LenOld               UNSIGNED,AUTO
LenNew               UNSIGNED,AUTO
StartIndex           UNSIGNED,AUTO
  CODE
  LenOld = LEN(TGT:TextLine)
  LenNew = LEN(Text)
  IF (LenOld + LenNew < MAXTARGETLEN)
    TGT:TextLine = TGT:TextLine & Text
  ELSE
    IF (LenOld)
      APPEND(TargetFile, LenOld)
    END

    StartIndex = 1
    LOOP WHILE (StartIndex + MAXTARGETLEN <= LenNew)
      TGT:TextLine = SUB(Text, StartIndex, MAXTARGETLEN)
      APPEND(TargetFile, MAXTARGETLEN)
      StartIndex += MAXTARGETLEN
    END

    TGT:TextLine = SUB(Text, StartIndex, (LenNew+1) - StartIndex)
  END


TextOutputClass.Writeln                PROCEDURE(<STRING text>)
  CODE
  SELF.Write(text & '<10>')

  APPEND(TargetFile, LEN(TGT:TextLine))
  ASSERT(~ERRORCODE())
  TGT:TextLine = ''


