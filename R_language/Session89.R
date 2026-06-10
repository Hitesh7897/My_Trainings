#===============================================================================
# Chapter : HTML & PDF File Handling in R
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
# HTML FILE HANDLING
################################################################################

# HyperText Markup Language (HTML)
# Used to create web pages and reports


################################################################################
# CREATE SIMPLE HTML FILE
################################################################################

html_content <- '
<html>

<head>
<title>My First HTML File</title>
</head>

<body>

<h1>HELLO</h1>

<h2>Flight Report</h2>

<p>
This is a simple HTML file created using R.
</p>

</body>

</html>
'

html_content


################################################################################
# WRITE HTML FILE
################################################################################

writeLines(
  html_content,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/simple.html"
)


################################################################################
# READ HTML FILE
################################################################################

readLines(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/simple.html"
)


################################################################################
# OPEN HTML FILE IN BROWSER
################################################################################

browseURL(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/simple.html"
)


################################################################################
# CREATE HTML TABLE FROM DATA FRAME
################################################################################

df <- flights |>
  select(
    year,
    month,
    day,
    carrier,
    flight,
    dep_delay
  ) |>
  slice(1:10)

df


################################################################################
# LOAD HTML TABLE PACKAGE
################################################################################

library(htmlTable)


################################################################################
# CONVERT DATA FRAME TO HTML TABLE
################################################################################

html_table <- htmlTable(
  df
)

cat(html_table)


################################################################################
# SAVE HTML TABLE
################################################################################

writeLines(
  html_table,
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/table.html"
)


################################################################################
# OPEN HTML TABLE IN BROWSER
################################################################################

browseURL(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/table.html"
)


################################################################################
# WEB SCRAPING HTML TABLES
################################################################################

library(rvest)


################################################################################
# READ WEB PAGE
################################################################################

webpage <- read_html(
  "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"
)

webpage


################################################################################
# EXTRACT HTML TABLES
################################################################################

tables <- html_table(
  webpage
)

length(tables)


################################################################################
# ACCESS FIRST TABLE
################################################################################

country_df <- tables[[1]]

country_df


################################################################################
# PDF FILE HANDLING
################################################################################

# Portable Document Format (PDF)
# Used for reports, charts and tables


################################################################################
# LOAD REQUIRED PACKAGES
################################################################################

library(pdftools)
library(gridExtra)


################################################################################
# CREATE SUMMARY DATA
################################################################################

flight_summary <- flights |>
  group_by(carrier) |>
  summarise(
    avg_delay = mean(
      dep_delay,
      na.rm = TRUE
    ),
    total_flights = n()
  )

flight_summary


################################################################################
# CREATE PDF CHART
################################################################################

pdf(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flight_summary.pdf",
  width = 8,
  height = 6
)


################################################################################
# GENERATE PLOT
################################################################################

plot(
  flight_summary$total_flights,
  flight_summary$avg_delay,
  main = "Flights vs Average Delay",
  xlab = "Total Flights",
  ylab = "Average Delay"
)

text(
  flight_summary$total_flights,
  flight_summary$avg_delay,
  labels = flight_summary$carrier,
  pos = 4
)


################################################################################
# CLOSE PDF FILE
################################################################################

dev.off()


################################################################################
# CREATE PDF TABLE
################################################################################

pdf(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flight_table.pdf",
  width = 10,
  height = 8
)

grid.table(
  head(flight_summary)
)

dev.off()


################################################################################
# EXTRACT TEXT FROM PDF
################################################################################

pdf_text_output <- pdf_text(
  "/home/hitesh/Documents/GitHub/My_Trainings/R_language/files/flight_table.pdf"
)

cat(
  pdf_text_output
)


################################################################################
# HTML vs PDF
################################################################################

# HTML
# ----
# Interactive
# Browser-based
# Supports web content
# Easy to update

# PDF
# ---
# Portable format
# Fixed layout
# Suitable for reports
# Easy to share and print


################################################################################
# KEY TAKEAWAYS
################################################################################

# writeLines()     → write HTML content
# readLines()      → read HTML content
# browseURL()      → open file in browser
# htmlTable()      → create HTML tables
# rvest            → web scraping package
# read_html()      → read HTML page
# html_table()     → extract HTML tables
# pdf()            → create PDF file
# dev.off()        → close PDF file
# grid.table()     → create PDF table
# pdf_text()       → extract text from PDF
# HTML             → web page format
# PDF              → report/document format


#===============================================================================
# END OF FILE
#===============================================================================