# Calculating 95% confidence intervals for phytolith D/P index values
# by Chad Yost chadyost@hotmail.com
# 12/03/2019

# This script calculates bootstrapped 95% confidence intervals for phytolith
# D/P (tree cover) index values by reading the individual D and P counts for
# each sample listed in a .csv file. The upper and lower confidence interval
# bounds for each sample are saved into a new .csv file.   

# Load R packages with routines needed for the BCa Bootstrap CI code.
library(boot)
library(simpleboot)

# Open directory window to locate the .csv file to import
# Import .csv file as a Data.Frame named “DPdata”
DPdata <- read.csv(file.choose(), header = TRUE)

# Remove any extra rows and columns during csv import, which is necessary for
# the code to execute correctly.
DPdata <- na.omit(DPdata)

# Add two columns to DPdata that will hold the calculated BCa bootstrap
# 95% confidence interval lower and upper endpoint values.
DPdata$ciLower <- 0     
DPdata$ciUpper <- 0

# Create variable “rowcount” to use in the ‘for’ loop routine.
rowcount <- nrow(DPdata)

# Loop routine for calculating BCa values from D/P index data.
# Datasets with >50 samples may take several minutes for the Bca
# calculations to be completed.
for (n in 1:rowcount) {
  
  # Create binomial vectors for D and P variables
  D <- c(rep(1, DPdata [n, 2]), rep(0, DPdata [n, 3]))
  P <- c(rep(1, DPdata [n, 3]), rep(0, DPdata [n, 2]))
  
  # Use 'one.boot' from the simpleboot R package to bootstrap a single sample 
  # statistic 10,000 times for each D and P value.
  Dresults <- one.boot(D, mean, 10000)
  Presults <- one.boot(P, mean, 10000)
  
  # Calculate the BCa confidence intervals for D and P counts separately.
  ci_Dresults <- boot.ci(Dresults, type = c("bca"))
  ci_Presults <- boot.ci(Presults, type = c("bca"))
  
  # Set variables for the calculated D and P lower and upper confidence interval
  # proportions from the bootstrap routine.
  Dmin <- ci_Dresults$bca [1, 4] 
  Dmax <- ci_Dresults$bca [1, 5] 
  Pmin <- ci_Presults$bca [1, 4]
  Pmax <- ci_Presults$bca [1, 5]
  
  # Calculate 95% confidence interval lower bounds for each D/P value by
  # standard error propagation (fractional uncertainties added in quadrature for
  # the D/P ratio) and inserts the values into column 5 of the DPdata dataframe.
  DPdata [n, 5] <- DPdata [n, 4] - ( DPdata [n, 4] * sqrt(((( DPdata [n, 2] -
                (( DPdata [n, 2] + DPdata [n, 3] ) * Dmin )) / DPdata [n, 2] ) ^ 2) +
                ((( DPdata [n, 3] - (( DPdata [n, 2] + DPdata [n, 3] ) * Pmin )) /
                DPdata [n, 3] ) ^ 2)))
  
  # Calculate 95% confidence interval upper bound endpoints for each D/P value and
  # inserts the values into column 5 of the DPdata dataframe.
  DPdata [n, 6] <- DPdata [n, 4] + ( DPdata [n, 4] * sqrt(((((( DPdata [n, 2] +
                   DPdata [n, 3] ) * Dmax ) - DPdata [n, 2] ) / DPdata [n, 2] ) ^ 2) +
                   ((((( DPdata [n, 2] + DPdata [n, 3] ) * Pmax ) - DPdata [n, 3] ) /
                   DPdata [n, 3] ) ^ 2)))
}

# The following warning message will appear (one for each occurrence) if any of
# the D or P count values equal 1, but the code will still execute correctly: 
# Warning message:
# In norm.inter(t, adj.alpha) : extreme order statistics used as endpoints

# Create .csv file from the DPdata dataframe and save to the working directory.
write.csv(DPdata, "DPdataBCA.csv", row.names = FALSE)
