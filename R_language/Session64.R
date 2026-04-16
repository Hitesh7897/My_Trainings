#===============================================================================
# Chapter : Advanced Joins, Nested Joins and join_by() in dplyr
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

heroes <- tribble(
  ~name,         ~pub_id,
  "ChotaBeem",    1,
  "BalaGanesh",   3
)

pubs <- tribble(
  ~pub_id, ~pub_name,
  1,       "ChotaBeem",
  2,       "JaiHanuman"
)

heroes
pubs

################################################################################
# NEST JOIN
################################################################################

# Keeps left table intact and nests matching rows from right

x <- nest_join(pubs, heroes, by = "pub_id")

x
x$heroes[[1]]   # Matches for pub_id = 1
x$heroes[[2]]   # Matches for pub_id = 2 (likely empty)

################################################################################
# FILTER JOINS
################################################################################

# semi_join() → Keep matching rows (no new columns)

semi_join(heroes, pubs, by = "pub_id")

# anti_join() → Keep non-matching rows

anti_join(heroes, pubs, by = "pub_id")

################################################################################
# CROSS JOIN
################################################################################

# Cartesian product (all combinations)

cross_join(heroes, pubs)

################################################################################
# JOIN_BY (MODERN FLEXIBLE JOINS)
################################################################################

# Basic usage
inner_join(heroes, pubs, by = join_by(pub_id))

?join_by

################################################################################
# NON-EQUI JOIN (RANGE JOIN)
################################################################################

sales <- tibble(
  id = c(1L, 1L, 1L, 2L, 2L),
  sale_date = as.Date(c("2018-12-31", "2019-01-02", "2019-01-05", "2019-01-04", "2019-01-01"))
)

promos <- tibble(
  id = c(1L, 1L, 2L),
  promo_date = as.Date(c("2019-01-01", "2019-01-05", "2019-01-02"))
)

sales
promos

# Join where sale_date >= promo_date (non-equi join)

by <- join_by(id, sale_date >= promo_date)

left_join(sales, promos, by)

################################################################################
# JOIN WITH SAME COLUMN NAME
################################################################################

flights |> 
  left_join(airlines, by = "carrier")

################################################################################
# JOIN WITH DIFFERENT COLUMN NAMES
################################################################################

# dest (flights) ↔ faa (airports)

flights |> 
  left_join(airports, by = c("dest" = "faa")) |> 
  select(dest, month, year, day, name)

# Example check
filter(airports, faa == "ATL")

################################################################################
# JOIN USING MULTIPLE KEYS
################################################################################

# Joining flights with weather on origin and time_hour

flights |> 
  left_join(weather, by = c("origin", "time_hour"))

################################################################################
# OTHER USEFUL NOTES
################################################################################

# nest_join() → Nested results (list-column)
# semi_join() → Filter matching rows
# anti_join() → Filter non-matching rows
# cross_join()→ All combinations
# join_by()   → Flexible join conditions (including inequalities)

#===============================================================================
# END OF FILE
#===============================================================================