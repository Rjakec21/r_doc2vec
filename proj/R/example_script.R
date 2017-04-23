source("parser.R") # Grab the parser functions
source("neuralnnet.R") # Grab the neural network functions

path <- "/PATH/TO/DOCUMENTS" # Change this to the directory of your documents.
stop <- c("a", "an", "and", "are", "as", 
		  "at", "be", "by", "for", "from", 
		  "has", "he", "in", "is", "it", 
		  "its", "of", "on", "that", "the", 
		  "to", "was", "were", "will", "with")

list <- parse(path, stop_list = stop, min_freq = 2) # Parse documents from a path
vocab <- build_vocab(list) # Combine the vocabularies of each document into one

print("Finished Building Vocabulary")

vector_size <- 20 # produce vectors of this fixed size
window_size <- 1 # size of the context to sample
results <- matrix(nrow = 0, ncol = vector_size) # Store the document vectors here

for (doc in list) {
	# calc_vector handles all of the setup needed to create a vector
	# from a parsed document.
	results <- rbind(results, calc_vector(doc@name, window_size, vector_size, vocab))
	
	# Optional progress print
	print(paste("Processed document vector for ", doc@name, sep = ""))
}


# Cosine similarity comparison, will compare all documents with each
# other, which may take a while.
for (a in c(2:length(list))){
	for (b in c(1:(a-1))){
		x <- results[b,] 
		y <- results[a,]
		
		# print a similarity between -1 and 1.
		# -1 means polar opposite and 1 means extremely similar.
		print(c(list[[b]]@name, list[[a]]@name))
		print(x %*% y / sqrt(x%*%x * y%*%y))
	}
}
