#! this template was created to run GenReadABCFiles and dump the output and verify that our implementation matches
#TEMPLATE(ABC,'AAA TEST')
#APPLICATION
#!
#! Test 1 :  Some multi dimension arrays
#DECLARE (%pClassName),UNIQUE
#DECLARE (%pClassCategory, %pClassName)
#DECLARE (%pClassIncFile,%pClassName)
#DECLARE (%pClassImplements, %pClassName),UNIQUE                        #! List of interfaces implmented by the class
#DECLARE (%pClassMethod,%pClassName),UNIQUE
#DECLARE (%pClassMethodPrototype,%pClassMethod),UNIQUE
#DECLARE (%pClassMethodFinal, %pClassMethodPrototype)
#DECLARE (%pClassMethodPrivate,  %pClassMethodPrototype)
#DECLARE (%pClassMethodVirtual,  %pClassMethodPrototype)
#DECLARE (%pClassMethodProtected,%pClassMethodPrototype)
#DECLARE (%pClassMethodProcAttribute,%pClassMethodPrototype)
#DECLARE (%pClassMethodInherited,%pClassMethodPrototype)
#DECLARE (%pClassMethodDefined, %pClassMethodPrototype)
#DECLARE (%pClassMethodReturnType,%pClassMethodPrototype)
#DECLARE (%pClassMethodParentCall,%pClassMethodPrototype)
#DECLARE (%pClassMethodDll, %pClassMethodPrototype)
#DECLARE (%pClassMethodExtName, %pClassMethodPrototype)
#DECLARE (%pClassMethodCallConv, %pClassMethodPrototype)
#DECLARE (%pClassMethodExtends, %pClassMethodPrototype)
#DECLARE (%pClassProperty,%pClassName),UNIQUE
#DECLARE (%pClassPropertyPrototype,%pClassProperty)
#DECLARE (%pClassPropertyPrivate,  %pClassProperty)
#DECLARE (%pClassPropertyProtected,%pClassProperty)
#DECLARE (%pClassPropertyInherited,%pClassProperty)
#DECLARE (%pClassPropertyDefined, %pClassProperty)
#!
#DECLARE (%pInterface),UNIQUE
#DECLARE (%pInterfaceCategory, %pInterface)
#DECLARE (%pInterfaceIncFile, %pInterface)
#DECLARE (%pInterfaceMethod, %pInterface),UNIQUE
#DECLARE (%pInterfaceMethodPrototype, %pInterfaceMethod),UNIQUE
#DECLARE (%pInterfaceMethodInherited, %pInterfaceMethodPrototype)
#DECLARE (%pInterfaceMethodDefined, %pInterfaceMethodPrototype)
#DECLARE (%pInterfaceMethodReturnType, %pInterfaceMethodPrototype)
#DECLARE (%pInterfaceMethodDll, %pInterfaceMethodPrototype)
#DECLARE (%pInterfaceMethodExtName, %pInterfaceMethodPrototype)
#DECLARE (%pInterfaceMethodCallConv, %pInterfaceMethodPrototype)
#!
#DECLARE (%pProcedure),UNIQUE                                           #! Procedures 'exported' from header file MAPs
#DECLARE (%pProcedureCategory, %pProcedure)
#DECLARE (%pProcedureIncFile, %pProcedure)
#DECLARE (%pProcedurePrototype, %pProcedure),UNIQUE
#DECLARE (%pProcedureDll, %pProcedurePrototype)
#DECLARE (%pProcedureExtName, %pProcedurePrototype)
#DECLARE (%pProcedureCallConv, %pProcedurePrototype)
#!
#DECLARE (%ClassMethodList),UNIQUE
#DECLARE (%PropertyList),UNIQUE              #!These variables are used by the SetABCProperty and CallABCMethod CODE templates
#DECLARE (%MethodList),UNIQUE
#DECLARE (%ObjectList),UNIQUE
#DECLARE (%ObjectListType,%ObjectList)
#SERVICE('C55TPLSX.DLL','GenReadABCFiles')
#CREATE('test.txt')
OMIT('_EndOfABCSymbols_')

--->Classes
  #FOR(%pClassName)
pClassName:                     |%pClassName|
pClassCategory:                 |%pClassCategory|
pClassIncFile:                  |%pClassIncFile|
    #FOR(%pClassImplements)
  pClassImplements              |%pClassImplements|
    #ENDFOR
    #FOR(%pClassMethod)
  pClassMethod:                 |%pClassMethod|
      #FOR(%pClassMethodPrototype)
    pClassMethodPrototype       |%pClassMethodPrototype|
    pClassMethodPrivate         |%pClassMethodPrivate|
    pClassMethodVirtual         |%pClassMethodVirtual|
    pClassMethodProtected       |%pClassMethodProtected|
    pClassMethodProcAttribute   |%pClassMethodProcAttribute|
    pClassMethodInherited       |%pClassMethodInherited|
    pClassMethodDefined         |%pClassMethodDefined|
    pClassMethodReturnType      |%pClassMethodReturnType|
    pClassMethodParentCall      |%pClassmethodParentCall|
    pClassMethodExtends         |%pClassmethodExtends|
      #ENDFOR
    #ENDFOR
    #FOR(%pClassProperty)
  pClassProperty                |%pClassProperty|
  pClassPropertyPrototype       |%pClassPropertyPrototype|
  pClassPropertyPrivate         |%pClassPropertyPrivate|
  pClassPropertyProtected       |%pClassPropertyProtected|
  pClassPropertyInherited       |%pClassPropertyInherited|
  pClassPropertyDefined         |%pClassPropertyDefined|
    #ENDFOR
  #ENDFOR

---> Interfaces
  #FOR(%pInterface)
pInterface                      |%pInterface|
pInterfaceCategory              |%pInterfaceCategory|
pInterfaceIncFile               |%pInterfaceIncFile|
    #FOR(%pInterfaceMethod)
  pInterfaceMethod              |%pInterfaceMethod|
      #FOR(%pInterfaceMethodPrototype)
    pInterfaceMethodPrototype   |%pInterfaceMethodPrototype|
    pInterfaceMethodInherited   |%pInterfaceMethodInherited|
    pInterfaceMethodDefined     |%pInterfaceMethodDefined|
    pInterfaceMethodReturnType  |%pInterfaceMethodReturnType|
      #ENDFOR
    #ENDFOR
  #ENDFOR
  
---> Exported Procedures
  #FOR(%pProcedure)
pProcedure                      |%pProcedure|
pProcedureCategory              |%pProcedureCategory|
pProcedureIncFile               |%pProcedureIncFile|
    #FOR(%pProcedurePrototype)
  pProcedurePrototype           |%pProcedurePrototype|
    #ENDFOR
  #ENDFOR
_EndOfABCSymbols_
#CLOSE