library(quanteda)
library(ggplot2)


setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/txt_replicated/")

paper_files = list.files(full.names=TRUE)
papers = lapply(paper_files, readLines)
papers = lapply(papers, function(x) paste(x, collapse = " "))
papers = unlist(papers)
# Open dataset
setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/")
ds = read.csv('./replication_dataset.csv', sep = '\t')

# Create index
index = gsub('./','', paper_files)
index = gsub('.txt','',index)
index = unlist(lapply(index, as.numeric))

papers_df = data.frame(papers, Study.Num = index, stringsAsFactors = FALSE)

# Import LIWC metrics
setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/")
liwc_metrics = read.csv('./LIWC_RESULTS.csv', sep = ',', stringsAsFactors = FALSE)

# Accomodate index
liwc_metrics$Study.Num = liwc_metrics$Filename
liwc_metrics$Study.Num = gsub('.txt','', liwc_metrics$Study.Num)
liwc_metrics$Study.Num = as.numeric(liwc_metrics$Study.Num)

#Save clean version of liwc metcis
write.table(liwc_metrics, file='liwc.csv', sep="\t", row.names = FALSE)

#Merge with train dataframe
liwc1 = merge(ds, liwc_metrics, by='Study.Num')
liwc1$replicate = as.factor(liwc1$replicate)


covariates = colnames(liwc1)[7:length(colnames(liwc1))]

for (feature in covariates){
  a = as.list(liwc1[feature])[[1]]
  b = as.list(liwc1['replicate'])[[1]]
  
  d = data.frame(ft=a, replicate=b)
  linmod = lm(ft~replicate, d)
  anova_model = anova(linmod)
  if(anova_model$`Pr(>F)`[1] < 0.2){
    cat(feature)
    cat(' ')
    cat(anova_model$`Pr(>F)`[1])
    cat('\n')
  }
}

linmod = lm(Clout~replicate, liwc1)
anova(linmod)




a = as.list(liwc1['Clout'])[[1]]
b = as.list(liwc1['replicate'])[[1]]

a[[1]]



d=data.frame(ft=a, rep=b)

lm(ft~rep,d)

d

liwc1[ft]
ft = covariates[1]
linmod = lm(liwc1['Analytic'] ~ liwc1['replicate'])

a = liwc1['Analytic']
as.vector(a)


d = data.frame(feature=a, replicate=liwc1$replicate)

v = as.list(a)

linmod = lm(liwc1['Analytic'] ~ liwc1['replicate'])
list(a)
?lm
liwc1$Analytic
liwc1

col(liwc1)


boxplot(Quote ~ replicate, data=liwc1)

df[c('Study.Num', 'replicate')]

linmod = lm(Quote ~ replicate, liwc1)
anova_model = anova(linmod)

anova_model$`Pr(>F)`[1]





df$[Study.Num]


aov_model = aov(Quote ~ replicate, liwc1)
differences = TukeyHSD(aov_model, conf.level = 0.95)

