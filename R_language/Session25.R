#===============================================================================
# Chapter 24: Regex Grouping, Character Classes, Quantifiers & Escapes
#===============================================================================

################################################################################
# SAMPLE DATA
################################################################################
x <- c("cat", "bat", "rat", "drat", "cat123", "123cat", "c.at", "g*t")
x


################################################################################
# ()  GROUPING  → Match one of many patterns (OR)
################################################################################
# (cat|bat) → match either "cat" OR "bat"

grep("(cat|bat)", x, value = TRUE)

# Expected Output:
# "cat" "bat" "cat123" "123cat"


################################################################################
# []  CHARACTER CLASS → Match ONE character from a set
################################################################################
# [cr]at → match "cat" or "rat"

grep("[cr]at", x, value = TRUE)

# Matches:
# "cat" "rat" "cat123" "123cat"


################################################################################
# {}  QUANTIFIER → Exact repetition
################################################################################
# a{2} → exactly TWO 'a'

grep("a{2}", c("a","aaa","aaaa","baabaaaa","aa"), value = TRUE)

grep("a{2}", c("a","aaa","aaaa","baabaaaa","aa","cacacacacbaa"), value = TRUE)

# value = FALSE → return index positions
grep("a{2}", c("a","aaa","aaaa","baabaaaa","aa","cacacacacbaa"), value = FALSE)


################################################################################
# \\  ESCAPE → Make special characters literal
################################################################################
# . and * are special characters
# To match them literally → escape using \\

x <- "a"

grep("\\.", x, value = TRUE)   # literal dot
grep("\\*", x, value = TRUE)   # literal star
grep(".", x, value = TRUE)     # dot means ANY character

# Print with escape characters
cat("Hitesh \n B G")


################################################################################
# [^ ]  NEGATIVE CHARACTER CLASS
################################################################################
# [^0-9] → match anything that is NOT a digit

grep("[^0-9]", c("123","12a","456"), value = TRUE)

# Matches:
# "12a"


################################################################################
# PERL-STYLE CHARACTER CLASSES
################################################################################
# \\d → digit
# \\D → non-digit
# \\w → word character (letters, digits, underscore)
# \\W → non-word character (symbols, spaces)
# \\s → whitespace (space, tab, newline)
# \\S → non-whitespace

grep("\\d", x, value = TRUE, perl = TRUE)
grep("\\D", x, value = TRUE, perl = TRUE)
grep("\\w", x, value = TRUE, perl = TRUE)

grep("\\W", c("c.at","g*t","C123","C&a","C a"), value = TRUE, perl = TRUE)
grep("\\s", c(" ","  ","A","A ","123","!"), value = TRUE, perl = TRUE)
grep("\\S", c(" ","  ","A","A ","123","!"), value = TRUE, perl = TRUE)


################################################################################
# POSIX PREDEFINED CHARACTER CLASSES
################################################################################
# [:digit:] → digits (0–9)
# [:alpha:] → letters
# [:alnum:] → letters + digits
# [:lower:] → lowercase letters
# [:upper:] → uppercase letters
# [:space:] → whitespace

x <- c(
  "abc",
  "ABC",
  "AbC123",
  "123",
  "abc_123",
  "hello world",
  "\tspace",
  "email@test.com"
)

grep("[[:digit:]]", x, value = TRUE)
grep("[[:alpha:]]", x, value = TRUE)
grep("[[:alnum:]]", x, value = TRUE)
grep("[[:lower:]]", x, value = TRUE)
grep("[[:upper:]]", x, value = TRUE)
grep("[[:space:]]", x, value = TRUE)


################################################################################
# SUMMARY
################################################################################
# ()     → Grouping / OR logic
# []     → One character from a set
# {}     → Exact repetition
# \\     → Escape special characters
# [^ ]   → Negative character class
# \\d \\w \\s → Perl-style shortcuts
# [:digit:] → POSIX-style classes
#
# BEST PRACTICE:
# - Use + for mandatory matches
# - Avoid * in validation
# - Always anchor with ^ and $
################################################################################

################################################################################
# END OF FILE
################################################################################