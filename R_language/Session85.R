#===============================================================================
# Chapter : Excel File Handling using readxl & writexl
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)
library(readxl)      # For reading Excel files
library(writexl)     # For writing Excel files


################################################################################
# LOAD DATASETS
################################################################################

data("flights")
data("airports")
data("airlines")
data("planes")
data("weather")


################################################################################
# DATA PREVIEW
################################################################################

flights
airports
airlines
planes
weather


################################################################################
# SET WORKING DIRECTORY
################################################################################

setwd(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files"
)

getwd()


################################################################################
# WRITE EXCEL FILE → write_xlsx()
################################################################################

# Export delayed flights dataset

delay_flights <- flights |> 
  filter(arr_delay > 120)

write_xlsx(
  delay_flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/delay_flights.xlsx"
)


################################################################################
# MULTIPLE SHEETS IN EXCEL
################################################################################

# Create list of datasets

flights_list <- list(
  Flights  = flights,
  Airports = airports,
  Airlines = airlines,
  Planes   = planes,
  Weather  = weather
)

flights_list

# Export multiple sheets into one workbook

write_xlsx(
  flights_list,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/nycflights13.xlsx"
)


################################################################################
# TEMPORARY EXCEL FILE → tempfile()
################################################################################

temp_file <- tempfile(fileext = ".xlsx")

write_xlsx(
  flights,
  temp_file
)

temp_file


################################################################################
# COLUMN HEADERS → col_names
################################################################################

# Export with column names

write_xlsx(
  airports,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/with_headers.xlsx",
  col_names = TRUE
)

# Export without column names

write_xlsx(
  airports,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/without_headers.xlsx",
  col_names = FALSE
)


################################################################################
# FORMAT HEADERS → format_headers
################################################################################

# Formatted headers:
# - Bold
# - Center aligned

write_xlsx(
  airports,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/formatted_header.xlsx",
  format_headers = TRUE
)

# Plain formatted headers

write_xlsx(
  airports,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/plain_formatted_header.xlsx",
  format_headers = FALSE
)


################################################################################
# LARGE FILE SUPPORT → use_zip64
################################################################################

# Create large dataset

big_flights <- bind_rows(
  flights,
  flights,
  flights
)

# Export normal Excel file

write_xlsx(
  big_flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/huge_flights.xlsx"
)

# Enable support for 4GB+ Excel files

write_xlsx(
  big_flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/huge_flights_compressed.xlsx",
  use_zip64 = TRUE
)

# Note:
# Not all platforms support ZIP64 compressed Excel files


################################################################################
# ASSIGNMENTS
################################################################################

# 1. Export the top delayed flights to Excel

# 2. Export monthly reports:
#    month = 1, 2, 3
#    Jan, Feb, March
#    Store inside "monthly_report.xlsx"

# 3. Export summary tables:
#    carrier_summary:
#    average delay + total flights
#
#    dest_summary:
#    average distance + total flights
#
#    Combine into:
#    "summary_report.xlsx"


################################################################################
# ASSIGNMENT SOLUTIONS
################################################################################

# Export the top delayed flights to Excel

top_delayed_flights <- flights |> 
  arrange(desc(dep_delay))

write_xlsx(
  top_delayed_flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/top_delayed_flights.xlsx"
)


################################################################################
# MONTHLY REPORTS
################################################################################

# Filter January, February and March data

monthly_report <- flights |> 
  filter(month %in% c(1, 2, 3))

# Create sheet-wise monthly datasets

monthly_report_list <- list(
  Jan = monthly_report |> filter(month == 1),
  Feb = monthly_report |> filter(month == 2),
  Mar = monthly_report |> filter(month == 3)
)

# Export workbook

write_xlsx(
  monthly_report_list,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/monthly_report.xlsx"
)


################################################################################
# SUMMARY REPORTS
################################################################################

# Carrier summary

carrier_summary <- flights |> 
  group_by(carrier) |> 
  summarise(
    avg_delay = mean(dep_delay, na.rm = TRUE),
    total_flights = n()
  )

# Destination summary

dest_summary <- flights |> 
  group_by(dest) |> 
  summarise(
    avg_dist = mean(distance, na.rm = TRUE),
    total_flights = n()
  )

# Combine sheets

summary_sheets <- list(
  Carrier_Summary = carrier_summary,
  Dest_Summary    = dest_summary
)

# Export workbook

write_xlsx(
  summary_sheets,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/summary_report.xlsx"
)


################################################################################
# READ EXCEL FILE → read_excel()
################################################################################

# Read default first sheet

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/nycflights13.xlsx"
)


################################################################################
# READ SPECIFIC SHEETS
################################################################################

# Read sheet using name

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/nycflights13.xlsx",
  sheet = "Airports"
)

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/nycflights13.xlsx",
  sheet = "Airlines"
)

# Read sheet using index

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/nycflights13.xlsx",
  sheet = 2
)


################################################################################
# READ SPECIFIC RANGE → range
################################################################################

# Read range A1:F10

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/nycflights13.xlsx",
  range = "A1:F10"
)


################################################################################
# SELECT SPECIFIC COLUMNS
################################################################################

# Select columns after reading

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/nycflights13.xlsx"
) |> 
  select(1:4)


################################################################################
# READ COLUMN RANGE → cell_cols()
################################################################################

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/nycflights13.xlsx",
  range = cell_cols("A:D"),
  sheet = 4
)


################################################################################
# READ ROW RANGE → cell_rows()
################################################################################

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/nycflights13.xlsx",
  range = cell_rows(2:10),
  sheet = 4
)


################################################################################
# READ CUSTOM CELL LIMITS → cell_limits()
################################################################################

# Read from A1 to D20

read_excel(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/nycflights13.xlsx",
  range = cell_limits(
    c(1, 1),   # Top-left corner
    c(20, 4)   # Bottom-right corner
  ),
  sheet = 4
)


################################################################################
# KEY TAKEAWAYS
################################################################################

# write_xlsx()      → export Excel files
# read_excel()      → import Excel files
# Multiple sheets   → export list of datasets
# tempfile()        → create temporary Excel files
# col_names         → control column headers
# format_headers    → format Excel headers
# use_zip64         → support large Excel files
# sheet             → read sheet by name/index
# range             → read specific Excel range
# cell_cols()       → select column ranges
# cell_rows()       → select row ranges
# cell_limits()     → custom cell boundaries


#===============================================================================
# END OF FILE
#===============================================================================