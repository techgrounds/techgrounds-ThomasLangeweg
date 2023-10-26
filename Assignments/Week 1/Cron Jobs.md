# Cron Jobs
Het uitvoeren van processen op aangewezen tijden/momenten

## Key-terms
1. Cron Jobs [x]

## Opdracht
### Gebruikte bronnen
Voor het maken van een cron job https://www.digitalocean.com/community/tutorials/how-to-use-cron-to-automate-tasks-ubuntu-1804

&

https://www.cyberciti.biz/faq/how-do-i-add-jobs-to-cron-under-linux-or-unix-oses/


### Ervaren problemen
Alleen dat de tijdzone niet ingesteld was op Europa/Amsterdam, deze heb ik aangepast door **sudo tiedatectl set-timezone Europe/Amsterdam** te gebruiken.

Het is mij ook niet gelukt om permission te krijgen tot /var/log.

### Resultaat
Onderstaande script aangemaakt voor de datum en huidige tijd:

![Alt text](<Screenshots/Screenshot 2023-10-26 134224.png>)

Door crontab -e te gebruiken de onderstaande job er in gezet, hier * * * * * gebruikt omdat dit elke minuut moet gebeuren:

![Alt text](<Screenshots/Screenshot 2023-10-26 134359.png>)

En hier het resultaat

![Alt text](<Screenshots/Screenshot 2023-10-26 134454.png>)

Hierbij ook de opdracht en hoe ik wekelijks een txt bestand heb met de diskspace:

![Alt text](<Screenshots/Screenshot 2023-10-26 141902.png>)
