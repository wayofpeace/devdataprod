# server.R for the EconChart app
# the server app below takes the user input for the economic indicator mnemonic
# it then pulls in the data from the Federal Reserve of St Louis website site
# it calls function in the helper.R file if the user selects checkbox options
#    the helpers.R file contains funtions to performan statistical computations (using helpers.R for organization) 
# it creates the output plot to be displayed by calling the chartSeries function

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
