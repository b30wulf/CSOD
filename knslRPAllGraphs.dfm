object RPAllGraphs: TRPAllGraphs
  Left = 530
  Top = 187
  Width = 231
  Height = 106
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object m_Report: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    OnGetValue = m_ReportGetValue
    OnManualBuild = m_ReportManualBuild
    Left = 16
    Top = 16
    ReportForm = {
      17000000DE17000017000000001F005C5C41323030302D5345525645525C4850
      204C617365724A6574203130323000FF09000000340800009A0B000048000000
      240000002400000024000000000000FFFF010000000000000002000B00506167
      65466F6F74657231000000000024020000F00200001400000030000300010000
      00000000000000FFFFFF1F00000000000000000000000000FFFF02000B005061
      676548656164657231000000000024000000F002000054000000300002000100
      0000000000000000FFFFFF1F00000000000000000000000000FFFF02000D004D
      6173746572486561646572310000000000A0000000F00200008F000000300004
      0001000000000000000000FFFFFF1F00000000000000000000000000FFFF0200
      0B004D61737465724461746131000000000048010000F00200000F0000003000
      050001000000000000000000FFFFFF1F0000000006005B4E6F6E655D00000000
      000000FFFF02000D004D6173746572466F6F74657231000000000077010000F0
      020000160000003000060001000000000000000000FFFFFF1F00000000000000
      000000000000FFFF00000B0061626F6E656E745F615F6E004800000038000000
      83020000140000000300000001000000C0C0C0000000FFFFFF002E0200000000
      00010020005B41626F6E656E744E616D655D20285B41626F6E656E7441646472
      6573735D2900000000FFFF0900417269616C20435952000B0000000000000000
      00020000000000020000000000FFFFFF00000000000006004D656D6F34340027
      000000F0030000EC0000000F0000000300000001000000000000000000FFFFFF
      1F2E02000000000001002000CEF2F7E5F220F1F4EEF0ECE8F0EEE2E0ED3A205B
      444154455D205B54494D455D00000000FFFF0900417269616C20435952000600
      000000004B4B4B00080000000000020000000000FFFFFF000000000000050069
      6E666F3100FB01000028000000D00000000C0000000300000001000000000000
      000000FFFFFF002E02000000000001002800C0D0CC20DDEDE5F0E3E5F2E8EAE0
      2E20CECECE2022C0E2F2EEECE0F2E8E7E0F6E8FF2D323030302200000000FFFF
      0900417269616C2043595200060000000000C0C0C00001000000000002000000
      0000FFFFFF00000000000005007469746C6500480000004D0000008302000025
      0000000300000001000000C0C0C0000000FFFFFF002E02000000000002003600
      CFF0E8EDE8ECE0E5ECE0FF20E820E2FBE4E0E2E0E5ECE0FF20E0EAF2E8E2EDE0
      FF20E820F0E5E0EAF2E8E2EDE0FF20FDEDE5F0E3E8FF0D2900EFEE20F4E8E4E5
      F0F32028EFF0E8F1EEE5E4E8EDE5EDE8FE2920E7E0205B5265706F7274446174
      655D00000000FFFF0900417269616C20435952000B0000000000000000000200
      00000000020000000000FFFFFF0000000000000800436F6E7472616374004800
      00002500000022010000120000000300000001000000C0C0C0000000FFFFFF00
      2E02000000000001000A005B436F6E74726163745D00000000FFFF0900417269
      616C20435952000A000000000000000000000000000000020000000000FFFFFF
      00000000000005004D656D6F320048000000EE00000018000000410000000300
      0F0001000000000000000000FFFFFF1F2E02000000000002000100B90D0300EF
      2FF700000000FFFF0900417269616C2043595200090000000000000000000A00
      00000000020000000000FFFFFF00000000000005004D656D6F330060000000EE
      0000002C0000004100000003000F0001000000000000000000FFFFFF1F2E0200
      0000000001000500C2F0E5ECFF00000000FFFF0900417269616C204359520009
      0000000000000000000A0000000000020000000000FFFFFF0000000000000500
      4D656D6F34008C000000EE0000008F0000002000000003000F00010000000000
      00000000FFFFFF1F2E02000000000002000800C0EAF2E8E2EDE0FF0D1300EFF0
      E8EDE8ECE0E5ECE0FF20FDEDE5F0E3E8FF00000000FFFF0900417269616C2043
      595200090000000000000000000A0000000000020000000000FFFFFF00000000
      000005004D656D6F36001B010000EE0000008F0000002000000003000F000100
      0000000000000000FFFFFF1F2E02000000000002000800C0EAF2E8E2EDE0FF0D
      1200E2FBE4E0E2E0E5ECE0FF20FDEDE5F0E3E8FF00000000FFFF090041726961
      6C2043595200090000000000000000000A0000000000020000000000FFFFFF00
      000000000005004D656D6F3900AA010000EE0000008F0000002000000003000F
      0001000000000000000000FFFFFF1F2E02000000000002000A00D0E5E0EAF2E8
      E2EDE0FF0D1300EFF0E8EDE8ECE0E5ECE0FF20FDEDE5F0E3E8FF00000000FFFF
      0900417269616C2043595200090000000000000000000A000000000002000000
      0000FFFFFF00000000000006004D656D6F31310039020000EE0000008F000000
      2000000003000F0001000000000000000000FFFFFF1F2E02000000000002000A
      00D0E5E0EAF2E8E2EDE0FF0D1200E2FBE4E0E2E0E5ECE0FF20FDEDE5F0E3E8FF
      00000000FFFF0900417269616C2043595200090000000000000000000A000000
      0000020000000000FFFFFF00000000000006004D656D6F313500480000004801
      0000180000000F00000003000F0001000000000000000000FFFFFF1F2E020000
      000000010007005B484849445D2000000000FFFF0900417269616C2043595200
      08000000000000000000010000000000020000000000FFFFFF00000000000006
      004D656D6F31360060000000480100002C0000000F00000003000F0001000000
      000000000000FFFFFF1F2E020000000000010008005B484854696D655D000000
      00FFFF0900417269616C20435952000800000000000000000002000000000002
      0000000000FFFFFF00000000000006004D656D6F3137008C0000004801000045
      0000000F00000003000F0001000000000000000000FFFFFF1F2E020000000000
      01000B005B446973706C617941705D00000000FFFF0900417269616C20435952
      0008000000000000000000090000000000020000000000FFFFFF000000000000
      06004D656D6F313800D1000000480100004A0000000F00000003000F00010000
      00000000000000FFFFFF1F2E020000000000010009005B44656C746141705D00
      000000FFFF0900417269616C2043595200080000000000000000000900000000
      00020000000000FFFFFF00000000000006004D656D6F3139001B010000480100
      00450000000F00000003000F0001000000000000000000FFFFFF1F2E02000000
      000001000B005B446973706C6179416D5D00000000FFFF0900417269616C2043
      59520008000000000000000000090000000000020000000000FFFFFF00000000
      000006004D656D6F32300060010000480100004A0000000F00000003000F0001
      000000000000000000FFFFFF1F2E020000000000010009005B44656C7461416D
      5D00000000FFFF0900417269616C204359520008000000000000000000090000
      000000020000000000FFFFFF00000000000006004D656D6F323100AA01000048
      010000450000000F00000003000F0001000000000000000000FFFFFF1F2E0200
      0000000001000B005B446973706C617952705D00000000FFFF0900417269616C
      204359520008000000000000000000090000000000020000000000FFFFFF0000
      0000000006004D656D6F323200EF010000480100004A0000000F00000003000F
      0001000000000000000000FFFFFF1F2E020000000000010009005B44656C7461
      52705D00000000FFFF0900417269616C20435952000800000000000000000009
      0000000000020000000000FFFFFF00000000000006004D656D6F323300390200
      0048010000440000000F00000003000F0001000000000000000000FFFFFF1F2E
      02000000000001000B005B446973706C6179526D5D00000000FFFF0900417269
      616C204359520008000000000000000000090000000000020000000000FFFFFF
      00000000000006004D656D6F3234007D020000480100004B0000000F00000003
      000F0001000000000000000000FFFFFF1F2E020000000000010009005B44656C
      7461526D5D00000000FFFF0900417269616C2043595200080000000000000000
      00090000000000020000000000FFFFFF00000000000005004D656D6F35008C00
      00001E010000450000001100000003000F0001000000000000000000FFFFFF1F
      2E02000000000001000900EFEEEAE0E7E0EDE8E500000000FFFF090041726961
      6C2043595200090000000000000000000A0000000000020000000000FFFFFF00
      000000000005004D656D6F3700D10000001E0100004A0000001100000003000F
      0001000000000000000000FFFFFF1F2E02000000000001000600F0E0F1F5EEE4
      00000000FFFF0900417269616C2043595200090000000000000000000A000000
      0000020000000000FFFFFF00000000000006004D656D6F313000390200001E01
      0000440000001100000003000F0001000000000000000000FFFFFF1F2E020000
      00000001000900EFEEEAE0E7E0EDE8E500000000FFFF0900417269616C204359
      5200090000000000000000000A0000000000020000000000FFFFFF0000000000
      0006004D656D6F3134007D0200001E0100004B0000001100000003000F000100
      0000000000000000FFFFFF1F2E02000000000001000600F0E0F1F5EEE4000000
      00FFFF0900417269616C2043595200090000000000000000000A000000000002
      0000000000FFFFFF00000000000006004D656D6F323500AA0100001E01000045
      0000001100000003000F0001000000000000000000FFFFFF1F2E020000000000
      01000900EFEEEAE0E7E0EDE8E500000000FFFF0900417269616C204359520009
      0000000000000000000A0000000000020000000000FFFFFF0000000000000600
      4D656D6F323600EF0100001E0100004A0000001100000003000F000100000000
      0000000000FFFFFF1F2E02000000000001000600F0E0F1F5EEE400000000FFFF
      0900417269616C2043595200090000000000000000000A000000000002000000
      0000FFFFFF00000000000006004D656D6F3237001B0100001E01000045000000
      1100000003000F0001000000000000000000FFFFFF1F2E020000000000010009
      00EFEEEAE0E7E0EDE8E500000000FFFF0900417269616C204359520009000000
      0000000000000A0000000000020000000000FFFFFF00000000000006004D656D
      6F323800600100001E0100004A0000001100000003000F000100000000000000
      0000FFFFFF1F2E02000000000001000600F0E0F1F5EEE400000000FFFF090041
      7269616C2043595200090000000000000000000A0000000000020000000000FF
      FFFF00000000000006004D656D6F333100480000007901000049000000120000
      000300000001000000000000000000FFFFFF1F2E02000000000001000500C8F2
      EEE3EE00000000FFFF0900417269616C20435952000900000000000000000009
      0000000000020000000000FFFFFF00000000000006004D656D6F333300AC0000
      00790100006F000000120000000300000001000000000000000000FFFFFF1F2E
      020000000000010007005B53756D41705D00000000FFFF0900417269616C2043
      59520009000000000000000000090000000000020000000000FFFFFF00000000
      000006004D656D6F3335003B010000790100006F000000120000000300000001
      000000000000000000FFFFFF1F2E020000000000010007005B53756D416D5D00
      000000FFFF0900417269616C2043595200090000000000000000000900000000
      00020000000000FFFFFF00000000000006004D656D6F333700CA010000790100
      006F000000120000000300000001000000000000000000FFFFFF1F2E02000000
      0000010007005B53756D52705D00000000FFFF0900417269616C204359520009
      000000000000000000090000000000020000000000FFFFFF0000000000000600
      4D656D6F33380059020000790100006F00000012000000030000000100000000
      0000000000FFFFFF1F2E020000000000010007005B53756D526D5D00000000FF
      FF0900417269616C204359520009000000000000000000090000000000020000
      000000FFFFFF000000000000100043757272656E744D657465724E616D650049
      000000A300000083020000110000000300000001000000000000000000FFFFFF
      1F2E020000000000010012005B43757272656E744D657465724E616D655D0000
      0000FFFF0900417269616C20435952000A000000000000000000080000000000
      020000000000FFFFFF00000000000009006D657465725F6B746900C0010000B6
      0000000C010000100000000300000001000000000000000000FFFFFF1F2E0200
      0000000001001500CAF2F23A205B43757272656E744D657465724B695D000000
      00FFFF0900417269616C20435952000900000000000000000008000000000002
      0000000000FFFFFF00000000000009006D657465725F6B747500C0010000C800
      00000C010000100000000300000001000000000000000000FFFFFF1F2E020000
      00000001001500CAF2ED3A205B43757272656E744D657465724B755D00000000
      FFFF0900417269616C2043595200090000000000000000000800000000000200
      00000000FFFFFF00000000000008006D657465725F6B7400C0010000DA000000
      0C010000100000000300000001000000000000000000FFFFFF1F2E0200000000
      0001001C00CAF22028EEE1F9E8E9293A205B43757272656E744D657465724B54
      5D00000000FFFF0900417269616C204359520009000000000000000000080000
      000000020000000000FFFFFF0000000000000B004465736372697074696F6E00
      49000000B600000072010000100000000300000001000000000000000000FFFF
      FF1F2E02000000000001003700D1F7E5F2F7E8EA3A205B43757272656E744D65
      746572547970655D2C20E7E0E22EB9205B43757272656E744D657465724E756D
      6265725D00000000FFFF0900417269616C204359520009000000000000000000
      080000000000020000000000FFFFFF0000000000000900446174615374617465
      0049000000C800000072010000100000000300000001000000000000000000FF
      FFFF1F2E02000000000001002300CFEEEBEDEEF2E020E4E0EDEDFBF53A205B43
      757272656E744D6574657253746174655D00000000FFFF0900417269616C2043
      59520009000000000000000000080000000000020000000000FFFFFF00000000
      000006004D656D6F3530004800000028020000E40000000E0000000300000001
      000000000000000000FFFFFF1F2E02000000000001002000CEF2F7E5F220F1F4
      EEF0ECE8F0EEE2E0ED3A205B444154455D205B54494D455D00000000FFFF0900
      417269616C204359520007000000000000000000080000000000020000000000
      FFFFFF00000000000006004D656D6F3531006802000028020000600000000E00
      00000300000001000000000000000000FFFFFF1F2E020000000000010007005B
      50414745235D00000000FFFF0900417269616C20435952000700000000000000
      0000090000000000020000000000FFFFFF0000000000000C004461746156616C
      69646974790049000000DA000000720100001000000003000000010000000000
      00000000FFFFFF1F2E02000000000001002C00C4EEF1F2EEE2E5F0EDEEF1F2FC
      20E4E0EDEDFBF53A205B43757272656E744D6574657256616C69646974795D00
      000000FFFF0900417269616C2043595200090000000000000000000800000000
      00020000000000FFFFFF00000000000005004D656D6F31008C0000000E010000
      8F0000001000000003000F0001000000000000000000FFFFFF1F2E0200000000
      0001000500EAC2F2B7F700000000FFFF0900417269616C204359520008000000
      0000000000000A0000000000020000000000FFFFFF00000000000005004D656D
      6F38001B0100000E0100008F0000001000000003000F00010000000000000000
      00FFFFFF1F2E02000000000001000500EAC2F2B7F700000000FFFF0900417269
      616C2043595200080000000000000000000A0000000000020000000000FFFFFF
      00000000000006004D656D6F313200AA0100000E0100008F0000001000000003
      000F0001000000000000000000FFFFFF1F2E02000000000001000600EAE2E0F0
      B7F700000000FFFF0900417269616C2043595200080000000000000000000A00
      00000000020000000000FFFFFF00000000000006004D656D6F31330039020000
      0E0100008F0000001000000003000F0001000000000000000000FFFFFF1F2E02
      000000000001000600EAE2E0F0B7F700000000FFFF0900417269616C20435952
      00080000000000000000000A0000000000020000000000FFFFFF00000000FE00
      000000000000}
  end
end
