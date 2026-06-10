#===============================================================================
# Chapter : ZIP Files & SQLite Database Handling in R
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)
library(readxl)


################################################################################
# SET WORKING DIRECTORY
################################################################################

setwd(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/"
)

getwd()


################################################################################
# ZIP / COMPRESSED FILE HANDLING
################################################################################

# ZIP files are commonly used to package
# multiple files into a single archive


################################################################################
# CREATE SAMPLE DATA
################################################################################

flight_data <- flights |>
  select(
    year,
    month,
    day,
    carrier,
    flight,
    dep_delay
  ) |>
  slice(1:100)

head(flight_data)


################################################################################
# WRITE CSV FILE
################################################################################

write_csv(
  flight_data,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flight_data.csv"
)


################################################################################
# CREATE ZIP FILE
################################################################################

zip(
  zipfile = "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.zip",
  files = "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flight_data.csv"
)


################################################################################
# VIEW ZIP FILE CONTENTS
################################################################################

unzip(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.zip",
  list = TRUE
)


################################################################################
# EXTRACT ZIP FILE
################################################################################

unzip(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.zip",
  exdir = "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/unzipped_data"
)


################################################################################
# READ FILE DIRECTLY FROM ZIP
################################################################################

read.csv(
  unz(
    "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.zip",
    "flight_data.csv"
  )
)


################################################################################
# SQLITE DATABASE HANDLING
################################################################################

# SQLite is a lightweight relational database
# stored in a single file


################################################################################
# INSTALL REQUIRED PACKAGES
################################################################################

install.packages("DBI")
install.packages("RSQLite")


################################################################################
# LOAD PACKAGES
################################################################################

library(DBI)
library(RSQLite)


################################################################################
# CREATE SQLITE CONNECTION
################################################################################

con <- dbConnect(
  SQLite(),
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.sqlite"
)

con


################################################################################
# LIST AVAILABLE TABLES
################################################################################

dbListTables(
  con
)


################################################################################
# WRITE DATA FRAME TO DATABASE
################################################################################

dbWriteTable(
  con,
  "flights",
  flights
)


################################################################################
# WRITE ANOTHER DATA FRAME
################################################################################

dbWriteTable(
  con,
  "airports",
  airports
)


################################################################################
# READ TABLE FROM DATABASE
################################################################################

flights_db <- dbReadTable(
  con,
  "flights"
)

head(flights_db)


################################################################################
# RUN SQL QUERY
################################################################################

dbGetQuery(
  con,
  "
  SELECT *
  FROM flights
  WHERE dep_delay > 60
  LIMIT 10
  "
)


################################################################################
# DISCONNECT DATABASE
################################################################################

dbDisconnect(
  con
)


################################################################################
# CLINICAL TRIAL USE CASE
################################################################################

# External data often arrives as:
# - CSV files
# - Pipe-delimited files
# - Excel files
# - ZIP archives

# Example:
# Study 4534 External Data

# Input:
#   4534_LB.csv
#   4534_PD.csv
#   4534_PK.csv
#   4534_DEVICE.csv

# Convert all files into:
#   4534_External_Data.sqlite

# Database Tables:
#   LB
#   PD
#   PK
#   DEVICE

# Benefits:
# - Single file delivery
# - Faster querying
# - Easy integration with ADM/SDTM workflows
# - Reduced file management overhead


################################################################################
# DATABASE WORKFLOW
################################################################################

# Raw Files
#    ↓
# CSV / TXT / PIPE Files
#    ↓
# SQLite Database
#    ↓
# SQL Queries
#    ↓
# SDTM / ADaM Processing
#    ↓
# Analysis & Reporting


################################################################################
# HDF5 FILES
################################################################################

# HDF5 = Hierarchical Data Format Version 5

# Commonly used for:
# - Large datasets
# - Scientific computing
# - Machine Learning
# - Deep Learning

# Packages:
# install.packages("hdf5r")
# library(hdf5r)


################################################################################
# KEY TAKEAWAYS
################################################################################

# zip()            → create ZIP archive
# unzip()          → extract ZIP archive
# unz()            → read file inside ZIP
# DBI              → database interface package
# RSQLite          → SQLite database package
# dbConnect()      → create database connection
# dbListTables()   → list database tables
# dbWriteTable()   → write data to database
# dbReadTable()    → read database table
# dbGetQuery()     → execute SQL query
# dbDisconnect()   → close database connection
# ZIP              → compressed archive format
# SQLite           → file-based relational database
# HDF5             → large-scale hierarchical data format


#===============================================================================
# END OF FILE
#===============================================================================