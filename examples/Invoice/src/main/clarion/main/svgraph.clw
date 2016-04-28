    MEMBER
 INCLUDE('SVGraph.inc'),ONCE
 INCLUDE('keycodes.clw'),ONCE
 INCLUDE('prnprop.clw'),ONCE
! Device Parameters for GetDeviceCaps()
winHORZRES              equate(8)                   ! Horizontal width in pixels
winVERTRES              equate(10)                  ! Vertical height in pixels
winLOGPIXELSX           equate(88)                  ! Logical pixels/inch in X
winLOGPIXELSY           equate(90)                  ! Logical pixels/inch in Y
!
! DrawText() Format Flags
winDT_WORDBREAK         equate(00000010h)
winDT_SINGLELINE        equate(00000020h)
winDT_EXPANDTABS        equate(00000040h)
winDT_NOCLIP            equate(00000100h)
winDT_CALCRECT          equate(00000400h)
!
! CreateFont()
winOUT_DEFAULT_PRECIS   equate(0)
winDEFAULT_PITCH        equate(0)
winFIXED_PITCH          equate(1)
winVARIABLE_PITCH       equate(2)
winMONO_FONT            equate(8)
!
winWM_GETFONT           equate(031h)
!
winSizeType             group,type
eW                        signed
eH                        signed
                        end
!
winRECTtype             group,type
eLeft                     signed
eTop                      signed
eRight                    signed
eBottom                   signed
                        end
!
winPOINTtype            group,type
eX                        signed
eY                        signed
                        end
!
winAPMFileHeaderType    group, type                 ! Aldus Placeable Metafiles
eKey                      ulong                     ! Magic number (always 9AC6CDD7h)
eHandle                   ushort                    ! Metafile HANDLE number (always 0)
eLeft                     short                     ! Left coordinate in metafile units
eTop                      short                     ! Top coordinate in metafile units
eRight                    short                     ! Right coordinate in metafile units
eBottom                   short                     ! Bottom coordinate in metafile units
eInch                     ushort                    ! Number of metafile units per inch
eReserved                 ulong                     ! Reserved (always 0)
eChecksum                 ushort                    ! Checksum value for previous 10 WORDs
                        end
!
winRECTLtype            group(winRectType), type
                        end
!
winSIZELtype            group(winSizeType), type
                        end
!
winENHMETAHEADERtype    group, type
eIType                    ulong
eNSize                    ulong
rclBounds                 like(winRECTLtype)
rclFrame                  like(winRECTLtype)
eDSignature               ulong
eNVersion                 ulong
eNBytes                   ulong
eNRecords                 ulong
eNHandles                 ulong
eSReserved                ulong
eNDescription             ulong
eOffDescription           ulong
eNPalEntries              ulong
szlDevice                 like(winSIZELtype)
szlMillimeters            like(winSIZELtype)
! WINVER >= 0x0400
eCbPixelFormat            ulong
eOffPixelFormat           ulong
eBOpenGL                  ulong
! WINVER >= 0x0500
szlMicrometers            like(winSIZELtype)
                        end
    MAP
  include('cwutil.inc')
  module('WinAPI')
    MulDiv(signed, signed, signed), signed, pascal
    GetDC(unsigned), unsigned, pascal
    ReleaseDC(unsigned, unsigned), signed, pascal
    CreateCompatibleDC(unsigned), unsigned, pascal
    DeleteDC(unsigned), bool, proc, pascal
    SelectObject(unsigned, unsigned), unsigned, pascal
    DeleteObject(unsigned), bool, pascal
    DrawText(unsigned, *string, signed, *winRECTtype, unsigned), signed, pascal, raw, name('DrawTextA')
    DrawTextEx(unsigned, *string, signed, *winRECTtype, unsigned, unsigned=0), signed, pascal, raw, name('DrawTextExA')
    CreateFont(signed, signed, signed, signed, signed, ulong, ulong, ulong, ulong, ulong, ulong, ulong, ulong, |
               *cstring), unsigned, pascal, raw, name('CreateFontA')
    GetTextExtentPoint32(unsigned,*string, signed, *winSizeType), bool, pascal, raw, name('GetTextExtentPoint32A')
    GetDeviceCaps(unsigned, signed), signed, pascal
    SendMessage(unsigned, unsigned, unsigned, long), long, pascal, name('SendMessageA')
    GetLastError(), ulong, pascal
    FormatMessageA(unsigned, ulong, unsigned, unsigned, *cstring, unsigned, *cstring), unsigned, pascal, raw
    SetWindowPos(unsigned, unsigned, signed, signed, signed, signed, unsigned), bool, pascal, proc
    BringWindowToTop(unsigned), bool, proc, pascal, proc
    GetClientRect(unsigned, *winRECTtype), bool, raw, proc, pascal
    MapWindowRECT(unsigned, unsigned, *winRECTtype, unsigned=2), signed, raw, pascal, proc, name('MapWindowPoints')
    GetSystemMetrics(signed), signed, pascal
    GetOpenFileName(*group), pascal, bool, proc, raw, name('GetOpenFileNameA')
    !
    CreateEnhMetaFileA(unsigned, unsigned=0, unsigned=0, unsigned=0), unsigned, pascal, raw
    DeleteEnhMetaFile(unsigned), bool, pascal
    CloseEnhMetaFile(unsigned), unsigned, pascal
    PlayEnhMetaFile(unsigned, unsigned, *RectType), bool, pascal, raw
    CopyEnhMetaFileA(unsigned, *cstring), unsigned, pascal, raw
    GetEnhMetaFileHeader(unsigned, unsigned, *winEnhMetaHeaderType), unsigned, raw, pascal
    SetWinMetaFileBits(unsigned, *string, unsigned=0, unsigned=0), unsigned, raw, pascal
    DPtoLP(unsigned, *PointType, signed), bool, pascal, raw
    !
    CreateMetaFile(unsigned=0), unsigned, pascal, raw, name('CreateMetaFileA')
    CloseMetaFile(unsigned), unsigned, pascal
    GetMetaFileBitsEx(unsigned, unsigned=0, unsigned=0), unsigned, pascal
    CopyMetaFile(unsigned, *cstring), unsigned, pascal, raw, name('CopyMetaFileA')
    DeleteMetaFile(unsigned), bool, pascal
    !
    _ellipse(unsigned hdc, signed nLeftRect, signed nTopRect, signed nRightRect, signed nBottomRect), bool, pascal, name('Ellipse')
    Rectangle(unsigned, signed, signed, signed, signed), bool, pascal
  end
  module('ClaAPI')
    FnSplit(*cstring, *cstring, *cstring, *cstring, *cstring), signed, raw, proc, name('_fnsplit')
    FnMerge(*cstring, *cstring, *cstring, *cstring, *cstring), raw, name('_fnmerge')
    DrawCopy(unsigned), name('Wsl$DrawCopy')
    WriteMetaFile(unsigned, const *cstring, unsigned, *winPOINT), raw, name('Wsl$WriteMetaFile')
  end
    END
GraphTextClass.Destruct             procedure
 code
  self.eText &= null
!
GraphTextClass.Init                 procedure(iText parIText)
 code
  self.iText &= parIText
  self.Init
!
GraphTextClass.Init                 procedure
savItext  &iText
 code
  savItext &= self.iText
  clear(self)
  self.iText &= savIText
  self.gBgr.eColor = color:none
  self.gBgr.eColor2 = color:none
  self.gBgr.eStyle = 0
  self.eBorderColor = color:none
  self.eFontColor = color:auto
!
GraphTextClass.SetText              procedure(string parText)
 code
  self.eText = clip(parText)
!
GraphTextClass.AddText              procedure(string parText, <string parSep>)
 code
  if ~self.eText
    self.eText = parText
  else
    if omitted(3)
      self.eText = self.eText & parText
    else
      self.eText = self.eText & parSep & parText
    end
  end
!
GraphTextClass.SetFont              procedure(<string parFontName>, <long parFontSize>, |
                                              <long parFontColor>, <long parFontStyle>, <long parCharSet>)
 code
  if ~omitted(2) then self.eFontName  = parFontName end
  if ~omitted(3) then self.eFontSize  = parFontSize end
  if ~omitted(4) then self.eFontColor = parFontColor end
  if ~omitted(5) then self.eFontStyle = parFontStyle end
  if ~omitted(6) then self.eCharSet   = parCharSet end
!
GraphTextClass.SetBgr               procedure(<long parColor>, <long parColor2>, <long parStyle>)
 code
  if ~omitted(2) then self.gBgr.eColor = parColor end
  if ~omitted(3) then self.gBgr.eColor2 = parColor2 end
  if ~omitted(4) then self.gBgr.eStyle = parStyle end
!
GraphTextClass.SetBorder            procedure(long parColor=color:none)
 code
  self.eBorderColor = parColor
!
GraphTextClass.SetAlignment         procedure(long parValue)
 code
  self.eAlignment = parValue
!
GraphTextClass.SetAngle             procedure(real parAngle)
 code
  self.eAngle = parAngle
!
GraphTextClass.SetRectangle         procedure(<real parX>, <real parY>, <real parW>, <real parH>)
 code
  if ~omitted(2) then self.eX = parX end
  if ~omitted(3) then self.eY = parY end
  if ~omitted(4) then self.eW = parW end
  if ~omitted(5) then self.eH = parH end
!
GraphTextClass.Calculate            procedure
locFont         like(gFontType)
 code
  if ~self.eText
    clear(self.eTextW)
    clear(self.eTextH)
  else
    if self.iText &= null then return end
    self.iText.PushFont
    locFont.eFontName  = choose(~self.eFontName,self.iText.FParent(){prop:FontName},self.eFontName)
    locFont.eFontSize  = choose(~self.eFontSize,self.iText.FParent(){prop:FontSize},self.eFontSize)
    locFont.eFontColor = self.eFontColor
    locFont.eFontStyle = self.eFontStyle
    locFont.eCharSet   = self.eCharSet
    self.iText.Setfont(locFont)
    self.iText.GetTextPoint(0, self.eText, self.eTextW, self.eTextH)
    if ~self.eW then self.eW = self.eTextW end
    if ~self.eH then self.eH = self.eTextH end
    self.iText.PopFont
  end
!
GraphTextClass.Draw                 procedure
locFont         like(gFontType)
locX            real, auto
locY            real, auto
 code
  if self.iText &= null then return end
  self.iText.PushStyle
  self.iText.PushFont
  locFont.eFontName  = choose(~self.eFontName,self.iText.FParent(){prop:FontName},self.eFontName)
  locFont.eFontSize  = choose(~self.eFontSize,self.iText.FParent(){prop:FontSize},self.eFontSize)
  locFont.eFontColor = choose(self.eFontColor=color:auto,color:windowtext,self.eFontColor)
  locFont.eFontStyle = self.eFontStyle
  locFont.eCharSet   = self.eCharSet
  self.iText.Setfont(locFont)
  !
  if self.gBgr.eColor <> color:none or self.eBorderColor <> color:none
    if self.eBorderColor <> color:none
      self.iText.SetStyle(self.eBorderColor)
    elsif self.gBgr.eColor <> color:none
      self.iText.SetStyle(self.gBgr.eColor)
    end
    self.iText.Box(self.eX, self.eY, self.eW, self.eH, self.gBgr)
  end
  locX = self.eX
  case band(self.eAlignment,11b)
  of Alignment:Left
  of Alignment:Right
    locX += choose(self.eW > self.eTextW, self.eW-self.eTextW, 0)
  else
    locX += choose(self.eW > self.eTextW, (self.eW-self.eTextW)/2, 0)
  end
  locY = self.eY + choose(self.iText.FactorYb() < 0, self.eTextH, 0)
  case band(self.eAlignment,1100b)
  of Alignment:Top
    locY += choose(self.eH > self.eTextH, self.eH-self.eTextH, 0)
  of Alignment:Bottom
  else
    locY += choose(self.eH > self.eTextH, (self.eH-self.eTextH)/2, 0)
  end
  show(self.iText.ToX(locX), self.iText.ToY(locY), self.eText)
  self.iText.PopFont
  self.iText.PopStyle
!
GraphNodeClass.Construct            procedure
 code
  if self.oText &= null then self.oText &= new(GraphTextClass) end
!
GraphNodeClass.Destruct             procedure
 code
  if ~(self.oText &= null) then dispose(self.oText) end
!
GraphNodeClass.Init                 procedure(qNodeType parQ, iNode parINode, iText parIText)
 code
  self.qNode &= parQ
  self.iNode &= parINode
  self.oText.Init(parIText)
  self.SetDefault
!
GraphNodeClass.Init                 procedure
 code
  if self.eToShowLabel                              ! If to show a name then
    self.oText.SetText(self.iNode.NodeNameText())
  end
  if self.eToShowValue                              ! If to show a value then
    self.oText.AddText(self.qNode.gXY.eY, ' ')
  end
  self.oText.SetBgr(choose(~self.eToShowBgr,color:none, self.iNode.TextBgr()))
  self.oText.SetBorder(self.iNode.TextBorder())
  self.oText.SetRectangle(self.gRec.eX + self.eRadius, self.gRec.eY)
  self.oText.Calculate
!
GraphNodeClass.SetDefault           procedure
 code
  self.eType = 0                                    ! Type of the Node
  clear(self.gRec)                                  ! Rectangle for drawing
  clear(self.gFill)
!
GraphNodeClass.SetRectangle         procedure(<real parX>, <real parY>, <real parW>, <real parH>)
 code
  if ~omitted(2) then self.gRec.eX = parX end
  if ~omitted(3) then self.gRec.eY = parY end
  if ~omitted(4) then self.gRec.eW = parW end
  if ~omitted(5) then self.gRec.eH = parH end
!
GraphNodeClass.SetFill              procedure(gFillType parFill)
 code
  self.gFill = parFill
!
GraphNodeClass.InNode               procedure(real parX, real parY)
locDelta        real, auto
locRet          bool
 code
  locDelta = self.iNode.SensitivityRadius()
  if locDelta < 3
    locDelta = abs(self.iNode.ToLW(3))
  else
    locDelta = abs(self.iNode.ToLW(locDelta))
  end
  if locDelta < self.eRadius then locDelta = self.eRadius end
  !
  if self.eType ~= NodeType:None
    locRet = self.iNode.inbox(parX, parY, self.gRec.eX-locDelta, self.gRec.eY-locDelta, locDelta*2, locDelta*2)
  end
  !
  return locRet
!
GraphNodeClass.Draw                 procedure
 code
  if self.eHide then return end                     ! Don't display node
  if self.iNode.Null(self.qNode) then return end
  case self.eType
  of NodeType:None                                  ! Invisible
  of NodeType:Square                                ! Square
    self.iNode.CPolygon(self.gRec.eX, self.gRec.eY, self.eRadius, 90, 4, self.gFill)
  of NodeType:Triangle                              ! Triangle
    self.iNode.CPolygon(self.gRec.eX, self.gRec.eY, self.eRadius, 90, 3, self.gFill)
  else                                              ! Circle (NodeType:Circle)
    self.iNode.Circle(self.gRec.eX, self.gRec.eY, self.eRadius, self.gFill)
  end
  if self.eToShowMinMax                             ! To show a minimum and maximum
    self.DrawMinMax
  end
  self.oText.Draw()
!
GraphNodeClass.DrawMinMax           procedure
locFill       like(gFillType)
locWindow     &window
locRadius     real
 code
  if self.iNode.Null(self.qNode) then return end
  if self.qNode.eID ~= self.iNode.MinID() and self.qNode.eID ~= self.iNode.MaxID()
    return
  end
  self.iNode.PushStyle
  locRadius = self.eRadius
  locWindow &= (self.iNode.Window())
  if ~(locWindow &= null)
    if locWindow{prop:type} = create:report
      locRadius += choose(locRadius < 1, 1, locRadius)
    else
      locRadius += 2
    end

    self.iNode.SetStyle(self.gFill.eColor)
    case self.eType                                   ! Node type
    of NodeType:Square                                ! Square
      self.iNode.CPolygon(self.gRec.eX, self.gRec.eY, locRadius, 90, 4, locFill)
    of NodeType:Triangle                              ! Triangle
      self.iNode.CPolygon(self.gRec.eX, self.gRec.eY, locRadius, 90, 3, locFill)
    else                                              ! Circle (NodeType:Circle)
      self.iNode.Circle(self.gRec.eX, self.gRec.eY, locRadius, locFill)
    end
  end
  self.iNode.PopStyle
GraphPieClass.SetDefault            procedure
 code
  parent.SetDefault
  clear(self.eSliceSum)
  self.eDepth = 20
!
GraphPieClass.Draw                  procedure       ! Pie
lq                  qPieType
 code
  if self.iDiagram.Null(self.qGraph.qNode) then return end
  self.iDiagram.Set(self.qGraph.qNode)
  loop until self.iDiagram.Next(self.qGraph.qNode)  ! Cycle through the nodes
    lq.eSlice = self.iDiagram.AToLY(self.qGraph.qNode.gXY.eY)
    lq.gFill = self.qGraph.qNode.gFill
    add(lq)
    if self.iDiagram.ErrCode(errorcode()) then return end
  end
  self.iDiagram.Pie(self.gRec.eX, self.gRec.eY, self.gRec.eW, self.gRec.eH, lq, self.eDepth)
  !
  if self.eDrawNode                                 ! Draw the node
    self.DrawNode
  end
!
GraphPieClass.CalcNode              procedure
locLY         real, auto
locAlpha      real, auto
 code
  locLY = self.iDiagram.AToLY(self.qGraph.qNode.gXY.eY)
  if self.eSliceSum <> 0
    locAlpha = (equ:DegToRad*360/self.eSliceSum)*(self.eSumForPie + locLY/2)
  else
    locAlpha = 0
  end
  self.qGraph.qNode.oNode.SetRectangle(|
                    self.gRec.eX + (abs(self.gRec.eW) / 2)*(1 + sin(locAlpha) * 2/3), |
                    self.gRec.eY + self.eDepth + (abs(self.gRec.eH - self.eDepth) / 2)*(1 + cos(locAlpha) * 2/3))
  self.qGraph.qNode.oNode.gFill.eColor = color:black
  self.eSumForPie += locLY
!
GraphPieClass.InDiagram             procedure(real parX, real parY)
locA            real, auto
locB            real, auto
locAngle        real, auto
locAngleIn      real, auto
locSum          real
locAlphaB       real, auto
locAlphaE       real, auto
locSlice        long
savPointer      long, auto
 code
  locA = self.gRec.eW / 2
  locB = (self.gRec.eH - self.eDepth) / 2
  if locA and locB
    ! Correction of coordinates
    parX -= self.gRec.eX + locA
    parY -= self.gRec.eY + self.eDepth + locB
    if (parX^2/locA^2 + parY^2/locB^2) <= 1         ! If inside an ellipse then
      locAngle = equ:DegToRad*360/self.eSliceSum    ! Angle of one unit
      locAngleIn = self.iDiagram.Rad(parX, parY)
      savPointer = pointer(self.qGraph.qNode)
      self.iDiagram.Set(self.qGraph.qNode)
      loop until self.iDiagram.Next(self.qGraph.qNode) ! Cycle through the nodes
        locAlphaB = locSum*locAngle
        locAlphaE = locAlphaB + locAngle*self.iDiagram.AToLY(self.qGraph.qNode.gXY.eY)
        if inrange(locAngleIn, |
                    self.iDiagram.Rad(locA*sin(locAlphaB),locB*cos(locAlphaB)), |
                    self.iDiagram.Rad(locA*sin(locAlphaE),locB*cos(locAlphaE)))
          locSlice = self.qGraph.qNode.eID
          break
        end
        locSum += self.iDiagram.AToLY(self.qGraph.qNode.gXY.eY)
      end
      self.iDiagram.Set(self.qGraph.qNode, savPointer)
    end
  end
  ! Returns the number of sector
  return locSlice
!
GraphBarWithAccumulationClass.CalcNode procedure
 code
  if ~self.iDiagram.ClusterSearch(self.qGraph.qNode.eClusterID)
    self.qGraph.qNode.oNode.SetRectangle(self.gRec.eX + self.iDiagram.ClusterSumH(), |
                                         self.iDiagram.ClusterPos(),, |
                                         self.iDiagram.AToLX(self.qGraph.qNode.gXY.eY-self.iDiagram.AxesMinY()))
    case self.eSubType
    of GraphSubType:Normalized
      self.qGraph.qNode.oNode.gRec.eH *= (self.iDiagram.ClusterSumYmax() / self.iDiagram.ClusterSumY())
    end
    self.qGraph.qNode.oNode.gRec.eH = self.iDiagram.ToLH(self.iDiagram.ToH(self.qGraph.qNode.oNode.gRec.eH))
    self.iDiagram.ClusterSumH(self.iDiagram.ClusterSumH()+self.qGraph.qNode.oNode.gRec.eH)
  end
!
GraphFloatingBarClass.Draw          procedure       ! The floating bar
 code
  if pointer(self.qGraph) % 2 and pointer(self.qGraph)<>records(self.qGraph)
    parent.Draw
  end
!
GraphFloatingBarClass.CalcNode      procedure
savNodePointer    long
locPos            real, auto
locLen            real, auto
 code
  if pointer(self.qGraph) % 2
    if ~self.iDiagram.ClusterSearch(self.qGraph.qNode.eClusterID)
      savNodePointer = pointer(self.qGraph.qNode)
      locPos = self.iDiagram.AToLX(self.qGraph.qNode.gXY.eY-self.iDiagram.AxesMinY())
      locLen = self.qGraph.qNode.gXY.eY
      ! The second value
      if ~self.iDiagram.Next(self.qGraph)
        if ~self.iDiagram.Set(self.qGraph.qNode, savNodePointer)
          locLen = self.iDiagram.AToLX(abs(locLen - self.qGraph.qNode.gXY.eY))
          if locPos > self.iDiagram.AToLX(self.qGraph.qNode.gXY.eY-self.iDiagram.AxesMinY())
            locPos = self.iDiagram.AToLX(self.qGraph.qNode.gXY.eY-self.iDiagram.AxesMinY())
          end
        end
        self.iDiagram.Previous(self.qGraph)         ! Restoration of the pointer
        self.iDiagram.Set(self.qGraph.qNode, savNodePointer)
      end
      self.qGraph.qNode.oNode.SetRectangle(self.gRec.eX + locPos, self.iDiagram.ClusterPos(),,locLen)
      self.iDiagram.ClusterPos(self.iDiagram.ClusterPos() + self.eBarRadius * 2 * (1 - self.iDiagram.BarOverlap()))
    end
  end
!
GraphFloatingBarClass.InDiagram     procedure(real parX, real parY)
 code
  if ~(pointer(self.qGraph) % 2) or pointer(self.qGraph)=records(self.qGraph) then return 0 end
  return parent.InDiagram(parX, parY)
!
GraphBarClass.Draw                  procedure
 code
  self.iDiagram.Set(self.qGraph.qNode)
  loop until self.iDiagram.Next(self.qGraph.qNode)  ! Cycle through the nodes
    if self.qGraph.qNode.oNode &= null then cycle end
    if ~self.qGraph.qNode.eClusterID then cycle end
    case self.eFigure
    of FigureType:Cylinder
      self.iDiagram.HCylinder(self.qGraph.qNode.oNode.gRec.eX, self.qGraph.qNode.oNode.gRec.eY, |
                              self.qGraph.qNode.oNode.gRec.eH, |
                              self.eBarRadius, self.eDepth, self.gFill)
    else
      self.iDiagram.HBar(self.qGraph.qNode.oNode.gRec.eX, self.qGraph.qNode.oNode.gRec.eY, |
                         self.qGraph.qNode.oNode.gRec.eH, |
                         self.eBarRadius, self.eDepth, self.gFill)
    end
  end
!
GraphBarClass.SetDefault            procedure
 code
  parent.SetDefault
  self.eBarRadius = 0
  self.eDepth = 0
  self.eFigure = 0                                  ! Figure for drawing
!
GraphBarClass.CalcNode              procedure
 code
  if ~self.iDiagram.ClusterSearch(self.qGraph.qNode.eClusterID)
    self.qGraph.qNode.oNode.SetRectangle(self.gRec.eX, self.iDiagram.ClusterPos(),, |
                                         self.iDiagram.AToLX(self.qGraph.qNode.gXY.eY-self.iDiagram.AxesMinY()))
    self.iDiagram.ClusterPos(self.iDiagram.ClusterPos()+self.eBarRadius*2*(1-self.iDiagram.BarOverlap()))
  end
!
GraphBarClass.InDiagram             procedure(real parX, real parY)
locID             long
savNodePointer    long, auto
 code
  if self.iDiagram.Null(self.qGraph.qNode) then return 0 end
  savNodePointer = pointer(self.qGraph.qNode)
  self.iDiagram.Set(self.qGraph.qNode)
  loop until self.iDiagram.Next(self.qGraph.qNode)  ! Cycle through the nodes
    if self.qGraph.qNode.oNode &= null then cycle end
    case self.eFigure
    of FigureType:Cylinder
      if ~self.iDiagram.InHCylinder(parX, parY, |
                                    self.qGraph.qNode.oNode.gRec.eX, self.qGraph.qNode.oNode.gRec.eY, |
                                    self.qGraph.qNode.oNode.gRec.eH, self.eBarRadius, self.eDepth)
        cycle
      end
    else
      if ~self.iDiagram.Inbox(parX, parY, |
                              self.qGraph.qNode.oNode.gRec.eX, self.qGraph.qNode.oNode.gRec.eY, |
                              self.qGraph.qNode.oNode.gRec.eH, self.eBarRadius*2, self.eDepth)
        cycle
      end
    end
    locID = self.qGraph.qNode.eID
    break
  end
  self.iDiagram.Set(self.qGraph.qNode, savNodePointer)
  return locID                                      ! Returns the number of node
!
GraphColumnWithAccumulationClass.CalcNode procedure
 code
  if ~self.iDiagram.ClusterSearch(self.qGraph.qNode.eClusterID)
    self.qGraph.qNode.oNode.SetRectangle(self.iDiagram.ClusterPos(), self.gRec.eY + self.iDiagram.ClusterSumH())
    case self.eSubType
    of GraphSubType:Normalized
      self.qGraph.qNode.oNode.gRec.eH *= (self.iDiagram.ClusterSumYmax() / self.iDiagram.ClusterSumY())
    end
    self.qGraph.qNode.oNode.gRec.eH = self.iDiagram.ToLH(self.iDiagram.ToH(self.qGraph.qNode.oNode.gRec.eH))
    self.iDiagram.ClusterSumH(self.iDiagram.ClusterSumH() + self.qGraph.qNode.oNode.gRec.eH)
  end
!
GraphFloatingColumnClass.Draw       procedure       ! The floating column
 code
  if pointer(self.qGraph) % 2 and pointer(self.qGraph)<>records(self.qGraph)
    parent.Draw
  end
!
GraphFloatingColumnClass.CalcNode   procedure
savNodePointer    long
locYpos           real, auto
locLen            real, auto
 code
  if pointer(self.qGraph) % 2
    if ~self.iDiagram.ClusterSearch(self.qGraph.qNode.eClusterID)
      savNodePointer = pointer(self.qGraph.qNode)
      locYpos = self.qGraph.qNode.oNode.gRec.eH
      locLen  = self.qGraph.qNode.gXY.eY
      ! The second value
      if ~self.iDiagram.Next(self.qGraph)
        if ~self.iDiagram.Set(self.qGraph.qNode, savNodePointer)
          locLen = self.iDiagram.AToLY(abs(locLen - self.qGraph.qNode.gXY.eY)) ! Height of a column
          if locYpos > self.iDiagram.AToLY(self.qGraph.qNode.gXY.eY-self.iDiagram.AxesMinY()) ! Minimum
            locYpos = self.iDiagram.AToLY(self.qGraph.qNode.gXY.eY-self.iDiagram.AxesMinY())
          end
        end
        self.iDiagram.Previous(self.qGraph)         ! Restoration of the pointer
        self.iDiagram.Set(self.qGraph.qNode, savNodePointer)
      end
      self.qGraph.qNode.oNode.SetRectangle(self.iDiagram.ClusterPos(), self.gRec.eY + locYpos,, locLen)
      self.iDiagram.ClusterPos(self.iDiagram.ClusterPos() + self.eBarRadius*2*(1 - self.iDiagram.BarOverlap()))
    end
  end
!
GraphFloatingColumnClass.InDiagram  procedure(real parX, real parY)
 code
  if ~(pointer(self.qGraph) % 2) or pointer(self.qGraph)=records(self.qGraph) then return 0 end
  return parent.InDiagram(parX, parY)
!
GraphColumnClass.Draw               procedure       ! Columns
 code
  self.iDiagram.Set(self.qGraph.qNode)
  loop until self.iDiagram.Next(self.qGraph.qNode)  ! Cycle through the nodes
    if self.qGraph.qNode.oNode &= null then cycle end
    if ~self.qGraph.qNode.eClusterID then cycle end
    case self.eFigure
    of FigureType:Cylinder
      self.iDiagram.VCylinder(self.qGraph.qNode.oNode.gRec.eX, self.qGraph.qNode.oNode.gRec.eY, |
                              self.qGraph.qNode.oNode.gRec.eH, |
                              self.eBarRadius, self.eDepth, self.gFill)
    else
      self.iDiagram.VBar(self.qGraph.qNode.oNode.gRec.eX, self.qGraph.qNode.oNode.gRec.eY, |
                         self.qGraph.qNode.oNode.gRec.eH, |
                         self.eBarRadius, self.eDepth, self.gFill)
    end
  end
!
GraphColumnClass.SetDefault         procedure
 code
  parent.SetDefault
  self.eBarRadius = 0
  self.eDepth = 0
  self.eFigure = 0                                  ! Figure for drawing
!
GraphColumnClass.CalcNode           procedure
 code
  if ~self.iDiagram.ClusterSearch(self.qGraph.qNode.eClusterID)
    self.qGraph.qNode.oNode.SetRectangle(self.iDiagram.ClusterPos(), self.gRec.eY)
    self.iDiagram.ClusterPos(self.iDiagram.ClusterPos() + self.eBarRadius*2*(1 - self.iDiagram.BarOverlap()))
  end
!
GraphColumnClass.InDiagram          procedure(real parX, real parY)
locID             long
savNodePointer    long, auto
 code
  if self.iDiagram.Null(self.qGraph.qNode) then return 0 end
  savNodePointer = pointer(self.qGraph.qNode)
  self.iDiagram.Set(self.qGraph.qNode)
  loop until self.iDiagram.Next(self.qGraph.qNode)  ! Cycle through the nodes
    if self.qGraph.qNode.oNode &= null then cycle end
    case self.eFigure
    of FigureType:Cylinder
      if ~self.iDiagram.InVCylinder(parX, parY, |
                                    self.qGraph.qNode.oNode.gRec.eX, self.qGraph.qNode.oNode.gRec.eY, |
                                    self.qGraph.qNode.oNode.gRec.eH, self.eBarRadius, self.eDepth)
        cycle
      end
    else
      if ~self.iDiagram.Inbox(parX, parY, |
                              self.qGraph.qNode.oNode.gRec.eX, self.qGraph.qNode.oNode.gRec.eY, |
                              self.eBarRadius*2, self.qGraph.qNode.oNode.gRec.eH, self.eDepth)
        cycle
      end
    end
    locID = self.qGraph.qNode.eID
    break
  end
  self.iDiagram.Set(self.qGraph.qNode, savNodePointer)
  return locID                                      ! Returns the number of node
!
GraphFloatingAreaClass.Draw         procedure       ! The floating area
lq            qXYType
savXY         like(gXYType)
 code
  if ~(pointer(self.qGraph) % 2) or pointer(self.qGraph)=records(self.qGraph)
     return
  end
  self.iDiagram.Set(self.qGraph.qNode)
  loop until self.iDiagram.Next(self.qGraph.qNode)  ! Cycle through the nodes
    do r:AddItem
  end
  if ~self.iDiagram.Next(self.qGraph)
    if ~self.iDiagram.Set(self.qGraph.qNode,-1)
      do r:AddItem
      loop until self.iDiagram.Previous(self.qGraph.qNode)
        do r:AddItem
      end
    end
    self.iDiagram.Polygon(lq, self.gFill)           ! Draw polygon
    if self.eDrawLine
      ! Draw the line
      self.iDiagram.Previous(self.qGraph)
      self.iDiagram.SetStyle(self.gFill.eColor)     ! Colour of the Diagram
      parent.Draw
      self.iDiagram.Next(self.qGraph)
      self.iDiagram.SetStyle(self.gFill.eColor)     ! Colour of the Diagram
      parent.Draw
    elsif self.eDrawNode                            ! Draw the node
      self.DrawNode
    end
  end
!
r:AddItem         routine
  lq.eX = self.gRec.eX + self.iDiagram.AToLX(self.qGraph.qNode.gXY.eX-self.iDiagram.AxesMinX())
  lq.eY = self.gRec.eY + self.iDiagram.AToLY(self.qGraph.qNode.gXY.eY-self.iDiagram.AxesMinY())
  add(lq)
  if self.iDiagram.ErrCode(errorcode()) then return end
!
GraphFloatingAreaClass.SetDefault   procedure
 code
  parent.SetDefault
  self.eDrawLine = true
!
GraphAreaClass.Draw                 procedure
lq            qXYType
 code
  if self.iDiagram.Null(self.qGraph.qNode) then return end
  ! Creating coordinates list for the Polygon
  self.iDiagram.Set(self.qGraph.qNode)
  loop until self.iDiagram.Next(self.qGraph.qNode)  ! Cycle through the nodes
    lq.eX = self.gRec.eX + self.iDiagram.AToLX(self.qGraph.qNode.gXY.eX-self.iDiagram.AxesMinX())
    lq.eY = self.gRec.eY + self.iDiagram.AToLY(self.qGraph.qNode.gXY.eY-self.iDiagram.AxesMinY())
    add(lq)
    if self.iDiagram.ErrCode(errorcode()) then return end
  end
  ! So as figure's lower border pass through the axis, add extra two coordinates
  ! to the head and to the tail of list
  if ~self.iDiagram.Set(lq, -1)
    lq.eY = self.gRec.eY
    add(lq)
    if self.iDiagram.ErrCode(errorcode()) then return end
    self.iDiagram.Set(lq, 1)
    lq.eY = self.gRec.eY
    add(lq, 1)
    if self.iDiagram.ErrCode(errorcode()) then return end
  end
  self.iDiagram.Polygon(lq, self.gFill)             ! Draw polygon
  if self.eDrawLine                                 ! Draw the line
    self.iDiagram.SetStyle(self.gFill.eColor)       ! Colour of the Diagram
    parent.Draw
  elsif self.eDrawNode                              ! Draw the node
    self.DrawNode
  end
!
GraphAreaClass.SetDefault           procedure
 code
  parent.SetDefault
  self.eDrawLine = true
!
GraphLineClass.Draw                 procedure
savXY         like(gXYType)
 code
  if ~self.iDiagram.Set(self.qGraph.qNode, 1)
    self.iDiagram.SetStyle(self.gFill.eColor)       ! Colour of the Diagram
    savXY = self.qGraph.qNode.gXY
    loop until self.iDiagram.Next(self.qGraph.qNode) ! Cycle through the nodes
      ! Draw line from previous node to current
      self.iDiagram.XYline( self.gRec.eX + self.iDiagram.AToLX(savXY.eX-self.iDiagram.AxesMinX()), |
                            self.gRec.eY + self.iDiagram.AToLY(savXY.eY-self.iDiagram.AxesMinY()), |
                            self.gRec.eX + self.iDiagram.AToLX(self.qGraph.qNode.gXY.eX-self.iDiagram.AxesMinX()), |
                            self.gRec.eY + self.iDiagram.AToLY(self.qGraph.qNode.gXY.eY-self.iDiagram.AxesMinY()))
      savXY = self.qGraph.qNode.gXY
    end
    if self.eDrawNode                               ! Draw the node
      self.DrawNode
    end
  end
!
GraphLineClass.SetDefault           procedure
 code
  parent.SetDefault
  self.eDrawNode = true
!
GraphScatterClass.Draw              procedure
 code
  self.iDiagram.SetStyle(self.gFill.eColor)         ! Colour of the Diagram
  self.DrawNode                                     ! Draw the node
!
GraphDiagramClass.Init              procedure(qGraphType parQ, iDiagram parIDiagram)
 code
  self.qGraph &= parQ
  self.iDiagram &= parIDiagram
  self.SetDefault
!
GraphDiagramClass.SetRectangle      procedure(<real parX>, <real parY>, <real parW>, <real parH>)
 code
  if ~omitted(2) then self.gRec.eX = parX end
  if ~omitted(3) then self.gRec.eY = parY end
  if ~omitted(4) then self.gRec.eW = parW end
  if ~omitted(5) then self.gRec.eH = parH end
!
GraphDiagramClass.SetFill           procedure(gFillType parFill)
 code
  self.gFill = parFill
!
GraphDiagramClass.Draw              procedure
 code
!
GraphDiagramClass.CalcNode          procedure
 code
!
GraphDiagramClass.DrawNode          procedure       ! Draw current node
 code
  self.iDiagram.Set(self.qGraph.qNode)
  loop until self.iDiagram.Next(self.qGraph.qNode) ! Cycle through the nodes
    if ~(self.qGraph.qNode.oNode &= null)
      self.qGraph.qNode.oNode.Draw
    end
  end
!
GraphDiagramClass.InDiagram         procedure(real parX, real parY)
locID             long
savNodePointer    long, auto
 code
  savNodePointer = pointer(self.qGraph.qNode)
  self.iDiagram.Set(self.qGraph.qNode)
  loop until self.iDiagram.Next(self.qGraph.qNode)  ! Cycle through the nodes
    if ~(self.qGraph.qNode.oNode &= null)
      if self.qGraph.qNode.oNode.InNode(parX, parY)
        locID = self.qGraph.qNode.eID
        break
      end
    end
  end
  self.iDiagram.Set(self.qGraph.qNode, savNodePointer)
  return locID                                      ! Returns the number of node
!
GraphDiagramClass.SetDefault        procedure
 code
  self.eType = 0                                    ! Type of the Diagram
  self.eSubType = 0                                 ! Subtype of the Diagram
  clear(self.gRec)                                  ! Rectangle for drawing
  clear(self.gFill)

  self.eDrawNode = true
  self.eDrawNodeMinMax = true
  self.eNodeMinID = 0                               ! Number of node having the minimal value Y
  self.eNodeMaxID = 0                               ! Number of node having the maximal value Y
  !
  clear(self.eSumForPie)
GraphTitleClass.Init                procedure(iText parIText)
 code
  parent.Init(parIText)
!
GraphTitleClass.Calculate           procedure       ! Calculate title properties
 code
  parent.Calculate
  ! Centring on X ; place on the top on Y
  self.SetRectangle(choose(self.gRec.eW=0, 0, self.gRec.eW/2-self.eW/2), choose(self.gRec.eH=0, 0, self.gRec.eH-self.eH))
!
GraphTitleClass.Draw                procedure       ! Display diagram title
 code
  if ~self.eHide
    parent.Draw
  end
!
GraphLegendClass.construct          procedure
 code
  if self.qLegend &= null then self.qLegend &= new(qLegendType) end
  free(self.qLegend) ; clear(self.qLegend)
!
GraphLegendClass.destruct           procedure
 code
  if ~(self.qLegend &= null)
    self.iLegend.Set(self.qLegend)
    loop until self.iLegend.Next(self.qLegend)
      self.qLegend.eText &= null
    end
    dispose(self.qLegend)
  end
!
GraphLegendClass.Init               procedure(*iLegend parILegend, *qGraphType parQGraph)
 code
  self.iLegend &= parILegend
  self.qGraph &= parQGraph
  self.Init
!
GraphLegendClass.Init               procedure
sav:iLegend     &iLegend
sav:qGraph      &qGraphType
sav:qLegend     &qLegendType
 code
  sav:iLegend &= self.iLegend
  sav:qGraph &= self.qGraph
  sav:qLegend &= self.qLegend
  clear(self)
  self.iLegend &= sav:iLegend
  self.qGraph &= sav:qGraph
  self.qLegend &= sav:qLegend
  self.eCellPadding = 1
!
GraphLegendClass.Calculate          procedure
! Calculate legend
 code
  clear(self.gPos)
  if self.ePosition = LegendPosition:None then return end
  self.iLegend.PushStyle
  self.iLegend.SetStyle
  self.iLegend.PushFont
  free(self.qLegend)
  clear(self.qLegend)
  ! Initial dimensions of the legend
  self.gPos.eW = self.gRec.eW-self.gDist.eL-self.gDist.eR
  self.gPos.eH = self.gRec.eH-self.gDist.eT-self.gDist.eB
  !
  self.iLegend.GetFont(self.gFont)
  self.BuildqLegend                                 ! Creating legend parameters list
  self.CountRows                                    ! Count rows number
  self.Optimize                                     ! Calculation of the optimum sizes of a legend
  self.PosLegend                                    ! Positioning of a legend
  !
  self.iLegend.PopFont
  self.iLegend.PopStyle
!
GraphLegendClass.BuildqLegend       procedure       ! Creating legend parameters list
locI      long
 code
  if self.iLegend.Null(self.qGraph) then return end
  case self.iLegend.GraphType()
  of GraphType:PieChart
    do r:PieChart
  of GraphType:FloatingColumn
  orof GraphType:FloatingBar
    do r:Floating
  else
    do r:Other
  end
!
r:Add       routine
  clear(self.qLegend)
  self.qLegend.eID = records(self.qLegend) + 1
  self.qLegend.eText = self.qGraph.eName
  self.iLegend.SetFont(self.gFont)
  self.iLegend.GetTextPoint(0, self.qLegend.eText, self.qLegend.eW, self.qLegend.eH)
  self.qLegend.eBoxType = 1
  self.qLegend.eBoxR = round(self.qLegend.eH/4,1)
  self.qLegend.gBoxFill = self.qGraph.gFill
  self.qLegend.eW += self.qLegend.eBoxR*4
  self.qLegend.eRow = 1
  add(self.qLegend, +self.qLegend.eID)
!
r:Floating  routine
  loop locI = 1 to records(self.qGraph)-1 by 2
    if self.iLegend.Set(self.qGraph, locI) then break end
    do r:Add
  end
!
r:PieChart  routine
  if ~self.iLegend.Set(self.qGraph,-1)
    self.iLegend.Set(self.qGraph.qNode)
    loop until self.iLegend.Next(self.qGraph.qNode)
      clear(self.qLegend)
      self.qLegend.eID = records(self.qLegend) + 1
      self.qLegend.eText = self.qGraph.qNode.eName
      self.iLegend.SetFont(self.gFont)
      self.iLegend.GetTextPoint(0, self.qLegend.eText, self.qLegend.eW, self.qLegend.eH)
      self.qLegend.eBoxType = 1
      self.qLegend.eBoxR = round(self.qLegend.eH/4,1)
      if self.qGraph.qNode.gFill.eColor = color:auto
        self.qLegend.gBoxFill.eColor = self.iLegend.NextColor(pointer(self.qGraph.qNode))
      else
        self.qLegend.gBoxFill.eColor = self.qGraph.qNode.gFill.eColor
      end
      self.qLegend.eW += self.qLegend.eBoxR*4
      self.qLegend.eRow = 1
      add(self.qLegend)
    end
  end
!
r:Other     routine
  self.iLegend.Set(self.qGraph)
  loop until self.iLegend.Next(self.qGraph)
    do r:Add
  end
!
GraphLegendClass.CountRows          procedure       ! Count rows number
locValue          real
 code
  self.eRows = 1                                    ! Min. values
  self.eCols = 1
  self.iLegend.Set(self.qLegend)
  loop until self.iLegend.Next(self.qLegend)
    case self.ePosition
    of LegendPosition:left
    orof LegendPosition:right
      locValue += self.qLegend.eH + 2*self.eCellPadding
      if locValue => self.gPos.eH then break end
      if pointer(self.qLegend) = 1 then cycle end
    of LegendPosition:Top
    orof LegendPosition:Bottom
      locValue += self.qLegend.eW + 2*self.eCellPadding
      if locValue <= self.gPos.eW then cycle end
      locValue = 0
    end
    self.eRows += 1
  end
!
GraphLegendClass.Optimize           procedure
locRi         long
savP          long
savRow        long
locRW         real, dim(choose(~self.eRows,abs(self.eRows))+10)
savW          real
locX          real
locY          real
locMaxW       real
locMaxH       real
 code
  self.eRows = choose(~self.eRows,1,abs(self.eRows))
  loop 10 times                                     ! counts attempts to choose lines number
    do r:Split                                      ! Divine into lines
    locMaxW = 0                                     ! Define maximal calculated length of the string
    loop locRi = 1 to self.eRows
      locMaxW = choose(locMaxW < locRw[locRi], locRw[locRi], locMaxW)
    end
    if locMaxW <= self.gPos.eW then break end       ! If calculated length is greater than maximal, then
    self.eRows += 1                                 ! increase lines number and recalculate
  end
  ! Calculating coords of the elements 
  self.iLegend.Set(self.qLegend)
  loop until self.iLegend.Next(self.qLegend)
    if savRow <> self.qLegend.eRow
      savRow = self.qLegend.eRow
      locX = self.eCellPadding + self.qLegend.eBoxR
      locY = locMaxH + self.eCellPadding
    end
    self.qLegend.eX = locX
    self.qLegend.eY = locY
    put(self.qLegend)
    locX += self.qLegend.eW + self.eCellPadding
    if locMaxH < (locY+self.qLegend.eH+self.eCellPadding)
      locMaxH = locY+self.qLegend.eH+self.eCellPadding
    end
  end
  self.gPos.eW = locMaxW                            ! Setting real dimensions of the legend
  self.gPos.eH = locMaxH
!----------------------------------------------------------------------------------------
r:Split       routine
  locRi = 0
  clear(locRw)
  self.iLegend.Set(self.qLegend)
  loop until self.iLegend.Next(self.qLegend)
    locRi += 1
    if inrange(locRi, 1, self.eRows)
      do r:Update
    else
      locRi = self.eRows
      do r:Update
      do r:Optimize                                 ! Optimization
    end
  end
!----------------------------------------------------------------------------------------
r:Update      routine
  self.qLegend.eRow = locRi
  locRw[locRi] += self.qLegend.eW+2*self.eCellPadding
  put(self.qLegend)
!----------------------------------------------------------------------------------------
r:Optimize    routine
  savP = pointer(self.qLegend)
  loop while locRi > 1
    if self.GetFirstItemInRow(locRi) then break end ! find first element in this string
    savW = self.qLegend.eW + 2 * self.eCellPadding  ! Element length
    if locRw[locRi] => (locRw[locRi-1]+savW)        ! If row length is greater than the previous one, then
      if self.iLegend.Previous(self.qLegend) then break end ! Find last element in the previous string
      if self.iLegend.Next(self.qLegend) then break end ! Turn back
      self.qLegend.eRow = locRi-1                   ! Change row number
      put(self.qLegend)
      locRw[locRi]   -= savW                        ! Recalc rows lengths
      locRw[locRi-1] += savW
    end
    locRi -= 1                                      ! Checking next pair
  end
  locRi = self.eRows
  self.iLegend.Set(self.qLegend, savP)
!
GraphLegendClass.GetFirstItemInRow  procedure(long parRi)
 code
  self.iLegend.Set(self.qLegend)
  loop until self.iLegend.Next(self.qLegend)
    if self.qLegend.eRow = parRi then break end     ! If it's beginning of the string, then element found
  end
  return errorcode()
!
GraphLegendClass.PosLegend          procedure
 code
  case self.ePosition
  of LegendPosition:Left
  orof LegendPosition:Right
    ! Centering
    self.gPos.eY = self.gDist.eB + (self.gRec.eH - self.gDist.eB - self.gDist.eT - self.gPos.eH)/2
    case self.ePosition
    of LegendPosition:Left
      self.gPos.eX = self.gDist.eL
    of LegendPosition:Right
      self.gPos.eX = self.gRec.eW - self.gDist.eR - self.gPos.eW
    end
  of LegendPosition:Top
  orof LegendPosition:Bottom
    ! Centering
    self.gPos.eX = self.gRec.eX + (self.gRec.eW - self.gDist.eL - self.gDist.eR - self.gPos.eW)/2
    case self.ePosition
    of LegendPosition:Top
      self.gPos.eY = self.gRec.eH - self.gDist.eT - self.gPos.eH
    of LegendPosition:Bottom
      self.gPos.eY = self.gDist.eB
    end
  end
!
GraphLegendClass.Draw               procedure       ! Draw legend
locX        real
locY        real
locI        long
 code
  if self.ePosition = LegendPosition:None then return end
  self.iLegend.PushStyle
  self.iLegend.SetStyle
  self.iLegend.PushFont
  self.iLegend.SetFont(self.gFont)
  self.iLegend.Set(self.qLegend)
  loop until self.iLegend.Next(self.qLegend)
    locX = self.gPos.eX + self.qLegend.eX
    locY = self.gPos.eY + self.qLegend.eY
    case self.qLegend.eBoxType
    of 1
      self.iLegend.Roundbox(locX, locY+self.qLegend.eH/2-self.qLegend.eBoxR, |
                            self.qLegend.eBoxR*2, self.qLegend.eBoxR*2, self.qLegend.gBoxFill)
    else
      self.iLegend.Box(locX, locY+self.qLegend.eH/2-self.qLegend.eBoxR, |
                       self.qLegend.eBoxR*2, self.qLegend.eBoxR*2, self.qLegend.gBoxFill)
    end
    locX += self.qLegend.eBoxR*3
    self.iLegend.Show(locX, locY, self.qLegend.eText)
  end
  if self.eBox
    self.iLegend.Box(self.gPos.eX, self.gPos.eY, self.gPos.eW, self.gPos.eH)
  end
  self.iLegend.PopFont
  self.iLegend.PopStyle
!
GraphPrimitiveClass.Construct       procedure
 code
  if self.qGrFont &= null then self.qGrFont &= new(qGrfontType) end
  free(self.qGrFont) ; clear(self.qGrFont)
  if self.qGrStyle &= null then self.qGrStyle &= new(qGrStyleType) end
  free(self.qGrStyle) ; clear(self.qGrStyle)
  if self.qTStyle &= null then self.qTStyle &= new(qTextStyle) end
  free(self.qTStyle) ; clear(self.qTStyle)
  if self.qGrMeasure &= null then self.qGrMeasure &= new(qGrMeasureType) end
  free(self.qGrMeasure) ; clear(self.qGrMeasure)
  self.eDebug = true
  self.gFactorXY.eXb = 0
  self.gFactorXY.eYb = 0
  self.gFactorXY.eFx = 1
  self.gFactorXY.eFy = 1
  self.InitPalette

GraphPrimitiveClass.Destruct        procedure
 code
  if ~(self.qTStyle &= null) then dispose(self.qTStyle) end
  if ~(self.qGrMeasure &= null) then dispose(self.qGrMeasure) end
  if ~(self.qGrStyle &= null) then dispose(self.qGrStyle) end
  if ~(self.qGrFont &= null) then dispose(self.qGrFont) end
!
GraphPrimitiveClass.FParent    procedure(<long parField>)
 code
  if ~omitted(2) then self.eFParent = parField end
  return self.eFParent
!
GraphPrimitiveClass.ErrCode         procedure(<signed parErrorcode>)
  code
  if ~omitted(2) then self.eErrorcode = parErrorCode end
  return self.eErrorcode
!
GraphPrimitiveClass.ErrWinCode      procedure
 code
 if self.ErrCode(GetLastError())
?  assert(~self.ErrCode(),'Method ErrWinCode<13,10>Error: ' & self.ErrCode() &' '& self.ErrWinMessage(self.ErrCode()))
 end
 return self.ErrCode()
!
GraphPrimitiveClass.ErrWinMessage   procedure(long parErrorCode)
locMsg          cstring(10000)
locFlags        ulong, auto
locArguments    &cstring
 code
  if ~parErrorCode then return '' end
  locFlags = 1000H + 0FFH
  locFlags = bor(locFlags, 200H)                  ! Ignore Arguments
  locFlags = bxor(bor(locFlags, 400H), 400H)      ! Ignore lpSource
  locArguments &= null
  if ~FormatMessageA(locFlags, 0, parErrorCode, 0, locMsg, size(locMsg), locArguments)
    clear(locMsg)
  .
  if ~(locArguments &= null) then dispose(locArguments) end
  return clip(locMsg)
!
GraphPrimitiveClass.CheckHandle     procedure(unsigned parHandle)
 code
  self.ErrCode(0)
  if ~parHandle
    self.ErrWinCode
?   assert(~self.ErrCode(),'Method CheckHandle<13,10>Error: ' & self.ErrCode() &' '& self.ErrWinMessage(self.ErrCode()))
  end
  return self.ErrCode()
!
GraphPrimitiveClass.InitPalette     procedure(long parPalette=256)
locI          long
 code
  if    inrange(parPalette,1,8)     then parPalette = 8     ! 8 colors
  elsif inrange(parPalette,9,16)    then parPalette = 16    ! 16 colors
  elsif inrange(parPalette,17,256)  then parPalette = 256   ! 256 colors
  end
  if parPalette > maximum(self.ePalette,1) then parPalette = maximum(self.ePalette,1) end
  self.ePalette :=: color:none
  !
  self.ePalette[1] :=: color:Black                  ! Black is always 1st
  self.ePalette[parPalette] = color:White           ! White is always the last
  loop locI = 2 to parPalette-1
    if inrange(locI,2,8)
      ! Windows system palette (8 color)
      self.ePalette[locI] = choose(locI-1, |
                            color:Silver, color:Red, color:Lime, color:Yellow, color:Blue, color:Fuschia, color:Aqua)
    elsif inrange(locI,9,15)
      ! Windows system palette (16 color)
      self.ePalette[locI] = choose(locI-8, |
                            color:Maroon, color:Green, color:Olive, color:Navy, color:Purple, color:Teal, color:Gray)
    elsif inrange(locI,16,95)
      ! Windows system palette (256 color)
      self.ePalette[locI] = choose(locI-15, |
                            0330000h, 0660000h, 0990000h, 0CC0000h, 0003300h, 0333300h, 0663300h, 0993300h, |
                            0CC3300h, 0FF3300h, 0006600h, 0336600h, 0666600h, 0996600h, 0CC6600h, 0FF6600h, |
                            0009900h, 0339900h, 0669900h, 0999900h, 0CC9900h, 0FF9900h, 000CC00h, 033CC00h, |
                            066CC00h, 099CC00h, 0CCCC00h, 0FFCC00h, 033FF00h, 066FF00h, 099FF00h, 0CCFF00h, |
                            0000033h, 0330033h, 0660033h, 0990033h, 0CC0033h, 0FF0033h, 0003333h, 0333333h, |
                            0663333h, 0993333h, 0CC3333h, 0FF3333h, 0006633h, 0336633h, 0666633h, 0996633h, |
                            0CC6633h, 0FF6633h, 0009933h, 0339933h, 0669933h, 0999933h, 0CC9933h, 0FF9933h, |
                            000CC33h, 033CC33h, 066CC33h, 099CC33h, 0CCCC33h, 0FFCC33h, 000FF33h, 033FF33h, |
                            066FF33h, 099FF33h, 0CCFF33h, 0FFFF33h, 0000066h, 0330066h, 0660066h, 0990066h, |
                            0CC0066h, 0FF0066h, 0003366h, 0333366h, 0663366h, 0993366h, 0CC3366h, 0FF3366h)
    elsif inrange(locI,96,175)
      self.ePalette[locI] = choose(locI-95, |
                            0006666h, 0336666h, 0666666h, 0996666h, 0CC6666h, 0FF6666h, 0009966h, 0339966h, |
                            0669966h, 0999966h, 0CC9966h, 0FF9966h, 000CC66h, 033CC66h, 066CC66h, 099CC66h, |
                            0CCCC66h, 0FFCC66h, 000FF66h, 033FF66h, 066FF66h, 099FF66h, 0CCFF66h, 0FFFF66h, |
                            0000099h, 0330099h, 0660099h, 0990099h, 0CC0099h, 0FF0099h, 0003399h, 0333399h, |
                            0663399h, 0993399h, 0CC3399h, 0FF3399h, 0006699h, 0336699h, 0666699h, 0996699h, |
                            0CC6699h, 0FF6699h, 0009999h, 0339999h, 0669999h, 0999999h, 0CC9999h, 0FF9999h, |
                            000CC99h, 033CC99h, 066CC99h, 099CC99h, 0CCCC99h, 0FFCC99h, 000FF99h, 033FF99h, |
                            066FF99h, 099FF99h, 0CCFF99h, 0FFFF99h, 00000CCh, 03300CCh, 06600CCh, 09900CCh, |
                            0CC00CCh, 0FF00CCh, 00033CCh, 03333CCh, 06633CCh, 09933CCh, 0CC33CCh, 0FF33CCh, |
                            00066CCh, 03366CCh, 06666CCh, 09966CCh, 0CC66CCh, 0FF66CCh, 00099CCh, 03399CCh)
    elsif inrange(locI,176,215)
      self.ePalette[locI] = choose(locI-175, |
                            06699CCh, 09999CCh, 0CC99CCh, 0FF99CCh, 000CCCCh, 033CCCCh, 066CCCCh, 099CCCCh, |
                            0CCCCCCh, 0FFCCCCh, 000FFCCh, 033FFCCh, 066FFCCh, 099FFCCh, 0CCFFCCh, 0FFFFCCh, |
                            03300FFh, 06600FFh, 09900FFh, 0CC00FFh, 00033FFh, 03333FFh, 06633FFh, 09933FFh, |
                            0CC33FFh, 0FF33FFh, 00066FFh, 03366FFh, 06666FFh, 09966FFh, 0CC66FFh, 0FF66FFh, |
                            00099FFh, 03399FFh, 06699FFh, 09999FFh, 0CC99FFh, 0FF99FFh, 000CCFFh, 033CCFFh, |
                            066CCFFh, 099CCFFh, 0CCCCFFh, 0FFCCFFh, 033FFFFh, 066FFFFh, 099FFFFh, 0CCFFFFh)
    elsif inrange(locI,224,263)
      ! Оттенки серого
      self.ePalette[locI] = choose(locI-223, |
                            0070707h, 00D0D0Dh, 0141414h, 01A1A1Ah, 0212121h, 0272727h, 02E2E2Eh, 0343434h, |
                            03B3B3Bh, 0414141h, 0484848h, 04E4E4Eh, 0555555h, 05C5C5Ch, 0626262h, 0696969h, |
                            06F6F6Fh, 0767676h, 07C7C7Ch, 0838383h, 0898989h, 0909090h, 0969696h, 09D9D9Dh, |
                            0A3A3A3h, 0AAAAAAh, 0B1B1B1h, 0B7B7B7h, 0BEBEBEh, 0C4C4C4h, 0CBCBCBh, 0D1D1D1h, |
                            0D8D8D8h, 0DEDEDEh, 0E5E5E5h, 0EBEBEBh, 0F2F2F2h, 0F8F8F8h)
    end
  end
!
GraphPrimitiveClass.GetColor        procedure(long parNum, long parPalette=256)
! Returns color from standard palette (by it's number)
locRGB        long(color:none)
 code
  if inrange(parPalette, 1, maximum(self.ePalette,1))
    if    inrange(parPalette,1,8)     then parPalette = 8     ! 8 colors
    elsif inrange(parPalette,9,16)    then parPalette = 16    ! 16 colors
    elsif inrange(parPalette,17,256)  then parPalette = 256   ! 256 colors
    end
    parNum = parNum % parPalette                    ! Colour's number (in the palette)
    if parNum = 0
      locRGB = color:White                          ! White is always the last
    else
      locRGB = self.ePalette[parNum]
    end
  end
  return locRGB
!
GraphPrimitiveClass.GetNumColor     procedure(long parColor, long parPalette=256)
locNum      long
locI        long
 code
  if parPalette = 0 then parPalette = maximum(self.ePalette,1) else parPalette = abs(parPalette) .
  if inrange(parPalette, 1, maximum(self.ePalette,1))
    if    inrange(parPalette,1,8)     then parPalette = 8     ! 8 colors
    elsif inrange(parPalette,9,16)    then parPalette = 16    ! 16 colors
    elsif inrange(parPalette,17,256)  then parPalette = 256   ! 256 colors
    end
    if parPalette > maximum(self.ePalette,1) then parPalette = maximum(self.ePalette,1) end
    if parColor = color:White
      locNum = parPalette                           ! White is always the last
    else
      loop locI = 1 to parPalette                   ! Search of number of the colour in a palette
        if self.ePalette[locI] = parColor
          locNum = locI
          break
        end
      end
    end
  end
  return locNum
!
GraphPrimitiveClass.NextColor       procedure(long parNum, long parPalette=256)
locRGB      long, auto
 code
  parNum += 1                                       ! Next number
  locRGB = self.GetColor(parNum, parPalette)        ! Searching colour by its number
  if locRGB = color:none                            ! if colour not found
    ! select color from whole RGB range, excluding standard palette colors
    loop
      locRGB = random(color:Black+1, color:White-1)
      if ~self.GetNumColor(locRGB, parPalette) then break end
    end
  end
  return locRGB
!
GraphPrimitiveClass.Null            procedure(*queue parQ)
 code
  self.ErrCode(0)
  if parQ &= null
    self.ErrCode(err:ReferenceNull)
  end
  return self.ErrCode()
!
GraphPrimitiveClass.Set             procedure(*queue parQ, long parPointer=0)
 code
  if self.Null(parQ) then return self.ErrCode() end
  if parPointer < 0
    get(parQ, records(parQ) - abs(parPointer+1))
  else
    get(parQ, parPointer)
  end
  return errorcode()
!
GraphPrimitiveClass.Next            procedure(*queue parQ)
 code
  if self.Null(parQ) then return self.ErrCode() end
  get(parQ, pointer(parQ)+1)
  return errorcode()
!
GraphPrimitiveClass.Previous        procedure(*queue parQ)
 code
  if self.Null(parQ) then return self.ErrCode() end
  get(parQ, pointer(parQ)-1)
  return errorcode()
!
GraphPrimitiveClass.Inbox           procedure(real parX, real parY, real parBoxX, real parBoxY, real parBoxW, real parBoxH)
! Checks a box
 code
  return choose(inrange(parX, parBoxX, parBoxX + parBoxW) and inrange(parY, parBoxY, parBoxY + parBoxH))
!
GraphPrimitiveClass.Inbox           procedure(real parX, real parY, gXYType parXY, gWHDType parWHD)
! Checks a box
 code
  return choose(inrange(parX, parXY.eX, parXY.eX + parWHD.eW) and |
                inrange(parY, parXY.eY, parXY.eY + parWHD.eH))
!
GraphPrimitiveClass.Inbox           procedure(real parX, real parY, real parBoxX, real parBoxY, |
                                              real parBoxW, real parBoxH, real parDepth, real parAngle=45)
locIn           bool(true)
locDcos         real, auto
locDsin         real, auto
locX1           real, auto
locY1           real, auto
 code
  if self.Inbox(parX, parY, parBoxX, parBoxY, parBoxW, parBoxH) ! Front
  elsif parDepth <> 0
    locDcos = parDepth*cos(equ:DegToRad*parAngle)
    locDsin = parDepth*sin(equ:DegToRad*parAngle)
    ! Upper facet
    locX1 = parBoxX
    locY1 = parBoxY + parBoxH
    if ~self.InPolygon(parX, parY, locX1, locY1, locX1+locDcos, locY1+locDsin, locX1+locDcos+parBoxW, |
                       locY1+locDsin, locX1+parBoxW, locY1)
      ! Right facet
      locX1 = parBoxX + parBoxW
      locY1 = parBoxY + parBoxH
      if ~self.InPolygon(parX, parY, locX1, locY1, locX1+locDcos, locY1+locDsin, locX1+locDcos, |
                         locY1+locDsin-parBoxH, locX1, parBoxY)
        locIn = false
      end
    end
  else
    locIn = false
  end
  return locIn
!
GraphPrimitiveClass.InPolygon       procedure(real parX, real parY, |
                                              real parX1, real parY1, real parX2, real parY2, |
                                              real parX3, real parY3, <real parX4>, <real parY4>)
! Checks a triangle or quadrangle
locBToSquare    real, auto
locCToSquare    real, auto
locAngle        real, auto
 code
  ! All is great is simply... But it is VERY difficult to find the simple decision.
  locBToSquare = (parX-parX1)^2+(parY-parY1)^2
  locCToSquare = (parX-parX2)^2+(parY-parY2)^2
  locAngle = acos( (locBToSquare+locCToSquare-(parX1-parX2)^2-(parY1-parY2)^2)/(2*sqrt(locBToSquare)*sqrt(locCToSquare)) )
  locBToSquare = (parX-parX2)^2+(parY-parY2)^2
  locCToSquare = (parX-parX3)^2+(parY-parY3)^2
  locAngle += acos( (locBToSquare+locCToSquare-(parX2-parX3)^2-(parY2-parY3)^2)/(2*sqrt(locBToSquare)*sqrt(locCToSquare)) )
  if omitted(10) or omitted(11)
    locBToSquare = (parX-parX3)^2+(parY-parY3)^2
    locCToSquare = (parX-parX1)^2+(parY-parY1)^2
    locAngle += acos( (locBToSquare+locCToSquare-(parX3-parX1)^2-(parY3-parY1)^2)/(2*sqrt(locBToSquare)*sqrt(locCToSquare)) )
  else
    locBToSquare = (parX-parX3)^2+(parY-parY3)^2
    locCToSquare = (parX-parX4)^2+(parY-parY4)^2
    locAngle += acos( (locBToSquare+locCToSquare-(parX3-parX4)^2-(parY3-parY4)^2)/(2*sqrt(locBToSquare)*sqrt(locCToSquare)) )
    locBToSquare = (parX-parX4)^2+(parY-parY4)^2
    locCToSquare = (parX-parX1)^2+(parY-parY1)^2
    locAngle += acos( (locBToSquare+locCToSquare-(parX4-parX1)^2-(parY4-parY1)^2)/(2*sqrt(locBToSquare)*sqrt(locCToSquare)) )
  end
  return choose(locAngle => equ:DegToRad*360)
!
GraphPrimitiveClass.InPolygon       procedure(real parX, real parY, qXYType parQ)
! Checks a polygon
locAngle        real
locX            real, auto
locY            real, auto
locBToSquare    real, auto
locCToSquare    real, auto
 code
  if self.Set(parQ, -1)
    locX = parQ.eX
    locY = parQ.eY
    self.Set(parQ)
    loop until self.Next(parQ)
      locBToSquare = (parX-locX)^2+(parY-locY)^2
      locCToSquare = (parX-parQ.eX)^2+(parY-parQ.eY)^2
      locAngle += acos( (locBToSquare + locCToSquare - (locX-parQ.eX)^2 - (locY-parQ.eY)^2)/|
                        (2*sqrt(locBToSquare)*sqrt(locCToSquare)) )
      locX = parQ.eX
      locY = parQ.eY
    end
  end
  return choose(locAngle => equ:DegToRad*360)
!
GraphPrimitiveClass.InEllipse       procedure(real parX, real parY, real parEllipseX, real parEllipseY, |
                                              real parEllipseW, real parEllipseH)
 code
  if ((parX - parEllipseX - parEllipseW/2)^2/(parEllipseW/2)^2 + |
      (parY - parEllipseY - parEllipseH/2)^2/(parEllipseH/2)^2) > 1
    return false
  end
  return true
!
GraphPrimitiveClass.InVCylinder     procedure(real parX, real parY, real parCylX, real parCylY, |
                                              real parCylH, real parCylR, real parDepth)
locIn           bool(true)
 code
  if self.Inbox(parX, parY, parCylX, parCylY+parDepth/2, parCylR*2, parCylH)
  elsif parDepth <> 0
    if ~self.InEllipse(parX, parY, parCylX, parCylY, parCylR*2, parDepth)
      if ~self.InEllipse(parX, parY, parCylX, parCylY+parCylH, parCylR*2, parDepth)
        locIn = false
      end
    end
  else
    locIn = false
  end
  return locIn
!
GraphPrimitiveClass.InHCylinder     procedure(real parX, real parY, real parCylX, real parCylY, |
                                              real parCylW, real parCylR, real parDepth)
locIn           bool(true)
 code
  if self.Inbox(parX, parY, parCylX+parDepth/2, parCylY, parCylW, parCylR*2)
  elsif parDepth <> 0
    if ~self.InEllipse(parX, parY, parCylX, parCylY, parDepth, parCylR*2)
      if ~self.InEllipse(parX, parY, parCylX+parCylW, parCylY, parDepth, parCylR*2)
        locIn = false
      end
    end
  else
    locIn = false
  end
  return locIn
!
GraphPrimitiveClass.Deg             procedure(real parX, real parY)
locDeg        real, auto
 code
  locDeg =  atan(parX/parY)*equ:RadToDeg
  if parY > 0 and parX > 0
  elsif parY < 0 and parX <> 0
    locDeg += 180
  elsif parY > 0 and parX < 0
    locDeg += 360
  end
  return locDeg
!
GraphPrimitiveClass.Rad             procedure(real parX, real parY)
locRad        real, auto
 code
  locRad =  atan(parX/parY)
  if parY > 0 and parX > 0
  elsif parY < 0 and parX <> 0
    locRad += 180*equ:DegToRad
  elsif parY > 0 and parX < 0
    locRad += 360*equ:DegToRad
  end
  return locRad
!
GraphPrimitiveClass.GetPrinterProp  procedure(long parProp)
gDevMode  like(gDevModeType), auto
locRet    any
 code
  gDevMode = printer{PROPPRINT:DevMode}
  case parProp
  of prop:Landscape
    locRet = choose(gDevMode.eOrientation,false,true)
  of propprint:PaperWidth
    locRet = choose(gDevMode.eOrientation, printer{propprint:PaperWidth}, printer{propprint:PaperHeight})
  of propprint:PaperHeight
    locRet = choose(gDevMode.eOrientation, printer{propprint:PaperHeight}, printer{propprint:PaperWidth})
  else
    locRet = printer{parProp}
  end
  return locRet
!
GraphPrimitiveClass.SetFactorXY     procedure(<real parXb>, <real parYb>, <real parFx>, <real parFy>)
! Sets output area's initial coordinates and
! factors of recalculation from the logic coordinates in the coordinates of the device
 code
  ! Initial coordinates in device' units
  if ~omitted(2) then self.gFactorXY.eXb = round(parXb,1) end
  if ~omitted(3) then self.gFactorXY.eYb = round(parYb,1) end
  ! Factors of recalculation from logic units in units Devices
  ! usually, Х-factor (coeff.) is equal to Y-factor
  if ~omitted(4) then self.gFactorXY.eFx = parFx end
  if ~omitted(5) then self.gFactorXY.eFy = parFy end
  if self.gFactorXY.eFx=0 then self.gFactorXY.eFx = 1 end
  if self.gFactorXY.eFy=0 then self.gFactorXY.eFy = 1 end
!
GraphPrimitiveClass.FactorYb        procedure(<real parValue>)
 code
  if ~omitted(2) then self.gFactorXY.eYb = parValue end
  return self.gFactorXY.eYb
!
GraphPrimitiveClass.FactorXb        procedure(<real parValue>)
 code
  if ~omitted(2) then self.gFactorXY.eXb = parValue end
  return self.gFactorXY.eXb
!
GraphPrimitiveClass.FactorX         procedure(<real parValue>)
 code
  if ~omitted(2) then self.gFactorXY.eFx = parValue end
  return self.gFactorXY.eFx
!
GraphPrimitiveClass.FactorY         procedure(<real parValue>)
 code
  if ~omitted(2) then self.gFactorXY.eFy = parValue end
  return self.gFactorXY.eFy
!
GraphPrimitiveClass.ToX             procedure(real parValue)
! Recalc X from logical coords to device coordinates
 code
  return abs(self.gFactorXY.eXb) + choose(self.gFactorXY.eXb<0,-1,1) * round(parValue*self.gFactorXY.eFx,1)
!
GraphPrimitiveClass.ToLX            procedure(real parValue)
 code
  return abs(self.gFactorXY.eXb) + choose(self.gFactorXY.eXb<0,-1,1) * parValue/self.gFactorXY.eFx
!
GraphPrimitiveClass.ToY             procedure(real parValue)
 code
  return abs(self.gFactorXY.eYb) + choose(self.gFactorXY.eYb<0,-1,1) * round(parValue*self.gFactorXY.eFy,1)
!
GraphPrimitiveClass.ToLY            procedure(real parValue)
 code
  return abs(self.gFactorXY.eYb) + choose(self.gFactorXY.eYb<0,-1,1) * parValue/self.gFactorXY.eFy
!
GraphPrimitiveClass.ToH             procedure(real parValue)
 code
  return choose(self.gFactorXY.eYb<0,-1,1) * round(parValue*self.gFactorXY.eFy,1)
!
GraphPrimitiveClass.ToLH            procedure(real parValue)
 code
  return choose(self.gFactorXY.eYb<0,-1,1) * parValue/self.gFactorXY.eFy
!
GraphPrimitiveClass.ToW             procedure(real parValue)
 code
  return choose(self.gFactorXY.eXb<0,-1,1) * round(parValue*self.gFactorXY.eFx,1)
!
GraphPrimitiveClass.ToLW            procedure(real parValue)
 code
  return choose(self.gFactorXY.eXb<0,-1,1) * parValue/self.gFactorXY.eFx
!
GraphPrimitiveClass.ToPos           procedure(*gPositionType parPosIn, *gPositionType parPos)
 code
  parPos.eX = self.ToX(parPosIn.eX)
  parPos.eY = self.ToY(parPosIn.eY)
  parPos.eW = self.ToW(parPosIn.eW)
  parPos.eH = self.ToH(parPosIn.eH)
!
GraphPrimitiveClass.ToLPos          procedure(*gPositionType parPos, *gPositionType parLPos)
 code
  parLPos.eX = self.ToLX(parPos.eX)
  parLPos.eY = self.ToLY(parPos.eY)
  parLPos.eW = self.ToLW(parPos.eW)
  parLPos.eH = self.ToLH(parPos.eH)
!
GraphPrimitiveClass.GetTextPoint    procedure(long parField=0, string parText, <*? parW>, <*? parH>)
! Get text's width & height
locP      like(gPositionType)
 code
  if ~omitted(4) or ~omitted(5)
    if self.eGrField
      self.SetFont(parField,self.eGrField)
      self.eGrField{prop:NoWidth} = true
      self.eGrField{prop:NoHeight} = true
      self.eGrField{prop:text} = parText
      locP.eW = abs(self.ToLW(self.eGrField{prop:Width}))
      locP.eH = abs(self.ToLH(self.eGrField{prop:Height}))
    end
    if ~omitted(4) then parW = locP.eW end
    if ~omitted(5) then parH = locP.eH end
  else
    self.ErrCode(err:OmittedParametr)
  end
!
GraphPrimitiveClass.GetTextWidth    procedure(string parText, long parField=0)
locRet    real
 code
  self.GetTextPoint(parField,parText,locRet)
  return(locRet)
!
GraphPrimitiveClass.GetTextHeight   procedure(string parText, long parField=0)
locRet    real
 code
  self.GetTextPoint(parField,parText,,locRet)
  return(locRet)
!
GraphPrimitiveClass.PushStyle       procedure
! Push current font parameters into stack
 code
  self.qGrStyle.eColor = pencolor()
  self.qGrStyle.eWidth = penwidth()
  self.qGrStyle.eStyle = penstyle()
  add(self.qGrStyle)
!
GraphPrimitiveClass.PopStyle        procedure
! Pop style parameters from the stack
 code
  get(self.qGrStyle,records(self.qGrStyle))
  if ~errorcode()
    setpencolor(self.qGrStyle.eColor)
    setpenwidth(self.qGrStyle.eWidth)
    setpenstyle(self.qGrStyle.eStyle)
    delete(self.qGrStyle)
  end
!
GraphPrimitiveClass.SetStyle        procedure(long parColor=color:WindowText, long parPenWidth=0, long parPenStyle=pen:Solid)
! Set painting parameters
 code
  setpencolor(parColor)
  setpenwidth(parPenWidth)
  setpenstyle(parPenStyle)
!
GraphPrimitiveClass.PushMeasure     procedure(window parWindow)
! To push the current parameters of a measure into stack
 code
  clear(self.qGrMeasure)
  case parWindow{prop:type}
  of create:report
    self.qGrMeasure.ePoints = parWindow{prop:points}
    if ~self.qGrMeasure.ePoints
      self.qGrMeasure.eThous = parWindow{prop:thous}
      self.qGrMeasure.eMm = parWindow{prop:mm}
    end
  else
    self.qGrMeasure.ePixels = parWindow{prop:pixels}
    !BUG!
    ! If parWindow{prop:pixels} = true then
    ! parWindow{prop:thous} and parWindow{prop:mm} also returns TRUE
    if ~self.qGrMeasure.ePixels
      self.qGrMeasure.eThous = parWindow{prop:thous}
      self.qGrMeasure.eMm = parWindow{prop:mm}
    end
  end
  add(self.qGrMeasure)
!
GraphPrimitiveClass.PopMeasure      procedure(window parWindow)
! To push out parameters of a measure from stack
 code
  get(self.qGrMeasure,records(self.qGrMeasure))
  if ~errorcode()
    case parWindow{prop:type}
    of create:report
      parWindow{prop:thous} = self.qGrMeasure.eThous
      parWindow{prop:mm} = self.qGrMeasure.eMm
      parWindow{prop:points} = self.qGrMeasure.ePoints
    else
      parWindow{prop:pixels} = self.qGrMeasure.ePixels
      parWindow{prop:thous} = self.qGrMeasure.eThous
      parWindow{prop:mm} = self.qGrMeasure.eMm
    end
    delete(self.qGrMeasure)
  end
!
GraphPrimitiveClass.PushMeasure     procedure
 code
  self.PushMeasure(self.eWindow)
!
GraphPrimitiveClass.PopMeasure      procedure
 code
  self.PopMeasure(self.eWindow)
!
GraphPrimitiveClass.SetMeasure      procedure
 code
  case self.eWindow{prop:type}
  of create:report
    self.eWindow{prop:thous} = true
  else
    if ~self.eWindow{prop:pixels}
      self.eToPixelsX = self.eWindow{prop:Width}
      self.eToPixelsY = self.eWindow{prop:Height}
      self.eWindow{prop:pixels} = true
      self.eToPixelsX = self.eWindow{prop:Width} / self.eToPixelsX
      self.eToPixelsY = self.eWindow{prop:Height} / self.eToPixelsY
    end
  end
!
GraphPrimitiveClass.PushFont        procedure
! To push the current parameters of a font into stack
 code
  getfont(0, self.qGrFont.eFontName, self.qGrFont.eFontSize, self.qGrFont.eFontColor, |
             self.qGrFont.eFontStyle, self.qGrFont.eCharSet)
  add(self.qGrFont)
!
GraphPrimitiveClass.PopFont         procedure
! To push out parameters of a font from stack
locFont   like(gFontType), auto
 code
  get(self.qGrFont,records(self.qGrFont))
  if ~errorcode()
    locFont = self.qGrFont
    self.SetFont(locFont,0,true)
    delete(self.qGrFont)
  end
!
GraphPrimitiveClass.GetFont         procedure(*gFontType parFont, <long parField>)
! Read font parameters
 code
  if omitted(3) then parField = 0 end
  getfont(parField, parFont.eFontName, parFont.eFontSize, parFont.eFontColor, |
          parFont.eFontStyle, parFont.eCharSet)
!
GraphPrimitiveClass.SetFont         procedure(*gFontType parFont, long parField, bool parSet)
! Set font parameters
 code
  if parSet or parFont.eFontName
    if upper(parField{prop:FontName}) <> upper(parFont.eFontName) then parField{prop:FontName} = parFont.eFontName end
  end
  if parSet or parFont.eFontSize
    if parField{prop:FontSize}+0 <> parFont.eFontSize then parField{prop:FontSize} = parFont.eFontSize end
  end
  if parSet or parFont.eFontStyle
    if parField{prop:FontStyle}+0 <> parFont.eFontStyle then parField{prop:FontStyle} = parFont.eFontStyle end
  end
  if parSet or parFont.eCharSet
    if parField{prop:FontCharSet}+0 <> parFont.eCharSet then parField{prop:FontCharSet} = parFont.eCharSet end
  end
  if parField{prop:FontColor}+0 <> parFont.eFontColor then parField{prop:FontColor} = parFont.eFontColor end
!
GraphPrimitiveClass.SetFont         procedure(*gFontType parFont, long parField=0)
 code
  self.SetFont(parFont, parField, false)
!
GraphPrimitiveClass.SetFont         procedure(long parFieldIn, long parFieldOut)
locFont   like(gFontType), auto
 code
  self.GetFont(locFont,parFieldIn)
  self.SetFont(locFont,parFieldOut)
!
GraphPrimitiveClass.GetPosition     procedure(long parField, *gPositionType parPos)
 code
  getposition(parField,parPos.eX,parPos.eY,parPos.eW,parPos.eH)
  self.ToLPos(parPos, parPos)
!
GraphPrimitiveClass.SetPosition     procedure(long parField, *gPositionType parPos)
! Positioning screen object
locP          like(gPositionType)
savDeferMove  long, auto
 code
  savDeferMove = system{prop:DeferMove}
  system{prop:DeferMove} = 4
  self.ToPos(parPos,locP)
  if parField{prop:Xpos} <> locP.eX   then parField{prop:Xpos} = locP.eX end
  if parField{prop:Ypos} <> locP.eY   then parField{prop:Ypos} = locP.eY end
  if parField{prop:Width} <> locP.eW  then parField{prop:Width} = locP.eW end
  if parField{prop:Height} <> locP.eH then parField{prop:Height} = locP.eH end
  system{prop:DeferMove} = savDeferMove
!
GraphPrimitiveClass.Pie             procedure(real parX, real parY, real parW, real parH, qPieType parQ, |
                                              real parDepth=0, long parWholevalue=0, long parStartangle=0)
locI            long
locII           long
locSlices       signed, dim(records(parQ)), auto
locColors       long, dim(records(parQ)), auto
loc             like(gPositionType)
savPointer      long, auto
 code
  if self.Null(parQ) then return end
  if ~records(parQ) then return end
  get(parQ, 0)
  loop
    locI += 1
    if self.Set(parQ, locI) then break end
    locSlices[locI] = self.ToH(parQ.eSlice)
    if parQ.gFill.eColor=color:auto                 ! Selection of unique colour
      savPointer = pointer(parQ)
      self.Set(parQ)
      loop
        locII += 1
        locColors[locI] = self.NextColor(locII)
        parQ.gFill.eColor = locColors[locI]
        get(parQ, +parQ.gFill.eColor)
      until errorcode()
      self.Set(parQ,savPointer)
    else
      locColors[locI] = parQ.gFill.eColor
    end
  end
  loc.eX = self.ToX(parX)
  loc.eY = self.ToY(parY)
  loc.eW = self.ToW(parW)
  loc.eH = self.ToH(parH)
  !FixUp to correct any negative values
  !**************************************************************************************
  if loc.eW < 0
    loc.eW = abs(loc.eW)
    loc.eX -= loc.eW
  end
  if loc.eH < 0
    loc.eH = abs(loc.eH)
    loc.eY -= loc.eH
  end
  !**************************************************************************************
  ! Output to REPORT-structure in 3D mode, area (0,0) - (max PIE coords)
  ! is overlapped by white square
  pie(loc.eX, loc.eY, loc.eW, loc.eH, locSlices, locColors, abs(self.ToH(parDepth)), parWholevalue, parStartangle)
!
GraphPrimitiveClass.Line            procedure(real parX, real parY, real parW, real parH)
 code
  line(self.ToX(parX), self.ToY(parY), self.ToW(parW), self.ToH(parH))
!
GraphPrimitiveClass.HLine           procedure(real parX, real parY, real parW, <real parPenWidth>)
 code
  self.PushStyle
  if ~omitted(5)
    self.SetStyle(,self.ToH(parPenWidth))
  end
  line(self.ToX(parX), self.ToY(parY), self.ToW(parW),0)
  self.PopStyle
!
GraphPrimitiveClass.Box             procedure(real parX, real parY, real parW, real parH, <*gFillType parFill>)
 code
  box(self.ToX(parX), self.ToY(parY), self.ToW(parW), self.ToH(parH), |
      choose(~omitted(6),parFill.eColor,color:none))
!
GraphPrimitiveClass.Roundbox        procedure(real parX, real parY, real parW, real parH, <*gFillType parFill>)
 code
  roundbox(self.ToX(parX), self.ToY(parY), self.ToW(parW), self.ToH(parH), |
           choose(~omitted(6),parFill.eColor,color:none))
!
GraphPrimitiveClass.XYLine          procedure(real parX, real parY, real parX2, real parY2)
 code
  line(self.ToX(parX), self.ToY(parY), self.ToX(parX2)-self.ToX(parX), |
       self.ToY(parY2)-self.ToY(parY))
!
GraphPrimitiveClass.VLine           procedure(gPositionType parPos, long parStyle=0, |
                                              long parPenColor=color:windowtext, real parPenWidth=0)
! Vertical line
locD        real
locTd       real
locBd       real
locT        real(5)
locFill     like(gFillType)
 code
  self.PushStyle
  self.SetStyle(parPenColor)
  if parPenWidth=0 then parPenWidth = 1 end
  ! Lines styles
  locFill.eColor = parPenColor
  locD = int(parPenWidth/2)
  if band(parStyle,01b)                             ! At the top
    locTd = round(2*locD + locT,1)
    self.Triangle(parPos.eX+locD, parPos.eY+parPos.eH, |
                       parPos.eX+3*locD+round(locT/2,1), parPos.eY+parPos.eH-locTd,|
                       parPos.eX-locD-round(locT/2,1), parPos.eY+parPos.eH-locTd,|
                       true,locFill)
  end
  if band(parStyle,10b)                             ! At the bottom
    locBd = round(2*locD+locT,1)
    self.Triangle(parPos.eX+locD, parPos.eY, |
                       parPos.eX+3*locD-round(locT/2,1), parPos.eY+locBd, |
                       parPos.eX+locD-round(locT/2,1), parPos.eY+locBd,|
                       true,locFill)
  end
  self.Box(parPos.eX, parPos.eY+locBd, parPenWidth, parPos.eH-locTd-locBd, locFill)
  self.PopStyle
!
GraphPrimitiveClass.HLine           procedure(gPositionType parPos, long parStyle=0, |
                                              long parPenColor=color:windowtext, real parPenWidth=0)
! Horizontal line
locD        real
locLd       real
locRd       real
locT        real(5)
locFill     like(gFillType)
 code
  self.PushStyle
  self.SetStyle(parPenColor)
  if parPenWidth=0 then parPenWidth = 1 end
  ! Lines styles
  locFill.eColor = parPenColor
  locD = int(parPenWidth/2)
  if band(parStyle,01b)                             ! At the right
    locRd = round(2*locD + locT,1)
    self.Triangle(parPos.eX+parPos.eW, abs(self.ToLH(1))+parPos.eY+locD, |
                       parPos.eX+parPos.eW-locRd, abs(self.ToLH(1))+parPos.eY+3*locD+round(locT/2,1),|
                       parPos.eX+parPos.eW-locRd, abs(self.ToLH(1))+parPos.eY-locD-round(locT/2,1),|
                       true,locFill)
  end
  if band(parStyle,10b)                             ! At the left
  end
  self.Box(parPos.eX+locLd, parPos.eY, parPos.eW-locLd-locRd, parPenWidth, locFill)
  self.PopStyle
!
GraphPrimitiveClass.Triangle        procedure(real parX1, real parY1, |
                                              real parX2, real parY2, |
                                              real parX3, real parY3, |
                                              long parStyle=0, <*gFillType parFill>)
! Triagle, drawing by apices' coordinates
locP      long,dim(6)
 code
  locP[1] = self.ToX(parX1) ; locP[2] = self.ToY(parY1)
  locP[3] = self.ToX(parX2) ; locP[4] = self.ToY(parY2)
  locP[5] = self.ToX(parX3) ; locP[6] = self.ToY(parY3)
  if band(parStyle,01b)
    if ~omitted(9)
      polygon(locP, parFill.eColor)
    else
      polygon(locP, pencolor())
    end
  else
    polygon(locP)
  end
!
GraphPrimitiveClass.RBox            procedure(real parX, real parY, real parR, <*gFillType parFill>)
! Rectagle incribed into circle
 code
  box(self.ToX(parX-parR), self.ToY(parY-parR), self.ToW(parR*2), self.ToH(parR*2), |
      choose(~omitted(5),parFill.eColor,color:none))
!
GraphPrimitiveClass.Polygon         procedure(qXYType parQ, <*gFillType parFill>)
! Closed polygon
locI    long, auto
locM    signed, dim(2*records(parQ)), auto
 code
  if ~self.Null(parQ)
    if records(parQ)
      get(parQ, 0)
      locI = 1
      loop
        get(parQ, pointer(parQ)+1)
        if errorcode() then break end
        locM[locI]    = self.ToX(parQ.eX)
        locM[locI+1]  = self.ToY(parQ.eY)
        locI += 2
      end
      polygon(locM, choose(~omitted(3),parFill.eColor,color:none))
    end
  end
!
GraphPrimitiveClass.CPolygon        procedure(real parX, real parY, real parR, real parAngle=45, long parType=4, |
                                              <*gFillType parFill>)
! Draws inscribed polygon
locI      real, auto
locAngle  real, auto
locTan    real, auto
locRad    real, auto
lQ        qXYType
 code
  locAngle = equ:DegToRad*360/parType
  parAngle *= equ:DegToRad
  loop locI = 0 to parType-1
    locRad = locAngle*locI+parAngle
    lQ.eX = parX + parR*cos(locRad)
    lQ.eY = parY + parR*sin(locRad)
    add(lQ)
  end
  if ~omitted(7)
    self.Polygon(lQ,parFill)
  else
    self.Polygon(lQ)
  end
!
GraphPrimitiveClass.Circle          procedure(real parX, real parY, real parR, <*gFillType parFill>)
 code
  ellipse(self.ToX(parX-parR), self.ToY(parY-parR), self.ToW(parR*2), self.ToH(parR*2), |
          choose(~omitted(5),parFill.eColor,color:none))
!
GraphPrimitiveClass.HCylinder       procedure(real parX, real parY, real parW, real parR, |
                                              real parDepth=0, *gFillType parFill)
! Horizontal cylinder with width(height) 2*R
locX      long, auto
locY      long, auto
locW      long, auto
locH      long, auto
locHalfW2 long, auto
locSign   long, auto
 code
  self.PushStyle
  locX = self.ToX(parX)
  locY = self.ToY(parY)
  locW = self.ToW(parW)
  locH = self.ToH(parR*2)
  locHalfW2 = self.ToW(parDepth)/2
  locSign = choose(locH<0,-1,1)
  if ~locHalfW2
    if pencolor() = color:black then self.SetStyle(color:white) else self.SetStyle(color:black) end
    box(locX, locY, locW, locH, parFill.eColor)
  else
    self.SetStyle(parFill.eColor)
    chord(locX, locY, locHalfW2*2, locH, 900*locSign, 2700*locSign, parFill.eColor)
    box(locX + locHalfW2, locY, locW, locH, parFill.eColor)
    if pencolor() = color:black then self.SetStyle(color:white) else self.SetStyle(color:black) end
    arc(locX, locY, locHalfW2*2, locH, 900*locSign, 2700*locSign)
    line(locX+locHalfW2, locY, locW, 0)
    line(locX+locHalfW2, locY+locH, locW, 0)
    ellipse(locX + locW, locY, locHalfW2*2, locH, parFill.eColor)
  end
  self.PopStyle
!
GraphPrimitiveClass.VCylinder       procedure(real parX, real parY, real parH, real parR, |
                                              real parDepth=0, *gFillType parFill)
! Vertical cylinder with width(height) 2*R
locX      long, auto
locY      long, auto
locW      long, auto
locH      long, auto
locHalfH2 long, auto
locSign   long, auto
 code
  self.PushStyle
  locX = self.ToX(parX)
  locY = self.ToY(parY)
  locW = self.ToW(parR*2)
  locH = self.ToH(parH)
  locHalfH2 = self.ToH(parDepth)/2
  locSign = choose(locW<0,-1,1)
  if ~locHalfH2
    if pencolor() = color:black then self.SetStyle(color:white) else self.SetStyle(color:black) end
    box(locX, locY, locW, locH, parFill.eColor)
  else
    self.SetStyle(parFill.eColor)
    chord(locX, locY, locW, locHalfH2*2, 1800*locSign, 3600*locSign, parFill.eColor)
    box(locX, locY + locHalfH2, locW, locH, parFill.eColor)
    if pencolor() = color:black then self.SetStyle(color:white) else self.SetStyle(color:black) end
    arc(locX, locY, locW, locHalfH2*2, 1800*locSign, 3600*locSign)
    line(locX, locY+locHalfH2, 0, locH)
    line(locX+locW, locY+locHalfH2, 0, locH)
    ellipse(locX, locY + locH, locW, locHalfH2*2, parFill.eColor)
  end
  self.PopStyle
!
GraphPrimitiveClass.VBar            procedure(real parX, real parY, real parH, real parR, |
                                              real parDepth=0, *gFillType parFill)
! Vertical rectangle, width = 2R
locM      signed, dim(8), auto
locX      signed, auto
locY      signed, auto
locH      signed, auto
locR2     signed, auto
locSin    signed, auto
locCos    signed, auto
 code
  self.PushStyle
  if pencolor() = color:black then self.SetStyle(color:white) else self.SetStyle(color:black) end
  !
  locX = self.ToX(parX)                        ! Initial coordinate X
  locY = self.ToY(parY)                        ! Initial coordinate Y
  locR2 = self.ToW(parR*2)                     ! Width of a figure
  if parDepth
    locCos = self.ToW(parDepth*cos(equ:DegToRad*45))
    locSin = self.ToH(parDepth*sin(equ:DegToRad*45))
  end
  locH = self.ToH(parH)
  ! Front facet
  locM[1] = locX                ; locM[2] = locY
  locM[3] = locM[1]             ; locM[4] = locM[2] + locH
  locM[5] = locM[3] + locR2     ; locM[6] = locM[4]
  locM[7] = locM[5]             ; locM[8] = locM[2]
  polygon(locM, parFill.eColor)
  if parDepth
    ! Upper facet
    locM[1] = locX              ; locM[2] = locY + locH
    locM[3] = locM[1] + locCos  ; locM[4] = locM[2] + locSin
    locM[5] = locM[3] + locR2   ; locM[6] = locM[4]
    locM[7] = locM[1] + locR2   ; locM[8] = locM[2]
    polygon(locM, parFill.eColor)
    ! Right facet
    locM[1] = locX + locR2      ; locM[2] = locY + locH
    locM[3] = locM[1] + locCos  ; locM[4] = locM[2] + locSin
    locM[5] = locM[3]           ; locM[6] = locM[4] - locH
    locM[7] = locM[1]           ; locM[8] = locY
    polygon(locM, parFill.eColor)
  end
  self.PopStyle
!
GraphPrimitiveClass.VBar            procedure(*qBarPartstype parBar, real parR, real parDepth=0)
! Vertical rectangle, width = 2R
locM      signed, dim(8), auto
locX      signed, auto
locY      signed, auto
locH      signed, auto
locR2     signed, auto
locSin    signed, auto
locCos    signed, auto
 code
  self.PushStyle
  if pencolor() = color:black then self.SetStyle(color:white) else self.SetStyle(color:black) end
  self.Set(parBar,1)
  locX = self.ToX(parBar.gRec.eX)              ! Initial coordinate X
  locY = self.ToY(parBar.gRec.eY)              ! Initial coordinate Y
  locR2 = self.ToW(parR*2)                     ! Width of a figure
  if parDepth
    locCos = self.ToW(parDepth*cos(equ:DegToRad*45))
    locSin = self.ToH(parDepth*sin(equ:DegToRad*45))
  end
  self.Set(parBar)
  loop until self.Next(parBar)
    locH = self.ToH(parBar.gRec.eH)
    ! Front facet
    locM[1] = locX                ; locM[2] = locY
    locM[3] = locM[1]             ; locM[4] = locM[2] + locH
    locM[5] = locM[3] + locR2     ; locM[6] = locM[4]
    locM[7] = locM[5]             ; locM[8] = locM[2]
    polygon(locM, parBar.gFill.eColor)
    if parDepth
      ! Upper facet
      locM[1] = locX              ; locM[2] = locY + locH
      locM[3] = locM[1] + locCos  ; locM[4] = locM[2] + locSin
      locM[5] = locM[3] + locR2   ; locM[6] = locM[4]
      locM[7] = locM[1] + locR2   ; locM[8] = locM[2]
      polygon(locM, parBar.gFill.eColor)
      ! Right facet
      locM[1] = locX + locR2      ; locM[2] = locY + locH
      locM[3] = locM[1] + locCos  ; locM[4] = locM[2] + locSin
      locM[5] = locM[3]           ; locM[6] = locM[4] - locH
      locM[7] = locM[1]           ; locM[8] = locY
      polygon(locM, parBar.gFill.eColor)
    end
    locY += locH                                    ! New coordinate Y
  end
  self.PopStyle
!
GraphPrimitiveClass.HBar            procedure(real parX, real parY, real parW, real parR, |
                                              real parDepth=0, *gFillType parFill)
! Horizontal rectangle with width(height) 2*R
locM      signed, dim(8), auto
locX      signed, auto
locY      signed, auto
locLen    signed, auto
locR2     signed, auto
locSin    signed, auto
locCos    signed, auto
 code
  self.PushStyle
  if pencolor() = color:black then self.SetStyle(color:white) else self.SetStyle(color:black) end
  locX = self.ToX(parX)                        ! Initial coordinate X
  locY = self.ToY(parY)                        ! Initial coordinate Y
  locR2 = self.ToH(parR*2)                     ! Height of a figure
  if parDepth
    locCos = self.ToW(parDepth*cos(equ:DegToRad*45))
    locSin = self.ToH(parDepth*sin(equ:DegToRad*45))
  end
  locLen = self.ToW(parW)
  ! Front facet
  locM[1] = locX              ; locM[2] = locY
  locM[3] = locM[1]           ; locM[4] = locM[2] + locR2
  locM[5] = locM[3] + locLen  ; locM[6] = locM[4]
  locM[7] = locM[5]           ; locM[8] = locM[2]
  polygon(locM, parFill.eColor)
  if parDepth
    ! Upper facet
    locM[1] = locX              ; locM[2] = locY + locR2
    locM[3] = locM[1] + locCos  ; locM[4] = locM[2] + locSin
    locM[5] = locM[3] + locLen  ; locM[6] = locM[4]
    locM[7] = locM[1] + locLen  ; locM[8] = locM[2]
    polygon(locM, parFill.eColor)
    ! Right facet
    locM[1] = locX + locLen     ; locM[2] = locY + locR2
    locM[3] = locM[1] + locCos  ; locM[4] = locM[2] + locSin
    locM[5] = locM[3]           ; locM[6] = locM[4] - locR2
    locM[7] = locM[1]           ; locM[8] = locY
    polygon(locM, parFill.eColor)
  end
  self.PopStyle
!
GraphPrimitiveClass.Show            procedure(real parX, real parY, string parText, <gFontType parFont>, |
                                              long parBgrColor=color:none, long parBorderColor=color:none)
locW      long
locH      long
 code
  self.PushStyle
  self.PushFont
  if ~omitted(5) then self.SetFont(parFont) end
  self.GetTextPoint(,parText,locW,locH)
  if parBorderColor <> color:none or parBgrColor <> color:none
    if parBorderColor <> color:none
      self.SetStyle(parBorderColor)
    elsif parBgrColor <> color:none
      self.SetStyle(parBgrColor)
    end
    box(self.ToX(parX), self.ToY(parY), self.ToW(locW)+penwidth(), self.ToH(locH), parBgrColor)
  end
  ! Since SHOW always draws text in device coordinates, then
  if self.gFactorXY.eYb < 0                         ! If coordinates are inversed, then
    parY += locH                                    ! adjust Y coordinate by text height
  end
  show(self.ToX(parX), self.ToY(parY), parText)
  self.PopFont
  self.PopStyle
!
GraphPrimitiveClass.VCylinder       procedure(*qBarPartstype parBar, real parR, real parDepth=0)
! Vertical cylinder with width(height) 2*R
locM        signed, dim(8), auto
locX        signed, auto
locY        signed, auto
locR2       signed, auto
locH        signed, auto
locHalfH2   signed, auto
locSign     signed, auto
locPenColor long, auto
 code
  self.PushStyle
  self.Set(parBar,1)
  locX = self.ToX(parBar.gRec.eX)              ! Initial coordinate X
  locY = self.ToY(parBar.gRec.eY)              ! Initial coordinate Y
  locR2 = self.ToW(parR*2)                     ! Width of a figure
  locHalfH2 = self.ToH(parDepth)/2
  locSign = choose(locR2<0,-1,1)
  locPenColor = pencolor()
  if locPenColor = color:black then self.SetStyle(color:white) else self.SetStyle(color:black) end
  self.Set(parBar)
  loop until self.Next(parBar)
    locH = self.ToH(parBar.gRec.eH)
    if ~locHalfH2
      do r:DrawFrontFacet
    else
      self.SetStyle(parBar.gFill.eColor)
      chord(locX, locY, locR2, locHalfH2*2, 1800*locSign, 3600*locSign, parBar.gFill.eColor)
      do r:DrawFrontFacet
      if locPenColor = color:black then self.SetStyle(color:white) else self.SetStyle(color:black) end
      arc(locX, locY, locR2, locHalfH2*2, 1800*locSign, 3600*locSign)
      line(locX, locY+locHalfH2, 0, locH)
      line(locX+locR2, locY+locHalfH2, 0, locH)
      ellipse(locX, locY + locH, locR2, locHalfH2*2, parBar.gFill.eColor)
    end
    locY += locH                                    ! New coordinate Y
  end
  self.PopStyle
!
r:DrawFrontFacet     routine                        ! Front facet
  locM[1] = locX                ; locM[2] = locY + locHalfH2
  locM[3] = locM[1]             ; locM[4] = locM[2] + locH
  locM[5] = locM[3] + locR2     ; locM[6] = locM[4]
  locM[7] = locM[5]             ; locM[8] = locM[2]
  polygon(locM, parBar.gFill.eColor)

!
GraphPrimitiveClass.HBar            procedure(*qBarPartstype parBar, real parR, real parDepth=0)
! Vertical rectangle, width = 2R
locM      signed, dim(8), auto
locX      signed, auto
locY      signed, auto
locLen    signed, auto
locR2     signed, auto
locSin    signed, auto
locCos    signed, auto
 code
  self.PushStyle
  if pencolor() = color:black then self.SetStyle(color:white) else self.SetStyle(color:black) end
  self.Set(parBar,1)
  locX = self.ToX(parBar.gRec.eX)              ! Initial coordinate X
  locY = self.ToY(parBar.gRec.eY)              ! Initial coordinate Y
  locR2 = self.ToH(parR*2)                     ! Height of a figure
  if parDepth
    locCos = self.ToW(parDepth*cos(equ:DegToRad*45))
    locSin = self.ToH(parDepth*cos(equ:DegToRad*45))
  end
  self.Set(parBar)
  loop until self.Next(parBar)
    locLen = self.ToW(parBar.gRec.eH)
    ! Front facet
    locM[1] = locX                ; locM[2] = locY
    locM[3] = locM[1]             ; locM[4] = locM[2] + locR2
    locM[5] = locM[3] + locLen    ; locM[6] = locM[4]
    locM[7] = locM[5]             ; locM[8] = locM[2]
    polygon(locM, parBar.gFill.eColor)
    if parDepth
      ! Upper facet
      locM[1] = locX              ; locM[2] = locY + locR2
      locM[3] = locM[1] + locCos  ; locM[4] = locM[2] + locSin
      locM[5] = locM[3] + locLen  ; locM[6] = locM[4]
      locM[7] = locM[1] + locLen  ; locM[8] = locM[2]
      polygon(locM, parBar.gFill.eColor)
      ! Right facet
      locM[1] = locX + locLen     ; locM[2] = locY + locR2
      locM[3] = locM[1] + locCos  ; locM[4] = locM[2] + locSin
      locM[5] = locM[3]           ; locM[6] = locM[4] - locR2
      locM[7] = locM[1]           ; locM[8] = locY
      polygon(locM, parBar.gFill.eColor)
    end
    locX += locLen                                  ! New coordinate X
  end
  self.PopStyle
!
GraphPrimitiveClass.HCylinder       procedure(*qBarPartstype parBar, real parR, real parDepth=0)
! Vertical cylinder with width(height) 2*R
locM        signed, dim(8), auto
locX        signed, auto
locY        signed, auto
locR2       signed, auto
locLen      signed, auto
locHalfH2   signed, auto
locSign     signed, auto
locPenColor long, auto
 code
  self.PushStyle
  self.Set(parBar,1)
  locX = self.ToX(parBar.gRec.eX)              ! Initial coordinate X
  locY = self.ToY(parBar.gRec.eY)              ! Initial coordinate Y
  locR2 = self.ToH(parR*2)                     ! Height of a figure
  locHalfH2 = self.ToW(parDepth)/2
  locSign = choose(locR2<0,-1,1)
  locPenColor = pencolor()
  if locPenColor = color:black then self.SetStyle(color:white) else self.SetStyle(color:black) end
  self.Set(parBar)
  loop until self.Next(parBar)
    locLen = self.ToW(parBar.gRec.eH)
    if ~locHalfH2
      do r:DrawFrontFacet
    else
      self.SetStyle(parBar.gFill.eColor)
      chord(locX, locY, locHalfH2*2, locR2, 900*locSign, 2700*locSign, parBar.gFill.eColor)
      do r:DrawFrontFacet
      if locPenColor = color:black then self.SetStyle(color:white) else self.SetStyle(color:black) end
      arc(locX, locY, locHalfH2*2, locR2, 900*locSign, 2700*locSign)
      line(locX+locHalfH2, locY, locLen, 0)
      line(locX+locHalfH2, locY+locR2, locLen, 0)
      ellipse(locX+locLen, locY, locHalfH2*2, locR2, parBar.gFill.eColor)
    end
    locX += locLen                                  ! New coordinate X
  end
  self.PopStyle
!
r:DrawFrontFacet    routine                         ! Front facet
  locM[1] = locX + locHalfH2    ; locM[2] = locY
  locM[3] = locM[1]             ; locM[4] = locM[2] + locR2
  locM[5] = locM[3] + locLen    ; locM[6] = locM[4]
  locM[7] = locM[5]             ; locM[8] = locM[2]
  polygon(locM, parBar.gFill.eColor)
!
GraphPrimitiveClass.CheckTarget     procedure       ! Checks a target on availability
 code
  self.ErrCode(0)
  if self.eWindow &= null
    self.ErrCode(err:ReferenceNull)
  else
    case status(self.eWindow)
    of window:Ok
    of window:NotOpened
      self.ErrCode(err:NotOpen)
    else
      self.ErrCode(true)
    end
  end
  return self.ErrCode()
!
GraphPrimitiveClass.Settarget       procedure
locField    long, auto
 code
  if ~self.CheckTarget()
    if self.eWindow{prop:type} = create:report      ! The object IMAGE can not be set by the target in REPORT
      locField = self.FParent(){prop:parent}
      loop until ~locField
        case locField{prop:type}
        of create:detail orof create:header orof create:footer
          break
        end
        locField = locField{prop:parent}
      end
      case locField{prop:type}
      of create:detail orof create:header orof create:footer
        settarget(self.eWindow, locField)
      else
        self.ErrCode(err:BadParent)
        settarget()
      end
    else
      settarget(self.eWindow, self.eFband)
    end
  end
  return self.ErrCode()
!
GraphPrimitiveClass.FileNamePart    procedure(string parFileName, long parPart=FileName:FileName)
locFileName   cstring(file:MaxFileName+1), auto
locDrv        cstring(file:MaxFileName+1)
locDir        cstring(file:MaxFileName+1)
LocName       cstring(file:MaxFileName+1)
locExt        cstring(file:MaxFileName+1)
locRet        any
 code
  locRet = ''
  if parFileName
    locFileName = clip(parFileName)
    FnSplit(locFileName, locDrv, locDir, LocName, locExt)
    if sub(locExt,1,1) = '.' then locExt = sub(locExt, 2, len(clip(locExt))-1) end
    case parPart
    of FileName:Directory                           ! full name of directory
      locRet = clip(locDrv) & clip(locDir)
    of FileName:Drive                               ! disk
      locRet = clip(locDrv)
    of FileName:DirectoryExcDrive                   ! directory without disk
      if clip(locDir) <> '\'
        locRet = clip(locDir)
      end
    of FileName:FileName                            ! file name with extension
      locRet = locName & choose(~locExt, '', '.' & clip(locExt))
    of FileName:FileNameExcExt                      ! file name without extension
      locRet = locName
    of FileName:FileExt                             ! extension
      locRet = clip(locExt)
    end
  else
    self.ErrCode(BadNameErr)
  end
  return locRet
!
GraphPrimitiveClass.FileNameExt     procedure(string parFileName)
 code
  return self.FileNamePart(parFileName, FileName:FileExt)
!
GraphPrimitiveClass.FileNameMerge   procedure(<string parFileName>, <string parDrv>, <string parDir>, |
                                              <string parName>, <string parExt>)
locFileName   cstring(file:MaxFileName+1), auto
locDrv        cstring(file:MaxFileName+1)
locDir        cstring(file:MaxFileName+1)
LocName       cstring(file:MaxFileName+1)
locExt        cstring(file:MaxFileName+1)
locRet        any
 code
  locRet = ''
  if parFileName
    if ~omitted(2)
      locFileName = clip(parFileName)
      FnSplit(locFileName, locDrv, locDir, LocName, locExt)
    end
    if ~omitted(3) then locDrv = clip(parDrv) end
    if ~omitted(4) then locDir = clip(parDir) end
    if ~omitted(5) then locName = clip(parName) end
    if ~omitted(6) then locExt = clip(parExt) end
    FnMerge(locFileName, locDrv, locDir, LocName, locExt)
  else
    self.ErrCode(BadNameErr)
  end
  return clip(locFileName)
!
GraphPrimitiveClass.GetTempFileName procedure(<string parPrefix>, <string parExt>)
locFileName       any
locNewFilename    any
 code
  self.ErrCode(0)
  loop 100 times
    locFileName = GetTempFileName(choose(~omitted(2), parPrefix, ''))
    if omitted(3) then break end
    locNewFilename = self.FileNameMerge(locFileName,,,, parExt)
    rename(locFileName, locNewFilename)
    case errorcode()
    of 0
      locFilename = locNewFilename
    of 05
      remove(locFileName)
      if ~errorcode() then cycle end
    end
    self.ErrCode(errorcode())
    break
  end
  if ~self.ErrCode()
    return locFilename
  end
  return ''
!
GraphPrimitiveClass.GetTextRec      procedure(long parField, string parText, *gPositionType parPos)
locHWND         unsigned, auto
locDC           unsigned, auto
locRect         like(winRECTtype)
locHFont        unsigned
 code
  parPos.eW = 0
  parPos.eH = 0
  if parField
    locHWND = parField{prop:Handle}
  else
    locHWND = parField{prop:ClientHandle}
  end
  locDC = GetDC(locHWND)
  if ~self.CheckHandle(locDC)
    locHFont = SendMessage(locHWND, winWM_GETFONT, 0, 0)
    if ~self.CheckHandle(locHFont)
      if SelectObject(locDC, locHFont)
        if DrawText(locDC, parText, len(parText), locRect, winDT_CALCRECT+winDT_NOCLIP+winDT_EXPANDTABS)
          if locRect.eRight
            parPos.eW = round(locRect.eRight/self.eToPixelsX+0.5,1)
          end
          if locRect.eBottom
            parPos.eH = round(locRect.eBottom/self.eToPixelsY+0.5,1)
          end
        else
          self.ErrWinCode
        end
      else
        self.ErrWinCode
      end
    end
    if ~ReleaseDC(locHWND, locDC)
      self.ErrWinCode
    end
  end
? assert(~self.ErrCode(),'Method GetTextRec<13,10>Error:' & self.ErrCode())
!
GraphPrimitiveClass.ImageToEMF      procedure
locHDCMeta      unsigned
locHMeta        unsigned
locFileName     cstring(file:MaxFileName+1)
!
locBuff         &string
locLenBuff      long
locHEnhMeta     unsigned
locHEnhMetaCopy unsigned
 code
  if self.CheckTarget() then return '' end
  locHDCMeta = CreateMetaFile()                     ! Creation new DC for drawing
  if ~self.CheckHandle(locHDCMeta)
    DrawCopy(locHDCMeta)
    locHMeta = CloseMetaFile(locHDCMeta)
    if ~self.CheckHandle(locHMeta)
      locLenBuff = GetMetaFileBitsEx(locHMeta)
      if locLenBuff
        locBuff &= new(string(locLenBuff))
        if GetMetaFileBitsEx(locHMeta,locLenBuff,address(locBuff))
          locHEnhMeta = SetWinMetaFileBits(locLenBuff, locBuff) ! Converting WMF to a metafile
          if ~self.CheckHandle(locHEnhMeta)
            ! To save the Metafile in file
            locFileName = self.GetTempFileName(,'emf')
            locHEnhMetaCopy = CopyEnhMetaFileA(locHEnhMeta, locFileName)
            if ~self.CheckHandle(locHEnhMetaCopy)
              if ~DeleteEnhMetaFile(locHEnhMetaCopy)
                self.ErrWinCode
              end
            end
            if ~DeleteEnhMetaFile(locHEnhMeta)      ! To remove the created Metafile
              self.ErrWinCode
            end
          end
        else
          self.ErrWinCode
        end
        if ~(locBuff &= null) then dispose(locBuff) end
      else
        self.ErrWinCode
      end
      if ~DeleteMetaFile(locHMeta)                  ! To remove the created Metafile
        self.ErrWinCode
      end
    end
  end
? assert(~self.ErrCode(),'Method ImageToEMF<13,10>Error:' & self.ErrCode())
  return choose(~self.ErrCode(), clip(locFileName), '')
!
GraphPrimitiveClass.ImageToWMF      procedure
locHDCMeta      unsigned
locHMeta        unsigned
locFileName     cstring(file:MaxFileName+1)
!
locBuff         &string
locLenBuff      long
locHEnhMeta     unsigned
locPos          like(gPositionType)
locMetaHeader   like(winENHMETAHEADERtype)
 code
  if self.CheckTarget() then return '' end
  locHDCMeta = CreateMetaFile()                     ! Creation new DC for drawing
  if ~self.CheckHandle(locHDCMeta)
    DrawCopy(locHDCMeta)
    locHMeta = CloseMetaFile(locHDCMeta)
    if ~self.CheckHandle(locHMeta)
      locLenBuff = GetMetaFileBitsEx(locHMeta)
      if locLenBuff
        locBuff &= new(string(locLenBuff))
        if GetMetaFileBitsEx(locHMeta,locLenBuff,address(locBuff))
          locHEnhMeta = SetWinMetaFileBits(locLenBuff, locBuff) ! Converting WMF to a metafile
          if ~self.CheckHandle(locHEnhMeta)
            if GetEnhMetaFileHeader(locHEnhMeta, size(locMetaHeader), locMetaHeader) ! Getting heading of a metafile
              locPos.eX = locMetaHeader.rclBounds.eLeft
              locPos.eY = locMetaHeader.rclBounds.eTop
              locPos.eW = locMetaHeader.rclBounds.eRight
              locPos.eH = locMetaHeader.rclBounds.eBottom
              ! To save the Metafile in file
              locFileName = self.StringToFile(self.WMFHeader(locPos) & locBuff, self.GetTempFileName(,'wmf'))
            else
              self.ErrWinCode
            end
            if ~DeleteEnhMetaFile(locHEnhMeta)      ! To remove the created Metafile
              self.ErrWinCode
            end
          end
        else
          self.ErrWinCode
        end
        if ~(locBuff &= null) then dispose(locBuff) end
      else
        self.ErrWinCode
      end
      if ~DeleteMetaFile(locHMeta)                  ! To remove the created Metafile
        self.ErrWinCode
      end
    end
  end
? assert(~self.ErrCode(),'Method ImageToWMF<13,10>Error:' & self.ErrCode())
  return choose(~self.ErrCode(), clip(locFileName), '')
!
GraphPrimitiveClass.StringToFile    procedure(string parS, <string parFileName>, bool parAdd=false)
! Saving of a string in a file
locFileName any
locFile     file,driver('DOS'),create
              record
Buf             string(512)
              end
            end
locB        long, auto
locLen      long, auto
locLenBuf   long, auto
 code
  self.ErrCode(0)
  if omitted(3)
    locFileName = self.GetTempFileName()
  elsif parFileName
    locFileName = parFileName
  else
    locFileName = ''
  end
  if ~locFileName
    self.ErrCode(BadNameErr)
  end
  if ~self.ErrCode()
    locFile{prop:Name} = locFileName
    if ~parAdd then create(locFile) end
    if ~self.ErrCode(errorcode())
      open(locFile)
      if ~self.ErrCode(errorcode())
        locLenBuf = size(locFile.Buf)
        locLen = len(parS)
        locB = 1
        loop while locLen > 0
          if locLen => locLenBuf
            locFile.Buf = parS[locB : locB + locLenBuf-1]
            add(locFile)
          else
            locFile.Buf[1 : locLen] = parS[locB : locB + locLen-1]
            add(locFile, locLen)
          .
          if self.ErrCode(errorcode()) then break .
          locB += locLenBuf
          locLen -= locLenBuf
        end
        close(locFile)
      end
    end
  end
? assert(~self.ErrCode(),'Method StringToFile<13,10>Error:' & self.ErrCode())
  return choose(~self.ErrCode(), clip(locFileName), '')
!
GraphPrimitiveClass.WMFHeader  procedure(gPositionType parPos)
locWMFH       like(winAPMFileHeaderType), auto      ! the Aldus Placeable Metafile (APM) format
locWMFH:Over  ushort,dim(10),over(locWMFH)
locHDC        unsigned
locHInch      signed
locVInch      signed
locI          long
 code
  if self.CheckTarget() then return '' end
  clear(locWMFH)
  locHDC = GetDC(0)
  if ~self.CheckHandle(locHDC)
    locHInch = GetDeviceCaps(locHDC, winLOGPIXELSX)
    locVInch = GetDeviceCaps(locHDC, winLOGPIXELSY)
    if ReleaseDC(0, locHDC)
      locWMFH.eKey = 9AC6CDD7h
      if locHInch >= locVInch
        locWMFH.eInch   = locHInch
        locWMFH.eLeft   = parPos.eX
        locWMFH.eTop    = round(parPos.eY * locHInch / locVInch,1)
        locWMFH.eRight  = parPos.eW
        locWMFH.eBottom = round(parPos.eH * locHInch / locVInch,1)
      else
        locWMFH.eInch   = locVInch
        locWMFH.eLeft   = round(parPos.eX * locVInch / locHInch,1)
        locWMFH.eTop    = parPos.eY
        locWMFH.eRight  = round(parPos.eW * locVInch / locHInch,1)
        locWMFH.eBottom = parPos.eH
      end
      loop locI = 1 to 10
        locWMFH.eChecksum = bxor(locWMFH.eChecksum, locWMFH:Over[locI])
      end
    else
      self.ErrWinCode
    end
  end
  if self.ErrCode()
?   assert(~self.ErrCode(),'Method WMFHeader<13,10>Error:' & self.ErrCode() &' '& self.ErrWinMessage(self.ErrCode()))
    return ''
  end
  return locWMFH
!
GraphBasicClass.Construct           procedure
 code
  if self.qGraph &= null then self.qGraph &= new(qGraphType) end
  self.Free:qGraph ; self.Clear:qGraph
  if self.qCluster &= null then self.qCluster &= new(qClusterType) end
  self.Free:qCluster ; self.Clear:qCluster
  if self.qSelectedGraph &= null then self.qSelectedGraph &= new(qSelectedGraphType) end
  self.Free:qSelectedGraph ; clear(self.qSelectedGraph)
  if self.oTitle &= null then self.oTitle &= new(GraphTitleClass) end
  self.oTitle.Init(self.iText)
  if self.oLegend &= null then self.oLegend &= new(GraphLegendClass) end
  self.oLegend.Init(self.iLegend, self.qGraph)
!
GraphBasicClass.Destruct            procedure
 code
  if ~(self.qGraph &= null)
    self.Free:qGraph
    dispose(self.qGraph)
  end
  if ~(self.qSelectedGraph &= null)
    self.Free:qSelectedGraph
    dispose(self.qSelectedGraph)
  end
  if ~(self.oLegend &= null) then dispose(self.oLegend) end
  if ~(self.oTitle &= null) then dispose(self.oTitle) end
!
GraphBasicClass.Free:qGraph         procedure
 code
  if ~(self.qGraph &= null)
    self.Set(self.qGraph)
    loop until self.Next(self.qGraph)
      self.qGraph.eName &= null
      if ~(self.qGraph.qNode &= null)
        self.Set(self.qGraph.qNode)
        loop until self.Next(self.qGraph.qNode)
          self.qGraph.qNode.eName &= null
          self.qGraph.qNode.eTip &= null
          if ~(self.qGraph.qNode.oNode &= null) then dispose(self.qGraph.qNode.oNode) end
        end
        dispose(self.qGraph.qNode)
      end
      if ~(self.qGraph.oDiagram &= null) then dispose(self.qGraph.oDiagram) end
    end
    free(self.qGraph)
  end
!
GraphBasicClass.Clear:qGraph        procedure
 code
  if ~self.Null(self.qGraph)
    clear(self.qGraph)
  end
!
GraphBasicClass.GraphSearch         procedure(string parGraph, bool parCheckID=true)
! Find diagram in list
 code
  if self.Null(self.qGraph) then return self.ErrCode() end
  if parCheckID and numeric(parGraph)               ! If a number then
    self.qGraph.eID = parGraph
    get(self.qGraph, self.qGraph.eID)               ! Searching by number
  else                                              ! Else searching by name
    parGraph = upper(parGraph)
    self.Set(self.qGraph)
    loop until self.Next(self.qGraph)
      if upper(self.qGraph.eName) = parGraph
        return false
      end
    end
  end
  return errorcode()
!
GraphBasicClass.GraphAdd                 procedure(string parName, long parType=GraphType:Line)
! Add diagram to the list
locID       long
locColor    long
 code
  if ~self.GraphSearch(parName, false)              ! Searching by the name
    return choose(~self.ErrCode(), true, self.ErrCode()) ! If is found then the diagram is not added
  end
  sort(self.qGraph, +self.qGraph.eID)
  if ~self.Set(self.qGraph, -1)                ! Looking for the last number
    locID = self.qGraph.eID
  end
  locColor = self.GraphNextColor()
  self.Clear:qGraph
  self.qGraph.eID           = locID + 1
  self.qGraph.eName         = parName
  self.qGraph.eType         = parType
  self.qGraph.gFill.eColor  = locColor
  self.qGraph.gFill.eColor2 = color:none
  self.qGraph.ePieDepth     = self.ePieDepth
  add(self.qGraph, +self.qGraph.eID)
  return self.ErrCode(errorcode())
!
GraphBasicClass.GraphFill           procedure(<long parColor>, <long parColor2>, <long parStyle>)
 code
  if self.Null(self.qGraph) then return end
  if ~omitted(2) then self.qGraph.gFill.eColor = parColor end
  if ~omitted(3) then self.qGraph.gFill.eColor2 = parColor2 end
  if ~omitted(4) then self.qGraph.gFill.eStyle = parStyle end
  put(self.qGraph)
  self.ErrCode(errorcode())
!
GraphBasicClass.GraphNextColor      procedure
! Search of the next colour of the diagram
savPointer      long
savPointerNode  long
locColor        long(color:none)
locI            long
 code
  if self.Null(self.qGraph) then return locColor end
  savPointer = pointer(self.qGraph)
  if ~(self.qGraph.qNode &= null)
    savPointerNode = pointer(self.qGraph.qNode)
  end
  self.Set(self.qGraph)
  loop
    locI += 1
    locColor = self.NextColor(locI)
    self.qGraph.gFill.eColor = locColor
    get(self.qGraph, +self.qGraph.gFill.eColor)
  until errorcode()
  if ~self.Set(self.qGraph, savPointer)
    if ~(self.qGraph.qNode &= null)
      self.Set(self.qGraph.qNode, savPointerNode)
    end
  end
  return locColor
!
! The list of clusters ------------------------------------------------------------------
GraphBasicClass.Free:qCluster       procedure
 code
  if ~self.Null(self.qCluster)
    self.Set(self.qCluster)
    loop until self.Next(self.qCluster)
      if ~(self.qCluster.oText &= null)
        dispose(self.qCluster.oText)
      end
    end
    free(self.qCluster)
  end
!
GraphBasicClass.Clear:qCluster      procedure
 code
  if ~self.Null(self.qCluster)
    clear(self.qCluster)
  end
!
GraphBasicClass.ClusterAdd          procedure(string parName, <string parText>, <long parCalcType>)
! The method adds parameters of group for the diagrams such as BarChart, ColumnChart etc.
locID      long
 code
  if self.Null(self.qCluster) then return self.ErrCode() end
  if self.ClusterSearch(parName, false)
    if ~self.Set(self.qCluster, -1)            ! Search of last number
      locID = self.qCluster.eID
    end
    clear(self.qCluster)
    self.qCluster.eID = locID + 1
    self.qCluster.eName = parName
    do r:SetText
    if ~omitted(4) then self.qCluster.eCalcType = parCalcType end
    add(self.qCluster, +self.qCluster.eID)
  else
    do r:SetText
    if ~omitted(4) then self.qCluster.eCalcType = parCalcType end
    put(self.qCluster)
  end
  return self.ErrCode(errorcode())
!
r:SetText     routine
  if ~omitted(3)
    if self.qCluster.oText &= null
      self.qCluster.oText &= new(GraphTextClass)
    end
    self.qCluster.oText.Init(self.iText)
    self.qCluster.oText.SetText(parText)
  end
!
GraphBasicClass.ClusterSearch       procedure(string parCluster, bool parCheckID=true)
! Find cluster in list
 code
  if self.Null(self.qCluster) then return self.ErrCode() end
  if parCheckID and numeric(parCluster)             ! If a number then
    self.qCluster.eID = parCluster
    get(self.qCluster, +self.qCluster.eID)          ! Searching by number
  else                                              ! Else searching by name
    parCluster = upper(parCluster)
    self.Set(self.qCluster)
    loop until self.Next(self.qCluster)
      if upper(self.qCluster.eName) = parCluster
        return false
      end
    end
  end
  return errorcode()
!
! ---------------------------------------------------------------------------------------
GraphBasicClass.Clear:qNode          procedure
 code
  if ~self.Null(self.qGraph.qNode)
    clear(self.qGraph.qNode)
    self.qGraph.qNode.gFill.eColor = color:none
    self.qGraph.qNode.gFill.eColor2 = color:none
  end
!
GraphBasicClass.Free:qSelectedGraph  procedure
 code
  if ~self.Null(self.qSelectedGraph)
    self.Set(self.qSelectedGraph)
    loop until self.Next(self.qSelectedGraph)
      if ~(self.qSelectedGraph.qSelectedNode &= null)
        dispose(self.qSelectedGraph.qSelectedNode)
      end
    end
    free(self.qSelectedGraph)
  end
!
GraphBasicClass.NodeSearch          procedure(string parNode, bool parCheckID=true)
! Node search in list of current diagram
 code
  if self.Null(self.qGraph.qNode) then return self.ErrCode() end
  if parCheckID and numeric(parNode)                ! If a number then
    self.qGraph.qNode.eID = parNode
    get(self.qGraph.qNode, +self.qGraph.qNode.eID)  ! Searching by number
  else                                              ! Else searching by name
    parNode = upper(parNode)
    self.Set(self.qGraph.qNode)
    loop until self.Next(self.qGraph.qNode)
      if upper(self.qGraph.qNode.eName) = parNode
        return false
      end
    end
  end
  return errorcode()
!
GraphBasicClass.NodeAdd             procedure(real parX, real parY, <long parType>, <string parName>, long parClusterID=0)
! Add node to the list
locID      long
 code
  if self.Null(self.qGraph) then return self.ErrCode() end
  if self.qGraph.qNode &= null
    self.qGraph.qNode &= new(qNodeType)
    put(self.qGraph)
    if self.ErrCode(errorcode())
      return self.ErrCode()
    end
  end
  sort(self.qGraph.qNode, +self.qGraph.qNode.eID)
  if ~self.Set(self.qGraph.qNode, -1)          ! Looking for the last number
    locID = self.qGraph.qNode.eID
  end
  self.Clear:qNode
  self.qGraph.qNode.eID         = locID + 1
  self.qGraph.qNode.eClusterID  = parClusterID
  self.qGraph.qNode.gXY.eX      = parX              ! Absolute units
  self.qGraph.qNode.gXY.eY      = parY
  if ~omitted(4) then self.qGraph.qNode.eType = parType end
  self.qGraph.qNode.gFill.eColor = color:auto
  self.qGraph.qNode.gFill.eColor2 = color:none
  if ~omitted(5) then self.qGraph.qNode.eName = clip(parName) end
  add(self.qGraph.qNode, +self.qGraph.qNode.eID)
  if ~self.ErrCode(errorcode())
    self.UpdatingMinMax
  end
  if self.qGraph.qNode.eClusterID
    if ~self.ClusterSearch(self.qGraph.qNode.eClusterID)
      self.qCluster.gSum.eX += self.qGraph.qNode.gXY.eX
      self.qCluster.gSum.eY += self.qGraph.qNode.gXY.eY
      self.qCluster.eNodes += 1
      if pointer(self.qGraph) % 2 then self.qCluster.eNodesFloat +=1 end
      put(self.qCluster)
      self.ErrCode(errorcode())
    end
  end
  return self.ErrCode()
!
GraphBasicClass.NodeFill            procedure(<long parColor>, <long parColor2>, <long parStyle>)
 code
  if self.Null(self.qGraph.qNode) then return end
  if ~omitted(2) then self.qGraph.qNode.gFill.eColor = parColor end
  if ~omitted(3) then self.qGraph.qNode.gFill.eColor2 = parColor2 end
  if ~omitted(4) then self.qGraph.qNode.gFill.eStyle = parStyle end
  put(self.qGraph.qNode)
  self.ErrCode(errorcode())
!
GraphBasicClass.NodeUpdate          procedure(long parNode, <real parX>, <real parY>, |
                                              <long parType>, <*gFillType parFill>, <string parName>)
! Renew node in the list
 code
  if ~self.NodeSearch(parNode)                      ! Searching by number (number is node's ID)
    if ~omitted(3) then self.qGraph.qNode.gXY.eX = parX end
    if ~omitted(4) then self.qGraph.qNode.gXY.eY = parY end
    if ~omitted(5) then self.qGraph.qNode.eType = parType end
    if ~omitted(6) then self.qGraph.qNode.gFill = parFill end
    if ~omitted(7) then self.qGraph.qNode.eName = clip(parName) end
    put(self.qGraph.qNode)
    if ~self.ErrCode(errorcode())
      self.UpdatingMinMax
    end
  end
  return self.ErrCode()
!
GraphBasicClass.UpdatingMinMax      procedure
savID    long, auto
savY      real, auto
 code
  if self.Null(self.qGraph.qNode) then return self.ErrCode() end
  ! Calculation of a minimum and maximum
  savID = self.qGraph.qNode.eID                     ! Saving of number of node
  savY = self.qGraph.qNode.gXY.eY
  if self.qGraph.eNodeMinID
    if ~self.NodeSearch(self.qGraph.eNodeMinID)
      if self.qGraph.qNode.gXY.eY > savY
        self.qGraph.eNodeMinID = savID
      end
    end
  else
    self.qGraph.eNodeMinID = savID
  end
  if self.qGraph.eNodeMaxID
    if ~self.NodeSearch(self.qGraph.eNodeMaxID)
      if self.qGraph.qNode.gXY.eY < savY
        self.qGraph.eNodeMaxID = savID
      end
    end
  else
    self.qGraph.eNodeMaxID = savID
  end
  put(self.qGraph)
  if ~self.ErrCode(errorcode())
    self.NodeSearch(savID)                          ! Restoration of the pointer
  end
  return self.ErrCode()
!
GraphBasicClass.CalculationMinMax   procedure
savID     long
savY      real
 code
  if self.Null(self.qGraph.qNode) then return self.ErrCode() end
  savID = self.qGraph.qNode.eID                     ! Saving of number of node
  clear(self.qGraph.eNodeMinID)
  clear(self.qGraph.eNodeMaxID)
  if ~self.Set(self.qGraph.qNode,1)
    self.qGraph.eNodeMinID = self.qGraph.qNode.eID
    self.qGraph.eNodeMaxID = self.qGraph.qNode.eID
    savY = self.qGraph.qNode.gXY.eY
    loop until self.Next(self.qGraph.qNode)
      if self.qGraph.qNode.gXY.eY < savY
        self.qGraph.eNodeMinID = self.qGraph.qNode.eID
      end
      if self.qGraph.qNode.gXY.eY > savY
        self.qGraph.eNodeMaxID = self.qGraph.qNode.eID
      end
    end
  end
  put(self.qGraph)
  if ~self.ErrCode(errorcode())
    self.NodeSearch(savID)                          ! Restoration of the pointer
  end
  return self.ErrCode()
!
GraphBasicClass.NodeDelete          procedure(long parNode)
! Remove node from the list
locUpdateCluster      bool
 code
  if ~self.NodeSearch(parNode)                      ! Searching by number (number is node's ID)
    self.qGraph.qNode.eName &= null
    self.qGraph.qNode.eTip &= null
    if ~(self.qGraph.qNode.oNode &= null) then dispose(self.qGraph.qNode.oNode) end
    delete(self.qGraph.qNode)
    if ~self.ErrCode(errorcode())
      self.CalculationMinMax
    end
  end
  if self.qGraph.qNode.eClusterID
    if ~self.ClusterSearch(self.qGraph.qNode.eClusterID)
      if self.qCluster.eNodes > 0
        self.qCluster.eNodes -= 1
        locUpdateCluster = true
      end
      if pointer(self.qGraph) % 2 and self.qCluster.eNodesFloat > 0
        self.qCluster.eNodesFloat -=1
        locUpdateCluster = true
      end
      if locUpdateCluster
        put(self.qCluster)
        self.ErrCode(errorcode())
      end
    end
  end
  return self.ErrCode()
!
GraphBasicClass.Hide                procedure       ! Hide the graphic
 code
 if ~self.Fparent(){prop:hide} then self.Fparent(){prop:hide} = true end
!
GraphBasicClass.UnHide              procedure       ! UnHide the graphic
 code
 if self.Fparent(){prop:hide} then self.Fparent(){prop:hide} = false end
!
GraphBasicClass.SetSelectedNode     procedure(long parGraphID=-1, long parNodeID=-1)
 code
  if ~self.Set(self.qSelectedGraph, parGraphID)
    self.Set(self.qSelectedGraph.qSelectedNode, parNodeID)
  end
  self.SynchronizeWithSelectedNode
  return self.ErrCode()
!
GraphBasicClass.SynchronizeWithSelectedNode procedure
 code
  self.Clear:qGraph
  if self.Null(self.qSelectedGraph) or self.Null(self.qGraph) then return end
  if ~self.Null(self.qSelectedGraph.qSelectedNode)
    self.qGraph.eID = self.qSelectedGraph.eID
    get(self.qGraph, +self.qGraph.eID)
    if ~self.ErrCode(errorcode())
      if ~self.Null(self.qGraph.qNode)
        self.qGraph.qNode.eID = self.qSelectedGraph.qSelectedNode.eID
        get(self.qGraph.qNode, +self.qGraph.qNode.eID)
        if errorcode()
          self.Clear:qNode
        end
      end
    end
  end
!
GraphBasicClass.NextSelectedNode    procedure
 code
  loop until ~self.Next(self.qSelectedGraph.qSelectedNode)
  until self.Next(self.qSelectedGraph)
  self.SynchronizeWithSelectedNode
  return self.ErrCode()
!
GraphBasicClass.PreviousSelectedNode procedure
 code
  loop until ~self.Previous(self.qSelectedGraph.qSelectedNode)
  until self.Previous(self.qSelectedGraph)
  self.SynchronizeWithSelectedNode
  return self.ErrCode()
!
GraphBasicClass.RegionZoom               procedure(bool parEnable=true)
locRect   like(winRECTtype)
 code
  if self.CheckTarget() then return end
  if self.eFRegionZoom and self.eFBand
    if ~parEnable
      if ~self.eFRegionZoom{prop:hide} then self.eFRegionZoom{prop:hide} = true end
    else
      GetClientRect(self.eFBand{prop:Handle}, locRect)
      MapWindowRECT(self.eFBand{prop:Handle}, self.eWindow{prop:ClientHandle}, locRect)
      setposition(self.eFRegionZoom, locRect.eLeft, locRect.eTop, |
                  locRect.eRight - locRect.eLeft, locRect.eBottom - locRect.eTop)
      if self.eFRegionZoom{prop:hide} then self.eFRegionZoom{prop:hide} = false end
    end
  end
!
! iText Interface
GraphBasicClass.iText.FParent       procedure
 code
  return self.eFParent
!
GraphBasicClass.iText.PushFont      procedure
 code
  self.PushFont
!
GraphBasicClass.iText.PopFont       procedure
 code
  self.PopFont
!
GraphBasicClass.iText.SetFont       procedure(*gFontType parFont, long parField=0)
 code
  self.SetFont(parFont, parField)
!
GraphBasicClass.iText.PushStyle     procedure
 code
  self.PushStyle
!
GraphBasicClass.iText.PopStyle      procedure
 code
  self.PopStyle
!
GraphBasicClass.iText.SetStyle      procedure(<long parColor>, <long parPenWidth>, <long parPenStyle>)
 code
  if omitted(2) and omitted(3) and omitted(4)
    self.SetStyle
  elsif ~omitted(2) and omitted(3) and omitted(4)
    self.SetStyle(parColor)
  elsif omitted(2) and ~omitted(3) and omitted(4)
    self.SetStyle(,parPenWidth)
  elsif omitted(2) and omitted(3) and ~omitted(4)
    self.SetStyle(,,parPenStyle)
  elsif ~omitted(2) and ~omitted(3) and omitted(4)
    self.SetStyle(parColor,parPenWidth)
  elsif ~omitted(2) and omitted(3) and ~omitted(4)
    self.SetStyle(parColor,,parPenStyle)
  elsif ~omitted(2) and omitted(3) and ~omitted(4)
    self.SetStyle(,parPenWidth,parPenStyle)
  else
    self.SetStyle(parColor,parPenWidth,parPenStyle)
  end
!
GraphBasicClass.iText.GetTextPoint  procedure(long parField=0, string parText, <*? parW>, <*? parH>)
 code
  if omitted(4) and ~omitted(5)
    self.GetTextPoint(parField, parText,, parH)
  elsif ~omitted(4) and omitted(5)
    self.GetTextPoint(parField, parText, parW)
  else
    self.GetTextPoint(parField, parText, parW, parH)
  end
!
GraphBasicClass.iText.Box           procedure(real parX, real parY, real parW, real parH, <*gFillType parFill>)
 code
  if omitted(6)
    self.Box(parX, parY, parW, parH)
  else
    self.Box(parX, parY, parW, parH, parFill)
  end
!
GraphBasicClass.iText.FactorYb      procedure(<real parValue>)
 code
  return choose(~omitted(2), self.FactorYb(parValue), self.FactorYb())
!
GraphBasicClass.iText.ToX           procedure(real parValue)
 code
  return self.ToX(parValue)
!
GraphBasicClass.iText.ToY           procedure(real parValue)
 code
  return self.ToY(parValue)
!
! iLegend interface
GraphBasicClass.iLegend.Null        procedure(*queue parQ)
 code
  return self.Null(parQ)
!
GraphBasicClass.iLegend.Set         procedure(*queue parQ, signed parPointer=0)
 code
  return self.Set(parQ, parPointer)
!
GraphBasicClass.iLegend.Next        procedure(*queue parQ)
 code
  return self.Next(parQ)
!
GraphBasicClass.iLegend.Previous    procedure(*queue parQ)
 code
  return self.Previous(parQ)
!
GraphBasicClass.iLegend.ErrCode     procedure(<signed parValue>)
 code
  return self.ErrCode(parValue)
!
GraphBasicClass.iLegend.PushStyle   procedure
 code
  self.PushStyle
!
GraphBasicClass.iLegend.PopStyle    procedure
 code
  self.PopStyle
!
GraphBasicClass.iLegend.SetStyle    procedure(<long parColor>, <long parPenWidth>, <long parPenStyle>)
 code
  if omitted(2) and omitted(3) and omitted(4)
    self.SetStyle
  elsif ~omitted(2) and omitted(3) and omitted(4)
    self.SetStyle(parColor)
  elsif omitted(2) and ~omitted(3) and omitted(4)
    self.SetStyle(,parPenWidth)
  elsif omitted(2) and omitted(3) and ~omitted(4)
    self.SetStyle(,,parPenStyle)
  elsif ~omitted(2) and ~omitted(3) and omitted(4)
    self.SetStyle(parColor,parPenWidth)
  elsif ~omitted(2) and omitted(3) and ~omitted(4)
    self.SetStyle(parColor,,parPenStyle)
  elsif ~omitted(2) and omitted(3) and ~omitted(4)
    self.SetStyle(,parPenWidth,parPenStyle)
  else
    self.SetStyle(parColor,parPenWidth,parPenStyle)
  end
!
GraphBasicClass.iLegend.Window      procedure
 code
  return address(self.eWindow)
!
GraphBasicClass.iLegend.PushFont    procedure
 code
  self.PushFont
!
GraphBasicClass.iLegend.PopFont     procedure
 code
  self.PopFont
!
GraphBasicClass.iLegend.SetFont     procedure(*gFontType parFont, long parField=0)
 code
  self.SetFont(parFont, parField)
!
GraphBasicClass.iLegend.GetTextPoint procedure(long parField=0, string parText, <*? parW>, <*? parH>)
 code
  if ~omitted(4) and ~omitted(5)
    self.GetTextPoint(parField, parText, parW, parH)
  elsif ~omitted(4) and omitted(5)
    self.GetTextPoint(parField, parText, parW)
  elsif omitted(4) and ~omitted(5)
    self.GetTextPoint(parField, parText,, parH)
  else
    self.GetTextPoint(parField, parText)
  end
!
GraphBasicClass.iLegend.Show        procedure(real parX, real parY, string parText, <gFontType parFont>, |
                                              long parBgrColor=color:none, long parBorderColor=color:none)
 code
  if omitted(5)
    self.Show(parX, parY, parText,, parBgrColor, parBorderColor)
  else
    self.Show(parX, parY, parText, parFont, parBgrColor, parBorderColor)
  end
!
GraphBasicClass.iLegend.Box         procedure(real parX, real parY, real parW, real parH, <*gFillType parFill>)
 code
  if omitted(6)
    self.Box(parX, parY, parW, parH)
  else
    self.Box(parX, parY, parW, parH, parFill)
  end
!
GraphBasicClass.iLegend.RoundBox    procedure(real parX, real parY, real parW, real parH, <*gFillType parFill>)
 code
  if omitted(6)
    self.RoundBox(parX, parY, parW, parH)
  else
    self.RoundBox(parX, parY, parW, parH, parFill)
  end
!
GraphBasicClass.iLegend.NextColor   procedure(long parNum, long parPalette=256)
 code
  return self.NextColor(parNum, parPalette)
!
GraphBasicClass.iLegend.GraphType   procedure
 code
  return self.eGraphType
!
GraphBasicClass.iLegend.GetFont     procedure(*gFontType parFont)
 code
  self.GetFont(parFont, self.FParent())
GraphAxisClass.Construct            procedure
 code
  if self.oAxisXname &= null then self.oAxisXname &= new(GraphTextClass) end
  self.oAxisXname.Init(self.iText)
  if self.oAxisYname &= null then self.oAxisYname &= new(GraphTextClass) end
  self.oAxisYname.Init(self.iText)
  if self.qStrokeX &= null then self.qStrokeX &= new(qStrokeType) end
  free(self.qStrokeX) ; clear(self.qStrokeX)
  if self.qStrokeY &= null then self.qStrokeY &= new(qStrokeType) end
  free(self.qStrokeY) ; clear(self.qStrokeY)
!
GraphAxisClass.Destruct             procedure
 code
  if ~(self.qStrokeX &= null) then dispose(self.qStrokeX) end
  if ~(self.qStrokeY &= null) then dispose(self.qStrokeY) end
  if ~(self.oAxisYname &= null) then dispose(self.oAxisYname) end
  if ~(self.oAxisXname &= null) then dispose(self.oAxisXname) end
!
GraphAxisClass.SetFactor            procedure(<real parFx>, <real parFy>)
! Sets factors for transformation of absolute coordinates to logic coordinates
 code
  if ~omitted(2) then self.gAxisFactor.eX = parFx end
  if ~omitted(3) then self.gAxisFactor.eY = parFy end
  if self.gAxisFactor.eX=0 then self.gAxisFactor.eX = 1 end
  if self.gAxisFactor.eY=0 then self.gAxisFactor.eY = 1 end
!
GraphAxisClass.AToLX                procedure(real parValue)
! Transformation of absolute values to logic coordinates of an axis X
 code
  return parValue/self.gAxisFactor.eX
!
GraphAxisClass.AToLY      procedure(real parValue)
! Transformation of absolute values to logic coordinates of an axis Y
 code
  return parValue/self.gAxisFactor.eY
!
GraphAxisClass.SetMinMax            procedure(<real parXmin>, <real parXmax>, <real parYmin>, <real parYmax>)
! Sets min./max. values for the axes
 code
  if ~omitted(2) then self.gAxisMin.eX = parXmin end
  if ~omitted(3) then self.gAxisMax.eX = parXmax end
  if ~omitted(4) then self.gAxisMin.eY = parYmin end
  if ~omitted(5) then self.gAxisMax.eY = parYmax end
!
GraphAxisClass.CalcMinMax           procedure
! Compute min./max. logical coordinates by real data
 code
  clear(self.gAxisMin.eX)
  clear(self.gAxisMin.eY)
  clear(self.gAxisMax.eX,-1)
  clear(self.gAxisMax.eY,-1)
  case self.eGraphType
  of GraphType:ColumnWithAccumulation
  orof GraphType:BarWithAccumulation
    self.Set(self.qCluster)                    ! Cycle through the cluster
    loop until self.Next(self.qCluster)
      if self.gAxisMax.eX < self.qCluster.gSum.eX
        self.gAxisMax.eX = self.qCluster.gSum.eX
      end
      if self.gAxisMax.eY < self.qCluster.gSum.eY
        self.gAxisMax.eY = self.qCluster.gSum.eY
      end
    end
  else
    if self.AxesScaleMinMax()
      clear(self.gAxisMin.eX,1)
      clear(self.gAxisMin.eY,1)
    end
    self.Set(self.qGraph)                      ! Cycle through the diagrams
    loop until self.Next(self.qGraph)
      if self.Set(self.qGraph.qNode)<>30 then cycle end
      loop until self.Next(self.qGraph.qNode)  ! Cycle through the nodes
        if self.AxesScaleMinMax()
          if self.gAxisMin.eX > self.qGraph.qNode.gXY.eX
            self.gAxisMin.eX = self.qGraph.qNode.gXY.eX
          end
          if self.gAxisMin.eY > self.qGraph.qNode.gXY.eY
            self.gAxisMin.eY = self.qGraph.qNode.gXY.eY
          end
        end
        if self.gAxisMax.eX < self.qGraph.qNode.gXY.eX
          self.gAxisMax.eX = self.qGraph.qNode.gXY.eX
        end
        if self.gAxisMax.eY < self.qGraph.qNode.gXY.eY
          self.gAxisMax.eY = self.qGraph.qNode.gXY.eY
        end
      end
    end
  end
!
GraphAxisClass.CalcAxes             procedure  ! Calculation of axes
locW      real, auto
 code
  free(self.qStrokeX)
  free(self.qStrokeY)
  !
  if ~band(self.eAxesStyle,AxesStyle:NoneX) and self.eAxisXname
    self.oAxisXName.SetRectangle(0,0,0,0)
    self.oAxisXName.Calculate
    self.oAxisXName.SetRectangle(self.gGraphDist.eL,self.gGraphDist.eB)
    self.gGraphDist.eB += self.oAxisXname.eH
  end
  if ~band(self.eAxesStyle,AxesStyle:NoneY) and self.eAxisYname
    self.oAxisYName.SetRectangle(0,0,0,0)
    self.oAxisYName.Calculate
    self.oAxisYName.SetRectangle(self.gGraphDist.eL,self.gGraphRect.eH - self.gGraphDist.eT - self.oAxisYname.eH)
    self.gGraphDist.eT += self.oAxisYname.eH
  end
  !
  if ~band(self.eAxesStyle,AxesStyle:NoneX)         ! If have to draw the axis
    self.gGraphDist.eB += self.eAxisYThickness
    self.gGraphDist.eR += 5 + self.eAxisXThickness  ! X-axis arrow length
  end
  if ~band(self.eAxesStyle,AxesStyle:NoneY)         ! If have to draw the axis
    self.gGraphDist.eL += self.eAxisXThickness
    self.gGraphDist.eT += 5 + self.eAxisYThickness  ! Y-axis arrow length
  end
  !
  ! Calculate axes
  case self.eGraphType
  of GraphType:ColumnChart                          ! Histogram (vertical columns)
  orof GraphType:FloatingColumn                     ! The floating columns
  orof GraphType:ColumnWithAccumulation
    self.SetFactor(0,(self.gAxisMax.eY-self.gAxisMin.eY)/self.gGraphRect.eH)
    self.gGraphDist.eL += self.GetYTextMaxWidth()
    self.CalcAxisBar(self.qStrokeX,1)               ! Calculation of a horizontal axis
    if self.e3D
      ! Adjusting indent from the top
      self.gGraphDist.eT += choose(~self.eBarDepth, self.eBarRadius, self.eBarDepth) * sin(equ:DegToRad*45)
    end
    self.gGraphDist.eB += self.GetXTextMaxHeight()
    self.CalcAxis(self.qStrokeY, 2)                 ! Calculation of a vertical axis
  of GraphType:BarChart                             ! Histogram (horizontal columns)
  orof GraphType:FloatingBar
  orof GraphType:BarWithAccumulation
    self.SetFactor((self.gAxisMax.eY-self.gAxisMin.eY)/self.gGraphRect.eW,0)
    self.gGraphDist.eB += self.GetXTextMaxHeight()
    self.CalcAxisBar(self.qStrokeY, 2)              ! Calculating vertical axis
    if self.e3D
      ! Adjusting indent from the right
      self.gGraphDist.eR += choose(~self.eBarDepth, self.eBarRadius, self.eBarDepth) * sin(equ:DegToRad*45)
    end
    self.gGraphDist.eL += self.GetYTextMaxWidth()
    self.CalcAxis(self.qStrokeX, 1)                 ! Calculation of a horizontal axis
  else
    ! Define scale step in abstract units
    self.SetFactor((self.gAxisMax.eX-self.gAxisMin.eX)/(self.gGraphRect.eW - self.gGraphDist.eL - self.gGraphDist.eR),|
                   (self.gAxisMax.eY-self.gAxisMin.eY)/(self.gGraphRect.eH - self.gGraphDist.eT - self.oAxisYname.eH))
    self.gGraphDist.eB += self.GetXTextMaxHeight()
    self.CalcAxis(self.qStrokeY, 2)                 ! Calculation of a vertical axis
    self.gGraphDist.eL += self.GetYTextMaxWidth()
    self.CalcAxis(self.qStrokeX, 1)                 ! Calculation of a horizontal axis
  end
  ! Correction of Coordinates
  locW = self.gGraphRect.eW - self.gGraphDist.eL - self.gGraphDist.eR
  if ~band(self.eAxesStyle,AxesStyle:NoneX) and self.eAxisXname
    ! Right alignment
    if locW > self.oAxisXName.eW
      self.oAxisXName.SetRectangle(self.gGraphDist.eL+(locW-self.oAxisXName.eW))
    else
      self.oAxisXName.SetRectangle(self.gGraphDist.eL,, locW)
    end
  end
  if ~band(self.eAxesStyle,AxesStyle:NoneY) and self.eAxisYname
    if locW > self.oAxisYName.eW
      self.oAxisYName.SetRectangle(self.gGraphDist.eL)
    else
      self.oAxisYName.SetRectangle(self.gGraphDist.eL,, locW)
    end
  end
!
GraphAxisClass.CalcAxis             procedure(qStrokeType parQ, long parAxis)
locI            long
locDelta        long
locD            real
locBy           real, auto
locLength       real, auto
locNone         long
locThickness    real
locGrid         bool
!
locMax          real
locExponent     long
locCoefficient  real
locMaximumScale real
 code
  free(parQ)
  case parAxis
  of 1                                              ! Axis X
    locBy = abs(self.ToLW(self.eAxisXScaleInterval))*2 ! Scale interval
    locThickness = self.eAxisXThickness
    locGrid = choose(self.eAxesGrid and self.eAxisXGrid)
    ! (IMAGE width - left indent - arrow length)
    locLength = self.gGraphRect.eW - self.gGraphDist.eL - self.gGraphDist.eR - locBy
    case self.eGraphType
    ! Define minimal scale step in absolute units
    of GraphType:BarChart
    orof GraphType:FloatingBar
    orof GraphType:BarWithAccumulation
      self.SetFactor((self.gAxisMax.eY-self.gAxisMin.eY)/locLength)
      locMax = self.gAxisMax.eY-self.gAxisMin.eY
    else
      self.SetFactor((self.gAxisMax.eX-self.gAxisMin.eX)/locLength)
      locMax = self.gAxisMax.eX-self.gAxisMin.eX
    end
    locNone = AxesStyle:NoText + AxesStyle:NoneX
    case choose(self.eAxesScale = Scale:Default, self.eAxesXScale, self.eAxesScale)
    of Scale:AsMSWord                               ! As Word
      do r:CalcAsWord
      locBy = locLength / (locMaximumScale/(locCoefficient*10^locExponent)) / 10
      self.SetFactor(locMaximumScale/locLength)
    end
  of 2                                              ! Axis Y
    locBy = abs(self.ToLH(self.eAxisYScaleInterval))*2 ! Scale interval
    locThickness = self.eAxisYThickness
    locGrid = choose(self.eAxesGrid and self.eAxisYGrid)
    ! (IMAGE height - bottom indent - top indent)
    locLength = self.gGraphRect.eH - self.gGraphDist.eB - self.gGraphDist.eT - locBy
    ! Correcting scale step in absolute units
    self.SetFactor(,(self.gAxisMax.eY-self.gAxisMin.eY)/locLength)
    locNone = AxesStyle:NoText + AxesStyle:NoneY
    case choose(self.eAxesScale = Scale:Default, self.eAxesXScale, self.eAxesScale)
    of Scale:AsMSWord                               ! As Word
      locMax = self.gAxisMax.eY-self.gAxisMin.eY
      do r:CalcAsWord
      locBy = locLength / (locMaximumScale/(locCoefficient*10^locExponent)) / 10
      self.SetFactor(, locMaximumScale/locLength)
    end
  else
    return
  end
  ! Calculation of a scale --------------------------------------------------------------
  loop
    locD += locBy
    if locD > locLength then break end
    locI += 1
    self.StrokeAdd(parQ, locI,, locD)
    if ~(locI % 10)
      if band(self.eAxesStyle,AxesStyle:NoStroke3) then cycle end ! DON'T display
      if ~band(self.eAxesStyle,locNone)             ! If we have to display text then
        case parAxis
        of 1                                        ! Axis X
          if self.eAxisXFormat                      ! Horizontal axis' number format
            case self.eGraphType
            of GraphType:BarChart
            orof GraphType:FloatingBar
            orof GraphType:BarWithAccumulation
              parQ.eText = format(self.gAxisMin.eY+locD*self.gAxisFactor.eX,self.eAxisXFormat)
            else
              parQ.eText = format(self.gAxisMin.eX+locD*self.gAxisFactor.eX,self.eAxisXFormat)
            end
          else
            ! Automatic numbers formatting
            case self.eGraphType
            of GraphType:BarChart
            orof GraphType:FloatingBar
            orof GraphType:BarWithAccumulation
              parQ.eText = round(self.gAxisMin.eY+locD*self.gAxisFactor.eX,self.gAxisFactor.eX)
            else
              parQ.eText = round(self.gAxisMin.eX+locD*self.gAxisFactor.eX,self.gAxisFactor.eX)
            end
          end
          self.GetTextPoint(self.FParent(), clip(parQ.eText), parQ.eTextW, parQ.eTextH)
        of 2                                        ! Axis Y
          parQ.eText = self.GetYTextPoint(self.gAxisMin.eY+locD*self.gAxisFactor.eY,|
                                          self.qStrokeY.eTextW, self.qStrokeY.eTextH)
        end
        self.GetFont(parQ.gFont, self.FParent())
      end
      parQ.eLen  = 10                               ! Thick stroke
      parQ.eThickness = 1 !locThickness
      parQ.eGrid = locGrid                          ! Grid line
    elsif ~(locI % 5)
      if band(self.eAxesStyle,AxesStyle:NoStroke2) then cycle end ! DON'T display
      parQ.eLen  = 6                                ! Normal stroke
      parQ.eThickness = 1 !locThickness/2
    else
      if band(self.eAxesStyle,AxesStyle:NoStroke1) then cycle end ! DON'T display
      parQ.eLen  = 2                                ! Thin strokes
    end
    put(parQ)
    if self.ErrCode(errorcode()) then break end
  end
!
r:CalcAsWord          routine
  if locMax < 1
    locExponent = int(log10(locMax))-2
  else
    locExponent = int(log10(locMax))-1
  end
  locCoefficient = locMax/10^locExponent
  if locCoefficient > 10 and locCoefficient <= 20
    locCoefficient = 2
  elsif locCoefficient > 20 and locCoefficient <= 50
    locCoefficient = 5
  else
    locCoefficient = 10
  end
  if locMax % (locCoefficient*10^locExponent) <> 0
    locMaximumScale = (int(locMax/(locCoefficient*10^locExponent))+1)*locCoefficient*10^locExponent
  else
    locMaximumScale = locMax
  end
!
GraphAxisClass.CalcAxisBar          procedure(qStrokeType parQ, long parAxis)
locBarGroups    long
locI            long, auto
locBy           real, auto
locNone         long
locIGraph       long, auto
locGraphType    long, auto
locMaxBars      long, auto
locPos          real, auto
locGrid         bool
 code
  free(parQ)
  if ~inlist(parAxis,1,2) then return end
  case self.eGraphType
  of GraphType:FloatingColumn                       ! The floating columns
  orof GraphType:FloatingBar                        ! The floating bar
    locGraphType = 2
    locGrid = choose(self.eAxesGrid and self.eAxisXGrid)
  of GraphType:ColumnWithAccumulation
  orof GraphType:BarWithAccumulation
    locGraphType = 3
    locGrid = choose(self.eAxesGrid and self.eAxisYGrid)
  else
    locGraphType = 1
  end
  locBarGroups = records(self.qCluster)
  ! Scale interval
  case parAxis
  of 1                                              ! Axis X
    locPos = self.gGraphDist.eL
    locBy = (self.gGraphRect.eW-self.gGraphDist.eL-self.gGraphDist.eR)/locBarGroups
    locNone = AxesStyle:NoText + AxesStyle:NoneX
  of 2                                              ! Axis Y
    locPos = self.gGraphDist.eB
    locBy = (self.gGraphRect.eH-self.gGraphDist.eB-self.gGraphDist.eT)/locBarGroups
    locNone = AxesStyle:NoText + AxesStyle:NoneY
  end
  ! Search of the maximal value
  locMaxBars = 1
  case locGraphType
  of 3
  else
    self.Set(self.qCluster)
    loop until self.Next(self.qCluster)
      case locGraphType
      of 2
        if locMaxBars < self.qCluster.eNodesFloat then locMaxBars = self.qCluster.eNodesFloat end
      else
        if locMaxBars < self.qCluster.eNodes then locMaxBars = self.qCluster.eNodes end
      end
    end
  end
  ! Compute column's half-width, considering overlapping and distances between groups
  self.eBarRadius = (locBy/2) / (locMaxBars+1)
  if self.eBarOverlap
    self.eBarRadius /= self.eBarOverlap
  end
  ! Forming scale parameters
  loop locI = 1 to locBarGroups
    if locI = 1
      self.StrokeAdd(parQ, 1,, 0, 0)
    else
      self.StrokeAdd(parQ, locI*2-1,, locBy*(locI-1), 5, locGrid)
    end
    self.StrokeAdd(parQ, locI*2,, locBy*(locI-1)+locBy/2) ! ePos - Coordinate of middle of group
    if self.Set(self.qCluster, locI) then cycle end
    self.qCluster.ePos = locPos + parQ.ePos
    case locGraphType
    of 2
      self.qCluster.ePos -=  self.qCluster.eNodesFloat*self.eBarRadius
    of 3
      self.qCluster.ePos -=  self.eBarRadius
    else
      self.qCluster.ePos -=  self.qCluster.eNodes*self.eBarRadius
    end
    put(self.qCluster)
    if band(self.eAxesStyle,locNone) then cycle end ! If not to display the text then cycle
    if ~(self.qCluster.oText &= null)
      if self.qCluster.oText.eText
        parQ.eText = self.qCluster.oText.eText
      end
    end
    if ~parQ.eText then parQ.eText = self.qCluster.eName end
    if ~parQ.eText then parQ.eText = clip(locI) end
    self.GetFont(parQ.gFont, self.FParent())
    self.GetTextPoint(self.FParent(), clip(parQ.eText), parQ.eTextW, parQ.eTextH)
    put(parQ)
  end
!
GraphAxisClass.DrawAxes             procedure       ! Draw axes
 code
  !
  if ~band(self.eAxesStyle,AxesStyle:NoneX) and self.eAxisXname
    self.oAxisXName.Draw
  end
  if ~band(self.eAxesStyle,AxesStyle:NoneY) and self.eAxisYname
    self.oAxisYName.Draw
  end
  !
  self.DrawAxisY                                    ! Drawing vertical scale
  self.DrawAxisX                                    ! Drawing horizontal scale
!
GraphAxisClass.GetYTextPoint        procedure(? parValue, <*? parW>, <*? parH>, <*? parMaxLen>)
locText       any
locTextW      real, auto
locTextH      real, auto
 code
  if self.eAxisYFormat                              ! Vertical axis' number format
    locText = clip(format(parValue,self.eAxisYFormat))
  else                                              ! Automatic numbers formatting
    locText = clip(round(parValue,self.gAxisFactor.eY))
  end
  self.GetTextPoint(self.FParent(),locText,locTextW,locTextH)
  if ~omitted(3) then parW = locTextW end
  if ~omitted(4) then parH = locTextH end
  if ~omitted(5)
    parMaxLen = choose(parMaxLen < locTextW, locTextW, parMaxLen) ! Max. text length
  end
  return locText
!
GraphAxisClass.GetYTextMaxWidth     procedure
locLen        real
locText       any
locTextW      real
 code
  if band(self.eAxesStyle,AxesStyle:NoStroke3) or |         ! If do NOT show or
     band(self.eAxesStyle,AxesStyle:NoText+AxesStyle:NoneY) ! do NOT draw the text, then
    return 0
  end
  case self.eGraphType
  of GraphType:ColumnChart
  orof GraphType:ColumnWithAccumulation
  orof GraphType:FloatingColumn
    do r:Other
  else
    do r:Calc
  end
  return 8 + locLen
!
r:Calc    routine
  self.Set(self.qStrokeY)
  loop until self.Next(self.qStrokeY)
    if ~self.qStrokeY.eText
      locText = pointer(self.qStrokeY)
    else
      locText = self.qStrokeY.eText
    end
    locTextW = self.GetTextWidth(locText,self.FParent())
    locLen = choose(locLen<locTextW,locTextW,locLen)
  end
!
r:Other       routine
 data
savAxisFactor like(gXYType)
locI          long
locH          real
locD          real
locBy         real
 code
  ! (IMAGE height - lower indent - upper indent)
  locH = self.gGraphRect.eH-(self.gGraphDist.eB+self.GetXTextMaxHeight())-self.gGraphDist.eT
  locBy = 2                                         ! Scale interval
  ! Correcting scale step in logical units
  savAxisFactor = self.gAxisFactor
  self.SetFactor(,(self.gAxisMax.eY-self.gAxisMin.eY)/locH)
  locD = locBy
  loop until locD > locH
    locD += locBy
    locI += 1
    if locI % 10 then cycle end
    self.GetYTextPoint(self.gAxisMin.eY+locD*self.gAxisFactor.eY,,,locLen)
  end
  self.gAxisFactor = savAxisFactor
!
GraphAxisClass.GetXTextMaxHeight     procedure
locText         any
locTextH        real
locDistB        real
 code
  if band(self.eAxesStyle,AxesStyle:NoText+AxesStyle:NoneX) then return 0 end
  case self.eGraphType
  of GraphType:ColumnChart                          ! Histogram (vertical columns)
  orof GraphType:ColumnWithAccumulation
  orof GraphType:FloatingColumn
    self.Set(self.qStrokeX)
    loop until self.Next(self.qStrokeX)
      locText = choose(~self.qStrokeX.eText, pointer(self.qStrokeX), self.qStrokeX.eText)
      self.GetTextPoint(self.FParent(), locText,, locTextH)
      ! Max. text height (shift from the axis below)
      locDistB = choose(locDistB < locTextH, locTextH, locDistB)
    end
  else
    locDistB = self.GetTextHeight('W', self.FParent())
  end
  return 8 + locDistB
!
GraphAxisClass.DrawAxisY            procedure
! Draw Y-axis
locP            like(gPositionType)
locTextY        real
savTextY        real
 code
  if band(self.eAxesStyle,AxesStyle:NoneY) then return end ! DON'T display axis
  self.PushStyle
  self.SetStyle
  locP = self.gGraphRect
  locP.eX += self.gGraphDist.eL - self.eAxisXThickness
  locP.eW -= self.gGraphDist.eL + self.gGraphDist.eR - 5
  locP.eY += self.gGraphDist.eB - self.eAxisYThickness
  locP.eH -= locP.eY + self.gGraphDist.eT - 5
  self.VLine(locP, 1, self.eAxisYColor, self.eAxisYThickness) ! Line
  ! Drawing vertical scale
  self.Set(self.qStrokeY)
  loop until self.Next(self.qStrokeY)
    locTextY = locP.eY+self.qStrokeY.ePos-self.qStrokeY.eTextH/2
    if self.qStrokeY.eText and |
       inrange(locTextY, locP.eY, locP.eY+locP.eH-self.qStrokeY.eTextH) and |
       (~savTextY or locTextY - self.qStrokeY.eTextH => savTextY)
      savTextY = locTextY
      ! Scale text (right alignment)
      self.Show(locP.eX-8-self.qStrokeY.eTextW, locTextY, clip(self.qStrokeY.eText),self.qStrokeY.gFont)
    end
    if self.qStrokeY.eLen                           ! If there is a strike, then draw
      self.HLine(locP.eX-self.qStrokeY.eLen/2, locP.eY+self.qStrokeY.ePos,|
                      self.qStrokeY.eLen+self.eAxisYThickness, 0)
    end
    if self.qStrokeY.eGrid                          ! If the grid then
      self.PushStyle
      self.SetStyle(self.eGridColor,,self.eGridStyle)
      self.Line(locP.eX+self.qStrokeY.eLen/2+4, locP.eY+self.qStrokeY.ePos, locP.eW-self.qStrokeY.eLen/2-4, 0)
      self.PopStyle
    end
  end
  self.PopStyle
!
GraphAxisClass.DrawAxisX            procedure
! Draw X-axis
locP            like(gPositionType), auto
locLen          long
 code
  if band(self.eAxesStyle,AxesStyle:NoneX) then return end ! DON'T display axis
  self.PushStyle
  self.SetStyle
  locP = self.gGraphRect
  locP.eX += self.gGraphDist.eL - self.eAxisXThickness
  locP.eW -= self.gGraphDist.eL + self.gGraphDist.eR - 5
  locP.eY += self.gGraphDist.eB - self.eAxisXThickness
  locP.eH -= self.gGraphDist.eT + self.gGraphDist.eB - 5
  self.HLine(locP, 1, self.eAxisXColor, self.eAxisXThickness) ! Line
  ! Drawing horizontal scale
  self.Set(self.qStrokeX)
  loop until self.Next(self.qStrokeX)
    if self.qStrokeX.eText and (locLen <= locP.eX+self.qStrokeX.ePos-self.qStrokeX.eTextW/2) and |
       (locP.eX+self.qStrokeX.ePos+self.qStrokeX.eTextW/2 < locP.eX+locP.eW)
      ! - to prevent text overlapping & merging
      locLen = locP.eX+self.qStrokeX.ePos+self.qStrokeX.eTextW/2
      ! Scale text
      self.Show(locP.eX+self.qStrokeX.ePos-self.qStrokeX.eTextW/2, |
                locP.eY-8-self.qStrokeX.eTextH, clip(self.qStrokeX.eText), self.qStrokeX.gFont)
    end
    if self.qStrokeX.eLen                           ! If there is a strike, then draw
      self.line(locP.eX+self.qStrokeX.ePos, abs(self.ToLH(1))+locP.eY-self.qStrokeX.eLen/2, 0, |
                     self.qStrokeX.eLen+self.eAxisXThickness)
    end
    if self.qStrokeX.eGrid                          ! If the grid then
      self.PushStyle
      self.SetStyle(self.eGridColor,,self.eGridStyle)
      self.line(locP.eX+self.qStrokeX.ePos, locP.eY+self.eAxisXThickness+self.qStrokeX.eLen/2+4, 0, |
                     locP.eH-self.qStrokeX.eLen/2-4)
      self.PopStyle
    end
  end
  self.PopStyle
!
GraphAxisClass.StrokeAdd            procedure(qStrokeType parQ, long parN, <string parText>, <real parPos>, |
                                              <real parLen>, <byte parGrid>)
! Add stroke description
 code
  clear(parQ)
  if ~parN
    self.Set(parQ, records(parQ))
    parQ.eID += 1
    do r:Set
    add(parQ, +parQ.eID)
  else
    if self.Set(parQ, parN)
      parQ.eID = parN
      do r:Set
      add(parQ, +parQ.eID)
    else
      do r:Set
      put(parQ)
    end
  end
r:Set   routine
  if ~omitted(4) then parQ.eText = parText end
  if ~omitted(5) then parQ.ePos  = parPos end
  if ~omitted(6) then parQ.eLen  = parLen end
  if ~omitted(7) then parQ.eGrid = parGrid end
!
GraphAxisClass.AxesScaleMinMax      procedure(<long parValue>)
 code
  if ~omitted(2)
    self.eAxesScaleMinMax = parValue
  end
  return choose(self.eAxesScaleMinMax and self.eAxesScale<>Scale:AsMSWord)
GraphClass.ToolTip                  procedure
locPos          like(gPositionType)
locText         any
locTextAdd      any
 code
  if self.eFToolTip
    locText = self.MouseText(self.gShowMouse.eOnT)
    if self.gShowDiagramName.eOnT
      locTextAdd = self.DiagramText()
      do r:AddText
    end
    if self.gShowNodeName.eOnT or self.gShowNodeValue.eOnT
      locTextAdd = self.NodeText(self.gShowNodeName.eOnT,self.gShowNodeValue.eOnT)
      do r:AddText
    end
    locTextAdd = self.NodeTipText()
    if locTextAdd
      locTextAdd = 'Node Tip: ' & locTextAdd
      do r:AddText
    end
    if locText
      if self.eFToolTip{prop:hide}
        self.SetFont(self.gToolTipProp, self.eFToolTip)
        if self.gToolTipProp.eTrn
          if ~self.eFToolTip{prop:trn} then self.eFToolTip{prop:trn} = true end
        else
          if self.eFToolTip{prop:color} <> self.gToolTipProp.eBgrColor
            self.eFToolTip{prop:color} = self.gToolTipProp.eBgrColor
          end
        end
        self.eFToolTip{prop:hide} = false
      end
      self.GetTextRec(self.eFToolTip, locText, locPos)
      if locPos.eW > 0 then locPos.eW += self.gToolTipProp.CorrectionOfWidth end ! Correction of width
      if locPos.eH > 0 then locPos.eH += self.gToolTipProp.CorrectionOfHeight end ! Correction of height
      locPos.eX = self.eMouseX
      locPos.eY = self.eMouseY-locPos.eH
      if self.eBestPositionToolTip                  ! Search of the best position
        if (self.eWindow{prop:width} - (locPos.eX+locPos.eW)) < 0
          locPos.eX += self.eWindow{prop:width} - (locPos.eX+locPos.eW)
          if locPos.eX < 0 then locPos.eX = 0 end
        end
        if locPos.eY < 0 then locPos.eY = 0 end
      end
      !
      setposition(self.eFToolTip, locPos.eX, locPos.eY, locPos.eW, locPos.eH)
      self.eFToolTip{prop:text} = locText
    else
      if ~self.eFToolTip{prop:hide} then self.eFToolTip{prop:hide} = true end
    end
  end
!
r:AddText     routine
  if locText
    if locTextAdd
      locText = locText & '<13,10>' & locTextAdd
    end
  else
    locText = locTextAdd
  end
GraphClass.Init                     procedure(window parWin, long parFParent, | ! Parent object
                                              real parL=0, real parT=0, |       ! Coordinates indent relative to
                                              real parR=0, real parB=0  |       ! parent object
                                              )
! Initializing object
 code
  self.ErrCode(0)
  self.eWindow &= parWin
  if self.CheckTarget() then return end
  self.FParent(parFParent)                          ! Set parent
  self.gParent.eL = parL                            ! Indents from parent object's bounds
  self.gParent.eT = parT
  self.gParent.eR = parR
  self.gParent.eB = parB
  !
  if self.eGrField then destroy(self.eGrField) end
  settarget(self.eWindow)
  self.PushMeasure
  self.SetMeasure
  self.eGrField = create(0, create:string, self.FParent())
  self.SetDefault
  if ~self.eFBand                                   ! If there is no IMAGE field then
    self.eFBand = create(0, create:Image, self.FParent()) ! IMAGE field - where the diagram will be displayed
  end
  !
  if self.eWindow{prop:type} ~= create:report
    if ~self.eFRegionZoom
      self.eFRegionZoom = create(0, create:Region, self.FParent())
      self.eFRegionZoom{prop:imm} = true
      BringWindowToTop(self.eFRegionZoom{Prop:Handle})
    end
  end
  !
  if self.eWindow{prop:type} ~= create:report
    if ~self.eFRegion
      self.eFRegion = create(0, create:Region, self.FParent())
      setposition(self.eFRegion, self.FParent(){prop:Xpos}, self.FParent(){prop:Ypos}, |
                  self.FParent(){prop:Width}, self.FParent(){prop:Height})
      self.eFRegion{prop:imm} = true
    end
    if ~self.eFToolTip
      self.eFToolTip = create(0, create:Prompt, self.FParent())
    end
  end
  self.PopMeasure
!
GraphClass.Kill                     procedure()
 code
  if ~self.CheckTarget()
    settarget(self.eWindow)
    if self.eGrField
      destroy(self.eGrField) ; clear(self.eGrField)
    end
    if self.eFBand
      destroy(self.eFBand) ; clear(self.eFBand)
    end
    if self.eFRegion
      destroy(self.eFRegion) ; clear(self.eFRegion)
    end
    if self.eFToolTip
      destroy(self.eFToolTip) ; clear(self.eFToolTip)
    end
    self.Free:qGraph
    self.Free:qSelectedGraph
    settarget
  end
  self.eWindow &= null
!
GraphClass.SetDefault               procedure       ! Set initial values
 code
  if self.CheckTarget() then return end
  self.Free:qGraph
  self.Free:qCluster
  self.oTitle.Init
  self.oLegend.Init
  ! Users' units: some abstract measure units
  ! that must be re-computed into device units before output onto device
  case self.eWindow{prop:type}
  of create:window
    ! Setting factors for a measure PIXEL. I.e. 1 unit of the user = 1 pixel
    self.SetFactorXY(0,0,1,1)
    self.eAxisXThickness = 1                        ! Thickness of a line in pixels
    self.eAxisYThickness = 1                        ! Thickness of a line in pixels
    self.eAxisXScaleInterval = 1                    ! Distance between strokes of an Axis in units of the device
    self.eAxisYScaleInterval = 1
  of create:report
    ! Setting factors for a measure INCH. I.e. 1 user's unit(logic units) = 1 mm
    self.SetFactorXY(0,0,40,40)                     ! device pitch is 1/1000 of inch
    self.eAxisXThickness = 0.5                      ! Thickness of a line in millimeters
    self.eAxisYThickness = 0.5                      ! Thickness of a line in millimeters
    self.eAxisXScaleInterval = abs(self.ToW(0.5))   ! Distance between strokes of an Axis in units of the device
    self.eAxisYScaleInterval = abs(self.ToH(0.5))
  end
  self.eEventLast = 0                               ! Last message
  self.Getposition(self.FParent(), self.gParent)    ! Parent's coordinates
  self.SetFactor(0,0)
  ! Default
  clear(self.gShowMouse)
  clear(self.gShowMouseX)
  clear(self.gShowMouseY)
  clear(self.gShowDiagramName)
  clear(self.gShowDiagramNameV)
  clear(self.gShowNodeName)
  clear(self.gShowNodeNameV)
  clear(self.gShowNodeValue)
  clear(self.gShowNodeValueX)
  clear(self.gShowNodeValueY)
  !
  self.eGraphType             = GraphType:ColumnChart
  self.eGraphSubType          = GraphSubType:Simple !GraphSubType:Normalized
  self.eGraphFigure           = FigureType:Bar
  self.eChoosePrinterFlag     = true
  self.eWallpaper             = true
  self.e3D                    = true
  self.eGradient              = false
  self.eZoom                  = 0                   ! Auto
  !
  self.eNodeType              = 0                   ! Node style - Default
  self.eNodeRadius            = 3                   ! in logical units
  self.eNodeLabel             = false
  self.eNodeValue             = false
  self.eNodeMinMax            = true
!  self.gNodeProp                                    ! Node Inscription font
  self.gNodeProp.eBgrColor    = color:btnface
  self.gNodeProp.eBorderColor = color:none
  self.eBestPositionNodeText  = true
  !
  self.eInteractivity         = true
  self.ePopUp                 = true                ! Popup menu
  clear(self.ePopUpItems,1)
  clear(self.ePopUpSubGraphType,1)
  clear(self.ePopUpSubLegend,1)
  clear(self.ePopUpSubAxes,1)
  clear(self.ePopUpSubNode,1)
  self.ePopUpHideItems        = true
  self.eSensitivityRadius     = 3                   ! in pixels
  !
  self.gPrint.ePreview        = true                ! Preview
  self.gPrint.eOrientation    = equ:Auto            ! Orientation same as on the printer
  self.gPrint.eBox            = true
  self.gPrint.eL              = 20                  ! Indent from left (mm)
  self.gPrint.eT              = 10                  ! Indent from top (mm)
  self.gPrint.eR              = 10                  ! Indent from right (mm)
  self.gPrint.eB              = 20                  ! Indent from bottom (mm)
  self.gPrint.eProportional   = true                ! To keep a proportion
  !
  self.eBarRadius             = 5                   ! Vertical column's half-width
  self.eBarOverlap            = 0                   ! Overlapping
  self.eBarDepth              = 0                   ! 3D depth
  !
  self.ePieDepth              = 20
  !
  self.eShowSBonFirstThread   = true
  ! Parameters of a saving
  self.eSaveFileNameAlwaysExt = true
  clear(self.eSaveFileName)
  ! Axes
  clear(self.gAxisMin)
  clear(self.gAxisMax)
  self.eAxesStyle             = AxesStyle:Default   ! Axes style - Default
  self.eAxesScale             = Scale:Default
  self.eAxesScaleMinMax       = false
  self.eAxesGrid              = false               ! No grid
  self.eGridColor             = color:btnshadow     ! Grid lines colour
  self.eGridStyle             = pen:dot             ! Grid lines style
  !
  self.eAxisXName             = true
  self.eAxesXScale            = Scale:Linear
  self.eAxisXColor            = color:windowtext    ! Axes lines colour
  self.eAxisXGrid             = false               ! No grid
  !
  self.eAxisYName             = true
  self.eAxesYScale            = Scale:Linear
  self.eAxisYColor            = color:windowtext    ! Axes lines colour
  self.eAxisYGrid             = false               ! No grid
  !
  self.eToolTip               = true                ! Tool tip
  self.gToolTipProp.eBgrColor  = color:yellow
  self.eBestPositionToolTip   = true
  self.gShowMouse.eOnT        = true
  self.gShowDiagramName.eOnT  = true
  self.gShowNodeName.eOnT     = true
  self.gShowNodeValue.eOnT    = true
!
GraphClass.TakeEvent                procedure
! Handle events (which has been sent to the parent object eFParent, and controls)
 code
  case event()
  of event:sized
    self.Resize                                     ! Set object's size
  end
  !
  self.TakeEventOfParent
  case field()
  of 0
  of self.eFRegion
  orof self.eFRegionZoom
    if self.eWindow{prop:active}
      self.PostEvent(event())
    end
  end
!
GraphClass.PostEvent                procedure(long parEvent)
! Send message to the object (to parent object eFParent)
 code
  if parEvent
    post(parEvent, self.FParent())
    self.eEventLast = parEvent
  end
!
GraphClass.GetMouse                 procedure
 code
  ! Coordinates of the mouse in DC units
  self.eMouseX = mousex()
  self.eMouseY = mousey()
  ! Coordinates of the mouse in logic units
  self.eMouseXl = self.ToLX((self.eMouseX - self.eFBand{prop:Xpos}) * self.eToPixelsX)
  self.eMouseYl = self.ToLY((self.eMouseY - self.eFBand{prop:Ypos}) * self.eToPixelsY)
  ! Coordinates of the mouse in physical units
  self.eMouseXa = self.gAxisMin.eX + (self.eMouseXl-self.gGraphDist.eL)*self.gAxisFactor.eX
  self.eMouseYa = self.gAxisMin.eY + (self.eMouseYl-self.gGraphDist.eB)*self.gAxisFactor.eY
!
GraphClass.FindNearbyNodes          procedure(real parX, real parY)
! Search of node near the specified coordinates
savGraphPointer long, auto
savNodePointer  long, auto
locIn           bool
 code
  self.Free:qSelectedGraph
  savGraphPointer = pointer(self.qGraph)
  self.Set(self.qGraph)
  loop until self.Next(self.qGraph)
    if self.qGraph.qNode &= null then cycle end
    clear(self.qSelectedGraph)
    self.qSelectedGraph.qSelectedNode &= null
    do r:In
    if locIn
      if self.qSelectedGraph.qSelectedNode &= null
        self.qSelectedGraph.eID = self.qGraph.eID
        self.qSelectedGraph.qSelectedNode &= new(qSelectedNodeType)
        add(self.qSelectedGraph)
      end
      self.qSelectedGraph.qSelectedNode.eID = locIn
      add(self.qSelectedGraph.qSelectedNode)
    end
  end
  self.Set(self.qGraph, savGraphPointer)
  return choose(records(self.qSelectedGraph))
!
r:In    routine
 locIn = false
  case self.qGraph.oDiagram.eType
  of GraphType:Line                               ! Diagram (line graph)
  orof GraphType:ScatterGraph                     ! Point-by-point diagram
  orof GraphType:AreaGraph                        ! Area graph
  orof GraphType:FloatingArea                     ! The floating area
    savNodePointer = pointer(self.qGraph.qNode)
    self.Set(self.qGraph.qNode)
    loop until self.Next(self.qGraph.qNode)
      if self.qGraph.qNode.oNode &= null then cycle end
      if ~self.qGraph.qNode.oNode.InNode(parX, parY) then cycle end
      if self.qSelectedGraph.qSelectedNode &= null
        self.qSelectedGraph.eID = self.qGraph.eID
        self.qSelectedGraph.qSelectedNode &= new(qSelectedNodeType)
        add(self.qSelectedGraph)
      end
      self.qSelectedGraph.qSelectedNode.eID = self.qGraph.qNode.eID
      add(self.qSelectedGraph.qSelectedNode)
    end
    self.Set(self.qGraph.qNode, savNodePointer)
  else
    if ~(self.qGraph.oDiagram &= null)
      locIn = self.qGraph.oDiagram.InDiagram(parX, parY)
    end
  end
!
GraphClass.IsOverNode     procedure
savGraphPointer long, auto
locIsfound      bool
 code
  savGraphPointer = pointer(self.qGraph)
  self.Set(self.qGraph)
  loop until self.Next(self.qGraph)
    if ~(self.qGraph.oDiagram &= null)
      case self.qGraph.oDiagram.eType
      of GraphType:PieChart                       ! Circle (pie) diagram
        if pointer(self.qGraph) <> records(self.qGraph) then cycle end
      end
      locIsfound = choose(self.qGraph.oDiagram.InDiagram(self.eMouseXl, self.eMouseYl))
    end
  until locIsfound
  self.Set(self.qGraph, savGraphPointer)
  ! Returns: TRUE - node is found
  return locIsfound
!
GraphClass.DrillDown                procedure
 code
  if self.eFDrillDown
    self.Hide
    if self.eFDrillDown{prop:Hide} then self.eFDrillDown{prop:Hide} = false end
    if focus() <> self.eFDrillDown then select(self.eFDrillDown) end
  end
  if ~self.SetSelectedNode()
      self.DrillDown( self.qGraph.eID, self.qGraph.eName, |
                      self.qGraph.qNode.eID, self.qGraph.qNode.eName, |
                      self.qGraph.qNode.gXY.eX, self.qGraph.qNode.gXY.eY)
  else
    self.DrillDown(0, '', 0, '', 0, 0)
  end
!
GraphClass.DrillDown                procedure(long parGraphID, string parGraphName, |
                                              long parNodeID, string parNodeName, |
                                              real parNodeX, real parNodeY)
 code
!
GraphClass.ReturnFromDrillDown      procedure
 code
  if self.eFReturnFromDrillDown
    self.Hide
    if self.eFReturnFromDrillDown{prop:Hide} then self.eFReturnFromDrillDown{prop:Hide} = false end
    if focus() <> self.eFReturnFromDrillDown then select(self.eFReturnFromDrillDown) end
  end
  if ~self.SetSelectedNode()
      self.ReturnFromDrillDown( self.qGraph.eID, self.qGraph.eName, |
                                self.qGraph.qNode.eID, self.qGraph.qNode.eName, |
                                self.qGraph.qNode.gXY.eX, self.qGraph.qNode.gXY.eY)
  else
    self.ReturnFromDrillDown(0, '', 0, '', 0, 0)
  end
!
GraphClass.ReturnFromDrillDown      procedure(long parGraphID, string parGraphName, |
                                              long parNodeID, string parNodeName, |
                                              real parNodeX, real parNodeY)
 code
!
GraphClass.MouseText                procedure(bool parShow=true)
 code
  if ~parShow then return '' end
  return 'Mouse: (' & self.MouseXText() & ' : ' & self.MouseYText() & ')'
!
GraphClass.MouseXText               procedure(bool parShow=true)
 code
  if ~parShow then return '' end
  if ~self.eAxisXFormat
    return round(self.eMouseXa,self.gAxisFactor.eX)
  else
    return format(self.eMouseXa,self.eAxisXFormat)
  end
GraphClass.MouseYText               procedure(bool parShow=true)
 code
  if ~parShow then return '' end
  if ~self.eAxisYFormat
    return round(self.eMouseYa,self.gAxisFactor.eY)
  else
    return format(self.eMouseYa,self.eAxisYFormat)
  end
!
GraphClass.DiagramText              procedure(bool parShow=true)
 code
  if ~self.DiagramNameText(parShow) then return '' end
  return 'Diagram: ' & self.DiagramNameText(parShow)
!
GraphClass.DiagramNameText          procedure(bool parShow=true)
 code
  if ~parShow then return '' end
  if ~self.qGraph.eName
    return choose(~self.qGraph.eID, '', clip(self.qGraph.eID))
  end
  return clip(self.qGraph.eName)
!
GraphClass.NodeXText                procedure(bool parShow=true)
 code
  if ~parShow or self.qGraph.qNode &= null then return '' end
  return self.qGraph.qNode.gXY.eX
!
GraphClass.NodeYText                procedure(bool parShow=true)
 code
  if ~parShow or self.qGraph.qNode &= null then return '' end
  return self.qGraph.qNode.gXY.eY
!
GraphClass.NodeValueText            procedure(bool parShow=true)
 code
  if ~parShow or self.qGraph.qNode &= null then return '' end
  return '('& self.NodeXText() &','& self.NodeYText() & ')'
!
GraphClass.NodeNameText             procedure(bool parShow=true)
 code
  if ~parShow or self.qGraph.qNode &= null then return '' end
  if ~self.qGraph.qNode.eName
    return choose(~self.qGraph.qNode.eID, '', clip(self.qGraph.qNode.eID))
  end
  return clip(self.qGraph.qNode.eName)
!
GraphClass.NodeText                 procedure(bool parShowName=true, bool parShowValue=true)
locText       any
 code
  locText = self.NodeNameText(parShowName)
  locText = clip(locText &' '& self.NodeValueText(parShowValue))
  return choose(~locText, '', 'Node: ' & clip(locText))
!
GraphClass.NodeTipText              procedure(bool parShow=true)
 code
  if ~parShow or self.qGraph.qNode &= null then return '' end
  return clip(self.qGraph.qNode.eTip)
!
GraphClass.AllText                  procedure
locText       any
 code
  self.SetSelectedNode
  locText = self.MouseText()
  if self.qGraph.eID
    locText = locText & '<13,10>' & self.DiagramText()
    if ~(self.qGraph.qNode &= null)
      if self.qGraph.qNode.eID
        locText = locText & '<13,10>' & self.NodeText()
        if self.qGraph.qNode.eTip
          locText = locText & '<13,10>Node Tip: '
          locText = locText & self.qGraph.qNode.eTip
        end
      end
    end
  end
  return locText
!
GraphClass.ShowOnStatusBar          procedure(string parText, long parN)
 code
  if parN
    if self.eShowSBonFirstThread and ~target{prop:Status,1}+0
      settarget(,1)
      if target{prop:Status,parN}
        target{prop:StatusText,parN} = parText
      end
      settarget()
    else
      if target{prop:Status,parN}
        target{prop:StatusText,parN} = parText
      end
    end
  end
!
GraphClass.GetValueFromStatusBar    procedure(long parN)
locText     any
 code
  if parN
    if self.eShowSBonFirstThread and ~target{prop:Status,1}+0
      settarget(,1)
      if target{prop:Status,parN}
        locText = target{prop:StatusText,parN}
      end
      settarget()
    else
      if target{prop:Status,parN}
        locText = target{prop:StatusText,parN}
      end
    end
  end
  return clip(locText)
!
GraphClass.ShowOnField              procedure(string parText, long parField)
 code
  if parField
    case parField{prop:type}
    of create:sstring
    orof create:entry
    orof create:combo
    orof create:text
      change(parField, parText)
    else
      parField{prop:text} = parText
    end
  end
!
GraphClass.GetValueFromField        procedure(long parField)
 code
  if parField
    case parField{prop:type}
    of create:sstring
    orof create:entry
    orof create:combo
    orof create:text
      return clip(contents(parField))
    end
    return clip(parField{prop:text})
  end
!
GraphClass.ToShowValues             procedure
locText     any
 code
  ! To show the text on a control
  locText = ''
  if self.gShowMouseX.eOnF
    self.ShowOnField(self.MouseXText(),self.gShowMouseX.eOnF)
  end
  if self.gShowMouseY.eOnF
    self.ShowOnField(self.MouseYText(),self.gShowMouseY.eOnF)
  end
  if self.gShowDiagramNameV.eOnF
    self.ShowOnField(self.DiagramNameText(),self.gShowDiagramNameV.eOnF)
  end
  if self.gShowNodeNameV.eOnF
    self.ShowOnField(self.NodeNameText(),self.gShowNodeNameV.eOnF)
  end
  if self.gShowNodeValueX.eOnF
    self.ShowOnField(self.NodeXText(),self.gShowNodeValueX.eOnF)
  end
  if self.gShowNodeValueY.eOnF
    self.ShowOnField(self.NodeYText(),self.gShowNodeValueY.eOnF)
  end
  ! To show the text on a status bar
  locText = ''
  if self.gShowMouseX.eOnS
    self.ShowOnStatusBar(self.MouseXText(), self.gShowMouseX.eOnS)
  end
  if self.gShowMouseY.eOnS
    self.ShowOnStatusBar(self.MouseYText(), self.gShowMouseY.eOnS)
  end
  if self.gShowDiagramNameV.eOnS
    self.ShowOnStatusBar(self.DiagramNameText(), self.gShowDiagramNameV.eOnS)
  end
  if self.gShowNodeNameV.eOnS
    self.ShowOnStatusBar(self.NodeNameText(), self.gShowNodeNameV.eOnS)
  end
  if self.gShowNodeValueX.eOnS
    self.ShowOnStatusBar(self.NodeXText(), self.gShowNodeValueX.eOnS)
  end
  if self.gShowNodeValueY.eOnS
    self.ShowOnStatusBar(self.NodeYText(), self.gShowNodeValueY.eOnS)
  end
  ! To show the text on title of a Window
  locText = self.MouseText(self.gShowMouse.eOnW)
  locText = clip(locText & ' ' & self.DiagramText(self.gShowDiagramName.eOnW))
  locText = clip(locText & ' ' & self.NodeText(self.gShowNodeName.eOnW,self.gShowNodeValue.eOnW))
  if locText
    target{prop:text} = locText
  end
  ! To show the all text on a control
  self.ShowOnField('',self.gShowMouse.eOnF)
  self.ShowOnField('',self.gShowDiagramName.eOnF)
  self.ShowOnField('',self.gShowNodeName.eOnF)
  self.ShowOnField('',self.gShowNodeValue.eOnF)
  !
  if self.gShowMouse.eOnF
    self.ShowOnField(self.MouseText(),self.gShowMouse.eOnF)
  end
  if self.gShowDiagramName.eOnF
    self.ShowOnField(self.GetValueFromField(self.gShowDiagramName.eOnF) &' '&  |
                     self.DiagramText(),self.gShowDiagramName.eOnF)
  end
  if self.gShowNodeName.eOnF
    self.ShowOnField(self.GetValueFromField(self.gShowNodeName.eOnF) &' '&  |
                     self.NodeText(true,false),self.gShowNodeName.eOnF)
  end
  if self.gShowNodeValue.eOnF
    if self.gShowNodeValue.eOnF=self.gShowNodeName.eOnF and self.NodeText(true,false)
      self.ShowOnField(self.GetValueFromField(self.gShowNodeName.eOnF) &' '&  |
                        self.NodeValueText(),self.gShowNodeName.eOnF)
    else
      self.ShowOnField(self.GetValueFromField(self.gShowNodeValue.eOnF) &' '& |
                       self.NodeText(false,true),self.gShowNodeValue.eOnF)
    end
  end
  ! To show the all text on a status bar
  self.ShowOnStatusBar('',self.gShowMouse.eOnS)
  self.ShowOnStatusBar('',self.gShowDiagramName.eOnS)
  self.ShowOnStatusBar('',self.gShowNodeName.eOnS)
  self.ShowOnStatusBar('',self.gShowNodeValue.eOnS)
  !
  if self.gShowMouse.eOnS
    self.ShowOnStatusBar(self.MouseText(),self.gShowMouse.eOnS)
  end
  if self.gShowDiagramName.eOnS
    self.ShowOnStatusBar(self.GetValueFromStatusBar(self.gShowDiagramName.eOnS) &' '&  |
                         self.DiagramText(),self.gShowDiagramName.eOnS)
  end
  if self.gShowNodeName.eOnS
    self.ShowOnStatusBar(self.GetValueFromStatusBar(self.gShowNodeName.eOnS) &' '&  |
                         self.NodeText(true,false),self.gShowNodeName.eOnS)
  end
  if self.gShowNodeValue.eOnS
    if self.gShowNodeValue.eOnS=self.gShowNodeName.eOnS and self.NodeText(true,false)
      self.ShowOnStatusBar(self.GetValueFromStatusBar(self.gShowNodeName.eOnS) &' '&  |
                        self.NodeValueText(),self.gShowNodeName.eOnS)
    else
      self.ShowOnStatusBar(self.GetValueFromStatusBar(self.gShowNodeValue.eOnS) &' '& |
                       self.NodeText(false,true),self.gShowNodeValue.eOnS)
    end
  end
!
GraphClass.Interactivity            procedure
 code
  if ~self.eInteractivity then return end
  self.FindNearbyNodes(self.eMouseXl, self.eMouseYl)
  self.SetSelectedNode
  self.ToShowValues
!
  if self.eToolTip
    self.ToolTip
  end
!
GraphClass.Refresh                  procedure(byte parRefresh=false)
 code
  if self.CheckTarget() then return end
  self.Free:qGraph
  self.Free:qCluster
  if ~self.BeginRefresh() or parRefresh
    if self.eFRegion and self.eFRegion{prop:hide} then unhide(self.eFRegion) end
    if self.eFBand and self.eFBand{prop:hide}
      unhide(self.eFBand)
      parRefresh = true
    end
    if parRefresh
      self.Resize(parRefresh)                         ! Resize and draw diagrams
    end
  end
!
GraphClass.BeginRefresh             procedure
 code
  return false
!
GraphClass.Resize                   procedure(long parResize=false)
locP            like(gPositionType), auto
savDeferMove    long, auto
savFactorXY     like(gFactorCoordinateType), auto
 code
  if self.CheckTarget() then return end
  self.PushMeasure
  self.SetMeasure
  savFactorXY = self.gFactorXY
  self.SetFactorXY(0,0)
  self.GetPosition(self.FParent(), locP)
  ! Redraw diagram only if explicitly specified, or if parent's coordinates changed
  if ~parResize and self.gParent.eX = locP.eX and self.gParent.eY = locP.eY and |
     self.gParent.eW = locP.eW and self.gParent.eH = locP.eH
    self.gFactorXY = savFactorXY
    self.PopMeasure
    return
  end
  self.gParent :=: locP                             ! New coordinates of the parent
  ! Setting indents
  locP.eX += self.gParent.eL
  locP.eY += self.gParent.eT
  locP.eW -= self.gParent.eL + self.gParent.eR
  locP.eH -= self.gParent.eT + self.gParent.eB
  ! Changing object fields' coordinates 
  savDeferMove = system{prop:DeferMove}
  system{prop:DeferMove} = -1
  if self.eFRegion
    self.SetPosition(self.eFRegion, self.gParent)   ! Set size and position of REGION object
  end
  self.SetPosition(self.eFBand, locP)               ! Set size and position of IMAGE object
  self.Draw                                         ! Redrawing diagram
  system{prop:DeferMove} = savDeferMove
  self.PopMeasure
!
GraphClass.Draw                     procedure       ! Draw object
 code
  if self.CheckTarget() then return end
  if ~self.eFBand then return end
  self.PushMeasure
  self.SetMeasure
  clear(self.gGraphDist)                            ! Indents
  self.gGraphRect.eW = abs(self.ToLW(self.eFBand{prop:Width})) * choose(self.eZoom=0, 1, self.eZoom/100)
  self.gGraphRect.eH = abs(self.ToLH(self.eFBand{prop:Height})) * choose(self.eZoom=0, 1, self.eZoom/100)
  self.Settarget
  if self.eWindow{prop:type} = create:report
    self.SetFactorXY(self.eFBand{prop:Xpos}, self.eFBand{prop:Ypos}-self.eFBand{prop:Height})
  else
    self.gGraphRect.eX = 0
    self.gGraphRect.eY = 0
    ! Setting logical coordinates (0,0) to left-lower corner
    self.SetFactorXY(0, -self.eFBand{prop:Height})
    if self.eZoom <= 100
      self.eFBand{prop:HScroll} = false
      self.eFBand{prop:VScroll} = false
      self.RegionZoom(false)
    else
      self.eFBand{prop:HScroll} = true
      self.eFBand{prop:VScroll} = true
      self.RegionZoom
    end
  end
  self.CalcGraph                                    ! Calculation of the diagrams
  self.DrawGraph                                    ! Drawing of the diagrams
  settarget()
  self.PopMeasure
!
GraphClass.DrawGraph                procedure       ! Draw diagrams
 code
  self.PushStyle
  self.SetStyle
  blank                                             ! Clear output area
  self.DrawWallpaper                                ! Draw the wallpaper
  self.oTitle.Draw                                  ! To draw a title
  self.oLegend.Draw                                 ! To draw a legend
  self.DrawAxes                                     ! To draw axes
  !
  self.Set(self.qGraph)
  loop until self.Next(self.qGraph)
    if ~(self.qGraph.oDiagram &= null)
      case self.eGraphType
      of GraphType:PieChart                         ! The pie chart
        if pointer(self.qGraph) <> records(self.qGraph) then cycle end ! To draw only last the diagram
      end
      self.qGraph.oDiagram.Draw                     ! To draw the diagram
    end
  end
  self.PopStyle
!
GraphClass.DrawWallPaper            procedure
 code
  if self.eWindow{prop:type} = create:report
  else
    if self.eWallpaper                              ! If background picture stated then
      self.eFBand{prop:text} = self.eWallpaperFile  ! display it
      self.eFBand{prop:tiled} = true
    else
      self.eFBand{prop:text} = ''
    end
  end
!
GraphClass.SaveAsGraph              procedure
! Method save the diagram in a WMF-file with the new name
 code
  self.SaveGraph(true)
!
GraphClass.SaveGraph                procedure(bool parAsk=false)
! Method save the diagram in a WMF-file
locFileName       any
locIndex          signed
 code
  self.ErrCode(0)
  if parAsk or ~self.eSaveFileName
    locIndex = 1
    if ~filedialoga('Save as',self.eSaveFileName,'WMF|*.wmf|EMF|*.emf|*.*|*.*',FILE:Save+FILE:KeepDir+FILE:LongName,locIndex)
      return
    else
      if ~self.FileNameExt(self.eSaveFileName)
        if self.eSaveFileNameAlwaysExt
          case locIndex
          of 1
            self.eSaveFileName = self.FileNameMerge(self.eSaveFileName,,,,'.wmf')
          of 2
            self.eSaveFileName = self.FileNameMerge(self.eSaveFileName,,,,'.emf')
          end
        end
      end
    end
  end
  if self.SetTarget() then return end
  setcursor(cursor:wait)
  case upper(self.FileNameExt(self.eSaveFileName))
  of 'EMF'
    locFileName = self.ImageToEMF()
  else
    locFileName = self.ImageToWMF()
  end
  if locFileName and self.eSaveFileName
    loop 2 times
      rename(locFileName, clip(self.eSaveFileName))
      case self.ErrCode(errorcode())
      of 0
        break
      of 05
        remove(clip(self.eSaveFileName))
        if self.ErrCode(errorcode())
?         assert(~self.ErrCode(), 'Method SaveGraph()<13,10>Error: ' & self.ErrCode() &'<13,10>File: ' & self.eSaveFileName)
          break
        end
      else
?       assert(~self.ErrCode(), 'Method SaveGraph()<13,10>Error(2): ' & self.ErrCode() &'<13,10>File: ' & self.eSaveFileName)
        break
      end
    end
  end
  setcursor
!
GraphClass.DrawReport               procedure(*report parReport, long parBand, queue parQRpt, bool parBestFit=false)
locImage        signed
locTmpFileName  any
locP            like(gPositionType)
locP:orig       like(gPositionType)
locRect         like(gPositionType)
 code
  if self.SetTarget() then return end
  locTmpFileName = self.ImageToWMF()
? assert(locTmpFileName,'<13,10>Method DrawReport()<13,10>File name: ' & locTmpFileName)
  if self.ErrCode() then return end
  !
  open(parReport)
  parReport{prop:preview} = parQRpt
  settarget(parReport)
  !
  locImage = create(0, create:Image, parBand)
  locImage{prop:hide} = false
  locImage{prop:text} = locTmpFileName
  locP:orig.eW = locImage{prop:Width}
  locP:orig.eH = locImage{prop:Height}
  !
  case self.gPrint.eOrientation
  of equ:Portrait
    parReport{prop:Landscape} = false
  of equ:Landscape
    parReport{prop:Landscape} = true
  else
    parReport{prop:Landscape} = self.GetPrinterProp(prop:Landscape)
  end
  parReport{propprint:Paper} = self.GetPrinterProp(propprint:Paper)
  locRect.eX = self.gPrint.eL*40                      ! Indents
  locRect.eY = self.gPrint.eT*40
  locRect.eW = self.GetPrinterProp(propprint:PaperWidth)*4 - self.gPrint.eL*40 - self.gPrint.eR*40
  locRect.eH = self.GetPrinterProp(propprint:PaperHeight)*4 - self.gPrint.eT*40 - self.gPrint.eB*40
  !
  locP = locP:orig
  locP.eX = locRect.eX
  locP.eY = locRect.eY
  case parBestFit                                     ! "Print best fit"
  of 1
    if self.gPrint.eStretch
      if self.gPrint.eProportional                    ! To keep a proportion
        if band(self.gPrint.eStretch, 01b)            ! To stretch along a horizontal
          locP.eW = locRect.eW
          locP.eH *= locRect.eW / locP:orig.eW
        elsif band(self.gPrint.eStretch, 10b)         ! To stretch along a vertical
          locP.eH = locRect.eH
          locP.eW *= locRect.eH / locP:orig.eH
        end
      else
        if band(self.gPrint.eStretch, 01b)            ! To stretch along a horizontal
          locP.eW = locRect.eW
        end
        if band(self.gPrint.eStretch, 10b)            ! To stretch along a vertical
          locP.eH = locRect.eH
        end
      end
    end
    case band(self.gPrint.eAlignment,11b)             ! Alignment
    of Alignment:Left                                 ! Left
    of Alignment:Right                                ! Right
       locP.eX = locRect.eX+locRect.eW - locP.eW
    of Alignment:CenterH
       locP.eX += locRect.eW/2 - locP.eW/2
    end
    case band(self.gPrint.eAlignment,1100b)           ! Alignment
    of Alignment:Top                                  ! Top
    of Alignment:Bottom                               ! Bottom
       locP.eY = locRect.eY+locRect.eH - locP.eH
    of Alignment:CenterV
       locP.eY += locRect.eH/2 - locP.eH/2
    end
  end
  setposition(parBand, locP.eX, locP.eY, locP.eW, locP.eH)
  setposition(locImage, 0, 0, locP.eW, locP.eH)
  settarget(parReport, parBand)                       ! Setting output area
  if self.gPrint.eBox
    box(0, 0, locP.eW, locP.eH)
  end
  !
  print(parReport, parBand)
  endpage(parReport)
  if locImage then destroy(locImage) end
  if locTmpFileName
    remove(locTmpFileName)
    self.ErrCode(errorcode())
  end
!
GraphClass.PrintGraph               procedure(bool parBestFit=false)
! The method prints the diagram
locRPTBreak     byte
qRpt            PreviewQueue
Report REPORT,AT(0,0,8396,11875),PAPER(PAPER:A4),PRE(rpt),THOUS
RPTbreak BREAK(locRPTBreak)
RPTdetail DETAIL,USE(?RPTdetail),FONT('Times Roman',,,)
         END
       END
     END
PreviewManager  PrintPreviewClass
 code
  if self.eChoosePrinterFlag
    if ~printerdialog('Choose Printer')
      return
    end
  end
  self.DrawReport(Report, ?RPTdetail, qRpt, parBestFit)
  PreviewManager.Init(qRpt)
  PreviewManager.AllowUserZoom = True
  PreviewManager.Maximize = True
  if self.gPrint.ePreview
    if PreviewManager.Display(NoZoom)
      report{prop:flushpreview} = true
    end
  else
    report{prop:flushpreview} = true
  end
  close(Report)
  self.Settarget
  !
  PreviewManager.Kill
!
GraphClass.CalcGraph                procedure
 code
  self.CalcMinMax
  ! To calculate the Title
  self.oTitle.gRec = self.gGraphRect
  self.oTitle.Calculate
  if ~self.oTitle.eHide
    self.gGraphDist.eT += self.oTitle.eH            ! Correct indents
  end
  ! To calculate the Legend
  self.oLegend.gRec = self.gGraphRect
  self.oLegend.gDist = self.gGraphDist
  self.oLegend.Calculate
  case self.oLegend.ePosition                       ! Correct indents
  of LegendPosition:Left
    self.gGraphDist.eL += self.oLegend.gPos.eW
  of LegendPosition:Right
    self.gGraphDist.eR += self.oLegend.gPos.eW
  of LegendPosition:Top
    self.gGraphDist.eT += self.oLegend.gPos.eH
  of LegendPosition:Bottom
    self.gGraphDist.eB += self.oLegend.gPos.eH
  end
  self.CalcAxes                                     ! To calculate axes
  !
  case self.eGraphType
  of GraphType:ColumnWithAccumulation
  orof GraphType:BarWithAccumulation
    clear(self.eSumYmax, -1)                        ! Search of maximal height of the diagrams
    self.Set(self.qCluster)
    loop until self.Next(self.qCluster)
      clear(self.qCluster.eSumH)
      put(self.qCluster)
      case self.eGraphSubType
      of GraphSubType:Normalized
        if self.eSumYmax < self.qCluster.gSum.eY
          self.eSumYmax = self.qCluster.gSum.eY
        end
      end
    end
  end
  !
  self.Set(self.qGraph)                             ! To calculate the diagrams
  loop until self.Next(self.qGraph)
    self.CalcCurrentGraph
    self.Set(self.qGraph.qNode)
    loop until self.Next(self.qGraph.qNode)
      self.CalcCurrentNode
    end
  end
  if self.eBestPositionNodeText                     ! Search of the best position of node text
    self.CalcBestPositionNodeText
  end
!
GraphClass.CalcCurrentGraph         procedure
 code
  if ~(self.qGraph.oDiagram &= null)
    dispose(self.qGraph.oDiagram)
    self.qGraph.oDiagram &= null
  end
  case choose(self.eGraphType=0, self.qGraph.eType, self.eGraphType)
  of GraphType:PieChart
    self.qGraph.oDiagram &= new(GraphPieClass)
  of GraphType:BarWithAccumulation
    self.qGraph.oDiagram &= new(GraphBarWithAccumulationClass)
  of GraphType:FloatingBar
    self.qGraph.oDiagram &= new(GraphFloatingBarClass)
  of GraphType:BarChart
    self.qGraph.oDiagram &= new(GraphBarClass)
  of GraphType:ColumnWithAccumulation
    self.qGraph.oDiagram &= new(GraphColumnWithAccumulationClass)
  of GraphType:FloatingColumn
    self.qGraph.oDiagram &= new(GraphFloatingColumnClass)
  of GraphType:ColumnChart
    self.qGraph.oDiagram &= new(GraphColumnClass)
  of GraphType:AreaGraph
    self.qGraph.oDiagram &= new(GraphAreaClass)
  of GraphType:FloatingArea
    self.qGraph.oDiagram &= new(GraphFloatingAreaClass)
  of GraphType:ScatterGraph
    self.qGraph.oDiagram &= new(GraphScatterClass)
  of GraphType:Line
    self.qGraph.oDiagram &= new(GraphLineClass)
  end
  put(self.qGraph)
  if ~(self.qGraph.oDiagram &= null)
    self.qGraph.oDiagram.Init(self.qGraph, self.iDiagram)
    self.qGraph.oDiagram.SetRectangle(self.gGraphDist.eL, self.gGraphDist.eB, |
                                      self.gGraphRect.eW - self.gGraphDist.eL - self.gGraphDist.eR, |
                                      self.gGraphRect.eH - self.gGraphDist.eT - self.gGraphDist.eB)
    self.qGraph.oDiagram.eType = choose(self.eGraphType=0, self.qGraph.eType, self.eGraphType)
    self.qGraph.oDiagram.eSubType = choose(self.eGraphSubType=0, self.qGraph.eSubType, self.eGraphSubType)
    self.qGraph.oDiagram.SetFill(self.qGraph.gFill)
    case self.qGraph.oDiagram.eType
    of GraphType:ColumnChart
    orof GraphType:FloatingColumn
    orof GraphType:ColumnWithAccumulation
    orof GraphType:BarChart
    orof GraphType:FloatingBar
    orof GraphType:BarWithAccumulation
      self.qGraph.oDiagram.eFigure = self.eGraphFigure
      self.qGraph.oDiagram.eBarRadius = self.eBarRadius
      self.qGraph.oDiagram.eDepth = choose(~self.e3D, 0, choose(~self.eBarDepth, self.eBarRadius, self.eBarDepth))
    of GraphType:PieChart
      self.qGraph.oDiagram.eDepth = choose(~self.e3D, 0, choose(~self.ePieDepth, self.qGraph.ePieDepth, self.ePieDepth))
      clear(self.qGraph.oDiagram.eSliceSum)
      self.Set(self.qGraph.qNode)
      loop until self.Next(self.qGraph.qNode)
        self.qGraph.oDiagram.eSliceSum += self.AToLY(self.qGraph.qNode.gXY.eY)
      end
    end
  end
!
GraphClass.CalcCurrentNode          procedure
 code
  if ~(self.qGraph.qNode.oNode &= null)
    dispose(self.qGraph.qNode.oNode)
    self.qGraph.qNode.oNode &= null
  end
  self.qGraph.qNode.oNode &= new(GraphNodeClass)
  put(self.qGraph.qNode)
  if ~(self.qGraph.qNode.oNode &= null)
    self.qGraph.qNode.oNode.Init(self.qGraph.qNode, self.iNode, self.iText)
    self.qGraph.qNode.oNode.eType = choose(self.eNodeType=0, self.qGraph.qNode.eType, self.eNodeType)
    self.qGraph.qNode.oNode.SetFill(self.qGraph.qNode.gFill)
    if self.qGraph.qNode.oNode.gFill.eColor = color:auto
      self.qGraph.qNode.oNode.gFill.eColor = self.qGraph.gFill.eColor
    end
    self.qGraph.qNode.oNode.eRadius = self.eNodeRadius * choose(self.eZoom=0 or self.eZoom=>100, 1, self.eZoom/100)
    self.qGraph.qNode.oNode.eHide = self.qGraph.qNode.eHide
    self.qGraph.qNode.oNode.eToShowLabel = self.eNodeLabel
    self.qGraph.qNode.oNode.eToShowValue = self.eNodeValue
    self.qGraph.qNode.oNode.eToShowBgr   = self.eNodeBgr
    self.qGraph.qNode.oNode.eToShowMinMax = self.eNodeMinMax
    if ~(self.qGraph.oDiagram &= null)
      self.qGraph.qNode.oNode.SetRectangle(|
                  self.qGraph.oDiagram.gRec.eX + self.AToLX(self.qGraph.qNode.gXY.eX-self.gAxisMin.eX), |
                  self.qGraph.oDiagram.gRec.eY + self.AToLY(self.qGraph.qNode.gXY.eY-self.gAxisMin.eY), |
                  self.AToLY(self.qGraph.qNode.gXY.eY-self.gAxisMin.eY), |
                  self.AToLY(self.qGraph.qNode.gXY.eY-self.gAxisMin.eY) |
                                          )
      self.qGraph.oDiagram.CalcNode
    end
    self.qGraph.qNode.oNode.Init
  end
!
GraphClass.CalcBestPositionNodeText procedure
! Search of the best position of node text
 code
  self.Set(self.qGraph)
  loop until self.Next(self.qGraph)
    self.Set(self.qGraph.qNode)
    loop until self.Next(self.qGraph.qNode)
      if self.qGraph.qNode.oNode &= null or self.qGraph.qNode.oNode.oText &= null then cycle end
      if (self.qGraph.qNode.oNode.oText.eX+self.qGraph.qNode.oNode.oText.eW) > |
         (self.qGraph.oDiagram.gRec.eX+self.qGraph.oDiagram.gRec.eW)
        self.qGraph.qNode.oNode.oText.eX -= (self.qGraph.qNode.oNode.oText.eX+self.qGraph.qNode.oNode.oText.eW) - |
                                            (self.qGraph.oDiagram.gRec.eX+self.qGraph.oDiagram.gRec.eW)
        if self.qGraph.qNode.oNode.oText.eX < self.qGraph.oDiagram.gRec.eX
          self.qGraph.qNode.oNode.oText.eX = self.qGraph.oDiagram.gRec.eX
        end
      end
      if (self.qGraph.qNode.oNode.oText.eY+self.qGraph.qNode.oNode.oText.eH) > |
         (self.qGraph.oDiagram.gRec.eY+self.qGraph.oDiagram.gRec.eH)
        self.qGraph.qNode.oNode.oText.eY -= (self.qGraph.qNode.oNode.oText.eY+self.qGraph.qNode.oNode.oText.eH) - |
                                            (self.qGraph.oDiagram.gRec.eY+self.qGraph.oDiagram.gRec.eH)
        if self.qGraph.qNode.oNode.oText.eY < self.qGraph.oDiagram.gRec.eY
          self.qGraph.qNode.oNode.oText.eY = self.qGraph.oDiagram.gRec.eY
        end
      end
    end
  end
!
GraphClass.TakeEventOfParent        procedure
! Handle events (which has been sent to the parent object eFParent)
savValue    any
 code
  if field() <> self.FParent() then return end
  case event()
  of event:Refresh                                  ! Refresh the object
    self.Free:qGraph
    self.Refresh(true)
  of event:Draw                                     ! Redraw the object
    self.Draw
  of event:MouseMove
    self.GetMouse                                   ! To receive coordinates of the mouse
    self.Interactivity                              ! To process action
  of event:MouseOut
    if ~self.eFToolTip{prop:hide} then self.eFToolTip{prop:hide} = true end ! Hide tip
  of event:MouseUp
    self.GetMouse                                   ! To receive coordinates of the mouse
    if ~self.eFToolTip{prop:hide} then self.eFToolTip{prop:hide} = true end ! Hide tip
    case keycode()
    of MouseLeft2
      if self.eFDrillDown
        self.PostEvent(event:DrillDown)
      elsif self.eFReturnFromDrillDown
        self.PostEvent(event:ReturnFromDrillDown)
      end
    of MouseRight
      if self.ePopUp
        self.Popup                                  ! Popup menu
      end
    end
  of event:Hide
    self.Hide
  of event:UnHide
    self.UnHide
  of event:GraphTypeScatterGraph
  orof event:GraphTypeLine
  orof event:GraphTypeAreaGraph
  orof event:GraphTypeFloatingArea
  orof event:GraphTypeColumnChart
  orof event:GraphTypeColumnWithAccumulation
  orof event:GraphTypeBarChart
  orof event:GraphTypeBarWithAccumulation
  orof event:GraphTypePieChart
  orof event:GraphTypeFloatingColumn
  orof event:GraphTypeFloatingBar
    savValue = self.eGraphType
    case event()
    of event:GraphTypeLine              ; self.eGraphType = GraphType:Line
    of event:GraphTypeColumnChart       ; self.eGraphType = GraphType:ColumnChart
    of event:GraphTypeColumnWithAccumulation ; self.eGraphType = GraphType:ColumnWithAccumulation
    of event:GraphTypeFloatingColumn    ; self.eGraphType = GraphType:FloatingColumn
    of event:GraphTypeScatterGraph      ; self.eGraphType = GraphType:ScatterGraph
    of event:GraphTypeAreaGraph         ; self.eGraphType = GraphType:AreaGraph
    of event:GraphTypeFloatingArea      ; self.eGraphType = GraphType:FloatingArea
    of event:GraphTypePieChart          ; self.eGraphType = GraphType:PieChart
    of event:GraphTypeBarChart          ; self.eGraphType = GraphType:BarChart
    of event:GraphTypeBarWithAccumulation ; self.eGraphType = GraphType:BarWithAccumulation
    of event:GraphTypeFloatingBar       ; self.eGraphType = GraphType:FloatingBar
    end
    if self.eGraphType <> savValue
      self.PostEvent(event:draw)
    end
  of event:GraphSubTypeSimple
  orof event:GraphSubTypeNormalized
    savValue = self.eGraphSubType
    case event()
    of event:GraphSubTypeSimple         ; self.eGraphSubType = GraphSubType:Simple
    of event:GraphSubTypeNormalized     ; self.eGraphSubType = GraphSubType:Normalized
    end
    if self.eGraphSubType <> savValue
      self.PostEvent(event:draw)
    end
  of event:FigureTypeBar
  orof event:FigureTypeCylinder
    savValue = self.eGraphFigure
    case event()
    of event:FigureTypeBar              ; self.eGraphFigure = FigureType:Bar
    of event:FigureTypeCylinder         ; self.eGraphFigure = FigureType:Cylinder
    end
    if self.eGraphFigure <> savValue
      self.PostEvent(event:draw)
    end
  of event:LegendPosition:None
  orof event:LegendPosition:Left
  orof event:LegendPosition:Right
  orof event:LegendPosition:Top
  orof event:LegendPosition:Bottom
    savValue = self.oLegend.ePosition
    case event()
    of event:LegendPosition:None    ; self.oLegend.ePosition = LegendPosition:None
    of event:LegendPosition:Left    ; self.oLegend.ePosition = LegendPosition:Left
    of event:LegendPosition:Right   ; self.oLegend.ePosition = LegendPosition:Right
    of event:LegendPosition:Top     ; self.oLegend.ePosition = LegendPosition:Top
    of event:LegendPosition:Bottom  ; self.oLegend.ePosition = LegendPosition:Bottom
    end
    if self.oLegend.ePosition <> savValue
      self.PostEvent(event:draw)
    end
  of event:LegendBoxON orof event:LegendBoxOFF
    savValue = self.oLegend.eBox
    self.oLegend.eBox = choose(event()=event:LegendBoxON)
    if self.oLegend.eBox <> savValue
      self.PostEvent(event:draw)
    end
  !
  of event:AxesStyle:None
  orof event:AxesStyle:Standard
  orof event:AxesStyle:Long
    savValue = self.eAxesStyle
    case event()
    of event:AxesStyle:None         ; self.eAxesStyle = AxesStyle:None
    of event:AxesStyle:Standard     ; self.eAxesStyle = AxesStyle:Standard
    of event:AxesStyle:Long         ; self.eAxesStyle = AxesStyle:Long
    end
    if self.eAxesStyle <> savValue
      self.PostEvent(event:draw)
    end
  !
  of event:AxesScale:Linear
  orof event:AxesScale:AsMSWord
    savValue = self.eAxesScale
    case event()
    of event:AxesScale:Linear       ; self.eAxesScale = Scale:Linear
    of event:AxesScale:AsMSWord     ; self.eAxesScale = Scale:AsMSWord
    end
    if self.eAxesScale <> savValue
      self.PostEvent(event:draw)
    end
  !
  of event:NodeType:None
  orof event:NodeType:Square
  orof event:NodeType:Triangle
  orof event:NodeType:Circle
    savValue = self.eNodeType
    case event()
    of event:NodeType:None          ; self.eNodeType = NodeType:None
    of event:NodeType:Square        ; self.eNodeType = NodeType:Square
    of event:NodeType:Triangle      ; self.eNodeType = NodeType:Triangle
    of event:NodeType:Circle        ; self.eNodeType = NodeType:Circle
    end
    if self.eNodeType <> savValue
      self.PostEvent(event:draw)
    end
  !
  of event:Zoom
  of event:Zoom500
  orof event:Zoom300
  orof event:Zoom200
  orof event:Zoom100
  orof event:Zoom50
  orof event:Zoom25
    savValue = self.eZoom
    case event()
    of event:Zoom500                ; self.eZoom = 500
    of event:Zoom300                ; self.eZoom = 300
    of event:Zoom200                ; self.eZoom = 200
    of event:Zoom100                ; self.eZoom = 100
    of event:Zoom50                 ; self.eZoom = 50
    of event:Zoom25                 ; self.eZoom = 25
    end
    if self.eZoom <> savValue
      self.PostEvent(event:draw)
    end
  !
  of event:TitleON orof event:TitleOFF              ! On/off title
    savValue = self.oTitle.eHide
    self.oTitle.eHide = choose(event()=event:TitleOFF)
    if self.oTitle.eHide <> savValue
      self.PostEvent(event:draw)
    end
  of event:WallpaperON orof event:WallpaperOFF      ! On/off wallpaper
    savValue = self.eWallpaper
    self.eWallpaper = choose(event()=event:WallpaperON)
    if self.eWallpaper <> savValue
      self.PostEvent(event:draw)
    end
  of event:GridON orof event:GridOFF                ! On/off grid
    savValue = self.eAxesGrid
    self.eAxesGrid = choose(event()=event:GridON)
    if savValue <> self.eAxesGrid
      self.PostEvent(event:draw)
    end
  of event:GridXON orof event:GridXOFF              ! On/off grid
    savValue = self.eAxisXGrid
    self.eAxisXGrid = choose(event()=event:GridXON)
    if savValue <> self.eAxisXGrid
      self.PostEvent(event:draw)
    end
  of event:GridYON orof event:GridYOFF              ! On/off grid
    savValue = self.eAxisYGrid
    self.eAxisYGrid = choose(event()=event:GridYON)
    if savValue <> self.eAxisYGrid
      self.PostEvent(event:draw)
    end
  of event:AxesScaleMinMaxON orof event:AxesScaleMinMaxOFF ! On/off Scale min/max
    savValue = self.eAxesScaleMinMax
    self.eAxesScaleMinMax = choose(event()=event:AxesScaleMinMaxON)
    if self.eAxesScaleMinMax <> savValue
      self.PostEvent(event:draw)
    end
  of event:AxesNameON orof event:AxesNameOFF        ! On/off axes names
    savValue = choose(self.eAxisXname or self.eAxisYname)
    self.eAxisXname = choose(event()=event:AxesNameON)
    self.eAxisYname = choose(event()=event:AxesNameON)
    if savValue <> choose(self.eAxisXname or self.eAxisYname)
      self.PostEvent(event:draw)
    end
  of event:3DON orof event:3DOFF                    ! On/off 3D
    savValue = self.e3D
    self.e3D = choose(event()=event:3DON)
    if self.e3D <> savValue
      self.PostEvent(event:draw)
    end
  of event:GradientON orof event:GradientOFF
    savValue = self.eGradient
    self.eGradient = choose(event()=event:GradientON)
    if self.eGradient <> savValue
      self.PostEvent(event:draw)
    end
  of event:NodeMinMaxON orof event:NodeMinMaxOFF    ! On/off show of node min/max
    savValue = self.eNodeMinMax
    self.eNodeMinMax = choose(event()=event:NodeMinMaxON)
    if self.eNodeMinMax <> savValue
      self.PostEvent(event:draw)
    end
  of event:NodeLabelON orof event:NodeLabelOFF      ! On/off show of node text
    savValue = self.eNodeLabel
    self.eNodeLabel = choose(event()=event:NodeLabelON)
    if self.eNodeLabel <> savValue
      self.PostEvent(event:draw)
    end
  of event:NodeValueON orof event:NodeValueOFF      ! On/off show of node value
    savValue = self.eNodeValue
    self.eNodeValue = choose(event()=event:NodeValueON)
    if self.eNodeValue <> savValue
      self.PostEvent(event:draw)
    end
  of event:NodeBgrON orof event:NodeBgrOFF          ! On/off node background
    savValue = self.eNodeBgr
    self.eNodeBgr = choose(event()=event:NodeBgrON)
    if self.eNodeBgr <> savValue
      self.PostEvent(event:draw)
    end
  of event:ToolTipON orof event:ToolTipOFF          ! On/off tip
    savValue = self.eToolTip
    self.eToolTip = choose(event()=event:ToolTipON)
  of event:SaveAs
    self.SaveAsGraph
  of event:Save
    self.SaveGraph                                  ! To save of the diagram as a WMF-file
  of event:Print
    self.PrintGraph                                 ! To print the diagram as is
  of event:PrintBestFit
    self.PrintGraph(true)                           ! To print the diagram by best fit
  of event:DrillDown
    self.GetMouse                                   ! To receive coordinates of the mouse
    if self.FindNearbyNodes(self.eMouseXl, self.eMouseYl) ! To find nearby nodes
      self.DrillDown                                ! To process Drilldown
    end
  of event:ReturnFromDrillDown
    self.GetMouse                                   ! To receive coordinates of the mouse
    self.FindNearbyNodes(self.eMouseXl, self.eMouseYl) ! To find nearby nodes
    self.ReturnFromDrillDown                        ! Return from Drilldown
  end
!
GraphClass.CalcPopup                    procedure(PopupClass PopupMgr)
locSep    long
 code
  PopupMgr.ClearKeycode=True
  if band(self.ePopUpItems,GraphPop:Title)
    PopupMgr.AddItem('Title','Title','',1)
    PopupMgr.SetItemCheck('Title',choose(~self.oTitle.eHide))
  end
  if band(self.ePopUpItems,GraphPop:Wallpaper)
    PopupMgr.AddItem('Wallpaper','Wallpaper','',1)
    PopupMgr.SetItemCheck('Wallpaper',self.eWallpaper)
  end
  if band(self.ePopUpItems,GraphPop:Zoom)
    PopupMgr.AddItem('Zoom','Zoom','',1)
    PopupMgr.AddItem('500%','Zoom500','',-1)
    PopupMgr.AddItem('300%','Zoom300','',-1)
    PopupMgr.AddItem('200%','Zoom200','',-1)
    PopupMgr.AddItem('100%','Zoom100','',-1)
    PopupMgr.AddItem('50%','Zoom50','',-1)
    PopupMgr.AddItem('25%','Zoom25','',-1)
    case self.eZoom
    of 500  ; PopupMgr.SetItemCheck('Zoom500',True)
    of 300  ; PopupMgr.SetItemCheck('Zoom300',True)
    of 200  ; PopupMgr.SetItemCheck('Zoom200',True)
    of 100  ; PopupMgr.SetItemCheck('Zoom100',True)
    of 50   ; PopupMgr.SetItemCheck('Zoom50',True)
    of 25   ; PopupMgr.SetItemCheck('Zoom25',True)
    else
       PopupMgr.SetItemCheck('Zoom100',True)
    end
  end
  if band(self.ePopUpItems, GraphPop:GraphType) or ~self.ePopUpHideItems
    PopupMgr.AddItem('Graph Type','GraphType','',1)
    PopupMgr.SetItemEnable('GraphType', choose(band(self.ePopUpItems, GraphPop:GraphType)))
    locSep = self.CalcPopupAdd2(PopupMgr, 'Scatter Graph', 'GraphTypeScatter', self.ePopUpSubGraphType, |
                                GraphPop:ScatterGraph, self.eGraphType, GraphType:ScatterGraph)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Line Graph', 'GraphTypeLine', self.ePopUpSubGraphType, |
                                  GraphPop:Line, self.eGraphType, GraphType:Line)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Area Graph', 'GraphTypeArea', self.ePopUpSubGraphType, |
                                  GraphPop:AreaGraph, self.eGraphType, GraphType:AreaGraph)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Floating Area', 'GraphTypeFloatingArea', self.ePopUpSubGraphType, |
                                  GraphPop:FloatingArea, self.eGraphType, GraphType:FloatingArea)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Column Chart', 'GraphTypeColumn', self.ePopUpSubGraphType, |
                                  GraphPop:ColumnChart, self.eGraphType, GraphType:ColumnChart)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Column with accumulation', 'GraphTypeColumnWithAccumulation', self.ePopUpSubGraphType, |
                                  GraphPop:ColumnWithAccumulation, self.eGraphType, GraphType:ColumnWithAccumulation)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Floating column', 'GraphTypeFloatingColumn', self.ePopUpSubGraphType, |
                                  GraphPop:FloatingColumn, self.eGraphType, GraphType:FloatingColumn)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Bar Chart', 'GraphTypeBar', self.ePopUpSubGraphType, |
                                  GraphPop:BarChart, self.eGraphType, GraphType:BarChart)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Bar with accumulation', 'GraphTypeBarWithAccumulation', self.ePopUpSubGraphType, |
                                  GraphPop:BarWithAccumulation, self.eGraphType, GraphType:BarWithAccumulation)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Floating bar', 'GraphTypeFloatingBar', self.ePopUpSubGraphType, |
                                  GraphPop:FloatingBar, self.eGraphType, GraphType:FloatingBar)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Pie Chart', 'GraphTypePie', self.ePopUpSubGraphType, |
                                  GraphPop:PieChart, self.eGraphType, GraphType:PieChart)
    case self.eGraphType
    of GraphType:ColumnWithAccumulation
    orof GraphType:BarWithAccumulation
      if locSep then PopupMgr.AddItem('-','Sep:GraphType','',-1) end
      PopupMgr.AddItem('Normalized','GraphSubTypeNormalized','',-1)
      case self.eGraphSubType
      of GraphSubType:Normalized  ; PopupMgr.SetItemCheck('GraphSubTypeNormalized',True)
      end
    end
  end
  if band(self.ePopUpItems,GraphPop:Figure) or ~self.ePopUpHideItems
    PopupMgr.AddItem('Figure','GraphFigure','',1)
    PopupMgr.SetItemEnable('GraphFigure', choose(band(self.ePopUpItems,GraphPop:Figure) and |
                                                 inlist(self.eGraphType,GraphType:ColumnChart,GraphType:FloatingColumn,|
                                                        GraphType:ColumnWithAccumulation, GraphType:BarWithAccumulation,|
                                                        GraphType:BarChart,GraphType:FloatingBar)))
    PopupMgr.AddItem('Bar','FigureTypeBar','',-1)
    PopupMgr.AddItem('Cylinder','FigureTypeCylinder','',-1)
    case self.eGraphFigure
    of FigureType:Bar           ; PopupMgr.SetItemCheck('FigureTypeBar',True)
    of FigureType:Cylinder      ; PopupMgr.SetItemCheck('FigureTypeCylinder',True)
    end
  end
  if band(self.ePopUpItems,GraphPop:3D) or ~self.ePopUpHideItems
    PopupMgr.AddItem('3D Effect','3D','',1)
    PopupMgr.SetItemCheck('3D',self.e3D)
    PopupMgr.SetItemEnable('3D', choose(band(self.ePopUpItems,GraphPop:3D) and |
                                        inlist(self.eGraphType,|
                                        GraphType:ColumnChart,GraphType:FloatingColumn,|
                                        GraphType:ColumnWithAccumulation, GraphType:BarWithAccumulation,|
                                        GraphType:BarChart,GraphType:FloatingBar,GraphType:PieChart)))
  end
  omit('*Not_Implemented*', true)
  if band(self.ePopUpItems,GraphPop:Gradient) or ~self.ePopUpHideItems
    PopupMgr.AddItem('Gradient Effect','Gradient','',1)
    PopupMgr.SetItemCheck('Gradient',self.eGradient)
    PopupMgr.SetItemEnable('Gradient', choose(band(self.ePopUpItems,GraphPop:Gradient) and |
                                              ~inlist(self.eGraphType,GraphType:ScatterGraph,GraphType:Line)))
  end
  !*Not_Implemented*
  if band(self.ePopUpItems,GraphPop:Legend) or ~self.ePopUpHideItems
    PopupMgr.AddItem('Legend','Legend','',1)
    PopupMgr.SetItemEnable('Legend', choose(band(self.ePopUpItems,GraphPop:Legend)))
    locSep = self.CalcPopupAdd2(PopupMgr, 'Bottom', 'LegendBottom', self.ePopUpSubLegend, |
                                GraphPop:Legend:Bottom, self.oLegend.ePosition, LegendPosition:Bottom)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Top', 'LegendTop', self.ePopUpSubLegend, |
                                  GraphPop:Legend:Top, self.oLegend.ePosition, LegendPosition:Top)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Left', 'LegendLeft', self.ePopUpSubLegend, |
                                  GraphPop:Legend:Left, self.oLegend.ePosition, LegendPosition:Left)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Right', 'LegendRight', self.ePopUpSubLegend, |
                                  GraphPop:Legend:Right, self.oLegend.ePosition, LegendPosition:Right)
    locSep += self.CalcPopupAdd2(PopupMgr, 'None', 'LegendNone', self.ePopUpSubLegend, |
                                  GraphPop:Legend:None, self.oLegend.ePosition, LegendPosition:None)
    if band(self.ePopUpItems,GraphPop:LegendBox)
      if locSep then PopupMgr.AddItem('-','Sep:LegendBox','',-1) end
      PopupMgr.AddItem('Box','LegendBox','',-1)
      PopupMgr.SetItemCheck('LegendBox',self.oLegend.eBox)
      PopupMgr.SetItemEnable('LegendBox', choose(self.oLegend.ePosition <> LegendPosition:None))
    end
  end
  if band(self.ePopUpItems,GraphPop:Axes) or ~self.ePopUpHideItems
    locSep = false
    PopupMgr.AddItem('Axis','Axis','',1)
    PopupMgr.SetItemEnable('Axis', choose(band(self.ePopUpItems,GraphPop:Axes)))
    locSep = self.CalcPopupAdd2(PopupMgr, 'Standard', 'AxesStylesStandard', self.ePopUpSubAxes, |
                                GraphPop:Axes:Standard, self.eAxesStyle, AxesStyle:Standard)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Long', 'AxesStylesLong', self.ePopUpSubAxes, |
                                  GraphPop:Axes:Long, self.eAxesStyle, AxesStyle:Long)
    locSep += self.CalcPopupAdd2(PopupMgr, 'None', 'AxesStylesNone', self.ePopUpSubAxes, |
                                  GraphPop:Axes:None, self.eAxesStyle, AxesStyle:None)
    if band(self.ePopUpItems,GraphPop:AxesName)
      if locSep then PopupMgr.AddItem('-','Sep:AxesName','',-1) end
      PopupMgr.AddItem('Axis name','AxesName','',-1)
      PopupMgr.SetItemCheck('AxesName',choose(self.eAxisXname or self.eAxisYname))
      PopupMgr.SetItemEnable('AxesName', choose(self.eAxesStyle <> AxesStyle:None))
    end
    if band(self.ePopUpItems,GraphPop:Grid)
      if locSep or band(self.ePopUpItems,GraphPop:AxesName)
        PopupMgr.AddItem('-','Sep:Grid','',-1)
      end
      PopupMgr.AddItem('Grid','Grid','',-1)
      PopupMgr.SetItemCheck('Grid', self.eAxesGrid)
      PopupMgr.SetItemEnable('Grid', choose(self.eAxesStyle <> AxesStyle:None))
      if band(self.ePopUpItems,GraphPop:GridX)
        PopupMgr.AddItem('Grid X','GridX','',-1)
        PopupMgr.SetItemCheck('GridX', self.eAxisXGrid)
        PopupMgr.SetItemEnable('GridX', choose(self.eAxesGrid and self.eAxesStyle <> AxesStyle:None))
      end
      if band(self.ePopUpItems,GraphPop:GridY)
        PopupMgr.AddItem('Grid Y','GridY','',-1)
        PopupMgr.SetItemCheck('GridY', self.eAxisYGrid)
        PopupMgr.SetItemEnable('GridY', choose(self.eAxesGrid and self.eAxesStyle <> AxesStyle:None))
      end
    end
    if band(self.ePopUpItems,GraphPop:AxesScale)
      if locSep or band(self.ePopUpItems,GraphPop:AxesName) or self.eAxesGrid
        PopupMgr.AddItem('-','Sep:AxesScale','',-1)
      end
      PopupMgr.AddItem('Scale linear','AxesScaleLinear','',-1)
      PopupMgr.AddItem('Scale as MS Word','AxesScaleAsMSWord','',-1)
        case self.eAxesScale
        of Scale:AsMSWord         ; PopupMgr.SetItemCheck('AxesScaleAsMSWord',true)
        else
          PopupMgr.SetItemCheck('AxesScaleLinear',true)
        end
    end
    if band(self.ePopUpItems,GraphPop:AxesScaleMinMax)
      if locSep or band(self.ePopUpItems,GraphPop:AxesName) or self.eAxesGrid or band(self.ePopUpItems,GraphPop:AxesScale)
        PopupMgr.AddItem('-','Sep:AxesScaleMinMax','',-1)
      end
      PopupMgr.AddItem('Scale min/max','AxesScaleMinMax','',-1)
      PopupMgr.SetItemCheck('AxesScaleMinMax',self.eAxesScaleMinMax)
      if inlist(self.eAxesScale, Scale:AsMSWord) or |
         inlist(self.eGraphType, GraphType:ColumnWithAccumulation, GraphType:BarWithAccumulation)
        PopupMgr.SetItemEnable('AxesScaleMinMax', false)
      else
        PopupMgr.SetItemEnable('AxesScaleMinMax', true)
      end
    end
  end
  if band(self.ePopUpItems,GraphPop:Node) or ~self.ePopUpHideItems
    PopupMgr.AddItem('Node','Node','',1)
    PopupMgr.SetItemEnable('Node', choose(band(self.ePopUpItems,GraphPop:Node) and |
                                          inlist(self.eGraphType,GraphType:Line,GraphType:ScatterGraph,|
                                          GraphType:AreaGraph,GraphType:FloatingArea,GraphType:PieChart)))
    locSep = self.CalcPopupAdd2(PopupMgr, 'Square', 'NodeTypeSquare', self.ePopUpSubNode, |
                                GraphPop:Node:Square, self.eNodeType, NodeType:Square)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Triangle', 'NodeTypeTriangle', self.ePopUpSubNode, |
                                  GraphPop:Node:Triangle, self.eNodeType, NodeType:Triangle)
    locSep += self.CalcPopupAdd2(PopupMgr, 'Circle', 'NodeTypeCircle', self.ePopUpSubNode, |
                                  GraphPop:Node:Circle, self.eNodeType, NodeType:Circle)
    locSep += self.CalcPopupAdd2(PopupMgr, 'None', 'NodeTypeNone', self.ePopUpSubNode, |
                                  GraphPop:Node:None, self.eNodeType, NodeType:None)
    if band(self.ePopUpItems,GraphPop:NodeMinMax+GraphPop:NodeLabel+GraphPop:NodeValue)
      if locSep then PopupMgr.AddItem('-','Sep:NodeMinMax','',-1) end
      if band(self.ePopUpItems,GraphPop:NodeMinMax)
        PopupMgr.AddItem('Minimum/Maximum','NodeMinMax','',-1)
        PopupMgr.SetItemCheck('NodeMinMax',self.eNodeMinMax)
        locSep = true
      end
      if band(self.ePopUpItems,GraphPop:NodeLabel)
        PopupMgr.AddItem('Show a label','NodeLabel','',-1)
        PopupMgr.SetItemCheck('NodeLabel',self.eNodeLabel)
        locSep = true
      end
      if band(self.ePopUpItems,GraphPop:NodeValue)
        PopupMgr.AddItem('Show a value','NodeValue','',-1)
        PopupMgr.SetItemCheck('NodeValue',self.eNodeValue)
        locSep = true
      end
    end
    if locSep or band(self.ePopUpItems,GraphPop:NodeMinMax+GraphPop:NodeLabel+GraphPop:NodeValue)
      PopupMgr.AddItem('-','Sep:NodeBgr','',-1)
    end
    PopupMgr.AddItem('Show a background','NodeBgr','',-1)
    PopupMgr.SetItemCheck('NodeBgr',self.eNodeBgr)
  end
  PopupMgr.AddItem('-','Sep:Print','',1)
  if band(self.ePopUpItems,GraphPop:Print)
    PopupMgr.AddItem('Print','Print','',1)
  end
  if band(self.ePopUpItems,GraphPop:PrintBestFit)
    PopupMgr.AddItem('Print best fit','PrintBestFit','',1)
  end
  PopupMgr.AddItem('-','Sep:Save','',1)
  if band(self.ePopUpItems,GraphPop:Save)
    PopupMgr.AddItem('Save','Save','',1)
  end
  if band(self.ePopUpItems,GraphPop:SaveAs)
    PopupMgr.AddItem('Save As...','SaveAs','',1)
  end
  if band(self.ePopUpItems,GraphPop:DrillDown) or band(self.ePopUpItems,GraphPop:ReturnFromDrillDown)
    PopupMgr.AddItem('-','Sep:DrillDown','',1)
    if band(self.ePopUpItems,GraphPop:DrillDown)
      PopupMgr.AddItem('Drill Down','DrillDown','',1)
      PopupMgr.SetItemEnable('DrillDown', choose(self.IsOverNode()<>false))
    end
    if band(self.ePopUpItems,GraphPop:ReturnFromDrillDown)
      PopupMgr.AddItem('Return from DrillDown','ReturnFromDrillDown','',1)
    end
  end
  if band(self.ePopUpItems,GraphPop:ToolTip)
    PopupMgr.AddItem('-','Sep:ToolTip','',1)
    PopupMgr.AddItem('ToolTip','ToolTip','',1)
    PopupMgr.SetItemCheck('ToolTip',self.eToolTip)
  end
!
GraphClass.PopupAsk                 procedure(PopupClass PopupMgr)
 code
  return PopupMgr.Ask()                             ! display popup menu
!
GraphClass.Popup                    procedure
PopupString       any                               ! to receive menu selection
PopupMgr          PopupClass                        ! declare PopupMgr object
 code
  if ~self.ePopUpItems
    return
  end
  PopupMgr.Init()                                   ! initialize PopupMgr object
  self.CalcPopup(PopupMgr)
  PopupString = self.PopupAsk(PopupMgr)             ! display popup menu
  !
  case lower(PopupString)                           ! check for selected item
  of 'disable'                                      ! if Disable item selected
  of lower('GraphTypeScatter')        ; self.PostEvent(event:GraphTypeScatterGraph)
  of lower('GraphTypeLine')           ; self.PostEvent(event:GraphTypeLine)
  of lower('GraphTypeArea')           ; self.PostEvent(event:GraphTypeAreaGraph)
  of lower('GraphTypeFloatingArea')   ; self.PostEvent(event:GraphTypeFloatingArea)
  of lower('GraphTypeColumn')         ; self.PostEvent(event:GraphTypeColumnChart)
  of lower('GraphTypeColumnWithAccumulation') ; self.PostEvent(event:GraphTypeColumnWithAccumulation)
  of lower('GraphTypeFloatingColumn') ; self.PostEvent(event:GraphTypeFloatingColumn)
  of lower('GraphTypeBar')            ; self.PostEvent(event:GraphTypeBarChart)
  of lower('GraphTypeBarWithAccumulation') ; self.PostEvent(event:GraphTypeBarWithAccumulation)
  of lower('GraphTypeFloatingBar')    ; self.PostEvent(event:GraphTypeFloatingBar)
  of lower('GraphTypePie')            ; self.PostEvent(event:GraphTypePieChart)
  of lower('GraphSubTypeNormalized')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:GraphSubTypeNormalized,event:GraphSubTypeSimple))
  of lower('FigureTypeBar')           ; self.PostEvent(event:FigureTypeBar)
  of lower('FigureTypeCylinder')      ; self.PostEvent(event:FigureTypeCylinder)
  of lower('LegendNone')              ; self.PostEvent(event:LegendPosition:None)
  of lower('LegendLeft')              ; self.PostEvent(event:LegendPosition:Left)
  of lower('LegendRight')             ; self.PostEvent(event:LegendPosition:Right)
  of lower('LegendTop')               ; self.PostEvent(event:LegendPosition:Top)
  of lower('LegendBottom')            ; self.PostEvent(event:LegendPosition:Bottom)
  of lower('AxesStylesNone')          ; self.PostEvent(event:AxesStyle:None)
  of lower('AxesStylesStandard')      ; self.PostEvent(event:AxesStyle:Standard)
  of lower('AxesStylesLong')          ; self.PostEvent(event:AxesStyle:Long)
  of lower('AxesScaleLinear')         ; self.PostEvent(event:AxesScale:Linear)
  of lower('AxesScaleAsMSWord')       ; self.PostEvent(event:AxesScale:AsMSWord)
  of lower('NodeTypeNone')            ; self.PostEvent(event:NodeType:None)
  of lower('NodeTypeSquare')          ; self.PostEvent(event:NodeType:Square)
  of lower('NodeTypeTriangle')        ; self.PostEvent(event:NodeType:Triangle)
  of lower('NodeTypeCircle')          ; self.PostEvent(event:NodeType:Circle)
  of lower('zoom500')                 ; self.PostEvent(event:Zoom500)
  of lower('zoom300')                 ; self.PostEvent(event:Zoom300)
  of lower('zoom200')                 ; self.PostEvent(event:Zoom200)
  of lower('zoom100')                 ; self.PostEvent(event:Zoom100)
  of lower('zoom50')                  ; self.PostEvent(event:Zoom50)
  of lower('zoom25')                  ; self.PostEvent(event:Zoom25)
  of lower('Print')                   ; self.PostEvent(event:Print)
  of lower('PrintBestFit')            ; self.PostEvent(event:PrintBestFit)
  of lower('Save')                    ; self.PostEvent(event:Save)
  of lower('SaveAs')                  ; self.PostEvent(event:SaveAs)
  of lower('DrillDown')               ; self.PostEvent(event:DrillDown)
  of lower('ReturnFromDrillDown')     ; self.PostEvent(event:ReturnFromDrillDown)
  of lower('Title')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:TitleON,event:TitleOFF))
  of lower('Wallpaper')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:WallpaperON,event:WallpaperOFF))
  of lower('3D')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:3DON,event:3DOFF))
  of lower('Grid')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:GridON,event:GridOFF))
  of lower('GridX')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:GridXON,event:GridXOFF))
  of lower('GridY')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:GridYON,event:GridYOFF))
  of lower('AxesScaleMinMax')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:AxesScaleMinMaxON,event:AxesScaleMinMaxOFF))
  of lower('AxesName')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:AxesNameON,event:AxesNameOFF))
  of lower('Gradient')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:GradientON,event:GradientOFF))
  of lower('NodeMinMax')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:NodeMinMaxON,event:NodeMinMaxOFF))
  of lower('NodeLabel')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:NodeLabelON,event:NodeLabelOFF))
  of lower('NodeValue')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:NodeValueON,event:NodeValueOFF))
  of lower('NodeBgr')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:NodeBgrON,event:NodeBgrOFF))
  of lower('LegendBox')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:LegendBoxON,event:LegendBoxOFF))
  of lower('ToolTip')
    self.PostEvent(choose(~PopupMgr.GetItemChecked(PopupString),event:ToolTipON,event:ToolTipOFF))
  end
!
  PopupMgr.Kill
!
GraphClass.CalcPopupAdd2            procedure(PopupClass PopupMgr, string parText, string parName, long parItems, |
                                              long parMask, long parCheck, long parCheckValue)
 code
  if band(parItems, parMask) or ~self.ePopUpHideItems
    PopupMgr.AddItem(parText, parName,'',-1)
    if band(parItems, parMask)
      PopupMgr.SetItemCheck(parName,choose(parCheck = parCheckValue))
    else
      PopupMgr.SetItemEnable(parName, false)
    end
    return 1
  end
  return 0
!
! iNode interface
GraphClass.iNode.Null               procedure(*queue parQ)
 code
  return self.Null(parQ)
!
GraphClass.iNode.Set                procedure(*queue parQ, signed parPointer=0)
 code
  return self.Set(parQ, parPointer)
!
GraphClass.iNode.Next               procedure(*queue parQ)
 code
  return self.Next(parQ)
!
GraphClass.iNode.Previous           procedure(*queue parQ)
 code
  return self.Previous(parQ)
!
GraphClass.iNode.ErrCode            procedure(<signed parValue>)
 code
  return self.ErrCode(parValue)
!
GraphClass.iNode.PushStyle          procedure
 code
  self.PushStyle
!
GraphClass.iNode.PopStyle           procedure
 code
  self.PopStyle
!
GraphClass.iNode.SetStyle           procedure(<long parColor>, <long parPenWidth>, <long parPenStyle>)
 code
  if omitted(2) and omitted(3) and omitted(4)
    self.SetStyle
  elsif ~omitted(2) and omitted(3) and omitted(4)
    self.SetStyle(parColor)
  elsif omitted(2) and ~omitted(3) and omitted(4)
    self.SetStyle(,parPenWidth)
  elsif omitted(2) and omitted(3) and ~omitted(4)
    self.SetStyle(,,parPenStyle)
  elsif ~omitted(2) and ~omitted(3) and omitted(4)
    self.SetStyle(parColor,parPenWidth)
  elsif ~omitted(2) and omitted(3) and ~omitted(4)
    self.SetStyle(parColor,,parPenStyle)
  elsif ~omitted(2) and omitted(3) and ~omitted(4)
    self.SetStyle(,parPenWidth,parPenStyle)
  else
    self.SetStyle(parColor,parPenWidth,parPenStyle)
  end
!
GraphClass.iNode.Window             procedure
 code
  return address(self.eWindow)
!
GraphClass.iNode.ToLW               procedure(real parValue)
 code
  return self.ToLW(parValue)
!
GraphClass.iNode.CPolygon           procedure(real parX, real parY, real parR, real parAngle=45, long parType=4, <*gFillType parFill>)
 code
  if omitted(7)
    self.CPolygon(parX, parY, parR, parAngle, parType)
  else
    self.CPolygon(parX, parY, parR, parAngle, parType, parFill)
  end
!
GraphClass.iNode.Circle             procedure(real parX, real parY, real parR, <*gFillType parFill>)
 code
  if omitted(5)
    self.Circle(parX, parY, parR)
  else
    self.Circle(parX, parY, parR, parFill)
  end
!
GraphClass.iNode.Inbox              procedure(real parX, real parY, real parBoxX, real parBoxY, real parBoxW, real parBoxH)
 code
  return self.Inbox(parX, parY, parBoxX, parBoxY, parBoxW, parBoxH)
!
GraphClass.iNode.NodeNameText       procedure
 code
  return self.NodeNameText()
!
GraphClass.iNode.TextBorder         procedure
 code
  return self.gNodeProp.eBorderColor
!
GraphClass.iNode.TextBgr            procedure
 code
  return self.gNodeProp.eBgrColor
!
GraphClass.iNode.MinID              procedure
 code
  return self.qGraph.eNodeMinID
!
GraphClass.iNode.MaxID              procedure
 code
  return self.qGraph.eNodeMaxID
!
GraphClass.iNode.SensitivityRadius  procedure
 code
  return self.eSensitivityRadius
! iDiagram interface
GraphClass.iDiagram.Null            procedure(*queue parQ)
 code
  return self.Null(parQ)
!
GraphClass.iDiagram.Set             procedure(*queue parQ, signed parPointer=0)
 code
  return self.Set(parQ, parPointer)
!
GraphClass.iDiagram.Next            procedure(*queue parQ)
 code
  return self.Next(parQ)
!
GraphClass.iDiagram.Previous        procedure(*queue parQ)
 code
  return self.Previous(parQ)
!
GraphClass.iDiagram.ErrCode         procedure(<signed parValue>)
 code
  return self.ErrCode(parValue)
!
GraphClass.iDiagram.PushStyle       procedure
 code
  self.PushStyle
!
GraphClass.iDiagram.PopStyle        procedure
 code
  self.PopStyle
!
GraphClass.iDiagram.SetStyle        procedure(<long parColor>, <long parPenWidth>, <long parPenStyle>)
 code
  if omitted(2) and omitted(3) and omitted(4)
    self.SetStyle
  elsif ~omitted(2) and omitted(3) and omitted(4)
    self.SetStyle(parColor)
  elsif omitted(2) and ~omitted(3) and omitted(4)
    self.SetStyle(,parPenWidth)
  elsif omitted(2) and omitted(3) and ~omitted(4)
    self.SetStyle(,,parPenStyle)
  elsif ~omitted(2) and ~omitted(3) and omitted(4)
    self.SetStyle(parColor,parPenWidth)
  elsif ~omitted(2) and omitted(3) and ~omitted(4)
    self.SetStyle(parColor,,parPenStyle)
  elsif ~omitted(2) and omitted(3) and ~omitted(4)
    self.SetStyle(,parPenWidth,parPenStyle)
  else
    self.SetStyle(parColor,parPenWidth,parPenStyle)
  end
!
GraphClass.iDiagram.ToH             procedure(real parValue)
 code
  return self.ToH(parValue)
!
GraphClass.iDiagram.ToLH            procedure(real parValue)
 code
  return self.ToLH(parValue)
!
GraphClass.iDiagram.AToLX           procedure(real parValue)
 code
  return self.AToLX(parValue)
!
GraphClass.iDiagram.AToLY           procedure(real parValue)
 code
  return self.AToLY(parValue)
!
GraphClass.iDiagram.Pie             procedure(real parX, real parY, real parW, real parH, qPieType parQ, real parDepth=0, long parWholevalue=0, long parStartangle=0)
 code
  self.Pie(parX, parY, parW, parH, parQ, parDepth, parWholevalue, parStartangle)
!
GraphClass.iDiagram.Rad             procedure(real parX, real parY)
 code
  return self.Rad(parX, parY)
!
GraphClass.iDiagram.HCylinder       procedure(real parX, real parY, real parW, real parR, real parDepth=0, *gFillType parFill)
 code
  self.HCylinder(parX, parY, parW, parR, parDepth, parFill)
!
GraphClass.iDiagram.HBar            procedure(real parX, real parY, real parW, real parR, real parDepth=0, *gFillType parFill)
 code
  self.HBar(parX, parY, parW, parR, parDepth, parFill)
!
GraphClass.iDiagram.VCylinder       procedure(real parX, real parY, real parW, real parR, real parDepth=0, *gFillType parFill)
 code
  self.VCylinder(parX, parY, parW, parR, parDepth, parFill)
!
GraphClass.iDiagram.VBar            procedure(real parX, real parY, real parH, real parR, real parDepth=0, *gFillType parFill)
 code
  self.VBar(parX, parY, parH, parR, parDepth, parFill)
!
GraphClass.iDiagram.InHCylinder     procedure(real parX, real parY, real parCylX, real parCylY, real parCylW, real parCylR, real parDepth)
 code
  return self.InHCylinder(parX, parY, parCylX, parCylY, parCylW, parCylR, parDepth)
!
GraphClass.iDiagram.InVCylinder     procedure(real parX, real parY, real parCylX, real parCylY, real parCylH, real parCylR, real parDepth)
 code
  return self.InVCylinder(parX, parY, parCylX, parCylY, parCylH, parCylR, parDepth)
!
GraphClass.iDiagram.Inbox           procedure(real parX, real parY, real parBoxX, real parBoxY, real parBoxW, real parBoxH, real parDepth, real parAngle=45)
 code
  return self.Inbox(parX, parY, parBoxX, parBoxY, parBoxW, parBoxH, parDepth, parAngle)
!
GraphClass.iDiagram.Polygon         procedure(qXYType parQ, <*gFillType parFill>)
 code
  if omitted(3)
    self.Polygon(parQ)
  else
    self.Polygon(parQ, parFill)
  end
!
GraphClass.iDiagram.XYLine          procedure(real parX, real parY, real parX2, real parY2)
 code
  self.XYLine(parX, parY, parX2, parY2)
!
GraphClass.iDiagram.AxesMinX        procedure
 code
  return self.gAxisMin.eX
!
GraphClass.iDiagram.AxesMinY        procedure
 code
  return self.gAxisMin.eY
!
GraphClass.iDiagram.Window          procedure
 code
  return address(self.eWindow)
!
GraphClass.iDiagram.ClusterSearch   procedure(string parCluster, bool parCheckID=true)
 code
  return self.ClusterSearch(parCluster, parCheckID)
!
GraphClass.iDiagram.ClusterPos      procedure(<real parValue>)
 code
  if ~omitted(2)
    self.qCluster.ePos = parValue
    put(self.qCluster)
    self.ErrCode(errorcode())
  end
  return self.qCluster.ePos
!
GraphClass.iDiagram.ClusterSumH     procedure(<real parValue>)
 code
  if ~omitted(2)
    self.qCluster.eSumH = parValue
    put(self.qCluster)
    self.ErrCode(errorcode())
  end
  return self.qCluster.eSumH
!
GraphClass.iDiagram.ClusterSumY     procedure
 code
  return self.qCluster.gSum.eY
!
GraphClass.iDiagram.ClusterSumYmax  procedure
 code
  return self.eSumYmax
!
GraphClass.iDiagram.BarOverlap      procedure
 code
  return self.eBarOverlap
!
