@description('Webserver vnet')
param existinglocalvnet string

@description('Management server vnet')
param remotevnet string

@description('Resource group name')
param resourcegrp string


resource vnetPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-01-01' = {
  name: '${existinglocalvnet}/peering-to-remote-vnet'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: resourceId(resourcegrp, 'Microsoft.Network/virtualNetworks', remotevnet)

    }
  }
}
