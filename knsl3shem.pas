unit knsl3shem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask;

type
  TTShemModule = class(TForm)
    Image1: TImage;
    lbUkv: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    procedure OnCloseForm(Sender: TObject; var Action: TCloseAction);
    procedure OnCreateForm(Sender: TObject);
    procedure OnClick(Sender: TObject);
  private
    { Private declarations }
  private
    FABOID    : Integer;
    FMID      : Integer;
    FVMID     : Integer;
    FGID      : Integer;
    FPRID     : Integer;
    FTID      : Integer;
  public
    procedure PrepareForm;
    procedure Init;
    procedure SaveForm;
    Procedure LoadFormFromFile(strPath:String);
    procedure LoadBitmap(strPath:String);
  public
    property PABOID   : Integer         read FABOID    write FABOID;
    property PMID     : Integer         read FMID      write FMID;
    property PVMID    : Integer         read FVMID     write FVMID;
    property PGID     : Integer         read FGID      write FGID;
    property PPRID    : Integer         read FPRID     write FPRID;
    property PTID     : Integer         read FTID      write FTID;
  end;

var
  TShemModule: TTShemModule;

implementation

{$R *.DFM}
procedure TTShemModule.OnCloseForm(Sender: TObject;
  var Action: TCloseAction);
begin
      Action := caFree;
end;
procedure TTShemModule.Init;
Begin

End;
procedure TTShemModule.PrepareForm;
Begin

End;
procedure TTShemModule.OnCreateForm(Sender: TObject);
Var
     strPath : String;
begin
     // «агрузка картинки
     //strPath := 'D:\Kon2\energo\bmp\bmp\GPP1_1.BMP';
     //LoadBitmap(strPath);
     registerClasses([TForm, TLabel,TImage]);
end;
procedure TTShemModule.LoadBitmap(strPath:String);
Begin
    //Image2.Picture.LoadFromFile(strPath);
End;

procedure TTShemModule.OnClick(Sender: TObject);
begin
      //—охранить форму в файл
end;
procedure TTShemModule.SaveForm;
Var
  BinStream, StrStream : TMemoryStream;
  TC, AComp         : TControl;
  I, K              : Integer;
  StList            : TStringList;
  St,strForm,strPath: String;
Begin
  BinStream := TMemoryStream.Create;
  StrStream := TMemoryStream.Create;
  TC := TControl.Create(Nil);
  StList := TStringList.Create;

  K := ComponentCount;
  I := 0;

  While (I < K) And (K > 0) Do
    If (Not (Components[I] Is TControl)) Then Begin
      TC.InsertComponent(Components[I]);
      RemoveComponent(Components[I]);
      K := ComponentCount;
    End Else Inc(I);
  BinStream.WriteComponent(Self);
  BinStream.Position := 0;
  ObjectBinaryToText(BinStream, StrStream);

  StrStream.Seek(0, soFromBeginning);
  StList.LoadFromStream(StrStream);

  StList[0] := 'object TShemModule: TForm';

  For I := 1 To StList.Count Do Begin
    St := StList[I - 1];
    If Pos('OnActivate = FormActivate', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnGetValue = GetValue', St) > 0 Then StList[I - 1] := ''


    Else If Pos('OnClick = ', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnCreate = ', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnDblClick = ', St) > 0 Then StList[I - 1] := ''

    Else If Pos('OnClick = FormClick', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnClose = OnCloseForm', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnDblClick = FormDblClick', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnKeyPress = FormKeyPress', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnPaint = FormPaint', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnDestroy = FormDestroy', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnDragDrop = FormDragDrop', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnDragOver = FormDragOver', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnMouseDown = FormMouseDown', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnMouseMove = FormMouseMove', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnMouseUp = FormMouseUp', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnResize = FormResize', St) > 0 Then StList[I - 1] := ''
    Else If Pos('PopupMenu = MainForm.InfoMenu', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnStartMovePage = FormMouseDown', St) > 0 Then StList[I - 1] := ''
    Else If Pos('OnMovePage = FormMouseMove', St) > 0 Then StList[I - 1] := '';
  End;

  strForm := Caption+'.dfm';
  strForm := StringReplace(strForm,' ','',[rfReplaceAll]);
  strForm := StringReplace(strForm,':','',[rfReplaceAll]);
  strPath := ExtractFilePath(Application.ExeName)+strForm;

  StList.SaveToFile(strPath);

  K := TC.ComponentCount;
  While K > 0 Do Begin
    AComp := TControl(TC.Components[0]);
    TC.RemoveComponent(AComp);
    InsertComponent(AComp);
    K := TC.ComponentCount;
  End;


  BinStream.Free;
  StrStream.Free;
  StList.Free;
  TC.Free;
  //LoadFormFromFile('D:\Kon2\—хемы—уммапо”ћ√1.dfm');
  LoadFormFromFile(strPath);
End;

Procedure TTShemModule.LoadFormFromFile(strPath:String);
Var
  InStream, BinStream : TMemoryStream;
//  StList            : TStringList;
//  St                : String;
  I, K, NAddr       : integer;
  AComps            : TComponent;
Begin

  BinStream := TMemoryStream.Create;
  InStream := TMemoryStream.Create;
//  StrStream := TMemoryStream.Create;
//  StList := TStringList.Create;

  InStream.LoadFromFile(strPath);

  InStream.Position := 0;
  ObjectTextToBinary(InStream, BinStream);

//  K := ComponentCount;
//  I := 0;
//
//  While (I < K) And (K > 0) Do
//    If ((Components[I] Is TControl)) Then Begin
//      Components[I].Destroy;
//      K := ComponentCount;
//    End Else Inc(I);

  BinStream.Position := 0;
  AComps := BinStream.ReadComponent(Nil);


//  While AComps.ComponentCount > 0 Do Begin
//    TC := TControl(AComps.Components[0]);
//    TC.Parent := Self;
//    AComps.RemoveComponent(TC);
//    InsertComponent(TC);
//    (TC As TButton).OnClick := Button2Click;
//  End;
  //TForm

  {
  For I := 1 To AComps.ComponentCount Do
    If TControl(AComps.Components[I - 1]) Is TForm Then
      (AComps.Components[I - 1] As TForm).OnClose := OnCloseForm;
  AComps.free;
  }

End;



end.
