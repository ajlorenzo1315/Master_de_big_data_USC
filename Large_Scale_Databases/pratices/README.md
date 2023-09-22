Usamos maquinas virtuales


#### GreiBD Desktop

    Máquina virtual con software de cliente y servidor.

    Usuario: alumnogreibd

    Contraseña: greibd2021

    Software Instalado:

        Sistema Operativo lubuntu 20.04.2 LTS
        Navegador Firefox
        OpenJDK 11.0.11
        PostgreSQL
        MySQL
        Cliente SQL DBeaver Community
        Citus Data para PostgreSQL
        MongoDB
        Cliente Compass para MongoDB
        Neo4J
        HBase 2.3.5 Standalone
        Pentaho 9.1
            Pentaho Server
            Pentaho Data Integration
            Schema Workbench
            Report Designer
            Saiku Analytics
        Apache NetBeans

    Aumentar Tamaño del Disco:

        Aumentar el tamaño del disco en Virtual Box.
        Comprobar el tamaño del disco con el comando "df -h"
        Aumentar el tamaño de la partición: "sudo cfdisk". Opción de menú "Resize". Antes de salir guardar los cambio con "Write" (elegir "yes" para confirmar). 
        sudo resize2fs -p /dev/sda1
        Volvemos a comprobar el nuevo tamaño con "df -h"


#### GreiBD Server Base

    Máquina virtual con software de servidor utilizada para simular pequeños clusters.

    Usuario: alumnogreibd

    Contraseña: greibd2021

    Software Instalado:

        Sistema Operativo Ubuntu Server 20.04.1 LTS
        PostgreSQL
        Citus Data para PostgreSQL
        MongoDB

    Aumentar tamaño del disco:

        Aumentar el tamaño del disco en Virtual Box.
        Comprobar el tamaño del disco con el comando "df -h"
        Aumentar el tamaño de la partición: "sudo cfdisk". Opción de menú "Resize". Antes de salir guardar los cambio con "Write" (elegir "yes" para confirmar). 
        sudo pvresize /dev/sda3
        sudo lvextend -L +Xg /dev/mapper/ubuntu--vg-ubuntu--lv (X es el número de GB con el que hemos extendido el disco)
        sudo resize2fs -p /dev/mapper/ubuntu--vg-ubuntu--lv
        Comprobar de nuevo el tamaño del disco con "df -h"

Para esta maquina virtual usamos 3 maquinas virtuales por los que usaamos 2 clones hay que llamarle citius2, citius3    
Al clonar hay que escoger crear una nueva mac   y en la siguiente ventana hay que selecionar la clonación completa 
