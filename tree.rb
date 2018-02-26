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
    @node.children.empty? ? 'Tree is empty' : list_v_1(@node, '', [])
    # @node.children.empty? ? 'Tree is empty' : list_v_2
  end

  def list_v_2(current_node = @node, temp_str = '', words_arr = [])
    temp_str += current_node.char unless current_node == @node
    current_node.children.each do |child|
      words_arr << temp_str + child.char if child.leaf
      words_arr = list_v_2(child, temp_str, words_arr.clone)
    end
    words_arr
  end

  private

  def list_v_1(node, temp_str, tree)
    temp_str += node.char unless node == @node
    tree << temp_str if node.leaf
    node.children.each { |child_node| list_v_1(child_node, temp_str, tree) }
    tree
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
