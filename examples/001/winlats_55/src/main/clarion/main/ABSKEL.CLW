  MEMBER

  INCLUDE('ABSKEL.INC'),ONCE
  MAP
  END

A:MoreRecords         ASTRING('MoreRecords')
A:NextRecord          ASTRING('NextRecord')

A:MaxRecCount           ASTRING('MaxRecordCount')
A:MaxNotDisplayed       ASTRING('MaxNotDisplayed')
A:UseLineCounting       ASTRING('LineCountBoolean')

MergeElement.Init                      PROCEDURE(STRING SkeletonFile, WbFileProperties Wbf)
SkelPhase          CSTRING('MERGE')
  CODE
    SELF.SkeletonFile &= NEW(STRING(LEN(CLIP(SkeletonFile))))
    SELF.SkeletonFile = SkeletonFile
    SELF.WebFileAccess &= Wbf
    SELF.PageBuilder &= CreatePageBuilder()
    SELF.PageBuilder.Init(SkelPhase,True)

MergeElement.Kill                      PROCEDURE()
  CODE
    DISPOSE(SELF.SkeletonFile)
    SELF.PageBuilder.Release

MergeElement.GetProperty               PROCEDURE(ASTRING name, UNSIGNED idx1=0, UNSIGNED idx2=0)

IV                      &IValue,AUTO

  CODE
    IV &= SELF.WebFileAccess.GetProperty(name, idx1, idx2)
    IF ~IV &= NULL
      RETURN IV
    ELSE
      RETURN NULL
    END

MergeElement.SetProperty               PROCEDURE(ASTRING name, STRING value)
  CODE

MergeElement.GenerateDocument   PROCEDURE(STRING FileName)
Id                 SkeletonElementId,auto

  CODE
    Id = SELF.PageBuilder.AddElement(SELF.IHtmlElementProperties, 0)
    SELF.PageBuilder.GenerateSkeleton(FileName, Id)


MergeElement.GetName            PROCEDURE()
  CODE
    RETURN 'MERGE'

MergeElement.GetPosition  PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>)
  CODE
    x = 100
    y = 100
    w = 100
    h = 100

MergeElement.GetSkeletonAttr    PROCEDURE(SIGNED whichAttr)
  CODE
    IF whichattr = SkeletonAttr:Name
      RETURN SELF.SkeletonFile
    ELSE
      RETURN ''
    END

!!-----------------------------------------------------------------------
MergeElement.IHtmlElementProperties.GetPosition  PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>)

  CODE
    SELF.GetPosition(x, y, w, h)

MergeElement.IHtmlElementProperties.GetProperty  PROCEDURE(ASTRING name, SIGNED idx1, SIGNED idx2)

  CODE
    RETURN SELF.GetProperty(name, idx1, idx2)

MergeElement.IHtmlElementProperties.SetProperty  PROCEDURE(ASTRING name, STRING value)

  CODE
    SELF.SetProperty(name, value)

MergeElement.IHtmlElementProperties.GetName PROCEDURE

  CODE
    RETURN SELF.GetName()

MergeElement.IHtmlElementProperties.GetSkeletonAttr PROCEDURE(SIGNED whichAttr)

  CODE
    RETURN SELF.GetSkeletonAttr(whichAttr)

MergeElement.IHtmlElementProperties.GetTargetZone PROCEDURE

  CODE
    RETURN ''

MergeElement.IHtmlElementProperties.GetExpandNow  PROCEDURE

  CODE
    RETURN TRUE

MergeElement.IHtmlElementProperties.IsHidden   PROCEDURE
  CODE
    RETURN FALSE

!!-----------------------------------------------------------------------

ReportElement.Init               PROCEDURE(ProcessClass Process, STRING SkeletonFile, WbFileProperties Wbf)
  CODE
  SELF.Process &= Process
  SELF.SkeletonFile = SkeletonFile
  SELF.WebFileAccess &= Wbf

  SELF.Process.Reset()
  SELF.AnyMore = CHOOSE(SELF.Process.Next(FALSE)=LEVEL:Benign,1,0)
  SELF.MaxRecordCount = 999 ! jvn Make it infinite or configurable.

ReportElement.GetProperty                  PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0)

IV                      &IValue,AUTO

  CODE
    IF (name = A:MoreRecords)
      RETURN CreateValue(WSLPROPTYPE:boolean, CHOOSE(SELF.AnyMore))
    ELSIF (name = A:MaxRecCount)
      RETURN CreateValue(WSLPROPTYPE:integer, SELF.MaxRecordCount)
    ELSE
      RETURN PARENT.GetProperty(name, idx1, idx2)
    END



ReportElement.GetSkeletonAttr              PROCEDURE(SIGNED WhichAttr)

  CODE
    IF whichattr = SkeletonAttr:Name
      RETURN SELF.SkeletonFile
    ELSE
      RETURN Parent.GetSkeletonAttr(whichattr)
    END

ReportElement.SetProperty                  PROCEDURE(ASTRING name, STRING value)

  CODE
    IF (name = A:NextRecord)
      SELF.AnyMore = CHOOSE(SELF.Process.Next(FALSE)=LEVEL:Benign,1,0)
    ELSE
      PARENT.SetProperty(name, value)
    END

