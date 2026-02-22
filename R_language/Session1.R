#===============================================================================
# Chapter 01 : Everything Is an Object in R
#===============================================================================


################################################################################
# 1. EVERYTHING IN R IS AN OBJECT
################################################################################

# Create objects
x    <- 3                  # numeric object
name <- "Hitesh"           # character object
v    <- c(1, 2, 3)         # vector object

# Objects live in memory
# Every object has:
# 1. type        -> how it is stored internally
# 2. class       -> how R interprets and behaves with it
# 3. attributes  -> metadata (dimensions, names, etc.)

typeof(x)         # "double"
class(x)          # "numeric"
attributes(x)     # NULL

typeof(name)      # "character"
class(name)       # "character"
attributes(name)  # NULL

typeof(v)         # "double"
class(v)          # "numeric"
attributes(v)     # NULL


################################################################################
# 2. DATA STRUCTURES IN R
################################################################################
# Vector, Matrix, List, Data Frame, Factor


########################################
# Scalar vs Vector
########################################

# Scalar = single value
# Vector = multiple values of same type

# Scalar
a <- 3
typeof(a)        # double
class(a)         # numeric
attributes(a)    # NULL

# Vector
b <- c(3, 4, 5, 6)      # c() = combine
print(b)

typeof(b)        # double
class(b)         # numeric
attributes(b)    # NULL
is.vector(b)     # TRUE


########################################
# Type Coercion Inside Vectors
########################################

b <- c(3, 4, 5, 6, "numeric")
b

typeof(b)        # character
class(b)         # character
attributes(b)    # NULL


################################################################################
# MATRIX
################################################################################

# Matrix is a 2D vector of the same data type
m <- matrix(1:6, nrow = 2)
m

typeof(m)        # integer
class(m)         # matrix array
attributes(m)    # $dim = c(2, 3)

# Note:
# A matrix has no independent type.
# Its type comes from the underlying vector.


################################################################################
# LIST
################################################################################

# List can store objects of different types
lst <- list(1, "Harsha", c(1, 3, "Hitesh"))
lst

typeof(lst)      # list
class(lst)       # list
attributes(lst)  # NULL


################################################################################
# DATA FRAME
################################################################################

# Comparable to:
# SQL table / SAS dataset / Excel worksheet

student <- data.frame(
  student_id   = c(1, 2),
  student_name = c("Hitesh", "Harsha"),
  student_age  = c(28, 30)
)

student

typeof(student)  # list
class(student)   # data.frame
attributes(student)

# Key Point:
# A data frame is a list with special attributes that allow tabular behavior.


################################################################################
# FACTOR (CATEGORICAL DATA)
################################################################################

f <- factor(c("M", "F", "M"))
f

typeof(f)        # integer
class(f)         # factor
levels(f)
attributes(f)

# Internal Representation:
# - Stored as integers
# - Levels attribute maps integers to labels
#
# Benefits:
# - Memory efficient
# - Faster statistical modeling
# - Historical S language design


################################################################################
# 3. typeof() vs class()
################################################################################

# typeof() -> low-level storage (machine-level)
# class()  -> high-level behavior (semantic meaning)

x <- 10
typeof(x)        # double
class(x)         # numeric

y <- "hello"
typeof(y)        # character

z <- TRUE
typeof(z)        # logical

typeof(list(1, "a"))  # list

# Date example
d <- as.Date("2025-01-01")
typeof(d)        # double
class(d)         # Date

class(student)   # data.frame

# Summary:
# typeof() -> how R stores the object
# class()  -> how R treats the object


################################################################################
# 4. FUNCTIONS (LOGIC BUILDING BLOCKS)
################################################################################

# Built-in functions
typeof(x)
data.frame()     # empty data frame

# User-defined function
add <- function(a, b) {
  a + b
}

add(3, 4)
add(b = 2, a = 6)

# Built-in examples
mean(c(1, 2, 3, 4))
summary(student)

# Operators are also functions
`+`(2, 3)
`*`(4, 5)


################################################################################
# 5. OBJECT-ORIENTED PROGRAMMING IN R
################################################################################

# R supports multiple OOP systems:
# 1. S3
# 2. S4
# 3. R6


########################################
# S3 OBJECTS
########################################

person <- list(name = "Ganesh", age = 46)
class(person) <- "person"

print.person <- function(x) {
  cat("Name:", x$name, "Age:", x$age, "\n")
}

print(person)


########################################
# S4 OBJECTS
########################################

setClass(
  "Person",
  slots = list(
    name = "character",
    age  = "numeric"
  )
)

p <- new("Person", name = "John", age = 30)

setMethod(
  "show",
  "Person",
  function(object) {
    cat("Name:", object@name, "Age:", object@age, "\n")
  }
)

show(p)


########################################
# R6 OBJECTS (Modern OOP)
########################################

library(R6)

Person <- R6Class(
  "Person",
  public = list(
    name = NULL,
    age  = NULL,
    
    initialize = function(name, age) {
      self$name <- name
      self$age  <- age
    },
    
    greet = function() {
      cat("Hello,", self$name, "- Age:", self$age, "\n")
    }
  )
)

p1 <- Person$new("Swetha", 28)
p1$greet()


################################################################################
# 6. COMPILER VS INTERPRETER (CONCEPT)
################################################################################

# R first parses code (syntax check)
# Then evaluates line-by-line

print("hello")

# Case-sensitive (will error if uncommented)
# prinT()


################################################################################
# 7. KEYWORDS
################################################################################

TRUE
FALSE
NULL
NA


################################################################################
# 8. FUNCTIONS ARE OBJECTS
################################################################################

a <- function() {
  print("hello")
}

a()


################################################################################
# 9. LITERALS & EXPRESSIONS
################################################################################

3 + 3      # numeric expression
"a"        # character literal
TRUE       # logical literal


################################################################################
# 10. OPERATORS & EXPRESSIONS
################################################################################

3 + 3
5 * 2
`-`(10, 4)


################################################################################
# END OF CHAPTER
################################################################################

# Key Takeaways:
# - Numbers are objects
# - Strings are objects
# - Functions are objects
# - Operators are functions
# - Models are objects
# In R, EVERYTHING is an object with a type and a class