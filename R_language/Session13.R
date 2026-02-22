#===============================================================================
# Chapter 12: Operators in R (Complete & Practical)
#===============================================================================
# References (Practice & Learning)
# --------------------------------
# https://leetcode.com/problem-list/design/
# https://www.kaggle.com/competitions
# https://github.com/ganeshbabuNN/MyNotes/tree/master/Logical_Programming
#===============================================================================


#===============================================================================
# Types of Operators in R
#===============================================================================
# 1. Arithmetic Operators
# 2. Assignment Operators
# 3. Relational Operators
# 4. Logical Operators
# 5. Special Operators
# 6. Special Infix Operators
# 7. Subsetting Operators
# 8. Tidyverse Logical Helpers
# 9. Bitwise Operators
#===============================================================================


###############################################
# 1. Arithmetic Operators
###############################################

# Basic arithmetic
3 + 3          # addition
3 - 3          # subtraction
4 * 4          # multiplication
4 / 3          # division
2 ^ 3          # exponentiation

# Unary operators
x <- c(1, 2, -3)
-x             # unary minus
+x             # unary plus

# Real-world example
basic <- 50000
hra <- 0.2 * basic
gross_salary <- basic + hra
gross_salary

# Avoid scientific notation
format(gross_salary, scientific = FALSE)
options(scipen = 999)
# options(scipen = 999) prevents scientific notation

# Common mistake
# "4" + 3      # ERROR: non-numeric argument


###############################################
# 2. Assignment Operators
###############################################

# Left assignment (recommended)
x <- 3
x

# Right assignment
393 -> a
a

# Equal assignment (allowed but discouraged)
a = 3
a

# Global assignment (<<-)
a <- 10

fn <- function() {
  print(a)      # global
  b <- 20       # local
  print(b)
  a <<- 200     # modifies global variable
  print(a)
}

fn()
a               # global value changed


###############################################
# 3. Relational Operators
###############################################

a <- c(3, 5.5, 6)
b <- c(22, 7, 6)

a <  b
a >  b
a <= b
a >= b
a == b
a != b


###############################################
# 4. Logical Operators
###############################################

a <- c(TRUE, FALSE, TRUE)
b <- c(FALSE, TRUE, TRUE)

# Element-wise (vectorized)
a & b
a | b
!a

# Short-circuit (first element only)
a <- TRUE
b <- FALSE

a && b
a || b


###############################################
# 5. Special Operators
###############################################

# Sequence operator
1:10

# Membership operator
x <- c("Hitesh", "Max", "rocky")
"Hitesh" %in% x     # TRUE
"hitesh" %in% x     # FALSE
"nadi"   %in% x     # FALSE

# Matrix multiplication
m1 <- matrix(1:6, nrow = 2)
m2 <- matrix(1:6, nrow = 3)
m1 %*% m2


###############################################
# 6. Special Infix Operators
###############################################

# User-defined infix operator
`%!in%` <- Negate(`%in%`)

"Hitesh" %!in% x    # FALSE
"nadi"   %!in% x    # TRUE


###############################################
# 7. Subsetting Operators
###############################################

v <- c(10, 20, 30, 40)
v[1]
v[2:3]
v[v > 20]

# Data frame subsetting
df <- data.frame(
  id  = 1:4,
  age = c(22, 35, 40, 28)
)

df[df$age > 30, ]
df[ , "age"]
df[["age"]]


###############################################
# 8. Tidyverse Logical Helpers
###############################################

library(dplyr)

df %>%
  filter(age > 30)

# Helper functions
between(df$age, 25, 40)
near(0.3, 0.30000001)
if_any(df, is.numeric)
if_all(df, is.numeric)


###############################################
# 9. Bitwise Operators
###############################################
# In R, bitwise operations are performed using functions
# (not symbols like in C/C++). Numbers are treated as
# 32-bit integers internally.

# Bitwise AND
bitwAnd(10, 3)

# Bitwise OR
bitwOr(10, 3)

# Bitwise XOR
bitwXor(10, 3)

# Bitwise NOT
bitwNot(10)

# Bitwise shift
bitwShiftL(2, 1)    # left shift
bitwShiftR(8, 1)    # right shift


###############################################
# Operator Precedence (Important for Exams)
###############################################

# Highest → Lowest
# ^
# unary + -
# * /
# + -
# < <= > >= == !=
# !
# & &&
# | ||
# <- <<- = -> ->>

# Examples
4 * 7 %% 3
2 * 3 ^ 2
4 ^ 2 + 2
(3 ^ 2) * 2


###############################################
# Key Interview Takeaways
###############################################

# 1. Operators are functions in R
'+'(2, 3)

# 2. Logical TRUE = 1, FALSE = 0
TRUE  + TRUE
FALSE + 10

# 3. & vs && and | vs ||
# & , |   → vectorized
# &&, ||  → first element only

# 4. <<- should be avoided in production code


###############################################
# END OF FILE
###############################################