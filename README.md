# Phytolith-Index-Bootstrap
<B>R scrips for calculating confidence intervals for phytolith D/P (tree cover) and Iph (aridity) index values</B>

These scripts calculate 95% confidence intervals for D/P and Iph phytolith index values by nonparametric bootstrap resampling using the ‘boot’ and ‘simpleboot’ packages in R (R Core Team, 2018). The bootstrapping and error propagation code was written to run on lists of phytolith counts used to calculate the D/P° and Iph values.
<br>
<br>
<B>DP_Bootstrap_script.R</B>

First, create a .csv file called DPdata.csv with the following four columns of data: 1) “Depth”, “Age”, or “Sample No”; 2)” D” for the D counts; 3) “P” for the P counts; and 4)”DPratio” for the calculated D/P values. Columns 2, 3, and 4 must be named as indicated for the code to work.

<table>
  <tr>
    <th>Depth</th>
    <th> D </th>
    <th> P </th>
    <th>DPratio</th>
  </tr>
  <tr>
    <td>n</td>
    <td>n</td>
    <td>n</td>
    <td>n</td>
  </tr>
  </table>
  
The code will not work if any of the D or P counts equal 0, these samples should be removed before running. If any of the samples have a D or P count equal to 1, a warning message will be returned, but the code will still execute. The code can be copied into the R or RStudio console or copied into a new R script file and run from there.
<br>
<br>
<B>Iph_Bootstrap_script.R</B>

First, create a .csv file called IphData.csv with the following four columns of data: 1) “Depth”, “Age”, or “Sample No”; 2) “C4xeric” for the saddle counts; 3) “C4mesic” for the bilobate + cross counts; and 4)”Iph” for the calculated Iph index values.

<table>
  <tr>
    <th>Depth</th>
    <th>C4xeric</th>
    <th>C4mesic</th>
    <th>Iph </th>
  </tr>
  <tr>
    <td>n</td>
    <td>n</td>
    <td>n</td>
    <td>n</td>
  </tr>
  </table>

The code will return an error if either the Iph numerator or denominator = 0 for any of the samples. These samples should be removed from the .csv file before running. The code can be copied into the R or RStudio console or copied into a new R script file and run from there.


