# neural network test

inputLayer <- matrix(c(1,1),nrow=1,ncol=2)
inputWeights <- matrix(c(0.8,0.2,0.4,0.9,0.3,0.5),nrow=2,ncol=3)
hiddenWeights <- matrix(c(0.3,0.5,0.9),nrow=3,ncol=1)
expectedValue <- 0

singleTest <- function(iLayer = inputLayer,
                       iWeights = inputWeights,
                       hWeights = hiddenWeights,
                       expected = expectedValue) {
  hLayer <- getHiddenLayer(iLayer, iWeights)
  sMHLayer <- applySoftmax(hLayer)
  oLayer <- getOutputLayer(sMHLayer, hWeights)
  sMOLayer <- applySoftmax(oLayer)
  loss <- calculateLoss(expected,sMOLayer)
  backPropagation(iLayer,iWeights,sMHLayer,
                  hWeights,sMOLayer,loss)
  return(list(iWeights,hWeights,sMOLayer))
}

nTest <- function(iLayer = inputLayer,
                  iWeights = inputWeights,
                  hWeights = hiddenWeights,
                  expected = expectedValue,
                  n = 10) {
  weights <- singleTest(iLayer,iWeights,hWeights,expected)
  for (i in 2:n) {
    weights <- singleTest(iLayer,iWeights = weights[[1]],
                          hWeights = weights[[2]],expected)
  }
  return(weights)
}