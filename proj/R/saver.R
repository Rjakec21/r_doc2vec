#saver.R
library(readr)

# Saves input data to file at filename. If append is TRUE, appends data to file. 
# Returns full data that was saved

saver <- function(toSave, filename, append = FALSE) {
  
  fullData <- toSave;
  
  if (append == TRUE) {
    # Read exisiting file and bind to new data
    appendTo <- read_csv(filename)
    fullData <- rbind(appendTo, toSave) 
  }

  #Write data set to csv
  write_csv(fullData, filename)
  
  # Return full data
  return (fullData)
}
