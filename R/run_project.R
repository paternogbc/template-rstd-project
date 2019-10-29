# Script to run all project code
# Note: Refresh R session before running this script

# Start----
# 1. Run all scripts again on a fresh R section---------------------------------
# 1.1 Load and clean data----
source(file = "R/01_C_load_clean_anura_data.R")

# 1.2 Run exploratory analysis and supp figures---------------------------------
source(file = "R/01_report_exploratory_analysis_study_variables.R")

# 1.3 Fit models----------------------------------------------------------------
source(file = "R/01_D_fit_linear_regression_freq_size.R")

# 1.3 Plot figures--------------------------------------------------------------
source(file = "R/01_Fig_linear_regression_freq_size.R")
