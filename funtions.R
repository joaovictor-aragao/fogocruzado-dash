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
    
    return(statedf)
    
  }
}

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
    
    return(ocss_list)
  }
}