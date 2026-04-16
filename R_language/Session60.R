#===============================================================================
# Chapter : Lead/Lag Comparisons and Join-Based Filtering in dplyr
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
# LEAD / LAG COMPARISON
################################################################################

# Detect increase compared to previous row

flights |> 
  mutate(
    larger_delay = dep_delay > lag(dep_delay)
  ) |> 
  select(carrier, month, year, day, time_hour, dep_delay, larger_delay) |> 
  tail(10)

################################################################################
# DECREASE COMPARED TO PREVIOUS ROW
################################################################################

# Flights where delay is smaller than previous flight

flights |> 
  filter(dep_delay < lag(dep_delay)) |> 
  select(carrier, month, year, day, time_hour, dep_delay)

################################################################################
# COMPARE WITH NEXT ROW (LEAD)
################################################################################

# Flights where delay is smaller than next flight

flights |> 
  filter(dep_delay < lead(dep_delay)) |> 
  select(carrier, month, year, day, time_hour, dep_delay)

################################################################################
# FILTER USING EXTERNAL LOOKUP (VECTOR)
################################################################################

# Tail numbers after 2010

y2010_tailnum <- planes |> 
  filter(year > 2010) |> 
  select(tailnum) |> 
  distinct() |> 
  pull()

# Filter flights using %in%

flights |> 
  filter(tailnum %in% y2010_tailnum) |> 
  select(carrier, tailnum) |> 
  distinct() |> 
  arrange(carrier)

################################################################################
# FILTER USING LOOKUP TABLE (SEMI JOIN)
################################################################################

# Example lookup tibble

t_tailnum <- tibble(
  tailnum = c("N150UW","N151UW","N152UW","N153UW","N154UW","N155UW","N156UW")
)

# Filter using semi_join()

flights |> 
  semi_join(t_tailnum, by = "tailnum")

################################################################################
# JOIN TYPES COMPARISON
################################################################################

# Example tables

heros <- tribble(
  ~name, ~pub_id,
  "batman", 1,
  "hellboy", 3
)

pubs <- tribble(
  ~pub_id, ~pub_name,
  1, "DC",
  2, "Marvel"
)

# inner_join → matching rows with columns combined
inner_join(heros, pubs, by = "pub_id")

# semi_join → filter rows that have match (no new columns)
semi_join(heros, pubs, by = "pub_id")

# anti_join → rows with no match
anti_join(heros, pubs, by = "pub_id")

# nest_join → nested matches
nested <- nest_join(pubs, heros, by = "pub_id")
View(nested)

################################################################################
# DYNAMIC FILTERING USING LOOKUP TABLE
################################################################################

# Tail numbers after 2010 with additional columns

y2010_tailnum <- planes |> 
  filter(year > 2010) |> 
  select(seats, tailnum)

# Filter flights using semi_join()

flights |> 
  semi_join(y2010_tailnum, by = "tailnum") |> 
  select(carrier, tailnum)

################################################################################
# OTHER USEFUL NOTES
################################################################################

# lag()        → Previous row value
# lead()       → Next row value
# %in%         → Match with vector
# semi_join()  → Filter using another table
# inner_join() → Combine matching rows
# anti_join()  → Find non-matching rows
# nest_join()  → Nested join results

#===============================================================================
# END OF FILE
#===============================================================================