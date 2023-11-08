# Public Key Infrastructure
Het internet werkt in vaak niet goed beveiligd, en door de infrastructuur kan je wel beveiligde verbindingen maken. Dit gebeurd door rollen, procedures etc. In deze opdracht ga ik werken met een SSL self-signed certificate.

## Key-terms
1. SSL self-signed certificate [x]
2. X.509 [x]
3. PKI [x]

## Opdracht
### Gebruikte bronnen
Voor het maken van een SSL self-signed certificaat: https://linuxize.com/post/creating-a-self-signed-ssl-certificate/ en hieronder de uitleg daarvan: https://www.youtube.com/watch?v=qXLD2UHq2vk&t=625s&ab_channel=DaveCrabbe

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
In de eerste opdracht heb ik een Self-Signed certificate gemaakt in mijn vm, hieronder zie je de stappen die ik gelopen heb:

![Alt text](<Screenshots/Screenshot 2023-11-08 100054.png>)

Voor websites is het alleen handiger dat een certificaat gemaakt en beoordeeld wordt door een extern bedrijf. Dit is alleen niet zo bij gevallen waarbij het bedrijf zelf al enorm groot is. Zie bijvoorbeeld hier wat details van google. De organisatie heeft zijn eigen certificaat gebruikt. 

![Alt text](<Screenshots/Screenshot 2023-11-08 100411.png>)

Ander voorbeeld hier is mijn scoutinggroep, welk gebruik maakt van een extern bedrijf.

![Alt text](<Screenshots/Screenshot 2023-11-08 100627.png>)

Hieronder is een lijst te zien van certificates welke trusted zijn op mijn VM, deze lijst is te lang dus hier een klein stukje:

![Alt text](<Screenshots/Screenshot 2023-11-08 101222.png>)

De lijst met certificaten die trusted zijn op mijn windows machine hieronder:

![Alt text](<Screenshots/Screenshot 2023-11-08 101613.png>)