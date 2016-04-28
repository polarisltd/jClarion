OMIT('_EndOfInclude_',_ICBrokerPresent_)
_ICBrokerPresent_ EQUATE(1)

INCLUDE('ICSINK.INC')
INCLUDE('ICJSL.INC')
INCLUDE('ICHTTP.INC')
INCLUDE('ICCLIENT.INC')
INCLUDE('ICFILES.INC')

BrokerClass          CLASS(WebDataSinkClass),MODULE('IcBroker.clw'),LINK('ICBROKER',LinkBaseClasses),TYPE,DLL(BaseClassDllMode)
CloseChannel           PROCEDURE
GetAuthorizedInfo      PROCEDURE(STRING AreaName, *STRING User, *STRING Password)
GetClient              PROCEDURE,*WebClientManagerClass
GetEnabled             PROCEDURE,BYTE
GetRequestArguments    PROCEDURE,STRING
Init                   PROCEDURE(STRING ProgramName, WebFilesClass)
Kill                   PROCEDURE
OpenChannel            PROCEDURE,BYTE
ProcessHttpHeader      PROCEDURE(STRING)
SetClient              PROCEDURE
SetClientBrowser       PROCEDURE,PROTECTED
TakeBeforeBuildHeader  PROCEDURE,VIRTUAL
TakeFile               PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove),VIRTUAL
TakeHtmlPage           PROCEDURE(STRING Filename, SIGNED Security, BYTE dontmove),VIRTUAL
TakeJslData            PROCEDURE(STRING, SIGNED Security),VIRTUAL
TakeUnauthorized       PROCEDURE(STRING Filename, SIGNED Security),VIRTUAL

Channel                LONG,PRIVATE
CurClient              &WebClientManagerClass,PROTECTED
Files                  &WebFilesClass
Http                   &HttpClass
ServerName             CSTRING(255),PROTECTED
UseRPC                 BYTE,PRIVATE
                     END


_EndOfInclude_
