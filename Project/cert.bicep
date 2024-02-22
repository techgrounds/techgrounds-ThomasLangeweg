@description('The location to deploy the resources to')
param location string = resourceGroup().location

@description('Name of the KeyVault to provision')
param keyVaultName string 

@description('Name of the user assigned identity')
param identityName string = 'id-thomas'

@description('The name of the certificate to create')
param certificateName  string = 'ssl'

@description('The common name of the certificate to create')
param certificateCommonName string = certificateName

@allowed([
  'OnSuccess'
  'OnExpiration'
  'Always'
])
@description('When the script resource is cleaned up')
param cleanupPreference string = 'OnSuccess'

var identityID = identity.id


resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: identityName
  location: location
}
resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: reference(identityID).tenantId
    accessPolicies: [
      {
        tenantId: reference(identityID).tenantId
        objectId: reference(identityID).principalId
        permissions: {
          secrets: [
            'all'
          ]
          certificates:[
            'all'
            'list'
          ]
          keys: [
            'all'
          ]
        }
      }
    ]
    enableSoftDelete: true
  }
}


resource createImportCert 'Microsoft.Resources/deploymentScripts@2020-10-01' = {

  name: 'AKV-Cert-${keyVault.name}-${replace(replace(certificateName,':',''),'/','-')}'
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${identityID}': {
      }     
    }
    
  }
  kind: 'AzureCLI'
  properties: {
    forceUpdateTag: 1
    azCliVersion: '2.35.0'
    timeout: 'PT10M'
    retentionInterval: 'P1D'
    environmentVariables: [
      {
        name: 'akvName'
        value: keyVaultName
      }
      {
        name: 'certName'
        value: certificateName
      }
      {
        name: 'certCommonName'
        value: certificateCommonName
      }
      {
        name: 'retryMax'
        value: '10'
      }
      {
        name: 'retrySleep'
        value: '5s'
      }
    ]
    scriptContent: '''
      #!/bin/bash
      set -e
      #echo "Waiting on Identity RBAC replication ($initialDelay)"
      #sleep $initialDelay
      #Retry loop to catch errors (usually RBAC delays)
      retryLoopCount=0
      until [ $retryLoopCount -ge $retryMax ]
      do
        echo "Creating AKV Cert $certName with CN $certCommonName (attempt $retryLoopCount)..."
        az keyvault certificate create --vault-name $akvName -n $certName -p "$(az keyvault certificate get-default-policy | sed -e s/CN=CLIGetDefaultPolicy/CN=${certCommonName}/g )" \
          && break
        sleep $retrySleep
        retryLoopCount=$((retryLoopCount+1))
      done
      echo "Getting Certificate $certName";
      retryLoopCount=0
      createdCert=$(az keyvault certificate show -n $certName --vault-name $akvName -o json)
      while [ -z "$(echo $createdCert | jq -r '.x509ThumbprintHex')" ] && [ $retryLoopCount -lt $retryMax ]
      do
        echo "Waiting for cert creation (attempt $retryLoopCount)..."
        sleep $retrySleep
        createdCert=$(az keyvault certificate show -n $certName --vault-name $akvName -o json)
        retryLoopCount=$((retryLoopCount+1))
      done
      unversionedSecretId=$(echo $createdCert | jq -r ".sid" | cut -d'/' -f-5) # remove the version from the url;
      jsonOutputString=$(echo $createdCert | jq --arg usid $unversionedSecretId '{name: .name ,certSecretId: {versioned: .sid, unversioned: $usid }, thumbprint: .x509Thumbprint, thumbprintHex: .x509ThumbprintHex}')
      echo $jsonOutputString > $AZ_SCRIPTS_OUTPUT_PATH
    '''
    cleanupPreference: cleanupPreference
  }
}

@description('Certificate name')
output certificateName string = createImportCert.properties.outputs.name

@description('KeyVault secret id to the created version')
output certificateSecretId string = createImportCert.properties.outputs.certSecretId.versioned

@description('KeyVault secret id which uses the unversioned uri')
output certificateSecretIdUnversioned string = createImportCert.properties.outputs.certSecretId.unversioned

@description('Certificate Thumbprint')
output certificateThumbprint string = createImportCert.properties.outputs.thumbprint

@description('Certificate Thumbprint (in hex)')
output certificateThumbprintHex string = createImportCert.properties.outputs.thumbprintHex

output identityName string = identityName
