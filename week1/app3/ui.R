shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Diabetes prediction"),
    sidebarPanel(
      numericInput('glucose', 'Glucose mg/dl', 90, 
                   min = 50, max = 200, step = 5),
      submitButton('Submit') # if removing this, 
                             # it'll display the result synchronously
    ),
    mainPanel(
      h3('Results of prediction'),
      h4('You entered'),
      verbatimTextOutput("inputValue"),
      h4('Which resulted in a prediction of '),
      verbatimTextOutput("prediction")
    )
  )
)