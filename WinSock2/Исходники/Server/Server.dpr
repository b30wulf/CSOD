program Server;
uses Winsock2,Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;
var
   inf:TWSADATA;
   i,z,socks,sockc: integer;
   sockaddr: TSockAddr;
   s: array[0..100] of Char;
begin
   WSAStartup(MAKEWORD(2,0),inf);                   // �������������� ����������
   socks:=socket(AF_INET,SOCK_STREAM,0);            // �������� �������� ��� ����������
   sockaddr.sin_family := AF_INET;                  // ������ ���������  TSockAddr
   sockaddr.sin_port := htons(210);                 // ...
   sockaddr.sin_addr.S_addr := htonl(INADDR_ANY);   // ...
   bind(socks,@sockaddr,sizeof(sockaddr));          // �������� ��������� � ������
   listen(socks,3);                                 // �������� �������
   i:=sizeof(sockaddr);
   while true do                                    // ����������� ���� � �������� ��������
   begin
      sockc:=accept(socks,sockaddr,i);              // ����������� ���������� ����� ��������
      //ShowMessage(inttostr(z));
      if sockc<>-1 then                             // ���� ���� �������
      begin
         z:=recv(sockc,s,Length(s),0);              // ������ ������
         if z<>-1 then                              // ���?
         begin
            ShowMessage('������ ��������: '+s);     // ���� ��, �� ������� ��
            s:='�������';                           // ������ � �����
            send(sockc,s,Length(s),0);              // �������� 
         end;
      end;
   end;
end.
