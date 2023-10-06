## Error install docker

Hit:1 http://es.archive.ubuntu.com/ubuntu jammy InRelease
Get:2 https://download.docker.com/linux/ubuntu jammy InRelease [48,9 kB]   
Hit:3 http://es.archive.ubuntu.com/ubuntu jammy-updates InRelease                                       
Hit:4 http://es.archive.ubuntu.com/ubuntu jammy-backports InRelease                                     
Err:2 https://download.docker.com/linux/ubuntu jammy InRelease
  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 7EA0A9C3F273FCD8
Hit:5 http://security.ubuntu.com/ubuntu jammy-security InRelease
Reading package lists... Done
W: GPG error: https://download.docker.com/linux/ubuntu jammy InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 7EA0A9C3F273FCD8
E: The repository 'https://download.docker.com/linux/ubuntu jammy InRelease' is not signed.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.


```bash
$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7EA0A9C3F273FCD8
Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).
Executing: /tmp/apt-key-gpghome.69FzBXI9fQ/gpg.1.sh --keyserver keyserver.ubuntu.com --recv-keys 7EA0A9C3F273FCD8
gpg: key 8D81803C0EBFCD88: 1 duplicate signature removed
gpg: key 8D81803C0EBFCD88: public key "Docker Release (CE deb) <docker@docker.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1

```
voy a eliminar esto


sudo add-apt-repository --remove "deb [arch=amd64] https://download.docker.com/linux/ubuntu jammy stable"

y avolver añadirlo 

sol 
al instalar virtual vox puede dar fallos que se interponga en con la instalación de docker

```bash
sudo apt --fix-broken install -y
```

### Vitual box

The VirtualBox Linux kernel driver is either not loaded or not set up correctly. Please try setting it up again by executing '/sbin/vboxconfig' as root. If your system has EFI Secure Boot enabled you may also need to sign the kernel modules (vboxdrv, vboxnetflt, vboxnetadp, vboxpci) before you can load them. Please see your Linux system's documentation for more information. where: suplibOsInit what: 3 VERR_VM_DRIVER_NOT_INSTALLED (-1908) - The support driver is not installed. On linux, open returned ENOENT.



This system is currently not set up to build kernel modules.
Please install the gcc make perl packages from your distribution.
This system is currently not set up to build kernel modules.
Please install the gcc make perl packages from your distribution.

There were problems setting up VirtualBox.  To re-start the set-up process, run
  /sbin/vboxconfig
as root.  If your system is using EFI Secure Boot you may need to sign the
kernel modules (vboxdrv, vboxnetflt, vboxnetadp, vboxpci) before you can load
them. Please see your Linux system's documentation for more information.
