#===============================================================================
# Chapter 06: Arrays, Factors, Data Frames & Default Type Constructors
#===============================================================================


###############################################
# 1. ARRAYS IN R
###############################################

# Arrays are multi-dimensional data structures
# All elements must be of the SAME data type
#
# General form:
# array(data, dim = c(d1, d2, d3, ...))


###############################################
# 1D ARRAY (Vector-like)
###############################################

array_1d <- array(1:5, dim = c(5))
array_1d
typeof(array_1d)    # integer
class(array_1d)     # array


###############################################
# 2D ARRAY (Matrix-like)
###############################################

array_2d <- array(1:6, dim = c(3, 2))
array_2d
typeof(array_2d)    # integer
class(array_2d)     # matrix array


###############################################
# 3D ARRAY
###############################################

array_3d <- array(1:18, dim = c(3, 3, 2))
array_3d
typeof(array_3d)    # integer
class(array_3d)     # array

# Accessing individual slices
array_3d[ , , 1]
array_3d[ , , 2]

typeof(array_3d)            # integer
typeof(array_3d[ , , 1])    # integer
class(array_3d)             # array


###############################################
# 4D ARRAY
###############################################

array_4d <- array(1:16, dim = c(2, 2, 2, 2))
array_4d
typeof(array_4d)    # integer
class(array_4d)     # array


###############################################
# 5D ARRAY (Clinical-style example)
###############################################

# Example dimensions:
# Visits x Tests x Subjects x Sites x Countries

array_5d <- array(1:48, dim = c(2, 3, 2, 2, 2))
array_5d
typeof(array_5d)    # integer
class(array_5d)     # array


###############################################
# KEY NOTES ON ARRAYS
###############################################

# - Arrays generalize matrices to n-dimensions
# - Indexing uses commas for each dimension
# - Internally stored as atomic vectors
# - Used heavily in simulations & modeling
# - Less common than data.frames in real-world analytics


###############################################
# 2. FACTORS (CATEGORICAL DATA)
###############################################

c <- c(1, 2, 3, 4, 3, 2, 2, 2, 3, 3, 3)
d <- factor(c)

d
typeof(d)      # integer
class(d)       # factor
levels(d)      # 1 2 3 4


###############################################
# WHY FACTORS MATTER
###############################################

# - Used for categorical variables
# - Required for statistical models
# - Memory-efficient storage
# - Critical in clinical data (SEX, RACE, ARM, AESEV)


###############################################
# 3. DATA FRAMES
###############################################

employee <- data.frame(
  emp_id   = c(1, 2, 3),
  emp_name = c("Hitesh", "Harsha", "Mukesh"),
  emp_age  = c(40, 22, 18)
)

employee
typeof(employee)    # list
class(employee)     # data.frame

str(employee)
# 'data.frame':  3 obs. of  3 variables:
# $ emp_id  : num  1 2 3
# $ emp_name: chr  "Hitesh" "Harsha" "Mukesh"
# $ emp_age : num  40 22 18


###############################################
# 4. TIBBLE (Modern Data Frame)
###############################################

library(tibble)

# A tibble is a modern, enhanced version of a data frame
# designed for the tidyverse. It provides cleaner printing,
# safer defaults, and more consistent behavior.

employee_t <- tibble(
  emp_id   = c(1, 2, 3),
  emp_name = c("gan", "she", "hi"),
  emp_age  = c(40, 22, 18)
)

employee_t
typeof(employee_t)    # list
class(employee_t)     # tbl_df tbl data.frame


###############################################
# DATA FRAME vs TIBBLE
###############################################

# data.frame:
# - Converts strings to factors (older versions)
# - Partial printing
# - Row names allowed
#
# tibble:
# - No string-to-factor conversion
# - Better printing
# - Preferred in tidyverse workflows


###############################################
# 5. DEFAULT VALUE CONSTRUCTORS
###############################################

# Numeric
numeric(2)            # 0 0

# Integer
integer(4)            # 0 0 0 0

# Character
character(4)          # "" "" "" ""

# Complex
complex(4)            # 0+0i 0+0i 0+0i 0+0i

# Raw
raw(1)                # 00

# List
vector("list", 1)

# Factor with empty levels
factor(character(4))

# Date default
as.Date(character(1)) # NA

# POSIXct default (timezone aware)
as.POSIXct(character(1), tz = "IST")
# Error:
# character string is not in a standard unambiguous format


###############################################
# KEY TAKEAWAYS
###############################################

# - Arrays are homogeneous multi-dimensional structures
# - Factors represent categorical variables
# - Data frames store tabular data (most commonly used)
# - Tibbles are modern, safer data frames
# - Default constructors help preallocate memory
# - Preallocation improves performance in loops


###############################################
# END OF FILE
###############################################