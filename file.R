#install the packages

install.packages("gganimate")

devtools::install_github("gganimate")

#load the packages

library(ggplot2)
library(gganimate)
library(gapminder)
library(gifski)

#load the dataset

df<-data.frame(read.csv(".../Animated plots in R/time-series-19-covid-combined.csv"))
df<-df[which(df$Country.Region=="India"|df$Country.Region=="China"|df$Country.Region=="US"|df$Country.Region=="United Kingdom"
             |df$Country.Region=="Italy"|df$Country.Region=="South Africa"|df$Country.Region=="Pakistan"|df$Country.Region=="Germany"
             |df$Country.Region=="Russia"|df$Country.Region=="Brazil"),]
rownames(df)<-NULL
df<-df[-c(which(df$Country.Region=="China"|df$Country.Region=="United Kingdom")),]


staticplot = ggplot(df, aes(x = Country.Region, y = Confirmed, 
                                       fill = as.factor(Country.Region), color = as.factor(Country.Region))) +
  geom_bar(stat="identity") +
  geom_text(aes(y = 0, label = paste(Country.Region, " ")), vjust = 0.2, hjust = 1) +
  geom_text(aes(y=Confirmed,label = as.character(Confirmed), hjust=0)) +
  
  coord_flip(clip = "off", expand = FALSE) +
  geom_text(aes(x=-Inf,y=Inf,vjust = 0, hjust = 1, label=paste0(format(as.Date(Date),"%d'%b%y"))), family='Quicksand Light', size=8, color = 'gray45')+ 
  scale_y_continuous(labels = scales::comma) +
  guides(color = FALSE, fill = FALSE) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.x = element_line( size=.1, color="grey" ),
        panel.grid.minor.x = element_line( size=.1, color="grey" ),
        plot.title=element_text(size=25, hjust=0.5, face="bold", colour="grey", vjust=-1),
        plot.subtitle=element_text(size=18, hjust=0.5, face="italic", color="grey"),
        plot.caption =element_text(size=8, hjust=0.5, face="italic", color="grey"),
        plot.background=element_blank(),
        plot.margin = margin(2,2, 2, 4, "cm")) +
  labs(title = 'Covid-19 Confirmed Cases',
       subtitle = 'Animations in R',
       x = '',
       y = '')+
  transition_states(Date)+
  ease_aes('cubic-in-out')
animate(staticplot, fps = 15, duration = 30,end_pause = 20,renderer=gifski_renderer("covid.gif")) 


