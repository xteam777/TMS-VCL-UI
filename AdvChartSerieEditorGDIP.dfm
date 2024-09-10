object AdvChartSeriesEditorFormGDIP: TAdvChartSeriesEditorFormGDIP
  Left = 564
  Top = 161
  BorderStyle = bsDialog
  Caption = 'Chart Series Editor'
  ClientHeight = 532
  ClientWidth = 756
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = -1
    Width = 185
    Height = 41
    TabOrder = 4
    object SpeedButton3: TSpeedButton
      Left = 46
      Top = 0
      Width = 23
      Height = 22
      Cursor = crHandPoint
      Hint = 'Change Serie name'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF00004300004300003C000037000036000036FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000930000930002841518892B
        2D8C2A2A830F0F6200004000003A00003AFF00FFFF00FFFF00FFFF00FFFF00FF
        0004B30104A73D45C3B3B7EAFFFFFFFFFFFFFFFFFFFFFFFFA0A2CC2D2D740000
        3A00004EFF00FFFF00FFFF00FF0005CC0107BA7F89E2FFFFFFFFFFFF9B9CDB5E
        5EB75F5FB6ADADDDFFFFFFFFFFFF5E5E9B00003A000043FF00FFFF00FF0005CC
        6472E5FFFFFFD7DAF52528B30102880A0DA206078C00006A31319CE6E6F7FFFF
        FF36367D000043FF00FF0007E80B1BD8F8F8FFF2F3FC1721C30405A41214A303
        048905068B01017409097630309CFFFFFFC3C3DB01015000004B0007E84358F0
        FFFFFF6476ED0104C00203950507910304870E109807088C03036E0909798686
        C9FFFFFF27278800004B0009F37F94FAFFFFFF1932F05867EAFCFCFDEBEDF8EA
        EAF7EAEBF7FFFFFFFFFFFF03047E3233A2FFFFFF5558BE00004A0218FDA6B4FD
        FFFFFF112CFD0C20F37E89F2FFFFFFFFFFFFFFFFFFFFFFFF0B0EBD0308AE5257
        BEFFFFFF6267C30000781735FFA4B6FFFFFFFF2C4AFF000FFF0518FCA3ACF3FF
        FFFFFFFFFF070EC70107C31017BE5E65CAFDFDFF4A4EBD00007F0318FF91A6FF
        FFFFFFA9B9FF000EFF0008FF0E1FFDA4AEF71420D8060ECA070CC3090FB7BABE
        EDFCFCFD1017AA00007FFF00FF5F7AFFFFFFFFFFFFFF5C75FF000BFF000EFF00
        0AFF0618F80007DB0006CC7380E8FFFFFF8F97E2000198FF00FFFF00FF425FFF
        C4CFFFFFFFFFFFFFFF8B9FFF162FFF0414FF0515FD2037F39FADF7FFFFFFE2E5
        FA101ABA000198FF00FFFF00FFFF00FF5975FFD7DFFFFFFFFFFFFFFFFCFCFFD1
        DBFFD4DFFFFFFFFFFFFFFFC6CDF71825CD0001B0FF00FFFF00FFFF00FFFF00FF
        FF00FF5C76FF97A9FDDAE0FFFFFFFFFFFFFFFFFFFFD4DBFD596FF00514D70001
        B0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5C75FF5C79FF62
        7DFF4A66FD203CF50619E5FF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton3Click
    end
    object SpeedButton2: TSpeedButton
      Left = 0
      Top = 0
      Width = 23
      Height = 22
      Cursor = crHandPoint
      Hint = 'Add Serie'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF00007200007200006B000066000065000065FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0001B70001B7050DAC393EB058
        5AB25657AB2E2F9000006F000069000069FF00FFFF00FFFF00FFFF00FFFF00FF
        0016CE0915C66C74D9CED1F2FFFFFFFFFFFFFFFFFFFFFFFFC1C2DF5A5A9F0101
        6900007DFF00FFFF00FFFF00FF0018DF0A1DD3A8B0EDFFFFFFFFFFFFBDBEE98C
        8CD18D8DD0CACAEAFFFFFFFFFFFF8C8CBD010169000072FF00FFFF00FF0018DF
        919DEFFFFFFFE6E8F94F53CE0002AB00009D0000950000975F5FBEF0F0FAFFFF
        FF6565A6000072FF00FF001EF12743E7FBFBFFF7F8FD3B4BDA0000C0161DBEB0
        B4E7A3A5E00A0CA000008F5252B9FFFFFFD9D9E90B0B7F00007A001EF17287F6
        FFFFFF91A1F4000DDA000BD0161DCBF1F4FEDEE1F60508A900009A000093ACAC
        DDFFFFFF5353AF00007A0023F8A8B8FCFFFFFF4060F61734ECA0AEF2BABEF1F8
        F9FEF3F4FBB6B8E99799DC0D0EA25A5BBFFFFFFF8487D60000790E3EFEC5CFFE
        FFFFFF3259FE2649F9FAFCFFFFFFFFFFFFFFFFFFFFFFFFFFEBECF91519B14A4F
        C1FFFFFF9094D90000A23C63FFC4D0FFFFFFFF5979FF052EFF375CFB586DF4F0
        F3FEE3E6FA4D5ADE3446D20004B7757CD6FFFFFF797DD50000A8103EFFB6C5FF
        FFFFFFC7D2FF032CFF0020FF1739FBF3F6FFE1E5FA071FDC0007CE0C1CCBD9DC
        F5FDFDFE313CC80000A8FF00FF8DA4FFFFFFFFFFFFFF8AA0FF0027FF002CFF46
        6AFF4163F8001DE9061CDFA1ACF1FFFFFFB4BAED0007BBFF00FFFF00FF718DFF
        DAE1FFFFFFFFFFFFFFB1C0FF3B5DFF1538FF1739FE4966F8C0CAFAFFFFFFEDEF
        FC3041D30007BBFF00FFFF00FFFF00FF88A0FFE6EBFFFFFFFFFFFFFFFDFDFFE2
        E9FFE4EBFFFFFFFFFFFFFFDBE0FA3D50E0000BCCFF00FFFF00FFFF00FFFF00FF
        FF00FF8AA1FFBAC7FEE8ECFFFFFFFFFFFFFFFFFFFFE4E9FE889BF61738E6000B
        CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8AA0FF8AA3FF90
        A6FF7993FE4A6BF91A40EFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton2Click
    end
    object SpeedButton1: TSpeedButton
      Left = 23
      Top = 0
      Width = 23
      Height = 22
      Cursor = crHandPoint
      Hint = 'Remove Serie'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF00007200007200006B000066000065000065FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0001B70001B7050DAC393EB058
        5AB25657AB2E2F9000006F000069000069FF00FFFF00FFFF00FFFF00FFFF00FF
        0016CE0915C66C74D9CED1F2FFFFFFFFFFFFFFFFFFFFFFFFC1C2DF5A5A9F0101
        6900007DFF00FFFF00FFFF00FF0018DF0A1DD3A8B0EDFFFFFFFFFFFFBDBEE98C
        8CD18D8DD0CACAEAFFFFFFFFFFFF8C8CBD010169000072FF00FFFF00FF0018DF
        919DEFFFFFFFE6E8F94F53CE0002AB161DBE1A1CB10000975F5FBEF0F0FAFFFF
        FF6565A6000072FF00FF001EF12743E7FBFBFFF7F8FD3B4BDA0000C0161DBE16
        19B40B0CA1090B9F00008F5252B9FFFFFFD9D9E90B0B7F00007A001EF17287F6
        FFFFFF91A1F4000DDA000BD0161DCB1D1EAE0C0DA00609A700009A000093ACAC
        DDFFFFFF5353AF00007A0023F8A8B8FCFFFFFF4060F61734ECF8F9FEF8F9FEF8
        F9FEF3F4FBF3F4FBF3F4FB0D0EA25A5BBFFFFFFF8487D60000790E3EFEC5CFFE
        FFFFFF3259FE2649F9C5CFFDFFFFFFFFFFFFFFFFFFFFFFFFEBECF91519B14A4F
        C1FFFFFF9094D90000A23C63FFC4D0FFFFFFFF5979FF052EFF123AFE122EEB0D
        24E20719D90F17D10004B70004B7757CD6FFFFFF797DD50000A8103EFFB6C5FF
        FFFFFFC7D2FF032CFF0020FF0829FE1630EB0119E20517D90A11D00C1CCBD9DC
        F5FDFDFE313CC80000A8FF00FF8DA4FFFFFFFFFFFFFF8AA0FF0027FF012CFF04
        24FF1C3EFB001DE9061CDFA1ACF1FFFFFFB4BAED0007BBFF00FFFF00FF718DFF
        DAE1FFFFFFFFFFFFFFB1C0FF3B5DFF1538FF1739FE4966F8C0CAFAFFFFFFEDEF
        FC3041D30007BBFF00FFFF00FFFF00FF88A0FFE6EBFFFFFFFFFFFFFFFDFDFFE2
        E9FFE4EBFFFFFFFFFFFFFFDBE0FA3D50E0000BCCFF00FFFF00FFFF00FFFF00FF
        FF00FF8AA1FFBAC7FEE8ECFFFFFFFFFFFFFFFFFFFFE4E9FE889BF61738E6000B
        CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8AA0FF8AA3FF90
        A6FF7993FE4A6BF91A40EFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
    end
    object SpeedButton4: TSpeedButton
      Left = 69
      Top = 0
      Width = 23
      Height = 22
      Cursor = crHandPoint
      Hint = 'Show serie annotations'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF003B00003B00003700002D00002800002800FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF006804006804347E386E9C6F82
        AA857BA17B4F7C500F4510002800002800FF00FFFF00FFFF00FFFF00FFFF00FF
        007A072C8E32B7D7BAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2EBE2668E680031
        00012C03FF00FFFF00FFFF00FF0086083C9F43E9F4EAFFFFFFEBF3ECA3C3A47E
        A67F8BAC8BCCDACCFFFFFFFFFFFF84A584003200002E00FF00FFFF00FF1A9A25
        E1F2E2FFFFFF9AC69D136B17065308064A07024403064607568456F3F7F3FFFF
        FF668E67002E00FF00FF009B0B8BD090FFFFFFB0D8B210781511671491B69316
        5E17084F09054806023F03578658FFFFFFE4ECE40F4B1000400011A41ED5EFD6
        FFFFFF36A13E1A801E17771BFFFFFFBCD4BD216A230A540C084D08024803CDDC
        CEFFFFFF5085520040002BAD36F2FAF3DFF3E1209A281F8E251D8622F2F8F3FF
        FFFFD1E3D24183430C5B0E0851098CAE8EFFFFFF7DAB7F0050004AB952FFFFFF
        CDECD026A22D249C2C219428F2F8F2FFFFFFFFFFFFC4DCC51269150F61117CA7
        7EFFFFFF87B68A005C0057BF60FFFFFEEEF9EF2AAB3228A73026A02EF3F9F3FF
        FFFFC6E1C73B934017791C106D13A3C6A5FFFFFF72AD7500600047B950F0F9F1
        FFFFFF55BE5C2BAD3329AA31FCFEFDB2DDB52C9C322090261D88231B8020EBF3
        EBFFFFFF39923E006000FF00FFC6E9C9FFFFFFD8F0D932B03B2BAD3390D4952D
        AA3328A32F259E2C19911F9DCDA0FFFFFFBDDEC0037909FF00FFFF00FF6BC671
        FAFDFAFFFFFFD9F0DA54BE5C2BAD332AAD3225AA2E3BB043B0DDB4FFFFFFEBF6
        EB2E9C36037909FF00FFFF00FFFF00FF9BD8A0FDFEFDFFFFFFFFFFFFECF8EDCB
        EBCEDAF1DDFFFFFFFFFFFFDFF1E03EAD47008907FF00FFFF00FFFF00FFFF00FF
        FF00FF89D28FDFF3E1FFFFFFFFFFFFFFFFFFFFFFFFF6FBF6ABDFB027AC320089
        07FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF76CB7C82D088A3DBA8AB
        DFAE90D49559BF6218A824FF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton4Click
    end
  end
  object Panel3: TPanel
    Left = 137
    Top = 0
    Width = 619
    Height = 506
    Align = alCustom
    Caption = 'Choose Serie'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 136
    Top = 0
    Width = 620
    Height = 507
    ActivePage = TabSheet6
    Align = alCustom
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Visible = False
    object TabSheet1: TTabSheet
      Caption = 'Global'
      object GroupBox23: TGroupBox
        Left = 3
        Top = 0
        Width = 606
        Height = 230
        Caption = 'Appearance'
        TabOrder = 0
        object Label22: TLabel
          Left = 343
          Top = 136
          Width = 49
          Height = 13
          Caption = 'Line color:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label6: TLabel
          Left = 343
          Top = 104
          Width = 57
          Height = 13
          Caption = 'Brush style:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label23: TLabel
          Left = 343
          Top = 164
          Width = 52
          Height = 13
          Caption = 'Line width:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label5: TLabel
          Left = 18
          Top = 184
          Width = 62
          Height = 13
          Caption = 'Border color:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label3: TLabel
          Left = 18
          Top = 211
          Width = 65
          Height = 13
          Caption = 'Border width:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label28: TLabel
          Left = 343
          Top = 193
          Width = 48
          Height = 13
          Caption = 'Pen style:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label8: TLabel
          Left = 343
          Top = 75
          Width = 81
          Height = 13
          Caption = 'Border rounding:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label13: TLabel
          Left = 19
          Top = 19
          Width = 38
          Height = 13
          Caption = 'Color 1:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label14: TLabel
          Left = 19
          Top = 45
          Width = 38
          Height = 13
          Caption = 'Color 2:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label16: TLabel
          Left = 19
          Top = 75
          Width = 83
          Height = 13
          Caption = 'Gradient fill type:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label17: TLabel
          Left = 19
          Top = 102
          Width = 58
          Height = 13
          Caption = 'Hatch style:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label131: TLabel
          Left = 19
          Top = 134
          Width = 31
          Height = 13
          Caption = 'Angle:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label133: TLabel
          Left = 343
          Top = 15
          Width = 50
          Height = 13
          Caption = 'Opacity 1:'
        end
        object Label134: TLabel
          Left = 343
          Top = 46
          Width = 50
          Height = 13
          Caption = 'Opacity 2:'
        end
        object AdvColorSelector6: TAdvChartColorSelector
          Left = 459
          Top = 133
          Width = 128
          Height = 22
          TabOrder = 12
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvColorSelector6Select
        end
        object AdvBrushStyleSelector1: TAdvChartBrushStyleSelector
          Left = 459
          Top = 100
          Width = 128
          Height = 22
          TabOrder = 11
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          BrushColor = clBlack
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          SelectedIndex = -1
          Style = ssCombo
          Tools = <
            item
              CaptionAlignment = taCenter
              ImageIndex = 0
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 1
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 2
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 3
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 4
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 5
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 6
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 7
            end
            item
              Caption = ' More Styles'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Styles'
              ItemType = itFullWidthButton
            end>
          OnClick = AdvBrushStyleSelector1Click
        end
        object SpinEdit3: TAdvChartSpinEdit
          Left = 459
          Top = 161
          Width = 38
          Height = 22
          Value = 0
          DateValue = 42150.471736898150000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 13
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit3Change
        end
        object AdvColorSelector1: TAdvChartColorSelector
          Left = 166
          Top = 179
          Width = 128
          Height = 22
          TabOrder = 6
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvColorSelector1Select
        end
        object SpinEdit1: TAdvChartSpinEdit
          Left = 166
          Top = 205
          Width = 38
          Height = 22
          Value = 0
          DateValue = 42150.471736909720000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 7
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit1Change
        end
        object AdvPenStyleSelector1: TAdvChartPenStyleSelector
          Left = 459
          Top = 189
          Width = 128
          Height = 22
          TabOrder = 14
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          PenColor = clBlack
          SelectedIndex = -1
          Style = ssCombo
          Tools = <
            item
              CaptionAlignment = taCenter
              ImageIndex = 0
              Hint = 'Solid'
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 1
              Hint = 'Round Dot'
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 2
              Hint = 'Square Dots'
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 3
              Hint = 'Dash'
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 4
              Hint = 'Dash Dots'
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 5
              Hint = 'Long Dash'
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 6
              Hint = 'Long Dash Dot'
            end
            item
              CaptionAlignment = taCenter
              ImageIndex = 7
              Hint = 'Long Dash Dot Dot'
            end
            item
              Caption = 'More Styles'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Styles'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvPenStyleSelector1Select
        end
        object SpinEdit7: TAdvChartSpinEdit
          Left = 459
          Top = 72
          Width = 38
          Height = 22
          Value = 0
          DateValue = 42150.471736921290000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 10
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit7Change
        end
        object AdvChartColorSelector3: TAdvChartColorSelector
          Left = 166
          Top = 12
          Width = 128
          Height = 22
          TabOrder = 0
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvChartColorSelector3Select
        end
        object AdvChartColorSelector4: TAdvChartColorSelector
          Left = 166
          Top = 40
          Width = 128
          Height = 22
          TabOrder = 1
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvChartColorSelector4Select
        end
        object ComboBox3: TComboBox
          Left = 166
          Top = 72
          Width = 137
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = ComboBox3Change
          Items.Strings = (
            'Solid'
            'Radial'
            'Vertical'
            'Horizontal'
            'ForwardDiagonal'
            'BackwardDiagonal'
            'Angle'
            'Hatch'
            'Path'
            'Texture'
            'None')
        end
        object ComboBox25: TComboBox
          Left = 166
          Top = 99
          Width = 137
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnChange = ComboBox25Change
          Items.Strings = (
            'Horizontal'
            'Vertical'
            'ForwardDiagonal'
            'BackwardDiagonal'
            'Cross'
            'DiagonalCross'
            '5 Percent'
            '10 Percent'
            '20 Percent'
            '25 Percent'
            '30 Percent'
            '40 Percent'
            '50 Percent'
            '60 Percent'
            '70 Percent'
            '75 Percent'
            '80 Percent'
            '90 Percent'
            'Light Downward Diagonal'
            'Light Upward Diagonal'
            'Dark Downward Diagonal'
            'Dark Upward Diagonal'
            'Wide Downward Diagonal'
            'Wide Upward Diagonal'
            'Light Vertical'
            'Light Horizontal'
            'Narrow Vertical'
            'Narrow Horizontal'
            'Dark Vertical'
            'Dark Horizontal'
            'Dashed Downward Diagonal'
            'Dashed Upward Diagonal'
            'Dashed Horizontal'
            'Dashed Vertical'
            'Small Confetti'
            'Large Confetti'
            'Zig Zag'
            'Wave'
            'Diagonal Brick'
            'Horizontal Brick'
            'Weave'
            'Plaid'
            'Divot'
            'Dotted Grid'
            'Dotted Diamond'
            'Shingle'
            'Trellis'
            'Sphere'
            'Small Grid'
            'Small CheckerBoard'
            'Large CheckerBoard'
            'Outlined Diamond'
            'Solid Diamond'
            'Total                      ')
        end
        object AdvChartSpinEdit2: TAdvChartSpinEdit
          Left = 166
          Top = 131
          Width = 66
          Height = 22
          Value = 0
          DateValue = 42150.471736979170000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 4
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit2Change
        end
        object CheckBox29: TCheckBox
          Left = 19
          Top = 159
          Width = 158
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Shadow:'
          TabOrder = 5
          OnClick = CheckBox29Click
        end
        object AdvChartSpinEdit3: TAdvChartSpinEdit
          Left = 459
          Top = 40
          Width = 44
          Height = 22
          Value = 0
          DateValue = 42150.471736979170000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 9
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit3Change
        end
        object AdvChartSpinEdit4: TAdvChartSpinEdit
          Left = 459
          Top = 12
          Width = 44
          Height = 22
          Value = 0
          DateValue = 42150.471736990740000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 8
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit4Change
        end
      end
      object GroupBox24: TGroupBox
        Left = 5
        Top = 232
        Width = 276
        Height = 200
        Caption = 'Chart Pattern'
        TabOrder = 1
        object Label4: TLabel
          Left = 18
          Top = 20
          Width = 37
          Height = 13
          Caption = 'Picture:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label2: TLabel
          Left = 18
          Top = 167
          Width = 41
          Height = 13
          Caption = 'Position:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Panel2: TPanel
          Left = 124
          Top = 19
          Width = 137
          Height = 137
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Caption = '...'
          TabOrder = 1
          object Image1: TImage
            Left = 0
            Top = 0
            Width = 133
            Height = 133
            Cursor = crHandPoint
            Hint = 'Click to insert image'
            Align = alClient
            ParentShowHint = False
            ShowHint = True
            Stretch = True
            OnClick = Image1Click
          end
        end
        object ComboBox2: TComboBox
          Left = 124
          Top = 162
          Width = 133
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 2
          Text = 'TopLeft'
          OnChange = ComboBox2Change
          Items.Strings = (
            'TopLeft'
            'TopRight'
            'BottomLeft'
            'BottomRight'
            'Tiled'
            'Stretched'
            'Center')
        end
        object Button13: TButton
          Left = 104
          Top = 19
          Width = 19
          Height = 17
          Cursor = crHandPoint
          Hint = 'Remove picture'
          Caption = 'x'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = Button13Click
        end
      end
      object GroupBox25: TGroupBox
        Left = 287
        Top = 232
        Width = 321
        Height = 101
        Caption = 'Candlestick'
        TabOrder = 2
        object Label27: TLabel
          Left = 15
          Top = 68
          Width = 52
          Height = 13
          Caption = 'Wick color:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label26: TLabel
          Left = 15
          Top = 26
          Width = 55
          Height = 13
          Caption = 'Wick width:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object SpinEdit4: TAdvChartSpinEdit
          Left = 128
          Top = 21
          Width = 38
          Height = 22
          Value = 0
          DateValue = 42150.471737013890000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 0
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit4Change
        end
        object AdvColorSelector7: TAdvChartColorSelector
          Left = 128
          Top = 64
          Width = 128
          Height = 22
          TabOrder = 1
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvColorSelector7Select
        end
      end
      object GroupBox27: TGroupBox
        Left = 3
        Top = 434
        Width = 606
        Height = 42
        Caption = 'Arrow'
        TabOrder = 3
        object Label75: TLabel
          Left = 18
          Top = 16
          Width = 29
          Height = 13
          Caption = 'Color:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label79: TLabel
          Left = 300
          Top = 16
          Width = 23
          Height = 13
          Caption = 'Size:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object AdvChartColorSelector7: TAdvChartColorSelector
          Left = 126
          Top = 13
          Width = 128
          Height = 22
          TabOrder = 0
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvChartColorSelector7Select
        end
        object AdvChartSpinEdit6: TAdvChartSpinEdit
          Left = 412
          Top = 13
          Width = 38
          Height = 22
          Value = 0
          DateValue = 42150.471737037040000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 1
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit6Change
        end
      end
      object GroupBox42: TGroupBox
        Left = 287
        Top = 339
        Width = 322
        Height = 89
        Caption = 'Increase / Decrease colors'
        TabOrder = 4
        object Label19: TLabel
          Left = 15
          Top = 28
          Width = 76
          Height = 13
          Caption = 'Color decrease:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label18: TLabel
          Left = 15
          Top = 60
          Width = 72
          Height = 13
          Caption = 'Color increase:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object AdvColorSelector4: TAdvChartColorSelector
          Left = 128
          Top = 56
          Width = 128
          Height = 22
          TabOrder = 0
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvColorSelector4Select
        end
        object AdvColorSelector5: TAdvChartColorSelector
          Left = 128
          Top = 24
          Width = 128
          Height = 22
          TabOrder = 1
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvColorSelector5Select
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Chart type'
      ImageIndex = 1
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 612
        Height = 479
        ActivePage = TabSheet9
        Align = alClient
        TabOrder = 0
        object TabSheet9: TTabSheet
          Caption = 'Line types'
          object GroupBox11: TGroupBox
            Left = 3
            Top = 0
            Width = 590
            Height = 113
            Caption = 'Line'
            TabOrder = 0
            object ChartTypeSelector1: TAdvChartTypeSelector
              Left = 7
              Top = 25
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Line'
              ChartType = ctLine
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object ChartTypeSelector3: TAdvChartTypeSelector
              Left = 158
              Top = 25
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Line Candlestick'
              ChartType = ctLineCandleStick
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object ChartTypeSelector4: TAdvChartTypeSelector
              Left = 233
              Top = 25
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Line Histogram'
              ChartType = ctLineHistogram
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object ChartTypeSelector2: TAdvChartTypeSelector
              Left = 83
              Top = 25
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Line Bar'
              ChartType = ctLineBar
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector20: TAdvChartTypeSelector
              Left = 309
              Top = 25
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Digital Line'
              ChartType = ctDigitalLine
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector23: TAdvChartTypeSelector
              Left = 385
              Top = 25
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'XY Line'
              ChartType = ctXYLine
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector26: TAdvChartTypeSelector
              Left = 461
              Top = 25
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'XY Digital Line'
              ChartType = ctXYDigitalLine
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
        end
        object TabSheet10: TTabSheet
          Caption = 'Bar types'
          ImageIndex = 1
          object Label157: TLabel
            Left = 3
            Top = 239
            Width = 53
            Height = 13
            Caption = 'Bar Shape:'
          end
          object GroupBox12: TGroupBox
            Left = -1
            Top = 3
            Width = 322
            Height = 113
            Caption = 'Bar'
            TabOrder = 0
            object ChartTypeSelector5: TAdvChartTypeSelector
              Left = 7
              Top = 25
              Width = 70
              Height = 71
              Cursor = crHandPoint
              Hint = 'Bar'
              ChartType = ctBar
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object ChartTypeSelector6: TAdvChartTypeSelector
              Left = 83
              Top = 25
              Width = 70
              Height = 71
              Cursor = crHandPoint
              Hint = 'Stacked Bar'
              ChartType = ctStackedBar
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object ChartTypeSelector7: TAdvChartTypeSelector
              Left = 159
              Top = 25
              Width = 70
              Height = 71
              Cursor = crHandPoint
              Hint = 'Stacked Percentage Bar'
              ChartType = ctStackedPercBar
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector9: TAdvChartTypeSelector
              Left = 235
              Top = 25
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Line Bar'
              ChartType = ctLineBar
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
          object GroupBox14: TGroupBox
            Left = 3
            Top = 122
            Width = 174
            Height = 108
            Caption = 'Histogram'
            TabOrder = 1
            object ChartTypeSelector11: TAdvChartTypeSelector
              Left = 13
              Top = 19
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Histogram'
              ChartType = ctHistogram
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector8: TAdvChartTypeSelector
              Left = 89
              Top = 19
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Line Histogram'
              ChartType = ctLineHistogram
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
          object ComboBox26: TComboBox
            Left = 67
            Top = 236
            Width = 110
            Height = 21
            Style = csDropDownList
            TabOrder = 2
            OnChange = ComboBox26Change
            Items.Strings = (
              'Rectangle'
              'Cylinder'
              'Pyramid')
          end
        end
        object TabSheet11: TTabSheet
          Caption = 'Pie types'
          ImageIndex = 2
          object GroupBox31: TGroupBox
            Left = 3
            Top = 3
            Width = 318
            Height = 97
            Caption = 'Pie / Donut'
            TabOrder = 0
            object AdvChartTypeSelector1: TAdvChartTypeSelector
              Left = 7
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Pie'
              ChartType = ctPie
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector2: TAdvChartTypeSelector
              Left = 83
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Donut'
              ChartType = ctDonut
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector4: TAdvChartTypeSelector
              Left = 236
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Half Donut'
              ChartType = ctHalfDonut
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector5: TAdvChartTypeSelector
              Left = 160
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Half Pie'
              ChartType = ctHalfPie
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
          object GroupBox36: TGroupBox
            Left = 3
            Top = 106
            Width = 318
            Height = 97
            Caption = 'Sized Pie / Donut'
            TabOrder = 1
            object AdvChartTypeSelector10: TAdvChartTypeSelector
              Left = 7
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Sized Pie'
              ChartType = ctSizedPie
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector11: TAdvChartTypeSelector
              Left = 83
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Sized Half Pie'
              ChartType = ctSizedHalfPie
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector12: TAdvChartTypeSelector
              Left = 236
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Sized Half Donut'
              ChartType = ctSizedHalfDonut
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector13: TAdvChartTypeSelector
              Left = 160
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Sized Donut'
              ChartType = ctSizedDonut
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
          object GroupBox37: TGroupBox
            Left = 3
            Top = 209
            Width = 318
            Height = 97
            Caption = 'Variable Radius Pie / Donut'
            TabOrder = 2
            object AdvChartTypeSelector14: TAdvChartTypeSelector
              Left = 7
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Variable Radius Pie'
              ChartType = ctVarRadiusPie
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector15: TAdvChartTypeSelector
              Left = 84
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Variable Radius Half Pie'
              ChartType = ctVarRadiusHalfPie
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector16: TAdvChartTypeSelector
              Left = 236
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Variable Radius Half Donut'
              ChartType = ctVarRadiusHalfDonut
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector17: TAdvChartTypeSelector
              Left = 160
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Variable Radius Donut'
              ChartType = ctVarRadiusDonut
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
          object GroupBox38: TGroupBox
            Left = 3
            Top = 312
            Width = 318
            Height = 97
            Caption = 'Spider'
            TabOrder = 3
            object AdvChartTypeSelector18: TAdvChartTypeSelector
              Left = 7
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Spider'
              ChartType = ctSpider
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector19: TAdvChartTypeSelector
              Left = 83
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Half Spider'
              ChartType = ctHalfSpider
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
        end
        object TabSheet12: TTabSheet
          Caption = 'Area types'
          ImageIndex = 3
          object GroupBox13: TGroupBox
            Left = 3
            Top = 3
            Width = 246
            Height = 108
            Caption = 'Area'
            TabOrder = 0
            object ChartTypeSelector8: TAdvChartTypeSelector
              Left = 7
              Top = 19
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Area'
              ChartType = ctArea
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object ChartTypeSelector9: TAdvChartTypeSelector
              Left = 83
              Top = 19
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Stacked Area'
              ChartType = ctStackedArea
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object ChartTypeSelector10: TAdvChartTypeSelector
              Left = 158
              Top = 19
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Stacked Percentage Area'
              ChartType = ctStackedPercArea
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
          object GroupBox33: TGroupBox
            Left = 3
            Top = 117
            Width = 82
            Height = 97
            Caption = 'Band'
            TabOrder = 1
            object AdvChartTypeSelector3: TAdvChartTypeSelector
              Left = 7
              Top = 18
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Band'
              ChartType = ctBand
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
        end
        object TabSheet13: TTabSheet
          Caption = 'Multi types'
          ImageIndex = 4
          object GroupBox16: TGroupBox
            Left = 3
            Top = 3
            Width = 390
            Height = 105
            Caption = 'Candlestick / OHLC / Error'
            TabOrder = 0
            object ChartTypeSelector14: TAdvChartTypeSelector
              Left = 83
              Top = 22
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'OHLC'
              ChartType = ctOHLC
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object ChartTypeSelector13: TAdvChartTypeSelector
              Left = 7
              Top = 22
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Candlestick'
              ChartType = ctCandleStick
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object ChartTypeSelector19: TAdvChartTypeSelector
              Left = 235
              Top = 22
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Error'
              ChartType = ctError
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector7: TAdvChartTypeSelector
              Left = 159
              Top = 22
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Line Candlestick'
              ChartType = ctLineCandleStick
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector6: TAdvChartTypeSelector
              Left = 311
              Top = 22
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Boxplot'
              ChartType = ctBoxPlot
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
        end
        object TabSheet14: TTabSheet
          Caption = 'Misc types'
          ImageIndex = 5
          object GroupBox18: TGroupBox
            Left = 5
            Top = 212
            Width = 90
            Height = 101
            Caption = 'None'
            TabOrder = 0
            object ChartTypeSelector20: TAdvChartTypeSelector
              Left = 10
              Top = 19
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'None'
              ChartType = ctNone
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
          object GroupBox15: TGroupBox
            Left = 5
            Top = 2
            Width = 244
            Height = 105
            Caption = 'Marker'
            TabOrder = 1
            object ChartTypeSelector12: TAdvChartTypeSelector
              Left = 10
              Top = 22
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Markers'
              ChartType = ctMarkers
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector21: TAdvChartTypeSelector
              Left = 86
              Top = 22
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Renko'
              ChartType = ctRenko
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object AdvChartTypeSelector22: TAdvChartTypeSelector
              Left = 162
              Top = 22
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'XY Markers'
              ChartType = ctXYMarkers
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
          object GroupBox17: TGroupBox
            Left = 255
            Top = 3
            Width = 346
            Height = 105
            Caption = 'Arrow / Bubble (+Scaled)'
            Ctl3D = True
            ParentCtl3D = False
            TabOrder = 2
            object ChartTypeSelector17: TAdvChartTypeSelector
              Left = 13
              Top = 22
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Bubble'
              ChartType = ctBubble
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object ChartTypeSelector18: TAdvChartTypeSelector
              Left = 89
              Top = 22
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Arrow'
              ChartType = ctArrow
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object ChartTypeSelector16: TAdvChartTypeSelector
              Left = 165
              Top = 22
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Scaled Bubble'
              ChartType = ctScaledBubble
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
            object ChartTypeSelector15: TAdvChartTypeSelector
              Left = 241
              Top = 22
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Scaled Arrow'
              ChartType = ctScaledArrow
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
          object GroupBox45: TGroupBox
            Left = 5
            Top = 108
            Width = 90
            Height = 98
            Caption = 'Gantt'
            TabOrder = 3
            object AdvChartTypeSelector24: TAdvChartTypeSelector
              Left = 10
              Top = 19
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Gantt'
              ChartType = ctGantt
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
          object GroupBox49: TGroupBox
            Left = 101
            Top = 108
            Width = 90
            Height = 98
            Caption = 'Funnel'
            TabOrder = 4
            object AdvChartTypeSelector25: TAdvChartTypeSelector
              Left = 10
              Top = 19
              Width = 70
              Height = 70
              Cursor = crHandPoint
              Hint = 'Funnel'
              ChartType = ctFunnel
              ColorDown = 4008604
              ColorHot = 11762521
              Color = 11762521
              ColorToDown = 6244301
              ColorToHot = 14335661
              ColorTo = 8870461
              GradientDirection = cgdVertical
              GradientSteps = 32
              OnMouseDown = ChartTypeSelector1MouseDown
              ShowHint = True
            end
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Crosshair'
      ImageIndex = 2
      object GroupBox20: TGroupBox
        Left = 2
        Top = 0
        Width = 605
        Height = 226
        Caption = 'Appearance'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label34: TLabel
          Left = 20
          Top = 198
          Width = 74
          Height = 13
          Caption = 'Gradient steps:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label33: TLabel
          Left = 20
          Top = 171
          Width = 89
          Height = 13
          Caption = 'Gradient direction:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label30: TLabel
          Left = 20
          Top = 142
          Width = 26
          Height = 13
          Caption = 'Font:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label24: TLabel
          Left = 20
          Top = 18
          Width = 62
          Height = 13
          Caption = 'Border color:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label25: TLabel
          Left = 20
          Top = 65
          Width = 29
          Height = 13
          Caption = 'Color:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label29: TLabel
          Left = 20
          Top = 92
          Width = 92
          Height = 13
          Caption = 'Gradient end color:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label7: TLabel
          Left = 20
          Top = 41
          Width = 65
          Height = 13
          Caption = 'Border width:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label135: TLabel
          Tag = 141
          Left = 213
          Top = 141
          Width = 38
          Height = 13
          Caption = 'Preview'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object ComboBox4: TComboBox
          Left = 175
          Top = 168
          Width = 145
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 6
          Text = 'Horizontal'
          OnChange = ComboBox4Change
          Items.Strings = (
            'Horizontal'
            'Vertical')
        end
        object SpinEdit5: TAdvChartSpinEdit
          Left = 175
          Top = 195
          Width = 38
          Height = 22
          Value = 0
          DateValue = 42150.471737152780000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 7
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit5Change
        end
        object CheckBox1: TCheckBox
          Left = 20
          Top = 115
          Width = 171
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Visible:'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 4
          OnClick = CheckBox1Click
        end
        object AdvColorSelector10: TAdvChartColorSelector
          Left = 175
          Top = 88
          Width = 128
          Height = 22
          TabOrder = 3
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvColorSelector10Select
        end
        object AdvColorSelector9: TAdvChartColorSelector
          Left = 175
          Top = 62
          Width = 128
          Height = 22
          TabOrder = 2
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvColorSelector9Select
        end
        object AdvColorSelector8: TAdvChartColorSelector
          Left = 175
          Top = 14
          Width = 128
          Height = 22
          TabOrder = 0
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvColorSelector8Select
        end
        object Button8: TButton
          Left = 175
          Top = 140
          Width = 32
          Height = 17
          Caption = '...'
          TabOrder = 5
          OnClick = Button8Click
        end
        object SpinEdit6: TAdvChartSpinEdit
          Left = 175
          Top = 38
          Width = 38
          Height = 22
          Value = 0
          DateValue = 42150.471737187500000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 1
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit6Change
        end
      end
      object AdvChartView1: TAdvChartView
        Left = 2
        Top = 232
        Width = 605
        Height = 243
        ShowDesignHelper = True
        Align = alCustom
        Panes = <
          item
            AxisMode = amXAxisFullWidth
            Bands.Distance = 2.000000000000000000
            BackGround.Color = clWhite
            BackGround.Font.Charset = DEFAULT_CHARSET
            BackGround.Font.Color = clWindowText
            BackGround.Font.Height = -11
            BackGround.Font.Name = 'Tahoma'
            BackGround.Font.Style = []
            BorderColor = clBlack
            CrossHair.CrossHairType = chtFullSizeCrossHairAtCursor
            CrossHair.CrossHairYValues.ShowYPosValue = True
            CrossHair.CrossHairYValues.Position = [chYAxis, chAtCursor]
            CrossHair.Distance = 0
            CrossHair.LineWidth = 2
            CrossHair.LineColor = clNavy
            CrossHair.Visible = True
            Height = 100.000000000000000000
            HeightType = htAuto
            Legend.Font.Charset = DEFAULT_CHARSET
            Legend.Font.Color = clWindowText
            Legend.Font.Height = -11
            Legend.Font.Name = 'Tahoma'
            Legend.Font.Style = []
            Legend.Visible = False
            Navigator.ScrollButtonLeftColor = clBlack
            Navigator.ScrollButtonLeftHotColor = clBlack
            Navigator.ScrollButtonLeftDownColor = clBlack
            Navigator.ScrollButtonRightColor = clBlack
            Navigator.ScrollButtonRightHotColor = clBlack
            Navigator.ScrollButtonRightDownColor = clBlack
            Navigator.ScrollButtonsSize = 20
            Name = 'ChartPane 0'
            Options = []
            Range.RangeTo = 9
            Series = <>
            Splitter.LineColor = clBlack
            Title.Alignment = taCenter
            Title.BorderColor = clBlack
            Title.BorderWidth = 1
            Title.Color = 15759360
            Title.ColorTo = 11887127
            Title.GradientDirection = cgdVertical
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -16
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Title.Position = tTop
            Title.Size = 25
            Title.Text = 'PREVIEW'
            XAxis.Font.Charset = DEFAULT_CHARSET
            XAxis.Font.Color = clWindowText
            XAxis.Font.Height = -11
            XAxis.Font.Name = 'Tahoma'
            XAxis.Font.Style = []
            XAxis.Size = 0
            XAxis.Text = 'X-axis'
            XGrid.MajorFont.Charset = DEFAULT_CHARSET
            XGrid.MajorFont.Color = clWindowText
            XGrid.MajorFont.Height = -11
            XGrid.MajorFont.Name = 'Tahoma'
            XGrid.MajorFont.Style = []
            XGrid.MinorFont.Charset = DEFAULT_CHARSET
            XGrid.MinorFont.Color = clWindowText
            XGrid.MinorFont.Height = -11
            XGrid.MinorFont.Name = 'Tahoma'
            XGrid.MinorFont.Style = []
            YAxis.Color = clWhite
            YAxis.Font.Charset = DEFAULT_CHARSET
            YAxis.Font.Color = clWindowText
            YAxis.Font.Height = -11
            YAxis.Font.Name = 'Tahoma'
            YAxis.Font.Style = []
            YAxis.Position = yRight
            YAxis.Size = 40
            YGrid.AutoUnits = False
            YGrid.BorderColor = clBlack
            YGrid.MinorDistance = 1.000000000000000000
            YGrid.MajorDistance = 2.000000000000000000
            YGrid.MinorLineColor = clWhite
            YGrid.MajorLineColor = clWhite
          end>
        TabOrder = 1
        Tracker.AutoSize = False
        Tracker.Font.Charset = DEFAULT_CHARSET
        Tracker.Font.Color = clWindowText
        Tracker.Font.Height = -11
        Tracker.Font.Name = 'Tahoma'
        Tracker.Font.Style = []
        Tracker.Title.Font.Charset = DEFAULT_CHARSET
        Tracker.Title.Font.Color = clWindowText
        Tracker.Title.Font.Height = -11
        Tracker.Title.Font.Name = 'Tahoma'
        Tracker.Title.Font.Style = []
        Tracker.Title.Text = 'TRACKER'
        Version = '3.3.1.1 DEC, 2015'
        XAxisZoomSensitivity = 25.000000000000000000
        YAxisZoomSensitivity = 25.000000000000000000
        ZoomColor = clBlack
        DoubleBuffered = True
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Marker'
      ImageIndex = 6
      object GroupBox10: TGroupBox
        Left = 3
        Top = 0
        Width = 606
        Height = 281
        Caption = 'Appearance'
        TabOrder = 0
        object Label44: TLabel
          Left = 19
          Top = 100
          Width = 28
          Height = 13
          Caption = 'Type:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label49: TLabel
          Left = 343
          Top = 132
          Width = 37
          Height = 13
          Caption = 'Picture:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label46: TLabel
          Left = 19
          Top = 174
          Width = 49
          Height = 13
          Caption = 'Line color:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label48: TLabel
          Left = 19
          Top = 203
          Width = 52
          Height = 13
          Caption = 'Line width:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label45: TLabel
          Left = 19
          Top = 149
          Width = 23
          Height = 13
          Caption = 'Size:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label9: TLabel
          Left = 19
          Top = 256
          Width = 95
          Height = 13
          Caption = 'Selected Line Color:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label10: TLabel
          Left = 19
          Top = 230
          Width = 73
          Height = 13
          Caption = 'Selected Color:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label11: TLabel
          Left = 343
          Top = 78
          Width = 96
          Height = 13
          Caption = 'Selected Line width:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label12: TLabel
          Left = 343
          Top = 103
          Width = 67
          Height = 13
          Caption = 'Selected Size:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label20: TLabel
          Left = 19
          Top = 45
          Width = 38
          Height = 13
          Caption = 'Color 2:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label21: TLabel
          Left = 19
          Top = 19
          Width = 38
          Height = 13
          Caption = 'Color 1:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label31: TLabel
          Left = 343
          Top = 15
          Width = 50
          Height = 13
          Caption = 'Opacity 1:'
        end
        object Label35: TLabel
          Left = 343
          Top = 46
          Width = 50
          Height = 13
          Caption = 'Opacity 2:'
        end
        object Label47: TLabel
          Left = 19
          Top = 73
          Width = 83
          Height = 13
          Caption = 'Gradient fill type:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object ComboBox7: TComboBox
          Left = 163
          Top = 97
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 3
          Text = 'None'
          OnChange = ComboBox7Change
          Items.Strings = (
            'None'
            'Circle'
            'Square'
            'Diamond'
            'Triangle'
            'Picture'
            'Custom')
        end
        object Panel1: TPanel
          Left = 432
          Top = 132
          Width = 137
          Height = 137
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Caption = '...'
          TabOrder = 14
          object Image2: TImage
            Left = 0
            Top = 0
            Width = 133
            Height = 133
            Align = alClient
            Stretch = True
            OnClick = Image2Click
          end
        end
        object AdvColorSelector12: TAdvChartColorSelector
          Left = 163
          Top = 172
          Width = 128
          Height = 22
          TabOrder = 5
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvColorSelector12Select
        end
        object SpinEdit11: TAdvChartSpinEdit
          Left = 163
          Top = 146
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737233800000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 4
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit11Change
        end
        object SpinEdit12: TAdvChartSpinEdit
          Left = 163
          Top = 200
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737245370000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 6
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit12Change
        end
        object Button14: TButton
          Left = 407
          Top = 131
          Width = 19
          Height = 17
          Caption = 'x'
          TabOrder = 13
          OnClick = Button14Click
        end
        object AdvChartColorSelector1: TAdvChartColorSelector
          Left = 163
          Top = 224
          Width = 128
          Height = 22
          TabOrder = 7
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvChartColorSelector1Select
        end
        object AdvChartColorSelector2: TAdvChartColorSelector
          Left = 163
          Top = 252
          Width = 128
          Height = 22
          TabOrder = 8
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvChartColorSelector2Select
        end
        object SpinEdit8: TAdvChartSpinEdit
          Left = 487
          Top = 76
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737256940000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 11
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit8Change
        end
        object SpinEdit9: TAdvChartSpinEdit
          Left = 487
          Top = 100
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737268520000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 12
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit9Change
        end
        object AdvChartColorSelector5: TAdvChartColorSelector
          Left = 163
          Top = 14
          Width = 128
          Height = 22
          TabOrder = 0
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvChartColorSelector5Select
        end
        object AdvChartColorSelector6: TAdvChartColorSelector
          Left = 163
          Top = 42
          Width = 128
          Height = 22
          TabOrder = 1
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvChartColorSelector6Select
        end
        object AdvChartSpinEdit1: TAdvChartSpinEdit
          Left = 486
          Top = 42
          Width = 44
          Height = 22
          Value = 0
          DateValue = 42150.471737280100000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 10
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit1Change
        end
        object AdvChartSpinEdit5: TAdvChartSpinEdit
          Left = 486
          Top = 14
          Width = 44
          Height = 22
          Value = 0
          DateValue = 42150.471737280100000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 9
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit5Change
        end
        object ComboBox11: TComboBox
          Left = 163
          Top = 70
          Width = 145
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = ComboBox11Change
          Items.Strings = (
            'Solid'
            'Radial'
            'Vertical'
            'Horizontal'
            'ForwardDiagonal'
            'BackwardDiagonal'
            'Angle'
            'Hatch'
            'Path'
            'Texture'
            'None')
        end
        object CheckBox21: TCheckBox
          Left = 19
          Top = 122
          Width = 158
          Height = 17
          Alignment = taLeftJustify
          Caption = 'IncreaseDecreaseMode'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 15
          OnClick = CheckBox21Click
        end
      end
      object AdvGDIPChartView1: TAdvGDIPChartView
        Left = 3
        Top = 287
        Width = 606
        Height = 189
        ShowDesignHelper = True
        Panes = <
          item
            Bands.Distance = 2.000000000000000000
            Background.Color = clWhite
            Background.Font.Charset = DEFAULT_CHARSET
            Background.Font.Color = clWindowText
            Background.Font.Height = -11
            Background.Font.Name = 'Tahoma'
            Background.Font.Style = []
            Background.GradientType = gtSolid
            BorderColor = clBlack
            CrossHair.CrossHairType = chtNone
            CrossHair.CrossHairYValues.Position = [chYAxis]
            CrossHair.Distance = 0
            Height = 100.000000000000000000
            Legend.Font.Charset = DEFAULT_CHARSET
            Legend.Font.Color = clWindowText
            Legend.Font.Height = -11
            Legend.Font.Name = 'Tahoma'
            Legend.Font.Style = []
            Legend.Visible = False
            Name = 'ChartPane 0'
            Options = []
            Range.RangeTo = 9
            Series = <
              item
                Pie.ValueFont.Charset = DEFAULT_CHARSET
                Pie.ValueFont.Color = clWindowText
                Pie.ValueFont.Height = -11
                Pie.ValueFont.Name = 'Tahoma'
                Pie.ValueFont.Style = []
                Pie.LegendFont.Charset = DEFAULT_CHARSET
                Pie.LegendFont.Color = clWindowText
                Pie.LegendFont.Height = -11
                Pie.LegendFont.Name = 'Tahoma'
                Pie.LegendFont.Style = []
                Pie.LegendTitleColorTo = clBlack
                Annotations = <>
                CrossHairYValue.BorderWidth = 0
                CrossHairYValue.Font.Charset = DEFAULT_CHARSET
                CrossHairYValue.Font.Color = clWindowText
                CrossHairYValue.Font.Height = -11
                CrossHairYValue.Font.Name = 'Tahoma'
                CrossHairYValue.Font.Style = []
                CrossHairYValue.GradientSteps = 0
                LegendText = 'Serie 0'
                Marker.MarkerType = mSquare
                Marker.MarkerColorTo = clBlack
                Name = 'Serie 0'
                ValueFont.Charset = DEFAULT_CHARSET
                ValueFont.Color = clWindowText
                ValueFont.Height = -11
                ValueFont.Name = 'Tahoma'
                ValueFont.Style = []
                ValueFormat = '%g'
                XAxis.DateTimeFont.Charset = DEFAULT_CHARSET
                XAxis.DateTimeFont.Color = clWindowText
                XAxis.DateTimeFont.Height = -11
                XAxis.DateTimeFont.Name = 'Tahoma'
                XAxis.DateTimeFont.Style = []
                XAxis.MajorFont.Charset = DEFAULT_CHARSET
                XAxis.MajorFont.Color = clWindowText
                XAxis.MajorFont.Height = -11
                XAxis.MajorFont.Name = 'Tahoma'
                XAxis.MajorFont.Style = []
                XAxis.MajorUnit = 1.000000000000000000
                XAxis.MajorUnitSpacing = 0
                XAxis.MinorFont.Charset = DEFAULT_CHARSET
                XAxis.MinorFont.Color = clWindowText
                XAxis.MinorFont.Height = -11
                XAxis.MinorFont.Name = 'Tahoma'
                XAxis.MinorFont.Style = []
                XAxis.MinorUnit = 1.000000000000000000
                XAxis.MinorUnitSpacing = 0
                XAxis.TextTop.Font.Charset = DEFAULT_CHARSET
                XAxis.TextTop.Font.Color = clWindowText
                XAxis.TextTop.Font.Height = -11
                XAxis.TextTop.Font.Name = 'Tahoma'
                XAxis.TextTop.Font.Style = []
                XAxis.TextBottom.Font.Charset = DEFAULT_CHARSET
                XAxis.TextBottom.Font.Color = clWindowText
                XAxis.TextBottom.Font.Height = -11
                XAxis.TextBottom.Font.Name = 'Tahoma'
                XAxis.TextBottom.Font.Style = []
                YAxis.MajorFont.Charset = DEFAULT_CHARSET
                YAxis.MajorFont.Color = clWindowText
                YAxis.MajorFont.Height = -11
                YAxis.MajorFont.Name = 'Tahoma'
                YAxis.MajorFont.Style = []
                YAxis.MajorUnitSpacing = 0
                YAxis.MinorFont.Charset = DEFAULT_CHARSET
                YAxis.MinorFont.Color = clWindowText
                YAxis.MinorFont.Height = -11
                YAxis.MinorFont.Name = 'Tahoma'
                YAxis.MinorFont.Style = []
                YAxis.MinorUnitSpacing = 0
                YAxis.TextLeft.Font.Charset = DEFAULT_CHARSET
                YAxis.TextLeft.Font.Color = clWindowText
                YAxis.TextLeft.Font.Height = -11
                YAxis.TextLeft.Font.Name = 'Tahoma'
                YAxis.TextLeft.Font.Style = []
                YAxis.TextRight.Font.Charset = DEFAULT_CHARSET
                YAxis.TextRight.Font.Color = clWindowText
                YAxis.TextRight.Font.Height = -11
                YAxis.TextRight.Font.Name = 'Tahoma'
                YAxis.TextRight.Font.Style = []
                BarValueTextFont.Charset = DEFAULT_CHARSET
                BarValueTextFont.Color = clWindowText
                BarValueTextFont.Height = -11
                BarValueTextFont.Name = 'Tahoma'
                BarValueTextFont.Style = []
                XAxisGroups = <>
                SerieType = stNormal
              end>
            Title.Alignment = taCenter
            Title.BorderColor = clBlack
            Title.BorderWidth = 1
            Title.Color = 15759360
            Title.ColorTo = 11887127
            Title.GradientDirection = cgdVertical
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -16
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Title.Position = tTop
            Title.Size = 25
            Title.Text = 'PREVIEW'
            XAxis.Font.Charset = DEFAULT_CHARSET
            XAxis.Font.Color = clWindowText
            XAxis.Font.Height = -11
            XAxis.Font.Name = 'Tahoma'
            XAxis.Font.Style = []
            XAxis.Position = xNone
            XAxis.Size = 20
            XAxis.Text = 'X-axis'
            XGrid.MajorFont.Charset = DEFAULT_CHARSET
            XGrid.MajorFont.Color = clWindowText
            XGrid.MajorFont.Height = -11
            XGrid.MajorFont.Name = 'Tahoma'
            XGrid.MajorFont.Style = []
            XGrid.MinorFont.Charset = DEFAULT_CHARSET
            XGrid.MinorFont.Color = clWindowText
            XGrid.MinorFont.Height = -11
            XGrid.MinorFont.Name = 'Tahoma'
            XGrid.MinorFont.Style = []
            YAxis.Font.Charset = DEFAULT_CHARSET
            YAxis.Font.Color = clWindowText
            YAxis.Font.Height = -11
            YAxis.Font.Name = 'Tahoma'
            YAxis.Font.Style = []
            YAxis.Position = yNone
            YAxis.Size = 40
            YAxis.Text = 'Y-axis'
            YGrid.MinorDistance = 1.000000000000000000
            YGrid.MajorDistance = 2.000000000000000000
          end>
        TabOrder = 1
        Tracker.Font.Charset = DEFAULT_CHARSET
        Tracker.Font.Color = clWindowText
        Tracker.Font.Height = -11
        Tracker.Font.Name = 'Tahoma'
        Tracker.Font.Style = []
        Tracker.Title.Font.Charset = DEFAULT_CHARSET
        Tracker.Title.Font.Color = clWindowText
        Tracker.Title.Font.Height = -11
        Tracker.Title.Font.Name = 'Tahoma'
        Tracker.Title.Font.Style = []
        Tracker.Title.Text = 'TRACKER'
        Version = '3.3.1.1 DEC, 2015'
        XAxisZoomSensitivity = 25.000000000000000000
        YAxisZoomSensitivity = 25.000000000000000000
        DoubleBuffered = True
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Serie'
      ImageIndex = 3
      object GroupBox22: TGroupBox
        Left = 3
        Top = 2
        Width = 598
        Height = 106
        Caption = 'Y- Axis / Legend'
        TabOrder = 0
        object Label37: TLabel
          Left = 18
          Top = 80
          Width = 44
          Height = 13
          Caption = 'Minimum:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label32: TLabel
          Left = 18
          Top = 19
          Width = 62
          Height = 13
          Caption = 'Legend text:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label36: TLabel
          Left = 18
          Top = 49
          Width = 48
          Height = 13
          Caption = 'Maximum:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label151: TLabel
          Left = 387
          Top = 16
          Width = 76
          Height = 13
          Caption = 'Show in legend:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label156: TLabel
          Left = 387
          Top = 46
          Width = 58
          Height = 13
          Caption = 'Logarithmic:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Edit1: TEdit
          Left = 162
          Top = 13
          Width = 219
          Height = 21
          TabOrder = 0
          OnChange = Edit1Change
        end
        object AdvSpinEdit1: TAdvChartSpinEdit
          Left = 162
          Top = 43
          Width = 140
          Height = 22
          SpinType = sptFloat
          Value = 0
          DateValue = 42150.471737326390000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 1
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvSpinEdit1Change
        end
        object AdvSpinEdit2: TAdvChartSpinEdit
          Left = 162
          Top = 75
          Width = 140
          Height = 22
          SpinType = sptFloat
          Value = 0
          DateValue = 42150.471737337960000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 2
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvSpinEdit2Change
        end
        object CheckBox16: TCheckBox
          Left = 499
          Top = 15
          Width = 22
          Height = 17
          TabOrder = 3
          OnClick = CheckBox16Click
        end
        object CheckBox20: TCheckBox
          Left = 499
          Top = 45
          Width = 22
          Height = 17
          TabOrder = 4
          OnClick = CheckBox20Click
        end
      end
      object GroupBox19: TGroupBox
        Left = 3
        Top = 260
        Width = 598
        Height = 85
        Caption = 'Chart type appearance'
        TabOrder = 2
        object Label42: TLabel
          Left = 18
          Top = 60
          Width = 59
          Height = 13
          Caption = 'Value width:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label43: TLabel
          Left = 18
          Top = 32
          Width = 95
          Height = 18
          AutoSize = False
          Caption = 'Value width type:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label153: TLabel
          Left = 379
          Top = 22
          Width = 57
          Height = 13
          Caption = '3D Offset : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label154: TLabel
          Left = 379
          Top = 46
          Width = 55
          Height = 13
          Caption = 'Enable 3D :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label155: TLabel
          Left = 379
          Top = 67
          Width = 54
          Height = 13
          Caption = 'Darken 3D:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object SpinEdit10: TAdvChartSpinEdit
          Left = 162
          Top = 54
          Width = 54
          Height = 22
          Value = 0
          DateValue = 42150.471737349540000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 1
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit10Change
        end
        object ComboBox6: TComboBox
          Left = 162
          Top = 27
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = 'Pixels'
          OnChange = ComboBox6Change
          Items.Strings = (
            'Pixels'
            'Percentage')
        end
        object CheckBox18: TCheckBox
          Left = 464
          Top = 45
          Width = 33
          Height = 17
          TabOrder = 2
          OnClick = CheckBox18Click
        end
        object AdvChartSpinEdit24: TAdvChartSpinEdit
          Left = 464
          Top = 19
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737361110000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 3
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit24Change
        end
        object CheckBox19: TCheckBox
          Left = 464
          Top = 66
          Width = 33
          Height = 17
          TabOrder = 4
          OnClick = CheckBox19Click
        end
      end
      object GroupBox21: TGroupBox
        Left = 3
        Top = 114
        Width = 358
        Height = 140
        Caption = 'Y - Values'
        TabOrder = 1
        object Label39: TLabel
          Left = 18
          Top = 25
          Width = 107
          Height = 13
          Caption = 'Show value in tracker:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label38: TLabel
          Left = 18
          Top = 51
          Width = 59
          Height = 13
          Caption = 'Show value:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label41: TLabel
          Left = 18
          Top = 118
          Width = 74
          Height = 13
          AutoSize = False
          Caption = 'Value type:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label40: TLabel
          Left = 18
          Top = 71
          Width = 65
          Height = 13
          Caption = 'Value format:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label83: TLabel
          Left = 187
          Top = 25
          Width = 31
          Height = 13
          Caption = 'Angle:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label84: TLabel
          Left = 187
          Top = 51
          Width = 26
          Height = 13
          Caption = 'Font:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label136: TLabel
          Tag = 51
          Left = 310
          Top = 51
          Width = 38
          Height = 13
          Caption = 'Preview'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label162: TLabel
          Left = 18
          Top = 93
          Width = 107
          Height = 13
          AutoSize = False
          Caption = 'Value format type:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object CheckBox2: TCheckBox
          Left = 162
          Top = 27
          Width = 22
          Height = 17
          TabOrder = 0
          OnClick = CheckBox2Click
        end
        object CheckBox3: TCheckBox
          Left = 162
          Top = 50
          Width = 33
          Height = 17
          TabOrder = 1
          OnClick = CheckBox3Click
        end
        object ComboBox5: TComboBox
          Left = 162
          Top = 113
          Width = 187
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 3
          Text = 'None'
          OnChange = ComboBox5Change
          Items.Strings = (
            'None'
            'Normal'
            'Percentage')
        end
        object Edit3: TEdit
          Left = 162
          Top = 68
          Width = 187
          Height = 21
          TabOrder = 2
          OnChange = Edit3Change
        end
        object Button1: TButton
          Left = 272
          Top = 50
          Width = 32
          Height = 18
          Caption = '...'
          TabOrder = 5
          OnClick = Button1Click
        end
        object AdvChartSpinEdit7: TAdvChartSpinEdit
          Left = 272
          Top = 22
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737395830000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 4
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit7Change
        end
        object ComboBox29: TComboBox
          Left = 162
          Top = 90
          Width = 187
          Height = 21
          Style = csDropDownList
          TabOrder = 6
          OnChange = ComboBox29Change
          Items.Strings = (
            'Normal'
            'Float')
        end
      end
      object GroupBox26: TGroupBox
        Left = 3
        Top = 435
        Width = 598
        Height = 41
        Caption = 'Annotations'
        TabOrder = 3
        object CheckBox7: TCheckBox
          Left = 18
          Top = 17
          Width = 159
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Annotations On Top:'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 0
          OnClick = CheckBox7Click
        end
      end
      object GroupBox34: TGroupBox
        Left = 3
        Top = 354
        Width = 598
        Height = 75
        Caption = 'Selection'
        TabOrder = 4
        object Label128: TLabel
          Left = 18
          Top = 48
          Width = 97
          Height = 13
          Caption = 'Selected mark color:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label129: TLabel
          Left = 18
          Top = 20
          Width = 132
          Height = 13
          Caption = 'Selected mark border color:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label130: TLabel
          Left = 370
          Top = 48
          Width = 70
          Height = 13
          Caption = 'Mark selected:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label132: TLabel
          Left = 370
          Top = 20
          Width = 92
          Height = 13
          Caption = 'Selected mark size:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object AdvChartColorSelector13: TAdvChartColorSelector
          Left = 162
          Top = 43
          Width = 128
          Height = 22
          TabOrder = 0
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvChartColorSelector14Select
        end
        object AdvChartColorSelector14: TAdvChartColorSelector
          Left = 162
          Top = 15
          Width = 128
          Height = 22
          TabOrder = 1
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvChartColorSelector13Select
        end
        object CheckBox11: TCheckBox
          Left = 514
          Top = 47
          Width = 33
          Height = 17
          TabOrder = 2
          OnClick = CheckBox11Click
        end
        object AdvChartSpinEdit22: TAdvChartSpinEdit
          Left = 514
          Top = 17
          Width = 54
          Height = 22
          Value = 0
          DateValue = 42150.471737430550000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 3
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit22Change
        end
      end
      object GroupBox41: TGroupBox
        Left = 367
        Top = 114
        Width = 234
        Height = 84
        Caption = 'Bar Text'
        TabOrder = 5
        object Label158: TLabel
          Left = 13
          Top = 17
          Width = 44
          Height = 18
          AutoSize = False
          Caption = 'Type:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label159: TLabel
          Left = 13
          Top = 39
          Width = 26
          Height = 13
          Caption = 'Font:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label160: TLabel
          Tag = 62
          Left = 119
          Top = 39
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object Label161: TLabel
          Left = 13
          Top = 60
          Width = 62
          Height = 18
          AutoSize = False
          Caption = 'Alignment:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object ComboBox27: TComboBox
          Left = 81
          Top = 14
          Width = 142
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = ComboBox27Change
          Items.Strings = (
            'Custom'
            'XAxisValue')
        end
        object Button19: TButton
          Left = 81
          Top = 37
          Width = 32
          Height = 18
          Caption = '...'
          TabOrder = 1
          OnClick = Button19Click
        end
        object ComboBox28: TComboBox
          Left = 81
          Top = 57
          Width = 142
          Height = 21
          Style = csDropDownList
          TabOrder = 2
          OnChange = ComboBox28Change
          Items.Strings = (
            'Left'
            'Right'
            'Center')
        end
      end
      object GroupBox46: TGroupBox
        Left = 367
        Top = 198
        Width = 234
        Height = 56
        Caption = 'Y-Values offset'
        TabOrder = 6
        object Label164: TLabel
          Left = 127
          Top = 25
          Width = 10
          Height = 13
          Caption = 'Y:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label165: TLabel
          Left = 10
          Top = 25
          Width = 10
          Height = 13
          Caption = 'X:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object AdvChartSpinEdit26: TAdvChartSpinEdit
          Left = 152
          Top = 22
          Width = 74
          Height = 22
          SpinType = sptFloat
          Value = 0
          DateValue = 42150.471737465270000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 0
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit26Change
        end
        object AdvChartSpinEdit27: TAdvChartSpinEdit
          Left = 30
          Top = 22
          Width = 75
          Height = 22
          SpinType = sptFloat
          Value = 0
          DateValue = 42150.471737465270000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 1
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit27Change
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'X-Axis'
      ImageIndex = 5
      object GroupBox1: TGroupBox
        Left = 325
        Top = 252
        Width = 268
        Height = 104
        Caption = 'Tickmark'
        TabOrder = 3
        object Label61: TLabel
          Left = 19
          Top = 24
          Width = 29
          Height = 13
          Caption = 'Color:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label62: TLabel
          Left = 19
          Top = 49
          Width = 23
          Height = 13
          Caption = 'Size:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label63: TLabel
          Left = 19
          Top = 77
          Width = 32
          Height = 13
          Caption = 'Width:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object SpinEdit18: TAdvChartSpinEdit
          Left = 104
          Top = 74
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737476850000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 2
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit18Change
        end
        object SpinEdit17: TAdvChartSpinEdit
          Left = 104
          Top = 46
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737488430000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 1
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit17Change
        end
        object AdvColorSelector13: TAdvChartColorSelector
          Left = 104
          Top = 18
          Width = 128
          Height = 22
          TabOrder = 0
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = clBlack
          BorderDownColor = 7021576
          BorderHotColor = clBlack
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvColorSelector13Select
        end
      end
      object GroupBox2: TGroupBox
        Left = 325
        Top = 0
        Width = 268
        Height = 117
        Caption = 'Text top'
        TabOrder = 1
        object Label65: TLabel
          Left = 19
          Top = 24
          Width = 31
          Height = 13
          Caption = 'Angle:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label66: TLabel
          Left = 19
          Top = 94
          Width = 26
          Height = 13
          Caption = 'Font:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label67: TLabel
          Left = 19
          Top = 70
          Width = 35
          Height = 13
          Caption = 'Offset:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label68: TLabel
          Left = 19
          Top = 47
          Width = 41
          Height = 13
          Caption = 'Position:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label140: TLabel
          Tag = 115
          Left = 140
          Top = 94
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object SpinEdit19: TAdvChartSpinEdit
          Left = 104
          Top = 67
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737499990000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 2
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit19Change
        end
        object ComboBox9: TComboBox
          Left = 104
          Top = 44
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 1
          OnChange = ComboBox9Change
          Items.Strings = (
            'Left'
            'Right'
            'Center'
            'Top'
            'Bottom')
        end
        object Button6: TButton
          Left = 102
          Top = 94
          Width = 32
          Height = 16
          Caption = '...'
          TabOrder = 3
          OnClick = Button6Click
        end
        object SpinEdit31: TAdvChartSpinEdit
          Left = 104
          Top = 19
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737511570000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          Signed = True
          TabOrder = 0
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit31Change
        end
      end
      object GroupBox3: TGroupBox
        Left = 325
        Top = 123
        Width = 268
        Height = 123
        Caption = 'Text bottom'
        TabOrder = 2
        object Label64: TLabel
          Left = 19
          Top = 24
          Width = 31
          Height = 13
          Caption = 'Angle:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label70: TLabel
          Left = 19
          Top = 93
          Width = 26
          Height = 13
          Caption = 'Font:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label71: TLabel
          Left = 19
          Top = 69
          Width = 35
          Height = 13
          Caption = 'Offset:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label72: TLabel
          Left = 19
          Top = 46
          Width = 41
          Height = 13
          Caption = 'Position:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label141: TLabel
          Tag = 115
          Left = 140
          Top = 93
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object SpinEdit20: TAdvChartSpinEdit
          Left = 104
          Top = 66
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737534730000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 2
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit20Change
        end
        object SpinEdit32: TAdvChartSpinEdit
          Left = 104
          Top = 17
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737534730000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          Signed = True
          TabOrder = 0
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit32Change
        end
        object ComboBox10: TComboBox
          Left = 104
          Top = 43
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 1
          OnChange = ComboBox10Change
          Items.Strings = (
            'Left'
            'Right'
            'Center'
            'Top'
            'Bottom')
        end
        object Button7: TButton
          Left = 102
          Top = 92
          Width = 32
          Height = 18
          Caption = '...'
          TabOrder = 3
          OnClick = Button7Click
        end
      end
      object GroupBox4: TGroupBox
        Left = 2
        Top = 0
        Width = 317
        Height = 441
        Caption = 'Units'
        TabOrder = 0
        object Label60: TLabel
          Left = 19
          Top = 408
          Width = 41
          Height = 13
          Caption = 'Position:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label58: TLabel
          Left = 19
          Top = 343
          Width = 109
          Height = 13
          Caption = 'Minor unit time format:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label57: TLabel
          Left = 19
          Top = 307
          Width = 90
          Height = 13
          Caption = 'Minor unit spacing:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label56: TLabel
          Left = 19
          Top = 272
          Width = 51
          Height = 13
          Caption = 'Minor unit:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label53: TLabel
          Left = 19
          Top = 238
          Width = 53
          Height = 13
          Caption = 'Minor font:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label59: TLabel
          Left = 19
          Top = 203
          Width = 110
          Height = 13
          Caption = 'Major unit time format:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label55: TLabel
          Left = 19
          Top = 167
          Width = 91
          Height = 13
          Caption = 'Major unit spacing:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label54: TLabel
          Left = 19
          Top = 135
          Width = 52
          Height = 13
          Caption = 'Major unit:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label52: TLabel
          Left = 19
          Top = 104
          Width = 54
          Height = 13
          Caption = 'Major font:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label51: TLabel
          Left = 19
          Top = 78
          Width = 70
          Height = 13
          Caption = 'Datetime font:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label50: TLabel
          Left = 19
          Top = 52
          Width = 82
          Height = 13
          Caption = 'Datetime format:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label137: TLabel
          Tag = 78
          Left = 175
          Top = 78
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object Label138: TLabel
          Tag = 101
          Left = 175
          Top = 101
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object Label139: TLabel
          Tag = 203
          Left = 175
          Top = 235
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object ComboBox8: TComboBox
          Left = 137
          Top = 405
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 11
          Text = 'Bottom'
          OnChange = ComboBox8Change
          Items.Strings = (
            'Bottom'
            'Top'
            'Both'
            'None')
        end
        object CheckBox4: TCheckBox
          Left = 17
          Top = 376
          Width = 131
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Visible'
          TabOrder = 10
          OnClick = CheckBox4Click
        end
        object Edit6: TEdit
          Left = 137
          Top = 340
          Width = 160
          Height = 21
          TabOrder = 9
          OnChange = Edit6Change
        end
        object SpinEdit16: TAdvChartSpinEdit
          Left = 137
          Top = 304
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737581020000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 8
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit16Change
        end
        object SpinEdit15: TAdvChartSpinEdit
          Left = 137
          Top = 268
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737581020000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 7
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit15Change
        end
        object Edit5: TEdit
          Left = 137
          Top = 200
          Width = 160
          Height = 21
          TabOrder = 5
          OnChange = Edit5Change
        end
        object SpinEdit14: TAdvChartSpinEdit
          Left = 137
          Top = 164
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737592590000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 4
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit14Change
        end
        object SpinEdit13: TAdvChartSpinEdit
          Left = 137
          Top = 132
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737604170000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 3
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit13Change
        end
        object Edit4: TEdit
          Left = 137
          Top = 50
          Width = 160
          Height = 21
          TabOrder = 0
          OnChange = Edit4Change
        end
        object Button3: TButton
          Left = 137
          Top = 77
          Width = 32
          Height = 17
          Caption = '...'
          TabOrder = 1
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 137
          Top = 100
          Width = 32
          Height = 18
          Caption = '...'
          TabOrder = 2
          OnClick = Button4Click
        end
        object Button5: TButton
          Left = 137
          Top = 234
          Width = 32
          Height = 18
          Caption = '...'
          TabOrder = 6
          OnClick = Button5Click
        end
        object CheckBox22: TCheckBox
          Left = 19
          Top = 27
          Width = 131
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Autounits'
          TabOrder = 12
          OnClick = CheckBox22Click
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Y-Axis'
      ImageIndex = 6
      object GroupBox8: TGroupBox
        Left = 325
        Top = 324
        Width = 268
        Height = 132
        Caption = 'Tickmark'
        TabOrder = 4
        object Label95: TLabel
          Left = 19
          Top = 24
          Width = 29
          Height = 13
          Caption = 'Color:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label100: TLabel
          Left = 19
          Top = 49
          Width = 53
          Height = 13
          Caption = 'Major Size:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label101: TLabel
          Left = 19
          Top = 107
          Width = 32
          Height = 13
          Caption = 'Width:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label148: TLabel
          Left = 19
          Top = 77
          Width = 52
          Height = 13
          Caption = 'Minor Size:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object SpinEdit27: TAdvChartSpinEdit
          Left = 104
          Top = 104
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737627320000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 2
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit27Change
        end
        object SpinEdit28: TAdvChartSpinEdit
          Left = 104
          Top = 46
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737627320000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 1
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit28Change
        end
        object AdvColorSelector14: TAdvChartColorSelector
          Left = 104
          Top = 18
          Width = 128
          Height = 22
          TabOrder = 0
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvColorSelector14Select
        end
        object AdvChartSpinEdit23: TAdvChartSpinEdit
          Left = 104
          Top = 74
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737638890000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 3
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit23Change
        end
      end
      object GroupBox7: TGroupBox
        Left = 325
        Top = 150
        Width = 268
        Height = 168
        Caption = 'Text right'
        TabOrder = 3
        object Label90: TLabel
          Left = 19
          Top = 24
          Width = 31
          Height = 13
          Caption = 'Angle:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label91: TLabel
          Left = 19
          Top = 139
          Width = 26
          Height = 13
          Caption = 'Font:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label92: TLabel
          Left = 19
          Top = 107
          Width = 35
          Height = 13
          Caption = 'Offset:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label93: TLabel
          Left = 19
          Top = 81
          Width = 41
          Height = 13
          Caption = 'Position:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label94: TLabel
          Left = 19
          Top = 55
          Width = 26
          Height = 13
          Caption = 'Text:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label145: TLabel
          Tag = 136
          Left = 140
          Top = 136
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object SpinEdit26: TAdvChartSpinEdit
          Left = 104
          Top = 104
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737650460000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 3
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit26Change
        end
        object ComboBox17: TComboBox
          Left = 104
          Top = 78
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 2
          OnChange = ComboBox17Change
          Items.Strings = (
            'Left'
            'Right'
            'Center'
            'Top'
            'Bottom')
        end
        object Edit13: TEdit
          Left = 104
          Top = 51
          Width = 145
          Height = 21
          TabOrder = 1
          OnChange = Edit13Change
        end
        object Button12: TButton
          Left = 104
          Top = 135
          Width = 32
          Height = 18
          Caption = '...'
          TabOrder = 4
          OnClick = Button12Click
        end
        object SpinEdit34: TAdvChartSpinEdit
          Left = 104
          Top = 19
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737673610000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          Signed = True
          TabOrder = 0
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit34Change
        end
      end
      object GroupBox6: TGroupBox
        Left = 325
        Top = 0
        Width = 268
        Height = 144
        Caption = 'Text left'
        TabOrder = 2
        object Label85: TLabel
          Left = 19
          Top = 24
          Width = 31
          Height = 13
          Caption = 'Angle:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label86: TLabel
          Left = 19
          Top = 115
          Width = 26
          Height = 13
          Caption = 'Font:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label87: TLabel
          Left = 19
          Top = 91
          Width = 35
          Height = 13
          Caption = 'Offset:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label88: TLabel
          Left = 19
          Top = 68
          Width = 41
          Height = 13
          Caption = 'Position:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label89: TLabel
          Left = 19
          Top = 47
          Width = 26
          Height = 13
          Caption = 'Text:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label144: TLabel
          Tag = 115
          Left = 140
          Top = 115
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object SpinEdit25: TAdvChartSpinEdit
          Left = 104
          Top = 88
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737685180000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 3
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit25Change
        end
        object ComboBox15: TComboBox
          Left = 104
          Top = 65
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 2
          OnChange = ComboBox15Change
          Items.Strings = (
            'Left'
            'Right'
            'Center'
            'Top'
            'Bottom')
        end
        object Edit12: TEdit
          Left = 104
          Top = 43
          Width = 145
          Height = 21
          TabOrder = 1
          OnChange = Edit12Change
        end
        object Button11: TButton
          Left = 104
          Top = 114
          Width = 32
          Height = 18
          Caption = '...'
          TabOrder = 4
          OnClick = Button11Click
        end
        object SpinEdit33: TAdvChartSpinEdit
          Left = 104
          Top = 19
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737696760000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          Signed = True
          TabOrder = 0
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit33Change
        end
      end
      object GroupBox5: TGroupBox
        Left = 2
        Top = 0
        Width = 317
        Height = 318
        Caption = 'Units'
        TabOrder = 0
        object Label74: TLabel
          Left = 19
          Top = 250
          Width = 41
          Height = 13
          Caption = 'Position:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label76: TLabel
          Left = 19
          Top = 191
          Width = 90
          Height = 13
          Caption = 'Minor unit spacing:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label77: TLabel
          Left = 19
          Top = 156
          Width = 51
          Height = 13
          Caption = 'Minor unit:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label78: TLabel
          Left = 19
          Top = 122
          Width = 53
          Height = 13
          Caption = 'Minor font:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label80: TLabel
          Left = 19
          Top = 91
          Width = 91
          Height = 13
          Caption = 'Major unit spacing:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label81: TLabel
          Left = 19
          Top = 64
          Width = 52
          Height = 13
          Caption = 'Major unit:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label82: TLabel
          Left = 20
          Top = 38
          Width = 54
          Height = 13
          Caption = 'Major font:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 19
          Top = 277
          Width = 55
          Height = 13
          Caption = 'Autorange:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label142: TLabel
          Tag = 25
          Left = 175
          Top = 39
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object Label143: TLabel
          Tag = 118
          Left = 175
          Top = 118
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object ComboBox13: TComboBox
          Left = 137
          Top = 247
          Width = 160
          Height = 21
          Style = csDropDownList
          TabOrder = 7
          OnChange = ComboBox13Change
          Items.Strings = (
            'Left'
            'Right'
            'Both'
            'None')
        end
        object CheckBox5: TCheckBox
          Left = 18
          Top = 218
          Width = 131
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Visible:'
          TabOrder = 6
          OnClick = CheckBox5Click
        end
        object SpinEdit21: TAdvChartSpinEdit
          Left = 137
          Top = 188
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737731480000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 5
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit21Change
        end
        object SpinEdit23: TAdvChartSpinEdit
          Left = 137
          Top = 88
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737731480000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 2
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit23Change
        end
        object Button9: TButton
          Left = 137
          Top = 38
          Width = 32
          Height = 18
          Caption = '...'
          TabOrder = 0
          OnClick = Button9Click
        end
        object Button10: TButton
          Left = 137
          Top = 117
          Width = 32
          Height = 18
          Caption = '...'
          TabOrder = 3
          OnClick = Button10Click
        end
        object AdvSpinEdit4: TAdvChartSpinEdit
          Left = 137
          Top = 150
          Width = 160
          Height = 22
          SpinType = sptFloat
          Value = 0
          DateValue = 42150.471737743060000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 4
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvSpinEdit4Change
        end
        object AdvSpinEdit5: TAdvChartSpinEdit
          Left = 137
          Top = 61
          Width = 160
          Height = 22
          SpinType = sptFloat
          Value = 0
          DateValue = 42150.471737743060000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 1
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvSpinEdit5Change
        end
        object ComboBox1: TComboBox
          Left = 137
          Top = 274
          Width = 160
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          TabOrder = 8
          OnChange = ComboBox1Change
          Items.Strings = (
            'Disabled'
            'Enabled'
            'Common'
            'Enabled Zero Based'
            'Common Zero Based')
        end
        object CheckBox12: TCheckBox
          Left = 189
          Top = 190
          Width = 108
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Minor visible:'
          TabOrder = 9
          OnClick = CheckBox12Click
        end
        object CheckBox13: TCheckBox
          Left = 189
          Top = 90
          Width = 108
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Major visible:'
          TabOrder = 10
          OnClick = CheckBox13Click
        end
        object CheckBox24: TCheckBox
          Left = 20
          Top = 13
          Width = 131
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Autounits'
          TabOrder = 11
          OnClick = CheckBox24Click
        end
      end
      object GroupBox9: TGroupBox
        Left = 2
        Top = 324
        Width = 317
        Height = 132
        Caption = 'Zeroline'
        TabOrder = 1
        object Label99: TLabel
          Left = 19
          Top = 48
          Width = 49
          Height = 13
          Caption = 'Line color:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label98: TLabel
          Left = 19
          Top = 75
          Width = 81
          Height = 13
          Caption = 'Reference point:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label97: TLabel
          Left = 19
          Top = 21
          Width = 52
          Height = 13
          Caption = 'Line width:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object CheckBox6: TCheckBox
          Left = 18
          Top = 102
          Width = 131
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Visible:'
          TabOrder = 3
          OnClick = CheckBox6Click
        end
        object AdvColorSelector15: TAdvChartColorSelector
          Left = 137
          Top = 42
          Width = 128
          Height = 22
          TabOrder = 1
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = clBlack
          BorderDownColor = 7021576
          BorderHotColor = clBlack
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvColorSelector15Select
        end
        object SpinEdit29: TAdvChartSpinEdit
          Left = 137
          Top = 15
          Width = 46
          Height = 22
          Value = 0
          DateValue = 42150.471737777780000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 0
          Visible = True
          Version = '1.6.2.3'
          OnChange = SpinEdit29Change
        end
        object AdvSpinEdit3: TAdvChartSpinEdit
          Left = 137
          Top = 74
          Width = 160
          Height = 22
          SpinType = sptFloat
          Value = 0
          DateValue = 42150.471737777780000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 2
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvSpinEdit3Change
        end
      end
    end
    object TabSheet17: TTabSheet
      Caption = 'Legend'
      ImageIndex = 11
      object Label166: TLabel
        Left = 3
        Top = 338
        Width = 489
        Height = 13
        Caption = 
          'These properties only apply to the separate Legend available for' +
          ' types such as Pie, Donut and Funnel'
      end
      object GroupBox29: TGroupBox
        Left = 3
        Top = 3
        Width = 598
        Height = 333
        Caption = 'Legend'
        TabOrder = 0
        object Label102: TLabel
          Left = 16
          Top = 74
          Width = 62
          Height = 13
          Caption = 'Border color:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label103: TLabel
          Left = 16
          Top = 97
          Width = 65
          Height = 13
          Caption = 'Border width:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label104: TLabel
          Left = 16
          Top = 18
          Width = 29
          Height = 13
          Caption = 'Color:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label105: TLabel
          Left = 16
          Top = 46
          Width = 92
          Height = 13
          Caption = 'Gradient end color:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label106: TLabel
          Left = 327
          Top = 131
          Width = 31
          Height = 13
          Caption = 'Angle:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label107: TLabel
          Left = 16
          Top = 121
          Width = 70
          Height = 13
          Caption = 'Gradient type:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label108: TLabel
          Left = 328
          Top = 157
          Width = 26
          Height = 13
          Caption = 'Font:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label113: TLabel
          Left = 327
          Top = 15
          Width = 50
          Height = 13
          Caption = 'Opacity 1:'
        end
        object Label114: TLabel
          Left = 327
          Top = 46
          Width = 50
          Height = 13
          Caption = 'Opacity 2:'
        end
        object Label111: TLabel
          Left = 16
          Top = 144
          Width = 58
          Height = 13
          Caption = 'Hatch style:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label109: TLabel
          Left = 327
          Top = 75
          Width = 54
          Height = 13
          Caption = 'Offset left:'
        end
        object Label115: TLabel
          Left = 327
          Top = 103
          Width = 54
          Height = 13
          Caption = 'Offset top:'
        end
        object Label124: TLabel
          Left = 16
          Top = 171
          Width = 41
          Height = 13
          Caption = 'Position:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label147: TLabel
          Tag = 157
          Left = 519
          Top = 157
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object AdvChartColorSelector8: TAdvChartColorSelector
          Left = 171
          Top = 66
          Width = 128
          Height = 22
          TabOrder = 2
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvChartColorSelector8Select
        end
        object AdvChartSpinEdit9: TAdvChartSpinEdit
          Left = 171
          Top = 92
          Width = 54
          Height = 22
          Value = 0
          DateValue = 42150.471737812500000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 3
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit9Change
        end
        object AdvChartColorSelector9: TAdvChartColorSelector
          Left = 171
          Top = 40
          Width = 128
          Height = 22
          TabOrder = 1
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvChartColorSelector9Select
        end
        object AdvChartColorSelector10: TAdvChartColorSelector
          Left = 171
          Top = 12
          Width = 128
          Height = 22
          TabOrder = 0
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = AdvChartColorSelector10Select
        end
        object AdvChartSpinEdit10: TAdvChartSpinEdit
          Left = 482
          Top = 128
          Width = 54
          Height = 22
          Value = 0
          DateValue = 42150.471737824080000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 6
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit10Change
        end
        object Button17: TButton
          Left = 481
          Top = 157
          Width = 32
          Height = 17
          Caption = '...'
          TabOrder = 7
          OnClick = Button17Click
        end
        object CheckBox9: TCheckBox
          Left = 327
          Top = 180
          Width = 169
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Visible:'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 8
          OnClick = CheckBox9Click
        end
        object AdvChartSpinEdit12: TAdvChartSpinEdit
          Left = 481
          Top = 40
          Width = 55
          Height = 22
          Value = 0
          DateValue = 42150.471737835650000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 10
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit12Change
        end
        object AdvChartSpinEdit13: TAdvChartSpinEdit
          Left = 481
          Top = 12
          Width = 55
          Height = 22
          Value = 0
          DateValue = 42150.471737847220000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 9
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit13Change
        end
        object ComboBox14: TComboBox
          Left = 171
          Top = 141
          Width = 128
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnChange = ComboBox14Change
          Items.Strings = (
            'Horizontal'
            'Vertical'
            'ForwardDiagonal'
            'BackwardDiagonal'
            'Cross'
            'DiagonalCross'
            '5 Percent'
            '10 Percent'
            '20 Percent'
            '25 Percent'
            '30 Percent'
            '40 Percent'
            '50 Percent'
            '60 Percent'
            '70 Percent'
            '75 Percent'
            '80 Percent'
            '90 Percent'
            'Light Downward Diagonal'
            'Light Upward Diagonal'
            'Dark Downward Diagonal'
            'Dark Upward Diagonal'
            'Wide Downward Diagonal'
            'Wide Upward Diagonal'
            'Light Vertical'
            'Light Horizontal'
            'Narrow Vertical'
            'Narrow Horizontal'
            'Dark Vertical'
            'Dark Horizontal'
            'Dashed Downward Diagonal'
            'Dashed Upward Diagonal'
            'Dashed Horizontal'
            'Dashed Vertical'
            'Small Confetti'
            'Large Confetti'
            'Zig Zag'
            'Wave'
            'Diagonal Brick'
            'Horizontal Brick'
            'Weave'
            'Plaid'
            'Divot'
            'Dotted Grid'
            'Dotted Diamond'
            'Shingle'
            'Trellis'
            'Sphere'
            'Small Grid'
            'Small CheckerBoard'
            'Large CheckerBoard'
            'Outlined Diamond'
            'Solid Diamond'
            'Total                      ')
        end
        object ComboBox12: TComboBox
          Left = 171
          Top = 117
          Width = 128
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnChange = ComboBox12Change
          Items.Strings = (
            'Solid'
            'Radial'
            'Vertical'
            'Horizontal'
            'ForwardDiagonal'
            'BackwardDiagonal'
            'Angle'
            'Hatch'
            'Path'
            'Texture'
            'None')
        end
        object AdvChartSpinEdit11: TAdvChartSpinEdit
          Left = 481
          Top = 69
          Width = 55
          Height = 22
          Value = 0
          DateValue = 42150.471737881950000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 11
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit11Change
        end
        object AdvChartSpinEdit15: TAdvChartSpinEdit
          Left = 481
          Top = 100
          Width = 55
          Height = 22
          Value = 0
          DateValue = 42150.471737893520000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 12
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit15Change
        end
        object GroupBox32: TGroupBox
          Left = 7
          Top = 197
          Width = 582
          Height = 125
          Caption = 'Title'
          TabOrder = 13
          object Label117: TLabel
            Left = 13
            Top = 39
            Width = 29
            Height = 13
            Caption = 'Color:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Transparent = True
          end
          object Label118: TLabel
            Left = 13
            Top = 65
            Width = 92
            Height = 13
            Caption = 'Gradient end color:'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label119: TLabel
            Left = 13
            Top = 90
            Width = 70
            Height = 13
            Caption = 'Gradient type:'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label121: TLabel
            Left = 320
            Top = 17
            Width = 58
            Height = 13
            Caption = 'Hatch style:'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label120: TLabel
            Left = 320
            Top = 44
            Width = 50
            Height = 13
            Caption = 'Opacity 1:'
          end
          object Label122: TLabel
            Left = 320
            Top = 71
            Width = 50
            Height = 13
            Caption = 'Opacity 2:'
          end
          object Label123: TLabel
            Left = 320
            Top = 97
            Width = 31
            Height = 13
            Caption = 'Angle:'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object CheckBox10: TCheckBox
            Left = 13
            Top = 15
            Width = 167
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Visible:'
            Color = clBtnFace
            ParentColor = False
            TabOrder = 0
            OnClick = CheckBox10Click
          end
          object AdvChartColorSelector11: TAdvChartColorSelector
            Left = 168
            Top = 60
            Width = 128
            Height = 22
            TabOrder = 1
            AppearanceStyle = esXP
            Version = '1.3.5.0'
            SelectedColor = clNone
            ShowRGBHint = True
            AutoThemeAdapt = False
            BorderColor = 12164479
            BorderDownColor = 7021576
            BorderHotColor = 12164479
            BorderDropDownColor = 12164479
            Caption = ''
            Color = clBtnFace
            ColorDown = 11900292
            ColorHot = 14073525
            ColorDropDown = 16251129
            ColorSelected = 14604246
            ColorSelectedTo = clNone
            Style = ssCombo
            Tools = <
              item
                Caption = 'None'
                CaptionAlignment = taCenter
                ImageIndex = -1
                Hint = 'None'
                ItemType = itFullWidthButton
              end
              item
                BackGroundColor = clBlack
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 13209
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 13107
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 13056
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 6697728
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clNavy
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 3486515
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 3355443
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clMaroon
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 26367
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clOlive
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clGreen
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clTeal
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clBlue
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 10053222
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clGray
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clRed
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 39423
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 52377
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 6723891
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 13421619
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 16737843
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clPurple
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 10066329
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clFuchsia
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 52479
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clYellow
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clLime
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clAqua
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 16763904
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 6697881
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clSilver
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 13408767
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 10079487
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 10092543
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 13434828
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 16777164
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 16764057
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 16751052
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clWhite
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                Caption = 'More Colors...'
                CaptionAlignment = taCenter
                ImageIndex = -1
                Hint = 'More Color'
                ItemType = itFullWidthButton
              end>
            OnSelect = AdvChartColorSelector11Select
          end
          object AdvChartColorSelector12: TAdvChartColorSelector
            Left = 168
            Top = 33
            Width = 128
            Height = 22
            TabOrder = 2
            AppearanceStyle = esXP
            Version = '1.3.5.0'
            SelectedColor = clNone
            ShowRGBHint = True
            AutoThemeAdapt = False
            BorderColor = 12164479
            BorderDownColor = 7021576
            BorderHotColor = 12164479
            BorderDropDownColor = 12164479
            Caption = ''
            Color = clBtnFace
            ColorDown = 11900292
            ColorHot = 14073525
            ColorDropDown = 16251129
            ColorSelected = 14604246
            ColorSelectedTo = clNone
            Style = ssCombo
            Tools = <
              item
                Caption = 'None'
                CaptionAlignment = taCenter
                ImageIndex = -1
                Hint = 'None'
                ItemType = itFullWidthButton
              end
              item
                BackGroundColor = clBlack
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 13209
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 13107
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 13056
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 6697728
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clNavy
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 3486515
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 3355443
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clMaroon
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 26367
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clOlive
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clGreen
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clTeal
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clBlue
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 10053222
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clGray
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clRed
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 39423
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 52377
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 6723891
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 13421619
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 16737843
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clPurple
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 10066329
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clFuchsia
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 52479
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clYellow
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clLime
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clAqua
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 16763904
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 6697881
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clSilver
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 13408767
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 10079487
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 10092543
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 13434828
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 16777164
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 16764057
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = 16751052
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                BackGroundColor = clWhite
                CaptionAlignment = taCenter
                ImageIndex = -1
              end
              item
                Caption = 'More Colors...'
                CaptionAlignment = taCenter
                ImageIndex = -1
                Hint = 'More Color'
                ItemType = itFullWidthButton
              end>
            OnSelect = AdvChartColorSelector12Select
          end
          object ComboBox18: TComboBox
            Left = 168
            Top = 87
            Width = 128
            Height = 21
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnChange = ComboBox18Change
          Items.Strings = (
            'Solid'
            'Radial'
            'Vertical'
            'Horizontal'
            'ForwardDiagonal'
            'BackwardDiagonal'
            'Angle'
            'Hatch'
            'Path'
            'Texture'
            'None')
          end
          object ComboBox19: TComboBox
            Left = 445
            Top = 14
            Width = 128
            Height = 21
            BevelEdges = []
            BevelInner = bvNone
            BevelOuter = bvNone
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnChange = ComboBox19Change
            Items.Strings = (
              'Horizontal'
              'Vertical'
              'ForwardDiagonal'
              'BackwardDiagonal'
              'Cross'
              'DiagonalCross'
              '5 Percent'
              '10 Percent'
              '20 Percent'
              '25 Percent'
              '30 Percent'
              '40 Percent'
              '50 Percent'
              '60 Percent'
              '70 Percent'
              '75 Percent'
              '80 Percent'
              '90 Percent'
              'Light Downward Diagonal'
              'Light Upward Diagonal'
              'Dark Downward Diagonal'
              'Dark Upward Diagonal'
              'Wide Downward Diagonal'
              'Wide Upward Diagonal'
              'Light Vertical'
              'Light Horizontal'
              'Narrow Vertical'
              'Narrow Horizontal'
              'Dark Vertical'
              'Dark Horizontal'
              'Dashed Downward Diagonal'
              'Dashed Upward Diagonal'
              'Dashed Horizontal'
              'Dashed Vertical'
              'Small Confetti'
              'Large Confetti'
              'Zig Zag'
              'Wave'
              'Diagonal Brick'
              'Horizontal Brick'
              'Weave'
              'Plaid'
              'Divot'
              'Dotted Grid'
              'Dotted Diamond'
              'Shingle'
              'Trellis'
              'Sphere'
              'Small Grid'
              'Small CheckerBoard'
              'Large CheckerBoard'
              'Outlined Diamond'
              'Solid Diamond'
              'Total                      ')
          end
          object AdvChartSpinEdit17: TAdvChartSpinEdit
            Left = 445
            Top = 68
            Width = 55
            Height = 22
            Value = 0
            DateValue = 42150.471737962960000000
            HexValue = 0
            IncrementFloat = 0.100000000000000000
            IncrementFloatPage = 1.000000000000000000
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'Tahoma'
            LabelFont.Style = []
            TabOrder = 5
            Visible = True
            Version = '1.6.2.3'
            OnChange = AdvChartSpinEdit17Change
          end
          object AdvChartSpinEdit18: TAdvChartSpinEdit
            Left = 445
            Top = 41
            Width = 55
            Height = 22
            Value = 0
            DateValue = 42150.471737962960000000
            HexValue = 0
            IncrementFloat = 0.100000000000000000
            IncrementFloatPage = 1.000000000000000000
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'Tahoma'
            LabelFont.Style = []
            TabOrder = 6
            Visible = True
            Version = '1.6.2.3'
            OnChange = AdvChartSpinEdit18Change
          end
          object AdvChartSpinEdit19: TAdvChartSpinEdit
            Left = 445
            Top = 94
            Width = 54
            Height = 22
            Value = 0
            DateValue = 42150.471737974530000000
            HexValue = 0
            IncrementFloat = 0.100000000000000000
            IncrementFloatPage = 1.000000000000000000
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'Tahoma'
            LabelFont.Style = []
            TabOrder = 7
            Visible = True
            Version = '1.6.2.3'
            OnChange = AdvChartSpinEdit19Change
          end
        end
        object ComboBox16: TComboBox
          Left = 171
          Top = 168
          Width = 128
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
          OnChange = ComboBox16Change
          Items.Strings = (
            'TopLeft'
            'TopRight'
            'TopCenter'
            'BottomLeft'
            'BottomRight'
            'BottomCenter'
            'CenterLeft'
            'CenterCenter'
            'CenterRight'
            'Custom')
        end
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Pie / Donut'
      ImageIndex = 7
      object GroupBox30: TGroupBox
        Left = 3
        Top = 3
        Width = 598
        Height = 78
        Caption = 'Appearance'
        TabOrder = 0
        object Label96: TLabel
          Left = 16
          Top = 21
          Width = 23
          Height = 13
          Caption = 'Size:'
        end
        object Label112: TLabel
          Left = 16
          Top = 49
          Width = 58
          Height = 13
          Caption = 'Start Angle:'
        end
        object Label116: TLabel
          Left = 176
          Top = 21
          Width = 92
          Height = 13
          Caption = 'Inner Size (Donut):'
        end
        object Label125: TLabel
          Left = 177
          Top = 49
          Width = 41
          Height = 13
          Caption = 'Position:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label126: TLabel
          Left = 414
          Top = 21
          Width = 23
          Height = 13
          Caption = 'Left:'
        end
        object Label127: TLabel
          Left = 504
          Top = 21
          Width = 22
          Height = 13
          Caption = 'Top:'
        end
        object Label163: TLabel
          Left = 414
          Top = 49
          Width = 50
          Height = 13
          Caption = 'Size Type:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object AdvChartSpinEdit8: TAdvChartSpinEdit
          Left = 91
          Top = 18
          Width = 65
          Height = 22
          Value = 0
          DateValue = 42150.471737997690000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 0
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit8Change
        end
        object AdvChartSpinEdit14: TAdvChartSpinEdit
          Left = 91
          Top = 46
          Width = 65
          Height = 22
          Value = 0
          DateValue = 42150.471737997690000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 1
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit14Change
        end
        object AdvChartSpinEdit16: TAdvChartSpinEdit
          Left = 275
          Top = 18
          Width = 65
          Height = 22
          Value = 0
          DateValue = 42150.471738009260000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 2
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit16Change
        end
        object ComboBox20: TComboBox
          Left = 275
          Top = 46
          Width = 128
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnChange = ComboBox20Change
          Items.Strings = (
            'TopLeft'
            'TopRight'
            'TopCenter'
            'BottomLeft'
            'BottomRight'
            'BottomCenter'
            'CenterLeft'
            'CenterCenter'
            'CenterRight'
            'Custom')
        end
        object AdvChartSpinEdit20: TAdvChartSpinEdit
          Left = 444
          Top = 18
          Width = 55
          Height = 22
          Value = 0
          DateValue = 42150.471738020830000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 4
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit20Change
        end
        object AdvChartSpinEdit21: TAdvChartSpinEdit
          Left = 532
          Top = 18
          Width = 55
          Height = 22
          Value = 0
          DateValue = 42150.471738020830000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 5
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit21Change
        end
        object ComboBox30: TComboBox
          Left = 476
          Top = 46
          Width = 111
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnChange = ComboBox30Change
          Items.Strings = (
            'Pixels'
            'Percentage')
        end
      end
      object GroupBox28: TGroupBox
        Left = 215
        Top = 87
        Width = 386
        Height = 50
        Caption = 'Slice Values'
        TabOrder = 1
        object Label110: TLabel
          Left = 13
          Top = 11
          Width = 26
          Height = 13
          Caption = 'Font:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label146: TLabel
          Tag = 10
          Left = 144
          Top = 10
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object Label152: TLabel
          Left = 210
          Top = 29
          Width = 41
          Height = 13
          Caption = 'Position:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Button2: TButton
          Left = 111
          Top = 8
          Width = 32
          Height = 17
          Caption = '...'
          TabOrder = 1
          OnClick = Button2Click
        end
        object CheckBox8: TCheckBox
          Left = 13
          Top = 30
          Width = 125
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Visible:'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 0
          OnClick = CheckBox8Click
        end
        object ComboBox24: TComboBox
          Left = 257
          Top = 26
          Width = 120
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = ComboBox24Change
          Items.Strings = (
            'Inside Slice'
            'Outside Slice')
        end
        object CheckBox17: TCheckBox
          Left = 210
          Top = 9
          Width = 125
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Legend on slice:'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 3
          OnClick = CheckBox17Click
        end
      end
      object GroupBox39: TGroupBox
        Left = 3
        Top = 87
        Width = 206
        Height = 50
        Caption = 'Grid'
        TabOrder = 2
        object CheckBox14: TCheckBox
          Left = 16
          Top = 9
          Width = 171
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Show Grid:'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 0
          OnClick = CheckBox14Click
        end
        object CheckBox15: TCheckBox
          Left = 16
          Top = 30
          Width = 171
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Show Pie Grid Lines:'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 1
          OnClick = CheckBox15Click
        end
      end
    end
    object TabSheet18: TTabSheet
      Caption = 'Funnel'
      ImageIndex = 12
      object GroupBox47: TGroupBox
        Left = 11
        Top = 6
        Width = 590
        Height = 171
        Caption = 'Appearance'
        TabOrder = 0
        object Label167: TLabel
          Left = 16
          Top = 21
          Width = 32
          Height = 13
          Caption = 'Width:'
        end
        object Label168: TLabel
          Left = 16
          Top = 52
          Width = 35
          Height = 13
          Caption = 'Height:'
        end
        object Label169: TLabel
          Left = 17
          Top = 84
          Width = 41
          Height = 13
          Caption = 'Position:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label170: TLabel
          Left = 446
          Top = 21
          Width = 23
          Height = 13
          Caption = 'Left:'
        end
        object Label171: TLabel
          Left = 446
          Top = 49
          Width = 22
          Height = 13
          Caption = 'Top:'
        end
        object Label172: TLabel
          Left = 186
          Top = 21
          Width = 57
          Height = 13
          Caption = 'Width type:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label173: TLabel
          Left = 186
          Top = 52
          Width = 60
          Height = 13
          Caption = 'Height type:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label174: TLabel
          Left = 18
          Top = 116
          Width = 30
          Height = 13
          Caption = 'Mode:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label175: TLabel
          Left = 18
          Top = 143
          Width = 41
          Height = 13
          Caption = 'Spacing:'
        end
        object AdvChartSpinEdit28: TAdvChartSpinEdit
          Left = 99
          Top = 18
          Width = 65
          Height = 22
          Value = 0
          DateValue = 42150.471738067130000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 0
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit28Change
        end
        object AdvChartSpinEdit29: TAdvChartSpinEdit
          Left = 99
          Top = 49
          Width = 65
          Height = 22
          Value = 0
          DateValue = 42150.471738078710000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 1
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit29Change
        end
        object ComboBox31: TComboBox
          Left = 99
          Top = 81
          Width = 128
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = ComboBox31Change
          Items.Strings = (
            'TopLeft'
            'TopRight'
            'TopCenter'
            'BottomLeft'
            'BottomRight'
            'BottomCenter'
            'CenterLeft'
            'CenterCenter'
            'CenterRight'
            'Custom')
        end
        object AdvChartSpinEdit30: TAdvChartSpinEdit
          Left = 520
          Top = 18
          Width = 55
          Height = 22
          Value = 0
          DateValue = 42150.471738090280000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 3
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit30Change
        end
        object AdvChartSpinEdit31: TAdvChartSpinEdit
          Left = 520
          Top = 46
          Width = 55
          Height = 22
          Value = 0
          DateValue = 42150.471738090280000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 4
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit31Change
        end
        object ComboBox32: TComboBox
          Left = 267
          Top = 18
          Width = 128
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnChange = ComboBox32Change
          Items.Strings = (
            'Pixels'
            'Percentage')
        end
        object ComboBox33: TComboBox
          Left = 267
          Top = 49
          Width = 128
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnChange = ComboBox33Change
          Items.Strings = (
            'Pixels'
            'Percentage')
        end
        object ComboBox34: TComboBox
          Left = 99
          Top = 113
          Width = 128
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnChange = ComboBox34Change
          Items.Strings = (
            'Width'
            'Height')
        end
        object AdvChartSpinEdit32: TAdvChartSpinEdit
          Left = 99
          Top = 140
          Width = 55
          Height = 22
          Value = 0
          DateValue = 42150.471738113430000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 8
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit32Change
        end
      end
      object GroupBox48: TGroupBox
        Left = 11
        Top = 183
        Width = 590
        Height = 73
        Caption = 'Values'
        TabOrder = 1
        object Label176: TLabel
          Left = 17
          Top = 46
          Width = 26
          Height = 13
          Caption = 'Font:'
          Color = 15984090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label177: TLabel
          Tag = 46
          Left = 91
          Top = 46
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object Label178: TLabel
          Left = 211
          Top = 46
          Width = 41
          Height = 13
          Caption = 'Position:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Button21: TButton
          Left = 53
          Top = 45
          Width = 32
          Height = 17
          Caption = '...'
          TabOrder = 1
          OnClick = Button2Click
        end
        object CheckBox25: TCheckBox
          Left = 18
          Top = 17
          Width = 171
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Visible:'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 0
          OnClick = CheckBox25Click
        end
        object ComboBox35: TComboBox
          Left = 303
          Top = 43
          Width = 120
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = ComboBox35Change
          Items.Strings = (
            'Inside Funnel'
            'Outside Funnel')
        end
        object CheckBox26: TCheckBox
          Left = 211
          Top = 17
          Width = 104
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Legend:'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 3
          OnClick = CheckBox26Click
        end
      end
    end
    object DTB: TTabSheet
      Caption = 'Database'
      ImageIndex = 8
      object GroupBox35: TGroupBox
        Left = 3
        Top = 3
        Width = 606
        Height = 86
        Caption = 'Connections'
        TabOrder = 0
        object Label149: TLabel
          Left = 16
          Top = 20
          Width = 81
          Height = 13
          Caption = 'Fieldname value:'
        end
        object Label150: TLabel
          Left = 16
          Top = 52
          Width = 85
          Height = 13
          Caption = 'Fieldname X-Axis:'
        end
        object ComboBox21: TComboBox
          Left = 136
          Top = 17
          Width = 257
          Height = 21
          TabOrder = 0
          OnChange = ComboBox21Change
        end
        object ComboBox22: TComboBox
          Left = 136
          Top = 49
          Width = 257
          Height = 21
          TabOrder = 1
          OnChange = ComboBox22Change
        end
      end
    end
    object TabSheet15: TTabSheet
      Caption = 'ZoomControl'
      ImageIndex = 9
      object GroupBox40: TGroupBox
        Left = 3
        Top = 3
        Width = 606
        Height = 62
        Caption = 'Zoom control window'
        TabOrder = 0
        object Label15: TLabel
          Left = 17
          Top = 25
          Width = 53
          Height = 13
          Caption = 'Serie type:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object ComboBox23: TComboBox
          Left = 115
          Top = 22
          Width = 198
          Height = 21
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = ComboBox23Change
          Items.Strings = (
            'Normal'
            'In Zoom Control Only'
            'In Zoom Control And Normal')
        end
      end
    end
    object TabSheet16: TTabSheet
      Caption = 'Groups'
      ImageIndex = 10
      object SpeedButton6: TSpeedButton
        Left = 3
        Top = 6
        Width = 23
        Height = 22
        Cursor = crHandPoint
        Hint = 'Add Serie'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF00007200007200006B000066000065000065FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0001B70001B7050DAC393EB058
          5AB25657AB2E2F9000006F000069000069FF00FFFF00FFFF00FFFF00FFFF00FF
          0016CE0915C66C74D9CED1F2FFFFFFFFFFFFFFFFFFFFFFFFC1C2DF5A5A9F0101
          6900007DFF00FFFF00FFFF00FF0018DF0A1DD3A8B0EDFFFFFFFFFFFFBDBEE98C
          8CD18D8DD0CACAEAFFFFFFFFFFFF8C8CBD010169000072FF00FFFF00FF0018DF
          919DEFFFFFFFE6E8F94F53CE0002AB00009D0000950000975F5FBEF0F0FAFFFF
          FF6565A6000072FF00FF001EF12743E7FBFBFFF7F8FD3B4BDA0000C0161DBEB0
          B4E7A3A5E00A0CA000008F5252B9FFFFFFD9D9E90B0B7F00007A001EF17287F6
          FFFFFF91A1F4000DDA000BD0161DCBF1F4FEDEE1F60508A900009A000093ACAC
          DDFFFFFF5353AF00007A0023F8A8B8FCFFFFFF4060F61734ECA0AEF2BABEF1F8
          F9FEF3F4FBB6B8E99799DC0D0EA25A5BBFFFFFFF8487D60000790E3EFEC5CFFE
          FFFFFF3259FE2649F9FAFCFFFFFFFFFFFFFFFFFFFFFFFFFFEBECF91519B14A4F
          C1FFFFFF9094D90000A23C63FFC4D0FFFFFFFF5979FF052EFF375CFB586DF4F0
          F3FEE3E6FA4D5ADE3446D20004B7757CD6FFFFFF797DD50000A8103EFFB6C5FF
          FFFFFFC7D2FF032CFF0020FF1739FBF3F6FFE1E5FA071FDC0007CE0C1CCBD9DC
          F5FDFDFE313CC80000A8FF00FF8DA4FFFFFFFFFFFFFF8AA0FF0027FF002CFF46
          6AFF4163F8001DE9061CDFA1ACF1FFFFFFB4BAED0007BBFF00FFFF00FF718DFF
          DAE1FFFFFFFFFFFFFFB1C0FF3B5DFF1538FF1739FE4966F8C0CAFAFFFFFFEDEF
          FC3041D30007BBFF00FFFF00FFFF00FF88A0FFE6EBFFFFFFFFFFFFFFFDFDFFE2
          E9FFE4EBFFFFFFFFFFFFFFDBE0FA3D50E0000BCCFF00FFFF00FFFF00FFFF00FF
          FF00FF8AA1FFBAC7FEE8ECFFFFFFFFFFFFFFFFFFFFE4E9FE889BF61738E6000B
          CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8AA0FF8AA3FF90
          A6FF7993FE4A6BF91A40EFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton6Click
      end
      object SpeedButton5: TSpeedButton
        Left = 26
        Top = 6
        Width = 23
        Height = 22
        Cursor = crHandPoint
        Hint = 'Remove Serie'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF00007200007200006B000066000065000065FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0001B70001B7050DAC393EB058
          5AB25657AB2E2F9000006F000069000069FF00FFFF00FFFF00FFFF00FFFF00FF
          0016CE0915C66C74D9CED1F2FFFFFFFFFFFFFFFFFFFFFFFFC1C2DF5A5A9F0101
          6900007DFF00FFFF00FFFF00FF0018DF0A1DD3A8B0EDFFFFFFFFFFFFBDBEE98C
          8CD18D8DD0CACAEAFFFFFFFFFFFF8C8CBD010169000072FF00FFFF00FF0018DF
          919DEFFFFFFFE6E8F94F53CE0002AB161DBE1A1CB10000975F5FBEF0F0FAFFFF
          FF6565A6000072FF00FF001EF12743E7FBFBFFF7F8FD3B4BDA0000C0161DBE16
          19B40B0CA1090B9F00008F5252B9FFFFFFD9D9E90B0B7F00007A001EF17287F6
          FFFFFF91A1F4000DDA000BD0161DCB1D1EAE0C0DA00609A700009A000093ACAC
          DDFFFFFF5353AF00007A0023F8A8B8FCFFFFFF4060F61734ECF8F9FEF8F9FEF8
          F9FEF3F4FBF3F4FBF3F4FB0D0EA25A5BBFFFFFFF8487D60000790E3EFEC5CFFE
          FFFFFF3259FE2649F9C5CFFDFFFFFFFFFFFFFFFFFFFFFFFFEBECF91519B14A4F
          C1FFFFFF9094D90000A23C63FFC4D0FFFFFFFF5979FF052EFF123AFE122EEB0D
          24E20719D90F17D10004B70004B7757CD6FFFFFF797DD50000A8103EFFB6C5FF
          FFFFFFC7D2FF032CFF0020FF0829FE1630EB0119E20517D90A11D00C1CCBD9DC
          F5FDFDFE313CC80000A8FF00FF8DA4FFFFFFFFFFFFFF8AA0FF0027FF012CFF04
          24FF1C3EFB001DE9061CDFA1ACF1FFFFFFB4BAED0007BBFF00FFFF00FF718DFF
          DAE1FFFFFFFFFFFFFFB1C0FF3B5DFF1538FF1739FE4966F8C0CAFAFFFFFFEDEF
          FC3041D30007BBFF00FFFF00FFFF00FF88A0FFE6EBFFFFFFFFFFFFFFFDFDFFE2
          E9FFE4EBFFFFFFFFFFFFFFDBE0FA3D50E0000BCCFF00FFFF00FFFF00FFFF00FF
          FF00FF8AA1FFBAC7FEE8ECFFFFFFFFFFFFFFFFFFFFE4E9FE889BF61738E6000B
          CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8AA0FF8AA3FF90
          A6FF7993FE4A6BF91A40EFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton5Click
      end
      object ListBox2: TListBox
        Left = 3
        Top = 34
        Width = 247
        Height = 431
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListBox2Click
      end
      object GroupBox43: TGroupBox
        Left = 256
        Top = 27
        Width = 345
        Height = 62
        Caption = 'Global'
        TabOrder = 1
        object CheckBox23: TCheckBox
          Left = 24
          Top = 25
          Width = 105
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Groups visible:'
          TabOrder = 0
          OnClick = CheckBox23Click
        end
      end
      object GroupBox44: TGroupBox
        Left = 256
        Top = 95
        Width = 345
        Height = 258
        Caption = 'Appearance'
        Enabled = False
        TabOrder = 2
        object lblLineType: TLabel
          Left = 24
          Top = 31
          Width = 48
          Height = 13
          Caption = 'Line type:'
        end
        object lblLineColor: TLabel
          Left = 24
          Top = 58
          Width = 49
          Height = 13
          Caption = 'Line color:'
        end
        object lblStartIndex: TLabel
          Left = 24
          Top = 85
          Width = 57
          Height = 13
          Caption = 'Start index:'
        end
        object lblEndIndex: TLabel
          Left = 24
          Top = 112
          Width = 51
          Height = 13
          Caption = 'End index:'
        end
        object lblCaption: TLabel
          Left = 24
          Top = 170
          Width = 41
          Height = 13
          Caption = 'Caption:'
        end
        object lblFontPreview: TLabel
          Tag = 198
          Left = 157
          Top = 198
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object Label73: TLabel
          Left = 24
          Top = 197
          Width = 26
          Height = 13
          Caption = 'Font:'
        end
        object Label69: TLabel
          Left = 24
          Top = 222
          Width = 29
          Height = 13
          Caption = 'Level:'
        end
        object chkVisible: TCheckBox
          Left = 24
          Top = 138
          Width = 105
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Visible:'
          TabOrder = 0
          OnClick = chkVisibleClick
        end
        object spinStart: TAdvChartSpinEdit
          Left = 118
          Top = 82
          Width = 55
          Height = 22
          Value = 0
          DateValue = 42150.471738182870000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 1
          Visible = True
          Version = '1.6.2.3'
          OnChange = spinStartChange
        end
        object spinEnd: TAdvChartSpinEdit
          Left = 118
          Top = 109
          Width = 55
          Height = 22
          Value = 0
          DateValue = 42150.471738182870000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 2
          Visible = True
          Version = '1.6.2.3'
          OnChange = spinEndChange
        end
        object csLineColor: TAdvChartColorSelector
          Left = 118
          Top = 52
          Width = 128
          Height = 22
          TabOrder = 3
          AppearanceStyle = esXP
          Version = '1.3.5.0'
          SelectedColor = clNone
          ShowRGBHint = True
          AutoThemeAdapt = False
          BorderColor = 12164479
          BorderDownColor = 7021576
          BorderHotColor = 12164479
          BorderDropDownColor = 12164479
          Caption = ''
          Color = clBtnFace
          ColorDown = 11900292
          ColorHot = 14073525
          ColorDropDown = 16251129
          ColorSelected = 14604246
          ColorSelectedTo = clNone
          Style = ssCombo
          Tools = <
            item
              Caption = 'None'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'None'
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Color'
              ItemType = itFullWidthButton
            end>
          OnSelect = csLineColorSelect
        end
        object cboLinetype: TComboBox
          Left = 118
          Top = 25
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 4
          OnChange = cboLinetypeChange
          Items.Strings = (
            'Vertical'
            'Vertical line'
            'Wrap'
            'Custom')
        end
        object txtCaption: TEdit
          Left = 118
          Top = 167
          Width = 147
          Height = 21
          TabOrder = 5
          OnChange = txtCaptionChange
        end
        object Button20: TButton
          Left = 118
          Top = 196
          Width = 32
          Height = 17
          Caption = '...'
          TabOrder = 6
          OnClick = Button20Click
        end
        object AdvChartSpinEdit25: TAdvChartSpinEdit
          Left = 118
          Top = 219
          Width = 55
          Height = 22
          Value = 0
          DateValue = 42150.471738206020000000
          HexValue = 0
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 7
          Visible = True
          Version = '1.6.2.3'
          OnChange = AdvChartSpinEdit25Change
        end
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 507
    Width = 756
    Height = 25
    Align = alBottom
    TabOrder = 2
    object Button15: TButton
      Left = 530
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Ok'
      Default = True
      TabOrder = 0
      OnClick = Button15Click
    end
    object Button16: TButton
      Left = 605
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = Button16Click
    end
    object Button18: TButton
      Left = 680
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 2
      OnClick = Button18Click
    end
  end
  object ListBox1: TCheckListBox
    Left = -1
    Top = 20
    Width = 138
    Height = 486
    OnClickCheck = ListBox1ClickCheck
    Align = alCustom
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 3
    OnClick = ListBox1Click
    OnDblClick = ListBox1DblClick
    OnDragDrop = ListBox1DragDrop
    OnDragOver = ListBox1DragOver
    OnMouseDown = ListBox1MouseDown
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 8
    Top = 464
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 40
    Top = 464
  end
  object ColorDialog1: TColorDialog
    Left = 72
    Top = 464
  end
end
