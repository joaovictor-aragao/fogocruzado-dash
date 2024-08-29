shinyServer(function(input, output, session){
  
  observeEvent(input$state,{
    
    # Get occurances
    occs <- getOccurances(base_url = BASE_URL, token = TOKEN, id_state = input$state)
    
    ## list of motivations to filter
    motiv_list <- c("All", dimnames(table(occs[, 5]))[[1]])
    
    ##------- consulting the dataset, name: df
    output$table <- renderTable({head(occs, input$n)})
    
    output$motivation_table <- renderTable({tabFreqCat(occs, 5)})
    
    output$barplot <- renderPlot({plotGen(occs, Date, input$motivation)})
    
    output$texting <- renderText({ input$state })
    
  })
})