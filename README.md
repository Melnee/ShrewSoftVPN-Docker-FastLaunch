Description: 
# Shrewsoft VPN Client in an Ubuntu 20.04 Docker Image, Just Add Water!

Shrewsoft VPN Client is an older tool that doesn't work well with any Linux distro past Ubuntu 18.04. https://www.shrew.net/home
But some organizations still use it!
Thankfully, a user called hayfa-abusnina (https://github.com/HayfaAbusnina/ike) created a github repo with install instructions for Shrewsoft on Ubuntu 20.04. This repo of mine is a docker wrapper around that.

This repo will automatically create a docker image in Ubuntu 20.04, install the necessary dependencies, and run Shrewsoft VPN Client in your GUI (provided you have X11 forwarding). Now this functional github solution can be run on any OS, consistently, no matter what environmental changes in the host, forever!

### What a timesaver :D

## Dependencies/Requirements: 
1. docker (https://www.docker.com/)
2. docker compose plugin (https://docs.docker.com/compose/)
3. xhost for X11 forwarding (this allows you to run programs in docker, and actually see the GUI!)
Xhost instructions for max and linux: https://www.businessnewsdaily.com/11035-how-to-use-x11-forwarding.html
Xhost instructions for windows: http://www.straightrunning.com/XmingNotes/

## Instructions:
1. Clone the repo
2. Place your .vpn files into the /vpn_files directory in the root directory of this github repo.
3. Inside the included .env.example file (also root directory of this repo) set the username equal to your desired username. Right now it's set to mine. `ENV USERNAME=melnee` (replace `melnee` with your desired username)
4. (Erase the suffix "example" from it to make it actually work!)
5. Run `xhost +` in a terminal to allow connections from all hosts (if you're in a debian distro! Mac or Windows may have different instructions for x11 forwarding, see above)
6. `sudo docker compose build` to build
7. `sudo docker compose up` to spin up the container
8. `sudo docker ps -a` to list containers. Copy the container id for the container titled something like "something-shrewsoft-vpn"
9. `sudo docker exec -it <CONTAINERID> /bin/bash` to enter container bash
10. `iked` to start the ike service
11. `qikea` to run shrewsoft vpn GUI !

## In the ShrewSoft interface, to import a vpn connection:
1. File
2. Import
3. Navigate to the directory in "Computer" then "/" called "vpn_files"
4. Open whichever one of the vpn files you placed there in Instructions Step 2.

## Credits:
Credit for Github Repo of ShrewSoft VPN on Ubuntu 20.04:
https://github.com/HayfaAbusnina/ike

Credit for tutorial of installation (same guy)
https://hayfa-abusnina.medium.com/installing-shrew-vpn-client-on-ubuntu-20-04-ike-ffcb88a832a1
