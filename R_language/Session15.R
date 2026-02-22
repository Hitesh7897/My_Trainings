#===============================================================================
# Chapter 14: Operator Associativity, Precedence & Overloading in R
#===============================================================================
# Practice & References
# ---------------------
# https://leetcode.com/problem-list/design/
# https://www.kaggle.com/competitions
# https://github.com/ganeshbabuNN/MyNotes/tree/master/Logical_Programming
#===============================================================================


###############################################
# Operator Associativity in R
###############################################

# Associativity answers the question:
# "When multiple operators of the SAME precedence exist,
#  in which direction are they evaluated?"

# Types:
# 1. Left-to-Right
# 2. Right-to-Left


###############################################
# Relational Operator Associativity
###############################################

5 < 10 < 20

# Interpreted as:
(5 < 10) < 20
# TRUE < 20
# 1 < 20
# TRUE

# IMPORTANT:
# - This is NOT mathematical chaining (unlike Python)
# - Avoid such expressions in production code


###############################################
# Right-to-Left Associativity (Assignment)
###############################################

# Assignment operators are evaluated Right-to-Left
# <- , -> , =

a <- b <- c <- 10
a
b
c

# Equivalent evaluation:
a <- (b <- (c <- 10))


###############################################
# Exponentiation (Right-to-Left)
###############################################

2 ^ 3 ^ 2

# Evaluated as:
2 ^ (3 ^ 2)
2 ^ 9
512

(2 ^ 3) ^ 2
# 8 ^ 2 = 64


###############################################
# Memory Behavior (Copy-on-Modify)
###############################################

library(lobstr)

c <- 10
obj_addr(c)

b <- c
obj_addr(b)

a <- b
obj_addr(a)

# NOTE:
# Same memory address until modification (copy-on-write)


###############################################
# Mixed Assignment
###############################################

10 -> x -> y
y

# Equivalent:
y <- (x <- 10)


###############################################
# Logical NOT Associativity
###############################################

!!TRUE
!(!TRUE)
!FALSE
TRUE


###############################################
# Unary Operators (Right-to-Left)
###############################################

-+5
-(+5)
-5


###############################################
# Sequence Operator (:) Associativity
###############################################

3 : 5 : 2

# Interpreted as:
(3 : 5) : 2

3 : (5 : 2)


###############################################
# Combined Expression (Complex Example)
###############################################

8 + 2 ^ 4 ^ 3

# Interpreted as:
8 + 2 ^ (4 ^ 3)
8 + 2 ^ 64

8 + (2 ^ 64)


###############################################
# Relational + Logical Precedence
###############################################

50 > 10 == 3

# Evaluated as:
(50 > 10) == 3
TRUE == 3
1 == 3
FALSE


###############################################
# Mixed Arithmetic
###############################################

3 ^ 4 * 3
# Exponentiation first → then multiplication


###############################################
# Operator Precedence Order (High → Low)
###############################################

# ()        Parentheses
# ^         Exponentiation (Right-to-Left)
# + -       Unary plus / minus
# * / %%    Multiplication / Division / Modulus
# + -       Addition / Subtraction
# :         Sequence
# < <= >    Relational
# == !=
# !         Logical NOT
# &         Logical AND (vectorized)
# |         Logical OR
# && ||     Short-circuit logical
# <- -> =   Assignment (Right-to-Left)
# ~         Formula (Right-to-Left)


###############################################
# Step-by-Step Evaluation Example
###############################################

result <- 5 + 2 ^ 3 * 4 > 20 & !FALSE
result

# Step breakdown:
# 2 ^ 3        = 8
# 8 * 4        = 32
# 5 + 32       = 37
# 37 > 20      = TRUE
# !FALSE       = TRUE
# TRUE & TRUE  = TRUE


###############################################
# PEMDAS+ Rule (R Version)
###############################################

# P  → Parentheses
# E  → Exponentiation
# U  → Unary operators
# M  → Multiplication / Division
# A  → Addition / Subtraction
# S  → Sequence
# R  → Relational
# L  → Logical
# A  → Assignment

# Reference:
# https://www.geeksforgeeks.org/maths/pemdas-rule/


###############################################
# Real-World Logical Filtering Example
###############################################

df <- data.frame(
  age    = c(18, 22, 30, 15),
  salary = c(20000, 30000, 50000, 15000)
)

df$age >= 18 & df$salary > 25000


###############################################
# Operator Overloading & Overriding
###############################################

# Operator Overloading:
# Same operator behaves differently for different data types


#-----------------------
# Numeric
#-----------------------
a <- 3
b <- 4
a + b


#-----------------------
# Character (Not Allowed)
#-----------------------
a <- "Hitesh"
b <- "B G"
# a | b        # ERROR: invalid operation


#-----------------------
# Vector (Element-wise)
#-----------------------
l1 <- c(1, 2, 3)
l2 <- c(1, 2, 3)
l1 + l2


#-----------------------
# List (Not Supported)
#-----------------------
l1 <- list(1, 2, 3)
l2 <- list(1, 2, 3)
# l1 + l2      # ERROR: non-numeric argument


###############################################
# Key Interview Takeaways
###############################################

# 1. R does NOT support chained comparisons
# 2. Assignment & exponentiation are Right-to-Left
# 3. Use parentheses to avoid ambiguity
# 4. Operators are functions internally
# 5. Overloading depends on data type support
# 6. Logical coercion happens silently (TRUE → 1)


###############################################
# END OF FILE
###############################################