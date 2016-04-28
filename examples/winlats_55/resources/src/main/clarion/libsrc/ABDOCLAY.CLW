
  MEMBER

  INCLUDE('ABDOCLAY.INC'),ONCE
  INCLUDE('IDOCFT.INC'),ONCE

  MAP
  .


SNAPX_DEFAULT EQUATE(5)
SNAPY_DEFAULT EQUATE(5)

LayoutCellClass.GetItem PROCEDURE(SIGNED Index)
  CODE

  GET(SELF.Contents, Index)
  RETURN SELF.Contents.Item


LayoutCellClass.ApplyCellAttributes PROCEDURE(IDocumentCreate ICreate, IDocIdType Id)
  CODE

  IF (SELF.SpanX > 1)
    ICreate.PutOption('COLSPAN', SELF.SpanX, Id)
  END
  IF (SELF.SpanY > 1)
    ICreate.PutOption('ROWSPAN', SELF.SpanY, Id)
  END


LayoutCellClass.Init PROCEDURE
  CODE
  SELF.SpanX = 1
  SELF.SpanY = 1
  SELF.Contents &= NEW CellQueue


LayoutCellClass.Kill PROCEDURE
  CODE
  DISPOSE (SELF.Contents)


RangeClass.AddPoint PROCEDURE(SIGNED Offset, SIGNED extent, *BYTE IsNew, SIGNED Delta)

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


RangeClass.Init PROCEDURE
  CODE
  SELF.Bounds &= NEW RangeQueue


RangeClass.Kill PROCEDURE
  CODE
  DISPOSE (SELF.Bounds)


LayoutClass.AddCell PROCEDURE(SIGNED Before)

NewCell &LayoutCellClass,AUTO
  CODE

  NewCell &= NEW LayoutCellClass
  Self.Rows.Columns.Cell &= NewCell
  NewCell.Init
  ADD(Self.Rows.Columns, Before)

LayoutClass.AddRow         PROCEDURE(SIGNED Before)

Xpos            SIGNED,AUTO

  CODE
  Self.Rows.Columns &= NEW ColumnQueue
  ADD(Self.Rows, Before)

  ! Initialise the columns in this row...
  LOOP Xpos = 1 TO RECORDS(SELF.RangeX.Bounds)
    SELF.AddCell(Xpos)
  END

LayoutClass.AddColumn      PROCEDURE(SIGNED Before)

Ypos            SIGNED,AUTO

  CODE
  ! Add a cell to each row to create the new column
  LOOP Ypos = 1 TO RECORDS(SELF.RangeY.Bounds)
    GET(Self.Rows, YPos)
    SELF.AddCell(Before)
  END

LayoutClass.Layout PROCEDURE(IDocIdType StartId)
CurCell         &LayoutCellClass,AUTO
Index           SIGNED,AUTO
NumItems        SIGNED,AUTO
NumRows         SIGNED,AUTO
Xindex          SIGNED,AUTO
Yindex          SIGNED,AUTO

CurItemId       IDocIDType,AUTO
TableId         IDocIDType,AUTO
RowId           IDocIDType,AUTO
CellId          IDocIDType,AUTO
  CODE

  SELF.Optimize
  NumRows = RECORDS(SELF.Rows);
  IF (NumRows > 0)

    TableId=SELF.ICreate.PutFormat(FT_Table, StartId, MV_Before)

    LOOP Yindex = 1 TO NumRows
      GET(SELF.Rows, Yindex)
      SELF.CreateWhitespace(Yindex)

      RowId=SELF.ICreate.PutFormat(FT_TableRow, TableId)

      LOOP Xindex = 1 TO RECORDS(SELF.Rows.Columns)
        GET(SELF.Rows.Columns, Xindex)
        CurCell &= SELF.Rows.Columns.Cell
        IF (NOT CurCell.Skip)
          NumItems = RECORDS(CurCell.Contents)

          CellId=SELF.ICreate.PutFormat(FT_TableCell, RowId)

          CurCell.ApplyCellAttributes(SELF.ICreate, CellId)

          LOOP Index = 1 TO NumItems
            CurItemId=CurCell.GetItem(Index)

            SELF.ICreate.MoveComponent(CurItemId, CellId)

          END
        END
      END
    END
  END


LayoutClass.CreateWhitespace        PROCEDURE(SIGNED Yindex)
  CODE

  IF SELF.ExpandWhitespace AND (Yindex > 1)
    !MORE
  END


LayoutClass.Init PROCEDURE(IDocumentCreate ICreate)
  CODE

  SELF.ICreate &= ICreate
  SELF.Rows &= NEW RowQueue
  SELF.RangeX &= NEW RangeClass
  SELF.RangeX.Bounds &= NEW RangeQueue
  SELF.RangeY &= NEW RangeClass
  SELF.RangeY.Bounds &= NEW RangeQueue

  SELF.ExpandWhitespace = FALSE
  SELF.SetSnap(SNAPX_DEFAULT, SNAPY_DEFAULT)


LayoutClass.SetSnap PROCEDURE(SIGNED SnapX, SIGNED SnapY)
  CODE

  SELF.SnapX = SnapX
  SELF.SnapY = SnapY


LayoutClass.Insert PROCEDURE(IDocIdType IDocId, LONG x, LONG y, LONG dx, LONG dy)
CurCell         &LayoutCellClass,AUTO
Xpos            SIGNED,AUTO
Ypos            SIGNED,AUTO
IsNew           BYTE,AUTO
  CODE

  Ypos = SELF.RangeY.AddPoint(y, dy, IsNew, SELF.SnapY)
  IF (IsNew)
    SELF.AddRow(Ypos)
  END

  Xpos = SELF.RangeX.AddPoint(x, dx, IsNew, SELF.SnapX)
  IF (IsNew)
    SELF.AddColumn(Xpos)
  END

  CurCell &= SELF.SetCell(Xpos, Ypos)
  CurCell.Contents.Item=IDocId
  ADD(CurCell.Contents)

  IF (dx > CurCell.dx)
     CurCell.dx = dx;
  END
  IF (dy > CurCell.dy)
     CurCell.dy = dy;
  END


LayoutClass.Kill              PROCEDURE

CurCell         &LayoutCellClass,AUTO
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


LayoutClass.SetCell          PROCEDURE(SIGNED Xpos, SIGNED Ypos)

  CODE
  GET(SELF.Rows, Ypos)
  GET(SELF.Rows.Columns, Xpos)
  RETURN SELF.Rows.Columns.Cell


LayoutClass.Optimize          PROCEDURE

CurCell         &LayoutCellClass,AUTO
NextCell        &LayoutCellClass,AUTO

Xpos            SIGNED,AUTO
Ypos            SIGNED,AUTO
NextCol         SIGNED,AUTO
NextRow         SIGNED,AUTO
MaxX            SIGNED,AUTO
MaxY            SIGNED,AUTO
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

