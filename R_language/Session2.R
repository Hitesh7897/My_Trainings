#===============================================================================
# Chapter: Input, Output, Functions & OOP Basics in R
#===============================================================================

########################################
# 1. BASIC OUTPUT
########################################

# Simple print
print("hello world")

########################################
# 2. USING A FUNCTION (FUNCTION STYLE)
########################################

display <- function() {
  print("hello world")
}

display()

########################################
# 3. GETTING USER INPUT
########################################

# Getting character input
pet_name <- readline(prompt = "Enter your favorite pet: ")
pet_name
typeof(pet_name) # character

#readline function will take the input as character

# Getting numeric input
age <- readline(prompt = "Enter your age: ")
age
typeof(age) # character

# Convert to integer
age <- as.integer(age)
age
typeof(age) # integer

########################################
# 4. USING scan() FOR INPUT
########################################

# Scan numeric values (default = numeric)
x <- scan() # To exit user input mode in console, press Enter twice
x
typeof(x) # double
class(x) # numeric

# Scan integer values
x <- scan(what = integer())
x
typeof(x) # double
class(x) # numeric

# Scan double values
x <- scan(what = double())
x
typeof(x) # double
class(x) # numeric

########################################
# 5. HELP & DOCUMENTATION
########################################

library(tidyverse)

help("function")
help(left_join)

?print

example("function")
demo(plotmath)

########################################
# 6. TOKENS, COMPILER & INTERPRETER (CONCEPT)
########################################

# Tokens are smallest meaningful units
# Examples of tokens:
# if
# function
# identifiers (variables)
# literals (values)

# Keywords (cannot be used as variable names)
if
function
ifelse
NA

########################################
# 7. OUTPUT FUNCTIONS
########################################

cat("Hitesh", "B G")

########################################
# 8. COMMENTS
###########################################
# This is a single-line comment
#
# No Multiple commented lines in R
#
#
###########################################

########################################
# 9. VARIABLES & EXPRESSIONS
########################################

a <- 4
b <- 3

########################################
# 10. PRINT OPTIONS
########################################

print("hello world")
print("hello world", quote = FALSE)
print(paste("hello", "World"), quote = FALSE)

########################################
# 11. FUNCTION WITH MULTIPLE PRINT STYLES
########################################

hello <- function() {
  print("hello world")
  print("hello world", quote = FALSE)
  print(paste("hello", "World"), quote = FALSE)
}

hello()

# Notes:
# hello     -> identifier
# function  -> keyword
# print     -> built-in function
# FALSE     -> logical literal

########################################
# 12. S3 OBJECT SYSTEM
########################################

# Generic function
say_msg <- function(obj) UseMethod("say_msg")

# Method for class "demo_class"
say_msg.demo_class <- function(obj) {
  paste("Hello", obj$value)
}

# Create object
x <- list(value = "World")
class(x) <- "demo_class"

# Call method
say_msg(x)

########################################
# 13. S4 OBJECT SYSTEM
########################################

# Define class
setClass(
  "Person",
  slots = list(name = "character")
)

# Create object
p_s4 <- new("Person", name = "World")

# Define generic
setGeneric("hello", function(object) standardGeneric("hello"))

# Define method
setMethod("hello", "Person", function(object) {
  paste("Hello", object@name)
})

# Call method
hello(p_s4)

########################################
# 14. R6 OBJECT SYSTEM
########################################

# R6 objects own their behavior (Java-style)
library(R6)

Person <- R6Class(
  "Person",
  public = list(
    name = NULL,
    
    initialize = function(name) {
      self$name <- name
    },
    
    hello = function() {
      paste("Hello", self$name)
    }
  )
)

# Create object
p_r6 <- Person$new("World")

# Call method
p_r6$hello()

########################################
# END OF FILE
########################################

# Key Takeaways:
# - Input: readline(), scan()
# - Output: print(), cat()
# - Functions are objects
# - Operators are functions
# - R supports S3, S4, and R6 OOP systems
# - Everything in R is an object