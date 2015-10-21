library(UsingR)


df_mean <- function(lambda_i, n_i, simu_i)
{
    set.seed(1234)
    lambda <- lambda_i
    n <- n_i
    simu_1 <- simu_i
    means_1 = NULL
    
    # Fill intermediaries results for each distribution
    for (i in 1 : simu_1) { means_1 = c(means_1, mean(rexp(n,lambda)));}
    # Create final data frame
    df <- data.frame(simulation = factor(c(rep(simu_1, simu_1))), 
                     means = c(means_1))
    df    
}
                    
shinyServer(
    function(input, output) {   
        output$TheoricalMean <- renderPrint({1/input$lambda})                
        
        output$D1Mean <- renderPrint({
            lambda <- input$lambda
            sample_size <- input$sample_size
            distribution_1_size <- input$distribution_1_size
            df <- df_mean(lambda, sample_size, distribution_1_size)
            mean(df$means, na.rm=T)
        })
        
        output$D2Mean <- renderPrint({
            lambda <- input$lambda
            sample_size <- input$sample_size
            distribution_2_size <- input$distribution_2_size
            df <- df_mean(lambda, sample_size, distribution_2_size)
            mean(df$means, na.rm=T)
        })
        
        output$Distribution_1 <- renderPlot({    
            lambda <- input$lambda
            sample_size <- input$sample_size
            distribution_1_size <- input$distribution_1_size
            df <- df_mean(lambda, sample_size, distribution_1_size)
                
            p <-ggplot(df, aes(x=means)) + 
                    geom_histogram(aes(y=..density..),      # Histogram with density instead of count on y-axis
                                   binwidth=0.2, 
                                   colour="black", fill="white") +
                    geom_density(alpha=.2, fill="#FF6666") +  # Overlay with transparent density plot +                    
                    labs(title = paste("Distribution 1:",sample_size,"exponentials sample mean distribution,", "Lambda=", lambda)) + 
                    ylab("Density") + 
                    xlab("Sample mean")+
                    geom_vline(xintercept=1/lambda,   # Theorical mean
                           color="red", linetype="dashed", size=1, show_guide = T) +
                    geom_vline(xintercept=mean(df$means, na.rm=T),
                           color="blue", linetype="dashed", size=1.2, show_guide = T) +
                    geom_text(x=1/lambda-0.5, label = "Theorical mean", y=0.04, angle=0, color="red") +
                    geom_text(x=1/lambda-0.5, label = "Simulated mean", y=0.015, angle=0, color="blue")
                    
            print(p)
        })    
        
        output$Distribution_2 <- renderPlot({    
            lambda <- input$lambda
            sample_size <- input$sample_size
            distribution_2_size <- input$distribution_2_size
            df <- df_mean(lambda, sample_size, distribution_2_size)
            p <-ggplot(df, aes(x=means)) + 
                geom_histogram(aes(y=..density..),      # Histogram with density instead of count on y-axis
                               binwidth=0.2, 
                               colour="black", fill="white") +
                geom_density(alpha=.2, fill="#FF6666") +  # Overlay with transparent density plot +                    
                labs(title = paste("Distribution 2:",sample_size,"exponentials sample mean distribution,", "Lambda=", lambda)) + 
                ylab("Density") + 
                xlab("Sample mean")+
                geom_vline(xintercept=1/lambda,   # Theorical mean
                           color="red", linetype="dashed", size=1) +
                geom_vline(xintercept=mean(df$means, na.rm=T),
                           color="blue", linetype="dashed", size=1.2) +
                geom_text(x=1/lambda-0.5, label = "Theorical mean", y=0.04, angle=0, color="red") +
                geom_text(x=1/lambda-0.5, label = "Simulated mean", y=0.015, angle=0, color="blue")
                                    
            print(p)
        }) 
    }
)