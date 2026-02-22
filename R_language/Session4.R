#===============================================================================
# Chapter 03: Variables, Assignment Operators, Naming Rules & Scope in R
#===============================================================================

###############################################
# 1. ASSIGNING VALUES TO VARIABLES
###############################################

# Assignment using leftward operator <-
x <- 3
x

# Assignment using equal operator =
x = 4
x

# NOTE:
# <- is preferred in R programming (best practice)
# = is also allowed but used less often

###############################################
# 2. VECTORS AND ASSIGNMENT
###############################################

# Assigning multiple values (vector)
x <- c(3, 3, 4, "Hitesh")
x

###############################################
# 3. RIGHTWARD ASSIGNMENT OPERATOR
###############################################

# Rightward assignment operator ->
c(3, 2, 4) -> b
b

# Equivalent leftward assignment
b <- c(3, 2, 5)
b

###############################################
# 4. MULTIPLE ASSIGNMENT
###############################################

# Assign same value to multiple variables
x = y = z = 5
x
y
z

# ❌ NOT allowed in R (compile-time error)
# x, y, z = 5, 3, 4

###############################################
# 5. VARIABLE NAMING RULES
###############################################

# Valid variable names
b_a <- 4
b.a <- 4
b4a <- 4
ba_ <- 4
.ba <- 4

# Invalid variable names (DO NOT RUN)
# b%a <- 4     # % not allowed
# ba% <- 4     # % not allowed
# .2ba <- 4    # dot followed by number not allowed
# _v_name <- 3 # cannot start with underscore

###############################################
# 6. NAMING CONVENTIONS (BEST PRACTICES)
###############################################

# Camel case (recommended)
myVariable <- 3

# Snake case (also common)
my_variable <- 4

###############################################
# 7. GLOBAL AND LOCAL VARIABLES (SCOPE)
###############################################

# Global variable
b <- 10

# Function definition
display <- function() {
  a <- 10          # Local variable
  print(a)         # Accessible inside function
  print(b)         # Global variable accessible inside function
}

# ❌ Local variable not accessible outside function
# print(a)   # This will cause an error if uncommented

# Call function
display()

###############################################
# 8. KEY TAKEAWAYS
###############################################

# - <- is the preferred assignment operator in R
# - Variables can store any R object
# - Vector assignment uses c()
# - Rightward assignment exists but is rarely used
# - Variable names must follow R naming rules
# - Local variables exist only inside functions
# - Global variables are accessible everywhere

###############################################
# END OF FILE
###############################################