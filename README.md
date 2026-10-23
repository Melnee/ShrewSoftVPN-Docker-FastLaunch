Description: 
# Shrewsoft VPN Client in an Ubuntu 20.04 Docker Image, Just Add Water!

Shrewsoft VPN Client is an older tool that doesn't work well with any Linux distro past Ubuntu 18.04. https://www.shrew.net/home
But some organizations still use it!
Thankfully, a user called hayfa-abusnina (https://github.com/HayfaAbusnina/ike) created a github repo with install instructions for Shrewsoft on Ubuntu 20.04. This repo of mine is a docker wrapper around that.

This repo will automatically create a docker image in Ubuntu 20.04, install the necessary dependencies, and run the Shrewsoft IKE daemon headlessly with an auto-reconnecting keepalive loop. Now this functional github solution can be run on any OS, consistently, no matter what environmental changes in the host, forever!

### What a timesaver :D

## Dependencies/Requirements: 
1. docker (https://www.docker.com/)
2. docker compose plugin (https://docs.docker.com/compose/)
3. xfreerdp recommended for your RDP client (to connect once the VPN tunnel is up)

## Setup:
1. Clone the repo
2. Place your `.vpn` config file into the `/vpn_files` directory in the root of this repo.
   - Make sure `s:phase2-transform` and `s:phase2-hmac` are set to specific values (e.g. `aes` / `sha1`) rather than `auto` — `auto` proposes too many transforms and causes some gateways (e.g. Cisco ASA) to terminate the session.
3. Copy `.env.example` to `.env` and fill in the values:
   - `USERNAME` — your local Linux username
   - `RDP_HOST` — IP of the machine you want to RDP into over the VPN
   - `RDP_USER` — RDP username
   - `RDP_BPP` / `RDP_NETWORK` — RDP colour depth and network profile
   - `VPN_FILE_USERNAME` — your XAUTH username for the VPN gateway
   - `VPN_FILE_PASSWORD` — your XAUTH password for the VPN gateway

## Running:
```bash
docker compose up --build
```

The container will:
1. Flush any stale kernel IPsec state
2. Start the IKE daemon (`iked`)
3. Load your VPN config from `/vpn_files/MLM.vpn` into the site store
4. Connect via `ikec` using your credentials from `.env`
5. Monitor the tunnel every 20 seconds — if `ikec` exits or the `tap0` interface disappears, it restarts automatically after 3 consecutive failures

Once the tunnel is up, `tap0` is visible on the host (the container uses `network_mode: host`), so you can RDP directly from the host:
```bash
bash launch_free_rdp.sh
```

## Rebuild vs restart:
- **Script changes** (`entrypoint.sh`, `write_vpn_config.sh`): `docker compose restart` — scripts are volume-mounted, no rebuild needed.
- **VPN config changes** (`vpn_files/MLM.vpn`): `docker compose restart` — also volume-mounted.
- **iked source changes** (anything under `ike_github_repo/`): `docker compose up --build` — the binary must be recompiled.

## Credits:
Credit for Github Repo of ShrewSoft VPN on Ubuntu 20.04:
https://github.com/HayfaAbusnina/ike

Credit for tutorial of installation (same guy)
https://hayfa-abusnina.medium.com/installing-shrew-vpn-client-on-ubuntu-20-04-ike-ffcb88a832a1
