   MEMBER
COMPILE('__Test__',_WebCoreDllMode_)
ERROR: _WebCoreDllMode_ set incorrectly
__Test__

   INCLUDE('WBSTD.INC'),ONCE
   INCLUDE('ABLPROP.INC'),ONCE
   INCLUDE('ABLLIST.INT'),ONCE
   INCLUDE('WBFILES.INC'),ONCE
   INCLUDE('WSLPROP.INT'),ONCE
   INCLUDE('LAYVALUE.INT'),ONCE

A:ChildIndex            ASTRING('ChildIndex')
A:Children              ASTRING('Children')
A:Container             ASTRING('Container')
A:Window                ASTRING('Window')
A:XPosition             ASTRING('XPosition')
A:YPosition             ASTRING('YPosition')

!!-----------------------------------------------------------------------

CreateReferenceValue      PROCEDURE(IProperties props)
vf                      &IValueFactory,AUTO
  CODE
  IF (NOT props &= NULL)
    vf &= GetValueFactory()
    RETURN vf.CreateCompound(props)
  END
  RETURN NULL

CreateCValue              PROCEDURE(SIGNED proptype, CONST * CSTRING value)
vf                      &IValueFactory,AUTO
  CODE
  vf &= GetValueFactory()
  case (proptype)
  of WslPropType:unknown
    RETURN NULL
  of WslPropType:boolean
    RETURN vf.createBool(value)
  of WslPropType:integer
    RETURN vf.createInt(value)
  ELSE
    RETURN vf.createString(value)
  END

CreateValue               PROCEDURE(SIGNED proptype, STRING value)
vf                      &IValueFactory,AUTO
temp                    &CSTRING,AUTO
ret                     &IValue,auto
  CODE
  vf &= GetValueFactory()
  case (proptype)
  of WslPropType:unknown
    RETURN NULL
  of WslPropType:boolean
    RETURN vf.createBool(value)
  of WslPropType:integer
    RETURN vf.createInt(value)
  ELSE
    temp &= NEW CSTRING(LEN(value)+1)
    temp = value
    ret &= vf.createString(temp)
    DISPOSE(temp)
    RETURN ret
  END

CreateBoolValue         PROCEDURE(BOOL value)
vf                      &IValueFactory,AUTO
  CODE
  vf &= GetValueFactory()
  RETURN vf.createBool(value)

CreateIntegerValue      PROCEDURE(SIGNED value)
vf                      &IValueFactory,AUTO
  CODE
  vf &= GetValueFactory()
  RETURN vf.createInt(value)

CreateStringValue       PROCEDURE(STRING value)
vf                      &IValueFactory,AUTO
temp                    &CSTRING,AUTO
ret                     &IValue,auto
  CODE
  vf &= GetValueFactory()
  temp &= NEW CSTRING(LEN(value)+1)
  temp = value
  ret &= vf.createString(temp)
  DISPOSE(temp)
  RETURN ret

!!-----------------------------------------------------------------------

WbPropertiesClass.GetProperty               PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0)
  CODE
  RETURN NULL

WbPropertiesClass.SetProperty               PROCEDURE(ASTRING name, STRING value)
  CODE

WbPropertiesClass.IProperties.GetProperty               PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0)
  CODE
  RETURN SELF.GetProperty(name, idx1, idx2)

WbPropertiesClass.IProperties.SetProperty               PROCEDURE(ASTRING name, STRING value)
  CODE
  SELF.SetProperty(name, value)

!!-----------------------------------------------------------------------

WbCoreHtmlProperties.Construct  PROCEDURE
  CODE
  SELF.Contents &= NEW FeqQueue

WbCoreHtmlProperties.Destruct PROCEDURE
  CODE
  DISPOSE(SELF.Contents)

WbCoreHtmlProperties.AddContents               PROCEDURE(WebControlId Child, SIGNED index)
  CODE
  IF (SELF.Type = CREATE:sheet) AND (index = 0)
    SELF.AddToAllTabs(Child)
  ELSE
    SELF.Contents.cid = child
    SELF.Contents.index = CHOOSE(index <> 0, index, 9999)
    ADD(SELF.Contents, SELF.Contents.index)    ! Ensure ChildIndex matches window order
  END

WbCoreHtmlProperties.AddToAllTabs              PROCEDURE(WebControlId Child)
idx                     SIGNED,AUTO
Match                   &IControlToHtml,AUTO
  CODE
  LOOP idx = 1 TO RECORDS(SELF.Contents)
    GET(SELF.Contents, idx)
    Match &= SELF.Map.Map(SELF.Contents.cid)
    Match.AddContents(Child)
  END

WbCoreHtmlProperties.CanContain                PROCEDURE
  CODE
  RETURN FALSE

WbCoreHtmlProperties.GetContainer PROCEDURE
  CODE
  RETURN SELF.Container

WbCoreHtmlProperties.GetDefaultContainerIndex  PROCEDURE
  CODE
  RETURN 1000

WbCoreHtmlProperties.GetName PROCEDURE
  CODE
  ASSERT(FALSE,'Abstract called')
  RETURN ''

WbCoreHtmlProperties.GetPosition  PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>)
  CODE
  ASSERT(FALSE,'Abstract called')

WbCoreHtmlProperties.GetProperty  PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0)
Match                   &IControlToHtml,AUTO
x                       SIGNED,AUTO
y                       SIGNED,AUTO
w                       SIGNED,AUTO
h                       SIGNED,AUTO
val                     SIGNED,AUTO
  CODE
  IF (A:ChildIndex = name)
    RETURN CreateIntegerValue(SELF.GetIndexInContainer())
  ELSIF (A:Children = name)
    IF (idx1 >= 0) AND (idx1 < RECORDS(SELF.Contents))
      GET(SELF.Contents, idx1+1)
      Match &= SELF.Map.Map(SELF.Contents.cid)
      RETURN CreateReferenceValue(Match.QueryProperties())
    END
  ELSIF (A:Container = name)
    Match &= SELF.Map.Map(SELF.Container)
    IF (NOT Match &= NULL)
      RETURN CreateReferenceValue(Match.QueryProperties())
    END
  ELSIF (A:XPosition = name) OR (A:YPosition = name)
    SELF.GetPosition(x, y, w, h)
    IF (A:XPosition = name)
      val = x
    ELSIF (A:YPosition = name)
      val = y
    END
    RETURN CreateIntegerValue(val)
  ELSIF (A:Window = name)
    Match &= SELF.Map.GetRoot();
    RETURN CreateReferenceValue(Match.QueryProperties())
  END
  RETURN NULL


WbCoreHtmlProperties.GetSkeletonAttr           PROCEDURE(SIGNED whichAttr)
curProp                 &IHtmlElementProperties,AUTO
curWindow               &IControlToHtml,AUTO
  CODE
  IF (whichAttr = SkeletonAttr:Theme)
    curWindow &= SELF.Map.GetRoot()
    IF (NOT curWindow &= SELF.IControlToHtml)
      curProp &= curWindow.QueryProperties()
      RETURN curProp.GetSkeletonAttr(whichAttr);
    END
  END
  RETURN ''

WbCoreHtmlProperties.GetTargetZone             PROCEDURE()
  CODE
  RETURN ''

WbCoreHtmlProperties.GetVisible    PROCEDURE
  CODE
    RETURN TRUE

WbCoreHtmlProperties.Init   PROCEDURE(WebControlId cid)
  CODE
    SELF.cid = cid
    SELF.Container = 0

WbCoreHtmlProperties.IsDefaultButton      PROCEDURE
  CODE
    RETURN FALSE


WbCoreHtmlProperties.IsFontNeeded   PROCEDURE
  CODE
    RETURN FALSE


WbCoreHtmlProperties.IsHidden   PROCEDURE
  CODE
    RETURN FALSE


WbCoreHtmlProperties.SetProperty  PROCEDURE(ASTRING name, STRING value)
  CODE


WbCoreHtmlProperties.BeforeResponse    PROCEDURE()
  CODE

WbCoreHtmlProperties.TakeResponse      PROCEDURE(STRING subControl, STRING value, ResetType type, IWbEventProcessor EventProcessor)
  CODE

WbCoreHtmlProperties.AfterResponse     PROCEDURE()
  CODE

WbCoreHtmlProperties.GetIndexInContainer    PROCEDURE()
Container               &IControlToHtml,AUTO
Index                   SIGNED,AUTO
  CODE
  Container &= SELF.Map.Map(SELF.Container)
  IF (NOT Container &= NULL)
    LOOP Index = 1 TO Container.GetContentCount()
      IF (SELF.cid = Container.GetContents(Index))
        RETURN Index
      END
    END
  END
  RETURN 0


!!-----------------------------------------------------------------------

WbCoreHtmlProperties.IHtmlElementProperties.GetPosition  PROCEDURE(* SIGNED x, * SIGNED y, * SIGNED w, * SIGNED h, <* SIGNED nowidth>, <* SIGNED noheight>)
  CODE
    SELF.GetPosition(x, y, w, h, nowidth, noheight)

WbCoreHtmlProperties.IHtmlElementProperties.GetProperty  PROCEDURE(ASTRING name, UNSIGNED idx1, UNSIGNED idx2)
  CODE
  RETURN SELF.GetProperty(name, idx1, idx2)

WbCoreHtmlProperties.IHtmlElementProperties.SetProperty  PROCEDURE(ASTRING name, STRING value)
  CODE
  SELF.SetProperty(name, value)

WbCoreHtmlProperties.IHtmlElementProperties.GetName PROCEDURE
  CODE
    RETURN SELF.GetName()

WbCoreHtmlProperties.IHtmlElementProperties.GetSkeletonAttr PROCEDURE(SIGNED whichAttr)
  CODE
    RETURN SELF.GetSkeletonAttr(whichAttr)

WbCoreHtmlProperties.IHtmlElementProperties.GetTargetZone PROCEDURE
  CODE
  RETURN SELF.GetTargetZone()

WbCoreHtmlProperties.IHtmlElementProperties.GetExpandNow  PROCEDURE
  CODE
  RETURN TRUE

WbCoreHtmlProperties.IHtmlElementProperties.IsHidden   PROCEDURE
  CODE
    RETURN SELF.IsHidden()


!WbCoreHtmlProperties.IHtmlElementProperties.Link PROCEDURE
!  CODE
!  SELF.Link

!WbCoreHtmlProperties.IHtmlElementProperties.Release PROCEDURE
!  CODE
!  SELF.Release


!!-----------------------------------------------------------------------

WbCoreHtmlProperties.IControlToHtml.Link PROCEDURE
  CODE
  SELF.Link

WbCoreHtmlProperties.IControlToHtml.Release PROCEDURE
  CODE
  SELF.Release


WbCoreHtmlProperties.IControlToHtml.AddContents               PROCEDURE(WebControlId Child, SIGNED index)
  CODE
  SELF.AddContents(child, index)

WbCoreHtmlProperties.IControlToHtml.CanContain                PROCEDURE
  CODE
    RETURN SELF.CanContain()

WbCoreHtmlProperties.IControlToHtml.GetDefaultContainerIndex  PROCEDURE
  CODE
  RETURN SELF.GetDefaultContainerIndex()

WbCoreHtmlProperties.IControlToHtml.RemoveContents            PROCEDURE(WebControlId Child)
  CODE
    SELF.Contents.cid = child
    GET(SELF.Contents, SELF.Contents.cid)
    DELETE(SELF.Contents)

WbCoreHtmlProperties.IControlToHtml.GetContainer      PROCEDURE
  CODE
    RETURN SELF.GetContainer()

WbCoreHtmlProperties.IControlToHtml.GetContentCount   PROCEDURE
  CODE
    RETURN RECORDS(SELF.Contents)

WbCoreHtmlProperties.IControlToHtml.GetContents       PROCEDURE(SIGNED index)
  CODE
    GET(SELF.Contents, index)
    RETURN SELF.Contents.cid

WbCoreHtmlProperties.IControlToHtml.GetId            PROCEDURE
  CODE
    RETURN SELF.cid

WbCoreHtmlProperties.IControlToHtml.IsDefaultButton      PROCEDURE
  CODE
    RETURN SELF.IsDefaultButton()

WbCoreHtmlProperties.IControlToHtml.QueryProperties   PROCEDURE
  CODE
    RETURN SELF.IHtmlElementProperties

WbCoreHtmlProperties.IControlToHtml.SetContainer PROCEDURE(WebControlId Container)
  CODE
    SELF.Container = Container

WbCoreHtmlProperties.IControlToHtml.SetMap      PROCEDURE(IMapFeqToControl Map)
  CODE
    SELF.Map &= Map

WbCoreHtmlProperties.IControlToHtml.BeforeResponse    PROCEDURE()
  CODE
    SELF.BeforeResponse()

WbCoreHtmlProperties.IControlToHtml.TakeResponse      PROCEDURE(STRING subControl, STRING value, ResetType type, IWbEventProcessor EventProcessor)
  CODE
    SELF.TakeResponse(subControl, value, type, EventProcessor)

WbCoreHtmlProperties.IControlToHtml.AfterResponse     PROCEDURE()
  CODE
    SELF.AfterResponse()

WbCoreHtmlProperties.IControlToHtml.GetVisible     PROCEDURE()
  CODE
    RETURN SELF.GetVisible()



