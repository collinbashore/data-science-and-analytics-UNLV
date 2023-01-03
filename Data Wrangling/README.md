# Project: Howie's Hotels Evidence Data Wrangling Project

<p align = "center">
    <img src = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.pinimg.com%2Foriginals%2Ffd%2F5d%2Fd7%2Ffd5dd74c15403cc1a208b87de2464ede.jpg&f=1&nofb=1&ipt=f0968970927a97cf0c9dbfa7071df66820cd9cc416c02d70109ae48ba64f8190&ipo=images">
<p/>


[MyNews13](https://www.mynews13.com/fl/orlando/attractions/2021/01/12/baby-rhino-at-disneys-animal-kingdom-given-name) (accessed 11/28/2022)
## Project overview

Howie is currently under investigation by the FBI. It turns out he's been cooking the books, making up records for hotel stays that never happened in order to launder money from his illegal endangered baby rhino smuggling operation.

## Goal
* Use data-wrangling skills to find all falsified records in Howie's database.
* Determine how much money Howie laundered.

## Tools/Data Used
![Jupyter Notebook](https://img.shields.io/badge/Tool-Jupyter-informational?style=flat&logo=jupyter&logoColor=orange&color=008080)
![Pandas](https://img.shields.io/badge/DS-pandas-%23150458.svg?style=flat&logo=pandas&logoColor=white&color=008080)
![Seaborn](https://img.shields.io/badge/DS-Seaborn-%230C55A5.svg?style=flat&logo=seaborn&logoColor=%white&color=008080)

**Data used:** [hotel_evidence.csv](https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Data%20Wrangling/hotel_evidence.csv)

## Identifying Falsified records
Before identifying the falsified records, the indicatior variables must be labeled, as shown below:
```
# Setting up an indicator variables to identify falsified records.
hotel_evidence['is_false'] = 0  # Adds a new column "is_false" with all values equal to zero.
```
When falsifying records, the column "is_false" will then be set equal to one.

#### Record with falsified hotel booking number
According to [Benford's Law](https://en.wikipedia.org/wiki/Benford%27s_law#Definition), the leading digit is likely to be the smallest digit in a group of numbers (such as record numbers). For example, in a group of numbers (1, 2, 3, 4), 1 is the smallest digit, followed by 2, 3, and 4. Any records that do not follow this pattern are falsified. Below is the violinplot that shows the distribution of the hotel booking numbers.

<img src = "Booking Number Distribution.png">

From the volinplot above, 1000000.0 is the smallest booking number. All of the booking numbers are numbered from the smallest booking number to booking number 1119389.0. But there is an outlier of 9999999.0. So the outlier is noted as a false record shown in the code below:

```
hotel_evidence.loc[hotel_evidence['booking_number'] > 1119389, 'is_false'] = 1
```

#### Number of weeks in a year
In a typical calendar year, there are 52 weeks (sometimes 53 weeks) in one calendar year. Below is the boxplot used to identify the week numbers in the given dataset.

<img src = "Distribution of Week Number.PNG">

From the boxplot above, there seems to be a week number of 75 in the dataset. Since there cannot be a week number greater than 53, the record with the week number of 75 will be falsified.

```
hotel_evidence.loc[hotel_evidence['arrival_date_week_number'] == 75.0, 'is_false'] = 1
```

#### Checking the number of records by day of the month
From the given dataset, there seems to be a hotel booking recording on Februrary 31st. The month of Februray does not have any dates that go above the 29th day, so that record will be falsified.

```
hotel_evidence.loc[(hotel_evidence['arrival_date_month'] == 'February') & (hotel_evidence['arrival_date_day_of_month'] == 31), 'is_false'] = 1
```
#### Checking for Unaccompanied Minors
There's a possibly that some of the hotel bookings recorded include bookings where adults are not present with minors (children and babies).
The code below falsifies those records:

```
adults = hotel_evidence['adults']
children = hotel_evidence['children']
babies = hotel_evidence['babies']

hotel_evidence.loc[(adults == 0) & (children > 0) & (babies > 0), 'is_false'] = 1
```

#### Checking for unmatched hotel charges
Some hotel bookings have total charges not equal to the actual amount that should be recorded. Below is the code to check if there are any unmatched hotel charges.

```
# Re-calculated total charges by multiplying adr * (weeknight stays + weekend stays)
# Answers are rounded to two decimal places.

hotel_evidence['check'] = round(hotel_evidence['adr']* (hotel_evidence['stays_in_week_nights'] + hotel_evidence['stays_in_weekend_nights']),2)

# Rounded the total_charges variable

hotel_evidence['total_charges_rounded'] = round(hotel_evidence['total_charges'],2)

# Print the 5 records where the calculated charges don't match what is recorded in the spreadsheet
print(hotel_evidence[hotel_evidence['check'] != hotel_evidence['total_charges_rounded']])

# Identify the records 
hotel_evidence.loc[ hotel_evidence['check'] != hotel_evidence['total_charges_rounded'], ['is_false']] = 1
```
From the code above, there are a total of five hotel bookings that have unmatched hotel charges.

## Conclusion
* After all of the records had been falsified (there's a total of 11 falsified records), the total amount of money laundered is recorded below
    - **Total amount laundered:** $105,498.05