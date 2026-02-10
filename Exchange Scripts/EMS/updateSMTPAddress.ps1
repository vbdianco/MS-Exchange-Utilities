$emails = @('@okdmnl.mail.onmicrosoft.com', '@okdmnl.onmicrosoft.com')
$filePath = Read-Host -Prompt "Please enter the Mailbox csv file path"
Write-Host "You entered: $filePath"

if (Test-Path $filePath){
	$mailboxes = Import-Csv -Path $filePath
} else {
	Write-Host "Error: The specified path does not exist"
}

foreach ($mailbox in $mailboxes){
	$dataMB = Get-Mailbox -Identity $mailbox.mailbox
	$addressToRemove = $dataMB.emailaddresses | Where-Object { $_ -notlike "*@okadamanila.com" -and $_ -like "smtp:*" }
	
	if ($addressToRemove) {
		foreach($address in $addressToRemove) {
			Write-Host "Removing address: $address" 		
			Set-Mailbox -Identity $dataMB.DisplayName -emailaddresses @{remove=$address}
		}
	} else {
		Write-Host "No address found to remove for this mailbox."
	}

	$usrEmail = $dataMB.PrimarySmtpAddress | ForEach-Object {$_.split('@')[0]}
	foreach ($email in $emails){
		Write-Host "Adding address: $usrEmail$email" 
		Set-Mailbox -Identity $dataMB.DisplayName -emailaddresses @{add=$usrEmail + $email}
	}
}