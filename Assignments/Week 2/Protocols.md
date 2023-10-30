# Protocols
In deze opdracht krijg ik een beter begrip van het onderwerp Protocol in je netwerk. 

## Key-terms
Zie weer de opdracht voor uitleg:

## Opdracht
### Gebruikte bronnen
Meeste van verschillende google zoektaken en wat eigen kennis.

Voor verschil TCP en UDP: https://www.youtube.com/watch?v=cA9ZJdqzOoU&ab_channel=CertBros

### Ervaren problemen
Geen problemen ervaren

### Resultaat
In elke laag van OSI model bestaan er een aantal protocollen, de keuze voor welke protocol is afhankelijk van de taak en vereisten.

```
Fysieke laag:
Hier zie je USB, Ethernet en Bluetooth. Met Ethernet wordt vaan IEEE 802.3 bedoeld welke direct van node tot node worden verbonden via koper of fiber.
```

```
Data Link:
Protocollen hier zijn ook Ethernet (IEEE 802.1Q) en Point-to-Point(PPP) maar ook Wifi. 
```

```
Netwerk:
Hier kent iedereen wel Internet Protocol wat staat voor IP, wat een verbinding maakt tussen apparaten over een netwerk. Hier heb je IPv4 en IPv6 van waarbij IPv6 meer opties heeft voor adressen. 
```

```
Transport:
Hier zie je Transmission Control Protocol(TCP) en User Datagram Protocol(UDP) naar voren komen. Om het verschil uit te leggen, zie Youtube filmpje in bronnen. 
```

```
Sessielaag:
Remote Procedure Call of RPC, is protocol waarmee een programma de uitvoering van een actie kan uitvoeren op een andere computer. Hierdoor kunnen dus applicaties communiceren over een netwerk.
```

```
Presentielaag:
Als protocol in deze laag heb je bijvoorbeeld SSL (Secure Sockets Layer) wat zorgt voor een beveiliging op bijvoorbeeld een webserver en een internetbrowser. Door middel van certificaten, als deze goed zijn wordt er een versleutelde verbinding gemaakt.
```

```
Toepassingslaag:
In de laatste laag zitten bepaalde protocollen die vaak werken met programma's, Voor mails services zie je SMTP (Simple Mail Transfer Protocol) En voor website/servers heb je vaak HTTP(S).
```

Om te kijken naar wat ik op dit moment precies aan het gebruiken ben van mijn eigen netwerk, zie ik hieronder dat ik een client hello verstuur naar Spotify:

![Alt text](<Screenshots/Screenshot 2023-10-30 140739.png>)

Via onderstaande laat ik ook zien dat ik spotify gebruik maar dan als programma in plaats van via een webbrowser: 

![Alt text](<Screenshots/Screenshot 2023-10-30 141126.png>)

Waarbij bovenstaande protocol MDNS gebruikt, dit is een netwerkprotocol dat wordt gebruikt om binnen een lokaal netwerk te werken zonder centrale DNS-server. Het zorgt voor automatisch communicatie. 

