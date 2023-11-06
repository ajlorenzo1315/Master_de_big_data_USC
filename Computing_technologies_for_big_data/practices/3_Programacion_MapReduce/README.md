

An alternative would be to use ``expect -c`` so the script will be executed using the /bin/bash shell, and to pass the previous responses to the ``expect -c`` command in quotes, escaping them to prevent them from being used as a filename or directory. ``Expect`` also needs to be installed and the shell used would be /bin/bash.

```bash
sudo apt-get install expect
```



module load maven