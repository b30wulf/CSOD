unit SchemDriver;
interface
uses forms,kp_1,kp_2p,kp_2c,kp_3,kp_4,kp_5,
     kp_6,kp_7,kp_8,kp_9,kp_10,kp_11,
     kp_13,kp_14,gpp1_1,gpp1_2,gpp2_1,gpp2_2,
     gpp2_2d,gppb1,gppb2,im1,main,teplo1,ctp2_1,
     ctp2,tp1,tp1_1,tp2,tp2_1;
type
     CSchemDriver = class
     private
     public
      constructor Create;
      destructor Destroy;override;
     public
      function GetForm(nABOID,nGID:Integer;var Owner:TForm;var frm:TForm;var nDesc:Integer):Boolean;
end;
implementation
constructor CSchemDriver.Create;
Begin

End;
destructor CSchemDriver.Destroy;
Begin

    inherited;
End;
  //kp_1 in 'kp_1.pas' {fkp_1},
  //kp_2p in 'kp_2p.pas' {fkp_2p},
  //kp_2c in 'kp_2c.pas' {fkp_2c},
  //kp_3 in 'kp_3.pas' {fkp_3},
  //kp_4 in 'kp_4.pas' {fkp_4},
  //kp_5 in 'kp_5.pas' {fkp_5},
  //kp_6 in 'kp_6.pas' {fkp_6},
  //kp_7 in 'kp_7.pas' {fkp_7},
  //kp_8 in 'kp_8.pas' {fkp_8},
  //kp_9 in 'kp_9.pas' {fkp_9},
  //kp_10 in 'kp_10.pas' {fkp_10},
  //kp_11 in 'kp_11.pas' {fkp_11},
  //kp_13 in 'kp_13.pas' {fkp_13},
  //kp_14 in 'kp_14.pas' {fkp_14},
  //gpp1_1 in 'gpp1_1.pas' {fgpp1_1},
  //gpp1_2 in 'gpp1_2.pas' {fgpp1_2},
  //gpp2_1 in 'gpp2_1.pas' {fgpp2_1},
  //gpp2_2 in 'gpp2_2.pas' {fgpp2_2},
  //gpp2_2d in 'gpp2_2d.pas' {fggp2_2d},
  //gppb1 in 'gppb1.pas' {fgppb1},
  //gppb2 in 'gppb2.pas' {fgppb2},
  //im1 in 'im1.pas' {fim1},
  //main in 'main.pas' {fmain},
  //teplo1 in 'teplo1.pas' {fteplo1},
  //ctp2_1 in 'ctp2_1.pas' {fctp2_1},
  //ctp2 in 'ctp2.pas' {fctp2},
  //tp1 in 'tp1.pas' {ctp1},
  //tp1_1 in 'tp1_1.pas' {ftp1_1},
  //tp2 in 'tp2.pas' {ftp2},
  //tp2_1 in 'tp2_1.pas' {ftp2_1};
function CSchemDriver.GetForm(nABOID,nGID:Integer;var Owner:TForm;var frm:TForm;var nDesc:Integer):Boolean;
Begin
    case nABOID of
         0: if fkp_1=Nil then
            Begin
             fkp_1 := Tfkp_1.Create(Owner);
             frm   := fkp_1;
            End else
            Begin
             frm   := fkp_1;
             frm.Show;
            End;
         1: if fkp_2p=Nil then
            Begin
             fkp_2p := Tfkp_2p.Create(Owner);
             frm   := fkp_2p;
            End else
            Begin
             frm   := fkp_2p;
             frm.Show;
            End;
         2 : if fkp_2c=Nil then
            Begin
             fkp_2c := Tfkp_2c.Create(Owner);
             frm   := fkp_2c;
            End else
            Begin
             frm   := fkp_2c;
             frm.Show;
            End;
         3 : if fkp_3=Nil then
            Begin
             fkp_3 := Tfkp_3.Create(Owner);
             frm   := fkp_3;
            End else
            Begin
             frm   := fkp_3;
             frm.Show;
            End;
         4 : if fkp_4=Nil then
            Begin
             fkp_4 := Tfkp_4.Create(Owner);
             frm   := fkp_4;
            End else
            Begin
             frm   := fkp_4;
             frm.Show;
            End;
         5 : if fkp_5=Nil then
            Begin
             fkp_5 := Tfkp_5.Create(Owner);
             frm   := fkp_5;
            End else
            Begin
             frm   := fkp_5;
             frm.Show;
            End;
         6 : if fkp_6=Nil then
            Begin
             fkp_6 := Tfkp_6.Create(Owner);
             frm   := fkp_6;
            End else
            Begin
             frm   := fkp_6;
             frm.Show;
            End;
         7  : if fkp_7=Nil then
            Begin
             fkp_7 := Tfkp_7.Create(Owner);
             frm   := fkp_7;
            End else
            Begin
             frm   := fkp_7;
             frm.Show;
            End;
         8 : if fkp_8=Nil then
            Begin
             fkp_8 := Tfkp_8.Create(Owner);
             frm   := fkp_8;
            End else
            Begin
             frm   := fkp_8;
             frm.Show;
            End;
         9 : if fkp_9=Nil then
            Begin
             fkp_9 := Tfkp_9.Create(Owner);
             frm   := fkp_9;
            End else
            Begin
             frm   := fkp_9;
             frm.Show;
            End;
         10 : if fkp_10=Nil then
            Begin
             fkp_10 := Tfkp_10.Create(Owner);
             frm   := fkp_10;
            End else
            Begin
             frm   := fkp_10;
             frm.Show;
            End;
         11 : if fkp_11=Nil then
            Begin
             fkp_11 := Tfkp_11.Create(Owner);
             frm   := fkp_11;
            End else
            Begin
             frm   := fkp_11;
             frm.Show;
            End;
         12 : if fkp_14=Nil then
            Begin
             fkp_14 := Tfkp_14.Create(Owner);
             frm   := fkp_14;
            End else
            Begin
             frm   := fkp_14;
             frm.Show;
            End;
    End;
End;
end.
