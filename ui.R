library(shiny)

shinyUI(fluidPage(
  titlePanel("Economic Data Charter"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select an economic time series to chart. 
        Information is sourced from Federal Reserve Board of St. Louis.
        Examples: GDP is gross domestic product.  UNRATE is the unemployment rate."),
    
      textInput("symb", "Symbol", "GDP"),
    
      dateRangeInput("dates", 
        "Date range",
        start = "2000-01-01", 
        end = as.character(Sys.Date())),
   
      actionButton("get", "Get Econ Data"),
      
      br(),
      br(),
      
      checkboxInput("log", "Plot y axis on log scale", 
        value = FALSE),
      
      checkboxInput("adjust", 
        "Compute Year over Year Pct Change", value = FALSE)
    ),
    
    mainPanel(plotOutput("plot"))
  )
))