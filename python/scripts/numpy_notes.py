import numpy as np

# 1D array creation
#   - default dtypes are int32 and float64
a1D = np.array([1.0,2,3],dtype=np.float64)
a1Dr = np.arange(1,10,0.1,dtype=np.float64)
a1Dlin = np.linspace(1,10,91)

# 2D array creation
a2D = np.array([[1,2],[3,4]])
eye = np.eye(2,2)
zeromat = np.zeros((2,2)) # accepts an int or tuple of int as input
onemat = np.ones((2,2)) # recall tuples use parenthesis, lists use square brackets
random_vector = np.random.uniform(0,1.0,10) # using psuedo-random generators

# accessing and manipulating array elements
accession = np.arange(4).reshape((2,2))
test = accession[:,0]

pass