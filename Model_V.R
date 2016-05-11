library(quanteda)
library(boot)
library(gdata)
library(stringr) 
library(dplyr)
library(plyr)
library(data.table)
library(RTextTools)
library(e1071)

list_doc<- list.files(path = "txt_replicated_parsed/")
text=c()

#Read the documents
for (element in list_doc) {
  file<- paste("txt_replicated_parsed/", element, sep="")
  text<-c(text,readChar(file, file.info(file)$size))
}  

dfText<- as.data.frame(as.numeric(gsub(".txt","", list_doc)))
dfText$text<-gsub("[[:punct:]]", " ", text)
colnames(dfText)<-c("name", "text")

#Paste the target variable
papers<-read.csv("replication_dataset.csv")
colnames(papers)<-c("name", "title", "target")
dfText<- join(dfText, papers, by="name")

#Creating dfm & tfidf matrix 
dfm_Text<-dfm(dfText$text,verbose = FALSE,removePunctuation = TRUE,stem = TRUE,
             removeNumbers = TRUE,  toLower = TRUE, ignoredFeatures=stopwords(kind = "english"))

dfm_aux<-as.data.frame(dfm_Text)
auxCol<-colnames(dfm_Text)
dfm_Text<-dfm_Text[,auxCol[nchar(auxCol)>3 & nchar(auxCol)<10]]
dfm_tfid<-tfidf(dfm_Text)

#############################
################ Models
######## SVM
dtText<-subset(dfText, select = c("text","target"))
dim<-nrow(dfText)
  
#Sample size
smp_size <- floor(0.90 * dim)

svmDfm=c()
svmTfi=c()
for (i in seq(1:100)){
train_ind <- sample(seq_len(dim), size = smp_size)

#####Word frequency
#Train the model
svm.model<- svm(dfm_Text[train_ind, ], y = factor(dfText$target[train_ind]), 
                scale = TRUE, type = NULL, kernel ="linear")
#Predict the model
predicted<-predict(svm.model, dfm_Text[-train_ind,])

Y_predicted<-as.numeric(predicted)-1
Y_test<-dfText$target[-train_ind]
accuracy<-(1-sum(sign(abs(Y_predicted-Y_test)/2))/length(Y_test))

svmDfm<-c(svmDfm,accuracy)
 
######TFIDF 
svm.model<- svm(dfm_tfid[train_ind, ], y = factor(dfText$target[train_ind]), 
                scale = TRUE, type = NULL, kernel ="linear")
predicted<-predict(svm.model, dfm_tfid[-train_ind,])
Y_predicted<-as.numeric(predicted)-1
Y_test<-dfText$target[-train_ind]

accuracy<-(1-sum(sign(abs(Y_predicted-Y_test)/2))/length(Y_test))

svmTfi<-c(svmTfi,accuracy)
}

####### Naive Bayes
#Convert the dfm to dataframe 
df_Text<-as.data.frame(dfm_Text)
df_tfid<-as.data.frame(dfm_tfid)

#Sample size
smp_size <- floor(0.90 * nrow(df_Text))

NB=c()
for (i in seq(1:100)){

train_ind <- sample(seq_len(dim), size = smp_size)  
#Train NB  
clf<-textmodel_NB(df_Text[train_ind, ],
                  factor(dfText$target[train_ind]),smooth = 1, prior="uniform" )

#Predict the target variable
predicted<-predict(clf, newdata = as.matrix(df_Text[-train_ind, ])
                   , rescaling = "none", level = 0.95, verbose = TRUE)

#Predict
Y_predicted<-as.numeric(predicted$docs$predicted)
Y_predicted[Y_predicted==1]<-0
Y_predicted[Y_predicted==2]<-1
Y_test<-dfText$target[-train_ind]

accuracy<-(1-sum(sign(abs(Y_predicted-Y_test)/2))/length(Y_test))

NB<-c(NB,accuracy)

}

#####Data frames of the models. 
dfDfm<-as.data.frame(svmDfm)
dfDfm$number<-"DFM SVM "
colnames(dfDfm)<-c("Mean","Model")
dfTfi<-as.data.frame(svmTfi)
dfTfi$number<-"TFIDF SVM "
colnames(dfTfi)<-c("Mean","Model")
NBDfm<-as.data.frame(NB)
NBDfm$number<-"NB"
colnames(NBDfm)<-c("Mean","Model")

#Boxplot
boxPlot<-rbind(dfDfm,dfTfi, NBDfm)
boxPlot$Model<-factor(boxPlot$Model)
boxplot(Mean~Model, data= boxPlot, xlab="Comparison betwen Models", ylab="Mean Accuracy" )

mean(NB)
sqrt(var(NB))
