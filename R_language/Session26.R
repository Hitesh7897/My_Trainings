#===============================================================================
# Chapter 25: String Functions in R (Base R + stringr)
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(stringr)
library(tidyverse)


################################################################################
# BASIC STRING CREATION
################################################################################

x <- "Hitesh"
a <- character(3)

is.character(x)


################################################################################
# LENGTH & BASIC INSPECTION
################################################################################

x <- c("R", "python", "julia")

length(x)        # Number of elements in the vector
nchar(x)         # Number of characters in each string

str_length(x)
str_length("Hitesh")


################################################################################
# COMBINING & FORMATTING STRINGS
################################################################################

paste("Hitesh", "B G")
paste("AE", ".sas4bat")
paste("Hitesh", "B G", sep = "-")
paste("Hitesh", "B G")

paste0("Hitesh", "B G")
paste0("AE", ".sas4bat")


################################################################################
# CONCATENATION + FORMATTING (REAL WORLD)
################################################################################

name   <- "Hitesh"
salary <- 2000
age    <- 30

sprintf(
  "Name: %s of age %d earning salary of: %.2f",
  name, age, salary
)

# stringr style (recommended)
str_glue("Name {name} of age {age} earning salary as {salary}")


################################################################################
# CASE CONVERSION
################################################################################

toupper("hitesh")
tolower("HITESH")

# stringr equivalents
str_to_upper("hitesh")            # "HITESH"
str_to_lower("HITESH B G")        # "hitesh b g"
str_to_title("HITESH B G")        # "Hitesh B G"
str_to_camel("HITESH B G")        # "hiteshBG"
str_to_sentence("HITESH B G")     # "Hitesh b g"
str_to_snake("HITESH B G")        # "hitesh_b_g"
str_to_kebab("HITESH B G")        # "hitesh-b-g"


################################################################################
# TRIMMING & PADDING
################################################################################

trimws("     Hitesh   B G    ")
strrep("=", 80)

x <- " trailingspace,   middle   , and leading space   "

str_trim(x)                       # trim both ends
str_trim(x, side = "left")        # left trim
str_trim(x, side = "both")        # explicit both
str_squish(x)                     # collapse internal spaces


################################################################################
# SUBSTRING & EXTRACTION
################################################################################

substr("Hitesh", 3, 5)

substring("DataScience", 1, 4)
substring("DataScience", 5, 11)
substring("DataScience", 2, 4)

# Vectorized extraction
substring("DataScience", c(1, 5), c(4, 11))


################################################################################
# REAL-WORLD EXTRACTION EXAMPLES
################################################################################

cart <- c(
  "apple 5",
  "banana 10",
  "coco 14",
  "cherry no-count"
)

str_extract(cart, "\\d")           # First digit
str_extract_all(cart, "\\d+")      # All digits
str_subset(cart, "\\d+")            # Keep rows with numbers


################################################################################
# REPLACE & REMOVE TEXT
################################################################################

x <- "2025-06-21"

sub("-", "/", x)                   # Replace first occurrence
gsub("-", "/", x)                  # Replace all occurrences

str_replace(x, "-", "/")
str_replace_all(x, "-", "/")

# Recode values
sex <- c("M", "F")
str_replace_all(sex, c("M" = "Male", "F" = "Female"))

# Remove symbols
price <- c("$40", "$56", "$30")
str_remove(price, "\\$")


################################################################################
# SUMMARY / OVERVIEW
################################################################################

# Create & Inspect:
#   character(), is.character()
#
# Length:
#   length(), nchar(), str_length()
#
# Concatenation & Formatting:
#   paste(), paste0(), sprintf(), str_glue()
#
# Case Conversion:
#   toupper(), tolower()
#   str_to_upper(), str_to_lower(), str_to_title()
#
# Trimming & Padding:
#   trimws(), strrep()
#   str_trim(), str_squish()
#
# Substring / Extraction:
#   substr(), substring()
#   str_extract(), str_extract_all(), str_subset()
#
# Replace / Remove:
#   sub(), gsub()
#   str_replace(), str_replace_all(), str_remove()
#
# Splitting:
#   strsplit(), str_split()
#
# Comparison:
#   identical(), chartr()
#
# Sorting:
#   sort()
#
# Missing Values:
#   is.na()


################################################################################
# END OF FILE
################################################################################