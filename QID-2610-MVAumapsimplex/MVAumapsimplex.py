# works on pandas 1.5.3, numpy 1.24.3, matplotlib 3.6.2 and networkx 3.1
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import networkx as nx
from matplotlib.patches import Polygon

simplices = nx.Graph()
simplices.add_node('A')
pos = {'A':(0.5,0.5)}
fig, ax = plt.subplots(figsize=(3,3))
nx.draw_networkx_nodes(simplices, pos, node_size=100, node_color='black', ax=ax)
plt.axis('off')
plt.title('0-simplex')
plt.show()

simplices = nx.Graph()
simplices.add_node('A')
simplices.add_node('B')
simplices.add_edge('A','B')
pos = {'A':(0.3,0.5), 'B':(0.7,0.5)}
fig, ax = plt.subplots(figsize=(3,3))
nx.draw_networkx_nodes(simplices, pos, node_size=100, node_color='black', ax=ax)
nx.draw_networkx_edges(simplices, pos, width=1.5, edge_color='black', ax=ax)
plt.axis('off')
plt.title('1-simplex')
plt.show()

simplices = nx.Graph()
simplices.add_node('A')
simplices.add_node('B')
simplices.add_node('C')
simplices.add_edge('A','B')
simplices.add_edge('B','C')
simplices.add_edge('A','C')
pos = {'A':(0,0), 'B':(1,0), 'C':(0.5,0.5)}
A = np.array([[0, 0],
              [1, 0],
              [0.5, 0.5]])
fig, ax = plt.subplots(figsize=(3,3))
polygon = Polygon(A, closed=False, facecolor='lightblue')
ax.add_patch(polygon)
nx.draw_networkx_nodes(simplices, pos, node_size=100, node_color='black', ax=ax)
nx.draw_networkx_edges(simplices, pos, width=1.5, edge_color='black', ax=ax)
plt.axis('off')
plt.title('2-simplex')
plt.show()

simplices = nx.Graph()
simplices_light = nx.Graph()
simplices.add_node('A')
simplices.add_node('B')
simplices.add_node('C')
simplices.add_node('D')
simplices_light.add_edge('A','B')
simplices.add_edge('B','C')
simplices.add_edge('A','C')
simplices.add_edge('A','D')
simplices.add_edge('B','D')
simplices.add_edge('C','D')
pos = {'A':(0,0), 'B':(1,0), 'C':(0.5,0.5), 'D':(0.5,-0.1)}
A = np.array([[0, 0],
              [0.5, 0.5],
              [0.5, -0.1]])
B = np.array([[0.5, -0.1],
              [0.5, 0.5],
              [1, 0]])
fig, ax = plt.subplots(figsize=(3,3))
polygonA = Polygon(A, closed=False, facecolor='lightblue')
ax.add_patch(polygonA)
polygonB = Polygon(B, closed=False, facecolor='#4aa8b5')
ax.add_patch(polygonB)
nx.draw_networkx_nodes(simplices, pos, node_size=100, node_color='black', ax=ax)
nx.draw_networkx_edges(simplices_light, pos, width=1.5, edge_color='black', alpha = 0.3, ax=ax)
nx.draw_networkx_edges(simplices, pos, width=1.5, edge_color='black', ax=ax)
plt.axis('off')
plt.title('3-simplex')
plt.show()