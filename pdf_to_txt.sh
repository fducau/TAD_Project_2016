#!/bin/bash
FILES=~/DS/Text_as_Data/Project/TAD_Project_2016/original_papers/*.pdf
for f in $FILES
do
 echo "Processing $f file..."
 pdftotext -enc UTF-8 $f
done