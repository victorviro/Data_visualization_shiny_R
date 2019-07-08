#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
#We get dataset

library(data.table)
dataset=fread('http://mlr.cs.umass.edu/ml/machine-learning-databases/adult/adult.data')
names (dataset) = c("Age", "Workclass", "Fnlwgt", "EducationLevel", "EducationNum", "MaritalStatus", "Occupation", 'Relation', 'Race', 'Gender','CapitalGain','CapitalLoss','HourPerWeek', 'NativeCountry','Income')


#Depuration
dataset[dataset=='?']= NA
colSums(is.na(dataset))
addmargins(table(dataset$Workclass))
dataset$Workclass[is.na(dataset$Workclass)]='Private'

addmargins(table(dataset$Occupation))
dataset$Occupation[is.na(dataset$Occupation)]='Prof-specialty'

dataset=na.omit(dataset)


dataset$Benefits=dataset$CapitalGain-dataset$CapitalLoss



dataset$Workclass <- gsub('^Federal-gov', 'Government', dataset$Workclass)
dataset$Workclass <- gsub('^Local-gov', 'Government', dataset$Workclass)
dataset$Workclass <- gsub('^State-gov', 'Government', dataset$Workclass) 

dataset$Workclass <- gsub('^Self-emp-inc', 'Self-Employed', dataset$Workclass)
dataset$Workclass <- gsub('^Self-emp-not-inc', 'Self-Employed', dataset$Workclass)

dataset$Workclass <- gsub('^Never-worked', 'Other', dataset$Workclass)
dataset$Workclass <- gsub('^Without-pay', 'Other', dataset$Workclass)
dataset$Workclass <- gsub('^Other', 'Other/Unknown', dataset$Workclass)
dataset$Workclass <- gsub('^Unknown', 'Other/Unknown', dataset$Workclass)



dataset$MaritalStatus <- gsub('Married-AF-spouse', 'Married', dataset$MaritalStatus)
dataset$MaritalStatus <- gsub('Married-civ-spouse', 'Married', dataset$MaritalStatus)
dataset$MaritalStatus <- gsub('Married-spouse-absent', 'Married', dataset$MaritalStatus)
dataset$MaritalStatus <- gsub('Never-married', 'Single', dataset$MaritalStatus)


attach(dataset)


library(shiny)
library(shinythemes)
library(ggplot2)


server <- function(input, output) {
  variableInput <- reactive({
    switch(input$variable,
           "Age" = Age,
           "EducationNum" = EducationNum,
           'HourPerWeek'=HourPerWeek,
           'Benefits'=Benefits
    )
  })
  variable1Input <- reactive({
    switch(input$variable1,
           "HourPerWeek" = HourPerWeek,
           "Age" = Age,
           'EducationNum'=EducationNum,
           'Benefits'= Benefits
    )
  })
  variable2Input <- reactive({
    switch(input$variable2,
           "Workclass" = Workclass,
           "MaritalStatus" = MaritalStatus,
           "Occupation" = Occupation, 
           "Relation" = Relation,
           "Race" = Race,
           "Gender" = Gender,
           "Income" = Income
    )
  })
  output$plot <- renderPlot({
    ggplot(dataset, aes( x= variableInput() , y=variable1Input(), color=variable2Input()))+geom_point()+
      labs(title="Scatter plot", y=input$variable1, x=input$variable, color=input$variable2)
    
  })
  
  #####2
  variable3Input <- reactive({
    switch(input$variable3,
           "Workclass" = Workclass,
           "MaritalStatus" = MaritalStatus,
           "Occupation" = Occupation, 
           "Relation" = Relation,
           "Race" = Race,
           "Gender" = Gender,
           "Income" = Income
    )
  })
  variable4Input <- reactive({
    switch(input$variable4,
           "MaritalStatus" = MaritalStatus,
           "Workclass" = Workclass,
           "Occupation" = Occupation, 
           "Relation" = Relation,
           "Race" = Race,
           "Gender" = Gender,
           "Income" = Income
    )
  })
  output$plot2 <- renderPlot({
    ggplot(dataset, aes(variable3Input())) +
      geom_bar(aes(fill = variable4Input()))+ 
      labs(title="Barchart", x=input$variable3, fill=input$variable4)
  })
}

