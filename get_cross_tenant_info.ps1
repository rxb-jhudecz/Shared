[CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$externalTenantID
    )


if (-not (Get-InstalledModule -Name Microsoft.Graph -ErrorAction SilentlyContinue)) {
    Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force
} 

Connect-MgGraph -Scopes "Policy.Read.All"
$info = Get-MgPolicyCrossTenantAccessPolicyPartner -CrossTenantAccessPolicyConfigurationPartnerTenantId $externalTenantID

$inboundcollabapp = $info.B2BCollaborationInbound.Applications
$inboundcollabusers = $info.B2BCollaborationInbound.UsersAndGroups
$inboundcollabusertargets = $info.B2BCollaborationInbound.UsersAndGroups.Targets

$outboundcollabapp = $info.B2BCollaborationOutbound.Applications
$outboundcollabusers =$info.B2BCollaborationOutbound.UsersAndGroups
$outboundcollabusertargets =$info.B2BCollaborationOutbound.UsersAndGroups.Targets

$inbounddirectapp = $info.B2BDirectConnectInbound.Applications
$inbounddirectusers = $info.B2BDirectConnectInbound.UsersAndGroups
$inbounddirectusertargets = $info.B2BDirectConnectInbound.UsersAndGroups.Targets

$outbounddirectapp = $info.B2BDirectConnectOutbound.Applications
$outbounddirectusers = $info.B2BDirectConnectOutbound.UsersAndGroups
$outbounddirectusertargets = $info.B2BDirectConnectOutbound.UsersAndGroups.Targets


cls
Write-host '============ Inbound Collaboration ============' -ForegroundColor Blue
Write-host 'Application Access:' $inboundcollabapp.AccessType 
write-host 'User Access:' $inboundcollabusers.AccessType
Write-Host "Targets: $($inboundcollabusertargets.target -join ', ')"
Write-Host "Target Types: $($inboundcollabusertargets.TargetType -join ', ')"

Write-Output ''
Write-Output ''

Write-Host '============ Outbound Collaboration ============' -ForegroundColor Blue
Write-host 'Application Access:' $outboundcollabapp.AccessType
write-host 'User Access:' $outboundcollabusers.AccessType
Write-Host "Targets: $($outboundcollabusertargets.target -join ', ')"
Write-Host "Target Types: $($outboundcollabusertargets.TargetType -join ', ')"

Write-Output ''
Write-Output ''
Write-Output ''

Write-host '============ Inbound Direct ============' -ForegroundColor Cyan
Write-host 'Application Access:' $inbounddirectapp.AccessType 
write-host 'User Access:' $inbounddirectusers.AccessType
Write-Host "Targets: $($inbounddirectusertargets.target -join ', ')"
Write-Host "Target Types: $($inbounddirectusertargets.TargetType -join ', ')"

Write-Output ''
Write-Output ''

Write-Host '============ Outbound Direct ============' -ForegroundColor Cyan
Write-host 'Application Access:' $outbounddirectapp.AccessType
write-host 'User Access:' $outbounddirectusers.AccessType
Write-Host "Targets: $($outbounddirectusertargets.target -join ', ')"
Write-Host "Target Types: $($outbounddirectusertargets.TargetType -join ', ')"

