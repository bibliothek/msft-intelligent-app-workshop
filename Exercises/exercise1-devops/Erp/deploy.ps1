# Check if user is already signed in
$context = Get-AzureRmContext | Out-Null
if (!$context.SubscriptionName) {
    Login-AzureRmAccount
}

# Select subscription where name contains `MSDN Subscription`
Get-AzureRmSubscription | where { $_.Name -like "*Visual*" } | Select-AzureRmSubscription

# Set some string constants
$rg = "intel-app-workshop2"
$location = "westeurope"
$dep = "Deployment-" + [guid]::NewGuid()
$path = "C:\Users\TTraining\Desktop\msft-intelligent-app-workshop\Exercises\exercise1-devops\"
$dbAdminUser = "demo"

# Check if resource group already exists
$group = Get-AzureRmResourceGroup -Name $rg -ErrorAction SilentlyContinue
if (!$group) {
    New-AzureRmResourceGroup -Name $rg -Location $location
}

# Deploy ARM template
New-AzureRmResourceGroupDeployment -ResourceGroupName $rg -TemplateFile "$path\erp.json" `
    -Name $dep -dbAdminUser $dbAdminUser -dbAdminPassword (Get-Credential).Password