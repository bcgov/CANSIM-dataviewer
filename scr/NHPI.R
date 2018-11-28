# Copyright 2018 Province of British Columbia
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

# NEW HOUSING PRICE INDEX (NHPI) CHART FOR INFOLINE
#
# install necessary packages
# utilities
library(readr)
library(zoo)
# plotting
library("ggplot2") # NOTE: requires ggplot 2.2.0 
library("scales")
# data manipulation
library("dplyr")
#
# set working directory
#setwd("J:/BCSTATS/INFOLINE/Infoline_2016-11-10_NHPI")
setwd("C:/@data/GitHub/CANSIM-data-viewer")
#
# read the data
# -- file 03270046-eng.csv download of CANSIM table 327-0046
# -- http://www5.statcan.gc.ca/cansim/a26?lang=eng&retrLang=eng&id=3270046&&pattern=&stByVal=1&p1=1&p2=1&tabMode=dataTable&csid=
thedata <- read_csv("data/03270046-eng.csv")


# fix dates
class(thedata$Ref_Date)
thedata$DATE <- as.Date(as.yearmon(thedata$Ref_Date, format="%Y/%m"))
#

startdate <- as.Date("2007-01-01")


# filter to have BC and Canada
thedata_long <- thedata %>%
  filter(DATE >= startdate) %>%
  filter(GEO == c("British Columbia", "Canada"), INDEX == "Total (house and land)")

thedata_long

# PLOT!
# basic
ggplot(thedata_long, aes(x=DATE, y=Value, group=GEO)) + 
  geom_line()
#
# with formatting applied
dataplot <- ggplot(thedata_long, aes(x=DATE, y=Value, colour=GEO)) + 
  geom_line(size=1.5) 
dataplot


dataplot2 <- dataplot +
  #  ylim(3500000, 6500000) +
  scale_y_continuous(labels = comma, limits = c(90, 120)) +
  scale_colour_manual(name=NULL,
                      breaks=c("Canada", "British Columbia"),
                      labels=c("Canada", "British Columbia"), 
                      values=c("#325A80", "#CCB550")) +
  theme_bw() +
  theme(
    panel.border = element_rect(colour="white"),
    plot.title = element_text(face="bold"),
    legend.position=c(1,0), 
    legend.justification=c(1,0),
    legend.title = element_text(size=12),
    legend.text = element_text(size=11),
    axis.line = element_line(colour="black"),
    axis.title = element_text(size=12),
    axis.text = element_text(size=12)
  )
#
dataplot2 

# experiments with ggplot2's new subtitle and caption options

# add titles / X-Y axis labels
dataplot2 +
  ggtitle("New Housing Price Index, Canada & B.C.", subtitle = "2007 = 100")

# add titles / X-Y axis labels
dataplot2 +
  labs(title = "New Housing Price Index, Canada & B.C.",
       subtitle = "2007 = 100")

# add titles / X-Y axis labels
dataplot2 +
  labs(title = "New Housing Price Index, Canada & B.C.",
       subtitle = "2007 = 100",
       x = NULL, y = "NHPI")

# add titles / X-Y axis labels
dataplot2 +
  labs(title = "New Housing Price Index, Canada & B.C.",
       subtitle = "2007 = 100",
       caption = "Source: Statistics Canada", 
       x = NULL, y = "NHPI") 

# final version
# add titles / X-Y axis labels / caption
NHPI_plot <- dataplot2 +
  labs(title = "New Housing Price Index, Canada & B.C.",
       subtitle = "Total (house and land)",
       caption = "Source: Statistics Canada, CANSIM table 327-0046", 
       x = NULL, y = "NHPI (2007 = 100)") 

ggsave(filename = "NHPI_plot.png", plot = NHPI_plot,
       width = 8, height = 6)
