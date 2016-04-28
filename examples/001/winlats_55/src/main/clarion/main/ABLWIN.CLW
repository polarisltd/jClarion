   MEMBER
COMPILE('__Test__',_WebCoreDllMode_)
ERROR: _WebCoreDllMode_ set incorrectly
__Test__
   MAP
   .

   INCLUDE('ABLPROP.INT'),ONCE
   INCLUDE('ABLWIN.INC'),ONCE
   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('WBSTD.INC'),ONCE

!!========================= Helper procedures... ===========================

WbWindowBaseClass.AddControl                PROCEDURE(IControlToHtml Control)
  CODE
  Control.Link()
  SELF.AddOwnedControl(Control)


WbWindowBaseClass.AddOwnedControl                PROCEDURE(IControlToHtml Control)
Properties              &IHtmlElementProperties
  CODE
  SELF.Controls.CId = Control.GetId()
!  SELF.Controls.Id = 0
  SELF.Controls.ContainerNotified = false
  SELF.Controls.Control &= Control
  Properties &= Control.QueryProperties()
  SELF.Controls.Name = lower(Properties.GetName())
  ADD(SELF.Controls)
  Control.SetMap(SELF.IMapFeqToControl)
  SELF.NeedToSync = true

WbWindowBaseClass.GenerateHTML              PROCEDURE(STRING Filename)
  CODE
  SELF.ResetVisibility()
  SELF.Builder.GenerateSkeleton(Filename, SELF.SkeletonRoot)

WbWindowBaseClass.MapToIControl             PROCEDURE(WebControlId From)
  CODE
  SELF.Controls.cid =From
  SELF.Controls.Control &= NULL
  GET(SELF.Controls, +SELF.Controls.cid)
  RETURN SELF.Controls.Control


WbWindowBaseClass.GetControl             PROCEDURE(STRING Name)
  CODE
  SELF.Controls.Name = lower(Name)
  SELF.Controls.Control &= NULL
  GET(SELF.Controls, SELF.Controls.Name)
  RETURN SELF.Controls.Control


WbWindowBaseClass.GetHasControl             PROCEDURE(WebControlId cId)
  CODE
  SELF.Controls.CID = cId
  GET(SELF.Controls, +SELF.Controls.CID)
  RETURN CHOOSE(ERRORCODE() = 0)


WbWindowBaseClass.Init                      PROCEDURE
  CODE
  SELF.Controls &= NEW ControlMapQueue
  SELF.Builder &= CreatePageBuilder()


WbWindowBaseClass.InitialiseDefaults             PROCEDURE
  CODE
    SELF.ResetFromWindow()
    SELF.SetParentDefaults()


WbWindowBaseClass.Kill                      PROCEDURE
Index                   SIGNED,AUTO
  CODE
  LOOP Index = 1 TO RECORDS(SELF.Controls)
    GET(SELF.Controls, Index)
    SELF.Controls.Control.Release()
  END
  DISPOSE(SELF.Controls)
  SELF.Builder.Release()

WbWindowBaseClass.Reset                 PROCEDURE
  CODE
  SELF.NeedToSync = true

WbWindowBaseClass.ResetFromWindow           PROCEDURE
  CODE
    ASSERT(FALSE, 'Should be pure virtual')

WbWindowBaseClass.ResetVisibility           PROCEDURE
  CODE
    !Recurse down through the controls, starting with the containers, and working
    !down to the most nested controls.  This ensures that the control's
    !container has already been registered with the web class

    IF (SELF.NeedToSync)
      SELF.AddToContainers()
      SELF.Builder.ClearContents()
      SELF.SkeletonRoot = SELF.ResetVisibility(SELF.RootId, 0)
      SELF.NeedToSync = FALSE
    END

WbWindowBaseClass.ResetVisibility           PROCEDURE(WebControlId Root, SkeletonElementId ParentId)
Index                   SIGNED,auto
cur                     &IControlToHtml,auto
ThisId                  SkeletonElementId,auto
  CODE
    SELF.Controls.CId = Root
    GET(SELF.Controls, +SELF.Controls.CID)

    ThisId = SELF.Builder.AddElement(SELF.Controls.Control.QueryProperties(), ParentId)
    !Clarion QUEUE could be corrupted...
    SELF.Controls.CID = Root
    GET(SELF.Controls, +SELF.Controls.CID)

    cur &= SELF.Controls.Control
    LOOP Index = 1 TO cur.GetContentCount()
      SELF.ResetVisibility(cur.GetContents(index), ThisId)
    END
    RETURN ThisId


WbWindowBaseClass.AddToContainers PROCEDURE
index                   SIGNED,AUTO
  CODE
    LOOP index = 1 TO RECORDS(SELF.Controls)
      GET(SELF.Controls, index)
      SELF.AddCurrentToContainer()
    END

WbWindowBaseClass.AddCurrentToContainer   PROCEDURE
container               WebControlId,AUTO
cur                     WebControlId,AUTO
contindex               SIGNED,AUTO
  CODE
    IF (NOT SELF.Controls.ContainerNotified)
      SELF.Controls.ContainerNotified = true
      PUT(SELF.Controls)
      cur = SELF.Controls.Cid
      container = SELF.Controls.Control.GetContainer()
      contindex = SELF.Controls.Control.GetDefaultContainerIndex()

      SELF.Controls.cid = container
      GET(SELF.Controls, +SELF.Controls.cid)
      IF (~ERRORCODE())
        SELF.Controls.Control.AddContents(cur, contindex)
      END
    END

WbWindowBaseClass.SetControlParentDefaults PROCEDURE(WebControlId Root)
all                     PositionQueue
bestMatch               SIGNED
bestScore               SIGNED
containers              PositionQueue
containerIndex          SIGNED,AUTO
cur                     &IControlToHtml
curFeq                  WebControlId
index                   SIGNED
index2                  SIGNED
score                   SIGNED
properties              &IHtmlElementProperties
  CODE
    SELF.Controls.cid = Root
    GET(SELF.Controls, SELF.Controls.cid)
    ASSERT(~ERRORCODE())
    cur &= SELF.Controls.Control

    ! Get a list of all the controls contained by this control
    ! Build a separate list of all the containers
    LOOP index = 1 TO cur.GetContentCount()
      SELF.Controls.cid = cur.GetContents(index)
      GET(SELF.Controls, SELF.Controls.cid)
      all.cid = SELF.Controls.cid
      all.Control &= SELF.Controls.Control
      properties &= SELF.Controls.Control.QueryProperties()
      properties.GetPosition(all.x, all.y, all.w, all.h)
      ADD(all)
      IF (SELF.Controls.Control.CanContain())
         containers :=: all
         ADD(containers)
      END
    END

    ! Now find the best matching container
    IF (RECORDS(containers))
      LOOP index = 1 TO RECORDS(all)
        GET(all, index)
        curFeq = all.cid
        bestMatch = 0
        bestScore = 9999
        containerIndex = 0
        LOOP index2 = 1 TO RECORDS(containers)
          GET(containers, index2)
          IF (all.cid <> containers.cid)
            IF (all.x >= containers.x) AND |
               (all.y >= containers.y) AND |
               (all.x + all.w <= containers.x + containers.w) AND |
               (all.y + all.h <= containers.y + containers.h)
              score = (all.x - containers.x) + |
                      (all.y - containers.y) + |
                      (containers.x + containers.w - (all.x + all.w)) + |
                      (containers.y + containers.h - (all.y + all.h));
              IF (score <> 0) AND (score < bestScore)
                bestScore = score
                bestMatch = index2
              END
            END
          ELSE
            containerIndex = index2
          END
        END
        IF (bestMatch)
          GET(containers, bestMatch)

          ! Transfer ownership....
          SELF.Controls.cid = Root
          GET(SELF.Controls, SELF.Controls.cid)
          SELF.Controls.Control.RemoveContents(curFeq)

          containers.Control.AddContents(curFeq)

          ! Remove this control from the list of potential containers
          ! otherwise we can end up including two things in each other....
          IF (containerIndex)
            GET(containers, containerIndex)
            DELETE(containers)
          END
        END
      END

      ! Now check each of our containers....
      LOOP index = 1 TO RECORDS(containers)
        GET(containers, index)
        SELF.SetControlParentDefaults(containers.cid)
      END
    END

WbWindowBaseClass.SetFormatOptions    PROCEDURE(SIGNED dx, SIGNED dy, SIGNED d2x, SIGNED d2y)
  CODE

WbWindowBaseClass.SetParentDefaults PROCEDURE
  CODE
    SELF.AddToContainers
    SELF.SetControlParentDefaults(SELF.RootId)

WbWindowBaseClass.TakeEvent PROCEDURE
  CODE
    CASE EVENT()
    OF EVENT:OpenWindow
      SELF.InitialiseDefaults
    END
    RETURN Level:Benign


!!---------------------------------------------------------------------------

WbWindowBaseClass.IPageCreator.CreatePage             PROCEDURE(STRING Filename)
  CODE
    SELF.GenerateHTML(Filename)
    RETURN TRUE


!!---------------------------------------------------------------------------

WbWindowBaseClass.WindowComponent.Kill PROCEDURE
  CODE
  SELF.Kill


WbWindowBaseClass.WindowComponent.Reset PROCEDURE(BYTE Force)
  CODE


WbWindowBaseClass.WindowComponent.ResetRequired PROCEDURE  ! 1 if reset of window required
  CODE
  RETURN False


WbWindowBaseClass.WindowComponent.SetAlerts PROCEDURE
  CODE


WbWindowBaseClass.WindowComponent.TakeEvent PROCEDURE
  CODE
  RETURN SELF.TakeEvent()


WbWindowBaseClass.WindowComponent.Update PROCEDURE        ! Everything but the window!
  CODE


WbWindowBaseClass.WindowComponent.UpdateWindow PROCEDURE
  CODE


!!---------------------------------------------------------------------------

WbWindowBaseClass.IMapFeqToControl.Map             PROCEDURE(WebControlId From)
  CODE
  RETURN SELF.MapToIControl(From)


WbWindowBaseClass.IMapFeqToControl.GetRoot         PROCEDURE
  CODE
  RETURN SELF.MapToIControl(SELF.RootId)



