##############################################
### Advanced Quantitative Research Methods
### Summer 2025
### Class 5: categorical and duration outcome models (GLM II)
### by Xin Ye

##################################################################
##################################################################

### 1. Ordinal logit/probit

# Let's replicate the analysis with NES 1996 in the lecture

install.packages("faraway")
library(faraway)
summary(nes96)

# ordinal logit
library(MASS)
order_m <- polr(PID ~ age + income + educ, 
                data = nes96)

summary(order_m)

# To interpret the effect using divide-by-4

coef(order_m)/4 
# for example, one unit increase in education level leads to 
# no more than 1.8% increase in the probability


# To interpret the baseline probability based on intercepts
order_m$zeta # how to extract those intercepts

library(arm)
invlogit(order_m$zeta)

# What is the basline probability of being independent?
invlogit(order_m$zeta)[4] - invlogit(order_m$zeta)[3] # p = 0.037

# What is the baseline probability of being strong Republican?
1 - invlogit(order_m$zeta)[6] # p = 0.13

#####

order_m2 <- polr(PID ~ age + educ, nes96, 
                 method = "probit")

summary(order_m2)

# coefficients in probit indicate the change in the Z-score of the probability

########################################

### 2. Unordered logit (multinomial)

# install.packages("nnet")

library(nnet)
unordered_m <- multinom(PID ~ age + educ + income, nes96)

summary(unordered_m)

###

# to calculate basline probability

intercept <- c(0, coef(unordered_m)[, 1]) # "0" included to indicate the baseline category

exp(intercept) / (1 + sum(exp(intercept)))


#####################################################

### 3. Duration Outcome Models

 install.packages("survival")
install.packages("MASS")

library(MASS) # Where our two dataset come from
library(survival) # What survival models are based on

# Dataset 1: leukaemia patient data in the lecture (uncensored)
data(leuk)
?leuk

# Dataset 2: leukaemia patient data from a medical trial (right-censored)
data(gehan)
?gehan

#########################################################################

# Kaplan-Meier estimator (log method is used to compute confidence intervals by default)

km1 <- survfit(Surv(time) ~ ag, data = leuk)
summary(km1)
plot(km1)

# with right-censoring, put two variables into Surv(): duration, status
km2 <- survfit(Surv(time, cens) ~ treat, data = gehan)
summary(km2)
plot(km2)

########

# ggplot2 + ggfortify sharpen Kaplan-Meier survival curves

library(ggplot2)
library(ggfortify)

autoplot(km1)
autoplot(km2) # "+" indicates censored cases 

############################################

# Exponential and Weibull models

wbm1 <- survreg(Surv(time) ~ ag + log(wbc), data = leuk) # Weibull is the default
summary(wbm1)

wbm2 <- survreg(Surv(time, cens) ~ treat, data = gehan)
summary(wbm2)

#

em1 <- survreg(Surv(time) ~ ag + log(wbc), data = leuk, dist = "exponential")
summary(em1)

em2 <- survreg(Surv(time, cens) ~ treat, data = gehan, dist = "exponential")
summary(em2)

# table report

library(stargazer)

stargazer(wbm1, em1, wbm2, em2, out = "hazard.html")

# interpretation (exponentiate beta)

exp(wbm2$coefficients)

# the drug being tested reduces remission time by a factor of 0.28
# or drug reduces remission time by 72% (1-0.28)

########################################################

# 4. Cox hazard model

cox1 <- coxph(Surv(time) ~ ag + log(wbc), data = leuk)
summary(cox1)

cox2 <- coxph(Surv(time, cens) ~ treat, data = gehan)
summary(cox2)

# interpretation: drug increases the "hazard" ratio of remission 
# by a factor of 4.82 (382% increase)

#######################

# test the proportionality-hazard assumption for the Cox model

# the null: proportionality
# the alternative: violation of proportionality

cox.zph(cox1)
cox.zph(cox2)

# neither each predictor nor the global test has a p < 0.05 
# cannot reject the null (having proportional effects)
# that said, the Cox models are valid in the two applications

