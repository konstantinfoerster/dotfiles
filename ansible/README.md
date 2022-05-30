# Archlinux installation

* Press tab inside the live disk boot menu and add `cow_spacesize=1G` to the boot parameter
* Set the correct keyboard layout via `loadkeys de`.  
* Install pip `curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py`
* Install ansible `pip install ansible`
* Check if efi or bios `ls /sys/firmware/efi*`
* Plugin network cable if not already done

* Run `ansible-pull -U https://github.com/konstantinfoerster/dotfiles/ansible/main.yml --tags wipe` to erase the existing crypted device and all partitions
* Run `ansible-pull -U https://github.com/konstantinfoerster/dotfiles/ansible/main.yml --tags storage` to setup the disk and encrypt it
* Run `arch-chroot /mnt/` to change into archlinux installation
* Run `ansible-pull -U https://github.com/konstantinfoerster/dotfiles/ansible/main.yml` to setup the complete system
* Run `exit` to exit the chroot
* Run `umount -a` to unmount all devices
* Run `reboot`




# Vscode settings
`"keyboard.dispatch": "keyCode"`

# Gnome

* Reset dconf `dconf reset -f /`
* Backup gnome settings `dconf dump / > saved_settings.dconf`.
* Load Backup `dconf load / < saved_settings.dconf`