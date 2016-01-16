#!  template code subset for testing basic template logic
#!
#TEMPLATE(ABC,'Application Builder Class Templates'),FAMILY('ABC')
#!
#!
#!
#GROUP(%SetupGlobalObjects)
  #CALL(%SetClassDefaults, 'ErrorManager', 'GlobalErrors', %ErrorManagerType)
  #CALL(%SetClassDefaults, 'INIManager', 'INIMgr', %INIClass)
  #CALL(%SetClassDefaults, 'Translator', 'Translator', %RunTimeTranslatorType)
  #CALL(%SetClassDefaults, 'FuzzyMatcher', 'FuzzyMatcher', %FuzzyMatcherClass)
  #FOR(%File)
    #CALL(%SetClassDefaults, 'FileManager:' & %File, 'Hide:Access:' & %File, %FileManagerType)
    #CALL(%SetClassDefaults, 'RelationManager:' & %File, 'Hide:Relate:' & %File, %RelationManagerType)
  #ENDFOR
#!
#!
#!
#!
#GROUP(%SetClassDefaults, %Tag, %ObjectName, %ObjectType)
#CALL(%SetClassItem, %Tag)
#CALL(%SetOOPDefaults, %ObjectName, %ObjectType)
#!
#!
#!
#GROUP(%SetOOPDefaults,%ObjectName,%ObjectType)
#ASSERT(%ClassItem,'%ClassItem has no instance, '&%ObjectName&' '&%ObjectType)
#ASSERT(%ObjectName,'%SetOOPDefaults: '&%ClassItem&' %ObjectName parameter is empty')
#ASSERT(%ObjectType,'%SetOOPDefaults: '&%ClassItem&' %ObjectType parameter is empty')
#SET(%DefaultBaseClassType,%ObjectType)
#IF(~%ThisObjectName)
  #SET(%ThisObjectName,%ObjectName)
#ENDIF
#CLEAR(%ActualDefaultBaseClassType)
#PURGE(%ClassLines)
#!
#!
#!
#!
#GROUP(%SetClassItem,%Instance)
#IF(%Instance AND %ClassItem <> %Instance)
  #CALL(%NoCaseFix, %ClassItem, %Instance)
  #ASSERT(UPPER(%ClassItem) = UPPER(%Instance), 'instance not found: '&%Instance)
#ENDIF
#!
#!
#GROUP(%NoCaseFix,*%Symbol,%FixValue),AUTO
#DECLARE(%i,LONG)
#FIX(%Symbol,%FixValue)
#IF(%Symbol <> %FixValue)
  #LOOP,FOR(%i,1,ITEMS(%Symbol))
    #SELECT(%Symbol,%i)
    #IF(UPPER(%Symbol)=UPPER(%FixValue))
      #BREAK
    #ENDIF
  #ENDLOOP
#ENDIF
#!
#!
#APPLICATION('CW Default Application'),HLP('~TPLApplication')
#CALL(%SetupGlobalObjects)