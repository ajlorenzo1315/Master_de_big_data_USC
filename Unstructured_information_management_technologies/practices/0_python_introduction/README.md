Install anaconda
using python 2.7

    chmod +x Anaconda3-2023.07-2-Linux-x86_64.sh
    ./Anaconda3-2023.07-2-Linux-x86_64.sh

creamos un entorno con Python 2.7

    conda create -y -n py27 python=2.7 


Instalamos los paquetes necesarios

    pip install -r requirements.txt

Lanzamos jupyter notebook

    jupyter-notebook     