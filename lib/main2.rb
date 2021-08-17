require './lib/gameboard.rb'
require './lib/node.rb'
require 'pry'

def build_children(vertex, nodes = [])
    moves = [
    [1, 2],
    [1, (-2)],
    [(-1), 2],
    [(-1), (-2)],
    [2, 1],
    [2, (-1)],
    [(-2),(-1)],
    [(-2), 1]]

    nodes = moves.reduce([]) do |sum, item|
   
        item[0] = vertex[0] + item[0]
        item[1] = vertex[1] + item[1]
        sum.push(item)
    end

    i = 0
    j = 0
    board = []
    for i in 0..7
        for j in 0..7
            board.push([i, j])
        end
    end

    nodes = nodes.map do |node|
        if board.any? { |coordinate| coordinate == node }
            node = node
        end
    end
    #nodes = nodes.compact

end


board = Gameboard.new()

#p knight_moves([3,3],[4,3], board)


#graph = board.build_knight_graph([3,3],[4,3], board)
graph = [[3, 3], [4, 5], [5, 7], [4, 3],[5, 3], [2, 4], [6, 5], [7, 7], [7, 3], [6, 1]]



def edge_list(graph)
    list = []
    graph.each do |outer|
        graph.each do |inner|
            if build_children(outer).include?(inner)
                list << [outer, inner]
            end
        end
    end
    list
end


edges = edge_list(graph)

#double check this tomorrow
directed_edge_list =[]

edges.map do |item|
    if edges.include?(item.reverse)
        directed_edge_list << item
        edges.delete(item)
    end
end
directed_edge_list




def breadth_first(graph)
    counter = 1
    queue = []
    visited = []
    distance = Array.new(graph.length, -1)
    #initialize all values to -1 
    distance[0] = 1
    #save node in Q
    queue << graph[0]
    q_count = 1
    while !queue.empty?() do
        current = queue.first()
        #counter += 1
        #save current node as visited
        visited << current

        if current[1] == [6,5]
           p "Number of moves: #{distance[visited.index(current)]}"
            return visited
        end
        
        #log children of current in queue
        children = build_children(current[1]).compact
        children.each do |child|
            # if child is in graph and if child hasn't been visited add to Q  graph.include?(child)   &&       
            if !visited.include?(child) && graph.include?([current[1], child])
                queue << [current[1], child]
                distance[q_count] = distance[visited.index(current)] + 1
                q_count += 1 #this part works
                
            end
        end
        counter += 1 # this counter doesn't
        queue.shift()
  
    end
    
    return visited
end
#breadth_first([3,3],[4,3], directed_edge_list)


visited = breadth_first(directed_edge_list)

def depth_trav(visited, term)
    arrays = []
    visited.reduce(visited[0]) do |sum, vertex|
        if sum == visited[0] && arrays.length != 0
            arrays.last << visited[0]
        elsif sum == visited[0]
            arrays << [sum]
        end
        visited.each_with_index do |item, index|
            if item[0] == term
                return
            elsif sum[1] == item[0]
                arrays.last << item
                sum = item
            end
        end
    end

    arrays[0].each_with_index do |node, index|
        p node[0]
        if index == arrays[0].length - 1
            p node[1]
        end
    end
end
depth_trav(visited, [6,5])
#depth_trav(breadth_first(directed_edge_list), [6,5])


# # arr = [directed_edge_list[0]]
# # directed_edge_list.reduce(directed_edge_list[0]) do |list, edge|
# #     if edge[0] == list[1]

# #         arr << edge
 
# #         list = edge
# #     end
# #     list
# # end

# array = [
# [[3, 3], [4, 5]],
# [[4, 5], [5, 7]],
# [[4, 5], [2, 4]], 
# [[5, 7], [6, 5]], 
# [[5, 3], [4, 5]], 
# [[5, 3], [6, 1]], 
# [[2, 4], [4, 3]], 
# [[6, 5], [5, 3]], 
# [[6, 5], [7, 3]],
# [[7, 3], [6, 1]]
# ]

# root = visited[0]
# len = visited.length - 1
# return if len < 1 || root == nil
# if root == term
#     p root
#     return
# end
# visited.each_with_index do |node, index|
#     return if node == nil
#     if node[1] == visited[index + 1][0]
#         depth_trav(visited[(index+1)..len], term)
#     end
# end
#depth first
# def traverse(graph)
#     if graph[0] == nil || graph.length < 1
#         return
#     end
    
#     paths = {}
#     graph.reduce do |sum, vertex|
#         if sum == graph[0]
#             paths[sum] = {}
#         end
#         knight = graph.index(vertex)
#         if build_children(sum).include?(vertex)
#             #edge list: paths << [sum, vertex]    
#             paths[sum] = traverse(graph[knight..(graph.length-1)])
#             graph.delete(sum)
#             sum = vertex
#         else
#             sum = sum 
#         end
#     end
    
#     paths
# end


def depth_trav(visited, term)
    arrays = []
    visited.reduce(visited[0]) do |sum, vertex|
        if sum == visited[0] && arrays.length != 0
            arrays.last << visited[0]
        elsif sum == visited[0]
            arrays << [sum]
        end
        visited.each_with_index do |item, index|
            if item[1] == term
                #what do I want to happen here? How do I need to traverse and store data?
                arrays.last << item
                print_moves(arrays)
                return
            elsif sum[1] == item[0]
                arrays.last << item
                sum = item
            end
        end
    end  
end