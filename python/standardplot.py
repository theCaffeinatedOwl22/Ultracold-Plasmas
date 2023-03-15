import matplotlib.pyplot as plt
import numpy as np
import math as m

x = np.linspace(0, m.pi, 100)  # Create a list of evenly-spaced numbers over the range
plt.plot(x, np.sin(x))       # Plot the sine of each x point
plt.show()                   # Display the plot