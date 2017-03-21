# doc2vec.R
# Currently in as basic a state as can be achieved based on the
# Gensim doc2vec model

Doc2Vec <- setClass(
  "Doc2Vec",
  
  slots=c(
    # List of documents which will be used for training
    documents="list",
    # If 0, use sum of context word vectors. If 1, use mean.
    dm_mean="numeric",
    # The training algorithm. 0 for DBOW, 1 for DM
    dm="numeric",
    # If 0 train doc vectors only (faster), if 1 trains vectors
    # simultaneously with DBOW
    dbow_words="numeric",
    # If 0, do nothing. If 1, concatenate context vectors rather 
    # than use mean
    dm_concat="numeric",
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
    dm_mean=0,
    # Use DM by default
    dm=1,
    # Train doc vectors only
    dbow_words=0,
    # No concatenation by default
    dm_concat=0,
    # 1 as a default, though only active when dm_concat is
    dm_tag_count=1,
    docvecs=NULL,
    docvecs_mapfile=NULL,
    comment=NULL,
    # Default trim rule, defined in word2vec.R
    trim_rule=DefaultTrimRule
  ),
  
  validity = function(object) {
    # Do something
  },
  
  contains = "Word2Vec"
)