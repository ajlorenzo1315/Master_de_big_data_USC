#### Error
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/sass’
ERROR: dependencies ‘lifecycle’, ‘rlang’, ‘vctrs’ are not available for package ‘hms’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/hms’
ERROR: dependencies ‘rlang’, ‘htmltools’ are not available for package ‘fontawesome’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/fontawesome’
ERROR: dependency ‘htmltools’ is not available for package ‘jquerylib’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/jquerylib’
ERROR: dependencies ‘cli’, ‘glue’, ‘lifecycle’, ‘magrittr’, ‘rlang’, ‘stringi’, ‘vctrs’ are not available for package ‘stringr’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/stringr’
ERROR: dependencies ‘cli’, ‘fansi’, ‘glue’, ‘lifecycle’, ‘rlang’, ‘utf8’, ‘vctrs’ are not available for package ‘pillar’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/pillar’
ERROR: dependency ‘hms’ is not available for package ‘progress’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/progress’
ERROR: dependencies ‘base64enc’, ‘cachem’, ‘htmltools’, ‘jquerylib’, ‘jsonlite’, ‘memoise’, ‘mime’, ‘rlang’, ‘sass’ are not available for package ‘bslib’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/bslib’
ERROR: dependencies ‘fansi’, ‘lifecycle’, ‘magrittr’, ‘pillar’, ‘rlang’, ‘vctrs’ are not available for package ‘tibble’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/tibble’
ERROR: dependencies ‘bit64’, ‘cli’, ‘glue’, ‘hms’, ‘lifecycle’, ‘rlang’, ‘tibble’, ‘tidyselect’, ‘tzdb’, ‘vctrs’, ‘progress’ are not available for package ‘vroom’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/vroom’
ERROR: dependency ‘tibble’ is not available for package ‘usdata’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/usdata’
ERROR: dependencies ‘cli’, ‘glue’, ‘gtable’, ‘isoband’, ‘lifecycle’, ‘rlang’, ‘scales’, ‘tibble’, ‘vctrs’ are not available for package ‘ggplot2’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/ggplot2’
ERROR: dependencies ‘bslib’, ‘fontawesome’, ‘htmltools’, ‘jquerylib’, ‘jsonlite’, ‘knitr’, ‘stringr’, ‘tinytex’, ‘xfun’, ‘yaml’ are not available for package ‘rmarkdown’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/rmarkdown’
ERROR: dependencies ‘cli’, ‘hms’, ‘lifecycle’, ‘rlang’, ‘tibble’, ‘vroom’, ‘tzdb’ are not available for package ‘readr’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/readr’
ERROR: dependencies ‘usdata’, ‘ggplot2’, ‘readr’, ‘rmarkdown’, ‘tibble’ are not available for package ‘openintro’
* removing ‘/home/alourido/R/x86_64-pc-linux-gnu-library/4.3/openintro’

The downloaded source packages are in
	‘/tmp/RtmpamVVC2/downloaded_packages’


✔ Package 'openintro' successfully installed.
There were 50 or more warnings (use warnings() to see the first 50)


#### Sol
No se pude usar la version de r-base si se quieren intalar paquetes
    # install r
    sudo apt install --no-install-recommends r-base-dev

    # 5000+ CRAN Packages
    sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+
    sudo apt install --no-install-recommends r-cran-rstan

