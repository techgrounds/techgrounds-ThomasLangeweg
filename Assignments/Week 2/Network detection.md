# Network detection
Je moet je netwerk analyseren en met deze opdracht, ook met deze opdracht kijk ik weer naar Wireshark en iets nieuws NMAP in linux. 

## Key-terms
1. NMAP [x]
2. Wireshark [x]

## Opdracht
### Gebruikte bronnen
Voor het gebruik van NMAP in Ubuntu: https://linuxhint.com/use-nmap-command-ubuntu/

### Ervaren problemen
Bij heel veel commands zie ik vaak het "permission denied" het is soms lastig daar omheen te werken. 

### Resultaat
Met de opdracht voor het gebruiken van NMAP zie ik alle connecties met de IP adres van de VM. Alleen zie ik hier niet wie en wat geconnect is, alleen de hoeveelheid en welk subnet er gebruikt wordt. Als eerst NMAP geinstalleerd via command **sudo apt install nmap**
En hierna command **sudo nmap -sn 3.121.40.175/24** om te zoeken naar alle host:

![Alt text](<Screenshots/Screenshot 2023-11-06 101440.png>)

Om verder te zoeken in Wireshark is de volgende opdracht om te kijken naar een connectie met Zoom, de betreffende packages zijn voor mij lastig te vinden met encryptie. Wel zie ik als ik online de browser open van Zoom het volgende verschijnen op Wireshark:

![Alt text](<Screenshots/Screenshot 2023-11-06 102558.png>)
