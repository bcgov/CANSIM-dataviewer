library(dplyr)
library(tidyr)
library(feather)

# data
read_feather("thedata_table.feather")


# make nice table
NHPI_table <- thedata_table %>%
  mutate(year = year(REF_DATE),
         month = month(REF_DATE, label = TRUE)) %>%
  select(year, month, VALUE) %>%
  spread(month, VALUE)

NHPI_table

# how to add annual average?
