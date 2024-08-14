# Part II Hands-On with Public Data Sets

## Analysis of Transportation Public Financial Statistics

### 2.1.1 Brief Introduction

The Transportation Public Financial Statistics dataset provides detailed information on transportation-related revenues and expenditures across different levels of government (federal, state, and local) and various modes of transportation. (Bureau of Transportation Statistics 2024)

Now let's take a look at the structure of this dataset. Firstly, it contains 1884 entries with each row representing a unique financial record. Secondly, it comprises 13 columns including:

- **cash_flow**: Indicates whether the entry is related to revenue or expenditure.
- **own_supporting user_other trust_fund**: Categories describing the source and type of funds.
- **exp_type**: Type of expenditure.
- **gov_level**: Government level (Federal, State, Local).
- **description**: Description of the financial activity.
- **year**: Year of the financial record.
- **value**: Actual financial value.
- **mode**: Mode of transportation (General, specific transportation types).
- **chained_value**: Adjusted financial value accounting for inflation.
- **estimate_actual**: Whether the value is an estimate or actual.
- **deflator**: Deflator value used for adjusting the financial value.

### Objective of the Dataset

The main objective of this dataset is to provide comprehensive insights into the financial operations related to transportation infrastructure and services across various governmental levels and transportation modes. This data is essential for understanding funding sources, expenditure patterns, and the financial impact of transportation policies.

### Exploratory Data Analysis

#### Basic Summary

The dataset covers the years from 2010 to 2022 with financial values ranging from -23.1 million to 92.05 billion. Adjusted for inflation, the chained values range from -19.91 million to 86.29 billion utilizing deflator values that range from 86.838 to 129.519.

#### Simple Analysis
![image](https://github.com/user-attachments/assets/6e08fcbd-558e-4a99-95fb-06840c73c07a)

Based on the dataset, it can be inferred that there has been a steady increase in transportation-related financial allocations over the years. This trend likely reflects ongoing investments in infrastructure and services. The data indicates a period of stable transportation funding from 2010 to 2019 followed by a dramatic increase starting in 2020. The sharp rise in 2021 and 2022 suggests a significant boost in funding potentially due to pandemic-related economic recovery efforts and new policy initiatives aimed at enhancing transportation infrastructure. These increases are likely driven by new infrastructure projects, increased government funding, or responses to economic and social factors such as the need for improved public transportation systems or economic recovery efforts after COVID-19.

The observed trends highlight a stable period of transportation funding from 2010 to 2019, with a notable surge beginning in 2020 and continuing through 2022. This significant rise indicates substantial investments in transportation, reflecting both the economic impacts of COVID-19 and strategic policy decisions to enhance infrastructure and support economic recovery.

#### General Guess

Based on the dataset, it can be inferred that there has been a steady increase in transportation-related financial allocations over the years. This trend likely reflects ongoing investments in infrastructure and services. The sharp rise in 2021 and 2022 suggests a significant boost in funding potentially due to pandemic-related economic recovery efforts and new policy initiatives aimed at enhancing transportation infrastructure.

## Analysis of Electric Vehicle Population Data

### 2.2.1 Brief Introduction

The Electric Vehicle Population Data dataset provides detailed information on the population of electric vehicles in various regions. This dataset can be used to understand the distribution, growth, and characteristics of electric vehicles over time. (Bureau of Transportation Statistics n.d.)

Let's take a look at the structure of this dataset. It contains numerous entries, each row representing a unique electric vehicle record. It comprises several columns including:

- **VIN (1-10)**: The first 10 characters of the Vehicle Identification Number.
- **County**: The county where the vehicle is registered.
- **City**: The city where the vehicle is registered.
- **State**: The state where the vehicle is registered.
- **Postal Code**: The postal code where the vehicle is registered.
- **Model Year**: The year of the vehicle model.
- **Make**: The manufacturer of the vehicle.
- **Model**: The model of the vehicle.
- **Electric Vehicle Type**: The type of electric vehicle (e.g., Battery Electric Vehicle, Plug-in Hybrid Electric Vehicle).
- **CAFV Eligibility**: Clean Alternative Fuel Vehicle (CAFV) eligibility status.
- **Electric Range**: The range of the electric vehicle on a single charge.
- **Base MSRP**: The Manufacturer's Suggested Retail Price (MSRP) of the vehicle.
- **Legislative District**: The legislative district where the vehicle is registered.
- **DOL Vehicle ID**: The Department of Licensing vehicle ID.
- **Vehicle Location**: The location (latitude and longitude) of the vehicle.

### Objective of the Dataset

The main objective of this dataset is to provide comprehensive insights into the population and distribution of electric vehicles across different regions. This data is essential for understanding the adoption patterns of electric vehicles, identifying areas with high EV concentrations, and informing policies related to transportation and environmental sustainability.

### Exploratory Data Analysis

#### Basic Summary

The dataset covers various years with vehicle model years ranging from early 2000s to recent years. It includes information on different types of electric vehicles, their range, and their geographic distribution.

#### Simple Analysis
![image](https://github.com/user-attachments/assets/727bc71a-3bb6-4449-a63f-28cad1929d8d)

The bar charts for the top 10 electric vehicle makes and models highlight Tesla's clear dominance in the market. Tesla not only leads in overall make with a substantial margin but also has multiple models (Model S, Model 3, Model X, and Model Y) among the top 10. This indicates strong brand presence and consumer preference for Tesla vehicles. Other manufacturers like Nissan, Chevrolet, BMW, and Ford also appear in the top 10, showing that established car makers are successfully competing in the EV market. The diversity of manufacturers and models suggests a competitive market with a variety of consumer choices.

#### General Guess

Tesla's strong performance in both make and model categories underscores its effective market strategies and product appeal. The presence of multiple Tesla models in the top 10 highlights the company's success in catering to different segments. Meanwhile, the inclusion of vehicles from other established manufacturers shows their growing foothold in the EV market. Overall, the diversity in top makes and models reflects a robust and competitive market offering consumers a wide range of electric vehicle options.
