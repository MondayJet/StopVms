try
{
    "Logging in to Azure..."
    Connect-AzAccount -Identity
}
catch {
    Write-Error -Message $_.Exception
    throw $_.Exception
}


# Define a dictionary with resource groups and VMs
$vmDictionary = @{
    "stag_RG" = @("Vm1", "Vm2", "Vm3", "Vm4")
    "TEST_RG" = @("Vm1", "Vm2", "Vm3", "Vm4")
    "Prod_RG" = @("Vm1", "Vm2", "Vm3", "Vm4")
}



# Function to stop VMs
function Stop-VMs {
    param (
        [string]$ResourceGroup,
        [string]$VMName
    )

    Write-Output "Stopping VM: $VMName in Resource Group: $ResourceGroup"
    Stop-AzVM -ResourceGroupName $ResourceGroup -Name $VMName -Force
}

# Loop through the dictionary and perform actions
foreach ($entry in $vmDictionary.GetEnumerator()) {
    $resourceGroup = $entry.Key
    $vms = $entry.Value

    foreach ($vm in $vms) {
        # Stop VM
        Stop-VMs -ResourceGroup $resourceGroup -VMName $vm
    }
}
