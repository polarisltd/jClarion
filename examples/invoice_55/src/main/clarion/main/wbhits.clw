  MEMBER

  INCLUDE('WBHITS.INC'),ONCE
  INCLUDE('ABUTIL.INC'),ONCE

  MAP
  END


LinksList   QUEUE,TYPE
Tag           ASTRING
EventID       LONG
ControlID     LONG
            END

HitCache    QUEUE,TYPE
Tag           ASTRING
Count         LONG
            END


LockSection   ASTRING('__Dont_Touch_Me__')
Locked        ASTRING('Locked')
LockPending   ASTRING('LockPending')
LockAttempts  LONG(100)


WbHitFileINIClass.HitFile.Open PROCEDURE(ASTRING FN)

  CODE
  SELF.Init(FN)


WbHitFileINIClass.HitFile.Close PROCEDURE

  CODE
  SELF.Kill


WbHitFileINIClass.HitFile.TakeTag PROCEDURE(ASTRING Tag, LONG Count)

  CODE
? ASSERT(Tag <> '', 'Attempting to update an invalid Tag!')
  IF SELF.Lock() = Level:Benign
    SELF.Update('Hit Log', Tag, SELF.HitFile.GetCount(Tag) + Count)
    IF SELF.Unlock() <> Level:Benign
?     ASSERT(False, 'Unable to unlock!')
    END
  ELSE
?   ASSERT(False,'Unable to obtain lock!')
  END


WbHitFileINIClass.HitFile.GetCount PROCEDURE(ASTRING Tag)

  CODE
  RETURN SELF.TryFetch('Hit Log', Tag)


WbHitFileINIClass.Lock PROCEDURE

  CODE
  IF ~SELF.lLock(LockPending) THEN RETURN Level:Notify.
  IF ~SELF.lLock(Locked)
    SELF.Unlock
    RETURN Level:Notify
  END
  RETURN Level:Benign


WbHitFileINIClass.lLock PROCEDURE(ASTRING Itm)

Lc  LONG(0)

  CODE
  LOOP WHILE SELF.TryFetch(LockSection, Itm) = True
    Lc += 1
    IF Lc = LockAttempts THEN RETURN False.
  END
  SELF.Update(LockSection, Itm, True)
  RETURN CHOOSE(SELF.TryFetch(LockSection, Itm) = True)


WbHitFileINIClass.lUnlock PROCEDURE(ASTRING Itm)

  CODE
  SELF.Update(LockSection, Itm, False)


WbHitFileINIClass.Unlock PROCEDURE

  CODE
  SELF.lUnlock(LockPending)
  SELF.lUnlock(Locked)
  RETURN Level:Benign





WbHitManagerClass.Construct PROCEDURE

  CODE
  SELF.Cache &= NEW HitCache


WbHitManagerClass.Destruct PROCEDURE

  CODE
  DISPOSE(SELF.Cache)


WbHitManagerClass.Init PROCEDURE(HitFile HF, LONG UpdateThreshold, <ASTRING FN>)

FName ASTRING,AUTO
i     LONG,AUTO

  CODE
  SELF.HF &= HF
  SELF.Threshold = UpdateThreshold
  IF OMITTED(4)
    FName = COMMAND('0')
    i = INSTRING('.', FName, 1, 1)
    IF ~i THEN i = LEN(FN) + 1.
    FName = FName[1 : i - 1] & '.LOG'
  ELSE
    FName = FN
  END
  SELF.HF.Open(FName)


WbHitManagerClass.Kill PROCEDURE

  CODE
  SELF.WriteHits
  SELF.HF.Close


WbHitManagerClass.GetTag PROCEDURE(ASTRING Tag)

  CODE
  SELF.Cache.Tag = Tag
  GET(SELF.Cache, SELF.Cache.Tag)
  RETURN CHOOSE(ERRORCODE() = 0, True, False)


WbHitManagerClass.GetCount PROCEDURE(ASTRING Tag)

RVal  LONG,AUTO

  CODE
  RVal = SELF.HF.GetCount(Tag)
  SELF.Cache.Tag = Tag
  GET(SELF.Cache, SELF.Cache.Tag)
  IF ~ERRORCODE() THEN RVal += SELF.Cache.Count.
  RETURN RVal


WbHitManagerClass.Take PROCEDURE(ASTRING Tag)

  CODE
  IF Tag <> ''
    IF SELF.GetTag(Tag)
      SELF.Cache.Count += 1
      PUT(SELF.Cache, SELF.Cache.Tag)
?     ASSERT(~ERRORCODE())
    ELSE
      SELF.Cache.Tag = Tag
      SELF.Cache.Count = 1
      ADD(SELF.Cache, SELF.Cache.Tag)
?     ASSERT(~ERRORCODE())
    END
    SELF.WriteCache(Tag)
  END


WbHitManagerClass.WriteCache PROCEDURE(ASTRING Tag, BYTE Force)

  CODE
  IF SELF.GetTag(Tag) AND (Force OR SELF.Cache.Count >= SELF.Threshold)
    SELF.WriteHits(Tag)
  END


WbHitManagerClass.WriteHits PROCEDURE(<ASTRING Tag>)

T ASTRING,AUTO
i LONG,AUTO

  CODE
  IF ~OMITTED(2)
    IF SELF.GetTag(Tag)
      T = Tag
      DO DoIt
    END
  ELSE
    LOOP i = RECORDS(SELF.Cache) TO 1 BY -1
      GET(SELF.Cache, i)
?     ASSERT(~ERRORCODE())
      T = SELF.Cache.Tag
      DO DoIt
    END
  END

DoIt ROUTINE
  IF SELF.Cache.Count > 0 THEN SELF.HF.TakeTag(T, SELF.Cache.Count).
  DELETE(SELF.Cache)
? ASSERT(~ERRORCODE())










WbHitCounterClass.Construct PROCEDURE

  CODE
  SELF.Links &= NEW LinksList
  SELF.MyName = ''


WbHitCounterClass.Destruct PROCEDURE

  CODE
  DISPOSE(SELF.Links)


WbHitCounterClass.Init PROCEDURE(WbHitManagerClass HM, <ASTRING InstanceName>)

  CODE
  SELF.HitManager &= HM
  IF ~OMITTED(3) THEN SELF.MyName = InstanceName.


WbHitCounterClass.TryAddLink PROCEDURE(ASTRING Tag, LONG EventID, LONG ControlID)

  CODE
  SELF.Links.Tag = Tag
  GET(SELF.Links, SELF.Links.Tag)
  IF ~ERRORCODE() THEN RETURN Level:Notify.   !Tag already found
  SELF.Links.EventID = EventID
  SELF.Links.ControlID = ControlID
  ADD(SELF.Links, SELF.Links.Tag)
? ASSERT(~ERRORCODE())
  RETURN Level:Benign


WbHitCounterClass.AddLink PROCEDURE(ASTRING Tag, LONG EventID, LONG ControlID)

  CODE
  IF SELF.TryAddLink(Tag, EventID, ControlID) <> Level:Benign
    DELETE(SELF.Links)
?   ASSERT(~ERRORCODE())     
    ASSERT(SELF.TryAddLink(Tag, EventID, ControlID) = Level:Benign, 'Unexpected error adding link!')
  END


WbHitCounterClass.GetTag PROCEDURE(LONG EventID, LONG ControlID)

RVal  ASTRING

  CODE
  IF EventID
    SELF.Links.EventID = EventID
    SELF.Links.ControlID = ControlID
    GET(SELF.Links, SELF.Links.EventID, SELF.Links.ControlID)
    RVal = CHOOSE(ERRORCODE() = 0, SELF.Links.Tag, '')
  END
  RETURN RVal

WbHitCounterClass.GetFullTagName PROCEDURE(ASTRING Tag)

  CODE
  RETURN CHOOSE(SELF.MyName = '', Tag, SELF.MyName & ': ' & Tag)


WbHitCounterClass.Take PROCEDURE(ASTRING Tag)

  CODE
  IF Tag <> '' THEN SELF.HitManager.Take(SELF.GetFullTagName(Tag)).


WbHitCounterClass.GetCount PROCEDURE(ASTRING Tag)

  CODE
  RETURN SELF.HitManager.GetCount(SELF.GetFullTagName(Tag))


WbHitCounterClass.WindowComponent.Kill PROCEDURE

  CODE


WbHitCounterClass.WindowComponent.Reset PROCEDURE(BYTE Force)

  CODE


WbHitCounterClass.WindowComponent.ResetRequired PROCEDURE

  CODE
  RETURN False


WbHitCounterClass.WindowComponent.SetAlerts PROCEDURE

  CODE


WbHitCounterClass.WindowComponent.TakeEvent PROCEDURE

  CODE
  SELF.Take(SELF.GetTag(EVENT(), FIELD()))
  RETURN Level:Benign


WbHitCounterClass.WindowComponent.Update PROCEDURE

  CODE


WbHitCounterClass.WindowComponent.UpdateWindow PROCEDURE

  CODE
