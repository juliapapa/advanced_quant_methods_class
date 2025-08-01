##############################################
### Advanced Quantitative Research Methods
### Summer 2025
### Class 4: binary and count outcome models (GLM I)
### by Xin Ye

##################################################################
##################################################################

### 1. Binary outcomes
########################################

# Dataset: graduate school application  
# outcome: admit (binary)
# predictors: gre, gpa, (college) rank

admission <- read.csv("Aula 4/binary.csv")

summary(admission)

###

# To build a GLM, we use glm() instead of lm()

# The usage of glm() is largely the same as that of lm(),
# we need to specify model formula and data source using the same syntax.

# For glm(), we also need to describe what distribution we want to use for
# modeling the outcome variable. In binary outcome cases, the distribution 
# should be "binomial" (if you leave distribution unspecified, 
# "gaussian", that is the normal, will be used as default).

model1 <- glm(admit ~ gre + gpa + rank, data = admission, 
              family = binomial)

# logit is the default method for "binomial" type of GLM

summary(model1)

library(stargazer)

stargazer(model1, out = "model1.html")

# BTW, to produce a summary statistics table for the dataset

stargazer(admission, summary = T, out = "summarytable.html")

#####################################

# If you want to switch to probit, add "(link = probit)" after 
# "binomial"



model2 <- glm(admit ~ gre + gpa + rank, data = admission, 
              family = binomial(link = probit))

summary(model2)

################

# Interpret coefficients in logit

summary(model1)

# exponentiation in R: exp()
# e.g. compute e to the power of 2
exp(2)

# We can make prediction by manually entering the inverse logit function
# exp()/(1+exp())
# or We can use invlogit() provided by arm package instead

####

# Example: How the probability would change if gpa increases from 2 to 3?

# Let's set the rest predictors at their means

coef(model1)

eta1 <- coef(model1)[1] + coef(model1)[2] * mean(admission$gre) + 
  coef(model1)[3] * 2 + coef(model1)[4] * mean(admission$rank)

eta2 <- coef(model1)[1] + coef(model1)[2] * mean(admission$gre) + 
  coef(model1)[3] * 3 + coef(model1)[4] * mean(admission$rank)

exp(eta2)/(1+exp(eta2)) - exp(eta1)/(1+exp(eta1))

# Or
install.packages("arm")
library(arm)

invlogit(eta2) - invlogit(eta1)


### divide by 4

coef(model1)/4

# For GPA, the maximum possible change  
# in probability corresponding to 1 increase is +0.19


### exponentiation for odds

exp(coef(model1))

# For GPA, one unit increase leads to 17.5% increase in odds
exp(coef(model1))[3]

###

# For rank, one unit increase leads to a multiplicative change of 0.57 in odds
exp(coef(model1))[4]

# or 42.9% decrease in odds
1 - exp(coef(model1))[4]


###############################################################
###############################################################


### 2. Count Outcomes

### Running Example: 
### Interlocking directorates among major Canadian firms

# Source: Ornstein, M. (1976)

library(carData)

data("Ornstein")

?Ornstein # Read the codebook

summary(Ornstein)

# firm-level dataset
# Outcome variable: interlocks (No. of interlocking director and executive positions) 
# Explanatory variable: assets, sector, nation


### Poisson Model

# still use glm(), but specify "family" type as "poisson"

model1 <- glm(interlocks ~ log(assets) + sector + nation, data = Ornstein, 
              family = poisson)

summary(model1)

# Interpret the effects of coefficients by exponentiation
exp(coef(model1))

# Remember that the effects are multiplicative, due to the exponential component

#########################

### Is Poisson regression a right choice? We need to test dispersion assumption 
# It is best to do it before running a Poisson regression

# The disperson test is based on "AER" package (make sure to install it first)

install.packages("AER")
library(AER)

dispersiontest(model1, alternative = "greater") 
# we specify over-dispersion as the alternative H

# p < 0.05, reject the null
# evidence for over-dispersion
# So we need to use quasi-poisson or negative binomial instead

### Run a quasi-Poisson

model2 <- glm(interlocks ~ log(assets) + sector + nation, 
              data = Ornstein, family = quasipoisson)

summary(model2)

# Notice the estimated value of dispersion parameter (phi)

####

### Run a negative binomial model (function from MASS package)
library(MASS)
model3 <- glm.nb(interlocks ~ log(assets) + sector + nation, 
                 data = Ornstein)

summary(model3)

exp(coef(model3))

########################################################

### Use a likelihood ratio test to compare two nested models
# recall our lecture on MLE

# Let's compare two negative binomial models:

res.m <- glm.nb(interlocks ~ log(assets) + sector, data = Ornstein)
unres.m <- glm.nb(interlocks ~ log(assets) + sector + nation, 
                  data = Ornstein)

# The point for doing a likelihood ratio test is to figure out if
# the unrestricted model is SIGNIFICANTLY better than the restricted one 
# (in terms of the log likelihood score)

# In other words, whether including additional variable(s) in our model does
# help improve our model

# The test function is based on "lmtest" (install first if you don't have it)

install.packages("lmtest")
library(lmtest)
lrtest(res.m, unres.m)

# p < 0.05, significant difference between the two
# Conclusion: the unrestricted model is better
# in other words, "nation" is a relevant explanatory variable for the model

###########################################################################

### additional technique: clear R's working environment

# to selectively remove objects from R's memory (e.g. "res.m")

rm(res.m)

# to clear the entire space (be cautious if you have something important in the working environment)
rm(list = ls())

