class Gameboard
    #create gameboard with 8 x 8 spaces
    attr_reader :board 
    attr_accessor :moves, :paths
    def initialize
        @board = build_board_boundaries(8)
        @moves = []
        @paths = {}
    end

    def build_board_boundaries(size, array = [])
        i = 0
        j = 0
        for i in 0..(size - 1)
            for j in 0..(size - 1)
                array.push([i, j])
            end
        end
        array 
    end

    def add_move(vertex)
        moves << vertex
    end

    def build_knight_graph(source, term, board)
        root = Node.new(source)
        return if source == nil
        self.add_move(source) unless moves.include?(source)
        root.children.each do |child|
            return if moves.include?(child)
            return if child == nil

            build_knight_graph(child, term, board)
            moves
        end
        moves
        return moves
    end

    def add_edge(i, node1)
        paths[i] = node1
        p paths
    end


end


    # node children in an array of vertices this time, so instead of going right and left
    # as in BST I can loop through an array from 0-7
    #I can use the build_board method to check if something is out of bounds
    # method will have array of vertices from initial position, you need a path with edges to every
    #next move at every vertex, that's the only way can find the shortest path so I need
    # to make a graph from all those edges