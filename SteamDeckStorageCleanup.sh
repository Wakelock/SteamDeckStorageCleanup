#!/bin/bash
# Steam Deck Storage Cleanup (2026 version)
# Note: this script should only be ran if one desperately needs storage.
# If there's still too little space afterwards, try replacing flatpaks with native apps.

# General cleanup
flatpak uninstall --unused
rm -rf ~/.dvdcss

# Steam cleanup
rm -rf ~/.local/share/Steam/appcache/librarycache/
rm -rf ~/.local/share/Steam/logs
rm -rf ~/.steam/steam/depotcache
rm -rf ~/.steam/steam/steamapps/downloading
rm -rf ~/.steam/steam/steamapps/shadercache

# Sudo cleanup (optional)
sudo steamos-readonly disable
sudo chattr -i /var/cache
sudo pacman -Scc
sudo rm -rf ~/.cache
sudo rm -rf /home/lost+found
sudo rm -rf /var/cache
sudo rm -rf /var/log

# Swap cleanup (optional)
sudo swapoff --all
sudo rm -r /home/swapfile

# System bloatware cleanup (optional)
sudo pacman -R cups-pdf
sudo pacman -R cups
sudo pacman -R kdeconnect
sudo pacman -R okular
sudo pacman -R plasma-meta
sudo pacman -R plasma-welcome
