#!/bin/bash
#
# Will update duckdns.org entry given HOSTNAME and TOKEN
#

HOSTNAME='add_hostname_here'
TOKEN='add-your-token-here'

PUBLIC_IPV4=$(curl --silent --insecure checkip.amazonaws.com)
CURRENT_IPV4=$(dig ${HOSTNAME}.duckdns.org +short -4)
URL="https://www.duckdns.org/update?domains=${HOSTNAME}&token=${TOKEN}&ip="

if [[ "$PUBLIC_IPV4" != "$CURRENT_IPV4" ]]; then
  log_msg="IP has changed from $CURRENT_IPV4 to $PUBLIC_IPV4 - "
  exitcode=$(echo url="${URL}" | curl --silent --insecure --config -)
  log_msg+=$exitcode
else
  log_msg="IP has not changed from $CURRENT_IPV4 - no changes made"
fi
logger -t duckdns "DDNS update of hostname='$HOSTNAME' $log_msg"
