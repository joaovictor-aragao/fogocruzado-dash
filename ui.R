
#### Reference ####
# Valid themes are: cerulean, cosmo, cyborg, darkly, 
# flatly, journal, lumen, paper, 
# readable, sandstone, simplex, slate, spacelab, 
# superhero, united, yeti.
# themeSelector()
# https://cran.r-project.org/web/packages/shinythemes/shinythemes.pdf


#### About shinythemes package ####
# Themes for use with Shiny. Includes several Bootstrap themes
# from <http://bootswatch.com/>, which are packaged for use with Shiny
# applications.

#### Install the shinythemes packages ####
# install.packages("shinythemes")


#### ShinyThemes Demo Code ####
library(shiny)
library(shinythemes)
library(datasets)

shinyUI(fluidPage(
  theme=shinytheme("cosmo"),
  # themeSelector(), ## not required but can be used to select the theme
  
  navbarPage(
    title="Dashboard ",
    id="nav",
    tabPanel("Data", value="Data",
             sidebarLayout(
               sidebarPanel(
                 selectInput(
                   inputId = "state",
                   label = "Select the State", 
                   choices=choiceList
                   ),
                 tags$hr(),
                 sliderInput("n", "Select no. of data rows", min = 2, max = 10, value=6)
               ),
               mainPanel(
                 textOutput("value"),
                 tableOutput("table")
               #   tabsetPanel(
               #     tabPanel("Dataset", tableOutput("table")),
               #     tabPanel("Summary Stats", verbatimTextOutput("summary"))
               #   )
               )
             )),
    tabPanel("Plots", value="Plots")
  )
  
))
