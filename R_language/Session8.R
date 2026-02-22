#===============================================================================
# Chapter 07: NA, NULL, Coercion Rules, Scalars & Vectors
#===============================================================================

library(tibble)


###############################################
# 1. NA BEHAVIOR IN ARITHMETIC & STRINGS
###############################################

NA + 0          # NA
NA / 2          # NA
NA * 22         # NA

# cat() with NA
cat(NA + "Hitesh")        # produces NA and warning

# paste() with NA
paste(NA, "Hitesh")      # NA Hitesh
paste("b", "ganesh")     # b ganesh


###############################################
# 2. TYPE AND CLASS OF NA
###############################################

x <- NA
typeof(x)       # logical
class(x)        # logical


###############################################
# 3. SCALAR vs VECTOR
###############################################

# Scalar (length-1 vector in R)
x <- 0
x
length(x)

# Vector with mixed values
x <- c(2, "a", "", NULL, NA)
x                   # NULL gets removed
typeof(x)           # character
class(x)            # character
length(x)           # 4

y <- c(2, 3, 4, 5, 5, NA, "", NULL)
y
typeof(y)           # character
class(y)            # character
length(y)           # 7


###############################################
# 4. TYPE COERCION DURING CONVERSION
###############################################

# Converting character + numeric vector to integer
z <- as.integer(y)     # "" becomes NA
z
typeof(z)              # integer
class(z)               # integer

# Character vector with NA and empty string
z <- c("a", "b", "c", NA, "")
z
typeof(z)              # character
class(z)               # character

# Explicit conversion to character
z <- as.character(z)
z
typeof(z)              # character
class(z)               # character


###############################################
# 5. NA TYPES (TYPED MISSING VALUES)
###############################################

# Typed NA values (important in data frames / tibbles)
student_id     <- NA_integer_
student_name   <- NA_character_
student_age    <- NA_integer_
student_height <- NA_real_

student <- tibble(
  student_id,
  student_name,
  student_age,
  student_height
)

student
str(student)


###############################################
# 6. MIXING NA TYPES
###############################################

c(3L, NA_integer_)
c(33, NA_integer_)        # integer coerced to numeric
c("Hitesh", NA_character_)


###############################################
# 7. COMPLEX DEFAULT NA
###############################################

typeof(0 + 0i)    # complex
class(0 + 0i)     # complex


###############################################
# 8. NA IN LOGICAL OPERATIONS
###############################################

x <- c(1, 2, NA)

ifelse(x > 1, "High", NA_character_)
ifelse(x > 1, "High", NA)


###############################################
# 9. NULL vs NA
###############################################

c(NULL, NA)

typeof(NULL)      # NULL
class(NULL)       # NULL


###############################################
# 10. TESTING FOR NA
###############################################

is.na(NA)             # TRUE
is.na(NA_character_)  # TRUE
is.na(NA_integer_)    # TRUE
is.na("")             # FALSE


###############################################
# IMPORTANT CONCEPTS (MUST REMEMBER)
###############################################

# NA:
# - Represents missing value
# - Has a type (logical, integer, real, character, complex)
# - Participates in vector operations
#
# NULL:
# - Represents "no object"
# - Length zero
# - Removed during vector construction
#
# Empty string "":
# - Valid character value
# - NOT missing
# - Length = 1


###############################################
# SUMMARY
###############################################

# - R treats everything as vectors
# - Scalars are length-1 vectors
# - NA propagates through calculations
# - NULL removes elements
# - Typed NA is mandatory for clean data frames
# - Coercion follows strict precedence rules


###############################################
# END OF FILE
###############################################