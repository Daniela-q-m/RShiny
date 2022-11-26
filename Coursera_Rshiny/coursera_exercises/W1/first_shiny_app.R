


library(shiny)

#Define UI, assign to fluidpage
#Each element in UI will be an argument
ui<-fluidPage(
  titlePanel("My First Shiny App"),
  
  textInput(inputId='my_text',label='Enter some text'),#To allow users to specify text
  
  textOutput(outputId='print_text') #Prints text from print_text function below
)

serve<-function(input, output){
  
  output$print_text<-renderText(input$my_text) 
  
}
  
shinyApp(ui=ui,server=server)
