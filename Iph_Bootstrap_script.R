# Calculating 95% confidence intervals for phytolith Iph index values
# by Chad Yost chadyost@hotmail.com
# 12/03/2019

# This script calculates bootstrapped 95% confidence intervals for phytolith
# Iph (aridity) index values by reading the individual saddle and lobate
# phytolith counts for each sample listed in a .csv file. The upper and lower
# confidence intervalbounds for each sample are saved into a new .csv file.

# Load R packages with routines needed for the BCa Bootstrap CI code.
library(boot)
library(simpleboot)

# Open directory window to locate the .csv file to import.
# Import the .csv file as a Data.Frame named “IphData”.
IphData <- read.csv(file.choose(), header = TRUE)

# Remove extra rows and columns during csv import, which is necessary for the
# code to execute correctly.
IphData <- na.omit(IphData)

# Add two columns to IphData that will hold the calculated BCa bootstrap 95%
# confidence interval lower and upper bound values.
IphData$ciLower <- 0     
IphData$ciUpper <- 0

# Create the variable “rowcount” used in the ‘for’ loop routine.
rowcount <- nrow(IphData)

# Loop routine for calculating confidence intervals for each sample.
# Datasets with >50 samples may take several minutes for the Bca
# calculations to be completed. The code will return an error if
# either the Iph numerator or denominator = 0 for any of the samples. 
for (n in 1:rowcount) {
  
  # Create a binomial vector for the Iph count data
  Iph <- c(rep(1, IphData [n, 2]), rep(0, IphData [n, 3]))
  
  # Uses 'one.boot' from the simpleboot R package to bootstrap a single
  # sample statistic 10,000 times.
  IphResults <- one.boot(Iph, mean, 10000)
  
  # Calculate the BCa 95% confidence interval lower and upper bounds for
  # each Iph value and adds them to columns 5 and 6 in the IphData dataframe.
  # You need to multiply these values by 100 if reporting Iph as a percentage.
  ci_IphResults <- boot.ci(IphResults, type = c("bca"))
  IphData[n, 5] <- ci_IphResults$bca[1, 4]
  IphData[n, 6] <- ci_IphResults$bca[1, 5]
}

# Create .csv file from the DPdata dataframe and output to the working directory.
write.csv(IphData, "IphDataBCA.csv", row.names = FALSE)
