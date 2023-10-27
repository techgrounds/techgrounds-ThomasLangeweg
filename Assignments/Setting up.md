# Setting up
Het instellen van je connectie met een VM Linux, ikzelf gebruik Windows dus hierbij heb ik OpenSSH nodig

## Key-terms
1. Virtuel Machine (VM) [x]
2. Secure shell protocol (SSH) [x]

## Opdracht
### Gebruikte bronnen
Voor veel informatie heb ik https://interworks.com/blog/2021/09/22/how-to-access-a-linux-virtual-machine-via-ssh-from-windows/ gebruikt

Aan oud Techgrounds deelnemer Killian ook een vraag gesteld

### Ervaren problemen
Ik heb 2 problemen ervaren:
* Was de port (-p) vergeten toe te voegen in mijn command om connectie te maken met VM het heeft ook niet geholpen dat het niet te zien was in mijn bron.
* Uiteindelijk week ik niet of dit een probleem was maar, de "security" van het .pem bestand aangepast.

### Resultaat
Het installeren van OpenSSH gedaan via Powershell

![Alt text](<Screenshots/Screenshot 2023-10-25 113433.png>)

En connectie gemaakt met VM met de volgende command:

![Alt text](<Screenshots/Screenshot 2023-10-25 113551.png>)

En met de command **whoami** gezien dat ik ben ingelogd

![Alt text](<Screenshots/Screenshot 2023-10-25 113742.png>)