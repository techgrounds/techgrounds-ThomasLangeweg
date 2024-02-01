/* maindeployment.bicep
Purpose: Deployment of modules in files
Created by: Thomas Langeweg
*/

targetScope = 'subscription'

// Name for Webserver
param adminuser string

// Password for Webserver
@secure()
@minLength(12)
param adminPassword string

// DNS Name for Webserver
param dnsweb string

//Username for Windows Admin server
param mgmtUser string

//Password for Windows Admin server (Must be atleast 12 characters)
@secure()
@minLength(12)
param mgmtPassword string

// DNS name for Windows Server
param dnswindows string

// @description('Set the local VNet name')
// param winVNetName string = 'winVNET'

// @description('Set the remote VNet name')
// param vmssVNetName string = 'vmssVNET'

@description('Key Vault Name')
param keyvaultname string = 'techkeyvaultproject123'

var rgname = 'rgroupProject'
param location string = 'westeurope'
var winvnet = winadminvm.outputs.winvnetname
var webvnet = webservervm.outputs.webvnetname


//---------------------Resource Group--------------------------//
resource rgroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgname
  location: location
  tags: {
    name : 'Cloud'
    value: 'Cloudproject12'
  }
}
//---------------------Storage Account-------------------------//
module storageaccount './storage.Bicep' = {
  scope: rgroup
  name: 'storagedeployment'
  params: {
    location : location
 }
}
//------------------Windows Admin Server-----------------------//
module winadminvm 'adminsvr.bicep' = {
  scope: rgroup
  name: 'Adminserver'
  params: {
    location: rgroup.location
    adminUsername: mgmtUser
    adminPassword: mgmtPassword
    mgmtdnsLabelPrefix: dnswindows
  }
}
//------------------------Webserver----------------------------//
module webservervm 'websvr.bicep' = {
  scope: rgroup
  name: 'Webserver'
  params: {
    location: rgroup.location
    adminUsername: adminuser
    adminPasswordOrKey: adminPassword
    dnsNameForPublicIP: dnsweb
  }
}
//-----------------------Vnet Peering---------------------------//
module vnetpeering 'vnetpeering.bicep' = {
  scope: rgroup
  name: 'vnetpeering'
  params: {
    WebVirtualNetworkName: webvnet
    WinVirtualNetworkName: winvnet
    ResourceGroupName: rgname
  }
}
//------------------------KeyVault----------------------------//
module keyvault 'keyvault.bicep' = {
  scope: rgroup
  name: 'keyvault'
  params: {
    keyvaultname: keyvaultname
    location: location
}
}

//------------------Encryption Webserver----------------------//
module websvrencryption 'websvrencryption.bicep' = {
  scope: rgroup
  name: 'websvrencryption'
  params: {
    keyvaultname: keyvaultname
    vmName_var: webservervm.outputs.webvmname
    location: location
  }
  dependsOn: [
   webservervm
   keyvault
  ]
}


//------------------Encryption Adminserver----------------------//
module adminsvrencryption 'adminsvrencryption.bicep'= {
  scope: rgroup
   name: 'adminsvrencryption'
  params: {
     keyvaultname: keyvaultname
     vmName: winadminvm.outputs.winvmname
     location:location
   }
   dependsOn: [
     winadminvm
     keyvault
   ]
 }
