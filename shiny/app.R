#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

source("model.r")

# 1. SERVER --------------------------------------------------------------------

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output, session) {
  
  predicted_text <- reactive(next_word(input$text_in_id_1))
  output$text_out_id_1 <- predicted_text
  # Clear
  observeEvent(input$button_1, {
    updateTextInput(session, "text_in_id_1",  value = "")
  })
  # Use predicted
  observeEvent(input$button_2, { 
    updateTextInput(session, "text_in_id_1",
                    value = paste(input$text_in_id_1, predicted_text()))
  })
})

# 2. UI ------------------------------------------------------------------------

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
   
   # Application title
   titlePanel("R-Capstone"),
   
   sidebarLayout(
     sidebarPanel(
       tags$p(""),
       tags$h3("Predicted next word:"),
       wellPanel(h1(textOutput("text_out_id_1"), align = "center")),
       fluidRow(
         column(width = 4,  offset = 0,
                actionButton("button_1",
                             label = "Clear",
                             icon = icon("refresh"))
         ),
         column(width = 4, offset = 3,
                actionButton("button_2",
                             label = "Add",
                             icon = icon("plus-square"))
         )
       )
     ),
     mainPanel(
       tags$p(""),
       tags$h3("Please, enter your text:"),
       h4(tags$textarea(id = "text_in_id_1", rows = 10, cols = 40, "")))
   )
))

# 2. APP -----------------------------------------------------------------------

# Run the application 
shinyApp(ui = ui, server = server)

