
  MEMBER

BaseClassDllMode     EQUATE(0)

  INCLUDE('ICLAYOUT.INC')

  MAP
    INCLUDE('ICSTD.INC')
    GetItem(*LayoutCellClass, SIGNED),*HtmlItemClass
  .


!!- Private class definitions -----------------------


GetItem         PROCEDURE(*LayoutCellClass CurCell, SIGNED Index)
  CODE
  GET(CurCell.Contents, Index)
  RETURN CurCell.Contents.Item


HtmlItemClass.CreateHtml      PROCEDURE(*HtmlClass Target)

  CODE


HtmlItemClass.GetCellAttributes       PROCEDURE(*HtmlClass Target)

  CODE
  RETURN ''


HtmlItemClass.GetPosition       PROCEDURE(*SIGNED x, *SIGNED y, *SIGNED w, *SIGNED h)

  CODE
  ASSERT(FALSE)


HtmlItemClass.Kill              PROCEDURE

  CODE


LayoutCellClass.GetCellAttributes PROCEDURE

Style           PSTRING(100)

  CODE
  IF (SELF.SpanX > 1)
    Style = Style & ' COLSPAN=' & SELF.SpanX
  END
  IF (SELF.SpanY > 1)
    Style = Style & ' ROWSPAN=' & SELF.SpanY
  END
  RETURN Style


LayoutCellClass.Init          PROCEDURE
  CODE
  SELF.SpanX = 1
  SELF.SpanY = 1
  SELF.Contents &= NEW CellQueue


LayoutCellClass.Kill          PROCEDURE
  CODE
  DISPOSE (SELF.Contents)


RangeClass.AddPoint  PROCEDURE(SIGNED Offset, SIGNED extent, *BYTE IsNew, SIGNED Delta)

AddIndex             SIGNED,AUTO
MaxBound             SIGNED,AUTO

  CODE
  MaxBound = RECORDS(SELF.Bounds)
  AddIndex = 1
  LOOP WHILE (AddIndex <= MaxBound)
    GET(SELF.Bounds, AddIndex)
    IF (Offset < SELF.Bounds.Maximum-2*Delta)
      BREAK
    END
    IF (Offset <= SELF.Bounds.Minimum+2*Delta)
      IF (Offset < SELF.Bounds.Minimum)
        SELF.Bounds.Minimum = Offset
      END
      IF (Offset > SELF.Bounds.Maximum)
        SELF.Bounds.Maximum = Offset
      END
      IF (Offset + extent > SELF.Bounds.MaxExtent)
        SELF.Bounds.MaxExtent = Offset + extent
      END
      PUT(SELF.Bounds)
      IsNew = FALSE
      RETURN AddIndex
    END
    AddIndex += 1
  END
  IsNew = TRUE
  SELF.Bounds.Minimum = Offset
  SELF.Bounds.Maximum = Offset
  SELF.Bounds.MaxExtent = Offset + extent
  ADD(SELF.Bounds, AddIndex)
  RETURN AddIndex


RangeClass.Init   PROCEDURE
  CODE
  SELF.Bounds &= NEW RangeQueue


RangeClass.Kill   PROCEDURE
  CODE
  DISPOSE (SELF.Bounds)


LayoutHtmlClass.AddCell        PROCEDURE(SIGNED Before)

NewCell         &LayoutCellClass,AUTO

  CODE
  NewCell &= NEW LayoutCellClass
  Self.Rows.Columns.Cell &= NewCell
  NewCell.Init
  ADD(Self.Rows.Columns, Before)

LayoutHtmlClass.AddRow         PROCEDURE(SIGNED Before)

Xpos            SIGNED,AUTO

  CODE
  Self.Rows.Columns &= NEW ColumnQueue
  ADD(Self.Rows, Before)

  ! Initialise the columns in this row...
  LOOP Xpos = 1 TO RECORDS(SELF.RangeX.Bounds)
    SELF.AddCell(Xpos)
  END

LayoutHtmlClass.AddColumn      PROCEDURE(SIGNED Before)

Ypos            SIGNED,AUTO

  CODE
  ! Add a cell to each row to create the new column
  LOOP Ypos = 1 TO RECORDS(SELF.RangeY.Bounds)
    GET(Self.Rows, YPos)
    SELF.AddCell(Before)
  END

LayoutHtmlClass.CreateHtml      PROCEDURE(*HtmlClass Target)

CurCell         &LayoutCellClass,AUTO
CurItem         &HtmlItemClass,AUTO
Index           SIGNED,AUTO
NumItems        SIGNED,AUTO
NumRows         SIGNED,AUTO
Style           ANY
Xindex          SIGNED,AUTO
Yindex          SIGNED,AUTO

  CODE

  SELF.Optimize
  NumRows = RECORDS(SELF.Rows);
  IF (NumRows > 0)
    Target.Write('<<TABLE' & SELF.Style & '>')
    LOOP Yindex = 1 TO NumRows
      GET(SELF.Rows, Yindex)
      SELF.CreateWhitespace(Yindex)
      Target.Write('<<TR>')
      LOOP Xindex = 1 TO RECORDS(SELF.Rows.Columns)
        GET(SELF.Rows.Columns, Xindex)
        CurCell &= SELF.Rows.Columns.Cell
        IF (NOT CurCell.Skip)
          NumItems = RECORDS(CurCell.Contents)
          IF (NumItems = 1)
            CurItem &= CurCell.GetItem(1)
            Target.Write('<<TD' & CurCell.GetCellAttributes() & CurItem.GetCellAttributes(Target) & '>')
            CurItem.CreateHtml(Target)
            Target.Writeln('<</TD>')
          ELSE
            Target.Write('<<TD' & CurCell.GetCellAttributes() & '>')
            LOOP Index = 1 TO NumItems
              CurItem &= CurCell.GetItem(Index)
              Style = CurItem.GetCellAttributes(Target)
              IF (Style)
                Target.Write('<<P ' & Style & '>')
              END
              CurItem.CreateHtml(Target)
              IF (Style)
                Target.Write('<</P>')
              END
            END
            Target.Writeln('<</TD>')
          END
        END
      END
      Target.Write('<</TR>')
    END
    Target.Writeln('<</TABLE>')
  END


LayoutHtmlClass.CreateWhitespace        PROCEDURE(SIGNED Yindex)
  CODE
  IF SELF.ExpandWhitespace AND (Yindex > 1)
    !MORE
  END

LayoutHtmlClass.Init              PROCEDURE(STRING Style, SIGNED SnapX, SIGNED SnapY)

  CODE
  IF (Style)
     SELF.Style = ' ' & Style
  ELSE
     SELF.Style = ''
  END

  SELF.Rows &= NEW RowQueue
  SELF.RangeX &= NEW RangeClass
  SELF.RangeX.Bounds &= NEW RangeQueue
  SELF.RangeY &= NEW RangeClass
  SELF.RangeY.Bounds &= NEW RangeQueue

  SELF.SnapX = SnapX
  SELF.SnapY = SnapY
  SELF.ExpandWhitespace = FALSE


LayoutHtmlClass.Insert            PROCEDURE(*HtmlItemClass NewItem)

CurCell         &LayoutCellClass,AUTO
dx              SIGNED,AUTO
dy              SIGNED,AUTO
x               SIGNED,AUTO
y               SIGNED,AUTO
Xpos            SIGNED,AUTO
Ypos            SIGNED,AUTO
IsNew           BYTE,AUTO

  CODE

  NewItem.GetPosition(x, y, dx, dy)
  Ypos = SELF.RangeY.AddPoint(y, dy, IsNew, SELF.SnapY)
  IF (IsNew)
    SELF.AddRow(Ypos)
  END

  Xpos = SELF.RangeX.AddPoint(x, dx, IsNew, SELF.SnapX)
  IF (IsNew)
    SELF.AddColumn(Xpos)
  END

  CurCell &= SELF.SetCell(Xpos, Ypos)
  CurCell.Contents.Item &= NewItem
  ADD(CurCell.Contents)

  IF (dx > CurCell.dx)
     CurCell.dx = dx;
  END
  IF (dy > CurCell.dy)
     CurCell.dy = dy;
  END


LayoutHtmlClass.Kill              PROCEDURE

CurCell         &LayoutCellClass,AUTO
CurItem         SIGNED,AUTO
Xpos            SIGNED,AUTO
Ypos            SIGNED,AUTO

  CODE

  IF (~SELF.Rows &= NULL)
    ASSERT(~SELF.RangeX.Bounds &= NULL)
    ASSERT(~SELF.RangeY.Bounds &= NULL)
    LOOP Ypos = 1 TO RECORDS(SELF.RangeY.Bounds)
      LOOP Xpos = 1 TO RECORDS(SELF.RangeX.Bounds)
        CurCell &= SELF.SetCell(Xpos, Ypos)
        CurCell.Kill
        DISPOSE(CurCell)
      END
      DISPOSE(Self.Rows.Columns)
    END
    DISPOSE(SELF.Rows)
    SELF.RangeX.Kill
    DISPOSE(SELF.RangeX)
    SELF.RangeY.Kill
    DISPOSE(SELF.RangeY)
  END


LayoutHtmlClass.SetCell          PROCEDURE(SIGNED Xpos, SIGNED Ypos)

  CODE
  GET(SELF.Rows, Ypos)
  GET(SELF.Rows.Columns, Xpos)
  RETURN SELF.Rows.Columns.Cell


LayoutHtmlClass.Optimize          PROCEDURE

CurCell         &LayoutCellClass,AUTO
NextCell        &LayoutCellClass,AUTO
LastCell        &LayoutCellClass,AUTO

Xpos            SIGNED,AUTO
Ypos            SIGNED,AUTO
NextCol         SIGNED,AUTO
NextRow         SIGNED,AUTO
MaxX            SIGNED,AUTO
MaxY            SIGNED,AUTO
Span            SIGNED,AUTO
NumRangeX       SIGNED,AUTO
NumRangeY       SIGNED,AUTO

  CODE

  NumRangeX = RECORDS(SELF.RangeX.Bounds)
  NumRangeY = RECORDS(SELF.RangeY.Bounds)

  ! First expand cells horizontally, so that items fill multiple cell entries
  ! until we reach a control that overlaps us, or the column represents a
  ! position beyond the right hand of the control.
  LOOP Ypos = 1 TO NumRangeY
    Xpos = 1
    LOOP WHILE (Xpos < NumRangeX)
      CurCell &= SELF.SetCell(Xpos, Ypos)
      IF (RECORDS(CurCell.Contents) > 0)
        NextCol = Xpos + 1
        GET(SELF.RangeX.Bounds, Xpos)
        MaxX = SELF.RangeX.Bounds.Minimum + CurCell.dx
        LOOP WHILE (NextCol <= NumRangeX)
          GET(SELF.RangeX.Bounds, NextCol)
          IF (MaxX <= SELF.RangeX.Bounds.Minimum)
            BREAK
          END
          NextCell &= SELF.SetCell(NextCol, Ypos)
          IF (RECORDS(NextCell.Contents) <> 0)
            BREAK
          END
          NextCell.Skip = TRUE
          CurCell.SpanX += 1
          NextCol += 1
        END
        Xpos = NextCol
      ELSE
        Xpos += 1
      END
    END
  END

  ! Now expand the cells vertically.  Same as above, except the cells can
  ! take up more than one column.
  LOOP Xpos = 1 TO NumRangeX
    LOOP Ypos = 1 TO NumRangeY - 1
      CurCell &= SELF.SetCell(Xpos, Ypos)
      IF (RECORDS(CurCell.Contents) > 0)
        NextRow = Ypos + 1
        GET(SELF.RangeY.Bounds, Ypos)
        MaxY = SELF.RangeY.Bounds.Minimum + CurCell.dy
        LOOP WHILE (NextRow <= NumRangeY)
          GET(SELF.RangeY.Bounds, NextRow)
          IF (MaxY <= SELF.RangeY.Bounds.Minimum)
            BREAK
          END
          LOOP NextCol = Xpos TO Xpos + CurCell.SpanX - 1
            NextCell &= SELF.SetCell(NextCol, NextRow)
            IF (NextCell.Skip OR (RECORDS(NextCell.Contents) <> 0))
              GOTO Done
            END
          END
          LOOP NextCol = Xpos TO Xpos + CurCell.SpanX - 1
            NextCell &= SELF.SetCell(NextCol, NextRow)
            NextCell.Skip = TRUE
          END
          CurCell.SpanY += 1
          NextRow += 1
        END
      END
Done
    END
  END


  ! Optimize spaces within the grid.
  LOOP Ypos = 1 TO NumRangeY
    Xpos = 1
    LOOP WHILE Xpos < NumRangeX
      CurCell &= SELF.SetCell(Xpos, Ypos)
      Xpos += 1
      IF (NOT CurCell.Skip AND RECORDS(CurCell.Contents) = 0)
        LOOP WHILE Xpos <= NumRangeX
          NextCell &= SELF.SetCell(Xpos, Ypos)
          IF (NextCell.Skip OR RECORDS(NextCell.Contents) <> 0)
            BREAK
          END
          NextCell.Skip = TRUE
          CurCell.SpanX += 1
          Xpos += 1
        END
      END
    END
  END

