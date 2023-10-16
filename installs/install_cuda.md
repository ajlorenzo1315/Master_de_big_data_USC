
## nvidia driver [link](https://www.nvidia.es/Download/index.aspx?lang=es)

Mi version  


    Linux x64 (AMD64/EM64T) Display Driver
    
    Versione: 	535.113.01
    Fecha de publicación: 	2023.9.21
    Sistema operativo: 	Linux 64-bit
    Idioma: 	Español (España)
    Tamaño: 	325.69 MB 

NVIDIA-Linux-x86_64-535.113.01.run

dar permisos y eejecutar como sudo 

```bash
chmod +x NVIDIA-Linux-x86_64-535.113.01.run

sudo ./NVIDIA-Linux-x86_64-535.113.01.run

```

1. Presione Ctrl+Alt+F1 e inicie sesión con sus credenciales.

2. Detenga su sesión actual del servidor X escribiendo sudo service `lightdm stop` o `sudo lightdm stop`. 

    EN MI CASO ME SALTE ESTE PASO Y PASE DIRECTAMETE AL 3 PUEDE QUE TRAS EJECUTAR SE TENGA QUE HACER UN REBOOT POR UN ERRO CON EL KERBEL 
    DE MOUBEUS

    - On Ubuntu and Debian:

        sudo service gdm stop

    - On Fedora:

        sudo systemctl stop gdm

    - On CentOS and RHEL:

        sudo systemctl stop gdm


3. Ingrese al nivel de ejecución 3 escribiendo sudo init 3.

4. Instale su archivo *.run.

    - Cambie al directorio donde ha descargado el archivo escribiendo, por ejemplo, cd Descargas. Si está en otro directorio, vaya allí. Compruebe si ve el archivo cuando escriba ls NVIDIA*.

    - Haga que el archivo sea ejecutable con chmod +x ./su-archivo-nvidia.run.

    - Ejecute el archivo con sudo ./su-archivo-nvidia.run.

**Nota** Es posible que se le solicite reiniciar cuando termine la instalación. Si no es así, ejecute sudo service lightdm start o sudo start lightdm para volver a iniciar su servidor X.
Vale la pena mencionar que, al instalar de esta manera, deberá repetir los pasos después de cada actualización del kernel.

**NOTA** Pasos para desactivar nouveau, en mi caso eso se podia hacer al lanzar el install del driver de nvidia luego solo hacer el paso 4

1. According to the NVIDIA developer zone: Create a file:

    sudo nano /etc/modprobe.d/blacklist-nouveau.conf

2. With the following contents:

    blacklist nouveau
    options nouveau modeset=0

3. Regenerate the kernel initramfs:

    sudo update-initramfs -u

4. Finally, reboot:

    sudo reboot


nvidia-smi
Sat Oct 14 20:29:57 2023       
+---------------------------------------------------------------------------------------+
| NVIDIA-SMI 535.113.01             Driver Version: 535.113.01   CUDA Version: 12.2     |
|-----------------------------------------+----------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
|                                         |                      |               MIG M. |
|=========================================+======================+======================|
|   0  NVIDIA GeForce RTX 3070 ...    Off | 00000000:01:00.0 Off |                  N/A |
| N/A   38C    P0              25W /  80W |     10MiB /  8192MiB |      0%      Default |
|                                         |                      |                  N/A |
+-----------------------------------------+----------------------+----------------------+
                                                                                         
+---------------------------------------------------------------------------------------+
| Processes:                                                                            |
|  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
|        ID   ID                                                             Usage      |
|=======================================================================================|
|    0   N/A  N/A      2418      G   /usr/lib/xorg/Xorg                            4MiB |
+---------------------------------------------------------------------------------------+


# Install cuda

    chmod +x cuda_install.sh
    ./cuda_install.sh
    reboot

# Install cuDNN 

Consigue el *.deb en este [link](https://developer.nvidia.com/rdp/cudnn-download)

    sudo dpkg -i cudnn-local-repo-ubuntu2204-8.9.5.29_1.0-1_amd64.deb
    sudo cp /var/cudnn-local-repo-ubuntu2204-8.9.5.29/cudnn-local-275FA572-keyring.gpg /usr/share/keyrings/

    sudo apt update
    sudo apt install libcudnn8
    sudo apt install libcudnn8-dev
    sudo apt install libcudnn8-samples