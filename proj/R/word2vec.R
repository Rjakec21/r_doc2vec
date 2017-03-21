# word2vec.R
# Currently in as basic a state as can be achieved based on the
# Gensim word2vec model

library(hash)

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
    # Lowest frequency for a word to be counted
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
    # The training algorithm. 0 for CBOW, 1 for skip-gram
    sg="numeric",
    # For model training. 0 for negative sampling, 
    # 1 for heirarchical softmax
    hs="numeric",
    # If > 0, negative sampling will be used and value is number of 
    # 'noise words' (usually between 5 and 20). If 0, no negative 
    # sampling will be used. 
    negative="numeric",
    # If 0, use sum of context word vectors. If 1, use mean.
    cbow_mean="numeric",
    # Hash function to randomly initialize weights
    hashfxn="function",
    # Number of iterations over the corpus
    iter="numeric",
    null_word="numeric",
    # A trimming rule for words, specifying whether words 
    # should remain in the vocabulary or be trimmed away
    trim_rule="function",
    # If 1, sort by descending frequency before assigning word 
    # indexes
    sorted_vocab="numeric",
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
    sg=0,
    # Negative Sampling on default
    hs=0,
    negative=5,
    # Uses mean on default
    cbow_mean=1,
    # Built-in R hash function
    hashfxn=hash,
    iter=5,
    null_word=0,
    # Default trim rule, defined above
    trim_rule=DefaultTrimRule,
    # Sorts on default
    sorted_vocab=1,
    batch_words=10000
  ),
  
  validity = function(object) {
    # Do something
  }
)

DefaultTrimRule <- function() {
  # Do something
}