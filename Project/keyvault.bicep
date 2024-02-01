@description('Location of KeyVault')
param location string = resourceGroup().location

@description('Name of KeyVault')
param keyvaultname string

var objectId = '395c03a0-bfa9-44bb-8fbd-e09ed9834d98'
var tenantId = 'de60b253-74bd-4365-b598-b9e55a2b208d'

resource Keyvault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyvaultname
  location: location
  tags: {
    name : 'Cloud'
    value: 'Cloudproject12'
  }
    properties: {
      accessPolicies: [
       {
         objectId: objectId
         permissions: {
            keys: [
             'all'
           ]
           secrets: [
             'all'
           ]
           storage: [
             'all'
           ]
         }
         tenantId: tenantId
       }
     ]
     enabledForDeployment: true
     enabledForDiskEncryption: true
     sku: {
       family: 'A'
       name: 'standard'
         }
     networkAcls: {
       defaultAction: 'Allow'
       bypass: 'AzureServices'
     }
      tenantId: tenantId
  }
}

output keyvaultname string = keyvaultname
