#===============================================================================
# Chapter 35 : stopifnot(), Production Error Handling & Package Management in R
#===============================================================================


################################################################################
# stopifnot() – SANITY CHECK / VALIDATION TOOL
################################################################################
# stopifnot() is used to validate assumptions.
# If the condition is FALSE, execution stops immediately.

is.numeric(4)
is.numeric(-1)

x <- -1

try(
  stopifnot("This value of x is less than 0" = x > 0)
)

# Used for:
# - Input validation
# - Data sanity checks
# - Defensive programming


################################################################################
# REAL-TIME PRODUCTION EXAMPLE
################################################################################
# Production-ready script characteristics:
# ✔ Script never crashes
# ✔ Errors logged
# ✔ Warnings handled
# ✔ Cleanup always runs


process_file <- function(file) {
  
  tryCatch(
    {
      # Manual error trigger
      if (!file.exists(file)) {
        stop("File does not exist")
      }
      
      data <- read.csv(file)
      
      # Manual warning trigger
      if (nrow(data) == 0) {
        warning("File is empty")
      }
      
      mean(data$value)
    },
    
    error = function(e) {
      message(paste("Error in file:", file))
      return(NULL)
    },
    
    warning = function(w) {
      message(paste("Warning in file:", file))
      return(NA)
    },
    
    finally = {
      message(paste("Finished processing:", file))
    }
  )
}


################################################################################
# TESTING FILE PROCESSING
################################################################################

process_file("file.csv")
process_file("file1.csv")
process_file("file2.csv")
process_file("file3.csv")
process_file("abcd.csv")

files <- c("file3.csv", "file.csv", "file1.csv", "file2.csv")
lapply(files, process_file)


################################################################################
# GLOBAL ERROR HANDLING OPTIONS
################################################################################

# Show traceback on error
options(error = traceback)

# Enter debugging mode on error
options(error = recover)

# Reset to default
options(error = NULL)


################################################################################
# PACKAGE MANAGEMENT IN R
################################################################################

# View loaded packages
search()

# View installed packages
installed.packages()

# Check old packages
old.packages()

# Update packages
update.packages()

# Remove package
remove.packages("MASS")

# Install from local ZIP
install.packages(
  "C:\\Users\\ganes\\Downloads\\grates-1.7.2.zip",
  repos = NULL,
  type = "source"
)

# Conditional installation
if (!require(reshape2)) {
  install.packages("reshape2")
  library(reshape2)
}

# Library paths
.libPaths()

# Show installed packages in interactive view
library()


################################################################################
# NAMESPACE LOCATOR (::)
################################################################################

install.packages("dplyr")
library(dplyr)

# Use specific function without loading entire namespace
dplyr::filter()


################################################################################
# SUMMARY
################################################################################
# stopifnot()     → Validation / sanity check
# tryCatch()      → Structured error handling
# options(error)  → Global error behavior
# lapply()        → Batch file processing
# require()       → Conditional package loading
# ::              → Explicit namespace usage
# .libPaths()     → View library directories


#===============================================================================
# END OF FILE
#===============================================================================