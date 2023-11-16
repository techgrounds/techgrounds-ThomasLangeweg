# Azure virtual networks
[Geef een korte beschrijving van het onderwerp]

## Key-terms
**Azure virtual networks (VNET)** laat resources zoals Virtual Machines, databases en web apps met elkaar communiceren. Dit vergroot het bereik van users met het internet en machines lokaal. 

**Point-to-site VPNs** Het Azure VNet wordt benaderd met een VPN vanaf een on-prem computer.

**Site-to-site VPNs** De on-prem VPN device of gateway wordt verbonden met de Azure VPN Gateway. Hierdoor krijg je effectief 1 groot local network.

**Azure Expressroute** Dit is een fysieke verbinding vanaf je lokale omgeving naar Azure.

## Opdracht
### Gebruikte bronnen
https://learn.microsoft.com/nl-nl/azure/virtual-network/virtual-networks-overview

&

https://www.youtube.com/watch?v=feQvnIUJ3Iw&t=4838s&ab_channel=K21Academy

### Ervaren problemen
In eerste instantie alles neergezet zoals het hoort, Vnet gemaakt en dan een VM gekoppeld. In eerste instantie was de default page niet te zien, na een half uur pauze te hebben genomen was deze ineens wel te zien. 

### Resultaat
Eerst een Vnet aangemaakt met de onderstaande subnets:

![Alt text](<Screenshots/Screenshot 2023-11-16 110144.png>)

Daarna een VM gemaakt op subnet-1:

![Alt text](<Screenshots/Screenshot 2023-11-16 110224.png>)

En hier zie je dat ik toegang heb tot de default page van apache:

![Alt text](<Screenshots/Screenshot 2023-11-16 103820.png>)