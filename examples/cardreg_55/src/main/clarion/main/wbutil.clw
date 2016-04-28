  MEMBER

  INCLUDE('WBUTIL.INC'),ONCE

  MAP
  END


CookieCache     QUEUE,TYPE      !This is used that that an Update/Fetch is valid on Persist:Clients
Sector            ASTRING       !without an intermediate page update
Name              ASTRING
Value             ASTRING
                END


PersistencyList QUEUE,TYPE
Sector            ASTRING
Name              ASTRING
Persistency       ASTRING
                END



WbCookieClass.Construct PROCEDURE

  CODE
  SELF.Cache &= New CookieCache
  SELF.Persistencies &= NEW PersistencyList
  SELF.Broker &= NULL
  SELF.WebServer &= NULL


WbCookieClass.Destruct PROCEDURE

  CODE
  DISPOSE(SELF.Persistencies)
  DISPOSE(SELF.Cache)


WbCookieClass.Fetch PROCEDURE(STRING Sector, STRING Name, STRING Default, STRING Filename)

RVal  ASTRING

  CODE
  IF SELF.WebActive()
    CASE SELF.GetPersistency(Sector, Name)
    OF Persist:Client
      RVal = CHOOSE(SELF.SyncCache(Sector, Name) = True, SELF.Cache.Value, SELF.TryFetchCookie(Sector, Name))
    OF Persist:Server
      RVal = PARENT.Fetch(Sector, Name, Default, Filename)
    ELSE
?     ASSERT(False)
    END
  ELSE
    IF SELF.GetPersistency(Sector, Name) = Persist:Server       !server persistent so get from INI
      RVal = PARENT.Fetch(Sector, Name, Default, Filename)
    ELSIF SELF.SyncCache(Sector, Name) = True                   !client persistent but value previously set
      RVal = SELF.Cache.Value
    END
  END
  IF RVal = '' THEN RVal = Default.                             !value not found but default supplied
  RETURN RVal


WbCookieClass.Update PROCEDURE(STRING Sector, STRING Name, STRING Value, STRING Filename)

  CODE
  IF SELF.GetPersistency(Sector, Name) = Persist:Client
    SELF.SyncCache(Sector, Name, True)
    SELF.Cache.Value = Value
    PUT(SELF.Cache)
?   ASSERT(~ERRORCODE())
  END
  IF SELF.WebActive() AND SELF.GetPersistency(Sector, Name) = Persist:Client
    SELF.UpdateCookie(Sector, Name, Value)
  ELSIF SELF.GetPersistency(Sector, Name) = Persist:Server
    PARENT.Update(Sector, Name, Value, Filename)
  END


WbCookieClass.GetPersistency PROCEDURE(ASTRING Sector, ASTRING Name)

  CODE
  SELF.Persistencies.Sector = Sector
  SELF.Persistencies.Name = Name
  GET(SELF.Persistencies, SELF.Persistencies.Sector, SELF.Persistencies.Name)
  RETURN CHOOSE(ERRORCODE() = 0, SELF.Persistencies.Persistency, Persist:Client)      !NOTE default is client persistency


WbCookieClass.SetPersistency PROCEDURE(ASTRING Sector, ASTRING Name, BYTE Persistency)

  CODE
  SELF.Persistencies.Sector = Sector
  SELF.Persistencies.Name = Name
  GET(SELF.Persistencies, SELF.Persistencies.Sector, SELF.Persistencies.Name)
  IF ERRORCODE()
    SELF.Persistencies.Persistency = Persistency
    ADD(SELF.Persistencies)
?   ASSERT(~ERRORCODE())
  ELSIF SELF.Persistencies.Persistency <> Persistency
    SELF.Persistencies.Persistency = Persistency
    PUT(SELF.Persistencies)
?   ASSERT(~ERRORCODE())
  END


WbCookieClass.FetchCookie PROCEDURE(ASTRING Sector, ASTRING Name)

RVal  ASTRING

  CODE
  IF SELF.WebActive()
    RVal = SELF.TryFetchCookie(Sector, Name)
  END
  ASSERT(RVal <> '')
  RETURN RVal

WbCookieClass.TryFetchCookie PROCEDURE(ASTRING Sector, ASTRING Name)

  CODE
  RETURN CHOOSE(SELF.WebActive() = True, SELF.Broker.Http.GetCookie(SELF.GetCookieName(Sector, Name)), '')


WbCookieClass.GetCookieName PROCEDURE(ASTRING Sector, ASTRING Name)

  CODE
  RETURN UPPER(CLIP(Sector) & '$' & CLIP(Name))


WbCookieClass.SetWeb PROCEDURE(WbBrokerClass Broker, WbServerClass WS)

  CODE
? ASSERT(~Broker &= NULL, 'WbCookieClass.SetWeb: Broker NULL!')
? ASSERT(~WS &= NULL, 'WbCookieClass.SetWeb: WS NULL!')
  SELF.Broker &= Broker
  SELF.WebServer &= WS


WbCookieClass.FreeCache PROCEDURE(BYTE Force)                                !Must call before WebServer.Halt

  CODE
  IF SELF.WebActive() OR Force
    FREE(SELF.Cache)
  END


WbCookieClass.UpdateCookie PROCEDURE(ASTRING Sector, ASTRING Name, ASTRING Value)

  CODE
  IF SELF.WebActive()
    SELF.TryUpdateCookie(Sector, Name, Value)
  ELSE
    ASSERT(False)
  END


WbCookieClass.TryUpdateCookie PROCEDURE(ASTRING Sector, ASTRING Name, ASTRING Value)

  CODE
  IF SELF.WebActive() AND ~SELF.Broker.Http &= NULL
    SELF.Broker.Http.SetCookie(SELF.GetCookieName(Sector, Name), Value)
  END


WbCookieClass.SyncCache PROCEDURE(ASTRING Sector, ASTRING Name, BYTE AutoAdd)

  CODE
  SELF.Cache.Sector = Sector
  SELF.Cache.Name = Name
  GET(SELF.Cache, SELF.Cache.Sector, SELF.Cache.Name)
  IF ERRORCODE()
    IF AutoAdd
      SELF.Cache.Value = ''
      ADD(SELF.Cache)                   !Relying on state preservation after failed GET
      RETURN CHOOSE(ERRORCODE() = 0)
    ELSE
      RETURN False
    END
  END
  RETURN True


WbCookieClass.WebActive PROCEDURE

  CODE
  RETURN CHOOSE(SELF.Broker &= NULL, False, SELF.WebServer.IsEnabled())

