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
end

#creates list of all edges in graph
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

#Traverse graph in breadth order to get distances to each node
def breadth_first(graph, source, term)
    queue = []
    visited = []
    distance = Array.new(graph.length, -1)
    #initialize all values to -1 
    distance[0] = 1
    #save node in Q
    q_count = 0
    #initialize queue with "root" nodes 
    graph.each_with_index do |item, index|
        if item[0] == source
            queue << item
            distance[index] = 1
            q_count += 1
        end
    end

    while !queue.empty?() do
        current = queue.first()
        #save current node as visited
        visited << current
        if current[1] == term || current[0] == term
            p "Number of moves: #{distance[visited.index(current)]}"
    
            return find_path(visited, term, distance[visited.index(current)])
        end
        #log children of current node into queue
        children = build_children(current[1]).compact
        children.each do |child|
            if !visited.include?([current[1], child])
                queue << [current[1], child]
                distance[q_count] = distance[visited.index(current)] + 1
                q_count += 1
            end
        end
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

#sort shortest path into array
def find_path(visited, term, distance, array = [visited[0]])    
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
    if result[1] != term
        visited.delete(result)
        find_path(visited, term, distance)
    elsif result != nil && result[1] == term
        return array
    end
end


def knight_moves(source, term)
    board = Gameboard.new()
    graph = board.build_knight_graph(source, term, board)
    edges = edge_list(graph)
    print_moves(breadth_first(edges, source, term))
end

knight_moves([4, 3], [3, 3])
knight_moves([0,0], [3, 3])
knight_moves([3, 3], [0, 0])





