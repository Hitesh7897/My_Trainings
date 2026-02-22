#===============================================================================
# Chapter 05: Dates, NULL vs NA, Type Coercion, Strings, Lists & Matrices
#===============================================================================


###############################################
# 1. DATE AND TIME IN R
###############################################

# Character date
dt <- "2025-03-01"
dt
typeof(dt)    # character
class(dt)     # character

# Convert to Date class
dt1 <- as.Date(dt)
dt1
typeof(dt1)   # double
class(dt1)    # Date

# Date-time string without conversion
as.Date("2025-03-11 01:30:50")   # time part is dropped


###############################################
# POSIX DATE-TIME
###############################################

# POSIXct: calendar time (stored as seconds)
dt3 <- as.POSIXct("2025-03-11 01:30:50")
dt3
typeof(dt3)   # double
class(dt3)    # POSIXct POSIXt

# Formatting date-time
format(dt3, "%d-%m-%Y %H:%M:%S")
dt3

# POSIXlt: list-based date-time
dt4 <- as.POSIXlt("2025-03-11 01:30:50")
dt4
typeof(dt4)   # list
class(dt4)    # POSIXlt POSIXt


###############################################
# 2. NULL IN R
###############################################

x <- NULL
x
typeof(x)     # NULL is a special object
class(x)      # NULL

# NULL cannot participate in arithmetic
# x + 1       # Error


###############################################
# 3. NA IN R
###############################################

a <- c(10, 20, 30, NA, 40, NULL, 60)
a

# Important differences
NA == NULL    # logical(0)
NULL == ""    # logical(0)
1 == 1        # TRUE
NA == " "     # logical NA


###############################################
# 4. LOGICAL COMPARISONS
###############################################

TRUE  == FALSE
TRUE  == TRUE
FALSE == FALSE

1 == 0
1 == 1
0 == 1
FALSE == TRUE


###############################################
# 5. CHARACTER (STRING) DATA TYPE
###############################################

s1 <- "my name is Hitesh"
s1
typeof(s1)    # character
class(s1)     # character


###############################################
# 6. VECTOR TYPE COERCION
###############################################

# Character vector
a <- c("Hitesh", "B G", "Harsha", "M")
a
typeof(a)     # character
class(a)      # character

# Numeric vector
a <- c(3, 2, 3, 4, 5)
a
typeof(a)     # double
class(a)      # numeric

# Numeric + character → character
a <- c(3, 2, 3, 4, 5, "a")
a
typeof(a)     # character
class(a)      # character

# Character dominates numeric
a <- c("1", "4", "5", "1", 3)
a
typeof(a)     # character
class(a)      # character

# Character dominates logical
a <- c("1", "4", "5", "1", 3, TRUE)
a
typeof(a)     # character
class(a)      # character


###############################################
# 7. LIST DATA STRUCTURE
###############################################

stu.data <- data.frame(
  id   = c(1, 2),
  name = c("Hitesh", "Harsha")
)

a <- list(
  1,
  "Ganesh",
  TRUE,
  3.3,
  5L,
  0 + 3i,
  as.Date("2025-01-01"),
  NULL,
  NA,
  c(3, 2, 4, 3),
  stu.data
)

a
typeof(a)     # list
class(a)      # list


###############################################
# 8. MATRIX DATA STRUCTURE
###############################################

# Matrix A (2 x 3)
a <- matrix(
  c(1, 2, 3,
    4, 5, 6),
  nrow  = 2,
  ncol  = 3,
  byrow = TRUE
)

a
typeof(a)     # double
class(a)      # matrix array

# Matrix B (3 x 2)
b <- matrix(
  c(7,  8,
    9, 10,
    11, 12),
  nrow  = 3,
  ncol  = 2,
  byrow = TRUE
)

b
typeof(b)     # double
class(b)      # matrix array


###############################################
# 9. MATRIX MULTIPLICATION (DOT PRODUCT)
###############################################

# Rule: (m x n) %*% (n x p) → (m x p)
a %*% b        # Valid matrix multiplication


###############################################
# 10. KEY TAKEAWAYS
###############################################

# - Date, POSIXct, and POSIXlt are different
# - NULL means "no object"
# - NA means "missing value"
# - NULL is removed from vectors automatically
# - Vectors enforce a single data type
# - Lists can hold mixed data types
# - Matrices require dimension compatibility
# - %*% performs matrix multiplication


###############################################
# END OF FILE
###############################################