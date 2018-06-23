require 'byebug'
class PolyTreeNode

  attr_reader :value , :parent , :children

  def initialize(value)
    @value = value
    @parent =nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(node)
    if node.nil?
      @parent=nil
      return
    end
    if @parent.nil?
      @parent = node
      node.children << self
    else
      prev_parent = @parent
      prev_parent.children.delete(self)
      @parent = node
      node.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Error" unless @children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target)

    return self if self.value == target

    @children.each do |child|

       node = child.dfs(target)
       return node if node

    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      queue += current_node.children
    end

    nil
  end

end
