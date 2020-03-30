# Contribution guidelines

Contributions are R-centric at the moment. 

## Issues

* There are two issue templates: 1) Bug report and 2) Feature request. Their use should be self-explanatory. If your issue does not fit in either of these categories, simply open a blank issue.
* As explained in the issue template, bug reports should include a reproducible example. If you use the `reprex` package, this will include the sessionInfo for your R session.

## Pull Requests

When making pull requests, please observe the following:

* Do not use this repository to host data. Rather, create a script which will harvest the data from a publicly available source.
* Stick with the current `data` and `eda` folder split. That is, scripts in `data` are for harvesting data and scripts in `eda` will explore data which has been harvested.
* There should be a one-to-one relationship between the script and the source. That is, any necessary processing after the data has been gathered should be in the same script used to source the data. 
* Each data gathering script should save its output as an `.rda` file with the same name as the script. 
* Try to keep the technology stack straightforward. Base R, `tidyverse` and `data.table` are fine. Please avoid obscure data wrangling and analysis packages.
