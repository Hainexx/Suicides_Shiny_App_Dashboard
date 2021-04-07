####

library(flexdashboard) # Dashboard package
library(highcharter) # Interactive data visualizations
library(viridis) # Color gradients
library(tidyverse) 
library(countrycode) # Converting country names/codes
library(DT) # Displaying data tables
library(crosstalk) # Provides interactivity for HTML widgets
library(plotly) # Interactive data visualizations
library(shiny) #shiny

data <- read.csv('https://raw.githubusercontent.com/SabaTavoosi/Suicide-data---Interactive-dashboard/master/master.csv') %>%
  filter(year != 2016, # filter out 2016 and countries with 0 data. 
         country != 'Dominica',
         country != 'Saint Kitts and Nevis')

# Fix the names of some of the countries in our data to match the country names 
# used by our map later on so that they'll be interpreted and displayed. 
data <- data %>%
  mutate(country = fct_recode(country, "The Bahamas" = "Bahamas"),
         country = fct_recode(country, "Cape Verde" = "Cabo Verde"),
         country = fct_recode(country, "South Korea" = "Republic of Korea"),
         country = fct_recode(country, "Russia" = "Russian Federation"),
         country = fct_recode(country, "Republic of Serbia" = "Serbia"),
         country = fct_recode(country, "United States of America" = "United States"))

# Reorder levels of age to be in chronological order.
data$age <- factor(data$age, levels = c("5-14 years", "15-24 years", "25-34 years", "35-54 years", "55-74 years", "75+ years"))

custom_theme <- hc_theme(
  colors = c('#5CACEE', 'green', 'red'),
  chart = list(
    backgroundColor = '#FAFAFA', 
    plotBorderColor = "black"),
  xAxis = list(
    gridLineColor = "C9C9C9", 
    labels = list(style = list(color = "#333333")), 
    lineColor = "#C9C9C9", 
    minorGridLineColor = "#C9C9C9", 
    tickColor = "#C9C9C9", 
    title = list(style = list(color = "#333333"))), 
  yAxis = list(
    gridLineColor = "#C9C9C9", 
    labels = list(style = list(color = "#333333")), 
    lineColor = "#C9C9C9", 
    minorGridLineColor = "#C9C9C9", 
    tickColor = "#C9C9C9", 
    tickWidth = 1, 
    title = list(style = list(color = "#333333"))),   
  title = list(style = list(color = '#333333', fontFamily = "Lato")),
  subtitle = list(style = list(color = '#666666', fontFamily = "Lato")),
  legend = list(
    itemStyle = list(color = "#333333"), 
    itemHoverStyle = list(color = "#FFF"), 
    itemHiddenStyle = list(color = "#606063")), 
  credits = list(style = list(color = "#666")),
  itemHoverStyle = list(color = 'gray'))

# Create tibble for our line plot.  
overall_tibble <- data %>%
  select(year, suicides_no, population) %>%
  group_by(year) %>%
  summarise(suicide_capita = round((sum(suicides_no)/sum(population))*100000, 2)) 

# Create tibble for sex plot.
sex_tibble <- data %>%
  select(year, sex, suicides_no, population) %>%
  group_by(year, sex) %>%
  summarise(suicide_capita = round((sum(suicides_no)/sum(population))*100000, 2))


# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Ozone level!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      sliderInput("slider", label = h3("Years Range"), min = 1985, 
                  max = 2015, value = c(1985, 2015))
    
     
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotlyOutput(outputId = "main"),
      plotlyOutput(outputId = "pie_sex")
      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  

  output$main <- renderPlotly({
    
    plot_ly(overall_tibble, grid = F, x = ~year, y = ~suicide_capita, color = ~suicide_capita, size = ~suicide_capita, mode = 'lines+markers', legendgroup = F) %>% layout(
        xaxis = list(
          range = input$slider)
      )
    
    
  })
  
  output$pie_sex <- renderPlotly({
    plot_ly(sex_tibble, labels = ~sex, values = ~suicide_capita, type = 'pie', textposition = 'inside',
            textinfo = 'label+percent',
            insidetextfont = list(color = '#FFFFFF'),
            hoverinfo = 'text',
            marker = list(colors = c('rgb(211,94,96)', 'rgb(128,133,133)', 'rgb(144,103,167)', 'rgb(171,104,87)', 'rgb(114,147,203)'),
                          line = list(color = '#FFFFFF', width = 1)),
            #The 'pull' attribute can also be used to create space between the sectors
            showlegend = FALSE)
  })
  
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
