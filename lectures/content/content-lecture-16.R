library(MASS)
library(magrittr)
sigma <- matrix(data = c(0.5,1.5,1.5,4.5), ncol = 2)
data_sample <- mvrnorm(n = 100, mu = c(5,5), Sigma = sigma) %>% data.frame
data_sample %>% {plot(x = .$X1, y = .$X2)}
plot(x = rnorm(n = 100), y = rnorm(n =100))

#????
# couldnt fivure out how to get a positive definite(??) covariance matrix...... should probs go back to review regression and then yuan's class...