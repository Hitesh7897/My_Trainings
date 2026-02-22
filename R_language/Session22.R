#===============================================================================
# Chapter 21: String Regular Expressions in R
#===============================================================================


###############################################
# String Regular Expression – Base R
###############################################

data <- "Order 1 cost $15, Order 2 costs $200, Hitesh needs to give Jyothi $1000"

# Extract all dollar amounts
regmatches(data, gregexpr("\\$[0-9]+", data))


###############################################
# 1. Regex Building Blocks (Special Characters)
###############################################

# .    -> Wildcard (any single character)
# ^    -> Start of string
# $    -> End of string
# []   -> Character class
# [^]  -> Negative character class
# |    -> OR operator

library(tidyverse)

str_extract("Hitesh is sleeping", ".l")
str_detect("Hitesh is sleeping", "^Hi")
str_detect("Hitesh is sleeping", "ng$")
str_detect("AE.sas4dat", "\\.sas4dat$")

str_extract("apple pep", "[piel]")           # first occurrence
str_extract_all("apple pep", "[piel]")       # all occurrences


###############################################
# Quantifiers (How Many?)
###############################################

# ?     -> 0 or 1 time
# *     -> 0 or more times
# +     -> 1 or more times
# {n}   -> Exactly n times
# {n,}  -> At least n times

str_extract("Models mode", "Models?")
str_extract_all("Models mode Model", "Model?")
str_extract_all("Models model", "Mode?")

str_extract("baaaa! baaaaa", "ba*")
str_extract_all("baaaa! baaaaa", "ba*")

str_extract("baaaa! baaaaa", "aa*")
str_extract_all("baaaa! baaaaa", "b*")    # matches empty strings too

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
str_extract("Hello world abcdef", "\\w{6,}")
str_extract("Hello world", "\\w{7}")
str_extract("Hello world", "\\w{3,}")


###############################################
# Uppercase Letter Matching
###############################################

str_extract("ID:USA", "[A-Z]{2,3}")

# [A-Z]  -> uppercase letters
# {2,3}  -> minimum 2, maximum 3 characters

str_extract_all("ID:USAID:", "[A-Z]{2,3}")

# Explanation:
# ID   -> valid (2 letters)
# USA  -> valid (3 letters)
# ID   -> valid again

str_extract_all("RAW:AGENT Ajit", "[A-Z]{2,3}")
# RAW
# AGE
# NT


###############################################
# Character Class Shortcuts
###############################################

# \\d -> Digit (0-9)
# \\D -> Non-digit
# \\w -> Word character
# \\W -> Non-word character
# \\s -> Whitespace
# \\S -> Non-whitespace

str_extract("part 99, part 20", "\\d")
str_extract_all("part 99, part 20", "\\d")

str_extract_all("part 99, part 20", "\\D+")
str_extract_all("part 99, part 20!", "\\w")
str_extract_all("part 99, part 20!", "\\w+")
str_extract_all("part 99, part 20!", "\\W")
str_extract_all("part 99, part 20!", "\\s")
str_extract_all("part 99, part 20!", "\\S+")


###############################################
# Date Pattern Validation
###############################################

data <- c("2023-10-10", "25OCT2025", "2023/26/02", "2026-06-03")

# Extract valid ISO dates (YYYY-MM-DD)
str_extract(data, "^\\d{4}-\\d{2}-\\d{2}$")


###############################################
# Lab Unit Extraction
###############################################

lab_raw <- "150 MG"
str_extract(lab_raw, "[A-Z]+$")


###############################################
# Real-World Clinical Example (SDTM Style)
###############################################

raw_clinical <- data.frame(
  USUBJID = c("SITE01-001", "SITE01-002", "SITE02-005"),
  RAW_LAB = c("  GLUCOSE (mg/dL) ",
              "HEMOGLOBIN (g/dL)",
              "glucose (MG/DL)"),
  RAW_MH  = c("DIABETES TYPE II",
              "hypertension",
              "Asthma - mild")
)

raw_clinical


###############################################
# Standardization using stringr + dplyr
###############################################

raw_clinical %>%
  mutate(
    LBTEST = str_to_upper(
      str_squish(str_extract(RAW_LAB, "^[A-Za-z]+"))
    ),
    LBUNIT = str_extract(RAW_LAB, "(?<=\\().+?(?=\\))")
  )


###############################################
# Whitespace Cleanup
###############################################

a <- "  Hitesh  B G "

paste(a)
paste0(a)

str_squish(a)
str_squish("Kidney   injury   acute")

# Remove ALL spaces (rare, but sometimes required)
str_remove_all("Kidney   injury   acute", "\\s")


###############################################
# Key Takeaways
###############################################

# 1. Regex lets you detect, extract, and validate patterns
# 2. stringr functions are cleaner and safer than base R
# 3. Quantifiers control repetition
# 4. Character classes simplify data cleaning
# 5. Regex is critical for SDTM, ADaM, and clinical text cleanup


#===============================================================================
# END OF FILE
#===============================================================================