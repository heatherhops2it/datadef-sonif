## Goal of this script is to investigate the R packages rredlist and rfishbase

## Note 2026/10/15 11:45 Hopper - rfishbase may take a while to access data. Estimated time to retrieve Fundulus diaphanus maturity data with 'maturity()' was 5.09 seconds.



# Load libraries ----------------------------------------------------------

library(rredlist)   # install.packages("rredlist")
library(rfishbase)   # install.packages("rfishbase")
library(tidyverse)




# Q1: What is in rfishbase? -----------------------------------------------

## Many functions in the package refer to data tables on a sp. page under the "More information" tab.
## These data tables are the specific links (e.g., "Reproduction," "Maturity") instead of headers (e.g., "Life cycle")
## If the requested sp. does not have a data table available on FishBase, the function result will display only the column headers (e.g., compare brains("Fundulus heteroclitus") with brains("Boreogadus saida"))
## These rfishbase functions can be loaded with a single sp. or a vector of multiple spp.

## If the function for a species' table doesn't exist already, fb_tables() shows the list of tables you can call with fb_tbl()

## references() gives information on a vector of references using the FishBase reference number

## It looks like the fishbase() function is what we will need for comparison to rredlist

fishbase()
