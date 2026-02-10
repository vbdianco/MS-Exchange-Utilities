$csvfilePath = "\\WIN-2019-EX-MB.zerocorp.local\Temp\mailboxpermissions.csv"
$filePath = Read-Host -Prompt "Please enter the mailbox csv file path"
Write-Host "You entered: $filePath"

if (Test-Path $filePath){
	$mailboxes = Import-Csv -Path $filePath
	if (Test-Path $csvfilePath){
		Remove-Item -Path $csvfilePath -Force
	}

} else {
	Write-Host "Error: The specified path does not exist."
}

if (Get-Command -Name Get-ExchangeServer -ErrorAction SilentlyContinue){	
	foreach ($mailbox in $mailboxes){ 
		$dataFullAccess = Get-MailboxPermission -Identity $mailbox.mailbox -ResultSize Unlimited | Where-Object {($_.IsInherited -eq $false) -and ($_.User -ne "NT AUTHORITY\SELF") -and ($_.AccessRights -like "FullAccess")} #| select Identity, User, AccessRights
		$dataSendAs = Get-ADPermission -Identity $mailbox.mailbox | Where-Object { $_.ExtendedRights -like "*send*" -and -not ($_.User -match "NT AUTHORITY") -and ($_.IsInherited -eq $false)} #| select Identity, User, ExtendedRights
		$dataSendOnBehalf = Get-Mailbox -Identity $mailbox.mailbox -filter('RecipientTypeDetails -eq "UserMailbox"') #| select-object Identity, GrantSendOnBehalfTo
		
		New-Object -TypeName PSObject -Property @{
			Mailbox = "$($mailbox.mailbox)"
			AccessRights = "$($dataFullAccess | ForEach-Object{
				"$($_.User) ($($_.AccessRights))"
			})"
			SendAs = "$($dataSendAs.User)"
			GrantSendOnBehalfTo = "$($dataSendOnBehalf.GrantSendOnBehalfTo)"
		} | Export-Csv -Path $csvfilePath -NoTypeInformation -Force -Append
	}
	$outputCsvFile = Get-ChildItem -Path $csvfilePath
	Write-Host "csv file has been created: $($outputCsvFile.FullName)"

} else {
			$exchangeSvr = Read-Host -Prompt "Enter your Exchange Server FQDN"
			$cred = Get-Credential -Message "Enter your Exchange Admin Credentials"
			
			$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://$exchangeSvr/PowerShell/ -Authentication Kerberos -Credential $cred 
			Import-PSSession $Session -DisableNameChecking

			foreach ($mailbox in $mailboxes){ 
				$dataFullAccess = Get-MailboxPermission -Identity $mailbox.mailbox -ResultSize Unlimited | Where-Object {($_.IsInherited -eq $false) -and ($_.User -ne "NT AUTHORITY\SELF") -and ($_.AccessRights -like "FullAccess")} #| select Identity, User, AccessRights
				$dataSendAs = Get-ADPermission -Identity $mailbox.mailbox | Where-Object { $_.ExtendedRights -like "*send*" -and -not ($_.User -match "NT AUTHORITY") -and ($_.IsInherited -eq $false)} #| select Identity, User, ExtendedRights
				$dataSendOnBehalf = Get-Mailbox -Identity $mailbox.mailbox -filter('RecipientTypeDetails -eq "UserMailbox"') #| select-object Identity, GrantSendOnBehalfTo
				
				New-Object -TypeName PSObject -Property @{
					Mailbox = "$($mailbox.mailbox)"
					AccessRights = "$($dataFullAccess | ForEach-Object{
						"$($_.User) ($($_.AccessRights))"
					})"
					SendAs = "$($dataSendAs.User)"
					GrantSendOnBehalfTo = "$($dataSendOnBehalf.GrantSendOnBehalfTo)"
				} | Export-Csv -Path $csvfilePath -NoTypeInformation -Force -Append
			}
			
			$outputCsvFile = Get-ChildItem -Path $csvfilePath
			Write-Host "csv file has been created: $($outputCsvFile.FullName)"
		
			Remove-PSSession $Session
}




