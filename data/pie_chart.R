library("dplyr")
library("stringr")
library("tidyverse")
library("ggplot2")
library(scales)


spotiify_origional <- read.csv("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-aa/main/data/charts.csv")
coutries_genres <- spotiify_origional %>% 
  select(country, genres = artist_genres) %>% 
  separate(genres, c("genres"), sep = ',')
View(coutries_genres)

coutries_genres$genres<-gsub("]","",as.character(coutries_genres$genres))
View(coutries_genres)

num_genres <- count(coutries_genres, genres)
num_genres <- num_genres[-c(1), ]
num_genres$n <- as.numeric(as.character(num_genres$n)) / 1000

View(num_genres)

top_10 <- num_genres[order(num_genres$n, decreasing = TRUE), ]
top_10 <- top_10[1:10, ]
top_10 <- top_10 %>% 
  mutate(percentage = n/sum(n))
View(top_10) 

# Create a basic bar
pie <- ggplot(top_10, aes(x="", y=n, fill=genres)) + geom_bar(stat="identity", width=1)
# Convert to pie (polar coordinates) and add labels
pie <- pie + coord_polar("y", start=0) + geom_text(aes(label = paste0(round(percentage*100), "%")), position = position_stack(vjust = 0.5))
# Add color scale (hex colors)
pie <- pie + scale_fill_manual(values=c("#55DDE0", "#33658A", "#2F4858", "#F6AE2D", "#F26419", "#F8766D", "yellow", "red", "blue", "green")) 
# Remove labels and add title
pie<-pie + labs(x = NULL, y = NULL, fill = "Genres", title = "Most Popoular genres across the globe (in thousand)")
# Tidy up the theme
pie<-pie + theme_classic() + theme(axis.line = element_blank(),
                                    axis.text = element_blank(),
                                    axis.ticks = element_blank(),
                                    plot.title = element_text(hjust = 0.5, color = "#666666"))
pie



