#The purpose of this app is to create an interactive histogram that shows the relationship between the 7 point and 5 point ideologies in Congress

library(shiny)

#Import Data, select relevant values
dat<-read.csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))
dat<- dat %>% 
  dplyr::select(c("pid7","ideo5")) %>%
  na.omit() %>%
  mutate(pid7=as.factor(pid7),ideo5=as.factor(ideo5))


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("7 point Ideology Based on Five Point Ideology In Congress"),
    sidebarLayout(
      #Default value is 3, minimum is 1 maximum is 5
        sidebarPanel(sliderInput("ideology_setting", "Select Five Point Ideology (1=Very liberal, 5=Very conservative)", value = 3, min = 1, max = 5)),
        # Show histogram of generated plot based on the slider value
        mainPanel( plotOutput("count_histogram"))
                  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$count_histogram <- renderPlot({
      
        # Filter dat in order to only include the five point ideology from the slider
      plotting_df<-dplyr::filter(dat,ideo5 %in% input$ideology_setting)
       
      #Create a plot with the value from the slider
        ggplot(plotting_df, aes(x=pid7)) + 
          geom_histogram(stat='count') +
          xlab('7 Point Party ID,1=Very Democratic, 7=Very Republican')+
          ylab('Count')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
