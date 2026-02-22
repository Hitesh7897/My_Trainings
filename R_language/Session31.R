#===============================================================================
# Chapter 30: Functions in R – Basics, Arguments & Return Values
#===============================================================================
# Practice & Problem Solving Reference
# -----------------------------------
# https://github.com/ganeshbabuNN/MyNotes/blob/master/Logical_Programming/
# Logical_Based_Programmings_Problems.txt
#===============================================================================


###############################################
# What is a Function?
###############################################
# A function is a reusable block of code
# that performs a specific task.

# Generic function syntax
function_name <- function(arg1, arg2, arg3) {
  statement1
  statement2
}


###############################################
# Simple Function Example
###############################################

add <- function(a, b) {
  result <- a + b
  return(result)
}

# Function call
add(4, 3)


###############################################
# Understanding Components of a Function
###############################################

# add        → function name
# a, b       → parameters
# add(4, 3)  → arguments
# result     → return value
# return()   → sends output back to caller


###############################################
# Variables, Objects & Values
###############################################

a <- 343
b <- 423

# a, b     → objects / variable names
# 343,423  → values / literals


###############################################
# Function with NO Arguments
###############################################

hello <- function() {
  print("hello world")
}

hello()


###############################################
# Built-in vs Custom Functions
###############################################

# Built-in functions
print()
cat()
sprintf()
mean()
nchar()

# Custom functions
# Defined by user using function()


###############################################
# Inspecting Functions
###############################################

?print
environment(hello)


###############################################
# Function with Loop Inside
###############################################
# Print squares from 1 to n

new.square <- function(a) {
  for (i in 1:a) {
    print(i^2)
  }
}

new.square(5)


###############################################
# Function Returning Character (Implicit)
###############################################

summing <- function(a, b, c) {
  result <- a + b + c
  paste(result)
}

sum_val <- summing(3, 3, 2)
sum_val

# Arithmetic will FAIL because result is character
# sum_val + 1   # ERROR


###############################################
# Function Returning Numeric (Correct Way)
###############################################

summing <- function(a, b, c) {
  result <- a + b + c
  return(result)
}

a <- summing(4, 3, 5.6)
a
typeof(a)  # "double"
class(a)   # "numeric"

a + 12


###############################################
# Conditional Logic Inside Function
###############################################
# Check if number is positive, negative or zero

check_num <- function(a) {
  if (a > 0) {
    result <- "positive"
  } else if (a < 0) {
    result <- "negative"
  } else {
    result <- "zero"
  }
  return(result)
}

check_num(36)
check_num(-5)
check_num(0)


###############################################
# Returning Multiple Values (WRONG WAY)
###############################################

cal <- function(a, b) {
  sum <- a + b
  sub <- a - b
  mul <- a * b
  div <- a / b
  return(sum, sub, mul, div)
}

cal(3, 4)

# ❌ return() can return ONLY ONE object
# R cannot return multiple separate objects


###############################################
# Returning Multiple Values (CORRECT WAY)
###############################################
# Use a list or other container

cal <- function(a, b) {
  sum <- a + b
  sub <- a - b
  mul <- a * b
  div <- a / b
  
  myList <- list(
    sum = sum,
    sub = sub,
    mul = mul,
    div = div
  )
  
  return(myList)
}

cal(4, 3)


###############################################
# Key Interview Takeaways
###############################################

# 1. Functions improve reusability & readability
# 2. Parameters ≠ Arguments
# 3. return() sends only ONE object
# 4. Use list() to return multiple values
# 5. Always return numeric for calculations
# 6. Character return breaks arithmetic
# 7. Functions have their own environment
# 8. Control flow (if/else, loops) works inside functions


###############################################
# END OF FILE
###############################################