  MEMBER
  INCLUDE('ABPRNAME.INC'),ONCE
  MAP
    MODULE('Core')
      PathSplit(CONST *CSTRING path, <*CSTRING drive>, <*CSTRING dir>, <*CSTRING file>, <*CSTRING ext>), SIGNED, PROC, RAW, NAME('_fnsplit')
      PathMerge(CONST *CSTRING path, <*CSTRING drive>, <*CSTRING dir>, <*CSTRING file>, <*CSTRING ext>), SIGNED, PROC, RAW, NAME('_fnmerge')
    END
  END
NameGenerator.Construct       PROCEDURE()
  CODE
    SELF.SetNameMask('_<%p0>')!_OF_<%t>')

NameGenerator.Init            PROCEDURE(STRING defaultName, STRING defaultExtension)
  CODE
    SELF.DefaultName = defaultName
    SELF.ReportName = defaultName
    SELF.DefaultExtension = defaultExtension
    SELF.Extension = defaultExtension

NameGenerator.SetTotalPages   PROCEDURE(SHORT TotalPages)
  CODE
    SELF.TotalPages = TotalPages

NameGenerator.SetNameMask     PROCEDURE(STRING Mask)
l     LONG,AUTO
r     LONG,AUTO
lSize LONG(4)
rSize LONG(4)
  CODE
    SELF.GenerationMask = CLIP(Mask)
    SELF.PPad = FALSE
    SELF.TPos = INSTRING('<%t>', Mask, 1, 1)
    SELF.PPos = INSTRING('<%p', Mask, 1, 1)
    IF ~SELF.TPos AND ~SELF.PPos
      SELF.MaskBits[1] = 1
      SELF.MaskBits[2] = LEN(SELF.GenerationMask)
    ELSE
      IF ~SELF.TPos
        l = SELF.PPos
        r = 0
        SELF.PPad = CHOOSE(Mask[SELF.PPos+3] = '0')
        IF SELF.PPad
          lSize += 1
        END
      ELSIF ~SELF.PPos
        l = SELF.TPos
        r = 0
      ELSE
        l = CHOOSE(SELF.TPos < SELF.PPos, SELF.TPos, SELF.PPos)
        r = CHOOSE(SELF.TPos > SELF.PPos, SELF.TPos, SELF.PPos)
        SELF.PPad = CHOOSE(Mask[SELF.PPos+3] = '0')
        IF SELF.PPad
          IF SELF.TPos > SELF.PPos
            lSize += 1
          ELSE
            rSize += 1
          END
        END
      END
      IF SELF.TPos ~= 1 AND SELF.PPos ~= 1
        SELF.MaskBits[1] = 1
      ELSE
        SELF.MaskBits[1] = 0
      END
      SELF.MaskBits[2] = l - 1
      SELF.MaskBits[3] = l + lSize
      IF r
        IF SELF.MaskBits[3] = r
          SELF.MaskBits[3] = 0
        END
        SELF.MaskBits[4] = r - 1
        SELF.MaskBits[5] = r + rSize
        SELF.MaskBits[6] = LEN(SELF.GenerationMask) + 1
      ELSE
        SELF.MaskBits[4] = LEN(SELF.GenerationMask) + 1
      END
    END

NameGenerator.MakeNumber      PROCEDURE(SHORT num)
  CODE
    IF SELF.PPad
      RETURN ALL('0', LEN(SELF.TotalPages) - LEN(num)) & num
    ELSE
      RETURN num
    END

NameGenerator.MakeMask        PROCEDURE(SHORT PageNumber)
FullStr CSTRING(28),AUTO
  CODE
    IF SELF.MaskBits[1]
      FullStr = SELF.GenerationMask[SELF.MaskBits[1] : SELF.MaskBits[2]]
    ELSE
      FullStr = ''
    END
    IF ~SELF.TPos
      IF SELF.PPos
        FullStr = FullStr & SELF.MakeNumber(PageNumber)
        FullStr = FullStr & SELF.GenerationMask[SELF.MaskBits[3] : SELF.MaskBits[4]]
      END
    ELSIF ~SELF.PPos
      FullStr = FullStr & SELF.TotalPages
      FullStr = FullStr & SELF.GenerationMask[SELF.MaskBits[3] : SELF.MaskBits[4]]
    ELSIF SELF.TPos < SELF.PPos
      FullStr = FullStr & SELF.TotalPages
      IF SELF.MaskBits[3]
        FullStr = FullStr & SELF.GenerationMask[SELF.MaskBits[3] : SELF.MaskBits[4]]
      END
      FullStr = FullStr & SELF.MakeNumber(PageNumber)
      FullStr = FullStr & SELF.GenerationMask[SELF.MaskBits[5] : SELF.MaskBits[6]]
    ELSE
      FullStr = FullStr & SELF.MakeNumber(PageNumber)
      IF SELF.MaskBits[3]
        FullStr = FullStr & SELF.GenerationMask[SELF.MaskBits[3] : SELF.MaskBits[4]]
      END
      FullStr = FullStr & SELF.TotalPages
      FullStr = FullStr & SELF.GenerationMask[SELF.MaskBits[5] : SELF.MaskBits[6]]
    END
    RETURN FullStr

NameGenerator.MakeName        PROCEDURE(SHORT PageNumber)
  CODE
    RETURN SELF.ReportName & SELF.MakeMask(PageNumber) & SELF.Extension

NameGenerator.GetName         PROCEDURE(BYTE nameType = Name:Full,SHORT PageNumber = 0)
  CODE
     RETURN SELF.GetDataFromName(SELF.ReportName,nameType,PageNumber)

NameGenerator.GetDataFromName    PROCEDURE(STRING Name,BYTE nameType = Name:Full,SHORT PageNumber = 0)
LOC:Path  CSTRING(FILE:MaxFilePath),AUTO
LOC:Drive CSTRING(FILE:MaxFilePath),AUTO
LOC:Dir   CSTRING(FILE:MaxFilePath),AUTO
LOC:Name  CSTRING(FILE:MaxFilePath),AUTO
FullStr   CSTRING(28),AUTO

  CODE
    IF PageNumber
        FullStr = SELF.MakeMask(PageNumber)
    ELSE
        FullStr = ''
    END
    IF nameType = Name:Full
      RETURN Name & FullStr & SELF.Extension
    ELSIF nameType = Name:Extension
      RETURN SELF.Extension
    ELSE
      LOC:Path = Name & FullStr & SELF.Extension
      PathSplit(LOC:Path, LOC:Drive, LOC:Dir, LOC:Name)
      IF BAND(nameType, Name:Path)
        IF BAND(nameType, Name:Name)
          PathMerge(LOC:Path, LOC:Drive,  LOC:Dir, LOC:Name)
        ELSE
          LOC:Name=''
          PathMerge(LOC:Path, LOC:Drive,  LOC:Dir,LOC:Name)!, SELF.Extension)
        END
      ELSE ! Name must be set
        IF BAND(nameType, Name:Extension)
          PathMerge(LOC:Path, , , LOC:Name, SELF.Extension)
        ELSE
          RETURN LOC:Name
        END
      END
      RETURN LOC:Path
    END

NameGenerator.GetExtension    PROCEDURE()
  CODE
    RETURN SELF.Extension

NameGenerator.ExtractFileName PROCEDURE(STRING value)
LOC:Path  CSTRING(FILE:MaxFilePath),AUTO
LOC:Drive CSTRING(FILE:MaxFilePath),AUTO
LOC:Dir   CSTRING(FILE:MaxFilePath),AUTO
LOC:Name  CSTRING(FILE:MaxFilePath),AUTO

  CODE
    IF ~value
      SELF.ReportName = SELF.DefaultName
      SELF.Extension = SELF.DefaultExtension
    ELSE
      LOC:Path = value
      PathSplit(LOC:Path, LOC:Drive, LOC:Dir, LOC:Name, SELF.Extension)
      PathMerge(SELF.ReportName, LOC:Drive,  LOC:Dir, LOC:Name)
      IF ~SELF.Extension
        SELF.Extension = SELF.DefaultExtension
      END
    END

