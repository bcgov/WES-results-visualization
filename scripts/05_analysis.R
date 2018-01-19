# Copyright 2017 Province of British Columbia
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

# Analysis.

# Turn regression weights into a network graph.

graph <- graph_from_data_frame(regression_weights, directed = TRUE)
vertices <- as_tibble(vertex_attr(graph))

# Add the x and y values to the vertices
vertices <- left_join(vertices, graph_layout, by = c('name' = 'Node'))
# TODO: Assert the post-join tibble has the same length as pre-join.

# Color the edges
E(graph)$color <- 'grey'
E(graph)$color[E(graph)$Weight > 0.2] <- 'blue'
E(graph)$color[E(graph)$Weight > 0.4] <- 'red'

# Other edge customization
E(graph)$arrow.size <- 0.5
E(graph)$arrow.width <- 1.2
E(graph)$width <- 2

V(graph)$color <- 'grey'

# Custom layout from the graph_layout
custom_layout <- as.matrix(vertices %>% select(c('x', 'y')))

# Plot the graph.
plot(graph, layout = custom_layout)