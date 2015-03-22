# server.R

library(quantmod)
source("helpers.R")


shinyServer(function(input, output) {
  
  dataInput <- reactive({  
    datall<-getSymbols(toupper(input$symb), src = "FRED", 
                    auto.assign = FALSE)
    dat<-datall[index(datall) >= input$dates[1] & index(datall) <= input$dates[2]]
    })
  
  finalInput <- reactive({
    if (!input$adjust) return(dataInput())
    adjust(input)
  })
  
  output$plot <- renderPlot({
    chartSeries(finalInput(), theme = chartTheme("white"), 
                type = "line", log.scale = input$log, TA = NULL, name=input$symb)
  })
})