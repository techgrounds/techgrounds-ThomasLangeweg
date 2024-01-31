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

var rgname = 'rgroupProject'
param location string = 'westeurope'


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
