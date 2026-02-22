#===============================================================================
# Chapter 16: Operators, Random Numbers, Sequences & Logical Helpers in R
#===============================================================================


###############################################
# Modulus and Integer Division Operators
###############################################

10 %% 3         # Returns the remainder
10 %/% 3        # Returns the quotient


###############################################
# Random Number Generation
###############################################

# Uniform random numbers between 0 and 1
runif(20)

# Real-world range (e.g., Age between 18 and 65)
runif(10, min = 18, max = 65)

# Generate integer-like random numbers
floor(runif(5, min = 10, max = 20))
ceiling(runif(5, min = 10, max = 20))
trunc(runif(5, min = 10, max = 20))


###############################################
# Sampling Values
###############################################

# Sample from 1 to 10
sample(10)

# Sample from a sequence
sample(2:10)

# Sample 5 values from 2 to 10
sample(2:10, 5)

# Coin toss simulation
sample(c("Head", "Tail"), size = 10, replace = TRUE)

# Sample character values
sample(c("A", "B", "C", "D", "E"))


###############################################
# Numeric Type Testing
###############################################

is.numeric(10)
is.integer(1L)


###############################################
# Logical Evaluation on Vectors
###############################################

z <- c(4, 5, 6, 7)

z > 4

# any(): TRUE if at least one condition is TRUE
any(z > 4)
any(z < 4)

# all(): TRUE only if all conditions are TRUE
all(z > 4)
all(z < 4)
all(z <= 4)


###############################################
# Sequence Generation
###############################################

seq(1, 10)
seq(1, 10, by = 2)


###############################################
# Repetition Functions
###############################################

rep(5, times = 10)
rep("*", times = 10)


###############################################
# Difference and Lag Functions
###############################################

c <- c(3, 5, 7, 8, 9, 10)

diff(c)

# lag() is mainly used in time series (stats / dplyr)
lag(c)
# lag() shifts values backward to access previous observations


###############################################
# Key Interview & Practical Takeaways
###############################################

# 1. %% gives remainder, %/% gives quotient
# 2. runif() is the most common random generator
# 3. floor(), ceiling(), trunc() control rounding
# 4. sample() is used for bootstrapping & simulations
# 5. any() checks existence of TRUE
# 6. all() enforces strict logical validation
# 7. seq() and rep() are core vector generators
# 8. diff() is widely used in time-series analysis
# 9. lag() shifts values for trend comparison


###############################################
# END OF FILE
###############################################