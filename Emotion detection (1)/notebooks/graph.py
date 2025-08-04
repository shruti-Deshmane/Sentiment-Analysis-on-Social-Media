import matplotlib.pyplot as plt

# Data
algorithms = ['Naive Bayes', 'SVC', 'Deep Learning Model', 'LogisticRegression']
accuracies = [65, 68, 63, 74]  # Example accuracy percentages

# Plotting
plt.figure(figsize=(8, 5))
plt.plot(algorithms, accuracies, marker='o', color='blue', label='Accuracy')
plt.title('Algorithm vs Accuracy', fontsize=16)
plt.xlabel('Algorithms', fontsize=14)
plt.ylabel('Accuracy (%)', fontsize=14)
plt.ylim(60, 80)  # Adjusted to match the accuracy range
plt.grid(True, linestyle='--', alpha=0.6)
plt.legend(fontsize=12)
plt.tight_layout()

# Display the graph
plt.show()
