Unit rchart;

(******************************************************************)
(*                                                                *)
(*                           R C H A R T                          *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1996..2001 H. Lohninger                 January 1996   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Jul-28, 2001                                  *)
(*                                                                *)
(******************************************************************)

{ Editorial Remark - version 4.00:
    The user defined tick labels of the axes (introduced with
    version 4.00 of RChart) goes back to an implementation of
    Benedikt Magrean (Magrean@IBAC.rwth-aachen.de) and Michael
    Jägers of IBAC, RWTH-Aachen, Germany, who kindly provided
    their sources. After checking their approach, I decided
    to go a slightly different way, which is more consistent with
    the overall design of RChart. Thanks to Ben and Michael for their
    support. }

{ Editorial Remark - version 5.00:
    The user defined text labels (introduced with version 5.00 of RChart)
    have been adapted from a first implementation by A. Pohlers, Dresden,
    Germany. Thanks for his support. }

{ Editorial Remark - version 5.50:
    The problem with the mouse cursor when leaving the control has been fixed
    with the help of Ch. Hofbauer, Vienna. Thanks Christian !}

{------------------------------------------------------------------------

Revision history
================

1.0   [March 1996]
      first released in March 1996

1.1   [Apr-01, 1996]

1.2   [Apr-22, 1996]
      DrawCanType ---> TDrawCan
      single ----> double
      Text-Item reduced to 10 byte size !
      Implementation of the following methods and properties:
         function  FindNearestItemReal
         function  FindNearestItemScreen
         procedure ScaleItem
         function  GetItemFParams
         procedure ScaleAllItems
         procedure ScaleSelectedItems
         procedure NewColorOfClassItems
         procedure SetRange
         function TRChart.MarkItemsInWindow
         procedure MarkAllItems
         function TRChart.Mousebox
         property  MouseAction
      The methods M2R and R2M are now public
      Mouse-Position is now always available - but only updated if mouse is
                     within Chart Window
      ClassNumber of Item introduced.

2.00  [Apr-24, 1996]
      both 16- and 32-bit version are available now
      Identifier 'Token' is replaced by 'Item'
      Logarithmic scales implemented
      function SetItemFParams implemented

2.01  [Apr-26, 1996]
      ShiftItem with kx,ky
      FindNearest... with dist parameter returned & class number restriction
      Note on classes: Itemclass is set to ClassDefault on creation (drawing) of an element
      class number 255 has special meaning: means every class (when searching)

2.02  [Jul-15, 1996]
      Grid implemented
      Frame around data window is now drawn correctly
      MouseAction is indicated by different cursors
      Help file improved
      Align property implemented

2.03  [Sep-12, 1996]
      Bug fixed: Mouse cursor labels now display the correct mouse position
        after a rescaling of the chart
      Numeric Labels are now detached from RChart and implemented as separate
         components. A special mouse interrupt is defined in order to link
         a label to the mouse cursor position (in chart coordinates)
      Bug in Printit fixed (bug was actually not in Printit but in Delphi
         printer canvas routine - replaced by Windows API call)
      New procedure CopyToOpenPrinter implemented
      TRcOneNumLabel, and TRchMouseLabel are discarded and replaced by TNumLab
      Bug fixed: MousePosY returns now the correct value
      Bug fixed: panning and zooming no longer crashes application if span of
         axis is very small compared to the absolute value of the axis values
      DateTime inscription implemented
      OnMouseMoveInChart event implemented
      Precision of coords of data elements changed to double
      Text item enlarged to 15 characters

2.04  [Jan-13, 1997]
      property MouseCursorFixed implemented
      property TypeOfFirstItem implemented
      property TypeOfLastItem implemented
      drawing speed improved by approx. 100% for large connected line
         drawings of the same color (using MoveTo and DrawTo)
         if the items are ordered by color)
      property LineWidth implemented  (see example CLOCK)
      property AutoRedraw implemented
      bug in ShowGraf fixed which caused the property Visible to be
         mismatched to the actual state of the component.
      shadow implemented (properties ShadowStyle, ShadowWidth,
         ShadowColor, ShadowBakColor)
      text items can now be adjusted in some parameters (font style,
         background style and bkg color)
           (property TextFontStyle: TFontStyles read FTextFontStyle write SetTextFontStyle;
            property TextBkStyle: TBrushStyle read FTextBkStyle write SetTextBkStyle;
            property TextBkColor: TColor read FTextBkColor write SetTextBkColor;
            ... bkg color has effect only if bkgstyle is not bsClear - which is the default !)

      tkLine and tkRect items are now drawn as dot if their extents are zero
         (not valid for tkLineTo !!)
      MarkAt has two new entries (bold cross, full circle)
      bug in logarithmic axis inscription fixed: number of scale ticks does
         not change any more when panned with the mouse (this bug occured only
         under rare circumstances)

3.00  [May-25, 1997]
      property PopupMenu implemented
      MaxRCMarks is available now
      properties ShortTicksX, and ShortTicksY implemented (to suppress short ticks on axes)
      property FirstItemOfLinkedList: pointer to anchor of linked list is now publicly available
      TBkgFill type
      FigType has now changed identifiers (i.e. 'Time' caused problems)
      TRFrameStyle
      RectFrame
      property FillColor implemented (-->rect/ellipse/frame/bar3d):
               Datacolor is now border line, FillColor is filling color
      method Ellipse implemented
      numbering on logarithmic axes with DecPlaceX/Y = -2 improved (no trailing zeroes any more)
      method SaveLinkedListASC implemented
*      method SaveLinkedList implemented
      method LoadLinkedList implemented
      method CopyToClipBoard implemented
      method CopyToBMP implemented
      TBakGndImg class
      background image (BMP) implemented
      bug with line width setting fixed: changing the line width is now displayed correctly

3.01  [Aug-20,1997]
      DCommon no longer needed
      property ScaleInscriptX implemented
      property ScaleInscriptY implemented
      DecPlacesX/Y extended to -3 (log. scales)
      ShowGraf no longer switches the visible state to true
      method SHowGrafNewOnly implemented
      method Autorange implemented
      SetRange now checks for situations where one of the axes has no extents
      minimum height and width of RChart now restricted to meaningful values

      bug fix: mouse zoom box behaved erratically if more than one chart is
               set to MouseAction <> maNone; (was problem with local variables)
      bug fix: application with RChart crashed if height of graphics area of RChart
               was reduced to zero
      background property editor is now centered on screen
      bug fix: exponents are now correctly displayed for linear scales
      bug fix: line width is now correctly handled (hopefully ;-)
      help file improved
      bug fix: background image resources were not released correctly on destroy
      bug fix: data are now printed in color
      bug fix: event MouseMoveInChart no more triggered by Paint method

3.02  [Apr-08,1998]
      bug fix: MouseAction = maZoomWindPos now does not change axes (increasing vs.
               decreasing scales)
      bug fix: zooming by dragging no longer crashes the application when
               logarithmic axes are about to become negative
      bug fix: global constants MinWidth and MinHeight caused naming conflict with some
               property in unit "comctrls". These two constants are renamed now to
               MinRCWidth, and MinRCHeight, respectively (sorry for any inconvenience)
      new default colors: shadows are now clGrayText/clBtnFace
                          WindColor is now clBtnFace

4.00  [Aug-08, 1998]
      RCHART is now available for Delphi 4.0
      ZoomState is now made public (as a readonly property)
*      property DataTag implemented
      tkNotMoveTo implemented
      property TextAlignment implemented
      OnZoomPan event implemented
      bug in OnMouseMoveInChart fixed, which caused occasional crashes
      FindMinMax implemented
      automatic alignment of grid implemented (grid lines appear at scale tick positions)
      bug fixed which prevented RChart from displaying the scale ticks if
        "XLabelType=ftNoFigs" and "ShortTicksX=false")
      bug fix: RChart no longer hangs if the ratio between the range of an axis and
        the grid spacing (GridDx, or GridDy) is large (>10e5)
      the public constants DefHeight and DefWidth are now renamed to DefRCHeight and
        DefRCWidth in order to avoid naming conflicts with other components
      ZoomHistory implemented
      maZoomWind and maZoomWindPos now act more Windows-like (zoom window can be resized
        while holding down the left mouse button)
      user definable tick labels implemented (X/YLabelType = ftUserText, properties UserTickTextX/Y)
      rccommon and rcbakbmp no longer needed for RChart operation
      16 Bit environment (Delphi 1) no longer supported
      smallest displayable coordinates now lowered to 1e-100 (was 1e-30)
      new property ClassVisible controls visibility of items
      RemoveItem implemented
      ConfineZoomRange implemented
      bug fix: '0.0' on scale was occasionally displayed as '-0.0'
      bug fix: Rchart disappeared on form designer of IDE if Visible was set FALSE
      CrossHair implemented (CrossHairSetup, CrossHairSetPos, CrossHairPosX, CrossHairPosY);
      PrintItHiRes implemented

4.01  [Aug-23, 1998]
      CopyToOpenPrinterHiRes implemented
      PrintIt and PrintItHiRes now print the hardcopy centered
      PrintItHiRes has now black-and-white option
      bug fix: axis labels are now displayed correctly for scale ranges greater than 1e5
                           (this bug was introduced with version 4.00)
      bug fix: PrintItHiRes now prints the marks correctly, broken help page corrected
      bug fix: PrintIt now prints scales in black and white mode correctly

4.02  [Apr-08, 1999]
      property Isometric implemented
      property ItemCount implemented
      property OnCanResize implemented
      method CopyToBitmap implemented
      bug fix: fill color was not set to gray value when chart window was
         copied as black and white image
      methods CopyToBMP and CopyToClipBoard extended (black-and-white option)
      position of scale ticks can now be retrieved
         (properties TickNumX, TickPosX, TickNumY, TickPosY)
      property MouseAction extended (maPanVert, maPanHoriz)
*      property TransparentItems implemented

5.00  [Sep-25, 1999]
      RChart is now available for D5
      Delphi 2.0 no longer supported
      bug fix: MarkAt (items 13, 14, 15) are now correctly filled
      bug fix: zero values of RangeHiX/Y and RangeLoX/Y are now correctly loaded
      bug fix: background bitmap editor in D4 now works correctly
*      chart elements are now stored in a doubly linked list
      LoadLinkedList and SaveLinkedList use a new file format
      new property LastItemOfLinkedList
      bug fix: ItemCount is now correct after LoadLinkedList (FName, true)
      bug fix: AutoRange now works correctly for logarithmix scales
*      PenStyle implemented
      MarkAt has now 14 more symbols
      cross hairs are now accessible as properties CrossHair1...CrossHair4
      cross hairs can now be moved interactively by mouse (MouseAction = maDragCrossH)
      bug fix: CrossHairPosY now returns y value correctly
      DecPlaceX and DecPlaceY extended to a maximum of 12 digits
      RangeLoX, RangeHiX, RangeLoY, and RangeHiY are now of type "extended" for better
          accuracy when zooming into very small regions
      new properties MinRangeX and MinRangeY
      OnCrossHairMove event implemented
      data sharing between several charts implemented (property UseDataOf)
      user-defined text labels implemented (property TextLabels)
      AddTextLabel implemented
      OnTextLabelMove event implemented
      bug fix: ftDateTime can now handle dates before 1900 correctly
      FtTime displays now down to milliseconds
      resolution problems with labeling of axes resolved
      RemoveItemByClass implemented
      runtime version does no longer contain property editor

5.5   [May-01, 2000]
      available for C++Builder 5.0
      published property Anchors and Contraints
      bug fix: the mouse cursor is reset to its default image when leaving the chart
      ClearZoomHistory implemented
      bug fix: zoom by mouse, SetRange and AutoRange is now handled correctly if property IsoMetric is true
      shadow of text labels implemented (properties TextLabels[].Mode, TextLabels[].ShadowDx, TextLabels[].ShadowDy, and TextLabels[].ColorShadow)
      multiline labels implemented
      MoveToRelPix and DrawToRelPix implemented
      bug fix: properties MousePosX, MousePosY, CrossHair1..4, IdAbscissa, IdOrdinate,
                  MinTickX, MinTickY can now also be read by C++ programs
                  (problem was due to a bug in BCB3, 4 & 5, but not in BCB1)

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      bug fix: TextLabels did not display correctly with solid background color
      bug fix: AddTextLabel now accepts parameters PosX, PosY as floating point values
      new properties XAxisPos and YAxisPos implemented
      property ClassicLayout implemented
      bug fix: Y-axis using the ftTime format is draw correctly for inverted scales (RangeLoY > RangeHiY)
      bug fix: inverted numeric scales now draw the top most scale tick correctly (occurred in rare circumstances)
      bug fix: memory for text labels fonts is now correctly allocated
      MouseBox now works more intuitively (left mouse button has to be kept pressed while drawing the mouse box)
      bug fix: FindNearestItemScreen does not create "integer overflow" error when zoomed in by a large factor
      MouseBoxAbort implemented
      bug fix: property editor form for BackgroundImg is now declared in interface section
      OnDataRendered and OnScalesRendered events implemented
      OnScaleTickDrawn Event implemented
      bug fix: zoom box now follows the correctly if MouseAction is maZoomWind and Isometric is TRUE
}

{-$DEFINE DEBUG}
{ This switch is used for debugging purposes only. Do NOT activate it.
  When active, any chart creates a log file of its own activities. The name of
  the log file is RCDEBUG_XXXX.TXT, where XXXX is the name of the chart }

{-$DEFINE SHAREWARE}
{ If this switch is turned on, the 'hint'-property is set during startup
  in order to indicate an unregistered shareware version. In addition, an
  indication of the shareware status is given in the chart area if the
  Delphi IDE is not up and running }

{$IFNDEF SDLBATCH}
{$IFDEF VER110}
{$OBJEXPORTALL On}                      { this switch is necessary for C++Builder 3.0 }
{$ENDIF}
{$IFDEF VER125}
{$OBJEXPORTALL On}                      { this switch is necessary for C++Builder 4.0 }
{$ENDIF}
{$IFDEF VER135}
{$OBJEXPORTALL On}                      { this switch is necessary for C++Builder 5.0 }
{$ENDIF}
{$ENDIF}

{------------------------------------------------------------------------------}
Interface
{------------------------------------------------------------------------------}


Uses
  WinTypes, WinProcs, Messages, Classes, graphics, controls,
  Forms, Menus;

Const
  defLRim           = 50;               { default left rim in component CHART }
  defRRim           = 10;               { default right rim in component CHART }
  defTRim           = 16;               { default top rim in component CHART }
  defBRim           = 32;               { default bottom rim in component CHART }
  defShadowWidth    = 0;                { default width of shadow }
  defPenStyle       = psSolid;          { default pen style }
  defDataCol        = clblack;          { default data color }
  defScaleCol       = clBlack;          { default scale color }
  defFillCol        = clSilver;         { default fill color }
  defChartCol       = clWhite;          { default chart background color }
  defWindCol        = clBtnFace;        { default window background color }
  defGridCol        = clBlack;          { default grid color }
  defLineWid        = 1;                { default line width }
  defRCHeight       = 160;
  defRCWidth        = 240;
  defBndLoX         : extended = 0.0;   { default boundaries of scaled area }
  defBndLoY         : extended = 0.0;
  defBndHiX         : extended = 10.0;
  defBndHiY         : extended = 10.0;
  defDecPlcX        = 1;                { nr. of dec. places on x-axes }
  defDecPlcY        = 1;                { nr. of dec. places on y-axes }
  defNXTick         = 3;                { number of ticks on x axis }
  defNYTick         = 3;                { number of ticks on y axis }
  MaxRCMarks        = 25;               { number of available mark symbols }
  MinRCWidth        = 50;               { minimum width of RChart control }
  MinRCHeight       = 10;               { minimum height of RChart control }

  MaxTickPos        = 150;              { maximum number of synchronized grid lines }
  MaxZoomStack      = 8;                { depth of zoom stack }
  MaxCrossH         = 4;                { number of crosshairs }
  MaxTxtLbl         = 20;               { number of text labels }
  MaxDataUsers      = 4;                { maximum number of data shares }
  RcMaxDouble       : extended = 1.7E308;

Type
  YearLengthType = (ylNone, ylYY, ylYYYY);
  DateOrderType = (doMMDDYY, doDDMMYY, doYYMMDD);
  TimeFormatType = (tfHMMSS, tfHHMMSS, tfHHhMM, tfAMPM);
  TCrossHMode = (chOff, chHoriz, chVert, chBoth); { kind of cross hair }
  TTxtLblMode = (tlOff, tlsimple, tlBox, tlUnderline, tlShadow); { kind of text label }
  DateForTimeType = (dtNone, dtOnePerChart, dtOnePerDay, dtAllTicks);
  TBkgFill = (bfSimple, bfStretch, bfTile);
  TBakGndImg = Class(TPersistent)       { background bitmap }
  private
    FName : String;                     { name of bitmap file to load }
    FOnChange : TNotifyEvent;
    FIncldPath : boolean;               { if TRUE, include path info }
    FFillMode : TBkgFill;               { fill of background image }
    Procedure SetName(fn : String);
    Procedure SetIncldPath(x : boolean);
    Procedure SetFillMode(x : TBkgFill);
  protected
  public
    Constructor Create(AOwner : TComponent);
    Destructor Destroy; override;
    Procedure Changed;
    Property OnChange : TNotifyEvent read FOnChange write FOnChange;
  published
    Property Name : String read FName write SetName;
    Property IncludePath : boolean read FIncldPath write SetIncldPath;
    Property FillMode : TBkgFill read FFillMode write SetFillMode;
  End;


  TCrossHair = Class(TPersistent)
  private
    FPosX : double;                     { crosshair x position }
    FPosY : double;                     { crosshair Y position }
    FColor : TColor;                    { color of crosshair }
    FMode : TCrossHMode;                { mode of crosshair }
    FLineType : TPenStyle;              { type of crosshair line }
    FLineWid : integer;                 { width of crosshair line }
    FOnChange : TNotifyEvent;
    FNum : Integer;
    Procedure SetCrossHPosX(value : double);
    Procedure SetCrossHPosY(value : double);
    Procedure SetCrossHColor(value : TColor);
    Procedure SetCrossHMode(value : TCrossHMode);
    Procedure SetCrossHLineType(value : TPenStyle);
    Procedure SetCrossHLineWid(value : integer);
  public
    Procedure Changed;
  published
    Property PosX : double read FPosX write SetCrossHPosX;
    Property PosY : double read FPosY write SetCrossHPosY;
    Property Color : TColor read FColor write SetCRossHColor;
    Property Mode : TCrossHMode read FMode write SetCrossHMode;
    Property Num : Integer read FNum;
    Property LineType : TPenStyle read FLineType write SetCrossHLineType;
    Property LineWid : integer read FLineWid write SetCrossHLineWid;
    Property OnChange : TNotifyEvent read FOnChange write FOnChange;
  End;

  TTextLabel = Class(TPersistent)
  private
    FPosX : double;                     { crosshair x position }
    FPosY : double;                     { crosshair Y position }
    FXShadow : integer;                 { dx of label shadow }
    FYShadow : integer;                 { dy of label shadow }
    FColorShadow : TColor;              { color of shadow }
    FAlignment : TAlignment;            { alignment of label }
    FAttachDat : boolean;               { determines whether position is attached to screen or data }
    FColorBkg : TColor;                 { color of background }
    FColorBrd : TColor;                 { color of border line }
    FTransPar : boolean;                { TRUE: box is transparent }
    FFont : TFont;                      { text font }
    FCaption : String;                  { text of label }
    FMode : TTxtLblMode;                { display mode of text label }
    FOnChange : TNotifyEvent;
    Procedure SetTxtLblAlignment(al : TAlignment);
    Procedure SetTxtLblPosX(value : double);
    Function GetTxtLblPosX : double;
    Procedure SetTxtLblPosY(value : double);
    Procedure SetTxtLblColorBkg(value : TColor);
    Procedure SetTxtLblColorBrd(value : TColor);
    Procedure SetTxtLblColorShadow(value : TColor);
    Procedure SetTxtLblTranspar(value : boolean);
    Procedure SetTxtLblMode(value : TTxtLblMode);
    Procedure SetTxtLblFont(value : TFont);
    Procedure SetTxtLblCaption(value : String);
    Procedure SetTxtLblScreenPos(value : boolean);
    Procedure SetTxtLblShadowDx(value : integer);
    Procedure SetTxtLblShadowDy(value : integer);
  public
    Procedure Changed;
  published
    Property PosX : double read GetTxtLblPosX write SetTxtLblPosX;
    Property PosY : double read FPosY write SetTxtLblPosY;
    Property AttachToData : boolean read FAttachDat write SetTxtLblScreenPos;
    Property ColorBkg : TColor read FColorBkg write SetTxtLblColorBkg;
    Property ColorBorder : TColor read FColorBrd write SetTxtLblColorBrd;
    Property ColorShadow : TColor read FColorShadow write SetTxtLblColorShadow;
    Property ShadowDx : integer read FXShadow write SetTxtLblShadowDx;
    Property ShadowDy : integer read FYShadow write SetTxtLblShadowDy;
    Property Transparent : boolean read FTransPar write SetTxtLblTransPar;
    Property Alignment : TAlignment read FAlignment write SetTxtLblAlignment;
    Property Font : TFont read FFont write SetTxtLblFont;
    Property Mode : TTxtLblMode read FMode write SetTxtLblMode;
    Property Caption : String read FCaption write SetTxtLblCaption;
    Property OnChange : TNotifyEvent read FOnChange write FOnChange;
  End;


  TDTLabel = Class(TPersistent)         { parameters of DateTime labels }
  private
    FTimeFormat : TimeFormatType;
    FDateSeparator : char;
    FTimeSeparator : char;
    FYearLength : YearLengthType;
    FMonthName : boolean;
    FDateOrder : DateOrderType;
    FDateForTime : DateForTimeType;
    FOnChange : TNotifyEvent;
    Procedure SetTimeFormat(Value : TimeFormatType);
    Procedure SetDateForTime(value : DateForTimeType);
    Procedure SetDateSeparator(Value : char);
    Procedure SetTimeSeparator(Value : char);
    Procedure SetYearLength(value : YearLengthType);
    Procedure SetMonthName(value : boolean);
    Procedure SetDAteOrder(value : DateOrderType);
  protected
  public
    Procedure Changed;
  published
    Property TimeFormat : TimeFormatType read FTimeFormat write SetTimeFormat;
    Property DateSeparator : char read FDateSeparator write SetDateSeparator;
    Property TimeSeparator : char read FTimeSeparator write SetTimeSeparator;
    Property YearLength : YearLengthType read FYearLength write SetYearLength;
    Property MonthName : boolean read FMonthName write SetMonthName;
    Property DateOrder : DateOrderType read FDateOrder write SetDateOrder;
    Property DateForTime : DateForTimeType read FDateForTime write SetDateForTime;
    Property OnChange : TNotifyEvent read FOnChange write FOnChange;
  End;

  TRFrameStyle = (rbLowered, rbRaised, rbEmbossed, rbEngraved);

  ItemType = (tkNone, tkMarkAt, tkLine, tkLineto, tkRect, tkRectFrame,
    tk3DBar, tkText, tkMoveTo, tkEllipse, tkEverything,
    tkNotMoveTo, tkMoveRelPix, tkLineRelPix);
                             { Attention: if the Itemtype is changed, the array
                               FItemCount should also be adjusted }
  PDrawCan = ^TDrawCan;
  TDrawCan = Record
    Next : PDrawCan;                    { pointer to next Item }
    Prev : PDrawCan;                    { pointer to previous item }
    x, y : double;                      { coordinates of Item }
    color : TColor;                     { color of Item }
    penstyle : TPenStyle;               { pen style used for this item }
    tag : longint;                      { user defined tag }
    lwid : byte;                        { line width }
    ItemClass : byte;                   { class number of Item }
    Case Element : ItemType Of
      tkLine,                           { line }
        tkRect : (x2, y2 : double;      { rectangle }
        fillcol1 : TColor;
        transp1 : boolean);
      tkRectFrame : (x4, y4 : double;   { rectangular frame }
        fillcol2 : TColor;
        framest : TRFrameStyle;
        shadowcol : TColor;
        hilightcol : TColor);
      tkEllipse : (ha, hv : double;     { ellipse }
        fillcol3 : TColor;
        transp2 : boolean);
      tk3DBar : (x3, y3 : double;       { 3D bar }
        fillcol4 : TCOlor;
        depth : integer;
        angle : integer);
      tkText : (txt : String[15];       { text }
        size : integer);
      tkMarkAt : (mark : byte);         { mark }
  End;

  FigType = (ftNoFigs, ftNum, ftTime, ftNoScales, ftDateTime, ftUserText);

  GridStyleType = (gsNone, gsPoints, gsVertLines, gsHorizLines, gsLines,
    gsHorizDotLines, gsVertDotLines, gsDotLines);
  TShadowStyle = (ssFlying, ssBox);
  TTextBkg = (tbClear, tbSolid);
  LabelStr = String[50];
  InscriptStr = String[15];
  ZoomStateType = (zsNormal, zsDrawWin);
  MouseBoxStateType = (msNormal, msFirstCorner, msRectDraw, msFinished);
  MouseActMode = (maNone, maPan, maZoomWind, maZoomWindPos, maZoomDrag,
    maPanHoriz, maPanVert, maDragCrossH, maDragLabel);
                                        { event for mouse pos. in chart coords }
  TMouseMoveInChartEvent = Procedure(Sender : TObject; InChart : boolean;
    Shift : TShiftState;
    rMousePosX, rMousePosY : double) Of Object;
  TScaleType = (sctXB, sctXT, sctYL, sctYR); { scale type and position }
  TZoomPanEvent = Procedure(Sender : TObject) Of Object; { event after zoom or pan }
  TScaleTickDrawnEvent = Procedure(Sender : TObject; Var Canvas : TCanvas; ScaleType : TScaleType; CurrentTickPos : double; ChartX, ChartY : integer) Of Object;
  TRenderEvent = Procedure(Sender : TObject; Var Canvas : TCanvas; Top, Left : integer) Of Object;
  TCrossHairMoveEvent = Procedure(Sender : TObject; WhichCrossHair : TCrossHair) Of Object;
  TTextLabelMoveEvent = Procedure(Sender : TObject; WhichTextLabel : TTextLabel) Of Object;
  TXaxPos = (xapTop, xapBottom, xapBoth);
  TYaxPos = (yapLeft, yapRight, yapBoth);

  TRChart = Class(TGraphicControl)
  private
{$IFDEF DEBUG}
    StartSystime : double;
    DebugFile : TextFile;
{$ENDIF}
    LButtonWasDown : boolean; { global identifier to track panning
                                                           by left mouse button }
    MouseAnchorScrX : integer;          { anchor mouse pos. on TRChart canvas }
    MouseAnchorScrY : integer;
    MouseAnchorRcLoX : double;
    MouseAnchorRcLoY : double;
    MouseAnchorRcHiX : double;
    MouseAnchorRcHiY : double;

    FZoomState : ZoomStateType;
    MouseBoxState : MouseBoxStateType;
    LastMouseX : integer;
    LastMouseY : integer;
    MouseBoxX1 : integer;
    MouseBoxX2 : integer;
    MouseBoxY1 : integer;
    MouseBoxY2 : integer;
    WindAnchorX : integer;
    WindAnchorY : integer;
    WindOldCornerX : integer;
    WindOldCornerY : integer;
    FUseDataOf : TRChart;               { assigned shared data chart }
    FDataUsers : Array[1..MaxDataUsers] Of TRChart;
    FDataUsersNum : integer;
    FXTickPosCnt : integer;             { tick positions - count }
    FYTickPosCnt : integer;
    FXScaleTickPos : Array[1..MaxTickPos] Of double; {tick positions}
    FYScaleTickPos : Array[1..MaxTickPos] Of double;
    FItClassVisib : Array[0..255] Of boolean; { visibility of item classes }
    FOnMMvInChart : TMouseMoveInChartEvent;
    FOnZoomPan : TZoomPanEvent;
    FOnScaleTickDrawn : TScaleTickDrawnEvent;
    FOnDataRendered : TRenderEvent;
    FOnScalesRendered : TRenderEvent;
    FOnCrossHMove : TCrossHairMoveEvent;
    FOnTxtLblMove : TTextLabelMoveEvent;
    AuxBmp : TBitMap;                   { bitmap to hold background picture }
    AuxCHBmp : TBitMap;                 { bitmap to create cross hairs }
    GrafBmp : TBitmap;                  { off-screen graphics bitmap }
    ChartBmp : TBitmap;                 { off-screen chart bitmap }
    FBakGndFile : TBakGndImg;           { background file }
    FDataTag : longint;                 { user defined tag }
    RcGridStyle : GridStyleType;        { style of grid }
    RcGridCol : TColor;                 { color of grid }
    RcGridDx : double;                  { x-distance of grid points }
    RcGridDy : double;                  { y-distance of grid points }
    RcLRim : integer;                   { left rim }
    RcRRim : integer;                   { right rim }
    RcTRim : integer;                   { top rim }
    RcBRim : integer;                   { bottom rim }
    Rc3DRim : integer;                  { width of shadow }
    RcShadowStyle : TShadowStyle;       { style of shadow }
    RcShadowColor : TColor;             { color of shadow }
    RcShadowBakCol : TColor;            { color of shadow background }
    RcShortTicksX : boolean;            { display short ticks on abscissa ? }
    RcShortTicksY : boolean;            { display short ticks on ordinate ? }
    RcXLog : boolean;                   { TRUE: logarithmic x-axis }
    RcYLog : boolean;                   { TRUE: logarithmic y-axis }
    RcMouseAction : MouseActMode;       { type of allowed mouse action }
    RcDataCol : TColor;                 { color of data }
    RcScaleCol : TColor;                { color of scales }
    RcFillCol : TColor;                 { fill color of rect/ellipse }
    RcChartCol : TColor;                { color of chart background }
    RcPenStyle : TPenStyle;             { pen style of drawing }
    RcWindCol : TColor;                 { color of window background }
    RcLineWid : byte;                   { line width of tkLine and tkLineTo }
    TitStr : String;                    { caption of chart }
    RcScaleInscrX : InscriptStr;        { string for scale inscription }
    RcScaleInscrY : InscriptStr;        { string for scale inscription }
    RcBndLoX : extended;                { boundaries of scaled area }
    RcBndLoY : extended;
    RcBndHiX : extended;
    RcBndHiY : extended;
    RcClassDefault : byte;              { default class number for new items }
    RcDecPlcX : integer;                { nr. of dec. places on x-axes }
    RcDecPlcY : integer;                { nr. of dec. places on y-axes }
    Cpkx, Cpdx : extended;              { params for scaling on x-axis }
    Cpky, Cpdy : extended;              { params for scaling on y-axis }
    RcXUnits : LabelStr;                { unit identif. on abscissa }
    RcYUnits : LabelStr;                { unit identif. on ordinate }
    RcXNtick : integer;                 { number of ticks on x-axis }
    RcYNtick : integer;                 { number of ticks on x-axis }
    RcXLabelType : FigType;             { type of labeling }
    RcYLabelType : FigType;             { type of labeling }
    FClassicLayout : boolean;           { TRUE: caption and unit labels are at classic positions }
    FXAxPos : TXaxPos;                  { position of abscissa labeling }
    FYAxPos : TYaxPos;                  { position of ordinate labeling }
    FUserTickTextX : String;            { user defined labeling of x axis }
    FUserTickTextY : String;            { user defined labeling of y axis }
    FMousePosX : double;                { mouse x position - real coords }
    FMousePosY : double;                { mouse y position - real coords }
    FDTXFormat : TDTLabel;              { format of date/time labels }
    FDTYFormat : TDTLabel;
    FMCurFixed : boolean;               { TRUE: fixed mouse cursor }
    FCrossHair : Array[1..MaxCrossH] Of TCrossHair; {cross hairs }
    FTextLabels : Array[1..MaxTxtLbl] Of TTextLabel; {text labels }
    CHNext : integer;                   { index of crosshair which is picked by mouse }
    TLNext : integer;                   { index of text label which is picked by mouse }
    FAutoRedraw : boolean;              {TRUE: automatic redraw on any change }
    FNumPPa : longint;                  { number of polyline segments }
    FTextFontStyle : TFontStyles;       { font style of text labels }
    FTextBkStyle : TTextBkg;            { background style of text labels }
    FTextBkColor : TColor;              { background color of text labels }
    FTextAlignment : TAlignment;        { aligmnent of text }
    Fxasp, Fyasp : integer;             { pixel widths of canvas }
    FIsometric : boolean;               { TRUE: scales are isometric }
    FTranspItems : boolean;             {TRUE: transparent ellipse & rectangle }
    FZoomStack : Array[1..MaxZoomStack, 1..4] Of extended; { circ. zoom stack }
    FZStackPoi : integer;               { zoom stack pointer }
    FZoomRange : Array[1..4] Of extended; { confined zoom range }
    FMinRngDiffX : double;              { minimum range of x axis }
    FMinRngDiffY : double;              { minimum range of x axis }
    FYarMashTab : double;
    Function AddScaleInscription(Instring : String; Inscr : InscriptStr) : String;
    Procedure AdjustCanInfoOfSharedCharts;
    Procedure AdjustScaling; virtual;
    Procedure ConstructChartBmp(cv : TCanvas);
    Procedure ConstructDataBmp(cv : TCanvas; PosX, PosY : integer; BlkWhite : boolean; FirstItem : PDrawCan);
    Procedure CopyToWMF(FName : String);
    Procedure DrawFinish(xPos, yPos : integer; SrcBmp : TBitMap);
    Function ExtractUserText(TickText : String; ix : integer) : String;
    Procedure ForceRange(xLo, yLo, xHi, yHi : extended; EnterToZoomStack : boolean; ConfineRange : boolean);
    Function GetTypeOfFirstItem : ItemType;
    Function GetTypeOfLastItem : ItemType;
    Function GetFirstItemLL : PDrawCan;
    Function GetLastItemLL : PDrawCan;
    Function GetClassVisib(cnum : byte) : boolean;
    Function GetCHPosX(chnum : integer) : double;
    Function GetCHPosY(chnum : integer) : double;
    Function GetCrossHair1 : TCrossHair;
    Function GetCrossHair2 : TCrossHair;
    Function GetCrossHair3 : TCrossHair;
    Function GetCrossHair4 : TCrossHair;
    Function GetItemCount(it : Itemtype) : longint;
    Function GetFTextLabel(ix : integer) : TTextLabel;
    Function GetTickPosX(ix : integer) : double;
    Function GetTickPosY(iy : integer) : double;
    Function GetMousePosX : double;
    Function GetMousePosY : double;
    Function GetXNTick : integer;
    Function GetYNTick : integer;
    Function GetXUnits : LabelStr;
    Function GetYUnits : LabelStr;

    Procedure SetYarMashTab(M : double);

    Procedure InitGraf(cv : TCanvas; PosX, PosY : integer);
    Procedure LLCalcExtents(np : PDrawCan; Rim : double; Var xLo, yLo, xHi, yHi : double);
    Procedure SetClassVisib(cnum : byte; value : boolean);
    Procedure SetCHPosX(chnum : integer; value : double);
    Procedure SetCHPosY(chnum : integer; value : double);
    Procedure SetLRim(r : integer);
    Procedure SetRRim(r : integer);
    Procedure SetTRim(r : INTEGER);
    Procedure SetBRim(r : integer);
    Procedure SetIsoMetric(im : boolean);
    Procedure SetUseDataOf(orc : TRChart);
    Procedure SetRc3DRim(r : integer);
    Procedure SetDataTag(tag : longint);
    Procedure SetShadowStyle(ss : TShadowStyle);
    Procedure SetShadowColor(c : TColor);
    Procedure SetShadowBakColor(c : TColor);
    Procedure SetClassDefault(DefClass : byte);
    Procedure SetCrossHair1(x : TCrossHair);
    Procedure SetCrossHair2(x : TCrossHair);
    Procedure SetCrossHair3(x : TCrossHair);
    Procedure SetCrossHair4(x : TCrossHair);
    Procedure SetDecPlcX(d : integer);
    Procedure SetDecPlcY(d : integer);
    Procedure SetGridStyle(gs : GridStyleType);
    Procedure SetGridDx(dx : double);
    Procedure SetGridDy(dy : double);
    Procedure SetDataCol(c : TColor);
    Procedure SetScaleCol(c : TColor);
    Procedure SetFillCol(c : TColor);
    Procedure SetChartCol(c : TColor);
    Procedure SetWindCol(c : TColor);
    Procedure SetGridCol(c : TColor);
    Procedure SetTitStr(hstr : String);
    Procedure SetPenStyle(ps : TPenStyle);
    Procedure SetLineWid(w : byte);
    Procedure SetXUnits(hstr : LabelStr);
    Procedure SetYUnits(hstr : LabelStr);
    Procedure SetShortTicksX(st : boolean);
    Procedure SetShortTicksY(st : boolean);
    Procedure SetRcXLog(XLog : boolean);
    Procedure SetRcYLog(YLog : boolean);
    Procedure SetBndLoX(r : extended);
    Procedure SetBndHiX(r : extended);
    Procedure SetBndLoY(r : extended);
    Procedure SetBndHiY(r : extended);
    Procedure SetDTXFormat(x : TDTLabel);
    Procedure SetDTYFormat(x : TDTLabel);
    Procedure SetLayout(x : boolean);
    Procedure SetMinRngX(r : double);
    Procedure SetMinRngY(r : double);
    Procedure WMMouseMoveInChart(Var Message : TWMMouse); message WM_MOUSEMOVE;
    Procedure CMMouseLeave(Var msg : TMessage); message CM_MOUSELeave;
    Procedure SetXNTick(d : integer);
    Procedure SetYNTick(d : integer);
    Procedure SetTextFontStyle(tfs : TFontStyles);
    Procedure SetTextBkStyle(bs : TTextBkg);
    Procedure SetTextBkColor(bc : TColor);
    Procedure SetTextAlignment(al : TAlignment);
    Procedure SetFTextLabel(ix : integer; value : TTextLabel);
    Procedure SetXAxPos(x : TXaxPos);
    Procedure SetXLabType(x : FigType);
    Procedure SetYAxPos(x : TYaxPos);
    Procedure SetYLabType(x : FigType);
    Procedure SetUserTickTextX(txt : String);
    Procedure SetUserTickTextY(txt : String);
    Procedure SetScaleInscrX(x : InscriptStr);
    Procedure SetScaleInscrY(x : InscriptStr);
    Procedure SetBakGndFile(x : TBakGndImg);
    Procedure ZoomStateOnStack;
    Procedure ShowYaxInternal(cv : TCanvas; XPos : integer; LowRange, HighRange : extended;
      NTicks, DecPlaces : integer; LabelType : FigType; LogAx : boolean;
      ScaleInscript : InscriptStr; UserTicktext : String;
      UnitLabel : LabelStr; StoreTickPos : boolean; OrientationLeft : boolean;
      LblPosX, LblPosY : integer; Mashtab : extended);
  protected
    RcFrstCan : PDrawCan;               { buffer of drawing elements }
    RcLastCan : PDrawCan;               { pointer to last drw. can }
    RcLastCanOnShow : PDrawCan;         { pointer to last entry when ShowGraf is called }
    FItemCount : Array[tkNone..tkLineRelPix] Of longint; { element count }
    Procedure Paint; override;
    Procedure Loaded; override;
    Procedure MouseMove(Shift : TShiftState; X, Y : integer); override;
    Procedure MouseMoveInChart(InChart : boolean; Shift : TShiftState;
      RMousePosX, RMousePosY : double);
    Procedure MouseDown(Button : TMouseButton;
      Shift : TShiftState; X, Y : Integer); override;
    Procedure MouseUp(Button : TMouseButton;
      Shift : TShiftState; X, Y : Integer); override;
    Procedure StyleChanged(Sender : TObject);
    Procedure DoZoomPanEvent;
    Procedure DoCrossHMoveEvent(WhichCH : TCrossHair);
    Procedure DoTxtLblMoveEvent(WhichTL : TTextLabel);
  public
    GraphList : TList;
    Constructor Create(AOwner : TComponent); override;
    Destructor Destroy; override;
    Procedure M2R(xin, yin : longint; Var xout, yout : double);
    Procedure R2M(xin, yin : double; Var xout, yout : longint);
    Procedure ClearGraf;
    Procedure ConfineZoomRange(xLo, yLo, xHi, yHi : double);
    Procedure ShowGraf;
    Procedure ShowGrafNewOnly;
    Procedure SetBounds(ALeft, ATop, AWidth, AHeight : Integer); override;
    Function MouseBox(Var xLo, yLo, xHi, yHi : double) : boolean;
    Procedure MouseBoxAbort;
                                                           { draw }
    Function AddTextLabel(PosX, PosY : double; TxtColor : TColor;
      Txt : String; PropertyTemplate : integer) : integer;
    Procedure Bar3D(llx, lly, urx, ury : double;
      Depth : integer; Angle : integer);
    Procedure ClearZoomHistory;
    Procedure CopyToBitmap(ABitmap : TBitmap; BlkWhite : boolean);
    Procedure CopyToBMP(FName : String; BlkWhite : boolean);
    Procedure CopyToClipboard(BlkWhite : boolean);
    Procedure CopyToOpenPrinter(Var x, y : integer; ScaleF : double; BlkWhite : boolean);
    Procedure CopyToOpenPrinterHiRes(Var x, y : integer; ScaleF : double; BlkWhite : boolean);
    Property CrossHairPosX[chnum : integer] : double read GetCHPosX write SetCHPosX;
    Property CrossHairPosY[chnum : integer] : double read GetCHPosY write SetCHPosY;
    Procedure CrossHairSetPos(chnum : integer; x, y : double);
    Procedure CrossHairSetup(ch : integer; chColor : TColor; Mode : TCrossHMode;
      LineType : TPenStyle; LineWidth : integer);
    Property DataTag : longint read FDataTag write SetDataTag;
    Procedure DrawTo(x, y : double);
    Procedure DrawToRelPix(dx, dy : integer);
    Procedure Ellipse(cx, cy, HorizAxLeng, VertAxLeng : double);
    Procedure Line(x1, y1, x2, y2 : double);
    Procedure MoveTo(x, y : double);
    Procedure MoveToRelPix(dx, dy : integer);
    Procedure MarkAt(x, y : double; mk : byte);
    Procedure PrintIt(ScaleF : double; BlkWhite : boolean);
    Procedure PrintItHiRes(ScaleF : double; BlkWhite : boolean);
    Procedure Rectangle(x1, y1, x2, y2 : double);
    Procedure RectFrame(x1, y1, x2, y2 : double; FrameStyle : TRFrameStyle;
      ShadowColor, HiLightColor : TColor);
    Procedure SaveLinkedListASC(FName : String);
    Procedure SaveLinkedList(FName : String);
    Procedure LoadLinkedList(FName : String; AppendIt : boolean);
    Procedure SetRange(xLo, yLo, xHi, yHi : extended);
    Procedure AutoRange(rim : double);
    Procedure Text(x, y : double; size : integer; txt : String);
                                                           { process single item }
    Procedure RemoveLastItem;
    Procedure RemoveFirstItem;
    Procedure RemoveItem(Item : PDrawCan);
    Function RemoveItemsByClass(ClassNumber : byte) : longint;
    Procedure FindMinMax(RangeLoX, RangeLoY, RangeHiX, RangeHiY : double; Var MinX, MinY, MaxX, MaxY : double);
    Function FindNearestItemReal(mx, my : double; ItemID : ItemType;
      ClassNumber : byte; Var Dist : double) : PDrawCan;
    Function FindNearestItemScreen(mx, my : double; ItemID : ItemType;
      ClassNumber : byte; Var Dist : double) : PDrawCan;
    Property FirstItemOfLinkedList : PDrawCan read GetFirstItemLL;
    Property LastItemOfLinkedList : PDrawCan read GetLastItemLL;
    Function GetItemParams(Item : PDrawCan) : TDrawCan;
    Property ItemCount[it : Itemtype] : longint read GetItemCount;
    Procedure SetItemParams(Item : PDrawCan; ItParams : TDrawCan);
    Procedure ScaleItem(Item : PDrawCan; kx, dx, ky, dy : double);
                                                           { process more items }
    Function MarkItemsInWindow(xLo, YLo, XHi, YHi : double; ItemID : ItemType; ClassNumber : byte) : longint;
    Procedure MarkAllItems(ItemID : ItemType; ClassNumber : byte);
    Property MousePosX : double read GetMousePosX;
    Property MousePosY : double read GetMousePosY;
    Property ClassVisible[cnum : byte] : boolean read GetClassVisib write SetClassVisib;
    Procedure ScaleAllItems(kx, dx, ky, dy : double);
    Procedure ScaleSelectedItems(kx, dx, ky, dy : double; ClassNumber : byte);
    Property TransparentItems : boolean read FTranspItems write FTranspItems;
    Property TypeOfLastItem : ItemType read GetTypeOfLastItem;
    Property TypeOfFirstItem : ItemType read GetTypeOfFirstItem;
    Procedure NewColorOfClassItems(Newcol : TColor; ClassNumber : byte);
    Property TextLabels[ix : integer] : TTextLabel read GetFTextLabel write SetFTextLabel;
    Property TickPosX[ix : integer] : double read GetTickPosX;
    Property TickPosY[iy : integer] : double read GetTickPosY;
    Property TickNumX : integer read FXTickPosCnt;
    Property TickNumY : integer read FYTickPosCnt;
    Property YarMashtab : double read FYarMashTab write SetYarMashTab;

    Property ZoomState : ZoomStateType read FZoomState;
    Procedure ZoomHistory(Index : integer);

  published
    Property Font;
    Property Align;
    Property Visible;
    Property ShowHint;
    Property PopupMenu;
{$IFNDEF VER110}                        // CBuilder 3.0 does not know about Anchors and Constraints
{$IFNDEF VER100}                        // Delphi 3.0 does not know about Anchors and Constraints
    Property Anchors;
    Property Constraints;
{$ENDIF}
{$ENDIF}
    Property AutoRedraw : boolean read FAutoRedraw write FAutoRedraw;
    Property LRim : integer read RcLrim write SetLRim default DefLRim; { left rim of graphics }
    Property RRim : integer read RcRRim write SetRRim default DefRRim; { right rim of graphics }
    Property TRim : integer read RcTRim write SetTRim default DefTRim; { top rim of graphics }
    Property BRim : integer read RcBRim write SetBRim default DefBRim; { bottom rim of graphics }
    Property BackGroundImg : TBakGndImg read FBakGndFile write SetBakGndFile;
    Property ClassDefault : byte read RcClassDefault write SetClassDefault;
    Property ClassicLayout : boolean read FClassicLayout write SetLayout;
    Property DecPlaceX : integer read RcDecPlcX write SetDecPlcX default defDecPlcX;
    Property DecPlaceY : integer read RcDecPlcY write SetDecPlcY default defDecPlcY;
    Property GridStyle : GridStyleType read RcGridStyle write SetGridStyle; { style of grid }
    Property GridDx : double read RcGridDx write SetGridDx; { x-distance of grid points }
    Property GridDy : double read RcGridDy write SetGridDy; { y-distance of grid points }
    Property Isometric : boolean read FIsoMetric write SetIsoMetric;
    Property RangeLoX : extended read RcBndLoX write SetBndLoX; { left boundary of scaled area }
    Property RangeHiX : extended read RcBndHiX write SetBndHiX; { right boundary of scaled area }
    Property RangeLoY : extended read RcBndLoY write SetBndLoY; { lower boundary of scaled area }
    Property RangeHiY : extended read RcBndHiY write SetBndHiY; { upper boundary of scaled area }
    Property DataColor : TColor read RcDataCol write SetDataCol default DefDataCol;
    Property PenStyle : TPenStyle read RcPenStyle write SetPenStyle default DefPenStyle;
    Property ScaleColor : TColor read RcScaleCol write SetScaleCol default DefScaleCol;
    Property FillColor : TColor read RcFillCol write SetFillCol default DefFillCol;
    Property ChartColor : TColor read RcChartCol write SetChartCol default DefChartCol;
    Property WindColor : TColor read RcWindCol write SetWindCol default DefWindCol;
    Property GridColor : TColor read RcGridCol write SetGridCol default DefGridCol;
    Property LineWidth : byte read RcLineWid write SetLineWid default DefLineWid;
    Property Caption : String read TitStr write SetTitStr;
    Property CrossHair1 : TCrossHair read GetCrossHair1 write SetCrossHair1;
    Property CrossHair2 : TCrossHair read GetCrossHair2 write SetCrossHair2;
    Property CrossHair3 : TCrossHair read GetCrossHair3 write SetCrossHair3;
    Property CrossHair4 : TCrossHair read GetCrossHair4 write SetCrossHair4;
    Property IdAbscissa : LabelStr read GetXUnits write SetXUnits;
    Property IdOrdinate : LabelStr read GetYUnits write SetYUnits;
    Property ScaleInscriptX : InscriptStr read RcScaleInscrX write SetScaleInscrX;
    Property ScaleInscriptY : InscriptStr read RcScaleInscrY write SetScaleInscrY;
    Property LogScaleX : boolean read RcXLog write SetRcXLog;
    Property LogScaleY : boolean read RcYLog write SetRcYLog;
    Property MinTickX : integer read GetXNTick write SetXNTick default defNXTick;
    Property MinTickY : integer read GetYNTick write SetYNTick default defNYTick;
    Property MinRangeX : double read FMinRngDiffX write SetMinRngX;
    Property MinRangeY : double read FMinRngDiffY write SetMinRngY;
    Property MouseAction : MouseActMode read RcMouseAction write RcMouseAction;
    Property MouseCursorFixed : boolean read FMCurFixed write FMCurFixed;
    Property ShadowWidth : integer read Rc3DRim write SetRc3DRim default DefShadowWidth;
    Property ShadowStyle : TShadowStyle read RcShadowStyle write SetShadowStyle;
    Property ShadowColor : TColor read RcShadowColor write SetShadowColor;
    Property ShadowBakColor : TColor read RcShadowBakCol write SetShadowBakColor;
    Property ShortTicksX : boolean read RcShortTicksX write SetShortTicksX;
    Property ShortTicksY : boolean read RcShortTicksY write SetShortTicksY;
    Property UseDataOf : TRChart read FUseDataOf write SetUseDataOf;
    Property TextFontStyle : TFontStyles read FTextFontStyle write SetTextFontStyle;
    Property TextBkStyle : TTextBkg read FTextBkStyle write SetTextBkStyle;
    Property TextBkColor : TColor read FTextBkColor write SetTextBkColor;
    Property TextAlignment : TAlignment read FTextAlignment write SetTextAlignment;
    Property XAxisPos : TXaxPos read FXaxPos write SetXaxPos;
    Property XLabelType : FigType read RcXLabelType write SetXLabType;
    Property YAxisPos : TYaxPos read FYaxPos write SetYaxPos;
    Property YLabelType : FigType read RcYLabelType write SetYLabType;
    Property UserTickTextX : String read FUserTickTextX write SetUserTickTextX;
    Property UserTickTextY : String read FUserTickTextY write SetUserTickTextY;
    Property DTXFormat : TDTLabel read FDTXFormat write SetDTXFormat;
    Property DTYFormat : TDTLabel read FDTYFormat write SetDTYFormat;
    Property OnClick;
    Property OnDblClick;
    Property OnMouseMove;
    Property OnMouseDown;
    Property OnMouseUp;
    Property OnMouseMoveInChart : TMouseMoveInChartEvent read FOnMMvInChart write FOnMMvInChart;
    Property OnZoomPan : TZoomPanEvent read FOnZoomPan write FOnZoomPan;
    Property OnScaleTickDrawn : TScaleTickDrawnEvent read FOnScaleTickDrawn write FOnScaleTickDrawn;
    Property OnDataRendered : TRenderEvent read FOnDataRendered write FOnDataRendered;
    Property OnScalesRendered : TRenderEvent read FOnScalesRendered write FOnScalesRendered;
    Property OnCrossHairMove : TCrossHairMoveEvent read FOnCrossHMove write FOnCrossHMove;
    Property OnTextLabelMove : TTextLabelMoveEvent read FOnTxtLblMove write FOnTxtLblMove;
{$IFNDEF VER110}                        // CBuilder 3.0 does not know OnCanResize
{$IFNDEF VER100}                        // Delphi 3.0 does not know OnCanResize
    Property OnCanResize;
{$ENDIF}
{$ENDIF}
  End;


Function RCSpecStrf(r : double; FieldWidth, DecP : integer) : String;

{$IFDEF DEVELOPVERS}                    { this is the interface section of }
                     {- $I rchrt2dvi.inc}{ the untested part of RCHART }
{$ENDIF}


{-----------------------------------------------------------------------}
Implementation
{-----------------------------------------------------------------------}

{$R RCHART.RES}

Uses
  sysutils, printers, ClipBrd, Dialogs;

{$IFDEF SHAREWARE}
{$I sharwinc\rchart_ct.inc}
{$I sharwinc\DELFRUN.INC}
{$ENDIF}


{$IFDEF DEVELOPVERS}                    { this is the implementation section of }
                             {- $I rchartdv.inc}{ the untested part of RCHART }
{$ENDIF}


Const
  SmallPosNum       : extended = 1E-100; { lower limit of logarithmic scales }
  ln10              : extended = 2.302585092994045684018;
  lg2               : extended = 0.301029995663981195214;
  lg5               : extended = 0.698970004336018804803;
  QSave             : extended = 0.999999999; { tolerance for axes }

Type
  ShortStr = String;


(**************************************************************************)

Function Max(x1, x2 : double) : double;
(**************************************************************************)

Begin
  If x1 > x2 Then max := x1
  Else max := x2;
End;

(**************************************************************************)

Function Min(x1, x2 : double) : double;
(**************************************************************************)

Begin
  If x1 < x2 Then min := x1
  Else min := x2;
End;


(**************************************************************************)

Function RCSpecStrf(r : double; FieldWidth, DecP : integer) : String;
(**************************************************************************
 ENTRY: r ............ number to convert to string
        FieldWidth ... width of output field
        DecP ......... number of decimal places,
                       if DecP = -1 then exponent is shortened to 2 digits

 EXIT:  function returns a string of number 'r'
 **************************************************************************)

Var
  hstr              : String;
  i                 : integer;

Begin
  If DecP = -1 Then Begin
    str(r : FieldWidth + 2 : DecP, hstr);
    i := 2 + pos('E', hstr);
    If (length(hstr) - i = 3) Then
      If (hstr[i] = '0') And (hstr[i + 1] = '0') Then delete(hstr, i, 2)
      Else Begin
        delete(hstr, i, 2);
        For i := 1 To length(hstr) Do
          hstr[i] := '*';
      End;
  End
  Else str(r : FieldWidth : DecP, hstr);
  RCSpecStrf := hstr;
End;


(******************************************************************)

Function MakeTimeStr(hour, minute, second, msec : word; fmt : byte) : String;
(******************************************************************)

Var
  hstr              : String;
  hstr1             : String;
  AMPM              : char;

Begin
  hstr := '';
  Case Fmt Of
    0 : Begin
        str(hour : 2, hstr);
        If hstr[1] = ' ' Then hstr[1] := '0';
        str(minute : 2, hstr1);
        If hstr1[1] = ' ' Then hstr1[1] := '0';
        hstr := hstr + ':' + hstr1;
        str(second : 2, hstr1);
        If hstr1[1] = ' ' Then hstr1[1] := '0';
        hstr := hstr + ':' + hstr1;
        str(msec, hstr1);
        While length(hstr1) < 3 Do
          hstr1 := '0' + hstr1;
        hstr := hstr + '.' + hstr1;
      End;
    1 : Begin
//        str(hour : 2, hstr);
        str(hour, hstr);
//        If hstr[1] = ' ' Then          hstr[1] := '0';
        str(minute : 2, hstr1);
        If hstr1[1] = ' ' Then hstr1[1] := '0';
        hstr := hstr + ':' + hstr1;
        str(second : 2, hstr1);
        If hstr1[1] = ' ' Then hstr1[1] := '0';
        hstr := hstr + ':' + hstr1;
      End;
    2 : Begin
        str(hour : 2, hstr);
        str(minute : 2, hstr1);
        If hstr1[1] = ' ' Then hstr1[1] := '0';
        hstr := hstr + 'h' + hstr1;
      End;
    3 : Begin
        str(hour : 2, hstr);
        str(minute : 2, hstr1);
        If hstr1[1] = ' ' Then
          hstr1[1] := '0';
        hstr := hstr + 'h' + hstr1 + '''';
        str(second : 2, hstr1);
        If hstr1[1] = ' ' Then
          hstr1[1] := '0';
        hstr := hstr + hstr1 + '"';
      End;
    4 : Begin
        str(hour : 2, hstr);
        If hstr[1] = ' ' Then
          hstr[1] := '0';
        str(minute : 2, hstr1);
        If hstr1[1] = ' ' Then
          hstr1[1] := '0';
        hstr := hstr + ':' + hstr1;
      End;
    5 : Begin
        If hour < 12 Then AMPM := 'a'
        Else AMPM := 'p';
        If hour = 0 Then
          hour := 12;
        If hour > 12 Then
          hour := hour - 12;
        str(hour : 2, hstr);
        str(minute : 2, hstr1);
        If hstr1[1] = ' ' Then
          hstr1[1] := '0';
        hstr := hstr + ':' + hstr1 + AMPM;
      End;
  End;
  MakeTimeStr := hstr;
End;


(******************************************************************)

Procedure CalcScalePars(Ntick : integer;
  LowVal, HighVal : extended;
  Var LowTick, Distance : extended;
  Var Divi : word);
(******************************************************************
ENTRY: ntick ..... number of ticks on scale
       LowVal .... beginning of scaling
       HighVal ... end point of scaling

EXIT:  LowTick ... first Tick on scale
       Distance .. distance of scale ticks
       Divi ...... number of divisions between scaling labels
*******************************************************************)

Var
  a, b              : extended;
  Sign              : integer;

Begin
  If HighVal = LowVal Then Begin
    LowTick := LowVal;
    Distance := 0.0;
    Divi := 1;
  End
  Else Begin
    If HighVal > LowVal Then Sign := 1
    Else Sign := -1;
    a := ln(abs(HighVal - LowVal) / NTick) / ln10;
    b := a - int(a);
    If ((a < 0) And (b <> 0)) Then a := a - 1;
    If (b < 0) Then b := b + 1;
    If b < lg2 Then Begin
      a := int(a);
      divi := 5;
    End;
    If ((b < lg5) And (b >= lg2)) Then Begin
      a := int(a) + lg2;
      divi := 4;
    End;
    If (b >= lg5) Then Begin
      a := int(a) + lg5;
      divi := 5;
    End;
    Distance := Sign * exp(a * ln10);
    LowTick := Distance * (int(LowVal / Distance) - 1);
    While (Sign * (LowVal - LowTick) > 0.001 * abs(Distance)) Do
      LowTick := LowTick + Distance;
  End;
End;



(**************************************************************************)

Procedure ExChange(Var x, y; size : word);
(**************************************************************************
  ENTRY:  x,y ..... any two equally sized variables
          size .... size of these variables
  EXIT:   x and y are exchanged
 **************************************************************************)

Type
  ByteArray = Array[1..MaxInt] Of byte;

Var
  i                 : integer;
  b                 : byte;

Begin
  For i := 1 To size Do Begin
    b := byteArray(x)[i];
    ByteArray(x)[i] := ByteArray(y)[i];
    byteArray(y)[i] := b;
  End;
End;



(******************************************************************)

Function CalcM(DecPlaces : integer; lo, hi : extended) : integer;
(******************************************************************
ENTRY: lo ........ low value
       hi ........ high value

EXIT:  CalcM returns the number of decimal places needed for a
       sufficiently precise labeling of the indicated range.
*******************************************************************)

Var
  h                 : extended;

Begin
  If (DecPlaces = -2) Or (DecPlaces = -3) { -3 has no effect with lin. scales } Then Begin
    h := abs(Hi - Lo);
    If (h >= 1E6) Or (h <= 1E-4) Then CalcM := -1
    Else If h >= 100 Then CalcM := 0
    Else CalcM := 2 - round(ln(abs(Hi - Lo)) / 2.5);
  End
  Else CalcM := DecPlaces;
End;


(******************************************************************)

Function CalcLogM(DecPlaces : integer; lo, hi : extended) : integer;
(******************************************************************
ENTRY: lo ........ low value
       hi ........ high value

EXIT:  CalcLogM returns the number of decimal places needed for a
       sufficiently precise labeling of the indicated range.

REMARK: This function is designed for logarithmic scales
*******************************************************************)



Var
  h                 : extended;

Begin
  If DecPlaces = -2 Then Begin
    If Hi < Lo Then
      Exchange(Hi, Lo, sizeof(Lo));
    h := Hi - Lo;
    If (h >= 1E6) Or (h <= 1E-4) Then CalcLogM := -1
    Else If Lo >= 1 Then CalcLogM := 0
    Else CalcLogM := 1 - round(ln(abs(Lo)) / ln10);
  End
  Else CalcLogM := DecPlaces;
End;


(******************************************************************)

Function IntPos(InNum : double) : longint;
(******************************************************************
  ENTRY:  InNum ...... number to process

  EXIT:   function returns next integer value which is greater or
          equal to 'InNum'
*******************************************************************)

Var
  aux               : longint;

Begin
  aux := round(InNum);
  If aux < InNum Then
    inc(aux);
  IntPos := aux;
End;


(******************************************************************)

Function IntNeg(InNum : double) : longint;
(******************************************************************
  ENTRY:  InNum ...... number to process

  EXIT:   function returns next integer value which is smaller or
          equal to 'InNum'
*******************************************************************)

Var
  aux               : longint;

Begin
  aux := round(InNum);
  If aux > InNum Then
    dec(aux);
  IntNeg := aux;
End;


(***********************************************************************)

Function FormatDateTimeSDL(fmt : String; DT : TDateTime) : String;
(***********************************************************************
 this routine has been written to cope with a bug in Delphi's FormatDateTime
 function: negative fractional values are formatted wrongly !!
 ***********************************************************************)

Const
  SmallNum          = 1E-8;

Begin
  If abs(DT) < SmallNum Then
    DT := 0;
  If (DT < 0) Then Begin
    If frac(dt) > -SmallNum Then DT := intNeg(Dt) - frac(dt)
    Else DT := intNeg(Dt) - frac(dt) - 1;
  End;
  FormatDateTimeSDL := FormatDateTime(fmt, DT);
End;



(***********************************************************************)

Procedure LimitToINteger(Var x1, x2 : longint);
(***********************************************************************)

Const
  MinInt16          = -30000;           { this has left some space for RcLrim, RcTrim, etc. }
  MaxInt16          = 30000;

Begin
  If x1 < MinInt16 Then
    x1 := MinInt16;
  If x2 < MinInt16 Then
    x2 := MinInt16;
  If x1 > MaxInt16 Then
    x1 := MaxInt16;
  If x2 > MaxInt16 Then
    x2 := MaxInt16;
End;



(******************************************************************)

Function FormatDateStr(DT : TDateTime; MonthName : boolean;
  YearLength : YearLengthType;
  DateOrder : DateOrderType;
  DateSeparator : char) : String;
(******************************************************************)

Var
  astr              : String;
  MonthString       : String[5];
  YearString        : String[5];

Begin
  If MonthName Then MonthString := 'mmm'
  Else MonthString := 'mm';
  Case YearLength Of
    ylNone : YearString := '';
    ylYYYY : YearString := 'yyyy';
    ylYY : YearSTring := 'yy';
  End;
  Case DateOrder Of
    doDDMMYY : Begin
        If YearString = '' Then astr := FormatDateTimeSDL('dd"' + DateSeparator + '"' +
            MonthString, DT)
        Else astr := FormatDateTimeSDL('dd"' + DateSeparator + '"' +
            MonthString + '"' + DateSeparator +
            '"' + YearString, DT);
      End;
    doMMDDYY : Begin
        If YearString = '' Then astr := FormatDateTimeSDL(MonthString + '"' + DateSeparator +
            '"dd', DT)
        Else astr := FormatDateTimeSDL(MonthString + '"' + DateSeparator +
            '"dd"' + DateSeparator +
            '"' + YearString, DT);
      End;
    doYYMMDD : Begin
        If YearString = '' Then astr := FormatDateTimeSDL(MonthString + '"' +
            DateSeparator + '"dd', DT)
        Else astr := FormatDateTimeSDL(YearString + '"' + DateSeparator +
            '"' + MonthString + '"' +
            DateSeparator + '"dd', DT);
      End;
  End;
  FormatDateStr := astr;
End;



(******************************************************************)

Function TimeString(Time : double; Showmsec : boolean) : String;
(******************************************************************)

Var
  hours             : longint;
  minutes           : longint;
  seconds           : longint;
  sec1000           : longint;
  Sign              : char;

Begin
  Sign := ' ';
  If time < 0 Then Begin
    time := abs(time);
    Sign := '-';
  End;
  hours := trunc(time / 3600);
  minutes := trunc((time - 3600.0 * hours) / 60);
  seconds := trunc(time - 3600.0 * hours - minutes * 60);
  sec1000 := round(1000 * frac(time));
  If ShowMsec Then TimeString := Sign + MakeTimeStr(hours, minutes, seconds, sec1000, 0)
  Else TimeString := Sign + MakeTimeStr(hours, minutes, seconds, sec1000, 1);
End;



(***********************************************************************)

Constructor TBakGndImg.Create(AOwner : TComponent);
(***********************************************************************)

Begin
  Inherited Create;
  FName := '';
  FIncldPath := false;
  FFillMode := bfStretch;
End;

(***********************************************************************)

Destructor TBakGndImg.Destroy;
(***********************************************************************)

Begin
  Inherited Destroy;
End;

(***********************************************************************)

Procedure TBakGndImg.Changed;
(***********************************************************************)

Begin
  If Assigned(FOnChange) Then
    FOnChange(Self);
End;


(***********************************************************************)

Procedure TBakGndImg.SetIncldPath(x : boolean);
(***********************************************************************)

Begin
  FIncldPath := x;
  If Not x Then
    FName := extractFileName(FName);
  Changed;
End;

(***********************************************************************)

Procedure TBakGndImg.SetFillMode(x : TBkgFill);
(***********************************************************************)

Begin
  FFillMode := x;
  Changed;
End;


(***********************************************************************)

Procedure TBakGndImg.SetName(fn : String);
(***********************************************************************)

Begin
  If FIncldPath Then FName := fn
  Else FName := extractFileName(fn);
  Changed;
End;


(***********************************************************************)

Procedure TCrossHair.SetCrossHPosX(value : double);
(***********************************************************************)

Begin
  FPosX := value;
  Changed;
End;

(***********************************************************************)

Procedure TCrossHair.SetCrossHPosY(value : double);
(***********************************************************************)

Begin
  FPosY := value;
  Changed;
End;

(***********************************************************************)

Procedure TCrossHair.SetCrossHColor(value : TColor);
(***********************************************************************)

Begin
  FColor := value;
  Changed;
End;

(***********************************************************************)

Procedure TCrossHair.SetCrossHMode(value : TCrossHMode);
(***********************************************************************)

Begin
  FMode := value;
  Changed;
End;

(***********************************************************************)

Procedure TCrossHair.SetCrossHLineType(value : TPenStyle);
(***********************************************************************)

Begin
  FLineType := value;
  Changed;
End;

(***********************************************************************)

Procedure TCrossHair.SetCrossHLineWid(value : integer);
(***********************************************************************)

Begin
  FLineWid := value;
  Changed;
End;

(***********************************************************************)

Procedure TCrossHair.Changed;
(***********************************************************************)

Begin
  If Assigned(FOnChange) Then
    FOnChange(Self);
End;



(***********************************************************************)

Procedure TTextLabel.SetTxtLblScreenPos(value : boolean);
(***********************************************************************)

Begin
  FAttachDat := value;
  Changed;
End;

(***********************************************************************)

Procedure TTextLabel.SetTxtLblAlignment(al : TAlignment);
(***********************************************************************)

Begin
  FAlignment := al;
  Changed;
End;


(***********************************************************************)

Function TTextLabel.GetTxtLblPosX : double;
(***********************************************************************)

Begin
  GetTxtLblPosX := FPosX;
End;


(***********************************************************************)

Procedure TTextLabel.SetTxtLblPosX(value : double);
(***********************************************************************)

Begin
  FPosX := value;
  Changed;
End;


(***********************************************************************)

Procedure TTextLabel.SetTxtLblPosY(value : double);
(***********************************************************************)

Begin
  FPosY := value;
  Changed;
End;

(***********************************************************************)

Procedure TTextLabel.SetTxtLblColorBkg(value : TColor);
(***********************************************************************)

Begin
  FColorBkg := value;
  Changed;
End;

(***********************************************************************)

Procedure TTextLabel.SetTxtLblColorBrd(value : TColor);
(***********************************************************************)

Begin
  FColorBrd := value;
  Changed;
End;


(***********************************************************************)

Procedure TTextLabel.SetTxtLblColorShadow(value : TColor);
(***********************************************************************)

Begin
  FColorShadow := value;
  Changed;
End;

(***********************************************************************)

Procedure TTextLabel.SetTxtLblShadowDx(value : integer);
(***********************************************************************)

Begin
  FXShadow := value;
  Changed;
End;

(***********************************************************************)

Procedure TTextLabel.SetTxtLblShadowDy(value : integer);
(***********************************************************************)

Begin
  FYShadow := value;
  Changed;
End;


(***********************************************************************)

Procedure TTextLabel.SetTxtLblFont(value : TFont);
(***********************************************************************)

Begin
  FFont := value;
  Changed;
End;

(***********************************************************************)

Procedure TTextLabel.SetTxtLblCaption(value : String);
(***********************************************************************)

Begin
  FCaption := value;
  Changed;
End;

(***********************************************************************)

Procedure TTextLabel.SetTxtLblTranspar(value : boolean);
(***********************************************************************)

Begin
  FTranspar := value;
  Changed;
End;

(***********************************************************************)

Procedure TTextLabel.SetTxtLblMode(value : TTxtLblMode);
(***********************************************************************)

Begin
  FMode := value;
  Changed;
End;

(***********************************************************************)

Procedure TTextLabel.Changed;
(***********************************************************************)

Begin
  If Assigned(FOnChange) Then
    FOnChange(Self);
End;




(***********************************************************************)

Procedure TDTLabel.Changed;
(***********************************************************************)

Begin
  If Assigned(FOnChange) Then
    FOnChange(Self);
End;



(***********************************************************************)

Procedure TDTLabel.SetDateOrder(value : DateOrderType);
(***********************************************************************)

Begin
  FDateOrder := value;
  Changed;
End;

(***********************************************************************)

Procedure TDTLabel.SetTimeFormat(value : TimeFormatType);
(***********************************************************************)

Begin
  FTimeFormat := value;
  Changed;
End;


(***********************************************************************)

Procedure TDTLabel.SetDateSeparator(Value : char);
(***********************************************************************)

Begin
  If Value <> FDateSeparator Then Begin
    FDateSeparator := Value;
    Changed;
  End;
End;


(***********************************************************************)

Procedure TDTLabel.SetTimeSeparator(Value : char);
(***********************************************************************)

Begin
  If Value <> FTimeSeparator Then Begin
    FTimeSeparator := Value;
    Changed;
  End;
End;


(***********************************************************************)

Procedure TDTLabel.SetYearLength(Value : YearLengthType);
(***********************************************************************)

Begin
  If Value <> FYearLength Then Begin
    FYearLength := Value;
    Changed;
  End;
End;


(***********************************************************************)

Procedure TDTLabel.SetDateFortime(value : DateForTimeType);
(***********************************************************************)

Begin
  If Value <> FDateForTime Then Begin
    FDateForTime := Value;
    Changed;
  End;
End;


(***********************************************************************)

Procedure TDTLabel.SetMonthName(Value : boolean);
(***********************************************************************)

Begin
  If Value <> FMonthName Then Begin
    FMonthName := Value;
    Changed;
  End;
End;



(*============== following are linked list operations =================*)


(***********************************************************************)

Procedure TRChart.LLCalcExtents(np : PDrawCan; Rim : double;
  Var xLo, yLo, xHi, yHi : double);
(***********************************************************************
  ENTRY:  np         pointer to first element in linked list
          Rim        additional rim to be used (in percent of range)

  EXIT:   xLo..yHi   bounds of axes to be used
 ***********************************************************************)

Const
  eto1              : extended = 2.718281828459045235360;

Var
  RangeChanged      : boolean;
  rx, ry            : double;
  sclf              : double;

Begin
  xLo := RcMaxDouble;
  yLo := RcMaxDouble;
  xHi := -RcMaxDouble;
  yHi := -RcMaxDouble;
  RangeChanged := false;
  While (np^.Element <> tkNone) Do Begin
    RangeChanged := true;
    If (np^.Element <> tkMoveRelPix) And (np^.Element <> tkLineRelPix) Then Begin
      If np^.x < xLo Then
        xLo := np^.x;
      If np^.y < yLo Then
        yLo := np^.y;
      If np^.x > xHi Then
        xHi := np^.x;
      If np^.y > yHi Then
        yHi := np^.y;
    End;
    Case np^.Element Of
      tkLine,
        tkRect : Begin
          If np^.x2 < xLo Then
            xLo := np^.x2;
          If np^.y2 < yLo Then
            yLo := np^.y2;
          If np^.x2 > xHi Then
            xHi := np^.x2;
          If np^.y2 > yHi Then
            yHi := np^.y2;
        End;
      tkRectFrame : Begin
          If np^.x4 < xLo Then
            xLo := np^.x4;
          If np^.y4 < yLo Then
            yLo := np^.y4;
          If np^.x4 > xHi Then
            xHi := np^.x4;
          If np^.y4 > yHi Then
            yHi := np^.y4;
        End;
      tkEllipse : Begin
          If np^.x - np^.ha < xLo Then
            xLo := np^.x - np^.ha;
          If np^.y - np^.hv < yLo Then
            yLo := np^.y - np^.hv;
          If np^.x + np^.ha > xHi Then
            xHi := np^.x + np^.ha;
          If np^.y + np^.hv > yHi Then
            yHi := np^.y + np^.hv;
        End;
      tk3DBar : Begin
          If np^.x3 < xLo Then
            xLo := np^.x3;
          If np^.y3 < yLo Then
            yLo := np^.y3;
          If np^.x3 > xHi Then
            xHi := np^.x3;
          If np^.y3 > yHi Then
            yHi := np^.y3;
        End;
    End;
    np := np^.Next;
  End;
  If Not RangeChanged Then Begin
    xLo := 0;
    xHi := 0;
    yLo := 0;
    yHi := 0;
  End
  Else Begin
    If RcXLog Then Begin
      sclf := ln(xHi / xLo);
      xHi := xLo * exp(sclf * (1 + rim / 100));
      xLo := xLo * exp(-sclf * rim / 100);
    End
    Else Begin
      rx := Rim / 100 * (xHi - xLo);
      xLo := xLo - rx;
      xHi := xHi + rx;
    End;
    If RcYLog Then Begin
      sclf := ln(yHi / yLo);
      yHi := yLo * exp(sclf * (1 + rim / 100));
      yLo := yLo * exp(-sclf * rim / 100);
    End
    Else Begin
      ry := Rim / 100 * (yHi - yLo);
      yLo := yLo - ry;
      yHi := yHi + ry;
    End;
  End;
  If xLo = xHi Then Begin
    xLo := xLo - 1;
    xHi := xHi + 1;
  End;
  If yLo = yHi Then Begin
    yLo := yLo - 1;
    yHi := yHi + 1;
  End;
End;



(***********************************************************************)

Procedure LLCalcMinMax(np : PDrawCan; RangeLoX, RangeLoY, RangeHiX, RangeHiY : double;
  Var xLo, yLo, xHi, yHi : double);
(***********************************************************************
  ENTRY:  np ................... pointer to first element in linked list
          RangeLoX..RangeHiY ... range of data area to be scanned

  EXIT:   xLo..yHi ............. minima and maxima found
 ***********************************************************************)

Begin
  xLo := RcMaxDouble;
  yLo := RcMaxDouble;
  xHi := -RcMaxDouble;
  yHi := -RcMaxDouble;
  While (np^.Element <> tkNone) Do Begin
    If (np^.Element <> tkMoveRelPix) And (np^.Element <> tkLineRelPix) Then
      If (np^.x > RangeLoX) And (np^.x < RangeHiX) And
        (np^.y > RangeLoY) And (np^.y < RangeHiY) Then Begin
        If np^.x < xLo Then
          xLo := np^.x;
        If np^.y < yLo Then
          yLo := np^.y;
        If np^.x > xHi Then
          xHi := np^.x;
        If np^.y > yHi Then
          yHi := np^.y;
      End;
    Case np^.Element Of
      tkLine,
        tkRect : If (np^.x2 > RangeLoX) And (np^.x2 < RangeHiX) And
        (np^.y2 > RangeLoY) And (np^.y2 < RangeHiY) Then Begin
          If np^.x2 < xLo Then
            xLo := np^.x2;
          If np^.y2 < yLo Then
            yLo := np^.y2;
          If np^.x2 > xHi Then
            xHi := np^.x2;
          If np^.y2 > yHi Then
            yHi := np^.y2;
        End;
      tkRectFrame : If (np^.x4 > RangeLoX) And (np^.x4 < RangeHiX) And
        (np^.y4 > RangeLoY) And (np^.y4 < RangeHiY) Then Begin
          If np^.x4 < xLo Then
            xLo := np^.x4;
          If np^.y4 < yLo Then
            yLo := np^.y4;
          If np^.x4 > xHi Then
            xHi := np^.x4;
          If np^.y4 > yHi Then
            yHi := np^.y4;
        End;
      tk3DBar : If (np^.x3 > RangeLoX) And (np^.x3 < RangeHiX) And
        (np^.y3 > RangeLoY) And (np^.y3 < RangeHiY) Then Begin
          If np^.x3 < xLo Then
            xLo := np^.x3;
          If np^.y3 < yLo Then
            yLo := np^.y3;
          If np^.x3 > xHi Then
            xHi := np^.x3;
          If np^.y3 > yHi Then
            yHi := np^.y3;
        End;
    End;
    np := np^.Next;
  End;
End;



(******************************************************************)

Procedure LLScaleItem(Item : PDrawCan; kx, dx, ky, dy : double);
(******************************************************************
ENTRY: Item ........ pointer to Item
       kx, ky ...... k of scaling for x and y
       dx, dy ...... d of scaling for x and y

EXIT:  The position of the selected item is scaled by
                                         x´ := x * kx + dx
                                     and y´ := y * ky + dy
 ******************************************************************)

Begin
  Item^.x := kx * Item^.x + dx;
  Item^.y := ky * Item^.y + dy;
  If (Item^.Element = tkLine) Or (Item^.Element = tkRect) Or
    (Item^.Element = tkRectFrame) Or (Item^.Element = tk3DBar) Or
    (Item^.Element = tkEllipse) Then Begin
    Item^.x2 := kx * Item^.x2 + dx;
    Item^.y2 := ky * Item^.y2 + dy;
  End;
End;

(******************************************************************)

Procedure LLScaleAllItems(np : PDrawCan; kx, dx, ky, dy : double);
(******************************************************************
ENTRY: np .......... pointer to first item in linked list to be processed
       kx, ky ...... k of scaling for x and y
       dx, dy ...... d of scaling for x and y

EXIT:  All items starting with np are scaled by the equations
               x´ := x * kx + dx,  and
               y´ := y * ky + dy
 ******************************************************************)

Begin
  While np^.Element <> tkNone Do Begin
    np^.x := kx * np^.x + dx;
    np^.y := ky * np^.y + dy;
    If (np^.Element = tkLine) Or (np^.Element = tkRect) Or
      (np^.Element = tkRectFrame) Or (np^.Element = tk3DBar) Or
      (np^.Element = tkEllipse) Then Begin
      np^.x2 := kx * np^.x2 + dx;
      np^.y2 := ky * np^.y2 + dy;
    End;
    np := np^.Next;
  End;
End;


(******************************************************************)

Procedure LLScaleSelectedItems(np : PDrawCan; kx, dx, ky, dy : double; ClassNumber : byte);
(******************************************************************
ENTRY: np ............ first item of linked list to start with
       kx, ky ........ k of scaling for x and y
       dx, dy ........ d of scaling for x and y
       ClassNumber ... class number of Items to be processed

EXIT:  All marked items starting with np are scaled by the equations
                  x´ := x * kx + dx,   and
                  y´ := y * ky + dy
 ******************************************************************)


Begin
  While np^.Element <> tkNone Do Begin
    If (np^.ItemClass = ClassNumber) Then Begin
      np^.x := kx * np^.x + dx;
      np^.y := ky * np^.y + dy;
      If (np^.Element = tkLine) Or (np^.Element = tkRect) Or
        (np^.Element = tkRectFrame) Or (np^.Element = tk3DBar) Or
        (np^.Element = tkEllipse) Then Begin
        np^.x2 := np^.x2 + dx;
        np^.y2 := np^.y2 + dy;
      End;
    End;
    np := np^.Next;
  End;
End;

(******************************************************************)

Function LLFindNearestItemReal(np : PDrawCan; mx, my : double;
  ItemID : ItemType; ClassNumber : byte; Var dist : double) : PDrawCan;
(******************************************************************
ENTRY: np ........... first item of linked list to be processed
       mx, my ....... real-world coords of search position
       ItemID ....... type of Item to be searched for
       ClassNumber .. class number of item to be searched for (255 = everything)

EXIT:  The pointer to the Item which is nearest to the position [mx,my]
       is returned. The distance is calulated from the real-world
       coordinates. A NIL value indicates that no Item of this type
       is present in the linked list. The distance of the closest item
       is returned in variable 'dist'.
*******************************************************************)

Var
  idx               : PDrawCan;
  d                 : double;

Begin
  idx := Nil;
  dist := RcMaxDouble;
  If ItemID <> tkNone Then { search only if ItemID is not tkNone }  Begin
    While (np^.Element <> tkNone) Do Begin
      If (((ItemID = tkNotMoveTo) And (np^.Element <> tkMoveTo)) Or
        (ItemID = tkEverything) Or (np^.Element = ItemID)) And
        ((ClassNumber = 255) Or (ClassNumber = np^.ItemClass)) Then Begin
        d := sqr(np^.x - mx) + sqr(np^.y - my);
        If d < dist Then Begin
          dist := d;
          idx := np;
        End;
      End;
      np := np^.Next;
    End;
  End;
  dist := sqrt(dist);
  LLFindNearestItemReal := idx;
End;


(******************************************************************)

Function LLMarkItemsInWindow(np : PDrawCan; xLo, YLo, XHi, YHi : double;
  ItemID : ItemType; ClassNumber : byte) : longint;
(******************************************************************
ENTRY: np .................. first item to start with
       xLo, YLo, XHi, YHi .. real-world coords of search window
       ItemID .............. type of Item to be searched in this window
       ClassNumber ......... class number to be assigned to found Items

EXIT:  All the Items which fulfill the given restrictions (xLo..yHi, ItemID)
       are assigned to a common class number 'ClassNumber'. The function
       returns the number of Items found in window.
*******************************************************************)

Var
  cnt               : longint;

Begin
  cnt := 0;
  If ClassNumber <> 255 Then Begin
    If xLo > xHi Then
      Exchange(xLo, xHi, sizeof(xLo));
    If yLo > yHi Then
      Exchange(yLo, yHi, sizeof(yLo));
    If ItemID <> tkNone Then { search only if ItemID is not tkNone }  Begin
      While (np^.Element <> tkNone) Do Begin
        If (((ItemID = tkNotMoveTo) And (np^.Element <> tkMoveTo)) Or
          (ItemID = tkEverything) Or (np^.Element = ItemID)) Then Begin
          If ((np^.x >= xLo) And (np^.x <= xHi) And
            (np^.y >= yLo) And (np^.y <= yHi)) Then Begin
            inc(cnt);
            np^.ItemClass := ClassNumber;
          End;
        End;
        np := np^.Next;
      End;
    End;
  End;
  LLMarkItemsInWindow := cnt;
End;

(******************************************************************)

Procedure LLMarkAllItems(np : PDrawCan; ItemID : ItemType; ClassNumber : byte);
(******************************************************************
ENTRY: np ............ first item to be processed
       ItemID ........ type of Item to be searched in this window
       ClassNumber ... class number to be assigned to found Items

EXIT:  All the Items which fulfill the given restrictions (ItemID)
       are assigned to a common class number 'ClassNumber'. The function
       returns the number of Items found in window.
*******************************************************************)


Begin
  If ClassNumber <> 255 Then Begin
    If ItemID <> tkNone Then { search only if ItemID is not tkNone }  Begin
      While (np^.Element <> tkNone) Do Begin
        If (((ItemID = tkNotMoveTo) And (np^.Element <> tkMoveTo)) Or
          (ItemID = tkEverything) Or (np^.Element = ItemID)) Then
          np^.ItemClass := ClassNumber;
        np := np^.Next;
      End;
    End;
  End;
End;


(***********************************************************************)

Constructor TRChart.Create(AOwner : TComponent);
(***********************************************************************)

Var
  NTstr             : Array[0..255] Of char;
  auxi              : integer;
  i                 : integer;
  ix                : ItemType;

Begin
  Inherited Create(AOwner);             { Inherit original constructor }
{$IFDEF DEBUG}
  StartSysTime := GetTickCount;
{$ENDIF}
  Height := DefRCHeight;                { Add new initializations }
  Width := defRCWidth;
  RcLastCan := New(PDrawCan);
  RcFrstCan := RcLastCan;
  RcLastCanOnShow := RcLastCan;
  RcLastCan^.Element := tkNone;
  RCLastCan^.Prev := Nil;
  RCLastCan^.Next := Nil;
  RcLRim := DefLRim;
  RcRRim := DefRRim;
  RcTRim := DefTRim;
  RcBRim := DefBRim;
  Rc3DRim := defShadowWidth;
  RcBndLoX := 0;
  RcBndHiX := 1;
  RcBndLoY := 0;
  RcBndHiY := 1;
  RcShadowColor := clGrayText;
  RcShadowBakCol := clBtnFace;
  RcShadowStyle := ssFlying;
  RcShortTicksX := true;
  RcShortTicksY := true;
  RcXLog := false;
  RcYLog := false;
  RcDecPlcX := defDecPlcX;
  RcDecPlcY := defDecPlcY;
  RcDataCol := defDataCol;
  RcPenStyle := defPenStyle;
  RcScaleCol := defScaleCol;
  RcFillCol := defFillCol;
  RcChartCol := defChartCol;
  RcWindCol := defWindCol;
  RcGridCol := defGridCol;
  RcLineWid := defLineWid;
  RcScaleInscrX := '';
  RcScaleInscrY := '';
  FClassicLayout := true;
  FXaxPos := xapBottom;
  FYaxPos := yapLeft;
  FUseDataOf := Nil;
  FDataUsersNum := 0;
  FUserTickTextX := '';
  FUserTickTextY := '';
  FTranspItems := false;
  FMinRngDiffX := 1E-10;
  FMinRngDiffY := 1E-10;
  TitStr := '';
  For ix := low(FItemCount) To high(FItemCount) Do
    FItemCount[ix] := 0;
  FItemCount[tkNone] := 1;
                   { The following lines have been included as a work-around for
                     a Delphi bug: Delphi (2.0) does not store a property if its
                     value is zero, even if the 'stored' keyword is specified.
                     This causes troubles if the default value is not zero. }
  If csDesigning In ComponentState Then Begin
    RcBndHiX := defBndHiX;
    RcBndHiY := defBndHiY;
  End
  Else Begin
    RcBndHiX := 1;
    RcBndHiY := 1;
{
       RcBndHiX := 0;   // uncomment these lines for Delphi 2.0
       RcBndHiY := 0;
}
  End;

  FZStackPoi := 1;
  ZoomStateOnStack;
  For i := 1 To 4 Do
    FZoomRange[i] := 0;

  For i := 1 To MaxCrossH Do Begin
    FCrossHair[i] := TCrossHair.Create;
    FCrossHair[i].FPosX := 0;
    FCrossHair[i].FPosY := 0;
    FCrossHair[i].FColor := clBlack;
    FCrossHair[i].FMode := chOff;
    FCrossHair[i].FNum := I;
    FCrossHair[i].FLineType := psSolid;
    FCrossHair[i].FLineWid := 1;
    FCrossHair[i].OnChange := StyleChanged;
  End;

  For i := 1 To MaxTxtLbl Do Begin
    FTextLabels[i] := TTextLabel.Create;
    FTextLabels[i].FPosX := 0;
    FTextLabels[i].FPosY := 0;
    FTextLabels[i].FAttachDat := true;
    FTextLabels[i].FAlignment := taCenter;
    FTextLabels[i].FColorBkg := clWhite;
    FTextLabels[i].FColorBrd := clBlack;
    FTextLabels[i].FXShadow := 3;
    FTextLabels[i].FYShadow := 3;
    FTextLabels[i].FColorShadow := clGray;
    FTextLabels[i].FTranspar := false;
    FTextLabels[i].FCaption := '';
    FTextLabels[i].FFont := TFont.Create;
    FTextLabels[i].FFont.Assign(Font);
    FTextLabels[i].FMode := tlOff;
    FTextLabels[i].OnChange := StyleChanged;
  End;

  RcXLabelType := ftNum;
  RcYLabelType := ftNum;

  FBakGndFile := TBakGndImg.Create(AOwner);
  FBakGndFile.Name := '';
  FBakGndFile.OnChange := StyleChanged;

  FDataTag := 0;
  FIsometric := false;
  FMCurFixed := false;
  FAutoRedraw := true;
  FNumPPa := 0;
  FTextFontStyle := [];
  FTextBkStyle := tbClear;
  FTextBkColor := clWhite;
  FTextAlignment := taCenter;
  FXTickPosCnt := 0;
  FYTickPosCnt := 0;
  For i := 0 To 255 Do
    FItClassVisib[i] := true;

  FDTXFormat := TDTLabel.Create;
  With FDTXFormat Do Begin
    TimeFormat := tfHHMMSS;
    DateSeparator := '-';
    TimeSeparator := ':';
    YearLength := ylYYYY;
    MonthName := true;
    DateForTime := dtOnePerDay;
    DateOrder := doDDMMYY;
    OnChange := StyleChanged;
  End;

  FDTYFormat := TDTLabel.Create;
  With FDTYFormat Do Begin
    TimeFormat := tfHHMMSS;
    DateSeparator := '-';
    TimeSeparator := ':';
    YearLength := ylYYYY;
    MonthName := true;
    DateForTime := dtOnePerDay;
    DateOrder := doDDMMYY;
    OnChange := StyleChanged;
  End;

  RcXNTick := defNXTick;
  RcYNTick := defNYTick;
  RcGridStyle := gsNone;
  RcGridDx := 0;
  RcGridDy := 0;
  StrPCopy(NTstr, 'CURHAND');
  Screen.Cursors[1] := LoadCursor(hinstance, NTstr);
  StrPCopy(NTstr, 'CURZOOMW');
  Screen.Cursors[2] := LoadCursor(hinstance, NTstr);
  StrPCopy(NTstr, 'CURZOOMD');
  Screen.Cursors[3] := LoadCursor(hinstance, NTstr);
  StrPCopy(NTstr, 'CURZOOMP');
  Screen.Cursors[4] := LoadCursor(hinstance, NTstr);

  GrafBmp := TBitmap.Create;            { Create the working bitmap and set its width and height }
  auxi := Width - RcLrim - RcRrim - Rc3DRim + 1;
  If auxi < 0 Then
    auxi := 0;
  GrafBmp.Width := auxi;
  auxi := Height - RcTRim - RcBRim - Rc3DRim + 1;
  If auxi < 0 Then
    auxi := 0;
  GrafBmp.Height := auxi;
  ChartBmp := TBitmap.Create;           { Create the chart bitmap and set its width and height }
  ChartBmp.Width := Width;
  ChartBmp.Height := Height;
  AuxCHBmp := TBitmap.Create;           { Create the working bitmap for cross hairs }
  AuxBmp := TBitmap.Create;             { Create the auxiliary background bitmap }
  AuxBmp.Width := 10;
  AuxBmp.Height := 10;
  Fxasp := GetDeviceCaps(AuxBmp.canvas.handle, aspectx);
  Fyasp := GetDeviceCaps(AuxBmp.canvas.handle, aspecty);
  RcMouseAction := maNone;
  LButtonWasDown := False;
  MouseAnchorScrX := 0;
  MouseAnchorScrY := 0;
  MouseAnchorRcLoX := 0;
  MouseAnchorRcLoY := 0;
  MouseAnchorRcHiX := 0;
  MouseAnchorRcHiY := 0;
  LastMouseX := 0;
  LastMouseY := 0;
  FZoomState := zsNormal;
  MouseBoxState := msNormal;
  FOnZoomPan := Nil;
  FOnDataRendered := Nil;
  FOnScaleTickDrawn := Nil;
  FOnScalesRendered := Nil;
  FOnCrossHMove := Nil;
  FOnTxtLblMove := Nil;
  FOnMMvInChart := Nil;
{$IFDEF SHAREWARE}
  Hint := GetHintStr;
  ShowHint := True;
{$ENDIF}
  GraphList := TList.Create;
//AdjustScaling;
  FYarMashTab := 1.0;
End;


(***********************************************************************)

Procedure TRChart.Loaded;
(***********************************************************************)

Begin
  Inherited;
{$IFDEF DEBUG}
  assignFile(DebugFile, 'RCDEBUG_' + Name + '.TXT');
  rewrite(DebugFile);
  writeln(DebugFile, 'debugging log file of ', Name);
  writeln(DebugFile);
  writeln(DebugFile, ' time [s]  action');
  writeln(DebugFile, '----------------------------------------------------');
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ' + 'Loaded');
{$ENDIF}
  AdjustScaling;
  Paint;
End;


(***********************************************************************)

Destructor TRChart.Destroy;
(***********************************************************************)


Var
  np                : PDrawCan;
  this              : PDrawCan;
  i                 : integer;

Begin
  For i := 1 To MaxCrossH Do
    FCrossHair[i].Free;
  For i := 1 To MaxTxtLbl Do Begin
    FTextLabels[i].FFont.Free;
    FTextLabels[i].Free;
  End;
  FDTXFormat.Free;
  FDTYFormat.Free;
  If FUseDataOf = Nil Then Begin
    this := RcFrstCan;
    While this^.Element <> tkNone Do Begin
      np := this^.Next;
      Dispose(this);
      this := np;
    End;
    Dispose(this);
  End;
  GrafBmp.Free;                         { destroy the graphics bitmap }
  AuxCHBmp.Free;                        { destroy the crosshair bitmap }
  ChartBmp.Free;                        { destroy the chart bitmap }
  AuxBmp.Free;                          { destroy aux. background bitmap }
  FBakGndFile.Free;                     { destroy background image class }
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ' + 'Destroyed');
  closeFile(DebugFile);
{$ENDIF}
  GraphList.Free;
  Inherited Destroy;                    { inherit original destructor }
End;


(******************************************************************)

Procedure TRChart.ZoomHistory(index : integer);
(******************************************************************)

Var
  poi               : integer;

Begin
  If (Index > -MaxZoomStack) And (Index <= 0) Then Begin
    poi := FZStackPoi + Index - 1;
    If poi < 1 Then
      poi := poi + MaxZoomStack;
    If (FZoomStack[poi, 1] <> 0) Or (FZoomStack[poi, 2] <> 0) Or
      (FZoomStack[poi, 3] <> 0) Or (FZoomStack[poi, 4] <> 0) Then Begin
      ForceRange(FZoomStack[poi, 1], FZoomStack[poi, 2],
        FZoomStack[poi, 3], FZoomStack[poi, 4], false, false);
      Paint;
    End;
  End;
End;

(******************************************************************)

Procedure TRChart.ClearZoomHistory;
(******************************************************************)

Begin
  FZStackPoi := 1;
  ZoomStateOnStack;
End;

(******************************************************************)

Function TRChart.GetClassVisib(cnum : byte) : boolean;
(******************************************************************)

Begin
  GetClassVisib := FItClassVisib[cnum];
End;

(******************************************************************)

Procedure TRChart.SetClassVisib(cnum : byte; value : boolean);
(******************************************************************)

Begin
  If FItClassVisib[cnum] <> value Then Begin
    FItClassVisib[cnum] := value;
    Paint;
  End;
End;

(******************************************************************)

Function TRChart.GetItemCount(it : Itemtype) : longint;
(******************************************************************)

Begin
  GetItemCount := FItemCount[it];
End;


(******************************************************************)

Function TRChart.GetCHPosX(chnum : integer) : double;
(******************************************************************)

Begin
  If (chnum > 0) And (chnum <= MaxCrossH) Then GetCHPosX := FCrossHair[chnum].FPosX
  Else GetCHPosX := 0;
End;

(******************************************************************)

Procedure TRChart.SetCHPosX(chnum : integer; value : double);
(******************************************************************)

Begin
  If (chnum >= 1) And (chnum <= MaxCrossH) Then Begin
    FCrossHair[chnum].FPosX := value;
    If FCrossHair[chnum].FMode <> chOff Then
      DrawFinish(RcLRim, RcTRim, GrafBmp);
  End;
End;

(******************************************************************)

Function TRChart.GetCHPosY(chnum : integer) : double;
(******************************************************************)

Begin
  If (chnum > 0) And (chnum <= MaxCrossH) Then GetCHPosY := FCrossHair[chnum].FPosY
  Else GetCHPosY := 0;
End;

(******************************************************************)

Procedure TRChart.SetCHPosY(chnum : integer; value : double);
(******************************************************************)

Begin
  If (chnum >= 1) And (chnum <= MaxCrossH) Then Begin
    FCrossHair[chnum].FPosY := value;
    If FCrossHair[chnum].FMode <> chOff Then
      DrawFinish(RcLRim, RcTRim, GrafBmp);
  End;
End;


(******************************************************************)

Function TRChart.GetMousePosX : double;
(******************************************************************)
// remark: the function GetMousePosX has to be implemented in order to cope with a bug of C++Builder
// which cannot address properties of type double directly

Begin
  GetMousePosX := FMousePosX;
End;

(******************************************************************)

Function TRChart.GetMousePosY : double;
(******************************************************************)
// remark: the function GetMousePosY has to be implemented in order to cope with a bug of C++Builder
// which cannot address properties of type double directly

Begin
  GetMousePosY := FMousePosY;
End;



(******************************************************************)

Function TRChart.GetTickPosX(ix : integer) : double;
(******************************************************************)

Begin
  If (ix >= 1) And (ix <= FXTickPosCnt) Then Begin
    If RCBndLoX <= RcBndHiX Then GetTickPosX := FXScaleTickPos[ix]
    Else GetTickPosX := FXScaleTickPos[FXTickPosCnt - ix + 1];
  End
  Else GetTickPosX := 0;
End;


(******************************************************************)

Function TRChart.GetTickPosY(iy : integer) : double;
(******************************************************************)

Begin
  If (iy >= 1) And (iy <= FYTickPosCnt) Then Begin
    If RCBndLoY <= RcBndHiY Then GetTickPosY := FYScaleTickPos[iy]
    Else GetTickPosY := FYScaleTickPos[FYTickPosCnt - iy + 1];
  End
  Else GetTickPosY := 0;
End;



(******************************************************************)

Procedure TRChart.SetBounds(ALeft, ATop, AWidth, AHeight : Integer);
(******************************************************************)

Begin
  If AHeight < MinRCHeight + RcTRim + RcBRim Then
    AHeight := MinRCHeight + RCTRim + RcBRim;
  If AWidth < MinRCWidth + RcLRim + RcRRim Then
    AWidth := MinRCWidth + RcLRim + RcRRim;
  If FIsoMetric Then
    SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
  Inherited SetBounds(ALeft, ATop, AWidth, AHeight);
End;

(******************************************************************)

Procedure TRChart.DoZoomPanEvent;
(******************************************************************)

Begin
  If Assigned(FOnZoomPan) Then
    FOnZoomPan(self);
End;



(******************************************************************)

Procedure TRChart.DoCrossHMoveEvent(WhichCH : TCrossHair);
(******************************************************************)

Begin
  If Assigned(FOnCrossHMove) Then
    FOnCrossHMove(self, WhichCH);
End;

(******************************************************************)

Procedure TRChart.DoTxtLblMoveEvent(WhichTL : TTextLabel);
(******************************************************************)

Begin
  If Assigned(FOnTxtLblMove) Then
    FOnTxtLblMove(self, WhichTL);
End;


(******************************************************************)

Procedure TRChart.MouseMoveInChart(InChart : boolean; Shift : TShiftState;
  RMousePosX, RMousePosY : double);
(******************************************************************
  InChart: TRUE if mouse cursor is within chart area
  Shift: state of mouse buttons
  RMousePosX, RMousePosY: real world coordinates of mouse cursor
 ******************************************************************)

Begin
  If Assigned(FOnMMvInChart) Then Begin
    FOnMMvInChart(self, InChart, Shift, rMousePosX, rMousePosY);
{$IFDEF DEBUG}
    writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'MouseMoveInChart (', RMousePosX : 1 : 3, ',', RMousePosY : 1 : 3, ')');
{$ENDIF}
  End;
End;

(******************************************************************************)

Procedure TRChart.CMMouseLeave(Var msg : TMessage);
(*******************************************************************************
  Enter : msg...TMessage

  All descendants of TComponent send a CM_MOUSEENTER and CM_MOUSELEAVE message
  when the mouse enters and leaves the bounds of the component.
*******************************************************************************)

Begin
  Inherited;
  Screen.Cursor := crDefault;
End;


(******************************************************************)

Procedure TRChart.WMMouseMoveInChart(Var Message : TWMMouse);
(******************************************************************)

Var
  rx, ry            : double;
  InChart           : boolean;

Begin
  Inherited;                            { default handling }
  With Message Do Begin
    M2R(XPos, YPos, rx, ry);
    If (XPos >= RcLRim) And (XPos <= Width - RcRRim - Rc3DRim) And
      (YPos >= RcTRim) And (YPos <= Height - RcBRim - Rc3DRim) Then InChart := True
    Else InChart := false;
  End;
  MouseMoveInChart(InChart, KeysToShiftState(Message.Keys), rx, ry);
End;



(******************************************************************)

Function TRChart.ExtractUserText(TickText : String; ix : integer) : String;
(******************************************************************
  ENTRY:   TickText ..... tick text, pipe separated
           ix ........... index of part to be extracted
  EXIT:    tick text of tick ix
 ******************************************************************)

Var
  j                 : integer;
  LastIx            : integer;

Begin
  j := 0;
  LastIx := 1;
  While ((ix > 0) And (j < length(Ticktext))) Do Begin
    inc(j);
    If tickText[j] = '|' Then Begin
      dec(ix);
      If ix > 0 Then
        LastIx := j + 1;
    End;
  End;
  If (j = length(TickText)) And (j > 0) Then
    If tickText[j] <> '|' Then
      inc(j);
  ExtractUserText := copy(Ticktext, LastIx, j - LastIx);
End;

(******************************************************************)

Function TRChart.AddScaleInscription(Instring : String; Inscr : InscriptStr) : String;
(******************************************************************
  ENTRY:   Instring ..... scale digits
           insrc ........ scale inscription frame
  EXIT:    combined string
 ******************************************************************)

Var
  astr2             : InscriptStr;
  ix                : integer;

Begin
  If length(Instring) = 0 Then AddScaleInscription := Instring
  Else Begin
    astr2 := '';
    ix := pos('&', Inscr);
    If ix > 0 Then Begin
      astr2 := copy(Inscr, ix + 1, length(Inscr));
      delete(Inscr, ix, length(Inscr));
    End;
    AddScaleInscription := Inscr + Instring + astr2;
  End;
End;

(******************************************************************)

Procedure TRChart.FindMinMax(RangeLoX, RangeLoY, RangeHiX, RangeHiY : double;
  Var MinX, MinY, MaxX, MaxY : double);
(******************************************************************
  ENTRY: RangeLoX..RangeHiY ..... range of data to be considered

  EXIT:  MinX..MaxY ............. minimum and maximum X and Y values of all graphics
                                  items in the specified range
 ******************************************************************)

Begin
  LLCalcMinMax(RcFrstCan,
    RangeLoX, RangeLoY, RangeHiX, RangeHiY,
    MinX, MinY, MaxX, MaxY);
End;

{$I hxoctbin.inc}

(******************************************************************)

Procedure TRChart.SaveLinkedListASC(FName : String);
(******************************************************************
  ENTRY:   FName ..... name of file containing linked list
  EXIT:    linked list is stored to the specified ASCII file
  REMARK:  This routine is for debugging purposes only
 ******************************************************************)


Var
  np                : PDrawCan;
  ItemCnt           : longint;
  TFile             : TextFile;


Begin
  np := RcFrstCan;
  ItemCnt := 0;
  assignFile(TFile, FName);
{$I-}rewrite(TFile);                    {I+}
  If IOResult = 0 Then Begin
    While (np^.Element <> tkNone) Do Begin
      inc(ItemCnt);
      writeln(Tfile);
      writeln(Tfile, '------ item ', ItemCnt, ' ------');
      writeln(TFile, 'self: ' + hex(longint(np), 8));
      writeln(TFile, 'prev: ' + hex(longint(np^.Prev), 8));
      writeln(TFile, 'next: ' + hex(longint(np^.Next), 8));
      Case np^.Element Of
        tkLineto : writeln(TFile, ' elemtype: ', 'tkLineTo');
        tkMoveTo : writeln(TFile, ' elemtype: ', 'tkMoveTo');
        tkMoveRelPix : writeln(TFile, ' elemtype: ', 'tkMoveRelPix');
        tkLineRelPix : writeln(TFile, ' elemtype: ', 'tkLineRelPix');
        tkLine : writeln(TFile, ' elemtype: ', 'tkLine');
        tkRect : writeln(TFile, ' elemtype: ', 'tkRect');
        tkRectFrame : writeln(TFile, ' elemtype: ', 'tkRectFrame');
        tkEllipse : writeln(TFile, ' elemtype: ', 'tkEllipse');
        tk3DBar : writeln(TFile, ' elemtype: ', 'tk3DBar');
        tkText : writeln(TFile, ' elemtype: ', 'tkText');
        tkMarkAt : writeln(TFile, ' elemtype: ', 'tkMarkAt');
      End;
      writeln(TFile, ' startpnt: [', np^.x : 1 : 4, '/', np^.y : 1 : 4, ']');
      writeln(Tfile, '    color: ', hex(longint(np^.color), 8));
      writeln(Tfile, ' penstyle: ', hex(ord(np^.penstyle), 2));
      writeln(Tfile, 'linewidth: ', np^.lwid);
      writeln(Tfile, ' classnum: ', np^.ItemClass);
      Case np^.Element Of
        tkLine : Begin
            writeln(Tfile, ' endpoint: [', np^.x2 : 1 : 4, '/', np^.y2 : 1 : 4, ']');
          End;
        tkRect : Begin
            writeln(Tfile, '   corner: [', np^.x2 : 1 : 4, '/', np^.y2 : 1 : 4, ']');
            writeln(Tfile, 'fillcolor: ', Hex(longint(np^.fillcol1), 8));
            writeln(Tfile, '  transp.: ', np^.transp1);
          End;
        tkRectFrame : Begin
            writeln(Tfile, '   corner: [', np^.x4 : 1 : 4, '/', np^.y4 : 1 : 4, ']');
            writeln(Tfile, 'fillcolor: ', Hex(longint(np^.fillcol2), 8));
            Case np^.framest Of
              rbLowered : writeln(Tfile, 'frametype: ', 'rbLowered');
              rbRaised : writeln(Tfile, 'frametype: ', 'rbRaised');
              rbEmbossed : writeln(Tfile, 'frametype: ', 'rbEmbossed');
              rbEngraved : writeln(Tfile, 'frametype: ', 'rbEngraved');
            End;
            writeln(Tfile, 'shadowcol: ', Hex(longint(np^.shadowcol), 8));
            writeln(Tfile, 'hilitecol: ', Hex(longint(np^.hilightcol), 8));
          End;
        tkEllipse : Begin
            writeln(Tfile, ' halfaxes: ', np^.ha : 1 : 4, ' ', np^.hv : 1 : 4);
            writeln(Tfile, 'fillcolor: ', Hex(longint(np^.fillcol3), 8));
            writeln(Tfile, '  transp.: ', np^.transp2);
          End;
        tk3DBar : Begin
            writeln(Tfile, ' endpoint: [', np^.x3 : 1 : 4, '/', np^.y3 : 1 : 4, ']');
            writeln(Tfile, 'fillcolor: ', Hex(longint(np^.fillcol4), 8));
            writeln(Tfile, '    depth: ', np^.depth);
            writeln(Tfile, '    angle: ', np^.angle);
          End;
        tkText : Begin
            writeln(TFile, '     text: ''', np^.txt, '''');
            writeln(TFile, '     size: ', np^.size);
          End;
        tkMarkAt : Begin
            writeln(TFile, ' marktype: ', np^.mark);
          End;
      End;
      np := np^.Next;
    End;

    inc(ItemCnt);
    writeln(Tfile);
    writeln(Tfile, '------ item ', ItemCnt, ' ------');
    writeln(TFile, 'self: ' + hex(longint(np), 8));
    writeln(TFile, 'prev: ' + hex(longint(np^.Prev), 8));
    writeln(TFile, 'next: ' + hex(longint(np^.Next), 8));
    writeln(TFile, ' elemtype: ', 'tkNone');
    closeFile(TFile);
  End;
End;


(******************************************************************)

Procedure TRChart.SaveLinkedList(FName : String);
(******************************************************************
  ENTRY:   FName ..... name of file containing linked list
  EXIT:    linked list is stored to the specified binary file
 ******************************************************************)

Var
  np                : PDrawCan;
  TFile             : File Of TDrawCan;

Begin
  np := RcFrstCan;
  assignFile(TFile, FName);
{$I-}rewrite(TFile);                    {I+}
  If IOResult = 0 Then Begin
    While np^.Element <> tkNone Do Begin
      write(Tfile, np^);
      np := np^.Next;
    End;
    closeFile(TFile);
  End;
End;


(******************************************************************)

Procedure TRChart.LoadLinkedList(FName : String; AppendIt : boolean);
(******************************************************************
  ENTRY:   FName ..... name of file containing linked list
           AppendIt .. a TRUE value causes appending the read linked
                       list to the existing one

  EXIT:    linked list is loaded from the specified binary file
 ******************************************************************)

Var
  np                : PDrawCan;
  TFile             : File Of TDrawCan;
  this              : PDrawCan;
  ix                : ItemType;
  AuxPrev           : PDrawCan;

Begin
  If Not AppendIt Then Begin
    this := RcFrstCan;                  { delete existing elements }
    While this^.Element <> tkNone Do Begin
      np := this^.Next;
      dispose(this);
      this := np;
    End;
    Dispose(this);
    RcLastCan := New(PDrawCan);
    RcFrstCan := RcLastCan;
    RcLastCanOnShow := RcLastCan;
    RcLastCan^.Element := tkNone;
    RcLastCan^.Next := Nil;
    RcLastCan^.Prev := Nil;
    For ix := low(FItemCount) To high(FItemCount) Do
      FItemCount[ix] := 0;
    FItemCount[tkNone] := 1;
  End;

  assignFile(TFile, FName);             { now load elements from file }
{$I-}reset(TFile);                      {I+}
  If IOResult = 0 Then Begin
    While Not eof(TFile) Do Begin
      AuxPrev := RcLastCan^.Prev;
      read(Tfile, RcLastCan^);
      RcLastCan^.Prev := AuxPrev;
      inc(FItemCount[RcLastCan^.Element]);
      RcLastCan^.Next := new(PDrawCan); { create new entry in item chain }
      RcLastCan^.Next^.Prev := RcLastCan;
      RcLastCan := RcLastCan^.Next;
      RcLastCan^.Element := tkNone;
      RcLastCan^.Next := Nil;
    End;
    closeFile(TFile);
  End;
  AdjustCanInfoOfSharedCharts;
  Paint;
End;

(***********************************************************************)

Procedure TRChart.SetDataTag(tag : longint);
(***********************************************************************)

Begin
  FDataTag := tag;
End;

(******************************************************************)

Procedure TRChart.CopyToClipboard(BlkWhite : boolean);
(******************************************************************)

Var
  RcWindColBak,
    RcChartColBak,
    RcScaleColBak,
    RcFontColBak    : TColor;
  AuxBitmap         : TBitmap;

Begin
  AuxBitmap := TBitmap.Create;          { Create the working bitmap and set its width and height }
  AuxBitmap.Width := GrafBmp.Width;
  AuxBitmap.Height := GrafBmp.Height;
  RcWindColBak := RcWindCol;            { backup colors }
  RcScaleColBak := RcScaleCol;
  RcChartColBak := RcChartCol;
  RcFontColBak := Font.Color;
  If BlkWhite Then Begin
    RcWindCol := clwhite;
    RcChartCol := clwhite;
    RcScaleCol := clblack;
    Font.Color := clblack;
  End;
  ConstructChartBmp(ChartBmp.Canvas);   { create chart }
  InitGraf(AuxBitmap.Canvas, 0, 0);
  ConstructDataBmp(AuxBitmap.Canvas, 0, 0, BlkWhite, RcFrstCan); { create data image }
  ChartBmp.Canvas.Draw(RcLRim, RcTRim, AuxBitmap);
  Clipboard.Assign(ChartBmp);
  RcWindCol := RcWindColBak;
  RcScaleCol := RcScaleColBak;
  RcChartCol := RcChartColBak;
  Font.Color := RcFontColBak;
  AuxBitmap.Free;
End;

(******************************************************************)

Procedure TRChart.CopyToBMP(FName : String; BlkWhite : boolean);
(******************************************************************
  ENTRY:   FName ..... name of bitmap file to be created
  EXIT:    bit map file contains BMP copy of RChart
 ******************************************************************)

Var
  astr1, astr2      : String;
  i                 : integer;
  RcWindColBak,
    RcChartColBak,
    RcScaleColBak,
    RcFontColBak    : TColor;
  AuxBitmap         : TBitmap;

Begin
  AuxBitmap := TBitmap.Create;          { Create the working bitmap and set its width and height }
  AuxBitmap.Width := GrafBmp.Width;
  AuxBitmap.Height := GrafBmp.Height;
  RcWindColBak := RcWindCol;            { backup colors }
  RcScaleColBak := RcScaleCol;
  RcChartColBak := RcChartCol;
  RcFontColBak := Font.Color;
  If BlkWhite Then Begin
    RcWindCol := clwhite;
    RcChartCol := clwhite;
    RcScaleCol := clblack;
    Font.Color := clblack;
  End;
  ConstructChartBmp(ChartBmp.Canvas);   { create chart }
  InitGraf(AuxBitmap.Canvas, 0, 0);
  ConstructDataBmp(AuxBitmap.Canvas, 0, 0, BlkWhite, RcFrstCan); { create data image }
  ChartBmp.Canvas.Draw(RcLRim, RcTRim, AuxBitmap);
  astr1 := ExtractFilepath(FName);      { force BMP extension }
  astr2 := ExtractFileName(Fname);
  i := pos('.', astr2);
  If i > 0 Then
    delete(astr2, i, 255);
  ChartBmp.SaveToFile(astr1 + astr2 + '.bmp');
  RcWindCol := RcWindColBak;
  RcScaleCol := RcScaleColBak;
  RcChartCol := RcChartColBak;
  Font.Color := RcFontColBak;
  AuxBitmap.Free;
End;


(******************************************************************)

Procedure TRChart.CopyToBitmap(ABitmap : TBitmap; BlkWhite : boolean);
(******************************************************************
  ENTRY:   ABitMap ..... bitmap which will contain the image
           BlkWhite .... if TRUE the image is copied in black and white
  EXIT:    bitmap ABitmap contains image of RChart
 ******************************************************************)

Var
  RcWindColBak,
    RcChartColBak,
    RcScaleColBak,
    RcFontColBak    : TColor;
  AuxBitmap         : TBitmap;

Begin
  If Abitmap <> Nil Then Begin
    AuxBitmap := TBitmap.Create;        { Create the working bitmap and set its width and height }
    AuxBitmap.Width := GrafBmp.Width;
    AuxBitmap.Height := GrafBmp.Height;
    RcWindColBak := RcWindCol;          { backup colors }
    RcScaleColBak := RcScaleCol;
    RcChartColBak := RcChartCol;
    RcFontColBak := Font.Color;
    If BlkWhite Then Begin
      RcWindCol := clwhite;
      RcChartCol := clwhite;
      RcScaleCol := clblack;
      Font.Color := clblack;
    End;
    ABitMap.Width := ChartBmp.Width;
    ABitMap.Height := ChartBmp.Height;
    ConstructChartBmp(ABitmap.Canvas);  { create chart }
    InitGraf(AuxBitmap.Canvas, 0, 0);
    ConstructDataBmp(AuxBitmap.Canvas, 0, 0, BlkWhite, RcFrstCan); { create data image }
    ABitmap.Canvas.Draw(RcLRim, RcTRim, AuxBitmap);
    RcWindCol := RcWindColBak;
    RcScaleCol := RcScaleColBak;
    RcChartCol := RcChartColBak;
    Font.Color := RcFontColBak;
    AuxBitmap.Free;
  End;
End;


(******************************************************************)

Procedure TRChart.CopyToWMF(FName : String);
(******************************************************************
  REMARK:  This function has testing status. Do not use it in production environments
  ENTRY:   FName ..... name of metafile file to be created
  EXIT:    file contains metafile copy of RChart
 ******************************************************************)

Const
  ScaleF            = 0.90;

Var
  astr1, astr2      : String;
  i                 : integer;
  WMFCanvas         : TCanvas;
  AuxWMF            : TMetaFile;
  Rect              : TRect;
  xpix, ypix        : longint;


Begin
  WMFCanvas := TCanvas.Create;
  Rect.Left := 0;
  Rect.Top := 0;
  Rect.Right := round({ScaleF*} 2540.0 * (Width - 1) / Screen.PixelsPerInch);
  Rect.Bottom := round({ScaleF*} 2540.0 * (Height - 1) / Screen.PixelsPerInch);
  WMFCanvas.Handle := CreateEnhMetafile(0, Nil, @Rect, Nil);

  xpix := GetDeviceCaps(WMFCanvas.Handle, LOGPIXELSX);
  ypix := GetDeviceCaps(WMFCanvas.Handle, LOGPIXELSY);
  SetMapMode(WMFCanvas.Handle, mm_isotropic); { use mapping to adjust size }
  SetWindowExtEx(WMFCanvas.Handle, Screen.PixelsPerInch, Screen.PixelsPerInch, Nil); { 32-Bit version }
  SetViewportExtEx(WMFCanvas.Handle, round(ScaleF * xpix), round(ScaleF * ypix), Nil);

  ConstructChartBmp(WMFCanvas);         // create chart
  InitGraf(WMFCanvas, RcLRim, RcTRim);
  ConstructDataBmp(WMFCanvas, RcLRim, RcTRim, false, RcFrstCan); // create data image
  astr1 := ExtractFilepath(FName);      // force WMF extension
  astr2 := ExtractFileName(Fname);
  i := pos('.', astr2);
  If i > 0 Then
    delete(astr2, i, 255);
  AuxWMF := TMetaFile.Create;
  AuxWMF.Handle := closeEnhMetafile(WMFCanvas.handle);
  AuxWMF.SaveToFile(astr1 + astr2 + '.wmf');
  AuxWMF.Free;
End;



(******************************************************************)

Procedure TRChart.PrintitHiRes(ScaleF : double; BlkWhite : boolean);
(******************************************************************
  ENTRY:   ScaleF ..... size scaling factor
           BlkWhite ... TRUE: black and white printout

  EXIT:    copy of RChart is printed with printer resolution
 ******************************************************************)

Var
  xpix, ypix        : longint;
  Rgn               : HRgn;
  x, y              : integer;
  PrtWidth          : longint;
  RcWindColBak,
    RcChartColBak,
    RcScaleColBak,
    RcFontColBak    : TColor;

Begin
  RcWindColBak := RcWindCol;            { backup colors }
  RcScaleColBak := RcScaleCol;
  RcChartColBak := RcChartCol;
  RcFontColBak := Font.Color;
  If BlkWhite Then Begin
    RcWindCol := clwhite;
    RcChartCol := clwhite;
    RcScaleCol := clblack;
    Font.Color := clblack;
  End;
  Printer.BeginDoc;                     { start printing }
  xpix := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
  ypix := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  PrtWidth := GetDeviceCaps(Printer.Handle, PHYSICALWIDTH);
  SetMapMode(Printer.Handle, mm_isotropic); { use mapping to adjust size }
  SetWindowExtEx(Printer.Handle, Screen.PixelsPerInch, Screen.PixelsPerInch, Nil); { 32-Bit version }
  SetViewportExtEx(Printer.Handle, round(ScaleF * xpix), round(ScaleF * ypix), Nil);
  x := (PrtWidth - round(Width / Screen.PixelsPerInch * ScaleF * xpix)) Div 2;
  If x < 0 Then
    x := 0;
  y := ypix Div 2;
  SetViewportOrgEx(Printer.Handle, x, y, Nil);
  ConstructChartBmp(Printer.Canvas);    { create chart }
  InitGraf(Printer.Canvas, RcLRim, RcTRim);

  Rgn := CreateRectRgn(x + round(ScaleF * xpix * RcLrim / Screen.PixelsPerInch), y + round(ScaleF * ypix * RcTrim / Screen.PixelsPerInch),
    x + round(ScaleF * xpix * (Width - RcRrim - Rc3DRim - 1) / Screen.PixelsPerInch), y + round(ScaleF * ypix * (Height - RcBrim - Rc3DRim - 1) / Screen.PixelsPerInch));
  SelectClipRgn(Printer.Canvas.Handle, Rgn);
  DeleteObject(Rgn);

  ConstructDataBmp(Printer.Canvas, RcLRim, RcTRim, false, RcFrstCan); { create data image }

  Printer.EndDoc;
  RcWindCol := RcWindColBak;
  RcScaleCol := RcScaleColBak;
  RcChartCol := RcChartColBak;
  Font.Color := RcFontColBak;
End;


(******************************************************************)

Procedure TRChart.CopyToOpenPrinterHiRes(Var x, y : integer; ScaleF : double; BlkWhite : boolean);
(******************************************************************
ENTRY: x,y ......... location where to print to (upper left corner
                     of the chart - in printer coordinates)
       ScaleF ...... scaling factor (1.0 delivers a hardcopy which is
                     approx. the same size as chart on the screen)

EXIT:  The chart is printed on the already open default printer. This
       procedure enables the user to mix text and graphics at will.
       The variable parameters x and y return the coordinates of the
       lower right corner of the printed chart
*******************************************************************)


Var
  xpix, ypix        : longint;
  Rgn               : HRgn;
  Origin            : TPoint;
  FontSize          : integer;
  FontName          : TFontName;
  FontStyle         : TFontStyles;
  FontCol           : TColor;
  RcWindColBak,
    RcChartColBak,
    RcScaleColBak,
    RcFontColBak    : TColor;

Begin
  RcWindColBak := RcWindCol;            { backup colors }
  RcScaleColBak := RcScaleCol;
  RcChartColBak := RcChartCol;
  RcFontColBak := Font.Color;
  If BlkWhite Then Begin
    RcWindCol := clwhite;
    RcChartCol := clwhite;
    RcScaleCol := clblack;
    Font.Color := clblack;
  End;
  FontStyle := Printer.Canvas.Font.Style;
  FontSize := Printer.Canvas.Font.Size;
  FontName := Printer.Canvas.Font.Name;
  FontCol := Printer.Canvas.Font.Color;
  xpix := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
  ypix := GetDeviceCaps(Printer.Handle, LOGPIXELSY);


  SetMapMode(Printer.Handle, mm_isotropic); { use mapping to adjust size }
  SetWindowExtEx(Printer.Handle, Screen.PixelsPerInch, Screen.PixelsPerInch, Nil); { 32-Bit version }
  SetViewportExtEx(Printer.Handle, round(ScaleF * xpix), round(ScaleF * ypix), Nil);

{$IFDEF VER90}                          { work around for type inconsistency among compiler versions }
  GetViewportOrgEx(Printer.Handle, @Origin);
{$ELSE}
{$IFDEF VER93}
  GetViewportOrgEx(Printer.Handle, @Origin);
{$ELSE}
  GetViewportOrgEx(Printer.Handle, Origin);
{$ENDIF}
{$ENDIF}

  SetViewportOrgEx(Printer.Handle, x, y, Nil);
  ConstructChartBmp(Printer.Canvas);    { create chart }
  InitGraf(Printer.Canvas, RcLRim, RcTRim);

  Rgn := CreateRectRgn(x + round(ScaleF * xpix * RcLrim / Screen.PixelsPerInch), y + round(ScaleF * ypix * RcTrim / Screen.PixelsPerInch),
    x + round(ScaleF * xpix * (Width - RcRrim - Rc3DRim - 1) / Screen.PixelsPerInch), y + round(ScaleF * ypix * (Height - RcBrim - Rc3DRim - 1) / Screen.PixelsPerInch));
  SelectClipRgn(Printer.Canvas.Handle, Rgn);
  DeleteObject(Rgn);
  ConstructDataBmp(Printer.Canvas, RcLRim, RcTRim, false, RcFrstCan); { create data image }
  Rgn := CreateRectRgn(0, 0, xpix * 9, ypix * 12); { restore clipping region }
  SelectClipRgn(Printer.Canvas.Handle, Rgn);
  DeleteObject(Rgn);

  SetWindowExtEx(Printer.Handle, Screen.PixelsPerInch, Screen.PixelsPerInch, Nil); { 32-Bit version }
  SetViewportExtEx(Printer.Handle, Screen.PixelsPerInch, Screen.PixelsPerInch, Nil);
  SetViewportOrgEx(Printer.Handle, Origin.x, Origin.y, Nil); { restore viewport }
  Printer.Canvas.Font.Name := FontName;
  Printer.Canvas.Font.Color := FontCol;
  Printer.Canvas.Font.Style := FontStyle;
  Printer.Canvas.Font.Size := FontSize;
  RcWindCol := RcWindColBak;
  RcScaleCol := RcScaleColBak;
  RcChartCol := RcChartColBak;
  Font.Color := RcFontColBak;
  x := x + round(Width / Screen.PixelsPerInch * ScaleF * xpix); { calculate coords of lower right corner }
  y := y + round(Height / Screen.PixelsPerInch * ScaleF * ypix);
End;






(******************************************************************)

Procedure TRCHart.R2M(xin, yin : double; Var xout, yout : longint);
(******************************************************************
ENTRY: xin, yin ..... coordinates of point in real world
       xout, yout ... virtual coordinates of this point

EXIT:  A point given in real coordinates is transformed into
       virtual screen coordinates.
*******************************************************************)

Var
  xtest             : double;
  ytest             : double;

Begin
  If RcXLog Then Begin
    If xin > SmallPosNum Then xtest := Cpkx * ln(xin) + CpDx
    Else Begin
      If RcBndHiX < RcBndLoX Then xtest := Width
      Else xtest := 0;
    End;
    If (xtest > MaxLongInt) Then
      xtest := MaxLongInt;
    If (xtest < -MaxLongInt) Then
      xtest := -MaxLongInt;
  End
  Else Begin
    xtest := Cpkx * Xin + CpDx;
    If (xtest > MaxLongInt) Then
      xtest := MaxLongInt;
    If (xtest < -MaxLongInt) Then
      xtest := -MaxLongInt;
  End;
  If RcYLog Then Begin
    If YIn > SmallPosNum Then ytest := Cpky * ln(Yin) + CpDy
    Else Begin
      If RcBndHiY < RcBndLoY Then ytest := 0
      Else ytest := Height;
    End;
    If (ytest > MaxLongInt) Then
      ytest := MaxLongInt;
    If (ytest < -MaxLongInt) Then
      ytest := -MaxLongInt;
  End
  Else Begin
    ytest := CpKy * yin + CpDy;
    If (ytest > MaxLongInt) Then
      ytest := MaxLongInt;
    If (ytest < -MaxLongInt) Then
      ytest := -MaxLongInt;
  End;
  xout := round(xtest);
  yout := round(ytest);
End;


(******************************************************************)

Procedure TRCHart.M2R(xin, yin : longint; Var xout, yout : double);
(******************************************************************
ENTRY: xin, yin ..... virtual coordinates of this point
       xout, yout ... coordinates of point in real world

EXIT:  A point given in virtual screen coordinates is transformed into
       real coordinates.
*******************************************************************)

Begin
  If RcXLog Then XOut := exp((xin - CpDx) / CpKx)
  Else XOut := (xin - CpDx) / CpKx;
  If RcYLog Then YOut := exp((yin - CpDy) / CpKy)
  Else YOut := (yin - CpDy) / CpKy;
End;




(***********************************************************************)

Procedure TRChart.AdjustScaling;
(***********************************************************************
ENTRY: coordinates of window corners (Dimension)
       extents of the real world (Bnd???)

EXIT:  The scaling system of this CHARTS-windows is calibrated
       according to the specified extents of the real world
(***********************************************************************)

Var
  MaskWidth         : integer;
  MaskHeight        : integer;

Begin
  If Not (csLoading In ComponentState) Then Begin
    MaskWidth := Width - RcLRim - RcRRim - Rc3DRim;
    MaskHeight := Height - RcTRim - RcBRim - Rc3DRim;
    If MaskWidth <= 0 { abscissa } Then Begin
      CpKx := 0;
      CpDx := Width / 2;
    End
    Else Begin
      If RcXLog { logarithmic } Then Begin
        CpKx := MaskWidth / (ln(RcBndHiX) - ln(RcBndLoX));
        CpDx := (RcLRim * ln(RcBndHiX) - (Width - RcRRim - Rc3DRim) * ln(RcBndLoX)) / (ln(RcBndHiX) - ln(RcBndLoX));
      End
      Else Begin                        { linear }
        CpKx := 1.0 / (RcBndHiX - RcBndLoX) * MaskWidth;
        CpDx := (RcLRim * RcBndHiX - (Width - RcRRim - Rc3DRim) * RcBndLoX) / (RcBndHiX - RcBndLoX);
      End;
    End;
    If MaskHeight <= 0 { ordinate } Then Begin
      CpKy := 0;
      CpDy := Height / 2;
    End
    Else Begin
      If RcYLog { logarithmic } Then Begin
        CpKy := -MaskHeight / (ln(RcBndHiY) - ln(RcBndLoY));
        CpDy := ((Height - RcBrim - Rc3DRim) * ln(RcBndHiY) - RcTRim * ln(RcBndLoY)) / (ln(RcBndHiY) - ln(RcBndLoY));
      End
      Else Begin                        { linear }
        CpKy := -MaskHeight / (RcBndHiY - RcBndLoY);
        CpDy := ((Height - RcBrim - Rc3DRim) * RcBndHiY - RcTRim * RcBndLoY) / (RcBndHiY - RcBndLoY);
      End;
    End;
  End;
End;



(*****************************************************************************)

Procedure TRChart.ShowYaxInternal(cv : TCanvas; XPos : integer; LowRange, HighRange : extended;
  NTicks, DecPlaces : integer; LabelType : FigType; LogAx : boolean;
  ScaleInscript : InscriptStr; UserTicktext : String;
  UnitLabel : LabelStr; StoreTickPos : boolean; OrientationLeft : boolean;
  LblPosX, LblPosY : integer; Mashtab : extended);
(*****************************************************************************)


Const                                   (* time scale parameters *)
  NDist             = 28;
  MsecIx            = 9;
  FigDist           : Array[0..Ndist] Of double =
    (0, 0.001, 0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 30, 60, 120, 180, 300, 600, 1200,
    1800, 3600, 7200, 14400, 21600, 43200, 86400);
  YaxTick           = 6;

Var
  m                 : integer;
  th, tw            : integer;
  TTspace           : extended;
  Divisor           : word;
  Dist              : extended;
  LoY               : extended;
  BLY, BHY          : extended;
  AuxStr            : ShortStr;
  x1, y1            : longint;
  TimTst            : boolean;
  nt                : integer;
  CurrentTickPos    : extended;
  ScaleType         : TScaleType;


  Procedure NumLinYax;
(*................*)

  Var
    i               : integer;
    Sign            : integer;

  Begin
    //MashTab := 1;
    LowRange := LowRange / Mashtab;
    HighRange := HighRange / Mashtab;

    CalcScalePars(NTicks, LowRange, HighRange, LoY, Dist, Divisor);

    If HighRange > LowRange Then Sign := 1
    Else Sign := -1;
    m := CalcM(DecPlaces, LowRange, HighRange);
    i := 0;
    th := CV.TextHeight('0');

    Repeat

      CurrentTickPos := (LoY + i * dist) * Mashtab;

      If FYTickPosCnt < MaxTickPos Then Begin
        inc(FYTickPosCnt);
        If StoreTickPos Then
          FYScaleTickPos[FYTickPosCnt] := CurrentTickPos;
      End;
      R2M(1, CurrentTickPos, x1, y1);
      x1 := XPos;
      CV.MoveTo(x1, y1);
      If OrientationLeft Then Cv.LineTo(x1 - YaxTick, y1)
      Else Cv.LineTo(x1 + YaxTick, y1);
      If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
        FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
      If LabelType <> ftNoFigs Then Begin
        If (abs(CurrentTickPos / (RcBndHiY - RcBndLoY)) < 1E-14) Then Begin
          CurrentTickPos := 0;
          If (abs(HighRange - LowRange) > 1E5) Then Begin
            If (m = 0) Then AuxStr := '0'
            Else AuxStr := '0.0';
          End Else
            AuxStr := RCSpecStrf(CurrentTickPos, 1, m);
        End Else
          AuxStr := RCSpecStrf(CurrentTickPos / Mashtab, 1, m);
        If length(AuxStr) > 14 Then
          AuxStr := copy(AuxStr, 1, 14);

        If LabelType = ftUserText Then AuxStr := ExtractUserText(UserTickText, i + 1)
        Else AuxStr := AddScaleInscription(AuxStr, ScaleInscript);
        tw := CV.TextWidth(AuxStr);
        If OrientationLeft Then CV.TextOut(x1 - YaxTick - tw - 2, y1 - th Div 2, AuxStr)
        Else CV.TextOut(x1 + YaxTick + 2, y1 - th Div 2, AuxStr);
      End;
      inc(i);
    Until Sign * (LoY + i * Dist - HighRange) > Sign * 0.001 * Dist;
  End;


  Procedure NumLogYax;
(*................*)

  Var
    LgRange         : extended;
    Use2510         : boolean;
    Mult            : extended;
    RcLoY           : extended;
    RcHiY           : extended;
    LabCnt          : integer;

    Procedure OneLabel(MultiP : extended; TickOnly : boolean);
(*. . . . . . . . . . . . . . . . . . . . . . . . . . *)

    Var
      ix            : integer;

    Begin
      If (Multip * LoY * Mult / QSave > RcLoY) And (QSave * Multip * LoY * Mult < RcHiY) Then Begin
        If FYTickPosCnt < MaxTickPos Then Begin
          inc(FYTickPosCnt);
          If StoreTickPos Then
            FYScaleTickPos[FYTickPosCnt] := Multip * LoY * Mult;
        End;
        R2M(1, Multip * LoY * Mult, x1, y1);
        x1 := XPos;
        CV.MoveTo(x1, y1);
        If OrientationLeft Then Cv.LineTo(x1 - YaxTick, y1)
        Else Cv.LineTo(x1 + YaxTick, y1);
        If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
          FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
        If (LabelType <> ftNoFigs) And Not TickOnly Then Begin
          If m = -3 Then Begin
            If round(Multip) = 1 Then AuxStr := RCSpecStrf(round(ln(LoY * Mult) / ln10), 1, 0)
            Else AuxStr := '';
          End
          Else AuxStr := RCSpecStrf(Multip * LoY * Mult, 1, m);
          If length(AuxStr) > 14 Then
            AuxStr := copy(AuxStr, 1, 14);
          If (DecPlaces = -2) And (pos('.', AuxStr) > 0) Then { remove trailing zeroes }  Begin
            ix := length(AuxStr);
            While AuxStr[ix] = '0' Do
              dec(ix);
            If AuxStr[ix] = '.' Then
              dec(ix);
            AuxStr := copy(AuxStr, 1, ix);
          End;
          inc(LabCnt);
          If LabelType = ftUserText Then AuxStr := ExtractUserText(UserTickText, LabCnt)
          Else AuxStr := AddScaleInscription(AuxStr, ScaleInscript);
          tw := CV.TextWidth(AuxStr);
          If OrientationLeft Then CV.TextOut(x1 - YaxTick - tw - 2, y1 - th Div 2, AuxStr)
          Else CV.TextOut(x1 + YaxTick + 2, y1 - th Div 2, AuxStr);
        End;
      End;
    End;

  Var
    i               : integer;

  Begin

    LabCnt := 0;
    LgRange := ln(HighRange / LowRange) / ln10;
    If abs(LgRange) < 1.0 Then
      NumLinYax                         { display lin. style scale if range below one order of magnitude }
    Else Begin                          { display logarithmic style scale }
      If abs(LgRange) + 0.5 < NTicks Then
        Use2510 := true
      Else
        use2510 := false;
      If HighRange > LowRange Then Begin
        RcLoy := LowRange;
        RcHiy := HighRange;
      End Else Begin
        RcHiy := LowRange;
        RcLoy := HighRange;
      End;
      m := CalcLogM(DecPlaces, RcLoY, RcHiY);
      th := CV.TextHeight('0');
      LoY := IntNeg(ln(RcLoY * QSave) / ln10);
      LoY := exp(ln10 * loY);
      Mult := 1.0;
      Repeat
        OneLabel(1.0, false);
        If Use2510 Then Begin
          For i := 2 To 9 Do
            If (i = 2) Or (i = 5) Then
              OneLabel(i, false)
            Else Begin
              If RcShortTicksY Then
                OneLabel(i, true);
            End;
        End;
        Mult := Mult * 10;
      Until QSave * LoY * Mult > RcHiY;
    End;
  End;



  Function TimeYax : boolean;
(*......................*)


  Var
    tt              : boolean;
    i               : integer;
    RngIx           : integer;
    Sign            : integer;

  Begin
    tt := false;
    RngIx := ndist;
    nt := NTicks;
    If HighRange > LowRange Then Sign := 1
    Else Sign := -1;
    While ((FigDist[RngIx] > abs(HighRange - LowRange) / NT) And (RngIx > 0)) Do
      dec(RngIx);
    th := CV.TextHeight('0');
    If ((RngIx < NDist) And (RngIx > 0)) Then Begin
      Tt := True;
      TTSpace := Sign * FigDist[RngIx];
      Nt := trunc((HighRange - LowRange) / TTSpace) + 5;
      LoY := TTSpace * (int(LowRange / TTSpace / QSave));
      If LowRange < 0 Then BLY := LowRange / QSave
      Else BLY := LowRange * QSave;
      If HighRange > 0 Then BHY := HighRange / QSave
      Else BHY := HighRange * Qsave;
      For i := 0 To NT Do Begin
        CurrentTickPos := LoY + i * TTSpace;
        If (Sign * CurrentTickPos >= Sign * BLY) And (Sign * CurrentTickPos <= Sign * BHY) Then Begin
          If FYTickPosCnt < MaxTickPos Then Begin
            inc(FYTickPosCnt);
            If StoreTickPos Then
              FYScaleTickPos[FYTickPosCnt] := LoY + i * TTSpace;
          End;
          R2M(1, LoY + i * TTSpace, x1, y1);
          x1 := XPos;
          cv.MoveTo(x1, y1);
          If OrientationLeft Then CV.LineTo(x1 - YaxTick, y1)
          Else CV.LineTo(x1 + YaxTick, y1);
          If RngIx <= MsecIx Then AuxStr := TimeString(LoY + i * TTspace, true)
          Else AuxStr := TimeString(LoY + i * TTspace, false);
          tw := CV.TextWidth(AuxStr);
          If OrientationLeft Then CV.TextOut(x1 - YaxTick - tw - 2, y1 - th Div 2, AuxStr)
          Else CV.TextOut(x1 + YaxTick + 2, y1 - th Div 2, AuxStr);
          If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
            FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
        End;
      End;
    End;
    TimeYax := tt;
  End;



  Procedure DateTimeYax;
(*..................*)

  Const
    MaxStepGrids    = 3;
    MaxStepNum      = 6;
    StepGrids       : Array[1..MaxStepGrids, 1..MaxStepNum] Of integer =
      ((1, 2, 3, 6, 8, 12), (1, 2, 5, 10, 20, 30), (1, 2, 3, 7, 14, 28));

  Var
    TimeRange       : extended;
    FirstTick       : extended;
    Step            : extended;
    bstr            : String;
    MonthString     : String[5];
    YearString      : String[5];
    LastDay         : integer;
    yy, mm, dd      : word;


    Function FindStep(StepGridIx : integer; Range, Multiplier : extended;
      Var FirstTick : extended) : extended;
(*.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . *)

{ StepGridIx .... type of step grid to apply
  Range ......... raw distance between two ticks
  Multiplier .... to get integer values
  FirstTick ..... DateTime of lower left corner

  function returns "best" integer distance between ticks
  FirstTick ..... position of first tick }


    Var
      st            : extended;
      ix            : integer;
      aint          : longint;
      days          : extended;

    Begin
      st := Range * Multiplier;
      ix := MaxStepNum;
      While ((StepGrids[StepGridIx, ix] > st) And (ix > 1)) Do
        dec(ix);
      days := intNeg(LowRange);
      If LowRange < 0 Then aint := intPos((1 + frac(LowRange)) * Multiplier)
      Else aint := intPos(frac(LowRange) * Multiplier);
      If aint <> 0 Then Begin
        aint := StepGrids[StepGridIx, ix] - (aint Mod StepGrids[StepGridIx, ix]);
        If aint = StepGrids[StepGridIx, ix] Then
          aint := 0;
      End;
      If LowRange < 0 Then FirstTick := days + intPos((1 + frac(LowRange)) * Multiplier + aint) / Multiplier
      Else FirstTick := days + intPos(frac(LowRange) * Multiplier + aint) / Multiplier;
      FindStep := StepGrids[StepGridIx, ix] / Multiplier;
    End;



    Procedure AboveYearInscription;
(*. . . . . . . . . . . . . . *)


    Var
      a, b          : extended;
      c             : integer;
      ystep         : longint;
      x1, y1        : longint;
      yy, mm, dd    : word;
      yy1           : word;

    Begin
      DecodeDate(LowRange, yy, mm, dd);
      a := (HighRange - LowRange) / 365.25 / NTicks;
      If a < 1 Then
        a := 1;
      a := ln(a) / ln10;

      b := exp(frac(a) * ln10);
      a := int(a);
      If b < 2 Then c := 1
      Else Begin
        If b < 5 Then c := 2
        Else c := 5;
      End;
      ystep := round(int(exp(a * ln10)) * c);

      yy1 := (((yy - 1) Div ystep) + 1) * ystep;
      If (yy1 = yy) And ((mm > 1) Or (dd > 1)) Then
        yy1 := yy1 + ystep;
      FirstTick := encodeDate(yy1, 1, 1);

      While (FirstTick - HighRange < 1E-8) Do Begin
        Case FDTYFormat.YearLength Of
          ylNone : bstr := '';
          ylYY : bstr := FormatDateTimeSDL('yy', FirstTick);
          ylYYYY : Begin
              bstr := FormatDateTimeSDL('yyyy', FirstTick);
              If length(bstr) > 0 Then Begin
                While bstr[1] = '0' Do
                  delete(bstr, 1, 1);
              End;
            End;
        End;
        If FYTickPosCnt < MaxTickPos Then Begin
          inc(FYTickPosCnt);
          If StoreTickPos Then
            FYScaleTickPos[FYTickPosCnt] := FirstTick;
        End;
        R2M(1, FirstTick, x1, y1);
        x1 := XPos;
        CV.MoveTo(x1, y1);
        If OrientationLeft Then CV.LineTo(x1 - YaxTick, y1)
        Else CV.LineTo(x1 + YaxTick, y1);
        tw := CV.TextWidth(bStr);
        th := CV.TextHeight(bStr) Div 2;
        If OrientationLeft Then Cv.TextOut(x1 - tw - YaxTick - 2, y1 - th, bStr)
        Else Cv.TextOut(x1 + YaxTick + 2, y1 - th, bStr);
        If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
          FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
        DecodeDate(FirstTick, yy, mm, dd);
        yy := yy + ystep;
        If yy > 9999 Then Begin
          yy := 9999;
          mm := 12;
          dd := 31;
        End;
        FirstTick := EncodeDate(yy, mm, dd);
      End;
    End;


    Procedure MonthToYearInscription;
(*. . . . . . . . . . . . . . .*)

    Var
      x1, y1        : longint;
      yy, mm, dd    : word;
      yy1           : word;
      mm1           : extended;
      ix            : integer;

    Begin
      DecodeDate(LowRange, yy, mm, dd);
      mm1 := (HighRange - LowRange) / 30.4375 / NTicks;
      ix := 5;
      While ((StepGrids[1, ix] > mm1) And (ix > 1)) Do
        dec(ix);

      If StepGrids[1, ix] > 1 Then Begin
        Repeat
          inc(mm);
          If mm > 12 Then Begin
            mm := 1;
            inc(yy);
          End;
        Until (mm Mod StepGrids[1, ix] = 1);
      End;
      dd := 1;
      FirstTick := EncodeDate(yy, mm, dd);

      If FDTYFormat.MonthName Then MonthString := 'mmm'
      Else MonthString := 'mm';
      Case FDTYFormat.YearLength Of
        ylNone : YearString := '';
        ylYYYY : YearString := 'yyyy';
        ylYY : YearSTring := 'yy';
      End;

      While (FirstTick - HighRange < 1E-8) Do Begin
        Case FDTYFormat.DateOrder Of
          doDDMMYY : bstr := FormatDateTimeSDL(MonthString + '"' + FDTYFormat.DateSeparator +
              '"' + YearString, FirstTick);
          doMMDDYY : bstr := FormatDateTimeSDL(MonthString + '"' + FDTYFormat.DateSeparator +
              '"' + YearString, FirstTick);
          doYYMMDD : bstr := FormatDateTimeSDL(YearString + '"' + FDTYFormat.DateSeparator +
              '"' + MonthString, FirstTick);
        End;
        If FirstTick >= LowRange Then Begin
          If FYTickPosCnt < MaxTickPos Then Begin
            inc(FYTickPosCnt);
            If StoreTickPos Then
              FYScaleTickPos[FYTickPosCnt] := FirstTick;
          End;
          R2M(1, FirstTick, x1, y1);
          x1 := XPos;
          CV.MoveTo(x1, y1);
          If OrientationLeft Then CV.LineTo(x1 - YaxTick, y1)
          Else CV.LineTo(x1 + YaxTick, y1);
          tw := CV.TextWidth(bStr);
          th := CV.TextHeight(bStr) Div 2;
          If OrientationLeft Then Cv.TextOut(x1 - tw - YaxTick - 2, y1 - th, bStr)
          Else Cv.TextOut(x1 + YaxTick + 2, y1 - th, bStr);
          If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
            FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
        End;
        DecodeDate(FirstTick, yy, mm, dd);
        mm := mm + StepGrids[1, ix];
        If mm > 12 Then Begin
          yy1 := (mm - 1) Div 12;
          mm := 1 + ((mm - 1) Mod 12);
          inc(yy, yy1);
        End;
        FirstTick := EncodeDate(yy, mm, dd);
      End;
    End;



    Procedure DayToMonthInscription;
(*. . . . . . . . . . . . . . .*)

    Var
      x1, y1        : longint;
      mm1           : extended;
      ix            : integer;
      Jan01         : extended;

    Begin
      DecodeDate(LowRange, yy, mm, dd);
      mm1 := (HighRange - LowRange) / NTicks;
      ix := MaxStepNum;
      While ((StepGrids[3, ix] > mm1) And (ix > 1)) Do
        dec(ix);
      Jan01 := encodeDate(yy, 1, 1);
      dd := (trunc(LowRange - Jan01) Div StepGrids[3, ix]) * StepGrids[3, ix];
      FirstTick := Jan01 + dd;
      Step := StepGrids[3, ix];
      If FDTYFormat.MonthName Then MonthString := 'mmm'
      Else MonthString := 'mm';
      Case FDTYFormat.YearLength Of
        ylNone : YearString := '';
        ylYYYY : YearString := 'yyyy';
        ylYY : YearSTring := 'yy';
      End;
      While (FirstTick - HighRange < 1E-8) Do Begin
        Case FDTYFormat.DateOrder Of
          doDDMMYY : bstr := FormatDateTimeSDL('dd"' + FDTYFormat.DateSeparator + '"' +
              MonthString + '"' + FDTYFormat.DateSeparator +
              '"' + YearString, FirstTick);
          doMMDDYY : bstr := FormatDateTimeSDL(MonthString + '"' + FDTYFormat.DateSeparator +
              '"dd"' + FDTYFormat.DateSeparator +
              '"' + YearString, FirstTick);
          doYYMMDD : bstr := FormatDateTimeSDL(YearString + '"' + FDTYFormat.DateSeparator +
              '"' + MonthString + '"' +
              FDTYFormat.DateSeparator + '"dd', FirstTick);
        End;
        If (FirstTick >= LowRange) Then Begin
          If FYTickPosCnt < MaxTickPos Then Begin
            inc(FYTickPosCnt);
            If StoreTickPos Then
              FYScaleTickPos[FYTickPosCnt] := FirstTick;
          End;
          R2M(1, FirstTick, x1, y1);
          x1 := XPos;
          CV.MoveTo(x1, y1);
          If OrientationLeft Then CV.LineTo(x1 - YaxTick, y1)
          Else CV.LineTo(x1 + YaxTick, y1);
          tw := CV.TextWidth(bStr);
          th := CV.TextHeight(bStr) Div 2;
          If OrientationLeft Then Cv.TextOut(x1 - tw - YaxTick - 2, y1 - th, bStr)
          Else Cv.TextOut(x1 + YaxTick + 2, y1 - th, bStr);
          If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
            FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
        End;
        FirstTick := FirstTick + Step;
      End;
    End;


    Procedure DisplayDate(x, y : longint);
(*  .   .   .   .   .   .   .   .   *)

    Begin
      bstr := FormatDateStr(FirstTick, FDTYFormat.MonthName,
        FDTYFormat.YearLength, FDTYFormat.DateOrder,
        FDTYFormat.DateSeparator);
      tw := CV.TextWidth(bStr);
      th := CV.TextHeight(bStr) Div 2;
      Case FDTYFormat.DateForTime Of
        dtOnePerChart : Begin
            If LastDay < 0 Then Begin
              If OrientationLeft Then Cv.TextOut(x - tw - YaxTick - 2, y - 3 * th, bStr)
              Else Cv.TextOut(x + YaxTick + 2, y - 3 * th, bStr);
              LastDay := dd;
            End
          End;
        dtOnePerDay : Begin
            If LastDay <> dd Then Begin
              If OrientationLeft Then Cv.TextOut(x - tw - YaxTick - 2, y - 3 * th, bStr)
              Else Cv.TextOut(x + YaxTick + 2, y - 3 * th, bStr);
              LastDay := dd;
            End
          End;
        dtAllTicks : Begin
            If OrientationLeft Then Cv.TextOut(x - tw - YaxTick - 2, y - 3 * th, bStr)
            Else Cv.TextOut(x + YaxTick + 2, y - 3 * th, bStr);
          End;
      End;
    End;


    Procedure BelowOneDayInscription(Mode : integer);
(*. . . . . . . . . . . . . . . . . . . . . . .*)
(* mode = 1 ..... HourToDay
          2 ..... MinuteToHour
          3 ..... SecondToMinute *)

    Var
      x1, y1        : longint;

    Begin
      FirstTick := LowRange;
      Case Mode Of
        1 : Step := FindStep(1, TimeRange, 24, FirstTick);
        2 : Step := FindStep(2, TimeRange, 1440, FirstTick);
        3 : Step := FindStep(2, TimeRange, 86400, FirstTick);
      End;
      LastDay := -1;
      While (FirstTick - HighRange < 1E-8) Do Begin
        DecodeDate(FirstTick, yy, mm, dd);
        Case Mode Of
          1 : Case FDTYFormat.TimeFormat Of
              tfHHMMSS : bstr := FormatDateTimeSDL('hh":"nn', FirstTick);
              tfAMPM : bstr := FormatDateTimeSDL('ham/pm', FirstTick);
              tfHHhMM : bstr := FormatDateTimeSDL('h"h"', FirstTick);
            End;
          2 : Case FDTYFormat.TimeFormat Of
              tfHHMMSS : bstr := FormatDateTimeSDL('hh":"nn', FirstTick);
              tfAMPM : bstr := FormatDateTimeSDL('h":"nnam/pm', FirstTick);
              tfHHhMM : bstr := FormatDateTimeSDL('h"h"nn', FirstTick);
            End;
          3 : Case FDTYFormat.TimeFormat Of
              tfHHMMSS : bstr := FormatDateTimeSDL('hh":"nn":"ss', FirstTick);
              tfAMPM : bstr := FormatDateTimeSDL('h":"nn"."ssam/pm', FirstTick);
              tfHHhMM : bstr := FormatDateTimeSDL('h"h"nn":"ss', FirstTick);
            End;
        End;
        If FYTickPosCnt < MaxTickPos Then Begin
          inc(FYTickPosCnt);
          If StoreTickPos Then
            FYScaleTickPos[FYTickPosCnt] := FirstTick;
        End;
        R2M(1, FirstTick, x1, y1);
        x1 := XPos;
        CV.MoveTo(x1, y1);
        If OrientationLeft Then CV.LineTo(x1 - YaxTick, y1)
        Else CV.LineTo(x1 + YaxTick, y1);
        tw := CV.TextWidth(bStr);
        th := CV.TextHeight(bStr) Div 2;
        If OrientationLeft Then Cv.TextOut(x1 - tw - YaxTick - 2, y1 - th, bStr)
        Else Cv.TextOut(x1 + YaxTick + 2, y1 - th, bStr);
        If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
          FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
        DisplayDate(x1, y1);
        FirstTick := FirstTick + Step;
      End;
    End;



  Begin                                 { DateTimeYax }

    If (HighRange < LowRange) Or (LowRange < -693593) Or (HighRange > 3E6) Then Begin
      R2M(1, (LowRange + HighRange) / 2, x1, y1);
      x1 := XPos;
      th := cv.TextHeight('T');
      If OrientationLeft Then Begin
        Cv.TextOut(x1 - cv.TextWidth('invalid') - 2, y1 - th, 'invalid');
        Cv.TextOut(x1 - cv.TextWidth('DateTime') - 2, y1, 'DateTime');
        Cv.TextOut(x1 - cv.TextWidth('scale') - 2, y1 + th, 'scale');
      End
      Else Begin
        Cv.TextOut(x1 + 2, y1 - th, 'invalid');
        Cv.TextOut(x1 + 2, y1, 'DateTime');
        Cv.TextOut(x1 + 2, y1 + th, 'scale');
      End;
    End
    Else Begin
      TimeRange := (HighRange - LowRange) / NTicks; { check for time resolution }
      If TimeRange <= 1.1574E-5 Then Begin { range is below 1 sec }
        R2M(1, (LowRange + HighRange) / 2, x1, y1);
        x1 := XPos;
        th := cv.TextHeight('T');
        If OrientationLeft Then Begin
          Cv.TextOut(x1 - cv.TextWidth('DateTime') - 2, y1 - th, 'DateTime');
          Cv.TextOut(x1 - cv.TextWidth('range is') - 2, y1, 'range is');
          Cv.TextOut(x1 - cv.TextWidth('below 1') - 2, y1 + th, 'below 1');
          Cv.TextOut(x1 - cv.TextWidth('second') - 2, y1 + 2 * th, 'second');
        End
        Else Begin
          Cv.TextOut(x1 + 2, y1 - th, 'DateTime');
          Cv.TextOut(x1 + 2, y1, 'range is');
          Cv.TextOut(x1 + 2, y1 + th, 'below 1');
          Cv.TextOut(x1 + 2, y1 + 2 * th, 'second');
        End;
      End
      Else Begin
        If TimeRange <= 6.9444E-4 Then BelowOneDayInscription(3) { range is 1 second to 1 minute }
        Else Begin
          If TimeRange <= 4.1667E-2 Then BelowOneDayInscription(2) { range is 1 minute to 1 hour }
          Else Begin
            If TimeRange <= 1.0 Then BelowOneDayInscription(1) { range is 1 hour to 1 day }
            Else Begin
              If TimeRange <= 30.0 Then Begin { range is 1 day to 1 month }
                DayToMonthInscription;  { 1,7,30(28,31) }
              End
              Else Begin
                If TimeRange <= 366.0 Then Begin { range is 1 month to 1 year }
                  MonthToYearInscription; { 1,2,3,6,12 }
                End
                Else Begin              { range is more than one year }
                  AboveYearInscription  { 1,2,5,10,... }
                End
              End
            End
          End
        End
      End;
    End;
  End;




Begin                                   { ShowYaxInternal }
  If OrientationLeft Then ScaleType := sctYL
  Else ScaleType := sctYR;

   { the following six lines are a work around for a nasty Windows bug
     which causes the printer fonts to be scaled improperly (sometimes);
     following the motto: beat dirty bugs with dirty tricks - sorry }
  If cv = Printer.Canvas Then Begin
    cv.Font.PixelsPerInch := Screen.PixelsPerInch;
    cv.Font.Size := Font.Size;
    cv.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  End;

  TimTst := false;
  If LabelType = ftDateTime Then DateTimeYax
  Else Begin
    If LabelType = ftTime Then
      TimTst := TimeYax;
    If Not timtst Then Begin
      If LogAx Then NumLogYax
      Else NumLinYax;
    End;
  End;
  If length(UnitLabel) <> 0 Then Begin
    AuxStr := UnitLabel;
    Cv.TextOut(LblPosX, LblPosY, AuxStr);
  End;
(*
if length (UnitLabel) <> 0 then
  begin
  AuxStr := UnitLabel;
  th := CV.TextHeight (AuxStr);
  tw := CV.TextWidth (AuxStr);
  case FXaxPos of
       xapTop : Cv.TextOut (XPos-4-tw,Height-RcBRim-th,AuxStr);
      xapBoth : Cv.TextOut (XPos-4-tw,Height-RcBRim-th,AuxStr);
    xapBottom : Cv.TextOut (XPos-4-tw,RcTRim-th-(th div 2),AuxStr);
  end;
  end;

*)
End;


(***********************************************************************)

Procedure TRChart.ConstructChartBmp(cv : TCanvas);
(***********************************************************************)

  Procedure ShowXax;
(*--------------*)


  Const
    NDist           = 28;               (* parameters for time scale *)
    MSecIx          = 9;
    FigDist         : Array[0..Ndist] Of double =
      (0, 0.001, 0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2,
      5, 10, 20, 30, 60, 120, 180, 300, 600, 1200,
      1800, 3600, 7200, 14400, 21600, 43200, 86400);
    FigNtick        : Array[1..Ndist] Of integer =
      (5, 4, 5, 5, 4, 5, 5, 4, 5, 5, 4,
      5, 5, 4, 6, 6, 6, 6, 5, 5, 6, 6, 6, 4, 4, 6, 6, 6);
    LongTick        = 7;                { length of long tick on scale }
    ShortTick       = 4;                { length of short tick on scale }


  Var
    m               : integer;
    th, tw          : integer;
    TlSpace         : extended;
    Divisor         : word;
    d, e            : extended;
    TTSpace         : extended;
    Dist            : extended;
    LoX             : extended;
    BLX, BHX        : extended;
    AuxStr          : ShortStr;
    x1, y1          : longint;
    TimTst          : boolean;
    Low             : extended;
    nt              : integer;
    CurrentTickPos  : extended;
    ScaleType       : TScaleType;

    Procedure NumLinXax;
(*................*)

    Var
      i             : integer;
      Sign          : integer;

    Begin
      CalcScalePars(RcXNtick, RcBndLoX, RcBndHiX, LoX, Dist, Divisor);
      TTSpace := Dist / Divisor;
      If RcBndHiX > RcBndLoX Then Sign := 1
      Else Sign := -1;
      If Sign * RcBndHix > 0 Then BHX := RcBndHiX / QSave
      Else BHX := RcBndHiX * QSave;

      If RcShortTicksX Then Begin
        low := LoX - Dist;
        i := 0;
        Repeat                          { short scale ticks }
          CurrentTickPos := Low + i * TTSpace;
          If (Sign * CurrentTickPos >= Sign * RcBndLoX) Then Begin
            If FXTickPosCnt < MaxTickPos Then Begin
              inc(FXTickPosCnt);
              FXScaleTickPos[FXTickPosCnt] := CurrentTickPos;
            End;
            R2M(CurrentTickPos, RcBndLoY, x1, y1);
            CV.MoveTo(x1, y1);
            CV.LineTo(x1, y1 + ShortTick);
            If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
              FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
          End;
          inc(i);
        Until Sign * (Low + i * TTSpace - RcBndHiX) > 0.001 * TTSpace;
      End;

      m := CalcM(RcDecPlcX, RcBndloX, RcBndHiX);
      i := 0;
      Repeat                            { long scale ticks + inscription }
        CurrentTickPos := LoX + i * Dist;
        If Not RcShortTicksX Then
          If FXTickPosCnt < MaxTickPos Then Begin
            inc(FXTickPosCnt);
            FXScaleTickPos[FXTickPosCnt] := CurrentTickPos;
          End;
        R2M(CurrentTickPos, RcBndLoY, x1, y1);
        CV.MoveTo(x1, y1);
        CV.LineTo(x1, y1 + LongTick);
        If (RcXLabelType <> ftNoFigs) Then Begin
          If (abs(CurrentTickPos / (RcBndHiX - RcBndLoX)) < 1E-14) Then Begin
            CurrentTickPos := 0;
            If (abs(RcBndHiX - RcBndLoX) > 1E5) Then Begin
              If (m = 0) Then AuxStr := '0'
              Else AuxStr := '0.0'
            End
            Else AuxStr := RCSpecStrf(CurrentTickPos, 1, m);
          End
          Else AuxStr := RCSpecStrf(CurrentTickPos, 1, m);
          If length(AuxStr) > 14 Then
            AuxStr := copy(AuxStr, 1, 14);

          If RcXLabelType = ftUserText Then AuxStr := ExtractUserText(FUserTickTextX, i + 1)
          Else AuxStr := AddScaleInscription(AuxStr, RcScaleInscrX);
          tw := CV.TextWidth(AuxStr) Div 2;
          If x1 + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 + LongTick, AuxStr)
          Else Cv.TextOut(x1 - tw, y1 + LongTick, AuxStr);
        End;
        If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
          FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
        inc(i);
      Until Sign * (LoX + i * Dist - RcBndHiX) > 0.001 * Dist;
    End;



    Procedure NumLogXax;
(*................*)


    Var
      i             : integer;
      LgRange       : extended;
      Use2510       : boolean;
      Mult          : extended;
      RcLoX         : extended;
      RcHiX         : extended;
      LabCnt        : integer;

      Procedure OneLabel(MultiP : extended; TickOnly : boolean);
(*. . . . . . . . . . . . . . . . . . . . . . . . . . *)

      Var
        ix          : integer;

      Begin
        If (Multip * LoX * Mult / QSave > RcLoX) And (QSave * Multip * LoX * Mult < RcHiX) Then Begin
          If Not TickOnly Or (TickOnly And RcShortTicksX) Then
            If FXTickPosCnt < MaxTickPos Then Begin
              inc(FXTickPosCnt);
              FXScaleTickPos[FXTickPosCnt] := Multip * LoX * Mult;
            End;
          R2M(Multip * LoX * Mult, RcBndLoY, x1, y1);
          CV.MoveTo(x1, y1);
          If TickOnly Then Begin
            If RcShortTicksX Then
              Cv.LineTo(x1, y1 + ShortTick);
          End
          Else Cv.LineTo(x1, y1 + LongTick);
          If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
            FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
          If (RcXLabelType <> ftNoFigs) And Not TickOnly Then Begin
            If m = -3 Then Begin
              If round(Multip) = 1 Then AuxStr := RCSpecStrf(round(ln(LoX * Mult) / ln10), 1, 0)
              Else AuxStr := '';
            End
            Else AuxStr := RCSpecStrf(Multip * LoX * Mult, 1, m);
            If length(AuxStr) > 14 Then
              AuxStr := copy(AuxStr, 1, 14);
            If (RcDecplcX = -2) And (pos('.', AuxStr) > 0) Then { remove trailing zeroes }  Begin
              ix := length(AuxStr);
              While AuxStr[ix] = '0' Do
                dec(ix);
              If AuxStr[ix] = '.' Then
                dec(ix);
              AuxStr := copy(AuxStr, 1, ix);
            End;
            inc(LabCnt);
            If RcXLabelType = ftUserText Then AuxStr := ExtractUserText(FUserTickTextX, LabCnt)
            Else AuxStr := AddScaleInscription(AuxStr, RcScaleInscrX);
            tw := CV.TextWidth(AuxStr) Div 2;
            If x1 + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 + LongTick, AuxStr)
            Else Cv.TextOut(x1 - tw, y1 + LongTick, AuxStr);
          End;
        End;
      End;


    Begin
      LabCnt := 0;
      LgRange := ln(RcBndHiX / RcBndLoX) / ln10;
      If abs(LgRange) < 1.0 Then NumLinXax { display lin. style scale if range below one order of magnitude }
      Else Begin                        { display logarithmic style scale }
        If abs(LgRange) + 0.5 < RcXNTick Then Use2510 := true
        Else use2510 := false;
        If RcBndHiX > RcBndLoX Then Begin
          RcLoX := RcBndLoX;
          RcHiX := RcBndHiX;
        End
        Else Begin
          RcHiX := RcBndLoX;
          RcLoX := RcBndHiX;
        End;
        m := CalcLogM(RcDecPlcX, RcLoX, RcHiX);
        th := CV.TextHeight('0');
        LoX := IntNeg(ln(RcLoX * QSave) / ln10);
        LoX := exp(ln10 * loX);
        Mult := 1.0;
        Repeat
          OneLabel(1.0, false);
          If Use2510 Then Begin
            For i := 2 To 9 Do
              If (i = 2) Or (i = 5) Then OneLabel(i, false)
              Else OneLabel(i, true);
          End;
          Mult := Mult * 10;
        Until QSave * LoX * Mult > RcHiX;
      End;
    End;


    Function TimeXax : boolean;
(*......................*)

    Var
      tt            : boolean;
      i             : integer;
      Sign          : integer;
      RngIx         : integer;
      LastPos       : integer;

    Begin
      tt := false;
      RngIx := ndist;
      nt := RcXntick;
      If RcBndHiX > RcBndLoX Then Sign := 1
      Else Sign := -1;
      While ((FigDist[RngIx] > abs(RcBndHiX - RcBndLoX) / NT) And (RngIx > 0)) Do
        dec(RngIx);
      If ((RngIx < NDist) And (RngIx > 0)) Then Begin
        tt := True;
        TlSpace := Sign * FigDist[RngIx];
        TTSpace := Sign * FigDist[RngIx] / FigNTick[RngIx];
        Nt := trunc((RcBndHiX - RcBndLoX) / TTSpace) + 5;
        LoX := TLSpace * (intNeg(RcBndLoX / TLSpace / QSave));
        If RcBndLox < 0 Then BLX := RcBndLoX / QSave
        Else BLX := RcBndLoX * QSave;
        If RcBndHix > 0 Then BHX := RcBndHiX / QSave
        Else BHX := RcBndHiX * QSave;
        If RcShortTicksX Then Begin     { draw the short ticks }
          For i := 0 To NT Do Begin
            CurrentTickPos := LoX + i * TTSpace;
            If (Sign * CurrentTickPos >= Sign * BLX) And (Sign * CurrentTickPos <= Sign * BHX) Then Begin
              If FXTickPosCnt < MaxTickPos Then Begin
                inc(FXTickPosCnt);
                FXScaleTickPos[FXTickPosCnt] := CurrentTickPos;
              End;
              R2M(CurrentTickPos, RcBndLoY, x1, y1);
              CV.MoveTo(x1, y1);
              CV.LineTo(x1, y1 + ShortTick);
            End;
            If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
              FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
          End;
        End;

        LastPos := -10000;
        For i := 0 To Nt Do Begin
          CurrentTickPos := LoX + i * TTSpace;
          d := CurrentTickPos / TlSPace;
          If d < 0 Then e := d - 0.5
          Else e := d + 0.5;
          If abs(d - int(e)) < 0.01 Then
            If (Sign * CurrentTickPos >= Sign * BLX) And (Sign * CurrentTickPos <= Sign * BHX) Then Begin
              If Not RcShortTicksX Then
                If FXTickPosCnt < MaxTickPos Then Begin
                  inc(FXTickPosCnt);
                  FXScaleTickPos[FXTickPosCnt] := CurrentTickPos;
                End;
              R2M(CurrentTickPos, RcBndLoY, x1, y1);
              CV.MoveTo(x1, y1);
              CV.LineTo(x1, y1 + LongTick);
              If RngIx <= MsecIx Then AuxStr := TimeString(LoX + i * TTspace, true)
              Else AuxStr := TimeString(LoX + i * TTspace, false);
              tw := CV.TextWidth(AuxStr) Div 2;
              If LastPos < x1 - tw Then Begin
                If x1 + tw >= width - Rc3DRim Then
                  Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 + LongTick, AuxStr)
                Else
                  Cv.TextOut(x1 - tw, y1 + LongTick, AuxStr);
                LastPos := x1 + tw + 2;
              End;
              If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
                FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
            End;
        End;
      End;
      TimeXax := tt;
    End;

    Procedure DateTimeXax;
(*..................*)

    Const
      MaxStepGrids  = 3;
      MaxStepNum    = 6;
      StepGrids     : Array[1..MaxStepGrids, 1..MaxStepNum] Of integer =
        ((1, 2, 3, 6, 8, 12), (1, 2, 5, 10, 20, 30), (1, 2, 3, 7, 14, 28));


    Var
      TimeRange     : extended;
      FirstTick     : extended;
      Step          : extended;
      bstr          : String;
      MonthString   : String[5];
      YearString    : String[5];
      LastDay       : integer;
      yy, mm, dd    : word;


      Function FindStep(StepGridIx : integer; Range, Multiplier : extended;
        Var FirstTick : extended) : extended;
(*.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . *)

{ StepGridIx .... type of step grid to apply
  Range ......... raw distance between two ticks
  Multiplier .... to get integer values
  FirstTick ..... DateTime of lower left corner

  function returns "best" integer distance between ticks
  FirstTick ..... position of first tick }


      Var
        st          : extended;
        ix          : integer;
        aint        : longint;
        days        : extended;

      Begin
        st := Range * Multiplier;       { st = actual, scaled step size }
        ix := MaxStepNum;
        While ((StepGrids[StepGridIx, ix] > st) And (ix > 1)) Do
          dec(ix);                      { find the largest integer step size which fits into st }
        days := intNeg(RcBndLoX);
        If RcBndLoX < 0 Then aint := intPos((1 + frac(RcBndLoX)) * Multiplier)
        Else aint := intPos(frac(RcBndLoX) * Multiplier);
        If aint <> 0 Then Begin
          aint := StepGrids[StepGridIx, ix] - (aint Mod StepGrids[StepGridIx, ix]);
          If aint = StepGrids[StepGridIx, ix] Then
            aint := 0;
        End;
        If RcBndLoX < 0 Then FirstTick := days + intPos((1 + frac(RcBndLoX)) * Multiplier + aint) / Multiplier
        Else FirstTick := days + intPos(frac(RcBndLoX) * Multiplier + aint) / Multiplier;
        FindStep := StepGrids[StepGridIx, ix] / Multiplier;
      End;



      Procedure AboveYearInscription;
(*. . . . . . . . . . . . . . *)


      Var
        a, b        : extended;
        c           : integer;
        ystep       : longint;
        x1, y1      : longint;
        yy, mm, dd  : word;
        yy1         : word;

      Begin
        DecodeDate(RcBndLoX, yy, mm, dd);
        a := (RcBndHiX - RcBndLoX) / 365.25 / RcXNTick;
        If a < 1 Then
          a := 1;
        a := ln(a) / ln10;

        b := exp(frac(a) * ln10);
        a := int(a);
        If b < 2 Then c := 1
        Else Begin
          If b < 5 Then c := 2
          Else c := 5;
        End;
        ystep := round(int(exp(a * ln10)) * c);

        yy1 := (((yy - 1) Div ystep) + 1) * ystep;
        If (yy1 = yy) And ((mm > 1) Or (dd > 1)) Then
          yy1 := yy1 + ystep;
        FIrstTick := encodeDate(yy1, 1, 1);

        While (FirstTick - RcBndHiX < 1E-8) Do Begin
          Case FDTXFormat.YearLength Of
            ylNone : bstr := '';
            ylYY : bstr := FormatDateTimeSDL('yy', FirstTick);
            ylYYYY : Begin
                bstr := FormatDateTimeSDL('yyyy', FirstTick);
                If length(bstr) > 0 Then Begin
                  While bstr[1] = '0' Do
                    delete(bstr, 1, 1);
                End;
              End;
          End;
          If FXTickPosCnt < MaxTickPos Then Begin
            inc(FXTickPosCnt);
            FXScaleTickPos[FXTickPosCnt] := FirstTick;
          End;
          R2M(FirstTick, RcBndLoY, x1, y1);
          CV.MoveTo(x1, y1);
          CV.LineTo(x1, y1 + LongTick);
          tw := CV.TextWidth(bStr) Div 2;
          If x1 + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 + LongTick, bStr)
          Else Cv.TextOut(x1 - tw, y1 + LongTick, bStr);
          If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
            FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
          DecodeDate(FirstTick, yy, mm, dd);
          yy := yy + ystep;
          If yy > 9999 Then Begin
            yy := 9999;
            mm := 12;
            dd := 31;
          End;
          FirstTick := EncodeDate(yy, mm, dd);
        End;
      End;


      Procedure MonthToYearInscription;
(*. . . . . . . . . . . . . . .*)

      Var
        x1, y1      : longint;
        yy, mm, dd  : word;
        yy1         : word;
        mm1         : extended;
        ix          : integer;

      Begin
        DecodeDate(RcBndLoX, yy, mm, dd);
        mm1 := (RcBndHiX - RcBndLoX) / 30.4375 / RcXNTick;
        ix := 5;
        While ((StepGrids[1, ix] > mm1) And (ix > 1)) Do
          dec(ix);

        If StepGrids[1, ix] > 1 Then Begin
          Repeat
            inc(mm);
            If mm > 12 Then Begin
              mm := 1;
              inc(yy);
            End;
          Until (mm Mod StepGrids[1, ix] = 1);
        End;
        dd := 1;
        FirstTick := EncodeDate(yy, mm, dd);

        If FDTXFormat.MonthName Then MonthString := 'mmm'
        Else MonthString := 'mm';
        Case FDTXFormat.YearLength Of
          ylNone : YearString := '';
          ylYYYY : YearString := 'yyyy';
          ylYY : YearSTring := 'yy';
        End;

        While (FirstTick - RcBndHiX < 1E-8) Do Begin
          Case FDTXFormat.DateOrder Of
            doDDMMYY : bstr := FormatDateTimeSDL(MonthString + '"' + FDTXFormat.DateSeparator +
                '"' + YearString, FirstTick);
            doMMDDYY : bstr := FormatDateTimeSDL(MonthString + '"' + FDTXFormat.DateSeparator +
                '"' + YearString, FirstTick);
            doYYMMDD : bstr := FormatDateTimeSDL(YearString + '"' + FDTXFormat.DateSeparator +
                '"' + MonthString, FirstTick);
          End;
          If FirstTick >= RcBndLoX Then Begin
            If FXTickPosCnt < MaxTickPos Then Begin
              inc(FXTickPosCnt);
              FXScaleTickPos[FXTickPosCnt] := FirstTick;
            End;
            R2M(FirstTick, RcBndLoY, x1, y1);
            CV.MoveTo(x1, y1);
            CV.LineTo(x1, y1 + LongTick);
            tw := CV.TextWidth(bStr) Div 2;
            If x1 + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 + LongTick, bStr)
            Else Cv.TextOut(x1 - tw, y1 + LongTick, bStr);
            If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
              FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
          End;
          DecodeDate(FirstTick, yy, mm, dd);
          mm := mm + StepGrids[1, ix];
          If mm > 12 Then Begin
            yy1 := (mm - 1) Div 12;
            mm := 1 + ((mm - 1) Mod 12);
            inc(yy, yy1);
          End;
          FirstTick := EncodeDate(yy, mm, dd);
        End;
      End;



      Procedure DayToMonthInscription;
(*. . . . . . . . . . . . . . .*)

      Var
        x1, y1      : longint;
        mm1         : extended;
        ix          : integer;
        Jan01       : extended;

      Begin
        DecodeDate(RcBndLoX, yy, mm, dd);
        mm1 := (RcBndHiX - RcBndLoX) / RcXNTick;
        ix := MaxStepNum;
        While ((StepGrids[3, ix] > mm1) And (ix > 1)) Do
          dec(ix);
        Jan01 := encodeDate(yy, 1, 1);
        dd := (trunc(RcBndLoX - Jan01) Div StepGrids[3, ix]) * StepGrids[3, ix];
        FirstTick := Jan01 + dd;
        Step := StepGrids[3, ix];
        If FDTXFormat.MonthName Then MonthString := 'mmm'
        Else MonthString := 'mm';
        Case FDTXFormat.YearLength Of
          ylNone : YearString := '';
          ylYYYY : YearString := 'yyyy';
          ylYY : YearSTring := 'yy';
        End;
        While (FirstTick - RcBndHiX < 1E-8) Do Begin
          Case FDTXFormat.DateOrder Of
            doDDMMYY : bstr := FormatDateTimeSDL('dd"' + FDTXFormat.DateSeparator + '"' +
                MonthString + '"' + FDTXFormat.DateSeparator +
                '"' + YearString, FirstTick);
            doMMDDYY : bstr := FormatDateTimeSDL(MonthString + '"' + FDTXFormat.DateSeparator +
                '"dd"' + FDTXFormat.DateSeparator +
                '"' + YearString, FirstTick);
            doYYMMDD : bstr := FormatDateTimeSDL(YearString + '"' + FDTXFormat.DateSeparator +
                '"' + MonthString + '"' +
                FDTXFormat.DateSeparator + '"dd', FirstTick);
          End;
          If (FirstTick >= RcBndLoX) Then Begin
            If FXTickPosCnt < MaxTickPos Then Begin
              inc(FXTickPosCnt);
              FXScaleTickPos[FXTickPosCnt] := FirstTick;
            End;
            R2M(FirstTick, RcBndLoY, x1, y1);
            CV.MoveTo(x1, y1);
            CV.LineTo(x1, y1 + LongTick);
            tw := CV.TextWidth(bStr) Div 2;
            If x1 + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 + LongTick, bStr)
            Else Cv.TextOut(x1 - tw, y1 + LongTick, bStr);
            If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
              FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
          End;
          FirstTick := FirstTick + Step;
        End;
      End;



      Procedure DisplayDate(x, y : longint);
(*  .   .   .   .   .   .   .   .   *)

      Begin
        bstr := FormatDateStr(FirstTick, FDTXFormat.MonthName,
          FDTXFormat.YearLength, FDTXFormat.DateOrder,
          FDTXFormat.DateSeparator);
        tw := CV.TextWidth(bStr) Div 2;
        th := CV.TextHeight(bStr);
        Case FDTXFormat.DateForTime Of
          dtOnePerChart : Begin
              If LastDay < 0 Then Begin
                If x + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y + LongTick + th, bStr)
                Else Cv.TextOut(x - tw, y + LongTick + th, bStr);
                LastDay := dd;
              End
            End;
          dtOnePerDay : Begin
              If LastDay <> dd Then Begin
                If x + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y + LongTick + th, bStr)
                Else Cv.TextOut(x - tw, y + LongTick + th, bStr);
                LastDay := dd;
              End
            End;
          dtAllTicks : Begin
              If x + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y + LongTick + th, bStr)
              Else Cv.TextOut(x - tw, y + LongTick + th, bStr);
            End;
        End;
      End;



      Procedure BelowOneDayInscription(Mode : integer);
(*. . . . . . . . . . . . . . . . . . . . . . .*)
(* mode = 1 ..... HourToDay
          2 ..... MinuteToHour
          3 ..... SecondToMinute *)

      Var
        x1, y1      : longint;

      Begin
        FirstTick := RcBndLoX;
        Case Mode Of
          1 : Step := FindStep(1, TimeRange, 24, FirstTick);
          2 : Step := FindStep(2, TimeRange, 1440, FirstTick);
          3 : Step := FindStep(2, TimeRange, 86400, FirstTick);
        End;
        LastDay := -1;
        While (FirstTick - RcBndHiX < 1E-8) Do Begin
          DecodeDate(FirstTick, yy, mm, dd);
          Case Mode Of
            1 : Case FDTXFormat.TimeFormat Of
                tfHHMMSS : bstr := FormatDateTimeSDL('hh":"nn', FirstTick);
                tfAMPM : bstr := FormatDateTimeSDL('ham/pm', FirstTick);
                tfHHhMM : bstr := FormatDateTimeSDL('h"h"', FirstTick);
              End;
            2 : Case FDTXFormat.TimeFormat Of
                tfHHMMSS : bstr := FormatDateTimeSDL('hh":"nn', FirstTick);
                tfAMPM : bstr := FormatDateTimeSDL('h":"nnam/pm', FirstTick);
                tfHHhMM : bstr := FormatDateTimeSDL('h"h"nn', FirstTick);
              End;
            3 : Case FDTXFormat.TimeFormat Of
                tfHHMMSS : bstr := FormatDateTimeSDL('hh":"nn":"ss', FirstTick);
                tfAMPM : bstr := FormatDateTimeSDL('h":"nn"."ssam/pm', FirstTick);
                tfHHhMM : bstr := FormatDateTimeSDL('h"h"nn":"ss', FirstTick);
              End;
          End;
          If FXTickPosCnt < MaxTickPos Then Begin
            inc(FXTickPosCnt);
            FXScaleTickPos[FXTickPosCnt] := FirstTick;
          End;
          R2M(FirstTick, RcBndLoY, x1, y1);
          CV.MoveTo(x1, y1);
          CV.LineTo(x1, y1 + LongTick);
          tw := CV.TextWidth(bStr) Div 2;
          If x1 + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 + LongTick, bStr)
          Else Cv.TextOut(x1 - tw, y1 + LongTick, bStr);
          If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
            FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
          DisplayDate(x1, y1);
          FirstTick := FirstTick + Step;
        End;
      End;



    Begin                               { DateTimeXax }
      If (RcBndHiX < RcBndLoX) Or (RcBndLoX < -693593) Or (RcBndHiX > 3E6) Then Begin
        R2M((RcBndLoX + RcBndHiX) / 2, RcBndLoY, x1, y1);
        Cv.TextOut(x1 - cv.TextWidth('invalid DateTime scale') Div 2,
          y1 + LongTick, 'invalid DateTime scale')
      End
      Else Begin
        TimeRange := (RcBndHiX - RcBndLoX) / RcXNTick; { check for time resolution }
        If TimeRange <= 1.1574E-5 Then Begin { range is below 1 sec }
          R2M((RcBndLoX + RcBndHiX) / 2, RcBndLoY, x1, y1);
          Cv.TextOut(x1 - cv.TextWidth('DateTime range is below 1 second') Div 2,
            y1 + LongTick, 'DateTime range is below 1 second')
        End
        Else Begin
          If TimeRange <= 6.9444E-4 Then BelowOneDayInscription(3) { range is 1 second to 1 minute }
          Else Begin
            If TimeRange <= 4.1667E-2 Then BelowOneDayInscription(2) { range is 1 minute to 1 hour }
            Else Begin
              If TimeRange <= 1.0 Then BelowOneDayInscription(1) { range is 1 hour to 1 day }
              Else Begin
                If TimeRange <= 30.0 Then Begin { range is 1 day to 1 month }
                  DayToMonthInscription; { 1,7,30(28,31) }
                End
                Else Begin
                  If TimeRange <= 366.0 Then Begin { range is 1 month to 1 year }
                    MonthToYearInscription; { 1,2,3,6,12 }
                  End
                  Else Begin            { range is more than one year }
                    AboveYearInscription { 1,2,5,10,... }
                  End
                End
              End
            End
          End
        End;
      End;
    End;




  Begin                                 { ShowXax }
    ScaleType := sctXB;

    { the following six lines are a work around for a nasty Windows bug
      which causes the printer fonts to be scaled improperly (sometimes);
      following the motto: beat dirty bugs with dirty tricks - sorry }
    If cv = Printer.Canvas Then Begin
      cv.Font.PixelsPerInch := Screen.PixelsPerInch;
      cv.Font.Size := Font.Size;
      cv.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
    End;

    If RcXNTick < 2 Then
      RcXNTick := 2;
    If RcXNTick > 20 Then
      RcXNTick := 20;
    TimTst := false;
    If RcXLabelType = ftDateTime Then DateTimeXax
    Else Begin
      If RcXLabelType = ftTime Then
        TimTst := TimeXax;
      If Not timtst Then Begin
        If RcXLog Then NumLogXax
        Else NumLinXax;
      End;
    End;
    If length(RcXUnits) <> 0 Then Begin
      AuxStr := RcXUnits;
      tw := CV.TextWidth(AuxStr);
      th := CV.TextHeight(AuxStr);
      Cv.TextOut((RcLRim + Width - RcRRim - Rc3DRim - tw) Div 2, Height - RcBRim - Rc3DRim + LongTick + th, AuxStr);
    End;
  End;





  Procedure ShowXAxTop;
(*--------------*)


  Const
    NDist           = 28;               (* parameters for time scale *)
    MSecIx          = 9;
    FigDist         : Array[0..Ndist] Of double =
      (0, 0.001, 0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2,
      5, 10, 20, 30, 60, 120, 180, 300, 600, 1200,
      1800, 3600, 7200, 14400, 21600, 43200, 86400);
    FigNtick        : Array[1..Ndist] Of integer =
      (5, 4, 5, 5, 4, 5, 5, 4, 5, 5, 4,
      5, 5, 4, 6, 6, 6, 6, 5, 5, 6, 6, 6, 4, 4, 6, 6, 6);
    LongTick        = 7;                { length of long tick on scale }
    ShortTick       = 4;                { length of short tick on scale }


  Var
    m               : integer;
    th, tw          : integer;
    TlSpace         : extended;
    Divisor         : word;
    d, e            : extended;
    TTSpace         : extended;
    Dist            : extended;
    LoX             : extended;
    BLX, BHX        : extended;
    AuxStr          : ShortStr;
    x1, y1          : longint;
    TimTst          : boolean;
    Low             : extended;
    nt              : integer;
    CurrentTickPos  : extended;
    ScaleType       : TScaleType;



    Procedure NumLinXax;
(*................*)

    Var
      i             : integer;
      Sign          : integer;

    Begin
      CalcScalePars(RcXNtick, RcBndLoX, RcBndHiX, LoX, Dist, Divisor);
      TTSpace := Dist / Divisor;
      If RcBndHiX > RcBndLoX Then Sign := 1
      Else Sign := -1;
      If Sign * RcBndHix > 0 Then BHX := RcBndHiX / QSave
      Else BHX := RcBndHiX * QSave;

      If RcShortTicksX Then Begin
        low := LoX - Dist;
        i := 0;
        Repeat                          { short scale ticks }
          CurrentTickPos := Low + i * TTSpace;
          If (Sign * CurrentTickPos >= Sign * RcBndLoX) Then Begin
            If FXTickPosCnt < MaxTickPos Then Begin
              inc(FXTickPosCnt);
              FXScaleTickPos[FXTickPosCnt] := CurrentTickPos;
            End;
            R2M(CurrentTickPos, RcBndHiY, x1, y1);
            CV.MoveTo(x1, y1);
            CV.LineTo(x1, y1 - ShortTick);
            If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
              FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
          End;
          inc(i);
        Until Sign * (Low + i * TTSpace - RcBndHiX) > 0.001 * TTSpace;
      End;

      m := CalcM(RcDecPlcX, RcBndloX, RcBndHiX);
      i := 0;
      Repeat                            { long scale ticks + inscription }
        CurrentTickPos := LoX + i * Dist;
        If Not RcShortTicksX Then
          If FXTickPosCnt < MaxTickPos Then Begin
            inc(FXTickPosCnt);
            FXScaleTickPos[FXTickPosCnt] := CurrentTickPos;
          End;
        R2M(CurrentTickPos, RcBndHiY, x1, y1);
        CV.MoveTo(x1, y1);
        CV.LineTo(x1, y1 - LongTick);
        If (RcXLabelType <> ftNoFigs) Then Begin
          If (abs(CurrentTickPos / (RcBndHiX - RcBndLoX)) < 1E-14) Then Begin
            CurrentTickPos := 0;
            If (abs(RcBndHiX - RcBndLoX) > 1E5) Then Begin
              If (m = 0) Then AuxStr := '0'
              Else AuxStr := '0.0'
            End
            Else AuxStr := RCSpecStrf(CurrentTickPos, 1, m);
          End
          Else AuxStr := RCSpecStrf(CurrentTickPos, 1, m);
          If length(AuxStr) > 14 Then
            AuxStr := copy(AuxStr, 1, 14);

          If RcXLabelType = ftUserText Then AuxStr := ExtractUserText(FUserTickTextX, i + 1)
          Else AuxStr := AddScaleInscription(AuxStr, RcScaleInscrX);
          tw := CV.TextWidth(AuxStr) Div 2;
          th := CV.TextHeight(AuxStr);
          If x1 + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 - LongTick - th, AuxStr)
          Else Cv.TextOut(x1 - tw, y1 - LongTick - th, AuxStr);
        End;
        If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
          FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
        inc(i);
      Until Sign * (LoX + i * Dist - RcBndHiX) > 0.001 * Dist;
    End;



    Procedure NumLogXax;
(*................*)


    Var
      i             : integer;
      LgRange       : extended;
      Use2510       : boolean;
      Mult          : extended;
      RcLoX         : extended;
      RcHiX         : extended;
      LabCnt        : integer;

      Procedure OneLabel(MultiP : extended; TickOnly : boolean);
(*. . . . . . . . . . . . . . . . . . . . . . . . . . *)

      Var
        ix          : integer;

      Begin
        If (Multip * LoX * Mult / QSave > RcLoX) And (QSave * Multip * LoX * Mult < RcHiX) Then Begin
          If Not TickOnly Or (TickOnly And RcShortTicksX) Then
            If FXTickPosCnt < MaxTickPos Then Begin
              inc(FXTickPosCnt);
              FXScaleTickPos[FXTickPosCnt] := Multip * LoX * Mult;
            End;
          R2M(Multip * LoX * Mult, RcBndHiY, x1, y1);
          CV.MoveTo(x1, y1);
          If TickOnly Then Begin
            If RcShortTicksX Then
              Cv.LineTo(x1, y1 - ShortTick);
          End
          Else Cv.LineTo(x1, y1 - LongTick);
          If (RcXLabelType <> ftNoFigs) And Not TickOnly Then Begin
            If m = -3 Then Begin
              If round(Multip) = 1 Then AuxStr := RCSpecStrf(round(ln(LoX * Mult) / ln10), 1, 0)
              Else AuxStr := '';
            End
            Else AuxStr := RCSpecStrf(Multip * LoX * Mult, 1, m);
            If length(AuxStr) > 14 Then
              AuxStr := copy(AuxStr, 1, 14);
            If (RcDecplcX = -2) And (pos('.', AuxStr) > 0) Then { remove trailing zeroes }  Begin
              ix := length(AuxStr);
              While AuxStr[ix] = '0' Do
                dec(ix);
              If AuxStr[ix] = '.' Then
                dec(ix);
              AuxStr := copy(AuxStr, 1, ix);
            End;
            inc(LabCnt);
            If RcXLabelType = ftUserText Then AuxStr := ExtractUserText(FUserTickTextX, LabCnt)
            Else AuxStr := AddScaleInscription(AuxStr, RcScaleInscrX);
            tw := CV.TextWidth(AuxStr) Div 2;
            th := CV.TextHeight(AuxStr);
            If x1 + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 - LongTick - th, AuxStr)
            Else Cv.TextOut(x1 - tw, y1 - LongTick - th, AuxStr);
          End;
          If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
            FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
        End;
      End;


    Begin
      LabCnt := 0;
      LgRange := ln(RcBndHiX / RcBndLoX) / ln10;
      If abs(LgRange) < 1.0 Then NumLinXax { display lin. style scale if range below one order of magnitude }
      Else Begin                        { display logarithmic style scale }
        If abs(LgRange) + 0.5 < RcXNTick Then Use2510 := true
        Else use2510 := false;
        If RcBndHiX > RcBndLoX Then Begin
          RcLoX := RcBndLoX;
          RcHiX := RcBndHiX;
        End
        Else Begin
          RcHiX := RcBndLoX;
          RcLoX := RcBndHiX;
        End;
        m := CalcLogM(RcDecPlcX, RcLoX, RcHiX);
        th := CV.TextHeight('0');
        LoX := IntNeg(ln(RcLoX * QSave) / ln10);
        LoX := exp(ln10 * loX);
        Mult := 1.0;
        Repeat
          OneLabel(1.0, false);
          If Use2510 Then Begin
            For i := 2 To 9 Do
              If (i = 2) Or (i = 5) Then OneLabel(i, false)
              Else OneLabel(i, true);
          End;
          Mult := Mult * 10;
        Until QSave * LoX * Mult > RcHiX;
      End;
    End;


    Function TimeXax : boolean;
(*......................*)

    Var
      tt            : boolean;
      i             : integer;
      Sign          : integer;
      RngIx         : integer;

    Begin
      tt := false;
      RngIx := ndist;
      nt := RcXntick;
      If RcBndHiX > RcBndLoX Then Sign := 1
      Else Sign := -1;
      While ((FigDist[RngIx] > abs(RcBndHiX - RcBndLoX) / NT) And (RngIx > 0)) Do
        dec(RngIx);
      If ((RngIx < NDist) And (RngIx > 0)) Then Begin
        tt := True;
        TlSpace := Sign * FigDist[RngIx];
        TTSpace := Sign * FigDist[RngIx] / FigNTick[RngIx];
        Nt := trunc((RcBndHiX - RcBndLoX) / TTSpace) + 5;
        LoX := TLSpace * (intNeg(RcBndLoX / TLSpace / QSave));
        If RcBndLox < 0 Then BLX := RcBndLoX / QSave
        Else BLX := RcBndLoX * QSave;
        If RcBndHix > 0 Then BHX := RcBndHiX / QSave
        Else BHX := RcBndHiX * QSave;
        If RcShortTicksX Then Begin     { draw the short ticks }
          For i := 0 To NT Do Begin
            CurrentTickPos := LoX + i * TTSpace;
            If (Sign * CurrentTickPos >= Sign * BLX) And (Sign * CurrentTickPos <= Sign * BHX) Then Begin
              If FXTickPosCnt < MaxTickPos Then Begin
                inc(FXTickPosCnt);
                FXScaleTickPos[FXTickPosCnt] := CurrentTickPos;
              End;
              R2M(CurrentTickPos, RcBndHiY, x1, y1);
              CV.MoveTo(x1, y1);
              CV.LineTo(x1, y1 - ShortTick);
              If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
                FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
            End;
          End;
        End;
        For i := 0 To Nt Do Begin
          CurrentTickPos := LoX + i * TTSpace;
          d := CurrentTickPos / TlSPace;
          If d < 0 Then e := d - 0.5
          Else e := d + 0.5;
          If abs(d - int(e)) < 0.01 Then
            If (Sign * CurrentTickPos >= Sign * BLX) And (Sign * CurrentTickPos <= Sign * BHX) Then Begin
              If Not RcShortTicksX Then
                If FXTickPosCnt < MaxTickPos Then Begin
                  inc(FXTickPosCnt);
                  FXScaleTickPos[FXTickPosCnt] := CurrentTickPos;
                End;
              R2M(CurrentTickPos, RcBndHiY, x1, y1);
              CV.MoveTo(x1, y1);
              CV.LineTo(x1, y1 - LongTick);
              If RngIx <= MsecIx Then AuxStr := TimeString(LoX + i * TTspace, true)
              Else AuxStr := TimeString(LoX + i * TTspace, false);
              tw := CV.TextWidth(AuxStr) Div 2;
              th := CV.TextHeight(AuxStr);
              If x1 + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 - LongTick - th, AuxStr)
              Else Cv.TextOut(x1 - tw, y1 - LongTick - th, AuxStr);
              If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
                FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
            End;
        End;
      End;
      TimeXax := tt;
    End;

    Procedure DateTimeXax;
(*..................*)

    Const
      MaxStepGrids  = 3;
      MaxStepNum    = 6;
      StepGrids     : Array[1..MaxStepGrids, 1..MaxStepNum] Of integer =
        ((1, 2, 3, 6, 8, 12), (1, 2, 5, 10, 20, 30), (1, 2, 3, 7, 14, 28));


    Var
      TimeRange     : extended;
      FirstTick     : extended;
      Step          : extended;
      bstr          : String;
      MonthString   : String[5];
      YearString    : String[5];
      LastDay       : integer;
      yy, mm, dd    : word;


      Function FindStep(StepGridIx : integer; Range, Multiplier : extended;
        Var FirstTick : extended) : extended;
(*.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . *)

{ StepGridIx .... type of step grid to apply
  Range ......... raw distance between two ticks
  Multiplier .... to get integer values
  FirstTick ..... DateTime of lower left corner

  function returns "best" integer distance between ticks
  FirstTick ..... position of first tick }


      Var
        st          : extended;
        ix          : integer;
        aint        : longint;
        days        : extended;

      Begin
        st := Range * Multiplier;       { st = actual, scaled step size }
        ix := MaxStepNum;
        While ((StepGrids[StepGridIx, ix] > st) And (ix > 1)) Do
          dec(ix);                      { find the largest integer step size which fits into st }
        days := intNeg(RcBndLoX);
        If RcBndLoX < 0 Then aint := intPos((1 + frac(RcBndLoX)) * Multiplier)
        Else aint := intPos(frac(RcBndLoX) * Multiplier);
        If aint <> 0 Then Begin
          aint := StepGrids[StepGridIx, ix] - (aint Mod StepGrids[StepGridIx, ix]);
          If aint = StepGrids[StepGridIx, ix] Then
            aint := 0;
        End;
        If RcBndLoX < 0 Then FirstTick := days + intPos((1 + frac(RcBndLoX)) * Multiplier + aint) / Multiplier
        Else FirstTick := days + intPos(frac(RcBndLoX) * Multiplier + aint) / Multiplier;
        FindStep := StepGrids[StepGridIx, ix] / Multiplier;
      End;



      Procedure AboveYearInscription;
(*. . . . . . . . . . . . . . *)


      Var
        a, b        : extended;
        c           : integer;
        ystep       : longint;
        x1, y1      : longint;
        yy, mm, dd  : word;
        yy1         : word;

      Begin
        DecodeDate(RcBndLoX, yy, mm, dd);
        a := (RcBndHiX - RcBndLoX) / 365.25 / RcXNTick;
        If a < 1 Then
          a := 1;
        a := ln(a) / ln10;

        b := exp(frac(a) * ln10);
        a := int(a);
        If b < 2 Then c := 1
        Else Begin
          If b < 5 Then c := 2
          Else c := 5;
        End;
        ystep := round(int(exp(a * ln10)) * c);

        yy1 := (((yy - 1) Div ystep) + 1) * ystep;
        If (yy1 = yy) And ((mm > 1) Or (dd > 1)) Then
          yy1 := yy1 + ystep;
        FIrstTick := encodeDate(yy1, 1, 1);

        While (FirstTick - RcBndHiX < 1E-8) Do Begin
          Case FDTXFormat.YearLength Of
            ylNone : bstr := '';
            ylYY : bstr := FormatDateTimeSDL('yy', FirstTick);
            ylYYYY : Begin
                bstr := FormatDateTimeSDL('yyyy', FirstTick);
                If length(bstr) > 0 Then Begin
                  While bstr[1] = '0' Do
                    delete(bstr, 1, 1);
                End;
              End;
          End;
          If FXTickPosCnt < MaxTickPos Then Begin
            inc(FXTickPosCnt);
            FXScaleTickPos[FXTickPosCnt] := FirstTick;
          End;
          R2M(FirstTick, RcBndHiY, x1, y1);
          CV.MoveTo(x1, y1);
          CV.LineTo(x1, y1 - LongTick);
          tw := CV.TextWidth(bStr) Div 2;
          th := CV.TextHeight(bStr);
          If x1 + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 - LongTick - th, bStr)
          Else Cv.TextOut(x1 - tw, y1 - LongTick - th, bStr);
          If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
            FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
          DecodeDate(FirstTick, yy, mm, dd);
          yy := yy + ystep;
          If yy > 9999 Then Begin
            yy := 9999;
            mm := 12;
            dd := 31;
          End;
          FirstTick := EncodeDate(yy, mm, dd);
        End;
      End;


      Procedure MonthToYearInscription;
(*. . . . . . . . . . . . . . .*)

      Var
        x1, y1      : longint;
        yy, mm, dd  : word;
        yy1         : word;
        mm1         : extended;
        ix          : integer;

      Begin
        DecodeDate(RcBndLoX, yy, mm, dd);
        mm1 := (RcBndHiX - RcBndLoX) / 30.4375 / RcXNTick;
        ix := 5;
        While ((StepGrids[1, ix] > mm1) And (ix > 1)) Do
          dec(ix);

        If StepGrids[1, ix] > 1 Then Begin
          Repeat
            inc(mm);
            If mm > 12 Then Begin
              mm := 1;
              inc(yy);
            End;
          Until (mm Mod StepGrids[1, ix] = 1);
        End;
        dd := 1;
        FirstTick := EncodeDate(yy, mm, dd);

        If FDTXFormat.MonthName Then MonthString := 'mmm'
        Else MonthString := 'mm';
        Case FDTXFormat.YearLength Of
          ylNone : YearString := '';
          ylYYYY : YearString := 'yyyy';
          ylYY : YearSTring := 'yy';
        End;

        While (FirstTick - RcBndHiX < 1E-8) Do Begin
          Case FDTXFormat.DateOrder Of
            doDDMMYY : bstr := FormatDateTimeSDL(MonthString + '"' + FDTXFormat.DateSeparator +
                '"' + YearString, FirstTick);
            doMMDDYY : bstr := FormatDateTimeSDL(MonthString + '"' + FDTXFormat.DateSeparator +
                '"' + YearString, FirstTick);
            doYYMMDD : bstr := FormatDateTimeSDL(YearString + '"' + FDTXFormat.DateSeparator +
                '"' + MonthString, FirstTick);
          End;
          If FirstTick >= RcBndLoX Then Begin
            If FXTickPosCnt < MaxTickPos Then Begin
              inc(FXTickPosCnt);
              FXScaleTickPos[FXTickPosCnt] := FirstTick;
            End;
            R2M(FirstTick, RcBndHiY, x1, y1);
            CV.MoveTo(x1, y1);
            CV.LineTo(x1, y1 - LongTick);
            tw := CV.TextWidth(bStr) Div 2;
            th := CV.TextHeight(bStr);
            If x1 + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 - LongTick - th, bStr)
            Else Cv.TextOut(x1 - tw, y1 - LongTick - th, bStr);
            If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
              FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
          End;
          DecodeDate(FirstTick, yy, mm, dd);
          mm := mm + StepGrids[1, ix];
          If mm > 12 Then Begin
            yy1 := (mm - 1) Div 12;
            mm := 1 + ((mm - 1) Mod 12);
            inc(yy, yy1);
          End;
          FirstTick := EncodeDate(yy, mm, dd);
        End;
      End;



      Procedure DayToMonthInscription;
(*. . . . . . . . . . . . . . .*)

      Var
        x1, y1      : longint;
        mm1         : extended;
        ix          : integer;
        Jan01       : extended;

      Begin
        DecodeDate(RcBndLoX, yy, mm, dd);
        mm1 := (RcBndHiX - RcBndLoX) / RcXNTick;
        ix := MaxStepNum;
        While ((StepGrids[3, ix] > mm1) And (ix > 1)) Do
          dec(ix);
        Jan01 := encodeDate(yy, 1, 1);
        dd := (trunc(RcBndLoX - Jan01) Div StepGrids[3, ix]) * StepGrids[3, ix];
        FirstTick := Jan01 + dd;
        Step := StepGrids[3, ix];
        If FDTXFormat.MonthName Then MonthString := 'mmm'
        Else MonthString := 'mm';
        Case FDTXFormat.YearLength Of
          ylNone : YearString := '';
          ylYYYY : YearString := 'yyyy';
          ylYY : YearSTring := 'yy';
        End;
        While (FirstTick - RcBndHiX < 1E-8) Do Begin
          Case FDTXFormat.DateOrder Of
            doDDMMYY : bstr := FormatDateTimeSDL('dd"' + FDTXFormat.DateSeparator + '"' +
                MonthString + '"' + FDTXFormat.DateSeparator +
                '"' + YearString, FirstTick);
            doMMDDYY : bstr := FormatDateTimeSDL(MonthString + '"' + FDTXFormat.DateSeparator +
                '"dd"' + FDTXFormat.DateSeparator +
                '"' + YearString, FirstTick);
            doYYMMDD : bstr := FormatDateTimeSDL(YearString + '"' + FDTXFormat.DateSeparator +
                '"' + MonthString + '"' +
                FDTXFormat.DateSeparator + '"dd', FirstTick);
          End;
          If (FirstTick >= RcBndLoX) Then Begin
            If FXTickPosCnt < MaxTickPos Then Begin
              inc(FXTickPosCnt);
              FXScaleTickPos[FXTickPosCnt] := FirstTick;
            End;
            R2M(FirstTick, RcBndHiY, x1, y1);
            CV.MoveTo(x1, y1);
            CV.LineTo(x1, y1 - LongTick);
            tw := CV.TextWidth(bStr) Div 2;
            th := CV.TextHeight(bStr);
            If x1 + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 - LongTick - th, bStr)
            Else Cv.TextOut(x1 - tw, y1 - LongTick - th, bStr);
            If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
              FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
          End;
          FirstTick := FirstTick + Step;
        End;
      End;



      Procedure DisplayDate(x, y : longint);
(*  .   .   .   .   .   .   .   .   *)

      Begin
        bstr := FormatDateStr(FirstTick, FDTXFormat.MonthName,
          FDTXFormat.YearLength, FDTXFormat.DateOrder,
          FDTXFormat.DateSeparator);
        tw := CV.TextWidth(bStr) Div 2;
        th := CV.TextHeight(bStr);
        Case FDTXFormat.DateForTime Of
          dtOnePerChart : Begin
              If LastDay < 0 Then Begin
                If x + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y - LongTick - th, bStr)
                Else Cv.TextOut(x - tw, y - LongTick - th, bStr);
                LastDay := dd;
              End
            End;
          dtOnePerDay : Begin
              If LastDay <> dd Then Begin
                If x + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y - LongTick - th, bStr)
                Else Cv.TextOut(x - tw, y - LongTick - th, bStr);
                LastDay := dd;
              End
            End;
          dtAllTicks : Begin
              If x + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y - LongTick - 2 * th, bStr)
              Else Cv.TextOut(x - tw, y - LongTick - 2 * th, bStr);
            End;
        End;
      End;



      Procedure BelowOneDayInscription(Mode : integer);
(*. . . . . . . . . . . . . . . . . . . . . . .*)
(* mode = 1 ..... HourToDay
          2 ..... MinuteToHour
          3 ..... SecondToMinute *)

      Var
        x1, y1      : longint;

      Begin
        FirstTick := RcBndLoX;
        Case Mode Of
          1 : Step := FindStep(1, TimeRange, 24, FirstTick);
          2 : Step := FindStep(2, TimeRange, 1440, FirstTick);
          3 : Step := FindStep(2, TimeRange, 86400, FirstTick);
        End;
        LastDay := -1;
        While (FirstTick - RcBndHiX < 1E-8) Do Begin
          DecodeDate(FirstTick, yy, mm, dd);
          Case Mode Of
            1 : Case FDTXFormat.TimeFormat Of
                tfHHMMSS : bstr := FormatDateTimeSDL('hh":"nn', FirstTick);
                tfAMPM : bstr := FormatDateTimeSDL('ham/pm', FirstTick);
                tfHHhMM : bstr := FormatDateTimeSDL('h"h"', FirstTick);
              End;
            2 : Case FDTXFormat.TimeFormat Of
                tfHHMMSS : bstr := FormatDateTimeSDL('hh":"nn', FirstTick);
                tfAMPM : bstr := FormatDateTimeSDL('h":"nnam/pm', FirstTick);
                tfHHhMM : bstr := FormatDateTimeSDL('h"h"nn', FirstTick);
              End;
            3 : Case FDTXFormat.TimeFormat Of
                tfHHMMSS : bstr := FormatDateTimeSDL('hh":"nn":"ss', FirstTick);
                tfAMPM : bstr := FormatDateTimeSDL('h":"nn"."ssam/pm', FirstTick);
                tfHHhMM : bstr := FormatDateTimeSDL('h"h"nn":"ss', FirstTick);
              End;
          End;
          If FXTickPosCnt < MaxTickPos Then Begin
            inc(FXTickPosCnt);
            FXScaleTickPos[FXTickPosCnt] := FirstTick;
          End;
          R2M(FirstTick, RcBndHiY, x1, y1);
          CV.MoveTo(x1, y1);
          CV.LineTo(x1, y1 - LongTick);
          tw := CV.TextWidth(bStr) Div 2;
          th := CV.TextHeight(bStr);
          If x1 + tw >= width - Rc3DRim Then Cv.TextOut(Width - 2 * tw - Rc3DRim, y1 - LongTick - th, bStr)
          Else Cv.TextOut(x1 - tw, y1 - LongTick - th, bStr);
          If Assigned(FOnScaleTickDrawn) Then { provide a hook to insert user defined tick inscriptions }
            FOnScaleTickDrawn(self, cv, ScaleType, CurrentTickPos, x1, y1);
          DisplayDate(x1, y1);
          FirstTick := FirstTick + Step;
        End;
      End;


    Begin                               { DateTimeXax }
      If (RcBndHiX < RcBndLoX) Or (RcBndLoX < -693593) Or (RcBndHiX > 3E6) Then Begin
        R2M((RcBndLoX + RcBndHiX) / 2, RcBndHiY, x1, y1);
        Cv.TextOut(x1 - cv.TextWidth('invalid DateTime scale') Div 2,
          y1 - LongTick, 'invalid DateTime scale')
      End Else Begin
        TimeRange := (RcBndHiX - RcBndLoX) / RcXNTick; { check for time resolution }
        If TimeRange <= 1.1574E-5 Then Begin { range is below 1 sec }
          R2M((RcBndLoX + RcBndHiX) / 2, RcBndLoY, x1, y1);
          Cv.TextOut(x1 - cv.TextWidth('DateTime range is below 1 second') Div 2,
            y1 - LongTick, 'DateTime range is below 1 second')
        End Else Begin
          If TimeRange <= 6.9444E-4 Then BelowOneDayInscription(3) { range is 1 second to 1 minute }
          Else Begin
            If TimeRange <= 4.1667E-2 Then BelowOneDayInscription(2) { range is 1 minute to 1 hour }
            Else Begin
              If TimeRange <= 1.0 Then BelowOneDayInscription(1) { range is 1 hour to 1 day }
              Else Begin
                If TimeRange <= 30.0 Then Begin { range is 1 day to 1 month }
                  DayToMonthInscription; { 1,7,30(28,31) }
                End Else Begin
                  If TimeRange <= 366.0 Then Begin { range is 1 month to 1 year }
                    MonthToYearInscription; { 1,2,3,6,12 }
                  End Else Begin        { range is more than one year }
                    AboveYearInscription { 1,2,5,10,... }
                  End
                End
              End
            End
          End
        End;
      End;
    End;



  Begin                                 { ShowXAxTop }
    ScaleType := sctXT;

    { the following six lines are a work around for a nasty Windows bug
      which causes the printer fonts to be scaled improperly (sometimes);
      following the motto: beat dirty bugs with dirty tricks - sorry }
    If cv = Printer.Canvas Then Begin
      cv.Font.PixelsPerInch := Screen.PixelsPerInch;
      cv.Font.Size := Font.Size;
      cv.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
    End;

    If RcXNTick < 2 Then
      RcXNTick := 2;
    If RcXNTick > 20 Then
      RcXNTick := 20;
    TimTst := false;
    If RcXLabelType = ftDateTime Then DateTimeXax
    Else Begin
      If RcXLabelType = ftTime Then
        TimTst := TimeXax;
      If Not timtst Then Begin
        If RcXLog Then NumLogXax
        Else NumLinXax;
      End;
    End;
    If length(RcXUnits) <> 0 Then Begin
      AuxStr := RcXUnits;
      tw := CV.TextWidth(AuxStr);
      th := CV.TextHeight(AuxStr);
      Cv.TextOut((RcLRim + Width - RcRRim - Rc3DRim - tw) Div 2, RcTRim - LongTick - 2 * th, AuxStr);
    End;
  End;


Var
  pg                : Array[1..4] Of TPoint;
  auxint            : integer;
  i                 : integer;
  th, tw            : integer;
  ULblPosY          : integer;
  ULblPosX          : integer;
  ULblPosX2         : integer;

Begin                                   { ConstructChartBmp }
  FXTickPosCnt := 0;
  FYTickPosCnt := 0;
  For i := 1 To MaxTickPos Do Begin
    FXScaleTickPos[i] := 0;
    FYScaleTickPos[i] := 0;
  End;
  ChartBmp.Width := Width;
  ChartBmp.Height := Height;
  cv.Pen.Style := psSolid;
  cv.Pen.Mode := pmCopy;
  cv.Brush.Color := RcWindCol;          { background window area }
  cv.Pen.Color := RcWindCol;

  cv.Rectangle(0, 0, Width, Height);

  If Rc3DRim > 0 Then { 3D shadow }  Begin
    cv.Brush.Color := RcShadowBakCol;
    ;
    cv.Pen.Color := RcShadowBakCol;
    ;
    cv.Rectangle(ChartBmp.Width - Rc3DRim, 0, ChartBmp.Width, Rc3DRim);
    cv.Rectangle(0, ChartBmp.Height - Rc3DRim, Rc3DRim, ChartBmp.Height);
    cv.Brush.Color := RcShadowColor;
    auxint := 0;
    Case RcShadowStyle Of
      ssBox : Begin
          cv.Pen.Color := clBlack;
          auxint := 0;
        End;
      ssFlying : Begin
          cv.Pen.Color := RcShadowColor;
          auxint := Rc3DRim - 1;
        End;
    End;
    pg[1] := Point(auxint, ChartBmp.Height - Rc3DRim);
    pg[2] := Point(Rc3DRim - 1, ChartBmp.Height - 1);
    pg[3] := Point(ChartBmp.Width - 1, ChartBmp.Height - 1);
    pg[4] := Point(ChartBmp.Width - Rc3DRim, ChartBmp.Height - Rc3DRim);
    cv.Polygon(pg);
    pg[1] := Point(ChartBmp.Width - Rc3DRim, ChartBmp.Height - Rc3DRim);
    pg[2] := Point(ChartBmp.Width - 1, ChartBmp.Height - 1);
    pg[3] := Point(ChartBmp.Width - 1, Rc3DRim - 1);
    pg[4] := Point(ChartBmp.Width - Rc3DRim, auxint);
    cv.Polygon(pg);
    cv.Pen.Color := clBlack;
    cv.MoveTo(0, 0);
    cv.LineTo(0, Height - Rc3DRim);
    cv.LineTo(Width - Rc3DRim, Height - Rc3DRim);
    cv.LineTo(Width - Rc3DRim, 0);
    cv.LineTo(0, 0);
  End;

  cv.Pen.Color := RcScaleCol;           { chart caption }
  cv.Brush.Style := bsClear;
  cv.Font := Font;
    { the following six lines are a work around for a nasty Windows bug
      which causes the printer fonts to be scaled improperly (sometimes);
      following the motto: beat dirty bugs with dirty tricks - sorry }
  If cv = Printer.Canvas Then Begin
    cv.Font.PixelsPerInch := Screen.PixelsPerInch;
    cv.Font.Size := Font.Size;
    cv.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  End;
  th := cv.TextHeight(TitStr);
  tw := cv.TextWidth(TitStr);
  ULblPosX := Width - RcRRim - Rc3DRim - tw;
  ULblPosX2 := Width - RcRRim - Rc3DRim - tw;
  ULblPosY := RcTRim - th;
  Case FXaxPos Of
    xapBottom : Begin
        Case FYaxPos Of
          yapRight : If FClassicLayout Then Begin
              ULblPosX := RcLRim;
              ULblPosY := RcTRim - th;
            End
            Else Begin
              ULblPosX := (RcLRim + Width - RcRRim - Rc3DRim - tw) Div 2;
              ULblPosY := RcTRim - th - (th Div 2);
            End;
          yapLeft : If FClassicLayout Then Begin
              ULblPosX := Width - RcRRim - Rc3DRim - tw;
              ULblPosY := RcTRim - th;
            End
            Else Begin
              ULblPosX := (RcLRim + Width - RcRRim - Rc3DRim - tw) Div 2;
              ULblPosY := RcTRim - th - (th Div 2);
            End;
          yapBoth : Begin
              ULblPosX := (RcLRim + Width - RcRRim - Rc3DRim - tw) Div 2;
              If FClassicLayout Then ULblPosY := RcTRim - th
              Else ULblPosY := RcTRim - th - (th Div 2);
            End;
        End;
      End;
    xapTop : Begin
        Case FYAxPos Of
          yapRight : If FClassicLayout Then Begin
              ULblPosX := RcLRim;
              ULblPosY := Height - RcBRim - Rc3DRim + 3;
            End
            Else Begin
              ULblPosX := (RcLRim + Width - RcRRim - Rc3DRim - tw) Div 2;
              ULblPosY := RcTRim - 3 * th - (th Div 2);
            End;
          yapLeft : If FClassicLayout Then Begin
              ULblPosX := Width - RcRRim - Rc3DRim - tw;
              ULblPosY := Height - RcBRim - Rc3DRim + 3;
            End
            Else Begin
              ULblPosX := (RcLRim + Width - RcRRim - Rc3DRim - tw) Div 2;
              ULblPosY := RcTRim - 3 * th - (th Div 2);
            End;
          yapBoth : Begin
              ULblPosX := (RcLRim + Width - RcRRim - Rc3DRim - tw) Div 2;
              If FClassicLayout Then ULblPosY := Height - RcBRim - Rc3DRim + 3
              Else ULblPosY := RcTRim - 3 * th - (th Div 2);
            End;
        End;
      End;
    xapBoth : Begin
        ULblPosX := (RcLRim + Width - RcRRim - Rc3DRim - tw) Div 2;
        ULblPosY := RcTRim - 3 * th - (th Div 2);
      End;
  End;

  cv.TextOut(ULblPosX, ULblPosY, Titstr);

  AdjustScaling;

  If RcXLabelType <> ftNoScales Then { x-axes }  Begin
    Case FXAxPos Of
      xapBottom : ShowXax;
      xapTop : ShowXaxTop;
      xapBoth : Begin
          ShowXax;
          ShowXaxTop;
        End;
    End;
  End;

  If RcYLabelType <> ftNoScales Then { y-axes }  Begin
    th := CV.TextHeight(RcYUnits);
    tw := CV.TextWidth(RcYUnits);
    Case FXaxPos Of                     // calculate y-label posítion
      xapBottom : Begin
          Case FYaxPos Of
            yapRight : If FClassicLayout Then Begin
                ULblPosX := Width - RcRRim - Rc3DRim - tw;
                ULblPosY := RcTRim - th;
              End
              Else Begin
                ULblPosX := Width - RcRRim - Rc3DRim + 4;
                ULblPosY := RcTRim - th - (th Div 2);
              End;
            yapLeft : If FClassicLayout Then Begin
                ULblPosX := RCLRim;
                ULblPosY := RcTRim - th;
              End
              Else Begin
                ULblPosX := RcLRim - 4 - tw;
                ULblPosY := RcTRim - th - (th Div 2);
              End;
            yapBoth : Begin
                If FClassicLayout Then Begin
                  ULblPosX := RcLRim;
                  ULblPosX2 := Width - RcRRim - Rc3DRim - tw;
                End
                Else Begin
                  ULblPosX := RcLRim - 4 - tw;
                  ULblPosX2 := Width - RcRRim - Rc3DRim + 4;
                End;
                If FClassicLayout Then ULblPosY := RcTRim - th
                Else ULblPosY := RcTRim - th - (th Div 2);
              End;
          End;
        End;
      xapTop : Begin
          Case FYAxPos Of
            yapRight : If FClassicLayout Then Begin
                ULblPosX := Width - RcRRim - Rc3DRim - tw;
                ULblPosY := Height - RcBRim - Rc3DRim + 3;
              End
              Else Begin
                ULblPosX := Width - RcRRim - Rc3DRim + 4;
                ULblPosY := Height - RcBRim - Rc3DRim + (th Div 2);
              End;
            yapLeft : If FClassicLayout Then Begin
                ULblPosX := RcLRim;
                ULblPosY := Height - RcBRim - Rc3DRim + 3;
              End
              Else Begin
                ULblPosX := RcLRim - 4 - tw;
                ULblPosY := Height - RcBRim - Rc3DRim + (th Div 2);
              End;
            yapBoth : Begin
                If FClassicLayout Then Begin
                  ULblPosX := RcLRim;
                  ULblPosX2 := Width - RcRRim - Rc3DRim - tw;
                End
                Else Begin
                  ULblPosX := RcLRim - 4 - tw;
                  ULblPosX2 := Width - RcRRim - Rc3DRim + 4;
                End;
                If FClassicLayout Then ULblPosY := Height - RcBRim - Rc3DRim + 3
                Else ULblPosY := Height - RcBRim - Rc3DRim + (th Div 2);
              End;
          End;
        End;
      xapBoth : Begin
          ULblPosY := Height - RcBRim - Rc3DRim + th + (th Div 2) - 1;
          Case FYAxPos Of
            yapRight : Begin
                ULblPosX := Width - RcRRim - Rc3DRim + 4;
              End;
            yapLeft : Begin
                ULblPosX := RcLRim - 4 - tw;
              End;
            yapBoth : Begin
                ULblPosX := RcLRim - 4 - tw;
                ULblPosX2 := Width - RcRRim - Rc3DRim + 4;
              End;
          End;
        End;
    End;

    Case FYAxPos Of
      yapLeft : Begin
          ShowYaxInternal(cv, RcLRim, RcBndLoY, RcBndHiY, RcYNTick, RcDecPlcY,
            RcYLabelType, RcYLog, RcScaleInscrY, FUserTickTextY,
            RcYUnits, true, true, ULblPosX, ULblPosY, FYarMashtab);
        End;
      yapRight : Begin
          ShowYaxInternal(cv, Width - RcRRim - Rc3DRim, RcBndLoY, RcBndHiY, RcYNTick, RcDecPlcY,
            RcYLabelType, RcYLog, RcScaleInscrY, FUserTickTextY,
            RcYUnits, true, false, ULblPosX, ULblPosY, FYarMashtab);
        End;
      yapBoth : Begin
          ShowYaxInternal(cv, RcLRim, RcBndLoY, RcBndHiY, RcYNTick, RcDecPlcY,
            RcYLabelType, RcYLog, RcScaleInscrY, FUserTickTextY,
            RcYUnits, true, true, ULblPosx, ULblPosY, FYarMashtab);
          ShowYaxInternal(cv, Width - RcRRim - Rc3DRim, RcBndLoY, RcBndHiY, RcYNTick, RcDecPlcY,
            RcYLabelType, RcYLog, RcScaleInscrY, FUserTickTextY,
            RcYUnits, true, false, ULblPosX2, ULblPosY, FYarMashtab);
        End;
    End;
  End;

  If Assigned(FOnScalesRendered) Then   { provide a hook to insert user defined graphics }
    FOnScalesRendered(self, cv, 0, 0);
End;

(******************************************************************************)

Procedure TRChart.CrossHairSetPos(chnum : integer; x, y : double);
(******************************************************************************)

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'CrossHairSetPos (', chnum, ',', x : 1 : 3, ',', y : 1 : 3, ')');
{$ENDIF}
  If (chnum >= 1) And (chnum <= MaxCrossH) Then Begin
    FCrossHair[chnum].FPosX := x;
    FCrossHair[chnum].FPosY := y;
    If FCrossHair[chnum].FMode <> chOff Then
      DrawFinish(RcLRim, RcTRim, GrafBmp);
  End;
End;

(******************************************************************************)

Procedure TRChart.DrawFinish(xPos, yPos : integer; SrcBmp : TBitMap);
(******************************************************************************
  draws the cross hairs and visible text labels and copies entire graphics
  to the canvas
 ******************************************************************************)

Var
  x1, y1            : longint;
  i                 : integer;
  AnyCrossHOn       : boolean;
{$IFDEF DEBUG}
  ST                : double;
  tFile             : textfile;
{$ENDIF}

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'DrawFinish (', xpos, ', ', ypos, ', ', hex(longint(SrcBmp), 8), ')');
{$ENDIF}

  AnyCrossHOn := false;
  For i := 1 To MaxCrossH Do            { check if any crosshair is on }
    If FCrossHair[i].FMode <> chOff Then
      AnyCrossHOn := true;

  If Not AnyCrossHOn Then Canvas.Draw(xPos, yPos, SrcBmp) { copy data directly to canvas }
  Else Begin
    AuxCHBmp.Width := SrcBmp.Width;     { take data copy and add crosshairs }
    AuxCHBmp.Height := SrcBmp.Height;
    AuxCHBmp.Canvas.Draw(0, 0, SrcBmp);
    If AnyCrossHOn Then Begin
      For i := 1 To MaxCrossH Do
        If FCrossHair[i].FMode <> chOff Then Begin
          R2M(FCrossHair[i].FPosX, FCrossHair[i].FPosY, x1, y1);
          AuxCHBmp.Canvas.Pen.Color := FCrossHair[i].FColor;
          AuxCHBmp.Canvas.Pen.Width := FCrossHair[i].FLineWid;
          AuxCHBmp.Canvas.Pen.Style := FCrossHair[i].FLineType;
          AuxCHBmp.Canvas.Brush.Style := bsClear;
          If (FCrossHair[i].FMode = chHoriz) Or (FCrossHair[i].FMode = chBoth) Then
            If (y1 > RcTRim + (FCrossHair[i].FLineWid Div 2)) And (y1 < Height - RcBRim - (FCrossHair[i].FLineWid Div 2)) Then Begin
              AuxCHBmp.Canvas.MoveTo(RcLRim + (FCrossHair[i].FLineWid Div 2) + 1 - xPos, y1 - yPos);
              AuxCHBmp.Canvas.LineTo(Width - RcRRim - Rc3DRim - (FCrossHair[i].FLineWid Div 2) - xPos, y1 - yPos);
            End;
          If (FCrossHair[i].FMode = chVert) Or (FCrossHair[i].FMode = chBoth) Then
            If (x1 > RcLRim + (FCrossHair[i].FLineWid Div 2)) And (x1 < Width - RcRRim - (FCrossHair[i].FLineWid Div 2)) Then Begin
              AuxCHBmp.Canvas.MoveTo(x1 - xPos, RcTRim + (FCrossHair[i].FLineWid Div 2) + 1 - yPos);
              AuxCHBmp.Canvas.LineTo(x1 - xPos, Height - RcBRim - Rc3DRim - (FCrossHair[i].FLineWid Div 2) - yPos);
            End;
        End;
    End;
    Canvas.Draw(xPos, yPos, AuxCHBmp);
  End;
End;


(******************************************************************************)

Procedure TRChart.CrossHairSetup(ch : integer; chColor : TColor; Mode : TCrossHMode;
  LineType : TPenStyle; LineWidth : integer);
(******************************************************************************
 ENTRY:  ch ......... cross hair number
         chcolor .... color of crosshair
         mode ....... type of crosshair cursor
         LineType ... pen style for crosshair
         LineWidth .. line width of crosshair

 EXIT:   properties of crosshair 'ch' are set up
 ******************************************************************************)

Begin
  If (ch >= 1) And (ch <= MaxCrossH) Then Begin
    FCrossHair[ch].FColor := chColor;
    FCrossHair[ch].FMode := mode;
    FCrossHair[ch].FLineType := LineType;
    FCrossHair[ch].FLineWid := LineWidth;
    DrawFinish(RcLRim, RcTRim, GrafBmp);
  End;
End;


(***********************************************************************)

Procedure TRChart.Paint;
(***********************************************************************)

Begin
  If (Visible Or (csDesigning In ComponentState)) And Not (csLoading In ComponentState) Then Begin
{$IFDEF DEBUG}
    writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'Paint');
{$ENDIF}
    ConstructChartBmp(ChartBmp.Canvas); { create chart }
    InitGraf(GrafBmp.Canvas, 0, 0);
    ConstructDataBmp(GrafBmp.Canvas, 0, 0, false, RcFrstCan); { create data image }
    ChartBmp.Canvas.Draw(RcLRim, RcTRim, GrafBmp);
    DrawFinish(0, 0, ChartBmp);         { copy the working bitmap + crosshairs + text labels to the main canvas }
  End;
{$IFDEF SHAREWARE}
  Hint := GetHintStr;
  ShowHint := True;
{$ENDIF}
End;


(**********************************************************************)

Procedure TRChart.MouseUp(Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
(**********************************************************************)

Var
  LoX, HiX, LoY, HiY : double;
  dX, DY            : Double;
Begin
  Inherited MouseUp(Button, Shift, X, Y);
  If MouseBoxState = msRectDraw Then Begin
    If Button = mbRight Then
      MouseBoxState := msNormal
    Else Begin
      MouseBoxX2 := X;
      MouseBoxY2 := Y;
      MouseBoxState := msFinished;
    End;
    Canvas.Pen.Mode := pmXor;
    Canvas.Pen.Color := clWhite;
    Canvas.Brush.Style := bsClear;
    Canvas.Rectangle(MouseBoxX1, MouseBoxY1, WindOldCornerX, WindOldCornerY);
    Canvas.Pen.Mode := pmCopy;
    Canvas.Brush.Style := bsSolid;
  End;

  If (RcMouseAction = maZoomWind) Or (RcMouseAction = maZoomWindPos) Or
    (FZoomState = zsDrawWin) Then
    Case FZoomState Of
      zsDrawWin : Begin
          If Button = mbRight Then Begin
            FZoomState := zsNormal;
            Canvas.Pen.Mode := pmXor;
            Canvas.Pen.Color := clWhite;
            Canvas.Brush.Style := bsClear;
            Canvas.Rectangle(WindAnchorX, WindAnchorY, WindOldCornerX, WindOldCornerY);
            Canvas.Pen.Mode := pmCopy;
            Canvas.Brush.Style := bsSolid;
          End;
          If Button = mbLeft Then Begin
            If ((WindAnchorX <> WindOldCornerX) And
              (WindAnchorY <> WindOldCornerY)) Then Begin
              M2R(WindAnchorX, WindAnchorY, LoX, LoY);
              M2R(WindOldCornerX, WindOldCornerY, HiX, HiY);
              //If RcMouseAction = maZoomWindPos Then Begin
              If ((HiX < LoX) And (RcBndLoX < RcBndHiX)) Or
                ((HiX > LoX) And (RcBndLoX > RcBndHiX)) Then
                Exchange(HiX, LoX, sizeof(LoX));
              If ((HiY < LoY) And (RcBndLoY < RcBndHiY)) Or
                ((HiY > LoY) And (RcBndLoY > RcBndHiY)) Then
                Exchange(HiY, LoY, sizeof(LoY));
              //End;
              If (WindAnchorX > WindOldCornerX) Or (WindAnchorY > WindOldCornerY) Then Begin
                dX := HiX - LoX;
                dY := HiY - LoY;
                If dX < 0 Then dX := 0;
                If dY < 0 Then dY := 0;
                LoX := RcBndLoX - dX;
                HiX := RcBndHiX + dX;
                LoY := RcBndLoY - dY;
                HiY := RcBndHiY + dY;
                ForceRange(LoX, LoY, HiX, HiY, true, false)
              End Else
                ForceRange(LoX, LoY, HiX, HiY, true, false);
              Paint;
              DoZoomPanEvent;
            End;
            FZoomState := zsNormal;
          End;
        End;
    End;
  If (RcMouseAction = maPan) Or (RcMouseAction = maPanHoriz) Or
    (RcMouseAction = maPanVert) Or (RcMouseAction = maZoomDrag) Then
    ZoomStateOnStack;
End;


(**********************************************************************)

Procedure TRChart.MouseDown(Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
(**********************************************************************)

Begin
  Inherited MouseDown(Button, Shift, X, Y);
  If MouseBoxState <> msNormal Then Begin
    Case MouseBoxState Of
      msFirstCorner : Begin
          If Button = mbRight Then
            MouseBoxState := msNormal
          Else Begin
            MouseBoxX1 := X;
            MouseBoxY1 := Y;
            WindOldCornerX := X;
            WindOldCornerY := Y;
            MouseBoxState := msRectDraw;
          End;
        End;
    End;
  End;
  If (RcMouseAction = maZoomWind) Or (RcMouseAction = maZoomWindPos) Then
    Case FZoomState Of
      zsNormal : Begin
          If Button = mbLeft Then
            If (X >= RcLRim) And (X <= Width - RcRRim - Rc3DRim) And (Y >= RcTRim) And (Y <= Height - RcBRim - Rc3DRim) Then Begin
              FZoomState := zsDrawWin;
              WindAnchorX := X;
              WindAnchorY := Y;
              WindOldCornerX := X;
              WindOldCornerY := Y;
            End;
        End;
    End;
End;

(**********************************************************************)

Procedure TRChart.MouseBoxAbort;
(**********************************************************************
  procedure aborts mouse box activities: mouse box returns false without
  valid box parameters
 **********************************************************************)

Begin
  MouseBoxState := msNormal;
End;

(**********************************************************************)

Function TRChart.Mousebox(Var xLo, yLo, xHi, yHi : double) : boolean;
(**********************************************************************
  ENTRY:  ----
  EXIT:   This function waits for the input of a rectangular window in the
          chart. It returns TRUE if the rectangular box has been defined
          correctly. In this case the parameters xLo..yHi are defined and
          valid.
 **********************************************************************)

Var
  reslt             : boolean;
  xx1, yy1          : double;

Begin
  MouseBoxState := msFirstCorner;
  Repeat
    Application.ProcessMessages;
  Until (MouseBoxState = msFinished) Or (MouseBoxState = msNormal);
  If MouseBoxState = msFinished Then Begin
    M2R(MouseBoxX1, MouseBoxY1, xx1, yy1);
    xLo := xx1;
    yLo := yy1;
    M2R(MouseBoxX2, MouseBoxY2, xx1, yy1);
    xHi := xx1;
    yHi := yy1;
    If xLo > xHi Then
      Exchange(xLo, xHi, sizeof(xLo));
    If yLo > yHi Then
      Exchange(yLo, yHi, sizeof(yLo));
  End;
  If MouseBoxState = msFinished Then reslt := True
  Else reslt := false;
  MouseBoxState := msNormal;
  MouseBox := reslt;
End;


(**********************************************************************)

Procedure TRChart.MouseMove(Shift : TShiftState; X, Y : integer);
(**********************************************************************)

Var
  dx, dy            : double;
  rx, ry            : double;
  MidX, MidY        : double;
  facX, facY        : double;
  MouseInWind       : boolean;
  dist, d           : double;
  i                 : integer;
  xx, yy            : longint;


Begin
  LastMouseX := X;
  LastMouseY := Y;
  Inherited MouseMove(Shift, X, Y);
  If MouseBoxState = msRectDraw Then Begin
    If (X < RcLRim) Then
      X := RcLRim;
    If (X > Width - RcRRim - Rc3DRim) Then
      X := Width - RcRRim - Rc3DRim;
    If (Y < RcTRim) Then
      Y := RcTRim;
    If (Y > Height - RcBRim - Rc3DRim) Then
      Y := Height - RcBRim - Rc3DRim;
    Canvas.Pen.Mode := pmXor;
    Canvas.Pen.Color := clWhite;
    Canvas.Brush.Style := bsClear;
    Canvas.Rectangle(MouseBoxX1, MouseBoxY1, WindOldCornerX, WindOldCornerY);
    Canvas.Rectangle(MouseBoxX1, MouseBoxY1, X, Y);
    Canvas.Pen.Mode := pmCopy;
    Canvas.Brush.Style := bsSolid;
    WindOldCornerX := X;
    WindOldCornerY := Y;
  End;
  Case RcMouseAction Of
    maPan, maPanVert, maPanHoriz : Begin { if panning by left mouse button is allowed }
        If ssLeft In Shift Then Begin
          If LButtonWasDown Then Begin
{$IFDEF DEBUG}
            writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'panning [', x, ',', y, ']');
{$ENDIF}
            If (X >= RcLRim) And (X <= Width - RcRRim - Rc3DRim) And (Y >= RcTRim) And (Y <= Height - RcBRim - Rc3DRim) Then Begin
              If RcXLog Then Begin
                dx := exp(ln(RcBndHiX / RcBndLoX) * (MouseAnchorScrX - X) / (Width - RcLRim - RcRRim - Rc3DRim));
                If RcYLog Then Begin    { log. x-axis, log. y-axis }
                  dy := exp(ln(RcBndHiY / RcBndLoY) * (Y - MouseAnchorScrY) / (Height - RcTrim - RcBRim - Rc3DRim));
                  Case RcMouseAction Of
                    maPanVert : forceRange(RcBndLoX, MouseAnchorRcLoY * dy,
                        RcBndHiX, MouseAnchorRcHiY * dy, false, true);
                    maPanHoriz : forceRange(MouseAnchorRcLoX * dx, RcBndLoY,
                        MouseAnchorRcHiX * dx, RcBndHiY, false, true);
                    maPan : forceRange(MouseAnchorRcLoX * dx, MouseAnchorRcLoY * dy,
                        MouseAnchorRcHiX * dx, MouseAnchorRcHiY * dy, false, true);
                  End;
                End
                Else Begin              { log. x-axis, lin. y-axis }
                  dy := (Y - MouseAnchorScrY) * (RcBndHiY - RcBndLoY) / (Height - RcTrim - RcBRim - Rc3DRim);
                  Case RcMouseAction Of
                    maPanVert : forceRange(RcBndLoX, MouseAnchorRcLoY + dy,
                        RcBndHiX, MouseAnchorRcHiY + dy, false, true);
                    maPanHoriz : forceRange(MouseAnchorRcLoX * dx, RcBndLoY,
                        MouseAnchorRcHiX * dx, RcBndHiY, false, true);
                    maPan : forceRange(MouseAnchorRcLoX * dx, MouseAnchorRcLoY + dy,
                        MouseAnchorRcHiX * dx, MouseAnchorRcHiY + dy, false, true);
                  End;
                End;
              End
              Else Begin
                dx := (X - MouseAnchorScrX) * (RcBndHiX - RcBndLoX) / (Width - RcLRim - RcRRim - Rc3DRim);
                If RcYLog Then Begin    { lin. x-axis, log. y-axis }
                  dy := exp(ln(RcBndHiY / RcBndLoY) * (Y - MouseAnchorScrY) / (Height - RcTrim - RcBRim - Rc3DRim));
                  Case RcMouseAction Of
                    maPanVert : forceRange(RcBndLoX, MouseAnchorRcLoY * dy,
                        RcBndHiX, MouseAnchorRcHiY * dy, false, true);
                    maPanHoriz : forceRange(MouseAnchorRcLoX - dx, RcBndLoY,
                        MouseAnchorRcHiX - dx, RcBndHiY, false, true);
                    maPan : forceRange(MouseAnchorRcLoX - dx, MouseAnchorRcLoY * dy,
                        MouseAnchorRcHiX - dx, MouseAnchorRcHiY * dy, false, true);
                  End;
                End
                Else Begin              { lin. x-axis, lin. y-axis }
                  dy := (Y - MouseAnchorScrY) * (RcBndHiY - RcBndLoY) / (Height - RcTrim - RcBRim - Rc3DRim);
                  Case RcMouseAction Of
                    maPanVert : forceRange(RcBndLoX, MouseAnchorRcLoY + dy,
                        RcBndHiX, MouseAnchorRcHiY + dy, false, true);
                    maPanHoriz : forceRange(MouseAnchorRcLoX - dx, RcBndLoY,
                        MouseAnchorRcHiX - dx, RcBndHiY, false, true);
                    maPan : forceRange(MouseAnchorRcLoX - dx, MouseAnchorRcLoY + dy,
                        MouseAnchorRcHiX - dx, MouseAnchorRcHiY + dy, false, true);
                  End;
                End;
              End;
              Paint;
              DoZoomPanEvent;
            End;
          End
          Else Begin                    { button has been newly pressed }
            MouseAnchorScrX := X;       { define anchor }
            MouseAnchorScrY := Y;
            MouseAnchorRcLoX := RcBndLoX;
            MouseAnchorRcLoY := RcBndLoY;
            MouseAnchorRcHiX := RcBndHiX;
            MouseAnchorRcHiY := RcBndHiY;
          End;
          LButtonWasDown := True;
        End
        Else Begin
          LButtonWasDown := false;
        End;
      End;

    maDragCrossH : Begin                { move the cross hairs by left mouse button }
        If ssLeft In Shift Then Begin
          M2R(x, y, rx, ry);
          If LButtonWasDown Then Begin
{$IFDEF DEBUG}
            writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'move cross hair by mouse [', x, ',', y, ']');
{$ENDIF}
            FCrossHair[CHNext].FPosX := rx;
            FCrossHair[CHNext].FPosY := ry;
            Paint;
            DoCrossHMoveEvent(FCrossHair[ChNext]);
          End
          Else Begin                    { button has been newly pressed }
            MouseAnchorScrX := X;       { define anchor }
            MouseAnchorScrY := Y;
            MouseAnchorRcLoX := RcBndLoX;
            MouseAnchorRcLoY := RcBndLoY;
            MouseAnchorRcHiX := RcBndHiX;
            MouseAnchorRcHiY := RcBndHiY;
            CHNext := 1;
            dist := RcMaxDouble;
            For i := 1 To MaxCrossH Do Begin
              R2M(FCrossHair[i].FPosX, FCrossHair[i].FPosY, xx, yy);
              If (FCrossHair[i].FMode = chBoth) Or (FCrossHair[i].FMode = chVert) Then Begin
                d := sqr(xx - x);
                If d < dist Then Begin
                  dist := d;
                  ChNext := i;
                End;
              End;
              If (FCrossHair[i].FMode = chBoth) Or (FCrossHair[i].FMode = chHoriz) Then Begin
                d := sqr(yy - y);
                If d < dist Then Begin
                  dist := d;
                  ChNext := i;
                End;
              End;
            End;
          End;
          LButtonWasDown := True;
        End
        Else Begin
          LButtonWasDown := false;
        End;
      End;

    maDragLabel : Begin                 { move the text labels by left mouse button }
        If ssLeft In Shift Then Begin
          M2R(x, y, rx, ry);
          If LButtonWasDown Then Begin
{$IFDEF DEBUG}
            writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'move text label [', x, ',', y, ']');
{$ENDIF}
            If FTextLabels[TLNext].FAttachDat Then Begin
              FTextLabels[TLNext].FPosX := rx;
              FTextLabels[TLNext].FPosY := ry;
            End
            Else Begin
              FTextLabels[TLNext].FPosX := x;
              FTextLabels[TLNext].FPosY := y;
            End;
            Paint;
            DoTxtLblMoveEvent(FTextLabels[TLNext]);
          End
          Else Begin                    { button has been newly pressed }
            MouseAnchorScrX := X;       { define anchor }
            MouseAnchorScrY := Y;
            MouseAnchorRcLoX := RcBndLoX;
            MouseAnchorRcLoY := RcBndLoY;
            MouseAnchorRcHiX := RcBndHiX;
            MouseAnchorRcHiY := RcBndHiY;
            TLNext := 1;
            dist := RcMaxDouble;
            For i := 1 To MaxTxtLbl Do Begin
              If FTextLabels[i].FAttachDat Then R2M(FTextLabels[i].FPosX, FTextLabels[i].FPosY, xx, yy)
              Else Begin
                xx := round(FTextLabels[i].FPosX);
                yy := round(FTextLabels[i].FPosY);
              End;
              If (FTextLabels[i].FMode <> tlOff) Then Begin
                d := sqr(xx - x) + sqr(yy - y);
                If d < dist Then Begin
                  dist := d;
                  TLNext := i;
                End;
              End;
            End;
          End;
          LButtonWasDown := True;
        End
        Else Begin
          LButtonWasDown := false;
        End;
      End;


    maZoomDrag : Begin                  { zoom by dragging left mouse button }
        If ssLeft In Shift Then Begin
          If LButtonWasDown Then Begin
{$IFDEF DEBUG}
            writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'zoom drag');
{$ENDIF}
            If (X >= RcLRim) And (X <= Width - RcRRim - Rc3DRim) And (Y >= RcTRim) And (Y <= Height - RcBRim - Rc3DRim) Then Begin
              facx := 1.0 - 1.0 * (X - MouseAnchorScrX) / Width;
              If FIsoMetric Then facy := facx
              Else facy := 1.0 + 1.0 * (y - MouseAnchorScrY) / Height;
              MidX := (MouseAnchorRcHiX + MouseAnchorRcLoX) / 2;
              MidY := (MouseAnchorRcHiY + MouseAnchorRcLoY) / 2;
              rx := facX * (MouseAnchorRcHiX - MouseAnchorRcLoX) / 2;
              ry := facY * (MouseAnchorRcHiY - MouseAnchorRcLoY) / 2;
              ForceRange(MidX - rx, MidY - ry, MidX + rx, MidY + ry, false, true);
              Paint;
              DoZoomPanEvent;
            End;
          End
          Else Begin                    { button has been newly pressed }
            MouseAnchorScrX := X;       { define anchor }
            MouseAnchorScrY := Y;
            MouseAnchorRcLoX := RcBndLoX;
            MouseAnchorRcLoY := RcBndLoY;
            MouseAnchorRcHiX := RcBndHiX;
            MouseAnchorRcHiY := RcBndHiY;
          End;
          LButtonWasDown := True;
        End
        Else Begin
          LButtonWasDown := false;
        End;
      End;

    maZoomWindPos,
      maZoomWind : Begin                { zoom by drawing a rectangular window }
        If FZoomState = zsDrawWin Then Begin
{$IFDEF DEBUG}
          writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'zoom window');
{$ENDIF}
          If (X < RcLRim) Then
            X := RcLRim;
          If (X > Width - RcRRim - Rc3DRim) Then
            X := Width - RcRRim - Rc3DRim;
          If FIsoMetric Then Begin
            If (y - WindAnchorY) * (x - WindAnchorX) > 0 Then y := WindAnchorY - WindAnchorX + X
            Else y := WindAnchorY + WindAnchorX - X;
          End;
          If (Y < RcTRim) Then
            Y := RcTRim;
          If (Y > Height - RcBRim - Rc3DRim) Then
            Y := Height - RcBRim - Rc3DRim;
          Canvas.Pen.Mode := pmXor;
          Canvas.Pen.Color := clWhite;
          Canvas.Brush.Style := bsClear;
          Canvas.Rectangle(WindAnchorX, WindAnchorY, WindOldCornerX, WindOldCornerY);
          Canvas.Rectangle(WindAnchorX, WindAnchorY, X, Y);
          Canvas.Pen.Mode := pmCopy;
          Canvas.Brush.Style := bsSolid;
          WindOldCornerX := X;
          WindOldCornerY := Y;
        End;
      End;
  End;

  M2R(x, y, rx, ry);
  If (X >= RcLRim) And (X <= Width - RcRRim - Rc3DRim) And (Y >= RcTRim) And (Y <= Height - RcBRim - Rc3DRim) Then Begin
    MouseInWind := true;
    FMousePosX := rx;
    FMousePosY := ry;
  End
  Else MouseInWind := False;
  Canvas.Font := Font;
  If MouseInWind And Not FMCurFixed Then Begin
    Case RcMouseAction Of
      maNone : screen.Cursor := crCross;
      maPan,
        maPanVert,
        maPanHoriz : screen.Cursor := 1;
      maZoomWindPos : screen.Cursor := 4;
      maZoomWind : screen.Cursor := 2;
      maZoomDrag : screen.Cursor := 3;
      maDragCrossH : screen.Cursor := crDefault;
      maDragLabel : screen.Cursor := crDefault;
    End;
  End
  Else Begin
    Screen.Cursor := crDefault;
  End;
End;


(******************************************************************)

Procedure TRChart.InitGraf(cv : TCanvas; PosX, PosY : integer);
(******************************************************************
ENTRY:  none (only system parameters)

EXIT:   The graphics bitmap is cleared and set up with the
        appropriate colors. The linked list of the graphics
        elements is not changed.
*******************************************************************)


Var
  Rect              : TRect;
  xcnt, ycnt        : integer;
  i, j              : longint;
  PictFault         : boolean;
  auxi              : integer;
  offs              : integer;

Begin
  offs := 1;                            { compensate for bug in Windows graphics engine }
  If cv = Printer.Canvas Then
    offs := 0;
  auxi := Width - RcLrim - RcRrim - Rc3DRim + offs;
  If auxi < 0 Then
    auxi := 0;
  GrafBmp.Width := auxi;
  auxi := Height - RcTRim - RcBRim - Rc3DRim + offs;
  If auxi < 0 Then
    auxi := 0;
  GrafBmp.Height := auxi;

  cv.Pen.Style := psSolid;
  cv.Pen.Mode := pmCopy;
  cv.Brush.Color := RcChartCol;         { background chart area }
  cv.Pen.Color := RcScaleCol;           { scales }
  PictFault := false;
  If FBakGndFile.Name = '' { load background bitmap } Then cv.Rectangle(0 + PosX, 0 + PosY, GrafBmp.Width + PosX, GrafBmp.Height + PosY)
  Else Begin
    Try
      AuxBmp.LoadFromFile(FBakGndFile.Name);
    Except
      PictFault := True;
      cv.Rectangle(0 + PosX, 0 + PosY, GrafBmp.Width + PosX, GrafBmp.Height + PosY);
      FBakGndFile.Name := '';
    End;
    If Not PictFault Then Begin
      Case FBakGndFile.FillMode Of
        bfSimple : Begin                { take background img as is }
            Rect.Left := 0;
            Rect.Top := 0;
            Rect.Right := AuxBmp.Width;
            Rect.Bottom := AuxBmp.Height;
            cv.Rectangle(0, 0, GrafBmp.Width, GrafBmp.Height);
            cv.StretchDraw(rect, AuxBmp);
          End;
        bfStretch : Begin               { stretch to fill entire chart area }
            Rect.Left := 0;
            Rect.Top := 0;
            Rect.Right := GrafBmp.Width;
            Rect.Bottom := GrafBmp.Height;
            cv.StretchDraw(rect, AuxBmp);
          End;
        bfTile : Begin                  { tile copies of image }
            xcnt := 1 + ((GrafBmp.Width - 1) Div AuxBmp.Width);
            ycnt := 1 + ((GrafBmp.Height - 1) Div AuxBmp.Height);
            For i := 1 To xcnt Do
              For j := 1 To ycnt Do Begin
                Rect.Left := (i - 1) * AuxBmp.Width;
                Rect.Top := (j - 1) * AuxBmp.Height;
                Rect.Right := i * AuxBmp.Width;
                Rect.Bottom := j * AuxBmp.Height;
                cv.StretchDraw(rect, AuxBmp);
              End;
          End;
      End;
    End;
  End;
End;

(******************************************************************)

Procedure TRChart.ClearGraf;
(******************************************************************
ENTRY: none (only system parameters)

EXIT:  The graphics bitmap is cleaned with the appropriate colors
*******************************************************************)

Var
  np                : PDrawCan;
  this              : PDrawCan;
  ix                : ItemType;


Begin
  InitGraf(GrafBmp.Canvas, 0, 0);
  this := RcFrstCan;
  While this^.Element <> tkNone Do Begin
    np := this^.Next;
    dispose(this);
    this := np;
  End;
  Dispose(this);
  RcLastCan := New(PDrawCan);
  RcFrstCan := RcLastCan;
  RcLastCanOnShow := RcLastCan;
  RcLastCan^.Element := tkNone;
  RcLastCan^.Next := Nil;
  RcFrstCan^.Prev := Nil;
  For ix := low(FItemCount) To high(FItemCount) Do
    FItemCount[ix] := 0;
  FItemCount[tkNone] := 1;
  AdjustCanInfoOfSharedCharts;
End;


(******************************************************************)

Procedure PrintBitmap(Bitmap : TBitmap; X, Y : integer);
(******************************************************************
 The Draw method on the printer canvas does not work properly.
 Borland suggests to use some Windows API calls instead (see file
 MANUALS.TXT somewhere on the Delphi-CD). The procedure PrintBitmap
 is based on this suggestion, but improved as far as the memory
 allocation is concerned.

 ENTRY: BitMap ..... arbitrary TBitmap
        X,Y ........ location where to copy to

 EXIT:  BitMap is copied to the printer canvas
 ******************************************************************)

Var
  Info              : PBitmapInfo;
{$IFDEF VER120}
  InfoSize          : dword;
  ImageSize         : dword;
{$ELSE}
{$IFDEF VER125}
  InfoSize          : dword;
  ImageSize         : dword;
{$ELSE}
{$IFDEF VER130}
  InfoSize          : dword;
  ImageSize         : dword;
{$ELSE}
{$IFDEF VER140}
  InfoSize          : dword;
  ImageSize         : dword;
{$ELSE}
  InfoSize          : integer;
  ImageSize         : dword;
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
  Image             : Pointer;
  hImage            : THandle;

Begin
  With Bitmap Do Begin
    GetDIBSizes(Handle, InfoSize, ImageSize);
    GetMem(Info, InfoSize);
    Try
      hImage := GlobalAlloc(GMEM_FIXED, ImageSize);
      Image := GlobalLock(hImage);
      Try
        GetDIB(Handle, Palette, Info^, Image^);
        With Info^.bmiHeader Do
          StretchDIBits(Printer.Canvas.Handle, X, Y, Width,
            Height, 0, 0, biWidth, biHeight, Image, Info^,
            DIB_RGB_COLORS, SRCCOPY);
      Finally
        GlobalUnLock(hImage);
        GlobalFree(hImage);
      End;
    Finally
      FreeMem(Info, InfoSize);
    End;
  End;
End;


(******************************************************************)

Procedure TRChart.PrintIt(ScaleF : double; BlkWhite : boolean);
(******************************************************************
ENTRY: BlkWhite .... TRUE if black and white output should be
                     generated
       ScaleF ...... scaling factor (1.0 delivers a hardcopy which is
                     approx. the same size as chart on the screen)

EXIT:  The chart is printed on the default printer
*******************************************************************)


Var
  RcWindColBak,
    RcChartColBak,
    RCFontColBak,
    RcScaleColBak   : TColor;
  xpix, ypix        : integer;
  x, y              : integer;
  PrtWidth          : longint;

Begin
  RcWindColBak := RcWindCol;            { backup colors }
  RcScaleColBak := RcScaleCol;
  RcChartColBak := RcChartCol;
  RcFontColBak := Font.Color;
  If BlkWhite Then Begin
    RcWindCol := clwhite;
    RcChartCol := clwhite;
    RcScaleCol := clblack;
    Font.Color := clblack;
  End;
  Printer.BeginDoc;                     { start printing }
  xpix := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
  ypix := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  PrtWidth := GetDeviceCaps(Printer.Handle, PHYSICALWIDTH);
  PrtWidth := PrtWidth Div xpix * Screen.PixelsPerInch;
  SetMapMode(Printer.Handle, mm_isotropic); { use mapping to adjust size }
  SetWindowExtEx(Printer.Handle, Screen.PixelsPerInch, Screen.PixelsPerInch, Nil); { 32-Bit version }
  SetViewportExtEx(Printer.Handle, round(ScaleF * xpix), round(ScaleF * ypix), Nil);
  x := round((PrtWidth - ScaleF * Width) / 2 / ScaleF);
  If x < 0 Then
    x := 0;
  y := round(Screen.PixelsPerInch / 2 / ScaleF);
  ConstructChartBmp(ChartBmp.Canvas);
  PrintBitmap(ChartBmp, x, y);          { copy the working bitmap to the printer canvas }
  InitGraf(GrafBmp.Canvas, 0, 0);
  ConstructDataBmp(GrafBmp.Canvas, 0, 0, BlkWhite, RcFrstCan);
  PrintBitMap(GrafBmp, x + RcLRim, y + RcTRim);
  RcWindCol := RcWindColBak;
  RcScaleCol := RcScaleColBak;
  RcChartCol := RcChartColBak;
  Font.Color := RcFontColBak;
  Application.ProcessMessages;
  Printer.EndDoc;                       { finish printing }
  ConstructChartBmp(ChartBmp.Canvas);
  Canvas.Draw(0, 0, ChartBmp);          { Copy the working bitmap to the main canvas }
  ShowGraf;
End;



(******************************************************************)

Procedure TRChart.CopyToOpenPrinter(Var x, y : integer;
  ScaleF : double; BlkWhite : boolean);
(******************************************************************
ENTRY: x,y ......... location where to print to (upper left corner
                     of the chart - in printer coordinates)
       BlkWhite .... TRUE if black and white output should be
                     generated
       ScaleF ...... scaling factor (1.0 delivers a hardcopy which is
                     approx. the same size as chart on the screen)

EXIT:  The chart is printed on the already open default printer. This
       procedure enables the user to mix text and graphics at will.
       The variable parameters x and y return the coordinates of the
       lower right corner of the printed chart
*******************************************************************)


Var
  RcWindColBak,
    RcChartColBak,
    RcScaleColBak,
    RcFontColBak    : TColor;
  xpix, ypix        : integer;

Begin
  RcWindColBak := RcWindCol;            { backup colors }
  RcScaleColBak := RcScaleCol;
  RcChartColBak := RcChartCol;
  RcFontColBak := Font.Color;
  If BlkWhite Then Begin
    RcWindCol := clwhite;
    RcChartCol := clwhite;
    RcScaleCol := clblack;
    Font.Color := clblack;
  End;
  xpix := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
  ypix := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  SetMapMode(Printer.Handle, mm_isotropic); { use mapping to adjust size }
  SetWindowExtEx(Printer.Handle, Screen.PixelsPerInch, Screen.PixelsPerInch, Nil); { 32-Bit version }
  SetViewportExtEx(Printer.Handle, round(ScaleF * xpix), round(ScaleF * ypix), Nil);
  ConstructChartBmp(ChartBmp.Canvas);
  PrintBitmap(ChartBmp, round(x / ScaleF * Screen.PixelsPerInch / xpix), { Copy the working bitmap to the main canvas }
    round(y / ScaleF * Screen.PixelsPerInch / ypix));
  InitGraf(GrafBmp.Canvas, 0, 0);
  ConstructDataBmp(GrafBmp.Canvas, 0, 0, BlkWhite, RcFrstCan);
  PrintBitMap(GrafBmp, round(x / ScaleF * Screen.PixelsPerInch / xpix) + RcLRim,
    round(y / ScaleF * Screen.PixelsPerInch / ypix) + RcTRim);

                                                    { now restore scaling to 1:1 }
  SetWindowExtEx(Printer.Handle, Screen.PixelsPerInch, Screen.PixelsPerInch, Nil); { 32-Bit version }
  SetViewportExtEx(Printer.Handle, Screen.PixelsPerInch, Screen.PixelsPerInch, Nil);

  RcWindCol := RcWindColBak;
  RcScaleCol := RcScaleColBak;
  RcChartCol := RcChartColBak;
  Font.Color := RcFontColBak;
  x := x + round(Width / Screen.PixelsPerInch * ScaleF * xpix); { calculate coords of lower right corner }
  y := y + round(Height / Screen.PixelsPerInch * ScaleF * ypix);
  Application.ProcessMessages;
  ConstructChartBmp(ChartBmp.Canvas);
  Canvas.Draw(0, 0, ChartBmp);          { Copy the working bitmap to the main canvas }
  ShowGraf;
End;



(******************************************************************)

Procedure TRchart.ScaleItem(Item : PDrawCan; kx, dx, ky, dy : double);
(******************************************************************
ENTRY: Item ...... pointer to Item
       kx, ky ...... k of scaling for x and y
       dx, dy ...... d of scaling for x and y

EXIT:  The position of the selected item is scaled by
                                         x´ := x * kx + dx
                                     and y´ := y * ky + dy
 ******************************************************************)

Begin
  LLScaleItem(Item, kx, dx, ky, dy);
End;


(******************************************************************)

Procedure TRchart.ScaleAllItems(kx, dx, ky, dy : double);
(******************************************************************
ENTRY: kx, ky ...... k of scaling for x and y
       dx, dy ...... d of scaling for x and y

EXIT:  All available Items are scaled by x´ := x * kx + dx
                                     and y´ := y * ky + dy
 ******************************************************************)

Begin
  LLScaleAllItems(RcFrstCan, kx, dx, ky, dy);
End;


(******************************************************************)

Procedure TRChart.NewColorOfClassItems(Newcol : TColor; ClassNumber : byte);
(******************************************************************
ENTRY: NewCol ........ new color to be set
       ClassNumber ... class number of Items to be processed

EXIT:  All Items with class number 'ClassNumber' have the new color 'NewCol'
 ******************************************************************)

Var
  np                : PDrawCan;

Begin
  np := RcFrstCan;
  While np^.Element <> tkNone Do Begin
    If (np^.ItemClass = ClassNumber) Or (ClassNumber = 255) Then
      np^.Color := NewCol;
    np := np^.Next;
  End;
End;




(******************************************************************)

Procedure TRchart.ScaleSelectedItems(kx, dx, ky, dy : double; ClassNumber : byte);
(******************************************************************
ENTRY: kx, ky ........ k of scaling for x and y
       dx, dy ........ d of scaling for x and y
       ClassNumber ... class number of Items to be processed

EXIT:  All marked Items are scaled by x´ := x * kx + dx
                                   and y´ := y * ky + dy
 ******************************************************************)

Begin
  LLScaleSelectedItems(RcFrstCan, kx, dx, ky, dy, ClassNumber);
End;


(******************************************************************)

Function TRChart.GetFirstItemLL : PDrawCan;
(******************************************************************
ENTRY: ---

EXIT:  The function returns the pointer to first item in the linked
       list
 ******************************************************************)

Begin
  GetFirstItemLL := RcFrstCan;
End;


(******************************************************************)

Function TRChart.GetLastItemLL : PDrawCan;
(******************************************************************
ENTRY: ---

EXIT:  The function returns the pointer to last item in the linked
       list
 ******************************************************************)

Begin
  GetLastItemLL := RcLastCan^.Prev;
End;




(******************************************************************)

Function TRChart.GetItemParams(Item : PDrawCan) : TDrawCan;
(******************************************************************
ENTRY: Item .... pointer to Item to be retrieved

EXIT:  The function returns the parameters of the indicated Item
 ******************************************************************)

Begin
  GetItemParams := Item^;
End;


(******************************************************************)

Procedure TRChart.SetItemParams(Item : PDrawCan; ItParams : TDrawCan);
(******************************************************************
ENTRY: Item ...... pointer to Item to be changed
       ItParams .. new set of parameters (set 'next' and 'prev' to NIL)

EXIT:  The function sets the parameters of the indicated Item

REMARK: The next entry of the item is not changed
 ******************************************************************)


Begin
  If (ItParams.Element <> tkNone) And (ItParams.Element <> tkEverything) Then Begin
    dec(FItemCount[Item^.Element]);
    ItParams.Next := Item^.next;
    ItParams.Prev := Item^.Prev;
    Item^ := ItParams;
    inc(FItemCount[Item^.Element]);
    AdjustCanInfoOfSharedCharts;
  End;
End;


(******************************************************************)

Function TRChart.FindNearestItemReal(mx, my : double;
  ItemID : ItemType; ClassNumber : byte; Var dist : double) : PDrawCan;
(******************************************************************
ENTRY: mx, my ....... real-world coords of search position
       ItemID ....... type of Item to be searched for
       ClassNumber .. class number of item to be searched for (255 = everything)

EXIT:  The pointer to the Item which is nearest to the position [mx,my]
       is returned. The distance is calulated from the real-world
       coordinates. A NIL value indicates that no Item of this type
       is present in the linked list. The distance of the closest item
       is returned in variable 'dist'.
*******************************************************************)

Begin
  FindNearestItemReal := LLFindNearestItemReal
    (RcFrstCan, mx, my, ItemID, ClassNumber, dist);
End;


(******************************************************************)

Procedure TRChart.MarkAllItems(ItemID : ItemType; ClassNumber : byte);
(******************************************************************
ENTRY: ItemID ............. type of Item to be searched in this window
       ClassNumber ........ class number to be assigned to found Items

EXIT:  All the Items which fulfill the given restrictions (ItemID)
       are assigned to a common class number 'ClassNumber'. The function
       returns the number of Items found in window.
*******************************************************************)

Begin
  LLMarkAllItems(RcFrstCan, ItemID, ClassNumber);
End;



(******************************************************************)

Function TRChart.MarkItemsInWindow(xLo, YLo, XHi, YHi : double;
  ItemID : ItemType; ClassNumber : byte) : longint;
(******************************************************************
ENTRY: xLo, YLo, XHi, YHi .. real-world coords of search window
       ItemID ............. type of Item to be searched in this window
       ClassNumber ......... class number to be assigned to found Items

EXIT:  All the Items which fulfill the given restrictions (xLo..yHi, ItemID)
       are assigned to a common class number 'ClassNumber'. The function
       returns the number of Items found in window.
*******************************************************************)

Begin
  MarkItemsInWindow := LLMarkItemsInWindow(RcFrstCan, xLo, YLo, XHi, YHi,
    ItemID, ClassNumber);
End;


(******************************************************************)

Function TRChart.FindNearestItemScreen(mx, my : double;
  ItemID : ItemType; ClassNumber : byte; Var dist : double) : PDrawCan;
(******************************************************************
ENTRY: mx, my ....... real-world coords of search position
       ItemID ....... type of Item to be searched for
       ClassNumber .. class number of item to be searched for (255 = everything)

EXIT:  The pointer to the Item which is nearest to the position [mx,my]
       is returned. The distance is calulated from the screen
       coordinates. A NIL value indicates that no Item of this type
       is present in the linked list. The distance of the closest item
       is returned in variable 'dist'.
*******************************************************************)

Var
  np                : PDrawCan;
  idx               : PDrawCan;
  d                 : double;
  mxscr             : longint;
  myscr             : longint;
  txscr             : longint;
  tyscr             : longint;

Begin
  np := RcFrstCan;
  idx := Nil;
  dist := RcMaxDouble;
  R2M(mx, my, mxscr, myscr);
  If ItemID <> tkNone Then { search only if ItemID is not tkNone }  Begin
    While (np^.Element <> tkNone) Do Begin
      If (((ItemID = tkNotMoveTo) And (np^.Element <> tkMoveTo)) Or
        (ItemID = tkEverything) Or (np^.Element = ItemID)) And
        ((ClassNumber = 255) Or (ClassNumber = np^.ItemClass)) Then Begin
        R2M(np^.x, np^.y, txscr, tyscr);
        d := sqr(1.0 * (txscr - mxscr)) + sqr(1.0 * (tyscr - myscr));
        If d < dist Then Begin
          dist := d;
          idx := np;
        End;
      End;
      np := np^.Next;
    End;
  End;
  dist := sqrt(dist);
  FindNearestItemScreen := idx;
End;


(******************************************************************)

Function TRChart.RemoveItemsByClass(ClassNumber : byte) : longint;
(******************************************************************
ENTRY: ClassNumber ... class number of items to be removed from linked list

EXIT:  All items which have class number ClassNumber are removed from
       the linked list. The function returns the number of remove elements
*******************************************************************)

Var
  cnt               : longint;
  np                : PDrawCan;
  NextItem          : PDrawCan;

Begin
  cnt := 0;
  np := RcFrstCan;
  While (np^.Element <> tkNone) Do Begin
    If np^.ItemClass = ClassNumber Then Begin
      NextItem := np^.Next;
      dec(FItemCount[np^.Element]);
      If np^.Prev = Nil Then Begin
        np^.Next^.Prev := Nil;
        RcFrstCan := np^.Next;
      End
      Else Begin
        np^.Prev^.Next := np^.Next;
        np^.Next^.Prev := np^.Prev;
      End;
      Dispose(np);
      inc(cnt);
      np := NextItem;
    End
    Else np := np^.Next;
  End;
  RemoveItemsByClass := cnt;
End;




(******************************************************************)

Procedure TRchart.RemoveItem(Item : PDrawCan);
(******************************************************************
  ENTRY: Item .... pointer to item to be removed from linked list

  EXIT:  specified item is removed from linked list
 ******************************************************************)

Var
  np                : PDrawCan;

Begin
  np := RcFrstCan;
  While (np^.Element <> tkNone) And (np <> item) Do
    np := np^.Next;
  If np^.Element <> tkNone Then Begin
    dec(FItemCount[np^.Element]);
    If np^.Prev = Nil Then Begin
      np^.Next^.Prev := Nil;
      RcFrstCan := np^.Next;
    End
    Else Begin
      np^.Prev^.Next := np^.Next;
      np^.Next^.Prev := np^.Prev;
    End;
    Dispose(np);
  End;
  AdjustCanInfoOfSharedCharts;
End;


(******************************************************************)

Procedure TRChart.RemoveLastItem;
(******************************************************************
ENTRY: none

EXIT:  The last Item stored with the graphics is removed from it
*******************************************************************)

Var
  np                : PDrawCan;

Begin
  If RcLastCan <> RcFrstCan Then Begin  { remove last entry }
    np := RcLastCan^.Prev;
    dec(FItemCount[np^.Element]);
    If (np = RcFrstCan) Then Begin
      RcLastCan^.Prev := Nil;
      RcFrstCan := RcLastCan;
    End
    Else Begin
      RcLastCan^.Prev := np^.Prev;
      np^.Prev^.Next := RcLastCan;
    End;
    Dispose(np);
  End;
  AdjustCanInfoOfSharedCharts;
End;


(******************************************************************)

Procedure TRChart.RemoveFirstItem;
(******************************************************************
ENTRY: none

EXIT:  The first item is removed from the linked list
*******************************************************************)

Var
  np                : PDrawCan;

Begin
  If RcFrstCan <> RcLastCan Then Begin
    np := RcFrstCan;
    dec(FItemCount[np^.Element]);
    RcFrstCan := RcFrstCan^.Next;       { change pointer to first can }
    RcFrstCan^.Prev := Nil;
    Dispose(np);                        { remove first entry }
  End;
  AdjustCanInfoOfSharedCharts;
End;

(******************************************************************)

Function TRChart.GetTypeOfFirstItem : ItemType;
(******************************************************************
ENTRY: none

EXIT:  The type of the first item is returned
*******************************************************************)

Begin
  If RcFrstCan <> RcLastCan Then GetTypeOfFirstItem := RcFrstCan^.Element
  Else GetTypeOfFirstItem := tkNone;
End;


(******************************************************************)

Function TRChart.GetTypeOfLastItem : ItemType;
(******************************************************************
ENTRY: none

EXIT:  The type of the last item in the linked list is returned
*******************************************************************)

Begin
  If RcLastCan^.Prev = Nil Then GetTypeOfLastItem := tkNone
  Else GetTypeOfLastItem := RcLastCan^.Prev^.Element;
End;


(******************************************************************)

Procedure TRChart.ConstructDataBmp(cv : TCanvas; PosX, PosY : integer;
  BlkWhite : boolean; FirstItem : PDrawCan);
(******************************************************************
  This routine creates the bitmap image of the data area; the upper left
  corner of the data image is defined by PosX/PosY. If BlkWhite is TRUE
  the data colors are automatically set to black, the fill colors are
  set to silver. Only the items of the linked list starting with
  FirstItem are drawn
 ******************************************************************)


Const
  PointBmp          : Array[1..MaxRCMarks, 1..7] Of byte =
    (($00, $00, $08, $1C, $08, $00, $00), { 1:  small plus }
    ($00, $08, $08, $3E, $08, $08, $00), { 2:  medium plus }
    ($08, $08, $08, $7F, $08, $08, $08), { 3:  large plus }
    ($00, $00, $14, $08, $14, $00, $00), { 4:  small cross }
    ($00, $22, $14, $08, $14, $22, $00), { 5:  medium cross }
    ($41, $22, $14, $08, $14, $22, $41), { 6:  large cross }
    ($00, $00, $1C, $1C, $1C, $00, $00), { 7:  small block }
    ($00, $3E, $3E, $3E, $3E, $3E, $00), { 8:  medium block }
    ($7F, $7F, $7F, $7F, $7F, $7F, $7F), { 9:  large block }
    ($00, $00, $1C, $14, $1C, $00, $00), { 10: small empty block }
    ($00, $3E, $22, $22, $22, $3E, $00), { 11: medium empty block }
    ($7F, $41, $41, $41, $41, $41, $7F), { 12: large empty block }
    ($00, $00, $08, $1C, $08, $00, $00), { 13: small spade }
    ($00, $08, $1C, $3E, $1C, $08, $00), { 14: medium spade }
    ($08, $1C, $3E, $7F, $3E, $1C, $08), { 15: large spade }
    ($00, $1C, $22, $22, $22, $1C, $00), { 16: medium circle }
    ($1C, $22, $41, $41, $41, $22, $1C), { 17: large circle }
    ($55, $2A, $55, $2A, $55, $2A, $55), { 18: large shaded block }
    ($08, $14, $22, $41, $22, $14, $08), { 19: empty large spade }
    ($00, $08, $14, $22, $00, $00, $00), { 20: small hat }
    ($08, $14, $22, $41, $00, $00, $00), { 21: large hat }
    ($00, $22, $14, $08, $00, $00, $00), { 22: small inverse hat }
    ($41, $22, $14, $08, $00, $00, $00), { 23: large inverse hat }
    ($1C, $3E, $7F, $7F, $7F, $3E, $1C), { 24: large filled circle }
    ($63, $77, $3E, $1C, $3E, $77, $63)); { 25: large bold cross }

  MaxPPa            = 200;              { size of polyline array }


Var
  np                : PDrawCan;
  x1, y1            : longint;
  x2, y2            : longint;
  i, j              : integer;
  tw, th            : integer;
  col               : TColor;
  dx, dy            : integer;
  f                 : double;

       { the following four variables are used for drawing speed
         optimization - change the colors of pen, font, or brush
         only if necessary }
  LastPenCol        : TColor;
  LastPenStyle      : TPenStyle;
  LastBrushCol      : TColor;
  LastFontCol       : TColor;
  LastLWidth        : integer;
  ppa               : Array[1..MaxPPa] Of TPoint; { polyline to speed up connected lines }
  LastMoveToX       : longint;
  LastMoveToY       : longint;



  Function NextGridLocation(x : double; LogLin : boolean; dx : double;
    index : integer; ynotx : boolean) : double;
(*---------------------------------------------------------------*)

  Var
    f               : double;
    i, j            : integer;

  Begin
    If dx = 0 Then Begin                { grid lines along scale ticks }
      If ynotx Then Begin
        If index > FYTickPosCnt Then x := max(RcBndHiY, RcBndLoY)
        Else If index > 0 Then x := FYScaleTickPos[index]
        Else x := max(RcBndHiY, RcBndLoY);
      End Else Begin
        If index > FXTickPosCnt Then x := max(RcBndHiX, RcBndLoX)
        Else If index > 0 Then x := FXScaleTickPos[index]
        Else x := max(RcBndHiX, RcBndLoX);
      End;
    End Else Begin                      { grid lines according to dx ... }
      If Not LogLin Or (dx > 0) Then x := x + abs(dx)
      Else Begin
        If dx = -1 Then Begin           { powers of 10 }
          x := x * 10;
        End Else
          If dx = -2 Then Begin         { 1-2-5 }
            f := ln(x) / ln10;
            i := IntNeg(f);
            f := f - i;
            j := round(exp(f * ln10));
            Case j Of
              1 : f := 2;
              2 : f := 5;
              5 : f := 10;
            End;
            x := f * exp(i * ln10);
          End Else Begin                { 1-2-3-...-9-10-20-... }
            f := ln(x) / ln10;
            i := IntNeg(f);
            f := f - i;
            f := 1 + round(exp(f * ln10));
            x := f * exp(i * ln10);
          End;
      End;
    End;
    NextGridLocation := x;
  End;



  Procedure ConstructGrid;
(*--------------------*)

  Const
    MaxGridLines    = 20000;

  Var
    i, j            : integer;
    x1, y1          : longint;
    lowx, lowy      : double;
    hix, hiy        : double;
    OrgLowY         : double;
    cnt             : integer;
    xix, yix        : integer;

  Begin
    lowx := RcBndLoX;
    lowy := RcBndLoy;
    hix := RcBndHiX;
    hiy := RcBndHiy;
    If lowx > hix Then
      Exchange(Lowx, HiX, sizeof(lowx));
    If lowy > hiy Then
      Exchange(Lowy, Hiy, sizeof(lowy));
    If FXTickPosCnt > 0 Then
      If FXScaleTickPos[1] > FXScaleTickPos[FXTickPosCnt] Then Begin
        i := 0;
        j := FXTickPosCnt + 1;
        Repeat
          inc(i);
          dec(j);
          Exchange(FXScaleTickPos[i], FXScaleTickPos[j], sizeof(FXScaleTickPos[1]));
        Until i >= j;
      End;
    If FYTickPosCnt > 0 Then
      If FYScaleTickPos[1] > FYScaleTickPos[FYTickPosCnt] Then Begin
        i := 0;
        j := FYTickPosCnt + 1;
        Repeat
          inc(i);
          dec(j);
          Exchange(FYScaleTickPos[i], FYScaleTickPos[j], sizeof(FYScaleTickPos[1]));
        Until i >= j;
      End;

    If RcGridDx = 0 Then Begin          { set grid lines at tick marks }
      If FXTickPosCnt > 0 Then LowX := FXScaleTickPos[1]
      Else LowX := min(RcBndLoX, RcBndHiX);
    End
    Else Begin
      If Not RCXLog Or (RcGridDx > 0) { calculate first grid position - x } Then LowX := RcGridDx * IntPos(LowX / RcGridDx)
      Else Begin
        If RcGridDx = -1 Then Begin     { powers of 10 }
          LowX := exp(intPos(ln(LowX) / ln10) * ln10);
        End
        Else
          If RcGridDx = -2 Then Begin   { 1-2-5 }
            f := ln(LowX) / ln10;
            i := IntNeg(f);
            f := f - i;
            j := round(exp(f * ln10));
            If j <= 10 Then
              f := 10;
            If j <= 5 Then
              f := 5;
            If j <= 2 Then
              f := 2;
            LowX := f * exp(i * ln10);
          End
          Else
            If RcGridDx = -3 Then Begin { 1-2-3-...-9-10-20-... }
              f := ln(LowX) / ln10;
              i := IntNeg(f);
              f := f - i;
              f := round(exp(f * ln10));
              LowX := f * exp(i * ln10);
            End;
      End;
    End;

    If RcGridDy = 0 Then Begin          { set grid lines at tick marks }
      If FYTickPosCnt > 0 Then LowY := FYScaleTickPos[1]
      Else LowY := min(RcBndLoY, RcBndHiY);
    End
    Else Begin
      If Not RCYLog Or (RcGridDy > 0) { calculate first grid position - y } Then LowY := RcGridDy * IntPos(LowY / RcGridDy)
      Else Begin
        If RcGridDy = -1 Then Begin     { powers of 10 }
          LowY := exp(intPos(ln(LowY) / ln10) * ln10);
        End
        Else
          If RcGridDy = -2 Then Begin   { 1-2-5 }
            f := ln(LowY) / ln10;
            i := IntNeg(f);
            f := f - i;
            j := round(exp(f * ln10));
            If j <= 10 Then
              f := 10;
            If j <= 5 Then
              f := 5;
            If j <= 2 Then
              f := 2;
            LowY := f * exp(i * ln10);
          End
          Else
            If RcGridDy = -3 Then Begin { 1-2-3-...-9-10-20-... }
              f := ln(LowY) / ln10;
              i := IntNeg(f);
              f := f - i;
              f := round(exp(f * ln10));
              LowY := f * exp(i * ln10);
            End;
      End;
    End;

    cv.Pen.Color := RcGridCol;
    xix := 1;
    yix := 1;
    Case RcGridStyle Of
      gsPoints : Begin
          cnt := 0;
          OrgLowY := LowY;
          While (LowX < HiX) And (cnt < MaxGridLines) Do Begin
            LowY := OrgLowY;
            yix := 1;
            While (LowY < HiY) And (cnt < MaxGridLines) Do Begin
              inc(cnt);
              R2M(LowX, LowY, x1, y1);
              cv.Pixels[x1 - RcLrim + PosX, y1 - RcTRim + PosY] := RcGridCol;
              inc(yix);
              LowY := NextGridLocation(LowY, RcYLog, RcGridDy, yix, true);
            End;
            inc(xix);
            LowX := NextGridLocation(LowX, RcXLog, RcGridDx, xix, false);
          End;
        End;
      gsVertDotLines,
        gsVertLines : Begin
          If RcGridStyle = gsVertDotLines Then cv.Pen.Style := psDot
          Else cv.Pen.Style := psSolid;
          cnt := 0;
          While (LowX < HiX) And (cnt < MaxGridLines) Do Begin
            R2M(LowX, RcBndLoY, x1, y1);
            cv.MoveTo(x1 - RcLrim + PosX, y1 - RcTRim + PosY);
            R2M(LowX, RcBndHiY, x1, y1);
            cv.LineTo(x1 - RcLrim + PosX, y1 - RcTRim + PosY);
            inc(cnt);
            inc(xix);
            LowX := NextGridLocation(LowX, RcXLog, RcGridDx, xix, false);
          End;
          If RcGridStyle = gsVertDotLines Then
            cv.Pen.Style := psSolid;
        End;
      gsHorizDotLines,
        gsHorizLines : Begin
          If RcGridStyle = gsHorizDotLines Then cv.Pen.Style := psDot
          Else cv.Pen.Style := psSolid;
          cnt := 0;
          While (LowY < HiY) {And (cnt < MaxGridLines)} Do Begin
            R2M(RcBndLoX, LowY, x1, y1);
            cv.MoveTo(x1 - RcLrim + PosX, y1 - RcTRim + PosY);
            R2M(RcBndHiX, LowY, x1, y1);
            cv.LineTo(x1 - RcLrim + PosX, y1 - RcTRim + PosY);
            inc(cnt);
            inc(yix);
            LowY := NextGridLocation(LowY, RcYLog, RcGridDy, yix, true);
          End;
          If RcGridStyle = gsHorizDotLines Then
            cv.Pen.Style := psSolid;
        End;
      gsLines,
        gsDotLines : Begin
          If RcGridStyle = gsDotLines Then cv.Pen.Style := psDot
          Else cv.Pen.Style := psSolid;
          cnt := 0;
          While (LowX < HiX) {And (cnt < MaxGridLines)} Do Begin
            R2M(LowX, RcBndLoY, x1, y1);
            cv.MoveTo(x1 - RcLrim + PosX, y1 - RcTRim + PosY);
            R2M(LowX, RcBndHiY, x1, y1);
            cv.LineTo(x1 - RcLrim + PosX, y1 - RcTRim + PosY);
            inc(cnt);
            inc(xix);
            LowX := NextGridLocation(LowX, RcXLog, RcGridDx, xix, false);
          End;
          While (LowY < HiY) And (cnt < MaxGridLines) Do Begin
            R2M(RcBndLoX, LowY, x1, y1);
            cv.MoveTo(x1 - RcLrim + PosX, y1 - RcTRim + PosY);
            R2M(RcBndHiX, LowY, x1, y1);
            cv.LineTo(x1 - RcLrim + PosX, y1 - RcTRim + PosY);
            inc(yix);
            inc(cnt);
            LowY := NextGridLocation(LowY, RcYLog, RcGridDy, yix, true);
          End;
          If RcGridStyle = gsDotLines Then
            cv.Pen.Style := psSolid;
        End;
    End;
  End;


  Procedure FinishPolyLine;
(*---------------------*)

  Var
    hdc             : THandle;

  Begin
    hdc := cv.Handle;
    If FNumPPa > 0 Then Begin
      WinProcs.PolyLine(hdc, ppa, FNumppa);
      cv.MoveTo(ppa[FNumPPa].x, ppa[FNumPPa].y);
      LastMoveToX := ppa[FNumPPa].x;
      LastMoveToY := ppa[FNumPPa].y;
      FNumPPa := 0;
    End;
  End;


  Procedure EnterPolyline(x, y : longint);
(*-----------------------------------*)

  Begin
    If FNumppa = 0 Then Begin
      inc(FNumppa);                     { enter last moveto as first point of polyline }
      ppa[FNumppa] := Point(LastMoveToX, LastMoveToY);
    End;
    inc(FNumppa);
    ppa[FNumppa] := Point(x, y);
    If FNumppa = MaxPPa Then Begin
      Finishpolyline;
      inc(FNumppa);
      ppa[FNumppa] := Point(x, y);
    End;
  End;


  Procedure DisplayMarkAsBitMap(Mark : integer; Col : TColor);
(*-------------------------------------------------------*)

  Var
    i, j            : integer;
    by              : byte;

  Begin                                 { bit maps }
    For i := 1 To 7 Do Begin
      by := PointBmp[Mark, i];
      If by <> 0 Then Begin
        For j := 1 To 7 Do Begin
          If by And $01 = $01 Then
            cv.Pixels[x1 - RcLRim + PosX + 4 - j, y1 - RcTRim + PosY - 4 + i] := Col;
          by := by Shr 1;
        End;
      End;
    End;
  End;


Var
  c1, c2            : TColor;
  quad              : Array[1..4] Of TPoint;
  tri               : Array[1..3] Of TPoint;
  NumLines          : integer;
  nl                : integer;
  lastj             : integer;
  twaux             : integer;
{$IFDEF SHAREWARE}
  astr              : String;
{$ENDIF}

Begin                                   { ConstructDataBmp }
  If (RcGridStyle <> gsNone) And (FirstItem = RcFrstCan) Then
    ConstructGrid;
  np := FirstItem;
  LastLwidth := RcLineWid;
  cv.Pen.Width := LastLWidth;
  LastMoveToX := 0 + PosX;
  LastMoveToY := 0 + PosY;
  cv.MoveTo(0 + PosX, 0 + PosY);
  LastPenCol := RcChartCol;
  LastPenStyle := psSolid;
  cv.Pen.Color := LastPenCol;
  cv.Pen.Style := LastPenStyle;
  LastBrushCol := RcChartCol;
  cv.Brush.Color := LastBrushCol;
  cv.Font := Font;
  LastFontCol := RcChartCol;
  cv.Font.Color := LastFontCol;

  While np^.Element <> tkNone Do Begin
    If FItClassVisib[np^.ItemClass] Then Begin
      If BlkWhite Then col := clblack
      Else col := np^.Color;
      If (np^.lWid <> LastLWidth) Then Begin
        FinishPolyLine;
        LastLWidth := np^.lWid;
        cv.Pen.Width := np^.lWid;
      End;
      Case np^.Element Of
        tkMoveto : Begin
            R2M(np^.x, np^.y, x1, y1);
            LimitToInteger(x1, y1);
            FinishPolyLine;
            LastMoveToX := x1 - RcLRim + PosX;
            LastMoveToY := y1 - RcTRim + PosY;
            cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
          End;
        tkLineTo : Begin
            R2M(np^.x, np^.y, x1, y1);
            LimitToInteger(x1, y1);
            If (col <> LastPenCol) Or (np^.penstyle <> LastPenStyle) Then Begin
              FinishPolyLine;
              LastPenCol := col;
              cv.Pen.Color := Col;
              LastPenStyle := np^.penstyle;
              cv.Pen.Style := np^.penstyle;
            End;
            EnterPolyLine(x1 - RcLrim + PosX, y1 - RcTRim + PosY);
          End;
        tkMoveRelPix : Begin
            x1 := cv.PenPos.x + round(np^.x);
            y1 := cv.PenPos.Y + round(np^.y);
            FinishPolyLine;
            LastMoveToX := x1;          //-RcLRim+PosX;
            LastMoveToY := y1;          //-RcTRim+PosY;
            cv.MoveTo(x1, y1);
          End;
        tkLineRelPix : Begin
            FinishPolyLine;
            x1 := cv.PenPos.x + round(np^.x);
            y1 := cv.PenPos.Y + round(np^.y);
            LastPenCol := col;
            cv.Pen.Color := Col;
            LastPenStyle := np^.penstyle;
            cv.Pen.Style := np^.penstyle;
            cv.LineTo(x1, y1);
            cv.Pixels[x1, y1] := col;
          End;
        tkText : Begin
            FinishPolyLine;
            If col <> LastFontCol Then Begin
              LastFontCol := col;
              cv.Font.Color := col;
            End;
            cv.Font.Style := FTextFontStyle;
            cv.Font.Size := np^.size;
                    { the following six lines are a work around for a nasty Windows bug
                      which causes the printer fonts to be scaled improperly (sometimes);
                      following the motto: beat dirty bugs with dirty tricks - sorry }
            If cv = Printer.Canvas Then Begin
              cv.Font.PixelsPerInch := Screen.PixelsPerInch;
              cv.Font.Size := np^.Size;
              cv.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
            End;
            cv.Brush.Color := FTextBkColor;
            If FTextBkStyle = tbClear Then cv.Brush.Style := bsClear
            Else cv.Brush.Style := bsSolid;
            R2M(np^.x, np^.y, x1, y1);
            LimitToInteger(x1, y1);
            tw := cv.TextWidth(np^.txt);
            th := cv.TextHeight(np^.txt);
            y1 := y1 - (th Div 2);
            Case FTextAlignment Of
              taRightJustify : x1 := x1 - tw;
              taCenter : x1 := x1 - (tw Div 2);
            End;
            cv.TextOut(x1 - RcLRim + PosX, y1 - RcTRim + PosY, np^.txt);
          End;
        tkEllipse : Begin
            FinishPolyLine;
            If BlkWhite Then Begin
              c1 := clblack;
              c2 := clSilver;
            End
            Else Begin
              c1 := col;
              c2 := np^.fillcol3;
            End;
            If c1 <> LastPenCol Then Begin
              LastPenCol := c1;
              cv.Pen.Color := c1;
            End;
            If col <> LastBrushCol Then Begin
              LastBrushCol := c2;
              cv.Brush.Color := c2;
            End;
            If np^.penstyle <> LastPenStyle Then Begin
              LastPenStyle := np^.penstyle;
              cv.Pen.Style := np^.penstyle;
            End;
            If np^.Transp2 Then cv.Brush.Style := bsClear
            Else cv.Brush.Style := bsSolid;
            R2M(np^.x - np^.ha, np^.y + np^.hv, x1, y1);
            LimitToInteger(x1, y1);
            R2M(np^.x + np^.ha, np^.y - np^.hv, x2, y2);
            LimitToInteger(x2, y2);
            If (x1 = x2) And (y1 = y2) Then cv.Pixels[x1 - RcLRim + PosX, y1 - RcTRim + PosY] := c1
            Else Begin
              If x2 > x1 { these 6 lines are to compensate } Then inc(x2) { for a bug in the Delphi graphics }
              Else inc(x1);             { library }
              If y2 > y1 {.} Then inc(y2) {.}
              Else inc(y1);             { end of bug fix }
              cv.Ellipse(x1 - RcLrim + PosX, y1 - RcTRim + PosY, x2 - RcLrim + PosX, y2 - RcTRim + PosY);
            End;
          End;
        tk3DBar : Begin
            FinishPolyLine;
            If BlkWhite Then Begin
              c1 := clblack;
              c2 := clSilver;
            End
            Else Begin
              c1 := col;
              c2 := np^.fillcol4;
            End;
            If c1 <> LastPenCol Then Begin
              LastPenCol := c1;
              cv.Pen.Color := c1;
            End;
            If col <> LastBrushCol Then Begin
              LastBrushCol := c2;
              cv.Brush.Color := c2;
            End;
            If np^.penstyle <> LastPenStyle Then Begin
              LastPenStyle := np^.penstyle;
              cv.Pen.Style := np^.penstyle;
            End;
            R2M(np^.x, np^.y, x1, y1);
            LimitToInteger(x1, y1);
            R2M(np^.x3, np^.y3, x2, y2);
            LimitToInteger(x2, y2);
            If x1 > x2 Then
              Exchange(x1, x2, sizeof(x1));
            If y1 > y2 Then
              Exchange(y1, y2, sizeof(y1));
            x1 := x1 - RcLrim + PosX;
            y1 := y1 - RcTRim + PosY;
            x2 := x2 - RcLrim + PosX;
            y2 := y2 - RcTRim + PosY;
            dx := round(np^.depth * cos(np^.angle / 180 * Pi));
            dy := -round(np^.depth * sin(np^.angle / 180 * Pi));
            If np^.angle > 90 Then
              ExChange(x1, x2, sizeof(x1));
            cv.Polygon([Point(x1, y1), Point(x1 + dx, y1 + dy),
              Point(x2 + dx, y1 + dy), Point(x2, y1)]);
            cv.Polygon([Point(x2 + dx, y1 + dy), Point(x2, y1),
              Point(x2, y2), Point(x2 + dx, y2 + dy)]);
            If x2 > x1 { these 6 lines are to compensate } Then inc(x2) { for a bug in the Delphi graphics }
            Else inc(x1);               { library - basically, this is a bug }
            If y2 > y1 { in the Windows GDI } Then inc(y2) {.}
            Else inc(y1);               { end of bug fix }
            cv.Rectangle(x1, y1, x2, y2);
          End;
        tkRect : Begin
            FinishPolyLine;
            If BlkWhite Then Begin
              c1 := clblack;
              c2 := clSilver;
            End
            Else Begin
              c1 := col;
              c2 := np^.fillcol1;
            End;
            If c1 <> LastPenCol Then Begin
              LastPenCol := c1;
              cv.Pen.Color := c1;
            End;
            If col <> LastBrushCol Then Begin
              LastBrushCol := c2;
              cv.Brush.Color := c2;
            End;
            If np^.penstyle <> LastPenStyle Then Begin
              LastPenStyle := np^.penstyle;
              cv.Pen.Style := np^.penstyle;
            End;
            If np^.Transp1 Then cv.Brush.Style := bsClear
            Else cv.Brush.Style := bsSolid;
            R2M(np^.x, np^.y, x1, y1);
            LimitToInteger(x1, y1);
            R2M(np^.x2, np^.y2, x2, y2);
            LimitToInteger(x2, y2);
            If (x1 = x2) And (y1 = y2) Then cv.Pixels[x1 - RcLRim + PosX, y1 - RcTRim + PosY] := c1
            Else Begin
              If x2 > x1 { these 6 lines are to compensate } Then inc(x2) { for a bug in the Delphi graphics }
              Else inc(x1);             { library }
              If y2 > y1 {.} Then inc(y2) {.}
              Else inc(y1);             { end of bug fix }
              cv.Rectangle(x1 - RcLrim + PosX, y1 - RcTRim + PosY, x2 - RcLrim + PosX, y2 - RcTRim + PosY);
            End;
          End;
        tkRectFrame : Begin
            FinishPolyLine;
            If BlkWhite Then c2 := clSilver
            Else c2 := np^.fillcol2;
            If np^.penstyle <> LastPenStyle Then Begin
              LastPenStyle := np^.penstyle;
              cv.Pen.Style := np^.penstyle;
            End;
            If col <> LastPenCol Then Begin
              LastPenCol := c2;
              cv.Pen.Color := c2;
            End;
            If col <> LastBrushCol Then Begin
              LastBrushCol := c2;
              cv.Brush.Color := c2;
            End;
            R2M(np^.x, np^.y, x1, y1);
            LimitToInteger(x1, y1);
            R2M(np^.x2, np^.y2, x2, y2);
            LimitToInteger(x2, y2);
            If x1 > x2 Then
              Exchange(x1, x2, sizeof(x1));
            If y1 < y2 Then
              Exchange(y1, y2, sizeof(y1));
            If (x1 = x2) And (y1 = y2) Then cv.Pixels[x1 - RcLRim + PosX, y1 - RcTRim + PosY] := c2
            Else Begin
              cv.Rectangle(x1 - RcLRim + PosX, y1 - RcTRim + PosY, x2 - RcLRim + PosX, y2 - RcTRim + PosY);
              Case np^.framest Of       { now draw frame }
                rbRaised : Begin
                    cv.Pen.Color := np^.HiLightCol;
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX, y2 - RcTRim + PosY);
                    cv.LineTo(x2 - RcLRim + PosX, y2 - RcTRim + PosY);
                    cv.Pen.Color := np^.ShadowCol;
                    LastPenCol := np^.ShadowCol;
                    cv.LineTo(x2 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
                  End;
                rbLowered : Begin
                    cv.Pen.Color := np^.ShadowCol;
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX, y2 - RcTRim + PosY);
                    cv.LineTo(x2 - RcLRim + PosX, y2 - RcTRim + PosY);
                    cv.Pen.Color := np^.HiLightCol;
                    LastPenCol := np^.HiLightCol;
                    cv.LineTo(x2 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
                  End;
                rbEmbossed : Begin
                    cv.Pen.Color := np^.ShadowCol;
                    cv.MoveTo(x1 - RcLRim + PosX + 1, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX + 1, y2 - RcTRim + PosY + 1);
                    cv.LineTo(x2 - RcLRim + PosX, y2 - RcTRim + PosY + 1);
                    cv.LineTo(x2 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX + 1, y1 - RcTRim + PosY);
                    cv.Pen.Color := np^.HiLightCol;
                    LastPenCol := np^.HiLightCol;
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY - 1);
                    cv.LineTo(x1 - RcLRim + PosX, y2 - RcTRim + PosY);
                    cv.LineTo(x2 - RcLRim + PosX - 1, y2 - RcTRim + PosY);
                    cv.LineTo(x2 - RcLRim + PosX - 1, y1 - RcTRim + PosY - 1);
                    cv.LineTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY - 1);
                  End;
                rbEngraved : Begin
                    cv.Pen.Color := np^.HiLightCol;
                    cv.MoveTo(x1 - RcLRim + PosX + 1, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX + 1, y2 - RcTRim + PosY + 1);
                    cv.LineTo(x2 - RcLRim + PosX, y2 - RcTRim + PosY + 1);
                    cv.LineTo(x2 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX + 1, y1 - RcTRim + PosY);
                    cv.Pen.Color := np^.ShadowCol;
                    LastPenCol := np^.ShadowCol;
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY - 1);
                    cv.LineTo(x1 - RcLRim + PosX, y2 - RcTRim + PosY);
                    cv.LineTo(x2 - RcLRim + PosX - 1, y2 - RcTRim + PosY);
                    cv.LineTo(x2 - RcLRim + PosX - 1, y1 - RcTRim + PosY - 1);
                    cv.LineTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY - 1);
                  End;
              End;
            End;
          End;
        tkLine : Begin
            FinishPolyLine;
            If col <> LastPenCol Then Begin
              LastPenCol := col;
              cv.Pen.Color := col;
            End;
            If np^.penstyle <> LastPenStyle Then Begin
              LastPenStyle := np^.penstyle;
              cv.Pen.Style := np^.penstyle;
            End;
            R2M(np^.x, np^.y, x1, y1);
            LimitToInteger(x1, y1);
            R2M(np^.x2, np^.y2, x2, y2);
            LimitToInteger(x2, y2);
            If (x1 = x2) And (y1 = y2) Then cv.Pixels[x1 - RcLRim + PosX, y1 - RcTRim + PosY] := col
            Else Begin
              cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
              cv.LineTo(x2 - RcLRim + PosX, y2 - RcTRim + PosY);
            End;
          End;
        tkMarkAt : Begin
            FinishPolyLine;
            If col <> LastPenCol Then Begin
              LastPenCol := col;
              cv.Pen.Color := col;
            End;
            If np^.penstyle <> LastPenStyle Then Begin
              LastPenStyle := np^.penstyle;
              cv.Pen.Style := np^.penstyle;
            End;
            R2M(np^.x, np^.y, x1, y1);
            LimitToInteger(x1, y1);
            If np^.mark >= $30 Then Begin
                           { the following six lines are a work around for a nasty Windows bug
                             which causes the printer fonts to be scaled improperly (sometimes);
                             following the motto: beat dirty bugs with dirty tricks - sorry }
              If cv = Printer.Canvas Then Begin
                cv.Font.PixelsPerInch := Screen.PixelsPerInch;
                cv.Font.Size := np^.Size;
                cv.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
              End;
              tw := cv.TextWidth(chr(np^.mark));
              th := cv.TextHeight(chr(np^.mark));
              cv.TextOut(x1 - RcLRim + PosX - tw Div 2, y1 - RcTRim + PosY - th Div 2, chr(np^.mark));
            End
            Else Begin
              Case np^.mark Of
                0 : Begin               { pixel }
                    cv.Pixels[x1 - RcLRim + PosX, y1 - RcTRim + PosY] := col;
                  End;
                1 : Begin               { small plus }
                    If cv = Printer.Canvas Then Begin
                      cv.MoveTo(x1 - RcLRim + PosX - 2, y1 - RcTRim + PosY);
                      cv.LineTo(x1 - RcLRim + PosX + 2, y1 - RcTRim + PosY);
                      cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY - 2);
                      cv.LineTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY + 2);
                    End
                    Else DisplayMarkAsBitMap(1, col);
                  End;
                2 : Begin               { medium plus }
                    If cv = Printer.Canvas Then Begin
                      cv.MoveTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY);
                      cv.LineTo(x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY);
                      cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY - 3);
                      cv.LineTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY + 3);
                    End
                    Else DisplayMarkAsBitMap(2, col);
                  End;
                3 : Begin               { large plus }
                    If cv = Printer.Canvas Then Begin
                      cv.MoveTo(x1 - RcLRim + PosX - 4, y1 - RcTRim + PosY);
                      cv.LineTo(x1 - RcLRim + PosX + 4, y1 - RcTRim + PosY);
                      cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY - 4);
                      cv.LineTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY + 4);
                    End
                    Else DisplayMarkAsBitMap(3, col);
                  End;
                4 : Begin               { small cross }
                    If cv = Printer.Canvas Then Begin
                      cv.MoveTo(x1 - RcLRim + PosX - 2, y1 - RcTRim + PosY - 2);
                      cv.LineTo(x1 - RcLRim + PosX + 2, y1 - RcTRim + PosY + 2);
                      cv.MoveTo(x1 - RcLRim + PosX - 2, y1 - RcTRim + PosY + 2);
                      cv.LineTo(x1 - RcLRim + PosX + 2, y1 - RcTRim + PosY - 2);
                    End
                    Else DisplayMarkAsBitMap(4, col);
                  End;
                5 : Begin               { medium cross }
                    If cv = Printer.Canvas Then Begin
                      cv.MoveTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY - 3);
                      cv.LineTo(x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY + 3);
                      cv.MoveTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY + 3);
                      cv.LineTo(x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY - 3);
                    End
                    Else DisplayMarkAsBitMap(5, col);
                  End;
                6 : Begin               { large cross }
                    If cv = Printer.Canvas Then Begin
                      cv.MoveTo(x1 - RcLRim + PosX - 4, y1 - RcTRim + PosY - 4);
                      cv.LineTo(x1 - RcLRim + PosX + 4, y1 - RcTRim + PosY + 4);
                      cv.MoveTo(x1 - RcLRim + PosX - 4, y1 - RcTRim + PosY + 4);
                      cv.LineTo(x1 - RcLRim + PosX + 4, y1 - RcTRim + PosY - 4);
                    End
                    Else DisplayMarkAsBitMap(6, col);
                  End;
                7 : Begin               { small block }
                    cv.Brush.Color := col;
                    cv.Rectangle(x1 - RcLRim + PosX - 1, y1 - RcTRim + PosY - 1, x1 - RcLRim + PosX + 2, y1 - RcTRim + PosY + 2);
                  End;
                8 : Begin               { medium block }
                    cv.Brush.Color := col;
                    cv.Rectangle(x1 - RcLRim + PosX - 2, y1 - RcTRim + PosY - 2, x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY + 3);
                  End;
                9 : Begin               { large block }
                    cv.Brush.Color := col;
                    cv.Rectangle(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY - 3, x1 - RcLRim + PosX + 4, y1 - RcTRim + PosY + 4);
                  End;
                10 : Begin              { small empty block }
                    cv.MoveTo(x1 - RcLRim + PosX - 1, y1 - RcTRim + PosY - 1);
                    cv.LineTo(x1 - RcLRim + PosX - 1, y1 - RcTRim + PosY + 1);
                    cv.LineTo(x1 - RcLRim + PosX + 1, y1 - RcTRim + PosY + 1);
                    cv.LineTo(x1 - RcLRim + PosX + 1, y1 - RcTRim + PosY - 1);
                    cv.LineTo(x1 - RcLRim + PosX - 1, y1 - RcTRim + PosY - 1);
                  End;
                11 : Begin              { medium empty block }
                    cv.MoveTo(x1 - RcLRim + PosX - 2, y1 - RcTRim + PosY - 2);
                    cv.LineTo(x1 - RcLRim + PosX - 2, y1 - RcTRim + PosY + 2);
                    cv.LineTo(x1 - RcLRim + PosX + 2, y1 - RcTRim + PosY + 2);
                    cv.LineTo(x1 - RcLRim + PosX + 2, y1 - RcTRim + PosY - 2);
                    cv.LineTo(x1 - RcLRim + PosX - 2, y1 - RcTRim + PosY - 2);
                  End;
                12 : Begin              { large empty block }
                    cv.MoveTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY - 3);
                    cv.LineTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY + 3);
                    cv.LineTo(x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY + 3);
                    cv.LineTo(x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY - 3);
                    cv.LineTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY - 3);
                  End;
                13 : Begin              { small spade }
                    cv.Brush.Color := col;
                    quad[1].x := x1 - RcLRim + PosX - 1;
                    quad[1].y := y1 - RcTRim + PosY;
                    quad[2].x := x1 - RcLRim + PosX;
                    quad[2].y := y1 - RcTRim + PosY + 1;
                    quad[3].x := x1 - RcLRim + PosX + 1;
                    quad[3].y := y1 - RcTRim + PosY;
                    quad[4].x := x1 - RcLRim + PosX;
                    quad[4].y := y1 - RcTRim + PosY - 1;
                    cv.polygon(quad);
                  End;
                14 : Begin              { medium spade }
                    cv.Brush.Color := col;
                    quad[1].x := x1 - RcLRim + PosX - 2;
                    quad[1].y := y1 - RcTRim + PosY;
                    quad[2].x := x1 - RcLRim + PosX;
                    quad[2].y := y1 - RcTRim + PosY + 2;
                    quad[3].x := x1 - RcLRim + PosX + 2;
                    quad[3].y := y1 - RcTRim + PosY;
                    quad[4].x := x1 - RcLRim + PosX;
                    quad[4].y := y1 - RcTRim + PosY - 2;
                    cv.polygon(quad);
                  End;
                15 : Begin              { large spade }
                    cv.Brush.Color := col;
                    quad[1].x := x1 - RcLRim + PosX - 3;
                    quad[1].y := y1 - RcTRim + PosY;
                    quad[2].x := x1 - RcLRim + PosX;
                    quad[2].y := y1 - RcTRim + PosY + 3;
                    quad[3].x := x1 - RcLRim + PosX + 3;
                    quad[3].y := y1 - RcTRim + PosY;
                    quad[4].x := x1 - RcLRim + PosX;
                    quad[4].y := y1 - RcTRim + PosY - 3;
                    cv.polygon(quad);
                  End;
                16 : Begin              { medium circle }
                    cv.brush.Style := bsClear;
                    cv.Ellipse(x1 - RcLRim + PosX - 2, y1 - RcTRim + PosY - 2, x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY + 3);
                    cv.brush.Style := bsSolid;
                  End;
                17 : Begin              { large circle }
                    cv.brush.Style := bsClear;
                    cv.Ellipse(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY - 3, x1 - RcLRim + PosX + 4, y1 - RcTRim + PosY + 4);
                    cv.brush.Style := bsSolid;
                  End;
                18 : Begin              { large shaded block }
                    If cv = Printer.Canvas Then Begin
                      For i := 1 To 7 Do
                        For j := 1 To 7 Do
                          If (i Mod 2) + (j Mod 2) <> 1 Then Begin
                            cv.MoveTo(x1 - RcLRim + PosX + i - 4, y1 - RcTRim + PosY + j - 4);
                            cv.LineTo(x1 - RcLRim + PosX + i - 4, y1 - RcTRim + PosY + j - 4);
                          End;
                    End
                    Else DisplayMarkAsBitMap(18, col);
                  End;
                19 : Begin              { empty large spade }
                    cv.MoveTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY + 3);
                    cv.LineTo(x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY - 3);
                    cv.LineTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY);
                  End;
                20 : Begin              { small hat }
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY + 3);
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY + 3);
                  End;
                21 : Begin              { large hat }
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX - 4, y1 - RcTRim + PosY + 4);
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX + 4, y1 - RcTRim + PosY + 4);
                  End;
                22 : Begin              { small inverse hat }
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY - 3);
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY - 3);
                  End;
                23 : Begin              { large inverse hat }
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX - 4, y1 - RcTRim + PosY - 4);
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX + 4, y1 - RcTRim + PosY - 4);
                  End;
                24 : Begin              { large filled circle }
                    cv.Brush.Color := col;
                    cv.Ellipse(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY - 3, x1 - RcLRim + PosX + 4, y1 - RcTRim + PosY + 4);
                  End;
                25 : Begin              { large bold cross }
                    If cv = Printer.Canvas Then Begin
                      cv.MoveTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY - 3);
                      cv.LineTo(x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY + 3);
                      cv.MoveTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY - 2);
                      cv.LineTo(x1 - RcLRim + PosX + 2, y1 - RcTRim + PosY + 3);
                      cv.MoveTo(x1 - RcLRim + PosX - 2, y1 - RcTRim + PosY - 3);
                      cv.LineTo(x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY + 2);

                      cv.MoveTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY + 3);
                      cv.LineTo(x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY - 3);
                      cv.MoveTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY + 2);
                      cv.LineTo(x1 - RcLRim + PosX + 2, y1 - RcTRim + PosY - 3);
                      cv.MoveTo(x1 - RcLRim + PosX - 2, y1 - RcTRim + PosY + 3);
                      cv.LineTo(x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY - 2);
                    End
                    Else DisplayMarkAsBitMap(25, col);
                  End;
                26 : Begin              { medium filled circle }
                    cv.brush.Color := col;
                    cv.Ellipse(x1 - RcLRim + PosX - 2, y1 - RcTRim + PosY - 2, x1 - RcLRim + PosX + 3, y1 - RcTRim + PosY + 3);
                  End;
                27 : Begin              { small circle }
                    cv.brush.Style := bsClear;
                    cv.Ellipse(x1 - RcLRim + PosX - 2, y1 - RcTRim + PosY - 2, x1 - RcLRim + PosX + 2, y1 - RcTRim + PosY + 2);
                    cv.brush.Style := bsSolid;
                  End;
                28 : Begin              { small filled circle }
                    cv.brush.Color := col;
                    cv.Ellipse(x1 - RcLRim + PosX - 2, y1 - RcTRim + PosY - 2, x1 - RcLRim + PosX + 2, y1 - RcTRim + PosY + 2);
                  End;
                29 : Begin              { small filled triangle down }
                    cv.Brush.Color := col;
                    tri[1].x := x1 - RcLRim + PosX - 2;
                    tri[1].y := y1 - RcTRim + PosY;
                    tri[2].x := x1 - RcLRim + PosX;
                    tri[2].y := y1 - RcTRim + PosY + 2;
                    tri[3].x := x1 - RcLRim + PosX + 2;
                    tri[3].y := y1 - RcTRim + PosY;
                    cv.polygon(tri);
                  End;
                30 : Begin              { medium filled triangle down }
                    cv.Brush.Color := col;
                    tri[1].x := x1 - RcLRim + PosX - 3;
                    tri[1].y := y1 - RcTRim + PosY;
                    tri[2].x := x1 - RcLRim + PosX;
                    tri[2].y := y1 - RcTRim + PosY + 3;
                    tri[3].x := x1 - RcLRim + PosX + 3;
                    tri[3].y := y1 - RcTRim + PosY;
                    cv.polygon(tri);
                  End;
                31 : Begin              { small triangle down }
                    cv.brush.Style := bsClear;
                    tri[1].x := x1 - RcLRim + PosX - 2;
                    tri[1].y := y1 - RcTRim + PosY;
                    tri[2].x := x1 - RcLRim + PosX;
                    tri[2].y := y1 - RcTRim + PosY + 2;
                    tri[3].x := x1 - RcLRim + PosX + 2;
                    tri[3].y := y1 - RcTRim + PosY;
                    cv.polygon(tri);
                    cv.brush.Style := bsSolid;
                  End;
                32 : Begin              { medium triangle down }
                    cv.brush.Style := bsClear;
                    tri[1].x := x1 - RcLRim + PosX - 3;
                    tri[1].y := y1 - RcTRim + PosY;
                    tri[2].x := x1 - RcLRim + PosX;
                    tri[2].y := y1 - RcTRim + PosY + 3;
                    tri[3].x := x1 - RcLRim + PosX + 3;
                    tri[3].y := y1 - RcTRim + PosY;
                    cv.polygon(tri);
                    cv.brush.Style := bsSolid;
                  End;
                33 : Begin              { large triangle down }
                    cv.brush.Style := bsClear;
                    tri[1].x := x1 - RcLRim + PosX - 4;
                    tri[1].y := y1 - RcTRim + PosY - 3;
                    tri[2].x := x1 - RcLRim + PosX;
                    tri[2].y := y1 - RcTRim + PosY + 4;
                    tri[3].x := x1 - RcLRim + PosX + 4;
                    tri[3].y := y1 - RcTRim + PosY - 3;
                    cv.polygon(tri);
                    cv.brush.Style := bsSolid;
                  End;
                34 : Begin              { large filled triangle down }
                    cv.brush.Color := col;
                    tri[1].x := x1 - RcLRim + PosX - 4;
                    tri[1].y := y1 - RcTRim + PosY - 3;
                    tri[2].x := x1 - RcLRim + PosX;
                    tri[2].y := y1 - RcTRim + PosY + 4;
                    tri[3].x := x1 - RcLRim + PosX + 4;
                    tri[3].y := y1 - RcTRim + PosY - 3;
                    cv.polygon(tri);
                  End;
                35 : Begin              { large triangle up }
                    cv.brush.Style := bsClear;
                    tri[1].x := x1 - RcLRim + PosX - 4;
                    tri[1].y := y1 - RcTRim + PosY + 3;
                    tri[2].x := x1 - RcLRim + PosX;
                    tri[2].y := y1 - RcTRim + PosY - 4;
                    tri[3].x := x1 - RcLRim + PosX + 4;
                    tri[3].y := y1 - RcTRim + PosY + 3;
                    cv.polygon(tri);
                    cv.brush.Style := bsSolid;
                  End;
                36 : Begin              { large filled triangle up}
                    cv.brush.Color := col;
                    tri[1].x := x1 - RcLRim + PosX - 4;
                    tri[1].y := y1 - RcTRim + PosY + 3;
                    tri[2].x := x1 - RcLRim + PosX;
                    tri[2].y := y1 - RcTRim + PosY - 4;
                    tri[3].x := x1 - RcLRim + PosX + 4;
                    tri[3].y := y1 - RcTRim + PosY + 3;
                    cv.polygon(tri);
                  End;
                37 : Begin              { inverse T }
                    cv.MoveTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX + 4, y1 - RcTRim + PosY);
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY - 8);
                  End;
                38 : Begin              { rotated H }
                    cv.MoveTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY - 2);
                    cv.LineTo(x1 - RcLRim + PosX + 4, y1 - RcTRim + PosY - 2);
                    cv.MoveTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY + 2);
                    cv.LineTo(x1 - RcLRim + PosX + 4, y1 - RcTRim + PosY + 2);
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY - 2);
                    cv.LineTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY + 2);
                  End;
                39 : Begin              { large circle }
                    cv.brush.Style := bsClear;
                    cv.Ellipse(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY - 3, x1 - RcLRim + PosX + 4, y1 - RcTRim + PosY + 4);
                    cv.brush.Style := bsSolid;
                    cv.MoveTo(x1 - RcLRim + PosX - 3, y1 - RcTRim + PosY);
                    cv.LineTo(x1 - RcLRim + PosX + 4, y1 - RcTRim + PosY);
                    cv.MoveTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY - 3);
                    cv.LineTo(x1 - RcLRim + PosX, y1 - RcTRim + PosY + 4);
                  End;

              Else
                cv.Pixels[x1 - RcLRim + PosX, y1 - RcTRim + PosY] := Col;
              End;
            End;
          End;
      End;
    End;
    np := np^.next;
  End;
  FinishPolyLine;

  For i := MaxTxtLbl Downto 1 Do        { draw text labels in reverse order }
    If FTextLabels[i].FMode <> tlOff Then Begin
      If FTextLabels[i].FAttachDat Then Begin
        R2M(FTextLabels[i].FPosX, FTextLabels[i].FPosY, x1, y1);
        x1 := PosX + x1;
        y1 := PosY + y1;
      End
      Else Begin
        x1 := PosX + round(FTextLabels[i].FPosX);
        y1 := PosY + round(FTextLabels[i].FPosY);
      End;
      cv.Font := FTextLabels[i].FFont;
      cv.Pen.Color := FTextLabels[i].FColorBrd;
      cv.Pen.Style := psSolid;
      cv.Brush.Color := FTextLabels[i].FColorBkg;
      If FTextLabels[i].FTransPar Then cv.Brush.Style := bsClear
      Else cv.Brush.Style := bsSolid;
      numLines := 1;
      lastj := 0;
      tw := 0;                          // calc. text width for multi-line label
      j := 0;
      While j < length(FTextLabels[i].FCaption) Do Begin
        inc(j);
        If (FTextLabels[i].FCaption[j] = #10) Then Begin
          inc(numLines);
          twaux := cv.TextWidth(copy(FTextLabels[i].FCaption, lastj, j - lastj));
          lastj := j;
          If twaux > tw Then
            tw := twaux;
        End;
      End;
      twaux := cv.TextWidth(copy(FTextLabels[i].FCaption, lastj, j - lastj));
      If twaux > tw Then
        tw := twaux;
      If tw = 0 Then
        tw := cv.TextWidth(FTextLabels[i].FCaption);
      th := cv.TextHeight(FTextLabels[i].FCaption);
      Case FTextLabels[i].FAlignment Of
        taLeftJustify : Begin
          End;
        taCenter : x1 := x1 - tw Div 2;
        taRightJustify : x1 := x1 - tw;
      End;
      Case FTextLabels[i].FMode Of
        tlSimple : Begin
            If Not FTextLabels[i].FTransPar Then Begin
              cv.Pen.Color := FTextLabels[i].FColorBkg;
              cv.Rectangle(x1 - 4 - RcLRim, y1 - th * NumLines - 2 - RcTRim, x1 + 4 + tw - RcLRim, y1 + 2 - RcTRim);
            End;
          End;
        tlShadow : Begin
            cv.Pen.Color := FTextLabels[i].FColorShadow;
            cv.Brush.Color := FTextLabels[i].FColorShadow;
            cv.Rectangle(x1 - 4 - RcLRim + FTextLabels[i].FxShadow, y1 - th * NumLines - 2 - RcTRim + FTextLabels[i].FyShadow,
              x1 + 4 + tw - RcLRim + FTextLabels[i].FxShadow, y1 + 2 - RcTRim + FTextLabels[i].FyShadow);
            cv.Pen.Color := FTextLabels[i].FColorBrd;
            cv.Brush.Color := FTextLabels[i].FColorBkg;
            cv.Rectangle(x1 - 4 - RcLRim, y1 - th * NumLines - 2 - RcTRim, x1 + 4 + tw - RcLRim, y1 + 2 - RcTRim);
          End;
        tlBox : cv.Rectangle(x1 - 4 - RcLRim, y1 - th * NumLines - 2 - RcTRim, x1 + 4 + tw - RcLRim, y1 + 2 - RcTRim);
        tlUnderline : Begin
            If Not FTextLabels[i].FTransPar Then Begin
              cv.Pen.Color := FTextLabels[i].FColorBkg;
              cv.Rectangle(x1 - 4 - RcLRim, y1 - th * NumLines - 2 - RcTRim, x1 + 4 + tw - RcLRim, y1 + 2 - RcTRim);
            End;
            cv.Pen.Color := FTextLabels[i].FColorBrd;
            cv.MoveTo(x1 - RcLRim, y1 - RcTRim);
            cv.Lineto(x1 + tw - RcLRim, y1 - RcTRim)
          End;
      End;
      If NumLines = 1 Then Begin
        cv.TextOut(x1 - RcLRim, y1 - th - RcTRim, FTextLabels[i].FCaption);
      End
      Else Begin
        lastj := 0;
        nl := 0;
        j := 0;
        While j < length(FTextLabels[i].FCaption) Do Begin
          inc(j);
          If (FTextLabels[i].FCaption[j] = #10) Then Begin
            twaux := cv.TextWidth(copy(FTextLabels[i].FCaption, lastj + 1, j - lastj - 1));
            Case FTextLabels[i].FAlignment Of
              taLeftJustify : twaux := 0;
              taCenter : twaux := (tw - twaux) Div 2;
              taRightJustify : twaux := tw - twaux;
            End;
            cv.TextOut(x1 - RcLRim + twaux, y1 - th * NumLines - RcTRim + nl * th, copy(FTextLabels[i].FCaption, lastj + 1, j - lastj - 1));
            lastj := j;
            inc(nl);
          End;
        End;
        twaux := cv.TextWidth(copy(FTextLabels[i].FCaption, lastj + 1, j - lastj));
        Case FTextLabels[i].FAlignment Of
          taLeftJustify : twaux := 0;
          taCenter : twaux := (tw - twaux) Div 2;
          taRightJustify : twaux := tw - twaux;
        End;
        cv.TextOut(x1 - RcLRim + twaux, y1 - th - RcTRim, copy(FTextLabels[i].FCaption, lastj + 1, j - lastj));
      End;
    End;

  If Assigned(FOnDataRendered) Then     { provide a hook to insert user defined graphics }
    FOnDataRendered(self, cv, RcTRim - PosY, RcLRim - PosX);

  cv.Pen.Width := 1;
  cv.Pen.Color := RcScaleCol;
  cv.Pen.Style := psSolid;
  cv.MoveTo(PosX, PosY);                { redraw frame }
  cv.LineTo(width - RcLRim - RcRRim - Rc3DRim + PosX, PosY);
  cv.LineTo(width - RcLRim - RcRRim - Rc3DRim + PosX, height - RcTRim - RcBRim - Rc3DRim + PosY);
  cv.LineTo(PosX, height - RcTRim - RcBRim - Rc3DRim + PosY);
  cv.LineTo(PosX, PosY);

{$IFDEF SHAREWARE}
  Hint := GetHintStr;
  ShowHint := True;
  If Not DelphiIsRunning Then Begin
    cv.Font.Color := clWhite;
    cv.Font.Name := 'MS Sans Serif';
    cv.Brush.Color := clNavy;
    cv.Brush.Style := bsSolid;
    cv.Font.Size := 8;
    astr := GetVisMsgStr;
    j := 0;
    While length(astr) > 0 Do Begin
      i := pos(#10, astr);
      If i = 0 Then
        i := length(astr);
      cv.TextOut(10, 10 + 20 * j, ' ' + copy(astr, 1, i - 1) + ' ');
      inc(j);
      delete(astr, 1, i);
    End;
  End;
{$ENDIF}
End;

(******************************************************************)

Function TRChart.AddTextLabel(PosX, PosY : double; TxtColor : TColor;
  Txt : String; PropertyTemplate : integer) : integer;
(******************************************************************)

Var
  reslt             : integer;

Begin
  If (PropertyTemplate < 1) Or (PropertyTemplate > MaxTxtLbl) Then
    PropertyTemplate := 0;
  reslt := 1;

  While (FTextLabels[reslt].FMode <> tlOff) And (reslt < MaxTxtLbl) Do
    inc(reslt);

  If FTextLabels[reslt].FMode = tlOff Then Begin

    FTextLabels[reslt].FPosX := PosX;
    FTextLabels[reslt].FPosY := PosY;
    FTextLabels[reslt].FCaption := txt;
    FTextLabels[reslt].FFont.Color := TxtColor;

    If PropertyTemplate = 0 Then Begin
      FTextLabels[reslt].FAttachDat := true;
      FTextLabels[reslt].FAlignment := taCenter;
      FTextLabels[reslt].FColorBkg := RcChartCol;
      FTextLabels[reslt].FColorBrd := RcScaleCol;
      FTextLabels[reslt].FTranspar := false;
      FTextLabels[reslt].FMode := tlSimple;
    End Else Begin
      FTextLabels[reslt].FAttachDat := FTextLabels[PropertyTemplate].FAttachDat;
      FTextLabels[reslt].FAlignment := FTextLabels[PropertyTemplate].FAlignment;
      FTextLabels[reslt].FColorBkg := FTextLabels[PropertyTemplate].FColorBkg;
      FTextLabels[reslt].FColorBrd := FTextLabels[PropertyTemplate].FColorBrd;
      FTextLabels[reslt].FTranspar := FTextLabels[PropertyTemplate].FTranspar;
      FTextLabels[reslt].FMode := FTextLabels[PropertyTemplate].FMode;
      If FTextLabels[reslt].FMode = tlOff Then
        FTextLabels[reslt].FMode := tlSimple;
    End;

  End Else reslt := 0;

  AddTextLabel := reslt;

End;


(******************************************************************)

Procedure TRChart.ShowGraf;
(******************************************************************
ENTRY: none (only system parameters)

EXIT:  The graphics bitmap is copied to the chart canvas
*******************************************************************)

Var
  i                 : integer;

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'ShowGraf');
{$ENDIF}
  If Visible Then Begin
    RcLastCanOnShow := RcLastCan;
    AdjustCanInfoOfSharedCharts;
    If Not FAutoRedraw Then Paint       { create chart explicitly if AutoRedraw is off }
    Else Begin
      InitGraf(GrafBmp.Canvas, 0, 0);
      ConstructDataBmp(GrafBmp.Canvas, 0, 0, false, RcFrstCan);
      DrawFinish(RcLRim, RcTRim, GrafBmp);
    End;
  End;
  If FUseDataOf <> Nil Then Begin
    FUseDataOf.StyleChanged(self);
    For i := 1 To FUseDataOf.FDataUsersNum Do
      FUseDataOf.FDataUsers[i].StyleChanged(self);
  End;
  For i := 1 To FDataUsersNum Do
    FDataUsers[i].StyleChanged(self);
End;

(******************************************************************)

Procedure TRChart.ShowGrafNewOnly;
(******************************************************************
ENTRY: none (only system parameters)

EXIT:  The graphics bitmap is copied to the chart canvas
*******************************************************************)


Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'ShowGrafNewOnly');
{$ENDIF}
  If Visible Then Begin
    ConstructDataBmp(GrafBmp.Canvas, 0, 0, false, RcLastCanOnShow);
    DrawFinish(RcLRim, RcTRim, GrafBmp);
    RcLastCanOnShow := RcLastCan;
    AdjustCanInfoOfSharedCharts;
  End;
End;


(***********************************************************************)

Procedure TRChart.SetScaleCol(c : TColor);
(***********************************************************************)

Begin
  RcScaleCol := c;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetFillCol(c : TColor);
(***********************************************************************)

Begin
  RcFillCol := c;
End;

(***********************************************************************)

Procedure TRChart.SetDataCol(c : TColor);
(***********************************************************************)

Begin
  RcDataCol := c;
End;

(***********************************************************************)

Procedure TRChart.SetPenStyle(ps : TPenStyle);
(***********************************************************************)

Begin
  RcPenStyle := ps;
End;


(***********************************************************************)

Procedure TRChart.SetShadowColor(c : TColor);
(***********************************************************************)

Begin
  RcShadowColor := c;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetShadowBakColor(c : TColor);
(***********************************************************************)

Begin
  RcShadowBakCol := c;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;



(***********************************************************************)

Procedure TRChart.SetLineWid(w : byte);
(***********************************************************************)

Begin
  RcLineWid := w;
End;


(***********************************************************************)

Procedure TRChart.SetChartCol(c : TColor);
(***********************************************************************)

Begin
  RcChartCol := c;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetWindCol(c : TColor);
(***********************************************************************)

Begin
  RcWindCol := c;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetGridCol(c : TColor);
(***********************************************************************)

Begin
  RcGridCol := c;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetTitStr(hstr : String);
(***********************************************************************)

Begin
  TitStr := hstr;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetScaleInscrX(x : InscriptStr);
(***********************************************************************)

Begin
  RcScaleInscrX := x;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetScaleInscrY(x : InscriptStr);
(***********************************************************************)

Begin
  RcScaleInscrY := x;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Function TRChart.GetXUnits : LabelStr;
(***********************************************************************)

Begin
  GetXUnits := RcXUnits;
End;


(***********************************************************************)

Function TRChart.GetYUnits : LabelStr;
(***********************************************************************)

Begin
  GetYUnits := RcYUnits;
End;


(***********************************************************************)

Procedure TRChart.SetXUnits(hstr : LabelStr);
(***********************************************************************)

Begin
  RcXUnits := hstr;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;



(***********************************************************************)

Procedure TRChart.SetYUnits(hstr : LabelStr);
(***********************************************************************)

Begin
  RcYUnits := hstr;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;



(***********************************************************************)

Procedure TRChart.SetIsoMetric(im : boolean);
(***********************************************************************)

Begin
  FIsoMetric := im;
  If FIsoMetric Then Begin
    SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
    ZoomStateOnStack;
    If FAutoRedraw Or (csDesigning In ComponentState) Then
      Paint;
  End;
End;


(***********************************************************************)

Procedure TRChart.SetRcXLog(XLog : boolean);
(***********************************************************************)

Begin
  If XLog { check if logarithmic scale should be invoked } Then Begin
    If (RcBndLoX >= SmallPosNum) And
      (RcBndHiX >= SmallPosNum) And
      (RcXLabelType <> ftDateTime) Then { switch to log scale only if }
      RcXLog := XLog;                   { axis is positive and not DateTime }
  End
  Else RcXLog := XLog;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetShortTicksX(st : boolean);
(***********************************************************************)

Begin
  If RcShortTicksX <> st Then Begin
    RcShortTicksX := st;
    If FAutoRedraw Or (csDesigning In ComponentState) Then
      Paint;
  End;
End;

(***********************************************************************)

Procedure TRChart.SetShortTicksY(st : boolean);
(***********************************************************************)

Begin
  If RcShortTicksY <> st Then Begin
    RcShortTicksY := st;
    If FAutoRedraw Or (csDesigning In ComponentState) Then
      Paint;
  End;
End;



(***********************************************************************)

Procedure TRChart.SetRcYLog(YLog : boolean);
(***********************************************************************)

Begin
  If YLog { check if logarithmic scale should be invoked } Then Begin
    If (RcBndLoY >= SmallPosNum) And
      (RcBndHiY >= SmallPosNum) And
      (RcYLabelType <> ftDateTime) Then { switch to log scale only if }
      RcYLog := YLog;                   { axis is positive and not DateTime}
  End
  Else RcYLog := YLog;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetBakGndFile(x : TBakGndImg);
(***********************************************************************)

Begin
  FBakGndFile := x;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;




(***********************************************************************)

Procedure TRChart.SetClassDefault(DefClass : byte);
(***********************************************************************)

Begin
  If defClass <> 255 Then
    RcClassDefault := DefClass;
End;

(***********************************************************************)

Procedure TRChart.ZoomStateOnStack;
(***********************************************************************)

Begin
  If Not (csLoading In ComponentState) Then Begin
    FZoomStack[FZStackPoi, 1] := RCBndLoX;
    FZoomStack[FZStackPoi, 2] := RCBndLoY;
    FZoomStack[FZStackPoi, 3] := RCBndHiX;
    FZoomStack[FZStackPoi, 4] := RCBndHiY;
    inc(FZStackPoi);
    If FZStackPoi > MaxZoomStack Then
      FZStackPoi := 1;
  End;
End;



(***********************************************************************)

Procedure TRChart.SetMinRngX(r : double);
(***********************************************************************)

Begin
  If r > SmallPosNum Then Begin
    FMinRngDiffX := r;
    If (abs(RcBndHiX - RcBndLoX) < FMinRngDiffX) Then Begin
      RcBndLoX := (RcBndHiX + RcBndLoX) / 2 - FMinRngDiffX / 2;
      RcBndHiX := (RcBndHiX + RcBndLoX) / 2 + FMinRngDiffX / 2;
      If FIsoMetric Then
        SetBndHiX(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
      ZoomStateOnStack;
      AdjustScaling;
      If FAutoRedraw Or (csDesigning In ComponentState) Then
        Paint;
    End;
  End;
End;


(***********************************************************************)

Procedure TRChart.SetMinRngY(r : double);
(***********************************************************************)

Begin
  If r > SmallPosNum Then Begin
    FMinRngDiffY := r;
    If (abs(RcBndHiY - RcBndLoY) < FMinRngDiffY) Then Begin
      RcBndLoY := (RcBndHiY + RcBndLoY) / 2 - FMinRngDiffY / 2;
      RcBndHiY := (RcBndHiY + RcBndLoY) / 2 + FMinRngDiffY / 2;
      If FIsoMetric Then
        SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
      ZoomStateOnStack;
      AdjustScaling;
      If FAutoRedraw Or (csDesigning In ComponentState) Then
        Paint;
    End;
  End;
End;



(***********************************************************************)

Procedure TRChart.SetBndLoX(r : extended);
(***********************************************************************)

Begin
  If (abs(RcBndHiX - r) >= FMinRngDiffX) Then Begin
    If RcXLog { check if logarithmic scale is active } Then Begin
      If (r >= SmallPosNum) Then Begin
        RcBndLoX := r;                  { change extents only if value is positive }
        If FIsoMetric Then
          SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
        ZoomStateOnStack;
      End;
    End
    Else Begin
      RcBndLoX := r;
      If FIsoMetric Then
        SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
      ZoomStateOnStack;
    End;
  End
  Else Begin
    RcBndLoX := r;
    RcBndHiX := RcBndLoX + FMinRngDiffX;
    If FIsoMetric Then
      SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
    ZoomStateOnStack;
  End;
  AdjustScaling;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetBndHiX(r : extended);
(***********************************************************************)

Begin
  If (abs(RcBndLoX - r) >= FMinRngDiffX) Then Begin
    If RcXLog { check if logarithmic scale is active } Then Begin
      If (r >= SmallPosNum) Then Begin
        RcBndHiX := r;                  { change extents only if value is positive }
        If FIsoMetric Then
          SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
        ZoomStateOnStack;
      End;
    End Else Begin
      RcBndHiX := r;
      If FIsoMetric Then
        SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
      ZoomStateOnStack;
    End;
  End Else Begin
    RcBndHiX := r;
    RcBndLoX := RcBndHiX - FMinRngDiffX;
    If FIsoMetric Then
      SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
    ZoomStateOnStack;
  End;
  AdjustScaling;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetBndLoY(r : extended);
(***********************************************************************)

Begin
  If (abs(RcBndHiY - r) >= FMinRngDiffY) Then Begin
    If RcYLog { check if logarithmic scale is active } Then Begin
      If (r >= SmallPosNum) Then Begin
        RcBndLoY := r;                  { change extents only if value is positive }
        If FIsoMetric Then
          SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
        ZoomStateOnStack;
      End;
    End Else Begin
      RcBndLoY := r;
      If FIsoMetric Then
        SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
      ZoomStateOnStack;
    End;
  End Else Begin
    RcBndLoY := r;
    RcBndHiY := RcBndLoY + FMinRngDiffY;
    If FIsoMetric Then
      SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
    ZoomStateOnStack;
  End;
  AdjustScaling;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetBndHiY(r : extended);
(***********************************************************************)

Begin
  If (abs(RcBndLoY - r) >= FMinRngDiffY) Then Begin
    If RcYLog { check if logarithmic scale is active } Then Begin
      If (r >= SmallPosNum) Then Begin
        RcBndHiY := r;                  { change extents only if value is positive }
        If FIsoMetric Then
          RcBndLoY := RcBndHiY - (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp;
        ZoomStateOnStack;
      End;
    End
    Else Begin
      RcBndHiY := r;
      If FIsoMetric Then
        RcBndLoY := RcBndHiY - (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp;
      ZoomStateOnStack;
    End;
  End
  Else Begin
    RcBndHiY := r;
    RcBndLoY := RcBndHiY - FMinRngDiffY;
    If FIsoMetric Then
      RcBndLoY := RcBndHiY - (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp;
    ZoomStateOnStack;
  End;
  AdjustScaling;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.ConfineZoomRange(xLo, yLo, xHi, yHi : double);
(***********************************************************************)

Begin
  FZoomRange[1] := xLo;
  FZoomRange[3] := xHi;
  FZoomRange[2] := yLo;
  FZoomRange[4] := yHi;
End;

(***********************************************************************)

Procedure TRChart.ForceRange(xLo, yLo, xHi, yHi : extended;
  EnterToZoomStack : boolean; ConfineRange : boolean);
(***********************************************************************)

Var
  RChanged          : boolean;
  dx, dy            : double;

Begin
  RChanged := false;
  If ConfineRange Then
    If Not ((FZoomRange[1] = 0) And (FZoomRange[2] = 0) And
      (FZoomRange[3] = 0) And (FZoomRange[4] = 0)) Then Begin
      dx := xHi - xLo;
      dy := yHi - yLo;
      If (xLo < FZoomRange[1]) Then Begin
        xLo := FZoomRange[1];
        If (RcMouseAction = maPan) Or (RCMouseAction = maPanHoriz) Then
          xHi := xLo + dx;
      End;
      If (xLo > FZoomRange[3]) Then Begin
        xLo := FZoomRange[3];
        If (RcMouseAction = maPan) Or (RCMouseAction = maPanHoriz) Then
          xHi := xLo + dx;
      End;
      If (xHi < FZoomRange[1]) Then Begin
        xHi := FZoomRange[1];
        If (RcMouseAction = maPan) Or (RCMouseAction = maPanHoriz) Then
          xLo := xHi - dx;
      End;
      If (xHi > FZoomRange[3]) Then Begin
        xHi := FZoomRange[3];
        If (RcMouseAction = maPan) Or (RCMouseAction = maPanHoriz) Then
          xLo := xHi - dx;
      End;
      If (yLo < FZoomRange[2]) Then Begin
        yLo := FZoomRange[2];
        If (RcMouseAction = maPan) Or (RCMouseAction = maPanVert) Then
          yHi := yLo + dy;
      End;
      If (yLo > FZoomRange[4]) Then Begin
        yLo := FZoomRange[4];
        If (RcMouseAction = maPan) Or (RCMouseAction = maPanVert) Then
          yHi := yLo + dy;
      End;
      If (yHi < FZoomRange[2]) Then Begin
        yHi := FZoomRange[2];
        If (RcMouseAction = maPan) Or (RCMouseAction = maPanVert) Then
          yLo := yHi - dy;
      End;
      If (yHi > FZoomRange[4]) Then Begin
        yHi := FZoomRange[4];
        If (RcMouseAction = maPan) Or (RCMouseAction = maPanVert) Then
          yLo := yHi - dy;
      End;
    End;
  If abs(xLo - xHi) >= FMinRngDiffX Then Begin
    If RcXLog { check if logarithmic scale is active } Then Begin
      If (xLo >= SmallPosNum) Then Begin
        RcBndLoX := xLo;                { change extents only if axis is positive }
        RChanged := true;
      End;
      If (xHi >= SmallPosNum) Then Begin
        RcBndHiX := xHi;
        RChanged := true;
      End;
    End
    Else Begin
      RcBndHiX := xHi;
      RcBndLoX := xLo;
      RChanged := true;
    End;
  End;
  If abs(yLo - yHi) >= FMinRngDiffY Then Begin
    If RcYLog { check if logarithmic scale is active } Then Begin
      If (YLo >= SmallPosNum) Then Begin
        RcBndLoY := YLo;                { change extents only if axis is positive }
        RChanged := true;
      End;
      If (YHi >= SmallPosNum) Then Begin
        RcBndHiY := YHi;
        RChanged := true;
      End;
    End
    Else Begin
      RcBndHiY := yHi;
      RcBndLoY := yLo;
      RChanged := true;
    End;
  End;
  If Rchanged And EnterToZoomStack Then
    ZoomStateOnStack;
  AdjustScaling;
End;

(***********************************************************************)

Procedure TRChart.SetRange(xLo, yLo, xHi, yHi : extended);
(***********************************************************************)

Begin
  If xLo = xHi Then Begin
    xLo := xLo - FMinRngDiffX / 2;
    xHi := xHi + FMinRngDiffX / 2;
  End;
  If yLo = yHi Then Begin
    yLo := yLo - FMinRngDiffY / 2;
    yHi := yHi + FMinRngDiffY / 2;
  End;
  If FIsoMetric Then
    yHi := yLo + (xHi - xLo) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp;
  ForceRange(xLo, yLo, xHi, yHi, true, false);
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.AutoRange(Rim : double);
(***********************************************************************)

Var
  xLo, yLo          : double;
  xHi, yHi          : double;

Begin
  LLCalcExtents(RcFrstCan, Rim, xLo, yLo, xHi, yHi);
  If FIsoMetric Then
    yHi := yLo + (xHi - xLo) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp;
  ForceRange(xLo, yLo, xHi, yHi, true, false);
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetDecPlcX(d : integer);
(***********************************************************************)

Begin
  If d < -3 Then
    d := -3;
  If d > 12 Then
    d := 12;
  RcDecPlcX := d;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetDecPlcY(d : integer);
(***********************************************************************)

Begin
  If d < -3 Then
    d := -3;
  If d > 12 Then
    d := 12;
  RcDecPlcY := d;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetGridDx(dx : double);
(***********************************************************************)

Begin
  If dx >= -3 Then Begin
    RcGridDx := dx;
    If FAutoRedraw Or (csDesigning In ComponentState) Then
      Paint;
  End;
End;

(***********************************************************************)

Procedure TRChart.SetGridDy(dy : double);
(***********************************************************************)

Begin
  If dy >= -3 Then Begin
    RcGridDy := dy;
    If FAutoRedraw Or (csDesigning In ComponentState) Then
      Paint;
  End;
End;



(***********************************************************************)

Function TRChart.GetXNTick : integer;
(***********************************************************************)

Begin
  GetXNTick := RcXNTick;
End;

(***********************************************************************)

Function TRChart.GetYNTick : integer;
(***********************************************************************)

Begin
  GetYNTick := RcYNTick;
End;


(***********************************************************************)

Procedure TRChart.SetXNTick(d : integer);
(***********************************************************************)

Begin
  If d < 2 Then
    d := 2;
  If d > 20 Then
    d := 20;
  RcXNTick := d;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetYNTick(d : integer);
(***********************************************************************)

Begin
  If d < 2 Then
    d := 2;
  If d > 20 Then
    d := 20;
  RcYNTick := d;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetGridStyle(gs : GridStyleType);
(***********************************************************************)

Begin
  RcGridStyle := gs;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetShadowStyle(ss : TShadowStyle);
(***********************************************************************)

Begin
  RcShadowStyle := ss;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;



(***********************************************************************)

Procedure TRChart.SetLayout(x : boolean);
(***********************************************************************)

Begin
  FClassicLayout := x;
  Paint;
End;


(***********************************************************************)

Procedure TRChart.SetXAxPos(x : TXaxPos);
(***********************************************************************)

Begin
  FXaxPos := x;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetYAxPos(x : TYaxPos);
(***********************************************************************)

Begin
  FYaxPos := x;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetXLabType(x : FigType);
(***********************************************************************)

Begin
  RcXLabelType := x;
  If RcXLabelType = ftDateTime Then
    LogScaleX := false;
  If RcXLabelType = ftTime Then
    DecPlaceX := 4;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetYLabType(x : FigType);
(***********************************************************************)

Begin
  RcYLabelType := x;
  If RcYLabelType = ftDateTime Then
    LogScaleY := false;
  If RcYLabelType = ftTime Then
    DecPlaceY := 4;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetLRim(r : integer);
(***********************************************************************)

Var
  auxi              : integer;

Begin
  RcLRim := r;
  auxi := Width - RcLrim - RcRrim - Rc3DRim + 1;
  If auxi < 0 Then
    auxi := 0;
  GrafBmp.Width := auxi;
  AdjustScaling;
  If FIsoMetric Then
    SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetRRim(r : integer);
(***********************************************************************)

Var
  auxi              : integer;

Begin
  RcRRim := r;
  auxi := Width - RcLrim - RcRrim - Rc3DRim + 1;
  If auxi < 0 Then
    auxi := 0;
  GrafBmp.Width := auxi;
  AdjustScaling;
  If FIsoMetric Then
    SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetTRim(r : integer);
(***********************************************************************)

Var
  auxi              : integer;

Begin
  RcTRim := r;
  auxi := Height - RcTrim - RcBrim - Rc3DRim + 1;
  If auxi < 0 Then
    auxi := 0;
  GrafBmp.Height := auxi;
  AdjustScaling;
  If FIsoMetric Then
    SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;



(***********************************************************************)

Procedure TRChart.SetBRim(r : integer);
(***********************************************************************)

Var
  auxi              : integer;

Begin
  RcBRim := r;
  auxi := Height - RcTrim - RcBrim - Rc3DRim + 1;
  If auxi < 0 Then
    auxi := 0;
  GrafBmp.Height := auxi;
  AdjustScaling;
  If FIsoMetric Then
    SetBndHiY(RcBndLoY + (RcBndHiX - RcBndLoX) * (Height - RcTRim - RcBRim - Rc3DRim + 1) / (Width - RcLrim - RcRrim - Rc3DRim + 1) * Fyasp / Fxasp);
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetRc3DRim(r : integer);
(***********************************************************************)

Var
  auxi              : integer;

Begin
  If r < 0 Then
    r := 0;
  If r > 32 Then
    r := 32;
  Rc3DRim := r;
  auxi := Height - RcTrim - RcBrim - Rc3DRim + 1;
  If auxi < 0 Then
    auxi := 0;
  GrafBmp.Height := auxi;
  AdjustScaling;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;



(******************************************************************)

Procedure TRChart.MarkAt(x, y : double; mk : byte);
(******************************************************************
ENTRY: x,y ....... location where to place point (mark)
       mk  ....... type of mark

EXIT:  A mark is drawn at the location (x,y).
*******************************************************************)

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'MarkAt (', x : 1 : 3, ',', y : 1 : 3, ',', mk, ')');
{$ENDIF}
  RcLastCan^.Element := TkMarkAt;
  RcLastCan^.ItemClass := RcClassDefault;
  RcLastCan^.x := x;
  RcLastCan^.y := y;
  RcLastCan^.Color := RcDataCol;
  RcLastCan^.PenStyle := RcPenStyle;
  RcLastCan^.Tag := FDataTag;
  RcLastCan^.lWid := RcLineWid;
  RcLastCan^.mark := mk;
  inc(FItemCount[tkMarkAt]);

  RcLastCan^.Next := new(PDrawCan);     (* create new empty entry in item chain *)
  RcLastCan^.Next^.Prev := RcLastCan;
  RcLastCan := RcLastCan^.Next;
  RcLastCan^.Element := tkNone;
  RcLastCan^.Next := Nil;
  AdjustCanInfoOfSharedCharts;
End;

(******************************************************************)

Procedure TRChart.Text(x, y : double; size : integer; txt : String);
(******************************************************************
ENTRY: x,y ....... location where to place the text
       size ...... size of font
       txt ....... text to be entered

EXIT:  the text is drawn at the location (x,y).
*******************************************************************)

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'Text (', x : 1 : 3, ',', y : 1 : 3, ',', size, ',', txt, ')');
{$ENDIF}
  RcLastCan^.Element := tkText;
  RcLastCan^.ItemClass := RcClassDefault;
  RcLastCan^.x := x;
  RcLastCan^.y := y;
  RcLastCan^.Color := RcDataCol;
  RcLastCan^.PenStyle := RcPenStyle;
  RcLastCan^.Tag := FDataTag;
  RcLastCan^.lWid := RcLineWid;
  RcLastCan^.txt := txt;
  RcLastCan^.size := size;
  inc(FItemCount[tkText]);

  RcLastCan^.Next := new(PDrawCan);     (* create new entry in item chain *)
  RcLastCan^.Next^.Prev := RcLastCan;
  RcLastCan := RcLastCan^.Next;
  RcLastCan^.Element := tkNone;
  RcLastCan^.Next := Nil;
  AdjustCanInfoOfSharedCharts;
End;



(******************************************************************)

Procedure TRChart.MoveTo(x, y : double);
(******************************************************************
ENTRY: x,y ....... point where cursor to move to

EXIT:  drawing cursor is moved to [x,y]
*******************************************************************)

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'MoveTo (', x : 1 : 3, ',', y : 1 : 3, ')');
{$ENDIF}
  RcLastCan^.Element := TkMoveto;
  RcLastCan^.ItemClass := RcClassDefault;
  RcLastCan^.Color := RcDataCol;
  RcLastCan^.PenStyle := RcPenStyle;
  RcLastCan^.Tag := FDataTag;
  RcLastCan^.lWid := RcLineWid;
  RcLastCan^.x := x;
  RcLastCan^.y := y;
  inc(FItemCount[tkMoveTo]);

  RcLastCan^.Next := new(PDrawCan);     (* create new entry in item chain *)
  RcLastCan^.Next^.Prev := RcLastCan;
  RcLastCan := RcLastCan^.Next;
  RcLastCan^.Element := tkNone;
  RcLastCan^.Next := Nil;
  AdjustCanInfoOfSharedCharts;
End;

(******************************************************************)

Procedure TRChart.MoveToRelPix(dx, dy : integer);
(******************************************************************
ENTRY: dx,dy ....... rel. pixel coords. of pen to be moved

EXIT:  drawing cursor is moved to [x+dx,y+dy]
*******************************************************************)

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'MoveToRelPix (', dx : 1, ',', dy : 1, ')');
{$ENDIF}
  RcLastCan^.Element := TkMoveRelPix;
  RcLastCan^.ItemClass := RcClassDefault;
  RcLastCan^.Color := RcDataCol;
  RcLastCan^.PenStyle := RcPenStyle;
  RcLastCan^.Tag := FDataTag;
  RcLastCan^.lWid := RcLineWid;
  RcLastCan^.x := dx;
  RcLastCan^.y := dy;
  inc(FItemCount[tkMoveRelPix]);

  RcLastCan^.Next := new(PDrawCan);     (* create new entry in item chain *)
  RcLastCan^.Next^.Prev := RcLastCan;
  RcLastCan := RcLastCan^.Next;
  RcLastCan^.Element := tkNone;
  RcLastCan^.Next := Nil;
  AdjustCanInfoOfSharedCharts;
End;


(******************************************************************)

Procedure TRChart.DrawTo(x, y : double);
(******************************************************************
ENTRY: x,y ....... point where to draw to

EXIT:  line is drawn from current cursor location to [x,y]
*******************************************************************)

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'DrawTo (', x : 1 : 3, ',', y : 1 : 3, ')');
{$ENDIF}
  RcLastCan^.Element := TkLineto;
  RcLastCan^.ItemClass := RcClassDefault;
  RcLastCan^.x := x;
  RcLastCan^.y := y;
  RcLastCan^.Color := RcDataCol;
  RcLastCan^.PenStyle := RcPenStyle;
  RcLastCan^.Tag := FDataTag;
  RcLastCan^.lWid := RcLineWid;
  inc(FItemCount[tkLineTo]);

  RcLastCan^.Next := new(PDrawCan);     { create new entry in item chain }
  RcLastCan^.Next^.Prev := RcLastCan;
  RcLastCan := RcLastCan^.Next;
  RcLastCan^.Element := tkNone;
  RcLastCan^.Next := Nil;
  AdjustCanInfoOfSharedCharts;
End;

(******************************************************************)

Procedure TRChart.DrawToRelPix(dx, dy : integer);
(******************************************************************
ENTRY: dx,dy ....... rel. pixel coords where to draw to

EXIT:  line is drawn from current cursor location to [x+dx,y+dy]
*******************************************************************)

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'LineRelPix (', dx : 1, ',', dy : 1, ')');
{$ENDIF}
  RcLastCan^.Element := TkLineRelPix;
  RcLastCan^.ItemClass := RcClassDefault;
  RcLastCan^.x := dx;
  RcLastCan^.y := dy;
  RcLastCan^.Color := RcDataCol;
  RcLastCan^.PenStyle := RcPenStyle;
  RcLastCan^.Tag := FDataTag;
  RcLastCan^.lWid := RcLineWid;
  inc(FItemCount[tkLineRelPix]);

  RcLastCan^.Next := new(PDrawCan);     { create new entry in item chain }
  RcLastCan^.Next^.Prev := RcLastCan;
  RcLastCan := RcLastCan^.Next;
  RcLastCan^.Element := tkNone;
  RcLastCan^.Next := Nil;
  AdjustCanInfoOfSharedCharts;
End;



(******************************************************************)

Procedure TRChart.Rectangle(x1, y1, x2, y2 : double);
(******************************************************************
ENTRY: x,y ....... point where to draw to

EXIT:  line is drawn from current cursor location to [x,y]
*******************************************************************)

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'Rectangle (', x1 : 1 : 3, ',', y1 : 1 : 3, ',', x2 : 1 : 3, ',', y2 : 1 : 3, ')');
{$ENDIF}
  RcLastCan^.Element := tkRect;
  RcLastCan^.ItemClass := RcClassDefault;
  RcLastCan^.x := x1;
  RcLastCan^.y := y1;
  RcLastCan^.x2 := x2;
  RcLastCan^.y2 := y2;
  RcLastCan^.Color := RcDataCol;
  RcLastCan^.PenStyle := RcPenStyle;
  RcLastCan^.Tag := FDataTag;
  RcLastCan^.fillcol1 := RcFillCol;
  RcLastCan^.lWid := RcLineWid;
  RcLastCan^.transp1 := FTranspItems;
  inc(FItemCount[tkRect]);

  RcLastCan^.Next := new(PDrawCan);     (* create new entry in item chain *)
  RcLastCan^.Next^.Prev := RcLastCan;
  RcLastCan := RcLastCan^.Next;
  RcLastCan^.Element := tkNone;
  RcLastCan^.Next := Nil;
  AdjustCanInfoOfSharedCharts;
End;

(******************************************************************)

Procedure TRChart.RectFrame(x1, y1, x2, y2 : double;
  FrameStyle : TRFrameStyle;
  ShadowColor, HiLightColor : TColor);
(******************************************************************
ENTRY: x1,y1,x2,y2 ....... corners of rectangle
       FrameStyle ........ frame style of frame
       ShadowColor ....... color of shadow line
       HiLightColor ...... color of highlighted line

EXIT:  framed rectangle is drawn
*******************************************************************)

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'RectFrame (', x1 : 1 : 3, ',', y1 : 1 : 3, ',', x2 : 1 : 3, ',', y2 : 1 : 3, ')');
{$ENDIF}
  RcLastCan^.Element := tkRectFrame;
  RcLastCan^.ItemClass := RcClassDefault;
  RcLastCan^.x := x1;
  RcLastCan^.y := y1;
  RcLastCan^.x2 := x2;
  RcLastCan^.y2 := y2;
  RcLastCan^.Color := RcDataCol;
  RcLastCan^.PenStyle := RcPenStyle;
  RcLastCan^.Tag := FDataTag;
  RcLastCan^.fillcol2 := RcFillCol;
  RcLastCan^.lWid := 1;
  RcLastCan^.framest := FrameStyle;
  RcLastCan^.ShadowCol := ShadowColor;
  RcLastCan^.HiLightCol := HiLightColor;
  inc(FItemCount[tkRectFrame]);

  RcLastCan^.Next := new(PDrawCan);     (* create new entry in item chain *)
  RcLastCan^.Next^.Prev := RcLastCan;
  RcLastCan := RcLastCan^.Next;
  RcLastCan^.Element := tkNone;
  RcLastCan^.Next := Nil;
  AdjustCanInfoOfSharedCharts;
End;


(******************************************************************)

Procedure TRChart.Bar3D(llx, lly, urx, ury : double; Depth : integer;
  Angle : integer);
(******************************************************************
  ENTRY:  llx, lly ..... lower left corner
          urx, ury ..... upper right corner
          depth ........ of bar
          angle ........ projection angle in degrees

  EXIT:  A 3-dimensional bar is drawn
*******************************************************************)

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'Bar3D (', llx : 1 : 3, ',', lly : 1 : 3, ',', urx : 1 : 3, ',', ury : 1 : 3, ')');
{$ENDIF}
  RcLastCan^.Element := tk3DBar;
  RcLastCan^.ItemClass := RcClassDefault;
  RcLastCan^.x := llx;
  RcLastCan^.y := lly;
  RcLastCan^.x2 := urx;
  RcLastCan^.y2 := ury;
  RcLastCan^.Color := RcDataCol;
  RcLastCan^.PenStyle := RcPenStyle;
  RcLastCan^.Tag := FDataTag;
  RcLastCan^.fillcol4 := RcFillCol;
  RcLastCan^.lWid := RcLineWid;
  RcLastCan^.depth := depth;
  If angle > 180 Then
    angle := 180;
  If angle < 0 Then
    angle := 0;
  RcLastCan^.angle := angle;
  inc(FItemCount[tk3DBar]);

  RcLastCan^.Next := new(PDrawCan);     (* create new entry in item chain *)
  RcLastCan^.Next^.Prev := RcLastCan;
  RcLastCan := RcLastCan^.Next;
  RcLastCan^.Element := tkNone;
  RcLastCan^.Next := Nil;
  AdjustCanInfoOfSharedCharts;
End;

(******************************************************************)

Procedure TRChart.Ellipse(cx, cy, HorizAxLeng, VertAxLeng : double);
(******************************************************************
  ENTRY:  cx, cy ....... circle center
          HorizAxLeng .. half length of horizontal axis
          VertAxLeng ... half length of vertical axis

  EXIT:   An ellipse is drawn with center [cx,cy] and HorizAxLeng and
          VertAxLeng long axes
*******************************************************************)

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'Ellipse (', cx : 1 : 3, ',', cy : 1 : 3, '/', HorizAxLeng : 1 : 3, '/', VertAxLeng : 1 : 3, ')');
{$ENDIF}
  RcLastCan^.Element := tkEllipse;
  RcLastCan^.ItemClass := RcClassDefault;
  RcLastCan^.x := cx;
  RcLastCan^.y := cy;
  RcLastCan^.ha := HorizAxLeng;
  RcLastCan^.hv := VertAxLeng;
  RcLastCan^.color := RcDataCol;
  RcLastCan^.PenStyle := RcPenStyle;
  RcLastCan^.Tag := FDataTag;
  RcLastCan^.fillcol3 := RcFillCol;
  RcLastCan^.transp2 := FTranspItems;
  RcLastCan^.lWid := RcLineWid;
  inc(FItemCount[tkEllipse]);

  RcLastCan^.Next := new(PDrawCan);     (* create new entry in item chain *)
  RcLastCan^.Next^.Prev := RcLastCan;
  RcLastCan := RcLastCan^.Next;
  RcLastCan^.Element := tkNone;
  RcLastCan^.Next := Nil;
  AdjustCanInfoOfSharedCharts;
End;



(******************************************************************)

Procedure TRChart.Line(x1, y1, x2, y2 : double);
(******************************************************************
ENTRY: x1,y1 ....... starting point of line
       x2,y2 ....... end point of line

EXIT:  line is drawn between [x1,y1] and [x2,y2]
*******************************************************************)

Begin
{$IFDEF DEBUG}
  writeln(DebugFile, (GetTickCount - StartSysTime) / 1000 : 8 : 2, ': ', 'Line (', x1 : 1 : 3, ',', y2 : 1 : 3, ',', x2 : 1 : 3, ',', y2 : 1 : 3, ')');
{$ENDIF}
  RcLastCan^.Element := TkLine;
  RcLastCan^.ItemClass := RcClassDefault;
  RcLastCan^.x := x1;
  RcLastCan^.y := y1;
  RcLastCan^.x2 := x2;
  RcLastCan^.y2 := y2;
  RcLastCan^.Color := RcDataCol;
  RcLastCan^.PenStyle := RcPenStyle;
  RcLastCan^.Tag := FDataTag;
  RcLastCan^.lwid := RcLineWid;
  inc(FItemCount[tkLine]);

  RcLastCan^.Next := new(PDrawCan);     (* create new entry in item chain *)
  RcLastCan^.Next^.Prev := RcLastCan;
  RcLastCan := RcLastCan^.Next;
  RcLastCan^.Element := tkNone;
  RcLastCan^.Next := Nil;
  AdjustCanInfoOfSharedCharts;
End;

(***********************************************************************)

Procedure TRChart.SetFTextLabel(ix : integer; value : TTextLabel);
(***********************************************************************)

Begin
  FTextLabels[ix].Assign(value);
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Function TRChart.GetFTextLabel(ix : integer) : TTextLabel;
(***********************************************************************)

Begin
  GetFTextLabel := FTextLabels[ix];
End;


(***********************************************************************)

Function TRChart.GetCrossHair1 : TCrossHair;
(***********************************************************************)

Begin
  GetCrossHair1 := FCrossHair[1];
End;

(***********************************************************************)

Function TRChart.GetCrossHair2 : TCrossHair;
(***********************************************************************)

Begin
  GetCrossHair2 := FCrossHair[2];
End;

(***********************************************************************)

Function TRChart.GetCrossHair3 : TCrossHair;
(***********************************************************************)

Begin
  GetCrossHair3 := FCrossHair[3];
End;

(***********************************************************************)

Function TRChart.GetCrossHair4 : TCrossHair;
(***********************************************************************)

Begin
  GetCrossHair4 := FCrossHair[4];
End;


(***********************************************************************)

Procedure TRChart.SetCrossHair1(x : TCrossHair);
(***********************************************************************)

Begin
  FCrossHair[1].Assign(x);
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetCrossHair2(x : TCrossHair);
(***********************************************************************)

Begin
  FCrossHair[2].Assign(x);
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetCrossHair3(x : TCrossHair);
(***********************************************************************)

Begin
  FCrossHair[3].Assign(x);
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetCrossHair4(x : TCrossHair);
(***********************************************************************)

Begin
  FCrossHair[4].Assign(x);
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;





(***********************************************************************)

Procedure TRChart.SetDTXFormat(x : TDTLabel);
(***********************************************************************)

Begin
  FDTXFormat.Assign(x);
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetDTYFormat(x : TDTLabel);
(***********************************************************************)

Begin
  FDTYFormat.Assign(x);
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;



(***********************************************************************)

Procedure TRChart.StyleChanged(Sender : TObject);
(***********************************************************************)

Begin
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetUseDataOf(orc : TRChart);
(***********************************************************************)

Var
  np                : PDrawCan;
  this              : PDrawCan;
  i, j              : integer;
  found             : boolean;

Begin
  If (orc = self) Then Begin
    MessageDlg('RChart: Cannot share data with myself', mtInformation, [mbOK], 0);
  End
  Else If (FDataUsersNum > 0) Then Begin
    MessageDlg('RChart: Cannot use foreign data. Other RCharts are using my own data.', mtInformation, [mbOK], 0);
  End
  Else If (orc <> FUseDataOf) Then Begin
    If (orc = Nil) Then Begin
      If FUseDataOf <> Nil Then Begin
        RcLastCan := New(PDrawCan);     // create own linked list
        RcFrstCan := RcLastCan;
        RcLastCanOnShow := RcLastCan;
        RcLastCan^.Element := tkNone;
        RCLastCan^.Prev := Nil;
        RCLastCan^.Next := Nil;
        i := 0;
        found := false;
        While (i < FUseDataOf.FDataUsersNum) And Not found Do Begin
                                        // remove entry in master
          inc(i);
          If FUseDataOf.FDataUsers[i] = self Then
            found := true;
        End;
        If found Then Begin
          For j := i To MaxDataUsers - 1 Do
            FUseDataOf.FDataUsers[j] := FUseDataOf.FDataUsers[j + 1];
          FUseDataOf.FDataUsers[MaxDataUsers] := Nil;
          dec(FUseDataOf.FDataUsersNum);
        End;
        FUseDataOf := Nil;
        StyleChanged(self);
      End;
    End
    Else Begin
      If orc.FUseDataOf <> Nil Then orc := orc.FUseDataOf;
      If orc.FDataUsersNum >= MaxDataUsers Then MessageDlg('RChart: Max. number of data shares exceeded', mtInformation, [mbOK], 0)
      Else Begin
        If FUseDataOf = Nil Then Begin  // remove own linked list
          this := RcFrstCan;
          While this^.Element <> tkNone Do Begin
            np := this^.Next;
            Dispose(this);
            this := np;
          End;
          Dispose(this);
        End
        Else Begin
          i := 0;
          found := false;
          While (i < FUseDataOf.FDataUsersNum) And Not found Do Begin
                                        // remove entry in master
            inc(i);
            If FUseDataOf.FDataUsers[i] = self Then
              found := true;
          End;
          If found Then Begin
            For j := i To MaxDataUsers - 1 Do
              FUseDataOf.FDataUsers[j] := FUseDataOf.FDataUsers[j + 1];
            FUseDataOf.FDataUsers[MaxDataUsers] := Nil;
            dec(FUseDataOf.FDataUsersNum);
          End;
        End;
        FUseDataOf := orc;
        RcFrstCan := FUseDataOf.RcFrstCan;
        RcLastCan := FUseDataOf.RcLastCan;
        RcLastCanOnSHow := FUseDataOf.RcLastCanOnShow;
        orc.FDataUsers[orc.FDataUsersNum + 1] := self;
        inc(orc.FDataUsersNum);
        StyleChanged(self);
      End;
    End;
  End;
End;

(***********************************************************************)

Procedure TRChart.AdjustCanInfoOfSharedCharts;
(***********************************************************************)

Var
  i                 : integer;

Begin
  If FUseDataOf <> Nil Then Begin
    FUseDataOf.RcFrstCan := RcFrstCan;
    FUseDataOf.RcLastCan := RcLastCan;
    FUseDataOf.RcLastCanOnShow := RcLastCanOnShow;
    FUseDataOf.FItemCount := FItemCount;
    For i := 1 To FUseDataOf.FDataUsersNum Do Begin
      FUseDataOf.FDataUsers[i].RcFrstCan := RcFrstCan;
      FUseDataOf.FDataUsers[i].RcLastCan := RcLastCan;
      FUseDataOf.FDataUsers[i].RcLastCanOnShow := RcLastCanOnShow;
      FUseDataOf.FDataUsers[i].FItemCount := FItemCount;
    End;
  End;
  For i := 1 To FDataUsersNum Do Begin
    FDataUsers[i].RcFrstCan := RcFrstCan;
    FDataUsers[i].RcLastCan := RcLastCan;
    FDataUsers[i].RcLastCanOnShow := RcLastCanOnShow;
    FDataUsers[i].FItemCount := FItemCount;
  End;
End;


(***********************************************************************)

Procedure TRChart.SetTextFontStyle(tfs : TFontStyles);
(***********************************************************************)

Begin
  FTextFontStyle := tfs;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetTextBkStyle(bs : TTextBkg);
(***********************************************************************)

Begin
  FTextBkStyle := bs;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRchart.SetTextBkColor(bc : TColor);
(***********************************************************************)

Begin
  FTextBkColor := bc;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRchart.SetTextAlignment(al : TAlignment);
(***********************************************************************)

Begin
  FTextAlignment := al;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

(***********************************************************************)

Procedure TRChart.SetUserTickTextX(txt : String);
(***********************************************************************)

Begin
  FUserTickTextX := txt;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;


(***********************************************************************)

Procedure TRChart.SetUserTickTextY(txt : String);
(***********************************************************************)

Begin
  FUserTickTextY := txt;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

Procedure TRChart.SetYarMashTab(M : double);
Begin
  If FYarMashTab = M Then exit;
  FYarMashTab := M;
  If FAutoRedraw Or (csDesigning In ComponentState) Then
    Paint;
End;

{$WARNINGS OFF}
End.

