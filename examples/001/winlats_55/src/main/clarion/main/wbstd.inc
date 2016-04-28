!ABCIncludeFile(WEB)

  OMIT('_EndOfInclude_',_WbStdPresent_)
_WbStdPresent_ EQUATE(1)

            MAP
              MODULE('WBSTD')
IC:GetAlphaNumeric          PROCEDURE(STRING text),STRING
IC:ColorHex                 PROCEDURE(ULONG color),STRING,NAME('IC$ColorHex')
IC:ColorText                PROCEDURE(ULONG color),STRING,NAME('IC$ColorText')
IC:DuplicateChar            PROCEDURE(*CSTRING Target, STRING Source,STRING search)
IC:EncodeBase64             PROCEDURE(STRING text),STRING
IC:DecodeBase64             PROCEDURE(STRING text),STRING
IC:GetBaseName              PROCEDURE(STRING FullPath),STRING
IC:GetCommandLineOption     PROCEDURE(STRING OptionName),STRING
IC:GetPathname              PROCEDURE(STRING FullPath),STRING
IC:GetPositionPixels        PROCEDURE(SIGNED Feq, *SIGNED x, *SIGNED y, *SIGNED w, *SIGNED h)
IC:GetStrDateTime           PROCEDURE(LONG Date, LONG Time),STRING
IC:Hex                      PROCEDURE(ULONG value, SIGNED MinDigits=1),STRING
IC:Html2Clarion             PROCEDURE(STRING text),STRING
IC:IsAbsoluteURL            PROCEDURE(STRING url),SIGNED
IC:RemoveFile               PROCEDURE(STRING Filename),SIGNED,PROC
IC:RGB                      PROCEDURE(LONG color),LONG
IC:TranslateFilename        PROCEDURE(STRING filename),STRING
              END
              MODULE('WBEXT')
IC:ConnectToBroker          PROCEDURE,NAME('IC$ConnectToBroker')
IC:CreateDirectory          PROCEDURE(STRING name),SIGNED,PROC,NAME('IC$CreateDirectory')
IC:CreateListboxFormat      PROCEDURE(SIGNED Feq),ULONG,NAME('IC$CreateListboxFormat')
IC:FreeListboxFormat        PROCEDURE(ULONG format),NAME('IC$FreeListboxFormat')
IC:GetBrokerVariable        PROCEDURE(UNSIGNED index),STRING,NAME('IC$GetBrokerVariable')
IC:GetCommandLine           PROCEDURE(),*CSTRING,NAME('IC$GetCommandLine')
IC:GetFileExists            PROCEDURE(STRING Filename),SIGNED,NAME('IC$FileExists')
IC:GetListboxHtml           PROCEDURE(SIGNED Feq),STRING,NAME('IC$GetListboxHtml')
IC:GetNumColumns            PROCEDURE(SIGNED Feq),SIGNED,NAME('IC$GetNumColumns')
IC:GetNumRecords            PROCEDURE(SIGNED Feq),LONG,NAME('IC$GetNumRecords')
IC:GetRecordData            PROCEDURE(SIGNED Feq, LONG Index, LONG id=0, LONG format=0),STRING,NAME('IC$GetRecordData')
IC:GetRequestClient         PROCEDURE(),STRING,NAME('IC$RequestClient')
IC:GetRequestText           PROCEDURE(),STRING,NAME('IC$RequestText')
IC:GetTempFilename          PROCEDURE(STRING Directory, STRING prefix),STRING,NAME('IC$TempFilename')
IC:GetHotKey                PROCEDURE(STRING text),STRING,NAME('IC$HotKey')
IC:GetEnvironmentVariable   PROCEDURE(STRING Var),STRING,NAME('IC$GetEnvironmentVariable')
IC:InitializeRPC            PROCEDURE(*WbFilesClass Files),SIGNED,NAME('IC$InitialiseRPC')
IC:IsExeRunningInBrowser    PROCEDURE(),SIGNED,NAME('IC$IsExeRunningInBrowser')
IC:LoadBroker               PROCEDURE(),NAME('IC$LoadBroker')
IC:OpenSkeleton             PROCEDURE(STRING source, STRING session),NAME('IC$OpenSkeleton')
IC:QuoteJsl                 PROCEDURE(STRING text),STRING,NAME('IC$QuoteJcl')
IC:QuoteText                PROCEDURE(STRING text, SIGNED kind),STRING,NAME('IC$QuoteHtml')
IC:StripHotkey              PROCEDURE(STRING text),STRING,NAME('IC$StripHotkey')
IC:RegisterServer           PROCEDURE(*WbServerClass server),NAME('IC$RegisterServer')
IC:RemoveDirectory          PROCEDURE(STRING filename),SIGNED,PROC,NAME('IC$RemoveDirectory')
IC:ReplaceSkeletonTag       PROCEDURE(STRING label, STRING newdata),NAME('IC$ReplaceSkeletonTag')
IC:SendPage                 PROCEDURE(STRING Filename, UNSIGNED Flags),NAME('IC$SendPage')
IC:SetMaxClients            PROCEDURE(UNSIGNED max),NAME('IC$SetMaxClient')
IC:TerminateRPC             PROCEDURE,NAME('IC$TerminateRPC')
IC:UnloadBroker             PROCEDURE(),NAME('IC$UnloadBroker')
IC:WritePatched             PROCEDURE(STRING target),NAME('IC$WritePatchedSkeleton')
              END
            END

  INCLUDE('WBSTD2.INC'),ONCE

_EndOfInclude_
