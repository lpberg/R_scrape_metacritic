library('rvest')
library('plotly')
library('dplyr')
#Reading the HTML code from the metacritic website
webpage <- read_html('https://www.metacritic.com/game/playstation-4/red-dead-redemption-2/critic-reviews')
#Using CSS selectors to scrap the data 
score_data <- as.numeric(html_text(html_nodes(webpage,'.tabs+ .critic_reviews .indiv')))
source_data <- html_text(html_nodes(webpage,'.tabs+ .critic_reviews .source .external'))
#create dataframe
df = data.frame(source = source_data, scores = score_data)
#change scource to factors sorted by score (for plotly)
df$source <- factor(df$source, levels = unique(df$source)[order(df$scores, decreasing = TRUE)])
#create plotly viz
p <- plot_ly(x = df$scores,
             y = df$source, 
             text = df$scores, 
             textposition = 'auto',
             type = 'bar', 
             orientation = 'h', 
             textfont = list(color = '#FFFFFF'),
             height = 1500) %>% layout(margin = list(l = 160))
p
