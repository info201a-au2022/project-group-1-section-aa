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
spotify_2022_global <- spotify_modify %>% 
  filter(date >= "2022-01-01") %>% 
  filter(country == "global") %>% 
  arrange(date) %>% 
  group_by(date)
View(spotify_2022)

# use write.csv() to turn the new dataset into a .csv file
write.csv(Your DataFrame,"Path to export the DataFrame\\File Name.csv", row.names = FALSE)
write.csv(spotify_2022, "/Users/oliviasapp/Documents/info201/project-group-1-section-aa/data/spotify_2022.csv" , row.names = FALSE)

# then I pushed the spotify_2022.csv to the GitHub repo



# Most popular 3 songs in the globe
top_3 <- spotify_2022_global[order(spotify_2022_global$streams, decreasing = TRUE), ]
top_3 <- top_3[1:3, ]
top_3$streams <- as.numeric(top_3$streams)
View(top_3)  

# rough bar chart
col_chart <- ggplot(data = top_3) + 
  geom_col(mapping = aes(x = name, y = streams)) +
  ggtitle("Top song's daily streamings across the globe") +
  theme(plot.title = element_text(hjust = 0.5))
col_chart <- col_chart + coord_cartesian(ylim = c(999000,1000000))
col_chart

#final bar chart
col_chart <- ggplot(data = top_3) + 
  geom_col(mapping = aes(x = name, y = streams)) +
  ggtitle("Top Three Songs Daily Streamed Globally") +
  theme(plot.title = element_text(hjust = 0.5))
col_chart <- col_chart + coord_cartesian(ylim = c(999000,1000000))
col_chart

# Most popular 100 sgns in the globe
top_100 <- spotify_2022_global[order(spotify_2022_global$streams, decreasing = TRUE), ]
top_100 <- top_100[1:100, ]
top_100$streams <- as.numeric(top_100$streams)
View(top_100)  


#Rough scatter plot Code
scatter_chart <- ggplot(data = top_100) +
  geom_point(mapping = aes(x = position, y = streams))
scatter_chart <- scatter_chart + scale_y_continuous(limits = c(985000, 1000000)) 
scatter_chart

#Final Scatter Plot Code
scatter_chart <- ggplot(data = top_100, colour = position) +
  geom_point(mapping = aes(x = position, y = streams)) + (aes(color = (position))) +
  labs(
    title =
      "Relationship between Streams and Position on Top 200 Charts",
    subtitle =
      "Data Provided by Kaggle and Spotify",
    caption = "Color Coding Refers To Top 200 Song Placement"
  )
scatter_chart <- scatter_chart + scale_y_continuous(limits = c(985000, 1000000)) 
scatter_chart

