# doc2vec.R

Doc2Vec <- function(documents=NULL, dm_mean=NULL, dm=1, dbow_words=0,
                    dm_concat=0, dm_tag_count=1, docvecs=NULL,
                    docvecs_mapfile=NULL, comment=NULL, trim_rule=NULL)
{
  thisEnv <- environment()
  
  me <- list(
    thisEnv = thisEnv,
    
    getEnv = function()
    {
      return(get("thisEnv",thisEnv))
    }
  )
  
  assign('this', me, envir=thisEnv)
  
  class(me) <- append(class(me), "Doc2Vec")
  return(me)
}