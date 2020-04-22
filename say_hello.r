library(shiny)

# Wish hello to a specific person

ui <- fluidPage(
  
  textInput("name", "Please tell me your name: "),
  textOutput("msg")
)

server <- function(input, output){
  output$msg <- renderText({
    paste("Hello ", input$name, "!!!")
  })
}

shinyApp(ui = ui, server = server)