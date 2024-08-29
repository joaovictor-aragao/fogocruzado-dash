# links to api
# https://api.fogocruzado.org.br/docs/endpoint/occurrences#exemplos-de-uso
# https://api.fogocruzado.org.br/

# Import libraries
library(shiny)
library(bslib)
library(dplyr)
library(ggplot2)

# Read env variables
readRenviron("./.Renviron")

# script with useful functions
source("funtions.R")

# variables
BASE_URL <- "https://api-service.fogocruzado.org.br/api/v2"

# Get token value
TOKEN <- getToken(
  base_url = BASE_URL, 
  user = Sys.getenv("EMAIL"), 
  password = Sys.getenv("PASSWORD")
)

# Get states list
states_list <- getStates(base_url = BASE_URL, token = TOKEN)

# Get occurances
occs <- getOccurances(base_url = BASE_URL, token = TOKEN, id_state = states_list[[1]][1])

## list of motivations to filter
motiv_list <- c("All", dimnames(table(occs[, 5]))[[1]])