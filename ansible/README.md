# Archlinux installation

* Download latest archlinux iso and write it to your preferred device
* Boot to the device, inside the boot menu press tab and add `cow_spacesize=1G` to the boot parameter
* Set the correct keyboard layout via `loadkeys de`
* Plugin network cable if not already done
* Check if efi or bios `ls /sys/firmware/efi*`
  * This project is only for systems with bios
* Install pip `curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py`
* Install ansible `pip install ansible`
* Install git `pacman -Syy && pacman -S git`
* Clone the dotfiles repository `git clone https://github.com/konstantinfoerster/dotfiles.git`
* Change into the dotfiles ansible dir `cd dotfiles/ansible`
* Copy `example.config.yml` to `config.yml` and make your system dependent changes
* To run an installation with storage wipe run `ansbile-playbook -K main.yml -t wipe -t storage -t prepare`
* Run `umount -a` to unmount all devices
* Run `reboot`

# Gnome

* Reset dconf `dconf reset -f /`
* Backup gnome settings `dconf dump / > saved_settings.dconf`
* Load Backup `dconf load / < saved_settings.dconf`

## Lint

Run `ansible-lint`

# TODO
* Rollout Chrome configuration
