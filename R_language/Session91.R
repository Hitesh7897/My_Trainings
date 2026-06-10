#===============================================================================
# Chapter : API Integration, SAS Files, Parquet & Feather Formats in R
#===============================================================================


################################################################################
# LOAD LIBRARIES
################################################################################

library(tidyverse)
library(nycflights13)


################################################################################
# SET WORKING DIRECTORY
################################################################################

setwd(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/"
)

getwd()


################################################################################
# API / REST DATA IMPORT IN R
################################################################################

# API = Application Programming Interface
# REST APIs are commonly used to retrieve
# real-time data from external systems


################################################################################
# INSTALL REQUIRED PACKAGES
################################################################################

install.packages("httr")
install.packages("jsonlite")


################################################################################
# LOAD PACKAGES
################################################################################

library(httr)
library(jsonlite)


################################################################################
# SEND API REQUEST
################################################################################

response <- GET(
  "https://api.data.gov.sg/v1/environment/air-temperature"
)


################################################################################
# CHECK RESPONSE STATUS
################################################################################

status_code(
  response
)


################################################################################
# EXTRACT RESPONSE CONTENT
################################################################################

content_text <- content(
  response,
  as = "text"
)

content_text


################################################################################
# CONVERT JSON TO R OBJECT
################################################################################

json_data <- fromJSON(
  content_text
)

json_data


################################################################################
# CONVERT TO TIBBLE
################################################################################

as_tibble(
  json_data
)


################################################################################
# SAS FILE HANDLING
################################################################################

# SAS datasets:
# .sas7bdat

# SAS Transport files:
# .xpt


################################################################################
# INSTALL REQUIRED PACKAGE
################################################################################

install.packages("haven")


################################################################################
# LOAD PACKAGE
################################################################################

library(haven)


################################################################################
# READ SAS DATASET
################################################################################

read_sas(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/AE.sas7bdat"
)


################################################################################
# CREATE SAMPLE DATA
################################################################################

flight_data <- flights |>
  select(
    year,
    month,
    day,
    dep_time,
    dep_delay
  ) |>
  slice(1:10)

flight_data


################################################################################
# WRITE XPT FILE
################################################################################

write_xpt(
  flight_data,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.xpt"
)


################################################################################
# READ XPT FILE
################################################################################

read_xpt(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.xpt"
)


################################################################################
# PARQUET FILE HANDLING
################################################################################

# Columnar storage format
# Optimized for analytics and big data


################################################################################
# INSTALL / LOAD ARROW PACKAGE
################################################################################

install.packages("arrow")

library(arrow)


################################################################################
# WRITE PARQUET FILE
################################################################################

write_parquet(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/clean_flights.parquet"
)


################################################################################
# READ PARQUET FILE
################################################################################

read_parquet(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/clean_flights.parquet"
)


################################################################################
# PARQUET COMPRESSION OPTIONS
################################################################################

# Snappy Compression

write_parquet(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/snappy_flights.parquet",
  compression = "snappy"
)

# GZIP Compression

write_parquet(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/gzip_flights.parquet",
  compression = "gzip"
)

# ZSTD Compression

write_parquet(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/zstd_flights.parquet",
  compression = "zstd"
)

# No Compression

write_parquet(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/uncompressed_flights.parquet",
  compression = "uncompressed"
)


################################################################################
# PARQUET USE CASES
################################################################################

# Big Data Analytics
# Data Lakes
# Spark Processing
# Hive Integration
# DuckDB Analytics
# Cloud Data Platforms

# Benefits:
# Faster than CSV
# Compressed storage
# Preserves datatypes
# Column-wise reading


################################################################################
# FEATHER FILE HANDLING
################################################################################

# Feather is an Arrow-based format
# Optimized for fast local read/write


################################################################################
# WRITE FEATHER FILE
################################################################################

write_feather(
  flights,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.feather"
)


################################################################################
# READ FEATHER FILE
################################################################################

read_feather(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flights.feather"
)


################################################################################
# FEATHER USE CASES
################################################################################

# Machine Learning Workflows
# Data Science Projects
# Python ↔ R Data Exchange
# Fast Local Storage

# Benefits:
# Extremely fast
# Preserves datatypes
# Lightweight format
# Arrow compatible


################################################################################
# SAS vs PARQUET vs FEATHER
################################################################################

# SAS (.sas7bdat)
# ----------------
# Native SAS format
# Widely used in Clinical Trials
# Supports labels and metadata

# XPT (.xpt)
# ----------
# SAS Transport format
# CDISC submission standard
# FDA submission compatible

# PARQUET (.parquet)
# ------------------
# Big Data format
# Columnar storage
# High compression
# Cloud friendly

# FEATHER (.feather)
# ------------------
# Ultra-fast local storage
# Ideal for ML workflows
# Cross-language compatibility


################################################################################
# CLINICAL PROGRAMMING USE CASE
################################################################################

# Raw Data Sources
# ----------------
# SAS7BDAT Files
# XPT Files
# APIs
# External Vendor Data

# Processing Layer
# ----------------
# R
# Python
# Spark
# DuckDB

# Storage Layer
# -------------
# Parquet
# Feather
# SQLite

# Output Layer
# ------------
# SDTM
# ADaM
# TLFs


################################################################################
# KEY TAKEAWAYS
################################################################################

# httr            → API communication
# GET()           → send HTTP GET request
# status_code()   → check API status
# content()       → extract response content
# jsonlite        → JSON processing
# fromJSON()      → convert JSON to R object
# haven           → SAS file handling
# read_sas()      → read SAS datasets
# write_xpt()     → write XPT files
# read_xpt()      → read XPT files
# arrow           → big data file formats
# write_parquet() → write parquet files
# read_parquet()  → read parquet files
# write_feather() → write feather files
# read_feather()  → read feather files
# API             → external data access
# SAS             → clinical trial data format
# XPT             → CDISC transport format
# Parquet         → big data analytics format
# Feather         → high-speed local format


#===============================================================================
# END OF FILE
#===============================================================================