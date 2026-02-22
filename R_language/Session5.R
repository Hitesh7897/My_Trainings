#===============================================================================
# Chapter 04 : Constants and Core Data Types in R
#===============================================================================


################################################################################
# 1. CONSTANTS IN R
################################################################################

# R does NOT support true constants (like C / Java).
# Convention: Use UPPERCASE names to indicate constant-like variables.

a  <- 10
PI <- 3.142

a
PI


################################################################################
# 2. DATA TYPES OVERVIEW
################################################################################

# Basic atomic data types in R:
# 1) Logical
# 2) Numeric (Double)
# 3) Integer
# 4) Complex
# 5) Character
# 6) Raw


################################################################################
# 3. LOGICAL DATA TYPE
################################################################################

log_1 <- TRUE
log_2 <- FALSE

# Type checking
is.logical(log_1)
is.logical(log_2)

# Storage and class
typeof(log_1)     # "logical"
class(log_1)      # "logical"

# Printing
cat(log_1, log_2, "\n")


################################################################################
# 4. NUMERIC DATA TYPE (DOUBLE)
################################################################################

a <- 232

is.numeric(a)     # TRUE
is.logical(a)     # FALSE
typeof(a)         # "double"
class(a)          # "numeric"

# Decimal numbers are numeric (double by default)
a <- 3.33
typeof(a)         # "double"
class(a)          # "numeric"


################################################################################
# 5. INTEGER DATA TYPE
################################################################################

# Use L suffix to explicitly create an integer
b <- 323L

is.integer(b)     # TRUE
typeof(b)         # "integer"
class(b)          # "integer"

b

# Memory Information:
# Integer  -> 4 bytes (32 bits)
# Numeric  -> 8 bytes (64 bits)
# 1 byte   -> 8 bits
# 32 bits  -> max value ≈ 2^31 - 1

4 * 256

# Integer overflow example:
# (Exceeds 32-bit integer limit)

a <- 3000000000L
# Warning:
# non-integer value qualified with L; using numeric value

typeof(a)         # "double"
class(a)          # "numeric"
a


################################################################################
# 6. COMPLEX DATA TYPE
################################################################################

com <- 3 + 2i

typeof(com)       # "complex"
class(com)        # "complex"


################################################################################
# 7. RAW DATA TYPE
################################################################################

# Raw vectors store bytes in hexadecimal format (00 to FF).
# Mainly used for:
# - Binary files
# - Network protocols
# - Low-level memory operations

myraw <- charToRaw("R is a Super Programming language")

myraw
typeof(myraw)     # "raw"
class(myraw)      # "raw"


################################################################################
# 8. DEFAULT MISSING VALUES (TYPED NA)
################################################################################

# Character NA
a <- NA_character_
typeof(a)         # "character"
class(a)          # "character"

# Complex NA
b <- NA_complex_
typeof(b)         # "complex"
class(b)          # "complex"

# Integer NA
c <- NA_integer_
typeof(c)         # "integer"
class(c)          # "integer"

# Numeric NA
d <- NA_real_
typeof(d)         # "double"
class(d)          # "numeric"

# Blank string (NOT NA)
f <- " "
typeof(f)         # "character"
class(f)          # "character"

# Important:
# NA  ≠  ""
# NA  ≠  " "


################################################################################
# 9. TYPE PRECEDENCE (COERCION HIERARCHY)
################################################################################

# Coercion order (Lowest → Highest):
# logical → integer → numeric → complex → character

# Automatic coercion examples

x <- c(TRUE, 1L, 2.5)
x
typeof(x)         # "double"
class(x)          # "numeric"

x <- c(1, 2 + 3i)
typeof(x)         # "complex"
class(x)          # "complex"

x <- c(1, "text")
typeof(x)         # "character"
class(x)          # "character"


################################################################################
# 10. KEY TAKEAWAYS
################################################################################

# ✔ R does not have true constants (use UPPERCASE convention)
# ✔ Numeric values are double by default
# ✔ Integers require L suffix
# ✔ typeof()  -> shows storage type
# ✔ class()   -> shows conceptual behavior
# ✔ Typed NA  -> preserves data integrity
# ✔ " " is NOT the same as NA
# ✔ Coercion follows a strict hierarchy


################################################################################
# END OF FILE
################################################################################