#===============================================================================
# Chapter : Importing CSV Files using read_csv()
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)


################################################################################
# READ CSV FILE USING ABSOLUTE PATH
################################################################################

read_csv(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.csv"
)


################################################################################
# READ CSV FILE USING WORKING DIRECTORY
################################################################################

# Set working directory

setwd(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files"
)

# Check current working directory

getwd()

# Read file using relative path

read_csv("flights.csv")


################################################################################
# READ CSV FILE FROM URL
################################################################################

# Read csv from GitHub URL

read_csv(
  "https://raw.githubusercontent.com/ganeshbabuNN/mydatasets/refs/heads/master/pandas-Datasets/nycflights13/flight.csv"
)

# Read csv from API URL

read_csv(
  "https://data.cityofnewyork.us/resource/erm2-nwe9.csv"
)


################################################################################
# COLUMN NAMES → col_names
################################################################################

# Read with default column names

read_csv(
  "flights.csv",
  col_names = TRUE
)

# Read without column names

read_csv(
  "flights.csv",
  col_names = FALSE
)

# Temporary custom column names

read_csv(
  "flights.csv",
  col_names = c(
    "yr",
    "mth",
    "dy",
    "dt",
    "sdt"
  )
)


################################################################################
# COLUMN TYPES → col_types
################################################################################

read_csv(
  "flights.csv",
  col_types = cols(
    year     = col_integer(),
    month    = col_character(),
    day      = col_integer(),
    dep_time = col_skip()
  )
)


################################################################################
# COLUMN SELECTION → col_select
################################################################################

# Select specific columns

read_csv(
  "flights.csv",
  col_select = c(
    year,
    month,
    day,
    dep_delay,
    arr_delay
  )
)

# Select columns using helper function

read_csv(
  "flights.csv",
  col_select = starts_with("dep")
)


################################################################################
# ADD SOURCE FILE NAME → id
################################################################################

# Add source filename column

read_csv(
  "flights.csv",
  id = "source_file"
)

# Read multiple files

files <- c("flights.csv")

read_csv(
  files,
  id = "filenames"
)


################################################################################
# LOCALE SETTINGS → locale()
################################################################################

# Regional differences:
# Separator     : ,  → ;
# Decimal point : .  → ,
# Countries     : US, UK, AUS → Germany, France, Brazil, Italy

read_csv(
  "flights.csv",
  locale = locale(decimal_mark = ",")
)


################################################################################
# HANDLE MISSING VALUES → na
################################################################################

read_csv(
  "flights.csv",
  na = c(
    "",
    "NA",
    "NULL",
    "Missing"
  )
)

# Quoted NA value

"NA"

# quoted_na = TRUE
# Treat quoted "NA" as missing value

# read_csv(
#   "flights.csv",
#   quoted_na = TRUE
# )


################################################################################
# REMOVE EXTRA WHITESPACES → trim_ws
################################################################################

a <- c(
  "   d  ",
  "dd  ",
  "d d "
)

trimws(a)

read_csv(
  "flights.csv",
  trim_ws = TRUE
)


################################################################################
# SKIP ROWS → skip
################################################################################

# Skip first 2 rows

read_csv(
  "flights.csv",
  skip = 2
)


################################################################################
# LIMIT NUMBER OF ROWS → n_max
################################################################################

# Read only first 10 rows

read_csv(
  "flights.csv",
  n_max = 10
)


################################################################################
# TYPE GUESSING → guess_max
################################################################################

# Guess column types using first 10 rows

read_csv(
  "flights.csv",
  guess_max = 10
)

# R makes datatype decisions
# based only on the first 10 rows


################################################################################
# COLUMN NAME REPAIR → name_repair
################################################################################

# Make names unique

# read_csv(
#   "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/test.csv",
#   name_repair = "unique"
# )

# No repair or checks

# read_csv(
#   "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/test.csv",
#   name_repair = "minimal"
# )

# Check uniqueness only

# read_csv(
#   "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/test.csv",
#   name_repair = "check_unique"
# )

# Unique repair silently

# read_csv(
#   "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/test.csv",
#   name_repair = "unique_quiet"
# )

# Universal repair

# read_csv(
#   "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/test.csv",
#   name_repair = "universal"
# )

# Universal repair silently

# read_csv(
#   "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/test.csv",
#   name_repair = "universal_quiet"
# )


################################################################################
# KEY TAKEAWAYS
################################################################################

# read_csv()     → import csv files
# setwd()        → set working directory
# getwd()        → get current working directory
# col_names      → manage column names
# col_types      → define datatypes manually
# col_select     → import selected columns
# id             → add source filename column
# locale()       → regional formatting settings
# na             → define missing values
# trim_ws        → remove extra whitespaces
# skip           → skip rows while importing
# n_max          → limit rows during import
# guess_max      → control datatype guessing
# name_repair    → repair duplicate/invalid names


#===============================================================================
# END OF FILE
#===============================================================================