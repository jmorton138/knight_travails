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

#creates list of all edges in graph
def edge_list(graph)
    list = []
    directed_edge_list = []
    graph.each do |outer| #nil class? undefined methods
        graph.each do |inner|
            if build_children(outer).include?(inner)
                list << [outer, inner]
            end
        end
    end
    list
end

#orders edges into directed list i.e., deletes duplicates
def direct_edge_list(edges)
    directed_edge_list =[]
    edges.map do |item|
        if edges.include?(item.reverse)
            directed_edge_list << item
            edges.delete(item.reverse)
        end
    end
    directed_edge_list
end

def breadth_first(graph, term)
    #counter = 1
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
        if current[1] == term || current[0] == term
            p "Number of moves: #{distance[visited.index(current)]}"
            return find_path(visited, term, distance[visited.index(current)])
            return visited
        end
        #log children of current node into queue
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
        #counter += 1
        queue.shift()
    end
    return visited
end




def print_moves(arrays)
    arrays.each_with_index do |node, index|
        p node[0]
        if index == arrays.length - 1
            p node[1]
        end
    end
end

def find_path(visited, term, distance, array = [visited[0]])
    # distance = 3 yields an answer conforming to this but still not a palindrome
    
    visited.delete(visited[0].reverse)
    counter = 1
    result = visited.reduce(visited[0]) do |sum, vertex|
        # p "sum #{sum}"
        # p "vertex #{vertex}"
        # p "counter #{counter}"
        # p "array #{array}"
        if sum[1] == vertex[0]
            array << vertex
            visited.delete(vertex.reverse)
            sum = vertex
            counter += 1
        end
        if distance == counter && sum[1] != term
            visited.delete(sum)
            find_path(visited, term, distance)
        end
        sum = sum
    end
    #p "result: #{result}"
    if result[1] != term
        visited.delete(result)
        find_path(visited, term, distance)
    elsif result != nil && result[1] == term
        #returns array of moves to term
        # p "distance #{distance}"
        return array
       # print_moves(array)
    end
end

def knight_moves(source, term)
    board = Gameboard.new()
    graph = board.build_knight_graph(source, term, board)
    edges = edge_list(graph)
    directed_edge_list = direct_edge_list(edges)
    visited = breadth_first(directed_edge_list, term)
    moves_array = find_path(visited, term) 
    print_moves(moves_array)
end

#knight_moves([3, 3], [4, 3])

source = [4, 3]
term = [3, 3]
board = Gameboard.new()

graph = board.build_knight_graph(source, term, board) # still wrong
#p graph.include?([3, 3])
edges = edge_list(graph) #works with 3, 3, 4,5, doesn't work with [0, 0], [1, 2]
#directed_edge_list = direct_edge_list(edges) #bug - value goes missing - this seems unneccessary?
# #could combine 2 functions saying either or when connecting then deleting afterwards
# #p directed_edge_list.include?([[4,5], [2,4]]) #true now

#visited = breadth_first(edges, term)


#array = find_path(visited, term) # buggy
print_moves(breadth_first(edges, term))

# p [
#     [1, 2],
#     [1, (-2)],
#     [(-1), 2],
#     [(-1), (-2)],
#     [2, 1],
#     [2, (-1)],
#     [(-2),(-1)],
#     [(-2), 1]].sort





