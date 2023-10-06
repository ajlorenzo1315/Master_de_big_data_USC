x86_64-pc-linux-gnu-library/4.3/rmarkdown/rmarkdown/lua/pagebreak.lua --lua-filter /home/alourido/R/x86_64-pc-linux-gnu-library/4.3/rmarkdown/rmarkdown/lua/latex-div.lua --embed-resources --standalone --highlight-style tango --pdf-engine pdflatex --variable graphics --variable 'geometry:margin=1in' 
output file: 1_Analisis_descriptivo_de_conjunto_de_datos.knit.md

! sh: 1: pdflatex: not found

Error: LaTeX failed to compile 1_Analisis_descriptivo_de_conjunto_de_datos.tex. See https://yihui.org/tinytex/r/#debugging for debugging tips. See 1_Analisis_descriptivo_de_conjunto_de_datos.log for more info.
In addition: Warning message:
In system2(..., stdout = if (use_file_stdout()) f1 else FALSE, stderr = f2) :
  error in running command
Execution halted

No LaTeX installation detected (LaTeX is required to create PDF output). You should install a LaTeX distribution for your platform: https://www.latex-project.org/get/

  If you are not sure, you may install TinyTeX in R: tinytex::install_tinytex()

  Otherwise consider MiKTeX on Windows - http://miktex.org

  MacTeX on macOS - https://tug.org/mactex/
  (NOTE: Download with Safari rather than Chrome _strongly_ recommended)

  Linux: Use system package manager

sol

sudo apt-get install texlive-full


error

------------------------- ANTICONF ERROR ---------------------------
Configuration failed because libxml-2.0 was not found. Try installing:
 * deb: libxml2-dev (Debian, Ubuntu, etc)
 * rpm: libxml2-devel (Fedora, CentOS, RHEL)
 * csw: libxml2_dev (Solaris)
If libxml-2.0 is already installed, check that 'pkg-config' is in your
PATH and PKG_CONFIG_PATH contains a libxml-2.0.pc file. If pkg-config
is unavailable you can set INCLUDE_DIR and LIB_DIR manually via:
R CMD INSTALL --configure-vars='INCLUDE_DIR=... LIB_DIR=...'
--------------------------------------------------------------------


sudo apt-get install libfontconfig1-dev libcurl4-openssl-dev libfontconfig1-dev 

Error export pdf 



processing file: 1_Analisis_descriptivo_de_conjunto_de_datos.Rmd
                                                                                                            
output file: 1_Analisis_descriptivo_de_conjunto_de_datos.knit.md

Error: Functions that produce HTML output found in document targeting latex output.
Please change the output type of this document to HTML.
If your aiming to have some HTML widgets shown in non-HTML format as a screenshot,
please install webshot or webshot2 R package for knitr to do the screenshot.
Alternatively, you can allow HTML output in non-HTML formats
by adding this option to the YAML front-matter of
your rmarkdown file:

  always_allow_html: true

Note however that the HTML output will not be visible in non-HTML formats.

Execution halted
