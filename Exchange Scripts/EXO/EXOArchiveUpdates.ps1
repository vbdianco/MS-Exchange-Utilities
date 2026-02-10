$filePath = Read-Host -Prompt "Please enter the Mailbox csv file path"
Write-Host "You entered: $filePath"

if (Test-Path $filePath){
	$mailboxes = Import-Csv -Path $filePath
} else {
	Write-Host "Error: The specified path does not exist"
}

foreach ($mailbox in $mailboxes){
	Write-Host "Enabling Mailbox Archive for $mailbox.mailbox"
	Enable-Mailbox -Identity $mailbox.mailbox -Archive
	Write-Host "Setting Mailbox retention Policy to 3 Months Archive for $mailbox.mailbox"
	Set-Mailbox -Identity $mailbox.mailbox -RetentionPolicy "3 Months Archive"
}