library(shiny)

shinyServer(
  function(input, output) {
    output$text1 <- renderText({input$text1})
    output$text2 <- renderText({input$text2})
    output$text3 <- renderText({
      input$goButton
      isolate(paste(input$text1, input$text2))
    })
    output$table <- renderDataTable(
      {dataTable()}, options = list(bFilter = FALSE, iDisplayLength = 50)
    )

    output$downloadData <- downloadHandler(
      filename = 'data.csv',
      content = function(file) {
        write.csv(dataTable(), file, row.names=FALSE)
      }
    )
    
  }
)