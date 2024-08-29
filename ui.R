## define directory
setwd("C:\\Users\\Joao\\Documents\\Dev\\fogocruzado-dash/")

## read source
source("data_generator.R")


#### ShinyThemes Demo Code ####
library(shiny)
library(shinythemes)
# library(datasets)

shinyUI(fluidPage(
  theme=shinytheme("cosmo"),
  # themeSelector(), ## not required but can be used to select the theme
  
  navbarPage(
    title="Dashboard Fogo Cruzado",
    id="nav",
    tabPanel(
      title = "Data", 
      value="Data",
      sidebarLayout(
        sidebarPanel(
           selectInput(
             inputId = "state",
             label = "Select the State", 
             choices=states_list
             ),
           tags$hr(),
           sliderInput("n", "Select no. of data rows", min = 2, max = 10, value=6)
         ),
         mainPanel(
           tabsetPanel(
             tabPanel("Data", tableOutput("table")),
             tabPanel("Motivation", tableOutput("motivation_table"))
             # textOutput("value")
           )
         )
       )),
    tabPanel(
      title = "Plots", 
      value = "Plots",
      sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "state",
            label = "Select the State", 
            choices=states_list
          ),
          selectInput(
            inputId = "motivation",
            label = "Select the Motivation", 
            choices=motiv_list
          )
        ),
        mainPanel(
          tabsetPanel(
            tabPanel("Barplot", plotOutput("barplot")),
            tabPanel("Map", textOutput("texting"))
            # textOutput("value")
          )
        )
      )
      )
  )
))
