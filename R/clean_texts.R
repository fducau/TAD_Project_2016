library(quanteda)
library(ggplot2)

#Remove punctuation used for abbreviation
remove_abb_punct = function(x){
  return(gsub("([[:upper:]]+)([[:lower:]]+)[.]", " ",x))
}



#Load the data
setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/txt_replicated_parsed/")

paper_files = list.files(full.names=TRUE)
papers = lapply(paper_files, readLines)
papers = lapply(papers, function(x) paste(x, collapse = "\n"))
papers = unlist(papers)

index = gsub('./','', paper_files)
index = gsub('.txt','',index)
index = unlist(lapply(index, as.numeric))

#Create dataframe to store the papers
papers_df = data.frame(papers, Study.Num = index, stringsAsFactors = FALSE)
papers_df$papers_clean = unlist(lapply(papers_df$papers, remove_abb_punct))





#Remove lines with only one word
remove_one_word = function (x){
  words = unlist(strsplit(x, ' '))
  if (length(words) <= 1){
    return (NULL)
  }
  else{
    return(x)
  }
}
#Remove lines which are all uppercase
remove_all_upper = function (x){
#  if (x == NULL){
#    return (NULL)
#  }
  up = toupper(x)
  if (up == x){
    return (NULL)
  }
  else{
    return(x)
  }
}


###########################
# Regular expressions used
###########################

#To remove periods when used for abbreviation
# "([[:upper:]]+)([[:lower:]]+)[.]", "\\1\\2"

#To remove punctuation signs but no commas or dots
# "([.,])|[[:punct:]]", "\\1"

#To find references
# "[(](([a-zA-Z]|[ ]|[,.])+)[0-9]{4}[)]"

