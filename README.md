# Azure APIM Product Subscription Export

![PowerShell](https://img.shields.io/badge/built%20with-PowerShell-012456.svg?logo=powershell&logoColor=white)
![Azure](https://img.shields.io/badge/Azure-API%20Management-blue?logo=microsoftazure&logoColor=white)
![License](https://img.shields.io/github/license/meezankhan/azure-apim-product-subscription-export)
![Last Commit](https://img.shields.io/github/last-commit/meezankhan/azure-apim-product-subscription-export)

🔍 Export detailed Azure API Management product subscriptions along with user metadata to a CSV file — ideal for auditing, governance, and user access analysis.

---

## 📌 Features

- Fetches all products from an Azure API Management (APIM) instance
- Lists subscriptions under each product
- Retrieves user details: name, email, ID
- Outputs a clean, timestamped `.csv` report

---

## ⚙️ Configuration

In the script, update the following:

```powershell
$tenantId           = "<your-tenant-id>"
$appId              = "<your-client-id>"
$clientSecret       = "<your-client-secret>"
$subscriptionId     = "<your-azure-subscription-id>"
$resourceGroupName  = "<your-resource-group>"
$apimServiceName    = "<your-apim-instance-name>"
