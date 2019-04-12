GAFA Stock Shiny Application
========================================================
author: Jessie J. Q
date: 2019-04-11
autosize: true

Overview
========================================================


- This Shiny application is built for developing data product course week 4 project
- This course project is a peer-graded assignment
- This project has two parts: 1. create a Shiny application; 2. prepare a reproducible presentation
- Review criteria can be found on the course website

GAFA Stock Prices Dataset
========================================================


- This dataset contains GAFA (Google, Apple, Facebook, Amazon) stock prices until 20 April 2018.
- It contains 19260 observations and 8 variables
- The dataset is treated for building Shiny application. (Details can be found on Github.Below is the link)
- https://github.com/JJQU/Developing-Data-Products
- Data Source: https://www.kaggle.com/stexo92/gafa-stock-prices

About this Application
========================================================


- This application displays the trend of GAFA stock prices in the past 14 years
- This application is interactive. 
- User can choose the company name and the date that they are interested in knowing
- User can click on the button to show or hide labs


R Code for Data Preparation
========================================================

### Here is some R code


```r
library(dplyr)
library(ggplot2)
library(tidyr)
library(GGally)


gafa <- read.csv("C:/Users/JJQ/Documents/data/GAFA Stock Prices.csv", stringsAsFactors = FALSE)
str(gafa)
summary(is.na(gafa))

sub_gafa <- select(gafa, Open:Volume)
sub_gafa1 <- lapply(sub_gafa, function(x)(as.numeric(x)))
sub_gafa2 <- as.data.frame(sub_gafa1)

date <- as.Date(gafa$Date, '%d/%m/%Y')



gafa_stock <- cbind(gafa$Stock, date, sub_gafa2)
colnames(gafa_stock) <- c("Company", "Date", "Open", "High", "Low", "Price", "AdjClose", "Volume" )
```

Shiny Application
========================================================
### https://jjq5958.shinyapps.io/gafa/



```r
library(shiny)


ui <- fluidPage(
  
  titlePanel("GAFA Stock Prices"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "dataset",
                  label = "Choose a company:",
                  choices = c("Amazon", "Apple", "Facebook", "Google")),
      
      dateInput('date',
                label = 'Date input: yyyy-mm-dd',
                value = Sys.Date()
      ),
      
      numericInput(inputId = "obs",
                   label = "Number of observations to view:",
                   value = 10),
      
      checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
      checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE) 
      
    ),
    
    
    mainPanel(
      plotOutput("plot1"),
      tableOutput("view")
      
    )
))

server <- function(input, output) {
  datasetInput <- reactive({
    switch(input$dataset,
           "Apple" = apple2,
           "Amazon" = amazon2,
           "Facebook" = facebook2,
           "Google" = google2)
  })
  
  output$view <- renderTable({
    filter(datasetInput(), Date1 == input$date)
  })
  
  output$plot1 <- renderPlot({
    
    g <- ggplot(gafa_stock, aes(Date, Price, color = Company)) + geom_line() + xlab("Date") + ylab("Price")
    print(g)
    
  })
  
  
}

shinyApp(ui = ui, server = server)
```
