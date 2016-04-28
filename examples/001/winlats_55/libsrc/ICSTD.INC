              MODULE('ICSTD')
                IC:GetAlphaNumeric(STRING),STRING
                IC:ColorHex(ULONG),STRING
                IC:ColorText(ULONG),STRING
                IC:DuplicateChar(*CSTRING, STRING,STRING)
                IC:EncodeBase64(STRING),STRING
                IC:DecodeBase64(STRING),STRING
                IC:Feq2Id(SIGNED,SIGNED=0),UNSIGNED
                IC:GetBaseName(STRING),STRING
                IC:GetCommandLineOption(STRING),STRING
                IC:GetControlType(SIGNED),SIGNED
                IC:GetPathname(STRING),STRING
                IC:GetPositionPixels(SIGNED Feq, *SIGNED x, *SIGNED y, *SIGNED w, *SIGNED h)
                IC:GetStrDateTime(LONG Date, LONG Time),STRING
                IC:Hex(ULONG),STRING
                IC:Html2Clarion(STRING),STRING
                IC:Id2Feq(UNSIGNED),SIGNED
                IC:IsAbsoluteURL(STRING),SIGNED
                IC:RemoveFile(STRING),SIGNED,PROC
                IC:RGB(LONG),LONG
                IC:SetCommandLine(STRING)
                IC:TranslateFilename(STRING),STRING
              END
              MODULE('ICEXT')
                IC:ConnectToBroker,NAME('IC$ConnectToBroker')
                IC:CopyFile(*CSTRING Source, *CSTRING Target),SIGNED,RAW,PROC,NAME('CopyFile')
                IC:CreateDirectory(STRING),SIGNED,PROC,NAME('IC$CreateDirectory')
                IC:CreateListboxFormat(SIGNED Feq),ULONG,NAME('IC$CreateListboxFormat')
                IC:FreeListboxFormat(ULONG format),NAME('IC$FreeListboxFormat')
                IC:GetBrokerVariable(UNSIGNED),STRING,NAME('IC$GetBrokerVariable')
                IC:GetFileExists(STRING),SIGNED,NAME('IC$FileExists')
                IC:GetListboxHtml(SIGNED),STRING,NAME('IC$GetListboxHtml')
                IC:GetNumColumns(SIGNED Feq),SIGNED,NAME('IC$GetNumColumns')
                IC:GetNumRecords(SIGNED Feq),LONG,NAME('IC$GetNumRecords')
                IC:GetRecordData(SIGNED Feq, LONG Index, LONG id=0, LONG format=0),STRING,NAME('IC$GetRecordData')
                IC:GetRequestClient(),STRING,NAME('IC$RequestClient')
                IC:GetRequestText(),STRING,NAME('IC$RequestText')
                IC:GetStandAloneCommandLine(),*CSTRING,NAME('IC$GetStandAloneCommandLine')
                IC:GetTempFilename(STRING Directory, STRING prefix),STRING,NAME('IC$TempFilename')
                IC:GetHotKey(STRING text),STRING,NAME('IC$HotKey')
                IC:InitializeRPC(*WebFilesClass),SIGNED,NAME('IC$InitialiseRPC')
                IC:LoadBroker(),NAME('IC$LoadBroker')
                IC:OpenSkeleton(STRING source, STRING session),NAME('IC$OpenSkeleton')
                IC:QuoteJsl(STRING),STRING,NAME('IC$QuoteJcl')
                IC:QuoteText(STRING, SIGNED),STRING,NAME('IC$QuoteHtml')
                IC:StripHotkey(STRING),STRING,NAME('IC$StripHotkey')
                IC:DoRemoveFile(*CSTRING),SIGNED,RAW,PROC,NAME('_remove')
                IC:RegisterServer(*WebServerClass),NAME('IC$RegisterServer')
                IC:RemoveDirectory(STRING),SIGNED,PROC,NAME('IC$RemoveDirectory')
                IC:RenameFile(*CSTRING, *CSTRING),SIGNED,RAW,PROC,NAME('_rename')
                IC:ReplaceSkeletonTag(STRING label, STRING newdata),NAME('IC$ReplaceSkeletonTag')
                IC:SendPage(STRING, UNSIGNED),NAME('IC$SendPage')
                IC:SetMaxClients(UNSIGNED),NAME('IC$SetMaxClient')
                IC:TerminateRPC,NAME('IC$TerminateRPC')
                IC:UnloadBroker(),NAME('IC$UnloadBroker')
                IC:WritePatched(STRING target),NAME('IC$WritePatchedSkeleton')
              END
