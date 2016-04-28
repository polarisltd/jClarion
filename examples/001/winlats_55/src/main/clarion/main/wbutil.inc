!ABCIncludeFile(WEB)

  OMIT('_EndOfInclude_', _WebUtilsIncluded_)
_WebUtilsIncluded_  EQUATE(1)

  INCLUDE('ABUTIL.INC'),ONCE
  INCLUDE('WBBROKER.INC'),ONCE
  INCLUDE('WBSERVER.INC'),ONCE

!This class is designed to be a 'plug-in' replacement for the standard ABC INIClass


  ITEMIZE(1),PRE(Persist)
Client      EQUATE
Server      EQUATE
  END

WbCookieClass         CLASS(INIClass),TYPE,MODULE('WBUTIL.CLW'),LINK('WBUTIL', _WebAbcLinkMode_),DLL(_WebAbcDllMode_)
Broker                &WbBrokerClass,PRIVATE
Cache                 &CookieCache,PRIVATE
Persistencies         &PersistencyList,PRIVATE
WebServer             &WbServerClass,PRIVATE

SyncCache             PROCEDURE(ASTRING Sector, ASTRING Name, BYTE AutoAdd = False),BYTE,PROC,PRIVATE
WebActive             PROCEDURE(),BYTE,PRIVATE

Construct             PROCEDURE
Destruct              PROCEDURE,VIRTUAL

Fetch                 PROCEDURE(STRING Sector, STRING Name, STRING Default, STRING Filename),STRING,VIRTUAL,PROTECTED
Update                PROCEDURE(STRING Sector, STRING Name, STRING Value, STRING Filename),VIRTUAL,PROTECTED

FetchCookie           PROCEDURE(ASTRING Sector, ASTRING Name),ASTRING
GetCookieName         PROCEDURE(ASTRING Sector, ASTRING Name),ASTRING
GetPersistency        PROCEDURE(ASTRING Sector, ASTRING Name),BYTE
SetWeb                PROCEDURE(WbBrokerClass Broker, WbServerClass WebServer)
SetPersistency        PROCEDURE(ASTRING Sector, ASTRING Name, BYTE Persistency)
TryFetchCookie        PROCEDURE(ASTRING Sector, ASTRING Name),ASTRING
TryUpdateCookie       PROCEDURE(ASTRING Sector, ASTRING Name, ASTRING Value)
UpdateCookie          PROCEDURE(ASTRING Sector, ASTRING Name, ASTRING Value)
FreeCache             PROCEDURE(BYTE Force = False)
                    END

  _EndOfInclude_

