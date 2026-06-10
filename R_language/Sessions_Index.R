#===============================================================================
# R TRAINING – SESSION-WISE TABLE OF CONTENTS
#===============================================================================


#-------------------------------------------------------------------------------
# SESSION 1 : Objects & Data Structures
#-------------------------------------------------------------------------------
# - Everything is an object (type, class, attributes)
# - typeof(), class(), attributes()
# - Scalars vs Vectors
# - Type coercion in vectors
# - Matrix
# - List
# - Data frame (as list)
# - Factor (levels, internal representation)
# - typeof vs class difference
# - Functions (built-in & user-defined)
# - Operators as functions
# - OOP basics (S3 intro)


#-------------------------------------------------------------------------------
# SESSION 2 : Input, Output & Functions
#-------------------------------------------------------------------------------
# - print(), cat()
# - Custom functions
# - readline() input
# - scan() input
# - Type conversion from input
# - Help system (help(), ?, example(), demo())
# - Tokens & keywords
# - Comments
# - Expression basics
# - S3 OOP (UseMethod)
# - S4 OOP basics (setClass)


#-------------------------------------------------------------------------------
# SESSION 3 : Packages & Environment
#-------------------------------------------------------------------------------
# - available.packages(), installed.packages()
# - library(), require()
# - pacman (p_load)
# - .libPaths()
# - getwd(), setwd()
# - str(), summary(), glimpse()
# - Built-in datasets (data())
# - Writing files (write_xlsx)
# - search() (environment)
# - options(), help()
# - Command history


#-------------------------------------------------------------------------------
# SESSION 4 : Variables & Scope
#-------------------------------------------------------------------------------
# - Assignment (<-, =, ->)
# - Multiple assignment
# - Variable naming rules
# - Naming conventions
# - Global vs Local variables
# - Scope inside functions


#-------------------------------------------------------------------------------
# SESSION 5 : Data Types & Constants
#-------------------------------------------------------------------------------
# - Constants concept (uppercase convention)
# - Logical, Numeric, Integer, Complex, Character, Raw
# - Type checking (is.logical, is.numeric)
# - Integer vs Numeric memory
# - Integer overflow
# - Raw data type
# - Typed NA (NA_character_, NA_integer_, etc.)
# - Difference between NA and ""


#-------------------------------------------------------------------------------
# SESSION 6 : Dates, NULL vs NA & Lists
#-------------------------------------------------------------------------------
# - as.Date(), POSIXct, POSIXlt
# - Date formatting
# - NULL behavior
# - NA vs NULL comparison
# - Logical comparisons
# - Character data type
# - Type coercion rules
# - Lists (mixed types)


#-------------------------------------------------------------------------------
# SESSION 7 : Arrays, Factors & Data Frames
#-------------------------------------------------------------------------------
# - Arrays (1D → 5D)
# - Array indexing
# - Factors (levels)
# - Data frame structure
# - tibble introduction


#-------------------------------------------------------------------------------
# SESSION 8 : NA Handling & Coercion
#-------------------------------------------------------------------------------
# - NA in arithmetic
# - paste() vs cat() behavior with NA
# - Scalar vs vector
# - Type coercion in vectors
# - as.integer(), as.character()
# - Typed NA in tibbles
# - NULL vs NA
# - is.na()


#-------------------------------------------------------------------------------
# SESSION 9 : Strings & Copy-on-Modify
#-------------------------------------------------------------------------------
# - stringr::str_c()
# - paste(), paste0()
# - NA handling differences
# - collapse vs sep
# - Copy-on-modify concept
# - Memory behavior (tracemem)
# - Mutable vs immutable discussion


#-------------------------------------------------------------------------------
# SESSION 10 : Type Conversion (Basics)
#-------------------------------------------------------------------------------
# - Type hierarchy
# - Implicit coercion
# - Explicit conversion (as.numeric, as.integer)
# - Logical ↔ Numeric conversion
# - NULL vs NA behavior
# - Conversion rules


#-------------------------------------------------------------------------------
# SESSION 11 : Type Conversion (Advanced)
#-------------------------------------------------------------------------------
# - Character conversions
# - Integer conversions
# - Numeric conversions
# - Logical conversions
# - Factor conversion pitfalls
# - Real-world examples


#-------------------------------------------------------------------------------
# SESSION 12 : Missing Values & Date-Time
#-------------------------------------------------------------------------------
# - NA, NaN, Inf
# - Date conversion (as.Date, POSIXct, POSIXlt)
# - Conversion inside data frames
# - Matrix vs list coercion
# - Type testing utilities


#-------------------------------------------------------------------------------
# SESSION 13 : Operators (Complete)
#-------------------------------------------------------------------------------
# - Arithmetic operators
# - Assignment operators
# - Relational operators
# - Logical operators
# - Special operators (%in%, %*%)
# - Custom infix operators
# - Subsetting operators
# - Tidyverse helpers (between, near)


#-------------------------------------------------------------------------------
# SESSION 14 : Subsetting & Bitwise
#-------------------------------------------------------------------------------
# - [], [[]], $ operators
# - Vector subsetting
# - List subsetting
# - Data frame subsetting
# - if_any(), if_all()
# - is.na(), !is.na()
# - Bitwise operators
# - Operator precedence


#-------------------------------------------------------------------------------
# SESSION 15 : Operator Precedence & Associativity
#-------------------------------------------------------------------------------
# - Associativity rules
# - Right-to-left vs left-to-right
# - Exponentiation behavior
# - Logical precedence
# - Copy-on-modify (memory)
# - Complex expressions evaluation


#-------------------------------------------------------------------------------
# SESSION 16 : Built-in Functions & Stats
#-------------------------------------------------------------------------------
# - sum(), mean(), median(), sd()
# - rounding (round, ceiling, floor)
# - sorting (order, sort, rank)
# - cumulative functions
# - number systems (binary, octal, hex)
# - UTF-8 encoding
# - Sys.time() formatting


#-------------------------------------------------------------------------------
# SESSION 17 : Random Numbers & Sequences
#-------------------------------------------------------------------------------
# - runif()
# - sample()
# - floor(), ceiling(), trunc()
# - seq(), rep()
# - any(), all()
# - diff(), lag()


#-------------------------------------------------------------------------------
# SESSION 18 : Formatting & Precision
#-------------------------------------------------------------------------------
# - format(), formatC(), sprintf()
# - Floating point precision issues
# - all.equal()
# - Handling Inf, NaN
# - string basics
# - nchar() vs length()


#-------------------------------------------------------------------------------
# SESSION 19 : Strings Deep Dive
#-------------------------------------------------------------------------------
# - Empty string vs NA
# - character() initialization
# - Quotes handling
# - print() vs cat()
# - paste(), paste0()
# - collapse vs sep


#-------------------------------------------------------------------------------
# SESSION 20 : sprintf() Formatting
#-------------------------------------------------------------------------------
# - sprintf() basics
# - Format specifiers (%s, %d, %f)
# - Decimal precision
# - Padding & alignment
# - Scientific notation
# - Vectorized formatting
# - substr()


#-------------------------------------------------------------------------------
# SESSION 21 : Regex Basics & Escape Characters
#-------------------------------------------------------------------------------
# - substr(), substring()
# - Escape characters (\n, \t, \r, \\, \', \")
# - cat() formatting tricks
# - Regex basics using Base R (gregexpr, regmatches)
# - stringr introduction
# - Special characters (., ^, $, [], |)
# - Quantifiers (?, *, +, {n})
# - Digit extraction (\d)
# - Word matching (\w)
# - Uppercase pattern matching


#-------------------------------------------------------------------------------
# SESSION 22 : Regex Deep Dive (stringr)
#-------------------------------------------------------------------------------
# - Regex building blocks
# - str_extract(), str_detect(), str_extract_all()
# - Character classes ([ ])
# - Quantifiers (?, *, +, {n})
# - Digit, word, whitespace shortcuts (\d, \w, \s)
# - Date validation patterns
# - Lab unit extraction
# - Clinical data cleaning use cases


#-------------------------------------------------------------------------------
# SESSION 23 : Regex Special Characters (grep)
#-------------------------------------------------------------------------------
# - Dot (.) wildcard
# - ^ start of string
# - $ end of string
# - * zero or more
# - + one or more
# - ? optional
# - grep() vs str_subset()
# - Pattern pitfalls (a* matching everything)


#-------------------------------------------------------------------------------
# SESSION 24 : Regex Validation & Anchors
#-------------------------------------------------------------------------------
# - ?, *, + behavior in validation
# - Anchors (^, $)
# - Why * and ? are dangerous
# - Best practice using +
# - Product code validation
# - Clinical ID validation (USUBJID)


#-------------------------------------------------------------------------------
# SESSION 25 : Regex Grouping & Character Classes
#-------------------------------------------------------------------------------
# - Grouping () for OR conditions
# - Character class []
# - Exact repetition {}
# - Escaping special characters
# - Negative character class [^]
# - Perl regex classes (\d, \w, \s)
# - POSIX classes ([[:digit:]], [[:alpha:]])


#-------------------------------------------------------------------------------
# SESSION 26 : String Functions (Base + stringr)
#-------------------------------------------------------------------------------
# - nchar(), length(), str_length()
# - paste(), paste0(), sprintf(), str_glue()
# - Case conversion (toupper, str_to_upper, etc.)
# - Trimming (trimws, str_trim, str_squish)
# - Substring extraction
# - Replace (sub, gsub, str_replace)
# - Real-world text cleaning


#-------------------------------------------------------------------------------
# SESSION 27 : String Ops + Control Flow
#-------------------------------------------------------------------------------
# - strsplit(), str_split()
# - String comparison (==, identical)
# - Sorting strings
# - if, if-else, if-else-if
# - switch()
# - for loop, while loop
# - Nested loops


#-------------------------------------------------------------------------------
# SESSION 28 : Control Flow + Apply Family
#-------------------------------------------------------------------------------
# - for, while, repeat loops
# - break, next
# - Nested loops
# - apply()
# - lapply(), sapply(), vapply()
# - tapply(), mapply()
# - Clinical dataset examples


#-------------------------------------------------------------------------------
# SESSION 29 : Apply Family (Deep Dive)
#-------------------------------------------------------------------------------
# - apply() (row vs column)
# - lapply() (list output)
# - sapply() (simplified output)
# - vapply() (type-safe)
# - tapply() (group-wise)
# - mapply() (multi-argument)
# - Functional programming basics


#-------------------------------------------------------------------------------
# SESSION 30 : Functions – Basics
#-------------------------------------------------------------------------------
# - Function syntax
# - Arguments vs parameters
# - return()
# - Functions without arguments
# - Built-in vs custom functions
# - Functions inside loops
# - Returning character vs numeric
# - Returning multiple values (list)


#-------------------------------------------------------------------------------
# SESSION 31 : Functions – Scope & Overriding
#-------------------------------------------------------------------------------
# - Function overriding
# - No function overloading in R
# - LEGB rule (Local, Enclosing, Global, Built-in)
# - Nested functions
# - Global assignment (<<-)


#-------------------------------------------------------------------------------
# SESSION 32 : Functions – Advanced Concepts
#-------------------------------------------------------------------------------
# - Multiple return values via list
# - Nested functions
# - do.call()
# - Default arguments
# - Named arguments
# - Variable number of arguments


#-------------------------------------------------------------------------------
# SESSION 33 : Lazy Evaluation & Debugging
#-------------------------------------------------------------------------------
# - Lazy evaluation
# - Anonymous functions
# - Function environments
# - debug()
# - stop(), warning(), message()
# - try() for error handling


#-------------------------------------------------------------------------------
# SESSION 34 : Exception Handling
#-------------------------------------------------------------------------------
# - message(), warning(), stop()
# - try()
# - tryCatch()
# - finally block
# - Custom error classes
# - withCallingHandlers()
# - suppressWarnings(), suppressMessages()


#-------------------------------------------------------------------------------
# SESSION 35 : Production Error Handling & Packages
#-------------------------------------------------------------------------------
# - stopifnot()
# - Defensive programming
# - Production-safe scripts
# - Global error options
# - Package management
# - Namespace (::)


#-------------------------------------------------------------------------------
# SESSION 36 : Tidyverse Introduction
#-------------------------------------------------------------------------------
# - tidyverse overview
# - dplyr basics
# - nycflights13 dataset
# - tibble vs data.frame
# - glimpse(), str()


#-------------------------------------------------------------------------------
# SESSION 37 : dplyr Basics
#-------------------------------------------------------------------------------
# - select()
# - filter()
# - Pipe operator (%>% and |>)
# - Base R vs dplyr comparison
# - Column selection techniques


#-------------------------------------------------------------------------------
# SESSION 38 : Advanced Column Selection
#-------------------------------------------------------------------------------
# - select helpers (starts_with, ends_with, contains)
# - matches() with regex
# - where() for type-based selection
# - all_of(), any_of()
# - Dynamic column selection


#-------------------------------------------------------------------------------
# SESSION 39 : Column Manipulation & Joins
#-------------------------------------------------------------------------------
# - select() advanced usage
# - relocate()
# - pull()
# - left_join()
# - distinct()
# - column reordering


#-------------------------------------------------------------------------------
# SESSION 40 : (Continuation – dplyr operations)
#-------------------------------------------------------------------------------
# - Advanced column handling
# - Viewing data (head, tail)
# - Column movement strategies
# - Data extraction as vectors


#-------------------------------------------------------------------------------
# SESSION 41 : Sorting with arrange()
#-------------------------------------------------------------------------------
# - arrange() (ascending & descending)
# - desc()
# - Sorting multiple columns
# - Handling NA in sorting
# - Bringing NA to top (!is.na())
# - Base R equivalent (order())


#-------------------------------------------------------------------------------
# SESSION 42 : Group-wise Sorting & Top-N
#-------------------------------------------------------------------------------
# - Sorting derived columns
# - arrange() with groups (.by_group)
# - slice_max(), slice_min()
# - Top-N per group
# - Second highest value extraction


#-------------------------------------------------------------------------------
# SESSION 43 : Ranking & Aggregation
#-------------------------------------------------------------------------------
# - group_by() + summarise()
# - Ranking functions:
#   row_number(), min_rank(), dense_rank(), percent_rank()
# - Ranking airlines by delay
# - Ranking within dataset


#-------------------------------------------------------------------------------
# SESSION 44 : Filtering & Slicing Basics
#-------------------------------------------------------------------------------
# - filter() with conditions
# - AND, OR, %in%
# - mutate() inside filter
# - slice(), slice_head(), slice_tail()
# - slice_min()


#-------------------------------------------------------------------------------
# SESSION 45 : Advanced Slicing & Sampling
#-------------------------------------------------------------------------------
# - slice_min(), slice_max()
# - slice_sample()
# - Sampling by proportion
# - rowSums() with across()
# - Optimization concepts (big data thinking)


#-------------------------------------------------------------------------------
# SESSION 46 : Row-wise Operations & across()
#-------------------------------------------------------------------------------
# - rowSums() vs sum()
# - across() usage
# - Formula (~) syntax
# - Row-wise filtering
# - Logical aggregation across columns


#-------------------------------------------------------------------------------
# SESSION 47 : Logical Operations with across()
#-------------------------------------------------------------------------------
# - Logical transformations across columns
# - TRUE/FALSE → numeric behavior
# - rowSums() with logical conditions
# - Real dataset filtering


#-------------------------------------------------------------------------------
# SESSION 48 : Filtering & Missing Values
#-------------------------------------------------------------------------------
# - Comparison operators (==, !=, >, <)
# - Logical operators (&, |, !)
# - NA handling:
#   is.na(), drop_na()
# - coalesce()
# - Missing data analysis


#-------------------------------------------------------------------------------
# SESSION 49 : Row-wise Mean & Proportions
#-------------------------------------------------------------------------------
# - rowwise()
# - Row vs column mean
# - group_by() + n()
# - Proportion calculation
# - distinct()


#-------------------------------------------------------------------------------
# SESSION 50 : if_any(), if_all(), if_else()
#-------------------------------------------------------------------------------
# - if_any(), if_all()
# - if_else() vs ifelse()
# - Conditional filtering
# - across() transformations


#-------------------------------------------------------------------------------
# SESSION 51 : Range Filtering & Aggregations
#-------------------------------------------------------------------------------
# - between()
# - %in% with ranges
# - min(), max(), range()
# - quantile-based filtering
# - Dynamic column selection (.data)


#-------------------------------------------------------------------------------
# SESSION 52 : Group-wise Filtering & Distinct
#-------------------------------------------------------------------------------
# - filter() with group aggregation
# - distinct()
# - n_distinct()
# - First row per group
# - Summarisation techniques


#-------------------------------------------------------------------------------
# SESSION 53 : Proportion Filtering & Window Functions
#-------------------------------------------------------------------------------
# - mean(is.na()) for proportions
# - Window functions:
#   row_number(), min_rank(), dense_rank()
# - Top-N per group
# - Ranking with ties


#-------------------------------------------------------------------------------
# SESSION 54 : Percentiles & Categorization
#-------------------------------------------------------------------------------
# - percent_rank()
# - cume_dist()
# - Percentile filtering
# - case_when() categorization


#-------------------------------------------------------------------------------
# SESSION 55 : Mapping & String Filtering
#-------------------------------------------------------------------------------
# - Lookup tables (deframe())
# - Mapping values
# - near() for numeric comparison
# - str_detect(), str_starts(), str_ends()
# - Regex filtering


#-------------------------------------------------------------------------------
# SESSION 56 : Regex + Group Metrics
#-------------------------------------------------------------------------------
# - Regex pattern filtering
# - str_extract(), str_replace()
# - Advanced regex (repetition patterns)
# - n(), n_groups(), n_distinct()


#-------------------------------------------------------------------------------
# SESSION 57 : Joins & Benchmarking
#-------------------------------------------------------------------------------
# - left_join()
# - microbenchmark, bench, profvis
# - Performance analysis
# - Time-based filtering


#-------------------------------------------------------------------------------
# SESSION 58 : Cumulative & Lag/Lead
#-------------------------------------------------------------------------------
# - cumsum()
# - lag(), lead()
# - Running calculations
# - count()


#-------------------------------------------------------------------------------
# SESSION 59 : Frequency & Group Filtering
#-------------------------------------------------------------------------------
# - count(), add_count()
# - Filtering frequent groups
# - slice_head(), slice_tail()
# - First/last row per group


#-------------------------------------------------------------------------------
# SESSION 60 : Lag/Lead & Join Filtering
#-------------------------------------------------------------------------------
# - lag() vs lead() comparisons
# - semi_join(), anti_join()
# - %in% filtering
# - Join-based filtering logic


#-------------------------------------------------------------------------------
# SESSION 61 : Duplicate Detection & Anti Joins
#-------------------------------------------------------------------------------
# - distinct() for unique values
# - Duplicate detection using group_by() + n()
# - add_count() for duplicates
# - duplicated() (base R)
# - janitor::get_dupes()
# - Predicate filtering (if_any, if_all)
# - anti_join() for mismatch detection
# - relocate() for column reordering


#-------------------------------------------------------------------------------
# SESSION 62 : Column Reordering & Nested Data
#-------------------------------------------------------------------------------
# - relocate() with conditions
# - Logical operators (& vs &&)
# - nest() for grouped list-columns
# - Access nested data
# - Joining datasets before filtering (correct workflow)


#-------------------------------------------------------------------------------
# SESSION 63 : Join Operations (Core Concepts)
#-------------------------------------------------------------------------------
# - inner_join(), left_join(), right_join(), full_join()
# - semi_join(), anti_join(), cross_join()
# - join_by() (modern syntax)
# - Join behavior with sample datasets


#-------------------------------------------------------------------------------
# SESSION 64 : Advanced Joins & join_by()
#-------------------------------------------------------------------------------
# - nest_join()
# - Non-equi joins (>=, <=)
# - Range joins
# - Joining on different column names
# - Multi-key joins


#-------------------------------------------------------------------------------
# SESSION 65 : Missing Data & Multi-table Joins
#-------------------------------------------------------------------------------
# - Handling NA after joins
# - inner vs left vs right join comparison
# - suffix handling
# - Chained joins (multi-table pipelines)
# - Mixed join strategies


#-------------------------------------------------------------------------------
# SESSION 66 : Join Debugging & Relationships
#-------------------------------------------------------------------------------
# - Key uniqueness validation
# - Detecting data explosion (many-to-many joins)
# - Self joins
# - anti_join() for debugging
# - Relationship types:
#   one-to-one, one-to-many, many-to-one, many-to-many


#-------------------------------------------------------------------------------
# SESSION 67 : Advanced join_by() & Optimization
#-------------------------------------------------------------------------------
# - Inequality joins
# - closest() joins
# - Aggregated joins (performance optimization)
# - Preventing duplication


#-------------------------------------------------------------------------------
# SESSION 68 : Join + Mutate + Optimization
#-------------------------------------------------------------------------------
# - mutate() with joins
# - coalesce() for missing values
# - transmute() vs mutate()
# - Memory optimization before joins
# - Nested data + joins
# - Join semantics parameters


#-------------------------------------------------------------------------------
# SESSION 69 : Join Parameters & Filter Semantics
#-------------------------------------------------------------------------------
# - na_matches (NA handling in joins)
# - multiple parameter (handling duplicates)
# - .by inside filter()
# - .preserve behavior
# - filter() vs filter_out()


#-------------------------------------------------------------------------------
# SESSION 70 : Advanced Filtering & Grouping
#-------------------------------------------------------------------------------
# - filter_all(), filter_if(), filter_at() (legacy)
# - if_all(), if_any() (modern replacement)
# - group_by() behavior
# - summarise() with .groups
# - Rowwise vs grouped logic


#-------------------------------------------------------------------------------
# SESSION 71 : Group-wise Operations & Context Functions
#-------------------------------------------------------------------------------
# - mutate(), filter(), slice within groups
# - across() with grouping
# - Ranking within groups
# - Context functions:
#   cur_group(), cur_column(), cur_data()
# - group_map(), group_modify()


#-------------------------------------------------------------------------------
# SESSION 72 : Group Metadata & .by Optimization
#-------------------------------------------------------------------------------
# - .by instead of group_by()
# - group_data(), group_rows(), group_indices()
# - cur_group_id()
# - Filtering groups with NA conditions
# - Group size analysis


#-------------------------------------------------------------------------------
# SESSION 73 : Group Iteration & Window Functions
#-------------------------------------------------------------------------------
# - group_split(), group_walk(), group_trim()
# - lag(), lead(), cumsum()
# - group_modify()
# - Multi-level aggregation
# - Pivot inside grouped workflow


#-------------------------------------------------------------------------------
# SESSION 74 : Subqueries & Semi-Joins
#-------------------------------------------------------------------------------
# - Subqueries using %in%
# - Inline queries inside filter()
# - semi_join() as EXISTS equivalent
# - Nested queries
# - Correlated subqueries


#-------------------------------------------------------------------------------
# SESSION 75 : Subqueries vs Joins & Data Combination
#-------------------------------------------------------------------------------
# - When to use subqueries vs joins
# - bind_rows(), bind_cols()
# - Set operations:
#   union(), union_all(), intersect(), setdiff(), symdiff()


#-------------------------------------------------------------------------------
# SESSION 76 : Data Reshaping (tidyr)
#-------------------------------------------------------------------------------
# - pivot_longer() (wide → long)
# - pivot_wider() (long → wide)
# - Handling duplicates before reshape
# - separate(), unite()


#-------------------------------------------------------------------------------
# SESSION 77 : Data Cleaning & Transformation
#-------------------------------------------------------------------------------
# - extract() with regex
# - complete() for missing combinations
# - fill() (forward fill)
# - replace_na()
# - nest() / unnest()
# - case_when(), if_else()


#-------------------------------------------------------------------------------
# SESSION 78 : Dynamic Programming & Column Operations
#-------------------------------------------------------------------------------
# - Dynamic column creation (!!)
# - across() transformations
# - rename(), rename_with()
# - Type conversion
# - Date-time transformations (lubridate)


#-------------------------------------------------------------------------------
# SESSION 79 : Row-wise + Advanced mutate Patterns
#-------------------------------------------------------------------------------
# - rowwise()
# - .by in mutate()
# - rowMeans(), pick()
# - reframe()
# - Custom functions inside mutate()
# - Top-N per group methods


#-------------------------------------------------------------------------------
# SESSION 80 : Functions with dplyr
#-------------------------------------------------------------------------------
# - Functions inside across(), filter(), mutate()
# - Custom aggregation functions
# - Parameterized functions
# - Anonymous functions (~)
# - Pipeline + function integration


#-------------------------------------------------------------------------------
# SESSION 81 : Functional Programming with dplyr + Tidy Evaluation
#-------------------------------------------------------------------------------
# - Functions returning dataframes
# - group_modify()
# - Custom aggregation functions
# - Tidy evaluation using {{ }}
# - Dynamic column selection
# - Variable arguments (...)
# - across() with custom functions
# - Custom cleaning functions
# - Parameterized functions
# - Function pipelines
# - safe_mean() for NA-safe summaries
# - mutate() + custom functions
# - filter() + custom functions
# - Functional programming concepts


#-------------------------------------------------------------------------------
# SESSION 82 : Data Transformation with mutate(), joins & nesting
#-------------------------------------------------------------------------------
# - mutate() for variable creation
# - if_else() conditional logic
# - case_when() multiple conditions
# - recode() and case_match()
# - Data type conversion
# - Handling missing values using coalesce()
# - String concatenation using paste()
# - separate() for column splitting
# - across() for bulk transformations
# - Custom column naming using .names
# - if_any() and if_all()
# - rowwise() operations
# - cumsum() cumulative functions
# - row_number()
# - left_join() (VLOOKUP equivalent)
# - Layered mutate() pipelines
# - with() base R helper
# - Nested data using list columns
# - cur_data() and pick()
# - Import and export functions


#-------------------------------------------------------------------------------
# SESSION 83 : Import & Export Operations using readr
#-------------------------------------------------------------------------------
# - read_csv() for importing csv files
# - write_csv() for exporting csv files
# - Absolute path vs Relative path
# - getwd() for working directory
# - tempfile() for temporary files
# - Handling missing values using na parameter
# - append = TRUE for appending datasets
# - col_names parameter for headers
# - quote parameter:
#   "needed", "all", "none"
# - escape parameter:
#   "double", "backslash"
# - Handling special characters during export
# - num_threads for multithreaded export
# - Exporting filtered datasets
# - Exporting summary reports
# - Exporting Top-N datasets
# - CSV import/export best practices


#-------------------------------------------------------------------------------
# SESSION 84 : Advanced CSV Importing using read_csv()
#-------------------------------------------------------------------------------
# - read_csv() using absolute paths
# - setwd() and getwd()
# - Reading files using relative paths
# - Importing CSV files from URLs
# - Reading API-based CSV datasets
# - col_names parameter
# - Temporary custom column names
# - col_types for datatype control
# - col_skip() for excluding columns
# - col_select for selective import
# - starts_with() helper inside col_select
# - id parameter for source tracking
# - Reading multiple files together
# - locale() for regional settings
# - decimal_mark handling
# - Regional CSV format differences
# - na parameter for missing values
# - quoted_na behavior
# - trim_ws for whitespace handling
# - trimws() base R function
# - skip parameter for skipping rows
# - n_max for limited row import
# - guess_max for datatype inference
# - name_repair options:
#   unique, minimal, check_unique,
#   unique_quiet, universal,
#   universal_quiet
# - CSV import best practices


#-------------------------------------------------------------------------------
# SESSION 85 : Excel File Handling using readxl & writexl
#-------------------------------------------------------------------------------
# - readxl and writexl packages
# - write_xlsx() for exporting Excel files
# - read_excel() for importing Excel files
# - Exporting filtered datasets to Excel
# - Creating multi-sheet Excel workbooks
# - Using list objects for multiple sheets
# - tempfile() for temporary Excel files
# - col_names parameter for headers
# - format_headers for styled headers
# - use_zip64 for large Excel files
# - Reading Excel sheets using sheet names
# - Reading Excel sheets using sheet index
# - range parameter for cell selection
# - cell_cols() for column ranges
# - cell_rows() for row ranges
# - cell_limits() for custom cell boundaries
# - Selecting columns after import
# - Excel reporting workflows
# - Workbook generation best practices


#-------------------------------------------------------------------------------
# SESSION 86 : Advanced Excel Importing & TSV File Handling
#-------------------------------------------------------------------------------
# - read_excel() advanced parameters
# - col_names with custom headers
# - Renaming columns after import
# - col_types for datatype control
# - skip datatype inside col_types
# - Handling missing values using na
# - trim_ws for whitespace cleanup
# - skip parameter for row skipping
# - n_max for limiting imported rows
# - guess_max for datatype inference
# - .name_repair options:
#   unique, minimal,
#   universal, universal_quiet
# - Handling duplicate column names
# - TSV (Tab Separated Values) files
# - write_tsv() for exporting TSV files
# - read_tsv() for importing TSV files
# - Reading compressed TSV files
# - Compression formats:
#   .gz, .bz2, .xz
# - Compressed file import/export workflows
# - Excel and TSV best practices


#-------------------------------------------------------------------------------
# SESSION 87 : Text Files, Fixed Width Files, RDS, RData & FST Files
#-------------------------------------------------------------------------------
# - Text file handling (.txt, .csv, .tsv)
# - write.table() for exporting text files
# - read.table() for importing text files
# - Pipe-delimited files (|)
# - Comma-delimited files (,)
# - Tab-delimited files (\t)
# - write_delim() and read_delim()
# - Delimited file handling using readr
# - Fixed Width Files (FWF)
# - sprintf() for fixed width formatting
# - writeLines() and readLines()
# - Creating custom width records
# - RDS files (.rds)
# - saveRDS() and readRDS()
# - RDS compression options:
#   gzip, bzip2, xz
# - Version compatibility in RDS
# - RData files (.RData)
# - save() and load()
# - Saving multiple objects
# - RDS vs RData comparison
# - FST files (.fst)
# - write_fst() and read_fst()
# - High-performance analytics storage
# - Text and binary storage best practices


#-------------------------------------------------------------------------------
# SESSION 88 : JSON, XML & YAML File Handling in R
#-------------------------------------------------------------------------------
# - JSON file handling using jsonlite
# - write_json() and read_json()
# - fromJSON() for JSON parsing
# - API-friendly data exchange formats
# - XML file handling using xml2
# - xml_new_root()
# - xml_add_child()
# - Creating hierarchical XML structures
# - write_xml() and read_xml()
# - Converting XML to list objects
# - as_list() conversion
# - Converting XML to tibble
# - YAML file handling using yaml
# - write_yaml() and read_yaml()
# - Data frame to list conversion
# - split() for YAML preparation
# - Reading YAML configurations
# - JSON vs XML vs YAML comparison
# - Data serialization concepts
# - Configuration file management


#-------------------------------------------------------------------------------
# SESSION 89 : HTML & PDF File Handling in R
#-------------------------------------------------------------------------------
# - HTML file generation
# - Creating HTML content in R
# - writeLines() for HTML export
# - readLines() for HTML import
# - browseURL() for opening HTML files
# - HTML table generation
# - htmlTable package
# - Converting data frames to HTML tables
# - Exporting HTML reports
# - Web scraping fundamentals
# - rvest package
# - read_html()
# - html_table()
# - Extracting tables from websites
# - PDF file generation
# - pdftools package
# - gridExtra package
# - Creating PDF reports
# - Exporting plots to PDF
# - Exporting tables to PDF
# - grid.table()
# - PDF text extraction using pdf_text()
# - HTML vs PDF reporting workflows


#-------------------------------------------------------------------------------
# SESSION 90 : ZIP Files & SQLite Database Handling in R
#-------------------------------------------------------------------------------
# - ZIP / Compressed file handling
# - Creating ZIP archives using zip()
# - unzip() for extraction
# - Listing ZIP contents
# - Reading files directly from ZIP
# - unz() function
# - CSV compression workflows
# - Database concepts
# - SQLite database fundamentals
# - DBI package
# - RSQLite package
# - dbConnect()
# - dbDisconnect()
# - dbListTables()
# - dbWriteTable()
# - dbReadTable()
# - dbGetQuery()
# - Executing SQL queries from R
# - Integrating flat files into SQLite
# - Clinical trial external data use cases
# - SQLite as intermediate storage
# - Introduction to HDF5 files
# - Large-scale data storage concepts


#-------------------------------------------------------------------------------
# SESSION 91 : API Integration, SAS Files, Parquet & Feather Formats in R
#-------------------------------------------------------------------------------
# - REST API integration
# - httr package
# - GET() requests
# - status_code()
# - content()
# - API response handling
# - JSON API processing
# - fromJSON()
# - Converting API responses to tibbles
# - SAS file handling using haven
# - read_sas() for SAS datasets
# - SAS7BDAT files
# - SAS Transport files (.xpt)
# - write_xpt() and read_xpt()
# - CDISC submission formats
# - Parquet file handling using arrow
# - write_parquet() and read_parquet()
# - Compression methods:
#   snappy, gzip, zstd, uncompressed
# - Big data storage formats
# - Feather file handling
# - write_feather() and read_feather()
# - Arrow ecosystem
# - Cross-language data exchange
# - Clinical programming storage architecture
# - SAS vs XPT vs Parquet vs Feather
# - Big data analytics workflows
# - Cloud and distributed data processing


#===============================================================================
# END OF FILE
#===============================================================================