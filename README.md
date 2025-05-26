# Get All Product Subscriptions in Azure API Management (APIM)

This PowerShell script retrieves a list of all API Management products and their subscriptions across your Azure APIM instance. It also enriches each subscription with user details (e.g., email, name, user ID) and exports the result to a CSV file.

## 📌 Features

- Fetches all APIM products in a specified instance
- Lists all subscriptions under each product
- Extracts user details tied to each subscription
- Outputs a clean CSV with:
  - Product ID
  - Subscription ID & Name
  - State
  - User info
  - Created date

## 🧠 Use Case

Ideal for platform engineers and governance teams managing Azure API Management. Helps with:

- Auditing subscriptions
- Analyzing user access
- Validating governance rules (e.g., product visibility, subscription hygiene)

## 🚀 How to Use

1. Clone this repository or download the `.ps1` file.
2. Fill in the required configuration section in the script:
   - Azure `tenantId`
   - Azure App Registration `clientId` and `clientSecret`
   - Azure subscription ID
   - APIM resource group and service name

```powershell
$tenantId     = "<your-tenant-id>"
$appId        = "<your-client-id>"
$clientSecret = "<your-client-secret>"
$subscriptionId = "<your-subscription-id>"
$resourceGroupName = "<your-resource-group>"
$apimServiceName = "<your-apim-name>"
