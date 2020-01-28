unit knslRPTypes;

interface

Type
  TXY = record
    X : integer;
    Y : integer;
  end;

  TXLSPointerHomeBalanse = class
    xnReportNameX             : Integer;
    xnReportNameY             : Integer;
    xnDogovorX                : Integer;
    xnDogovorY                : Integer;
    xnAddressX                : Integer;
    xnAddressY                : Integer;
    xnPrimaryIndicationsX     : Integer;
    xnPrimaryIndicationsY     : Integer;
    xnSecondaryIndicationsX   : Integer;
    xnSecondaryIndicationsY   : Integer;
    xnNumberHouse             : Integer;
    xnConsumerLS              : Integer;
    xnConsumerName            : Integer;
    xnEnergy                  : Integer;
    xnMeterNumb               : Integer;
    xnRatio                   : Integer;
    xnPrimaryIndicationsT     : array[0..4] of integer;
    xnSecondaryIndicationsT   : array[0..4] of integer;
    xnDifferenceIndicationT   : array[0..4] of integer;
    xnPowerConsumptionT       : array[0..4] of integer;
    xnFirstRow                : Integer;
    xnTotalSummHomeT          : array[0..4] of TXY;
    xnTotalSummBalanceT       : array[0..4] of TXY;
    xnTotalSummNoBalanceT     : array[0..4] of TXY;    
  end;

implementation

end.
