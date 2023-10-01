# works on pandas 1.5.3, numpy 1.24.3, matplotlib 3.6.2 and networkx 3.1
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import networkx as nx
from matplotlib.patches import Polygon

triangle_complex = nx.Graph()

triangle_complex.add_node('B')
triangle_complex.add_node('C')
triangle_complex.add_node('D')
triangle_complex.add_node('E')
triangle_complex.add_node('F')
triangle_complex.add_node('G')
triangle_complex.add_node('H')

triangle_complex.add_edge('A', 'B')
triangle_complex.add_edge('B', 'C')
triangle_complex.add_edge('A', 'C')
triangle_complex.add_edge('C', 'D')
triangle_complex.add_edge('B', 'D')
triangle_complex.add_edge('E', 'F')
triangle_complex.add_edge('C', 'H')

pos = {'A': (0, 0), 'B': (0.8, 0), 'C': (0.5, 0.9), 'D':(1.3,0.7), 'E':(1.3,0.1), 'F':(1.8, 0.8), 'G':(2,0.2), 'H':(0,0.8)}
A = np.array([[0, 0],
              [0.8, 0],
              [1.3, 0.7],
              [0.5,0.9]])

fig, ax = plt.subplots()

polygon = Polygon(A, closed=False, facecolor='lightblue')
ax.add_patch(polygon)

nx.draw_networkx_nodes(triangle_complex, pos, node_size=100, node_color='black', ax=ax)
nx.draw_networkx_edges(triangle_complex, pos, width=1.5, edge_color='black', ax=ax)

plt.title('Example of a Simplicial Complex')
plt.axis('off')
plt.show()

triangle_complex = nx.Graph()

triangle_complex.add_node('B')
triangle_complex.add_node('C')
triangle_complex.add_node('D')
triangle_complex.add_node('E')
triangle_complex.add_node('F')

triangle_complex.add_edge('A', 'B')
triangle_complex.add_edge('B', 'C')
triangle_complex.add_edge('A', 'C')
triangle_complex.add_edge('D', 'E')
triangle_complex.add_edge('E', 'F')
triangle_complex.add_edge('D', 'F')

pos = {'A': (0, 0), 'B': (0.8, 0), 'C': (0.8, 0.6), 'D':(0.8,0.2), 'E':(0.8,1), 'F':(1.5, 0.8)}
A = np.array([[0, 0],
              [0.8, 0],
              [0.8, 0.2],
              [1.5,0.8],
              [0.8,1],
              [0.8,0.6]])

fig, ax = plt.subplots()

polygon = Polygon(A, closed=False, facecolor='lightblue')
ax.add_patch(polygon)

nx.draw_networkx_nodes(triangle_complex, pos, node_size=100, node_color='black', ax=ax)
nx.draw_networkx_edges(triangle_complex, pos, width=1.5, edge_color='black', ax=ax)

plt.title('Non-Example of a Simplicial Complex')
plt.axis('off')
plt.show()