# word2vec.R
# Was goind to add Sentences, but this is unnecessary.
# Role is taken by Documents type in parser.R
# Fixed some variables and made validity function

library(hash)

DefaultTrimRule <- function(document, min_count) {
  
}

Word2Vec <- setClass(
  "Word2Vec",
  
  slots=c(
    # List of Sentence types which will be used for training
    sentences="list",
    # Dimensionality of the vectors
    size="numeric",
    # Initial learning rate, which eventually drops to min_alpha
    alpha="numeric",
    # Distance between words used in each prediction
    window="numeric",
    # Lowest frequency for a word to be counted with 
    # default trim rule
    min_count="numeric",
    # Size of vocab of words. If reached, infrequent words 
    # are deleted
    max_vocab_size="numeric",
    # Threshold for which high-frequency words will be down-sampled
    sample="numeric",
    # To seed the random number generator
    seed="numeric",
    # Number of threads to train the model
    workers="numeric",
    # End value of alpha to be reached
    min_alpha="numeric",
    # The training algorithm. TRUE for skip-gram, FALSE
    # for CBOW (default)
    sg="logical",
    # For model training. TRUE for heirarchical softmax, 
    # FALSE for negative sampling (default)
    hs="logical",
    # If > 0, negative sampling will be used and value is number of 
    # 'noise words' (usually between 5 and 20). If 0, no negative 
    # sampling will be used. 
    negative="numeric",
    # If TRUE, use mean of context word vectors (default). 
    # If FALSE, use sum.
    cbow_mean="logical",
    # Hash function to randomly initialize weights
    hashfxn="function",
    # Number of iterations over the corpus
    iter="numeric",
    null_word="numeric",
    # A trimming rule for words, specifying whether words 
    # should remain in the vocabulary or be trimmed away
    trim_rule="function",
    # If TRUE, sort by descending frequency before assigning word 
    # indexes
    sorted_vocab="logical",
    # Target number of words to be sent to each worker thread
    batch_words="numeric"
  ),
  
  prototype=list(
    # Model is left uninitialized
    sentences=NULL,
    size=100,
    alpha=0.025,
    window=5,
    min_count=5,
    # -1 for no max size
    max_vocab_size=-1,
    sample=1e-3,
    seed=1,
    workers=3,
    min_alpha=0.0001,
    # CBOW on default
    sg=FALSE,
    # Negative Sampling on default
    hs=FALSE,
    negative=5,
    # Uses mean on default
    cbow_mean=TRUE,
    # Built-in R hash function
    hashfxn=hash,
    iter=5,
    null_word=0,
    # Default trim rule, defined above
    trim_rule=DefaultTrimRule,
    # Sorts on default
    sorted_vocab=TRUE,
    batch_words=10000
  ),
  
  validity = function(object) {
    if (object@min_alpha > object@alpha) {
      return(paste("min_alpha > alpha, which is incorrect,",
                   "alpha will drop to min_alpha during training",
                   sep=" "))
    }
    else if (object@iter <= 0) {
      return("iter <= 0. iter must be positive, so the corpus",
             "is read at least once.",
             sep=" ")
    }
    else if (object@batch_words <= 0) {
      return("batch_words <= 0. batch_words must be positive,",
             "so some words are sent to each worker thread.",
             sep=" ")
    }
  }
)