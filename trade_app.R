library(shiny)

#Define user input function
ui <- fluidPage(
  #sidebar layout with input and output definitions
  sidebarLayout(
    #input: select variables to plot
    sidebarPanel(
    #select variables for y axis
 
    selectInput(inputId = "y",
                label = "Country:", 
                choices = c(Trade_SSA$Country),
                multiple = TRUE,
                selected = "India"),
    #select variable for x axis
    sliderInput(inputId = "x",
                label="Select Time Period:",
                min=1992, max= 2016,
                value = c(1999, 2005),
                step=1)
    ),
    #output: show line chart
    mainPanel(
      plotOutput(outputId = "linechart")
    )
  )
)

#define server function
server <- function(input, output) {
  # create the line chart object that plotOutput is expecting
  output$linechart <- renderPlot({
    ggplot(data=Trade_SSA, aes_string(x=input$x, y=input$y))
    geom_line() 
  })
}

#Create rhe shiny app object
shinyApp(ui=ui, server=server)