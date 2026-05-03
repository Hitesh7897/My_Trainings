#===============================================================================
# Chapter : Subqueries, Joins vs Subqueries, and Data Combination in dplyr
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

flights            # prints dataset
View(flights)      # opens viewer

flights <- flights # ❌ invalid / redundant reassignment


################################################################################
# NESTED SUBQUERY EXAMPLE
################################################################################

flights |> 
  filter(dest %in% (                     # Query 1
    airports |> 
      filter(
        faa %in% (                      # Query 2
          flights |>                    # Query 3
            filter(arr_delay > 60) |> 
            pull(dest)
        )
      ) |> 
      pull(faa)
  ))


################################################################################
# SUBQUERY WITH EXISTS LOGIC (SQL EQUIVALENT)
################################################################################

# EXISTS → semi_join()

flights |> 
  semi_join(weather, by = c("origin", "time_hour"))


################################################################################
# WINDOW-STYLE SUBQUERY (RANKING)
################################################################################

flights |> 
  group_by(dest) |> 
  mutate(
    rank = dense_rank(desc(arr_delay)),
    .keep = "none"
  ) |> 
  filter(rank <= 3)


################################################################################
# SUBQUERY vs JOIN (WHEN TO USE WHAT)
################################################################################

# %in%        → value lookup
# semi_join() → EXISTS
# anti_join() → NOT EXISTS
# left_join() → add columns
# mutate()    → derived variables


################################################################################
# WHEN NOT TO USE SUBQUERIES
################################################################################

# ❌ Multiple columns involved → use joins
# ❌ Performance critical → joins are faster
# ❌ Deep nesting → prefer pipe workflow
# ❌ Complex logic → joins improve readability

# Note: Subqueries are not primary in dplyr workflows


################################################################################
# DATA COMBINATION TECHNIQUES
################################################################################

#-------------------------------------------------------------------------------
# ROW-WISE COMBINATION → bind_rows()
#-------------------------------------------------------------------------------

# Use when columns are same (or compatible)

jan_flights <- flights |> filter(month == 1)
feb_flights <- flights |> filter(month == 2)

combined_rows <- bind_rows(jan_flights, feb_flights)

# Key concepts:
# - Automatically aligns columns
# - Missing columns filled with NA


#-------------------------------------------------------------------------------
# COLUMN-WISE COMBINATION → bind_cols()
#-------------------------------------------------------------------------------

# Use when number of rows is same

df1 <- flights |> select(flight, origin)
df2 <- flights |> select(dest, air_time)

nrow(df1)
nrow(df2)

combined_cols <- bind_cols(df1, df2)

# ⚠ Risk:
# - No key matching
# - Purely position-based combination


################################################################################
# SET OPERATIONS
################################################################################

# Rules:
# - Same column names
# - Same data types

a <- tibble(
  id = c(1, 2, 3, 4),
  name = c("ganesh", "Ravi", "Sita", "Anu")
)

b <- tibble(
  id = c(3, 4, 5, 6),
  name = c("Sita", "Anu", "Kiran", "John")
)

print(a)
print(b)


#-------------------------------------------------------------------------------
# union() → unique rows
#-------------------------------------------------------------------------------

union(a, b)


#-------------------------------------------------------------------------------
# union_all() → keep all rows (including duplicates)
#-------------------------------------------------------------------------------

union_all(a, b)


#-------------------------------------------------------------------------------
# intersect() → common rows
#-------------------------------------------------------------------------------

intersect(a, b)


#-------------------------------------------------------------------------------
# setdiff() → rows in A but not in B
#-------------------------------------------------------------------------------

setdiff(a, b)
setdiff(b, a)


#-------------------------------------------------------------------------------
# symdiff() → exclusive rows (A or B but not both)
#-------------------------------------------------------------------------------

symdiff(a, b)

# Equivalent logic:
# union(a, b) - intersect(a, b)


################################################################################
# KEY TAKEAWAYS
################################################################################

# semi_join() → EXISTS logic
# anti_join() → NOT EXISTS logic
# %in% → simple lookup
# bind_rows() → stack datasets
# bind_cols() → combine by position (use carefully)
# set operations → union, intersect, setdiff, symdiff
# prefer joins over nested subqueries in complex workflows


#===============================================================================
# END OF FILE
#===============================================================================