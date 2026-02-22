#===============================================================================
# Chapter 11: Missing Values, Date-Time & Coercion Rules in R
#===============================================================================
# Topics Covered
# --------------
# 1. NA, NaN, Inf
# 2. Date & Time Conversions
# 3. Conversion inside Data Structures
# 4. Matrix & List Coercion
# 5. Coercion During Operations
# 6. Type Testing Utilities
# 7. Common Pitfalls (Exam + Interview)
#===============================================================================


###############################################
# 1. Missing Values: NA, NaN, Inf
###############################################

# NA (Missing Value)
x <- NA
x
typeof(x)        # "logical" (default NA type)
class(x)         # "logical"

# NaN (Not a Number)
x <- 0 / 0
x
typeof(x)        # "double"
class(x)         # "numeric"

# Inf (Infinity)
x <- 1 / 0
x
typeof(x)        # "double"
class(x)         # "numeric"


###############################################
# 2. Date & Time Conversions
###############################################

# Character -> Date
a <- "2025-01-16"
a
typeof(a)        # "character"
class(a)         # "character"

a <- as.Date(a)
a
typeof(a)        # "double"
class(a)         # "Date"

# Wrong format (returns NA)
a <- as.Date("2025-01-16", "%d-%m-%Y")
a

# POSIXct (Date + Time, numeric internally)
a <- as.POSIXct("2025-01-16 13:00:36")
a
typeof(a)        # "double"
class(a)         # "POSIXct" "POSIXt"

# POSIXlt (Date + Time, list internally)
a <- as.POSIXlt("2025-01-16 13:00:36")
a
typeof(a)        # "list"
class(a)         # "POSIXlt" "POSIXt"


###############################################
# 3. Conversion Inside Data Structures
###############################################

df <- data.frame(
  id   = c("1", "2", "3"),
  age  = c("23", "19", "30"),
  stringsAsFactors = FALSE
)

df
str(df)

# Column-wise conversion (CORRECT)
df$id  <- as.numeric(df$id)
df$age <- as.numeric(df$age)
str(df)

# WRONG (Do NOT do this)
# df <- as.numeric(df)   # destroys data frame structure


###############################################
# 4. Matrix & List Coercion
###############################################

# Matrix: must have ONE data type
m <- matrix(c(1, TRUE, 3), nrow = 3, ncol = 2)
m

m[1, 1]
m[2, 1]
m[3, 1]

typeof(m[3, 1])   # "double"
typeof(m)         # "double"
class(m)          # "matrix" "array"

# List: can store mixed types
ls <- list(m)
typeof(ls)        # "list"
class(ls)         # "list"


###############################################
# 5. Coercion During Operations
###############################################

# Coercion hierarchy:
# logical --> integer --> numeric --> character

## A. Logical -> Numeric
a <- TRUE + 5L
a
typeof(a)        # "integer"
class(a)         # "integer"

sum(c(TRUE, FALSE, TRUE))    # count of TRUE values
TRUE + TRUE                  # 2

## B. Numeric -> Logical
as.logical(0)                # FALSE
as.logical(233)              # TRUE


###############################################
# 6. Type Testing Utilities
###############################################

# Used heavily in validation & debugging
class()          # conceptual class
typeof()         # internal storage
is.numeric()     # numeric check
is.character()   # character check
is.factor()      # factor check
str()            # structure (MOST IMPORTANT)


###############################################
# 7. Factor Conversion Pitfalls (CRITICAL)
###############################################

f <- factor(c("10", "20"))
f

# WRONG (returns level codes)
as.numeric(f)

# CORRECT
as.numeric(as.character(f))


###############################################
# 8. Logical Misinterpretation
###############################################

as.logical("Yes")     # NA
as.logical("TRUE")    # TRUE
as.logical("FALSE")   # FALSE


###############################################
# 9. Character String Example
###############################################

a <- "this isn't a value"
a
typeof(a)        # "character"
class(a)         # "character"


###############################################
# Key Exam & Interview Takeaways
###############################################

# NA        -> Missing value (typed)
# NaN       -> Invalid numeric result
# Inf       -> Infinite numeric value
# NULL      -> No object (length 0)
# Date      -> Stored as double (days since 1970)
# POSIXct   -> Numeric datetime (fast, recommended)
# POSIXlt   -> List datetime (easy extraction)
# Matrix    -> Single data type only
# List      -> Mixed types allowed
# Factor    -> NEVER convert directly to numeric


###############################################
# END OF FILE
###############################################