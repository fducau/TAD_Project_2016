########################
# DATASET EXPLORATION
########################

library(quanteda)
library(ggplot2)

setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/")

ds = read.csv('replication_dataset.csv', sep = ',', stringsAsFactors = FALSE)

# Number of studies in the dataset
N = nrow(ds)

N_replicated = sum(ds$replicate)
N_unreplicated = N-N_replicated

# Distribution of replicated datasets
counts <- table(ds$replicate)

barplot(counts, main="Replicated Studies Distribution", 
        xlab="Replicated", ylab='Number of studies')

