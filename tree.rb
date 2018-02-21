load 'tree_node.rb'
class Tree
  def initialize
    @node = TreeNode.new('*')
  end

  def add(word)
    word = word.delete('^a-zA-Z')
    letters = word.chars
    branch = @node
    letters.each do |letter|
      branch = branch.children.empty? ? create_sprout(branch, letter) : find_sprout(branch, letter)
    end
    branch.leaf = true
    word
  end

  private

  def create_sprout(branch, letter)
    sprout = TreeNode.new(letter)
    branch.children << sprout
    sprout
  end

  def find_sprout(branch, letter)
    branch.children.each { |node| return node if node.char == letter }
    create_sprout(branch, letter)
  end
end
