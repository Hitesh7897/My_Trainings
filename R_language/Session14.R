#===============================================================================
# Chapter 13: Subsetting, Logical Helpers & Bitwise Operators in R
#===============================================================================
# References (Practice & Learning)
# --------------------------------
# https://leetcode.com/problem-list/design/
# https://www.kaggle.com/competitions
# https://github.com/ganeshbabuNN/MyNotes/tree/master/Logical_Programming
#===============================================================================


#===============================================================================
# Topics Covered
#===============================================================================
# 1. Subsetting Operators
# 2. Tidyverse Logical Helpers
# 3. Bitwise Operators
# 4. Operator Precedence & Associativity
#===============================================================================


###############################################
# 1. Subsetting Operators
###############################################

# []   → Extract multiple elements
# [[]] → Extract a single element (no list wrapping)
# $    → Access named element (mainly for data frames & lists)


#-----------------------
# Vector Subsetting
#-----------------------

a <- c(3,4,2,3,54,5,45,32,432,423,423,423,423,423,423,
       42,342,342,34,45,543,32454,43,454,45,454,545)

a

a[5]            # single element (still a vector)
a[[5]]          # single element (pure value)
a[c(1, 4)]      # multiple elements
a[3:5]          # slicing / range
a[-5]           # exclude index 5
a[a > 100]      # logical subsetting


#-----------------------
# List Subsetting
#-----------------------

lst <- list(1, "Hitesh", TRUE, c(3,2,4,3), mtcars)
lst

lst[[2]]              # character element
lst[[4]][2]           # vector inside list
lst[[5]][3, ]         # row from mtcars
lst[[5]]$disp         # column access
(lst[[5]]$disp)       # explicit printing


#-----------------------
# Data Frame Subsetting
#-----------------------

data(sleep)
class(sleep)          # "data.frame"

sleep$ID
sleep$extra

mtcars$hp
mtcars[c(1, 2)]               # column 1 & 2
mtcars[mtcars$mpg > 25, ]     # row filtering


###############################################
# 2. Tidyverse Logical Helpers
###############################################

library(tidyverse)

# Sample dataset
student_data <- tibble(
  student_id     = 1:6,
  student_name   = c("A", "B", "C", "D", "E", "F"),
  student_age    = c(28, 32, 35, 29, 40, 34),
  student_class  = c("MCA", NA, "BCA", "MCA", NA, "MSC"),
  student_gender = c("M", "F", "M", "F", "M", "F")
)

student_data


# between()
student_data %>%
  filter(between(student_age, 30, 35))

# is.na()
student_data %>%
  filter(is.na(student_class))

# !is.na()
student_data %>%
  filter(!is.na(student_gender))

# if_any() → any selected column satisfies condition
student_data %>%
  filter(if_any(where(is.numeric), ~ .x > 35))

# if_all() → all selected columns satisfy condition
student_data %>%
  filter(if_all(where(is.numeric), ~ .x > 20))


###############################################
# 3. Bitwise Operators
###############################################

# Bitwise AND
bitwAnd(5, 3)      # 101 & 011 = 001 → 1

# Bitwise OR
bitwOr(6, 3)       # 110 | 011 = 111 → 7

# Bitwise XOR
bitwXor(3, 4)      # 011 ^ 100 = 111 → 7

# Bitwise NOT
bitwNot(5)

# Bitwise Shifts
bitwShiftL(2, 1)   # left shift
bitwShiftR(8, 1)   # right shift


###############################################
# 4. Operator Precedence & Associativity
###############################################

# Operator Precedence (High → Low)
# --------------------------------
# ()        Parentheses
# ^         Exponentiation (Right-to-Left)
# + -       Unary operators
# * / %%    Multiplication / Division / Modulus
# + -       Addition / Subtraction
# :         Sequence
# < <= >    Relational
# == !=
# !         Logical NOT
# &         Logical AND (vectorized)
# |         Logical OR
# && ||     Short-circuit logical
# <- -> =   Assignment (Right-to-Left)
# ~         Formula


#-----------------------
# Arithmetic Precedence
#-----------------------

3 + 2 * 3
3 + (2 * 3)

10 - 4 - 2
(10 - 4) - 2

10 / 2 / 3
(10 / 2) / 3


#-----------------------
# Logical Precedence
#-----------------------

TRUE & FALSE & TRUE | TRUE
(TRUE & FALSE) & TRUE | TRUE
(FALSE & TRUE) | TRUE
FALSE | TRUE


#-----------------------
# Relational + Logical
#-----------------------

5 > 3 & 2 < 1
(5 > 3) & (2 < 1)

5 > (3 & 2) < 1   # avoid writing like this (confusing)


###############################################
# Real-World Mapping
###############################################

# Arithmetic → Banking, Finance, Payroll
# Logical    → Eligibility rules, validation checks
# %in%       → Category filters (marketing, reporting)
# Pipes      → Data pipelines (ETL, SDTM/ADaM flows)
# Subsetting → Reporting, analysis, row/column selection


###############################################
# Interview Takeaways
###############################################

# 1. [] always returns same type (vector/list/data frame)
# 2. [[ ]] extracts the actual element
# 3. $ works only for named elements
# 4. & vs && → vectorized vs short-circuit
# 5. Parentheses remove ambiguity
# 6. Bitwise operators are low-level but powerful


###############################################
# END OF FILE
###############################################