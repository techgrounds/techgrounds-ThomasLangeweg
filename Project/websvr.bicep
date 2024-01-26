@description('Username for the Virtual Machine.')
param adminUsername string

@description('Unique DNS Name for the Public IP used to access the Virtual Machine.')
param dnsNameForPublicIP string

@description('location for resources')
param location string = resourceGroup().location


@allowed([
  'sshPublicKey'
  'password'
])
@description('Type of authentication to use on the Virtual Machine. SSH key is recommended.')
param authenticationType string = 'password'

@description('SSH Key or password for the Virtual Machine. SSH key is recommended.')
@secure()
param adminPasswordOrKey string

@description('UTC timestamp used to create distinct deployment scripts for each deployment')
param utcValue string = utcNow()

param storageAccountName string = 'webserverstorageproj'

param WinserverIpAdd string

var ubuntuOSVersion = 'Ubuntu-2004'
var vmSize = 'Standard_B1ls'
var publicIpSku = 'Standard'
var imagePublisher = 'Canonical'
var imageOffer = 'UbuntuServer'
var nicName_var = 'WebVMNic'
var addressPrefix = '10.10.10.0/24'
var subnetName = 'WebSubnet'
var subnetPrefix = '10.10.10.0/25'
var publicIPAddressName_var = 'WebPublicIP'
var publicIPAddressType = 'Static'
var vmName_var = 'WebUbuntuVM'
var virtualNetworkName_var = 'WebVNET'
var subnetRef = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName_var, subnetName)
var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${adminUsername}/.ssh/authorized_keys'
        keyData: adminPasswordOrKey
      }
    ]
  }
}

var networkSecurityGroupName_var = 'WebVM-NSG'
var blobfileurl = 'https://webserverstorageproj.blob.core.windows.net/data/installapache.sh'


resource publicIPAddressName 'Microsoft.Network/publicIPAddresses@2020-05-01' = {
  name: publicIPAddressName_var
  location: location
  zones:[
    '2'
  ]
  sku: {
    name: publicIpSku
  }
  properties: {
    publicIPAllocationMethod: publicIPAddressType
    dnsSettings: {
      domainNameLabel: dnsNameForPublicIP
    }
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: nicName_var
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddressName.id
          }
          subnet: {
            id: subnetRef
          }
        }
      }
    ]
  }
  dependsOn: [
    virtualNetworkName
  ]
}

resource networkSecurityGroupName 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: networkSecurityGroupName_var
  location: location
  properties: {
    securityRules: [
      {
        id: 'SSH'
        name: 'SSH'
        properties: {
          priority: 1000
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '22'
          protocol: 'Tcp'
          //sourceAddressPrefix: '*'
          sourceAddressPrefix: WinserverIpAdd
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        id: 'HTTP'
        name: 'HTTP'
        properties: {
          priority: 1001
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '80'
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        id: 'HTTPS'
        name: 'HTTPS'
        properties: {
          priority: 1003
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '443'
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
        }
     } 
    ]
  }
}

resource virtualNetworkName 'Microsoft.Network/virtualNetworks@2020-05-01' = {
  name: virtualNetworkName_var
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
          networkSecurityGroup: {
            id: networkSecurityGroupName.id
          }
        }
      }
    ]
  }
}

resource vmName 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmName_var
  location: location
  tags: {
    name : 'Cloud'
    value : 'Cloudproject12'
  }
  zones:[
    '2'
  ]
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName_var
      adminUsername: adminUsername
      adminPassword: adminPasswordOrKey
      linuxConfiguration: ((authenticationType == 'password') ? null : linuxConfiguration)
    }
    storageProfile: {
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: ubuntuOSVersion
        version: 'latest'
      }
      osDisk: {
        name: '${vmName_var}_OSDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
        
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicName.id
        }
      ]
    }
  }
}

resource vmName_install_apache 'Microsoft.Compute/virtualMachines/extensions@2023-09-01' = {
  parent: vmName
  name: 'install_apache'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    typeHandlerVersion: '2.1'
    autoUpgradeMinorVersion: true
    settings: {
      skipDos2Unix: false
      
             }
    protectedSettings: {
      storageAccountName: storageAccountName
      storageAccountKey: listKeys(resourceId('Microsoft.Storage/storageAccounts', storageAccountName), '2022-05-01').keys[0].value
      fileUris: [
       'https://webserverstorageproj.blob.core.windows.net/data/installapache.sh'
      ]
      commandToExecute: 'sh installapache.sh'
    }
  }
}

output webvnetname string = virtualNetworkName.name
output webvmname string = vmName_var
