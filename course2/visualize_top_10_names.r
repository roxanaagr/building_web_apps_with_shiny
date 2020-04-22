# Build a Shiny app that lets users visualize the top 10 most popular 
# names by sex by adding an input to let them choose the sex


library(shiny)
library(ggplot2)
library(babynames)
library(dplyr)
library(DT)
library(plotly)

ui <- fluidPage(
  titlePanel("What's in a Name?"),
  
  selectInput("sex", "Please select the gender", choices = c("F", "M")),
  
  sliderInput("year", "Select year", 
              value = 1900, 
              min = 1900, 
              max = 2010),
  
  # Add a table output
  tableOutput("table_top_10_names"),
  
  # Add a DT table
  DT::DTOutput("table_dt_top_10_names"),
  
  # Plot output
  plotOutput("plot_top_10_names"),
  
  # Interactive plot output (using plotly)
  plotly::plotlyOutput("plot_plotly_top_10_names")
)


server <- function(input, output){
  # Render plot of top 10 most popular names
  
  # first, we need to select the top 10 names
  top_10_names <- function(){
    top_10_names <- babynames %>%
      filter(sex == input$sex) %>%
      filter(year == input$year) %>%
      top_n(10, prop)
  }

  output$plot_top_10_names <- renderPlot({

    ggplot(top_10_names(), aes(x = name, y = prop)) +
      geom_col(fill = "#263e63")
  })
  
  output$plot_plotly_top_10_names <- plotly::renderPlotly({
    ggplot(top_10_names(), aes(x = name, y = prop)) +
      geom_col(fill = "#263e63")
  })
  
  
  
  output$table_top_10_names <- renderTable(top_10_names())
  
  output$table_dt_top_10_names <- DT::renderDT(DT::datatable(top_10_names()))
}

shinyApp(ui = ui, server = server)