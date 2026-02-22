#===============================================================================
# Chapter 18: Strings in R – Empty Strings, Printing & Formatting
#===============================================================================


###############################################
# Empty String vs NA
###############################################

a <- c("", NA, "8", NA_character_)
a
class(a)            # "character"

# Empty string check
a == ""

# NA check
is.na(a)


###############################################
# Creating Empty Strings
###############################################

# Vector of empty strings (length = 2)
y <- character(2)
y
length(y)           # 2
nchar(y)            # 0 0

# Truly empty character vector (length = 0)
y <- character(0)
y
length(y)           # 0
nchar(y)            # integer(0)

# Adding value later
y[1] <- "hitesh"
y


###############################################
# length() vs nchar()
###############################################

z <- "R"
length(z)           # number of elements
nchar(z)            # number of characters

z <- c("R", "python", "julia", 1, TRUE)
z                   # implicit coercion to character
length(z)           # 5
nchar(z)            # 1 6 5 1 4

is.character(z)     # TRUE
is.numeric(z)       # FALSE


###############################################
# Quotes in Strings
###############################################

x <- "learn the R programming language"
print(x)

x <- 'learn the R programming language'
print(x)

# Invalid (commented)
# x <- 'learn the R 'programming language'

x <- "learn the R 'programming language"
print(x)

x <- 'learn the R "programming language'
print(x)


###############################################
# Printing Strings
###############################################

company    <- "Visa"
experience <- 6
name       <- "Hitesh B G"

# print() – debugging / interactive output
print(name)

# cat() – formatted console output
cat("Myself", name, "working in", company,
    "for past", experience, "years\n")

cat("hello world\n")
cat(c("A", "B"))
cat(c("A", "B"), sep = "-\n")
cat("A", "B", sep = "-\n")

cat("hello\nworld")
cat("hello\t\tworld\n")


###############################################
# paste() – String Combination
###############################################

paste("Myself", name, "working in", company,
      "for past", experience, "years")

paste("A", "B", "C")
paste("A", "B", "C", sep = "-")

name <- c("A", "B", "C")
paste("item", name)

f_name <- "Hitesh"
l_name <- "B G"
paste("Full name:", f_name, l_name)

# collapse – join vector into single string
paste(name, collapse = "-")
paste(name, collapse = ", ")

# sep vs collapse
paste("A", "B", "C", sep = "-")
paste("A", "B", "C", collapse = "-")

paste()


###############################################
# paste0() – No Separator (IDs, Filenames)
###############################################

paste0("Hello", "R")

file_id <- 10
paste0("report_", file_id, ".csv")

ids <- 1:3
paste0("ID_", ids)        # "ID_1" "ID_2" "ID_3"
paste("ID_", ids)         # "ID_ 1" "ID_ 2" "ID_ 3"
cat("ID_", ids, "\n")     # ID_ 1 2 3


###############################################
# sprintf() – Professional Formatting
###############################################

user_score <- 0.876

paste0("The final score is ", user_score * 100)
sprintf("The final score is %.3f%%", user_score * 100)

# Logging example
for (i in 1:5) {
  cat(sprintf("Processing batch %02d ...\n", i))
}

# File generation
years     <- 2020:2024
filenames <- paste0("data_report_", years, ".csv")
filenames


###############################################
# Summary & Best Practices
###############################################

# 1. "" (empty string) ≠ NA
# 2. length() → elements, nchar() → characters
# 3. print() → debugging
# 4. cat() → user-facing messages / logs
# 5. paste() → readable text
# 6. paste0() → IDs, filenames
# 7. sprintf() → numeric precision & reports


###############################################
# END OF FILE
###############################################