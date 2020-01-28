object Bases: TBases
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 10
  Top = 834
  Height = 200
  Width = 572
  object LOGDB: TIBDatabase
    DatabaseName = 'C:\a2000\ascue\LogFile.fdb'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = LOGTransaction
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 48
    Top = 8
  end
  object LOGTransaction: TIBTransaction
    Active = False
    DefaultDatabase = LOGDB
    Left = 120
    Top = 8
  end
  object LOGQuery: TIBQuery
    Database = LOGDB
    Transaction = LOGTransaction
    CachedUpdates = False
    SQL.Strings = (
      'select * from LOGS')
    Left = 200
    Top = 8
  end
  object LOGBLOB: TIBQuery
    Database = LOGDB
    Transaction = LOGTransaction
    CachedUpdates = False
    Left = 280
    Top = 8
    ParamData = <
      item
        DataType = ftBlob
        Name = 'BLB'
        ParamType = ptUnknown
      end>
  end
end
