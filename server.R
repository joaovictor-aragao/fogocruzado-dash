library(shiny)

shinyServer(function(input, output, session){
  

  output$value <- renderText({input$state})
  
  ##------- consulting the dataset, name: df
  
  output$table <- renderTable({
    head(occs, input$n)
  })

  
})