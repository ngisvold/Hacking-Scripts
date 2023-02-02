# Flush the DNS cache before securing host file.
Clear-DnsClientCache

# Variables to hold the path of the hosts file and the security descriptor
$hostsFile = "C:\Windows\System32\drivers\etc\hosts"
$securityDescriptor = "D:(A;OICI;GA;;;SY)(A;OICI;GA;;;BA)"

# Set the security descriptor on the hosts file
# This will deny write and modify permissions to all users except the system and backup operators
Set-Acl -Path $hostsFile -AclObject (Get-Acl -Path $hostsFile).SetSecurityDescriptorSddl($securityDescriptor, "None")

# Confirm the security descriptor was set successfully
if ((Get-Acl -Path $hostsFile).AccessToString -match "Deny.*WriteData") {
    Write-Output "The hosts file was successfully protected."
} else {
    Write-Output "The hosts file could not be protected."
}
