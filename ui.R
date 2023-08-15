ui <- navbarPage(
  "Global Depression Rates",
  tags$style("
    nav div{
      background-color: #BCE5FF;
    }
  "),
  
  tabPanel("Introduction",
           h1("Mental Health Across Borders: Analyzing Depression by Country and Age Group"),
           
           div(
             img(
               src = "https://californiahealthline.org/wp-content/uploads/sites/3/2016/09/sad-elderly_7701.jpg?w=770"),
             p(em("Source: California Healthline"), style = "font-size:10px")),
           
           p("By Simran Kaur, Leanna Sun, Susruthi Karanam, and Jullie Jasminez"),
           p("August 14, 2023"),
           
           h2("Introduction and Research Questions"),
           p("Our goal is to gain a better look at how depression rates vary 
           across the world by age group. This is important because mental health
           is a critical global issue, and understanding the variations in 
           depression rates can aid in case-by-case treatments and mental health 
           policies. To address this question, we will analyze a comprehensive 
           dataset that records depression rates by country and age group, aiming
           to uncover patterns and trends that contribute to a better understanding
           of the mental health landscape worldwide."),
           p("Our research questions, based on our dataset, include:"),
           p("• How do depression rates vary across different age groups in different countries?"),
           p("• Are there significant differences in depression prevalence between developed and 
             developing countries within specific age brackets?"),
           p("• What is the overall trend of depression rates across different age groups 
             globally? Are certain age groups more vulnerable to depression?"),
           p("• How do depression rates within the U.S. compare to that of other countries
             looking at the same age groups?"),
           p("• How do depression rates vary among age groups within the U.S.?"),
           p("Understanding the variations in mental health disorders across age
             groups holds significant implications for technologists, designers,
             and policymakers. Technologists can develop age-appropriate digital 
             platforms and tools to support mental health, utilizing data analytics
             and Al for early detection and personalized interventions. Designers
             can create empathetic and user-centric interfaces, considering cultural
             sensitivities and regional differences to enhance accessibility and
             reduce stigma. Policymakers can use the insights to design 
             evidence-based mental health policies that allocate resources 
             effectively, catering to the specific needs of adolescents, adults,
             and the elderly. Strengthening mental health services in schools,
             workplaces, and geriatric care centers, and integrating mental health
             support into primary healthcare, can lead to improved mental health 
             services, reduced stigma, and enhanced well-being across diverse populations."),
        
           h2("The Dataset"),
           p("Our dataset is from ",
             a("Mental Health Depression Disorder Data.",
               href = "https://data.world/vizzup/mental-health-depression-disorder-data/workspace/file?filename=Mental+health+Depression+disorder+Data.xlsx")),
           p("The data was collected by Saloni Dattani, Lucas Rodés-Guirao, 
             Hannah Ritchie, and Max Roser from ",
             a("Our World in Data,", 
             href = "https://ourworldindata.org/"), 
            "a website dedicated to research on global issues."),
           p("This data was collected to reduce the burden of mental illness 
             worldwide by providing reliable data to get more attention and 
             support to the issue and those suffering with the illnesses. It was
             collected and generated using statistical methods on top of surveys
             and screening data from mental health patients worldwide."),
           p("When engaging with this data, it's crucial to recognize its potential
             impact in assisting individuals with mental health challenges. 
             Ethical considerations regarding data collection methods should also
             be examined, ensuring the respect and well-being of participants."),
           p("The data does come with potential issues. One notable challenge is
             the reluctance of individuals to openly address their mental health
             concerns, particularly in regions where mental health awareness is 
             limited. This can lead to skewed data representation, especially in
             areas where acknowledging such issues is culturally restricted. 
             Another issue is the subjective nature of surveys and 
             data collection, as interpretations of mental health issues can vary
             widely among individuals and across cultures. Additionally, there is
             data missing for age groups between 35 and 49. The exclusion of this
             group results in lack of proper representation and insight on 
             depression rates of these age groups."),
           p("Our objective is to comprehensively examine global depression rates
           by age group, serving a crucial role in addressing the global mental
           health crisis. Through meticulous analysis of a comprehensive dataset,
           we aim to reveal underlying patterns and trends. This endeavor holds
           the potential to significantly inform tailored interventions, treatment
           strategies, and mental health policies that can positively impact diverse populations."),
           div(
             style = "display: flex; flex-direction: column; align-items: 
             center; justify-content: center;",
             img(
               src = "https://progress.im/sites/default/files/styles/content_full/public/istock-1304715718_0.jpg?itok=hcHZzfqJ",
               width = "600px",
               height = "270px"
             ),
             p(em("Source: Progress in Mind"), style = "font-size:10px")),
           
           
           h2("Limitations and Challenges"),
           p("Throughout this project there will be many contributions and 
             challenges that will increase the difficulty of having a correct
             analysis. Ensuring the data quality is accurate may be a challenge 
             and there may be limitations in certain age groups which can lead 
             to inaccurate data representation. Along with the difficulty of 
             collecting information on mental health issues with different 
             countries and regions. Due to the difference and stigma towards 
             mental health, the dataset may not account for the different variations
             of mental health issues therefore leading to inaccurate conclusions."),
           p("Another limitation and challenge throughout this project may be the 
           confounding variables. Identifying a correlating between age and mental
           health is not simple and there are many confounding variables within this 
           study including economic status, cultural differences, along with more
           lifestyle factors. Due to these confounding variables, there are many 
           limitations to accurately analyzing the dataset. Generalization must
           be avoided to ensure that the results are not too simplified towards
           a certain demographic and population.")
  ),
  
  tabPanel("Age Groups by Country",
           fluidPage(
             titlePanel("Depression Rates of Different Age Groups in Different Countries"),
             sidebarLayout(
               sidebarPanel(
                 selectInput("entity", label = "Select a Country:", choices = unique(depressionrates$entity), selected = "United States")),
               mainPanel(
                 plotOutput("country_line_chart")
               )
             )
             
             
             
           ),
           p("This chart attempts to understand depression rate trends across different age groups throughout different years.
             By going through the select box drop down feature, you are able to pick and choose which country's data you want 
             to see."),
           p("With this chart, it's easy to see how different age groups might have a higher or lower rate of depression based 
             on the country they live in. These differences could stem from economy, culture, weather, and more.")
  ),
  
  tabPanel("Comparing U.S. and Other Countries",
  fluidPage(
    checkboxGroupInput("checkGroup", label = h3("Checkbox group"), 
                       c("10 to 14 years old" = "10_14_years_old", "15 to 19 years old" = "15_19_years_old","20 to 24 years old" = "20_24_years_old", "25 to 29 years old" = "25_29_years_old",
                                      "30 to 34 years old" = "30_34_years_old", "50 to 69 years old" = "50_69_years_old", "70 years old" = "70_years_old"), 
                       selected = "10_14_years_old"),
    
    
    hr(),
    fluidRow(column(7, verbatimTextOutput("value")))
    
  ),
    
  selectInput("Country", label = h3("Select a Country: "), 
                choices = depressionrates$entity,
                  selected = "Afghanistan"),
                  plotOutput("comparison_chart"),
  p("This chart attempts to understand how depression rates in different countries directly compare to the United States. 
    By selecting a country to compare with and checking which age groups you want displayed, you will get a side-by-side 
    bar graph to see the differences."),
  p("With this chart, it's easy to see how depression is differently experienced based on age in countries other than our own. 
    By seeing these differences, you can get a better understanding of the prevalence of depression in a different country.")
  ),

  tabPanel("Age Groups in the U.S. by Year",
           fluidPage(
             titlePanel("Age Groups in the US"),
             sidebarLayout(
               sidebarPanel(
                 selectInput("year", label = "Select a Year:", choices = unique(depressionrates$year), selected = 1990)),
               mainPanel(
                 plotOutput("bar_chart")
               )
             )
           ),
           p("This chart attempts to understand how depression rates changed between age groups across the years. By allowing 
             you to select a specific year, you can easily and clearly see the depression rates for the age groups in the 
             United States."),
           p("With this chart, you can easily see how the age groups' depression rates compare with each other side-by-side, 
             and see how the differences in depression rates across all of age groups either increase or decrease throughout 
             time.")
   ),

  tabPanel("Conclusion",
           h2("Main Takeaways"),
           p("Each visualization we have led to its own key takeaways regarding 
           depression rates by age group and/or location."),
           p(""),
           em(strong("Depression Rates of Age Groups by Country")),
           div(
             style = "display: flex; justify-content: space-between;",
             img(
               src = "https://github.com/info201a-su23/final-deliverable-p03-lea-sun/blob/main/images/chart1_uk.png?raw=true",
               style = "width: 45%;"
             ),
             img(
               src = "https://github.com/info201a-su23/final-deliverable-p03-lea-sun/blob/main/images/chart1_malaysia.png?raw=true",  
               style = "width: 45%;"
             )
           ),
           p(em("Visualization for the UK versus Malaysia"), style = "font-size:10px"),
           p("For this visualization, we look at individual countries and how
             depression rates vary for each age group over the years. A pattern we
             noticed is that for a lot of the countries, 70 year olds have the
             highest or higher rates of depression. This could be explained by
             various factors, such as smaller populations of older age groups,
             or older individuals feeling more lonely or isolated due to age.
             This pattern is especially seen among smaller, less developed countries,
             as opposed to developed and larger countries with more sophisticated
             economics and advanced infrastructure and technology. For these larger,
             more developed countries, a pattern observed is that the higher 
             age groups mainly consist of younger age groups, such as 20-24 year
             olds, occasionally with the older age groups as well. For example, in
             the images above, the United Kingdom, a big developed country, has 
             seen the most rates among 25 to 29 year olds. Malaysia, on the other 
             hand, has seen the greatest rates among 70 year olds. The difference
             between these patterns could be explain by aging populations, differing
             societal and cultural norms, technological growth (or lack thereof), 
             economic disparities, etc."),
           em(strong("Comparing the U.S. to Other Countries")),
           p(""),
           em(strong("U.S. Depression Rates Among Age Group By Year")),
           div(
             style = "display: flex; justify-content: space-between;",
             img(
               src = "https://github.com/info201a-su23/final-deliverable-p03-lea-sun/blob/main/images/chart3_1990.png?raw=true",
               style = "width: 45%;"
             ),
             img(
               src = "https://github.com/info201a-su23/final-deliverable-p03-lea-sun/blob/main/images/chart3_2017.png?raw=true",  
               style = "width: 45%;"
             )
           ),
           p(em("Comaprsion of Depression Rates between Age Groups in U.S versus other countries in 2017"), style = "font-size:10px"),
           p("The purpose of the chart is to be able to display the data in the
             simplest form to be able to compare selected age groups in
             different countries. By having this direct comparison, we are
             able to see what age groups have higher percentages than
             user-selected countries. The main takeaway of this
             bar chart is to be able to notice what countries have 
             higher depression rates and what possible factors contribute. 
             In order to understand if underdeveloped countries
             live less stress, the comparison of the U.S. and Nepal. The
             depression rate for every age category was almost double U.S. 
             Except for the age category 70 years old. This may help determine 
             the quality of life for underdeveloped countries. More 
             specifically,the vulnerability to stress in the older age group of
             70 years. To further explore the subject of higher stress for
             older ages in underdeveloped countries, the comparison of the U.S.
             and Pakistan. Similar to Nepal, the U.S. had double stress 
             percentages for every age category except for the age category 70
             years. The age category 70 years is reaching 7% meanwhile the U.S
             is below 4% depression rate. These specific insights consistently
             prove that underdeveloped countries have higher stress percentages
             for the age category of 70 years. However, it can be concluded 
             that the U.S. has a higher stressful and challenging lifestyle
             for every other age category compared to underdeveloped countries.
             With the help of these findings, we can determine retirement is
             easier in the U.S. However, more resources are needed to reduce
             stress throughout education and work life." ),
           p(em("Age groups in the U.S. in 1990 versus 2017"), style = "font-size:10px"),
           p("By looking at how depression rates have changed throughout the
             years in the U.S., we can see how specific factors that we are
             surrounded by in our daily lives can contribute to mental health.
             As seen in the two images above of 1990 and 2017 in the U.S.,
             while 70 year olds consistenly have lower depression rates, over 
             the years, the rates slowly drop down to below 4%, as opposed to 
             being over 4% in the 1990s. This could be explained by improved
             healthcare, stronger social support, generational differences, etc. 
             Inversely, rates for 10-14 year olds, also have lower rates,
             have increased over the years, jumping from below 2% in the 90s to
             over 2.5% recently. Additionally, from 1990 to 1999, the graph shows
             how the three age groups with the highest depression rates are 20 to 
             24, 25 to 29, and 30 to 34 year olds. After 1999, the depression 
             rates for 15 to 19 year olds starts to increase, eventually 
             becoming the age group with the second highest rate. The increase
             for younger age groups could be explained by cultural shifts or the
             rise of technology and social media. Yet countries such as Canada and
             the U.S have simmilar depression rates across the age categories
             due to the simmilarities in lifestyle. Both the U.S and Canada are
             developed countries that value education and work. Due to these high-
             stressful activities, there are higher percentage of stress. Along with
             the factors of technology, social media, and generational differences
             contributing to this data."),
           
           h2("Important Insight"),
           p("Since the dataset does not explicitly measure other factors along
             with depression rates, it forces us to take a deeper look at potential
             explanations and factors that contribute to changing and varying
             depression rates among age groups and locations. Possible 
             contributing explanations can include the impact of aging populations,
             shifting cultural and societal norms, the role of technological
             growth and the internet, economic and income disparities, access to
             mental health resources, average education levels, environmental 
             factors, and more. By looking at data on specific countries and age
             groups, we can simultaneously take into account other information 
             about the location and age group to help gain more context on 
             the depression rates. If we look at the data as a whole, conclusions
             and implications may be too general or unmeaningful. The specific charts
             comparing the U.S depression levels amongst different age categories 
             reveals factors that contribute to different lifestyles. Along with
             another chart comapring the factors of U.S and user-selcted countires. 
             By specifically choosing underdeveloped countries such as Pakistan
             and Nepal, data can help conclude age groups of 70 have higher stress
             than U.S. However, U.S has higher stress fpr every other age category. 
             This dataset revealed the societal norms and cultural difference and
             their affects of stress levels on lifestyles."),
           h2("Implications"),
           p("The broader and main implications are to gain a deeper understanding
             of depression rates and mental health issues according to different
             contexts. Specialized and specific policies for different age groups,
             within different countries, and even for different contributing factors
             are needed to properly address mental health issues and help those who
             are struggling. As seen in our visualizations, not only is there variation
             among countries of different qualities and factors, there is also
             significant change and variation among age groups in the U.S. due to age
             and other variables. This means the policies, measures, and treatments 
             require holistic approaches.")
  )
)
  

