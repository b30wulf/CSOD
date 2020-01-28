unit rcproped;

(*********************************************************************)
(*                                                                   *)
(*                                                                   *)
(*                          R C P R O P E D                          *)
(*                    property editor for RChart                     *)
(*                                                                   *)
(*                     SDL Component Suite 6.0                       *)
(*                                                                   *)
(*     (C) 1996..2001 H. Lohninger                    January 1996   *)
(*                    P.O.B. 123                                     *)
(*                    Vienna, Austria, Europe                        *)
(*                                                                   *)
(*     Last Update: Oct-08, 1999                                     *)
(*                                                                   *)
(*********************************************************************)

{ Release History:

5.0    [Oct-09, 1999]
       RCPROPED has been extracted from RChart to make design interface independent
          from run-time units (was necessary with Delphi 5.0)

5.5    [May-01, 2000]
       available for C++Builder 5.0

6.0    [May-30, 2001]
       available for Delphi 6.0

}

{------------------------------------------------------------------------------}
interface
{------------------------------------------------------------------------------}

uses
  rchart, classes, controls, forms, dialogs, stdctrls, extctrls, buttons,
{$IFDEF VER140}
  designeditors, designintf          //Delphi 6.0 has changed access to design interface
{$ELSE}
  dsgnintf
{$ENDIF}
  ;

type
  TrcBakBMPEditor = class(TForm)
                      CBIncldPath: TCheckBox;
                      CBFillMode: TComboBox;
                      SBLoadBMP: TSpeedButton;
                      SBOK: TSpeedButton;
                      EdName: TEdit;
                      Label1: TLabel;
                      SBCancel: TSpeedButton;
                      Image1: TImage;
                      Bevel1: TBevel;
                      LblDims: TLabel;
                      procedure SBLoadBMPClick(Sender: TObject);
                      procedure CBIncldPathClick(Sender: TObject);
                      procedure SBOKClick(Sender: TObject);
                      procedure SBCancelClick(Sender: TObject);
                    private
                        { Private declarations }
                    public
                      FullName : string;
                    end;

procedure Register;

{------------------------------------------------------------------------------}
implementation
{------------------------------------------------------------------------------}

uses
  SysUtils;

{$R *.DFM}


type
  TBakGndFileProperty = class(TClassProperty)
                        public
                          procedure Edit; override;
                          function GetAttributes: TPropertyAttributes; override;
                        end;


(***********************************************************************)
procedure TrcBakBMPEditor.SBLoadBMPClick(Sender: TObject);
(***********************************************************************)

var
  OpenDialog : TOpenDialog;

begin
OpenDialog := TOpenDialog.Create(Application);
try
  OpenDialog.Filter := 'Bitmap Files|*.bmp';
  OpenDialog.FileName := '*.bmp';
  if OpenDialog.Execute then
    begin
    FullName := lowercase(OpenDialog.Filename);
    if CBIncldPath.Checked
      then EdName.Text := FullName
      else EdName.Text := ExtractFileName(FullName);
    Image1.Picture.LoadFromFile (FullName);
    LblDims.Caption := RCSPecstrf(Image1.Picture.Width,1,0)+'  X  '+
                       RCSpecstrf(Image1.Picture.Height,1,0);
    end;
finally
  OpenDialog.Free;
end;
end;

(***********************************************************************)
procedure TrcBakBMPEditor.CBIncldPathClick(Sender: TObject);
(***********************************************************************)

begin
if CBIncldPath.Checked
  then EdName.Text := FullName
  else EdName.Text := ExtractFileName(FullName);
end;

(***********************************************************************)
procedure TrcBakBMPEditor.SBOKClick(Sender: TObject);
(***********************************************************************)

begin
close;
ModalResult := mrOK;
end;

(***********************************************************************)
procedure TrcBakBMPEditor.SBCancelClick(Sender: TObject);
(***********************************************************************)

begin
close;
ModalResult := mrCancel;
end;



(***********************************************************************)
procedure TBakGndFileProperty.Edit;
(***********************************************************************)

var
  Editor : TrcBakBMPEditor;

begin
Editor := TrcBakBMPEditor.Create(Application);
try
  case TBakGndImg(GetOrdValue).FillMode of
    bfSimple : Editor.CBFillMode.Text := 'bfSimple';
      bfTile : Editor.CBFillMode.Text := 'bfTile';
   bfStretch : Editor.CBFillMode.Text := 'bfStretch';
  end;
  Editor.CBIncldPath.Checked := TBakGndImg(GetOrdValue).IncludePath;
  Editor.FullName := TBakGndImg(GetOrdValue).Name;
  Editor.EdName.Text := Editor.FullName;
  try
    Editor.Image1.Picture.LoadFromFile (Editor.FullName);
  except
  end;
  Editor.LblDims.Caption := RCSPecstrf(Editor.Image1.Picture.Width,1,0)+'  X  '+
                            RCSpecstrf(Editor.Image1.Picture.Height,1,0);
  if Editor.ShowModal = mrOK then
    begin
    TBakGndImg(GetOrdValue).IncludePath := Editor.CBIncldPath.Checked;
    TBakGndImg(GetOrdValue).Name := Editor.EdName.Text;
    if Editor.CBFillMode.Text = 'bfSimple'
      then TBakGndImg(GetOrdValue).FillMode := bfSimple
      else if Editor.CBFillMode.Text = 'bfTile'
             then TBakGndImg(GetOrdValue).FillMode := bfTile
             else TBakGndImg(GetOrdValue).FillMode := bfStretch;
    end;
finally
  Editor.Free;
end;
end;


(***********************************************************************)
function TBakGndFileProperty.GetAttributes: TPropertyAttributes;
(***********************************************************************)

begin
Result := [paDialog, paSubProperties];
end;


(***********************************************************************)
procedure Register;
(***********************************************************************)

begin
RegisterComponents ('SDL', [TRChart]);
RegisterPropertyEditor (TypeInfo(TBakGndImg), TRChart, '', TBakGndFileProperty);
end;


end.
 
