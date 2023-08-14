library(shiny)
library(ggplot2)
library(dplyr)

data <- read.csv("depression_data.csv")


server <- function(input, output) {
  output$bar_chart <- renderPlot({
    selected_year <- input$year
    year_data <- data %>%
      filter(Year == selected_year) %>%
      pivot_longer(cols = starts_with("x"), names_to = "Age_Group", values_to = "Depression_Rate")
    
    ggplot(year_data, aes(x = Age_Group, y = Depression_Rate, fill = Age_Group)) +
      geom_bar(stat = "identity") +
      labs(title = paste("Age Groups in the US in", selected_year),
           x = "Age Group", y = "Depression Rate") +
      scale_fill_discrete(labels = c("X10.to.14.years.old" = "10 to 14 years old", "X15.to.19.years.old" = "15 to 19 years old", "X20.to.24.years.old" = "20 to 24 years old", "X25.to.29.years.old" = "25 to 29 years old", "X30.to.34.years.old" = "30 to 34 years old","X35.to.49.years.old" = "35 to 49 years old", "X50.to.69.years.old" = "50 to 69 years old", "X70.years.old" = "70 years old" )) +
      scale_x_discrete(labels = c("X10.to.14.years.old" = "10 to 14 years old", "X15.to.19.years.old" = "15 to 19 years old", "X20.to.24.years.old" = "20 to 24 years old", "X25.to.29.years.old" = "25 to 29 years old", "X30.to.34.years.old" = "30 to 34 years old","X35.to.49.years.old" = "35 to 49 years old", "X50.to.69.years.old" = "50 to 69 years old", "X70.years.old" = "70 years old" )) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
}