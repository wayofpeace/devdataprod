# helpers.R contains functions to support the EconChart applications
# it contains functions to adjust values provided by the Federal Reserve of St. Louis
# it detects the periodicity of the economic indicator selected (i.e. monthly, quarterly or annual)
# using the correct periodicity it computes the year over year percentage change in the indicator
# the adjust function returns the year over year percentage change for the selected date range

adjust<-function(input) { 
  datalladj<-getSymbols(toupper(input$symb), src = "FRED", 
                     auto.assign = FALSE)

  if (periodicity(datalladj)$scale=="monthly") {
    datalladj<-100*(datalladj/Lag(datalladj,12)-1)
    datalladj<-datalladj[!is.na(datalladj)]
    datalladj<-datalladj[!is.infinite(datalladj)]
  }
  else if (periodicity(datalladj)$scale=="quarterly") {
    datalladj<-100*(datalladj/Lag(datalladj,4)-1)
    datalladj<-datalladj[!is.na(datalladj)]
    datalladj<-datalladj[!is.infinite(datalladj)]
  }
  else if (periodicity(datalladj)$scale=="annual") {
    datalladj<-100*(datalladj/Lag(datalladj,1)-1)
    datalladj<-datalladj[!is.na(datalladj)]
    datalladj<-datalladj[!is.infinite(datalladj)]
  }
  
  dat<-datalladj[index(datalladj) >= input$dates[1] & index(datalladj) <= input$dates[2]]
}
