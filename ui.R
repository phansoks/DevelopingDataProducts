library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Comparing 2 exponential distributions in function of some parameters"),
    
    sidebarPanel(            
        numericInput('lambda', 'Lambda', 0.2, min = 0.1, max = 1, step = 0.1),
        numericInput('sample_size', 'Sample size', 40, min = 1, max = 100, step = 1),
        sliderInput('distribution_1_size', 'Distribution 1 size',value = 100, min = 1, max = 3000, step = 10,),
        sliderInput('distribution_2_size', 'Distribution 2 size',value = 1000, min = 1, max = 3000, step = 10,)
    ),
    mainPanel(    
        
        h4("Documentation"),
        p(" This apps simulates one of the course project done in the Statistical Inference class about the 
            exponential distribution and the central limit theorem. The goal is to shows the evolution of a distribution
            depending of several parameters. Here, we give the possibility to change the lambda, sample size and distribution size."),                
        p(" Two density plots are displayed, they both share the same lambda and sample size. Only the distribution size is specific
            to one plot. The goal is to show that with an increasing distribution size, the sample mean will get closer to the
            theorical mean."),
        p(" And the exact value of sample mean for distribution is shown directly on the plots with blue and red lines but also
            at the very bottom of the apps."),
        p(" Feel free to play with the parameters, plots and sample means will be refreshed automatically."),
        
        plotOutput('Distribution_1'),
        plotOutput('Distribution_2'),
        h4('Theorical mean'),
        verbatimTextOutput("TheoricalMean"),
        h4('Distribution 1 Simulated mean'), 
        verbatimTextOutput("D1Mean"),
        h4('Distribution 2 Simulated mean'),
        verbatimTextOutput("D2Mean")
    )
))