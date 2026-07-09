#!/bin/bash
# Steam Deck Storage Cleanup

case "$1" in
-update) if [ "$(curl https://raw.githubusercontent.com/Wakelock/SteamDeckStorageCleanup/refs/heads/main/version.txt)" = "20260709" ]
then
  echo "The cleanup script is up to date."
else
  echo "Warning: you're offline, or this version is outdated."
fi
exit
esac

prev_storage=$(df --output=avail -B1 /home | tail -1)

# General cleanup
flatpak uninstall --unused
rm -rf ~/.dvdcss

# Steam cleanup
rm -rf ~/.local/share/Steam/appcache/librarycache/
rm -rf ~/.local/share/Steam/logs
rm -rf ~/.steam/steam/depotcache
rm -rf ~/.steam/steam/steamapps/downloading
rm -rf ~/.steam/steam/steamapps/shadercache

# Optional
case "$1" in
-sudo)
sudo steamos-readonly disable
echo Deleting cache...
sudo chattr -i /var/cache
sudo pacman -Scc <<<'y'
sudo rm -rf ~/.cache
sudo rm -rf /home/lost+found
sudo rm -rf /var/cache
sudo rm -rf /var/log
echo Uninstalling bloatware...
sudo pacman -R cups-pdf <<<'y'
sudo pacman -R cups <<<'y'
sudo pacman -R okular <<<'y'
sudo pacman -R plasma-meta <<<'y'
sudo pacman -R plasma-welcome <<<'y'
echo Disbling Swap...
sudo swapoff --all
sudo rm -r /home/swapfile
esac

curr_storage=$(df --output=avail -B1 /home | tail -1)
freed_storage=$(( curr_storage - prev_storage ))
echo "Successfully freed $(( freed_storage )) KB"
