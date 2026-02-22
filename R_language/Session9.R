#===============================================================================
# Chapter 08: String Concatenation & Mutability in R
#===============================================================================

library(tidyverse)


###############################################
# 1. stringr::str_c()
###############################################

# str_c() is a tidyverse-friendly string concatenation function
# Key behavior:
# - NA is contagious (propagates)
# - Vectorized
# - collapse behaves like paste()

stringr::str_c(c(4, 23, NA), sep = "/")

str_c("Data", "science", sep = " ")   # "Data science"
str_c("Data", "science", sep = ",")   # "Data,science"

# NA propagation
str_c(c("Data", "science", NA))       # "Data" "science" NA

# collapse joins into ONE string
str_c(c("Data", "science"), collapse = "-")        # "Data-science"
str_c(c("Data", "science", NA), collapse = "-")    # NA


###############################################
# 2. paste() and paste0()
###############################################

paste0(c("Data", "science", NA), collapse = "-")   # "Data-science-NA"

paste("hello", "world")                            # "hello world"
paste0("hello", "world")                           # "helloworld"

ids <- 1:3
paste("ID", ids)                                   # "ID 1" "ID 2" "ID 3"
paste0("ID", ids)                                  # "ID1" "ID2" "ID3"

paste("ID", c(3, 4, 5), collapse = "-")             # "ID 3-ID 4-ID 5"
paste0("ID", c(3, 4, 5), collapse = "-")            # "ID3-ID4-ID5"


###############################################
# 3. NA HANDLING COMPARISON (VERY IMPORTANT)
###############################################

str_c(c(2, 3), collapse = "-")                      # "2-3"
str_c(c(2, 3, NA), collapse = "-")                  # NA

paste(c(2, 3), collapse = "-")                      # "2-3"
paste(c(2, 3, NA), collapse = "-")                  # "2-3-NA"

# Key Difference:
# str_c()  -> NA propagates
# paste()  -> NA converted to "NA"


###############################################
# QUICK SUMMARY (INTERVIEW LEVEL)
###############################################

# paste()  : base R, tolerant of NA
# paste0() : same as paste(sep = "")
# str_c()  : tidyverse, strict NA handling, cleaner semantics


###############################################
# 4. MUTABLE vs IMMUTABLE OBJECTS IN R
###############################################

# QUESTION:
# Are objects mutable or immutable in R?

# SHORT ANSWER:
# ❌ R objects are NOT mutable
# ❌ R objects are NOT immutable
# ✅ R uses COPY-ON-MODIFY semantics


###############################################
# 5. COPY-ON-MODIFY DEMONSTRATION
###############################################

x <- c(1, 2, 3, 4, 5)

# Track memory address
tracemem(x)

# Modify vector
x[3] <- 10

x
tracemem(x)

# OUTPUT INTERPRETATION:
# - A new memory copy is created ONLY when modification happens
# - Original object is preserved until modification


###############################################
# 6. WHY R IS NOT "MUTABLE"
###############################################

# In mutable languages (C / Python lists):
# - Object changes in-place
# - Same memory location is modified

# In R:
# - Object is copied when modified
# - Original memory stays untouched
# - Safe for functional programming


###############################################
# 7. WHY R IS NOT "IMMUTABLE"
###############################################

# Immutable objects (e.g., Python tuple):
# - Cannot be changed at all
# - Must create new object always

# In R:
# - You CAN "change" objects
# - But internally R decides whether to copy or reuse memory


###############################################
# 8. COPY-ON-MODIFY IN SIMPLE WORDS
###############################################

# R behaves like:
# "Pretend objects are mutable,
#  but secretly copy them when needed."


###############################################
# 9. PERFORMANCE OPTIMIZATION (ADVANCED)
###############################################

# If object has single reference → R may modify in place
# If object has multiple references → R copies

a <- c(1, 2, 3)
b <- a                       # second reference created

tracemem(a)
tracemem(b)

a[1] <- 99                   # forces copy

tracemem(a)
tracemem(b)


###############################################
# 10. COMPARISON WITH C (calloc EXAMPLE)
###############################################

# C:
# int *ptr = (int*)calloc(5, sizeof(int));
# - Direct memory allocation
# - Manual memory control
# - Mutable by default

# R:
# - Memory managed by GC
# - No direct pointer manipulation
# - Safe, predictable behavior


###############################################
# FINAL INTERVIEW SUMMARY
###############################################

# ✔ R objects are NOT mutable
# ✔ R objects are NOT immutable
# ✔ R uses copy-on-modify
# ✔ tracemem() proves it
# ✔ This design supports functional programming
# ✔ Prevents side effects in data pipelines


###############################################
# END OF FILE
###############################################