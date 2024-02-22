@description('Size of VMs in the VM Scale Set.')
param vmSku string = 'Standard_B2ms'

@description('String used as a base for naming resources. Must be 3-57 characters in length and globally unique across Azure. A hash is prepended to this string for some resources, and resource-specific information is appended.')
@maxLength(57)
param vmssName string ='webservercloud'

@description('Number of VM instances (1000 or less).')
@minValue(1)
@maxValue(1000)
param instanceCount int = 1

@description('Admin username on all VMs.')
param adminUsername string

@description('Default location')
param location string = resourceGroup().location

@description('Type of authentication to use on the Virtual Machine. SSH key is recommended.')
@allowed([
  'sshPublicKey'
  'password'
])
param authenticationType string = 'password'

@description('Storage account name ')
param storagename string

@description('Public ip of the management server')
param publicipmgmtserver string

param identityName string

param secreturl string 

@description('Blob url ')
param bloburl string

@description('SSH Key or password for the Virtual Machine. SSH key is recommended.')
@secure()
param adminPasswordOrKey string

var blobfileurl = '${bloburl}/data/installapache.sh'
var identityID = identity.id
var longNamingInfix = toLower(vmssName)
var namingInfix = toLower(substring('${vmssName}${uniqueString(resourceGroup().id)}', 0, 9))
var addressPrefix = '10.10.0.0/16'
var subnetPrefix = '10.10.8.0/24'
var virtualNetworkName = '${namingInfix}vnet'
var subnetName = '${namingInfix}subnet'
var nicName = '${namingInfix}nic'
var networkSecurityGroupName = '${namingInfix}nsg'
var ipConfigName = '${namingInfix}ipconfig'
var imageReference = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '18.04-LTS'
  version: 'latest'
}
var appGwPublicIPAddressName = '${namingInfix}appGwPip'
var appGwName = '${namingInfix}appGw'
var appGwPublicIPAddressID = appGwPublicIPAddress.id
var appGwSubnetName = '${namingInfix}appGwSubnet'
var appGwSubnetPrefix = '10.10.1.0/24'
var appGwSubnetID = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, appGwSubnetName)
var appGwFrontendPort = 80
var appGwBackendPort = 80
var appGwBePoolName = '${namingInfix}appGwBepool'
var probeName = '${namingInfix}probe'
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


resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' existing ={
  name: identityName
}
resource nsg 'Microsoft.Network/networkSecurityGroups@2020-05-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-22'
        properties: {
          priority: 100
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '22'
          protocol: 'Tcp'
          sourceAddressPrefix: publicipmgmtserver
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'default-allow-80'
        properties: {
          priority: 200
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
        name: 'default-allow-443'
        properties: {
          priority: 300
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
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-08-01' = {
  name: virtualNetworkName
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
            id: nsg.id
          }
        }
      }
      {
        name: appGwSubnetName
        properties: {
          addressPrefix: appGwSubnetPrefix

        }
      }
    ]
  }
}

resource appGwPublicIPAddress 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: appGwPublicIPAddressName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    dnsSettings: {
      domainNameLabel: longNamingInfix
    }
  }
 zones:[
  '2'
 ]
}

resource appGw 'Microsoft.Network/applicationGateways@2021-05-01' = {
  name: appGwName
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${identityID}': {
      }
    }
  }
  properties: {
    sku: {
      name: 'Standard_V2'
      tier: 'Standard_V2'
    }
    sslCertificates: [
      {
        name: 'appGatewaySslCert'
        properties: {
          keyVaultSecretId: secreturl
        }
      }
    ]
    gatewayIPConfigurations: [
      {
        name: 'appGwIpConfig'
        properties: {
          subnet: {
            id: appGwSubnetID
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGwFrontendIP'
        properties: {
          publicIPAddress: {
            id: appGwPublicIPAddressID
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'appGwFrontendPort'
        properties: {
          port: 443
        }
      }
      {
        name: 'appGwFrontendPort80'
        properties: {
          port: 80
        }
      }


      
    ]
    
    backendAddressPools: [
      {
        name: appGwBePoolName
        
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGwBackendHttpSettings'
        properties: {
          port: appGwBackendPort
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress:true
          probe:{
            id: resourceId('Microsoft.Network/applicationGateways/probes/',appGwName,probeName)
          }
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGwHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations/', appGwName, 'appGwFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts/', appGwName, 'appGwFrontendPort')
          }
          protocol: 'Https'
          sslCertificate: {
            id: resourceId('Microsoft.Network/applicationGateways/sslCertificates', appGwName, 'appGatewaySslCert')
          }
        }
      }
      {
        name: 'appGwHttpListener80'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations/', appGwName, 'appGwFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts/', appGwName, 'appGwFrontendPort80')
          }
          protocol: 'Http'
          
        }

      }
      
    ]
    
    requestRoutingRules: [
      {
        name: 'rule1'
        properties: {
          priority:50
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners/', appGwName, 'appGwHttpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools/', appGwName, appGwBePoolName)
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection/', appGwName, 'appGwBackendHttpSettings')
          }
        }
      }
      {
        name: 'rule2'
        
        properties: {
          priority: 300
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners/', appGwName, 'appGwHttpListener80')
          }
          redirectConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/redirectConfigurations', appGwName, 'rc-http-default')
          }
          
        }
      }
    ]
    redirectConfigurations: [
      {
        name: 'rc-http-default'
        properties:{
          redirectType: 'Permanent'
          includePath: true
          includeQueryString: true
          targetListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGwName, 'appGwHttpListener')
          }
          
        }
      }
   ]
    probes:[
      {
        name: probeName
        properties:{
          protocol:'Http'
          path:'/'
          interval:30
          timeout:30
          unhealthyThreshold:3
          pickHostNameFromBackendHttpSettings:true
          match:{
            statusCodes:[
              '200-399'
            ]
          }

        }
          
        
      }
    ]
    autoscaleConfiguration: {
      minCapacity: 1
      maxCapacity: 2
    }
  }
  dependsOn: [
    virtualNetwork
    appGwPublicIPAddress

  ]
}

resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2022-08-01' = {
  name: namingInfix
  location: location
  zones:[
    '2'
  ]
  sku: {
    name: vmSku
    tier: 'Standard'
    capacity: instanceCount
  }
  
  properties: {
    
    overprovision: true
    singlePlacementGroup: false
    
    upgradePolicy: {
      mode: 'Automatic'
    }
    automaticRepairsPolicy: {
      enabled: true
      gracePeriod: 'PT10M'
    }
    virtualMachineProfile: {
      storageProfile: {
        osDisk: {
          caching: 'ReadWrite'
          createOption: 'FromImage'
        }
        imageReference: imageReference
      }
      osProfile: {
        computerNamePrefix: namingInfix
        adminUsername: adminUsername
        adminPassword: adminPasswordOrKey
        linuxConfiguration: ((authenticationType == 'password') ? json('null') : linuxConfiguration)
      }
      networkProfile: {
        
        networkInterfaceConfigurations: [
          {
            name: nicName
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: ipConfigName
                  properties: {
                    subnet: {
                      id: resourceId('Microsoft.Network/virtualNetworks/subnets/', virtualNetworkName, subnetName)
                    }
                    applicationGatewayBackendAddressPools: [
                      {
                        id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools/', appGwName, appGwBePoolName)
                      }
                    ]
                  }
                }
              ]
              networkSecurityGroup: {
                id: nsg.id
              }
            }
          }
        ]
      }
      extensionProfile: {
        extensions: [
          {
            name: 'scriptextension'
            properties: {
              publisher: 'Microsoft.Azure.Extensions'
              type: 'CustomScript'
              typeHandlerVersion: '2.1'
              autoUpgradeMinorVersion: true
              settings: {
                skipDos2Unix: false
                fileUris: [
                    'https://prodrguniquestorage.blob.core.windows.net/data/installapache.sh'
                    
                   
                ]
                               
              }
             
              protectedSettings: {
                storageAccountName: storagename
                storageAccountKey :  listKeys(resourceId('Microsoft.Storage/storageAccounts', storagename), '2022-05-01').keys[0].value
                commandToExecute: 'sh installapache.sh'
             }
           }
          }
          {
            name : 'healthextension'
            properties:{
              publisher:'Microsoft.ManagedServices'
              type: 'ApplicationHealthLinux'
              autoUpgradeMinorVersion:true
              typeHandlerVersion: '1.0'
              settings:{
                protocol: 'tcp'
                port : 80
              }
            }
          }
       ]
      }
    }
  }
  dependsOn: [
    virtualNetwork
    appGw
  ]
}
resource autoscalewad 'Microsoft.Insights/autoscalesettings@2015-04-01' = {
  name: 'autoscalewad'
  location: location
  properties: {
    name: 'autoscalewad'
    targetResourceUri: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Compute/virtualMachineScaleSets/${namingInfix}'
    enabled: true
    profiles: [
      {
        name: 'Profile1'
        capacity: {
          minimum: '1'
          maximum: '3'
          default: '1'
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Compute/virtualMachineScaleSets/${namingInfix}'
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT2M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: 70
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT1M'
            }
          }
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Compute/virtualMachineScaleSets/${namingInfix}'
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'LessThan'
              threshold: 30
            }
            scaleAction: {
              direction: 'Decrease'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT5M'
            }
          }
        ]
      }
    ]
  }
  dependsOn: [
    vmss
  ]
}
output fqdn string = 'http://${appGwPublicIPAddress.properties.dnsSettings.fqdn}'
output webservervnet string = virtualNetwork.name
output burl string  = blobfileurl
