@description('Location of the resources.')
param location string = resourceGroup().location

@description('Name of the virtual machine.')
param vmName string

@description('Name of the KeyVault to place the volume encryption key')
param keyvaultname string

var keyVaultResourceID = resourceId(resourceGroup().name, 'Microsoft.KeyVault/vaults/', keyvaultname)
var encryptionOperation = 'EnableEncryption'
var keyEncryptionAlgorithm = 'RSA-OAEP'


resource vmName_diskEncryption 'Microsoft.Compute/virtualMachines/extensions@2020-12-01' = {
  name: '${vmName}/diskEncryption'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Security'
    type: 'AzureDiskEncryption'
    typeHandlerVersion: '2.2'
    autoUpgradeMinorVersion: true
    settings: {
      EncryptionOperation: encryptionOperation
      KeyVaultURL: reference(keyVaultResourceID, '2022-07-01').vaultUri
      KeyVaultResourceId: keyVaultResourceID
      KeyEncryptionAlgorithm: keyEncryptionAlgorithm
      VolumeType: 'All'
    }
  }
}
