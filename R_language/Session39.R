#===============================================================================
# Chapter 38 : Advanced Column Selection in dplyr (select Helpers & Dynamic Selection)
#===============================================================================


################################################################################
# EXCLUDING COLUMNS
################################################################################

# Exclude specific columns
flights |> 
  select(-dep_time, -arr_time, -carrier) |> 
  glimpse()

# Exclude a range of columns
flight_1 <- flights |> 
  select(-(year:day))   # Excluding year through day



################################################################################
# RSTUDIO SHORTCUTS
################################################################################

# Indentation     → Ctrl + I
# Format Document → Ctrl + Shift + A
# Pipe Shortcut   → Ctrl + Shift + M



################################################################################
# RENAMING COLUMNS
################################################################################

flights |> 
  select(
    dep_year  = year,
    dep_month = month,
    dep_day   = day
  ) |> 
  head()



################################################################################
# HELPER FUNCTIONS IN select()
################################################################################

# Starts with specific text
flights |> 
  select(starts_with("dep"))

# Ends with specific text
flights |> 
  select(ends_with("delay"))

# Contains text
flights |> 
  select(contains("time"))

# Regular expression: starts with "arr"
flights |> 
  select(matches("^arr"))

# Multiple regex conditions
flights |> 
  select(matches("delay|time"))

# Case-insensitive search
flights |> 
  select(matches("delay|TIME", ignore.case = TRUE))

# Case-sensitive search
flights |> 
  select(matches("delay|TIME", ignore.case = FALSE))

# Columns ending with "t"
flights |> 
  select(matches("^.*t$"))

# Last column
flights |> 
  select(last_col())

# Second last column
flights |> 
  select(last_col(offset = 1))

# Select first column by position
flights |> 
  select(1)



################################################################################
# SELECT BY DATA TYPE
################################################################################

# Select numeric columns
flights |> 
  select(where(is.numeric))

# Select character columns
flights |> 
  select(where(is.character))

# Exclude numeric columns
flights |> 
  select(!where(is.numeric))

# Alternative syntax
flights |> 
  select(-where(is.numeric))



################################################################################
# SELECT USING LOGICAL VECTOR
################################################################################

flights |> 
  select(which(c(TRUE, FALSE, TRUE, FALSE, FALSE, TRUE)))

flights |> 
  select(which(c(TRUE, TRUE, TRUE, TRUE, TRUE)))



################################################################################
# BASE R COLUMN ACCESS
################################################################################

# Row 2, columns 1 to 5
flights[2, 1:5]

# First 5 column names
head(names(flights), 5)



################################################################################
# DYNAMIC COLUMN SELECTION
################################################################################

col <- c("carrier", "year", "month", "dd")

# Base R
flights[, col]

# all_of() → Every column must exist (otherwise error)
flights |> 
  select(all_of(col))

# any_of() → Select only existing columns (no error)
flights |> 
  select(any_of(col))



################################################################################
# MULTIPLE HELPER COMBINATIONS
################################################################################

# Columns starting with "dep" AND ending with "delay"
flights |> 
  select(starts_with("dep"), ends_with("delay"))

# Exclude columns starting with "dep"
flights |> 
  select(-starts_with("dep"))



################################################################################
# SUMMARY
################################################################################

# select()           → Choose columns
# -column            → Exclude column
# col1:col5          → Column range
# starts_with()      → Prefix match
# ends_with()        → Suffix match
# contains()         → Substring match
# matches()          → Regex match
# last_col()         → Select last column
# where()            → Select by data type
# all_of()           → Strict dynamic selection
# any_of()           → Flexible dynamic selection


#===============================================================================
# END OF FILE
#===============================================================================