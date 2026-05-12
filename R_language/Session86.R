#===============================================================================
# Chapter : Advanced Excel Importing & TSV File Handling
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)
library(readxl)


################################################################################
# SET WORKING DIRECTORY
################################################################################

setwd(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/"
)

getwd()


################################################################################
# READ EXCEL FILE → col_names
################################################################################

# Read with headers

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_data.xlsx",
  col_names = TRUE
)

# Read without headers

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_data.xlsx",
  col_names = FALSE
)


################################################################################
# CUSTOM COLUMN NAMES
################################################################################

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_data.xlsx",
  col_names = c(
    "yr",
    "mn",
    "dy",
    "dep_time",
    rep("Extra", 15)
  )
)


################################################################################
# RENAME COLUMNS AFTER IMPORT
################################################################################

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_data.xlsx"
) |> 
  rename(
    yr = year,
    mn = month,
    dy = day
  )


################################################################################
# COLUMN TYPES → col_types
################################################################################

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_data.xlsx",
  col_types = c(
    "numeric",
    "numeric",
    "numeric",
    rep("skip", 16)
  )
)


################################################################################
# HANDLE MISSING VALUES → na
################################################################################

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_data.xlsx",
  na = c(
    "",
    "NA",
    "Missing",
    "NULL"
  )
)


################################################################################
# REMOVE EXTRA WHITESPACES → trim_ws
################################################################################

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_data.xlsx",
  trim_ws = FALSE
)


################################################################################
# SKIP ROWS → skip
################################################################################

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_data.xlsx",
  skip = 2
)


################################################################################
# LIMIT ROWS → n_max
################################################################################

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_data.xlsx",
  n_max = 10
)


################################################################################
# TYPE GUESSING → guess_max
################################################################################

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_data.xlsx",
  guess_max = 10
)

# R decides column datatypes
# based on the first 10 records


################################################################################
# COLUMN NAME REPAIR → .name_repair
################################################################################

# Make names unique

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/test.xlsx",
  .name_repair = "unique"
)

# Minimal repair

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/test.xlsx",
  .name_repair = "minimal"
)

# Universal repair

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/test.xlsx",
  .name_repair = "universal"
)

# Universal repair quietly

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/test.xlsx",
  .name_repair = "universal_quiet"
)


################################################################################
# TSV FILE HANDLING
################################################################################

# TSV → Tab Separated Values


################################################################################
# WRITE TSV FILE → write_tsv()
################################################################################

write_tsv(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.tsv"
)


################################################################################
# READ TSV FILE → read_tsv()
################################################################################

read_tsv(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.tsv",
  n_max = 10
)


################################################################################
# COMPRESSED TSV FILES
################################################################################

# GZIP compression

write_tsv(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.tsv.gz"
)

# BZIP2 compression

write_tsv(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.tsv.bz2"
)

# XZ compression

write_tsv(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.tsv.xz"
)


################################################################################
# READ COMPRESSED TSV FILE
################################################################################

read_tsv(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.tsv.bz2"
)


################################################################################
# KEY TAKEAWAYS
################################################################################

# read_excel()      → import Excel files
# col_names         → manage headers
# col_types         → control datatypes
# rename()          → rename columns after import
# na                → define missing values
# trim_ws           → handle whitespaces
# skip              → skip rows during import
# n_max             → limit rows during import
# guess_max         → datatype guessing limit
# .name_repair      → repair duplicate names
# write_tsv()       → export TSV files
# read_tsv()        → import TSV files
# TSV               → tab separated values
# .gz               → gzip compression
# .bz2              → bzip2 compression
# .xz               → xz compression


#===============================================================================
# END OF FILE
#===============================================================================