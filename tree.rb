class Tree
  def initialize
    @node = TreeNode.new('*')
  end

  def add(word)
    word = word.delete('^a-zA-Z')
    return 'Fill line with word, please' if word.empty?
    branch = @node
    word.chars.each { |letter| branch = find_or_create_sprout(branch, letter) }
    branch.leaf = true
  end

  def list
    return 'Tree is empty' if @node.children.empty?
    tree = []
    @node.children.each { |child| tree << find_branches(child, '', tree) }
    tree.reject(&:empty?)
  end

  private

  def find_branches(node, str, tree)
    if node.leaf
      double_l = str + node.char
      tree << double_l
      # for word with double letter, for example 'letter'
      node.children.each { |child_node| find_branches(child_node, double_l, tree) }
    else
      str << node.char
      node.children.each { |child_node| find_branches(child_node, str, tree) }
      str.chop!
    end
  end

  def find_or_create_sprout(branch, letter)
    find_sprout(branch, letter) || create_sprout(branch, letter)
  end

  def find_sprout(branch, letter)
    branch.children.find { |node| node.char == letter }
  end

  def create_sprout(branch, letter)
    sprout = TreeNode.new(letter)
    branch.children << sprout
    sprout
  end
end
