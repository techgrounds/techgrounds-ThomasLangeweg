# Azure Core Services
Dit is een lijst met de meeste bekende services en termen in Azure. 

## Key-terms
Zie opdracht voor alle termen.

## Opdracht
### Gebruikte bronnen

### Ervaren problemen
Het zoeken naar de uitleg van sommige termen/services was af en toe lastig met verschillende verhalen. 

### Resultaat
Lijst met services

| Term/Service | Uitleg|
| ---------------- | ---------------- |
| Regions and Region Pairs   | Een regio waar een aantal datacenters staan die samen gelinkt zijn over de wereld. Een Region pair zijn verschillende Regions die samen werken.|
Availability Zones     | Elke Region bestaat uit een of meerdere datacenters, als dit er meerdere zijn. Dan zijn deze samengelinkt via een snelle internet kabel |
Resource Groups   | Is een container resources welke werksaam zijn in Azure, zo kan je alles wat met een ding te maken heeft gebruik maken van deze groups. Of departemineren van verschillende producties.   |
Subscriptions     |An Azure subscription is a logical container used to provision resources in Azure. It holds the details of all your resources like virtual machines (VMs), databases, and more. When you create an Azure resource like a VM, you identify the subscription it belongs to. As you use the VM, the usage of the VM is aggregated and billed monthly. |
Management Groups    | Elke resource moet in 1 group zitten, de groups hebben een locatie. Binnen de groups kunnen er wel verschillende plekken zijn. Je kan wel Resources verplaatsen van de ene naar de andere group.  |
Azure Resource Manager  | Dit is een laag dat zorgt dat alles met elkaar kan communiceren zodat het goed samen blijft werken.   |
Virtual Machines | Is een machine wat bestaat op een andere OS. Hier kan je bijvoorbeeld iets uittesten of aanpassen zonder invloed uit te oefenen op het OS van de server/computer. Hier moet je wel zelf bepalen wat en hoe het systeem werkt. Dit kan dan als  |
Azure App Services | Met deze services kan je web apps en service maken, welke kan richting het internet worden gestuurd. Hier kunnen dan users naar kijken. 
Azure Container Instances (ACI) | Een applicatie, config en andere welke je in een container repository kan plaatsen. Dit is de snelste en makkelijkste manier om een container te laten draaien. 
Azure Kubernetes Service (AKS) | Dit verdeeld containers in een load balancer om uiteindelijk te laten gebruiken voor users. 
Azure Virtual Desktop | Een virtueel desktop in Azure voor het gebruik van apps of het maken van files. 
Virtual Networks | Het netwerk van Virtual machines in Azure. Deze kunnen verdeeld worden in subnets en andere ports. Zo kan je ze ook groupen waar je ze wilt hebben. 
VPN Gateway | Met deze gateway kan je een connectie zoeken met je eigen internal netwerk. Dit gebeurt dan beveiligd, in plaats van over het publieke internet. 
Virtual Network Peering | Dit is het peeren van meerdere virtual machines op het virtual network, dit kan ook met een vm in je eigen server. 
ExpressRoute | Gebruik Azure ExpressRoute om privéverbindingen te maken tussen Azure-datacenters en infrastructuur on-premises of in een co-locatieomgeving. ExpressRoute-verbindingen routeren niet via het openbare internet en bieden meer betrouwbaarheid, meer snelheid en lagere latentie dan normale internetverbindingen.
Container (Blob) Storage | Staat voor Binary large objects, deze worden in containers opgeslagen. Hier kan dan een user gebruik van maken in een programma. 
Disk Storage | Azure managed disks are block-level storage volumes that are managed by Azure and used with Azure Virtual Machines.
File Storage | Dit lijkt heel erg op Blob storage, hier worden alleen files geplaatst en de containers heette hier "share". 
Storage Tiers | Je hebt hier 3 lagen storage, dit is HOT (vaak gebruikt) Cool (minder vaak gebruikt) en archive (data wat nooit gebruikt wordt)
Cosmos DB | Hier kan je opgeslagen files opslaan op meerdere regions in Azure Cloud. Zo kan je gebruik maken van dingen overal op de wereld. 
Azure SQL Database | Hier worden structured files geplaatst, deze worden opgeslagen in table format. Deze worden opgeslagen als DBaaS. 
Azure Database for MySQL | Met Azure Database for MySQL kunnen gebruikers gemakkelijk schaalbare, veilige en betrouwbare MySQL-databases implementeren, beheren en gebruiken zonder zich zorgen te hoeven maken over de infrastructuuronderhoudstaken, zoals patching, back-ups, en schaalbaarheid.
Azure Database for PostgreSQL | Het stelt ontwikkelaars en organisaties in staat om PostgreSQL-databases te gebruiken in een cloudomgeving met hoge beschikbaarheid, beveiliging en schaalbaarheid.
SQL Managed Instance |  Het biedt een platform voor het uitvoeren van SQL Server-workloads in de cloud met vrijwel alle functies en compatibiliteit van een on-premises SQL Server.
Azure Marketplace | Hier kunnen users publieke dingen kopen of krijgen voor het gebruik in hun eigen projecten. 