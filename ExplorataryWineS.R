---
title: 'Exploatary Data Analysis '
output:
  html_document: default
  pdf_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)

```

```{r global_options, include=FALSE}
knitr::opts_chunk$set(message=FALSE,warning=FALSE,echo=FALSE)
```


Following is an explotary data analysis of the Red wine , the quality of the Red wine is judged from 1 to 10 and consist of 11 attributes instrumental in deciding upon the quality

### Univarate Analysis and Visualization

```{r cars}
Wines <- read.csv("wineQualityReds.csv")
str(Wines)
```

The Dataset consist of the 12 varaibles and 1 Response Variable. Most of the data seems to be in numeric in nature and not categorical apart from response Variable (quality). There is a prescense of a Redudant column with the column name X which denotes the row no of the observation and we would be better of by removing that column

```{r}
Wines <- subset(Wines,select=-c(X))
summary(Wines)
```

It is always good to check out the summary to know what we are dealing it. Looking at the statistics there is definately seems to be prescense of outliers in atributes as evident by the column like total.sulfur.dioxide , free.sulfur.dioxide ,  residual.sugar , fixed.acidity where the Max and a third Quartile have a substantial difference

```{r}
summary(Wines$quality)
```

Even though the the possible rating are from 1 to 10 , wines are judged more on the scale of 3 to 8 . The Median and 3rd Quartile stood at 6 while Mean stands at about mid 5 indicating a lot of wines are judged either 5 or 6




```{r pressure, echo=FALSE}
library(ggplot2)
ggplot(aes(x=factor(quality)),data=Wines)+geom_bar()+xlab("Quality")
```

The Bar Plot Confirms our assumption that a lot of wines are rated 5 or 6 . Also the no of wines rated other than 5 or 6 are quite low in comparision. This could stand a problem for effective data exploration due to class imbalance

The attributes present in the Red wine are quite important apart from only a handful of attribute like density and ph which tells more about the chemical struture of liquid than anything . So its important to disect the attributes one by one

```{r}
ggplot(aes(x=alcohol),data=Wines)+geom_histogram(bins=40)
```

*Since The plot is Skewed we would plot it it on log 10 scale*

```{r}
ggplot(aes(x=alcohol),data=Wines)+geom_histogram(bins=40)+scale_x_log10()

```

Inspite of the log10 scale alcohol content definately seems to be positively skewed. It seems to start abrubtly at about 9 and gradually progressed down. There is also a Outlier way out on the x axis at about 15

```{r}
plot <- ggplot(aes(y=alcohol,x=factor(quality)),data=Wines)+geom_boxplot()
plot + xlab("Quality")

```


Boxplot of the alcohol content seems to be intresting. That one outlier contributed to the wine which is rated 5. Also there indeed seems to be a some positive correlation where the higher alcohol content seems to be better rated. 


```{r}
by(Wines$alcohol,Wines$quality,median)
```

Since the attribute is skewed, median seems to be the better measure for the central tendency and looking at the table indeed it seems like the Quality of wine is positively coorelated with alcohol content

```{r}
plot <- ggplot(aes(x=total.sulfur.dioxide),data=Wines)+geom_histogram(bins=40)
plot+scale_x_log10() 
```



Total Sulfur Dioxide is definately positively skewed and only by looking at the log10 scale we were able to analyze few things. Most of the data is concentrated around in the range of 10 to 100  

```{r}
plot <- ggplot(aes(y=total.sulfur.dioxide,x=factor(quality)),data=Wines)
plot+geom_boxplot()
```


The Boxplot dosent tell us much about how the total surface dioxide influences the Quality. There are definaltely outliers the most striking which have contributed to Wine rated 7 which i beleive is due to error due to human observation or something similar

```{r}
plot <- ggplot(aes(x=free.sulfur.dioxide),data=Wines)+geom_histogram(bins=40)
plot 
```

*Since The plot is Skewed we would plot it it on log 10 scale*

```{r}
plot+ scale_x_log10()
```

Just like every feature analyzed uptill now free sulfur dioxide also looks like a standard Positively skewed graph with the bulk of values occuring in the range of 0 to 15

Looking at the log 10 scale there definately seems to be an interesting observation marked close at a 1
```{r}
plot <- ggplot(aes(y=free.sulfur.dioxide,x=factor(quality)),data=Wines)
plot + geom_boxplot()+xlab("Quality")
```

Nothing Intresting from the boxplot, total.surfur.dioxide and free.sulfur.dioxide dosent seems to have much say regarding the final quality of wine

That one oultlier which are at low 0 seems to have conntributed to wine quality rated 6


```{r}
plot <- ggplot(aes(x=chlorides),data=Wines)+geom_histogram(bins=40)
plot
```

*Since The plot is Skewed we would plot it it on log 10 scale*
```{r}
plot+scale_x_log10()
```


Chlorides determines the amount of salt in the wines and unlike others it seems to have a standard bell configuration with the bulk of chlorides stands at about 0.10. The original plot might have tricked everyone that the data is positively skewed but it is only due to outliers that the axis seems to have shifted a little bit . Plotting on log 10 scale , the bell shaped configuratuon is easily visible


```{r}
plot <- ggplot(aes(x=residual.sugar),data=Wines)+geom_histogram(bins=40)
plot
```

*Since The plot is Skewed we would plot it it on log 10 scale*

```{r}
plot+scale_x_log10()
```


Residual sugar denotes amount of sugar remaining after fermentation stops and too much of a sugar makes the wine sweet

Looking at histogram i would argue that plot is bell distributed. There is indeed a lot of values which aren't in the bulk area but they are few and spread out. The boxplot might be able to give out a clear picture
```{r}
plot <- ggplot(aes(y=residual.sugar,x=factor(quality)),data=Wines)+geom_boxplot()
plot + xlab("Quality")
```

Nope There are lot of Outliers particulary in the Wine quality rated 6. Most of the box plot are in the same range and  Needlessly to say residual sugar is very bad attribute to test the dependency on Wine quality. We might as well as drop the attribute for the further exploration

```{r}
ggplot(aes(x=citric.acid),data=Wines)+geom_histogram(bins=40)
```


Citric Acid is responsible for adding freshness and flavour to the Wine. Looking at histogram most of the citric acid is found at low quantity and from there there are no of wines which have almost the same amount of citric acid up to till 0.50. The attribute is definately positively skewed

Interestingly there is one outlier having a citric acid quantity of about 1.0. i wonder what that point would be

```{r}
plot <- ggplot(aes(y=citric.acid,x=factor(quality)),data=Wines)+geom_boxplot()
plot + xlab("Quality")

by(Wines$citric.acid,Wines$quality,median)
```

Box plot is Intresting enough . It looks like higher the amount of citric acid higher is the quality of wine . While it isn't clear how much of the citric acid is affecting the quality but its safe to assume that citric acid is positively coorelated with the quality of wine particularly when looking at the boxplot of wine qualiity rated 4 and 8


Median seems to be confirming our assumption . There is a substantial difference in the median value of the citric acid for the wine quality rated 7 and 8 versus the wine quality rated 5 and 6

```{r}
ggplot(aes(x=volatile.acidity),data=Wines)+geom_histogram(bins=40)
```


Volatile.acid determines the amount of acetic acid in wine and looking at the histogram its unlikely we will found many surprises. It is a bell distribution curve with bulk of the wines having the volatile acidity in The range of 0.4 to 0.8



**NOTE- Intution says the fixed.acidity and sulphates might not tell very much about the quality of wine. The sulphates is added as an antioxidant and antimicrobial while fixed acidity keeps a check on the Acid and for that reason i m not exploring these attributes**


#### Univarate Analysis Reflection

The dataset in the general is number heavy and seems to positvely skewed as a whole. There are some intresting attributes which might seem promising like alcohol content and citric acid which might shed some light on the quality of wine . In the final note there are lot of outliers in a lot no of attributes which so far exceed the ordinary but other than dosent effect the quality of wine in general which is strange to say

### Bivarate and Multivarate Analysis and Visualization

```{r}
ggplot(aes(x=alcohol,y=citric.acid),data=Wines)+geom_point(alpha=0.2)
```

Our Promising attribute citric.acid and alcohol dosent seems to have any kind of relationship whatsoever and there are basically independent to each other 

But our Analysis showed the higher the alchol content and higher the citric acid is related to the better quality of wind. Let's Explore Further

```{r}
plot <- ggplot(aes(x=alcohol,y=citric.acid),data=Wines)+geom_point(alpha=0.2)
plot + facet_wrap(~quality)+scale_x_log10()

```

By Facet wrap it looks like combined higher content of alchol content and citric acid might lead to better Quality of wine . The assumption can be seen if we see the plot for the wine quality rated 5 vs the wine quality rated 7 or 8


```{r}
plot <- ggplot(aes(x=volatile.acidity,y=alcohol),data=Wines)
plot + geom_point(alpha=0.3)+ scale_x_log10()+xlab("Attribute Scaled to Log10") 
```


It is interesting to look at how the alcohol content varies with the volatile acidity and looking at the scatterplot it dosent seems to have any relationship and fairly uncorrelated


```{r}
plot <- ggplot(aes(x=volatile.acidity,y=alcohol),data=Wines)
plot + geom_point(aes(color=factor(quality)),alpha=0.3)+scale_x_log10()
```

Labelling the points by color tells nothing with the wine rated higher quality is intermixed in the cluster with the lower quality wine

```{r}
ggplot(aes(x=volatile.acidity,y=citric.acid),data=Wines)+geom_point(alpha=0.3)
```

The amount of acetic acid in wine and citric acid seems to negatively correlated . It will be interesting to see what it will tell us  about quality of wine

```{r}
plot <- ggplot(aes(x=volatile.acidity,y=citric.acid),data=Wines)+geom_point(alpha=0.3)
plot + facet_wrap(~quality)
```


Generally lower quantity of volatile acidity is preferred along with the substantially higher quantity of citric acid in comparison for the Better quality of wine. But it seems to be standard for a lot of wines in general and not exclusive to wine rated 7 or 8

```{r}
library(corrplot)
cor(Wines) -> Correlation
corrplot(Correlation,method="color")
```


Having Reached the dead end its worthwile to look at the Correlation plot to how could we procced. Most of the strong correlations seems to be obvious for instance like how the amount of fixed acidity influences the citric acid quantity or volatile acid quantity and most obvious of them is how fixed acid quantity influences the Ph and therfore its no surprises here to see PH strongly coorelates with the amount of fixed acid quantity. The Quality of wine dosent strongly correlates with  anyone exccept alchohol quantity. Surprisingly there is indeed some form of relationshop between volatile acidity and quality which we didn't explored in previous section

```{r}
plot <- ggplot(aes(y=volatile.acidity,x=factor(quality)),data=Wines)
plot  +geom_boxplot()+xlab("Quality")
```


Intresting there seems to be some form of relationship where the lower quality of volatile acidity(citric acid) does seems to have a better quality wine.

Having already drawn the all possible scatterplot of promising attributes , lets facet wrap the alcohol content with the volatile acidity

```{r}
plot <- ggplot(aes(x=volatile.acidity,y=alcohol),data=Wines)
plot +geom_point(aes(color=factor(quality)),alpha=0.3)+facet_wrap(~quality)
```


Intrestingly  a trend could be seen where the higher quality of alchohol and low quantity of volatile acidity seems to have a better quality wine. Lets cleanse the visualization a little bit by dropping the clustered points and by fitting the line to confirm hypothesis

```{r}
plot <- ggplot(aes(x=volatile.acidity,y=alcohol),data=Wines)
plot <- plot
plot+geom_smooth(method="lm",aes(color=factor(quality)))+scale_x_log10()
```

Here a trend could easily be observed where higher quality of alcohol with respect to volatile acidity is considered highly favourable (aka positive slope). The graph is consistent with the above plot where our dataset in which highly rated wine generally have a low volatile acidity and high alcohol content



Lets summarise all the interesting and promising endpoints we have into one final plot

```{r}
library(dplyr)
library(gridExtra)
group_by(Wines,quality) -> grp



summarise(grp,volatile_Acidity=median(volatile.acidity),Alcohol=median(alcohol)
          ,citric_Acid=median(citric.acid))->Summarise

#---------------------------------------------------------------#
p1 <-ggplot(aes(x=quality,y=volatile_Acidity,group=1),data=Summarise)
p1 <- p1+ geom_point(shape=8)+geom_line(linetype="dotdash",color="red")

p2 <- ggplot(aes(x=quality,y=Alcohol,group=1),data=Summarise)
p2 <- p2 +geom_point(shape=8)+geom_line(linetype="dotdash",color="red")

p3 <- ggplot(aes(x=quality,y=citric_Acid,group=1),data=Summarise)
p3 <- p3 +geom_point(shape=8)+geom_line(linetype="dotdash",color="red")

Combined<- grid.arrange(p1,p2,p3)
#print(Combined)

```

The Final Plot definately shows how volatile acidity is preferred lower for quality while citric acid and alchohol content is preferred higher for good quality wine


### Final Points and Plot

```{r}
corrplot(Correlation,method="color",
         title = "Correlation Plot", type="upper",  mar=c(0,0,1,0))
```

The Correlation plot shows the correlation between the features. The quality of the Wine dataset is isn't strong correlated with any of the features except for maybe a coulpe of attributes like  volatile.acidity, alcohol and citric acid

```{r}
p1 <-ggplot(aes(x=quality,y=volatile_Acidity,group=1),data=Summarise)
p1 <- p1+ geom_point(shape=8)+geom_line(linetype="dotdash",color="red")
p1 <- p1+ggtitle("The amount of acetic acid (g / dm^3) in wine")
p1 <- p1 + theme(plot.title = element_text(hjust = 0.5))
p1 <- p1+xlab("Wine Quality Ratings")+ylab("Volatile Acidity")

p2 <- ggplot(aes(x=quality,y=Alcohol,group=1),data=Summarise)
p2 <- p2 +geom_point(shape=8)+geom_line(linetype="dotdash",color="red")
p2<- p2+ ggtitle("Percent alcohol content(% by volume) of the wine")
p2 <- p2 + theme(plot.title = element_text(hjust = 0.5))
p2 <- p2+xlab("Wine Quality Ratings")+ylab("Alcohol Amount")

p3 <- ggplot(aes(x=quality,y=citric_Acid,group=1),data=Summarise)
p3 <- p3 +geom_point(shape=8)+geom_line(linetype="dotdash",color="red")
p3 <- p3+ggtitle("Amount of citric acid (g / dm^3)  in wine")
p3 <- p3 + theme(plot.title = element_text(hjust = 0.5))
p3 <- p3+xlab("Wine Quality Ratings")+ylab("Citric Acid Amount")

Combined<- grid.arrange(p1,p2,p3)
```

The effect of the attributes on the quality of wine which showed the strongest correlation with it 

```{r}
plot <- ggplot(aes(x=factor(quality)),data=Wines)+geom_bar(fill="red",
                                                           color="black")
plot <- plot + xlab("Wine Quality Ratings")+ylab("Total Count")
plot <- plot+ggtitle("No of Wines Rated by Quality")
plot+theme(plot.title = element_text(hjust = 0.5))
```

The difference of the Response variables where the no of wine rated 5 or 6 far exceeds that of the other variable 

### Reflection 

The dataset consist of the contents and ingrediants of the wine and the rating it got . Much of the attribute was found to have no relation to quality of wine and there are many no of erroneus outliers which brings in to somewhat confusion. In addition the, class imbalance problem also lead to problems in effective data Visualization leading to lot of dead end . Also there was also not a great relationship between the attributes. In the end we were finally able to zero in to about two or three attributes which showed some kind of relationship with the quality. Bottom line: high amount of alcohol  , high amount of citric acid and low amount of volatile acidity is generally considered as most probale way to make a good wine

Regarding my final thoughts i would say that while there has indeed been a large no of attributes present to analyze the factors contributing to quality of wine, not much was of any use because the dataset suffers from the class imbalance problem. There was too much of wine rated 5 or 6 in comparision to wines rated Higher or lower . The range through which wine was rated was put to Little benefit and i would say wine quality should have graded on the scale of 5 instead of 10 for effective Analyzing. Also some attributes present in the dataset made little sense  for analyzing quality of wine and could have been replaced more by the attributes that could have told something regarding the quality of Wine, For instance the ph and density attribute should have been completly dropped and instead be replaced like the grape juice concentrate (one of the major ingredients of Wine)
