/* maindeployment.bicep
Purpose: Deployement of modules in files
Created by: Thomas
*/

targetScope = 'subscription'

// Username Admin
param adminuser string

// Password for admin
@secure()
@minLength(12)
param adminPassword string

// Dns Name for webserver
param dnsweb string

// Username for Windows server
param mgmtuser string

// Password for Windows admin
@secure()
@minLength(12)
param mgmtpassword string

// DNS for Windows
param dnswindows string

@description('Set Vnet name (Local)')
param WinvirtuelNetworkName string = 'WinVnet'

@description('Set Vnet name (remote)')
param WebVirtuelNetworkName string = 'WebVnet'

@description('Key Vault Name')
param Keyvaultname string = 'kvproject'

var rgname = 'rgtechgrounds'
var location = 'westeurope'
var webvnet = webservervm.outputs.webvnetname
var winvet = winadminvm.outputs.winvnetname

resource rgroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: rgname
  location: location
  tags: {
    name : 'Cloud'
    value : 'Cloudproject12'
  }
}

module storageaccount 'storage.bicep' = {
  scope: rgroup
  name: 'deploymentstorage'
}

module winadminvm 'adminsvr.bicep' = {
  scope: rgroup
  name: Adminserver
  params: {
    location: rgroup.location
    adminPassword: mgmtpassword
    adminUsername: mgmtuser
    dnsLabelPrefix: dnswindows
    storageAccountName: storageaccount.outputs.storagename
  }
}

module webservervm 'websvr.bicep' = {
  scope: rgroup
  name: 'Webserver'
  params: {
    location: rgroup.location
    adminUsername: adminuser
    adminPasswordOrKey: adminPassword
    dnsNameForPublicIP: dnsweb
    storageAccountName: storageaccount.outputs.storagename    
    WinserverIpAdd: winadminvm.outputs.ipadd
    }
}
