!ABCIncludeFile(GRAPH)

OMIT('_EndOfInclude_',_GraphPresent_)
_GraphPresent_ EQUATE(1)

 INCLUDE('SVGraph.equ'),ONCE
 INCLUDE('ABPOPUP.INC'),ONCE
 INCLUDE('ABREPORT.INC'),ONCE
! Standard structure types descriptions
! ---------------------------------------------------------------------------------------
! Some constants *******************************************************************
LF_FullFaceSize         equate(64)                  ! Max. font name length
! Structures *****************************************************************************
gFactorCoordinateType group,type                    ! Coordinates transformation factor
eXb                     long                        ! Zero point in device' coordinates
eYb                     long
eFx                     real                        ! Transformation factor (for transformating in device' units)
eFy                     real
                      end
! ---------------------------------------------------------------------------------------
gFontType             group,type                    ! font parameters
eFontName               string(LF_FullFaceSize)
eFontSize               long
eFontColor              long
eFontStyle              long
eCharSet                byte
                      end
! ---------------------------------------------------------------------------------------
gFillType             group, type
eColor                  long(color:none)
eColor2                 long(color:none)
eStyle                  long
                      end
! ---------------------------------------------------------------------------------------
gTextStyle            group, type                   ! The style of the text
gFont                   group(gFontType) end
gBgrFill                like(gFillType)
eBorderColor            long(color:none)
eBorderStyle            long
eBorderWidth            real
eBorderDepth            real
eAlignment              byte
eAngle                  real
                      end
! ---------------------------------------------------------------------------------------
qTextStyle            queue, type                   ! The list of styles of the text
eID                     long
gStyle                  like(gTextStyle)
                      end
! ---------------------------------------------------------------------------------------
gIntPositionType      group,type                    ! 2D integer coordinates
eX                      signed
eY                      signed
eW                      signed
eH                      signed
                      end
! ---------------------------------------------------------------------------------------
gPositionType         group,type                    ! 2D coordinates
eX                      real
eY                      real
eW                      real
eH                      real
                      end
! ---------------------------------------------------------------------------------------
gDistanceType         group,type                    ! Indents
eL                      real                        ! At the left
eT                      real                        ! At the top
eR                      real                        ! At the right
eB                      real                        ! At the bottom
                      end
! ---------------------------------------------------------------------------------------
gXYType               group,type                    ! XY of coordinate in absolute units
eX                      real
eY                      real
                      end
! ---------------------------------------------------------------------------------------
gWHDType              group,type                    ! WHD coordinates in logical units
eW                      real
eH                      real
!eD                      real
                      end
! ---------------------------------------------------------------------------------------
qXYType               queue,type                    ! Coordinates list
eX                      real
eY                      real
                      end
! ---------------------------------------------------------------------------------------
qPieType              queue,type                    ! Sectors list for the PIE
eSlice                  real                        ! Relative size
gFill                   like(gFillType)             ! Filling
                      end
! ---------------------------------------------------------------------------------------
gDevModeType          group, type
eDeviceName             string(32)                  !PROPPRINT:Device
eSpecVersion            ushort
eDriverVersion          ushort
eSize                   ushort
eDriverExtra            ushort
eFields                 ulong
eOrientation            short
ePaperSize              short                       !PROPPRINT:Paper
ePaperLength            short                       !PROPPRINT:PaperHeight
ePaperWidth             short                       !PROPPRINT:PaperWidth
eScale                  short                       !PROPPRINT:Percent
eCopies                 short                       !PROPPRINT:Copies
eDefaultSource          short                       !PROPPRINT:PaperBin
ePrintQuality           short                       !PROPPRINT:Resolution
eColor                  short                       !PROPPRINT:Color
eDuplex                 short                       !PROPPRINT:Duplex
eYResolution            short
eTTOption               short
eCollate                short
eFormName               string(32)
eLogPixels              ushort
eBitsPerPel             ulong
PelsWidth               ulong
ePelsHeight             ulong
eDisplayFlags           ulong
eNup                    ulong
eDisplayFrequency       ulong
! if (WINVER >= 0x0400)
eICMMethod              ulong
eICMIntent              ulong
eMediaType              ulong
eDitherType             ulong
eReserved1              ulong
eReserved2              ulong
! if (WINVER >= 0x0500) || (_WIN32_WINNT >= 0x0400)
ePanningWidth           ulong
ePanningHeight          ulong
                      end
! ---------------------------------------------------------------------------------------
qGrStyleType          queue,type                    ! Drawing styles stack
eColor                  long
eWidth                  long
eStyle                  long
                      end
! ---------------------------------------------------------------------------------------
qGrFontType           queue, type                   ! Font parameters stack
                        like(gFontType)
                      end
! ---------------------------------------------------------------------------------------
qGrMeasureType        queue, type                   ! Measures stack
ePixels                 byte
eThous                  byte
eMm                     byte
ePoints                 byte
                      end
! ---------------------------------------------------------------------------------------
qBarPartstype         queue, type
gRec                    like(gPositionType)
gFill                   like(gFillType)
                      end
! ---------------------------------------------------------------------------------------
qLegendType           queue, type                   ! Legend elements list
eID                     long
eText                   any
                        like(gPositionType)
eBoxType                short
eBoxR                   long
gBoxFill                like(gFillType)
eRow                    long
                      end
! ---------------------------------------------------------------------------------------
qStrokeType           queue, type                   ! Axis points' parameters
eID                     long                        ! Ordiecutive number
eText                   string(60)                  ! Text to be drawn
gFont                   like(gFontType)
eTextW                  real                        ! Text length
eTextH                  real                        ! Text height
ePos                    real                        ! Stroke position
eLen                    real                        ! Stroke length
eThickness              real                        ! Strike thickness
eGrid                   byte                        ! true - draw Grid line
                      end
! ---------------------------------------------------------------------------------------
qAxisType             queue, type                   ! Axis parameters
eID                     long                        ! Number of an axis under the order (unique)
eLabel                  string(60)                  ! Label of axis
eStyle                  long                        ! Axis style
Name                    &GraphTextClass             ! The name of an axis
eNameAlignment          byte                        ! Alignment of a name relatively of an axis
qStroke                 &qStrokeType                ! Axis points' parameters
eMin                    real                        ! Min. values
eMax                    real                        ! Max. values
eFactor                 real                        ! Coeffs for transformating absolute units to logical units
eFormat                 string(30)                  ! Format of numbers
eColor                  long                        ! Axes lines colour
eArrowLen               real
gRec                    like(gPositionType)         ! private: Rectangle for drawing
                      end
! ---------------------------------------------------------------------------------------
qNodeType             queue, type                   ! Nodes list
eID                     long                        ! Number of node under the order (unique)
eClusterID              long                        !
eName                   any                         ! Node name (unique)
eType                   short                       ! Node TYPE (by default)
gFill                   like(gFillType)             ! Filling of the node
eHide                   byte                        ! Don't display node
gXY                     like(gXYTYPE)               ! Node's 2D-coordinates in absolute units
eTip                    any                         ! Text to be displayed in pop-up hint
!
oNode                   &GraphNodeClass
                      end
! ---------------------------------------------------------------------------------------
qClusterType          queue, type
eID                     long                        ! Number of cluster under the order (unique)
eName                   string(90)                  ! Name of cluster (unique)
eCalcType               long                        ! Type of calculation
oText                   &GraphTextClass             ! The text for show
!
gSum                    like(gXYTYPE)               ! private: The sum of values in absolute units
eNodes                  long                        ! private: Quantity of nodes in a cluster
eNodesFloat             long                        ! private: Quantity of nodes in a cluster for Floating bars
ePos                    real                        ! private: The current position of a bar
eSumH                   real                        ! private:
                      end
! ---------------------------------------------------------------------------------------
qGraphType            queue,type                    ! Diagrams list
eID                     long                        ! Diagram number (unique)
eName                   any                         ! Diagram name (unique)
eType                   short                       ! Type of the Diagram
eSubType                short                       ! Subtype of the Diagram
gFill                   like(gFillType)             ! Filling of the diagram
eHide                   long                        ! Don't display diagram
qNode                   &qNodeType                  ! Nodes list
ePieDepth               real                        ! for PIE
!
oDiagram                &GraphDiagramClass
eNodeMinID              long                        ! private: Number of node having the minimal value Y
eNodeMaxID              long                        ! private: Number of node having the maximal value Y
                      end
! ---------------------------------------------------------------------------------------
qSelectedNodeType     queue,type                    ! List of selected node
eID                     long                        ! Number of node under the order
                      end
! ---------------------------------------------------------------------------------------
qSelectedGraphType    queue,type                    ! List of selected Diagrams
eID                     long                        ! Number of diagram under the order
qSelectedNode           &qSelectedNodeType
                      end
! ---------------------------------------------------------------------------------------
iGDI          interface
Null                  procedure(*queue parQ), signed
Set                   procedure(*queue parQ, signed parPointer=0), signed, proc
Next                  procedure(*queue parQ), signed, proc
Previous              procedure(*queue parQ), signed, proc
ErrCode               procedure(<signed parValue>), signed, proc, virtual
PushStyle             procedure
PopStyle              procedure
SetStyle              procedure(<long parColor>, <long parPenWidth>, <long parPenStyle>)
Window                procedure(), signed
!
              end
GraphTextClass      class,type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
iText                 &iText
!
eText                 any
eTextTSyle            long
!
eFontName             string(LF_FullFaceSize)
eFontSize             long
eFontColor            long
eFontStyle            long
eCharSet              byte
gBgr                  group(gFillType)
                      end
eBorderColor          long
eAlignment            byte
eAngle                real
!
eX                    real                            ! Rectangle for drawing
eY                    real
eW                    real
eH                    real
eTextW                real
eTextH                real
!
Destruct              procedure
Init                  procedure(iText parIText), virtual
Init                  procedure, virtual
SetText               procedure(string parText), virtual
AddText               procedure(string parText, <string parSep>), virtual
SetFont               procedure(<string parFontName>, <long parFontSize>, <long parFontColor>, <long parFontStyle>, <long parCharSet>), virtual
SetBgr                procedure(<long parColor>, <long parColor2>, <long parStyle>), virtual
SetBorder             procedure(long parColor=color:none), virtual
SetAlignment          procedure(long parValue), virtual
SetAngle              procedure(real parAngle), virtual
SetRectangle          procedure(<real parX>, <real parY>, <real parW>, <real parH>), virtual
Calculate             procedure, virtual
!
Draw                  procedure, virtual
                    end
!----------------------------------------------------------------------------------------
iText               interface
FParent               procedure(), long
PushFont              procedure
PopFont               procedure
SetFont               procedure(*gFontType parFont, long parField=0)
PushStyle             procedure
PopStyle              procedure
SetStyle              procedure(<long parColor>, <long parPenWidth>, <long parPenStyle>)
GetTextPoint          procedure(long parField=0, string parText, <*? parW>, <*? parH>)
Box                   procedure(real parX, real parY, real parW, real parH, <*gFillType parFill>)
FactorYb              procedure(<real parValue>), real
ToX                   procedure(real parValue), long
ToY                   procedure(real parValue), long
                    end
!----------------------------------------------------------------------------------------
GraphNodeClass      class,type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
qNode                 &qNodeType
iNode                 &iNode
!
eType                 short                         ! Node TYPE
gRec                  like(gPositionType)           ! Coordinates for drawing in logic units
gFill                 like(gFillType)               ! Filling of the node
eRadius               real                          ! Radius of node
oText                 &GraphTextClass               ! The text for show
!
eHide                 byte                          ! True - Don't display node
eToShowMinMax         byte                          ! True - To show a minimum and maximum
eToShowLabel          byte                          ! True - To show a label
eToShowValue          byte                          ! True - To show a value
eToShowBgr            byte                          ! True - To show a background
gProp                 group(gFontType)              ! Node Inscription font
eBgrColor               long                        ! Node background color
eBorderColor            long                        ! Node border color
                      end
eBestPositionText     byte
!
Construct             procedure
Destruct              procedure
Init                  procedure(qNodeType parQ, iNode parINode, iText parIText)
Init                  procedure
SetRectangle          procedure(<real parX>, <real parY>, <real parW>, <real parH>)
SetFill               procedure(gFillType parFill)
SetDefault            procedure, virtual
Draw                  procedure, virtual
DrawMinMax            procedure, virtual
InNode                procedure(real parX, real parY), long, virtual
                    end
!----------------------------------------------------------------------------------------
iNode               interface(iGDI)
ToLW                  procedure(real parValue), real
Inbox                 procedure(real parX, real parY, real parBoxX, real parBoxY, real parBoxW, real parBoxH), bool
CPolygon              procedure(real parX, real parY, real parR, real parAngle=45, long parType=4, <*gFillType parFill>)
Circle                procedure(real parX, real parY, real parR, <*gFillType parFill>)
NodeNameText          procedure, string
TextBorder            procedure, long
TextBgr               procedure, long
MinID                 procedure, long
MaxID                 procedure, long
SensitivityRadius     procedure, long
                    end
!----------------------------------------------------------------------------------------
GraphDiagramClass   class,type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
qGraph                &qGraphType
iDiagram              &iDiagram
!
eType                 short                         ! Type of the Diagram
eSubType              short                         ! Subtype of the Diagram
eNodeMinID            long                          ! Number of node having the minimal value Y
eNodeMaxID            long                          ! Number of node having the maximal value Y
gRec                  like(gPositionType)           ! Rectangle for drawing
gFill                 like(gFillType)
eDrawNode             bool
eDrawNodeMinMax       bool
! 3D
eDepth                real
!
eBarRadius            real
eFigure               short                         ! Figure for drawing
!
eSliceSum             real                          ! for PIE
eSumForPie            real
!
Init                  procedure(qGraphType parQ, iDiagram parIDiagram)
SetRectangle          procedure(<real parX>, <real parY>, <real parW>, <real parH>)
SetFill               procedure(gFillType parFill)
Draw                  procedure, virtual
SetDefault            procedure, virtual
InDiagram             procedure(real parX, real parY), long, virtual
!
CalcNode              procedure, virtual
DrawNode              procedure, virtual            ! Draw current node
                    end
!----------------------------------------------------------------------------------------
GraphLineClass      class(GraphDiagramClass),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
Draw                  procedure, virtual
SetDefault            procedure, virtual
                    end
!----------------------------------------------------------------------------------------
GraphScatterClass   class(GraphDiagramClass),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
Draw                  procedure, virtual
                    end
!----------------------------------------------------------------------------------------
GraphAreaClass      class(GraphLineClass),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
eDrawLine             bool
Draw                  procedure, virtual
SetDefault            procedure, virtual
                    end
!----------------------------------------------------------------------------------------
GraphFloatingAreaClass class(GraphLineClass),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
eDrawLine             bool
Draw                  procedure, virtual
SetDefault            procedure, virtual
                    end
!----------------------------------------------------------------------------------------
GraphColumnClass    class(GraphDiagramClass),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
Draw                  procedure, virtual
SetDefault            procedure, virtual
CalcNode              procedure, virtual
InDiagram             procedure(real parX, real parY), long, virtual
                    end
!----------------------------------------------------------------------------------------
GraphFloatingColumnClass class(GraphColumnClass),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
Draw                  procedure, virtual
CalcNode              procedure, virtual
InDiagram             procedure(real parX, real parY), long, virtual
                    end
!----------------------------------------------------------------------------------------
GraphColumnWithAccumulationClass class(GraphColumnClass),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
CalcNode              procedure, virtual
                    end
!----------------------------------------------------------------------------------------
GraphBarClass       class(GraphDiagramClass),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
Draw                  procedure, virtual
SetDefault            procedure, virtual
CalcNode              procedure, virtual
InDiagram             procedure(real parX, real parY), long, virtual
                    end
!----------------------------------------------------------------------------------------
GraphFloatingBarClass class(GraphBarClass),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
Draw                  procedure, virtual
CalcNode              procedure, virtual
InDiagram             procedure(real parX, real parY), long, virtual
                    end
!----------------------------------------------------------------------------------------
GraphBarWithAccumulationClass class(GraphBarClass),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
CalcNode              procedure, virtual
                    end
!----------------------------------------------------------------------------------------
GraphPieClass       class(GraphDiagramClass),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
Draw                  procedure, virtual
SetDefault            procedure, virtual
CalcNode              procedure, virtual
InDiagram             procedure(real parX, real parY), long, virtual
                    end
!----------------------------------------------------------------------------------------
iDiagram            interface(iGDI)
ToH                   procedure(real parValue), long
ToLH                  procedure(real parValue), real
AToLX                 procedure(real parValue), real
AToLY                 procedure(real parValue), real
Pie                   procedure(real parX, real parY, real parW, real parH, qPieType parQ, real parDepth=0, long parWholevalue=0, long parStartangle=0)
Rad                   procedure(real parX, real parY), real
HCylinder             procedure(real parX, real parY, real parW, real parR, real parDepth=0, *gFillType parFill)
HBar                  procedure(real parX, real parY, real parW, real parR, real parDepth=0, *gFillType parFill)
VCylinder             procedure(real parX, real parY, real parW, real parR, real parDepth=0, *gFillType parFill)
VBar                  procedure(real parX, real parY, real parH, real parR, real parDepth=0, *gFillType parFill)
Inbox                 procedure(real parX, real parY, real parBoxX, real parBoxY, real parBoxW, real parBoxH, real parDepth, real parAngle=45), bool
InHCylinder           procedure(real parX, real parY, real parCylX, real parCylY, real parCylW, real parCylR, real parDepth), bool
InVCylinder           procedure(real parX, real parY, real parCylX, real parCylY, real parCylH, real parCylR, real parDepth), bool
Polygon               procedure(qXYType parQ, <*gFillType parFill>)
XYLine                procedure(real parX, real parY, real parX2, real parY2)
!
AxesMinX              procedure, real
AxesMinY              procedure, real
!
ClusterSearch         procedure(string parCluster, bool parCheckID=true), long, proc
ClusterPos            procedure(<real parValue>), real, proc
ClusterSumH           procedure(<real parValue>), real, proc
ClusterSumY           procedure(), real
ClusterSumYmax        procedure(), real
BarOverlap            procedure(), real
                    end
!----------------------------------------------------------------------------------------
GraphTitleClass     class(GraphTextClass),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
eHide                 byte                          ! True - to not show
gRec                  like(gPositionType)           ! Area for drawing
!
Init                  procedure(iText parIText), virtual
Calculate             procedure, virtual
Draw                  procedure, virtual
                    end
!----------------------------------------------------------------------------------------
GraphLegendClass    class,type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
qGraph                &qGraphType
qLegend               &qLegendType
iLegend               &iLegend
!
ePosition             short                         ! Location (do not show, left, right, top, bottom)
eBox                  byte                          ! Draw the frame
eCellPadding          long                          ! Indent off the frame
gFont                 like(gFontTYPE)               ! Font parameters
gRec                  like(gPositionType)           ! Area for drawing
gDist                 like(gDistanceType)           ! Indents
!
gPos                  like(gPositionTYPE)           ! Legend position (will be calculated)
eRows                 long
eCols                 long
!
construct             procedure
destruct              procedure
Init                  procedure(*iLegend parILegend, *qGraphType parQGraph)
Init                  procedure
BuildqLegend          procedure(), virtual          ! Creates legend parameters list
CountRows             procedure(), virtual          ! Counting lines
Optimize              procedure(), virtual          ! Optimizing elements locations
GetFirstItemInRow     procedure(long parRi), long, virtual ! Find first element in the STRING
PosLegend             procedure(), virtual          ! Positioning the legend
Calculate             procedure(), virtual          ! Calculate legend
Draw                  procedure(), virtual          ! Draw legend
                    end
! ---------------------------------------------------------------------------------------
iLegend             interface(iGDI)
PushFont              procedure
PopFont               procedure
SetFont               procedure(*gFontType parFont, long parField=0)
GetTextPoint          procedure(long parField=0, string parText, <*? parW>, <*? parH>)
Show                  procedure(real parX, real parY, string parText, <gFontType parFont>, long parBgrColor=color:none, long parBorderColor=color:none)
Box                   procedure(real parX, real parY, real parW, real parH, <*gFillType parFill>)
RoundBox              procedure(real parX, real parY, real parW, real parH, <*gFillType parFill>)
NextColor             procedure(long parNum, long parPalette=256), long
GraphType             procedure, long
GetFont               procedure(*gFontType parFont)
                    end
!----------------------------------------------------------------------------------------
! "GraphPrimitiveClass" - Standard graphic methods class
!----------------------------------------------------------------------------------------
GraphPrimitiveClass class,type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
eDebug                byte
eErrorCode            signed,private                ! Last error code. Use ErrCode()
eToPixelsX            real
eToPixelsY            real
! Variables for internal usage
ePalette              long, dim(256)
qTStyle               &qTextStyle
qGrFont               &qGrFontType,private
qGrStyle              &qGrStyleType,private
qGrMeasure            &qGrMeasureType,private
gFactorXY             like(gFactorCoordinateType),private ! Use SetFactorXY(); FactorY(); FactorYb() etc
eGrField              long,private
eWindow               &window
eFParent              long,private                  ! Use FParent()
eFBand                long                          ! IMAGE field
!
Construct             procedure
Destruct              procedure
!
FParent               procedure(<long parField>), long, proc, virtual
ErrCode               procedure(<signed parErrorcode>), signed, proc, virtual
ErrWinCode            procedure(), signed, proc, virtual
ErrWinMessage         procedure(long parErrorCode), string, proc, virtual
CheckHandle           procedure(unsigned parHandle), signed, virtual
CheckTarget           procedure(), signed, virtual
Settarget             procedure(), signed, proc, virtual
! Sets initial coordinates and transformation coeffs
! from logic units to units of the device -----------------------------------------------
SetFactorXY           procedure(<real parXb>, <real parYb>, <real parFx>, <real parFy>), virtual
FactorYb              procedure(<real parValue>), real
FactorXb              procedure(<real parValue>), real
FactorX               procedure(<real parValue>), real
FactorY               procedure(<real parValue>), real
ToX                   procedure(real parValue), long
ToY                   procedure(real parValue), long
ToW                   procedure(real parValue), long
ToH                   procedure(real parValue), long
ToPos                 procedure(*gPositionType parPosU, *gPositionType parPos)
! from units of the device to logic unit ------------------------------------------------
ToLX                  procedure(real parValue), real
ToLY                  procedure(real parValue), real
ToLW                  procedure(real parValue), real
ToLH                  procedure(real parValue), real
ToLPos                procedure(*gPositionType parPos, *gPositionType parLPos)
! Positioning screen object
SetPosition           procedure(long parField, gPositionType parPos)
! Screen objects coordinates
GetPosition           procedure(long parField, *gPositionType parPos)
! Get text's width & height
GetTextPoint          procedure(long parField=0, string parText, <*? parW>, <*? parH>)
GetTextRec            procedure(long parField, string parText, *gPositionType parPos)
! Get text width
GetTextWidth          procedure(string parText, long parField=0), real
! Get text heigth
GetTextHeight         procedure(string parText, long parField=0), real
!
GetPrinterProp        procedure(long parProp), ?
! Graphic primitives --------------------------------------------------------------------
Box                   procedure(real parX, real parY, real parW, real parH, <*gFillType parFill>), virtual
Pie                   procedure(real parX, real parY, real parW, real parH, qPieType parQ, real parDepth=0, long parWholevalue=0, long parStartangle=0), virtual
Line                  procedure(real parX, real parY, real parW, real parH), virtual
HLine                 procedure(real parX, real parY, real parW, <real parPenWidth>), virtual
RoundBox              procedure(real parX, real parY, real parW, real parH, <*gFillType parFill>), virtual
Show                  procedure(real parX, real parY, string parText, <gFontType parFont>, long parBgrColor=color:none, long parBorderColor=color:none), virtual
! Circle with center at (X,Y) and radius R
Circle                procedure(real parX, real parY, real parR, <*gFillType parFill>), virtual
! Line from (x1,y1) to (x2,y2)
XYLine                procedure(real parX, real parY, real parX2, real parY2), virtual
! Vertical line
VLine                 procedure(gPositionType parPos, long parStyle=0, long parPenColor=color:windowtext, real parPenWidth=0), virtual
! Horizontal line
HLine                 procedure(gPositionType parPos, long parStyle=0, long parPenColor=color:windowtext, real parPenWidth=0), virtual
! Triangle by three points
Triangle              procedure(real parX1, real parY1, real parX2, real parY2, real parX3, real parY3, long parStyle=0, <*gFillType parFill>), virtual
! Square with center at (X,Y) and side 2*R (incircle radius = R)
RBox                  procedure(real parX, real parY, real parR, <*gFillType parFill>), virtual
Polygon               procedure(qXYType parQ, <*gFillType parFill>), virtual
CPolygon              procedure(real parX, real parY, real parR, real parAngle=45, long parType=4, <*gFillType parFill>), virtual
! Vertical column -----------------------------------------------------------------------
VBar                  procedure(real parX, real parY, real parH, real parR, real parDepth=0, *gFillType parFill), virtual
VBar                  procedure(*qBarPartstype parBar, real parR, real parDepth=0), virtual
VCylinder             procedure(real parX, real parY, real parW, real parR, real parDepth=0, *gFillType parFill), virtual
VCylinder             procedure(*qBarPartstype parBar, real parR, real parDepth=0), virtual
! Horizontal column (row) ---------------------------------------------------------------
HBar                  procedure(real parX, real parY, real parW, real parR, real parDepth=0, *gFillType parFill), virtual
HBar                  procedure(*qBarPartstype parBar, real parR, real parDepth=0), virtual
HCylinder             procedure(real parX, real parY, real parW, real parR, real parDepth=0, *gFillType parFill), virtual
HCylinder             procedure(*qBarPartstype parBar, real parR, real parDepth=0), virtual
! Methods of measures -------------------------------------------------------------------
PushMeasure           procedure(window parWindow)
PopMeasure            procedure(window parWindow)
PushMeasure           procedure
PopMeasure            procedure
SetMeasure            procedure(), virtual
! Methods of styles ---------------------------------------------------------------------
PushStyle             procedure
PopStyle              procedure
SetStyle              procedure(long parColor=color:WindowText, long parPenWidth=0, long parPenStyle=pen:Solid)
! Methods of fonts ----------------------------------------------------------------------
PushFont              procedure
PopFont               procedure
GetFont               procedure(*gFontType parFont, <long parField>)
SetFont               procedure(*gFontType parFont, long parField=0)
SetFont               procedure(*gFontType parFont, long parField, bool parSet)
SetFont               procedure(long parFieldIn, long parFieldOut)
! Methods of colours --------------------------------------------------------------------
InitPalette           procedure(long parPalette=256)
GetColor              procedure(long parNum, long parPalette=256), long ! Colour from the standard palette
NextColor             procedure(long parNum, long parPalette=256), long ! Next color in standard palette
GetNumColor           procedure(long parColor, long parPalette=256), long ! Color number (in standard palette)
! ---------------------------------------------------------------------------------------
! Some primitive methods to use queue
Null                  procedure(*queue parQ), long
Set                   procedure(*queue parQ, long parPointer=0), long, proc
Next                  procedure(*queue parQ), long, proc
Previous              procedure(*queue parQ), long, proc
!
Deg                   procedure(real parX, real parY), real
Rad                   procedure(real parX, real parY), real
!
Inbox                 procedure(real parX, real parY, real parBoxX, real parBoxY, real parBoxW, real parBoxH), bool
Inbox                 procedure(real parX, real parY, real parBoxX, real parBoxY, real parBoxW, real parBoxH, real parDepth, real parAngle=45), bool
Inbox                 procedure(real parX, real parY, gXYType parXY, gWHDType parWHD), bool
InHCylinder           procedure(real parX, real parY, real parCylX, real parCylY, real parCylW, real parCylR, real parDepth), bool
InVCylinder           procedure(real parX, real parY, real parCylX, real parCylY, real parCylH, real parCylR, real parDepth), bool
InPolygon             procedure(real parX, real parY, qXYType parQ), bool
InPolygon             procedure(real parX, real parY, real parX1, real parY1, real parX2, real parY2, real parX3, real parY3, <real parX4>, <real parY4>), bool
InEllipse             procedure(real parX, real parY, real parEllipseX, real parEllipseY, real parEllipseW, real parEllipseH), bool
! Other ---------------------------------------------------------------------------------
FileNameMerge         procedure(<string parFileName>, <string parDrv>, <string parDir>, <string parName>, <string parExt>), string
FileNamePart          procedure(string parFileName, long parPart=FileName:FileName), string
FileNameExt           procedure(string parFileName), string
GetTempFileName       procedure(<string parPrefix>, <string parExt>), string, virtual
StringToFile          procedure(string parS, <string parFileName>, bool parAdd=false), string, virtual
!
WMFHeader             procedure(gPositionType parPos), string, virtual
ImageToWMF            procedure(), string, virtual
ImageToEMF            procedure(), string, virtual
                  end
! "GraphBasicClass" - class used to work with graphics
! ---------------------------------------------------------------------------------------
GraphBasicClass   class(GraphPrimitiveClass),type,implements(iText),implements(iLegend),module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
qGraph                &qGraphType                   ! The list of the diagrams
qCluster              &qClusterType                 ! The list of clusters
gParent               group(gPositionType)
                        like(gDistanceType), pre()
                      end
eFRegion              long                          ! REGION field
eFRegionZoom          long
eFToolTip             long                          ! Field for ToolTip
oTitle                &GraphTitleClass              ! Diagram Title parameters
oLegend               &GraphLegendClass             ! Legend parameters
! Wallpaper parameters
eWallpaper            byte                          ! True - Wallpaper output
eWallpaperFile        string(file:MaxFileName)      ! File Name for Wallpaper
! Diagram parameters
eGraphType            short                         ! Type of the diagram
eGraphSubType         short                         ! Subtype of the diagram
eGraphFigure          short                         ! Figure for drawing
gGraphRect            like(gPositionType)           ! Area for drawing the diagram (for IMAGE)
gGraphDist            like(gDistanceType)           ! Indents
eZoom                 decimal(5,2)                  ! Zomm (0.00-999.00)
e3D                   byte                          ! True - output in 3D mode
eGradient             byte                          ! True - output with gradient
eInteractivity        byte                          ! Interactivity
ePieDepth             real                          ! Depth for a PIE
! Node parameters
eNodeType             short                         ! Node TYPE
eNodeRadius           real                          ! Radius of node
eNodeMinMax           byte                          ! True - To show a minimum and maximum
eNodeLabel            byte                          ! True - To show a label
eNodeValue            byte                          ! True - To show a value
eNodeBgr              byte                          ! True - To show a background
gNodeProp             group(gFontType)              ! Node Inscription font
eBgrColor               long                        ! Node background color
eBorderColor            long                        ! Node border color
                      end
eBestPositionNodeText byte
! Parameters of popup menu
ePopUpItems           long
ePopUpSubGraphType    long
ePopUpSubLegend       long
ePopUpSubAxes         long
ePopUpSubNode         long
ePopUpHideItems       bool
! Interactivity parameters
ePopUp                byte                          ! True - To show Popup the menu when the key MouseRight is pressed
eToolTip              byte                          ! True - show tooltip
eBestPositionToolTip  byte
gToolTipProp          group(gFontType)              ! Font parameters
eBgrColor               long                        ! Background
eTrn                    byte                        ! Transparent background
CorrectionOfWidth       long
CorrectionOfHeight      long
                      end
eMouseX               real                          ! Current coordinate of the mouse (X) in pixels
eMouseY               real                          ! Current coordinate of the mouse (Y) in pixels
eMouseXl              real                          ! Current coordinate of the mouse (X) in logic units
eMouseYl              real                          ! Current coordinate of the mouse (Y) in logic units
eMouseXa              real                          ! Current coordinate of the mouse (X) in physical(absolute) units
eMouseYa              real                          ! Current coordinate of the mouse (Y) in physical(absolute) units
!
eSensitivityRadius    long                          ! Sensitivity Radius in pixels
qSelectedGraph        &qSelectedGraphType           ! List of selected Diagrams
! Parameters of Printer
eChoosePrinterFlag    byte                          ! True - To choose the printer
! Parameters of a print
gPrint                group
ePreview                byte
eOrientation            byte
eBox                    byte
                        like(gDistanceType)         ! Indents
eAlignment              long                        ! Alignment: Left; Right; HCenter; Top; Bottom; VCenter
eStretch                long                        ! Stretch: 01b - along horizontal; 10b - along vertical
eProportional           bool                        ! To keep a proportion
                      end
! Drill Down
eFDrillDown           long
eFReturnFromDrillDown long
! Parameters of a saving
eSaveFileNameAlwaysExt bool
eSaveFileName         string(file:MaxFileName)
! Current values
eEventLast            long                          ! Last message
!
Construct             procedure
Destruct              procedure
! The Graph -----------------------------------------------------------------------------
Free:qGraph           procedure
Clear:qGraph          procedure
! Find diagram in list
GraphSearch           procedure(string parGraph, bool parCheckID=true), long, proc, virtual
GraphNextColor        procedure, long, virtual
! Add diagram to the list
GraphAdd              procedure(string parName, long parTYPE=GraphTYPE:Line), long, proc, virtual
GraphFill             procedure(<long parColor>, <long parColor2>, <long parStyle>), virtual
! The Clusters --------------------------------------------------------------------------
Free:qCluster         procedure
Clear:qCluster        procedure
ClusterAdd            procedure(string parLabel, <string parText>, <long parCalcType>), long, proc, virtual
ClusterSearch         procedure(string parCluster, bool parCheckID=true), long, proc, virtual
! The Node ------------------------------------------------------------------------------
Clear:qNode           procedure
! Node search in list of current diagram
NodeSearch            procedure(string parNode, bool parCheckID=true), long, proc, virtual
! Add node to the list
NodeAdd               procedure(real parX, real parY, <long parTYPE>, <string parName>, long parClusterID=0), long, proc, virtual
NodeFill              procedure(<long parColor>, <long parColor2>, <long parStyle>), virtual
! Renew node in the list
NodeUpdate            procedure(long parNode, <real parX>, <real parY>, <long parTYPE>, <*gFillType parFill>, <string parName>), long, proc, virtual
! Remove node from the list
NodeDelete            procedure(long parNode), long, proc, virtual
CalculationMinMax     procedure, long, proc, virtual
UpdatingMinMax        procedure, long, proc, virtual
!
Free:qSelectedGraph   procedure
SynchronizeWithSelectedNode procedure, virtual
SetSelectedNode       procedure(long parGraphNpp=-1, long parNodeNpp=-1), long, proc, virtual
NextSelectedNode      procedure, long, proc, virtual
PreviousSelectedNode  procedure, long, proc, virtual
!
Hide                  procedure(), virtual          ! Hide the graphic
UnHide                procedure(), virtual          ! UnHide the graphic
RegionZoom            procedure(bool parEnable=true), virtual
                    end
!----------------------------------------------------------------------------------------
! "GraphAxisClass" - Class for handling axes
! ---------------------------------------------------------------------------------------
GraphAxisClass      class(GraphBasicClass),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
! Axes parameters
eAxesStyle            long                          ! Style of axes
eAxesScale            long                          ! Style of a scale
eAxesScaleMinMax      bool                          ! Scale from minimal up to maximal
eAxesGrid             bool                          ! True - to show a grid
!
eAxisXname            bool                          ! True - to show a name of an axis X
oAxisXname            &GraphTextClass               ! The name of an axis X
qStrokeX              &qStrokeType                  ! Points' parameters of the horizontal axis
eAxesXScale           long                          ! Style of a scale
eAxisXScaleInterval   real                          ! Distance between strokes of an axis (Scale interval) [pixel or mm]
eAxisXFormat          string(30)                    ! Horizontzl axis' numbers format
eAxisXColor           long                          ! Colour of a line of an axis
eAxisXThickness       real                          ! Thickness of a line in logic units
eAxisXGrid            bool                          ! True - to show a grid
eGridXColor           long                          ! Grid lines colour
eGridXStyle           long                          ! Grid lines style
!
eAxisYname            bool                          ! True - to show a name of an axis Y
oAxisYname            &GraphTextClass               ! The name of an axis Y
qStrokeY              &qStrokeType                  ! Points' parameters of the vertical axis
eAxesYScale           long                          ! Style of a scale
eAxisYScaleInterval   real                          ! Distance between strokes of an axis (Scale interval) [pixel or mm]
eAxisYFormat          string(30)                    ! Vertical axis' number format
eAxisYColor           long                          ! Colour of a line of an axis
eAxisYThickness       real                          ! Thickness of a line in logic units
eAxisYGrid            bool                          ! True - to show a grid
eGridYColor           long                          ! Grid lines colour
eGridYStyle           long                          ! Grid lines style
!
gAxisMin              like(gXYTYPE)                 ! Min. values
gAxisMax              like(gXYTYPE)                 ! Max. values
gAxisFactor           like(gXYTYPE)                 ! Coefficients for transformation of physical units to logic units
! Grid parameters
eGridColor            long                          ! Grid lines colour
eGridStyle            long                          ! Grid lines style
! Vertical/horizontal axes parameters
eBarGroupDistance     real                          ! Min. distance between column groups
eBarRadius            real                          ! Column's half-width for BarGraph
eBarOverlap           real                          ! Overlapping for the columns
eBarDepth             real                          ! 3D depth
!
Construct             procedure
Destruct              procedure
AxesScaleMinMax       procedure(<long parValue>), bool, proc, virtual
! Sets coeffs for transformating from logical units to physical units
SetFactor             procedure(<real parFx>, <real parFy>)
AToLX                 procedure(real parValue), real
AToLY                 procedure(real parValue), real
! Sets min./max. values for the axes
SetMinMax             procedure(<real parXmin>, <real parXmax>, <real parYmin>, <real parYmax>)
CalcMinMax            procedure(), virtual
! Add stroke description
StrokeAdd             procedure(qStrokeType parQ, long parN, <string parText>, <real parPos>, <real parLen>, <byte parGrid>), virtual
! Calculation of axes
CalcAxes              procedure, virtual
CalcAxisBar           procedure(qStrokeType parQ, long parAxis), virtual
CalcAxis              procedure(qStrokeType parQ, long parAxis), virtual
GetYTextPoint         procedure(? parValue, <*? parW>, <*? parH>, <*? parMaxLen>), string, proc, virtual
GetYTextMaxWidth      procedure(), real, virtual
GetXTextMaxHeight     procedure(), real, virtual
! Drawing of axes
DrawAxisY             procedure, virtual
DrawAxisX             procedure, virtual
DrawAxes              procedure, virtual
                    end
!----------------------------------------------------------------------------------------
! "GraphClass"
gShowToType         group, type
eOnT                  byte
eOnW                  byte
eOnF                  long
eOnS                  long
                    end
!----------------------------------------------------------------------------------------
GraphClass          class(GraphAxisClass),implements(iDiagram),implements(iNode),type,module('SVGraph.clw'),link('SVGraph.clw',_ABCLinkMode_),dll(_ABCDllMode_)
!
gShowMouse            like(gShowToType)
gShowMouseX           like(gShowToType)
gShowMouseY           like(gShowToType)
gShowDiagramName      like(gShowToType)
gShowDiagramNameV     like(gShowToType)
gShowNodeName         like(gShowToType)
gShowNodeNameV        like(gShowToType)
gShowNodeValue        like(gShowToType)
gShowNodeValueX       like(gShowToType)
gShowNodeValueY       like(gShowToType)
eShowSBonFirstThread  bool                          ! If SatusBar in target is not added then to show on SatusBar of first thread
!
eSumYmax              real
! Initializing object
Init                  procedure(window parWin, long parFParent, real parL=0, real parT=0, real parR=0, real parB=0) !,EXTENDS
Kill                  procedure !,EXTENDS
! Set initial values
SetDefault            procedure(), virtual
! Send message to the object (to parent object eFParent)
PostEvent             procedure(long parEvent), virtual
! Handle events (which has been sent to the parent object eFParent, and controls)
TakeEvent             procedure(), virtual
TakeEventOfParent     procedure, virtual
CalcPopup             procedure(PopupClass PopupMgr), virtual
CalcPopupAdd2         procedure(PopupClass PopupMgr, string parText, string parName, long parItems, long parItemMask, long parCheck, long parCheckValue), long, virtual
PopupAsk              procedure(PopupClass PopupMgr), string, virtual
Popup                 procedure, virtual
BeginRefresh          procedure(), bool, virtual
Refresh               procedure(byte parRefresh=false), virtual ! Refresh object
Resize                procedure(long parResize=false), virtual  ! Set object's size
Draw                  procedure(), virtual          ! To draw object
CalcGraph             procedure(), virtual          ! To calculate object
CalcCurrentNode       procedure(), virtual
CalcCurrentGraph      procedure(), virtual
CalcBestPositionNodeText procedure(), virtual
DrawGraph             procedure(), virtual          ! To draw diagrams
DrawWallPaper         procedure(), virtual
DrawReport            procedure(*report parReport, long parBand, queue parQRpt, bool parBestFit=false), virtual
PrintGraph            procedure(bool parBestFit=false), virtual
SaveGraph             procedure(bool parAsk=false), virtual
SaveAsGraph           procedure, virtual
MouseText             procedure(bool parShow=true), string, virtual
MouseXText            procedure(bool parShow=true), string, virtual
MouseYText            procedure(bool parShow=true), string, virtual
DiagramNameText       procedure(bool parShow=true), string, virtual
DiagramText           procedure(bool parShow=true), string, virtual
NodeXText             procedure(bool parShow=true), string, virtual
NodeYText             procedure(bool parShow=true), string, virtual
NodeValueText         procedure(bool parShow=true), string, virtual
NodeNameText          procedure(bool parShow=true), string, virtual
NodeTipText           procedure(bool parShow=true), string, virtual
NodeText              procedure(bool parShowName=true, bool parShowValue=true), string, virtual
AllText               procedure(), string, virtual
Interactivity         procedure, virtual
GetValueFromStatusBar procedure(long parN), string, virtual
ShowOnStatusBar       procedure(string parText, long parN), virtual
GetValueFromField     procedure(long parField), string, virtual
ShowOnField           procedure(string parText, long parField), virtual
ToShowValues          procedure, virtual
ToolTip               procedure, virtual
DrillDown             procedure, virtual
DrillDown             procedure(long parGraphNpp, string parGraphName, long parNodeNpp, string parNodeName, real parNodeX, real parNodeY), virtual
ReturnFromDrillDown   procedure, virtual
ReturnFromDrillDown   procedure(long parGraphNpp, string parGraphName, long parNodeNpp, string parNodeName, real parNodeX, real parNodeY), virtual
GetMouse              procedure, virtual
IsOverNode            procedure(), bool, virtual
FindNearbyNodes       procedure(real parX, real parY), long, proc, virtual
                    end
!----------------------------------------------------------------------------------------

 _EndOfInclude_
