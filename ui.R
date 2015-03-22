# ui.R for EconChart app
# this code sets up the layout for the EconChart app
# it creates a textbox in which the user can type a mnemonic for an economic indicator
# it sets up drop down menus for date ranges for the display of the economic indicator on a plot
# it sets up two checkboxes for options to plot using hte logarithmic scale and as a year over percent change

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
