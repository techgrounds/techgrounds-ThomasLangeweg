# Azure Disk Storage
In deze opdracht ga ik een Managed Disk aanmaken voor 2 VM's

## Key-terms
Managed Disk: Is een virtuele harde schijf wat verdeeld kan worden tussen 2 VMs. 
Snapshot: Punt waar je naartoe kan gaan als backup. 

![Alt text](screenshots/Assgn6-Disktypes01.png)

## Opdracht
### Gebruikte bronnen
https://www.javatpoint.com/linux-mount

https://help.ubuntu.com/community/InstallingANewHardDrive

https://superuser.com/questions/934678/fdisk-do-i-need-it-or-can-i-make-a-filesystem-directly

https://www.howtogeek.com/443342/how-to-use-the-mkfs-command-on-linux/

https://superuser.com/questions/676093/partition-not-showing-up-in-dev

https://docs.microsoft.com/en-us/azure/virtual-machines/disks-types

https://docs.microsoft.com/nl-nl/azure/virtual-machines/managed-disks-overview

### Ervaren problemen
Het lukt mij om op mijn 2de VM mijn bestand te zien welke gemaakt is op mijn eerste VM. Helaas lukt het mij niet om hierop te reageren en het daarna weer te zien op mijn eerste VM. 

### Resultaat
Als eerste heb ik 2 VMs gemaakt en deze opengezet en gekoppeld met SSH:

![Alt text](<Screenshots/Screenshot 2023-11-15 095116.png>)

Daarna een Managed Disk gemaakt, hier zijn er 2 geshared. 

![Alt text](<Screenshots/Screenshot 2023-11-15 100905.png>)

Hierna heb ik een bestand gemaakt in VM1 welke ik wil zien in VM2:

![Alt text](<Screenshots/Screenshot 2023-11-15 151803.png>)
![Alt text](<Screenshots/Screenshot 2023-11-15 151927.png>)

En hier heb ik een snapshot gemaakt van mijn eerdere managed disk en deze gemaakt in de portal:

![Alt text](<Screenshots/Screenshot 2023-11-15 152423.png>)