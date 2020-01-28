{*******************************************************************************
 *  Модуль протокола счетчика Энергомера 16401M версии 4.0
 *  24.05.2018
 ******************************************************************************}

unit knsl2CE16401Mv4;

interface

uses
    Windows, Classes, SysUtils,
    knsl5config, knsl2meter, utldatabase, utltypes, utlbox,
    utlconst, utlmtimer, utlTimeDate, knsl3EventBox,utlmd5,Math,knsl2CE16401MMeter;

type

    CCE16401Mv4 = class(CCE16401MMeter)
    private
     { Private declarations }
    public
        constructor Create;
        destructor  Destroy; override;
     { Public declarations }
    end;


implementation

constructor CCE16401Mv4.Create;
Begin
  FillChar(m_nT, SizeOf(m_nT), 0);
End;

destructor CCE16401Mv4.Destroy;
Begin
    inherited;
End;


End.
