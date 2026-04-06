$key = New-Object Byte[] 32
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($key)
$key | Out-File "D:\vbdia\Documents\Projects\MS-Exchange-Utilities\Security\Secret\file.key"