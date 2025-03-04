@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.c"
if not exist hex2mif.exe goto done
if exist Lab5.ihx hex2mif Lab5.ihx
if exist Lab5.hex hex2mif Lab5.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\wongh\OneDrive - UBC\UBC\Year 2\ELEC 291\ELEC-291\Lab5\Lab5.hex
