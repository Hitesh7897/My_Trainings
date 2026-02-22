#===============================================================================
# Chapter 23: Regular Expressions – ?, *, +, Anchors, and Real-world Validation
#===============================================================================

################################################################################
# INTRODUCTION
################################################################################
# Regular Expressions (Regex) are patterns used to match, search, extract,
# or validate strings.
#
# In R, regex is widely used in:
# - Data cleaning
# - Clinical data validation (USUBJID, AETERM, LAB data)
# - Web scraping
# - Text mining
#
# This file focuses on:
#   ?, *, +   (Quantifiers)
#   ^ and $   (Anchors)
#   Real-world validation rules
################################################################################


################################################################################
# BASIC TEST DATA
################################################################################
x <- c("c#a","ca","caaaa","xa","aab")
x


################################################################################
# 1. ASTERISK (*)  → ZERO OR MORE OCCURRENCES
################################################################################
# Pattern: ca*
# Meaning:
#   c   → mandatory
#   a*  → zero or more 'a'

grep("ca*", x, value = TRUE)

# Explanation:
# "c#a"     -> c matches, a* = zero a
# "ca"      -> c + one a
# "caaaa"   -> c + many a
# "xa"      -> no c → NO MATCH
# "aab"     -> no c → NO MATCH


################################################################################
# DANGER OF USING *
################################################################################
grep("a*", c("c#a","ca","caaaa","xa","aab","ykke"), value = TRUE)

# WHY EVERYTHING MATCHES?
# a* allows ZERO 'a'
# Zero 'a' exists at every position in every string
#
# RULE:
# Never use * for validation logic


################################################################################
# 2. QUESTION MARK (?) → ZERO OR ONE OCCURRENCE
################################################################################
# Pattern: ca?
# Meaning:
#   c   → mandatory
#   a?  → optional (0 or 1)

grep("ca?", c("c#a","ca","caaaa","xa","aab"), value = TRUE)

# Matches:
# "c#a"     -> c only
# "ca"      -> c + a
# "caaaa"   -> matches only "ca" inside
#
# Again, ? is OPTIONAL → risky for validation


################################################################################
# DANGER OF USING ?
################################################################################
grep("a?", c("c#a","ca","caaaa","xa","aab"), value = TRUE)

# Everything matches
# Because ZERO 'a' is allowed everywhere


################################################################################
# PROPER USE OF ? WITH ANCHORS
################################################################################
grep("^a?$", c("c#a","ca","caaaa","xa","aab"), value = TRUE)

# ^ start of string
# $ end of string
#
# Valid strings:
# "" (empty)
# "a"


################################################################################
# 3. PLUS (+) → ONE OR MORE OCCURRENCES  (BEST PRACTICE)
################################################################################
# + means the character MUST exist at least once
# This is the safest quantifier for validation


################################################################################
# SUMMARY OF ?, *, +
################################################################################
# ?  → 0 or 1 time       (Optional)        ❌ Risky
# *  → 0 or more times  (Anything)         ❌ Dangerous
# +  → 1 or more times  (Mandatory)        ✅ Best Practice


################################################################################
# REAL-WORLD EXAMPLE 1: PRODUCT CODE VALIDATION
################################################################################
code <- c(
  "AB123",
  "AB1234",
  "AB",
  "AB1",
  "AB12345",
  "AC123",
  "ABCD123"
)

# BUSINESS RULE:
# - Must start with "AB"
# - Must have AT LEAST one digit
# - Only digits allowed after AB


################################################################################
# CORRECT SOLUTION
################################################################################
grep("^AB[0-9]+$", code, value = TRUE)

# + ensures at least one digit is mandatory


################################################################################
# WRONG SOLUTIONS (DO NOT USE)
################################################################################
grep("^AB[0-9]*$", code, value = TRUE)   # allows "AB" → WRONG
grep("^AB[0-9]?$", code, value = TRUE)   # allows only one digit → WRONG


################################################################################
# REAL-WORLD EXAMPLE 2: CLINICAL USUBJID VALIDATION
################################################################################
usubjid <- c(
  "ABC123-001-0001",   # valid
  "ABC123-01-0001",    # invalid site
  "ABC123-001-001",    # invalid subject
  "ABC123-001-",       # invalid
  "ABC123-001-00012",  # invalid
  "ABC123-001",
  "AB1",
  "A",
  "1",
  "A1",
  "AB"
)

# BUSINESS RULE:
# <LETTERS+NUMBERS>-<3 DIGITS>-<4 DIGITS>


################################################################################
# CORRECT VALIDATION REGEX
################################################################################
grep("^[A-Z0-9]+-[0-9]{3}-[0-9]{4}$", usubjid, value = TRUE)


################################################################################
# WRONG / TOO LOOSE (DO NOT USE)
################################################################################
grep("^[A-Z0-9]*-[0-9]*-[0-9]*$", usubjid, value = TRUE)
grep("^[A-Z0-9]?$", usubjid, value = TRUE)


################################################################################
# GOLDEN RULES FOR REGEX VALIDATION
################################################################################
# 1. If something MUST exist → use +
# 2. Avoid * in validation logic
# 3. Always use ^ and $ for full-string validation
# 4. Prefer explicit counts: {n}, {n,m}
# 5. Think in BUSINESS RULES, not symbols


################################################################################
# END OF FILE
################################################################################