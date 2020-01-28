object knsl3DepartamenIns: Tknsl3DepartamenIns
  Left = 262
  Top = 174
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Добавление районныйх электрических сетей'
  ClientHeight = 348
  ClientWidth = 1015
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object aop_AbonPages: TAdvOfficePager
    Left = 0
    Top = 0
    Width = 1015
    Height = 348
    Align = alClient
    ActivePage = aop_AbonAttributes
    ButtonSettings.CloseButtonPicture.Data = {
      424DA20400000000000036040000280000000900000009000000010008000000
      00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001000001010100000100
      0000000202000100020200000000000202020002020200000000010002020202
      0200010000000101000202020001010000000100020202020200010000000002
      0202000202020000000000020200010002020000000001000001010100000100
      0000}
    ButtonSettings.PageListButtonPicture.Data = {
      424DA20400000000000036040000280000000900000009000000010008000000
      00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010101000101010100
      0000010101000200010101000000010100020202000101000000010002020202
      0200010000000002020200020202000000000002020001000202000000000100
      0001010100000100000001010101010101010100000001010101010101010100
      0000}
    ButtonSettings.ScrollButtonPrevPicture.Data = {
      424DA20400000000000036040000280000000900000009000000010008000000
      00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010101000001010100
      0000010101000202000101000000010100020202000101000000010002020200
      0101010000000002020200010101010000000100020202000101010000000101
      0002020200010100000001010100020200010100000001010101000001010100
      0000}
    ButtonSettings.ScrollButtonNextPicture.Data = {
      424DA20400000000000036040000280000000900000009000000010008000000
      00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010000010101010100
      0000010002020001010101000000010002020200010101000000010100020202
      0001010000000101010002020200010000000101000202020001010000000100
      0202020001010100000001000202000101010100000001010000010101010100
      0000}
    ButtonSettings.CloseButtonHint = 'Close'
    ButtonSettings.PageListButtonHint = 'Page List'
    ButtonSettings.ScrollButtonNextHint = 'Next'
    ButtonSettings.ScrollButtonPrevHint = 'Previous'
    Constraints.MinWidth = 510
    TabSettings.StartMargin = 4
    TabSettings.Shape = tsRightRamp
    TabReorder = False
    ShowShortCutHints = False
    TabOrder = 0
    NextPictureChanged = False
    PrevPictureChanged = False
    object aop_AbonAttributes: TAdvOfficePage
      Left = 1
      Top = 26
      Width = 1013
      Height = 320
      Hint = 'Fnh'
      Caption = 'Атрибуты районных электрических сетей'
      ImageIndex = 0
      PageAppearance.BorderColor = 14922381
      PageAppearance.Color = 16445929
      PageAppearance.ColorTo = 15587527
      PageAppearance.ColorMirror = 15587527
      PageAppearance.ColorMirrorTo = 16773863
      PageAppearance.Gradient = ggVertical
      PageAppearance.GradientMirror = ggVertical
      TabAppearance.BorderColor = clNone
      TabAppearance.BorderColorHot = 15383705
      TabAppearance.BorderColorSelected = 14922381
      TabAppearance.BorderColorSelectedHot = 6343929
      TabAppearance.BorderColorDisabled = clNone
      TabAppearance.BorderColorDown = clNone
      TabAppearance.Color = clBtnFace
      TabAppearance.ColorTo = clWhite
      TabAppearance.ColorSelected = 16709360
      TabAppearance.ColorSelectedTo = 16445929
      TabAppearance.ColorDisabled = clWhite
      TabAppearance.ColorDisabledTo = clSilver
      TabAppearance.ColorHot = 14542308
      TabAppearance.ColorHotTo = 16768709
      TabAppearance.ColorMirror = clWhite
      TabAppearance.ColorMirrorTo = clWhite
      TabAppearance.ColorMirrorHot = 14016477
      TabAppearance.ColorMirrorHotTo = 10736609
      TabAppearance.ColorMirrorSelected = 16445929
      TabAppearance.ColorMirrorSelectedTo = 16181984
      TabAppearance.ColorMirrorDisabled = clWhite
      TabAppearance.ColorMirrorDisabledTo = clSilver
      TabAppearance.Font.Charset = DEFAULT_CHARSET
      TabAppearance.Font.Color = clWindowText
      TabAppearance.Font.Height = -11
      TabAppearance.Font.Name = 'Tahoma'
      TabAppearance.Font.Style = []
      TabAppearance.Gradient = ggVertical
      TabAppearance.GradientMirror = ggVertical
      TabAppearance.GradientHot = ggRadial
      TabAppearance.GradientMirrorHot = ggVertical
      TabAppearance.GradientSelected = ggVertical
      TabAppearance.GradientMirrorSelected = ggVertical
      TabAppearance.GradientDisabled = ggVertical
      TabAppearance.GradientMirrorDisabled = ggVertical
      TabAppearance.TextColor = 9126421
      TabAppearance.TextColorHot = 9126421
      TabAppearance.TextColorSelected = 9126421
      TabAppearance.TextColorDisabled = clGray
      TabAppearance.ShadowColor = 15255470
      TabAppearance.HighLightColor = 16775871
      TabAppearance.HighLightColorHot = 16643309
      TabAppearance.HighLightColorSelected = 6540536
      TabAppearance.HighLightColorSelectedHot = 12451839
      TabAppearance.HighLightColorDown = 16776144
      TabAppearance.BackGround.Color = 16767935
      TabAppearance.BackGround.ColorTo = clNone
      TabAppearance.BackGround.Direction = gdHorizontal
      object AdvPanel3: TAdvPanel
        Left = 2
        Top = 2
        Width = 1009
        Height = 316
        Align = alClient
        BevelOuter = bvNone
        Color = 13616833
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7485192
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        UseDockManager = True
        Version = '1.7.9.0'
        BorderColor = 16765615
        Caption.Color = 12105910
        Caption.ColorTo = 10526878
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWhite
        Caption.Font.Height = -11
        Caption.Font.Name = 'MS Sans Serif'
        Caption.Font.Style = []
        Caption.GradientDirection = gdVertical
        Caption.Indent = 2
        Caption.ShadeLight = 255
        CollapsColor = clHighlight
        CollapsDelay = 0
        ColorTo = 12958644
        ColorMirror = 12958644
        ColorMirrorTo = 15527141
        ShadowColor = clBlack
        ShadowOffset = 0
        StatusBar.BorderStyle = bsSingle
        StatusBar.Font.Charset = DEFAULT_CHARSET
        StatusBar.Font.Color = clWhite
        StatusBar.Font.Height = -11
        StatusBar.Font.Name = 'Tahoma'
        StatusBar.Font.Style = []
        StatusBar.Color = 10592158
        StatusBar.ColorTo = 5459275
        StatusBar.GradientDirection = gdVertical
        FullHeight = 0
        object Label1: TLabel
          Left = 4
          Top = 1
          Width = 317
          Height = 17
          Caption = 'Таблица 1. Список всех районов в система:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = 17
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object RTFLabel1: TRTFLabel
          Left = 782
          Top = 145
          Width = 491
          Height = 168
          RichText = 
            '{\rtf1\ansi\ansicpg1251\deff0{\fonttbl{\f0\fnil\fcharset204{\*\f' +
            'name Arial;}Arial CYR;}}'#13#10'{\colortbl ;\red0\green0\blue0;\red0\g' +
            'reen128\blue0;\red128\green0\blue0;\red154\green151\blue14;}'#13#10'\v' +
            'iewkind4\uc1\pard\cf1\lang1049\f0\fs22\'#39'c8\'#39'ed\'#39'f1\'#39'f2\'#39'f0\'#39'f3\'#39 +
            'ea\'#39'f6\'#39'e8\'#39'ff \'#39'ef\'#39'ee \'#39'e4\'#39'ee\'#39'e1\'#39'e0\'#39'e2\'#39'eb\'#39'e5\'#39'ed\'#39'e8\'#39'fe' +
            ' \'#39'ed\'#39'ee\'#39'e2\'#39'ee\'#39'e3\'#39'ee \'#39'ef\'#39'ee\'#39'e4\'#39'f0\'#39'e0\'#39'e7\'#39'e4\'#39'e5\'#39'eb\'#39 +
            'e5\'#39'ed\'#39'e8\'#39'ff \'#39'e8\'#39'eb\'#39'e8 \'#39'f3\'#39'e4\'#39'e0\'#39'eb\'#39'e5\'#39'ed\'#39'e8\'#39'e5 \'#39'f' +
            '3\'#39'e6\'#39'e5 \'#39'e8\'#39'ec\'#39'e5\'#39'fe\'#39'f9\'#39'e8\'#39'f5\'#39'f1\'#39'ff:\cf0\fs16 '#13#10'\par ' +
            '\fs18 1. \cf2\'#39'c4\'#39'eb\'#39'ff \'#39'e4\'#39'ee\'#39'e1\'#39'e0\'#39'e2\'#39'eb\'#39'e5\'#39'ed\'#39'e8\'#39 +
            'ff \'#39'ed\'#39'ee\'#39'e2\'#39'ee\'#39'e3\'#39'ee \'#39'ef\'#39'ee\'#39'e4\'#39'f0\'#39'e0\'#39'e7\'#39'e4\'#39'e5\'#39'eb' +
            '\'#39'e5\'#39'ed\'#39'e8\'#39'ff \'#39'e2 \'#39'ed\'#39'f3\'#39'e6\'#39'ed\'#39'fb\'#39'e9 \'#39'f0\'#39'e0\'#39'e9\'#39'ee\' +
            #39'ed, \'#39'e2\'#39'fb\'#39'e1\'#39'e5\'#39'f0\'#39'e8\'#39'f2\'#39'e5 \'#39'f0\'#39'e0\'#39'e9\'#39'ee\'#39'ed \'#39'e2 ' +
            '\'#39'f2\'#39'e0\'#39'e1\'#39'eb\'#39'e8\'#39'f6\'#39'e5 1.\cf0 '#13#10'\par 2.\cf3\'#39'c2\'#39'e2\'#39'e5\'#39'e' +
            '4\'#39'e8\'#39'f2\'#39'e5 \b\'#39'ed\'#39'ee\'#39'e2\'#39'ee\'#39'e5 \'#39'ed\'#39'e0\'#39'e7\'#39'e2\'#39'e0\'#39'ed\'#39'e' +
            '8\'#39'e5 \'#39'ef\'#39'ee\'#39'e4\'#39'f0\'#39'e0\'#39'e7\'#39'e4\'#39'e5\'#39'eb\'#39'e5\'#39'ed\'#39'e8\'#39'ff\b0  \' +
            #39'e2 \'#39'ef\'#39'ee\'#39'eb\'#39'e5 1. \'#39'e8 \'#39'ed\'#39'e0\'#39'e6\'#39'ec\'#39'e8\'#39'f2\'#39'e5 \'#39'ea\'#39 +
            'ed\'#39'ee\'#39'ef\'#39'ea\'#39'f3 \'#39'e4\'#39'ee\'#39'e1\'#39'e0\'#39'e2\'#39'e8\'#39'f2\'#39'fc.'#13#10'\par \cf0 ' +
            '2. \cf3\'#39'c2\'#39'e2\'#39'e5\'#39'e4\'#39'e8\'#39'f2\'#39'e5 \b\'#39'ea\'#39'ee\'#39'e4 \'#39'ef\'#39'ee\'#39'e4\' +
            #39'f0\'#39'e0\'#39'e7\'#39'e4\'#39'e5\'#39'eb\'#39'e5\'#39'ed\'#39'e8\'#39'ff\b0  \'#39'e2 \'#39'ef\'#39'ee\'#39'eb\'#39'e' +
            '5 2. \'#39'e8 \'#39'ed\'#39'e0\'#39'e6\'#39'ec\'#39'e8\'#39'f2\'#39'e5 \'#39'ea\'#39'ed\'#39'ee\'#39'ef\'#39'ea\'#39'f3 ' +
            '\'#39'e4\'#39'ee\'#39'e1\'#39'e0\'#39'e2\'#39'e8\'#39'f2\'#39'fc.\cf4 '#13#10'\par '#13#10'\par \cf0 1. \cf2' +
            '\'#39'c4\'#39'eb\'#39'ff \'#39'f3\'#39'e4\'#39'e0\'#39'eb\'#39'e5\'#39'ed\'#39'e8\'#39'ff \'#39'ed\'#39'ee\'#39'e2\'#39'ee\'#39 +
            'e3\'#39'ee \'#39'ef\'#39'ee\'#39'e4\'#39'f0\'#39'e0\'#39'e7\'#39'e4\'#39'e5\'#39'eb\'#39'e5\'#39'ed\'#39'e8\'#39'ff, \'#39'e' +
            '2\'#39'fb\'#39'e1\'#39'e5\'#39'f0\'#39'e8\'#39'f2\'#39'e5 \'#39'ed\'#39'f3\'#39'e6\'#39'ed\'#39'fb\'#39'e9 \'#39'f0\'#39'e0\' +
            #39'e9\'#39'ee\'#39'ed \'#39'e2 \'#39'f2\'#39'e0\'#39'e1\'#39'eb\'#39'e8\'#39'f6\'#39'e5 1.'#13#10'\par \cf0 2. \' +
            'cf3\'#39'c2\'#39'fb\'#39'e1\'#39'e5\'#39'f0\'#39'e8\'#39'f2\'#39'e5 \'#39'ed\'#39'f3\'#39'e6\'#39'ed\'#39'ee\'#39'e5 \'#39'e' +
            'f\'#39'ee\'#39'e4\'#39'f0\'#39'e0\'#39'e7\'#39'e4\'#39'e5\'#39'eb\'#39'e5\'#39'ed\'#39'e8\'#39'e5 \'#39'e8\'#39'e7 \'#39'f2\' +
            #39'e0\'#39'e1\'#39'eb\'#39'e8\'#39'f6\'#39'fb 2 \'#39'e8 \'#39'ed\'#39'e0\'#39'e6\'#39'ec\'#39'e8\'#39'f2\'#39'e5 \'#39'ea' +
            '\'#39'ed\'#39'ee\'#39'ef\'#39'ea\'#39'f3 \'#39'f3\'#39'e4\'#39'e0\'#39'eb\'#39'e8\'#39'f2\'#39'fc\cf0 '#13#10'\par '#13#10'\' +
            'par }'#13#10#0
          Color = 12958644
          Transparent = True
          WordWrap = False
          Version = '1.3.0.0'
        end
        object Label2: TLabel
          Left = 336
          Top = 1
          Width = 429
          Height = 17
          Caption = 'Таблица 2. Список подразделений в выбранноми районе:'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = 17
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object btn_DepartamentDel: TRbButton
          Left = 334
          Top = 284
          Width = 445
          Height = 29
          Hint = 'Удалить район'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7485192
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btn_DepartamentDelClick
          TabOrder = 0
          TextShadow = True
          Caption = 'Удалить'
          ModalResult = 0
          Spacing = 2
          Layout = blGlyphLeft
          Colors.DefaultFrom = clWhite
          Colors.DefaultTo = 13745839
          Colors.OverFrom = clWhite
          Colors.OverTo = 12489846
          Colors.ClickedFrom = 13029334
          Colors.ClickedTo = 15463415
          Colors.HotTrack = clBlue
          Colors.BorderColor = clGray
          Colors.TextShadow = clWhite
          FadeSpeed = fsMedium
          ShowFocusRect = True
          HotTrack = False
          GradientBorder = True
        end
        object GroupBox1: TGroupBox
          Left = 782
          Top = 23
          Width = 507
          Height = 122
          Caption = 'Добавлнение нового подразделения'
          TabOrder = 1
          object Label14: TLabel
            Left = 7
            Top = 24
            Width = 223
            Height = 14
            Caption = '1. Новое название подразделения:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label3: TLabel
            Left = 7
            Top = 48
            Width = 148
            Height = 14
            Caption = '2. Код подразделения:'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object btn_DepartamentAdd: TRbButton
            Left = 50
            Top = 88
            Width = 367
            Height = 26
            Hint = 'Добавить район'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7485192
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = btn_DepartamentAddClick
            TabOrder = 0
            TextShadow = True
            Caption = 'Добавить'
            ModalResult = 0
            Spacing = 2
            Layout = blGlyphLeft
            Colors.DefaultFrom = clWhite
            Colors.DefaultTo = 13745839
            Colors.OverFrom = clWhite
            Colors.OverTo = 12489846
            Colors.ClickedFrom = 13029334
            Colors.ClickedTo = 15463415
            Colors.HotTrack = clBlue
            Colors.BorderColor = clGray
            Colors.TextShadow = clWhite
            FadeSpeed = fsMedium
            ShowFocusRect = True
            HotTrack = False
            GradientBorder = True
          end
          object DepartamEsName: TEdit
            Left = 232
            Top = 21
            Width = 271
            Height = 21
            TabOrder = 1
          end
          object Code: TEdit
            Left = 232
            Top = 45
            Width = 271
            Height = 21
            TabOrder = 2
          end
        end
        object AdvRegionES: TAdvStringGrid
          Left = 0
          Top = 24
          Width = 318
          Height = 257
          Cursor = crDefault
          ColCount = 2
          DefaultRowHeight = 21
          RowCount = 5
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          GridLineWidth = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goRowSelect]
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 2
          GridLineColor = 15062992
          OnClickCell = AdvRegionESClickCell
          ActiveCellFont.Charset = RUSSIAN_CHARSET
          ActiveCellFont.Color = clWindowText
          ActiveCellFont.Height = -11
          ActiveCellFont.Name = 'Times New Roman'
          ActiveCellFont.Style = [fsBold]
          ActiveCellColor = 10344697
          ActiveCellColorTo = 6210033
          Bands.Active = True
          Bands.PrimaryColor = 16310238
          Bands.SecondaryColor = clWhite
          CellNode.ShowTree = False
          ColumnHeaders.Strings = (
            '№ п/п'
            'Название')
          ControlLook.FixedGradientFrom = 16513526
          ControlLook.FixedGradientTo = 15260626
          ControlLook.ControlStyle = csClassic
          EnhRowColMove = False
          Filter = <>
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = clWindowText
          FixedFont.Height = -13
          FixedFont.Name = 'Times New Roman'
          FixedFont.Style = []
          FloatFormat = '%.2f'
          PrintSettings.DateFormat = 'dd/mm/yyyy'
          PrintSettings.Font.Charset = DEFAULT_CHARSET
          PrintSettings.Font.Color = clWindowText
          PrintSettings.Font.Height = -11
          PrintSettings.Font.Name = 'MS Sans Serif'
          PrintSettings.Font.Style = []
          PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
          PrintSettings.FixedFont.Color = clWindowText
          PrintSettings.FixedFont.Height = -11
          PrintSettings.FixedFont.Name = 'MS Sans Serif'
          PrintSettings.FixedFont.Style = []
          PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
          PrintSettings.HeaderFont.Color = clWindowText
          PrintSettings.HeaderFont.Height = -11
          PrintSettings.HeaderFont.Name = 'MS Sans Serif'
          PrintSettings.HeaderFont.Style = []
          PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
          PrintSettings.FooterFont.Color = clWindowText
          PrintSettings.FooterFont.Height = -11
          PrintSettings.FooterFont.Name = 'MS Sans Serif'
          PrintSettings.FooterFont.Style = []
          PrintSettings.Borders = pbNoborder
          PrintSettings.Centered = False
          PrintSettings.PageNumSep = '/'
          RowHeaders.Strings = (
            '№ п/п')
          RowIndicator.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF001F5C00FF1F5B00FF1F5C00FFFFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF001B6100FF156B06FF1D5F00FF205D00FFFFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00176301FF0D7910FF167510FF1B6001FF205D
            00FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF001A6403FF057709FF097A0EFF157B16FF1A64
            03FF205B00FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF001C6606FF0C861AFF007E0BFF068314FF1486
            1EFF186C0AFF1F5B00FF1F5D00FFFFFFFF00FFFFFF00FFFFFF001E5B00FF1F5D
            00FF1F5D00FF1F5D00FF1F5B00FF1F6C0DFF13952AFF008B17FF008A17FF038B
            1AFF129025FF177712FF1D5D00FF205D00FFFFFFFF00FFFFFF001D5C00FF0878
            0BFF058212FF058414FF058516FF0D9225FF079C2AFF009823FF009823FF0095
            20FF01931FFF0F982AFF17841DFF1C6102FF205C00FF1E5C00FF1C5C00FF078E
            1EFF009B24FF009F28FF00A32BFF00A42DFF00A42DFF00A52EFF00A42EFF00A1
            2CFF009E28FF009923FF0A9C2CFF148F25FF1A6A08FF1E5A00FF1B5C00FF2BA2
            42FF0DAA39FF05AA35FF01AD36FF00AF36FF00B037FF00B137FF00AF36FF00AD
            34FF00AA32FF01A630FF05A12DFF15A73BFF169127FF1C5B00FF195C00FF56BC
            6EFF39C86AFF32C766FF2FCB67FF29CA63FF23C65DFF23C65DFF23C55CFF25C3
            5BFF28C15AFF2CBE5BFF36C162FF229E39FF1A6707FFFFFFFF001A5B00FF3E9B
            45FF2FA748FF2AA645FF2AA746FF3BBE61FF4DDB85FF46D97FFF47D87EFF45D5
            7BFF48D57DFF50D581FF2C9D3EFF1B6002FFFFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF0028781BFF6CE8A0FF56E692FF56E390FF60E7
            99FF63DF93FF2C9135FF1A5900FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF002B781DFF87F0B5FF6FEFA7FF7FF6B5FF6DDE
            97FF258124FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF002D7B20FFAEF7CFFFADFED4FF70D28EFF1C70
            11FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF002D7F23FFC5FFE3FF62BF77FF146303FFFFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF0020690DFF2E8F36FF155A00FFFFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
          ScrollWidth = 14
          SearchFooter.Color = 16773091
          SearchFooter.ColorTo = 16765615
          SearchFooter.FindNextCaption = 'Find &next'
          SearchFooter.FindPrevCaption = 'Find &previous'
          SearchFooter.Font.Charset = DEFAULT_CHARSET
          SearchFooter.Font.Color = clWindowText
          SearchFooter.Font.Height = -11
          SearchFooter.Font.Name = 'MS Sans Serif'
          SearchFooter.Font.Style = []
          SearchFooter.HighLightCaption = 'Highlight'
          SearchFooter.HintClose = 'Close'
          SearchFooter.HintFindNext = 'Find next occurence'
          SearchFooter.HintFindPrev = 'Find previous occurence'
          SearchFooter.HintHighlight = 'Highlight occurences'
          SearchFooter.MatchCaseCaption = 'Match case'
          SelectionColor = 6210033
          WordWrap = False
          ColWidths = (
            64
            250)
          RowHeights = (
            21
            21
            21
            21
            21)
        end
        object AdvDepartamentES: TAdvStringGrid
          Left = 333
          Top = 24
          Width = 445
          Height = 257
          Cursor = crDefault
          ColCount = 3
          DefaultRowHeight = 21
          RowCount = 5
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          GridLineWidth = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goRowSelect]
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 3
          GridLineColor = 15062992
          ActiveCellFont.Charset = RUSSIAN_CHARSET
          ActiveCellFont.Color = clWindowText
          ActiveCellFont.Height = -11
          ActiveCellFont.Name = 'Times New Roman'
          ActiveCellFont.Style = [fsBold]
          ActiveCellColor = 10344697
          ActiveCellColorTo = 6210033
          Bands.Active = True
          Bands.PrimaryColor = 16310238
          Bands.SecondaryColor = clWhite
          CellNode.ShowTree = False
          ColumnHeaders.Strings = (
            '№ п/п'
            'Название'
            'Код подразделения')
          ControlLook.FixedGradientFrom = 16513526
          ControlLook.FixedGradientTo = 15260626
          ControlLook.ControlStyle = csClassic
          EnhRowColMove = False
          Filter = <>
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = clWindowText
          FixedFont.Height = -13
          FixedFont.Name = 'Times New Roman'
          FixedFont.Style = []
          FloatFormat = '%.2f'
          PrintSettings.DateFormat = 'dd/mm/yyyy'
          PrintSettings.Font.Charset = DEFAULT_CHARSET
          PrintSettings.Font.Color = clWindowText
          PrintSettings.Font.Height = -11
          PrintSettings.Font.Name = 'MS Sans Serif'
          PrintSettings.Font.Style = []
          PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
          PrintSettings.FixedFont.Color = clWindowText
          PrintSettings.FixedFont.Height = -11
          PrintSettings.FixedFont.Name = 'MS Sans Serif'
          PrintSettings.FixedFont.Style = []
          PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
          PrintSettings.HeaderFont.Color = clWindowText
          PrintSettings.HeaderFont.Height = -11
          PrintSettings.HeaderFont.Name = 'MS Sans Serif'
          PrintSettings.HeaderFont.Style = []
          PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
          PrintSettings.FooterFont.Color = clWindowText
          PrintSettings.FooterFont.Height = -11
          PrintSettings.FooterFont.Name = 'MS Sans Serif'
          PrintSettings.FooterFont.Style = []
          PrintSettings.Borders = pbNoborder
          PrintSettings.Centered = False
          PrintSettings.PageNumSep = '/'
          RowHeaders.Strings = (
            '№ п/п')
          RowIndicator.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF001F5C00FF1F5B00FF1F5C00FFFFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF001B6100FF156B06FF1D5F00FF205D00FFFFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00176301FF0D7910FF167510FF1B6001FF205D
            00FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF001A6403FF057709FF097A0EFF157B16FF1A64
            03FF205B00FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF001C6606FF0C861AFF007E0BFF068314FF1486
            1EFF186C0AFF1F5B00FF1F5D00FFFFFFFF00FFFFFF00FFFFFF001E5B00FF1F5D
            00FF1F5D00FF1F5D00FF1F5B00FF1F6C0DFF13952AFF008B17FF008A17FF038B
            1AFF129025FF177712FF1D5D00FF205D00FFFFFFFF00FFFFFF001D5C00FF0878
            0BFF058212FF058414FF058516FF0D9225FF079C2AFF009823FF009823FF0095
            20FF01931FFF0F982AFF17841DFF1C6102FF205C00FF1E5C00FF1C5C00FF078E
            1EFF009B24FF009F28FF00A32BFF00A42DFF00A42DFF00A52EFF00A42EFF00A1
            2CFF009E28FF009923FF0A9C2CFF148F25FF1A6A08FF1E5A00FF1B5C00FF2BA2
            42FF0DAA39FF05AA35FF01AD36FF00AF36FF00B037FF00B137FF00AF36FF00AD
            34FF00AA32FF01A630FF05A12DFF15A73BFF169127FF1C5B00FF195C00FF56BC
            6EFF39C86AFF32C766FF2FCB67FF29CA63FF23C65DFF23C65DFF23C55CFF25C3
            5BFF28C15AFF2CBE5BFF36C162FF229E39FF1A6707FFFFFFFF001A5B00FF3E9B
            45FF2FA748FF2AA645FF2AA746FF3BBE61FF4DDB85FF46D97FFF47D87EFF45D5
            7BFF48D57DFF50D581FF2C9D3EFF1B6002FFFFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF0028781BFF6CE8A0FF56E692FF56E390FF60E7
            99FF63DF93FF2C9135FF1A5900FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF002B781DFF87F0B5FF6FEFA7FF7FF6B5FF6DDE
            97FF258124FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF002D7B20FFAEF7CFFFADFED4FF70D28EFF1C70
            11FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF002D7F23FFC5FFE3FF62BF77FF146303FFFFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF0020690DFF2E8F36FF155A00FFFFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
          ScrollWidth = 14
          SearchFooter.Color = 16773091
          SearchFooter.ColorTo = 16765615
          SearchFooter.FindNextCaption = 'Find &next'
          SearchFooter.FindPrevCaption = 'Find &previous'
          SearchFooter.Font.Charset = DEFAULT_CHARSET
          SearchFooter.Font.Color = clWindowText
          SearchFooter.Font.Height = -11
          SearchFooter.Font.Name = 'MS Sans Serif'
          SearchFooter.Font.Style = []
          SearchFooter.HighLightCaption = 'Highlight'
          SearchFooter.HintClose = 'Close'
          SearchFooter.HintFindNext = 'Find next occurence'
          SearchFooter.HintFindPrev = 'Find previous occurence'
          SearchFooter.HintHighlight = 'Highlight occurences'
          SearchFooter.MatchCaseCaption = 'Match case'
          SelectionColor = 6210033
          WordWrap = False
          ColWidths = (
            64
            261
            116)
          RowHeights = (
            21
            21
            21
            21
            21)
        end
      end
    end
    object AdvProgressBar1: TAdvProgressBar
      Left = 0
      Top = 328
      Width = 1015
      Height = 20
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      Level0ColorTo = 14811105
      Level1ColorTo = 13303807
      Level2Color = 5483007
      Level2ColorTo = 11064319
      Level3ColorTo = 13290239
      Level1Perc = 70
      Level2Perc = 90
      Position = 0
      ShowBorder = True
      Version = '1.2.0.0'
    end
    object CheckBox1: TCheckBox
      Left = 131
      Top = 138
      Width = 238
      Height = 17
      Caption = 'Атрибуты бытового учета'
      Enabled = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object ComboBox1: TComboBox
      Left = 161
      Top = 55
      Width = 155
      Height = 22
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 2
    end
    object cmbPullAbon: TComboBox
      Left = 159
      Top = 55
      Width = 155
      Height = 22
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 3
    end
  end
end
