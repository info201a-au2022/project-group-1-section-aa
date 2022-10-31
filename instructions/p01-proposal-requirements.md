# Instructions for P01: Project Proposal 

* **Where is the project brief?**  [`../instructions/project-design-brief.pdf`](../instructions/project-design-brief.pdf).
* **Making Progress**: We understand this project might be difficult. Also, we understand that your project ideas might not be completely worked out. So, we ask that you do the best you can. You will receive specific guidance from your TA and constructive feedback. We are confident that you will succeed! 
* **What should be included in the proposal?** Every proposal will be different. It depends on your particular project.  That said, in the table below you will find the **required** report elements.  It is important that you engage with and respond to the the Design Brief. 
* **How should the proposal be formatted?** You should format your proposal using Markdown. You should aim for a professional presentation - clear, concise, inclusive, interesting, and free of spelling and grammatical errors. 
* **What headings should we use?** As needed, the suggested headings below can be revised and new headings and sub-headings can be added. Please use headings, bullet lists, tables, figures, and other markdown code effectively - seek a professional presentation. 
* **Questions?** If you have questions, please ask your TA or post on Teams.

|Element | Brief Description|
|---------------| --------------
|Code name | M-you-sic | 
|Project title| Give your project a concise, interesting title that summarizes the entirety of your project. (Your title can change on subsequent deliverables.) |
|Authors | Names of your team members and contact information (UW email addresses). |
|Affiliation |  INFO-201: Technical Foundations of Informatics - The Information School - University of Washington |
|Date | Autumn 2022|
|Abstract | Write a short abstract of three sentences. Your abstract should summarize your entire project, but only the very most important aspects. Here are two examples of how you might structure your abstract: **(1)** "Our main question is .... This question is important because .... To address the question, we will ...." and **(2)** "We are concerned with ..., because .... To address this concern, we plan to ...." |
|Keywords | Music, Spotify Streaming, Global 
 |
|Introduction | Finding new music to listen to seems to be a constant struggle. Sure streaming platforms all have their own recommendation algorithms, but it feels like you've heard all these songs before. We wanted to reinvent the music recommendation process. Our project uses a data set that tracks popular songs from around the globe that were listened to on Spotify. We got our dataset from kaggle. It looks at variables such as: song name, country, date, artist, genre, streams, and a position it appears in a country’s chart . We want to develop a website that helps people find new artists and music to listen to based on songs, artists, and genres they like. You would answer a few questions to gauge your music taste, and in return the website provides personalized music recommendations. We could show different songs that are  trending around the globe. We have graphics that break down the stats of popular songs and artists in different countries. We want our website to be interactive and focus on a global perspective. Expanding your worldview and exposure to different cultures through music. |
|Problem Domain | In the past generation of music, becoming discovered as a new artist was a very hard feat to accomplish. However, over the past few years, streaming services have made this feat easier to accomplish by using data sets collected by users' interactions to recommend new artists and songs. “Yet, as algorithmic recommendations take center stage in the music discovery landscape, the professional community at large still perceives these recommender algorithms as black boxes.”(Jones, Morgan) Music professionals rely on recommender systems across platforms like Spotify and YouTube to increase the ad budgets, connect with new audiences, and all-around execute successful release campaigns. While often having no clear vision of how these systems operate and how to leverage them to amplify artist discovery. The topic of unveiling AI-driven recommender systems and providing music professionals with the resources and tools they need to understand and manage these algorithms will be a big focus for Music Tomorrow throughout 2022. Our focus for this project is to figure out how these recommendation playlists are created and how they affect the direct and indirect stakeholders. 
Possible harms to the stakeholders are the accessibility issues. No matter what your favorite genre is, chances are your information is accessed and most data falls through a crack in the process, music services are afflicted by a data gap. This impacts not only how music cultures evolve, but how artists who fit into an acceptable genre are compensated versus those who fall through the cracks. The main cause of this disconnect is the misanalysis of, or a failure to even see, various subgenres of music styles. That is one of the main harms in the creation of this algorithm. 
Benefits would fall upon popular artists and the direct stakeholders because they only see who they like and the popular artists can make more money. As you can see in the graphic above, the streaming sites take up a large majority of the music industry. As a result of this, this algorithm has the potential to make unpopular artists less popular and popular artists rise to the top, creating a big gap. However our main goal is to learn how we take data from active listeners to give them a recommended playlist; For example, what BPM do they listen to, what is their favorite artist, do they like similar songs. We will take on the challenge of understanding how the recommended playlist works so we can benefit the direct stakeholders and indirect stakeholders.

“How Do Music Recommendations Work to Boost User Engagement?” Algolia Blog, https://www.algolia.com/blog/ux/how-does-a-music-recommendations-algorithm-work-to-boost-user-engagement/. 
Jones, Morgan. “Spotify's Algorithm Explained.” Bippermedia.com, 8 Apr. 2022, https://bippermedia.com/spotifys-algorithm-explained/. 
“Music Streaming Services Mishandle Our Data-and Our Culture Is Paying for It.” Quartz, 3 Jan. 2020, https://qz.com/1773480/the-problem-with-how-the-music-streaming-industry-handles-data. |
|Research Questions | Our main question is how do we take data from active listeners to give them a recommended playlist; For example, what BPM do they listen to, what is their favorite artist, do they like similar songs
The motivation behind this question is that this is what the bulk of our project is, figuring out how the specific data sets are paired and how new songs are suggested. We are concerned with finding popular songs across different countries because we want to know if music taste can span cultures and languages. To address this we can filter the data to find the most popular songs, genres, and artists by country. Another research question we want to explore is how to provide equal opportunities to every artist within the platform. The reason for this is that to cross cultures, we should not be restricted to a single genre such as pop or R&B. By creating a user-oriented algorithm, we can categorize the recommendation lists into various sections like "popular artists," "new artists," and thus users can explore different artist and genre based on their preferences. Another thing we will consider is the way we design the user interface.
Motivation: Being the first thing user will see, it is important to make the website as straightforward and neat as possible. So base on top of that, we need to explore different ways to arrange buttons/sections and provide users with the most convenient way to explore music.|
|The Dataset | **(1)** The dataset contains variables that are related to the problem domain/research question, and this includes name, country, streams, and genre. Since our research question is about taking data from active listeners in order to give them a recommended playlist, we will take the variables and filter them to answer it. The most crucial variables will be the name of the song, and the amount of streams. Getting the data that represents the most streamed song in a certain year and demographic will allow for our project to generate a recommended playlist to listeners, based on a specific genre they like. To determine the type of genre/music a listener likes, a survey would be made. 
**(2)** 
| Name | Observations | Variables |
|------|--------------|-----------|
|Spotify Track Dataset|
|
 **(3)** Freyberg, J. (2022, October 20). Spotify Tracks Chart Dataset (2014-2022). Kaggle. Retrieved October 30, 2022, from https://www.kaggle.com/datasets/jfreyberg/spotify-chart-data 
 Popularity of Spotify top tracks by genre. Kaggle. (n.d.). Retrieved October 30, 2022, from https://www.kaggle.com/datasets/thedevastator/popularity-of-spotify-top-tracks-by-genre 
MaharshiPandya. (2022, October 22). 🎹 spotify tracks dataset. Kaggle. Retrieved October 30, 2022, from https://www.kaggle.com/datasets/maharshipandya/-spotify-tracks-dataset 
 **(4)** The main data set (Spotify tracks chart dataset (2014-2022) comes from Kaggle, and it was created by Julian Freyberg. The dataset was created in 2014, and it was last updated about 10 days ago by Freyberg. The purpose for collecting the data is to collect information from Spotify from many different countries. The information allows for the viewers to see which songs had the most streams. Freyberg most likely funded and benefited from the data, since he got credibility from it. Additionally, Spotify also benefits from the data, since the database revolves around it. People who have interest in listening to a song from the dataset, created more popularity for Spotify; thus, the data can be seen as a marketing tool. To add on, the data is collected weekly directly from Spotify, which indicates that it is validated and held secure. Freyberg collected data directly from https://kworb.net/spotify/. The data is also credible and trustworthy since the author has created datasets before. The place where the data comes from also causes it to be trustworthy since it was not altered. We obtained this data by searching through the data science tool, Kaggle. 
 |
|Expected Implications | Technologists: In the future, technologists can utilize what we have to create unique, user-oriented projects across a wide range of fields. We envision our project to be applicable to a wide range of fields, including music, real estate, food delivery, the automobile market, and many others.
A designer's main objective is to create unique visual representations that help customers understand their needs. Our website allows designers to better understand what their clients need by accessing it. Furthermore, designers are capable of developing efficient solutions that satisfy clients' requirements and, most importantly, create visuals that are unique and personal for clients.
Policymakers can better understand people's needs by evaluating the data our program provides and, based on those needs, modify regulations to meet those needs. By using our project, policymakers can better understand people's needs and eventually develop a more equalized social environment. |
|Limitations | Proposal only. What limitations might you need to address? Briefly discuss. (About 150 words.) |
|_Findings_ | _Not for the project proposal; for final report only. Give answers to each of your research questions. (About 400 words.)_ |
|_Discussion_ | _Not for the project proposal; for final report only. Discuss importance and/or implications of your findings  (About 400 words.)_ |
|_Conclusion_ | _Not for the project proposal; for final report only. Give the reader a summary point, the key point that you will like your audience to leave with. (About 400 words.)_ |
|Acknowledgements | Is there anyone you would like to thank? A librarian who helped you with your research? A Teaching Assistant? A friend who helped you find your data? Say thank you in this section.|
|References | Include your three or more research citations here. Also, include citations to your data files. Please use a standard citation style of your choice.  See [Citing Sources](https://guides.lib.uw.edu/research/citations) at the UW Library. |
|Appendix A: Questions| Do you have questions for your TA or instructor?  Include them here.|