Write-Host "#########################################################"
Write-Host "                                                         "
Write-Host "    This will Check if a set of mailbox exists in EXO."
Write-Host "                                                         "
Write-Host "#########################################################"
Write-Host "                                                         "

$filePath = Read-Host -Prompt "Please enter the Mailbox csv file path"
Write-Host "You entered: $filePath"

if (Test-Path $filePath){
    $mailboxes = Import-Csv -Path $filePath
} else {
    Write-Host "Error: The specified path does not exist."    
}

foreach ($mailbox in $mailboxes){
    $exists = Get-EXOMailbox -Identity $mailbox.mailbox -ErrorAction Stop
}