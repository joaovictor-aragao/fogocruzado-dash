### using POST method to get token
getToken <- function(base_url, user, password) {
  
  auth <- httr::POST(
    url = paste0(BASE_URL, "/auth/login"),
    body = list(
      email = user, 
      password = password
    ), encode = "json"
  )
  
  if (auth$status_code == 201) {
    
    return(httr::content(auth)$data$accessToken)
  } else {
    stop("It doesn't work!")
  }
}

### list of states and Ids
getStates <- function(base_url, token) {
  list_states <- httr::GET(
    url = paste0(base_url, "/states"),
    httr::add_headers(Authorization = paste0("Bearer ", token))
  )
  
  if (list_states$status_code == 200) {
    states_list <- httr::content(list_states)
    
    statedf <- data.frame()
    
    for (i in 1:length(states_list)) {
      statedf <- rbind(statedf, c(states_list$data[[i]]$id, states_list$data[[i]]$name))
    }
    
    names(statedf) <- c("Id", "State")
    
    lstate <- statedf[, 1]
    names(lstate) <- statedf[, 2]
    
    return(lstate)
    
  }
}

## get and filter the data returned
getOccurances <- function(base_url, token, id_state) {
  occs <- httr::GET(
    url = paste0(base_url, "/occurrences?idState=", id_state),
    httr::add_headers(Authorization = paste0("Bearer ", token))
  )
  
  if (occs$status_code == 200) {
    occs <- httr::content(occs)
    
    ocss_list <- data.frame()
    for (i in 1:length(occs$data)) {
      ocss_list <- rbind(
        ocss_list,
        c(
          occs$data[[i]]$region$state,
          occs$data[[i]]$latitude,
          occs$data[[i]]$longitude,
          occs$data[[i]]$date,
          occs$data[[i]]$contextInfo$mainReason$name
        )
      )
    }
    
    ## naming vars
    names(ocss_list) <- c("State", "Latitude", "Longitute", "Date", "Motivation")
    
    ## modifying Date to the YYYY-MM-DD format
    ocss_list$Date <- substr(ocss_list$Date, 1, 10)
    occs$Date <- as.Date(occs$Date)
    
    return(ocss_list)
  }
}

## creates a frequency table to categorical var
tabFreqCat <- function(data, num_var) {
  
  tab <- as.data.frame(table(data[, num_var]))
  tab <- tab[order(tab[, 2], decreasing = TRUE),]
  tab$`n (%)` <- paste0(
    tab[, 2], " (",
    round(tab[, 2] / sum(tab[, 2], na.rm = TRUE) * 100, 1), "%)"
  )
  tab <- tab[, c(1, 3)]
  names(tab)[1] <- c("")
  
  return(tab)
}

plotGen <- function(data, date_var, motiv_filter) {
  
  ## filter by motivation
  if (motiv_filter == "All") {
    filtering <- TRUE
  } else {
    filtering <- data[, 5] == motiv_filter
  }
  
  df <- data %>% 
    filter(filtering) %>% 
    group_by(Date) %>%
    summarise(count=n()) %>%
    data.frame()
  
  print(filtering)
  
  return(
    ggplot(data=df, aes(x=Date, y=count)) +
    geom_bar(stat="identity", fill="steelblue")+
    theme_minimal()
    )
}
