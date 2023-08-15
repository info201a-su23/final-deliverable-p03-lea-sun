library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)


server <- function(input, output) {
  
  reactive_bar_data <- reactive({
    year_data <- depressionrates %>%
      filter(year == input$year) %>%
      pivot_longer(cols = c("10_14_years_old", "15_19_years_old", "20_24_years_old", "25_29_years_old", "30_34_years_old", "50_69_years_old", "70_years_old"),
                   names_to = "Age_Group", values_to = "Depression_Rate")
    return(year_data)
  })
  
  output$bar_chart <- renderPlot({
    year_data <- reactive_bar_data()
    # print(year_data)
    
    ggplot(year_data, aes(x = Age_Group, y = as.numeric(Depression_Rate), fill = Age_Group)) +
      geom_bar(stat = "identity") +
      scale_fill_discrete(labels = c("10_14_years_old" = "10 to 14 years old", "15_19_years_old" = "15 to 19 years old", "20_24_years_old" = "20 to 24 years old", "25_29_years_old" = "25 to 29 years old", "30_34_years_old" = "30 to 34 years old", "50_69_years_old" = "50 to 69 years old", "70_years_old" = "70 years old" )) +
      scale_x_discrete(labels = c("10_14_years_old" = "10 to 14 years old", "15_19_years_old" = "15 to 19 years old", "20_24_years_old" = "20 to 24 years old", "25_29_years_old" = "25 to 29 years old", "30_34_years_old" = "30 to 34 years old", "50_69_years_old" = "50 to 69 years old", "70_years_old" = "70 years old" )) +
      labs(title = paste("Age Groups in the US in", input$year),
           x = "Age Group", y = "Depression Rate (%)") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  output$comparison_chart <- renderPlot({
    selected_age_groups <- input$checkGroup
    selected_country <- input$Country
    
    long_data_selected <- depressionrates %>%
      filter(year == 2017, entity == selected_country) %>%
      pivot_longer(cols = starts_with(selected_age_groups), names_to = "age_group", values_to = "Depression_Rate") %>%
      mutate(group = "Selected Country")
    
    long_data_us <- depressionrates %>%
      filter(year == 2017, entity == "United States") %>%
      pivot_longer(cols = starts_with(selected_age_groups), names_to = "age_group", values_to = "Depression_Rate") %>%
      mutate(group = "United States")
    
    combined_data <- bind_rows(long_data_selected, long_data_us)
    
    ggplot(combined_data, aes(x = age_group, y = as.numeric(Depression_Rate), fill = group)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = paste("Comparing Depression Rates for", selected_country, "and United States"),
           x = "Age Group", y = "Depression Rate (%)") +
      scale_fill_discrete(name = "Legend", labels = c(selected_country, "United States")) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}
