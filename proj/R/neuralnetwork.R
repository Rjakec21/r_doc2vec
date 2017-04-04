# neuralnetwork
#   Performs all matrix operations on the neural net.
library(sigmoid)

# layerConvert
#   This is the general form of the function which performs the
#   conversion from one layer to the next.
# Called by: 
#   getHiddenLayer, getOutputLayer
# input:
#   inLayer - matrix with one row. Contains all inputs
#   weights - matrix with as many rows as inputLayer has columns, and
#             as many columns as output layers desired, i.e.,
#             [ w_{1,1}, w_{1,2}, w_{1,3}]
#             [ w_{2,1}, w_{2,2}, w_{2,3}]
#             This would be the form of the function for an inputLayer
#             with 2 nodes and a outputLayer with 3 nodes
# output:
#   The outputLayer is returned after doing the matrix multiplication,
#   the next step is applying the softmax
layerConvert <- function(inLayer, weights) {
  outLayer <- inLayer %*% weights
  return(outLayer)
}

# getDeltaHiddenSum
getDeltaHiddenSum <- function(deltaOSum, oWeights, hiddenLayer){
  hiddenSum <- sum(hiddenLayer)
  smDeriv <- hiddenSum * (1 - hiddenSum)
  return(deltaOSum * oWeights * smDeriv)
}

# getDeltaOutputSum
getDeltaOutputSum <- function(outputLayer, outputLoss) {
  outputSum <- sum(outputLayer)
  smDeriv <- outputSum * (1 - outputSum)
  return((smDeriv * outputLoss)[1])
}

# getHiddenLayer
#   Converts from the input layer to the hidden layer. General
#   guidelines say that number of nodes in hidden layer should
#   be less than the number of input nodes and greater than the 
#   number of output nodes.
# Calls:
#   layerConvert
# input:
#   inputLayer - the matrix that is the input nodes. See layerConvert
#                for details
#   weights - the matrix that is the weights. See layerConvert for
#             details
# output:
#   The hidden layer, which will be used to find the output layer
getHiddenLayer <- function(inputLayer, hiddenWeights) {
  return(layerConvert(inputLayer, hiddenWeights))
}

# getOutputLayer
#   Converts from the hidden layer to the output layer. General
#   guidelines say that number of nodes in output layer should
#   be small, 1 preferred.
# Calls:
#   layerConvert
# input:
#   inputLayer - the matrix that is the hidden nodes. See layerConvert
#                for details
#   weights - the matrix that is the weights. See layerConvert for
#             details
# output:
#   The output layer, which will be used for back propagation
getOutputLayer <- function(hiddenLayer, outputWeights){
  return(layerConvert(hiddenLayer, weights))
}

# applySoftmax
#   Applies the softmax function to the output during a movement
#   from one layer to the other (input -> hidden, hidden -> output).
#   Currently uses the sigmoid function from the R library
# Calls:
#   sigmoid
# inputs:
#   outLayer - the output layer from a matrix multiplication
# outputs:
#   The output layer after being normalized using the chosen function.
applySoftmax <- function(outLayer){
  return(SoftMax(outLayer))
}

# calculateLoss
#   Calculates the error from the output layer using the 
#   found output and comparing to the expected value. Both outputs
#   can be singular values or matrices
# inputs:
#   expectedValue - the value(s) known to be correct
#   realValue - the value(s) found from the neural net
# outputs:
#   The difference between the values
calculateLoss <- function(expectedValue, realValue) {
  return(expectedValue - realValue)
}

# Change the weights based on stochastic gradient descent based on error and learning rate.
backPropagation <- function(iLayer,hWeights,oWeights,loss
                            ,alphaRate) {
	deltaOutput <- getDeltaOutputSum()
	deltaOWeights <- deltaOutput * oWeights
	oldOWeights <- oWeights
	oWeights <- oWeights + deltaOWeights
	
	deltaHidden <- getDeltaHiddenSum()
	deltaHWeights <- deltaHidden * iLayer
	hWeights <- hWeights + deltaHWeights
}