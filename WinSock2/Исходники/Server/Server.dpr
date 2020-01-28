program Server;
uses Winsock2,Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;
var
   inf:TWSADATA;
   i,z,socks,sockc: integer;
   sockaddr: TSockAddr;
   s: array[0..100] of Char;
begin
   WSAStartup(MAKEWORD(2,0),inf);                   // Инициализируем библиотеку
   socks:=socket(AF_INET,SOCK_STREAM,0);            // Получаем параметр для переменной
   sockaddr.sin_family := AF_INET;                  // Опишем структуру  TSockAddr
   sockaddr.sin_port := htons(210);                 // ...
   sockaddr.sin_addr.S_addr := htonl(INADDR_ANY);   // ...
   bind(socks,@sockaddr,sizeof(sockaddr));          // Привяжем структуру к сокету
   listen(socks,3);                                 // Начинаем слушать
   i:=sizeof(sockaddr);
   while true do                                    // Бесконечный цикл в ожидании коннекта
   begin
      sockc:=accept(socks,sockaddr,i);              // Присваиваем переменной ответ коннекте
      //ShowMessage(inttostr(z));
      if sockc<>-1 then                             // Если есть коннект
      begin
         z:=recv(sockc,s,Length(s),0);              // Примем данные
         if z<>-1 then                              // оок?
         begin
            ShowMessage('Клиент передает: '+s);     // Если ок, то выводим их
            s:='Здарова';                           // данные в ответ
            send(sockc,s,Length(s),0);              // Посылаем 
         end;
      end;
   end;
end.
