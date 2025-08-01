##############################################
### Advanced Quantitative Research Methods
### Summer 2025
### Class 2: OLS Regression
### by Xin Ye


##################################################################
##################################################################
# Reading in data (the Quality of Government Data)

# before loading the dataset, set the working directory first
qog <- read.csv("qog_long.csv", header = T, stringsAsFactors = F)

##################################################################
# Variables for this analysis:

# bti_ci: conflict intensity (our outcome variable of interest)
# bti_ffe: free and fair election, 10 for the best
# al_ethnic: ethnic fractionalization
# mad_gdppc: GDP per capita
# p_polity2: polity2 score (political regime)
# pwt_pop: population
# icrg_qog: government quality score

##################################################################

# The original dataset is too large. Let's focus on just a few variables
# To make our dataset clean, we subset it by selected variables

qog_s <- subset(qog, select = c("bti_ci", "bti_ffe", "al_ethnic", 
                                "mad_gdppc", "p_polity2", "pwt_pop", 
                                "icrg_qog"))

##### view and explore data structure

head(qog_s) # for a quick inspection of a data.frame

# accessing rows and columns
qog_s[7, ] # row 7
qog_s[, 2] # column 2
qog_s[3, 1] # row 3, column 1

# accessing certain variables
qog_s[, 2]
qog_s[,"bti_ffe"]
qog_s$bti_ffe


# accessing multiple variables
qog_s[, c("p_polity2", "pwt_pop")]


# learn more about the data.frame
dim(qog_s) # dimensions of the data.frame
names(qog_s) # variable names in the data.frame
colnames(qog_s) # same thing
rownames(qog_s) # for data.frames not always interesting


# change variable labels in a data.frame
colnames(qog_s)[1] <- "conflict"
colnames(qog_s)

##############################################################

#### plotting variables

## first of all, explore the summary statistics of the dataset 
## the distribution of outcome variable

summary(qog_s)

plot(density(qog_s$icrg_qog, na.rm = T))  # good enough for the normality assumption

# take a look at GDP per capita
plot(density(qog_s$mad_gdppc, na.rm = T))  # a long tail

# log can adjust it toward the normal distribution
plot(density(log(qog_s$mad_gdppc), na.rm = T))


##################################################################

## FIT THE REGRESSION MODEL

## Here we fit the linear regression model. The function for
## the model is lm() which takes arguments:
##  formula:  the expression of the model. We put the dependent
##            variable, then a tilde, then our independent 
##            variable. For example, Y ~ X.
##  data:     the name of the data frame where the variables
##            can be found.
##

### Let's first test if economic development helps to explain conflict intensity
model1 <- lm(bti_ci ~ mad_gdppc, data = qog)

### Get a full summary of the regression result, which includes:
# distribution of residuals
# coefficient table (estimate, standard error, t statistic, p value)
# residual standard error
# R^2 (proportion of the variation explained by the model)
# F statistic and test (test if the model is better than a model without any explanatory variables)

summary(model1)

# The coefficient is too small. So we would like to use log(GDP per capita) instead
# to the magnitude of the coefficient more visiable

model1 <- lm(icrg_qog ~ log(mad_gdppc), data = qog)
summary(model1)


### Add more variables into the model

model2 <- lm(icrg_qog ~ log(mad_gdppc) + p_polity2, data = qog)

summary(model2)


model3 <- lm(icrg_qog ~ log(mad_gdppc) + p_polity2 + log(pwt_pop), 
             data = qog)

summary(model3)

#########################################################################

### important technique 1: 
### generate regression table

install.packages("stargazer") # run this line only when the package is not installed

library(stargazer)

# generate a regression table to include model1, model2 and model 3 in a html file 
stargazer(model1, model2, model3, out = "model.html")
getwd()

# open that html file, and then copy and paste the table to your word document 


### important technique 2: 
### standardized coefficients to compare effect size
### formula: beta * sd(X) / sd(Y)

# we can directly extract all the parameters by
model3$coefficients

# or
coef(model3)

# standardizing the coefficient of GDP per capita
coef(model3)[2] * sd(log(qog_s$mad_gdppc), na.rm = T) / sd(qog_s$icrg_qog, na.rm = T)
# which is around 0.7

# standardizing the coefficient of polity2
coef(model3)[3] * sd(qog_s$p_polity2, na.rm = T) / sd(qog_s$icrg_qog, na.rm = T)
# which is around 0.23

# so GDP per capita has a greater impact on the outcome variable


### important technique 3: 
### make prediction based on regression models

# get predicted values for all the observations (systematic component)
predict(model3)

# make prediction with a fake observation
new_data <- data.frame(mad_gdppc = 10000, p_polity2 = 5, pwt_pop = 42)

predict(model3, new_data)
# the predicted quality score is 0.51, with our model 3                    

# we can also ask for a 99% confidence interval for this prediction
predict(model3, new_data, interval = "confidence", level = 0.99)


### important technique 4: 
### quick model diagnostics (built-in function in R)

plot(model3)

# Hit return/enter key to see the next plot

# 1: Residuals vs fitted plot, checking if the mean of residuals equals 0
# 2: Normal Q-Q plot, checking if residuals are normally distributed
# 3: Scale-location plot, checking homoscedasticity (contanst variance of residuals)
# 4: Residual vs leverage plot, checking outliers with conventional Cook's distance cutoff

# show them in one plot (edit the layout of the basic plot)
par(mfrow = c(2, 2))
plot(model3)

# if you want to switch back to the original layout and clean the plot section
dev.off()

