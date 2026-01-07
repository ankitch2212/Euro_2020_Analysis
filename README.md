Predicting Performance Variables Impacting Result in EURO 2020

Table of Contents
INTRODUCTION	
Methodology	
Sample	
Procedure	
Data Analysis	
Results and Discussion	
Conclusion	



INTRODUCTION
One of the most watched sports in the world is football. Advanced data processing techniques are being used to anticipate the results of athletic events as well as the team's strengths and weaknesses (Lago-Peas et al., 2010). Football is also affected by technology due to its quick development and teams employ data scientists to evaluate the performance of their players, opponents, and squad. In order to predict sporting results and analyse match strategy, a variety of analytical techniques are being used more frequently in sports science research (J. H. Kim & Choi, 2014).
Numerous sports organisations are looking to enhance the strategies of their teams in sports like basketball, rugby, baseball, and football, which has led to numerous studies on the correlation between match results and winning criteria. According to Hughes and Franks' (2005) research, winning teams favour play styles that emphasise ball possession. Studies have also shown that winning teams take more shots (Luhtanen et al., 1997), shots on goal (Horn et al., 2000; Low et al., 2002), and winning team has better goals per shot than losing teams (Bishovets et al., 1993; Horn et al., 2000; Delgado-Bordonau et al., 2013).
In order to comprehend team performance and the factors that contribute to victory or failure, various variables are evaluated (Lago-Penas, Lago-Ballesteros, & Rey, 2011). In studies comparing the performances of successful and unsuccessful teams, factors like the total number of shots, shots on target, penalty area entries, crosses and fouls received, crosses against, fouls committed, and the number of red and yellow cards received have also been examined. (Castellano, Casamichana, & Lago, 2012; Lago-Penas, Lago-Ballesteros, & Rey, 2011; Ruiz-Ruiz et al., 2011; Lago-Penas el at., 2010; Armatas et al., 2009; Lago-Ballesteros & Lago-Penas, 2010). 
For instance, information on sixteen performance metrics was gathered and evaluated in research by Castellano, Casamichana, & Lago (2012), Lago-Penas, Lago-Ballesteros, & Rey (2011), and Delgado-Bordonau et al. (2013). These studies showed that winning teams greatly outperformed drawing and losing teams in terms of ball possession, total shots, and shots on target. According to Castellano, Casamichana, & Lago (2012), losing teams had higher averages in comparison to winning and drawing teams for total shots, shots on target, fouls, and red cards received. In addition, losing teams received noticeably more yellow and red cards than winning teams, according to Lago-Penas, Lago-Ballesteros, & Rey's (2011) research.
In the 2010 World Cup, shots on goal and goals scored were used to compare winning and losing teams. The research showed that winning teams outperformed losing teams in all offensive performance measures, with the exception of "shots off the goal." These results support the idea that winning teams are more resilient in offence-related variables while losing teams exhibit higher averages for defence-related variables (Castellano, Casamichana, & Lago, 2012; Lago-Penas, Lago-Ballesteros, & Rey, 2011; Lago-Ballesteros & Lago Penas, 2010). Only a few studies have examined the impact of both offensive and defensive performance on match outcomes, and more study is necessary.
In this study, we are going to look at the player performance variables that make the most impact on the result of the game. From the previous study, we learn that the player performance metrics have the most potential in predicting the game result. Many teams before the game simulate the previous and upcoming game to predict the result so this study becomes important in finding out those performance variables.

Methodology
Sample
Fifty-two matches of Euro 2020 were analysed to achieve the purpose of the study. The match result was further divided into wins and not wins. Data was collected from https://data.world/cervus/uefa-euro-2020, which includes multiple files including data on Match events (e.g., Foul, free kick), general match information (e.g., time, score), match line-ups (e.g., players, bench, coach), player statistics, team statistics and pre-match information. For this study, we only used data from Team statistics as it fulfilled the purpose of the study and the following table represent variables that Match Team Statistics holds.
Table 1 - Data set information
Variables 	Description	Data Type
MatchID	Unique ID of the Match	Numeric
TeamID	Unique ID of the Team 	Numeric
HomeTeam	Home Team Name	String
AwayTeam	Away Team Name	String
TeamName	Team Name 	String
IsHomeTeam	The value resulting in Team is an Away or Home Team	String
IsAwayTeam	The value resulting in Team is an Away or Home Team	String
StatsID	Unique ID of the Stats	Numeric
StatsName	Stats Name	String
Value	Value of equivalent stats	Numeric

Procedure 
We start with pre-processing our data by checking missing values and data summary. Then we used SQL query and pivot wider to transform our dataset to the required form. As the stats name was in row format, we converted it into column format as studied in practical sessions.
We added game results to our data as it is the targeted variable for our study. Since we have 193 variables of performance stats, we have selected only twenty-four variables related to offence and defence, such as Ball Possession, Total Attempts, Attempts on target, Attempts Accuracy, Corners, Offsides, Passes completed, Passes accuracy, Crosses attempted, Dribbling, Total Attacks, Assists, Attempts on target in penalty area, Tackles, Saves, Clearances, Fouls committed, Yellow cards, Red cards, Recovered balls, Own-goals, Lost balls, Change of possession, Blocks as we studied from related literature (Lago-Penas, Lago-Ballesteros & Rey, 2011; Castellano, Casamichana & Lago, 2012; Lago-Penas, Lago-Ballesteros & Rey, 2011; Ruiz-Ruiz et a!., 2011; Lago-Penas el aI., 2010; Armatas et a!., 2009, LagoBallesteros & Lago-Penas, 2010; Hughes & Franks, 2005).
Then we pre-process our data again by replacing null values (is.na function), changing the data type of variables (sapply function), and doing exploratory data analysis by checking the correlation of variables with the target variable.

Data Analysis 
We use the feature selection technique for selecting only the most relevant and best-performing feature or variable to reduce the total number of features (Chauhan & Kaur, 2014; Kaur et al., 2012; Kaur et al., 2010; Kaur et al., 2011). We used the Recursive feature Elimination technique, resulting in 9 features (Table 1). 
Recursive Feature Elimination improves generalisation performance by removing the least important features whose deletion will have a negligible effect on training errors. Also, Recursive Feature Elimination is related to support vector machines which generalise well for small sample classifications (Chen & Jeong, 2007). RFE is a wrapper-type feature selection algorithm that searches for a subset of features by starting with all features in the training data set and ranking features by importance, discarding the least important features, and re-fitting the model, reducing model processing time and the likelihood of overfitting.
In the following analysis stage, binary logistic regression was implemented to identify the performance indicators that best predict the successful match outcome. The logistic regression analysis used the binary outcome, win versus draw and losses, as the dependent variable.
Logistic Regression is a statistical and probabilistic classification model, and it is used to predict a binary response. 
One expression of the logistic function is: 
f(x)=1/1+e−λ.
This function is helpful because it restricts the output between 0 and 1, which can be interpreted as a probability (Sánchez Gálvez et al., 2022). Where Lambda is a constant value for different values of x. In this study, the probability is referenced to the target variable as after the model the predicted values would be between 1 & 0 which also represent the probability of the result.
For this analysis, we have used the following libraries.

Table 2- Libraries for Coding
Library	Description 
dplyr	For data wrangling
Sqldf	for running SQL Statements
Tidyverse	For loading and manipulating data
Faux	For simulating new variables
dataExplorer	For exploratory data analysis
caret	For the implementation of RFE
randomForest	For Recursive feature selection
caTools	For logitBoost classifier
yardstick	For checking model performance
ggplot2	For plotting graphs

Figure 1 shows the result of data pre-processing explaining the datasets missing values and percentage of continuous and discrete variables. Figure 1 plot shows that our data set has no missing value, and our dataset has no initial complications. 
Figure 1

Results and Discussion
Figure 2 shows the correlation between the target variable, i.e., Result, versus the predictor variables, i.e., all 24 variables we selected before applying the feature selection technique.
We can observe from the image that the Result positively correlates with Assist, Attempts on target in penalty area, Attempts on target, Ball possession, and Attempts accuracy. The Result is also negatively correlated with Yellow cards, Red cards, and Foul committed. These correlation results conclude that the game Result positively correlates with offensive variables and negatively correlates with defensive variables.
One of the main observations from the previous studies is that they do univariate statistical analysis on the target versus the independent variables before applying the model. However, this resulted in limited insights into the dynamic nature of soccer performance (McGarry, 2009). Due to this, we used the Recursive feature elimination technique as its significance (Chauhan & Kaur, 2014).
Another element here is that following the same procedure used by our predecessors in their studies may result in the same observations and not be led to any new details or findings.
Hence, we used the Recursive Feature Elimination technique instead of the statical approach in our study; the Recursive Feature Elimination result can be observed in Table 1.
 
Figure 2
Recursive feature selection
Resampling performance over subset size:
Table 3
Variables	RMSE	Rsquared	MAE	RMSESD	RsquaredSD	MAESD	Selected
1	0.4293	0.3355	0.3453	0.11317	0.2702	0.10708	 
2	0.4149	0.3646	0.3201	0.10039	0.2855	0.08773	 
3	0.3707	0.4699	0.2942	0.09564	0.2896	0.08099	 
4	0.3705	0.4637	0.2976	0.08182	0.2635	0.07227	 
5	0.3768	0.4602	0.3085	0.07618	0.2344	0.06981	 
6	0.3734	0.4609	0.2983	0.07532	0.2506	0.07035	 
7	0.3699	0.4692	0.3021	0.07104	0.2288	0.06583	 
8	0.3711	0.4606	0.3085	0.07728	0.2422	0.06873	 
9	0.3663	0.4667	0.3029	0.07363	0.2275	0.06456	     *
10	0.3668	0.4804	0.3081	0.07165	0.2295	0.06347	 
11	0.371	0.4761	0.3149	0.07362	0.2310	0.06372	 
12	0.3681	0.4784	0.3108	0.07317	0.2305	0.06425	 
13	0.3689	0.4759	0.3139	0.07392	0.2368	0.06462	 
14	0.373	0.4682	0.3195	0.07091	0.2368	0.06237	 
15	0.3727	0.4645	0.3188	0.07072	0.2387	0.06206	 
16	0.3744	0.4601	0.3216	0.06982	0.2413	0.06184	 
17	0.3753	0.4670	0.3242	0.07108	0.2435	0.06192	 
18	0.3745	0.4670	0.3229	0.06686	0.2274	0.06004	 
19	0.3782	0.4575	0.3279	0.07015	0.2493	0.0617	 
20	0.3828	0.4446	0.3343	0.06933	0.2447	0.06073	 
21	0.383	0.4423	0.3331	0.06601	0.2339	0.05825	 
22	0.387	0.4293	0.3380	0.06798	0.2353	0.05981	 
23	0.3895	0.4181	0.3420	0.06347	0.2292	0.05602	 
24	0.3876	0.4251	0.3396	0.06589	0.2340	0.05921	 

Table 3 shows that the recursive feature elimination technique recommends nine features for the model (see the asterisk sign under the “Selected” column). We can observe the same results visually in the graph, i.e., figure 3. The RFE algorithm comes to the conclusion of recommending 9 features because of its property of removing features one by one and finding the most important feature based on feature importance ranking and making model faster and less overfitted.  
 
Figure 3
The blue dot in figure 3 represents the optimal solution – i.e., nine features. Still, we can also observe that the model has higher R-squared values for having features like 7 with 0.4692, 10 with 0.4804, 11 with 0.4761, 12 with 0.4784, 13 with 0.4759, 17 and 18 with 0.4670 R-squared values in comparison to selected nine features with R-squared value of 0.4667. The reason behind the RFE algorithm in recommending 9 features as its ranks the features on feature importance and priorities in improving model performance in speed and making the model less over-fitted.
Our model suggested the Nine features: 
Table 4-Features selected by RFE
Assists
Attempts Accuracy
Attempts on Target in Penalty area
Attempts on Target
Crosses Attempted
Ball Possession
Tackles
Yellow Cards
Corners
Figure 4 shows the variable importance for the selected variables, and we see which variables are most important for predicting the target variable. We can observe that Assists is the most crucial variable, followed by Attempts Accuracy and Attempts on target in penalty area. The variable importance is the value the RFE model gives to every feature and based on the ranking selects the best features for the model.
 
Figure 4
The suggested variables also can be backed by previous studies like Huges & Franks (2005) indicated that successful teams utilise Ball possession; authors also found that successful teams had a higher number of shots at goal (i.e., Attempts on target) and their effectiveness (Attempts Accuracy) was much higher than losing or drawing teams (Jones, James & Mellalieu, 2004; Lago-Penas et al., 2010).
After the recursive feature elimination technique, we applied Logistic Regression on the selected nine features with the target variable, i.e., Result.
Table 5
Coefficients	Estimate Std	Error	z value	Pr(>|z|)
(Intercept)	-22.5472	10.5951	-2.128	0.0333*
Assists	5.1255	1.9707	2.601	0.0093**
Attempts Accuracy	-0.0251	0.0435	-0.577	0.5638
Attempts on target in penalty area	2.6783	1.3776	1.944	0.0519
Attempts on target	-1.2317	0.7952	-1.549	0.1214
Crosses attempted	-0.8134	0.382	-2.129	0.0332*
Ball Possession	0.4795	0.2034	2.357	0.0184*
Tackles	0.2918	0.2749	1.061	0.2885
Yellow Cards	-1.4929	1.0486	-1.424	0.1545
Corners	0.1067	0.4034	0.265	0.7914
Significant. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
(Dispersion parameter for binomial family taken to be 1)
Below Table Represents some model values which give information about our model performance.
Table 6
Model	Value
Accuracy	0.7586
P-Value	0.2796
Sensitivity	0.5556

Table 5 and the below values represent the result of the logistic regression analysis. The model identified that Assists, Crosses attempted, and Ball possession were significant factors (P<0.05).
Table 7 represents the predicted outcome of the matches vs the game’s actual outcome. For the above values, we can observe that model has an accuracy of 75.86%.
Table 7
 	Actual Outcome
	Win	Tied or lost
Predicted Outcome	Win 	5	3
	Tied or lost	4	17

This study aimed to identify the key performance indicators that make the most impression on the game result, i.e., the team won, drew, and lost the game. Our model had an accuracy of 75.86% with Assists, Attempts Accuracy, Attempts on Target in penalty area, attempts on target, Crosses attempted, Ball possession, Tackles, Yellow cards, and Corners as features. Keeping the accuracy of the model in view, we did well. 
This study sought to discover the main performance factors that have the greatest influence on game outcome, i.e., whether the team won, drew, or lost the game. With Assists, Attempts Accuracy, Attempts on Target in Penalty Area, Attempts on Target, Crosses Attempted, Ball Possession, Tackles, Yellow Cards, and Corners as characteristics, our model had an accuracy of 75.86%. Keeping the model's accuracy in mind, we fared well. 
Our results agree with those of earlier studies in the same field. For instance, most studies indicated that teams' possession-based playing styles had a significant impact on the outcomes, and we also found in our research that ball possession is one of the important performance indicators influencing the game's result (Hughes & Franks, 2005; Hook & Hughes, 2001). Possession football, also known as "tiki-taka," is practised by a variety of teams and players, including Johan Cruyff, Louis Van Gaal, Arsene Wenger, and Pep Guardiola. Its goal is to keep possession of the ball for a longer period of time than the opposition by using numerous low-risk passes and a gradual pass and move strategy to wear down the opposition. 
Total passes and passes in the opponent's half were noted in studies by Lago-Penas and Dellal (2010) and Lago (2009) as one of the important performers in their study. Our recursive feature elimination method, however, suggests that efforts on target and attempts accuracy were the important indicators in this situation. According to several studies (Castellano, Casamichana, & Lago (2012), Lago-Penas, LagoBallesteros, & Rey (2011), Lago-Ballesteros & Lago-Penas, 2010, & Armatas et al. (2009), a team's chances of scoring goals and having an impact on the game rise the more shots they take. In every one of these investigations, more total shots were tallied for winning teams than for losing ones. 
We cannot say how important of an impact they are having on the research because we did not use statistical analysis, but we can say that it was not strongly associated with the outcome of the game. However, the logistic regression revealed that Assists was present, suggesting that it is a crucial element influencing the impact of the games. Assists, crosses that were attempted, and ball possession were all significant predictors in our logistic regression model, although they are all attacking factors. Defence-related variables including tackles, yellow cards, and corners had little to no effect on the model. The top, mid-table, and lowest teams in the Spanish league did not differ in any defence-related variable, according to a recent study by Lago-Ballesteros & Lago (2010).

Conclusion
In conclusion, the Recursive Feature Elimination technique's suggested features selected for the logistic regression model are based on importance ranking. The accuracy of our logistic model is 75.86%, which is acceptable for a model given the input data. 
The main conclusion from this study is that, out of the nine features suggested by the recursive feature reduction technique model, Assists, Crosses attempted, and Ball possession has greatly impacted the model.
The question that now arises is: Did we succeed in achieving the goal that we established at the outset of this study? which was "The performance factor that has the greatest impact on the outcome of the game." Out of the twenty-four factors that made up our final analysis, we chose from the 193 performance-related variables based on earlier research. Using the recursive feature elimination method, we then further reduced it to nine features. By evaluating the performance of the models, we can conclude that we were successful in finding performance metrics that have an impact on the outcome of the game. Assists, Attempts Accuracy, Attempts on Target in the penalty area, Attempts on Target, Crosses attempted, Ball possession, Tackles, Yellow cards, and Corners were found to have an effect on the game's outcome and to have the best model accuracy.
Every research project has flaws and restrictions, and this study is no exception. As this study has numerous limitations, we will now examine each one and offer suggestions for how they might be improved in future research. The data offered is the first significant flaw. We have a tiny database compared to studies done on League data because the Euro or European Championship is a very small competition compared to games played in domestic leagues.
The performance indicators we chose for this study need work as well, as we only determined twenty-four variables out of the 193 we had thanks to the relevant earlier studies. Does the outcome change if all 193 factors have been established? Although we cannot say, we can investigate this in our upcoming research but we are unable to find any study with this many variables.
Another area that needs work is the statistical analysis that we should have conducted in our study to check for differences that are statistically significant between each variable and the outcome. We opted to apply the recursive feature elimination method instead, even though this ultimately gave us a satisfactory outcome.
The studies from Castellano, Casamichana, & Lago (2012), Lago-Penas, LagoBallesteros, & Rey (2011), Lago-Ballesteros, & Lago-Pens (2010), & Armatas et al. (2009) provided the features related to offence and defence, but by using statistical analysis, we could have provided a stronger argument.
The binary model we choose, binary logistic regression, only compared the winning result with the non-winning result, excluding the crucial component of the game, i.e., the draw, which is the last constraint. The other model that is best suited is Multiple Logistic regression as we can use draw as one of the target variables.
As a result, there are not many studies that focus on identifying performance markers that affect game outcomes.


