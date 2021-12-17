#
# Script to set up static routes for M365 endpoints
# Eric Clark
# Last Update 12/16/21
# Script provided as-is
# M365 endponts listed at https://docs.microsoft.com/en-us/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide#exchange-online
#
# Make sure we have the latest Cohesity Module
echo "Updating Cohesity Powershell Module"
Update-Module -Name “Cohesity.PowerShell”

# Setup Cohesity Credentials
# Edit below with credentials for your environment
$username = "admin"
$password = "TechAccel1!"
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr

#Connect to the target cluster
Connect-CohesityCluster -Server 172.16.3.101 -Credential ($cred)
#
# List of endpoint ipv4 networks with duplicates removed 12/16/21
#
$gateway = '10.225.35.254'
$intfgrp = "intf_group1"
$networks = @('13.107.140.6/32',
# '13.107.136.0/22',
'13.107.18.10/31',
'13.107.18.15/32',
'13.107.6.152/31',
'13.107.6.171/32',
'131.253.33.215/32',
'132.245.0.0/16',
'132.245.0.0/16',
'150.171.32.0/22',
'150.171.40.0/22',
# '20.190.128.0/18',
'204.79.197.215/32',
'23.103.160.0/20',
'40.104.0.0/15',
'40.107.0.0/16',
'40.108.128.0/17',
'40.126.0.0/18',
'40.92.0.0/15',
'40.96.0.0/13',
'50.171.32.0/22',
'52.100.0.0/14',
'52.104.0.0/14',
'52.108.0.0/14',
'52.238.106.116/32',
'52.238.78.88/32',
'52.244.203.72/32',
'52.244.207.172/32',
'52.244.223.198/32',
'52.244.37.168/32',
# '52.96.0.0/14',
'52.247.150.191/32')

# Set the static routes

foreach ( $ip in $networks )
{
  New-CohesityRoutes -DestNetwork $ip -NextHop $gateway -InterfaceGroupName $intfgrp -Confirm:$false
}
