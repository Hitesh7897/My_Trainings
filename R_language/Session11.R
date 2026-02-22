#===============================================================================
# Chapter 10: Type Conversion in R (Detailed & Practical)
#===============================================================================
# Topics Covered
# --------------
# 1. Character conversions
# 2. Integer conversions
# 3. Numeric conversions
# 4. Logical conversions
# 5. Factor conversion pitfalls
# 6. Real-world SDTM example using AE domain
#===============================================================================


###############################################
# 1. Character Conversion
###############################################

a <- as.character(100)
a
typeof(a)        # "character"
class(a)         # "character"

a <- as.character(3.14)      # decimal
a
typeof(a)        # "character"
class(a)         # "character"

a <- as.character(5L)        # integer
a
typeof(a)        # "character"
class(a)         # "character"

a <- as.character(TRUE)      # logical
a
typeof(a)        # "character"
class(a)         # "character"

a <- as.character(NULL)      # NULL -> empty character vector
a
typeof(a)        # "character"
class(a)         # "character"
length(a)        # 0

a <- as.character(NA)        # NA -> NA_character_
a
typeof(a)        # "character"
class(a)         # "character"
length(a)        # 1


###############################################
# 2. Integer Conversion
###############################################

a <- as.integer("A")         # invalid -> NA with warning
a
typeof(a)        # "integer"
class(a)         # "integer"

a <- as.integer(33)
a
typeof(a)        # "integer"
class(a)         # "integer"

a <- as.integer(3.6)         # truncation (NOT rounding)
a
typeof(a)        # "integer"
class(a)         # "integer"

a <- as.integer(TRUE)        # TRUE -> 1
a
typeof(a)        # "integer"
class(a)         # "integer"

a <- as.integer(NULL)        # empty integer vector
a
typeof(a)        # "integer"
class(a)         # "integer"
length(a)        # 0

a <- as.integer(NA)          # NA_integer_
a
typeof(a)        # "integer"
class(a)         # "integer"
length(a)        # 1

a <- NA_integer_
typeof(a)        # "integer"
class(a)         # "integer"
length(a)        # 1

# Mixed coercion example
a <- c(1L, 2L, 3L, NA_integer_, TRUE, "A")
a
typeof(a)        # "character" (highest type wins)
class(a)         # "character"


###############################################
# 3. Numeric Conversion
###############################################

a <- as.numeric(TRUE)        # TRUE -> 1
a
typeof(a)        # "double"
class(a)         # "numeric"

a <- as.numeric(4L)
a
typeof(a)        # "double"
class(a)         # "numeric"

a <- as.numeric("Hitesh")    # invalid -> NA
a
typeof(a)        # "double"
class(a)         # "numeric"

a <- as.numeric(NULL)        # empty numeric vector
a
typeof(a)        # "double"
class(a)         # "numeric"
length(a)        # 0


###############################################
# 4. Logical Conversion
###############################################

a <- as.logical(1L)
a
typeof(a)        # "logical"
class(a)         # "logical"

a <- as.logical(33)          # non-zero -> TRUE
a
typeof(a)        # "logical"
class(a)         # "logical"

a <- as.logical("CHAR")      # invalid -> NA
a
typeof(a)        # "logical"
class(a)         # "logical"

a <- c(1, "A", NULL, NA)
a[1]

a <- as.logical(NULL)        # empty logical vector
a
typeof(a)        # "logical"
class(a)         # "logical"
length(a)        # 0

a <- as.logical(NA)          # NA stays NA
a
typeof(a)        # "logical"
class(a)         # "logical"
length(a)        # 1


###############################################
# 5. Factor Conversion (VERY IMPORTANT)
###############################################

f <- factor(c("M", "F", "M", "F", NA, 3L))
f
typeof(f)                   # "integer"
class(f)                    # "factor"

# Factor -> Character (SAFE)
f_char <- as.character(f)
f_char
typeof(f_char)              # "character"
class(f_char)               # "character"

# Factor -> Numeric (WRONG WAY)
f_num_wrong <- as.numeric(f)
f_num_wrong
typeof(f_num_wrong)         # "double"
class(f_num_wrong)          # "numeric"

# Correct way (ALWAYS do this)
f_num_correct <- as.numeric(as.character(f))
f_num_correct
typeof(f_num_correct)       # "double"
class(f_num_correct)        # "numeric"


###############################################
# 6. Real-World Example: SDTM AE Domain
###############################################

library(tidyverse)

# Read AE dataset
AE <- read.csv(
  "https://raw.githubusercontent.com/ganeshbabuNN/datasets/refs/heads/master/clinical_datasets/sdtm/daibetes/csv/ae.csv"
)

AE
str(AE)

# Base R subsetting
AE_1 <- AE[which(AE$AETERM == "PAIN"), ]
AE_1

AE_2 <- AE_1[which(AE_1$AEBODSYS == "CARDIAC DISORDERS"), ]
AE_2

# dplyr (Recommended)
AE_Cardiac <- AE %>%
  filter(AETERM == "PAIN") %>%
  filter(AEBODSYS == "CARDIAC DISORDERS")

AE_Cardiac


###############################################
# Key Takeaways (Interview Level)
###############################################

# - as.integer() truncates; it does NOT round
# - NULL -> empty vector after conversion
# - NA -> typed NA after conversion
# - Character is the highest type in coercion
# - NEVER convert factor directly to numeric
# - ALWAYS use as.numeric(as.character(factor))


###############################################
# END OF FILE
###############################################