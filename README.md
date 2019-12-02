# Phytolith-Index-Bootstrap
<B>R scrips for calculating confidence intervals for phytolith D/P (tree cover) and Iph (aridity) index values</B>

These scripts calculate 95% confidence intervals for D/P and Iph phytolith index values by nonparametric bootstrap resampling using the ‘boot’ and ‘simpleboot’ packages in R (R Core Team, 2018). The bootstrapping and error propagation code was written to run on lists of phytolith counts used to calculate the D/P° and Iph values.

<B>Multiple sample BCa 95% bootstrap confidence interval code for D/P values</B>

First, create a .csv file called DPdata.csv with the following four columns of data: 1) “Depth”, “Age”, or “Sample No”; 2)” D” for the D counts; 3) “P” for the P counts; and 4)”DPratio” for the calculated D/P values. Columns 2, 3, and 4 must be named as indicated for the code to work. The code will not work if any of the D or P counts equal 0, these samples should be removed before running. If any of the samples have a D or P count equal to 1, a warning message will be returned, but the code will still execute. The code can be copied into the R or RStudio console or copied into a new R script file and run from there.
