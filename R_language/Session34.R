#===============================================================================
# Chapter 33 : Lazy Evaluation, Anonymous Functions & Error Handling in R
#===============================================================================


################################################################################
# LAZY ARGUMENTS / LAZY EVALUATION
################################################################################
# Arguments in R are evaluated ONLY when they are actually used inside a function.

a <- function(a, b) {
  print(a + 3)   # b is never evaluated
}

a(2)


################################################################################
# ANONYMOUS FUNCTIONS
################################################################################
# Functions without a name
# Commonly used with apply-family functions (lapply, sapply, etc.)

df <- data.frame(
  name   = c("g", "c", "f"),
  weight = c(34, 45, 101),
  stringsAsFactors = TRUE
)

df

# Named function
bmi <- function(w) {
  res <- w / (1.75 * 2)
  return(res)
}

# Anonymous function with sapply
df$BMI <- sapply(df$weight, function(w) w / (1.75 * 2))
df


################################################################################
# FUNCTION ENVIRONMENT & SEARCH PATH
################################################################################

library(tidyverse)

environment(bmi)
environment(print)
environment(dplyr)

find("bmi")
find("print")
find("dplyr")

?find
?environment


################################################################################
# DEBUGGING IN R
################################################################################
# debug() allows step-by-step execution of a function

gan <- function(a, b) {
  print(a + 3)
  print(a + 2)
  print(a + 1)
  
  for (i in 1:10) {
    print(i)
  }
}

debug(gan)
gan(2)


################################################################################
# ERRORS AND EXCEPTIONS
################################################################################

# Example of error
res <- 10 + "gan"    # Type error
print("hello")

log(10)

# Function without error handling
logt <- function(x) {
  print("1 - process started")
  print(log(x))
  print("2 - process ended")
}

logt(3)
log("a")       # Error
logt(-1)       # Warning + NaN


################################################################################
# MANUALLY RAISING ERRORS USING stop()
################################################################################

logt <- function(x) {
  print("1 - process started")
  
  if (x < 0) {
    stop("It is a negative number")
  }
  
  print(log(x))
  print("2 - process ended")
}

logt(-1)


################################################################################
# GENERATING WARNINGS USING warning()
################################################################################

logt <- function(x) {
  print("1 - process started")
  
  if (x < 0) {
    warning("It is a negative number")
  }
  
  print(log(x))
  print("2 - process ended")
}

logt(-1)


################################################################################
# USING message()
################################################################################
# message() is used for informational output
# Can be suppressed using suppressMessages()

logt <- function(x) {
  message("1 - process started")
  
  if (x < 0) {
    warning("It is a negative number")
  }
  
  print(log(x))
  message("2 - process ended")
}

logt(1)


################################################################################
# HANDLING ERRORS USING try()
################################################################################

logt <- function(x) {
  message("1 - process started")
  
  if (x < 0) {
    warning("It is a negative number")
  }
  
  res <- try(log(x))
  
  if (inherits(res, "try-error")) {
    print("Error occurred in RES")
  }
  
  message("2 - process ended")
}

logt("a")


################################################################################
# SUMMARY
################################################################################
# ✔ Lazy evaluation delays argument execution
# ✔ Anonymous functions enable inline logic
# ✔ debug() helps trace execution
# ✔ stop() → error
# ✔ warning() → warning
# ✔ message() → informational logs
# ✔ try() → basic error handling
# ✔ tryCatch() → advanced error handling (next topic)


################################################################################
# NEXT TOPIC
################################################################################
# tryCatch() – Structured error handling
#===============================================================================