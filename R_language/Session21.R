#===============================================================================
# Chapter 20: Strings – Escape Characters & Regular Expressions in R
#===============================================================================


###############################################
# Accessing String Elements
###############################################

substr("Hitesh Bangalore Gopinatha", 4, 7)
substring("Hitesh Bangalore Gopinatha", 4, 7)

typeof(letters)          # "character"
letters[4:6]
letters[c(5, 7, 9)]


###############################################
# Escape Characters (Escape Sequences)
###############################################

cat("My name is Hitesh B G. Work experience 6+ years of experience.")

# Escaping single quote
cat('My name is Hitesh B G. Work experience\'s 6+ years.')

# Escaping double quote
cat("My name is Hitesh B G. Work experience\"s 6+ years.")

# Quoted sentence
cat("My name is Hitesh B G. \"Work experience 6+ years\" and looking for job.")

# New line
cat("My name is Hitesh B G.\nWork experience 6+ years.\nLooking for job.")

# Tab spacing
cat("Jyothi\tHitesh\tGanesh\tSwati\n")

# Backspace (console dependent)
cat("        \b\b\b\b\b\b\bHitesh B G\n")

# Carriage return (progress overwrite)
cat("Loading... 0%\r")
cat("Loading... 100%\n")

# Backslash handling (Windows vs Linux)
cat("File location: C:\\hitesh\\Documents\n")
cat("File location: C:/hitesh/Documents\n")


###############################################
# Escape Character Reference
###############################################

# \'  → Single quote
# \"  → Double quote
# \n  → New line
# \t  → Tab
# \b  → Backspace
# \r  → Carriage return
# \\  → Literal backslash


###############################################
# Regular Expressions – Base R
###############################################

data <- "Order 1 cost $15, Order 2 costs $200, Hitesh owes Jyothi $1000"

# Extract all dollar amounts
regmatches(data, gregexpr("\\$[0-9]+", data))


###############################################
# Regular Expressions – stringr (Recommended)
###############################################

library(stringr)
library(tidyverse)


###############################################
# Special Characters (Regex Building Blocks)
###############################################

# .    → Any single character
# ^    → Start of string
# $    → End of string
# []   → Character class
# [^]  → Negative character class
# |    → OR

str_extract("Hitesh is sleeping", ".s")
str_detect("Hitesh is sleeping", "^Hi")
str_detect("Hitesh is sleeping", "ng$")
str_detect("AE.sas4dat", "\\.sas4dat$")

str_extract("apple pep", "[aeiou]")
str_extract_all("apple pep", "[pl]")


###############################################
# Quantifiers (How Many?)
###############################################

# ?     → 0 or 1
# *     → 0 or more
# +     → 1 or more
# {n}   → Exactly n
# {n,}  → At least n

str_extract("Models mode", "Models?")
str_extract_all("Models model", "Mode?")
str_extract("baaaa! baaaaa", "ba*")
str_extract("baaaa! baaaaa", "aa*")
str_extract_all("baaaa! baaaaa", "b*")   # matches empty strings too

nchar("baaaa! baaaaa")


###############################################
# Digit Extraction
###############################################

str_extract("Room 402", "\\d+")
str_extract_all("Room 402 Room 503", "\\d+")

str_extract("FY2024 16 02", "\\d{4}")
str_extract_all("FY2024 16 0226", "\\d{4}")


###############################################
# Word Characters
###############################################

str_extract("Hello world", "\\w{5,}")
str_extract("Hello world", "\\w{5}")
str_extract("Hello world", "\\w{3,}")


###############################################
# Uppercase Letter Matching
###############################################

str_extract("ID:USA", "[A-Z]{2,3}")
str_extract_all("ID:USAID:", "[A-Z]{2,3}")

# Explanation:
# 1) "ID"  → matches 2 uppercase letters
# 2) "USA" → matches exactly 3 uppercase letters
# 3) "ID"  → matches again


###############################################
# Practical Clinical / Real-World Use Case
###############################################

raw_text <- c(
  "SUBJ01_VISIT1",
  "SUBJ02_VISIT10",
  "SUBJ03_VISIT2"
)

# Extract subject ID
str_extract(raw_text, "^SUBJ\\d+")

# Extract visit number
as.numeric(str_extract(raw_text, "\\d+$"))


###############################################
# Key Takeaways
###############################################

# 1. Escape characters control special output behavior
# 2. Regex allows pattern-based searching & extraction
# 3. stringr functions are safer and more readable
# 4. Quantifiers define repetition rules
# 5. Regex is essential for SDTM, ADaM, and text cleaning


#===============================================================================
# END OF FILE
#===============================================================================