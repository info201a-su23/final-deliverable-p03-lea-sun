library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)


server <- function(input, output) {
  
  non_country_options <- c("American Samoa", "Andean Latin America", "Australasia", "Central Asia", "Central Europe", 
                           "Central Europe, Eastern Europe, and Central Asia", "Central Latin America", "Central Sub-Saharan Africa", 
                           "East Asia", "Eastern Europe", "Eastern Sub-Saharan Africa", "High SDI", "High-income", 
                           "High-income Asia Pacific", "High-middle SDI", "Latin America and Caribbean", "Low SDI", 
                           "Low-middle SDI", "Middle SDI", "North Africa and Middle East", "North America", 
                           "Northern Mariana Islands", "Oceania", "South Asia", "Southeast Asia", "Southeast Asia, East Asia, and Oceania", 
                           "Southern Latin America", "Southern Sub-Saharan Africa", "Sub-Saharan Africa", 
                           "Tropical Latin America", "United States Virgin Islands", "Western Europe", "Western Sub-Saharan Africa", 
                           "World")
  valid_countries <- depressionrates %>%
    filter(!entity %in% non_country_options) %>%
    pull(entity)
  
  reactive_bar_data <- reactive({
    year_data <- depressionrates %>%
      filter(entity == "United States", year == input$year) %>%
      pivot_longer(cols = c("10_14_years_old", "15_19_years_old", "20_24_years_old", "25_29_years_old", "30_34_years_old", "50_69_years_old", "70_years_old"),
                   names_to = "Age_Group", values_to = "Depression_Rate")
    return(year_data)
  })
  
  output$bar_chart <- renderPlotly({
    year_data <- reactive_bar_data()
    
    gg <- ggplot(year_data, aes(x = Age_Group, y = as.numeric(Depression_Rate), fill = Age_Group)) +
      geom_bar(stat = "identity") +
      scale_fill_discrete(labels = c("10_14_years_old" = "10 to 14 years old", "15_19_years_old" = "15 to 19 years old", "20_24_years_old" = "20 to 24 years old", "25_29_years_old" = "25 to 29 years old", "30_34_years_old" = "30 to 34 years old", "50_69_years_old" = "50 to 69 years old", "70_years_old" = "70 years old" )) +
      scale_x_discrete(labels = c("10_14_years_old" = "10 to 14 years old", "15_19_years_old" = "15 to 19 years old", "20_24_years_old" = "20 to 24 years old", "25_29_years_old" = "25 to 29 years old", "30_34_years_old" = "30 to 34 years old", "50_69_years_old" = "50 to 69 years old", "70_years_old" = "70 years old" )) +
      labs(title = paste("Age Groups in the US in", input$year),
           x = "Age Group", y = "Depression Rate (%)", fill = "Age Group") +
   theme_minimal() +
   theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
   guides(fill = guide_legend(title = "Age Group"))
    
    ggplotly(gg)
})

reactive_compare_data <- reactive({
  selected_age_groups <- input$checkGroup
  selected_country <- input$Country
  
  if(is.null(selected_age_groups)) {
    selected_age_groups <- c("10_14_years_old", "15_19_years_old", "20_24_years_old", "25_29_years_old", "30_34_years_old", "50_69_years_old", "70_years_old")
  }
  
  long_data_selected <- depressionrates %>%
    filter(year == 2017, entity == selected_country) %>%
    select(year, entity, "10_14_years_old", "15_19_years_old", "20_24_years_old", "25_29_years_old", "30_34_years_old", "50_69_years_old", "70_years_old") %>%
    pivot_longer(cols = selected_age_groups, names_to = "age_group", values_to = "Depression_Rate") %>%
    mutate(group = "Selected Country")
  
  long_data_us <- depressionrates %>%
    filter(year == 2017, entity == "United States") %>%
    select(year, entity, "10_14_years_old", "15_19_years_old", "20_24_years_old", "25_29_years_old", "30_34_years_old", "50_69_years_old", "70_years_old") %>%
    pivot_longer(cols = selected_age_groups, names_to = "age_group", values_to = "Depression_Rate") %>%
    mutate(group = "United States")
  
  combined_data <- bind_rows(long_data_selected, long_data_us)
  return(combined_data)
  
})

output$comparison_chart <- renderPlotly({
  combined_data <- reactive_compare_data()
  

gg <- ggplot(combined_data, aes(x = age_group, y = as.numeric(Depression_Rate), fill = group)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = paste("Comparing Depression Rates for", input$Country, "and United States (2017)"),
       x = "Age Group", y = "Depression Rate (%)") +
  scale_fill_discrete(name = "Legend", labels = c(input$Country, "United States")) +
  scale_x_discrete(labels = c("10_14_years_old" = "10 to 14 years old", "15_19_years_old" = "15 to 19 years old", "20_24_years_old" = "20 to 24 years old", "25_29_years_old" = "25 to 29 years old", "30_34_years_old" = "30 to 34 years old", "50_69_years_old" = "50 to 69 years old", "70_years_old" = "70 years old" )) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplotly(gg)
})

output$country_select <- renderUI({
  selectInput("Country", label = h3("Select a Country: "),
              choices = unique(valid_countries),
              selected = "Afghanistan")
})

reactive_line_data <- reactive({
  selected_country <- input$entity
  
  if(is.null(selected_country)) {
    selected_country <- "United States"
  }
  
  country_data <- depressionrates %>%
    filter(entity == selected_country)
  
  country_depression_rates <- country_data %>%
    pivot_longer(cols = c("10_14_years_old", "15_19_years_old", "20_24_years_old", "25_29_years_old", "30_34_years_old", "50_69_years_old", "70_years_old"),
                 names_to = "AgeGroup", values_to = "DepressionRate")
  
  return(country_depression_rates)
})

output$country_line_chart <- renderPlotly({
  country_depression_rates <- reactive_line_data()
  
  gg <- ggplot(country_depression_rates, aes(x = year, y = DepressionRate, color = AgeGroup)) +
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
  
  ggplotly(gg)
})

output$country_line_select <- renderUI({
  selectInput("entity", label = h3("Select a Country: "),
              choices = unique(valid_countries),
              selected = "United States")
})

}
