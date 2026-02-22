#===============================================================================
# Chapter 22: Regular Expressions – Special Characters
#===============================================================================

###############################################
# Sample Data
###############################################

x <- c("cat", "bat", "rat", "drat", "cat123", "123cat", "c.at")
x


###############################################
# . (Dot) – Any Single Character
###############################################
# The dot (.) matches ANY single character except newline

grep("c.t", x, value = TRUE)

library(tidyverse)
str_subset(string = x, pattern = "c.t")

# Matches:
# cat
# c.at


###############################################
# ^ (Caret) – Start of the String
###############################################
# ^c means string must START with 'c'

grep("^c", x, value = TRUE)

# Matches:
# cat
# cat123
# c.at


###############################################
# $ (Dollar) – End of the String
###############################################
# t$ means string must END with 't'

grep("t$", x, value = TRUE)

# Matches:
# cat
# bat
# rat
# drat
# 123cat


###############################################
# * (Asterisk) – Zero or More Occurrences
###############################################
# a* means ZERO or MORE 'a' characters
# Important: * applies ONLY to the character before it

grep("ca*", x, value = TRUE)

# Explanation:
# "c" followed by ZERO or more "a"

test_vec <- c(
  "c#a", "cda", "ceee", "candy", "Carol",
  "rccc", "ra", "ganced", "chaitanya"
)

grep("ca*", test_vec, value = TRUE)

str_subset(string = test_vec, pattern = "ca*")

# Breakdown:
# c       -> YES (a* = zero a)
# ca      -> YES
# c followed by anything -> YES
# ra      -> NO (no c)
# Carol   -> YES (case-sensitive C != c)
# chaitanya -> YES


###############################################
# a* Alone (Important Concept)
###############################################
# a* matches ZERO or more a's
# This means it matches EVERY position in a string

grep("a*", c("c#a", "ceee", "rccc", "ra", "ganced", "chaitanya"), value = TRUE)

# This is why a* is dangerous in web scraping if misused


###############################################
# + (Plus) – One or More Occurrences
###############################################
# a+ means ONE or MORE 'a'
# At least one 'a' must be present

grep(
  "ca+",
  c("c#a", "cda", "ceee", "candy", "Carol", "rccc", "ra", "ganced", "chaitanya"),
  value = TRUE
)

str_subset(
  string = c("c#a", "cda", "ceee", "candy", "Carol", "rccc", "ra", "ganced", "chaitanya"),
  pattern = "ca+"
)

# Matches:
# ca
# candy
# ganced
# chaitanya


###############################################
# ? (Question Mark) – Zero or One Occurrence
###############################################
# a? means a is OPTIONAL (0 or 1 time)

grep("ca?", x, value = TRUE)

grep(
  "ca?",
  c("c#a", "cda", "ceee", "candy", "Carol",
    "rccc", "ra", "gnaced", "chaitanya", "aadsaaabx"),
  value = TRUE
)

# Explanation:
# c      -> YES
# ca     -> YES
# c only -> YES
# ra     -> NO
# gnaced -> YES (contains c)
# This is VERY useful in web scraping & loose pattern matching


###############################################
# Summary of Special Characters
###############################################

# .   -> Any single character
# ^   -> Start of string
# $   -> End of string
# *   -> Zero or more occurrences
# +   -> One or more occurrences
# ?   -> Zero or one occurrence


###############################################
# Real-World Use Cases
###############################################

# ✔ File validation
# ✔ Web scraping
# ✔ SDTM / ADaM text standardization
# ✔ Free-text medical term cleaning
# ✔ Data quality checks


#===============================================================================
# END OF FILE
#===============================================================================