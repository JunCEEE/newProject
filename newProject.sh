#!/bin/bash
# This script to create a well-structured project directory is inspired by this article http://arxiv.org/abs/1609.00037, which can also by found on github: https://swcarpentry.github.io/good-enough-practices-in-scientific-computing/.

if [ ! $1 ]; then
    echo usage: $0 projectName
else
echo project name: $1

PROJDIR=${1}Project
# Put each project in its own directory
mkdir $PROJDIR
cd $PROJDIR

# Put text documents associated with the project in the doc directory
mkdir -p doc/manuscript
echo "put manuscripts here" > doc/manuscript/README

mkdir -p doc/lab_notebook
echo "put laboratory logs here" > doc/lab_notebook/README

# Put raw data and metadata in a data directory
# the data directory might require subdirectories to organize raw data based on time, method of collection, or other metadata most relevant to your analysis.
mkdir -p data/simulation
echo "put simulation raw data here" > data/simulation/README

mkdir -p data/experiment
echo "put experiment raw data here" > data/experiment/README

# Put files generated during cleanup and analysis in a results directory
mkdir -p results/processed_data
echo "put processed data sets, figures and tables here" > results/processed_data/README

mkdir -p results/figs
echo "put figures here" > results/figs/README

mkdir -p results/tables
echo "put tables here" > results/tables/README

# Put project source code in the src directory
mkdir -p src/controller
echo "put run scripts, control scripts here" > src/controller/README

mkdir -p src/analysis
echo "put analysis scripts here" > src/analysis/README

mkdir -p src/program
echo "put program develop codes here" > src/program/README

cat << EOF > src/sync.sh
#!/bin/bash

rsync -r  ../results/figs ../doc/manuscript
EOF
chmod +x src/sync.sh

# Add cleanBig to get rid of large simulation output
cat << 'EOF' > cleanBig.sh
#!/bin/bash
# This script is to clean up big files in a git repository
# From https://bit.ly/2kdQrl9

find . -size +40M | sed 's|^\./||g' >> .gitignore
echo "$(awk '!NF || !seen[$0]++' .gitignore)" >  .gitignore
cat .gitignore
EOF
chmod +x  cleanBig.sh

# Add .gitignore
cat << 'EOF' > .gitignore
## Mac OS:
.root
.vscode
*.DS_Store

## Jupyter
.ipynb_checkpoints

## CPP
# Prerequisites
*.d

# Compiled Object files
*.slo
*.lo
*.o
*.obj

# Precompiled Headers
*.gch
*.pch

# Compiled Dynamic libraries
*.so
*.dylib
*.dll

# Fortran module files
*.mod
*.smod

# Compiled Static libraries
*.lai
*.la
*.a
*.lib

# Executables
*.exe
*.out
*.app

## Latex:
## Core latex/pdflatex auxiliary files:
*.aux
*.lof
*.log
*.lot
*.fls
*.out
*.toc
*.fmt
*.fot
*.cb
*.cb2
.*.lb

## Intermediate documents:
*.dvi
*.xdv
*-converted-to.*
# these rules might exclude image files for figures etc.
# *.ps
# *.eps
# *.pdf

## Generated if empty string is given at "Please type another file name for output:"
.pdf

## Bibliography auxiliary files (bibtex/biblatex/biber):
*.bbl
*.bcf
*.blg
*-blx.aux
*-blx.bib
*.run.xml

## Build tool auxiliary files:
*.fdb_latexmk
*.synctex
*.synctex(busy)
*.synctex.gz
*.synctex.gz(busy)
*.pdfsync

## Build tool directories for auxiliary files
# latexrun
latex.out/

## Auxiliary and intermediate files from other packages:
# algorithms
*.alg
*.loa

# achemso
acs-*.bib

# amsthm
*.thm

# beamer
*.nav
*.pre
*.snm
*.vrb

# changes
*.soc

# comment
*.cut

# cprotect
*.cpt

# elsarticle (documentclass of Elsevier journals)
*.spl

# endnotes
*.ent

# fixme
*.lox

# feynmf/feynmp
*.mf
*.mp
*.t[1-9]
*.t[1-9][0-9]
*.tfm

#(r)(e)ledmac/(r)(e)ledpar
*.end
*.?end
*.[1-9]
*.[1-9][0-9]
*.[1-9][0-9][0-9]
*.[1-9]R
*.[1-9][0-9]R
*.[1-9][0-9][0-9]R
*.eledsec[1-9]
*.eledsec[1-9]R
*.eledsec[1-9][0-9]
*.eledsec[1-9][0-9]R
*.eledsec[1-9][0-9][0-9]
*.eledsec[1-9][0-9][0-9]R

# glossaries
*.acn
*.acr
*.glg
*.glo
*.gls
*.glsdefs
*.lzo
*.lzs

# uncomment this for glossaries-extra (will ignore makeindex's style files!)
# *.ist

# gnuplottex
*-gnuplottex-*

# gregoriotex
*.gaux
*.gtex

# htlatex
*.4ct
*.4tc
*.idv
*.lg
*.trc
*.xref

# hyperref
*.brf

# knitr
*-concordance.tex
# TODO Comment the next line if you want to keep your tikz graphics files
*.tikz
*-tikzDictionary

# listings
*.lol

# luatexja-ruby
*.ltjruby

# makeidx
*.idx
*.ilg
*.ind

# minitoc
*.maf
*.mlf
*.mlt
*.mtc[0-9]*
*.slf[0-9]*
*.slt[0-9]*
*.stc[0-9]*

# minted
_minted*
*.pyg

# morewrites
*.mw

# nomencl
*.nlg
*.nlo
*.nls

# pax
*.pax

# pdfpcnotes
*.pdfpc

# sagetex
*.sagetex.sage
*.sagetex.py
*.sagetex.scmd

# scrwfile
*.wrt

# sympy
*.sout
*.sympy
sympy-plots-for-*.tex/

# pdfcomment
*.upa
*.upb

# pythontex
*.pytxcode
pythontex-files-*/

# tcolorbox
*.listing

# thmtools
*.loe

# TikZ & PGF
*.dpth
*.md5
*.auxlock

# todonotes
*.tdo

# vhistory
*.hst
*.ver

# easy-todo
*.lod

# xcolor
*.xcp

# xmpincl
*.xmpi

# xindy
*.xdy

# xypic precompiled matrices and outlines
*.xyc
*.xyd

# endfloat
*.ttt
*.fff

# Latexian
TSWLatexianTemp*

## Editors:
# WinEdt
*.bak
*.sav

# Texpad
.texpadtmp

# LyX
*.lyx~

# Kile
*.backup

# gummi
.*.swp

# KBibTeX
*~[0-9]*

# auto folder when using emacs and auctex
./auto/*
*.el

# expex forward references with \gathertags
*-tags.tex

# standalone packages
*.sta

# Makeindex log files
*.lpz
EOF

# A README file that provides an overview of the project as a whole
cat << 'EOF' | tee README.md
```
|-- README.md
|-- data
|   -- experiment/
|   	[-- raw_data]
|   -- simulation/
|   	[-- raw_data]
|-- doc
|   -- manuscript/
|   -- lab_notebook/
|-- results
|   -- processed_data/
|   -- figs/
|       [-- fig1]
|       [-- fig2]
|   -- tables/
|       [-- paper1]
|       [-- paper2]
|-- src
|   -- controller/runAll.sh
|   -- analysis/scripts.py
|   -- program/program.cpp
```
EOF

fi

