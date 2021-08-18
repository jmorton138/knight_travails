class Gameboard
    #create gameboard with 8 x 8 spaces
    attr_reader :board 
    attr_accessor :moves, :paths
    def initialize
        @board = build_board_boundaries(8)
        @moves = []
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
        return moves if source == nil || moves.include?(source)
        self.add_move(source) unless moves.include?(source)
        root.children.each do |child|
            if child == nil
                next
            end
            build_knight_graph(child, term, board)
            moves
        end
        return moves
    end
end
