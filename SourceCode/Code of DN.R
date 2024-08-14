# 加载必要的库
library(tidyverse)
library(caret)
library(ggplot2)
library(corrplot)
library(randomForest)

# 导入数据集
darknet <- read.csv("C:\\Users\\Xinglai\\Desktop\\Darknet.CSV")

# 数据转换
darknet <- darknet %>% mutate_if(is.character, as.factor)

# 检查和处理缺失值
darknet <- na.omit(darknet)

# 确保所有列都是数值类型
darknet <- darknet %>% mutate_if(is.factor, as.numeric)

# 标准化数值列，移除标准差为零的列
numeric_cols <- darknet %>% select_if(is.numeric)
darknet_scaled <- numeric_cols %>% select_if(~ sd(.) != 0) %>% scale()

# 创建新的数据框，包含标准化后的数值列
darknet <- cbind(darknet %>% select_if(is.factor), darknet_scaled)
# 筛选重要特征列，根据实际存在的列名进行选择
selected_columns <- c("Flow.Duration", "Total.Fwd.Packet", "Total.Bwd.packets", 
                      "Packet.Length.Mean", "Packet.Length.Std", "Idle.Mean", "Idle.Std")

# 创建新的数据框，包含选定的特征列
darknet_selected <- darknet %>% select(all_of(selected_columns))

# 计算相关矩阵
corr_matrix <- cor(darknet_selected, use = "complete.obs")

# 改进的相关矩阵可视化
corrplot(corr_matrix, method = 'color', tl.col = 'black', tl.srt = 45, tl.cex = 0.8, number.cex = 0.8)
# 直方图
ggplot(darknet, aes(x = `Flow.Duration`)) +
  geom_histogram(binwidth = 1, fill = 'blue', color = 'black') +
  theme_minimal() +
  labs(title = 'Distribution of Flow Duration', x = 'Flow Duration', y = 'Frequency')

# 确保 Label 列被视为因子
darknet$Label <- as.factor(darknet$Label)

# 使用 aes(group = Label) 明确分组
ggplot(darknet, aes(x = Label, y = `Flow.Duration`, group = Label)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = 'Boxplot of Flow Duration by Label', x = 'Label', y = 'Flow Duration')

# 散点图
ggplot(darknet, aes(x = `Flow.Duration`, y = `Total.Fwd.Packet`)) +
  geom_point() +
  theme_minimal() +
  labs(title = 'Scatter Plot of Flow Duration vs Total Fwd Packet', x = 'Flow Duration', y = 'Total Fwd Packet')

# 柱状图
ggplot(darknet, aes(x = Label)) +
  geom_bar(fill = 'blue', color = 'black') +
  theme_minimal() +
  labs(title = 'Count of Categories in Label', x = 'Label', y = 'Count')

# 线性回归
linear_model <- lm(`Flow.Duration` ~ ., data = darknet)
summary(linear_model)

# 线性回归残差图
linear_pred <- predict(linear_model, darknet)
ggplot(darknet, aes(x = linear_pred, y = darknet$`Flow.Duration` - linear_pred)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  theme_minimal() +
  labs(title = 'Residual Plot for Linear Regression', x = 'Predicted Values', y = 'Residuals')

# 随机森林回归
rf_model <- randomForest(`Flow.Duration` ~ ., data = darknet)
print(rf_model)
varImpPlot(rf_model)

# 随机森林回归残差图
rf_pred <- predict(rf_model, darknet)
ggplot(darknet, aes(x = rf_pred, y = darknet$`Flow.Duration` - rf_pred)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  theme_minimal() +
  labs(title = 'Residual Plot for Random Forest Regression', x = 'Predicted Values', y = 'Residuals')

# 模型评估
linear_rmse <- sqrt(mean((darknet$`Flow.Duration` - linear_pred)^2))
rf_rmse <- sqrt(mean((darknet$`Flow.Duration` - rf_pred)^2))

evaluation <- data.frame(Model = c('Linear Regression', 'Random Forest'),
                         RMSE = c(linear_rmse, rf_rmse))
print(evaluation)

# 比较随机森林和线性回归残差的图表
linear_residuals <- darknet$`Flow.Duration` - linear_pred
rf_residuals <- darknet$`Flow.Duration` - rf_pred

comparison_data <- data.frame(
  Random_Forest_Residuals = rf_residuals,
  Linear_Regression_Residuals = linear_residuals
)

ggplot(comparison_data, aes(x = Random_Forest_Residuals, y = Linear_Regression_Residuals)) +
  geom_point(alpha = 0.5) +
  geom_abline(slope = 1, intercept = 0, color = 'red') +
  theme_minimal() +
  labs(title = 'Comparison of Random Forest and Linear Regression Residuals',
       x = 'Random Forest Residuals',
       y = 'Linear Regression Residuals')