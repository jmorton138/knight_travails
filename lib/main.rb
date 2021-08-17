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

#p knight_moves([3,3],[4,3], board)
#graph = board.build_knight_graph([3,3],[4,3], board)

#creates list of all edges in graph
def edge_list(graph)
    list = []
    directed_edge_list = []
    graph.each do |outer|
        graph.each do |inner|
            if build_children(outer).include?(inner)
                list << [outer, inner]
            end
        end
    end
    list
end

#orders edges into directed list
def direct_edge_list(edges)
    directed_edge_list =[]
    edges.map do |item|
        if edges.include?(item.reverse)
            directed_edge_list << item
            edges.delete(item)
        end
    end
    directed_edge_list
end

def breadth_first(graph, term)
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
        #save current node as visited
        visited << current
        if current[1] == term
            # p term
            # p current
            p "Number of moves: #{distance[visited.index(current)]}"
            return visited
        end
        #log children of current in queue
        children = build_children(current[1]).compact
        children.each do |child|
            if !visited.include?(child) && graph.include?([current[1], child])
                queue << [current[1], child]
                distance[q_count] = distance[visited.index(current)] + 1
                q_count += 1 #this part works 
                # p "Q: #{q_count}" 
                # p "visited: #{visited}"
            end
        end
        counter += 1 # this counter doesn't
        queue.shift()
  
    end
    return visited
end

#use distance as limit to loop i.e., if array[distance] != term then delete last variable and loop through again.




#testarr = [[[2, 4], [4, 3]], [[3, 3], [4, 5]], [[4, 5], [5, 7]], [[4, 5], [2, 4]], [[5, 7], [6, 5]]]
#graph = [[3, 3], [4, 5], [5, 7], [4, 3], [5, 3], [2, 4], [6, 5], [7, 7], [7, 3], [6, 1]]



def print_moves(arrays)
    #p arrays
    #this prints array properly but array input array isn't right
    arrays.each_with_index do |node, index|
        p node[0]
        if index == arrays.length - 1
            p node[1]
        end
    end
end

def find_path(visited, term)
    array = [visited[0]]
    distance = 3
    counter = 1
    result = visited.reduce(visited[0]) do |sum, vertex|
        # p "sum #{sum}"
        # p "vertex #{vertex}"
        # p "counter #{counter}"
        # p "array #{array}"
        if sum[1] == vertex[0]
            array << vertex
            sum = vertex
            counter += 1
        end
        if distance == counter && sum[1] != term
            visited.delete(sum)
            find_path(visited, term)
        end
        sum = sum
    end
    #p "endsum #{result}"
    if result[1] != term
        visited.delete(result)
        find_path(visited, term)
    elsif result[1] == term
        print_moves(array)
    end
    
end

def knight_moves(source, term)
    board = Gameboard.new()
    graph = board.build_knight_graph(source, term, board)
    #graph = [[3, 3], [4, 5], [5, 7], [4, 3], [5, 3], [2, 4], [6, 5], [7, 7], [7, 3], [6, 1]]

    edges = edge_list(graph)
    directed_edge_list = direct_edge_list(edges)
    visited = breadth_first(directed_edge_list, term)
    find_path(visited, term)
    #depth_trav(visited, term)
end

knight_moves([0, 0], [1, 2])





#breadth_first([3,3],[4,3], directed_edge_list)

# edges = edge_list(graph)
# directed_edge_list = direct_edge_list(edges)
# visited = breadth_first(directed_edge_list)
#visited = breadth_first(direct_edge_list(edge_list(graph)))







