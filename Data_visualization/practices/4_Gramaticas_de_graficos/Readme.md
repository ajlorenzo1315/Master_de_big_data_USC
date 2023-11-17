## Instalar R kernel para jupyternotebook

Asegúrate de tener R instalado en tu sistema. Si aún no tienes R instalado, puedes descargarlo desde el sitio oficial de R: https://cran.r-project.org/

Instala Jupyter Notebook si aún no lo tienes instalado. Puedes hacerlo utilizando pip (el gestor de paquetes de Python) con el siguiente comando:

pip install jupyter

Instala el paquete IRkernel en R. Abre R o RStudio y ejecuta los siguientes comandos:

R

install.packages('IRkernel')
IRkernel::installspec(user = FALSE)

El primer comando instalará el paquete IRkernel, y el segundo comando registrará el kernel de R en Jupyter Notebook. Asegúrate de ejecutar estos comandos en una sesión de R.

Inicia Jupyter Notebook ejecutando el siguiente comando en tu terminal o consola:

jupyter notebook

Esto abrirá Jupyter Notebook en tu navegador web.

En Jupyter Notebook, crea un nuevo cuaderno seleccionando "Nuevo" en la parte superior de la página y elige el kernel de R que debería estar disponible.

error 

> IRkernel::installspec(user = FALSE)
Error in IRkernel::installspec(user = FALSE) : 
  jupyter-client has to be installed but “jupyter kernelspec --version” exited with code 127.
In addition: Warning message:
In system2("jupyter", c("kernelspec", "--version"), FALSE, FALSE) :
  error in running command


Crea un nuevo entorno de Conda que incluya R e instala Jupyter Notebook:

```bash

conda create -n r_env r jupyter

```
Esto creará un nuevo entorno llamado r_env con R y Jupyter Notebook instalados.

Activa el entorno de Conda que acabas de crear:

```bash

conda activate r_env
```
Instala el paquete IRkernel en el entorno de Conda:

```bash

R -e "install.packages('IRkernel', repos='https://cloud.r-project.org/')"
```

Registra el kernel de R en Jupyter Notebook en el entorno de Conda:

```bash

R -e "IRkernel::installspec(user = FALSE)"
```

Inicia Jupyter Notebook en el entorno de Conda:

```bash

jupyter notebook
```
