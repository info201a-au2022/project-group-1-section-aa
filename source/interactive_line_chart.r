library("dplyr")
library("stringr")
library("tidyverse")
library("ggplot2")
library("plotly")
install.packages("plotly")

spotiify_origional <- read.csv("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-aa/main/data/charts.csv")
View(spotiify_origional)

spotify_modify <- spotiify_origional %>% 
  select(name, country, date, position, streams, artists, genres = artist_genres)

spotify_2022 <- spotify_modify %>% 
  filter(date >= "2022-01-01") %>% 
  arrange(date) %>% 
  group_by(date)

spotify_2022_global <- spotify_modify %>% 
  filter(date >= "2022-09-17") %>%
  filter(date <= "2022-09-29") %>% 
  filter(country == "global") %>% 
  filter(name =="Blank Space") %>% 
  mutate(date = as.Date(date)) %>% 
  mutate(streams = as.numeric(streams)) %>% 
  arrange(date) %>% 
  group_by(streams)

spotify_2022_global1 <- spotify_modify %>% 
  filter(date >= "2022-09-17") %>%
  filter(date <= "2022-09-29") %>% 
  filter(country == "global") %>% 
  mutate(date = as.Date(date)) %>% 
  filter(name == "Don't Start Now") %>% 
  mutate(streams = as.numeric(streams)) %>% 
  arrange(date) %>% 
  group_by(streams)

spotify_2022_global2 <- spotify_modify %>% 
  filter(date >= "2022-09-17") %>%
  filter(date <= "2022-09-29") %>% 
  filter(country == "global") %>% 
  mutate(date = as.Date(date)) %>% 
  filter(name == "Levitating (feat. DaBaby)") %>% 
  mutate(streams = as.numeric(streams)) %>% 
  arrange(date) %>% 
  group_by(streams)

View(spotify_2022_global)

stream_3 <- ggplot() + 
    geom_line(data=spotify_2022_global, aes(x=date, y=streams, group=1, color="Blank Space",)) + 
  geom_line(data=spotify_2022_global1, aes(x=date, y=streams, group=2, color="Don't Start Now")) + 
  geom_line(data=spotify_2022_global2, aes(x=date, y=streams, group=3, color="Levitating (feat. DaBaby)")) + 
  scale_color_manual(name = "Song Name", values = c("Blank Space" = "darkblue", "Don't Start Now" = "red", "Levitating (feat. DaBaby)" = "green")) +
  xlab("Date(2022)") + ylab("Amount of Streams") +
  ggtitle("Three Songs Top Consecutive Streaming Days")
  
plot(stream_3)

ggplotly(stream_3)
