library("dplyr")
library("stringr")
library("tidyverse")

spotiify_origional <- read.csv("Spotify tracks data.csv")

spotify_modify <- spotiify_origional %>% 
  select(name, country, date, position, streams, artists, genres = artist_genres)

spotify_2022 <- spotify_modify %>% 
  filter(date >= "2022-01-01") %>% 
  arrange(date) %>% 
  group_by(date)
  
  
spotify_position <- spotify_2022%>% 
  group_by(date) %>% 
  arrange(position) 
  
spotify_recent <- spotify_modify %>% 
  filter(date == max(date))

