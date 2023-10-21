
pip3 install jupyter_contrib_nbextensions
pip3 install pandoc

jupyter nbconvert  2_analisis_exploratorio_v2.ipynb --to pdf

error

nbconvert.utils.pandoc.PandocMissing: Pandoc wasn't found.

wget https://github.com/jgm/pandoc/releases/download/3.1.8/pandoc-3.1.8-1-amd64.deb
sudo dpkg -i  pandoc-3.1.8-1-amd64.deb
