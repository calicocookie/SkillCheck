#!/bin/sh

set -e

R -f install_pkgs.R
rm install_pkgs.R
git clone --recursive https://github.com/microsoft/LightGBM
cd LightGBM
Rscript build_r.R
cd ..
rm -rf LightGBM
