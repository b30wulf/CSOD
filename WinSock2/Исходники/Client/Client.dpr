program Client;
uses Winsock2,Windows,Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, SysUtils;
var
   Server:TInaddr;
   inf: TWSADATA;
   z,socks: integer;
   sockaddr: TSockAddr;
   s: array[0..100] of Char;
begin
   s:='������';                                                 // ������ ��� ��������
   Server.s_addr:=inet_addr(PChar('127.0.0.1'));                // ����� �������
   WSAStartup(MAKEWORD(2,0),inf);                               // �������������� ����������
   socks:=socket(AF_INET,SOCK_STREAM,IPPROTO_IP);               // �������� �������� ��� ����������
   sockaddr.sin_family := AF_INET;                              // ������ ���������  TSockAddr
   sockaddr.sin_port := htons(210);                             // ...
   sockaddr.sin_addr := Server;                                 // ...
   if connect(socks,@sockaddr,sizeof(sockaddr))<>-1 then        // ���� ����������� ������ ������� ��...
   begin
      send(socks,s,Length(s),0);                                // ...�������� ������
      while true do                                             // ���� ������
      begin
         z:=recv(socks,s,Length(s),0);                          // �������� �����
         if z<>-1 then                                          // ���� ��� �� ��...
         ShowMessage('������ ��������: '+s);                    // ...������� ��������� � ����������� �������
      end;
   end; 
end.
