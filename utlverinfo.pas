unit utlverinfo; //������ 1.0 3/8/98 �������� � ��������� � Delphi 3.
(*����� Rick Peterson, ������ ��������� ���������������� ��������

� ���������� �� ����� �� �������������. � ������ ���������
���������� ���� ������� �������� ���������� ���. ��������� ����������
��� ���� ��������� �������. ����� ��� ����� - rickpet@airmail.net. *)

interface

uses

  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TypInfo;

type
{$M+}
  (* ������ ��������� $M+??? ��� ���������� Delphi �������� � ��� RTTI-���������� ���

  ������������ �����. � �������� ��������� ������ � ������������� ������ ���
  �� �������� � ������� GetEnumName *)
  TVersionType = (vtCompanyName, vtFileDescription, vtFileVersion,
    vtInternalName,
    vtLegalCopyright, vtLegalTradeMark, vtOriginalFileName,
    vtProductName, vtProductVersion, vtComments);
{$M-}
  LANGANDCODEPAGE = packed record
    wLanguage   : WORD;
    wCodePage   : WORD;
  end;
  PLANGANDCODEPAGE =^ LANGANDCODEPAGE;
  TrpVersionInfo = class(TComponent)
    (* ������ ��������� ��������� �������� ���������� � ������ ������ ����������

    �� ����� ��� ���������� *)
  private

    FVersionInfo  : array[0..ord(high(TVersionType))] of string;
    pLangCodePage : PLANGANDCODEPAGE;
  protected
    function GetCompanyName: string;
    function GetFileDescription: string;
    function GetFileVersion: string;
    function GetInternalName: string;
    function GetLegalCopyright: string;
    function GetLegalTradeMark: string;
    function GetOriginalFileName: string;
    function GetProductName: string;
    function GetProductVersion: string;
    function GetComments: string;
    function GetVersionInfo(VersionType: TVersionType): string; virtual;
    procedure SetVersionInfo; virtual;
  public
    constructor Create(AOwner: TComponent); override;

  published
    (* ������������ ��� ����� ������ - Label1.Caption := VersionInfo1.FileVersion

    ����������: ��� �������� - ������ ��� ������, ������� ��� ���������� �
    ���������� �������� *)
    property CompanyName: string read GetCompanyName;
    property FileDescription: string read GetFileDescription;
    property FileVersion: string read GetFileVersion;
    property InternalName: string read GetInternalName;
    property LegalCopyright: string read GetLegalCopyright;
    property LegalTradeMark: string read GetLegalTradeMark;
    property OriginalFileName: string read GetOriginalFileName;
    property ProductName: string read GetProductName;
    property ProductVersion: string read GetProductVersion;
    property Comments: string read GetComments;
  end;

//procedure Register;

implementation

constructor TrpVersionInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetVersionInfo;
end;

function TrpVersionInfo.GetCompanyName: string;
begin

  result := GeTVersionInfo(vtCompanyName);
end;

function TrpVersionInfo.GetFileDescription: string;
begin

  result := GeTVersionInfo(vtFileDescription);
end;

function TrpVersionInfo.GetFileVersion: string;
begin

  result := GeTVersionInfo(vtFileVersion);
end;

function TrpVersionInfo.GetInternalName: string;
begin

  result := GeTVersionInfo(vtInternalName);
end;

function TrpVersionInfo.GetLegalCopyright: string;
begin

  result := GeTVersionInfo(vtLegalCopyright);
end;

function TrpVersionInfo.GetLegalTradeMark: string;
begin

  result := GeTVersionInfo(vtLegalTradeMark);
end;

function TrpVersionInfo.GetOriginalFileName: string;
begin
  result := GeTVersionInfo(vtOriginalFileName);
end;

function TrpVersionInfo.GetProductName: string;
begin
  result := GeTVersionInfo(vtProductName);
end;

function TrpVersionInfo.GetProductVersion: string;
begin
  result := GeTVersionInfo(vtProductVersion);
end;

function TrpVersionInfo.GetComments: string;
begin
  result := GeTVersionInfo(vtComments);
end;

function TrpVersionInfo.GeTVersionInfo(VersionType: TVersionType): string;
begin
  result := FVersionInfo[ord(VersionType)];
end;

procedure TrpVersionInfo.SeTVersionInfo;
var
  sAppName, sVersionType,strQry,strLan,strCode: string;
  iAppSize, iLenOfValue, i,j,cpSz: UINT;
  pcBuf, pcValue: PChar;
  dwCI,szLC : Dword;
  pbBuff  : PByteArray;
  cp      : LANGANDCODEPAGE;
begin
  szLC := sizeof(LANGANDCODEPAGE);
  sAppName := Application.ExeName;
  iAppSize := GetFileVersionInfoSize(PChar(sAppName), iAppSize);
  if iAppSize > 0 then
  begin
    pcBuf := AllocMem(iAppSize);
    GetFileVersionInfo(PChar(sAppName), 0, iAppSize, pcBuf);
   if VerQueryValue(pcBuf,PChar('\\VarFileInfo\\Translation'),Pointer(pbBuff),cpSz)=True then
   Begin
    for j:=0 to Trunc(cpSz/szLC)-1 do
    Begin
     Move(pbBuff[j*szLC],cp,szLC);
     for i := 0 to Ord(High(TVersionType)) do
     begin
      sVersionType := GetEnumName(TypeInfo(TVersionType), i);
      sVersionType := Copy(sVersionType, 3, length(sVersionType));
       strLan  := IntToHex(cp.wLanguage,4);
       strCode := IntToHex(cp.wCodePage,4);
       strQry := 'StringFileInfo\'+strLan+strCode+'\'+sVersionType;
       if VerQueryValue(pcBuf, PChar(strQry), Pointer(pcValue), iLenOfValue) then
       FVersionInfo[i] := pcValue;
     end;
   End;
    FreeMem(pcBuf, iAppSize);
  end;
  end;
end;
{
procedure Register;
begin
  RegisterComponents('FreeWare', [TrpVersionInfo]);
end;
}

end.

