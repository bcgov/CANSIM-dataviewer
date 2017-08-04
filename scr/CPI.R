# CONSUMER PRICE INDEX 
#
# install necessary packages
# utilities
library(readr)
library(zoo)
# data manipulation
library("dplyr")
# plotting
library("ggplot2") # NOTE: requires ggplot 2.2.0 
library("scales")


# set working directory
setwd("C:/@data/GitHub/CANSIM-data-viewer")
#
# read the data
# -- file 03260020-eng.csv download of CANSIM table 326-0020
# -- http://www5.statcan.gc.ca/cansim/a26?id=3260020
thedata <- read_csv("data/03260020-eng.csv")


# dates: correct format, add separate year and month variables
class(thedata$Ref_Date)
thedata$DATE <- as.Date(as.yearmon(thedata$Ref_Date, format="%Y/%m"))
thedata$year <- format(as.Date(thedata$DATE, format="%Y-%m-%d"),"%Y")
thedata$month <- format(as.Date(thedata$DATE, format="%Y-%m-%d"),"%m")

# add fiscal year variable 
# notes:
#   -- fiscal year is defined as April to March, with the year referencing the end of the period
#      e.g. April 2016 to March 2017 is fiscalyear == 2017
#   -- "(format(thedata$DATE, "%m") >= "04")" returns TRUE/FALSE, thus adds 1 if >=04
thedata$fiscalyear <- as.numeric(format(thedata$DATE, "%Y")) + (format(thedata$DATE, "%m") >= "04")
#

ls.str(thedata)
tail(thedata)

startdate <- as.Date("2007-01-01")


# filter to have B.C. and maybe Canada
thedata_long <- thedata %>%
#  filter(DATE >= startdate) %>%
#  filter(GEO == c("British Columbia", "Canada"), COMM == "All-items")
  filter(GEO == c("British Columbia"), COMM == "All-items")

ls.str(thedata_long)
head(thedata_long)
tail(thedata_long)


# *********************************************

# create summary table with annual average CPI

CPI_BC_annual <- thedata_long %>%
  group_by(GEO, year) %>%
  summarise(CPI_annual = mean(Value),
            monthcount = n())

tail(CPI_BC_annual)

# add year over year percent change

# TIL dplyr has "window functions"
# https://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html

CPI_BC_annual <- CPI_BC_annual %>%
  mutate(CPI_YoY_pct = (CPI_annual - lag(CPI_annual)) / lag(CPI_annual) * 100) 

tail(CPI_BC_annual,10)

write_csv(CPI_BC_annual, "CPI_BC_annual.csv")


# repeat; create summary table with annual average CPI for fiscal year

CPI_BC_fiscal <- thedata_long %>%
  group_by(GEO, fiscalyear) %>%
  summarise(CPI_annual = mean(Value),
            monthcount = n()) %>%
  mutate(CPI_YoY_pct = (CPI_annual - lag(CPI_annual)) / lag(CPI_annual) * 100) 

tail(CPI_BC_fiscal,10)

write_csv(CPI_BC_fiscal, "CPI_BC_fiscal.csv")


# --------- 

# some poking about

# what happens if we compare the first 8 months (April - November) of fiscal 2016 to fiscal 2017?

tail(thedata_long, 12)

period <- as.month(c(4:11))
period

thedata_long %>%
  filter(month %in% c("04", "05", "06", "07", "08", "09", "10", "11") & year > 2005) %>%
  group_by(GEO, fiscalyear) %>%
  summarise(CPI_annual = mean(Value),
            monthcount = n()) %>%
  mutate(CPI_YoY_pct = (CPI_annual - lag(CPI_annual)) / lag(CPI_annual) * 100) 


