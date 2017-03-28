# doc2vec.R
# Added TaggedDocuments and corrected some variables
# Added validity method

TaggedDocument <- setClass(
  "TaggedDocument",
  
  slots=c(
    tags="character"
  ),
  
  prototype=list(
    tags=c("")
  ),
  
  contains="Document"
)

Doc2Vec <- setClass(
  "Doc2Vec",
  
  slots=c(
    # List of documents which will be used for training
    documents="list",
    # If TRUE, use mean of context word vectors.
    # If FALSE, use sum (default)
    dm_mean="logical",
    # The training algorithm. TRUE for DM (default), FALSE for DBOW
    dm="logical",
    # If TRUE, trains vectors simultaneously with DBOW. 
    # If FALSE train doc vectors only (faster)
    dbow_words="logical",
    # If TRUE, concatenate context vectors rather than use mean.
    # If FALSE, train doc vectors only (faster)
    dm_concat="logical",
    # Expected number of tags per document when dm_concat is active
    dm_tag_count="numeric",
    docvecs="list",
    docvecs_mapfile="character",
    comment="character",
    trim_rule="function"
  ),
  
  prototype = list(
    # Model is left uninitialized
    documents=NULL,
    # Use sum by default
    dm_mean=FALSE,
    # Use DM by default
    dm=TRUE,
    # Train doc vectors only by default
    dbow_words=FALSE,
    # No concatenation by default
    dm_concat=FALSE,
    # 1 as a default, though only active when dm_concat is
    dm_tag_count=1,
    docvecs=NULL,
    docvecs_mapfile=NULL,
    comment=NULL,
    # Default trim rule, defined in word2vec.R
    trim_rule=DefaultTrimRule
  ),
  
  validity = function(object) {
    if (object@dm_tag_count <= 0) {
      return(paste("dm_tag_count <= 0. dm_tag_count must be",
             "positive for dm to find tags in documents",
             sep=" "))
    }
  },
  
  contains = "Word2Vec"
)