library(quanteda)
library(ggplot2)


setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/txt_papers/")

paper_files = list.files(full.names=TRUE)
papers = lapply(paper_files, readLines)
unlist(papers)

papers_1 = lapply(papers, function(x) paste(x, collapse = " "))
