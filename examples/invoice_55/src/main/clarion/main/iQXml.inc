 SECTION('Modules')
   MODULE('iQ-XML Functions')
       XML:LoadFromString(*CSTRING,<BYTE>,<BYTE>),SHORT,DLL(DLL_MODE)
       XML:LoadFromFile(STRING,<BYTE>,<BYTE>),SHORT,DLL(DLL_MODE)
       XML:Free(),DLL(DLL_MODE)
       XML:DebugQueue(<STRING>),DLL(DLL_MODE)
       XML:LoadQueue(*QUEUE,<BYTE>,<BYTE>,<BYTE>),BYTE,DLL(DLL_MODE)
       XML:FindNextNode(STRING,<STRING>,<STRING>,<STRING>,<STRING>),SHORT,DLL(DLL_MODE)
       XML:FindNextContent(STRING,BYTE,BYTE),SHORT,DLL(DLL_MODE)
       XML:ReadNextRecord(*QUEUE,*CSTRING),SHORT,DLL(DLL_MODE)
       XML:ReadPreviousRecord(*QUEUE,*CSTRING),SHORT,DLL(DLL_MODE)
       XML:ReadCurrentRecord(*QUEUE,*CSTRING),SHORT,DLL(DLL_MODE)

       XML:GotoSibling(),SHORT,DLL(DLL_MODE)
       XML:GotoParent(),SHORT,DLL(DLL_MODE)
       XML:GotoChild(),SHORT,DLL(DLL_MODE)

       XML:GotoTop(),DLL(DLL_MODE)
       XML:GetPointer(),LONG,DLL(DLL_MODE)
       XML:SetPointer(LONG),SHORT,DLL(DLL_MODE)
       XML:SaveState(),SHORT,DLL(DLL_MODE)
       XML:RestoreState(SHORT),SHORT,DLL(DLL_MODE)
       XML:FreeState(SHORT),DLL(DLL_MODE)
       XML:PrimaryKeyCascade(STRING,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>,<STRING>),DLL(DLL_MODE)
       XML:PrimaryKeyClear(),DLL(DLL_MODE)
       XML:PrimaryFieldCascade(STRING,STRING),DLL(DLL_MODE)
       XML:PrimaryFieldClear(),DLL(DLL_MODE)    
       XML:QualifyFieldSet(STRING,<BYTE>),DLL(DLL_MODE)
       XML:QualifyFieldClear(<STRING>),DLL(DLL_MODE)
       XML:AttributeFieldSet(STRING,<BYTE>,<STRING>),DLL(DLL_MODE)
       XML:AttributeFieldClear(<STRING>),DLL(DLL_MODE)
       XML:AutoRootSet(),DLL(DLL_MODE)
       XML:AutoRootClear(),DLL(DLL_MODE)
       XML:GetError(<SHORT>),STRING,DLL(DLL_MODE)
       XML:ViewFile(STRING),DLL(DLL_MODE)
       XML:DebugMyQueue(*QUEUE,<STRING>),DLL(DLL_MODE)
       XML:SkipDebug(BYTE),DLL(DLL_MODE)
       XML:PickFileToDebug(),DLL(DLL_MODE)  
       XML:SetProgressWindow(ULONG,<STRING>),DLL(DLL_MODE)
    END

    MODULE('iQ-XML Write Functions')
       XML:CreateXMLFile(STRING,<STRING>,<STRING>,<BYTE>),SHORT,DLL(DLL_MODE)
       XML:CreateParent(STRING),DLL(DLL_MODE)
       XML:CreateAttribute(STRING,STRING),DLL(DLL_MODE)
       XML:AddParent(<BYTE>,<STRING>),DLL(DLL_MODE)
       XML:AddElement(STRING,STRING,<BYTE>),DLL(DLL_MODE)
       XML:CloseXMLFile(<BYTE>),DLL(DLL_MODE)
       XML:CloseParent(),DLL(DLL_MODE)
       XML:AddComment(STRING),DLL(DLL_MODE)
       XML:AddFromQueue(*QUEUE,STRING,<BYTE>,<BYTE>,<BYTE>),DLL(DLL_MODE)
       XML:AddStringText(STRING,<BYTE>),DLL(DLL_MODE)
       XML:CreateXMLString(<STRING>,<STRING>,<BYTE>),SHORT,DLL(DLL_MODE)
       XML:CloseXMLString(<BYTE>),STRING,DLL(DLL_MODE)
       XML:SetElementPrefix(STRING),DLL(DLL_MODE)
       XML:AddFromGroup(*GROUP,STRING,<BYTE>,<BYTE>),DLL(DLL_MODE)
    END
    SECTION('Equates')

IQXML:None       EQUATE(0)
IQXML:Required   EQUATE(1)
IQXML:Optional   EQUATE(2)
IQXML:ISO8601GMT EQUATE('*ISO8601GMT')
