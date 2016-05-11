#!/bin/bash
find ~/DS/Text_as_Data/Project/TAD_Project_2016/original_papers/New/ -name "*.pdf" | while read file;
do
curl --data-binary @"$file" -H "Content-Type: application/pdf" -L "http://pdfx.cs.man.ac.uk" > "${file}x.xml";
done
