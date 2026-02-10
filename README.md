# MS-Exchange-Utilities

PowerShell Scripts for managing MS Exchange both On-Prem and Online. You can use these scripts to manage Exchange on-prem and online remotely.

Instructions:
1. Connect to Exchange by executing Connection scripts from the Conn folder. Open individual PowerShell instance for Exchange on-premises and Exchange online.

    EMSConn.ps1 - Used to connect to Exchange Management Shell on-premises.
    EXOConn.ps1 - Used to connect to Exchange Online Admin Center.

2. Exchange Management Shell on-premises scripts are located in the EMS folder with the following (Requires mailboxes.csv):
    
    mailboxperm.ps1 - Used to get list of users who have permissions to a mailbox.
    updateSMTPAddress.ps1 - Used to remove outdated SMTP addresses while retaining primary SMTP address domain and add new alternate SMTP addresses.
    usrMigration - Used to extract list of mailboxes and save as csv file for migrating to Exchange online.

3. Exchange Online scripts aare located in the EXO folder with the following (Requires mailboxes.csv):

    CheckEXOMailbox.ps1 - Used to check if mailbox is in Exchange online.
    EXOArchiveUpdates.ps1 - Used to enable Mailbox Archiving and update Retention Policy.