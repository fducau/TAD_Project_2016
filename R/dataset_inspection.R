library(quanteda)
library(ggplot2)


########################
# DATASET EXPLORATION
########################

setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/")

ds = read.csv('./train.csv', sep = '\t', stringsAsFactors = FALSE)

# Number of studies in the dataset
N = nrow(ds)

N_replicated = sum(ds$replicate)
N_unreplicated = N-N_replicated

# Distribution of replicated datasets
counts <- table(ds$replicate)

barplot(counts, main="Replicated Studies Distribution", 
        xlab="Replicated", ylab='Number of studies')

