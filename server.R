library(shiny)
library(ggplot2)
library(dplyr)


shinyServer(function(input, output) {
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
  
  
})



