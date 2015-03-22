
# adjusts  
# values provided by the Federal Reserve of St. Louis

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