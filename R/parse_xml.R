#install.packages("xml2")
library(xml2)

#Get the text of the body from the xml version of the paper
get_text_from_xml = function(x){
  regions = xml_find_all(x, '//region')
  text = ''
  for (r in regions){
    class = xml_attr(r, 'class')
    if (class == "DoCO:TextChunk"){
      text = paste(text, xml_text(r), sep=' ')
    }
  }
  return(text)
}


#For all the files in xml_replicated, get the text of the paper and save it to txt. 

setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/xml_replicated/")
xml_files = list.files(full.names=TRUE)

for (xml_file in xml_files){
   file = read_xml(xml_file)
   dest_file = file(gsub('.pdfx.xml', '.txt', xml_file))
   writeLines(get_text_from_xml(file), dest_file)
   close(dest_file)
}





#Get the text of the body from the xml version of the paper
#Receives a string with the location of the file

get_mentioned_references_from_xml = function(x){
  xml_file = read_xml(x)
  xrefs = xml_find_all(xml_file, '//xref')
  i=0
  for (ref in xrefs){
    att =  xml_attrs(ref)
    ref_type = att['ref-type']
    if (ref_type == "bibr"){
      i = i+1
    }
  }
  return(i)
}


index = gsub('.pdfx.xml', '', xml_files)
index = gsub('./', '', index)
index = unlist(lapply(index, as.numeric))


setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/xml_replicated/")
references_df = data.frame(Study.Num = index, file=xml_files, stringsAsFactors = FALSE)
references_df$mentioned_ref = lapply(references_df$file, get_mentioned_references_from_xml)


setwd("/home/fnd/DS/Text_as_Data/Project/TAD_Project_2016/")

ds = read.csv('./train.csv', sep = '\t', stringsAsFactors = FALSE)
xml_files

references_df

file1 = xml_files[1]
x1 = read_xml(file1)
xrefs = xml_find_all(x1, '//xref')

xrefs[1]
ref_type
att

i=0
for (ref in xrefs){
  att =  xml_attrs(ref)
  cat(att)
  ref_type = att['ref-type']
  
  if (ref_type == "bibr"){
    i = i+1
  }
  cat(i)
}








xrefs = xml_find_all(x1, '//xref')
length(xrefs)

x = xrefs[1]
att =  xml_attrs(x)
att
ref_type = att[[1]]['ref-type']

if(ref_type == 'bibr'){
  cat('bien')
}

xml_attr(xrefs[80])

xml_type(xrefs[80])

x1 = xrefs[1]
x1at = xml_attrs(x1)
x1at = x1at[[1]]
x1at['class']
x1

i=0


for(x in xrefs){
  cat(xml_attrs(x)['id'])
  cat(' ')
}

lista = c(7, 11, 18, 19, 20, 21, 22, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 48, 49, 53, 54,
          55, 56, 57, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 82, 83, 84, 85, 89, 90, 96, 102,
          109, 111, 160, 167, 168, 169, 170, 171, 180, 199, 200, 206, 209, 229, 233, 243, 244, 248, 249, 252, 253, 254, 255, 257, 258,
          259, 262, 266 )
lista
length(unique(lista))
xrefs
unique(xrefs)

length(xrefs)

r1 = regions[4]

xml_path(r1)
xml_attr(r1, 'class')
xml_text(r1)

t1 = 'asdf sadf sadf sadf asd.'
t2 = 'qewroiuerti ber ,vfdsio esw,f ppoer. '

paste(t1, t2, sep=' ')





text1 = get_text_from_xml(file)



text

r3 = regions[3]
r3

xml_attr(r3, 'class')
xml_path(r3)
xml_text(r3)

xml_structure(r3)

l = as_list(file)


extract_text = function(x){
  regions = xml_find_all(x, '//region')
  
  
  
}