library(cansim)

data_SEPH1 <- get_cansim("14-10-0201-01", refresh = TRUE)
max(data_SEPH1$REF_DATE)


data_SEPH2 <- get_cansim("14-10-0203-01", refresh = TRUE)
max(data_SEPH2$REF_DATE)

data_SEPH3 <- get_cansim("14-10-0223-01", refresh = TRUE)
max(data_SEPH3$REF_DATE)

beepr::beep("treasure")



# ----

# CPI
# current to December 2018
# https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1810000402
data_CPI <- get_cansim("18-10-0004-02", refresh = TRUE)
max(data_CPI$REF_DATE)

# New Housing Price Index
# current to November 2018
# https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1810020501

data_NHPI <- get_cansim("18-10-0205-01", refresh = TRUE)
max(data_NHPI$REF_DATE)



