# Microsoft Entra ID & Containers
[Geef een korte beschrijving van het onderwerp]

## Key-terms

## Opdracht
### Gebruikte bronnen
1. https://www.youtube.com/watch?v=iSYcWNpi_6A&ab_channel=AndyMaloneMVP
2. https://www.youtube.com/watch?v=ThT3n2Yass4&ab_channel=AndyMaloneMVP
3. https://learn.microsoft.com/nl-nl/entra/verified-id/decentralized-identifier-overview
4. https://www.youtube.com/watch?v=jAWLQFi4USk&ab_channel=AdamMarczak-AzureforEveryone
5. https://learn.microsoft.com/en-us/azure/container-instances/?WT.mc_id=AZ-MVP-5003556
6. https://www.youtube.com/watch?v=eyNBf1sqdBQ&ab_channel=PowerCertAnimatedVideos

### Ervaren problemen
Ik zie dat ik geen Microsoft Entra ID aan kan maken, omdat ik geen paid customer ben. 

### Resultaat
Microsoft Entra ID
--
**Microsoft Entra ID** Is een cloudgebaseerde dienst van Microsoft die identiteits- en toegangsbeheer biedt voor gebruikers, applicaties en apparaten. Het fungeert als een oplossing voor identiteitsbeheer en toegangscontrole voor organisaties die gebruikmaken van Microsoft Azure of andere Microsoft-services. Voorheen was dit Azure AD.


* Waar kan ik deze dienst vinden in de console?
  * Deze service is te vinden met het aanmaken van een Resource. Hier kan je zoeken naar Entra ID en kies je voor het volgende:
![Alt text](<Screenshots/Screenshot 2023-11-27 135212.png>)

* Hoe zet ik deze dienst aan?
  *   Daarna door de de stappen te volgende kan je deze aanmaken. Dat is mij hier gelukt:
  ![Alt text](<Screenshots/Screenshot 2023-11-27 140030.png>)

* Hoe kan ik deze dienst koppelen aan andere resources?
  * Door Users aan te maken en daar de Policies van aan te passen kan ik deze users de juiste rechten geven. 
  * Deze service is gemaakt voor Authentication methods. Hier kan je bijvoorbeeld ook de volgende dingen aanmaken voor tenants in je organisatie:
      * Tokens
      * Mails
      * Passwords
      * etc

Azure Containers:
-- 
**Azure Containers** is een verzameling services en tools binnen Microsoft Azure die zijn ontworpen om de implementatie, beheer en schaalbaarheid van containergebaseerde applicaties te ondersteunen. Containers zijn een vorm van virtualisatie die het mogelijk maken om applicaties en hun afhankelijkheden te isoleren en uit te voeren op een gestandaardiseerde manier, ongeacht de omgeving waarin ze worden ingezet.

In deze omgeving heb je dan Azure Kubernetes Service (AKS) en Azure Container Instances (ACI):

**Azure Kubernetes Service (AKS)**: AKS is een volledig beheerde Kubernetes-service in Azure. Kubernetes is een open-source platform voor containerorkestratie dat wordt gebruikt voor het automatiseren van het implementeren, schalen en beheren van containerapplicaties.

**Azure Container Instances (ACI)**: ACI biedt een eenvoudige manier om containers zonder het beheer van virtuele machines direct in Azure uit te voeren. Het is bedoeld voor snelle implementaties van individuele containers, zonder de complexiteit van het beheren van de onderliggende infrastructuur.

Dit is een simpelere versie dan een Virtual Machine, deze hebben vaak elk een eigen OS en andere punten nodig. Hierdoor zijn Containers een makkelijkere en financieel voordelige optie voor simpele doeleinde. 

![Alt text](<Screenshots/Screenshot 2023-11-27 144519.png>)

