
$resultFilePath = "Shared Folder Path" 
$filePath = Read-Host -Prompt "Please enter the Mailbox csv file path"
Write-Host "You entered: $filePath"

if (Test-Path $filePath){
    $mailboxes = Import-Csv -Path $filePath
    if (Test-Path $resultFilePath){
        Remove-Item -Path $resultFilePath
    }
}else{
    Write-Host "Error: The specified path does not exist."
}
foreach ($mailbox in $mailboxes){
    $dataMB = Get-EXOCasMailbox -Identity $mailbox.mailbox
    New-Object -TypeName psobject -Property @{
        EMAILADDRESS = "$($dataMB.PrimarySMTPAddress)"
    }| Export-Csv -Path $resultFilePath -NoTypeInformation -Force -Append 
}