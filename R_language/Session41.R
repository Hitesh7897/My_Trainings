#===============================================================================
# Chapter 40 : Sorting Data with arrange() in dplyr
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)



################################################################################
# FUNCTION EXAMPLE (PARAMETERS vs ARGUMENTS)
################################################################################

a <- function(a, b, c) {   # Parameters
  a <- 10
  return(sum(...))
}

a(4, 3, 4, 4, 4, 4, 4)    # Arguments

################################################################################
# arrange() FUNCTION SYNTAX
################################################################################

# Syntax
# arrange(.data, ..., .by_group = FALSE)

# S3 method for data.frame
# arrange(.data, ..., .by_group = FALSE, .locale = NULL)

################################################################################
# SORTING DATA USING arrange()
################################################################################

# Ascending order
flights |> 
  arrange(dep_delay) |> 
  select(dep_delay)


# Descending order
flights |> 
  arrange(desc(dep_delay)) |> 
  select(dep_delay)


# Sorting by multiple columns
flights |> 
  arrange(desc(dep_delay), desc(distance)) |> 
  select(dep_delay, distance)

################################################################################
# HANDLING MISSING VALUES
################################################################################

# Count missing values in dataset
colSums(is.na(flights))


# Arrange with missing values
flights |> 
  arrange(arr_delay) |> 
  select(arr_delay) |> 
  tail()

flights |> 
  arrange(desc(arr_delay)) |> 
  select(arr_delay) |> 
  tail()

################################################################################
# BRINGING NA VALUES TO THE TOP
################################################################################

flights |> 
  arrange(!is.na(arr_delay), arr_delay) |> 
  select(arr_delay) |> 
  head()

!is.na(flights$arr_delay)

################################################################################
# BASE R EQUIVALENT
################################################################################

flights[order(flights$arr_delay, na.last = FALSE), "arr_delay"]

################################################################################
# SUMMARY
################################################################################

# arrange()            → Sort rows
# desc()               → Descending order
# arrange(col1,col2)   → Multi-column sorting
# is.na()              → Detect missing values
# !is.na()             → Non-missing values
# order()              → Base R sorting function


#===============================================================================
# END OF FILE
#===============================================================================