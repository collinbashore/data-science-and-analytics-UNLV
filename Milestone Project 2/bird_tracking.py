######## Milestone Project 2: Traveler Profiles for Bird Watchers ########

# Python libraries used for this project
import pandas as pd
import numpy as np
import plotly.express as px
from sqlalchemy.engine import create_engine

## PART 1: Writing SQL queries 

# Created an engine to access the "milestone_project2" database on MySQL
engine = create_engine("mysql+mysqlconnector://root:password@localhost:3306/milestone_project2")

# Reading the first five observations of the city_weather table
city_weather = pd.read_sql('SELECT * FROM city_weather LIMIT 5', engine)
city_weather.head()

# Reading the first five observations of the bird_data table
bird_data = pd.read_sql('SELECT * FROM bird_data LIMIT 5', engine)
bird_data.head()

# Joining the bird_data (left table) and the city_weather (right table) tables
join_data = pd.read_sql("SELECT bird.*, city.avg_temp FROM bird_data AS bird LEFT JOIN city_weather AS city ON bird.date = city.DATE AND bird.nearest_city = city.CITY ORDER BY bird.id", engine)
join_data.drop(['date'], axis = 1, inplace = True) # Removes the "date" column
join_data

# Saving the joined data as a csv file
join_data.to_csv('bird_tracking.csv', index = False)

# NOTE: Setting index=False ensures that the index column is not treated as a 
# new column in the newly saved csv file.

## PART 2: Data Wrangling and Exploratory Data Analysis (EDA)
birds_df = pd.read_csv('bird_tracking.csv')

birds_df.isnull().sum() # Calculates the number of missing cells in each column
birds_df.dropna(inplace = True) # Drops any records with missing data
birds_df.duplicated().sum() # Checks for duplicated rows (there are 69 duplicated rows)
birds_df.drop_duplicates() # Drops any rows with duplicated records

# Function for plotting multiple histograms
def plot_hists(dataframe, column_name): 
    '''
    This function plots a histogram for any feature from the dataframe of interest (which is the birds_df dataframe)
    
    Inputs:
    - dataframe: The pandas dataframe used to plot the histograms
    - column_name: This input accepts a string that matches any of the features in the dataframe
    '''
    df = dataframe
    fig = px.histogram(df, x = column_name)
    fig.show()

plot_hists(birds_df, "avg_temp") # Plots a histogram for the "avg_temp" feature
plot_hists(birds_df, "altitude") # Plots a histogram for the "altitude" feature
plot_hists(birds_df, "speed_2d") # Plots a histogram of the "speede_2d" feature

# From the histogram plots above, the minimum temperature is truly an outlier
# The row containing an outlier in the avg_temp column is dropped using "avg_temp > 40"
birds_df = birds_df[birds_df['avg_temp'] > 40]

# EDA for Categorical Features

print(birds_df[['bird_name']].value_counts())
# Output: Nico: 3355, Sanne: 3313, Eric: 3203

birds_df[['nearest_city']].value_counts() # Most observations in the dataset were nearest to the city of Dakar

# Created a new dataframe to calculate the average temperature for each country
new_df = birds_df[['country','avg_temp']]
new_df.groupby('country').mean().sort_values(['avg_temp'], ascending = True)

# Dropping and renaming column(s) that are not needed to create dashboards for each traveler profile
birds_df.drop(['device_info_serial', 'direction', 'nearest_city'], axis = 1, inplace = True)
birds_df.rename(columns = {'speed_2d': 'speed'}, inplace = True)

# Saving the cleaned dataframe as an Excel file
birds_df.to_excel('bird_data_clean.xlsx', index = False)