{*************************************************************************************************************************
 *  ������ �������������� � �������� ��������� ������ � ����������� �������� �
 *  �������� ��������������. ����� ���������� �� ������� �� ������ " �������
 *  �������� �������� ����� " �� ������ ���� ������������ - > ���������.
 *
 *  Artem Buyak and his friend Romka Kudin
 *  08.05.2018
 ************************************************************************************************************************}
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTP, IdBaseComponent, IdMessage, IdSocks,
  IdServerIOHandler, IdSSLOpenSSL, IdIOHandler, IdIOHandlerSocket, ComCtrls,
  ExtCtrls, knsl5module, MimePart, SMTPSend, MimeMess,ssl_openssl, CheckLst,knsl3EventBox,utlconst,
  utltypes, utldatabase, IBQuery, Mask;

type
  TListRec = class(TObject)
    email : string[50];
    chk   : string[1];
    MES   : string[1];
    BES   : string[1];
    KES   : string[1];
  end;

  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    MailAddress: TEdit;
    Label1: TLabel;
    DeleteEmail: TButton;
    AddEmail: TButton;
    Label2: TLabel;
    GroupBox3: TGroupBox;
    Button3: TButton;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
    Timer1: TTimer;
    emailListBox: TCheckListBox;
    MES: TCheckBox;
    BES: TCheckBox;
    KES: TCheckBox;
    //CheckListBox1: TCheckListBox;
//    procedure IdSMTP1Connected(Sender: TObject);
    procedure IdSMTP1Connected;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormirListOfEmail;
    procedure AddEmailClick(Sender: TObject);
    procedure DeleteEmailClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure emailListBoxClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MailAddressChange(Sender: TObject);

  private
    { Private declarations }
      ChangeColor : Boolean;
      Sender1 : TObject;
      CanCloseForm : Boolean;
      ListRec : TListRec;
  public
    { Public declarations }
      Form1Form1  : TTKnsForm;
      Form1tampList : TList;
  end;
  TR     = class(TThread)
  private
    CanCloseForm : boolean;
    MSGi : string;
    procedure SelLabel;
    procedure CanCloseF;
    procedure SMTPConnected;
    { Private declarations }
  protected
    procedure Execute; override;
  end;

  TR2     = class(TThread)
  private
    MSGi : string;
    procedure SelLabel;
    procedure SMTPConnected;
    { Private declarations }
  protected
    procedure Execute; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


{****************************************************************************************************************
* �������� ��������� �������� ������.
* � ���� ���� ����� �� �������, ����������� ��� � ������. ��� ����� ������������
* ���������� Form1tampList, �������� ������� �������� ��� ������ �����, � ���
* �������� ��� �������, ������� �������� � ��. ���������� ��� �������, � �������
* ����� �� ��� ������.
*
* ������ ������ email ������ XXXXX@mail.ru;ON, ������� ���������� ��������� ���
* ������, ������� �������� ��� "ON". ���������� ��� ������ � "email_address.ini".
*****************************************************************************************************************}
//procedure TForm1.IdSMTP1Connected(Sender: TObject);
procedure TForm1.IdSMTP1Connected;
var
      vg    : String;
      SafeF : TextFile;
      str   : string;
      i,j   : integer;
      Item  : TListItem;
      m     :TMimemess;
      l     :tstringlist;
      p     : TMimepart;
      Res   :boolean;
      sl: TStringList;
      Year, Month, Day: word;
      infRegion  : ^SL3REGION; // ���� � ��������
begin
  ProgressBar1.Min := 0;
  // �� 1 ������ ���-�� ������� � �����
  ProgressBar1.Max := emailListBox.Items.Count + 1;
  ProgressBar1.Position := 0;

begin
        // ���������� ������ �������� ���� �� ���������� ������� ��������, �.�.
        // �������� ���� � ��������� ������
        Button3.Enabled:= False;

        DecodeDate((Now - 1), Year, Month, Day);
        Try

        // SMTP - �������� ��� �������� ����������� ����� � ����� TCP/IP
        // ���� ��� ���������
        // -------------------------------------------------------------

     for j := 0 to emailListBox.Items.Count - 1 do begin

       ListRec:=TListRec(emailListBox.Items.Objects[j]);

        m:=TMimemess.create;
        l:=tstringlist.create;
                        p := m.AddPartMultipart('mixed', nil);
                        // ����� � ������
                        l.add('����� � �������������� ��: ' + FormatDateTime('dd.mm.yyyy"', (Now - 1)));
                        m.AddPartText(l,p);
       if Day < 10 then begin
        str := '0' + IntToStr(Day) + '_';
       end else begin
        str := IntToStr(Day) + '_';
    end;
       if Month < 10 then begin
        str := str + '0' + IntToStr(Month) + '_' + IntToStr(Year)+'.xls';
       end else begin
        str := str + IntToStr(Month) + '_' + IntToStr(Year)+'.xls';
    end;

       if (Form1tampList=Nil) then begin
    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������ �� �������!!!');
    exit;
    end;

  {   for j := 0 to emailListBox.Items.Count - 1 do begin

       ListRec:=TListRec(emailListBox.Items.Objects[j]);    }

       if ListRec.MES = '1' then begin
         if (FileExists(ExtractFilePath(Application.Exename) + 'ExportData\�����_��_�������_' + '����������� ��' + '_��_' + str)) then begin
           m.AddPartBinaryFromFile(ExtractFilePath(Application.Exename) + 'ExportData\�����_��_�������_' + '����������� ��' +'_��_' + str,p)
         end;
       end;

       if ListRec.BES = '1' then begin
         if (FileExists(ExtractFilePath(Application.Exename) + 'ExportData\�����_��_�������_' + '���������� ��' + '_��_' + str)) then begin
           m.AddPartBinaryFromFile(ExtractFilePath(Application.Exename) + 'ExportData\�����_��_�������_' + '���������� ��' +'_��_' + str,p)
         end;
       end;

       if ListRec.KES = '1' then begin
         if (FileExists(ExtractFilePath(Application.Exename) + 'ExportData\�����_��_�������_' + '������������ ��' + '_��_' + str)) then begin
           m.AddPartBinaryFromFile(ExtractFilePath(Application.Exename) + 'ExportData\�����_��_�������_' + '������������ ��' +'_��_' + str,p)
         end;
       end;

    {   for i:=0 to Form1tampList.Count-1 do begin
        infRegion := Form1tampList[i];
        if (infRegion^.m_sbyEnable = 1) and
             (FileExists(ExtractFilePath(Application.Exename) + 'ExportData\�����_��_�������_' + infRegion^.m_nRegNM + '_��_' + str)) then begin
            m.AddPartBinaryFromFile(ExtractFilePath(Application.Exename) + 'ExportData\�����_��_�������_' + infRegion^.m_nRegNM +'_��_' + str,p)
         end;    }

    m.header.from:='energoa2000@mail.ru';
    m.header.subject:=FormatDateTime('dd.mm.yyyy"', (Now - 1));


    	ProgressBar1.Position := ProgressBar1.Position + 1;
    	// �������� ���������� �� ���������� ������ �� ������ email-�����

         if emailListBox.Checked[j] then begin
  //       if ListRec.MES = '1' then begin

           Label2.Caption := '����������� ��: ' + ListRec.email;
           m.header.toList.add(ListRec.email);
	    m.EncodeMessage;
	    memo1.lines.assign(m.lines);
           Res:=SendToRaw('energoa2000@mail.ru', ListRec.email, 'smtp.mail.ru', m.lines, 'energoa2000@mail.ru', 'avtomation2000');
           if Res then begin
             if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������ ���������� ��: ' + ListRec.email);
           end else if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'������ �� ����������!!!');
       end;
       m.Destroy; //m.free;
       l.Destroy; //l.free;
    end;
   finally
{     m.Destroy; //m.free;
     l.Destroy; //l.free;  }
   end;
    ProgressBar1.Position := ProgressBar1.Position + 1;
    Button3.Enabled:= True;
end;
ProgressBar1.Position := 0;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
     IdSMTP1Connected;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FormirListOfEmail;
  Form1.CanCloseForm := True;

end;


procedure TForm1.FormirListOfEmail;
var   vg    : String;
      SafeF : TextFile;
      str,s : string;
      i     : integer;
begin
      vg := ExtractFilePath(Application.Exename);
      vg := (vg + 'Settings\email_address.ini');
      AssignFile(SafeF, vg);
      if FileExists(vg) then
        begin
                Reset(SafeF);
          // ************* BO 27/09/2018
          i:=0;
          While not EOF (SafeF) do begin
            readLn(SafeF, str);
            if trim(str) <> '' then begin
              ListRec:=TListRec.Create;
              ListRec.email:=copy(str,1,pos(';',str)-1);
              delete(str,1,pos(';',str));
              ListRec.chk:=copy(str,1,pos(';',str)-1);
              delete(str,1,pos(';',str));
              ListRec.MES:=copy(str,1,pos(';',str)-1);
              delete(str,1,pos(';',str));
              ListRec.BES:=copy(str,1,pos(';',str)-1);
              delete(str,1,pos(';',str));
              ListRec.KES:=str;
              emailListBox.Items.AddObject(ListRec.email,ListRec);
              emailListBox.ItemIndex:=i;
              if (ListRec.chk = '0') then emailListBox.Checked[i]:=false else emailListBox.Checked[i]:=true;
              emailListBoxClick(MES);  emailListBoxClick(BES);  emailListBoxClick(KES);
              inc(i);
            end;
          end;
          // ************* end of BO

          CloseFile(SafeF);
        end;
end;


// ***************** BO 1.10.18 �������� e-mail �� ������������ �������� ��������
function CheckAllowed(const s: string): boolean;
var
  i: integer;
begin
  Result := false;
  for i := 1 to Length(s) do
  begin
    if not (s[i] in ['a'..'z', 'A'..'Z', '0'..'9', '_', '-', '.', '@']) then
      Exit;
  end;
  Result := true;
end;

procedure TForm1.MailAddressChange(Sender: TObject);
var s : string;
begin
  s := MailAddress.text;
  if not CheckAllowed(s) then begin
    delete(s, length(s),1);
    MailAddress.text:=s;
  end;
  //
end;

procedure TForm1.AddEmailClick(Sender: TObject);
var s : string;
begin
  s := MailAddress.Text;
  ListRec:=TListRec.Create;
  ListRec.email:=s;
  ListRec.chk:='1';
  ListRec.MES:='0';
  ListRec.BES:='0';
  ListRec.KES:='0';
  emailListBox.Items.AddObject(ListRec.email,ListRec);
  emailListBox.ItemIndex:=emailListBox.Items.Count-1;
  emailListBox.Checked[emailListBox.ItemIndex]:=true;
end;

procedure TForm1.DeleteEmailClick(Sender: TObject);
var i : integer;
begin
  i:= emailListBox.ItemIndex;
  emailListBox.Items.Delete(i);
  if (i = emailListBox.Items.Count) then dec(i);
  emailListBox.ItemIndex:=i;
  emailListBoxClick(Sender);
end;

procedure TR.SelLabel;
begin
  Form1.Label2.Caption:=MSGi;
end;

procedure TR.CanCloseF;
begin
  Form1.CanCloseForm:=CanCloseForm;
end;

procedure TR.SMTPConnected;
begin
  Form1.IdSMTP1Connected;
end;

procedure TR.Execute;
var i : integer;
begin
  CanCloseForm := False;
  Synchronize(CanCloseF);
  MSGi:='�������� �����.';
  Synchronize(SelLabel);

  Synchronize(SMTPConnected);

  MSGi:='�������� ���������!';
  Synchronize(SelLabel);
  CanCloseForm := True;
  Synchronize(CanCloseF);
end;



procedure TForm1.Button3Click(Sender: TObject);
var NewTR : TR;
begin
    Sender1 := Sender;
    NewTR := TR.Create(true);
    NewTR.FreeOnTerminate := true;
    NewTR.Priority := tpLower;
    NewTR.Resume;
  //  NewTR.Destroy;    // ??

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
    NewTR               : TR2;
    _hh,_mm,_ss, _mmmm  : word;
begin
    DecodeTime(Now, _hh, _mm, _ss, _mmmm);
    if (_hh = 01)and (_mm = 00)then
    begin
        if (_ss = 1) or (_ss = 2) or (_ss = 3) then
        begin

        if (emailListBox.Items=Nil) then
                FormirListOfEmail;
                Sender1 := Sender;
                NewTR := TR2.Create(true);
                NewTR.FreeOnTerminate := true;
                NewTR.Priority := tpLower;
                NewTR.Resume;
        end;
    end;
end;

procedure TR2.SelLabel;
begin
  Form1.Label2.Caption:=MSGi;
end;

procedure TR2.SMTPConnected;
begin
  Form1.IdSMTP1Connected;
end;

procedure TR2.Execute;
var i : integer;
begin
  MSGi:='�������� �����.';
  Synchronize(SelLabel);
//         Form1.Label2.Caption := '�������� �����.';

  Synchronize(SMTPConnected);
//        Form1.IdSMTP1Connected{(Form1.Sender1)};

  MSGi:='�������� ���������!';
  Synchronize(SelLabel);
//        Form1.Label2.Caption := '�������� ���������!';
end;



procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
        CanClose := CanCloseForm;
end;


      {
function TForm1.GetParceString(nID:Integer;sAdvDiscL2Tag:String):String;
var
    i, j  : integer;
    ts: string;
begin
   j  := 0;
   ts := '';
   for i := 1 to Length(sAdvDiscL2Tag) do
   begin
     if sAdvDiscL2Tag[i] = ';' then
     begin
      if (j=nID) then
      Begin
       Result := ts;
       exit;
      End;
      ts := '';
      Inc(j);
      continue;
       {
                  Case j Of
         0 : begin ed_L2KoncFubNum.Text   := ts; j := j + 1; end;
         1 : begin ed_L2KoncPassw.Text    := ts; j := j + 1; end;
         2 : begin ed_L2KoncAdrToRead.Text  := ts; j := j + 1; end;
         3 : begin ed_L2KoncRazNum.Text   := ts; j := j + 1; end;
         4 : begin ed_L2KoncNumTar.Text   := ts; j := j + 1; end;
         5 : begin ed_L2NaprVvoda.Text    := ts; j := j + 1; end;
         6 : begin ed_L2TypeTI.Text       := ts; j := j + 1; end;
         7 : begin ed_L2TypeTU.Text       := ts; j := j + 1; end;
         8 : begin dt_L2DateInst.Date     := StrToDate(ts); j := j + 1; end;
       end;
       ts := '';
       continue;
       }
    { end;
     ts := ts + sAdvDiscL2Tag[i];
   end;
end;
      }




// ************* BO 28/09/2018

procedure TForm1.emailListBoxClick(Sender: TObject);
begin
  // ������������ ��� ��������� ������ ��� ������ �� �����
  ListRec:=TListRec(emailListBox.Items.Objects[emailListBox.ItemIndex]);
  if (emailListBox.Checked[emailListBox.ItemIndex] = false) then ListRec.chk := '0' else ListRec.chk := '1';
  {if sender = MES then} if ListRec.MES = '0' then MES.Checked := false else MES.Checked:=true;
  {if sender = BES then} if ListRec.BES = '0' then BES.Checked := false else BES.Checked:=true;
  {if sender = KES then} if ListRec.KES = '0' then KES.Checked := false else KES.Checked:=true;
end;

procedure TForm1.FormDestroy(Sender: TObject);     // ************* BO 28/09/2018
var i     : integer;
    vg    : string;
    SafeF : TextFile;
begin
  vg := ExtractFilePath(Application.Exename);
  vg := (vg + 'Settings\email_address.ini');
  AssignFile(SafeF, vg);
  Rewrite(SafeF);
  for i:=0 to emailListBox.Items.Count-1 do begin
    ListRec:=TListRec(emailListBox.Items.Objects[i]);
    Writeln(SafeF, ListRec.email + ';'+  ListRec.chk + ';' +  ListRec.MES + ';' + ListRec.BES + ';' + ListRec.KES);
    ListRec.Destroy;
  end;
  CloseFile(SafeF);
end;

procedure TForm1.CheckBoxKeyPress(Sender: TObject; var Key: Char);    // ************* BO 28/09/2018
begin        // �������� ������������ �� ������� ������ �� ��������: Space ...
  if (Key = ' ') {Space} then begin
    ListRec:=TListRec(emailListBox.Items.Objects[emailListBox.ItemIndex]);
    if sender = MES then if ListRec.MES = '0' then ListRec.MES:= '1' else ListRec.MES:= '0';
    if sender = BES then if ListRec.BES = '0' then ListRec.BES:= '1' else ListRec.BES:= '0';
    if sender = KES then if ListRec.KES = '0' then ListRec.KES:= '1' else ListRec.KES:= '0';
  end;
end;

procedure TForm1.CheckBoxMouseUp(Sender: TObject; Button: TMouseButton;     // ************* BO 28/09/2018
  Shift: TShiftState; X, Y: Integer);
begin
  ListRec:=TListRec(emailListBox.Items.Objects[emailListBox.ItemIndex]);
  if sender = MES then if ListRec.MES = '0' then ListRec.MES:= '1' else ListRec.MES:= '0';
  if sender = BES then if ListRec.BES = '0' then ListRec.BES:= '1' else ListRec.BES:= '0';
  if sender = KES then if ListRec.KES = '0' then ListRec.KES:= '1' else ListRec.KES:= '0';
end;



end.
