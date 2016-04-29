library(quanteda)
library(data.table)
library(dplyr)
library('stringr')
library(boot)


list_doc<- list.files(path = "txt_papers/")
i=1
names<-seq(1:159)
text<-seq(1:159)
references<-seq(1:159)
#Read the documents
for (element in list_doc) {
  names[i]<-element
  file<- paste("txt_papers/", element, sep="")
  text[i]<-readChar(file, file.info(file)$size)
  #Count the number of references taking into account the regex (YEAR).
  refText<-gsub(".*\nReferences\n","",ignore.case=TRUE,text[i])
  pat<-"\\(\\d{4}\\)\\."
  references[i]<-length(regmatches(refText, gregexpr(pat, refText, perl=TRUE))[[1]])
  if (references[i]==0){
    pat<-"\\d{4}\\;"
    references[i]<-length(regmatches(refText, gregexpr(pat, refText, perl=TRUE))[[1]])
  }
  i=i+1
}  

numfig<-function(text){
  refText<-gsub(".*\n\n","",ignore.case=TRUE,text)
}

textdf<-as.data.frame(names)
textdf$references<-references

write.csv(file="references.csv", textdf)

