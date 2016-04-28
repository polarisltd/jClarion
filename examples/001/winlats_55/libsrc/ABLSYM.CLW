   MEMBER
COMPILE('__Test__',_WebCoreDllMode_)
ERROR: _WebCoreDllMode_ set incorrectly
__Test__

   INCLUDE('WBSTD.INC'),ONCE
   INCLUDE('ABLPROP.INC'),ONCE
   INCLUDE('ABLSYM.INC'),ONCE
   INCLUDE('WSLPROP.INT'),ONCE
   INCLUDE('LAYVALUE.INT'),ONCE
   INCLUDE('WBBROKER.INC'),ONCE

A:IE                    ASTRING('IE')
A:MozillaVersion        ASTRING('MozillaVersion')
A:Netscape              ASTRING('Netscape')
A:Version               ASTRING('Version')

!!-----------------------------------------------------------------------

WbBrowserPropertiesClass.GetProperty         PROCEDURE(ASTRING name, unsigned idx1=0, unsigned idx2=0)
UserAgent               CSTRING(255),AUTO
IE                      SIGNED,AUTO
IEEnd                   SIGNED,AUTO
  MAP
GetMozillaVersion       PROCEDURE,*IValue
  END

  CODE
!IE5: User-Agent: Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; VNIE4 3.1.814)
!NS4.5: User-Agent: Mozilla/4.51 [en] (Win98; I)

  UserAgent = SELF.Broker.Http.GetBrowserProperty('User-Agent')
  IE=INSTRING('MSIE', UserAgent, 1, 1)

  IF (A:IE = name)
    RETURN CreateBoolValue(CHOOSE(IE<>0))
  ELSIF (A:Netscape = name)
    RETURN CreateBoolValue(CHOOSE(IE=0))
  ELSIF (A:MozillaVersion = name)
    RETURN GetMozillaVersion()
  ELSIF (A:Version = name)
    IF (IE)
      IEEnd = INSTRING(';', UserAgent, 1, IE+5)
      RETURN CreateValue(WslPropType:string, UserAgent[IE+5 : IEEnd-1])
    ELSE
      RETURN GetMozillaVersion()
    END
  END
  RETURN NULL

GetMozillaVersion       PROCEDURE
Mozilla                 SIGNED,AUTO
MozillaEnd              SIGNED,AUTO
  CODE
  Mozilla = INSTRING('Mozilla/', UserAgent, 1, 1)
  IF (Mozilla)
    MozillaEnd = INSTRING(' ', UserAgent, 1, Mozilla)
    IF (NOT MozillaEnd)
      MozillaEnd = LEN(UserAgent)+1
    END
    RETURN CreateValue(WslPropType:string, UserAgent[Mozilla+8 : MozillaEnd-1])
  END
  RETURN NULL



WbBrowserPropertiesClass.Init        PROCEDURE(WbBrokerClass Broker)
  CODE
  SELF.Broker &= Broker

