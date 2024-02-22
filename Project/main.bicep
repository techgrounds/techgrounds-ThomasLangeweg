/* maindeployment.bicep
Purpose: Deployment of modules in files
Created by: Thomas Langeweg
*/

targetScope = 'subscription'

@description('Location for all resources.')
param location string = 'eastus'

@description('Environment')
param envt string = 'prod'

@description('Webserver admin user name')
param adminUsername string

@description('Webserver admin user password')
@secure()
param adminPasswordOrKey string

@description('Management Admin user name')
param mgmtUserName string

@description('Management Admin password')
@secure()
param mgmtPassword string

@description('Management server DNS name')
param mgmtDNSName string

@description('Unique Key vault name')
param keyvaultname string


//---------------------Resource Group--------------------------//
resource resourceGp 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${envt}rg'
  location: location
}

//---------------------Storage Account-------------------------//
module storage 'storage.bicep' = {
  scope: resourceGp
  name: 'storagedeployment'
  params: {
    location : location
 }
}
//------------------Windows Admin Server-----------------------//
module adminservervm 'adminsvr.bicep' = {
  scope: resourceGp
  name: 'ManagementServerVM'
  params: {
    location: location
    adminPassword: mgmtPassword
    adminUsername: mgmtUserName
    mgmtdnsLabelPrefix: mgmtDNSName
    storageAccountName: storage.outputs.name
 }
}

module webscaleset 'webscaleset.bicep'= {
  scope: resourceGp
  name: 'WebserverVMSS'
  params: {
    location: location
    adminPasswordOrKey: adminPasswordOrKey
    adminUsername: adminUsername
    storagename: storage.outputs.name
    publicipmgmtserver: adminservervm.outputs.pip
    identityName:keyvault.outputs.identityName
    secreturl : keyvault.outputs.certificateSecretIdUnversioned
    bloburl: storage.outputs.bloburl
  }
  dependsOn: [
    keyvault
  ]
}

/*
//------------------------Webserver----------------------------//
module webservervm 'websvr.bicep' = {
  scope: resourceGp
  name: 'Webserver'
  params: {
    location: resourceGp.location
    adminUsername: adminuser
    adminPasswordOrKey: adminPassword
    dnsNameForPublicIP: dnsweb
  }
}


//-----------------------Vnet Peering---------------------------//
module vnetpeering 'vnetpeering.bicep' = {
  scope: resourceGp
  name: 'vnetpeering'
  params: {
    WebVirtualNetworkName: webvnet
    WinVirtualNetworkName: winvnet
    ResourceGroupName: resourceGp
  }
}
*/

//------------------------KeyVault----------------------------//
module keyvault 'cert.bicep' = {
  scope: resourceGp
  name: 'keyvault'
  params: {
    keyVaultName: keyvaultname
    location: location
}
}

//------------------Encryption Webserver----------------------//
/*
module websvrencryption 'websvrencryption.bicep' = {
  scope: resourceGp
  name: 'websvrencryption'
  params: {
    keyvaultname: keyvaultname
    vmName_var: webscaleset.outputs.webvmname
    location: location
  }
  dependsOn: [
   // webscaleset
   keyvault
  ]
}
*/

//------------------Encryption Adminserver----------------------//
module adminsvrencryption 'adminsvrencryption.bicep'= {
  scope: resourceGp
   name: 'adminsvrencryption'
  params: {
     keyvaultname: keyvaultname
     vmName: adminservervm.outputs.adminvmname
     location:location
   }
   dependsOn: [
     adminservervm
     keyvault
   ]
 }
