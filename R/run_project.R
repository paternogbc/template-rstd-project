# Script to run all project code
# Note: Refresh R session before running this script

# Start----
# 1. Erase processed data & outputs-------------------------------------------
do.call(file.remove, list(list.files("data/processed/", full.names = TRUE)))
do.call(file.remove, list(list.files("output/figures/", full.names = TRUE)))
do.call(file.remove, list(list.files("output/tables/", full.names = TRUE)))
do.call(file.remove, list(list.files("output/supp/", full.names = TRUE)))
do.call(file.remove, list(list.files("output/temp/", full.names = TRUE)))

# 2. Run all scripts again on a fresh R section------------------------------------
# 2.1 Load and clean data----
source(file = "R/01_C_load_clean_anura_data.R")

# 2.2 Fit models----
source(file = "R/01_D_fit_linear_regression_freq_size.R")

# 2.3 Plot figures----
source(file = "R/01_Fig_linear_regression_freq_size.R")
