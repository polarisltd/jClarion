!ABCIncludeFile(WEB)

  OMIT('_EndOfInclude_',_ICBrokerPresent_)
_ICBrokerPresent_ EQUATE(1)

  INCLUDE('WBSINK.INC'),ONCE
  INCLUDE('WBHTTP.INC'),ONCE
  INCLUDE('WBCLIENT.INC'),ONCE
  INCLUDE('WBFILES.INC'),ONCE

WbBrokerClass          CLASS(WbDataSinkClass),MODULE('WBBROKER.CLW'),LINK('WBBROKER', _WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
CloseChannel           PROCEDURE
GetAuthorizedInfo      PROCEDURE(STRING AreaName, *STRING User, *STRING Password)
GetClient              PROCEDURE,*WbClientManagerClass
GetEnabled             PROCEDURE,BYTE
GetRequestArguments    PROCEDURE,STRING
Init                   PROCEDURE(STRING ProgramName, WbFilesClass Files)   !,EXTENDS
Kill                   PROCEDURE
OpenChannel            PROCEDURE,BYTE
ProcessHttpHeader      PROCEDURE(STRING Txt)
SetClient              PROCEDURE
SetClientBrowser       PROCEDURE,PROTECTED
TakeBeforeBuildHeader  PROCEDURE,VIRTUAL
TakeFile               PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove),VIRTUAL
TakeHtmlPage           PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove),VIRTUAL
TakeJslData            PROCEDURE(STRING Filename, SIGNED Security),VIRTUAL
TakeUnauthorized       PROCEDURE(STRING Filename, SIGNED Security),VIRTUAL

Channel                LONG,PRIVATE
CurClient              &WbClientManagerClass,PROTECTED
Files                  &WbFilesClass
Http                   &WbHttpClass
UseRPC                 BYTE,PRIVATE
                     END


  _EndOfInclude_
