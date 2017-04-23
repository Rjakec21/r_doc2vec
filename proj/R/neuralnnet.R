library("nnet")

# This version of run_batch processes all of the examples in one batch.
run_batch <- function(input, output, weights = c(), hidden_size){
	net <- nnet(x = input, y = output, size = hidden_size, 
		softmax = TRUE, maxit = 10, MaxNWts = 1000000000, trace = FALSE)
	ret <- net$wts[1:(2*hidden_size)] # grab the input weights
	ret <- ret[seq(2,2*hidden_size,2)] # grab the even weights since odd weights
									   # come from a bias node.
	return(ret)
}

# Turn a word into a one-hot vector based on the vocabulary.
vectorize <- function(word, vocab){
	vocab_size <- length(vocab$word)
	one_hot_vector <- numeric(vocab_size)
	pos <- match(word, vocab$word)
	one_hot_vector[[pos]] <- 1
	return(one_hot_vector)
}

# Pick a random word in a context.
sample_context <- function(context){
	pos <- sample(1:length(context), 1)
	return(context[[pos]])
}

# Grab a window of text from a document of size 2 * context_size + 1
grab_context <- function(file_path, pos, context_size, vocab){
  words <- get_document(file_path, vocab)
  
  start_pos <- pos - context_size
  end_pos <- pos + context_size
  if (start_pos < 1){ # Start from the beginning of the list if start_pos goes before it.
  	start_pos <- 1
  }
  if (end_pos > length(words)){ # End of the list if end_pos goes past it.
  	end_pos <- length(words)
  }
  return(words[start_pos:end_pos])
}

get_document <- function(file_path, vocab){ # Read the document
  doc <- read.delim(file_path, header = FALSE, sep = " ", quote = "")
  #Flatten the table of words that gets read in.
  words <- c(t(doc))
  words <- words[!is.na(words)]  
    
  # Remove all punctuation and lower case all words.
  index <- 1;
  while (index <= length(words)){
	words[index] <- tolower(gsub("[[:punct:]]", "", words[index]))
    index <- index + 1
  }
  
  words <- words[!(words == "")]
  words <- words[(words %in% vocab$word)]
  
  return(words)
}

# This function uses the above function to prepare and run the neural net
# file is a document path and name.
# window_size is the size of the context window to search
# vector_size is the size of the document vectors
# vocab is the vocabulary
calc_vector <- function(file, window_size, vector_size=10, vocab) {
	size <- length(get_document(file, vocab))
	vocab_size <- length(vocab$word)
	output <- c()
	input <- c()
	for (i in c(1:size)){
		context <- grab_context(file, i, window_size, vocab)
		sample <- sample_context(context)
		example <- vectorize(sample, vocab)
		output <- c(output, example)
		input <- c(input, 1)
	}
	input <- matrix(input, nrow=size, ncol=1)
	output <- matrix(output, nrow=size, ncol=vocab_size)
	weights <- run_batch(input, output, hidden_size = vector_size)
	return(weights)
}
