# Virtual Machine
In deze opdracht maak ik in Azure een VM en probeer daar via powershell contact mee te krijgen. 

## Key-terms
1. Remote Desktop Protocol (RDP): Allows a user to connect to and control another computer remotely. It enables users to access and interact with a desktop or application on a remote machine as if they were sitting in front of it.
2. NIC network security: Zorgt voor Encryptie en beveiliging. 
3. 

## Opdracht
### Gebruikte bronnen
Mijn thuisopdracht voor de studie. 

### Ervaren problemen
Weer hetzelfde als de connectie met de VM van TG, hier moest ik de key weer aanpassen naar alleen voor mij gebruiken. 

### Resultaat
Hieronder heb ik de onderstaande VM aangemaakt in Azure volgende de onderstaande parameters:
1. Maak een VM met de volgende vereisten:
2. Ubuntu Server 20.04 LTS - Gen1
3. Size: Standard_B1ls
4. Allowed inbound ports:
5. HTTP (80)
6. SSH (22)
7. OS Disk type: Standard SSD
8. Networking: defaults
9. Boot diagnostics zijn niet nodig
10. Custom data:

![Alt text](<Screenshots/Screenshot 2023-11-14 142447.png>)

Nadat deze is aangemaakt heb ik de connectie gemaakt via Powershell:

![Alt text](<Screenshots/Screenshot 2023-11-14 142432.png>)

