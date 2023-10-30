# OSI Stack
De introductie van het werken met OSI en TCP/IP modellen.

## Key-terms
*Beschreven in de opdracht*

## Opdracht
### Gebruikte bronnen
Wikipedia: https://nl.wikipedia.org/wiki/OSI-model

https://www.youtube.com/watch?v=Ilk7UXzV_Qc&ab_channel=RealPars

https://www.youtube.com/watch?v=LANW3m7UgWs&ab_channel=CertBros

https://www.youtube.com/watch?v=OTwp3xtd4dg&ab_channel=CertBros


### Ervaren problemen
Geen probleem ervaren. 

### Resultaat
---

#### OSI model

OSI model staat voor een gestandaardiseerd referentiemodel voor datacommunicatie. Letterlijk is het een afkorting van Open Systems Interconnection. Hieronder heb ik de 7 lagen beschreven:

1. Fysieke laag: Deze laag behandelt de fysieke verbinding tussen apparaten, zoals kabels, connectoren en signalen. Het bepaalt hoe ruwe bits over het medium worden verzonden.

2. Datalinklaag: De datalinklaag zorgt voor foutdetectie en -correctie en regelt toegang tot het fysieke medium. Het deelt gegevens in frames en adresseert apparaten op basis van hun fysieke MAC-adressen.

3. Netwerklaag: Hier wordt routing uitgevoerd, waarbij gegevenspakketten worden doorgestuurd tussen verschillende netwerken. IP-adressen worden gebruikt om apparaten op een netwerk te identificeren.

4. Transportlaag: De transportlaag biedt end-to-end communicatie en zorgt voor foutcontrole en gegevensstroombeheer. Protocollen zoals TCP (Transmission Control Protocol) en UDP (User Datagram Protocol) werken op deze laag.

5. Sessielaag: Deze laag is verantwoordelijk voor het opzetten, onderhouden en beëindigen van communicatiesessies tussen applicaties. Het beheert ook de synchronisatie van gegevensuitwisseling.

6. Presentatielaag: Hier wordt gegevensconversie, compressie en codering uitgevoerd om ervoor te zorgen dat gegevens in een geschikt formaat worden gepresenteerd aan de toepassingslaag.

7. Toepassingslaag: Dit is de bovenste laag en biedt de interface voor gebruikersapplicaties. Protocollen op deze laag regelen de eindgebruikerscommunicatie en toepassingen zoals e-mail, webbrowsers en bestandsuitwisseling.

#### TCP/IP model

Het TCP/IP-model is een ander referentiemodel voor netwerkarchitectuur dat wordt gebruikt om de werking van netwerken te begrijpen en te standaardiseren. In tegenstelling tot het OSI-model, dat zeven lagen heeft, bestaat het TCP/IP-model uit vier lagen.

1. Toepassingslaag: De toepassingslaag komt overeen met de bovenste drie lagen van het OSI-model (toepassingslaag, presentatielaag en sessielaag). Deze laag is verantwoordelijk voor het bieden van diensten en communicatiefuncties voor toepassingen en gebruikers. Dit omvat protocollen voor e-mail, webbrowsing, bestandsuitwisseling en andere toepassingen.

2. Transportlaag: Deze laag komt overeen met de transportlaag van het OSI-model. Het biedt end-to-end communicatie en betrouwbare gegevensaflevering. TCP (Transmission Control Protocol) en UDP (User Datagram Protocol) zijn de meest gebruikte protocollen op deze laag.

3. Internetlaag: De internetlaag komt overeen met de netwerklaag van het OSI-model. Het houdt zich bezig met het routeren van gegevenspakketten over verschillende netwerken. IP (Internet Protocol) is het belangrijkste protocol op deze laag.

4. Netwerktoegangslaag: Deze laag komt grotendeels overeen met de gecombineerde datalink- en fysieke lagen van het OSI-model. Het behandelt de fysieke verbinding tussen apparaten en netwerken, evenals de toegang tot het fysieke medium. Dit kan omvatten Ethernet, WiFi, DSL en andere technologieën.

Er is een update versie van TCP/IP met de 4 laag verdeeld in 2 lagen, daarbij heb je dan 4 **Data Link laag** en 5 **Fysieke laag**