library("dplyr")
library("stringr")
library("tidyverse")

# at the moment I am still trying to figure out how to put the data set into the GitHub
# in the meantime you can follow these steps to get the data set and filter it down
# to one data set that we can all use
 
# go to https://www.kaggle.com/datasets/jfreyberg/spotify-chart-data?resource=download
# download the data set, I named mine 'Spotify tracks data.csv'

# load the .csv into R studio
#read.csv("the name of the .csv you downloaded from kaggle")
spotiify_origional <- read.csv("Spotify tracks data.csv")

# filters down the data
# removes the track id, explicit, and duration columns
spotify_modify <- spotiify_origional %>% 
  select(name, country, date, position, streams, artists, genres = artist_genres)

#returns all the data just from 2022
#this is the data set you should you on the project
spotify_2022 <- spotify_modify %>% 
  filter(date >= "2022-01-01") %>% 
  arrange(date) %>% 
  group_by(date)


save(spotify_2022, file = "spotify_tracks_2022")

