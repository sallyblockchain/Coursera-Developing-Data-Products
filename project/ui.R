# The user-interface definition of the Shiny web app.
library(shiny)

shinyUI(
    navbarPage("LEGO Set Visualizer", 
    # multi-page user-interface that includes a navigation bar.
        tabPanel("Explore the Data",
             sidebarPanel(
                sliderInput("timeline", 
                            "Timeline:", 
                            min = 1950,
                            max = 2015,
                            value = c(1996, 2015)),
                            #format = "####"),
                uiOutput("themesControl"), # the id
                actionButton(inputId = "clearAll", 
                             label = "Clear selection", 
                             icon = icon("square-o")),
                actionButton(inputId = "selectAll", 
                             label = "Select all", 
                             icon = icon("check-square-o"))
        
             ),
             mainPanel(
                 tabsetPanel(
                   # Data 
                   tabPanel(p(icon("table"), "Dataset"),
                            dataTableOutput(outputId="dTable")
                   ),
                   tabPanel(p(icon("line-chart"), "Visualize the Data"), 
                            sidebarPanel(
                                textInput(inputId="text1", label = "Input Text1"),
                                textInput(inputId="text2", label = "Input Text2"),
                                actionButton("goButton", "Go!")
                            ),
                            mainPanel(
                                p('Output text1'),
                                textOutput('text1'),
                                p('Output text2'),
                                textOutput('text2'),
                                p('Output text3'),
                                textOutput('text3')
                            )
                    ) # end of "Visualize" tab panel

                 )
                   
            )     
        ), # end of "Explore Dataset" tab panel
    
        tabPanel(p(icon("search"), "LookUp on Brickset Website"),
             mainPanel(
                 h4("The page popped-up is the LEGO set database on Brickset.com."),
                 h4("Step 1. Please type the Set ID below and press the 'Go!' button:"),
                 textInput(inputId="setid", label = "Input Set ID"),
                 #p('Output Set ID:'),
                 #textOutput('setid'),
                 actionButton("goButtonAdd", "Go!"),
                 h5('Output Address:'),
                 textOutput("address"),
                 p(""),
                 h4("Step 2. Please click the button below. You will be 
                    directed to the above address."),
                 p(""),
                 #tags$a(href=textOutput("address"), "Click here!")
                 textOutput("address2"),
                 actionButton("goButtonDirect", "Go to BrickSet Page for This Set!")
                 
             )         
        ),
        
        tabPanel("About",
                 mainPanel(
                   includeMarkdown("about.md")
                 )
        ) # end of "About" tab panel
    )
  
)
