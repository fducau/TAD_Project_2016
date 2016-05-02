library(quanteda)
library(ggplot2)

#Load the data
setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/txt_replicated/")

paper_files = list.files(full.names=TRUE)
papers = lapply(paper_files, readLines)
papers = lapply(papers, function(x) paste(x, collapse = " "))
papers = unlist(papers)
# Open dataset
setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/")
ds = read.csv('./replication_dataset.csv', sep = '\t')

index = gsub('./','', paper_files)
index = gsub('.txt','',index)
index = unlist(lapply(index, as.numeric))

#Create dataframe to store the papers
papers_df = data.frame(papers, Study.Num = index, stringsAsFactors = FALSE)








df = merge(ds, papers_df, by='Study.Num')



p_corpus = corups
p_corpus = corpus(papers)

save(p_corpus, './')
p_corpus$documents$texts[1]

c$p_clean = b[1]

c$read_FRE = readability(c$papers, "Flesch")
c$replicate = as.factor(c$replicate)

boxplot(read_FRE ~ replicate, data=c)


linmod = lm(read_FRE ~ replicate, c)
anova_model = anova(linmod)




aov_model = aov(read_FRE ~ replicate, c)
differences = TukeyHSD(aov_model, conf.level = 0.95)

anova()