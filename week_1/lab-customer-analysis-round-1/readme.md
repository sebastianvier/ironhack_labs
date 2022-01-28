![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# Lab | Customer Analysis Round 1

#### Remember the process:

1. Case Study
2. Get data
3. Cleaning/Wrangling/EDA
4. Processing Data
5. Modeling
6. Validation
7. Reporting

### Abstract

The objective of this data is to understand customer demographics and buying behavior. Later during the week, we will use predictive analytics to analyze the most profitable customers and how they interact. After that, we will take targeted actions to increase profitable customer response, retention, and growth.

For this lab, we will gather the data from 3 _csv_ files that are provided in the `files_for_lab` folder. Use that data and complete the data cleaning tasks as mentioned later in the instructions.

### Instructions

1) Read the three files into python as dataframes
2) Show the DataFrame's shape.
3) Standardize header names.
4) Rearrange the columns in the dataframe as needed
5) Concatenate the three dataframes
6) Which columns are numerical?
7) Which columns are categorical?
8) Understand the meaning of all columns
9)I Perform the data cleaning operations mentioned so far in class
10) Delete the column education and the number of open complaints from the dataframe.
11) Correct the values in the column customer lifetime value. They are given as a percent, so multiply them by 100 and change `dtype` to `numerical` type.
12) Check for duplicate rows in the data and remove if any.
13) Filter out the data for customers who have an income of 0 or less.
