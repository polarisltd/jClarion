
  MEMBER

  INCLUDE('WBFILE.INC'),ONCE
  INCLUDE('WBFILES.INC'),ONCE
  INCLUDE('WBREPORT.INC'),ONCE

MaxNotDisplayed         EQUATE(100000)

A:MaxRecCount           ASTRING('MaxRecordCount')
A:MaxNotDisplayed       ASTRING('MaxNotDisplayed')
A:UseLineCounting       ASTRING('LineCountBoolean')


WebDetailProperties.GetProperty                  PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0)

IV                      &IValue,AUTO

  CODE
    IF (name = A:MoreRecords)
      RETURN CreateValue(WSLPROPTYPE:boolean, CHOOSE(SELF.AnyMore AND NOT SELF.PageBreak))
    ELSIF (name = A:MaxRecCount)
      RETURN CreateValue(WSLPROPTYPE:integer, SELF.MaxRecordCount)
    ELSIF (name = A:MaxNotDisplayed)
      RETURN CreateValue(WSLPROPTYPE:integer, MaxNotDisplayed)
    ELSIF (name = A:UseLineCounting)
      RETURN CreateValue(WSLPROPTYPE:integer, SELF.UseLineCounting)
    ELSE
      IV &= SELF.WebFileAccess.GetProperty(name, idx1, idx2)
      IF ~IV &= NULL
        RETURN IV
      ELSE
        RETURN PARENT.GetProperty(name, idx1, idx2)
      END
    END

WebDetailProperties.GetSkeletonAttr              PROCEDURE(SIGNED WhichAttr)

  CODE
    IF whichattr = SkeletonAttr:Name
      RETURN SELF.SkeletonFile
    ELSE
      RETURN Parent.GetSkeletonAttr(whichattr)
    END

WebDetailProperties.NextPage                     PROCEDURE()

  CODE
    SELF.CurPage += 1
    IF SELF.CurPage > 1
      ENABLE(SELF.PreviousFeq)
    END
    SELF.ChangePage

WebDetailProperties.PreviousPage                 PROCEDURE()

  CODE
    SELF.CurPage -= 1
    SELF.ChangePage

WebDetailProperties.ChangePage                   PROCEDURE()

  CODE
    SELF.PageBreak = FALSE
    SELF.GlobalFiles.SetSuffix(SELF.OldSuffix & '.' & SELF.CurPage)

WebDetailProperties.Init                         PROCEDURE(WbFileProperties Wbf, SIGNED feq, ProcessClass Process, SIGNED NextFeq, SIGNED PreviousFeq, STRING SkeletonFile)

  CODE
    SELF.WebFileAccess &= Wbf
    SELF.SkeletonFile &= NEW(STRING(LEN(CLIP(SkeletonFile))))
    SELF.SkeletonFile = SkeletonFile
    SELF.Process &= Process
    SELF.NextFeq = NextFeq
    SELF.PreviousFeq = PreviousFeq
    DISABLE(SELF.PreviousFeq)
    PARENT.Init(feq, FEQ:Unknown)
    SELF.AnyMore = TRUE
    SELF.PageBreak = FALSE
    SELF.GlobalFiles &= WbFilesClass::Get()
    SELF.OldSuffix = SELF.GlobalFiles.GetSuffix()
    SELF.LastPage = 0
    SELF.CurPage = 0
    SELF.NextPage()

WebDetailProperties.Kill                         PROCEDURE

  CODE
    SELF.GlobalFiles.SetSuffix(SELF.OldSuffix)
    IF ~SELF.SkeletonFile &= NULL
      DISPOSE(SELF.SkeletonFile).

WebDetailProperties.SetProperty                  PROCEDURE(ASTRING name, STRING value)

  CODE
    IF (name = A:NextRecord)
      SELF.AnyMore = CHOOSE(SELF.Process.Next(FALSE)=LEVEL:Benign,1,0)
      IF ~SELF.AnyMore
        DISABLE(SELF.NextFeq)
      END
    ELSIF (name = A:CheckPageBreak)
      SELF.PageBreak = 1
    ELSIF (name = A:Reset)
      SELF.Process.Reset()
      SELF.AnyMore = CHOOSE(SELF.Process.Next(FALSE)=LEVEL:Benign,1,0)
    ELSE
      PARENT.SetProperty(name, value)
    END

