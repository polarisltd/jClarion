! Server routines for browse windows
  MEMBER
  MAP
  END
  INCLUDE('Errors.CLW'),ONCE
  INCLUDE('Keycodes.CLW'),ONCE
  INCLUDE('ABBROWSE.TRN'),ONCE
  INCLUDE('ABQUERY.INC'),ONCE
  INCLUDE('ABBROWSE.INC'),ONCE
  INCLUDE('ABVCRFRM.INC'),ONCE

FormVCRClass.Init              PROCEDURE(SIGNED pVCRGroup,SIGNED VCRPageSize,VIEW V,RelationManager RM,WindowManager WM)
 CODE
    SELF.VCRGroup     = pVCRGroup
    SELF.OnFirstRecord= True
    SELF.OnLastRecord = False
    SELF.NoRecords    = False
    SELF.VCRPageSize  = VCRPageSize
    SELF.MoveDirection= EVENT:ScrollDown
    SELF.InsertWhenNoRecords = False
    SELF.Window &= WM
    IF SELF.Window.Request=0 THEN
       SELF.Window.Request=ViewRecord
    END
    SELF.Sort &= NEW BrowseSortOrder
    PARENT.Init(V,RM,SELF.Sort)
    SELF.Window.AddItem(SELF.FormVCRWindowComponent)
    SELF.Window.FormVCR &= SELF
    SELF.Window.BatchProcessing = True

FormVCRClass.Kill              PROCEDURE()
I UNSIGNED,AUTO
  CODE
    IF ~(SELF.Sort &= NULL)
      LOOP I = 1 TO RECORDS(SELF.Sort)
        GET(SELF.Sort,I)
        IF ~(SELF.Sort.Thumb &= NULL)
          SELF.Sort.Thumb.Kill
        END
        IF ~(SELF.Sort.Resets &= NULL)
           SELF.Sort.Resets.Kill
           DISPOSE(SELF.Sort.Resets)
        END
      END
    END
    SELF.Window.RemoveItem(SELF.FormVCRWindowComponent)
    PARENT.Kill
    DISPOSE(SELF.Sort)
    DISPOSE(SELF.ToolbarItem)

FormVCRClass.GetActionAllowed             PROCEDURE(SIGNED E,BYTE pActionRequested=0)
 CODE
    IF SELF.NoRecords AND NOT(E=EVENT:Accepted AND pActionRequested=InsertRecord) THEN
       RETURN False
    END
    CASE E
    OF EVENT:ScrollUp
       IF SELF.VCRUp AND SELF.VCRUp{PROP:DISABLE}=False AND SELF.VCRUp{PROP:HIDE}=False THEN
          RETURN True
       ELSE
          RETURN False
       END
    OF EVENT:ScrollDown
       IF SELF.VCRDown AND SELF.VCRDown{PROP:DISABLE}=False AND SELF.VCRDown{PROP:HIDE}=False THEN
          RETURN True
       ELSE
          RETURN False
       END
    OF EVENT:PageUp
       IF SELF.VCRPageUp AND SELF.VCRPageUp{PROP:DISABLE}=False AND SELF.VCRPageUp{PROP:HIDE}=False THEN
          RETURN True
       ELSE
          RETURN False
       END
    OF EVENT:PageDown
       IF SELF.VCRPageDown AND SELF.VCRPageDown{PROP:DISABLE}=False AND SELF.VCRPageDown{PROP:HIDE}=False THEN
          RETURN True
       ELSE
          RETURN False
       END
    OF EVENT:ScrollTop
       IF SELF.VCRTop AND SELF.VCRTop{PROP:DISABLE}=False AND SELF.VCRTop{PROP:HIDE}=False THEN
          RETURN True
       ELSE
          RETURN False
       END
    OF EVENT:ScrollBottom
       IF SELF.VCRBottom AND SELF.VCRBottom{PROP:DISABLE}=False AND SELF.VCRBottom{PROP:HIDE}=False THEN
          RETURN True
       ELSE
          RETURN False
       END
    OF EVENT:Accepted
       CASE pActionRequested
       OF InsertRecord
          IF SELF.VCRInsert AND SELF.VCRInsert{PROP:DISABLE}=False AND SELF.VCRInsert{PROP:HIDE}=False THEN
             RETURN True
          ELSE
             IF SELF.VCRNewRecord AND SELF.VCRNewRecord{PROP:DISABLE}=False AND SELF.VCRNewRecord{PROP:HIDE}=False THEN
                RETURN True
             ELSE
                RETURN False
             END
          END
       OF ChangeRecord
          IF SELF.VCRChange AND SELF.VCRChange{PROP:DISABLE}=False AND SELF.VCRChange{PROP:HIDE}=False THEN
             RETURN True
          ELSE
             IF SELF.VCRNewRecord AND SELF.VCRNewRecord{PROP:DISABLE}=False AND SELF.VCRNewRecord{PROP:HIDE}=False THEN
                RETURN True
             ELSE
                RETURN False
             END
          END
       OF DeleteRecord
          IF SELF.VCRDelete AND SELF.VCRDelete{PROP:DISABLE}=False AND SELF.VCRDelete{PROP:HIDE}=False THEN
             IF SELF.VCRNewRecord AND SELF.VCRNewRecord{PROP:DISABLE}=False AND SELF.VCRNewRecord{PROP:HIDE}=False THEN
                RETURN False
             ELSE
                RETURN True
             END
          ELSE
             RETURN False
          END
       OF ViewRecord
          IF SELF.VCRView AND SELF.VCRView{PROP:DISABLE}=False AND SELF.VCRView{PROP:HIDE}=False THEN
             IF SELF.VCRNewRecord AND SELF.VCRNewRecord{PROP:DISABLE}=False AND SELF.VCRNewRecord{PROP:HIDE}=False THEN
                RETURN False
             ELSE
                RETURN True
             END
          ELSE
             RETURN False
          END
       ELSE
          RETURN False
       END
    ELSE
       RETURN False
    END

FormVCRClass.SetRequestControl           PROCEDURE(SIGNED pVCRRequest,SIGNED pVCRViewRecord,SIGNED pVCRInsertRecord,SIGNED pVCRChangeRecord,SIGNED pVCRDeleteRecord)
 CODE
    
    SELF.VCRInsert = pVCRInsertRecord
    SELF.VCRChange = pVCRChangeRecord
    SELF.VCRDelete = pVCRDeleteRecord
    SELF.VCRView   = pVCRViewRecord


    IF SELF.VCRView THEN
       SELF.VCRView{PROP:VALUE}  =ViewRecord
    END
    IF SELF.VCRInsert THEN
       SELF.VCRInsert{PROP:VALUE}=InsertRecord
       SELF.Window.InsertAction = Insert:Batch
    END
    IF SELF.VCRChange THEN
       SELF.VCRChange{PROP:VALUE}=ChangeRecord
    END
    IF SELF.VCRDelete THEN
       SELF.VCRDelete{PROP:VALUE}=DeleteRecord
    END

    SELF.VCRRequest  = pVCRRequest
    IF SELF.VCRRequest THEN
       SELF.VCRRequest{PROP:USE}=SELF.Window.Request
       DISPLAY(SELF.VCRRequest)
    END
    SELF.VCRPrevRequest = SELF.Window.Request
    
FormVCRClass.SetVCRControls              PROCEDURE(SIGNED pVCRTop,SIGNED pVCRPageUp,SIGNED pVCRUp,SIGNED pVCRDown,SIGNED pVCRPageDown,SIGNED pVCRBottom,SIGNED pVCRNewRecord=0)
 CODE
    SELF.VCRTop      = pVCRTop
    SELF.VCRUp       = pVCRUp
    SELF.VCRPageUp   = pVCRPageUp
    SELF.VCRPageDown = pVCRPageDown
    SELF.VCRDown     = pVCRDown
    SELF.VCRBottom   = pVCRBottom
    IF pVCRNewRecord THEN
       SELF.VCRNewRecord = pVCRNewRecord
    END

FormVCRClass.AddLocator PROCEDURE(LocatorClass L)
  CODE
    SELF.Sort.Locator &= L
    PUT(SELF.Sort)

FormVCRClass.TakeLocate        PROCEDURE
 CODE

FormVCRClass.UpdateButtons     PROCEDURE
 CODE
    IF SELF.OnFirstRecord OR SELF.Window.Request = InsertRecord THEN
       DISABLE(SELF.VCRUp)
       DISABLE(SELF.VCRPageUp)
       DISABLE(SELF.VCRTop)
    ELSE
       ENABLE(SELF.VCRUp)
       ENABLE(SELF.VCRPageUp)
       ENABLE(SELF.VCRTop)
    END
    IF SELF.OnLastRecord OR SELF.Window.Request = InsertRecord THEN
       DISABLE(SELF.VCRDown)
       DISABLE(SELF.VCRPageDown)
       DISABLE(SELF.VCRBottom)
    ELSE
       ENABLE(SELF.VCRDown)
       ENABLE(SELF.VCRPageDown)
       ENABLE(SELF.VCRBottom)
    END
    IF SELF.VCRNewRecord THEN
       IF SELF.VCRRequest THEN
          HIDE(SELF.VCRRequest)
       END
    END
    IF NOT (SELF.Window.Request = InsertRecord)  AND SELF.NoRecords THEN
       IF SELF.Window.OkControl THEN
          DISABLE(SELF.Window.OkControl)
       END
    ELSE
       IF SELF.Window.OkControl THEN
          ENABLE(SELF.Window.OkControl)
       END
    END

FormVCRClass.TakeAcceptedLocator PROCEDURE
  CODE
       IF ~SELF.Sort.Locator &= NULL AND ACCEPTED() = SELF.Sort.Locator.Control
         IF SELF.Window.Request <> InsertRecord THEN
            IF SELF.Sort.Locator.TakeAccepted()
         IF SELF.Sort.MainKey &= NULL
            SELF.Reset(1)
         ELSE
            SELF.Reset(SELF.GetFreeElementPosition())
         END
               SELF.ViewPosition=''

               SELF.ItemsToFill = 1
               SELF.Fetch(FillForward)

               SELF.Sort.Locator.Reset
               SELF.UpdateWindow
               SELF.Window.Reset
            ELSE
               IF SELF.NoRecords THEN
                  SELF.TakeScroll(Event:ScrollTop)
               END
            END
         ELSE
            CHANGE(SELF.Sort.Locator.Control,'')
         END
       END

FormVCRClass.GetAction                    PROCEDURE()
 CODE
    RETURN SELF.Window.Request

FormVCRClass.TakeEvent         PROCEDURE
VSP BYTE,AUTO
 CODE
    IF EVENT()=EVENT:Accepted THEN
       CASE ACCEPTED()
       OF 0
       OF SELF.VCRTop
          IF SELF.Window.Request = ChangeRecord AND SELF.MSAccessMode THEN
             IF SELF.Window.OkControl THEN
                SELF.MoveDirection = Event:ScrollTop
                POST(Event:Accepted,SELF.Window.OkControl)
             END
          ELSE
             SELF.TakeScroll(Event:ScrollTop)
          END
       OF SELF.VCRPageUp
          IF SELF.Window.Request = ChangeRecord AND SELF.MSAccessMode THEN
             IF SELF.Window.OkControl THEN
                SELF.MoveDirection = Event:PageUp
                POST(Event:Accepted,SELF.Window.OkControl)
             END
          ELSE
             SELF.TakeScroll(Event:PageUp)
          END
       OF SELF.VCRUp
          IF SELF.Window.Request = ChangeRecord AND SELF.MSAccessMode THEN
             IF SELF.Window.OkControl THEN
                SELF.MoveDirection = Event:ScrollUp
                POST(Event:Accepted,SELF.Window.OkControl)
             END
          ELSE
             SELF.TakeScroll(Event:ScrollUp)
          END
       OF SELF.VCRDown
          IF SELF.Window.Request = ChangeRecord AND SELF.MSAccessMode THEN
             IF SELF.Window.OkControl THEN
                SELF.MoveDirection = Event:ScrollDown
                POST(Event:Accepted,SELF.Window.OkControl)
             END
          ELSE
             SELF.TakeScroll(Event:ScrollDown)
          END
       OF SELF.VCRPageDown
          IF SELF.Window.Request = ChangeRecord AND SELF.MSAccessMode THEN
             IF SELF.Window.OkControl THEN
                SELF.MoveDirection = Event:PageDown
                POST(Event:Accepted,SELF.Window.OkControl)
             END
          ELSE
             SELF.TakeScroll(Event:PageDown)
          END
       OF SELF.VCRBottom
          IF SELF.Window.Request = ChangeRecord AND SELF.MSAccessMode THEN
             IF SELF.Window.OkControl THEN
                SELF.MoveDirection = Event:ScrollBottom
                POST(Event:Accepted,SELF.Window.OkControl)
             END
          ELSE
             SELF.TakeScroll(Event:ScrollBottom)
          END
       OF SELF.VCRNewRecord
       OF SELF.VCRInsert
          IF SELF.VCRInsert THEN
             SELF.Window.Request = InsertRecord
             POST(Event:Accepted,SELF.VCRRequest)
          END
       OF SELF.VCRChange
          IF SELF.VCRChange THEN
             SELF.Window.Request = ChangeRecord
             POST(Event:Accepted,SELF.VCRRequest)
          END
       OF SELF.VCRDelete
          IF SELF.VCRDelete THEN
             SELF.Window.Request = DeleteRecord
             POST(Event:Accepted,SELF.VCRRequest)
          END
       OF SELF.VCRView
          IF SELF.VCRView THEN
             SELF.Window.Request = ViewRecord
             POST(Event:Accepted,SELF.VCRRequest)
          END
       OF SELF.VCRRequest
          IF SELF.GetActionAllowed(EVENT:Accepted,SELF.Window.Request) THEN
             CHANGE(SELF.VCRRequest,SELF.Window.Request)
             SELF.Window.OriginalRequest = SELF.Window.Request
             SELF.TakeRequestChanged(SELF.VCRPrevRequest,SELF.Window.Request)
             SELF.VCRPrevRequest = SELF.Window.Request
          ELSE
             IF SELF.NoRecords THEN
                SELF.NoRecords = RECORDS(SELF.View)
                IF NOT SELF.GetActionAllowed(EVENT:Accepted,SELF.Window.Request) THEN
                   SELF.Window.Request = SELF.VCRPrevRequest
                   CHANGE(SELF.VCRRequest,SELF.Window.Request)
                   SELF.UpdateWindow
                ELSE
                   CHANGE(SELF.VCRRequest,SELF.Window.Request)
                   SELF.Window.OriginalRequest = SELF.Window.Request
                   SELF.TakeRequestChanged(SELF.VCRPrevRequest,SELF.Window.Request)
                   SELF.VCRPrevRequest = SELF.Window.Request
                END
             END
          END
       OF SELF.Window.OkControl
       OROF SELF.Window.SaveControl
           SELF.ViewPosition=POSITION(SELF.View)
           SELF.SaveRequired = True
           IF SELF.OnFirstRecord THEN
              SELF.MoveDirection = Event:ScrollDown
           END
       ELSE
          IF NOT 0{PROP:AcceptAll} THEN
             SELF.TakeAcceptedLocator()
          END
       END
    ELSE
       IF FIELD()=SELF.VCRGroup AND SELF.VCRGroup THEN
          CASE EVENT()
          OF EVENT:ScrollUp
          OROF EVENT:ScrollDown
          OROF EVENT:PageUp
          OROF EVENT:PageDown
          OROF EVENT:ScrollTop
          OROF EVENT:ScrollBottom
               SELF.TakeScroll
          END
       END
    END

FormVCRClass.TakeScroll PROCEDURE(SIGNED E)
  CODE
    IF ~E
      E = EVENT()
    END
    CASE E
    OF Event:ScrollUp OROF Event:ScrollDown
      SELF.ScrollOne(E)
    OF Event:PageUp OROF Event:PageDown
      SELF.ScrollPage(E)
    OF Event:ScrollTop OROF Event:ScrollBottom
      SELF.ScrollEnd(E) 
    END
    SELF.Window.Reset()
    SELF.UpdateWindow()

FormVCRClass.SetAlerts                    PROCEDURE
  CODE

FormVCRClass.AddToolbarTarget PROCEDURE(ToolbarClass T)
  CODE
    SELF.Toolbar &= T
    SELF.ToolbarItem &= NEW ToolbarFormVCRClass
    SELF.ToolbarItem.FormVCR &= SELF
    T.AddTarget(SELF.ToolbarItem,SELF.VCRGroup)
    SELF.UpdateToolbarButtons

FormVCRClass.UpdateToolbarButtons PROCEDURE
  CODE
    IF SELF.VCRNewRecord THEN
       SELF.ToolbarItem.InsertButton = SELF.VCRNewRecord
       SELF.ToolbarItem.DeleteButton = 0
       SELF.ToolbarItem.ChangeButton = 0
       SELF.ToolbarItem.SelectButton = 0
    ELSE
       IF SELF.VCRInsert
         SELF.ToolbarItem.InsertButton = SELF.VCRInsert
       END
       IF SELF.VCRDelete
         SELF.ToolbarItem.DeleteButton = SELF.VCRDelete
       END
       IF SELF.VCRChange
         SELF.ToolbarItem.ChangeButton = SELF.VCRChange
       END
       IF SELF.VCRView
         SELF.ToolbarItem.SelectButton = SELF.VCRView
       END
    END

    SELF.Toolbar.SetTarget(SELF.VCRGroup)

FormVCRClass.UpdateResets PROCEDURE
  CODE
    SELF.Sort.Resets.AssignRightToLeft

FormVCRClass.Next PROCEDURE
Res BYTE,AUTO
  CODE
    Res = PARENT.Next()
    CASE Res
    OF Level:Notify
    OF Level:Fatal
    END
    RETURN Res

FormVCRClass.Previous  PROCEDURE
Res BYTE,AUTO
  CODE
    Res = PARENT.Previous()
    CASE Res
    OF Level:Notify
    OF Level:Fatal
    END
    RETURN Res

FormVCRClass.SetRecord         PROCEDURE()
 CODE

FormVCRClass.CheckBorders      PROCEDURE()
SkipFirst BYTE(0)
LastRecordPosition  STRING(1024)
Direction BYTE
LIndex    BYTE
 CODE
     IF SELF.QuickScan THEN
        SELF.Primary.SetQuickScan(1)
     END
     IF SELF.NoRecords THEN
        SET(SELF.View,0)
        NEXT(SELF.View)
        IF NOT ERRORCODE() THEN
           SELF.NoRecords = False
        ELSE
           SELF.NoRecords = True
        END
     END
     SELF.OnFirstRecord = True
     SELF.OnLastRecord  = True
     SELF.ViewPosition=POSITION(SELF.View)
     IF NOT SELF.ViewPosition THEN
        SELF.NoRecords     = True
        SELF.OnFirstRecord = True
        SELF.OnLastRecord  = True
        RETURN
     END
     !Saving the view files buffer
     SELF.SaveBuffers()
     RESET(SELF.View,SELF.ViewPosition)
     SkipFirst = True
     LastRecordPosition = SELF.ViewPosition
     LOOP LIndex=1 to 2
          LOOP
              Direction = CHOOSE(LIndex=1,FillForward,FillBackward)
              CASE CHOOSE(Direction = FillForward,SELF.Next(),SELF.Previous())
              OF Level:Notify
                 IF Direction = FillForward THEN
                    SELF.OnLastRecord =True
                 ELSE
                    SELF.OnFirstRecord=True
                    IF SELF.OnLastRecord THEN
                       IF SkipFirst THEN
                          SELF.NoRecords = True
                       END
                    END
                 END
                 BREAK
              OF Level:Fatal
                 SELF.OnFirstRecord=True
                 SELF.OnLastRecord =True
                 SELF.NoRecords    =True
                 RETURN
              END
              IF SkipFirst
                 SkipFirst = FALSE
                 CYCLE
              END
              IF Direction = FillForward THEN
                 SELF.OnLastRecord =False
              ELSE
                 SELF.OnFirstRecord=False
              END
              BREAK
          END
          RESET(SELF.View,LastRecordPosition)
          SkipFirst = True
     END
     IF SELF.Next() <> Level:Fatal THEN
     END
     !Restoring the view files buffers
     SELF.RestoreBuffers()
     IF SELF.QuickScan
        SELF.Primary.SetQuickScan(0)
     END
                 
FormVCRClass.Fetch             PROCEDURE(BYTE Direction)
SkipFirst BYTE(0)
LastRecordPosition  STRING(1024)
  CODE
  LastRecordPosition=''
  IF SELF.ItemsToFill > 0 THEN
     IF SELF.QuickScan THEN
        SELF.Primary.SetQuickScan(1)
     END
     IF SELF.ViewPosition
        RESET(SELF.View,SELF.ViewPosition)
        SkipFirst = True
     ELSE
        SELF.ViewPosition=POSITION(SELF.View)
     END
     LastRecordPosition=SELF.ViewPosition
     LOOP WHILE SELF.ItemsToFill
       CASE CHOOSE(Direction = FillForward,SELF.Next(),SELF.Previous())
       OF Level:Notify
          IF LastRecordPosition THEN
             RESET(SELF.View,LastRecordPosition)
          ELSE
             RESET(SELF.View,SELF.ViewPosition)
          END
          IF SELF.Next() <> Level:Fatal THEN
          END
          SELF.SetRecord
          BREAK
       OF Level:Fatal
          RETURN
       END
       LastRecordPosition=POSITION(SELF.View)
       IF SkipFirst
          SkipFirst = FALSE
          IF POSITION(SELF.View) = SELF.ViewPosition
             CYCLE
          END
        END
        SELF.SetRecord
        SELF.ViewPosition=POSITION(SELF.View)
        SELF.ItemsToFill -= 1
     END
     IF SELF.QuickScan
        SELF.Primary.SetQuickScan(0)
     END
     SELF.SaveRequired = True
  END

FormVCRClass.TakeNextRecord PROCEDURE()
  CODE
    IF SELF.Window.Request = InsertRecord THEN
       RETURN
    END
    CASE SELF.MoveDirection
    OF   EVENT:ScrollUp
    OROF EVENT:ScrollTop
    OROF EVENT:PageUp
         IF NOT SELF.OnFirstRecord THEN
            SELF.TakeScroll(SELF.MoveDirection)
            !This is seted here because the caller of this method is supposed to refres the buffer
            SELF.SaveRequired = False
         ELSE
            IF SELF.Window.Request <> DeleteRecord THEN
               SELF.SaveRequired = False
               SELF.ViewPosition = POSITION(SELF.View)
               SELF.UpdateWindow()
            ELSE
               SELF.Window.Request = ChangeRecord
               IF NOT SELF.OnLastRecord THEN
                  SELF.TakeScroll(Event:ScrollDown)
                  SELF.SaveRequired = False
               ELSE
                  SELF.Window.Reset()
               END
               SELF.UpdateWindow()
            END
         END
    OF   EVENT:PageDown
    OROF EVENT:ScrollDown
    OROF EVENT:ScrollBottom
         IF NOT SELF.OnLastRecord THEN
            SELF.TakeScroll(SELF.MoveDirection)
            !This is seted here because the caller of this method is supposed to refres the buffer
            SELF.SaveRequired = False
         ELSE
            IF SELF.Window.Request <> DeleteRecord THEN
               SELF.SaveRequired = False
               SELF.ViewPosition = POSITION(SELF.View)
               SELF.UpdateWindow()
            ELSE
               SELF.Window.Request = ChangeRecord
               IF NOT SELF.OnFirstRecord THEN
                  SELF.TakeScroll(Event:ScrollUp)
                  SELF.SaveRequired = False
               ELSE
                  SELF.Window.Reset()
               END
               SELF.UpdateWindow()
            END
         END
    ELSE
       MESSAGE('Direction not supported ('&SELF.MoveDirection&')')
       SELF.MoveDirection = EVENT:PageDown
       SELF.TakeNextRecord()
    END

FormVCRClass.ScrollOne PROCEDURE(SIGNED Ev)
  CODE
    SELF.CurrentEvent = Ev
    SELF.ItemsToFill  = 1
    SELF.Fetch(CHOOSE(Ev = EVENT:ScrollUp,FillBackward,FillForward))

FormVCRClass.ScrollPage PROCEDURE(SIGNED Ev)
LI SIGNED,AUTO
  CODE
     SELF.CurrentEvent = Ev
     SELF.ItemsToFill  = SELF.VCRPageSize
     SELF.Fetch(CHOOSE(Ev = EVENT:PageUp,FillBackward,FillForward))
     ! Fill with next read(s)

FormVCRClass.ScrollEnd PROCEDURE(SIGNED Ev)
  CODE
     IF Ev = Event:ScrollTop THEN
        SELF.OnFirstRecord= True
     ELSE
        SELF.OnLastRecord = True
     END
     SELF.CurrentEvent = Ev
     SELF.ItemsToFill  = 1
     SELF.ViewPosition=''
     SELF.Reset
     SELF.Fetch(CHOOSE(Ev = Event:ScrollTop,FillForward,FillBackward))
     ! Fill with next read(s)

FormVCRClass.UpdateWindow PROCEDURE
  CODE
    IF ~(SELF.Sort.Locator &= NULL)
      SELF.Sort.Locator.UpdateWindow
    END
    SELF.CheckBorders
    SELF.UpdateButtons
    IF ~SELF.Toolbar &= NULL
      SELF.Toolbar.DisplayButtons
    END
    SELF.UpdateViewRecord()

FormVCRClass.InitSort PROCEDURE(BYTE B)
RVal BYTE(0)
  CODE
    IF SELF.SetSort(B)
      IF ~SELF.Sort.Locator &= NULL
        SELF.Sort.Locator.Set
      END
      Rval = 1
    END
    RETURN RVal

FormVCRClass.SetSort PROCEDURE(BYTE B,BYTE Force)
RVal BYTE(0)
  CODE
    RVal = SELF.InitSort(B)
    IF SELF.ApplyRange() OR Rval OR Force THEN
       SELF.ApplyOrder
       SELF.ApplyFilter
       RESET(SELF.View,SELF.ViewPosition)
       Rval = 1
    END
    RETURN Rval

FormVCRClass.ResetSort PROCEDURE(BYTE Force)
RVal BYTE(0)
  CODE
    RVal = SELF.SetSort(POINTER(SELF.Sort),Force)
    IF RVal OR Force THEN
       SELF.CheckBorders
    END
    RETURN Rval

FormVCRClass.TakeRequestChanged           PROCEDURE(BYTE pPreviousRequest,BYTE pActualRequest)
I BYTE(0)
  CODE
     IF pPreviousRequest <> pActualRequest THEN
        IF pPreviousRequest = InsertRecord THEN
           IF SELF.Primary.Me.CancelAutoInc() THEN
              RETURN
           ELSE
              IF SELF.ViewPosition THEN
                 RESET(SELF.View,SELF.ViewPosition)
                 I = SELF.Previous()
              END
              SELF.CheckBorders
              SELECT(SELF.Window.FirstField)
              SELF.SaveRequired=True
              SELF.Window.Reset()
              RETURN
           END
        END
        IF pActualRequest = InsertRecord THEN
           IF SELF.PrimeRecord() THEN
              SELF.Window.Response = RequestCancelled
              SELF.Window.Reset()
              RETURN
           ELSE
              SELF.Window.PrimeFields
              SELF.Window.Response = RequestCancelled
           END
           SELF.ViewPosition=POSITION(SELF.View)
           SELF.SaveRequired=True
           SELECT(SELF.Window.FirstField)
           SELF.Window.Reset()
           RETURN
        END
        SELF.Window.Reset()

     END

FormVCRClass.UpdateViewRecord    PROCEDURE
Pos       STRING(1024),AUTO
RC        UNSIGNED,AUTO
  CODE
     IF SELF.ViewPosition
      WATCH(SELF.View)
      REGET(SELF.View,SELF.ViewPosition)
      RC = ERRORCODE()
      IF  RC = NoDriverSupport
        SELF.ViewPosition = POSITION (SELF.View)
        RESET(SELF.View,SELF.ViewPosition)
        WATCH(SELF.View)
        NEXT(SELF.View)
        RC = ERRORCODE()
        RESET(SELF.View,SELF.ViewPosition)
      END
     END

FormVCRClass.FormVCRWindowComponent.Kill         PROCEDURE
  CODE
  SELF.Kill

FormVCRClass.FormVCRWindowComponent.TakeEvent    PROCEDURE
  CODE
  SELF.TakeEvent
  RETURN Level:Benign

FormVCRClass.FormVCRWindowComponent.SetAlerts    PROCEDURE
  CODE
  SELF.SetAlerts
  SELF.ScrollEnd(Event:ScrollTop)
  SELF.UpdateWindow()
  IF SELF.Window.Request =InsertRecord THEN
     IF SELF.GetActionAllowed(Event:Accepted,InsertRecord)
        SELF.TakeRequestChanged(0,InsertRecord)
     END
  ELSE
     IF SELF.NoRecords THEN
        IF SELF.InsertWhenNoRecords THEN
           IF SELF.GetActionAllowed(Event:Accepted,InsertRecord)
              SELF.Window.Request =InsertRecord
              SELF.TakeRequestChanged(0,InsertRecord)
              SELF.VCRPrevRequest = SELF.Window.Request
           END
        END
     END
  END

FormVCRClass.FormVCRWindowComponent.Reset        PROCEDURE(BYTE Force)
  CODE
  SELF.ResetSort(False)

FormVCRClass.FormVCRWindowComponent.PrimaryBufferSaveRequired PROCEDURE()
  CODE
     RETURN SELF.SaveRequired

FormVCRClass.FormVCRWindowComponent.PrimaryBufferSaved   PROCEDURE()
  CODE
     IF SELF.SaveRequired=True THEN
        SELF.SaveRequired=False
        SELF.ViewPosition=POSITION(SELF.View)
        SELF.UpdateWindow()
     END

FormVCRClass.FormVCRWindowComponent.PrimaryBufferRestoreRequired PROCEDURE()
  CODE
     RETURN SELF.RestoreRequired

FormVCRClass.FormVCRWindowComponent.PrimaryBufferRestored   PROCEDURE()
  CODE
     IF SELF.RestoreRequired=True THEN
        SELF.RestoreRequired=False
     END

FormVCRClass.FormVCRWindowComponent.ResetRequired PROCEDURE
  CODE
  RETURN SELF.ApplyRange()

FormVCRClass.FormVCRWindowComponent.Update       PROCEDURE
  CODE

FormVCRClass.FormVCRWindowComponent.UpdateWindow PROCEDURE
  CODE
     SELF.UpdateWindow
