!ABCIncludeFile(WEB)

  OMIT('_EndOfInclude_',_ICHookPresent_)
_ICHookPresent_ EQUATE(1)

WbDummyLinkInWbHook       CLASS,MODULE('WBHOOK.CLW'),LINK('WBHOOK',_WebAbcLinkMode_),TYPE,DLL(_WebAbcDllMode_)
                        END

  MAP
    MODULE('WBHOOK')
IC:ClearHooks       PROCEDURE,NAME('IC$ClearHooks')
IC:InitializeHooks  PROCEDURE,NAME('IC$InitializeHooks')
    END
  END


  _EndOfInclude_
