#===============================================================================
# Chapter : Advanced Column Operations, Dynamic Programming, and Type Handling
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)
library(lubridate)


################################################################################
# LOAD DATASETS
################################################################################

data("flights")
data("airlines")
data("airports")
data("weather")
data("planes")


################################################################################
# DATA PREVIEW
################################################################################

flights            # prints dataset
View(flights)      # opens viewer

flights <- flights # ❌ invalid / redundant reassignment


################################################################################
# DYNAMIC COLUMN CREATION (TIDY EVALUATION)
################################################################################

# Create column dynamically using !!

col_name <- "new_delay"

flights |> 
  mutate(
    !!col_name := arr_delay * 2,
    .keep = "used"
  )


################################################################################
# COLUMN-WISE OPERATIONS USING across()
################################################################################

flights |> 
  mutate(
    across(c(dep_delay, arr_delay), ~ . / 60),
    .keep = "used"
  )


################################################################################
# RENAMING COLUMNS
################################################################################

# Create new column

flights |> 
  mutate(departure_delay = dep_delay, .keep = "used") |> 
  select(departure_delay)

# Rename existing column

flights |> 
  rename(departure_delay = dep_delay)

# Rename multiple columns using pattern

flights |> 
  rename_with(
    ~ paste0("Departure_", .),
    starts_with("dep_")
  )


################################################################################
# REORDERING DATA
################################################################################

# Sort rows

flights |> 
  arrange(arr_delay, dep_delay)

# Reorder columns

flights |> 
  relocate(arr_delay, dep_delay)

# Move column after another

flights |> 
  relocate(arr_delay, .after = arr_time)


################################################################################
# TYPE CONVERSION
################################################################################

# Individual conversion

flights |> 
  mutate(
    carrier = as.factor(carrier),
    flight  = as.character(flight)
  ) |> 
  glimpse()

# Bulk conversion

flights |> 
  mutate(
    across(where(is.numeric), as.double)
  ) |> 
  glimpse()


################################################################################
# STRING TRANSFORMATIONS
################################################################################

flights |> 
  mutate(
    carrier = str_to_lower(carrier),
    .keep = "used"
  )


################################################################################
# DATE-TIME TRANSFORMATIONS (BASE R)
################################################################################

flights |> 
  select(year, month, day, time_hour) |> 
  mutate(
    date_str = paste(year, month, day, format(time_hour, "%H"), sep = "-"),
    new_time = as.POSIXct(date_str, format = "%Y-%m-%d %H")
  )


################################################################################
# DATE-TIME TRANSFORMATIONS (lubridate)
################################################################################

flights |> 
  select(year, month, day, time_hour) |> 
  mutate(
    flight_date = make_date(year, month, day),
    dep_hour    = hour(time_hour),
    .keep = "used"
  )


################################################################################
# KEY TAKEAWAYS
################################################################################

# !! (bang-bang) → dynamic column creation
# across() → apply functions across multiple columns
# rename() → rename single column
# rename_with() → rename multiple columns dynamically
# arrange() → sort rows
# relocate() → reorder columns
# type conversion → as.factor(), as.character(), as.double()
# string functions → str_to_lower(), etc.
# lubridate → powerful date-time manipulation
# tidy evaluation → enables dynamic programming in dplyr


#===============================================================================
# END OF FILE
#===============================================================================