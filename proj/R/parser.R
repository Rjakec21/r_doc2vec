# parser.R
# How to use the parse method:
# result <- parse("/Path/To/Documents/")
# print(result)
# Cleaned up a bit and moved things around for documentation reasons
# No longer prints while running. Add verbose variable?
# Made a sort variable, so only sorts when requested
library(methods)

#Class definition for a document
document <- setClass(
  "Document", 
  
  slots=c(
    name="character", 
    words="data.frame"
  )
)

#  Parse all of the files in a directory (Recurses down through subdirectories)
parse <- function(path, sort){
  setwd(path)
  dir <- list.files(recursive = TRUE);
  
  #  Store the list of documents processed.
  doc_list <- c()

  for (file in dir){
    doc <- read.delim(file, header = FALSE, sep = " ")
    #Flatten the table of words that gets read in.
    words <- c(t(doc))
    
    # Remove all punctuation and lower case all words.
    index <- 1;
	  while (index <= length(words)){
		  words[index] <- tolower(gsub("[[:punct:]]", "", words[index]))
		  index <- index + 1
	  }
	
	  # Store the number of times each word is used in a text.
    freq.data <- data.frame(word = c(""), occurrence = c(0))

    # count frequency
    for (word in words){
      if (word %in% freq.data[,1]){ 
        # If a word is already in the list of found words.
        pos <- match(word, freq.data[,1])
        freq.data[,2][pos] <- freq.data[,2][pos] + 1
      } 
      else { 
        # If a word is not in the list of found words.
        new_row <- data.frame(word = word, occurrence = 1)
        freq.data <- rbind(freq.data, new_row)
      }
    }
    
    #  Sort the words by frequency
    doc_words=freq.data
    if (sort) { #only sort if asked to do so
      doc_words=freq.data[order(-freq.data[,2]),]
    }
    doc_temp <- document(name=file, words=doc_words)
    doc_list <- c(doc_list, doc_temp)
  }
  
  return(doc_list)
}