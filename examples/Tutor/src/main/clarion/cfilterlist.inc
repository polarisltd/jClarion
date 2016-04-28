!ABCIncludeFile

omit('End of include', _cFilterListPresent_)
_cFilterListPresent_        equate(1)

    include('cFiltBase.inc'), once
    include('iFilter.int'), once
    include('abqeip.inc'), once
    include('abutil.inc'), once

TDefaultOpe     group, type
Number            ushort
                end

TCol            group, type
ColName           string(25)
                end

TConnectOpe     group, type
Operator          string(25)
                end

TColQ           queue(TCol), type
                end


TConnectOpeQ    queue(TConnectOpe), type
                end

TColEditClass   class(EditDropListClass), type, module('cFilterList.clw'), link('cfilterList.clw', _ABCLinkMode_), DLL(_ABCDLLMode_)
ColQ              &TColQ
Destruct          procedure()
CreateControl     procedure(), virtual, protected
SetAlerts         procedure(), virtual
                end

TColOpeClass    class(EditDropListClass), type,  module('cFilterList.clw'), link('cfilterList.clw', _ABCLinkMode_), DLL(_ABCDLLMode_)
ColOpeQ           &TColOpeQ
Destruct          procedure()
CreateControl     procedure(), virtual, protected
SetAlerts         procedure(), virtual
                end

TConnEditClass  class(EditDropListClass), type, module('cFilterList.clw'), link('cfilterList.clw', _ABCLinkMode_), DLL(_ABCDLLMode_)
ConnOpeQ          &TConnectOpeQ
Destruct          procedure()
CreateControl     procedure(), virtual, protected
SetAlerts         procedure(), virtual
                end


cFilterList     class(cFilterBase), type, module('cFilterList.clw'), implements(IFilter), link('cfilterList.clw', _ABCLinkMode_), DLL(_ABCDLLMode_)

EIP               &QEIPManager
ColEditClass      &TColEditClass
ColOpeClass       &TColOpeClass
ColValueClass     &EditEntryClass
ConEditClass      &TConnEditClass

ColEditVar        like(TFilter.Column)
ColOpeVar         like(TFilter.Operator)
ColValueVar       like(TFilter.Value)
ConEditVar        like(TFilter.Connection)

EQ                &EditQueue
FPairs            &FieldPairsClass

INIMgr            &INIClass
DisposeINI        byte, private
AppName           string(50)                ! For INI and Registry in order to create the different sections needed to save the queries
ProcName          string(50)
CurrentQuery      string(50)                ! Current Query name

ListCtrl          long                      ! List control that shows the Filter lines

ColQ              &TColQ

ConnectopeQ       &TConnectOpeQ             ! Queue holding keywords AND, OR, etc...
ColOpeQ           &TColOpeQ                 ! Queue containing keywords like GT IN, NOT IN etc...
ColOpeExQ         &TColOpeExceptQ           ! Queue containing datatype exception for filter generation

ConnectOpe        long                      ! Droplist FEQ that will contain Connection operator (AND, OR AND (..., etc...)
ColumnOpe         long                      ! Droplist FEQ that will contain Operator like GT, LT BETWEEN etc...
ValueEntry        long                      ! Entry FEQ that will be used to edit the value in the Filter line
W                 &Window                   ! Reference to parent window (used with REGISTER statement)

Construct         procedure()
Destruct          procedure()

AskQueryName      procedure(), virtual
Init              procedure(long pListCtrl, window pW), virtual
InitINI           procedure(*INIClass pIniRef), virtual
InitINI           procedure(string pIniFileName, long pIniType = NVD_INI), byte, virtual, proc
FillConnectOpe    procedure(), virtual
FillColOpe        procedure(TDefaultOpe pOpeGrp), virtual
FillColOpeEx      procedure(TDefaultOpe pOpeGrp), virtual
RegisterEvents    procedure(), virtual
OnDrop            procedure(), byte, virtual, proc
OnAlertKey        procedure(), byte, virtual, proc
OnPreAlertKey     procedure(), byte, virtual, proc
onAccepted        procedure(), byte, virtual, proc
Reset             procedure(), virtual
Save              procedure(), virtual
SaveAS            procedure(), virtual
Load              procedure(), long, proc, virtual

                end

    End of include

