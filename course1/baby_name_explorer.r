# Build a shiny app to explore the popularity of baby names

# load libraries
library(shiny)
library(babynames)
library(ggplot2)

# create UI
ui <- fluidPage(
  
  ### This way, they will be displayed one below the other
  # titlePanel("Baby Name Explorer"),
  # textInput("name", "Enter name", "Roxana"),
  # plotOutput('trend')
  
  ### But we need to have them one next to the other:
  titlePanel("Baby Name Explorer"),
  sidebarLayout(
    sidebarPanel(
      textInput("name", "Enter Name", "Roxana")
    ),
    
    mainPanel(
      plotOutput("trend")
    )  
  )
)

# create Server
server <- function(input, output){
  output$trend <- renderPlot({
    # first, we select the data for the given name
    data_name <- subset(babynames, name == input$name)
    
    ggplot(data_name) +
      geom_line(aes(x = year, y = prop, color = sex))
  })
}

# Run app
shinyApp(ui = ui, server = server)