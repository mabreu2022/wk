object DataModule1: TDataModule1
  Height = 205
  Width = 340
  PixelsPerInch = 120
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=postgres'
      'Password=123'
      'User_Name=postgres'
      'Server=localhost'
      'DriverID=PG')
    LoginPrompt = False
    Left = 157
    Top = 8
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\TESTE WKTecnologia\Win32\Debug\libpq.dll'
    Left = 157
    Top = 94
  end
end
