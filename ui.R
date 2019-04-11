
library(shiny)

shinyUI(fluidPage(
  
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
  )
))
