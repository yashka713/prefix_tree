class TreeNode
  attr_accessor :char, :children, :leaf

  def initialize(char)
    @char = char
    @children = []
    @leaf = false
  end
end
