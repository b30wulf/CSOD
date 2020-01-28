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
   s:='Привет';                                                 // Данные для отправки
   Server.s_addr:=inet_addr(PChar('127.0.0.1'));                // Адрес сервера
   WSAStartup(MAKEWORD(2,0),inf);                               // Инициализируем библиотеку
   socks:=socket(AF_INET,SOCK_STREAM,IPPROTO_IP);               // Получаем параметр для переменной
   sockaddr.sin_family := AF_INET;                              // Опишем структуру  TSockAddr
   sockaddr.sin_port := htons(210);                             // ...
   sockaddr.sin_addr := Server;                                 // ...
   if connect(socks,@sockaddr,sizeof(sockaddr))<>-1 then        // Если подключение прошло успешно то...
   begin
      send(socks,s,Length(s),0);                                // ...Посылаем данные
      while true do                                             // Ждем ответа
      begin
         z:=recv(socks,s,Length(s),0);                          // Получаем ответ
         if z<>-1 then                                          // Если все ок то...
         ShowMessage('Сервер передает: '+s);                    // ...Выводим сообщение с полученными данными
      end;
   end; 
end.
