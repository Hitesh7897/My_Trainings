#===============================================================================
# Chapter 37 : Data Frame vs Tibble & dplyr Data Manipulation
#===============================================================================


################################################################################
# LOAD REQUIRED LIBRARIES
################################################################################

library(tidyverse)   # Modern data manipulation framework
library(nycflights13)


################################################################################
# DATA FRAME vs TIBBLE
################################################################################

# Base R Data Frame
my_df <- data.frame(
  name = c("A", "B", "C"),
  age  = c(32, 32, 43)
)

my_df
str(my_df)


# Tibble (Modern data frame)
my_df_tib <- tibble(
  name = c("A", "B", "C"),
  age  = c(32, 32, 43)
)

my_df_tib


################################################################################
# tribble() – Clean Table Creation (Row-wise)
################################################################################
# tribble = "Transposed Tibble"
# Easiest way to manually create small tables

my_trib <- tribble(
  ~name,  ~age,
  "swet", 32,
  "bo",   32,
  "ram",  44
)

my_trib


################################################################################
# WHY TIDYVERSE / dplyr?
################################################################################
# tidyverse = Modern R Data Language
# Cleaner syntax
# Readable pipelines
# Better printing
# Safer column selection

flights
View(flights)


################################################################################
# BASE R FILTERING (OLD STYLE)
################################################################################

# Capture only year, month, day
flights_m <- flights[, c("year", "month", "day")]

# Filter month == 1
flights_m[which(flights_m$month == 1), ]



################################################################################
# dplyr SELECT + FILTER
################################################################################

# Select specific columns
flights_m1 <- select(flights, year, month, day)

# Filter month == 1
filter(flights_m1, month == 1)



################################################################################
# PIPE OPERATOR (%>%) – Tidyverse Pipe
################################################################################

# Enhanced readable workflow
flights %>%
  select(year, month, day) %>%
  filter(month == 1) %>%
  glimpse()


################################################################################
# NATIVE R PIPE (|>) – R 4.1+
################################################################################

flight_ga <- flights |>
  select(year, month, day) |>
  filter(month == 1) |>
  glimpse()



################################################################################
# QUERYING DATA WITH select()
################################################################################

class(flights)
glimpse(flights)

# Select specific columns
select(flights, dep_time, arr_time, carrier)

# Modern pipe (Ctrl + Shift + M in RStudio)
flights |> select(dep_time)

# Multiple columns
flights |> select(dep_time, arr_time, carrier)



################################################################################
# SELECT BY COLUMN POSITION
################################################################################

# Select column range by name
flights |> select(flight:dest)

# Select by index range
flights |> select(11:14)

# Select specific index positions
flights |> select(2, 7, 10)

# Mixed index selection
flights |> select(3, 11:14)



################################################################################
# EXCLUDING COLUMNS
################################################################################

# Exclude specific columns
flights |> select(-dep_time, -arr_time, -carrier) |> glimpse()

# Exclude range of columns
flight_1 <- flights |> select(-(year:day))



################################################################################
# SUMMARY
################################################################################

# data.frame → Base R traditional structure
# tibble     → Modern safer data frame
# tribble()  → Quick manual table creation
# select()   → Choose columns
# filter()   → Filter rows
# %>%        → Tidyverse pipe
# |>         → Native R pipe
# -colname   → Exclude columns
# col1:col5  → Select column range


#===============================================================================
# END OF FILE
#===============================================================================