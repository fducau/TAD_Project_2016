library(quanteda)
library(ggplot2)
#Uses the output of clean_texts to compute the FRE for each text



papers_df$FRE = readability(papers_df$papers_clean, "Flesch")
readability = papers_df[c('Study.Num','FRE')]


setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/features/")
write.table(readability, file='readability.csv', sep=",", row.names = FALSE)


#FRE box plot

df = merge(ds, papers_df, by='Study.Num')

df$replicate = as.factor(df$replicate)

boxplot(FRE ~ replicate, data=df, xlab='Replicability', ylab='FRE')

