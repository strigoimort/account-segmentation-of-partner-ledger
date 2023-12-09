import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load Data
data = data
df = pd.DataFrame(data)

# Data Cleansing (Replace this with your actual data cleansing steps)
# Example: Convert 'due_date' to datetime
df['due_date'] = pd.to_datetime(df['due_date'])

# Exploratory Data Analysis (EDA)
# Summary Statistics
summary_stats = df.describe()

# Data Visualization
# Example: Bar plot for 'segment_partner'
plt.figure(figsize=(10, 6))
sns.barplot(x='segment_partner', y='abs_balance', data=df, hue='status')
plt.title('Segment-wise Absolute Balance')
plt.xlabel('Segment Partner')
plt.ylabel('Absolute Balance')
plt.show()

# Further EDA and Visualization based on your requirements

# Save the cleansed data to a new CSV file
df.to_csv('cleaned_data.csv', index=False)
