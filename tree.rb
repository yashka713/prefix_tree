require_relative 'tree_node.rb'

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

  def includes?(word)
    branch = @node
    word.delete('^a-zA-Z').chars.all? { |letter| branch = find_sprout(branch, letter) } && branch.leaf
  end

  def list
    @node.children.empty? ? 'Tree is empty' : fill_tree(@node, '', [])
  end

  private

  def find_branches(node, str, tree)
    if node.leaf
      double_l = str + node.char
      tree << double_l
      # for word with double letter, for example 'letter'
      fill_tree(node, double_l, tree)
    else
      str << node.char
      fill_tree(node, str, tree)
      str.chop!
    end
  end

  def fill_tree(node, str, tree)
    node.children.each { |child_node| find_branches(child_node, str, tree) }
    tree.reject(&:empty?)
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
