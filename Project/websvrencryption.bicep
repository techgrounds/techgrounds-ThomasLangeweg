@description('Resource group of the KeyVault')
param keyVaultResourceGroup string = resourceGroup().name

@description('Name of the virtual machine')
param vmName_var string

@description('Name of the KeyVault to place the volume encryption key')
param keyvaultname string

@description('Type of the volume OS or Data to perform encryption operation')
param volumeType string = 'All'

@description('Pass in an unique value like a GUID everytime the operation needs to be force run')
param forceUpdateTag string = '1.0'

@description('Location for all resources.')
param location string = resourceGroup().location

var extensionName = 'AzureDiskEncryptionForLinux'
var extensionVersion = '1.1'
var encryptionOperation = 'EnableEncryption'
var keyEncryptionAlgorithm = 'RSA-OAEP'
var keyVaultResourceID = resourceId(keyVaultResourceGroup, 'Microsoft.KeyVault/vaults/', keyvaultname)

resource vmName_extension 'Microsoft.Compute/virtualMachines/extensions@2020-12-01' = {
  name: '${vmName_var}/${extensionName}'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Security'
    type: extensionName
    typeHandlerVersion: extensionVersion
    autoUpgradeMinorVersion: true
    forceUpdateTag: forceUpdateTag
    settings: {
      EncryptionOperation: encryptionOperation
      KeyVaultURL: reference(keyVaultResourceID, '2016-10-01').vaultUri
      KeyVaultResourceId: keyVaultResourceID
      KeyEncryptionAlgorithm: keyEncryptionAlgorithm
      VolumeType: volumeType
    }
  }
}
