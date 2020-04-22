
# Load shiny
library(shiny)

# Create the UI
ui <- fluidPage(
  
  textInput("name", "Enter a name: "),
  textOutput('q')
  
)

# Define a custom function to create the server
server <- function(input, output, session) {
  output$q <- renderText({
    paste("Do you prefer dogs or cats,", input$name, "?")
  })
}


# Run the app
shinyApp(ui = ui, server = server)