object Form825: TForm825
  Left = 0
  Top = 0
  Caption = 'TMS Advanced Charts 3D Pie'
  ClientHeight = 678
  ClientWidth = 1092
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 203
    Height = 678
    Align = alLeft
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 10
      Top = 37
      Width = 185
      Height = 124
      Caption = 'Rotation'
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 24
        Width = 10
        Height = 13
        Caption = 'X:'
      end
      object Label2: TLabel
        Left = 16
        Top = 55
        Width = 10
        Height = 13
        Caption = 'Y:'
      end
      object Label3: TLabel
        Left = 16
        Top = 86
        Width = 10
        Height = 13
        Caption = 'Z:'
      end
      object TrackBar1: TTrackBar
        Left = 35
        Top = 19
        Width = 150
        Height = 25
        Max = 360
        Min = -360
        TabOrder = 0
        OnChange = TrackBar1Change
      end
      object TrackBar2: TTrackBar
        Left = 35
        Top = 50
        Width = 150
        Height = 25
        Max = 360
        Min = -360
        TabOrder = 1
        OnChange = TrackBar2Change
      end
      object TrackBar3: TTrackBar
        Left = 35
        Top = 81
        Width = 150
        Height = 25
        Max = 360
        Min = -360
        TabOrder = 2
        OnChange = TrackBar3Change
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 167
      Width = 187
      Height = 154
      Caption = 'Appearance'
      TabOrder = 1
      object Label7: TLabel
        Left = 18
        Top = 93
        Width = 70
        Height = 13
        Caption = 'Transparency:'
      end
      object CheckBox1: TCheckBox
        Left = 18
        Top = 24
        Width = 151
        Height = 17
        Caption = 'Anti-Alias'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = CheckBox1Click
      end
      object CheckBox3: TCheckBox
        Left = 18
        Top = 47
        Width = 151
        Height = 17
        Caption = 'Show Values'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = CheckBox3Click
      end
      object CheckBox4: TCheckBox
        Left = 18
        Top = 70
        Width = 151
        Height = 17
        Caption = 'Show Images'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = CheckBox4Click
      end
      object TrackBar7: TTrackBar
        Left = 26
        Top = 112
        Width = 151
        Height = 25
        Max = 255
        TabOrder = 3
        OnChange = TrackBar7Change
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 326
      Width = 187
      Height = 211
      Caption = 'Layout'
      TabOrder = 2
      object Label4: TLabel
        Left = 18
        Top = 53
        Width = 53
        Height = 13
        Caption = 'Extraction:'
      end
      object Label5: TLabel
        Left = 18
        Top = 104
        Width = 48
        Height = 13
        Caption = 'Elevation:'
      end
      object Label6: TLabel
        Left = 18
        Top = 157
        Width = 33
        Height = 13
        Caption = 'Depth:'
      end
      object CheckBox2: TCheckBox
        Left = 18
        Top = 23
        Width = 151
        Height = 17
        Caption = 'AutoSize'
        TabOrder = 0
        OnClick = CheckBox2Click
      end
      object TrackBar4: TTrackBar
        Left = 26
        Top = 123
        Width = 151
        Height = 25
        Max = 200
        Min = -200
        TabOrder = 1
        OnChange = TrackBar4Change
      end
      object TrackBar5: TTrackBar
        Left = 26
        Top = 72
        Width = 151
        Height = 25
        Max = 200
        TabOrder = 2
        OnChange = TrackBar5Change
      end
      object TrackBar6: TTrackBar
        Left = 26
        Top = 176
        Width = 151
        Height = 25
        Max = 200
        TabOrder = 3
        OnChange = TrackBar6Change
      end
    end
    object GroupBox4: TGroupBox
      Left = 10
      Top = 543
      Width = 187
      Height = 66
      Caption = 'Interaction'
      TabOrder = 3
      object CheckBox5: TCheckBox
        Left = 18
        Top = 25
        Width = 70
        Height = 17
        Caption = 'Enabled'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = CheckBox5Click
      end
      object Button2: TButton
        Left = 94
        Top = 21
        Width = 75
        Height = 25
        Caption = 'How To ?'
        TabOrder = 1
        OnClick = Button2Click
      end
    end
    object Button3: TButton
      Left = 10
      Top = 6
      Width = 135
      Height = 25
      Caption = 'Random Values / Colors'
      TabOrder = 4
      OnClick = Button3Click
    end
    object Button1: TButton
      Left = 10
      Top = 615
      Width = 187
      Height = 25
      Caption = 'Reset Pie Chart to Default'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button4: TButton
      Left = 10
      Top = 643
      Width = 187
      Height = 25
      Caption = 'Save To Image'
      TabOrder = 6
      OnClick = Button4Click
    end
  end
  object AdvChartView3D1: TAdvChartView3D
    Left = 203
    Top = 0
    Width = 889
    Height = 678
    Align = alClient
    TabOrder = 1
    Color = 16118513
    Series = <
      item
        Legend.CaptionFont.Charset = DEFAULT_CHARSET
        Legend.CaptionFont.Color = clWindowText
        Legend.CaptionFont.Height = -11
        Legend.CaptionFont.Name = 'Tahoma'
        Legend.CaptionFont.Style = []
        Legend.ItemsFont.Charset = DEFAULT_CHARSET
        Legend.ItemsFont.Color = clWindowText
        Legend.ItemsFont.Height = -11
        Legend.ItemsFont.Name = 'Tahoma'
        Legend.ItemsFont.Style = []
        Legend.CaptionAlignment = taLeft
        Values.ImagePosition = ipTopRight
        Values.CaptionsFont.Charset = DEFAULT_CHARSET
        Values.CaptionsFont.Color = clWindowText
        Values.CaptionsFont.Height = -11
        Values.CaptionsFont.Name = 'Tahoma'
        Values.CaptionsFont.Style = []
        Values.ValuesFont.Charset = DEFAULT_CHARSET
        Values.ValuesFont.Color = clWindowText
        Values.ValuesFont.Height = -11
        Values.ValuesFont.Name = 'Tahoma'
        Values.ValuesFont.Style = []
        Values.ValueFormat = '%.0f'
        Items = <
          item
            Caption = 'Value 0'
            Color = 356091
            Value = 68.000000000000000000
          end
          item
            Caption = 'Value 1'
            Color = 10053120
            Value = 82.000000000000000000
          end
          item
            Caption = 'Value 2'
            Color = 3407718
            Value = 67.000000000000000000
          end
          item
            Caption = 'Value 3'
            Color = 3342540
            Value = 60.000000000000000000
          end
          item
            Caption = 'Value 4'
            Color = 16121840
            Value = 71.000000000000000000
          end
          item
            Caption = 'Value 5'
            Color = 16763904
            Value = 66.000000000000000000
          end>
        Depth = 40.000000000000000000
        Size = 300.000000000000000000
        Caption = 'Chart Serie 3D'
        XRotation = -55.000000000000000000
      end>
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clWindowText
    Title.Font.Height = -16
    Title.Font.Name = 'Tahoma'
    Title.Font.Style = []
    Title.Text = 'AdvChartView 3D'
    Version = '1.0.0.0 Feb, 2013'
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 208
    Top = 624
  end
end
