library(shiny)
library(dplyr)
library(ggplot2)
library(readxl)

#Define user input function
ui <- fluidPage(
  #sidebar layout with input and output definitions
  sidebarLayout(
    #input: select variables to plot
    sidebarPanel(
    #select variables for y axis
 
    selectInput(inputId = "nation",
                label = "Select one or more Countries:", 
                choices = c(Trade_SSA$Country),
                multiple = TRUE,
                selected = "India"),
   
    #select variable for x axis
    sliderInput(inputId = "time",
                label="Select Time Period:",
                min=1992, max= 2016,
                value = c(2000, 2005),
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
  #create a reactive function
  plotdata <- reactive({
    Trade_SSA %>% filter(Country==input$nation) %>% filter(Years==input$time)
  })
  
  # create the line chart object that plotOutput is expecting
  output$linechart <- renderPlot({
    ggplot(data=plotdata(), aes_string(x=Years, y=Trade_Value))
    geom_line() + facet_grid(~ Trade_Flow) + theme(axis.text.x=element_text(angle=-55, hjust=0), legend.position = "top")
  })
}

#Create the shiny app object
shinyApp(ui=ui, server=server)