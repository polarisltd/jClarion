!ABCIncludeFile

    omit('End of include', _abqeipPresent_)
_abqeipPresent_        equate(1)

    include('abwindow.inc'),once
    include('abeip.inc'),once


QEIPManager     CLASS(EipManager),type, MODULE('abqeip.clw'),LINK('abqeip.clw', _ABCLinkMode_),DLL(_ABCDllMode_)
Q                    &Queue !queue EIP is on
Init                 PROCEDURE,BYTE,DERIVED,PROC
TakeCompleted        PROCEDURE(BYTE Force),DERIVED
TakeNewSelection     PROCEDURE,DERIVED,BYTE,PROC
ClearColumn          PROCEDURE,DERIVED
SetRequest           procedure(byte Request), virtual
                END


  End of include
