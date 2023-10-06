## R Session Startup Failure Report

### RStudio Version

RStudio 2023.06.2+561 "Mountain Hydrangea " (de44a311, 2023-08-25) for Ubuntu Jammy

Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) rstudio/2023.06.2+561 Chrome/110.0.5481.208 Electron/23.3.0 Safari/537.36

### Error message

[No error available]

### Process Output

The R session exited with code 127. 

Error output:

```
/usr/lib/rstudio/resources/app/bin/rsession: error while loading shared libraries: libpq.so.5: cannot open shared object file: No such file or directory

```

Standard output:

```
[No output emitted]
```

### Logs

*Log File*

```
[No logs available]
```

### SOL

    sudo apt-get install libpq5


### otro error posible


    Leyendo lista de paquetes... Hecho
    Creando árbol de dependencias... Hecho
    Leyendo la información de estado... Hecho
    r-cran-rstan ya está en su versión más reciente (2.21.8-1cran1.2204.0).
    Tal vez quiera ejecutar «apt --fix-broken install» para corregirlo.
    Los siguientes paquetes tienen dependencias incumplidas:
    rstudio : Depende: libssl-dev pero no va a instalarse
            Depende: libclang-dev pero no va a instalarse
    virtualbox-7.0 : Depende: libqt5core5a (>= 5.15.1) pero no va a instalarse
                    Depende: libqt5dbus5 (>= 5.14.1) pero no va a instalarse
                    Depende: libqt5gui5 (>= 5.14.1) pero no va a instalarse o
                            libqt5gui5-gles (>= 5.14.1) pero no va a instalarse
                    Depende: libqt5help5 (>= 5.15.1) pero no va a instalarse
                    Depende: libqt5opengl5 (>= 5.0.2) pero no va a instalarse
                    Depende: libqt5printsupport5 (>= 5.0.2) pero no va a instalarse
                    Depende: libqt5widgets5 (>= 5.15.1) pero no va a instalarse
                    Depende: libqt5x11extras5 (>= 5.6.0) pero no va a instalarse
                    Depende: libqt5xml5 (>= 5.0.2) pero no va a instalarse
                    Recomienda: libsdl-ttf2.0-0 pero no va a instalarse
    E: Dependencias incumplidas. Intente «apt --fix-broken install» sin paquetes (o especifique una solución).

### SOL 

    dpkg --fix-broken install