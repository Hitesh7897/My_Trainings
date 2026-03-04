#===============================================================================
# Chapter 39 : Column Reordering, relocate(), pull(), Joins & distinct() in dplyr
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)



################################################################################
# COLUMN REORDERING USING select()
################################################################################

# Select specific columns
flights |> 
  select(year, dep_time, arr_time)

# Exclude a column
flights |> 
  select(year, -dep_time, arr_time)

# Move remaining columns to the end
flights |> 
  select(year, -dep_time, arr_time, everything()) |> 
  glimpse()

# Move a column to the end ("James Bond technique")
flights |> 
  select(-year, everything()) |> 
  glimpse()



################################################################################
# VIEWING ROWS
################################################################################

# First 5 rows
flights |> 
  select(-year, everything()) |> 
  head()

# First 10 rows
flights |> 
  select(-year, everything()) |> 
  head(10)

# Last 5 rows
flights |> 
  select(-year, everything()) |> 
  tail(5)



################################################################################
# relocate() – MOVE COLUMNS
################################################################################

# Move columns after another column
flights |> 
  relocate(origin, dest, .after = year)

# Move column before another column
flights |> 
  relocate(distance, .before = air_time)

# Move all character columns to the front
flights |> 
  relocate(where(is.character))

# Move specific column to front
flights |> 
  relocate(carrier) |> 
  glimpse()

# Move columns containing specific text
flights |> 
  relocate(contains("delay"))

# Move character columns to the end
flights |> 
  relocate(where(is.character), .after = last_col()) |> 
  glimpse()



################################################################################
# CONVERTING COLUMNS TO VECTOR
################################################################################

# Extract column as data frame
year_f <- flights |> select(year)

# Convert to vector
typeof(as.vector(year_f))
v_year <- as.vector(year_f)

# pull() directly extracts column as vector
year_p <- flights |> pull(year)
year_p

# pull by index
flights |> pull(4)

# pull last column
flights |> pull(last_col())



################################################################################
# SELECT AFTER JOIN
################################################################################

# Join airline names with flights data
flights |> 
  left_join(airlines, by = "carrier") |> 
  select(carrier, name, dep_delay, arr_delay)



################################################################################
# DISTINCT VALUES
################################################################################

# Unique carriers
flights |> 
  distinct(carrier)

# Unique origin-destination pairs
flights |> 
  select(origin, dest) |> 
  distinct(origin, dest)

# Base R equivalent
unique(flights$carrier)

# Same result using distinct()
flights |> 
  distinct(carrier)



################################################################################
# SUMMARY
################################################################################

# select()        → Select / reorder columns
# everything()    → Keep remaining columns
# relocate()      → Move columns
# pull()          → Extract column as vector
# left_join()     → Merge datasets
# distinct()      → Unique rows


#===============================================================================
# END OF FILE
#===============================================================================