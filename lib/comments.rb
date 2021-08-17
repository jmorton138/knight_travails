def traverse(graph, board)
    if graph.length < 1 || graph[0] == nil
        return
    end
    paths = board.paths
    
    graph.each_with_index do |vertex, outer_index|

        #p "vertex : #{vertex}" 
        
        graph.each_with_index do |var, inner_index|
            ##initiate var to root of paths?
            if build_children(vertex).include?(var)
                #binding.pry
                #create edge between vertex and var
                # recursively: pass graph excluding vertex and var at front of graph
                #p graph

                graph.delete(vertex)
                graph.delete(var)
                graph.unshift(var) 
                paths[var] = traverse(graph, board)
                #delete var from graph? but then what about when var is vertex?
                #delete vertex from graph
            end
        end
        # delete vertex
        #graph.delete(vertex)
        
        #graph.delete(vertex)
    end
    
    p paths
end


this first brach is correct
{[3, 3]=>{
    [4, 5]=>{
        [2, 4]=>{
            [4, 3]=>{}
            }
        }, 
    # can't get to 2,4 from 3,3    
    [2, 4]=>{
        [4, 3]=>{}}
    },

    [4, 5]=>{
        [2, 4]=>{
            [4, 3]=>{}
                }
            }, 
    2, 4]=>{
        [4, 3]=>{}
        }
}

#make outer loop reduce?
graph.reduce(graph[0]) do |sum, vertex|

    if sum == graph[0] && arrays.length != 0
        arrays.last << graph[0]
    elsif sum == graph[0]
        arrays << [sum]
    end
    p arrays
    graph.each_with_index do |item, index|

        if item == [4,3]
            sum = [3,3]
            
        elsif build_children(sum).include?(item) && !arrays.include?(item)
            arrays.last << item
            sum = item
        end

    end
end
p arrays

def nested_hash
    Hash.new { |h, k| h[k] = nested_hash }
end

graph.each_with_index do |var, index_1|
    board.paths[] = {}
    graph.each_with_index do |item, index_2|
        #puts "#{item} at index #{index_2}"
        arrays[index_1] << item
    end
end
p arrays

# initialize and store source vertex aka graph[0]
# check if next vertex graph[i+1] is included in graph[i]'s children
# if true append graph[i+1] to current list
# then check if graph[i+2] is included in graph[i+1]'s children
# if not start back at source vertex but skip over deadend variable(delete it?)
# visualize chesspeice and test it out on paper then try and form algorithm





<Node:0x00007fcfe28937d0 @vertex=[3, 3],
@children=[[4, 5], [4, 1], [2, 5], [2, 1], [5, 4], [5, 2], [1, 2], [1, 4]]>

p board.paths
graph = [[3, 3], [4, 5], [5, 7], [5, 3], [6, 5], [7, 7], [7, 3], [6, 1],
[3, 7], [4, 1], [2, 5], [2, 1], [5, 4], [6, 6], [6, 2], [7, 4], [7, 0],
[4, 6], [4, 2], [7, 5], [5, 2], [6, 4], [7, 6], [7, 2], [5, 6], [6, 0], 
[4, 4], [4, 0], [1, 2], [2, 4], [3, 6], [3, 2], [1, 6], [2, 0], [0, 4], 
[0, 0], [1, 4], [2, 6], [2, 2], [3, 4], [3, 0], [0, 6], [0, 2], [3, 5],
[4, 7], [4, 3], [5, 5], [6, 7], [6, 3], [5, 1], [2, 7], [2, 3]]





def knight_moves(start_vertex, end_vertex, board)
    if start_vertex == end_vertex
        p "got it"
        return
    elsif start_vertex == nil
        p "out"
        return
    end
    moves = board.moves
    len = moves.length - 1
    node = Node.new(start_vertex)
    if len < 0
        p "start"
        moves[0] = [start_vertex]
    end
    node.children.each_with_index do |child, index|
  
        if child == nil
            p "out of bounds"
            moves[moves.length] = []
            return
        elsif child == end_vertex
            p "end vertex"
            moves[moves.length - 1].push(child)
            moves[moves.length] = []
            return
        else
            p "here"    
            p moves[moves.length - 1].push(child)
            #board.board.delete(child)
            #binding.pry
        
        end
        node.children[index] = knight_moves(child, end_vertex, board)
    
    end
    p node
    
end



def depth_trav(visited, term)
    if visited[0] == nil || visited.length < 1
        return
    end
    if visited[0][1] == term
        return
    end
    
    paths = {}
    visited.reduce do |sum, vertex|
        if sum == visited[0]
            paths[sum] = {}
        end
        knight = visited.index(vertex)
        if sum[1] == vertex[0] 
            paths[sum] = depth_trav(visited[knight..(visited.length-1)], term)
            sum = vertex
        else
            sum = sum 
        end
    end
    p paths
end

# ####
# def depth_trav(visited, term)

#     if visited[0][1] == term
#         return
#     end
#     arrays = []
#     visited.reduce(visited[0]) do |sum, vertex|
#         #initialize array. First if is redundant?
#         # if sum == visited[0] && arrays.length != 0
#         #     arrays.last << visited[0]
#         # els
#         if sum == visited[0]
#             arrays << [sum]
#         end
#         #or from reduce?

#         #recursion from each variable?
#         visited.each_with_index do |item, index|
#             if item[1] == term
#                 #what do I want to happen here? How do I need to traverse and store data?
#                 arrays.last << item
#                 print_moves(arrays)
#                 return
#             elsif sum[1] == item[0]
#                 arrays.last << item
#                 sum = item
#             end
#         end
#     end  
# end
