library(shiny)
library(shinythemes)
library(ggplot2)
library(DT)
library(dplyr)

data <- read.csv("Telco-Customer-Churn.csv", stringsAsFactors = FALSE)

if (!file.exists("history_log.csv")) {
  write.csv(data.frame(Time = character(), Action = character(), Detail = character()),
            "history_log.csv", row.names = FALSE)
}

users <- data.frame(
  username = c("admin", "user1"),
  password = c("adminpass", "userpass"),
  role = c("admin", "user"),  
  stringsAsFactors = FALSE
)

check_user <- function(username, password) {
  # Loại bỏ khoảng trắng thừa và chuyển về chữ thường
  username <- tolower(trimws(username))
  password <- trimws(password)
  
  # So sánh username và password nhập vào với dữ liệu trong 'users'
  user_info <- users %>% 
    filter(tolower(trimws(username)) == tolower(trimws(username)), 
           trimws(password) == trimws(password))
  
  if (nrow(user_info) == 1) {
    return(user_info)
  } else {
    return(NULL)
  }
}


