# ============================
# Script: Get All Product Subscriptions in APIM
# Author: Meezan Khan
# ============================

Set-StrictMode -Version Latest

# ========== CONFIG ==========
$tenantId           = "<your-tenant-id>"
$appId              = "<your-client-id>"
$clientSecret       = "<your-client-secret>"
$subscriptionId     = "<your-azure-subscription-id>"
$resourceGroupName  = "<your-resource-group>"
$apimServiceName    = "<your-apim-instance-name>"

# ========== AUTH ==========
try {
    $secureSecret = ConvertTo-SecureString $clientSecret -AsPlainText -Force
    $credentials = New-Object System.Management.Automation.PSCredential($appId, $secureSecret)
    Connect-AzAccount -ServicePrincipal -TenantId $tenantId -Credential $credentials | Out-Null
    Write-Host "✅ Authenticated successfully" -ForegroundColor Green
} catch {
    Write-Error "❌ Authentication failed. $_"
    exit
}

# ========== MODULES ==========
Import-Module Az.Accounts
Import-Module Az.ApiManagement

# ========== SET CONTEXT ==========
Set-AzContext -SubscriptionId $subscriptionId | Out-Null
$context = New-AzApiManagementContext -ResourceGroupName $resourceGroupName -ServiceName $apimServiceName

# ========== FETCH DATA ==========
Write-Host "`n🔄 Fetching all products and subscriptions..." -ForegroundColor Cyan

$results = @()
$products = Get-AzApiManagementProduct -Context $context

foreach ($product in $products) {
    # Use ProductId or fallback to ID segment
    $productId = $product.ProductId
    if (-not $productId) {
        $productId = $product.Id.Split("/")[-1]
    }

    Write-Host "📦 Product: $productId" -ForegroundColor Yellow

    $subscriptions = Get-AzApiManagementSubscription -Context $context -ProductId $productId

    foreach ($sub in $subscriptions) {
        try {
            $userId = $sub.UserId.Split("/")[-1]
            $user = Get-AzApiManagementUser -Context $context -UserId $userId

            $results += [PSCustomObject]@{
                ProductId        = $productId
                SubscriptionName = $sub.Name
                SubscriptionId   = $sub.SubscriptionId
                State            = $sub.State
                UserName         = $user.FirstName + " " + $user.LastName
                UserEmail        = $user.Email
                UserId           = $userId
                CreatedDate      = $sub.CreatedDate
            }
        } catch {
            Write-Warning "⚠️ Could not resolve user info for subscription $($sub.SubscriptionId) in product $productId"
        }
    }
}

# ========== EXPORT ==========
$timestamp = Get-Date -Format "yyyy-MM-dd_HHmm"
$outputPath = ".\AllProductSubscriptions_$timestamp.csv"

$results | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

Write-Host "`n✅ Export completed: $outputPath" -ForegroundColor Green
