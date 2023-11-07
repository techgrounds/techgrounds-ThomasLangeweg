# Passwords
Wat is een goede manier van passwords opslaan en wat is het principe Hashing.

## Key-terms
1. Hash [x]
2. Rainbow table

## Opdracht
### Gebruikte bronnen
Voor Hashcracking https://crackstation.net/

Uitleg en verwerking van Hash https://www.youtube.com/watch?v=jmtzX-NPFDc&ab_channel=Simplilearn 

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
Hashing is een proces waarbij gegevens worden omgezet in een vaste lengte van tekens, meestal een reeks cijfers en letters. Het belangrijkste doel van hashing is om efficiënt gegevens te kunnen opslaan, ophalen en vergelijken.

Een hashfunctie neemt inputgegevens en genereert een unieke hashwaarde, die meestal een vaste lengte heeft, ongeacht de grootte van de oorspronkelijke gegevens. Een goede hashfunctie zorgt ervoor dat zelfs kleine wijzigingen in de inputgegevens leiden tot significante veranderingen in de resulterende hashwaarde.

Dit is een betere optie in het geval van een encryptie omdat er bij encryptie nog altijd een key bestaat wat gepakt kan worden door hacking etc. Aan de andere kant is het ook niet zo veilig want een Rainbowtable kan nog steeds een Hash kraken. Dit gebeurd dan door een tabel met veelvoorkomende wachtwoorden te scannen. 

Hieronder een voorbeeld van rainbow table en daarbij het resultaat van een MD5 Hash:

![Alt text](<Screenshots/Screenshot 2023-11-07 145908.png>)

Hier is te zien dat dit een zwak wachtwoord is, en het niet **Salted** is. Nog een voorbeeld is:

![Alt text](<Screenshots/Screenshot 2023-11-07 150102.png>)

In dit voorbeeld is er in de oorspronkelijk tekst "Salt" toegevoegd wat er dus voor zorgt dat het niet lijkt op het wachtwoord in die tabel. Vandaar dat dit niet te vinden is. 

In de onderstaande screenshot weet ik dat ik voor user thomas_2 paswoord 123 heb aangemaakt, de enige manier dat ik het weet is omdat ik het heb aangemaakt. Dit is alleen niet te vinden in Rainbow Table, omdat het wachtwoord hier in $6$ gemaakt is en dat het automatisch gesalt is. Vandaar dat het voor [Link](https://crackstation.net/) te groot is om te zoeken. 

