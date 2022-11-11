library("dplyr")
library("stringr")
library("tidyverse")

# I wanted to make our data set smaller so it could be easier to use
# The full dataset is called charts.csv and the one I made is called spotify_2022.csv
# this takes the spotify data set we had and filters it to only data from 2022
# I used these steps to filter it down
# YOU DO NOT NEED TO READ/DO THIS, I just want the record for myself
 
# got the data from https://www.kaggle.com/datasets/jfreyberg/spotify-chart-data?resource=download
# go to the GitHUb project repo, open data then open charts.csv

# load the .csv into R studio, you can do this 1 of 2 ways
#read.csv("the name of the .csv you downloaded from kaggle")
spotiify_origional <- read.csv("charts.csv")
spotiify_origional <- read.csv("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-aa/main/data/charts.csv")

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

# use write.csv() to turn the new dataset into a .csv file
write.csv(Your DataFrame,"Path to export the DataFrame\\File Name.csv", row.names = FALSE)
write.csv(spotify_2022, "/Users/oliviasapp/Documents/info201/project-group-1-section-aa/data/spotify_2022.csv" , row.names = FALSE)

# then I pushed the spotify_2022.csv to the GitHub repo
