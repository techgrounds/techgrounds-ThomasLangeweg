# Firewall
Hoe werkt een Firewall en waar werken ze met welke Firewall. 

## Key-terms
1. Firewall [x]
2. Stateful/stateless [x]
3. Firewall Daemons [x]

## Opdracht
### Gebruikte bronnen
Algemene info over Firewall https://www.youtube.com/watch?v=kDEX1HXybrU&ab_channel=PowerCertAnimatedVideos & https://www.youtube.com/watch?v=IWNfb4a1ay0&ab_channel=CertBros

Voor weken met UFW zie volgende 2 bronnen:
1. https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands
2. https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-20-04

### Ervaren problemen
Geen problemen ervaren. 

### Resultaat
Voor het installeren van een webserver heb ik Apache2 al staan van de vorige opdracht: Zie screenshot below:

![Alt text](<Screenshots/Screenshot 2023-11-06 105535.png>)

Nu ga ik opzoek naar de standaard browser van deze server, hiervoor weet ik dat ik moet zoeken via het IP adres van VM. Na even zoeken kwam ik erachter dat ik hiervoor de **Webport** nodig had in plaats van de **sshport** door deze te gebruiken kom ik bij de default page:

![Alt text](<Screenshots/Screenshot 2023-11-06 111130.png>)

Hierna moesten we de firewall installeren en openzetten voor SSH, hieronder staat alles nog open voor de server:

![Alt text](<Screenshots/Screenshot 2023-11-06 112641.png>)

Hier heb ik alle opties voor web traffic uitgezet:

![Alt text](<Screenshots/Screenshot 2023-11-06 113053.png>)