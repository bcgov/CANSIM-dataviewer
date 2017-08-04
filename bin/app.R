# setwd("C:/RProjects/LFS/LFSApp")

MonthlyLFSx1 <- readRDS("Data/MonthlyLFSx1.rds")
MonthlyLFSx2 <- readRDS("Data/MonthlyLFSx2.rds")
wide_UnRate <- readRDS("Data/wideUnRate.rds")

library(dplyr)
#library(ggplot2)
library(CANSIM2R) # this package downloads CANSIM tables
#library(Hmisc) # need this package to read labels
library(zoo) #to deal with dates that only have year and month, with no days
library(shiny)
library(DT)
#library(car)
library(rmarkdown)
library(rCharts)
#library(rsconnect)
library(dygraphs)
library(xts)

server <- function(input, output) {
  
  output$LFSTable <- DT::renderDataTable(MonthlyLFSx1 %>% 
                                           filter(Date==input$RefMonth2) %>%
                                           select(t, Date,i,Employment,UnRate),
                                        colnames = c('Region' = 'i',
                                                     'Unemployment Rate' = 'UnRate'
                                                     ), # headers
                                         rownames = FALSE,
                                         extensions = 'Buttons',
                                         class = 'cell-border stripe hover', #styling opts.
                                         options=list(
                                           dom='Bt ', # only show buttons and table, hence Bt
                                           pageLength = 11, # the maximum number of elements to show; default = 10
                                           buttons = 
                                             list('copy', 'print', list(
                                               extend = 'collection',
                                               buttons = c('csv', 'excel'),
                                               text = 'Download Data'
                                             )),
                                           columnDefs = list(
                                             list(targets={{0}},visible = FALSE)
                                             ) # hide first column
                                         ) 
  ) 
  
  
  output$ReferenceMonth <- renderText( # displaying reactive output
    {
      
      paste("The reference month is:", input$RefMonth)
      
    }
  )
  
  output$ReferenceRegion <- renderText( 
    {
      
      paste("The reference region is:", input$Region)
      
    }
  )
  
  output$UR <- renderText( 
    {
      
      paste("The current unemployment rate is: ", MonthlyLFSx1 %>% 
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(UnRate),
            "%",sep="")
      
      
    }
  )
  
  output$URLast <- renderText(
    {
      
      paste("The unemployment rate last month was: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(URLast),
            "%",sep="")
      
      
    }
  )
  
  output$URLastYear <- renderText(
    {
      
      paste("The unemployment rate last year was: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(URLastYear),
            "%",sep="")
      
      
    }
  )
  
  output$EmpChangeMonth <- renderText(
    {
      
      paste("since last month, employment changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(MoMEmp15Over),
            sep="")
      
      
    }
  )
  
  output$LFChangeMonth <- renderText(
    {
      
      paste("since last month, labour force changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(MoMLF15Over),
            sep="")
      
      
    }
  )
  
  output$EmpChangeYear <- renderText(
    {
      
      paste("since last year, employment changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(YoYEmp15Over),
            sep="")
      
      
    }
  )
  
  output$LFChangeYear <- renderText(
    {
      
      paste("since last year, labour force changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(YoYLF15Over),
            sep="")
      
      
    }
  )
  
  output$FTMonth <- renderText(
    {
      
      paste("since last month, full-time jobs changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(MoMEmpFT15Over),
            sep="")
      
      
    }
  )
  
  output$PTMonth <- renderText(
    {
      
      paste("since last month, part-time jobs changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(MoMEmpPT15Over),
            sep="")
      
      
    }
  )
  
  output$FTMonth1524 <- renderText(
    {
      
      paste("since last month, full-time jobs for 15-24 changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(MoMEmpFT1524),
            sep="")
      
      
    }
  )
  
  output$FTMonth2554 <- renderText(
    {
      
      paste("since last month, full-time jobs for 25-54 changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(MoMEmpFT2554),
            sep="")
      
      
    }
  )
  
  output$FTMonth55Over <- renderText(
    {
      
      paste("since last month, full-time jobs for 55 & over changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(MoMEmpFT54Over),
            sep="")
      
      
    }
  )
  
  output$Public <- renderText(
    {
      
      paste("since last month, public sector jobs changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(MoMEmpPublic),
            sep="")
      
      
    }
  )
  
  output$Private <- renderText(
    {
      
      paste("since last month, private sector jobs changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(MoMEmpPrivate),
            sep="")
      
      
    }
  )
  
  output$Self <- renderText(
    {
      
      paste("since last month, self employment changed by : ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i==input$Region) %>%
              select(MoMEmpSelf),
            sep="")
      
      
    }
  )
  
  output$CanUR <- renderText(
    {
      
      paste("In Canada, the current unemployment rate is: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i=="Canada") %>%
              select(UnRate), "%",
            sep="")
      
      
    }
  )
  
  output$CanURLast <- renderText(
    {
      
      paste("In Canada, the unemployment rate last month was: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i=="Canada") %>%
              select(URLast), "%",
            sep="")
      
      
    }
  )
  
  output$CanMoMEmp <- renderText(
    {
      
      paste("In Canada, since last month, employment changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i=="Canada") %>%
              select(MoMEmp15Over),
            sep="")
      
      
    }
  )
  
  output$CanFT <- renderText(
    {
      
      paste("In Canada, full-time jobs changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i=="Canada") %>%
              select(MoMEmpFT15Over),
            sep="")
      
      
    }
  )
  
  output$CanPT <- renderText(
    {
      
      paste("In Canada, part-time jobs changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i=="Canada") %>%
              select(MoMEmpPT15Over),
            sep="")
      
      
    }
  )
  
  output$CanLF <- renderText(
    {
      
      paste("In Canada, labour force changed by: ", MonthlyLFSx1 %>%
              filter(Date==input$RefMonth) %>%
              filter(i=="Canada") %>%
              select(MoMLF15Over),
            sep="")
      
      
    }
  )
  
  # Shiny code to enter charts and graphs
  output$URPlot <- renderChart({
    
    # Render a discrete bar graph using rChart and the java script package nvd3
    
    n1 <- nPlot(x= 'i', y = 'UnRate', data = MonthlyLFSx1 %>% filter(Date==input$RefMonth), 
                type = 'discreteBarChart', dom = 'URPlot')
    n1$yAxis(axisLabel = "%", width=40) # width can't exceed 64; won't show otherwise
    n1$chart(color = c('#263359', '#263359', '#592633', '#263359', '#263359', '#263359', '#263359', '#263359', 
                      '#263359', '#263359', '#263359'))
    
    # Commented code below is handy for multile bar chart type as opposed to discrete
    #n1$chart(color = "#! function(d){ return 'blue'} !#")
    #n1$chart(reduceXTicks = FALSE, showLegend = FALSE, showControls = FALSE) # this is only applicable for multipleBarCharts 
    
    n1$xAxis(staggerLabels = TRUE) # Staggering axis labels; otherwise some labels won't show
    n1
    
    
  })
  
  # output$TimeSeries <- renderChart({
  #   
  #   # Render a discrete bar graph using rChart and the java script package Rickshaw or nvd2
  #   
  #   # r1 <- Rickshaw$new()
  #   # r1$layer(V922 ~ Var2, data = MonthlyLFSx2, group = "i", type="line")
  #   # r1$set(slider = TRUE, dom="TimeSeries")
  #   # return(r1)
  #   
  #   
  #   n2 <- nPlot(UnRate ~ Date, 
  #               data = MonthlyLFSx2 %>% filter(i=="British Columbia" | i=="Canada"), group = "i", 
  #               type = 'lineWithFocusChart', dom = "TimeSeries")
  #   n2$xAxis(tickFormat="#!function(d) {return d3.time.format.utc('%Y-%m-%d')(new Date(d * 24 * 60 * 60 * 1000));}!#" )
  #   n2
  #   
  #   
  #   
  # })
  
  output$dygraph <- renderDygraph({
    
    wide_UnRate2 <- wide_UnRate[,input$Region2] # using base syntax to allow for multiple inputs
    wide_UnRate3 <- xts(wide_UnRate2, as.Date(wide_UnRate$Date, format='%y-%m-%d')) # convert the above table to time series
    
    dygraph(wide_UnRate3, main = "Unemployment Rate by Region") %>%
      dyRangeSelector() %>%
      dyShading(from = "1990-1-1", to = "1991-1-1") %>%
      dyShading(from = "2009-1-1", to = "2011-1-1") %>%
      dyAxis("y", label = "Unemp. Rate (%)") %>%
      dyEvent(input$RefMonth, "Reference Month", labelLoc = "bottom") %>%
      #dyLegend(show = "follow") %>%
      dyOptions(colors = RColorBrewer::brewer.pal(8, "Set2"), drawGrid = FALSE) %>%
      dyHighlight(highlightCircleSize = 5,
                highlightSeriesBackgroundAlpha = 0.2,
                hideOnMouseOut = TRUE)
  })
  
}

  ################# UI section starts below #################

# Use a fluid Bootstrap layout
ui <- fluidPage(
  
  theme = "app.css",
  
  # Give the page a title
  titlePanel("Labour Force Survey Highlights"),
  
  tabsetPanel(
    
          # First tab
        tabPanel("Bar Graph", 
          
          sidebarLayout(      
    
              
              sidebarPanel(
                  selectInput("RefMonth", "Reference Month", 
                    unique(as.character(MonthlyLFSx1$Date)),selected = max(MonthlyLFSx1$Date)),
                  selectInput("Region", "Region",
                    unique(as.character(MonthlyLFSx1$i)),selected = "British Columbia"),
                  hr(),
                  textOutput("ReferenceMonth"), 
                  textOutput("ReferenceRegion"),
                  textOutput("UR"),
                  textOutput("URLast"),
                  textOutput("EmpChangeMonth"),
                  textOutput("LFChangeMonth"),
                  textOutput("EmpChangeYear"),
                  textOutput("LFChangeYear"),
                  textOutput("URLastYear"),
                  hr(),
                  textOutput("FTMonth"),
                  textOutput("PTMonth"),
                  textOutput("FTMonth1524"),
                  textOutput("FTMonth2554"),
                  textOutput("FTMonth55Over"),
                  hr(),
                  textOutput("Public"),
                  textOutput("Private"),
                  textOutput("Self"),
                  hr(),
                  textOutput("CanUR"),
                  textOutput("CanURLast"),
                  textOutput("CanMoMEmp"),
                  textOutput("CanFT"),
                  textOutput("CanPT"),
                  textOutput("CanLF")
                          ),
                     
            # The main panel
              mainPanel(
                 h3("Unemployment Rate",align="center"),
                 showOutput("URPlot", lib="nvd3") # The bar graph for all Regions
                        )         
                    )
              ), 
        
        # Second tab
        
        tabPanel("Line Graph",
                 
                 sidebarLayout(      
                   
                   # Define the sidebar with one input
                    sidebarPanel(
                        selectInput("Region2", "Region(s)",
                                 unique(as.character(MonthlyLFSx1$i)),selected = "British Columbia",multiple = TRUE),
                        helpText("Can select multiple regions")
                    
                   ),
                 
                 mainPanel(
                   
                   dygraphOutput("dygraph")
                   
                   
                 
                   )         
                 )
              ), 
        
        
        # Third tab
        
          tabPanel("Data Table",
           
                 sidebarLayout(      
             
             # Define the sidebar 
                  sidebarPanel(
                      selectInput("RefMonth2", "Reference Month", 
                           unique(as.character(MonthlyLFSx1$Date)),selected = max(MonthlyLFSx1$Date))
               
             ),
           
           mainPanel(
                     DT::dataTableOutput("LFSTable"))  # The main datatable
             
             
             
             
             
           )
        )
      )
        
        
        
    )
      


shinyApp(ui = ui, server = server)