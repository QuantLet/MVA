# Works on pandas 2.0.0, scikit-learn 1.3.1, matplotlib 3.7.1
import pandas as pd
from sklearn.tree import DecisionTreeClassifier, plot_tree
import matplotlib.pyplot as plt

# Load data
data = pd.read_csv('bankruptcy.dat', sep='\s+', header=None)
data.columns = ['X1', 'X2', 'y']

# Prepare the data for the model
X = data[['X1', 'X2']]
y = data['y']

# Create classification tree
clf = DecisionTreeClassifier(
    criterion='gini',           # Splitting criterion
    min_samples_split=30,       # Minimum number of samples required to split a node
    min_samples_leaf=1,         # Minimum number of samples required to be at a leaf node
    max_depth=30,               # Maximum depth of the tree
    random_state=0,             # Ensures reproducibility of the model
)

clf.fit(X, y)

# Plotting
plt.figure(figsize=(20, 10))
plot_tree(
    clf,
    filled=True,
    feature_names=['X1', 'X2'],
    class_names=['Class -1', 'Class 1'],
    rounded=True,
    fontsize=12,
    precision=2
)
plt.title('Decision Tree for Bankruptcy Dataset', fontsize=20)
plt.show()