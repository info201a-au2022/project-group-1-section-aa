library("dplyr")
library("stringr")
library("tidyverse")
library("ggplot2")

spotiify_origional <- read.csv("charts.csv")
spotiify_origional <- read.csv("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-aa/main/data/charts.csv")

spotify_modify <- spotiify_origional %>% 
  select(name, country, date, position, streams, artists, genres = artist_genres)
View(spotify_modify)

spotify_2022_global <- spotify_modify %>% 
  filter(date >= "2022-01-01") %>% 
  filter(country == "global") %>% 
  arrange(date) %>% 
  group_by(date)
View(spotify_2022_global)


# Most popular 100 songs in the globe
top_100 <- spotify_2022_global[order(spotify_2022_global$streams, decreasing = TRUE), ]
top_100 <- top_100[1:100, ]
View(top_100)  