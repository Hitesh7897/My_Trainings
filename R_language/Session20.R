#===============================================================================
# Chapter 19: sprintf() – Professional String Formatting in R
#===============================================================================


###############################################
# Why sprintf()?
###############################################

paste("Score:", 9.45687)
sprintf("Score: %.2f", 9.45687)

# Syntax:
# sprintf("format string", value1, value2, ...)


###############################################
# Basic Format Specifiers
###############################################

# %s      → String
# %d / %i → Integer
# %f      → Decimal (float)
# %.2f    → 2 decimal places
# %05d    → Pad with zeros
# %e      → Scientific notation
# %E      → Upper-case scientific notation
# %g      → Compact format (auto)
# %%      → Literal percent sign


###############################################
# Multiple Values (Vectorized Behavior)
###############################################

sprintf("Score: %.2f and %.2f",
        9.45687,
        c(3, 2, 34))

# NOTE:
# sprintf() is vectorized.
# Shorter arguments are recycled automatically.


###############################################
# String Formatting
###############################################

paste0("Hello ", "Hitesh")
sprintf("Hello %s", "Hitesh")

name  <- "Hitesh"
score <- 89.36

sprintf("Student %s scored %.2f marks", name, score)


###############################################
# Integer Formatting
###############################################

sprintf("Money $%d", 2500)
sprintf("Money $%i", 2500)

sprintf("%5d", 82)      # width = 5 (space padded)
sprintf("%05d", 82)     # zero padded


###############################################
# Decimal Formatting
###############################################

sprintf("Score: %f", 1.2)        # default 6 decimals
sprintf("Score: %.3f", 1.2)      # 3 decimals
sprintf("Score: %.0f", 1.2)      # round to 0 decimals
sprintf("Score: %+.0f", 1.2)     # show + sign

sprintf("Score: $%.2f", 1.2)     # currency style
sprintf("Score: %.2f%%", 1.2)    # percent symbol


###############################################
# Scientific & Compact Notation
###############################################

sprintf("%e", 82.235697)
sprintf("%E", 82.235697)

# %g / %G:
# - Automatically chooses fixed or scientific notation
# - Removes unnecessary trailing zeros
# - Shows decimal point only when needed

sprintf("%g", 82.235697)
sprintf("%.4g", 82.235697)


###############################################
# String Width & Alignment
###############################################

sprintf("%s", "Hitesh B G")
sprintf("%.5s", "Hitesh B G")     # first 5 characters

sprintf("%-10s", "Hitesh")        # left aligned
sprintf("%10s", "Hitesh")         # right aligned


###############################################
# Accessing String Elements
###############################################

x <- "Learn R programming"

substr(x, 8)              # from position 8 to end
substr(x, 8, 12)          # from position 8 to 12

# substring() alternative
substring(x, 8, 12)


###############################################
# Internal Inspection (Advanced)
###############################################

x <- 10L      # integer
y <- 10       # numeric (double)

typeof(x)
typeof(y)

# Inspect memory representation (advanced)
.Internal(inspect(x))
.Internal(inspect(y))


###############################################
# Key Takeaways
###############################################

# 1. paste()   → simple joining
# 2. paste0()  → join without space
# 3. sprintf() → professional formatting
# 4. %f        → decimals
# 5. %d / %i   → integers
# 6. %%        → literal percent
# 7. sprintf() is vectorized by default


#===============================================================================
# END OF FILE
#===============================================================================