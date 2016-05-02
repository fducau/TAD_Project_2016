library(quanteda)
library(ggplot2)


#Load the data
setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/txt_replicated/")

paper_files = list.files(full.names=TRUE)
papers = lapply(paper_files, readLines)
papers = lapply(papers, function(x) paste(x, collapse = "\n"))
papers = unlist(papers)
# Open dataset
setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/")
ds = read.csv('./replication_dataset.csv', sep = '\t')

index = gsub('./','', paper_files)
index = gsub('.txt','',index)
index = unlist(lapply(index, as.numeric))

#Create dataframe to store the papers
papers_df = data.frame(papers, Study.Num = index, stringsAsFactors = FALSE)



p1_file = paper_files[1]
p1 = readLines(p1_file)

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



'LAPUTA' == toupper('Laputa')



p2 = lapply(p1, remove_one_word)
p2 = p2[!sapply(p2,is.null)]


p3 = lapply(p2, remove_all_upper)
p3

p3_file = file('p3_clean.txt')
writeLines(unlist(p3), p3_file)

unlist(p3)

a = remove_one_word('madre')
a
p1l1 = p1[1]
b = unlist(strsplit(p1l1, ' '))

length(b)
p2 = lapply(p1, remove_one_word)
len()


lapply(papers_df$papers, gsub,"([.-])|[[:punct:]]", "\\1")


texto = 'Dr. sadf sd gbhoww. Asdfuowe ewltki vloi Dsas. Asaedrtpo dglo weo vfd.'
texto = '(12.5), (2004), (Marakiwa, 2008) (lasdf sdf)' 
###########################
# Regular expressions used
###########################

#To remove periods when used for abbreviation
# "([[:upper:]]+)([[:lower:]]+)[.]", "\\1\\2"

#To remove punctuation signs but no commas or dots
# "([.,])|[[:punct:]]", "\\1"

#To find references
# "[(](([a-zA-Z]|[ ]|[,.])+)[0-9]{4}[)]"



a = papers_df$papers[1]



st = 'asdfsd sadgf dg sadf SS.SS. asdfsa!:@$%"#$:@#$^$%&U.^('
filter(st, grepl('SSS', st))


gregexpr("[(](([a-zA-Z]|[ ]|[,.])+)[0-9]{4}[)]", '(12.5), (2004), (Marakiwa, 2008) (lasdf sdf)' )
gsub("[(](([a-zA-Z]|[ ]|[,.])+)[0-9]{4}[)]",'{REF}','(12.5), (2004), (Marakiwa, 2008) (Marakiwa, 28) (lasdf sdf)' )


regexpr("[()]", '(12.5), (2004), (Marakiwa, 2008) (lasdf sdf)')


a
b = unlist(a)
length(b)
texto[]
b

?grep
b[1]


papers_df$p_clean = b




