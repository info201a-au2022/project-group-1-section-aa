library("dplyr")
library("stringr")
library("tidyverse")
library("ggplot2")

# load the .csv into R studio, you can do this 1 of 2 ways
#read.csv("the name of the .csv you downloaded from kaggle")
spotiify_origional <- read.csv("charts.csv")
spotiify_origional <- read.csv("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-aa/main/data/charts.csv")
View(spotiify_origional)
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
View(spotiify_origional)

spotify_2022_global <- spotify_modify %>% 
  filter(date >= "2022-01-01") %>% 
  filter(country == "global") %>% 
  arrange(date) %>% 
  group_by(streams)
View(spotify_2022_global) 

top_3 <- spotify_2022_global[order(spotify_2022_global$streams, decreasing = TRUE), ]
top_3 <- top_3[1:3,]
top_3$streams <- as.numeric(top_3$streams)
View(top_3)  

col_chart <- ggplot(data = top_3) + 
  geom_col(mapping = aes(x = name, y = streams)) +
  ggtitle("Top Three Songs Daily Streamed Globally") +
  theme(plot.title = element_text(hjust = 0.5))
col_chart <- col_chart + coord_cartesian(ylim = c(999000,1000000))
col_chart

# Bar Chart Paragraph :
