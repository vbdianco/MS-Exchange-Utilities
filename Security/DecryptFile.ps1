$EncryptedData = Get-Content "D:\vbdia\Documents\Projects\MS-Exchange-Utilities\Security\cred.txt"
$Key = Get-Content "D:\vbdia\Documents\Projects\MS-Exchange-Utilities\Security\Secret\file.key"
$SecureString = $EncryptedData | ConvertTo-SecureString -Key $Key

[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString))