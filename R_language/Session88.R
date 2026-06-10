#===============================================================================
# Chapter : JSON, XML & YAML File Handling in R
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)


################################################################################
# INSTALL REQUIRED PACKAGES
################################################################################

install.packages("jsonlite")
install.packages("xml2")
install.packages("yaml")


################################################################################
# LOAD PACKAGES
################################################################################

library(jsonlite)
library(xml2)
library(yaml)


################################################################################
# SET WORKING DIRECTORY
################################################################################

setwd(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/"
)

getwd()


################################################################################
# JSON FILE HANDLING
################################################################################

# JavaScript Object Notation (JSON)
# Widely used for APIs and data exchange


################################################################################
# CREATE SAMPLE DATA
################################################################################

flights_data <- flights |>
  slice(1:10)

flights_data


################################################################################
# WRITE JSON FILE
################################################################################

write_json(
  flights_data,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.json"
)


################################################################################
# READ JSON FILE
################################################################################

read_json(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.json"
)


################################################################################
# CONVERT JSON TO DATA FRAME
################################################################################

fromJSON(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.json"
)


################################################################################
# XML FILE HANDLING
################################################################################

# Extensible Markup Language (XML)
# Commonly used for hierarchical data exchange


################################################################################
# CREATE SAMPLE DATA FOR XML
################################################################################

flights_small <- flights |>
  select(
    year,
    month,
    day,
    carrier,
    flight,
    origin,
    dest
  ) |>
  slice(1:10)

flights_small


################################################################################
# CREATE XML ROOT NODE
################################################################################

root <- xml_new_root("flights")


################################################################################
# ADD CHILD NODES
################################################################################

for (i in 1:nrow(flights_small)) {
  
  flight_node <- xml_add_child(
    root,
    "flight"
  )
  
  xml_add_child(
    flight_node,
    "year",
    flights_small$year[i]
  )
  
  xml_add_child(
    flight_node,
    "month",
    flights_small$month[i]
  )
  
  xml_add_child(
    flight_node,
    "day",
    flights_small$day[i]
  )
  
  xml_add_child(
    flight_node,
    "carrier",
    flights_small$carrier[i]
  )
  
  xml_add_child(
    flight_node,
    "flight",
    flights_small$flight[i]
  )
  
  xml_add_child(
    flight_node,
    "origin",
    flights_small$origin[i]
  )
  
  xml_add_child(
    flight_node,
    "dest",
    flights_small$dest[i]
  )
  
}


################################################################################
# WRITE XML FILE
################################################################################

write_xml(
  root,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.xml"
)


################################################################################
# READ XML FILE
################################################################################

xml_data <- read_xml(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.xml"
)

xml_data


################################################################################
# CONVERT XML TO LIST
################################################################################

xml_list <- as_list(
  xml_data
)

xml_list


################################################################################
# CONVERT XML TO TIBBLE
################################################################################

xml_df <- as_tibble(
  xml_list
) |>
  unnest_wider(flights) |>
  unnest_longer(everything())

xml_df


################################################################################
# YAML FILE HANDLING
################################################################################

# YAML Ain't Markup Language
# Human-readable configuration format


################################################################################
# CONVERT DATA FRAME TO LIST
################################################################################

flight_list <- split(
  flights_small,
  seq(nrow(flights_small))
)

flight_list


################################################################################
# WRITE YAML FILE
################################################################################

write_yaml(
  flight_list,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.yaml"
)


################################################################################
# VIEW YAML CONTENT
################################################################################

cat(
  readLines(
    "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.yaml"
  ),
  sep = "\n"
)


################################################################################
# READ YAML FILE
################################################################################

read_yaml(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.yaml"
)


################################################################################
# JSON vs XML vs YAML
################################################################################

# JSON
# ----
# Lightweight
# API friendly
# Easy to parse
# Compact format

# XML
# ---
# Hierarchical structure
# Supports attributes
# Widely used in enterprise systems
# More verbose than JSON

# YAML
# ----
# Human-readable
# Configuration files
# Less punctuation
# Easy to edit manually


################################################################################
# KEY TAKEAWAYS
################################################################################

# jsonlite         → JSON file handling
# write_json()     → write JSON files
# read_json()      → read JSON files
# fromJSON()       → convert JSON to data frame/list
# xml2             → XML file handling
# xml_new_root()   → create XML root node
# xml_add_child()  → add XML child nodes
# write_xml()      → write XML files
# read_xml()       → read XML files
# as_list()        → convert XML to list
# yaml             → YAML file handling
# write_yaml()     → write YAML files
# read_yaml()      → read YAML files
# JSON             → API/data exchange format
# XML              → hierarchical markup format
# YAML             → configuration/data serialization format


#===============================================================================
# END OF FILE
#===============================================================================