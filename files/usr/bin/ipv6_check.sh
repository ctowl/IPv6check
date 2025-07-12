#!/bin/sh

INTERFACE="eth2"
TAG="IPv6_Check"

if ! ip -6 addr show "$INTERFACE" >/dev/null 2>&1; then
    logger -t "$TAG" "$INTERFACE not found"
    exit 1
fi

IPV6_COUNT=$(ip -6 addr show dev "$INTERFACE" | grep -v 'fe80::' | grep -c 'inet6 ')

logger -t "$TAG" "$INTERFACE IPv6 count is $IPV6_COUNT"

if [ "$IPV6_COUNT" -le 1 ] || [ "$IPV6_COUNT" -ge 3 ]; then
    logger -t "$TAG" "$INTERFACE IPv6 count abnormal ($IPV6_COUNT), restarting wan6..."
    ifdown wan6
    sleep 2
    ifup wan6
    sleep 5
fi
