# Script to load and clean raw data set (anura calls)
# Gustavo Paterno
# Last update: 2019-10-21

# Note: The dataset is a modified version of the original data!
# Only for educational purpose!
# Source of the original dataset: 
# https://github.com/paternogbc/2015_Rohr_et_al_JAEcol

# Start----
# Packages ----------------------------------------------------------------
library(tidyverse)
library(inspectdf)
library(forcats)

# Load data ---------------------------------------------------------------
rd <- read.csv(file = "data/raw/raw_anura_call_data.csv")

# 1. Basic checks --------------------------------------------------------------
nrow(rd)             # How many rows
str(rd)              # Variables classes
attributes(rd)       # Attributres
head(rd)             # First rows
any(duplicated(rd))  # There is any duplicated rows?
any(is.na(rd))       # There are NAs in the data?

# 2. Rename columns names-------------------------------------------------------
dat <- dplyr::rename(rd, 
              family  = FAMILy,
              species = Species,
              envir   = en,
              freq    = DF,
              size    = SVL)

# 3. Fix factor variables-------------------------------------------------------
# factor variables
levels(dat$family)
levels(dat$envir) # There is some typos in this variable!
levels(dat$species)

# 3.1 envir = "" will be coded as NA
levels(dat$envir)[levels(dat$envir) == ""] <- NA

# 3.2 envir = flowingg will be coded as flowing
levels(dat$envir)[levels(dat$envir) == "flowingg"] <- "flowing"

# 3.3 envir = stilll and "still " will be coded as still
levels(dat$envir)[levels(dat$envir) == "still  "] <- "still"
levels(dat$envir)[levels(dat$envir) == "stilll"] <- "still"

# check
levels(dat$envir)

# 4. Remove NAs-----------------------------------------------------------------
na_check <- inspectdf::inspect_na(dat) # Percentage of NA in each columns
na_check

# Which rows have NA?
dat[is.na(dat$freq) | is.na(dat$size), ]

# Remove NAs
dat <- na.omit(dat)

# Check (# should be all zero!)
inspectdf::inspect_na(dat) # Percentage of NA in each columns

# 5. Remove duplicated rows--------------------------------------------------
# Which rows are dupliucated?
dup <- which(duplicated(dat))
dat[dup, ]

# remove duplicated rows
dat <- dat[-dup, ]

# check (should be FALSE)
any(duplicated(dat)) 

# 6. Average dominant frequency by species---------------------------------
any(table(dat$species) > 1) # Any species with more than 1 sample?

dat_g <- group_by(dat, family, envir, species)

dat_clean <- summarise(dat_g, 
                       n    = n(),
                       freq = mean(freq),
                       size = mean(size)
                       )
# Check data
#View(dat_clean)
nrow(dat_clean)
nrow(rd)

# 7. Transform variables------------------------------------------------------
dat_clean$freq_log <- log(dat_clean$freq)
dat_clean$size_log <- log(dat_clean$size)

head(dat_clean)

# 8. Save processed data -----------------------------------------------------
write.csv(x = dat_clean, 
          file = "data/processed/processed_anura_call_data.csv", 
          row.names = FALSE)

# Test saved data
dat_test <- read.csv("data/processed/processed_anura_call_data.csv")
str(dat_test)

# END-------