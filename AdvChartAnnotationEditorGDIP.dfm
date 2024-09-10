object AdvChartAnnotationsEditorFormGDIP: TAdvChartAnnotationsEditorFormGDIP
  Left = 736
  Top = 270
  BorderStyle = bsDialog
  Caption = 'Chart Annotations Editor'
  ClientHeight = 531
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
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = -1
    Width = 185
    Height = 41
    TabOrder = 0
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
    object SpeedButton3: TSpeedButton
      Left = 46
      Top = 0
      Width = 23
      Height = 22
      Cursor = crHandPoint
      Hint = 'Change pane name'
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
  end
  object Panel3: TPanel
    Left = 137
    Top = 0
    Width = 619
    Height = 506
    Align = alCustom
    Caption = 'Choose Annotation'
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
    ActivePage = TabSheet8
    Align = alCustom
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Visible = False
    object TabSheet8: TTabSheet
      Caption = 'Annotations'
      ImageIndex = 7
      object GroupBox26: TGroupBox
        Left = 3
        Top = 3
        Width = 598
        Height = 473
        Caption = 'Appearance'
        TabOrder = 0
        object Label102: TLabel
          Left = 14
          Top = 251
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
          Left = 14
          Top = 278
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
        object Label104: TLabel
          Left = 14
          Top = 304
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
        object Label105: TLabel
          Left = 14
          Top = 384
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
        object Label108: TLabel
          Left = 14
          Top = 408
          Width = 35
          Height = 13
          Caption = 'Height:'
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
        object Label111: TLabel
          Left = 14
          Top = 436
          Width = 32
          Height = 13
          Caption = 'Width:'
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
        object Label112: TLabel
          Left = 14
          Top = 225
          Width = 34
          Height = 13
          Caption = 'Shape:'
        end
        object Label1: TLabel
          Left = 14
          Top = 332
          Width = 49
          Height = 13
          Caption = 'Line color:'
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
          Left = 14
          Top = 356
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
        object Label4: TLabel
          Left = 14
          Top = 22
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
        object Label133: TLabel
          Left = 296
          Top = 18
          Width = 50
          Height = 13
          Caption = 'Opacity 1:'
        end
        object Label134: TLabel
          Left = 296
          Top = 49
          Width = 50
          Height = 13
          Caption = 'Opacity 2:'
        end
        object Label5: TLabel
          Left = 14
          Top = 48
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
          Left = 14
          Top = 78
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
          Left = 14
          Top = 105
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
          Left = 14
          Top = 137
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
        object Label7: TLabel
          Tag = 384
          Left = 171
          Top = 384
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object GroupBox28: TGroupBox
          Left = 295
          Top = 246
          Width = 297
          Height = 117
          Caption = 'Content'
          TabOrder = 21
          object Label13: TLabel
            Left = 16
            Top = 19
            Width = 101
            Height = 13
            Caption = 'Horizontal alignment:'
          end
          object Label14: TLabel
            Left = 16
            Top = 46
            Width = 88
            Height = 13
            Caption = 'Vertical alignment:'
          end
          object Label31: TLabel
            Left = 16
            Top = 73
            Width = 26
            Height = 13
            Caption = 'Text:'
          end
          object ComboBox11: TComboBox
            Left = 136
            Top = 16
            Width = 145
            Height = 21
            Style = csDropDownList
            TabOrder = 0
            OnChange = ComboBox11Change
            Items.Strings = (
              'Left'
              'Right'
              'Center')
          end
          object ComboBox12: TComboBox
            Left = 136
            Top = 43
            Width = 145
            Height = 21
            Style = csDropDownList
            TabOrder = 1
            OnChange = ComboBox12Change
            Items.Strings = (
              'Top'
              'Bottom'
              'Center')
          end
          object Edit2: TEdit
            Left = 136
            Top = 70
            Width = 145
            Height = 21
            TabOrder = 2
            OnChange = Edit2Change
          end
          object CheckBox8: TCheckBox
            Left = 16
            Top = 92
            Width = 265
            Height = 17
            Alignment = taLeftJustify
            BiDiMode = bdLeftToRight
            Caption = 'Word wrap:'
            ParentBiDiMode = False
            TabOrder = 3
            OnClick = CheckBox8Click
          end
        end
        object GroupBox29: TGroupBox
          Left = 295
          Top = 71
          Width = 297
          Height = 105
          Caption = 'Arrow'
          TabOrder = 19
          object Label35: TLabel
            Left = 16
            Top = 19
            Width = 28
            Height = 13
            Caption = 'Type:'
          end
          object Label75: TLabel
            Left = 16
            Top = 46
            Width = 23
            Height = 13
            Caption = 'Size:'
          end
          object Label3: TLabel
            Left = 16
            Top = 76
            Width = 49
            Height = 13
            Caption = 'Line color:'
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
          object ComboBox14: TComboBox
            Left = 136
            Top = 16
            Width = 145
            Height = 21
            Style = csDropDownList
            TabOrder = 0
            OnChange = ComboBox14Change
            Items.Strings = (
              'Line'
              'StartArrow'
              'EndArrow'
              'DoubleArrow')
          end
          object SpinEdit22: TAdvChartSpinEdit
            Left = 136
            Top = 43
            Width = 145
            Height = 22
            Value = 0
            DateValue = 41236.464895625000000000
            HexValue = 0
            Enabled = True
            IncrementFloat = 0.100000000000000000
            IncrementFloatPage = 1.000000000000000000
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'Tahoma'
            LabelFont.Style = []
            TabOrder = 1
            Visible = True
            Version = '1.0.0.0'
            OnChange = SpinEdit22Change
          end
          object AdvChartColorSelector2: TAdvChartColorSelector
            Left = 138
            Top = 70
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
            OnSelect = AdvChartColorSelector2Select
          end
        end
        object CheckBox7: TCheckBox
          Left = 14
          Top = 203
          Width = 129
          Height = 17
          Alignment = taLeftJustify
          BiDiMode = bdLeftToRight
          Caption = 'Auto size:'
          ParentBiDiMode = False
          TabOrder = 7
          OnClick = CheckBox7Click
        end
        object GroupBox30: TGroupBox
          Left = 295
          Top = 175
          Width = 297
          Height = 72
          Caption = 'Balloon'
          TabOrder = 20
          object Label79: TLabel
            Left = 16
            Top = 19
            Width = 46
            Height = 13
            Caption = 'Direction:'
          end
          object Label83: TLabel
            Left = 16
            Top = 46
            Width = 54
            Height = 13
            Caption = 'Arrow size:'
          end
          object ComboBox16: TComboBox
            Left = 136
            Top = 14
            Width = 145
            Height = 21
            Style = csDropDownList
            TabOrder = 0
            OnChange = ComboBox16Change
            Items.Strings = (
              'Up Right'
              'Up Left'
              'Down Right'
              'Down Left')
          end
          object SpinEdit24: TAdvChartSpinEdit
            Left = 136
            Top = 41
            Width = 145
            Height = 22
            Value = 0
            DateValue = 41236.464895636570000000
            HexValue = 0
            Enabled = True
            IncrementFloat = 0.100000000000000000
            IncrementFloatPage = 1.000000000000000000
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'Tahoma'
            LabelFont.Style = []
            TabOrder = 1
            Visible = True
            Version = '1.0.0.0'
            OnChange = SpinEdit24Change
          end
        end
        object AdvChartColorSelector6: TAdvChartColorSelector
          Left = 133
          Top = 248
          Width = 128
          Height = 22
          TabOrder = 9
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
        object SpinEdit30: TAdvChartSpinEdit
          Left = 133
          Top = 299
          Width = 38
          Height = 22
          Value = 0
          DateValue = 41236.464895648150000000
          HexValue = 0
          Enabled = True
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 11
          Visible = True
          Version = '1.0.0.0'
          OnChange = SpinEdit30Change
        end
        object SpinEdit35: TAdvChartSpinEdit
          Left = 133
          Top = 273
          Width = 38
          Height = 22
          Value = 0
          DateValue = 41236.464895659720000000
          HexValue = 0
          Enabled = True
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 10
          Visible = True
          Version = '1.0.0.0'
          OnChange = SpinEdit35Change
        end
        object Button1: TButton
          Left = 133
          Top = 383
          Width = 32
          Height = 17
          Caption = '...'
          TabOrder = 14
          OnClick = Button1Click
        end
        object SpinEdit37: TAdvChartSpinEdit
          Left = 133
          Top = 405
          Width = 38
          Height = 22
          Value = 0
          DateValue = 41236.464895659720000000
          HexValue = 0
          Enabled = True
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 15
          Visible = True
          Version = '1.0.0.0'
          OnChange = SpinEdit37Change
        end
        object GroupBox31: TGroupBox
          Left = 295
          Top = 363
          Width = 297
          Height = 55
          Caption = 'Offset'
          TabOrder = 22
          object Label109: TLabel
            Left = 16
            Top = 22
            Width = 10
            Height = 13
            Caption = 'X:'
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
          object Label110: TLabel
            Left = 152
            Top = 22
            Width = 10
            Height = 13
            Caption = 'Y:'
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
          object SpinEdit38: TAdvChartSpinEdit
            Left = 85
            Top = 18
            Width = 38
            Height = 22
            Value = 0
            DateValue = 41236.464895671300000000
            HexValue = 0
            Enabled = True
            IncrementFloat = 0.100000000000000000
            IncrementFloatPage = 1.000000000000000000
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'Tahoma'
            LabelFont.Style = []
            TabOrder = 0
            Visible = True
            Version = '1.0.0.0'
            OnChange = SpinEdit38Change
          end
          object SpinEdit39: TAdvChartSpinEdit
            Left = 221
            Top = 19
            Width = 38
            Height = 22
            Value = 0
            DateValue = 41236.464895671300000000
            HexValue = 0
            Enabled = True
            IncrementFloat = 0.100000000000000000
            IncrementFloatPage = 1.000000000000000000
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'Tahoma'
            LabelFont.Style = []
            TabOrder = 1
            Visible = True
            Version = '1.0.0.0'
            OnChange = SpinEdit39Change
          end
        end
        object SpinEdit40: TAdvChartSpinEdit
          Left = 133
          Top = 433
          Width = 38
          Height = 22
          Value = 0
          DateValue = 41236.464895682870000000
          HexValue = 0
          Enabled = True
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 16
          Visible = True
          Version = '1.0.0.0'
          OnChange = SpinEdit40Change
        end
        object ComboBox19: TComboBox
          Left = 133
          Top = 222
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 8
          OnChange = ComboBox19Change
          Items.Strings = (
            'Rectangle'
            'Circle'
            'RoundRect'
            'Balloon'
            'Line')
        end
        object CheckBox9: TCheckBox
          Left = 14
          Top = 182
          Width = 129
          Height = 17
          Alignment = taLeftJustify
          BiDiMode = bdLeftToRight
          Caption = 'Visible:'
          ParentBiDiMode = False
          TabOrder = 6
          OnClick = CheckBox9Click
        end
        object SpinEdit1: TAdvChartSpinEdit
          Left = 133
          Top = 354
          Width = 38
          Height = 22
          Value = 0
          DateValue = 41236.464895694440000000
          HexValue = 0
          Enabled = True
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 13
          Visible = True
          Version = '1.0.0.0'
          OnChange = SpinEdit1Change
        end
        object AdvChartColorSelector1: TAdvChartColorSelector
          Left = 133
          Top = 326
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
          OnSelect = AdvChartColorSelector1Select
        end
        object AdvChartColorSelector3: TAdvChartColorSelector
          Left = 134
          Top = 15
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
          Left = 134
          Top = 43
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
        object AdvChartSpinEdit3: TAdvChartSpinEdit
          Left = 412
          Top = 43
          Width = 44
          Height = 22
          Value = 0
          DateValue = 41236.464895717600000000
          HexValue = 0
          Enabled = True
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 18
          Visible = True
          Version = '1.0.0.0'
          OnChange = AdvChartSpinEdit3Change
        end
        object AdvChartSpinEdit4: TAdvChartSpinEdit
          Left = 412
          Top = 15
          Width = 44
          Height = 22
          Value = 0
          DateValue = 41236.464895717600000000
          HexValue = 0
          Enabled = True
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 17
          Visible = True
          Version = '1.0.0.0'
          OnChange = AdvChartSpinEdit4Change
        end
        object ComboBox3: TComboBox
          Left = 134
          Top = 75
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
          Left = 134
          Top = 102
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
          Left = 134
          Top = 134
          Width = 66
          Height = 22
          Value = 0
          DateValue = 41236.464895763890000000
          HexValue = 0
          Enabled = True
          IncrementFloat = 0.100000000000000000
          IncrementFloatPage = 1.000000000000000000
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          TabOrder = 4
          Visible = True
          Version = '1.0.0.0'
          OnChange = AdvChartSpinEdit2Change
        end
        object CheckBox29: TCheckBox
          Left = 14
          Top = 162
          Width = 129
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Shadow:'
          TabOrder = 5
          OnClick = CheckBox29Click
        end
        object GroupBox1: TGroupBox
          Left = 295
          Top = 418
          Width = 297
          Height = 52
          Caption = 'Point'
          TabOrder = 23
          object Label6: TLabel
            Left = 13
            Top = 22
            Width = 32
            Height = 13
            Caption = 'Index:'
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
          object AdvChartSpinEdit1: TAdvChartSpinEdit
            Left = 85
            Top = 18
            Width = 38
            Height = 22
            Value = 0
            DateValue = 41236.464895775460000000
            HexValue = 0
            Enabled = True
            IncrementFloat = 0.100000000000000000
            IncrementFloatPage = 1.000000000000000000
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'Tahoma'
            LabelFont.Style = []
            TabOrder = 0
            Visible = True
            Version = '1.0.0.0'
            OnChange = AdvChartSpinEdit1Change
          end
        end
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 506
    Width = 756
    Height = 25
    Align = alBottom
    TabOrder = 3
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
    object Button2: TButton
      Left = 680
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object ListBox1: TListBox
    Left = -1
    Top = 20
    Width = 138
    Height = 486
    Align = alCustom
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 4
    OnClick = ListBox1Click
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 8
    Top = 312
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 40
    Top = 312
  end
  object ColorDialog1: TColorDialog
    Left = 72
    Top = 312
  end
end
