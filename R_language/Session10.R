#===============================================================================
# Chapter 09: Type Conversion in R
#===============================================================================
# Topics Covered
# --------------
# 1. Type hierarchy in R
# 2. Implicit type conversion (Coercion)
# 3. Explicit type conversion (Type casting)
# 4. Behavior of NULL vs NA during conversion
# 5. Practical rules and interview notes
#===============================================================================


###############################################
# 1. Type Hierarchy in R
###############################################

# R follows a strict coercion hierarchy when mixing data types

# Lowest to Highest:
# logical --> integer --> numeric(double) --> complex --> character
#
# NULL is outside the hierarchy (it represents "nothing")


###############################################
# 2. Implicit Type Conversion (Coercion)
###############################################

# NA without suffix
x <- NA
typeof(x)     # "logical"
class(x)      # "logical"

# Mixing multiple types forces coercion to the highest type
x <- c(TRUE, 10, 3.5, 6, "A")
x
typeof(x)     # "character"
class(x)      # "character"

x <- c(TRUE, 10, 3.5, 6)
x
typeof(x)     # "double"
class(x)      # "numeric"

x <- c(TRUE, 10, 3.5, 6, 4L)
x
typeof(x)     # "double"
class(x)      # "numeric"


###############################################
# Logical to Numeric
###############################################

x <- TRUE + 4
x                   # 5
typeof(x)           # "double"
class(x)            # "numeric"


###############################################
# Integer to Numeric
###############################################

x <- 1L + 3
x
typeof(x)           # "double"
class(x)            # "numeric"


###############################################
# Logical to Integer (via coercion)
###############################################

x <- c(TRUE, FALSE, 5L)
x
typeof(x)           # "integer"
class(x)            # "integer"


###############################################
# Integer to Numeric
###############################################

x <- (1L + 2)
x
typeof(x)           # "double"
class(x)            # "numeric"


###############################################
# Numeric to Character
###############################################

x <- c(10.5, "hello")
x
typeof(x)           # "character"
class(x)            # "character"


###############################################
# 3. Explicit Type Conversion (Type Casting)
###############################################

# Character to Numeric
x <- "10.5"
typeof(x)           # "character"
class(x)            # "character"

x <- as.numeric(x)
x
typeof(x)           # "double"
class(x)            # "numeric"

# Invalid numeric conversion
y <- "Apple"
as.numeric(y)       # NA with warning: NAs introduced by coercion


###############################################
# Numeric to Integer
###############################################

z <- 10.9
typeof(z)           # "double"
class(z)            # "numeric"

z <- as.integer(z)  # truncates (does NOT round)
z
typeof(z)           # "integer"
class(z)            # "integer"


###############################################
# Integer to Logical
###############################################

z <- 1L
typeof(z)           # "integer"
class(z)            # "integer"

z <- as.logical(z)
z                   # TRUE
typeof(z)           # "logical"
class(z)            # "logical"

z <- 0L
z <- as.logical(z)
z                   # FALSE
typeof(z)           # "logical"
class(z)            # "logical"


###############################################
# Numeric to Logical
###############################################

z <- 3
z <- as.logical(z)
z                   # TRUE

z <- -32
z <- as.logical(z)
z                   # TRUE

# Rule:
# 0        -> FALSE
# Non-zero -> TRUE


###############################################
# 4. Conversion Behavior: NULL vs NA
###############################################

# NULL
z <- NULL
z
typeof(z)           # "NULL"
class(z)            # "NULL"

z <- as.logical(z)
z                   # logical(0)

# Explanation:
# - NULL has no value and no length
# - Conversion returns an empty vector

length(NULL)        # 0


###############################################
# NA
###############################################

z <- NA
z
typeof(z)           # "logical"
class(z)            # "logical"

z <- as.logical(z)
z                   # NA

# NA is already a logical missing value


###############################################
# Character Conversion
###############################################

z <- as.character(NULL)
z
typeof(z)           # "character"
class(z)            # "character"
length(z)           # 0

z <- as.character(NA)
z
typeof(z)           # "character"
class(z)            # "character"
length(z)           # 1


###############################################
# Integer Conversion
###############################################

z <- as.integer(NULL)
z
typeof(z)           # "integer"
class(z)            # "integer"
length(z)           # 0

z <- as.integer(NA)
z
typeof(z)           # "integer"
class(z)            # "integer"
length(z)           # 1


###############################################
# Numeric Conversion
###############################################

z <- as.numeric(NULL)
z
typeof(z)           # "double"
class(z)            # "numeric"
length(z)           # 0

z <- as.numeric(NA)
z
typeof(z)           # "double"
class(z)            # "numeric"
length(z)           # 1


###############################################
# 5. Summary Rules (IMPORTANT)
###############################################

# Implicit conversion happens automatically
# Explicit conversion uses as.*() functions

# NULL:
# - Represents "nothing"
# - Length = 0
# - Converts to empty vector of target type

# NA:
# - Represents "missing value"
# - Length = 1
# - Retains missingness across conversions


###############################################
# Interview One-Liners
###############################################

# TRUE  -> 1
# FALSE -> 0
# Non-zero numeric -> TRUE
# 0 -> FALSE
# as.integer() truncates (does NOT round)
# Character coercion is final in the hierarchy
# NULL is not a value; NA is a missing value


###############################################
# END OF FILE
###############################################