@description('Username for the Virtual Machine.')
param adminUsername string

@description('Unique DNS Name for the Public IP used to access the Virtual Machine.')
param dnsNameForPublicIP string

@description('Location for all resources.')
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

@description('The Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version.')
@allowed([
  'Ubuntu-1804'
  'Ubuntu-2004'
  'Ubuntu-2204'
])
param ubuntuOSVersion string = 'Ubuntu-2004'

@description('Size of the virtual machine')
param vmSize string = 'Standard_B2ms'

var imageReference = {
  'Ubuntu-1804': {
    publisher: 'Canonical'
    offer: 'UbuntuServer'
    sku: '18_04-lts-gen2'
    version: 'latest'
  }
'Ubuntu-2004': {
  publisher: 'Canonical'
  offer: '0001-com-ubuntu-server-focal'
  sku: '20_04-lts-gen2'
  version: 'latest'
 }
'Ubuntu-2204': {
  publisher: 'Canonical'
  offer: '0001-com-ubuntu-server-jammy'
  sku: '22_04-lts-gen2'
  version: 'latest'
 }
}

var storageAccountName = 'bootdiags${uniqueString(resourceGroup().id)}'
var nicNamevar = 'WebserverVMNic'
var osDiskType = 'StandardSSD_LRS'
var addressPrefix = '10.10.0.0/16'
var subnetName = 'Subnet'
var subnetPrefix = '10.10.10.0/24'
var publicIpName = 'WebserverPublicIP'
var publicIPAddressType = 'Static'
var vmName_var = 'WebserverVM'
var virtualNetworkNamevar = 'WebserverVNET'
var subnetRef = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkNamevar, subnetName)
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
var networkSecurityGroupNamevar = 'Webserver-NSG'

resource storageaccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource pip 'Microsoft.Network/publicIPAddresses@2023-06-01' = {
  name: publicIpName
  location: location
  zones:[
    '2'
  ]
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: publicIPAddressType
    dnsSettings: {
      domainNameLabel: dnsNameForPublicIP
    }
  }
}

resource networkSecurityGroupName 'Microsoft.Network/networkSecurityGroups@2023-06-01' = {
  name: networkSecurityGroupNamevar
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
          sourceAddressPrefix: '*'
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
    ]
  }
}

resource virtualNetworkName 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: virtualNetworkNamevar
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

resource nicName 'Microsoft.Network/networkInterfaces@2023-06-01' = {
  name: nicNamevar
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pip.id
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



resource vmName 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vmName_var
  location: location
  tags: {
    name : 'Cloud'
    value: 'Cloudproject12'
  }
  zones:[
    '2'
  ]
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
      imageReference: imageReference[ubuntuOSVersion]   
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicName.id
        }
      ]
    }
      osProfile: {
        computerName: vmName_var
        adminUsername: adminUsername
        adminPassword: adminPasswordOrKey
        linuxConfiguration: ((authenticationType == 'password') ? json('null') : linuxConfiguration)
      }
    }
  }

output webvnetname string = virtualNetworkName.name
output webvmname string = vmName_var
