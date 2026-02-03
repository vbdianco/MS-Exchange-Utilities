$filePath = Read-Host -Prompt "Please enter the Mailbox csv file path"
Write-Host "You entered: $filePath"

foreach ($mailbox in $mailboxes){
    $dataMB = Get-EXOCasMailbox -Identity $mailbox.mailbox | Select-Object DisplayName, RecipientTypeDetails, PrimarySmtpAddress
    $dataMB | Export-Csv -Path "G:\usrMigration.csv" -Force -Append -NoTypeInformation
}