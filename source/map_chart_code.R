library("dplyr")
library("stringr")
library("tidyverse")
library("scales")
library("ggplot2")
library("maps")
library("scales")


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
#write.csv(Your DataFrame,"Path to export the DataFrame\\File Name.csv", row.names = FALSE)
write.csv(spotify_2022, "/Users/oliviasapp/Documents/info201/project-group-1-section-aa/data/spotify_2022.csv" , row.names = FALSE)


# Most popular 3 songs in the globe
top_3 <- spotify_2022_global[order(spotify_2022_global$streams, decreasing = TRUE), ]
top_3 <- top_3[1:3, ]
top_3$streams <- as.numeric(top_3$streams)
View(top_3)  
# Pepas was the most streamed song of the year according to top_3

# Map code, kind of long

# makes the map template
world_map <- map_data("world")
ggplot(world_map, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill="lightgray", colour = "white")

# makes a list off all the countries where Pepas was popular this year
top_country <- spotify_2022 %>% 
  select(name, date, country) %>% 
  filter(name == "Pepas") %>% 
  filter(country != "global")
top_country <- unique(top_country$country)
top_country <- toupper(top_country) #capatalizes country codes

# transitional data frame, assigns 1 to all the countries in top_country to record
# which countries listened to Pepas
tc2 <- data.frame(Code = top_country, yes_no = "yes")

# a new data frame that has all the abrevated country codes and the country names
abrevations <- read.csv("https://pkgstore.datahub.io/core/country-list/data_csv/data/d7c9d7cfb42cb69f4422dec222dbbaa8/data_csv.csv")
abrevations <- read.csv("wikipedia-iso-country-codes.csv")

# shortens abreviations to only include names and 2 char codes
abrevations <- abrevations %>% 
  select(region = English.short.name.lower.case, Code = Alpha.2.code)

# data frame that join's abrevations with the modified countries that listened to Pepas
# if a country listened to Peopas they get a 1, if not they get a 0
abrevs <- left_join(abrevations, tc2, by = "Code")
abrevs <- abrevs %>% 
  mutate(yes_no = replace_na(yes_no, "no"))

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

plotclr <- c("yellow","blue")  #Choose the collors you want to plot

# map of the world. Yellow countries listened to Pepas, blue countries did not
# grey countries means we have no data
# I NEED to fix the key on the side to be more clear
ggplot(top_country.map, aes(map_id = region, fill = yes_no))+
  geom_map(map = top_country.map,  color = "white")+
  expand_limits(x = top_country.map$long, y = top_country.map$lat)+
  ggtitle("Was the Global Top Song of 2022 (Pepas) Popular in these Countries?") +
  scale_fill_manual(values = c("dark red", "pink"))


