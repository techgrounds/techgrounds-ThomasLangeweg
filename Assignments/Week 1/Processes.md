# Processes
Hoe Linux in elkaar zit, is in 3 categorieën: Daemons, Services en Programs. Hier leer ik een beetje over daemons.

## Key-terms
1. Telnet [x]
2. Daemon [x]
3. PID [x]

## Opdracht
### Gebruikte bronnen
Voor command en info https://www.howtoforge.com/how-to-install-and-use-telnet-on-ubuntu/ 

### Ervaren problemen
Het was lastig informatie vinden online, verschillende bronnen gaven andere commands en install weer. 

### Resultaat
Met command **sudo apt install telnetd -y** heb ik een daemon geinstalleerd. 

Hierna door **sudo systemctl status inetd** de status bekeken met als antwoord PID 4276 en 844.0k memory

Door command **sudo killall inetd** proces gestopt.

![Alt text](<Screenshots/Screenshot 2023-10-26 091258.png>)