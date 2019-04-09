
library(shiny)

shinyUI(fluidPage(
  
  titlePanel("GAFA Stock Prices"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("Company", "Company Name:", c("Google", "Apple", "Facebook", "Amazon")),
      dateRangeInput("Date", "Date Range:", 
                     start = "2004-08-19",
                     end = "2018-04-20"),
       checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
       checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE), 
       checkboxInput("show_title", "Show/Hide Title")
       
    ),

    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("plot1")
      
    )
  )
))
