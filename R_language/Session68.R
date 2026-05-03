#===============================================================================
# Chapter : Advanced Joins, Mutations, and Join Semantics in dplyr
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)


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

View(flights)
glimpse(flights)
glimpse(weather)


################################################################################
# BASIC NOTES
################################################################################

flights            # prints dataset
View(flights)      # opens viewer

flights <- flights # ❌ invalid / redundant reassignment


################################################################################
# JOIN + MUTATE
################################################################################

flights |> 
  left_join(planes, by = "tailnum") |>
  mutate(age = year.x - year.y) |> 
  select(carrier, tailnum, age)


################################################################################
# HANDLING MISSING VALUES USING coalesce()
################################################################################

flights |> 
  left_join(planes, by = "tailnum") |>
  mutate(age = coalesce((year.x - year.y), 0)) |> 
  select(carrier, tailnum, age)

# Example
x <- c(1, 2, NA, NA, 5, NA)
y <- c(NA, NA, 3, 4, 5, NA)

coalesce(x, 0)


################################################################################
# mutate() vs transmute()
################################################################################

# ❗ coalesce() not directly usable in select()

# ✅ Use transmute()

flights |> 
  left_join(planes, by = "tailnum") |> 
  transmute(carrier, tailnum, age = coalesce((year.x - year.y), 0))

# Notes:
# mutate()    → keeps all existing columns + adds/modifies
# transmute() → keeps only newly created columns


################################################################################
# MEMORY OPTIMIZATION TECHNIQUES
################################################################################

# Reduce columns before join
flights |> 
  select(carrier, tailnum, year, month, day) |> 
  left_join(planes, by = "tailnum", relationship = "many-to-one")

# Reduce rows before join
flights |> 
  select(carrier, tailnum, year, month, day) |> 
  filter(year == 2013) |> 
  left_join(planes, by = "tailnum", relationship = "many-to-one")


################################################################################
# WORKING WITH NESTED DATA
################################################################################

nested <- flights |> 
  group_by(carrier) |> 
  nest()

nested$data
nested$data[[1]]


################################################################################
# JOIN + DISTINCT (ENSURING UNIQUENESS)
################################################################################

planes_unique <- planes |> 
  distinct(tailnum, .keep_all = TRUE)

flights |> 
  left_join(planes_unique, by = join_by(tailnum), relationship = "many-to-one")


################################################################################
# JOIN + WINDOW FUNCTIONS
################################################################################

# Window Functions:
# dense_rank(), min_rank(), percent_rank(), row_number()

flights |> 
  left_join(airlines, by = "carrier") |> 
  group_by(name) |> 
  mutate(rank = dense_rank(desc(arr_delay))) |> 
  ungroup() |> 
  select(carrier, rank, name)


################################################################################
# JOIN CHECKLIST (VERY IMPORTANT)
################################################################################

# ✔ Common keys exist
# ✔ Key data types match
# ✔ Missing values handled
# ✔ Relationship type (one-to-many, etc.)
# ✔ Keys are unique?
# ✔ Expected row count after join?


################################################################################
# JOIN SEMANTICS
################################################################################

?left_join

full_join(
  x,
  y,
  by = NULL,
  copy = FALSE,
  suffix = c(".x", ".y"), 
  ...,
  keep = NULL,
  na_matches = c("na", "never"),
  multiple = "all",
  relationship = NULL
)


################################################################################
# copy PARAMETER
################################################################################

dummy <- tibble(
  carrier = character(10)
)

left_join(flights, dummy, copy = TRUE)
left_join(dummy, flights, copy = TRUE)

# Used when joining data across different sources


################################################################################
# keep PARAMETER
################################################################################

inner_join(
  flights,
  airports,
  by = c("dest" = "faa"),
  keep = TRUE
) |> glimpse()

# Keeps both join keys


################################################################################
# na_matches PARAMETER
################################################################################

# Controls how NA values behave during joins

colSums(is.na(flights))

flights |> 
  inner_join(planes, by = "tailnum", keep = TRUE) |> 
  glimpse() |> 
  select(carrier, tailnum.x, tailnum.y) |> 
  filter(!is.na(tailnum.x))


# Example

student <- tibble(
  id = c(1, 2, NA), 
  name = c("Alice", "Bob", "Unknown")
)

hobbies <- tibble(
  id = c(1, NA), 
  hobby = c("Coding", "Sting")
)

# Default (NA matches NA)
student |> left_join(hobbies, by = "id")

# Explicit NA matching
student |> left_join(hobbies, by = "id", na_matches = "na")

# NA never matches
student |> left_join(hobbies, by = "id", na_matches = "never")


################################################################################
# KEY TAKEAWAYS
################################################################################

# coalesce() → handle missing values
# transmute() → memory-efficient transformations
# Reduce data before joins (columns + rows)
# Validate join relationships
# Use distinct() to avoid duplication
# Understand join parameters (copy, keep, na_matches)
# Window functions + joins = powerful analytics


#===============================================================================
# END OF FILE
#===============================================================================