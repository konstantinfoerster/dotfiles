# Archlinux installation

* Press tab inside the live disk boot menu and add `cow_spacesize=1G` to the boot parameter
* Set the correct keyboard layout via `loadkeys de`.  
* Plugin network cable if not already done
* Install pip `curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py`
* Install ansible `pip install ansible`
* Check if efi or bios `ls /sys/firmware/efi*`
* Clone the dotfiles repository `git clone https://github.com/konstantinfoerster/dotfiles`
* Change into the dotfiles ansible dir `cd dotfiles/ansible`
* TODO change settings to match your preferences
* To run an installation with storage wipe run `ansbile-playbook -K base_install.yml -t wipe -t storage -prepare`
* Run `umount -a` to unmount all devices
* Run `reboot`

# Gnome

* Reset dconf `dconf reset -f /`
* Backup gnome settings `dconf dump / > saved_settings.dconf`.
* Load Backup `dconf load / < saved_settings.dconf`