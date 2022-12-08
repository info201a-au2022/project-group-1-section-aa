library("dplyr")
library("knitr")
library("ggplot2")
library("leaflet")
library("shiny")
library("tidyverse")
library("scales")
library("maps")
library("plotly")


ui <- navbarPage(
  title = "Spotify Top Tracks ",
  tabPanel(
    "Introduction",
    img(src = "https://ggsc.s3.amazonaws.com/images/uploads/Four_people_listening_to_music.jpg", height="50%", width="50%", align="left"),
    img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Spotify_App_Logo.svg/2048px-Spotify_App_Logo.svg.png", height="20%", width="31%", align="button right"),
    h3(""),
    h3("In the past generation, getting discovered as an artist was difficult to accomplish. But with the use streaming services, it has been simple for individuals to explore upcoming artists and songs.
        Although it has been easier to do so, finding new songs can be a challenge, since music is a diverse concept. One of the most popular streaming services, Spotify, contains large amounts of data.
        While many have no clear vision of how these systems operate, along with utalizing them to amplify artist discovery, it is important to expose artists to music listeners. Our focus is to figure 
        out the most popular songs around the globe in 2022, and to find out whether there is an association with demographic location and song popularity. In order to analyze our focus, the data collectection came
        directly from a Spotify dataset. The dataset contained crucial information including songs, artists, location, and streams. We specifically chose to analyze 2022, since it is the most recent year. Nonetheless,
        the goal of this project is to introduce listeners to a wider persepctive, especially when it comes to cultural awareness."),

  tabPanel(
    "Background & Research Questions",
    tabsetPanel(type = "tab",
                tabPanel("Background",
                         h3("Finding new music to listen to can be a constant struggle. 
                             Although streaming platforms have their own recommendation algorithms, 
                             some may say that they have already heard the recommendations. We wanted to reinvent 
                             the music recommendation process. Our project uses a data set from Kaggle that tracks popular songs 
                             from around the globe that were listened to on Spotify. 
                             The website that was developed helps people find new artists and music to listen to based on songs, artists, and genres they already like. 
                             Additionally, it shows different songs that are trending around the globe. 
                             The graphics break down the stats of popular songs and artists in different countries, along with an interactive option.")
                ),
                tabPanel("Research questions",
                         h3("- How do we take data from active listeners to give them a recommended playlist?"),
                         h3("- Does music taste span cultures and languages, based on popular music in different countries?"),
                         h3("- How do we, as users, expand our listening prefrences, according to genre?")
                )
                
    )
  ),
  
  tabPanel(
    "Vis1: Bar chart",
    fluidPage(
      titlePanel("Top 15 Daily Streamings"),
      mainPanel(
      plotlyOutput(outputId = "geo_map", width = "80%", height = "400%"),
      ),
    ),
    h3("This chart showed the top 15 daily streaming songs globally in 2020. 
           In the graph, there are two sections: the bar chart and color legends that 
           allow users to interact and refer to different bars. One interactive aspect 
           of this graph is that you can see a specific note when you move your mouse across each bar. 
           Upon clicking one specific color legend in this interactive graph, 
           the bar corresponding to that color will be removed, which helps the audience 
           better understand the graph by clearing the bar they are not interested in. 
           It will appear again if you click one more time. Finally, the color legend has 
           the function of only displaying the legend you want with a double-click. 
           This function makes it easier for readers to compare genres they like. 
           For example, if I want to compare pop r&b and rap, I can utilize this 
           function to have a more straightforward visualization."),
    ),
  
  tabPanel(
    "Vis2: Line chart",
    fluidPage(
      titlePanel("Streams Over Time"),
      mainPanel(
        plotlyOutput(outputId = "line_chart")
      ),
    ),
    h3("This graph is showing the relationship between the three most popular songs 
        by the amount of streams at the end of September 2022. On this visual, the 
        Y-axis is the amount of streams and the X-axis is the days leading up 
        to the end of September 2022. The different songs are charted according 
        to color; Navy Blue is “Blank Space”, Red is “Don’t Start Now”, and Green 
        is “Levitating (feat. Dababy)”. The most popular song throughout the end 
        of September was Levitating.Through the research we have done we have 
        figured out some interesting things about when the most popular songs 
        are released. One major takeaway is that the spikes in streaming are not 
        only for popular songs, but newly released songs as well during this 2 week period. 
        We found that in addition to the beginning of summer, September/October is the 
        second most popular time to release new music because of back to school and 
        office workers entering the winter months. This promotes a new music culture 
        where people are taking advantage of the music business because these things 
        are happening around the world."),
  ),
  
  tabPanel(
    "Vis3: Map graph",
    fluidPage(
      titlePanel("Popularity of 15 Top Songs Around the Globe"),
      mainPanel(
        selectInput("song_name", label = h3("Song Choices"), 
                    choices = list("About Damn Time", "Bad Decisions (with BTS & Snoop Dogg)", "Blank Space",
                                   "Enemy (with JID) - from the series Arcane League of Legends",
                                   "Heather", "I’m Tired (with Zendaya) - Bonus Track",
                                   "La Corriente", "Last Christmas", "Pepas", "Perfect",
                                   "Something Just Like This", "The Happiest Girl",
                                   "The Real Slim Shady", "Viva La Vida", "Yonaguni"), 
                    selected = 1),
        hr(),
        plotOutput(outputId = "map_graph")
      ),
    ),
    h3("This map of the world shades in each country based on how many streams 
       it had in 2022 for a particular song. If a country is yellow they streamed 
       the song a lot, if the country is purple the country did not stream the 
       song that much, and if the country is gray we have no data. The user can 
       choose to look at one of 15 popular songs from 2022. This map tries to 
       answer the question: How popular were certain songs in different countries? 
       The map makes it pretty obvious when a song had a latest 1 million streams."),
    h3("Some key observations from this map. Just because a song is popular 
       “globally” it does not mean that it is popular in every country. Each of 
       these 15 songs had a lot of streams globally, but were popular in only a 
       few countries. Most other countries did not listen to them much. Thus, 
       some countries have the power to dominate global music charts."),
    h3("Countries in North America, South America, Europe, and Southeast Asia 
       dominated the streams for the top songs. Implying that these countries like 
       each song enough to have it be recognized as popular globally. Looking at 
       only these 15 songs,  most of the artists are American, Puerto Rican, British, 
       or Korean. This could explain the popularity of these songs in different 
       specific regions around the globe.")
  ),
  
  tabPanel(
    "Conclusion",
    tabsetPanel(type = "tab",
                tabPanel("Main takeaways",
                         h3("- From analyzing the data we discovered that songs 
                              that were popular globally (had the most streams total) 
                              were actually only popular in a few countries. Meaning 
                              that a song can gain global popularity if it is trending 
                              in only a few places. It is interesting to see the 
                              countries that have a monopoly over Spotify’s charts.
                              These few countries typically have large populations. 
                              We can also assume that these countries have more Spotify 
                              listeners than the rest of the world.  "),
                         h3("- It's important to acknowledge that Spotify data is 
                                not necessarily a good representation of global music 
                                listeners. People in different countries use other 
                                streaming platforms. Even in just the United States,
                                Apple Music is Spotify's biggest competitor. People 
                                across different cultures and age groups listen to
                                music in other ways as well, the radio, CDs, downloaded songs, 
                                as well as live music. Because many African countries 
                                can not access Spotify, we do not have much data 
                                about their listeners. Spotify is also not available 
                                in China, so we do not have any data for them as well. 
                               So the data set does not encompass the full sense 
                                of music popularity across the world."),
                         h3("-We noticed that “Pop” was a very popular genre across the data set. 
                                Even outside of English speaking countries, A lot of the more streamed 
                                songs were pop songs. Sharing pop songs from different countries can help 
                                bring people together, by bridging cultural gaps. It is important to 
                                recognize the things that connect us, including music, an important 
                                community unifier. Throughout time, music has always  brought people together. 
                                It's a part of human nature to create, perform, and listen to music. 
                                As we have transitioned to a new way of listening (streaming) we should 
                                continue to let it unite us.")
                ),
                
                
                tabPanel("Future work",
                         h3("Technologists: In the future, technologists 
                                can utilize what we have to create unique, 
                                user-oriented projects across a wide range of fields. 
                                We envision our project to be applicable towards music, real estate, food delivery, 
                                the automobile market, and many others.") ,
                         h3("A designer's main objective is to create unique 
                                visual representations that help customers understand 
                                their needs. Our website allows designers to better 
                                understand what their clients need by accessing it. 
                                Furthermore, designers are capable of developing efficient 
                                solutions that satisfy clients' requirements and, most 
                                importantly, create visuals that are unique and personal 
                                for clients."),
                         h3("Spotify can better understand people's needs by evaluating 
                                the data our program provides. The streaming service can also expand
                                 to be more globally focused. Along with developing a more 
                                equalized social environment. ")
                )
    )
  ),
  
  tabPanel(
    "About us",
    h3("Team members: Harry Hall, Olivia Sapp, Jiajie He, Terra Shrestha"),
    h3("Contact Info:"),
    h3("Harry :  hhall5@uw.edu"),
    h3("Olivia:  osapp2@uw.edu"),
    h3("Jiajie: jiajih@uw.edu"),
    h3("Terra: Tshres@uw.edu")
  )
)
