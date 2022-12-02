library("dplyr")
library("stringr")
library("tidyverse")
library("scales")
library("ggplot2")
library("maps")



# load the .csv into R studio, you can do this 1 of 2 ways
#read.csv("the name of the .csv you downloaded from kaggle")
spotiify_origional <- read.csv("charts.csv")
#spotiify_origional <- read.csv("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-aa/main/data/charts.csv")

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
spotify_2022$streams <- as.numeric(spotify_2022$streams)

View(spotify_2022)

spotify_2022_global <- spotify_modify %>% 
  filter(date >= "2022-01-01") %>% 
  filter(country == "global") %>% 
  arrange(date) %>% 
  group_by(date)
View(spotify_2022_global)

# use write.csv() to turn the new dataset into a .csv file
#write.csv(Your DataFrame,"Path to export the DataFrame\\File Name.csv", row.names = FALSE)
#write.csv(spotify_2022_global, "/Users/oliviasapp/Documents/info201/project-group-1-section-aa/data/spotify_2022.csv" , row.names = FALSE)


# top 5 most popular songs globally 
top_5 <- spotify_2022_global[order(spotify_2022_global$streams, decreasing = TRUE), ]
top_5 <- top_5[1:5, ]
top_5$streams <- as.numeric(top_5$streams)
View(top_5)  
# Pepas, Blank Space, I'm Tired, Yonaguni, and Heather
# were the most streamed song of the year according to top_5

# Map code, kind of long

# makes the map template
world_map <- map_data("world")
ggplot(world_map, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill="lightgray", colour = "white")

# a new data frame that has all the abrevated country codes and the country names
#abrevations <- read.csv("https://pkgstore.datahub.io/core/country-list/data_csv/data/d7c9d7cfb42cb69f4422dec222dbbaa8/data_csv.csv")
abrevations <- read.csv("wikipedia-iso-country-codes.csv")

# shortens abreviations to only include names and 2 char codes
abrevations <- abrevations %>% 
  select(region = English.short.name.lower.case, Code = Alpha.2.code)

# makes a list off all the countries where the song was popular this year
get_song_streams <- function(song_name) {
  song_streams <- spotify_2022 %>% 
    select(name, date, country, streams) %>% 
    filter(name == song_name) %>% 
    filter(country != "global") %>% 
    group_by(country) %>% 
    summarize(streams = sum(streams)) %>% 
    rename(Code = country)  
  song_streams$Code <- toupper(song_streams$Code) #capatalizes country codes
  
  # data frame that join's abrevations with the modified countries that listened to a song
  # if a country listened to Peopas they get a 1, if not they get a 0
  abrevs <- left_join(abrevations, song_streams, by = "Code") %>% 
    replace(is.na(.), 0)
  
  # fixes some of the names of the countries in abrevs so they match the countries in world_map
  abrevs$region <- str_replace(abrevs$region, "United States Of America", "USA")
  abrevs$region <- str_replace(abrevs$region, "Libyan Arab Jamahiriya", "Libya")
  abrevs$region <- str_replace(abrevs$region, "Côte d'Ivoire", "Ivory Coast")
  abrevs$region <- str_replace(abrevs$region, "Tanzania, United Republic of", "Tanzania")
  abrevs$region <- str_replace(abrevs$region, "Republic of Democratic Republic of the Congo", "Democratic Republic of the Congo")
  abrevs$region <- str_replace(abrevs$region, "Congo", "Republic of Congo")
  abrevs$region <- str_replace(abrevs$region, "Republic of Republic of Republic of Congo", "Republic of Congo")
  abrevs$region <- str_replace(abrevs$region, "South Sudan", "Sudan") 	
  abrevs$region <- str_replace(abrevs$region, "Syrian Arab Republic", "Syria")
  abrevs$region <- str_replace(abrevs$region, "Korea, Democratic People's Republic of", "North Korea")
  abrevs$region <- str_replace(abrevs$region, "Korea, Republic of (South Korea)", "South Korea")
  abrevs$region <- str_replace(abrevs$region, "Lao People's Democratic Republic", "Laos")
  abrevs$region <- str_replace(abrevs$region, "United Kingdom", "UK")
  abrevs$region <- str_replace(abrevs$region, "Moldova, Republic of", "Moldova")
  abrevs$region <- str_replace(abrevs$region, "Macedonia, the former Yugoslav Republic of", "North Macedonia")
 
   # dataframe that will go into the map
  top_country.map <- left_join(world_map, abrevs, by = "region")
  
  return(top_country.map)
}


# gets rid of grid lines
blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        # remove axis lines
    axis.text = element_blank(),        # remove axis labels
    axis.ticks = element_blank(),       # remove axis ticks
    axis.title = element_blank(),       # remove axis titles
    plot.background = element_blank(),  # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank()      # remove border around plot
  )

plot_song_map <- function(song_name){
  # map of the world. Yellow countries listened to Blenk Space, blue countries did not
  # grey countries means we have no data
  plot<- ggplot(get_song_streams(song_name), aes(map_id = region, fill = streams))+
    geom_map(map = top_country.map,  color = "white")+
    expand_limits(x = top_country.map$long, y = top_country.map$lat)+
    ggtitle(paste("How popular was the song", song_name, "in each country?")) +
    scale_fill_continuous(type = "viridis", labels = comma) +
    labs(fill = "Streams") + 
    blank_theme
  return(plot)
}

plot_song_map("Pepas")
plot_song_map("Blank Space")
plot_song_map("I’m Tired (with Zendaya) - Bonus Track")
plot_song_map("Yonaguni")
plot_song_map("Heather")

