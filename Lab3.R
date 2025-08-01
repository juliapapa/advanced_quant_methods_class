##############################################
### Advanced Quantitative Research Methods
### Summer 2025
### Class 3: OLS Regression (additional)
### by Xin Ye


##################################################################
##################################################################

### 1. dealing with categorical explanatory variable and interpretation

# We will use the Duncan dataset from "car" package for this part
install.packages("pbkrtest")
install.packages("car", type = "binary")
library(car)
?Duncan

summary(Duncan)

# note that type (of occupation) is a categorical variable

# to include such a variable, use factor() to turn it into different categories
d_m1 <- lm(prestige ~ education + income + factor(type), data = Duncan)

summary(d_m1)

## "bc" is missing, which is used as the reference group for comparison 
## otherwise, we will have a perfect multicollinearity that prevents OLS estimation

## coefficient of "prof" tells you the difference between "bc" and "prof"
## coefficient of "wc" tells you the difference between "bc" and "wc"

# you can choose which category you want to drop by re-level the variable
Duncan$type <- relevel(Duncan$type, ref = "prof")
d_m2 <- lm(prestige ~ education + income + factor(type), data = Duncan)

summary(d_m2)

# to compare two regression results
library(stargazer)

stargazer(d_m1, d_m2, out = "modelouput1.html")

# HTML-format file generated in the working directory

#########################################################################

### 2 using high-order and interactive terms

# back to QOG data
# loading the QOG dataset (longer version), on e-learning)
# before loading the dataset, set the working directory first


# csv files or other types of files can be read by functions from "foreign"
# similarily, .dta format data can be loaded by read.dta()
library(foreign)

qog <- read.csv("qog_long.csv", header = T, stringsAsFactors = F)
qog <- read.csv("~/Desktop/FGV EAESP Winter School 2025/Class 2/qog_long.csv", header = T, stringsAsFactors = F)

# assume this is your base model 
m2 <- lm(iiag_gov ~ bti_ffe + log(mad_gdppc), data = qog)
summary(m2)

# You want to test if the effect of GDP per capita is nonlinear (with a quadratic term)
nl_m1 <- lm(iiag_gov ~ bti_ffe + log(mad_gdppc) + I(log(mad_gdppc)^2), 
            data = qog)
summary(nl_m1)
# It looks that a quadratic term does not capture the real variation of Y


## Now let's use an interactive term to see if the effect of election is 
## different across high- and low-income countries

# first let's dichotomize GDP per capita variable so the coefficients of 
# interactive model are more interpretable

qog$highincome <- ifelse(qog$mad_gdppc >= 8000, 1, 0)

# use : to indicate that you want to interact the two variables

inter_m <- lm(iiag_gov ~ bti_ffe + highincome + bti_ffe:highincome, 
              data = qog)

summary(inter_m)

# highincome is group indicator, 
# its coefficient represents baseline group difference in iiag_gov

# coefficient of election represents the effect of election in low-income group
# the sum of the coefficient of election and that of the interactive term
# represents the effect of election in high-income group


### additional technique: 
### use ggplot package to display potential group divergence

library(ggplot2) 

### add smooth lines to indicate trends by groups
ggplot(qog, aes(x = bti_ffe, y = iiag_gov, 
                   colour = factor(highincome))) + 
  geom_point() + theme_classic() + stat_smooth(method = "lm")

# if want to remove confidence interval
ggplot(qog, aes(x = bti_ffe, y = iiag_gov, 
                colour = factor(highincome))) + 
  geom_point() + theme_classic() + stat_smooth(method = "lm", se = FALSE)


### or use small facets to show patterns in different groups
ggplot(qog, aes(x = bti_ffe, y = iiag_gov)) + 
  geom_point() + theme_classic() + stat_smooth(method = "lm", se = FALSE) + 
  facet_wrap(~ factor(highincome))


