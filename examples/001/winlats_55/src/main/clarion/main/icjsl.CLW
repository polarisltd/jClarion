
  MEMBER

BaseClassDllMode     EQUATE(0)

  INCLUDE('ICSTD.EQU')

  MAP
    INCLUDE('ICSTD.INC')
  .

  INCLUDE('ICJSL.INC')

!- Private Functions ----------------------------------------------------------

!- Output class for generating the java interface data ------------------------

JslManagerClass.OpenChannel            PROCEDURE(SIGNED Security, *WebFilesClass Files)

  CODE
  SELF.LastId = -1
  SELF.NextId = -1
  SELF.Security = Security
  SELF.Files &= Files

  Files.SelectTarget(Security)

  SELF.Target.CreateOpen(Files.GetFilename(Content:Jsl))
  SELF.Target.Writeln('TS')


JslManagerClass.CloseChannel           PROCEDURE

  CODE
  SELF.BeginUpdate(-1)
  SELF.Target.Writeln('.')
  SELF.Target.Close
  SELF.Client.TakeJslData(SELF.Files.GetFilename(Content:Jsl), SELF.Security)


JslManagerClass.BeginUpdate            PROCEDURE(SIGNED Id)

  CODE
  IF (SELF.Lastid <> Id)
    IF (SELF.LastId <> -1)
      SELF.Target.Writeln('END')
    END
    IF (Id <> -1)
      SELF.Target.Writeln('ID ' & Id)
    END
    SELF.LastId = Id
    SELF.NextId = Id
  END


JslManagerClass.SelectControl          PROCEDURE(SIGNED Feq)

  CODE
  SELF.NextId = SELF.Client.Feq2Id(Feq)


JslManagerClass.SetAttribute PROCEDURE(BYTE Which)

  CODE
  SELF.BeginUpdate(SELF.NextId)
  SELF.Target.Writeln(CHR(Which))


JslManagerClass.SetAttribute PROCEDURE(BYTE Which, STRING Value)

  CODE
  SELF.BeginUpdate(SELF.NextId)
  SELF.Target.Writeln(CHR(Which) & ' ' & CLIP(Value))


JslManagerClass.SetAttributeFilename PROCEDURE(BYTE Which, STRING Filename)

  CODE
  SELF.BeginUpdate(SELF.NextId)
  SELF.Target.Writeln(CHR(Which) & ' ' & SELF.Files.GetAlias(Filename))


JslManagerClass.SetIconAttribute PROCEDURE(SIGNED CurIndex, STRING Filename)

  CODE
  SELF.BeginUpdate(SELF.NextId)
  SELF.Target.Writeln(CHR(JSL:ListIcon) & ' ' & CurIndex & ' ' & SELF.Files.GetAlias(Filename))


JslManagerClass.SetAttributeLong PROCEDURE(BYTE Which, LONG Value)

  CODE
  SELF.BeginUpdate(SELF.NextId)
  SELF.Target.Writeln(CHR(Which) & ' ' & Value)


JslManagerClass.SetChecked  PROCEDURE(SIGNED Feq, BYTE IsChecked)

  CODE
  SELF.BeginUpdate(SELF.Client.Feq2Id(ClarionComFeq))
  SELF.Target.Writeln('V X' & IC:Feq2Id(Feq) & '.checked=' & IsChecked)


JslManagerClass.SetListChoice   PROCEDURE(SIGNED Feq, SIGNED _Choice)

  CODE
  IF (_Choice)
    SELF.BeginUpdate(SELF.Client.Feq2Id(ClarionComFeq))
    SELF.Target.Writeln('V X' & IC:Feq2Id(Feq) & '.selectedIndex=' & _Choice)
  END


JslManagerClass.SetValue    PROCEDURE(SIGNED Feq, ? NewValue)

  CODE
  SELF.BeginUpdate(SELF.Client.Feq2Id(ClarionComFeq))
  SELF.Target.Writeln('V X' & IC:feq2Id(Feq) & '.value="' & IC:QuoteJsl(CLIP(NewValue)) & '"')


JslManagerClass.SetQueueEntry   PROCEDURE(SIGNED CurFeq, SIGNED Index, LONG Format)
  CODE
  SELF.BeginUpdate(SELF.NextId)
  SELF.Target.Writeln('@' & IC:GetRecordData(CurFeq, Index, 0, Format) & '|')


JslManagerClass.AddQueueEntry   PROCEDURE(SIGNED CurFeq, SIGNED Index, LONG Format)
  CODE
  SELF.BeginUpdate(SELF.NextId)
  SELF.Target.Writeln('>' & IC:GetRecordData(CurFeq, Index, 0, Format) & '|')


JslManagerClass.ScrollQueueUp   PROCEDURE(SIGNED CurFeq, SIGNED Index, LONG Format)
  CODE
  SELF.BeginUpdate(SELF.NextId)
  SELF.Target.Writeln('#' & IC:GetRecordData(CurFeq, Index, -1, Format) & '|')


JslManagerClass.ScrollQueueDown   PROCEDURE(SIGNED CurFeq, SIGNED Index, LONG Format)
  CODE
  SELF.BeginUpdate(SELF.NextId)
  SELF.Target.Writeln('#' & IC:GetRecordData(CurFeq, Index, -2, Format) & '|')


JslManagerClass.RemoveQueueEntries PROCEDURE(SIGNED Index, SIGNED Number)
  CODE
  SELF.BeginUpdate(SELF.NextId)
  SELF.Target.Writeln('<<|' & Index-1 & '|' & Index-1+Number-1)


JslManagerClass.RemoveAllQueueEntries PROCEDURE
  CODE
  SELF.BeginUpdate(SELF.NextId)
  SELF.Target.Writeln('*')


JslManagerClass.Init                   PROCEDURE(*WebClientManagerInterface Client)
  CODE
  SELF.Target &= NEW TextOutputClass
  SELF.Client &= Client


JslManagerClass.Kill                   PROCEDURE
  CODE
  DISPOSE (SELF.Target)
