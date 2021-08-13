class Node
    attr_accessor :vertex, :children

    def initialize(vertex)
        #[i, j]
        @vertex = vertex 
        #children
        @children = build_child_nodes(@vertex)
    end

    def build_child_nodes(vertex, nodes = [])
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
        #make into function
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
end
