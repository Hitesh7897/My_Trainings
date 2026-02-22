#===============================================================================
# Chapter 31: Functions in R – Return Values, Overriding & Scope (LEGB)
#===============================================================================


###############################################
# 1. Returning Multiple Values from a Function
###############################################
# R functions can return ONLY ONE object.
# To return multiple values, use a container (list, vector, data frame).

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
# 2. Function Overloading vs Overriding in R
###############################################

# IMPORTANT CONCEPT:
# ❌ R does NOT support function overloading (like Java/C++)
# ✅ R supports function overriding

# Function overriding:
# A new function with the SAME name replaces the old one


###############################################
# Example 1: Function Overriding
###############################################

add <- function(a, b) {
  print("hello")
  return(a + b)
}

add <- function(b, c) {
  print("hello1")
  return(b + c)
}

add(2, 3)
# Output:
# "hello1"
# 5

# The FIRST definition is completely overwritten


###############################################
# Example 2: Overriding with Different Arguments
###############################################

add <- function(a, b) {
  print("hello")
  return(a + b)
}

add <- function(b, c, d) {
  print("hello1")
  return(b + c + d)
}

# add(4, 3)  # ERROR: missing argument 'd'
add(4, 3, 2)


###############################################
# Key Rule
###############################################
# R selects functions ONLY by name, NOT by signature
# Last definition wins


###############################################
# 3. Scope in R – LEGB Rule
###############################################

# LEGB stands for:
# L → Local
# E → Enclosing
# G → Global
# B → Built-in


###############################################
# Nested Functions & Scope Resolution
###############################################

x <- "I am Global"
pi <- 100  # Overriding built-in pi in global scope

outer_func <- function() {      # Enclosing / Parent function
  x <- "I am Enclosing"
  
  cat("\nParent function x:\n", x)
  
  x <<- "ganesh" 
  
  inner_func <- function() {    # Local / Child function
    cat("\nChild function x (before update):\n", x)
    
   # x <<- "ganesh"               # Modifies global x
    cat("\nChild function x (after global update):\n", x)
    
    local_val <- "I am Local"
    print(x)                     # Enclosing / global (after <<-)
    print(pi)                    # Global (built-in overridden)
  }
  
  inner_func()
  cat("\nParent function x after inner call:\n", x)
}

print(x)        # Global before function call
outer_func()
print(x)        # Global after function call


###############################################
# 4. Global Assignment Using <<-
###############################################

x <- 20

hitesh <- function() {
  x <- 10           # Local x
  print(x)
  
  x <<- 100         # Modify global x
}

hitesh()
print(x)


###############################################
# Key Interview Takeaways
###############################################

# 1. R does NOT support function overloading
# 2. R supports function overriding (last definition wins)
# 3. return() can return only ONE object
# 4. Use list() to return multiple values
# 5. Scope follows LEGB rule
# 6. <<- modifies variables in parent/global scope
# 7. Avoid <<- in production code
# 8. Built-in functions can be overridden (but risky)


###############################################
# END OF FILE
###############################################