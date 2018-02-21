load 'tree_node.rb'
class Tree
  def initialize
    @node = TreeNode.new('*')
  end

  def add(word)
    word = word.delete('^a-zA-Z')
    letters = word.chars
    branch = @node
    letters.each { |letter| branch = find_or_create_sprout(branch, letter) }
    branch.leaf = true
    word
  end

  private

  def create_sprout(branch, letter)
    sprout = TreeNode.new(letter)
    branch.children << sprout
    sprout
  end

  def find_or_create_sprout(branch, letter)
    branch.children.each { |node| return node if node.char == letter }
    create_sprout(branch, letter)
  end
end
