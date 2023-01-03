# Project: [Exploratory Data Analysis (EDA) and Multivariate Regression Analysis of the Fish Market](https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Python%20Programming/EDA%20Fish%20Market%20Project/FIshMarketEDA.ipynb)

<p align = "center">
<img src = "https://images.saymedia-content.com/.image/t_share/MTc0MjMwNDUxMzIwMjY4NjY4/signs-of-stress-in-tropical-fish.jpg">
</p>

## Objectives:
* Determine how the fishes should be distributed by species and weight.
* Perform multivariate regression analysis to predict the average weight (cm) of all fish in the fish market.
* Determine the relationship between the average length (cm) and the weight (in grams) of all fish by species.

## Tools/Data used:
* The dataset can be accessed from Kaggle: [Fish Market Dataset](https://www.kaggle.com/datasets/aungpyaeap/fish-market)

**Tools:** ![Matplotlib](https://img.shields.io/badge/DS-Matplotlib-%23ffffff.svg?style=flat&logo=Matplotlib&logoColor=black&color=008080)
![NumPy](https://img.shields.io/badge/DS-numpy-%23013243.svg?style=flat&logo=numpy&logoColor=white&color=008080)
![Pandas](https://img.shields.io/badge/DS-pandas-%23150458.svg?style=flat&logo=pandas&logoColor=white&color=008080)
![Plotly](https://img.shields.io/badge/DS-Plotly-%233F4F75.svg?style=flat&logo=plotly&logoColor=white&color=008080)
![Statsmodels](https://img.shields.io/badge/DS-Statsmodels-%230C55A5.svg?style=flat&logo=scipy&logoColor=%white&color=008080)
![Seaborn](https://img.shields.io/badge/DS-Seaborn-%230C55A5.svg?style=flat&logo=seaborn&logoColor=%white&color=008080)
## Exploratory Data Analysis
<img src = "https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Python%20Programming/EDA%20Fish%20Market%20Project/fish_count.png">
<img src = 'https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Python%20Programming/EDA%20Fish%20Market%20Project/avglength_vs_weight.png'>
<img src = "https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Python%20Programming/EDA%20Fish%20Market%20Project/weight_vs_species.png">
<img src = "https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Python%20Programming/EDA%20Fish%20Market%20Project/fishcorr.png">

### Note on the Plotly Plots:

To interact with the plotly plots created in this project, you can go to the project notebook or interact with the plots
linked here individually:

* [Weight vs. Average Length](https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Python%20Programming/EDA%20Fish%20Market%20Project/avglength_vs_weight.html)
* [Height vs. Species](https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Python%20Programming/EDA%20Fish%20Market%20Project/height_vs_species.html)
* [Weight vs. Species](https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Python%20Programming/EDA%20Fish%20Market%20Project/weight_vs_species.html)
* [Width vs. Species](https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Python%20Programming/EDA%20Fish%20Market%20Project/width_vs_species.html)


## Multivariate Regression Analysis

<p align = "center">
<img src = "https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Python%20Programming/EDA%20Fish%20Market%20Project/OLS%20Regression%20Output.png">
</p>

### Notes on Regression Output:
* Since the p-value of the F-statistic of 4.95e-70 is **less than** the significance level of 0.05, the above model is assumed to be statistically significant
* 88.5% of the variation of weight can be explained by the predictor variables

## Project Conclusion:
* Based on the EDA of the fish market, it is best to decrease the Pike fish species placed in each fish tank to prevent from the fish tanks collapsing since the Pike species have the largest average length and fewer fishes that are heavier in weight.
* Bream and Whitefish fish species should also be carefully place in each of the fish tanks since their average weights are higher compared to other fish species.
* There is a strong positive association between weight and average length of all the fishes (r = 0.92).
