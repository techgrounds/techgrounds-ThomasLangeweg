# ALB & Auto Scaling
Met het in de cloud hoef je vaak niet zelf na te denken over de ruimte dat je nodig hebt. Dit is door Azure automatisch scalable naar hetgeen wat je nodig heb. Dit gebeurt door Azure Load Balancer. In deze opdracht ga ik hier gebruik van maken. 

## Key-terms
1. **Azure Load Balancer**: Je krijgt deze gratis bij een VM Scale Set. De ALB werkt op laag 4 van de OSI stack (TCP/UDP). Een ALB kan alleen routeren naar Azure resources. Het zorgt ervoor dat traffic evenveel verdeeld wordt over bijvoorbeeld VMs. Je hebt hier ook meerdere tiers in, dit is dan Web tier en Data tier. De web tier is hier vaak de public en data tier internal. 
2. **Application Gateway**: Deze load balancer werkt op laag 7 van de OSI stack (HTTP/HTTPS). Ook heeft het support voor onder andere SSL termination en Web Application Firewall (WAF) features. Een Application Gateway kan routeren naar elk routable IP address.

## Opdracht
### Gebruikte bronnen
Klein stukje uitleg van ALB https://www.youtube.com/watch?v=5NMcM4zJPM4&list=PLGjZwEtPN7j-Q59JYso3L4_yoCjj2syrM&index=11&ab_channel=AdamMarczak-AzureforEveryone

Voor demo van VMSS: https://www.youtube.com/watch?v=xD9MVGY216o&ab_channel=CloudTechWorld

### Ervaren problemen
Geen problemen ervaren. 

### Resultaat
In deze opdracht moeten we gebruik maken van auto scaling, hierin heb ik een Virtual Machine Scale Set aangemaakt in Azure, dit moest met de onderstaande vereisten:
* Ubuntu Server 20.04 LTS - Gen1
* Size: Standard_B1ls
* Allowed inbound ports:
* SSH (22)
* HTTP (80)
* OS Disk type: Standard SSD
* Networking: defaults
* Boot diagnostics zijn niet nodig
* Initial Instance Count: 2
* Scaling Policy: Custom
* Aantal VMs: minimaal 1 en maximaal 4
* Voeg een VM toe bij 75% CPU gebruik
* Verwijder een VM bij 30% CPU gebruik

```
Custom data:
#!/bin/bash
sudo su
apt update
apt install apache2 -y
ufw allow 'Apache'
systemctl enable apache2
systemctl restart apache2
```
De resultaten hieronder:
![Alt text](<Screenshots/Screenshot 2023-11-21 095717.png>)

![Alt text](<Screenshots/Screenshot 2023-11-21 095757.png>)

Daarna voor het stress testen heb ik de onderstaande command ingevoerd hierdoor is de eerste VM naar 100% CPU usage gegaan en hierna zijn er 3 bij gekomen. 

![Alt text](<Screenshots/Screenshot 2023-11-21 112558.png>)

![Alt text](<Screenshots/Screenshot 2023-11-21 112545.png>)
