
    1. Используйте справочник счетчиков SPRSCHET для подключения по номеру 
       счетчика кода типа счетчика.
                ------------------
    2. Если регистрируемого счетчика нет в справочнике, то чтобы была возможность
       выбрать тип из справочников (SPRGRSC-справочник групп счетчиков,
       SPRTPSC-справочник типов счетчиков).


Structure for database: D:\SPRAVOCN\REFS\SPRSCHET.DBF
Number of data records:   58859
Date of last update   : 02.11.10
Code Page             : 866
Field  Field Name  Type       Width    Dec    Index  Collate
    1  KODGR       Numeric        3                  
    2  KODTIPSC    Numeric        6  - код типа счетчика                
    3  NST         Character     20  - № счетчика                
    4  PROV        Character      5                  
    5  GODEN       Character      5                  
    6  SDELSKAL    Numeric        1                  
** Total **                      41


Structure for database: D:\SPRAVOCN\REFS\SPRTPSC.DBF
Number of data records:     426
Date of last update   : 02.11.10
Code Page             : 866
Field  Field Name  Type       Width    Dec    Index  Collate
    1  KODGR       Numeric        3                  
    2  KODTIPSC    Numeric        6 - код типа счетчика                 
    3  TIPSCH      Character     20 - тип счетчика                 
    4  SR_ATT      Numeric        2                  
    5  FABRIC      Character     24                  
    6  ZNACN       Numeric        2                  
    7  DROB        Numeric        1                  
    8  AMPER       Character      8                  
    9  VOLT        Numeric        3                  
   10  FAZA        Numeric        1                  
   11  KOLSCAL     Numeric        1                  
** Total **                      72
             