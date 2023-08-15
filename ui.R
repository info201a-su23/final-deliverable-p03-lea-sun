ui <- navbarPage(
  "Global Depression Rates",
  tabPanel("Introduction",
           h1("Mental Health Across Borders: Analyzing Depression by Country and Age Group"),
           
           div(
             img(
               src = "https://californiahealthline.org/wp-content/uploads/sites/3/2016/09/sad-elderly_7701.jpg?w=770"),
             p("Source: California Healthline")),
           
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
             areas where acknowledging such issues is culturally restrained. 
             Another constraint lies in the subjective nature of surveys and 
             screening data, as interpretations of mental health issues can vary
             widely among individuals and across cultures. Discrepancies arise when
             differing classifications affect reporting, potentially hindering 
             the accuracy and consistency of the data. Additionally, variations 
             in diagnostic expertise among healthcare professionals may 
             inadvertently lead to misdiagnoses."),
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
             p("Source: Progress in Mind")),
           
           
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
  
  tabPanel("Age Groups by Country"),
  tabPanel("Comparing U.S. and Other Countries",
  fluidPage(
    checkboxGroupInput("checkGroup", label = h3("Checkbox group"), 
                       choices = list("10 to 14 yr olds" = 1, "15 to 19 yr olds" = 2,"20 to 24 yr olds" = 3, "25 to 29 yr old" = 4,
                                      "30 to 34 yr olds" = 5, "50 to 69 yr olds" = 6, "70 yr old" = 7), 
                       selected = 1),
    
    
    hr(),
    fluidRow(column(7, verbatimTextOutput("value")))
    
  ),
    
  selectInput("Country", label = h3("Select a Country: "), 
                choices = unique(depressionrates$entity),
                  selected = "Afghanistan"),
                  plotOutput("comparison_chart")
  ),

  tabPanel("Age Groups in the U.S.",
           fluidPage(
             titlePanel("Age Groups in the US"),
             sidebarLayout(
               sidebarPanel(
                 selectInput("year", label = "Select a Year:", choices = unique(depressionrates$year), selected = 1990)
               ),
               mainPanel(
                 plotOutput("bar_chart")
               )
             )
             
             
             
           )
   ),

  tabPanel("Conclusion")
)
  

