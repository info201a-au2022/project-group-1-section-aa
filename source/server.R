library(shiny)
source("ui.R")
spotiify_origional <- read.csv("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-aa/main/data/charts.csv")


my_server <- function(input, output) {
    output$geo_map <- renderPlotly({
        spotify_modify <- spotiify_origional %>% 
            select(name, country, date, position, streams, artists, genres = artist_genres)
        
        #returns all the data just from 2022
        #this is the data set you should you on the project
        spotify_2022 <- spotify_modify %>% 
            filter(date >= "2022-01-01") %>% 
            arrange(date) %>% 
            group_by(date)
        
        spotify_2022_global <- spotify_modify %>% 
            filter(date >= "2022-01-01") %>% 
            filter(country == "global") %>% 
            arrange(date) %>% 
            group_by(streams)
        
        top_15 <- spotify_2022_global[order(spotify_2022_global$streams, decreasing = TRUE), ]
        top_15 <- unique(top_15[1:15,])
        top_15$streams <- as.numeric(top_15$streams)
        
        top_15 <- top_15 %>% 
            separate(genres, c("genres"), sep = ',')
        top_15$genres <- gsub("]|\\[|[']","",as.character(top_15$genres))
        
        col_chart <- ggplot(data = top_15) + geom_col(mapping = aes(x = name, y = streams, fill = genres)) +   
            ggtitle("Top 15 Songs Daily Streamed Globally") + 
            theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(angle = 45, hjust = 1)) + 
            coord_cartesian(ylim = c(995000,1000000))
        col_chart
        
        col_chart <- ggplot(data = top_15) + geom_col(mapping = aes(x = name, y = streams, fill = genres)) +   
            labs(x = "Name",
                 y = "Streams",
                 title = "Top 15 Songs Daily Streamed Globally in 2020",
                 caption = "Note: The song 'Something Just Like This' appears twice in the top daily streams data"
            ) +   theme(plot.caption = element_text(hjust=0)) +
            theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(angle = 45, hjust = 1)) + 
            coord_cartesian(ylim = c(995000,1000000))
        col_chart
        
        ggplotly(col_chart)
    })
    
    output$line_chart <- renderPlotly({
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
        
        stream_3 <- ggplot() + 
            geom_line(data=spotify_2022_global, aes(x=date, y=streams, group=1, color="Blank Space",)) + 
            geom_line(data=spotify_2022_global1, aes(x=date, y=streams, group=2, color="Don't Start Now")) + 
            geom_line(data=spotify_2022_global2, aes(x=date, y=streams, group=3, color="Levitating (feat. DaBaby)")) + 
            scale_color_manual(name = "Song Name", values = c("Blank Space" = "darkblue", "Don't Start Now" = "red", "Levitating (feat. DaBaby)" = "green")) +
            xlab("Date(2022)") + ylab("Amount of Streams") +
            ggtitle("Three Songs Top Consecutive Streaming Days")
        stream_3
        
        ggplotly(stream_3)
    })
    
   output$map_graph <- renderPlot({
    spotify_modify <- spotiify_origional %>% 
      dplyr::select(name, country, date, position, streams, artists, genres = artist_genres)
    #returns all the data just from 2022
    #this is the data set you should you on the project
    spotify_2022 <- spotify_modify %>% 
      filter(date >= "2022-01-01") %>% 
      arrange(date) %>% 
      group_by(date)
    spotify_2022$streams <- as.numeric(spotify_2022$streams)
    
    spotify_2022_global <- spotify_modify %>% 
      filter(date >= "2022-01-01") %>% 
      filter(country == "global") %>% 
      arrange(date) %>% 
      group_by(date)
    
    # top 5 most popular songs globally 
    top_5 <- spotify_2022_global[order(spotify_2022_global$streams, decreasing = TRUE), ]
    top_5 <- top_5[1:5, ]
    top_5$streams <- as.numeric(top_5$streams)
    
    # Pepas, Blank Space, I'm Tired, Yonaguni, and Heather
    # were the most streamed song of the year according to top_5
    
    # Map code        
    # makes the map template
    world_map <- map_data("world")
    ggplot(world_map, aes(x = long, y = lat, group = group)) +
      geom_polygon(fill="lightgray", colour = "white")
    
    # a new data frame that has all the abrevated country codes and the country names
    abrevations <- read.csv("https://pkgstore.datahub.io/core/country-list/data_csv/data/d7c9d7cfb42cb69f4422dec222dbbaa8/data_csv.csv")
    #abrevations <- read.csv("wikipedia-iso-country-codes.csv")
    
    abrevations <- abrevations %>% 
      dplyr::select(region = Name, Code)
    
    # fixes some of the names of the countries in abrevations so they match the countries in world_map in the  get_song_streams function
    
    abrevations$region <- str_replace(abrevations$region, "United States", "USA")
    abrevations$region <- str_replace(abrevations$region, "Libyan Arab Jamahiriya", "Libya")
    abrevations$region <- str_replace(abrevations$region, "Côte d'Ivoire", "Ivory Coast")
    abrevations$region <- str_replace(abrevations$region, "Tanzania, United Republic of", "Tanzania")
    abrevations$region <- str_replace(abrevations$region, "Republic of Congo, the Democratic Republic of the", "Democratic Republic of the Congo")
    abrevations$region <- str_replace(abrevations$region, "Congo", "Republic of Congo")
    abrevations$region <- str_replace(abrevations$region, "South Sudan", "Sudan") 	
    abrevations$region <- str_replace(abrevations$region, "Syrian Arab Republic", "Syria")
    abrevations$region <- str_replace(abrevations$region, "Korea, Democratic People's Republic of", "North Korea")
    abrevations$region <- str_replace(abrevations$region, "Korea, Republic of", "South Korea")
    abrevations$region <- str_replace(abrevations$region, "Lao People's Democratic Republic", "Laos")
    abrevations$region <- str_replace(abrevations$region, "United Kingdom", "UK")
    abrevations$region <- str_replace(abrevations$region, "Moldova, Republic of", "Moldova")
    abrevations$region <- str_replace(abrevations$region, "Macedonia, the former Yugoslav Republic of", "North Macedonia")
    abrevations$region <- str_replace(abrevations$region, "Venezuela, Bolivarian Republic of", "Venezuela")
    abrevations$region <- str_replace(abrevations$region, "Russian Federation", "Russia")
    abrevations$region <- str_replace(abrevations$region, "Bolivia, Plurinational State of", "Bolivia")
    abrevations$region <- str_replace(abrevations$region, "Iran, Islamic Republic of", "Iran")
    abrevations$region <- str_replace(abrevations$region, "Viet Nam", "Vietnam")
    abrevations$region <- str_replace(abrevations$region, "Macedonia, the Former Yugoslav Republic of", "North Macedonia")
    
    
    
    # makes a list off all the countries where the song was popular this year
    get_song_streams <- function(song_name) {
      song_streams <- spotify_2022 %>% 
        dplyr::select(name, date, country, streams) %>% 
        filter(name == input$song_name) %>% 
        filter(country != "global") %>% 
        group_by(country) %>% 
        summarize(streams = sum(streams)) %>% 
        rename(Code = country)  
      song_streams$Code <- toupper(song_streams$Code) #capatalizes country codes
      
      # data frame that joins abrevations with the modified countries that listened to a song
      abrevs <- left_join(abrevations, song_streams, by = "Code") %>% 
        replace(is.na(.), 0)
      
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
    
    # plot_song_map <- function(input){
    #   # map of the world. Yellow countries listened to the song a lot, blue countries did not
    #   # grey countries means we have no data
    #   plot<- ggplot(get_song_streams(input$song_name), aes(map_id = region, fill = streams))+
    #     geom_map(map = get_song_streams(input$song_name),  color = "white")+
    #     expand_limits(x = get_song_streams(input$song_name)$long, 
    #                   y = get_song_streams(input$song_name)$lat)+
    #     ggtitle(paste("How popular was the song", input$song_name, "in each country?")) +
    #     scale_fill_continuous(type = "viridis", labels = comma) +
    #     labs(fill = "Streams") + 
    #     blank_theme
    #   return(plot)
    # }
    
  
    ggplot(get_song_streams(input$song_name), aes(map_id = region, fill = streams))+
      geom_map(map = get_song_streams(input$song_name),  color = "white")+
      expand_limits(x = get_song_streams(input$song_name)$long, 
                    y = get_song_streams(input$song_name)$lat)+
      ggtitle(paste("How popular was the song", input$song_name, "in each country?")) +
      scale_fill_continuous(type = "viridis", labels = comma) +
      labs(fill = "Streams") + 
      blank_theme
    
  })
    
    
}
