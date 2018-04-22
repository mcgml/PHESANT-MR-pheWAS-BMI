#!/bin/bash
set -euo pipefail

datadir="${PROJECT_DATA}/phenotypes/derived/"
origdir="${PROJECT_DATA}/phenotypes/original/"
head -n 1 ${origdir}data.11148.csv | sed 's/,"/,"x/g' | sed 's/-/_/g' | sed 's/\./_/g' > ${datadir}data.11148-phesant_header.csv
awk '(NR>1) {print $0}' ${origdir}data.11148.csv >> ${datadir}data.11148-phesant_header.csv
