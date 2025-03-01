@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.c"
if not exist hex2mif.exe goto done
if exist PeriodEFM8.ihx hex2mif PeriodEFM8.ihx
if exist PeriodEFM8.hex hex2mif PeriodEFM8.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\Lab4\PeriodEFM8.hex
