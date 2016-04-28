  MEMBER

  INCLUDE('WBSTD.EQU'),ONCE
  INCLUDE('WBSTD.INC'),ONCE

  MAP
GetHexValue   PROCEDURE(BYTE),BYTE
GetStartBase  PROCEDURE(STRING FullPath),SIGNED
Output64Chunk PROCEDURE(SIGNED, SIGNED, SIGNED, SIGNED),STRING
DecodeChar    PROCEDURE(STRING),SIGNED
    MODULE ('Windows')
GetSysColor   PROCEDURE(SIGNED),LONG,PASCAL,NAME('GetSysColor')
    END
  END


DayMap               GROUP
                       STRING('Sun')
                       STRING('Mon')
                       STRING('Tue')
                       STRING('Wed')
                       STRING('Thu')
                       STRING('Fri')
                       STRING('Sat')
                     END

MonthMap             GROUP
                       STRING('Jan')
                       STRING('Feb')
                       STRING('Mar')
                       STRING('Apr')
                       STRING('May')
                       STRING('Jun')
                       STRING('Jul')
                       STRING('Aug')
                       STRING('Sep')
                       STRING('Oct')
                       STRING('Nov')
                       STRING('Dec')
                     END

Days                 STRING(3),DIM(7),OVER(DayMap)
Months               STRING(3),DIM(12),OVER(MonthMap)

basis_64             STRING('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/')

GetHexValue  PROCEDURE(Next)

  CODE
  IF (Next >= VAL('0')) AND (Next <= VAL('9'))
     RETURN Next - VAL('0')
  ELSIF (Next >= VAL('A')) AND (Next <= VAL('F'))
     RETURN Next - VAL('A') + 10
  ELSIF (Next >= VAL('a')) AND (Next <= VAL('f'))
     RETURN Next - VAL('a') + 10
  END
  RETURN 0


IC:RGB                  PROCEDURE(LONG color)

SystemMask              EQUATE(080000000H)
SysColorMask            EQUATE(00000FFFFH)

  CODE
  IF (BAND(color, SystemMask))
    RETURN GetSysColor(BAND(color, SysColorMask))
  END
  RETURN color


IC:Hex                  PROCEDURE(ULONG value, SIGNED MinDigits)

MaxLength       EQUATE(20)
Digit           BYTE
Text            STRING(MaxLength)
Index           SIGNED(MaxLength)

  CODE
  LOOP WHILE (value)
    Digit = Value % 16
    Value = Value / 16
    IF (Digit < 10)
      Digit = VAL('0') + Digit
    ELSE
      Digit = VAL('A') + (Digit - 10)
    END
    Text[Index] = CHR(digit)
    Index -= 1
    MinDigits -= 1
  END
  IF (MinDigits > 0)
    LOOP MinDigits TIMES
      Text[Index] = '0'
      Index -= 1
    END
  END
  RETURN Text[Index+1 : MaxLength]


IC:ColorHex             PROCEDURE(ULONG color)

  CODE
  color = IC:RGB(color)
  color = BAND(color, 0FFH) * 010000H + BAND(color, 0FF00H) + BAND(color, 0FF0000H) / 010000H
  RETURN IC:Hex(color, 6)


IC:ColorText            PROCEDURE(ULONG color)

HexLen          SIGNED,AUTO
HexText         PSTRING(10),AUTO

  CODE
  color = IC:RGB(color)
  CASE color
  OF 0
    RETURN 'Black'
  OF 0FFFFFFH
    RETURN 'White'
  END
  HexText = IC:ColorHex(color)
  HexLen = LEN(HexText)

  RETURN '#' & SUB('00000' & HexText, HexLen, 6)


IC:Html2Clarion         PROCEDURE(STRING Response)

Length               SIGNED
FromIndex            SIGNED(1)
ToIndex              SIGNED(1)
Next                 BYTE

  CODE

  Length = LEN(Response)
  LOOP WHILE(FromIndex <= Length)
    CASE VAL(Response[FromIndex])
    OF VAL('+')
      Response[ToIndex] = ' '
    OF VAL('%')
      IF (FromIndex + 2 > Length)
        BREAK
      END
      Next = GetHexValue(VAL(Response[FromIndex+1])) * 16 + |
             GetHexValue(VAL(Response[FromIndex+2]))
      Response[ToIndex] = CHR(Next)
      FromIndex += 2
    ELSE
      Response[ToIndex] = Response[FromIndex]
    END
    FromIndex += 1
    ToIndex += 1
  END
  RETURN SUB(Response, 1, ToIndex-1)


IC:IsAbsoluteURL        PROCEDURE(STRING Pathname)
  CODE
  Pathname = UPPER(Pathname)
  IF (SUB(Pathname, 1, 5) = 'HTTP:') OR (SUB(Pathname, 1, 6) = 'HTTPS:')
    RETURN TRUE
  END
  IF (SUB(Pathname, 1, 1) = '/') OR (INSTRING('.EXE.', Pathname, 1, 1))
    RETURN TRUE
  END
  RETURN FALSE


IC:GetCommandLineOption    PROCEDURE(OptionName)

StartIndex          SIGNED
EndIndex            SIGNED
CommandLine         CSTRING(255)

  CODE

  CommandLine = IC:GetCommandLine()
  StartIndex = INSTRING(OptionName, CommandLine, 1, 1)
  IF (StartIndex)
    EndIndex = INSTRING(' ', CommandLine, 1, StartIndex)
    IF (EndIndex = 0)
      EndIndex = LEN(CommandLine) + 1
    END

    StartIndex += LEN(OptionName)
    RETURN SUB(CommandLine, StartIndex, EndIndex - StartIndex)
  END
  RETURN ''


GetStartBase     PROCEDURE(STRING FullPath)

StartName       SIGNED,AUTO
NextSlash       SIGNED,AUTO

  CODe
  StartName = 1
  LOOP
    NextSlash = INSTRING('\', FullPath, 1, StartName)
    IF (NextSlash = 0)
      NextSlash = INSTRING('/', FullPath, 1, StartName)
      IF (NextSlash = 0)
        RETURN StartName
      END
    END
    StartName = NextSlash + 1
  END

IC:GetBaseName     PROCEDURE(STRING FullPath)

StartName       SIGNED,AUTO

  CODe
  StartName = GetStartBase(FullPath)
  RETURN CLIP(SUB(FullPath, StartName, LEN(FullPath)))


IC:GetPathname     PROCEDURE(STRING FullPath)

StartName       SIGNED,AUTO

  CODe
  StartName = GetStartBase(FullPath)
  RETURN SUB(FullPath, 1, StartName-1)



IC:GetPositionPixels PROCEDURE(SIGNED Feq, *SIGNED x, *SIGNED y, *SIGNED width, *SIGNED height)
Units  SIGNED,AUTO

  CODE

  Units = 0
  IF (0{PROP:mm} = 1)
    Units = PROP:mm
  ELSIF (0{PROP:points} = 1)
    Units = PROP:points
  ELSIF (0{PROP:thous} = 1)
    Units = PROP:thous
  END

  0{PROP:points} = 1

  GetPosition(Feq,x,y,width,height)

  0{PROP:points} = 0
  CASE Units
  OF PROP:mm
    0{PROP:mm} = 1
  OF PROP:points
    0{PROP:points} = 1
  OF PROP:thous
    0{PROP:thous} = 1
  END


IC:RemoveFile      PROCEDURE(Filename)

TempName        CSTRING(FILE:MaxFilename)

  CODE
  TempName = Filename
  RETURN IC:DoRemoveFile(TempName)


IC:TranslateFilename    PROCEDURE(STRING Filename)

CurIndex             SIGNED,AUTO
MaxIndex             SIGNED,AUTO

  CODE
  MaxIndex = LEN(Filename)
  LOOP CurIndex = 1 TO MaxIndex
    IF (Filename[CurIndex] = '\')
      Filename[CurIndex] = '/'
    END
  END
  RETURN Filename


IC:DuplicateChar              PROCEDURE(*CSTRING Target, STRING Source, STRING Char)
SourceIndex           SIGNED,AUTO
SourceLen             SIGNED,AUTO
TargetIndex           SIGNED,AUTO

  CODE

  SourceLen = LEN(source)
  TargetIndex = 1

  LOOP SourceIndex = 1 TO SourceLen
    IF (Source[SourceIndex] = Char)
      Target[TargetIndex] = Char
      TargetIndex += 1
    END

    Target[TargetIndex] = Source[SourceIndex]
    TargetIndex += 1
  END
  Target[TargetIndex] = '<0>'


IC:GetStrDateTime PROCEDURE(LONG Date, LONG Time)
Day                  STRING(10),AUTO
Month                STRING(10),AUTO
TheDate              STRING(80),AUTO
TheTime              STRING(20),AUTO

  CODE

  Day = Days[(Date % 7) + 1]
  Month = Months[MONTH(date)]

  TheDate = CLIP(Day) & ', ' & FORMAT(DAY(Date), '@N02') & ' ' & CLIP(Month) & ' ' & YEAR(Date)
  TheTime = FORMAT(Time,@T04) & ' GMT'
  RETURN CLIP(TheDate) & ' ' & CLIP(TheTime)


Output64Chunk        PROCEDURE(SIGNED c1, SIGNED c2, SIGNED c3, SIGNED pads)
Result               CSTRING(5),AUTO
p1                   SIGNED,AUTO
p2                   SIGNED,AUTO
p3                   SIGNED,AUTO
ResIndex             SIGNED(1)

  CODE

  p1 = BSHIFT(c1,-2)
  Result[ResIndex] = basis_64[(p1+1)]
  ResIndex = ResIndex + 1

  p1 = BSHIFT(BAND(c1,3h), 4)
  p2 = BSHIFT(BAND(c2,0f0h), -4)
  p3 = BOR(p1, p2)
  Result[ResIndex] = basis_64[(p3+1)]
  ResIndex = ResIndex + 1
  IF (pads = 2)
    Result[(ResIndex):(ResIndex+1)] = '=='
    ResIndex = ResIndex + 2
  ELSE
    p1 = BSHIFT(BAND(c2, 0fh), 2)
    p2 = BSHIFT(BAND(c3, 0c0h), -6)
    p3 = BOR(p1, p2)

    Result[ResIndex] = basis_64[(p3+1)]
    ResIndex = ResIndex + 1
    IF (pads)
      Result[ResIndex] = '='
    ELSE
      p1 = BAND(c3, 3fh)
      Result[ResIndex] = basis_64[(p1+1)]
    END
    ResIndex = ResIndex + 1
  END

  Result[ResIndex] = '<0>'

  RETURN Result


IC:EncodeBase64        PROCEDURE(STRING input)
c1                   SIGNED,AUTO
c2                   SIGNED,AUTO
c3                   SIGNED,AUTO
ct                   SIGNED,AUTO
Chunk                CSTRING(10),AUTO
Result               CSTRING(1281)
InputIndex           SIGNED,AUTO
InputLen             SIGNED,AUTO
  CODE

  ct = 1

  InputLen = LEN(input)
  InputIndex = 1

  LOOP
    IF (InputIndex > InputLen)
      c1 = -1
      BREAK
    ELSE
      c1 = VAL(input[(InputIndex):(InputIndex)])
      InputIndex = InputIndex + 1
    END
    IF (InputIndex > InputLen)
      c2 = -1
    ELSE
      c2 = VAL(input[(InputIndex):(InputIndex)])
      InputIndex = InputIndex + 1
    END
    IF (c2 = -1)
      Chunk = Output64Chunk(c1, 0, 0, 2)
    ELSE
      IF (InputIndex > InputLen)
        c3 = -1
      ELSE
        c3 = VAL(input[(InputIndex):(InputIndex)])
        InputIndex = InputIndex + 1
      END
      IF (c3 = -1)
        Chunk = Output64Chunk(c1, c2, 0, 1)
      ELSE
        Chunk = Output64Chunk(c1, c2, c3, 0)
      END
    END
    ct = ct + 4
    IF (ct > 72)
        ct = 1
    END

    Result = Result & Chunk
  END

  RETURN Result


DecodeChar      PROCEDURE(STRING cs)
c                    SIGNED,AUTO

  CODE

  c = VAL(cs)

  IF ((c>=VAL('A')) AND (c<=VAL('Z')))
    RETURN (c-VAL('A'))
  END
  IF ((c>=VAL('a')) AND (c<=VAL('z')))
    RETURN (26+c-VAL('a'))
  END
  IF ((c>=VAL('0')) AND (c<=VAL('9')))
    RETURN (52+c-VAL('0'))
  END

  IF (c = VAL('+'))
    RETURN 62
  ELSIF (c = VAL('-'))
    RETURN 62
  END

  RETURN 0


IC:DecodeBase64        PROCEDURE(STRING input)
Result               CSTRING(1025),AUTO
i                    SIGNED,AUTO
j                    SIGNED,AUTO
InLen                SIGNED,AUTO

  CODE

  i = 1
  j = 1
  InLen = LEN(input)
  LOOP WHILE (i <= InLen)
    Result[j]  = CHR((DecodeChar(input[i])*4)+(DecodeChar(input[i+1]) / 10h))
    Result[(j+1)]= CHR((DecodeChar(input[i+1])*10h)+(DecodeChar(input[i+2]) / 4))
    Result[(j+2)]= CHR((DecodeChar(input[i+2])*40h)+DecodeChar(input[i+3]))
    j = j + 3
    i = i + 4
  END

  Result[j]='<0>'

  RETURN Result


IC:GetAlphaNumeric      PROCEDURE(STRING text)
len                  SIGNED,AUTO
src                  SIGNED,AUTO
tgt                  SIGNED,AUTO
  CODE
  len = LEN(text)
  src = 1
  tgt = 1
  LOOP WHILE (src <= len)
     CASE text[src]
     OF 'A' TO 'Z'
     OROF 'a' TO 'z'
     OROF '0' TO '9'
     OROF '_'
       text[tgt] = text[src]
       tgt += 1
     END
     src += 1
  END
  IF (tgt <> 1)
    RETURN text[(1):(tgt-1)]
  END
  RETURN ''

