# Part III In-depth Analysis

## 3.1 Introduction

I've downloaded the dataset named “Darknet.csv” on Kaggle. This dataset contains network traffic data captured from various sources including both normal and attack traffic (Friedrich 2020). It includes several features related to network flow characteristics such as flow duration, total packets in forward and backward directions, packet length statistics, idle times, and more. The goal of this analysis is to explore the dataset, visualize the relationships between different features, and build regression models to predict network flow durations.

## 3.2 Analysis Process

### 3.2.1 Data Loading and Preprocessing

The dataset was loaded into R, and initial preprocessing steps included handling missing values, encoding categorical variables if any, and normalizing numerical features for better model performance.

### 3.2.2 Data Cleaning

1. **Handling Missing Values**
   - I removed rows with missing values to ensure the dataset only contains complete records. This step is crucial for reliable analysis and model training.

2. **Ensuring All Columns are Numeric**
   - I converted all factor-type columns to numeric. This ensures a consistent data format, making it easier to perform mathematical operations and apply machine learning algorithms.

3. **Standardizing Numeric Columns and Removing Zero Variance Columns**
   - I scaled numerical features to have a mean of zero and a standard deviation of one. I also removed columns with zero variance as they do not provide useful information. This step improves the performance of many machine learning algorithms.

4. **Combining Standardized Numeric Columns with Categorical Data**
   - I combined the standardized numeric data with any remaining categorical data. This creates a cohesive dataset that is ready for further analysis, visualization, and model training.
![image](https://github.com/user-attachments/assets/409df645-ac22-4fb9-9623-37994701244c)

### 3.2.3 Correlation Analysis

I selected some representative items for analysis. A correlation matrix was created to understand the relationships between different numerical features in the dataset.

**Findings:**
- The correlation matrix shows the relationships between different features in the dataset. Darker colors represent stronger correlations. From this matrix, we can infer that features like `Total.Fwd.Packet` and `Total.Bwd.packets` are strongly correlated with `Flow.Duration`. This suggests that the number of packets in forward and backward directions significantly affects the flow duration.

### 3.2.4 Data Visualization

Several visualizations were created to understand the distribution and relationships of the key features.

- **Distribution of Flow Duration**
![image](https://github.com/user-attachments/assets/8150cafb-3e8e-4f29-8387-3fcc47dd34ee)

  **Findings:**
  - This histogram shows the distribution of flow durations in the dataset, indicating that most flows have short durations. The distribution is heavily skewed towards shorter durations, which is typical in network traffic data where most connections are short-lived.

- **Boxplot of Flow Duration by Label**
![image](https://github.com/user-attachments/assets/2b57214d-00a1-4fc8-881c-3245cb0f5ed2)

  **Findings:**
  - A boxplot of flow duration by label illustrates the distribution of flow durations across different labels. This plot helps in understanding the variation of flow durations with respect to different categories. It indicates that certain labels have more variability in flow durations, suggesting different types of network activities associated with these labels.

- **Scatter Plot of Flow Duration vs Total Forward Packets**
![image](https://github.com/user-attachments/assets/7faf7d19-7d19-435e-90e1-40a6a8b727f1)

  **Findings:**
  - The scatter plot of flow duration vs total forward packets shows the relationship between flow duration and total forward packets. It appears there is some clustering indicating potential relationships. The plot suggests that higher numbers of forward packets are associated with longer flow durations.

- **Count of Categories in Label**
![image](https://github.com/user-attachments/assets/adca5384-2800-4814-b0b7-2a66d858bb14)

  **Findings:**
  - This bar plot shows the distribution of different labels in the dataset, indicating class imbalances. This helps in identifying which categories are overrepresented or underrepresented in the data.

### 3.2.5 Model Building

I used the column of `Flow.Duration` as the target variable to predict using various features in the dataset. Two regression models were built: Linear Regression and Random Forest Regression.

- **Linear Regression Model**

  **Model Summary:**
![image](https://github.com/user-attachments/assets/1475e356-776c-4cf5-81df-8eb9d6e77d9a)

  **Findings:**
  - The summary for the linear regression model shows the coefficients, standard errors, t-values, and p-values for each feature. The model has a high R-squared value, indicating a good fit to the data. Significant predictors include `Total.Fwd.Packet`, `Total.Bwd.packets`, and various packet length statistics. This suggests that these features are crucial in determining flow duration. However, some residual patterns indicate that the model may not fully capture all the relationships in the data.

  - **Residual Plot:**
![image](https://github.com/user-attachments/assets/851e3013-bcc1-4a98-bce3-56227d64eb49)

    **Findings:**
    - The residual plot for the linear regression model shows the residuals spread across the predicted values. There are discernible patterns in the residuals indicating that the model might not be fully capturing the complexity of the data. This suggests that while the linear regression model provides a good fit, it may miss some nuances in the dataset.

- **Random Forest Regression Model**
![image](https://github.com/user-attachments/assets/71450bc9-e843-4ca4-a0e1-c893f0141fff)

  **Model Summary:**

  **Findings:**
  - The summary for the random forest regression model shows the mean of squared residuals and the percentage of variance explained. The model has a very low mean squared residual and explains 99.99% of the variance, indicating excellent performance. This model captures the complexities in the dataset more effectively than the linear regression model.

  - **Residual Plot:**
![image](https://github.com/user-attachments/assets/d2ec61cb-e73f-4bec-96ae-695545980c26)

    **Findings:**
    - The residual plot for the random forest regression model shows the residuals spread across the predicted values. The residuals are more randomly distributed compared to the linear regression model, indicating a better fit. This randomness suggests that the random forest model is more accurate in capturing the underlying patterns in the data.

- **Comparison of Residuals**
![image](https://github.com/user-attachments/assets/064f1f88-ef60-47c2-8a7b-c79aeccb06f6)

  **Findings:**
  - The scatter plot compares the residuals of the random forest and linear regression models, showing the relationship between the residuals of the two models. The random forest residuals are closer to zero, indicating less error compared to the linear regression model. This comparison highlights the superior performance of the random forest model in capturing the underlying data patterns.

  - **Residual Plot for Comparison:**
![image](https://github.com/user-attachments/assets/0ec2cac8-8da1-4496-8fa7-97abd437173d)

    **Findings:**
    - The comparison plot of random forest and linear regression residuals shows that the random forest model consistently has lower residuals. This further underscores its effectiveness in capturing the intricacies of the dataset. The linear regression model, while adequate, shows more significant errors indicating areas where it might not be modeling the data as precisely.

## Conclusion and Recommendations

- **Conclusion:**
  - The analysis of the Darknet dataset using Linear Regression and Random Forest Regression models revealed significant insights into network traffic behaviors. The Linear Regression model provided a good fit with a high R-squared value, highlighting significant predictors such as `Total.Fwd.Packet` and `Total.Bwd.packets`. However, the residual patterns indicated that this model might not fully capture the complexities of the data, leading to some systematic errors.

  - In contrast, the Random Forest Regression model demonstrated superior performance, as evidenced by its very low mean squared residuals and a high percentage of variance explained. The residuals for the Random Forest model were more randomly distributed, indicating a better fit and higher accuracy in capturing the underlying patterns in the data. The comparative analysis of residuals further confirmed that the Random Forest model outperformed the Linear Regression model, consistently showing lower residuals and fewer errors.

- **Recommendations:**

  - **Model Selection:** Given the superior performance of the Random Forest Regression model, it is recommended to use this model for predicting network flow durations. Its ability to capture complex interactions between features makes it more suitable for this type of dataset.

  - **Feature Engineering:** Further improvements can be achieved by enhancing feature engineering. Creating more meaningful features that capture the underlying patterns in network traffic data can improve model performance. Consider incorporating domain-specific knowledge to design these features.

  - **Handling Class Imbalance:** The dataset shows class imbalance, which can affect model performance. Implement techniques such as SMOTE (Synthetic Minority Over-sampling Technique) or class weighting to address this issue and improve the fairness and accuracy of the models.

  - **Hyperparameter Tuning:** Apply cross-validation and hyperparameter tuning to optimize model parameters. Techniques such as grid search or randomized search can be used to find the best set of parameters for the Random Forest model, further enhancing its performance.

  - **Model Interpretability:** While Random Forest provides excellent accuracy, its interpretability can be limited. Use techniques like SHAP (SHapley Additive exPlanations) or LIME (Local Interpretable Model-agnostic Explanations) to interpret the model and understand feature contributions better.

### 3.2.6 Limitations and Areas for Improvements

- **Class Imbalance:**

  - **Current State:** The dataset shows class imbalance, which can affect model performance and bias the predictions towards the majority class.
  
  - **Improvements:** Implement techniques such as SMOTE (Synthetic Minority Over-sampling Technique), class weighting, or other resampling methods to balance the classes and improve model fairness.

- **Feature Engineering:**

  - **Current State:** The current analysis utilized the provided features without extensive transformation or creation of new features.
  
  - **Improvements:** Enhance feature engineering by creating more meaningful features that capture the underlying patterns in the data. This could involve domain-specific knowledge to create features that better represent network traffic behaviors.

- **Model Tuning:**

  - **Current State:** Basic models were used without extensive hyperparameter tuning.
  
  - **Improvements:** Apply cross-validation and hyperparameter tuning to optimize model parameters, ensuring better performance and generalizability. This could involve grid search or randomized search techniques.

- **Evaluation Metrics:**

  - **Current State:** The models were evaluated primarily using RMSE.
  
  - **Improvements:** Incorporate additional evaluation metrics such as MAE (Mean Absolute Error), R-squared, and others to provide a more comprehensive assessment of model performance.

- **Generalizability:**

  - **Current State:** The models were tested on the provided dataset without considering real-world variability.
  
  - **Improvements:** Validate models on different datasets or through k-fold cross-validation to ensure robustness and generalizability to unseen data.

- **Interpretability:**

  - **Current State:** While the Random Forest model performed well, its interpretability can be limited compared to linear models.
  
  - **Improvements:** Use techniques like SHAP (SHapley Additive exPlanations) or LIME (Local Interpretable Model-agnostic Explanations) to interpret complex models and understand feature contributions better.

## References

14. Bureau of Transportation Statistics. (n.d.). *Electric Vehicle Population Data*. Data.gov. Retrieved from https://catalog.data.gov/dataset/electric-vehicle-population-data

15. Bureau of Transportation Statistics. (2024). *Transportation Public Financial Statistics (TPFS)*. Data.gov. Retrieved from https://catalog.data.gov/dataset/transportation-public-financial-statistics-tpfs

16. Friedrich, P. (2020). *CIC-Darknet2020 Internet Traffic*. Kaggle. Retrieved from https://www.kaggle.com/datasets/peterfriedrich1/cicdarknet2020-internet-traffic
