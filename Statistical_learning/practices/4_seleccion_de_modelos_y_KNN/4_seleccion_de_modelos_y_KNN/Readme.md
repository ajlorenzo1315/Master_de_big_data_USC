#### usar 

screen para dejar cosas ejecutadas

si
```bash
screen
```
para salir 

teclas:

ctrl+a

luego

tecla: 
d

para recurara la seison de screen

```bash
screen -r 
```

copiamos los archivos necesarios

```bash
scp *ipynb cursoxxx@hadoop3.cesga.es:/home/usc/cursos/curso111/AE/4_seleccion_de_modelos_y_KNN
```


**por el momento crearemos un entorno en caso de que no pueda acceder al cesga**

conda create -n AE python=3.11.5


scp 4_seleccion_de_modelos_y_KNN  cursoxxx@hadoop3.cesga.es:~/AE

ssh  cursoxxx@hadoop3.cesga.es

scp -r energy+efficiency cursoxxx@hadoop3.cesga.es:/home/usc/cursos/curso111/AE/4_seleccion_de_modelos_y_KNN/data

screen 

ctr+a d

screen -r