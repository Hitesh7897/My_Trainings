#===============================================================================
# Chapter 15: Built-in Functions, Number Systems, Text Encoding & Date-Time
#===============================================================================


###############################################
# Handling NA in Aggregation
###############################################

a <- c(1, 2, 3, 34, NA)

sum(a, na.rm = TRUE)


###############################################
# Number Systems in R
###############################################
# Decimal, Binary, Octal, Hexadecimal

a <- 363

print(a)                 # Decimal
print(intToBits(a))      # Binary (raw representation)
print(as.octmode(a))     # Octal
print(as.hexmode(a))     # Hexadecimal

# NOTE:
# R does NOT have bin(), oct(), hex() like Python.
# Use intToBits(), as.octmode(), as.hexmode()


###############################################
# UTF-8 Encoding & Decoding
###############################################

test <- utf8ToInt("Apples")
test
class(test)

test1 <- intToUtf8(test)
test1


###############################################
# Built-in Mathematical Functions
###############################################

abs(-3)
2^2
sqrt(25)

log(10)        # Natural log
exp(1)

factorial(4)

a <- c(3, 4, 5, 6, 7)

sum(a)
prod(a)


###############################################
# Rounding Functions
###############################################

a <- 3.556

round(a)
round(a, 2)

ceiling(a)
floor(a)

trunc(a)


###############################################
# Ordering, Sorting & Ranking
###############################################

student_marks <- c(34, 56, 31, 46, 78, 87, 43, 87, NA)

order(student_marks)                   # Position index
sort(student_marks, na.last = TRUE)
rank(student_marks, na.last = "keep")

max(student_marks, na.rm = TRUE)
min(student_marks, na.rm = TRUE)

which.max(student_marks)
which.min(student_marks)

student_marks[which.max(student_marks)]


###############################################
# Descriptive Statistics
###############################################

mean(student_marks, na.rm = TRUE)
sum(student_marks, na.rm = TRUE)
median(student_marks, na.rm = TRUE)
sd(student_marks, na.rm = TRUE)

range(student_marks, na.rm = TRUE)


###############################################
# Cumulative Functions
###############################################

a <- c(1, 2, 3, 4, 5, 6)

cumsum(a)
cumprod(a)
cummax(a)
cummin(a)


###############################################
# Numeric Formatting
###############################################
# digits → significant digits
# nsmall → minimum decimal places

a <- c(12.36, 22.3600, 3.899, 4.256, 5.36, 6)
class(a)

format(a, nsmall = 1)
format(a, digits = 3)

format(c(6.0, 13.1), digits = 2)
format(12.343456, digits = 4)
format(12.3, nsmall = 3)
format(6.0, nsmall = 2)
format(6.12, digits = 2)

nums <- c(1.5, 12.345, 100)
format(nums, nsmall = 2)


###############################################
# System Date & Time
###############################################

Sys.time()

format(Sys.time(), "%Y")
format(Sys.time(), "%y")
format(Sys.time(), "%B")
format(Sys.time(), "%b")
format(Sys.time(), "%m")
format(Sys.time(), "%d")
format(Sys.time(), "%A")
format(Sys.time(), "%a")
format(Sys.time(), "%H")
format(Sys.time(), "%M")
format(Sys.time(), "%S")

# ISO 8601 Date-Time Format
format(Sys.time(), "%Y-%m-%dT%H:%M:%S")


###############################################
# lubridate (Recommended for Date-Time Handling)
###############################################

library(lubridate)

ymd_hms(Sys.time())
format_ISO8601(Sys.time())


###############################################
# Character to Date Conversion
###############################################

a <- "03012026"

# Base R (fails without format)
as.Date(a)

# lubridate (correct approach)
dmy(a)


###############################################
# Key Interview Takeaways
###############################################

# 1. Always use na.rm = TRUE in aggregations
# 2. R does NOT have bin(), oct(), hex() like Python
# 3. intToBits() gives raw binary (machine-level)
# 4. Use format() for presentation, NOT computation
# 5. lubridate is safer for real-world date parsing
# 6. UTF-8 encoding matters in multilingual data
# 7. which.max() gives position, max() gives value


###############################################
# END OF FILE
###############################################