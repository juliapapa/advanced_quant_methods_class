##############################################
### Advanced Quantitative Research Methods
### Summer 2025
### Class 1: R basics
### by Xin Ye

###
### Basic Conventions
###

## Anything after '#' is a comment, and R ignores it. 
##    You should use comments profusely!
##    Comments will remind you what the codes does,
##    why you wrote it the way you did, and will 
##    make it easier for others to use/read your code.
## Object and function names are case sensitive 
## Underscore_names, dot.names, camelCase 

### 
### Installing packages
###

## Packages are bundles of functions, written by
## other R users. The 'base' functions included in
## your R distribution may not do everything you 
## want. In many cases, someone has already written
## a function that would do what you want. To access
## the function you need, you install the R package
## containing that function.

## For example, basic R cannot import data that was
## generated in the Stata software. The 'foreign' package,
## however, contains a function that allows us to read
## in such data. 

## To get access to the function we need, we first install
## the 'foreign' pacakge using install.packages():
# Install a package once

## You only need to install a package ONCE. After you've 
## installed it, you can call it using library()
library(foreign) # Call a library every session you need it

## NOTE: When you close R (or RStudio) and reopen it, the
## 'foreign' package will no longer be attached. If you 
## need to use a function from the 'foreign' package in 
## your new R session, you'll need to call the package
## by using library() again.

## NOTE: By convention, you should include all necessary 
## packages at the top of your R script. That way, when
## someone else runs your code, they immediately see which
## packages they might need to install.

###
### R As a Calculator
###

## We can use R as a (very powerful) calculator. To see
## how these basic operations work, you can highlight 
## the following codes and run them. To run a portion of
## your code, either highlight the code and hit CMD+ENTER (Mac)
## or CTRL+ENTER (PC); or highlight and cursor-click on "Run"
## in the top-right corner of the script window.

# Addition, subtraction
1+1

# Division:
1/2 

# Multiplication
2*3 

# Order of operations!
(2+3)*4 # This yields 20!
2+3*4 # This yields 14!

# Exponents
2^3 # 8


###
### Objects, Vectors
###

## R is what's called an "object oriented" language. In the
## world of R, everything revolves around objects. We create
## and manipulate objects. Objects can be single numbers, vectors,
## matrices, data frames, and so forth. Let's make a few objects.

# Create an object x
x <- 2
x

# Create an object y
y <- 4
y

## Now let's get some practice manipulating objects. If 
## we have two objects that are single numbers, we can 
## add them together. 

## NOTE: An object that's a single number, like x and y
## above, is *technically* a vector --- it's a vector that
## has a single element. 

# Adding objects together
x + y

## We can also manipulate an object by changing its value.
## In the code that follows, we take an object x and reassign
## it to be equal to itself plus 1. This *overrides* the value
## of x --- i.e., the value of x is changed to (x+1)

# Changing objects
x <- x + 1
x

## Vectors are sets of numbers. Vectors are described by
## their length, or the number of elements the vector 
## holds. Let's create a vector and see what it looks like.

# Create a vector of numbers
x <- c(2, 4, 6, 7, 8, 12, 18)
x

## NOTE: The c() stands for 'construct' or 'combine'. It
## takes the items in parentheses, each separated by a 
## comma, and maked them into a vector.

## In R, a lot of what we'll do is perform math functions on
## vectors. If we perform a math function on a vector using
## a single number, we perform the function on each element
## in the vector. For example, if we add 1 (a single number) 
## to the vector x, this is equivalent to adding 1 to every
## element in the vector. Let's try raising the vector x to
## the second power:

# Math with vectors
x
x^2

## To find out how long a vector is---i.e., how many elements
## the vector holds, we use the length() function.

# Length of a vector
length(x)

## We can add vectors together. If the vectors have the same
## length, adding the vectors results in adding corresponding
## elements together. (I.e., the resulting vector will have a
## first element equal to the sum of the first elements from 
## the two vectors.) See for example:

# Adding vectors
y <- c(3, 5, 7, 8, 9, 0, 7)
length(x) # x has 7 elements
length(y) # y has 7 elements
x + y 

## See? The first element of x+y is equal to the
## first element of x (2) plus the first element
## of y (3) = 5. We can, of course, create a NEW
## vector, and assign to it the values of x+y:

x.d <- x + y

###
### Sequences of numbers
###

## There are multiple ways to generate sequences of numbers
## in R. If you want the integers between two values, you 
## can just use a colon:

x <- 1:5
x

## We can also use the seq() function. This function takes three
## arguments: the starting value, the ending value, and the 
## increment of the sequence. See the help file:
?seq

## The following code will do the exact same thing as we did
## above using 1:5. We're telling R to start the sequence at
## 1, end it at 5, and create the sequence with increment 
## length 1. (i.e., count from 1 to 5 by 1.)

y <- seq(1, 5 , by = 1)
y

## That's just more typing than saying 1:5. But seq() is able
## to create sequences other than integers. For example, if
## we wanted a sequence of numbers from 1 to 5, increasing by 
## 0.2 each time:

z <- seq(1, 5, by = 0.2)
z

## This is much easier than trying to figure out the appropriate
## increment value in order to achieve a sequence of the right
## length, right?

# We can also reverse the ordering of a sequence:
x <- 5:1
x

y <- seq(5, 1, by = -0.2)
y


###
### Vector Indexing
###

## To access a specific element in a vector, we use what's 
## called indexing. Indexes are expressed within square 
## brackets right after an object name. First, let's 
## create a vector to play with:

x <- c(0, 0.1, 0.2, 0.3, 0.4, 0.5)
x

## To get the first element of the vector, we use the 
## name of the vector, followed by the number 1 in 
## square brackets, as such:
x[1]

## To get the last element, you would need to know first
## how many elements are contained in the vector. We know
## how to do that!
n <- length(x)

## We can access subsets of a vector. This might be useful
## when we want to compare some elements to other elements.
## We'll come up with an example in a moment. First, the 
## mechanics:

# To get the first five elements:
x[1:5]

# To get everything EXCEPT the fifth element:
x[-5]

# To get everything EXCEPT the first five:
x[-(1:5)]

# To get the first, third, and eighth elements:
x[c(1, 3, 8)]


###
### Functions of objects and vectors
###

## Functions are how most of our math gets done in R. Functions,
## just like in algebra, take an input (an 'argument' in R lingo),
## perform some operations, and spit out an output. Adding up the
## values of each element of x would be tedious--and our x only has
## seven elements! But the sum() function does this quickly.

## First, let's create an object
x <- c(2, 4, 6, 7, 8, 12, 18)

# Adding up the elements of x
sum(x)

## And of course, as always, we can assign this sum to 
## a new object, as such:
sum.x <- sum(x)

# The arithmetic mean of x
mean.x <- mean(x)
mean.x

# The median of y
median.y <- median(y)
median.y

# Standard deviation of y
snausage <- sd(y)
snausage

# Max, min values of x
min(x)
max(x) 

###
### Asking for help
###

## If you have a question about what a function does, or
## what arguments it takes, you can type ?functionname. So
## if you wanted to see that the min() function does, you 
## would just type:
?min

###
### Logical Statements
###

## We'll use logical statements a good bit in this class. If you've
## worked in other statsitical software, or in other languages like Python,
## Julia, etc, you may be familar with these. Logical statements return
## values of TRUE or FALSE, based on whether or not your assertion is
## true or false.

## To see how these work, let's reassign x to be an object that takes 
## the single value 2:

x <- 2

## The test for equality is two equal signs, '=='. If the two things
## are equal, R says TRUE. If they're not equal, R says FALSE>

# Equality
x == 2
x==1

## NOTE: VERY, VERY important. There is a BIG difference between the
## single equal '=' and the double equal '=='. The single equal sign
## is an assignment operator. In other words, '=' works the exact same
## as '<-'. So if you type x=3, you are NOT asking R if x equals 3. 
## You're telling R to (re)assign x the value of 3.

## There are many ways to test inequality. Basic inequalities, like
## greater/less than, are easy enough. Remember, the gator 'eats'
## the bigger number:

# Inequality
x > 1
x < 3

## If you want to test whether x is "greater than or equal to" some
## number, you use the greater than sign '>' and the equal sign '='

# Greater than or equal to
x >= 1
x >= 2
x >= 3

## And the same thing for "less than or equal to"

# Less than or equal to
x <= 1
x <= 2
x <= 3

## You can test whether x is UNEQUAL to a value. This is done by 
## using an exclamation point ! and equal sign =. This is read as
## "Is x NOT equal to (read: different from) this number?"

# Inequality
x != 3 # "Is x different from 3?" R says: TRUE
x != 2 # "Is x different from 2?" R says: FALSE

## We can also do logical tests on entire vectors. For example,
## if we have a vector x, and we want to know if each element is 
## equal to a number, we use the same type of notation as above:

# Create a vector x
x <- 1:5

# Is each element of x equal to 3?
x == 3 

## NOTE: See what R did? It says FALSE, FALSE, TRUE, FALSE, FALSE. 
## This is because the first, second, fourth and fifth elements of
## x are not equal to 3. The third element is equal to three.

# We can do the same with inequality:
x < 4


## Now imagine you wanted to ask "Does the number 2 appear in the vector
## x?" You can do that by using the following logical statement:
2 %in% x

## Does the number 5 appear in the vector 'x'?
5 %in% x

## We can use the which() function to ask R which elements of a vector
## meet a certain condition. For example, if we wanted to know "Which
## elements of x are equal to 2?" we could use the following function:

which(x == 2)

## Let's now introduce a new function, ifelse(). This function takes three args:
##  test: a logical statement
##  if TRUE: do this
##  if FALSE: do this
##
## The ifelse() function creates a new vector based on the contents of another
## vector. For every element where the logical statement is TRUE, the new vector
## is filled with the value in the "if TRUE" position; and the inverse for FALSE.
##
## That's confusing, let's just see this at work. Let's create a vector x.
x <- c(1, 1, 1, 2, 2, 4, 5, 9)

## Now let's use the ifelse() function. We'll create a new vector y that takes a 
## value 1 when x==1 and 0 everywhere that x!=1. Got it?
y <- ifelse(x == 2, 1, 0)
y 

## Observe that y is now a vector: 0, 0, 0, 1, 1, 0, 0, 0. The first element of y
## is 0 because the first element of x is 1, i.e. is not equal to 2. The fourth 
## element of y gets a 1 because the fourth element of x IS equal to 2, as is the
## fifth element of x. 

### 
### Missing values
###

## NA is a missing value. They can cause headaches since R doesn't automatically
## ignore them. For example, if we create the object z that is the numbers
## 1 to 5 and a missing value...
z <- c(1, 2, 3, 4, 5, NA) # N.b., could also z <- c(1:5,NA)

## ... and try to compute the mean, we run into an issue.
mean(z) # ugh.

## Most functions allow you to pass an optional argument, called na.rm.
## na.rm = TRUE tells the function to ignore missing values; na.rm=FALSE
## tells the function to keep the missing values in the vector/matrix.
mean(z, na.rm = T)

## this works for other functions, like median...
median(z)
median(z, na.rm = TRUE)

## variance (the square of standard deviation)
var(z)
var(z, na.rm = T)

## standard deviation
sd(z)
sd(z, na.rm = T)


###
### Datasets, variables, and summary statistics
### in this example, we are going to load a csv. file of the Quality of Government dataset
### inside read.csv(), there are two additonal arguments:
### "header = T" notifies R that the first row of the data should be parsed as header
### "stringASFactors = F" asks R not to turn character strings into factor objects

qog <- read.csv("C:/Users/julia/Documents/FGV/Advanced_Methods/Aula 1/qog_2019.csv", header = T, stringsAsFactors = F)

# notice that "gdppc" (GDP per capita) variable is parsed as an integer
# but it is more convenient to use it as an ordinary numeric object 
# which can take any numeric values and be implemented by any type of computation
# So we transform this variable to a numeric one by

qog$gdppc <- as.numeric(qog$gdppc)

# find GDP per capita of the United States?
qog$gdppc[qog$cname == "United States"]

# find those countries richer than the United States
# unique() is used to remove repetitive information
unique(qog$cname[qog$gdppc > qog$gdppc[qog$cname == "United States"]])

# alternatively, do it in multiple steps by creating new objects in R
group.a <- subset(qog, qog$gdppc > qog$gdppc[qog$cname == "United States"])
unique(group.a$cname)


# find the average GDP per capita among the countries richer than the United States
mean(qog$gdppc[qog$gdppc > qog$gdppc[qog$cname == "United States"]], na.rm = T)

