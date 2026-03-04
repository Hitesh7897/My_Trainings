#===============================================================================
# Chapter 34 : Exception Handling & Conditions in R
#===============================================================================


################################################################################
# INTRODUCTION
################################################################################
# In R, exceptions are handled using condition mechanisms.
# R provides different condition types to manage execution flow:
# - message()
# - warning()
# - stop()
# - try()
# - tryCatch()
# - withCallingHandlers()


################################################################################
# TYPES OF CONDITIONS IN R
################################################################################

# message() → Informational message (does not stop execution)
message("Information about your code")

# Compare with print()
print("Information about your code")


################################################################################
# WARNING
################################################################################
# warning() → Used when something suspicious happens but execution continues

sqrt(4)
sqrt(-1)  # Generates warning (NaN produced)

warning("This is a negative number")


################################################################################
# STOP (ERROR)
################################################################################
# stop() → Stops execution immediately

if (!file.exists("file5.csv")) {
  stop("File is not found")
  print("This line will NOT execute")
}


################################################################################
# try() – BASIC ERROR HANDLING
################################################################################

log(10)

try(log("a"))   # Prevents script from stopping
print("Hello")

# Capture error object
res <- try(log("a"))
res

if (inherits(res, "try-error")) {
  print("Error detected")
}


# Example: Reading multiple files safely
files <- c("file3.csv", "file.csv", "file1.csv", "file2.csv")

for (f in files) {
  try(read.csv(f))
  print("Continuing loop...")
}


################################################################################
# tryCatch() – ADVANCED ERROR HANDLING
################################################################################

tryCatch(
  log("a"),
  error = function(e) {
    print("Error handled")
    print(e$message)
  }
)

# Handling both error and warning
tryCatch(
  {
    log("a")
  },
  error = function(e) {
    print("Error handled")
    print(e$message)
  },
  warning = function(w) {
    print("Warning caught! Pay attention")
    print(w$message)
  }
)


################################################################################
# FINALLY BLOCK
################################################################################
# Code inside finally always runs

tryCatch(
  {
    log("a")
  },
  error = function(e) {
    print("Error handled")
  },
  finally = {
    print("Cleanup activity done")
  }
)


################################################################################
# CUSTOM ERROR CREATION
################################################################################

my_function <- function(x) {
  if (x < 0) {
    stop(structure(
      list(message = "Negative value not allowed"),
      class = c("custom_error", "error", "condition")
    ))
  }
}

my_function(-1)


################################################################################
# HANDLING CUSTOM ERROR
################################################################################

tryCatch(
  my_function(-2),
  custom_error = function(e) {
    print("Custom error handled")
  }
)


################################################################################
# withCallingHandlers()
################################################################################
# Intercepts conditions without stopping execution

withCallingHandlers(
  sqrt(-1),
  warning = function(w) {
    print("Warning intercepted")
    invokeRestart("muffleWarning")   # Suppress warning
  }
)

?invokeRestart
sqrt(-1)


################################################################################
# SUPPRESSING WARNINGS & MESSAGES
################################################################################

suppressWarnings(sqrt(-1))
suppressMessages(library(dplyr))


################################################################################
# SUMMARY
################################################################################
# message()   → Informational output
# warning()   → Warning (execution continues)
# stop()      → Error (execution stops)
# try()       → Basic error capture
# tryCatch()  → Structured error handling
# withCallingHandlers() → Advanced condition handling
# suppressWarnings() / suppressMessages() → Hide output


#===============================================================================
# END OF FILE
#===============================================================================