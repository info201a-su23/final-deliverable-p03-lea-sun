library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)


server <- function(input, output) {
  
  reactive_bar_data <- reactive({
    year_data <- depressionrates %>%
      filter(entity == "United States", year == input$year) %>%
      pivot_longer(cols = c("10_14_years_old", "15_19_years_old", "20_24_years_old", "25_29_years_old", "30_34_years_old", "50_69_years_old", "70_years_old"),
                   names_to = "Age_Group", values_to = "Depression_Rate")
    return(year_data)
  })
  
  output$bar_chart <- renderPlot({
    year_data <- reactive_bar_data()
    
    ggplot(year_data, aes(x = Age_Group, y = as.numeric(Depression_Rate), fill = Age_Group)) +
      geom_bar(stat = "identity") +
      scale_fill_discrete(labels = c("10_14_years_old" = "10 to 14 years old", "15_19_years_old" = "15 to 19 years old", "20_24_years_old" = "20 to 24 years old", "25_29_years_old" = "25 to 29 years old", "30_34_years_old" = "30 to 34 years old", "50_69_years_old" = "50 to 69 years old", "70_years_old" = "70 years old" )) +
      scale_x_discrete(labels = c("10_14_years_old" = "10 to 14 years old", "15_19_years_old" = "15 to 19 years old", "20_24_years_old" = "20 to 24 years old", "25_29_years_old" = "25 to 29 years old", "30_34_years_old" = "30 to 34 years old", "50_69_years_old" = "50 to 69 years old", "70_years_old" = "70 years old" )) +
      labs(title = paste("Age Groups in the US in", input$year),
           x = "Age Group", y = "Depression Rate (%)", fill = "Age Group") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  reactive_compare_data <- reactive({
    selected_age_groups <- input$checkGroup
    selected_country <- input$Country
    
    long_data_selected <- depressionrates %>%
      filter(year == 2017, entity == selected_country) %>%
      select(year, entity, "10_14_years_old", "15_19_years_old", "20_24_years_old", "25_29_years_old", "30_34_years_old", "50_69_years_old", "70_years_old") %>%
      pivot_longer(cols = c("10_14_years_old", "15_19_years_old", "20_24_years_old", "25_29_years_old", "30_34_years_old", "50_69_years_old", "70_years_old"), names_to = "age_group", values_to = "Depression_Rate") %>%
      mutate(group = "Selected Country")
    
    long_data_us <- depressionrates %>%
      filter(year == 2017, entity == "United States") %>%
      select(year, entity, "10_14_years_old", "15_19_years_old", "20_24_years_old", "25_29_years_old", "30_34_years_old", "50_69_years_old", "70_years_old") %>%
      pivot_longer(cols = c("10_14_years_old", "15_19_years_old", "20_24_years_old", "25_29_years_old", "30_34_years_old", "50_69_years_old", "70_years_old"), names_to = "age_group", values_to = "Depression_Rate") %>%
      mutate(group = "United States")
    
    combined_data <- bind_rows(long_data_selected, long_data_us)
    return(combined_data)
    
  })
  
  output$comparison_chart <- renderPlot({
    combined_data <- reactive_compare_data()
    
    ggplot(combined_data, aes(x = age_group, y = as.numeric(Depression_Rate), fill = group)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = paste("Comparing Depression Rates for", input$Country, "and United States (2017)"),
           x = "Age Group", y = "Depression Rate (%)") +
      scale_fill_discrete(name = "Legend", labels = c(input$Country, "United States")) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  reactive_line_data <- reactive({
    selected_country <- input$entity
    country_data <- depressionrates %>%
      filter(entity == selected_country)
    
    country_depression_rates <- country_data %>%
      pivot_longer(cols = c("10_14_years_old", "15_19_years_old", "20_24_years_old", "25_29_years_old", "30_34_years_old", "50_69_years_old", "70_years_old"),
                   names_to = "AgeGroup", values_to = "DepressionRate")
    
    return(country_depression_rates)
  })
  
  output$country_line_chart <- renderPlot({
    country_depression_rates <- reactive_line_data()
    
    ggplot(country_depression_rates, aes(x = year, y = DepressionRate, color = AgeGroup)) +
      geom_line() +
      labs(title = paste("Depression Rates in", input$entity, "by Age Group Throughout the Years"),
           x = "Year",
           y = "Depression Rate Percentage (%)",
           color = "Age Group") +
      scale_color_discrete(labels = c("10_14_years_old" = "10-14 years old",
                                      "15_19_years_old" = "15-19 years old",
                                      "20_24_years_old" = "20-24 years old",
                                      "25_29_years_old" = "25-29 years old",
                                      "30_34_years_old" = "30-34 years old",
                                      "50_69_years_old" = "50-69 years old",
                                      "70_years_old" = "70 years old")) +
      theme_minimal()
  })
}
