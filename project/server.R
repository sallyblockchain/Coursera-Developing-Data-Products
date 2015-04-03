library(shiny)

# Load data processing file
source("data_processing.R")
themes <- sort(unique(data$theme))

# Shiny server
shinyServer(
  function(input, output) {
#     output$text1 <- renderText({input$text1})
#     output$text2 <- renderText({input$text2})
#     output$text3 <- renderText({
#       input$goButton
#       isolate(paste(input$text1, input$text2))
#     })
    output$setid <- renderText({input$setid})
    
    output$address <- renderText({
        input$goButtonAdd
        isolate(paste("http://brickset.com/sets/", 
                input$setid, sep=""))
        
    })
    
#     getPage<-function(url) {
#         return(tags$iframe(src = url, 
#                            style="width:100%;",  
#                            frameborder="0", id="iframe", 
#                            height = "500px"))
#     }
    
    openPage <- function(url) {
        return(tags$a(href=url, "Click here!", target="_blank"))
    }
    
    output$inc <- renderUI({ 
        input$goButtonDirect
        isolate(openPage(paste("http://brickset.com/sets/", 
                               input$setid, sep="")))
        ## Can't open iframe below 
        # Got This request has been blocked; 
        # the content must be served over HTTPS error msg
        # Mixed Content: The page at 'https://xiaodan.shinyapps.io/LegoDatasetVisualization/' 
        # was loaded over HTTPS, but requested an insecure resource 'http://brickset.com/sets/'. 
        # This request has been blocked; the content must be served over HTTPS.
        #isolate(getPage(paste("//brickset.com/sets/", 
        #                       input$setid, sep="")))  
    })
    
    
    # Initialize reactive values
    values <- reactiveValues()
    values$themes <- themes
    
    # Create event type checkbox
    output$themesControl <- renderUI({
        checkboxGroupInput('themes', 'LEGO Themes:', 
                           themes, selected = values$themes)
    })
    
    # Add observer on select-all button
    observe({
        if(input$selectAll == 0) return()
        values$themes <- themes
    })
    
    # Add observer on clear-all button
    observe({
        if(input$clearAll == 0) return()
        values$themes <- c() # empty list
    })

    # Prepare dataset
    dataTable <- reactive({
        groupByTheme(data, input$timeline[1], 
                     input$timeline[2], input$pieces[1],
                     input$pieces[2], input$themes)
    })

    dataTableByYear <- reactive({
        groupByYearAgg(data, input$timeline[1], 
                    input$timeline[2], input$pieces[1],
                    input$pieces[2], input$themes)
    })

    dataTableByPiece <- reactive({
        groupByYearPiece(data, input$timeline[1], 
                       input$timeline[2], input$pieces[1],
                       input$pieces[2], input$themes)
    })

    dataTableByPieceAvg <- reactive({
        groupByPieceAvg(data, input$timeline[1], 
                        input$timeline[2], input$pieces[1],
                        input$pieces[2], input$themes)
    })

    dataTableByPieceThemeAvg <- reactive({
        groupByPieceThemeAvg(data, input$timeline[1], 
                             input$timeline[2], input$pieces[1],
                             input$pieces[2], input$themes)
    })
    
    # Render data table
    output$dTable <- renderDataTable({
        dataTable()
    } #, options = list(bFilter = FALSE, iDisplayLength = 50)
    )
    
    output$themesByYear <- renderChart({
        plotThemesCountByYear(dataTableByYear())
    })

    output$piecesByYear <- renderChart({
        plotPiecesByYear(dataTableByPiece())
    })

    output$piecesByYearAvg <- renderChart({
        plotPiecesByYearAvg(dataTableByPieceAvg())
    })

    output$piecesByThemeAvg <- renderChart({
        plotPiecesByThemeAvg(dataTableByPieceThemeAvg())
    })
    
  } # end of function(input, output)
)