#===============================================================================
# Chapter : Import and Export Operations using readr
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)
library(readr)


################################################################################
# LOAD DATASET
################################################################################

data("flights")
data("airports")


################################################################################
# PACKAGE LOADING INFORMATION
################################################################################

# tidyverse package attachments and conflicts

library(tidyverse)
library(nycflights13)


################################################################################
# FILE PATHS
################################################################################

# Absolute Path
# Example:
# /home/hitesh/Documents/GitHub/My_Trainings/R_language/files

# Relative Path
# Example:
# files/late_flights.csv


################################################################################
# CURRENT WORKING DIRECTORY
################################################################################

getwd()


################################################################################
# DATA PREVIEW
################################################################################

flights
glimpse(flights)


################################################################################
# EXPORT CSV FILE → write_csv()
################################################################################

# Export complete flights dataset

write_csv(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.csv"
)


################################################################################
# EXPORT FILTERED DATA
################################################################################

# Export flights delayed more than 60 minutes

late_flights <- flights |> 
  filter(arr_delay > 60)

write_csv(
  late_flights,
  "files/late_flights.csv"
)


################################################################################
# TEMPORARY FILES → tempfile()
################################################################################

# Create temporary csv file

temp_file <- tempfile(fileext = ".csv")

write_csv(
  flights,
  temp_file
)

temp_file


################################################################################
# HANDLE MISSING VALUES → na PARAMETER
################################################################################

# Count missing values

colSums(is.na(flights))

# Export with blank NA values

write_csv(
  flights,
  "files/flights_blank_na.csv",
  na = ""
)

# Export with custom missing value label

write_csv(
  flights,
  "files/flights_missing_na.csv",
  na = "missing"
)


################################################################################
# APPEND DATA → append = TRUE
################################################################################

# Create monthly flight datasets

jan_flights <- flights |> 
  filter(month == 1)

feb_flights <- flights |> 
  filter(month == 2)

# Write January flights

write_csv(
  jan_flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/monthly_flights.csv"
)

# Append February flights

write_csv(
  feb_flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/monthly_flights.csv",
  append = TRUE
)


################################################################################
# COLUMN HEADERS → col_names
################################################################################

# Export with column names

write_csv(
  late_flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/with_headers.csv",
  col_names = TRUE
)

# Export without column names

write_csv(
  late_flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/without_headers.csv",
  col_names = FALSE
)


################################################################################
# QUOTES HANDLING → quote PARAMETER
################################################################################

# Quote only when required

write_csv(
  late_flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/quote_needed.csv",
  quote = "needed"
)

# Quote all values

write_csv(
  late_flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/quote_all.csv",
  quote = "all"
)

# Disable quotes

write_csv(
  late_flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/quote_none.csv",
  quote = "none"
)

# none    → some regional settings reject quotes
# needed  → add quotes only when required
# all     → quote every field


################################################################################
# ESCAPE CHARACTERS → escape PARAMETER
################################################################################

airports_1 <- airports |> 
  slice(1:5) |> 
  mutate(
    remarks = c(
      'Pilot said "Delayed due to weather"',
      'Passenger said "Very good flight"',
      "Path: C:\\Flights\\Logs",
      'Quote and slash: "Error\\Warning"',
      'Normal text'
    )
  )

# Default export

write_csv(
  airports_1,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/orginal_escape.csv"
)

# Double quote escaping

write_csv(
  airports_1,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/double_escape.csv",
  escape = "double"
)

# Backslash escaping

write_csv(
  airports_1,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/backslash_escape.csv",
  escape = "backslash"
)

airports_1


################################################################################
# MULTITHREADING → num_threads
################################################################################

# Check available threads

readr_threads()

# Single-thread export

write_csv(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/single_thread.csv",
  num_threads = 1
)

# Multi-thread export

write_csv(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/multi_thread.csv",
  num_threads = 4
)


################################################################################
# IMPORT CSV FILES → read_csv()
################################################################################

# Read exported csv file

# imported_flights <- read_csv(
#   "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.csv"
# )

# Read delayed flights file

# delayed_data <- read_csv(
#   "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/late_flights.csv"
# )


################################################################################
# PRACTICE EXERCISES
################################################################################

# Export Delayed Flights Report

flights |> 
  filter(arr_delay > 120) |> 
  write_csv(
    "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/high_delay_report.csv"
  )


# Export Carrier Summary Report

carrier_summary <- flights |> 
  group_by(carrier) |> 
  summarise(
    avg_arr_delay = mean(arr_delay, na.rm = TRUE),
    total_flights = n()
  )

write_csv(
  carrier_summary,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/carrier_summary.csv"
)


# Export Top 100 Longest Flights

top_100_flights <- flights |> 
  arrange(desc(distance)) |> 
  slice(1:100)

write_csv(
  top_100_flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/top_100_longest_flights.csv"
)


################################################################################
# KEY TAKEAWAYS
################################################################################

# write_csv()     → export dataframe to csv
# read_csv()      → import csv files
# tempfile()      → create temporary files
# na parameter    → customize missing values
# append = TRUE   → append data into existing file
# col_names       → control column headers
# quote           → control text quoting
# escape          → handle special characters
# num_threads     → improve export performance
# absolute path   → full system file location
# relative path   → path relative to working directory


#===============================================================================
# END OF FILE
#===============================================================================