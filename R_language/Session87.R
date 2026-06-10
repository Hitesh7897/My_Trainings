#===============================================================================
# Chapter : Text Files, Fixed Width Files, RDS, RData & FST Files
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
# TEXT FILE HANDLING
################################################################################

# Common text file formats:
# .txt
# .csv
# .tsv


################################################################################
# PIPE DELIMITED TEXT FILE → Base R
################################################################################

# Write pipe-delimited file

write.table(
  flights,
  file = "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_pipe.txt",
  sep = "|"
)

# Read pipe-delimited file

read.table(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_pipe.txt",
  sep = "|"
)


################################################################################
# COMMA DELIMITED TEXT FILE
################################################################################

# Write comma-separated file

write.table(
  flights,
  file = "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_comma.txt",
  sep = ","
)

# Read comma-separated file

read.table(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_comma.txt",
  sep = ","
)


################################################################################
# TAB DELIMITED TEXT FILE
################################################################################

# Write tab-separated file

write.table(
  flights,
  file = "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_tab.txt",
  sep = "\t"
)

# Read tab-separated file

read.table(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_tab.txt",
  sep = "\t"
)


################################################################################
# DELIMITED FILES USING readr
################################################################################

# Pipe-delimited

write_delim(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_pipe_readr.txt",
  delim = "|"
)

read_delim(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_pipe_readr.txt",
  delim = "|"
)


################################################################################
# SEMICOLON DELIMITED FILE
################################################################################

write_delim(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_semicolon.txt",
  delim = ";"
)

read_delim(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_semicolon.txt",
  delim = ";"
)


################################################################################
# FIXED WIDTH FILES (FWF)
################################################################################

# Column widths:
# year      → 6
# month     → 4
# day       → 4
# carrier   → 8
# flight    → 8
# dep_delay → 8

fwf_data <- flights |>
  select(
    year,
    month,
    day,
    carrier,
    flight,
    dep_delay
  ) |>
  slice(1:10)

fwf_data


################################################################################
# CREATE FIXED WIDTH FILE → sprintf()
################################################################################

fwf_lines <- sprintf(
  "%-6s%-4s%-4s%-8s%-8s%-8s",
  fwf_data$year,
  fwf_data$month,
  fwf_data$day,
  fwf_data$carrier,
  fwf_data$flight,
  fwf_data$dep_delay
)

fwf_lines


################################################################################
# WRITE FIXED WIDTH FILE
################################################################################

writeLines(
  fwf_lines,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/fwf_lines.txt"
)


################################################################################
# READ FIXED WIDTH FILE
################################################################################

readLines(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/fwf_lines.txt",
  n = 5
)


################################################################################
# RDS FILES
################################################################################

# Save single R object

saveRDS(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.rds"
)

# Read RDS file

readRDS(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.rds"
)


################################################################################
# RDS FILE OPTIONS
################################################################################

# Version 2 for backward compatibility

saveRDS(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_v2.rds",
  version = 2
)

# GZIP compression

saveRDS(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_gzip.rds",
  compress = "gzip"
)

# BZIP2 compression

saveRDS(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_bzip2.rds",
  compress = "bzip2"
)

# XZ compression

saveRDS(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_xz.rds",
  compress = "xz"
)

# Default compression

saveRDS(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_default.rds",
  compress = TRUE
)


################################################################################
# READ COMPRESSED RDS FILE
################################################################################

readRDS(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_v2.rds"
)


################################################################################
# RDATA FILES
################################################################################

# Save single object

save(
  flights,
  file = "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.RData"
)


################################################################################
# SAVE MULTIPLE OBJECTS
################################################################################

save(
  flights,
  airports,
  file = "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_airports.RData"
)


################################################################################
# LOAD RDATA FILE
################################################################################

load(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights_airports.RData"
)


################################################################################
# RDS vs RDATA
################################################################################

# RDS
# ----
# Stores a single object
# Requires readRDS()
# Object name can be assigned manually
#
# Example:
# df <- readRDS("file.rds")

# RDATA
# -----
# Stores one or more objects
# Requires load()
# Original object names are restored automatically
#
# Example:
# load("file.RData")


################################################################################
# FST FILES
################################################################################

# High-performance file format for R analytics
# Faster read/write compared to CSV and RDS

install.packages("fst")

library(fst)


################################################################################
# WRITE FST FILE
################################################################################

write_fst(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.fst"
)


################################################################################
# READ FST FILE
################################################################################

read_fst(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.fst"
)


################################################################################
# KEY TAKEAWAYS
################################################################################

# write.table()    → export text files
# read.table()     → import text files
# write_delim()    → export delimited files
# read_delim()     → import delimited files
# sprintf()        → create fixed width records
# writeLines()     → write text line-by-line
# readLines()      → read text line-by-line
# saveRDS()        → save single R object
# readRDS()        → read single R object
# save()           → save multiple R objects
# load()           → load RData files
# write_fst()      → write fst files
# read_fst()       → read fst files
# .rds             → single object storage
# .RData           → multiple object storage
# .fst             → high-speed analytics format


#===============================================================================
# END OF FILE
#===============================================================================