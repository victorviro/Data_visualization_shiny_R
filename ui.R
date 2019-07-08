#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
ui1 <- 
  fluidPage(theme = shinytheme("superhero"),
            
            # App title ----
            titlePanel("Scatterplot"),
            
            # Sidebar layout with input and output definitions ----
            sidebarLayout(
              
              # Sidebar panel for inputs ----
              sidebarPanel(
                
                # Input: Selector for variables of  dataset ----
                selectInput(
                  inputId = "variable",
                  label = "Choose a continuous variable:",
                  choices = c("Age", "EducationNum",'HourPerWeek', 'Benefits')),
                
                selectInput(inputId = "variable1",
                            label = "Choose a continuous variable:",
                            choices = c("HourPerWeek", "Age", 'EducationNum', 'Benefits')),
                selectInput(inputId = "variable2",
                            label = "Choose a cualitative variable:",
                            choices = c('Workclass','MaritalStatus','Occupation', 'Relation', 'Race', 'Gender', 'Income'))
              ),
              mainPanel(
                plotOutput('plot')
              )
            )
  )





####2
ui2 <- 
  fluidPage(theme = shinytheme("superhero"),
            
            # App title ----
            titlePanel("Barplot"),
            
            # Sidebar layout with input and output definitions ----
            sidebarLayout(
              
              # Sidebar panel for inputs ----
              sidebarPanel(
                
                # Input: Selector for variables of  dataset ----
                
                
                selectInput(inputId = "variable3",
                            label = "Choose a cualitative variable:",
                            choices = c('Workclass','MaritalStatus','Occupation', 'Relation', 'Race', 'Gender', 'Income')),
                selectInput(inputId = "variable4",
                            label = "Choose a cualitative variable:",
                            choices = c('MaritalStatus','Workclass','Occupation', 'Relation', 'Race', 'Gender', 'Income'))
              ),
              mainPanel(
                plotOutput('plot2')
              )
            )
  )



# Define UI for application that draws a histogram
ui <- navbarPage('Visualization Dataset',
                 tabPanel('Scatter plot', ui1
                 ),
                 tabPanel('Barchart', ui2)
)