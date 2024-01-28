
getwd()
setwd("/Users/poisson/Documents/数理统计/Web Scraping")

# load packages
install.packages("rvest")
install.packages("dplyr")

library(rvest)
library(dplyr)
library(xml2)

# read data
url = url("https://movie.douban.com/top250", 'rb')
page = read_html(url)
# capture.output(xml_structure(page))

# automatically scrape the other info from nested page
get_year = function(movie_links){
  # movie_page = read_html("https://movie.douban.com/subject/1292052/")
  movie_page = read_html(movie_links)
  year = movie_page %>% html_nodes("span.year") %>% html_text()
  year = gsub("[^0-9]+", "", year)
  return(year)
}

get_country = function(movie_links){
  # movie_page = read_html("https://movie.douban.com/subject/1292052/")
  movie_page = read_html(movie_links)
  country = movie_page %>% html_nodes("span:nth-child(17)") %>% html_attr("content") %>% gsub("\\d{4}-\\d{2}-\\d{2}\\((.*?)\\)", "\\1", .)
  return(country)
} # not accurate and completed, need be fixed


get_director = function(movie_links){
  movie_page = read_html(movie_links)
  # movie_page = read_html("https://movie.douban.com/subject/1292052/")
  director = movie_page %>% html_nodes("span.attrs") %>% html_text()
  director = director[1]
  return(director)
}

get_cast= function(movie_links){
  movie_page = read_html(movie_links)
  # movie_page = read_html("https://movie.douban.com/subject/1292052/")
  cast = movie_page %>% html_nodes("span.attrs") %>% html_text()
  cast = cast[3]
  return(cast)
}

# scrape some info from the ranking page
title = page %>% html_nodes(".title:nth-child(1)") %>% html_text()
other = page %>% html_nodes("span.other") %>% html_text()
comment = page %>% html_nodes(".inq") %>% html_text()
rating = page %>% html_nodes(".rating_num") %>% html_text()
links = page %>% html_nodes(".hd a") %>% html_attr('href')

# apply functions to all nested links
year = sapply(links, FUN = get_year, USE.NAMES = FALSE)
country = sapply(links, FUN = get_country, USE.NAMES = FALSE)
country = unlist(country)
country = lapply(country, function(x) ifelse(length(x) == 0, NA, x))
director = sapply(links, FUN = get_director, USE.NAMES = FALSE)
cast = sapply(links, FUN = get_cast, USE.NAMES = FALSE)

# create df and store values
movies = data.frame(title, other, rating, year, country, director, cast, comment, links, stringsAsFactors = FALSE)
view(movies)





for (page_num in seq(from = 0, to = 225, by = 25)) {
  
  url = paste("https://movie.douban.com/top250?start=",page_num,"&filter=") 
  
  # Set the simulated user agent string
  user_agent_string = "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.20 (KHTML, like Gecko) Chrome/11.0.672.2 Safari/534.20"
  user_agent = httr::user_agent(user_agent_string)
  
  page_link = session(url, user_agent)
  
  page = read_html(page_link)}

# scrape some info from the ranking page
title = page %>% html_nodes(".title:nth-child(1)") %>% html_text()
other = page %>% html_nodes("span.other") %>% html_text()
comment = page %>% html_nodes(".inq") %>% html_text()
rating = page %>% html_nodes(".rating_num") %>% html_text()
links = page %>% html_nodes(".hd a") %>% html_attr('href')

# apply functions to all nested links
year = sapply(links, FUN = get_year, USE.NAMES = FALSE)
country = sapply(links, FUN = get_country, USE.NAMES = FALSE)
country = unlist(country)
country = lapply(country, function(x) ifelse(length(x) == 0, NA, x))
director = sapply(links, FUN = get_director, USE.NAMES = FALSE)
cast = sapply(links, FUN = get_cast, USE.NAMES = FALSE)

# create df and store values
movies = data.frame(title, other, rating, year, country, director, cast, comment, links, stringsAsFactors = FALSE)
}




