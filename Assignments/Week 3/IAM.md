# IAM
Beveiliging op een netwerk uitleg en verschillen.

## Key-terms
1. Multi-factor authentication [x]
2. Authentication [x]
3. Authorization [x]
4. The Principle of Least Privilege [x]

## Opdracht
### Gebruikte bronnen
Voor het verschil tussen Authentication en Authorization https://www.youtube.com/watch?v=85BBfKo6bdo&ab_channel=RobertsDevTalk

Wat Least privilege is: https://www.youtube.com/watch?v=RDRWIqEHDcE&ab_channel=TheInfosecAcademy

### Ervaren problemen
Geen problemen ervaren.

### Resultaat
Voor het verschil tussen Authentication en Authorization en hiervoor heb ik verschillende video's bekeken en websites bekeken en het volgende overzicht gemaakt:

```
Authentication
Het doel van authenticatie is om te controleren of iemand daadwerkelijk is wie hij beweert te zijn, en het speelt een cruciale rol bij het beveiligen van computersystemen, netwerken, online accounts en gevoelige informatie. Het werkt door verschillende manieren met Wachtwoordauthenticatie, Biometrische authenticatie, Two-factor authentication (2FA) of multi-factor authentication (MFA) en certificaten. 
```
```
Authorization
Authorisatie is het proces waarbij wordt bepaald welke acties een geauthenticeerde gebruiker, systeem of entiteit mag uitvoeren binnen een systeem of op bepaalde bronnen. Voorbeelden hiervan zijn Rolgebaseerde toegangscontrole (RBAC), Toegangsbeheerlijsten (ACL's), Beleid voor toegangsbeheer (ABAC) en Fijnmazige autorisatie. 
```
De volgende 3 factoren zijn vormen van Authentication:
- Know
- Have
- Are
  
```
Know: Staat voor punten/dingen die de user zou moeten weten, dit verstaat dan onder wachtwoorden of pincodes.
```

```
Have: Staat voor apparaten/dingen die je hebt, zie bijvoorbeeld je telefoon die je nodig hebt voor het inloggen bij overheid zaken. Dit doe je door een code te ontvangen met DigiD App.
```

```
Are: Dit is wat je bent, jouw vingerafdruk of je gezicht kan je gebruiken om in te loggen op je telefoon. Dit ben je dus. 
```
Door multi-factor authentication te gebruiken ben je meer zeker of je beveiliging. Wachtwoorden (Know) zijn vaak niet meer veilig genoeg, dit wordt dan samen gebruikt met een extra code (Have) op je telefoon of email. 


#### The Principle of Least Privilege

Dit leg ik uit met een voorbeeld uit mijn vorige werkgever, hier was ik vooral bezig met orders verwerken en uitzetten richting het magazijn. Hier had ik niet de taak om de orders op te nemen van een klant, dus ik had geen toegang in het systeem tot klantgegevens. Ook was het voor ons niet geschikt om te kijken naar hun betaalgegevens. Hetgeen wat voor ons beschikbaar was, is de locatie het aantal en waar het naartoe moest. Meer toegang hadden wij niet. Dus hier wordt alleen maar gekeken naar welke functie ik had en tot welke factoren ik toegang heb. 