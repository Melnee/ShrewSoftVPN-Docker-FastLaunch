#!/bin/bash
SITE="MLM"
INTERVAL=20
FAILS=0
MAX_FAILS=3

ip xfrm state flush
ip xfrm policy flush

iked -F -d 3 > /var/log/iked.log 2>&1 &
sleep 2

bash /usr/local/bin/write_vpn_config.sh

setsid ikec -r "$SITE" -u "$VPN_FILE_USERNAME" -p "$VPN_FILE_PASSWORD" -a \
  >/var/log/ikec.log 2>&1 &

sleep 10

printf "VPN Logs (ikec):\n"
tail -n 10 /var/log/ikec.log
printf "\nVPN Logs (iked):\n"
tail -n 30 /var/log/iked.log

i=0
while true; do
  printf "KEEPALIVE pid=%d iter=%d epoch=%s\n" "$$" "$i" "$(date '+%m/%d %I:%M:%S %p')"
  i=$((i + 1))

  healthy=true
  pgrep -x ikec >/dev/null || healthy=false
  ip link show tap0 >/dev/null 2>&1 || healthy=false

  if [ "$healthy" = false ]; then
    FAILS=$((FAILS + 1))
    echo "VPN unhealthy (fail $FAILS/$MAX_FAILS)"
  else
    FAILS=0
    echo "VPN healthy"
  fi

  if (( FAILS >= MAX_FAILS )); then
    echo "VPN unhealthy, restarting ikec"
    pkill ikec
    sleep 5
    pkill -9 ikec
    setsid ikec -r "$SITE" -u "$VPN_FILE_USERNAME" -p "$VPN_FILE_PASSWORD" -a \
      >/var/log/ikec.log 2>&1 &
    FAILS=0
  fi

  sleep "$INTERVAL"
done
