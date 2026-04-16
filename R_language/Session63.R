#===============================================================================
# Chapter : Join Operations in dplyr (inner, left, right, full and more)
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
# DATASET PREVIEW
################################################################################

flights
View(flights)

################################################################################
# TYPES OF JOINS
################################################################################

# Core joins:
# inner_join()
# left_join()
# right_join()
# full_join()

# Additional joins:
# nest_join()
# semi_join()
# anti_join()
# cross_join()
# join_by()

################################################################################
# SAMPLE TABLES
################################################################################

# Table A: Heroes

heroes <- tribble(
  ~name,         ~pub_id,
  "ChotaBeem",    1,
  "BalaGanesh",   3
)

# Table B: Publishers

pubs <- tribble(
  ~pub_id, ~pub_name,
  1,       "ChotaBeem",
  2,       "JaiHanuman"
)

heroes
pubs

################################################################################
# INNER JOIN
################################################################################

# Keep only rows where key exists in both tables

inner_join(heroes, pubs, by = "pub_id")

# Example with flights

flights |> 
  inner_join(airlines, by = "carrier") |> 
  select(carrier, name) |> 
  distinct()

################################################################################
# LEFT JOIN
################################################################################

# Keep all rows from left table (Table A), match from right

left_join(heroes, pubs, by = "pub_id")

# Example with flights

flights |> 
  left_join(airlines, by = "carrier") |> 
  select(carrier, name)

################################################################################
# RIGHT JOIN
################################################################################

# Keep all rows from right table (Table B), match from left

right_join(heroes, pubs, by = "pub_id")

# Example with flights

flights |> 
  right_join(airlines, by = "carrier") |> 
  select(carrier, name)

################################################################################
# FULL JOIN
################################################################################

# Keep all rows from both tables (matched + unmatched)

full_join(heroes, pubs, by = "pub_id")

################################################################################
# OTHER JOIN TYPES
################################################################################

# semi_join() → Keep rows from left that have match in right (no new columns)
semi_join(heroes, pubs, by = "pub_id")

# anti_join() → Keep rows from left that DO NOT have match
anti_join(heroes, pubs, by = "pub_id")

# nest_join() → Nested matching rows
nested <- nest_join(heroes, pubs, by = "pub_id")
View(nested)

# cross_join() → Cartesian product (all combinations)
cross_join(heroes, pubs)

################################################################################
# JOIN BY (MODERN SYNTAX)
################################################################################

# Using join_by() for explicit conditions

inner_join(heroes, pubs, by = join_by(pub_id))

################################################################################
# OTHER USEFUL NOTES
################################################################################

# inner_join() → Matching rows only
# left_join()  → Keep all rows from left
# right_join() → Keep all rows from right
# full_join()  → Keep all rows from both
# semi_join()  → Filter based on existence
# anti_join()  → Find non-matching rows
# cross_join() → All combinations
# join_by()    → Flexible join conditions

#===============================================================================
# END OF FILE
#===============================================================================