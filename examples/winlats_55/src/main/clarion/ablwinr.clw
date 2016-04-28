   MEMBER
COMPILE('__Test__',_WebRunDllMode_)
ERROR: WebRunDllMode set incorrectly
__Test__
   MAP
   .

   INCLUDE('ABLPROPR.INC'),ONCE
   INCLUDE('ABLWINR.INC'),ONCE
   INCLUDE('WBSTD.INC'),ONCE

EventMapper             CLASS
Construct                 PROCEDURE
Map                       PROCEDURE(ASTRING name),SIGNED

TieH                      SIGNED
                        END

Event                   CLASS(Element)
EventNo                   UNSIGNED
Feq                       SIGNED
                        END

!!========================= Helper procedures... ===========================

EventMapper.Construct   PROCEDURE
TieH                      SIGNED(0)
  CODE
    TieH = TIE('',,0)
    TIE('Accepted',TieH,EVENT:Accepted)
    TIE('NewSelection',TieH,EVENT:NewSelection)
    TIE('ScrollUp',TieH,EVENT:ScrollUp)
    TIE('ScrollDown',TieH,EVENT:ScrollDown)
    TIE('PageUp',TieH,EVENT:PageUp)
    TIE('PageDown',TieH,EVENT:PageDown)
    TIE('ScrollTop',TieH,EVENT:ScrollTop)
    TIE('ScrollBottom',TieH,EVENT:ScrollBottom)
    TIE('Locate',TieH,EVENT:Locate)
    TIE('MouseDown',TieH,EVENT:MouseDown)
    TIE('MouseUp',TieH,EVENT:MouseUp)
    TIE('MouseIn',TieH,EVENT:MouseIn)
    TIE('MouseOut',TieH,EVENT:MouseOut)
    TIE('MouseMove',TieH,EVENT:MouseMove)
    TIE('VBXevent',TieH,EVENT:VBXevent)
    TIE('AlertKey',TieH,EVENT:AlertKey)
    TIE('PreAlertKey',TieH,EVENT:PreAlertKey)
    TIE('Dragging',TieH,EVENT:Dragging)
    TIE('Drag',TieH,EVENT:Drag)
    TIE('Drop',TieH,EVENT:Drop)
    TIE('ScrollDrag',TieH,EVENT:ScrollDrag)
    TIE('TabChanging',TieH,EVENT:TabChanging)
    TIE('Expanding',TieH,EVENT:Expanding)
    TIE('Contracting',TieH,EVENT:Contracting)
    TIE('Expanded',TieH,EVENT:Expanded)
    TIE('Contracted',TieH,EVENT:Contracted)
    TIE('Rejected',TieH,EVENT:Rejected)
    TIE('DroppingDown',TieH,EVENT:DroppingDown)
    TIE('DroppedDown',TieH,EVENT:DroppedDown)
    TIE('ScrollTrack',TieH,EVENT:ScrollTrack)
    TIE('ColumnResize',TieH,EVENT:ColumnResize)
    TIE('Selecting',TieH,EVENT:Selecting)
    TIE('Selected',TieH,EVENT:Selected)
    TIE('CloseWindow',TieH,EVENT:CloseWindow)
    TIE('CloseDown',TieH,EVENT:CloseDown)
    TIE('OpenWindow',TieH,EVENT:OpenWindow)
    TIE('OpenFailed',TieH,EVENT:OpenFailed)
    TIE('LoseFocus',TieH,EVENT:LoseFocus)
    TIE('GainFocus',TieH,EVENT:GainFocus)
    TIE('Suspend',TieH,EVENT:Suspend)
    TIE('Resume',TieH,EVENT:Resume)
    TIE('Timer',TieH,EVENT:Timer)
    TIE('DDErequest',TieH,EVENT:DDErequest)
    TIE('DDEadvise',TieH,EVENT:DDEadvise)
    TIE('DDEdata',TieH,EVENT:DDEdata)
    TIE('DDEcommand',TieH,EVENT:DDEcommand)
    TIE('DDEexecute',TieH,EVENT:DDEexecute)
    TIE('DDEpoke',TieH,EVENT:DDEpoke)
    TIE('DDEclosed',TieH,EVENT:DDEclosed)
    TIE('Move',TieH,EVENT:Move)
    TIE('Size',TieH,EVENT:Size)
    TIE('Restore',TieH,EVENT:Restore)
    TIE('Maximize',TieH,EVENT:Maximize)
    TIE('Iconize',TieH,EVENT:Iconize)
    TIE('Completed',TieH,EVENT:Completed)
    TIE('Moved',TieH,EVENT:Moved)
    TIE('Sized',TieH,EVENT:Sized)
    TIE('Restored',TieH,EVENT:Restored)
    TIE('Maximized',TieH,EVENT:Maximized)
    TIE('Iconized',TieH,EVENT:Iconized)
    TIE('Docked',TieH,EVENT:Docked)
    TIE('Undocked',TieH,EVENT:Undocked)
    SELF.TieH = TieH

EventMapper.Map                 PROCEDURE(ASTRING name)
  CODE
    RETURN TIED(name, SELF.TieH)


!!========================= Helper procedures... ===========================

WbWindowClass.Construct            PROCEDURE
  CODE
  SELF.Delayed &= NEW Array

WbWindowClass.Destruct             PROCEDURE
  CODE
  DISPOSE(SELF.Delayed)

WbWindowClass.CreateDefault             PROCEDURE(SIGNED Feq)
Properties              &WbControlHtmlProperties,auto
  CODE
  Properties &= NEW WbControlHtmlProperties
  Properties.Init(Feq, FEQ:Unknown)
  SELF.AddOwnedControl(Properties.IControlToHtml)
  RETURN properties.IControlToHtml


WbWindowClass.CreateDefaultWindow       PROCEDURE
Properties              &WbWindowHtmlProperties,auto
  CODE
  Properties &= NEW WbWindowHtmlProperties
  Properties.Init()
  SELF.AddOwnedControl(Properties.IControlToHtml)


WbWindowClass.Init                      PROCEDURE
Phase                   CSTRING('RUNTIME')
LastPhase               BOOL(True)
  CODE
  PARENT.Init
  SELF.RootId = 0
  SELF.UnknownId = FEQ:Unknown
  SELF.Builder.Init(Phase, LastPhase)


WbWindowClass.ResetFromControl          PROCEDURE(WebControlId cId)
match                   &IControlToHtml,AUTO
  CODE
  match &= SELF.MapToIControl(cid)
  IF match &= NULL
    IF (cid{PROP:type} < 0100H)
      match &= SELF.CreateDefault(CId)
    END
  END
  RETURN match

WbWindowClass.ResetFromWindow           PROCEDURE
CurFeq                  SIGNED
  CODE
    ! Add a window pseudo control...
    IF NOT SELF.GetHasControl(0)
       SELF.CreateDefaultWindow()
    END

    CurFeq = 0{PROP:nextfield}
    LOOP WHILE (CurFeq)
      SELF.ResetFromControl(CurFeq)
      CurFeq = 0{PROP:nextfield, CurFeq}
    END

    CurFeq = 04000H
    LOOP WHILE (CurFeq{PROP:type})
      SELF.ResetFromControl(CurFeq)
      CurFeq += 1
    END

WbWindowClass.TakeUnknownResponse       PROCEDURE(STRING name, STRING value)
  CODE


!!---------------------------------------------------------------------------
WbWindowClass.IWbEventProcessor.DelayedPost  PROCEDURE(UNSIGNED EventNo, SIGNED feq)
delayed                 &Event
  CODE
  delayed &= NEW Event
  delayed.EventNo = EventNo
  delayed.feq = feq
  SELF.Delayed.DoAppend(delayed)

!!---------------------------------------------------------------------------

WbWindowClass.IWebResponseProcessor.BeforeResponses      PROCEDURE(BOOL partial)
Index                   SIGNED,AUTO
  CODE
  SELF.DefaultButtonNeeded = CHOOSE(NOT Partial)
  SELF.DefaultButton = 0

  IF (NOT Partial)
    ! Unset check boxes not sent in submit string - so need to pre-clear
    LOOP Index = 1 TO RECORDS(SELF.Controls)
      GET(SELF.Controls, Index)
      SELF.Controls.Control.BeforeResponse()
    END
  END

WbWindowClass.IWebResponseProcessor.TakeResponse       PROCEDURE(STRING Name, STRING Value)
EndMain                 SIGNED,AUTO
EventPos                SIGNED,AUTO
Len                     SIGNED,AUTO
Separator               SIGNED,AUTO
ResponseType            ResetType(RESET:Value)
  CODE
    !! Format of the names is: "<MainControl>$<sub-elements>$How"
    Len = LEN(Name)
    Separator = INSTRING('$',Name,1,1)
    IF (Separator)
      IF (SUB(Name, Len-4,3)='$xy')
        !!if name attribute ends with $xy, used for an input to only get one
        !!event through instead of NAME.x and NAME.y
        IF (SUB(Name, Len-1,2)='.y')
          RETURN
        END
        ASSERT(SUB(Name, Len-1,2)='.x')
        Len -= 5
      END
      IF (SUB(Name, Len-6,7)='$Choice')
        Len -= 7
        ResponseType=RESET:Choice
      ELSIF (SUB(Name, Len-4,5)='$Bool')
        Len -= 5
        ResponseType=RESET:Bool
        ResponseType=RESET:Bool
      ELSE
        EventPos = INSTRING('$Event',Name,1,Separator)
        IF (EventPos)
          ResponseType = EventMapper.Map(Name[EventPos+6 : Len])
          Len = EventPos-1
        END
      END
      EndMain = Separator-1
    ELSE
      EndMain = Len
      Separator = EndMain
    END
    SELF.Controls.Name = lower(Name[1 : EndMain])
    GET(SELF.Controls, SELF.Controls.Name)
    IF (~ERRORCODE())
       SELF.Controls.Control.TakeResponse(Name[Separator+1:Len], Value, ResponseType, SELF.IWbEventProcessor)
    ELSE
       CASE (Name)
       OF 'SuppressDefaultButton'
         SELF.DefaultButtonNeeded = CHOOSE(NOT Value)
       ELSE
         SELF.TakeUnknownResponse(Name, Value)
       END
    END

WbWindowClass.IWebResponseProcessor.AfterResponses       PROCEDURE(BOOL partial)
Index                   SIGNED,AUTO
cur                     &Event,auto
  CODE
   IF (NOT Partial)
     ! Unset check boxes not sent in submit string - so need to pre-clear
     LOOP Index = 1 TO RECORDS(SELF.Controls)
       GET(SELF.Controls, Index)
       SELF.Controls.Control.AfterResponse()
     END
   END

   ! Now post any events that need to occur last - e.g. button presses.
   LOOP index = 0 TO SELF.Delayed.Ordinality()-1
     cur &= SELF.Delayed.castItem(index)
     IF (cur.EventNo = EVENT:Accepted) AND (cur.feq{PROP:std} = STD:close)
       POST(EVENT:CloseWindow)
     ELSE
       POST(cur.EventNo, cur.feq)
     END
   END
   SELF.Delayed.kill


