Instructions:
1. Install docker and docker compose
2. Run `xhost +` to allow connections from all hosts
3. `sudo docker compose build` to build
4. `sudo docker exec -it <CONTAINERNAME> /bin/bash` to enter container bash
5. `iked` to start the ike service
6. `qikea` to run shrewsoft vpn GUI

Credit for Github Repo of ShrewSoft VPN on Ubuntu 20.04:
https://github.com/HayfaAbusnina/ike

Credit for tutorial of installation: 
https://hayfa-abusnina.medium.com/installing-shrew-vpn-client-on-ubuntu-20-04-ike-ffcb88a832a1