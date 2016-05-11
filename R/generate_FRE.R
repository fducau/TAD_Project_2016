library(quanteda)
library(ggplot2)
#Uses the output of clean_texts to compute the FRE for each text



papers_df$FRE = readability(papers_df$papers_clean, "Flesch")
readability = papers_df[c('Study.Num','FRE')]


setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/features/")
write.table(readability, file='readability.csv', sep="\t", row.names = FALSE)






################################

df = merge(ds, papers_df, by='Study.Num')

df$replicate = as.factor(df$replicate)

boxplot(FRE ~ replicate, data=df)

df[c('Study.Num', 'replicate')]

linmod = lm(FRE ~ replicate, df)
anova_model = anova(linmod)

df$[Study.Num]


aov_model = aov(FRE ~ replicate, df)
differences = TukeyHSD(aov_model, conf.level = 0.95)