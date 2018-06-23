require_relative 'skeleton/lib/00_tree_node'


class KnightPathFinder
  MOVES = [
    [-1,-2],
    [-2,-1],
    [1,-2],
    [2,-1],
    [-2,1],
    [-1,2],
    [1,2],
    [2,1]
  ]
  attr_reader :root
  def initialize(pos)
    @pos = pos
    @root = PolyTreeNode.new(@pos)
    @visited_positions = [@pos]
    build_move_tree
  end

  def build_move_tree
    queue = [@root]
    until queue.empty?
      current_node = queue.shift
      available_pos = new_move_positions(@pos).map {|el| PolyTreeNode.new(el)}
      available_pos.each {|node| node.parent = @root}
      queue += available_pos

    end
    @root
  end

  def find_path(pos)
    p "THIS IS ROOT"
    p @root
    end_node = @root.bfs(pos)
    trace_back_path(end_node)
  end

  def trace_back_path(end_node)
    result = [end_node]

    until end_node == @root
      p "THIS IS WHERE WE ARE AT"
      p end_node.value
      end_node = end_node.parent
      result.unshift(end_node)

    end
    result.map {|node| node.value}
  end

  def self.valid_move?(pos)
    result = []
    MOVES.each do |move|
      row = move.first + pos.first
      col = move.last + pos.last
      if row.between?(0,7) && col.between?(0,7)
        result << [row,col]
      end
    end #move = [row, col]
    result
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_move?(pos).reject { |el| @visited_positions.include?(el) }
    @visited_positions += moves
    moves
  end

end
# k = KnightPathFinder.new([0,0])

# k.find_path([6,2])
