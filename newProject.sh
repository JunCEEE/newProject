#!/bin/bash
# This script to create a well-structured project directory is inspired by this article http://arxiv.org/abs/1609.00037, which can also by found on github: https://swcarpentry.github.io/good-enough-practices-in-scientific-computing/.

if [ ! $1 ]; then
    echo usage: $0 projectName
else
echo project name: $1

PROJDIR=${1}Project
# 1. Put each project in its own directory
mkdir $PROJDIR
cd $PROJDIR

# 2. Put text documents associated with the project in the doc directory
mkdir doc

# 3. Put raw data and metadata in a data directory
# the data directory might require subdirectories to organize raw data based on time, method of collection, or other metadata most relevant to your analysis.
mkdir data

# 4. Put files generated during cleanup and analysis in a results directory
mkdir results

# 5. Put project source code in the src directory
mkdir src
cat << EOF > src/sync.sh
#!/bin/bash

PUB="${1}-pub"
rsync -r  ../results/figs ../doc/\$PUB
EOF
chmod +x src/sync.sh

# 6. A README file that provides an overview of the project as a whole
cat << EOF | tee README.md
$1
|-- README.md
|-- data
|   -- raw_data
|-- doc
|   -- documents_of_source_code
|   -- manuscripts
|   -- lab_notebooks
|-- results
|   -- intermediate_results
|   -- cleaned_data_sets
|   -- figures
|       [-- paper1]
|       [-- paper2]
|   -- tables
|       [-- paper1]
|       [-- paper2]
|-- src
|   -- runAll.sh (controller)
|   -- scripts.py (analysis)
|   -- program.cpp
EOF

fi
