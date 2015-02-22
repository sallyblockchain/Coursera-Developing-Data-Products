library(shiny)

# Load data processing file
source("data_processing.R")
themes <- sort(unique(data$theme))

# Shiny server
shinyServer(
  function(input, output) {
    output$text1 <- renderText({input$text1})
    output$text2 <- renderText({input$text2})
    output$text3 <- renderText({
      input$goButton
      isolate(paste(input$text1, input$text2))
    })
    
    # Initialize reactive values
    values <- reactiveValues()
    values$themes <- themes
    
    # Create event type checkbox
    output$themesControl <- renderUI({
        checkboxGroupInput('themes', 'LEGO Themes', 
                           themes, selected = values$themes)
    })
    
    # Add observer on select-all button
    observe({
        if(input$selectAll == 0) return()
        values$themes <- themes
    })
    
    # add observer on clear-all button
    observe({
        if(input$clearAll == 0) return()
        values$themes <- c() # empty list
    })

    # Prepare dataset
    dataTable <- reactive({
        groupByTheme(data, input$timeline[1], 
                     input$timeline[2], input$themes)
    })
    
    # Render data table
    output$dTable <- renderDataTable(
      {dataTable()}, options = list(bFilter = FALSE, iDisplayLength = 50)
    )
    
  }
)