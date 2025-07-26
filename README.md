# 💼 Employee Salary Predictor –Web App

📍 **Live Demo**: [Click here to view the app](https://employee-salary-predictor-app.streamlit.app/) 

## 📌 Project Overview

This interactive web application predicts an employee’s monthly salary based on features such as **age**, **experience**, **degree**, **job title**, and **gender**.  
A **Random Forest Regression** model is used to capture nonlinear patterns and interactions in the data.  
Built with **Streamlit**, the app delivers real-time salary predictions through a user-friendly UI, and is deployed on **Streamlit Cloud** for public access.

## 🎯 Objectives

- 🔍 Predict salary using multiple employee features  
- 🧠 Use Random Forest Regressor for high-performance salary estimation  
- 💬 Enable user-friendly interaction for real-time prediction  
- 📉 Visualize model evaluation and feature importance  

## 📁 Dataset Description

| Feature            | Description                            |
|--------------------|----------------------------------------|
| `Age`              | Age of the employee (in years)         |
| `Gender`           | Gender identity                        |
| `Degree`           | Highest educational qualification      |
| `Job_Title`        | Current role or designation            |
| `Experience_Years` | Work experience in years               |
| `Salary`           | Monthly salary (target variable)       |

## ⚙️ Tech Stack

- 🐍 Python  
- 🌲 `RandomForestRegressor` from Scikit-learn  
- 📊 Pandas, NumPy for data manipulation  
- 📉 Seaborn, Matplotlib for visualizations  
- 🌐 Streamlit for web interface  

## 📊 Features

- ✅ Interactive input form: Age, Gender, Degree, Job Title, Experience  
- ✅ Instant salary prediction displayed in ₹ (INR)  
- ✅ Evaluation metrics (R², MSE) displayed on test data  
- ✅ Graphs: Actual vs Predicted, Residuals, Feature Importance, Scatter Plot  
- ✅ Hosted using **Streamlit Cloud**

## 📈 Model Performance

The Random Forest model was evaluated on a hold-out test set:

| Metric                   | Value          |
|---------------------------|----------------|
| 📉 Mean Squared Error (MSE) | ~233,566,052    |
| 📈 R² Score                | **0.91**       |
| 📊 MAE (Mean Absolute Error) | ~4,856 INR      |

> ✅ The model demonstrates **high accuracy** with an R² score of **95.8%**, indicating that it explains most of the variance in salary.

## 📊 Visualizations

1. **📈 Actual vs Predicted** – Line plot of predicted vs real salary  
2. **📉 Residual Distribution** – Residual errors plotted as a histogram  
3. **🌟 Feature Importance** – Ranked influence of each feature on prediction  
4. **🔵 Scatter Plot** – Correlation between actual and predicted salaries  

## 🧪 Sample Prediction (Example)

| Feature             | Input           |
|---------------------|-----------------|
| Age                 | 29              |
| Gender              | Female          |
| Degree              | M.Tech          |
| Job Title           | Data Analyst    |
| Experience_Years    | 4               |
| 💰 Predicted Salary | ₹ 1,32,000 / month |

## 🔮 Future Recommendations
- 🔁 **Retrain with Larger & Updated Dataset**  
  Incorporate more real-world samples from industry sources for better generalization.
- 🧑‍💼 **Add More Features**  
  Include company size, location, skills, certifications, performance ratings, etc.
