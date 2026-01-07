#R Packages will be used:-
library("dplyr") #For Data Wrangling
library("sqldf") #For running SQL Statements
library("tidyverse") #For loading and manipulating data, visualizing data etc.
library("faux") #For Simulating new Variables
library("DataExplorer") #For Exploratory data analysis
# For Implementing RFE for Feature Selection:
library("caret") 
library("randomForest")
library("caTools")
library("yardstick")
library("ggplot2")

#Importing Data Set:-
Matchteamstats<-read.csv("C:/Users/ankit/OneDrive/Documents/Master's Lectures and Notes/Intro to Data Science/cervus-uefa-euro-2020/Match team statistics.csv", header=TRUE)

#Viewing the data set
head(Matchteamstats)

#viewing quick summary of Match team stats
summary(Matchteamstats)

#Since StatsName is the column with the most information now we are going to perform basic data checks.

n_distinct(Matchteamstats$StatsName) # To check no. of distinct stats i.e.: 193

unique(Matchteamstats$StatsName) # To view unique stats names

# Checking any null values
sum(is.na(Matchteamstats$Value))

# Now we are going to transform the available dataset i.e.: MatchTeamStats to the required data frame 
# using SQL query and pivot_wider
Teamstats=sqldf('SELECT MatchID,TeamName,TeamID,HomeTeamName,
             AwayTeamName,StatsName,Value 
             FROM Matchteamstats ORDER BY MatchID ASC')

TeamStats1 <- pivot_wider(Teamstats, names_from = StatsName, values_from = Value) 
#used pivot_wider for using Statsnames as columns

#Adding Game Result Column
#For result we are doing binary result either 1 or 0 where 1 mean WIN and 0 means Not WIN(Loss or Draw)
TeamStats1$results = ifelse(TeamStats1$Goals > TeamStats1$`Goals conceded`, 1,0)

#Since we 193 stats we can't use all of them so we have selected related stats
#After reading related literature I have selected stats related to attack and defense.
Teamstats_final_df= select(TeamStats1,MatchID,TeamName,TeamID,HomeTeamName,
                       AwayTeamName,`Ball Possession`,`Total Attempts`,
                       `Attempts on target`,`Attempts Accuracy`,Corners,Offsides,
                       `Passes completed`,`Passes accuracy`,`Crosses attempted`,Dribbling,
                       `Total Attacks`,Assists,`Attempts on target in penalty area`,
                       `Tackles`,Saves,Clearances,`Fouls committed`,`Yellow cards`,
                       `Red cards`,`Recovered balls`,`Own-goals`,`Lost balls`,`Change of possession`,
                       Blocks,results)

#Teamstats_final_df is the final table we needed now we doing basic Data Frame checks
summary(Teamstats_final_df)

#We can observe that many of are columns coming as character although we know that value of all these
#stats is integer so we are going to change the data type of these columns.
Teamstats_final_df[, c(6:29)] <- sapply(Teamstats_final_df[, c(6:29)], as.numeric)
str(Teamstats_final_df)
summary(Teamstats_final_df)

#Replacing NA with 0 
Teamstats_final_df[is.na(Teamstats_final_df)] <- 0

#Exploratory Data Analysis
plot_intro(Teamstats_final_df)
plot_correlation(select(Teamstats_final_df,-MatchID,-TeamName,-TeamID,-HomeTeamName,-AwayTeamName))

#Feature Selection
#For feature selection we are using Recursive Feature Elimination
# Define the control using a random forest selection function
control <- rfeControl(functions = rfFuncs, # random forest
                      method = "repeatedcv", # repeated cv
                      repeats = 5, # number of repeats
                      number = 10) # number of folds

# Features
x <- Teamstats_final_df %>%
  select(-results,-MatchID,-TeamName,-TeamID,-HomeTeamName,-AwayTeamName) %>%
  as.data.frame()

# Target variable
y <- Teamstats_final_df$results

# Training: 70%; Test: 30%
set.seed(2021)

inTrain <- createDataPartition(y, p = .70, list = FALSE)[,1]

x_train <- x[ inTrain, ]
x_test  <- x[-inTrain, ]

y_train <- y[ inTrain]
y_test  <- y[-inTrain]


# Run RFE
result_rfe1 <- rfe(x = x_train, 
                   y = y_train, 
                   sizes = c(1:26),
                   rfeControl = control)

# Print the results
result_rfe1

# Print the selected features
predictors(result_rfe1)

# Print the results visually
ggplot(data = result_rfe1, metric = "Rsquared") + theme_bw()

varimp_data <- data.frame(feature = row.names(varImp(result_rfe1))[1:3],
                          importance = varImp(result_rfe1)[1:3, 1])

ggplot(data = varimp_data, 
       aes(x = reorder(feature, -importance), y = importance, fill = feature)) +
  geom_bar(stat="identity") + labs(x = "Features", y = "Variable Importance") + 
  geom_text(aes(label = round(importance, 2)), vjust=1.6, color="white", size=4) + 
  theme_bw() + theme(legend.position = "none")

# Post prediction
postResample(predict(result_rfe1, x_test), y_test)

# Logistic Regression Model with selected Features
# Splitting data into training and test sets to build and evaluate model

Final_df= select(Teamstats_final_df,MatchID,TeamName,TeamID,HomeTeamName,
                 AwayTeamName,Assists,`Attempts Accuracy`,`Attempts on target in penalty area`,
                 `Attempts on target`,`Crosses attempted`,`Ball Possession`,Tackles,
                 `Yellow cards`,Corners,results)

sample <- sample(c(TRUE, FALSE), nrow(Final_df), replace=TRUE, prob=c(0.7,0.3))
train <- Final_df[sample, ]
test <- Final_df[!sample, ]


# with all variables
model_1 <- glm(results~Assists+`Attempts Accuracy`+`Attempts on target in penalty area`+
               `Attempts on target`+`Crosses attempted`+`Ball Possession`+Tackles+
               `Yellow cards`+Corners,family="binomial",data = train)

summary(model_1)  # coefficients and standard errors
exp(coef(model_1)) # odds ratio

# Predicting on Test Data

output <- test
output$PredictedResult <- predict(model_1, newdata = output, type='response')
output$PredictedResult <- ifelse(output$PredictedResult >0.5, 1, 0)
output1 <- output[c(1:5, 15:16)]
names(output1)[6] <- "ActualResult"

# Evaluating the Model

observations <- factor(output1$ActualResult,
                       levels = c(1, 0))

predicted <- factor(output$PredictedResult,
                    levels = c(1, 0))

conf <- table(predicted, observations)
f.conf <- confusionMatrix(conf)

set.seed(123)
mat_conf <- data.frame(
  results = sample(0:1,29, replace = T),
  predicted = sample(0:1,29, replace = T)
)
mat_conf$results <- observations
mat_conf$predicted <- predicted

cm <- conf_mat(mat_conf, results, predicted)
cm
# Confusion matrix  to assess the quality of classification on a test set

autoplot(cm, type = "heatmap") +
  scale_fill_gradient(low = "firebrick1", high = "aquamarine1")

print(f.conf)
