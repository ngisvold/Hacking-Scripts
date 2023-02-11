#!/bin/bash

# Define target IP address
TARGET_IP="192.168.0.1"

# Port scanning
echo "Port scanning $TARGET_IP..."
for port in {1..65535}; do
    hping3 -c 1 -p $port $TARGET_IP > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Port $port is open"
    fi
done

# Network segmentation testing
echo "Testing network segmentation..."
hping3 -c 1 -p 80 $TARGET_IP > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Target is accessible on port 80"
else
    echo "Target is not accessible on port 80"
fi

# Firewall testing
echo "Testing firewall rules..."
hping3 -c 1 -p 22 --flood $TARGET_IP > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Firewall rules are not effective"
else
    echo "Firewall rules are effective"
fi

# TCP/IP protocol testing
echo "Testing TCP/IP protocols..."
hping3 -c 1 -S $TARGET_IP > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "TCP protocol is working"
else
    echo "TCP protocol is not working"
fi
hping3 -c 1 -2 $TARGET_IP > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "UDP protocol is working"
else
    echo "UDP protocol is not working"
fi
hping3 -c 1 -1 $TARGET_IP > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "ICMP protocol is working"
else
    echo "ICMP protocol is not working"
fi

# Network performance testing
echo "Testing network performance..."
hping3 -c 100 -i u1000 $TARGET_IP
