#===============================================================================
# Chapter 32: Functions – Advanced Concepts & Scope
#===============================================================================


################################################################################
# RETURNING MULTIPLE VALUES USING LIST
################################################################################

cal <- function(a, b) {
  sum <- a + b
  sub <- a - b
  mul <- a * b
  div <- a / b
  
  myList <- list(sum, sub, mul, div)
  return(myList)
}

cal(4, 3)


################################################################################
# FUNCTION OVERLOADING & OVERRIDING (AWARENESS)
################################################################################

# Function overriding
# Same function name, same arguments
# Latest definition overrides the previous one

add <- function(a, b) {
  print("hello")
  return(a + b)
}

add <- function(b, c) {
  print("hello1")
  return(b + c)
}

add(2, 3)


# Function overloading (NOT supported in R)
# Same function name, different number of arguments
# R always picks the latest definition

add <- function(a, b) {
  print("hello")
  return(a + b)
}

add <- function(b, c, d) {
  print("hello1")
  return(b + c + d)
}

add(4, 3)   # Error: missing argument


################################################################################
# SCOPE & LEGB RULE
################################################################################

# LEGB:
# L → Local
# E → Enclosing
# G → Global
# B → Built-in


################################################################################
# NESTED FUNCTIONS & SCOPE
################################################################################

x <- "I am Global"
pi <- 100   # Overriding built-in pi in global scope

outer_func <- function() {      # Parent function
  x <- "I am Enclosing"
  cat("\nParent Function x:\n", x)
  
  inner_func <- function() {    # Child function
    cat("\nChild Function x (before update):\n", x)
    
    x <<- "ganesh"              # Update global variable
    cat("\nChild Function x (after global update):\n", x)
    
    local_val <- "I am Local"
    print(x)                    # Global x
    print(pi)                   # Global pi
  }
  
  inner_func()
  cat("\nParent Function x (after child execution):\n", x)
}

print(x)
outer_func()


################################################################################
# GLOBAL VARIABLE MODIFICATION USING <<-
################################################################################

x <- 20

swetha <- function() {
  x <- 10
  print(x)      # Local
  x <<- 100     # Global modification
}

swetha()
print(x)


################################################################################
# ASSIGNING FUNCTION RESULT TO A VARIABLE
################################################################################

display <- function() {
  return(3)
}

a <- display()
print(a)


################################################################################
# FUNCTION INSIDE ANOTHER FUNCTION
################################################################################

display <- function(name) {
  message <- function() {
    print("hello")
  }
  result <- paste(message(), name)
  return(result)
}

display("ganesh")


################################################################################
# RETURNING A VALUE FROM FUNCTION
################################################################################

display <- function() {
  return(5)
}

library(tidyverse)

display()
find("str_to_upper")

rm("display")

a <- display()
print(a)


################################################################################
# PASSING ANY TYPE TO A FUNCTION
################################################################################

a <- function(a, b, c) {
  return(a + b - c)
}

a(3, 2, 3)
a(b = 4, c = 10, a = 5)   # Named arguments


################################################################################
# USING do.call()
################################################################################

list_a <- list(b = 4, c = 10)
typeof(list_a)

# Pass list as arguments dynamically
do.call(a, c(list(a = 1), list_a))


################################################################################
# rbind() WITH do.call()
################################################################################

rbind("ae", "mh", "cm", "lb")

list_df <- list("ae", "mh", "cm", "lb")
do.call(rbind, list_df)


################################################################################
# DEFAULT ARGUMENTS
################################################################################

a <- function(a = 10, b, c) {
  return(a + b - c)
}

a(c = 100, b = 50)
a(c = 100, b = 50, a = 300)   # a overrides default


################################################################################
# VARIABLE NUMBER OF ARGUMENTS
################################################################################

a <- function(a) {
  return(a * 3)
}

b <- c(2, 6, 9, 6)
a(b)

do.call(a, list(c(2, 6, 9, 6)))


################################################################################
# ELLIPSIS (...)
################################################################################

sum(3, 4, 5, 6)

a <- function(...) {
  return(sum(...))
}

a(c(4, 5, 6, 7, 7))
a(6, 6, 7, 87, 9)


################################################################################
# LIST, UNLIST, AND TYPE HANDLING
################################################################################

b <- list(c(2, 6, 9, 6), 3, TRUE, NA, mtcars)
b

unlist(b)

a <- list(c(2, 6, 9, 6))
a[[1]]
as.vector(a[[1]])

unlist(c(2, 6, 9, 6))

typeof(b)


################################################################################
# ENVIRONMENT MANAGEMENT
################################################################################

find("a")     # Locate object
rm("a")       # Remove object


################################################################################
# END OF NOTES
################################################################################