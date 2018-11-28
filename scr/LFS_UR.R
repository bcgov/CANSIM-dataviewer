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

# Get historical unemployment data from the Labour Force Survey and create interactive data visualization

#---- Load necessary packages #----


library(tidyverse) # loads multiple packages such as dplyr, tidyr, ggplot2 etc. 
library(CANSIM2R)  # simplifies the process of directly downloading data from CANSIM
library(Hmisc)     # need this package to read labels and create metadata materials
library(zoo)       # package has the 'as.yearmon' function, which is used to create date variables from fields lacking day values
library(shiny)     # used for interactive application development
library(DT)        # datatable package 
library(car)       # package provides a good way to 'recode' values
library(rCharts)   # package in development that can be used to create interactive plots 
library(xts)       # for turning data frames into time series objects
library(dygraphs)  # for charting time series data
library(ggiraph)   # turns ggplot2 output into interactive plots


#---- Download table from CANSIM and save it in the environment as a data frame object #----

## The package "CANSIM2R" has two main functions; 'getCANSIM()' is used to extract a single table from CANSIM, while
## 'mergeCANSIM(c(,))' is used to extract and merge multiple tables on key variables at once 
  
monthlyLFS <- getCANSIM(2820087)                                         # download seasonally adjusted, monthly LFS data
metadataMonthlyLFS <- data.frame(colnames(monthlyLFS),label(monthlyLFS)) # create metadata frame to view all labels
monthlyLFS$Date <- as.Date(as.yearmon(monthlyLFS$t,format="%Y/%m"))      # turn the time variable into an explicit date variable

# Create new data frame with only the relevant fields selected, and rename for better readability

monthlyLFS1 <- monthlyLFS %>% select(Date,i,V922)  
monthlyLFS1 <- rename(monthlyLFS1,UnRate=V922)
monthlyLFS1 <- rename(monthlyLFS1,Region=i)

#---- Plot unemployment rate data using the NVD3 library from the rCharts package #----

# Provincial unemployment rate for a given month across all provinces; Bar Chart

barUR <- nPlot(x= 'Region', y = 'UnRate', data = monthlyLFS1 %>% filter(Date=="2016-10-01"), 
            type = 'discreteBarChart', dom = 'URPlot') # can pick any date
barUR$yAxis(axisLabel = "%", width=40)                 # width can't exceed 64; won't show otherwise
barUR$chart(color = c('#263359', '#263359', '#592633', '#263359', '#263359', '#263359', '#263359', '#263359', 
                   '#263359', '#263359', '#263359'))
barUR$xAxis(staggerLabels = TRUE)                      # Stagger axis labels; otherwise some labels won't show
barUR


# Historical unemployment rate for British Columbia; Line Chart

lineUR <-nPlot(x = 'Date', y= 'UnRate', data = monthlyLFS1 %>% filter(Region=="British Columbia"),
               type = 'lineChart')
lineUR$yAxis(axisLabel = "%", width=40)
lineUR$xAxis(tickFormat="#!function(d) 
             {return d3.time.format.utc('%Y-%m-%d')
             (new Date(d * 24 * 60 * 60 * 1000));}!#")  # javascript code to format the dates properly
lineUR



#---- Plot unemployment rate using dygraphs package #----

## In order to make the data compatible with dygraphs, we need to first turn it "wide," 
## followed by turning it into a time series object; need 'tidyr' and 'xts' packages for that

wideMonthlyLFS1 <- monthlyLFS1 %>% select(Date,Region,UnRate) %>% spread(Region,UnRate)   # 'spread' function is from tidyr
wideMonthlyLFS1 <- xts(wideMonthlyLFS1, as.Date(wideMonthlyLFS1$Date, format='%y-%m-%d')) # turn the data frame to time series obj.

dygraph(wideMonthlyLFS1, main = "Unemployment Rate by Region") %>%
  dyRangeSelector() %>%
  dyShading(from = "1990-1-1", to = "1991-1-1") %>%
  dyShading(from = "2008-7-1", to = "2009-4-1") %>%
  dyAxis("y", label = "Unemp. Rate (%)") %>%
  #dyEvent(input$RefMonth, "Reference Month", labelLoc = "bottom") %>%
  #dyLegend(show = "follow") %>%
  dyOptions(colors = RColorBrewer::brewer.pal(8, "Set2"), drawGrid = FALSE) %>%
  dyHighlight(highlightCircleSize = 5,
              highlightSeriesBackgroundAlpha = 0.2,
              hideOnMouseOut = TRUE)

## The above graph is very unsightly, but the intention is to show the numerous options and the excellent performance of dygraphs
## for graphing large time series datasets 


#---- Make ggplot2 interactive with ggiraph #----

## ggplot2 is the most well supported, preeminent graphical engine within the R community. As such, it is advantageous for myriad 
## reasons to retain its syntax and, if needed, add elements of interactivity on top of it. 
## One package that enables this process is "ggiraph"

# Unemployment rate by region, using only ggplot2

ggplot(data=monthlyLFS1 %>% filter(Date == "2016-10-01"), aes(x=Region, y=UnRate, fill=Region)) + 
  geom_bar(stat="identity") +
  ylab("Unemployment Rate (%)") + 
  theme(panel.background = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_text(angle=45, hjust=1 , size = 10),
        legend.position="none",
        axis.ticks = element_blank()) +
  scale_fill_brewer(palette="Set3") + 
  ggtitle("Unemployment Rate \n October 2016")

# Now the same graph, but this time using ggplot2 in conjunction with ggiraph

gg_bar <- ggplot(data=monthlyLFS1 %>% filter(Date == "2016-10-01"), 
                 aes(x=Region, y=UnRate, fill=Region)) + 
  geom_bar_interactive(stat="identity", aes(data_id = Region, tooltip = as.character(UnRate))) +
  ylab("Unemployment Rate (%)") + 
  theme(panel.background = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_text(angle=45, hjust = 1, size = 10),
        legend.position="none",
        axis.ticks = element_blank()) +
  scale_fill_brewer(palette="Set3") + 
  ggtitle("Unemployment Rate \n October 2016")

ggiraph(code = {print(gg_bar)})

## In the above code, a minimal amount of code was changed to introduce "hover" interactivity to the existing ggplot2 graph.
## `geom_bar` was replaced with `geom_bar_interactive`, and some additional arguments were added to define the tooltip. 
## In addition, the plot was saved as an object in the environment, which was then called in the `ggiraph()` function.

#---- Generate interactive table using DT package #----

## A very basic example of an interactive table using the DT package.
## Lots of options to customize functionalities. Allows for useful tasks such as sorting by unemployment rate. 
## In general, the package is at its most useful when embedded within a shiny application. 

datatable(monthlyLFS1 %>% 
                      filter(Date=="2016-10-01") %>%
                      select(Date,Region,UnRate),
                    colnames = c('Unemployment Rate' = 'UnRate'), # headers
                    rownames = FALSE,
                    extensions = 'Buttons',
                    class = 'cell-border stripe hover',           # styling options
                    options=list(
                      dom='Bt ',                                  # only show buttons and table, hence Bt
                      pageLength = 11,                            # the maximum number of elements to show; default = 10
                      buttons = 
                        list('copy', 'print', list(
                          extend = 'collection',
                          buttons = c('csv', 'excel'),
                          text = 'Download Data'
                                                  ))
                                ) 
                      )
