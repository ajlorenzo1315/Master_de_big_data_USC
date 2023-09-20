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