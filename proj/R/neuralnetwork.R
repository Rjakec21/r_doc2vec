# input layer should be an array
# weights should be specific to a document (in between input and hidden layer)
getHiddenLayer <- function(input_layer, weights) {
  # return the array representing the hidden layer
}

# hidden layer is calculated by getHiddenLayer()
# weights should be specific to a document (in between hidden and output layer)
getOutputLayer <- function(hidden_layer, weights){
  # return the array representing the output layer
}

# Apply the softmax equation to the output layer.
applySoftmax <- function(output_layer){
  # return the array representing the output layer
	# normalized using the softmax equation.
}

# Calculate the loss based on the error between the
# expected value and the real value.
calculateLoss <- function(expected_value, real_value) {
  # return a value representing the distance between
  	# the expected value and the real value.
}

# Change the weights based on stochastic gradient descent based on error and learning rate.
backpropagation <- function(hidden_layer_weights, output_layer_weights, loss, learning_rate){
	# No return needed, just need to modify the weights to adjust for error.
}