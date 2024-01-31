// This is the bicep file which creates the Storage account with a blob container.
targetScope = 'resourceGroup'

@description('Name of the blob as it is stored in the blob container')
param filename string = 'installapache'

@description('Name of the blob container')
param containerName string = 'data'

@description('Azure region where resources should be deployed')
param location string = resourceGroup().location

@description('Desired name of the storage account')
param storageAccountName string = 'svrstorageprojectv1'


resource storageaccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  tags: {
    name : 'Cloud'
    value: 'Cloudproject12'
  }
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
  resource blobService 'blobServices' = {
    name: 'default'

    resource container 'containers' = {
      name: containerName
    }
  }
}

resource deploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'deployscript-upload-blob-'
  location: location
  kind: 'AzureCLI'
  properties: {
    azCliVersion: '2.26.1'
    timeout: 'PT1H'
    retentionInterval: 'P1D'
    cleanupPreference: 'OnSuccess'
    storageAccountSettings: {
      storageAccountName: storageAccountName
      storageAccountKey: storageaccount.listKeys().keys[0].value
    }
    environmentVariables: [
      {
        name: 'AZURE_STORAGE_ACCOUNT'
        value: storageaccount.name
      }
      {
        name: 'AZURE_STORAGE_KEY'
        secureValue: storageaccount.listKeys().keys[0].value
      }
      {
        name: 'CONTENT'
        value: loadTextContent('./installapache.sh')
      }
    ]
     scriptContent: 'echo "$CONTENT" > ${filename} && az storage blob upload -f ${filename} -c ${containerName} -n ${filename}'
  }
}


output storagename string = storageaccount.name
output bloburl string = storageaccount.properties.primaryEndpoints.blob
