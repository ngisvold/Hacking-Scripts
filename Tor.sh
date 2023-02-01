#!/bin/bash

#install and use the Tor proxy for internet traffic

# Update the package list and install Tor
sudo apt-get update
sudo apt-get install tor -y

# Start the Tor service
sudo service tor start

# Set the environment variable for http_proxy and https_proxy to use Tor as a proxy
export http_proxy="socks5://127.0.0.1:9050"
export https_proxy="socks5://127.0.0.1:9050"

# Test internet connection using curl command
curl --silent https://check.torproject.org/ | grep Congratulations
