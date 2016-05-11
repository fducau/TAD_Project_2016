library(quanteda)
library(boot)
library(gdata)
library(stringr) 
library(dplyr)
library(plyr)

#Function that gets the number of references in the paper.  
#Input: Text of the document (txt_papers)
#Number of references.
refNumber<-function(text){
  pat<-"\\(\\d{4}\\)\\."
  refText<-gsub(".*\nReferences\n","",ignore.case=TRUE,text)
  references<-length(regmatches(refText, gregexpr(pat, refText, perl=TRUE))[[1]])
  if (references>0){
    return(references)
  } else{
    pat<-"\\d{4}\\;"
    references<-length(regmatches(refText, gregexpr(pat, refText, perl=TRUE))[[1]])
    if (references>0){
      return(references)
    }else{
      pat<-"\\d{4}\\."
      references<-length(regmatches(refText, gregexpr(pat, refText, perl=TRUE))[[1]])
      if (references>0){
        return(references)
      } else{
      pat<-"\\(\\d{4}\\)"
      references<-length(regmatches(refText, gregexpr(pat, refText, perl=TRUE))[[1]])
      return(references)  
      }
    } 
  } 
}

#Function that gets the number of times the author quote a paper 
#Input: Text of the document (txt_replicated) and year (lower bound for the year of the paper)
#Output: Number of quotes
numRef<-function(x, year){
  pat<-"\\d{4}"
  list_years<-gsub("\n","",paste(regmatches(x, gregexpr(pat, x, perl=TRUE))[[1]]))
  n<-length(list_years[list_years>year & list_years<2016])
  return(n)
}


list_doc<- list.files(path = "txt_replicated/")
references<-c()
numberRef<-c()
numberRef10<-c()

#Read the documents
for (element in list_doc) {
  file<- paste("txt_replicated/", element, sep="")
  text<-readChar(file, file.info(file)$size)
  refText<-gsub(".*\nReferences\n","",ignore.case=TRUE,text)
  text<-gsub(".\nReferences\n.*","",ignore.case=TRUE,text)
  references<-c(references, refNumber(refText))
  numberRef<-c(numberRef, numRef(text, 1970))
  numberRef10<-c(numberRef10, numRef(text, 2006))
}  

#Create the dataframe to export
dfText<- as.data.frame(as.numeric(gsub(".txt","", list_doc)))
dfText$references<-references
dfText$referencesU<- numberRef
dfText$referencesY<- numberRef10
colnames(dfText)<-c("name", "references", "number_quotes", "number_quotes10Y")
dfText<-dfText[ order(dfText[,1]), ]
write.csv(dfText, file="References_.csv")
