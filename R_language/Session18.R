#===============================================================================
# Chapter 17: Number Formatting, Floating-Point Precision & String Basics in R
#===============================================================================

###############################################
# Number Formatting – format(), formatC(), sprintf()
###############################################

nums <- c(1.5, 12.345, 100, 3.2)

# Default formatting
format(nums)

# Force at least 2 decimal places
format(nums, nsmall = 2)

# NOTE:
# format() aligns numbers by default (right-justified),
# which can look inconsistent when decimals differ.

# Remove alignment padding
format(nums, nsmall = 2, justify = "none")

# Truncate numbers before formatting
format(trunc(nums), nsmall = 2, justify = "none")

# formatC():
# format = "f" → fixed-point numeric format
formatC(nums, digits = 2, format = "f")

# Width + zero padding
formatC(nums, width = 6, format = "f", digits = 2, flag = "0")

# Single value example
formatC(12.3665, format = "f", digits = 2)

# Show sign explicitly
formatC(c(-1, -2, 2), format = "f", digits = 1, flag = "+")

# sprintf() – most powerful and consistent
sprintf("%.2f", nums)

###############################################
# Floating-Point Comparison Pitfalls
###############################################

3 + 4 == 7
3.5 + 4.5 == 8.0

# Floating-point precision issue
0.1 + 0.2 == 0.3          # FALSE

# Correct way to compare floating-point numbers
all.equal(0.1 + 0.2, 0.3)


###############################################
# Summation with Missing & Special Values
###############################################

sum(c(1, 2, NA, 45), na.rm = TRUE)
sum(c(1, 2, NA, 45, NaN), na.rm = TRUE)
sum(c(1, 2, NA, 45, NaN, NULL), na.rm = TRUE)

# Inf causes sum to be Inf
sum(c(1, 2, NA, 45, NaN, NULL, Inf), na.rm = TRUE)

# Proper filtering before summation
a <- c(1, 2, NA, 45, NaN, NULL, Inf)
sum(a[is.finite(a)], na.rm = TRUE)


###############################################
# String Basics
###############################################

x <- "Hitesh B G"
class(x)

# Create empty vectors
character(3)
numeric(3)
integer(3)

# Quotes inside strings
a <- "Hitesh's script"
a

# length() vs nchar()
length(a)               # Number of elements (always 1 here)
nchar(a)                # Number of characters

# Numeric vs character length
a <- 32423423
length(a)               # Still 1 element
nchar(as.character(a))  # Count digits

###############################################
# Key Interview & Practical Takeaways
###############################################

# 1. format() is for display, NOT for calculations
# 2. formatC() and sprintf() are preferred for reports
# 3. Never compare decimals using ==
#    → Use all.equal()
# 4. Always remove NA, NaN, Inf before aggregation
# 5. length() ≠ nchar()
# 6. Strings in R are always character vectors

###############################################
# END OF FILE
###############################################